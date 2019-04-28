/*********************************************************************
 *
 *	TCP/IP Stack Manager
 *  Module for Microchip TCP/IP Stack
 *	 -Handles internal RX packet pre-processing prior to dispatching 
 *    to upper application layers.
 *	 -Reference: AN833
 *
 *********************************************************************
 * FileName:        StackTsk.c
 * Dependencies:    StackTsk.H
 *                  ARP.h
 *                  MAC.h
 *                  IP.h
 *                  ICMP.h
 *                  Tcp.h
 *                  http.h
 * Processor:       PIC18, PIC24F, PIC24H, dsPIC30F, dsPIC33F
 * Complier:        Microchip C18 v3.02 or higher
 *					Microchip C30 v2.01 or higher
 * Company:         Microchip Technology, Inc.
 *
 * Software License Agreement
 *
 * Copyright ?2002-2007 Microchip Technology Inc.  All rights 
 * reserved.
 *
 * Microchip licenses to you the right to use, modify, copy, and 
 * distribute: 
 * (i)  the Software when embedded on a Microchip microcontroller or 
 *      digital signal controller product (“Device? which is 
 *      integrated into Licensee’s product; or
 * (ii) ONLY the Software driver source files ENC28J60.c and 
 *      ENC28J60.h ported to a non-Microchip device used in 
 *      conjunction with a Microchip ethernet controller for the 
 *      sole purpose of interfacing with the ethernet controller. 
 *
 * You should refer to the license agreement accompanying this 
 * Software for additional information regarding your rights and 
 * obligations.
 *
 * THE SOFTWARE AND DOCUMENTATION ARE PROVIDED “AS IS?WITHOUT 
 * WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING WITHOUT 
 * LIMITATION, ANY WARRANTY OF MERCHANTABILITY, FITNESS FOR A 
 * PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT SHALL 
 * MICROCHIP BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR 
 * CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA, COST OF 
 * PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS 
 * BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE 
 * THEREOF), ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER 
 * SIMILAR COSTS, WHETHER ASSERTED ON THE BASIS OF CONTRACT, TORT 
 * (INCLUDING NEGLIGENCE), BREACH OF WARRANTY, OR OTHERWISE.
 *
 *
 * Author               Date        Comment
 *~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * Nilesh Rajbharti     8/14/01     Original (Rev. 1.0)
 * Nilesh Rajbharti     2/9/02      Cleanup
 * Nilesh Rajbharti     5/22/02     Rev 2.0 (See version.log for detail)
 * Nilesh Rajbharti     12/5/02     Modified UDPProcess() and TCPProcess()
 *                                  to include localIP as third param.
 *                                  This was done to allow these functions
 *                                  to calculate checksum correctly.
 * Nilesh Rajbharti     7/26/04     Added code in StackTask() to not
 *                                  clear statically IP address if link is
 *                                  removed and DHCP module is disabled
 *                                  at runtime.
 * Howard Schlunder		03/16/07	Rewrote stack manager to be linear
********************************************************************/
#define __STACKTSK_C

#include "TCPIP Stack/TCPIP.h"

// myDHCPBindCount defined in MainDemo.c;  Used to force an IP 
// address display update for IP Gleaning
extern BYTE myDHCPBindCount;


// Stack FSM states.
typedef enum _SM_STACK
{
    SM_STACK_IDLE,
    SM_STACK_MAC,
    SM_STACK_IP,
    SM_STACK_ARP,
    SM_STACK_TCP,
    SM_STACK_UDP
} SM_STACK;
static SM_STACK smStack;

NODE_INFO remoteNode;



/*********************************************************************
 * Function:        void StackInit(void)
 *
 * PreCondition:    None
 *
 * Input:           None
 *
 * Output:          Stack and its componets are initialized
 *
 * Side Effects:    None
 *
 * Note:            This function must be called before any of the
 *                  stack or its component routines are used.
 *
 ********************************************************************/
