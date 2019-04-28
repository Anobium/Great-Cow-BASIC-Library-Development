/*********************************************************************
 *
 *	Microchip TCP/IP Stack Demo Application Configuration Header
 *
 *********************************************************************
 * FileName:        TCPIPConfig.h
 * Dependencies:    Microchip TCP/IP Stack
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
 * Author               Date        Comment
 *~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * Howard Schlunder		10/04/2006	Original
 ********************************************************************/
#ifndef __TCPIPCONFIG_H
#define __TCPIPCONFIG_H

#include "TCPIP Stack/TCPIP.h"

/*
 * Modules to include in this project
 */
//#define STACK_USE_UART					// Application demo using UART for IP address display and stack configuration
//#define STACK_USE_SLIP				// Reserved: SLIP is not supported in this stack version.
//#define STACK_USE_IP_GLEANING
//#define STACK_USE_ICMP_SERVER
#define STACK_USE_ICMP_CLIENT
//#define STACK_USE_HTTP_SERVER
//#define STACK_USE_MPFS
#define STACK_USE_DHCP_CLIENT
//#define STACK_USE_DHCP_SERVER
//#define STACK_USE_FTP_SERVER
//#define STACK_USE_SMTP_CLIENT
//#define STACK_USE_SNMP_SERVER
//#define STACK_USE_TFTP_CLIENT
//#define STACK_USE_GENERIC_TCP_CLIENT_EXAMPLE	// HTTP Client example in GenericTCPClient.c
//#define STACK_USE_GENERIC_TCP_SERVER_EXAMPLE	// ToUpper server example in GenericTCPServer.c
//#define STACK_USE_TELNET_SERVER			// Telnet server
#define STACK_USE_ANNOUNCE				// Microchip Embedded Ethernet Device Discoverer server/client
//#define STACK_USE_DNS					// Domain Name Service Client
//#define STACK_USE_NBNS					// NetBIOS Name Service Server
//#define STACK_USE_REBOOT_SERVER			// Module for resetting this PIC remotely.  Primarily useful for a Bootloader.
//#define STACK_USE_UDP_PERFORMANCE_TEST	// Module for testing UDP TX performance characteristics.  NOTE: Enabling this will cause a huge amount of UDP broadcast packets to flood your network on various ports.  Use care when enabling this on production networks, especially with VPNs (could tunnel broadcast traffic across a limited bandwidth connection).
//#define STACK_USE_TCP_PERFORMANCE_TEST	// Module for testing TCP TX performance characteristics

/*
 * If html pages are stored in internal program memory,
 * comment MPFS_USE_EEPROM and include an MPFS image (.c file) 
 * in the project.  If html pages are stored in external EEPROM 
 * memory, uncomment MPFS_USE_EEPROM
 */
//#define MPFS_USE_EEPROM

/*
 * Number of bytes to be reserved before MPFS storage is to start.
 *
 * These bytes host application configurations such as IP Address,
 * MAC Address, and any other required variables.
 *
 * After making any change to this variable, MPFS.exe must be
 * executed with correct block size.
 * See MPFS.exe help message by executing MPFS /?
 */
//#define MPFS_RESERVE_BLOCK              (64)


/*
 * Following low level modules are automatically enabled/disabled based on high-level
 * module selections.
 * If you need them with your custom application, enable it here.
 */
#define STACK_USE_TCP
#define STACK_USE_UDP

/*
 * Uncomment following line if this stack will be used in CLIENT
 * mode.  In CLIENT mode, some functions specific to client operation
 * are enabled.
 */
#define STACK_CLIENT_MODE


// When MPFS is stored in internal program memory (instead of external EEPROM), FTP is not supported.
#if !defined(MPFS_USE_EEPROM)
	#undef STACK_USE_FTP_SERVER
#endif

#if defined(STACK_USE_FTP_SERVER) || defined(STACK_USE_HTTP_SERVER)
	#define STACK_USE_MPFS
#endif

// Comment following line if SNMP TRAP support is needed
//#define SNMP_TRAP_DISABLED

// When SLIP is used, DHCP is not supported.
#if defined(STACK_USE_SLIP)
	#undef STACK_USE_DHCP_CLIENT
#endif

// When IP Gleaning is enabled, ICMP must also be enabled.
#if defined(STACK_USE_IP_GLEANING)
    #if !defined(STACK_USE_ICMP_SERVER)
        #define STACK_USE_ICMP_SERVER
    #endif
#endif


// Make sure that STACK_CLIENT_MODE is defined if a service 
// depends on it
#if defined(STACK_USE_FTP_SERVER) || \
	defined(STACK_USE_SNMP_SERVER) || \
	defined(STACK_USE_DNS) || \
	defined(STACK_USE_GENERIC_TCP_CLIENT_EXAMPLE) || \
	defined(STACK_USE_TFTP_CLIENT) || \
	defined(STACK_USE_SMTP_CLIENT) || \
	defined(STACK_USE_ICMP_CLIENT)
	#if !defined(STACK_CLIENT_MODE)
	    #define STACK_CLIENT_MODE
	#endif
#endif

