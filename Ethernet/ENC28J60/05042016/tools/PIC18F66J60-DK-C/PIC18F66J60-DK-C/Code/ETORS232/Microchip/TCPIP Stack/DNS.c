/*********************************************************************
 *
 *	Domain Name System (DNS) Client
 *  Module for Microchip TCP/IP Stack
 *	 -Provides hostname to IP address translation
 *	 -Reference: RFC 1035
 *
 *********************************************************************
 * FileName:        DNS.c
 * Dependencies:    UDP, ARP, Tick
 * Processor:       PIC18, PIC24F, PIC24H, dsPIC30F, dsPIC33F
 * Complier:        Microchip C18 v3.02 or higher
 *					Microchip C30 v2.05 or higher
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
 * Author               Date		Comment
 *~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * Howard Schlunder     7/31/06		Original
 * Howard Schlunder		10/09/06	Added DNSBeginUsage(), DNSEndUsage() 
 *									module ownership semaphore
 ********************************************************************/
#define __DNS_C

#include "TCPIP Stack/TCPIP.h"

#if defined(STACK_USE_DNS)


#define DNS_PORT		53u
#define DNS_TIMEOUT		(TICK_SECOND*2)



static UDP_SOCKET MySocket = INVALID_UDP_SOCKET;
static BYTE *DNSHostName;
static ROM BYTE *DNSHostNameROM;
static BYTE RecordType;
static union
{
	BYTE Val;
	struct
	{
		unsigned char DNSInUse 		: 1;
		unsigned char AddressValid	: 1;
		unsigned char filler 		: 6;
	} bits;
} Flags = {0x00};
static enum
{
	DNS_HOME = 0,
	DNS_RESOLVE_ARP,
	DNS_OPEN_SOCKET,
	DNS_QUERY,
	DNS_GET_RESULT,
	DNS_DONE
} smDNS = DNS_DONE;

typedef struct _DNS_HEADER
{
	WORD_VAL TransactionID;
	WORD_VAL Flags;
	WORD_VAL Questions;
	WORD_VAL Answers;
	WORD_VAL AuthoritativeRecords;
	WORD_VAL AdditionalRecords;
} DNS_HEADER;

typedef struct _DNS_ANSWER_HEADER
{
	WORD_VAL	ResponseName;
	WORD_VAL	ResponseType;
	WORD_VAL	ResponseClass;
	DWORD_VAL	ResponseTTL;
	WORD_VAL	ResponseLen;
} DNS_ANSWER_HEADER;

static void DNSPutString(BYTE *String);
static void DNSPutROMString(ROM BYTE *String);
static void DNSGetString(BYTE *String);


/*********************************************************************
 * Function:        BOOL DNSBeginUsage(void)
 *
 * PreCondition:    Stack is initialized()
 *
 * Input:           None
 *
 * Output:          TRUE: If no DNS resolution operations are in progress and this application has successfully taken ownership of the DNS module
 *					FALSE: If the DNS module is currently being used by some other module.  Call DNSBeginUsage() some time later (after returning to the main() program loop).
 *
 * Side Effects:    None
 *
 * Overview:        Call DNSBeginUsage() and make sure it returns TRUE before calling any DNS APIs.  Call DNSEndUsage() when this application no longer needs the DNS module so that other applications may make use of it.
 *
 * Note:            None
 ********************************************************************/
BOOL DNSBeginUsage(void)
{
	if(Flags.bits.DNSInUse)
		return FALSE;

	Flags.bits.DNSInUse = TRUE;
	return TRUE;
}


/*********************************************************************
 * Function:        BOOL DNSEndUsage(void)
 *
 * PreCondition:    DNSBeginUsage() returned TRUE on a previous call.
 *
 * Input:           None
 *
 * Output:          TRUE: If the address to the host name was 
 *						  successfully resolved
 *					FALSE: If the DNS failed or address does not 
 *						   exists.  The contents of *Hostname are 
 *						   unchanged.
 *
 * Side Effects:    None
 *
 * Overview:        Call DNSBeginUsage() and make sure it returns 
 *					TRUE before calling any DNS APIs.  Call 
 *					DNSEndUsage() when this application no longer 
 *					needs the DNS module so that other applications 
 *					may make use of it.
 *
 * Note:            None
 ********************************************************************/
BOOL DNSEndUsage(void)
{
	if(MySocket != INVALID_UDP_SOCKET)
	{
		UDPClose(MySocket);
		MySocket = INVALID_UDP_SOCKET;
	}
	smDNS = DNS_DONE;
	Flags.bits.DNSInUse = FALSE;

	return Flags.bits.AddressValid;
}


