;Program compiled by Great Cow BASIC (0.95 2016-06-01)
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F4520, r=DEC
#include <P18F4520.inc>
 CONFIG LVP = OFF, STVREN = OFF, MCLRE = ON, PBADEN = OFF, WDT = OFF, BOREN = OFF, PWRT = ON, OSC = HS

;********************************************************************************

;Set aside memory locations for variables
ACKPSH	EQU	13
ADDR	EQU	14
ARRAYLOC	EQU	15
ARRAYLOC_H	EQU	16
BANKTOBESELECTED	EQU	17
BUTTONSTATE	EQU	18
CLIENT_SEQNUM	EQU	19
CLIENT_SEQNUM_E	EQU	23
CLIENT_SEQNUM_H	EQU	24
CLIENT_SEQNUM_U	EQU	25
COMMANDLINESTRING	EQU	879
COMPORT	EQU	26
CURRBYTE	EQU	27
DEBUG01	EQU	28
DELAYTEMP	EQU	0
DELAYTEMP2	EQU	1
ENC28J60_DATA	EQU	29
ENC28J60_READREG	EQU	30
ENC28J60_TEMP	EQU	31
ENC_OUTBYTE	EQU	32
ENC_OUTBYTE1	EQU	33
ENC_OUTBYTE2	EQU	34
ENDPTR	EQU	35
ENDPTR_H	EQU	36
ETHERBUFFER	EQU	933
ETHERGETLENGTH	EQU	37
ETHERGETLENGTH_H	EQU	38
ETH_COUNTER	EQU	39
ETH_COUNTER_H	EQU	41
ETH_FRAMELENGTH	EQU	42
ETH_FRAMELENGTH_H	EQU	44
EXPECTED_ACK	EQU	45
EXPECTED_ACK_E	EQU	48
EXPECTED_ACK_H	EQU	46
EXPECTED_ACK_U	EQU	47
FLAGS	EQU	49
FNLSL	EQU	50
FNLSL_E	EQU	53
FNLSL_H	EQU	51
FNLSL_U	EQU	52
FNLSR	EQU	54
FNLSR_E	EQU	57
FNLSR_H	EQU	55
FNLSR_U	EQU	56
HSERPRINTCRLFCOUNT	EQU	58
HTMLMAPPING	EQU	59
HTMLMAPPINGTYPE	EQU	60
HTTPCLOSETRANSACTION	EQU	61
HTTPPRINTCRLFFLAG	EQU	62
HTTPSENTTCPPACKET	EQU	63
HTTPSTANDARDHEADERSTATUSBIT	EQU	64
HULP2	EQU	65
HULP2_H	EQU	67
HULP3	EQU	68
II	EQU	69
II_H	EQU	70
INCOMING_ACK	EQU	71
INCOMING_ACK_E	EQU	75
INCOMING_ACK_H	EQU	76
INCOMING_ACK_U	EQU	77
IPADDR	EQU	856
IPPORT	EQU	78
IPROUTER	EQU	851
IP_CHECKSUM16	EQU	79
IP_CHECKSUM16_H	EQU	80
IP_CHKSUM32	EQU	81
IP_CHKSUM32_E	EQU	84
IP_CHKSUM32_H	EQU	82
IP_CHKSUM32_U	EQU	83
IP_HEADER_LENGTH	EQU	85
IP_HULP1	EQU	86
IP_ID	EQU	87
IP_ID_H	EQU	89
IP_TEMP16	EQU	90
IP_TEMP16_H	EQU	91
IP_X	EQU	92
I_CHECKSUM16	EQU	93
I_CHECKSUM16_H	EQU	95
I_CHKSUM32	EQU	96
I_CHKSUM32_E	EQU	99
I_CHKSUM32_H	EQU	97
I_CHKSUM32_U	EQU	100
I_ODD	EQU	101
I_X	EQU	102
I_X_H	EQU	103
LASTGET	EQU	104
LASTSELECTEDBANK	EQU	105
LOCALTMP	EQU	106
LOCALTMP_H	EQU	108
MACADDR	EQU	861
MACADDRROUTER	EQU	846
MAXLEN	EQU	109
MAXLEN_H	EQU	110
MSG_TEMP2	EQU	868
NEXTPACKETPTR	EQU	111
NEXTPACKETPTR_H	EQU	113
NUMBITS	EQU	114
OUTVALUETEMP	EQU	115
PACKETLENGTH	EQU	116
PACKETLENGTH_H	EQU	118
PCKTLEN	EQU	119
PCKTLEN_H	EQU	120
PHYREGADDR	EQU	121
PREVIOUS_NEXTPACKETPTR	EQU	122
PREVIOUS_NEXTPACKETPTR_H	EQU	123
PRINTLEN	EQU	124
RESULT	EQU	125
RESULT_H	EQU	126
RXSTAT	EQU	127
RXSTAT_H	EQU	128
SERDATA	EQU	129
SERPRINTVAL	EQU	130
SERPRINTVAL_H	EQU	131
SNTPSERVERADDR	EQU	841
SPICLOCKMODE	EQU	132
SPICURRENTMODE	EQU	133
SPIRXDATA	EQU	134
SPITXDATA	EQU	135
STARTPTR	EQU	136
STARTPTR_H	EQU	137
STRINGPOINTER	EQU	138
SUM	EQU	139
SUM_E	EQU	142
SUM_H	EQU	140
SUM_U	EQU	141
SYSARRAYTEMP1	EQU	143
SYSARRAYTEMP2	EQU	144
SYSBITVAR0	EQU	145
SYSBYTETEMPA	EQU	5
SYSBYTETEMPB	EQU	9
SYSBYTETEMPX	EQU	0
SYSCALCTEMPA	EQU	5
SYSCALCTEMPB	EQU	9
SYSCALCTEMPX	EQU	0
SYSCALCTEMPX_H	EQU	1
SYSDIVLOOP	EQU	4
SYSDIVMULTA	EQU	7
SYSDIVMULTA_H	EQU	8
SYSDIVMULTB	EQU	11
SYSDIVMULTB_H	EQU	12
SYSDIVMULTX	EQU	2
SYSDIVMULTX_H	EQU	3
SYSFNBYTE1	EQU	146
SYSHTTPDATAHANDLER	EQU	147
SYSHTTPDATAHANDLER_H	EQU	148
SYSLONGTEMPB	EQU	9
SYSLONGTEMPB_E	EQU	12
SYSLONGTEMPB_H	EQU	10
SYSLONGTEMPB_U	EQU	11
SYSMACADDRHANDLER	EQU	149
SYSMACADDRHANDLER_H	EQU	150
SYSPRINTDATAHANDLER	EQU	151
SYSPRINTDATAHANDLER_H	EQU	152
SYSPRINTTEMP	EQU	153
SYSREPEATTEMP1	EQU	154
SYSREPEATTEMP2	EQU	155
SYSREPEATTEMP3	EQU	156
SYSREPEATTEMP4	EQU	157
SYSREPEATTEMP5	EQU	158
SYSREPEATTEMP6	EQU	159
SYSREPEATTEMP7	EQU	160
SYSREPEATTEMP8	EQU	161
SYSREPEATTEMP9	EQU	162
SYSSTRINGA	EQU	7
SYSSTRINGA_H	EQU	8
SYSSTRINGLENGTH	EQU	6
SYSSTRINGPARAM1	EQU	892
SYSTEMP1	EQU	163
SYSTEMP1_E	EQU	166
SYSTEMP1_H	EQU	164
SYSTEMP1_U	EQU	165
SYSTEMP2	EQU	167
SYSTEMP2_H	EQU	168
SYSTEMP3	EQU	169
SYSWAITTEMPMS	EQU	2
SYSWAITTEMPMS_H	EQU	3
SYSWORDTEMPA	EQU	5
SYSWORDTEMPA_H	EQU	6
SYSWORDTEMPB	EQU	9
SYSWORDTEMPB_H	EQU	10
SYSWORDTEMPX	EQU	0
SYSWORDTEMPX_H	EQU	1
TABLELOC	EQU	170
TABLELOC_H	EQU	171
TABLESTARTPOINT	EQU	172
TABLESTARTPOINT_H	EQU	173
TCPDATALEN_IN	EQU	174
TCPDATALEN_IN_H	EQU	175
TCPDATALEN_OUT	EQU	176
TCPDATALEN_OUT_H	EQU	177
TCPRESULT16	EQU	178
TCPRESULT16_H	EQU	180
TEMP	EQU	181
TEMPSTRING1	EQU	838
TT	EQU	182
T_UDP_DESTPORT	EQU	183
T_UDP_DESTPORT_H	EQU	184
VAL1	EQU	185
VAL2	EQU	186
VAL2_H	EQU	187
VAL3	EQU	188
VAL4	EQU	189
WORK	EQU	190
X_ODD	EQU	191

;********************************************************************************

;Alias variables
AFSR0	EQU	4073
AFSR0_H	EQU	4074
I_VALUE16	EQU	93
I_VALUE16_H	EQU	95
SYSCOMMANDLINESTRING_0	EQU	879
SYSETHERBUFFER_1	EQU	934
SYSETHERBUFFER_10	EQU	943
SYSETHERBUFFER_11	EQU	944
SYSETHERBUFFER_12	EQU	945
SYSETHERBUFFER_13	EQU	946
SYSETHERBUFFER_14	EQU	947
SYSETHERBUFFER_15	EQU	948
SYSETHERBUFFER_17	EQU	950
SYSETHERBUFFER_18	EQU	951
SYSETHERBUFFER_19	EQU	952
SYSETHERBUFFER_2	EQU	935
SYSETHERBUFFER_20	EQU	953
SYSETHERBUFFER_21	EQU	954
SYSETHERBUFFER_22	EQU	955
SYSETHERBUFFER_23	EQU	956
SYSETHERBUFFER_24	EQU	957
SYSETHERBUFFER_25	EQU	958
SYSETHERBUFFER_26	EQU	959
SYSETHERBUFFER_27	EQU	960
SYSETHERBUFFER_28	EQU	961
SYSETHERBUFFER_29	EQU	962
SYSETHERBUFFER_3	EQU	936
SYSETHERBUFFER_30	EQU	963
SYSETHERBUFFER_31	EQU	964
SYSETHERBUFFER_32	EQU	965
SYSETHERBUFFER_33	EQU	966
SYSETHERBUFFER_34	EQU	967
SYSETHERBUFFER_35	EQU	968
SYSETHERBUFFER_36	EQU	969
SYSETHERBUFFER_37	EQU	970
SYSETHERBUFFER_38	EQU	971
SYSETHERBUFFER_39	EQU	972
SYSETHERBUFFER_4	EQU	937
SYSETHERBUFFER_40	EQU	973
SYSETHERBUFFER_41	EQU	974
SYSETHERBUFFER_42	EQU	975
SYSETHERBUFFER_43	EQU	976
SYSETHERBUFFER_44	EQU	977
SYSETHERBUFFER_45	EQU	978
SYSETHERBUFFER_46	EQU	979
SYSETHERBUFFER_47	EQU	980
SYSETHERBUFFER_48	EQU	981
SYSETHERBUFFER_49	EQU	982
SYSETHERBUFFER_5	EQU	938
SYSETHERBUFFER_50	EQU	983
SYSETHERBUFFER_51	EQU	984
SYSETHERBUFFER_52	EQU	985
SYSETHERBUFFER_55	EQU	988
SYSETHERBUFFER_56	EQU	989
SYSETHERBUFFER_57	EQU	990
SYSETHERBUFFER_58	EQU	991
SYSETHERBUFFER_59	EQU	992
SYSETHERBUFFER_6	EQU	939
SYSETHERBUFFER_60	EQU	993
SYSETHERBUFFER_61	EQU	994
SYSETHERBUFFER_7	EQU	940
SYSETHERBUFFER_8	EQU	941
SYSETHERBUFFER_9	EQU	942
SYSIPADDR_1	EQU	857
SYSIPADDR_2	EQU	858
SYSIPADDR_3	EQU	859
SYSIPADDR_4	EQU	860
SYSMACADDR_1	EQU	862
SYSMACADDR_2	EQU	863
SYSMACADDR_3	EQU	864
SYSMACADDR_4	EQU	865
SYSMACADDR_5	EQU	866
SYSMACADDR_6	EQU	867

;********************************************************************************

;Vectors
	ORG	0
	goto	BASPROGRAMSTART
	ORG	8
	retfie

;********************************************************************************

;Start of program memory page 0
	ORG	12
BASPROGRAMSTART
;Call initialisation routines
	call	INITSYS
	call	ENC28J60_INITIALISE
	call	INITUSART
;Automatic pin direction setting
	bcf	TRISA,0,ACCESS

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
;___________
;MCLR - MCLR/E.3 -|1    U   40|- B.7/PGD - BUS 1 = Address Digit 4
;Wireless Data In (D0) - A.0 -|2        39|- B.6/PGC - BUS 1 = Address Digit 3
;Wireless Data In (D1) - A.1 -|3        38|- B.5/PGM - BUS 1 = Address Digit 2
;Wireless Data In (D2) - A.2 -|4        37|- B.4 - BUS 1 = Address Digit 1
;Wireless Data In (D3) - A.3 -|5        36|- B.3 - Data Bit 8
;Button Input 1 - A.4 -|6        35|- B.2 - Data Bit 4
;Button Input 2 - A.5 -|7        34|- B.1 - Data Bit 2
;Button Input 4 - E.0 -|8        33|- B.0 - Data Bit 1
;Square Wave Input (I2C Bus) - E.1 -|9        32|- (+)
;Hooter Out - E.2 -|10       31|- (-)
;(+) -|11       30|- D.7 - BUS 2 = Address Digit 4
;(-) -|12       29|- D.6 - BUS 2 = Address Digit 3
;OSC1 -|13       28|- D.5 - BUS 2 = Address Digit 2
;OSC2 -|14       27|- D.4 - BUS 2 = Address Digit 1
;BUS 1 = Address Digit 5 - C.0 -|15       26|- C.7/RX - RS232 RX
;BUS 1 = Address Digit 6 - C.1 -|16       25|- C.6/TX - RS232 TX
;Aux I/O 1 + Heartbeat LED - C.2 -|17       24|- C.5 - Button Input 3
;I2C Bus (Clock) - C.3/SCL -|18       23|- C.4/SDA - I2C Bus (Data)
;BUS 2 = Address Digit 5 - D.0 -|19       22|- D.3 - Aux I/O 3 -
;BUS 2 = Address Digit 6 - D.1 -|20_______21|- D.2 - Aux I/O 2 -
;
;debug01  = 0
	clrf	DEBUG01,BANKED
;#define USART_BAUD_RATE 115200
;#define USART_BLOCKING
;#define USART_TX_BLOCKING
;----- Define Hardware settings
;#Define ENC28J60_DI								PortC.4			'Connected to Device SO
;#Define ENC28J60_DO								PortC.5			'Connected to Device SI
;#Define ENC28J60_SCK							PortC.3			'Connected to Clock
;#Define ENC28J60_CS 							PortA.5			'Chip select line
;#Define ENC28J60_RESET  					PortD.2			'Reset line
;#Define Heartbeat 								PortC.2
;#Define TX 												PortC.7
;#Define RX												PortC.6
;#Define I2C_MODE 						  		Master
;#Define I2C_DATA 						  	 	PortC.4
;#Define I2C_CLOCK 								PortB.0
;#Define I2C_DISABLE_INTERRUPTS 		On
;#Define LCD_IO 										10
;#Define LCD_2C_Address_1 					0x4E 				'Default to 0x4E
;#Define LCD_SPEED 								Fast
;#Define LCD_Backlight_On_State  	1
;#Define LCD_Backlight_Off_State 	0
;#Define Delay											1 S
;----- Variables
;----- Quick Command Reference:
;----- Main body of program commences here.
;HSerPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;HserPrint "ENC28j60 Ethernet Driver 035" : HSerPrintCRLF
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable4
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable4
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT257
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;HSerSend 7
	movlw	7
	movwf	SERDATA,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERSEND
RESET_ENC26J60
;ipaddr = 10,0,0,35
	lfsr	0,IPADDR
	movlw	4
	movwf	POSTINC0,ACCESS
	movlw	10
	movwf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	movlw	35
	movwf	POSTINC0,ACCESS
;macaddr = 0x00, 0x1E, 0xC0, 0x00, 0x00, 0x02
	lfsr	0,MACADDR
	movlw	6
	movwf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	movlw	30
	movwf	POSTINC0,ACCESS
	movlw	192
	movwf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	movlw	2
	movwf	POSTINC0,ACCESS
;ipport = 80
	movlw	80
	movwf	IPPORT,BANKED
;ipserver = 10,0,0,36
;iprouter = 10,0,0,2
	lfsr	0,IPROUTER
	movlw	4
	movwf	POSTINC0,ACCESS
	movlw	10
	movwf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	movlw	2
	movwf	POSTINC0,ACCESS
;macaddrrouter = 0x44, 0x94, 0xfc, 0xa3, 0xe5, 0x8f
	lfsr	0,MACADDRROUTER
	movlw	6
	movwf	POSTINC0,ACCESS
	movlw	68
	movwf	POSTINC0,ACCESS
	movlw	148
	movwf	POSTINC0,ACCESS
	movlw	252
	movwf	POSTINC0,ACCESS
	movlw	163
	movwf	POSTINC0,ACCESS
	movlw	229
	movwf	POSTINC0,ACCESS
	movlw	143
	movwf	POSTINC0,ACCESS
;sntpserveraddr = 129, 6, 15, 28
	lfsr	0,SNTPSERVERADDR
	movlw	4
	movwf	POSTINC0,ACCESS
	movlw	129
	movwf	POSTINC0,ACCESS
	movlw	6
	movwf	POSTINC0,ACCESS
	movlw	15
	movwf	POSTINC0,ACCESS
	movlw	28
	movwf	POSTINC0,ACCESS
;ENC28j60_Init ( macaddr )
	movlw	low MACADDR
	movwf	SysMACADDRHandler,BANKED
	movlw	high MACADDR
	movwf	SysMACADDRHandler_H,BANKED
	call	ENC28J60_INIT
;HserPrint "Initialised"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable5
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable5
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT257
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;#Define SwitchIn porta.4
;dir SwitchIn  in
	bsf	TRISA,4,ACCESS
;#Define ButtonDown = 1
;buttonstate = ButtonDown
	movlw	1
	movwf	BUTTONSTATE,BANKED
;ENC28j60_bitSet( ECON1 , econ1_txrst )
;ENC28j60_bitClear( ECON1 , econ1_txrst )
;ENC28j60_writeReg( ERXFCON, 0 )
	movlw	56
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;dim myReadTime as bit
;myReadTime = 0
	bcf	SYSBITVAR0,0,BANKED
;Do forever
SysDoLoop_S1
;if SwitchIn = buttonstate then
	clrf	SysCalcTempA,ACCESS
	btfsc	PORTA,4,ACCESS
	incf	SysCalcTempA,F,ACCESS
	movf	BUTTONSTATE,W,BANKED
	subwf	SysCalcTempA,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF2
;if buttonstate  = ButtonDown then
	decf	BUTTONSTATE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF3
;end if
ENDIF3
;end if
ENDIF2
;ENC28j60_poll 'Start the process.
	call	ENC28J60_POLL
;if myReadTime = 0 then
;ENC28j60_sntp_get                       'get the Network Time once
;myReadTime = 1
;end if
;Loop
	bra	SysDoLoop_S1
SysDoLoop_E1
;end
	bra	BASPROGRAMEND
;----- Support methods.  Subroutines and Functions
;CHANGE Epoch_seconds  TO SUIT LOCAL NEEDS.. IN SECONDS!!
;If you want use the CALCULATED UDP checksum.  Not required typically.
;#define ENC28j60_UDP_checkSum_Supported
;If you want the ENC28j60 to respond to ICMP/Ping requests
;#define ENC28j60_ping_Supported
;If you want the ENC28j60 to put things on the LCD
;#define ENC28j60_Lcd_Supported
;If you want the ENC28j60 to put things on the terminal
;#define ENC28j60_Hserial_Supported
;#define ENC28j60_packetCounting_Supported
;#define ENC28j60_BufferErrorMessages_Supported
;#define ReceivePacketDebug_Supported
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
;#define HTTP_HANDLER PortsStatus_HTM
;#define etherBufferSize 600
;#define ENC28j60_Select         Set ENC28j60_CS off
;#define ENC28j60_Deselect       Set ENC28j60_CS on
;#define ENC28j60_Reset_CMD			Set ENC28j60_RESET on: Wait 20 ms :Set ENC28j60_RESET off: Wait 20 ms :Set ENC28j60_RESET on: Wait 20 ms
;#define Synflag = 0
;#define Finflag = 1
CONFIGURATIONDETAILS
MEMORY_LOCATIONS_SCRIPT
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

Delay_MS
	incf	SysWaitTempMS_H, F,ACCESS
DMS_START
	movlw	227
	movwf	DELAYTEMP2,ACCESS
DMS_OUTER
	movlw	6
	movwf	DELAYTEMP,ACCESS
DMS_INNER
	decfsz	DELAYTEMP, F,ACCESS
	bra	DMS_INNER
	decfsz	DELAYTEMP2, F,ACCESS
	bra	DMS_OUTER
	decfsz	SysWaitTempMS, F,ACCESS
	bra	DMS_START
	decfsz	SysWaitTempMS_H, F,ACCESS
	bra	DMS_START
	return

;********************************************************************************

ENC28J60_ARPREPLY
;ENC28j60_set_response_macaddress
	call	ENC28J60_SET_RESPONSE_MACADDRESS
;For II = 1 To 6
;etherBuffer(32 + II) = etherBuffer(II)
;Next
;T_arp_dest_enetpacket0 = T_enetpacketdest0
	movff	SYSETHERBUFFER_1,SYSETHERBUFFER_33
;T_arp_dest_enetpacket1 = T_enetpacketdest1
	movff	SYSETHERBUFFER_2,SYSETHERBUFFER_34
;T_arp_dest_enetpacket2 = T_enetpacketdest2
	movff	SYSETHERBUFFER_3,SYSETHERBUFFER_35
;T_arp_dest_enetpacket3 = T_enetpacketdest3
	movff	SYSETHERBUFFER_4,SYSETHERBUFFER_36
;T_arp_dest_enetpacket4 = T_enetpacketdest4
	movff	SYSETHERBUFFER_5,SYSETHERBUFFER_37
;T_arp_dest_enetpacket5 = T_enetpacketdest5
	movff	SYSETHERBUFFER_6,SYSETHERBUFFER_38
;For II = 1 To 4
;etherBuffer(38 + II) = etherBuffer(28 + II)
;Next
;T_arp_tipaddr0 = T_arp_sipaddr0
	movff	SYSETHERBUFFER_29,SYSETHERBUFFER_39
;T_arp_tipaddr1 = T_arp_sipaddr1
	movff	SYSETHERBUFFER_30,SYSETHERBUFFER_40
;T_arp_tipaddr2 = T_arp_sipaddr2
	movff	SYSETHERBUFFER_31,SYSETHERBUFFER_41
;T_arp_tipaddr3 = T_arp_sipaddr3
	movff	SYSETHERBUFFER_32,SYSETHERBUFFER_42
