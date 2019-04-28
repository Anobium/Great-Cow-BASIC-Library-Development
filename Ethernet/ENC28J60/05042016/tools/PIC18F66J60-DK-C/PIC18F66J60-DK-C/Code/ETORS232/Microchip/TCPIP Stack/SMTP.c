/*********************************************************************
 *
 *	Simple Mail Transfer Protocol (SMTP) Client
 *	Module for Microchip TCP/IP Stack
 *   -Provides ability to send Emails
 *	 -Reference: RFC 2821
 *
 *********************************************************************
 * FileName:        SMTP.c
 * Dependencies:    TCP, ARP, DNS, STACK_CLIENT_MODE
 * Processor:       PIC18, PIC24F, PIC24H, dsPIC30, dsPIC33F
 * Complier:        Microchip C18 v3.02 or higher
 * 					Microchip C30 v2.05 or higher
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
 * Howard Schlunder		11/2/06	Vastly improved for release
 ********************************************************************/
#define __SMTP_C

#include "TCPIP Stack/TCPIP.h"

#if defined(STACK_USE_SMTP_CLIENT)


#define SMTP_PORT	25

// Public variables
// Public string pointers controlling the mail message.  
// Application must set these after calling SMTPBeginUsage().
// Unneeded fields should be set to NULL.
SMTP_POINTERS SMTPClient;

// Internal variables
static NODE_INFO SMTPServer;
static TCP_SOCKET MySocket = INVALID_SOCKET;
static TICK LastPutTime;
static union
{
	BYTE *Pos;
	enum
	{
		CR_PERIOD_SEEK_CR = 0,
		CR_PERIOD_SEEK_LF,
		CR_PERIOD_SEEK_PERIOD,
		CR_PERIOD_NEED_INSERTION
	} State;
} CRPeriod;
static enum _TransportState
{
	TRANSPORT_HOME = 0,
	TRANSPORT_BEGIN,
	TRANSPORT_NAME_RESOLVE,
	TRANSPORT_ARP_START_RESOLVE,
	TRANSPORT_ARP_IN_PROGRESS,
	TRANSPORT_ARP_RESOLVED,
	TRANSPORT_SOCKET_OBTAINED,
	TRANSPORT_CLOSE
} TransportState = TRANSPORT_HOME;
static enum _SMTPState
{
	SMTP_HOME = 0,
	SMTP_HELO,
	SMTP_HELO_ACK,	
	SMTP_MAILFROM,
	SMTP_MAILFROM_ACK,
	SMTP_RCPTTO_INIT,
	SMTP_RCPTTO,
	SMTP_RCPTTO_ACK,
	SMTP_RCPTTO_ISDONE,
	SMTP_RCPTTOCC_INIT,
	SMTP_RCPTTOCC,
	SMTP_RCPTTOCC_ACK,
	SMTP_RCPTTOCC_ISDONE,
	SMTP_RCPTTOBCC_INIT,
	SMTP_RCPTTOBCC,
	SMTP_RCPTTOBCC_ACK,
	SMTP_RCPTTOBCC_ISDONE,
	SMTP_DATA,
	SMTP_DATA_ACK,
	SMTP_DATA_HEADER,
	SMTP_DATA_BODY_INIT,
	SMTP_DATA_BODY,
	SMTP_DATA_BODY_ACK,
	SMTP_QUIT_INIT,
	SMTP_QUIT
} SMTPState;
static enum _PutHeadersState
{
	PUTHEADERS_FROM_INIT = 0,
	PUTHEADERS_FROM,
	PUTHEADERS_TO_INIT,
	PUTHEADERS_TO,
	PUTHEADERS_CC_INIT,
	PUTHEADERS_CC,
	PUTHEADERS_SUBJECT_INIT,
	PUTHEADERS_SUBJECT,
	PUTHEADERS_OTHER_INIT,
	PUTHEADERS_OTHER,
	PUTHEADERS_DONE
} PutHeadersState;
static enum _RXParserState
{
	RX_BYTE_0 = 0,
	RX_BYTE_1,
	RX_BYTE_2,
	RX_BYTE_3,
	RX_SEEK_CR,
	RX_SEEK_LF
} RXParserState;
static union _SMTPFlags
{
	BYTE Val;
	struct
	{
		unsigned char RXSkipResponse:1;
		unsigned char SMTPInUse:1;
		unsigned char SentSuccessfully:1;
		unsigned char ReadyToStart:1;
		unsigned char ReadyToFinish:1;
		unsigned char ConnectedOnce:1;
		unsigned char filler:2;
	} bits;
} SMTPFlags = {0x00};
static WORD ResponseCode;

