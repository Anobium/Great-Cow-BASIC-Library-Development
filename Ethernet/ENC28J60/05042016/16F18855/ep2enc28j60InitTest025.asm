;Program compiled by Great Cow BASIC (0.95 2016-04-30)
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
ARRAYLOC_E	EQU	38
ARRAYLOC_H	EQU	36
ARRAYLOC_U	EQU	37
BANKTOBESELECTED	EQU	39
BUTTONSTATE	EQU	40
CLIENT_SEQNUM	EQU	41
CLIENT_SEQNUM_E	EQU	45
CLIENT_SEQNUM_H	EQU	46
CLIENT_SEQNUM_U	EQU	47
COMPORT	EQU	48
COUNTLOOP	EQU	49
COUNTLOOP_H	EQU	50
CRL	EQU	51
DELAYTEMP	EQU	112
DELAYTEMP2	EQU	113
ENC28J60_DATA	EQU	52
ENC28J60_READREG	EQU	53
ENC28J60_TEMP	EQU	54
ENC_OUTBYTE	EQU	55
ENC_OUTBYTE1	EQU	56
ENC_OUTBYTE2	EQU	57
ENDPTR	EQU	58
ENDPTR_H	EQU	59
ETHERBUFFER	EQU	8697
ETHERGETLENGTH	EQU	60
ETHERGETLENGTH_H	EQU	61
ETH_COUNTER	EQU	62
ETH_COUNTER_H	EQU	64
ETH_FRAMELENGTH	EQU	65
ETH_FRAMELENGTH_H	EQU	67
EXPECTED_ACK	EQU	68
EXPECTED_ACK_E	EQU	71
EXPECTED_ACK_H	EQU	69
EXPECTED_ACK_U	EQU	70
FLAGS	EQU	72
FNLSL	EQU	73
FNLSL_E	EQU	76
FNLSL_H	EQU	74
FNLSL_U	EQU	75
FNLSR	EQU	77
FNLSR_E	EQU	80
FNLSR_H	EQU	78
FNLSR_U	EQU	79
HSERPRINTCRLFCOUNT	EQU	81
HTMLMAPPING	EQU	82
HTMLMAPPINGTYPE	EQU	83
HULP2	EQU	84
HULP2_H	EQU	86
HULP3	EQU	87
II	EQU	88
II_H	EQU	89
INCOMING_ACK	EQU	90
INCOMING_ACK_E	EQU	94
INCOMING_ACK_H	EQU	95
INCOMING_ACK_U	EQU	96
IPADDR	EQU	8620
IPPORT	EQU	97
IPROUTER	EQU	8615
IPSERVER	EQU	8610
IP_CHECKSUM16	EQU	98
IP_CHECKSUM16_H	EQU	99
IP_CHKSUM32	EQU	100
IP_CHKSUM32_E	EQU	103
IP_CHKSUM32_H	EQU	101
IP_CHKSUM32_U	EQU	102
IP_HEADER_LENGTH	EQU	104
IP_HULP1	EQU	105
IP_ID	EQU	106
IP_ID_H	EQU	108
IP_TEMP16	EQU	109
IP_TEMP16_H	EQU	110
IP_X	EQU	111
I_CHECKSUM16	EQU	125
I_CHECKSUM16_H	EQU	127
I_CHKSUM32	EQU	160
I_CHKSUM32_E	EQU	163
I_CHKSUM32_H	EQU	161
I_CHKSUM32_U	EQU	164
I_ODD	EQU	165
I_X	EQU	166
I_X_H	EQU	167
LASTSELECTEDBANK	EQU	168
LOCALTMP	EQU	169
LOCALTMP_H	EQU	171
MACADDR	EQU	8625
MACADDRROUTER	EQU	8605
MAXLEN	EQU	172
MAXLEN_H	EQU	173
MSG_TEMP2	EQU	8632
NEXTPACKETPTR	EQU	174
NEXTPACKETPTR_H	EQU	176
NUMBITS	EQU	177
OUTVALUETEMP	EQU	178
PACKETLENGTH	EQU	179
PACKETLENGTH_H	EQU	181
PCKTLEN	EQU	182
PCKTLEN_H	EQU	183
PHYREGADDR	EQU	184
PREVIOUS_NEXTPACKETPTR	EQU	185
PREVIOUS_NEXTPACKETPTR_H	EQU	186
PRINTLEN	EQU	187
RESULT	EQU	188
RESULT_H	EQU	189
RXSTAT	EQU	190
RXSTAT_H	EQU	191
SERDATA	EQU	192
SERPRINTVAL	EQU	193
SERPRINTVAL_H	EQU	194
SHOWT	EQU	195
SNTPSERVERADDR	EQU	8600
SPICLOCKMODE	EQU	196
SPICURRENTMODE	EQU	197
SPIRXDATA	EQU	198
SPITXDATA	EQU	199
STARTPTR	EQU	200
STARTPTR_H	EQU	201
STRINGPOINTER	EQU	202
SUM	EQU	203
SUM_E	EQU	206
SUM_H	EQU	204
SUM_U	EQU	205
SYSARRAYTEMP1	EQU	207
SYSARRAYTEMP2	EQU	208
SYSBITVAR0	EQU	209
SYSBYTETEMPA	EQU	117
SYSBYTETEMPB	EQU	121
SYSBYTETEMPX	EQU	112
SYSCALCTEMPA	EQU	117
SYSCALCTEMPB	EQU	121
SYSCALCTEMPX	EQU	112
SYSCALCTEMPX_H	EQU	113
SYSDIVLOOP	EQU	116
SYSDIVMULTA	EQU	119
SYSDIVMULTA_H	EQU	120
SYSDIVMULTB	EQU	123
SYSDIVMULTB_H	EQU	124
SYSDIVMULTX	EQU	114
SYSDIVMULTX_H	EQU	115
SYSFNBYTE1	EQU	210
SYSLONGTEMPB	EQU	121
SYSLONGTEMPB_E	EQU	124
SYSLONGTEMPB_H	EQU	122
SYSLONGTEMPB_U	EQU	123
SYSMACADDRHANDLER	EQU	211
SYSMACADDRHANDLER_H	EQU	212
SYSPRINTDATAHANDLER	EQU	213
SYSPRINTDATAHANDLER_H	EQU	214
SYSPRINTTEMP	EQU	215
SYSREPEATTEMP1	EQU	216
SYSREPEATTEMP2	EQU	217
SYSREPEATTEMP3	EQU	218
SYSREPEATTEMP4	EQU	219
SYSREPEATTEMP5	EQU	220
SYSREPEATTEMP6	EQU	221
SYSREPEATTEMP7	EQU	222
SYSREPEATTEMP8	EQU	223
SYSREPEATTEMP9	EQU	224
SYSSTRINGA	EQU	119
SYSSTRINGA_H	EQU	120
SYSSTRINGLENGTH	EQU	118
SYSTEMP1	EQU	225
SYSTEMP1_E	EQU	228
SYSTEMP1_H	EQU	226
SYSTEMP1_U	EQU	227
SYSTEMP2	EQU	229
SYSTEMP2_H	EQU	230
SYSTEMP3	EQU	231
SYSWAITTEMPMS	EQU	114
SYSWAITTEMPMS_H	EQU	115
SYSWORDTEMPA	EQU	117
SYSWORDTEMPA_H	EQU	118
SYSWORDTEMPB	EQU	121
SYSWORDTEMPB_H	EQU	122
SYSWORDTEMPX	EQU	112
SYSWORDTEMPX_H	EQU	113
TABLELOC	EQU	232
TABLELOC_H	EQU	233
TCPDATALEN_IN	EQU	234
TCPDATALEN_IN_H	EQU	235
TCPDATALEN_OUT	EQU	236
TCPDATALEN_OUT_H	EQU	237
TCPRESULT16	EQU	238
TCPRESULT16_H	EQU	288
TEMP	EQU	289
TEMPSTRING1	EQU	8597
TEMPWORD3	EQU	290
TEMPWORD3_H	EQU	291
TEMPWORD4	EQU	292
TEMPWORD4_H	EQU	293
TT	EQU	294
TT_H	EQU	295
T_UDP_DESTPORT	EQU	296
T_UDP_DESTPORT_H	EQU	297
VAL1	EQU	298
VAL2	EQU	299
VAL2_H	EQU	300
VAL3	EQU	301
VAL4	EQU	302
WORK	EQU	303
X_ODD	EQU	304

;********************************************************************************

;Alias variables
AFSR0	EQU	4
AFSR0_H	EQU	5
I_VALUE16	EQU	125
I_VALUE16_H	EQU	127
SSPBUF	EQU	396
SSPCON1	EQU	400
SSPSTAT	EQU	399
SYSETHERBUFFER_1	EQU	826
SYSETHERBUFFER_10	EQU	835
SYSETHERBUFFER_11	EQU	836
SYSETHERBUFFER_12	EQU	837
SYSETHERBUFFER_13	EQU	838
SYSETHERBUFFER_14	EQU	839
SYSETHERBUFFER_15	EQU	840
SYSETHERBUFFER_17	EQU	842
SYSETHERBUFFER_18	EQU	843
SYSETHERBUFFER_19	EQU	844
SYSETHERBUFFER_2	EQU	827
SYSETHERBUFFER_20	EQU	845
SYSETHERBUFFER_21	EQU	846
SYSETHERBUFFER_22	EQU	847
SYSETHERBUFFER_23	EQU	848
SYSETHERBUFFER_24	EQU	849
SYSETHERBUFFER_25	EQU	850
SYSETHERBUFFER_26	EQU	851
SYSETHERBUFFER_27	EQU	852
SYSETHERBUFFER_28	EQU	853
SYSETHERBUFFER_29	EQU	854
SYSETHERBUFFER_3	EQU	828
SYSETHERBUFFER_30	EQU	855
SYSETHERBUFFER_31	EQU	856
SYSETHERBUFFER_32	EQU	857
SYSETHERBUFFER_33	EQU	858
SYSETHERBUFFER_34	EQU	859
SYSETHERBUFFER_35	EQU	860
SYSETHERBUFFER_36	EQU	861
SYSETHERBUFFER_37	EQU	862
SYSETHERBUFFER_38	EQU	863
SYSETHERBUFFER_39	EQU	864
SYSETHERBUFFER_4	EQU	829
SYSETHERBUFFER_40	EQU	865
SYSETHERBUFFER_41	EQU	866
SYSETHERBUFFER_42	EQU	867
SYSETHERBUFFER_43	EQU	868
SYSETHERBUFFER_44	EQU	869
SYSETHERBUFFER_45	EQU	870
SYSETHERBUFFER_46	EQU	871
SYSETHERBUFFER_47	EQU	872
SYSETHERBUFFER_48	EQU	873
SYSETHERBUFFER_49	EQU	874
SYSETHERBUFFER_5	EQU	830
SYSETHERBUFFER_50	EQU	875
SYSETHERBUFFER_51	EQU	876
SYSETHERBUFFER_52	EQU	877
SYSETHERBUFFER_55	EQU	928
SYSETHERBUFFER_56	EQU	929
SYSETHERBUFFER_57	EQU	930
SYSETHERBUFFER_58	EQU	931
SYSETHERBUFFER_59	EQU	932
SYSETHERBUFFER_6	EQU	831
SYSETHERBUFFER_60	EQU	933
SYSETHERBUFFER_61	EQU	934
SYSETHERBUFFER_7	EQU	832
SYSETHERBUFFER_8	EQU	833
SYSETHERBUFFER_9	EQU	834
SYSIPADDR_1	EQU	701
SYSIPADDR_2	EQU	702
SYSIPADDR_3	EQU	703
SYSIPADDR_4	EQU	704
SYSMACADDR_1	EQU	706
SYSMACADDR_2	EQU	707
SYSMACADDR_3	EQU	708
SYSMACADDR_4	EQU	709
SYSMACADDR_5	EQU	710
SYSMACADDR_6	EQU	711

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
;Automatic pin direction setting
	bcf	TRISA,0

