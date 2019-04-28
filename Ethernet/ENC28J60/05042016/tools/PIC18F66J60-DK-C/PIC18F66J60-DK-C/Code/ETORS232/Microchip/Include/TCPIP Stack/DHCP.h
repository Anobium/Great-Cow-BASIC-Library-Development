/*********************************************************************
 *
 *                  DHCP Defs for Microchip TCP/IP Stack
 *
 *********************************************************************
 * FileName:        DHCP.h
 * Dependencies:    TCPIPStack.h
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
 ********************************************************************/
#ifndef __DHCP_H
#define __DHCP_H

#define DHCP_CLIENT_PORT                (68u)
#define DHCP_SERVER_PORT                (67u)

#define BOOT_REQUEST                    (1u)
#define BOOT_REPLY                      (2u)
#define BOOT_HW_TYPE                    (1u)
#define BOOT_LEN_OF_HW_TYPE             (6u)

#define DHCP_MESSAGE_TYPE               (53u)
#define DHCP_MESSAGE_TYPE_LEN           (1u)

#define DHCP_UNKNOWN_MESSAGE            (0u)

#define DHCP_DISCOVER_MESSAGE           (1u)
#define DHCP_OFFER_MESSAGE              (2u)
#define DHCP_REQUEST_MESSAGE            (3u)
#define DHCP_DECLINE_MESSAGE            (4u)
#define DHCP_ACK_MESSAGE                (5u)
#define DHCP_NAK_MESSAGE                (6u)
#define DHCP_RELEASE_MESSAGE            (7u)

#define DHCP_SERVER_IDENTIFIER          (54u)
#define DHCP_SERVER_IDENTIFIER_LEN      (4u)

#define DHCP_OPTION_ACK_MESSAGE			(53u)
#define DHCP_PARAM_REQUEST_LIST         (55u)
#define DHCP_PARAM_REQUEST_LIST_LEN     (4u)
#define DHCP_PARAM_REQUEST_IP_ADDRESS       (50u)
#define DHCP_PARAM_REQUEST_IP_ADDRESS_LEN   (4u)
#define DHCP_SUBNET_MASK                (1u)
#define DHCP_ROUTER                     (3u)
#define DHCP_DNS						(6u)
#define DHCP_HOST_NAME					(12u)
#define DHCP_IP_LEASE_TIME              (51u)
#define DHCP_END_OPTION                 (255u)


typedef struct _BOOTP_HEADER
{
	BYTE		MessageType;
	BYTE		HardwareType;
	BYTE		HardwareLen;
	BYTE		Hops;
	DWORD		TransactionID;
	WORD		SecondsElapsed;
	WORD		BootpFlags;
	IP_ADDR		ClientIP;
	IP_ADDR		YourIP;
	IP_ADDR		NextServerIP;
	IP_ADDR		RelayAgentIP;
	MAC_ADDR	ClientMAC;
} BOOTP_HEADER;


typedef enum _SM_DHCP
{
	SM_DHCP_DISABLED = 0,
	SM_DHCP_GET_SOCKET,
	SM_DHCP_SEND_DISCOVERY,
	SM_DHCP_GET_OFFER,
	SM_DHCP_SEND_REQUEST,
	SM_DHCP_GET_REQUEST_ACK,
	SM_DHCP_BOUND,
	SM_DHCP_SEND_RENEW,
	SM_DHCP_GET_RENEW_ACK,
	SM_DHCP_SEND_RENEW2,
	SM_DHCP_GET_RENEW_ACK2,
	SM_DHCP_SEND_RENEW3,
	SM_DHCP_GET_RENEW_ACK3
} SM_DHCP;


typedef union _DHCP_CLIENT_FLAGS
{
    struct
    {
        unsigned char bIsBound : 1;
        unsigned char bOfferReceived : 1;
		unsigned char bDHCPServerDetected : 1;
    } bits;
    BYTE Val;
} DHCP_CLIENT_FLAGS;

#if !defined(__DHCP_C)
    extern DHCP_CLIENT_FLAGS DHCPFlags;
    extern SM_DHCP smDHCPState;
	extern BYTE DHCPBindCount;
#endif

void DHCPReset(void);
void DHCPTask(void);
void DHCPServerTask(void);

/*********************************************************************
 * Macro:           void DHCPEnable(void)
 *
 * PreCondition:    None
 *
 * Input:           None
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        
 *
 * Note:            
 ********************************************************************/
#define DHCPEnable()       (smDHCPState = SM_DHCP_GET_SOCKET)


/*********************************************************************
 * Macro:           void DHCPDisable(void)
 *
 * PreCondition:    None
 *
 * Input:           None
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        Puts DHCPTask into unhandled state "SM_DHCP_DISABLED"
 *                  and hence DHCP is effictively disabled.
 *
 * Note:            This macro should be called before DHCPTask is called
 *                  or else a UDP port will be kept open and there will
 *                  be no task to process it.
 ********************************************************************/
#define DHCPDisable()       (smDHCPState = SM_DHCP_DISABLED)


/*********************************************************************
 * Macro:           BOOL DHCPIsBound(void)
 *
 * PreCondition:    None
 *
 * Input:           None
 *
 * Output:          TRUE if DHCP is bound to given configuration
 *                  FALSE if DHCP has yet to be bound.
 *
 * Side Effects:    None
 *
 * Overview:        None
 *
 * Note:
 ********************************************************************/
#define DHCPIsBound()       (DHCPFlags.bits.bIsBound)

#endif
