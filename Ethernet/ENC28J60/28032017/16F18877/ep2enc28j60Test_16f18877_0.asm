;Program compiled by Great Cow BASIC (0.97.01 2017-02-20)
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F18877, r=DEC
#include <P16F18877.inc>
 __CONFIG _CONFIG1, _RSTOSC_HFINT32
 __CONFIG _CONFIG2, _STVREN_OFF & _BOREN_OFF & _MCLRE_ON
 __CONFIG _CONFIG3, _WDTE_OFF
 __CONFIG _CONFIG4, _LVP_OFF

;********************************************************************************

;Set aside memory locations for variables
ADDR	EQU	32
COMPORT	EQU	33
DELAYTEMP	EQU	112
DELAYTEMP2	EQU	113
ENC_OUTBYTE	EQU	34
HSERPRINTCRLFCOUNT	EQU	35
I_CHECKSUM16	EQU	36
I_CHECKSUM16_H	EQU	37
PRINTLEN	EQU	38
SERDATA	EQU	39
SPICLOCKMODE	EQU	40
SPICURRENTMODE	EQU	41
SPIRXDATA	EQU	42
SPITXDATA	EQU	43
SSPBUFTEMP1	EQU	44
STRINGPOINTER	EQU	45
SYSBITVAR0	EQU	46
SYSPRINTDATAHANDLER	EQU	47
SYSPRINTDATAHANDLER_H	EQU	48
SYSPRINTTEMP	EQU	49
SYSREPEATTEMP1	EQU	50
SYSREPEATTEMP3	EQU	51
SYSSTRINGA	EQU	119
SYSSTRINGA_H	EQU	120
SYSTEMP1	EQU	52
SYSWAITTEMPMS	EQU	114
SYSWAITTEMPMS_H	EQU	115

;********************************************************************************

;Alias variables
AFSR0	EQU	4
AFSR0_H	EQU	5

;********************************************************************************

;Vectors
	ORG	0
	pagesel	BASPROGRAMSTART
	goto	BASPROGRAMSTART
	ORG	4
	retfie

;********************************************************************************

;Start of program memory page 0
	ORG	5
BASPROGRAMSTART
;Call initialisation routines
	call	INITSYS
	call	INITPPS
	call	INITUSART

;Start of the main program
;Current limitations.
;1. Packet size cannot exceed 700 bytes.
;2. Means, web page table cannot exceed 595 bytes.
;3. Web pages have to be...... wait for this one.... an odd number of bytes!! ?
;So, if things do not work....
;1. Check the TCP packet size in the terminal windows - cannot exceed 685 bytes.
;2. Check the table - cannot exceed 595
;3. Make sure the TCP packet size in the terminal window is an odd number.
;All this is sortable but for today. We are in a great place!
;A web page is max at about 633... but, the converter strips out chars not required so this will vary on the CRLF's used.
;you need the latest HTML2GCB.EXE.  I have uploaded also.
;you need the latest compiler.  I have uploaded also.
;
;lots of todos
;''A program  for GCGB and GCB.
;''A program  for GCGB and GCB.
;''--------------------------------------------------------------------------------------------------------------------------------
;'' Description  :  Setup ENC28j60, then reads data from the Ethernet stream to a PC terminal.
;''
;'' You NEED a PC terminal connected to the serial out on the microprocessor.
;''
;''@author    [todo]
;''@licence   GPL
;''@version   [todo]
;''@date      [todo]
;''********************************************************************************
;
;#include "ENC28J60.h"
;#include "Ethernet.h"
;#define USART_BAUD_RATE 115200
;#define USART_BLOCKING
;#define USART_TX_BLOCKING
;----- Define Ethernet Hardware type
;#define ETHERNET_TYPE ETHERNET_TYPE_ENC28j60
;----- Define Hardware settings
;#Define Ethernet_DI               Portb.0   'Connected to Device SO
;#Define Ethernet_DO               Portb.3     'Connected to Device SI
;#Define Ethernet_SCK              Portb.1     'Connected to Clock
;#Define Ethernet_CS               Porta.5     'Chip select line
;#Define Ethernet_RESET            Portb.4     'Reset line
;----- Variables
;#Define ENC28j60_DI     Ethernet_DI
;#Define ENC28j60_DO     Ethernet_DO
;#Define ENC28j60_SCK    Ethernet_SCK
;#Define ENC28j60_CS     Ethernet_CS
;#Define ENC28j60_RESET  Ethernet_RESET
;wait 500 ms
	movlw	244
	movwf	SysWaitTempMS
	movlw	1
	movwf	SysWaitTempMS_H
	call	Delay_MS
;HSerPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	call	HSERPRINTCRLF

;HSerPrint "Welcome to the Start"
	movlw	low StringTable2
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable2) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT226

;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	call	HSERPRINTCRLF

;ENC28j60_Init
	call	ENC28J60_INIT

;HSerPrint "Welcome to the End"
	movlw	low StringTable3
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable3) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT226

;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	call	HSERPRINTCRLF

