;Program compiled by Great Cow BASIC (0.96.01 2017-01-04)
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
ACKPSH	EQU	32
ADCON	EQU	33
ADCPH	EQU	34
ADDR	EQU	35
ADREADPORT	EQU	36
ANALOGCHANNEL	EQU	37
ARRAYLOC	EQU	38
ARRAYLOC_H	EQU	39
BANKTOBESELECTED	EQU	40
BUTTONSTATE	EQU	41
BYTENUM	EQU	42
BYTETOBIN	EQU	9065
CLIENT_SEQNUM	EQU	43
CLIENT_SEQNUM_E	EQU	47
CLIENT_SEQNUM_H	EQU	48
CLIENT_SEQNUM_U	EQU	49
COMMANDLINESTRING	EQU	9085
COMPORT	EQU	50
CURRBYTE	EQU	51
DELAYTEMP	EQU	112
DELAYTEMP2	EQU	113
ENC28J60_DATA	EQU	52
ENC28J60_READREG	EQU	53
ENC28J60_TEMP	EQU	54
ENC_IPADDR	EQU	9047
ENC_IPPORT	EQU	55
ENC_IPROUTER	EQU	9042
ENC_IPSERVER	EQU	9037
ENC_MACADDR	EQU	9058
ENC_MACADDROUTER	EQU	9032
ENC_NEXTPACKETPTR	EQU	56
ENC_NEXTPACKETPTR_H	EQU	57
ENC_OUTBYTE	EQU	58
ENC_OUTBYTE1	EQU	59
ENC_OUTBYTE2	EQU	60
ENC_SNTPSERVERADDR	EQU	9027
ENDPTR	EQU	61
ENDPTR_H	EQU	62
EPOCH_SECONDS	EQU	63
EPOCH_SECONDS_E	EQU	66
EPOCH_SECONDS_H	EQU	64
EPOCH_SECONDS_U	EQU	65
ETHERBUFFER	EQU	9221
ETHERBUFFERINDEX	EQU	67
ETHERBUFFERINDEX_H	EQU	68
ETHERGETLENGTH	EQU	69
ETHERGETLENGTH_H	EQU	70
ETH_COUNTER	EQU	71
ETH_COUNTER_H	EQU	72
ETH_FRAMELENGTH	EQU	73
ETH_FRAMELENGTH_H	EQU	74
FLAGS	EQU	75
FNLSL	EQU	76
FNLSL_E	EQU	79
FNLSL_H	EQU	77
FNLSL_U	EQU	78
FNLSR	EQU	80
FNLSR_E	EQU	83
FNLSR_H	EQU	81
FNLSR_U	EQU	82
HEX	EQU	9023
HSERPRINTCRLFCOUNT	EQU	84
HTTPCLOSETRANSACTION	EQU	85
HTTPPRINTCRLFFLAG	EQU	86
HTTPSENTTCPPACKET	EQU	87
HULP2	EQU	88
HULP2_H	EQU	89
HULP3	EQU	90
II	EQU	91
II_H	EQU	92
INCOMING_ACK	EQU	93
INCOMING_ACK_E	EQU	96
INCOMING_ACK_H	EQU	94
INCOMING_ACK_U	EQU	95
INSTR	EQU	97
IP_HEADER_LENGTH	EQU	98
IP_ID	EQU	99
IP_ID_H	EQU	100
I_CHECKSUM16	EQU	101
I_CHECKSUM16_H	EQU	102
I_CHKSUM32	EQU	103
I_CHKSUM32_E	EQU	106
I_CHKSUM32_H	EQU	104
I_CHKSUM32_U	EQU	105
I_ODD	EQU	107
I_X	EQU	108
I_X_H	EQU	109
L2	EQU	160
L2_E	EQU	163
L2_H	EQU	161
L2_U	EQU	162
LASTGET	EQU	110
LASTSELECTEDBANK	EQU	111
LEFT	EQU	9180
LOCALTMP	EQU	125
LOCALTMP_H	EQU	126
MAXLEN	EQU	164
MAXLEN_H	EQU	165
NUMBITS	EQU	127
OUTVALUETEMP	EQU	166
PACKETLENGTH	EQU	167
PACKETLENGTH_H	EQU	168
PCKTLEN	EQU	169
PCKTLEN_H	EQU	170
PHYREGADDR	EQU	171
PRINTLEN	EQU	172
READAD	EQU	173
RESULT	EQU	174
RESULT_H	EQU	175
RXSTAT	EQU	176
RXSTAT_H	EQU	177
SERDATA	EQU	178
SERPRINTVAL	EQU	179
SERPRINTVAL_E	EQU	182
SERPRINTVAL_H	EQU	180
SERPRINTVAL_U	EQU	181
SPICLOCKMODE	EQU	183
SPICURRENTMODE	EQU	184
SPIRXDATA	EQU	185
SPITXDATA	EQU	186
STARTPTR	EQU	187
STARTPTR_H	EQU	188
STR	EQU	9052
STRINGPOINTER	EQU	189
SUM	EQU	190
SUM_E	EQU	193
SUM_H	EQU	191
SUM_U	EQU	192
SYSARRAYTEMP1	EQU	194
SYSARRAYTEMP2	EQU	195
SYSBITVAR0	EQU	196
SYSBYTETEMPA	EQU	117
SYSBYTETEMPB	EQU	121
SYSBYTETEMPX	EQU	112
SYSCALCTEMPA	EQU	117
SYSCALCTEMPA_E	EQU	120
SYSCALCTEMPA_H	EQU	118
SYSCALCTEMPA_U	EQU	119
SYSCALCTEMPB	EQU	121
SYSCALCTEMPX	EQU	112
SYSCALCTEMPX_H	EQU	113
SYSCHARCOUNT	EQU	197
SYSDIVLOOP	EQU	116
SYSDIVMULTA	EQU	119
SYSDIVMULTA_H	EQU	120
SYSDIVMULTB	EQU	123
SYSDIVMULTB_H	EQU	124
SYSDIVMULTX	EQU	114
SYSDIVMULTX_H	EQU	115
SYSENC_MACADDRHANDLER	EQU	198
SYSENC_MACADDRHANDLER_H	EQU	199
SYSFINDLEN	EQU	200
SYSFNBYTE1	EQU	201
SYSHTTPDATAHANDLER	EQU	202
SYSHTTPDATAHANDLER_H	EQU	203
SYSLONGDIVMULTA	EQU	204
SYSLONGDIVMULTA_E	EQU	207
SYSLONGDIVMULTA_H	EQU	205
SYSLONGDIVMULTA_U	EQU	206
SYSLONGDIVMULTB	EQU	208
SYSLONGDIVMULTB_E	EQU	211
SYSLONGDIVMULTB_H	EQU	209
SYSLONGDIVMULTB_U	EQU	210
SYSLONGDIVMULTX	EQU	212
SYSLONGDIVMULTX_E	EQU	215
SYSLONGDIVMULTX_H	EQU	213
SYSLONGDIVMULTX_U	EQU	214
SYSLONGTEMPA	EQU	117
SYSLONGTEMPA_E	EQU	120
SYSLONGTEMPA_H	EQU	118
SYSLONGTEMPA_U	EQU	119
SYSLONGTEMPB	EQU	121
SYSLONGTEMPB_E	EQU	124
SYSLONGTEMPB_H	EQU	122
SYSLONGTEMPB_U	EQU	123
SYSLONGTEMPX	EQU	112
SYSLONGTEMPX_E	EQU	115
SYSLONGTEMPX_H	EQU	113
SYSLONGTEMPX_U	EQU	114
SYSPRINTBUFFER	EQU	9074
SYSPRINTBUFFLEN	EQU	216
SYSPRINTDATAHANDLER	EQU	217
SYSPRINTDATAHANDLER_H	EQU	218
SYSPRINTTEMP	EQU	219
SYSREPEATTEMP1	EQU	220
SYSREPEATTEMP10	EQU	221
SYSREPEATTEMP11	EQU	222
SYSREPEATTEMP2	EQU	223
SYSREPEATTEMP3	EQU	224
SYSREPEATTEMP4	EQU	225
SYSREPEATTEMP5	EQU	226
SYSREPEATTEMP6	EQU	227
SYSREPEATTEMP7	EQU	228
SYSREPEATTEMP8	EQU	229
SYSREPEATTEMP9	EQU	230
SYSSEARCHEND	EQU	231
SYSSTRDATA	EQU	232
SYSSTRINGA	EQU	119
SYSSTRINGA_H	EQU	120
SYSSTRINGLENGTH	EQU	118
SYSSTRINGPARAM1	EQU	9139
SYSSTRINGTEMP	EQU	233
SYSSTRLEN	EQU	234
SYSSYSFINDSTRINGHANDLER	EQU	235
SYSSYSFINDSTRINGHANDLER_H	EQU	236
SYSSYSINSTRINGHANDLER	EQU	237
SYSSYSINSTRINGHANDLER_H	EQU	238
SYSTEMP1	EQU	288
SYSTEMP1_E	EQU	291
SYSTEMP1_H	EQU	289
SYSTEMP1_U	EQU	290
SYSTEMP2	EQU	292
SYSTEMP2_E	EQU	295
SYSTEMP2_H	EQU	293
SYSTEMP2_U	EQU	294
SYSTEMP3	EQU	239
SYSTEMPARRAY	EQU	9098
SYSVALTEMP	EQU	296
SYSVALTEMP_H	EQU	297
SYSWAITTEMP10US	EQU	117
SYSWAITTEMPMS	EQU	114
SYSWAITTEMPMS_H	EQU	115
SYSWORDTEMPA	EQU	117
SYSWORDTEMPA_H	EQU	118
SYSWORDTEMPB	EQU	121
SYSWORDTEMPB_H	EQU	122
SYSWORDTEMPX	EQU	112
SYSWORDTEMPX_H	EQU	113
TABLELOC	EQU	298
TABLELOC_H	EQU	299
TABLESTARTPOINT	EQU	300
TABLESTARTPOINT_H	EQU	301
TCPDATALEN_IN	EQU	302
TCPDATALEN_IN_H	EQU	303
TCPRESULT16	EQU	304
TCPRESULT16_H	EQU	305
TEMP	EQU	306
TT	EQU	307
T_UDP_DESTPORT	EQU	308
T_UDP_DESTPORT_H	EQU	309
VAL1	EQU	310
VAL2	EQU	311
VAL2_H	EQU	312
VAL3	EQU	313
VAL4	EQU	314
WORK	EQU	315
X_ODD	EQU	316
ZZ	EQU	317
ZZZ	EQU	318
ZZZ_H	EQU	319

;********************************************************************************

;Alias variables
AFSR0	EQU	4
AFSR0_H	EQU	5
I_VALUE16	EQU	101
I_VALUE16_H	EQU	102
SYSCOMMANDLINESTRING_0	EQU	1453
SYSCOMMANDLINESTRING_1	EQU	1454
SYSCOMMANDLINESTRING_10	EQU	1463
SYSCOMMANDLINESTRING_11	EQU	1464
SYSCOMMANDLINESTRING_12	EQU	1465
SYSCOMMANDLINESTRING_2	EQU	1455
SYSCOMMANDLINESTRING_3	EQU	1456
SYSCOMMANDLINESTRING_4	EQU	1457
SYSCOMMANDLINESTRING_5	EQU	1458
SYSCOMMANDLINESTRING_6	EQU	1459
SYSCOMMANDLINESTRING_7	EQU	1460
SYSCOMMANDLINESTRING_8	EQU	1461
SYSCOMMANDLINESTRING_9	EQU	1462
SYSENC_IPADDR_1	EQU	1368
SYSENC_IPADDR_2	EQU	1369
SYSENC_IPADDR_3	EQU	1370
SYSENC_IPADDR_4	EQU	1371
SYSENC_MACADDROUTER_1	EQU	1353
SYSENC_MACADDROUTER_2	EQU	1354
SYSENC_MACADDROUTER_3	EQU	1355
SYSENC_MACADDROUTER_4	EQU	1356
SYSENC_MACADDROUTER_5	EQU	1357
SYSENC_MACADDROUTER_6	EQU	1358
SYSENC_MACADDR_1	EQU	1379
SYSENC_MACADDR_2	EQU	1380
SYSENC_MACADDR_3	EQU	1381
SYSENC_MACADDR_4	EQU	1382
SYSENC_MACADDR_5	EQU	1383
SYSENC_MACADDR_6	EQU	1384
SYSENC_SNTPSERVERADDR_1	EQU	1348
SYSENC_SNTPSERVERADDR_2	EQU	1349
SYSENC_SNTPSERVERADDR_3	EQU	1350
SYSENC_SNTPSERVERADDR_4	EQU	1351
SYSETHERBUFFER_1	EQU	1638
SYSETHERBUFFER_10	EQU	1647
SYSETHERBUFFER_11	EQU	1696
SYSETHERBUFFER_12	EQU	1697
SYSETHERBUFFER_13	EQU	1698
SYSETHERBUFFER_14	EQU	1699
SYSETHERBUFFER_15	EQU	1700
SYSETHERBUFFER_16	EQU	1701
SYSETHERBUFFER_17	EQU	1702
SYSETHERBUFFER_18	EQU	1703
SYSETHERBUFFER_19	EQU	1704
SYSETHERBUFFER_2	EQU	1639
SYSETHERBUFFER_20	EQU	1705
SYSETHERBUFFER_21	EQU	1706
SYSETHERBUFFER_22	EQU	1707
SYSETHERBUFFER_23	EQU	1708
SYSETHERBUFFER_24	EQU	1709
SYSETHERBUFFER_25	EQU	1710
SYSETHERBUFFER_26	EQU	1711
SYSETHERBUFFER_27	EQU	1712
SYSETHERBUFFER_28	EQU	1713
SYSETHERBUFFER_29	EQU	1714
SYSETHERBUFFER_3	EQU	1640
SYSETHERBUFFER_30	EQU	1715
SYSETHERBUFFER_31	EQU	1716
SYSETHERBUFFER_32	EQU	1717
SYSETHERBUFFER_33	EQU	1718
SYSETHERBUFFER_34	EQU	1719
SYSETHERBUFFER_35	EQU	1720
SYSETHERBUFFER_36	EQU	1721
SYSETHERBUFFER_37	EQU	1722
SYSETHERBUFFER_38	EQU	1723
SYSETHERBUFFER_39	EQU	1724
SYSETHERBUFFER_4	EQU	1641
SYSETHERBUFFER_40	EQU	1725
SYSETHERBUFFER_41	EQU	1726
SYSETHERBUFFER_42	EQU	1727
SYSETHERBUFFER_43	EQU	1728
SYSETHERBUFFER_44	EQU	1729
SYSETHERBUFFER_45	EQU	1730
SYSETHERBUFFER_46	EQU	1731
SYSETHERBUFFER_47	EQU	1732
SYSETHERBUFFER_48	EQU	1733
SYSETHERBUFFER_49	EQU	1734
SYSETHERBUFFER_5	EQU	1642
SYSETHERBUFFER_50	EQU	1735
SYSETHERBUFFER_51	EQU	1736
SYSETHERBUFFER_52	EQU	1737
SYSETHERBUFFER_53	EQU	1738
SYSETHERBUFFER_54	EQU	1739
SYSETHERBUFFER_55	EQU	1740
SYSETHERBUFFER_56	EQU	1741
SYSETHERBUFFER_57	EQU	1742
SYSETHERBUFFER_58	EQU	1743
SYSETHERBUFFER_59	EQU	1744
SYSETHERBUFFER_6	EQU	1643
SYSETHERBUFFER_60	EQU	1745
SYSETHERBUFFER_61	EQU	1746
SYSETHERBUFFER_62	EQU	1747
SYSETHERBUFFER_63	EQU	1748
SYSETHERBUFFER_64	EQU	1749
SYSETHERBUFFER_65	EQU	1750
SYSETHERBUFFER_66	EQU	1751
SYSETHERBUFFER_67	EQU	1752
SYSETHERBUFFER_68	EQU	1753
SYSETHERBUFFER_69	EQU	1754
SYSETHERBUFFER_7	EQU	1644
SYSETHERBUFFER_70	EQU	1755
SYSETHERBUFFER_8	EQU	1645
SYSETHERBUFFER_9	EQU	1646
SYSHEX_0	EQU	1343
SYSHEX_1	EQU	1344
SYSHEX_2	EQU	1345
SYSLEFT_0	EQU	1596
SYSREADADBYTE	EQU	173
SYSSTR_0	EQU	1372

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
	call	PPSINIT
	call	INITUSART
	call	ENC28J60_INITIALISE
;Automatic pin direction setting
	movlw	255
	movwf	TRISE
	movlw	255
	movwf	TRISC

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
;No DHCP support
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
;----- Define Hardware settings for the ENC28j60 for SPI, if PPS is used then needs to match the ports defined.
;#Define ENC28J60_DI               Portb.0     'Connected to Device SO
;#Define ENC28J60_DO               Portb.3     'Connected to Device SI
;#Define ENC28J60_SCK              Portb.1     'Connected to Clock
;#Define ENC28J60_CS               Porta.5     'Chip select line
;#Define ENC28J60_RESET            Portb.4     'Reset line
;----- Variables
;----- Quick Command Reference:
;----- Main body of program commences here.
RESET_ENC26J60
;HSerPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$

;HserPrint "ENC28j60 Ethernet Driver 040" : HSerPrintCRLF
	movlw	low StringTable4
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable4) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
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

;ENC_ipaddr = 192,168,0,3
	movlw	low ENC_IPADDR
	movwf	FSR0L
	movlw	high ENC_IPADDR
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
	movlw	3
	movwf	INDF0
;ENC_macaddr = 0x00, 0x1E, 0xC0, 0x00, 0x00, 0x03
	movlw	low ENC_MACADDR
	movwf	FSR0L
	movlw	high ENC_MACADDR
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
	movlw	3
	movwf	INDF0
;ENC_IpPort = 80
	movlw	80
	movwf	ENC_IPPORT
;ENC_ipserver = 192,168,0,106
	movlw	low ENC_IPSERVER
	movwf	FSR0L
	movlw	high ENC_IPSERVER
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
;ENC_iprouter = 192,168,0,250
	movlw	low ENC_IPROUTER
	movwf	FSR0L
	movlw	high ENC_IPROUTER
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
;ENC_MacAddRouter = 0x38, 0x10, 0xd5, 0xef, 0x0e, 0xdb
	movlw	low ENC_MACADDROUTER
	movwf	FSR0L
	movlw	high ENC_MACADDROUTER
	movwf	FSR0H
	movlw	6
	movwf	INDF0
	incf	FSR0L,F
	movlw	56
	movwf	INDF0
	incf	FSR0L,F
	movlw	16
	movwf	INDF0
	incf	FSR0L,F
	movlw	213
	movwf	INDF0
	incf	FSR0L,F
	movlw	239
	movwf	INDF0
	incf	FSR0L,F
	movlw	14
	movwf	INDF0
	incf	FSR0L,F
	movlw	219
	movwf	INDF0
;ENC_SntpServerAddr = 129, 6, 15, 28
	movlw	low ENC_SNTPSERVERADDR
	movwf	FSR0L
	movlw	high ENC_SNTPSERVERADDR
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
;ENC28j60_Init ( ENC_macaddr )
	movlw	low ENC_MACADDR
	banksel	SYSENC_MACADDRHANDLER
	movwf	SysENC_MACADDRHandler
	movlw	high ENC_MACADDR
	movwf	SysENC_MACADDRHandler_H
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
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$

;#Define SwitchIn porta.4
;dir SwitchIn  in
	bsf	TRISA,4
;#Define ENC28j60Led portd.3
;dir ENC28j60Led out
	bcf	TRISD,3
;#Define ButtonDown = 1
;dim buttonstate as byte
;buttonstate = ButtonDown
	movlw	1
	movwf	BUTTONSTATE
;dim myReadTime as bit
;myReadTime = 0
	banksel	SYSBITVAR0
	bcf	SYSBITVAR0,0
;ENC28j60_regdump
	banksel	STATUS
	call	ENC28J60_REGDUMP

;ENC28j60_setfrequency ( 3 )
	movlw	3
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_SETFREQUENCY
	call	ENC28J60_SETFREQUENCY
	pagesel	$

;repeat 3                                  'This, therefore, will display day and time 3 times.
	movlw	3
	banksel	SYSREPEATTEMP1
	movwf	SysRepeatTemp1
SysRepeatLoop1
;ENC28j60_sntp_get                       'Get the Network Time 3 times.
	banksel	STATUS
	pagesel	ENC28J60_SNTP_GET
	call	ENC28J60_SNTP_GET
	pagesel	$

;wait 5 ms                               'wait for the response, then, proceed to main program
	movlw	5
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;end repeat
	banksel	SYSREPEATTEMP1
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop1
SysRepeatLoopEnd1
;HSerPrint "Program Started "
	movlw	low StringTable7
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable7) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;Do forever
SysDoLoop_S1
;if SwitchIn = buttonstate then
	clrf	SysCalcTempA
	banksel	PORTA
	btfsc	PORTA,4
	incf	SysCalcTempA,F
	movf	BUTTONSTATE,W
	subwf	SysCalcTempA,W
	btfss	STATUS, Z
	goto	ENDIF2
;if buttonstate  = ButtonDown then
	decf	BUTTONSTATE,W
	btfss	STATUS, Z
	goto	ENDIF3
;ENC28j60_regdump
	call	ENC28J60_REGDUMP

;end if
ENDIF3
;end if
ENDIF2
;ENC28j60_poll
	pagesel	ENC28J60_POLL
	call	ENC28J60_POLL
	pagesel	$

;ENC28j60Led = !ENC28j60Led
	banksel	SYSTEMP1
	clrf	SysTemp1
	banksel	PORTD
	btfss	PORTD,3
	goto	ENDIF4
	banksel	SYSTEMP1
	incf	SysTemp1,F
ENDIF4
	banksel	SYSTEMP1
	comf	SysTemp1,F
	banksel	LATD
	bcf	LATD,3
	banksel	SYSTEMP1
	btfss	SysTemp1,0
	goto	ENDIF5
	banksel	LATD
	bsf	LATD,3
ENDIF5
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
;#define ENC28j60_Reset_CMD      Set ENC28j60_RESET on: Wait 20 ms :Set ENC28j60_RESET off: Wait 20 ms :Set ENC28j60_RESET on: Wait 20 ms
;#define Synflag = 0
;#define Finflag = 1
CONFIGURATIONDETAILS
MEMORY_LOCATIONS_SCRIPT
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

;********************************************************************************

ENC28J60_INITIALISE
;ENC_macaddr =   0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	movlw	low ENC_MACADDR
	movwf	FSR0L
	movlw	high ENC_MACADDR
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
;ENC_ipaddr =    0,0,0,0
	movlw	low ENC_IPADDR
	movwf	FSR0L
	movlw	high ENC_IPADDR
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
;ENC_IpPort = 80   'set a default value
	movlw	80
	movwf	ENC_IPPORT
;ENC_ipserver =  0,0,0,0
	movlw	low ENC_IPSERVER
	movwf	FSR0L
	movlw	high ENC_IPSERVER
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
;Ip_id = 0
	clrf	IP_ID
	clrf	IP_ID_H
;lastGet = 0
	clrf	LASTGET
;TableStartPoint =1
	movlw	1
	banksel	TABLESTARTPOINT
	movwf	TABLESTARTPOINT
	clrf	TABLESTARTPOINT_H
;Epoch_seconds = 0
	banksel	EPOCH_SECONDS
	clrf	EPOCH_SECONDS
	clrf	EPOCH_SECONDS_H
	clrf	EPOCH_SECONDS_U
	clrf	EPOCH_SECONDS_E
	return

;********************************************************************************

ENC28J60_REGDUMP
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$

;HSerPrint "Registerdump: "
	movlw	low StringTable85
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable85) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;HSerPrintCRLF 1
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$

;HSerPrint "Cntrl: ECON1 ECON2 ESTAT  EIR  EIE  EREVID"
	movlw	low StringTable86
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable86) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$

;ENC28j60_data = ENC28j60_ReadReg( econ1)
	movlw	31
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "       " + Hex(ENC28j60_data)
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable87
	movwf	SysStringA
	movlw	(high StringTable87) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;ENC28j60_data = ENC28j60_ReadReg( econ2)
	movlw	30
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "    " + Hex(ENC28j60_data)
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable88
	movwf	SysStringA
	movlw	(high StringTable88) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;ENC28j60_data = ENC28j60_ReadReg( estat)
	movlw	29
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "    " + Hex(ENC28j60_data)
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable88
	movwf	SysStringA
	movlw	(high StringTable88) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;ENC28j60_data = ENC28j60_ReadReg (eir)
	movlw	28
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "     " + Hex(ENC28j60_data)
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable89
	movwf	SysStringA
	movlw	(high StringTable89) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;ENC28j60_data = ENC28j60_ReadReg( eie)
	movlw	27
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "   " + Hex(ENC28j60_data)
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable90
	movwf	SysStringA
	movlw	(high StringTable90) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;ENC28j60_data = ENC28j60_ReadReg( erevid) AND 0b'00011111'
	movlw	114
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movlw	31
	andwf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "   " + Hex(ENC28j60_data)
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable90
	movwf	SysStringA
	movlw	(high StringTable90) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$

;HSerPrint "MAC  : MACON1  MACON3  MACON4  MAC-Address"
	movlw	low StringTable91
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable91) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$

;ENC28j60_data = ENC28j60_ReadReg( macon1)
	movlw	192
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "       " + Hex(ENC28j60_data)
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable87
	movwf	SysStringA
	movlw	(high StringTable87) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;Invalid register on specific revisions of the ENC28j60
;ENC28j60_data = ENC28j60_ReadReg( macon2)
;HSerPrint "      " + Hex(ENC28j60_data)
;ENC28j60_data = ENC28j60_ReadReg( macon3)
	movlw	194
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "      " + Hex(ENC28j60_data)
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable92
	movwf	SysStringA
	movlw	(high StringTable92) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;ENC28j60_data = ENC28j60_ReadReg( macon4)
	movlw	195
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "      " + Hex(ENC28j60_data)
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable92
	movwf	SysStringA
	movlw	(high StringTable92) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;ENC28j60_data = ENC28j60_ReadReg( maadr5)
	movlw	228
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "      " + Hex(ENC28j60_data)
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable92
	movwf	SysStringA
	movlw	(high StringTable92) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;ENC28j60_data = ENC28j60_ReadReg( maadr4)
	movlw	229
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint ":" + Hex(ENC28j60_data)
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable93
	movwf	SysStringA
	movlw	(high StringTable93) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;ENC28j60_data = ENC28j60_ReadReg( maadr3)
	movlw	226
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint ":" + Hex(ENC28j60_data)
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable93
	movwf	SysStringA
	movlw	(high StringTable93) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;ENC28j60_data = ENC28j60_ReadReg( maadr2)
	movlw	227
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint ":" + Hex(ENC28j60_data)
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable93
	movwf	SysStringA
	movlw	(high StringTable93) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;ENC28j60_data = ENC28j60_ReadReg( maadr1)
	movlw	224
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint ":" + Hex(ENC28j60_data)
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable93
	movwf	SysStringA
	movlw	(high StringTable93) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;ENC28j60_data = ENC28j60_ReadReg( maadr0)
	movlw	225
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint ":" + Hex(ENC28j60_data)
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable93
	movwf	SysStringA
	movlw	(high StringTable93) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$

;HSerPrint "Rx   : ERXST  ERXND  ERXWRPT ERXRDPT ERXFCON EPKTCNT MAMXFL"
	movlw	low StringTable94
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable94) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$

;ENC28j60_data = ENC28j60_ReadReg(erxsth)
	movlw	9
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "       " + Hex(ENC28j60_data)
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable87
	movwf	SysStringA
	movlw	(high StringTable87) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;ENC28j60_data = ENC28j60_ReadReg(erxstl)
	movlw	8
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint Hex(ENC28j60_data)
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;ENC28j60_data = ENC28j60_ReadReg(erxndh)
	movlw	11
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "   " + Hex(ENC28j60_data)
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable90
	movwf	SysStringA
	movlw	(high StringTable90) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;ENC28j60_data = ENC28j60_ReadReg(erxndl)
	movlw	10
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint Hex(ENC28j60_data)
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;ENC28j60_data = ENC28j60_ReadReg(erxwrpth)
	movlw	15
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "   " + Hex(ENC28j60_data)
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable90
	movwf	SysStringA
	movlw	(high StringTable90) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;ENC28j60_data = ENC28j60_ReadReg(erxwrptl)
	movlw	14
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint Hex(ENC28j60_data)
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;ENC28j60_data = ENC28j60_ReadReg(erxrdpth)
	movlw	13
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "    " + Hex(ENC28j60_data)
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable88
	movwf	SysStringA
	movlw	(high StringTable88) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;ENC28j60_data = ENC28j60_ReadReg(erxrdptl)
	movlw	12
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint Hex(ENC28j60_data)
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;ENC28j60_data = ENC28j60_ReadReg(erxfcon)
	movlw	56
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "    " + Hex(ENC28j60_data)
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable88
	movwf	SysStringA
	movlw	(high StringTable88) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;ENC28j60_data = ENC28j60_ReadReg(epktcnt)
	movlw	57
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "      " + Hex(ENC28j60_data)
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable92
	movwf	SysStringA
	movlw	(high StringTable92) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;ENC28j60_data = ENC28j60_ReadReg(mamxflh)
	movlw	203
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "      " + Hex(ENC28j60_data)
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable92
	movwf	SysStringA
	movlw	(high StringTable92) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;ENC28j60_data = ENC28j60_ReadReg(mamxfll)
	movlw	202
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint Hex(ENC28j60_data)
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$

;HSerPrint "Tx   : ETXST  ETXND  EWRPT  MACLCON1 MACLCON2"
	movlw	low StringTable95
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable95) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$