// Make sure that STACK_USE_TCP is defined if a service depends on 
// it
#if defined(STACK_USE_HTTP_SERVER) || \
	defined(STACK_USE_FTP_SERVER) || \
	defined(STACK_USE_TELNET_SERVER) || \
	defined(STACK_USE_GENERIC_TCP_CLIENT_EXAMPLE) || \
	defined(STACK_USE_GENERIC_TCP_SERVER_EXAMPLE) || \
	defined(STACK_USE_SMTP_CLIENT) || \
	defined(STACK_USE_TCP_PERFORMANCE_TEST)
    #if !defined(STACK_USE_TCP)
        #define STACK_USE_TCP
    #endif
#endif

// Make sure that STACK_USE_UDP is defined if a service depends 
// on it
#if defined(STACK_USE_DHCP_CLIENT) || \
	defined(STACK_USE_DNS) || \
	defined(STACK_USE_NBNS) || \
	defined(STACK_USE_SNMP_SERVER) || \
	defined(STACK_USE_TFTP_CLIENT) || \
	defined(STACK_USE_ANNOUNCE) || \
	defined(STACK_USE_UDP_PERFORMANCE_TEST)
    #if !defined(STACK_USE_UDP)
        #define STACK_USE_UDP
    #endif
#endif


#if defined(STACK_USE_SLIP)
	#define NON_MCHP_MAC
#endif

#if defined(LCD_DATA_IO)
	#define USE_LCD
#endif


//
// Default Address information - If not found in data EEPROM.
//
#define MY_DEFAULT_HOST_NAME			"MCHPBOARD"

#define MY_DEFAULT_MAC_BYTE1            (0x00)
#define MY_DEFAULT_MAC_BYTE2            (0x04)
#define MY_DEFAULT_MAC_BYTE3            (0xA3)
#define MY_DEFAULT_MAC_BYTE4            (0x00)
#define MY_DEFAULT_MAC_BYTE5            (0x00)
#define MY_DEFAULT_MAC_BYTE6            (0x00)

#define MY_DEFAULT_IP_ADDR_BYTE1        (169ul)
#define MY_DEFAULT_IP_ADDR_BYTE2        (254ul)
#define MY_DEFAULT_IP_ADDR_BYTE3        (1ul)
#define MY_DEFAULT_IP_ADDR_BYTE4        (1ul)

#define MY_DEFAULT_MASK_BYTE1           (255ul)
#define MY_DEFAULT_MASK_BYTE2           (255ul)
#define MY_DEFAULT_MASK_BYTE3           (0ul)
#define MY_DEFAULT_MASK_BYTE4           (0ul)

#define MY_DEFAULT_GATE_BYTE1           MY_DEFAULT_IP_ADDR_BYTE1
#define MY_DEFAULT_GATE_BYTE2           MY_DEFAULT_IP_ADDR_BYTE2
#define MY_DEFAULT_GATE_BYTE3           MY_DEFAULT_IP_ADDR_BYTE3
#define MY_DEFAULT_GATE_BYTE4           (1ul)

#define MY_DEFAULT_PRIMARY_DNS_BYTE1	MY_DEFAULT_GATE_BYTE1
#define MY_DEFAULT_PRIMARY_DNS_BYTE2	MY_DEFAULT_GATE_BYTE2
#define MY_DEFAULT_PRIMARY_DNS_BYTE3	MY_DEFAULT_GATE_BYTE3
#define MY_DEFAULT_PRIMARY_DNS_BYTE4	MY_DEFAULT_GATE_BYTE4

#define MY_DEFAULT_SECONDARY_DNS_BYTE1	MY_DEFAULT_GATE_BYTE1
#define MY_DEFAULT_SECONDARY_DNS_BYTE2	MY_DEFAULT_GATE_BYTE2
#define MY_DEFAULT_SECONDARY_DNS_BYTE3	MY_DEFAULT_GATE_BYTE3
#define MY_DEFAULT_SECONDARY_DNS_BYTE4	MY_DEFAULT_GATE_BYTE4

/*
 * TCP configurations
 * To minmize page update, match number of sockets and
 * HTTP connections with different page sources in a
 * page.
 * For example, if page contains reference to 3 more pages,
 * browser may try to open 4 simultaneous HTTP connections,
 * and to minimize browser delay, set HTTP connections to
 * 4, MAX_TCP_SOCKETS to 4.
 * If you are using other applications, you should
 * keep at least one socket available for them.
 */

// Maximum TCP sockets to be defined.
// Note that each TCP socket consumes 26 bytes of RAM (sizeof(TCB_STUB)), 
// and a goodly chunk of Ethernet buffer RAM (TCP_TX_FIFO_SIZE + 1 + TCP_RX_FIFO_SIZE + sizeof(TCB))
// for each socket)
#define MAX_TCP_SOCKETS     (2ul)
#define TCP_TX_FIFO_SIZE	(512ul)
#define TCP_RX_FIFO_SIZE	(512ul)

// Maximum avaialble UDP Sockets
#define MAX_UDP_SOCKETS     (3ul)

// Maximum numbers of simultaneous HTTP connections allowed.
// Each connection consumes 10 bytes and a TCP socket
#define MAX_HTTP_CONNECTIONS	(1ul)


#endif