;For II = 1 To 6
;etherBuffer(22 + II) = etherBuffer(6 + II)
;Next
;T_arp_src_enetpacket0 = T_enetpacketsrc0
	movff	SYSETHERBUFFER_7,SYSETHERBUFFER_23
;T_arp_src_enetpacket1 = T_enetpacketsrc1
	movff	SYSETHERBUFFER_8,SYSETHERBUFFER_24
;T_arp_src_enetpacket2 = T_enetpacketsrc2
	movff	SYSETHERBUFFER_9,SYSETHERBUFFER_25
;T_arp_src_enetpacket3 = T_enetpacketsrc3
	movff	SYSETHERBUFFER_10,SYSETHERBUFFER_26
;T_arp_src_enetpacket4 = T_enetpacketsrc4
	movff	SYSETHERBUFFER_11,SYSETHERBUFFER_27
;T_arp_src_enetpacket5 = T_enetpacketsrc5
	movff	SYSETHERBUFFER_12,SYSETHERBUFFER_28
;T_arp_sipaddr0 = ipaddr(1)
	movff	SYSIPADDR_1,SYSETHERBUFFER_29
;T_arp_sipaddr1 = ipaddr(2)
	movff	SYSIPADDR_2,SYSETHERBUFFER_30
;T_arp_sipaddr2 = ipaddr(3)
	movff	SYSIPADDR_3,SYSETHERBUFFER_31
;T_arp_sipaddr3 = ipaddr(4)
	movff	SYSIPADDR_4,SYSETHERBUFFER_32
;etherBuffer(22) = 2
	movlw	2
	banksel	SYSETHERBUFFER_22
	movwf	SYSETHERBUFFER_22,BANKED
;ENC28j60_writebuffer( 42 )
	movlw	42
	banksel	PCKTLEN
	movwf	PCKTLEN,BANKED
	clrf	PCKTLEN_H,BANKED
	call	ENC28J60_WRITEBUFFER
;ENC28j60_packetsend(42)
	movlw	42
	movwf	PCKTLEN,BANKED
	clrf	PCKTLEN_H,BANKED
	goto	ENC28J60_PACKETSEND

;********************************************************************************

ENC28J60_BITCLEAR
;				banktobeselected = ( addr & BANK_MASK) / 32
;banktobeselected = ( addr & BANK_MASK)
	movlw	96
	andwf	ADDR,W,BANKED
	movwf	BANKTOBESELECTED,BANKED
;Repeat 5
	movlw	5
	movwf	SysRepeatTemp5,BANKED
SysRepeatLoop5
;set c off
	bcf	STATUS,C,ACCESS
;rotate banktobeselected right
	rrcf	BANKTOBESELECTED,F,BANKED
;end repeat
	decfsz	SysRepeatTemp5,F,BANKED
	bra	SysRepeatLoop5
SysRepeatLoopEnd5
;if lastselectedBank <> banktobeselected then
	movf	BANKTOBESELECTED,W,BANKED
	subwf	LASTSELECTEDBANK,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ELSE16_1
;if ( ( addr & ADDR_MASK )  <= EIE  ) then
	movlw	31
	andwf	ADDR,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SysBYTETempB
	movlw	27
	movwf	SysBYTETempA,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	btfsc	SysByteTempX,0,ACCESS
;ENC28j60_selectBank ( banktobeselected, addr )
	call	ENC28J60_SELECTBANK
;end if
;Else
	bra	ENDIF16
ELSE16_1
;lastselectedBank = banktobeselected
	movff	BANKTOBESELECTED,LASTSELECTEDBANK
;end if
ENDIF16
;ENC28j60_Select
	bcf	LATA,5,ACCESS
;FastHWSPITransfer( ENC28j60_BIT_FIELD_CLR | (addr AND ADDR_MASK ), temp )
	movlw	31
	andwf	ADDR,W,BANKED
	movwf	SysTemp1,BANKED
	movlw	160
	iorwf	SysTemp1,W,BANKED
	movwf	SPITXDATA,BANKED
	call	FASTHWSPITRANSFER
;FastHWSPITransfer( ENC_Outbyte, temp )
	movff	ENC_OUTBYTE,SPITXDATA
	call	FASTHWSPITRANSFER
;ENC28j60_Deselect
	bsf	LATA,5,ACCESS
	return

;********************************************************************************

ENC28J60_BITSET
;				banktobeselected = ( addr & BANK_MASK) / 32
;HSerPrintByteCRLF banktobeselected
;banktobeselected = ( addr & BANK_MASK)
	movlw	96
	andwf	ADDR,W,BANKED
	movwf	BANKTOBESELECTED,BANKED
;Repeat 5
	movlw	5
	movwf	SysRepeatTemp6,BANKED
SysRepeatLoop6
;set c off
	bcf	STATUS,C,ACCESS
;rotate banktobeselected right
	rrcf	BANKTOBESELECTED,F,BANKED
;end repeat
	decfsz	SysRepeatTemp6,F,BANKED
	bra	SysRepeatLoop6
SysRepeatLoopEnd6
;HSerPrintByteCRLF banktobeselected
;HSerPrintCRLF
;if lastselectedBank <> banktobeselected then
	movf	BANKTOBESELECTED,W,BANKED
	subwf	LASTSELECTEDBANK,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ELSE53_1
;if ( ( addr & ADDR_MASK )  <= EIE  ) then
	movlw	31
	andwf	ADDR,W,BANKED
	movwf	SysTemp2,BANKED
	movff	SysTemp2,SysBYTETempB
	movlw	27
	movwf	SysBYTETempA,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	btfsc	SysByteTempX,0,ACCESS
;ENC28j60_selectBank ( banktobeselected, addr )
	call	ENC28J60_SELECTBANK
;end if
;Else
	bra	ENDIF53
ELSE53_1
;lastselectedBank = banktobeselected
	movff	BANKTOBESELECTED,LASTSELECTEDBANK
;end if
ENDIF53
;ENC28j60_Select
	bcf	LATA,5,ACCESS
;FastHWSPITransfer( ENC28j60_BIT_FIELD_SET | (addr AND ADDR_MASK ), temp )
	movlw	31
	andwf	ADDR,W,BANKED
	movwf	SysTemp2,BANKED
	movlw	128
	iorwf	SysTemp2,W,BANKED
	movwf	SPITXDATA,BANKED
	call	FASTHWSPITRANSFER
;FastHWSPITransfer( ENC_Outbyte, temp )
	movff	ENC_OUTBYTE,SPITXDATA
	call	FASTHWSPITRANSFER
;ENC28j60_Deselect
	bsf	LATA,5,ACCESS
	return

;********************************************************************************

ENC28J60_CALCCHECKSUM
;Dim II As Word
;Dim LocalTmp As Word
;Dim Sum As Long
;Sum = 0
	clrf	SUM,BANKED
	clrf	SUM_H,BANKED
	clrf	SUM_U,BANKED
	clrf	SUM_E,BANKED
;LocalTmp = 0
	clrf	LOCALTMP,BANKED
	clrf	LOCALTMP_H,BANKED
;I_odd = (Endptr - startptr ) Mod 2
	movf	STARTPTR,W,BANKED
	subwf	ENDPTR,W,BANKED
	movwf	SysTemp1,BANKED
	movf	STARTPTR_H,W,BANKED
	subwfb	ENDPTR_H,W,BANKED
	movwf	SysTemp1_H,BANKED
	movff	SysTemp1,SysWORDTempA
	movff	SysTemp1_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysDivSub16
	movff	SysWORDTempX,I_ODD
;if I_odd = 1 then HSerPrint "!"
	decf	I_ODD,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF55
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable45
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable45
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT257
ENDIF55
;For II = Startptr To Endptr Step 2
	movlw	2
	subwf	STARTPTR,W,BANKED
	movwf	II,BANKED
	movlw	0
	subwfb	STARTPTR_H,W,BANKED
	movwf	II_H,BANKED
	movff	STARTPTR,SysWORDTempB
	movff	STARTPTR_H,SysWORDTempB_H
	movff	ENDPTR,SysWORDTempA
	movff	ENDPTR_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd6
SysForLoop6
	movlw	2
	addwf	II,F,BANKED
	movlw	0
	addwfc	II_H,F,BANKED
;Sum = Sum + etherBuffer(II + 1)
	lfsr	0,ETHERBUFFER
	movf	II,W,BANKED
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp1,BANKED
	movf	II_H,W,BANKED
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movlw	1
	addwf	SysTemp1,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movf	INDF0,W,ACCESS
	addwf	SUM,F,BANKED
	movlw	0
	addwfc	SUM_H,F,BANKED
	movlw	0
	addwfc	SUM_U,F,BANKED
	movlw	0
	addwfc	SUM_E,F,BANKED
;LocalTmp_h  = etherBuffer(II)
	lfsr	0,ETHERBUFFER
	movf	II,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	II_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movff	INDF0,LOCALTMP_H
;Sum = Sum + LocalTmp
	movf	LOCALTMP,W,BANKED
	addwf	SUM,F,BANKED
	movf	LOCALTMP_H,W,BANKED
	addwfc	SUM_H,F,BANKED
	movlw	0
	addwfc	SUM_U,F,BANKED
	movlw	0
	addwfc	SUM_E,F,BANKED
;Next I
	movff	II,SysWORDTempA
	movff	II_H,SysWORDTempA_H
	movff	ENDPTR,SysWORDTempB
	movff	ENDPTR_H,SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop6
SysForLoopEnd6
;II = FnLsr( sum, 16 )
	movff	SUM,SYSLONGTEMPB
	movff	SUM_H,SYSLONGTEMPB_H
	movff	SUM_U,SYSLONGTEMPB_U
	movff	SUM_E,SYSLONGTEMPB_E
	movlw	16
	movwf	NUMBITS,BANKED
	call	FN_FNLSR
	movff	FNLSR,II
	movff	FNLSR_H,II_H
;LocalTmp  = [word]Sum
	movff	SUM,LOCALTMP
	movff	SUM_H,LOCALTMP_H
;LocalTmp  = LocalTmp  + II
	movf	II,W,BANKED
	addwf	LOCALTMP,F,BANKED
	movf	II_H,W,BANKED
	addwfc	LOCALTMP_H,F,BANKED
;LocalTmp  = Not LocalTmp
	comf	LOCALTMP,F,BANKED
	comf	LOCALTMP_H,F,BANKED
;etherBuffer(result) = LocalTmp_h
	lfsr	0,ETHERBUFFER
	movf	RESULT,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	RESULT_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movff	LOCALTMP_H,INDF0
;etherBuffer(result + 1) = [byte]LocalTmp
	lfsr	0,ETHERBUFFER
	movf	RESULT,W,BANKED
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp1,BANKED
	movf	RESULT_H,W,BANKED
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movlw	1
	addwf	SysTemp1,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	LOCALTMP,INDF0
	return

;********************************************************************************

ENC28J60_GENERAL_CHECKSUM
;dim I_x as word
;dim I_chksum32 as long
;X_odd = (Val2 - Val1 ) Mod 2
	movf	VAL1,W,BANKED
	subwf	VAL2,W,BANKED
	movwf	SysTemp2,BANKED
	movlw	0
	subwfb	VAL2_H,W,BANKED
	movwf	SysTemp2_H,BANKED
	movff	SysTemp2,SysWORDTempA
	movff	SysTemp2_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysDivSub16
	movff	SysWORDTempX,X_ODD
;if X_odd = 1 then HSerPrint "$"
;I_chksum32 = 0
	clrf	I_CHKSUM32,BANKED
	clrf	I_CHKSUM32_H,BANKED
	clrf	I_CHKSUM32_U,BANKED
	clrf	I_CHKSUM32_E,BANKED
;For I_x = Val1 To Val2 Step 2
	movlw	2
	subwf	VAL1,W,BANKED
	movwf	I_X,BANKED
	clrf	I_X_H,BANKED
	btfss	STATUS,C,ACCESS
	decf	I_X_H,F,BANKED
	movff	VAL1,SysWORDTempB
	clrf	SysWORDTempB_H,ACCESS
	movff	VAL2,SysWORDTempA
	movff	VAL2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd10
SysForLoop10
	movlw	2
	addwf	I_X,F,BANKED
	movlw	0
	addwfc	I_X_H,F,BANKED
;I_value16 = FnLsl( etherbuffer(i_x), 8 )
	lfsr	0,ETHERBUFFER
	movf	I_X,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	I_X_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movff	INDF0,SYSLONGTEMPB
	clrf	SYSLONGTEMPB_H,ACCESS
	clrf	SYSLONGTEMPB_U,ACCESS
	clrf	SYSLONGTEMPB_E,ACCESS
	movlw	8
	movwf	NUMBITS,BANKED
	call	FN_FNLSL
	movff	FNLSL,I_VALUE16
	movff	FNLSL_H,I_VALUE16_H
;Hulp3 = I_x + 1
	incf	I_X,W,BANKED
	movwf	HULP3,BANKED
;I_value16 = I_value16 + etherBuffer(hulp3)
	lfsr	0,ETHERBUFFER
	movf	HULP3,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movf	INDF0,W,ACCESS
	addwf	I_VALUE16,F,ACCESS
	movlw	0
	addwfc	I_VALUE16_H,F,ACCESS
;I_chksum32 = I_chksum32 + I_value16
	movf	I_VALUE16,W,ACCESS
	addwf	I_CHKSUM32,F,BANKED
	movf	I_VALUE16_H,W,ACCESS
	addwfc	I_CHKSUM32_H,F,BANKED
	movlw	0
	addwfc	I_CHKSUM32_U,F,BANKED
	movlw	0
	addwfc	I_CHKSUM32_E,F,BANKED
;Next I_x
	movff	I_X,SysWORDTempA
	movff	I_X_H,SysWORDTempA_H
	movff	VAL2,SysWORDTempB
	movff	VAL2_H,SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop10
SysForLoopEnd10
;If I_odd = 1 Then
	decf	I_ODD,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF108
;Val2 = Val2 + 3
	movlw	3
	addwf	VAL2,F,BANKED
	movlw	0
	addwfc	VAL2_H,F,BANKED
;I_value16 = FnLsl( etherbuffer(val2), 8 )
	lfsr	0,ETHERBUFFER
	movf	VAL2,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	VAL2_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movff	INDF0,SYSLONGTEMPB
	clrf	SYSLONGTEMPB_H,ACCESS
	clrf	SYSLONGTEMPB_U,ACCESS
	clrf	SYSLONGTEMPB_E,ACCESS
	movlw	8
	movwf	NUMBITS,BANKED
	call	FN_FNLSL
	movff	FNLSL,I_VALUE16
	movff	FNLSL_H,I_VALUE16_H
;I_chksum32 = I_chksum32 + I_value16
	movf	I_VALUE16,W,ACCESS
	addwf	I_CHKSUM32,F,BANKED
	movf	I_VALUE16_H,W,ACCESS
	addwfc	I_CHKSUM32_H,F,BANKED
	movlw	0
	addwfc	I_CHKSUM32_U,F,BANKED
	movlw	0
	addwfc	I_CHKSUM32_E,F,BANKED
;End If
ENDIF108
;I_checksum16 = Fnlsr(i_chksum32, 16)
	movff	I_CHKSUM32,SYSLONGTEMPB
	movff	I_CHKSUM32_H,SYSLONGTEMPB_H
	movff	I_CHKSUM32_U,SYSLONGTEMPB_U
	movff	I_CHKSUM32_E,SYSLONGTEMPB_E
	movlw	16
	movwf	NUMBITS,BANKED
	call	FN_FNLSR
	movff	FNLSR,I_CHECKSUM16
	movff	FNLSR_H,I_CHECKSUM16_H
;I_checksum16 = I_checksum16 + I_chksum32 ' only 16 lower bits of i_chksum32 is taken...
	movf	I_CHKSUM32,W,BANKED
	addwf	I_CHECKSUM16,F,BANKED
	movf	I_CHKSUM32_H,W,BANKED
	addwfc	I_CHECKSUM16_H,F,BANKED
;I_checksum16 = Not I_checksum16
	comf	I_CHECKSUM16,F,BANKED
	comf	I_CHECKSUM16_H,F,BANKED
;Val3 = i_checksum16_h
	movff	I_CHECKSUM16_H,VAL3
;Val4 = i_checksum16
	movff	I_CHECKSUM16,VAL4
	return

;********************************************************************************

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
	movff	SYSETHERBUFFER_48,WORK
;Tcp_fin = Work.0
	bcf	SYSBITVAR0,1,BANKED
	btfsc	WORK,0,BANKED
	bsf	SYSBITVAR0,1,BANKED
;Tcp_syn = Work.1
	bcf	SYSBITVAR0,2,BANKED
	btfsc	WORK,1,BANKED
	bsf	SYSBITVAR0,2,BANKED
;Tcp_rst = Work.2
	bcf	SYSBITVAR0,3,BANKED
	btfsc	WORK,2,BANKED
	bsf	SYSBITVAR0,3,BANKED
;Tcp_psh = Work.3
	bcf	SYSBITVAR0,4,BANKED
	btfsc	WORK,3,BANKED
	bsf	SYSBITVAR0,4,BANKED
;Tcp_ack = Work.4
	bcf	SYSBITVAR0,5,BANKED
	btfsc	WORK,4,BANKED
	bsf	SYSBITVAR0,5,BANKED
;Tcp_urg = Work.5
	bcf	SYSBITVAR0,6,BANKED
	btfsc	WORK,5,BANKED
	bsf	SYSBITVAR0,6,BANKED
;HSerPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;HSerPrint "Flags:"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable46
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable46
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT257
;HSerPrint T_ip_srcaddr0
	movff	SYSETHERBUFFER_27,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT258
;HSerPrint ","
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable47
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable47
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT257
;HSerPrint T_ip_srcaddr1
	movff	SYSETHERBUFFER_28,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT258
;HSerPrint ","
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable47
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable47
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT257
;HSerPrint T_ip_srcaddr2
	movff	SYSETHERBUFFER_29,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT258
;HSerPrint ","
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable47
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable47
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT257
;HSerPrint T_ip_srcaddr3
	movff	SYSETHERBUFFER_30,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT258
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;HserPrint "FIN "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable48
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable48
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT257
;HSerSend 9
	movlw	9
	movwf	SERDATA,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERSEND
;HserPrint "SYN "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable49
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable49
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT257
;HSerSend 9
	movlw	9
	movwf	SERDATA,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERSEND
;HserPrint  "RST "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable50
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable50
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT257
;HSerSend 9
	movlw	9
	movwf	SERDATA,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERSEND
;HserPrint  "PSH "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable51
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable51
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT257
;HSerSend 9
	movlw	9
	movwf	SERDATA,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERSEND
;HserPrint  "ACK "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable52
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable52
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT257
;HSerSend 9
	movlw	9
	movwf	SERDATA,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERSEND
;HserPrint "TCP_URG "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable53
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable53
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT257
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;HserPrint Tcp_fin
	clrf	SERPRINTVAL,BANKED
	btfsc	SYSBITVAR0,1,BANKED
	incf	SERPRINTVAL,F,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT258
;HSerSend 9
	movlw	9
	movwf	SERDATA,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERSEND
;HserPrint Tcp_syn
	clrf	SERPRINTVAL,BANKED
	btfsc	SYSBITVAR0,2,BANKED
	incf	SERPRINTVAL,F,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT258
;HSerSend 9
	movlw	9
	movwf	SERDATA,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERSEND
;HserPrint Tcp_rst
	clrf	SERPRINTVAL,BANKED
	btfsc	SYSBITVAR0,3,BANKED
	incf	SERPRINTVAL,F,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT258
;HSerSend 9
	movlw	9
	movwf	SERDATA,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERSEND
;HserPrint Tcp_psh
	clrf	SERPRINTVAL,BANKED
	btfsc	SYSBITVAR0,4,BANKED
	incf	SERPRINTVAL,F,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT258
;HSerSend 9
	movlw	9
	movwf	SERDATA,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERSEND
;HserPrint Tcp_ack
	clrf	SERPRINTVAL,BANKED
	btfsc	SYSBITVAR0,5,BANKED
	incf	SERPRINTVAL,F,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT258
;HSerSend 9
	movlw	9
	movwf	SERDATA,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERSEND
;HserPrint Tcp_urg
	clrf	SERPRINTVAL,BANKED
	btfsc	SYSBITVAR0,6,BANKED
	incf	SERPRINTVAL,F,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT258
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
HTTPPART1
;If Tcp_syn = 1 and Tcp_fin = 0 Then
	clrf	SysByteTempX,ACCESS
	btfsc	SYSBITVAR0,2,BANKED
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp3
	clrf	SysByteTempX,ACCESS
	btfss	SYSBITVAR0,1,BANKED
	comf	SysByteTempX,F,ACCESS
	movf	SysTemp3,W,BANKED
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp1,BANKED
	btfss	SysTemp1,0,BANKED
	bra	ENDIF58
;HSerPrint "syn&!fin"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable54
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable54
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT257
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;ENC28j60_set_response_IPpacket
	call	ENC28J60_SET_RESPONSE_IPPACKET
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
	movff	SYSETHERBUFFER_36,SYSCALCTEMPA
	movff	SYSETHERBUFFER_38,SYSCALCTEMPB
	call	SWAP98
	movff	SYSCALCTEMPA,SYSETHERBUFFER_36
	movff	SYSCALCTEMPB,SYSETHERBUFFER_38
;Swap Tcp_srcporth , Tcp_destporth
	movff	SYSETHERBUFFER_35,SYSCALCTEMPA
	movff	SYSETHERBUFFER_37,SYSCALCTEMPB
	call	SWAP98
	movff	SYSCALCTEMPA,SYSETHERBUFFER_35
	movff	SYSCALCTEMPB,SYSETHERBUFFER_37
;Tcpdatalen_in = 1
	movlw	1
	movwf	TCPDATALEN_IN,BANKED
	clrf	TCPDATALEN_IN_H,BANKED
;[byte]Client_seqnum_E = Tcp_seqnum3
	movff	SYSETHERBUFFER_39,CLIENT_SEQNUM_E
;[byte]Client_seqnum_U = Tcp_seqnum2
	movff	SYSETHERBUFFER_40,CLIENT_SEQNUM_U
;[byte]Client_seqnum_H = Tcp_seqnum1
	movff	SYSETHERBUFFER_41,CLIENT_SEQNUM_H
;[byte]Client_seqnum   = Tcp_seqnum0
	movff	SYSETHERBUFFER_42,CLIENT_SEQNUM
;Client_seqnum = Client_seqnum + Tcpdatalen_in
	movf	TCPDATALEN_IN,W,BANKED
	addwf	CLIENT_SEQNUM,F,BANKED
	movf	TCPDATALEN_IN_H,W,BANKED
	addwfc	CLIENT_SEQNUM_H,F,BANKED
	movlw	0
	addwfc	CLIENT_SEQNUM_U,F,BANKED
	movlw	0
	addwfc	CLIENT_SEQNUM_E,F,BANKED
;Tcp_acknum0 = Client_seqnum
	movff	CLIENT_SEQNUM,SYSETHERBUFFER_46
;Tcp_acknum1 = Client_seqnum_H
	movff	CLIENT_SEQNUM_H,SYSETHERBUFFER_45
