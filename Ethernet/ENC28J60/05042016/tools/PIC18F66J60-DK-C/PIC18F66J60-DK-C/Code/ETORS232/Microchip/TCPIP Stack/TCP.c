/*********************************************************************
 *
 *	Transmission Control Protocol (TCP) Communications Layer
 *  Module for Microchip TCP/IP Stack
 *	 -Provides reliable, handshaked transport of application stream 
 *    oriented data with flow control
 *	 -Reference: RFC 793
 *
 *********************************************************************
 * FileName:        TCP.c
 * Dependencies:    string.h
 *                  StackTsk.h
 *                  Helpers.h
 *                  IP.h
 *                  MAC.h
 *                  ARP.h
 *                  Tick.h
 *                  TCP.h
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
 * Nilesh Rajbharti     5/8/01  	Original        (Rev 1.0)
 * Howard Schlunder		12/11/06	Changed almost everything to 
 *									better meet RFC 793.
 ********************************************************************/
#define __TCP_C

#include "TCPIP Stack/TCPIP.h"

#if defined(STACK_USE_TCP)


#define MAX_TCP_DATA_LEN			(MAC_TX_BUFFER_SIZE - sizeof(TCP_HEADER) - sizeof(IP_HEADER) - sizeof(ETHER_HEADER))

// TCP Timeout and retransmit numbers
#define TCP_START_TIMEOUT_VAL   	((TICK)TICK_SECOND * (TICK)1)
#define TCP_TIME_WAIT_TIMEOUT_VAL   ((TICK)TICK_SECOND * (TICK)0)
#define MAX_RETRY_COUNTS    (5u)

#define TCP_AUTO_TRANSMIT_TIMEOUT_VAL	((WORD)(TICK_SECOND/25))

// TCP Flags defined in RFC
#define FIN     (0x01)
#define SYN     (0x02)
#define RST     (0x04)
#define PSH     (0x08)
#define ACK     (0x10)
#define URG     (0x20)

// TCP Header
typedef struct _TCP_HEADER
{
	WORD    SourcePort;
	WORD    DestPort;
	DWORD   SeqNumber;
	DWORD   AckNumber;

	struct
	{
		unsigned char Reserved3      : 4;
		unsigned char Val            : 4;
	} DataOffset;

	union
	{
		struct
		{
			unsigned char flagFIN    : 1;
			unsigned char flagSYN    : 1;
			unsigned char flagRST    : 1;
			unsigned char flagPSH    : 1;
			unsigned char flagACK    : 1;
			unsigned char flagURG    : 1;
			unsigned char Reserved2  : 2;
		} bits;
		BYTE byte;
	} Flags;

	WORD    Window;
	WORD    Checksum;
	WORD    UrgentPointer;
} TCP_HEADER;

// TCP Options as defined by RFC
#define TCP_OPTIONS_END_OF_LIST     (0x00u)
#define TCP_OPTIONS_NO_OP           (0x01u)
#define TCP_OPTIONS_MAX_SEG_SIZE    (0x02u)
typedef struct _TCP_OPTIONS
{
	BYTE        Kind;
	BYTE        Length;
	WORD_VAL    MaxSegSize;
} TCP_OPTIONS;

#define SwapPseudoTCPHeader(h)  (h.TCPLength = swaps(h.TCPLength))

// IP pseudo header as defined by RFC 793
typedef struct _PSEUDO_HEADER
{
	IP_ADDR SourceAddress;
	IP_ADDR DestAddress;
	BYTE Zero;
	BYTE Protocol;
	WORD TCPLength;
} PSEUDO_HEADER;

#define LOCAL_PORT_START_NUMBER (1024u)
#define LOCAL_PORT_END_NUMBER   (5000u)


// Local temp port numbers.
#ifdef STACK_CLIENT_MODE
static WORD NextPort __attribute__((persistent));
#endif

#if defined(HI_TECH_C)
	// The initializer forces this large array out of the bss section 
	// so we can link correctly.
	TCB_STUB TCBStubs[MAX_TCP_SOCKETS] = {'\0'};	
#else
	// The TCB array is very large.  With the C18 compiler, one must 
	// modify the linker script to make an array that spans more than 
	// one memory bank.  To do this, make the necessary changes to your 
	// processor's linker script (.lkr).  Here is an example showing 
	// gpr11 and 128 bytes of gpr12 being combined into one 384 byte 
	// block used exclusively by the TCB_MEM data section:
	// ...
	// //DATABANK   NAME=gpr11      START=0xB00          END=0xBFF
	// //DATABANK   NAME=gpr12      START=0xC00          END=0xCFF
	// DATABANK   NAME=gpr11b     START=0xB00          END=0xC7F           PROTECTED
	// DATABANK   NAME=gpr12      START=0xC80          END=0xCFF
	// ...
	// SECTION    NAME=TCP_TCB_RAM    RAM=gpr11b
	// ...
	#pragma udata TCB_uRAM
	TCB_STUB TCBStubs[MAX_TCP_SOCKETS];
	#pragma udata					// Return to any other RAM section
#endif

static TCB MyTCB;
//static TCP_SOCKET hCurrentTCB = 0;


static void HandleTCPSeg(TCP_SOCKET hTCP, TCP_HEADER *h, WORD len);
static void SendTCP(TCP_SOCKET hTCP, BYTE flags);
static TCP_SOCKET FindMatchingSocket(TCP_HEADER *h, NODE_INFO *remote);
static void SwapTCPHeader(TCP_HEADER* header);
static void CloseSocket(TCP_SOCKET hTCP);
static void LoadTCB(TCP_SOCKET hTCP);
static void SaveTCB(TCP_SOCKET hTCP);
static BYTE ProcessRXBytes(TCB_STUB *ps, TCP_HEADER *h, WORD len);



static void LoadTCB(TCP_SOCKET hTCP)
{
	WORD PtrSave;
//	if(hCurrentTCB == hTCP)
//		return;

	// Load up the new TCB
//	hCurrentTCB = hTCP;
	PtrSave = MACSetReadPtr(TCBStubs[hTCP].bufferTxStart - sizeof(MyTCB));
	MACGetArray((BYTE*)&MyTCB, sizeof(MyTCB));
	MACSetReadPtr(PtrSave);
}

static void SaveTCB(TCP_SOCKET hTCP)
{
	WORD PtrSave;

//	hCurrentTCB = hTCP;

	// Save the current TCB
	PtrSave = MACSetWritePtr(TCBStubs[hTCP].bufferTxStart - sizeof(MyTCB));
	MACPutArray((BYTE*)&MyTCB, sizeof(MyTCB));
	MACSetWritePtr(PtrSave);
}


/*********************************************************************
* Function:        void TCPInit(void)
*
* PreCondition:    None
*
* Input:           None
*
* Output:          TCP is initialized.
*
* Side Effects:    None
*
* Overview:        Initialize all socket states
*
* Note:            This function is called only once during lifetime
*                  of the application.
********************************************************************/
void TCPInit(void)
{
	TCP_SOCKET hTCP;
	TCB_STUB *ps;
	
	// Initialize all sockets.
	for(hTCP = 0; hTCP < MAX_TCP_SOCKETS; hTCP++)
	{
		ps = &TCBStubs[hTCP];

		ps->smState			= TCP_CLOSED;
		ps->bufferTxStart	= BASE_TCB_ADDR + sizeof(TCB) + hTCP*(sizeof(TCB) + (TCP_TX_FIFO_SIZE+1) + (TCP_RX_FIFO_SIZE+1));
		ps->bufferRxStart	= ps->bufferTxStart + TCP_TX_FIFO_SIZE+1;
		ps->bufferEnd		= ps->bufferRxStart + TCP_RX_FIFO_SIZE;
		ps->Flags.bServer	= FALSE;
		ps->Flags.bTimerEnabled = FALSE;
		ps->Flags.bTimer2Enabled = FALSE;
		ps->Flags.bDelayedACKTimerEnabled = FALSE;
		ps->Flags.bOneSegmentReceived = FALSE;
		ps->Flags.bHalfFullFlush = FALSE;
		ps->Flags.bTXASAP = FALSE;
	}

	// Initialize random number generator
	srand((WORD)TickGet());
}



/*********************************************************************
* Function:        TCP_SOCKET TCPListen(WORD port)
*
* PreCondition:    TCPInit() is already called.
*
* Input:           port    - A TCP port to be opened.
*
* Output:          Given port is opened and returned on success
*                  INVALID_SOCKET if no more sockets left.
*
* Side Effects:    None
*
* Overview:        None
*
* Note:            None
********************************************************************/
TCP_SOCKET TCPListen(WORD port)
{
	TCP_SOCKET hTCP;
	TCB_STUB *ps;

	for(hTCP = 0; hTCP < MAX_TCP_SOCKETS; hTCP++)
	{
		ps = &TCBStubs[hTCP];

		if(ps->smState == TCP_CLOSED)
		{
			ps->Flags.bServer = TRUE;
			ps->smState = TCP_LISTEN;
			ps->remoteHash.Val = port;
			ps->txTail = ps->bufferTxStart;
			ps->txHead = ps->bufferTxStart;
			ps->rxTail = ps->bufferRxStart;
			ps->rxHead = ps->bufferRxStart;

			MyTCB.sHoleSize = -1;
			MyTCB.localPort.Val = port;
			MyTCB.txUnackedTail = ps->bufferTxStart;
			((DWORD_VAL*)(&MyTCB.MySEQ))->w[0] = rand();
			((DWORD_VAL*)(&MyTCB.MySEQ))->w[1] = rand();
			SaveTCB(hTCP);
			
			return hTCP;
		}
	}

	return INVALID_SOCKET;
}