;ENC28j60_data = ENC28j60_ReadReg(etxsth)
	movlw	5
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "       " + Hex(ENC28j60_data)
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable87
	movwf	SysStringA
	movlw	(high StringTable87) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;ENC28j60_data = ENC28j60_ReadReg(etxstl)
	movlw	4
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint Hex(ENC28j60_data)
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;ENC28j60_data = ENC28j60_ReadReg(etxndh)
	movlw	7
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "   " + Hex(ENC28j60_data)
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable90
	movwf	SysStringA
	movlw	(high StringTable90) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;ENC28j60_data = ENC28j60_ReadReg(etxndl)
	movlw	6
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint Hex(ENC28j60_data)
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;ENC28j60_data = ENC28j60_ReadReg(EWRPTH)
	movlw	3
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "   " +  Hex(ENC28j60_data)
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable90
	movwf	SysStringA
	movlw	(high StringTable90) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;ENC28j60_data = ENC28j60_ReadReg(EWRPTl)
	movlw	2
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint Hex(ENC28j60_data)
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;ENC28j60_data = ENC28j60_ReadReg(maclcon1)
	movlw	200
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "   " + Hex(ENC28j60_data)
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable90
	movwf	SysStringA
	movlw	(high StringTable90) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;ENC28j60_data = ENC28j60_ReadReg(maclcon2)
	movlw	201
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "       " + Hex(ENC28j60_data)
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable87
	movwf	SysStringA
	movlw	(high StringTable87) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;Invalid register on specific revisions of the ENC28j60
;ENC28j60_data = ENC28j60_ReadReg(maphsup)
;HSerPrint "       " + Hex(ENC28j60_data)
;HSerPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$

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
;OSCFRQ = 0b00000110 'OSCSTAT chip.... the 16f18855 style chip
	movlw	6
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

PPSINIT
;RXPPS  = 0x17 'Pin RC7 source is an input for RX
	movlw	23
	banksel	RXPPS
	movwf	RXPPS
;RC6PPS = 0x10 'Pin RC6 source is TX/CK
	movlw	16
	banksel	RC6PPS
	movwf	RC6PPS
;SSP1CLKPPS = 0x09
	movlw	9
	banksel	SSP1CLKPPS
	movwf	SSP1CLKPPS
;RB1PPS = 0x14
	movlw	20
	banksel	RB1PPS
	movwf	RB1PPS
;SSP1DATPPS = 0x08
	movlw	8
	banksel	SSP1DATPPS
	movwf	SSP1DATPPS
;RB3PPS = 0x15
	movlw	21
	banksel	RB3PPS
	movwf	RB3PPS
	banksel	STATUS
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
	banksel	SYSBITVAR0
	bcf	SYSBITVAR0,1
	banksel	WORK
	btfss	WORK,0
	goto	ENDIF85
	banksel	SYSBITVAR0
	bsf	SYSBITVAR0,1
ENDIF85
;Tcp_syn = Work.1
	banksel	SYSBITVAR0
	bcf	SYSBITVAR0,2
	banksel	WORK
	btfss	WORK,1
	goto	ENDIF86
	banksel	SYSBITVAR0
	bsf	SYSBITVAR0,2
ENDIF86
;Tcp_rst = Work.2
	banksel	SYSBITVAR0
	bcf	SYSBITVAR0,3
	banksel	WORK
	btfss	WORK,2
	goto	ENDIF87
	banksel	SYSBITVAR0
	bsf	SYSBITVAR0,3
ENDIF87
;Tcp_psh = Work.3
	banksel	SYSBITVAR0
	bcf	SYSBITVAR0,4
	banksel	WORK
	btfss	WORK,3
	goto	ENDIF88
	banksel	SYSBITVAR0
	bsf	SYSBITVAR0,4
ENDIF88
;Tcp_ack = Work.4
	banksel	SYSBITVAR0
	bcf	SYSBITVAR0,5
	banksel	WORK
	btfss	WORK,4
	goto	ENDIF89
	banksel	SYSBITVAR0
	bsf	SYSBITVAR0,5
ENDIF89
;Tcp_urg = Work.5
	banksel	SYSBITVAR0
	bcf	SYSBITVAR0,6
	banksel	WORK
	btfss	WORK,5
	goto	ENDIF90
	banksel	SYSBITVAR0
	bsf	SYSBITVAR0,6
ENDIF90
HTTPPART1
;If Tcp_syn = 1 and Tcp_fin = 0 Then
	clrf	SysByteTempX
	banksel	SYSBITVAR0
	btfsc	SYSBITVAR0,2
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	movwf	SysTemp3
	clrf	SysByteTempX
	btfss	SYSBITVAR0,1
	comf	SysByteTempX,F
	movf	SysTemp3,W
	andwf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	btfss	SysTemp1,0
	goto	ENDIF80
;HSerPrint "syn&!fin"
	movlw	low StringTable69
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable69) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$

;ENC28j60_set_response_IPpacket
	pagesel	ENC28J60_SET_RESPONSE_IPPACKET
	call	ENC28J60_SET_RESPONSE_IPPACKET
	pagesel	$

;T_ip_destaddr0 = T_ip_srcaddr0
;T_ip_destaddr1 = T_ip_srcaddr1
;T_ip_destaddr2 = T_ip_srcaddr2
;T_ip_destaddr3 = T_ip_srcaddr3
;
;'Set source IP in IP header, pos 27
;T_ip_srcaddr0 = ENC_IpAddr(1)
;T_ip_srcaddr1 = ENC_IpAddr(2)
;T_ip_srcaddr2 = ENC_IpAddr(3)
;T_ip_srcaddr3 = ENC_IpAddr(4)
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
	pagesel	SWAP103
	call	SWAP103
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
	pagesel	SWAP103
	call	SWAP103
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
;etherbuffer(49) = 0x20
	movlw	32
	movwf	SYSETHERBUFFER_49
;etherbuffer(50) = 0x00
	clrf	SYSETHERBUFFER_50
;etherbuffer(60) = 0x01
	movlw	1
	movwf	SYSETHERBUFFER_60
;etherbuffer(61) = 0x01
	movlw	1
	movwf	SYSETHERBUFFER_61
;I_value16 = T_ip_vers_len And 0x0F
	movlw	15
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
	movwf	TT
;ENC28j60_Ip_header_checksum
	banksel	STATUS
	pagesel	ENC28J60_IP_HEADER_CHECKSUM
	call	ENC28J60_IP_HEADER_CHECKSUM
	pagesel	$

;ENC28j60_tcp_checksum
	pagesel	ENC28J60_TCP_CHECKSUM
	call	ENC28J60_TCP_CHECKSUM
	pagesel	$

;ENC28j60_writebuffer(tt)
	banksel	TT
	movf	TT,W
	banksel	PCKTLEN
	movwf	PCKTLEN
	clrf	PCKTLEN_H
	banksel	STATUS
	pagesel	ENC28J60_WRITEBUFFER
	call	ENC28J60_WRITEBUFFER
	pagesel	$

;ENC28j60_packetsend(tt)
	banksel	TT
	movf	TT,W
	banksel	PCKTLEN
	movwf	PCKTLEN
	clrf	PCKTLEN_H
	banksel	STATUS
	pagesel	ENC28J60_PACKETSEND
	call	ENC28J60_PACKETSEND
	pagesel	$

;Ackpsh = 0
	clrf	ACKPSH
;End If
ENDIF80
HTTPPART2
;' If an ACK and PSH is received and the destination port address is valid
;If Tcp_ack = 1 Then
	banksel	SYSBITVAR0
	btfss	SYSBITVAR0,5
	goto	ENDIF81
;if Tcp_fin = 0 then
	btfsc	SYSBITVAR0,1
	goto	ENDIF83
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
;T_ip_srcaddr0 = ENC_IpAddr(1)
	banksel	SYSENC_IPADDR_1
	movf	SYSENC_IPADDR_1,W
	banksel	SYSETHERBUFFER_27
	movwf	SYSETHERBUFFER_27
;T_ip_srcaddr1 = ENC_IpAddr(2)
	banksel	SYSENC_IPADDR_2
	movf	SYSENC_IPADDR_2,W
	banksel	SYSETHERBUFFER_28
	movwf	SYSETHERBUFFER_28
;T_ip_srcaddr2 = ENC_IpAddr(3)
	banksel	SYSENC_IPADDR_3
	movf	SYSENC_IPADDR_3,W
	banksel	SYSETHERBUFFER_29
	movwf	SYSETHERBUFFER_29
;T_ip_srcaddr3 = ENC_IpAddr(4)
	banksel	SYSENC_IPADDR_4
	movf	SYSENC_IPADDR_4,W
	banksel	SYSETHERBUFFER_30
	movwf	SYSETHERBUFFER_30
;Swap Tcp_srcportl , Tcp_destportl
	movf	SYSETHERBUFFER_36,W
	movwf	SYSCALCTEMPA
	movf	SYSETHERBUFFER_38,W
	movwf	SYSCALCTEMPB
	banksel	STATUS
	pagesel	SWAP103
	call	SWAP103
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
	pagesel	SWAP103
	call	SWAP103
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
	movf	SysTemp1,W
	banksel	INCOMING_ACK
	addwf	INCOMING_ACK,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movf	SysTemp1_H,W
	banksel	INCOMING_ACK_H
	addwfc	INCOMING_ACK_H,W
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H
	movlw	0
	banksel	INCOMING_ACK_U
	addwfc	INCOMING_ACK_U,W
	banksel	SYSTEMP2_U
	movwf	SysTemp2_U
	movlw	0
	banksel	INCOMING_ACK_E
	addwfc	INCOMING_ACK_E,W
	banksel	SYSTEMP2_E
	movwf	SysTemp2_E
	movlw	40
	subwf	SysTemp2,W
	banksel	INCOMING_ACK
	movwf	INCOMING_ACK
	movlw	0
	banksel	SYSTEMP2_H
	subwfb	SysTemp2_H,W
	banksel	INCOMING_ACK_H
	movwf	INCOMING_ACK_H
	movlw	0
	banksel	SYSTEMP2_U
	subwfb	SysTemp2_U,W
	banksel	INCOMING_ACK_U
	movwf	INCOMING_ACK_U
	movlw	0
	banksel	SYSTEMP2_E
	subwfb	SysTemp2_E,W
	banksel	INCOMING_ACK_E
	movwf	INCOMING_ACK_E
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
ENDIF83
;If Tcp_psh = 1 Then
	banksel	SYSBITVAR0
	btfss	SYSBITVAR0,4
	goto	ENDIF84
;HSerPrint "ack&psh"
	movlw	low StringTable70
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable70) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$

;GET / HTTP/1.1
;HSerPrint T_ip_srcaddr0
	banksel	SYSETHERBUFFER_27
	movf	SYSETHERBUFFER_27,W
	banksel	SERPRINTVAL
	movwf	SERPRINTVAL
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT264
	call	HSERPRINT264
	pagesel	$

;HSerPrint "."
	movlw	low StringTable44
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable44) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;HSerPrint T_ip_srcaddr1
	banksel	SYSETHERBUFFER_28
	movf	SYSETHERBUFFER_28,W
	banksel	SERPRINTVAL
	movwf	SERPRINTVAL
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT264
	call	HSERPRINT264
	pagesel	$

;HSerPrint "."
	movlw	low StringTable44
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable44) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;HSerPrint T_ip_srcaddr2
	banksel	SYSETHERBUFFER_29
	movf	SYSETHERBUFFER_29,W
	banksel	SERPRINTVAL
	movwf	SERPRINTVAL
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT264
	call	HSERPRINT264
	pagesel	$

;HSerPrint "."
	movlw	low StringTable44
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable44) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;HSerPrint T_ip_srcaddr3
	banksel	SYSETHERBUFFER_30
	movf	SYSETHERBUFFER_30,W
	banksel	SERPRINTVAL
	movwf	SERPRINTVAL
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT264
	call	HSERPRINT264
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
;T_ip_srcaddr0 = ENC_IpAddr(1)
;T_ip_srcaddr1 = ENC_IpAddr(2)
;T_ip_srcaddr2 = ENC_IpAddr(3)
;T_ip_srcaddr3 = ENC_IpAddr(4)
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
	banksel	STATUS
	pagesel	HTTPCOMMANDLINE
	call	HTTPCOMMANDLINE
	pagesel	$

;etherBuffer(17) = 0
	banksel	SYSETHERBUFFER_17
	clrf	SYSETHERBUFFER_17
;etherBuffer(18) = 40
	movlw	40
	movwf	SYSETHERBUFFER_18
;'5 x 4 = 20 bytes
;etherBuffer(47) = 0x50
	movlw	80
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
	pagesel	$

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
ENDIF84
;End If
ENDIF81
;if Tcp_fin = 0  then
	banksel	SYSBITVAR0
	btfsc	SYSBITVAR0,1
	goto	ELSE82_1
;HTTPPart3
	banksel	STATUS
	pagesel	HTTPPART3
	call	HTTPPART3
	pagesel	$

;Else
	goto	ENDIF82
ELSE82_1
;HTTPPart4
	banksel	STATUS
	pagesel	HTTPPART4
	call	HTTPPART4
	pagesel	$

;end if
ENDIF82
	return

;********************************************************************************

;Overloaded signature: BYTE:
FN_READAD48
;ADPCH = ADReadPort
	movf	ADREADPORT,W
	banksel	ADPCH
	movwf	ADPCH
;***************************************
;Perform conversion
;LLReadAD 1
;'Configure ANSELA/B/C/D
;Select Case ADReadPort 'Configure ANSELA/B/C/D @DebugADC_H
;Case 0: Set ANSELA.0 On
SysSelect7Case1
	banksel	ADREADPORT
	movf	ADREADPORT,F
	btfss	STATUS, Z
	goto	SysSelect7Case2
	banksel	ANSELA
	bsf	ANSELA,0
;Case 1: Set ANSELA.1 On
	goto	SysSelectEnd7
SysSelect7Case2
	decf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect7Case3
	banksel	ANSELA
	bsf	ANSELA,1
;Case 2: Set ANSELA.2 On
	goto	SysSelectEnd7
SysSelect7Case3
	movlw	2
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect7Case4
	banksel	ANSELA
	bsf	ANSELA,2
;Case 3: Set ANSELA.3 On
	goto	SysSelectEnd7
SysSelect7Case4
	movlw	3
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect7Case5
	banksel	ANSELA
	bsf	ANSELA,3
;Case 4: Set ANSELA.4 ON
	goto	SysSelectEnd7
SysSelect7Case5
	movlw	4
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect7Case6
	banksel	ANSELA
	bsf	ANSELA,4
;Case 5: Set ANSELA.5 On
	goto	SysSelectEnd7
SysSelect7Case6
	movlw	5
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect7Case7
	banksel	ANSELA
	bsf	ANSELA,5
;Case 6: Set ANSELA.6 On
	goto	SysSelectEnd7
SysSelect7Case7
	movlw	6
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect7Case8
	banksel	ANSELA
	bsf	ANSELA,6
;Case 7: Set ANSELA.7 On
	goto	SysSelectEnd7
SysSelect7Case8
	movlw	7
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect7Case9
	banksel	ANSELA
	bsf	ANSELA,7
;Case 8: Set ANSELB.0 On
	goto	SysSelectEnd7
SysSelect7Case9
	movlw	8
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect7Case10
	banksel	ANSELB
	bsf	ANSELB,0
;Case 9: Set ANSELB.1 On
	goto	SysSelectEnd7
SysSelect7Case10
	movlw	9
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect7Case11
	banksel	ANSELB
	bsf	ANSELB,1
;Case 10: Set ANSELB.2 On
	goto	SysSelectEnd7
SysSelect7Case11
	movlw	10
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect7Case12
	banksel	ANSELB
	bsf	ANSELB,2
;Case 11: Set ANSELB.3 On
	goto	SysSelectEnd7
SysSelect7Case12
	movlw	11
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect7Case13
	banksel	ANSELB
	bsf	ANSELB,3
;Case 12: Set ANSELB.4 On
	goto	SysSelectEnd7
SysSelect7Case13
	movlw	12
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect7Case14
	banksel	ANSELB
	bsf	ANSELB,4
;Case 13: Set ANSELB.5 On
	goto	SysSelectEnd7
SysSelect7Case14
	movlw	13
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect7Case15
	banksel	ANSELB
	bsf	ANSELB,5
;Case 14: Set ANSELB.6 On
	goto	SysSelectEnd7
SysSelect7Case15
	movlw	14
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect7Case16
	banksel	ANSELB
	bsf	ANSELB,6
;Case 15: Set ANSELB.7 On
	goto	SysSelectEnd7
SysSelect7Case16
	movlw	15
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect7Case17
	banksel	ANSELB
	bsf	ANSELB,7
;Case 16: Set ANSELC.0 On
	goto	SysSelectEnd7
SysSelect7Case17
	movlw	16
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect7Case18
	banksel	ANSELC
	bsf	ANSELC,0
;Case 17: Set ANSELC.1 On
	goto	SysSelectEnd7
SysSelect7Case18
	movlw	17
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect7Case19
	banksel	ANSELC
	bsf	ANSELC,1
;Case 18: Set ANSELC.2 On
	goto	SysSelectEnd7
SysSelect7Case19
	movlw	18
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect7Case20
	banksel	ANSELC
	bsf	ANSELC,2
;Case 19: Set ANSELC.3 On
	goto	SysSelectEnd7
SysSelect7Case20
	movlw	19
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect7Case21
	banksel	ANSELC
	bsf	ANSELC,3
;Case 20: Set ANSELC.4 On
	goto	SysSelectEnd7
SysSelect7Case21
	movlw	20
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect7Case22
	banksel	ANSELC
	bsf	ANSELC,4
;Case 21: Set ANSELC.5 On
	goto	SysSelectEnd7
SysSelect7Case22
	movlw	21
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect7Case23
	banksel	ANSELC
	bsf	ANSELC,5
;Case 22: Set ANSELC.6 On
	goto	SysSelectEnd7
SysSelect7Case23
	movlw	22
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect7Case24
	banksel	ANSELC
	bsf	ANSELC,6
;Case 23: Set ANSELC.7 On
	goto	SysSelectEnd7
SysSelect7Case24
	movlw	23
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect7Case25
	banksel	ANSELC
	bsf	ANSELC,7
;Case 24: Set ANSELD.0 On
	goto	SysSelectEnd7
SysSelect7Case25
	movlw	24
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect7Case26
	banksel	ANSELD
	bsf	ANSELD,0
;Case 25: Set ANSELD.1 On
	goto	SysSelectEnd7
SysSelect7Case26
	movlw	25
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect7Case27
	banksel	ANSELD
	bsf	ANSELD,1
;Case 26: Set ANSELD.2 On
	goto	SysSelectEnd7
SysSelect7Case27
	movlw	26
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect7Case28
	banksel	ANSELD
	bsf	ANSELD,2
;Case 27: Set ANSELD.3 On
	goto	SysSelectEnd7
SysSelect7Case28
	movlw	27
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect7Case29
	banksel	ANSELD
	bsf	ANSELD,3
;Case 28: Set ANSELD.4 On
	goto	SysSelectEnd7
SysSelect7Case29
	movlw	28
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect7Case30
	banksel	ANSELD
	bsf	ANSELD,4
;Case 29: Set ANSELD.5 On
	goto	SysSelectEnd7
SysSelect7Case30
	movlw	29
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect7Case31
	banksel	ANSELD
	bsf	ANSELD,5
;Case 30: Set ANSELD.6 On
	goto	SysSelectEnd7
SysSelect7Case31
	movlw	30
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect7Case32
	banksel	ANSELD
	bsf	ANSELD,6
;Case 31: Set ANSELD.7 On
	goto	SysSelectEnd7
SysSelect7Case32
	movlw	31
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect7Case33
	banksel	ANSELD
	bsf	ANSELD,7
;Case 32: Set ANSELE.0 On
	goto	SysSelectEnd7
SysSelect7Case33
	movlw	32
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect7Case34
	banksel	ANSELE
	bsf	ANSELE,0
;Case 33: Set ANSELE.1 On
	goto	SysSelectEnd7
SysSelect7Case34
	movlw	33
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect7Case35
	banksel	ANSELE
	bsf	ANSELE,1
;Case 34: Set ANSELE.2 On
	goto	SysSelectEnd7
SysSelect7Case35
	movlw	34
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect7Case36
	banksel	ANSELE
	bsf	ANSELE,2
;End Select  '*** ANSEL Bits should now be set ***
SysSelect7Case36
SysSelectEnd7
;Set ADCS off 'Clock source = FOSC/ADCLK
	banksel	ADCON0
	bcf	ADCON0,ADCS
;ADCLK = 1 ' default to FOSC/2
	movlw	1
	movwf	ADCLK
;SET ADCS OFF  'ADCON0.4
	bcf	ADCON0,ADCS
;ADCLK = 15    'FOSC/16
	movlw	15
	movwf	ADCLK
;if ADLeftadjust = 0 then
;Set ADCON.2 off     '8-bit
	banksel	ADCON
	bcf	ADCON,2
;End if
;ADCPH = ADReadPort  'Configure AD read Channel
	movf	ADREADPORT,W
	movwf	ADCPH
;SET ADCON0.ADON ON
	banksel	ADCON0
	bsf	ADCON0,ADON
;Wait AD_Delay
	movlw	2
	movwf	SysWaitTemp10US
	banksel	STATUS
	pagesel	Delay_10US
	call	Delay_10US
	pagesel	$
;SET ADCON0.GO_NOT_DONE ON
	banksel	ADCON0
	bsf	ADCON0,GO_NOT_DONE
;nop
	nop
;Wait While ADCON0.GO_NOT_DONE ON
SysWaitLoop18
	btfsc	ADCON0,GO_NOT_DONE
	goto	SysWaitLoop18
;SET ADCON0.ADON OFF
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

;ReadAD = ADRESH
	banksel	ADRESH
	movf	ADRESH,W
	movwf	READAD
	banksel	STATUS
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
	retlw	52	;4
	retlw	48	;0


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


StringTable7
	retlw	16
	retlw	80	;P
	retlw	114	;r
	retlw	111	;o
	retlw	103	;g
	retlw	114	;r
	retlw	97	;a
	retlw	109	;m
	retlw	32	; 
	retlw	83	;S
	retlw	116	;t
	retlw	97	;a
	retlw	114	;r
	retlw	116	;t
	retlw	101	;e
	retlw	100	;d
	retlw	32	; 


StringTable10
	retlw	1
	retlw	82	;R


StringTable11
	retlw	1
	retlw	68	;D


StringTable12
	retlw	1
	retlw	84	;T


StringTable20
	retlw	1
	retlw	47	;/


StringTable21
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


StringTable23
	retlw	10
	retlw	82	;R
	retlw	69	;E
	retlw	70	;F
	retlw	82	;R
	retlw	69	;E
	retlw	83	;S
	retlw	72	;H
	retlw	58	;:
	retlw	32	; 
	retlw	53	;5


StringTable24
	retlw	0


StringTable25
	retlw	27
	retlw	60	;<
	retlw	104	;h
	retlw	116	;t
	retlw	109	;m
	retlw	108	;l
	retlw	62	;>
	retlw	60	;<
	retlw	102	;f
	retlw	111	;o
	retlw	110	;n
	retlw	116	;t
	retlw	32	; 
	retlw	102	;f
	retlw	97	;a
	retlw	99	;c
	retlw	101	;e
	retlw	61	; (equals)
	retlw	104	;h
	retlw	101	;e
	retlw	108	;l
	retlw	118	;v
	retlw	101	;e
	retlw	116	;t
	retlw	105	;i
	retlw	99	;c
	retlw	97	;a
	retlw	62	;>


StringTable26
	retlw	52
	retlw	60	;<
	retlw	105	;i
	retlw	109	;m
	retlw	103	;g
	retlw	32	; 
	retlw	97	;a
	retlw	108	;l
	retlw	116	;t
	retlw	61	; (equals)
	retlw	34	;"
	retlw	71	;G
	retlw	67	;C
	retlw	66	;B
	retlw	32	; 
	retlw	76	;L
	retlw	111	;o
	retlw	103	;g
	retlw	111	;o
	retlw	33	;!
	retlw	34	;"
	retlw	32	; 
	retlw	116	;t
	retlw	105	;i
	retlw	116	;t
	retlw	108	;l
	retlw	101	;e
	retlw	61	; (equals)
	retlw	34	;"
	retlw	71	;G
	retlw	114	;r
	retlw	101	;e
	retlw	97	;a
	retlw	116	;t
	retlw	32	; 
	retlw	67	;C
	retlw	111	;o
	retlw	119	;w
	retlw	32	; 
	retlw	66	;B
	retlw	65	;A
	retlw	83	;S
	retlw	73	;I
	retlw	67	;C
	retlw	32	; 
	retlw	118	;v
	retlw	48	;0
	retlw	46	;.
	retlw	48	;0
	retlw	52	;4
	retlw	48	;0
	retlw	34	;"
	retlw	32	; 


StringTable27
	retlw	39
	retlw	115	;s
	retlw	114	;r
	retlw	99	;c
	retlw	61	; (equals)
	retlw	34	;"
	retlw	104	;h
	retlw	116	;t
	retlw	116	;t
	retlw	112	;p
	retlw	58	;:
	retlw	47	;/
	retlw	47	;/
	retlw	103	;g
	retlw	111	;o
	retlw	111	;o
	retlw	46	;.
	retlw	103	;g
	retlw	108	;l
	retlw	47	;/
	retlw	70	;F
	retlw	90	;Z
	retlw	52	;4
	retlw	118	;v
	retlw	52	;4
	retlw	101	;e
	retlw	34	;"
	retlw	32	; 
	retlw	104	;h
	retlw	101	;e
	retlw	105	;i
	retlw	103	;g
	retlw	104	;h
	retlw	116	;t
	retlw	61	; (equals)
	retlw	34	;"
	retlw	51	;3
	retlw	54	;6
	retlw	34	;"
	retlw	32	; 


StringTable28
	retlw	22
	retlw	119	;w
	retlw	105	;i
	retlw	100	;d
	retlw	116	;t
	retlw	104	;h
	retlw	61	; (equals)
	retlw	34	;"
	retlw	50	;2
	retlw	52	;4
	retlw	51	;3
	retlw	34	;"
	retlw	62	;>
	retlw	60	;<
	retlw	98	;b
	retlw	114	;r
	retlw	62	;>
	retlw	60	;<
	retlw	98	;b
	retlw	114	;r
	retlw	32	; 
	retlw	47	;/
	retlw	62	;>


StringTable29
	retlw	20
	retlw	38	;&
	retlw	110	;n
	retlw	98	;b
	retlw	115	;s
	retlw	112	;p
	retlw	59	;;
	retlw	38	;&
	retlw	110	;n
	retlw	98	;b
	retlw	115	;s
	retlw	112	;p
	retlw	59	;;
	retlw	69	;E
	retlw	118	;v
	retlw	97	;a
	retlw	110	;n
	retlw	32	; 
	retlw	105	;i
	retlw	115	;s
	retlw	32	; 


StringTable30
	retlw	4
	retlw	110	;n
	retlw	111	;o
	retlw	116	;t
	retlw	32	; 


StringTable31
	retlw	27
	retlw	32	; 
	retlw	105	;i
	retlw	110	;n
	retlw	32	; 
	retlw	116	;t
	retlw	104	;h
	retlw	101	;e
	retlw	32	; 
	retlw	108	;l
	retlw	97	;a
	retlw	98	;b
	retlw	32	; 
	retlw	97	;a
	retlw	116	;t
	retlw	32	; 
	retlw	116	;t
	retlw	104	;h
	retlw	101	;e
	retlw	32	; 
	retlw	109	;m
	retlw	111	;o
	retlw	109	;m
	retlw	101	;e
	retlw	110	;n
	retlw	116	;t
	retlw	46	;.
	retlw	46	;.


StringTable32
	retlw	62
	retlw	112	;p
	retlw	114	;r
	retlw	111	;o
	retlw	98	;b
	retlw	97	;a
	retlw	98	;b
	retlw	108	;l
	retlw	121	;y
	retlw	32	; 
	retlw	119	;w
	retlw	111	;o
	retlw	114	;r
	retlw	107	;k
	retlw	105	;i
	retlw	110	;n
	retlw	103	;g
	retlw	32	; 
	retlw	101	;e
	retlw	108	;l
	retlw	115	;s
	retlw	101	;e
	retlw	119	;w
	retlw	104	;h
	retlw	101	;e
	retlw	114	;r
	retlw	101	;e
	retlw	44	;,
	retlw	32	; 
	retlw	104	;h
	retlw	97	;a
	retlw	118	;v
	retlw	105	;i
	retlw	110	;n
	retlw	103	;g
	retlw	32	; 
	retlw	102	;f
	retlw	97	;a
	retlw	109	;m
	retlw	105	;i
	retlw	108	;l
	retlw	121	;y
	retlw	32	; 
	retlw	116	;t
	retlw	105	;i
	retlw	109	;m
	retlw	101	;e
	retlw	32	; 
	retlw	111	;o
	retlw	114	;r
	retlw	32	; 
	retlw	101	;e
	retlw	118	;v
	retlw	101	;e
	retlw	110	;n
	retlw	32	; 
	retlw	97	;a
	retlw	115	;s
	retlw	108	;l
	retlw	101	;e
	retlw	101	;e
	retlw	112	;p
	retlw	33	;!


