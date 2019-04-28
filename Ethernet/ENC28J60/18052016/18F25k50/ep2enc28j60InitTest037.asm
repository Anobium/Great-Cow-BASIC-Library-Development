;Program compiled by Great Cow BASIC (0.95.010_RC6 2016-10-19)
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F25K50, r=DEC
#include <P18F25K50.inc>
 CONFIG LVP = ON, STVREN = OFF, MCLRE = ON, WDTEN = OFF, BOREN = OFF, FOSC = INTOSCIO, CPUDIV = NOCLKDIV

;********************************************************************************

;Set aside memory locations for variables
ACKPSH	EQU	13
ADDR	EQU	14
ADREADPORT	EQU	15
ANALOGCHANNEL	EQU	16
ARRAYLOC	EQU	17
ARRAYLOC_H	EQU	18
BANKTOBESELECTED	EQU	19
BUTTONSTATE	EQU	20
BYTENUM	EQU	21
BYTETOBIN	EQU	900
CLIENT_SEQNUM	EQU	22
CLIENT_SEQNUM_E	EQU	26
CLIENT_SEQNUM_H	EQU	27
CLIENT_SEQNUM_U	EQU	28
COMMANDLINESTRING	EQU	909
COMPORT	EQU	29
CURRBYTE	EQU	30
DELAYTEMP	EQU	0
DELAYTEMP2	EQU	1
ENC28J60_DATA	EQU	31
ENC28J60_READREG	EQU	32
ENC28J60_TEMP	EQU	33
ENC_OUTBYTE	EQU	34
ENC_OUTBYTE1	EQU	35
ENC_OUTBYTE2	EQU	36
ENDPTR	EQU	37
ENDPTR_H	EQU	38
ETHERBUFFER	EQU	1045
ETHERBUFFERINDEX	EQU	39
ETHERBUFFERINDEX_H	EQU	40
ETHERGETLENGTH	EQU	41
ETHERGETLENGTH_H	EQU	42
ETH_COUNTER	EQU	43
ETH_COUNTER_H	EQU	44
ETH_FRAMELENGTH	EQU	45
ETH_FRAMELENGTH_H	EQU	46
FLAGS	EQU	47
FNLSL	EQU	48
FNLSL_E	EQU	51
FNLSL_H	EQU	49
FNLSL_U	EQU	50
FNLSR	EQU	52
FNLSR_E	EQU	55
FNLSR_H	EQU	53
FNLSR_U	EQU	54
HEX	EQU	863
HSERPRINTCRLFCOUNT	EQU	56
HTTPCLOSETRANSACTION	EQU	57
HTTPPRINTCRLFFLAG	EQU	58
HTTPSENTTCPPACKET	EQU	59
HULP2	EQU	60
HULP2_H	EQU	61
HULP3	EQU	62
II	EQU	63
II_H	EQU	64
INCOMING_ACK	EQU	65
INCOMING_ACK_E	EQU	68
INCOMING_ACK_H	EQU	66
INCOMING_ACK_U	EQU	67
INSTR	EQU	69
IPADDR	EQU	882
IPPORT	EQU	70
IPROUTER	EQU	877
IP_HEADER_LENGTH	EQU	71
IP_ID	EQU	72
IP_ID_H	EQU	73
I_CHECKSUM16	EQU	74
I_CHECKSUM16_H	EQU	75
I_CHKSUM32	EQU	76
I_CHKSUM32_E	EQU	79
I_CHKSUM32_H	EQU	77
I_CHKSUM32_U	EQU	78
I_ODD	EQU	80
I_X	EQU	81
I_X_H	EQU	82
LASTGET	EQU	83
LASTSELECTEDBANK	EQU	84
LEFT	EQU	1004
LOCALTMP	EQU	85
LOCALTMP_H	EQU	86
MACADDR	EQU	893
MACADDRROUTER	EQU	872
MAXLEN	EQU	87
MAXLEN_H	EQU	88
NEXTPACKETPTR	EQU	89
NEXTPACKETPTR_H	EQU	90
NUMBITS	EQU	91
OUTVALUETEMP	EQU	92
PACKETLENGTH	EQU	93
PACKETLENGTH_H	EQU	94
PCKTLEN	EQU	95
PCKTLEN_H	EQU	96
PHYREGADDR	EQU	97
PRINTLEN	EQU	98
READAD	EQU	99
RESULT	EQU	100
RESULT_H	EQU	101
RXSTAT	EQU	102
RXSTAT_H	EQU	103
SERDATA	EQU	104
SERPRINTVAL	EQU	105
SERPRINTVAL_H	EQU	106
SNTPSERVERADDR	EQU	867
SPICLOCKMODE	EQU	107
SPICURRENTMODE	EQU	108
SPIRXDATA	EQU	109
SPITXDATA	EQU	110
STARTPTR	EQU	111
STARTPTR_H	EQU	112
STR	EQU	887
STRINGPOINTER	EQU	113
SUM	EQU	114
SUM_E	EQU	117
SUM_H	EQU	115
SUM_U	EQU	116
SYSARRAYTEMP1	EQU	118
SYSARRAYTEMP2	EQU	119
SYSBITVAR0	EQU	120
SYSBYTETEMPA	EQU	5
SYSBYTETEMPB	EQU	9
SYSBYTETEMPX	EQU	0
SYSCALCTEMPA	EQU	5
SYSCALCTEMPB	EQU	9
SYSCALCTEMPX	EQU	0
SYSCALCTEMPX_H	EQU	1
SYSCHARCOUNT	EQU	121
SYSDIVLOOP	EQU	4
SYSDIVMULTA	EQU	7
SYSDIVMULTA_H	EQU	8
SYSDIVMULTB	EQU	11
SYSDIVMULTB_H	EQU	12
SYSDIVMULTX	EQU	2
SYSDIVMULTX_H	EQU	3
SYSFINDLEN	EQU	122
SYSFNBYTE1	EQU	123
SYSHTTPDATAHANDLER	EQU	124
SYSHTTPDATAHANDLER_H	EQU	125
SYSLONGTEMPB	EQU	9
SYSLONGTEMPB_E	EQU	12
SYSLONGTEMPB_H	EQU	10
SYSLONGTEMPB_U	EQU	11
SYSMACADDRHANDLER	EQU	126
SYSMACADDRHANDLER_H	EQU	127
SYSPRINTDATAHANDLER	EQU	128
SYSPRINTDATAHANDLER_H	EQU	129
SYSPRINTTEMP	EQU	130
SYSREPEATTEMP1	EQU	131
SYSREPEATTEMP10	EQU	132
SYSREPEATTEMP2	EQU	133
SYSREPEATTEMP3	EQU	134
SYSREPEATTEMP4	EQU	135
SYSREPEATTEMP5	EQU	136
SYSREPEATTEMP6	EQU	137
SYSREPEATTEMP7	EQU	138
SYSREPEATTEMP8	EQU	139
SYSREPEATTEMP9	EQU	140
SYSSEARCHEND	EQU	141
SYSSTRDATA	EQU	142
SYSSTRINGA	EQU	7
SYSSTRINGA_H	EQU	8
SYSSTRINGLENGTH	EQU	6
SYSSTRINGPARAM1	EQU	963
SYSSTRINGTEMP	EQU	143
SYSSTRLEN	EQU	144
SYSSYSFINDSTRINGHANDLER	EQU	145
SYSSYSFINDSTRINGHANDLER_H	EQU	146
SYSSYSINSTRINGHANDLER	EQU	147
SYSSYSINSTRINGHANDLER_H	EQU	148
SYSTEMP1	EQU	149
SYSTEMP1_E	EQU	152
SYSTEMP1_H	EQU	150
SYSTEMP1_U	EQU	151
SYSTEMP2	EQU	153
SYSTEMP2_H	EQU	154
SYSTEMP3	EQU	155
SYSTEMPARRAY	EQU	922
SYSVALTEMP	EQU	156
SYSVALTEMP_H	EQU	157
SYSWAITTEMP10US	EQU	5
SYSWAITTEMPMS	EQU	2
SYSWAITTEMPMS_H	EQU	3
SYSWORDTEMPA	EQU	5
SYSWORDTEMPA_H	EQU	6
SYSWORDTEMPB	EQU	9
SYSWORDTEMPB_H	EQU	10
SYSWORDTEMPX	EQU	0
SYSWORDTEMPX_H	EQU	1
T1	EQU	158
T1_H	EQU	159
T2	EQU	160
T2_H	EQU	161
TABLELOC	EQU	162
TABLELOC_H	EQU	163
TABLESTARTPOINT	EQU	164
TABLESTARTPOINT_H	EQU	165
TCPDATALEN_IN	EQU	166
TCPDATALEN_IN_H	EQU	167
TCPRESULT16	EQU	168
TCPRESULT16_H	EQU	169
TEMP	EQU	170
TT	EQU	171
T_UDP_DESTPORT	EQU	172
T_UDP_DESTPORT_H	EQU	173
VAL1	EQU	174
VAL2	EQU	175
VAL2_H	EQU	176
VAL3	EQU	177
VAL4	EQU	178
WORK	EQU	179
X_ODD	EQU	180
ZZ	EQU	181
ZZZ	EQU	182
ZZZ_H	EQU	183

;********************************************************************************

;Alias variables
AFSR0	EQU	4073
AFSR0_H	EQU	4074
I_VALUE16	EQU	74
I_VALUE16_H	EQU	75
SYSCOMMANDLINESTRING_0	EQU	909
SYSCOMMANDLINESTRING_1	EQU	910
SYSCOMMANDLINESTRING_10	EQU	919
SYSCOMMANDLINESTRING_11	EQU	920
SYSCOMMANDLINESTRING_12	EQU	921
SYSCOMMANDLINESTRING_2	EQU	911
SYSCOMMANDLINESTRING_3	EQU	912
SYSCOMMANDLINESTRING_4	EQU	913
SYSCOMMANDLINESTRING_5	EQU	914
SYSCOMMANDLINESTRING_6	EQU	915
SYSCOMMANDLINESTRING_7	EQU	916
SYSCOMMANDLINESTRING_8	EQU	917
SYSCOMMANDLINESTRING_9	EQU	918
SYSETHERBUFFER_1	EQU	1046
SYSETHERBUFFER_10	EQU	1055
SYSETHERBUFFER_11	EQU	1056
SYSETHERBUFFER_12	EQU	1057
SYSETHERBUFFER_13	EQU	1058
SYSETHERBUFFER_14	EQU	1059
SYSETHERBUFFER_15	EQU	1060
SYSETHERBUFFER_17	EQU	1062
SYSETHERBUFFER_18	EQU	1063
SYSETHERBUFFER_19	EQU	1064
SYSETHERBUFFER_2	EQU	1047
SYSETHERBUFFER_20	EQU	1065
SYSETHERBUFFER_21	EQU	1066
SYSETHERBUFFER_22	EQU	1067
SYSETHERBUFFER_23	EQU	1068
SYSETHERBUFFER_24	EQU	1069
SYSETHERBUFFER_25	EQU	1070
SYSETHERBUFFER_26	EQU	1071
SYSETHERBUFFER_27	EQU	1072
SYSETHERBUFFER_28	EQU	1073
SYSETHERBUFFER_29	EQU	1074
SYSETHERBUFFER_3	EQU	1048
SYSETHERBUFFER_30	EQU	1075
SYSETHERBUFFER_31	EQU	1076
SYSETHERBUFFER_32	EQU	1077
SYSETHERBUFFER_33	EQU	1078
SYSETHERBUFFER_34	EQU	1079
SYSETHERBUFFER_35	EQU	1080
SYSETHERBUFFER_36	EQU	1081
SYSETHERBUFFER_37	EQU	1082
SYSETHERBUFFER_38	EQU	1083
SYSETHERBUFFER_39	EQU	1084
SYSETHERBUFFER_4	EQU	1049
SYSETHERBUFFER_40	EQU	1085
SYSETHERBUFFER_41	EQU	1086
SYSETHERBUFFER_42	EQU	1087
SYSETHERBUFFER_43	EQU	1088
SYSETHERBUFFER_44	EQU	1089
SYSETHERBUFFER_45	EQU	1090
SYSETHERBUFFER_46	EQU	1091
SYSETHERBUFFER_47	EQU	1092
SYSETHERBUFFER_48	EQU	1093
SYSETHERBUFFER_49	EQU	1094
SYSETHERBUFFER_5	EQU	1050
SYSETHERBUFFER_50	EQU	1095
SYSETHERBUFFER_51	EQU	1096
SYSETHERBUFFER_52	EQU	1097
SYSETHERBUFFER_55	EQU	1100
SYSETHERBUFFER_56	EQU	1101
SYSETHERBUFFER_57	EQU	1102
SYSETHERBUFFER_58	EQU	1103
SYSETHERBUFFER_59	EQU	1104
SYSETHERBUFFER_6	EQU	1051
SYSETHERBUFFER_60	EQU	1105
SYSETHERBUFFER_61	EQU	1106
SYSETHERBUFFER_7	EQU	1052
SYSETHERBUFFER_8	EQU	1053
SYSETHERBUFFER_9	EQU	1054
SYSHEX_0	EQU	863
SYSHEX_1	EQU	864
SYSHEX_2	EQU	865
SYSIPADDR_1	EQU	883
SYSIPADDR_2	EQU	884
SYSIPADDR_3	EQU	885
SYSIPADDR_4	EQU	886
SYSLEFT_0	EQU	1004
SYSMACADDR_1	EQU	894
SYSMACADDR_2	EQU	895
SYSMACADDR_3	EQU	896
SYSMACADDR_4	EQU	897
SYSMACADDR_5	EQU	898
SYSMACADDR_6	EQU	899
SYSREADADBYTE	EQU	99
SYSSTR_0	EQU	887

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
	setf	TRISC,ACCESS

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
;#define USART_BAUD_RATE 115200
;#define USART_BLOCKING
;#define USART_TX_BLOCKING
;----- Define Hardware settings
;#Define ENC28J60_DI               Portb.0   'Connected to Device SO
;#Define ENC28J60_DO               Portb.3     'Connected to Device SI
;#Define ENC28J60_SCK              Portb.1     'Connected to Clock
;#Define ENC28J60_CS               Porta.5     'Chip select line
;#Define ENC28J60_RESET            Portb.4     'Reset line
;----- Variables
;----- Quick Command Reference:
;----- Main body of program commences here.
;HSerPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF

;HserPrint "ENC28j60 Ethernet Driver 037" : HSerPrintCRLF
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
	call	HSERPRINT261

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
;ipaddr = 192,168,0,3
	lfsr	0,IPADDR
	movlw	4
	movwf	POSTINC0,ACCESS
	movlw	192
	movwf	POSTINC0,ACCESS
	movlw	168
	movwf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	movlw	3
	movwf	POSTINC0,ACCESS
;macaddr = 0x00, 0x1E, 0xC0, 0x00, 0x00, 0x03
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
	movlw	3
	movwf	POSTINC0,ACCESS
;ipport = 80
	movlw	80
	movwf	IPPORT,BANKED
;ipserver = 192,168,0,106
;iprouter = 192,168,0,250
	lfsr	0,IPROUTER
	movlw	4
	movwf	POSTINC0,ACCESS
	movlw	192
	movwf	POSTINC0,ACCESS
	movlw	168
	movwf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	movlw	250
	movwf	POSTINC0,ACCESS
;macaddrrouter = 0x00, 0x50, 0x7f, 0xdc, 0x64, 0x48
	lfsr	0,MACADDRROUTER
	movlw	6
	movwf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	movlw	80
	movwf	POSTINC0,ACCESS
	movlw	127
	movwf	POSTINC0,ACCESS
	movlw	220
	movwf	POSTINC0,ACCESS
	movlw	100
	movwf	POSTINC0,ACCESS
	movlw	72
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
	call	HSERPRINT261

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
;dim buttonstate as byte
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
;ENC28j60_bitSet( ECON1 , econ1_txrst )
	movlw	31
	movwf	ADDR,BANKED
	movlw	128
	movwf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_BITSET

;ENC28j60_bitClear( ECON1 , econ1_txrst )
	movlw	31
	movwf	ADDR,BANKED
	movlw	128
	movwf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_BITCLEAR

;ENC28j60_bitClear( EIR , EIR_TXERIF )
	movlw	28
	movwf	ADDR,BANKED
	movlw	2
	movwf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_BITCLEAR

;ENC28j60_regdump
	call	ENC28J60_REGDUMP

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
;#define etherBufferSize 1000
;#define ENC28j60_Select         Set ENC28j60_CS off
;#define ENC28j60_Deselect       Set ENC28j60_CS on
;#define ENC28j60_Reset_CMD			Set ENC28j60_RESET on: Wait 20 ms :Set ENC28j60_RESET off: Wait 20 ms :Set ENC28j60_RESET on: Wait 20 ms
;#define Synflag = 0
;#define Finflag = 1
;#define ENC28j60_Detailed_RegDump
CONFIGURATIONDETAILS
MEMORY_LOCATIONS_SCRIPT
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

FN_BYTETOBIN
;ByteToBin = ""
	lfsr	1,BYTETOBIN
	movlw	low StringTable22
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable22
	movwf	TBLPTRH,ACCESS
	call	SysReadString
;Repeat 8
	movlw	8
	movwf	SysRepeatTemp10,BANKED
SysRepeatLoop10
;If ByteNum.7 = 1 Then
	btfss	BYTENUM,7,BANKED
	bra	ELSE136_1
;ByteToBin = ByteToBin +"1"
	lfsr	1,BYTETOBIN
	clrf	SysStringLength,ACCESS
	lfsr	0,BYTETOBIN
	call	SysCopyStringPart
	movlw	low StringTable135
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable135
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,BYTETOBIN
	movff	SysStringLength, INDF0
;Else
	bra	ENDIF136
ELSE136_1
;ByteToBin = ByteToBin +"0"
	lfsr	1,BYTETOBIN
	clrf	SysStringLength,ACCESS
	lfsr	0,BYTETOBIN
	call	SysCopyStringPart
	movlw	low StringTable71
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable71
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,BYTETOBIN
	movff	SysStringLength, INDF0
;End If
ENDIF136
;Rotate ByteNum Left
	rlcf	BYTENUM,F,BANKED
;End Repeat
	decfsz	SysRepeatTemp10,F,BANKED
	bra	SysRepeatLoop10
SysRepeatLoopEnd10
	return

;********************************************************************************

Delay_10US
D10US_START
	movlw	12
	movwf	DELAYTEMP,ACCESS
DelayUS0
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS0
	decfsz	SysWaitTemp10US, F,ACCESS
	bra	D10US_START
	return

;********************************************************************************

Delay_MS
	incf	SysWaitTempMS_H, F,ACCESS
DMS_START
	movlw	108
	movwf	DELAYTEMP2,ACCESS
DMS_OUTER
	movlw	11
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
	call	ENC28J60_PACKETSEND

	return

;********************************************************************************

ENC28J60_BITCLEAR
;				banktobeselected = ( addr & BANK_MASK) / 32
;banktobeselected = ( addr & BANK_MASK)
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
;end repeat
	decfsz	SysRepeatTemp3,F,BANKED
	bra	SysRepeatLoop3
SysRepeatLoopEnd3
;if lastselectedBank <> banktobeselected then
	movf	BANKTOBESELECTED,W,BANKED
	subwf	LASTSELECTEDBANK,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ELSE6_1
;if ( ( addr & ADDR_MASK )  <= EIE  ) then
	movlw	31
	andwf	ADDR,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SysBYTETempB
	movlw	27
	movwf	SysBYTETempA,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF7
;ENC28j60_selectBank ( banktobeselected, addr )
	call	ENC28J60_SELECTBANK

;end if
ENDIF7
;Else
	bra	ENDIF6
ELSE6_1
;lastselectedBank = banktobeselected
	movff	BANKTOBESELECTED,LASTSELECTEDBANK
;end if
ENDIF6
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
;HSerPrintByteCRLF banktobeselected
;HSerPrintCRLF
;if lastselectedBank <> banktobeselected then
	movf	BANKTOBESELECTED,W,BANKED
	subwf	LASTSELECTEDBANK,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ELSE4_1
;if ( ( addr & ADDR_MASK )  <= EIE  ) then
	movlw	31
	andwf	ADDR,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SysBYTETempB
	movlw	27
	movwf	SysBYTETempA,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF5
;ENC28j60_selectBank ( banktobeselected, addr )
	call	ENC28J60_SELECTBANK

;end if
ENDIF5
;Else
	bra	ENDIF4
ELSE4_1
;lastselectedBank = banktobeselected
	movff	BANKTOBESELECTED,LASTSELECTEDBANK
;end if
ENDIF4
;ENC28j60_Select
	bcf	LATA,5,ACCESS
;FastHWSPITransfer( ENC28j60_BIT_FIELD_SET | (addr AND ADDR_MASK ), temp )
	movlw	31
	andwf	ADDR,W,BANKED
	movwf	SysTemp1,BANKED
	movlw	128
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
	bra	ENDIF64
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
	call	HSERPRINT261

ENDIF64
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
	bra	SysForLoopEnd7
SysForLoop7
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
	bra	SysForLoop7
SysForLoopEnd7
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
	bra	SysForLoopEnd16
SysForLoop16
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
	bra	SysForLoop16
SysForLoopEnd16
;If I_odd = 1 Then
	decf	I_ODD,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF130
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
ENDIF130
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
	movlw	low StringTable59
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable59
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;HSerPrint T_ip_srcaddr0
	movff	SYSETHERBUFFER_27,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT262

;HSerPrint ","
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable60
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable60
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;HSerPrint T_ip_srcaddr1
	movff	SYSETHERBUFFER_28,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT262

;HSerPrint ","
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable60
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable60
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;HSerPrint T_ip_srcaddr2
	movff	SYSETHERBUFFER_29,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT262

;HSerPrint ","
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable60
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable60
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;HSerPrint T_ip_srcaddr3
	movff	SYSETHERBUFFER_30,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT262

;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF

;HserPrint "FIN "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable61
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable61
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;HSerSend 9
	movlw	9
	movwf	SERDATA,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERSEND

;HserPrint "SYN "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable62
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable62
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;HSerSend 9
	movlw	9
	movwf	SERDATA,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERSEND

;HserPrint  "RST "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable63
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable63
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;HSerSend 9
	movlw	9
	movwf	SERDATA,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERSEND

;HserPrint  "PSH "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable64
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable64
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;HSerSend 9
	movlw	9
	movwf	SERDATA,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERSEND

;HserPrint  "ACK "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable65
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable65
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;HSerSend 9
	movlw	9
	movwf	SERDATA,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERSEND

;HserPrint "TCP_URG "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable66
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable66
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

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
	call	HSERPRINT262

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
	call	HSERPRINT262

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
	call	HSERPRINT262

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
	call	HSERPRINT262

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
	call	HSERPRINT262

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
	call	HSERPRINT262

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
	bra	ENDIF67
;HSerPrint "syn&!fin"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable67
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable67
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

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
	call	SWAP102
	movff	SYSCALCTEMPA,SYSETHERBUFFER_36
	movff	SYSCALCTEMPB,SYSETHERBUFFER_38

;Swap Tcp_srcporth , Tcp_destporth
	movff	SYSETHERBUFFER_35,SYSCALCTEMPA
	movff	SYSETHERBUFFER_37,SYSCALCTEMPB
	call	SWAP102
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
ENDIF67
HTTPPART2
;' If an ACK and PSH is received and the destination port address is valid
;If Tcp_ack = 1 Then
	btfss	SYSBITVAR0,5,BANKED
	bra	ENDIF68
;if Tcp_fin = 0 then
	btfsc	SYSBITVAR0,1,BANKED
	bra	ENDIF70
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
	call	SWAP102
	movff	SYSCALCTEMPA,SYSETHERBUFFER_36
	movff	SYSCALCTEMPB,SYSETHERBUFFER_38

;Swap Tcp_srcporth , Tcp_destporth
	movff	SYSETHERBUFFER_35,SYSCALCTEMPA
	movff	SYSETHERBUFFER_37,SYSCALCTEMPB
	call	SWAP102
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
ENDIF70
;If Tcp_psh = 1 Then
	btfss	SYSBITVAR0,4,BANKED
	bra	ENDIF71
;HSerPrint "ack&psh"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable68
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable68
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

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
	call	HSERPRINT262

;HSerPrint "."
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable42
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable42
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;HSerPrint T_ip_srcaddr1
	movff	SYSETHERBUFFER_28,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT262

;HSerPrint "."
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable42
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable42
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;HSerPrint T_ip_srcaddr2
	movff	SYSETHERBUFFER_29,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT262

;HSerPrint "."
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable42
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable42
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;HSerPrint T_ip_srcaddr3
	movff	SYSETHERBUFFER_30,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT262

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
;HTTPCommandLine
	banksel	0
	call	HTTPCOMMANDLINE

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
ENDIF71
;End If
ENDIF68
;if Tcp_fin = 0  then
	btfsc	SYSBITVAR0,1,BANKED
	bra	ELSE69_1
;HTTPPart3
	call	HTTPPART3

;Else
	bra	ENDIF69
ELSE69_1
;HTTPPart4
	call	HTTPPART4

;end if
ENDIF69
	return

;********************************************************************************

ENC28J60_INIT
;Dir ENC28j60_DI in
	bsf	TRISB,0,ACCESS
;Dir ENC28j60_DO Out
	bcf	TRISB,3,ACCESS
;Dir ENC28j60_SCK Out
	bcf	TRISB,1,ACCESS
;Dir ENC28j60_CS out
	bcf	TRISA,5,ACCESS
;Dir ENC28j60_RESET out
	bcf	TRISB,4,ACCESS
;set ENC28j60_DO off
	bcf	LATB,3,ACCESS
;set ENC28j60_SCK off
	bcf	LATB,1,ACCESS
;set ENC28j60_CS off
	bcf	LATA,5,ACCESS
;ENC28j60_Deselect
	bsf	LATA,5,ACCESS
;Repeat 5
	movlw	5
	movwf	SysRepeatTemp1,BANKED