// Internal functions
static BYTE *FindEmailAddress(BYTE *str, WORD *wLen);
static ROM BYTE *FindROMEmailAddress(ROM BYTE *str, WORD *wLen);


/*********************************************************************
 * Function:        BOOL SMTPBeginUsage(void)
 *
 * PreCondition:    Stack is initialized()
 *
 * Input:           None
 *
 * Output:          TRUE: If no SMTP operations are in progress and this application has successfully taken ownership of the SMTP module
 *					FALSE: If the SMTP module is currently being used by some other application.  Call SMTPBeginUsage() some time later (after returning to the main() program loop).
 *
 * Side Effects:    None
 *
 * Overview:        Call DNSBeginUsage() and make sure it returns TRUE before calling any DNS APIs.  Call DNSEndUsage() when this application no longer needs the DNS module so that other applications may make use of it.
 *
 * Note:            None
 ********************************************************************/
BOOL SMTPBeginUsage(void)
{
	static BYTE NullString = '\0';

	if(SMTPFlags.bits.SMTPInUse)
		return FALSE;

	SMTPFlags.Val = 0x00;
	SMTPFlags.bits.SMTPInUse = TRUE;
	TransportState = TRANSPORT_BEGIN;
	RXParserState = RX_BYTE_0;
	SMTPState = SMTP_HOME;
	memset((void*)&SMTPClient, 0x00, sizeof(SMTPClient));
		
	return TRUE;
}


/*********************************************************************
 * Function:        void SMTPEndUsage(void)
 *
 * PreCondition:    SMTPBeginUsage() returned TRUE on a previous call.
 *
 * Input:           None
 *
 * Output:          SMTP_SUCCESS (0x0000): on success
 *					SMTP_RESOLVE_ERROR (0x8000): if unable to resolve SMTP server
 *					SMTP_CONNECT_ERROR (0x8001): if unable to connect to SMTP server or connection lost
 *					1-199 and 300-999: last SMTP server response code
 *
 * Side Effects:    None
 *
 * Overview:        Releases ownership of the SMTP module caused by a 
 *					previous call to SMTPBeginUsage()
 *
 * Note:            None
 ********************************************************************/
WORD SMTPEndUsage(void)
{
	if(!SMTPFlags.bits.SMTPInUse)
		return FALSE;

	// Release the DNS module, if in use
	if(TransportState == TRANSPORT_NAME_RESOLVE)
		DNSEndUsage();
	
	// Release the TCP socket, if in use
	if(MySocket != INVALID_SOCKET)
	{
		TCPDisconnect(MySocket);
		MySocket = INVALID_SOCKET;
	}
	
	// Release the SMTP module
	SMTPFlags.bits.SMTPInUse = FALSE;
	TransportState = TRANSPORT_HOME;

	if(SMTPFlags.bits.SentSuccessfully)
	{
		return 0;
	}
	else
	{
		return ResponseCode;
	}
}

/*********************************************************************
 * Function:        void SMTPTask(void)
 *
 * PreCondition:    Stack is initialized()
 *
 * Input:           None
 *
 * Output:          None
 *
 * Side Effects:    Uses ARP module
 *
 * Overview:        None
 *
 * Note:            This is a work is in progress
 ********************************************************************/