;Tcp_acknum2 = Client_seqnum_U
	movff	CLIENT_SEQNUM_U,SYSETHERBUFFER_44
;Tcp_acknum3 = Client_seqnum_E
	movff	CLIENT_SEQNUM_E,SYSETHERBUFFER_43
;Tcp_seqnum0 = 0xFF                                 'Initial sequencenumber
	banksel	SYSETHERBUFFER_42
	setf	SYSETHERBUFFER_42,BANKED
;Tcp_seqnum1 = 0xFF                                 '
	setf	SYSETHERBUFFER_41,BANKED
;Tcp_seqnum2 = 0x10                                 '
	movlw	16
	movwf	SYSETHERBUFFER_40,BANKED
;Tcp_seqnum3 = 0x11                                 '
	movlw	17
	movwf	SYSETHERBUFFER_39,BANKED
;Flags.synflag = 1
	banksel	FLAGS
	bsf	FLAGS,0,BANKED
;Tcp_flags = 0
	banksel	SYSETHERBUFFER_48
	clrf	SYSETHERBUFFER_48,BANKED
;Tcp_flags.1 = 1
	bsf	SYSETHERBUFFER_48,1,BANKED
;Tcp_flags.4 = 1
	bsf	SYSETHERBUFFER_48,4,BANKED
;etherbuffer(49) = 0x20
	movlw	32
	movwf	SYSETHERBUFFER_49,BANKED
;etherbuffer(50) = 0x00
	clrf	SYSETHERBUFFER_50,BANKED
;etherbuffer(60) = 0x01
	movlw	1
	movwf	SYSETHERBUFFER_60,BANKED
;etherbuffer(61) = 0x01
	movlw	1
	movwf	SYSETHERBUFFER_61,BANKED
;I_value16 = T_ip_vers_len And 0x0F
	movlw	15
	andwf	SYSETHERBUFFER_15,W,BANKED
	movwf	I_VALUE16,ACCESS
	clrf	I_VALUE16_H,ACCESS
;I_value16 = I_value16 * 4
	movff	I_VALUE16,SysWORDTempA
	movff	I_VALUE16_H,SysWORDTempA_H
	movlw	4
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	call	SysMultSub16
	movff	SysWORDTempX,I_VALUE16
	movff	SysWORDTempX_H,I_VALUE16_H
;tt = (( T_ip_pktlen0 * 256 )+ T_ip_pktlen1 ) + 14
	movff	SYSETHERBUFFER_17,SysWORDTempA
	clrf	SysWORDTempA_H,ACCESS
	clrf	SysWORDTempB,ACCESS
	movlw	1
	movwf	SysWORDTempB_H,ACCESS
	call	SysMultSub16
	movff	SysWORDTempX,SysTemp1
	movff	SysWORDTempX_H,SysTemp1_H
	banksel	SYSETHERBUFFER_18
	movf	SYSETHERBUFFER_18,W,BANKED
	banksel	SYSTEMP1
	addwf	SysTemp1,W,BANKED
	movwf	SysTemp2,BANKED
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	SysTemp2_H,BANKED
	movlw	14
	addwf	SysTemp2,W,BANKED
	movwf	TT,BANKED
;ENC28j60_Ip_header_checksum
	rcall	ENC28J60_IP_HEADER_CHECKSUM
;ENC28j60_tcp_checksum
	call	ENC28J60_TCP_CHECKSUM
;ENC28j60_writebuffer(tt)
	movff	TT,PCKTLEN
	clrf	PCKTLEN_H,BANKED
	call	ENC28J60_WRITEBUFFER
;ENC28j60_packetsend(tt)
	movff	TT,PCKTLEN
	clrf	PCKTLEN_H,BANKED
	call	ENC28J60_PACKETSEND
;Ackpsh = 0
	clrf	ACKPSH,BANKED
;End If
ENDIF58
HTTPPART2
;' If an ACK and PSH is received and the destination port address is valid
;If Tcp_ack = 1 Then
	btfss	SYSBITVAR0,5,BANKED
	bra	ENDIF59
;if Tcp_fin = 0 then
	btfsc	SYSBITVAR0,1,BANKED
	bra	ENDIF61
;T_ip_destaddr0 = T_ip_srcaddr0
	movff	SYSETHERBUFFER_27,SYSETHERBUFFER_31
;T_ip_destaddr1 = T_ip_srcaddr1
	movff	SYSETHERBUFFER_28,SYSETHERBUFFER_32
;T_ip_destaddr2 = T_ip_srcaddr2
	movff	SYSETHERBUFFER_29,SYSETHERBUFFER_33
;T_ip_destaddr3 = T_ip_srcaddr3
	movff	SYSETHERBUFFER_30,SYSETHERBUFFER_34
;T_ip_srcaddr0 = ipaddr(1)
	movff	SYSIPADDR_1,SYSETHERBUFFER_27
;T_ip_srcaddr1 = ipaddr(2)
	movff	SYSIPADDR_2,SYSETHERBUFFER_28
;T_ip_srcaddr2 = ipaddr(3)
	movff	SYSIPADDR_3,SYSETHERBUFFER_29
;T_ip_srcaddr3 = ipaddr(4)
	movff	SYSIPADDR_4,SYSETHERBUFFER_30
;Swap Tcp_srcportl , Tcp_destportl
	movff	SYSETHERBUFFER_36,SYSCALCTEMPA
	movff	SYSETHERBUFFER_38,SYSCALCTEMPB
	call	SWAP98
	movff	SYSCALCTEMPA,SYSETHERBUFFER_36
	movff	SYSCALCTEMPB,SYSETHERBUFFER_38
;Swap Tcp_srcporth , Tcp_destporth
	movff	SYSETHERBUFFER_35,SYSCALCTEMPA
	movff	SYSETHERBUFFER_37,SYSCALCTEMPB
	call	SWAP98
	movff	SYSCALCTEMPA,SYSETHERBUFFER_35
	movff	SYSCALCTEMPB,SYSETHERBUFFER_37
;ENC28j60_Packetshape
	call	ENC28J60_PACKETSHAPE
;[byte]Incoming_ack_E = Tcp_seqnum3
	movff	SYSETHERBUFFER_39,INCOMING_ACK_E
;[byte]Incoming_ack_U = Tcp_seqnum2
	movff	SYSETHERBUFFER_40,INCOMING_ACK_U
;[byte]Incoming_ack_H = Tcp_seqnum1
	movff	SYSETHERBUFFER_41,INCOMING_ACK_H
;[byte]Incoming_ack   = Tcp_seqnum0
	movff	SYSETHERBUFFER_42,INCOMING_ACK
;Incoming_ack = Incoming_ack + ((( T_ip_pktlen0 * 256 )+ T_ip_pktlen1 )) - 40         '489 - 14
	movff	SYSETHERBUFFER_17,SysWORDTempA
	clrf	SysWORDTempA_H,ACCESS
	clrf	SysWORDTempB,ACCESS
	movlw	1
	movwf	SysWORDTempB_H,ACCESS
	call	SysMultSub16
	movff	SysWORDTempX,SysTemp1
	movff	SysWORDTempX_H,SysTemp1_H
	banksel	SYSETHERBUFFER_18
	movf	SYSETHERBUFFER_18,W,BANKED
	banksel	SYSTEMP1
	addwf	SysTemp1,W,BANKED
	movwf	SysTemp2,BANKED
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	SysTemp2_H,BANKED
	movf	SysTemp2,W,BANKED
	addwf	INCOMING_ACK,W,BANKED
	movwf	SysTemp1,BANKED
	movf	SysTemp2_H,W,BANKED
	addwfc	INCOMING_ACK_H,W,BANKED
	movwf	SysTemp1_H,BANKED
	movlw	0
	addwfc	INCOMING_ACK_U,W,BANKED
	movwf	SysTemp1_U,BANKED
	movlw	0
	addwfc	INCOMING_ACK_E,W,BANKED
	movwf	SysTemp1_E,BANKED
	movlw	40
	subwf	SysTemp1,W,BANKED
	movwf	INCOMING_ACK,BANKED
	movlw	0
	subwfb	SysTemp1_H,W,BANKED
	movwf	INCOMING_ACK_H,BANKED
	movlw	0
	subwfb	SysTemp1_U,W,BANKED
	movwf	INCOMING_ACK_U,BANKED
	movlw	0
	subwfb	SysTemp1_E,W,BANKED
	movwf	INCOMING_ACK_E,BANKED
;Tcp_seqnum0 = Tcp_acknum0
	movff	SYSETHERBUFFER_46,SYSETHERBUFFER_42
;Tcp_seqnum1 = Tcp_acknum1
	movff	SYSETHERBUFFER_45,SYSETHERBUFFER_41
;Tcp_seqnum2 = Tcp_acknum2
	movff	SYSETHERBUFFER_44,SYSETHERBUFFER_40
;Tcp_seqnum3 = Tcp_acknum3
	movff	SYSETHERBUFFER_43,SYSETHERBUFFER_39
;Tcp_acknum0 = Incoming_ack
	movff	INCOMING_ACK,SYSETHERBUFFER_46
;Tcp_acknum1 = Incoming_ack_H
	movff	INCOMING_ACK_H,SYSETHERBUFFER_45
;Tcp_acknum2 = Incoming_ack_U
	movff	INCOMING_ACK_U,SYSETHERBUFFER_44
;Tcp_acknum3 = Incoming_ack_E
	movff	INCOMING_ACK_E,SYSETHERBUFFER_43
;end if
ENDIF61
;If Tcp_psh = 1 Then
	btfss	SYSBITVAR0,4,BANKED
	bra	ENDIF62
;HSerPrint "ack&psh"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable55
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable55
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT257
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;GET / HTTP/1.1
;HSerPrint T_ip_srcaddr0
	movff	SYSETHERBUFFER_27,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT258
;HSerPrint "."
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable56
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable56
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT257
;HSerPrint T_ip_srcaddr1
	movff	SYSETHERBUFFER_28,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT258
;HSerPrint "."
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable56
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable56
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT257
;HSerPrint T_ip_srcaddr2
	movff	SYSETHERBUFFER_29,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT258
;HSerPrint "."
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable56
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable56
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT257
;HSerPrint T_ip_srcaddr3
	movff	SYSETHERBUFFER_30,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT258
;'ACK and PSH
;
;'set flags
;Tcp_flags = 0
	banksel	SYSETHERBUFFER_48
	clrf	SYSETHERBUFFER_48,BANKED
;Tcp_flags.4 = 1                           'ack
	bsf	SYSETHERBUFFER_48,4,BANKED
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
	clrf	SYSETHERBUFFER_17,BANKED
;etherBuffer(18) = 40
	movlw	40
	movwf	SYSETHERBUFFER_18,BANKED
;'5 x 4 = 20 bytes
;etherBuffer(47) = 0x50
	movlw	80
	movwf	SYSETHERBUFFER_47,BANKED
;'flag ACK
;etherBuffer(48) = 0x10
	movlw	16
	movwf	SYSETHERBUFFER_48,BANKED
;etherbuffer(49) = 0X20
	movlw	32
	movwf	SYSETHERBUFFER_49,BANKED
;etherbuffer(50) = 0X00
	clrf	SYSETHERBUFFER_50,BANKED
;'padding
;etherBuffer(55) = 0x00
	clrf	SYSETHERBUFFER_55,BANKED
;etherBuffer(56) = 0x00
	clrf	SYSETHERBUFFER_56,BANKED
;etherBuffer(57) = 0x00
	clrf	SYSETHERBUFFER_57,BANKED
;etherBuffer(58) = 0x00
	clrf	SYSETHERBUFFER_58,BANKED
;etherBuffer(59) = 0x00
	clrf	SYSETHERBUFFER_59,BANKED
;etherBuffer(60) = 0x00
	clrf	SYSETHERBUFFER_60,BANKED
;ENC28j60_ip_header_checksum
	banksel	0
	rcall	ENC28J60_IP_HEADER_CHECKSUM
;ENC28j60_tcp_checksum
	call	ENC28J60_TCP_CHECKSUM
;tt = (( T_ip_pktlen0 * 256 )+ T_ip_pktlen1 ) + 14
;T_ip_pktlen0 = 0
	banksel	SYSETHERBUFFER_17
	clrf	SYSETHERBUFFER_17,BANKED
;T_ip_pktlen1 = 40
	movlw	40
	movwf	SYSETHERBUFFER_18,BANKED
;ENC28j60_writebuffer(60)
	movlw	60
	banksel	PCKTLEN
	movwf	PCKTLEN,BANKED
	clrf	PCKTLEN_H,BANKED
	call	ENC28J60_WRITEBUFFER
;ENC28j60_packetsend(60)
	movlw	60
	movwf	PCKTLEN,BANKED
	clrf	PCKTLEN_H,BANKED
	rcall	ENC28J60_PACKETSEND
;Ackpsh = 1
	movlw	1
	movwf	ACKPSH,BANKED
;TableStartPoint = 1
	movlw	1
	movwf	TABLESTARTPOINT,BANKED
	clrf	TABLESTARTPOINT_H,BANKED
;End If
ENDIF62
;End If
ENDIF59
;if Tcp_fin = 0  then
	btfsc	SYSBITVAR0,1,BANKED
	bra	ELSE60_1
;HTTPPart3
	call	HTTPPART3
;Else
	bra	ENDIF60
ELSE60_1
;HTTPPart4
	call	HTTPPART4
;end if
ENDIF60
	return

;********************************************************************************

ENC28J60_INIT
;Dir ENC28j60_DI in
	bsf	TRISC,4,ACCESS
;Dir ENC28j60_DO Out
	bcf	TRISC,5,ACCESS
;Dir ENC28j60_SCK Out
	bcf	TRISC,3,ACCESS
;Dir ENC28j60_CS out
	bcf	TRISA,5,ACCESS
;Dir ENC28j60_RESET out
	bcf	TRISD,2,ACCESS
;set ENC28j60_DO off
	bcf	LATC,5,ACCESS
;set ENC28j60_SCK off
	bcf	LATC,3,ACCESS
;set ENC28j60_CS off
	bcf	LATA,5,ACCESS
;ENC28j60_Deselect
	bsf	LATA,5,ACCESS
;Repeat 5
	movlw	5
	movwf	SysRepeatTemp1,BANKED
SysRepeatLoop1
;ENC28j60_Reset_CMD
	bsf	LATD,2,ACCESS
	movlw	20
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
	bcf	LATD,2,ACCESS
	movlw	20
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
	bsf	LATD,2,ACCESS
	movlw	20
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;End Repeat
	decfsz	SysRepeatTemp1,F,BANKED
	bra	SysRepeatLoop1
SysRepeatLoopEnd1
;ENC28j60_Select
	bcf	LATA,5,ACCESS
;SPIMode MasterSlow, 0
	movlw	11
	movwf	SPICURRENTMODE,BANKED
	clrf	SPICLOCKMODE,BANKED
	call	SPIMODE213
;FastHWSPITransfer( ENC28j60_SOFT_RESET, temp )
	setf	SPITXDATA,BANKED
	call	FASTHWSPITRANSFER
;lastselectedBank = 99
	movlw	99
	movwf	LASTSELECTEDBANK,BANKED
;wait while ( (ENC28j60_ReadReg( ESTAT ) & ESTAT_CLKRDY ) <> ESTAT_CLKRDY)
SysWaitLoop1
	movlw	29
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movlw	1
	andwf	ENC28J60_READREG,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SysBYTETempA
	movlw	1
	movwf	SysBYTETempB,ACCESS
	call	SysCompEqual
	comf	SysByteTempX,F,ACCESS
	btfsc	SysByteTempX,0,ACCESS
	bra	SysWaitLoop1
;ENC28j60_writeReg(ECON1, 0xC0) 'Hold it in Reset
	movlw	31
	movwf	ADDR,BANKED
	movlw	192
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ECON2, 0x80) 'Set the AUTOINC bit
	movlw	30
	movwf	ADDR,BANKED
	movlw	128
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(EIR, 0x00) 'Reset interrupt flags
	movlw	28
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(EIE,  0xC1)  'Interrupts: Packet reception and buffer errors
	movlw	27
	movwf	ADDR,BANKED
	movlw	193
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(EWOLIE, 0x00)  'Disable wake-on-lan interrupts
	movlw	54
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(EWOLIR, 0x00)  'Clear wake-on-lan interrupt flags
	movlw	55
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ETXSTL, ENC_TXBUF_STL)
	movlw	4
	movwf	ADDR,BANKED
	movlw	112
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ETXSTH, ENC_TXBUF_STH)
	movlw	5
	movwf	ADDR,BANKED
	movlw	22
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ETXNDL, ENC_TXBUF_NDL)
	movlw	6
	movwf	ADDR,BANKED
	setf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ETXNDH, ENC_TXBUF_NDH)  'TX Buffer : 1800 bytes
	movlw	7
	movwf	ADDR,BANKED
	movlw	31
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ERXSTL, ENC_RXBUF_STL)
	movlw	8
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ERXSTH, ENC_RXBUF_STH)
	movlw	9
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ERXNDL, ENC_RXBUF_NDL)
	movlw	10
	movwf	ADDR,BANKED
	movlw	110
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ERXNDH, ENC_RXBUF_NDH)  'RX Buffer : 6390 bytes
	movlw	11
	movwf	ADDR,BANKED
	movlw	22
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ERDPTL, ENC_RXBUF_STL)
	clrf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ERDPTH, ENC_RXBUF_STH)
	movlw	1
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ERXRDPTL, ENC_RXBUF_STL)
	movlw	12
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ERXRDPTH, ENC_RXBUF_STH) 'RX Pointers (same)
	movlw	13
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;nextpacketptr = ENC_RXBUF_ST
	clrf	NEXTPACKETPTR,BANKED
	clrf	NEXTPACKETPTR_H,BANKED
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
	movwf	ADDR,BANKED
	movlw	32
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(EFLOCON, 0x00) 'Disable flow control sending
	movlw	119
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ECOCON, 0x00) 'Disable Clock Out pin
	movlw	117
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(EBSTCON, 0x00) 'Disable built-in self test controller
	movlw	103
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;wait while ( (ENC28j60_ReadReg(ESTAT) & ESTAT_CLKRDY) <> ESTAT_CLKRDY)
SysWaitLoop2
	movlw	29
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movlw	1
	andwf	ENC28J60_READREG,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SysBYTETempA
	movlw	1
	movwf	SysBYTETempB,ACCESS
	call	SysCompEqual
	comf	SysByteTempX,F,ACCESS
	btfsc	SysByteTempX,0,ACCESS
	bra	SysWaitLoop2
;ENC28j60_writeReg(MISTAT, 0x00)  'Clear MII status register
	movlw	234
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(MICMD, 0x00)   'Clear MII command register
	movlw	210
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(MICON1, 0x02)  'Fast MII operation
;ENC28j60_writeReg(MICON2, 0x00)  'Release MII interface from reset
;ENC28j60_writeReg(MACON1, b'00001101' )  'Enable packet reception
	movlw	192
	movwf	ADDR,BANKED
	movlw	13
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(MACON2, 0x00)  'Release the MAC subsystem from reset
;ENC28j60_writeReg(MACON3, 0xB1)  'Auto Pad + CRC + Full Duplex
;ENC28j60_writeReg(MACON3, 0x32)  'Auto Pad to 60 bytes + CRC + Half Duplex + Check frame length
	movlw	194
	movwf	ADDR,BANKED
	movlw	50
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(MACON4, 0x01)  'Need valid preamble
	movlw	195
	movwf	ADDR,BANKED
	movlw	1
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(MAPHSUP, b'00010000') 'Release MAC-PHY support from Reset
;ENC28j60_writeReg(MAMXFLL, 0xEE)
	movlw	202
	movwf	ADDR,BANKED
	movlw	238
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(MAMXFLH, 0x05)  'Maximum frame length
	movlw	203
	movwf	ADDR,BANKED
	movlw	5
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(MABBIPG, 0x12) 'IEEE BTB Inter Packet Gap
	movlw	196
	movwf	ADDR,BANKED
	movlw	18
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(MAIPGL, 0x12)
	movlw	198
	movwf	ADDR,BANKED
	movlw	18
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(MAIPGH, 0x0C)  'IEEE Non BTB Inter Packet Gap
	movlw	199
	movwf	ADDR,BANKED
	movlw	12
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(MAADR0, macaddr(2))
	movlw	225
	movwf	ADDR,BANKED
	movlw	2
	addwf	SysMACADDRHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysMACADDRHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(MAADR1, macaddr(1))
	movlw	224
	movwf	ADDR,BANKED
	movlw	1
	addwf	SysMACADDRHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysMACADDRHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(MAADR2, macaddr(4))
	movlw	227
	movwf	ADDR,BANKED
	movlw	4
	addwf	SysMACADDRHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysMACADDRHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(MAADR3, macaddr(3))
	movlw	226
	movwf	ADDR,BANKED
	movlw	3
	addwf	SysMACADDRHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysMACADDRHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(MAADR4, macaddr(6))
	movlw	229
	movwf	ADDR,BANKED
	movlw	6
	addwf	SysMACADDRHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysMACADDRHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(MAADR5, macaddr(5))
	movlw	228
	movwf	ADDR,BANKED
	movlw	5
	addwf	SysMACADDRHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysMACADDRHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;'Initialize PHY subsystem
;ENC28j60_writePhyReg(PHCON1, 0x00, 0x00)  'Half duplex
	clrf	PHYREGADDR,BANKED
	clrf	ENC_OUTBYTE1,BANKED
	clrf	ENC_OUTBYTE2,BANKED
	call	ENC28J60_WRITEPHYREG
;ENC28j60_writePhyReg(PHCON2, 0x00, 0x00)
	movlw	16
	movwf	PHYREGADDR,BANKED
	clrf	ENC_OUTBYTE1,BANKED
	clrf	ENC_OUTBYTE2,BANKED
	call	ENC28J60_WRITEPHYREG
;ENC28j60_writePhyReg(PHLCON, B'00000100', B'01110110')
	movlw	20
	movwf	PHYREGADDR,BANKED
	movlw	4
	movwf	ENC_OUTBYTE1,BANKED
	movlw	118
	movwf	ENC_OUTBYTE2,BANKED
	call	ENC28J60_WRITEPHYREG
;ENC28j60_writePhyReg(PHIE, 0x00, 0x00)  'Disable interrupts
	movlw	18
	movwf	PHYREGADDR,BANKED
	clrf	ENC_OUTBYTE1,BANKED
	clrf	ENC_OUTBYTE2,BANKED
	call	ENC28J60_WRITEPHYREG
;ENC28j60_writeReg(ECON1, B'00010100')
	movlw	31
	movwf	ADDR,BANKED
	movlw	20
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ECON1, B'00000100')
;ENC28j60_writePhyReg ( PHLCON, 0xA2, 0x0A )
;wait 5 s
;ENC28j60_writePhyReg ( PHLCON, 0x76, 0x04 )
	movlw	20
	movwf	PHYREGADDR,BANKED
	movlw	118
	movwf	ENC_OUTBYTE1,BANKED
	movlw	4
	movwf	ENC_OUTBYTE2,BANKED
	goto	ENC28J60_WRITEPHYREG

;********************************************************************************

ENC28J60_INITIALISE
;macaddr =   0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	lfsr	0,MACADDR
	movlw	6
	movwf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
