/*********************************************************************
 *
 *	UDP Performance Test
 *  Module for Microchip TCP/IP Stack
 *	 -Sends out dummy packets from ROM memory
 *	 -Reference: None.  This is for testing only.
 *
 *********************************************************************
 * FileName:        UDPPerformanceTest.c
 * Dependencies:    TCPIP.h
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
 * Author               Date    	Comment
 *~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * Howard Schlunder     01/29/07	Original
 ********************************************************************/
#define __UDPPERFORMANCETEST_C

#include "TCPIP Stack/TCPIP.h"
#if defined(STACK_USE_UDP_PERFORMANCE_TEST)

#define PERFORMANCE_PORT	12345


/*********************************************************************
 * Function:        void UDPPerformanceTask(void)
 *
 * PreCondition:    Stack is initialized()
 *
 * Input:           None
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        Opens a UDP socket, transmits a big packet, closes UDP scoket
 *
 * Note:            None
 ********************************************************************/
void UDPPerformanceTask(void)
{
	UDP_SOCKET	MySocket;
	NODE_INFO	Remote;
	WORD		wTemp;
	
	// Set the socket's destination to be a broadcast over our IP 
	// subnet
	// Set the MAC destination to be a broadcast
	memset(&Remote, 0xFF, sizeof(Remote));
	
	// Open a UDP socket for outbound transmission
	MySocket = UDPOpen(0, &Remote, PERFORMANCE_PORT);
	
	// Abort operation if no UDP sockets are available
	// If this ever happens, incrementing MAX_UDP_SOCKETS in 
	// StackTsk.h may help (at the expense of more global memory 
	// resources).
	if(MySocket == INVALID_UDP_SOCKET)
		return;
	
	// Make certain the socket can be written to
	if(!UDPIsPutReady(MySocket))
	{
		UDPClose(MySocket);
		return;
	}
	
	wTemp = UDPPutROMArray((ROM BYTE*)
			"The quick brown fox tried to jump over the yellow dog.  Unfortunately, the yellow dog stood up while the fox was in mid-jump.  As a result, the two collided.  Then, the dog, being the omnivore that it is, ate the quick brown fox.  This line is 256 bytes.\r\n"
			"The quick brown fox tried to jump over the yellow dog.  Unfortunately, the yellow dog stood up while the fox was in mid-jump.  As a result, the two collided.  Then, the dog, being the omnivore that it is, ate the quick brown fox.  This line is 256 bytes.\r\n"
			"The quick brown fox tried to jump over the yellow dog.  Unfortunately, the yellow dog stood up while the fox was in mid-jump.  As a result, the two collided.  Then, the dog, being the omnivore that it is, ate the quick brown fox.  This line is 256 bytes.\r\n"
			"The quick brown fox tried to jump over the yellow dog.  Unfortunately, the yellow dog stood up while the fox was in mid-jump.  As a result, the two collided.  Then, the dog, being the omnivore that it is, ate the quick brown fox.  This line is 256 bytes.\r\n", 1024);

	// Send the packet
	UDPFlush();
	
	// Close the socket so it can be used by other modules
	UDPClose(MySocket);
}

#endif //#if defined(STACK_USE_UDP_PERFORMANCE_TEST)
