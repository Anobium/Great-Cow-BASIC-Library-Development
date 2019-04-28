;Program compiled by Great Cow BASIC (0.95 2016-04-17)
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
DELAYTEMP	EQU	112
DELAYTEMP2	EQU	113
SYSCALCTEMPB	EQU	121
SYSCALCTEMPX	EQU	112
SYSCALCTEMPX_H	EQU	113
SYSDIVMULTA	EQU	119
SYSDIVMULTA_H	EQU	120
SYSDIVMULTB	EQU	123
SYSDIVMULTB_H	EQU	124
SYSDIVMULTX	EQU	114
SYSDIVMULTX_H	EQU	115
SYSLONGTEMPB	EQU	121
SYSLONGTEMPB_H	EQU	122
SYSLONGTEMPB_U	EQU	123
SYSLONGTEMPB_E	EQU	124
SysBYTETempA	EQU	117
SysBYTETempB	EQU	121
SysBYTETempX	EQU	112
SysCalcTempA	EQU	117
SysCalcTempA_H	EQU	118
SysCalcTempA_U	EQU	119
SysCalcTempA_E	EQU	120
SysDivLoop	EQU	116
SysLONGTempA	EQU	117
SysLONGTempA_H	EQU	118
SysLONGTempA_U	EQU	119
SysLONGTempA_E	EQU	120
SysLONGTempX	EQU	112
SysLONGTempX_H	EQU	113
SysLONGTempX_U	EQU	114
SysLONGTempX_E	EQU	115
SysStringA	EQU	119
SysStringA_H	EQU	120
SysStringLength	EQU	118
SysWORDTempA	EQU	117
SysWORDTempA_H	EQU	118
SysWORDTempB	EQU	121
SysWORDTempB_H	EQU	122
SysWORDTempX	EQU	112
SysWORDTempX_H	EQU	113
SysWaitTempMS	EQU	114
SysWaitTempMS_H	EQU	115
ETHERBUFFER	EQU	9069
SYSSTRINGPARAM1	EQU	9028
SYSPRINTBUFFER	EQU	9017
MACADDR	EQU	9010
STR	EQU	9004
IPADDR	EQU	8999
IPROUTER	EQU	8994
IPSERVER	EQU	8989
HEX	EQU	8985
ADDR	EQU	32
BANKTOBESELECTED	EQU	33
BITIN	EQU	34
BUTTONSTATE	EQU	35
CNT	EQU	36
COMPORT	EQU	37
CRASH	EQU	38
ENC28J60_DATA	EQU	39
ENC28J60_READREG	EQU	40
ENC28J60_TEMP	EQU	41
ENC_LAST_TXBUF	EQU	42
ENC_LAST_TXBUF_H	EQU	43
ENC_OUTBYTE	EQU	44
ENC_OUTBYTE1	EQU	45
ENC_OUTBYTE2	EQU	46
ENDPTR	EQU	47
ENDPTR_H	EQU	48
ETHERGETLENGTH	EQU	49
ETHERGETLENGTH_H	EQU	50
ETH_COUNTER	EQU	51
ETH_COUNTER_H	EQU	52
ETH_FRAMELENGTH	EQU	54
ETH_FRAMELENGTH_H	EQU	55
FNLSL	EQU	57
FNLSL_H	EQU	58
FNLSL_U	EQU	59
FNLSL_E	EQU	60
FNLSR	EQU	61
FNLSR_H	EQU	62
FNLSR_U	EQU	63
FNLSR_E	EQU	64
FNNOTBIT	EQU	65
HSERPRINTCRLFCOUNT	EQU	66
HULP1	EQU	67
HULP2	EQU	68
HULP2_H	EQU	69
HULP3	EQU	70
II	EQU	71
II_H	EQU	72
IPPORT	EQU	73
IP_CHECKSUM16	EQU	74
IP_CHECKSUM16_H	EQU	75
IP_CHKSUM32	EQU	76
IP_CHKSUM32_H	EQU	77
IP_CHKSUM32_U	EQU	78
IP_CHKSUM32_E	EQU	79
IP_HEADER_LENGTH	EQU	80
IP_HULP1	EQU	81
IP_ID	EQU	82
IP_ID_H	EQU	83
IP_TEMP16	EQU	85
IP_TEMP16_H	EQU	86
IP_X	EQU	87
I_CHECKSUM16	EQU	88
I_CHECKSUM16_H	EQU	89
I_CHKSUM32	EQU	91
I_CHKSUM32_H	EQU	92
I_CHKSUM32_U	EQU	93
I_CHKSUM32_E	EQU	94
I_ODD	EQU	95
I_VALUE16	EQU	96
I_VALUE16_H	EQU	97
I_X	EQU	98
I_X_H	EQU	99
LASTSELECTEDBANK	EQU	100
LOCALTMP	EQU	101
LOCALTMP_H	EQU	102
MACON2	EQU	104
MAPHSUP	EQU	105
MAXLEN	EQU	106
MAXLEN_H	EQU	107
MYDEBUGCOUNT	EQU	108
MYDEBUGCOUNT_H	EQU	109
MYDEBUGCOUNT_U	EQU	110
MYDEBUGCOUNT_E	EQU	111
NEXTPACKETPTR	EQU	125
NEXTPACKETPTR_H	EQU	126
NUMBITS	EQU	127
OLDPACKETCOUNTERIN	EQU	160
OLDPACKETCOUNTERIN_H	EQU	161
OLDPACKETCOUNTERIN_U	EQU	162
OLDPACKETCOUNTERIN_E	EQU	163
OLDPACKETCOUNTEROUT	EQU	164
OLDPACKETCOUNTEROUT_H	EQU	165
OLDPACKETCOUNTEROUT_U	EQU	166
OLDPACKETCOUNTEROUT_E	EQU	167
OUTVALUETEMP	EQU	168
PACKETCOUNTERIN	EQU	169
PACKETCOUNTERIN_H	EQU	170
PACKETCOUNTERIN_U	EQU	171
PACKETCOUNTERIN_E	EQU	172
PACKETCOUNTEROUT	EQU	173
PACKETCOUNTEROUT_H	EQU	174
PACKETCOUNTEROUT_U	EQU	175
PACKETCOUNTEROUT_E	EQU	176
PACKETLENGTH	EQU	177
PACKETLENGTH_H	EQU	178
PCKTLEN	EQU	179
PCKTLEN_H	EQU	180
PHYREGADDR	EQU	182
PREVIOUS_NEXTPACKETPTR	EQU	183
PREVIOUS_NEXTPACKETPTR_H	EQU	184
PRINTLEN	EQU	185
RESULT	EQU	186
RESULT_H	EQU	187
RESULT16	EQU	188
RESULT16_H	EQU	189
RXSTAT	EQU	190
RXSTAT_H	EQU	191
SERDATA	EQU	192
SERPRINTVAL	EQU	193
SERPRINTVAL_H	EQU	194
SERPRINTVAL_U	EQU	195
SERPRINTVAL_E	EQU	196
SPICLOCKMODE	EQU	197
SPICURRENTMODE	EQU	198
SPIRXDATA	EQU	199
SPITXDATA	EQU	200
STARTPTR	EQU	201
STARTPTR_H	EQU	202
SUM	EQU	203
SUM_H	EQU	204
SUM_U	EQU	205
SUM_E	EQU	206
SYSBITVAR0	EQU	207
SYSCHARCOUNT	EQU	208
SYSLONGDIVMULTA	EQU	209
SYSLONGDIVMULTA_H	EQU	210
SYSLONGDIVMULTA_U	EQU	211
SYSLONGDIVMULTA_E	EQU	212
SYSLONGDIVMULTB	EQU	213
SYSLONGDIVMULTB_H	EQU	214
SYSLONGDIVMULTB_U	EQU	215
SYSLONGDIVMULTB_E	EQU	216
SYSLONGDIVMULTX	EQU	217
SYSLONGDIVMULTX_H	EQU	218
SYSLONGDIVMULTX_U	EQU	219
SYSLONGDIVMULTX_E	EQU	220
SYSPRINTBUFFLEN	EQU	221
SYSPRINTTEMP	EQU	222
SYSSTRDATA	EQU	223
SYSSTRINGTEMP	EQU	224
SYSVALTEMP	EQU	225
SYSVALTEMP_H	EQU	226
StringPointer	EQU	227
SysArrayTemp1	EQU	228
SysArrayTemp2	EQU	229
SysFnBYTE1	EQU	230
SysMACADDRHandler	EQU	231
SysMACADDRHandler_H	EQU	232
SysPRINTDATAHandler	EQU	233
SysPRINTDATAHandler_H	EQU	234
SysRepeatTemp1	EQU	235
SysRepeatTemp2	EQU	236
SysRepeatTemp3	EQU	237
SysRepeatTemp4	EQU	238
SysRepeatTemp5	EQU	239
SysTemp1	EQU	288
SysTemp1_H	EQU	289
SysTemp1_U	EQU	290
SysTemp1_E	EQU	291
SysTemp2	EQU	292
SysTemp3	EQU	293
TEMP	EQU	294
T_IP_HDR_CKSUM	EQU	295
T_UDP_DESTPORT	EQU	296
T_UDP_DESTPORT_H	EQU	297
VAL1	EQU	298
VAL2	EQU	299
VAL2_H	EQU	300
VAL3	EQU	301
VAL4	EQU	302

;********************************************************************************

;Alias variables
AFSR0	EQU	4
AFSR0_H	EQU	5
SSPBUF	EQU	396
SSPCON1	EQU	400
SSPSTAT	EQU	399
SYSETHERBUFFER_1	EQU	1390
SYSETHERBUFFER_10	EQU	1447
SYSETHERBUFFER_11	EQU	1448
SYSETHERBUFFER_12	EQU	1449
SYSETHERBUFFER_13	EQU	1450
SYSETHERBUFFER_14	EQU	1451
SYSETHERBUFFER_15	EQU	1452
SYSETHERBUFFER_16	EQU	1453
SYSETHERBUFFER_17	EQU	1454
SYSETHERBUFFER_18	EQU	1455
SYSETHERBUFFER_19	EQU	1456
SYSETHERBUFFER_2	EQU	1391
SYSETHERBUFFER_20	EQU	1457
SYSETHERBUFFER_21	EQU	1458
SYSETHERBUFFER_22	EQU	1459
SYSETHERBUFFER_23	EQU	1460
SYSETHERBUFFER_24	EQU	1461
SYSETHERBUFFER_25	EQU	1462
SYSETHERBUFFER_26	EQU	1463
SYSETHERBUFFER_27	EQU	1464
SYSETHERBUFFER_28	EQU	1465
SYSETHERBUFFER_29	EQU	1466
SYSETHERBUFFER_3	EQU	1440
SYSETHERBUFFER_30	EQU	1467
SYSETHERBUFFER_31	EQU	1468
SYSETHERBUFFER_32	EQU	1469
SYSETHERBUFFER_33	EQU	1470
SYSETHERBUFFER_34	EQU	1471
SYSETHERBUFFER_35	EQU	1472
SYSETHERBUFFER_36	EQU	1473
SYSETHERBUFFER_37	EQU	1474
SYSETHERBUFFER_38	EQU	1475
SYSETHERBUFFER_39	EQU	1476
SYSETHERBUFFER_4	EQU	1441
SYSETHERBUFFER_40	EQU	1477
SYSETHERBUFFER_41	EQU	1478
SYSETHERBUFFER_42	EQU	1479
SYSETHERBUFFER_43	EQU	1480
SYSETHERBUFFER_5	EQU	1442
SYSETHERBUFFER_6	EQU	1443
SYSETHERBUFFER_7	EQU	1444
SYSETHERBUFFER_8	EQU	1445
SYSETHERBUFFER_9	EQU	1446
SYSHEX_0	EQU	1257
SYSHEX_1	EQU	1258
SYSHEX_2	EQU	1259
SYSIPADDR_1	EQU	1320
SYSIPADDR_2	EQU	1321
SYSIPADDR_3	EQU	1322
SYSIPADDR_4	EQU	1323
SYSIPROUTER_1	EQU	1315
SYSIPROUTER_2	EQU	1316
SYSIPROUTER_3	EQU	1317
SYSIPROUTER_4	EQU	1318
SYSMACADDR_1	EQU	1331
SYSMACADDR_2	EQU	1332
SYSMACADDR_3	EQU	1333
SYSMACADDR_4	EQU	1334
SYSMACADDR_5	EQU	1335
SYSMACADDR_6	EQU	1336
SYSSTR_0	EQU	1324

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
;''A program  for GCGB and GCB.
;''A program  for GCGB and GCB.
;''--------------------------------------------------------------------------------------------------------------------------------
;'' Description  :  Setup ENC28J60, then reads data from the Ethernet stream to a PC terminal.
;''
;''	You NEED a PC terminal connected to the serial out on the microprocessor.
;''
;''@author 		[todo]
;''@licence		GPL
;''@version		[todo]
;''@date   		[todo]
;''********************************************************************************
;#define debug
;UNLOCKPPS
;dim IntState as bit
;IntState = GIE
	banksel	SYSBITVAR0
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
	bcf	INTCON,GIE
	banksel	SYSBITVAR0
	btfsc	SYSBITVAR0,0
	bsf	INTCON,GIE
;#define USART_BAUD_RATE 9600
;#define USART_BLOCKING
;#define USART_TX_BLOCKING
;----- Define Hardware settings
;#define ENC28J60_DI			portb.4						'Connected to Device SO
;#define ENC28J60_DO			portb.5							'Connected to Device SI
;#define ENC28J60_SCK		portb.3							'Connected to Clock
;#define ENC28J60_CS 		portb.2							'Chip select line
;#define ENC28J60_RESET  PORTb.1							'Reset line
;----- Variables
;----- Quick Command Reference:
;----- Main body of program commences here.
RESTART
;HSerPrintCRLF 2
	movlw	2
	banksel	HSERPRINTCRLFCOUNT
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$
;HserPrint "ENC28J60 Ethernet Driver 017" : HSerPrintCRLF
	movlw	low StringTable3
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable3) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT248
	call	HSERPRINT248
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
;ENC28J60_Init ( macaddr )
	movlw	low MACADDR
	banksel	SYSMACADDRHANDLER
	movwf	SysMACADDRHandler
	movlw	high MACADDR
	movwf	SysMACADDRHandler_H
	banksel	STATUS
	pagesel	ENC28J60_INIT
	call	ENC28J60_INIT
	pagesel	$
;HserPrint "Initialised": HSerPrintCRLF 2
	movlw	low StringTable4
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable4) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
	movlw	2
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$
;dir porta.0 out
	bcf	TRISA,0
;dir porta.5 in
	bsf	TRISA,5
;ENC28J60_bitSet( ECON1 , econ1_txrst )
	movlw	31
	movwf	ADDR
	movlw	128
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_BITSET
	call	ENC28J60_BITSET
	pagesel	$
;ENC28J60_bitClear( ECON1 , econ1_txrst )
	movlw	31
	movwf	ADDR
	movlw	128
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_BITCLEAR
	call	ENC28J60_BITCLEAR