SysRepeatLoop1
;ENC28j60_Reset_CMD
	bsf	LATB,4,ACCESS
	movlw	20
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
	bcf	LATB,4,ACCESS
	movlw	20
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
	bsf	LATB,4,ACCESS
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
	call	SPIMODE217

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
;ENC28j60_writeReg(ECON1, 0xC1) 'Hold it in Reset
	movlw	31
	movwf	ADDR,BANKED
	movlw	193
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
	call	ENC28J60_WRITEPHYREG

	return

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
	bra	ENDIF27
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
ENDIF27
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
	movff	SysByteTempX,SysTemp2
	movff	enc28j60_readreg,SysBYTETempA
	movff	nextpacketptr_h,SysBYTETempB
	call	SysCompEqual
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movf	SysTemp2,W,BANKED
	iorwf	SysTemp1,W,BANKED
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
	bra	ENDIF29
;HSerSend 7
	movlw	7
	movwf	SERDATA,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERSEND

;HSerPrint "#2ERDPTL and ERDPTH error"
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
	call	HSERPRINT261

;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF

;ENC28j60_regdump
	rcall	ENC28J60_REGDUMP

;exit do
	bra	SysDoLoop_E4
;end if
ENDIF29
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
	movff	SysByteTempX,SysTemp2
	movff	enc28j60_readreg,SysBYTETempA
	movff	nextpacketptr_h,SysBYTETempB
	call	SysCompEqual
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp3
	movf	SysTemp2,W,BANKED
	iorwf	SysTemp3,W,BANKED
	movwf	SysTemp1,BANKED
	btfsc	SysTemp1,0,BANKED
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
	bra	ENDIF30
;eth_counter = nextpacketptr -1
	movlw	1
	subwf	NEXTPACKETPTR,W,BANKED
	movwf	ETH_COUNTER,BANKED
	movlw	0
	subwfb	NEXTPACKETPTR_H,W,BANKED
	movwf	ETH_COUNTER_H,BANKED
;END IF
ENDIF30
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
	bra	ENDIF31
;If etherBuffer(14) = 0X06 Then                             'Type:ARP
	movlw	6
	subwf	SYSETHERBUFFER_14,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF32
;If etherBuffer(21) = 0X00 Then                          'ARP request
	movf	SYSETHERBUFFER_21,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF34
;If etherBuffer(22) = 0X01 Then                       'ARP request
	decf	SYSETHERBUFFER_22,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF36
;If etherBuffer(39) = ipaddr(1) Then                  'ARP for us
	banksel	SYSIPADDR_1
	movf	SYSIPADDR_1,W,BANKED
	banksel	SYSETHERBUFFER_39
	subwf	SYSETHERBUFFER_39,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF38
;If etherBuffer(40) = ipaddr(2) Then
	banksel	SYSIPADDR_2
	movf	SYSIPADDR_2,W,BANKED
	banksel	SYSETHERBUFFER_40
	subwf	SYSETHERBUFFER_40,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF40
;If etherBuffer(41) = ipaddr(3) Then
	banksel	SYSIPADDR_3
	movf	SYSIPADDR_3,W,BANKED
	banksel	SYSETHERBUFFER_41
	subwf	SYSETHERBUFFER_41,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF42
;If etherBuffer(42) = ipaddr(4) Then
	banksel	SYSIPADDR_4
	movf	SYSIPADDR_4,W,BANKED
	banksel	SYSETHERBUFFER_42
	subwf	SYSETHERBUFFER_42,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF44
;ENC28j60_Arpreply
	banksel	0
	call	ENC28J60_ARPREPLY

;End If
ENDIF44
;End If
ENDIF42
;End If
ENDIF40
;End If
ENDIF38
;End If
ENDIF36
;End If
ENDIF34
;End If
ENDIF32
;If etherBuffer(14) = 0X00 Then                             'Type:IP
	banksel	SYSETHERBUFFER_14
	movf	SYSETHERBUFFER_14,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF33
;If etherBuffer(15) = 0X45 Then                          'We handle only simple IP packets
	movlw	69
	subwf	SYSETHERBUFFER_15,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF35
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
	bra	ENDIF37
;If etherBuffer(31) = ipaddr(1) Then                  'Ip packet for us
	banksel	SYSIPADDR_1
	movf	SYSIPADDR_1,W,BANKED
	banksel	SYSETHERBUFFER_31
	subwf	SYSETHERBUFFER_31,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF39
;If etherBuffer(32) = ipaddr(2) Then
	banksel	SYSIPADDR_2
	movf	SYSIPADDR_2,W,BANKED
	banksel	SYSETHERBUFFER_32
	subwf	SYSETHERBUFFER_32,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF41
;If etherBuffer(33) = ipaddr(3) Then
	banksel	SYSIPADDR_3
	movf	SYSIPADDR_3,W,BANKED
	banksel	SYSETHERBUFFER_33
	subwf	SYSETHERBUFFER_33,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF43
;If etherBuffer(34) = ipaddr(4) Then
	banksel	SYSIPADDR_4
	movf	SYSIPADDR_4,W,BANKED
	banksel	SYSETHERBUFFER_34
	subwf	SYSETHERBUFFER_34,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF45
;If etherBuffer(24) = 1 Then              'Protocol:ICMP
	decf	SYSETHERBUFFER_24,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF46
;If etherBuffer(35) = 0X08 Then        'ICMP echo request
	movlw	8
	subwf	SYSETHERBUFFER_35,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF49
;PORTA.0 = 1
	bsf	LATA,0,ACCESS
;ENC28j60_Pingreply
	banksel	0
	rcall	ENC28J60_PINGREPLY

;PORTA.0 = 0
	bcf	LATA,0,ACCESS
;End If
ENDIF49
;End If
ENDIF46
;If etherBuffer(24) = 17 Then             'Protocol:UDP
	movlw	17
	banksel	SYSETHERBUFFER_24
	subwf	SYSETHERBUFFER_24,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF47
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
	call	ENC28J60_UDP_HANDLER

;if T_udp_destport = 7 then
	movff	T_UDP_DESTPORT,SysWORDTempA
	movff	T_UDP_DESTPORT_H,SysWORDTempA_H
	movlw	7
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF50
;ENC28j60_Setipaddrs
	call	ENC28J60_SETIPADDRS

;Swap T_udp_srcport0 , T_udp_destport0
	movff	SYSETHERBUFFER_35,SYSCALCTEMPA
	movff	SYSETHERBUFFER_37,SYSCALCTEMPB
	call	SWAP102
	movff	SYSCALCTEMPA,SYSETHERBUFFER_35
	movff	SYSCALCTEMPB,SYSETHERBUFFER_37

;Swap T_udp_srcport1 , T_udp_destport1
	movff	SYSETHERBUFFER_36,SYSCALCTEMPA
	movff	SYSETHERBUFFER_38,SYSCALCTEMPB
	call	SWAP102
	movff	SYSCALCTEMPA,SYSETHERBUFFER_36
	movff	SYSCALCTEMPB,SYSETHERBUFFER_38

;ENC28j60_Udp_checksum
	call	ENC28J60_UDP_CHECKSUM

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
	call	ENC28J60_WRITEBUFFER

;ENC28j60_packetsend( hulp2 )
	movff	HULP2,PCKTLEN
	movff	HULP2_H,PCKTLEN_H
	rcall	ENC28J60_PACKETSEND

;end if
ENDIF50
;End If
ENDIF47
;If etherBuffer(24) = 6 Then              'Protocol:TCP
	movlw	6
	banksel	SYSETHERBUFFER_24
	subwf	SYSETHERBUFFER_24,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF48
;If Tcp_destporth = 0 Then
	movf	SYSETHERBUFFER_37,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF51
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
ENDIF51
;End If
ENDIF48
;End If
ENDIF45
;End If
ENDIF43
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
	call	ENC28J60_WRITEREG

;ENC28j60_writeReg(etxndh , hulp2_h )
	movlw	7
	movwf	ADDR,BANKED
	movff	HULP2_H,ENC_OUTBYTE
	call	ENC28J60_WRITEREG

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
	call	ENC28J60_SET_RESPONSE_IPPACKET

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
	call	ENC28J60_WRITEBUFFER

;ENC28j60_packetsend(packetlength)
	movff	PACKETLENGTH,PCKTLEN
	movff	PACKETLENGTH_H,PCKTLEN_H
	rcall	ENC28J60_PACKETSEND

	return

;********************************************************************************

ENC28J60_POLL
;if ENC28j60_ReadReg( epktcnt ) > 0 Then
	movlw	57
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movf	ENC28J60_READREG,W,BANKED
	sublw	0
	btfsc	STATUS, C,ACCESS
	bra	ENDIF8
;ENC28j60_packetreceive( etherBufferSize )
	movlw	232
	movwf	MAXLEN,BANKED
	movlw	3
	movwf	MAXLEN_H,BANKED
	rcall	ENC28J60_PACKETRECEIVE

;end if
ENDIF8
;if ENC28j60_ReadReg( EIR ) & EIR_RXERIF = EIR_RXERIF Then
	movlw	28
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,SysTemp1
	btfss	SysTemp1,0,BANKED
	bra	ENDIF9
;ENC28j60_bitClear( EIR, EIR_RXERIF )
	movlw	28
	movwf	ADDR,BANKED
	movlw	1
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_BITCLEAR

;end if
ENDIF9
	return

;********************************************************************************

ENC28J60_READBUFFER
;dim eth_counter as Word
;ENC28j60_regdump
;if etherGetLength  > 1518 then Exit Sub
;ENC28j60_Select
	bcf	LATA,5,ACCESS
;Set WCOL Off
	bcf	SSP1CON1,WCOL,ACCESS
;SSPBUF = ENC28j60_READ_BUF_MEM
	movlw	58
	movwf	SSPBUF,ACCESS
;Wait While BF = Off
SysWaitLoop12
	btfss	SSP1STAT,BF,ACCESS
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
	bra	SysForLoopEnd3
SysForLoop3
	incf	ETH_COUNTER,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	ETH_COUNTER_H,F,BANKED
;if eth_counter > etherBufferSize then
	movff	ETH_COUNTER,SysWORDTempB
	movff	ETH_COUNTER_H,SysWORDTempB_H
	movlw	232
	movwf	SysWORDTempA,ACCESS
	movlw	3
	movwf	SysWORDTempA_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
;exit for
	bra	SysForLoopEnd3
;end if
;SSPBUF = 0
	clrf	SSPBUF,ACCESS
;Wait While BF = Off
SysWaitLoop13
	btfss	SSP1STAT,BF,ACCESS
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
	bra	SysForLoop3
SysForLoopEnd3
;if etherGetLength > etherBufferSize then
	movff	ETHERGETLENGTH,SysWORDTempB
	movff	ETHERGETLENGTH_H,SysWORDTempB_H
	movlw	232
	movwf	SysWORDTempA,ACCESS
	movlw	3
	movwf	SysWORDTempA_H,ACCESS
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF55
;for eth_counter = etherBufferSize+1 to etherGetLength
	movlw	232
	movwf	ETH_COUNTER,BANKED
	movlw	3
	movwf	ETH_COUNTER_H,BANKED
	movlw	233
	movwf	SysWORDTempB,ACCESS
	movlw	3
	movwf	SysWORDTempB_H,ACCESS
	movff	ETHERGETLENGTH,SysWORDTempA
	movff	ETHERGETLENGTH_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd4
SysForLoop4
	incf	ETH_COUNTER,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	ETH_COUNTER_H,F,BANKED
;SSPBUF = 0
	clrf	SSPBUF,ACCESS
;Wait While BF = Off
SysWaitLoop14
	btfss	SSP1STAT,BF,ACCESS
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
	bra	SysForLoop4
SysForLoopEnd4
;End if
ENDIF55
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
	movwf	SysRepeatTemp4,BANKED
SysRepeatLoop4
;set c off
	bcf	STATUS,C,ACCESS
;rotate banktobeselected right
	rrcf	BANKTOBESELECTED,F,BANKED
;end repeat
	decfsz	SysRepeatTemp4,F,BANKED
	bra	SysRepeatLoop4
SysRepeatLoopEnd4
;HSerPrint "$"
;HSerPrint banktobeselected
;HSerPrint ":"
;				'These registers (EIE, EIR, ESTAT, ECON2, ECON1)
;				'are present in all banks, no need to switch bank
;if lastselectedBank <> banktobeselected then
	movf	BANKTOBESELECTED,W,BANKED
	subwf	LASTSELECTEDBANK,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF10
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
	bra	ELSE11_1
;ENC28j60_selectBank ( banktobeselected, addr )
	call	ENC28J60_SELECTBANK

;else
	bra	ENDIF11
ELSE11_1
;lastselectedBank = banktobeselected
	movff	BANKTOBESELECTED,LASTSELECTEDBANK
;end if
ENDIF11
;end if
ENDIF10
;ENC28j60_Select
	bcf	LATA,5,ACCESS
;Set WCOL Off
	bcf	SSP1CON1,WCOL,ACCESS
;SSPBUF = ENC28j60_READ_CTRL_REG | ( addr AND ADDR_MASK )
	movlw	31
	andwf	ADDR,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SSPBUF
;Wait While BF = Off
SysWaitLoop3
	btfss	SSP1STAT,BF,ACCESS
	bra	SysWaitLoop3
;temp = SSPBUF
	movff	SSPBUF,TEMP
;Set WCOL Off
	bcf	SSP1CON1,WCOL,ACCESS