;#define ENC28j60_Select         Set ENC28j60_CS off
;#define ENC28j60_Deselect       Set ENC28j60_CS on
;#define ENC28j60_Reset_CMD      Set ENC28j60_RESET on: Wait 20 ms :Set ENC28j60_RESET off: Wait 20 ms :Set ENC28j60_RESET on: Wait 20 ms
CONFIGURATIONDETAILS
;Important bit maps
;#define EPKTDEC 0x40
;#define DMAST   0x20
;#define CSUMEN  0x10
;#define TXRTS   0x08
;#define MIIRD   0x01
;#define BUSY    0x01
;#define CLKRDY  0x01
;#define RXEN    0x04
MEMORY_LOCATIONS_SCRIPT
;Set ENC28j60 Memory locations
;ENC28j60 Control Registers
;#define WCRCMD  b'01000000'      ; write control register
;#define BFCCMD  b'10100000'      ; bit field clear
;#define BFSCMD  b'10000000'      ; bit field set
;Control register definitions are a combination of address,
;bank number, and Ethernet/MAC/PHY indicator bits.
;- Register address  (bits 0-4)
;- Bank number (bits 5-6)
;- MAC/MII indicator (bit 7)
;
;#define ADDR_MASK 0x1F
;#define BANK_MASK 0x60
;#define SPRD_MASK 0x80
;All-bank registers'
;#define BANK0   0
;#define BANK1   1
;#define BANK2   2
;#define BANK3   3
;#define EIE   0x1B
;#define EIR   0x1C
;#define ESTAT   0x1D
;#define ECON2   0x1E
;#define ECON1   0x1F
;Bank 0 registers'
;#define ERDPTL    (0x00|0x00)
;#define ERDPTH    (0x01|0x00)
;#define EWRPTL    (0x02|0x00)
;#define EWRPTH    (0x03|0x00)
;#define ETXSTL    (0x04|0x00)
;#define ETXSTH    (0x05|0x00)
;#define ETXNDL    (0x06|0x00)
;#define ETXNDH    (0x07|0x00)
;#define ERXSTL    (0x08|0x00)
;#define ERXSTH    (0x09|0x00)
;#define ERXNDL    (0x0A|0x00)
;#define ERXNDH    (0x0B|0x00)
;#define ERXRDPTL  (0x0C|0x00)
;#define ERXRDPTH  (0x0D|0x00)
;#define ERXWRPTL  (0x0E|0x00)
;#define ERXWRPTH  (0x0F|0x00)
;#define EDMASTL   (0x10|0x00)
;#define EDMASTH   (0x11|0x00)
;#define EDMANDL   (0x12|0x00)
;#define EDMANDH   (0x13|0x00)
;#define EDMADSTL  (0x14|0x00)
;#define EDMADSTH  (0x15|0x00)
;#define EDMACSL   (0x16|0x00)
;#define EDMACSH   (0x17|0x00)
;Bank 1 registers'
;#define EHT0    (0x00|0x20)
;#define EHT1    (0x01|0x20)
;#define EHT2    (0x02|0x20)
;#define EHT3    (0x03|0x20)
;#define EHT4    (0x04|0x20)
;#define EHT5    (0x05|0x20)
;#define EHT6    (0x06|0x20)
;#define EHT7    (0x07|0x20)
;#define EPMM0   (0x08|0x20)
;#define EPMM1   (0x09|0x20)
;#define EPMM2   (0x0A|0x20)
;#define EPMM3   (0x0B|0x20)
;#define EPMM4   (0x0C|0x20)
;#define EPMM5   (0x0D|0x20)
;#define EPMM6   (0x0E|0x20)
;#define EPMM7   (0x0F|0x20)
;#define EPMCSL    (0x10|0x20)
;#define EPMCSH    (0x11|0x20)
;#define EPMOL   (0x14|0x20)
;#define EPMOH   (0x15|0x20)
;#define EWOLIE    (0x16|0x20)
;#define EWOLIR    (0x17|0x20)
;#define ERXFCON   (0x18|0x20)
;#define EPKTCNT   (0x19|0x20)
;Bank 2 registers'
;#define MACON1    (0x00|0x40|SPRD_MASK)
;#define MACON2 (0x01|0x40|SPRD_MASK)'
;#define MACON3    (0x02|0x40|SPRD_MASK)
;#define MACON4    (0x03|0x40|SPRD_MASK)
;#define MABBIPG   (0x04|0x40|SPRD_MASK)
;#define MAIPGL    (0x06|0x40|SPRD_MASK)
;#define MAIPGH    (0x07|0x40|SPRD_MASK)
;#define MACLCON1  (0x08|0x40|SPRD_MASK)
;#define MACLCON2  (0x09|0x40|SPRD_MASK)
;#define MAMXFLL   (0x0A|0x40|SPRD_MASK)
;#define MAMXFLH   (0x0B|0x40|SPRD_MASK)
;#define MAPHSUP    (0x0D|0x40|SPRD_MASK)
;#define MICON    (0x11|0x40|SPRD_MASK)
;#define MICMD   (0x12|0x40|SPRD_MASK)
;#define MIREGADR  (0x14|0x40|SPRD_MASK)
;#define MIWRL   (0x16|0x40|SPRD_MASK)
;#define MIWRH   (0x17|0x40|SPRD_MASK)
;#define MIRDL   (0x18|0x40|SPRD_MASK)
;#define MIRDH   (0x19|0x40|SPRD_MASK)
;Bank 3 registers'
;#define MAADR1    (0x00|0x60|SPRD_MASK)
;#define MAADR0    (0x01|0x60|SPRD_MASK)
;#define MAADR3    (0x02|0x60|SPRD_MASK)
;#define MAADR2    (0x03|0x60|SPRD_MASK)
;#define MAADR5    (0x04|0x60|SPRD_MASK)
;#define MAADR4    (0x05|0x60|SPRD_MASK)
;#define EBSTSD    (0x06|0x60)
;#define EBSTCON   (0x07|0x60)
;#define EBSTCSL   (0x08|0x60)
;#define EBSTCSH   (0x09|0x60)
;#define MISTAT    (0x0A|0x60|SPRD_MASK)
;#define EREVID    (0x12|0x60)
;#define ECOCON    (0x15|0x60)
;#define EFLOCON   (0x17|0x60)
;#define EPAUSL    (0x18|0x60)
;#define EPAUSH    (0x19|0x60)
;PHY registers'
;#define PHCON1    0x00
;#define PHSTAT1   0x01
;#define PHHID1    0x02
;#define PHHID2    0x03
;#define PHCON2    0x10
;#define PHSTAT2   0x11
;#define PHIE    0x12
;#define PHIR    0x13
;#define PHLCON    0x14
;ENC28j60 EIE Register Bit Definitions'
;#define EIE_INTIE 0x80
;#define EIE_PKTIE 0x40
;#define EIE_DMAIE 0x20
;#define EIE_LINKIE  0x10
;#define EIE_TXIE  0x08
;#define EIE_WOLIE  0x04 (reserved)'
;#define EIE_TXERIE  0x02
;#define EIE_RXERIE  0x01
;ENC28j60 EIR Register Bit Definitions'
;#define EIR_PKTIF 0x40
;#define EIR_DMAIF 0x20
;#define EIR_LINKIF  0x10
;#define EIR_TXIF  0x08
;#define EIR_WOLIF  0x04 (reserved)'
;#define EIR_TXERIF  0x02
;#define EIR_RXERIF  0x01
;ENC28j60 ESTAT Register Bit Definitions'
;#define ESTAT_INT 0x80
;#define ESTAT_LATECOL 0x10
;#define ESTAT_RXBUSY  0x04
;#define ESTAT_TXABRT  0x02
;#define ESTAT_CLKRDY  0x01
;ENC28j60 ECON2 Register Bit Definitions'
;#define ECON2_AUTOINC 0x80
;#define ECON2_PKTDEC  0x40
;#define ECON2_PWRSV 0x20
;#define ECON2_VRPS  0x08
;ENC28j60 ECON1 Register Bit Definitions'
;#define ECON1_TXRST 0x80
;#define ECON1_RXRST 0x40
;#define ECON1_DMAST 0x20
;#define ECON1_CSUMEN  0x10
;#define ECON1_TXRTS 0x08
;#define ECON1_RXEN  0x04
;#define ECON1_BSEL1 0x02
;#define ECON1_BSEL0 0x01
;ENC28j60 MACON1 Register Bit Definitions'
;#define MACON1_LOOPBK 0x10
;#define MACON1_TXPAUS 0x08
;#define MACON1_RXPAUS 0x04
;#define MACON1_PASSALL  0x02
;#define MACON1_MARXEN 0x01
;ENC28j60 MACON2 Register Bit Definitions'
;#define MACON2_MARST  0x80
;#define MACON2_RNDRST 0x40
;#define MACON2_MARXRST  0x08
;#define MACON2_RFUNRST  0x04
;#define MACON2_MATXRST  0x02
;#define MACON2_TFUNRST  0x01
;ENC28j60 MACON3 Register Bit Definitions'
;#define MACON3_PADCFG2  0x80
;#define MACON3_PADCFG1  0x40
;#define MACON3_PADCFG0  0x20
;#define MACON3_TXCRCEN  0x10
;#define MACON3_PHDRLEN  0x08
;#define MACON3_HFRMLEN  0x04
;#define MACON3_FRMLNEN  0x02
;#define MACON3_FULDPX 0x01
;ENC28j60 MICMD Register Bit Definitions'
;#define MICMD_MIISCAN 0x02
;#define MICMD_MIIRD 0x01
;ENC28j60 MISTAT Register Bit Definitions'
;#define MISTAT_NVALID 0x04
;#define MISTAT_SCAN 0x02
;#define MISTAT_BUSY 0x01
;ENC28j60 ERXFCON Register Bit Definitions'
;#define ERXFCON_UCEN  0x80
;#define ERXFCON_ANDOR 0x40
;#define ERXFCON_CRCEN 0x20
;#define ERXFCON_PMEN  0x10
;#define ERXFCON_MPEN  0x08
;#define ERXFCON_HTEN  0x04
;#define ERXFCON_MCEN  0x02
;#define ERXFCON_BCEN  0x01
;ENC28j60 PHY PHCON1 Register Bit Definitions'
;#define PHCON1_PRST 0x8000
;#define PHCON1_PLOOPBK  0x4000
;#define PHCON1_PPWRSV 0x0800
;#define PHCON1_PDPXMD 0x0100
;ENC28j60 PHY PHSTAT1 Register Bit Definitions'
;#define PHSTAT1_PFDPX 0x1000
;#define PHSTAT1_PHDPX 0x0800
;#define PHSTAT1_LLSTAT  0x0004
;#define PHSTAT1_JBSTAT  0x0002
;ENC28j60 PHY PHSTAT2 Register Bit Definitions'
;#define PHSTAT2_TXSTAT  (1 << 13)
;#define PHSTAT2_RXSTAT  (1 << 12)
;#define PHSTAT2_COLSTAT (1 << 11)
;#define PHSTAT2_LSTAT (1 << 10)
;#define PHSTAT2_DPXSTAT (1 << 9)
;#define PHSTAT2_PLRITY  (1 << 5)
;ENC28j60 PHY PHCON2 Register Bit Definitions'
;#define PHCON2_FRCLINK  0x4000
;#define PHCON2_TXDIS  0x2000
;#define PHCON2_JABBER 0x0400
;#define PHCON2_HDLDIS 0x0100
;ENC28j60 PHY PHIE Register Bit Definitions'
;#define PHIE_PLNKIE (1 << 4)
;#define PHIE_PGEIE  (1 << 1)
;ENC28j60 PHY PHIR Register Bit Definitions'
;#define PHIR_PLNKIF (1 << 4)
;#define PHIR_PGEIF  (1 << 1)
;ENC28j60 Packet Control Byte Bit Definitions'
;#define PKTCTRL_PHUGEEN   0x08
;#define PKTCTRL_PPADEN    0x04
;#define PKTCTRL_PCRCEN    0x02
;#define PKTCTRL_POVERRIDE 0x01
;ENC28j60 Transmit Status Vector'
;#define TSV_TXBYTECNT   0
;#define TSV_TXCOLLISIONCNT  16
;#define TSV_TXCRCERROR    20
;#define TSV_TXLENCHKERROR 21
;#define TSV_TXLENOUTOFRANGE 22
;#define TSV_TXDONE    23
;#define TSV_TXMULTICAST   24
;#define TSV_TXBROADCAST   25
;#define TSV_TXPACKETDEFER 26
;#define TSV_TXEXDEFER   27
;#define TSV_TXEXCOLLISION 28
;#define TSV_TXLATECOLLISION 29
;#define TSV_TXGIANT   30
;#define TSV_TXUNDERRUN    31
;#define TSV_TOTBYTETXONWIRE 32
;#define TSV_TXCONTROLFRAME  48
;#define TSV_TXPAUSEFRAME  49
;#define TSV_BACKPRESSUREAPP 50
;#define TSV_TXVLANTAGFRAME  51
;#define TSV_SIZE    7
;#define TSV_BYTEOF(x)    ((x) / 8)
;#define TSV_BITMASK(x)   (1 << ((x) % 8))
;#define TSV_GETBIT(x, y) (((x)[TSV_BYTEOF(y)] & TSV_BITMASK(y)) ? 1 : 0)
;ENC28j60 Receive Status Vector'
;#define RSV_RXLONGEVDROPEV  16
;#define RSV_CARRIEREV   18
;#define RSV_CRCERROR    20
;#define RSV_LENCHECKERR   21
;#define RSV_LENOUTOFRANGE 22
;#define RSV_RXOK    23
;#define RSV_RXMULTICAST   24
;#define RSV_RXBROADCAST   25
;#define RSV_DRIBBLENIBBLE 26
;#define RSV_RXCONTROLFRAME  27
;#define RSV_RXPAUSEFRAME  28
;#define RSV_RXUNKNOWNOPCODE 29
;#define RSV_RXTYPEVLAN    30
;#define RSV_SIZE    6
;#define RSV_BITMASK(x)   (1 << ((x) - 16))
;#define RSV_GETBIT(x, y) (((x) & RSV_BITMASK(y)) ? 1 : 0)
;SPI operation codes'
;#define ENC28j60_READ_CTRL_REG  0x00
;#define ENC28j60_READ_BUF_MEM 0x3A
;#define ENC28j60_WRITE_CTRL_REG 0x40
;#define ENC28j60_WRITE_BUF_MEM  0x7A
;#define ENC28j60_BIT_FIELD_SET  0x80
;#define ENC28j60_BIT_FIELD_CLR  0xA0
;#define ENC28j60_SOFT_RESET 0xFF
;#define TXEND_INIT    0x1FFF
;#define TXEND_INIT_b    0x1F
;#define TXEND_INIT_h    0xFF
;Put RX buffer at 0 as suggested by the Errata datasheet'
;#define RXSTART_INIT    0x0000
;#define RXSTART_INIT_b    0x00
;#define RXSTART_INIT_h    0x00
;#define RXEND_INIT    0x19FF
;#define RXEND_INIT_b    0xFF
;#define RXEND_INIT_h    0x19
;maximum ethernet frame length'
;#define MAX_FRAMELEN    1518
;Preferred half duplex: LEDA: Link status LEDB: Rx/Tx activity'
;#define ENC28j60_LAMPS_MODE 0x3476
;'FILE:Ethernet.h
;Ethernet setup and buffer definitions for the GCBASIC compiler
;Copyright (C) 2017 Evan Venn
;This library is free software; you can redistribute it and/or
;modify it under the terms of the GNU Lesser General Public
;License as published by the Free Software Foundation; either
;version 2.1 of the License, or (at your option) any later version.
;This library is distributed in the hope that it will be useful,
;but WITHOUT ANY WARRANTY; without even the implied warranty of
;MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;Lesser General Public License for more details.
;You should have received a copy of the GNU Lesser General Public
;License along with this library; if not, write to the Free Software
;Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
;Notes
;28/03/2017 Initial release
;Ethernet Hardware types
;#define ETHERNET_TYPE_ENC28j60 1
;dim macaddr(6)
;dim ipaddr(4)
;dim ipserver(4)
;dim iprouter(4)
;dim macaddrrouter(4)
;dim sntpserveraddr(4)
;dim ipport as byte
;#define etherBufferSize 730
;dim etherbuffer(etherBufferSize)
;dim nextpacketptr as word
;dim I_checksum16 as word
;dim I_value16 as word alias I_checksum16_H, I_checksum16
;Dim Ip_id As Word
;dim T_udp_destport as word
;Dim hulp2 As Word
;Dim Incoming_ack as Long
;dim commandlineString as string * 12
;dim arrayloc,TableLoc as word
;dim HTTPStandardHeaderStatusBit as Byte
;dim HTTPSentTCPPacket, lastGet as byte
;dim TCPresult16, TableStartPoint as word
;#define HTTPPrintCRLF 1
;dim lastselectedBank, banktobeselected as byte
;dim SSPBUFtemp1, SSPBUFtemp2 as byte
;Recommend not to change any of this definitions.
;IP Header Size
;#define IP_HeaderSize 14
;These defines all refer to the defined array - etherbuffer
;dim etherbuffer(etherBufferSize)
;Ethernet packet destination
;#Define T_enetpacketdest0 etherbuffer(0x01)
;#Define T_enetpacketdest1 etherbuffer(0x02)
;#Define T_enetpacketdest2 etherbuffer(0x03)
;#Define T_enetpacketdest3 etherbuffer(0x04)
;#Define T_enetpacketdest4 etherbuffer(0x05)
;#Define T_enetpacketdest5 etherbuffer(0x06)
;Ethernet packet source
;#Define T_enetpacketsrc0 etherbuffer(0x07)
;#Define T_enetpacketsrc1 etherbuffer(0x08)
;#Define T_enetpacketsrc2 etherbuffer(0x09)
;#Define T_enetpacketsrc3 etherbuffer(0x0A)
;#Define T_enetpacketsrc4 etherbuffer(0x0B)
;#Define T_enetpacketsrc5 etherbuffer(0x0C)
;Ethernet packet type
;#Define T_enetpackettype0 etherbuffer(0x0D)
;#Define T_enetpackettype1 etherbuffer(0x0E)
;ARP definitions
;#Define T_arp_hwtype1 etherbuffer(0x10)
;#Define T_arp_prttype1 etherbuffer(0x12)
;#Define T_arp_hwlen etherbuffer(0x13)
;#Define T_arp_prlen etherbuffer(0x14)
;#Define T_arp_op1 etherbuffer(0x16)
;ARP source ip address
;#Define T_arp_sipaddr0 etherbuffer(0x1D)
;#Define T_arp_sipaddr1 etherbuffer(0x1E)
;#Define T_arp_sipaddr2 etherbuffer(0x1F)
;#Define T_arp_sipaddr3 etherbuffer(0x20)
;ARP target IP address
;#Define T_arp_tipaddr0 etherbuffer(0x27)
;#Define T_arp_tipaddr1 etherbuffer(0x28)
;#Define T_arp_tipaddr2 etherbuffer(0x29)
;#Define T_arp_tipaddr3 etherbuffer(0x2A)
;IP header layout IP version and header length
;#Define T_ip_header_pointer0 0x0F
;#Define T_ip_header_pointer1 0x21
;IP version and hardware type
;#Define T_ip_vers_len etherbuffer(0x0F)
;#Define T_arp_hwtype0 etherbuffer(0x0F)
;ARP definitions
;#Define T_arp_prttype0 etherbuffer(0x11)
;#Define T_arp_op0 etherbuffer(0x15)
;ARP source mac address
;#Define T_arp_src_enetpacket0 etherbuffer(0x17)
;#Define T_arp_src_enetpacket1 etherbuffer(0x18)
;#Define T_arp_src_enetpacket2 etherbuffer(0x19)
;#Define T_arp_src_enetpacket3 etherbuffer(0x1A)
;#Define T_arp_src_enetpacket4 etherbuffer(0x1B)
;#Define T_arp_src_enetpacket5 etherbuffer(0x1C)
;ARP source mac address
;#Define T_arp_dest_enetpacket0 etherbuffer(0x21)
;#Define T_arp_dest_enetpacket1 etherbuffer(0x22)
;#Define T_arp_dest_enetpacket2 etherbuffer(0x23)
;#Define T_arp_dest_enetpacket3 etherbuffer(0x24)
;#Define T_arp_dest_enetpacket4 etherbuffer(0x25)
;#Define T_arp_dest_enetpacket5 etherbuffer(0x26)
;TOS
;#Define T_tos etherbuffer(0x10)
;Packet Buffer length
;#Define T_ip_pktlen0 etherbuffer(0x11)
;#Define T_ip_pktlen1 etherbuffer(0x12)
;TCP buffers size, flags, offsets and ttl
;#Define T_id0 etherbuffer(0x13)
;#Define T_id1 etherbuffer(0x14)
;#Define T_flags etherbuffer(0x15)
;#Define T_offset etherbuffer(0x16)
;#Define T_ttl etherbuffer(0x17)
;Protocol type (ICMP=1, TCP=6, UDP=11)
;#Define T_ip_proto etherbuffer(0x18)
;Header checksum
;#Define T_ip_hdr_cksum0_pointer 0x19
;#Define T_ip_hdr_cksum0 etherbuffer(0x19)
;#Define T_ip_hdr_cksum1 etherbuffer(0x1A)
;IP address of source
;#Define T_ip_srcaddr0 etherbuffer(0x1B)
;#Define T_ip_srcaddr1 etherbuffer(0x1C)
;#Define T_ip_srcaddr2 etherbuffer(0x1D)
;#Define T_ip_srcaddr3 etherbuffer(0x1E)
;IP address of destination
;#Define T_ip_destaddr0 etherbuffer(0x1F)
;#Define T_ip_destaddr1 etherbuffer(0x20)
;#Define T_ip_destaddr2 etherbuffer(0x21)
;#Define T_ip_destaddr3 etherbuffer(0x22)
;ICMP parameters
;#Define T_icmp_type etherbuffer(0x23)
;#Define T_icmp_code etherbuffer(0x24)
;#Define T_icmp_cksum0 etherbuffer(0x25)
;#Define T_icmp_cksum1 etherbuffer(0x26)
;TCP Source port
;#Define Tcp_srcporth etherbuffer(0x23)
;#Define Tcp_srcportl etherbuffer(0x24)
;TCP Destination port
;#Define Tcp_destporth etherbuffer(0x25)
;#Define Tcp_destportl etherbuffer(0x26)
;TCP Sequence number
;#Define Tcp_seqnum3 etherbuffer(0x27)
;#Define Tcp_seqnum2 etherbuffer(0x28)
;#Define Tcp_seqnum1 etherbuffer(0x29)
;#Define Tcp_seqnum0 etherbuffer(0x2A)
;TCP Acknowledge number
;#Define Tcp_acknum3 etherbuffer(0x2B)
;#Define Tcp_acknum2 etherbuffer(0x2C)
;#Define Tcp_acknum1 etherbuffer(0x2D)
;#Define Tcp_acknum0 etherbuffer(0x2E)
;TCP Headets, flags and checksum
;#Define Tcp_hdr etherbuffer(0x2F)
;#Define Tcp_flags etherbuffer(0x30)
;#Define Tcp_cksum0 etherbuffer(0x33)
;#Define Tcp_cksum1 etherbuffer(0x34)
;UDP source port
;#Define T_udp_srcport0 etherbuffer(0x23)
;#Define T_udp_srcport1 etherbuffer(0x24)
;UDP destination port
;#Define T_udp_destport0 etherbuffer(0x25)
;#Define T_udp_destport1 etherbuffer(0x26)
;UDP length
;#Define T_udp_len0 etherbuffer(0x27)
;#Define T_udp_len1 etherbuffer(0x28)
;UDP checksum
;#Define T_udp_chksum0 etherbuffer(0x29)
;#Define T_udp_chksum1 etherbuffer(0x2A)
;UDP Data pointer
;#Define T_udp_data_pointer 0x2B
;UDP Data Buffer
;#Define T_udp_data etherbuffer(0x2B)
;#Define T_udp_data0 etherbuffer(0x2B)
;#Define T_udp_data1 etherbuffer(0x2C)
;#Define T_udp_data2 etherbuffer(0x2D)
;#Define T_udp_data3 etherbuffer(0x2E)
;#Define T_udp_data4 etherbuffer(0x2F)
;#Define T_udp_data5 etherbuffer(0x30)
;#Define T_udp_data6 etherbuffer(0x31)
;#Define T_udp_data7 etherbuffer(0x32)
;#Define T_udp_data8 etherbuffer(0x33)
;#Define T_udp_data9 etherbuffer(0x34)
;#Define T_udp_data10 etherbuffer(0x35)
;#Define T_udp_data11 etherbuffer(0x36)
;#Define T_udp_data12 etherbuffer(0x37)
;#Define T_udp_data13 etherbuffer(0x38)
;#Define T_udp_data14 etherbuffer(0x39)
;#Define T_udp_data15 etherbuffer(0x3A)
;#Define T_udp_data16 etherbuffer(0x3B)
;#Define T_udp_data17 etherbuffer(0x3C)
;#Define T_udp_data18 etherbuffer(0x3D)
;#Define T_udp_data19 etherbuffer(0x3E)
;#Define T_udp_data20 etherbuffer(0x3F)
;#Define T_udp_data21 etherbuffer(0x40)
;#Define T_udp_data22 etherbuffer(0x41)
;#Define T_udp_data23 etherbuffer(0x42)
;#Define T_udp_data24 etherbuffer(0x43)
;#Define T_udp_data25 etherbuffer(0x44)
;#Define T_udp_data26 etherbuffer(0x45)
;#Define T_udp_data27 etherbuffer(0x46)
;#Define T_udp_data28 etherbuffer(0x47)
;#Define T_udp_data29 etherbuffer(0x48)
;#Define T_udp_data30 etherbuffer(0x49)
;#Define T_udp_data31 etherbuffer(0x4A)
;#Define T_udp_data32 etherbuffer(0x4B)
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