/*********************************************************************
* FunctionL		BOOL TCPGetRemoteInfo(TCP_SOCKET hTCP, SOCKET_INFO *RemoteInfo)
*
* PreCondition:	TCPInit() is already called.
*
* Input:		hTCP      - Handle of socket to read
*
* Output:		A new socket is created, connection request is
*				sent and socket handle is returned.
*
* Side Effects:	None
*
* Overview:		None
*
* Note:			None
*
********************************************************************/
SOCKET_INFO* TCPGetRemoteInfo(TCP_SOCKET hTCP)
{
	static SOCKET_INFO	RemoteInfo;

	LoadTCB(hTCP);
	memcpy((void*)&RemoteInfo.remote, (void*)&MyTCB.remote, sizeof(NODE_INFO));
	RemoteInfo.remotePort.Val = MyTCB.remotePort.Val;

	return &RemoteInfo;
}


/*********************************************************************
* Function:        TCP_SOCKET TCPConnect(NODE_INFO* remote,
*                                      WORD remotePort)
*
* PreCondition:    TCPInit() is already called.
*
* Input:           remote      - Remote node address info
*                  remotePort  - remote port to be connected.
*
* Output:          A new socket is created, connection request is
*                  sent and socket handle is returned.
*
* Side Effects:    None
*
* Overview:        None
*
* Note:            By default this function is not included in
*                  source.  You must define STACK_CLIENT_MODE to
*                  be able to use this function.
********************************************************************/
#ifdef STACK_CLIENT_MODE
TCP_SOCKET TCPConnect(NODE_INFO *remote, WORD remotePort)
{
	TCP_SOCKET hTCP;
	TCB_STUB *ps;

	// Find an available socket
	for(hTCP = 0; hTCP < MAX_TCP_SOCKETS; hTCP++)
	{
		ps = &TCBStubs[hTCP];

		if(ps->smState != TCP_CLOSED)
			continue;

		// Zero out the TCB
		memset((BYTE*)&MyTCB, 0x00, sizeof(MyTCB));

		// Each new socket that is opened by this node, gets the 
		// next sequential port number.
		if(NextPort < LOCAL_PORT_START_NUMBER || NextPort > LOCAL_PORT_END_NUMBER)
			NextPort = LOCAL_PORT_START_NUMBER;
		
		// Set the non-zero TCB fields
		MyTCB.sHoleSize = -1;
		MyTCB.localPort.Val = NextPort++;
		MyTCB.remotePort.Val = remotePort;
		memcpy((void*)&MyTCB.remote, (void*)remote, sizeof(NODE_INFO));
		((DWORD_VAL*)(&MyTCB.MySEQ))->w[0] = rand();
		((DWORD_VAL*)(&MyTCB.MySEQ))->w[1] = rand();
		MyTCB.retryCount = 0;
		MyTCB.retryInterval = TCP_START_TIMEOUT_VAL;

		// Zero out the buffer contents
		MyTCB.txUnackedTail	= ps->bufferTxStart;
		ps->txHead			= ps->bufferTxStart;
		ps->txTail			= ps->bufferTxStart;
		ps->rxHead			= ps->bufferRxStart;
		ps->rxTail			= ps->bufferRxStart;
		
		// Update the TCB Stub
		ps->remoteHash.Val = (remote->IPAddr.w[1]+remote->IPAddr.w[0] + remotePort) ^ MyTCB.localPort.Val;
		ps->smState = TCP_SYN_SENT;
		ps->eventTime = TickGet() + TCP_START_TIMEOUT_VAL;
		ps->Flags.bTimerEnabled = TRUE;

		// Save the TCB
		SaveTCB(hTCP);

		// Send TCP SYNchronize (connect) request
		SendTCP(hTCP, SYN);

		return hTCP;
	}

	// If there is no socket available, return error.
	return INVALID_SOCKET;
}
#endif



/*********************************************************************
* Function:        BOOL TCPIsConnected(TCP_SOCKET hTCP)
*
* PreCondition:    TCPInit() is already called.
*
* Input:           hTCP    - Socket to be checked for connection.
*
* Output:          TRUE    if given socket is connected
*                  FALSE   if given socket is not connected.
*
* Side Effects:    None
*
* Overview:        None
*
* Note:            A socket is said to be connected only if it is in 
*				   the TCP_ESTABLISHED state
********************************************************************/
BOOL TCPIsConnected(TCP_SOCKET hTCP)
{
	return TCBStubs[hTCP].smState == TCP_ESTABLISHED;
}



/*********************************************************************
* Function:        void TCPDisconnect(TCP_SOCKET hTCP)
*
* PreCondition:    TCPInit() is already called
*
* Input:           hTCP - Socket to be disconnected.
*
* Output:          A disconnect request is sent for given socket.  
*				   This function does nothing if the socket isn't 
*				   currently connected.
*
* Side Effects:    None
*
* Overview:        None
*
* Note:            None
********************************************************************/
void TCPDisconnect(TCP_SOCKET hTCP)
{
	TCB_STUB *ps;

	ps = &TCBStubs[hTCP];
	LoadTCB(hTCP);

	switch(ps->smState)
	{
		//case TCP_CLOSED:
		//case TCP_LISTEN:
		//case TCP_LAST_ACK:
		//case TCP_FIN_WAIT_1:
		//case TCP_FIN_WAIT_2:
		//case TCP_CLOSING:
		//case TCP_TIME_WAIT:
		//	return;

		case TCP_SYN_SENT:
			CloseSocket(hTCP);
			break;

		case TCP_SYN_RECEIVED:
		case TCP_ESTABLISHED:
			MyTCB.MySEQ++;
			SendTCP(hTCP, FIN | ACK);
			ps->smState = TCP_FIN_WAIT_1;
			// Clear timeout info
			MyTCB.retryCount  = 0;
			MyTCB.retryInterval = TCP_START_TIMEOUT_VAL;
			ps->eventTime = TickGet() + TCP_START_TIMEOUT_VAL;
			ps->Flags.bTimerEnabled = TRUE;
			break;

		case TCP_CLOSE_WAIT:
			MyTCB.MySEQ++;
			SendTCP(hTCP, FIN | ACK);
			ps->smState = TCP_LAST_ACK;
			// Clear timeout info
			MyTCB.retryCount  = 0;
			MyTCB.retryInterval = TCP_START_TIMEOUT_VAL;
			ps->eventTime = TickGet() + TCP_START_TIMEOUT_VAL;
			ps->Flags.bTimerEnabled = TRUE;
			break;
	}
	
	SaveTCB(hTCP);
}

/*********************************************************************
* Function:        void TCPFlush(TCP_SOCKET hTCP)
*
* PreCondition:    TCPInit() is already called.
*
* Input:           s       - Socket whose data is to be transmitted.
*
* Output:          None
*
* Side Effects:    None
*
* Overview:        None
*
* Note:            None
********************************************************************/
void TCPFlush(TCP_SOCKET hTCP)
{
	TCB_STUB *ps;

	ps = &TCBStubs[hTCP];
	LoadTCB(hTCP);

	if(ps->txHead != MyTCB.txUnackedTail)
	{
		SendTCP(hTCP, PSH | ACK);

		// Clear timeout info
		MyTCB.retryCount = 0;
		MyTCB.retryInterval = TCP_START_TIMEOUT_VAL;
		ps->eventTime = TickGet() + TCP_START_TIMEOUT_VAL;
		ps->Flags.bTimerEnabled = TRUE;
	}
	SaveTCB(hTCP);
}



/*********************************************************************
* Function:        WORD TCPIsPutReady(TCP_SOCKET hTCP)
*
* PreCondition:    TCPInit() is already called.
*
* Input:           hTCP: handle of socket to test
*
* Output:          Number of bytes that can be immediately placed 
*				   in the transmit buffer.
*
* Side Effects:    None
*
* Overview:        None
*
* Note:            None
********************************************************************/
WORD TCPIsPutReady(TCP_SOCKET hTCP)
{
	TCB_STUB	*ps;

	ps = &TCBStubs[hTCP];

	// Unconnected sockets shouldn't be transmitting anything.
	if(!((ps->smState == TCP_ESTABLISHED) || (ps->smState == TCP_CLOSE_WAIT)))
		return 0;

	// Calculate the free space in this socket's TX FIFO
	if(ps->txHead >= ps->txTail)
		return (ps->bufferRxStart - ps->bufferTxStart - 1) - (ps->txHead - ps->txTail);
	else
		return ps->txTail - ps->txHead - 1;
}


/*********************************************************************
* Function:        BOOL TCPPut(TCP_SOCKET hTCP, BYTE byte)
*
* PreCondition:    TCPIsPutReady(s) != 0
*
* Input:           hTCP: socket handle to use
*                  byte: a data byte to send
*
* Output:          TRUE if given byte was put in transmit buffer
*                  FALSE if transmit buffer is full.
*
* Side Effects:    None
*
* Overview:        None
*
* Note:            None
********************************************************************/
BOOL TCPPut(TCP_SOCKET hTCP, BYTE byte)
{
	TCB_STUB *ps;
	WORD wFreeTXSpace;

	ps = &TCBStubs[hTCP];

	wFreeTXSpace = TCPIsPutReady(hTCP);
	if(wFreeTXSpace == 0u)
		return FALSE;
	else if(wFreeTXSpace == 1u) // About to run out of space, lets transmit so the remote node might send an ACK back faster
		TCPFlush(hTCP);	

	// Send all current bytes if we are crossing half full
	// This is required to improve performance with the delayed 
	// acknowledgement algorithm
	if((!ps->Flags.bHalfFullFlush) && (wFreeTXSpace <= ((ps->bufferRxStart-ps->bufferTxStart)>>1)))
	{
		TCPFlush(hTCP);	
		ps->Flags.bHalfFullFlush = TRUE;
	}

	MACSetWritePtr(ps->txHead);
	MACPut(byte);
	if(++ps->txHead >= ps->bufferRxStart)
		ps->txHead = ps->bufferTxStart;

	// Send the last byte as a separate packet (likely will make the remote node send back ACK faster)
	if(wFreeTXSpace == 1u)
		TCPFlush(hTCP);

	// If not already enabled, start a timer so this data will 
	// eventually get sent even if the application doens't call
	// TCPFlush()
	if(!ps->Flags.bTimer2Enabled)
	{
		ps->Flags.bTimer2Enabled = TRUE;
		ps->eventTime2 = (WORD)TickGet() + TCP_AUTO_TRANSMIT_TIMEOUT_VAL;
	}

	return TRUE;
}

