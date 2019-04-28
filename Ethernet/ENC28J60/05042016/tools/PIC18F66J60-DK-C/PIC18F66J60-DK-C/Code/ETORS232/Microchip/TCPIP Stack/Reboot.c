/*********************************************************************
 *
 *	Reboot Module
 *  Module for Microchip TCP/IP Stack
 *	 -Remotely resets the PIC
 *	 -Reference: None yet.  Hopefully AN833 in the future.
 *
 *********************************************************************
 * FileName:        Reboot.c
 * Dependencies:    TCPIP.h
 * Processor:       PIC18, PIC24F, PIC24H, dsPIC30F, dsPIC33F
 * Complier:        Microchip C18 v3.10 or higher
 *					Microchip C30 v2.04 or higher
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
 * Author               Date    	Comment
 *~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * Howard Schlunder     02/22/07	Original
 ********************************************************************/
#define __REBOOT_C

#include "TCPIP Stack/TCPIP.h"
#if defined(STACK_USE_REBOOT_SERVER)

#define REBOOT_PORT		30304	//UDP


/*********************************************************************
 * Function:        void RebootTask(void)
 *
 * PreCondition:    Stack is initialized()
 *
 * Input:           None
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        Checks for incomming traffic on port 30304.  
 *					Resets the PIC if a 'R' is received.
 *
 * Note:            This module is primarily for use with the 
 *					Ethernet bootloader.  By resetting, the Ethernet 
 *					bootloader can take control for a second and let
 *					a firmware upgrade take place.
 ********************************************************************/
void RebootTask(void)
{
	static UDP_SOCKET	MySocket = INVALID_UDP_SOCKET;
	BYTE 				i;
	
	if(MySocket == INVALID_UDP_SOCKET)
		MySocket = UDPOpen(REBOOT_PORT, NULL, INVALID_UDP_PORT);

	if(MySocket == INVALID_UDP_SOCKET)
		return;

	// Do nothing if no data is waiting
	if(!UDPIsGetReady(MySocket))
		return;
	
	// See if this is a valid packet specifing that we should reboot
	UDPGet(&i);
	if(i != 0x00)
		return;

	Reset();
}

#endif //#if defined(STACK_USE_REBOOT_SERVER)