StringTable33
	retlw	47
	retlw	112	;p
	retlw	114	;r
	retlw	111	;o
	retlw	98	;b
	retlw	97	;a
	retlw	98	;b
	retlw	108	;l
	retlw	121	;y
	retlw	32	; 
	retlw	119	;w
	retlw	111	;o
	retlw	114	;r
	retlw	107	;k
	retlw	105	;i
	retlw	110	;n
	retlw	103	;g
	retlw	32	; 
	retlw	111	;o
	retlw	110	;n
	retlw	32	; 
	retlw	97	;a
	retlw	32	; 
	retlw	71	;G
	retlw	114	;r
	retlw	101	;e
	retlw	97	;a
	retlw	116	;t
	retlw	32	; 
	retlw	67	;C
	retlw	111	;o
	retlw	119	;w
	retlw	32	; 
	retlw	66	;B
	retlw	65	;A
	retlw	83	;S
	retlw	73	;I
	retlw	67	;C
	retlw	32	; 
	retlw	115	;s
	retlw	111	;o
	retlw	108	;l
	retlw	117	;u
	retlw	116	;t
	retlw	105	;i
	retlw	111	;o
	retlw	110	;n
	retlw	33	;!


StringTable34
	retlw	12
	retlw	60	;<
	retlw	98	;b
	retlw	114	;r
	retlw	32	; 
	retlw	47	;/
	retlw	62	;>
	retlw	60	;<
	retlw	98	;b
	retlw	114	;r
	retlw	32	; 
	retlw	47	;/
	retlw	62	;>


StringTable35
	retlw	31
	retlw	38	;&
	retlw	110	;n
	retlw	98	;b
	retlw	115	;s
	retlw	112	;p
	retlw	59	;;
	retlw	38	;&
	retlw	110	;n
	retlw	98	;b
	retlw	115	;s
	retlw	112	;p
	retlw	59	;;
	retlw	65	;A
	retlw	110	;n
	retlw	97	;a
	retlw	108	;l
	retlw	111	;o
	retlw	103	;g
	retlw	32	; 
	retlw	105	;i
	retlw	110	;n
	retlw	112	;p
	retlw	117	;u
	retlw	116	;t
	retlw	115	;s
	retlw	32	; 
	retlw	97	;a
	retlw	114	;r
	retlw	101	;e
	retlw	58	;:
	retlw	32	; 


StringTable36
	retlw	6
	retlw	60	;<
	retlw	98	;b
	retlw	114	;r
	retlw	32	; 
	retlw	47	;/
	retlw	62	;>


StringTable37
	retlw	21
	retlw	60	;<
	retlw	98	;b
	retlw	114	;r
	retlw	32	; 
	retlw	47	;/
	retlw	62	;>
	retlw	38	;&
	retlw	110	;n
	retlw	98	;b
	retlw	115	;s
	retlw	112	;p
	retlw	59	;;
	retlw	38	;&
	retlw	110	;n
	retlw	98	;b
	retlw	115	;s
	retlw	112	;p
	retlw	59	;;
	retlw	65	;A
	retlw	68	;D
	retlw	67	;C


StringTable38
	retlw	2
	retlw	58	;:
	retlw	32	; 


StringTable39
	retlw	25
	retlw	38	;&
	retlw	110	;n
	retlw	98	;b
	retlw	115	;s
	retlw	112	;p
	retlw	59	;;
	retlw	38	;&
	retlw	110	;n
	retlw	98	;b
	retlw	115	;s
	retlw	112	;p
	retlw	80	;P
	retlw	111	;o
	retlw	114	;r
	retlw	116	;t
	retlw	115	;s
	retlw	32	; 
	retlw	65	;A
	retlw	58	;:
	retlw	38	;&
	retlw	110	;n
	retlw	98	;b
	retlw	115	;s
	retlw	112	;p
	retlw	59	;;


StringTable40
	retlw	20
	retlw	38	;&
	retlw	110	;n
	retlw	98	;b
	retlw	115	;s
	retlw	112	;p
	retlw	59	;;
	retlw	38	;&
	retlw	110	;n
	retlw	98	;b
	retlw	115	;s
	retlw	112	;p
	retlw	59	;;
	retlw	66	;B
	retlw	58	;:
	retlw	38	;&
	retlw	110	;n
	retlw	98	;b
	retlw	115	;s
	retlw	112	;p
	retlw	59	;;


StringTable41
	retlw	20
	retlw	38	;&
	retlw	110	;n
	retlw	98	;b
	retlw	115	;s
	retlw	112	;p
	retlw	59	;;
	retlw	38	;&
	retlw	110	;n
	retlw	98	;b
	retlw	115	;s
	retlw	112	;p
	retlw	59	;;
	retlw	67	;C
	retlw	58	;:
	retlw	38	;&
	retlw	110	;n
	retlw	98	;b
	retlw	115	;s
	retlw	112	;p
	retlw	59	;;


StringTable42
	retlw	20
	retlw	38	;&
	retlw	110	;n
	retlw	98	;b
	retlw	115	;s
	retlw	112	;p
	retlw	59	;;
	retlw	38	;&
	retlw	110	;n
	retlw	98	;b
	retlw	115	;s
	retlw	112	;p
	retlw	59	;;
	retlw	69	;E
	retlw	58	;:
	retlw	38	;&
	retlw	110	;n
	retlw	98	;b
	retlw	115	;s
	retlw	112	;p
	retlw	59	;;


StringTable43
	retlw	20
	retlw	38	;&
	retlw	110	;n
	retlw	98	;b
	retlw	115	;s
	retlw	112	;p
	retlw	59	;;
	retlw	38	;&
	retlw	110	;n
	retlw	98	;b
	retlw	115	;s
	retlw	112	;p
	retlw	59	;;
	retlw	83	;S
	retlw	111	;o
	retlw	117	;u
	retlw	114	;r
	retlw	99	;c
	retlw	101	;e
	retlw	58	;:
	retlw	32	; 


StringTable44
	retlw	1
	retlw	46	;.


StringTable45
	retlw	39
	retlw	60	;<
	retlw	105	;i
	retlw	109	;m
	retlw	103	;g
	retlw	32	; 
	retlw	97	;a
	retlw	108	;l
	retlw	116	;t
	retlw	61	; (equals)
	retlw	34	;"
	retlw	76	;L
	retlw	97	;a
	retlw	98	;b
	retlw	34	;"
	retlw	32	; 
	retlw	116	;t
	retlw	105	;i
	retlw	116	;t
	retlw	108	;l
	retlw	101	;e
	retlw	61	; (equals)
	retlw	34	;"
	retlw	71	;G
	retlw	114	;r
	retlw	101	;e
	retlw	97	;a
	retlw	116	;t
	retlw	32	; 
	retlw	67	;C
	retlw	111	;o
	retlw	119	;w
	retlw	32	; 
	retlw	66	;B
	retlw	65	;A
	retlw	83	;S
	retlw	73	;I
	retlw	67	;C
	retlw	34	;"
	retlw	32	; 


StringTable46
	retlw	52
	retlw	115	;s
	retlw	114	;r
	retlw	99	;c
	retlw	61	; (equals)
	retlw	34	;"
	retlw	104	;h
	retlw	116	;t
	retlw	116	;t
	retlw	112	;p
	retlw	58	;:
	retlw	47	;/
	retlw	47	;/
	retlw	103	;g
	retlw	111	;o
	retlw	111	;o
	retlw	46	;.
	retlw	103	;g
	retlw	108	;l
	retlw	47	;/
	retlw	121	;y
	retlw	78	;N
	retlw	103	;g
	retlw	53	;5
	retlw	84	;T
	retlw	114	;r
	retlw	34	;"
	retlw	32	; 
	retlw	104	;h
	retlw	101	;e
	retlw	105	;i
	retlw	103	;g
	retlw	104	;h
	retlw	116	;t
	retlw	61	; (equals)
	retlw	34	;"
	retlw	50	;2
	retlw	49	;1
	retlw	55	;7
	retlw	34	;"
	retlw	32	; 
	retlw	119	;w
	retlw	105	;i
	retlw	100	;d
	retlw	116	;t
	retlw	104	;h
	retlw	61	; (equals)
	retlw	34	;"
	retlw	51	;3
	retlw	56	;8
	retlw	54	;6
	retlw	34	;"
	retlw	32	; 


StringTable47
	retlw	52
	retlw	115	;s
	retlw	114	;r
	retlw	99	;c
	retlw	61	; (equals)
	retlw	34	;"
	retlw	104	;h
	retlw	116	;t
	retlw	116	;t
	retlw	112	;p
	retlw	58	;:
	retlw	47	;/
	retlw	47	;/
	retlw	103	;g
	retlw	111	;o
	retlw	111	;o
	retlw	46	;.
	retlw	103	;g
	retlw	108	;l
	retlw	47	;/
	retlw	78	;N
	retlw	85	;U
	retlw	79	;O
	retlw	70	;F
	retlw	87	;W
	retlw	117	;u
	retlw	34	;"
	retlw	32	; 
	retlw	104	;h
	retlw	101	;e
	retlw	105	;i
	retlw	103	;g
	retlw	104	;h
	retlw	116	;t
	retlw	61	; (equals)
	retlw	34	;"
	retlw	52	;4
	retlw	50	;2
	retlw	52	;4
	retlw	34	;"
	retlw	32	; 
	retlw	119	;w
	retlw	105	;i
	retlw	100	;d
	retlw	116	;t
	retlw	104	;h
	retlw	61	; (equals)
	retlw	34	;"
	retlw	50	;2
	retlw	51	;3
	retlw	57	;9
	retlw	34	;"
	retlw	32	; 


StringTable48
	retlw	11
	retlw	62	;>
	retlw	60	;<
	retlw	98	;b
	retlw	114	;r
	retlw	62	;>
	retlw	60	;<
	retlw	98	;b
	retlw	114	;r
	retlw	32	; 
	retlw	47	;/
	retlw	62	;>


StringTable49
	retlw	7
	retlw	60	;<
	retlw	47	;/
	retlw	104	;h
	retlw	116	;t
	retlw	109	;m
	retlw	108	;l
	retlw	62	;>


StringTable60
	retlw	1
	retlw	33	;!


StringTable62
	retlw	1
	retlw	44	;,


StringTable69
	retlw	8
	retlw	115	;s
	retlw	121	;y
	retlw	110	;n
	retlw	38	;&
	retlw	33	;!
	retlw	102	;f
	retlw	105	;i
	retlw	110	;n


StringTable70
	retlw	7
	retlw	97	;a
	retlw	99	;c
	retlw	107	;k
	retlw	38	;&
	retlw	112	;p
	retlw	115	;s
	retlw	104	;h


StringTable72
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


StringTable73
	retlw	1
	retlw	48	;0


StringTable78
	retlw	1
	retlw	32	; 


StringTable85
	retlw	14
	retlw	82	;R
	retlw	101	;e
	retlw	103	;g
	retlw	105	;i
	retlw	115	;s
	retlw	116	;t
	retlw	101	;e
	retlw	114	;r
	retlw	100	;d
	retlw	117	;u
	retlw	109	;m
	retlw	112	;p
	retlw	58	;:
	retlw	32	; 


StringTable86
	retlw	42
	retlw	67	;C
	retlw	110	;n
	retlw	116	;t
	retlw	114	;r
	retlw	108	;l
	retlw	58	;:
	retlw	32	; 
	retlw	69	;E
	retlw	67	;C
	retlw	79	;O
	retlw	78	;N
	retlw	49	;1
	retlw	32	; 
	retlw	69	;E
	retlw	67	;C
	retlw	79	;O
	retlw	78	;N
	retlw	50	;2
	retlw	32	; 
	retlw	69	;E
	retlw	83	;S
	retlw	84	;T
	retlw	65	;A
	retlw	84	;T
	retlw	32	; 
	retlw	32	; 
	retlw	69	;E
	retlw	73	;I
	retlw	82	;R
	retlw	32	; 
	retlw	32	; 
	retlw	69	;E
	retlw	73	;I
	retlw	69	;E
	retlw	32	; 
	retlw	32	; 
	retlw	69	;E
	retlw	82	;R
	retlw	69	;E
	retlw	86	;V
	retlw	73	;I
	retlw	68	;D


StringTable87
	retlw	7
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 


StringTable88
	retlw	4
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 


StringTable89
	retlw	5
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 


StringTable90
	retlw	3
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 


StringTable91
	retlw	42
	retlw	77	;M
	retlw	65	;A
	retlw	67	;C
	retlw	32	; 
	retlw	32	; 
	retlw	58	;:
	retlw	32	; 
	retlw	77	;M
	retlw	65	;A
	retlw	67	;C
	retlw	79	;O
	retlw	78	;N
	retlw	49	;1
	retlw	32	; 
	retlw	32	; 
	retlw	77	;M
	retlw	65	;A
	retlw	67	;C
	retlw	79	;O
	retlw	78	;N
	retlw	51	;3
	retlw	32	; 
	retlw	32	; 
	retlw	77	;M
	retlw	65	;A
	retlw	67	;C
	retlw	79	;O
	retlw	78	;N
	retlw	52	;4
	retlw	32	; 
	retlw	32	; 
	retlw	77	;M
	retlw	65	;A
	retlw	67	;C
	retlw	45	;-
	retlw	65	;A
	retlw	100	;d
	retlw	100	;d
	retlw	114	;r
	retlw	101	;e
	retlw	115	;s
	retlw	115	;s


StringTable92
	retlw	6
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 


StringTable93
	retlw	1
	retlw	58	;:


StringTable94
	retlw	59
	retlw	82	;R
	retlw	120	;x
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	58	;:
	retlw	32	; 
	retlw	69	;E
	retlw	82	;R
	retlw	88	;X
	retlw	83	;S
	retlw	84	;T
	retlw	32	; 
	retlw	32	; 
	retlw	69	;E
	retlw	82	;R
	retlw	88	;X
	retlw	78	;N
	retlw	68	;D
	retlw	32	; 
	retlw	32	; 
	retlw	69	;E
	retlw	82	;R
	retlw	88	;X
	retlw	87	;W
	retlw	82	;R
	retlw	80	;P
	retlw	84	;T
	retlw	32	; 
	retlw	69	;E
	retlw	82	;R
	retlw	88	;X
	retlw	82	;R
	retlw	68	;D
	retlw	80	;P
	retlw	84	;T
	retlw	32	; 
	retlw	69	;E
	retlw	82	;R
	retlw	88	;X
	retlw	70	;F
	retlw	67	;C
	retlw	79	;O
	retlw	78	;N
	retlw	32	; 
	retlw	69	;E
	retlw	80	;P
	retlw	75	;K
	retlw	84	;T
	retlw	67	;C
	retlw	78	;N
	retlw	84	;T
	retlw	32	; 
	retlw	77	;M
	retlw	65	;A
	retlw	77	;M
	retlw	88	;X
	retlw	70	;F
	retlw	76	;L


StringTable95
	retlw	45
	retlw	84	;T
	retlw	120	;x
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	58	;:
	retlw	32	; 
	retlw	69	;E
	retlw	84	;T
	retlw	88	;X
	retlw	83	;S
	retlw	84	;T
	retlw	32	; 
	retlw	32	; 
	retlw	69	;E
	retlw	84	;T
	retlw	88	;X
	retlw	78	;N
	retlw	68	;D
	retlw	32	; 
	retlw	32	; 
	retlw	69	;E
	retlw	87	;W
	retlw	82	;R
	retlw	80	;P
	retlw	84	;T
	retlw	32	; 
	retlw	32	; 
	retlw	77	;M
	retlw	65	;A
	retlw	67	;C
	retlw	76	;L
	retlw	67	;C
	retlw	79	;O
	retlw	78	;N
	retlw	49	;1
	retlw	32	; 
	retlw	77	;M
	retlw	65	;A
	retlw	67	;C
	retlw	76	;L
	retlw	67	;C
	retlw	79	;O
	retlw	78	;N
	retlw	50	;2


StringTable96
	retlw	4
	retlw	68	;D
	retlw	97	;a
	retlw	121	;y
	retlw	32	; 


StringTable97
	retlw	5
	retlw	84	;T
	retlw	105	;i
	retlw	109	;m
	retlw	101	;e
	retlw	32	; 


StringTable98
	retlw	13
	retlw	97	;a
	retlw	99	;c
	retlw	107	;k
	retlw	38	;&
	retlw	97	;a
	retlw	99	;c
	retlw	107	;k
	retlw	112	;p
	retlw	117	;u
	retlw	115	;s
	retlw	104	;h
	retlw	61	; (equals)
	retlw	49	;1


StringTable103
	retlw	7
	retlw	97	;a
	retlw	99	;c
	retlw	107	;k
	retlw	38	;&
	retlw	102	;f
	retlw	105	;i
	retlw	110	;n


StringTable104
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


StringTable105
	retlw	16
	retlw	101	;e
	retlw	109	;m
	retlw	112	;p
	retlw	116	;t
	retlw	121	;y
	retlw	32	; 
	retlw	116	;t
	retlw	104	;h
	retlw	101	;e
	retlw	32	; 
	retlw	98	;b
	retlw	117	;u
	retlw	102	;f
	retlw	102	;f
	retlw	101	;e
	retlw	114	;r


StringTable106
	retlw	7
	retlw	32	; 
	retlw	32	; 
	retlw	80	;P
	retlw	65	;A
	retlw	68	;D
	retlw	33	;!
	retlw	32	; 


StringTable107
	retlw	5
	retlw	83	;S
	retlw	101	;e
	retlw	110	;n
	retlw	100	;d
	retlw	58	;:


StringTable108
	retlw	7
	retlw	66	;B
	retlw	47	;/
	retlw	87	;W
	retlw	105	;i
	retlw	114	;r
	retlw	101	;e
	retlw	58	;:


StringTable109
	retlw	10
	retlw	44	;,
	retlw	32	; 
	retlw	84	;T
	retlw	67	;C
	retlw	80	;P
	retlw	32	; 
	retlw	80	;P
	retlw	107	;k
	retlw	116	;t
	retlw	58	;:


StringTable110
	retlw	7
	retlw	44	;,
	retlw	32	; 
	retlw	72	;H
	retlw	84	;T
	retlw	77	;M
	retlw	76	;L
	retlw	58	;:


StringTable111
	retlw	5
	retlw	71	;G
	retlw	69	;E
	retlw	84	;T
	retlw	32	; 
	retlw	47	;/


StringTable112
	retlw	6
	retlw	32	; 
	retlw	72	;H
	retlw	84	;T
	retlw	84	;T
	retlw	80	;P
	retlw	47	;/


StringTable113
	retlw	3
	retlw	52	;4
	retlw	48	;0
	retlw	48	;0


StringTable134
	retlw	1
	retlw	49	;1


;********************************************************************************

;Start of program memory page 2
	ORG	4096
ENC28J60_SNTP_HANDLER
;DIM L2 AS long
;Epoch_seconds = T_udp_data3
	banksel	SYSETHERBUFFER_46
	movf	SYSETHERBUFFER_46,W
	banksel	EPOCH_SECONDS
	movwf	EPOCH_SECONDS
	clrf	EPOCH_SECONDS_H
	clrf	EPOCH_SECONDS_U
	clrf	EPOCH_SECONDS_E
;Epoch_seconds_H = T_udp_data2
	banksel	SYSETHERBUFFER_45
	movf	SYSETHERBUFFER_45,W
	banksel	EPOCH_SECONDS_H
	movwf	EPOCH_SECONDS_H
;Epoch_seconds_U = T_udp_data1
	banksel	SYSETHERBUFFER_44
	movf	SYSETHERBUFFER_44,W
	banksel	EPOCH_SECONDS_U
	movwf	EPOCH_SECONDS_U
;Epoch_seconds_E   = T_udp_data0
	banksel	SYSETHERBUFFER_43
	movf	SYSETHERBUFFER_43,W
	banksel	EPOCH_SECONDS_E
	movwf	EPOCH_SECONDS_E
;Epoch_seconds = Epoch_seconds - [Long]3660595200  'ADJUSTS TIME TO 1/1/2016
	movlw	0
	subwf	EPOCH_SECONDS,F
	movlw	64
	subwfb	EPOCH_SECONDS_H,F
	movlw	48
	subwfb	EPOCH_SECONDS_U,F
	movlw	218
	subwfb	EPOCH_SECONDS_E,F
;HserPrint "Day "
	movlw	low StringTable96
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable96) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;l2 = ( Epoch_seconds / 86400 ) + 1
	movf	EPOCH_SECONDS,W
	movwf	SysLONGTempA
	movf	EPOCH_SECONDS_H,W
	movwf	SysLONGTempA_H
	movf	EPOCH_SECONDS_U,W
	movwf	SysLONGTempA_U
	movf	EPOCH_SECONDS_E,W
	movwf	SysLONGTempA_E
	movlw	128
	movwf	SysLONGTempB
	movlw	81
	movwf	SysLONGTempB_H
	movlw	1
	movwf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	pagesel	SysDivSub32
	call	SysDivSub32
	pagesel	$
	movf	SysLONGTempA,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movf	SysLONGTempA_H,W
	movwf	SysTemp1_H
	movf	SysLONGTempA_U,W
	movwf	SysTemp1_U
	movf	SysLONGTempA_E,W
	movwf	SysTemp1_E
	movlw	1
	addwf	SysTemp1,W
	banksel	L2
	movwf	L2
	movlw	0
	banksel	SYSTEMP1_H
	addwfc	SysTemp1_H,W
	banksel	L2_H
	movwf	L2_H
	movlw	0
	banksel	SYSTEMP1_U
	addwfc	SysTemp1_U,W
	banksel	L2_U
	movwf	L2_U
	movlw	0
	banksel	SYSTEMP1_E
	addwfc	SysTemp1_E,W
	banksel	L2_E
	movwf	L2_E
;l2 = l2 *100
	movf	L2,W
	movwf	SysLONGTempA
	movf	L2_H,W
	movwf	SysLONGTempA_H
	movf	L2_U,W
	movwf	SysLONGTempA_U
	movf	L2_E,W
	movwf	SysLONGTempA_E
	movlw	100
	movwf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SysMultSub32
	call	SysMultSub32
	pagesel	$
	movf	SysLONGTempX,W
	banksel	L2
	movwf	L2
	movf	SysLONGTempX_H,W
	movwf	L2_H
	movf	SysLONGTempX_U,W
	movwf	L2_U
	movf	SysLONGTempX_E,W
	movwf	L2_E
;l2 = l2 % 36525
	movf	L2,W
	movwf	SysLONGTempA
	movf	L2_H,W
	movwf	SysLONGTempA_H
	movf	L2_U,W
	movwf	SysLONGTempA_U
	movf	L2_E,W
	movwf	SysLONGTempA_E
	movlw	173
	movwf	SysLONGTempB
	movlw	142
	movwf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SysDivSub32
	call	SysDivSub32
	pagesel	$
	movf	SysLONGTempX,W
	banksel	L2
	movwf	L2
	movf	SysLONGTempX_H,W
	movwf	L2_H
	movf	SysLONGTempX_U,W
	movwf	L2_U
	movf	SysLONGTempX_E,W
	movwf	L2_E
;l2 = l2 /100
	movf	L2,W
	movwf	SysLONGTempA
	movf	L2_H,W
	movwf	SysLONGTempA_H
	movf	L2_U,W
	movwf	SysLONGTempA_U
	movf	L2_E,W
	movwf	SysLONGTempA_E
	movlw	100
	movwf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SysDivSub32
	call	SysDivSub32
	pagesel	$
	movf	SysLONGTempA,W
	banksel	L2
	movwf	L2
	movf	SysLONGTempA_H,W
	movwf	L2_H
	movf	SysLONGTempA_U,W
	movwf	L2_U
	movf	SysLONGTempA_E,W
	movwf	L2_E
;HSerPrint l2
	movf	L2,W
	movwf	SERPRINTVAL
	movf	L2_H,W
	movwf	SERPRINTVAL_H
	movf	L2_U,W
	movwf	SERPRINTVAL_U
	movf	L2_E,W
	movwf	SERPRINTVAL_E
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT267
	call	HSERPRINT267
	pagesel	$

;l2 = Epoch_seconds / 31536000  ' CALC year
	movf	EPOCH_SECONDS,W
	movwf	SysLONGTempA
	movf	EPOCH_SECONDS_H,W
	movwf	SysLONGTempA_H
	movf	EPOCH_SECONDS_U,W
	movwf	SysLONGTempA_U
	movf	EPOCH_SECONDS_E,W
	movwf	SysLONGTempA_E
	movlw	128
	movwf	SysLONGTempB
	movlw	51
	movwf	SysLONGTempB_H
	movlw	225
	movwf	SysLONGTempB_U
	movlw	1
	movwf	SysLONGTempB_E
	pagesel	SysDivSub32
	call	SysDivSub32
	pagesel	$
	movf	SysLONGTempA,W
	banksel	L2
	movwf	L2
	movf	SysLONGTempA_H,W
	movwf	L2_H
	movf	SysLONGTempA_U,W
	movwf	L2_U
	movf	SysLONGTempA_E,W
	movwf	L2_E
;l2 = l2 + 2016
	movlw	224
	addwf	L2,F
	movlw	7
	addwfc	L2_H,F
	movlw	0
	addwfc	L2_U,F
	movlw	0
	addwfc	L2_E,F
;HSerPrint "/"
	movlw	low StringTable20
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable20) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;HSerPrint l2
	banksel	L2
	movf	L2,W
	movwf	SERPRINTVAL
	movf	L2_H,W
	movwf	SERPRINTVAL_H
	movf	L2_U,W
	movwf	SERPRINTVAL_U
	movf	L2_E,W
	movwf	SERPRINTVAL_E
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT267
	call	HSERPRINT267
	pagesel	$

;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$

;HserPrint "Time "
	movlw	low StringTable97
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable97) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;l2 = Epoch_seconds % 86400
	movf	EPOCH_SECONDS,W
	movwf	SysLONGTempA
	movf	EPOCH_SECONDS_H,W
	movwf	SysLONGTempA_H
	movf	EPOCH_SECONDS_U,W
	movwf	SysLONGTempA_U
	movf	EPOCH_SECONDS_E,W
	movwf	SysLONGTempA_E
	movlw	128
	movwf	SysLONGTempB
	movlw	81
	movwf	SysLONGTempB_H
	movlw	1
	movwf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	pagesel	SysDivSub32
	call	SysDivSub32
	pagesel	$
	movf	SysLONGTempX,W
	banksel	L2
	movwf	L2
	movf	SysLONGTempX_H,W
	movwf	L2_H
	movf	SysLONGTempX_U,W
	movwf	L2_U
	movf	SysLONGTempX_E,W
	movwf	L2_E
;l2 = l2 / 3600
	movf	L2,W
	movwf	SysLONGTempA
	movf	L2_H,W
	movwf	SysLONGTempA_H
	movf	L2_U,W
	movwf	SysLONGTempA_U
	movf	L2_E,W
	movwf	SysLONGTempA_E
	movlw	16
	movwf	SysLONGTempB
	movlw	14
	movwf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SysDivSub32
	call	SysDivSub32
	pagesel	$
	movf	SysLONGTempA,W
	banksel	L2
	movwf	L2
	movf	SysLONGTempA_H,W
	movwf	L2_H
	movf	SysLONGTempA_U,W
	movwf	L2_U
	movf	SysLONGTempA_E,W
	movwf	L2_E
;if l2 < 10 then HSerPrint "0"
	movf	L2,W
	movwf	SysLONGTempA
	movf	L2_H,W
	movwf	SysLONGTempA_H
	movf	L2_U,W
	movwf	SysLONGTempA_U
	movf	L2_E,W
	movwf	SysLONGTempA_E
	movlw	10
	movwf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF61
	movlw	low StringTable73
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable73) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

ENDIF61
;HSerPrint l2
	banksel	L2
	movf	L2,W
	movwf	SERPRINTVAL
	movf	L2_H,W
	movwf	SERPRINTVAL_H
	movf	L2_U,W
	movwf	SERPRINTVAL_U
	movf	L2_E,W
	movwf	SERPRINTVAL_E
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT267
	call	HSERPRINT267
	pagesel	$

;HSerPrint ":"
	movlw	low StringTable93
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable93) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;l2 = Epoch_seconds % 3600
	movf	EPOCH_SECONDS,W
	movwf	SysLONGTempA
	movf	EPOCH_SECONDS_H,W
	movwf	SysLONGTempA_H
	movf	EPOCH_SECONDS_U,W
	movwf	SysLONGTempA_U
	movf	EPOCH_SECONDS_E,W
	movwf	SysLONGTempA_E
	movlw	16
	movwf	SysLONGTempB
	movlw	14
	movwf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	pagesel	SysDivSub32
	call	SysDivSub32
	pagesel	$
	movf	SysLONGTempX,W
	banksel	L2
	movwf	L2
	movf	SysLONGTempX_H,W
	movwf	L2_H
	movf	SysLONGTempX_U,W
	movwf	L2_U
	movf	SysLONGTempX_E,W
	movwf	L2_E
;l2 = l2 / 60
	movf	L2,W
	movwf	SysLONGTempA
	movf	L2_H,W
	movwf	SysLONGTempA_H
	movf	L2_U,W
	movwf	SysLONGTempA_U
	movf	L2_E,W
	movwf	SysLONGTempA_E
	movlw	60
	movwf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SysDivSub32
	call	SysDivSub32
	pagesel	$
	movf	SysLONGTempA,W
	banksel	L2
	movwf	L2
	movf	SysLONGTempA_H,W
	movwf	L2_H
	movf	SysLONGTempA_U,W
	movwf	L2_U
	movf	SysLONGTempA_E,W
	movwf	L2_E
;if l2 < 10 then HSerPrint "0"
	movf	L2,W
	movwf	SysLONGTempA
	movf	L2_H,W
	movwf	SysLONGTempA_H
	movf	L2_U,W
	movwf	SysLONGTempA_U
	movf	L2_E,W
	movwf	SysLONGTempA_E
	movlw	10
	movwf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF62
	movlw	low StringTable73
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable73) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

ENDIF62
;HSerPrint l2
	banksel	L2
	movf	L2,W
	movwf	SERPRINTVAL
	movf	L2_H,W
	movwf	SERPRINTVAL_H
	movf	L2_U,W
	movwf	SERPRINTVAL_U
	movf	L2_E,W
	movwf	SERPRINTVAL_E
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT267
	call	HSERPRINT267
	pagesel	$

