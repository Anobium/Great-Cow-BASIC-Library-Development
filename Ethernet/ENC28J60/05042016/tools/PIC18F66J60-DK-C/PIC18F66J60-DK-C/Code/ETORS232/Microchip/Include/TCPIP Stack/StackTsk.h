/*********************************************************************
 *
 *                  Microchip TCP/IP Stack Definitions
 *
 *********************************************************************
 * FileName:        StackTsk.h
 * Dependencies:    Compiler.h
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
 * Nilesh Rajbharti     8/10/01 Original        (Rev 1.0)
 * Nilesh Rajbharti     2/9/02  Cleanup
 * Nilesh Rajbharti     5/22/02 Rev 2.0 (See version.log for detail)
 * Nilesh Rajbharti     8/7/03  Rev 2.21 - TFTP Client addition
 * Howard Schlunder		9/30/04	Added MCHP_MAC, MAC_POWER_ON_TEST, 
 								EEPROM_BUFFER_SIZE, USE_LCD
 * Howard Schlunder		8/09/06	Removed MCHP_MAC, added STACK_USE_NBNS, 
 *								STACK_USE_DNS, and STACK_USE_GENERIC_TCP_EXAMPLE
 ********************************************************************/
#ifndef __STACK_TSK_H
#define __STACK_TSK_H


// Check for potential configuration errors in "TCPIPConfig.h"
#if (MAX_TCP_SOCKETS <= 0 || MAX_TCP_SOCKETS > 255)
#error Invalid MAX_TCP_SOCKETS value specified.
#endif

// Check for potential configuration errors in "TCPIPConfig.h"
#if (MAX_UDP_SOCKETS <= 0 || MAX_UDP_SOCKETS > 255 )
#error Invlaid MAX_UDP_SOCKETS value specified
#endif

// Check for potential configuration errors in "TCPIPConfig.h"
#if (MAX_HTTP_CONNECTIONS <= 0 || MAX_HTTP_CONNECTIONS > 255 )
#error Invalid MAX_HTTP_CONNECTIONS value specified.
#endif

// Check for potential configuration errors in "TCPIPConfig.h"
#define AVAILABLE_SOCKETS (MAX_TCP_SOCKETS)
#if defined(STACK_USE_HTTP_SERVER)
    #define AVAILABLE_SOCKETS2 (AVAILABLE_SOCKETS - MAX_HTTP_CONNECTIONS)
#else
    #define AVAILABLE_SOCKETS2  (MAX_TCP_SOCKETS)
#endif

// Check for potential configuration errors in "TCPIPConfig.h"
// When using FTP, you must have at least two sockets free
#if defined(STACK_USE_FTP_SERVER)
    #define AVAILABLE_SOCKETS3 (AVAILABLE_SOCKETS2 - 2)
#else
    #define AVAILABLE_SOCKETS3  (AVAILABLE_SOCKETS2)
#endif

// Check for potential configuration errors in "TCPIPConfig.h"
#if AVAILABLE_SOCKETS3 < 0 || AVAILABLE_SOCKETS3 > MAX_TCP_SOCKETS
    #error MAX_TCP_SOCKETS is too low to accommodate MAX_HTTP_CONNECTIONS and/or STACK_USE_FTP_SERVER
    #error Either increase MAX_TCP_SOCKETS in StackTsk.h or decrease module socket usage.
#endif

// Check for potential configuration errors in "TCPIPConfig.h"
#define AVAILABLE_UDP_SOCKETS       (MAX_UDP_SOCKETS)
#if defined(STACK_USE_DHCP_CLIENT)
    #define AVAILABLE_UDP_SOCKETS2       (AVAILABLE_UDP_SOCKETS - 1)
#else
    #define AVAILABLE_UDP_SOCKETS2      AVAILABLE_UDP_SOCKETS
#endif

#if defined(STACK_USE_SNMP_SERVER)
    #define AVAILABLE_UDP_SOCKETS3      (AVAILABLE_UDP_SOCKETS2 - 1)
#else
    #define AVAILABLE_UDP_SOCKETS3      AVAILABLE_UDP_SOCKETS2
#endif

#if defined(STACK_USE_TFTP_CLIENT)
    #define AVAILABLE_UDP_SOCKETS4      (AVAILABLE_UDP_SOCKETS2)
#else
    #define AVAILABLE_UDP_SOCKETS4      AVAILABLE_UDP_SOCKETS3
#endif

// Check for potential configuration errors in "TCPIPConfig.h"
#if AVAILABLE_UDP_SOCKETS4 < 0 || AVAILABLE_UDP_SOCKETS4 > MAX_UDP_SOCKETS
    #error MAX_UDP_SOCKETS is too low to accommodate DHCP, SNMP, and/or TFTP client
    #error Either increase MAX_UDP_SOCKETS in StackTsk.h or decrease module UDP socket usage.
#endif



typedef struct __attribute__((__packed__)) _MAC_ADDR
{
    BYTE v[6];
} MAC_ADDR;

#define IP_ADDR		DWORD_VAL

typedef struct __attribute__((__packed__)) _NODE_INFO
{
    MAC_ADDR    MACAddr;
    IP_ADDR     IPAddr;
} NODE_INFO;
/*
typedef struct __attribute__((__packed__)) _APP_CONFIG 
{
	IP_ADDR		MyIPAddr;
	IP_ADDR		MyMask;
	IP_ADDR		MyGateway;
	IP_ADDR		PrimaryDNSServer;
	IP_ADDR		SecondaryDNSServer;
	IP_ADDR		DefaultIPAddr;
	IP_ADDR		DefaultMask;
	MAC_ADDR	MyMACAddr;
	BYTE		NetBIOSName[16];
	struct
	{
		unsigned char : 6;
		unsigned char bIsDHCPEnabled : 1;
		unsigned char bInConfigMode : 1;
	} Flags;
} APP_CONFIG;
*/
typedef struct __attribute__((__packed__)) _APP_CONFIG 
{
    BYTE        Name[16];
    IP_ADDR     MyIPAddr;
    IP_ADDR     MyMask;
    IP_ADDR     MyGateway;
    WORD        MyPortAddr;
    MAC_ADDR    MyMACAddr;

    IP_ADDR     RemoteIPAddr;
    WORD        RemotePortAddr;

    BYTE        ConnectMode;
    BYTE        UARTBaud;

    struct
    {
        BYTE    bIsDHCPEnabled:1;
        BYTE    bInConfigMode:1;
    } Flags;
    WORD        MagicWord;

} APP_CONFIG;



#ifndef THIS_IS_STACK_APPLICATION
    extern APP_CONFIG AppConfig;
#endif


void StackInit(void);
void StackTask(void);


#endif
