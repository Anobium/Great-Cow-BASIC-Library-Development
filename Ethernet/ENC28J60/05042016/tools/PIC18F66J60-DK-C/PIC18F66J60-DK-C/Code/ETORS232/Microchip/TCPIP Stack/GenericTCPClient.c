/*********************************************************************
 *
 *  Generic TCP Client Example Application
 *  Module for Microchip TCP/IP Stack
 *   -Implements an example HTTP client and should be used as a basis 
 *	  for creating new TCP client applications
 *	 -Reference: None.  Hopefully AN833 in the future.
 *
 *********************************************************************
 * FileName:        GenericTCPClient.c
 * Dependencies:    TCP.h, DNS.h
 * Processor:       PIC18, PIC24F, PIC24H, dsPIC30, dsPIC33F
 * Complier:        Microchip C18 v3.03 or higher
 * 					Microchip C30 v2.02 or higher
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
 * Howard Schlunder     8/01/06	Original
 ********************************************************************/
#define __GENERICTCPCLIENT_C

#include "TCPIP Stack/TCPIP.h"

#if defined(STACK_USE_GENERIC_TCP_CLIENT_EXAMPLE)


//TODO: Define proper server address here
BYTE ServerName[] =	"www.google.com";
WORD ServerPort = 80;

// This is specific to this HTTP Client example
ROM BYTE RemoteURL[] = "/search?as_q=Microchip&as_sitesearch=microchip.com";


/*********************************************************************
 * Function:        void GenericTCPClient(void)
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
void GenericTCPClient(void)
{
	BYTE 				i;
	BYTE 				*StringPtr;
	static TICK			Timer;
	static TCP_SOCKET	MySocket = INVALID_SOCKET;
	static NODE_INFO	Server;
	static enum _GenericTCPExampleState
	{
		SM_HOME = 0,
		SM_NAME_RESOLVE,
		SM_ARP_START_RESOLVE,
		SM_ARP_RESOLVE,
		SM_SOCKET_OBTAIN,
		SM_SOCKET_OBTAINED,
		SM_PROCESS_RESPONSE,
		SM_DISCONNECT,
		SM_DONE
	} GenericTCPExampleState = SM_DONE;

	switch(GenericTCPExampleState)
	{
		case SM_HOME:
			// Obtain ownership of the DNS resolution module
			if(!DNSBeginUsage())
				break;

			// Obtain the IP address associated with the common ServerName
			DNSResolve(ServerName, DNS_TYPE_A);
			GenericTCPExampleState++;
			break;

		case SM_NAME_RESOLVE:
			// Wait for the DNS server to return the requested IP address
			if(!DNSIsResolved(&Server.IPAddr))
				break;

			// Release the DNS module, we no longer need it
			if(!DNSEndUsage())
			{
				// An invalid IP address was returned from the DNS 
				// server.  Quit and fail permanantly if host is not valid.
				GenericTCPExampleState = SM_DONE;
				break;
			}

			GenericTCPExampleState++;

		case SM_ARP_START_RESOLVE:
			// Obtain the MAC address associated with the server's IP address (either direct MAC address on same subnet, or the MAC address of the Gateway machine)
			ARPResolve(&Server.IPAddr);
			Timer = TickGet();
			GenericTCPExampleState++;
			break;

		case SM_ARP_RESOLVE:
			// Wait for the MAC address to finish being obtained
			if(!ARPIsResolved(&Server.IPAddr, &Server.MACAddr))
			{
				// Time out if too much time is spent in this state
				if(TickGet()-Timer > 1*TICK_SECOND)
				{
					// Retransmit ARP request
					GenericTCPExampleState--;
				}
				break;
			}
			GenericTCPExampleState++;

		case SM_SOCKET_OBTAIN:
			// Connect a socket to the remote TCP server
			MySocket = TCPConnect(&Server, ServerPort);
			
			// Abort operation if no TCP sockets are available
			// If this ever happens, incrementing MAX_TCP_SOCKETS in 
			// StackTsk.h may help (at the expense of more global memory 
			// resources).
			if(MySocket == INVALID_SOCKET)
				break;

			GenericTCPExampleState++;
			Timer = TickGet();
			break;

		case SM_SOCKET_OBTAINED:
			// Wait for the remote server to accept our connection request
			if(!TCPIsConnected(MySocket))
			{
				// Time out if too much time is spent in this state
				if(TickGet()-Timer > 5*TICK_SECOND)
				{
					// Close the socket so it can be used by other modules
					TCPDisconnect(MySocket);
					MySocket = INVALID_SOCKET;
					GenericTCPExampleState--;
				}
				break;
			}

			Timer = TickGet();

			// Make certain the socket can be written to
			if(!TCPIsPutReady(MySocket))
				break;
			
			// Place the application protocol data into the transmit buffer.  For this example, we are connected to an HTTP server, so we'll send an HTTP GET request.
			TCPPutROMString(MySocket, (ROM BYTE*)"GET ");
			TCPPutROMString(MySocket, RemoteURL);
			TCPPutROMString(MySocket, (ROM BYTE*)" HTTP/1.1\r\nHost: ");
			TCPPutString(MySocket, ServerName);
			TCPPutROMString(MySocket, (ROM BYTE*)"\r\n\r\n");

			// Send the packet
			TCPFlush(MySocket);
			GenericTCPExampleState++;

		case SM_PROCESS_RESPONSE:
			// Check to see if the remote node has disconnected from us or sent us any application data
			// If application data is available, write it to the UART
			if(!TCPIsConnected(MySocket))
			{
				GenericTCPExampleState++;
			}
	
			if(!TCPIsGetReady(MySocket))
				break;
	
			// Obtain the server reply
			while(TCPGet(MySocket, &i))
			{
				while(BusyUART());
				WriteUART(i);
			}
	
			break;
	
		case SM_DISCONNECT:
			// Close the socket so it can be used by other modules
			// For this application, we wish to stay connected, but this state will still get entered if the remote server decides to disconnect
			TCPDisconnect(MySocket);
			MySocket = INVALID_SOCKET;
			GenericTCPExampleState = SM_DONE;
			break;
	
		case SM_DONE:
			// Do nothing unless the user pushes BUTTON1 and wants to restart the whole connection/download process
			if(BUTTON1_IO == 0u)
				GenericTCPExampleState = SM_HOME;
			break;
	}
}

#endif	//#if defined(STACK_USE_GENERIC_TCP_CLIENT_EXAMPLE)
