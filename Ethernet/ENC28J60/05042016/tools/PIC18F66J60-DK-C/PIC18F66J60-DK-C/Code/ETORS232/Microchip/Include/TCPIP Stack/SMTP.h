/*********************************************************************
 *
 *                  Simple Mail Transfer Protocol (SMTP) Client
 *					Module for Microchip TCP/IP Stack
 *
 *********************************************************************
 * FileName:        SMTP.c
 * Dependencies:    TCP.h
 * Processor:       PIC18, PIC24F, PIC24H, dsPIC30, dsPIC33F
 * Complier:        Microchip C18 v3.02 or higher
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
 * Author               Date    Comment
 *~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * Howard Schlunder     3/03/06	Original
 ********************************************************************/
#ifndef __SMTP_H
#define __SMTP_H


#define SMTP_SUCCESS		(0x0000)
#define SMTP_RESOLVE_ERROR	(0x8000)
#define SMTP_CONNECT_ERROR	(0x8001)

typedef struct _SMTP_POINTERS
{
	union
	{
		BYTE *szRAM;
		ROM BYTE *szROM;
	} Server;
	union
	{
		BYTE *szRAM;
		ROM BYTE *szROM;
	} To;
	union
	{
		BYTE *szRAM;
		ROM BYTE *szROM;
	} CC;
	union
	{
		BYTE *szRAM;
		ROM BYTE *szROM;
	} BCC;
	union
	{
		BYTE *szRAM;
		ROM BYTE *szROM;
	} From;
	union
	{
		BYTE *szRAM;
		ROM BYTE *szROM;
	} Subject;
	union
	{
		BYTE *szRAM;
		ROM BYTE *szROM;
	} OtherHeaders;
	union
	{
		BYTE *szRAM;
		ROM BYTE *szROM;
	} Body;

	struct
	{
		unsigned char Server:1;
		unsigned char To:1;
		unsigned char CC:1;
		unsigned char BCC:1;
		unsigned char From:1;
		unsigned char Subject:1;
		unsigned char OtherHeaders:1;
		unsigned char Body:1;
	} ROMPointers;
} SMTP_POINTERS;

extern SMTP_POINTERS SMTPClient;

BOOL SMTPBeginUsage(void);
WORD SMTPEndUsage(void);
void SMTPTask(void);
void SMTPSendMail(void);
BOOL SMTPIsBusy(void);
WORD SMTPIsPutReady(void);
BOOL SMTPPut(BYTE c);
WORD SMTPPutArray(BYTE* Data, WORD Len);
WORD SMTPPutROMArray(ROM BYTE* Data, WORD Len);
WORD SMTPPutString(BYTE* Data);
WORD SMTPPutROMString(ROM BYTE* Data);
void SMTPFlush(void);
void SMTPPutDone(void);


#endif