;Ntp_get                       'get the Network Time once
;Enc28j60_data = ENC28J60_ReadReg( erevid)
;HSerPrint "#1"
;HSerPrintCRLF
;HSerPrint "Rx   : ERXST  ERXND  ERXWRPT ERXRDPT ERXFCON EPKTCNT"
;HSerPrintCRLF
;Enc28j60_data = ENC28J60_ReadReg(erxsth)
;HSerPrint "       " + Hex(enc28j60_data);
;Enc28j60_data = ENC28J60_ReadReg(erxstl)
;HSerPrint Hex(enc28j60_data);
;Enc28j60_data = ENC28J60_ReadReg(erxndh)
;HSerPrint "   " + Hex(enc28j60_data);
;Enc28j60_data = ENC28J60_ReadReg(erxndl)
;HSerPrint Hex(enc28j60_data);
;Enc28j60_data = ENC28J60_ReadReg(erxwrpth)
;HSerPrint "   " + Hex(enc28j60_data);
;Enc28j60_data = ENC28J60_ReadReg(erxwrptl)
;HSerPrint Hex(enc28j60_data);
;Enc28j60_data = ENC28J60_ReadReg(erxrdpth)
;HSerPrint "    " + Hex(enc28j60_data);
;Enc28j60_data = ENC28J60_ReadReg(erxrdptl)
;HSerPrint Hex(enc28j60_data);
;Enc28j60_data = ENC28J60_ReadReg(erxfcon)
;HSerPrint "    " + Hex(enc28j60_data);
;Enc28j60_data = ENC28J60_ReadReg(epktcnt)
;HSerPrint "      " + Hex(enc28j60_data);
;HSerPrintCRLF
;HSerPrint "Write ARP"
;HSerPrintCRLF 2
;Enc28j60regdump
	pagesel	ENC28J60REGDUMP
	call	ENC28J60REGDUMP
	pagesel	$
;repeat 5
	movlw	5
	banksel	SYSREPEATTEMP1
	movwf	SysRepeatTemp1
SysRepeatLoop1
;ARP-test. Fill buffer and send it on its way.
;Enc28j60writebufferARP
	banksel	STATUS
	pagesel	ENC28J60WRITEBUFFERARP
	call	ENC28J60WRITEBUFFERARP
	pagesel	$
;end Repeat
	banksel	SYSREPEATTEMP1
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop1
SysRepeatLoopEnd1
;Enc28j60_data = ENC28J60_ReadReg( erevid)
;HSerPrint "#2"
;HSerPrintCRLF
;HSerPrint "Rx   : ERXST  ERXND  ERXWRPT ERXRDPT ERXFCON EPKTCNT"
;HSerPrintCRLF
;Enc28j60_data = ENC28J60_ReadReg(erxsth)
;HSerPrint "       " + Hex(enc28j60_data);
;Enc28j60_data = ENC28J60_ReadReg(erxstl)
;HSerPrint Hex(enc28j60_data);
;Enc28j60_data = ENC28J60_ReadReg(erxndh)
;HSerPrint "   " + Hex(enc28j60_data);
;Enc28j60_data = ENC28J60_ReadReg(erxndl)
;HSerPrint Hex(enc28j60_data);
;Enc28j60_data = ENC28J60_ReadReg(erxwrpth)
;HSerPrint "   " + Hex(enc28j60_data);
;Enc28j60_data = ENC28J60_ReadReg(erxwrptl)
;HSerPrint Hex(enc28j60_data);
;Enc28j60_data = ENC28J60_ReadReg(erxrdpth)
;HSerPrint "    " + Hex(enc28j60_data);
;Enc28j60_data = ENC28J60_ReadReg(erxrdptl)
;HSerPrint Hex(enc28j60_data);
;Enc28j60_data = ENC28J60_ReadReg(erxfcon)
;HSerPrint "    " + Hex(enc28j60_data);
;Enc28j60_data = ENC28J60_ReadReg(epktcnt)
;HSerPrint "      " + Hex(enc28j60_data);
;HSerPrintCRLF 2
;HSerPrintCRLF 2
;dim OldpacketCounterOut, OldpacketCounterIn, mydebugcount as long
;mydebugcount = 0
	banksel	MYDEBUGCOUNT
	clrf	MYDEBUGCOUNT
	clrf	MYDEBUGCOUNT_H
	clrf	MYDEBUGCOUNT_U
	clrf	MYDEBUGCOUNT_E
;ENC28J60_writeReg(ERXFCON, 0x00)
	movlw	56
	movwf	ADDR
	clrf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;#define ButtonDown = 0
;buttonstate = ButtonDown
	clrf	BUTTONSTATE
;Enc28j60regdump
	pagesel	ENC28J60REGDUMP
	call	ENC28J60REGDUMP
	pagesel	$
;Do forever
SysDoLoop_S1
;Setwith ( porta.0, FnNotBit ( porta.0 ))
;if Source then
	clrf	BITIN
	btfsc	PORTA,0
	incf	BITIN,F
	pagesel	FN_FNNOTBIT
	call	FN_FNNOTBIT
	pagesel	$
	btfss	FNNOTBIT
	goto	ELSE1_1
;TargetBit = 1
	bsf	LATA,0
;else
	goto	ENDIF1
ELSE1_1
;TargetBit = 0
	bcf	LATA,0
;end if
ENDIF1
;HSerPrint mydebugcount
;HSerPrintCRLF
;if porta.5 = buttonstate then
	clrf	SysCalcTempA
	btfsc	PORTA,5
	incf	SysCalcTempA,F
	movf	BUTTONSTATE,W
	subwf	SysCalcTempA,W
	btfss	STATUS, Z
	goto	ENDIF3
;if buttonstate  = ButtonDown then
	movf	BUTTONSTATE,F
	btfss	STATUS, Z
	goto	ENDIF4
;HserPrint cnt
	movf	CNT,W
	banksel	SERPRINTVAL
	movwf	SERPRINTVAL
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT249
	call	HSERPRINT249
	pagesel	$
;HserPrint ", "
	movlw	low StringTable5
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable5) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;HserPrint packetCounterOut
	banksel	PACKETCOUNTEROUT
	movf	PACKETCOUNTEROUT,W
	movwf	SERPRINTVAL
	movf	PACKETCOUNTEROUT_H,W
	movwf	SERPRINTVAL_H
	movf	PACKETCOUNTEROUT_U,W
	movwf	SERPRINTVAL_U
	movf	PACKETCOUNTEROUT_E,W
	movwf	SERPRINTVAL_E
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT252
	call	HSERPRINT252
	pagesel	$
;HserPrint ", "
	movlw	low StringTable5
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable5) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;HserPrint packetCounterIn
	banksel	PACKETCOUNTERIN
	movf	PACKETCOUNTERIN,W
	movwf	SERPRINTVAL
	movf	PACKETCOUNTERIN_H,W
	movwf	SERPRINTVAL_H
	movf	PACKETCOUNTERIN_U,W
	movwf	SERPRINTVAL_U
	movf	PACKETCOUNTERIN_E,W
	movwf	SERPRINTVAL_E
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT252
	call	HSERPRINT252
	pagesel	$
;HserPrint ", "
	movlw	low StringTable5
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable5) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;HSerPrint crash
	movf	CRASH,W
	banksel	SERPRINTVAL
	movwf	SERPRINTVAL
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT249
	call	HSERPRINT249
	pagesel	$
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$
;OldpacketCounterIn = packetCounterIn
	banksel	PACKETCOUNTERIN
	movf	PACKETCOUNTERIN,W
	movwf	OLDPACKETCOUNTERIN
	movf	PACKETCOUNTERIN_H,W
	movwf	OLDPACKETCOUNTERIN_H
	movf	PACKETCOUNTERIN_U,W
	movwf	OLDPACKETCOUNTERIN_U
	movf	PACKETCOUNTERIN_E,W
	movwf	OLDPACKETCOUNTERIN_E
;OldpacketCounterOut = packetCounterOut
	movf	PACKETCOUNTEROUT,W
	movwf	OLDPACKETCOUNTEROUT
	movf	PACKETCOUNTEROUT_H,W
	movwf	OLDPACKETCOUNTEROUT_H
	movf	PACKETCOUNTEROUT_U,W
	movwf	OLDPACKETCOUNTEROUT_U
	movf	PACKETCOUNTEROUT_E,W
	movwf	OLDPACKETCOUNTEROUT_E
;Enc28j60regdump
	banksel	STATUS
	pagesel	ENC28J60REGDUMP
	call	ENC28J60REGDUMP
	pagesel	$
;end if
ENDIF4
;SetWith( buttonstate, FnNotBit ( buttonstate ))
;if Source then
	movf	BUTTONSTATE,W
	movwf	BITIN
	pagesel	FN_FNNOTBIT
	call	FN_FNNOTBIT
	pagesel	$
	btfss	FNNOTBIT
	goto	ELSE5_1
;TargetBit = 1
	movlw	1
	movwf	BUTTONSTATE
;else
	goto	ENDIF5
ELSE5_1
;TargetBit = 0
	clrf	BUTTONSTATE
;end if
ENDIF5
;end if
ENDIF3
;Enc28j60poll 'watch the terminal screen.... All traffic visible
	pagesel	ENC28J60POLL
	call	ENC28J60POLL
	pagesel	$
;Loop
	goto	SysDoLoop_S1
SysDoLoop_E1
;end
	goto	BASPROGRAMEND
;----- Support methods.  Subroutines and Functions
;#define ENC28J60_Select         Set ENC28J60_CS off
;#define ENC28J60_Deselect       Set ENC28J60_CS on
;#define ENC28J60_Reset_CMD			Set ENC28J60_RESET on: Wait 10 ms :Set ENC28J60_RESET off: Wait 10 ms :Set ENC28J60_RESET on: Wait 10 ms
CONFIGURATIONDETAILS
MEMORY_LOCATIONS_SCRIPT
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

;********************************************************************************

ENC28J60_INITIALISE
;IF NOT_TO = 0 THEN
;crash++
;ELSE
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
;packetCounterOut = 0
	banksel	PACKETCOUNTEROUT
	clrf	PACKETCOUNTEROUT
	clrf	PACKETCOUNTEROUT_H
	clrf	PACKETCOUNTEROUT_U
	clrf	PACKETCOUNTEROUT_E
;packetCounterIn = 0
	clrf	PACKETCOUNTERIN
	clrf	PACKETCOUNTERIN_H
	clrf	PACKETCOUNTERIN_U
	clrf	PACKETCOUNTERIN_E
;Ip_id = 0
	banksel	IP_ID
	clrf	IP_ID
	clrf	IP_ID_H
;crash = 0
	clrf	CRASH
;END IF
	return

;********************************************************************************

ENC28J60_UDP
;dim T_udp_destport as word
;Dim hulp2 As Word
;T_udp_destport = ( T_udp_destport0 * 256 ) + T_udp_destport1
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
;select case T_udp_destport
;case 6000
SysSelect3Case1
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
	goto	SysSelect3Case2
;if T_udp_data = "R" then
	movlw	82
	banksel	SYSETHERBUFFER_43
	subwf	SYSETHERBUFFER_43,W
	btfss	STATUS, Z
	goto	ENDIF64
;ENC28J60_Initialise
	banksel	STATUS
	call	ENC28J60_INITIALISE
;goto Restart
	goto	RESTART
;end if
ENDIF64
;if T_udp_data = "D" then
	movlw	68
	subwf	SYSETHERBUFFER_43,W
	btfss	STATUS, Z
	goto	ENDIF65
;Enc28j60regdump
	banksel	STATUS
	pagesel	ENC28J60REGDUMP
	call	ENC28J60REGDUMP
	pagesel	$
;end if
ENDIF65
;case 5000
	goto	SysSelectEnd3
SysSelect3Case2
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
	goto	SysSelect3Case3
;Select Case T_udp_data
;Case "A" : HSerPrint "Action A"
SysSelect4Case1
	movlw	65
	banksel	SYSETHERBUFFER_43
	subwf	SYSETHERBUFFER_43,W
	btfss	STATUS, Z
	goto	SysSelect4Case2
	movlw	low StringTable29
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable29) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Case "B" : HSerPrint "Action B"
	goto	SysSelectEnd4
SysSelect4Case2
	movlw	66
	subwf	SYSETHERBUFFER_43,W
	btfss	STATUS, Z
	goto	SysSelect4Case3
	movlw	low StringTable31
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable31) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Case "C" : HSerPrint "Action C"
	goto	SysSelectEnd4
SysSelect4Case3
	movlw	67
	subwf	SYSETHERBUFFER_43,W
	btfss	STATUS, Z
	goto	SysSelect4Case4
	movlw	low StringTable33
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable33) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Case "D" : HSerPrint "Action D"
	goto	SysSelectEnd4
SysSelect4Case4
	movlw	68
	subwf	SYSETHERBUFFER_43,W
	btfss	STATUS, Z
	goto	SysSelect4Case5
	movlw	low StringTable34
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable34) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Case "E" : HSerPrint "Action E"
	goto	SysSelectEnd4
SysSelect4Case5
	movlw	69
	subwf	SYSETHERBUFFER_43,W
	btfss	STATUS, Z
	goto	SysSelect4Case6
	movlw	low StringTable36
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable36) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Case "a" : HSerPrint "Action a"
	goto	SysSelectEnd4
SysSelect4Case6
	movlw	97
	subwf	SYSETHERBUFFER_43,W
	btfss	STATUS, Z
	goto	SysSelect4Case7
	movlw	low StringTable38
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable38) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Case "b" : HSerPrint "Action b"
	goto	SysSelectEnd4
SysSelect4Case7
	movlw	98
	subwf	SYSETHERBUFFER_43,W
	btfss	STATUS, Z
	goto	SysSelect4Case8
	movlw	low StringTable40
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable40) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Case "c" : HSerPrint "Action c"
	goto	SysSelectEnd4
SysSelect4Case8
	movlw	99
	subwf	SYSETHERBUFFER_43,W
	btfss	STATUS, Z
	goto	SysSelect4Case9
	movlw	low StringTable42
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable42) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Case "d" : HSerPrint "Action d"
	goto	SysSelectEnd4
SysSelect4Case9
	movlw	100
	subwf	SYSETHERBUFFER_43,W
	btfss	STATUS, Z
	goto	SysSelect4Case10
	movlw	low StringTable44
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable44) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Case "e" : HSerPrint "Action e"
	goto	SysSelectEnd4
SysSelect4Case10
	movlw	101
	subwf	SYSETHERBUFFER_43,W
	btfss	STATUS, Z
	goto	SysSelect4Case11
	movlw	low StringTable46
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable46) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Case Else : HSerPrint "Action F"
	goto	SysSelectEnd4
SysSelect4Case11
	movlw	low StringTable47
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable47) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;End Select
SysSelect4Case12
SysSelectEnd4
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$
;case 7
	goto	SysSelectEnd3
SysSelect3Case3
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
	goto	SysSelect3Case4
;hserPrint "Echopacket"
	movlw	low StringTable48
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable48) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
;ENC28J60_Setipaddrs
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
	call	SWAP87
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
	call	SWAP87
	movf	SYSCALCTEMPA,W
	banksel	SYSETHERBUFFER_36
	movwf	SYSETHERBUFFER_36
	movf	SYSCALCTEMPB,W
	movwf	SYSETHERBUFFER_38
;ENC28J60_Udp_checksum
	banksel	STATUS
	call	ENC28J60_UDP_CHECKSUM
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
;Enc28j60writebuffer( hulp2 )
	movf	HULP2,W
	banksel	PCKTLEN
	movwf	PCKTLEN
	banksel	HULP2_H
	movf	HULP2_H,W
	banksel	PCKTLEN_H
	movwf	PCKTLEN_H
	banksel	STATUS
	pagesel	ENC28J60WRITEBUFFER
	call	ENC28J60WRITEBUFFER
	pagesel	$
;Enc28j60packetsend( hulp2 )
	movf	HULP2,W
	banksel	PCKTLEN
	movwf	PCKTLEN
	banksel	HULP2_H
	movf	HULP2_H,W
	banksel	PCKTLEN_H
	movwf	PCKTLEN_H
	banksel	STATUS
	pagesel	ENC28J60PACKETSEND
	call	ENC28J60PACKETSEND
	pagesel	$
;case 25
	goto	SysSelectEnd3
SysSelect3Case4
	banksel	T_UDP_DESTPORT
	movf	T_UDP_DESTPORT,W
	movwf	SysWORDTempA
	movf	T_UDP_DESTPORT_H,W
	movwf	SysWORDTempA_H
	movlw	25
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	SysSelect3Case5
;0x0025 NTP protocol
;ENC28J60_NTP
;end select
SysSelect3Case5
SysSelectEnd3
	banksel	STATUS
	return