void SMTPTask(void)
{
	BYTE			c;
	static TICK		Timer;
	static BYTE		RXBuffer[4];
	static ROM BYTE *ROMStrPtr, *ROMStrPtr2;
	static BYTE 	*RAMStrPtr;
	static WORD		wAddressLength;

	switch(TransportState)
	{
		case TRANSPORT_HOME:
			// SMTPBeginUsage() is the only function which will kick 
			// the state machine into the next state
			break;

		case TRANSPORT_BEGIN:
			// Wait for the user to program all the pointers and then 
			// call SMTPSendMail()
			if(!SMTPFlags.bits.ReadyToStart)
				break;

			// Obtain ownership of the DNS resolution module
			if(!DNSBeginUsage())
				break;

			// Obtain the IP address associated with the SMTP mail server
			if(SMTPClient.Server.szRAM || SMTPClient.Server.szROM)
			{
				if(SMTPClient.ROMPointers.Server)
					DNSResolve(SMTPClient.Server.szRAM, DNS_TYPE_A);
				else
					DNSResolveROM(SMTPClient.Server.szROM, DNS_TYPE_A);
			}
			else
			{
				// If we don't have a mail server, try to send the mail 
				// directly to the destination SMTP server
				if(SMTPClient.To.szRAM && !SMTPClient.ROMPointers.To)
				{
					SMTPClient.Server.szRAM = (BYTE*)strchr((char*)SMTPClient.To.szRAM, '@');
					SMTPClient.ROMPointers.Server = 0;
				}
				else if(SMTPClient.To.szROM && SMTPClient.ROMPointers.To)
				{
					SMTPClient.Server.szROM = (ROM BYTE*)strchrpgm((ROM char*)SMTPClient.To.szROM, '@');
					SMTPClient.ROMPointers.Server = 1;
				}

				if(!(SMTPClient.Server.szRAM || SMTPClient.Server.szROM))
				{
					if(SMTPClient.CC.szRAM && !SMTPClient.ROMPointers.CC)
					{
						SMTPClient.Server.szRAM = (BYTE*)strchr((char*)SMTPClient.CC.szRAM, '@');
						SMTPClient.ROMPointers.Server = 0;
					}
					else if(SMTPClient.CC.szROM && SMTPClient.ROMPointers.CC)
					{
						SMTPClient.Server.szROM = (ROM BYTE*)strchrpgm((ROM char*)SMTPClient.CC.szROM, '@');
						SMTPClient.ROMPointers.Server = 1;
					}
				}

				if(!(SMTPClient.Server.szRAM || SMTPClient.Server.szROM))
				{
					if(SMTPClient.BCC.szRAM && !SMTPClient.ROMPointers.BCC)
					{
						SMTPClient.Server.szRAM = (BYTE*)strchr((char*)SMTPClient.BCC.szRAM, '@');
						SMTPClient.ROMPointers.Server = 0;
					}
					else if(SMTPClient.BCC.szROM && SMTPClient.ROMPointers.BCC)
					{
						SMTPClient.Server.szROM = (ROM BYTE*)strchrpgm((ROM char*)SMTPClient.BCC.szROM, '@');
						SMTPClient.ROMPointers.Server = 1;
					}
				}

				// See if we found a hostname anywhere which we could resolve
				if(!(SMTPClient.Server.szRAM || SMTPClient.Server.szROM))
				{
					DNSEndUsage();
					TransportState = TRANSPORT_HOME;
					break;
				}

				// Skip over the @ sign and resolve the host name
				if(SMTPClient.ROMPointers.Server)
				{
					SMTPClient.Server.szROM++;
					DNSResolveROM(SMTPClient.Server.szROM, DNS_TYPE_MX);
				}
				else
				{
					SMTPClient.Server.szRAM++;
					DNSResolve(SMTPClient.Server.szRAM, DNS_TYPE_MX);
				}
			}
			
			TransportState++;
			break;

		case TRANSPORT_NAME_RESOLVE:
			// Wait for the DNS server to return the requested IP address
			if(!DNSIsResolved(&SMTPServer.IPAddr))
				break;

			// Release the DNS module, we no longer need it
			if(!DNSEndUsage())
			{
				// An invalid IP address was returned from the DNS 
				// server.  Quit and fail permanantly if host is not valid.
				ResponseCode = SMTP_RESOLVE_ERROR;
				TransportState = TRANSPORT_HOME;
				break;
			}

			TransportState++;
			// No need to break here

		case TRANSPORT_ARP_START_RESOLVE:
			// Obtain the MAC address associated with the server's IP address (either direct MAC address on same subnet, or the MAC address of the Gateway machine)
			ARPResolve(&SMTPServer.IPAddr);
			Timer = TickGet();
			TransportState++;
			break;

		case TRANSPORT_ARP_IN_PROGRESS:
			// Check to see if the MAC address has been resovlved
			if(!ARPIsResolved(&SMTPServer.IPAddr, &SMTPServer.MACAddr))
			{
				// Time out if too much time is spent in this state
				if(TickGet()-Timer > 2*TICK_SECOND)
				{
					ResponseCode = SMTP_RESOLVE_ERROR;
					// Retry ARP resolution
					TransportState = TRANSPORT_HOME;
				}
				break;
			}

			TransportState++;
			Timer = TickGet();
			// No break; fall into SM_ARP_RESOLVED

		case TRANSPORT_ARP_RESOLVED:
			// Connect a TCP socket to the remote SMTP server
			MySocket = TCPConnect(&SMTPServer, SMTP_PORT);
			
			// Abort operation if no TCP sockets are available
			// If this ever happens, incrementing MAX_TCP_SOCKETS in 
			// TCPIPConfig. may help (at the expense of more global memory 
			// resources).
			if(MySocket == INVALID_SOCKET)
				break;

			TransportState++;
			Timer = TickGet();
			// No break; fall into SM_SOCKET_OBTAINED

		case TRANSPORT_SOCKET_OBTAINED:
			if(!TCPIsConnected(MySocket))
			{
				// Don't stick around in the wrong state if the
				// server was connected, but then disconnected us.
				// Also time out if we can't establish the connection 
				// to the SMTP server
				if(SMTPFlags.bits.ConnectedOnce || ((LONG)(TickGet()-Timer) > (LONG)(8*TICK_SECOND)))
				{
					ResponseCode = SMTP_CONNECT_ERROR;
					TransportState = TRANSPORT_CLOSE;
				}

				break;
			}
			SMTPFlags.bits.ConnectedOnce = TRUE;

			// See if the server sent us anything
			while(TCPIsGetReady(MySocket))
			{
				TCPGet(MySocket, &c);
				switch(RXParserState)
				{
					case RX_BYTE_0:
					case RX_BYTE_1:
					case RX_BYTE_2:
						RXBuffer[RXParserState] = c;
						RXParserState++;
						break;
	
					case RX_BYTE_3:
						switch(c)
						{
							case ' ':
								SMTPFlags.bits.RXSkipResponse = FALSE;
								RXParserState++;
								break;
							case '-':
								SMTPFlags.bits.RXSkipResponse = TRUE;
								RXParserState++;
								break;
							case '\r':
								RXParserState = RX_SEEK_LF;
								break;
						}
						break;
	
					case RX_SEEK_CR:
						if(c == '\r')
							RXParserState++;
						break;
	
					case RX_SEEK_LF:
						// If we received the whole command
						if(c == '\n')
						{
							RXParserState = RX_BYTE_0;

							if(!SMTPFlags.bits.RXSkipResponse)
							{
								// The server sent us a response code
								// Null terminate the ASCII reponse code so we can convert it to an integer
								RXBuffer[3] = 0;
								ResponseCode = atoi((char*)RXBuffer);

								// Handle the response
								switch(SMTPState)
								{
									case SMTP_HOME:
									case SMTP_HELO_ACK:
									case SMTP_MAILFROM_ACK:
									case SMTP_RCPTTO_ACK:
									case SMTP_RCPTTOCC_ACK:
									case SMTP_RCPTTOBCC_ACK:
										if(ResponseCode >= 200u && ResponseCode <= 299u)
											SMTPState++;
										else
											SMTPState = SMTP_QUIT_INIT;
										break;
							
									case SMTP_DATA_ACK:
										if(ResponseCode == 354u)
											SMTPState++;
										else
											SMTPState = SMTP_QUIT_INIT;
										break;
							
									case SMTP_DATA_BODY_ACK:
										if(ResponseCode >= 200u && ResponseCode <= 299u)
											SMTPFlags.bits.SentSuccessfully = TRUE;
							
										SMTPState = SMTP_QUIT_INIT;
										break;
								}
							}
						}
						else if(c != '\r')
							RXParserState--;
	
						break;
				}
			}

			// Generate new data in the TX buffer, as needed, if possible
			if(TCPIsPutReady(MySocket) < 64u)
				break;

			switch(SMTPState)
			{
				case SMTP_HELO:
					TCPPutROMString(MySocket, (ROM BYTE*)"HELO MCHPBOARD\r\n");
					TCPFlush(MySocket);
					SMTPState++;
					break;

				case SMTP_MAILFROM:
					TCPPutROMString(MySocket, (ROM BYTE*)"MAIL FROM:<");
					if(SMTPClient.ROMPointers.From)
					{
						ROMStrPtr = FindROMEmailAddress(SMTPClient.From.szROM, &wAddressLength);
						TCPPutROMArray(MySocket, ROMStrPtr, wAddressLength);
					}
					else
					{
						RAMStrPtr = FindEmailAddress(SMTPClient.From.szRAM, &wAddressLength);
						TCPPutArray(MySocket, RAMStrPtr, wAddressLength);
					}
					TCPPutROMString(MySocket, (ROM BYTE*)">\r\n");
					TCPFlush(MySocket);
					SMTPState++;
					break;

				case SMTP_RCPTTO_INIT:
					// See if there are any (To) recipients to process
					if(SMTPClient.To.szRAM && !SMTPClient.ROMPointers.To)
					{
						RAMStrPtr = FindEmailAddress(SMTPClient.To.szRAM, &wAddressLength);
						if(wAddressLength)
						{
							SMTPState = SMTP_RCPTTO;
							break;
						}
					}
					if(SMTPClient.To.szROM && SMTPClient.ROMPointers.To)
					{
						ROMStrPtr = FindROMEmailAddress(SMTPClient.To.szROM, &wAddressLength);
						if(wAddressLength)
						{
							SMTPState = SMTP_RCPTTO;
							break;
						}
					}
					
					SMTPState = SMTP_RCPTTOCC_INIT;
					break;

				case SMTP_RCPTTO:
				case SMTP_RCPTTOCC:
				case SMTP_RCPTTOBCC:
					TCPPutROMString(MySocket, (ROM BYTE*)"RCPT TO:<");
					if(SMTPClient.ROMPointers.To)
						TCPPutROMArray(MySocket, ROMStrPtr, wAddressLength);
					else
						TCPPutArray(MySocket, RAMStrPtr, wAddressLength);
					TCPPutROMString(MySocket, (ROM BYTE*)">\r\n");
					TCPFlush(MySocket);
					SMTPState++;
					break;

				case SMTP_RCPTTO_ISDONE:
					// See if we have any more (To) recipients to process
					// If we do, we must roll back a couple of states
					if(SMTPClient.ROMPointers.To)
						ROMStrPtr = FindROMEmailAddress(ROMStrPtr+wAddressLength, &wAddressLength);
					else
						RAMStrPtr = FindEmailAddress(RAMStrPtr+wAddressLength, &wAddressLength);
	
					if(wAddressLength)
					{
						SMTPState = SMTP_RCPTTO;
						break;
					}

					// All done with To field
					SMTPState++;
					//No break

				case SMTP_RCPTTOCC_INIT:
					// See if there are any Carbon Copy (CC) recipients to process
					if(SMTPClient.CC.szRAM && !SMTPClient.ROMPointers.CC)
					{
						RAMStrPtr = FindEmailAddress(SMTPClient.CC.szRAM, &wAddressLength);
						if(wAddressLength)
						{
							SMTPState = SMTP_RCPTTOCC;
							break;
						}
					}
					if(SMTPClient.CC.szROM && SMTPClient.ROMPointers.CC)
					{
						ROMStrPtr = FindROMEmailAddress(SMTPClient.CC.szROM, &wAddressLength);
						if(wAddressLength)
						{
							SMTPState = SMTP_RCPTTOCC;
							break;
						}
					}
					
					SMTPState = SMTP_RCPTTOBCC_INIT;
					break;

				case SMTP_RCPTTOCC_ISDONE:
					// See if we have any more Carbon Copy (CC) recipients to process
					// If we do, we must roll back a couple of states
					if(SMTPClient.ROMPointers.CC)
						ROMStrPtr = FindROMEmailAddress(ROMStrPtr+wAddressLength, &wAddressLength);
					else
						RAMStrPtr = FindEmailAddress(RAMStrPtr+wAddressLength, &wAddressLength);

					if(wAddressLength)
					{
						SMTPState = SMTP_RCPTTOCC;
						break;
					}

					// All done with CC field
					SMTPState++;
					//No break

				case SMTP_RCPTTOBCC_INIT:
					// See if there are any Blind Carbon Copy (BCC) recipients to process
					if(SMTPClient.BCC.szRAM && !SMTPClient.ROMPointers.BCC)
					{
						RAMStrPtr = FindEmailAddress(SMTPClient.BCC.szRAM, &wAddressLength);
						if(wAddressLength)
						{
							SMTPState = SMTP_RCPTTOBCC;
							break;
						}
					}
					if(SMTPClient.BCC.szROM && SMTPClient.ROMPointers.BCC)
					{
						ROMStrPtr = FindROMEmailAddress(SMTPClient.BCC.szROM, &wAddressLength);
						if(wAddressLength)
						{
							SMTPState = SMTP_RCPTTOBCC;
							break;
						}
					}

					// All done with BCC field
					SMTPState = SMTP_DATA;
					break;

				case SMTP_RCPTTOBCC_ISDONE:
					// See if we have any more Blind Carbon Copy (CC) recipients to process
					// If we do, we must roll back a couple of states
					if(SMTPClient.ROMPointers.BCC)
						ROMStrPtr = FindROMEmailAddress(ROMStrPtr+wAddressLength, &wAddressLength);
					else
						RAMStrPtr = FindEmailAddress(RAMStrPtr+wAddressLength, &wAddressLength);

					if(wAddressLength)
					{
						SMTPState = SMTP_RCPTTOBCC;
						break;
					}

					// All done with BCC field
					SMTPState++;
					//No break

				case SMTP_DATA:
					TCPPutROMString(MySocket, (ROM BYTE*)"DATA\r\n");
					SMTPState++;
					PutHeadersState = PUTHEADERS_FROM_INIT;
					TCPFlush(MySocket);
					break;

				case SMTP_DATA_HEADER:
					while((PutHeadersState != PUTHEADERS_DONE) && (TCPIsPutReady(MySocket) > 64u))
					{
						switch(PutHeadersState)
						{
							case PUTHEADERS_FROM_INIT:
								if(SMTPClient.From.szRAM || SMTPClient.From.szROM)
								{
									PutHeadersState = PUTHEADERS_FROM;
									TCPPutROMString(MySocket, (ROM BYTE*)"From: ");
								}
								else
								{
									PutHeadersState = PUTHEADERS_TO_INIT;
								}
								break;
								
							case PUTHEADERS_FROM:
								if(SMTPClient.ROMPointers.From)
								{
									SMTPClient.From.szROM = TCPPutROMString(MySocket, SMTPClient.From.szROM);
									if(*SMTPClient.From.szROM == 0)
										PutHeadersState = PUTHEADERS_TO_INIT;
								}
								else
								{
									SMTPClient.From.szRAM = TCPPutString(MySocket, SMTPClient.From.szRAM);
									if(*SMTPClient.From.szRAM == 0)
										PutHeadersState = PUTHEADERS_TO_INIT;
								}
								break;

							case PUTHEADERS_TO_INIT:
								if(SMTPClient.To.szRAM || SMTPClient.To.szROM)
								{
									PutHeadersState = PUTHEADERS_TO;
									TCPPutROMString(MySocket, (ROM BYTE*)"\r\nTo: ");
								}
								else
								{
									PutHeadersState = PUTHEADERS_CC_INIT;
								}
								break;
								
							case PUTHEADERS_TO:
								if(SMTPClient.ROMPointers.To)
								{
									SMTPClient.To.szROM = TCPPutROMString(MySocket, SMTPClient.To.szROM);
									if(*SMTPClient.To.szROM == 0)
										PutHeadersState = PUTHEADERS_CC_INIT;
								}
								else
								{
									SMTPClient.To.szRAM = TCPPutString(MySocket, SMTPClient.To.szRAM);
									if(*SMTPClient.To.szRAM == 0)
										PutHeadersState = PUTHEADERS_CC_INIT;
								}
								break;

							case PUTHEADERS_CC_INIT:
								if(SMTPClient.CC.szRAM || SMTPClient.CC.szROM)
								{
									PutHeadersState = PUTHEADERS_CC;
									TCPPutROMString(MySocket, (ROM BYTE*)"\r\nCC: ");
								}
								else
								{
									PutHeadersState = PUTHEADERS_SUBJECT_INIT;
								}
								break;
								
							case PUTHEADERS_CC:
								if(SMTPClient.ROMPointers.CC)
								{
									SMTPClient.CC.szROM = TCPPutROMString(MySocket, SMTPClient.CC.szROM);
									if(*SMTPClient.CC.szROM == 0)
										PutHeadersState = PUTHEADERS_SUBJECT_INIT;
								}
								else
								{
									SMTPClient.CC.szRAM = TCPPutString(MySocket, SMTPClient.CC.szRAM);
									if(*SMTPClient.CC.szRAM == 0)
										PutHeadersState = PUTHEADERS_SUBJECT_INIT;
								}
								break;

							case PUTHEADERS_SUBJECT_INIT:
								if(SMTPClient.Subject.szRAM || SMTPClient.Subject.szROM)
								{
									PutHeadersState = PUTHEADERS_SUBJECT;
									TCPPutROMString(MySocket, (ROM BYTE*)"\r\nSubject: ");
								}
								else
								{
									PutHeadersState = PUTHEADERS_OTHER_INIT;
								}
								break;
								
							case PUTHEADERS_SUBJECT:
								if(SMTPClient.ROMPointers.Subject)
								{
									SMTPClient.Subject.szROM = TCPPutROMString(MySocket, SMTPClient.Subject.szROM);
									if(*SMTPClient.Subject.szROM == 0)
										PutHeadersState = PUTHEADERS_OTHER_INIT;
								}
								else
								{
									SMTPClient.Subject.szRAM = TCPPutString(MySocket, SMTPClient.Subject.szRAM);
									if(*SMTPClient.Subject.szRAM == 0)
										PutHeadersState = PUTHEADERS_OTHER_INIT;
								}
								break;

							case PUTHEADERS_OTHER_INIT:
								TCPPutROMArray(MySocket, (ROM BYTE*)"\r\n", 2);
								if(SMTPClient.OtherHeaders.szRAM || SMTPClient.OtherHeaders.szROM)
								{
									PutHeadersState = PUTHEADERS_OTHER;
								}
								else
								{
									TCPPutROMArray(MySocket, (ROM BYTE*)"\r\n", 2);
									PutHeadersState = PUTHEADERS_DONE;
									SMTPState++;
								}
								break;
								
							case PUTHEADERS_OTHER:
								if(SMTPClient.ROMPointers.OtherHeaders)
								{
									SMTPClient.OtherHeaders.szROM = TCPPutROMString(MySocket, SMTPClient.OtherHeaders.szROM);
									if(*SMTPClient.OtherHeaders.szROM == 0)
									{
										TCPPutROMArray(MySocket, (ROM BYTE*)"\r\n", 2);
										PutHeadersState = PUTHEADERS_DONE;
										SMTPState++;
									}
								}
								else
								{
									SMTPClient.OtherHeaders.szRAM = TCPPutString(MySocket, SMTPClient.OtherHeaders.szRAM);
									if(*SMTPClient.OtherHeaders.szRAM == 0)
									{
										TCPPutROMArray(MySocket, (ROM BYTE*)"\r\n", 2);
										PutHeadersState = PUTHEADERS_DONE;
										SMTPState++;
									}
								}
								break;
						}
					}
					TCPFlush(MySocket);
					break;
		
				case SMTP_DATA_BODY_INIT:
					SMTPState++;
					RAMStrPtr = SMTPClient.Body.szRAM;
					ROMStrPtr2 = (ROM BYTE*)"\r\n.\r\n";
					CRPeriod.Pos = (BYTE*)strstrrampgm((char*)RAMStrPtr, (ROM char*)"\r\n.");
					// No break here
		
				case SMTP_DATA_BODY:
					if(SMTPClient.Body.szRAM || SMTPClient.Body.szROM)
					{
						if(*ROMStrPtr2)
						{
							// Put the application data, doing the transparancy replacement of "\r\n." with "\r\n.."
							while(CRPeriod.Pos)
							{
								CRPeriod.Pos += 3;
								RAMStrPtr += TCPPutArray(MySocket, RAMStrPtr, CRPeriod.Pos-RAMStrPtr);
								if(RAMStrPtr == CRPeriod.Pos)
								{
									if(!TCPPut(MySocket, '.'))
									{
										CRPeriod.Pos -= 3;
										break;
									}
								}
								else
								{
									CRPeriod.Pos -= 3;
									break;
								}
								CRPeriod.Pos = (BYTE*)strstrrampgm((char*)RAMStrPtr, (ROM char*)"\r\n.");
							}
							
							// If we get down here, either all replacements have been made or there is no remaining space in the TCP output buffer
							RAMStrPtr = TCPPutString(MySocket, RAMStrPtr);
							ROMStrPtr2 = TCPPutROMString(MySocket, ROMStrPtr2);
							TCPFlush(MySocket);
						}
					}
					else
					{
						if(SMTPFlags.bits.ReadyToFinish)
						{
							if(*ROMStrPtr2)
							{
								ROMStrPtr2 = TCPPutROMString(MySocket, ROMStrPtr2);
								TCPFlush(MySocket);
							}
		
						}
					}

					if(*ROMStrPtr2 == 0u)
					{
						SMTPState++;
					}
					break;
		
				case SMTP_QUIT_INIT:
					SMTPState++;
					ROMStrPtr = (ROM BYTE*)"QUIT\r\n";
					// No break here

				case SMTP_QUIT:
					if(*ROMStrPtr)
					{
						ROMStrPtr = TCPPutROMString(MySocket, ROMStrPtr);
						TCPFlush(MySocket);
					}

					if(*ROMStrPtr == 0u)
					{
						TransportState = TRANSPORT_CLOSE;
					}
					break;
			}
			break;

		case TRANSPORT_CLOSE:
			// Close the socket so it can be used by other modules
			TCPDisconnect(MySocket);
			MySocket = INVALID_SOCKET;

			// Go back to doing nothing
			TransportState = TRANSPORT_HOME;
			break;
	}
}

