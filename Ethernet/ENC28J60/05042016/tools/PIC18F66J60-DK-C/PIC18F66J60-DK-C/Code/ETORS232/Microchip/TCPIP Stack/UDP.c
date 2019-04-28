/*********************************************************************
 *
 *	User Datagram Protocol (UDP) Communications Layer
 *  Module for Microchip TCP/IP Stack
 *	 -Provides unreliable, minimum latency transport of application 
 *    datagram (packet) oriented data
 *	 -Reference: RFC 768
 *
 *********************************************************************
 * FileName:        UDP.c
 * Dependencies:    StackTsk.h
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
 * Nilesh Rajbharti     3/19/01  Original        (Rev 1.0)
 * Nilesh Rajbharti     2/26/03  Fixed UDPGet and UDPProcess bugs
 *                               as discovered and fixed by John Owen
 *                               of Powerwave.
 *                               1. UDPGet would return FALSE on last good byte
 *                               2. UDPProcess was incorrectly calculating length.
 * Nilesh Rajbharti     5/19/03  Added bFirstRead flag similar to TCP
 *                               to detect very first UDPGet and
 *                               reset MAC Rx pointer to begining of
 *                               UDP data area.  This would ensure that
 *                               if UDP socket has pending Rx data and
 *                               another module resets MAC Rx pointer,
 *                               next UDP socket Get would get correct
 *                               data.
 * Robert Sloan (RSS)    5/29/03 Improved FindMatchingSocket()
 * Nilesh Rajbharti     12/2/03  Added UDPChecksum logic in UDPProcess()
 * Nilesh Rajbharti     12/5/03  Modified UDPProcess() and FindMatchingSocket()
 *                               to include localIP as new parameter.
 *                               This corrects pseudo header checksum
 *                               logic in UDPProcess().
 *                               It also corrects broadcast packet
 *                               matching correct in FindMatchingSocket().
 * Howard Schlunder		1/16/06	 Fixed an imporbable RX checksum bug 
 *								 when using a Microchip Ethernet controller)
 * Howard Schlunder		6/02/06	 Fixed a bug where all RXed UDP packets 
 *								 without a checksum (0x0000) were thrown
 *								 away.  No checksum is legal in UDP.
 * Howard Schlunder		8/10/06	 Fixed a bug where UDP sockets would 
 *								 unintentionally keep the remote MAC 
 *								 address cached, even after calling 
 *								 UDPInit(), UDPClose(), or reseting 
 *								 the part without clearing all the 
 *								 PICmicro memory.
 ********************************************************************/
#define __UDP_C

#include "TCPIP Stack/TCPIP.h"

#if defined(STACK_USE_UDP)

#define LOCAL_UDP_PORT_START_NUMBER (50000u)
#define LOCAL_UDP_PORT_END_NUMBER   (51999u)


UDP_SOCKET_INFO		UDPSocketInfo[MAX_UDP_SOCKETS];
UDP_SOCKET			activeUDPSocket;
static UDP_SOCKET	LastPutSocket = INVALID_UDP_SOCKET;

static UDP_SOCKET FindMatchingSocket(UDP_HEADER *h, NODE_INFO *remoteNode,
                                    IP_ADDR *localIP);

/*********************************************************************
 * Function:        void UDPInit(void)
 *
 * PreCondition:    None
 *
 * Input:           None
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        Initializes internal variables.
 *
 * Note:
 ********************************************************************/
void UDPInit(void)
{
    UDP_SOCKET s;

    for ( s = 0; s < MAX_UDP_SOCKETS; s++ )
    {
		UDPClose(s);
    }
}

/*********************************************************************
 * Function:        UDP_SOCKET UDPOpen(UDP_PORT localPort,
 *                                     NODE_INFO *remoteNode,
 *                                     UDP_PORT remotePort)
 *
 * PreCondition:    UDPInit() is already called
 *
 * Input:           remoteNode - Remote Node info such as MAC and IP
 *                               address
 *                               If NULL, broadcast node address is set.
 *                  remotePort - Remote Port to which to talk to
 *                               If INVALID_UDP_SOCKET, localPort is
 *                               opened for Listen.
 *                  localPort  - A valid port number or 0x0000 if 
 *								 dynamic assignment is desired.
 *
 * Output:          On success: A UDP socket handle that can be used 
 *					for subsequent UDP API calls.
 *					On failure: INVALID_UDP_SOCKET
 *
 * Side Effects:    None
 *
 * Overview:        A UDP socket is allocated and parameters are stored.
 *
 * Note:            If the localPort is not specified, a unique port 
 *					number is automatically assigned.
 ********************************************************************/