;********************************************************************************

ENC28J60_UDP_CHECKSUM
;dim I_chksum32 as long
;dim I_value16, Result16, I_checksum16, Hulp2, I_x as word
;T_udp_chksum0 = 0x00
	banksel	SYSETHERBUFFER_41
	clrf	SYSETHERBUFFER_41
;T_udp_chksum1 = 0x00
	clrf	SYSETHERBUFFER_42
;tmp = T_id0
;T_id0 = T_id1
;T_id1 = tmp
;T_flags=0x40
;I_chksum32 = 0
	banksel	I_CHKSUM32
	clrf	I_CHKSUM32
	clrf	I_CHKSUM32_H
	clrf	I_CHKSUM32_U
	clrf	I_CHKSUM32_E
;I_value16 = 0
	clrf	I_VALUE16
	clrf	I_VALUE16_H
;I_chksum32 = I_value16 + I_chksum32
	movf	I_CHKSUM32,W
	addwf	I_VALUE16,W
	movwf	I_CHKSUM32
	movf	I_CHKSUM32_H,W
	addwfc	I_VALUE16_H,W
	movwf	I_CHKSUM32_H
	movlw	0
	banksel	SYSTEMP2
	movwf	SysTemp2
	banksel	I_CHKSUM32_U
	movf	I_CHKSUM32_U,W
	banksel	SYSTEMP2
	addwfc	SysTemp2,W
	banksel	I_CHKSUM32_U
	movwf	I_CHKSUM32_U
	movlw	0
	banksel	SYSTEMP3
	movwf	SysTemp3
	banksel	I_CHKSUM32_E
	movf	I_CHKSUM32_E,W
	banksel	SYSTEMP3
	addwfc	SysTemp3,W
	banksel	I_CHKSUM32_E
	movwf	I_CHKSUM32_E
;I_value16 = FnLsl( T_ip_srcaddr2, 8 ) + T_ip_srcaddr3
	banksel	SYSETHERBUFFER_29
	movf	SYSETHERBUFFER_29,W
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
	banksel	SYSETHERBUFFER_30
	movf	SYSETHERBUFFER_30,W
	banksel	FNLSL
	addwf	FNLSL,W
	movwf	I_VALUE16
	movlw	0
	addwfc	FNLSL_H,W
	movwf	I_VALUE16_H
;I_chksum32 = I_value16 + I_chksum32
	movf	I_CHKSUM32,W
	addwf	I_VALUE16,W
	movwf	I_CHKSUM32
	movf	I_CHKSUM32_H,W
	addwfc	I_VALUE16_H,W
	movwf	I_CHKSUM32_H
	movlw	0
	banksel	SYSTEMP2
	movwf	SysTemp2
	banksel	I_CHKSUM32_U
	movf	I_CHKSUM32_U,W
	banksel	SYSTEMP2
	addwfc	SysTemp2,W
	banksel	I_CHKSUM32_U
	movwf	I_CHKSUM32_U
	movlw	0
	banksel	SYSTEMP3
	movwf	SysTemp3
	banksel	I_CHKSUM32_E
	movf	I_CHKSUM32_E,W
	banksel	SYSTEMP3
	addwfc	SysTemp3,W
	banksel	I_CHKSUM32_E
	movwf	I_CHKSUM32_E
;I_value16 = FnLsl( T_ip_destaddr0, 8 ) + T_ip_destaddr1
	banksel	SYSETHERBUFFER_31
	movf	SYSETHERBUFFER_31,W
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
	banksel	SYSETHERBUFFER_32
	movf	SYSETHERBUFFER_32,W
	banksel	FNLSL
	addwf	FNLSL,W
	movwf	I_VALUE16
	movlw	0
	addwfc	FNLSL_H,W
	movwf	I_VALUE16_H
;I_chksum32 = I_value16 + I_chksum32
	movf	I_CHKSUM32,W
	addwf	I_VALUE16,W
	movwf	I_CHKSUM32
	movf	I_CHKSUM32_H,W
	addwfc	I_VALUE16_H,W
	movwf	I_CHKSUM32_H
	movlw	0
	banksel	SYSTEMP2
	movwf	SysTemp2
	banksel	I_CHKSUM32_U
	movf	I_CHKSUM32_U,W
	banksel	SYSTEMP2
	addwfc	SysTemp2,W
	banksel	I_CHKSUM32_U
	movwf	I_CHKSUM32_U
	movlw	0
	banksel	SYSTEMP3
	movwf	SysTemp3
	banksel	I_CHKSUM32_E
	movf	I_CHKSUM32_E,W
	banksel	SYSTEMP3
	addwfc	SysTemp3,W
	banksel	I_CHKSUM32_E
	movwf	I_CHKSUM32_E
;I_value16 = FnLsl( T_ip_destaddr2, 8 ) + T_ip_destaddr3
	banksel	SYSETHERBUFFER_33
	movf	SYSETHERBUFFER_33,W
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
	banksel	SYSETHERBUFFER_34
	movf	SYSETHERBUFFER_34,W
	banksel	FNLSL
	addwf	FNLSL,W
	movwf	I_VALUE16
	movlw	0
	addwfc	FNLSL_H,W
	movwf	I_VALUE16_H
;I_chksum32 = I_value16 + I_chksum32
	movf	I_CHKSUM32,W
	addwf	I_VALUE16,W
	movwf	I_CHKSUM32
	movf	I_CHKSUM32_H,W
	addwfc	I_VALUE16_H,W
	movwf	I_CHKSUM32_H
	movlw	0
	banksel	SYSTEMP2
	movwf	SysTemp2
	banksel	I_CHKSUM32_U
	movf	I_CHKSUM32_U,W
	banksel	SYSTEMP2
	addwfc	SysTemp2,W
	banksel	I_CHKSUM32_U
	movwf	I_CHKSUM32_U
	movlw	0
	banksel	SYSTEMP3
	movwf	SysTemp3
	banksel	I_CHKSUM32_E
	movf	I_CHKSUM32_E,W
	banksel	SYSTEMP3
	addwfc	SysTemp3,W
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
;I_value16 = FnLsl( T_udp_len0, 8 ) + T_udp_len1
	banksel	SYSETHERBUFFER_39
	movf	SYSETHERBUFFER_39,W
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
	banksel	SYSETHERBUFFER_40
	movf	SYSETHERBUFFER_40,W
	banksel	FNLSL
	addwf	FNLSL,W
	movwf	I_VALUE16
	movlw	0
	addwfc	FNLSL_H,W
	movwf	I_VALUE16_H
;I_chksum32 = I_value16 + I_chksum32
	movf	I_CHKSUM32,W
	addwf	I_VALUE16,W
	movwf	I_CHKSUM32
	movf	I_CHKSUM32_H,W
	addwfc	I_VALUE16_H,W
	movwf	I_CHKSUM32_H
	movlw	0
	banksel	SYSTEMP2
	movwf	SysTemp2
	banksel	I_CHKSUM32_U
	movf	I_CHKSUM32_U,W
	banksel	SYSTEMP2
	addwfc	SysTemp2,W
	banksel	I_CHKSUM32_U
	movwf	I_CHKSUM32_U
	movlw	0
	banksel	SYSTEMP3
	movwf	SysTemp3
	banksel	I_CHKSUM32_E
	movf	I_CHKSUM32_E,W
	banksel	SYSTEMP3
	addwfc	SysTemp3,W
	banksel	I_CHKSUM32_E
	movwf	I_CHKSUM32_E
;I_odd = T_udp_len1 Mod 2
	clrf	I_ODD
	banksel	SYSETHERBUFFER_40
	btfss	SYSETHERBUFFER_40,0
	goto	ENDIF69
	banksel	I_ODD
	incf	I_ODD,F
ENDIF69
;Result16 = FnLsl( T_udp_len0, 8 ) + T_udp_len1
	banksel	SYSETHERBUFFER_39
	movf	SYSETHERBUFFER_39,W
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
	banksel	SYSETHERBUFFER_40
	movf	SYSETHERBUFFER_40,W
	banksel	FNLSL
	addwf	FNLSL,W
	banksel	RESULT16
	movwf	RESULT16
	movlw	0
	banksel	FNLSL_H
	addwfc	FNLSL_H,W
	banksel	RESULT16_H
	movwf	RESULT16_H
;Hulp1 = 0x2B
	movlw	43
	banksel	HULP1
	movwf	HULP1
;Hulp2 = 0x2B + Result16
	movlw	43
	banksel	RESULT16
	addwf	RESULT16,W
	banksel	HULP2
	movwf	HULP2
	movlw	0
	banksel	RESULT16_H
	addwfc	RESULT16_H,W
	banksel	HULP2_H
	movwf	HULP2_H
;Hulp2 = Hulp2 - 12
	movlw	12
	subwf	HULP2,F
	movlw	0
	subwfb	HULP2_H,F
;For I_x = Hulp1 To Hulp2 Step 2
	movlw	2
	subwf	HULP1,W
	movwf	I_X
	clrf	I_X_H
	btfss	STATUS,C
	decf	I_X_H,F
	movf	HULP1,W
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
	goto	SysForLoopEnd8
SysForLoop8
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
;I_value16 = I_value16 + etherbuffer(hulp3)
	movlw	low(ETHERBUFFER)
	addwf	HULP3,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	high(ETHERBUFFER)
	addwfc	SysTemp2,W
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
	movf	HULP2,W
	movwf	SysWORDTempB
	movf	HULP2_H,W
	movwf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop8
SysForLoopEnd8
;If I_odd = 1 Then
	decf	I_ODD,W
	btfss	STATUS, Z
	goto	ENDIF68
;Hulp2 = Hulp2 + 3
	movlw	3
	addwf	HULP2,F
	movlw	0
	addwfc	HULP2_H,F
;I_value16 = 0
;I_value16 = FnLsl( etherbuffer(hulp2), 8 )
	movlw	low(ETHERBUFFER)
	addwf	HULP2,W
	movwf	AFSR0
	movlw	high(ETHERBUFFER)
	addwfc	HULP2_H,W
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
ENDIF68
;I_checksum16 =  FnLsr( i_chksum32, 16 )
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
;I_checksum16 = I_checksum16 + [word]I_chksum32                 ' only 16 lower bits of i_chksum32 is taken...
	movf	I_CHKSUM32,W
	addwf	I_CHECKSUM16,F
	movf	I_CHKSUM32_H,W
	addwfc	I_CHECKSUM16_H,F
;I_checksum16 = Not I_checksum16
	comf	I_CHECKSUM16,F
	comf	I_CHECKSUM16_H,F
;T_udp_chksum0 = i_checksum16_h
	movf	I_CHECKSUM16_H,W
	banksel	SYSETHERBUFFER_41
	movwf	SYSETHERBUFFER_41
;T_udp_chksum1 = i_checksum16
	banksel	I_CHECKSUM16
	movf	I_CHECKSUM16,W
	banksel	SYSETHERBUFFER_42
	movwf	SYSETHERBUFFER_42
;T_udp_chksum0 = 0
	clrf	SYSETHERBUFFER_41
;T_udp_chksum1 = 0
	clrf	SYSETHERBUFFER_42
	banksel	STATUS
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

FN_STR
;SysCharCount = 0
	banksel	SYSCHARCOUNT
	clrf	SYSCHARCOUNT
;Dim SysCalcTempX As Word
;IF SysValTemp >= 10000 then
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
	goto	ENDIF24
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
	movwf	SYSVALTEMP
	movf	SYSCALCTEMPX_H,W
	movwf	SYSVALTEMP_H
;SysCharCount += 1
	incf	SYSCHARCOUNT,F
;Str(SysCharCount) = SysStrData + 48
	movlw	low(STR)
	addwf	SYSCHARCOUNT,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	high(STR)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movlw	48
	banksel	SYSSTRDATA
	addwf	SYSSTRDATA,W
	movwf	INDF0
;Goto SysValThousands
	goto	SYSVALTHOUSANDS
;End If
ENDIF24
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
	goto	ENDIF25
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
	movwf	SYSVALTEMP
	movf	SYSCALCTEMPX_H,W
	movwf	SYSVALTEMP_H
;SysCharCount += 1
	incf	SYSCHARCOUNT,F
;Str(SysCharCount) = SysStrData + 48
	movlw	low(STR)
	addwf	SYSCHARCOUNT,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	high(STR)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movlw	48
	banksel	SYSSTRDATA
	addwf	SYSSTRDATA,W
	movwf	INDF0
;Goto SysValHundreds
	goto	SYSVALHUNDREDS
;End If
ENDIF25
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
	goto	ENDIF26
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
	movwf	SYSVALTEMP
	movf	SYSCALCTEMPX_H,W
	movwf	SYSVALTEMP_H
;SysCharCount += 1
	incf	SYSCHARCOUNT,F
;Str(SysCharCount) = SysStrData + 48
	movlw	low(STR)
	addwf	SYSCHARCOUNT,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	high(STR)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movlw	48
	banksel	SYSSTRDATA
	addwf	SYSSTRDATA,W
	movwf	INDF0
;Goto SysValTens
	goto	SYSVALTENS
;End If
ENDIF26
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
	goto	ENDIF27
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
	movwf	SYSVALTEMP
	movf	SYSCALCTEMPX_H,W
	movwf	SYSVALTEMP_H
;SysCharCount += 1
	incf	SYSCHARCOUNT,F
;Str(SysCharCount) = SysStrData + 48
	movlw	low(STR)
	addwf	SYSCHARCOUNT,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	high(STR)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movlw	48
	banksel	SYSSTRDATA
	addwf	SYSSTRDATA,W
	movwf	INDF0
;End If
ENDIF27
;SysCharCount += 1
	banksel	SYSCHARCOUNT
	incf	SYSCHARCOUNT,F
;Str(SysCharCount) = SysValTemp + 48
	movlw	low(STR)
	addwf	SYSCHARCOUNT,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	high(STR)
	addwfc	SysTemp2,W
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
	movf	SYSCHARCOUNT,W
	banksel	SYSSTR_0
	movwf	SYSSTR_0
	banksel	STATUS
	return

;********************************************************************************

;Overloaded signature: BYTE:BYTE:
SWAP87
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
	goto	ENDIF80
;SysLongTempA = 0
	clrf	SYSLONGTEMPA
	clrf	SYSLONGTEMPA_H
	clrf	SYSLONGTEMPA_U
	clrf	SYSLONGTEMPA_E
;exit sub
	return
;end if
ENDIF80
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
	goto	ENDIF81
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
ENDIF81
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

SysStringTables
	movf	SysStringA_H,W
	movwf	PCLATH
	movf	SysStringA,W
	incf	SysStringA,F
	btfsc	STATUS,Z
	incf	SysStringA_H,F
	movwf	PCL

StringTable3
	retlw	28
	retlw	69	;E
	retlw	78	;N
	retlw	67	;C
	retlw	50	;2
	retlw	56	;8
	retlw	74	;J
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
	retlw	49	;1
	retlw	55	;7


StringTable4
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


StringTable5
	retlw	2
	retlw	44	;,
	retlw	32	; 


StringTable8
	retlw	9
	retlw	78	;N
	retlw	111	;o
	retlw	32	; 
	retlw	112	;p
	retlw	97	;a
	retlw	99	;c
	retlw	107	;k
	retlw	101	;e
	retlw	116	;t


StringTable10
	retlw	3
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 


StringTable11
	retlw	5
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 


StringTable15
	retlw	16
	retlw	84	;T
	retlw	67	;C
	retlw	80	;P
	retlw	32	; 
	retlw	82	;R
	retlw	101	;e
	retlw	112	;p
	retlw	108	;l
	retlw	121	;y
	retlw	32	; 
	retlw	78	;N
	retlw	101	;e
	retlw	101	;e
	retlw	100	;d
	retlw	101	;e
	retlw	100	;d