;l2 = Epoch_seconds % [LONG]60
	movf	EPOCH_SECONDS,W
	movwf	SysLONGTempA
	movf	EPOCH_SECONDS_H,W
	movwf	SysLONGTempA_H
	movf	EPOCH_SECONDS_U,W
	movwf	SysLONGTempA_U
	movf	EPOCH_SECONDS_E,W
	movwf	SysLONGTempA_E
	movlw	60
	movwf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	pagesel	SysDivSub32
	call	SysDivSub32
	pagesel	$
	movf	SysLONGTempX,W
	banksel	L2
	movwf	L2
	movf	SysLONGTempX_H,W
	movwf	L2_H
	movf	SysLONGTempX_U,W
	movwf	L2_U
	movf	SysLONGTempX_E,W
	movwf	L2_E
;HSerPrint ":"
	movlw	low StringTable93
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable93) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;if l2 < 10 then HSerPrint "0"
	banksel	L2
	movf	L2,W
	movwf	SysLONGTempA
	movf	L2_H,W
	movwf	SysLONGTempA_H
	movf	L2_U,W
	movwf	SysLONGTempA_U
	movf	L2_E,W
	movwf	SysLONGTempA_E
	movlw	10
	movwf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF63
	movlw	low StringTable73
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable73) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

ENDIF63
;HSerPrint l2
	banksel	L2
	movf	L2,W
	movwf	SERPRINTVAL
	movf	L2_H,W
	movwf	SERPRINTVAL_H
	movf	L2_U,W
	movwf	SERPRINTVAL_U
	movf	L2_E,W
	movwf	SERPRINTVAL_E
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT267
	call	HSERPRINT267
	pagesel	$

;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$

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
	movf	I_CHKSUM32,W
	addwf	I_VALUE16,W
	movwf	I_CHKSUM32
	movf	I_CHKSUM32_H,W
	addwfc	I_VALUE16_H,W
	movwf	I_CHKSUM32_H
	movlw	0
	banksel	SYSTEMP3
	movwf	SysTemp3
	banksel	I_CHKSUM32_U
	movf	I_CHKSUM32_U,W
	banksel	SYSTEMP3
	addwfc	SysTemp3,W
	banksel	I_CHKSUM32_U
	movwf	I_CHKSUM32_U
	movlw	0
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	I_CHKSUM32_E
	movf	I_CHKSUM32_E,W
	banksel	SYSTEMP1
	addwfc	SysTemp1,W
	banksel	I_CHKSUM32_E
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
	movf	I_CHKSUM32,W
	addwf	I_VALUE16,W
	movwf	I_CHKSUM32
	movf	I_CHKSUM32_H,W
	addwfc	I_VALUE16_H,W
	movwf	I_CHKSUM32_H
	movlw	0
	banksel	SYSTEMP3
	movwf	SysTemp3
	banksel	I_CHKSUM32_U
	movf	I_CHKSUM32_U,W
	banksel	SYSTEMP3
	addwfc	SysTemp3,W
	banksel	I_CHKSUM32_U
	movwf	I_CHKSUM32_U
	movlw	0
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	I_CHKSUM32_E
	movf	I_CHKSUM32_E,W
	banksel	SYSTEMP1
	addwfc	SysTemp1,W
	banksel	I_CHKSUM32_E
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
	movf	I_CHKSUM32,W
	addwf	I_VALUE16,W
	movwf	I_CHKSUM32
	movf	I_CHKSUM32_H,W
	addwfc	I_VALUE16_H,W
	movwf	I_CHKSUM32_H
	movlw	0
	banksel	SYSTEMP3
	movwf	SysTemp3
	banksel	I_CHKSUM32_U
	movf	I_CHKSUM32_U,W
	banksel	SYSTEMP3
	addwfc	SysTemp3,W
	banksel	I_CHKSUM32_U
	movwf	I_CHKSUM32_U
	movlw	0
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	I_CHKSUM32_E
	movf	I_CHKSUM32_E,W
	banksel	SYSTEMP1
	addwfc	SysTemp1,W
	banksel	I_CHKSUM32_E
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
	movf	I_CHKSUM32,W
	addwf	I_VALUE16,W
	movwf	I_CHKSUM32
	movf	I_CHKSUM32_H,W
	addwfc	I_VALUE16_H,W
	movwf	I_CHKSUM32_H
	movlw	0
	banksel	SYSTEMP3
	movwf	SysTemp3
	banksel	I_CHKSUM32_U
	movf	I_CHKSUM32_U,W
	banksel	SYSTEMP3
	addwfc	SysTemp3,W
	banksel	I_CHKSUM32_U
	movwf	I_CHKSUM32_U
	movlw	0
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	I_CHKSUM32_E
	movf	I_CHKSUM32_E,W
	banksel	SYSTEMP1
	addwfc	SysTemp1,W
	banksel	I_CHKSUM32_E
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
	subwf	I_CHKSUM32,F
	movf	I_VALUE16_H,W
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
	movf	I_CHKSUM32,W
	addwf	I_VALUE16,W
	movwf	I_CHKSUM32
	movf	I_CHKSUM32_H,W
	addwfc	I_VALUE16_H,W
	movwf	I_CHKSUM32_H
	movlw	0
	banksel	SYSTEMP3
	movwf	SysTemp3
	banksel	I_CHKSUM32_U
	movf	I_CHKSUM32_U,W
	banksel	SYSTEMP3
	addwfc	SysTemp3,W
	banksel	I_CHKSUM32_U
	movwf	I_CHKSUM32_U
	movlw	0
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	I_CHKSUM32_E
	movf	I_CHKSUM32_E,W
	banksel	SYSTEMP1
	addwfc	SysTemp1,W
	banksel	I_CHKSUM32_E
	movwf	I_CHKSUM32_E
;I_odd = I_value16 Mod 2
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
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	0
	banksel	I_VALUE16_H
	addwfc	I_VALUE16_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	movlw	22
	subwf	SysTemp1,W
	banksel	HULP2
	movwf	HULP2
	movlw	0
	banksel	SYSTEMP1_H
	subwfb	SysTemp1_H,W
	banksel	HULP2_H
	movwf	HULP2_H
;I_odd = T_udp_len1 Mod 2
	clrf	I_ODD
	banksel	SYSETHERBUFFER_40
	btfss	SYSETHERBUFFER_40,0
	goto	ENDIF94
	banksel	I_ODD
	incf	I_ODD,F
ENDIF94
;If I_odd = 1 Then
	banksel	I_ODD
	decf	I_ODD,W
	btfss	STATUS, Z
	goto	ENDIF91
;Hulp2 =  Hulp2 + 1
	incf	HULP2,F
	btfsc	STATUS,Z
	incf	HULP2_H,F
;etherbuffer( Hulp2 + 1 ) = 0x00
	movlw	low(ETHERBUFFER)
	addwf	HULP2,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(ETHERBUFFER)
	banksel	HULP2_H
	addwfc	HULP2_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	movlw	1
	addwf	SysTemp1,W
	movwf	AFSR0
	movlw	0
	addwfc	SysTemp1_H,W
	movwf	AFSR0_H
	clrf	INDF0
;End If
ENDIF91
;For I_x = 0x23 To Hulp2 Step 2
	movlw	33
	banksel	I_X
	movwf	I_X
	clrf	I_X_H
	movlw	35
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
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
	movwf	I_VALUE16_H
;[byte]I_value16 = etherbuffer( i_x + 1 )
	movlw	low(ETHERBUFFER)
	addwf	I_X,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(ETHERBUFFER)
	banksel	I_X_H
	addwfc	I_X_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	movlw	1
	addwf	SysTemp1,W
	movwf	AFSR0
	movlw	0
	addwfc	SysTemp1_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	I_VALUE16
	movwf	I_VALUE16
;I_chksum32 = I_value16 + I_chksum32
	movf	I_CHKSUM32,W
	addwf	I_VALUE16,W
	movwf	I_CHKSUM32
	movf	I_CHKSUM32_H,W
	addwfc	I_VALUE16_H,W
	movwf	I_CHKSUM32_H
	movlw	0
	banksel	SYSTEMP3
	movwf	SysTemp3
	banksel	I_CHKSUM32_U
	movf	I_CHKSUM32_U,W
	banksel	SYSTEMP3
	addwfc	SysTemp3,W
	banksel	I_CHKSUM32_U
	movwf	I_CHKSUM32_U
	movlw	0
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	I_CHKSUM32_E
	movf	I_CHKSUM32_E,W
	banksel	SYSTEMP1
	addwfc	SysTemp1,W
	banksel	I_CHKSUM32_E
	movwf	I_CHKSUM32_E
;Next
	movf	I_X,W
	movwf	SysWORDTempA
	movf	I_X_H,W
	movwf	SysWORDTempA_H
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
	movf	I_CHKSUM32,W
	movwf	I_CHECKSUM16
	movf	I_CHKSUM32_H,W
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

HTTPPART4
;' If an ACK and FIN is received and the destination port address is valid
;If Tcp_ack = 1 Then
	banksel	SYSBITVAR0
	btfss	SYSBITVAR0,5
	goto	ENDIF99
;If Tcp_fin = 1 Then
	btfss	SYSBITVAR0,1
	goto	ENDIF100
;HSerPrint "ack&fin"
	movlw	low StringTable103
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable103) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$

;'set flags
;Tcp_flags = 0
	banksel	SYSETHERBUFFER_48
	clrf	SYSETHERBUFFER_48
;Tcp_flags.4 = 1                           'ack
	bsf	SYSETHERBUFFER_48,4
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
;T_ip_srcaddr0 = ENC_IpAddr(1)
	banksel	SYSENC_IPADDR_1
	movf	SYSENC_IPADDR_1,W
	banksel	SYSETHERBUFFER_27
	movwf	SYSETHERBUFFER_27
;T_ip_srcaddr1 = ENC_IpAddr(2)
	banksel	SYSENC_IPADDR_2
	movf	SYSENC_IPADDR_2,W
	banksel	SYSETHERBUFFER_28
	movwf	SYSETHERBUFFER_28
;T_ip_srcaddr2 = ENC_IpAddr(3)
	banksel	SYSENC_IPADDR_3
	movf	SYSENC_IPADDR_3,W
	banksel	SYSETHERBUFFER_29
	movwf	SYSETHERBUFFER_29
;T_ip_srcaddr3 = ENC_IpAddr(4)
	banksel	SYSENC_IPADDR_4
	movf	SYSENC_IPADDR_4,W
	banksel	SYSETHERBUFFER_30
	movwf	SYSETHERBUFFER_30
;Swap Tcp_srcportl , Tcp_destportl
	movf	SYSETHERBUFFER_36,W
	movwf	SYSCALCTEMPA
	movf	SYSETHERBUFFER_38,W
	movwf	SYSCALCTEMPB
	banksel	STATUS
	pagesel	SWAP103
	call	SWAP103
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
	pagesel	SWAP103
	call	SWAP103
	pagesel	$
	movf	SYSCALCTEMPA,W
	banksel	SYSETHERBUFFER_35
	movwf	SYSETHERBUFFER_35
	movf	SYSCALCTEMPB,W
	movwf	SYSETHERBUFFER_37

;'swap mac
;ENC28j60_Packetshape
	banksel	STATUS
	pagesel	ENC28J60_PACKETSHAPE
	call	ENC28J60_PACKETSHAPE
	pagesel	$

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
	pagesel	ENC28J60_IP_HEADER_CHECKSUM
	call	ENC28J60_IP_HEADER_CHECKSUM
	pagesel	$

;ENC28j60_tcp_checksum
	call	ENC28J60_TCP_CHECKSUM

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

;End If
ENDIF100
;End If
ENDIF99
	banksel	STATUS
	return

;********************************************************************************

PORTSSTATUS_HTM
;dim analogChannel as byte
;dir porta.0 in
	bsf	TRISA,0
;dir porta.1 in
	bsf	TRISA,1
;dir porta.2 in
	bsf	TRISA,2
;dir porta.3 in
	bsf	TRISA,3
;HTTPPrint( "REFRESH: 5",HTTPPrintCRLF )
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable23
	movwf	SysStringA
	movlw	(high StringTable23) & 127
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
	pagesel	HTTPPRINT
	call	HTTPPRINT
	pagesel	$

;HTTPPrint( "", HTTPPrintCRLF )
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable24
	movwf	SysStringA
	movlw	(high StringTable24) & 127
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
	pagesel	HTTPPRINT
	call	HTTPPRINT
	pagesel	$

;HTTPPrint ( "<html><font face=helvetica>")
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable25
	movwf	SysStringA
	movlw	(high StringTable25) & 127
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	banksel	SYSHTTPDATAHANDLER
	movwf	SysHTTPDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H
	banksel	HTTPPRINTCRLFFLAG
	clrf	HTTPPRINTCRLFFLAG
	pagesel	HTTPPRINT
	call	HTTPPRINT
	pagesel	$

;HTTPPrint ( "<img alt=""GCB Logo!"" title=""Great Cow BASIC v0.040"" ")
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable26
	movwf	SysStringA
	movlw	(high StringTable26) & 127
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	banksel	SYSHTTPDATAHANDLER
	movwf	SysHTTPDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H
	banksel	HTTPPRINTCRLFFLAG
	clrf	HTTPPRINTCRLFFLAG
	pagesel	HTTPPRINT
	call	HTTPPRINT
	pagesel	$

;HTTPPrint ( "src=""http://goo.gl/FZ4v4e"" height=""36"" ")
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable27
	movwf	SysStringA
	movlw	(high StringTable27) & 127
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	banksel	SYSHTTPDATAHANDLER
	movwf	SysHTTPDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H
	banksel	HTTPPRINTCRLFFLAG
	clrf	HTTPPRINTCRLFFLAG
	pagesel	HTTPPRINT
	call	HTTPPRINT
	pagesel	$

;HTTPPrint ("width=""243""><br><br />" )
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable28
	movwf	SysStringA
	movlw	(high StringTable28) & 127
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	banksel	SYSHTTPDATAHANDLER
	movwf	SysHTTPDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H
	banksel	HTTPPRINTCRLFFLAG
	clrf	HTTPPRINTCRLFFLAG
	pagesel	HTTPPRINT
	call	HTTPPRINT
	pagesel	$

;HTTPPrint  ("&nbsp;&nbsp;Evan is ")
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable29
	movwf	SysStringA
	movlw	(high StringTable29) & 127
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	banksel	SYSHTTPDATAHANDLER
	movwf	SysHTTPDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H
	banksel	HTTPPRINTCRLFFLAG
	clrf	HTTPPRINTCRLFFLAG
	pagesel	HTTPPRINT
	call	HTTPPRINT
	pagesel	$

;if ReadAD( 0 ) < 50 then
	clrf	ADREADPORT
	pagesel	FN_READAD48
	call	FN_READAD48
	pagesel	$
	movlw	50
	banksel	SYSREADADBYTE
	subwf	SYSREADADBYTE,W
	btfsc	STATUS, C
	goto	ENDIF133
;HTTPPrint ("not ")
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable30
	movwf	SysStringA
	movlw	(high StringTable30) & 127
	movwf	SysStringA_H
	banksel	STATUS
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	banksel	SYSHTTPDATAHANDLER
	movwf	SysHTTPDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H
	banksel	HTTPPRINTCRLFFLAG
	clrf	HTTPPRINTCRLFFLAG
	pagesel	HTTPPRINT
	call	HTTPPRINT
	pagesel	$

;end if
ENDIF133
;HTTPPrint " in the lab at the moment.."
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable31
	movwf	SysStringA
	movlw	(high StringTable31) & 127
	movwf	SysStringA_H
	banksel	STATUS
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	banksel	SYSHTTPDATAHANDLER
	movwf	SysHTTPDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H
	banksel	HTTPPRINTCRLFFLAG
	clrf	HTTPPRINTCRLFFLAG
	pagesel	HTTPPRINT
	call	HTTPPRINT
	pagesel	$

;if ReadAD( 0 ) < 50 then
	clrf	ADREADPORT
	pagesel	FN_READAD48
	call	FN_READAD48
	pagesel	$
	movlw	50
	banksel	SYSREADADBYTE
	subwf	SYSREADADBYTE,W
	btfsc	STATUS, C
	goto	ELSE134_1
;HTTPPrint ("probably working elsewhere, having family time or even asleep!")
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable32
	movwf	SysStringA
	movlw	(high StringTable32) & 127
	movwf	SysStringA_H
	banksel	STATUS
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	banksel	SYSHTTPDATAHANDLER
	movwf	SysHTTPDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H
	banksel	HTTPPRINTCRLFFLAG
	clrf	HTTPPRINTCRLFFLAG
	pagesel	HTTPPRINT
	call	HTTPPRINT
	pagesel	$

;Else
	goto	ENDIF134
ELSE134_1
;HTTPPrint ("probably working on a Great Cow BASIC solution!")
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable33
	movwf	SysStringA
	movlw	(high StringTable33) & 127
	movwf	SysStringA_H
	banksel	STATUS
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	banksel	SYSHTTPDATAHANDLER
	movwf	SysHTTPDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H
	banksel	HTTPPRINTCRLFFLAG
	clrf	HTTPPRINTCRLFFLAG
	pagesel	HTTPPRINT
	call	HTTPPRINT
	pagesel	$

;end if
ENDIF134
;HTTPPrint "<br /><br />"
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable34
	movwf	SysStringA
	movlw	(high StringTable34) & 127
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	banksel	SYSHTTPDATAHANDLER
	movwf	SysHTTPDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H
	banksel	HTTPPRINTCRLFFLAG
	clrf	HTTPPRINTCRLFFLAG
	pagesel	HTTPPRINT
	call	HTTPPRINT
	pagesel	$

;HTTPPrint "&nbsp;&nbsp;Analog inputs are: "
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable35
	movwf	SysStringA
	movlw	(high StringTable35) & 127
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	banksel	SYSHTTPDATAHANDLER
	movwf	SysHTTPDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H
	banksel	HTTPPRINTCRLFFLAG
	clrf	HTTPPRINTCRLFFLAG
	pagesel	HTTPPRINT
	call	HTTPPRINT
	pagesel	$

;HTTPPrint "<br />"
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable36
	movwf	SysStringA
	movlw	(high StringTable36) & 127
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	banksel	SYSHTTPDATAHANDLER
	movwf	SysHTTPDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H
	banksel	HTTPPRINTCRLFFLAG
	clrf	HTTPPRINTCRLFFLAG
	pagesel	HTTPPRINT
	call	HTTPPRINT
	pagesel	$

;for analogChannel = 0 to 3
	movlw	255
	movwf	ANALOGCHANNEL
SysForLoop17
	incf	ANALOGCHANNEL,F
;HTTPPrint "<br />&nbsp;&nbsp;ADC"
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable37
	movwf	SysStringA
	movlw	(high StringTable37) & 127
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	banksel	SYSHTTPDATAHANDLER
	movwf	SysHTTPDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H
	banksel	HTTPPRINTCRLFFLAG
	clrf	HTTPPRINTCRLFFLAG
	pagesel	HTTPPRINT
	call	HTTPPRINT
	pagesel	$

;HTTPPrint str(analogChannel)
	movf	ANALOGCHANNEL,W
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	clrf	SYSVALTEMP_H
	banksel	STATUS
	pagesel	FN_STR
	call	FN_STR
	pagesel	$
	movlw	low STR
	banksel	SYSHTTPDATAHANDLER
	movwf	SysHTTPDATAHandler
	movlw	high STR
	movwf	SysHTTPDATAHandler_H
	banksel	HTTPPRINTCRLFFLAG
	clrf	HTTPPRINTCRLFFLAG
	pagesel	HTTPPRINT
	call	HTTPPRINT
	pagesel	$

;HTTPPrint ": "
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable38
	movwf	SysStringA
	movlw	(high StringTable38) & 127
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	banksel	SYSHTTPDATAHANDLER
	movwf	SysHTTPDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H
	banksel	HTTPPRINTCRLFFLAG
	clrf	HTTPPRINTCRLFFLAG
	pagesel	HTTPPRINT
	call	HTTPPRINT
	pagesel	$

;HTTPPrint str(ReadAD( analogChannel ))
	movf	ANALOGCHANNEL,W
	movwf	ADREADPORT
	pagesel	FN_READAD48
	call	FN_READAD48
	pagesel	$
	banksel	SYSREADADBYTE
	movf	SYSREADADBYTE,W
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	clrf	SYSVALTEMP_H
	banksel	STATUS
	pagesel	FN_STR
	call	FN_STR
	pagesel	$
	movlw	low STR
	banksel	SYSHTTPDATAHANDLER
	movwf	SysHTTPDATAHandler
	movlw	high STR
	movwf	SysHTTPDATAHandler_H
	banksel	HTTPPRINTCRLFFLAG
	clrf	HTTPPRINTCRLFFLAG
	pagesel	HTTPPRINT
	call	HTTPPRINT
	pagesel	$

;HTTPPrint "<br />"
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable36
	movwf	SysStringA
	movlw	(high StringTable36) & 127
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	banksel	SYSHTTPDATAHANDLER
	movwf	SysHTTPDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H
	banksel	HTTPPRINTCRLFFLAG
	clrf	HTTPPRINTCRLFFLAG
	pagesel	HTTPPRINT
	call	HTTPPRINT
	pagesel	$

;next
	movlw	3
	subwf	ANALOGCHANNEL,W
	btfss	STATUS, C
	goto	SysForLoop17
SysForLoopEnd17
;HTTPPrint "<br />"
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable36
	movwf	SysStringA
	movlw	(high StringTable36) & 127
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	banksel	SYSHTTPDATAHANDLER
	movwf	SysHTTPDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H
	banksel	HTTPPRINTCRLFFLAG
	clrf	HTTPPRINTCRLFFLAG
	pagesel	HTTPPRINT
	call	HTTPPRINT
	pagesel	$

;HTTPPrint "&nbsp;&nbspPorts A:&nbsp;" + ByteToBin(porta)
	movf	PORTA,W
	movwf	BYTENUM
	pagesel	FN_BYTETOBIN
	call	FN_BYTETOBIN
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable39
	movwf	SysStringA
	movlw	(high StringTable39) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low BYTETOBIN
	movwf	FSR0L
	movlw	high BYTETOBIN
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSHTTPDATAHANDLER
	movwf	SysHTTPDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H
	banksel	HTTPPRINTCRLFFLAG
	clrf	HTTPPRINTCRLFFLAG
	pagesel	HTTPPRINT
	call	HTTPPRINT
	pagesel	$

;HTTPPrint "&nbsp;&nbsp;B:&nbsp;" + ByteToBin(portb)
	movf	PORTB,W
	movwf	BYTENUM
	pagesel	FN_BYTETOBIN
	call	FN_BYTETOBIN
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable40
	movwf	SysStringA
	movlw	(high StringTable40) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low BYTETOBIN
	movwf	FSR0L
	movlw	high BYTETOBIN
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSHTTPDATAHANDLER
	movwf	SysHTTPDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H
	banksel	HTTPPRINTCRLFFLAG
	clrf	HTTPPRINTCRLFFLAG
	pagesel	HTTPPRINT
	call	HTTPPRINT
	pagesel	$

;HTTPPrint "&nbsp;&nbsp;C:&nbsp;" + ByteToBin(portc)
	movf	PORTC,W
	movwf	BYTENUM
	pagesel	FN_BYTETOBIN
	call	FN_BYTETOBIN
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable41
	movwf	SysStringA
	movlw	(high StringTable41) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low BYTETOBIN
	movwf	FSR0L
	movlw	high BYTETOBIN
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSHTTPDATAHANDLER
	movwf	SysHTTPDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H
	banksel	HTTPPRINTCRLFFLAG
	clrf	HTTPPRINTCRLFFLAG
	pagesel	HTTPPRINT
	call	HTTPPRINT
	pagesel	$

;HTTPPrint "&nbsp;&nbsp;E:&nbsp;" + ByteToBin(porte)
	movf	PORTE,W
	movwf	BYTENUM
	pagesel	FN_BYTETOBIN
	call	FN_BYTETOBIN
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable42
	movwf	SysStringA
	movlw	(high StringTable42) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low BYTETOBIN
	movwf	FSR0L
	movlw	high BYTETOBIN
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSHTTPDATAHANDLER
	movwf	SysHTTPDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H
	banksel	HTTPPRINTCRLFFLAG
	clrf	HTTPPRINTCRLFFLAG
	pagesel	HTTPPRINT
	call	HTTPPRINT
	pagesel	$

;HTTPPrint "<br /><br />"
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable34
	movwf	SysStringA
	movlw	(high StringTable34) & 127
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	banksel	SYSHTTPDATAHANDLER
	movwf	SysHTTPDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H
	banksel	HTTPPRINTCRLFFLAG
	clrf	HTTPPRINTCRLFFLAG
	pagesel	HTTPPRINT
	call	HTTPPRINT
	pagesel	$

;HTTPPrint "&nbsp;&nbsp;Source: " + str(T_ip_destaddr0)
	banksel	SYSETHERBUFFER_31
	movf	SYSETHERBUFFER_31,W
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	clrf	SYSVALTEMP_H
	banksel	STATUS
	pagesel	FN_STR
	call	FN_STR
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable43
	movwf	SysStringA
	movlw	(high StringTable43) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low STR
	movwf	FSR0L
	movlw	high STR
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSHTTPDATAHANDLER
	movwf	SysHTTPDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H
	banksel	HTTPPRINTCRLFFLAG
	clrf	HTTPPRINTCRLFFLAG
	pagesel	HTTPPRINT
	call	HTTPPRINT
	pagesel	$

;HTTPPrint "." + str(T_ip_destaddr1)
	banksel	SYSETHERBUFFER_32
	movf	SYSETHERBUFFER_32,W
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	clrf	SYSVALTEMP_H
	banksel	STATUS
	pagesel	FN_STR
	call	FN_STR
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable44
	movwf	SysStringA
	movlw	(high StringTable44) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low STR
	movwf	FSR0L
	movlw	high STR
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSHTTPDATAHANDLER
	movwf	SysHTTPDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H
	banksel	HTTPPRINTCRLFFLAG
	clrf	HTTPPRINTCRLFFLAG
	pagesel	HTTPPRINT
	call	HTTPPRINT
	pagesel	$

;HTTPPrint "." + str(T_ip_destaddr2)
	banksel	SYSETHERBUFFER_33
	movf	SYSETHERBUFFER_33,W
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	clrf	SYSVALTEMP_H
	banksel	STATUS
	pagesel	FN_STR
	call	FN_STR
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable44
	movwf	SysStringA
	movlw	(high StringTable44) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low STR
	movwf	FSR0L
	movlw	high STR
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSHTTPDATAHANDLER
	movwf	SysHTTPDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H
	banksel	HTTPPRINTCRLFFLAG
	clrf	HTTPPRINTCRLFFLAG
	pagesel	HTTPPRINT
	call	HTTPPRINT
	pagesel	$

;HTTPPrint "." + str(T_ip_destaddr3)
	banksel	SYSETHERBUFFER_34
	movf	SYSETHERBUFFER_34,W
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	clrf	SYSVALTEMP_H
	banksel	STATUS
	pagesel	FN_STR
	call	FN_STR
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable44
	movwf	SysStringA
	movlw	(high StringTable44) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low STR
	movwf	FSR0L
	movlw	high STR
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR0L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSHTTPDATAHANDLER
	movwf	SysHTTPDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H
	banksel	HTTPPRINTCRLFFLAG
	clrf	HTTPPRINTCRLFFLAG
	pagesel	HTTPPRINT
	call	HTTPPRINT
	pagesel	$

;HTTPPrint "<br /><br />"
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable34
	movwf	SysStringA
	movlw	(high StringTable34) & 127
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	banksel	SYSHTTPDATAHANDLER
	movwf	SysHTTPDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H
	banksel	HTTPPRINTCRLFFLAG
	clrf	HTTPPRINTCRLFFLAG
	pagesel	HTTPPRINT
	call	HTTPPRINT
	pagesel	$

;HTTPPrint ( "<img alt=""Lab"" title=""Great Cow BASIC"" ")
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable45
	movwf	SysStringA
	movlw	(high StringTable45) & 127
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	banksel	SYSHTTPDATAHANDLER
	movwf	SysHTTPDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H
	banksel	HTTPPRINTCRLFFLAG
	clrf	HTTPPRINTCRLFFLAG
	pagesel	HTTPPRINT
	call	HTTPPRINT
	pagesel	$

;if ReadAD( 0 ) < 50 then
	clrf	ADREADPORT
	pagesel	FN_READAD48
	call	FN_READAD48
	pagesel	$
	movlw	50
	banksel	SYSREADADBYTE
	subwf	SYSREADADBYTE,W
	btfsc	STATUS, C
	goto	ELSE136_1
;HTTPPrint ( "src=""http://goo.gl/yNg5Tr"" height=""217"" width=""386"" ")
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable46
	movwf	SysStringA
	movlw	(high StringTable46) & 127
	movwf	SysStringA_H
	banksel	STATUS
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	banksel	SYSHTTPDATAHANDLER
	movwf	SysHTTPDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H
	banksel	HTTPPRINTCRLFFLAG
	clrf	HTTPPRINTCRLFFLAG
	pagesel	HTTPPRINT
	call	HTTPPRINT
	pagesel	$

;Else
	goto	ENDIF136
ELSE136_1
;HTTPPrint ( "src=""http://goo.gl/NUOFWu"" height=""424"" width=""239"" ")
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable47
	movwf	SysStringA
	movlw	(high StringTable47) & 127
	movwf	SysStringA_H
	banksel	STATUS
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	banksel	SYSHTTPDATAHANDLER
	movwf	SysHTTPDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H
	banksel	HTTPPRINTCRLFFLAG
	clrf	HTTPPRINTCRLFFLAG
	pagesel	HTTPPRINT
	call	HTTPPRINT
	pagesel	$