UDP_SOCKET UDPOpen(UDP_PORT localPort,
                   NODE_INFO *remoteNode,
                   UDP_PORT remotePort)
{
    UDP_SOCKET s;
    UDP_SOCKET_INFO *p;

	// Local temp port numbers.
	static WORD NextPort __attribute__((persistent));


    p = UDPSocketInfo;
    for ( s = 0; s < MAX_UDP_SOCKETS; s++ )
    {
        if(p->localPort == INVALID_UDP_PORT)
        {
			p->localPort = localPort;	

			if(localPort == 0x0000u)
			{
				if(NextPort > LOCAL_UDP_PORT_END_NUMBER || NextPort < LOCAL_UDP_PORT_START_NUMBER)
					NextPort = LOCAL_UDP_PORT_START_NUMBER;
	
	            p->localPort    = NextPort++;
			}

            // If remoteNode is supplied, remember it.
            if(remoteNode)
            {
                memcpy((void*)&p->remoteNode,
                        (const void*)remoteNode,
                        sizeof(p->remoteNode));
            }
            else
			{
				// else Set broadcast address
				memset((void*)&p->remoteNode, 0xFF, sizeof(p->remoteNode));
			}

            p->remotePort   = remotePort;
            p->TxCount      = 0;
            p->RxCount      = 0;

            // Mark this socket as active.
            // Once an active socket is set, subsequent operation can be
            // done without explicitely supply socket identifier.
            activeUDPSocket = s;
            return s;
        }
        p++;
    }

    return (UDP_SOCKET)INVALID_UDP_SOCKET;
}




/*********************************************************************
 * Function:        void UDPClose(UDP_SOCKET s)
 *
 * PreCondition:    UDPOpen() is already called
 *
 * Input:           s       - Socket that is to be closed.
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        Given socket is marked as available for future
 *                  new communcations.
 *
 * Note:            This function does not affect previous
 *                  active UDP socket designation.
  ********************************************************************/
void UDPClose(UDP_SOCKET s)
{
    UDPSocketInfo[s].localPort = INVALID_UDP_PORT;
	UDPSocketInfo[s].remoteNode.IPAddr.Val = 0x00000000;
    UDPSocketInfo[s].Flags.bFirstRead = FALSE;
}


/*********************************************************************
 * Function:        BOOL UDPIsPutReady(UDP_SOCKET s)
 *
 * PreCondition:
 *
 * Input:           s       - Socket that is to be loaded and made
 *                            an active UDP socket.
 *
 * Output:          WORD: Number of bytes that can be put, 0 if none
 *
 * Side Effects:    None
 *
 * Overview:        None
 *
 * Note:            This call sets given socket as an active UDP socket.
 ********************************************************************/
WORD UDPIsPutReady(UDP_SOCKET s)
{
	if(LastPutSocket != s)
	{
		LastPutSocket = s;
		MACSetWritePtr(BASE_TX_ADDR + sizeof(ETHER_HEADER) + sizeof(IP_HEADER) + sizeof(UDP_HEADER));
		UDPSocketInfo[s].TxCount = 0;
	}

	activeUDPSocket = s;
	if(!MACIsTxReady())
		return 0;

	return MAC_TX_BUFFER_SIZE - sizeof(IP_HEADER) - sizeof(UDP_HEADER) - UDPSocketInfo[activeUDPSocket].TxCount;
}

/*********************************************************************
 * Function:        BOOL UDPPut(BYTE v)
 *
 * PreCondition:    UDPIsPutReady() > 0 with desired UDP socket
 *                  that is to be loaded.
 *
 * Input:           v       - Data byte to loaded into transmit buffer
 *
 * Output:          TRUE if put successful
 *                  FALSE if transmit buffer is full and put failed
 *
 * Side Effects:    None
 *
 * Overview:        Given data byte is put into UDP transmit buffer
 *                  and active UDP socket buffer length is incremented
 *                  by one.
 *                  If buffer has become full, FALSE is returned.
 *                  Or else TRUE is returned.
 *
 * Note:            This function loads data into an active UDP socket
 *                  as determined by previous call to UDPIsPutReady()
 ********************************************************************/
BOOL UDPPut(BYTE v)
{
	// See if we are out of transmit space.
	if(UDPSocketInfo[activeUDPSocket].TxCount >= (MAC_TX_BUFFER_SIZE - sizeof(IP_HEADER) - sizeof(UDP_HEADER)))
	{
		return FALSE;
	}

    // Load application data byte
    MACPut(v);
	UDPSocketInfo[activeUDPSocket].TxCount++;

    return TRUE;
}