;********************************************************************************

Delay_MS
	incf	SysWaitTempMS_H, F
DMS_START
	movlw	4
	movwf	DELAYTEMP2
DMS_OUTER
	movlw	165
	movwf	DELAYTEMP
DMS_INNER
	decfsz	DELAYTEMP, F
	goto	DMS_INNER
	decfsz	DELAYTEMP2, F
	goto	DMS_OUTER
	decfsz	SysWaitTempMS, F
	goto	DMS_START
	decfsz	SysWaitTempMS_H, F
	goto	DMS_START
	return

;********************************************************************************

ENC28J60_INIT
;Dir ENC28j60_DI in
	bsf	TRISB,0
;Dir ENC28j60_DO Out
	bcf	TRISB,3
;Dir ENC28j60_SCK Out
	bcf	TRISB,1
;Dir ENC28j60_CS out
	bcf	TRISA,5
;Dir ENC28j60_RESET out
	bcf	TRISB,4
;set ENC28j60_DO off
	bcf	LATB,3
;set ENC28j60_SCK off
	bcf	LATB,1
;set ENC28j60_CS off
	bcf	LATA,5
;ENC28j60_Deselect
	bsf	LATA,5
;Repeat 5
	movlw	5
	movwf	SysRepeatTemp1
SysRepeatLoop1
;ENC28j60_Reset_CMD
	bsf	LATB,4
	movlw	20
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
	bcf	LATB,4
	movlw	20
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
	bsf	LATB,4
	movlw	20
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;End Repeat
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop1
SysRepeatLoopEnd1
;ENC28j60_Select
	bcf	LATA,5
