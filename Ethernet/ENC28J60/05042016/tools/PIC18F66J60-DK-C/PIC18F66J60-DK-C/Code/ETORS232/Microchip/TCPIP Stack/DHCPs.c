/*********************************************************************
 *
 *  Dynamic Host Configuration Protocol (DHCP) Server
 *  Module for Microchip TCP/IP Stack
 *	 -Provides automatic IP address, subnet mask, gateway address, 
 *	  DNS server address, and other configuration parameters on DHCP 
 *	  enabled networks.
 *	 -Reference: RFC 2131, 2132
 *
 *********************************************************************
 * FileName:        DHCPs.c
 * Dependencies:    UDP, ARP, Tick
 * Processor:       PIC18, PIC24F, PIC24H, dsPIC30F, dsPIC33F
 * Complier:        Microchip C18 v3.10 or higher
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
 * Author               Date    	Comment
 *~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * Howard Schlunder     02/28/07	Original
 ********************************************************************/
#define __DHCPS_C

#include "TCPIP Stack/TCPIP.h"

#if defined(STACK_USE_DHCP_SERVER)

#define DHCP_LEASE_DURATION				10ul	// Seconds.  This is extremely short so the client(s) won't use our IP address for long if we inadvertently give out a DHCP lease while there is another DHCP server on this network that we didn't know about.
//#define DHCP_MAX_LEASES				2		// Not implemented

// ClientMAC multicast bit is used to determine if a lease is given out or not.
// Lease IP address is derived from index into DCB array
typedef struct _DHCP_CONTROL_BLOCK
{
	TICK 		LeaseExpires;
	MAC_ADDR	ClientMAC;
	enum 
	{
		LEASE_UNUSED = 0,
		LEASE_REQUESTED,
		LEASE_GRANTED
	} smLease;
} DHCP_CONTROL_BLOCK;


static UDP_SOCKET			MySocket;
static IP_ADDR				DHCPNextLease;
//static DHCP_CONTROL_BLOCK	DCB[DHCP_MAX_LEASES];	// Not Implmented
BOOL 						bDHCPServerEnabled = TRUE;

static void DHCPReplyToDiscovery(BOOTP_HEADER *Header);
static void DHCPReplyToRequest(BOOTP_HEADER *Header, BOOL bAccept);


/*********************************************************************
 * Function:        void DHCPServerTask(void)
 *
 * PreCondition:    None
 *
 * Input:           None
 *
 * Output:          Processes DHCP requests and distributes IP 
 *					addresses
 *
 * Side Effects:    None
 *
 * Overview:        None
 *
 * Note:            None
 ********************************************************************/