StringTable16
	retlw	21
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
	retlw	32	; 
	retlw	69	;E
	retlw	78	;N
	retlw	67	;C
	retlw	50	;2
	retlw	56	;8
	retlw	74	;J
	retlw	54	;6
	retlw	48	;0


StringTable17
	retlw	10
	retlw	32	; 
	retlw	86	;V
	retlw	101	;e
	retlw	114	;r
	retlw	115	;s
	retlw	105	;i
	retlw	111	;o
	retlw	110	;n
	retlw	58	;:
	retlw	32	; 


StringTable18
	retlw	34
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


StringTable19
	retlw	7
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 


StringTable20
	retlw	4
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 


StringTable21
	retlw	50
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
	retlw	50	;2
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


StringTable22
	retlw	6
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 


StringTable23
	retlw	1
	retlw	46	;.


StringTable24
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


StringTable25
	retlw	53
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
	retlw	32	; 
	retlw	77	;M
	retlw	65	;A
	retlw	80	;P
	retlw	72	;H
	retlw	83	;S
	retlw	85	;U
	retlw	80	;P


StringTable26
	retlw	1
	retlw	82	;R


StringTable27
	retlw	1
	retlw	68	;D


StringTable28
	retlw	1
	retlw	65	;A


StringTable29
	retlw	8
	retlw	65	;A
	retlw	99	;c
	retlw	116	;t
	retlw	105	;i
	retlw	111	;o
	retlw	110	;n
	retlw	32	; 
	retlw	65	;A


StringTable30
	retlw	1
	retlw	66	;B


StringTable31
	retlw	8
	retlw	65	;A
	retlw	99	;c
	retlw	116	;t
	retlw	105	;i
	retlw	111	;o
	retlw	110	;n
	retlw	32	; 
	retlw	66	;B


StringTable32
	retlw	1
	retlw	67	;C


StringTable33
	retlw	8
	retlw	65	;A
	retlw	99	;c
	retlw	116	;t
	retlw	105	;i
	retlw	111	;o
	retlw	110	;n
	retlw	32	; 
	retlw	67	;C


StringTable34
	retlw	8
	retlw	65	;A
	retlw	99	;c
	retlw	116	;t
	retlw	105	;i
	retlw	111	;o
	retlw	110	;n
	retlw	32	; 
	retlw	68	;D


StringTable35
	retlw	1
	retlw	69	;E


StringTable36
	retlw	8
	retlw	65	;A
	retlw	99	;c
	retlw	116	;t
	retlw	105	;i
	retlw	111	;o
	retlw	110	;n
	retlw	32	; 
	retlw	69	;E


StringTable37
	retlw	1
	retlw	97	;a


StringTable38
	retlw	8
	retlw	65	;A
	retlw	99	;c
	retlw	116	;t
	retlw	105	;i
	retlw	111	;o
	retlw	110	;n
	retlw	32	; 
	retlw	97	;a


StringTable39
	retlw	1
	retlw	98	;b


StringTable40
	retlw	8
	retlw	65	;A
	retlw	99	;c
	retlw	116	;t
	retlw	105	;i
	retlw	111	;o
	retlw	110	;n
	retlw	32	; 
	retlw	98	;b


StringTable41
	retlw	1
	retlw	99	;c


StringTable42
	retlw	8
	retlw	65	;A
	retlw	99	;c
	retlw	116	;t
	retlw	105	;i
	retlw	111	;o
	retlw	110	;n
	retlw	32	; 
	retlw	99	;c


StringTable43
	retlw	1
	retlw	100	;d


StringTable44
	retlw	8
	retlw	65	;A
	retlw	99	;c
	retlw	116	;t
	retlw	105	;i
	retlw	111	;o
	retlw	110	;n
	retlw	32	; 
	retlw	100	;d


StringTable45
	retlw	1
	retlw	101	;e


StringTable46
	retlw	8
	retlw	65	;A
	retlw	99	;c
	retlw	116	;t
	retlw	105	;i
	retlw	111	;o
	retlw	110	;n
	retlw	32	; 
	retlw	101	;e


StringTable47
	retlw	8
	retlw	65	;A
	retlw	99	;c
	retlw	116	;t
	retlw	105	;i
	retlw	111	;o
	retlw	110	;n
	retlw	32	; 
	retlw	70	;F


StringTable48
	retlw	10
	retlw	69	;E
	retlw	99	;c
	retlw	104	;h
	retlw	111	;o
	retlw	112	;p
	retlw	97	;a
	retlw	99	;c
	retlw	107	;k
	retlw	101	;e
	retlw	116	;t


;********************************************************************************

;Start of program memory page 1
	ORG	2048
CALCCHECKSUM
;Dim II As Word
;Dim LocalTmp As Word
;Dim Sum As Long
;Sum = 0
	banksel	SUM
	clrf	SUM
	clrf	SUM_H
	clrf	SUM_U
	clrf	SUM_E
;For II = Startptr To Endptr Step 2
	movlw	2
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
	goto	SysForLoopEnd11
SysForLoop11
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
	banksel	SUM
	addwf	SUM,F
	movlw	0
	addwfc	SUM_H,F
	movlw	0
	addwfc	SUM_U,F
	movlw	0
	addwfc	SUM_E,F
;LocalTmp  = etherBuffer(II) * 256
	movlw	low(ETHERBUFFER)
	banksel	II
	addwf	II,W
	movwf	AFSR0
	movlw	high(ETHERBUFFER)
	addwfc	II_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SysWORDTempA
	clrf	SysWORDTempA_H
	clrf	SysWORDTempB
	movlw	1
	movwf	SysWORDTempB_H
	pagesel	SysMultSub16
	call	SysMultSub16
	pagesel	$
	movf	SysWORDTempX,W
	movwf	LOCALTMP
	movf	SysWORDTempX_H,W
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
	goto	SysForLoop11
SysForLoopEnd11
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
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(ETHERBUFFER)
	banksel	RESULT_H
	addwfc	RESULT_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	movlw	1
	addwf	SysTemp1,W
	movwf	AFSR0
	movlw	0
	addwfc	SysTemp1_H,W
	movwf	AFSR0_H
	banksel	LOCALTMP
	movf	LOCALTMP,W
	movwf	INDF0
	return

;********************************************************************************

ENC28J60REGDUMP
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$
;HSerPrint "Registerdump ENC28J60"
	movlw	low StringTable16
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable16) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg( erevid)
	movlw	114
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint " Version: " + str( Enc28j60_data )
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
	movlw	low StringTable17
	movwf	SysStringA
	movlw	(high StringTable17) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low STR
	movwf	FSR0L
	movlw	high STR
	movwf	FSR0H
	call	SysCopyStringPart
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
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$
;HSerPrint "Cntrl: ECON1 ECON2 ESTAT  EIR  EIE"
	movlw	low StringTable18
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable18) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg( econ1)
	movlw	31
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "       " + Hex(enc28j60_data);
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
	movlw	low StringTable19
	movwf	SysStringA
	movlw	(high StringTable19) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	call	SysCopyStringPart
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
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg( econ2)
	movlw	30
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "    " + Hex(enc28j60_data);
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
	movlw	low StringTable20
	movwf	SysStringA
	movlw	(high StringTable20) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	call	SysCopyStringPart
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
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg( estat)
	movlw	29
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "    " + Hex(enc28j60_data);
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
	movlw	low StringTable20
	movwf	SysStringA
	movlw	(high StringTable20) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	call	SysCopyStringPart
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
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;ENC28J60_ReadReg (eir)
	movlw	28
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
;HSerPrint "     " + Hex(enc28j60_data);
	movf	ENC28J60_DATA,W
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
	movlw	low StringTable11
	movwf	SysStringA
	movlw	(high StringTable11) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	call	SysCopyStringPart
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
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg( eie)
	movlw	27
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "   " + Hex(enc28j60_data)
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
	movlw	low StringTable10
	movwf	SysStringA
	movlw	(high StringTable10) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	call	SysCopyStringPart
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
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$
;HSerPrint "MAC  : MACON1  MACON2  MACON3  MACON4  MAC-Address"
	movlw	low StringTable21
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable21) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg( macon1)
	movlw	192
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "       " + Hex(enc28j60_data);
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
	movlw	low StringTable19
	movwf	SysStringA
	movlw	(high StringTable19) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	call	SysCopyStringPart
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
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg( macon2)
	movf	MACON2,W
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "      " + Hex(enc28j60_data);
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
	movlw	low StringTable22
	movwf	SysStringA
	movlw	(high StringTable22) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	call	SysCopyStringPart
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
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg( macon3)
	movlw	194
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "      " + Hex(enc28j60_data);
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
	movlw	low StringTable22
	movwf	SysStringA
	movlw	(high StringTable22) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	call	SysCopyStringPart
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
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg( macon4)
	movlw	195
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "      " + Hex(enc28j60_data);
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
	movlw	low StringTable22
	movwf	SysStringA
	movlw	(high StringTable22) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	call	SysCopyStringPart
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
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg( maadr5)
	movlw	228
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "      " + Hex(enc28j60_data);
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
	movlw	low StringTable22
	movwf	SysStringA
	movlw	(high StringTable22) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	call	SysCopyStringPart
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
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg( maadr4)
	movlw	229
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "." + Hex(enc28j60_data);
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
	movlw	low StringTable23
	movwf	SysStringA
	movlw	(high StringTable23) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	call	SysCopyStringPart
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
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg( maadr3)
	movlw	226
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "." + Hex(enc28j60_data);
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
	movlw	low StringTable23
	movwf	SysStringA
	movlw	(high StringTable23) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	call	SysCopyStringPart
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
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg( maadr2)
	movlw	227
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "." + Hex(enc28j60_data);
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
	movlw	low StringTable23
	movwf	SysStringA
	movlw	(high StringTable23) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	call	SysCopyStringPart
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
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg( maadr1)
	movlw	224
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "." + Hex(enc28j60_data);
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
	movlw	low StringTable23
	movwf	SysStringA
	movlw	(high StringTable23) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	call	SysCopyStringPart
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
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg( maadr0)
	movlw	225
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "." + Hex(enc28j60_data)
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
	movlw	low StringTable23
	movwf	SysStringA
	movlw	(high StringTable23) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	call	SysCopyStringPart
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
	pagesel	HSERPRINT248
	call	HSERPRINT248
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
	movlw	low StringTable24
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable24) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg(erxsth)
	movlw	9
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "       " + Hex(enc28j60_data);
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
	movlw	low StringTable19
	movwf	SysStringA
	movlw	(high StringTable19) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	call	SysCopyStringPart
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
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg(erxstl)
	movlw	8
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint Hex(enc28j60_data);
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
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg(erxndh)
	movlw	11
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "   " + Hex(enc28j60_data);
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
	movlw	low StringTable10
	movwf	SysStringA
	movlw	(high StringTable10) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	call	SysCopyStringPart
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
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg(erxndl)
	movlw	10
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint Hex(enc28j60_data);
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
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg(erxwrpth)
	movlw	15
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "   " + Hex(enc28j60_data);
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
	movlw	low StringTable10
	movwf	SysStringA
	movlw	(high StringTable10) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	call	SysCopyStringPart
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
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg(erxwrptl)
	movlw	14
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint Hex(enc28j60_data);
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
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg(erxrdpth)
	movlw	13
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "    " + Hex(enc28j60_data);
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
	movlw	low StringTable20
	movwf	SysStringA
	movlw	(high StringTable20) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	call	SysCopyStringPart
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
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg(erxrdptl)
	movlw	12
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint Hex(enc28j60_data);
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
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg(erxfcon)
	movlw	56
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "    " + Hex(enc28j60_data);
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
	movlw	low StringTable20
	movwf	SysStringA
	movlw	(high StringTable20) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	call	SysCopyStringPart
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
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg(epktcnt)
	movlw	57
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "      " + Hex(enc28j60_data);
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
	movlw	low StringTable22
	movwf	SysStringA
	movlw	(high StringTable22) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	call	SysCopyStringPart
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
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg(mamxflh)
	movlw	203
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "      " + Hex(enc28j60_data);
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
	movlw	low StringTable22
	movwf	SysStringA
	movlw	(high StringTable22) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	call	SysCopyStringPart
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
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg(mamxfll)
	movlw	202
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint Hex(enc28j60_data)
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
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$
;HSerPrint "Tx   : ETXST  ETXND  EWRPT  MACLCON1 MACLCON2 MAPHSUP"
	movlw	low StringTable25
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable25) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg(etxsth)
	movlw	5
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "       " + Hex(enc28j60_data);
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
	movlw	low StringTable19
	movwf	SysStringA
	movlw	(high StringTable19) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	call	SysCopyStringPart
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
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg(etxstl)
	movlw	4
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint Hex(enc28j60_data);
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
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg(etxndh)
	movlw	7
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "   " + Hex(enc28j60_data);
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
	movlw	low StringTable10
	movwf	SysStringA
	movlw	(high StringTable10) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	call	SysCopyStringPart
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
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg(etxndl)
	movlw	6
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint Hex(enc28j60_data);
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
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg(EWRPTH)
	movlw	3
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "   " +  Hex(enc28j60_data);
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
	movlw	low StringTable10
	movwf	SysStringA
	movlw	(high StringTable10) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	call	SysCopyStringPart
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
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg(EWRPTl)
	movlw	2
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint Hex(enc28j60_data);
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
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg(maclcon1)
	movlw	200
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "   " + Hex(enc28j60_data);
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
	movlw	low StringTable10
	movwf	SysStringA
	movlw	(high StringTable10) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	call	SysCopyStringPart
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
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg(maclcon2)
	movlw	201
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "       " + Hex(enc28j60_data);
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
	movlw	low StringTable19
	movwf	SysStringA
	movlw	(high StringTable19) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	call	SysCopyStringPart
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
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg(maphsup)
	movf	MAPHSUP,W
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "       " + Hex(enc28j60_data)
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
	movlw	low StringTable19
	movwf	SysStringA
	movlw	(high StringTable19) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	call	SysCopyStringPart
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
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;HSerPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	goto	HSERPRINTCRLF

;********************************************************************************

ENC28J60WRITEBUFFERARP
;etherbuffer(1) = 0xFF 'Broadcast
	movlw	255
	banksel	SYSETHERBUFFER_1
	movwf	SYSETHERBUFFER_1
;etherbuffer(2) = 0xFF
	movlw	255
	movwf	SYSETHERBUFFER_2
;etherbuffer(3) = 0xFF
	movlw	255
	banksel	SYSETHERBUFFER_3
	movwf	SYSETHERBUFFER_3
;etherbuffer(4) = 0xFF
	movlw	255
	movwf	SYSETHERBUFFER_4
;etherbuffer(5) = 0xFF
	movlw	255
	movwf	SYSETHERBUFFER_5
;etherbuffer(6) = 0xFF
	movlw	255
	movwf	SYSETHERBUFFER_6
;etherbuffer(7)  = macaddr(1)
	banksel	SYSMACADDR_1
	movf	SYSMACADDR_1,W
	banksel	SYSETHERBUFFER_7
	movwf	SYSETHERBUFFER_7
;etherbuffer(8)  = macaddr(2)
	banksel	SYSMACADDR_2
	movf	SYSMACADDR_2,W
	banksel	SYSETHERBUFFER_8
	movwf	SYSETHERBUFFER_8
;etherbuffer(9)  = macaddr(3)
	banksel	SYSMACADDR_3
	movf	SYSMACADDR_3,W
	banksel	SYSETHERBUFFER_9
	movwf	SYSETHERBUFFER_9
;etherbuffer(10) = macaddr(4)
	banksel	SYSMACADDR_4
	movf	SYSMACADDR_4,W
	banksel	SYSETHERBUFFER_10
	movwf	SYSETHERBUFFER_10
;etherbuffer(11) = macaddr(5)
	banksel	SYSMACADDR_5
	movf	SYSMACADDR_5,W
	banksel	SYSETHERBUFFER_11
	movwf	SYSETHERBUFFER_11