/*********************************************************************
* Function:        WORD TCPPutArray(TCP_SOCKET hTCP, BYTE *data, WORD len)
*
* PreCondition:    None
*
* Input:           hTCP    - Socket handle to use
*                  data    - Pointer to data to put
*				   len     - Count of bytes to put
*
* Output:          Count of bytes actually placed in the TX buffer
*
* Side Effects:    None
*
* Overview:        None
*
* Note:            None
********************************************************************/
WORD TCPPutArray(TCP_SOCKET hTCP, BYTE *data, WORD len)
{
	WORD wActualLen;
	WORD wFreeTXSpace;
	WORD wRightLen = 0;
	TCB_STUB *ps;

	ps = &TCBStubs[hTCP];

	wFreeTXSpace = TCPIsPutReady(hTCP);
	if(wFreeTXSpace == 0u)
	{
		TCPFlush(hTCP);
		return 0;
	}

	wActualLen = wFreeTXSpace;
	if(wFreeTXSpace > len)
		wActualLen = len;

	// Send all current bytes if we are crossing half full
	// This is required to improve performance with the delayed 
	// acknowledgement algorithm
	if((!ps->Flags.bHalfFullFlush) && (wFreeTXSpace <= ((ps->bufferRxStart-ps->bufferTxStart)>>1)))
	{
		TCPFlush(hTCP);	
		ps->Flags.bHalfFullFlush = TRUE;
	}
	
	// See if we need a two part put
	if(ps->txHead + wActualLen >= ps->bufferRxStart)
	{
		wRightLen = ps->bufferRxStart-ps->txHead;
		MACSetWritePtr(ps->txHead);
		MACPutArray(data, wRightLen);
		data += wRightLen;
		wActualLen -= wRightLen;
		ps->txHead = ps->bufferTxStart;
	}

	MACSetWritePtr(ps->txHead);
	MACPutArray(data, wActualLen);
	ps->txHead += wActualLen;

	// Send these bytes right now if we are out of TX buffer space
	if(wFreeTXSpace <= len)
		TCPFlush(hTCP);

	// If not already enabled, start a timer so this data will 
	// eventually get sent even if the application doens't call
	// TCPFlush()
	if(!ps->Flags.bTimer2Enabled)
	{
		ps->Flags.bTimer2Enabled = TRUE;
		ps->eventTime2 = (WORD)TickGet() + TCP_AUTO_TRANSMIT_TIMEOUT_VAL;
	}

	return wActualLen + wRightLen;
}

WORD TCPPutROMArray(TCP_SOCKET hTCP, ROM BYTE *data, WORD len)
{
	WORD wActualLen;
	WORD wFreeTXSpace;
	WORD wRightLen = 0;
	TCB_STUB *ps;

	ps = &TCBStubs[hTCP];

	wFreeTXSpace = TCPIsPutReady(hTCP);
	if(wFreeTXSpace == 0u)
	{
		TCPFlush(hTCP);
		return 0;
	}

	// Send all current bytes if we are crossing half full
	// This is required to improve performance with the delayed 
	// acknowledgement algorithm
	if((!ps->Flags.bHalfFullFlush) && (wFreeTXSpace <= ((ps->bufferRxStart-ps->bufferTxStart)>>1)))
	{
		TCPFlush(hTCP);	
		ps->Flags.bHalfFullFlush = TRUE;
	}
	
	wActualLen = wFreeTXSpace;
	if(wFreeTXSpace > len)
		wActualLen = len;
	
	// See if we need a two part put
	if(ps->txHead + wActualLen >= ps->bufferRxStart)
	{
		wRightLen = ps->bufferRxStart-ps->txHead;
		MACSetWritePtr(ps->txHead);
		MACPutROMArray(data, wRightLen);
		data += wRightLen;
		wActualLen -= wRightLen;
		ps->txHead = ps->bufferTxStart;
	}

	MACSetWritePtr(ps->txHead);
	MACPutROMArray(data, wActualLen);
	ps->txHead += wActualLen;

	// Send these bytes right now if we are out of TX buffer space
	if(wFreeTXSpace <= len)
		TCPFlush(hTCP);

	// If not already enabled, start a timer so this data will 
	// eventually get sent even if the application doens't call
	// TCPFlush()
	if(!ps->Flags.bTimer2Enabled)
	{
		ps->Flags.bTimer2Enabled = TRUE;
		ps->eventTime2 = (WORD)TickGet() + TCP_AUTO_TRANSMIT_TIMEOUT_VAL;
	}

	return wActualLen + wRightLen;
}


/*********************************************************************
* Function:        WORD TCPPutString(TCP_SOCKET hTCP, BYTE *data)
*
* PreCondition:    None
*
* Input:           hTCP    - Socket handle to use
*                  data    - Pointer to null terminated string to put
*
* Output:          BYTE* - *data pointer incremented by the number of 
*							bytes actually placed in the TX FIFO
*
* Side Effects:    None
*
* Overview:        None
*
* Note:            None
********************************************************************/
BYTE* TCPPutString(TCP_SOCKET hTCP, BYTE *data)
{
	return data + TCPPutArray(hTCP, data, strlen((char*)data));
}

ROM BYTE* TCPPutROMString(TCP_SOCKET hTCP, ROM BYTE *data)
{
	return data + TCPPutROMArray(hTCP, data, strlenpgm((ROM char*)data));
}


/*********************************************************************
* Function:        void TCPDiscard(TCP_SOCKET hTCP)
*
* PreCondition:    TCPInit() is already called.
*
* Input:           hTCP       - socket handle
*
* Output:          None
*
* Side Effects:    None
*
* Overview:        Removes all pending data from the socket's RX 
*				   FIFO.
*
* Note:            None
********************************************************************/
void TCPDiscard(TCP_SOCKET hTCP)
{
	TCB_STUB *ps;

	if(TCPIsGetReady(hTCP))
	{
		ps = &TCBStubs[hTCP];
		LoadTCB(hTCP);
	
		// Delete all data in the RX buffer
		ps->rxTail = ps->rxHead;
	
		// Send a Window update message to the remote node
		SendTCP(hTCP, ACK);
	
		SaveTCB(hTCP);
	}
}


/*********************************************************************
* Function:        WORD TCPIsGetReady(TCP_SOCKET hTCP)
*
* PreCondition:    TCPInit() is already called.
*
* Input:           hTCP       - socket to test
*
* Output:          Number of bytes that are available in socket 'hTCP' 
*				   for immediate retrieval
*
* Side Effects:    None
*
* Overview:        None
*
* Note:            None
********************************************************************/
WORD TCPIsGetReady(TCP_SOCKET hTCP)
{
	TCB_STUB	*ps;

	ps = &TCBStubs[hTCP];

	if(ps->rxHead >= ps->rxTail)
		return ps->rxHead - ps->rxTail;
	else
		return (ps->bufferEnd - ps->rxTail + 1) + (ps->rxHead - ps->bufferRxStart);
}


/*********************************************************************
* Function:        BOOL TCPGet(TCP_SOCKET hTCP, BYTE *byte)
*
* PreCondition:    TCPInit() is already called
*
* Input:           hTCP    - socket
*                  byte    - Pointer to a byte.
*
* Output:          TRUE if a byte was read.
*                  FALSE if byte was not read.
*
* Side Effects:    None
*
* Overview:        None
*
* Note:            None
********************************************************************/
BOOL TCPGet(TCP_SOCKET hTCP, BYTE *byte)
{
	TCB_STUB	*ps;
	WORD GetReadyCount;

	GetReadyCount = TCPIsGetReady(hTCP);
	if(GetReadyCount == 0u)
		return FALSE;

	ps = &TCBStubs[hTCP];
	MACSetReadPtr(ps->rxTail);
	*byte = MACGet();
	if(++ps->rxTail > ps->bufferEnd)
		ps->rxTail = ps->bufferRxStart;

	// Send a window update if we've run out of data
	if(GetReadyCount == 1u)
	{
		LoadTCB(hTCP);
		SendTCP(hTCP, ACK);
		SaveTCB(hTCP);
	}
	// If not already enabled, start a timer so a window 
	// update will get sent to the remote node at some point
	else if(!ps->Flags.bTimer2Enabled)
	{
		ps->Flags.bTimer2Enabled = TRUE;
		ps->eventTime2 = (WORD)TickGet() + TCP_AUTO_TRANSMIT_TIMEOUT_VAL;
	}


	return TRUE;
}