void SMTPSendMail(void)
{
	SMTPFlags.bits.ReadyToStart = TRUE;
}

BOOL SMTPIsBusy(void)
{
	return TransportState != TRANSPORT_HOME;
}

WORD SMTPIsPutReady(void)
{
	if(SMTPState != SMTP_DATA_BODY)
		return 0;

	return TCPIsPutReady(MySocket);	
}

BOOL SMTPPut(BYTE c)
{
	if(CRPeriod.State == CR_PERIOD_NEED_INSERTION)
	{
		if(TCPPut(MySocket, '.'))
			CRPeriod.State = CR_PERIOD_SEEK_CR;
		else
			return FALSE;
	}

	switch(CRPeriod.State)
	{
		case CR_PERIOD_SEEK_CR:
			if(c == '\r')
				CRPeriod.State++;
			break;

		case CR_PERIOD_SEEK_LF:
			if(c == '\n')
				CRPeriod.State++;
			else if(c != '\r')
				CRPeriod.State--;
			break;

		case CR_PERIOD_SEEK_PERIOD:
			if(c == '.')
				CRPeriod.State++;	// CR_PERIOD_NEED_INSERTION
			else if(c == '\r')
				CRPeriod.State--;
			else
				CRPeriod.State = CR_PERIOD_SEEK_CR;
			break;
	}

	if(!TCPPut(MySocket, c))
		return FALSE;

	return TRUE;
}