;end if
ENDIF136
;HTTPPrint ("><br><br />" )
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable48
	movwf	SysStringA
	movlw	(high StringTable48) & 127
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	banksel	SYSHTTPDATAHANDLER
	movwf	SysHTTPDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H
	banksel	HTTPPRINTCRLFFLAG
	clrf	HTTPPRINTCRLFFLAG
	pagesel	HTTPPRINT
	call	HTTPPRINT
	pagesel	$

;HTTPPrint ("</html>")
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable49
	movwf	SysStringA
	movlw	(high StringTable49) & 127
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	banksel	SYSHTTPDATAHANDLER
	movwf	SysHTTPDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysHTTPDATAHandler_H
	banksel	HTTPPRINTCRLFFLAG
	clrf	HTTPPRINTCRLFFLAG
	pagesel	HTTPPRINT
	call	HTTPPRINT
	pagesel	$

;HTTPSend
	movlw	255
	movwf	HTTPCLOSETRANSACTION
	pagesel	HTTPSEND
	call	HTTPSEND
	pagesel	$

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

;Start of program memory page 3
	ORG	6144
Delay_10US
D10US_START
	movlw	25
	movwf	DELAYTEMP
DelayUS0
	decfsz	DELAYTEMP,F
	goto	DelayUS0
	nop
	decfsz	SysWaitTemp10US, F
	goto	D10US_START
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
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
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
	goto	SysForLoopEnd9
SysForLoop9
	movlw	2
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
	pagesel	FN_FNLSL
	call	FN_FNLSL
	pagesel	$
	movf	FNLSL,W
	movwf	I_VALUE16
	movf	FNLSL_H,W
	movwf	I_VALUE16_H
;Hulp3 = I_x + 1
	incf	I_X,W
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
	addwf	I_CHKSUM32,F
	movf	I_VALUE16_H,W
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
	goto	SysForLoop9
SysForLoopEnd9
;If I_odd = 1 Then
	decf	I_ODD,W
	btfss	STATUS, Z
	goto	ENDIF79
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
	pagesel	FN_FNLSL
	call	FN_FNLSL
	pagesel	$
	movf	FNLSL,W
	movwf	I_VALUE16
	movf	FNLSL_H,W
	movwf	I_VALUE16_H
;I_chksum32 = I_chksum32 + I_value16
	movf	I_VALUE16,W
	addwf	I_CHKSUM32,F
	movf	I_VALUE16_H,W
	addwfc	I_CHKSUM32_H,F
	movlw	0
	addwfc	I_CHKSUM32_U,F
	movlw	0
	addwfc	I_CHKSUM32_E,F
;End If
ENDIF79
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
	pagesel	FN_FNLSR
	call	FN_FNLSR
	pagesel	$
	movf	FNLSR,W
	movwf	I_CHECKSUM16
	movf	FNLSR_H,W
	movwf	I_CHECKSUM16_H
;I_checksum16 = I_checksum16 + I_chksum32 ' only 16 lower bits of i_chksum32 is taken...
	movf	I_CHKSUM32,W
	addwf	I_CHECKSUM16,F
	movf	I_CHKSUM32_H,W
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
	banksel	SYSREPEATTEMP2
	movwf	SysRepeatTemp2
SysRepeatLoop2
;ENC28j60_Reset_CMD
	banksel	LATB
	bsf	LATB,4
	movlw	20
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
	bcf	LATB,4
	movlw	20
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
	bsf	LATB,4
	movlw	20
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;End Repeat
	banksel	SYSREPEATTEMP2
	decfsz	SysRepeatTemp2,F
	goto	SysRepeatLoop2
SysRepeatLoopEnd2
;ENC28j60_Select
	banksel	LATA
	bcf	LATA,5
;SPIMode MasterSlow, 0
	movlw	11
	banksel	SPICURRENTMODE
	movwf	SPICURRENTMODE
	clrf	SPICLOCKMODE
	banksel	STATUS
	pagesel	SPIMODE219
	call	SPIMODE219
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
	movwf	LASTSELECTEDBANK
;wait while ( (ENC28j60_ReadReg( ESTAT ) & ESTAT_CLKRDY ) <> ESTAT_CLKRDY)
SysWaitLoop1
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
	goto	SysWaitLoop1
;ENC28j60_writeReg(ECON1, 0xC1) 'Hold it in Reset
	movlw	31
	movwf	ADDR
	movlw	193
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

;ENC_nextpacketptr = ENC_RXBUF_ST
	clrf	ENC_NEXTPACKETPTR
	clrf	ENC_NEXTPACKETPTR_H
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

;ENC28j60_writeReg(MAADR0, ENC_MacAddr(2))
	movlw	225
	movwf	ADDR
	movlw	2
	banksel	SYSENC_MACADDRHANDLER
	addwf	SysENC_MACADDRHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysENC_MACADDRHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	ENC_OUTBYTE
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$

;ENC28j60_writeReg(MAADR1, ENC_MacAddr(1))
	movlw	224
	movwf	ADDR
	movlw	1
	banksel	SYSENC_MACADDRHANDLER
	addwf	SysENC_MACADDRHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysENC_MACADDRHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	ENC_OUTBYTE
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$

;ENC28j60_writeReg(MAADR2, ENC_MacAddr(4))
	movlw	227
	movwf	ADDR
	movlw	4
	banksel	SYSENC_MACADDRHANDLER
	addwf	SysENC_MACADDRHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysENC_MACADDRHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	ENC_OUTBYTE
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$

;ENC28j60_writeReg(MAADR3, ENC_MacAddr(3))
	movlw	226
	movwf	ADDR
	movlw	3
	banksel	SYSENC_MACADDRHANDLER
	addwf	SysENC_MACADDRHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysENC_MACADDRHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	ENC_OUTBYTE
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$

;ENC28j60_writeReg(MAADR4, ENC_MacAddr(6))
	movlw	229
	movwf	ADDR
	movlw	6
	banksel	SYSENC_MACADDRHANDLER
	addwf	SysENC_MACADDRHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysENC_MACADDRHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	ENC_OUTBYTE
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$

;ENC28j60_writeReg(MAADR5, ENC_MacAddr(5))
	movlw	228
	movwf	ADDR
	movlw	5
	banksel	SYSENC_MACADDRHANDLER
	addwf	SysENC_MACADDRHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysENC_MACADDRHandler_H,W
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
	call	ENC28J60_WRITEPHYREG
	pagesel	$

	return

;********************************************************************************

ENC28J60_PACKETRECEIVE
;Dim eth_counter, eth_frameLength As Word
;Dim previous_ENC_nextpacketptr as word
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
	goto	ENDIF29
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
ENDIF29
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
;ENC28j60_writeReg(ERDPTL, [byte]ENC_nextpacketptr )
	banksel	ADDR
	clrf	ADDR
	movf	ENC_NEXTPACKETPTR,W
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$

;ENC28j60_writeReg(ERDPTH, ENC_nextpacketptr_h )
	movlw	1
	movwf	ADDR
	movf	ENC_NEXTPACKETPTR_H,W
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
;loop while (ENC28j60_ReadReg(ERDPTL) <>  [byte]ENC_nextpacketptr) or (ENC28j60_ReadReg(ERDPTH) <> ENC_nextpacketptr_h )
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
	banksel	ENC_NEXTPACKETPTR
	movf	ENC_NEXTPACKETPTR,W
	movwf	SysBYTETempB
	pagesel	SysCompEqual
	call	SysCompEqual
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	banksel	ENC28J60_READREG
	movf	enc28j60_readreg,W
	movwf	SysBYTETempA
	movf	enc_nextpacketptr_h,W
	movwf	SysBYTETempB
	pagesel	SysCompEqual
	call	SysCompEqual
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movf	SysTemp2,W
	iorwf	SysTemp1,W
	banksel	SYSTEMP3
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
;ENC_nextpacketptr = etherbuffer(1)
	banksel	SYSETHERBUFFER_1
	movf	SYSETHERBUFFER_1,W
	banksel	ENC_NEXTPACKETPTR
	movwf	ENC_NEXTPACKETPTR
	clrf	ENC_NEXTPACKETPTR_H
;ENC_nextpacketptr_h = etherbuffer(2)
	banksel	SYSETHERBUFFER_2
	movf	SYSETHERBUFFER_2,W
	banksel	ENC_NEXTPACKETPTR_H
	movwf	ENC_NEXTPACKETPTR_H
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
;ENC28j60_writeReg(ERDPTL, [byte]ENC_nextpacketptr )
	banksel	ADDR
	clrf	ADDR
	movf	ENC_NEXTPACKETPTR,W
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$

;ENC28j60_writeReg(ERDPTH, ENC_nextpacketptr_h )
	movlw	1
	movwf	ADDR
	movf	ENC_NEXTPACKETPTR_H,W
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
	goto	ENDIF31
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

;HSerPrint "#2ERDPTL and ERDPTH error"
	movlw	low StringTable72
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable72) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$

;ENC28j60_regdump
	pagesel	ENC28J60_REGDUMP
	call	ENC28J60_REGDUMP
	pagesel	$

;exit do
	goto	SysDoLoop_E4
;end if
ENDIF31
;loop while (ENC28j60_ReadReg(ERDPTL) <>  [byte]ENC_nextpacketptr) or (ENC28j60_ReadReg(ERDPTH) <> ENC_nextpacketptr_h )
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
	banksel	ENC_NEXTPACKETPTR
	movf	ENC_NEXTPACKETPTR,W
	movwf	SysBYTETempB
	pagesel	SysCompEqual
	call	SysCompEqual
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	banksel	ENC28J60_READREG
	movf	enc28j60_readreg,W
	movwf	SysBYTETempA
	movf	enc_nextpacketptr_h,W
	movwf	SysBYTETempB
	pagesel	SysCompEqual
	call	SysCompEqual
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	banksel	SYSTEMP3
	movwf	SysTemp3
	banksel	SYSTEMP2
	movf	SysTemp2,W
	banksel	SYSTEMP3
	iorwf	SysTemp3,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	btfsc	SysTemp1,0
	goto	SysDoLoop_S4
SysDoLoop_E4
;'Packet is finished
;HSerPrint eth_counter
;HSerPrintCRLF
;IF ( ENC_nextpacketptr and 1 ) = 0 THEN
	movlw	1
	banksel	ENC_NEXTPACKETPTR
	andwf	ENC_NEXTPACKETPTR,W
	banksel	SYSTEMP1
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
	goto	ENDIF32
;eth_counter = ENC_nextpacketptr -1
	movlw	1
	subwf	ENC_NEXTPACKETPTR,W
	movwf	ETH_COUNTER
	movlw	0
	subwfb	ENC_NEXTPACKETPTR_H,W
	movwf	ETH_COUNTER_H
;END IF
ENDIF32
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
	goto	ENDIF33
;If etherBuffer(14) = 0X06 Then                             'Type:ARP
	movlw	6
	subwf	SYSETHERBUFFER_14,W
	btfss	STATUS, Z
	goto	ENDIF34
;If etherBuffer(21) = 0X00 Then                          'ARP request
	movf	SYSETHERBUFFER_21,F
	btfss	STATUS, Z
	goto	ENDIF36
;If etherBuffer(22) = 0X01 Then                       'ARP request
	decf	SYSETHERBUFFER_22,W
	btfss	STATUS, Z
	goto	ENDIF38
;If etherBuffer(39) = ENC_IpAddr(1) Then                  'ARP for us
	banksel	SYSENC_IPADDR_1
	movf	SYSENC_IPADDR_1,W
	banksel	SYSETHERBUFFER_39
	subwf	SYSETHERBUFFER_39,W
	btfss	STATUS, Z
	goto	ENDIF40
;If etherBuffer(40) = ENC_IpAddr(2) Then
	banksel	SYSENC_IPADDR_2
	movf	SYSENC_IPADDR_2,W
	banksel	SYSETHERBUFFER_40
	subwf	SYSETHERBUFFER_40,W
	btfss	STATUS, Z
	goto	ENDIF42
;If etherBuffer(41) = ENC_IpAddr(3) Then
	banksel	SYSENC_IPADDR_3
	movf	SYSENC_IPADDR_3,W
	banksel	SYSETHERBUFFER_41
	subwf	SYSETHERBUFFER_41,W
	btfss	STATUS, Z
	goto	ENDIF44
;If etherBuffer(42) = ENC_IpAddr(4) Then
	banksel	SYSENC_IPADDR_4
	movf	SYSENC_IPADDR_4,W
	banksel	SYSETHERBUFFER_42
	subwf	SYSETHERBUFFER_42,W
	btfss	STATUS, Z
	goto	ENDIF46
;ENC28j60_Arpreply
	banksel	STATUS
	pagesel	ENC28J60_ARPREPLY
	call	ENC28J60_ARPREPLY
	pagesel	$

;End If
ENDIF46
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
;If etherBuffer(14) = 0X00 Then                             'Type:IP
	banksel	SYSETHERBUFFER_14
	movf	SYSETHERBUFFER_14,F
	btfss	STATUS, Z
	goto	ENDIF35
;If etherBuffer(15) = 0X45 Then                          'We handle only simple IP packets
	movlw	69
	subwf	SYSETHERBUFFER_15,W
	btfss	STATUS, Z
	goto	ENDIF37
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
	banksel	SYSTEMP3
	movwf	SysTemp3
	btfss	SysTemp3,0
	goto	ENDIF39
;If etherBuffer(31) = ENC_IpAddr(1) Then                  'Ip packet for us
	banksel	SYSENC_IPADDR_1
	movf	SYSENC_IPADDR_1,W
	banksel	SYSETHERBUFFER_31
	subwf	SYSETHERBUFFER_31,W
	btfss	STATUS, Z
	goto	ENDIF41
;If etherBuffer(32) = ENC_IpAddr(2) Then
	banksel	SYSENC_IPADDR_2
	movf	SYSENC_IPADDR_2,W
	banksel	SYSETHERBUFFER_32
	subwf	SYSETHERBUFFER_32,W
	btfss	STATUS, Z
	goto	ENDIF43
;If etherBuffer(33) = ENC_IpAddr(3) Then
	banksel	SYSENC_IPADDR_3
	movf	SYSENC_IPADDR_3,W
	banksel	SYSETHERBUFFER_33
	subwf	SYSETHERBUFFER_33,W
	btfss	STATUS, Z
	goto	ENDIF45
;If etherBuffer(34) = ENC_IpAddr(4) Then
	banksel	SYSENC_IPADDR_4
	movf	SYSENC_IPADDR_4,W
	banksel	SYSETHERBUFFER_34
	subwf	SYSETHERBUFFER_34,W
	btfss	STATUS, Z
	goto	ENDIF47
;If etherBuffer(24) = 1 Then              'Protocol:ICMP
	decf	SYSETHERBUFFER_24,W
	btfss	STATUS, Z
	goto	ENDIF48
;If etherBuffer(35) = 0X08 Then        'ICMP echo request
	movlw	8
	subwf	SYSETHERBUFFER_35,W
	btfss	STATUS, Z
	goto	ENDIF51
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
ENDIF51
;End If
ENDIF48
;If etherBuffer(24) = 17 Then             'Protocol:UDP
	movlw	17
	banksel	SYSETHERBUFFER_24
	subwf	SYSETHERBUFFER_24,W
	btfss	STATUS, Z
	goto	ENDIF49
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
	movwf	T_UDP_DESTPORT
	movlw	0
	addwfc	SysTemp1_H,W
	movwf	T_UDP_DESTPORT_H
;ENC28j60_Udp_Handler
	banksel	STATUS
	pagesel	ENC28J60_UDP_HANDLER
	call	ENC28J60_UDP_HANDLER
	pagesel	$

;select case T_udp_srcport1
;case 0x25
SysSelect3Case1
	movlw	37
	banksel	SYSETHERBUFFER_36
	subwf	SYSETHERBUFFER_36,W
	btfss	STATUS, Z
	goto	SysSelect3Case2
;ENC28j60_sntp_handler
	banksel	STATUS
	pagesel	ENC28J60_SNTP_HANDLER
	call	ENC28J60_SNTP_HANDLER
	pagesel	$

;Exit Sub
	return
;end select
SysSelect3Case2
SysSelectEnd3
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
	goto	ENDIF52
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
	pagesel	SWAP103
	call	SWAP103
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
	pagesel	SWAP103
	call	SWAP103
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
ENDIF52
;End If
ENDIF49
;If etherBuffer(24) = 6 Then              'Protocol:TCP
	movlw	6
	banksel	SYSETHERBUFFER_24
	subwf	SYSETHERBUFFER_24,W
	btfss	STATUS, Z
	goto	ENDIF50
;If Tcp_destporth = 0 Then
	movf	SYSETHERBUFFER_37,F
	btfss	STATUS, Z
	goto	ENDIF53
;Select Case Tcp_destportl
SysSelect4Case1
	movlw	80
	subwf	SYSETHERBUFFER_38,W
	btfss	STATUS, Z
	goto	SysSelect4Case2
;ENC28j60_http
	banksel	STATUS
	pagesel	ENC28J60_HTTP
	call	ENC28J60_HTTP
	pagesel	$

;End Select
SysSelect4Case2
SysSelectEnd4
;End If
ENDIF53
;End If
ENDIF50
;End If
ENDIF47
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
	banksel	STATUS
	return

;********************************************************************************

GETSTRING
;CommandLineString(0)=12
	movlw	12
	banksel	SYSCOMMANDLINESTRING_0
	movwf	SYSCOMMANDLINESTRING_0
;CommandLineString(1) = EtherBuffer(EtherBufferIndex)
	movlw	low(ETHERBUFFER)
	banksel	ETHERBUFFERINDEX
	addwf	ETHERBUFFERINDEX,W
	movwf	AFSR0
	movlw	high(ETHERBUFFER)
	addwfc	ETHERBUFFERINDEX_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP1
	movwf	SysArrayTemp1
	banksel	SYSCOMMANDLINESTRING_1
	movwf	SYSCOMMANDLINESTRING_1
;CommandLineString(2) = EtherBuffer(EtherBufferIndex+1)
	movlw	low(ETHERBUFFER)
	banksel	ETHERBUFFERINDEX
	addwf	ETHERBUFFERINDEX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(ETHERBUFFER)
	banksel	ETHERBUFFERINDEX_H
	addwfc	ETHERBUFFERINDEX_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	movlw	1
	addwf	SysTemp1,W
	movwf	AFSR0
	movlw	0
	addwfc	SysTemp1_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP1
	movwf	SysArrayTemp1
	banksel	SYSCOMMANDLINESTRING_2
	movwf	SYSCOMMANDLINESTRING_2
;CommandLineString(3) = EtherBuffer(EtherBufferIndex+2)
	movlw	low(ETHERBUFFER)
	banksel	ETHERBUFFERINDEX
	addwf	ETHERBUFFERINDEX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(ETHERBUFFER)
	banksel	ETHERBUFFERINDEX_H
	addwfc	ETHERBUFFERINDEX_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	movlw	2
	addwf	SysTemp1,W
	movwf	AFSR0
	movlw	0
	addwfc	SysTemp1_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP1
	movwf	SysArrayTemp1
	banksel	SYSCOMMANDLINESTRING_3
	movwf	SYSCOMMANDLINESTRING_3
;CommandLineString(4) = EtherBuffer(EtherBufferIndex+3)
	movlw	low(ETHERBUFFER)
	banksel	ETHERBUFFERINDEX
	addwf	ETHERBUFFERINDEX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(ETHERBUFFER)
	banksel	ETHERBUFFERINDEX_H
	addwfc	ETHERBUFFERINDEX_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	movlw	3
	addwf	SysTemp1,W
	movwf	AFSR0
	movlw	0
	addwfc	SysTemp1_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP1
	movwf	SysArrayTemp1
	banksel	SYSCOMMANDLINESTRING_4
	movwf	SYSCOMMANDLINESTRING_4
;CommandLineString(5) = EtherBuffer(EtherBufferIndex+4)
	movlw	low(ETHERBUFFER)
	banksel	ETHERBUFFERINDEX
	addwf	ETHERBUFFERINDEX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(ETHERBUFFER)
	banksel	ETHERBUFFERINDEX_H
	addwfc	ETHERBUFFERINDEX_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	movlw	4
	addwf	SysTemp1,W
	movwf	AFSR0
	movlw	0
	addwfc	SysTemp1_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP1
	movwf	SysArrayTemp1
	banksel	SYSCOMMANDLINESTRING_5
	movwf	SYSCOMMANDLINESTRING_5
;CommandLineString(6) = EtherBuffer(EtherBufferIndex+5)
	movlw	low(ETHERBUFFER)
	banksel	ETHERBUFFERINDEX
	addwf	ETHERBUFFERINDEX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(ETHERBUFFER)
	banksel	ETHERBUFFERINDEX_H
	addwfc	ETHERBUFFERINDEX_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	movlw	5
	addwf	SysTemp1,W
	movwf	AFSR0
	movlw	0
	addwfc	SysTemp1_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP1
	movwf	SysArrayTemp1
	banksel	SYSCOMMANDLINESTRING_6
	movwf	SYSCOMMANDLINESTRING_6
;CommandLineString(7) = EtherBuffer(EtherBufferIndex+6)
	movlw	low(ETHERBUFFER)
	banksel	ETHERBUFFERINDEX
	addwf	ETHERBUFFERINDEX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(ETHERBUFFER)
	banksel	ETHERBUFFERINDEX_H
	addwfc	ETHERBUFFERINDEX_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	movlw	6
	addwf	SysTemp1,W
	movwf	AFSR0
	movlw	0
	addwfc	SysTemp1_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP1
	movwf	SysArrayTemp1
	banksel	SYSCOMMANDLINESTRING_7
	movwf	SYSCOMMANDLINESTRING_7
;CommandLineString(8) = EtherBuffer(EtherBufferIndex+7)
	movlw	low(ETHERBUFFER)
	banksel	ETHERBUFFERINDEX
	addwf	ETHERBUFFERINDEX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(ETHERBUFFER)
	banksel	ETHERBUFFERINDEX_H
	addwfc	ETHERBUFFERINDEX_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	movlw	7
	addwf	SysTemp1,W
	movwf	AFSR0
	movlw	0
	addwfc	SysTemp1_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP1
	movwf	SysArrayTemp1
	banksel	SYSCOMMANDLINESTRING_8
	movwf	SYSCOMMANDLINESTRING_8
;CommandLineString(9) = EtherBuffer(EtherBufferIndex+8)
	movlw	low(ETHERBUFFER)
	banksel	ETHERBUFFERINDEX
	addwf	ETHERBUFFERINDEX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(ETHERBUFFER)
	banksel	ETHERBUFFERINDEX_H
	addwfc	ETHERBUFFERINDEX_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	movlw	8
	addwf	SysTemp1,W
	movwf	AFSR0
	movlw	0
	addwfc	SysTemp1_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP1
	movwf	SysArrayTemp1
	banksel	SYSCOMMANDLINESTRING_9
	movwf	SYSCOMMANDLINESTRING_9
;CommandLineString(10) = EtherBuffer(EtherBufferIndex+9)
	movlw	low(ETHERBUFFER)
	banksel	ETHERBUFFERINDEX
	addwf	ETHERBUFFERINDEX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(ETHERBUFFER)
	banksel	ETHERBUFFERINDEX_H
	addwfc	ETHERBUFFERINDEX_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	movlw	9
	addwf	SysTemp1,W
	movwf	AFSR0
	movlw	0
	addwfc	SysTemp1_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP1
	movwf	SysArrayTemp1
	banksel	SYSCOMMANDLINESTRING_10
	movwf	SYSCOMMANDLINESTRING_10
;CommandLineString(11) = EtherBuffer(EtherBufferIndex+10)
	movlw	low(ETHERBUFFER)
	banksel	ETHERBUFFERINDEX
	addwf	ETHERBUFFERINDEX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(ETHERBUFFER)
	banksel	ETHERBUFFERINDEX_H
	addwfc	ETHERBUFFERINDEX_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	movlw	10
	addwf	SysTemp1,W
	movwf	AFSR0
	movlw	0
	addwfc	SysTemp1_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP1
	movwf	SysArrayTemp1
	banksel	SYSCOMMANDLINESTRING_11
	movwf	SYSCOMMANDLINESTRING_11
;CommandLineString(12) = EtherBuffer(EtherBufferIndex+11)
	movlw	low(ETHERBUFFER)
	banksel	ETHERBUFFERINDEX
	addwf	ETHERBUFFERINDEX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(ETHERBUFFER)
	banksel	ETHERBUFFERINDEX_H
	addwfc	ETHERBUFFERINDEX_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	movlw	11
	addwf	SysTemp1,W
	movwf	AFSR0
	movlw	0
	addwfc	SysTemp1_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP1
	movwf	SysArrayTemp1
	banksel	SYSCOMMANDLINESTRING_12
	movwf	SYSCOMMANDLINESTRING_12
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
	banksel	STATUS
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
	goto	ELSE105_1
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
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movf	SysWORDTempX_H,W
	movwf	SysTemp1_H
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
	goto	ENDIF106
;HSerPrint "  PAD! "
	movlw	low StringTable106
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable106) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

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
ENDIF106
;Ackpsh = 0
	clrf	ACKPSH
;
;HSerPrintCRLF
;FOR hulp2 = 0X0037 TO arrayloc
;HSerSend etherbuffer(HULP2)
;Next
;HSerPrintCRLF
;Else
	goto	ENDIF105
ELSE105_1
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
ENDIF105
;HSerPrintCRLF
	movlw	1
	banksel	HSERPRINTCRLFCOUNT
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$

;HSerPrint "Send:"
	movlw	low StringTable107
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable107) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;HSerPrint T_ip_srcaddr0
	banksel	SYSETHERBUFFER_27
	movf	SYSETHERBUFFER_27,W
	banksel	SERPRINTVAL
	movwf	SERPRINTVAL
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT264
	call	HSERPRINT264
	pagesel	$

;HSerPrint ","
	movlw	low StringTable62
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable62) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;HSerPrint T_ip_srcaddr1
	banksel	SYSETHERBUFFER_28
	movf	SYSETHERBUFFER_28,W
	banksel	SERPRINTVAL
	movwf	SERPRINTVAL
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT264
	call	HSERPRINT264
	pagesel	$

;HSerPrint ","
	movlw	low StringTable62
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable62) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;HSerPrint T_ip_srcaddr2
	banksel	SYSETHERBUFFER_29
	movf	SYSETHERBUFFER_29,W
	banksel	SERPRINTVAL
	movwf	SERPRINTVAL
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT264
	call	HSERPRINT264
	pagesel	$

;HSerPrint ","
	movlw	low StringTable62
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable62) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;HSerPrint T_ip_srcaddr3
	banksel	SYSETHERBUFFER_30
	movf	SYSETHERBUFFER_30,W
	banksel	SERPRINTVAL
	movwf	SERPRINTVAL
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT264
	call	HSERPRINT264
	pagesel	$

;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$

;Tcp_acknum0 = Incoming_ack
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
;HSerSend 9
	movlw	9
	banksel	SERDATA
	movwf	SERDATA
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERSEND
	call	HSERSEND
	pagesel	$

;HSerPrint "B/Wire:"
	movlw	low StringTable108
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable108) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;HSerPrint ( TCPresult16 + [byte]IP_HeaderSize )
	movlw	14
	banksel	TCPRESULT16
	addwf	TCPRESULT16,W
	banksel	SERPRINTVAL
	movwf	SERPRINTVAL
	movlw	0
	banksel	TCPRESULT16_H
	addwfc	TCPRESULT16_H,W
	banksel	SERPRINTVAL_H
	movwf	SERPRINTVAL_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT265
	call	HSERPRINT265
	pagesel	$

;HSerPrint ", TCP Pkt:"
	movlw	low StringTable109
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable109) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;HSerPrint ( TCPresult16 - 40 )
	movlw	40
	banksel	TCPRESULT16
	subwf	TCPRESULT16,W
	banksel	SERPRINTVAL
	movwf	SERPRINTVAL
	movlw	0
	banksel	TCPRESULT16_H
	subwfb	TCPRESULT16_H,W
	banksel	SERPRINTVAL_H
	movwf	SERPRINTVAL_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT265
	call	HSERPRINT265
	pagesel	$

;HSerPrint ", HTML:"
	movlw	low StringTable110
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable110) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;HSerPrint ( TCPresult16 - 88 )
	movlw	88
	banksel	TCPRESULT16
	subwf	TCPRESULT16,W
	banksel	SERPRINTVAL
	movwf	SERPRINTVAL
	movlw	0
	banksel	TCPRESULT16_H
	subwfb	TCPRESULT16_H,W
	banksel	SERPRINTVAL_H
	movwf	SERPRINTVAL_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT265
	call	HSERPRINT265
	pagesel	$

;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$

;T_ip_pktlen0 = TCPresult16_H                             'HTML-code + 40
	banksel	TCPRESULT16_H
	movf	TCPRESULT16_H,W
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
	pagesel	$

;ENC28j60_tcp_checksum
	pagesel	ENC28J60_TCP_CHECKSUM
	call	ENC28J60_TCP_CHECKSUM
	pagesel	$

;ENC28j60_writebuffer( TCPresult16 + IP_HeaderSize   )
	movlw	14
	banksel	TCPRESULT16
	addwf	TCPRESULT16,W
	banksel	PCKTLEN
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

;ENC28j60_packetsend( TCPresult16 + IP_HeaderSize   )
	movlw	14
	banksel	TCPRESULT16
	addwf	TCPRESULT16,W
	banksel	PCKTLEN
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

	return

;********************************************************************************

FN_STR
;SysCharCount = 0
	banksel	SYSCHARCOUNT
	clrf	SYSCHARCOUNT
;Dim SysCalcTempX As Word
;IF SysValTemp >= 10000 then
	banksel	SYSVALTEMP
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB
	movlw	39
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF138
;SysStrData = SysValTemp / 10000
	banksel	SYSVALTEMP
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
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
	banksel	SYSSTRDATA
	movwf	SYSSTRDATA