;etherbuffer(12) = macaddr(6)
	banksel	SYSMACADDR_6
	movf	SYSMACADDR_6,W
	banksel	SYSETHERBUFFER_12
	movwf	SYSETHERBUFFER_12
;etherbuffer(13) = 0x08
	movlw	8
	movwf	SYSETHERBUFFER_13
;etherbuffer(14) = 0x06
	movlw	6
	movwf	SYSETHERBUFFER_14
;arp
;etherbuffer(15) = 0x00
	clrf	SYSETHERBUFFER_15
;etherbuffer(16) = 0x01
	movlw	1
	movwf	SYSETHERBUFFER_16
;etherbuffer(17) = 0x08
	movlw	8
	movwf	SYSETHERBUFFER_17
;etherbuffer(18) = 0x00
	clrf	SYSETHERBUFFER_18
;etherbuffer(19) = 0x06
	movlw	6
	movwf	SYSETHERBUFFER_19
;etherbuffer(20) = 0x04
	movlw	4
	movwf	SYSETHERBUFFER_20
;etherbuffer(21) = 0x00
	clrf	SYSETHERBUFFER_21
;etherbuffer(22) = 0x01
	movlw	1
	movwf	SYSETHERBUFFER_22
;etherbuffer(23) = macaddr(1)
	banksel	SYSMACADDR_1
	movf	SYSMACADDR_1,W
	banksel	SYSETHERBUFFER_23
	movwf	SYSETHERBUFFER_23
;etherbuffer(24) = macaddr(2)
	banksel	SYSMACADDR_2
	movf	SYSMACADDR_2,W
	banksel	SYSETHERBUFFER_24
	movwf	SYSETHERBUFFER_24
;etherbuffer(25) = macaddr(3)
	banksel	SYSMACADDR_3
	movf	SYSMACADDR_3,W
	banksel	SYSETHERBUFFER_25
	movwf	SYSETHERBUFFER_25
;etherbuffer(26) = macaddr(4)
	banksel	SYSMACADDR_4
	movf	SYSMACADDR_4,W
	banksel	SYSETHERBUFFER_26
	movwf	SYSETHERBUFFER_26
;etherbuffer(27) = macaddr(5)
	banksel	SYSMACADDR_5
	movf	SYSMACADDR_5,W
	banksel	SYSETHERBUFFER_27
	movwf	SYSETHERBUFFER_27
;etherbuffer(28) = macaddr(6)
	banksel	SYSMACADDR_6
	movf	SYSMACADDR_6,W
	banksel	SYSETHERBUFFER_28
	movwf	SYSETHERBUFFER_28
;etherbuffer(29) = ipaddr(1) 'own TUX-IP-number
	banksel	SYSIPADDR_1
	movf	SYSIPADDR_1,W
	banksel	SYSETHERBUFFER_29
	movwf	SYSETHERBUFFER_29
;etherbuffer(30) = ipaddr(2)
	banksel	SYSIPADDR_2
	movf	SYSIPADDR_2,W
	banksel	SYSETHERBUFFER_30
	movwf	SYSETHERBUFFER_30
;etherbuffer(31) = ipaddr(3)
	banksel	SYSIPADDR_3
	movf	SYSIPADDR_3,W
	banksel	SYSETHERBUFFER_31
	movwf	SYSETHERBUFFER_31
;etherbuffer(32) = ipaddr(4)
	banksel	SYSIPADDR_4
	movf	SYSIPADDR_4,W
	banksel	SYSETHERBUFFER_32
	movwf	SYSETHERBUFFER_32
;etherbuffer(33) = 0x00 'MAC-address router
	clrf	SYSETHERBUFFER_33
;etherbuffer(34) = 0x00
	clrf	SYSETHERBUFFER_34
;etherbuffer(35) = 0x00
	clrf	SYSETHERBUFFER_35
;etherbuffer(36) = 0x00
	clrf	SYSETHERBUFFER_36
;etherbuffer(37) = 0x00
	clrf	SYSETHERBUFFER_37
;etherbuffer(38) = 0x00
	clrf	SYSETHERBUFFER_38
;etherbuffer(39) = iprouter(1) 'IP-number router
	banksel	SYSIPROUTER_1
	movf	SYSIPROUTER_1,W
	banksel	SYSETHERBUFFER_39
	movwf	SYSETHERBUFFER_39
;etherbuffer(40) = iprouter(2)
	banksel	SYSIPROUTER_2
	movf	SYSIPROUTER_2,W
	banksel	SYSETHERBUFFER_40
	movwf	SYSETHERBUFFER_40
;etherbuffer(41) = iprouter(3)
	banksel	SYSIPROUTER_3
	movf	SYSIPROUTER_3,W
	banksel	SYSETHERBUFFER_41
	movwf	SYSETHERBUFFER_41
;etherbuffer(42) = iprouter(4)
	banksel	SYSIPROUTER_4
	movf	SYSIPROUTER_4,W
	banksel	SYSETHERBUFFER_42
	movwf	SYSETHERBUFFER_42
;Enc28j60writebuffer( 42 )' as 60 is the true length of ARP packet
	movlw	42
	banksel	PCKTLEN
	movwf	PCKTLEN
	clrf	PCKTLEN_H
	banksel	STATUS
	pagesel	ENC28J60WRITEBUFFER
	call	ENC28J60WRITEBUFFER
	pagesel	$
;Enc28j60packetsend( 60 )
	movlw	60
	banksel	PCKTLEN
	movwf	PCKTLEN
	clrf	PCKTLEN_H
	banksel	STATUS
	pagesel	ENC28J60PACKETSEND
	goto	ENC28J60PACKETSEND

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

;Start of program memory page 2
	ORG	4096
ARPREPLY
;ENC28J60_Setst_mac
	call	ENC28J60_SETST_MAC
;For II = 1 To 6
	clrf	II
SysForLoop5
	incf	II,F
;etherBuffer(32 + II) = etherBuffer(II)
	movlw	low(ETHERBUFFER)
	addwf	II,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	high(ETHERBUFFER)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP2
	movwf	SysArrayTemp2
	movwf	SysArrayTemp1
	movlw	low(ETHERBUFFER+32)
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(ETHERBUFFER+32)
	movwf	SysTemp1_H
	banksel	II
	movf	II,W
	banksel	SYSTEMP1
	addwf	SysTemp1,W
	movwf	AFSR0
	movlw	0
	addwfc	SysTemp1_H,W
	movwf	AFSR0_H
	banksel	SYSARRAYTEMP1
	movf	SysArrayTemp1,W
	movwf	INDF0
;Next
	movlw	6
	banksel	II
	subwf	II,W
	btfss	STATUS, C
	goto	SysForLoop5
SysForLoopEnd5
;For II = 1 To 4
	clrf	II
SysForLoop6
	incf	II,F
;etherBuffer(38 + II) = etherBuffer(28 + II)
	movlw	low(ETHERBUFFER+28)
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(ETHERBUFFER+28)
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
	movlw	low(ETHERBUFFER+38)
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(ETHERBUFFER+38)
	movwf	SysTemp1_H
	banksel	II
	movf	II,W
	banksel	SYSTEMP1
	addwf	SysTemp1,W
	movwf	AFSR0
	movlw	0
	addwfc	SysTemp1_H,W
	movwf	AFSR0_H
	banksel	SYSARRAYTEMP1
	movf	SysArrayTemp1,W
	movwf	INDF0
;Next
	movlw	4
	banksel	II
	subwf	II,W
	btfss	STATUS, C
	goto	SysForLoop6
SysForLoopEnd6
;For II = 1 To 6
	clrf	II
SysForLoop7
	incf	II,F
;etherBuffer(22 + II) = etherBuffer(6 + II)
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
	movlw	low(ETHERBUFFER+22)
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(ETHERBUFFER+22)
	movwf	SysTemp1_H
	banksel	II
	movf	II,W
	banksel	SYSTEMP1
	addwf	SysTemp1,W
	movwf	AFSR0
	movlw	0
	addwfc	SysTemp1_H,W
	movwf	AFSR0_H
	banksel	SYSARRAYTEMP1
	movf	SysArrayTemp1,W
	movwf	INDF0
;Next
	movlw	6
	banksel	II
	subwf	II,W
	btfss	STATUS, C
	goto	SysForLoop7
SysForLoopEnd7
;etherBuffer(29) = ipaddr(1)
	banksel	SYSIPADDR_1
	movf	SYSIPADDR_1,W
	banksel	SYSETHERBUFFER_29
	movwf	SYSETHERBUFFER_29
;etherBuffer(30) = ipaddr(2)
	banksel	SYSIPADDR_2
	movf	SYSIPADDR_2,W
	banksel	SYSETHERBUFFER_30
	movwf	SYSETHERBUFFER_30
;etherBuffer(31) = ipaddr(3)
	banksel	SYSIPADDR_3
	movf	SYSIPADDR_3,W
	banksel	SYSETHERBUFFER_31
	movwf	SYSETHERBUFFER_31
;etherBuffer(32) = ipaddr(4)
	banksel	SYSIPADDR_4
	movf	SYSIPADDR_4,W
	banksel	SYSETHERBUFFER_32
	movwf	SYSETHERBUFFER_32
;etherBuffer(22) = 2
	movlw	2
	movwf	SYSETHERBUFFER_22
;HSerSend 9
;HSerPrint "       >"
;
;for ii = 1 to 24
;HSerPrint hex(etherbuffer(ii))
;HSerPrint ":"
;next
;HSerPrintCRLF
;Enc28j60writebuffer( 42 )
	movlw	42
	banksel	PCKTLEN
	movwf	PCKTLEN
	clrf	PCKTLEN_H
	banksel	STATUS
	call	ENC28J60WRITEBUFFER
;Enc28j60packetsend(42)
	movlw	42
	banksel	PCKTLEN
	movwf	PCKTLEN
	clrf	PCKTLEN_H
	banksel	STATUS
	goto	ENC28J60PACKETSEND

;********************************************************************************

ENC28J60PACKETRECEIVE
;Dim eth_counter, eth_frameLength As Word
;Dim previous_nextpacketptr as word
;ENC28J60_temp = ENC28J60_ReadReg (eir) and EIR_PKTIF
	movlw	28
	movwf	ADDR
	call	FN_ENC28J60_READREG
	movlw	64
	andwf	ENC28J60_READREG,W
	movwf	ENC28J60_TEMP
;If ENC28J60_temp <> EIR_PKTIF Then
	movlw	64
	subwf	ENC28J60_TEMP,W
	btfsc	STATUS, Z
	goto	ENDIF39
;HSerPrint "No packet"
	movlw	low StringTable8
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable8) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
;ENC28J60_bitSet( ECON2, ECON2_PKTDEC )
	movlw	30
	movwf	ADDR
	movlw	64
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_BITSET
	call	ENC28J60_BITSET
	pagesel	$
;Exit Sub
	return
;End If
ENDIF39
;packetCounterIn++
	banksel	PACKETCOUNTERIN
	incf	PACKETCOUNTERIN,F
	btfsc	STATUS,Z
	incf	PACKETCOUNTERIN_H,F
	btfsc	STATUS,Z
	incf	PACKETCOUNTERIN_U,F
	btfsc	STATUS,Z
	incf	PACKETCOUNTERIN_E,F
;Enc28j60_data = ENC28J60_ReadReg( erevid )
	movlw	114
	banksel	ADDR
	movwf	ADDR
	call	FN_ENC28J60_READREG
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;do
;ENC28J60_writeReg(ERDPTL, [byte]nextpacketptr )
	clrf	ADDR
	movf	NEXTPACKETPTR,W
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(ERDPTH, nextpacketptr_h )
	movlw	1
	movwf	ADDR
	movf	NEXTPACKETPTR_H,W
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;loop while (ENC28J60_ReadReg(ERDPTL) <>  [byte]nextpacketptr) or (ENC28J60_ReadReg(ERDPTH) <> nextpacketptr_h )
;Enc28j60readbuffer(6)
	movlw	6
	movwf	ETHERGETLENGTH
	clrf	ETHERGETLENGTH_H
	call	ENC28J60READBUFFER
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
;HSerPrint hex(etherbuffer(5))
;HSerSend 9
;HSerPrint hex(etherbuffer(5) and 0x80 )
;HSerPrintCRLF
;HSerPrint hex(etherbuffer(6))
;HSerPrintCRLF
;if ( etherbuffer(5) AND 0x80 ) = 0x80 then
	movlw	128
	banksel	SYSETHERBUFFER_5
	andwf	SYSETHERBUFFER_5,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movwf	SysBYTETempA
	movlw	128
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SysCompEqual
	call	SysCompEqual
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF40
;Enc28j60readbuffer(eth_frameLength)
	movf	ETH_FRAMELENGTH,W
	movwf	ETHERGETLENGTH
	movf	ETH_FRAMELENGTH_H,W
	movwf	ETHERGETLENGTH_H
	call	ENC28J60READBUFFER
;end if
ENDIF40
ENDPACKET
;do
SysDoLoop_S4
;ENC28J60_writeReg(ERDPTL, [byte]nextpacketptr )
	banksel	ADDR
	clrf	ADDR
	movf	NEXTPACKETPTR,W
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(ERDPTH, nextpacketptr_h )
	movlw	1
	movwf	ADDR
	movf	NEXTPACKETPTR_H,W
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;loop while (ENC28J60_ReadReg(ERDPTL) <>  [byte]nextpacketptr) or (ENC28J60_ReadReg(ERDPTH) <> nextpacketptr_h )
	clrf	ADDR
	call	FN_ENC28J60_READREG
	movf	ENC28J60_READREG,W
	banksel	SYSFNBYTE1
	movwf	SysFnBYTE1
	movlw	1
	banksel	ADDR
	movwf	ADDR
	call	FN_ENC28J60_READREG
	banksel	SYSFNBYTE1
	movf	sysfnbyte1,W
	movwf	SysBYTETempA
	banksel	NEXTPACKETPTR
	movf	NEXTPACKETPTR,W
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
	movf	nextpacketptr_h,W
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
	movwf	SysTemp3
	btfsc	SysTemp3,0
	goto	SysDoLoop_S4
SysDoLoop_E4
;IF ( nextpacketptr and 1 ) = 0 THEN
	movlw	1
	banksel	NEXTPACKETPTR
	andwf	NEXTPACKETPTR,W
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
	goto	ENDIF41
;eth_counter = nextpacketptr -1
	movlw	1
	subwf	NEXTPACKETPTR,W
	movwf	ETH_COUNTER
	movlw	0
	subwfb	NEXTPACKETPTR_H,W
	movwf	ETH_COUNTER_H
;END IF
ENDIF41
;ENC28J60_writeReg(ERXRDPTL, [byte]eth_counter )
	movlw	12
	movwf	ADDR
	movf	ETH_COUNTER,W
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(ERXRDPTH, eth_counter_h )
	movlw	13
	movwf	ADDR
	movf	ETH_COUNTER_H,W
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_bitSet( ECON2, ECON2_PKTDEC )
	movlw	30
	movwf	ADDR
	movlw	64
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_BITSET
	call	ENC28J60_BITSET
	pagesel	$
;
;HSerPrintCRLF
;HSerSend 9
;HSerSend 9
;
;for ii = 1 to 24
;HSerPrint hex(etherbuffer(ii))
;HSerPrint ":"
;next
;HSerPrintCRLF
;If etherBuffer(13) = 0X08 Then
	movlw	8
	banksel	SYSETHERBUFFER_13
	subwf	SYSETHERBUFFER_13,W
	btfss	STATUS, Z
	goto	ENDIF42
;HSerPrint "13@1,"
;If etherBuffer(14) = 0X06 Then                             'Type:ARP
	movlw	6
	subwf	SYSETHERBUFFER_14,W
	btfss	STATUS, Z
	goto	ENDIF43