/*********************************************************************
* Function:        WORD TCPGetArray(TCP_SOCKET hTCP, BYTE *buffer,
*                                      WORD len)
*
* PreCondition:    TCPInit() is already called
*
* Input:           hTCP    - socket handle
*                  buffer  - Buffer to hold received data.
*                  len     - Buffer length
*
* Output:          Number of bytes loaded into buffer.
*
* Side Effects:    None
*
* Overview:        None
*
* Note:            None
********************************************************************/
WORD TCPGetArray(TCP_SOCKET hTCP, BYTE *buffer, WORD len)
{
	WORD ActualLen;
	WORD RightLen = 0;
	TCB_STUB *ps;

	ps = &TCBStubs[hTCP];

	ActualLen = TCPIsGetReady(hTCP);
	if(len > ActualLen)
		len = ActualLen;

	// See if we need a two part get
	if(ps->rxTail + len > ps->bufferEnd)
	{
		RightLen = ps->bufferEnd - ps->rxTail + 1;
		MACSetReadPtr(ps->rxTail);
		MACGetArray(buffer, RightLen);
		if(buffer)
			buffer += RightLen;
		len -= RightLen;
		ps->rxTail = ps->bufferRxStart;
	}

	MACSetReadPtr(ps->rxTail);
	MACGetArray(buffer, len);
	ps->rxTail += len;

	// Send a window update if we've run low on data
	if(ActualLen - len <= len)
	{
		LoadTCB(hTCP);
		SendTCP(hTCP, ACK);
		SaveTCB(hTCP);
	}
	else if(!ps->Flags.bTimer2Enabled)
	// If not already enabled, start a timer so a window 
	// update will get sent to the remote node at some point
	{
		ps->Flags.bTimer2Enabled = TRUE;
		ps->eventTime2 = (WORD)TickGet() + TCP_AUTO_TRANSMIT_TIMEOUT_VAL;
	}

	return len + RightLen;
}


/*********************************************************************
* Function:		WORD TCPGetRxFIFOFree(TCP_SOCKET hTCP)
*
* PreCondition:	TCPInit() is already called
*
* Input:		hTCP - TCP socket handle
*
* Output:		Number of bytes that can still fit in the RX FIFO.  
*				0 is returned if the FIFO is completely full.
*
* Side Effects:	None
*
* Overview:		None
*
* Note:			None
********************************************************************/
WORD TCPGetRxFIFOFree(TCP_SOCKET hTCP)
{
	WORD wDataLen;
	WORD wFIFOSize;

	// Calculate total usable FIFO size
	wFIFOSize = TCBStubs[hTCP].bufferEnd - TCBStubs[hTCP].bufferRxStart;

	// Find out how many data bytes are actually in the RX FIFO
	wDataLen = TCPIsGetReady(hTCP);

	return wFIFOSize - wDataLen;
}

/*********************************************************************
* Function:		WORD TCPFindArray(TCP_SOCKET hTCP, BYTE *cFindArray, WORD wLen, WORD wStart, BOOL bTextCompare)
*
* PreCondition:	TCPInit() is already called
*
* Input:		hTCP       - TCP socket handle
*				cFindArray - Pointer to an array of bytes to look for
*				wLen       - Length of cFindArray
*				wStart	   - Position within the RX FIFO to begin searching. 0 is the beginning of the FIFO.
*				bTextCompare- Search using a case-insensitive algorithm if TRUE, otherwise, do a binary 1 to 1 search
*
* Output:		0xFFFF: Array not found
*				0 to 65534: Location the array was found
*
* Side Effects:	None
*
* Overview:		None
*
* Note:			As an example, if the RX FIFO contains:
*				"PIC MCUs are good." 
*				and cFindArray -> "MCU"
*				and wLen -> 3
*				the value returned by the search function would be 4
********************************************************************/
WORD TCPFindArray(TCP_SOCKET hTCP, BYTE *cFindArray, WORD wLen, WORD wStart, BOOL bTextCompare)
{
	WORD wDataLen;
	WORD wBytesUntilWrap;
	WORD wLocation;
	WORD wLenStart;
	BYTE *cFindArrayStart;
	BYTE i, j, k;
	BYTE buffer[8];
	TCB_STUB *ps;

	if(wLen == 0u)
		return 0u;

	ps = &TCBStubs[hTCP];

	// Find out how many bytes are in the RX FIFO and return 
	// immediately if we won't possibly find a match
	wDataLen = TCPIsGetReady(hTCP);
	if(wDataLen < wLen + wStart)
		return 0xFFFFu;

	wLocation = ps->rxTail + wStart;
	if(wLocation > ps->bufferEnd)
		wLocation -= ps->bufferEnd - ps->bufferRxStart + 1;
	MACSetReadPtr(wLocation);
	wBytesUntilWrap = ps->bufferEnd - wLocation + 1;
	wLocation = wStart;
	wLenStart = wLen;
	cFindArrayStart = cFindArray;
	j = *cFindArray++;
	if(bTextCompare)
	{
		if(j >= 'a' && j <= 'z')
			j += 'A'-'a';
	}

	// Search for the array
	while(1)
	{
		// Figure out how big of a chunk to read
		k = sizeof(buffer);
		if(k > wBytesUntilWrap)
			k = wBytesUntilWrap;
		if((WORD)k > wLen)
			k = wLen;

		// Read a chunk of data into the buffer
		MACGetArray(buffer, (WORD)k);
		wBytesUntilWrap -= k;

		if(wBytesUntilWrap == 0)
		{
			MACSetReadPtr(ps->bufferRxStart);
			wBytesUntilWrap = 0xFFFFu;
		}

		// Convert everything to uppercase
		if(bTextCompare)
		{
			for(i = 0; i < k; i++)
			{
				if(buffer[i] >= 'a' && buffer[i] <= 'z')
					buffer[i] += 'A'-'a';

				if(j == buffer[i])
				{
					if(--wLen == 0)
						return wLocation-wLenStart + i + 1;
					j = *cFindArray++;
					if(j >= 'a' && j <= 'z')
						j += 'A'-'a';
				}
				else
				{
					wLen = wLenStart;
					cFindArray = cFindArrayStart;
					j = *cFindArray++;
					if(j >= 'a' && j <= 'z')
						j += 'A'-'a';
				}
			}
		}
		else	// Compare as is
		{
			for(i = 0; i < k; i++)
			{
				if(j == buffer[i])
				{
					if(--wLen == 0)
						return wLocation-wLenStart + i + 1;
					j = *cFindArray++;
				}
				else
				{
					wLen = wLenStart;
					cFindArray = cFindArrayStart;
					j = *cFindArray++;
				}
			}
		}

		// Check to see if it is impossible to find a match
		wDataLen -= k;
		if(wDataLen < wLen)
			return 0xFFFFu;

		wLocation += k;
	}
}

WORD TCPFindROMArray(TCP_SOCKET hTCP, ROM BYTE *cFindArray, WORD wLen, WORD wStart, BOOL bTextCompare)
{
	WORD wDataLen;
	WORD wBytesUntilWrap;
	WORD wLocation;
	WORD wLenStart;
	ROM BYTE *cFindArrayStart;
	BYTE i, j, k;
	BYTE buffer[8];
	TCB_STUB *ps;

	if(wLen == 0u)
		return 0u;

	ps = &TCBStubs[hTCP];

	// Find out how many bytes are in the RX FIFO and return 
	// immediately if we won't possibly find a match
	wDataLen = TCPIsGetReady(hTCP);
	if(wDataLen < wLen + wStart)
		return 0xFFFFu;

	wLocation = ps->rxTail + wStart;
	if(wLocation > ps->bufferEnd)
		wLocation -= ps->bufferEnd - ps->bufferRxStart + 1;
	MACSetReadPtr(wLocation);
	wBytesUntilWrap = ps->bufferEnd - wLocation + 1;
	wLocation = wStart;
	wLenStart = wLen;
	cFindArrayStart = cFindArray;
	j = *cFindArray++;
	if(bTextCompare)
	{
		if(j >= 'a' && j <= 'z')
			j += 'A'-'a';
	}

	// Search for the array
	while(1)
	{
		// Figure out how big of a chunk to read
		k = sizeof(buffer);
		if(k > wBytesUntilWrap)
			k = wBytesUntilWrap;
		if((WORD)k > wLen)
			k = wLen;

		// Read a chunk of data into the buffer
		MACGetArray(buffer, (WORD)k);
		wBytesUntilWrap -= k;

		if(wBytesUntilWrap == 0)
		{
			MACSetReadPtr(ps->bufferRxStart);
			wBytesUntilWrap = 0xFFFFu;
		}

		// Convert everything to uppercase
		if(bTextCompare)
		{
			for(i = 0; i < k; i++)
			{
				if(buffer[i] >= 'a' && buffer[i] <= 'z')
					buffer[i] += 'A'-'a';

				if(j == buffer[i])
				{
					if(--wLen == 0)
						return wLocation-wLenStart + i + 1;
					j = *cFindArray++;
					if(j >= 'a' && j <= 'z')
						j += 'A'-'a';
				}
				else
				{
					wLen = wLenStart;
					cFindArray = cFindArrayStart;
					j = *cFindArray++;
					if(j >= 'a' && j <= 'z')
						j += 'A'-'a';
				}
			}
		}
		else	// Compare as is
		{
			for(i = 0; i < k; i++)
			{
				if(j == buffer[i])
				{
					if(--wLen == 0)
						return wLocation-wLenStart + i + 1;
					j = *cFindArray++;
				}
				else
				{
					wLen = wLenStart;
					cFindArray = cFindArrayStart;
					j = *cFindArray++;
				}
			}
		}

		// Check to see if it is impossible to find a match
		wDataLen -= k;
		if(wDataLen < wLen)
			return 0xFFFFu;

		wLocation += k;
	}
}