;SSPBUF = temp
	movff	TEMP,SSPBUF
;Wait While BF = Off
SysWaitLoop4
	btfss	SSP1STAT,BF,ACCESS
	bra	SysWaitLoop4
;temp = SSPBUF
	movff	SSPBUF,TEMP
;Set WCOL Off
	bcf	SSP1CON1,WCOL,ACCESS
;SSPBUF = temp
	movff	TEMP,SSPBUF
;Wait While BF = Off
SysWaitLoop5
	btfss	SSP1STAT,BF,ACCESS
	bra	SysWaitLoop5
;ENC28j60_ReadReg = SSPBUF
	movff	SSPBUF,ENC28J60_READREG
;ENC28j60_Deselect
	bsf	LATA,5,ACCESS
	return

;********************************************************************************

ENC28J60_REGDUMP
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF

;HSerPrint "Registerdump ENC28j60"
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
	call	HSERPRINT261

;ENC28j60_data = ENC28j60_ReadReg( erevid)
	movlw	114
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint " ENC Rev " + str( ENC28j60_data )
	movff	ENC28J60_DATA,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	call	FN_STR
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable84
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable84
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,STR
	call	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;HSerPrint " Build 037"
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
	call	HSERPRINT261

;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF

;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF

;HSerPrint "Cntrl: ECON1 ECON2 ESTAT  EIR  EIE"
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
	call	HSERPRINT261

;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF

;ENC28j60_data = ENC28j60_ReadReg( econ1)
	movlw	31
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "       " + Hex(ENC28j60_data)
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable87
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable87
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,HEX
	call	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;ENC28j60_data = ENC28j60_ReadReg( econ2)
	movlw	30
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "    " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable88
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable88
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,HEX
	call	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;ENC28j60_data = ENC28j60_ReadReg( estat)
	movlw	29
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "    " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable88
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable88
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,HEX
	call	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;ENC28j60_data = ENC28j60_ReadReg (eir)
	movlw	28
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "     " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable89
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable89
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,HEX
	call	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;ENC28j60_data = ENC28j60_ReadReg( eie)
	movlw	27
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "   " + Hex(ENC28j60_data)
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable90
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable90
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,HEX
	call	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF

;HSerPrint "MAC  : MACON1  MACON3  MACON4  MAC-Address"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable91
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable91
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF

;ENC28j60_data = ENC28j60_ReadReg( macon1)
	movlw	192
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "       " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable87
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable87
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,HEX
	call	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;ENC28j60_data = ENC28j60_ReadReg( macon2)
;HSerPrint "      " + Hex(ENC28j60_data);
;ENC28j60_data = ENC28j60_ReadReg( macon3)
	movlw	194
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "      " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable92
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable92
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,HEX
	call	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;ENC28j60_data = ENC28j60_ReadReg( macon4)
	movlw	195
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "      " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable92
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable92
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,HEX
	call	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;ENC28j60_data = ENC28j60_ReadReg( maadr5)
	movlw	228
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "      " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable92
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable92
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,HEX
	call	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;ENC28j60_data = ENC28j60_ReadReg( maadr4)
	movlw	229
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "." + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable42
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable42
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,HEX
	call	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;ENC28j60_data = ENC28j60_ReadReg( maadr3)
	movlw	226
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "." + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable42
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable42
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,HEX
	call	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;ENC28j60_data = ENC28j60_ReadReg( maadr2)
	movlw	227
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "." + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable42
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable42
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,HEX
	call	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;ENC28j60_data = ENC28j60_ReadReg( maadr1)
	movlw	224
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "." + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable42
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable42
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,HEX
	call	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;ENC28j60_data = ENC28j60_ReadReg( maadr0)
	movlw	225
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "." + Hex(ENC28j60_data)
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable42
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable42
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,HEX
	call	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF

;HSerPrint "Rx   : ERXST  ERXND  ERXWRPT ERXRDPT ERXFCON EPKTCNT MAMXFL"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable93
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable93
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF

;ENC28j60_data = ENC28j60_ReadReg(erxsth)
	movlw	9
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "       " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable87
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable87
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,HEX
	call	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;ENC28j60_data = ENC28j60_ReadReg(erxstl)
	movlw	8
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;ENC28j60_data = ENC28j60_ReadReg(erxndh)
	movlw	11
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "   " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable90
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable90
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,HEX
	call	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;ENC28j60_data = ENC28j60_ReadReg(erxndl)
	movlw	10
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;dim t1, t2 as word
;ENC28j60_data = ENC28j60_ReadReg(erxwrpth)
	movlw	15
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "   " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable90
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable90
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,HEX
	call	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;t1_h = ENC28j60_data
	movff	ENC28J60_DATA,T1_H
;ENC28j60_data = ENC28j60_ReadReg(erxwrptl)
	movlw	14
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;[byte]t1 = ENC28j60_data
	movff	ENC28J60_DATA,T1
;ENC28j60_data = ENC28j60_ReadReg(erxrdpth)
	movlw	13
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "    " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable88
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable88
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,HEX
	call	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;t2_h = ENC28j60_data
	movff	ENC28J60_DATA,T2_H
;ENC28j60_data = ENC28j60_ReadReg(erxrdptl)
	movlw	12
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;[byte]t2 = ENC28j60_data
	movff	ENC28J60_DATA,T2
;ENC28j60_data = ENC28j60_ReadReg(erxfcon)
	movlw	56
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "    " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable88
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable88
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,HEX
	call	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;ENC28j60_data = ENC28j60_ReadReg(epktcnt)
	movlw	57
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "      " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable92
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable92
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,HEX
	call	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;ENC28j60_data = ENC28j60_ReadReg(mamxflh)
	movlw	203
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "      " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable92
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable92
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,HEX
	call	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;ENC28j60_data = ENC28j60_ReadReg(mamxfll)
	movlw	202
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint Hex(ENC28j60_data)
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF

;HSerPrint "Tx   : ETXST  ETXND  EWRPT  MACLCON1 MACLCON2"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable94
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable94
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF

;ENC28j60_data = ENC28j60_ReadReg(etxsth)
	movlw	5
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "       " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable87
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable87
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,HEX
	call	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;ENC28j60_data = ENC28j60_ReadReg(etxstl)
	movlw	4
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	rcall	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;ENC28j60_data = ENC28j60_ReadReg(etxndh)
	movlw	7
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "   " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	rcall	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable90
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable90
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,HEX
	call	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT261

;ENC28j60_data = ENC28j60_ReadReg(etxndl)
	movlw	6
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	rcall	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT261

;ENC28j60_data = ENC28j60_ReadReg(EWRPTH)
	movlw	3
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "   " +  Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	rcall	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable90
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable90
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,HEX
	call	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT261

;ENC28j60_data = ENC28j60_ReadReg(EWRPTl)
	movlw	2
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	rcall	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT261

;ENC28j60_data = ENC28j60_ReadReg(maclcon1)
	movlw	200
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "   " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	rcall	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable90
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable90
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,HEX
	call	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT261

;ENC28j60_data = ENC28j60_ReadReg(maclcon2)
	movlw	201
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "       " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	rcall	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable87
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable87
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,HEX
	call	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT261

;ENC28j60_data = ENC28j60_ReadReg(maphsup)
;HSerPrint "       " + Hex(ENC28j60_data)
;HSerPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF

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
	call	ENC28J60_IP_HEADER_CHECKSUM

	return

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
	call	ENC28J60_IP_HEADER_CHECKSUM

	return

;********************************************************************************

ENC28J60_SET_RESPONSE_MACADDRESS
;For II = 1 To 6
	clrf	II,BANKED
SysForLoop5
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
	bra	SysForLoop5
SysForLoopEnd5
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
	bra	ENDIF87
	banksel	I_ODD
	incf	I_ODD,F,BANKED
ENDIF87
;If I_odd = 1 Then
	banksel	I_ODD
	decf	I_ODD,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF84
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
ENDIF84
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
	bra	SysForLoopEnd8
SysForLoop8
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
	bra	SysForLoop8
SysForLoopEnd8
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
	bcf	SSP1CON1,WCOL,ACCESS
;SSPBUF = ENC28j60_write_buf_mem
	movlw	122
	movwf	SSPBUF,ACCESS
;Wait While BF = Off
SysWaitLoop15
	btfss	SSP1STAT,BF,ACCESS
	bra	SysWaitLoop15
;temp = SSPBUF
	movff	SSPBUF,TEMP
;SSPBUF = 0x0E
	movlw	14
	movwf	SSPBUF,ACCESS
;Wait While BF = Off
SysWaitLoop16
	btfss	SSP1STAT,BF,ACCESS
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
	bra	SysForLoopEnd6
SysForLoop6
	incf	ETH_COUNTER,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	ETH_COUNTER_H,F,BANKED
;if eth_counter > etherBufferSize then Exit For
	movff	ETH_COUNTER,SysWORDTempB
	movff	ETH_COUNTER_H,SysWORDTempB_H
	movlw	232
	movwf	SysWORDTempA,ACCESS
	movlw	3
	movwf	SysWORDTempA_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd6
;SSPBUF = etherbuffer(eth_counter)
	lfsr	0,ETHERBUFFER
	movf	ETH_COUNTER,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	ETH_COUNTER_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movff	INDF0,SSPBUF
;Wait While BF = Off
SysWaitLoop17
	btfss	SSP1STAT,BF,ACCESS
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
	bra	SysForLoop6
SysForLoopEnd6
;ENC28j60_Deselect
	bsf	LATA,5,ACCESS
	return

;********************************************************************************

ENC28J60_WRITEPHYREG
;		while ((ENC28j60_ReadReg(MISTAT) & MISTAT_BUSY ) = MISTAT_BUSY )
SysDoLoop_S2
	movlw	234
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
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
	call	FN_ENC28J60_READREG
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
	movwf	SysRepeatTemp5,BANKED
SysRepeatLoop5
;set c off
	bcf	STATUS,C,ACCESS
;rotate banktobeselected right
	rrcf	BANKTOBESELECTED,F,BANKED
;end Repeat
	decfsz	SysRepeatTemp5,F,BANKED
	bra	SysRepeatLoop5
SysRepeatLoopEnd5
;if lastselectedBank <> banktobeselected then
	movf	BANKTOBESELECTED,W,BANKED
	subwf	LASTSELECTEDBANK,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ELSE12_1
;if ( ( addr & ADDR_MASK )  <= EIE  ) then
	movlw	31
	andwf	ADDR,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SysBYTETempB
	movlw	27
	movwf	SysBYTETempA,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF13
;ENC28j60_selectBank ( banktobeselected, addr )
	rcall	ENC28J60_SELECTBANK

;end if
ENDIF13
;Else
	bra	ENDIF12
ELSE12_1
;lastselectedBank = banktobeselected
	movff	BANKTOBESELECTED,LASTSELECTEDBANK
;end if
ENDIF12
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

GETSTRING
;CommandLineString(0)=12
	movlw	12
	banksel	SYSCOMMANDLINESTRING_0
	movwf	SYSCOMMANDLINESTRING_0,BANKED
;CommandLineString(1) = EtherBuffer(EtherBufferIndex)
	lfsr	0,ETHERBUFFER
	banksel	ETHERBUFFERINDEX
	movf	ETHERBUFFERINDEX,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	ETHERBUFFERINDEX_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movff	INDF0,SysArrayTemp1
	movff	SysArrayTemp1,SYSCOMMANDLINESTRING_1
;CommandLineString(2) = EtherBuffer(EtherBufferIndex+1)
	lfsr	0,ETHERBUFFER
	movf	ETHERBUFFERINDEX,W,BANKED
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp2,BANKED
	movf	ETHERBUFFERINDEX_H,W,BANKED
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp2_H,BANKED
	movlw	1
	addwf	SysTemp2,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,SysArrayTemp1
	movff	SysArrayTemp1,SYSCOMMANDLINESTRING_2
;CommandLineString(3) = EtherBuffer(EtherBufferIndex+2)
	lfsr	0,ETHERBUFFER
	movf	ETHERBUFFERINDEX,W,BANKED
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp2,BANKED
	movf	ETHERBUFFERINDEX_H,W,BANKED
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp2_H,BANKED
	movlw	2
	addwf	SysTemp2,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,SysArrayTemp1
	movff	SysArrayTemp1,SYSCOMMANDLINESTRING_3
;CommandLineString(4) = EtherBuffer(EtherBufferIndex+3)
	lfsr	0,ETHERBUFFER
	movf	ETHERBUFFERINDEX,W,BANKED
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp2,BANKED
	movf	ETHERBUFFERINDEX_H,W,BANKED
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp2_H,BANKED
	movlw	3
	addwf	SysTemp2,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,SysArrayTemp1
	movff	SysArrayTemp1,SYSCOMMANDLINESTRING_4
;CommandLineString(5) = EtherBuffer(EtherBufferIndex+4)
	lfsr	0,ETHERBUFFER
	movf	ETHERBUFFERINDEX,W,BANKED
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp2,BANKED
	movf	ETHERBUFFERINDEX_H,W,BANKED
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp2_H,BANKED
	movlw	4
	addwf	SysTemp2,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,SysArrayTemp1
	movff	SysArrayTemp1,SYSCOMMANDLINESTRING_5