/*********************************************************************
 * Function:        void DNSResolve(BYTE *Hostname, BYTE RecordType)
 *
 * PreCondition:    Stack is initialized()
 *
 * Input:           *Hostname: Null terminated string specifying the 
 *							   host address to resolve to an IP 
 *							   address.
 *					Type: DNS_TYPE_A (1d): Host Address (normal IP address)
 *						  DNS_TYPE_MX (15d): Mail eXchange
 *						  All other values are reserved
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        Call DNSIsResolved() until the host is resolved.
 *
 * Note:            A UDP socket must be available before this 
 *					function is called.  It is freed at the end of 
 *					the resolution.  MAX_UDP_SOCKETS may need to be 
 *					increased if other modules use UDP sockets.
 *
 *					You must not modify *Hostname until DNSIsResolved() 
 *					returns TRUE.
 ********************************************************************/
void DNSResolve(BYTE *Hostname, BYTE Type)
{
	DNSHostName = Hostname;
	DNSHostNameROM = NULL;
	smDNS = DNS_HOME;
	RecordType = Type;
	Flags.bits.AddressValid = FALSE;
}

void DNSResolveROM(ROM BYTE *Hostname, BYTE Type)
{
	DNSHostName = NULL;
	DNSHostNameROM = Hostname;
	smDNS = DNS_HOME;
	RecordType = Type;
	Flags.bits.AddressValid = FALSE;
}


/*********************************************************************
 * Function:        BOOL DNSIsResolved(IP_ADDR *HostIP)
 *
 * PreCondition:    DNSResolve() was called.
 *
 * Input:           HostIP: Pointer to IP_ADDR structure to store the 
 *							returned host IP address when DNS 
 *							resolution is complete.
 *
 * Output:          *HostIP, 4 byte IP address
 *
 * Side Effects:    None
 *
 * Overview:        Call DNSIsResolved() until the host is resolved.
 *
 * Note:            You cannot start two DNS resolution proceedures 
 *					concurrently.
 *
 *					You must not modify *Hostname until DNSIsResolved() 
 *					returns TRUE.
 ********************************************************************/
