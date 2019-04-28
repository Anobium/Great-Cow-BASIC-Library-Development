;Program compiled by Great Cow BASIC (0.95 2016-05-09)
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F18855, r=DEC
#include <P16F18855.inc>
 __CONFIG _CONFIG1, _FEXTOSC_OFF & _RSTOSC_HFINT32
 __CONFIG _CONFIG2, _CPD_ON & _WRT_OFF & _MCLRE_ON
 __CONFIG _CONFIG3, _WDTE_OFF
 __CONFIG _CONFIG4, _LVP_OFF

;********************************************************************************

;Set aside memory locations for variables
01	EQU	32
ACKPSH	EQU	33
ADDR	EQU	34
ARRAYLOC	EQU	35
ARRAYLOC_H	EQU	36
BANKTOBESELECTED	EQU	37
BUTTONSTATE	EQU	38
CLIENT_SEQNUM	EQU	39
CLIENT_SEQNUM_E	EQU	43
CLIENT_SEQNUM_H	EQU	44
CLIENT_SEQNUM_U	EQU	45
COMMANDLINESTRING	EQU	8413
COMPORT	EQU	46
CURRBYTE	EQU	47
DEBUG01	EQU	48
DELAYTEMP	EQU	112
DELAYTEMP2	EQU	113
ENC28J60_DATA	EQU	49
ENC28J60_READREG	EQU	50
ENC28J60_TEMP	EQU	51
ENC_OUTBYTE	EQU	52
ENC_OUTBYTE1	EQU	53
ENC_OUTBYTE2	EQU	54
ETHERBUFFER	EQU	8467
ETHERGETLENGTH	EQU	55
ETHERGETLENGTH_H	EQU	56
ETH_COUNTER	EQU	57
ETH_COUNTER_H	EQU	59
ETH_FRAMELENGTH	EQU	60
ETH_FRAMELENGTH_H	EQU	62
EXPECTED_ACK	EQU	63
EXPECTED_ACK_E	EQU	66
EXPECTED_ACK_H	EQU	64
EXPECTED_ACK_U	EQU	65
FLAGS	EQU	67
FNLSL	EQU	68
FNLSL_E	EQU	71
FNLSL_H	EQU	69
FNLSL_U	EQU	70
FNLSR	EQU	72
FNLSR_E	EQU	75
FNLSR_H	EQU	73
FNLSR_U	EQU	74
HSERPRINTCRLFCOUNT	EQU	76
HTMLMAPPING	EQU	77
HTMLMAPPINGTYPE	EQU	78
HTTPCLOSETRANSACTION	EQU	79
HTTPPRINTCRLFFLAG	EQU	80
HTTPSENTTCPPACKET	EQU	81
HTTPSTANDARDHEADERSTATUSBIT	EQU	82
HULP2	EQU	83
HULP2_H	EQU	85
HULP3	EQU	86
II	EQU	87
INCOMING_ACK	EQU	88
INCOMING_ACK_E	EQU	92
INCOMING_ACK_H	EQU	93
INCOMING_ACK_U	EQU	94
IPADDR	EQU	8390
IPPORT	EQU	95
IPROUTER	EQU	8385
IP_CHECKSUM16	EQU	96
IP_CHECKSUM16_H	EQU	97
IP_CHKSUM32	EQU	98
IP_CHKSUM32_E	EQU	101
IP_CHKSUM32_H	EQU	99
IP_CHKSUM32_U	EQU	100
IP_HEADER_LENGTH	EQU	102
IP_HULP1	EQU	103
IP_ID	EQU	104
IP_ID_H	EQU	105
IP_TEMP16	EQU	106
IP_TEMP16_H	EQU	107
IP_X	EQU	108
I_CHECKSUM16	EQU	109
I_CHECKSUM16_H	EQU	111
I_CHKSUM32	EQU	160
I_CHKSUM32_E	EQU	163
I_CHKSUM32_H	EQU	161
I_CHKSUM32_U	EQU	125
I_ODD	EQU	126
I_X	EQU	164
I_X_H	EQU	165
LASTGET	EQU	127
LASTSELECTEDBANK	EQU	166
MACADDR	EQU	8395
MACADDRROUTER	EQU	8380
MAXLEN	EQU	167
MAXLEN_H	EQU	168
MSG_TEMP2	EQU	8402
NEXTPACKETPTR	EQU	169
NEXTPACKETPTR_H	EQU	171
NUMBITS	EQU	172
OUTVALUETEMP	EQU	173
PCKTLEN	EQU	174
PCKTLEN_H	EQU	175
PHYREGADDR	EQU	176
PREVIOUS_NEXTPACKETPTR	EQU	177
PREVIOUS_NEXTPACKETPTR_H	EQU	178
PRINTLEN	EQU	179
RXSTAT	EQU	180
RXSTAT_H	EQU	181
SERDATA	EQU	182
SERPRINTVAL	EQU	183
SNTPSERVERADDR	EQU	8375
SPICLOCKMODE	EQU	184
SPICURRENTMODE	EQU	185
SPIRXDATA	EQU	186
SPITXDATA	EQU	187
STRINGPOINTER	EQU	188
SYSARRAYTEMP1	EQU	189
SYSARRAYTEMP2	EQU	190
SYSBITVAR0	EQU	191
SYSBYTETEMPA	EQU	117
SYSBYTETEMPB	EQU	121
SYSBYTETEMPX	EQU	112
SYSCALCTEMPA	EQU	117
SYSCALCTEMPB	EQU	121
SYSCALCTEMPX	EQU	112
SYSDIVLOOP	EQU	116
SYSDIVMULTA	EQU	119
SYSDIVMULTA_H	EQU	120
SYSDIVMULTB	EQU	123
SYSDIVMULTB_H	EQU	124
SYSDIVMULTX	EQU	114
SYSDIVMULTX_H	EQU	115
SYSFNBYTE1	EQU	192
SYSHTTPDATAHANDLER	EQU	193
SYSHTTPDATAHANDLER_H	EQU	194
SYSLONGTEMPB	EQU	121
SYSLONGTEMPB_E	EQU	124
SYSLONGTEMPB_H	EQU	122
SYSLONGTEMPB_U	EQU	123
SYSMACADDRHANDLER	EQU	195
SYSMACADDRHANDLER_H	EQU	196
SYSPRINTDATAHANDLER	EQU	197
SYSPRINTDATAHANDLER_H	EQU	198
SYSPRINTTEMP	EQU	199
SYSREPEATTEMP1	EQU	200
SYSREPEATTEMP2	EQU	201
SYSREPEATTEMP3	EQU	202
SYSREPEATTEMP4	EQU	203
SYSREPEATTEMP5	EQU	204
SYSREPEATTEMP6	EQU	205
SYSREPEATTEMP7	EQU	206
SYSREPEATTEMP8	EQU	207
SYSREPEATTEMP9	EQU	208
SYSSTRINGA	EQU	119
SYSSTRINGA_H	EQU	120
SYSSTRINGLENGTH	EQU	118
SYSSTRINGPARAM1	EQU	8426
SYSTEMP1	EQU	209
SYSTEMP1_E	EQU	212
SYSTEMP1_H	EQU	210
SYSTEMP1_U	EQU	211
SYSTEMP2	EQU	213
SYSTEMP2_H	EQU	214
SYSTEMP3	EQU	215
SYSWAITTEMPMS	EQU	114
SYSWAITTEMPMS_H	EQU	115
SYSWORDTEMPA	EQU	117
SYSWORDTEMPA_H	EQU	118
SYSWORDTEMPB	EQU	121
SYSWORDTEMPB_H	EQU	122
SYSWORDTEMPX	EQU	112
SYSWORDTEMPX_H	EQU	113
TABLELOC	EQU	216
TABLELOC_H	EQU	217
TABLESTARTPOINT	EQU	218
TABLESTARTPOINT_H	EQU	219
TCPDATALEN_IN	EQU	220
TCPDATALEN_IN_H	EQU	221
TCPDATALEN_OUT	EQU	222
TCPDATALEN_OUT_H	EQU	223
TCPRESULT16	EQU	224
TCPRESULT16_H	EQU	226
TEMP	EQU	227
TEMPSTRING1	EQU	8372
TT	EQU	228
T_UDP_DESTPORT	EQU	229
T_UDP_DESTPORT_H	EQU	230
VAL1	EQU	231
VAL2	EQU	232
VAL2_H	EQU	233
VAL3	EQU	234
VAL4	EQU	235
WORK	EQU	236
X_ODD	EQU	237

;********************************************************************************

;Alias variables
AFSR0	EQU	4
AFSR0_H	EQU	5
I_VALUE16	EQU	109
I_VALUE16_H	EQU	111
SSPBUF	EQU	396
SSPCON1	EQU	400
SSPSTAT	EQU	399
SYSCOMMANDLINESTRING_0	EQU	349
SYSETHERBUFFER_1	EQU	452
SYSETHERBUFFER_10	EQU	461
SYSETHERBUFFER_11	EQU	462
SYSETHERBUFFER_12	EQU	463
SYSETHERBUFFER_13	EQU	464
SYSETHERBUFFER_14	EQU	465
SYSETHERBUFFER_15	EQU	466
SYSETHERBUFFER_17	EQU	468
SYSETHERBUFFER_18	EQU	469
SYSETHERBUFFER_2	EQU	453
SYSETHERBUFFER_21	EQU	472
SYSETHERBUFFER_22	EQU	473
SYSETHERBUFFER_23	EQU	474
SYSETHERBUFFER_24	EQU	475
SYSETHERBUFFER_25	EQU	476
SYSETHERBUFFER_26	EQU	477
SYSETHERBUFFER_27	EQU	478
SYSETHERBUFFER_28	EQU	479
SYSETHERBUFFER_29	EQU	480
SYSETHERBUFFER_3	EQU	454
SYSETHERBUFFER_30	EQU	481
SYSETHERBUFFER_31	EQU	482
SYSETHERBUFFER_32	EQU	483
SYSETHERBUFFER_33	EQU	484
SYSETHERBUFFER_34	EQU	485
SYSETHERBUFFER_35	EQU	486
SYSETHERBUFFER_36	EQU	487
SYSETHERBUFFER_37	EQU	488
SYSETHERBUFFER_38	EQU	489
SYSETHERBUFFER_39	EQU	490
SYSETHERBUFFER_4	EQU	455
SYSETHERBUFFER_40	EQU	491
SYSETHERBUFFER_41	EQU	492
SYSETHERBUFFER_42	EQU	493
SYSETHERBUFFER_43	EQU	494
SYSETHERBUFFER_44	EQU	495
SYSETHERBUFFER_45	EQU	544
SYSETHERBUFFER_46	EQU	545
SYSETHERBUFFER_47	EQU	546
SYSETHERBUFFER_48	EQU	547
SYSETHERBUFFER_49	EQU	548
SYSETHERBUFFER_5	EQU	456
SYSETHERBUFFER_50	EQU	549
SYSETHERBUFFER_51	EQU	550
SYSETHERBUFFER_52	EQU	551
SYSETHERBUFFER_55	EQU	554
SYSETHERBUFFER_56	EQU	555
SYSETHERBUFFER_57	EQU	556
SYSETHERBUFFER_58	EQU	557
SYSETHERBUFFER_59	EQU	558
SYSETHERBUFFER_6	EQU	457
SYSETHERBUFFER_60	EQU	559
SYSETHERBUFFER_61	EQU	560
SYSETHERBUFFER_7	EQU	458
SYSETHERBUFFER_8	EQU	459
SYSETHERBUFFER_9	EQU	460
SYSIPADDR_1	EQU	327
SYSIPADDR_2	EQU	328
SYSIPADDR_3	EQU	329
SYSIPADDR_4	EQU	330
SYSMACADDR_1	EQU	332
SYSMACADDR_2	EQU	333
SYSMACADDR_3	EQU	334
SYSMACADDR_4	EQU	335
SYSMACADDR_5	EQU	336
SYSMACADDR_6	EQU	337

;********************************************************************************

;Vectors
	ORG	0
	goto	BASPROGRAMSTART
	ORG	4
	retfie

;********************************************************************************

;Start of program memory page 0
	ORG	5
BASPROGRAMSTART
;Call initialisation routines
	pagesel	INITSYS
	call	INITSYS
	pagesel	$
	call	ENC28J60_INITIALISE
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
;''	You NEED a PC terminal connected to the serial out on the microprocessor.
;''
;''@author 		[todo]
;''@licence		GPL
;''@version		[todo]
;''@date   		[todo]
;''********************************************************************************
;#option explicit
;debug01  = 0
	clrf	DEBUG01
;UNLOCKPPS
;dim IntState as bit
;IntState = GIE
	banksel	SYSBITVAR0
	bcf	SYSBITVAR0,7
	btfsc	INTCON,GIE
	bsf	SYSBITVAR0,7
;GIE = 0
	bcf	INTCON,GIE
;PPSLOCK = 0x55
	movlw	85
	banksel	PPSLOCK
	movwf	PPSLOCK
;PPSLOCK = 0xAA
	movlw	170
	movwf	PPSLOCK
;PPSLOCKED = 0x00 	'unlock PPS
	bcf	PPSLOCK,PPSLOCKED
;RC0PPS = 0x0010		  'RC0->EUSART:TX;
	movlw	16
	banksel	RC0PPS
	movwf	RC0PPS
;RXPPS  = 0x0011 		'RC1->EUSART:RX;
	movlw	17
	banksel	RXPPS
	movwf	RXPPS
;RB3PPS = 0x0014     'RB3->MSSP1:SCK1;
	movlw	20
	banksel	RB3PPS
	movwf	RB3PPS
;SSP1CLKPPS = 0x000B 'RB3->MSSP1:SCK1;
	movlw	11
	banksel	SSP1CLKPPS
	movwf	SSP1CLKPPS
;SSP1DATPPS = 0x000C 'RB4->MSSP1:SDI1;
	movlw	12
	movwf	SSP1DATPPS
;RB5PPS = 0x0015     'RB5->MSSP1:SDO1;
	movlw	21
	banksel	RB5PPS
	movwf	RB5PPS
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
	btfss	SYSBITVAR0,7
	bcf	INTCON,GIE
	btfsc	SYSBITVAR0,7
	bsf	INTCON,GIE
;#define USART_BAUD_RATE 115200
;#define USART_BLOCKING
;#define USART_TX_BLOCKING
;----- Define Hardware settings
;#define ENC28j60_DI			portb.4						'Connected to Device SO
;#define ENC28j60_DO			portb.5							'Connected to Device SI
;#define ENC28j60_SCK		portb.3							'Connected to Clock
;#define ENC28j60_CS 		portb.2							'Chip select line
;#define ENC28j60_RESET  PORTb.1							'Reset line
;----- Variables
;----- Quick Command Reference:
;----- Main body of program commences here.
;HSerPrintCRLF 2
	movlw	2
	banksel	HSERPRINTCRLFCOUNT
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$
;HserPrint "ENC28j60 Ethernet Driver 031_004" : HSerPrintCRLF
	movlw	low StringTable4
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable4) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT259
	call	HSERPRINT259
	pagesel	$
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$
;HSerSend 7
	movlw	7
	banksel	SERDATA
	movwf	SERDATA
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERSEND
	call	HSERSEND
	pagesel	$
RESET_ENC26J60
;ipaddr = 192,168,0,4
	movlw	low IPADDR
	movwf	FSR0L
	movlw	high IPADDR
	movwf	FSR0H
	movlw	4
	movwf	INDF0
	incf	FSR0L,F
	movlw	192
	movwf	INDF0
	incf	FSR0L,F
	movlw	168
	movwf	INDF0
	incf	FSR0L,F
	clrf	INDF0
	incf	FSR0L,F
	movlw	4
	movwf	INDF0
;macaddr = 0x00, 0x1E, 0xC0, 0x00, 0x00, 0x04
	movlw	low MACADDR
	movwf	FSR0L
	movlw	high MACADDR
	movwf	FSR0H
	movlw	6
	movwf	INDF0
	incf	FSR0L,F
	clrf	INDF0
	incf	FSR0L,F
	movlw	30
	movwf	INDF0
	incf	FSR0L,F
	movlw	192
	movwf	INDF0
	incf	FSR0L,F
	clrf	INDF0
	incf	FSR0L,F
	clrf	INDF0
	incf	FSR0L,F
	movlw	4
	movwf	INDF0
;ipport = 80
	movlw	80
	movwf	IPPORT
;ipserver = 192,168,0,106
;iprouter = 192,168,0,250
	movlw	low IPROUTER
	movwf	FSR0L
	movlw	high IPROUTER
	movwf	FSR0H
	movlw	4
	movwf	INDF0
	incf	FSR0L,F
	movlw	192
	movwf	INDF0
	incf	FSR0L,F
	movlw	168
	movwf	INDF0
	incf	FSR0L,F
	clrf	INDF0
	incf	FSR0L,F
	movlw	250
	movwf	INDF0
;macaddrrouter = 0x00, 0x50, 0x7f, 0xdc, 0x64, 0x48
	movlw	low MACADDRROUTER
	movwf	FSR0L
	movlw	high MACADDRROUTER
	movwf	FSR0H
	movlw	6
	movwf	INDF0
	incf	FSR0L,F
	clrf	INDF0
	incf	FSR0L,F
	movlw	80
	movwf	INDF0
	incf	FSR0L,F
	movlw	127
	movwf	INDF0
	incf	FSR0L,F
	movlw	220
	movwf	INDF0
	incf	FSR0L,F
	movlw	100
	movwf	INDF0
	incf	FSR0L,F
	movlw	72
	movwf	INDF0
;sntpserveraddr = 129, 6, 15, 28
	movlw	low SNTPSERVERADDR
	movwf	FSR0L
	movlw	high SNTPSERVERADDR
	movwf	FSR0H
	movlw	4
	movwf	INDF0
	incf	FSR0L,F
	movlw	129
	movwf	INDF0
	incf	FSR0L,F
	movlw	6
	movwf	INDF0
	incf	FSR0L,F
	movlw	15
	movwf	INDF0
	incf	FSR0L,F
	movlw	28
	movwf	INDF0
;ENC28j60_Init ( macaddr )
	movlw	low MACADDR
	banksel	SYSMACADDRHANDLER
	movwf	SysMACADDRHandler
	movlw	high MACADDR
	movwf	SysMACADDRHandler_H
	banksel	STATUS
	pagesel	ENC28J60_INIT
	call	ENC28J60_INIT
	pagesel	$
;HserPrint "Initialised"
	movlw	low StringTable5
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable5) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT259
	call	HSERPRINT259
	pagesel	$
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$
;#define SwitchIn porta.5
;dir SwitchIn  in
	bsf	TRISA,5
;#define ButtonDown = 0
;buttonstate = ButtonDown
	clrf	BUTTONSTATE
;ENC28j60_bitSet( ECON1 , econ1_txrst )
;ENC28j60_bitClear( ECON1 , econ1_txrst )
;ENC28j60_writeReg( ERXFCON, 0 )
	movlw	56
	movwf	ADDR
	clrf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;dim myReadTime as bit
;myReadTime = 0
	banksel	SYSBITVAR0
	bcf	SYSBITVAR0,0
;Do forever
SysDoLoop_S1
;if SwitchIn = buttonstate then
	clrf	SysCalcTempA
	banksel	PORTA
	btfsc	PORTA,5
	incf	SysCalcTempA,F
	movf	BUTTONSTATE,W
	subwf	SysCalcTempA,W
	btfss	STATUS, Z
	goto	ENDIF2
;if buttonstate  = ButtonDown then
	movf	BUTTONSTATE,F
	btfss	STATUS, Z
	goto	ENDIF3
;end if
ENDIF3
;end if
ENDIF2
;ENC28j60_poll 'Start the process.
	pagesel	ENC28J60_POLL
	call	ENC28J60_POLL
	pagesel	$
;if myReadTime = 0 then
;ENC28j60_sntp_get                       'get the Network Time once
;myReadTime = 1
;end if
;Loop
	goto	SysDoLoop_S1
SysDoLoop_E1
;end
	goto	BASPROGRAMEND
;----- Support methods.  Subroutines and Functions
;CHANGE Epoch_seconds  TO SUIT LOCAL NEEDS.. IN SECONDS!!
;If you want use the CALCULATED UDP checksum.  Not required typically.
;#define ENC28j60_UDP_checkSum_Supported
;If you want the ENC28j60 to respond to ICMP/Ping requests
;#define ENC28j60_ping_Supported
;If you want the ENC28j60 to put things on the terminal
;#define ENC28j60_Hserial_Supported
;#define ENC28j60_packetCounting_Supported
;#define ENC28j60_BufferErrorMessages_Supported
;#define ReceivePacketDebug_Supported
;#define ENC28j60_ShowHTTPAddress_Supported
;#define ENC28j60_ShowHTTPInfo_Supported
;#define ShowHTTPHeader_Supported
;#define ShowHTTPFlags
;If you want the UDP protocols to be supported.  You cannot turn off UDP/ARP
;#define ENC28j60_UDP_Supported
;#define ENC28j60_reinitialisation_Supported
;#define ENC28j60_sntp_Supported
;#define ENC28j60_sntp_UTC_adjust_supported
;#define ENC28j60_sntp_Remote_Supported
;#define ENC28j60_Echo7_Supported
;#define ENC28j60regdump_Supported
;If you want the TCP protocols to be supported.
;#define ENC28j60_tcp_supported
;#define ENC28j60_http_supported
;#define ENC28j60_telnet_supported
;If you want to add your own UDP handler.
;#define ENC28j60_Handle_udp My_udp_handler
;''http://www.hackshed.co.uk/lets-build-a-functional-arduino-webserver-sdcard-ethernet/
;#define HTTP_HANDLER userSubAJAX
;#define etherBufferSize 500
;sub userSubAJAX
;HTTPPrint str(55155)
;
;end sub
;http://tmail.mooo.com:8080                         'shows index.htm
;http://tmail.mooo.com:8080/index.htm               'shows index.htm
;http://tmail.mooo.com:8080/?data=val1              'currently, shows port status page. This will be an AJAX call.
;http://tmail.mooo.com:8080/?data=val1              'not operational. Will be AJAX call.
;http://tmail.mooo.com:8080/anyinvalidurl           'shows 403 error
;#define HTTP_HANDLER myHTTP_HANDLER
;#define etherBufferSize 620
;#define ENC28j60_Select         Set ENC28j60_CS off
;#define ENC28j60_Deselect       Set ENC28j60_CS on
;#define ENC28j60_Reset_CMD			Set ENC28j60_RESET on: Wait 20 ms :Set ENC28j60_RESET off: Wait 20 ms :Set ENC28j60_RESET on: Wait 20 ms
;#define Synflag = 0
;#define Finflag = 1
CONFIGURATIONDETAILS
MEMORY_LOCATIONS_SCRIPT
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

;********************************************************************************

ENC28J60_INITIALISE
;macaddr =   0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	movlw	low MACADDR
	movwf	FSR0L
	movlw	high MACADDR
	movwf	FSR0H
	movlw	6
	movwf	INDF0
	incf	FSR0L,F
	clrf	INDF0
	incf	FSR0L,F
	clrf	INDF0
	incf	FSR0L,F
	clrf	INDF0
	incf	FSR0L,F
	clrf	INDF0
	incf	FSR0L,F
	clrf	INDF0
	incf	FSR0L,F
	clrf	INDF0
;ipaddr =    0,0,0,0
	movlw	low IPADDR
	movwf	FSR0L
	movlw	high IPADDR
	movwf	FSR0H
	movlw	4
	movwf	INDF0
	incf	FSR0L,F
	clrf	INDF0
	incf	FSR0L,F
	clrf	INDF0
	incf	FSR0L,F
	clrf	INDF0
	incf	FSR0L,F
	clrf	INDF0
;ipserver =  0,0,0,0
;ipport = 80   'set a default value
	movlw	80
	movwf	IPPORT
;Ip_id = 0
	clrf	IP_ID
	clrf	IP_ID_H
;an outstanding GET is a pending flag
;lastGet = 0
	clrf	LASTGET
;TableStartPoint =1
	movlw	1
	banksel	TABLESTARTPOINT
	movwf	TABLESTARTPOINT
	clrf	TABLESTARTPOINT_H
	banksel	STATUS
	return

;********************************************************************************

ENC28J60_SET_RESPONSE_IPPACKET
;T_ip_destaddr0 = T_ip_srcaddr0
	banksel	SYSETHERBUFFER_27
	movf	SYSETHERBUFFER_27,W
	movwf	SYSETHERBUFFER_31
;T_ip_destaddr1 = T_ip_srcaddr1
	movf	SYSETHERBUFFER_28,W
	movwf	SYSETHERBUFFER_32
;T_ip_destaddr2 = T_ip_srcaddr2
	movf	SYSETHERBUFFER_29,W
	movwf	SYSETHERBUFFER_33
;T_ip_destaddr3 = T_ip_srcaddr3
	movf	SYSETHERBUFFER_30,W
	movwf	SYSETHERBUFFER_34
;T_ip_srcaddr0 = ipaddr(1)
	banksel	SYSIPADDR_1
	movf	SYSIPADDR_1,W
	banksel	SYSETHERBUFFER_27
	movwf	SYSETHERBUFFER_27
;T_ip_srcaddr1 = ipaddr(2)
	banksel	SYSIPADDR_2
	movf	SYSIPADDR_2,W
	banksel	SYSETHERBUFFER_28
	movwf	SYSETHERBUFFER_28
;T_ip_srcaddr2 = ipaddr(3)
	banksel	SYSIPADDR_3
	movf	SYSIPADDR_3,W
	banksel	SYSETHERBUFFER_29
	movwf	SYSETHERBUFFER_29
;T_ip_srcaddr3 = ipaddr(4)
	banksel	SYSIPADDR_4
	movf	SYSIPADDR_4,W
	banksel	SYSETHERBUFFER_30
	movwf	SYSETHERBUFFER_30
;ENC28j60_set_response_macaddress
	banksel	STATUS
	pagesel	ENC28J60_SET_RESPONSE_MACADDRESS
	call	ENC28J60_SET_RESPONSE_MACADDRESS
	pagesel	$
;ENC28j60_Ip_header_checksum
	pagesel	ENC28J60_IP_HEADER_CHECKSUM
	goto	ENC28J60_IP_HEADER_CHECKSUM

;********************************************************************************

ENC28J60_TCP_CHECKSUM
;Dim Whulp1 As Word
;Dim Tempword2 As Word
;dim I_chksum32 as long
;dim Hulp2, I_x as word
;tcp_cksum0 = 0x00
	banksel	SYSETHERBUFFER_51
	clrf	SYSETHERBUFFER_51
;tcp_cksum1 = 0x00
	clrf	SYSETHERBUFFER_52
;I_chksum32 = 0
	banksel	I_CHKSUM32
	clrf	I_CHKSUM32
	clrf	I_CHKSUM32_H
	banksel	I_CHKSUM32_U
	clrf	I_CHKSUM32_U
	banksel	I_CHKSUM32_E
	clrf	I_CHKSUM32_E
