/*********************************************************************
 *
 *  Microchip TCP/IP Stack Include File
 *
 *********************************************************************
 * FileName:        TCPIP.h
 * Dependencies:    
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
 * Howard Schlunder		12/20/06	Original
 ********************************************************************/
#ifndef __TCPIP_H
#define __TCPIP_H

#include <string.h>
#include <stdlib.h>
#include "GenericTypeDefs.h"
#include "Compiler.h"
#include "HardwareProfile.h"
#include "TCPIPConfig.h"
#include "TCPIP Stack/StackTsk.h"
#include "TCPIP Stack/Helpers.h"
#include "TCPIP Stack/Delay.h"
#include "TCPIP Stack/Tick.h"
#include "TCPIP Stack/MAC.h"
#include "TCPIP Stack/IP.h"
#include "TCPIP Stack/ARP.h"

#if defined(STACK_USE_UDP)
	#include "TCPIP Stack/UDP.h"
#endif

#if defined(STACK_USE_TCP)
	#include "TCPIP Stack/TCP.h"
#endif

#if defined(USE_LCD)
	#include "TCPIP Stack/LCDBlocking.h"
#endif

#if defined(STACK_USE_UART)
	#include "TCPIP Stack/UART.h"
#endif

#if defined(STACK_USE_UART)
	#include "TCPIP Stack/UART.h"
#endif

#if defined(STACK_USE_DHCP_CLIENT) || defined(STACK_USE_DHCP_SERVER)
	#include "TCPIP Stack/DHCP.h"
#endif

#if defined(STACK_USE_DNS)
	#include "TCPIP Stack/DNS.h"
#endif

#if defined(STACK_USE_FTP_SERVER)
	#include "TCPIP Stack/MPFS.h"
	#include "TCPIP Stack/FTP.h"
#endif

#if defined(STACK_USE_HTTP_SERVER)
	#include "TCPIP Stack/MPFS.h"
	#include "TCPIP Stack/HTTP.h"
#endif

#if defined(STACK_USE_ICMP_SERVER) || defined(STACK_USE_ICMP_CLIENT)
	#include "TCPIP Stack/ICMP.h"
#endif

#if defined(STACK_USE_ANNOUNCE)
	#include "TCPIP Stack/Announce.h"
#endif

#if defined(MPFS_USE_EEPROM)
	#include "TCPIP Stack/MPFS.h"
	#include "TCPIP Stack/XEEPROM.h"
#endif

#if defined(STACK_USE_SNMP_SERVER)
	#include "TCPIP Stack/SNMP.h"
	#include "TCPIP Stack/mib.h"
#endif

#if defined(STACK_USE_NBNS)
	#include "TCPIP Stack/NBNS.h"
#endif

#if defined(STACK_USE_DNS)
	#include "TCPIP Stack/DNS.h"
#endif

#if defined(STACK_USE_GENERIC_TCP_CLIENT_EXAMPLE)
	#include "TCPIP Stack/GenericTCPClient.h"
#endif

#if defined(STACK_USE_GENERIC_TCP_SERVER_EXAMPLE)
	#include "TCPIP Stack/GenericTCPServer.h"
#endif

#if defined(STACK_USE_TELNET_SERVER)
	#include "TCPIP Stack/Telnet.h"
#endif

#if defined(STACK_USE_SMTP_CLIENT)
	#include "TCPIP Stack/SMTP.h"
#endif

#if defined(STACK_USE_TFTP_CLIENT)
	#include "TCPIP Stack/TFTPc.h"
#endif

#if defined(STACK_USE_REBOOT_SERVER)
	#include "TCPIP Stack/Reboot.h"
#endif

#if defined(STACK_USE_UDP_PERFORMANCE_TEST)
	#include "TCPIP Stack/UDPPerformanceTest.h"
#endif

#if defined(STACK_USE_TCP_PERFORMANCE_TEST)
	#include "TCPIP Stack/TCPPerformanceTest.h"
#endif

#endif