;CommandLineString(6) = EtherBuffer(EtherBufferIndex+5)
	lfsr	0,ETHERBUFFER
	movf	ETHERBUFFERINDEX,W,BANKED
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp2,BANKED
	movf	ETHERBUFFERINDEX_H,W,BANKED
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp2_H,BANKED
	movlw	5
	addwf	SysTemp2,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,SysArrayTemp1
	movff	SysArrayTemp1,SYSCOMMANDLINESTRING_6
;CommandLineString(7) = EtherBuffer(EtherBufferIndex+6)
	lfsr	0,ETHERBUFFER
	movf	ETHERBUFFERINDEX,W,BANKED
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp2,BANKED
	movf	ETHERBUFFERINDEX_H,W,BANKED
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp2_H,BANKED
	movlw	6
	addwf	SysTemp2,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,SysArrayTemp1
	movff	SysArrayTemp1,SYSCOMMANDLINESTRING_7
;CommandLineString(8) = EtherBuffer(EtherBufferIndex+7)
	lfsr	0,ETHERBUFFER
	movf	ETHERBUFFERINDEX,W,BANKED
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp2,BANKED
	movf	ETHERBUFFERINDEX_H,W,BANKED
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp2_H,BANKED
	movlw	7
	addwf	SysTemp2,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,SysArrayTemp1
	movff	SysArrayTemp1,SYSCOMMANDLINESTRING_8
;CommandLineString(9) = EtherBuffer(EtherBufferIndex+8)
	lfsr	0,ETHERBUFFER
	movf	ETHERBUFFERINDEX,W,BANKED
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp2,BANKED
	movf	ETHERBUFFERINDEX_H,W,BANKED
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp2_H,BANKED
	movlw	8
	addwf	SysTemp2,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,SysArrayTemp1
	movff	SysArrayTemp1,SYSCOMMANDLINESTRING_9
;CommandLineString(10) = EtherBuffer(EtherBufferIndex+9)
	lfsr	0,ETHERBUFFER
	movf	ETHERBUFFERINDEX,W,BANKED
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp2,BANKED
	movf	ETHERBUFFERINDEX_H,W,BANKED
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp2_H,BANKED
	movlw	9
	addwf	SysTemp2,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,SysArrayTemp1
	movff	SysArrayTemp1,SYSCOMMANDLINESTRING_10
;CommandLineString(11) = EtherBuffer(EtherBufferIndex+10)
	lfsr	0,ETHERBUFFER
	movf	ETHERBUFFERINDEX,W,BANKED
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp2,BANKED
	movf	ETHERBUFFERINDEX_H,W,BANKED
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp2_H,BANKED
	movlw	10
	addwf	SysTemp2,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,SysArrayTemp1
	movff	SysArrayTemp1,SYSCOMMANDLINESTRING_11
;CommandLineString(12) = EtherBuffer(EtherBufferIndex+11)
	lfsr	0,ETHERBUFFER
	movf	ETHERBUFFERINDEX,W,BANKED
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp2,BANKED
	movf	ETHERBUFFERINDEX_H,W,BANKED
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp2_H,BANKED
	movlw	11
	addwf	SysTemp2,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,SysArrayTemp1
	movff	SysArrayTemp1,SYSCOMMANDLINESTRING_12
;HSerPrint "*"
;HSerPrint commandlineString
;HSerSend 9
;for ttttt = 1 to 12
;AA = commandlineString( ttttt )
;IF AA > 31 Then
;HSerPrint AA
;Else
;HSerPrint HEX(AA )
;END IF
;HSerPrint ","
;next
;HSerPrint "*"
;HSerPrintCRLF
	return

;********************************************************************************

FN_HEX
;Hex(0) = 2
	movlw	2
	banksel	SYSHEX_0
	movwf	SYSHEX_0,BANKED
;SysStringTemp = SysValTemp And 0x0F
	movlw	15
	banksel	SYSVALTEMP
	andwf	SYSVALTEMP,W,BANKED
	movwf	SYSSTRINGTEMP,BANKED
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	sublw	9
	btfsc	STATUS, C,ACCESS
	bra	ENDIF20
	movlw	7
	addwf	SYSSTRINGTEMP,F,BANKED
ENDIF20
;Hex(2) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W,BANKED
	banksel	SYSHEX_2
	movwf	SYSHEX_2,BANKED
;For SysStringTemp = 1 to 4
	banksel	SYSSTRINGTEMP
	clrf	SYSSTRINGTEMP,BANKED
SysForLoop1
	incf	SYSSTRINGTEMP,F,BANKED
;Rotate SysValTemp Right
	rrcf	SYSVALTEMP,F,BANKED
;Next
	movlw	4
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop1
SysForLoopEnd1
;SysStringTemp = SysValTemp And 0x0F
	movlw	15
	andwf	SYSVALTEMP,W,BANKED
	movwf	SYSSTRINGTEMP,BANKED
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	sublw	9
	btfsc	STATUS, C,ACCESS
	bra	ENDIF22
	movlw	7
	addwf	SYSSTRINGTEMP,F,BANKED
ENDIF22
;Hex(1) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W,BANKED
	banksel	SYSHEX_1
	movwf	SYSHEX_1,BANKED
	banksel	0
	return

;********************************************************************************

;Overloaded signature: STRING:byte:
HSERPRINT261
;PrintLen = PrintData(0)
	movff	SysPRINTDATAHandler,AFSR0
	movff	SysPRINTDATAHandler_H,AFSR0_H
	movff	INDF0,PRINTLEN
;If PrintLen <> 0 then
	movf	PRINTLEN,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF24
;for SysPrintTemp = 1 to PrintLen
	clrf	SYSPRINTTEMP,BANKED
	movlw	1
	subwf	PRINTLEN,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd2
SysForLoop2
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
	bra	SysForLoop2
SysForLoopEnd2
;End If
ENDIF24
	return

;********************************************************************************

;Overloaded signature: BYTE:byte:
HSERPRINT262
;OutValueTemp = 0
	clrf	OUTVALUETEMP,BANKED
;IF SerPrintVal >= 100 Then
	movlw	100
	subwf	SERPRINTVAL,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	ENDIF118
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
ENDIF118
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
	bra	ENDIF119
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
ENDIF119
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
HSERPRINT263
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
	bra	ENDIF120
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
ENDIF120
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
	bra	ENDIF121
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
ENDIF121
;If SerPrintVal >= 100 then
	movff	SERPRINTVAL,SysWORDTempA
	movff	SERPRINTVAL_H,SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF122
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
ENDIF122
;If SerPrintVal >= 10 then
	movff	SERPRINTVAL,SysWORDTempA
	movff	SERPRINTVAL_H,SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF123
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
ENDIF123
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
	movff	HSERPRINTCRLFCOUNT,SysRepeatTemp6
	movf	SYSREPEATTEMP6,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd6
SysRepeatLoop6
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
	decfsz	SysRepeatTemp6,F,BANKED
	bra	SysRepeatLoop6
SysRepeatLoopEnd6
	return

;********************************************************************************

HSERSEND
;if comport = 1 Then
	decf	COMPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF23
;Wait While TX1IF = Off
SysWaitLoop8
	btfss	PIR1,TX1IF,ACCESS
	bra	SysWaitLoop8
;Wait While TX1IF = Off
SysWaitLoop9
	btfss	PIR1,TX1IF,ACCESS
	bra	SysWaitLoop9
;TXREG1 = SerData
	movff	SERDATA,TXREG1
;end if
ENDIF23
	return

;********************************************************************************

HTTPCOMMANDLINE
;dim CommandLineString as string * 12
;dim zzz, TableLoc as word
;TableLoc = 1
	movlw	1
	movwf	TABLELOC,BANKED
	clrf	TABLELOC_H,BANKED
;For zz = 1 to 2
	clrf	ZZ,BANKED
SysForLoop10
	incf	ZZ,F,BANKED
;For TableLoc = 40 To 120
	movlw	39
	movwf	TABLELOC,BANKED
	clrf	TABLELOC_H,BANKED
SysForLoop11
	incf	TABLELOC,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	TABLELOC_H,F,BANKED
;GetString ( TableLoc )
	movff	TABLELOC,ETHERBUFFERINDEX
	movff	TABLELOC_H,ETHERBUFFERINDEX_H
	rcall	GETSTRING

;if zz = 1 then
	decf	ZZ,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE100_1
;If Left(CommandLineString,5) = "GET /" Then
	movlw	low COMMANDLINESTRING
	movwf	SysSYSINSTRINGHandler,BANKED
	movlw	high COMMANDLINESTRING
	movwf	SysSYSINSTRINGHandler_H,BANKED
	movlw	5
	movwf	SYSCHARCOUNT,BANKED
	rcall	FN_LEFT
	lfsr	1,SYSTEMPARRAY
	movlw	low StringTable113
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable113
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	lfsr	0,LEFT
	lfsr	1,SYSTEMPARRAY
	call	SysCompEqualString
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF103
;HSerPrintCRLF
;HSerPrint "%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
;HSerPrintCRLF
;HSerPrint commandlineString
;HSerPrintCRLF
;HSerPrint "%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
;HSerPrintCRLF
;lastGet = 1
	movlw	1
	movwf	LASTGET,BANKED
;TableLoc += 5
	movlw	5
	addwf	TABLELOC,F,BANKED
	movlw	0
	addwfc	TABLELOC_H,F,BANKED
;GetString ( TableLoc )
	movff	TABLELOC,ETHERBUFFERINDEX
	movff	TABLELOC_H,ETHERBUFFERINDEX_H
	rcall	GETSTRING

;HSerPrintCRLF
;HSerPrint "%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
;HSerPrintCRLF
;HSerPrint commandlineString
;HSerPrintCRLF
;HSerPrint "%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
;HSerPrintCRLF
;If Left(CommandLineString , 6) = " HTTP/" Then
	movlw	low COMMANDLINESTRING
	movwf	SysSYSINSTRINGHandler,BANKED
	movlw	high COMMANDLINESTRING
	movwf	SysSYSINSTRINGHandler_H,BANKED
	movlw	6
	movwf	SYSCHARCOUNT,BANKED
	rcall	FN_LEFT
	lfsr	1,SYSTEMPARRAY
	movlw	low StringTable114
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable114
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	lfsr	0,LEFT
	lfsr	1,SYSTEMPARRAY
	call	SysCompEqualString
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF105
;CommandLineString = "index.htm"
	lfsr	1,COMMANDLINESTRING
	movlw	low StringTable19
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable19
	movwf	TBLPTRH,ACCESS
	call	SysReadString
;Exit sub
	return
;End if
ENDIF105
;Exit For  'no longer look for GET / as we have found it.
	bra	SysForLoopEnd11
;End IF
ENDIF103
;Else
	bra	ENDIF100
ELSE100_1
;if lastGet = 1 then
	decf	LASTGET,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF104
;HSerPrint "!!"
;HSerPrintCRLF
;zzz = instr( CommandLineString , " " )
	movlw	low COMMANDLINESTRING
	movwf	SysSYSINSTRINGHandler,BANKED
	movlw	high COMMANDLINESTRING
	movwf	SysSYSINSTRINGHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable76
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable76
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysSYSFINDSTRINGHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysSYSFINDSTRINGHandler_H,BANKED
	rcall	FN_INSTR
	movff	INSTR,ZZZ
	clrf	ZZZ_H,BANKED
;CommandLineString = left( CommandLineString, zzz - 1 )
	movlw	low COMMANDLINESTRING
	movwf	SysSYSINSTRINGHandler,BANKED
	movlw	high COMMANDLINESTRING
	movwf	SysSYSINSTRINGHandler_H,BANKED
	decf	ZZZ,W,BANKED
	movwf	SYSCHARCOUNT,BANKED
	rcall	FN_LEFT
	lfsr	1,COMMANDLINESTRING
	lfsr	0,LEFT
	call	SysCopyString
;end if
ENDIF104
;exit sub
	return
;End if
ENDIF100
;Next
	movff	TABLELOC,SysWORDTempA
	movff	TABLELOC_H,SysWORDTempA_H
	movlw	120
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop11
SysForLoopEnd11
;Next
	movlw	2
	subwf	ZZ,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop10
SysForLoopEnd10
;CommandLineString = "400"
	lfsr	1,COMMANDLINESTRING
	movlw	low StringTable115
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable115
	movwf	TBLPTRH,ACCESS
	goto	SysReadString

;********************************************************************************

HTTPPART3
;If Tcp_ack = 1 Then
	btfss	SYSBITVAR0,5,BANKED
	bra	ENDIF88
;If etherBuffer(17) = 0 Then
	banksel	SYSETHERBUFFER_17
	movf	SYSETHERBUFFER_17,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF89
;If etherBuffer(18) = 40 Then
	movlw	40
	subwf	SYSETHERBUFFER_18,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF90
;If Ackpsh = 1 Then
	banksel	ACKPSH
	decf	ACKPSH,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF91
;HSerPrint "ack&ackpush=1"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable100
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable100
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT261

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
;HTTPPrintStandardHeader
	rcall	HTTPPRINTSTANDARDHEADER

;HTTP_HANDLER
	rcall	PORTSSTATUS_HTM

;End If
ENDIF91
;End If
ENDIF90
;End If
ENDIF89
;End If
ENDIF88
	banksel	0
	return