;I_value16_h = T_ip_srcaddr0
	banksel	SYSETHERBUFFER_27
	movf	SYSETHERBUFFER_27,W
	banksel	I_VALUE16_H
	movwf	I_VALUE16_H
;[byte]I_value16 = T_ip_srcaddr1
	banksel	SYSETHERBUFFER_28
	movf	SYSETHERBUFFER_28,W
	banksel	I_VALUE16
	movwf	I_VALUE16
;I_chksum32 = I_value16 + I_chksum32
	banksel	I_CHKSUM32
	movf	I_CHKSUM32,W
	banksel	I_VALUE16
	addwf	I_VALUE16,W
	banksel	I_CHKSUM32
	movwf	I_CHKSUM32
	movf	I_CHKSUM32_H,W
	banksel	I_VALUE16_H
	addwfc	I_VALUE16_H,W
	banksel	I_CHKSUM32_H
	movwf	I_CHKSUM32_H
	clrf	SysTemp3
	banksel	I_CHKSUM32_U
	movf	I_CHKSUM32_U,W
	banksel	SYSTEMP3
	addwfc	SysTemp3,W
	banksel	I_CHKSUM32_U
	movwf	I_CHKSUM32_U
	movlw	0
	banksel	SYSTEMP1
	movwf	SysTemp1
	movf	I_CHKSUM32_E,W
	addwfc	SysTemp1,W
	movwf	I_CHKSUM32_E
;I_value16_h = T_ip_srcaddr2
	banksel	SYSETHERBUFFER_29
	movf	SYSETHERBUFFER_29,W
	banksel	I_VALUE16_H
	movwf	I_VALUE16_H
;[byte]I_value16 = T_ip_srcaddr3
	banksel	SYSETHERBUFFER_30
	movf	SYSETHERBUFFER_30,W
	banksel	I_VALUE16
	movwf	I_VALUE16
;I_chksum32 = I_value16 + I_chksum32
	banksel	I_CHKSUM32
	movf	I_CHKSUM32,W
	banksel	I_VALUE16
	addwf	I_VALUE16,W
	banksel	I_CHKSUM32
	movwf	I_CHKSUM32
	movf	I_CHKSUM32_H,W
	banksel	I_VALUE16_H
	addwfc	I_VALUE16_H,W
	banksel	I_CHKSUM32_H
	movwf	I_CHKSUM32_H
	clrf	SysTemp3
	banksel	I_CHKSUM32_U
	movf	I_CHKSUM32_U,W
	banksel	SYSTEMP3
	addwfc	SysTemp3,W
	banksel	I_CHKSUM32_U
	movwf	I_CHKSUM32_U
	movlw	0
	banksel	SYSTEMP1
	movwf	SysTemp1
	movf	I_CHKSUM32_E,W
	addwfc	SysTemp1,W
	movwf	I_CHKSUM32_E
;I_value16_h = T_ip_destaddr0
	banksel	SYSETHERBUFFER_31
	movf	SYSETHERBUFFER_31,W
	banksel	I_VALUE16_H
	movwf	I_VALUE16_H
;[byte]I_value16 = T_ip_destaddr1
	banksel	SYSETHERBUFFER_32
	movf	SYSETHERBUFFER_32,W
	banksel	I_VALUE16
	movwf	I_VALUE16
;I_chksum32 = I_value16 + I_chksum32
	banksel	I_CHKSUM32
	movf	I_CHKSUM32,W
	banksel	I_VALUE16
	addwf	I_VALUE16,W
	banksel	I_CHKSUM32
	movwf	I_CHKSUM32
	movf	I_CHKSUM32_H,W
	banksel	I_VALUE16_H
	addwfc	I_VALUE16_H,W
	banksel	I_CHKSUM32_H
	movwf	I_CHKSUM32_H
	clrf	SysTemp3
	banksel	I_CHKSUM32_U
	movf	I_CHKSUM32_U,W
	banksel	SYSTEMP3
	addwfc	SysTemp3,W
	banksel	I_CHKSUM32_U
	movwf	I_CHKSUM32_U
	movlw	0
	banksel	SYSTEMP1
	movwf	SysTemp1
	movf	I_CHKSUM32_E,W
	addwfc	SysTemp1,W
	movwf	I_CHKSUM32_E
;I_value16_h = T_ip_destaddr2
	banksel	SYSETHERBUFFER_33
	movf	SYSETHERBUFFER_33,W
	banksel	I_VALUE16_H
	movwf	I_VALUE16_H
;[byte]I_value16 = T_ip_destaddr3
	banksel	SYSETHERBUFFER_34
	movf	SYSETHERBUFFER_34,W
	banksel	I_VALUE16
	movwf	I_VALUE16
;I_chksum32 = I_value16 + I_chksum32
	banksel	I_CHKSUM32
	movf	I_CHKSUM32,W
	banksel	I_VALUE16
	addwf	I_VALUE16,W
	banksel	I_CHKSUM32
	movwf	I_CHKSUM32
	movf	I_CHKSUM32_H,W
	banksel	I_VALUE16_H
	addwfc	I_VALUE16_H,W
	banksel	I_CHKSUM32_H
	movwf	I_CHKSUM32_H
	clrf	SysTemp3
	banksel	I_CHKSUM32_U
	movf	I_CHKSUM32_U,W
	banksel	SYSTEMP3
	addwfc	SysTemp3,W
	banksel	I_CHKSUM32_U
	movwf	I_CHKSUM32_U
	movlw	0
	banksel	SYSTEMP1
	movwf	SysTemp1
	movf	I_CHKSUM32_E,W
	addwfc	SysTemp1,W
	movwf	I_CHKSUM32_E
;I_chksum32 = I_chksum32 + T_ip_proto
	banksel	SYSETHERBUFFER_24
	movf	SYSETHERBUFFER_24,W
	banksel	I_CHKSUM32
	addwf	I_CHKSUM32,F
	movlw	0
	addwfc	I_CHKSUM32_H,F
	movlw	0
	banksel	I_CHKSUM32_U
	addwfc	I_CHKSUM32_U,F
	movlw	0
	banksel	I_CHKSUM32_E
	addwfc	I_CHKSUM32_E,F
;ENC28j60_calc_ippartial_checksum
;I_value16 = T_ip_vers_len And 0x0F
	movlw	15
	banksel	SYSETHERBUFFER_15
	andwf	SYSETHERBUFFER_15,W
	banksel	I_VALUE16
	movwf	I_VALUE16
	clrf	I_VALUE16_H
;I_value16 = I_value16 * 4
	movf	I_VALUE16,W
	movwf	SysWORDTempA
	movf	I_VALUE16_H,W
	movwf	SysWORDTempA_H
	movlw	4
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysMultSub16
	call	SysMultSub16
	pagesel	$
	movf	SysWORDTempX,W
	movwf	I_VALUE16
	movf	SysWORDTempX_H,W
	movwf	I_VALUE16_H
;I_chksum32 = I_chksum32 - I_value16
	movf	I_VALUE16,W
	banksel	I_CHKSUM32
	subwf	I_CHKSUM32,F
	banksel	I_VALUE16_H
	movf	I_VALUE16_H,W
	banksel	I_CHKSUM32_H
	subwfb	I_CHKSUM32_H,F
	movlw	0
	banksel	I_CHKSUM32_U
	subwfb	I_CHKSUM32_U,F
	movlw	0
	banksel	I_CHKSUM32_E
	subwfb	I_CHKSUM32_E,F
;I_value16_h = T_ip_pktlen0
	banksel	SYSETHERBUFFER_17
	movf	SYSETHERBUFFER_17,W
	banksel	I_VALUE16_H
	movwf	I_VALUE16_H
;[byte]I_value16 = T_ip_pktlen1
	banksel	SYSETHERBUFFER_18
	movf	SYSETHERBUFFER_18,W
	banksel	I_VALUE16
	movwf	I_VALUE16
;I_chksum32 = I_value16 + I_chksum32
	banksel	I_CHKSUM32
	movf	I_CHKSUM32,W
	banksel	I_VALUE16
	addwf	I_VALUE16,W
	banksel	I_CHKSUM32
	movwf	I_CHKSUM32
	movf	I_CHKSUM32_H,W
	banksel	I_VALUE16_H
	addwfc	I_VALUE16_H,W
	banksel	I_CHKSUM32_H
	movwf	I_CHKSUM32_H
	clrf	SysTemp3
	banksel	I_CHKSUM32_U
	movf	I_CHKSUM32_U,W
	banksel	SYSTEMP3
	addwfc	SysTemp3,W
	banksel	I_CHKSUM32_U
	movwf	I_CHKSUM32_U
	movlw	0
	banksel	SYSTEMP1
	movwf	SysTemp1
	movf	I_CHKSUM32_E,W
	addwfc	SysTemp1,W
	movwf	I_CHKSUM32_E
;I_odd = I_value16 Mod 2
	banksel	I_VALUE16
	movf	I_VALUE16,W
	movwf	SysWORDTempA
	movf	I_VALUE16_H,W
	movwf	SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempX,W
	movwf	I_ODD
;Hulp2 = 0x23 + I_value16 - 22 'should be 20 bytes (for the IP Header ) be two bytes less for gcb For-next loop
	movlw	35
	addwf	I_VALUE16,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	0
	banksel	I_VALUE16_H
	addwfc	I_VALUE16_H,W
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H
	movlw	22
	subwf	SysTemp2,W
	banksel	HULP2
	movwf	HULP2
	movlw	0
	banksel	SYSTEMP2_H
	subwfb	SysTemp2_H,W
	banksel	HULP2_H
	movwf	HULP2_H
;I_odd = T_udp_len1 Mod 2
	clrf	I_ODD
	banksel	SYSETHERBUFFER_40
	btfss	SYSETHERBUFFER_40,0
	goto	ENDIF66
	banksel	I_ODD
	incf	I_ODD,F
ENDIF66
;If I_odd = 1 Then
	banksel	I_ODD
	decf	I_ODD,W
	btfss	STATUS, Z
	goto	ENDIF63
;Hulp2 =  Hulp2 + 1
	incf	HULP2,F
	btfsc	STATUS,Z
	incf	HULP2_H,F
;etherbuffer( Hulp2 + 1 ) = 0x00
	movlw	low(ETHERBUFFER)
	addwf	HULP2,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	high(ETHERBUFFER)
	banksel	HULP2_H
	addwfc	HULP2_H,W
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H
	movlw	1
	addwf	SysTemp2,W
	movwf	AFSR0
	movlw	0
	addwfc	SysTemp2_H,W
	movwf	AFSR0_H
	clrf	INDF0
;End If
ENDIF63
;For I_x = 0x23 To Hulp2 Step 2
	movlw	33
	banksel	I_X
	movwf	I_X
	clrf	I_X_H
	movlw	35
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	HULP2
	movf	HULP2,W
	movwf	SysWORDTempA
	movf	HULP2_H,W
	movwf	SysWORDTempA_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd5
SysForLoop5
	movlw	2
	banksel	I_X
	addwf	I_X,F
	movlw	0
	addwfc	I_X_H,F
;I_value16_h = etherbuffer(i_x)
	movlw	low(ETHERBUFFER)
	addwf	I_X,W
	movwf	AFSR0
	movlw	high(ETHERBUFFER)
	addwfc	I_X_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	I_VALUE16_H
	movwf	I_VALUE16_H
;[byte]I_value16 = etherbuffer( i_x + 1 )
	movlw	low(ETHERBUFFER)
	banksel	I_X
	addwf	I_X,W
	movwf	SysTemp2
	movlw	high(ETHERBUFFER)
	addwfc	I_X_H,W
	movwf	SysTemp2_H
	movlw	1
	addwf	SysTemp2,W
	movwf	AFSR0
	movlw	0
	addwfc	SysTemp2_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	I_VALUE16
	movwf	I_VALUE16
;I_chksum32 = I_value16 + I_chksum32
	banksel	I_CHKSUM32
	movf	I_CHKSUM32,W
	banksel	I_VALUE16
	addwf	I_VALUE16,W
	banksel	I_CHKSUM32
	movwf	I_CHKSUM32
	movf	I_CHKSUM32_H,W
	banksel	I_VALUE16_H
	addwfc	I_VALUE16_H,W
	banksel	I_CHKSUM32_H
	movwf	I_CHKSUM32_H
	clrf	SysTemp3
	banksel	I_CHKSUM32_U
	movf	I_CHKSUM32_U,W
	banksel	SYSTEMP3
	addwfc	SysTemp3,W
	banksel	I_CHKSUM32_U
	movwf	I_CHKSUM32_U
	movlw	0
	banksel	SYSTEMP1
	movwf	SysTemp1
	movf	I_CHKSUM32_E,W
	addwfc	SysTemp1,W
	movwf	I_CHKSUM32_E
;Next
	movf	I_X,W
	movwf	SysWORDTempA
	movf	I_X_H,W
	movwf	SysWORDTempA_H
	banksel	HULP2
	movf	HULP2,W
	movwf	SysWORDTempB
	movf	HULP2_H,W
	movwf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop5
SysForLoopEnd5
;I_checksum16 = i_chksum32
	banksel	I_CHKSUM32
	movf	I_CHKSUM32,W
	banksel	I_CHECKSUM16
	movwf	I_CHECKSUM16
	banksel	I_CHKSUM32_H
	movf	I_CHKSUM32_H,W
	banksel	I_CHECKSUM16_H
	movwf	I_CHECKSUM16_H
;I_checksum16 = I_checksum16 + [byte]I_chksum32_u
	movf	I_CHKSUM32_U,W
	addwf	I_CHECKSUM16,F
	movlw	0
	addwfc	I_CHECKSUM16_H,F
;I_checksum16 = Not [word]I_checksum16
	comf	I_CHECKSUM16,F
	comf	I_CHECKSUM16_H,F
;[byte]tcp_cksum0 = I_checksum16_h
	movf	I_CHECKSUM16_H,W
	banksel	SYSETHERBUFFER_51
	movwf	SYSETHERBUFFER_51
;[byte]tcp_cksum1 = I_checksum16
	banksel	I_CHECKSUM16
	movf	I_CHECKSUM16,W
	banksel	SYSETHERBUFFER_52
	movwf	SYSETHERBUFFER_52
	banksel	STATUS
	return

;********************************************************************************

INITUSART
;comport = 1
	movlw	1
	movwf	COMPORT
;SPBRG = SPBRGL_TEMP
	movlw	68
	banksel	SPBRG
	movwf	SPBRG
;SPBRGH = SPBRGH_TEMP
	clrf	SPBRGH
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
;PIC USART 2 Init
	banksel	STATUS
	return

;********************************************************************************

IVALID1
	movf	SYSSTRINGA,W
	movwf	SysWORDTempA
	movf	SYSSTRINGA_H,W
	movwf	SysWORDTempA_H
	movlw	36
	movwf	SysWORDTempB
	movlw	5
	movwf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	retlw	0
	movf	SysStringA, W
	addlw	low TableIVALID1
	movwf	SysStringA
	movlw	(high TableIVALID1) & 127
	btfsc	STATUS, C
	addlw	1
	addwf	SysStringA_H, W
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableIVALID1
	retlw	35
	retlw	60
	retlw	33
	retlw	68
	retlw	79
	retlw	67
	retlw	84
	retlw	89
	retlw	80
	retlw	69
	retlw	32
	retlw	104
	retlw	116
	retlw	109
	retlw	108
	retlw	32
	retlw	80
	retlw	85
	retlw	66
	retlw	76
	retlw	73
	retlw	67
	retlw	32
	retlw	34
	retlw	45
	retlw	47
	retlw	47
	retlw	87
	retlw	51
	retlw	67
	retlw	47
	retlw	47
	retlw	68
	retlw	84
	retlw	68
	retlw	32
	retlw	72
	retlw	84
	retlw	77
	retlw	76
	retlw	32
	retlw	52
	retlw	46
	retlw	48
	retlw	49
	retlw	32
	retlw	84
	retlw	114
	retlw	97
	retlw	110
	retlw	115
	retlw	105
	retlw	116
	retlw	105
	retlw	111
	retlw	110
	retlw	97
	retlw	108
	retlw	47
	retlw	47
	retlw	69
	retlw	78
	retlw	34
	retlw	62
	retlw	60
	retlw	104
	retlw	116
	retlw	109
	retlw	108
	retlw	62
	retlw	60
	retlw	104
	retlw	101
	retlw	97
	retlw	100
	retlw	62
	retlw	60
	retlw	116
	retlw	105
	retlw	116
	retlw	108
	retlw	101
	retlw	62
	retlw	60
	retlw	47
	retlw	116
	retlw	105
	retlw	116
	retlw	108
	retlw	101
	retlw	62
	retlw	60
	retlw	115
	retlw	116
	retlw	121
	retlw	108
	retlw	101
	retlw	32
	retlw	116
	retlw	121
	retlw	112
	retlw	101
	retlw	61
	retlw	34
	retlw	116
	retlw	101
	retlw	120
	retlw	116
	retlw	47
	retlw	99
	retlw	115
	retlw	115
	retlw	34
	retlw	62
	retlw	115
	retlw	112
	retlw	97
	retlw	110
	retlw	46
	retlw	99
	retlw	55
	retlw	32
	retlw	123
	retlw	102
	retlw	111
	retlw	110
	retlw	116
	retlw	45
	retlw	102
	retlw	97
	retlw	109
	retlw	105
	retlw	108
	retlw	121
	retlw	58
	retlw	32
	retlw	104
	retlw	101
	retlw	108
	retlw	118
	retlw	101
	retlw	116
	retlw	105
	retlw	99
	retlw	97
	retlw	125
	retlw	115
	retlw	112
	retlw	97
	retlw	110
	retlw	46
	retlw	99
	retlw	54
	retlw	32
	retlw	123
	retlw	102
	retlw	111
	retlw	110
	retlw	116
	retlw	45
	retlw	115
	retlw	105
	retlw	122
	retlw	101
	retlw	58
	retlw	32
	retlw	55
	retlw	48
	retlw	37
	retlw	125
	retlw	105
	retlw	109
	retlw	103
	retlw	46
	retlw	99
	retlw	53
	retlw	32
	retlw	123
	retlw	102
	retlw	108
	retlw	111
	retlw	97
	retlw	116
	retlw	58
	retlw	32
	retlw	114
	retlw	105
	retlw	103
	retlw	104
	retlw	116
	retlw	59
	retlw	125
	retlw	100
	retlw	105
	retlw	118
	retlw	46
	retlw	99
	retlw	52
	retlw	32
	retlw	123
	retlw	116
	retlw	101
	retlw	120
	retlw	116
	retlw	45
	retlw	97
	retlw	108
	retlw	105
	retlw	103
	retlw	110
	retlw	58
	retlw	32
	retlw	99
	retlw	101
	retlw	110
	retlw	116
	retlw	101
	retlw	114
	retlw	125
	retlw	112
	retlw	46
	retlw	99
	retlw	51
	retlw	32
	retlw	123
	retlw	102
	retlw	111
	retlw	110
	retlw	116
	retlw	45
	retlw	102
	retlw	97
	retlw	109
	retlw	105
	retlw	108
	retlw	121
	retlw	58
	retlw	32
	retlw	104
	retlw	101
	retlw	108
	retlw	118
	retlw	101
	retlw	116
	retlw	105
	retlw	99
	retlw	97
	retlw	125
	retlw	115
	retlw	116
	retlw	114
	retlw	111
	retlw	110
	retlw	103
	retlw	46
	retlw	99
	retlw	50
	retlw	32
	retlw	123
	retlw	116
	retlw	101
	retlw	120
	retlw	116
	retlw	45
	retlw	100
	retlw	101
	retlw	99
	retlw	111
	retlw	114
	retlw	97
	retlw	116
	retlw	105
	retlw	111
	retlw	110
	retlw	58
	retlw	32
	retlw	117
	retlw	110
	retlw	100
	retlw	101
	retlw	114
	retlw	108
	retlw	105
	retlw	110
	retlw	101
	retlw	125
	retlw	115
	retlw	112
	retlw	97
	retlw	110
	retlw	46
	retlw	99
	retlw	49
	retlw	32
	retlw	123
	retlw	99
	retlw	111
	retlw	108
	retlw	111
	retlw	114
	retlw	58
	retlw	32
	retlw	35
	retlw	48
	retlw	48
	retlw	48
	retlw	48
	retlw	70
	retlw	70
	retlw	59
	retlw	32
	retlw	102
	retlw	111
	retlw	110
	retlw	116
	retlw	45
	retlw	115
	retlw	105
	retlw	122
	retlw	101
	retlw	58
	retlw	32
	retlw	49
	retlw	53
	retlw	48
	retlw	37
	retlw	125
	retlw	60
	retlw	47
	retlw	115
	retlw	116
	retlw	121
	retlw	108
	retlw	101
	retlw	62
	retlw	60
	retlw	47
	retlw	104
	retlw	101
	retlw	97
	retlw	100
	retlw	62
	retlw	60
	retlw	98
	retlw	111
	retlw	100
	retlw	121
	retlw	62
	retlw	60
	retlw	100
	retlw	105
	retlw	118
	retlw	32
	retlw	99
	retlw	108
	retlw	97
	retlw	115
	retlw	115
	retlw	61
	retlw	34
	retlw	99
	retlw	52
	retlw	34
	retlw	62
	retlw	60
	retlw	112
	retlw	32
	retlw	99
	retlw	108
	retlw	97
	retlw	115
	retlw	115
	retlw	61
	retlw	34
	retlw	99
	retlw	51
	retlw	34
	retlw	62
	retlw	60
	retlw	97
	retlw	32
	retlw	116
	retlw	97
	retlw	114
	retlw	103
	retlw	101
	retlw	116
	retlw	61
	retlw	34
	retlw	95
	retlw	98
	retlw	108
	retlw	97
	retlw	110
	retlw	107
	retlw	34
	retlw	32
	retlw	104
	retlw	114
	retlw	101
	retlw	102
	retlw	61
	retlw	34
	retlw	104
	retlw	116
	retlw	116
	retlw	112
	retlw	58
	retlw	47
	retlw	47
	retlw	115
	retlw	111
	retlw	117
	retlw	114
	retlw	99
	retlw	101
	retlw	102
	retlw	111
	retlw	114
	retlw	103
	retlw	101
	retlw	46
	retlw	110
	retlw	101
	retlw	116
	retlw	47
	retlw	112
	retlw	47
	retlw	103
	retlw	99
	retlw	98
	retlw	97
	retlw	115
	retlw	105
	retlw	99
	retlw	34
	retlw	62
	retlw	60
	retlw	115
	retlw	116
	retlw	114
	retlw	111
	retlw	110
	retlw	103
	retlw	32
	retlw	99
	retlw	108
	retlw	97
	retlw	115
	retlw	115
	retlw	61
	retlw	34
	retlw	99
	retlw	50
	retlw	34
	retlw	62
	retlw	60
	retlw	115
	retlw	112
	retlw	97
	retlw	110
	retlw	32
	retlw	99
	retlw	108
	retlw	97
	retlw	115
	retlw	115
	retlw	61
	retlw	34
	retlw	99
	retlw	49
	retlw	34
	retlw	62
	retlw	71
	retlw	114
	retlw	101
	retlw	97
	retlw	116
	retlw	32
	retlw	67
	retlw	111
	retlw	119
	retlw	32
	retlw	66
	retlw	65
	retlw	83
	retlw	73
	retlw	67
	retlw	32
	retlw	84
	retlw	67
	retlw	80
	retlw	47
	retlw	73
	retlw	80
	retlw	32
	retlw	83
	retlw	116
	retlw	97
	retlw	99
	retlw	107
	retlw	60
	retlw	47
	retlw	115
	retlw	112
	retlw	97
	retlw	110
	retlw	62
	retlw	60
	retlw	47
	retlw	115
	retlw	116
	retlw	114
	retlw	111
	retlw	110
	retlw	103
	retlw	62
	retlw	60
	retlw	47
	retlw	97
	retlw	62
	retlw	60
	retlw	47
	retlw	112
	retlw	62
	retlw	60
	retlw	47
	retlw	100
	retlw	105
	retlw	118
	retlw	62
	retlw	60
	retlw	115
	retlw	112
	retlw	97
	retlw	110
	retlw	32
	retlw	111
	retlw	110
	retlw	99
	retlw	108
	retlw	105
	retlw	99
	retlw	107
	retlw	61
	retlw	34
	retlw	116
	retlw	104
	retlw	105
	retlw	115
	retlw	46
	retlw	115
	retlw	116
	retlw	121
	retlw	108
	retlw	101
	retlw	46
	retlw	99
	retlw	111
	retlw	108
	retlw	111
	retlw	114
	retlw	32
	retlw	61
	retlw	32
	retlw	39
	retlw	98
	retlw	108
	retlw	117
	retlw	101
	retlw	39
	retlw	34
	retlw	32
	retlw	99
	retlw	108
	retlw	97
	retlw	115
	retlw	115
	retlw	61
	retlw	34
	retlw	99
	retlw	55
	retlw	34
	retlw	62
	retlw	60
	retlw	98
	retlw	114
	retlw	62
	retlw	60
	retlw	98
	retlw	114
	retlw	62
	retlw	84
	retlw	104
	retlw	105
	retlw	115
	retlw	32
	retlw	112
	retlw	97
	retlw	103
	retlw	101
	retlw	32
	retlw	105
	retlw	115
	retlw	32
	retlw	115
	retlw	101
	retlw	114
	retlw	118
	retlw	101
	retlw	100
	retlw	32
	retlw	98
	retlw	121
	retlw	32
	retlw	97
	retlw	32
	retlw	71
	retlw	67
	retlw	66
	retlw	32
	retlw	72
	retlw	84
	retlw	84
	retlw	80
	retlw	32
	retlw	181
	retlw	83
	retlw	101
	retlw	114
	retlw	118
	retlw	101
	retlw	114
	retlw	46
	retlw	48
	retlw	51
	retlw	52
	retlw	32
	retlw	102
	retlw	114
	retlw	111
	retlw	109
	retlw	32
	retlw	97
	retlw	32
	retlw	49
	retlw	54
	retlw	70
	retlw	49
	retlw	56
	retlw	56
	retlw	53
	retlw	53
	retlw	32
	retlw	77
	retlw	105
	retlw	99
	retlw	114
	retlw	111
	retlw	99
	retlw	104
	retlw	105
	retlw	112
	retlw	32
	retlw	109
	retlw	105
	retlw	99
	retlw	114
	retlw	111
	retlw	99
	retlw	111
	retlw	110
	retlw	116
	retlw	114
	retlw	111
	retlw	108
	retlw	108
	retlw	101
	retlw	114
	retlw	32
	retlw	117
	retlw	115
	retlw	105
	retlw	110
	retlw	103
	retlw	32
	retlw	97
	retlw	110
	retlw	32
	retlw	69
	retlw	78
	retlw	67
	retlw	50
	retlw	56
	retlw	74
	retlw	54
	retlw	48
	retlw	32
	retlw	69
	retlw	116
	retlw	104
	retlw	101
	retlw	114
	retlw	110
	retlw	101
	retlw	116
	retlw	32
	retlw	99
	retlw	111
	retlw	110
	retlw	116
	retlw	114
	retlw	111
	retlw	108
	retlw	108
	retlw	101
	retlw	114
	retlw	46
	retlw	60
	retlw	98
	retlw	114
	retlw	62
	retlw	60
	retlw	98
	retlw	114
	retlw	62
	retlw	84
	retlw	104
	retlw	105
	retlw	115
	retlw	32
	retlw	112
	retlw	97
	retlw	103
	retlw	101
	retlw	32
	retlw	111
	retlw	102
	retlw	32
	retlw	72
	retlw	84
	retlw	77
	retlw	76
	retlw	32
	retlw	105
	retlw	116
	retlw	32
	retlw	105
	retlw	115
	retlw	32
	retlw	98
	retlw	101
	retlw	105
	retlw	110
	retlw	103
	retlw	32
	retlw	112
	retlw	114
	retlw	111
	retlw	99
	retlw	101
	retlw	115
	retlw	115
	retlw	101
	retlw	100
	retlw	32
	retlw	97
	retlw	115
	retlw	32
	retlw	109
	retlw	117
	retlw	108
	retlw	116
	retlw	105
	retlw	112
	retlw	108
	retlw	101
	retlw	32
	retlw	84
	retlw	67
	retlw	80
	retlw	32
	retlw	72
	retlw	84
	retlw	77
	retlw	76
	retlw	32
	retlw	112
	retlw	97
	retlw	99
	retlw	107
	retlw	101
	retlw	116
	retlw	115
	retlw	44
	retlw	32
	retlw	97
	retlw	115
	retlw	32
	retlw	116
	retlw	104
	retlw	101
	retlw	32
	retlw	72
	retlw	84
	retlw	77
	retlw	76
	retlw	32
	retlw	101
	retlw	120
	retlw	99
	retlw	101
	retlw	101
	retlw	100
	retlw	115
	retlw	32
	retlw	116
	retlw	104
	retlw	101
	retlw	32
	retlw	32
	retlw	109
	retlw	101
	retlw	109
	retlw	111
	retlw	114
	retlw	121
	retlw	32
	retlw	98
	retlw	117
	retlw	102
	retlw	102
	retlw	101
	retlw	114
	retlw	46
	retlw	32
	retlw	84
	retlw	104
	retlw	101
	retlw	32
	retlw	109
	retlw	101
	retlw	109
	retlw	111
	retlw	114
	retlw	121
	retlw	32
	retlw	98
	retlw	117
	retlw	102
	retlw	102
	retlw	101
	retlw	114
	retlw	32
	retlw	105
	retlw	115
	retlw	32
	retlw	54
	retlw	48
	retlw	48
	retlw	32
	retlw	98
	retlw	121
	retlw	116
	retlw	101
	retlw	115
	retlw	32
	retlw	97
	retlw	110
	retlw	100
	retlw	32
	retlw	116
	retlw	104
	retlw	101
	retlw	32
	retlw	72
	retlw	84
	retlw	77
	retlw	76
	retlw	32
	retlw	105
	retlw	115
	retlw	32
	retlw	111
	retlw	118
	retlw	101
	retlw	114
	retlw	32
	retlw	49
	retlw	50
	retlw	48
	retlw	48
	retlw	32
	retlw	98
	retlw	121
	retlw	116
	retlw	101
	retlw	115
	retlw	46
	retlw	32
	retlw	83
	retlw	111
	retlw	44
	retlw	32
	retlw	119
	retlw	101
	retlw	32
	retlw	109
	retlw	117
	retlw	115
	retlw	116
	retlw	32
	retlw	98
	retlw	101
	retlw	32
	retlw	112
	retlw	97
	retlw	115
	retlw	115
	retlw	105
	retlw	110
	retlw	103
	retlw	32
	retlw	109
	retlw	111
	retlw	114
	retlw	101
	retlw	32
	retlw	116
	retlw	104
	retlw	97
	retlw	110
	retlw	32
	retlw	111
	retlw	110
	retlw	101
	retlw	32
	retlw	84
	retlw	67
	retlw	80
	retlw	32
	retlw	112
	retlw	97
	retlw	99
	retlw	107
	retlw	101
	retlw	116
	retlw	32
	retlw	116
	retlw	111
	retlw	32
	retlw	99
	retlw	111
	retlw	110
	retlw	115
	retlw	116
	retlw	114
	retlw	117
	retlw	99
	retlw	116
	retlw	32
	retlw	116
	retlw	104
	retlw	101
	retlw	32
	retlw	72
	retlw	84
	retlw	77
	retlw	76
	retlw	32
	retlw	116
	retlw	114
	retlw	97
	retlw	110
	retlw	115
	retlw	97
	retlw	99
	retlw	116
	retlw	105
	retlw	111
	retlw	110
	retlw	46
	retlw	60
	retlw	98
	retlw	114
	retlw	62
	retlw	60
	retlw	98
	retlw	114
	retlw	62
	retlw	84
	retlw	104
	retlw	105
	retlw	115
	retlw	32
	retlw	112
	retlw	97
	retlw	103
	retlw	101
	retlw	32
	retlw	105
	retlw	115
	retlw	32
	retlw	104
	retlw	101
	retlw	108
	retlw	100
	retlw	32
	retlw	97
	retlw	115
	retlw	32
	retlw	97
	retlw	32
	retlw	116
	retlw	97
	retlw	98
	retlw	108
	retlw	101
	retlw	32
	retlw	119
	retlw	105
	retlw	116
	retlw	104
	retlw	105
	retlw	110
	retlw	32
	retlw	116
	retlw	104
	retlw	101
	retlw	32
	retlw	71
	retlw	114
	retlw	101
	retlw	97
	retlw	116
	retlw	32
	retlw	67
	retlw	111
	retlw	119
	retlw	32
	retlw	66
	retlw	65
	retlw	83
	retlw	73
	retlw	67
	retlw	32
	retlw	115
	retlw	111
	retlw	117
	retlw	114
	retlw	99
	retlw	101
	retlw	32
	retlw	102
	retlw	105
	retlw	108
	retlw	101
	retlw	32
	retlw	97
	retlw	115
	retlw	32
	retlw	116
	retlw	104
	retlw	105
	retlw	115
	retlw	32
	retlw	119
	retlw	105
	retlw	108
	retlw	108
	retlw	32
	retlw	98
	retlw	101
	retlw	32
	retlw	116
	retlw	104
	retlw	101
	retlw	32
	retlw	100
	retlw	101
	retlw	102
	retlw	97
	retlw	117
	retlw	108
	retlw	116
	retlw	32
	retlw	119
	retlw	101
	retlw	98
	retlw	32
	retlw	112
	retlw	97
	retlw	103
	retlw	101
	retlw	32
	retlw	109
	retlw	101
	retlw	116
	retlw	104
	retlw	111
	retlw	100
	retlw	46
	retlw	60
	retlw	98
	retlw	114
	retlw	62
	retlw	60
	retlw	98
	retlw	114
	retlw	62
	retlw	79
	retlw	112
	retlw	101
	retlw	114
	retlw	97
	retlw	116
	retlw	105
	retlw	110
	retlw	103
	retlw	32
	retlw	111
	retlw	110
	retlw	32
	retlw	100
	retlw	101
	retlw	118
	retlw	105
	retlw	99
	retlw	101
	retlw	95
	retlw	49
	retlw	57
	retlw	50
	retlw	95
	retlw	49
	retlw	54
	retlw	56
	retlw	95
	retlw	48
	retlw	95
	retlw	52
	retlw	60
	retlw	98
	retlw	114
	retlw	62
	retlw	60
	retlw	98
	retlw	114
	retlw	62
	retlw	60
	retlw	105
	retlw	109
	retlw	103
	retlw	32
	retlw	99
	retlw	108
	retlw	97
	retlw	115
	retlw	115
	retlw	61
	retlw	34
	retlw	99
	retlw	53
	retlw	34
	retlw	32
	retlw	115
	retlw	114
	retlw	99
	retlw	61
	retlw	34
	retlw	104
	retlw	116
	retlw	116
	retlw	112
	retlw	58
	retlw	47
	retlw	47
	retlw	103
	retlw	111
	retlw	111
	retlw	46
	retlw	103
	retlw	108
	retlw	47
	retlw	49
	retlw	86
	retlw	104
	retlw	56
	retlw	118
	retlw	77
	retlw	34
	retlw	32
	retlw	97
	retlw	108
	retlw	116
	retlw	61
	retlw	34
	retlw	65
	retlw	110
	retlw	111
	retlw	98
	retlw	105
	retlw	117
	retlw	109
	retlw	39
	retlw	115
	retlw	32
	retlw	76
	retlw	111
	retlw	103
	retlw	111
	retlw	34
	retlw	62
	retlw	60
	retlw	98
	retlw	114
	retlw	62
	retlw	60
	retlw	98
	retlw	114
	retlw	62
	retlw	60
	retlw	115
	retlw	112
	retlw	97
	retlw	110
	retlw	32
	retlw	111
	retlw	110
	retlw	99
	retlw	108
	retlw	105
	retlw	99
	retlw	107
	retlw	61
	retlw	34
	retlw	116
	retlw	104
	retlw	105
	retlw	115
	retlw	46
	retlw	115
	retlw	116
	retlw	121
	retlw	108
	retlw	101
	retlw	46
	retlw	99
	retlw	111
	retlw	108
	retlw	111
	retlw	114
	retlw	32
	retlw	61
	retlw	32
	retlw	39
	retlw	114
	retlw	101
	retlw	100
	retlw	39
	retlw	34
	retlw	32
	retlw	99
	retlw	108
	retlw	97
	retlw	115
	retlw	115
	retlw	61
	retlw	34
	retlw	99
	retlw	54
	retlw	34
	retlw	62
	retlw	64
	retlw	82
	retlw	101
	retlw	108
	retlw	32
	retlw	48
	retlw	51
	retlw	52
	retlw	46
	retlw	48
	retlw	49
	retlw	60
	retlw	98
	retlw	114
	retlw	62
	retlw	60
	retlw	47
	retlw	115
	retlw	112
	retlw	97
	retlw	110
	retlw	62
	retlw	60
	retlw	47
	retlw	115
	retlw	112
	retlw	97
	retlw	110
	retlw	62
	retlw	60
	retlw	47
	retlw	98
	retlw	111
	retlw	100
	retlw	121
	retlw	62
	retlw	60
	retlw	47
	retlw	104
	retlw	116
	retlw	109
	retlw	108
	retlw	62

