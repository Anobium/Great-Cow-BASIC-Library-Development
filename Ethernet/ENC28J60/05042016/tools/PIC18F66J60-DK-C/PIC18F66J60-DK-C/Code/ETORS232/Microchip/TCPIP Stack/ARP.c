/*********************************************************************
 *
 *	Address Resolution Protocol (ARP) Client and Server
 *  Module for Microchip TCP/IP Stack
 *	 -Provides IP address to Ethernet MAC address translation
 *	 -Reference: RFC 826
 *
 *********************************************************************
 * FileName:        ARP.c
 * Dependencies:    string.h
 *                  StackTsk.h
 *                  Helpers.h
 *                  ARP.h
 *                  MAC.h
 * Processor:       PIC18, PIC24F, PIC24H, dsPIC30F, dsPIC33F
 * Complier:        Microchip C18 v3.02 or higher
 *					Microchip C30 v2.01 or higher
 * Company:         Microchip Technology, Inc.
 *
 * Software License Agreement
 *
 * Copyright © 2002-2007 Microchip Technology Inc.  All rights 
 * reserved.
 *
 * Microchip licenses to you the right to use, modify, copy, and 
 * distribute: 
 * (i)  the Software when embedded on a Microchip microcontroller or 
 *      digital signal controller product (“Device”) which is 
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
 * THE SOFTWARE AND DOCUMENTATION ARE PROVIDED “AS IS” WITHOUT 
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
 * Author               Date    Comment
 *~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * Nilesh Rajbharti     5/1/01  Original        (Rev 1.0)
 * Nilesh Rajbharti     2/9/02  Cleanup
 * Nilesh Rajbharti     5/22/02 Rev 2.0 (See version.log for detail)
 * Howard Schlunder		8/17/06	Combined ARP.c and ARPTsk.c into ARP.c; 
 *								rewrote some of it to look more linear
 ********************************************************************/
#define __ARP_C

#include "TCPIP Stack/TCPIP.h"

#if !defined(STACK_USE_SLIP)


// ARP Operation codes.
#define ARP_OPERATION_REQ       0x01u
#define ARP_OPERATION_RESP      0x02u

// ETHERNET packet type as defined by IEEE 802.3
#define HW_ETHERNET             (0x0001u)
#define ARP_IP                  (0x0800u)



// This ARP task caches one ARP response.
#ifdef STACK_CLIENT_MODE
static NODE_INFO Cache;
#endif


// ARP packet
typedef struct _ARP_PACKET
{
    WORD        HardwareType;
    WORD        Protocol;
    BYTE        MACAddrLen;
    BYTE        ProtocolLen;
    WORD        Operation;
    MAC_ADDR    SenderMACAddr;
    IP_ADDR     SenderIPAddr;
    MAC_ADDR    TargetMACAddr;
    IP_ADDR     TargetIPAddr;
} ARP_PACKET;

// Helper function
static void SwapARPPacket(ARP_PACKET *p);
static BOOL ARPPut(ARP_PACKET *packet);



/*********************************************************************
 * Function:        BOOL ARPPut(NODE_INFO* more, BYTE opCode)
 *
 * PreCondition:    None
 *
 * Input:           remote  - Remote node info
 *                  opCode  - ARP op code to send
 *
 * Output:          TRUE - The ARP packet was generated properly
 *					FALSE - Unable to allocate a TX buffer
 *
 * Side Effects:    None
 *
 * Overview:        None
 *
 * Note:            None
 ********************************************************************/
static BOOL ARPPut(ARP_PACKET *packet)
{
	while(!MACIsTxReady());
	MACSetWritePtr(BASE_TX_ADDR);
	

    packet->HardwareType  = HW_ETHERNET;
    packet->Protocol      = ARP_IP;
    packet->MACAddrLen    = sizeof(MAC_ADDR);
    packet->ProtocolLen   = sizeof(IP_ADDR);
//    packet->SenderMACAddr = AppConfig.MyMACAddr;	// HI-TECH PICC-18 compiler can't handle this statement, use memcpy() as a workaround
	memcpy(&packet->SenderMACAddr, (void*)&AppConfig.MyMACAddr, sizeof(packet->SenderMACAddr));
    packet->SenderIPAddr  = AppConfig.MyIPAddr;

    SwapARPPacket(packet);

    MACPutHeader(&packet->TargetMACAddr, MAC_ARP, sizeof(*packet));
    MACPutArray((BYTE*)packet, sizeof(*packet));
    MACFlush();
	
	return TRUE;
}



/*********************************************************************
 * Function:        void ARPInit(void)
 *
 * PreCondition:    None
 *
 * Input:           None
 *
 * Output:          ARP Cache is initialized.
 *
 * Side Effects:    None
 *
 * Overview:        None
 *
 * Note:            None
 ********************************************************************/
#ifdef STACK_CLIENT_MODE
void ARPInit(void)
{
    Cache.MACAddr.v[0] = 0xff;
    Cache.MACAddr.v[1] = 0xff;
    Cache.MACAddr.v[2] = 0xff;
    Cache.MACAddr.v[3] = 0xff;
    Cache.MACAddr.v[4] = 0xff;
    Cache.MACAddr.v[5] = 0xff;

	Cache.IPAddr.Val = 0x0;
}
#endif