;Start of the main program
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
;showt = 0
	banksel	SHOWT
	clrf	SHOWT
;UNLOCKPPS
;dim IntState as bit
;IntState = GIE
	bcf	SYSBITVAR0,6
	btfsc	INTCON,GIE
	bsf	SYSBITVAR0,6
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
	btfss	SYSBITVAR0,6
	bcf	INTCON,GIE
	btfsc	SYSBITVAR0,6
	bsf	INTCON,GIE
;#define USART_BAUD_RATE 9600
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
RESET_ENC26J60
;HserPrint "ENC28j60 Ethernet Driver 025" : HSerPrintCRLF
	movlw	low StringTable4
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable4) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT252
	call	HSERPRINT252
	pagesel	$
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$
;ipaddr = 192,168,0,1
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
	movlw	1
	movwf	INDF0
;macaddr = 0x00, 0x1E, 0xC0, 0x00, 0x00, 0x02
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
	movlw	2
	movwf	INDF0
;ipport = 80
	movlw	80
	movwf	IPPORT
;ipserver = 192,168,0,106
	movlw	low IPSERVER
	movwf	FSR0L
	movlw	high IPSERVER
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
	movlw	106
	movwf	INDF0
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
;#define SwitchIn porta.5
;dir SwitchIn  in
	bsf	TRISA,5
;#define ButtonDown = 0
;buttonstate = ButtonDown
	clrf	BUTTONSTATE
;ENC28j60_bitSet( ECON1 , econ1_txrst )
	movlw	31
	movwf	ADDR
	movlw	128
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_BITSET
	call	ENC28J60_BITSET
	pagesel	$
;ENC28j60_bitClear( ECON1 , econ1_txrst )
	movlw	31
	movwf	ADDR
	movlw	128
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_BITCLEAR
	call	ENC28J60_BITCLEAR
	pagesel	$
;ENC28j60_Ntp_get                       'get the Network Time once
;ENC28j60_writeReg(ERXFCON, 0x00)
	movlw	56
	movwf	ADDR
	clrf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;Do forever
SysDoLoop_S1
;if SwitchIn = buttonstate then
	clrf	SysCalcTempA
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
;Loop
	goto	SysDoLoop_S1
SysDoLoop_E1
;end
	goto	BASPROGRAMEND
;----- Support methods.  Subroutines and Functions
;CHANGE Epoch_seconds  TO SUIT LOCAL NEEDS.. IN SECONDS!!
;#define ENC28j60_Handle_udp My_udp_handler
;If you want use the CALCULATED UDP checksum.  Not required typically.
;#define ENC28j60_UDP_checkSum_Supported
;If you want the ENC28j60 to respond to ICMP/Ping requests
;#define ENC28j60_ping_Supported
;If you want the ENC28j60 to put things on the terminal
;#define ENC28j60_Hserial_Supported
;#define ENC28j60_packetCounting_Supported
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
	banksel	SYSBITVAR0
	bcf	SYSBITVAR0,0
	banksel	WORK
	btfss	WORK,0
	goto	ENDIF74
	banksel	SYSBITVAR0
	bsf	SYSBITVAR0,0
ENDIF74
;Tcp_syn = Work.1
	banksel	SYSBITVAR0
	bcf	SYSBITVAR0,1
	banksel	WORK
	btfss	WORK,1
	goto	ENDIF75
	banksel	SYSBITVAR0
	bsf	SYSBITVAR0,1
ENDIF75
;Tcp_rst = Work.2
	banksel	SYSBITVAR0
	bcf	SYSBITVAR0,2
	banksel	WORK
	btfss	WORK,2
	goto	ENDIF76
	banksel	SYSBITVAR0
	bsf	SYSBITVAR0,2
ENDIF76
;Tcp_psh = Work.3
	banksel	SYSBITVAR0
	bcf	SYSBITVAR0,3
	banksel	WORK
	btfss	WORK,3
	goto	ENDIF77
	banksel	SYSBITVAR0
	bsf	SYSBITVAR0,3
ENDIF77
;Tcp_ack = Work.4
	banksel	SYSBITVAR0
	bcf	SYSBITVAR0,4
	banksel	WORK
	btfss	WORK,4
	goto	ENDIF78
	banksel	SYSBITVAR0
	bsf	SYSBITVAR0,4
ENDIF78
;Tcp_urg = Work.5
	banksel	SYSBITVAR0
	bcf	SYSBITVAR0,5
	banksel	WORK
	btfss	WORK,5
	goto	ENDIF79
	banksel	SYSBITVAR0
	bsf	SYSBITVAR0,5
ENDIF79
;#define debug0
HTTPPART1
;If Tcp_syn = 1 Then
	banksel	SYSBITVAR0
	btfss	SYSBITVAR0,1
	goto	ENDIF64
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
	pagesel	SWAP91
	call	SWAP91
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
	pagesel	SWAP91
	call	SWAP91
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
;etherbuffer(49) = 0X02
	movlw	2
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
	banksel	TT
	movwf	TT
	movlw	0
	banksel	SYSTEMP2_H
	addwfc	SysTemp2_H,W
	banksel	TT_H
	movwf	TT_H
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
	banksel	PCKTLEN
	movwf	PCKTLEN
	banksel	TT_H
	movf	TT_H,W
	banksel	PCKTLEN_H
	movwf	PCKTLEN_H
	banksel	STATUS
	pagesel	ENC28J60_WRITEBUFFER
	call	ENC28J60_WRITEBUFFER
	pagesel	$
;ENC28j60_packetsend(tt)
	banksel	TT
	movf	TT,W
	banksel	PCKTLEN
	movwf	PCKTLEN
	banksel	TT_H
	movf	TT_H,W
	banksel	PCKTLEN_H
	movwf	PCKTLEN_H
	banksel	STATUS
	pagesel	ENC28J60_PACKETSEND
	call	ENC28J60_PACKETSEND
	pagesel	$
;Ackpsh = 0
	clrf	ACKPSH
;End If
ENDIF64
HTTPPART2
;' If an ACK and PSH is received and the destination port address is valid
;If Tcp_ack = 1 Then
	banksel	SYSBITVAR0
	btfss	SYSBITVAR0,4
	goto	ENDIF65
;If Tcp_psh = 1 Then
	btfss	SYSBITVAR0,3
	goto	ENDIF67
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
;T_ip_destaddr0 = T_ip_srcaddr0
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
	pagesel	SWAP91
	call	SWAP91
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
	pagesel	SWAP91
	call	SWAP91
	pagesel	$
	movf	SYSCALCTEMPA,W
	banksel	SYSETHERBUFFER_35
	movwf	SYSETHERBUFFER_35
	movf	SYSCALCTEMPB,W
	movwf	SYSETHERBUFFER_37
;'           'swap mac
;'           Call Packetshape
;ENC28j60_Packetshape
	banksel	STATUS
	pagesel	ENC28J60_PACKETSHAPE
	call	ENC28J60_PACKETSHAPE
	pagesel	$
;'
;'           Incoming_ack0 = Tcp_seqnum0
;'           Incoming_ack1 = Tcp_seqnum1
;'           Incoming_ack2 = Tcp_seqnum2
;'           Incoming_ack3 = Tcp_seqnum3
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
;HSerPrint hex(Tcp_seqnum3)
;HSerPrint hex(Tcp_seqnum2)
;HSerPrint hex(Tcp_seqnum1)
;HSerPrint hex(Tcp_seqnum0)
;HSerSend 9
;HSerPrint hex(Incoming_ack_E)
;HSerPrint hex(Incoming_ack_U)
;HSerPrint hex(Incoming_ack_H)
;HSerPrint hex(Incoming_ack)
;HSerPrintCRLF
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
;HSerPrint hex(Incoming_ack_E)
;HSerPrint hex(Incoming_ack_U)
;HSerPrint hex(Incoming_ack_H)
;HSerPrint hex(Incoming_ack)
;HSerSend 9
;Tcp_seqnum0 = Tcp_acknum0
	banksel	SYSETHERBUFFER_46
	movf	SYSETHERBUFFER_46,W
	movwf	SYSETHERBUFFER_42
;Tcp_seqnum1 = Tcp_acknum1
	movf	SYSETHERBUFFER_45,W
	movwf	SYSETHERBUFFER_41
;Tcp_seqnum2 = Tcp_acknum2
	movf	SYSETHERBUFFER_44,W
	movwf	SYSETHERBUFFER_40
;Tcp_seqnum3 = Tcp_acknum3
	movf	SYSETHERBUFFER_43,W
	movwf	SYSETHERBUFFER_39
;
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
;HSerPrint hex(Tcp_seqnum3)
;HSerPrint hex(Tcp_seqnum2)
;HSerPrint hex(Tcp_seqnum1)
;HSerPrint hex(Tcp_seqnum0)
;HSerPrintCRLF
;etherBuffer(17) = 0
	clrf	SYSETHERBUFFER_17
;etherBuffer(18) = 40
	movlw	40
	movwf	SYSETHERBUFFER_18
;
;'5 x 4 = 20 bytes
;etherBuffer(47) = 0x50
	movlw	80
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
	banksel	SYSETHERBUFFER_55
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
;etherBuffer(55) = 0x01
;etherBuffer(56) = 0x01
;etherBuffer(57) = 0x08
;etherBuffer(58) = 0x0a
;etherBuffer(59) = 0x12
;etherBuffer(60) = 0xcc
;etherBuffer(61) = 0x00
;'           etherBuffer(62) = 0x7d
;etherBuffer(63) = 0x00
;etherBuffer(64) = 0x0d
;etherBuffer(65) = 0x2b
;etherBuffer(66) = 0xe0
;
;
;Call Ip_header_checksum
;Call Tcp_checksum
;Call ENC28j60packetsend(60)
;ENC28j60_ip_header_checksum
	banksel	STATUS
	pagesel	ENC28J60_IP_HEADER_CHECKSUM
	call	ENC28J60_IP_HEADER_CHECKSUM
;ENC28j60_tcp_checksum
	pagesel	ENC28J60_TCP_CHECKSUM
	call	ENC28J60_TCP_CHECKSUM
	pagesel	$
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
	banksel	SYSTEMP2
	movwf	SysTemp2
	movf	SysWORDTempX_H,W
	movwf	SysTemp2_H
	banksel	SYSETHERBUFFER_18
	movf	SYSETHERBUFFER_18,W
	banksel	SYSTEMP2
	addwf	SysTemp2,W
	movwf	SysTemp1
	movlw	0
	addwfc	SysTemp2_H,W
	movwf	SysTemp1_H
	movlw	14
	addwf	SysTemp1,W
	banksel	TT
	movwf	TT
	movlw	0
	banksel	SYSTEMP1_H
	addwfc	SysTemp1_H,W
	banksel	TT_H
	movwf	TT_H
;T_ip_pktlen1 = 40
	movlw	40
	banksel	SYSETHERBUFFER_18
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
;End If
ENDIF67
;End If
ENDIF65
;
;HTTPPart3
;If Tcp_ack = 1 Then
	banksel	SYSBITVAR0
	btfss	SYSBITVAR0,4
	goto	ENDIF66
;If etherBuffer(17) = 0 Then
	banksel	SYSETHERBUFFER_17
	movf	SYSETHERBUFFER_17,F
	btfss	STATUS, Z
	goto	ENDIF68
;HSerPrint "Buffer(17) = 0 "
;If etherBuffer(18) = 40 Then
	movlw	40
	subwf	SYSETHERBUFFER_18,W
	btfss	STATUS, Z
	goto	ENDIF69