;********************************************************************************

;Start of program memory page 1
	ORG	2048
ENC28J60_HTTP
;Dim Tcp_fin As Bit
;Dim Tcp_syn As Bit
;Dim Tcp_rst As Bit
;Dim Tcp_psh As Bit
;Dim Tcp_ack As Bit
;Dim Tcp_urg As Bit
;Dim Tcpdatalen_in As Word
;Dim Tcpdatalen_out As Word
;Dim Expected_ack As Long
;Dim Flags As Byte
;Dim Client_seqnum As Long
;Dim Msg_temp2 As String * 10
;dim Tempword3 As Word
;dim Tempstring1 As String * 1
;Dim Ackpsh As Byte
;Work = Tcp_flags   'in the TCP Buffer, see aliases
	banksel	SYSETHERBUFFER_48
	movf	SYSETHERBUFFER_48,W
	banksel	WORK
	movwf	WORK
;Tcp_fin = Work.0
	bcf	SYSBITVAR0,1
	btfsc	WORK,0
	bsf	SYSBITVAR0,1
;Tcp_syn = Work.1
	bcf	SYSBITVAR0,2
	btfsc	WORK,1
	bsf	SYSBITVAR0,2
;Tcp_rst = Work.2
	bcf	SYSBITVAR0,3
	btfsc	WORK,2
	bsf	SYSBITVAR0,3
;Tcp_psh = Work.3
	bcf	SYSBITVAR0,4
	btfsc	WORK,3
	bsf	SYSBITVAR0,4
;Tcp_ack = Work.4
	bcf	SYSBITVAR0,5
	btfsc	WORK,4
	bsf	SYSBITVAR0,5
;Tcp_urg = Work.5
	bcf	SYSBITVAR0,6
	btfsc	WORK,5
	bsf	SYSBITVAR0,6
HTTPPART1
;If Tcp_syn = 1 and Tcp_fin = 0 Then
	clrf	SysByteTempX
	btfsc	SYSBITVAR0,2
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	movwf	SysTemp2
	clrf	SysByteTempX
	btfss	SYSBITVAR0,1
	comf	SysByteTempX,F
	movf	SysTemp2,W
	andwf	SysByteTempX,W
	movwf	SysTemp3
	btfss	SysTemp3,0
	goto	ENDIF51
;ENC28j60_set_response_IPpacket
	banksel	STATUS
	pagesel	ENC28J60_SET_RESPONSE_IPPACKET
	call	ENC28J60_SET_RESPONSE_IPPACKET
	pagesel	$
;T_ip_destaddr0 = T_ip_srcaddr0
;T_ip_destaddr1 = T_ip_srcaddr1
;T_ip_destaddr2 = T_ip_srcaddr2
;T_ip_destaddr3 = T_ip_srcaddr3
;
;'Set source IP in IP header, pos 27
;T_ip_srcaddr0 = ipaddr(1)
;T_ip_srcaddr1 = ipaddr(2)
;T_ip_srcaddr2 = ipaddr(3)
;T_ip_srcaddr3 = ipaddr(4)
;
;ENC28j60_packetshape
;ENC28j60_ip_header_checksum
;Swap Tcp_srcportl , Tcp_destportl
	banksel	SYSETHERBUFFER_36
	movf	SYSETHERBUFFER_36,W
	movwf	SYSCALCTEMPA
	movf	SYSETHERBUFFER_38,W
	movwf	SYSCALCTEMPB
	banksel	STATUS
	pagesel	SWAP98
	call	SWAP98
	pagesel	$
	movf	SYSCALCTEMPA,W
	banksel	SYSETHERBUFFER_36
	movwf	SYSETHERBUFFER_36
	movf	SYSCALCTEMPB,W
	movwf	SYSETHERBUFFER_38
;Swap Tcp_srcporth , Tcp_destporth
	movf	SYSETHERBUFFER_35,W
	movwf	SYSCALCTEMPA
	movf	SYSETHERBUFFER_37,W
	movwf	SYSCALCTEMPB
	banksel	STATUS
	pagesel	SWAP98
	call	SWAP98
	pagesel	$
	movf	SYSCALCTEMPA,W
	banksel	SYSETHERBUFFER_35
	movwf	SYSETHERBUFFER_35
	movf	SYSCALCTEMPB,W
	movwf	SYSETHERBUFFER_37
;Tcpdatalen_in = 1
	movlw	1
	banksel	TCPDATALEN_IN
	movwf	TCPDATALEN_IN
	clrf	TCPDATALEN_IN_H
;[byte]Client_seqnum_E = Tcp_seqnum3
	banksel	SYSETHERBUFFER_39
	movf	SYSETHERBUFFER_39,W
	banksel	CLIENT_SEQNUM_E
	movwf	CLIENT_SEQNUM_E
;[byte]Client_seqnum_U = Tcp_seqnum2
	banksel	SYSETHERBUFFER_40
	movf	SYSETHERBUFFER_40,W
	banksel	CLIENT_SEQNUM_U
	movwf	CLIENT_SEQNUM_U
;[byte]Client_seqnum_H = Tcp_seqnum1
	banksel	SYSETHERBUFFER_41
	movf	SYSETHERBUFFER_41,W
	banksel	CLIENT_SEQNUM_H
	movwf	CLIENT_SEQNUM_H
;[byte]Client_seqnum   = Tcp_seqnum0
	banksel	SYSETHERBUFFER_42
	movf	SYSETHERBUFFER_42,W
	banksel	CLIENT_SEQNUM
	movwf	CLIENT_SEQNUM
;Client_seqnum = Client_seqnum + Tcpdatalen_in
	banksel	TCPDATALEN_IN
	movf	TCPDATALEN_IN,W
	banksel	CLIENT_SEQNUM
	addwf	CLIENT_SEQNUM,F
	banksel	TCPDATALEN_IN_H
	movf	TCPDATALEN_IN_H,W
	banksel	CLIENT_SEQNUM_H
	addwfc	CLIENT_SEQNUM_H,F
	movlw	0
	addwfc	CLIENT_SEQNUM_U,F
	movlw	0
	addwfc	CLIENT_SEQNUM_E,F
;Tcp_acknum0 = Client_seqnum
	movf	CLIENT_SEQNUM,W
	banksel	SYSETHERBUFFER_46
	movwf	SYSETHERBUFFER_46
;Tcp_acknum1 = Client_seqnum_H
	banksel	CLIENT_SEQNUM_H
	movf	CLIENT_SEQNUM_H,W
	banksel	SYSETHERBUFFER_45
	movwf	SYSETHERBUFFER_45
;Tcp_acknum2 = Client_seqnum_U
	banksel	CLIENT_SEQNUM_U
	movf	CLIENT_SEQNUM_U,W
	banksel	SYSETHERBUFFER_44
	movwf	SYSETHERBUFFER_44
;Tcp_acknum3 = Client_seqnum_E
	banksel	CLIENT_SEQNUM_E
	movf	CLIENT_SEQNUM_E,W
	banksel	SYSETHERBUFFER_43
	movwf	SYSETHERBUFFER_43
;Tcp_seqnum0 = 0xFF                                 'Initial sequencenumber
	movlw	255
	movwf	SYSETHERBUFFER_42
;Tcp_seqnum1 = 0xFF                                 '
	movlw	255
	movwf	SYSETHERBUFFER_41
;Tcp_seqnum2 = 0x10                                 '
	movlw	16
	movwf	SYSETHERBUFFER_40
;Tcp_seqnum3 = 0x11                                 '
	movlw	17
	movwf	SYSETHERBUFFER_39
;Flags.synflag = 1
	banksel	FLAGS
	bsf	FLAGS,0
;Tcp_flags = 0
	banksel	SYSETHERBUFFER_48
	clrf	SYSETHERBUFFER_48
;Tcp_flags.1 = 1
	bsf	SYSETHERBUFFER_48,1
;Tcp_flags.4 = 1
	bsf	SYSETHERBUFFER_48,4
;etherbuffer(49) = 0X20
	movlw	32
	movwf	SYSETHERBUFFER_49
;etherbuffer(50) = 0X00
	clrf	SYSETHERBUFFER_50
;etherbuffer(60) = 01
	banksel	01
	movf	01,W
	banksel	SYSETHERBUFFER_60
	movwf	SYSETHERBUFFER_60
;etherbuffer(61) = 01
	banksel	01
	movf	01,W
	banksel	SYSETHERBUFFER_61
	movwf	SYSETHERBUFFER_61
;I_value16 = T_ip_vers_len And 0x0F
	movlw	15
	banksel	SYSETHERBUFFER_15
	andwf	SYSETHERBUFFER_15,W
	banksel	I_VALUE16
	movwf	I_VALUE16
	clrf	I_VALUE16_H
;I_value16 = I_value16 * 4
	movf	I_VALUE16,W
	movwf	SysWORDTempA
	movf	I_VALUE16_H,W
	movwf	SysWORDTempA_H
	movlw	4
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysMultSub16
	call	SysMultSub16
	pagesel	$
	movf	SysWORDTempX,W
	movwf	I_VALUE16
	movf	SysWORDTempX_H,W
	movwf	I_VALUE16_H
;tt = (( T_ip_pktlen0 * 256 )+ T_ip_pktlen1 ) + 14
	banksel	SYSETHERBUFFER_17
	movf	SYSETHERBUFFER_17,W
	movwf	SysWORDTempA
	clrf	SysWORDTempA_H
	clrf	SysWORDTempB
	movlw	1
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysMultSub16
	call	SysMultSub16
	pagesel	$
	movf	SysWORDTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movf	SysWORDTempX_H,W
	movwf	SysTemp1_H
	banksel	SYSETHERBUFFER_18
	movf	SYSETHERBUFFER_18,W
	banksel	SYSTEMP1
	addwf	SysTemp1,W
	movwf	SysTemp2
	movlw	0
	addwfc	SysTemp1_H,W
	movwf	SysTemp2_H
	movlw	14
	addwf	SysTemp2,W
	movwf	TT
;ENC28j60_Ip_header_checksum
	banksel	STATUS
	pagesel	ENC28J60_IP_HEADER_CHECKSUM
	call	ENC28J60_IP_HEADER_CHECKSUM
;ENC28j60_tcp_checksum
	pagesel	ENC28J60_TCP_CHECKSUM
	call	ENC28J60_TCP_CHECKSUM
	pagesel	$
;ENC28j60_writebuffer(tt)
	banksel	TT
	movf	TT,W
	movwf	PCKTLEN
	clrf	PCKTLEN_H
	banksel	STATUS
	pagesel	ENC28J60_WRITEBUFFER
	call	ENC28J60_WRITEBUFFER
	pagesel	$
;ENC28j60_packetsend(tt)
	banksel	TT
	movf	TT,W
	movwf	PCKTLEN
	clrf	PCKTLEN_H
	banksel	STATUS
	pagesel	ENC28J60_PACKETSEND
	call	ENC28J60_PACKETSEND
	pagesel	$
;Ackpsh = 0
	clrf	ACKPSH
;End If
ENDIF51
HTTPPART2
;' If an ACK and PSH is received and the destination port address is valid
;If Tcp_ack = 1 Then
	banksel	SYSBITVAR0
	btfss	SYSBITVAR0,5
	goto	ENDIF52
;if Tcp_fin = 0 then
	btfsc	SYSBITVAR0,1
	goto	ENDIF54
;T_ip_destaddr0 = T_ip_srcaddr0
	banksel	SYSETHERBUFFER_27
	movf	SYSETHERBUFFER_27,W
	movwf	SYSETHERBUFFER_31
;T_ip_destaddr1 = T_ip_srcaddr1
	movf	SYSETHERBUFFER_28,W
	movwf	SYSETHERBUFFER_32
;T_ip_destaddr2 = T_ip_srcaddr2
	movf	SYSETHERBUFFER_29,W
	movwf	SYSETHERBUFFER_33
;T_ip_destaddr3 = T_ip_srcaddr3
	movf	SYSETHERBUFFER_30,W
	movwf	SYSETHERBUFFER_34
;T_ip_srcaddr0 = ipaddr(1)
	banksel	SYSIPADDR_1
	movf	SYSIPADDR_1,W
	banksel	SYSETHERBUFFER_27
	movwf	SYSETHERBUFFER_27
;T_ip_srcaddr1 = ipaddr(2)
	banksel	SYSIPADDR_2
	movf	SYSIPADDR_2,W
	banksel	SYSETHERBUFFER_28
	movwf	SYSETHERBUFFER_28
;T_ip_srcaddr2 = ipaddr(3)
	banksel	SYSIPADDR_3
	movf	SYSIPADDR_3,W
	banksel	SYSETHERBUFFER_29
	movwf	SYSETHERBUFFER_29
;T_ip_srcaddr3 = ipaddr(4)
	banksel	SYSIPADDR_4
	movf	SYSIPADDR_4,W
	banksel	SYSETHERBUFFER_30
	movwf	SYSETHERBUFFER_30
;Swap Tcp_srcportl , Tcp_destportl
	movf	SYSETHERBUFFER_36,W
	movwf	SYSCALCTEMPA
	movf	SYSETHERBUFFER_38,W
	movwf	SYSCALCTEMPB
	banksel	STATUS
	pagesel	SWAP98
	call	SWAP98
	pagesel	$
	movf	SYSCALCTEMPA,W
	banksel	SYSETHERBUFFER_36
	movwf	SYSETHERBUFFER_36
	movf	SYSCALCTEMPB,W
	movwf	SYSETHERBUFFER_38
;Swap Tcp_srcporth , Tcp_destporth
	movf	SYSETHERBUFFER_35,W
	movwf	SYSCALCTEMPA
	movf	SYSETHERBUFFER_37,W
	movwf	SYSCALCTEMPB
	banksel	STATUS
	pagesel	SWAP98
	call	SWAP98
	pagesel	$
	movf	SYSCALCTEMPA,W
	banksel	SYSETHERBUFFER_35
	movwf	SYSETHERBUFFER_35
	movf	SYSCALCTEMPB,W
	movwf	SYSETHERBUFFER_37
;ENC28j60_Packetshape
	banksel	STATUS
	pagesel	ENC28J60_PACKETSHAPE
	call	ENC28J60_PACKETSHAPE
	pagesel	$
;[byte]Incoming_ack_E = Tcp_seqnum3
	banksel	SYSETHERBUFFER_39
	movf	SYSETHERBUFFER_39,W
	banksel	INCOMING_ACK_E
	movwf	INCOMING_ACK_E
;[byte]Incoming_ack_U = Tcp_seqnum2
	banksel	SYSETHERBUFFER_40
	movf	SYSETHERBUFFER_40,W
	banksel	INCOMING_ACK_U
	movwf	INCOMING_ACK_U
;[byte]Incoming_ack_H = Tcp_seqnum1
	banksel	SYSETHERBUFFER_41
	movf	SYSETHERBUFFER_41,W
	banksel	INCOMING_ACK_H
	movwf	INCOMING_ACK_H
;[byte]Incoming_ack   = Tcp_seqnum0
	banksel	SYSETHERBUFFER_42
	movf	SYSETHERBUFFER_42,W
	banksel	INCOMING_ACK
	movwf	INCOMING_ACK
;Incoming_ack = Incoming_ack + ((( T_ip_pktlen0 * 256 )+ T_ip_pktlen1 )) - 40         '489 - 14
	banksel	SYSETHERBUFFER_17
	movf	SYSETHERBUFFER_17,W
	movwf	SysWORDTempA
	clrf	SysWORDTempA_H
	clrf	SysWORDTempB
	movlw	1
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysMultSub16
	call	SysMultSub16
	pagesel	$
	movf	SysWORDTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movf	SysWORDTempX_H,W
	movwf	SysTemp1_H
	banksel	SYSETHERBUFFER_18
	movf	SYSETHERBUFFER_18,W
	banksel	SYSTEMP1
	addwf	SysTemp1,W
	movwf	SysTemp2
	movlw	0
	addwfc	SysTemp1_H,W
	movwf	SysTemp2_H
	movf	SysTemp2,W
	banksel	INCOMING_ACK
	addwf	INCOMING_ACK,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movf	SysTemp2_H,W
	banksel	INCOMING_ACK_H
	addwfc	INCOMING_ACK_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	movlw	0
	banksel	INCOMING_ACK_U
	addwfc	INCOMING_ACK_U,W
	banksel	SYSTEMP1_U
	movwf	SysTemp1_U
	movlw	0
	banksel	INCOMING_ACK_E
	addwfc	INCOMING_ACK_E,W
	banksel	SYSTEMP1_E
	movwf	SysTemp1_E
	movlw	40
	subwf	SysTemp1,W
	banksel	INCOMING_ACK
	movwf	INCOMING_ACK
	movlw	0
	banksel	SYSTEMP1_H
	subwfb	SysTemp1_H,W
	banksel	INCOMING_ACK_H
	movwf	INCOMING_ACK_H
	movlw	0
	banksel	SYSTEMP1_U
	subwfb	SysTemp1_U,W
	banksel	INCOMING_ACK_U
	movwf	INCOMING_ACK_U
	movlw	0
	banksel	SYSTEMP1_E
	subwfb	SysTemp1_E,W
	banksel	INCOMING_ACK_E
	movwf	INCOMING_ACK_E
