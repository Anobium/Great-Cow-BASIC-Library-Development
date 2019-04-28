/*********************************************************************
 *
 *	Dynamic Host Configuration Protocol (DHCP) Client
 *  Module for Microchip TCP/IP Stack
 *	 -Provides automatic IP address, subnet mask, gateway address, 
 *	  DNS server address, and other configuration parameters on DHCP 
 *	  enabled networks.
 *	 -Reference: RFC 2131, 2132
 *
 *********************************************************************
 * FileName:        DHCP.c
 * Dependencies:    StackTsk.h
 *                  UDP.h
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
 * Nilesh Rajbharti     3/21/01  Original        (Rev 1.0)
 * Nilesh Rajbharti     7/10/02  Explicitly initialized tempIPAddress
 *                                               (Rev 2.11)
 * Nilesh Rajbharti     5/16/03 Increased DHCP_TIMEOUT to 2 seconds.
 * Nilesh Rajbharti     5/16/03 Fixed SM_DHCP_BROADCAST logic
 *                              where UDPPut was called before setting
 *                              active socket.
 * Robert Sloan         5/29/03 Improved DHCP State machine to handle
 *                              NAK and renew existing IP address.
 * Nilesh Rajbharti     8/15/03 Modified _DHCPRecieve() to check for
 *                              chaddr field before accpting the packet.
 *                              Fixed DHCPTask() where it would not
 *                              reply to first OFFER.
 * Nilesh Rajbharti     3/1/04  Used tickDiff in DHCPTask() "bind"
 *                              state to adjust for irregular TICK_SECOND
 *                              Without this logic, actual lease time count
 *                              down may be incorrect.
 * Howard Schlunder		5/11/06	Fixed tickDiff usage, reducing 
 *								accumulated timing error.  Fixed DHCP 
 *								state machine requesting IP 0.0.0.0 
 *								after lease expiration.
 * Howard Schlunder		6/01/06	Added DHCPFlags.bits.bOfferReceived flag to 
 *								allow operation on networks with multiple
 *								DHCP servers offering multiple addresses
 * Howard Schlunder		8/01/06 Added DNS server option to DHCP request, 
 *								untested Host Name option to DHCP request
 * Howard Schlunder		1/09/06	Fixed a DHCP renewal not renewing lease time bug
 * Howard Schlunder		3/16/07 Rewrote DHCP state machine
 ********************************************************************/
#define __DHCP_C
#include "TCPIP Stack/TCPIP.h"

#if defined(STACK_USE_DHCP_CLIENT)


#define DHCP_TIMEOUT                    (TICK)(2*TICK_SECOND)


SM_DHCP smDHCPState = SM_DHCP_GET_SOCKET;
DHCP_CLIENT_FLAGS DHCPFlags = { 0x00 };
BYTE DHCPBindCount = 0;

static UDP_SOCKET DHCPSocket = INVALID_UDP_SOCKET;
static DWORD_VAL DHCPServerID;
static DWORD_VAL DHCPLeaseTime;
static IP_ADDR tempIPAddress;
static IP_ADDR tempGateway;
static IP_ADDR tempMask;
#if defined(STACK_USE_DNS)
static IP_ADDR tempDNS;
static IP_ADDR tempDNS2;
#endif
//static BYTE tempHostName[16];
static union
{
	struct
	{
		char IPAddress:1;
		char Gateway:1;
		char Mask:1;
		char DNS:1;
		char DNS2:1;
		char HostName:1;
	} bits;
	BYTE Val;
} ValidValues;


static BYTE _DHCPReceive(void);
static void _DHCPSend(BYTE messageType);


/*********************************************************************
 * Function:        void DHCPReset(void)
 *
 * PreCondition:    None
 *
 * Input:           None
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        Resets the DHCP client, giving up any lease, 
 *					knowledge of DHCP servers, etc.
 *
 * Note:            None
 ********************************************************************/
