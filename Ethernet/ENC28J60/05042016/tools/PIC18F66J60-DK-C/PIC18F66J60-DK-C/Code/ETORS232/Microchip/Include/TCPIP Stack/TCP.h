/*********************************************************************
 *
 *                  TCP Module Defs for Microchip TCP/IP Stack
 *
 *********************************************************************
 * FileName:        TCP.h
 * Dependencies:    StackTsk.h
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
 * Howard Schlunder		11/30/06	See "TCPIP Stack Version.txt" file
 ********************************************************************/
#ifndef __TCP_H
#define __TCP_H


typedef BYTE TCP_SOCKET;

#define INVALID_SOCKET      (0xFE)
#define UNKNOWN_SOCKET      (0xFF)

// TCP States as defined by RFC 793
typedef enum _TCP_STATE
{
    TCP_LISTEN = 0,
    TCP_SYN_SENT,
    TCP_SYN_RECEIVED,
    TCP_ESTABLISHED,
    TCP_FIN_WAIT_1,
    TCP_FIN_WAIT_2,
    TCP_CLOSING,
    TCP_TIME_WAIT,
	TCP_CLOSE_WAIT,
    TCP_LAST_ACK,
    TCP_CLOSED,
} TCP_STATE;

// TCP Control Block (TCB) Information
// Stubs are stored in local PIC RAM
// Current size is 26 bytes
typedef struct _TCB_STUB
{
	WORD_VAL remoteHash;	// Hash consists of remoteIP, remotePort, localPort for connected sockets.  It is a localPort number only for listening server sockets.
	WORD bufferTxStart;		// TCB is located sizeof(TCB) bytes before this address
	WORD bufferRxStart;
	WORD bufferEnd;
	WORD txHead;
	WORD txTail;
	WORD rxHead;
	WORD rxTail;
    TICK eventTime;			// Packet retransmissions, state changes
	WORD eventTime2;		// Window updates, automatic transmission
	WORD delayedACKTime;	// Delayed Acknowledgement timer
    TCP_STATE smState;
    struct
    {
        unsigned char bServer : 1;
		unsigned char bTimerEnabled	: 1;
		unsigned char bTimer2Enabled : 1;
		unsigned char bDelayedACKTimerEnabled : 1;
		unsigned char bOneSegmentReceived : 1;
		unsigned char bHalfFullFlush : 1;
		unsigned char bTXASAP : 1;
    } Flags;
} TCB_STUB;

// The rest of the TCB is stored in Ethernet buffer RAM
// Current size is 35 bytes
typedef struct _TCB
{
	NODE_INFO remote;
    WORD_VAL remotePort;
    WORD_VAL localPort;

	WORD txUnackedTail;
	WORD remoteWindow;
	DWORD MySEQ;
	DWORD RemoteSEQ;
	BYTE retryCount;
	TICK retryInterval;
	SHORT sHoleSize;
	WORD wFutureDataSize;
} TCB;

typedef struct _SOCKET_INFO
{
	NODE_INFO remote;
	WORD_VAL remotePort;
} SOCKET_INFO;

#undef RESERVED_TCP_MEMORY
#define RESERVED_TCP_MEMORY	((DWORD)MAX_TCP_SOCKETS*((DWORD)(TCP_TX_FIFO_SIZE+1)+(DWORD)TCP_RX_FIFO_SIZE+(DWORD)sizeof(TCB)))

#if !defined(__TCP_C)
extern TCB_STUB TCBStubs[MAX_TCP_SOCKETS];
#endif


void TCPInit(void);
SOCKET_INFO* TCPGetRemoteInfo(TCP_SOCKET hTCP);
TCP_SOCKET TCPListen(WORD port);
TCP_SOCKET TCPConnect(NODE_INFO *remote, WORD port);
BOOL TCPIsConnected(TCP_SOCKET hTCP);
void TCPDisconnect(TCP_SOCKET hTCP);
WORD TCPIsPutReady(TCP_SOCKET hTCP);
BOOL TCPPut(TCP_SOCKET hTCP, BYTE byte);
WORD TCPPutArray(TCP_SOCKET hTCP, BYTE *Data, WORD Len);
WORD TCPPutROMArray(TCP_SOCKET hTCP, ROM BYTE *Data, WORD Len);
BYTE* TCPPutString(TCP_SOCKET hTCP, BYTE *Data);
ROM BYTE* TCPPutROMString(TCP_SOCKET hTCP, ROM BYTE *Data);
WORD TCPIsGetReady(TCP_SOCKET hTCP);
WORD TCPGetRxFIFOFree(TCP_SOCKET hTCP);
BOOL TCPGet(TCP_SOCKET hTCP, BYTE *byte);
WORD TCPGetArray(TCP_SOCKET hTCP, BYTE *buffer, WORD count);
WORD TCPFind(TCP_SOCKET hTCP, BYTE cFind, WORD wStart, BOOL bTextCompare);
WORD TCPFindROMArray(TCP_SOCKET hTCP, ROM BYTE *cFindArray, WORD wLen, WORD wStart, BOOL bTextCompare);
WORD TCPFindArray(TCP_SOCKET hTCP, BYTE *cFindArray, WORD wLen, WORD wStart, BOOL bTextCompare);
void TCPDiscard(TCP_SOCKET hTCP);
BOOL TCPProcess(NODE_INFO *remote, IP_ADDR *localIP, WORD len);
void TCPTick(void);
void TCPFlush(TCP_SOCKET hTCP);



#endif