;Tcp_seqnum0 = Tcp_acknum0
	banksel	SYSETHERBUFFER_46
	movf	SYSETHERBUFFER_46,W
	banksel	SYSETHERBUFFER_42
	movwf	SYSETHERBUFFER_42
;Tcp_seqnum1 = Tcp_acknum1
	banksel	SYSETHERBUFFER_45
	movf	SYSETHERBUFFER_45,W
	banksel	SYSETHERBUFFER_41
	movwf	SYSETHERBUFFER_41
;Tcp_seqnum2 = Tcp_acknum2
	movf	SYSETHERBUFFER_44,W
	movwf	SYSETHERBUFFER_40
;Tcp_seqnum3 = Tcp_acknum3
	movf	SYSETHERBUFFER_43,W
	movwf	SYSETHERBUFFER_39
;Tcp_acknum0 = Incoming_ack
	banksel	INCOMING_ACK
	movf	INCOMING_ACK,W
	banksel	SYSETHERBUFFER_46
	movwf	SYSETHERBUFFER_46
;Tcp_acknum1 = Incoming_ack_H
	banksel	INCOMING_ACK_H
	movf	INCOMING_ACK_H,W
	banksel	SYSETHERBUFFER_45
	movwf	SYSETHERBUFFER_45
;Tcp_acknum2 = Incoming_ack_U
	banksel	INCOMING_ACK_U
	movf	INCOMING_ACK_U,W
	banksel	SYSETHERBUFFER_44
	movwf	SYSETHERBUFFER_44
;Tcp_acknum3 = Incoming_ack_E
	banksel	INCOMING_ACK_E
	movf	INCOMING_ACK_E,W
	banksel	SYSETHERBUFFER_43
	movwf	SYSETHERBUFFER_43
;end if
ENDIF54
;If Tcp_psh = 1 Then
	banksel	SYSBITVAR0
	btfss	SYSBITVAR0,4
	goto	ENDIF55
;GET / HTTP/1.1
;HSerPrint T_ip_destaddr0
	banksel	SYSETHERBUFFER_31
	movf	SYSETHERBUFFER_31,W
	banksel	SERPRINTVAL
	movwf	SERPRINTVAL
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT260
	call	HSERPRINT260
	pagesel	$
;HSerPrint "."
	movlw	low StringTable49
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable49) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT259
	call	HSERPRINT259
	pagesel	$
;HSerPrint T_ip_destaddr1
	banksel	SYSETHERBUFFER_32
	movf	SYSETHERBUFFER_32,W
	banksel	SERPRINTVAL
	movwf	SERPRINTVAL
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT260
	call	HSERPRINT260
	pagesel	$
;HSerPrint "."
	movlw	low StringTable49
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable49) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT259
	call	HSERPRINT259
	pagesel	$
;HSerPrint T_ip_destaddr2
	banksel	SYSETHERBUFFER_33
	movf	SYSETHERBUFFER_33,W
	banksel	SERPRINTVAL
	movwf	SERPRINTVAL
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT260
	call	HSERPRINT260
	pagesel	$
;HSerPrint "."
	movlw	low StringTable49
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable49) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT259
	call	HSERPRINT259
	pagesel	$
;HSerPrint T_ip_destaddr3
	banksel	SYSETHERBUFFER_34
	movf	SYSETHERBUFFER_34,W
	banksel	SERPRINTVAL
	movwf	SERPRINTVAL
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT260
	call	HSERPRINT260
	pagesel	$
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$
;'ACK and PSH
;
;'set flags
;Tcp_flags = 0
	banksel	SYSETHERBUFFER_48
	clrf	SYSETHERBUFFER_48
;Tcp_flags.4 = 1                           'ack
	bsf	SYSETHERBUFFER_48,4
;
;'           'Move IP source address to destination address
;'           T_ip_destaddr = T_ip_srcaddr
;'           'Make ethernet module IP address source address
;'           T_ip_srcaddr = My_ip
;'           Swap Tcp_srcportl , Tcp_destportl
;'           Swap Tcp_srcporth , Tcp_destporth
;'Swap IP addresses
;
;T_ip_destaddr0 = T_ip_srcaddr0
;T_ip_destaddr1 = T_ip_srcaddr1
;T_ip_destaddr2 = T_ip_srcaddr2
;T_ip_destaddr3 = T_ip_srcaddr3
;
;'Set source IP in IP header, pos 27
;T_ip_srcaddr0 = ipaddr(1)
;T_ip_srcaddr1 = ipaddr(2)
;T_ip_srcaddr2 = ipaddr(3)
;T_ip_srcaddr3 = ipaddr(4)
;
;Swap Tcp_srcportl , Tcp_destportl
;Swap Tcp_srcporth , Tcp_destporth
;
;''           'swap mac
;ENC28j60_Packetshape
;
;
;[byte]Incoming_ack_E = Tcp_seqnum3
;[byte]Incoming_ack_U = Tcp_seqnum2
;[byte]Incoming_ack_H = Tcp_seqnum1
;[byte]Incoming_ack   = Tcp_seqnum0
;
;
;Incoming_ack = Incoming_ack + ((( T_ip_pktlen0 * 256 )+ T_ip_pktlen1 )) - 40         '489 - 14
;
;Tcp_seqnum0 = Tcp_acknum0
;Tcp_seqnum1 = Tcp_acknum1
;Tcp_seqnum2 = Tcp_acknum2
;Tcp_seqnum3 = Tcp_acknum3
;
;Tcp_acknum0 = Incoming_ack
;Tcp_acknum1 = Incoming_ack_H
;Tcp_acknum2 = Incoming_ack_U
;Tcp_acknum3 = Incoming_ack_E
;etherBuffer(17) = 0
	banksel	SYSETHERBUFFER_17
	clrf	SYSETHERBUFFER_17
;etherBuffer(18) = 40
	movlw	40
	movwf	SYSETHERBUFFER_18
;'5 x 4 = 20 bytes
;etherBuffer(47) = 0x50
	movlw	80
	banksel	SYSETHERBUFFER_47
	movwf	SYSETHERBUFFER_47
;'flag ACK
;etherBuffer(48) = 0x10
	movlw	16
	movwf	SYSETHERBUFFER_48
;etherbuffer(49) = 0X20
	movlw	32
	movwf	SYSETHERBUFFER_49
;etherbuffer(50) = 0X00
	clrf	SYSETHERBUFFER_50
;'padding
;etherBuffer(55) = 0x00
	clrf	SYSETHERBUFFER_55
;etherBuffer(56) = 0x00
	clrf	SYSETHERBUFFER_56
;etherBuffer(57) = 0x00
	clrf	SYSETHERBUFFER_57
;etherBuffer(58) = 0x00
	clrf	SYSETHERBUFFER_58
;etherBuffer(59) = 0x00
	clrf	SYSETHERBUFFER_59
;etherBuffer(60) = 0x00
	clrf	SYSETHERBUFFER_60
;ENC28j60_ip_header_checksum
	banksel	STATUS
	pagesel	ENC28J60_IP_HEADER_CHECKSUM
	call	ENC28J60_IP_HEADER_CHECKSUM
;ENC28j60_tcp_checksum
	pagesel	ENC28J60_TCP_CHECKSUM
	call	ENC28J60_TCP_CHECKSUM
	pagesel	$
;tt = (( T_ip_pktlen0 * 256 )+ T_ip_pktlen1 ) + 14
;T_ip_pktlen0 = 0
	banksel	SYSETHERBUFFER_17
	clrf	SYSETHERBUFFER_17
;T_ip_pktlen1 = 40
	movlw	40
	movwf	SYSETHERBUFFER_18
;ENC28j60_writebuffer(60)
	movlw	60
	banksel	PCKTLEN
	movwf	PCKTLEN
	clrf	PCKTLEN_H
	banksel	STATUS
	pagesel	ENC28J60_WRITEBUFFER
	call	ENC28J60_WRITEBUFFER
	pagesel	$
;ENC28j60_packetsend(60)
	movlw	60
	banksel	PCKTLEN
	movwf	PCKTLEN
	clrf	PCKTLEN_H
	banksel	STATUS
	pagesel	ENC28J60_PACKETSEND
	call	ENC28J60_PACKETSEND
	pagesel	$
;Ackpsh = 1
	movlw	1
	movwf	ACKPSH
;TableStartPoint = 1
	movlw	1
	banksel	TABLESTARTPOINT
	movwf	TABLESTARTPOINT
	clrf	TABLESTARTPOINT_H
;End If
ENDIF55
;End If
ENDIF52
;if Tcp_fin = 0  then
	btfsc	SYSBITVAR0,1
	goto	ELSE53_1
;HTTPPart3
	banksel	STATUS
	pagesel	HTTPPART3
	call	HTTPPART3
	pagesel	$
;Else
	goto	ENDIF53
ELSE53_1
;HTTPPart4
	banksel	STATUS
	pagesel	HTTPPART4
	call	HTTPPART4
	pagesel	$
;end if
ENDIF53
	return

;********************************************************************************

ENC28J60_INIT
;Dir ENC28j60_DI in
	bsf	TRISB,4
;Dir ENC28j60_DO Out
	bcf	TRISB,5
;Dir ENC28j60_SCK Out
	bcf	TRISB,3
;Dir ENC28j60_CS out
	bcf	TRISB,2
;Dir ENC28j60_RESET out
	bcf	TRISB,1
;set ENC28j60_DO off
	bcf	LATB,5
;set ENC28j60_SCK off
	bcf	LATB,3
;set ENC28j60_CS off
	bcf	LATB,2
;ENC28j60_Deselect
	bsf	LATB,2
;Repeat 5
	movlw	5
	banksel	SYSREPEATTEMP1
	movwf	SysRepeatTemp1
SysRepeatLoop1
;ENC28j60_Reset_CMD
	banksel	LATB
	bsf	LATB,1
	movlw	20
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
	bcf	LATB,1
	movlw	20
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
	bsf	LATB,1
	movlw	20
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;End Repeat
	banksel	SYSREPEATTEMP1
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop1
SysRepeatLoopEnd1
;ENC28j60_Select
	banksel	LATB
	bcf	LATB,2
;SPIMode MasterSlow, 0
	movlw	11
	banksel	SPICURRENTMODE
	movwf	SPICURRENTMODE
	clrf	SPICLOCKMODE
	banksel	STATUS
	pagesel	SPIMODE215
	call	SPIMODE215
	pagesel	$
;FastHWSPITransfer( ENC28j60_SOFT_RESET, temp )
	movlw	255
	banksel	SPITXDATA
	movwf	SPITXDATA
	banksel	STATUS
	pagesel	FASTHWSPITRANSFER
	call	FASTHWSPITRANSFER
	pagesel	$
;lastselectedBank = 99
	movlw	99
	banksel	LASTSELECTEDBANK
	movwf	LASTSELECTEDBANK
;wait while ( (ENC28j60_ReadReg( ESTAT ) & ESTAT_CLKRDY ) <> ESTAT_CLKRDY)
SysWaitLoop1
	movlw	29
	banksel	ADDR
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movlw	1
	andwf	ENC28J60_READREG,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movwf	SysBYTETempA
	movlw	1
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SysCompEqual
	call	SysCompEqual
	pagesel	$
	comf	SysByteTempX,F
	btfsc	SysByteTempX,0
	goto	SysWaitLoop1
;ENC28j60_writeReg(ECON1, 0xC0) 'Hold it in Reset
	movlw	31
	movwf	ADDR
	movlw	192
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(ECON2, 0x80) 'Set the AUTOINC bit
	movlw	30
	movwf	ADDR
	movlw	128
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(EIR, 0x00) 'Reset interrupt flags
	movlw	28
	movwf	ADDR
	clrf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(EIE,  0xC1)  'Interrupts: Packet reception and buffer errors
	movlw	27
	movwf	ADDR
	movlw	193
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(EWOLIE, 0x00)  'Disable wake-on-lan interrupts
	movlw	54
	movwf	ADDR
	clrf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(EWOLIR, 0x00)  'Clear wake-on-lan interrupt flags
	movlw	55
	movwf	ADDR
	clrf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(ETXSTL, ENC_TXBUF_STL)
	movlw	4
	movwf	ADDR
	movlw	112
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(ETXSTH, ENC_TXBUF_STH)
	movlw	5
	movwf	ADDR
	movlw	22
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(ETXNDL, ENC_TXBUF_NDL)
	movlw	6
	movwf	ADDR
	movlw	255
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(ETXNDH, ENC_TXBUF_NDH)  'TX Buffer : 1800 bytes
	movlw	7
	movwf	ADDR
	movlw	31
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(ERXSTL, ENC_RXBUF_STL)
	movlw	8
	movwf	ADDR
	clrf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(ERXSTH, ENC_RXBUF_STH)
	movlw	9
	movwf	ADDR
	clrf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(ERXNDL, ENC_RXBUF_NDL)
	movlw	10
	movwf	ADDR
	movlw	110
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(ERXNDH, ENC_RXBUF_NDH)  'RX Buffer : 6390 bytes
	movlw	11
	movwf	ADDR
	movlw	22
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(ERDPTL, ENC_RXBUF_STL)
	clrf	ADDR
	clrf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(ERDPTH, ENC_RXBUF_STH)
	movlw	1
	movwf	ADDR
	clrf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(ERXRDPTL, ENC_RXBUF_STL)
	movlw	12
	movwf	ADDR
	clrf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(ERXRDPTH, ENC_RXBUF_STH) 'RX Pointers (same)
	movlw	13
	movwf	ADDR
	clrf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;nextpacketptr = ENC_RXBUF_ST
	banksel	NEXTPACKETPTR
	clrf	NEXTPACKETPTR
	clrf	NEXTPACKETPTR_H
;ENC28j60_writeReg( ERXFCON, 0xA1) 'Receive unicasts or broadcasts
;For broadcast packets we allow only ARP packtets
;All other packets should be unicast only for our mac (MAADR)
;
;The pattern to match on is therefore
;Type     ETH.DST
;ARP      BROADCAST
;06 08 -- ff ff ff ff ff ff -> ip checksum for theses bytes=f7f9
;in binary these poitions are:11 0000 0011 1111
;This is hex 303F->EPMM0=0x3f,EPMM1=0x30
;ENC28j60_writeReg( EPMCSH, 0xf7)
;ENC28j60_writeReg( EPMCSL, 0xf9)
;ENC28j60_writeReg( EPMM0, 0x3f)
;ENC28j60_writeReg( EPMM1, 0x30)
;ENC28j60_bitClear( ERXFCON, ERXFCON_ANDOR ) 'Set filter bit
;
;Enc28j60_bitSet( ERXFCON, ERXFCON_UCEN ) 'Set filter bit
;
;ENC28j60_bitClear( ERXFCON, ERXFCON_CRCEN ) 'Set filter bit
;
;Enc28j60_bitSet( ERXFCON, ERXFCON_BCEN ) 'Set filter bit
;
;ENC28j60_bitClear( ERXFCON, ERXFCON_MPEN ) 'UnSet filter bit
;
;Enc28j60_bitSet( ERXFCON, ERXFCON_PMEN ) 'Set filter bit
;ENC28j60_writeReg( ERXFCON, ERXFCON_UCEN | ERXFCON_MCEN | ERXFCON_BCEN | ERXFCON_PMEN)
;Cannot get filter to Work, so use the folllowing
;ENC28j60_writeReg( ERXFCON, ERXFCON_CRCEN )
	movlw	56
	banksel	ADDR
	movwf	ADDR
	movlw	32
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(EFLOCON, 0x00) 'Disable flow control sending
	movlw	119
	movwf	ADDR
	clrf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(ECOCON, 0x00) 'Disable Clock Out pin
	movlw	117
	movwf	ADDR
	clrf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(EBSTCON, 0x00) 'Disable built-in self test controller
	movlw	103
	movwf	ADDR
	clrf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;wait while ( (ENC28j60_ReadReg(ESTAT) & ESTAT_CLKRDY) <> ESTAT_CLKRDY)
SysWaitLoop2
	movlw	29
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movlw	1
	andwf	ENC28J60_READREG,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movwf	SysBYTETempA
	movlw	1
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SysCompEqual
	call	SysCompEqual
	pagesel	$
	comf	SysByteTempX,F
	btfsc	SysByteTempX,0
	goto	SysWaitLoop2
;ENC28j60_writeReg(MISTAT, 0x00)  'Clear MII status register
	movlw	234
	movwf	ADDR
	clrf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(MICMD, 0x00)   'Clear MII command register
	movlw	210
	movwf	ADDR
	clrf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(MICON1, 0x02)  'Fast MII operation
;ENC28j60_writeReg(MICON2, 0x00)  'Release MII interface from reset
;ENC28j60_writeReg(MACON1, b'00001101' )  'Enable packet reception
	movlw	192
	movwf	ADDR
	movlw	13
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(MACON2, 0x00)  'Release the MAC subsystem from reset
;ENC28j60_writeReg(MACON3, 0xB1)  'Auto Pad + CRC + Full Duplex
;ENC28j60_writeReg(MACON3, 0x32)  'Auto Pad to 60 bytes + CRC + Half Duplex + Check frame length
	movlw	194
	movwf	ADDR
	movlw	50
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(MACON4, 0x01)  'Need valid preamble
	movlw	195
	movwf	ADDR
	movlw	1
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(MAPHSUP, b'00010000') 'Release MAC-PHY support from Reset
;ENC28j60_writeReg(MAMXFLL, 0xEE)
	movlw	202
	movwf	ADDR
	movlw	238
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(MAMXFLH, 0x05)  'Maximum frame length
	movlw	203
	movwf	ADDR
	movlw	5
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(MABBIPG, 0x12) 'IEEE BTB Inter Packet Gap
	movlw	196
	movwf	ADDR
	movlw	18
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(MAIPGL, 0x12)
	movlw	198
	movwf	ADDR
	movlw	18
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(MAIPGH, 0x0C)  'IEEE Non BTB Inter Packet Gap
	movlw	199
	movwf	ADDR
	movlw	12
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(MAADR0, macaddr(2))
	movlw	225
	movwf	ADDR
	movlw	2
	banksel	SYSMACADDRHANDLER
	addwf	SysMACADDRHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysMACADDRHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	ENC_OUTBYTE
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(MAADR1, macaddr(1))
	movlw	224
	movwf	ADDR
	movlw	1
	banksel	SYSMACADDRHANDLER
	addwf	SysMACADDRHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysMACADDRHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	ENC_OUTBYTE
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(MAADR2, macaddr(4))
	movlw	227
	movwf	ADDR
	movlw	4
	banksel	SYSMACADDRHANDLER
	addwf	SysMACADDRHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysMACADDRHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	ENC_OUTBYTE
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(MAADR3, macaddr(3))
	movlw	226
	movwf	ADDR
	movlw	3
	banksel	SYSMACADDRHANDLER
	addwf	SysMACADDRHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysMACADDRHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	ENC_OUTBYTE
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(MAADR4, macaddr(6))
	movlw	229
	movwf	ADDR
	movlw	6
	banksel	SYSMACADDRHANDLER
	addwf	SysMACADDRHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysMACADDRHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	ENC_OUTBYTE
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(MAADR5, macaddr(5))
	movlw	228
	movwf	ADDR
	movlw	5
	banksel	SYSMACADDRHANDLER
	addwf	SysMACADDRHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysMACADDRHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	ENC_OUTBYTE
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;'Initialize PHY subsystem
;ENC28j60_writePhyReg(PHCON1, 0x00, 0x00)  'Half duplex
	banksel	PHYREGADDR
	clrf	PHYREGADDR
	banksel	ENC_OUTBYTE1
	clrf	ENC_OUTBYTE1
	clrf	ENC_OUTBYTE2
	pagesel	ENC28J60_WRITEPHYREG
	call	ENC28J60_WRITEPHYREG
	pagesel	$
;ENC28j60_writePhyReg(PHCON2, 0x00, 0x00)
	movlw	16
	banksel	PHYREGADDR
	movwf	PHYREGADDR
	banksel	ENC_OUTBYTE1
	clrf	ENC_OUTBYTE1
	clrf	ENC_OUTBYTE2
	pagesel	ENC28J60_WRITEPHYREG
	call	ENC28J60_WRITEPHYREG
	pagesel	$
;ENC28j60_writePhyReg(PHLCON, B'00000100', B'01110110')
	movlw	20
	banksel	PHYREGADDR
	movwf	PHYREGADDR
	movlw	4
	banksel	ENC_OUTBYTE1
	movwf	ENC_OUTBYTE1
	movlw	118
	movwf	ENC_OUTBYTE2
	pagesel	ENC28J60_WRITEPHYREG
	call	ENC28J60_WRITEPHYREG
	pagesel	$
;ENC28j60_writePhyReg(PHIE, 0x00, 0x00)  'Disable interrupts
	movlw	18
	banksel	PHYREGADDR
	movwf	PHYREGADDR
	banksel	ENC_OUTBYTE1
	clrf	ENC_OUTBYTE1
	clrf	ENC_OUTBYTE2
	pagesel	ENC28J60_WRITEPHYREG
	call	ENC28J60_WRITEPHYREG
	pagesel	$
;ENC28j60_writeReg(ECON1, B'00010100')
	movlw	31
	movwf	ADDR
	movlw	20
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(ECON1, B'00000100')
;ENC28j60_writePhyReg ( PHLCON, 0xA2, 0x0A )
;wait 5 s
;ENC28j60_writePhyReg ( PHLCON, 0x76, 0x04 )
	movlw	20
	banksel	PHYREGADDR
	movwf	PHYREGADDR
	movlw	118
	banksel	ENC_OUTBYTE1
	movwf	ENC_OUTBYTE1
	movlw	4
	movwf	ENC_OUTBYTE2
	pagesel	ENC28J60_WRITEPHYREG
	goto	ENC28J60_WRITEPHYREG

;********************************************************************************

ENC28J60_PACKETRECEIVE
;Dim eth_counter, eth_frameLength As Word
;Dim previous_nextpacketptr as word
;ENC28j60_temp = ENC28j60_ReadReg (eir) and EIR_PKTIF
	movlw	28
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movlw	64
	andwf	ENC28J60_READREG,W
	movwf	ENC28J60_TEMP
;If ENC28j60_temp <> EIR_PKTIF Then
	movlw	64
	subwf	ENC28J60_TEMP,W
	btfsc	STATUS, Z
	goto	ENDIF21
;#ifdef ENC28j60_Hserial_Supported
;todo erv
;HSerPrint "No packet"
;reset
;#endif
;ENC28j60_bitSet( ECON2, ECON2_PKTDEC )
;goto Reset_ENC26j60
	goto	RESET_ENC26J60
;Exit Sub
	return
;End If
ENDIF21
;ENC28j60_data = ENC28j60_ReadReg( erevid )
	movlw	114
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;eth_counter = 1
	movlw	1
	movwf	ETH_COUNTER
	clrf	ETH_COUNTER_H
;do
SysDoLoop_S3
;HSerPrint "2"
;ENC28j60_writeReg(ERDPTL, [byte]nextpacketptr )
	banksel	ADDR
	clrf	ADDR
	banksel	NEXTPACKETPTR
	movf	NEXTPACKETPTR,W
	banksel	ENC_OUTBYTE
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(ERDPTH, nextpacketptr_h )
	movlw	1
	movwf	ADDR
	banksel	NEXTPACKETPTR_H
	movf	NEXTPACKETPTR_H,W
	banksel	ENC_OUTBYTE
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;eth_counter++
	incf	ETH_COUNTER,F
	btfsc	STATUS,Z
	incf	ETH_COUNTER_H,F
;if eth_counter = 0 then
	movf	ETH_COUNTER,W
	movwf	SysWORDTempA
	movf	ETH_COUNTER_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysCompEqual16
	btfsc	SysByteTempX,0
;HSerPrint "#1ERDPTL and ERDPTH error"
;HSerPrintCRLF
;exit do
	goto	SysDoLoop_E3
;end if
;loop while (ENC28j60_ReadReg(ERDPTL) <>  [byte]nextpacketptr) or (ENC28j60_ReadReg(ERDPTH) <> nextpacketptr_h )
	clrf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	banksel	SYSFNBYTE1
	movwf	SysFnBYTE1
	movlw	1
	banksel	ADDR
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	banksel	SYSFNBYTE1
	movf	sysfnbyte1,W
	movwf	SysBYTETempA
	movf	NEXTPACKETPTR,W
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SysCompEqual
	call	SysCompEqual
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	ENC28J60_READREG
	movf	enc28j60_readreg,W
	movwf	SysBYTETempA
	banksel	NEXTPACKETPTR_H
	movf	nextpacketptr_h,W
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SysCompEqual
	call	SysCompEqual
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movf	SysTemp1,W
	iorwf	SysTemp2,W
	movwf	SysTemp3
	btfsc	SysTemp3,0
	goto	SysDoLoop_S3
SysDoLoop_E3
;HSerPrint "4"
;ENC28j60_readbuffer(6)
	movlw	6
	banksel	ETHERGETLENGTH
	movwf	ETHERGETLENGTH
	clrf	ETHERGETLENGTH_H
	pagesel	ENC28J60_READBUFFER
	call	ENC28J60_READBUFFER
	pagesel	$
;HSerPrint "5"
;nextpacketptr = etherbuffer(1)
	banksel	SYSETHERBUFFER_1
	movf	SYSETHERBUFFER_1,W
	banksel	NEXTPACKETPTR
	movwf	NEXTPACKETPTR
	clrf	NEXTPACKETPTR_H
;nextpacketptr_h = etherbuffer(2)
	banksel	SYSETHERBUFFER_2
	movf	SYSETHERBUFFER_2,W
	banksel	NEXTPACKETPTR_H
	movwf	NEXTPACKETPTR_H
;eth_frameLength = etherbuffer(3)
	banksel	SYSETHERBUFFER_3
	movf	SYSETHERBUFFER_3,W
	banksel	ETH_FRAMELENGTH
	movwf	ETH_FRAMELENGTH
	clrf	ETH_FRAMELENGTH_H
;eth_frameLength_h = etherbuffer(4)
	banksel	SYSETHERBUFFER_4
	movf	SYSETHERBUFFER_4,W
	banksel	ETH_FRAMELENGTH_H
	movwf	ETH_FRAMELENGTH_H