void DHCPReset(void)
{
    // Do nothing if DHCP is disabled
    if(smDHCPState == SM_DHCP_DISABLED)
        return;

    if(DHCPSocket != INVALID_UDP_SOCKET)
		smDHCPState = SM_DHCP_SEND_DISCOVERY;
	else
		smDHCPState = SM_DHCP_GET_SOCKET;

    DHCPBindCount = 0;
    DHCPFlags.bits.bIsBound = FALSE;
}


/*********************************************************************
 * Function:        void DHCPTask(void)
 *
 * PreCondition:    DHCPInit() is already called
 *
 * Input:           None
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        Gets and generates DHCP messages to obtain a 
 *					lease and keep it from expiring
 *
 * Note:            None
 ********************************************************************/
void DHCPTask(void)
{
    static TICK eventTime;

    switch(smDHCPState)
    {
		case SM_DHCP_DISABLED:
		    if(DHCPSocket != INVALID_UDP_SOCKET)
			{
		        UDPClose(DHCPSocket);
		    	DHCPSocket = INVALID_UDP_SOCKET;
			}
			break;

		case SM_DHCP_GET_SOCKET:
			// Open a socket to send and receive broadcast messages on
	        DHCPSocket = UDPOpen(DHCP_CLIENT_PORT, NULL, DHCP_SERVER_PORT);
			if(DHCPSocket == INVALID_UDP_SOCKET)
				break;

			smDHCPState = SM_DHCP_SEND_DISCOVERY;
			// No break

		case SM_DHCP_SEND_DISCOVERY:
			if(UDPIsPutReady(DHCPSocket) < 258)
				break;

			// Ensure that we transmit to the broadcast IP and MAC addresses
			// The UDP Socket remembers who it was last talking to
			memset((void*)&UDPSocketInfo[DHCPSocket].remoteNode, 0xFF, sizeof(UDPSocketInfo[DHCPSocket].remoteNode));

		    // Assume default IP Lease time of 60 seconds.
		    // This should be minimum possible to make sure that if
		    // server did not specify lease time, we try again after this minimum time.
		    DHCPLeaseTime.Val = 60;
			ValidValues.Val = 0x00;
			DHCPBindCount = 0;
			DHCPFlags.bits.bIsBound = FALSE;	
			DHCPFlags.bits.bOfferReceived = FALSE;
			
			// Send the DHCP Discover broadcast
			_DHCPSend(DHCP_DISCOVER_MESSAGE);
			
			// Start a timer and begin looking for a response
			eventTime = TickGet() + DHCP_TIMEOUT;
			smDHCPState = SM_DHCP_GET_OFFER;
	        break;

		case SM_DHCP_GET_OFFER:
			// Check to see if a packet has arrived
			if(UDPIsGetReady(DHCPSocket) < 250)
			{
				// Go back and transmit a new discovery if we didn't get an offer after 2 seconds
				if((LONG)(eventTime - TickGet()) <= (LONG)0)
					smDHCPState = SM_DHCP_SEND_DISCOVERY;
				break;
			}

			// Let the DHCP server module know that there is a DHCP server 
			// on this network
			DHCPFlags.bits.bDHCPServerDetected = TRUE;

			// Check to see if we received an offer
			if(_DHCPReceive() != DHCP_OFFER_MESSAGE)
				break;

			smDHCPState = SM_DHCP_SEND_REQUEST;
			// No break

		case SM_DHCP_SEND_REQUEST:
			if(UDPIsPutReady(DHCPSocket) < 258)
				break;

			// Send the DHCP request message
			_DHCPSend(DHCP_REQUEST_MESSAGE);
			
			// Start a timer and begin looking for a response
			eventTime = TickGet() + DHCP_TIMEOUT;
			smDHCPState = SM_DHCP_GET_REQUEST_ACK;
	        break;

		case SM_DHCP_GET_REQUEST_ACK:
			// Check to see if a packet has arrived
			if(UDPIsGetReady(DHCPSocket) < 250)
			{
				// Go back and transmit a new discovery if we didn't get an ACK after 2 seconds
				if((LONG)(eventTime - TickGet()) <= (LONG)0)
					smDHCPState = SM_DHCP_SEND_DISCOVERY;
				break;
			}

			// Check to see if we received an offer
			switch(_DHCPReceive())
			{
				case DHCP_ACK_MESSAGE:
					eventTime = TickGet() + TICK_SECOND;
					smDHCPState = SM_DHCP_BOUND;

	                DHCPFlags.bits.bIsBound = TRUE;	
	                DHCPBindCount++;
					if(ValidValues.bits.IPAddress)
		                AppConfig.MyIPAddr = tempIPAddress;
					if(ValidValues.bits.Mask)
						AppConfig.MyMask = tempMask;
					if(ValidValues.bits.Gateway)
						AppConfig.MyGateway = tempGateway;
					#if defined(STACK_USE_DNS)
						if(ValidValues.bits.DNS)
							AppConfig.PrimaryDNSServer = tempDNS;
						if(ValidValues.bits.DNS2)
							AppConfig.SecondaryDNSServer = tempDNS2;
					#endif
//					if(ValidValues.bits.HostName)
//						memcpy(AppConfig.NetBIOSName, (void*)tempHostName, sizeof(AppConfig.NetBIOSName));

					break;

				case DHCP_NAK_MESSAGE:
					smDHCPState = SM_DHCP_SEND_DISCOVERY;
					break;
			}
			break;

		case SM_DHCP_BOUND:
	        if((LONG)(eventTime - TickGet()) >= (LONG)0)
				break;

			// Check to see if our lease has nearly expired and we must renew
			eventTime += TICK_SECOND;
			DHCPLeaseTime.Val--;
			if(DHCPLeaseTime.Val)
				break;
			
			smDHCPState = SM_DHCP_SEND_RENEW;
			// No break

		case SM_DHCP_SEND_RENEW:
		case SM_DHCP_SEND_RENEW2:
		case SM_DHCP_SEND_RENEW3:
			if(UDPIsPutReady(DHCPSocket) < 258)
				break;

			// Send the DHCP request message
			_DHCPSend(DHCP_REQUEST_MESSAGE);
			DHCPFlags.bits.bOfferReceived = FALSE;
			
			// Start a timer and begin looking for a response
			eventTime = TickGet() + DHCP_TIMEOUT;
			smDHCPState++;
			break;

		case SM_DHCP_GET_RENEW_ACK:
		case SM_DHCP_GET_RENEW_ACK2:
		case SM_DHCP_GET_RENEW_ACK3:
			// Check to see if a packet has arrived
			if(UDPIsGetReady(DHCPSocket) < 250)
			{
				// Go back and transmit a new discovery if we didn't get an ACK after 2 seconds
				if((LONG)(eventTime - TickGet()) <= (LONG)0)
				{
					if(++smDHCPState > SM_DHCP_GET_RENEW_ACK3)
						smDHCPState = SM_DHCP_SEND_DISCOVERY;
				}
				break;
			}

			// Check to see if we received an offer
			switch(_DHCPReceive())
			{
				case DHCP_ACK_MESSAGE:
					eventTime = TickGet() + TICK_SECOND;
					DHCPBindCount++;
					smDHCPState = SM_DHCP_BOUND;
					break;

				case DHCP_NAK_MESSAGE:
					smDHCPState = SM_DHCP_SEND_DISCOVERY;
					break;
			}
			break;
	}
}