;HSerPrint "14@1,"
;If etherBuffer(21) = 0X00 Then                          'ARP request
	movf	SYSETHERBUFFER_21,F
	btfss	STATUS, Z
	goto	ENDIF45
;If etherBuffer(22) = 0X01 Then                       'ARP request
	decf	SYSETHERBUFFER_22,W
	btfss	STATUS, Z
	goto	ENDIF47
;If etherBuffer(39) = ipaddr(1) Then                  'ARP for us
	banksel	SYSIPADDR_1
	movf	SYSIPADDR_1,W
	banksel	SYSETHERBUFFER_39
	subwf	SYSETHERBUFFER_39,W
	btfss	STATUS, Z
	goto	ENDIF49
;If etherBuffer(40) = ipaddr(2) Then
	banksel	SYSIPADDR_2
	movf	SYSIPADDR_2,W
	banksel	SYSETHERBUFFER_40
	subwf	SYSETHERBUFFER_40,W
	btfss	STATUS, Z
	goto	ENDIF51
;If etherBuffer(41) = ipaddr(3) Then
	banksel	SYSIPADDR_3
	movf	SYSIPADDR_3,W
	banksel	SYSETHERBUFFER_41
	subwf	SYSETHERBUFFER_41,W
	btfss	STATUS, Z
	goto	ENDIF53
;If etherBuffer(42) = ipaddr(4) Then
	banksel	SYSIPADDR_4
	movf	SYSIPADDR_4,W
	banksel	SYSETHERBUFFER_42
	subwf	SYSETHERBUFFER_42,W
	btfss	STATUS, Z
	goto	ENDIF55
;Arpreply
	banksel	STATUS
	call	ARPREPLY
;HSerPrint "ARP Replied": HSerPrintCRLF
;End If
ENDIF55
;End If
ENDIF53
;End If
ENDIF51
;End If
ENDIF49
;End If
ENDIF47
;End If
ENDIF45
;End If
ENDIF43
;If etherBuffer(14) = 0X00 Then                             'Type:IP
	banksel	SYSETHERBUFFER_14
	movf	SYSETHERBUFFER_14,F
	btfss	STATUS, Z
	goto	ENDIF44
;HSerPrint "14@2,"
;If etherBuffer(15) = 0X45 Then                          'We handle only simple IP packets
	movlw	69
	subwf	SYSETHERBUFFER_15,W
	btfss	STATUS, Z
	goto	ENDIF46
;HSerPrint "15@2,"
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
	goto	ENDIF48
;HSerPrint "21@2,"
;If etherBuffer(31) = ipaddr(1) Then                  'Ip packet for us
	banksel	SYSIPADDR_1
	movf	SYSIPADDR_1,W
	banksel	SYSETHERBUFFER_31
	subwf	SYSETHERBUFFER_31,W
	btfss	STATUS, Z
	goto	ENDIF50
;If etherBuffer(32) = ipaddr(2) Then
	banksel	SYSIPADDR_2
	movf	SYSIPADDR_2,W
	banksel	SYSETHERBUFFER_32
	subwf	SYSETHERBUFFER_32,W
	btfss	STATUS, Z
	goto	ENDIF52
;If etherBuffer(33) = ipaddr(3) Then
	banksel	SYSIPADDR_3
	movf	SYSIPADDR_3,W
	banksel	SYSETHERBUFFER_33
	subwf	SYSETHERBUFFER_33,W
	btfss	STATUS, Z
	goto	ENDIF54
;If etherBuffer(34) = ipaddr(4) Then
	banksel	SYSIPADDR_4
	movf	SYSIPADDR_4,W
	banksel	SYSETHERBUFFER_34
	subwf	SYSETHERBUFFER_34,W
	btfss	STATUS, Z
	goto	ENDIF56
;If etherBuffer(24) = 1 Then              'Protocol:ICMP
	decf	SYSETHERBUFFER_24,W
	btfss	STATUS, Z
	goto	ENDIF57
;If etherBuffer(35) = 0X08 Then        'ICMP echo request
	movlw	8
	subwf	SYSETHERBUFFER_35,W
	btfss	STATUS, Z
	goto	ENDIF60
;Pingreply
	banksel	STATUS
	call	PINGREPLY
;HSerPrint "Pinged ": HSerPrintCRLF
;End If
ENDIF60
;End If
ENDIF57
;If etherBuffer(24) = 17 Then             'Protocol:UDP
	movlw	17
	banksel	SYSETHERBUFFER_24
	subwf	SYSETHERBUFFER_24,W
	btfss	STATUS, Z
	goto	ENDIF58
;Udp_receive                    'werkt wel
;ENC28J60_Udp
	banksel	STATUS
	pagesel	ENC28J60_UDP
	call	ENC28J60_UDP
	pagesel	$
;End If
ENDIF58
;If etherBuffer(24) = 6 Then              'Protocol:TCP
	movlw	6
	banksel	SYSETHERBUFFER_24
	subwf	SYSETHERBUFFER_24,W
	btfss	STATUS, Z
	goto	ENDIF59
;Tcp                            'werkt niet
;HSerPrint "TCP Reply Needed": HSerPrintCRLF
	movlw	low StringTable15
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable15) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	banksel	COMPORT
	movwf	COMPORT
	pagesel	HSERPRINT248
	call	HSERPRINT248
	pagesel	$
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$
;End If
ENDIF59
;End If
ENDIF56
;End If
ENDIF54
;End If
ENDIF52
;End If
ENDIF50
;End If
ENDIF48
;End If
ENDIF46
;End If
ENDIF44
;End If
ENDIF42
	banksel	STATUS
	return

;********************************************************************************

ENC28J60PACKETSEND
;ENC28J60_bitSet( ECON1 , econ1_txrst )
	movlw	31
	movwf	ADDR
	movlw	128
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_BITSET
	call	ENC28J60_BITSET
	pagesel	$
;ENC28J60_bitClear( ECON1 , econ1_txrst )
	movlw	31
	movwf	ADDR
	movlw	128
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_BITCLEAR
	call	ENC28J60_BITCLEAR
	pagesel	$
;added
;ENC28J60_bitClear( EIR , EIR_TXERIF )
	movlw	28
	movwf	ADDR
	movlw	2
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_BITCLEAR
	call	ENC28J60_BITCLEAR
	pagesel	$
;wait while ( (ENC28J60_ReadReg( ECON1 ) & ECON1_TXRTS ) = ECON1_TXRTS )
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
;ENC28J60_writeReg(etxndl , (ENC_TXBUF_STL + pcktlen ) & 0xFF )
	movlw	6
	movwf	ADDR
	movlw	112
	banksel	PCKTLEN
	addwf	PCKTLEN,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	0
	banksel	PCKTLEN_H
	addwfc	PCKTLEN_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	movf	SysTemp1,W
	banksel	ENC_OUTBYTE
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(etxndh , ENC_TXBUF_STH + pcktlen_h )
	movlw	7
	movwf	ADDR
	movlw	22
	banksel	PCKTLEN_H
	addwf	PCKTLEN_H,W
	banksel	ENC_OUTBYTE
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_bitSet( EIR , EIR_TXIF )
	movlw	28
	movwf	ADDR
	movlw	8
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_BITSET
	call	ENC28J60_BITSET
	pagesel	$
;ENC28J60_bitClear( EIE , EIE_TXIE )
	movlw	27
	movwf	ADDR
	movlw	8
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_BITCLEAR
	call	ENC28J60_BITCLEAR
	pagesel	$
;ENC28J60_bitSet( ECON1 , econ1_txrts )
	movlw	31
	movwf	ADDR
	movlw	8
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_BITSET
	call	ENC28J60_BITSET
	pagesel	$
;wait while ( (ENC28J60_ReadReg( ECON1 ) & ECON1_TXRTS ) = ECON1_TXRTS )
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
;packetCounterOut++
	banksel	PACKETCOUNTEROUT
	incf	PACKETCOUNTEROUT,F
	btfsc	STATUS,Z
	incf	PACKETCOUNTEROUT_H,F
	btfsc	STATUS,Z
	incf	PACKETCOUNTEROUT_U,F
	btfsc	STATUS,Z
	incf	PACKETCOUNTEROUT_E,F
;Value = 0
;Value.econ1_txrst = 1
;Call Enc28j60bitfield_set(econ1 , Value)
;
;Value.econ1_txrst = 1
;Call Enc28j60bitfield_clear(econ1 , Value)
;
;'set the write pointer to start of transmit buffer area
;Value = Low(txstart_init)
;Call Enc28j60writecontrolregbyte(ewrptl , Value)
;
;Value = High(txstart_init)
;Call Enc28j60writecontrolregbyte(ewrpth , Value)
;
;'set the TXND pointer to correspond to the packet size given
;Value = Low(txstart_init)
;Value = Value + Low(pcktlen)
;Call Enc28j60writecontrolregbyte(etxndl , Value)
;
;Value = High(txstart_init)
;Value = Value + High(pcktlen)
;
;Call Enc28j60writecontrolregbyte(etxndh , Value)
;
;'send the contents of the transmit buffer onto the network
;Value = 0
;Value.econ1_txrts = 1
;Call Enc28j60bitfield_set(econ1 , Value)
	banksel	STATUS
	return

;********************************************************************************

ENC28J60READBUFFER
;dim eth_counter as Word
;if etherGetLength  > 1518 then Exit Sub
	movf	ETHERGETLENGTH,W
	movwf	SysWORDTempB
	movf	ETHERGETLENGTH_H,W
	movwf	SysWORDTempB_H
	movlw	238
	movwf	SysWORDTempA
	movlw	5
	movwf	SysWORDTempA_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	return
;ENC28J60_Select
	bcf	LATB,2
;Set WCOL Off
	banksel	SSP1CON1
	bcf	SSP1CON1,WCOL
;SSPBUF = ENC28J60_READ_BUF_MEM
	movlw	58
	movwf	SSPBUF
;Wait While BF = Off
SysWaitLoop15
	btfss	SSP1STAT,BF
	goto	SysWaitLoop15
;temp = SSPBUF
	movf	SSPBUF,W
	banksel	TEMP
	movwf	TEMP
;if etherGetLength < etherBufferSize+1 then
	banksel	ETHERGETLENGTH
	movf	ETHERGETLENGTH,W
	movwf	SysWORDTempA
	movf	ETHERGETLENGTH_H,W
	movwf	SysWORDTempA_H
	movlw	129
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF83
;for eth_counter = 1 to etherGetLength
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
	goto	SysForLoopEnd12
SysForLoop12
	incf	ETH_COUNTER,F
	btfsc	STATUS,Z
	incf	ETH_COUNTER_H,F
;SSPBUF = 0
	banksel	SSPBUF
	clrf	SSPBUF
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
	goto	SysForLoop12
SysForLoopEnd12
;End if
ENDIF83
;if etherGetLength > etherBufferSize then
;
;for eth_counter = 65 to etherGetLength
;SSPBUF = 0
;Wait While BF = Off
;temp = SSPBUF
;
;next
;
;End if
;ENC28J60_Deselect
	bsf	LATB,2
	return

;********************************************************************************

ENC28J60WRITEBUFFER
;dim eth_counter as Word
;ENC28J60_writeReg(ewrptl, ENC_TXBUF_STL)
	movlw	2
	movwf	ADDR
	movlw	112
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(ewrpth, ENC_TXBUF_STH)
	movlw	3
	movwf	ADDR
	movlw	22
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_Select
	bcf	LATB,2
;Set WCOL Off
	banksel	SSP1CON1
	bcf	SSP1CON1,WCOL
;SSPBUF = Enc28j60_write_buf_mem
	movlw	122
	movwf	SSPBUF
;Wait While BF = Off
SysWaitLoop7
	btfss	SSP1STAT,BF
	goto	SysWaitLoop7
;temp = SSPBUF
	movf	SSPBUF,W
	banksel	TEMP
	movwf	TEMP
;SSPBUF = 0x0E
	movlw	14
	banksel	SSPBUF
	movwf	SSPBUF
;Wait While BF = Off
SysWaitLoop8
	btfss	SSP1STAT,BF
	goto	SysWaitLoop8
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
	movlw	128
	movwf	SysWORDTempA
	clrf	SysWORDTempA_H
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
	banksel	SSPBUF
	movwf	SSPBUF
;Wait While BF = Off
SysWaitLoop9
	btfss	SSP1STAT,BF
	goto	SysWaitLoop9
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
	goto	SysForLoop1
SysForLoopEnd1
;ENC28J60_Deselect
	bsf	LATB,2
	return

;********************************************************************************

ENC28J60_INIT
;Dir ENC28J60_DI in
	bsf	TRISB,4
;Dir ENC28J60_DO Out
	bcf	TRISB,5
;Dir ENC28J60_SCK Out
	bcf	TRISB,3
;Dir ENC28J60_CS out
	bcf	TRISB,2
;Dir ENC28J60_RESET out
	bcf	TRISB,1
;set ENC28J60_DO off
	bcf	LATB,5
;set ENC28J60_SCK off
	bcf	LATB,3
;set ENC28J60_CS off
	bcf	LATB,2
;ENC28J60_Deselect
	bsf	LATB,2
;Repeat 5
	movlw	5
	banksel	SYSREPEATTEMP2
	movwf	SysRepeatTemp2
SysRepeatLoop2
;ENC28J60_Reset_CMD
	banksel	LATB
	bsf	LATB,1
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
	bcf	LATB,1
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
	bsf	LATB,1
	movlw	10
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
;ENC28J60_Select
	banksel	LATB
	bcf	LATB,2
;SPIMode Master, 0
	movlw	12
	banksel	SPICURRENTMODE
	movwf	SPICURRENTMODE
	clrf	SPICLOCKMODE
	banksel	STATUS
	call	SPIMODE204
;FastHWSPITransfer( ENC28J60_SOFT_RESET, temp )
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
;wait while ( (ENC28J60_ReadReg( ESTAT ) & ESTAT_CLKRDY ) <> ESTAT_CLKRDY)
SysWaitLoop1
	movlw	29
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
	pagesel	SysCompEqual
	call	SysCompEqual
	pagesel	$
	comf	SysByteTempX,F
	btfsc	SysByteTempX,0
	goto	SysWaitLoop1
;ENC28J60_writeReg(ECON1, 0xC0) 'Hold it in Reset
	movlw	31
	movwf	ADDR
	movlw	192
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(ECON2, 0x80) 'Set the AUTOINC bit
	movlw	30
	movwf	ADDR
	movlw	128
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(EIR, 0x00) 'Reset interrupt flags
	movlw	28
	movwf	ADDR
	clrf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(EIE,  0xC0)  'Interrupts: Packet reception
	movlw	27
	movwf	ADDR
	movlw	192
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(EWOLIE, 0x00)  'Disable wake-on-lan interrupts
	movlw	54
	movwf	ADDR
	clrf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(EWOLIR, 0x00)  'Clear wake-on-lan interrupt flags
	movlw	55
	movwf	ADDR
	clrf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(ETXSTL, ENC_TXBUF_STL)
	movlw	4
	movwf	ADDR
	movlw	112
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(ETXSTH, ENC_TXBUF_STH)
	movlw	5
	movwf	ADDR
	movlw	22
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(ETXNDL, ENC_TXBUF_NDL)
	movlw	6
	movwf	ADDR
	movlw	255
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(ETXNDH, ENC_TXBUF_NDH)  'TX Buffer : 1800 bytes
	movlw	7
	movwf	ADDR
	movlw	31
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(ERXSTL, ENC_RXBUF_STL)
	movlw	8
	movwf	ADDR
	clrf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(ERXSTH, ENC_RXBUF_STH)
	movlw	9
	movwf	ADDR
	clrf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(ERXNDL, ENC_RXBUF_NDL)
	movlw	10
	movwf	ADDR
	movlw	110
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(ERXNDH, ENC_RXBUF_NDH)  'RX Buffer : 6390 bytes
	movlw	11
	movwf	ADDR
	movlw	22
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(ERDPTL, ENC_RXBUF_STL)
	clrf	ADDR
	clrf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(ERDPTH, ENC_RXBUF_STH)
	movlw	1
	movwf	ADDR
	clrf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ERXND