;ipaddr =    0,0,0,0
	lfsr	0,IPADDR
	movlw	4
	movwf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
;ipserver =  0,0,0,0
;ipport = 80   'set a default value
	movlw	80
	movwf	IPPORT,BANKED
;Ip_id = 0
	clrf	IP_ID,BANKED
	clrf	IP_ID_H,BANKED
;an outstanding GET is a pending flag
;lastGet = 0
	clrf	LASTGET,BANKED
;TableStartPoint =1
	movlw	1
	movwf	TABLESTARTPOINT,BANKED
	clrf	TABLESTARTPOINT_H,BANKED
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
	clrf	I_CHKSUM32,BANKED
;Ip_header_length = T_ip_vers_len And 0x0F
	movlw	15
	banksel	SYSETHERBUFFER_15
	andwf	SYSETHERBUFFER_15,W,BANKED
	banksel	IP_HEADER_LENGTH
	movwf	IP_HEADER_LENGTH,BANKED
;Ip_header_length = 4 * Ip_header_length
;repeat 2
	movlw	2
	movwf	SysRepeatTemp7,BANKED
SysRepeatLoop7
;set C off
	bcf	STATUS,C,ACCESS
;rotate Ip_header_length left
	rlcf	IP_HEADER_LENGTH,F,BANKED
;end repeat
	decfsz	SysRepeatTemp7,F,BANKED
	bra	SysRepeatLoop7
SysRepeatLoopEnd7
;I_chksum32 = 0
	clrf	I_CHKSUM32,BANKED
;I_odd = 0
	clrf	I_ODD,BANKED
;Val1 = 15
	movlw	15
	movwf	VAL1,BANKED
;Val2 = 0x0E + Ip_header_length - 1
	movlw	14
	addwf	IP_HEADER_LENGTH,W,BANKED
	movwf	SysTemp2,BANKED
	clrf	SysTemp2_H,BANKED
	btfsc	STATUS,C,ACCESS
	incf	SysTemp2_H,F,BANKED
	movlw	1
	subwf	SysTemp2,W,BANKED
	movwf	VAL2,BANKED
	movlw	0
	subwfb	SysTemp2_H,W,BANKED
	movwf	VAL2_H,BANKED
;T_ip_hdr_cksum0 = 0
	banksel	SYSETHERBUFFER_25
	clrf	SYSETHERBUFFER_25,BANKED
;T_ip_hdr_cksum1 = 0
	clrf	SYSETHERBUFFER_26,BANKED
;ENC28j60_General_checksum(val1 , Val2)
	banksel	0
	call	ENC28J60_GENERAL_CHECKSUM
;T_ip_hdr_cksum0 = Val3
	movff	VAL3,SYSETHERBUFFER_25
;T_ip_hdr_cksum1 = Val4
	movff	VAL4,SYSETHERBUFFER_26
	return

;********************************************************************************

ENC28J60_PACKETRECEIVE
;Dim eth_counter, eth_frameLength As Word
;Dim previous_nextpacketptr as word
;ENC28j60_temp = ENC28j60_ReadReg (eir) and EIR_PKTIF
	movlw	28
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movlw	64
	andwf	ENC28J60_READREG,W,BANKED
	movwf	ENC28J60_TEMP,BANKED
;If ENC28j60_temp <> EIR_PKTIF Then
	movlw	64
	subwf	ENC28J60_TEMP,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF18
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
ENDIF18
;ENC28j60_data = ENC28j60_ReadReg( erevid )
	movlw	114
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;eth_counter = 1
	movlw	1
	movwf	ETH_COUNTER,BANKED
	clrf	ETH_COUNTER_H,BANKED
;do
SysDoLoop_S3
;HSerPrint "2"
;ENC28j60_writeReg(ERDPTL, [byte]nextpacketptr )
	clrf	ADDR,BANKED
	movff	NEXTPACKETPTR,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ERDPTH, nextpacketptr_h )
	movlw	1
	movwf	ADDR,BANKED
	movff	NEXTPACKETPTR_H,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;eth_counter++
	incf	ETH_COUNTER,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	ETH_COUNTER_H,F,BANKED
;if eth_counter = 0 then
	movff	ETH_COUNTER,SysWORDTempA
	movff	ETH_COUNTER_H,SysWORDTempA_H
	clrf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompEqual16
	btfsc	SysByteTempX,0,ACCESS
;HSerPrint "#1ERDPTL and ERDPTH error"
;HSerPrintCRLF
;exit do
	bra	SysDoLoop_E3
;end if
;loop while (ENC28j60_ReadReg(ERDPTL) <>  [byte]nextpacketptr) or (ENC28j60_ReadReg(ERDPTH) <> nextpacketptr_h )
	clrf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,SysFnBYTE1
	movlw	1
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	sysfnbyte1,SysBYTETempA
	movff	NEXTPACKETPTR,SysBYTETempB
	call	SysCompEqual
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movff	enc28j60_readreg,SysBYTETempA
	movff	nextpacketptr_h,SysBYTETempB
	call	SysCompEqual
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp2
	movf	SysTemp1,W,BANKED
	iorwf	SysTemp2,W,BANKED
	movwf	SysTemp3,BANKED
	btfsc	SysTemp3,0,BANKED
	bra	SysDoLoop_S3
SysDoLoop_E3
;HSerPrint "4"
;ENC28j60_readbuffer(6)
	movlw	6
	movwf	ETHERGETLENGTH,BANKED
	clrf	ETHERGETLENGTH_H,BANKED
	rcall	ENC28J60_READBUFFER
;HSerPrint "5"
;nextpacketptr = etherbuffer(1)
	movff	SYSETHERBUFFER_1,NEXTPACKETPTR
	clrf	NEXTPACKETPTR_H,BANKED
;nextpacketptr_h = etherbuffer(2)
	movff	SYSETHERBUFFER_2,NEXTPACKETPTR_H
;eth_frameLength = etherbuffer(3)
	movff	SYSETHERBUFFER_3,ETH_FRAMELENGTH
	clrf	ETH_FRAMELENGTH_H,BANKED
;eth_frameLength_h = etherbuffer(4)
	movff	SYSETHERBUFFER_4,ETH_FRAMELENGTH_H
;RxStat = etherbuffer(5)
	movff	SYSETHERBUFFER_5,RXSTAT
;RxStat_h = etherbuffer(6)
	movff	SYSETHERBUFFER_6,RXSTAT_H
;if ( etherbuffer(5) AND 0x80 ) = 0x80 then
;ENC28j60_readbuffer(eth_frameLength)
	movff	ETH_FRAMELENGTH,ETHERGETLENGTH
	movff	ETH_FRAMELENGTH_H,ETHERGETLENGTH_H
	rcall	ENC28J60_READBUFFER
;end if
;HSerPrint "6"
ENDPACKET
;eth_counter = 1
	movlw	1
	movwf	ETH_COUNTER,BANKED
	clrf	ETH_COUNTER_H,BANKED
;do
SysDoLoop_S4
;ENC28j60_writeReg(ERDPTL, [byte]nextpacketptr )
	clrf	ADDR,BANKED
	movff	NEXTPACKETPTR,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ERDPTH, nextpacketptr_h )
	movlw	1
	movwf	ADDR,BANKED
	movff	NEXTPACKETPTR_H,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;eth_counter++
	incf	ETH_COUNTER,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	ETH_COUNTER_H,F,BANKED
;if eth_counter = 0 then
	movff	ETH_COUNTER,SysWORDTempA
	movff	ETH_COUNTER_H,SysWORDTempA_H
	clrf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF20
;HSerPrint "#2ERDPTL and ERDPTH error"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable58
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable58
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT257
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;exit do
	bra	SysDoLoop_E4
;end if
ENDIF20
;loop while (ENC28j60_ReadReg(ERDPTL) <>  [byte]nextpacketptr) or (ENC28j60_ReadReg(ERDPTH) <> nextpacketptr_h )
	clrf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,SysFnBYTE1
	movlw	1
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	sysfnbyte1,SysBYTETempA
	movff	NEXTPACKETPTR,SysBYTETempB
	call	SysCompEqual
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movff	enc28j60_readreg,SysBYTETempA
	movff	nextpacketptr_h,SysBYTETempB
	call	SysCompEqual
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp2
	movf	SysTemp1,W,BANKED
	iorwf	SysTemp2,W,BANKED
	movwf	SysTemp3,BANKED
	btfsc	SysTemp3,0,BANKED
	bra	SysDoLoop_S4
SysDoLoop_E4
;'Packet is finished
;HSerPrint eth_counter
;HSerPrintCRLF
;IF ( nextpacketptr and 1 ) = 0 THEN
	movlw	1
	andwf	NEXTPACKETPTR,W,BANKED
	movwf	SysTemp1,BANKED
	clrf	SysTemp1_H,BANKED
	movff	SysTemp1,SysWORDTempA
	movff	SysTemp1_H,SysWORDTempA_H
	clrf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF21
;eth_counter = nextpacketptr -1
	movlw	1
	subwf	NEXTPACKETPTR,W,BANKED
	movwf	ETH_COUNTER,BANKED
	movlw	0
	subwfb	NEXTPACKETPTR_H,W,BANKED
	movwf	ETH_COUNTER_H,BANKED
;END IF
ENDIF21
;ENC28j60_writeReg(ERXRDPTL, [byte]eth_counter )
	movlw	12
	movwf	ADDR,BANKED
	movff	ETH_COUNTER,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ERXRDPTH, [byte]eth_counter_h )
	movlw	13
	movwf	ADDR,BANKED
	movff	ETH_COUNTER_H,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28j60_bitSet( ECON2, ECON2_PKTDEC )
	movlw	30
	movwf	ADDR,BANKED
	movlw	64
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_BITSET
;If etherBuffer(13) = 0X08 Then                               'TYPE: IP
	movlw	8
	banksel	SYSETHERBUFFER_13
	subwf	SYSETHERBUFFER_13,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF22
;If etherBuffer(14) = 0X06 Then                             'Type:ARP
	movlw	6
	subwf	SYSETHERBUFFER_14,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF23
;If etherBuffer(21) = 0X00 Then                          'ARP request
	movf	SYSETHERBUFFER_21,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF25
;If etherBuffer(22) = 0X01 Then                       'ARP request
	decf	SYSETHERBUFFER_22,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF27
;If etherBuffer(39) = ipaddr(1) Then                  'ARP for us
	movf	SYSIPADDR_1,W,BANKED
	subwf	SYSETHERBUFFER_39,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF29
;If etherBuffer(40) = ipaddr(2) Then
	movf	SYSIPADDR_2,W,BANKED
	subwf	SYSETHERBUFFER_40,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF31
;If etherBuffer(41) = ipaddr(3) Then
	movf	SYSIPADDR_3,W,BANKED
	subwf	SYSETHERBUFFER_41,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF33
;If etherBuffer(42) = ipaddr(4) Then
	movf	SYSIPADDR_4,W,BANKED
	subwf	SYSETHERBUFFER_42,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF35
;ENC28j60_Arpreply
	banksel	0
	call	ENC28J60_ARPREPLY
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
;End If
ENDIF23
;If etherBuffer(14) = 0X00 Then                             'Type:IP
	banksel	SYSETHERBUFFER_14
	movf	SYSETHERBUFFER_14,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF24
;If etherBuffer(15) = 0X45 Then                          'We handle only simple IP packets
	movlw	69
	subwf	SYSETHERBUFFER_15,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF26
;If etherBuffer(21) = 0 or etherBuffer(21) = 0x40 Then                          'We handle only non fragmented packets
	movff	SYSETHERBUFFER_21,SysBYTETempA
	clrf	SysBYTETempB,ACCESS
	banksel	0
	call	SysCompEqual
	movff	SysByteTempX,SysTemp2
	movff	SYSETHERBUFFER_21,SysBYTETempA
	movlw	64
	movwf	SysBYTETempB,ACCESS
	call	SysCompEqual
	movf	SysTemp2,W,BANKED
	iorwf	SysByteTempX,W,ACCESS
	movwf	SysTemp3,BANKED
	btfss	SysTemp3,0,BANKED
	bra	ENDIF28
;If etherBuffer(31) = ipaddr(1) Then                  'Ip packet for us
	banksel	SYSIPADDR_1
	movf	SYSIPADDR_1,W,BANKED
	subwf	SYSETHERBUFFER_31,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF30
;If etherBuffer(32) = ipaddr(2) Then
	movf	SYSIPADDR_2,W,BANKED
	subwf	SYSETHERBUFFER_32,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF32
;If etherBuffer(33) = ipaddr(3) Then
	movf	SYSIPADDR_3,W,BANKED
	subwf	SYSETHERBUFFER_33,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF34
;If etherBuffer(34) = ipaddr(4) Then
	movf	SYSIPADDR_4,W,BANKED
	subwf	SYSETHERBUFFER_34,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF36
;If etherBuffer(24) = 1 Then              'Protocol:ICMP
	decf	SYSETHERBUFFER_24,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF37
;If etherBuffer(35) = 0X08 Then        'ICMP echo request
	movlw	8
	subwf	SYSETHERBUFFER_35,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF40
;PORTA.0 = 1
	bsf	LATA,0,ACCESS
;ENC28j60_Pingreply
	banksel	0
	rcall	ENC28J60_PINGREPLY
;PORTA.0 = 0
	bcf	LATA,0,ACCESS
;End If
ENDIF40
;End If
ENDIF37
;If etherBuffer(24) = 17 Then             'Protocol:UDP
	movlw	17
	banksel	SYSETHERBUFFER_24
	subwf	SYSETHERBUFFER_24,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF38
;T_udp_destport = ( T_udp_destport0 * 256 ) + T_udp_destport1
	movff	SYSETHERBUFFER_37,SysWORDTempA
	clrf	SysWORDTempA_H,ACCESS
	clrf	SysWORDTempB,ACCESS
	movlw	1
	movwf	SysWORDTempB_H,ACCESS
	banksel	0
	call	SysMultSub16
	movff	SysWORDTempX,SysTemp1
	movff	SysWORDTempX_H,SysTemp1_H
	banksel	SYSETHERBUFFER_38
	movf	SYSETHERBUFFER_38,W,BANKED
	banksel	SYSTEMP1
	addwf	SysTemp1,W,BANKED
	movwf	T_UDP_DESTPORT,BANKED
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	T_UDP_DESTPORT_H,BANKED
;ENC28j60_Udp_Handler
	rcall	ENC28J60_UDP_HANDLER
;if T_udp_destport = 7 then
	movff	T_UDP_DESTPORT,SysWORDTempA
	movff	T_UDP_DESTPORT_H,SysWORDTempA_H
	movlw	7
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF41
;ENC28j60_Setipaddrs
	rcall	ENC28J60_SETIPADDRS
;Swap T_udp_srcport0 , T_udp_destport0
	movff	SYSETHERBUFFER_35,SYSCALCTEMPA
	movff	SYSETHERBUFFER_37,SYSCALCTEMPB
	call	SWAP98
	movff	SYSCALCTEMPA,SYSETHERBUFFER_35
	movff	SYSCALCTEMPB,SYSETHERBUFFER_37
;Swap T_udp_srcport1 , T_udp_destport1
	movff	SYSETHERBUFFER_36,SYSCALCTEMPA
	movff	SYSETHERBUFFER_38,SYSCALCTEMPB
	call	SWAP98
	movff	SYSCALCTEMPA,SYSETHERBUFFER_36
	movff	SYSCALCTEMPB,SYSETHERBUFFER_38
;ENC28j60_Udp_checksum
	rcall	ENC28J60_UDP_CHECKSUM
;Hulp2 = T_udp_len0 * 256
	movff	SYSETHERBUFFER_39,SysWORDTempA
	clrf	SysWORDTempA_H,ACCESS
	clrf	SysWORDTempB,ACCESS
	movlw	1
	movwf	SysWORDTempB_H,ACCESS
	call	SysMultSub16
	movff	SysWORDTempX,HULP2
	movff	SysWORDTempX_H,HULP2_H
;Hulp2 = Hulp2 + T_udp_len1
	banksel	SYSETHERBUFFER_40
	movf	SYSETHERBUFFER_40,W,BANKED
	banksel	HULP2
	addwf	HULP2,F,BANKED
	movlw	0
	addwfc	HULP2_H,F,BANKED
;Hulp2 = Hulp2 + 34
	movlw	34
	addwf	HULP2,F,BANKED
	movlw	0
	addwfc	HULP2_H,F,BANKED
;ENC28j60_writebuffer( hulp2 )
	movff	HULP2,PCKTLEN
	movff	HULP2_H,PCKTLEN_H
	rcall	ENC28J60_WRITEBUFFER
;ENC28j60_packetsend( hulp2 )
	movff	HULP2,PCKTLEN
	movff	HULP2_H,PCKTLEN_H
	rcall	ENC28J60_PACKETSEND
;end if
ENDIF41
;End If
ENDIF38
;If etherBuffer(24) = 6 Then              'Protocol:TCP
	movlw	6
	banksel	SYSETHERBUFFER_24
	subwf	SYSETHERBUFFER_24,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF39
;If Tcp_destporth = 0 Then
	movf	SYSETHERBUFFER_37,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF42
;Select Case Tcp_destportl
SysSelect3Case1
	movlw	80
	subwf	SYSETHERBUFFER_38,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case2
;ENC28j60_http
	banksel	0
	call	ENC28J60_HTTP
;End Select
SysSelect3Case2
SysSelectEnd3
;End If
ENDIF42
;End If
ENDIF39
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
;End If
ENDIF24
;End If
ENDIF22
	banksel	0
	return

;********************************************************************************

ENC28J60_PACKETSEND
;ENC28j60_bitSet( ECON1 , econ1_txrst )
	movlw	31
	movwf	ADDR,BANKED
	movlw	128
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_BITSET
;ENC28j60_bitClear( ECON1 , econ1_txrst )
	movlw	31
	movwf	ADDR,BANKED
	movlw	128
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_BITCLEAR
;ENC28j60_bitClear( EIR , EIR_TXERIF )
	movlw	28
	movwf	ADDR,BANKED
	movlw	2
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_BITCLEAR
;wait while ( (ENC28j60_ReadReg( ECON1 ) & ECON1_TXRTS ) = ECON1_TXRTS )
SysWaitLoop10
	movlw	31
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movlw	8
	andwf	ENC28J60_READREG,W,BANKED
	movwf	SysTemp2,BANKED
	movff	SysTemp2,SysBYTETempA
	movlw	8
	movwf	SysBYTETempB,ACCESS
	call	SysCompEqual
	btfsc	SysByteTempX,0,ACCESS
	bra	SysWaitLoop10
;ENC28j60_writeReg(etxndl , (ENC_TXBUF_STL + pcktlen ) & 0xFF )
;ENC28j60_writeReg(etxndh , ENC_TXBUF_STH + pcktlen_h )
;todo erv
;hulp2 =  ENC_TXBUF_ST + pcktlen
	movlw	112
	addwf	PCKTLEN,W,BANKED
	movwf	HULP2,BANKED
	movlw	22
	addwfc	PCKTLEN_H,W,BANKED
	movwf	HULP2_H,BANKED
;HSerPrint hex(hulp2_h)
;HSerPrint hex(hulp2)
;HSerPrintCRLF
;ENC28j60_writeReg(etxndl , hulp2 & 0xFF )
	movlw	6
	movwf	ADDR,BANKED
	movff	HULP2,ENC_OUTBYTE
	rcall	ENC28J60_WRITEREG
;ENC28j60_writeReg(etxndh , hulp2_h )
	movlw	7
	movwf	ADDR,BANKED
	movff	HULP2_H,ENC_OUTBYTE
	rcall	ENC28J60_WRITEREG
;ENC28j60_bitSet( EIR , EIR_TXIF )
	movlw	28
	movwf	ADDR,BANKED
	movlw	8
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_BITSET
;ENC28j60_bitClear( EIE , EIE_TXIE )
	movlw	27
	movwf	ADDR,BANKED
	movlw	8
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_BITCLEAR
;ENC28j60_bitSet( ECON1 , econ1_txrts )
	movlw	31
	movwf	ADDR,BANKED
	movlw	8
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_BITSET
;wait while ( (ENC28j60_ReadReg( ECON1 ) & ECON1_TXRTS ) = ECON1_TXRTS )
SysWaitLoop11
	movlw	31
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movlw	8
	andwf	ENC28J60_READREG,W,BANKED
	movwf	SysTemp2,BANKED
	movff	SysTemp2,SysBYTETempA
	movlw	8
	movwf	SysBYTETempB,ACCESS
	call	SysCompEqual
	btfsc	SysByteTempX,0,ACCESS
	bra	SysWaitLoop11
	return

;********************************************************************************

ENC28J60_PACKETSHAPE
;T_enetpacketdest0 = T_enetpacketsrc0
	movff	SYSETHERBUFFER_7,SYSETHERBUFFER_1
;T_enetpacketdest1 = T_enetpacketsrc1
	movff	SYSETHERBUFFER_8,SYSETHERBUFFER_2
;T_enetpacketdest2 = T_enetpacketsrc2
	movff	SYSETHERBUFFER_9,SYSETHERBUFFER_3
;T_enetpacketdest3 = T_enetpacketsrc3
	movff	SYSETHERBUFFER_10,SYSETHERBUFFER_4
;T_enetpacketdest4 = T_enetpacketsrc4
	movff	SYSETHERBUFFER_11,SYSETHERBUFFER_5
;T_enetpacketdest5 = T_enetpacketsrc5
	movff	SYSETHERBUFFER_12,SYSETHERBUFFER_6
;T_enetpacketsrc0 = macaddr(1)
	movff	SYSMACADDR_1,SYSETHERBUFFER_7
;T_enetpacketsrc1 = macaddr(2)
	movff	SYSMACADDR_2,SYSETHERBUFFER_8
;T_enetpacketsrc2 = macaddr(3)
	movff	SYSMACADDR_3,SYSETHERBUFFER_9
;T_enetpacketsrc3 = macaddr(4)
	movff	SYSMACADDR_4,SYSETHERBUFFER_10
;T_enetpacketsrc4 = macaddr(5)
	movff	SYSMACADDR_5,SYSETHERBUFFER_11
;T_enetpacketsrc5 = macaddr(6)
	movff	SYSMACADDR_6,SYSETHERBUFFER_12
	return

;********************************************************************************

ENC28J60_PINGREPLY
;Dim Packetlength As Word
;T_id0 = ip_id_h
	movff	IP_ID_H,SYSETHERBUFFER_19
;T_id1 = [byte]ip_id
	movff	IP_ID,SYSETHERBUFFER_20
;Ip_id = Ip_id + 1
	incf	IP_ID,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	IP_ID_H,F,BANKED
;ENC28j60_set_response_IPpacket
	rcall	ENC28J60_SET_RESPONSE_IPPACKET
;'Swap IP addresses
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
;'Swap MAC addresses
;ENC28j60_set_response_macaddress
;T_ip_hdr_cksum0 = 0
	banksel	SYSETHERBUFFER_25
	clrf	SYSETHERBUFFER_25,BANKED
;T_ip_hdr_cksum1 = 0
	clrf	SYSETHERBUFFER_26,BANKED