/*********************************************************************
        DHCP PACKET FORMAT AS PER RFC 1541

   0                   1                   2                   3
   0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |     op (1)    |   htype (1)   |   hlen (1)    |   hops (1)    |
   +---------------+---------------+---------------+---------------+
   |                            xid (4)                            |
   +-------------------------------+-------------------------------+
   |           secs (2)            |           flags (2)           |
   +-------------------------------+-------------------------------+
   |                          ciaddr  (4)                          |
   +---------------------------------------------------------------+
   |                          yiaddr  (4)                          |
   +---------------------------------------------------------------+
   |                          siaddr  (4)                          |
   +---------------------------------------------------------------+
   |                          giaddr  (4)                          |
   +---------------------------------------------------------------+
   |                                                               |
   |                          chaddr  (16)                         |
   |                                                               |
   |                                                               |
   +---------------------------------------------------------------+
   |                                                               |
   |                          sname   (64)                         |
   +---------------------------------------------------------------+
   |                                                               |
   |                          file    (128)                        |
   +---------------------------------------------------------------+
   |                                                               |
   |                          options (312)                        |
   +---------------------------------------------------------------+

 ********************************************************************/
static BYTE _DHCPReceive(void)
{
    BYTE v;
    BYTE i, j;
    BYTE type;
    BOOL lbDone;
    DWORD_VAL tempServerID;


    // Assume unknown message until proven otherwise.
    type = DHCP_UNKNOWN_MESSAGE;

    UDPGet(&v);                             // op
    
    // Make sure this is BOOT_REPLY.
    if ( v == BOOT_REPLY )
    {
        // Discard htype, hlen, hops, xid, secs, flags, ciaddr.
        for ( i = 0; i < 15u; i++ )
            UDPGet(&v);

		// Check to see if this is the first offer
		if(DHCPFlags.bits.bOfferReceived)
		{
	        // Discard offered IP address, we already have an offer
	        for ( i = 0; i < 4u; i++ )
	            UDPGet(&v);
		}
		else
		{
	        // Save offered IP address until we know for sure that we have it.
			UDPGetArray((BYTE*)&tempIPAddress, sizeof(tempIPAddress));
			ValidValues.bits.IPAddress = 1;
		}

        // Ignore siaddr, giaddr
        for ( i = 0; i < 8u; i++ )
            UDPGet(&v);

        // Check to see if chaddr (Client Hardware Address) belongs to us.
        for ( i = 0; i < 6u; i++ )
        {
            UDPGet(&v);
            if ( v != AppConfig.MyMACAddr.v[i])
                goto UDPInvalid;
        }


        // Ignore part of chaddr, sname, file, magic cookie.
        for ( i = 0; i < 206u; i++ )
            UDPGet(&v);

        lbDone = FALSE;
        do
        {
			// Get the Option number
			// Break out eventually in case if this is a malformed 
			// DHCP message, ie: missing DHCP_END_OPTION marker
			if(!UDPGet(&v))
			{
				lbDone = TRUE;
				break;
			}

            switch(v)
            {
            case DHCP_MESSAGE_TYPE:
                UDPGet(&v);                         // Skip len
                // Len must be 1.
                if ( v == 1u )
                {
                    UDPGet(&type);                  // Get type

					// Throw away the packet if we know we don't need it (ie: another offer when we already have one)
					if(DHCPFlags.bits.bOfferReceived && (type == DHCP_OFFER_MESSAGE))
					{
						goto UDPInvalid;
					}
                }
                else
                    goto UDPInvalid;
                break;

            case DHCP_SUBNET_MASK:
                UDPGet(&v);                     // Skip len
                // Len must be 4.
                if ( v == 4u )
                {
					// Check to see if this is the first offer
					if(DHCPFlags.bits.bOfferReceived)
					{
				        // Discard offered IP mask, we already have an offer
				        for ( i = 0; i < 4u; i++ )
				            UDPGet(&v);
					}
					else
					{
						UDPGetArray((BYTE*)&tempMask, sizeof(tempMask));
						ValidValues.bits.Mask = 1;
					}
                }
                else
                    goto UDPInvalid;
                break;

            case DHCP_ROUTER:
                UDPGet(&j);
                // Len must be >= 4.
                if ( j >= 4u )
                {
					// Check to see if this is the first offer
					if(DHCPFlags.bits.bOfferReceived)
					{
				        // Discard offered Gateway address, we already have an offer
				        for ( i = 0; i < 4u; i++ )
				            UDPGet(&v);
					}
					else
					{
						UDPGetArray((BYTE*)&tempGateway, sizeof(tempGateway));
						ValidValues.bits.Gateway = 1;
					}
                }
                else
                    goto UDPInvalid;

                // Discard any other router addresses.
                j -= 4;
                while(j--)
                    UDPGet(&v);
                break;

#if defined(STACK_USE_DNS)
            case DHCP_DNS:
                UDPGet(&j);
                // Len must be >= 4.
                if(j < 4u)
                    goto UDPInvalid;

				// Check to see if this is the first offer
				if(!DHCPFlags.bits.bOfferReceived)
				{
					UDPGetArray((BYTE*)&tempDNS, sizeof(tempDNS));
					ValidValues.bits.DNS = 1;
					j -= 4;
				}

				// Len must be >= 4 for a secondary DNS server address
				if(j >= 4u)
				{
					// Check to see if this is the first offer
					if(!DHCPFlags.bits.bOfferReceived)
					{
						UDPGetArray((BYTE*)&tempDNS2, sizeof(tempDNS2));
						ValidValues.bits.DNS2 = 1;
						j -= 4;
					}
				}

                // Discard any other DNS server addresses
                while(j--)
                    UDPGet(&v);
                break;
#endif

//            case DHCP_HOST_NAME:
//                UDPGet(&j);
//                // Len must be >= 4.
//                if(j < 1u)
//					goto UDPInvalid;
//
//				// Check to see if this is the first offer
//				if(DHCPFlags.bits.bOfferReceived)
//				{
//			        // Discard offered host name, we already have an offer
//	                while(j--)
//	                    UDPGet(&v);
//				}
//				else
//				{
//					for(i = 0; j, i < sizeof(tempHostName); i++, j--)
//					{
//						UDPGet(&tempHostName[i]);
//					}
//					while(j--)
//					{
//						UDPGet(&v);
//					}
//					ValidValues.bits.HostName = 1;
//				}
//
//                break;

            case DHCP_SERVER_IDENTIFIER:
                UDPGet(&v);                         // Get len
                // Len must be 4.
                if ( v == 4u )
                {
                    UDPGet(&tempServerID.v[3]);   // Get the id
                    UDPGet(&tempServerID.v[2]);
                    UDPGet(&tempServerID.v[1]);
                    UDPGet(&tempServerID.v[0]);
                }
                else
                    goto UDPInvalid;
                break;

            case DHCP_END_OPTION:
                lbDone = TRUE;
                break;

            case DHCP_IP_LEASE_TIME:
                UDPGet(&v);                         // Get len
                // Len must be 4.
                if ( v == 4u )
                {
					// Check to see if this is the first offer
					if(DHCPFlags.bits.bOfferReceived)
					{
				        // Discard offered lease time, we already have an offer
				        for ( i = 0; i < 4u; i++ )
				            UDPGet(&v);
					}
					else
					{
	                    UDPGet(&DHCPLeaseTime.v[3]);
	                    UDPGet(&DHCPLeaseTime.v[2]);
	                    UDPGet(&DHCPLeaseTime.v[1]);
	                    UDPGet(&DHCPLeaseTime.v[0]);

	                    // In case if our clock is not as accurate as the remote 
						// DHCP server's clock, let's treat the lease time as only 
						// 96.875% of the value given
						DHCPLeaseTime.Val -= DHCPLeaseTime.Val>>5;
					}
                }
                else
                    goto UDPInvalid;
                break;

            default:
                // Ignore all unsupport tags.
                UDPGet(&j);                     // Get option len
                while( j-- )                    // Ignore option values
                    UDPGet(&v);
            }
        } while( !lbDone );
    }

    // If this is an OFFER message, remember current server id.
    if ( type == DHCP_OFFER_MESSAGE )
    {
        DHCPServerID.Val = tempServerID.Val;
		DHCPFlags.bits.bOfferReceived = TRUE;
    }
    else
    {
        // For other types of messages, make sure that received
        // server id matches with our previous one.
        if ( DHCPServerID.Val != tempServerID.Val )
            type = DHCP_UNKNOWN_MESSAGE;
    }

    UDPDiscard();                             // We are done with this packet
    return type;

UDPInvalid:
    UDPDiscard();
    return DHCP_UNKNOWN_MESSAGE;

}