;ENC28J60_writeReg(ERXRDPTL, ENC_RXBUF_STL)
	movlw	12
	movwf	ADDR
	clrf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(ERXRDPTH, ENC_RXBUF_STH) 'RX Pointers (same)
	movlw	13
	movwf	ADDR
	clrf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;nextpacketptr = ENC_RXBUF_ST
	clrf	NEXTPACKETPTR
	clrf	NEXTPACKETPTR_H
;ENC28J60_writeReg(ERXFCON, 0xA1) 'Receive unicasts or broadcasts
	movlw	56
	movwf	ADDR
	movlw	161
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(EFLOCON, 0x00) 'Disable flow control sending
	movlw	119
	movwf	ADDR
	clrf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(ECOCON, 0x00) 'Disable Clock Out pin
	movlw	117
	movwf	ADDR
	clrf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(EBSTCON, 0x00) 'Disable built-in self test controller
	movlw	103
	movwf	ADDR
	clrf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;wait while ( (ENC28J60_ReadReg(ESTAT) & ESTAT_CLKRDY) <> ESTAT_CLKRDY)
SysWaitLoop2
	movlw	29
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
	pagesel	SysCompEqual
	call	SysCompEqual
	pagesel	$
	comf	SysByteTempX,F
	btfsc	SysByteTempX,0
	goto	SysWaitLoop2
;ENC28J60_writeReg(MISTAT, 0x00)  'Clear MII status register
	movlw	234
	movwf	ADDR
	clrf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(MICMD, 0x00)   'Clear MII command register
	movlw	210
	movwf	ADDR
	clrf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(MICON1, 0x02)  'Fast MII operation
;ENC28J60_writeReg(MICON2, 0x00)  'Release MII interface from reset
;ENC28J60_writeReg(MACON1, b'00001101' )  'Enable packet reception
	movlw	192
	movwf	ADDR
	movlw	13
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(MACON2, 0x00)  'Release the MAC subsystem from reset
;ENC28J60_writeReg(MACON3, 0xB1)  'Auto Pad + CRC + Full Duplex
;ENC28J60_writeReg(MACON3, 0x32)  'Auto Pad to 60 bytes + CRC + Half Duplex + Check frame length
	movlw	194
	movwf	ADDR
	movlw	50
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(MACON4, 0x01)  'Need valid preamble
	movlw	195
	movwf	ADDR
	movlw	1
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(MAPHSUP, b'00010000') 'Release MAC-PHY support from Reset
;ENC28J60_writeReg(MAMXFLL, 0xEE)
	movlw	202
	movwf	ADDR
	movlw	238
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(MAMXFLH, 0x05)  'Maximum frame length
	movlw	203
	movwf	ADDR
	movlw	5
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(MABBIPG, 0x12) 'IEEE BTB Inter Packet Gap
	movlw	196
	movwf	ADDR
	movlw	18
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(MAIPGL, 0x12)
	movlw	198
	movwf	ADDR
	movlw	18
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(MAIPGH, 0x0C)  'IEEE Non BTB Inter Packet Gap
	movlw	199
	movwf	ADDR
	movlw	12
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(MAADR0, macaddr(2))
	movlw	225
	movwf	ADDR
	banksel	SYSMACADDR_2
	movf	SYSMACADDR_2,W
	banksel	ENC_OUTBYTE
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(MAADR1, macaddr(1))
	movlw	224
	movwf	ADDR
	banksel	SYSMACADDR_1
	movf	SYSMACADDR_1,W
	banksel	ENC_OUTBYTE
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(MAADR2, macaddr(4))
	movlw	227
	movwf	ADDR
	banksel	SYSMACADDR_4
	movf	SYSMACADDR_4,W
	banksel	ENC_OUTBYTE
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(MAADR3, macaddr(3))
	movlw	226
	movwf	ADDR
	banksel	SYSMACADDR_3
	movf	SYSMACADDR_3,W
	banksel	ENC_OUTBYTE
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(MAADR4, macaddr(6))
	movlw	229
	movwf	ADDR
	banksel	SYSMACADDR_6
	movf	SYSMACADDR_6,W
	banksel	ENC_OUTBYTE
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(MAADR5, macaddr(5))
	movlw	228
	movwf	ADDR
	banksel	SYSMACADDR_5
	movf	SYSMACADDR_5,W
	banksel	ENC_OUTBYTE
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;'Initialize PHY subsystem
;ENC28J60_writePhyReg(PHCON1, 0x00, 0x00)  'Half duplex
	banksel	PHYREGADDR
	clrf	PHYREGADDR
	banksel	ENC_OUTBYTE1
	clrf	ENC_OUTBYTE1
	clrf	ENC_OUTBYTE2
	pagesel	ENC28J60_WRITEPHYREG
	call	ENC28J60_WRITEPHYREG
	pagesel	$
;ENC28J60_writePhyReg(PHCON2, 0x00, 0x00)
	movlw	16
	banksel	PHYREGADDR
	movwf	PHYREGADDR
	banksel	ENC_OUTBYTE1
	clrf	ENC_OUTBYTE1
	clrf	ENC_OUTBYTE2
	pagesel	ENC28J60_WRITEPHYREG
	call	ENC28J60_WRITEPHYREG
	pagesel	$
;ENC28J60_writePhyReg(PHLCON, B'00000100', B'01110110')
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
;ENC28J60_writePhyReg(PHIE, 0x00, 0x00)  'Disable interrupts
	movlw	18
	banksel	PHYREGADDR
	movwf	PHYREGADDR
	banksel	ENC_OUTBYTE1
	clrf	ENC_OUTBYTE1
	clrf	ENC_OUTBYTE2
	pagesel	ENC28J60_WRITEPHYREG
	call	ENC28J60_WRITEPHYREG
	pagesel	$
;ENC28J60_writeReg(ECON1, B'00010100')
	movlw	31
	movwf	ADDR
	movlw	20
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(ECON1, B'00000100')
;ENC28J60_writePhyReg ( PHLCON, 0xA2, 0x0A )
;wait 5 s
;ENC28J60_writePhyReg ( PHLCON, 0x76, 0x04 )
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

FN_ENC28J60_READREG
;banktobeselected =  ( addr & BANK_MASK) / 32
	movlw	96
	andwf	ADDR,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movwf	SysBYTETempA
	movlw	32
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SysDivSub
	call	SysDivSub
	pagesel	$
	movf	SysBYTETempA,W
	movwf	BANKTOBESELECTED
;				'These registers (EIE, EIR, ESTAT, ECON2, ECON1)
;				'are present in all banks, no need to switch bank
;if lastselectedBank <> banktobeselected then
	subwf	LASTSELECTEDBANK,W
	btfsc	STATUS, Z
	goto	ENDIF11
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
	goto	ELSE12_1
;ENC28J60_selectBank ( banktobeselected, addr )
	call	ENC28J60_SELECTBANK
;else
	goto	ENDIF12
ELSE12_1
;lastselectedBank = banktobeselected
	movf	BANKTOBESELECTED,W
	movwf	LASTSELECTEDBANK
;end if
ENDIF12
;end if
ENDIF11
;ENC28J60_Select
	bcf	LATB,2
;Set WCOL Off
	banksel	SSP1CON1
	bcf	SSP1CON1,WCOL
;SSPBUF = ENC28J60_READ_CTRL_REG | ( addr AND ADDR_MASK )
	movlw	31
	banksel	ADDR
	andwf	ADDR,W
	banksel	SYSTEMP1
	movwf	SysTemp1
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
SysWaitLoop6
	btfss	SSP1STAT,BF
	goto	SysWaitLoop6
;ENC28J60_ReadReg = SSPBUF
	movf	SSPBUF,W
	banksel	ENC28J60_READREG
	movwf	ENC28J60_READREG
;ENC28J60_Deselect
	bsf	LATB,2
	return

;********************************************************************************

ENC28J60_SELECTBANK
;ENC28J60_Select
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
;ENC28J60_Deselect
	bsf	LATB,2
;Select case banktobeselected
;case 1
SysSelect1Case1
	decf	BANKTOBESELECTED,W
	btfss	STATUS, Z
	goto	SysSelect1Case2
;ENC28J60_Select
	bcf	LATB,2
;FastHWSPITransfer(BFSCMD | ECON1, temp)
	movlw	159
	banksel	SPITXDATA
	movwf	SPITXDATA
	banksel	STATUS
	pagesel	FASTHWSPITRANSFER
	call	FASTHWSPITRANSFER
	pagesel	$
;FastHWSPITransfer(b'00000001' , temp)
	movlw	1
	banksel	SPITXDATA
	movwf	SPITXDATA
	banksel	STATUS
	pagesel	FASTHWSPITRANSFER
	call	FASTHWSPITRANSFER
	pagesel	$
;ENC28J60_Deselect
	bsf	LATB,2
;case 2
	goto	SysSelectEnd1
SysSelect1Case2
	movlw	2
	subwf	BANKTOBESELECTED,W
	btfss	STATUS, Z
	goto	SysSelect1Case3
;	ENC28J60_Select
	bcf	LATB,2
;FastHWSPITransfer(BFSCMD | ECON1, temp)
	movlw	159
	banksel	SPITXDATA
	movwf	SPITXDATA
	banksel	STATUS
	pagesel	FASTHWSPITRANSFER
	call	FASTHWSPITRANSFER
	pagesel	$
;FastHWSPITransfer(b'00000010' , temp)
	movlw	2
	banksel	SPITXDATA
	movwf	SPITXDATA
	banksel	STATUS
	pagesel	FASTHWSPITRANSFER
	call	FASTHWSPITRANSFER
	pagesel	$
;ENC28J60_Deselect
	bsf	LATB,2
;case 3
	goto	SysSelectEnd1
SysSelect1Case3
	movlw	3
	subwf	BANKTOBESELECTED,W
	btfss	STATUS, Z
	goto	SysSelect1Case4
;	ENC28J60_Select
	bcf	LATB,2
;FastHWSPITransfer(BFSCMD | ECON1, temp)
	movlw	159
	banksel	SPITXDATA
	movwf	SPITXDATA
	banksel	STATUS
	pagesel	FASTHWSPITRANSFER
	call	FASTHWSPITRANSFER
	pagesel	$
;FastHWSPITransfer(b'00000011' , temp)
	movlw	3
	banksel	SPITXDATA
	movwf	SPITXDATA
	banksel	STATUS
	pagesel	FASTHWSPITRANSFER
	call	FASTHWSPITRANSFER
	pagesel	$
;ENC28J60_Deselect
	bsf	LATB,2
;End Select
SysSelect1Case4
SysSelectEnd1
;lastselectedBank = banktobeselected
	movf	BANKTOBESELECTED,W
	movwf	LASTSELECTEDBANK
	return

;********************************************************************************

ENC28J60_SETST_MAC
;For II = 1 To 6
	clrf	II
SysForLoop13
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
	goto	SysForLoop13
SysForLoopEnd13
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

FN_FNLSR
;dim SysLongTempB as long
;SysLongTempB  = BitsIn
;Repeat NumBits
	movf	NUMBITS,W
	banksel	SYSREPEATTEMP4
	movwf	SysRepeatTemp4
	btfsc	STATUS,Z
	goto	SysRepeatLoopEnd4
SysRepeatLoop4
;Set C Off
	bcf	STATUS,C
;Rotate SysLongTempB Right
	rrf	SYSLONGTEMPB_E,F
	rrf	SYSLONGTEMPB_U,F
	rrf	SYSLONGTEMPB_H,F
	rrf	SYSLONGTEMPB,F
;End Repeat
	decfsz	SysRepeatTemp4,F
	goto	SysRepeatLoop4
SysRepeatLoopEnd4
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

GENERAL_PART_CHECKSUM
;dim I_value16, I_x as word
;dim I_chksum32 as long
;I_chksum32 = 0
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
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	high(ETHERBUFFER)
	addwfc	SysTemp2,W
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
	goto	ENDIF72
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
ENDIF72
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
	call	FN_FNLSR
	movf	FNLSR,W
	movwf	I_CHECKSUM16
	movf	FNLSR_H,W
	movwf	I_CHECKSUM16_H
;HSerPrint hex(I_checksum16_h)
;HSerPrint hex(I_checksum16)
;HSerPrintCRLF
;I_checksum16 = I_checksum16 + I_chksum32 ' only 16 lower bits of i_chksum32 is taken...
	movf	I_CHKSUM32,W
	addwf	I_CHECKSUM16,F
	movf	I_CHKSUM32_H,W
	addwfc	I_CHECKSUM16_H,F
;HSerPrint hex(I_checksum16_h)
;HSerPrint hex(I_checksum16)
;HSerPrintCRLF
;I_checksum16 = Not I_checksum16
	comf	I_CHECKSUM16,F
	comf	I_CHECKSUM16_H,F
;HSerPrint hex(I_checksum16_h)
;HSerPrint hex(I_checksum16)
;HSerPrintCRLF
;Val3 = i_checksum16_h
	movf	I_CHECKSUM16_H,W
	banksel	VAL3
	movwf	VAL3
;Val4 = i_checksum16
	banksel	I_CHECKSUM16
	movf	I_CHECKSUM16,W
	banksel	VAL4
	movwf	VAL4
;HSerPrint hex(val3)
;HSerPrint hex(val4)
;HSerPrintCRLF
	banksel	STATUS
	return

;********************************************************************************

;Overloaded signature: BYTE:byte:
HSERPRINT249
;OutValueTemp = 0
	banksel	OUTVALUETEMP
	clrf	OUTVALUETEMP
;IF SerPrintVal >= 100 Then
	movlw	100
	subwf	SERPRINTVAL,W
	btfss	STATUS, C
	goto	ENDIF35
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
ENDIF35
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
	banksel	SYSTEMP2
	movwf	SysTemp2
	banksel	SERPRINTVAL
	movf	SERPRINTVAL,W
	movwf	SysBYTETempA
	movlw	10
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	banksel	SYSTEMP2
	movf	SysTemp2,W
	iorwf	SysByteTempX,W
	movwf	SysTemp1
	btfss	SysTemp1,0
	goto	ENDIF36
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
ENDIF36
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

;Overloaded signature: LONG:byte:
HSERPRINT252
;Dim SysCalcTempA As Long
;Dim SysPrintBuffer(10)
;SysPrintBuffLen = 0
	banksel	SYSPRINTBUFFLEN
	clrf	SYSPRINTBUFFLEN
;Do
SysDoLoop_S3
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
	pagesel	SysDivSub32
	call	SysDivSub32
	pagesel	$
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
	goto	SysDoLoop_S3
SysDoLoop_E3
;For SysPrintTemp = SysPrintBuffLen To 1 Step -1
	banksel	SYSPRINTBUFFLEN
	incf	SYSPRINTBUFFLEN,W
	movwf	SYSPRINTTEMP
	movlw	1
	subwf	SYSPRINTBUFFLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd4
SysForLoop4
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
	goto	SysForLoop4
SysForLoopEnd4
	banksel	STATUS
	return

;********************************************************************************

PINGREPLY
;Dim Packetlength As Word
;ENC28J60_Setst_mac
	call	ENC28J60_SETST_MAC
;Setip_id
	pagesel	SETIP_ID
	call	SETIP_ID
	pagesel	$
;Setst_ip
	call	SETST_IP
;etherBuffer(25) = 0
	banksel	SYSETHERBUFFER_25
	clrf	SYSETHERBUFFER_25
;etherBuffer(26) = 0
	clrf	SYSETHERBUFFER_26
;Calcchecksum(15 , 33 , 25)
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
	pagesel	CALCCHECKSUM
	call	CALCCHECKSUM
	pagesel	$