BOOL DNSIsResolved(IP_ADDR *HostIP)
{
	static NODE_INFO	Remote;
	static TICK			StartTime;
	static WORD_VAL		SentTransactionID __attribute__((persistent));
	BYTE 				i;
	WORD_VAL			w;
	DNS_HEADER			DNSHeader;
	DNS_ANSWER_HEADER	DNSAnswerHeader;

	switch(smDNS)
	{
		case DNS_HOME:
			ARPResolve(&AppConfig.PrimaryDNSServer);
			StartTime = TickGet();
			smDNS++;
			break;

		case DNS_RESOLVE_ARP:
			if(!ARPIsResolved(&AppConfig.PrimaryDNSServer, &Remote.MACAddr))
			{
				if(TickGet() - StartTime > DNS_TIMEOUT)
				{
					smDNS--;
				}
				break;
			}
			Remote.IPAddr.Val = AppConfig.PrimaryDNSServer.Val;
			smDNS++;
			// No need to break, we can immediately open a socket

		case DNS_OPEN_SOCKET:
			MySocket = UDPOpen(0, &Remote, DNS_PORT);
			if(MySocket == INVALID_UDP_SOCKET)
				break;

			smDNS++;
			// No need to break, we can immediately start resolution
			
		case DNS_QUERY:
			if(!UDPIsPutReady(MySocket))
				break;
			
			// Put DNS query here
			SentTransactionID.Val++;
			UDPPut(SentTransactionID.v[1]);// User chosen transaction ID
			UDPPut(SentTransactionID.v[0]);
			UDPPut(0x01);		// Standard query with recursion
			UDPPut(0x00);	
			UDPPut(0x00);		// 0x0001 questions
			UDPPut(0x01);
			UDPPut(0x00);		// 0x0000 answers
			UDPPut(0x00);
			UDPPut(0x00);		// 0x0000 name server resource records
			UDPPut(0x00);
			UDPPut(0x00);		// 0x0000 additional records
			UDPPut(0x00);

			// Put hostname string to resolve
			if(DNSHostName)
				DNSPutString(DNSHostName);
			else
				DNSPutROMString(DNSHostNameROM);

			UDPPut(0x00);		// Type: DNS_TYPE_A A (host address) or DNS_TYPE_MX for mail exchange
			UDPPut(RecordType);
			UDPPut(0x00);		// Class: IN (Internet)
			UDPPut(0x01);

			UDPFlush();
			StartTime = TickGet();
			smDNS++;
			break;

		case DNS_GET_RESULT:
			if(!UDPIsGetReady(MySocket))
			{
				if(TickGet() - StartTime > DNS_TIMEOUT)
				{
					smDNS--;
				}
				break;
			}

			// Retrieve the DNS header and de-big-endian it
			UDPGet(&DNSHeader.TransactionID.v[1]);
			UDPGet(&DNSHeader.TransactionID.v[0]);

			// Throw this packet away if it isn't in response to our last query
			if(DNSHeader.TransactionID.Val != SentTransactionID.Val)
			{
				UDPDiscard();
				break;
			}

			UDPGet(&DNSHeader.Flags.v[1]);
			UDPGet(&DNSHeader.Flags.v[0]);
			UDPGet(&DNSHeader.Questions.v[1]);
			UDPGet(&DNSHeader.Questions.v[0]);
			UDPGet(&DNSHeader.Answers.v[1]);
			UDPGet(&DNSHeader.Answers.v[0]);
			UDPGet(&DNSHeader.AuthoritativeRecords.v[1]);
			UDPGet(&DNSHeader.AuthoritativeRecords.v[0]);
			UDPGet(&DNSHeader.AdditionalRecords.v[1]);
			UDPGet(&DNSHeader.AdditionalRecords.v[0]);

			// Remove all questions
			while(DNSHeader.Questions.Val--)
			{
				DNSGetString(NULL);
				UDPGet(&w.v[1]);		// Question type
				UDPGet(&w.v[0]);
				UDPGet(&w.v[1]);		// Question class
				UDPGet(&w.v[0]);
			}
			
			// Scan through answers
			while(DNSHeader.Answers.Val--)
			{
				UDPGet(&DNSAnswerHeader.ResponseName.v[1]);		// Response name
				UDPGet(&DNSAnswerHeader.ResponseName.v[0]);
				UDPGet(&DNSAnswerHeader.ResponseType.v[1]);		// Response type
				UDPGet(&DNSAnswerHeader.ResponseType.v[0]);
				UDPGet(&DNSAnswerHeader.ResponseClass.v[1]);	// Response class
				UDPGet(&DNSAnswerHeader.ResponseClass.v[0]);
				UDPGet(&DNSAnswerHeader.ResponseTTL.v[3]);		// Time to live
				UDPGet(&DNSAnswerHeader.ResponseTTL.v[2]);
				UDPGet(&DNSAnswerHeader.ResponseTTL.v[1]);
				UDPGet(&DNSAnswerHeader.ResponseTTL.v[0]);
				UDPGet(&DNSAnswerHeader.ResponseLen.v[1]);		// Response length
				UDPGet(&DNSAnswerHeader.ResponseLen.v[0]);

				// Make sure that this is a 4 byte IP address, response type A or MX, class 1
				// Check if this is Type A or MX
				if( DNSAnswerHeader.ResponseType.Val	== 0x0001u &&
					DNSAnswerHeader.ResponseClass.Val	== 0x0001u && // Internet class
					DNSAnswerHeader.ResponseLen.Val		== 0x0004u)
				{
					Flags.bits.AddressValid = TRUE;
					UDPGet(&HostIP->v[0]);
					UDPGet(&HostIP->v[1]);
					UDPGet(&HostIP->v[2]);
					UDPGet(&HostIP->v[3]);
					goto DoneSearchingRecords;
				}
				else
				{
					while(DNSAnswerHeader.ResponseLen.Val--)
					{
						UDPGet(&i);
					}
				}
			}

			// Remove all Authoritative Records
			while(DNSHeader.AuthoritativeRecords.Val--)
			{
				UDPGet(&DNSAnswerHeader.ResponseName.v[1]);		// Response name
				UDPGet(&DNSAnswerHeader.ResponseName.v[0]);
				UDPGet(&DNSAnswerHeader.ResponseType.v[1]);		// Response type
				UDPGet(&DNSAnswerHeader.ResponseType.v[0]);
				UDPGet(&DNSAnswerHeader.ResponseClass.v[1]);	// Response class
				UDPGet(&DNSAnswerHeader.ResponseClass.v[0]);
				UDPGet(&DNSAnswerHeader.ResponseTTL.v[3]);		// Time to live
				UDPGet(&DNSAnswerHeader.ResponseTTL.v[2]);
				UDPGet(&DNSAnswerHeader.ResponseTTL.v[1]);
				UDPGet(&DNSAnswerHeader.ResponseTTL.v[0]);
				UDPGet(&DNSAnswerHeader.ResponseLen.v[1]);		// Response length
				UDPGet(&DNSAnswerHeader.ResponseLen.v[0]);

				// Make sure that this is a 4 byte IP address, response type A or MX, class 1
				// Check if this is Type A
				if( DNSAnswerHeader.ResponseType.Val	== 0x0001u &&
					DNSAnswerHeader.ResponseClass.Val	== 0x0001u && // Internet class
					DNSAnswerHeader.ResponseLen.Val		== 0x0004u)
				{
					Flags.bits.AddressValid = TRUE;
					UDPGet(&HostIP->v[0]);
					UDPGet(&HostIP->v[1]);
					UDPGet(&HostIP->v[2]);
					UDPGet(&HostIP->v[3]);
					goto DoneSearchingRecords;
				}
				else
				{
					while(DNSAnswerHeader.ResponseLen.Val--)
					{
						UDPGet(&i);
					}
				}
			}

			// Remove all Additional Records
			while(DNSHeader.AdditionalRecords.Val--)
			{
				UDPGet(&DNSAnswerHeader.ResponseName.v[1]);		// Response name
				UDPGet(&DNSAnswerHeader.ResponseName.v[0]);
				UDPGet(&DNSAnswerHeader.ResponseType.v[1]);		// Response type
				UDPGet(&DNSAnswerHeader.ResponseType.v[0]);
				UDPGet(&DNSAnswerHeader.ResponseClass.v[1]);	// Response class
				UDPGet(&DNSAnswerHeader.ResponseClass.v[0]);
				UDPGet(&DNSAnswerHeader.ResponseTTL.v[3]);		// Time to live
				UDPGet(&DNSAnswerHeader.ResponseTTL.v[2]);
				UDPGet(&DNSAnswerHeader.ResponseTTL.v[1]);
				UDPGet(&DNSAnswerHeader.ResponseTTL.v[0]);
				UDPGet(&DNSAnswerHeader.ResponseLen.v[1]);		// Response length
				UDPGet(&DNSAnswerHeader.ResponseLen.v[0]);

				// Make sure that this is a 4 byte IP address, response type A or MX, class 1
				// Check if this is Type A
				if( DNSAnswerHeader.ResponseType.Val	== 0x0001u &&
					DNSAnswerHeader.ResponseClass.Val	== 0x0001u && // Internet class
					DNSAnswerHeader.ResponseLen.Val		== 0x0004u)
				{
					Flags.bits.AddressValid = TRUE;
					UDPGet(&HostIP->v[0]);
					UDPGet(&HostIP->v[1]);
					UDPGet(&HostIP->v[2]);
					UDPGet(&HostIP->v[3]);
					goto DoneSearchingRecords;
				}
				else
				{
					while(DNSAnswerHeader.ResponseLen.Val--)
					{
						UDPGet(&i);
					}
				}
			}

DoneSearchingRecords:

			UDPDiscard();
			UDPClose(MySocket);
			MySocket = INVALID_UDP_SOCKET;
			smDNS++;
			// No need to break, we are done and need to return TRUE

		case DNS_DONE:
			return TRUE;
	}
	
	return FALSE;
}