;SPIMode MasterFast, 0
	movlw	13
	movwf	SPICURRENTMODE
	clrf	SPICLOCKMODE
	call	SPIMODE181

;Repeat 5
	movlw	5
	movwf	SysRepeatTemp1
SysRepeatLoop2
;FastHWSPITransfer( ENC28j60_SOFT_RESET )
;SPITransfer( ENC28j60_SOFT_RESET, SSPBUFtemp1 )
	movlw	255
	movwf	SPITXDATA
	call	HWSPITRANSFER
	movf	SPIRXDATA,W
	movwf	SSPBUFTEMP1

;End Repeat
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop2
SysRepeatLoopEnd2
;ENC28j60_DeSelect
	bsf	LATA,5
;ENC28J60_Select
	bcf	LATA,5
;SPITransfer ( ( BFCCMD | ECON1 ), SSPBUFtemp1 )
	movlw	191
	movwf	SPITXDATA
	call	HWSPITRANSFER
	movf	SPIRXDATA,W
	movwf	SSPBUFTEMP1

;SPITransfer(0b00000001, SSPBUFtemp1 )
	movlw	1
	movwf	SPITXDATA
	call	HWSPITRANSFER
	movf	SPIRXDATA,W
	movwf	SSPBUFTEMP1

;ENC28J60_Deselect
	bsf	LATA,5