;ENC28j60_Calcchecksum( T_ip_header_pointer0 , T_ip_header_pointer1 , T_ip_hdr_cksum0_pointer )
	movlw	15
	banksel	STARTPTR
	movwf	STARTPTR,BANKED
	clrf	STARTPTR_H,BANKED
	movlw	33
	movwf	ENDPTR,BANKED
	clrf	ENDPTR_H,BANKED
	movlw	25
	movwf	RESULT,BANKED
	clrf	RESULT_H,BANKED
	call	ENC28J60_CALCCHECKSUM
;T_icmp_type = 0
	banksel	SYSETHERBUFFER_35
	clrf	SYSETHERBUFFER_35,BANKED
;T_icmp_cksum0 = 0
	clrf	SYSETHERBUFFER_37,BANKED
;T_icmp_cksum1 = 0
	clrf	SYSETHERBUFFER_38,BANKED
;Packetlength_h = etherBuffer(17)
	movff	SYSETHERBUFFER_17,PACKETLENGTH_H
;[byte]Packetlength = etherBuffer(18)
	movff	SYSETHERBUFFER_18,PACKETLENGTH
;Packetlength = etherBuffer(17) * 256
;Packetlength = Packetlength + etherBuffer(18)
;Packetlength = Packetlength + 13                         'We are going to calculate the checksum till the end of packet (IP length + 14 byte of the ethernet stuff), -1 to get word start
	movlw	13
	banksel	PACKETLENGTH
	addwf	PACKETLENGTH,F,BANKED
	movlw	0
	addwfc	PACKETLENGTH_H,F,BANKED
;ENC28j60_Calcchecksum(35 , Packetlength , 37)
	movlw	35
	movwf	STARTPTR,BANKED
	clrf	STARTPTR_H,BANKED
	movff	PACKETLENGTH,ENDPTR
	movff	PACKETLENGTH_H,ENDPTR_H
	movlw	37
	movwf	RESULT,BANKED
	clrf	RESULT_H,BANKED
	call	ENC28J60_CALCCHECKSUM
;Packetlength = Packetlength + 1
	incf	PACKETLENGTH,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	PACKETLENGTH_H,F,BANKED
;ENC28j60_writebuffer( packetlength )
	movff	PACKETLENGTH,PCKTLEN
	movff	PACKETLENGTH_H,PCKTLEN_H
	rcall	ENC28J60_WRITEBUFFER
;ENC28j60_packetsend(packetlength)
	movff	PACKETLENGTH,PCKTLEN
	movff	PACKETLENGTH_H,PCKTLEN_H
	bra	ENC28J60_PACKETSEND

;********************************************************************************

ENC28J60_POLL
;if ENC28j60_ReadReg( epktcnt ) > 0 Then
	movlw	57
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movf	ENC28J60_READREG,W,BANKED
	sublw	0
	btfsc	STATUS, C,ACCESS
	bra	ENDIF4
;ENC28j60_packetreceive( etherBufferSize )
	movlw	88
	movwf	MAXLEN,BANKED
	movlw	2
	movwf	MAXLEN_H,BANKED
	rcall	ENC28J60_PACKETRECEIVE
;end if
ENDIF4
;if ENC28j60_ReadReg( EIR ) & 0x01 = 0X01 Then
	movlw	28
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,SysTemp1
	btfss	SysTemp1,0,BANKED
	bra	ENDIF5
;HSerPrint "Buffer Overun"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable70
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable70
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT257
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;ENC28j60_bitClear( EIR, EIR_RXERIF )
	movlw	28
	movwf	ADDR,BANKED
	movlw	1
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_BITCLEAR
;goto Reset_ENC26j60
;end if
ENDIF5
	return

;********************************************************************************

ENC28J60_READBUFFER
;dim eth_counter as Word
;ENC28j60_regdump
;if etherGetLength  > 1518 then Exit Sub
;ENC28j60_Select
	bcf	LATA,5,ACCESS
;Set WCOL Off
	bcf	SSPCON1,WCOL,ACCESS
;SSPBUF = ENC28j60_READ_BUF_MEM
	movlw	58
	movwf	SSPBUF,ACCESS
;Wait While BF = Off
SysWaitLoop12
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop12
;temp = SSPBUF
	movff	SSPBUF,TEMP
;for eth_counter = 1 to etherGetLength
	clrf	ETH_COUNTER,BANKED
	clrf	ETH_COUNTER_H,BANKED
	movlw	1
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	movff	ETHERGETLENGTH,SysWORDTempA
	movff	ETHERGETLENGTH_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd2
SysForLoop2
	incf	ETH_COUNTER,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	ETH_COUNTER_H,F,BANKED
;if eth_counter > etherBufferSize then
	movff	ETH_COUNTER,SysWORDTempB
	movff	ETH_COUNTER_H,SysWORDTempB_H
	movlw	88
	movwf	SysWORDTempA,ACCESS
	movlw	2
	movwf	SysWORDTempA_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
;exit for
	bra	SysForLoopEnd2
;end if
;SSPBUF = 0
	clrf	SSPBUF,ACCESS
;Wait While BF = Off
SysWaitLoop13
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop13
;etherbuffer( eth_counter ) = SSPBUF
	lfsr	0,ETHERBUFFER
	movf	ETH_COUNTER,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	ETH_COUNTER_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movff	SSPBUF,INDF0
;next
	movff	ETH_COUNTER,SysWORDTempA
	movff	ETH_COUNTER_H,SysWORDTempA_H
	movff	ETHERGETLENGTH,SysWORDTempB
	movff	ETHERGETLENGTH_H,SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop2
SysForLoopEnd2
;if etherGetLength > etherBufferSize then
	movff	ETHERGETLENGTH,SysWORDTempB
	movff	ETHERGETLENGTH_H,SysWORDTempB_H
	movlw	88
	movwf	SysWORDTempA,ACCESS
	movlw	2
	movwf	SysWORDTempA_H,ACCESS
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF46
;for eth_counter = etherBufferSize+1 to etherGetLength
	movlw	88
	movwf	ETH_COUNTER,BANKED
	movlw	2
	movwf	ETH_COUNTER_H,BANKED
	movlw	89
	movwf	SysWORDTempB,ACCESS
	movlw	2
	movwf	SysWORDTempB_H,ACCESS
	movff	ETHERGETLENGTH,SysWORDTempA
	movff	ETHERGETLENGTH_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd3
SysForLoop3
	incf	ETH_COUNTER,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	ETH_COUNTER_H,F,BANKED
;SSPBUF = 0
	clrf	SSPBUF,ACCESS
;Wait While BF = Off
SysWaitLoop14
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop14
;temp = SSPBUF
	movff	SSPBUF,TEMP
;next
	movff	ETH_COUNTER,SysWORDTempA
	movff	ETH_COUNTER_H,SysWORDTempA_H
	movff	ETHERGETLENGTH,SysWORDTempB
	movff	ETHERGETLENGTH_H,SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop3
SysForLoopEnd3
;End if
ENDIF46
;ENC28j60_Deselect
	bsf	LATA,5,ACCESS
	return

;********************************************************************************

FN_ENC28J60_READREG
;banktobeselected =  ( addr & BANK_MASK) / 32
;banktobeselected =  ( addr & BANK_MASK)
	movlw	96
	andwf	ADDR,W,BANKED
	movwf	BANKTOBESELECTED,BANKED
;Repeat 5
	movlw	5
	movwf	SysRepeatTemp2,BANKED
SysRepeatLoop2
;set c off
	bcf	STATUS,C,ACCESS
;rotate banktobeselected right
	rrcf	BANKTOBESELECTED,F,BANKED
;end repeat
	decfsz	SysRepeatTemp2,F,BANKED
	bra	SysRepeatLoop2
SysRepeatLoopEnd2
;HSerPrint "$"
;HSerPrint banktobeselected
;HSerPrint ":"
;				'These registers (EIE, EIR, ESTAT, ECON2, ECON1)
;				'are present in all banks, no need to switch bank
;if lastselectedBank <> banktobeselected then
	movf	BANKTOBESELECTED,W,BANKED
	subwf	LASTSELECTEDBANK,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF6
;if ( ( addr & ADDR_MASK ) <= EIE  ) then
	movlw	31
	andwf	ADDR,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SysBYTETempB
	movlw	27
	movwf	SysBYTETempA,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE7_1
;ENC28j60_selectBank ( banktobeselected, addr )
	rcall	ENC28J60_SELECTBANK
;else
	bra	ENDIF7
ELSE7_1
;lastselectedBank = banktobeselected
	movff	BANKTOBESELECTED,LASTSELECTEDBANK
;end if
ENDIF7
;end if
ENDIF6
;ENC28j60_Select
	bcf	LATA,5,ACCESS
;Set WCOL Off
	bcf	SSPCON1,WCOL,ACCESS
;SSPBUF = ENC28j60_READ_CTRL_REG | ( addr AND ADDR_MASK )
	movlw	31
	andwf	ADDR,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SSPBUF
;Wait While BF = Off
SysWaitLoop3
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop3
;temp = SSPBUF
	movff	SSPBUF,TEMP
;Set WCOL Off
	bcf	SSPCON1,WCOL,ACCESS
;SSPBUF = temp
	movff	TEMP,SSPBUF
;Wait While BF = Off
SysWaitLoop4
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop4
;temp = SSPBUF
	movff	SSPBUF,TEMP
;Set WCOL Off
	bcf	SSPCON1,WCOL,ACCESS
;SSPBUF = temp
	movff	TEMP,SSPBUF
;Wait While BF = Off
SysWaitLoop5
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop5
;ENC28j60_ReadReg = SSPBUF
	movff	SSPBUF,ENC28J60_READREG
;ENC28j60_Deselect
	bsf	LATA,5,ACCESS
	return

;********************************************************************************

ENC28J60_SELECTBANK
;ENC28j60_Select
	bcf	LATA,5,ACCESS
;FastHWSPITransfer(BFCCMD | ECON1, temp)
	movlw	191
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;FastHWSPITransfer(b'00000011', temp)
	movlw	3
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;ENC28j60_Deselect
	bsf	LATA,5,ACCESS
;ENC28j60_Select
	bcf	LATA,5,ACCESS
;FastHWSPITransfer(BFSCMD | ECON1, temp)
	movlw	159
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;Select case banktobeselected
;case 1
SysSelect1Case1
	decf	BANKTOBESELECTED,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case2
;FastHWSPITransfer(b'00000001' , temp)
	movlw	1
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;case 2
	bra	SysSelectEnd1
SysSelect1Case2
	movlw	2
	subwf	BANKTOBESELECTED,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case3
;FastHWSPITransfer(b'00000010' , temp)
	movlw	2
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;case 3
	bra	SysSelectEnd1
SysSelect1Case3
	movlw	3
	subwf	BANKTOBESELECTED,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case4
;FastHWSPITransfer(b'00000011' , temp)
	movlw	3
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;End Select
SysSelect1Case4
SysSelectEnd1
;ENC28j60_Deselect
	bsf	LATA,5,ACCESS
;lastselectedBank = banktobeselected
	movff	BANKTOBESELECTED,LASTSELECTEDBANK
	return

;********************************************************************************

ENC28J60_SETIPADDRS
;T_ip_destaddr0 = T_ip_srcaddr0
	movff	SYSETHERBUFFER_27,SYSETHERBUFFER_31
;T_ip_destaddr1 = T_ip_srcaddr1
	movff	SYSETHERBUFFER_28,SYSETHERBUFFER_32
;T_ip_destaddr2 = T_ip_srcaddr2
	movff	SYSETHERBUFFER_29,SYSETHERBUFFER_33
;T_ip_destaddr3 = T_ip_srcaddr3
	movff	SYSETHERBUFFER_30,SYSETHERBUFFER_34
;T_ip_srcaddr0 = ipaddr(1)
	movff	SYSIPADDR_1,SYSETHERBUFFER_27
;T_ip_srcaddr1 = ipaddr(2)
	movff	SYSIPADDR_2,SYSETHERBUFFER_28
;T_ip_srcaddr2 = ipaddr(3)
	movff	SYSIPADDR_3,SYSETHERBUFFER_29
;T_ip_srcaddr3 = ipaddr(4)
	movff	SYSIPADDR_4,SYSETHERBUFFER_30
;ENC28j60_set_response_macaddress
	rcall	ENC28J60_SET_RESPONSE_MACADDRESS
;ENC28j60_Ip_header_checksum
	bra	ENC28J60_IP_HEADER_CHECKSUM

;********************************************************************************

ENC28J60_SET_RESPONSE_IPPACKET
;T_ip_destaddr0 = T_ip_srcaddr0
	movff	SYSETHERBUFFER_27,SYSETHERBUFFER_31
;T_ip_destaddr1 = T_ip_srcaddr1
	movff	SYSETHERBUFFER_28,SYSETHERBUFFER_32
;T_ip_destaddr2 = T_ip_srcaddr2
	movff	SYSETHERBUFFER_29,SYSETHERBUFFER_33
;T_ip_destaddr3 = T_ip_srcaddr3
	movff	SYSETHERBUFFER_30,SYSETHERBUFFER_34
;T_ip_srcaddr0 = ipaddr(1)
	movff	SYSIPADDR_1,SYSETHERBUFFER_27
;T_ip_srcaddr1 = ipaddr(2)
	movff	SYSIPADDR_2,SYSETHERBUFFER_28
;T_ip_srcaddr2 = ipaddr(3)
	movff	SYSIPADDR_3,SYSETHERBUFFER_29
;T_ip_srcaddr3 = ipaddr(4)
	movff	SYSIPADDR_4,SYSETHERBUFFER_30
;ENC28j60_set_response_macaddress
	rcall	ENC28J60_SET_RESPONSE_MACADDRESS
;ENC28j60_Ip_header_checksum
	bra	ENC28J60_IP_HEADER_CHECKSUM

;********************************************************************************

ENC28J60_SET_RESPONSE_MACADDRESS
;For II = 1 To 6
	clrf	II,BANKED
SysForLoop4
	incf	II,F,BANKED
;etherBuffer(II)= etherBuffer(6 + II)
	lfsr	0,ETHERBUFFER
	movlw	6
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp1,BANKED
	movlw	0
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movf	II,W,BANKED
	addwf	SysTemp1,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,SysArrayTemp2
	movff	SysArrayTemp2,SysArrayTemp1
	lfsr	0,ETHERBUFFER
	movf	II,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	SysArrayTemp1,INDF0
;Next
	movlw	6
	subwf	II,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop4
SysForLoopEnd4
;etherBuffer(7) = macaddr(1)
	movff	SYSMACADDR_1,SYSETHERBUFFER_7
;etherBuffer(8) = macaddr(2)
	movff	SYSMACADDR_2,SYSETHERBUFFER_8
;etherBuffer(9) = macaddr(3)
	movff	SYSMACADDR_3,SYSETHERBUFFER_9
;etherBuffer(10) = macaddr(4)
	movff	SYSMACADDR_4,SYSETHERBUFFER_10
;etherBuffer(11) = macaddr(5)
	movff	SYSMACADDR_5,SYSETHERBUFFER_11
;etherBuffer(12) = macaddr(6)
	movff	SYSMACADDR_6,SYSETHERBUFFER_12
	return

;********************************************************************************

ENC28J60_TCP_CHECKSUM
;Dim Whulp1 As Word
;Dim Tempword2 As Word
;dim I_chksum32 as long
;dim Hulp2, I_x as word
;tcp_cksum0 = 0x00
	banksel	SYSETHERBUFFER_51
	clrf	SYSETHERBUFFER_51,BANKED
;tcp_cksum1 = 0x00
	clrf	SYSETHERBUFFER_52,BANKED
;I_chksum32 = 0
	banksel	I_CHKSUM32
	clrf	I_CHKSUM32,BANKED
	clrf	I_CHKSUM32_H,BANKED
	clrf	I_CHKSUM32_U,BANKED
	clrf	I_CHKSUM32_E,BANKED
;I_value16_h = T_ip_srcaddr0
	movff	SYSETHERBUFFER_27,I_VALUE16_H
;[byte]I_value16 = T_ip_srcaddr1
	movff	SYSETHERBUFFER_28,I_VALUE16
;I_chksum32 = I_value16 + I_chksum32
	movf	I_CHKSUM32,W,BANKED
	addwf	I_VALUE16,W,ACCESS
	movwf	I_CHKSUM32,BANKED
	movf	I_CHKSUM32_H,W,BANKED
	addwfc	I_VALUE16_H,W,ACCESS
	movwf	I_CHKSUM32_H,BANKED
	clrf	SysTemp3,BANKED
	movf	I_CHKSUM32_U,W,BANKED
	addwfc	SysTemp3,W,BANKED
	movwf	I_CHKSUM32_U,BANKED
	clrf	SysTemp1,BANKED
	movf	I_CHKSUM32_E,W,BANKED
	addwfc	SysTemp1,W,BANKED
	movwf	I_CHKSUM32_E,BANKED
;I_value16_h = T_ip_srcaddr2
	movff	SYSETHERBUFFER_29,I_VALUE16_H
;[byte]I_value16 = T_ip_srcaddr3
	movff	SYSETHERBUFFER_30,I_VALUE16
;I_chksum32 = I_value16 + I_chksum32
	movf	I_CHKSUM32,W,BANKED
	addwf	I_VALUE16,W,ACCESS
	movwf	I_CHKSUM32,BANKED
	movf	I_CHKSUM32_H,W,BANKED
	addwfc	I_VALUE16_H,W,ACCESS
	movwf	I_CHKSUM32_H,BANKED
	clrf	SysTemp3,BANKED
	movf	I_CHKSUM32_U,W,BANKED
	addwfc	SysTemp3,W,BANKED
	movwf	I_CHKSUM32_U,BANKED
	clrf	SysTemp1,BANKED
	movf	I_CHKSUM32_E,W,BANKED
	addwfc	SysTemp1,W,BANKED
	movwf	I_CHKSUM32_E,BANKED
;I_value16_h = T_ip_destaddr0
	movff	SYSETHERBUFFER_31,I_VALUE16_H
;[byte]I_value16 = T_ip_destaddr1
	movff	SYSETHERBUFFER_32,I_VALUE16
;I_chksum32 = I_value16 + I_chksum32
	movf	I_CHKSUM32,W,BANKED
	addwf	I_VALUE16,W,ACCESS
	movwf	I_CHKSUM32,BANKED
	movf	I_CHKSUM32_H,W,BANKED
	addwfc	I_VALUE16_H,W,ACCESS
	movwf	I_CHKSUM32_H,BANKED
	clrf	SysTemp3,BANKED
	movf	I_CHKSUM32_U,W,BANKED
	addwfc	SysTemp3,W,BANKED
	movwf	I_CHKSUM32_U,BANKED
	clrf	SysTemp1,BANKED
	movf	I_CHKSUM32_E,W,BANKED
	addwfc	SysTemp1,W,BANKED
	movwf	I_CHKSUM32_E,BANKED
;I_value16_h = T_ip_destaddr2
	movff	SYSETHERBUFFER_33,I_VALUE16_H
;[byte]I_value16 = T_ip_destaddr3
	movff	SYSETHERBUFFER_34,I_VALUE16
;I_chksum32 = I_value16 + I_chksum32
	movf	I_CHKSUM32,W,BANKED
	addwf	I_VALUE16,W,ACCESS
	movwf	I_CHKSUM32,BANKED
	movf	I_CHKSUM32_H,W,BANKED
	addwfc	I_VALUE16_H,W,ACCESS
	movwf	I_CHKSUM32_H,BANKED
	clrf	SysTemp3,BANKED
	movf	I_CHKSUM32_U,W,BANKED
	addwfc	SysTemp3,W,BANKED
	movwf	I_CHKSUM32_U,BANKED
	clrf	SysTemp1,BANKED
	movf	I_CHKSUM32_E,W,BANKED
	addwfc	SysTemp1,W,BANKED
	movwf	I_CHKSUM32_E,BANKED
;I_chksum32 = I_chksum32 + T_ip_proto
	banksel	SYSETHERBUFFER_24
	movf	SYSETHERBUFFER_24,W,BANKED
	banksel	I_CHKSUM32
	addwf	I_CHKSUM32,F,BANKED
	movlw	0
	addwfc	I_CHKSUM32_H,F,BANKED
	movlw	0
	addwfc	I_CHKSUM32_U,F,BANKED
	movlw	0
	addwfc	I_CHKSUM32_E,F,BANKED
;ENC28j60_calc_ippartial_checksum
;I_value16 = T_ip_vers_len And 0x0F
	movlw	15
	banksel	SYSETHERBUFFER_15
	andwf	SYSETHERBUFFER_15,W,BANKED
	movwf	I_VALUE16,ACCESS
	clrf	I_VALUE16_H,ACCESS
;I_value16 = I_value16 * 4
	movff	I_VALUE16,SysWORDTempA
	movff	I_VALUE16_H,SysWORDTempA_H
	movlw	4
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	call	SysMultSub16
	movff	SysWORDTempX,I_VALUE16
	movff	SysWORDTempX_H,I_VALUE16_H
;I_chksum32 = I_chksum32 - I_value16
	movf	I_VALUE16,W,ACCESS
	subwf	I_CHKSUM32,F,BANKED
	movf	I_VALUE16_H,W,ACCESS
	subwfb	I_CHKSUM32_H,F,BANKED
	movlw	0
	subwfb	I_CHKSUM32_U,F,BANKED
	movlw	0
	subwfb	I_CHKSUM32_E,F,BANKED
;I_value16_h = T_ip_pktlen0
	movff	SYSETHERBUFFER_17,I_VALUE16_H
;[byte]I_value16 = T_ip_pktlen1
	movff	SYSETHERBUFFER_18,I_VALUE16
;I_chksum32 = I_value16 + I_chksum32
	movf	I_CHKSUM32,W,BANKED
	addwf	I_VALUE16,W,ACCESS
	movwf	I_CHKSUM32,BANKED
	movf	I_CHKSUM32_H,W,BANKED
	addwfc	I_VALUE16_H,W,ACCESS
	movwf	I_CHKSUM32_H,BANKED
	clrf	SysTemp3,BANKED
	movf	I_CHKSUM32_U,W,BANKED
	addwfc	SysTemp3,W,BANKED
	movwf	I_CHKSUM32_U,BANKED
	clrf	SysTemp1,BANKED
	movf	I_CHKSUM32_E,W,BANKED
	addwfc	SysTemp1,W,BANKED
	movwf	I_CHKSUM32_E,BANKED
;I_odd = I_value16 Mod 2
	movff	I_VALUE16,SysWORDTempA
	movff	I_VALUE16_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysDivSub16
	movff	SysWORDTempX,I_ODD
;Hulp2 = 0x23 + I_value16 - 22 'should be 20 bytes (for the IP Header ) be two bytes less for gcb For-next loop
	movlw	35
	addwf	I_VALUE16,W,ACCESS
	movwf	SysTemp2,BANKED
	movlw	0
	addwfc	I_VALUE16_H,W,ACCESS
	movwf	SysTemp2_H,BANKED
	movlw	22
	subwf	SysTemp2,W,BANKED
	movwf	HULP2,BANKED
	movlw	0
	subwfb	SysTemp2_H,W,BANKED
	movwf	HULP2_H,BANKED