;HSerPrint "Buffer(18) = 40 "
;If Ackpsh = 1 Then
	banksel	ACKPSH
	decf	ACKPSH,W
	btfss	STATUS, Z
	goto	ENDIF70
;HSerPrint "(3)"
;HSerPrintCRLF
;'ACK after a ACK-PSH
;dim I_x, Tempword3 as word
;dim Tempword4 As Word
;'set flags
;Tcp_flags = 0
	banksel	SYSETHERBUFFER_48
	clrf	SYSETHERBUFFER_48
;Tcp_flags.4  = 1                          'ack
	bsf	SYSETHERBUFFER_48,4
;Tcp_flags.3  = 1                          'psh
	bsf	SYSETHERBUFFER_48,3
;Tcp_flags.0  = 1                          'fin
	bsf	SYSETHERBUFFER_48,0
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
;#define SizeofTable1 0x0100
;Tempword3 = 0x37 ' pointer to TCP data for HTTP
	movlw	55
	banksel	TEMPWORD3
	movwf	TEMPWORD3
	clrf	TEMPWORD3_H
;Tempword4 = 0x37
	movlw	55
	movwf	TEMPWORD4
	clrf	TEMPWORD4_H
;HSerPrint "SizeofTable1 = "
;HSerPrint SizeofTable1
;HSerPrintCRLF 2
;dim tt, countloop as word
;HSerPrint T_ip_destaddr0
	banksel	SYSETHERBUFFER_31
	movf	SYSETHERBUFFER_31,W
	banksel	SERPRINTVAL
	movwf	SERPRINTVAL
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT253
	call	HSERPRINT253
	pagesel	$
;HSerPrint "."
	movlw	low StringTable27
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable27) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT252
	call	HSERPRINT252
	pagesel	$
;HSerPrint T_ip_destaddr1
	banksel	SYSETHERBUFFER_32
	movf	SYSETHERBUFFER_32,W
	banksel	SERPRINTVAL
	movwf	SERPRINTVAL
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT253
	call	HSERPRINT253
	pagesel	$
;HSerPrint "."
	movlw	low StringTable27
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable27) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT252
	call	HSERPRINT252
	pagesel	$
;HSerPrint T_ip_destaddr2
	banksel	SYSETHERBUFFER_33
	movf	SYSETHERBUFFER_33,W
	banksel	SERPRINTVAL
	movwf	SERPRINTVAL
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT253
	call	HSERPRINT253
	pagesel	$
;HSerPrint "."
	movlw	low StringTable27
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable27) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT252
	call	HSERPRINT252
	pagesel	$
;HSerPrint T_ip_destaddr3
	banksel	SYSETHERBUFFER_34
	movf	SYSETHERBUFFER_34,W
	banksel	SERPRINTVAL
	movwf	SERPRINTVAL
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT253
	call	HSERPRINT253
	pagesel	$
;HSerPrint ":"
	movlw	low StringTable28
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable28) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT252
	call	HSERPRINT252
	pagesel	$
;tt = Tcp_destportl + ( Tcp_destporth * 256)
	banksel	SYSETHERBUFFER_37
	movf	SYSETHERBUFFER_37,W
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
	banksel	SYSTEMP2
	movwf	SysTemp2
	movf	SysWORDTempX_H,W
	movwf	SysTemp2_H
	movf	SysTemp2,W
	banksel	SYSETHERBUFFER_38
	addwf	SYSETHERBUFFER_38,W
	banksel	TT
	movwf	TT
	movlw	0
	banksel	SYSTEMP3
	movwf	SysTemp3
	movf	SysTemp2_H,W
	addwfc	SysTemp3,W
	banksel	TT_H
	movwf	TT_H
;HSerPrint tt
	movf	TT,W
	banksel	SERPRINTVAL
	movwf	SERPRINTVAL
	banksel	TT_H
	movf	TT_H,W
	banksel	SERPRINTVAL_H
	movwf	SERPRINTVAL_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT254
	call	HSERPRINT254
	pagesel	$
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$
;HSerPrint "-------------------------------------------------------------"
;HSerPrintCRLF
;countloop = 1
;for i_x = 1 to SizeofTable1 - 1
;ReadTable firstpage1, countloop , inbyte
;countloop = countloop + 1
;etherBuffer( Tempword4 ) = inbyte
;HSerPrint chr(inbyte)
;Tempword4 = Tempword4 + 1
;if Tempword4++ = etherBufferSize  Then
;HSerSend 7
;HSerPrint "Out of Buffer"
;HSerPrintCRLF
;end if
;next
;
;dim arrayloc as long
;arrayloc = 0x0037
	movlw	55
	movwf	ARRAYLOC
	clrf	ARRAYLOC_H
	clrf	ARRAYLOC_U
	clrf	ARRAYLOC_E
;Msg_temp2="HTTP/0.9 200 OK"
	movlw	low MSG_TEMP2
	movwf	FSR1L
	movlw	high MSG_TEMP2
	movwf	FSR1H
	movlw	low StringTable29
	movwf	SysStringA
	movlw	(high StringTable29) & 127
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
;for [word]TableLoc = 1 to 15
	banksel	TABLELOC
	clrf	TABLELOC
	clrf	TABLELOC_H
SysForLoop7
	banksel	TABLELOC
	incf	TABLELOC,F
	btfsc	STATUS,Z
	incf	TABLELOC_H,F
;etherBuffer(arrayloc) = Msg_temp2(TableLoc)
	movlw	low(MSG_TEMP2)
	addwf	TABLELOC,W
	movwf	AFSR0
	movlw	high(MSG_TEMP2)
	addwfc	TABLELOC_H,W
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
;HSerSend etherBuffer(arrayloc)
;arrayloc = arrayloc +1
	banksel	ARRAYLOC
	incf	ARRAYLOC,F
	btfsc	STATUS,Z
	incf	ARRAYLOC_H,F
	btfsc	STATUS,Z
	incf	ARRAYLOC_U,F
	btfsc	STATUS,Z
	incf	ARRAYLOC_E,F
;next
	banksel	TABLELOC
	movf	TABLELOC,W
	movwf	SysWORDTempA
	movf	TABLELOC_H,W
	movwf	SysWORDTempA_H
	movlw	15
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop7
SysForLoopEnd7
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
	btfsc	STATUS,Z
	incf	ARRAYLOC_U,F
	btfsc	STATUS,Z
	incf	ARRAYLOC_E,F
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
	btfsc	STATUS,Z
	incf	ARRAYLOC_U,F
	btfsc	STATUS,Z
	incf	ARRAYLOC_E,F
;Msg_temp2="Content-Type: text/html"
	movlw	low MSG_TEMP2
	movwf	FSR1L
	movlw	high MSG_TEMP2
	movwf	FSR1H
	movlw	low StringTable30
	movwf	SysStringA
	movlw	(high StringTable30) & 127
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
;for [word]TableLoc = 1 to 23
	banksel	TABLELOC
	clrf	TABLELOC
	clrf	TABLELOC_H
SysForLoop8
	banksel	TABLELOC
	incf	TABLELOC,F
	btfsc	STATUS,Z
	incf	TABLELOC_H,F
;etherBuffer(arrayloc) = Msg_temp2(TableLoc)
	movlw	low(MSG_TEMP2)
	addwf	TABLELOC,W
	movwf	AFSR0
	movlw	high(MSG_TEMP2)
	addwfc	TABLELOC_H,W
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
;HSerSend etherBuffer(arrayloc)
;arrayloc = arrayloc +1
	banksel	ARRAYLOC
	incf	ARRAYLOC,F
	btfsc	STATUS,Z
	incf	ARRAYLOC_H,F
	btfsc	STATUS,Z
	incf	ARRAYLOC_U,F
	btfsc	STATUS,Z
	incf	ARRAYLOC_E,F
;next
	banksel	TABLELOC
	movf	TABLELOC,W
	movwf	SysWORDTempA
	movf	TABLELOC_H,W
	movwf	SysWORDTempA_H
	movlw	23
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop8
SysForLoopEnd8
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
	btfsc	STATUS,Z
	incf	ARRAYLOC_U,F
	btfsc	STATUS,Z
	incf	ARRAYLOC_E,F
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
	btfsc	STATUS,Z
	incf	ARRAYLOC_U,F
	btfsc	STATUS,Z
	incf	ARRAYLOC_E,F
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
	btfsc	STATUS,Z
	incf	ARRAYLOC_U,F
	btfsc	STATUS,Z
	incf	ARRAYLOC_E,F
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
	btfsc	STATUS,Z
	incf	ARRAYLOC_U,F
	btfsc	STATUS,Z
	incf	ARRAYLOC_E,F
;For [word]TableLoc = 1 to 549
	banksel	TABLELOC
	clrf	TABLELOC
	clrf	TABLELOC_H
SysForLoop9
	banksel	TABLELOC
	incf	TABLELOC,F
	btfsc	STATUS,Z
	incf	TABLELOC_H,F
;ReadTable firstpage1, [word]TableLoc, etherBuffer([word]arrayloc)
	movlw	low(ETHERBUFFER)
	banksel	ARRAYLOC
	addwf	ARRAYLOC,W
	movwf	AFSR0
	movlw	high(ETHERBUFFER)
	addwfc	ARRAYLOC_H,W
	movwf	AFSR0_H
	banksel	TABLELOC
	movf	TABLELOC,W
	movwf	SYSSTRINGA
	movf	TABLELOC_H,W
	movwf	SYSSTRINGA_H
	banksel	STATUS
	call	FIRSTPAGE1
	movwf	INDF0
;HSerSend etherBuffer(arrayloc)
	movlw	low(ETHERBUFFER)
	addwf	ARRAYLOC,W
	movwf	AFSR0
	movlw	high(ETHERBUFFER)
	addwfc	ARRAYLOC_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SERDATA
	movwf	SERDATA
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERSEND
	call	HSERSEND
	pagesel	$
;arrayloc = arrayloc +1
	incf	ARRAYLOC,F
	btfsc	STATUS,Z
	incf	ARRAYLOC_H,F
	btfsc	STATUS,Z
	incf	ARRAYLOC_U,F
	btfsc	STATUS,Z
	incf	ARRAYLOC_E,F
;Next
	banksel	TABLELOC
	movf	TABLELOC,W
	movwf	SysWORDTempA
	movf	TABLELOC_H,W
	movwf	SysWORDTempA_H
	movlw	37
	movwf	SysWORDTempB
	movlw	2
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop9
SysForLoopEnd9
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
	btfsc	STATUS,Z
	incf	ARRAYLOC_U,F
	btfsc	STATUS,Z
	incf	ARRAYLOC_E,F
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
	btfsc	STATUS,Z
	incf	ARRAYLOC_U,F
	btfsc	STATUS,Z
	incf	ARRAYLOC_E,F
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
	btfsc	STATUS,Z
	incf	ARRAYLOC_U,F
	btfsc	STATUS,Z
	incf	ARRAYLOC_E,F
;etherBuffer(arrayloc) = 0x0a
	movlw	low(ETHERBUFFER)
	addwf	ARRAYLOC,W
	movwf	AFSR0
	movlw	high(ETHERBUFFER)
	addwfc	ARRAYLOC_H,W
	movwf	AFSR0_H
	movlw	10
	movwf	INDF0
;dim TCPresult16 as word
;TCPresult16 = 40 + arrayloc
	movlw	40
	addwf	ARRAYLOC,W
	banksel	TCPRESULT16
	movwf	TCPRESULT16
	movlw	0
	banksel	ARRAYLOC_H
	addwfc	ARRAYLOC_H,W
	banksel	TCPRESULT16_H
	movwf	TCPRESULT16_H
;HSerPrint "TCP Packet = "
;HSerPrint TCPresult16
;HSerPrintCRLF
;HSerPrintCRLF
;HSerPrint "-------------------------------------------------------------"
;HSerPrintCRLF 2
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
	pagesel	ENC28J60_IP_HEADER_CHECKSUM
	call	ENC28J60_IP_HEADER_CHECKSUM
