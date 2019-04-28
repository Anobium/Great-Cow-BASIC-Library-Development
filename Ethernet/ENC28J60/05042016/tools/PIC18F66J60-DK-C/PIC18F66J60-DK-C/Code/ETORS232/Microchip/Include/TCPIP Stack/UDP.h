/*********************************************************************
 *
 *                  UDP Module Defs for Microchip TCP/IP Stack
 *
 *********************************************************************
 * FileName:        UDP.h
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
 ********************************************************************/
#ifndef __UDP_H
#define __UDP_H


typedef WORD UDP_PORT;
typedef BYTE UDP_SOCKET;

typedef struct _UDP_SOCKET_INFO
{
    NODE_INFO   remoteNode;
    UDP_PORT    remotePort;
    UDP_PORT    localPort;
    WORD        TxCount;
    WORD        RxCount;

    struct
    {
        unsigned char bFirstRead     : 1;
    } Flags;

} UDP_SOCKET_INFO;


#define INVALID_UDP_SOCKET      (0xffu)
#define INVALID_UDP_PORT        (0ul)

/*
 * All module utilizing UDP module will get extern definition of
 * activeUDPSocket.  While UDP module itself will define activeUDPSocket.
 */
#if !defined(__UDP_C)
    extern UDP_SOCKET activeUDPSocket;
    extern UDP_SOCKET_INFO  UDPSocketInfo[MAX_UDP_SOCKETS];
#endif


typedef struct _UDP_HEADER
{
    UDP_PORT    SourcePort;
    UDP_PORT    DestinationPort;
    WORD        Length;
    WORD        Checksum;
} UDP_HEADER;


void UDPInit(void);

UDP_SOCKET UDPOpen(UDP_PORT localPort, NODE_INFO *remoteNode, UDP_PORT remotePort);
void UDPClose(UDP_SOCKET s);
BOOL UDPProcess(NODE_INFO *remoteNode, IP_ADDR *localIP, WORD len);

WORD UDPIsPutReady(UDP_SOCKET s);
BOOL UDPPut(BYTE v);
WORD UDPPutArray(BYTE *cData, WORD wDataLen);
WORD UDPPutROMArray(ROM BYTE *cData, WORD wDataLen);
BYTE* UDPPutString(BYTE *strData);
ROM BYTE* UDPPutROMString(ROM BYTE *strData);
void UDPFlush(void);

WORD UDPIsGetReady(UDP_SOCKET s);
BOOL UDPGet(BYTE *v);
WORD UDPGetArray(BYTE *cData, WORD wDataLen);
void UDPDiscard(void);


/*********************************************************************
 * Macro:           UDPSetTxBuffer(a, b)
 *
 * PreCondition:    None
 *
 * Input:           a       - Buffer identifier
 *                  b       - Offset
 *
 * Output:          Next Read/Write access to transmit buffer 'a'
 *                  set to offset 'b'
 *
 * Side Effects:    None
 *
 * Note:            None
 *
 ********************************************************************/
#define UDPSetTxBuffer(b) IPSetTxBuffer(b+sizeof(UDP_HEADER))


/*********************************************************************
 * Macro:           UDPSetRxBuffer(a)
 *
 * PreCondition:    None
 *
 * Input:           a       - Offset
 *
 * Output:          Next Read/Write access to receive buffer is
 *                  set to offset 'b'
 *
 * Side Effects:    None
 *
 * Note:            None
 *
 ********************************************************************/
#define UDPSetRxBuffer(a) IPSetRxBuffer(a+sizeof(UDP_HEADER))


#endif
