/*********************************************************************
 *
 *  Berekely TCP server demo application.
 *  This application uses the BSD socket APIs and starts a server 
 *  listening on TCP port 9764.  All data sent to a connection on 
 *  this port will be echoed back to the sender.  By default, this 
 *  demo supports 3 simultaneous connections.
 *
 *********************************************************************
 * FileName:        BerkeleyTCPServerDemo.c
 * Company:         Microchip Technology, Inc.
 * Processor:       PIC18, PIC24F, PIC24H, dsPIC30F, dsPIC33F, PIC32
 * Compiler:        Microchip C32 v1.05 or higher
 *					Microchip C30 v3.12 or higher
 *					Microchip C18 v3.30 or higher
 *					HI-TECH PICC-18 PRO 9.63PL2 or higher
 * Company:         Microchip Technology, Inc.
 *
 * Software License Agreement
 *
 * Copyright (C) 2002-2009 Microchip Technology Inc.  All rights
 * reserved.
 *
 * Microchip licenses to you the right to use, modify, copy, and
 * distribute:
 * (i)  the Software when embedded on a Microchip microcontroller or
 *      digital signal controller product ("Device") which is
 *      integrated into Licensee's product; or
 * (ii) ONLY the Software driver source files ENC28J60.c, ENC28J60.h,
 *		ENCX24J600.c and ENCX24J600.h ported to a non-Microchip device
 *		used in conjunction with a Microchip ethernet controller for
 *		the sole purpose of interfacing with the ethernet controller.
 *
 * You should refer to the license agreement accompanying this
 * Software for additional information regarding your rights and
 * obligations.
 *
 * THE SOFTWARE AND DOCUMENTATION ARE PROVIDED "AS IS" WITHOUT
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
 * Author               Date    	Comment
 *~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * Aseem Swalah         4/21/08  	Original
 ********************************************************************/
 
#include "TCPIPConfig.h" 

#if defined(STACK_USE_BERKELEY_API)

#include "TCPIP Stack/TCPIP.h"


#define PORTNUM 9764
#define MAX_CLIENT (3) // Maximum number of simultanous connections accepted by the server.


/*********************************************************************
 * Function:        void BerkeleyTCPServerDemo(void)
 *
 * PreCondition:    Stack is initialized
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
void BerkeleyTCPServerDemo(void)
{
    static SOCKET   bsdServerSocket = INVALID_SOCKET;   
    static SOCKET  ClientSock[MAX_CLIENT] ={INVALID_SOCKET, INVALID_SOCKET, INVALID_SOCKET};
    static struct sockaddr_in addr;
    struct sockaddr_in addRemote;
    char  bfr[15];
    int length;
    int i;
    int addrlen = sizeof(struct sockaddr_in);
    static int sockcount = 0;
    static enum _BSDServerState
    {
        BSD_START = 0,
        BSD_BIND,
        BSD_LISTENING,
        BSD_ACCEPT,
        BSD_OPERATION,
    } BSDServerState = BSD_START;

    switch(BSDServerState)
    {
        case BSD_START:
            // Create a socket for this server to listen and accept connections on
            if((bsdServerSocket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)) == INVALID_SOCKET)
                return;
            
            BSDServerState = BSD_BIND;
            break;

        case BSD_BIND:
            //bind to a local port
            addr.sin_port = PORTNUM;
            addr.sin_addr.S_un.S_addr = IP_ADDR_ANY;
            if( bind( bsdServerSocket, (struct sockaddr*)&addr, addrlen ) == SOCKET_ERROR )
                return;
            
            BSDServerState = BSD_LISTENING;
            break;
         
      case BSD_LISTENING:
            if(listen( bsdServerSocket, MAX_CLIENT) == SOCKET_ERROR)
                return;
            BSDServerState = BSD_ACCEPT;
            break;
         
      case BSD_ACCEPT:
            for(i=0; i<MAX_CLIENT; i++)
            {
                if(ClientSock[i] == INVALID_SOCKET)
                {
                    if((ClientSock[i] = accept(bsdServerSocket, (struct sockaddr*)&addRemote, &addrlen)) != INVALID_SOCKET)
                    {
                        sockcount++;
                    }
                }
            }

            if(sockcount >= MAX_CLIENT) // will not accept further client connection request.
            {
                BSDServerState = BSD_OPERATION;
                closesocket(bsdServerSocket); // close the listen server socket.
            }
            // no break it falls through for the successfully accepted connection.
         
        case BSD_OPERATION:
            //receive and send back the data
            for(i=0; i<MAX_CLIENT; i++)
            {
                if(ClientSock[i] != INVALID_SOCKET)
                {
                    length = recv( ClientSock[i], bfr, sizeof(bfr), 0);
             
                    if( length > 0 )
                    {
                        bfr[length] = '\0';
                        send(ClientSock[i], bfr, strlen(bfr), 0);
                    }
                    else if( length < 0 )
                    {
                        closesocket( ClientSock[i] );
                        sockcount--;
                        ClientSock[i] = INVALID_SOCKET;
                        BSDServerState = BSD_ACCEPT;
                    }
                 }
            }
            break;
         
        default:
            return;
    }
    return;
}

#endif //#if defined(STACK_USE_BERKELEY_API)