;ENC28J60_Select
	bcf	LATA,5
;SPITransfer( BFSCMD | ECON1, SSPBUFtemp1 )
	movlw	159
	movwf	SPITXDATA
	call	HWSPITRANSFER
	movf	SPIRXDATA,W
	movwf	SSPBUFTEMP1

;SPITransfer(0b00000010 , SSPBUFtemp1 )
	movlw	2
	movwf	SPITXDATA
	call	HWSPITRANSFER
	movf	SPIRXDATA,W
	movwf	SSPBUFTEMP1

;ENC28J60_Deselect
	bsf	LATA,5
;ENC28J60_writeReg(MIREGADR, PHLCON)
	movlw	212
	movwf	ADDR
	movlw	20
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG

;ENC28J60_writeReg(MIWRL, 0b10100010)
	movlw	214
	movwf	ADDR
	movlw	162
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG

;ENC28J60_writeReg(MIWRH, 0b00000100)
	movlw	215
	movwf	ADDR
	movlw	4
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG

;writes byte ENC_Outbyte in ENC register addr of the current bank
	return

;********************************************************************************

ENC28J60_WRITEREG
;ENC28J60_Select
	bcf	LATA,5
;SPITransfer( addr OR WCRCMD , SSPBUFtemp1 )
	movlw	64
	iorwf	ADDR,W
	movwf	SPITXDATA
	call	HWSPITRANSFER
	movf	SPIRXDATA,W
	movwf	SSPBUFTEMP1