static void DNSPutString(BYTE *String)
{
	BYTE *RightPtr;
	BYTE i;
	BYTE Len;

	RightPtr = String;

	while(1)
	{
		do
		{
			i = *RightPtr++;
		} while((i != 0x00u) && (i != '.') && (i != '/') && (i != ',') && (i != '>'));
	
		// Put the length parameter
		Len = (BYTE)(RightPtr-String-1);
		UDPPut(Len);
		while(Len--)
		{
			UDPPut(*String++);
		}
		if(i == 0x00u || i == '/' || i == ',' || i == '>')
			break;

		// Skip over the '.' in the input string
		String++;
	}
	
	// Put the string terminator character
	UDPPut(0x00);
}

static void DNSPutROMString(ROM BYTE *String)
{
	ROM BYTE *RightPtr;
	BYTE i;
	BYTE Len;

	RightPtr = String;

	while(1)
	{
		do
		{
			i = *RightPtr++;
		} while((i != 0x00u) && (i != '.') && (i != '/') && (i != ',') && (i != '>'));
	
		// Put the length parameter
		Len = (BYTE)(RightPtr-String-1);
		UDPPut(Len);
		UDPPutROMArray(String, Len);
		String += Len + 1;

		if(i == 0x00u || i == '/' || i == ',' || i == '>')
			break;
	}
	
	// Put the string terminator character
	UDPPut(0x00);
}


static void DNSGetString(BYTE *String)
{
	BYTE i;
	BYTE j;

	if(String == NULL)
	{
		UDPGet(&i);
		while(i)
		{
			while(i--)
			{
				UDPGet(&j);
			}
			UDPGet(&i);
		}
	}
	else
	{
		UDPGet(&i);
		while(i)
		{
			while(i--)
			{
				UDPGet(String);
				String++;
			}
			UDPGet(&i);
		}
	}
}


#endif	//#if defined(STACK_USE_DNS)