void DHCPServerTask(void)
{
	BYTE 				i;
	BYTE				Option, Len;
	BOOTP_HEADER		BOOTPHeader;
	DWORD				dw;
	BOOL				bAccept;
	static enum
	{
		DHCP_OPEN_SOCKET,
		DHCP_LISTEN
	} smDHCPServer = DHCP_OPEN_SOCKET;

#if defined(STACK_USE_DHCP_CLIENT)
	// Make sure we don't clobber anyone else's DHCP server
	if(DHCPFlags.bits.bDHCPServerDetected)
		return;
#endif

	if(!bDHCPServerEnabled)
		return;

	switch(smDHCPServer)
	{
		case DHCP_OPEN_SOCKET:
			// Obtain a UDP socket to listen/transmit on
			MySocket = UDPOpen(DHCP_SERVER_PORT, NULL, DHCP_CLIENT_PORT);
			if(MySocket == INVALID_UDP_SOCKET)
				break;


			// Decide which address to lease out
			// Note that this needs to be changed if we are to 
			// support more than one lease
			DHCPNextLease.Val = (AppConfig.MyIPAddr.Val & AppConfig.MyMask.Val) + 0x02000000;
			if(DHCPNextLease.v[3] == 255)
				DHCPNextLease.v[3] += 0x03000000;
			if(DHCPNextLease.v[3] == 0)
				DHCPNextLease.Val += 0x02000000;

			smDHCPServer++;

		case DHCP_LISTEN:
			// Check to see if a valid DHCP packet has arrived
			if(UDPIsGetReady(MySocket) < 241)
				break;

			// Retrieve the BOOTP header
			UDPGetArray((BYTE*)&BOOTPHeader, sizeof(BOOTPHeader));

			bAccept = (BOOTPHeader.ClientIP.Val == DHCPNextLease.Val) || (BOOTPHeader.ClientIP.Val == 0x00000000);

			// Validate first three fields
			if(BOOTPHeader.MessageType != 1u)
				break;
			if(BOOTPHeader.HardwareType != 1u)
				break;
			if(BOOTPHeader.HardwareLen != 6u)
				break;

			// Throw away 10 unused bytes of hardware address,
			// server host name, and boot file name -- unsupported/not needed.
			for(i = 0; i < 64+128+(16-sizeof(MAC_ADDR)); i++)
				UDPGet(&Option);

			// Obtain Magic Cookie and verify
			UDPGetArray((BYTE*)&dw, sizeof(DWORD));
			if(dw != 0x63538263ul)
				break;

			// Obtain options
			while(1)
			{
				// Get option type
				if(!UDPGet(&Option))
					break;
				if(Option == DHCP_END_OPTION)
					break;

				// Get option length
				UDPGet(&Len);
	
				// Process option
				switch(Option)
				{
					case DHCP_MESSAGE_TYPE:
						UDPGet(&i);
						switch(i)
						{
							case DHCP_DISCOVER_MESSAGE:
								DHCPReplyToDiscovery(&BOOTPHeader);
								break;

							case DHCP_REQUEST_MESSAGE:
								DHCPReplyToRequest(&BOOTPHeader, bAccept);
								break;

							// Need to handle these if supporting more than one DHCP lease
							case DHCP_RELEASE_MESSAGE:
							case DHCP_DECLINE_MESSAGE:
								break;
						}
						break;

					case DHCP_PARAM_REQUEST_IP_ADDRESS:
						if(Len == 4)
						{
							// Get the requested IP address and see if it is the one we have on offer.
							UDPGetArray((BYTE*)&dw, 4);
							bAccept = (dw == DHCPNextLease.Val);
						}
						break;

					case DHCP_END_OPTION:
						UDPDiscard();
						return;
				}

				// Remove any unprocessed bytes that we don't care about
				while(Len--)
				{
					UDPGet(&i);
				}
			}			

			UDPDiscard();
			break;
	}
}