;I_odd = T_udp_len1 Mod 2
	clrf	I_ODD,BANKED
	banksel	SYSETHERBUFFER_40
	btfss	SYSETHERBUFFER_40,0,BANKED
	bra	ENDIF78
	banksel	I_ODD
	incf	I_ODD,F,BANKED
ENDIF78
;If I_odd = 1 Then
	banksel	I_ODD
	decf	I_ODD,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF75
;Hulp2 =  Hulp2 + 1
	incf	HULP2,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	HULP2_H,F,BANKED
;etherbuffer( Hulp2 + 1 ) = 0x00
	lfsr	0,ETHERBUFFER
	movf	HULP2,W,BANKED
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp2,BANKED
	movf	HULP2_H,W,BANKED
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp2_H,BANKED
	movlw	1
	addwf	SysTemp2,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	clrf	INDF0,ACCESS
;End If
ENDIF75
;For I_x = 0x23 To Hulp2 Step 2
	movlw	33
	movwf	I_X,BANKED
	clrf	I_X_H,BANKED
	movlw	35
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	movff	HULP2,SysWORDTempA
	movff	HULP2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd7
SysForLoop7
	movlw	2
	addwf	I_X,F,BANKED
	movlw	0
	addwfc	I_X_H,F,BANKED
;I_value16_h = etherbuffer(i_x)
	lfsr	0,ETHERBUFFER
	movf	I_X,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	I_X_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movff	INDF0,I_VALUE16_H
;[byte]I_value16 = etherbuffer( i_x + 1 )
	lfsr	0,ETHERBUFFER
	movf	I_X,W,BANKED
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp2,BANKED
	movf	I_X_H,W,BANKED
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp2_H,BANKED
	movlw	1
	addwf	SysTemp2,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,I_VALUE16
;I_chksum32 = I_value16 + I_chksum32
	movf	I_CHKSUM32,W,BANKED
	addwf	I_VALUE16,W,ACCESS
	movwf	I_CHKSUM32,BANKED
	movf	I_CHKSUM32_H,W,BANKED
	addwfc	I_VALUE16_H,W,ACCESS
	movwf	I_CHKSUM32_H,BANKED
	clrf	SysTemp3,BANKED
	movf	I_CHKSUM32_U,W,BANKED
	addwfc	SysTemp3,W,BANKED
	movwf	I_CHKSUM32_U,BANKED
	clrf	SysTemp1,BANKED
	movf	I_CHKSUM32_E,W,BANKED
	addwfc	SysTemp1,W,BANKED
	movwf	I_CHKSUM32_E,BANKED
;Next
	movff	I_X,SysWORDTempA
	movff	I_X_H,SysWORDTempA_H
	movff	HULP2,SysWORDTempB
	movff	HULP2_H,SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop7
SysForLoopEnd7
;I_checksum16 = i_chksum32
	movff	I_CHKSUM32,I_CHECKSUM16
	movff	I_CHKSUM32_H,I_CHECKSUM16_H
;I_checksum16 = I_checksum16 + [byte]I_chksum32_u
	movf	I_CHKSUM32_U,W,BANKED
	addwf	I_CHECKSUM16,F,BANKED
	movlw	0
	addwfc	I_CHECKSUM16_H,F,BANKED
;I_checksum16 = Not [word]I_checksum16
	comf	I_CHECKSUM16,F,BANKED
	comf	I_CHECKSUM16_H,F,BANKED
;[byte]tcp_cksum0 = I_checksum16_h
	movff	I_CHECKSUM16_H,SYSETHERBUFFER_51
;[byte]tcp_cksum1 = I_checksum16
	movff	I_CHECKSUM16,SYSETHERBUFFER_52
	return

;********************************************************************************

ENC28J60_UDP_CHECKSUM
;dim I_chksum32 as long
;dim Hulp2, I_x as word
;T_udp_chksum0 = 0x00
	banksel	SYSETHERBUFFER_41
	clrf	SYSETHERBUFFER_41,BANKED
;T_udp_chksum1 = 0x00
	clrf	SYSETHERBUFFER_42,BANKED
	banksel	0
	return

;********************************************************************************

ENC28J60_UDP_HANDLER
;Uncomment to show UDP packet data
;select case T_udp_destport
;case 6000
SysSelect4Case1
	movff	T_UDP_DESTPORT,SysWORDTempA
	movff	T_UDP_DESTPORT_H,SysWORDTempA_H
	movlw	112
	movwf	SysWORDTempB,ACCESS
	movlw	23
	movwf	SysWORDTempB_H,ACCESS
	call	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect4Case2
;case 5000
	bra	SysSelectEnd4
SysSelect4Case2
	movff	T_UDP_DESTPORT,SysWORDTempA
	movff	T_UDP_DESTPORT_H,SysWORDTempA_H
	movlw	136
	movwf	SysWORDTempB,ACCESS
	movlw	19
	movwf	SysWORDTempB_H,ACCESS
	call	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect4Case3
;Select Case T_udp_data
;Case "A" : HSerPrint "Action A"
;Case "B" : HSerPrint "Action B"
;Case "C" : HSerPrint "Action C"
;Case "D" : HSerPrint "Action D"
;Case "E" : HSerPrint "Action E"
;Case "T" : HserPrint "Time..."
;Case "a" : HSerPrint "Action a"
;Case "b" : HSerPrint "Action b"
;Case "c" : HSerPrint "Action c"
;Case "d" : HSerPrint "Action d"
;Case "e" : HSerPrint "Action e"
;
;Case Else : HSerPrint "Action F"
;End Select
SysSelect5Case1
SysSelectEnd5
;'         HSerPrintCRLF
;end select
SysSelect4Case3
SysSelectEnd4
	return

;********************************************************************************

ENC28J60_WRITEBUFFER
;dim eth_counter as Word
;ENC28j60_writeReg(ewrptl, ENC_TXBUF_STL)
	movlw	2
	movwf	ADDR,BANKED
	movlw	112
	movwf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28j60_writeReg(ewrpth, ENC_TXBUF_STH)
	movlw	3
	movwf	ADDR,BANKED
	movlw	22
	movwf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28j60_Select
	bcf	LATA,5,ACCESS
;Set WCOL Off
	bcf	SSPCON1,WCOL,ACCESS
;SSPBUF = ENC28j60_write_buf_mem
	movlw	122
	movwf	SSPBUF,ACCESS
;Wait While BF = Off
SysWaitLoop15
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop15
;temp = SSPBUF
	movff	SSPBUF,TEMP
;SSPBUF = 0x0E
	movlw	14
	movwf	SSPBUF,ACCESS
;Wait While BF = Off
SysWaitLoop16
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop16
;temp = SSPBUF
	movff	SSPBUF,TEMP
;for eth_counter = 1 to pcktlen
	clrf	ETH_COUNTER,BANKED
	clrf	ETH_COUNTER_H,BANKED
	movlw	1
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	movff	PCKTLEN,SysWORDTempA
	movff	PCKTLEN_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd5
SysForLoop5
	incf	ETH_COUNTER,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	ETH_COUNTER_H,F,BANKED
;if eth_counter > etherBufferSize then Exit For
	movff	ETH_COUNTER,SysWORDTempB
	movff	ETH_COUNTER_H,SysWORDTempB_H
	movlw	88
	movwf	SysWORDTempA,ACCESS
	movlw	2
	movwf	SysWORDTempA_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd5
;SSPBUF = etherbuffer(eth_counter)
	lfsr	0,ETHERBUFFER
	movf	ETH_COUNTER,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	ETH_COUNTER_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movff	INDF0,SSPBUF
;Wait While BF = Off
SysWaitLoop17
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop17
;temp = SSPBUF
	movff	SSPBUF,TEMP
;next
	movff	ETH_COUNTER,SysWORDTempA
	movff	ETH_COUNTER_H,SysWORDTempA_H
	movff	PCKTLEN,SysWORDTempB
	movff	PCKTLEN_H,SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop5
SysForLoopEnd5
;ENC28j60_Deselect
	bsf	LATA,5,ACCESS
	return

;********************************************************************************

ENC28J60_WRITEPHYREG
;		while ((ENC28j60_ReadReg(MISTAT) & MISTAT_BUSY ) = MISTAT_BUSY )
SysDoLoop_S2
	movlw	234
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
;ENC28j60_writeReg( MIREGADR, PhyRegaddr )
	movlw	212
	movwf	ADDR,BANKED
	movff	PHYREGADDR,ENC_OUTBYTE
	rcall	ENC28J60_WRITEREG
;ENC28j60_writeReg( MIWRL, ENC_Outbyte1 )
	movlw	214
	movwf	ADDR,BANKED
	movff	ENC_OUTBYTE1,ENC_OUTBYTE
	rcall	ENC28J60_WRITEREG
;ENC28j60_writeReg( MIWRH, ENC_Outbyte2 )
	movlw	215
	movwf	ADDR,BANKED
	movff	ENC_OUTBYTE2,ENC_OUTBYTE
	rcall	ENC28J60_WRITEREG
;wait while ( (ENC28j60_ReadReg( MISTAT ) & MISTAT_BUSY ) = MISTAT_BUSY )
SysWaitLoop6
	movlw	234
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movlw	1
	andwf	ENC28J60_READREG,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SysBYTETempA
	movlw	1
	movwf	SysBYTETempB,ACCESS
	call	SysCompEqual
	btfsc	SysByteTempX,0,ACCESS
	bra	SysWaitLoop6
	return

;********************************************************************************

ENC28J60_WRITEREG
;				banktobeselected = ( addr & BANK_MASK) / 32
;banktobeselected =  ( addr & BANK_MASK)
	movlw	96
	andwf	ADDR,W,BANKED
	movwf	BANKTOBESELECTED,BANKED
;Repeat 5
	movlw	5
	movwf	SysRepeatTemp3,BANKED
SysRepeatLoop3
;set c off
	bcf	STATUS,C,ACCESS
;rotate banktobeselected right
	rrcf	BANKTOBESELECTED,F,BANKED
;end Repeat
	decfsz	SysRepeatTemp3,F,BANKED
	bra	SysRepeatLoop3
SysRepeatLoopEnd3
;if lastselectedBank <> banktobeselected then
	movf	BANKTOBESELECTED,W,BANKED
	subwf	LASTSELECTEDBANK,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ELSE8_1
;if ( ( addr & ADDR_MASK )  <= EIE  ) then
	movlw	31
	andwf	ADDR,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SysBYTETempB
	movlw	27
	movwf	SysBYTETempA,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	btfsc	SysByteTempX,0,ACCESS
;ENC28j60_selectBank ( banktobeselected, addr )
	rcall	ENC28J60_SELECTBANK
;end if
;Else
	bra	ENDIF8
ELSE8_1
;lastselectedBank = banktobeselected
	movff	BANKTOBESELECTED,LASTSELECTEDBANK
;end if
ENDIF8
;ENC28j60_Select
	bcf	LATA,5,ACCESS
;FastHWSPITransfer( ENC28j60_WRITE_CTRL_REG | (addr AND ADDR_MASK ), temp )
	movlw	31
	andwf	ADDR,W,BANKED
	movwf	SysTemp1,BANKED
	movlw	64
	iorwf	SysTemp1,W,BANKED
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;FastHWSPITransfer( ENC_Outbyte, temp )
	movff	ENC_OUTBYTE,SPITXDATA
	rcall	FASTHWSPITRANSFER
;ENC28j60_Deselect
	bsf	LATA,5,ACCESS
	return

;********************************************************************************

FASTHWSPITRANSFER
;Set SSPCON1.WCOL Off
	bcf	SSPCON1,WCOL,ACCESS
;SSPBUF = SPITxData
	movff	SPITXDATA,SSPBUF
;Wait While SSPSTAT.BF = Off
SysWaitLoop7
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop7
;Set SSPSTAT.BF Off
	bcf	SSPSTAT,BF,ACCESS
;SPIRxData = SSPBUF
	movff	SSPBUF,SPIRXDATA
	return

;********************************************************************************

FN_FNLSL
;dim SysLongTempB as long
;SysLongTempB  = BitsIn
;Repeat NumBits
	movff	NUMBITS,SysRepeatTemp9
	movf	SYSREPEATTEMP9,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd9
SysRepeatLoop9
;Set C Off
	bcf	STATUS,C,ACCESS
;Rotate SysLongTempB Left
	rlcf	SYSLONGTEMPB,F,ACCESS
	rlcf	SYSLONGTEMPB_H,F,ACCESS
	rlcf	SYSLONGTEMPB_U,F,ACCESS
	rlcf	SYSLONGTEMPB_E,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp9,F,BANKED
	bra	SysRepeatLoop9
SysRepeatLoopEnd9
;FnLSL = SysLongTempB
	movff	SYSLONGTEMPB,FNLSL
	movff	SYSLONGTEMPB_H,FNLSL_H
	movff	SYSLONGTEMPB_U,FNLSL_U
	movff	SYSLONGTEMPB_E,FNLSL_E
	return

;********************************************************************************

FN_FNLSR
;dim SysLongTempB as long
;SysLongTempB  = BitsIn
;Repeat NumBits
	movff	NUMBITS,SysRepeatTemp8
	movf	SYSREPEATTEMP8,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd8
SysRepeatLoop8
;Set C Off
	bcf	STATUS,C,ACCESS
;Rotate SysLongTempB Right
	rrcf	SYSLONGTEMPB_E,F,ACCESS
	rrcf	SYSLONGTEMPB_U,F,ACCESS
	rrcf	SYSLONGTEMPB_H,F,ACCESS
	rrcf	SYSLONGTEMPB,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp8,F,BANKED
	bra	SysRepeatLoop8
SysRepeatLoopEnd8
;FnLSR = SysLongTempB
	movff	SYSLONGTEMPB,FNLSR
	movff	SYSLONGTEMPB_H,FNLSR_H
	movff	SYSLONGTEMPB_U,FNLSR_U
	movff	SYSLONGTEMPB_E,FNLSR_E
	return

;********************************************************************************

;Overloaded signature: STRING:byte:
HSERPRINT257
;PrintLen = PrintData(0)
	movff	SysPRINTDATAHandler,AFSR0
	movff	SysPRINTDATAHandler_H,AFSR0_H
	movff	INDF0,PRINTLEN
;If PrintLen <> 0 then
	movf	PRINTLEN,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF13
;for SysPrintTemp = 1 to PrintLen
	clrf	SYSPRINTTEMP,BANKED
	movlw	1
	subwf	PRINTLEN,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd1
SysForLoop1
	incf	SYSPRINTTEMP,F,BANKED
;HSerSend(PrintData(SysPrintTemp),comport )
	movf	SYSPRINTTEMP,W,BANKED
	addwf	SysPRINTDATAHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,SERDATA
	rcall	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;next
	movf	PRINTLEN,W,BANKED
	subwf	SYSPRINTTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop1
SysForLoopEnd1
;End If
ENDIF13
	return

;********************************************************************************

;Overloaded signature: BYTE:byte:
HSERPRINT258
;OutValueTemp = 0
	clrf	OUTVALUETEMP,BANKED
;IF SerPrintVal >= 100 Then
	movlw	100
	subwf	SERPRINTVAL,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	ENDIF100
;OutValueTemp = SerPrintVal / 100
	movff	SERPRINTVAL,SysBYTETempA
	movlw	100
	movwf	SysBYTETempB,ACCESS
	call	SysDivSub
	movff	SysBYTETempA,OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movff	SYSCALCTEMPX,SERPRINTVAL
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W,BANKED
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;End If
ENDIF100
;If OutValueTemp > 0 Or SerPrintVal >= 10 Then
	movff	OUTVALUETEMP,SysBYTETempB
	clrf	SysBYTETempA,ACCESS
	call	SysCompLessThan
	movff	SysByteTempX,SysTemp3
	movff	SERPRINTVAL,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movf	SysTemp3,W,BANKED
	iorwf	SysByteTempX,W,ACCESS
	movwf	SysTemp1,BANKED
	btfss	SysTemp1,0,BANKED
	bra	ENDIF101
;OutValueTemp = SerPrintVal / 10
	movff	SERPRINTVAL,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	call	SysDivSub
	movff	SysBYTETempA,OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movff	SYSCALCTEMPX,SERPRINTVAL
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W,BANKED
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;End If
ENDIF101
;HSerSend(SerPrintVal + 48 ,comport)
	movlw	48
	addwf	SERPRINTVAL,W,BANKED
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	goto	Delay_MS

;********************************************************************************

;Overloaded signature: WORD:byte:
HSERPRINT259
;Dim SysCalcTempX As Word
;OutValueTemp = 0
	clrf	OUTVALUETEMP,BANKED
;If SerPrintVal >= 10000 then
	movff	SERPRINTVAL,SysWORDTempA
	movff	SERPRINTVAL_H,SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB,ACCESS
	movlw	39
	movwf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF102
;OutValueTemp = SerPrintVal / 10000 [word]
	movff	SERPRINTVAL,SysWORDTempA
	movff	SERPRINTVAL_H,SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB,ACCESS
	movlw	39
	movwf	SysWORDTempB_H,ACCESS
	call	SysDivSub16
	movff	SysWORDTempA,OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movff	SYSCALCTEMPX,SERPRINTVAL
	movff	SYSCALCTEMPX_H,SERPRINTVAL_H
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W,BANKED
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;Goto HSerPrintWord1000
	bra	HSERPRINTWORD1000
;End If
ENDIF102
;If SerPrintVal >= 1000 then
	movff	SERPRINTVAL,SysWORDTempA
	movff	SERPRINTVAL_H,SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB,ACCESS
	movlw	3
	movwf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF103
HSERPRINTWORD1000
;OutValueTemp = SerPrintVal / 1000 [word]
	movff	SERPRINTVAL,SysWORDTempA
	movff	SERPRINTVAL_H,SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB,ACCESS
	movlw	3
	movwf	SysWORDTempB_H,ACCESS
	call	SysDivSub16
	movff	SysWORDTempA,OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movff	SYSCALCTEMPX,SERPRINTVAL
	movff	SYSCALCTEMPX_H,SERPRINTVAL_H
;HSerSend(OutValueTemp + 48 ,comport  )
	movlw	48
	addwf	OUTVALUETEMP,W,BANKED
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;Goto HSerPrintWord100
	bra	HSERPRINTWORD100
;End If
ENDIF103
;If SerPrintVal >= 100 then
	movff	SERPRINTVAL,SysWORDTempA
	movff	SERPRINTVAL_H,SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF104
HSERPRINTWORD100
;OutValueTemp = SerPrintVal / 100 [word]
	movff	SERPRINTVAL,SysWORDTempA
	movff	SERPRINTVAL_H,SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysDivSub16
	movff	SysWORDTempA,OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movff	SYSCALCTEMPX,SERPRINTVAL
	movff	SYSCALCTEMPX_H,SERPRINTVAL_H
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W,BANKED
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;Goto HSerPrintWord10
	bra	HSERPRINTWORD10
;End If
ENDIF104
;If SerPrintVal >= 10 then
	movff	SERPRINTVAL,SysWORDTempA
	movff	SERPRINTVAL_H,SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF105
HSERPRINTWORD10
;OutValueTemp = SerPrintVal / 10 [word]
	movff	SERPRINTVAL,SysWORDTempA
	movff	SERPRINTVAL_H,SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysDivSub16
	movff	SysWORDTempA,OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movff	SYSCALCTEMPX,SERPRINTVAL
	movff	SYSCALCTEMPX_H,SERPRINTVAL_H
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W,BANKED
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;End If
ENDIF105
;HSerSend(SerPrintVal + 48 ,comport  )
	movlw	48
	addwf	SERPRINTVAL,W,BANKED
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	goto	Delay_MS

;********************************************************************************

HSERPRINTCRLF
;repeat HSerPrintCRLFCount
	movff	HSERPRINTCRLFCOUNT,SysRepeatTemp4
	movf	SYSREPEATTEMP4,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd4
SysRepeatLoop4
;HSerSend(13,comport)
	movlw	13
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;HSerSend(10,comport)
	movlw	10
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;end Repeat
	decfsz	SysRepeatTemp4,F,BANKED
	bra	SysRepeatLoop4
SysRepeatLoopEnd4
	return

;********************************************************************************

HSERSEND
;if comport = 1 Then
	decf	COMPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF12
;Wait While TXIF = Off
SysWaitLoop8
	btfss	PIR1,TXIF,ACCESS
	bra	SysWaitLoop8
;Wait While TXIF = Off
SysWaitLoop9
	btfss	PIR1,TXIF,ACCESS
	bra	SysWaitLoop9
;TXREG = SerData
	movff	SERDATA,TXREG
;end if
ENDIF12
	return

;********************************************************************************

HTTPPART3
;If Tcp_ack = 1 Then
	btfss	SYSBITVAR0,5,BANKED
	bra	ENDIF79
;If etherBuffer(17) = 0 Then
	banksel	SYSETHERBUFFER_17
	movf	SYSETHERBUFFER_17,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF80
;If etherBuffer(18) = 40 Then
	movlw	40
	subwf	SYSETHERBUFFER_18,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF81
;If Ackpsh = 1 Then
	banksel	ACKPSH
	decf	ACKPSH,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF82
;HSerPrint "ack&ackpush=1"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable78
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable78
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT257
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF
;arrayloc = 0x0037   'start of HTTP header within the TCP Packet
	movlw	55
	movwf	ARRAYLOC,BANKED
	clrf	ARRAYLOC_H,BANKED
;HSerPrint "TableStartPoint = "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable79
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable79
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT257
;HSerPrint TableStartPoint
	movff	TABLESTARTPOINT,SERPRINTVAL
	movff	TABLESTARTPOINT_H,SERPRINTVAL_H
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT259
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF
;if TableStartPoint = 1 then
	movff	TABLESTARTPOINT,SysWORDTempA
	movff	TABLESTARTPOINT_H,SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF83
;HTTPSentTCPPacket = 0
	clrf	HTTPSENTTCPPACKET,BANKED
;HTTPPrintStandardHeader ;print the header
	rcall	HTTPPRINTSTANDARDHEADER
;HTTPPrint( "", HTTPPrintCRLF )
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable22
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable22
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H,BANKED
	movlw	1
	movwf	HTTPPRINTCRLFFLAG,BANKED
	rcall	HTTPPRINT
;end if
ENDIF83
;eth_counter = 0
	clrf	ETH_COUNTER,BANKED
;commandlineString = ""
	lfsr	1,COMMANDLINESTRING
	movlw	low StringTable22
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable22
	movwf	TBLPTRH,ACCESS
	call	SysReadString
;For [word]TableLoc = TableStartPoint to SizeofTable1
	movlw	1
	subwf	TABLESTARTPOINT,W,BANKED
	movwf	TABLELOC,BANKED
	movlw	0
	subwfb	TABLESTARTPOINT_H,W,BANKED
	movwf	TABLELOC_H,BANKED
	movff	TABLESTARTPOINT,SysWORDTempB
	movff	TABLESTARTPOINT_H,SysWORDTempB_H
	movlw	35
	movwf	SysWORDTempA,ACCESS
	movlw	5
	movwf	SysWORDTempA_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd8
SysForLoop8
	incf	TABLELOC,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	TABLELOC_H,F,BANKED
;eth_counter += 1
	incf	ETH_COUNTER,F,BANKED