;ENC28j60_tcp_checksum
	pagesel	ENC28J60_TCP_CHECKSUM
	call	ENC28J60_TCP_CHECKSUM
	pagesel	$
;if showt = 0 then
;HSerPrintCRLF
;For I_x = 0x37 To 0x37+TCPresult16
;HSerPrint chr(etherbuffer(I_x))
;Next
;HSerPrintCRLF
;showt=1
;end if
;ENC28j60_writebuffer( TCPresult16 + 14   )
	movlw	14
	banksel	TCPRESULT16
	addwf	TCPRESULT16,W
	movwf	PCKTLEN
	movlw	0
	banksel	TCPRESULT16_H
	addwfc	TCPRESULT16_H,W
	banksel	PCKTLEN_H
	movwf	PCKTLEN_H
	banksel	STATUS
	pagesel	ENC28J60_WRITEBUFFER
	call	ENC28J60_WRITEBUFFER
	pagesel	$
;ENC28j60_packetsend( TCPresult16 + 14   )
	movlw	14
	banksel	TCPRESULT16
	addwf	TCPRESULT16,W
	movwf	PCKTLEN
	movlw	0
	banksel	TCPRESULT16_H
	addwfc	TCPRESULT16_H,W
	banksel	PCKTLEN_H
	movwf	PCKTLEN_H
	banksel	STATUS
	pagesel	ENC28J60_PACKETSEND
	call	ENC28J60_PACKETSEND
	pagesel	$
;End If
ENDIF70
;End If
ENDIF69
;End If
ENDIF68
;Ackpsh = 0
	banksel	ACKPSH
	clrf	ACKPSH
;End If
ENDIF66
	banksel	STATUS
	return

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
	movlw	low IPSERVER
	movwf	FSR0L
	movlw	high IPSERVER
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
;ipport = 80   'set a default value
	movlw	80
	movwf	IPPORT
;Ip_id = 0
	clrf	IP_ID
	clrf	IP_ID_H
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
SysWaitLoop12
	btfss	SSP1STAT,BF
	goto	SysWaitLoop12
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
	movlw	244
	movwf	SysWORDTempA
	movlw	1
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
SysWaitLoop13
	btfss	SSP1STAT,BF
	goto	SysWaitLoop13
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
	movlw	244
	movwf	SysWORDTempA
	movlw	1
	movwf	SysWORDTempA_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF52
;for eth_counter = etherBufferSize+1 to etherGetLength
	movlw	244
	movwf	ETH_COUNTER
	movlw	1
	movwf	ETH_COUNTER_H
	movlw	245
	movwf	SysWORDTempB
	movlw	1
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
SysWaitLoop14
	btfss	SSP1STAT,BF
	goto	SysWaitLoop14
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
ENDIF52
;ENC28j60_Deselect
	bsf	LATB,2
	return

;********************************************************************************

FIRSTPAGE1
	movf	SYSSTRINGA,W
	movwf	SysWORDTempA
	movf	SYSSTRINGA_H,W
	movwf	SysWORDTempA_H
	movlw	38
	movwf	SysWORDTempB
	movlw	2
	movwf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	retlw	0
	movf	SysStringA, W
	addlw	low TableFIRSTPAGE1
	movwf	SysStringA
	movlw	(high TableFIRSTPAGE1) & 127
	btfsc	STATUS, C
	addlw	1
	addwf	SysStringA_H, W
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableFIRSTPAGE1
	retlw	37
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
	retlw	71
	retlw	67
	retlw	66
	retlw	32
	retlw	84
	retlw	67
	retlw	80
	retlw	73
	retlw	80
	retlw	60
	retlw	47
	retlw	116
	retlw	105
	retlw	116
	retlw	108
	retlw	101
	retlw	62
	retlw	13
	retlw	10
	retlw	60
	retlw	47
	retlw	104
	retlw	101
	retlw	97
	retlw	100
	retlw	62
	retlw	13
	retlw	10
	retlw	60
	retlw	98
	retlw	111
	retlw	100
	retlw	121
	retlw	62
	retlw	13
	retlw	10
	retlw	60
	retlw	102
	retlw	111
	retlw	110
	retlw	116
	retlw	32
	retlw	102
	retlw	97
	retlw	99
	retlw	101
	retlw	61
	retlw	104
	retlw	101
	retlw	108
	retlw	118
	retlw	101
	retlw	116
	retlw	105
	retlw	99
	retlw	97
	retlw	62
	retlw	13
	retlw	10
	retlw	60
	retlw	99
	retlw	101
	retlw	110
	retlw	116
	retlw	101
	retlw	114
	retlw	62
	retlw	60
	retlw	66
	retlw	62
	retlw	60
	retlw	85
	retlw	62
	retlw	60
	retlw	70
	retlw	79
	retlw	78
	retlw	84
	retlw	32
	retlw	83
	retlw	73
	retlw	90
	retlw	69
	retlw	61
	retlw	53
	retlw	32
	retlw	67
	retlw	79
	retlw	76
	retlw	79
	retlw	82
	retlw	61
	retlw	34
	retlw	35
	retlw	48
	retlw	48
	retlw	48
	retlw	48
	retlw	102
	retlw	102
	retlw	34
	retlw	62
	retlw	60
	retlw	80
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
	retlw	80
	retlw	62
	retlw	60
	retlw	47
	retlw	66
	retlw	62
	retlw	60
	retlw	47
	retlw	85
	retlw	62
	retlw	60
	retlw	47
	retlw	70
	retlw	79
	retlw	78
	retlw	84
	retlw	62
	retlw	60
	retlw	47
	retlw	99
	retlw	101
	retlw	110
	retlw	116
	retlw	101
	retlw	114
	retlw	62
	retlw	13
	retlw	10
	retlw	60
	retlw	98
	retlw	114
	retlw	62
	retlw	60
	retlw	98
	retlw	114
	retlw	62
	retlw	13
	retlw	10
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
	retlw	32
	retlw	117
	retlw	115
	retlw	105
	retlw	110
	retlw	103
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
	retlw	84
	retlw	67
	retlw	80
	retlw	47
	retlw	73
	retlw	80
	retlw	32
	retlw	115
	retlw	116
	retlw	97
	retlw	99
	retlw	107
	retlw	46
	retlw	13
	retlw	10
	retlw	60
	retlw	98
	retlw	114
	retlw	62
	retlw	60
	retlw	98
	retlw	114
	retlw	62
	retlw	13
	retlw	10
	retlw	67
	retlw	111
	retlw	110
	retlw	116
	retlw	114
	retlw	111
	retlw	108
	retlw	32
	retlw	38
	retlw	32
	retlw	105
	retlw	110
	retlw	116
	retlw	101
	retlw	114
	retlw	102
	retlw	97
	retlw	99
	retlw	101
	retlw	32
	retlw	121
	retlw	111
	retlw	117
	retlw	114
	retlw	32
	retlw	71
	retlw	67
	retlw	66
	retlw	32
	retlw	115
	retlw	111
	retlw	108
	retlw	117
	retlw	116
	retlw	105
	retlw	111
	retlw	110
	retlw	115
	retlw	32
	retlw	118
	retlw	105
	retlw	97
	retlw	32
	retlw	116
	retlw	104
	retlw	101
	retlw	32
	retlw	119
	retlw	101
	retlw	98
	retlw	46
	retlw	13
	retlw	10
	retlw	60
	retlw	98
	retlw	114
	retlw	62
	retlw	60
	retlw	98
	retlw	114
	retlw	62
	retlw	13
	retlw	10
	retlw	60
	retlw	97
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
	retlw	115
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
	retlw	50
	retlw	74
	retlw	74
	retlw	77
	retlw	70
	retlw	84
	retlw	34
	retlw	62
	retlw	74
	retlw	111
	retlw	105
	retlw	110
	retlw	32
	retlw	116
	retlw	104
	retlw	101
	retlw	32
	retlw	71
	retlw	67
	retlw	66
	retlw	32
	retlw	66
	retlw	101
	retlw	116
	retlw	97
	retlw	32
	retlw	112
	retlw	114
	retlw	111
	retlw	103
	retlw	114
	retlw	97
	retlw	109
	retlw	60
	retlw	47
	retlw	97
	retlw	62
	retlw	46
	retlw	13
	retlw	10
	retlw	60
	retlw	98
	retlw	114
	retlw	62
	retlw	60
	retlw	98
	retlw	114
	retlw	62
	retlw	13
	retlw	10
	retlw	60
	retlw	105
	retlw	109
	retlw	103
	retlw	32
	retlw	115
	retlw	116
	retlw	121
	retlw	108
	retlw	101
	retlw	61
	retlw	34
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
	retlw	62
	retlw	13
	retlw	10
	retlw	60
	retlw	98
	retlw	114
	retlw	62
	retlw	13
	retlw	10
	retlw	60
	retlw	98
	retlw	114
	retlw	62
	retlw	13
	retlw	10
	retlw	60
	retlw	102
	retlw	111
	retlw	110
	retlw	116
	retlw	32
	retlw	115
	retlw	105
	retlw	122
	retlw	101
	retlw	61
	retlw	34
	retlw	49
	retlw	34
	retlw	62
	retlw	64
	retlw	114
	retlw	101
	retlw	108
	retlw	101
	retlw	97
	retlw	115
	retlw	101
	retlw	32
	retlw	48
	retlw	50
	retlw	54
	retlw	46
	retlw	48
	retlw	99
	retlw	60
	retlw	98
	retlw	114
	retlw	62
	retlw	60
	retlw	47
	retlw	102
	retlw	111
	retlw	110
	retlw	116
	retlw	62
	retlw	13
	retlw	10
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
	retlw	13
	retlw	10

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

INITUSART
;comport = 1
	movlw	1
	movwf	COMPORT
;SPBRG = SPBRGL_TEMP
	movlw	64
	banksel	SPBRG
	movwf	SPBRG
;SPBRGH = SPBRGH_TEMP
	movlw	3
	movwf	SPBRGH
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

;Start of program memory page 1
	ORG	2048
ENC28J60_CALCCHECKSUM
;Dim II As Word
;Dim LocalTmp As Word
;Dim Sum As Long
;Sum = 0
	banksel	SUM
	clrf	SUM
	clrf	SUM_H
	clrf	SUM_U
	clrf	SUM_E
;LocalTmp = 0
	clrf	LOCALTMP
	clrf	LOCALTMP_H
;I_odd = (Endptr - startptr ) Mod 2
	movf	STARTPTR,W
	banksel	ENDPTR
	subwf	ENDPTR,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movf	STARTPTR_H,W
	banksel	ENDPTR_H
	subwfb	ENDPTR_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	movf	SysTemp1,W
	movwf	SysWORDTempA
	movf	SysTemp1_H,W
	movwf	SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	call	SysDivSub16
	movf	SysWORDTempX,W
	banksel	I_ODD
	movwf	I_ODD
;if I_odd = 1 then HSerPrint "!"
	decf	I_ODD,W
	btfss	STATUS, Z
	goto	ENDIF61
	movlw	low StringTable18
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable18) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT252
	call	HSERPRINT252
	pagesel	$
ENDIF61
;For II = Startptr To Endptr Step 2
	movlw	2
	banksel	STARTPTR
	subwf	STARTPTR,W
	banksel	II
	movwf	II
	movlw	0
	banksel	STARTPTR_H
	subwfb	STARTPTR_H,W
	banksel	II_H
	movwf	II_H
	banksel	STARTPTR
	movf	STARTPTR,W
	movwf	SysWORDTempB
	movf	STARTPTR_H,W
	movwf	SysWORDTempB_H
	banksel	ENDPTR
	movf	ENDPTR,W
	movwf	SysWORDTempA
	movf	ENDPTR_H,W
	movwf	SysWORDTempA_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd6