/*********************************************************************
 * Function:        WORD UDPPutArray(BYTE *cData, WORD wDataLen)
 *
 * PreCondition:    UDPIsPutReady() > 0 with desired UDP socket
 *                  that is to be loaded.
 *
 * Input:           *cData - Pointer to data to write
 *					wDataLen - Length of data @ *cData to write
 *
 * Output:          WORD: Number of bytes successfully placed in the 
 *						  UDP transmit buffer
 *
 * Side Effects:    None
 *
 * Overview:        None
 *
 * Note:            None
 ********************************************************************/
WORD UDPPutArray(BYTE *cData, WORD wDataLen)
{
	WORD wTemp;

	wTemp = (MAC_TX_BUFFER_SIZE - sizeof(IP_HEADER) - sizeof(UDP_HEADER)) - UDPSocketInfo[activeUDPSocket].TxCount;
	if(wTemp < wDataLen)
		wDataLen = wTemp;

	UDPSocketInfo[activeUDPSocket].TxCount += wDataLen; 

    // Load application data bytes
    MACPutArray(cData, wDataLen);

    return wDataLen;
}

WORD UDPPutROMArray(ROM BYTE *cData, WORD wDataLen)
{
	WORD wTemp;

	wTemp = (MAC_TX_BUFFER_SIZE - sizeof(IP_HEADER) - sizeof(UDP_HEADER)) - UDPSocketInfo[activeUDPSocket].TxCount;
	if(wTemp < wDataLen)
		wDataLen = wTemp;

	UDPSocketInfo[activeUDPSocket].TxCount += wDataLen; 

    // Load application data bytes
    MACPutROMArray(cData, wDataLen);

    return wDataLen;
}

BYTE* UDPPutString(BYTE *strData)
{
	return strData + UDPPutArray(strData, strlen((char*)strData));
}

ROM BYTE* UDPPutROMString(ROM BYTE *strData)
{
	return strData + UDPPutROMArray(strData, strlenpgm((ROM char*)strData));
}



/*********************************************************************
 * Function:        BOOL UDPFlush(void)
 *
 * PreCondition:    UDPPut() is already called and desired UDP socket
 *                  is set as an active socket by calling
 *                  UDPIsPutReady().
 *
 * Input:           None
 *
 * Output:          All and any data associated with active UDP socket
 *                  buffer is marked as ready for transmission.
 *
 * Side Effects:    None
 *
 * Overview:        None
 *
 * Note:            This function transmit all data from
 *                  an active UDP socket.
 ********************************************************************/
void UDPFlush(void)
{
    UDP_HEADER      h;
    UDP_SOCKET_INFO *p;

    // Wait for TX hardware to become available (finish transmitting 
    // any previous packet)
    while(!IPIsTxReady());

    p = &UDPSocketInfo[activeUDPSocket];

	
    h.SourcePort        = swaps(p->localPort);
    h.DestinationPort   = swaps(p->remotePort);
    h.Length            = (WORD)((WORD)p->TxCount + (WORD)sizeof(UDP_HEADER));
    // Do not swap h.Length yet.  It is needed in IPPutHeader.
    h.Checksum          = 0x0000;

    MACSetWritePtr(BASE_TX_ADDR + sizeof(ETHER_HEADER));

    // Load IP header.
    IPPutHeader( &p->remoteNode,
                 IP_PROT_UDP,
                 h.Length );


    // Now swap h.Length.
    h.Length            = swaps(h.Length);

    // Now load UDP header.
    IPPutArray((BYTE*)&h, sizeof(h));

    // Update checksum.
    // TO BE IMPLEMENTED

    MACFlush();

    p->TxCount          = 0;
	LastPutSocket 		= INVALID_UDP_SOCKET;
}



/*********************************************************************
 * Function:        WORD UDPIsGetReady(UDP_SOCKET s)
 *
 * PreCondition:    UDPInit() is already called.
 *
 * Input:           A valid UDP socket that is already "Listen"ed on
 *                  or opened.
 *
 * Output:          WORD: Number of available bytes that can be 
 *					retrieved.  0 if no data received on this socket.
 *
 * Side Effects:    Given socket is set as an active UDP Socket.
 *
 * Overview:        None
 *
 * Note:            This function automatically sets supplied socket
 *                  as an active socket.  Caller need not call
 *                  explicit function UDPSetActiveSocket().  All
 *                  subsequent calls will us this socket as an
 *                  active socket.
 ********************************************************************/