;SysValTemp = SysCalcTempX
	movf	SYSCALCTEMPX,W
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	movf	SYSCALCTEMPX_H,W
	movwf	SYSVALTEMP_H
;SysCharCount += 1
	banksel	SYSCHARCOUNT
	incf	SYSCHARCOUNT,F
;Str(SysCharCount) = SysStrData + 48
	movlw	low(STR)
	addwf	SYSCHARCOUNT,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(STR)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF0
;Goto SysValThousands
	goto	SYSVALTHOUSANDS
;End If
ENDIF138
;IF SysValTemp >= 1000 then
	banksel	SYSVALTEMP
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB
	movlw	3
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF139
SYSVALTHOUSANDS
;SysStrData = SysValTemp / 1000
	banksel	SYSVALTEMP
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
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
	banksel	SYSSTRDATA
	movwf	SYSSTRDATA
;SysValTemp = SysCalcTempX
	movf	SYSCALCTEMPX,W
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	movf	SYSCALCTEMPX_H,W
	movwf	SYSVALTEMP_H
;SysCharCount += 1
	banksel	SYSCHARCOUNT
	incf	SYSCHARCOUNT,F
;Str(SysCharCount) = SysStrData + 48
	movlw	low(STR)
	addwf	SYSCHARCOUNT,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(STR)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF0
;Goto SysValHundreds
	goto	SYSVALHUNDREDS
;End If
ENDIF139
;IF SysValTemp >= 100 then
	banksel	SYSVALTEMP
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF140
SYSVALHUNDREDS
;SysStrData = SysValTemp / 100
	banksel	SYSVALTEMP
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempA,W
	banksel	SYSSTRDATA
	movwf	SYSSTRDATA
;SysValTemp = SysCalcTempX
	movf	SYSCALCTEMPX,W
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	movf	SYSCALCTEMPX_H,W
	movwf	SYSVALTEMP_H
;SysCharCount += 1
	banksel	SYSCHARCOUNT
	incf	SYSCHARCOUNT,F
;Str(SysCharCount) = SysStrData + 48
	movlw	low(STR)
	addwf	SYSCHARCOUNT,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(STR)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF0
;Goto SysValTens
	goto	SYSVALTENS
;End If
ENDIF140
;IF SysValTemp >= 10 Then
	banksel	SYSVALTEMP
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF141
SYSVALTENS
;SysStrData = SysValTemp / 10
	banksel	SYSVALTEMP
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempA,W
	banksel	SYSSTRDATA
	movwf	SYSSTRDATA
;SysValTemp = SysCalcTempX
	movf	SYSCALCTEMPX,W
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	movf	SYSCALCTEMPX_H,W
	movwf	SYSVALTEMP_H
;SysCharCount += 1
	banksel	SYSCHARCOUNT
	incf	SYSCHARCOUNT,F
;Str(SysCharCount) = SysStrData + 48
	movlw	low(STR)
	addwf	SYSCHARCOUNT,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(STR)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF0
;End If
ENDIF141
;SysCharCount += 1
	banksel	SYSCHARCOUNT
	incf	SYSCHARCOUNT,F
;Str(SysCharCount) = SysValTemp + 48
	movlw	low(STR)
	addwf	SYSCHARCOUNT,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(STR)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movlw	48
	banksel	SYSVALTEMP
	addwf	SYSVALTEMP,W
	movwf	INDF0
;SysValTemp = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SYSVALTEMP
	movf	SYSCALCTEMPX_H,W
	movwf	SYSVALTEMP_H
;Str(0) = SysCharCount
	banksel	SYSCHARCOUNT
	movf	SYSCHARCOUNT,W
	banksel	SYSSTR_0
	movwf	SYSSTR_0
	banksel	STATUS
	return

;********************************************************************************

;Start of program memory page 4
	ORG	8192
FN_BYTETOBIN
;ByteToBin = ""
	movlw	low BYTETOBIN
	movwf	FSR1L
	movlw	high BYTETOBIN
	movwf	FSR1H
	movlw	low StringTable24
	movwf	SysStringA
	movlw	(high StringTable24) & 127
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
;Repeat 8
	movlw	8
	banksel	SYSREPEATTEMP11
	movwf	SysRepeatTemp11
SysRepeatLoop11
;If ByteNum.7 = 1 Then
	banksel	BYTENUM
	btfss	BYTENUM,7
	goto	ELSE142_1
;ByteToBin = ByteToBin +"1"
	movlw	low BYTETOBIN
	movwf	FSR1L
	movlw	high BYTETOBIN
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low BYTETOBIN
	movwf	FSR0L
	movlw	high BYTETOBIN
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low StringTable134
	movwf	SysStringA
	movlw	(high StringTable134) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low BYTETOBIN
	movwf	FSR0L
	movlw	high BYTETOBIN
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
;Else
	goto	ENDIF142
ELSE142_1
;ByteToBin = ByteToBin +"0"
	movlw	low BYTETOBIN
	movwf	FSR1L
	movlw	high BYTETOBIN
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low BYTETOBIN
	movwf	FSR0L
	movlw	high BYTETOBIN
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low StringTable73
	movwf	SysStringA
	movlw	(high StringTable73) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low BYTETOBIN
	movwf	FSR0L
	movlw	high BYTETOBIN
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
;End If
ENDIF142
;Rotate ByteNum Left
	rlf	BYTENUM,F
;End Repeat
	banksel	SYSREPEATTEMP11
	decfsz	SysRepeatTemp11,F
	goto	SysRepeatLoop11
SysRepeatLoopEnd11
	banksel	STATUS
	return

;********************************************************************************

ENC28J60_ARPREPLY
;ENC28j60_set_response_macaddress
	pagesel	ENC28J60_SET_RESPONSE_MACADDRESS
	call	ENC28J60_SET_RESPONSE_MACADDRESS
	pagesel	$

;For II = 1 To 6
;etherBuffer(32 + II) = etherBuffer(II)
;Next
;T_arp_dest_enetpacket0 = T_enetpacketdest0
	banksel	SYSETHERBUFFER_1
	movf	SYSETHERBUFFER_1,W
	banksel	SYSETHERBUFFER_33
	movwf	SYSETHERBUFFER_33
;T_arp_dest_enetpacket1 = T_enetpacketdest1
	banksel	SYSETHERBUFFER_2
	movf	SYSETHERBUFFER_2,W
	banksel	SYSETHERBUFFER_34
	movwf	SYSETHERBUFFER_34
;T_arp_dest_enetpacket2 = T_enetpacketdest2
	banksel	SYSETHERBUFFER_3
	movf	SYSETHERBUFFER_3,W
	banksel	SYSETHERBUFFER_35
	movwf	SYSETHERBUFFER_35
;T_arp_dest_enetpacket3 = T_enetpacketdest3
	banksel	SYSETHERBUFFER_4
	movf	SYSETHERBUFFER_4,W
	banksel	SYSETHERBUFFER_36
	movwf	SYSETHERBUFFER_36
;T_arp_dest_enetpacket4 = T_enetpacketdest4
	banksel	SYSETHERBUFFER_5
	movf	SYSETHERBUFFER_5,W
	banksel	SYSETHERBUFFER_37
	movwf	SYSETHERBUFFER_37
;T_arp_dest_enetpacket5 = T_enetpacketdest5
	banksel	SYSETHERBUFFER_6
	movf	SYSETHERBUFFER_6,W
	banksel	SYSETHERBUFFER_38
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
	banksel	SYSETHERBUFFER_7
	movf	SYSETHERBUFFER_7,W
	banksel	SYSETHERBUFFER_23
	movwf	SYSETHERBUFFER_23
;T_arp_src_enetpacket1 = T_enetpacketsrc1
	banksel	SYSETHERBUFFER_8
	movf	SYSETHERBUFFER_8,W
	banksel	SYSETHERBUFFER_24
	movwf	SYSETHERBUFFER_24
;T_arp_src_enetpacket2 = T_enetpacketsrc2
	banksel	SYSETHERBUFFER_9
	movf	SYSETHERBUFFER_9,W
	banksel	SYSETHERBUFFER_25
	movwf	SYSETHERBUFFER_25
;T_arp_src_enetpacket3 = T_enetpacketsrc3
	banksel	SYSETHERBUFFER_10
	movf	SYSETHERBUFFER_10,W
	banksel	SYSETHERBUFFER_26
	movwf	SYSETHERBUFFER_26
;T_arp_src_enetpacket4 = T_enetpacketsrc4
	movf	SYSETHERBUFFER_11,W
	movwf	SYSETHERBUFFER_27
;T_arp_src_enetpacket5 = T_enetpacketsrc5
	movf	SYSETHERBUFFER_12,W
	movwf	SYSETHERBUFFER_28
;T_arp_sipaddr0 = ENC_IpAddr(1)
	banksel	SYSENC_IPADDR_1
	movf	SYSENC_IPADDR_1,W
	banksel	SYSETHERBUFFER_29
	movwf	SYSETHERBUFFER_29
;T_arp_sipaddr1 = ENC_IpAddr(2)
	banksel	SYSENC_IPADDR_2
	movf	SYSENC_IPADDR_2,W
	banksel	SYSETHERBUFFER_30
	movwf	SYSETHERBUFFER_30
;T_arp_sipaddr2 = ENC_IpAddr(3)
	banksel	SYSENC_IPADDR_3
	movf	SYSENC_IPADDR_3,W
	banksel	SYSETHERBUFFER_31
	movwf	SYSETHERBUFFER_31
;T_arp_sipaddr3 = ENC_IpAddr(4)
	banksel	SYSENC_IPADDR_4
	movf	SYSENC_IPADDR_4,W
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
	call	ENC28J60_PACKETSEND

	return

;********************************************************************************

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
	banksel	LOCALTMP
	clrf	LOCALTMP
	clrf	LOCALTMP_H
;I_odd = (Endptr - startptr ) Mod 2
	banksel	STARTPTR
	movf	STARTPTR,W
	banksel	ENDPTR
	subwf	ENDPTR,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	STARTPTR_H
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
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempX,W
	movwf	I_ODD
;if I_odd = 1 then HSerPrint "!"
	decf	I_ODD,W
	btfss	STATUS, Z
	goto	ENDIF74
	movlw	low StringTable60
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable60) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

ENDIF74
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
	goto	SysForLoopEnd8
SysForLoop8
	movlw	2
	addwf	II,F
	movlw	0
	addwfc	II_H,F
;Sum = Sum + etherBuffer(II + 1)
	movlw	low(ETHERBUFFER)
	addwf	II,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	high(ETHERBUFFER)
	banksel	II_H
	addwfc	II_H,W
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H
	movlw	1
	addwf	SysTemp2,W
	movwf	AFSR0
	movlw	0
	addwfc	SysTemp2_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SUM
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
	movwf	LOCALTMP_H
;Sum = Sum + LocalTmp
	movf	LOCALTMP,W
	banksel	SUM
	addwf	SUM,F
	banksel	LOCALTMP_H
	movf	LOCALTMP_H,W
	banksel	SUM_H
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
	goto	SysForLoop8
SysForLoopEnd8
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
	banksel	NUMBITS
	movwf	NUMBITS
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
	banksel	LOCALTMP
	movwf	LOCALTMP
	banksel	SUM_H
	movf	SUM_H,W
	banksel	LOCALTMP_H
	movwf	LOCALTMP_H
;LocalTmp  = LocalTmp  + II
	movf	II,W
	addwf	LOCALTMP,F
	movf	II_H,W
	addwfc	LOCALTMP_H,F
;LocalTmp  = Not LocalTmp
	comf	LOCALTMP,F
	comf	LOCALTMP_H,F
;etherBuffer(result) = LocalTmp_h
	movlw	low(ETHERBUFFER)
	banksel	RESULT
	addwf	RESULT,W
	movwf	AFSR0
	movlw	high(ETHERBUFFER)
	addwfc	RESULT_H,W
	movwf	AFSR0_H
	banksel	LOCALTMP_H
	movf	LOCALTMP_H,W
	movwf	INDF0
;etherBuffer(result + 1) = [byte]LocalTmp
	movlw	low(ETHERBUFFER)
	banksel	RESULT
	addwf	RESULT,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	high(ETHERBUFFER)
	banksel	RESULT_H
	addwfc	RESULT_H,W
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H
	movlw	1
	addwf	SysTemp2,W
	movwf	AFSR0
	movlw	0
	addwfc	SysTemp2_H,W
	movwf	AFSR0_H
	banksel	LOCALTMP
	movf	LOCALTMP,W
	movwf	INDF0
	return

;********************************************************************************

ENC28J60_PACKETSEND
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

;ENC28j60_bitClear( EIR , EIR_TXERIF )
	movlw	28
	movwf	ADDR
	movlw	2
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_BITCLEAR
	call	ENC28J60_BITCLEAR
	pagesel	$

;wait while ( (ENC28j60_ReadReg( ECON1 ) & ECON1_TXRTS ) = ECON1_TXRTS )
SysWaitLoop13
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
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$

;ENC28j60_writeReg(etxndh , hulp2_h )
	movlw	7
	movwf	ADDR
	movf	HULP2_H,W
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$

;ENC28j60_bitSet( EIR , EIR_TXIF )
	movlw	28
	movwf	ADDR
	movlw	8
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_BITSET
	call	ENC28J60_BITSET
	pagesel	$

;ENC28j60_bitClear( EIE , EIE_TXIE )
	movlw	27
	movwf	ADDR
	movlw	8
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_BITCLEAR
	call	ENC28J60_BITCLEAR
	pagesel	$

;ENC28j60_bitSet( ECON1 , econ1_txrts )
	movlw	31
	movwf	ADDR
	movlw	8
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_BITSET
	call	ENC28J60_BITSET
	pagesel	$

;wait while ( (ENC28j60_ReadReg( ECON1 ) & ECON1_TXRTS ) = ECON1_TXRTS )
SysWaitLoop14
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
	pagesel	SysCompEqual
	call	SysCompEqual
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysWaitLoop14
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
	pagesel	ENC28J60_SET_RESPONSE_IPPACKET
	call	ENC28J60_SET_RESPONSE_IPPACKET
	pagesel	$

;'Swap IP addresses
;T_ip_destaddr0 = T_ip_srcaddr0
;T_ip_destaddr1 = T_ip_srcaddr1
;T_ip_destaddr2 = T_ip_srcaddr2
;T_ip_destaddr3 = T_ip_srcaddr3
;
;'Set source IP in IP header, pos 27
;T_ip_srcaddr0 = ENC_IpAddr(1)
;T_ip_srcaddr1 = ENC_IpAddr(2)
;T_ip_srcaddr2 = ENC_IpAddr(3)
;T_ip_srcaddr3 = ENC_IpAddr(4)
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
	call	ENC28J60_CALCCHECKSUM

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
	call	ENC28J60_CALCCHECKSUM

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
	call	ENC28J60_PACKETSEND

	return

;********************************************************************************

ENC28J60_READBUFFER
;dim eth_counter as Word
;ENC28j60_regdump
;if etherGetLength  > 1518 then Exit Sub
;ENC28j60_Select
	bcf	LATA,5
;Set WCOL Off
	banksel	SSP1CON1
	bcf	SSP1CON1,WCOL
;SSPBUF = ENC28j60_READ_BUF_MEM
	movlw	58
	movwf	SSP1BUF
;Wait While BF = Off
SysWaitLoop15
	btfss	SSP1STAT,BF
	goto	SysWaitLoop15
;temp = SSPBUF
	movf	SSP1BUF,W
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
	goto	SysForLoopEnd4
SysForLoop4
	incf	ETH_COUNTER,F
	btfsc	STATUS,Z
	incf	ETH_COUNTER_H,F
;if eth_counter > etherBufferSize then
	movf	ETH_COUNTER,W
	movwf	SysWORDTempB
	movf	ETH_COUNTER_H,W
	movwf	SysWORDTempB_H
	movlw	232
	movwf	SysWORDTempA
	movlw	3
	movwf	SysWORDTempA_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
;exit for
	goto	SysForLoopEnd4
;end if
;SSPBUF = 0
	banksel	SSP1BUF
	clrf	SSP1BUF
;Wait While BF = Off
SysWaitLoop16
	btfss	SSP1STAT,BF
	goto	SysWaitLoop16
;etherbuffer( eth_counter ) = SSPBUF
	movlw	low(ETHERBUFFER)
	banksel	ETH_COUNTER
	addwf	ETH_COUNTER,W
	movwf	AFSR0
	movlw	high(ETHERBUFFER)
	addwfc	ETH_COUNTER_H,W
	movwf	AFSR0_H
	banksel	SSP1BUF
	movf	SSP1BUF,W
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
	goto	SysForLoop4
SysForLoopEnd4
;if etherGetLength > etherBufferSize then
	movf	ETHERGETLENGTH,W
	movwf	SysWORDTempB
	movf	ETHERGETLENGTH_H,W
	movwf	SysWORDTempB_H
	movlw	232
	movwf	SysWORDTempA
	movlw	3
	movwf	SysWORDTempA_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF57
;for eth_counter = etherBufferSize+1 to etherGetLength
	movlw	232
	movwf	ETH_COUNTER
	movlw	3
	movwf	ETH_COUNTER_H
	movlw	233
	movwf	SysWORDTempB
	movlw	3
	movwf	SysWORDTempB_H
	movf	ETHERGETLENGTH,W
	movwf	SysWORDTempA
	movf	ETHERGETLENGTH_H,W
	movwf	SysWORDTempA_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd5
SysForLoop5
	incf	ETH_COUNTER,F
	btfsc	STATUS,Z
	incf	ETH_COUNTER_H,F
;SSPBUF = 0
	banksel	SSP1BUF
	clrf	SSP1BUF
;Wait While BF = Off
SysWaitLoop17
	btfss	SSP1STAT,BF
	goto	SysWaitLoop17
;temp = SSPBUF
	movf	SSP1BUF,W
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
	goto	SysForLoop5
SysForLoopEnd5
;End if
ENDIF57
;ENC28j60_Deselect
	bsf	LATA,5
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
;HSerPrint "$"
;HSerPrint banktobeselected
;HSerPrint ":"
;'These registers (EIE, EIR, ESTAT, ECON2, ECON1)
;'are present in all banks, no need to switch bank
;if lastselectedBank <> banktobeselected then
	banksel	BANKTOBESELECTED
	movf	BANKTOBESELECTED,W
	subwf	LASTSELECTEDBANK,W
	btfsc	STATUS, Z
	goto	ENDIF8
;if ( ( addr & ADDR_MASK ) <= EIE  ) then
	movlw	31
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
	goto	ELSE9_1
;ENC28j60_selectBank ( banktobeselected, addr )
	pagesel	ENC28J60_SELECTBANK
	call	ENC28J60_SELECTBANK
	pagesel	$

;else
	goto	ENDIF9
ELSE9_1
;lastselectedBank = banktobeselected
	movf	BANKTOBESELECTED,W
	movwf	LASTSELECTEDBANK
;end if
ENDIF9
;end if
ENDIF8
;ENC28j60_Select
	bcf	LATA,5
;Set WCOL Off
	banksel	SSP1CON1
	bcf	SSP1CON1,WCOL
;SSPBUF = ENC28j60_READ_CTRL_REG | ( addr AND ADDR_MASK )
	movlw	31
	banksel	ADDR
	andwf	ADDR,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	SSP1BUF
	movwf	SSP1BUF
;Wait While BF = Off
SysWaitLoop3
	btfss	SSP1STAT,BF
	goto	SysWaitLoop3
;temp = SSPBUF
	movf	SSP1BUF,W
	banksel	TEMP
	movwf	TEMP
;Set WCOL Off
	banksel	SSP1CON1
	bcf	SSP1CON1,WCOL
;SSPBUF = temp
	banksel	TEMP
	movf	TEMP,W
	banksel	SSP1BUF
	movwf	SSP1BUF
;Wait While BF = Off
SysWaitLoop4
	btfss	SSP1STAT,BF
	goto	SysWaitLoop4
;temp = SSPBUF
	movf	SSP1BUF,W
	banksel	TEMP
	movwf	TEMP
;Set WCOL Off
	banksel	SSP1CON1
	bcf	SSP1CON1,WCOL
;SSPBUF = temp
	banksel	TEMP
	movf	TEMP,W
	banksel	SSP1BUF
	movwf	SSP1BUF
;Wait While BF = Off
SysWaitLoop5
	btfss	SSP1STAT,BF
	goto	SysWaitLoop5
;ENC28j60_ReadReg = SSPBUF
	movf	SSP1BUF,W
	banksel	ENC28J60_READREG
	movwf	ENC28J60_READREG
;ENC28j60_Deselect
	bsf	LATA,5
	return

;********************************************************************************

ENC28J60_SNTP_GET
;T_enetpacketdest0 = ENC_MacAddRouter(1)
	banksel	SYSENC_MACADDROUTER_1
	movf	SYSENC_MACADDROUTER_1,W
	banksel	SYSETHERBUFFER_1
	movwf	SYSETHERBUFFER_1
;T_enetpacketdest1 = ENC_MacAddRouter(2)
	banksel	SYSENC_MACADDROUTER_2
	movf	SYSENC_MACADDROUTER_2,W
	banksel	SYSETHERBUFFER_2
	movwf	SYSETHERBUFFER_2
;T_enetpacketdest2 = ENC_MacAddRouter(3)
	banksel	SYSENC_MACADDROUTER_3
	movf	SYSENC_MACADDROUTER_3,W
	banksel	SYSETHERBUFFER_3
	movwf	SYSETHERBUFFER_3
;T_enetpacketdest3 = ENC_MacAddRouter(4)
	banksel	SYSENC_MACADDROUTER_4
	movf	SYSENC_MACADDROUTER_4,W
	banksel	SYSETHERBUFFER_4
	movwf	SYSETHERBUFFER_4
;T_enetpacketdest4 = ENC_MacAddRouter(5)
	banksel	SYSENC_MACADDROUTER_5
	movf	SYSENC_MACADDROUTER_5,W
	banksel	SYSETHERBUFFER_5
	movwf	SYSETHERBUFFER_5
;T_enetpacketdest5 = ENC_MacAddRouter(6)
	banksel	SYSENC_MACADDROUTER_6
	movf	SYSENC_MACADDROUTER_6,W
	banksel	SYSETHERBUFFER_6
	movwf	SYSETHERBUFFER_6
;T_enetpacketsrc0 = ENC_MacAddr(1)
	banksel	SYSENC_MACADDR_1
	movf	SYSENC_MACADDR_1,W
	banksel	SYSETHERBUFFER_7
	movwf	SYSETHERBUFFER_7
;T_enetpacketsrc1 = ENC_MacAddr(2)
	banksel	SYSENC_MACADDR_2
	movf	SYSENC_MACADDR_2,W
	banksel	SYSETHERBUFFER_8
	movwf	SYSETHERBUFFER_8
;T_enetpacketsrc2 = ENC_MacAddr(3)
	banksel	SYSENC_MACADDR_3
	movf	SYSENC_MACADDR_3,W
	banksel	SYSETHERBUFFER_9
	movwf	SYSETHERBUFFER_9
;T_enetpacketsrc3 = ENC_MacAddr(4)
	banksel	SYSENC_MACADDR_4
	movf	SYSENC_MACADDR_4,W
	banksel	SYSETHERBUFFER_10
	movwf	SYSETHERBUFFER_10
;T_enetpacketsrc4 = ENC_MacAddr(5)
	banksel	SYSENC_MACADDR_5
	movf	SYSENC_MACADDR_5,W
	banksel	SYSETHERBUFFER_11
	movwf	SYSETHERBUFFER_11
;T_enetpacketsrc5 = ENC_MacAddr(6)
	banksel	SYSENC_MACADDR_6
	movf	SYSENC_MACADDR_6,W
	banksel	SYSETHERBUFFER_12
	movwf	SYSETHERBUFFER_12
;T_enetpackettype0 = 0X08
	movlw	8
	movwf	SYSETHERBUFFER_13
;T_enetpackettype1 = 0X00                              ' = 0X0800
	clrf	SYSETHERBUFFER_14
;T_ip_vers_len = 0X45
	movlw	69
	movwf	SYSETHERBUFFER_15
;T_tos = 0X00
	clrf	SYSETHERBUFFER_16
;T_ip_pktlen0 = 0X00
	clrf	SYSETHERBUFFER_17
;T_ip_pktlen1 = 0X30
	movlw	48
	movwf	SYSETHERBUFFER_18
;T_id0 = 0X4A
	movlw	74
	movwf	SYSETHERBUFFER_19
;T_id1 = 0XA5
	movlw	165
	movwf	SYSETHERBUFFER_20
;T_flags = 0X00
	clrf	SYSETHERBUFFER_21
;T_offset = 0X00
	clrf	SYSETHERBUFFER_22
;T_ttl = 0X80
	movlw	128
	movwf	SYSETHERBUFFER_23
;T_ip_proto = 0X11
	movlw	17
	movwf	SYSETHERBUFFER_24
;T_ip_srcaddr0 = ENC_IpAddr(1)
	banksel	SYSENC_IPADDR_1
	movf	SYSENC_IPADDR_1,W
	banksel	SYSETHERBUFFER_27
	movwf	SYSETHERBUFFER_27
;T_ip_srcaddr1 = ENC_IpAddr(2)
	banksel	SYSENC_IPADDR_2
	movf	SYSENC_IPADDR_2,W
	banksel	SYSETHERBUFFER_28
	movwf	SYSETHERBUFFER_28
;T_ip_srcaddr2 = ENC_IpAddr(3)
	banksel	SYSENC_IPADDR_3
	movf	SYSENC_IPADDR_3,W
	banksel	SYSETHERBUFFER_29
	movwf	SYSETHERBUFFER_29
;T_ip_srcaddr3 = ENC_IpAddr(4)
	banksel	SYSENC_IPADDR_4
	movf	SYSENC_IPADDR_4,W
	banksel	SYSETHERBUFFER_30
	movwf	SYSETHERBUFFER_30
;T_ip_destaddr0 = ENC_SntpServerAddr(1)
	banksel	SYSENC_SNTPSERVERADDR_1
	movf	SYSENC_SNTPSERVERADDR_1,W
	banksel	SYSETHERBUFFER_31
	movwf	SYSETHERBUFFER_31
;T_ip_destaddr1 = ENC_SntpServerAddr(2)
	banksel	SYSENC_SNTPSERVERADDR_2
	movf	SYSENC_SNTPSERVERADDR_2,W
	banksel	SYSETHERBUFFER_32
	movwf	SYSETHERBUFFER_32
;T_ip_destaddr2 = ENC_SntpServerAddr(3)
	banksel	SYSENC_SNTPSERVERADDR_3
	movf	SYSENC_SNTPSERVERADDR_3,W
	banksel	SYSETHERBUFFER_33
	movwf	SYSETHERBUFFER_33
;T_ip_destaddr3 = ENC_SntpServerAddr(4)
	banksel	SYSENC_SNTPSERVERADDR_4
	movf	SYSENC_SNTPSERVERADDR_4,W
	banksel	SYSETHERBUFFER_34
	movwf	SYSETHERBUFFER_34
;T_udp_srcport0 = 0X13
	movlw	19
	movwf	SYSETHERBUFFER_35
;T_udp_srcport1 = 0X88
	movlw	136
	movwf	SYSETHERBUFFER_36
;T_udp_destport0 = 0X00                                        'port 0025 = 37 SNTP
	clrf	SYSETHERBUFFER_37
;T_udp_destport1 = 0X25
	movlw	37
	movwf	SYSETHERBUFFER_38
;T_udp_len0 = 0X00
	clrf	SYSETHERBUFFER_39
;T_udp_len1 = 0X1C
	movlw	28
	movwf	SYSETHERBUFFER_40
;T_udp_data0 = 0X58 'Asc( "X")
	movlw	88
	movwf	SYSETHERBUFFER_43
;T_udp_data1 = 0X0A ' lf
	movlw	10
	movwf	SYSETHERBUFFER_44
;T_udp_data2 = 0X0D ' cr
	movlw	13
	movwf	SYSETHERBUFFER_45
;T_udp_data4 = 0
	clrf	SYSETHERBUFFER_47
;T_udp_data5 = 0
	clrf	SYSETHERBUFFER_48
;T_udp_data6 = 0
	clrf	SYSETHERBUFFER_49
;T_udp_data7 = 0
	clrf	SYSETHERBUFFER_50
;T_udp_data8 = 0
	clrf	SYSETHERBUFFER_51
;T_udp_data9 = 0
	clrf	SYSETHERBUFFER_52
;T_udp_data10 = 0
	clrf	SYSETHERBUFFER_53
;T_udp_data11 = 0
	clrf	SYSETHERBUFFER_54
;T_udp_data12 = 0
	clrf	SYSETHERBUFFER_55
;T_udp_data13 = 0
	clrf	SYSETHERBUFFER_56
;T_udp_data14 = 0
	clrf	SYSETHERBUFFER_57
;T_udp_data15 = 0
	clrf	SYSETHERBUFFER_58
;T_udp_data16 = 0
	clrf	SYSETHERBUFFER_59
;T_udp_data17 = 0
	clrf	SYSETHERBUFFER_60
;T_udp_data18 = 0
	clrf	SYSETHERBUFFER_61
;T_udp_data19 = 0
	clrf	SYSETHERBUFFER_62
;T_udp_data20 = 0
	clrf	SYSETHERBUFFER_63
;T_udp_data21 = 0
	clrf	SYSETHERBUFFER_64
;T_udp_data22 = 0
	clrf	SYSETHERBUFFER_65
;T_udp_data23 = 0
	clrf	SYSETHERBUFFER_66
;T_udp_data24 = 0
	clrf	SYSETHERBUFFER_67
;T_udp_data25 = 0
	clrf	SYSETHERBUFFER_68
;T_udp_data26 = 0
	clrf	SYSETHERBUFFER_69