SysForLoop6
	movlw	2
	addwf	II,F
	movlw	0
	addwfc	II_H,F
;Sum = Sum + etherBuffer(II + 1)
	movlw	low(ETHERBUFFER)
	addwf	II,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(ETHERBUFFER)
	banksel	II_H
	addwfc	II_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	movlw	1
	addwf	SysTemp1,W
	movwf	AFSR0
	movlw	0
	addwfc	SysTemp1_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	addwf	SUM,F
	movlw	0
	addwfc	SUM_H,F
	movlw	0
	addwfc	SUM_U,F
	movlw	0
	addwfc	SUM_E,F
;LocalTmp_h  = etherBuffer(II)
	movlw	low(ETHERBUFFER)
	banksel	II
	addwf	II,W
	movwf	AFSR0
	movlw	high(ETHERBUFFER)
	addwfc	II_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	LOCALTMP_H
	movwf	LOCALTMP_H
;Sum = Sum + LocalTmp
	movf	LOCALTMP,W
	addwf	SUM,F
	movf	LOCALTMP_H,W
	addwfc	SUM_H,F
	movlw	0
	addwfc	SUM_U,F
	movlw	0
	addwfc	SUM_E,F
;Next I
	banksel	II
	movf	II,W
	movwf	SysWORDTempA
	movf	II_H,W
	movwf	SysWORDTempA_H
	movf	ENDPTR,W
	movwf	SysWORDTempB
	movf	ENDPTR_H,W
	movwf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop6
SysForLoopEnd6
;II = FnLsr( sum, 16 )
	banksel	SUM
	movf	SUM,W
	movwf	SYSLONGTEMPB
	movf	SUM_H,W
	movwf	SYSLONGTEMPB_H
	movf	SUM_U,W
	movwf	SYSLONGTEMPB_U
	movf	SUM_E,W
	movwf	SYSLONGTEMPB_E
	movlw	16
	movwf	NUMBITS
	banksel	STATUS
	pagesel	FN_FNLSR
	call	FN_FNLSR
	pagesel	$
	movf	FNLSR,W
	movwf	II
	movf	FNLSR_H,W
	movwf	II_H
;LocalTmp  = [word]Sum
	banksel	SUM
	movf	SUM,W
	movwf	LOCALTMP
	movf	SUM_H,W
	movwf	LOCALTMP_H
;LocalTmp  = LocalTmp  + II
	banksel	II
	movf	II,W
	banksel	LOCALTMP
	addwf	LOCALTMP,F
	banksel	II_H
	movf	II_H,W
	banksel	LOCALTMP_H
	addwfc	LOCALTMP_H,F
;LocalTmp  = Not LocalTmp
	comf	LOCALTMP,F
	comf	LOCALTMP_H,F
;etherBuffer(result) = LocalTmp_h
	movlw	low(ETHERBUFFER)
	addwf	RESULT,W
	movwf	AFSR0
	movlw	high(ETHERBUFFER)
	addwfc	RESULT_H,W
	movwf	AFSR0_H
	movf	LOCALTMP_H,W
	movwf	INDF0
;etherBuffer(result + 1) = [byte]LocalTmp
	movlw	low(ETHERBUFFER)
	addwf	RESULT,W
	movwf	SysTemp1
	movlw	high(ETHERBUFFER)
	addwfc	RESULT_H,W
	movwf	SysTemp1_H
	movlw	1
	addwf	SysTemp1,W
	movwf	AFSR0
	movlw	0
	addwfc	SysTemp1_H,W
	movwf	AFSR0_H
	movf	LOCALTMP,W
	movwf	INDF0
	banksel	STATUS
	return

;********************************************************************************

ENC28J60_GENERAL_CHECKSUM
;dim I_x as word
;dim I_chksum32 as long
;X_odd = (Val2 - Val1 ) Mod 2
	banksel	VAL1
	movf	VAL1,W
	subwf	VAL2,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	0
	banksel	VAL2_H
	subwfb	VAL2_H,W
	banksel	SYSTEMP2_H
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
	banksel	I_CHKSUM32
	clrf	I_CHKSUM32
	clrf	I_CHKSUM32_H
	clrf	I_CHKSUM32_U
	clrf	I_CHKSUM32_E
;For I_x = Val1 To Val2 Step 2
	movlw	2
	banksel	VAL1
	subwf	VAL1,W
	banksel	I_X
	movwf	I_X
	clrf	I_X_H
	btfss	STATUS,C
	decf	I_X_H,F
	banksel	VAL1
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
	goto	SysForLoopEnd11
SysForLoop11
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
	addwfc	I_CHKSUM32_U,F
	movlw	0
	addwfc	I_CHKSUM32_E,F
;Next I_x
	movf	I_X,W
	movwf	SysWORDTempA
	movf	I_X_H,W
	movwf	SysWORDTempA_H
	banksel	VAL2
	movf	VAL2,W
	movwf	SysWORDTempB
	movf	VAL2_H,W
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop11
SysForLoopEnd11
;If I_odd = 1 Then
	banksel	I_ODD
	decf	I_ODD,W
	btfss	STATUS, Z
	goto	ENDIF94
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
	banksel	NUMBITS
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
	addwfc	I_CHKSUM32_U,F
	movlw	0
	addwfc	I_CHKSUM32_E,F
;End If
ENDIF94
;I_checksum16 = Fnlsr(i_chksum32, 16)
	movf	I_CHKSUM32,W
	movwf	SYSLONGTEMPB
	movf	I_CHKSUM32_H,W
	movwf	SYSLONGTEMPB_H
	movf	I_CHKSUM32_U,W
	movwf	SYSLONGTEMPB_U
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
	pagesel	SPIMODE208
	call	SPIMODE208
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
;ENC28j60_writeReg(ERXFCON, 0xA1) 'Receive unicasts or broadcasts
	movlw	56
	banksel	ADDR
	movwf	ADDR
	movlw	161
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
	goto	ENDIF24
;#ifdef ENC28j60_Hserial_Supported
;todo erv
;HSerPrint "No packet"
;reset
	reset
;#endif
;ENC28j60_bitSet( ECON2, ECON2_PKTDEC )
;goto Reset_ENC26j60
	goto	RESET_ENC26J60
;Exit Sub
	return
;End If
ENDIF24
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
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
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
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF26
;HSerPrint "#2ERDPTL and ERDPTH error"
	movlw	low StringTable31
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable31) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT252
	call	HSERPRINT252
	pagesel	$
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$
;exit do
	goto	SysDoLoop_E4
;end if
ENDIF26
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
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF27
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
ENDIF27
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
;If etherBuffer(13) = 0X08 Then
	movlw	8
	banksel	SYSETHERBUFFER_13
	subwf	SYSETHERBUFFER_13,W
	btfss	STATUS, Z
	goto	ENDIF28
;If etherBuffer(14) = 0X06 Then                             'Type:ARP
	movlw	6
	subwf	SYSETHERBUFFER_14,W
	btfss	STATUS, Z
	goto	ENDIF29
;If etherBuffer(21) = 0X00 Then                          'ARP request
	movf	SYSETHERBUFFER_21,F
	btfss	STATUS, Z
	goto	ENDIF31
;If etherBuffer(22) = 0X01 Then                       'ARP request
	decf	SYSETHERBUFFER_22,W
	btfss	STATUS, Z
	goto	ENDIF33
;If etherBuffer(39) = ipaddr(1) Then                  'ARP for us
	banksel	SYSIPADDR_1
	movf	SYSIPADDR_1,W
	banksel	SYSETHERBUFFER_39
	subwf	SYSETHERBUFFER_39,W
	btfss	STATUS, Z
	goto	ENDIF35
;If etherBuffer(40) = ipaddr(2) Then
	banksel	SYSIPADDR_2
	movf	SYSIPADDR_2,W
	banksel	SYSETHERBUFFER_40
	subwf	SYSETHERBUFFER_40,W
	btfss	STATUS, Z
	goto	ENDIF37
;If etherBuffer(41) = ipaddr(3) Then
	banksel	SYSIPADDR_3
	movf	SYSIPADDR_3,W
	banksel	SYSETHERBUFFER_41
	subwf	SYSETHERBUFFER_41,W
	btfss	STATUS, Z
	goto	ENDIF39
;If etherBuffer(42) = ipaddr(4) Then
	banksel	SYSIPADDR_4
	movf	SYSIPADDR_4,W
	banksel	SYSETHERBUFFER_42
	subwf	SYSETHERBUFFER_42,W
	btfss	STATUS, Z
	goto	ENDIF41
;ENC28j60_Arpreply
	banksel	STATUS
	pagesel	ENC28J60_ARPREPLY
	call	ENC28J60_ARPREPLY
	pagesel	$
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
;If etherBuffer(14) = 0X00 Then                             'Type:IP
	banksel	SYSETHERBUFFER_14
	movf	SYSETHERBUFFER_14,F
	btfss	STATUS, Z
	goto	ENDIF30
;If etherBuffer(15) = 0X45 Then                          'We handle only simple IP packets
	movlw	69
	subwf	SYSETHERBUFFER_15,W
	btfss	STATUS, Z
	goto	ENDIF32
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
	goto	ENDIF34
;If etherBuffer(31) = ipaddr(1) Then                  'Ip packet for us
	banksel	SYSIPADDR_1
	movf	SYSIPADDR_1,W
	banksel	SYSETHERBUFFER_31
	subwf	SYSETHERBUFFER_31,W
	btfss	STATUS, Z
	goto	ENDIF36
;If etherBuffer(32) = ipaddr(2) Then
	banksel	SYSIPADDR_2
	movf	SYSIPADDR_2,W
	banksel	SYSETHERBUFFER_32
	subwf	SYSETHERBUFFER_32,W
	btfss	STATUS, Z
	goto	ENDIF38
;If etherBuffer(33) = ipaddr(3) Then
	banksel	SYSIPADDR_3
	movf	SYSIPADDR_3,W
	banksel	SYSETHERBUFFER_33
	subwf	SYSETHERBUFFER_33,W
	btfss	STATUS, Z
	goto	ENDIF40
;If etherBuffer(34) = ipaddr(4) Then
	banksel	SYSIPADDR_4
	movf	SYSIPADDR_4,W
	banksel	SYSETHERBUFFER_34
	subwf	SYSETHERBUFFER_34,W
	btfss	STATUS, Z
	goto	ENDIF42
;If etherBuffer(24) = 1 Then              'Protocol:ICMP
	decf	SYSETHERBUFFER_24,W
	btfss	STATUS, Z
	goto	ENDIF43
;If etherBuffer(35) = 0X08 Then        'ICMP echo request
	movlw	8
	subwf	SYSETHERBUFFER_35,W
	btfss	STATUS, Z
	goto	ENDIF46
;PORTA.0 = 1
	banksel	LATA
	bsf	LATA,0
;ENC28j60_Pingreply
	pagesel	ENC28J60_PINGREPLY
	call	ENC28J60_PINGREPLY
	pagesel	$
;PORTA.0 = 0
	bcf	LATA,0
;End If
ENDIF46
;End If
ENDIF43
;If etherBuffer(24) = 17 Then             'Protocol:UDP
	movlw	17
	banksel	SYSETHERBUFFER_24
	subwf	SYSETHERBUFFER_24,W
	btfss	STATUS, Z
	goto	ENDIF44
;T_udp_destport = ( T_udp_destport0 * 256 ) + T_udp_destport1
	movf	SYSETHERBUFFER_37,W
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
	banksel	SYSETHERBUFFER_38
	movf	SYSETHERBUFFER_38,W
	banksel	SYSTEMP1
	addwf	SysTemp1,W
	banksel	T_UDP_DESTPORT
	movwf	T_UDP_DESTPORT
	movlw	0
	banksel	SYSTEMP1_H
	addwfc	SysTemp1_H,W
	banksel	T_UDP_DESTPORT_H
	movwf	T_UDP_DESTPORT_H
