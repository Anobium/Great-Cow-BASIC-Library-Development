/*********************************************************************
 *
 *	Generic TCP Server Example Application
 *  Module for Microchip TCP/IP Stack
 *   -Implements an example "ToUpper" TCP server on port 9760 and 
 *	  should be used as a basis for creating new TCP server 
 *    applications
 *	 -Reference: None.  Hopefully AN833 in the future.
 *
 *********************************************************************
 * FileName:        GenericTCPServer.c
 * Dependencies:    TCP.h
 * Processor:       PIC18, PIC24F, PIC24H, dsPIC30, dsPIC33F
 * Complier:        Microchip C18 v3.03 or higher
 * 					Microchip C30 v2.01 or higher
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
 * Howard Schlunder     10/19/06	Original
 ********************************************************************/
#define __GENERICTCPSERVER_C

#include "TCPIP Stack/TCPIP.h"

#if defined(STACK_USE_GENERIC_TCP_SERVER_EXAMPLE)


#define SERVER_PORT	9760


/*********************************************************************
 * Function:        void GenericTCPServer(void)
 *
 * PreCondition:    Stack is initialized()
 *
 * Input:           None
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        None
 *
 * Note:            None
 ********************************************************************/
void GenericTCPServer(void)
{
	BYTE c;
	static TCP_SOCKET	MySocket;
	static enum _TCPServerState
	{
		SM_HOME = 0,
		SM_LISTENING,
	} TCPServerState = SM_HOME;
	static BYTE	AppTXBuffer[33];
	static BYTE *AppTXStart = AppTXBuffer;
	static BYTE *AppTXEnd = AppTXBuffer;

	switch(TCPServerState)
	{
		case SM_HOME:
			// Allocate a socket for this server to listen and accept connections on
			MySocket = TCPListen(SERVER_PORT);
			if(MySocket == INVALID_SOCKET)
			{
#ifdef USE_LCD
				strcpypgm2ram((char*)LCDText, "Error: Increase MAX_TCP_SOCKETS");
				LCDUpdate();
#endif
				return;
			}

			TCPServerState++;
			break;

		case SM_LISTENING:
			// See if anyone is connected to us
			if(!TCPIsConnected(MySocket))
			{
				// Zero out the App TX buffer and do nothing
				AppTXEnd = AppTXStart;
				return;
			}

			// Receive any bytes that have been sent to us.
			if(TCPIsGetReady(MySocket))
			{
				// Need to use LED7, disable BUTTON2 functionality on Explorer 16
				LED7_TRIS = 0;
	
				while(TCPGet(MySocket, &c))
				{
					// Convert the character to uppercase and transmit it back 
					// to the sender
					if(c >= 'a' && c <= 'z')
						c -= ('a' - 'A');

					*AppTXEnd++ = c;
					if(AppTXEnd > AppTXBuffer + sizeof(AppTXBuffer))
						AppTXEnd = AppTXBuffer;
				}
	
				// Restore BUTTON2 functionality on Explorer 16
				LED7_TRIS = 1;
			}

			// Transmit any bytes that are waiting to be sent.
			c = 0x00;
			while(TCPIsPutReady(MySocket) && (AppTXStart != AppTXEnd))
			{
				c = 0xFF;
				TCPPut(MySocket, *AppTXStart++);
				if(AppTXStart > AppTXBuffer + sizeof(AppTXBuffer))
					AppTXStart = AppTXBuffer;
			}
			// Flush the packet if we placed anything in the transmit buffer
			if(c)
				TCPFlush(MySocket);


			break;
	}
}

#endif //#if defined(STACK_USE_GENERIC_TCP_SERVER_EXAMPLE)