WORD TCPFind(TCP_SOCKET hTCP, BYTE cFind, WORD wStart, BOOL bTextCompare)
{
	return TCPFindArray(hTCP, &cFind, sizeof(cFind), wStart, bTextCompare);
}


/*********************************************************************
* Function:        void TCPTick(void)
*
* PreCondition:    TCPInit() is already called.
*
* Input:           None
*
* Output:          Each socket FSM is executed for any timeout
*                  situation.
*
* Side Effects:    None
*
* Overview:        None
*
* Note:            None
********************************************************************/
void TCPTick(void)
{
	TCP_SOCKET hTCP;
	TCB_STUB *ps;
	BOOL bACKSent;

	// Periodically all "not closed" sockets must perform timed operations
	for(hTCP = 0; hTCP < MAX_TCP_SOCKETS; hTCP++)
	{
		ps = &TCBStubs[hTCP];

		bACKSent = FALSE;

		// Transmit ASAP data if the medium is available
		if(ps->Flags.bTXASAP)
		{
			if(MACIsTxReady())
			{
				LoadTCB(hTCP);
				SendTCP(hTCP, ACK);
				SaveTCB(hTCP);
				bACKSent = TRUE;
			}
		}

		// Perform any needed window updates and data transmissions
		if(ps->Flags.bTimer2Enabled)
		{
			// See if the timeout has occured
			if((SHORT)(ps->eventTime2 - (WORD)TickGet()) <= (SHORT)0)
			{
				// Send out a window update and any bytes waiting in the TX FIFO
				if(!bACKSent)
				{
					LoadTCB(hTCP);
					SendTCP(hTCP, ACK);
					SaveTCB(hTCP);
					bACKSent = TRUE;
				}
			}
		}

		// Process Delayed ACKnowledgement timer
		if(ps->Flags.bDelayedACKTimerEnabled)
		{
			// See if the timeout has occured
			if((SHORT)(ps->delayedACKTime - (WORD)TickGet()) <= (SHORT)0)
			{
				if(!bACKSent)
				{
					// Send out our delayed ACK
					LoadTCB(hTCP);
					SendTCP(hTCP, ACK);
					SaveTCB(hTCP);
					bACKSent = TRUE;
				}
			}
		}

		// The TCP_CLOSED, TCP_LISTEN, and sometimes the TCP_ESTABLISHED 
		// state don't need any timeout events
		if(!ps->Flags.bTimerEnabled)
			continue;

		// If timeout has not occured, do not do anything.
		if((LONG)(TickGet() - ps->eventTime) < (LONG)0)
			continue;

		// Load up extended MyTCB information
		// If bACKSent, then the TCB has already been loaded.  No need to do it again.
		if(!bACKSent)
			LoadTCB(hTCP);

		// This will be one more attempt.
		MyTCB.retryCount++;

		// Update timeout value if there is need to wait longer.
		MyTCB.retryInterval <<= 1;

		// Restart timeout reference.
		ps->eventTime = TickGet() + MyTCB.retryInterval;

		// A timeout has occured.  Respond to this timeout condition
		// depending on what state this socket is in.
		switch(ps->smState)
		{
			case TCP_SYN_SENT:
				// Keep sending SYN until we hear from remote node.
				// This may be for infinite time, in that case
				// caller must detect it and do something.
				MyTCB.retryInterval = TCP_START_TIMEOUT_VAL;
				MyTCB.retryCount = 0;
				SendTCP(hTCP, SYN);
				break;
	
			case TCP_SYN_RECEIVED:
				// We must receive ACK before timeout expires.
				// If not, resend SYN+ACK.
				// Abort, if maximum attempts counts are reached.
				if(MyTCB.retryCount <= MAX_RETRY_COUNTS)
				{
					SendTCP(hTCP, SYN | ACK);
				}
				else
				{
					if(ps->Flags.bServer)
					{
						SendTCP(hTCP, RST);
						CloseSocket(hTCP);
					}
					else
					{
						ps->smState = TCP_SYN_SENT;
						MyTCB.retryInterval = TCP_START_TIMEOUT_VAL;
						MyTCB.retryCount = 0;
						SendTCP(hTCP, SYN);
					}
				}
				break;
	
			case TCP_ESTABLISHED:
				if(MyTCB.txUnackedTail != ps->txTail)
				{
					// Retransmit any unacknowledged data
					if(MyTCB.retryCount <= MAX_RETRY_COUNTS)
					{
						// Roll back unacknowledged TX tail pointer
						MyTCB.MySEQ -= (LONG)(SHORT)(MyTCB.txUnackedTail - ps->txTail);
						if(MyTCB.txUnackedTail < ps->txTail)
							MyTCB.MySEQ -= (LONG)(SHORT)(ps->bufferRxStart - ps->bufferTxStart);
						MyTCB.txUnackedTail = ps->txTail;
	
						SendTCP(hTCP, PSH | ACK);
					}
					else
					{
						// No response back for too long, close connection
						// This could happen, for instance, if the communication 
						// medium was lost
						MyTCB.MySEQ++;
						ps->smState = TCP_FIN_WAIT_1;
						MyTCB.retryInterval = TCP_START_TIMEOUT_VAL;
						MyTCB.retryCount = 0;
	
						SendTCP(hTCP, FIN | ACK);
					}
				}
				break;
	
			case TCP_FIN_WAIT_1:
				if(MyTCB.retryCount <= MAX_RETRY_COUNTS)
				{
					// Roll back unacknowledged TX tail pointer
					MyTCB.MySEQ -= (LONG)(SHORT)(MyTCB.txUnackedTail - ps->txTail);
					if(MyTCB.txUnackedTail < ps->txTail)
						MyTCB.MySEQ -= (LONG)(SHORT)(ps->bufferRxStart - ps->bufferTxStart);
					MyTCB.txUnackedTail = ps->txTail;

					// Send another FIN
					SendTCP(hTCP, FIN | ACK);
				}
				else
				{
					// Close on our own, we can't seem to communicate 
					// with the remote node anymore
					SendTCP(hTCP, RST | ACK);
					CloseSocket(hTCP);
				}
				break;
	
			case TCP_FIN_WAIT_2:
				// Close on our own, we can't seem to communicate 
				// with the remote node anymore
				SendTCP(hTCP, RST | ACK);
				CloseSocket(hTCP);
				break;

			case TCP_CLOSING:
				if(MyTCB.retryCount <= MAX_RETRY_COUNTS)
				{
					// Roll back unacknowledged TX tail pointer
					MyTCB.MySEQ -= (LONG)(SHORT)(MyTCB.txUnackedTail - ps->txTail);
					if(MyTCB.txUnackedTail < ps->txTail)
						MyTCB.MySEQ -= (LONG)(SHORT)(ps->bufferRxStart - ps->bufferTxStart);
					MyTCB.txUnackedTail = ps->txTail;

					// Send another ACK
					SendTCP(hTCP, ACK);
				}
				else
				{
					// Close on our own, we can't seem to communicate 
					// with the remote node anymore
					SendTCP(hTCP, RST | ACK);
					CloseSocket(hTCP);
				}
				break;
	
			case TCP_TIME_WAIT:
				// Wait around for a while (2MSL) and then goto closed state
				CloseSocket(hTCP);
				break;
			
			case TCP_CLOSE_WAIT:
				if(MyTCB.retryCount <= MAX_RETRY_COUNTS)
				{
					// Roll back unacknowledged TX tail pointer
					MyTCB.MySEQ -= (LONG)(SHORT)(MyTCB.txUnackedTail - ps->txTail);
					if(MyTCB.txUnackedTail < ps->txTail)
						MyTCB.MySEQ -= (LONG)(SHORT)(ps->bufferRxStart - ps->bufferTxStart);
					MyTCB.txUnackedTail = ps->txTail;

					// Send ACK
					SendTCP(hTCP, ACK);
				}
				else
				{
					// We shouldn't get down here if the application properly closes the connection.
					// However, if it doesn't, we still need to ensure socket reuse, so let's forcefully close the socket.
					SendTCP(hTCP, RST | ACK);
					CloseSocket(hTCP);
				}
				break;
	
			case TCP_LAST_ACK:
				// Send some more FINs or close anyway
				if(MyTCB.retryCount <= MAX_RETRY_COUNTS)
				{
					SendTCP(hTCP, FIN | ACK);
				}
				else
				{
					SendTCP(hTCP, RST | ACK);
					CloseSocket(hTCP);
				}
				break;
		}

		SaveTCB(hTCP);
	}
}