WORD UDPIsGetReady(UDP_SOCKET s)
{
    activeUDPSocket = s;
    return UDPSocketInfo[activeUDPSocket].RxCount;
}

/*********************************************************************
 * Function:        BOOL UDPGet(BYTE *v)
 *
 * PreCondition:    UDPInit() is already called     AND
 *                  UDPIsGetReady(s) > 0
 *
 * Input:           v       - Buffer to receive UDP data byte
 *
 * Output:          TRUE    if a data byte was read
 *                  FALSE   if no data byte was read or available
 *
 * Side Effects:    None
 *
 * Overview:        None
 *
 * Note:            This function fetches data from an active UDP
 *                  socket as set by UDPIsGetReady() call.
 ********************************************************************/
BOOL UDPGet(BYTE *v)
{
	// Make sure that there is data to return
    if ( UDPSocketInfo[activeUDPSocket].RxCount == 0u )
        return FALSE;

    // If if this very first read to packet, set MAC Rx Pointer to
    // beginig of UDP data area.
    if ( UDPSocketInfo[activeUDPSocket].Flags.bFirstRead )
    {
        UDPSocketInfo[activeUDPSocket].Flags.bFirstRead = FALSE;
        UDPSetRxBuffer(0);
    }

    *v = MACGet();

    UDPSocketInfo[activeUDPSocket].RxCount--;

    if ( UDPSocketInfo[activeUDPSocket].RxCount == 0u )
    {
        MACDiscardRx();
    }

    return TRUE;
}

/*********************************************************************
 * Function:        WORD UDPGetArray(BYTE *cData, WORD wDataLen)
 *
 * PreCondition:    UDPInit() is already called     AND
 *                  UDPIsGetReady(s) > 0
 *
 * Input:           *cData - Pointer to location to write retrieved bytes
 *					wDataLen - Number of bytes to retreive
 *				
 * Output:          WORD - Number of bytes written to cData
 *
 * Side Effects:    None
 *
 * Overview:        None
 *
 * Note:            This function fetches data from an active UDP
 *                  socket as set by UDPIsGetReady()
 ********************************************************************/
WORD UDPGetArray(BYTE *cData, WORD wDataLen)
{
    // If this is the very first read of the packet, set MAC Rx Pointer to
    // beginig of UDP data area.
    if(UDPSocketInfo[activeUDPSocket].Flags.bFirstRead)
    {
        UDPSocketInfo[activeUDPSocket].Flags.bFirstRead = FALSE;
        UDPSetRxBuffer(0);
    }

	// Make sure that there is data to return
	if(UDPSocketInfo[activeUDPSocket].RxCount < wDataLen)
		wDataLen = UDPSocketInfo[activeUDPSocket].RxCount;

	wDataLen = MACGetArray(cData, wDataLen);

    UDPSocketInfo[activeUDPSocket].RxCount -= wDataLen;

    if(UDPSocketInfo[activeUDPSocket].RxCount == 0u)
    {
        MACDiscardRx();
    }

    return wDataLen;
}

/*********************************************************************
 * Function:        void UDPDiscard(void)
 *
 * PreCondition:    UDPInit() is already called
 *
 * Input:           None
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        None
 *
 * Note:            This function discards an active UDP socket content.
 ********************************************************************/
void UDPDiscard(void)
{
    if(UDPSocketInfo[activeUDPSocket].RxCount)
        MACDiscardRx();

    UDPSocketInfo[activeUDPSocket].RxCount = 0;
}



/*********************************************************************
 * Function:        BOOL UDPProcess(NODE_INFO* remoteNode,
 *                                  IP_ADDR *localIP,
 *                                  WORD len)
 *
 * PreCondition:    UDPInit() is already called     AND
 *                  UDP segment is ready in MAC buffer
 *
 * Input:           remoteNode      - Remote node info
 *                  len             - Total length of UDP semgent.
 *
 * Output:          TRUE if this function has completed its task
 *                  FALSE otherwise
 *
 * Side Effects:    None
 *
 * Overview:        None
 *
 * Note:            None
 ********************************************************************/
// Pseudo header as defined by rfc 793.
typedef struct _PSEUDO_HEADER
{
    IP_ADDR SourceAddress;
    IP_ADDR DestAddress;
    BYTE Zero;
    BYTE Protocol;
    WORD Length;
} PSEUDO_HEADER;