;********************************************************************************

HTTPPART4
;' If an ACK and FIN is received and the destination port address is valid
;If Tcp_ack = 1 Then
	btfss	SYSBITVAR0,5,BANKED
	bra	ENDIF92
;If Tcp_fin = 1 Then
	btfss	SYSBITVAR0,1,BANKED
	bra	ENDIF93
;HSerPrint "ack&fin"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable105
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable105
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT261

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
	call	SWAP102
	movff	SYSCALCTEMPA,SYSETHERBUFFER_36
	movff	SYSCALCTEMPB,SYSETHERBUFFER_38

;Swap Tcp_srcporth , Tcp_destporth
	movff	SYSETHERBUFFER_35,SYSCALCTEMPA
	movff	SYSETHERBUFFER_37,SYSCALCTEMPB
	call	SWAP102
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
	call	ENC28J60_WRITEBUFFER

;ENC28j60_packetsend(60)
	movlw	60
	movwf	PCKTLEN,BANKED
	clrf	PCKTLEN_H,BANKED
	call	ENC28J60_PACKETSEND

;End If
ENDIF93
;End If
ENDIF92
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
	movlw	232
	movwf	SysWORDTempA,ACCESS
	movlw	3
	movwf	SysWORDTempA_H,ACCESS
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF94
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF

;HSerPrint "empty the buffer"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable107
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable107
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT261

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
ENDIF94
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
	bra	ENDIF97
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
ENDIF97
	return

;********************************************************************************

HTTPPRINTSTANDARDHEADER
;HTTPPrint( "HTTP/1.0 200 OK", HTTPPrintCRLF )
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable106
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable106
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
	bra	ELSE98_1
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
	bra	ENDIF99
;HSerPrint "  PAD! "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable108
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable108
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT261

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
ENDIF99
;Ackpsh = 0
	clrf	ACKPSH,BANKED
;
;HSerPrintCRLF
;FOR hulp2 = 0X0037 TO arrayloc
;HSerSend etherbuffer(HULP2)
;Next
;HSerPrintCRLF
;Else
	bra	ENDIF98
ELSE98_1
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
ENDIF98
;HSerPrintCRLF
	movlw	1
	banksel	HSERPRINTCRLFCOUNT
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF

;HSerPrint "Send:"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable109
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable109
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT261

;HSerPrint T_ip_srcaddr0
	movff	SYSETHERBUFFER_27,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT262

;HSerPrint ","
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable60
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable60
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT261

;HSerPrint T_ip_srcaddr1
	movff	SYSETHERBUFFER_28,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT262

;HSerPrint ","
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable60
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable60
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT261

;HSerPrint T_ip_srcaddr2
	movff	SYSETHERBUFFER_29,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT262

;HSerPrint ","
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable60
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable60
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT261

;HSerPrint T_ip_srcaddr3
	movff	SYSETHERBUFFER_30,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT262

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
	movlw	low StringTable110
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable110
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT261

;HSerPrint ( TCPresult16 + [byte]IP_HeaderSize )
	movlw	14
	addwf	TCPRESULT16,W,BANKED
	movwf	SERPRINTVAL,BANKED
	movlw	0
	addwfc	TCPRESULT16_H,W,BANKED
	movwf	SERPRINTVAL_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT263

;HSerPrint ", TCP Pkt:"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable111
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable111
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT261

;HSerPrint ( TCPresult16 - 40 )
	movlw	40
	subwf	TCPRESULT16,W,BANKED
	movwf	SERPRINTVAL,BANKED
	movlw	0
	subwfb	TCPRESULT16_H,W,BANKED
	movwf	SERPRINTVAL_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT263

;HSerPrint ", HTML:"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable112
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable112
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT261

;HSerPrint ( TCPresult16 - 88 )
	movlw	88
	subwf	TCPRESULT16,W,BANKED
	movwf	SERPRINTVAL,BANKED
	movlw	0
	subwfb	TCPRESULT16_H,W,BANKED
	movwf	SERPRINTVAL_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT263

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
	call	ENC28J60_PACKETSEND

	return

;********************************************************************************

INITSYS
;nop             ' This is the routine for the OSCCON config
	nop
;OSCCON = OSCCON OR b'01110000'
	movlw	112
	iorwf	OSCCON,F,ACCESS
;BSR = 0
	clrf	BSR,ACCESS
;TBLPTRU = 0
	clrf	TBLPTRU,ACCESS
;SET ADFM OFF
	bcf	ADCON2,ADFM,ACCESS
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON,ACCESS
;ANSELA = 0
	banksel	ANSELA
	clrf	ANSELA,BANKED
;ANSELB = 0
	clrf	ANSELB,BANKED
;ANSELC = 0
	clrf	ANSELC,BANKED
;C2ON = 0
	bcf	CM2CON0,C2ON,ACCESS
;C1ON = 0
	bcf	CM1CON0,C1ON,ACCESS
;PORTA = 0
	clrf	PORTA,ACCESS
;PORTB = 0
	clrf	PORTB,ACCESS
;PORTC = 0
	clrf	PORTC,ACCESS
;PORTE = 0
	clrf	PORTE,ACCESS
	banksel	0
	return

;********************************************************************************

INITUSART
;comport = 1
	movlw	1
	movwf	COMPORT,BANKED
;SPBRG = SPBRGL_TEMP
	movlw	33
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

FN_INSTR
;Instr = 0
	clrf	INSTR,BANKED
;SysStrLen = SysInString(0)
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movff	INDF0,SYSSTRLEN
;If SysStrLen = 0 Then Exit Function
	movf	SYSSTRLEN,F,BANKED
	btfsc	STATUS, Z,ACCESS
	return
;SysFindLen = SysFindString(0)
	movff	SysSYSFINDSTRINGHandler,AFSR0
	movff	SysSYSFINDSTRINGHandler_H,AFSR0_H
	movff	INDF0,SYSFINDLEN
;If SysFindLen = 0 Then Exit Function
	movf	SYSFINDLEN,F,BANKED
	btfsc	STATUS, Z,ACCESS
	return
;If SysFindLen > SysStrLen Then Exit Function
	movf	SYSFINDLEN,W,BANKED
	subwf	SYSSTRLEN,W,BANKED
	btfss	STATUS, C,ACCESS
	return
;SysSearchEnd = SysStrLen - SysFindLen
	movf	SYSFINDLEN,W,BANKED
	subwf	SYSSTRLEN,W,BANKED
	movwf	SYSSEARCHEND,BANKED
;For SysStringTemp = 0 to SysSearchEnd
	setf	SYSSTRINGTEMP,BANKED
	movlw	0
	subwf	SYSSEARCHEND,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd12
SysForLoop12
	incf	SYSSTRINGTEMP,F,BANKED
;For SysStrData = 1 To SysFindLen
	clrf	SYSSTRDATA,BANKED
	movlw	1
	subwf	SYSFINDLEN,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd13
SysForLoop13
	incf	SYSSTRDATA,F,BANKED
;If SysInString(SysStringTemp + SysStrData) <> SysFindString(SysStrData) Then Goto SysInstrNextPos
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	SysSYSINSTRINGHandler,W,BANKED
	movwf	SysTemp2,BANKED
	movlw	0
	addwfc	SysSYSINSTRINGHandler_H,W,BANKED
	movwf	SysTemp2_H,BANKED
	movf	SYSSTRDATA,W,BANKED
	addwf	SysTemp2,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,SysArrayTemp1
	movf	SYSSTRDATA,W,BANKED
	addwf	SysSYSFINDSTRINGHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysSYSFINDSTRINGHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,SysArrayTemp2
	movf	SYSARRAYTEMP2,W,BANKED
	subwf	SYSARRAYTEMP1,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SYSINSTRNEXTPOS
;Next
	movf	SYSFINDLEN,W,BANKED
	subwf	SYSSTRDATA,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop13
SysForLoopEnd13
;Instr = SysStringTemp + 1
	incf	SYSSTRINGTEMP,W,BANKED
	movwf	INSTR,BANKED
;Exit Function
	return
SYSINSTRNEXTPOS
;Next
	movf	SYSSEARCHEND,W,BANKED
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop12
SysForLoopEnd12
;Instr = 0
	clrf	INSTR,BANKED
	return

;********************************************************************************

FN_LEFT
;If SysInString(0) = 0 Then
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	INDF0,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF114
;Left(0) = 0
	banksel	SYSLEFT_0
	clrf	SYSLEFT_0,BANKED
;Exit Function
	banksel	0
	return
;End If
ENDIF114
;If SysInString(0) < SysCharCount Then
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	SYSCHARCOUNT,W,BANKED
	subwf	INDF0,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	ENDIF115
;SysCharCount = SysInString(0)
	movff	SysSYSINSTRINGHandler,AFSR0
	movff	SysSYSINSTRINGHandler_H,AFSR0_H
	movff	INDF0,SYSCHARCOUNT
;End If
ENDIF115
;For SysStringTemp = 1 To SysCharCount
	clrf	SYSSTRINGTEMP,BANKED
	movlw	1
	subwf	SYSCHARCOUNT,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd14
SysForLoop14
	incf	SYSSTRINGTEMP,F,BANKED
;Left(SysStringTemp) = SysInString(SysStringTemp)
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	SysSYSINSTRINGHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysSYSINSTRINGHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,SysArrayTemp2
	movff	SysArrayTemp2,SysArrayTemp1
	lfsr	0,LEFT
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	SysArrayTemp1,INDF0
;Next
	movf	SYSCHARCOUNT,W,BANKED
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop14
SysForLoopEnd14
;Left(0) = SysCharCount
	movff	SYSCHARCOUNT,SYSLEFT_0
	return

;********************************************************************************

PORTSSTATUS_HTM
;dim analogChannel as byte
;dir porta.0 in
	bsf	TRISA,0,ACCESS
;dir porta.1 in
	bsf	TRISA,1,ACCESS
;dir porta.2 in
	bsf	TRISA,2,ACCESS
;dir porta.3 in
	bsf	TRISA,3,ACCESS
;HTTPPrint( "REFRESH: 5",HTTPPrintCRLF )
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable21
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable21
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H,BANKED
	movlw	1
	movwf	HTTPPRINTCRLFFLAG,BANKED
	rcall	HTTPPRINT

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

;HTTPPrint ( "<html><font face=helvetica>")
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable23
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable23
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H,BANKED
	clrf	HTTPPRINTCRLFFLAG,BANKED
	rcall	HTTPPRINT

;HTTPPrint ( "<img alt=""GCB Logo!"" title=""Great Cow BASIC"" ")
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable24
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable24
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H,BANKED
	clrf	HTTPPRINTCRLFFLAG,BANKED
	rcall	HTTPPRINT

;HTTPPrint ( "src=""http://goo.gl/FZ4v4e"" height=""36"" ")
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable25
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable25
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H,BANKED
	clrf	HTTPPRINTCRLFFLAG,BANKED
	rcall	HTTPPRINT

;HTTPPrint ("width=""243""><br><br />" )
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable26
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable26
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H,BANKED
	clrf	HTTPPRINTCRLFFLAG,BANKED
	rcall	HTTPPRINT

;HTTPPrint  ("&nbsp;&nbsp;Evan is ")
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable27
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable27
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H,BANKED
	clrf	HTTPPRINTCRLFFLAG,BANKED
	rcall	HTTPPRINT

;if ReadAD( 0 ) < 50 then
	clrf	ADREADPORT,BANKED
	rcall	FN_READAD47
	movlw	50
	subwf	SYSREADADBYTE,W,BANKED
	btfsc	STATUS, C,ACCESS
	bra	ENDIF124
;HTTPPrint ("not ")
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable28
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable28
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H,BANKED
	clrf	HTTPPRINTCRLFFLAG,BANKED
	rcall	HTTPPRINT

;end if
ENDIF124
;HTTPPrint " in the lab at the moment.."
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable29
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable29
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H,BANKED
	clrf	HTTPPRINTCRLFFLAG,BANKED
	rcall	HTTPPRINT

;if ReadAD( 0 ) < 50 then
	clrf	ADREADPORT,BANKED
	rcall	FN_READAD47
	movlw	50
	subwf	SYSREADADBYTE,W,BANKED
	btfsc	STATUS, C,ACCESS
	bra	ELSE125_1
;HTTPPrint ("probably working at his real job!")
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable30
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable30
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H,BANKED
	clrf	HTTPPRINTCRLFFLAG,BANKED
	rcall	HTTPPRINT

;Else
	bra	ENDIF125
ELSE125_1
;HTTPPrint ("probably working on a Great Cow BASIC solution!")
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable31
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable31
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H,BANKED
	clrf	HTTPPRINTCRLFFLAG,BANKED
	rcall	HTTPPRINT

;end if
ENDIF125
;HTTPPrint "<br /><br />"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable32
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable32
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H,BANKED
	clrf	HTTPPRINTCRLFFLAG,BANKED
	rcall	HTTPPRINT

;HTTPPrint "&nbsp;&nbsp;Analog inputs are: "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable33
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable33
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H,BANKED
	clrf	HTTPPRINTCRLFFLAG,BANKED
	rcall	HTTPPRINT