;RxStat = etherbuffer(5)
	banksel	SYSETHERBUFFER_5
	movf	SYSETHERBUFFER_5,W
	banksel	RXSTAT
	movwf	RXSTAT
;RxStat_h = etherbuffer(6)
	banksel	SYSETHERBUFFER_6
	movf	SYSETHERBUFFER_6,W
	banksel	RXSTAT_H
	movwf	RXSTAT_H
;if ( etherbuffer(5) AND 0x80 ) = 0x80 then
;ENC28j60_readbuffer(eth_frameLength)
	banksel	ETH_FRAMELENGTH
	movf	ETH_FRAMELENGTH,W
	movwf	ETHERGETLENGTH
	movf	ETH_FRAMELENGTH_H,W
	movwf	ETHERGETLENGTH_H
	pagesel	ENC28J60_READBUFFER
	call	ENC28J60_READBUFFER
	pagesel	$
;end if
;HSerPrint "6"
ENDPACKET
;eth_counter = 1
	movlw	1
	movwf	ETH_COUNTER
	clrf	ETH_COUNTER_H
;do
SysDoLoop_S4
;ENC28j60_writeReg(ERDPTL, [byte]nextpacketptr )
	banksel	ADDR
	clrf	ADDR
	banksel	NEXTPACKETPTR
	movf	NEXTPACKETPTR,W
	banksel	ENC_OUTBYTE
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(ERDPTH, nextpacketptr_h )
	movlw	1
	movwf	ADDR
	banksel	NEXTPACKETPTR_H
	movf	NEXTPACKETPTR_H,W
	banksel	ENC_OUTBYTE
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;eth_counter++
	incf	ETH_COUNTER,F
	btfsc	STATUS,Z
	incf	ETH_COUNTER_H,F
;if eth_counter = 0 then
	movf	ETH_COUNTER,W
	movwf	SysWORDTempA
	movf	ETH_COUNTER_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysCompEqual16
	btfsc	SysByteTempX,0
;exit do
	goto	SysDoLoop_E4
;end if
;loop while (ENC28j60_ReadReg(ERDPTL) <>  [byte]nextpacketptr) or (ENC28j60_ReadReg(ERDPTH) <> nextpacketptr_h )
	clrf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	banksel	SYSFNBYTE1
	movwf	SysFnBYTE1
	movlw	1
	banksel	ADDR
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	banksel	SYSFNBYTE1
	movf	sysfnbyte1,W
	movwf	SysBYTETempA
	movf	NEXTPACKETPTR,W
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SysCompEqual
	call	SysCompEqual
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	ENC28J60_READREG
	movf	enc28j60_readreg,W
	movwf	SysBYTETempA
	banksel	NEXTPACKETPTR_H
	movf	nextpacketptr_h,W
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SysCompEqual
	call	SysCompEqual
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movf	SysTemp1,W
	iorwf	SysTemp2,W
	movwf	SysTemp3
	btfsc	SysTemp3,0
	goto	SysDoLoop_S4
SysDoLoop_E4
;'Packet is finished
;HSerPrint eth_counter
;HSerPrintCRLF
;IF ( nextpacketptr and 1 ) = 0 THEN
	movlw	1
	banksel	NEXTPACKETPTR
	andwf	NEXTPACKETPTR,W
	movwf	SysTemp1
	clrf	SysTemp1_H
	movf	SysTemp1,W
	movwf	SysWORDTempA
	movf	SysTemp1_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	call	SysCompEqual16
	btfss	SysByteTempX,0
	goto	ENDIF24
;eth_counter = nextpacketptr -1
	movlw	1
	banksel	NEXTPACKETPTR
	subwf	NEXTPACKETPTR,W
	banksel	ETH_COUNTER
	movwf	ETH_COUNTER
	movlw	0
	banksel	NEXTPACKETPTR_H
	subwfb	NEXTPACKETPTR_H,W
	banksel	ETH_COUNTER_H
	movwf	ETH_COUNTER_H
;END IF
ENDIF24
;ENC28j60_writeReg(ERXRDPTL, [byte]eth_counter )
	movlw	12
	movwf	ADDR
	movf	ETH_COUNTER,W
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg(ERXRDPTH, [byte]eth_counter_h )
	movlw	13
	movwf	ADDR
	movf	ETH_COUNTER_H,W
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_bitSet( ECON2, ECON2_PKTDEC )
	movlw	30
	movwf	ADDR
	movlw	64
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_BITSET
	call	ENC28J60_BITSET
	pagesel	$
;If etherBuffer(13) = 0X08 Then                               'TYPE: IP
	movlw	8
	banksel	SYSETHERBUFFER_13
	subwf	SYSETHERBUFFER_13,W
	btfss	STATUS, Z
	goto	ENDIF25
;If etherBuffer(14) = 0X06 Then                             'Type:ARP
	movlw	6
	subwf	SYSETHERBUFFER_14,W
	btfss	STATUS, Z
	goto	ENDIF26
;If etherBuffer(21) = 0X00 Then                          'ARP request
	movf	SYSETHERBUFFER_21,F
	btfss	STATUS, Z
	goto	ENDIF28
;If etherBuffer(22) = 0X01 Then                       'ARP request
	decf	SYSETHERBUFFER_22,W
	btfss	STATUS, Z
	goto	ENDIF30
;If etherBuffer(39) = ipaddr(1) Then                  'ARP for us
	banksel	SYSIPADDR_1
	movf	SYSIPADDR_1,W
	banksel	SYSETHERBUFFER_39
	subwf	SYSETHERBUFFER_39,W
	btfss	STATUS, Z
	goto	ENDIF32
;If etherBuffer(40) = ipaddr(2) Then
	banksel	SYSIPADDR_2
	movf	SYSIPADDR_2,W
	banksel	SYSETHERBUFFER_40
	subwf	SYSETHERBUFFER_40,W
	btfss	STATUS, Z
	goto	ENDIF34
;If etherBuffer(41) = ipaddr(3) Then
	banksel	SYSIPADDR_3
	movf	SYSIPADDR_3,W
	banksel	SYSETHERBUFFER_41
	subwf	SYSETHERBUFFER_41,W
	btfss	STATUS, Z
	goto	ENDIF36
;If etherBuffer(42) = ipaddr(4) Then
	banksel	SYSIPADDR_4
	movf	SYSIPADDR_4,W
	banksel	SYSETHERBUFFER_42
	subwf	SYSETHERBUFFER_42,W
	btfss	STATUS, Z
	goto	ENDIF38
;ENC28j60_Arpreply
	banksel	STATUS
	pagesel	ENC28J60_ARPREPLY
	call	ENC28J60_ARPREPLY
	pagesel	$
;End If
ENDIF38
;End If
ENDIF36
;End If
ENDIF34
;End If
ENDIF32
;End If
ENDIF30
;End If
ENDIF28
;End If
ENDIF26
;If etherBuffer(14) = 0X00 Then                             'Type:IP
	banksel	SYSETHERBUFFER_14
	movf	SYSETHERBUFFER_14,F
	btfss	STATUS, Z
	goto	ENDIF27
;If etherBuffer(15) = 0X45 Then                          'We handle only simple IP packets
	movlw	69
	subwf	SYSETHERBUFFER_15,W
	btfss	STATUS, Z
	goto	ENDIF29
;If etherBuffer(21) = 0 or etherBuffer(21) = 0x40 Then                          'We handle only non fragmented packets
	movf	SYSETHERBUFFER_21,W
	movwf	SysBYTETempA
	clrf	SysBYTETempB
	banksel	STATUS
	pagesel	SysCompEqual
	call	SysCompEqual
	pagesel	$
	movf	SysByteTempX,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	banksel	SYSETHERBUFFER_21
	movf	SYSETHERBUFFER_21,W
	movwf	SysBYTETempA
	movlw	64
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SysCompEqual
	call	SysCompEqual
	pagesel	$
	banksel	SYSTEMP2
	movf	SysTemp2,W
	iorwf	SysByteTempX,W
	movwf	SysTemp3
	btfss	SysTemp3,0
	goto	ENDIF31
;If etherBuffer(31) = ipaddr(1) Then                  'Ip packet for us
	banksel	SYSIPADDR_1
	movf	SYSIPADDR_1,W
	banksel	SYSETHERBUFFER_31
	subwf	SYSETHERBUFFER_31,W
	btfss	STATUS, Z
	goto	ENDIF33
;If etherBuffer(32) = ipaddr(2) Then
	banksel	SYSIPADDR_2
	movf	SYSIPADDR_2,W
	banksel	SYSETHERBUFFER_32
	subwf	SYSETHERBUFFER_32,W
	btfss	STATUS, Z
	goto	ENDIF35
;If etherBuffer(33) = ipaddr(3) Then
	banksel	SYSIPADDR_3
	movf	SYSIPADDR_3,W
	banksel	SYSETHERBUFFER_33
	subwf	SYSETHERBUFFER_33,W
	btfss	STATUS, Z
	goto	ENDIF37
;If etherBuffer(34) = ipaddr(4) Then
	banksel	SYSIPADDR_4
	movf	SYSIPADDR_4,W
	banksel	SYSETHERBUFFER_34
	subwf	SYSETHERBUFFER_34,W
	btfss	STATUS, Z
	goto	ENDIF39
;If etherBuffer(24) = 1 Then              'Protocol:ICMP
	decf	SYSETHERBUFFER_24,W
	btfss	STATUS, Z
	goto	ENDIF40
;End If
ENDIF40
;If etherBuffer(24) = 6 Then              'Protocol:TCP
	movlw	6
	subwf	SYSETHERBUFFER_24,W
	btfss	STATUS, Z
	goto	ENDIF41
;If Tcp_destporth = 0 Then
	movf	SYSETHERBUFFER_37,F
	btfss	STATUS, Z
	goto	ENDIF42
;Select Case Tcp_destportl
SysSelect3Case1
	movlw	80
	subwf	SYSETHERBUFFER_38,W
	btfss	STATUS, Z
	goto	SysSelect3Case2
;ENC28j60_http
	banksel	STATUS
	call	ENC28J60_HTTP
;End Select
SysSelect3Case2
SysSelectEnd3
;End If
ENDIF42
;End If
ENDIF41
;End If
ENDIF39
;End If
ENDIF37
;End If
ENDIF35
;End If
ENDIF33
;End If
ENDIF31
;End If
ENDIF29
;End If
ENDIF27
;End If
ENDIF25
	banksel	STATUS
	return

;********************************************************************************

FN_FNLSR
;dim SysLongTempB as long
;SysLongTempB  = BitsIn
;Repeat NumBits
	banksel	NUMBITS
	movf	NUMBITS,W
	movwf	SysRepeatTemp8
	btfsc	STATUS,Z
	goto	SysRepeatLoopEnd8
SysRepeatLoop8
;Set C Off
	bcf	STATUS,C
;Rotate SysLongTempB Right
	rrf	SYSLONGTEMPB_E,F
	rrf	SYSLONGTEMPB_U,F
	rrf	SYSLONGTEMPB_H,F
	rrf	SYSLONGTEMPB,F
;End Repeat
	decfsz	SysRepeatTemp8,F
	goto	SysRepeatLoop8
SysRepeatLoopEnd8
;FnLSR = SysLongTempB
	movf	SYSLONGTEMPB,W
	banksel	FNLSR
	movwf	FNLSR
	movf	SYSLONGTEMPB_H,W
	movwf	FNLSR_H
	movf	SYSLONGTEMPB_U,W
	movwf	FNLSR_U
	movf	SYSLONGTEMPB_E,W
	movwf	FNLSR_E
	return

;********************************************************************************

IVALID1_H
	movf	SYSSTRINGA,W
	movwf	SysWORDTempA
	movf	SYSSTRINGA_H,W
	movwf	SysWORDTempA_H
	movlw	115
	movwf	SysWORDTempB
	movlw	2
	movwf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	retlw	0
	movf	SysStringA, W
	addlw	low TableIVALID1_H
	movwf	SysStringA
	movlw	(high TableIVALID1_H) & 127
	btfsc	STATUS, C
	addlw	1
	addwf	SysStringA_H, W
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableIVALID1_H
	retlw	5
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255

;********************************************************************************

SYSCOMPEQUAL16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;movf SysWordTempA, W
	movf	SYSWORDTEMPA, W
;subwf SysWordTempB, W
	subwf	SYSWORDTEMPB, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;movf SysWordTempA_H, W
	movf	SYSWORDTEMPA_H, W
;subwf SysWordTempB_H, W
	subwf	SYSWORDTEMPB_H, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

;Start of program memory page 2
	ORG	4096
ENC28J60_ARPREPLY
;ENC28j60_set_response_macaddress
	call	ENC28J60_SET_RESPONSE_MACADDRESS
;For II = 1 To 6
;etherBuffer(32 + II) = etherBuffer(II)
;Next
;T_arp_dest_enetpacket0 = T_enetpacketdest0
	banksel	SYSETHERBUFFER_1
	movf	SYSETHERBUFFER_1,W
	movwf	SYSETHERBUFFER_33
;T_arp_dest_enetpacket1 = T_enetpacketdest1
	movf	SYSETHERBUFFER_2,W
	movwf	SYSETHERBUFFER_34
;T_arp_dest_enetpacket2 = T_enetpacketdest2
	movf	SYSETHERBUFFER_3,W
	movwf	SYSETHERBUFFER_35
;T_arp_dest_enetpacket3 = T_enetpacketdest3
	movf	SYSETHERBUFFER_4,W
	movwf	SYSETHERBUFFER_36
;T_arp_dest_enetpacket4 = T_enetpacketdest4
	movf	SYSETHERBUFFER_5,W
	movwf	SYSETHERBUFFER_37
;T_arp_dest_enetpacket5 = T_enetpacketdest5
	movf	SYSETHERBUFFER_6,W
	movwf	SYSETHERBUFFER_38
;For II = 1 To 4
;etherBuffer(38 + II) = etherBuffer(28 + II)
;Next
;T_arp_tipaddr0 = T_arp_sipaddr0
	movf	SYSETHERBUFFER_29,W
	movwf	SYSETHERBUFFER_39
;T_arp_tipaddr1 = T_arp_sipaddr1
	movf	SYSETHERBUFFER_30,W
	movwf	SYSETHERBUFFER_40
;T_arp_tipaddr2 = T_arp_sipaddr2
	movf	SYSETHERBUFFER_31,W
	movwf	SYSETHERBUFFER_41
;T_arp_tipaddr3 = T_arp_sipaddr3
	movf	SYSETHERBUFFER_32,W
	movwf	SYSETHERBUFFER_42
;For II = 1 To 6
;etherBuffer(22 + II) = etherBuffer(6 + II)
;Next
;T_arp_src_enetpacket0 = T_enetpacketsrc0
	movf	SYSETHERBUFFER_7,W
	movwf	SYSETHERBUFFER_23
;T_arp_src_enetpacket1 = T_enetpacketsrc1
	movf	SYSETHERBUFFER_8,W
	movwf	SYSETHERBUFFER_24
;T_arp_src_enetpacket2 = T_enetpacketsrc2
	movf	SYSETHERBUFFER_9,W
	movwf	SYSETHERBUFFER_25
;T_arp_src_enetpacket3 = T_enetpacketsrc3
	movf	SYSETHERBUFFER_10,W
	movwf	SYSETHERBUFFER_26
;T_arp_src_enetpacket4 = T_enetpacketsrc4
	movf	SYSETHERBUFFER_11,W
	movwf	SYSETHERBUFFER_27
;T_arp_src_enetpacket5 = T_enetpacketsrc5
	movf	SYSETHERBUFFER_12,W
	movwf	SYSETHERBUFFER_28
;T_arp_sipaddr0 = ipaddr(1)
	banksel	SYSIPADDR_1
	movf	SYSIPADDR_1,W
	banksel	SYSETHERBUFFER_29
	movwf	SYSETHERBUFFER_29
;T_arp_sipaddr1 = ipaddr(2)
	banksel	SYSIPADDR_2
	movf	SYSIPADDR_2,W
	banksel	SYSETHERBUFFER_30
	movwf	SYSETHERBUFFER_30
;T_arp_sipaddr2 = ipaddr(3)
	banksel	SYSIPADDR_3
	movf	SYSIPADDR_3,W
	banksel	SYSETHERBUFFER_31
	movwf	SYSETHERBUFFER_31
;T_arp_sipaddr3 = ipaddr(4)
	banksel	SYSIPADDR_4
	movf	SYSIPADDR_4,W
	banksel	SYSETHERBUFFER_32
	movwf	SYSETHERBUFFER_32
;etherBuffer(22) = 2
	movlw	2
	movwf	SYSETHERBUFFER_22
;ENC28j60_writebuffer( 42 )
	movlw	42
	banksel	PCKTLEN
	movwf	PCKTLEN
	clrf	PCKTLEN_H
	banksel	STATUS
	call	ENC28J60_WRITEBUFFER
;ENC28j60_packetsend(42)
	movlw	42
	banksel	PCKTLEN
	movwf	PCKTLEN
	clrf	PCKTLEN_H
	banksel	STATUS
	goto	ENC28J60_PACKETSEND

;********************************************************************************

ENC28J60_BITCLEAR
;				banktobeselected = ( addr & BANK_MASK) / 32
;banktobeselected = ( addr & BANK_MASK)
	movlw	96
	andwf	ADDR,W
	movwf	BANKTOBESELECTED
;Repeat 5
	movlw	5
	banksel	SYSREPEATTEMP5
	movwf	SysRepeatTemp5
SysRepeatLoop5
;set c off
	bcf	STATUS,C
;rotate banktobeselected right
	banksel	BANKTOBESELECTED
	rrf	BANKTOBESELECTED,F
;end repeat
	banksel	SYSREPEATTEMP5
	decfsz	SysRepeatTemp5,F
	goto	SysRepeatLoop5
SysRepeatLoopEnd5
;if lastselectedBank <> banktobeselected then
	banksel	BANKTOBESELECTED
	movf	BANKTOBESELECTED,W
	banksel	LASTSELECTEDBANK
	subwf	LASTSELECTEDBANK,W
	btfsc	STATUS, Z
	goto	ELSE19_1
;if ( ( addr & ADDR_MASK )  <= EIE  ) then
	movlw	31
	banksel	ADDR
	andwf	ADDR,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movwf	SysBYTETempB
	movlw	27
	movwf	SysBYTETempA
	banksel	STATUS
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	btfsc	SysByteTempX,0
;ENC28j60_selectBank ( banktobeselected, addr )
	call	ENC28J60_SELECTBANK
;end if
;Else
	goto	ENDIF19
ELSE19_1
;lastselectedBank = banktobeselected
	banksel	BANKTOBESELECTED
	movf	BANKTOBESELECTED,W
	banksel	LASTSELECTEDBANK
	movwf	LASTSELECTEDBANK
;end if
ENDIF19
;ENC28j60_Select
	banksel	LATB
	bcf	LATB,2
;FastHWSPITransfer( ENC28j60_BIT_FIELD_CLR | (addr AND ADDR_MASK ), temp )
	movlw	31
	andwf	ADDR,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	160
	iorwf	SysTemp1,W
	movwf	SPITXDATA
	banksel	STATUS
	pagesel	FASTHWSPITRANSFER
	call	FASTHWSPITRANSFER
	pagesel	$
;FastHWSPITransfer( ENC_Outbyte, temp )
	movf	ENC_OUTBYTE,W
	banksel	SPITXDATA
	movwf	SPITXDATA
	banksel	STATUS
	pagesel	FASTHWSPITRANSFER
	call	FASTHWSPITRANSFER
	pagesel	$
;ENC28j60_Deselect
	bsf	LATB,2
	return

;********************************************************************************

ENC28J60_BITSET
;				banktobeselected = ( addr & BANK_MASK) / 32
;HSerPrintByteCRLF banktobeselected
;banktobeselected = ( addr & BANK_MASK)
	movlw	96
	andwf	ADDR,W
	movwf	BANKTOBESELECTED
;Repeat 5
	movlw	5
	banksel	SYSREPEATTEMP6
	movwf	SysRepeatTemp6
SysRepeatLoop6
;set c off
	bcf	STATUS,C
;rotate banktobeselected right
	banksel	BANKTOBESELECTED
	rrf	BANKTOBESELECTED,F
;end repeat
	banksel	SYSREPEATTEMP6
	decfsz	SysRepeatTemp6,F
	goto	SysRepeatLoop6
SysRepeatLoopEnd6
;HSerPrintByteCRLF banktobeselected
;HSerPrintCRLF
;if lastselectedBank <> banktobeselected then
	banksel	BANKTOBESELECTED
	movf	BANKTOBESELECTED,W
	banksel	LASTSELECTEDBANK
	subwf	LASTSELECTEDBANK,W
	btfsc	STATUS, Z
	goto	ELSE49_1
;if ( ( addr & ADDR_MASK )  <= EIE  ) then
	movlw	31
	banksel	ADDR
	andwf	ADDR,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movwf	SysBYTETempB
	movlw	27
	movwf	SysBYTETempA
	banksel	STATUS
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	btfsc	SysByteTempX,0
;ENC28j60_selectBank ( banktobeselected, addr )
	call	ENC28J60_SELECTBANK
;end if
;Else
	goto	ENDIF49
ELSE49_1
;lastselectedBank = banktobeselected
	banksel	BANKTOBESELECTED
	movf	BANKTOBESELECTED,W
	banksel	LASTSELECTEDBANK
	movwf	LASTSELECTEDBANK
;end if
ENDIF49
;ENC28j60_Select
	banksel	LATB
	bcf	LATB,2
;FastHWSPITransfer( ENC28j60_BIT_FIELD_SET | (addr AND ADDR_MASK ), temp )
	movlw	31
	andwf	ADDR,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	128
	iorwf	SysTemp2,W
	movwf	SPITXDATA
	banksel	STATUS
	pagesel	FASTHWSPITRANSFER
	call	FASTHWSPITRANSFER
	pagesel	$
;FastHWSPITransfer( ENC_Outbyte, temp )
	movf	ENC_OUTBYTE,W
	banksel	SPITXDATA
	movwf	SPITXDATA
	banksel	STATUS
	pagesel	FASTHWSPITRANSFER
	call	FASTHWSPITRANSFER
	pagesel	$
;ENC28j60_Deselect
	bsf	LATB,2
	return

;********************************************************************************

ENC28J60_GENERAL_CHECKSUM
;dim I_x as word
;dim I_chksum32 as long
;X_odd = (Val2 - Val1 ) Mod 2
	banksel	VAL1
	movf	VAL1,W
	subwf	VAL2,W
	movwf	SysTemp2
	movlw	0
	subwfb	VAL2_H,W
	movwf	SysTemp2_H
	movf	SysTemp2,W
	movwf	SysWORDTempA
	movf	SysTemp2_H,W
	movwf	SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	call	SysDivSub16
	movf	SysWORDTempX,W
	banksel	X_ODD
	movwf	X_ODD
;if X_odd = 1 then HSerPrint "$"
;I_chksum32 = 0
	clrf	I_CHKSUM32
	clrf	I_CHKSUM32_H
	banksel	I_CHKSUM32_U
	clrf	I_CHKSUM32_U
	banksel	I_CHKSUM32_E
	clrf	I_CHKSUM32_E
;For I_x = Val1 To Val2 Step 2
	movlw	2
	subwf	VAL1,W
	movwf	I_X
	clrf	I_X_H
	btfss	STATUS,C
	decf	I_X_H,F
	movf	VAL1,W
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	movf	VAL2,W
	movwf	SysWORDTempA
	movf	VAL2_H,W
	movwf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd9
SysForLoop9
	movlw	2
	banksel	I_X
	addwf	I_X,F
	movlw	0
	addwfc	I_X_H,F
;I_value16 = FnLsl( etherbuffer(i_x), 8 )
	movlw	low(ETHERBUFFER)
	addwf	I_X,W
	movwf	AFSR0
	movlw	high(ETHERBUFFER)
	addwfc	I_X_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SYSLONGTEMPB
	clrf	SYSLONGTEMPB_H
	clrf	SYSLONGTEMPB_U
	clrf	SYSLONGTEMPB_E
	movlw	8
	movwf	NUMBITS
	banksel	STATUS
	pagesel	FN_FNLSL
	call	FN_FNLSL
	pagesel	$
	movf	FNLSL,W
	movwf	I_VALUE16
	movf	FNLSL_H,W
	movwf	I_VALUE16_H
;Hulp3 = I_x + 1
	banksel	I_X
	incf	I_X,W
	banksel	HULP3
	movwf	HULP3
;I_value16 = I_value16 + etherBuffer(hulp3)
	movlw	low(ETHERBUFFER)
	addwf	HULP3,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP3
	movwf	SysTemp3
	movlw	high(ETHERBUFFER)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	I_VALUE16
	addwf	I_VALUE16,F
	movlw	0
	addwfc	I_VALUE16_H,F
;I_chksum32 = I_chksum32 + I_value16
	movf	I_VALUE16,W
	banksel	I_CHKSUM32
	addwf	I_CHKSUM32,F
	banksel	I_VALUE16_H
	movf	I_VALUE16_H,W
	banksel	I_CHKSUM32_H
	addwfc	I_CHKSUM32_H,F
	movlw	0
	banksel	I_CHKSUM32_U
	addwfc	I_CHKSUM32_U,F
	movlw	0
	banksel	I_CHKSUM32_E
	addwfc	I_CHKSUM32_E,F
;Next I_x
	movf	I_X,W
	movwf	SysWORDTempA
	movf	I_X_H,W
	movwf	SysWORDTempA_H
	movf	VAL2,W
	movwf	SysWORDTempB
	movf	VAL2_H,W
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop9
SysForLoopEnd9
;If I_odd = 1 Then
	decf	I_ODD,W
	btfss	STATUS, Z
	goto	ENDIF97
;Val2 = Val2 + 3
	movlw	3
	banksel	VAL2
	addwf	VAL2,F
	movlw	0
	addwfc	VAL2_H,F
;I_value16 = FnLsl( etherbuffer(val2), 8 )
	movlw	low(ETHERBUFFER)
	addwf	VAL2,W
	movwf	AFSR0
	movlw	high(ETHERBUFFER)
	addwfc	VAL2_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SYSLONGTEMPB
	clrf	SYSLONGTEMPB_H
	clrf	SYSLONGTEMPB_U
	clrf	SYSLONGTEMPB_E
	movlw	8
	movwf	NUMBITS
	banksel	STATUS
	pagesel	FN_FNLSL
	call	FN_FNLSL
	pagesel	$
	movf	FNLSL,W
	movwf	I_VALUE16
	movf	FNLSL_H,W
	movwf	I_VALUE16_H
;I_chksum32 = I_chksum32 + I_value16
	movf	I_VALUE16,W
	banksel	I_CHKSUM32
	addwf	I_CHKSUM32,F
	banksel	I_VALUE16_H
	movf	I_VALUE16_H,W
	banksel	I_CHKSUM32_H
	addwfc	I_CHKSUM32_H,F
	movlw	0
	banksel	I_CHKSUM32_U
	addwfc	I_CHKSUM32_U,F
	movlw	0
	banksel	I_CHKSUM32_E
	addwfc	I_CHKSUM32_E,F