static void DHCPReplyToDiscovery(BOOTP_HEADER *Header)
{
	BYTE i;

	// Set the correct socket to active and ensure that 
	// enough space is available to generate the DHCP response
	if(UDPIsPutReady(MySocket) < 300)
		return;

	// Begin putting the BOOTP Header and DHCP options
	UDPPut(BOOT_REPLY);			// Message Type: 2 (BOOTP Reply)
	// Reply with the same Hardware Type, Hardware Address Length, Hops, and Transaction ID fields
	UDPPutArray((BYTE*)&(Header->HardwareType), 7);
	UDPPut(0x00);				// Seconds Elapsed: 0 (Not used)
	UDPPut(0x00);				// Seconds Elapsed: 0 (Not used)
	UDPPutArray((BYTE*)&(Header->BootpFlags), sizeof(Header->BootpFlags));
	UDPPut(0x00);				// Your (client) IP Address: 0.0.0.0 (none yet assigned)
	UDPPut(0x00);				// Your (client) IP Address: 0.0.0.0 (none yet assigned)
	UDPPut(0x00);				// Your (client) IP Address: 0.0.0.0 (none yet assigned)
	UDPPut(0x00);				// Your (client) IP Address: 0.0.0.0 (none yet assigned)
	UDPPutArray((BYTE*)&DHCPNextLease, sizeof(IP_ADDR));	// Lease IP address to give out
	UDPPut(0x00);				// Next Server IP Address: 0.0.0.0 (not used)
	UDPPut(0x00);				// Next Server IP Address: 0.0.0.0 (not used)
	UDPPut(0x00);				// Next Server IP Address: 0.0.0.0 (not used)
	UDPPut(0x00);				// Next Server IP Address: 0.0.0.0 (not used)
	UDPPut(0x00);				// Relay Agent IP Address: 0.0.0.0 (not used)
	UDPPut(0x00);				// Relay Agent IP Address: 0.0.0.0 (not used)
	UDPPut(0x00);				// Relay Agent IP Address: 0.0.0.0 (not used)
	UDPPut(0x00);				// Relay Agent IP Address: 0.0.0.0 (not used)
	UDPPutArray((BYTE*)&(Header->ClientMAC), sizeof(MAC_ADDR));	// Client MAC address: Same as given by client
	for(i = 0; i < 64+128+(16-sizeof(MAC_ADDR)); i++)	// Remaining 10 bytes of client hardware address, server host name: Null string (not used)
		UDPPut(0x00);									// Boot filename: Null string (not used)
	UDPPut(0x63);				// Magic Cookie: 0x63538263
	UDPPut(0x82);				// Magic Cookie: 0x63538263
	UDPPut(0x53);				// Magic Cookie: 0x63538263
	UDPPut(0x63);				// Magic Cookie: 0x63538263
	
	// Options: DHCP Offer
	UDPPut(DHCP_MESSAGE_TYPE);	
	UDPPut(1);
	UDPPut(DHCP_OFFER_MESSAGE);

	// Option: Subnet Mask
	UDPPut(DHCP_SUBNET_MASK);
	UDPPut(sizeof(IP_ADDR));
	UDPPutArray((BYTE*)&AppConfig.MyMask, sizeof(IP_ADDR));

	// Option: Lease duration
	UDPPut(DHCP_IP_LEASE_TIME);
	UDPPut(4);
	UDPPut((DHCP_LEASE_DURATION>>24) & 0xFF);
	UDPPut((DHCP_LEASE_DURATION>>16) & 0xFF);
	UDPPut((DHCP_LEASE_DURATION>>8) & 0xFF);
	UDPPut((DHCP_LEASE_DURATION) & 0xFF);

	// Option: Server identifier
	UDPPut(DHCP_SERVER_IDENTIFIER);	
	UDPPut(sizeof(IP_ADDR));
	UDPPutArray((BYTE*)&AppConfig.MyIPAddr, sizeof(IP_ADDR));

	// Option: Router/Gateway address
	UDPPut(DHCP_ROUTER);		
	UDPPut(sizeof(IP_ADDR));
	UDPPutArray((BYTE*)&AppConfig.MyIPAddr, sizeof(IP_ADDR));

	// No more options, mark ending
	UDPPut(DHCP_END_OPTION);

	// Transmit the packet
	UDPFlush();
}