static void _DHCPSend(BYTE messageType)
{
    BYTE i;
	IP_ADDR	MyIP;


    UDPPut(BOOT_REQUEST);                       // op
    UDPPut(BOOT_HW_TYPE);                       // htype
    UDPPut(BOOT_LEN_OF_HW_TYPE);                // hlen
    UDPPut(0);                                  // hops
    UDPPut(0x12);                               // xid[0]
    UDPPut(0x23);                               // xid[1]
    UDPPut(0x34);                               // xid[2]
    UDPPut(0x56);                               // xid[3]
    UDPPut(0);                                  // secs[0]
    UDPPut(0);                                  // secs[1]
    UDPPut(0x80);                               // flags[0] with BF set
    UDPPut(0);                                  // flags[1]

    // If this is DHCP REQUEST message, use previously allocated IP address.
#if 0
    if ( messageType == DHCP_REQUEST_MESSAGE )
    {
		UDPPutArray((BYTE*)&tempIPAddress, sizeof(tempIPAddress));
    }
    else
#endif
    {
        UDPPut(0x00);
        UDPPut(0x00);
        UDPPut(0x00);
        UDPPut(0x00);
    }

    // Set yiaddr, siaddr, giaddr as zeros,
    for ( i = 0; i < 12u; i++ )
        UDPPut(0x00);

    // Load chaddr - Client hardware address.
	UDPPutArray((BYTE*)&AppConfig.MyMACAddr, sizeof(AppConfig.MyMACAddr));

    // Set chaddr[6..15], sname and file as zeros.
    for ( i = 0; i < 202u; i++ )
        UDPPut(0);

    // Load magic cookie as per RFC 1533.
    UDPPut(99);
    UDPPut(130);
    UDPPut(83);
    UDPPut(99);

    // Load message type.
    UDPPut(DHCP_MESSAGE_TYPE);
    UDPPut(DHCP_MESSAGE_TYPE_LEN);
    UDPPut(messageType);

	if(messageType == DHCP_DISCOVER_MESSAGE)
	{
		// Reset offered flag so we know to act upon the next valid offer
		DHCPFlags.bits.bOfferReceived = FALSE;
	}


    if ( messageType != DHCP_DISCOVER_MESSAGE && tempIPAddress.Val != 0x0000u )
    {
         // DHCP REQUEST message may include server identifier,
         // to identify the server we are talking to.
         // DHCP ACK may include it too.  To simplify logic,
         // we will include server identifier in DHCP ACK message too.
         // _DHCPReceive() would populate "serverID" when it
         // receives DHCP OFFER message. We will simply use that
         // when we are replying to server.
         // If this is a renwal request, do not include server id.
         UDPPut(DHCP_SERVER_IDENTIFIER);
         UDPPut(DHCP_SERVER_IDENTIFIER_LEN);
         UDPPut(DHCPServerID.v[3]);
         UDPPut(DHCPServerID.v[2]);
         UDPPut(DHCPServerID.v[1]);
         UDPPut(DHCPServerID.v[0]);
     }

    // Load our interested parameters
    // This is hardcoded list.  If any new parameters are desired,
    // new lines must be added here.
    UDPPut(DHCP_PARAM_REQUEST_LIST);
    UDPPut(DHCP_PARAM_REQUEST_LIST_LEN);
    UDPPut(DHCP_SUBNET_MASK);
    UDPPut(DHCP_ROUTER);
	UDPPut(DHCP_DNS);
	UDPPut(DHCP_HOST_NAME);

     // Add requested IP address to DHCP Request Message
    if ( messageType == DHCP_REQUEST_MESSAGE )
    {
        UDPPut(DHCP_PARAM_REQUEST_IP_ADDRESS);
        UDPPut(DHCP_PARAM_REQUEST_IP_ADDRESS_LEN);
		UDPPutArray((BYTE*)&tempIPAddress, DHCP_PARAM_REQUEST_IP_ADDRESS_LEN);
    }

    // Add any new paramter request here.

    // End of Options.
    UDPPut(DHCP_END_OPTION);

	// Make sure we advirtise a 0.0.0.0 IP address so all DHCP servers will respond.  If we have a static IP outside the DHCP server's scope, it may simply ignore discover messages.
	MyIP.Val = AppConfig.MyIPAddr.Val;
	AppConfig.MyIPAddr.Val = 0x00000000;
    UDPFlush();
	AppConfig.MyIPAddr.Val = MyIP.Val;
	
}


#endif	//#if defined(STACK_USE_DHCP_CLIENT)