;HTTPPrint "<br />"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable34
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable34
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H,BANKED
	clrf	HTTPPRINTCRLFFLAG,BANKED
	rcall	HTTPPRINT

;for analogChannel = 0 to 3
	setf	ANALOGCHANNEL,BANKED
SysForLoop15
	incf	ANALOGCHANNEL,F,BANKED
;HTTPPrint "<br />&nbsp;&nbsp;ADC"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable35
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable35
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H,BANKED
	clrf	HTTPPRINTCRLFFLAG,BANKED
	rcall	HTTPPRINT

;HTTPPrint str(analogChannel)
	movff	ANALOGCHANNEL,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	rcall	FN_STR
	movlw	low STR
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high STR
	movwf	SysHTTPDATAHandler_H,BANKED
	clrf	HTTPPRINTCRLFFLAG,BANKED
	rcall	HTTPPRINT

;HTTPPrint ": "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable36
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable36
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H,BANKED
	clrf	HTTPPRINTCRLFFLAG,BANKED
	rcall	HTTPPRINT

;HTTPPrint str(ReadAD( analogChannel ))
	movff	ANALOGCHANNEL,ADREADPORT
	rcall	FN_READAD47
	movff	SYSREADADBYTE,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	rcall	FN_STR
	movlw	low STR
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high STR
	movwf	SysHTTPDATAHandler_H,BANKED
	clrf	HTTPPRINTCRLFFLAG,BANKED
	rcall	HTTPPRINT

;HTTPPrint "<br />"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable34
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable34
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H,BANKED
	clrf	HTTPPRINTCRLFFLAG,BANKED
	rcall	HTTPPRINT

;next
	movlw	3
	subwf	ANALOGCHANNEL,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop15
SysForLoopEnd15
;HTTPPrint "<br />"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable34
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable34
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H,BANKED
	clrf	HTTPPRINTCRLFFLAG,BANKED
	rcall	HTTPPRINT

;HTTPPrint "&nbsp;&nbspPorts A:&nbsp;" + ByteToBin(porta)
	movff	PORTA,BYTENUM
	call	FN_BYTETOBIN
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable37
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable37
	movwf	TBLPTRH,ACCESS
	rcall	SysReadStringPart
	lfsr	0,BYTETOBIN
	rcall	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H,BANKED
	clrf	HTTPPRINTCRLFFLAG,BANKED
	rcall	HTTPPRINT

;HTTPPrint "&nbsp;&nbsp;B:&nbsp;" + ByteToBin(portb)
	movff	PORTB,BYTENUM
	call	FN_BYTETOBIN
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable38
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable38
	movwf	TBLPTRH,ACCESS
	rcall	SysReadStringPart
	lfsr	0,BYTETOBIN
	rcall	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H,BANKED
	clrf	HTTPPRINTCRLFFLAG,BANKED
	rcall	HTTPPRINT

;HTTPPrint "&nbsp;&nbsp;C:&nbsp;" + ByteToBin(portc)
	movff	PORTC,BYTENUM
	call	FN_BYTETOBIN
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable39
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable39
	movwf	TBLPTRH,ACCESS
	rcall	SysReadStringPart
	lfsr	0,BYTETOBIN
	rcall	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H,BANKED
	clrf	HTTPPRINTCRLFFLAG,BANKED
	rcall	HTTPPRINT

;HTTPPrint "&nbsp;&nbsp;E:&nbsp;" + ByteToBin(porte)
	movff	PORTE,BYTENUM
	call	FN_BYTETOBIN
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable40
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable40
	movwf	TBLPTRH,ACCESS
	rcall	SysReadStringPart
	lfsr	0,BYTETOBIN
	rcall	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H,BANKED
	clrf	HTTPPRINTCRLFFLAG,BANKED
	rcall	HTTPPRINT

;HTTPPrint "<br /><br />"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable32
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable32
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H,BANKED
	clrf	HTTPPRINTCRLFFLAG,BANKED
	call	HTTPPRINT

;HTTPPrint "&nbsp;&nbsp;Source: " + str(T_ip_destaddr0)
	movff	SYSETHERBUFFER_31,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	rcall	FN_STR
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable41
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable41
	movwf	TBLPTRH,ACCESS
	rcall	SysReadStringPart
	lfsr	0,STR
	rcall	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H,BANKED
	clrf	HTTPPRINTCRLFFLAG,BANKED
	call	HTTPPRINT

;HTTPPrint "." + str(T_ip_destaddr1)
	movff	SYSETHERBUFFER_32,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	rcall	FN_STR
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable42
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable42
	movwf	TBLPTRH,ACCESS
	rcall	SysReadStringPart
	lfsr	0,STR
	rcall	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H,BANKED
	clrf	HTTPPRINTCRLFFLAG,BANKED
	call	HTTPPRINT

;HTTPPrint "." + str(T_ip_destaddr2)
	movff	SYSETHERBUFFER_33,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	rcall	FN_STR
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable42
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable42
	movwf	TBLPTRH,ACCESS
	rcall	SysReadStringPart
	lfsr	0,STR
	rcall	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H,BANKED
	clrf	HTTPPRINTCRLFFLAG,BANKED
	call	HTTPPRINT

;HTTPPrint "." + str(T_ip_destaddr3)
	movff	SYSETHERBUFFER_34,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	rcall	FN_STR
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable42
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable42
	movwf	TBLPTRH,ACCESS
	rcall	SysReadStringPart
	lfsr	0,STR
	rcall	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H,BANKED
	clrf	HTTPPRINTCRLFFLAG,BANKED
	call	HTTPPRINT

;HTTPPrint "<br /><br />"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable32
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable32
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H,BANKED
	clrf	HTTPPRINTCRLFFLAG,BANKED
	call	HTTPPRINT

;HTTPPrint ( "<img alt=""Lab"" title=""Great Cow BASIC"" ")
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable43
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable43
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H,BANKED
	clrf	HTTPPRINTCRLFFLAG,BANKED
	call	HTTPPRINT

;if ReadAD( 0 ) < 50 then
	clrf	ADREADPORT,BANKED
	rcall	FN_READAD47
	movlw	50
	subwf	SYSREADADBYTE,W,BANKED
	btfsc	STATUS, C,ACCESS
	bra	ELSE127_1
;HTTPPrint ( "src=""http://goo.gl/yNg5Tr"" height=""217"" width=""386"" ")
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable44
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable44
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H,BANKED
	clrf	HTTPPRINTCRLFFLAG,BANKED
	call	HTTPPRINT

;Else
	bra	ENDIF127
ELSE127_1
;HTTPPrint ( "src=""http://goo.gl/NUOFWu"" height=""424"" width=""239"" ")
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable45
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable45
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H,BANKED
	clrf	HTTPPRINTCRLFFLAG,BANKED
	call	HTTPPRINT

;end if
ENDIF127
;HTTPPrint ("><br><br />" )
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable46
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable46
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H,BANKED
	clrf	HTTPPRINTCRLFFLAG,BANKED
	call	HTTPPRINT

;HTTPPrint ("</html>")
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable47
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable47
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H,BANKED
	clrf	HTTPPRINTCRLFFLAG,BANKED
	call	HTTPPRINT

;HTTPSend
	setf	HTTPCLOSETRANSACTION,BANKED
	call	HTTPSEND

	return

;********************************************************************************

;Overloaded signature: BYTE:
FN_READAD47
;***************************************
;Perform conversion
;LLReadAD 1
;Select Case ADReadPort ' #IFDEF Var(ANSELA). ANSELA exists @DebugADC_H
;Case 0: Set ANSELA.0 On
SysSelect6Case1
	movf	ADREADPORT,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case2
	banksel	ANSELA
	bsf	ANSELA,0,BANKED
;Case 1: Set ANSELA.1 On
	bra	SysSelectEnd6
SysSelect6Case2
	decf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case3
	banksel	ANSELA
	bsf	ANSELA,1,BANKED
;Case 2: Set ANSELA.2 On
	bra	SysSelectEnd6
SysSelect6Case3
	movlw	2
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case4
	banksel	ANSELA
	bsf	ANSELA,2,BANKED
;Case 3: Set ANSELA.3 On
	bra	SysSelectEnd6
SysSelect6Case4
	movlw	3
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case5
	banksel	ANSELA
	bsf	ANSELA,3,BANKED
;Case 4: Set ANSELA.5 On
	bra	SysSelectEnd6
SysSelect6Case5
	movlw	4
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case6
	banksel	ANSELA
	bsf	ANSELA,5,BANKED
;Case 12: Set ANSELB.0 On
	bra	SysSelectEnd6
SysSelect6Case6
	movlw	12
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case7
	banksel	ANSELB
	bsf	ANSELB,0,BANKED
;Case 10: Set ANSELB.1 On
	bra	SysSelectEnd6
SysSelect6Case7
	movlw	10
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case8
	banksel	ANSELB
	bsf	ANSELB,1,BANKED
;Case 8: Set ANSELB.2 On
	bra	SysSelectEnd6
SysSelect6Case8
	movlw	8
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case9
	banksel	ANSELB
	bsf	ANSELB,2,BANKED
;Case 9: Set ANSELB.3 On
	bra	SysSelectEnd6
SysSelect6Case9
	movlw	9
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case10
	banksel	ANSELB
	bsf	ANSELB,3,BANKED
;Case 11: Set ANSELB.4 On
	bra	SysSelectEnd6
SysSelect6Case10
	movlw	11
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case11
	banksel	ANSELB
	bsf	ANSELB,4,BANKED
;Case 13: Set ANSELB.5 On
	bra	SysSelectEnd6
SysSelect6Case11
	movlw	13
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case12
	banksel	ANSELB
	bsf	ANSELB,5,BANKED
;Case 14: Set ANSELC.2 On
	bra	SysSelectEnd6
SysSelect6Case12
	movlw	14
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case13
	banksel	ANSELC
	bsf	ANSELC,2,BANKED
;Case 15: Set ANSELC.3 On
	bra	SysSelectEnd6
SysSelect6Case13
	movlw	15
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case14
	banksel	ANSELC
	bsf	ANSELC,3,BANKED
;Case 16: Set ANSELC.4 On
	bra	SysSelectEnd6
SysSelect6Case14
	movlw	16
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case15
	banksel	ANSELC
	bsf	ANSELC,4,BANKED
;Case 17: Set ANSELC.5 On
	bra	SysSelectEnd6
SysSelect6Case15
	movlw	17
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case16
	banksel	ANSELC
	bsf	ANSELC,5,BANKED
;Case 18: Set ANSELC.6 On
	bra	SysSelectEnd6
SysSelect6Case16
	movlw	18
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case17
	banksel	ANSELC
	bsf	ANSELC,6,BANKED
;Case 19: Set ANSELC.7 On
	bra	SysSelectEnd6
SysSelect6Case17
	movlw	19
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case18
	banksel	ANSELC
	bsf	ANSELC,7,BANKED
;End Select  'End Select #1
SysSelect6Case18
SysSelectEnd6
;SET ADCS1 OFF
	bcf	ADCON2,ADCS1,ACCESS
;SET ADCS0 ON
	bsf	ADCON2,ADCS0,ACCESS
;SET ADCON0.CHS0 OFF
	bcf	ADCON0,CHS0,ACCESS
;SET ADCON0.CHS1 OFF
	bcf	ADCON0,CHS1,ACCESS
;SET ADCON0.CHS2 OFF
	bcf	ADCON0,CHS2,ACCESS
;SET ADCON0.CHS3 OFF
	bcf	ADCON0,CHS3,ACCESS
;SET ADCON0.CHS4 OFF
	bcf	ADCON0,CHS4,ACCESS
;IF ADReadPort.0 On Then Set ADCON0.CHS0 On
	banksel	ADREADPORT
	btfsc	ADREADPORT,0,BANKED
	bsf	ADCON0,CHS0,ACCESS
;IF ADReadPort.1 On Then Set ADCON0.CHS1 On
	btfsc	ADREADPORT,1,BANKED
	bsf	ADCON0,CHS1,ACCESS
;IF ADReadPort.2 On Then Set ADCON0.CHS2 On
	btfsc	ADREADPORT,2,BANKED
	bsf	ADCON0,CHS2,ACCESS
;If ADReadPort.3 On Then Set ADCON0.CHS3 On
	btfsc	ADREADPORT,3,BANKED
	bsf	ADCON0,CHS3,ACCESS
;If ADReadPort.4 On Then Set ADCON0.CHS4 On
	btfsc	ADREADPORT,4,BANKED
	bsf	ADCON0,CHS4,ACCESS
;SET ADCON0.ADON ON
	bsf	ADCON0,ADON,ACCESS
;Wait AD_Delay
	movlw	2
	movwf	SysWaitTemp10US,ACCESS
	call	Delay_10US
;SET ADCON0.GO_NOT_DONE ON
	bsf	ADCON0,GO_NOT_DONE,ACCESS
;nop
	nop
;Wait While ADCON0.GO_NOT_DONE ON
SysWaitLoop18
	btfsc	ADCON0,GO_NOT_DONE,ACCESS
	bra	SysWaitLoop18
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON,ACCESS
;ANSELA = 0
	banksel	ANSELA
	clrf	ANSELA,BANKED
;ANSELB = 0
	clrf	ANSELB,BANKED
;ANSELC = 0
	clrf	ANSELC,BANKED