/*********************************************************************
* Function:        BOOL TCPProcess(NODE_INFO* remote,
*                                  IP_ADDR *localIP,
*                                  WORD len)
*
* PreCondition:    TCPInit() is already called     AND
*                  TCP segment is ready in MAC buffer
*
* Input:           remote      - Remote node info
*                  len         - Total length of TCP semgent.
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
BOOL TCPProcess(NODE_INFO *remote, IP_ADDR *localIP, WORD len)
{
	TCP_HEADER      TCPHeader;
	PSEUDO_HEADER   pseudoHeader;
	TCP_SOCKET      socket;
	WORD_VAL        checksum1;
	WORD_VAL        checksum2;
	BYTE            optionsSize;

	// Calculate IP pseudoheader checksum.
	pseudoHeader.SourceAddress      = remote->IPAddr;
	pseudoHeader.DestAddress        = *localIP;
	pseudoHeader.Zero               = 0x0;
	pseudoHeader.Protocol           = IP_PROT_TCP;
	pseudoHeader.TCPLength          = len;

	SwapPseudoTCPHeader(pseudoHeader);

	checksum1.Val = ~CalcIPChecksum((BYTE*)&pseudoHeader,
		sizeof(pseudoHeader));

	// Now calculate TCP packet checksum in NIC RAM - should match
	// pesudo header checksum
	checksum2.Val = CalcIPBufferChecksum(len);

	// Compare checksums.
	if(checksum1.Val != checksum2.Val)
	{
		MACDiscardRx();
		return TRUE;
	}

	// Retrieve TCP header.
	IPSetRxBuffer(0);
	MACGetArray((BYTE*)&TCPHeader, sizeof(TCPHeader));
	SwapTCPHeader(&TCPHeader);


	// Skip over options to retrieve data bytes
	optionsSize = (BYTE)((TCPHeader.DataOffset.Val << 2)-
		sizeof(TCPHeader));
	len = len - optionsSize - sizeof(TCPHeader);

	// Find matching socket.
	socket = FindMatchingSocket(&TCPHeader, remote);
	if(socket != INVALID_SOCKET)
	{
		HandleTCPSeg(socket, &TCPHeader, len);
		SaveTCB(socket);
	}
	else
	{
		// If this is an unknown socket, or we don't have any 
		// listening sockets available, discard it.  We can't 
		// process it right now.
		MACDiscardRx();
	}

	return TRUE;
}


/*********************************************************************
* Function:        static void SendTCP(TCP_SOCKET hTCP, BYTE flags)
*
* PreCondition:    TCPInit() is already called
*				   LoadTCP() is called with the value of hTCP
*
* Input:           hTCP: Handle of socket to send packet with
*				   flags: Additional TCP flags to include
*
* Output:          A TCP segment is assembled and transmitted
*
* Side Effects:    None
*
* Overview:        None
*
* Note:            Function does not save the MyTCB data.  It is 
*				   the caller's responsibility to save it.
********************************************************************/
static void SendTCP(TCP_SOCKET hTCP, BYTE flags)
{
	TCB_STUB		*ps;
	WORD_VAL        wVal;
	TCP_HEADER      header;
	TCP_OPTIONS     options;
	PSEUDO_HEADER   pseudoHeader;
	WORD 			len;
	WORD			wEffectiveWindow;
	
	ps = &TCBStubs[hTCP];

	// Status will now be synched, disable automatic future 
	// status transmissions
	ps->Flags.bTimer2Enabled = 0;
	ps->Flags.bTXASAP = 0;
	ps->Flags.bDelayedACKTimerEnabled = 0;
	ps->Flags.bOneSegmentReceived = 0;

	//  Make sure that we can write to the MAC transmit area
	while(!IPIsTxReady());

	// Put all socket application data in the TX space
	if(flags & SYN)
	{
		// Don't put any data for SYN messages
		len = 0;
	}
	else
	{
		// Begin copying any application data over to the TX space
		if(ps->txHead == MyTCB.txUnackedTail)
		{
			len = 0;
		}
		else if(ps->txHead > MyTCB.txUnackedTail)
		{
			len = ps->txHead - MyTCB.txUnackedTail;
			wEffectiveWindow = MyTCB.remoteWindow;
			if(MyTCB.txUnackedTail >= ps->txTail)
				wEffectiveWindow -= MyTCB.txUnackedTail - ps->txTail;
			else
				wEffectiveWindow -= (ps->bufferRxStart - ps->bufferTxStart) - (ps->txTail - MyTCB.txUnackedTail);

			if(len > wEffectiveWindow)
				len = wEffectiveWindow;

			if(len > 576)
			{
				len = 576;
				ps->Flags.bTXASAP = 1;
			}

			MACMemCopyAsync(BASE_TX_ADDR+sizeof(ETHER_HEADER)+sizeof(IP_HEADER)+sizeof(TCP_HEADER), MyTCB.txUnackedTail, len);
			MyTCB.txUnackedTail += len;
		}
		else
		{
			pseudoHeader.TCPLength = ps->bufferRxStart - MyTCB.txUnackedTail;
			len = pseudoHeader.TCPLength + ps->txHead - ps->bufferTxStart;

			wEffectiveWindow = MyTCB.remoteWindow;
			if(MyTCB.txUnackedTail >= ps->txTail)
				wEffectiveWindow -= MyTCB.txUnackedTail - ps->txTail;
			else
				wEffectiveWindow -= (ps->bufferRxStart - ps->bufferTxStart) - (ps->txTail - MyTCB.txUnackedTail);
				
			if(len > wEffectiveWindow)
				len = wEffectiveWindow;

			if(len > 576)
			{
				len = 576;
				ps->Flags.bTXASAP = 1;
			}

			if(pseudoHeader.TCPLength > wEffectiveWindow)
				pseudoHeader.TCPLength = wEffectiveWindow;

			if(pseudoHeader.TCPLength > 576)
				pseudoHeader.TCPLength = 576;

			MACMemCopyAsync(BASE_TX_ADDR+sizeof(ETHER_HEADER)+sizeof(IP_HEADER)+sizeof(TCP_HEADER), MyTCB.txUnackedTail, pseudoHeader.TCPLength);
			pseudoHeader.TCPLength = len - pseudoHeader.TCPLength;
	
			// Copy any left over chunks of application data over
			if(pseudoHeader.TCPLength)
			{
				MACMemCopyAsync(BASE_TX_ADDR+sizeof(ETHER_HEADER)+sizeof(IP_HEADER)+sizeof(TCP_HEADER)+(ps->bufferRxStart-MyTCB.txUnackedTail), ps->bufferTxStart, pseudoHeader.TCPLength);
			}

			MyTCB.txUnackedTail += len;
			if(MyTCB.txUnackedTail >= ps->bufferRxStart)
				MyTCB.txUnackedTail -= ps->bufferRxStart-ps->bufferTxStart;
		}
	}
	
	header.SourcePort			= MyTCB.localPort.Val;
	header.DestPort				= MyTCB.remotePort.Val;
	if(flags & (SYN | FIN))
		header.SeqNumber		= MyTCB.MySEQ-1;
	else
	header.SeqNumber			= MyTCB.MySEQ;
	header.AckNumber			= MyTCB.RemoteSEQ;
	header.Flags.bits.Reserved2	= 0;
	header.DataOffset.Reserved3	= 0;
	header.Flags.byte			= flags;
	header.UrgentPointer        = 0;

	// For next time
	MyTCB.MySEQ += (DWORD)len;

	// Calculate the amount of free space in the RX buffer area of this socket
	if(ps->rxHead >= ps->rxTail)
		header.Window = (ps->bufferEnd - ps->bufferRxStart) - (ps->rxHead - ps->rxTail);
	else
		header.Window = ps->rxTail - ps->rxHead - 1;

	// Calculate the amount of free space in the MAC RX buffer area and adjust window if needed
	wVal.Val = MACGetFreeRxSize()-64;
	if((SHORT)wVal.Val < (SHORT)0)
		wVal.Val = 0;
	// Force the remote node to throttle back if we are running low on general RX buffer space
//	if(header.Window > wVal.Val)
	if((header.Window > wVal.Val) && (wVal.Val < 2000))
		header.Window = wVal.Val;

	SwapTCPHeader(&header);


	len += sizeof(header);

	header.DataOffset.Val   = sizeof(header) >> 2;
	if(flags & SYN)
	{
		len += sizeof(options);
		options.Kind = TCP_OPTIONS_MAX_SEG_SIZE;
		options.Length = 0x04;

		// Load MSS and swap to big endian
		options.MaxSegSize.Val = 0x4002;	// 576

		header.DataOffset.Val   += sizeof(options) >> 2;
	}

	// Calculate IP pseudoheader checksum.
	pseudoHeader.SourceAddress	= AppConfig.MyIPAddr;
	pseudoHeader.DestAddress    = MyTCB.remote.IPAddr;
	pseudoHeader.Zero           = 0x0;
	pseudoHeader.Protocol       = IP_PROT_TCP;
	pseudoHeader.TCPLength		= len;

	SwapPseudoTCPHeader(pseudoHeader);

	header.Checksum = ~CalcIPChecksum((BYTE*)&pseudoHeader, sizeof(pseudoHeader));

	MACSetWritePtr(BASE_TX_ADDR + sizeof(ETHER_HEADER));

	// Write IP header.
	IPPutHeader(&MyTCB.remote, IP_PROT_TCP, len);
	MACPutArray((BYTE*)&header, sizeof(header));
	if(flags & SYN)
		MACPutArray((BYTE*)&options, sizeof(options));

	MACSetReadPtr(BASE_TX_ADDR + sizeof(ETHER_HEADER) + sizeof(IP_HEADER));
	wVal.Val = CalcIPBufferChecksum(len);

	// Update the TCP checksum and begin transmission of the packet
	MACSetWritePtr(BASE_TX_ADDR + sizeof(ETHER_HEADER) + sizeof(IP_HEADER) + 16);
	MACPutArray((BYTE*)&wVal, sizeof(WORD));

	while(!MACIsMemCopyDone());
	MACFlush();
}