#define SwapPseudoHeader(h)  (h.Length = swaps(h.Length))

BOOL UDPProcess(NODE_INFO *remoteNode, IP_ADDR *localIP, WORD len)
{
    UDP_HEADER		h;
    UDP_SOCKET		s;
    PSEUDO_HEADER	pseudoHeader;
    DWORD_VAL		checksums;


    // Retrieve UDP header.
    MACGetArray((BYTE*)&h, sizeof(h));

    h.SourcePort        = swaps(h.SourcePort);
    h.DestinationPort   = swaps(h.DestinationPort);
    h.Length            = swaps(h.Length) - sizeof(UDP_HEADER);

	// See if we need to validate the checksum field (0x0000 is disabled)
	if(h.Checksum)
	{
	    // Calculate IP pseudoheader checksum.
	    pseudoHeader.SourceAddress		= remoteNode->IPAddr;
	    pseudoHeader.DestAddress.v[0]	= localIP->v[0];
	    pseudoHeader.DestAddress.v[1]	= localIP->v[1];
	    pseudoHeader.DestAddress.v[2]	= localIP->v[2];
	    pseudoHeader.DestAddress.v[3]	= localIP->v[3];
	    pseudoHeader.Zero				= 0x0;
	    pseudoHeader.Protocol			= IP_PROT_UDP;
	    pseudoHeader.Length				= len;

	    SwapPseudoHeader(pseudoHeader);
	
	    checksums.w[0] = ~CalcIPChecksum((BYTE*)&pseudoHeader,
	                                    sizeof(pseudoHeader));
	
	
	    // Now calculate UDP packet checksum in NIC RAM -- should match pseudoHeader
	    IPSetRxBuffer(0);
	    checksums.w[1] = CalcIPBufferChecksum(len);
	
	    if(checksums.w[0] != checksums.w[1])
	    {
	        MACDiscardRx();
	        return TRUE;
	    }
	}

    s = FindMatchingSocket(&h, remoteNode, localIP);
    if ( s == INVALID_UDP_SOCKET )
    {
         // If there is no matching socket, There is no one to handle
         // this data.  Discard it.
        MACDiscardRx();
    }
    else
    {
        UDPSocketInfo[s].RxCount = h.Length;
        UDPSocketInfo[s].Flags.bFirstRead = TRUE;
    }


    return TRUE;
}


/*********************************************************************
 * Function:        UDP_SOCKET FindMatchingSocket(UDP_HEADER *h,
 *                                NODE_INFO *remoteNode,
 *                                IP_ADDR *localIP)
 *
 * PreCondition:    UDP Segment header has been retrieved from buffer
 *                  The IP header has also been retrieved
 *
 * Input:           remoteNode      - Remote node info from IP header
 *                  h               - header of UDP semgent.
 *
 * Output:          matching UDP socket or INVALID_UDP_SOCKET
 *
 * Side Effects:    None
 *
 * Overview:        None
 *
 * Note:            None
 ********************************************************************/
#define BROADCAST_ADDRESS   (0xfffffffful)
static UDP_SOCKET FindMatchingSocket(UDP_HEADER *h,
                                     NODE_INFO *remoteNode,
                                     IP_ADDR *localIP)
{
    UDP_SOCKET s;
    UDP_SOCKET partialMatch;
    UDP_SOCKET_INFO *p;

    partialMatch = INVALID_UDP_SOCKET;

    p = UDPSocketInfo;
    for ( s = 0; s < MAX_UDP_SOCKETS; s++ )
    {
        // This packet is said to be matching with current socket
        // 1. If its destination port matches with our local port.
        // 2. This socket does not have any data pending.
        // 3. Packet source IP address matches with socket remote IP address.
        //    OR this socket had transmitted packet with destination address as broadcast.
        if ( p->localPort == h->DestinationPort )
        {
            if ( (p->remotePort == h->SourcePort) && (p->RxCount == 0ul) )
            {
                if ( (p->remoteNode.IPAddr.Val == remoteNode->IPAddr.Val) ||
                     (localIP->Val == BROADCAST_ADDRESS) )
                {
                    return s;
                }
            }

            partialMatch = s;
        }
        p++;
    }

    if ( partialMatch != INVALID_UDP_SOCKET )
    {
        p = &UDPSocketInfo[partialMatch];

        memcpy((void*)&p->remoteNode,
                (const void*)remoteNode, sizeof(p->remoteNode) );

        p->remotePort = h->SourcePort;
    } 
    return partialMatch;
}


#endif //#if defined(STACK_USE_UDP)