;T_udp_data27 = 0
	clrf	SYSETHERBUFFER_70
;ENC28j60_Ip_header_checksum
	banksel	STATUS
	pagesel	ENC28J60_IP_HEADER_CHECKSUM
	call	ENC28J60_IP_HEADER_CHECKSUM
	pagesel	$

;ENC28j60_Udp_checksum
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
;ENC28j60_writebuffer( 45 )
	movlw	45
	banksel	PCKTLEN
	movwf	PCKTLEN
	clrf	PCKTLEN_H
	banksel	STATUS
	call	ENC28J60_WRITEBUFFER

;ENC28j60_packetsend( hulp2 )
	movf	HULP2,W
	banksel	PCKTLEN
	movwf	PCKTLEN
	banksel	HULP2_H
	movf	HULP2_H,W
	banksel	PCKTLEN_H
	movwf	PCKTLEN_H
	banksel	STATUS
	call	ENC28J60_PACKETSEND

	return

;********************************************************************************

ENC28J60_WRITEBUFFER
;dim eth_counter as Word
;ENC28j60_writeReg(ewrptl, ENC_TXBUF_STL)
	movlw	2
	movwf	ADDR
	movlw	112
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$

;ENC28j60_writeReg(ewrpth, ENC_TXBUF_STH)
	movlw	3
	movwf	ADDR
	movlw	22
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$

;ENC28j60_Select
	bcf	LATA,5
;Set WCOL Off
	banksel	SSP1CON1
	bcf	SSP1CON1,WCOL
;SSPBUF = ENC28j60_write_buf_mem
	movlw	122
	movwf	SSP1BUF
;Wait While BF = Off
SysWaitLoop6
	btfss	SSP1STAT,BF
	goto	SysWaitLoop6
;temp = SSPBUF
	movf	SSP1BUF,W
	banksel	TEMP
	movwf	TEMP
;SSPBUF = 0x0E
	movlw	14
	banksel	SSP1BUF
	movwf	SSP1BUF
;Wait While BF = Off
SysWaitLoop7
	btfss	SSP1STAT,BF
	goto	SysWaitLoop7
;temp = SSPBUF
	movf	SSP1BUF,W
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
	goto	SysForLoopEnd1
SysForLoop1
	incf	ETH_COUNTER,F
	btfsc	STATUS,Z
	incf	ETH_COUNTER_H,F
;if eth_counter > etherBufferSize then Exit For
	movf	ETH_COUNTER,W
	movwf	SysWORDTempB
	movf	ETH_COUNTER_H,W
	movwf	SysWORDTempB_H
	movlw	232
	movwf	SysWORDTempA
	movlw	3
	movwf	SysWORDTempA_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd1
;SSPBUF = etherbuffer(eth_counter)
	movlw	low(ETHERBUFFER)
	addwf	ETH_COUNTER,W
	movwf	AFSR0
	movlw	high(ETHERBUFFER)
	addwfc	ETH_COUNTER_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SSP1BUF
	movwf	SSP1BUF
;Wait While BF = Off
SysWaitLoop8
	btfss	SSP1STAT,BF
	goto	SysWaitLoop8
;temp = SSPBUF
	movf	SSP1BUF,W
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
	goto	SysForLoop1
SysForLoopEnd1
;ENC28j60_Deselect
	bsf	LATA,5
	return

;********************************************************************************

;Overloaded signature: BYTE:byte:
HSERPRINT264
;OutValueTemp = 0
	banksel	OUTVALUETEMP
	clrf	OUTVALUETEMP
;IF SerPrintVal >= 100 Then
	movlw	100
	subwf	SERPRINTVAL,W
	btfss	STATUS, C
	goto	ENDIF127
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
ENDIF127
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
	banksel	SYSTEMP1
	movwf	SysTemp1
	btfss	SysTemp1,0
	goto	ENDIF128
;OutValueTemp = SerPrintVal / 10
	banksel	SERPRINTVAL
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
ENDIF128
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

;Overloaded signature: WORD:byte:
HSERPRINT265
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
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF129
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
;Goto HSerPrintWord1000
	goto	HSERPRINTWORD1000
;End If
ENDIF129
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
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF130
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
;Goto HSerPrintWord100
	goto	HSERPRINTWORD100
;End If
ENDIF130
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
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF131
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
;Goto HSerPrintWord10
	goto	HSERPRINTWORD10
;End If
ENDIF131
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
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF132
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
ENDIF132
;HSerSend(SerPrintVal + 48 ,comport  )
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

;Overloaded signature: LONG:byte:
HSERPRINT267
;Dim SysCalcTempA As Long
;Dim SysPrintBuffer(10)
;SysPrintBuffLen = 0
	banksel	SYSPRINTBUFFLEN
	clrf	SYSPRINTBUFFLEN
;Do
SysDoLoop_S5
;SysPrintBuffLen += 1
	banksel	SYSPRINTBUFFLEN
	incf	SYSPRINTBUFFLEN,F
;SysPrintBuffer(SysPrintBuffLen) = SerPrintVal % 10
	movlw	low(SYSPRINTBUFFER)
	addwf	SYSPRINTBUFFLEN,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	high(SYSPRINTBUFFER)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	banksel	SERPRINTVAL
	movf	SERPRINTVAL,W
	movwf	SysLONGTempA
	movf	SERPRINTVAL_H,W
	movwf	SysLONGTempA_H
	movf	SERPRINTVAL_U,W
	movwf	SysLONGTempA_U
	movf	SERPRINTVAL_E,W
	movwf	SysLONGTempA_E
	movlw	10
	movwf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	banksel	STATUS
	call	SysDivSub32
	movf	SysLONGTempX,W
	movwf	INDF0
;SerPrintVal = SysCalcTempA
	movf	SYSCALCTEMPA,W
	banksel	SERPRINTVAL
	movwf	SERPRINTVAL
	movf	SYSCALCTEMPA_H,W
	movwf	SERPRINTVAL_H
	movf	SYSCALCTEMPA_U,W
	movwf	SERPRINTVAL_U
	movf	SYSCALCTEMPA_E,W
	movwf	SERPRINTVAL_E
;Loop While SerPrintVal <> 0
	movf	serprintval,W
	movwf	SysLONGTempA
	movf	serprintval_H,W
	movwf	SysLONGTempA_H
	movf	serprintval_U,W
	movwf	SysLONGTempA_U
	movf	serprintval_E,W
	movwf	SysLONGTempA_E
	clrf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SysCompEqual32
	call	SysCompEqual32
	pagesel	$
	comf	SysByteTempX,F
	btfsc	SysByteTempX,0
	goto	SysDoLoop_S5
SysDoLoop_E5
;For SysPrintTemp = SysPrintBuffLen To 1 Step -1
	banksel	SYSPRINTBUFFLEN
	incf	SYSPRINTBUFFLEN,W
	movwf	SYSPRINTTEMP
	movlw	1
	subwf	SYSPRINTBUFFLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd7
SysForLoop7
	decf	SYSPRINTTEMP,F
;HSerSend(SysPrintBuffer(SysPrintTemp) + 48, comport  )
	movlw	low(SYSPRINTBUFFER)
	addwf	SYSPRINTTEMP,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	high(SYSPRINTBUFFER)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movlw	48
	addwf	INDF0,W
	banksel	SERDATA
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
;Next
	banksel	SYSPRINTTEMP
	movf	SYSPRINTTEMP,W
	sublw	1
	btfss	STATUS, C
	goto	SysForLoop7
SysForLoopEnd7
	banksel	STATUS
	return

;********************************************************************************

HTTPCOMMANDLINE
;dim CommandLineString as string * 12
;dim zzz, TableLoc as word
;TableLoc = 1
	movlw	1
	banksel	TABLELOC
	movwf	TABLELOC
	clrf	TABLELOC_H
;For zz = 1 to 2
	clrf	ZZ
SysForLoop12
	incf	ZZ,F
;For TableLoc = 40 To 120
	movlw	39
	movwf	TABLELOC
	clrf	TABLELOC_H
SysForLoop13
	banksel	TABLELOC
	incf	TABLELOC,F
	btfsc	STATUS,Z
	incf	TABLELOC_H,F
;GetString ( TableLoc )
	movf	TABLELOC,W
	banksel	ETHERBUFFERINDEX
	movwf	ETHERBUFFERINDEX
	banksel	TABLELOC_H
	movf	TABLELOC_H,W
	banksel	ETHERBUFFERINDEX_H
	movwf	ETHERBUFFERINDEX_H
	pagesel	GETSTRING
	call	GETSTRING
	pagesel	$

;if zz = 1 then
	banksel	ZZ
	decf	ZZ,W
	btfss	STATUS, Z
	goto	ELSE107_1
;If Left(CommandLineString,5) = "GET /" Then
	movlw	low COMMANDLINESTRING
	banksel	SYSSYSINSTRINGHANDLER
	movwf	SysSYSINSTRINGHandler
	movlw	high COMMANDLINESTRING
	movwf	SysSYSINSTRINGHandler_H
	movlw	5
	movwf	SYSCHARCOUNT
	banksel	STATUS
	pagesel	FN_LEFT
	call	FN_LEFT
	pagesel	$
	movlw	low SYSTEMPARRAY
	movwf	FSR1L
	movlw	high SYSTEMPARRAY
	movwf	FSR1H
	movlw	low StringTable111
	movwf	SysStringA
	movlw	(high StringTable111) & 127
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low LEFT
	movwf	FSR0L
	movlw	high LEFT
	movwf	FSR0H
	movlw	low SYSTEMPARRAY
	movwf	FSR1L
	movlw	high SYSTEMPARRAY
	movwf	FSR1H
	pagesel	SysCompEqualString
	call	SysCompEqualString
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF110
;HSerPrintCRLF
;HSerPrint "%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
;HSerPrintCRLF
;HSerPrint commandlineString
;HSerPrintCRLF
;HSerPrint "%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
;HSerPrintCRLF
;lastGet = 1
	movlw	1
	movwf	LASTGET
;TableLoc += 5
	movlw	5
	banksel	TABLELOC
	addwf	TABLELOC,F
	movlw	0
	addwfc	TABLELOC_H,F
;GetString ( TableLoc )
	movf	TABLELOC,W
	banksel	ETHERBUFFERINDEX
	movwf	ETHERBUFFERINDEX
	banksel	TABLELOC_H
	movf	TABLELOC_H,W
	banksel	ETHERBUFFERINDEX_H
	movwf	ETHERBUFFERINDEX_H
	pagesel	GETSTRING
	call	GETSTRING
	pagesel	$

;HSerPrintCRLF
;HSerPrint "%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
;HSerPrintCRLF
;HSerPrint commandlineString
;HSerPrintCRLF
;HSerPrint "%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
;HSerPrintCRLF
;If Left(CommandLineString , 6) = " HTTP/" Then
	movlw	low COMMANDLINESTRING
	banksel	SYSSYSINSTRINGHANDLER
	movwf	SysSYSINSTRINGHandler
	movlw	high COMMANDLINESTRING
	movwf	SysSYSINSTRINGHandler_H
	movlw	6
	movwf	SYSCHARCOUNT
	banksel	STATUS
	pagesel	FN_LEFT
	call	FN_LEFT
	pagesel	$
	movlw	low SYSTEMPARRAY
	movwf	FSR1L
	movlw	high SYSTEMPARRAY
	movwf	FSR1H
	movlw	low StringTable112
	movwf	SysStringA
	movlw	(high StringTable112) & 127
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low LEFT
	movwf	FSR0L
	movlw	high LEFT
	movwf	FSR0H
	movlw	low SYSTEMPARRAY
	movwf	FSR1L
	movlw	high SYSTEMPARRAY
	movwf	FSR1H
	pagesel	SysCompEqualString
	call	SysCompEqualString
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF112
;CommandLineString = "index.htm"
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
;Exit sub
	return
;End if
ENDIF112
;Exit For  'no longer look for GET / as we have found it.
	goto	SysForLoopEnd13
;End IF
ENDIF110
;Else
	goto	ENDIF107
ELSE107_1
;if lastGet = 1 then
	banksel	LASTGET
	decf	LASTGET,W
	btfss	STATUS, Z
	goto	ENDIF111
;HSerPrint "!!"
;HSerPrintCRLF
;zzz = instr( CommandLineString , " " )
	movlw	low COMMANDLINESTRING
	banksel	SYSSYSINSTRINGHANDLER
	movwf	SysSYSINSTRINGHandler
	movlw	high COMMANDLINESTRING
	movwf	SysSYSINSTRINGHandler_H
	movlw	low StringTable78
	movwf	SysSYSFINDSTRINGHandler
	movlw	(high StringTable78) | 128
	movwf	SysSYSFINDSTRINGHandler_H
	banksel	STATUS
	call	FN_INSTR
	movf	INSTR,W
	banksel	ZZZ
	movwf	ZZZ
	clrf	ZZZ_H
;CommandLineString = left( CommandLineString, zzz - 1 )
	movlw	low COMMANDLINESTRING
	banksel	SYSSYSINSTRINGHANDLER
	movwf	SysSYSINSTRINGHandler
	movlw	high COMMANDLINESTRING
	movwf	SysSYSINSTRINGHandler_H
	banksel	ZZZ
	decf	ZZZ,W
	banksel	SYSCHARCOUNT
	movwf	SYSCHARCOUNT
	banksel	STATUS
	pagesel	FN_LEFT
	call	FN_LEFT
	pagesel	$
	movlw	low COMMANDLINESTRING
	movwf	FSR1L
	movlw	high COMMANDLINESTRING
	movwf	FSR1H
	movlw	low LEFT
	movwf	FSR0L
	movlw	high LEFT
	movwf	FSR0H
	pagesel	SysCopyString
	call	SysCopyString
	pagesel	$
;end if
ENDIF111
;exit sub
	return
;End if
ENDIF107
;Next
	banksel	TABLELOC
	movf	TABLELOC,W
	movwf	SysWORDTempA
	movf	TABLELOC_H,W
	movwf	SysWORDTempA_H
	movlw	120
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop13
SysForLoopEnd13
;Next
	movlw	2
	banksel	ZZ
	subwf	ZZ,W
	btfss	STATUS, C
	goto	SysForLoop12
SysForLoopEnd12
;CommandLineString = "400"
	movlw	low COMMANDLINESTRING
	movwf	FSR1L
	movlw	high COMMANDLINESTRING
	movwf	FSR1H
	movlw	low StringTable113
	movwf	SysStringA
	movlw	(high StringTable113) & 127
	movwf	SysStringA_H
	banksel	STATUS
	pagesel	SysReadString
	goto	SysReadString

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
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	0
	banksel	ARRAYLOC_H
	addwfc	ARRAYLOC_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	movlw	6
	addwf	SysTemp1,W
	banksel	HULP2
	movwf	HULP2
	movlw	0
	banksel	SYSTEMP1_H
	addwfc	SysTemp1_H,W
	banksel	HULP2_H
	movwf	HULP2_H
;If hulp2 > etherBufferSize Then
	movf	HULP2,W
	movwf	SysWORDTempB
	movf	HULP2_H,W
	movwf	SysWORDTempB_H
	movlw	232
	movwf	SysWORDTempA
	movlw	3
	movwf	SysWORDTempA_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF101
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$

;HSerPrint "empty the buffer"
	movlw	low StringTable105
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable105) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT263
	call	HSERPRINT263
	pagesel	$

;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$

;HTTPSend ( false )
	clrf	HTTPCLOSETRANSACTION
	pagesel	HTTPSEND
	call	HTTPSEND
	pagesel	$

;arrayloc = 0x0037   'start of HTTP header within the TCP Packet
	movlw	55
	movwf	ARRAYLOC
	clrf	ARRAYLOC_H
;HTTPSentTCPPacket = 1
	movlw	1
	movwf	HTTPSENTTCPPACKET
;End IF
ENDIF101
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
	goto	SysForLoopEnd11
SysForLoop11
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
	goto	SysForLoop11
SysForLoopEnd11
;if HTTPPrintCRLFflag = 1 then
	banksel	HTTPPRINTCRLFFLAG
	decf	HTTPPRINTCRLFFLAG,W
	btfss	STATUS, Z
	goto	ENDIF104
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
ENDIF104
	return

;********************************************************************************

FN_INSTR
;Instr = 0
	clrf	INSTR
;SysStrLen = SysInString(0)
	banksel	SYSSYSINSTRINGHANDLER
	movf	SysSYSINSTRINGHandler,W
	movwf	AFSR0
	movf	SysSYSINSTRINGHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SYSSTRLEN
;If SysStrLen = 0 Then Exit Function
	movf	SYSSTRLEN,F
	btfss	STATUS, Z
	goto	ENDIF115
	banksel	STATUS
	return
ENDIF115
;SysFindLen = SysFindString(0)
	movf	SysSYSFINDSTRINGHandler,W
	movwf	AFSR0
	movf	SysSYSFINDSTRINGHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SYSFINDLEN
;If SysFindLen = 0 Then Exit Function
	movf	SYSFINDLEN,F
	btfss	STATUS, Z
	goto	ENDIF116
	banksel	STATUS
	return
ENDIF116
;If SysFindLen > SysStrLen Then Exit Function
	movf	SYSFINDLEN,W
	subwf	SYSSTRLEN,W
	btfsc	STATUS, C
	goto	ENDIF117
	banksel	STATUS
	return
ENDIF117
;SysSearchEnd = SysStrLen - SysFindLen
	movf	SYSFINDLEN,W
	subwf	SYSSTRLEN,W
	movwf	SYSSEARCHEND
;For SysStringTemp = 0 to SysSearchEnd
	movlw	255
	movwf	SYSSTRINGTEMP
	movlw	0
	subwf	SYSSEARCHEND,W
	btfss	STATUS, C
	goto	SysForLoopEnd14
SysForLoop14
	incf	SYSSTRINGTEMP,F
;For SysStrData = 1 To SysFindLen
	clrf	SYSSTRDATA
	movlw	1
	subwf	SYSFINDLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd15
SysForLoop15
	incf	SYSSTRDATA,F
;If SysInString(SysStringTemp + SysStrData) <> SysFindString(SysStrData) Then Goto SysInstrNextPos
	movf	SYSSTRINGTEMP,W
	addwf	SysSYSINSTRINGHandler,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	0
	banksel	SYSSYSINSTRINGHANDLER_H
	addwfc	SysSYSINSTRINGHandler_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	banksel	SYSSTRDATA
	movf	SYSSTRDATA,W
	banksel	SYSTEMP1
	addwf	SysTemp1,W
	movwf	AFSR0
	movlw	0
	addwfc	SysTemp1_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP1
	movwf	SysArrayTemp1
	movf	SYSSTRDATA,W
	addwf	SysSYSFINDSTRINGHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysSYSFINDSTRINGHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SysArrayTemp2
	subwf	SYSARRAYTEMP1,W
	btfss	STATUS, Z
	goto	SYSINSTRNEXTPOS
;Next
	movf	SYSFINDLEN,W
	subwf	SYSSTRDATA,W
	btfss	STATUS, C
	goto	SysForLoop15
SysForLoopEnd15
;Instr = SysStringTemp + 1
	incf	SYSSTRINGTEMP,W
	banksel	INSTR
	movwf	INSTR
;Exit Function
	return
SYSINSTRNEXTPOS
;Next
	movf	SYSSEARCHEND,W
	subwf	SYSSTRINGTEMP,W
	btfss	STATUS, C
	goto	SysForLoop14
SysForLoopEnd14
;Instr = 0
	banksel	INSTR
	clrf	INSTR
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

SYSDIVSUB32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysLongTempX as long
;dim SysLongDivMultA as long
;dim SysLongDivMultB as long
;dim SysLongDivMultX as long
;SysLongDivMultA = SysLongTempA
	movf	SYSLONGTEMPA,W
	banksel	SYSLONGDIVMULTA
	movwf	SYSLONGDIVMULTA
	movf	SYSLONGTEMPA_H,W
	movwf	SYSLONGDIVMULTA_H
	movf	SYSLONGTEMPA_U,W
	movwf	SYSLONGDIVMULTA_U
	movf	SYSLONGTEMPA_E,W
	movwf	SYSLONGDIVMULTA_E
;SysLongDivMultB = SysLongTempB
	movf	SYSLONGTEMPB,W
	movwf	SYSLONGDIVMULTB
	movf	SYSLONGTEMPB_H,W
	movwf	SYSLONGDIVMULTB_H
	movf	SYSLONGTEMPB_U,W
	movwf	SYSLONGDIVMULTB_U
	movf	SYSLONGTEMPB_E,W
	movwf	SYSLONGDIVMULTB_E
;SysLongDivMultX = 0
	clrf	SYSLONGDIVMULTX
	clrf	SYSLONGDIVMULTX_H
	clrf	SYSLONGDIVMULTX_U
	clrf	SYSLONGDIVMULTX_E
;if SysLongDivMultB = 0 then
	movf	SYSLONGDIVMULTB,W
	movwf	SysLONGTempA
	movf	SYSLONGDIVMULTB_H,W
	movwf	SysLONGTempA_H
	movf	SYSLONGDIVMULTB_U,W
	movwf	SysLONGTempA_U
	movf	SYSLONGDIVMULTB_E,W
	movwf	SysLONGTempA_E
	clrf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SysCompEqual32
	call	SysCompEqual32
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF68
;SysLongTempA = 0
	clrf	SYSLONGTEMPA
	clrf	SYSLONGTEMPA_H
	clrf	SYSLONGTEMPA_U
	clrf	SYSLONGTEMPA_E
;exit sub
	return
;end if
ENDIF68
;SysDivLoop = 32
	movlw	32
	movwf	SYSDIVLOOP
SYSDIV32START
;set C off
	bcf	STATUS,C
;Rotate SysLongDivMultA Left
	banksel	SYSLONGDIVMULTA
	rlf	SYSLONGDIVMULTA,F
	rlf	SYSLONGDIVMULTA_H,F
	rlf	SYSLONGDIVMULTA_U,F
	rlf	SYSLONGDIVMULTA_E,F
;Rotate SysLongDivMultX Left
	rlf	SYSLONGDIVMULTX,F
	rlf	SYSLONGDIVMULTX_H,F
	rlf	SYSLONGDIVMULTX_U,F
	rlf	SYSLONGDIVMULTX_E,F
;SysLongDivMultX = SysLongDivMultX - SysLongDivMultB
	movf	SYSLONGDIVMULTB,W
	subwf	SYSLONGDIVMULTX,F
	movf	SYSLONGDIVMULTB_H,W
	subwfb	SYSLONGDIVMULTX_H,F
	movf	SYSLONGDIVMULTB_U,W
	subwfb	SYSLONGDIVMULTX_U,F
	movf	SYSLONGDIVMULTB_E,W
	subwfb	SYSLONGDIVMULTX_E,F
;Set SysLongDivMultA.0 On
	bsf	SYSLONGDIVMULTA,0
;If C Off Then
	btfsc	STATUS,C
	goto	ENDIF69
;Set SysLongDivMultA.0 Off
	bcf	SYSLONGDIVMULTA,0
;SysLongDivMultX = SysLongDivMultX + SysLongDivMultB
	movf	SYSLONGDIVMULTB,W
	addwf	SYSLONGDIVMULTX,F
	movf	SYSLONGDIVMULTB_H,W
	addwfc	SYSLONGDIVMULTX_H,F
	movf	SYSLONGDIVMULTB_U,W
	addwfc	SYSLONGDIVMULTX_U,F
	movf	SYSLONGDIVMULTB_E,W
	addwfc	SYSLONGDIVMULTX_E,F
;End If
ENDIF69
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F
;goto SysDiv32Start
	goto	SYSDIV32START
;SysLongTempA = SysLongDivMultA
	movf	SYSLONGDIVMULTA,W
	movwf	SYSLONGTEMPA
	movf	SYSLONGDIVMULTA_H,W
	movwf	SYSLONGTEMPA_H
	movf	SYSLONGDIVMULTA_U,W
	movwf	SYSLONGTEMPA_U
	movf	SYSLONGDIVMULTA_E,W
	movwf	SYSLONGTEMPA_E
;SysLongTempX = SysLongDivMultX
	movf	SYSLONGDIVMULTX,W
	movwf	SYSLONGTEMPX
	movf	SYSLONGDIVMULTX_H,W
	movwf	SYSLONGTEMPX_H
	movf	SYSLONGDIVMULTX_U,W
	movwf	SYSLONGTEMPX_U
	movf	SYSLONGDIVMULTX_E,W
	movwf	SYSLONGTEMPX_E
	banksel	STATUS
	return

;********************************************************************************

SYSMULTSUB32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysLongTempX as long
;dim SysLongDivMultA as long
;dim SysLongDivMultB as long
;dim SysLongDivMultX as long
;SysLongDivMultA = SysLongTempA
	movf	SYSLONGTEMPA,W
	banksel	SYSLONGDIVMULTA
	movwf	SYSLONGDIVMULTA
	movf	SYSLONGTEMPA_H,W
	movwf	SYSLONGDIVMULTA_H
	movf	SYSLONGTEMPA_U,W
	movwf	SYSLONGDIVMULTA_U
	movf	SYSLONGTEMPA_E,W
	movwf	SYSLONGDIVMULTA_E
;SysLongDivMultB = SysLongTempB
	movf	SYSLONGTEMPB,W
	movwf	SYSLONGDIVMULTB
	movf	SYSLONGTEMPB_H,W
	movwf	SYSLONGDIVMULTB_H
	movf	SYSLONGTEMPB_U,W
	movwf	SYSLONGDIVMULTB_U
	movf	SYSLONGTEMPB_E,W
	movwf	SYSLONGDIVMULTB_E
;SysLongDivMultX = 0
	clrf	SYSLONGDIVMULTX
	clrf	SYSLONGDIVMULTX_H
	clrf	SYSLONGDIVMULTX_U
	clrf	SYSLONGDIVMULTX_E
MUL32LOOP
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
	banksel	SYSLONGDIVMULTB
	btfss	SYSLONGDIVMULTB,0
	goto	ENDIF66
	movf	SYSLONGDIVMULTA,W
	addwf	SYSLONGDIVMULTX,F
	movf	SYSLONGDIVMULTA_H,W
	addwfc	SYSLONGDIVMULTX_H,F
	movf	SYSLONGDIVMULTA_U,W
	addwfc	SYSLONGDIVMULTX_U,F
	movf	SYSLONGDIVMULTA_E,W
	addwfc	SYSLONGDIVMULTX_E,F
ENDIF66
;set STATUS.C OFF
	bcf	STATUS,C
;rotate SysLongDivMultB right
	rrf	SYSLONGDIVMULTB_E,F
	rrf	SYSLONGDIVMULTB_U,F
	rrf	SYSLONGDIVMULTB_H,F
	rrf	SYSLONGDIVMULTB,F
;set STATUS.C off
	bcf	STATUS,C
;rotate SysLongDivMultA left
	rlf	SYSLONGDIVMULTA,F
	rlf	SYSLONGDIVMULTA_H,F
	rlf	SYSLONGDIVMULTA_U,F
	rlf	SYSLONGDIVMULTA_E,F
;if SysLongDivMultB > 0 then goto MUL32LOOP
	movf	SYSLONGDIVMULTB,W
	movwf	SysLONGTempB
	movf	SYSLONGDIVMULTB_H,W
	movwf	SysLONGTempB_H
	movf	SYSLONGDIVMULTB_U,W
	movwf	SysLONGTempB_U
	movf	SYSLONGDIVMULTB_E,W
	movwf	SysLONGTempB_E
	clrf	SysLONGTempA
	clrf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	banksel	STATUS
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	btfsc	SysByteTempX,0
	goto	MUL32LOOP
;SysLongTempX = SysLongDivMultX
	banksel	SYSLONGDIVMULTX
	movf	SYSLONGDIVMULTX,W
	movwf	SYSLONGTEMPX
	movf	SYSLONGDIVMULTX_H,W
	movwf	SYSLONGTEMPX_H
	movf	SYSLONGDIVMULTX_U,W
	movwf	SYSLONGTEMPX_U
	movf	SYSLONGDIVMULTX_E,W
	movwf	SYSLONGTEMPX_E
	banksel	STATUS
	return

;********************************************************************************

;Start of program memory page 5
	ORG	10240
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

ENC28J60_BITCLEAR
;banktobeselected = ( addr & BANK_MASK) / 32
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
;if lastselectedBank <> banktobeselected then
	banksel	BANKTOBESELECTED
	movf	BANKTOBESELECTED,W
	subwf	LASTSELECTEDBANK,W
	btfsc	STATUS, Z
	goto	ELSE27_1
;if ( ( addr & ADDR_MASK )  <= EIE  ) then
	movlw	31
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
	goto	ENDIF28
;ENC28j60_selectBank ( banktobeselected, addr )
	call	ENC28J60_SELECTBANK

;end if
ENDIF28
;Else
	goto	ENDIF27
ELSE27_1
;lastselectedBank = banktobeselected
	movf	BANKTOBESELECTED,W
	movwf	LASTSELECTEDBANK
;end if
ENDIF27
;ENC28j60_Select
	bcf	LATA,5
;FastHWSPITransfer( ENC28j60_BIT_FIELD_CLR | (addr AND ADDR_MASK ), temp )
	movlw	31
	andwf	ADDR,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	160
	iorwf	SysTemp1,W
	banksel	SPITXDATA
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
	bsf	LATA,5
	return

;********************************************************************************

ENC28J60_BITSET
;banktobeselected = ( addr & BANK_MASK) / 32
;HSerPrintByteCRLF banktobeselected
;banktobeselected = ( addr & BANK_MASK)
	movlw	96
	andwf	ADDR,W
	movwf	BANKTOBESELECTED
;Repeat 5
	movlw	5
	banksel	SYSREPEATTEMP8
	movwf	SysRepeatTemp8
SysRepeatLoop8
;set c off
	bcf	STATUS,C