/*********************************************************************
* Function:        static TCP_SOCKET FindMatchingSocket(TCP_HEADER *h,
*                                      NODE_INFO* remote)
*
* PreCondition:    TCPInit() is already called
*
* Input:           h           - TCP Header to be matched against.
*                  remote      - Node who sent this header.
*
* Output:          A socket that matches with given header and remote
*                  node is searched.
*                  If such socket is found, its index is returned
*                  else INVALID_SOCKET is returned.
*
* Side Effects:    None
*
* Overview:        None
*
* Note:            None
********************************************************************/
static TCP_SOCKET FindMatchingSocket(TCP_HEADER *h, NODE_INFO *remote)
{
	TCB_STUB *ps;
	TCP_SOCKET hTCP;
	TCP_SOCKET partialMatch;
	WORD hash;

	partialMatch = INVALID_SOCKET;
	hash = (remote->IPAddr.w[1]+remote->IPAddr.w[0] + h->SourcePort) ^ h->DestPort;

	for(hTCP = 0; hTCP < MAX_TCP_SOCKETS; hTCP++ )
	{
		ps = &TCBStubs[hTCP];

		if(ps->smState == TCP_CLOSED)
		{
			continue;
		}
		else if(ps->smState == TCP_LISTEN)
		{
			if(ps->remoteHash.Val == h->DestPort)
				partialMatch = hTCP;
			continue;
		}
		else if(ps->remoteHash.Val != hash)
		{
			continue;
		}

		LoadTCB(hTCP);
		if(	h->DestPort == MyTCB.localPort.Val &&
			h->SourcePort == MyTCB.remotePort.Val &&
			remote->IPAddr.Val == MyTCB.remote.IPAddr.Val)
		{
			return hTCP;
		}
	}

	// We are not listening on this port, nor is a socket using it
	if(partialMatch == INVALID_SOCKET)
		return INVALID_SOCKET;

	// Set up the extended TCB with the info needed to establish a 
	// connection and return this socket to the caller
	ps = &TCBStubs[partialMatch];

	ps->remoteHash.Val = hash;
	ps->txHead = ps->bufferTxStart;
	ps->txTail = ps->bufferTxStart;
	ps->rxHead = ps->bufferRxStart;
	ps->rxTail = ps->bufferRxStart;
	ps->Flags.bTimerEnabled = FALSE;

	memcpy((void*)&MyTCB.remote, (void*)remote, sizeof(NODE_INFO));
	MyTCB.remotePort.Val = h->SourcePort;
	MyTCB.localPort.Val = h->DestPort;
	((DWORD_VAL*)(&MyTCB.MySEQ))->w[0] = rand();
	((DWORD_VAL*)(&MyTCB.MySEQ))->w[1] = rand();
	MyTCB.txUnackedTail	= ps->bufferTxStart;

	return partialMatch;
}



/*********************************************************************
* Function:        static void SwapTCPHeader(TCP_HEADER* header)
*
* PreCondition:    None
*
* Input:           header      - TCP Header to be swapped.
*
* Output:          Given header is swapped.
*
* Side Effects:    None
*
* Overview:        None
*
* Note:            None
********************************************************************/
static void SwapTCPHeader(TCP_HEADER* header)
{
	header->SourcePort      = swaps(header->SourcePort);
	header->DestPort        = swaps(header->DestPort);
	header->SeqNumber       = swapl(header->SeqNumber);
	header->AckNumber       = swapl(header->AckNumber);
	header->Window          = swaps(header->Window);
	header->Checksum        = swaps(header->Checksum);
	header->UrgentPointer   = swaps(header->UrgentPointer);
}



/*********************************************************************
* Function:        static void CloseSocket(TCP_SOCKET hTCP)
*
* PreCondition:    TCPInit() is already called
*				   LoadTCB() must be called with the value of hTCP
*
* Input:           hTCP  - Handle of socket to close/reinitialize
*
* Output:          Given socket information is reset and any
*                  buffered bytes held by this socket are discarded.
*
* Side Effects:    None
*
* Overview:        None
*
* Note:            Function does not save the MyTCB data.  It is 
*				   the caller's responsibility to save it.
********************************************************************/
static void CloseSocket(TCP_SOCKET hTCP)
{
	TCB_STUB *ps;
	
	ps = &TCBStubs[hTCP];

	ps->smState = ps->Flags.bServer ? TCP_LISTEN : TCP_CLOSED;
	ps->Flags.bTimerEnabled = FALSE;
	ps->Flags.bTimer2Enabled = FALSE;
	ps->Flags.bDelayedACKTimerEnabled = FALSE;
	ps->Flags.bOneSegmentReceived = FALSE;
	ps->Flags.bHalfFullFlush = FALSE;
	ps->Flags.bTXASAP = FALSE;
	ps->remoteHash.Val = MyTCB.localPort.Val;
	ps->txTail = ps->bufferTxStart;
	ps->txHead = ps->bufferTxStart;
	ps->rxTail = ps->bufferRxStart;
	ps->rxHead = ps->bufferRxStart;
	MyTCB.txUnackedTail = ps->bufferTxStart;
	((DWORD_VAL*)(&MyTCB.MySEQ))->w[0] = rand();
	((DWORD_VAL*)(&MyTCB.MySEQ))->w[1] = rand();
}



/*********************************************************************
* Function:        static void HandleTCPSeg(TCP_SOCKET hTCP, TCP_HEADER *h, WORD len)
*
* PreCondition:    TCPInit() is already called     AND
*                  TCPProcess() is the caller.
*
* Input:           hTCP        - Socket that owns this segment
*                  h           - TCP Header
*                  len         - Total buffer length.
*
* Output:          TCP FSM is executed on given socket with
*                  given TCP segment.
*
* Side Effects:    None
*
* Overview:        None
*
* Note:            None
********************************************************************/
static void HandleTCPSeg(TCP_SOCKET hTCP, TCP_HEADER *h, WORD len)
{
	DWORD dwTemp;
	WORD wTemp;
	LONG lMissingBytes;
	WORD wMissingBytes;
	WORD wFreeSpace;
	TCB_STUB *ps;
	BYTE flags;

	ps = &TCBStubs[hTCP];
	flags = 0x00;


	// Reset FSM, if RST is received.
	if(h->Flags.bits.flagRST)
	{
		SendTCP(hTCP, RST);
		CloseSocket(hTCP);
		MACDiscardRx();
		return;
	}

	// Update the local stored copy of the RemoteWindow
	// If previously we had a zero window, and now we don't 
	// immediately send whatever was panding
	if((MyTCB.remoteWindow == 0u) && h->Window)
		ps->Flags.bTXASAP = 1;
	MyTCB.remoteWindow = h->Window;


	switch(ps->smState)
	{
		case TCP_LISTEN:
			if(!h->Flags.bits.flagSYN)
			{
				SendTCP(hTCP, RST);
				CloseSocket(hTCP);
				break;
			}
			
			flags = SYN | ACK;
			ps->smState = TCP_SYN_RECEIVED;

			// Clear timeout info
			MyTCB.retryCount = 0;
			MyTCB.retryInterval = TCP_START_TIMEOUT_VAL;
			ps->eventTime = TickGet() + TCP_START_TIMEOUT_VAL;
			ps->Flags.bTimerEnabled = TRUE;

			// We now have a sequence number for the remote node
			MyTCB.RemoteSEQ = h->SeqNumber + 1;

			break;

		case TCP_SYN_SENT:
			if(!h->Flags.bits.flagSYN)
				break;

			if(h->Flags.bits.flagACK)
			{
				// If SYN+ACK, we may need to go to TCP_ESTABLISHED state
				if(h->AckNumber == MyTCB.MySEQ)
				{
					flags = ACK;
					ps->smState = TCP_ESTABLISHED;
					ps->Flags.bTimerEnabled = FALSE;

					// Check for application data and make it 
					// available, if present
					flags |= ProcessRXBytes(ps, h, len);
				}
				else
				{
					// ACK number incorrect: ignore this packet
					flags = RST;
					break;
				}
			}
			else
			{
				// Got SYN without ACK, need to go to TCP_SYN_RECEIVED state
				flags = SYN | ACK;
				ps->smState = TCP_SYN_RECEIVED;

				// Clear timeout info
				MyTCB.retryCount  = 0;
				MyTCB.retryInterval = TCP_START_TIMEOUT_VAL;
				ps->eventTime = TickGet() + TCP_START_TIMEOUT_VAL;
			}

			// We now have a sequence number for the remote node
			MyTCB.RemoteSEQ = h->SeqNumber + 1;

			break;

		case TCP_SYN_RECEIVED:
			if(h->Flags.bits.flagACK && (h->AckNumber == MyTCB.MySEQ))
			{
				ps->smState = TCP_ESTABLISHED;
				ps->Flags.bTimerEnabled = FALSE;

				// Check for application data and make it 
				// available, if present
				flags |= ProcessRXBytes(ps, h, len);
			}

			break;

		case TCP_ESTABLISHED:
			// Check for application data and make it 
			// available, if present
			flags |= ProcessRXBytes(ps, h, len);

			// Handle any requests to close the connection
			if(h->Flags.bits.flagFIN)
			{
				MyTCB.RemoteSEQ++;

				if(len == 0u)
				{
					flags = FIN | ACK;
					MyTCB.MySEQ++;
					ps->smState = TCP_LAST_ACK;
				}
				else
				{
					// Don't send a FIN back immediately.  The application 
					// may want to send a little bit more data before closing 
					// the socket.
					flags = ACK;
					ps->smState = TCP_CLOSE_WAIT;
				}

				// Clear timeout info
				MyTCB.retryCount  = 0;
				MyTCB.retryInterval = TCP_START_TIMEOUT_VAL;
				ps->eventTime = TickGet() + TCP_START_TIMEOUT_VAL;
				ps->Flags.bTimerEnabled = TRUE;
			}

			break;

		case TCP_FIN_WAIT_1:
			if(h->Flags.bits.flagFIN && h->Flags.bits.flagACK && (h->AckNumber == MyTCB.MySEQ))
			{
				MyTCB.RemoteSEQ++;
				flags = ACK;
				ps->smState = TCP_TIME_WAIT;
				ps->eventTime = TickGet() + TCP_TIME_WAIT_TIMEOUT_VAL;
			}
			else if(h->Flags.bits.flagACK && (h->AckNumber == MyTCB.MySEQ))
			{
				ps->smState = TCP_FIN_WAIT_2;
			}
			else if(h->Flags.bits.flagFIN)
			{
				MyTCB.RemoteSEQ++;
				flags = ACK;
				ps->smState = TCP_CLOSING;

				// Clear timeout info
				MyTCB.retryCount  = 0;
				MyTCB.retryInterval = TCP_START_TIMEOUT_VAL;
				ps->eventTime = TickGet() + TCP_START_TIMEOUT_VAL;
			}

			// Check for application data and make it 
			// available, if present
			flags |= ProcessRXBytes(ps, h, len);

			break;

		case TCP_FIN_WAIT_2:
			if(h->Flags.bits.flagFIN)
			{
				MyTCB.RemoteSEQ++;
				flags = ACK;
				ps->smState = TCP_TIME_WAIT;
				ps->eventTime = TickGet() + TCP_TIME_WAIT_TIMEOUT_VAL;
			}

			// Check for application data and make it 
			// available, if present
			flags |= ProcessRXBytes(ps, h, len);

			break;

		case TCP_CLOSING:
			if(h->Flags.bits.flagACK && (h->AckNumber == MyTCB.MySEQ))
			{
				ps->smState = TCP_TIME_WAIT;
				ps->eventTime = TickGet() + TCP_TIME_WAIT_TIMEOUT_VAL;
			}

			// Check for application data and make it 
			// available, if present
			flags |= ProcessRXBytes(ps, h, len);

			break;

		case TCP_CLOSE_WAIT:
			flags = ACK;
			break;

		case TCP_LAST_ACK:
			if(h->Flags.bits.flagACK && (h->AckNumber == MyTCB.MySEQ))
			{
				CloseSocket(hTCP);
			}
			break;

		case TCP_TIME_WAIT:
			flags = RST;
			break;
	}


	// Throw away all ACKnowledged TX data
	if(h->Flags.bits.flagACK && (ps->smState != TCP_CLOSED) && (ps->smState != TCP_LISTEN))
	{
		// Calculate what the last acknowledged sequence number was
		dwTemp = MyTCB.MySEQ - (LONG)(SHORT)(MyTCB.txUnackedTail - ps->txTail);
		if(MyTCB.txUnackedTail < ps->txTail)
			dwTemp -= ps->bufferRxStart - ps->bufferTxStart;

		// Calcluate how many bytes were ACKed with this packet
		dwTemp = h->AckNumber - dwTemp;
		if(((LONG)(dwTemp) > 0) && (dwTemp <= ps->bufferRxStart - ps->bufferTxStart))
		{
			ps->Flags.bHalfFullFlush = FALSE;

			// Bytes ACKed, free up the TX FIFO space
			ps->txTail += dwTemp;
			if(ps->txTail >= ps->bufferRxStart)
			{
				ps->txTail -= ps->bufferRxStart - ps->bufferTxStart;
			}

			// No need to keep our retransmit timer going if we having nothing that needs ACKing anymore
			if((ps->smState == TCP_ESTABLISHED) && (ps->txTail == MyTCB.txUnackedTail))
				ps->Flags.bTimerEnabled = FALSE;
		}
	}


	while(!MACIsMemCopyDone());
	MACDiscardRx();

	if(flags)
		SendTCP(hTCP, flags);
}