/*********************************************************************
 * Function:        BOOL ARPProcess(void)
 *
 * PreCondition:    ARP packet is ready in MAC buffer.
 *
 * Input:           None
 *
 * Output:          TRUE: If all processing of this ARP packet is complete.  Do not call ARPProcess() again until a new ARP packet is waiting in the RX buffer.
 *					FALSE: If ARPProcess() must be called more times.  We need more time to sent an ARP response
 *
 * Side Effects:    None
 *
 * Overview:        None
 *
 * Note:            None
 ********************************************************************/
BOOL ARPProcess(void)
{
	ARP_PACKET packet;
	static NODE_INFO Target;
	static enum
	{
	    SM_ARP_IDLE,
	    SM_ARP_REPLY
	} smARP = SM_ARP_IDLE;

    switch(smARP)
    {
	    case SM_ARP_IDLE:
			// Obtain the incoming ARP packet
		    MACGetArray((BYTE*)&packet, sizeof(packet));		
		    MACDiscardRx();
		    SwapARPPacket(&packet);
		
			// Validate the ARP packet
		    if ( packet.HardwareType != HW_ETHERNET     ||
		         packet.MACAddrLen != sizeof(MAC_ADDR)  ||
		         packet.ProtocolLen != sizeof(IP_ADDR) )
		    {
		         return TRUE;
		    }
		
			// Handle incoming ARP responses
#ifdef STACK_CLIENT_MODE
			if(packet.Operation == ARP_OPERATION_RESP)
			{
				Cache.MACAddr = packet.SenderMACAddr;
				Cache.IPAddr = packet.SenderIPAddr;
				return TRUE;
			}
#endif

			// Handle incoming ARP requests for our MAC address
			if(packet.Operation == ARP_OPERATION_REQ)
			{
				if(packet.TargetIPAddr.Val != AppConfig.MyIPAddr.Val)
				{
					return TRUE;
				}
				Target.IPAddr = packet.SenderIPAddr;
				Target.MACAddr = packet.SenderMACAddr;

				smARP = SM_ARP_REPLY;
			}
			// Do not break.  If we get down here, we need to send a reply.	

	    case SM_ARP_REPLY:
	        packet.Operation		= ARP_OPERATION_RESP;
    	    packet.TargetMACAddr	= Target.MACAddr;
    	    packet.TargetIPAddr		= Target.IPAddr;

			// Send an ARP response to a previously received request
			if(!ARPPut(&packet))
			{
	           return FALSE;
			}

			// Begin listening for ARP requests again
			smARP = SM_ARP_IDLE;
	        break;
	}

    return TRUE;
}


/*********************************************************************
 * Function:        void ARPResolve(IP_ADDR* IPAddr)
 *
 * PreCondition:    MACIsTxReady(TRUE) returns TRUE
 *
 * Input:           IPAddr  - IP Address to be resolved.
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        An ARP request is sent.
 *
 * Note:            This function is available only when
 *                  STACK_CLIENT_MODE is defined.
 ********************************************************************/
#ifdef STACK_CLIENT_MODE
void ARPResolve(IP_ADDR *IPAddr)
{
    ARP_PACKET packet;

	packet.Operation            = ARP_OPERATION_REQ;
	packet.TargetMACAddr.v[0]   = 0xff;
	packet.TargetMACAddr.v[1]   = 0xff;
	packet.TargetMACAddr.v[2]   = 0xff;
	packet.TargetMACAddr.v[3]   = 0xff;
	packet.TargetMACAddr.v[4]   = 0xff;
	packet.TargetMACAddr.v[5]   = 0xff;


    // ARP query either the IP address directly (on our subnet), or do an ARP query for our Gateway if off of our subnet
	packet.TargetIPAddr			= ((AppConfig.MyIPAddr.Val ^ IPAddr->Val) & AppConfig.MyMask.Val) ? AppConfig.MyGateway : *IPAddr;

    ARPPut(&packet);
}
#endif



/*********************************************************************
 * Function:        BOOL ARPIsResolved(IP_ADDR* IPAddr,
 *                                      MAC_ADDR *MACAddr)
 *
 * PreCondition:    None
 *
 * Input:           IPAddr      - IPAddress to be resolved.
 *                  MACAddr     - Buffer to hold corresponding
 *                                MAC Address.
 *
 * Output:          TRUE if given IP Address has been resolved.
 *                  FALSE otherwise.
 *
 * Side Effects:    None
 *
 * Overview:        None
 *
 * Note:            This function is available only when
 *                  STACK_CLIENT_MODE is defined.
 ********************************************************************/
#ifdef STACK_CLIENT_MODE
BOOL ARPIsResolved(IP_ADDR *IPAddr, MAC_ADDR *MACAddr)
{
    if((Cache.IPAddr.Val == IPAddr->Val) || ((Cache.IPAddr.Val == AppConfig.MyGateway.Val) && Cache.IPAddr.Val))
    {
        *MACAddr = Cache.MACAddr;
        return TRUE;
    }
    return FALSE;
}
#endif



/*********************************************************************
 * Function:        static void SwapARPPacket(ARP_PACKET* p)
 *
 * PreCondition:    None
 *
 * Input:           p   - ARP packet to be swapped.
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        None
 *
 * Note:            None
 ********************************************************************/
static void SwapARPPacket(ARP_PACKET *p)
{
    p->HardwareType     = swaps(p->HardwareType);
    p->Protocol         = swaps(p->Protocol);
    p->Operation        = swaps(p->Operation);
}

#endif	//#if !defined(STACK_USE_SLIP)