;ReadTable ivalid351, TableLoc, commandlineString(eth_counter)
	lfsr	0,COMMANDLINESTRING
	movf	ETH_COUNTER,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	TABLELOC,SYSSTRINGA
	movff	TABLELOC_H,SYSSTRINGA_H
	rcall	IVALID351
	movwf	INDF0,ACCESS
;commandlineString(0) = eth_counter
	movff	ETH_COUNTER,SYSCOMMANDLINESTRING_0
;eth_counter = eth_counter % 12
	movff	ETH_COUNTER,SysBYTETempA
	movlw	12
	movwf	SysBYTETempB,ACCESS
	call	SysDivSub
	movff	SysBYTETempX,ETH_COUNTER
;if eth_counter = 0 then
	movf	ETH_COUNTER,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF85
;HTTPPrint( commandlineString )
	movlw	low COMMANDLINESTRING
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high COMMANDLINESTRING
	movwf	SysHTTPDATAHandler_H,BANKED
	clrf	HTTPPRINTCRLFFLAG,BANKED
	rcall	HTTPPRINT
;if HTTPSentTCPPacket = 1 then
	decf	HTTPSENTTCPPACKET,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF88
;HSerPrint "exiting@1 "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable80
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable80
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT257
;TableStartPoint = TableLoc - 11
	movlw	11
	subwf	TABLELOC,W,BANKED
	movwf	TABLESTARTPOINT,BANKED
	movlw	0
	subwfb	TABLELOC_H,W,BANKED
	movwf	TABLESTARTPOINT_H,BANKED
;HTTPSentTCPPacket = 0
	clrf	HTTPSENTTCPPACKET,BANKED
;exit sub
	return
;end if
ENDIF88
;commandlineString = ""
	lfsr	1,COMMANDLINESTRING
	movlw	low StringTable22
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable22
	movwf	TBLPTRH,ACCESS
	call	SysReadString
;end if
ENDIF85
;Next
	movff	TABLELOC,SysWORDTempA
	movff	TABLELOC_H,SysWORDTempA_H
	movlw	35
	movwf	SysWORDTempB,ACCESS
	movlw	5
	movwf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop8
SysForLoopEnd8
;eth_counter = eth_counter - 2
;if eth_counter <> 0 then
	movf	ETH_COUNTER,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF87
;ReadTable ivalid351, TableLoc, commandlineString( eth_counter )
	lfsr	0,COMMANDLINESTRING
	movf	ETH_COUNTER,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	TABLELOC,SYSSTRINGA
	movff	TABLELOC_H,SYSSTRINGA_H
	rcall	IVALID351
	movwf	INDF0,ACCESS
;commandlineString(0) = eth_counter
	movff	ETH_COUNTER,SYSCOMMANDLINESTRING_0
;HTTPPrint( commandlineString )
	movlw	low COMMANDLINESTRING
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high COMMANDLINESTRING
	movwf	SysHTTPDATAHandler_H,BANKED
	clrf	HTTPPRINTCRLFFLAG,BANKED
	rcall	HTTPPRINT
;if HTTPSentTCPPacket = 1 then
	decf	HTTPSENTTCPPACKET,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF89
;HSerPrint "exiting@2 "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable81
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable81
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT257
;TableStartPoint = TableLoc - 1
	movlw	1
	subwf	TABLELOC,W,BANKED
	movwf	TABLESTARTPOINT,BANKED
	movlw	0
	subwfb	TABLELOC_H,W,BANKED
	movwf	TABLESTARTPOINT_H,BANKED
;exit sub
	return
;end if
ENDIF89
;end if
ENDIF87
;HSerPrint "HTTPSend@3"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable82
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable82
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT257
;HTTPSend
	setf	HTTPCLOSETRANSACTION,BANKED
	rcall	HTTPSEND
;commandlineString="index.htm"
	lfsr	1,COMMANDLINESTRING
	movlw	low StringTable19
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable19
	movwf	TBLPTRH,ACCESS
	call	SysReadString
;End If
ENDIF82
;End If
ENDIF81
;End If
ENDIF80
;End If
ENDIF79
	banksel	0
	return

;********************************************************************************

HTTPPART4
;' If an ACK and FIN is received and the destination port address is valid
;If Tcp_ack = 1 Then
	btfss	SYSBITVAR0,5,BANKED
	bra	ENDIF90
;If Tcp_fin = 1 Then
	btfss	SYSBITVAR0,1,BANKED
	bra	ENDIF91
;HSerPrint "ack&fin"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable83
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable83
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT257
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF
;'set flags
;Tcp_flags = 0
	banksel	SYSETHERBUFFER_48
	clrf	SYSETHERBUFFER_48,BANKED
;Tcp_flags.4 = 1                           'ack
	bsf	SYSETHERBUFFER_48,4,BANKED
;T_ip_destaddr0 = T_ip_srcaddr0
	movff	SYSETHERBUFFER_27,SYSETHERBUFFER_31
;T_ip_destaddr1 = T_ip_srcaddr1
	movff	SYSETHERBUFFER_28,SYSETHERBUFFER_32
;T_ip_destaddr2 = T_ip_srcaddr2
	movff	SYSETHERBUFFER_29,SYSETHERBUFFER_33
;T_ip_destaddr3 = T_ip_srcaddr3
	movff	SYSETHERBUFFER_30,SYSETHERBUFFER_34
;T_ip_srcaddr0 = ipaddr(1)
	movff	SYSIPADDR_1,SYSETHERBUFFER_27
;T_ip_srcaddr1 = ipaddr(2)
	movff	SYSIPADDR_2,SYSETHERBUFFER_28
;T_ip_srcaddr2 = ipaddr(3)
	movff	SYSIPADDR_3,SYSETHERBUFFER_29
;T_ip_srcaddr3 = ipaddr(4)
	movff	SYSIPADDR_4,SYSETHERBUFFER_30
;Swap Tcp_srcportl , Tcp_destportl
	movff	SYSETHERBUFFER_36,SYSCALCTEMPA
	movff	SYSETHERBUFFER_38,SYSCALCTEMPB
	banksel	0
	call	SWAP98
	movff	SYSCALCTEMPA,SYSETHERBUFFER_36
	movff	SYSCALCTEMPB,SYSETHERBUFFER_38
;Swap Tcp_srcporth , Tcp_destporth
	movff	SYSETHERBUFFER_35,SYSCALCTEMPA
	movff	SYSETHERBUFFER_37,SYSCALCTEMPB
	call	SWAP98
	movff	SYSCALCTEMPA,SYSETHERBUFFER_35
	movff	SYSCALCTEMPB,SYSETHERBUFFER_37
;'swap mac
;ENC28j60_Packetshape
	call	ENC28J60_PACKETSHAPE
;[byte]Client_seqnum_E = Tcp_seqnum3
	movff	SYSETHERBUFFER_39,CLIENT_SEQNUM_E
;[byte]Client_seqnum_U = Tcp_seqnum2
	movff	SYSETHERBUFFER_40,CLIENT_SEQNUM_U
;[byte]Client_seqnum_H = Tcp_seqnum1
	movff	SYSETHERBUFFER_41,CLIENT_SEQNUM_H
;[byte]Client_seqnum   = Tcp_seqnum0
	movff	SYSETHERBUFFER_42,CLIENT_SEQNUM
;Tcp_seqnum0 = Tcp_acknum0
	movff	SYSETHERBUFFER_46,SYSETHERBUFFER_42
;Tcp_seqnum1 = Tcp_acknum1
	movff	SYSETHERBUFFER_45,SYSETHERBUFFER_41
;Tcp_seqnum2 = Tcp_acknum2
	movff	SYSETHERBUFFER_44,SYSETHERBUFFER_40
;Tcp_seqnum3 = Tcp_acknum3
	movff	SYSETHERBUFFER_43,SYSETHERBUFFER_39
;Client_seqnum = Client_seqnum + 1
	incf	CLIENT_SEQNUM,F,BANKED
;Tcp_acknum0 = Client_seqnum
	movff	CLIENT_SEQNUM,SYSETHERBUFFER_46
;Tcp_acknum1 = Client_seqnum_H
	movff	CLIENT_SEQNUM_H,SYSETHERBUFFER_45
;Tcp_acknum2 = Client_seqnum_U
	movff	CLIENT_SEQNUM_U,SYSETHERBUFFER_44
;Tcp_acknum3 = Client_seqnum_E
	movff	CLIENT_SEQNUM_E,SYSETHERBUFFER_43
;etherBuffer(17) = 0
	banksel	SYSETHERBUFFER_17
	clrf	SYSETHERBUFFER_17,BANKED
;etherBuffer(18) = 40
	movlw	40
	movwf	SYSETHERBUFFER_18,BANKED
;'5 x 4 = 20 bytes
;etherBuffer(47) = 0x50
	movlw	80
	movwf	SYSETHERBUFFER_47,BANKED
;'flag ACK
;etherBuffer(48) = 0x10
	movlw	16
	movwf	SYSETHERBUFFER_48,BANKED
;
;etherBuffer(49) = 0x00
	clrf	SYSETHERBUFFER_49,BANKED
;etherBuffer(50) = 0x72
	movlw	114
	movwf	SYSETHERBUFFER_50,BANKED
;'padding
;etherBuffer(55) = 0x00
	clrf	SYSETHERBUFFER_55,BANKED
;etherBuffer(56) = 0x00
	clrf	SYSETHERBUFFER_56,BANKED
;etherBuffer(57) = 0x00
	clrf	SYSETHERBUFFER_57,BANKED
;etherBuffer(58) = 0x00
	clrf	SYSETHERBUFFER_58,BANKED
;etherBuffer(59) = 0x00
	clrf	SYSETHERBUFFER_59,BANKED
;etherBuffer(60) = 0x00
	clrf	SYSETHERBUFFER_60,BANKED
;ENC28j60_ip_header_checksum
	banksel	0
	call	ENC28J60_IP_HEADER_CHECKSUM
;ENC28j60_tcp_checksum
	call	ENC28J60_TCP_CHECKSUM
;T_ip_pktlen0 = 0
	banksel	SYSETHERBUFFER_17
	clrf	SYSETHERBUFFER_17,BANKED
;T_ip_pktlen1 = 40
	movlw	40
	movwf	SYSETHERBUFFER_18,BANKED
;ENC28j60_writebuffer(60)
	movlw	60
	banksel	PCKTLEN
	movwf	PCKTLEN,BANKED
	clrf	PCKTLEN_H,BANKED
	rcall	ENC28J60_WRITEBUFFER
;ENC28j60_packetsend(60)
	movlw	60
	movwf	PCKTLEN,BANKED
	clrf	PCKTLEN_H,BANKED
	call	ENC28J60_PACKETSEND
;End If
ENDIF91
;End If
ENDIF90
	return

;********************************************************************************

HTTPPRINT
;HSerPrint HTTPData
;HSerPrintCRLF
;dim hulp2 as word
;hulp2 = arrayloc + HTTPData(0) + 6
	movff	SysHTTPDATAHandler,AFSR0
	movff	SysHTTPDATAHandler_H,AFSR0_H
	movf	INDF0,W,ACCESS
	addwf	ARRAYLOC,W,BANKED
	movwf	SysTemp2,BANKED
	movlw	0
	addwfc	ARRAYLOC_H,W,BANKED
	movwf	SysTemp2_H,BANKED
	movlw	6
	addwf	SysTemp2,W,BANKED
	movwf	HULP2,BANKED
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	HULP2_H,BANKED
;If hulp2 > etherBufferSize Then
	movff	HULP2,SysWORDTempB
	movff	HULP2_H,SysWORDTempB_H
	movlw	88
	movwf	SysWORDTempA,ACCESS
	movlw	2
	movwf	SysWORDTempA_H,ACCESS
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF92
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF
;HSerPrint "empty the buffer"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable85
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable85
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT257
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF
;HTTPSend ( false )
	clrf	HTTPCLOSETRANSACTION,BANKED
	rcall	HTTPSEND
;arrayloc = 0x0037   'start of HTTP header within the TCP Packet
	movlw	55
	movwf	ARRAYLOC,BANKED
	clrf	ARRAYLOC_H,BANKED
;HTTPSentTCPPacket = 1
	movlw	1
	movwf	HTTPSENTTCPPACKET,BANKED
;End IF
ENDIF92
;For currbyte = 1 to HTTPData(0)
	clrf	CURRBYTE,BANKED
	movff	SysHTTPDATAHandler,AFSR0
	movff	SysHTTPDATAHandler_H,AFSR0_H
	movlw	1
	subwf	INDF0,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd9
SysForLoop9
	incf	CURRBYTE,F,BANKED
;etherBuffer(arrayloc) = HTTPData(currbyte)
	movf	CURRBYTE,W,BANKED
	addwf	SysHTTPDATAHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysHTTPDATAHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,SysArrayTemp1
	movff	SysArrayTemp1,SysArrayTemp2
	lfsr	0,ETHERBUFFER
	movf	ARRAYLOC,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	ARRAYLOC_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movff	SysArrayTemp2,INDF0
;arrayloc += 1
	incf	ARRAYLOC,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	ARRAYLOC_H,F,BANKED
;Next
	movff	SysHTTPDATAHandler,AFSR0
	movff	SysHTTPDATAHandler_H,AFSR0_H
	movf	INDF0,W,ACCESS
	subwf	CURRBYTE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop9
SysForLoopEnd9
;if HTTPPrintCRLFflag = 1 then
	decf	HTTPPRINTCRLFFLAG,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF95
;etherBuffer(arrayloc) = 0x0d: arrayloc += 1
	lfsr	0,ETHERBUFFER
	movf	ARRAYLOC,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	ARRAYLOC_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movlw	13
	movwf	INDF0,ACCESS
	incf	ARRAYLOC,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	ARRAYLOC_H,F,BANKED
;etherBuffer(arrayloc) = 0x0a: arrayloc += 1
	lfsr	0,ETHERBUFFER
	movf	ARRAYLOC,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	ARRAYLOC_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movlw	10
	movwf	INDF0,ACCESS
	incf	ARRAYLOC,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	ARRAYLOC_H,F,BANKED
;end if
ENDIF95
	return

;********************************************************************************

HTTPPRINTSTANDARDHEADER
;HTTPPrint( "HTTP/1.0 200 OK", HTTPPrintCRLF )
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable84
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable84
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H,BANKED
	movlw	1
	movwf	HTTPPRINTCRLFFLAG,BANKED
	rcall	HTTPPRINT
;HTTPPrint( "X-Pad: avoid browser bug", HTTPPrintCRLF )
;bad        HTTPPrint( "Cache-Control: no-cache, no-store, must-revalidate", HTTPPrintCRLF )
;HTTPPrint( "Pragma: no-cache", HTTPPrintCRLF )
;HTTPPrint( "Content-Type: text/html", HTTPPrintCRLF )
;HTTPPrint( "<!DOCTYPE HTML>", HTTPPrintCRLF )
	return

;********************************************************************************

HTTPSEND
;HSerPrintCRLF
;HSerPrint "HTTPSend = "
;HSerPrintCRLF HTTPCloseTransaction
;Tcp_flags = 0
	banksel	SYSETHERBUFFER_48
	clrf	SYSETHERBUFFER_48,BANKED
;Tcp_flags.4  = 1                          'ack
	bsf	SYSETHERBUFFER_48,4,BANKED
;if HTTPCloseTransaction = true then
	banksel	HTTPCLOSETRANSACTION
	incf	HTTPCLOSETRANSACTION,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE96_1
;Tcp_flags.3  = 1                          'psh
	banksel	SYSETHERBUFFER_48
	bsf	SYSETHERBUFFER_48,3,BANKED
;Tcp_flags.0  = 1                          'fin
	bsf	SYSETHERBUFFER_48,0,BANKED
;etherBuffer(arrayloc) = 0x0d: arrayloc = arrayloc +1
	lfsr	0,ETHERBUFFER
	banksel	ARRAYLOC
	movf	ARRAYLOC,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	ARRAYLOC_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movlw	13
	movwf	INDF0,ACCESS
	incf	ARRAYLOC,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	ARRAYLOC_H,F,BANKED
;etherBuffer(arrayloc) = 0x0a: arrayloc = arrayloc +1
	lfsr	0,ETHERBUFFER
	movf	ARRAYLOC,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	ARRAYLOC_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movlw	10
	movwf	INDF0,ACCESS
	incf	ARRAYLOC,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	ARRAYLOC_H,F,BANKED
;etherBuffer(arrayloc) = 0x0d: arrayloc = arrayloc +1
	lfsr	0,ETHERBUFFER
	movf	ARRAYLOC,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	ARRAYLOC_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movlw	13
	movwf	INDF0,ACCESS
	incf	ARRAYLOC,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	ARRAYLOC_H,F,BANKED
;etherBuffer(arrayloc) = 0x0a: arrayloc = arrayloc +1
	lfsr	0,ETHERBUFFER
	movf	ARRAYLOC,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	ARRAYLOC_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movlw	10
	movwf	INDF0,ACCESS
	incf	ARRAYLOC,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	ARRAYLOC_H,F,BANKED
;arrayloc = arrayloc - 1
	movlw	1
	subwf	ARRAYLOC,F,BANKED
	movlw	0
	subwfb	ARRAYLOC_H,F,BANKED
;if arrayloc Mod 2 = 0 then
	movff	ARRAYLOC,SysWORDTempA
	movff	ARRAYLOC_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysDivSub16
	movff	SysWORDTempX,SysTemp2
	movff	SysWORDTempX_H,SysTemp2_H
	movff	SysTemp2,SysWORDTempA
	movff	SysTemp2_H,SysWORDTempA_H
	clrf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF97
;HSerPrint "  PAD! "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable86
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable86
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT257
;arrayloc += 1
	incf	ARRAYLOC,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	ARRAYLOC_H,F,BANKED
;etherBuffer(arrayloc) = 0x00 'added to pad out, should the
	lfsr	0,ETHERBUFFER
	movf	ARRAYLOC,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	ARRAYLOC_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	clrf	INDF0,ACCESS
;end if
ENDIF97
;Ackpsh = 0
	clrf	ACKPSH,BANKED
;
;HSerPrintCRLF
;FOR hulp2 = 0X0037 TO arrayloc
;HSerSend etherbuffer(HULP2)
;Next
;HSerPrintCRLF
;Else
	bra	ENDIF96
ELSE96_1
;arrayloc = arrayloc - 1
	movlw	1
	subwf	ARRAYLOC,F,BANKED
	movlw	0
	subwfb	ARRAYLOC_H,F,BANKED
;Tcp_flags.3  = 0                          'psh
	banksel	SYSETHERBUFFER_48
	bcf	SYSETHERBUFFER_48,3,BANKED
;Tcp_flags.0  = 0
	bcf	SYSETHERBUFFER_48,0,BANKED
;end if
ENDIF96
;HSerPrintCRLF
	movlw	1
	banksel	HSERPRINTCRLFCOUNT
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF
;HSerPrint "Send:"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable87
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable87
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT257
;HSerPrint T_ip_srcaddr0
	movff	SYSETHERBUFFER_27,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT258
;HSerPrint ","
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable47
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable47
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT257
;HSerPrint T_ip_srcaddr1
	movff	SYSETHERBUFFER_28,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT258
;HSerPrint ","
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable47
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable47
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT257
;HSerPrint T_ip_srcaddr2
	movff	SYSETHERBUFFER_29,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT258
;HSerPrint ","
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable47
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable47
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT257
;HSerPrint T_ip_srcaddr3
	movff	SYSETHERBUFFER_30,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT258
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF
;Tcp_acknum0 = Incoming_ack
	movff	INCOMING_ACK,SYSETHERBUFFER_46
;Tcp_acknum1 = Incoming_ack_H
	movff	INCOMING_ACK_H,SYSETHERBUFFER_45
;Tcp_acknum2 = Incoming_ack_U
	movff	INCOMING_ACK_U,SYSETHERBUFFER_44
;Tcp_acknum3 = Incoming_ack_E
	movff	INCOMING_ACK_E,SYSETHERBUFFER_43
;TCPresult16 = [word]arrayloc - [byte]IP_HeaderSize
	movlw	14
	subwf	ARRAYLOC,W,BANKED
	movwf	TCPRESULT16,BANKED
	movlw	0
	subwfb	ARRAYLOC_H,W,BANKED
	movwf	TCPRESULT16_H,BANKED
;HSerSend 9
	movlw	9
	movwf	SERDATA,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERSEND
;HSerPrint "B/Wire:"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable88
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable88
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT257
;HSerPrint ( TCPresult16 + [byte]IP_HeaderSize )
	movlw	14
	addwf	TCPRESULT16,W,BANKED
	movwf	SERPRINTVAL,BANKED
	movlw	0
	addwfc	TCPRESULT16_H,W,BANKED
	movwf	SERPRINTVAL_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT259
;HSerPrint ", TCP Pkt:"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable89
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable89
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT257
;HSerPrint ( TCPresult16 - 40 )
	movlw	40
	subwf	TCPRESULT16,W,BANKED
	movwf	SERPRINTVAL,BANKED
	movlw	0
	subwfb	TCPRESULT16_H,W,BANKED
	movwf	SERPRINTVAL_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT259
;HSerPrint ", HTML:"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable90
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable90
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT257
;HSerPrint ( TCPresult16 - 88 )
	movlw	88
	subwf	TCPRESULT16,W,BANKED
	movwf	SERPRINTVAL,BANKED
	movlw	0
	subwfb	TCPRESULT16_H,W,BANKED
	movwf	SERPRINTVAL_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT259
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF
;T_ip_pktlen0 = TCPresult16_H                             'HTML-code + 40
	movff	TCPRESULT16_H,SYSETHERBUFFER_17
;T_ip_pktlen1 = TCPresult16
	movff	TCPRESULT16,SYSETHERBUFFER_18
;ENC28j60_ip_header_checksum
	call	ENC28J60_IP_HEADER_CHECKSUM
;ENC28j60_tcp_checksum
	call	ENC28J60_TCP_CHECKSUM
;ENC28j60_writebuffer( TCPresult16 + IP_HeaderSize   )
	movlw	14
	addwf	TCPRESULT16,W,BANKED
	movwf	PCKTLEN,BANKED
	movlw	0
	addwfc	TCPRESULT16_H,W,BANKED
	movwf	PCKTLEN_H,BANKED
	call	ENC28J60_WRITEBUFFER
;ENC28j60_packetsend( TCPresult16 + IP_HeaderSize   )
	movlw	14
	addwf	TCPRESULT16,W,BANKED
	movwf	PCKTLEN,BANKED
	movlw	0
	addwfc	TCPRESULT16_H,W,BANKED
	movwf	PCKTLEN_H,BANKED
	goto	ENC28J60_PACKETSEND

;********************************************************************************

INITSYS
;BSR = 0
	clrf	BSR,ACCESS
;TBLPTRU = 0
	clrf	TBLPTRU,ACCESS
;SET ADFM OFF
	bcf	ADCON2,ADFM,ACCESS
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON,ACCESS
;SET PCFG3 ON
	bsf	ADCON1,PCFG3,ACCESS
;SET PCFG2 ON
	bsf	ADCON1,PCFG2,ACCESS
;SET PCFG1 ON
	bsf	ADCON1,PCFG1,ACCESS