;End If
ENDIF97
;I_checksum16 = Fnlsr(i_chksum32, 16)
	banksel	I_CHKSUM32
	movf	I_CHKSUM32,W
	movwf	SYSLONGTEMPB
	movf	I_CHKSUM32_H,W
	movwf	SYSLONGTEMPB_H
	banksel	I_CHKSUM32_U
	movf	I_CHKSUM32_U,W
	movwf	SYSLONGTEMPB_U
	banksel	I_CHKSUM32_E
	movf	I_CHKSUM32_E,W
	movwf	SYSLONGTEMPB_E
	movlw	16
	movwf	NUMBITS
	banksel	STATUS
	pagesel	FN_FNLSR
	call	FN_FNLSR
	pagesel	$
	movf	FNLSR,W
	movwf	I_CHECKSUM16
	movf	FNLSR_H,W
	movwf	I_CHECKSUM16_H
;I_checksum16 = I_checksum16 + I_chksum32 ' only 16 lower bits of i_chksum32 is taken...
	banksel	I_CHKSUM32
	movf	I_CHKSUM32,W
	banksel	I_CHECKSUM16
	addwf	I_CHECKSUM16,F
	banksel	I_CHKSUM32_H
	movf	I_CHKSUM32_H,W
	banksel	I_CHECKSUM16_H
	addwfc	I_CHECKSUM16_H,F
;I_checksum16 = Not I_checksum16
	comf	I_CHECKSUM16,F
	comf	I_CHECKSUM16_H,F
;Val3 = i_checksum16_h
	movf	I_CHECKSUM16_H,W
	banksel	VAL3
	movwf	VAL3
;Val4 = i_checksum16
	banksel	I_CHECKSUM16
	movf	I_CHECKSUM16,W
	banksel	VAL4
	movwf	VAL4
	banksel	STATUS
	return

;********************************************************************************

ENC28J60_IP_HEADER_CHECKSUM
;Dim Ip_x As Byte
;Dim Ip_hulp1 As Byte
;Dim Ip_chksum32 As Long
;Dim Ip_checksum16 As Word
;Dim Ip_temp16 As Word
;Dim Ip_header_length As Byte
;Dim Val2 as word
;I_chksum32 = 0
	banksel	I_CHKSUM32
	clrf	I_CHKSUM32
;Ip_header_length = T_ip_vers_len And 0x0F
	movlw	15
	banksel	SYSETHERBUFFER_15
	andwf	SYSETHERBUFFER_15,W
	banksel	IP_HEADER_LENGTH
	movwf	IP_HEADER_LENGTH
;Ip_header_length = 4 * Ip_header_length
;repeat 2
	movlw	2
	banksel	SYSREPEATTEMP7
	movwf	SysRepeatTemp7
SysRepeatLoop7
;set C off
	bcf	STATUS,C
;rotate Ip_header_length left
	banksel	IP_HEADER_LENGTH
	rlf	IP_HEADER_LENGTH,F
;end repeat
	banksel	SYSREPEATTEMP7
	decfsz	SysRepeatTemp7,F
	goto	SysRepeatLoop7
SysRepeatLoopEnd7
;I_chksum32 = 0
	clrf	I_CHKSUM32
;I_odd = 0
	banksel	I_ODD
	clrf	I_ODD
;Val1 = 15
	movlw	15
	banksel	VAL1
	movwf	VAL1
;Val2 = 0x0E + Ip_header_length - 1
	movlw	14
	banksel	IP_HEADER_LENGTH
	addwf	IP_HEADER_LENGTH,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	clrf	SysTemp2_H
	btfsc	STATUS,C
	incf	SysTemp2_H,F
	movlw	1
	subwf	SysTemp2,W
	movwf	VAL2
	movlw	0
	subwfb	SysTemp2_H,W
	movwf	VAL2_H
;T_ip_hdr_cksum0 = 0
	banksel	SYSETHERBUFFER_25
	clrf	SYSETHERBUFFER_25
;T_ip_hdr_cksum1 = 0
	clrf	SYSETHERBUFFER_26
;ENC28j60_General_checksum(val1 , Val2)
	banksel	STATUS
	call	ENC28J60_GENERAL_CHECKSUM
;T_ip_hdr_cksum0 = Val3
	banksel	VAL3
	movf	VAL3,W
	banksel	SYSETHERBUFFER_25
	movwf	SYSETHERBUFFER_25
;T_ip_hdr_cksum1 = Val4
	banksel	VAL4
	movf	VAL4,W
	banksel	SYSETHERBUFFER_26
	movwf	SYSETHERBUFFER_26
	banksel	STATUS
	return

;********************************************************************************

ENC28J60_PACKETSEND
;ENC28j60_bitSet( ECON1 , econ1_txrst )
	movlw	31
	movwf	ADDR
	movlw	128
	movwf	ENC_OUTBYTE
	call	ENC28J60_BITSET
;ENC28j60_bitClear( ECON1 , econ1_txrst )
	movlw	31
	movwf	ADDR
	movlw	128
	movwf	ENC_OUTBYTE
	call	ENC28J60_BITCLEAR
;ENC28j60_bitClear( EIR , EIR_TXERIF )
	movlw	28
	movwf	ADDR
	movlw	2
	movwf	ENC_OUTBYTE
	call	ENC28J60_BITCLEAR
;wait while ( (ENC28j60_ReadReg( ECON1 ) & ECON1_TXRTS ) = ECON1_TXRTS )
SysWaitLoop13
	movlw	31
	movwf	ADDR
	call	FN_ENC28J60_READREG
	movlw	8
	andwf	ENC28J60_READREG,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	movwf	SysBYTETempA
	movlw	8
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SysCompEqual
	call	SysCompEqual
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysWaitLoop13
;ENC28j60_writeReg(etxndl , (ENC_TXBUF_STL + pcktlen ) & 0xFF )
;ENC28j60_writeReg(etxndh , ENC_TXBUF_STH + pcktlen_h )
;todo erv
;hulp2 =  ENC_TXBUF_ST + pcktlen
	movlw	112
	banksel	PCKTLEN
	addwf	PCKTLEN,W
	banksel	HULP2
	movwf	HULP2
	movlw	22
	banksel	PCKTLEN_H
	addwfc	PCKTLEN_H,W
	banksel	HULP2_H
	movwf	HULP2_H
;HSerPrint hex(hulp2_h)
;HSerPrint hex(hulp2)
;HSerPrintCRLF
;ENC28j60_writeReg(etxndl , hulp2 & 0xFF )
	movlw	6
	movwf	ADDR
	movf	HULP2,W
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(etxndh , hulp2_h )
	movlw	7
	movwf	ADDR
	movf	HULP2_H,W
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28j60_bitSet( EIR , EIR_TXIF )
	movlw	28
	movwf	ADDR
	movlw	8
	movwf	ENC_OUTBYTE
	call	ENC28J60_BITSET
;ENC28j60_bitClear( EIE , EIE_TXIE )
	movlw	27
	movwf	ADDR
	movlw	8
	movwf	ENC_OUTBYTE
	call	ENC28J60_BITCLEAR
;ENC28j60_bitSet( ECON1 , econ1_txrts )
	movlw	31
	movwf	ADDR
	movlw	8
	movwf	ENC_OUTBYTE
	call	ENC28J60_BITSET
;wait while ( (ENC28j60_ReadReg( ECON1 ) & ECON1_TXRTS ) = ECON1_TXRTS )
SysWaitLoop14
	movlw	31
	movwf	ADDR
	call	FN_ENC28J60_READREG
	movlw	8
	andwf	ENC28J60_READREG,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	movwf	SysBYTETempA
	movlw	8
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SysCompEqual
	call	SysCompEqual
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysWaitLoop14
	return

;********************************************************************************

ENC28J60_PACKETSHAPE
;T_enetpacketdest0 = T_enetpacketsrc0
	banksel	SYSETHERBUFFER_7
	movf	SYSETHERBUFFER_7,W
	movwf	SYSETHERBUFFER_1
;T_enetpacketdest1 = T_enetpacketsrc1
	movf	SYSETHERBUFFER_8,W
	movwf	SYSETHERBUFFER_2
;T_enetpacketdest2 = T_enetpacketsrc2
	movf	SYSETHERBUFFER_9,W
	movwf	SYSETHERBUFFER_3
;T_enetpacketdest3 = T_enetpacketsrc3
	movf	SYSETHERBUFFER_10,W
	movwf	SYSETHERBUFFER_4
;T_enetpacketdest4 = T_enetpacketsrc4
	movf	SYSETHERBUFFER_11,W
	movwf	SYSETHERBUFFER_5
;T_enetpacketdest5 = T_enetpacketsrc5
	movf	SYSETHERBUFFER_12,W
	movwf	SYSETHERBUFFER_6
;T_enetpacketsrc0 = macaddr(1)
	banksel	SYSMACADDR_1
	movf	SYSMACADDR_1,W
	banksel	SYSETHERBUFFER_7
	movwf	SYSETHERBUFFER_7
;T_enetpacketsrc1 = macaddr(2)
	banksel	SYSMACADDR_2
	movf	SYSMACADDR_2,W
	banksel	SYSETHERBUFFER_8
	movwf	SYSETHERBUFFER_8
;T_enetpacketsrc2 = macaddr(3)
	banksel	SYSMACADDR_3
	movf	SYSMACADDR_3,W
	banksel	SYSETHERBUFFER_9
	movwf	SYSETHERBUFFER_9
;T_enetpacketsrc3 = macaddr(4)
	banksel	SYSMACADDR_4
	movf	SYSMACADDR_4,W
	banksel	SYSETHERBUFFER_10
	movwf	SYSETHERBUFFER_10
;T_enetpacketsrc4 = macaddr(5)
	banksel	SYSMACADDR_5
	movf	SYSMACADDR_5,W
	banksel	SYSETHERBUFFER_11
	movwf	SYSETHERBUFFER_11
;T_enetpacketsrc5 = macaddr(6)
	banksel	SYSMACADDR_6
	movf	SYSMACADDR_6,W
	banksel	SYSETHERBUFFER_12
	movwf	SYSETHERBUFFER_12
	banksel	STATUS
	return

;********************************************************************************

ENC28J60_READBUFFER
;dim eth_counter as Word
;ENC28j60_regdump
;if etherGetLength  > 1518 then Exit Sub
;ENC28j60_Select
	bcf	LATB,2
;Set WCOL Off
	banksel	SSP1CON1
	bcf	SSP1CON1,WCOL
;SSPBUF = ENC28j60_READ_BUF_MEM
	movlw	58
	movwf	SSPBUF
;Wait While BF = Off
SysWaitLoop10
	btfss	SSP1STAT,BF
	goto	SysWaitLoop10
;temp = SSPBUF
	movf	SSPBUF,W
	banksel	TEMP
	movwf	TEMP
;for eth_counter = 1 to etherGetLength
	banksel	ETH_COUNTER
	clrf	ETH_COUNTER
	clrf	ETH_COUNTER_H
	movlw	1
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	movf	ETHERGETLENGTH,W
	movwf	SysWORDTempA
	movf	ETHERGETLENGTH_H,W
	movwf	SysWORDTempA_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd2
SysForLoop2
	incf	ETH_COUNTER,F
	btfsc	STATUS,Z
	incf	ETH_COUNTER_H,F
;if eth_counter > etherBufferSize then
	movf	ETH_COUNTER,W
	movwf	SysWORDTempB
	movf	ETH_COUNTER_H,W
	movwf	SysWORDTempB_H
	movlw	218
	movwf	SysWORDTempA
	movlw	2
	movwf	SysWORDTempA_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
;exit for
	goto	SysForLoopEnd2
;end if
;SSPBUF = 0
	banksel	SSPBUF
	clrf	SSPBUF
;Wait While BF = Off
SysWaitLoop11
	btfss	SSP1STAT,BF
	goto	SysWaitLoop11
;etherbuffer( eth_counter ) = SSPBUF
	movlw	low(ETHERBUFFER)
	banksel	ETH_COUNTER
	addwf	ETH_COUNTER,W
	movwf	AFSR0
	movlw	high(ETHERBUFFER)
	addwfc	ETH_COUNTER_H,W
	movwf	AFSR0_H
	banksel	SSPBUF
	movf	SSPBUF,W
	movwf	INDF0
;next
	banksel	ETH_COUNTER
	movf	ETH_COUNTER,W
	movwf	SysWORDTempA
	movf	ETH_COUNTER_H,W
	movwf	SysWORDTempA_H
	movf	ETHERGETLENGTH,W
	movwf	SysWORDTempB
	movf	ETHERGETLENGTH_H,W
	movwf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop2
SysForLoopEnd2
;if etherGetLength > etherBufferSize then
	movf	ETHERGETLENGTH,W
	movwf	SysWORDTempB
	movf	ETHERGETLENGTH_H,W
	movwf	SysWORDTempB_H
	movlw	218
	movwf	SysWORDTempA
	movlw	2
	movwf	SysWORDTempA_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF46
;for eth_counter = etherBufferSize+1 to etherGetLength
	movlw	218
	movwf	ETH_COUNTER
	movlw	2
	movwf	ETH_COUNTER_H
	movlw	219
	movwf	SysWORDTempB
	movlw	2
	movwf	SysWORDTempB_H
	movf	ETHERGETLENGTH,W
	movwf	SysWORDTempA
	movf	ETHERGETLENGTH_H,W
	movwf	SysWORDTempA_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd3
SysForLoop3
	incf	ETH_COUNTER,F
	btfsc	STATUS,Z
	incf	ETH_COUNTER_H,F
;SSPBUF = 0
	banksel	SSPBUF
	clrf	SSPBUF
;Wait While BF = Off
SysWaitLoop12
	btfss	SSP1STAT,BF
	goto	SysWaitLoop12
;temp = SSPBUF
	movf	SSPBUF,W
	banksel	TEMP
	movwf	TEMP
;next
	banksel	ETH_COUNTER
	movf	ETH_COUNTER,W
	movwf	SysWORDTempA
	movf	ETH_COUNTER_H,W
	movwf	SysWORDTempA_H
	movf	ETHERGETLENGTH,W
	movwf	SysWORDTempB
	movf	ETHERGETLENGTH_H,W
	movwf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop3
SysForLoopEnd3
;End if
ENDIF46
;ENC28j60_Deselect
	bsf	LATB,2
	return

;********************************************************************************

FN_ENC28J60_READREG
;banktobeselected =  ( addr & BANK_MASK) / 32
;banktobeselected =  ( addr & BANK_MASK)
	movlw	96
	andwf	ADDR,W
	movwf	BANKTOBESELECTED
;Repeat 5
	movlw	5
	banksel	SYSREPEATTEMP2
	movwf	SysRepeatTemp2
SysRepeatLoop2
;set c off
	bcf	STATUS,C
;rotate banktobeselected right
	banksel	BANKTOBESELECTED
	rrf	BANKTOBESELECTED,F
;end repeat
	banksel	SYSREPEATTEMP2
	decfsz	SysRepeatTemp2,F
	goto	SysRepeatLoop2
SysRepeatLoopEnd2
;HSerPrint "$"
;HSerPrint banktobeselected
;HSerPrint ":"
;				'These registers (EIE, EIR, ESTAT, ECON2, ECON1)
;				'are present in all banks, no need to switch bank
;if lastselectedBank <> banktobeselected then
	banksel	BANKTOBESELECTED
	movf	BANKTOBESELECTED,W
	banksel	LASTSELECTEDBANK
	subwf	LASTSELECTEDBANK,W
	btfsc	STATUS, Z
	goto	ENDIF9
;if ( ( addr & ADDR_MASK ) <= EIE  ) then
	movlw	31
	banksel	ADDR
	andwf	ADDR,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movwf	SysBYTETempB
	movlw	27
	movwf	SysBYTETempA
	banksel	STATUS
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ELSE10_1
;ENC28j60_selectBank ( banktobeselected, addr )
	call	ENC28J60_SELECTBANK
;else
	goto	ENDIF10
ELSE10_1
;lastselectedBank = banktobeselected
	movf	BANKTOBESELECTED,W
	banksel	LASTSELECTEDBANK
	movwf	LASTSELECTEDBANK
;end if
ENDIF10
;end if
ENDIF9
;ENC28j60_Select
	banksel	LATB
	bcf	LATB,2
;Set WCOL Off
	banksel	SSP1CON1
	bcf	SSP1CON1,WCOL
;SSPBUF = ENC28j60_READ_CTRL_REG | ( addr AND ADDR_MASK )
	movlw	31
	banksel	ADDR
	andwf	ADDR,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	SSPBUF
	movwf	SSPBUF
;Wait While BF = Off
SysWaitLoop3
	btfss	SSP1STAT,BF
	goto	SysWaitLoop3
;temp = SSPBUF
	movf	SSPBUF,W
	banksel	TEMP
	movwf	TEMP
;Set WCOL Off
	banksel	SSP1CON1
	bcf	SSP1CON1,WCOL
;SSPBUF = temp
	banksel	TEMP
	movf	TEMP,W
	banksel	SSPBUF
	movwf	SSPBUF
;Wait While BF = Off
SysWaitLoop4
	btfss	SSP1STAT,BF
	goto	SysWaitLoop4
;temp = SSPBUF
	movf	SSPBUF,W
	banksel	TEMP
	movwf	TEMP
;Set WCOL Off
	banksel	SSP1CON1
	bcf	SSP1CON1,WCOL
;SSPBUF = temp
	banksel	TEMP
	movf	TEMP,W
	banksel	SSPBUF
	movwf	SSPBUF
;Wait While BF = Off
SysWaitLoop5
	btfss	SSP1STAT,BF
	goto	SysWaitLoop5
;ENC28j60_ReadReg = SSPBUF
	movf	SSPBUF,W
	banksel	ENC28J60_READREG
	movwf	ENC28J60_READREG
;ENC28j60_Deselect
	bsf	LATB,2
	return

;********************************************************************************

ENC28J60_SELECTBANK
;ENC28j60_Select
	bcf	LATB,2
;FastHWSPITransfer(BFCCMD | ECON1, temp)
	movlw	191
	banksel	SPITXDATA
	movwf	SPITXDATA
	banksel	STATUS
	pagesel	FASTHWSPITRANSFER
	call	FASTHWSPITRANSFER
	pagesel	$
;FastHWSPITransfer(b'00000011', temp)
	movlw	3
	banksel	SPITXDATA
	movwf	SPITXDATA
	banksel	STATUS
	pagesel	FASTHWSPITRANSFER
	call	FASTHWSPITRANSFER
	pagesel	$
;ENC28j60_Deselect
	bsf	LATB,2
;ENC28j60_Select
	bcf	LATB,2
;FastHWSPITransfer(BFSCMD | ECON1, temp)
	movlw	159
	banksel	SPITXDATA
	movwf	SPITXDATA
	banksel	STATUS
	pagesel	FASTHWSPITRANSFER
	call	FASTHWSPITRANSFER
	pagesel	$
;Select case banktobeselected
;case 1
SysSelect1Case1
	decf	BANKTOBESELECTED,W
	btfss	STATUS, Z
	goto	SysSelect1Case2
;FastHWSPITransfer(b'00000001' , temp)
	movlw	1
	banksel	SPITXDATA
	movwf	SPITXDATA
	banksel	STATUS
	pagesel	FASTHWSPITRANSFER
	call	FASTHWSPITRANSFER
	pagesel	$
;case 2
	goto	SysSelectEnd1
SysSelect1Case2
	movlw	2
	subwf	BANKTOBESELECTED,W
	btfss	STATUS, Z
	goto	SysSelect1Case3
;FastHWSPITransfer(b'00000010' , temp)
	movlw	2
	banksel	SPITXDATA
	movwf	SPITXDATA
	banksel	STATUS
	pagesel	FASTHWSPITRANSFER
	call	FASTHWSPITRANSFER
	pagesel	$
;case 3
	goto	SysSelectEnd1
SysSelect1Case3
	movlw	3
	subwf	BANKTOBESELECTED,W
	btfss	STATUS, Z
	goto	SysSelect1Case4
;FastHWSPITransfer(b'00000011' , temp)
	movlw	3
	banksel	SPITXDATA
	movwf	SPITXDATA
	banksel	STATUS
	pagesel	FASTHWSPITRANSFER
	call	FASTHWSPITRANSFER
	pagesel	$
;End Select
SysSelect1Case4
SysSelectEnd1
;ENC28j60_Deselect
	bsf	LATB,2
;lastselectedBank = banktobeselected
	movf	BANKTOBESELECTED,W
	banksel	LASTSELECTEDBANK
	movwf	LASTSELECTEDBANK
	banksel	STATUS
	return

;********************************************************************************

ENC28J60_SET_RESPONSE_MACADDRESS
;For II = 1 To 6
	clrf	II
SysForLoop4
	incf	II,F
;etherBuffer(II)= etherBuffer(6 + II)
	movlw	low(ETHERBUFFER+6)
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	high(ETHERBUFFER+6)
	movwf	SysTemp2_H
	banksel	II
	movf	II,W
	banksel	SYSTEMP2
	addwf	SysTemp2,W
	movwf	AFSR0
	movlw	0
	addwfc	SysTemp2_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SysArrayTemp2
	movwf	SysArrayTemp1
	movlw	low(ETHERBUFFER)
	banksel	II
	addwf	II,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP3
	movwf	SysTemp3
	movlw	high(ETHERBUFFER)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movf	SysArrayTemp1,W
	movwf	INDF0
;Next
	movlw	6
	banksel	II
	subwf	II,W
	btfss	STATUS, C
	goto	SysForLoop4
SysForLoopEnd4
;etherBuffer(7) = macaddr(1)
	banksel	SYSMACADDR_1
	movf	SYSMACADDR_1,W
	banksel	SYSETHERBUFFER_7
	movwf	SYSETHERBUFFER_7
;etherBuffer(8) = macaddr(2)
	banksel	SYSMACADDR_2
	movf	SYSMACADDR_2,W
	banksel	SYSETHERBUFFER_8
	movwf	SYSETHERBUFFER_8
;etherBuffer(9) = macaddr(3)
	banksel	SYSMACADDR_3
	movf	SYSMACADDR_3,W
	banksel	SYSETHERBUFFER_9
	movwf	SYSETHERBUFFER_9
;etherBuffer(10) = macaddr(4)
	banksel	SYSMACADDR_4
	movf	SYSMACADDR_4,W
	banksel	SYSETHERBUFFER_10
	movwf	SYSETHERBUFFER_10
;etherBuffer(11) = macaddr(5)
	banksel	SYSMACADDR_5
	movf	SYSMACADDR_5,W
	banksel	SYSETHERBUFFER_11
	movwf	SYSETHERBUFFER_11
;etherBuffer(12) = macaddr(6)
	banksel	SYSMACADDR_6
	movf	SYSMACADDR_6,W
	banksel	SYSETHERBUFFER_12
	movwf	SYSETHERBUFFER_12
	banksel	STATUS
	return

;********************************************************************************

ENC28J60_WRITEBUFFER
;dim eth_counter as Word
;ENC28j60_writeReg(ewrptl, ENC_TXBUF_STL)
	movlw	2
	movwf	ADDR
	movlw	112
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ewrpth, ENC_TXBUF_STH)
	movlw	3
	movwf	ADDR
	movlw	22
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28j60_Select
	bcf	LATB,2
;Set WCOL Off
	banksel	SSP1CON1
	bcf	SSP1CON1,WCOL
;SSPBUF = ENC28j60_write_buf_mem
	movlw	122
	movwf	SSPBUF
;Wait While BF = Off
SysWaitLoop15
	btfss	SSP1STAT,BF
	goto	SysWaitLoop15
;temp = SSPBUF
	movf	SSPBUF,W
	banksel	TEMP
	movwf	TEMP
;SSPBUF = 0x0E
	movlw	14
	banksel	SSPBUF
	movwf	SSPBUF
;Wait While BF = Off
SysWaitLoop16
	btfss	SSP1STAT,BF
	goto	SysWaitLoop16
;temp = SSPBUF
	movf	SSPBUF,W
	banksel	TEMP
	movwf	TEMP
;for eth_counter = 1 to pcktlen
	banksel	ETH_COUNTER
	clrf	ETH_COUNTER
	clrf	ETH_COUNTER_H
	movlw	1
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	PCKTLEN
	movf	PCKTLEN,W
	movwf	SysWORDTempA
	movf	PCKTLEN_H,W
	movwf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd6
SysForLoop6
	incf	ETH_COUNTER,F
	btfsc	STATUS,Z
	incf	ETH_COUNTER_H,F
;if eth_counter > etherBufferSize then Exit For
	movf	ETH_COUNTER,W
	movwf	SysWORDTempB
	movf	ETH_COUNTER_H,W
	movwf	SysWORDTempB_H
	movlw	218
	movwf	SysWORDTempA
	movlw	2
	movwf	SysWORDTempA_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd6
;SSPBUF = etherbuffer(eth_counter)
	movlw	low(ETHERBUFFER)
	addwf	ETH_COUNTER,W
	movwf	AFSR0
	movlw	high(ETHERBUFFER)
	addwfc	ETH_COUNTER_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SSPBUF
	movwf	SSPBUF
;Wait While BF = Off
SysWaitLoop17
	btfss	SSP1STAT,BF
	goto	SysWaitLoop17
;temp = SSPBUF
	movf	SSPBUF,W
	banksel	TEMP
	movwf	TEMP
;next
	banksel	ETH_COUNTER
	movf	ETH_COUNTER,W
	movwf	SysWORDTempA
	movf	ETH_COUNTER_H,W
	movwf	SysWORDTempA_H
	banksel	PCKTLEN
	movf	PCKTLEN,W
	movwf	SysWORDTempB
	movf	PCKTLEN_H,W
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop6
SysForLoopEnd6
;ENC28j60_Deselect
	bsf	LATB,2
	return

;********************************************************************************

ENC28J60_WRITEREG
;				banktobeselected = ( addr & BANK_MASK) / 32
;banktobeselected =  ( addr & BANK_MASK)
	movlw	96
	andwf	ADDR,W
	movwf	BANKTOBESELECTED
;Repeat 5
	movlw	5
	banksel	SYSREPEATTEMP3
	movwf	SysRepeatTemp3
SysRepeatLoop3
;set c off
	bcf	STATUS,C
;rotate banktobeselected right
	banksel	BANKTOBESELECTED
	rrf	BANKTOBESELECTED,F
;end Repeat
	banksel	SYSREPEATTEMP3
	decfsz	SysRepeatTemp3,F
	goto	SysRepeatLoop3
SysRepeatLoopEnd3
;if lastselectedBank <> banktobeselected then
	banksel	BANKTOBESELECTED
	movf	BANKTOBESELECTED,W
	banksel	LASTSELECTEDBANK
	subwf	LASTSELECTEDBANK,W
	btfsc	STATUS, Z
	goto	ELSE11_1