// TODO: Handle more than one DHCP lease
static void DHCPReplyToRequest(BOOTP_HEADER *Header, BOOL bAccept)
{
	BYTE i;

	// Set the correct socket to active and ensure that 
	// enough space is available to generate the DHCP response
	if(UDPIsPutReady(MySocket) < 300)
		return;

	// Search through all remaining options and look for the Requested IP address field
	// Obtain options
	while(UDPIsGetReady(MySocket))
	{
		BYTE Option, Len;
		DWORD dw;

		// Get option type
		if(!UDPGet(&Option))
			break;
		if(Option == DHCP_END_OPTION)
			break;

		// Get option length
		UDPGet(&Len);

		// Process option
		if((Option == DHCP_PARAM_REQUEST_IP_ADDRESS) && (Len == 4))
		{
			// Get the requested IP address and see if it is the one we have on offer.  If not, we should send back a NAK, but since there could be some other DHCP server offering this address, we'll just silently ignore this request.
			UDPGetArray((BYTE*)&dw, 4);
			if(dw != DHCPNextLease.Val)
			{
				bAccept = FALSE;
			}
			break;
		}

		// Remove the unprocessed bytes that we don't care about
		while(Len--)
		{
			UDPGet(&i);
		}
	}			


#if defined(STACK_USE_DHCP_CLIENT)
	// Someone is using our DHCP server, start using a static 
	// IP address and update the bind count so it displays on 
	// the LCD
	AppConfig.Flags.bInConfigMode = FALSE;
	DHCPBindCount++;
#endif

	// Begin putting the BOOTP Header and DHCP options
	UDPPut(BOOT_REPLY);			// Message Type: 2 (BOOTP Reply)
	// Reply with the same Hardware Type, Hardware Address Length, Hops, and Transaction ID fields
	UDPPutArray((BYTE*)&(Header->HardwareType), 7);
	UDPPut(0x00);				// Seconds Elapsed: 0 (Not used)
	UDPPut(0x00);				// Seconds Elapsed: 0 (Not used)
	UDPPutArray((BYTE*)&(Header->BootpFlags), sizeof(Header->BootpFlags));
	UDPPutArray((BYTE*)&(Header->ClientIP), sizeof(IP_ADDR));// Your (client) IP Address:
	UDPPutArray((BYTE*)&DHCPNextLease, sizeof(IP_ADDR));	// Lease IP address to give out
	UDPPut(0x00);				// Next Server IP Address: 0.0.0.0 (not used)
	UDPPut(0x00);				// Next Server IP Address: 0.0.0.0 (not used)
	UDPPut(0x00);				// Next Server IP Address: 0.0.0.0 (not used)
	UDPPut(0x00);				// Next Server IP Address: 0.0.0.0 (not used)
	UDPPut(0x00);				// Relay Agent IP Address: 0.0.0.0 (not used)
	UDPPut(0x00);				// Relay Agent IP Address: 0.0.0.0 (not used)
	UDPPut(0x00);				// Relay Agent IP Address: 0.0.0.0 (not used)
	UDPPut(0x00);				// Relay Agent IP Address: 0.0.0.0 (not used)
	UDPPutArray((BYTE*)&(Header->ClientMAC), sizeof(MAC_ADDR));	// Client MAC address: Same as given by client
	for(i = 0; i < 64+128+(16-sizeof(MAC_ADDR)); i++)	// Remaining 10 bytes of client hardware address, server host name: Null string (not used)
		UDPPut(0x00);									// Boot filename: Null string (not used)
	UDPPut(0x63);				// Magic Cookie: 0x63538263
	UDPPut(0x82);				// Magic Cookie: 0x63538263
	UDPPut(0x53);				// Magic Cookie: 0x63538263
	UDPPut(0x63);				// Magic Cookie: 0x63538263
	
	// Options: DHCP lease ACKnowledge
	if(bAccept)
	{
		UDPPut(DHCP_OPTION_ACK_MESSAGE);	
		UDPPut(1);
		UDPPut(DHCP_ACK_MESSAGE);
	}
	else	// Send a NACK
	{
		UDPPut(DHCP_OPTION_ACK_MESSAGE);	
		UDPPut(1);
		UDPPut(DHCP_NAK_MESSAGE);
	}

	// Option: Lease duration
	UDPPut(DHCP_IP_LEASE_TIME);
	UDPPut(4);
	UDPPut((DHCP_LEASE_DURATION>>24) & 0xFF);
	UDPPut((DHCP_LEASE_DURATION>>16) & 0xFF);
	UDPPut((DHCP_LEASE_DURATION>>8) & 0xFF);
	UDPPut((DHCP_LEASE_DURATION) & 0xFF);

	// Option: Server identifier
	UDPPut(DHCP_SERVER_IDENTIFIER);	
	UDPPut(sizeof(IP_ADDR));
	UDPPutArray((BYTE*)&AppConfig.MyIPAddr, sizeof(IP_ADDR));

	// Option: Subnet Mask
	UDPPut(DHCP_SUBNET_MASK);
	UDPPut(sizeof(IP_ADDR));
	UDPPutArray((BYTE*)&AppConfig.MyMask, sizeof(IP_ADDR));

	// Option: Router/Gateway address
	UDPPut(DHCP_ROUTER);		
	UDPPut(sizeof(IP_ADDR));
	UDPPutArray((BYTE*)&AppConfig.MyIPAddr, sizeof(IP_ADDR));

	// No more options, mark ending
	UDPPut(DHCP_END_OPTION);

	// Transmit the packet
	UDPFlush();
}

#endif //#if defined(STACK_USE_DHCP_SERVER)