/*********************************************************************
* Function:		static BYTE ProcessRXBytes(TCB_STUB *ps, TCP_HEADER *h, WORD len)
*
* PreCondition:	None
*
* Input:        *ps: Pointer to the current TCB_STUB which needs processing
*				*h: Pointer to the TCP_HEADER of the TCP packet we received
*				len: Number of TCP application layer bytes available
*
* Output:		BYTE: Flags that should be transmitted back
*
* Side Effects:	None
*
* Overview:		None
*
* Note:			This is an internal TCP layer function only.
********************************************************************/
static BYTE ProcessRXBytes(TCB_STUB *ps, TCP_HEADER *h, WORD len)
{
	WORD wTemp;
	LONG lMissingBytes;
	WORD wMissingBytes;
	WORD wFreeSpace;

	// Check for application data and make it 
	// available, if present
	if(!len)
		return 0x00;

	// Calculate the number of bytes ahead of our head pointer this segment skips
	lMissingBytes = h->SeqNumber - MyTCB.RemoteSEQ;
	wMissingBytes = (WORD)lMissingBytes;
	
	// Calculate the RX FIFO space
	if(ps->rxHead >= ps->rxTail)
		wFreeSpace = (ps->bufferEnd - ps->bufferRxStart) - (ps->rxHead - ps->rxTail);
	else
		wFreeSpace = ps->rxTail - ps->rxHead - 1;
	
	// See if any of the segment data is within our RX window
	if(((LONG)wFreeSpace > lMissingBytes) && ((SHORT)wMissingBytes + (SHORT)len > (SHORT)0))
	{
		// See if there are bytes we must skip
		if((SHORT)wMissingBytes <= 0)
		{
			// Position packet read pointer to start of useful data area.
			IPSetRxBuffer((h->DataOffset.Val << 2) - wMissingBytes);
			len += wMissingBytes;
			MyTCB.RemoteSEQ += (DWORD)len;
	
			// Copy the application data from the packet into the socket RX FIFO
			// See if we need a two part copy (spans bufferEnd->bufferRxStart)
			if(ps->rxHead + len > ps->bufferEnd)
			{
				wTemp = ps->bufferEnd - ps->rxHead + 1;
				MACMemCopyAsync(ps->rxHead, -1, wTemp);
				MACMemCopyAsync(ps->bufferRxStart, -1, len - wTemp);
				ps->rxHead = ps->bufferRxStart + (len - wTemp);
			}
			else
			{
				MACMemCopyAsync(ps->rxHead, -1, len);
				ps->rxHead += len;
			}
	
			// See if we have a hole and other data waiting already in the RX FIFO
			if(MyTCB.sHoleSize != -1)
			{
				MyTCB.sHoleSize -= len;
				wTemp = MyTCB.wFutureDataSize + MyTCB.sHoleSize;
	
				// See if we just closed up a hole, and if so, advance head pointer
				if((SHORT)wTemp < (SHORT)0)
				{
					MyTCB.sHoleSize = -1;
				}
				else if(MyTCB.sHoleSize <= 0)
				{
					MyTCB.RemoteSEQ += wTemp;
					ps->rxHead += wTemp;
					if(ps->rxHead > ps->bufferEnd)
						ps->rxHead -= ps->bufferEnd - ps->bufferRxStart + 1;							
					MyTCB.sHoleSize = -1;
				}
			}
		} // This packet is out of order or we lost a packet, see if we can generate a hole to accomodate it
		else if((SHORT)wMissingBytes > 0)
		{
			// Position packet read pointer to start of useful data area.
			IPSetRxBuffer(h->DataOffset.Val << 2);
	
			// See if we need a two part copy (spans bufferEnd->bufferRxStart)
			if(ps->rxHead + wMissingBytes + len > ps->bufferEnd)
			{
				// Calculate number of data bytes to copy before wraparound
				wTemp = ps->bufferEnd - ps->rxHead + 1 - wMissingBytes;
				if((SHORT)wTemp >= 0)
				{
					MACMemCopyAsync(ps->rxHead + wMissingBytes, -1, wTemp);
					MACMemCopyAsync(ps->bufferRxStart, -1, len - wTemp);
				}
				else
				{
					MACMemCopyAsync(ps->rxHead + wMissingBytes - (ps->bufferEnd - ps->bufferRxStart + 1), -1, len);
				}
			}
			else
			{
				MACMemCopyAsync(ps->rxHead + wMissingBytes, -1, len);
			}
		
			// Record the hole is here
			if(MyTCB.sHoleSize == -1)
			{
				MyTCB.sHoleSize = wMissingBytes;
				MyTCB.wFutureDataSize = len;
			}
			else
			{
				// We already have a hole, see if we can shrink the hole 
				// or extend the future data size
				if(wMissingBytes < (WORD)MyTCB.sHoleSize)
				{
					if((wMissingBytes + len > (WORD)MyTCB.sHoleSize + MyTCB.wFutureDataSize) || (wMissingBytes + len < (WORD)MyTCB.sHoleSize))
						MyTCB.wFutureDataSize = len;
					else
						MyTCB.wFutureDataSize = (WORD)MyTCB.sHoleSize + MyTCB.wFutureDataSize - wMissingBytes;
					MyTCB.sHoleSize = wMissingBytes;
				}
				else if(wMissingBytes + len > (WORD)MyTCB.sHoleSize + MyTCB.wFutureDataSize)
				{
					MyTCB.wFutureDataSize += wMissingBytes + len - (WORD)MyTCB.sHoleSize - MyTCB.wFutureDataSize;
				}
				
			}

			// Request a fast retransmit from remote node by sending three duplicate ACKs
			//SendTCP(hTCP, ACK);
			//while(!MACIsTxReady());
			//MACFlush();
			//while(!MACIsTxReady());
			//MACFlush();
		}
	}

	// Make sure that we immediately send back an ack for the 
	// second segment received
	if(ps->Flags.bOneSegmentReceived)
		return ACK;

	ps->Flags.bOneSegmentReceived = TRUE;	

	// Do not send an ACK immediately back.  Instead, we will 
	// perform delayed acknowledgements.  To do this, we will 
	// just start a timer
	if(!ps->Flags.bDelayedACKTimerEnabled)
	{
		ps->Flags.bDelayedACKTimerEnabled = TRUE;
		ps->delayedACKTime = (WORD)TickGet() + (WORD)(TICK_SECOND/5);
	}
	
	return 0;
}

#endif //#if defined(STACK_USE_TCP)