;if ( ( addr & ADDR_MASK )  <= EIE  ) then
	movlw	31
	banksel	ADDR
	andwf	ADDR,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movwf	SysBYTETempB
	movlw	27
	movwf	SysBYTETempA
	banksel	STATUS
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	btfsc	SysByteTempX,0
;ENC28j60_selectBank ( banktobeselected, addr )
	call	ENC28J60_SELECTBANK
;end if
;Else
	goto	ENDIF11
ELSE11_1
;lastselectedBank = banktobeselected
	banksel	BANKTOBESELECTED
	movf	BANKTOBESELECTED,W
	banksel	LASTSELECTEDBANK
	movwf	LASTSELECTEDBANK
;end if
ENDIF11
;ENC28j60_Select
	banksel	LATB
	bcf	LATB,2
;FastHWSPITransfer( ENC28j60_WRITE_CTRL_REG | (addr AND ADDR_MASK ), temp )
	movlw	31
	andwf	ADDR,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	64
	iorwf	SysTemp1,W
	movwf	SPITXDATA
	banksel	STATUS
	pagesel	FASTHWSPITRANSFER
	call	FASTHWSPITRANSFER
	pagesel	$
;FastHWSPITransfer( ENC_Outbyte, temp )
	movf	ENC_OUTBYTE,W
	banksel	SPITXDATA
	movwf	SPITXDATA
	banksel	STATUS
	pagesel	FASTHWSPITRANSFER
	call	FASTHWSPITRANSFER
	pagesel	$
;ENC28j60_Deselect
	bsf	LATB,2
	return

;********************************************************************************

;Overloaded signature: STRING:byte:
HSERPRINT259
;PrintLen = PrintData(0)
	banksel	SYSPRINTDATAHANDLER
	movf	SysPRINTDATAHandler,W
	movwf	AFSR0
	movf	SysPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	PRINTLEN
;If PrintLen <> 0 then
	movf	PRINTLEN,F
	btfsc	STATUS, Z
	goto	ENDIF16
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
	banksel	STATUS
	pagesel	HSERSEND
	call	HSERSEND
	pagesel	$
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;next
	banksel	PRINTLEN
	movf	PRINTLEN,W
	subwf	SYSPRINTTEMP,W
	btfss	STATUS, C
	goto	SysForLoop1
SysForLoopEnd1
;End If
ENDIF16
	banksel	STATUS
	return

;********************************************************************************

;Overloaded signature: BYTE:byte:
HSERPRINT260
;OutValueTemp = 0
	banksel	OUTVALUETEMP
	clrf	OUTVALUETEMP
;IF SerPrintVal >= 100 Then
	movlw	100
	subwf	SERPRINTVAL,W
	btfss	STATUS, C
	goto	ENDIF93
;OutValueTemp = SerPrintVal / 100
	movf	SERPRINTVAL,W
	movwf	SysBYTETempA
	movlw	100
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SysDivSub
	call	SysDivSub
	pagesel	$
	movf	SysBYTETempA,W
	banksel	OUTVALUETEMP
	movwf	OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SERPRINTVAL
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W
	movwf	SERDATA
	banksel	STATUS
	pagesel	HSERSEND
	call	HSERSEND
	pagesel	$
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;End If
ENDIF93
;If OutValueTemp > 0 Or SerPrintVal >= 10 Then
	banksel	OUTVALUETEMP
	movf	OUTVALUETEMP,W
	movwf	SysBYTETempB
	clrf	SysBYTETempA
	banksel	STATUS
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	movf	SysByteTempX,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	movf	SERPRINTVAL,W
	movwf	SysBYTETempA
	movlw	10
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	banksel	SYSTEMP3
	movf	SysTemp3,W
	iorwf	SysByteTempX,W
	movwf	SysTemp1
	btfss	SysTemp1,0
	goto	ENDIF94
;OutValueTemp = SerPrintVal / 10
	movf	SERPRINTVAL,W
	movwf	SysBYTETempA
	movlw	10
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SysDivSub
	call	SysDivSub
	pagesel	$
	movf	SysBYTETempA,W
	banksel	OUTVALUETEMP
	movwf	OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SERPRINTVAL
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W
	movwf	SERDATA
	banksel	STATUS
	pagesel	HSERSEND
	call	HSERSEND
	pagesel	$
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;End If
ENDIF94
;HSerSend(SerPrintVal + 48 ,comport)
	movlw	48
	banksel	SERPRINTVAL
	addwf	SERPRINTVAL,W
	movwf	SERDATA
	banksel	STATUS
	pagesel	HSERSEND
	call	HSERSEND
	pagesel	$
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	goto	Delay_MS

;********************************************************************************

HTTPPART3
;If Tcp_ack = 1 Then
	banksel	SYSBITVAR0
	btfss	SYSBITVAR0,5
	goto	ENDIF70
;If etherBuffer(17) = 0 Then
	banksel	SYSETHERBUFFER_17
	movf	SYSETHERBUFFER_17,F
	btfss	STATUS, Z
	goto	ENDIF71
;If etherBuffer(18) = 40 Then
	movlw	40
	subwf	SYSETHERBUFFER_18,W
	btfss	STATUS, Z
	goto	ENDIF72
;If Ackpsh = 1 Then
	banksel	ACKPSH
	decf	ACKPSH,W
	btfss	STATUS, Z
	goto	ENDIF73
;arrayloc = 0x0037   'start of HTTP header within the TCP Packet
	movlw	55
	movwf	ARRAYLOC
	clrf	ARRAYLOC_H
;HSerPrint "TableStartPoint = "
;HSerPrint TableStartPoint
;HSerPrintCRLF
;if TableStartPoint = 1 then
	banksel	TABLESTARTPOINT
	movf	TABLESTARTPOINT,W
	movwf	SysWORDTempA
	movf	TABLESTARTPOINT_H,W
	movwf	SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF74
;HTTPSentTCPPacket = 0
	clrf	HTTPSENTTCPPACKET
;HTTPPrintStandardHeader ;print the header
	pagesel	HTTPPRINTSTANDARDHEADER
	call	HTTPPRINTSTANDARDHEADER
	pagesel	$
;HTTPPrint( "", HTTPPrintCRLF )
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable21
	movwf	SysStringA
	movlw	(high StringTable21) & 127
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	banksel	SYSHTTPDATAHANDLER
	movwf	SysHTTPDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H
	movlw	1
	banksel	HTTPPRINTCRLFFLAG
	movwf	HTTPPRINTCRLFFLAG
	call	HTTPPRINT
;end if
ENDIF74
;eth_counter = 0
	clrf	ETH_COUNTER
;commandlineString = ""
	movlw	low COMMANDLINESTRING
	movwf	FSR1L
	movlw	high COMMANDLINESTRING
	movwf	FSR1H
	movlw	low StringTable21
	movwf	SysStringA
	movlw	(high StringTable21) & 127
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
;For [word]TableLoc = TableStartPoint to SizeofTable1
	movlw	1
	banksel	TABLESTARTPOINT
	subwf	TABLESTARTPOINT,W
	movwf	TABLELOC
	movlw	0
	subwfb	TABLESTARTPOINT_H,W
	movwf	TABLELOC_H
	movf	TABLESTARTPOINT,W
	movwf	SysWORDTempB
	movf	TABLESTARTPOINT_H,W
	movwf	SysWORDTempB_H
	movlw	35
	movwf	SysWORDTempA
	movlw	5
	movwf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd7
SysForLoop7
	banksel	TABLELOC
	incf	TABLELOC,F
	btfsc	STATUS,Z
	incf	TABLELOC_H,F
;eth_counter += 1
	banksel	ETH_COUNTER
	incf	ETH_COUNTER,F
;ReadTable ivalid1, TableLoc, commandlineString(eth_counter)
	movlw	low(COMMANDLINESTRING)
	addwf	ETH_COUNTER,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP3
	movwf	SysTemp3
	movlw	high(COMMANDLINESTRING)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movf	TABLELOC,W
	movwf	SYSSTRINGA
	movf	TABLELOC_H,W
	movwf	SYSSTRINGA_H
	banksel	STATUS
	pagesel	IVALID1
	call	IVALID1
	pagesel	$
	movwf	INDF0
;commandlineString(0) = eth_counter
	movf	ETH_COUNTER,W
	banksel	SYSCOMMANDLINESTRING_0
	movwf	SYSCOMMANDLINESTRING_0
;eth_counter = eth_counter % 12
	banksel	ETH_COUNTER
	movf	ETH_COUNTER,W
	movwf	SysBYTETempA
	movlw	12
	movwf	SysBYTETempB
	pagesel	SysDivSub
	call	SysDivSub
	pagesel	$
	movf	SysBYTETempX,W
	movwf	ETH_COUNTER
;if eth_counter = 0 then
	movf	ETH_COUNTER,F
	btfss	STATUS, Z
	goto	ENDIF76
;HTTPPrint( commandlineString )
	movlw	low COMMANDLINESTRING
	banksel	SYSHTTPDATAHANDLER
	movwf	SysHTTPDATAHandler
	movlw	high COMMANDLINESTRING
	movwf	SysHTTPDATAHandler_H
	banksel	HTTPPRINTCRLFFLAG
	clrf	HTTPPRINTCRLFFLAG
	call	HTTPPRINT
;if HTTPSentTCPPacket = 1 then
	decf	HTTPSENTTCPPACKET,W
	btfss	STATUS, Z
	goto	ENDIF79
;HSerPrint "exiting@1 "
;TableStartPoint = TableLoc - 11
	movlw	11
	banksel	TABLELOC
	subwf	TABLELOC,W
	movwf	TABLESTARTPOINT
	movlw	0
	subwfb	TABLELOC_H,W
	movwf	TABLESTARTPOINT_H
;HTTPSentTCPPacket = 0
	banksel	HTTPSENTTCPPACKET
	clrf	HTTPSENTTCPPACKET
;exit sub
	return
;end if
ENDIF79
;commandlineString = ""
	movlw	low COMMANDLINESTRING
	movwf	FSR1L
	movlw	high COMMANDLINESTRING
	movwf	FSR1H
	movlw	low StringTable21
	movwf	SysStringA
	movlw	(high StringTable21) & 127
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
;end if
ENDIF76
;Next
	banksel	TABLELOC
	movf	TABLELOC,W
	movwf	SysWORDTempA
	movf	TABLELOC_H,W
	movwf	SysWORDTempA_H
	movlw	35
	movwf	SysWORDTempB
	movlw	5
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop7
SysForLoopEnd7
;eth_counter = eth_counter - 2
;if eth_counter <> 0 then
	movf	ETH_COUNTER,F
	btfsc	STATUS, Z
	goto	ENDIF78
;ReadTable ivalid1, TableLoc, commandlineString( eth_counter )
	movlw	low(COMMANDLINESTRING)
	addwf	ETH_COUNTER,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP3
	movwf	SysTemp3
	movlw	high(COMMANDLINESTRING)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movf	TABLELOC,W
	movwf	SYSSTRINGA
	movf	TABLELOC_H,W
	movwf	SYSSTRINGA_H
	banksel	STATUS
	pagesel	IVALID1
	call	IVALID1
	pagesel	$
	movwf	INDF0
;commandlineString(0) = eth_counter
	movf	ETH_COUNTER,W
	banksel	SYSCOMMANDLINESTRING_0
	movwf	SYSCOMMANDLINESTRING_0
;HTTPPrint( commandlineString )
	movlw	low COMMANDLINESTRING
	banksel	SYSHTTPDATAHANDLER
	movwf	SysHTTPDATAHandler
	movlw	high COMMANDLINESTRING
	movwf	SysHTTPDATAHandler_H
	banksel	HTTPPRINTCRLFFLAG
	clrf	HTTPPRINTCRLFFLAG
	call	HTTPPRINT
;if HTTPSentTCPPacket = 1 then
	decf	HTTPSENTTCPPACKET,W
	btfss	STATUS, Z
	goto	ENDIF80
;HSerPrint "exiting@2 "
;TableStartPoint = TableLoc
	banksel	TABLELOC
	movf	TABLELOC,W
	movwf	TABLESTARTPOINT
	movf	TABLELOC_H,W
	movwf	TABLESTARTPOINT_H
;exit sub
	banksel	STATUS
	return
;end if
ENDIF80
;end if
ENDIF78
;HSerPrint "HTTPSend@3"
;HTTPSend
	movlw	255
	movwf	HTTPCLOSETRANSACTION
	call	HTTPSEND
;commandlineString="index.htm"
	movlw	low COMMANDLINESTRING
	movwf	FSR1L
	movlw	high COMMANDLINESTRING
	movwf	FSR1H
	movlw	low StringTable18
	movwf	SysStringA
	movlw	(high StringTable18) & 127
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
;End If
ENDIF73
;End If
ENDIF72
;End If
ENDIF71
;End If
ENDIF70
	banksel	STATUS
	return

;********************************************************************************

HTTPPART4
;' If an ACK and FIN is received and the destination port address is valid
;If Tcp_ack = 1 Then
	banksel	SYSBITVAR0
	btfss	SYSBITVAR0,5
	goto	ENDIF81
;If Tcp_fin = 1 Then
	btfss	SYSBITVAR0,1
	goto	ENDIF82
;HSerPrint "ack&fin"
;HSerPrintCRLF
;'set flags
;Tcp_flags = 0
	banksel	SYSETHERBUFFER_48
	clrf	SYSETHERBUFFER_48
;Tcp_flags.4 = 1                           'ack
	bsf	SYSETHERBUFFER_48,4
;T_ip_destaddr0 = T_ip_srcaddr0
	banksel	SYSETHERBUFFER_27
	movf	SYSETHERBUFFER_27,W
	movwf	SYSETHERBUFFER_31
;T_ip_destaddr1 = T_ip_srcaddr1
	movf	SYSETHERBUFFER_28,W
	movwf	SYSETHERBUFFER_32
;T_ip_destaddr2 = T_ip_srcaddr2
	movf	SYSETHERBUFFER_29,W
	movwf	SYSETHERBUFFER_33
;T_ip_destaddr3 = T_ip_srcaddr3
	movf	SYSETHERBUFFER_30,W
	movwf	SYSETHERBUFFER_34
;T_ip_srcaddr0 = ipaddr(1)
	banksel	SYSIPADDR_1
	movf	SYSIPADDR_1,W
	banksel	SYSETHERBUFFER_27
	movwf	SYSETHERBUFFER_27
;T_ip_srcaddr1 = ipaddr(2)
	banksel	SYSIPADDR_2
	movf	SYSIPADDR_2,W
	banksel	SYSETHERBUFFER_28
	movwf	SYSETHERBUFFER_28
;T_ip_srcaddr2 = ipaddr(3)
	banksel	SYSIPADDR_3
	movf	SYSIPADDR_3,W
	banksel	SYSETHERBUFFER_29
	movwf	SYSETHERBUFFER_29
;T_ip_srcaddr3 = ipaddr(4)
	banksel	SYSIPADDR_4
	movf	SYSIPADDR_4,W
	banksel	SYSETHERBUFFER_30
	movwf	SYSETHERBUFFER_30
;Swap Tcp_srcportl , Tcp_destportl
	movf	SYSETHERBUFFER_36,W
	movwf	SYSCALCTEMPA
	movf	SYSETHERBUFFER_38,W
	movwf	SYSCALCTEMPB
	banksel	STATUS
	pagesel	SWAP98
	call	SWAP98
	pagesel	$
	movf	SYSCALCTEMPA,W
	banksel	SYSETHERBUFFER_36
	movwf	SYSETHERBUFFER_36
	movf	SYSCALCTEMPB,W
	movwf	SYSETHERBUFFER_38
;Swap Tcp_srcporth , Tcp_destporth
	movf	SYSETHERBUFFER_35,W
	movwf	SYSCALCTEMPA
	movf	SYSETHERBUFFER_37,W
	movwf	SYSCALCTEMPB
	banksel	STATUS
	pagesel	SWAP98
	call	SWAP98
	pagesel	$
	movf	SYSCALCTEMPA,W
	banksel	SYSETHERBUFFER_35
	movwf	SYSETHERBUFFER_35
	movf	SYSCALCTEMPB,W
	movwf	SYSETHERBUFFER_37
;'swap mac
;ENC28j60_Packetshape
	banksel	STATUS
	call	ENC28J60_PACKETSHAPE
;[byte]Client_seqnum_E = Tcp_seqnum3
	banksel	SYSETHERBUFFER_39
	movf	SYSETHERBUFFER_39,W
	banksel	CLIENT_SEQNUM_E
	movwf	CLIENT_SEQNUM_E
;[byte]Client_seqnum_U = Tcp_seqnum2
	banksel	SYSETHERBUFFER_40
	movf	SYSETHERBUFFER_40,W
	banksel	CLIENT_SEQNUM_U
	movwf	CLIENT_SEQNUM_U
;[byte]Client_seqnum_H = Tcp_seqnum1
	banksel	SYSETHERBUFFER_41
	movf	SYSETHERBUFFER_41,W
	banksel	CLIENT_SEQNUM_H
	movwf	CLIENT_SEQNUM_H
;[byte]Client_seqnum   = Tcp_seqnum0
	banksel	SYSETHERBUFFER_42
	movf	SYSETHERBUFFER_42,W
	banksel	CLIENT_SEQNUM
	movwf	CLIENT_SEQNUM
;Tcp_seqnum0 = Tcp_acknum0
	banksel	SYSETHERBUFFER_46
	movf	SYSETHERBUFFER_46,W
	banksel	SYSETHERBUFFER_42
	movwf	SYSETHERBUFFER_42
;Tcp_seqnum1 = Tcp_acknum1
	banksel	SYSETHERBUFFER_45
	movf	SYSETHERBUFFER_45,W
	banksel	SYSETHERBUFFER_41
	movwf	SYSETHERBUFFER_41
;Tcp_seqnum2 = Tcp_acknum2
	movf	SYSETHERBUFFER_44,W
	movwf	SYSETHERBUFFER_40
;Tcp_seqnum3 = Tcp_acknum3
	movf	SYSETHERBUFFER_43,W
	movwf	SYSETHERBUFFER_39
;Client_seqnum = Client_seqnum + 1
	banksel	CLIENT_SEQNUM
	incf	CLIENT_SEQNUM,F
;Tcp_acknum0 = Client_seqnum
	movf	CLIENT_SEQNUM,W
	banksel	SYSETHERBUFFER_46
	movwf	SYSETHERBUFFER_46
;Tcp_acknum1 = Client_seqnum_H
	banksel	CLIENT_SEQNUM_H
	movf	CLIENT_SEQNUM_H,W
	banksel	SYSETHERBUFFER_45
	movwf	SYSETHERBUFFER_45
;Tcp_acknum2 = Client_seqnum_U
	banksel	CLIENT_SEQNUM_U
	movf	CLIENT_SEQNUM_U,W
	banksel	SYSETHERBUFFER_44
	movwf	SYSETHERBUFFER_44
;Tcp_acknum3 = Client_seqnum_E
	banksel	CLIENT_SEQNUM_E
	movf	CLIENT_SEQNUM_E,W
	banksel	SYSETHERBUFFER_43
	movwf	SYSETHERBUFFER_43
;etherBuffer(17) = 0
	clrf	SYSETHERBUFFER_17
;etherBuffer(18) = 40
	movlw	40
	movwf	SYSETHERBUFFER_18
;'5 x 4 = 20 bytes
;etherBuffer(47) = 0x50
	movlw	80
	banksel	SYSETHERBUFFER_47
	movwf	SYSETHERBUFFER_47
;'flag ACK
;etherBuffer(48) = 0x10
	movlw	16
	movwf	SYSETHERBUFFER_48
;
;etherBuffer(49) = 0x00
	clrf	SYSETHERBUFFER_49
;etherBuffer(50) = 0x72
	movlw	114
	movwf	SYSETHERBUFFER_50
;'padding
;etherBuffer(55) = 0x00
	clrf	SYSETHERBUFFER_55
;etherBuffer(56) = 0x00
	clrf	SYSETHERBUFFER_56
;etherBuffer(57) = 0x00
	clrf	SYSETHERBUFFER_57
;etherBuffer(58) = 0x00
	clrf	SYSETHERBUFFER_58
;etherBuffer(59) = 0x00
	clrf	SYSETHERBUFFER_59
;etherBuffer(60) = 0x00
	clrf	SYSETHERBUFFER_60
;ENC28j60_ip_header_checksum
	banksel	STATUS
	call	ENC28J60_IP_HEADER_CHECKSUM
;ENC28j60_tcp_checksum
	pagesel	ENC28J60_TCP_CHECKSUM
	call	ENC28J60_TCP_CHECKSUM
	pagesel	$
;T_ip_pktlen0 = 0
	banksel	SYSETHERBUFFER_17
	clrf	SYSETHERBUFFER_17
;T_ip_pktlen1 = 40
	movlw	40
	movwf	SYSETHERBUFFER_18
;ENC28j60_writebuffer(60)
	movlw	60
	banksel	PCKTLEN
	movwf	PCKTLEN
	clrf	PCKTLEN_H
	banksel	STATUS
	call	ENC28J60_WRITEBUFFER
;ENC28j60_packetsend(60)
	movlw	60
	banksel	PCKTLEN
	movwf	PCKTLEN
	clrf	PCKTLEN_H
	banksel	STATUS
	call	ENC28J60_PACKETSEND
;End If
ENDIF82
;End If
ENDIF81
	banksel	STATUS
	return

;********************************************************************************

HTTPPRINT
;HSerPrint HTTPData
;HSerPrintCRLF
;dim hulp2 as word
;hulp2 = arrayloc + HTTPData(0) + 6
	banksel	SYSHTTPDATAHANDLER
	movf	SysHTTPDATAHandler,W
	movwf	AFSR0
	movf	SysHTTPDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	ARRAYLOC
	addwf	ARRAYLOC,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	0
	banksel	ARRAYLOC_H
	addwfc	ARRAYLOC_H,W
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H
	movlw	6
	addwf	SysTemp2,W
	banksel	HULP2
	movwf	HULP2
	movlw	0
	banksel	SYSTEMP2_H
	addwfc	SysTemp2_H,W
	banksel	HULP2_H
	movwf	HULP2_H
;If hulp2 > etherBufferSize Then
	movf	HULP2,W
	movwf	SysWORDTempB
	movf	HULP2_H,W
	movwf	SysWORDTempB_H
	movlw	218
	movwf	SysWORDTempA
	movlw	2
	movwf	SysWORDTempA_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF83
;HTTPSend ( false )
	clrf	HTTPCLOSETRANSACTION
	call	HTTPSEND
;arrayloc = 0x0037   'start of HTTP header within the TCP Packet
	movlw	55
	movwf	ARRAYLOC
	clrf	ARRAYLOC_H
;HTTPSentTCPPacket = 1
	movlw	1
	movwf	HTTPSENTTCPPACKET
;End IF
ENDIF83
;For currbyte = 1 to HTTPData(0)
	clrf	CURRBYTE
	banksel	SYSHTTPDATAHANDLER
	movf	SysHTTPDATAHandler,W
	movwf	AFSR0
	movf	SysHTTPDATAHandler_H,W
	movwf	AFSR0_H
	movlw	1
	subwf	INDF0,W
	btfss	STATUS, C
	goto	SysForLoopEnd8
SysForLoop8
	banksel	CURRBYTE
	incf	CURRBYTE,F
;etherBuffer(arrayloc) = HTTPData(currbyte)
	movf	CURRBYTE,W
	banksel	SYSHTTPDATAHANDLER
	addwf	SysHTTPDATAHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysHTTPDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SysArrayTemp1
	movwf	SysArrayTemp2
	movlw	low(ETHERBUFFER)
	banksel	ARRAYLOC
	addwf	ARRAYLOC,W
	movwf	AFSR0
	movlw	high(ETHERBUFFER)
	addwfc	ARRAYLOC_H,W
	movwf	AFSR0_H
	banksel	SYSARRAYTEMP2
	movf	SysArrayTemp2,W
	movwf	INDF0
;arrayloc += 1
	banksel	ARRAYLOC
	incf	ARRAYLOC,F
	btfsc	STATUS,Z
	incf	ARRAYLOC_H,F
;Next
	banksel	SYSHTTPDATAHANDLER
	movf	SysHTTPDATAHandler,W
	movwf	AFSR0
	movf	SysHTTPDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	CURRBYTE
	subwf	CURRBYTE,W
	btfss	STATUS, C
	goto	SysForLoop8
SysForLoopEnd8
;if HTTPPrintCRLFflag = 1 then
	banksel	HTTPPRINTCRLFFLAG
	decf	HTTPPRINTCRLFFLAG,W
	btfss	STATUS, Z
	goto	ENDIF86
;etherBuffer(arrayloc) = 0x0d: arrayloc += 1
	movlw	low(ETHERBUFFER)
	addwf	ARRAYLOC,W
	movwf	AFSR0
	movlw	high(ETHERBUFFER)
	addwfc	ARRAYLOC_H,W
	movwf	AFSR0_H
	movlw	13
	movwf	INDF0
	incf	ARRAYLOC,F
	btfsc	STATUS,Z
	incf	ARRAYLOC_H,F
;etherBuffer(arrayloc) = 0x0a: arrayloc += 1
	movlw	low(ETHERBUFFER)
	addwf	ARRAYLOC,W
	movwf	AFSR0
	movlw	high(ETHERBUFFER)
	addwfc	ARRAYLOC_H,W
	movwf	AFSR0_H
	movlw	10
	movwf	INDF0
	incf	ARRAYLOC,F
	btfsc	STATUS,Z
	incf	ARRAYLOC_H,F
;end if
ENDIF86
	return

;********************************************************************************

HTTPSEND
;HSerPrintCRLF
;HSerPrint "HTTPSend = "
;HSerPrintCRLF HTTPCloseTransaction
;Tcp_flags = 0
	banksel	SYSETHERBUFFER_48
	clrf	SYSETHERBUFFER_48
;Tcp_flags.4  = 1                          'ack
	bsf	SYSETHERBUFFER_48,4
;if HTTPCloseTransaction = true then
	banksel	HTTPCLOSETRANSACTION
	incf	HTTPCLOSETRANSACTION,W
	btfss	STATUS, Z
	goto	ELSE87_1
;Tcp_flags.3  = 1                          'psh
	banksel	SYSETHERBUFFER_48
	bsf	SYSETHERBUFFER_48,3
;Tcp_flags.0  = 1                          'fin
	bsf	SYSETHERBUFFER_48,0
;etherBuffer(arrayloc) = 0x0d: arrayloc = arrayloc +1
	movlw	low(ETHERBUFFER)
	banksel	ARRAYLOC
	addwf	ARRAYLOC,W
	movwf	AFSR0
	movlw	high(ETHERBUFFER)
	addwfc	ARRAYLOC_H,W
	movwf	AFSR0_H
	movlw	13
	movwf	INDF0
	incf	ARRAYLOC,F
	btfsc	STATUS,Z
	incf	ARRAYLOC_H,F