;ReadAD = ADRESH
	movff	ADRESH,READAD
;SET ADFM OFF
	bcf	ADCON2,ADFM,ACCESS
	banksel	0
	return

;********************************************************************************

;Overloaded signature: BYTE:BYTE:
SPIMODE217
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

FN_STR
;SysCharCount = 0
	clrf	SYSCHARCOUNT,BANKED
;Dim SysCalcTempX As Word
;IF SysValTemp >= 10000 then
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB,ACCESS
	movlw	39
	movwf	SysWORDTempB_H,ACCESS
	rcall	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF16
;SysStrData = SysValTemp / 10000
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB,ACCESS
	movlw	39
	movwf	SysWORDTempB_H,ACCESS
	rcall	SysDivSub16
	movff	SysWORDTempA,SYSSTRDATA
;SysValTemp = SysCalcTempX
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
;SysCharCount += 1
	incf	SYSCHARCOUNT,F,BANKED
;Str(SysCharCount) = SysStrData + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSSTRDATA,W,BANKED
	movwf	INDF0,ACCESS
;Goto SysValThousands
	bra	SYSVALTHOUSANDS
;End If
ENDIF16
;IF SysValTemp >= 1000 then
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB,ACCESS
	movlw	3
	movwf	SysWORDTempB_H,ACCESS
	rcall	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF17
SYSVALTHOUSANDS
;SysStrData = SysValTemp / 1000
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB,ACCESS
	movlw	3
	movwf	SysWORDTempB_H,ACCESS
	rcall	SysDivSub16
	movff	SysWORDTempA,SYSSTRDATA
;SysValTemp = SysCalcTempX
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
;SysCharCount += 1
	incf	SYSCHARCOUNT,F,BANKED
;Str(SysCharCount) = SysStrData + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSSTRDATA,W,BANKED
	movwf	INDF0,ACCESS
;Goto SysValHundreds
	bra	SYSVALHUNDREDS
;End If
ENDIF17
;IF SysValTemp >= 100 then
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF18
SYSVALHUNDREDS
;SysStrData = SysValTemp / 100
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysDivSub16
	movff	SysWORDTempA,SYSSTRDATA
;SysValTemp = SysCalcTempX
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
;SysCharCount += 1
	incf	SYSCHARCOUNT,F,BANKED
;Str(SysCharCount) = SysStrData + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSSTRDATA,W,BANKED
	movwf	INDF0,ACCESS
;Goto SysValTens
	bra	SYSVALTENS
;End If
ENDIF18
;IF SysValTemp >= 10 Then
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF19
SYSVALTENS
;SysStrData = SysValTemp / 10
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysDivSub16
	movff	SysWORDTempA,SYSSTRDATA
;SysValTemp = SysCalcTempX
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
;SysCharCount += 1
	incf	SYSCHARCOUNT,F,BANKED
;Str(SysCharCount) = SysStrData + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSSTRDATA,W,BANKED
	movwf	INDF0,ACCESS
;End If
ENDIF19
;SysCharCount += 1
	incf	SYSCHARCOUNT,F,BANKED
;Str(SysCharCount) = SysValTemp + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSVALTEMP,W,BANKED
	movwf	INDF0,ACCESS
;SysValTemp = SysCalcTempX
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
;Str(0) = SysCharCount
	movff	SYSCHARCOUNT,SYSSTR_0
	return

;********************************************************************************

;Overloaded signature: BYTE:BYTE:
SWAP102
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

SYSCOMPEQUALSTRING
;Dim SysByteTempA As Byte
;Dim SysByteTempX As Byte
;SysByteTempX = 0
	clrf	SYSBYTETEMPX,ACCESS
;movf INDF0, W
	movf	INDF0, W,ACCESS
;cpfseq POSTINC1
	cpfseq	POSTINC1,ACCESS
;return
	return
;movf INDF0, F
	movf	INDF0, F,ACCESS
;bz SCEStrTrue
	bz	SCESTRTRUE
;movff POSTINC0, SysByteTempA
	movff	POSTINC0, SYSBYTETEMPA
SYSSTRINGCOMP
;movf POSTINC0, W
	movf	POSTINC0, W,ACCESS
;cpfseq POSTINC1
	cpfseq	POSTINC1,ACCESS
;return
	return
;decfsz SysByteTempA, F
	decfsz	SYSBYTETEMPA, F,ACCESS
;goto SysStringComp
	bra	SYSSTRINGCOMP
SCESTRTRUE
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

SYSCOPYSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;movff INDF0, SysCalcTempA
	movff	INDF0, SYSCALCTEMPA
;movff SysCalcTempA, INDF1
	movff	SYSCALCTEMPA, INDF1
;goto SysCopyStringCheck
	bra	SYSCOPYSTRINGCHECK
;When appending, add length to counter
SYSCOPYSTRINGPART
;movf INDF0, W
	movf	INDF0, W,ACCESS
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA,ACCESS
;addwf SysStringLength, F
	addwf	SYSSTRINGLENGTH, F,ACCESS
SYSCOPYSTRINGCHECK
;movf SysCalcTempA,F
	movf	SYSCALCTEMPA,F,ACCESS
;btfsc STATUS,Z
	btfsc	STATUS,Z,ACCESS
;return
	return
SYSSTRINGCOPY
;movff PREINC0, PREINC1
	movff	PREINC0, PREINC1
;decfsz SysCalcTempA, F
	decfsz	SYSCALCTEMPA, F,ACCESS
;goto SysStringCopy
	bra	SYSSTRINGCOPY
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
	bra	ENDIF62
;SysWordTempA = 0
	clrf	SYSWORDTEMPA,ACCESS
	clrf	SYSWORDTEMPA_H,ACCESS
;exit sub
	return
;end if
ENDIF62
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
	bra	ENDIF63
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0,ACCESS
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W,ACCESS
	addwf	SYSDIVMULTX,F,ACCESS
	movf	SYSDIVMULTB_H,W,ACCESS
	addwfc	SYSDIVMULTX_H,F,ACCESS
;End If
ENDIF63
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
	db	114,32,48,51,55


StringTable5
	db	11,73,110,105,116,105,97,108,105,115,101,100


StringTable19
	db	9,105,110,100,101,120,46,104,116,109


StringTable21
	db	10,82,69,70,82,69,83,72,58,32,53


StringTable22
	db	0


StringTable23
	db	27,60,104,116,109,108,62,60,102,111,110,116,32,102,97,99,101,61,104,101,108,118
	db	101,116,105,99,97,62


StringTable24
	db	45,60,105,109,103,32,97,108,116,61,34,71,67,66,32,76,111,103,111,33,34,32,116,105
	db	116,108,101,61,34,71,114,101,97,116,32,67,111,119,32,66,65,83,73,67,34,32


StringTable25
	db	39,115,114,99,61,34,104,116,116,112,58,47,47,103,111,111,46,103,108,47,70,90,52,118
	db	52,101,34,32,104,101,105,103,104,116,61,34,51,54,34,32


StringTable26
	db	22,119,105,100,116,104,61,34,50,52,51,34,62,60,98,114,62,60,98,114,32,47,62


StringTable27
	db	20,38,110,98,115,112,59,38,110,98,115,112,59,69,118,97,110,32,105,115,32


StringTable28
	db	4,110,111,116,32


StringTable29
	db	27,32,105,110,32,116,104,101,32,108,97,98,32,97,116,32,116,104,101,32,109,111
	db	109,101,110,116,46,46


StringTable30
	db	33,112,114,111,98,97,98,108,121,32,119,111,114,107,105,110,103,32,97,116,32,104
	db	105,115,32,114,101,97,108,32,106,111,98,33


StringTable31
	db	47,112,114,111,98,97,98,108,121,32,119,111,114,107,105,110,103,32,111,110,32,97
	db	32,71,114,101,97,116,32,67,111,119,32,66,65,83,73,67,32,115,111,108,117,116,105,111
	db	110,33


StringTable32
	db	12,60,98,114,32,47,62,60,98,114,32,47,62


StringTable33
	db	31,38,110,98,115,112,59,38,110,98,115,112,59,65,110,97,108,111,103,32,105,110
	db	112,117,116,115,32,97,114,101,58,32


StringTable34
	db	6,60,98,114,32,47,62


StringTable35
	db	21,60,98,114,32,47,62,38,110,98,115,112,59,38,110,98,115,112,59,65,68,67


StringTable36
	db	2,58,32


StringTable37
	db	25,38,110,98,115,112,59,38,110,98,115,112,80,111,114,116,115,32,65,58,38,110,98,115
	db	112,59


StringTable38
	db	20,38,110,98,115,112,59,38,110,98,115,112,59,66,58,38,110,98,115,112,59


StringTable39
	db	20,38,110,98,115,112,59,38,110,98,115,112,59,67,58,38,110,98,115,112,59


StringTable40
	db	20,38,110,98,115,112,59,38,110,98,115,112,59,69,58,38,110,98,115,112,59


StringTable41
	db	20,38,110,98,115,112,59,38,110,98,115,112,59,83,111,117,114,99,101,58,32


StringTable42
	db	1,46


StringTable43
	db	39,60,105,109,103,32,97,108,116,61,34,76,97,98,34,32,116,105,116,108,101,61,34,71
	db	114,101,97,116,32,67,111,119,32,66,65,83,73,67,34,32


StringTable44
	db	52,115,114,99,61,34,104,116,116,112,58,47,47,103,111,111,46,103,108,47,121,78
	db	103,53,84,114,34,32,104,101,105,103,104,116,61,34,50,49,55,34,32,119,105,100
	db	116,104,61,34,51,56,54,34,32


StringTable45
	db	52,115,114,99,61,34,104,116,116,112,58,47,47,103,111,111,46,103,108,47,78,85,79,70
	db	87,117,34,32,104,101,105,103,104,116,61,34,52,50,52,34,32,119,105,100,116,104
	db	61,34,50,51,57,34,32


StringTable46
	db	11,62,60,98,114,62,60,98,114,32,47,62


StringTable47
	db	7,60,47,104,116,109,108,62


StringTable58
	db	1,33


StringTable59
	db	6,70,108,97,103,115,58


StringTable60
	db	1,44


StringTable61
	db	4,70,73,78,32


StringTable62
	db	4,83,89,78,32


StringTable63
	db	4,82,83,84,32


StringTable64
	db	4,80,83,72,32


StringTable65
	db	4,65,67,75,32


StringTable66
	db	8,84,67,80,95,85,82,71,32


StringTable67
	db	8,115,121,110,38,33,102,105,110


StringTable68
	db	7,97,99,107,38,112,115,104


StringTable70
	db	25,35,50,69,82,68,80,84,76,32,97,110,100,32,69,82,68,80,84,72,32,101,114,114
	db	111,114


StringTable71
	db	1,48


StringTable76
	db	1,32


StringTable83
	db	21,82,101,103,105,115,116,101,114,100,117,109,112,32,69,78,67,50,56,106,54,48


StringTable84
	db	9,32,69,78,67,32,82,101,118,32


StringTable85
	db	10,32,66,117,105,108,100,32,48,51,55


StringTable86
	db	34,67,110,116,114,108,58,32,69,67,79,78,49,32,69,67,79,78,50,32,69,83,84,65,84,32
	db	32,69,73,82,32,32,69,73,69


StringTable87
	db	7,32,32,32,32,32,32,32


StringTable88
	db	4,32,32,32,32


StringTable89
	db	5,32,32,32,32,32


StringTable90
	db	3,32,32,32


StringTable91
	db	42,77,65,67,32,32,58,32,77,65,67,79,78,49,32,32,77,65,67,79,78,51,32,32,77,65
	db	67,79,78,52,32,32,77,65,67,45,65,100,100,114,101,115,115


StringTable92
	db	6,32,32,32,32,32,32


StringTable93
	db	59,82,120,32,32,32,58,32,69,82,88,83,84,32,32,69,82,88,78,68,32,32,69,82,88,87
	db	82,80,84,32,69,82,88,82,68,80,84,32,69,82,88,70,67,79,78,32,69,80,75,84,67,78
	db	84,32,77,65,77,88,70,76


StringTable94
	db	45,84,120,32,32,32,58,32,69,84,88,83,84,32,32,69,84,88,78,68,32,32,69,87,82,80
	db	84,32,32,77,65,67,76,67,79,78,49,32,77,65,67,76,67,79,78,50


StringTable100
	db	13,97,99,107,38,97,99,107,112,117,115,104,61,49


StringTable105
	db	7,97,99,107,38,102,105,110


StringTable106
	db	15,72,84,84,80,47,49,46,48,32,50,48,48,32,79,75


StringTable107
	db	16,101,109,112,116,121,32,116,104,101,32,98,117,102,102,101,114


StringTable108
	db	7,32,32,80,65,68,33,32


StringTable109
	db	5,83,101,110,100,58


StringTable110
	db	7,66,47,87,105,114,101,58


StringTable111
	db	10,44,32,84,67,80,32,80,107,116,58


StringTable112
	db	7,44,32,72,84,77,76,58


StringTable113
	db	5,71,69,84,32,47


StringTable114
	db	6,32,72,84,84,80,47


StringTable115
	db	3,52,48,48


StringTable135
	db	1,49


;********************************************************************************


 END