;ENC28j60_Handle_Udp
	banksel	STATUS
	pagesel	ENC28J60_HANDLE_UDP
	call	ENC28J60_HANDLE_UDP
	pagesel	$
;if T_udp_destport = 7 then
	banksel	T_UDP_DESTPORT
	movf	T_UDP_DESTPORT,W
	movwf	SysWORDTempA
	movf	T_UDP_DESTPORT_H,W
	movwf	SysWORDTempA_H
	movlw	7
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF47
;ENC28j60_Setipaddrs
	pagesel	ENC28J60_SETIPADDRS
	call	ENC28J60_SETIPADDRS
	pagesel	$
;Swap T_udp_srcport0 , T_udp_destport0
	banksel	SYSETHERBUFFER_35
	movf	SYSETHERBUFFER_35,W
	movwf	SYSCALCTEMPA
	movf	SYSETHERBUFFER_37,W
	movwf	SYSCALCTEMPB
	banksel	STATUS
	pagesel	SWAP91
	call	SWAP91
	pagesel	$
	movf	SYSCALCTEMPA,W
	banksel	SYSETHERBUFFER_35
	movwf	SYSETHERBUFFER_35
	movf	SYSCALCTEMPB,W
	movwf	SYSETHERBUFFER_37
;Swap T_udp_srcport1 , T_udp_destport1
	movf	SYSETHERBUFFER_36,W
	movwf	SYSCALCTEMPA
	movf	SYSETHERBUFFER_38,W
	movwf	SYSCALCTEMPB
	banksel	STATUS
	pagesel	SWAP91
	call	SWAP91
	pagesel	$
	movf	SYSCALCTEMPA,W
	banksel	SYSETHERBUFFER_36
	movwf	SYSETHERBUFFER_36
	movf	SYSCALCTEMPB,W
	movwf	SYSETHERBUFFER_38
;ENC28j60_Udp_checksum
	banksel	STATUS
	pagesel	ENC28J60_UDP_CHECKSUM
	call	ENC28J60_UDP_CHECKSUM
	pagesel	$
;Hulp2 = T_udp_len0 * 256
	banksel	SYSETHERBUFFER_39
	movf	SYSETHERBUFFER_39,W
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
	movwf	HULP2
	movf	SysWORDTempX_H,W
	movwf	HULP2_H
;Hulp2 = Hulp2 + T_udp_len1
	banksel	SYSETHERBUFFER_40
	movf	SYSETHERBUFFER_40,W
	banksel	HULP2
	addwf	HULP2,F
	movlw	0
	addwfc	HULP2_H,F
;Hulp2 = Hulp2 + 34
	movlw	34
	addwf	HULP2,F
	movlw	0
	addwfc	HULP2_H,F
;ENC28j60_writebuffer( hulp2 )
	movf	HULP2,W
	banksel	PCKTLEN
	movwf	PCKTLEN
	banksel	HULP2_H
	movf	HULP2_H,W
	banksel	PCKTLEN_H
	movwf	PCKTLEN_H
	banksel	STATUS
	pagesel	ENC28J60_WRITEBUFFER
	call	ENC28J60_WRITEBUFFER
	pagesel	$
;ENC28j60_packetsend( hulp2 )
	movf	HULP2,W
	banksel	PCKTLEN
	movwf	PCKTLEN
	banksel	HULP2_H
	movf	HULP2_H,W
	banksel	PCKTLEN_H
	movwf	PCKTLEN_H
	banksel	STATUS
	pagesel	ENC28J60_PACKETSEND
	call	ENC28J60_PACKETSEND
	pagesel	$
;end if
ENDIF47
;End If
ENDIF44
;If etherBuffer(24) = 6 Then              'Protocol:TCP
	movlw	6
	banksel	SYSETHERBUFFER_24
	subwf	SYSETHERBUFFER_24,W
	btfss	STATUS, Z
	goto	ENDIF45
;If Tcp_destporth = 0 Then
	movf	SYSETHERBUFFER_37,F
	btfss	STATUS, Z
	goto	ENDIF48
;Select Case Tcp_destportl
;Case 80 : ENC28j60_http
SysSelect3Case1
	movlw	80
	subwf	SYSETHERBUFFER_38,W
	btfss	STATUS, Z
	goto	SysSelect3Case2
	banksel	STATUS
	pagesel	ENC28J60_HTTP
	call	ENC28J60_HTTP
	pagesel	$
;End Select
SysSelect3Case2
SysSelectEnd3
;End If
ENDIF48
;End If
ENDIF45
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
;End If
ENDIF30
;End If
ENDIF28
	banksel	STATUS
	return

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
	clrf	I_CHKSUM32_U
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
	movf	I_CHKSUM32_U,W
	addwfc	SysTemp3,W
	movwf	I_CHKSUM32_U
	clrf	SysTemp1
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
	movf	I_CHKSUM32_U,W
	addwfc	SysTemp3,W
	movwf	I_CHKSUM32_U
	clrf	SysTemp1
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
	movf	I_CHKSUM32_U,W
	addwfc	SysTemp3,W
	movwf	I_CHKSUM32_U
	clrf	SysTemp1
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
	movf	I_CHKSUM32_U,W
	addwfc	SysTemp3,W
	movwf	I_CHKSUM32_U
	clrf	SysTemp1
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
	addwfc	I_CHKSUM32_U,F
	movlw	0
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
	subwfb	I_CHKSUM32_U,F
	movlw	0
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
	movf	I_CHKSUM32_U,W
	addwfc	SysTemp3,W
	movwf	I_CHKSUM32_U
	clrf	SysTemp1
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
	call	SysDivSub16
	movf	SysWORDTempX,W
	banksel	I_ODD
	movwf	I_ODD
;Hulp2 = 0x23 + I_value16 - 22 'should be 20 bytes (for the IP Header ) be two bytes less for gcb For-next loop
	movlw	35
	banksel	I_VALUE16
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
	banksel	I_ODD
	clrf	I_ODD
	banksel	SYSETHERBUFFER_40
	btfss	SYSETHERBUFFER_40,0
	goto	ENDIF83
	banksel	I_ODD
	incf	I_ODD,F
ENDIF83
;If I_odd = 1 Then
	banksel	I_ODD
	decf	I_ODD,W
	btfss	STATUS, Z
	goto	ENDIF80
;Hulp2 =  Hulp2 + 1
	banksel	HULP2
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
ENDIF80
;For I_x = 0x23 To Hulp2 Step 2
	movlw	33
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
	goto	SysForLoopEnd10
SysForLoop10
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
	movf	I_CHKSUM32_U,W
	addwfc	SysTemp3,W
	movwf	I_CHKSUM32_U
	clrf	SysTemp1
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
	goto	SysForLoop10
SysForLoopEnd10
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
	banksel	I_CHKSUM32_U
	movf	I_CHKSUM32_U,W
	banksel	I_CHECKSUM16
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

FIRSTPAGE1_H
	movf	SYSSTRINGA,W
	movwf	SysWORDTempA
	movf	SYSSTRINGA_H,W
	movwf	SysWORDTempA_H
	movlw	228
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	retlw	0
	movf	SysStringA, W
	addlw	low TableFIRSTPAGE1_H
	movwf	SysStringA
	movlw	(high TableFIRSTPAGE1_H) & 127
	btfsc	STATUS, C
	addlw	1
	addwf	SysStringA_H, W
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableFIRSTPAGE1_H
	retlw	2
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
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
	goto	ENDIF84
;SysWordTempA = 0
	clrf	SYSWORDTEMPA
	clrf	SYSWORDTEMPA_H
;exit sub
	return
;end if
ENDIF84
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
	goto	ENDIF85
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	addwfc	SYSDIVMULTX_H,F
;End If
ENDIF85
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

;Start of program memory page 2
	ORG	4096
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
	banksel	SYSREPEATTEMP3
	movwf	SysRepeatTemp3
SysRepeatLoop3
;set c off
	bcf	STATUS,C
;rotate banktobeselected right
	banksel	BANKTOBESELECTED
	rrf	BANKTOBESELECTED,F
;end repeat
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
	goto	ELSE9_1
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
	call	SysCompLessThan
	comf	SysByteTempX,F
	btfsc	SysByteTempX,0
;ENC28j60_selectBank ( banktobeselected, addr )
	call	ENC28J60_SELECTBANK
;end if
;Else
	goto	ENDIF9
ELSE9_1
;lastselectedBank = banktobeselected
	banksel	BANKTOBESELECTED
	movf	BANKTOBESELECTED,W
	banksel	LASTSELECTEDBANK
	movwf	LASTSELECTEDBANK
;end if
ENDIF9
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
	call	FASTHWSPITRANSFER
;FastHWSPITransfer( ENC_Outbyte, temp )
	movf	ENC_OUTBYTE,W
	banksel	SPITXDATA
	movwf	SPITXDATA
	banksel	STATUS
	call	FASTHWSPITRANSFER
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
;HSerPrintByteCRLF banktobeselected
;HSerPrintCRLF
;if lastselectedBank <> banktobeselected then
	banksel	BANKTOBESELECTED
	movf	BANKTOBESELECTED,W
	banksel	LASTSELECTEDBANK
	subwf	LASTSELECTEDBANK,W
	btfsc	STATUS, Z
	goto	ELSE7_1
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
	call	SysCompLessThan
	comf	SysByteTempX,F
	btfsc	SysByteTempX,0
;ENC28j60_selectBank ( banktobeselected, addr )
	call	ENC28J60_SELECTBANK
;end if
;Else
	goto	ENDIF7
ELSE7_1
;lastselectedBank = banktobeselected
	banksel	BANKTOBESELECTED
	movf	BANKTOBESELECTED,W
	banksel	LASTSELECTEDBANK
	movwf	LASTSELECTEDBANK
;end if
ENDIF7
;ENC28j60_Select
	banksel	LATB
	bcf	LATB,2
;FastHWSPITransfer( ENC28j60_BIT_FIELD_SET | (addr AND ADDR_MASK ), temp )
	movlw	31
	andwf	ADDR,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	128
	iorwf	SysTemp1,W
	movwf	SPITXDATA
	banksel	STATUS
	call	FASTHWSPITRANSFER
;FastHWSPITransfer( ENC_Outbyte, temp )
	movf	ENC_OUTBYTE,W
	banksel	SPITXDATA
	movwf	SPITXDATA
	banksel	STATUS
	call	FASTHWSPITRANSFER
;ENC28j60_Deselect
	bsf	LATB,2
	return

;********************************************************************************

ENC28J60_HANDLE_UDP
;Uncomment to show UDP packet data
;select case T_udp_destport
;case 6000
SysSelect4Case1
	banksel	T_UDP_DESTPORT
	movf	T_UDP_DESTPORT,W
	movwf	SysWORDTempA
	movf	T_UDP_DESTPORT_H,W
	movwf	SysWORDTempA_H
	movlw	112
	movwf	SysWORDTempB
	movlw	23
	movwf	SysWORDTempB_H
	banksel	STATUS
	call	SysCompEqual16
	btfss	SysByteTempX,0
	goto	SysSelect4Case2
;case 5000
	goto	SysSelectEnd4
SysSelect4Case2
	banksel	T_UDP_DESTPORT
	movf	T_UDP_DESTPORT,W
	movwf	SysWORDTempA
	movf	T_UDP_DESTPORT_H,W
	movwf	SysWORDTempA_H
	movlw	136
	movwf	SysWORDTempB
	movlw	19
	movwf	SysWORDTempB_H
	banksel	STATUS
	call	SysCompEqual16
	btfss	SysByteTempX,0
	goto	SysSelect4Case3
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
	clrf	I_ODD