;etherBuffer(arrayloc) = 0x0a: arrayloc = arrayloc +1
	movlw	low(ETHERBUFFER)
	addwf	ARRAYLOC,W
	movwf	AFSR0
	movlw	high(ETHERBUFFER)
	addwfc	ARRAYLOC_H,W
	movwf	AFSR0_H
	movlw	10
	movwf	INDF0
	incf	ARRAYLOC,F
	btfsc	STATUS,Z
	incf	ARRAYLOC_H,F
;etherBuffer(arrayloc) = 0x0d: arrayloc = arrayloc +1
	movlw	low(ETHERBUFFER)
	addwf	ARRAYLOC,W
	movwf	AFSR0
	movlw	high(ETHERBUFFER)
	addwfc	ARRAYLOC_H,W
	movwf	AFSR0_H
	movlw	13
	movwf	INDF0
	incf	ARRAYLOC,F
	btfsc	STATUS,Z
	incf	ARRAYLOC_H,F
;etherBuffer(arrayloc) = 0x0a: arrayloc = arrayloc +1
	movlw	low(ETHERBUFFER)
	addwf	ARRAYLOC,W
	movwf	AFSR0
	movlw	high(ETHERBUFFER)
	addwfc	ARRAYLOC_H,W
	movwf	AFSR0_H
	movlw	10
	movwf	INDF0
	incf	ARRAYLOC,F
	btfsc	STATUS,Z
	incf	ARRAYLOC_H,F
;arrayloc = arrayloc - 1
	movlw	1
	subwf	ARRAYLOC,F
	movlw	0
	subwfb	ARRAYLOC_H,F
;if arrayloc Mod 2 = 0 then
	movf	ARRAYLOC,W
	movwf	SysWORDTempA
	movf	ARRAYLOC_H,W
	movwf	SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysDivSub16
	movf	SysWORDTempX,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movf	SysWORDTempX_H,W
	movwf	SysTemp2_H
	movf	SysTemp2,W
	movwf	SysWORDTempA
	movf	SysTemp2_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF88
;arrayloc += 1
	incf	ARRAYLOC,F
	btfsc	STATUS,Z
	incf	ARRAYLOC_H,F
;etherBuffer(arrayloc) = 0x00 'added to pad out, should the
	movlw	low(ETHERBUFFER)
	addwf	ARRAYLOC,W
	movwf	AFSR0
	movlw	high(ETHERBUFFER)
	addwfc	ARRAYLOC_H,W
	movwf	AFSR0_H
	clrf	INDF0
;end if
ENDIF88
;Ackpsh = 0
	clrf	ACKPSH
;
;HSerPrintCRLF
;FOR hulp2 = 0X0037 TO arrayloc
;HSerSend etherbuffer(HULP2)
;Next
;HSerPrintCRLF
;Else
	goto	ENDIF87
ELSE87_1
;arrayloc = arrayloc - 1
	movlw	1
	subwf	ARRAYLOC,F
	movlw	0
	subwfb	ARRAYLOC_H,F
;Tcp_flags.3  = 0                          'psh
	banksel	SYSETHERBUFFER_48
	bcf	SYSETHERBUFFER_48,3
;Tcp_flags.0  = 0
	bcf	SYSETHERBUFFER_48,0
;end if
ENDIF87
;Tcp_acknum0 = Incoming_ack
	banksel	INCOMING_ACK
	movf	INCOMING_ACK,W
	banksel	SYSETHERBUFFER_46
	movwf	SYSETHERBUFFER_46
;Tcp_acknum1 = Incoming_ack_H
	banksel	INCOMING_ACK_H
	movf	INCOMING_ACK_H,W
	banksel	SYSETHERBUFFER_45
	movwf	SYSETHERBUFFER_45
;Tcp_acknum2 = Incoming_ack_U
	banksel	INCOMING_ACK_U
	movf	INCOMING_ACK_U,W
	banksel	SYSETHERBUFFER_44
	movwf	SYSETHERBUFFER_44
;Tcp_acknum3 = Incoming_ack_E
	banksel	INCOMING_ACK_E
	movf	INCOMING_ACK_E,W
	banksel	SYSETHERBUFFER_43
	movwf	SYSETHERBUFFER_43
;TCPresult16 = [word]arrayloc - [byte]IP_HeaderSize
	movlw	14
	banksel	ARRAYLOC
	subwf	ARRAYLOC,W
	banksel	TCPRESULT16
	movwf	TCPRESULT16
	movlw	0
	banksel	ARRAYLOC_H
	subwfb	ARRAYLOC_H,W
	banksel	TCPRESULT16_H
	movwf	TCPRESULT16_H
;T_ip_pktlen0 = TCPresult16_H                             'HTML-code + 40
	banksel	SYSETHERBUFFER_17
	movwf	SYSETHERBUFFER_17
;T_ip_pktlen1 = TCPresult16
	banksel	TCPRESULT16
	movf	TCPRESULT16,W
	banksel	SYSETHERBUFFER_18
	movwf	SYSETHERBUFFER_18
;ENC28j60_ip_header_checksum
	banksel	STATUS
	call	ENC28J60_IP_HEADER_CHECKSUM
;ENC28j60_tcp_checksum
	pagesel	ENC28J60_TCP_CHECKSUM
	call	ENC28J60_TCP_CHECKSUM
	pagesel	$
;ENC28j60_writebuffer( TCPresult16 + IP_HeaderSize   )
	movlw	14
	banksel	TCPRESULT16
	addwf	TCPRESULT16,W
	movwf	PCKTLEN
	movlw	0
	addwfc	TCPRESULT16_H,W
	movwf	PCKTLEN_H
	banksel	STATUS
	call	ENC28J60_WRITEBUFFER
;ENC28j60_packetsend( TCPresult16 + IP_HeaderSize   )
	movlw	14
	banksel	TCPRESULT16
	addwf	TCPRESULT16,W
	movwf	PCKTLEN
	movlw	0
	addwfc	TCPRESULT16_H,W
	movwf	PCKTLEN_H
	banksel	STATUS
	goto	ENC28J60_PACKETSEND

;********************************************************************************

INITSYS
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
;C2ON = 0
	banksel	CM2CON0
	bcf	CM2CON0,C2ON
;C1ON = 0
	bcf	CM1CON0,C1ON
;PORTA = 0
	banksel	PORTA
	clrf	PORTA
;PORTB = 0
	clrf	PORTB
;PORTC = 0
	clrf	PORTC
;PORTE = 0
	clrf	PORTE
	return

;********************************************************************************

;Overloaded signature: BYTE:BYTE:
SPIMODE215
;Dim SSPCON1 Alias SSP1CON1 ;added for 18f18855
;Dim SSPSTAT Alias SSP1STAT ;added for 18f18855
;Dim SSPBUF Alias SSP1BUF
;Set SSPCON1.SSPEN Off ;(Prevents any weird glitches during setup)
	banksel	SSPCON1
	bcf	SSPCON1,SSPEN
;Set SSPSTAT.SMP Off
	bcf	SSPSTAT,SMP
;Set SSPSTAT.CKE Off
	bcf	SSPSTAT,CKE
;If SPIClockMode.0 = Off Then
	banksel	SPICLOCKMODE
	btfsc	SPICLOCKMODE,0
	goto	ENDIF13
;Set SSPSTAT.CKE On
	banksel	SSPSTAT
	bsf	SSPSTAT,CKE
;End If
ENDIF13
;Set SSPCON1.CKP Off
	banksel	SSPCON1
	bcf	SSPCON1,CKP
;If SPIClockMode.1 = On Then
	banksel	SPICLOCKMODE
	btfss	SPICLOCKMODE,1
	goto	ENDIF14
;Set SSPCON1.CKP On
	banksel	SSPCON1
	bsf	SSPCON1,CKP
;End If
ENDIF14
;Set SSPCON1.SSPM3 Off
	banksel	SSPCON1
	bcf	SSPCON1,SSPM3
;Set SSPCON1.SSPM2 Off
	bcf	SSPCON1,SSPM2
;Set SSPCON1.SSPM1 Off
	bcf	SSPCON1,SSPM1
;Set SSPCON1.SSPM0 Off
	bcf	SSPCON1,SSPM0
;Select Case SPICurrentMode
;Case MasterFast
SysSelect2Case1
	movlw	13
	banksel	SPICURRENTMODE
	subwf	SPICURRENTMODE,W
	btfss	STATUS, Z
	goto	SysSelect2Case2
;Case Master
	goto	SysSelectEnd2
SysSelect2Case2
	movlw	12
	subwf	SPICURRENTMODE,W
	btfss	STATUS, Z
	goto	SysSelect2Case3
;Set SSPCON1.SSPM0 On
	banksel	SSPCON1
	bsf	SSPCON1,SSPM0
;Case MasterSlow
	goto	SysSelectEnd2
SysSelect2Case3
	movlw	11
	subwf	SPICURRENTMODE,W
	btfss	STATUS, Z
	goto	SysSelect2Case4
;Set SSPCON1.SSPM1 On
	banksel	SSPCON1
	bsf	SSPCON1,SSPM1
;Case Slave
	goto	SysSelectEnd2
SysSelect2Case4
	movf	SPICURRENTMODE,F
	btfss	STATUS, Z
	goto	SysSelect2Case5
;Set SSPCON1.SSPM2 On
	banksel	SSPCON1
	bsf	SSPCON1,SSPM2
;Set SSPCON1.SSPM0 On
	bsf	SSPCON1,SSPM0
;Case SlaveSS
	goto	SysSelectEnd2
SysSelect2Case5
	decf	SPICURRENTMODE,W
	btfss	STATUS, Z
	goto	SysSelect2Case6
;Set SSPCON1.SSPM2 On
	banksel	SSPCON1
	bsf	SSPCON1,SSPM2
;End Select
SysSelect2Case6
SysSelectEnd2
;Set SSPCON1.SSPEN On
	banksel	SSPCON1
	bsf	SSPCON1,SSPEN
	banksel	STATUS
	return

;********************************************************************************

SYSDIVSUB16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;dim SysDivMultA as word
;dim SysDivMultB as word
;dim SysDivMultX as word
;SysDivMultA = SysWordTempA
	movf	SYSWORDTEMPA,W
	movwf	SYSDIVMULTA
	movf	SYSWORDTEMPA_H,W
	movwf	SYSDIVMULTA_H
;SysDivMultB = SysWordTempB
	movf	SYSWORDTEMPB,W
	movwf	SYSDIVMULTB
	movf	SYSWORDTEMPB_H,W
	movwf	SYSDIVMULTB_H
;SysDivMultX = 0
	clrf	SYSDIVMULTX
	clrf	SYSDIVMULTX_H
;if SysDivMultB = 0 then
	movf	SYSDIVMULTB,W
	movwf	SysWORDTempA
	movf	SYSDIVMULTB_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF91
;SysWordTempA = 0
	clrf	SYSWORDTEMPA
	clrf	SYSWORDTEMPA_H
;exit sub
	return
;end if
ENDIF91
;SysDivLoop = 16
	movlw	16
	movwf	SYSDIVLOOP
SYSDIV16START
;set C off
	bcf	STATUS,C
;Rotate SysDivMultA Left
	rlf	SYSDIVMULTA,F
	rlf	SYSDIVMULTA_H,F
;Rotate SysDivMultX Left
	rlf	SYSDIVMULTX,F
	rlf	SYSDIVMULTX_H,F
;SysDivMultX = SysDivMultX - SysDivMultB
	movf	SYSDIVMULTB,W
	subwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	subwfb	SYSDIVMULTX_H,F
;Set SysDivMultA.0 On
	bsf	SYSDIVMULTA,0
;If C Off Then
	btfsc	STATUS,C
	goto	ENDIF92
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	addwfc	SYSDIVMULTX_H,F
;End If
ENDIF92
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F
;goto SysDiv16Start
	goto	SYSDIV16START
;SysWordTempA = SysDivMultA
	movf	SYSDIVMULTA,W
	movwf	SYSWORDTEMPA
	movf	SYSDIVMULTA_H,W
	movwf	SYSWORDTEMPA_H
;SysWordTempX = SysDivMultX
	movf	SYSDIVMULTX,W
	movwf	SYSWORDTEMPX
	movf	SYSDIVMULTX_H,W
	movwf	SYSWORDTEMPX_H
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

StringTable4
	retlw	32
	retlw	69	;E
	retlw	78	;N
	retlw	67	;C
	retlw	50	;2
	retlw	56	;8
	retlw	106	;j
	retlw	54	;6
	retlw	48	;0
	retlw	32	; 
	retlw	69	;E
	retlw	116	;t
	retlw	104	;h
	retlw	101	;e
	retlw	114	;r
	retlw	110	;n
	retlw	101	;e
	retlw	116	;t
	retlw	32	; 
	retlw	68	;D
	retlw	114	;r
	retlw	105	;i
	retlw	118	;v
	retlw	101	;e
	retlw	114	;r
	retlw	32	; 
	retlw	48	;0
	retlw	51	;3
	retlw	49	;1
	retlw	95	;_
	retlw	48	;0
	retlw	48	;0
	retlw	52	;4


StringTable5
	retlw	11
	retlw	73	;I
	retlw	110	;n
	retlw	105	;i
	retlw	116	;t
	retlw	105	;i
	retlw	97	;a
	retlw	108	;l
	retlw	105	;i
	retlw	115	;s
	retlw	101	;e
	retlw	100	;d


StringTable18
	retlw	9
	retlw	105	;i
	retlw	110	;n
	retlw	100	;d
	retlw	101	;e
	retlw	120	;x
	retlw	46	;.
	retlw	104	;h
	retlw	116	;t
	retlw	109	;m


StringTable21
	retlw	0


StringTable49
	retlw	1
	retlw	46	;.


StringTable71
	retlw	15
	retlw	72	;H
	retlw	84	;T
	retlw	84	;T
	retlw	80	;P
	retlw	47	;/
	retlw	49	;1
	retlw	46	;.
	retlw	48	;0
	retlw	32	; 
	retlw	50	;2
	retlw	48	;0
	retlw	48	;0
	retlw	32	; 
	retlw	79	;O
	retlw	75	;K


;********************************************************************************

;Start of program memory page 3
	ORG	6144
Delay_MS
	incf	SysWaitTempMS_H, F
DMS_START
	movlw	14
	movwf	DELAYTEMP2
DMS_OUTER
	movlw	189
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

ENC28J60_POLL
;if ENC28j60_ReadReg( epktcnt ) > 0 Then
	movlw	57
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	sublw	0
	btfsc	STATUS, C
	goto	ENDIF7
;ENC28j60_packetreceive( etherBufferSize )
	movlw	218
	banksel	MAXLEN
	movwf	MAXLEN
	movlw	2
	movwf	MAXLEN_H
	banksel	STATUS
	pagesel	ENC28J60_PACKETRECEIVE
	call	ENC28J60_PACKETRECEIVE
	pagesel	$
;end if
ENDIF7
;if ENC28j60_ReadReg( EIR ) & 0x01 = 0X01 Then
	movlw	28
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	btfss	SysTemp1,0
	goto	ENDIF8
;ENC28j60_bitClear( EIR, EIR_RXERIF )
	movlw	28
	banksel	ADDR
	movwf	ADDR
	movlw	1
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_BITCLEAR
	call	ENC28J60_BITCLEAR
	pagesel	$
;goto Reset_ENC26j60
;end if
ENDIF8
	banksel	STATUS
	return

;********************************************************************************

ENC28J60_WRITEPHYREG
;		while ((ENC28j60_ReadReg(MISTAT) & MISTAT_BUSY ) = MISTAT_BUSY )
SysDoLoop_S2
	movlw	234
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
;ENC28j60_writeReg( MIREGADR, PhyRegaddr )
	movlw	212
	movwf	ADDR
	banksel	PHYREGADDR
	movf	PHYREGADDR,W
	banksel	ENC_OUTBYTE
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg( MIWRL, ENC_Outbyte1 )
	movlw	214
	movwf	ADDR
	movf	ENC_OUTBYTE1,W
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28j60_writeReg( MIWRH, ENC_Outbyte2 )
	movlw	215
	movwf	ADDR
	movf	ENC_OUTBYTE2,W
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;wait while ( (ENC28j60_ReadReg( MISTAT ) & MISTAT_BUSY ) = MISTAT_BUSY )
SysWaitLoop6
	movlw	234
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movlw	1
	andwf	ENC28J60_READREG,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movwf	SysBYTETempA
	movlw	1
	movwf	SysBYTETempB
	banksel	STATUS
	call	SysCompEqual
	btfsc	SysByteTempX,0
	goto	SysWaitLoop6
	return

;********************************************************************************

FASTHWSPITRANSFER
;Set SSPCON1.WCOL Off
	banksel	SSPCON1
	bcf	SSPCON1,WCOL
;SSPBUF = SPITxData
	banksel	SPITXDATA
	movf	SPITXDATA,W
	banksel	SSPBUF
	movwf	SSPBUF
;Wait While SSPSTAT.BF = Off
SysWaitLoop7
	btfss	SSPSTAT,BF
	goto	SysWaitLoop7
;Set SSPSTAT.BF Off
	bcf	SSPSTAT,BF
;SPIRxData = SSPBUF
	movf	SSPBUF,W
	banksel	SPIRXDATA
	movwf	SPIRXDATA
	banksel	STATUS
	return

;********************************************************************************

FN_FNLSL
;dim SysLongTempB as long
;SysLongTempB  = BitsIn
;Repeat NumBits
	banksel	NUMBITS
	movf	NUMBITS,W
	movwf	SysRepeatTemp9
	btfsc	STATUS,Z
	goto	SysRepeatLoopEnd9
SysRepeatLoop9
;Set C Off
	bcf	STATUS,C
;Rotate SysLongTempB Left
	rlf	SYSLONGTEMPB,F
	rlf	SYSLONGTEMPB_H,F
	rlf	SYSLONGTEMPB_U,F
	rlf	SYSLONGTEMPB_E,F
;End Repeat
	decfsz	SysRepeatTemp9,F
	goto	SysRepeatLoop9
SysRepeatLoopEnd9
;FnLSL = SysLongTempB
	movf	SYSLONGTEMPB,W
	banksel	FNLSL
	movwf	FNLSL
	movf	SYSLONGTEMPB_H,W
	movwf	FNLSL_H
	movf	SYSLONGTEMPB_U,W
	movwf	FNLSL_U
	movf	SYSLONGTEMPB_E,W
	movwf	FNLSL_E
	return

;********************************************************************************

HSERPRINTCRLF
;repeat HSerPrintCRLFCount
	movf	HSERPRINTCRLFCOUNT,W
	banksel	SYSREPEATTEMP4
	movwf	SysRepeatTemp4
	btfsc	STATUS,Z
	goto	SysRepeatLoopEnd4
SysRepeatLoop4
;HSerSend(13,comport)
	movlw	13
	movwf	SERDATA
	banksel	STATUS
	call	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;HSerSend(10,comport)
	movlw	10
	banksel	SERDATA
	movwf	SERDATA
	banksel	STATUS
	call	HSERSEND
;wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;end Repeat
	banksel	SYSREPEATTEMP4
	decfsz	SysRepeatTemp4,F
	goto	SysRepeatLoop4
SysRepeatLoopEnd4
	banksel	STATUS
	return

;********************************************************************************

HSERSEND
;if comport = 1 Then
	decf	COMPORT,W
	btfss	STATUS, Z
	goto	ENDIF15
;Wait While TXIF = Off
SysWaitLoop8
	banksel	PIR3
	btfss	PIR3,TXIF
	goto	SysWaitLoop8
;Wait While TXIF = Off
SysWaitLoop9
	btfss	PIR3,TXIF
	goto	SysWaitLoop9
;TXREG1 = SerData
	banksel	SERDATA
	movf	SERDATA,W
	banksel	TXREG1
	movwf	TXREG1
;end if
ENDIF15
	banksel	STATUS
	return

;********************************************************************************

HTTPPRINTSTANDARDHEADER
;HTTPPrint( "HTTP/1.0 200 OK", HTTPPrintCRLF )
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable71
	movwf	SysStringA
	movlw	(high StringTable71) & 127
	movwf	SysStringA_H
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSHTTPDATAHANDLER
	movwf	SysHTTPDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H
	movlw	1
	banksel	HTTPPRINTCRLFFLAG
	movwf	HTTPPRINTCRLFFLAG
	pagesel	HTTPPRINT
	call	HTTPPRINT
	pagesel	$
;HTTPPrint( "X-Pad: avoid browser bug", HTTPPrintCRLF )
;bad        HTTPPrint( "Cache-Control: no-cache, no-store, must-revalidate", HTTPPrintCRLF )
;HTTPPrint( "Pragma: no-cache", HTTPPrintCRLF )
;HTTPPrint( "Content-Type: text/html", HTTPPrintCRLF )
;HTTPPrint( "<!DOCTYPE HTML>", HTTPPrintCRLF )
;HTTPPrint("Connection: close", HTTPPrintCRLF )
	return

;********************************************************************************

;Overloaded signature: BYTE:BYTE:
SWAP98
;SysCalcTempX = SysCalcTempA
	movf	SYSCALCTEMPA,W
	movwf	SYSCALCTEMPX
;SysCalcTempA = SysCalcTempB
	movf	SYSCALCTEMPB,W
	movwf	SYSCALCTEMPA
;SysCalcTempB = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SYSCALCTEMPB
	return

;********************************************************************************

SYSCOMPEQUAL
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;movf SysByteTempA, W
	movf	SYSBYTETEMPA, W
;subwf SysByteTempB, W
	subwf	SYSBYTETEMPB, W
;btfsc STATUS, Z
	btfsc	STATUS, Z
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

SYSCOMPLESSTHAN
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;bsf STATUS, C
	bsf	STATUS, C
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W
;subwf SysByteTempA, W
	subwf	SYSBYTETEMPA, W
;btfss STATUS, C
	btfss	STATUS, C
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

SYSCOMPLESSTHAN16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;movf SysWordTempA_H,W
	movf	SYSWORDTEMPA_H,W
;subwf SysWordTempB_H,W
	subwf	SYSWORDTEMPB_H,W
;btfss STATUS,C
	btfss	STATUS,C
;return
	return
;movf SysWordTempB_H,W
	movf	SYSWORDTEMPB_H,W
;subwf SysWordTempA_H,W
	subwf	SYSWORDTEMPA_H,W
;btfss STATUS,C
	btfss	STATUS,C
;goto SCLT16True
	goto	SCLT16TRUE
;movf SysWordTempB,W
	movf	SYSWORDTEMPB,W
;subwf SysWordTempA,W
	subwf	SYSWORDTEMPA,W
;btfsc STATUS,C
	btfsc	STATUS,C
;return
	return
SCLT16TRUE
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

SYSDIVSUB
;dim SysByteTempA as byte
;dim SysByteTempB as byte
;dim SysByteTempX as byte
;movf SysByteTempB, F
	movf	SYSBYTETEMPB, F
;btfsc STATUS, Z
	btfsc	STATUS, Z
;return
	return
;SysByteTempX = 0
	clrf	SYSBYTETEMPX
;SysDivLoop = 8
	movlw	8
	movwf	SYSDIVLOOP
SYSDIV8START
;bcf STATUS, C
	bcf	STATUS, C
;rlf SysByteTempA, F
	rlf	SYSBYTETEMPA, F
;rlf SysByteTempX, F
	rlf	SYSBYTETEMPX, F
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W
;subwf SysByteTempX, F
	subwf	SYSBYTETEMPX, F
;bsf SysByteTempA, 0
	bsf	SYSBYTETEMPA, 0
;btfsc STATUS, C
	btfsc	STATUS, C
;goto Div8NotNeg
	goto	DIV8NOTNEG
;bcf SysByteTempA, 0
	bcf	SYSBYTETEMPA, 0
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W
;addwf SysByteTempX, F
	addwf	SYSBYTETEMPX, F
DIV8NOTNEG
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F
;goto SysDiv8Start
	goto	SYSDIV8START
	return

;********************************************************************************

SYSMULTSUB16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;dim SysDivMultA as word
;dim SysDivMultB as word
;dim SysDivMultX as word
;SysDivMultA = SysWordTempA
	movf	SYSWORDTEMPA,W
	movwf	SYSDIVMULTA
	movf	SYSWORDTEMPA_H,W
	movwf	SYSDIVMULTA_H
;SysDivMultB = SysWordTempB
	movf	SYSWORDTEMPB,W
	movwf	SYSDIVMULTB
	movf	SYSWORDTEMPB_H,W
	movwf	SYSDIVMULTB_H
;SysDivMultX = 0
	clrf	SYSDIVMULTX
	clrf	SYSDIVMULTX_H
MUL16LOOP
;IF SysDivMultB.0 ON then SysDivMultX += SysDivMultA
	btfss	SYSDIVMULTB,0
	goto	ENDIF89
	movf	SYSDIVMULTA,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTA_H,W
	addwfc	SYSDIVMULTX_H,F
ENDIF89
;set STATUS.C OFF
	bcf	STATUS,C
;rotate SysDivMultB right
	rrf	SYSDIVMULTB_H,F
	rrf	SYSDIVMULTB,F
;set STATUS.C off
	bcf	STATUS,C
;rotate SysDivMultA left
	rlf	SYSDIVMULTA,F
	rlf	SYSDIVMULTA_H,F
;if SysDivMultB > 0 then goto MUL16LOOP
	movf	SYSDIVMULTB,W
	movwf	SysWORDTempB
	movf	SYSDIVMULTB_H,W
	movwf	SysWORDTempB_H
	clrf	SysWORDTempA
	clrf	SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0
	goto	MUL16LOOP
;SysWordTempX = SysDivMultX
	movf	SYSDIVMULTX,W
	movwf	SYSWORDTEMPX
	movf	SYSDIVMULTX_H,W
	movwf	SYSWORDTEMPX_H
	return

;********************************************************************************

SYSREADSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;call SysStringTables
	pagesel	SYSSTRINGTABLES
	call	SYSSTRINGTABLES
	pagesel	$
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA
;movwf INDF1
	movwf	INDF1
;goto SysStringReadCheck
	goto	SYSSTRINGREADCHECK
SYSREADSTRINGPART
;call SysStringTables
	pagesel	SYSSTRINGTABLES
	call	SYSSTRINGTABLES
	pagesel	$
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA
;addwf SysStringLength,F
	addwf	SYSSTRINGLENGTH,F
SYSSTRINGREADCHECK
;movf SysCalcTempA,F
	movf	SYSCALCTEMPA,F
;btfsc STATUS,Z
	btfsc	STATUS,Z
;return
	return
SYSSTRINGREAD
;call SysStringTables
	pagesel	SYSSTRINGTABLES
	call	SYSSTRINGTABLES
	pagesel	$
;addfsr 1,1
	addfsr	1,1
;movwf INDF1
	movwf	INDF1
;decfsz SysCalcTempA, F
	decfsz	SYSCALCTEMPA, F
;goto SysStringRead
	goto	SYSSTRINGREAD
	return

;********************************************************************************


 END