;SET PCFG0 ON
	bsf	ADCON1,PCFG0,ACCESS
;		CMCON = 7
	movlw	7
	movwf	CMCON,ACCESS
;PORTA = 0
	clrf	PORTA,ACCESS
;PORTB = 0
	clrf	PORTB,ACCESS
;PORTC = 0
	clrf	PORTC,ACCESS
;PORTD = 0
	clrf	PORTD,ACCESS
;PORTE = 0
	clrf	PORTE,ACCESS
	return

;********************************************************************************

INITUSART
;comport = 1
	movlw	1
	movwf	COMPORT,BANKED
;SPBRG = SPBRGL_TEMP
	movlw	42
	movwf	SPBRG,ACCESS
;SPBRGH = SPBRGH_TEMP
	clrf	SPBRGH,ACCESS
;BRG16 = BRG16_TEMP
	bsf	BAUDCON,BRG16,ACCESS
;BRGH = BRGH_TEMP
	bsf	TXSTA,BRGH,ACCESS
;Set SYNC Off
	bcf	TXSTA,SYNC,ACCESS
;Set SPEN On
	bsf	RCSTA,SPEN,ACCESS
;Set CREN On
	bsf	RCSTA,CREN,ACCESS
;Set TXEN On
	bsf	TXSTA,TXEN,ACCESS
;PIC USART 2 Init
	return

;********************************************************************************

IVALID351
	movff	SYSSTRINGA,SysWORDTempA
	movff	SYSSTRINGA_H,SysWORDTempA_H
	movlw	36
	movwf	SysWORDTempB,ACCESS
	movlw	5
	movwf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableIVALID351
	movwf	TBLPTRL,ACCESS
	movlw	high TableIVALID351
	btfsc	STATUS, C,ACCESS
	addlw	1
	addwf	SysStringA_H, W,ACCESS
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableIVALID351
	db	35,60,33,68,79,67,84,89,80,69,32,104,116,109,108,32,80,85,66,76,73,67,32,34,45,47
	db	47,87,51,67,47,47,68,84,68,32,72,84,77,76,32,52,46,48,49,32,84,114,97,110,115,105
	db	116,105,111,110,97,108,47,47,69,78,34,62,60,104,116,109,108,62,60,104,101,97
	db	100,62,60,116,105,116,108,101,62,60,47,116,105,116,108,101,62,60,115,116,121,108
	db	101,32,116,121,112,101,61,34,116,101,120,116,47,99,115,115,34,62,115,112,97,110
	db	46,99,55,32,123,102,111,110,116,45,102,97,109,105,108,121,58,32,104,101,108,118
	db	101,116,105,99,97,125,115,112,97,110,46,99,54,32,123,102,111,110,116,45,115,105
	db	122,101,58,32,55,48,37,125,105,109,103,46,99,53,32,123,102,108,111,97,116,58,32,114
	db	105,103,104,116,59,125,100,105,118,46,99,52,32,123,116,101,120,116,45,97,108,105
	db	103,110,58,32,99,101,110,116,101,114,125,112,46,99,51,32,123,102,111,110,116,45
	db	102,97,109,105,108,121,58,32,104,101,108,118,101,116,105,99,97,125,115,116,114,111
	db	110,103,46,99,50,32,123,116,101,120,116,45,100,101,99,111,114,97,116,105,111,110
	db	58,32,117,110,100,101,114,108,105,110,101,125,115,112,97,110,46,99,49,32,123,99
	db	111,108,111,114,58,32,35,48,48,48,48,70,70,59,32,102,111,110,116,45,115,105,122,101
	db	58,32,49,53,48,37,125,60,47,115,116,121,108,101,62,60,47,104,101,97,100,62,60,98
	db	111,100,121,62,60,100,105,118,32,99,108,97,115,115,61,34,99,52,34,62,60,112,32,99
	db	108,97,115,115,61,34,99,51,34,62,60,97,32,116,97,114,103,101,116,61,34,95,98,108
	db	97,110,107,34,32,104,114,101,102,61,34,104,116,116,112,58,47,47,115,111,117,114
	db	99,101,102,111,114,103,101,46,110,101,116,47,112,47,103,99,98,97,115,105,99,34
	db	62,60,115,116,114,111,110,103,32,99,108,97,115,115,61,34,99,50,34,62,60,115,112,97
	db	110,32,99,108,97,115,115,61,34,99,49,34,62,71,114,101,97,116,32,67,111,119,32,66
	db	65,83,73,67,32,84,67,80,47,73,80,32,83,116,97,99,107,60,47,115,112,97,110,62,60,47
	db	115,116,114,111,110,103,62,60,47,97,62,60,47,112,62,60,47,100,105,118,62,60,115,112
	db	97,110,32,111,110,99,108,105,99,107,61,34,116,104,105,115,46,115,116,121,108,101
	db	46,99,111,108,111,114,32,61,32,39,98,108,117,101,39,34,32,99,108,97,115,115,61,34
	db	99,55,34,62,60,98,114,62,60,98,114,62,84,104,105,115,32,112,97,103,101,32,105,115
	db	32,115,101,114,118,101,100,32,98,121,32,97,32,71,67,66,32,72,84,84,80,32,181,83
	db	101,114,118,101,114,46,48,51,53,32,102,114,111,109,32,97,32,49,54,70,49,56,56,53
	db	53,32,77,105,99,114,111,99,104,105,112,32,109,105,99,114,111,99,111,110,116,114
	db	111,108,108,101,114,32,117,115,105,110,103,32,97,110,32,69,78,67,50,56,74,54,48,32
	db	69,116,104,101,114,110,101,116,32,99,111,110,116,114,111,108,108,101,114,46,60,98
	db	114,62,60,98,114,62,84,104,105,115,32,112,97,103,101,32,111,102,32,72,84,77,76,32
	db	105,116,32,105,115,32,98,101,105,110,103,32,112,114,111,99,101,115,115,101,100,32
	db	97,115,32,109,117,108,116,105,112,108,101,32,84,67,80,32,72,84,77,76,32,112,97,99
	db	107,101,116,115,44,32,97,115,32,116,104,101,32,72,84,77,76,32,101,120,99,101
	db	101,100,115,32,116,104,101,32,32,109,101,109,111,114,121,32,98,117,102,102,101,114
	db	46,32,84,104,101,32,109,101,109,111,114,121,32,98,117,102,102,101,114,32,105,115
	db	32,54,48,48,32,98,121,116,101,115,32,97,110,100,32,116,104,101,32,72,84,77,76,32
	db	105,115,32,111,118,101,114,32,49,50,48,48,32,98,121,116,101,115,46,32,83,111,44,32
	db	119,101,32,109,117,115,116,32,98,101,32,112,97,115,115,105,110,103,32,109,111,114
	db	101,32,116,104,97,110,32,111,110,101,32,84,67,80,32,112,97,99,107,101,116,32
	db	116,111,32,99,111,110,115,116,114,117,99,116,32,116,104,101,32,72,84,77,76,32
	db	116,114,97,110,115,97,99,116,105,111,110,46,60,98,114,62,60,98,114,62,84,104
	db	105,115,32,112,97,103,101,32,105,115,32,104,101,108,100,32,97,115,32,97,32,116
	db	97,98,108,101,32,119,105,116,104,105,110,32,116,104,101,32,71,114,101,97,116,32
	db	67,111,119,32,66,65,83,73,67,32,115,111,117,114,99,101,32,102,105,108,101,32,97,115
	db	32,116,104,105,115,32,119,105,108,108,32,98,101,32,116,104,101,32,100,101,102,97
	db	117,108,116,32,119,101,98,32,112,97,103,101,32,109,101,116,104,111,100,46,60,98
	db	114,62,60,98,114,62,79,112,101,114,97,116,105,110,103,32,111,110,32,100,101,118
	db	105,99,101,95,49,57,50,95,49,54,56,95,48,95,51,60,98,114,62,60,98,114,62,60,105,109
	db	103,32,99,108,97,115,115,61,34,99,53,34,32,115,114,99,61,34,104,116,116,112,58,47
	db	47,103,111,111,46,103,108,47,49,86,104,56,118,77,34,32,97,108,116,61,34,65,110,111
	db	98,105,117,109,39,115,32,76,111,103,111,34,62,60,98,114,62,60,98,114,62,60,115,112
	db	97,110,32,111,110,99,108,105,99,107,61,34,116,104,105,115,46,115,116,121,108,101
	db	46,99,111,108,111,114,32,61,32,39,114,101,100,39,34,32,99,108,97,115,115,61,34,99
	db	54,34,62,64,82,101,108,32,48,51,53,46,48,49,60,98,114,62,60,47,115,112,97,110
	db	62,60,47,115,112,97,110,62,60,47,98,111,100,121,62,60,47,104,116,109,108,62

;********************************************************************************

IVALID351_H
	movff	SYSSTRINGA,SysWORDTempA
	movff	SYSSTRINGA_H,SysWORDTempA_H
	movlw	115
	movwf	SysWORDTempB,ACCESS
	movlw	2
	movwf	SysWORDTempB_H,ACCESS
	rcall	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableIVALID351_H
	movwf	TBLPTRL,ACCESS
	movlw	high TableIVALID351_H
	btfsc	STATUS, C,ACCESS
	addlw	1
	addwf	SysStringA_H, W,ACCESS
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableIVALID351_H
	db	5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255

;********************************************************************************

;Overloaded signature: BYTE:BYTE:
SPIMODE213
;Set SSPCON1.SSPEN Off ;(Prevents any weird glitches during setup)
	bcf	SSPCON1,SSPEN,ACCESS
;Set SSPSTAT.SMP Off
	bcf	SSPSTAT,SMP,ACCESS
;Set SSPSTAT.CKE Off
	bcf	SSPSTAT,CKE,ACCESS
;If SPIClockMode.0 = Off Then
	btfss	SPICLOCKMODE,0,BANKED
;Set SSPSTAT.CKE On
	bsf	SSPSTAT,CKE,ACCESS
;End If
;Set SSPCON1.CKP Off
	bcf	SSPCON1,CKP,ACCESS
;If SPIClockMode.1 = On Then
	btfsc	SPICLOCKMODE,1,BANKED
;Set SSPCON1.CKP On
	bsf	SSPCON1,CKP,ACCESS
;End If
;Set SSPCON1.SSPM3 Off
	bcf	SSPCON1,SSPM3,ACCESS
;Set SSPCON1.SSPM2 Off
	bcf	SSPCON1,SSPM2,ACCESS
;Set SSPCON1.SSPM1 Off
	bcf	SSPCON1,SSPM1,ACCESS
;Set SSPCON1.SSPM0 Off
	bcf	SSPCON1,SSPM0,ACCESS
;Select Case SPICurrentMode
;Case MasterFast
SysSelect2Case1
	movlw	13
	subwf	SPICURRENTMODE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case2
;Case Master
	bra	SysSelectEnd2
SysSelect2Case2
	movlw	12
	subwf	SPICURRENTMODE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case3
;Set SSPCON1.SSPM0 On
	bsf	SSPCON1,SSPM0,ACCESS
;Case MasterSlow
	bra	SysSelectEnd2
SysSelect2Case3
	movlw	11
	subwf	SPICURRENTMODE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case4
;Set SSPCON1.SSPM1 On
	bsf	SSPCON1,SSPM1,ACCESS
;Case Slave
	bra	SysSelectEnd2
SysSelect2Case4
	movf	SPICURRENTMODE,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case5
;Set SSPCON1.SSPM2 On
	bsf	SSPCON1,SSPM2,ACCESS
;Set SSPCON1.SSPM0 On
	bsf	SSPCON1,SSPM0,ACCESS
;Case SlaveSS
	bra	SysSelectEnd2
SysSelect2Case5
	decf	SPICURRENTMODE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case6
;Set SSPCON1.SSPM2 On
	bsf	SSPCON1,SSPM2,ACCESS
;End Select
SysSelect2Case6
SysSelectEnd2
;Set SSPCON1.SSPEN On
	bsf	SSPCON1,SSPEN,ACCESS
	return

;********************************************************************************

;Overloaded signature: BYTE:BYTE:
SWAP98
;SysCalcTempX = SysCalcTempA
	movff	SYSCALCTEMPA,SYSCALCTEMPX
;SysCalcTempA = SysCalcTempB
	movff	SYSCALCTEMPB,SYSCALCTEMPA
;SysCalcTempB = SysCalcTempX
	movff	SYSCALCTEMPX,SYSCALCTEMPB
	return

;********************************************************************************

SYSCOMPEQUAL
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;setf SysByteTempX
	setf	SYSBYTETEMPX,ACCESS
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W,ACCESS
;cpfseq SysByteTempA
	cpfseq	SYSBYTETEMPA,ACCESS
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
	return

;********************************************************************************

SYSCOMPEQUAL16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
;movf SysWordTempB, W
	movf	SYSWORDTEMPB, W,ACCESS
;cpfseq SysWordTempA
	cpfseq	SYSWORDTEMPA,ACCESS
;return
	return
;movf SysWordTempB_H, W
	movf	SYSWORDTEMPB_H, W,ACCESS
;cpfseq SysWordTempA_H
	cpfseq	SYSWORDTEMPA_H,ACCESS
;return
	return
;setf SysByteTempX
	setf	SYSBYTETEMPX,ACCESS
	return

;********************************************************************************

SYSCOMPLESSTHAN
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;setf SysByteTempX
	setf	SYSBYTETEMPX,ACCESS
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W,ACCESS
;cpfslt SysByteTempA
	cpfslt	SYSBYTETEMPA,ACCESS
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
	return

;********************************************************************************

SYSCOMPLESSTHAN16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
;movf SysWordTempA_H,W
	movf	SYSWORDTEMPA_H,W,ACCESS
;subwf SysWordTempB_H,W
	subwf	SYSWORDTEMPB_H,W,ACCESS
;btfss STATUS,C
	btfss	STATUS,C,ACCESS
;return
	return
;movf SysWordTempB_H,W
	movf	SYSWORDTEMPB_H,W,ACCESS
;subwf SysWordTempA_H,W
	subwf	SYSWORDTEMPA_H,W,ACCESS
;bnc SCLT16True
	bnc	SCLT16TRUE
;movf SysWordTempB,W
	movf	SYSWORDTEMPB,W,ACCESS
;subwf SysWordTempA,W
	subwf	SYSWORDTEMPA,W,ACCESS
;btfsc STATUS,C
	btfsc	STATUS,C,ACCESS
;return
	return
SCLT16TRUE
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F,ACCESS
	return

;********************************************************************************

SYSDIVSUB
;dim SysByteTempA as byte
;dim SysByteTempB as byte
;dim SysByteTempX as byte
;movf SysByteTempB, F
	movf	SYSBYTETEMPB, F,ACCESS
;btfsc STATUS, Z
	btfsc	STATUS, Z,ACCESS
;return
	return
;SysByteTempX = 0
	clrf	SYSBYTETEMPX,ACCESS
;SysDivLoop = 8
	movlw	8
	movwf	SYSDIVLOOP,ACCESS
SYSDIV8START
;bcf STATUS, C
	bcf	STATUS, C,ACCESS
;rlf SysByteTempA, F
	rlcf	SYSBYTETEMPA, F,ACCESS
;rlf SysByteTempX, F
	rlcf	SYSBYTETEMPX, F,ACCESS
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W,ACCESS
;subwf SysByteTempX, F
	subwf	SYSBYTETEMPX, F,ACCESS
;bsf SysByteTempA, 0
	bsf	SYSBYTETEMPA, 0,ACCESS
;btfsc STATUS, C
	btfsc	STATUS, C,ACCESS
;goto Div8NotNeg
	bra	DIV8NOTNEG
;bcf SysByteTempA, 0
	bcf	SYSBYTETEMPA, 0,ACCESS
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W,ACCESS
;addwf SysByteTempX, F
	addwf	SYSBYTETEMPX, F,ACCESS
DIV8NOTNEG
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F,ACCESS
;goto SysDiv8Start
	bra	SYSDIV8START
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
	movff	SYSWORDTEMPA,SYSDIVMULTA
	movff	SYSWORDTEMPA_H,SYSDIVMULTA_H
;SysDivMultB = SysWordTempB
	movff	SYSWORDTEMPB,SYSDIVMULTB
	movff	SYSWORDTEMPB_H,SYSDIVMULTB_H
;SysDivMultX = 0
	clrf	SYSDIVMULTX,ACCESS
	clrf	SYSDIVMULTX_H,ACCESS
;if SysDivMultB = 0 then
	movff	SYSDIVMULTB,SysWORDTempA
	movff	SYSDIVMULTB_H,SysWORDTempA_H
	clrf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF98
;SysWordTempA = 0
	clrf	SYSWORDTEMPA,ACCESS
	clrf	SYSWORDTEMPA_H,ACCESS
;exit sub
	return
;end if
ENDIF98
;SysDivLoop = 16
	movlw	16
	movwf	SYSDIVLOOP,ACCESS
SYSDIV16START
;set C off
	bcf	STATUS,C,ACCESS
;Rotate SysDivMultA Left
	rlcf	SYSDIVMULTA,F,ACCESS
	rlcf	SYSDIVMULTA_H,F,ACCESS
;Rotate SysDivMultX Left
	rlcf	SYSDIVMULTX,F,ACCESS
	rlcf	SYSDIVMULTX_H,F,ACCESS
;SysDivMultX = SysDivMultX - SysDivMultB
	movf	SYSDIVMULTB,W,ACCESS
	subwf	SYSDIVMULTX,F,ACCESS
	movf	SYSDIVMULTB_H,W,ACCESS
	subwfb	SYSDIVMULTX_H,F,ACCESS
;Set SysDivMultA.0 On
	bsf	SYSDIVMULTA,0,ACCESS
;If C Off Then
	btfsc	STATUS,C,ACCESS
	bra	ENDIF99
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0,ACCESS
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W,ACCESS
	addwf	SYSDIVMULTX,F,ACCESS
	movf	SYSDIVMULTB_H,W,ACCESS
	addwfc	SYSDIVMULTX_H,F,ACCESS
;End If
ENDIF99
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F,ACCESS
;goto SysDiv16Start
	bra	SYSDIV16START
;SysWordTempA = SysDivMultA
	movff	SYSDIVMULTA,SYSWORDTEMPA
	movff	SYSDIVMULTA_H,SYSWORDTEMPA_H
;SysWordTempX = SysDivMultX
	movff	SYSDIVMULTX,SYSWORDTEMPX
	movff	SYSDIVMULTX_H,SYSWORDTEMPX_H
	return

;********************************************************************************

SYSMULTSUB16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;movf SysWordTempA, W
	movf	SYSWORDTEMPA, W,ACCESS
;mulwf SysWordTempB
	mulwf	SYSWORDTEMPB,ACCESS
;movff PRODL, SysWordTempX
	movff	PRODL, SYSWORDTEMPX
;movff PRODH, SysWordTempX_H
	movff	PRODH, SYSWORDTEMPX_H
;movf SysWordTempA, W
	movf	SYSWORDTEMPA, W,ACCESS
;mulwf SysWordTempB_H
	mulwf	SYSWORDTEMPB_H,ACCESS
;movf PRODL, W
	movf	PRODL, W,ACCESS
;addwf SysWordTempX_H, F
	addwf	SYSWORDTEMPX_H, F,ACCESS
;movf SysWordTempA_H, W
	movf	SYSWORDTEMPA_H, W,ACCESS
;mulwf SysWordTempB
	mulwf	SYSWORDTEMPB,ACCESS
;movf PRODL, W
	movf	PRODL, W,ACCESS
;addwf SysWordTempX_H, F
	addwf	SYSWORDTEMPX_H, F,ACCESS
;movf SysWordTempA_H, F
	movf	SYSWORDTEMPA_H, F,ACCESS
;mulwf SysWordTempB_H
	mulwf	SYSWORDTEMPB_H,ACCESS
	return

;********************************************************************************

SYSREADSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;TBLRD*+
	tblrd*+
;movff TABLAT,SysCalcTempA
	movff	TABLAT,SYSCALCTEMPA
;movff TABLAT,INDF1
	movff	TABLAT,INDF1
;goto SysStringReadCheck
	bra	SYSSTRINGREADCHECK
SYSREADSTRINGPART
;TBLRD*+
	tblrd*+
;movf TABLAT, W
	movf	TABLAT, W,ACCESS
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA,ACCESS
;addwf SysStringLength,F
	addwf	SYSSTRINGLENGTH,F,ACCESS
SYSSTRINGREADCHECK
;movf SysCalcTempA,F
	movf	SYSCALCTEMPA,F,ACCESS
;btfsc STATUS,Z
	btfsc	STATUS,Z,ACCESS
;return
	return
SYSSTRINGREAD
;TBLRD*+
	tblrd*+
;movff TABLAT,PREINC1
	movff	TABLAT,PREINC1
;decfsz SysCalcTempA, F
	decfsz	SYSCALCTEMPA, F,ACCESS
;goto SysStringRead
	bra	SYSSTRINGREAD
	return

;********************************************************************************

SysStringTables

StringTable4
	db	28,69,78,67,50,56,106,54,48,32,69,116,104,101,114,110,101,116,32,68,114,105,118,101
	db	114,32,48,51,53


StringTable5
	db	11,73,110,105,116,105,97,108,105,115,101,100


StringTable19
	db	9,105,110,100,101,120,46,104,116,109


StringTable22
	db	0


StringTable45
	db	1,33


StringTable46
	db	6,70,108,97,103,115,58


StringTable47
	db	1,44


StringTable48
	db	4,70,73,78,32


StringTable49
	db	4,83,89,78,32


StringTable50
	db	4,82,83,84,32


StringTable51
	db	4,80,83,72,32


StringTable52
	db	4,65,67,75,32


StringTable53
	db	8,84,67,80,95,85,82,71,32


StringTable54
	db	8,115,121,110,38,33,102,105,110


StringTable55
	db	7,97,99,107,38,112,115,104


StringTable56
	db	1,46


StringTable58
	db	25,35,50,69,82,68,80,84,76,32,97,110,100,32,69,82,68,80,84,72,32,101,114,114
	db	111,114


StringTable70
	db	13,66,117,102,102,101,114,32,79,118,101,114,117,110


StringTable78
	db	13,97,99,107,38,97,99,107,112,117,115,104,61,49


StringTable79
	db	18,84,97,98,108,101,83,116,97,114,116,80,111,105,110,116,32,61,32


StringTable80
	db	10,101,120,105,116,105,110,103,64,49,32


StringTable81
	db	10,101,120,105,116,105,110,103,64,50,32


StringTable82
	db	10,72,84,84,80,83,101,110,100,64,51


StringTable83
	db	7,97,99,107,38,102,105,110


StringTable84
	db	15,72,84,84,80,47,49,46,48,32,50,48,48,32,79,75


StringTable85
	db	16,101,109,112,116,121,32,116,104,101,32,98,117,102,102,101,114


StringTable86
	db	7,32,32,80,65,68,33,32


StringTable87
	db	5,83,101,110,100,58


StringTable88
	db	7,66,47,87,105,114,101,58


StringTable89
	db	10,44,32,84,67,80,32,80,107,116,58


StringTable90
	db	7,44,32,72,84,77,76,58


;********************************************************************************


 END