;Val1 = 15
	movlw	15
	banksel	VAL1
	movwf	VAL1
;Val2 = 0x0E + Ip_header_length - 1
	movlw	14
	banksel	IP_HEADER_LENGTH
	addwf	IP_HEADER_LENGTH,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	movlw	1
	subwf	SysTemp3,W
	banksel	VAL2
	movwf	VAL2
	clrf	VAL2_H
	btfss	STATUS,C
	decf	VAL2_H,F
;T_ip_hdr_cksum0 = 0
	banksel	SYSETHERBUFFER_25
	clrf	SYSETHERBUFFER_25
;T_ip_hdr_cksum1 = 0
	clrf	SYSETHERBUFFER_26
;ENC28j60_General_checksum(val1 , Val2)
	banksel	STATUS
	pagesel	ENC28J60_GENERAL_CHECKSUM
	call	ENC28J60_GENERAL_CHECKSUM
	pagesel	$
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
SysWaitLoop10
	movlw	31
	movwf	ADDR
	call	FN_ENC28J60_READREG
	movlw	8
	andwf	ENC28J60_READREG,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movwf	SysBYTETempA
	movlw	8
	movwf	SysBYTETempB
	banksel	STATUS
	call	SysCompEqual
	btfsc	SysByteTempX,0
	goto	SysWaitLoop10
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
SysWaitLoop11
	movlw	31
	movwf	ADDR
	call	FN_ENC28J60_READREG
	movlw	8
	andwf	ENC28J60_READREG,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movwf	SysBYTETempA
	movlw	8
	movwf	SysBYTETempB
	banksel	STATUS
	call	SysCompEqual
	btfsc	SysByteTempX,0
	goto	SysWaitLoop11
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

ENC28J60_PINGREPLY
;Dim Packetlength As Word
;T_id0 = ip_id_h
	movf	IP_ID_H,W
	banksel	SYSETHERBUFFER_19
	movwf	SYSETHERBUFFER_19
;T_id1 = [byte]ip_id
	banksel	IP_ID
	movf	IP_ID,W
	banksel	SYSETHERBUFFER_20
	movwf	SYSETHERBUFFER_20
;Ip_id = Ip_id + 1
	banksel	IP_ID
	incf	IP_ID,F
	btfsc	STATUS,Z
	incf	IP_ID_H,F
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
	clrf	SYSETHERBUFFER_25
;T_ip_hdr_cksum1 = 0
	clrf	SYSETHERBUFFER_26
;ENC28j60_Calcchecksum( T_ip_header_pointer0 , T_ip_header_pointer1 , T_ip_hdr_cksum0_pointer )
	movlw	15
	banksel	STARTPTR
	movwf	STARTPTR
	clrf	STARTPTR_H
	movlw	33
	banksel	ENDPTR
	movwf	ENDPTR
	clrf	ENDPTR_H
	movlw	25
	banksel	RESULT
	movwf	RESULT
	clrf	RESULT_H
	banksel	STATUS
	pagesel	ENC28J60_CALCCHECKSUM
	call	ENC28J60_CALCCHECKSUM
	pagesel	$
;T_icmp_type = 0
	banksel	SYSETHERBUFFER_35
	clrf	SYSETHERBUFFER_35
;T_icmp_cksum0 = 0
	clrf	SYSETHERBUFFER_37
;T_icmp_cksum1 = 0
	clrf	SYSETHERBUFFER_38
;Packetlength_h = etherBuffer(17)
	movf	SYSETHERBUFFER_17,W
	banksel	PACKETLENGTH_H
	movwf	PACKETLENGTH_H
;[byte]Packetlength = etherBuffer(18)
	banksel	SYSETHERBUFFER_18
	movf	SYSETHERBUFFER_18,W
	banksel	PACKETLENGTH
	movwf	PACKETLENGTH
;Packetlength = etherBuffer(17) * 256
;Packetlength = Packetlength + etherBuffer(18)
;Packetlength = Packetlength + 13                         'We are going to calculate the checksum till the end of packet (IP length + 14 byte of the ethernet stuff), -1 to get word start
	movlw	13
	addwf	PACKETLENGTH,F
	movlw	0
	addwfc	PACKETLENGTH_H,F
;ENC28j60_Calcchecksum(35 , Packetlength , 37)
	movlw	35
	movwf	STARTPTR
	clrf	STARTPTR_H
	movf	PACKETLENGTH,W
	banksel	ENDPTR
	movwf	ENDPTR
	banksel	PACKETLENGTH_H
	movf	PACKETLENGTH_H,W
	banksel	ENDPTR_H
	movwf	ENDPTR_H
	movlw	37
	banksel	RESULT
	movwf	RESULT
	clrf	RESULT_H
	banksel	STATUS
	pagesel	ENC28J60_CALCCHECKSUM
	call	ENC28J60_CALCCHECKSUM
	pagesel	$
;Packetlength = Packetlength + 1
	banksel	PACKETLENGTH
	incf	PACKETLENGTH,F
	btfsc	STATUS,Z
	incf	PACKETLENGTH_H,F
;ENC28j60_writebuffer( packetlength )
	movf	PACKETLENGTH,W
	movwf	PCKTLEN
	movf	PACKETLENGTH_H,W
	movwf	PCKTLEN_H
	banksel	STATUS
	call	ENC28J60_WRITEBUFFER
;ENC28j60_packetsend(packetlength)
	banksel	PACKETLENGTH
	movf	PACKETLENGTH,W
	movwf	PCKTLEN
	movf	PACKETLENGTH_H,W
	movwf	PCKTLEN_H
	banksel	STATUS
	goto	ENC28J60_PACKETSEND

;********************************************************************************

ENC28J60_POLL
;if crl = 1 then
	decf	CRL,W
	btfsc	STATUS, Z
;HSerPrintCRLF
;crl = 0
	clrf	CRL
;Else
;if bck = 1 Then
;HSerPrint "<"
;bck=0
;end if
;end if
;HSerPrint "EIE :"
;HSerPrint ByteToBin( ENC28j60_ReadReg( EIE ))
;HSerSend 9
;HSerPrint "EIR :"
;HSerPrint ByteToBin( ENC28j60_ReadReg( EIR ))
;HSerSend 9
;HSerPrintCRLF
;ENC28j60_data = ENC28j60_ReadReg( erevid )
;ENC28j60_selectBank ( 1, epktcnt )
;lastselectedBank = 99
	movlw	99
	banksel	LASTSELECTEDBANK
	movwf	LASTSELECTEDBANK
;HSerPrint ENC28j60_ReadReg( epktcnt )
;HSerPrintCRLF
;wait while ( ENC28j60_ReadReg( ESTAT ) and ESTAT_RXBUSY ) = ESTAT_RXBUSY
;if ENC28j60_ReadReg( epktcnt ) > 0 Then
	movlw	57
	banksel	ADDR
	movwf	ADDR
	call	FN_ENC28J60_READREG
	movf	ENC28J60_READREG,W
	sublw	0
	btfsc	STATUS, C
	goto	ELSE12_1
;HSerPrint "1"
;ENC28j60_packetreceive(300)
	movlw	44
	banksel	MAXLEN
	movwf	MAXLEN
	movlw	1
	movwf	MAXLEN_H
	banksel	STATUS
	pagesel	ENC28J60_PACKETRECEIVE
	call	ENC28J60_PACKETRECEIVE
	pagesel	$
;crl = 1
	movlw	1
	movwf	CRL
;bck = 1
;else
ELSE12_1
;ENC28j60_bitSet( ECON2, ECON2_PKTDEC )
;end if
ERRORHANDLER
;if ENC28j60_ReadReg( EIR ) & 0x01 = 0X01 Then
	movlw	28
	movwf	ADDR
	call	FN_ENC28J60_READREG
	movf	ENC28J60_READREG,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	btfss	SysTemp1,0
	goto	ENDIF13
;HSerPrint "Buffer Overun"
;HSerSend 7
;HSerPrint "B"
;ENC28j60_bitClear( EIR, EIR_RXERIF )
	movlw	28
	banksel	ADDR
	movwf	ADDR
	movlw	1
	movwf	ENC_OUTBYTE
	call	ENC28J60_BITCLEAR
;end if
ENDIF13
	banksel	STATUS
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
	banksel	SYSREPEATTEMP4
	movwf	SysRepeatTemp4
SysRepeatLoop4
;set c off
	bcf	STATUS,C
;rotate banktobeselected right
	banksel	BANKTOBESELECTED
	rrf	BANKTOBESELECTED,F
;end repeat
	banksel	SYSREPEATTEMP4
	decfsz	SysRepeatTemp4,F
	goto	SysRepeatLoop4
SysRepeatLoopEnd4
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
	goto	ENDIF14
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
	call	SysCompLessThan
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ELSE15_1
;ENC28j60_selectBank ( banktobeselected, addr )
	call	ENC28J60_SELECTBANK
;else
	goto	ENDIF15
ELSE15_1
;lastselectedBank = banktobeselected
	movf	BANKTOBESELECTED,W
	banksel	LASTSELECTEDBANK
	movwf	LASTSELECTEDBANK
;end if
ENDIF15
;end if
ENDIF14
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
	call	FASTHWSPITRANSFER
;FastHWSPITransfer(b'00000011', temp)
	movlw	3
	banksel	SPITXDATA
	movwf	SPITXDATA
	banksel	STATUS
	call	FASTHWSPITRANSFER
;ENC28j60_Deselect
	bsf	LATB,2
;ENC28j60_Select
	bcf	LATB,2
;FastHWSPITransfer(BFSCMD | ECON1, temp)
	movlw	159
	banksel	SPITXDATA
	movwf	SPITXDATA
	banksel	STATUS
	call	FASTHWSPITRANSFER
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
	call	FASTHWSPITRANSFER
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
	call	FASTHWSPITRANSFER
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
	call	FASTHWSPITRANSFER
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

ENC28J60_SETIPADDRS
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
	call	ENC28J60_SET_RESPONSE_MACADDRESS
;ENC28j60_Ip_header_checksum
	goto	ENC28J60_IP_HEADER_CHECKSUM

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
	call	ENC28J60_SET_RESPONSE_MACADDRESS
;ENC28j60_Ip_header_checksum
	goto	ENC28J60_IP_HEADER_CHECKSUM

;********************************************************************************

ENC28J60_SET_RESPONSE_MACADDRESS
;For II = 1 To 6
	clrf	II
SysForLoop4
	incf	II,F
;etherBuffer(II)= etherBuffer(6 + II)
	movlw	low(ETHERBUFFER+6)
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(ETHERBUFFER+6)
	movwf	SysTemp1_H
	banksel	II
	movf	II,W
	banksel	SYSTEMP1
	addwf	SysTemp1,W
	movwf	AFSR0
	movlw	0
	addwfc	SysTemp1_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SysArrayTemp2
	movwf	SysArrayTemp1
	movlw	low(ETHERBUFFER)
	banksel	II
	addwf	II,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	high(ETHERBUFFER)
	addwfc	SysTemp2,W
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

ENC28J60_UDP_CHECKSUM
;dim I_chksum32 as long
;dim Hulp2, I_x as word
;T_udp_chksum0 = 0x00
	banksel	SYSETHERBUFFER_41
	clrf	SYSETHERBUFFER_41
;T_udp_chksum1 = 0x00
	clrf	SYSETHERBUFFER_42
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
	call	SysCompLessThan16
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd5
SysForLoop5
	incf	ETH_COUNTER,F
	btfsc	STATUS,Z
	incf	ETH_COUNTER_H,F
;if eth_counter > etherBufferSize then Exit For
	movf	ETH_COUNTER,W
	movwf	SysWORDTempB
	movf	ETH_COUNTER_H,W
	movwf	SysWORDTempB_H
	movlw	244
	movwf	SysWORDTempA
	movlw	1
	movwf	SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd5
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
	call	SysCompLessThan16
	btfsc	SysByteTempX,0
	goto	SysForLoop5
