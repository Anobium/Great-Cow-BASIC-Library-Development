/*********************************************************************
 *
 *	TCP Performance Test
 *  Module for Microchip TCP/IP Stack
 *	 -Establishes a connection and then sends out dummy packets 
 *	  from ROM memory
 *	 -Reference: None.  This is for testing only.
 *
 *********************************************************************
 * FileName:        TCPPerformanceTest.c
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
#define __TCPPERFORMANCETEST_C

#include "TCPIP Stack/TCPIP.h"
#if defined(STACK_USE_TCP_PERFORMANCE_TEST)

#define PERFORMANCE_PORT	12345


/*********************************************************************
 * Function:        void TCPPerformanceTask(void)
 *
 * PreCondition:    Stack is initialized()
 *
 * Input:           None
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        Opens a TCP socket, listens for a connection, and 
 *					then transmits some big data
 *
 * Note:            None
 ********************************************************************/
void TCPPerformanceTask(void)
{
	static TCP_SOCKET MySocket = INVALID_SOCKET;
	static DWORD_VAL dwVLine;
	BYTE buffer[12];
	WORD w;
	
	// Start the TCP server, listening on PERFORMANCE_PORT
	if(MySocket == INVALID_SOCKET)
	{
		MySocket = TCPListen(PERFORMANCE_PORT);
	
		// Abort operation if no UDP sockets are available
		// If this ever happens, incrementing MAX_UDP_SOCKETS in 
		// StackTsk.h may help (at the expense of more global memory 
		// resources).
		if(MySocket == INVALID_SOCKET)
			return;
		
		dwVLine.Val = 0;
	}
	
	// See how many bytes we can write to the TX FIFO
	w = TCPIsPutReady(MySocket);

	// Constant data in RAM
	buffer[0] = '0';
	buffer[1] = 'x';
	buffer[10] = ':';
	buffer[11] = ' ';

	// Transmit as much data as the TX FIFO will allow
	while(w >= 62u)
	{
		// Convert line counter to ASCII hex string
		buffer[2] = btohexa_high(dwVLine.v[3]);
		buffer[3] = btohexa_low(dwVLine.v[3]);
		buffer[4] = btohexa_high(dwVLine.v[2]);
		buffer[5] = btohexa_low(dwVLine.v[2]);
		buffer[6] = btohexa_high(dwVLine.v[1]);
		buffer[7] = btohexa_low(dwVLine.v[1]);
		buffer[8] = btohexa_high(dwVLine.v[0]);
		buffer[9] = btohexa_low(dwVLine.v[0]);

		// Place all data in the TCP TX FIFO
		TCPPutArray(MySocket, buffer, sizeof(buffer));
		TCPPutROMArray(MySocket, (ROM BYTE*)"The fox smoked crack and died. This is 62 bytes.\r\n", 50);

		dwVLine.Val++;
		w -= 62;
	}

	// Send everything immediately
	TCPFlush(MySocket);
}

#endif //#if defined(STACK_USE_TCP_PERFORMANCE_TEST)