WORD SMTPPutArray(BYTE* Data, WORD Len)
{
	WORD result = 0;

	// Must use SMTPPut() instead of TCPPutArray because of transparancy replacements of "\r\n." with "\r\n.."
	while(Len--)
	{
		if(SMTPPut(*Data++))
		{
			result++;
		}
		else
		{
			Data--;
			break;
		}
	}

	return result;
}
WORD SMTPPutROMArray(ROM BYTE* Data, WORD Len)
{
	WORD result = 0;

	// Must use SMTPPut() instead of TCPPutArray because of transparancy replacements of "\r\n." with "\r\n.."
	while(Len--)
	{
		if(SMTPPut(*Data++))
		{
			result++;
		}
		else
		{
			Data--;
			break;
		}
	}

	return result;
}

WORD SMTPPutString(BYTE* Data)
{
	WORD result = 0;

	// Must use SMTPPut() instead of TCPPutArray because of transparancy replacements of "\r\n." with "\r\n.."
	while(*Data)
	{
		if(SMTPPut(*Data++))
		{
			result++;
		}
		else
		{
			Data--;
			break;
		}
	}

	return result;
}

WORD SMTPPutROMString(ROM BYTE* Data)
{
	WORD result = 0;

	// Must use SMTPPut() instead of TCPPutArray because of transparancy replacements of "\r\n." with "\r\n.."
	while(*Data)
	{
		if(SMTPPut(*Data++))
		{
			result++;
		}
		else
		{
			Data--;
			break;
		}
	}

	return result;
}