;SPITransfer( ENC_Outbyte, SSPBUFtemp1 )
	movf	ENC_OUTBYTE,W
	movwf	SPITXDATA
	call	HWSPITRANSFER
	movf	SPIRXDATA,W
	movwf	SSPBUFTEMP1

;ENC28J60_Deselect
	bsf	LATA,5
	return

;********************************************************************************

;Overloaded signature: STRING:byte:
HSERPRINT226
;PrintLen = PrintData(0)
	movf	SysPRINTDATAHandler,W
	movwf	AFSR0
	movf	SysPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	PRINTLEN
;If PrintLen <> 0 then
	movf	PRINTLEN,F
	btfsc	STATUS, Z
	goto	ENDIF8
;for SysPrintTemp = 1 to PrintLen
	clrf	SYSPRINTTEMP
	movlw	1
	subwf	PRINTLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd1
SysForLoop1
	incf	SYSPRINTTEMP,F
;HSerSend(PrintData(SysPrintTemp),comport )
	movf	SYSPRINTTEMP,W
	addwf	SysPRINTDATAHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SERDATA
	call	HSERSEND

;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;next
	movf	PRINTLEN,W
	subwf	SYSPRINTTEMP,W
	btfss	STATUS, C
	goto	SysForLoop1
SysForLoopEnd1
;End If
ENDIF8
	return

;********************************************************************************

HSERPRINTCRLF
;repeat HSerPrintCRLFCount
	movf	HSERPRINTCRLFCOUNT,W
	movwf	SysRepeatTemp3
	btfsc	STATUS,Z
	goto	SysRepeatLoopEnd3
SysRepeatLoop3
;HSerSend(13,comport)
	movlw	13
	movwf	SERDATA
	call	HSERSEND

;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;HSerSend(10,comport)
	movlw	10
	movwf	SERDATA
	call	HSERSEND

;wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;end Repeat
	decfsz	SysRepeatTemp3,F
	goto	SysRepeatLoop3
SysRepeatLoopEnd3
	return

;********************************************************************************

HSERSEND
;if comport = 1 Then
	decf	COMPORT,W
	btfss	STATUS, Z
	goto	ENDIF7
;Wait While TXIF = Off
SysWaitLoop2
	banksel	PIR3
	btfss	PIR3,TXIF
	goto	SysWaitLoop2