void StackInit(void)
{
    smStack                     = SM_STACK_IDLE;

#if defined(STACK_USE_IP_GLEANING) || defined(STACK_USE_DHCP_CLIENT)
    /*
     * If DHCP or IP Gleaning is enabled,
     * startup in Config Mode.
     */
    AppConfig.Flags.bInConfigMode = TRUE;

#endif

    MACInit();

    ARPInit();

#if defined(STACK_USE_UDP)
    UDPInit();
#endif

#if defined(STACK_USE_TCP)
    TCPInit();
#endif

}


/*********************************************************************
 * Function:        void StackTask(void)
 *
 * PreCondition:    StackInit() is already called.
 *
 * Input:           None
 *
 * Output:          Stack FSM is executed.
 *
 * Side Effects:    None
 *
 * Note:            This FSM checks for new incoming packets,
 *                  and routes it to appropriate stack components.
 *                  It also performs timed operations.
 *
 *                  This function must be called periodically to
 *                  ensure timely responses.
 *
 ********************************************************************/
void StackTask(void)
{
    WORD dataCount;
    IP_ADDR tempLocalIP;
	BYTE cFrameType;
	BYTE cIPFrameType;


	#if defined(STACK_USE_DHCP_CLIENT)
	// Normally, an application would not include  DHCP module
	// if it is not enabled. But in case some one wants to disable
	// DHCP module at run-time, remember to not clear our IP
	// address if link is removed.
	if(AppConfig.Flags.bIsDHCPEnabled)
	{
		if(!MACIsLinked())
		{
//			AppConfig.MyIPAddr.Val = AppConfig.DefaultIPAddr.Val;
//			AppConfig.MyMask.Val = AppConfig.DefaultMask.Val;
			DHCPFlags.bits.bDHCPServerDetected = FALSE;
			AppConfig.Flags.bInConfigMode = TRUE;
			DHCPReset();
		}
	
		// DHCP must be called all the time even after IP configuration is
		// discovered.
		// DHCP has to account lease expiration time and renew the configuration
		// time.
		DHCPTask();
		
		if(DHCPIsBound())
			AppConfig.Flags.bInConfigMode = FALSE;
	}
	#endif

	#if defined(STACK_USE_TCP)
	// Perform all TCP time related tasks (retransmit, send acknowledge, close connection, etc)
	TCPTick();
	#endif


	// Process as many incomming packets as we can
	while(MACGetHeader(&remoteNode.MACAddr, &cFrameType))
	{
		switch(cFrameType)
		{
			case MAC_ARP:
				ARPProcess();
				break;
	
			case MAC_IP:
				if(!IPGetHeader(&tempLocalIP, &remoteNode, &cIPFrameType, &dataCount))
					break;

				#if defined(STACK_USE_ICMP_SERVER) || defined(STACK_USE_ICMP_CLIENT)
				if(cIPFrameType == IP_PROT_ICMP)
				{
					ICMPProcess(&remoteNode, dataCount);
					
					#if defined(STACK_USE_IP_GLEANING)
					if(AppConfig.Flags.bInConfigMode && AppConfig.Flags.bIsDHCPEnabled)
					{
						// Accoriding to "IP Gleaning" procedure,
						// when we receive an ICMP packet with a valid
						// IP address while we are still in configuration
						// mode, accept that address as ours and conclude
						// configuration mode.
						if(tempLocalIP.Val != 0xffffffff)
						{
							AppConfig.Flags.bInConfigMode = FALSE;
							AppConfig.MyIPAddr = tempLocalIP;
							myDHCPBindCount--;
						}
					}
					#endif
					break;
				}
				#endif
				
				#if defined(STACK_USE_TCP)
				if(cIPFrameType == IP_PROT_TCP)
				{
					TCPProcess(&remoteNode, &tempLocalIP, dataCount);
					break;
				}
				#endif
				
				#if defined(STACK_USE_UDP)
				if(cIPFrameType == IP_PROT_UDP)
				{
					UDPProcess(&remoteNode, &tempLocalIP, dataCount);
					break;
				}
				#endif

				break;
		}
	}
}