void SMTPFlush(void)
{
	TCPFlush(MySocket);
}

void SMTPPutDone(void)
{
	SMTPFlags.bits.ReadyToFinish = TRUE;
}


static BYTE *FindEmailAddress(BYTE *str, WORD *wLen)
{
	BYTE *lpStart;
	BYTE c;
	union
	{
		BYTE Val;
		struct
		{
			BYTE FoundOpenBracket	: 1;
			BYTE FoundAt			: 1;
		} bits;
	} ParseStates;

	lpStart = str;
	*wLen = 0x0000;
	ParseStates.Val = 0x00;

	while(c = *str++)
	{	
		if(c == '<')
		{
			ParseStates.bits.FoundOpenBracket = 1;
			lpStart = str;
			*wLen = -1;
		}
		else if(c == '@')
			ParseStates.bits.FoundAt = 1;


		if(	!ParseStates.bits.FoundOpenBracket &&
			!ParseStates.bits.FoundAt &&
			(c == ' ' || c == ','))
		{
			lpStart = str;
			continue;
		}
		else if(c == ',')
			break;

		if(ParseStates.bits.FoundOpenBracket && ParseStates.bits.FoundAt)
		{
			if(c == '>')
				break;
		}
		
		// Advance to next character
		*wLen += 1;
	}

	if(!ParseStates.bits.FoundAt)
		*wLen = 0;

	return lpStart;
}