SysForLoopEnd5
;ENC28j60_Deselect
	bsf	LATB,2
	return

;********************************************************************************

ENC28J60_WRITEPHYREG
;		while ((ENC28j60_ReadReg(MISTAT) & MISTAT_BUSY ) = MISTAT_BUSY )
SysDoLoop_S2
	movlw	234
	movwf	ADDR
	call	FN_ENC28J60_READREG
;ENC28j60_writeReg( MIREGADR, PhyRegaddr )
	movlw	212
	movwf	ADDR
	banksel	PHYREGADDR
	movf	PHYREGADDR,W
	banksel	ENC_OUTBYTE
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg( MIWRL, ENC_Outbyte1 )
	movlw	214
	movwf	ADDR
	movf	ENC_OUTBYTE1,W
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg( MIWRH, ENC_Outbyte2 )
	movlw	215
	movwf	ADDR
	movf	ENC_OUTBYTE2,W
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;wait while ( (ENC28j60_ReadReg( MISTAT ) & MISTAT_BUSY ) = MISTAT_BUSY )
SysWaitLoop6
	movlw	234
	movwf	ADDR
	call	FN_ENC28J60_READREG
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

ENC28J60_WRITEREG
;				banktobeselected = ( addr & BANK_MASK) / 32
;banktobeselected =  ( addr & BANK_MASK)
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
;end Repeat
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
	goto	ELSE16_1
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
	call	SysCompLessThan
	comf	SysByteTempX,F
	btfsc	SysByteTempX,0
;ENC28j60_selectBank ( banktobeselected, addr )
	call	ENC28J60_SELECTBANK
;end if
;Else
	goto	ENDIF16
ELSE16_1
;lastselectedBank = banktobeselected
	banksel	BANKTOBESELECTED
	movf	BANKTOBESELECTED,W
	banksel	LASTSELECTEDBANK
	movwf	LASTSELECTEDBANK
;end if
ENDIF16
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
	call	FASTHWSPITRANSFER
;FastHWSPITransfer( ENC_Outbyte, temp )
	movf	ENC_OUTBYTE,W
	banksel	SPITXDATA
	movwf	SPITXDATA
	banksel	STATUS
	call	FASTHWSPITRANSFER
;ENC28j60_Deselect
	bsf	LATB,2
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

;Overloaded signature: STRING:byte:
HSERPRINT252
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
	goto	ENDIF21
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
	call	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;next
	banksel	PRINTLEN
	movf	PRINTLEN,W
	subwf	SYSPRINTTEMP,W
	btfss	STATUS, C
	goto	SysForLoop1
SysForLoopEnd1
;End If
ENDIF21
	banksel	STATUS
	return

;********************************************************************************

;Overloaded signature: BYTE:byte:
HSERPRINT253
;OutValueTemp = 0
	banksel	OUTVALUETEMP
	clrf	OUTVALUETEMP
;IF SerPrintVal >= 100 Then
	movlw	100
	subwf	SERPRINTVAL,W
	btfss	STATUS, C
	goto	ENDIF86
;OutValueTemp = SerPrintVal / 100
	movf	SERPRINTVAL,W
	movwf	SysBYTETempA
	movlw	100
	movwf	SysBYTETempB
	banksel	STATUS
	call	SysDivSub
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
	call	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;End If
ENDIF86
;If OutValueTemp > 0 Or SerPrintVal >= 10 Then
	banksel	OUTVALUETEMP
	movf	OUTVALUETEMP,W
	movwf	SysBYTETempB
	clrf	SysBYTETempA
	banksel	STATUS
	call	SysCompLessThan
	movf	SysByteTempX,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	movf	SERPRINTVAL,W
	movwf	SysBYTETempA
	movlw	10
	movwf	SysBYTETempB
	banksel	STATUS
	call	SysCompLessThan
	comf	SysByteTempX,F
	banksel	SYSTEMP3
	movf	SysTemp3,W
	iorwf	SysByteTempX,W
	movwf	SysTemp1
	btfss	SysTemp1,0
	goto	ENDIF87
;OutValueTemp = SerPrintVal / 10
	movf	SERPRINTVAL,W
	movwf	SysBYTETempA
	movlw	10
	movwf	SysBYTETempB
	banksel	STATUS
	call	SysDivSub
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
	call	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;End If
ENDIF87
;HSerSend(SerPrintVal + 48 ,comport)
	movlw	48
	banksel	SERPRINTVAL
	addwf	SERPRINTVAL,W
	movwf	SERDATA
	banksel	STATUS
	call	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	goto	Delay_MS

;********************************************************************************

;Overloaded signature: WORD:byte:
HSERPRINT254
;Dim SysCalcTempX As Word
;OutValueTemp = 0
	banksel	OUTVALUETEMP
	clrf	OUTVALUETEMP
;If SerPrintVal >= 10000 then
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB
	movlw	39
	movwf	SysWORDTempB_H
	banksel	STATUS
	call	SysCompLessThan16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF88
;OutValueTemp = SerPrintVal / 10000 [word]
	banksel	SERPRINTVAL
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB
	movlw	39
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempA,W
	banksel	OUTVALUETEMP
	movwf	OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SERPRINTVAL
	movf	SYSCALCTEMPX_H,W
	movwf	SERPRINTVAL_H
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W
	movwf	SERDATA
	banksel	STATUS
	call	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;Goto HSerPrintWord1000
	goto	HSERPRINTWORD1000
;End If
ENDIF88
;If SerPrintVal >= 1000 then
	banksel	SERPRINTVAL
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB
	movlw	3
	movwf	SysWORDTempB_H
	banksel	STATUS
	call	SysCompLessThan16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF89
HSERPRINTWORD1000
;OutValueTemp = SerPrintVal / 1000 [word]
	banksel	SERPRINTVAL
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB
	movlw	3
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempA,W
	banksel	OUTVALUETEMP
	movwf	OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SERPRINTVAL
	movf	SYSCALCTEMPX_H,W
	movwf	SERPRINTVAL_H
;HSerSend(OutValueTemp + 48 ,comport  )
	movlw	48
	addwf	OUTVALUETEMP,W
	movwf	SERDATA
	banksel	STATUS
	call	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;Goto HSerPrintWord100
	goto	HSERPRINTWORD100
;End If
ENDIF89
;If SerPrintVal >= 100 then
	banksel	SERPRINTVAL
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	call	SysCompLessThan16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF90
HSERPRINTWORD100
;OutValueTemp = SerPrintVal / 100 [word]
	banksel	SERPRINTVAL
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempA,W
	banksel	OUTVALUETEMP
	movwf	OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SERPRINTVAL
	movf	SYSCALCTEMPX_H,W
	movwf	SERPRINTVAL_H
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W
	movwf	SERDATA
	banksel	STATUS
	call	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;Goto HSerPrintWord10
	goto	HSERPRINTWORD10
;End If
ENDIF90
;If SerPrintVal >= 10 then
	banksel	SERPRINTVAL
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	call	SysCompLessThan16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF91
HSERPRINTWORD10
;OutValueTemp = SerPrintVal / 10 [word]
	banksel	SERPRINTVAL
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempA,W
	banksel	OUTVALUETEMP
	movwf	OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SERPRINTVAL
	movf	SYSCALCTEMPX_H,W
	movwf	SERPRINTVAL_H
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W
	movwf	SERDATA
	banksel	STATUS
	call	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;End If
ENDIF91
;HSerSend(SerPrintVal + 48 ,comport  )
	movlw	48
	banksel	SERPRINTVAL
	addwf	SERPRINTVAL,W
	movwf	SERDATA
	banksel	STATUS
	call	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	goto	Delay_MS

;********************************************************************************

HSERPRINTCRLF
;repeat HSerPrintCRLFCount
	movf	HSERPRINTCRLFCOUNT,W
	banksel	SYSREPEATTEMP6
	movwf	SysRepeatTemp6
	btfsc	STATUS,Z
	goto	SysRepeatLoopEnd6
SysRepeatLoop6
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
	banksel	SYSREPEATTEMP6
	decfsz	SysRepeatTemp6,F
	goto	SysRepeatLoop6
SysRepeatLoopEnd6
	banksel	STATUS
	return

;********************************************************************************

HSERSEND
;if comport = 1 Then
	decf	COMPORT,W
	btfss	STATUS, Z
	goto	ENDIF20
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
ENDIF20
	banksel	STATUS
	return

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
SPIMODE208
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
	goto	ENDIF18
;Set SSPSTAT.CKE On
	banksel	SSPSTAT
	bsf	SSPSTAT,CKE
;End If
ENDIF18
;Set SSPCON1.CKP Off
	banksel	SSPCON1
	bcf	SSPCON1,CKP
;If SPIClockMode.1 = On Then
	banksel	SPICLOCKMODE
	btfss	SPICLOCKMODE,1
	goto	ENDIF19
;Set SSPCON1.CKP On
	banksel	SSPCON1
	bsf	SSPCON1,CKP
;End If
ENDIF19
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

;Overloaded signature: BYTE:BYTE:
SWAP91
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
	goto	ENDIF59
	movf	SYSDIVMULTA,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTA_H,W
	addwfc	SYSDIVMULTX_H,F
ENDIF59
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
	call	SYSSTRINGTABLES
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA
;movwf INDF1
	movwf	INDF1
;goto SysStringReadCheck
	goto	SYSSTRINGREADCHECK
SYSREADSTRINGPART
;call SysStringTables
	call	SYSSTRINGTABLES
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
	call	SYSSTRINGTABLES
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

SysStringTables
	movf	SysStringA_H,W
	movwf	PCLATH
	movf	SysStringA,W
	incf	SysStringA,F
	btfsc	STATUS,Z
	incf	SysStringA_H,F
	movwf	PCL

StringTable4
	retlw	28
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
	retlw	50	;2
	retlw	53	;5


StringTable18
	retlw	1
	retlw	33	;!


StringTable27
	retlw	1
	retlw	46	;.


StringTable28
	retlw	1
	retlw	58	;:


StringTable29
	retlw	15
	retlw	72	;H
	retlw	84	;T
	retlw	84	;T
	retlw	80	;P
	retlw	47	;/
	retlw	48	;0
	retlw	46	;.
	retlw	57	;9
	retlw	32	; 
	retlw	50	;2
	retlw	48	;0
	retlw	48	;0
	retlw	32	; 
	retlw	79	;O
	retlw	75	;K


StringTable30
	retlw	23
	retlw	67	;C
	retlw	111	;o
	retlw	110	;n
	retlw	116	;t
	retlw	101	;e
	retlw	110	;n
	retlw	116	;t
	retlw	45	;-
	retlw	84	;T
	retlw	121	;y
	retlw	112	;p
	retlw	101	;e
	retlw	58	;:
	retlw	32	; 
	retlw	116	;t
	retlw	101	;e
	retlw	120	;x
	retlw	116	;t
	retlw	47	;/
	retlw	104	;h
	retlw	116	;t
	retlw	109	;m
	retlw	108	;l


StringTable31
	retlw	25
	retlw	35	;#
	retlw	50	;2
	retlw	69	;E
	retlw	82	;R
	retlw	68	;D
	retlw	80	;P
	retlw	84	;T
	retlw	76	;L
	retlw	32	; 
	retlw	97	;a
	retlw	110	;n
	retlw	100	;d
	retlw	32	; 
	retlw	69	;E
	retlw	82	;R
	retlw	68	;D
	retlw	80	;P
	retlw	84	;T
	retlw	72	;H
	retlw	32	; 
	retlw	101	;e
	retlw	114	;r
	retlw	114	;r
	retlw	111	;o
	retlw	114	;r


;********************************************************************************

;Start of program memory page 3
	ORG	6144

 END