;rotate banktobeselected right
	banksel	BANKTOBESELECTED
	rrf	BANKTOBESELECTED,F
;end repeat
	banksel	SYSREPEATTEMP8
	decfsz	SysRepeatTemp8,F
	goto	SysRepeatLoop8
SysRepeatLoopEnd8
;HSerPrintByteCRLF banktobeselected
;HSerPrintCRLF
;if lastselectedBank <> banktobeselected then
	banksel	BANKTOBESELECTED
	movf	BANKTOBESELECTED,W
	subwf	LASTSELECTEDBANK,W
	btfsc	STATUS, Z
	goto	ELSE72_1
;if ( ( addr & ADDR_MASK )  <= EIE  ) then
	movlw	31
	andwf	ADDR,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movwf	SysBYTETempB
	movlw	27
	movwf	SysBYTETempA
	banksel	STATUS
	call	SysCompLessThan
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF73
;ENC28j60_selectBank ( banktobeselected, addr )
	call	ENC28J60_SELECTBANK

;end if
ENDIF73
;Else
	goto	ENDIF72
ELSE72_1
;lastselectedBank = banktobeselected
	movf	BANKTOBESELECTED,W
	movwf	LASTSELECTEDBANK
;end if
ENDIF72
;ENC28j60_Select
	bcf	LATA,5
;FastHWSPITransfer( ENC28j60_BIT_FIELD_SET | (addr AND ADDR_MASK ), temp )
	movlw	31
	andwf	ADDR,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	128
	iorwf	SysTemp2,W
	banksel	SPITXDATA
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
	bsf	LATA,5
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
	banksel	I_CHKSUM32
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
	banksel	SYSTEMP1
	movwf	SysTemp1
	clrf	SysTemp1_H
	btfsc	STATUS,C
	incf	SysTemp1_H,F
	movlw	1
	subwf	SysTemp1,W
	movwf	VAL2
	movlw	0
	subwfb	SysTemp1_H,W
	movwf	VAL2_H
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
	banksel	SYSETHERBUFFER_11
	movf	SYSETHERBUFFER_11,W
	banksel	SYSETHERBUFFER_5
	movwf	SYSETHERBUFFER_5
;T_enetpacketdest5 = T_enetpacketsrc5
	banksel	SYSETHERBUFFER_12
	movf	SYSETHERBUFFER_12,W
	banksel	SYSETHERBUFFER_6
	movwf	SYSETHERBUFFER_6
;T_enetpacketsrc0 = ENC_MacAddr(1)
	banksel	SYSENC_MACADDR_1
	movf	SYSENC_MACADDR_1,W
	banksel	SYSETHERBUFFER_7
	movwf	SYSETHERBUFFER_7
;T_enetpacketsrc1 = ENC_MacAddr(2)
	banksel	SYSENC_MACADDR_2
	movf	SYSENC_MACADDR_2,W
	banksel	SYSETHERBUFFER_8
	movwf	SYSETHERBUFFER_8
;T_enetpacketsrc2 = ENC_MacAddr(3)
	banksel	SYSENC_MACADDR_3
	movf	SYSENC_MACADDR_3,W
	banksel	SYSETHERBUFFER_9
	movwf	SYSETHERBUFFER_9
;T_enetpacketsrc3 = ENC_MacAddr(4)
	banksel	SYSENC_MACADDR_4
	movf	SYSENC_MACADDR_4,W
	banksel	SYSETHERBUFFER_10
	movwf	SYSETHERBUFFER_10
;T_enetpacketsrc4 = ENC_MacAddr(5)
	banksel	SYSENC_MACADDR_5
	movf	SYSENC_MACADDR_5,W
	banksel	SYSETHERBUFFER_11
	movwf	SYSETHERBUFFER_11
;T_enetpacketsrc5 = ENC_MacAddr(6)
	banksel	SYSENC_MACADDR_6
	movf	SYSENC_MACADDR_6,W
	banksel	SYSETHERBUFFER_12
	movwf	SYSETHERBUFFER_12
	banksel	STATUS
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
	goto	ENDIF6
;ENC28j60_packetreceive( etherBufferSize )
	movlw	232
	banksel	MAXLEN
	movwf	MAXLEN
	movlw	3
	movwf	MAXLEN_H
	banksel	STATUS
	pagesel	ENC28J60_PACKETRECEIVE
	call	ENC28J60_PACKETRECEIVE
	pagesel	$

;end if
ENDIF6
;if ENC28j60_ReadReg( EIR ) & EIR_RXERIF = EIR_RXERIF Then
	movlw	28
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	btfss	SysTemp1,0
	goto	ENDIF7
;ENC28j60_bitClear( EIR, EIR_RXERIF )
	movlw	28
	banksel	ADDR
	movwf	ADDR
	movlw	1
	movwf	ENC_OUTBYTE
	call	ENC28J60_BITCLEAR

;end if
ENDIF7
	banksel	STATUS
	return

;********************************************************************************

ENC28J60_SELECTBANK
;ENC28j60_Select
	bcf	LATA,5
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
	bsf	LATA,5
;ENC28j60_Select
	bcf	LATA,5
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
	bsf	LATA,5
;lastselectedBank = banktobeselected
	movf	BANKTOBESELECTED,W
	movwf	LASTSELECTEDBANK
	return

;********************************************************************************

ENC28J60_SETFREQUENCY
;IF ENC_Outbyte > 5 THEN
	movf	ENC_OUTBYTE,W
	sublw	5
	btfsc	STATUS, C
	goto	ENDIF10
;ENC_Outbyte =  5
	movlw	5
	movwf	ENC_OUTBYTE
;END IF
ENDIF10
;ENC28j60_WriteReg( ECOCON, ENC_Outbyte )
	movlw	117
	movwf	ADDR
	call	ENC28J60_WRITEREG

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
;T_ip_srcaddr0 = ENC_IpAddr(1)
	banksel	SYSENC_IPADDR_1
	movf	SYSENC_IPADDR_1,W
	banksel	SYSETHERBUFFER_27
	movwf	SYSETHERBUFFER_27
;T_ip_srcaddr1 = ENC_IpAddr(2)
	banksel	SYSENC_IPADDR_2
	movf	SYSENC_IPADDR_2,W
	banksel	SYSETHERBUFFER_28
	movwf	SYSETHERBUFFER_28
;T_ip_srcaddr2 = ENC_IpAddr(3)
	banksel	SYSENC_IPADDR_3
	movf	SYSENC_IPADDR_3,W
	banksel	SYSETHERBUFFER_29
	movwf	SYSETHERBUFFER_29
;T_ip_srcaddr3 = ENC_IpAddr(4)
	banksel	SYSENC_IPADDR_4
	movf	SYSENC_IPADDR_4,W
	banksel	SYSETHERBUFFER_30
	movwf	SYSETHERBUFFER_30
;ENC28j60_set_response_macaddress
	banksel	STATUS
	call	ENC28J60_SET_RESPONSE_MACADDRESS

;ENC28j60_Ip_header_checksum
	call	ENC28J60_IP_HEADER_CHECKSUM

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
;T_ip_srcaddr0 = ENC_IpAddr(1)
	banksel	SYSENC_IPADDR_1
	movf	SYSENC_IPADDR_1,W
	banksel	SYSETHERBUFFER_27
	movwf	SYSETHERBUFFER_27
;T_ip_srcaddr1 = ENC_IpAddr(2)
	banksel	SYSENC_IPADDR_2
	movf	SYSENC_IPADDR_2,W
	banksel	SYSETHERBUFFER_28
	movwf	SYSETHERBUFFER_28
;T_ip_srcaddr2 = ENC_IpAddr(3)
	banksel	SYSENC_IPADDR_3
	movf	SYSENC_IPADDR_3,W
	banksel	SYSETHERBUFFER_29
	movwf	SYSETHERBUFFER_29
;T_ip_srcaddr3 = ENC_IpAddr(4)
	banksel	SYSENC_IPADDR_4
	movf	SYSENC_IPADDR_4,W
	banksel	SYSETHERBUFFER_30
	movwf	SYSETHERBUFFER_30
;ENC28j60_set_response_macaddress
	banksel	STATUS
	call	ENC28J60_SET_RESPONSE_MACADDRESS

;ENC28j60_Ip_header_checksum
	call	ENC28J60_IP_HEADER_CHECKSUM

	return

;********************************************************************************

ENC28J60_SET_RESPONSE_MACADDRESS
;For II = 1 To 6
	clrf	II
SysForLoop6
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
	banksel	SYSARRAYTEMP2
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
	banksel	SYSARRAYTEMP1
	movf	SysArrayTemp1,W
	movwf	INDF0
;Next
	movlw	6
	banksel	II
	subwf	II,W
	btfss	STATUS, C
	goto	SysForLoop6
SysForLoopEnd6
;etherBuffer(7) = ENC_MacAddr(1)
	banksel	SYSENC_MACADDR_1
	movf	SYSENC_MACADDR_1,W
	banksel	SYSETHERBUFFER_7
	movwf	SYSETHERBUFFER_7
;etherBuffer(8) = ENC_MacAddr(2)
	banksel	SYSENC_MACADDR_2
	movf	SYSENC_MACADDR_2,W
	banksel	SYSETHERBUFFER_8
	movwf	SYSETHERBUFFER_8
;etherBuffer(9) = ENC_MacAddr(3)
	banksel	SYSENC_MACADDR_3
	movf	SYSENC_MACADDR_3,W
	banksel	SYSETHERBUFFER_9
	movwf	SYSETHERBUFFER_9
;etherBuffer(10) = ENC_MacAddr(4)
	banksel	SYSENC_MACADDR_4
	movf	SYSENC_MACADDR_4,W
	banksel	SYSETHERBUFFER_10
	movwf	SYSETHERBUFFER_10
;etherBuffer(11) = ENC_MacAddr(5)
	banksel	SYSENC_MACADDR_5
	movf	SYSENC_MACADDR_5,W
	banksel	SYSETHERBUFFER_11
	movwf	SYSETHERBUFFER_11
;etherBuffer(12) = ENC_MacAddr(6)
	banksel	SYSENC_MACADDR_6
	movf	SYSENC_MACADDR_6,W
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

ENC28J60_UDP_HANDLER
;Uncomment to show UDP packet data
;select case T_udp_destport
;case 6000
SysSelect5Case1
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
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	SysSelect5Case2
;if T_udp_data = "R" then
	movlw	82
	banksel	SYSETHERBUFFER_43
	subwf	SYSETHERBUFFER_43,W
	btfss	STATUS, Z
	goto	ENDIF64
;ENC28j60_Initialise
	banksel	STATUS
	pagesel	ENC28J60_INITIALISE
	call	ENC28J60_INITIALISE
	pagesel	$

;goto Reset_ENC26j60
	goto	RESET_ENC26J60
;end if
ENDIF64
;if T_udp_data = "D" then
	movlw	68
	subwf	SYSETHERBUFFER_43,W
	btfss	STATUS, Z
	goto	ENDIF65
;ENC28j60_regdump
	banksel	STATUS
	pagesel	ENC28J60_REGDUMP
	call	ENC28J60_REGDUMP
	pagesel	$

;end if
ENDIF65
;case 5000
	goto	SysSelectEnd5
SysSelect5Case2
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
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	SysSelect5Case3
;Select Case T_udp_data
;Case "A" : HSerPrint "Action A"
;Case "B" : HSerPrint "Action B"
;Case "C" : HSerPrint "Action C"
;Case "D" : HSerPrint "Action D"
;Case "E" : HSerPrint "Action E"
;Case "T" : HserPrint "Time..."
;CASE "T"
SysSelect6Case1
	movlw	84
	banksel	SYSETHERBUFFER_43
	subwf	SYSETHERBUFFER_43,W
	btfss	STATUS, Z
	goto	SysSelect6Case2
;ENC28j60_sntp_get
	banksel	STATUS
	pagesel	ENC28J60_SNTP_GET
	call	ENC28J60_SNTP_GET
	pagesel	$

;Case "a" : HSerPrint "Action a"
;Case "b" : HSerPrint "Action b"
;Case "c" : HSerPrint "Action c"
;Case "d" : HSerPrint "Action d"
;Case "e" : HSerPrint "Action e"
;
;Case Else : HSerPrint "Action F"
;End Select
SysSelect6Case2
SysSelectEnd6
;'         HSerPrintCRLF
;end select
SysSelect5Case3
SysSelectEnd5
	banksel	STATUS
	return

;********************************************************************************

ENC28J60_WRITEPHYREG
;while ((ENC28j60_ReadReg(MISTAT) & MISTAT_BUSY ) = MISTAT_BUSY )
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
SysWaitLoop9
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
	pagesel	SysCompEqual
	call	SysCompEqual
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysWaitLoop9
	return

;********************************************************************************

ENC28J60_WRITEREG
;banktobeselected = ( addr & BANK_MASK) / 32
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
;end Repeat
	banksel	SYSREPEATTEMP4
	decfsz	SysRepeatTemp4,F
	goto	SysRepeatLoop4
SysRepeatLoopEnd4
;if lastselectedBank <> banktobeselected then
	banksel	BANKTOBESELECTED
	movf	BANKTOBESELECTED,W
	subwf	LASTSELECTEDBANK,W
	btfsc	STATUS, Z
	goto	ELSE14_1
;if ( ( addr & ADDR_MASK )  <= EIE  ) then
	movlw	31
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
	goto	ENDIF15
;ENC28j60_selectBank ( banktobeselected, addr )
	call	ENC28J60_SELECTBANK

;end if
ENDIF15
;Else
	goto	ENDIF14
ELSE14_1
;lastselectedBank = banktobeselected
	movf	BANKTOBESELECTED,W
	movwf	LASTSELECTEDBANK
;end if
ENDIF14
;ENC28j60_Select
	bcf	LATA,5
;FastHWSPITransfer( ENC28j60_WRITE_CTRL_REG | (addr AND ADDR_MASK ), temp )
	movlw	31
	andwf	ADDR,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	64
	iorwf	SysTemp1,W
	banksel	SPITXDATA
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
	bsf	LATA,5
	return

;********************************************************************************

FASTHWSPITRANSFER
;Set SSPCON1.WCOL Off
	banksel	SSP1CON1
	bcf	SSP1CON1,WCOL
;SSPBUF = SPITxData
	banksel	SPITXDATA
	movf	SPITXDATA,W
	banksel	SSP1BUF
	movwf	SSP1BUF
;Wait While SSPSTAT.BF = Off
SysWaitLoop10
	btfss	SSP1STAT,BF
	goto	SysWaitLoop10
;Set SSPSTAT.BF Off
	bcf	SSP1STAT,BF
;SPIRxData = SSPBUF
	movf	SSP1BUF,W
	banksel	SPIRXDATA
	movwf	SPIRXDATA
	banksel	STATUS
	return

;********************************************************************************

FN_FNLSL
;dim SysLongTempB as long
;SysLongTempB  = BitsIn
;Repeat NumBits
	movf	NUMBITS,W
	banksel	SYSREPEATTEMP10
	movwf	SysRepeatTemp10
	btfsc	STATUS,Z
	goto	SysRepeatLoopEnd10
SysRepeatLoop10
;Set C Off
	bcf	STATUS,C
;Rotate SysLongTempB Left
	rlf	SYSLONGTEMPB,F
	rlf	SYSLONGTEMPB_H,F
	rlf	SYSLONGTEMPB_U,F
	rlf	SYSLONGTEMPB_E,F
;End Repeat
	decfsz	SysRepeatTemp10,F
	goto	SysRepeatLoop10
SysRepeatLoopEnd10
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

FN_FNLSR
;dim SysLongTempB as long
;SysLongTempB  = BitsIn
;Repeat NumBits
	movf	NUMBITS,W
	banksel	SYSREPEATTEMP9
	movwf	SysRepeatTemp9
	btfsc	STATUS,Z
	goto	SysRepeatLoopEnd9
SysRepeatLoop9
;Set C Off
	bcf	STATUS,C
;Rotate SysLongTempB Right
	rrf	SYSLONGTEMPB_E,F
	rrf	SYSLONGTEMPB_U,F
	rrf	SYSLONGTEMPB_H,F
	rrf	SYSLONGTEMPB,F
;End Repeat
	decfsz	SysRepeatTemp9,F
	goto	SysRepeatLoop9
SysRepeatLoopEnd9
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

FN_HEX
;Hex(0) = 2
	movlw	2
	banksel	SYSHEX_0
	movwf	SYSHEX_0
;SysStringTemp = SysValTemp And 0x0F
	movlw	15
	banksel	SYSVALTEMP
	andwf	SYSVALTEMP,W
	banksel	SYSSTRINGTEMP
	movwf	SYSSTRINGTEMP
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	sublw	9
	btfsc	STATUS, C
	goto	ENDIF20
	movlw	7
	addwf	SYSSTRINGTEMP,F
ENDIF20
;Hex(2) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W
	banksel	SYSHEX_2
	movwf	SYSHEX_2
;For SysStringTemp = 1 to 4
	banksel	SYSSTRINGTEMP
	clrf	SYSSTRINGTEMP
SysForLoop2
	incf	SYSSTRINGTEMP,F
;Rotate SysValTemp Right
	banksel	SYSVALTEMP
	rrf	SYSVALTEMP,F
;Next
	movlw	4
	banksel	SYSSTRINGTEMP
	subwf	SYSSTRINGTEMP,W
	btfss	STATUS, C
	goto	SysForLoop2
SysForLoopEnd2
;SysStringTemp = SysValTemp And 0x0F
	movlw	15
	banksel	SYSVALTEMP
	andwf	SYSVALTEMP,W
	banksel	SYSSTRINGTEMP
	movwf	SYSSTRINGTEMP
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	sublw	9
	btfsc	STATUS, C
	goto	ENDIF22
	movlw	7
	addwf	SYSSTRINGTEMP,F
ENDIF22
;Hex(1) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W
	banksel	SYSHEX_1
	movwf	SYSHEX_1
	banksel	STATUS
	return

;********************************************************************************

;Overloaded signature: STRING:byte:
HSERPRINT263
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
	goto	ENDIF24
;for SysPrintTemp = 1 to PrintLen
	clrf	SYSPRINTTEMP
	movlw	1
	subwf	PRINTLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd3
SysForLoop3
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
	goto	SysForLoop3
SysForLoopEnd3
;End If
ENDIF24
	banksel	STATUS
	return

;********************************************************************************

HSERPRINTCRLF
;repeat HSerPrintCRLFCount
	movf	HSERPRINTCRLFCOUNT,W
	banksel	SYSREPEATTEMP5
	movwf	SysRepeatTemp5
	btfsc	STATUS,Z
	goto	SysRepeatLoopEnd5
SysRepeatLoop5
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
	banksel	SYSREPEATTEMP5
	decfsz	SysRepeatTemp5,F
	goto	SysRepeatLoop5
SysRepeatLoopEnd5
	banksel	STATUS
	return

;********************************************************************************

HSERSEND
;if comport = 1 Then
	decf	COMPORT,W
	btfss	STATUS, Z
	goto	ENDIF23
;Wait While TXIF = Off
SysWaitLoop11
	banksel	PIR3
	btfss	PIR3,TXIF
	goto	SysWaitLoop11
;Wait While TXIF = Off
SysWaitLoop12
	btfss	PIR3,TXIF
	goto	SysWaitLoop12
;TXREG1 = SerData
	banksel	SERDATA
	movf	SERDATA,W
	banksel	TXREG1
	movwf	TXREG1
;end if
ENDIF23
	banksel	STATUS
	return

;********************************************************************************

HTTPPART3
;If Tcp_ack = 1 Then
	banksel	SYSBITVAR0
	btfss	SYSBITVAR0,5
	goto	ENDIF95
;If etherBuffer(17) = 0 Then
	banksel	SYSETHERBUFFER_17
	movf	SYSETHERBUFFER_17,F
	btfss	STATUS, Z
	goto	ENDIF96
;If etherBuffer(18) = 40 Then
	movlw	40
	subwf	SYSETHERBUFFER_18,W
	btfss	STATUS, Z
	goto	ENDIF97
;If Ackpsh = 1 Then
	banksel	ACKPSH
	decf	ACKPSH,W
	btfss	STATUS, Z
	goto	ENDIF98
;HSerPrint "ack&ackpush=1"
	movlw	low StringTable98
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable98) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	call	HSERPRINT263

;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	call	HSERPRINTCRLF

;arrayloc = 0x0037   'start of HTTP header within the TCP Packet
	movlw	55
	movwf	ARRAYLOC
	clrf	ARRAYLOC_H
;HTTPPrintStandardHeader
	call	HTTPPRINTSTANDARDHEADER

;HTTP_HANDLER
	pagesel	PORTSSTATUS_HTM
	call	PORTSSTATUS_HTM
	pagesel	$

;End If
ENDIF98
;End If
ENDIF97
;End If
ENDIF96
;End If
ENDIF95
	banksel	STATUS
	return

;********************************************************************************

HTTPPRINTSTANDARDHEADER
;HTTPPrint( "HTTP/1.0 200 OK", HTTPPrintCRLF )
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable104
	movwf	SysStringA
	movlw	(high StringTable104) & 127
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
	return

;********************************************************************************

FN_LEFT
;If SysInString(0) = 0 Then
	banksel	SYSSYSINSTRINGHANDLER
	movf	SysSYSINSTRINGHandler,W
	movwf	AFSR0
	movf	SysSYSINSTRINGHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,F
	btfss	STATUS, Z
	goto	ENDIF123
;Left(0) = 0
	banksel	SYSLEFT_0
	clrf	SYSLEFT_0
;Exit Function
	banksel	STATUS
	return
;End If
ENDIF123
;If SysInString(0) < SysCharCount Then
	movf	SysSYSINSTRINGHandler,W
	movwf	AFSR0
	movf	SysSYSINSTRINGHandler_H,W
	movwf	AFSR0_H
	movf	SYSCHARCOUNT,W
	subwf	INDF0,W
	btfsc	STATUS, C
	goto	ENDIF124
;SysCharCount = SysInString(0)
	movf	SysSYSINSTRINGHandler,W
	movwf	AFSR0
	movf	SysSYSINSTRINGHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SYSCHARCOUNT
;End If
ENDIF124
;For SysStringTemp = 1 To SysCharCount
	clrf	SYSSTRINGTEMP
	movlw	1
	subwf	SYSCHARCOUNT,W
	btfss	STATUS, C
	goto	SysForLoopEnd16
SysForLoop16
	incf	SYSSTRINGTEMP,F
;Left(SysStringTemp) = SysInString(SysStringTemp)
	movf	SYSSTRINGTEMP,W
	addwf	SysSYSINSTRINGHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysSYSINSTRINGHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SysArrayTemp2
	movwf	SysArrayTemp1
	movlw	low(LEFT)
	addwf	SYSSTRINGTEMP,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(LEFT)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movf	SysArrayTemp1,W
	movwf	INDF0
;Next
	movf	SYSCHARCOUNT,W
	subwf	SYSSTRINGTEMP,W
	btfss	STATUS, C
	goto	SysForLoop16
SysForLoopEnd16
;Left(0) = SysCharCount
	movf	SYSCHARCOUNT,W
	banksel	SYSLEFT_0
	movwf	SYSLEFT_0
	banksel	STATUS
	return

;********************************************************************************

;Overloaded signature: BYTE:BYTE:
SPIMODE219
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
	goto	ENDIF18
;Set SSPSTAT.CKE On
	banksel	SSP1STAT
	bsf	SSP1STAT,CKE
;End If
ENDIF18
;Set SSPCON1.CKP Off
	banksel	SSP1CON1
	bcf	SSP1CON1,CKP
;If SPIClockMode.1 = On Then
	banksel	SPICLOCKMODE
	btfss	SPICLOCKMODE,1
	goto	ENDIF19
;Set SSPCON1.CKP On
	banksel	SSP1CON1
	bsf	SSP1CON1,CKP
;End If
ENDIF19
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
	banksel	SSP1CON1
	bsf	SSP1CON1,SSPM0
;Case MasterSlow
	goto	SysSelectEnd2
SysSelect2Case3
	movlw	11
	subwf	SPICURRENTMODE,W
	btfss	STATUS, Z
	goto	SysSelect2Case4
;Set SSPCON1.SSPM1 On
	banksel	SSP1CON1
	bsf	SSP1CON1,SSPM1
;Case Slave
	goto	SysSelectEnd2
SysSelect2Case4
	movf	SPICURRENTMODE,F
	btfss	STATUS, Z
	goto	SysSelect2Case5
;Set SSPCON1.SSPM2 On
	banksel	SSP1CON1
	bsf	SSP1CON1,SSPM2
;Set SSPCON1.SSPM0 On
	bsf	SSP1CON1,SSPM0
;Case SlaveSS
	goto	SysSelectEnd2
SysSelect2Case5
	decf	SPICURRENTMODE,W
	btfss	STATUS, Z
	goto	SysSelect2Case6
;Set SSPCON1.SSPM2 On
	banksel	SSP1CON1
	bsf	SSP1CON1,SSPM2
;End Select
SysSelect2Case6
SysSelectEnd2
;Set SSPCON1.SSPEN On
	banksel	SSP1CON1
	bsf	SSP1CON1,SSPEN
	banksel	STATUS
	return

;********************************************************************************

;Overloaded signature: BYTE:BYTE:
SWAP103
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

SYSCOMPEQUAL32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;movf SysLongTempA, W
	movf	SYSLONGTEMPA, W
;subwf SysLongTempB, W
	subwf	SYSLONGTEMPB, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;movf SysLongTempA_H, W
	movf	SYSLONGTEMPA_H, W
;subwf SysLongTempB_H, W
	subwf	SYSLONGTEMPB_H, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;movf SysLongTempA_U, W
	movf	SYSLONGTEMPA_U, W
;subwf SysLongTempB_U, W
	subwf	SYSLONGTEMPB_U, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;movf SysLongTempA_E, W
	movf	SYSLONGTEMPA_E, W
;subwf SysLongTempB_E, W
	subwf	SYSLONGTEMPB_E, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

SYSCOMPEQUALSTRING
;Dim SysByteTempA As Byte
;Dim SysByteTempX As Byte
;SysByteTempX = 0
	clrf	SYSBYTETEMPX
;movf INDF0, W
	movf	INDF0, W
;movwf SysByteTempA
	movwf	SYSBYTETEMPA
;subwf INDF1, W
	subwf	INDF1, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;movf SysByteTempA, F
	movf	SYSBYTETEMPA, F
;btfsc STATUS, Z
	btfsc	STATUS, Z
;goto SCEStrTrue
	goto	SCESTRTRUE
SYSSTRINGCOMP
;addfsr 0, 1
	addfsr	0, 1
;addfsr 1, 1
	addfsr	1, 1
;movf INDF0, W
	movf	INDF0, W
;subwf INDF1, W
	subwf	INDF1, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;decfsz SysByteTempA, F
	decfsz	SYSBYTETEMPA, F
;goto SysStringComp
	goto	SYSSTRINGCOMP
SCESTRTRUE
;comf SysByteTempX, F
	comf	SYSBYTETEMPX, F
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

SYSCOMPLESSTHAN32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;movf SysLongTempA_E,W
	movf	SYSLONGTEMPA_E,W
;subwf SysLongTempB_E,W
	subwf	SYSLONGTEMPB_E,W
;btfss STATUS,C
	btfss	STATUS,C
;return
	return
;btfss STATUS,Z
	btfss	STATUS,Z
;goto SCLT32True
	goto	SCLT32TRUE
;movf SysLongTempA_U,W
	movf	SYSLONGTEMPA_U,W
;subwf SysLongTempB_U,W
	subwf	SYSLONGTEMPB_U,W
;btfss STATUS,C
	btfss	STATUS,C
;return
	return
;btfss STATUS,Z
	btfss	STATUS,Z
;goto SCLT32True
	goto	SCLT32TRUE
;movf SysLongTempA_H,W
	movf	SYSLONGTEMPA_H,W
;subwf SysLongTempB_H,W
	subwf	SYSLONGTEMPB_H,W
;btfss STATUS,C
	btfss	STATUS,C
;return
	return
;btfss STATUS,Z
	btfss	STATUS,Z
;goto SCLT32True
	goto	SCLT32TRUE
;movf SysLongTempB,W
	movf	SYSLONGTEMPB,W
;subwf SysLongTempA,W
	subwf	SYSLONGTEMPA,W
;btfsc STATUS,C
	btfsc	STATUS,C
;return
	return
SCLT32TRUE
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

SYSCOPYSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;movf INDF0, W
	movf	INDF0, W
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA
;movwf INDF1
	movwf	INDF1
;goto SysCopyStringCheck
	goto	SYSCOPYSTRINGCHECK
SYSCOPYSTRINGPART
;movf INDF0, W
	movf	INDF0, W
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA
;addwf SysStringLength, F
	addwf	SYSSTRINGLENGTH, F
SYSCOPYSTRINGCHECK
;movf SysCalcTempA,F
	movf	SYSCALCTEMPA,F
;btfsc STATUS,Z
	btfsc	STATUS,Z
;return
	return
SYSSTRINGCOPY
;addfsr 0, 1
	addfsr	0, 1
;addfsr 1, 1
	addfsr	1, 1
;movf INDF0, W
	movf	INDF0, W
;movwf INDF1
	movwf	INDF1
;decfsz SysCalcTempA, F
	decfsz	SYSCALCTEMPA, F
;goto SysStringCopy
	goto	SYSSTRINGCOPY
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
	goto	ENDIF113
;SysWordTempA = 0
	clrf	SYSWORDTEMPA
	clrf	SYSWORDTEMPA_H
;exit sub
	return
;end if
ENDIF113
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
	goto	ENDIF114
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	addwfc	SYSDIVMULTX_H,F
;End If
ENDIF114
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
	goto	ENDIF16
	movf	SYSDIVMULTA,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTA_H,W
	addwfc	SYSDIVMULTX_H,F
ENDIF16
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
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
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