;Wait While TXIF = Off
SysWaitLoop3
	btfss	PIR3,TXIF
	goto	SysWaitLoop3
;TXREG1 = SerData
	banksel	SERDATA
	movf	SERDATA,W
	banksel	TXREG1
	movwf	TXREG1
;end if
ENDIF7
	banksel	STATUS
	return

;********************************************************************************

HWSPITRANSFER
;If SPICurrentMode > 10 Then
	movf	SPICURRENTMODE,W
	sublw	10
	btfsc	STATUS, C
	goto	ELSE6_1
;Set SSPCON1.WCOL Off
	banksel	SSP1CON1
	bcf	SSP1CON1,WCOL
;SSPBUF = SPITxData
	banksel	SPITXDATA
	movf	SPITXDATA,W
	banksel	SSP1BUF
	movwf	SSP1BUF
;Else
	goto	ENDIF6
ELSE6_1
;Do
SysDoLoop_S1
;SET SSPCON1.WCOL OFF
	banksel	SSP1CON1
	bcf	SSP1CON1,WCOL
;SSPBUF = SPITxData
	banksel	SPITXDATA
	movf	SPITXDATA,W
	banksel	SSP1BUF
	movwf	SSP1BUF
;Loop While SSPCON1.WCOL = On
	btfsc	SSP1CON1,WCOL
	goto	SysDoLoop_S1
SysDoLoop_E1
;End If
ENDIF6
;Wait While SSPSTAT.BF = Off
SysWaitLoop1
	btfss	SSP1STAT,BF
	goto	SysWaitLoop1
;SPIRxData = SSPBUF
	movf	SSP1BUF,W
	banksel	SPIRXDATA
	movwf	SPIRXDATA
;Set SSPSTAT.BF Off
	banksel	SSP1STAT
	bcf	SSP1STAT,BF
	banksel	STATUS
	return

;********************************************************************************

INITPPS
;UNLOCKPPS
;dim IntState as bit
;IntState = GIE
	bcf	SYSBITVAR0,0
	btfsc	INTCON,GIE
	bsf	SYSBITVAR0,0
;GIE = 0
	bcf	INTCON,GIE
;PPSLOCK = 0x55
	movlw	85
	banksel	PPSLOCK
	movwf	PPSLOCK
;PPSLOCK = 0xAA
	movlw	170
	movwf	PPSLOCK
;PPSLOCKED = 0x00  'unlock PPS
	bcf	PPSLOCK,PPSLOCKED

;'Module: EUSART
;RC5PPS = 0x0010    'TX > RC5
;TXPPS = 0x0015    'RC5 > TX (bi-directional)
;SSP1CLKPPS = 0x09
;RB1PPS = 0x14
;
;SSP1DATPPS = 0x08
;RB3PPS = 0x15
;'Module: EUSART
;RC6PPS = 0x0010    'TX > RC6
;TXPPS = 0x0016    'RC6 > TX (bi-directional)
;'Module: MSSP1
;RB1PPS = 0x0014    'SCK1 > RB1
;SSP1CLKPPS = 0x0009    'RB1 > SCK1 (bi-directional)
;RB3PPS = 0x0015    'SDO1 > RB3
;RC5PPS = 0x0010    'TX > RC6
	movlw	16
	banksel	RC5PPS
	movwf	RC5PPS
;TXPPS = 0x0015    'RC6 > TX (bi-directional)
	movlw	21
	banksel	TXPPS
	movwf	TXPPS
;SSP1CLKPPS = 0x09;   //RB1->MSSP1:SCK1;
	movlw	9
	movwf	SSP1CLKPPS
;RB1PPS = 0x14;   //RB1->MSSP1:SCK1;
	movlw	20
	banksel	RB1PPS
	movwf	RB1PPS
;SSP1DATPPS = 0x08;   //RB0->MSSP1:SDI1;
	movlw	8
	banksel	SSP1DATPPS
	movwf	SSP1DATPPS
;RB3PPS = 0x15;   //RB3->MSSP1:SDO1;
	movlw	21
	banksel	RB3PPS
	movwf	RB3PPS
;LOCKPPS
;PPSLOCK = 0x55
	movlw	85
	banksel	PPSLOCK
	movwf	PPSLOCK
;PPSLOCK = 0xAA
	movlw	170
	movwf	PPSLOCK
;PPSLOCKED = 0x01  'lock PPS
	bsf	PPSLOCK,PPSLOCKED
;GIE = IntState
	banksel	SYSBITVAR0
	btfss	SYSBITVAR0,0
	bcf	INTCON,GIE
	btfsc	SYSBITVAR0,0
	bsf	INTCON,GIE

	return

;********************************************************************************

INITSYS
;nop             ' This is the routine to support OSCCON1 config addresss
	nop
;OSCCON1 = 0x60 ' NOSC HFINTOSC; NDIV 1 - Common as this simply sets the HFINTOSC
	movlw	96
	banksel	OSCCON1
	movwf	OSCCON1
;OSCCON3 = 0x00 ' CSWHOLD may proceed; SOSCPWR Low power
	clrf	OSCCON3
;OSCEN = 0x00   ' MFOEN disabled; LFOEN disabled; ADOEN disabled; SOSCEN disabled; EXTOEN disabled; HFOEN disabled
	clrf	OSCEN
;OSCTUNE = 0x00 ' HFTUN 0
	clrf	OSCTUNE
;OSCFRQ = 0b00000011
	movlw	3
	movwf	OSCFRQ
;SET ADCON0.ADON OFF
	banksel	ADCON0
	bcf	ADCON0,ADON
;ANSELA = 0
	banksel	ANSELA
	clrf	ANSELA
;ANSELB = 0
	clrf	ANSELB
;ANSELC = 0
	clrf	ANSELC
;ANSELD = 0
	clrf	ANSELD
;ANSELE = 0
	clrf	ANSELE
;#IFDEF bit(C2ON): C2ON = 0: #ENDIF
	banksel	CM2CON0
	bcf	CM2CON0,C2ON
;#IFDEF bit(C1ON): C1ON = 0: #ENDIF
	bcf	CM1CON0,C1ON
;PORTA = 0
	banksel	PORTA
	clrf	PORTA
;PORTB = 0
	clrf	PORTB
;PORTC = 0
	clrf	PORTC
;PORTD = 0
	clrf	PORTD
;PORTE = 0
	clrf	PORTE
	return

;********************************************************************************