;etherBuffer(35) = 0
	banksel	SYSETHERBUFFER_35
	clrf	SYSETHERBUFFER_35
;etherBuffer(37) = 0
	clrf	SYSETHERBUFFER_37
;etherBuffer(38) = 0
	clrf	SYSETHERBUFFER_38
;Packetlength = etherBuffer(17) * 256
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
	banksel	PACKETLENGTH
	movwf	PACKETLENGTH
	movf	SysWORDTempX_H,W
	movwf	PACKETLENGTH_H
;Packetlength = Packetlength + etherBuffer(18)
	banksel	SYSETHERBUFFER_18
	movf	SYSETHERBUFFER_18,W
	banksel	PACKETLENGTH
	addwf	PACKETLENGTH,F
	movlw	0
	addwfc	PACKETLENGTH_H,F
;Packetlength = Packetlength + 13                         'We are going to calculate the checksum till the end of packet (IP length + 14 byte of the ethernet stuff), -1 to get word start
	movlw	13
	addwf	PACKETLENGTH,F
	movlw	0
	addwfc	PACKETLENGTH_H,F
;Calcchecksum(35 , Packetlength , 37)
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
	pagesel	CALCCHECKSUM
	call	CALCCHECKSUM
	pagesel	$
;Packetlength = Packetlength + 1
	banksel	PACKETLENGTH
	incf	PACKETLENGTH,F
	btfsc	STATUS,Z
	incf	PACKETLENGTH_H,F
;Enc28j60writebuffer( packetlength )
	movf	PACKETLENGTH,W
	movwf	PCKTLEN
	movf	PACKETLENGTH_H,W
	movwf	PCKTLEN_H
	banksel	STATUS
	call	ENC28J60WRITEBUFFER
;Enc28j60packetsend(packetlength)
	banksel	PACKETLENGTH
	movf	PACKETLENGTH,W
	movwf	PCKTLEN
	movf	PACKETLENGTH_H,W
	movwf	PCKTLEN_H
	banksel	STATUS
	goto	ENC28J60PACKETSEND

;********************************************************************************

SETST_IP
;Dim II As Byte
;For II = 1 To 4
	clrf	II
SysForLoop10
	incf	II,F
;etherBuffer(30 + II) = etherBuffer(26 + II)
	movlw	low(ETHERBUFFER+26)
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(ETHERBUFFER+26)
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
	movlw	low(ETHERBUFFER+30)
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(ETHERBUFFER+30)
	movwf	SysTemp1_H
	banksel	II
	movf	II,W
	banksel	SYSTEMP1
	addwf	SysTemp1,W
	movwf	AFSR0
	movlw	0
	addwfc	SysTemp1_H,W
	movwf	AFSR0_H
	banksel	SYSARRAYTEMP1
	movf	SysArrayTemp1,W
	movwf	INDF0
;Next I
	movlw	4
	banksel	II
	subwf	II,W
	btfss	STATUS, C
	goto	SysForLoop10
SysForLoopEnd10
;etherBuffer(27) = ipaddr(1)
	banksel	SYSIPADDR_1
	movf	SYSIPADDR_1,W
	banksel	SYSETHERBUFFER_27
	movwf	SYSETHERBUFFER_27
;etherBuffer(28) = ipaddr(2)
	banksel	SYSIPADDR_2
	movf	SYSIPADDR_2,W
	banksel	SYSETHERBUFFER_28
	movwf	SYSETHERBUFFER_28
;etherBuffer(29) = ipaddr(3)
	banksel	SYSIPADDR_3
	movf	SYSIPADDR_3,W
	banksel	SYSETHERBUFFER_29
	movwf	SYSETHERBUFFER_29
;etherBuffer(30) = ipaddr(4)
	banksel	SYSIPADDR_4
	movf	SYSIPADDR_4,W
	banksel	SYSETHERBUFFER_30
	movwf	SYSETHERBUFFER_30
	banksel	STATUS
	return

;********************************************************************************

;Overloaded signature: BYTE:BYTE:
SPIMODE204
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
	goto	ENDIF22
;Set SSPSTAT.CKE On
	banksel	SSPSTAT
	bsf	SSPSTAT,CKE
;End If
ENDIF22
;Set SSPCON1.CKP Off
	banksel	SSPCON1
	bcf	SSPCON1,CKP
;If SPIClockMode.1 = On Then
	banksel	SPICLOCKMODE
	btfss	SPICLOCKMODE,1
	goto	ENDIF23
;Set SSPCON1.CKP On
	banksel	SSPCON1
	bsf	SSPCON1,CKP
;End If
ENDIF23
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
	goto	ENDIF78
;SysWordTempA = 0
	clrf	SYSWORDTEMPA
	clrf	SYSWORDTEMPA_H
;exit sub
	return
;end if
ENDIF78
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
	goto	ENDIF79
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	addwfc	SYSDIVMULTX_H,F
;End If
ENDIF79
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

ENC28J60POLL
;ENC28J60_selectBank ( 0x20, epktcnt )
;Enc28j60_data = ENC28J60_ReadReg( erevid )
	movlw	114
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;cnt = ENC28J60_ReadReg( epktcnt )
	movlw	57
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	CNT
;If cnt > 0 Then
	sublw	0
	btfsc	STATUS, C
	goto	ENDIF20
;Enc28j60packetreceive(etherBufferSize)
	movlw	128
	movwf	MAXLEN
	clrf	MAXLEN_H
	pagesel	ENC28J60PACKETRECEIVE
	call	ENC28J60PACKETRECEIVE
	pagesel	$
;End If
ENDIF20
	return

;********************************************************************************

ENC28J60_BITCLEAR
;banktobeselected = ( addr & BANK_MASK) / 32
	movlw	96
	andwf	ADDR,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movwf	SysBYTETempA
	movlw	32
	movwf	SysBYTETempB
	banksel	STATUS
	call	SysDivSub
	movf	SysBYTETempA,W
	movwf	BANKTOBESELECTED
;if lastselectedBank <> banktobeselected then
	subwf	LASTSELECTEDBANK,W
	btfsc	STATUS, Z
	goto	ELSE15_1
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
	goto	ENDIF16
;ENC28J60_selectBank ( banktobeselected, addr )
	pagesel	ENC28J60_SELECTBANK
	call	ENC28J60_SELECTBANK
	pagesel	$
;end if
ENDIF16
;Else
	goto	ENDIF15
ELSE15_1
;lastselectedBank = banktobeselected
	movf	BANKTOBESELECTED,W
	movwf	LASTSELECTEDBANK
;end if
ENDIF15
;ENC28J60_Select
	bcf	LATB,2
;FastHWSPITransfer( ENC28J60_BIT_FIELD_CLR | (addr AND ADDR_MASK ), temp )
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
;ENC28J60_Deselect
	bsf	LATB,2
	return

;********************************************************************************

ENC28J60_BITSET
;banktobeselected = ( addr & BANK_MASK) / 32
	movlw	96
	andwf	ADDR,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movwf	SysBYTETempA
	movlw	32
	movwf	SysBYTETempB
	banksel	STATUS
	call	SysDivSub
	movf	SysBYTETempA,W
	movwf	BANKTOBESELECTED
;if lastselectedBank <> banktobeselected then
	subwf	LASTSELECTEDBANK,W
	btfsc	STATUS, Z
	goto	ELSE13_1
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
	goto	ENDIF14
;ENC28J60_selectBank ( banktobeselected, addr )
	pagesel	ENC28J60_SELECTBANK
	call	ENC28J60_SELECTBANK
	pagesel	$
;end if
ENDIF14
;Else
	goto	ENDIF13
ELSE13_1
;lastselectedBank = banktobeselected
	movf	BANKTOBESELECTED,W
	movwf	LASTSELECTEDBANK
;end if
ENDIF13
;ENC28J60_Select
	bcf	LATB,2
;FastHWSPITransfer( ENC28J60_BIT_FIELD_SET | (addr AND ADDR_MASK ), temp )
	movlw	31
	andwf	ADDR,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	128
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
;ENC28J60_Deselect
	bsf	LATB,2
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
;T_ip_hdr_cksum = 0x00
	banksel	T_IP_HDR_CKSUM
	clrf	T_IP_HDR_CKSUM
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
	movwf	SysBYTETempA
	movlw	4
	movwf	SysBYTETempB
	call	SysMultSub
	movf	SysBYTETempX,W
	movwf	IP_HEADER_LENGTH
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
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	1
	subwf	SysTemp2,W
	movwf	VAL2
	clrf	VAL2_H
	btfss	STATUS,C
	decf	VAL2_H,F
;T_ip_hdr_cksum0 = 0
	banksel	SYSETHERBUFFER_25
	clrf	SYSETHERBUFFER_25
;T_ip_hdr_cksum1 = 0
	clrf	SYSETHERBUFFER_26
;General_part_checksum(val1 , Val2)
	banksel	STATUS
	pagesel	GENERAL_PART_CHECKSUM
	call	GENERAL_PART_CHECKSUM
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
;ENC28J60_Setst_mac
	banksel	STATUS
	pagesel	ENC28J60_SETST_MAC
	call	ENC28J60_SETST_MAC
	pagesel	$
;ENC28J60_Ip_header_checksum
	call	ENC28J60_IP_HEADER_CHECKSUM
;Calcchecksum(15 , 33 , 25)
	return

;********************************************************************************

ENC28J60_WRITEPHYREG
;		while ((ENC28J60_ReadReg(MISTAT) & MISTAT_BUSY ) = MISTAT_BUSY )
SysDoLoop_S2
	movlw	234
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
;ENC28J60_writeReg( MIREGADR, PhyRegaddr )
	movlw	212
	movwf	ADDR
	banksel	PHYREGADDR
	movf	PHYREGADDR,W
	banksel	ENC_OUTBYTE
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;temp = ENC28J60_ReadReg( MIREGADR )
;ENC28J60_writeReg( MIWRL, ENC_Outbyte1 )
	movlw	214
	movwf	ADDR
	movf	ENC_OUTBYTE1,W
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg( MIWRH, ENC_Outbyte2 )
	movlw	215
	movwf	ADDR
	movf	ENC_OUTBYTE2,W
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;wait while ( (ENC28J60_ReadReg( MISTAT ) & MISTAT_BUSY ) = MISTAT_BUSY )
SysWaitLoop3
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
	goto	SysWaitLoop3
	return

;********************************************************************************

ENC28J60_WRITEREG
;banktobeselected = ( addr & BANK_MASK) / 32
	movlw	96
	andwf	ADDR,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movwf	SysBYTETempA
	movlw	32
	movwf	SysBYTETempB
	banksel	STATUS
	call	SysDivSub
	movf	SysBYTETempA,W
	movwf	BANKTOBESELECTED
;if lastselectedBank <> banktobeselected then
	subwf	LASTSELECTEDBANK,W
	btfsc	STATUS, Z
	goto	ELSE9_1
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
	goto	ENDIF10
;ENC28J60_selectBank ( banktobeselected, addr )
	pagesel	ENC28J60_SELECTBANK
	call	ENC28J60_SELECTBANK
	pagesel	$
;end if
ENDIF10
;Else
	goto	ENDIF9
ELSE9_1
;lastselectedBank = banktobeselected
	movf	BANKTOBESELECTED,W
	movwf	LASTSELECTEDBANK
;end if
ENDIF9
;ENC28J60_Select
	bcf	LATB,2
;FastHWSPITransfer( ENC28J60_WRITE_CTRL_REG | (addr AND ADDR_MASK ), temp )
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
;ENC28J60_Deselect
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
SysWaitLoop10
	btfss	SSPSTAT,BF
	goto	SysWaitLoop10
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
	movf	NUMBITS,W
	banksel	SYSREPEATTEMP5
	movwf	SysRepeatTemp5
	btfsc	STATUS,Z
	goto	SysRepeatLoopEnd5
SysRepeatLoop5
;Set C Off
	bcf	STATUS,C
;Rotate SysLongTempB Left
	rlf	SYSLONGTEMPB,F
	rlf	SYSLONGTEMPB_H,F
	rlf	SYSLONGTEMPB_U,F
	rlf	SYSLONGTEMPB_E,F
;End Repeat
	decfsz	SysRepeatTemp5,F
	goto	SysRepeatLoop5
SysRepeatLoopEnd5
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

FN_FNNOTBIT
;If BitIn then
	movf	BITIN,F
	btfsc	STATUS,Z
	goto	ELSE21_1
;FnNOTBit = 0
	bcf	FNNOTBIT
;Else
	goto	ENDIF21
ELSE21_1
;FnNOTBit = 1
	bsf	FNNOTBIT
;End If
ENDIF21
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
	movwf	SYSSTRINGTEMP
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	sublw	9
	btfsc	STATUS, C
	goto	ENDIF28
	movlw	7
	addwf	SYSSTRINGTEMP,F
ENDIF28
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
	rrf	SYSVALTEMP,F
;Next
	movlw	4
	subwf	SYSSTRINGTEMP,W
	btfss	STATUS, C
	goto	SysForLoop2
SysForLoopEnd2
;SysStringTemp = SysValTemp And 0x0F
	movlw	15
	andwf	SYSVALTEMP,W
	movwf	SYSSTRINGTEMP
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	sublw	9
	btfsc	STATUS, C
	goto	ENDIF30
	movlw	7
	addwf	SYSSTRINGTEMP,F
ENDIF30
;Hex(1) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W
	banksel	SYSHEX_1
	movwf	SYSHEX_1
	banksel	STATUS
	return

;********************************************************************************

;Overloaded signature: STRING:byte:
HSERPRINT248
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
	goto	ENDIF32
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
ENDIF32
	banksel	STATUS
	return

;********************************************************************************

HSERPRINTCRLF
;repeat HSerPrintCRLFCount
	movf	HSERPRINTCRLFCOUNT,W
	banksel	SYSREPEATTEMP3
	movwf	SysRepeatTemp3
	btfsc	STATUS,Z
	goto	SysRepeatLoopEnd3
SysRepeatLoop3
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
	banksel	SYSREPEATTEMP3
	decfsz	SysRepeatTemp3,F
	goto	SysRepeatLoop3
SysRepeatLoopEnd3
	banksel	STATUS
	return

;********************************************************************************

HSERSEND
;if comport = 1 Then
	decf	COMPORT,W
	btfss	STATUS, Z
	goto	ENDIF31
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
ENDIF31
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

SETIP_ID
;etherBuffer(19) = ip_id_h
	movf	IP_ID_H,W
	banksel	SYSETHERBUFFER_19
	movwf	SYSETHERBUFFER_19
;etherBuffer(20) = [byte]ip_id
	banksel	IP_ID
	movf	IP_ID,W
	banksel	SYSETHERBUFFER_20
	movwf	SYSETHERBUFFER_20
;Ip_id = Ip_id + 1
	banksel	IP_ID
	incf	IP_ID,F
	btfsc	STATUS,Z
	incf	IP_ID_H,F
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

SYSMULTSUB
;dim SysByteTempA as byte
;dim SysByteTempB as byte
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
MUL8LOOP
;movf SysByteTempA, W
	movf	SYSBYTETEMPA, W
;btfsc SysByteTempB, 0
	btfsc	SYSBYTETEMPB, 0
;addwf SysByteTempX, F
	addwf	SYSBYTETEMPX, F
;bcf STATUS, C
	bcf	STATUS, C
;rrf SysByteTempB, F
	rrf	SYSBYTETEMPB, F
;bcf STATUS, C
	bcf	STATUS, C
;rlf SysByteTempA, F
	rlf	SYSBYTETEMPA, F
;movf SysByteTempB, F
	movf	SYSBYTETEMPB, F
;btfss STATUS, Z
	btfss	STATUS, Z
;goto MUL8LOOP
	goto	MUL8LOOP
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
	goto	ENDIF76
	movf	SYSDIVMULTA,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTA_H,W
	addwfc	SYSDIVMULTX_H,F
ENDIF76
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