static ROM BYTE *FindROMEmailAddress(ROM BYTE *str, WORD *wLen)
{
	ROM BYTE *lpStart;
	BYTE c;
	union
	{
		BYTE Val;
		struct
		{
			BYTE FoundOpenBracket	: 1;
			BYTE FoundAt			: 1;
		} bits;
	} ParseStates;

	lpStart = str;
	*wLen = 0x0000;
	ParseStates.Val = 0x00;

	while(c = *str++)
	{	
		if(c == '<')
		{
			ParseStates.bits.FoundOpenBracket = 1;
			lpStart = str;
			*wLen = -1;
		}
		else if(c == '@')
			ParseStates.bits.FoundAt = 1;


		if(	!ParseStates.bits.FoundOpenBracket &&
			!ParseStates.bits.FoundAt &&
			(c == ' ' || c == ','))
		{
			lpStart = str;
			continue;
		}
		else if(c == ',')
			break;

		if(ParseStates.bits.FoundOpenBracket && ParseStates.bits.FoundAt)
		{
			if(c == '>')
				break;
		}
		
		// Advance to next character
		*wLen += 1;
	}

	if(!ParseStates.bits.FoundAt)
		*wLen = 0;

	return lpStart;
}

#endif //#if defined(STACK_USE_SMTP_CLIENT)