INITUSART
;comport = 1
	movlw	1
	movwf	COMPORT
;SPBRG = SPBRGL_TEMP
	movlw	16
	banksel	SPBRG
	movwf	SPBRG
;SPBRGH = SPBRGH_TEMP
	clrf	SP1BRGH
;BRG16 = BRG16_TEMP
	bsf	BAUD1CON,BRG16
;BRGH = BRGH_TEMP
	bsf	TX1STA,BRGH
;Set SYNC Off
	bcf	TX1STA,SYNC_TX1STA
;Set SPEN On
	bsf	RC1STA,SPEN
;Set CREN On
	bsf	RC1STA,CREN
;Set TXEN On
	bsf	TX1STA,TXEN
	banksel	STATUS
	return

;********************************************************************************

;Overloaded signature: BYTE:BYTE:
SPIMODE181
;Dim SSPCON1 Alias SSP1CON1 ;added for 18f18855
;Dim SSPSTAT Alias SSP1STAT ;added for 18f18855
;Dim SSPBUF Alias SSP1BUF
;Set SSPCON1.SSPEN Off ;(Prevents any weird glitches during setup)
	banksel	SSP1CON1
	bcf	SSP1CON1,SSPEN
;Set SSPSTAT.SMP Off
	bcf	SSP1STAT,SMP
;Set SSPSTAT.CKE Off
	bcf	SSP1STAT,CKE
;If SPIClockMode.0 = Off Then
	banksel	SPICLOCKMODE
	btfsc	SPICLOCKMODE,0
	goto	ENDIF4
;Set SSPSTAT.CKE On
	banksel	SSP1STAT
	bsf	SSP1STAT,CKE
;End If
ENDIF4
;Set SSPCON1.CKP Off
	banksel	SSP1CON1
	bcf	SSP1CON1,CKP
;If SPIClockMode.1 = On Then
	banksel	SPICLOCKMODE
	btfss	SPICLOCKMODE,1
	goto	ENDIF5
;Set SSPCON1.CKP On
	banksel	SSP1CON1
	bsf	SSP1CON1,CKP
;End If
ENDIF5
;Set SSPCON1.SSPM3 Off
	banksel	SSP1CON1
	bcf	SSP1CON1,SSPM3
;Set SSPCON1.SSPM2 Off
	bcf	SSP1CON1,SSPM2
;Set SSPCON1.SSPM1 Off
	bcf	SSP1CON1,SSPM1
;Set SSPCON1.SSPM0 Off
	bcf	SSP1CON1,SSPM0
;Select Case SPICurrentMode
;Case MasterFast
SysSelect1Case1
	movlw	13
	banksel	SPICURRENTMODE
	subwf	SPICURRENTMODE,W
	btfss	STATUS, Z
	goto	SysSelect1Case2
;Case Master
	goto	SysSelectEnd1
SysSelect1Case2
	movlw	12
	subwf	SPICURRENTMODE,W
	btfss	STATUS, Z
	goto	SysSelect1Case3
;Set SSPCON1.SSPM0 On
	banksel	SSP1CON1
	bsf	SSP1CON1,SSPM0
;Case MasterSlow
	goto	SysSelectEnd1
SysSelect1Case3
	movlw	11
	subwf	SPICURRENTMODE,W
	btfss	STATUS, Z
	goto	SysSelect1Case4
;Set SSPCON1.SSPM1 On
	banksel	SSP1CON1
	bsf	SSP1CON1,SSPM1
;Case Slave
	goto	SysSelectEnd1
SysSelect1Case4
	movf	SPICURRENTMODE,F
	btfss	STATUS, Z
	goto	SysSelect1Case5
;Set SSPCON1.SSPM2 On
	banksel	SSP1CON1
	bsf	SSP1CON1,SSPM2
;Set SSPCON1.SSPM0 On
	bsf	SSP1CON1,SSPM0
;Case SlaveSS
	goto	SysSelectEnd1
SysSelect1Case5
	decf	SPICURRENTMODE,W
	btfss	STATUS, Z
	goto	SysSelect1Case6
;Set SSPCON1.SSPM2 On
	banksel	SSP1CON1
	bsf	SSP1CON1,SSPM2
;End Select
SysSelect1Case6
SysSelectEnd1
;Set SSPCON1.SSPEN On
	banksel	SSP1CON1
	bsf	SSP1CON1,SSPEN
	banksel	STATUS
	return

;********************************************************************************

SysStringTables
	movf	SysStringA_H,W
	movwf	PCLATH
	movf	SysStringA,W
	incf	SysStringA,F
	btfsc	STATUS,Z
	incf	SysStringA_H,F
	movwf	PCL

StringTable2
	retlw	20
	retlw	87	;W
	retlw	101	;e
	retlw	108	;l
	retlw	99	;c
	retlw	111	;o
	retlw	109	;m
	retlw	101	;e
	retlw	32	; 
	retlw	116	;t
	retlw	111	;o
	retlw	32	; 
	retlw	116	;t
	retlw	104	;h
	retlw	101	;e
	retlw	32	; 
	retlw	83	;S
	retlw	116	;t
	retlw	97	;a
	retlw	114	;r
	retlw	116	;t


StringTable3
	retlw	18
	retlw	87	;W
	retlw	101	;e
	retlw	108	;l
	retlw	99	;c
	retlw	111	;o
	retlw	109	;m
	retlw	101	;e
	retlw	32	; 
	retlw	116	;t
	retlw	111	;o
	retlw	32	; 
	retlw	116	;t
	retlw	104	;h
	retlw	101	;e
	retlw	32	; 
	retlw	69	;E
	retlw	110	;n
	retlw	100	;d


;********************************************************************************

;Start of program memory page 1
	ORG	2048
;Start of program memory page 2
	ORG	4096
;Start of program memory page 3
	ORG	6144
;Start of program memory page 4
	ORG	8192
;Start of program memory page 5
	ORG	10240
;Start of program memory page 6
	ORG	12288
;Start of program memory page 7
	ORG	14336
;Start of program memory page 8
	ORG	16384
;Start of program memory page 9
	ORG	18432
;Start of program memory page 10
	ORG	20480
;Start of program memory page 11
	ORG	22528
;Start of program memory page 12
	ORG	24576
;Start of program memory page 13
	ORG	26624
;Start of program memory page 14
	ORG	28672
;Start of program memory page 15
	ORG	30720

 END
