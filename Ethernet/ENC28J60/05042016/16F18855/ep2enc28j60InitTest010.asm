;Program compiled by Great Cow BASIC (0.95 2016-03-13)
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
SYSCALCTEMPA	EQU	117
SYSCALCTEMPX	EQU	112
SYSCALCTEMPX_H	EQU	113
SYSDIVMULTA	EQU	119
SYSDIVMULTA_H	EQU	120
SYSDIVMULTB	EQU	123
SYSDIVMULTB_H	EQU	124
SYSDIVMULTX	EQU	114
SYSDIVMULTX_H	EQU	115
SysBYTETempA	EQU	117
SysBYTETempB	EQU	121
SysBYTETempX	EQU	112
SysDivLoop	EQU	116
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
BYTETOBIN	EQU	9019
MACADDR	EQU	9012
STR	EQU	9006
IPADDR	EQU	9001
IPROUTER	EQU	8996
IPSERVER	EQU	8991
HEX	EQU	8987
ADDR	EQU	32
BANKTOBESELECTED	EQU	33
BITIN	EQU	34
BYTENUM	EQU	35
CNT	EQU	36
COMPORT	EQU	37
DEBUG	EQU	38
ENC28J60_DATA	EQU	39
ENC28J60_DATAH	EQU	40
ENC28J60_DATAL	EQU	41
ENC28J60_READREG	EQU	42
ENC28J60_TEMP	EQU	43
ENC_LAST_TXBUF	EQU	44
ENC_LAST_TXBUF_H	EQU	45
ENC_OUTBYTE	EQU	46
ENC_OUTBYTE1	EQU	47
ENC_OUTBYTE2	EQU	48
ETHERGETLENGTH	EQU	49
ETHERGETLENGTH_H	EQU	50
ETH_COUNTER	EQU	51
ETH_COUNTER_H	EQU	52
ETH_FRAMELENGTH	EQU	53
ETH_FRAMELENGTH_H	EQU	54
FNNOTBIT	EQU	56
HSERPRINTCRLFCOUNT	EQU	57
IPPORT	EQU	58
LASTSELECTEDBANK	EQU	59
MACON2	EQU	60
MAPHSUP	EQU	61
MAXLEN	EQU	62
MAXLEN_H	EQU	63
NEXTPACKETPTR	EQU	64
NEXTPACKETPTR_H	EQU	65
OUTVALUETEMP	EQU	67
PCKTLEN	EQU	68
PCKTLEN_H	EQU	69
PHYREGADDR	EQU	71
PREVIOUS_NEXTPACKETPTR	EQU	72
PREVIOUS_NEXTPACKETPTR_H	EQU	73
PRINTLEN	EQU	74
RXSTAT	EQU	75
RXSTAT_H	EQU	76
SERDATA	EQU	77
SERPRINTVAL	EQU	78
SERPRINTVAL_H	EQU	79
SPICLOCKMODE	EQU	80
SPICURRENTMODE	EQU	81
SPIRXDATA	EQU	82
SPITXDATA	EQU	83
SYSBITVAR0	EQU	84
SYSCHARCOUNT	EQU	85
SYSPRINTTEMP	EQU	86
SYSSTRDATA	EQU	87
SYSSTRINGTEMP	EQU	88
SYSVALTEMP	EQU	89
SYSVALTEMP_H	EQU	90
StringPointer	EQU	91
SysMACADDRHandler	EQU	92
SysMACADDRHandler_H	EQU	93
SysPRINTDATAHandler	EQU	94
SysPRINTDATAHandler_H	EQU	95
SysRepeatTemp1	EQU	96
SysRepeatTemp2	EQU	97
SysTemp1	EQU	98
SysTemp1_H	EQU	99
SysTemp2	EQU	100
TEMP	EQU	101
TT	EQU	102

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
SYSETHERBUFFER_5	EQU	1442
SYSETHERBUFFER_6	EQU	1443
SYSETHERBUFFER_7	EQU	1444
SYSETHERBUFFER_8	EQU	1445
SYSETHERBUFFER_9	EQU	1446
SYSHEX_0	EQU	1259
SYSHEX_1	EQU	1260
SYSHEX_2	EQU	1261
SYSIPADDR_1	EQU	1322
SYSIPADDR_2	EQU	1323
SYSIPADDR_3	EQU	1324
SYSIPADDR_4	EQU	1325
SYSIPROUTER_1	EQU	1317
SYSIPROUTER_2	EQU	1318
SYSIPROUTER_3	EQU	1319
SYSIPROUTER_4	EQU	1320
SYSMACADDR_1	EQU	1333
SYSMACADDR_2	EQU	1334
SYSMACADDR_3	EQU	1335
SYSMACADDR_4	EQU	1336
SYSMACADDR_5	EQU	1337
SYSMACADDR_6	EQU	1338
SYSSTR_0	EQU	1326

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
;HSerPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$
;HserPrint "ENC28J60 Ethernet Driver 010" : HSerPrintCRLF
	movlw	low StringTable1
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable1) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
	pagesel	$
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$
;HserPrint "Init Test": HSerPrintCRLF 2
	movlw	low StringTable2
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable2) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
	pagesel	$
	movlw	2
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$
;wait while porta.5 = 1
SysWaitLoop1
	btfsc	PORTA,5
	goto	SysWaitLoop1
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;wait while porta.5 = 0
SysWaitLoop2
	btfss	PORTA,5
	goto	SysWaitLoop2
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
;iprouter = 192,168,0,2
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
	movlw	2
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
	movwf	SysMACADDRHandler
	movlw	high MACADDR
	movwf	SysMACADDRHandler_H
	pagesel	ENC28J60_INIT
	call	ENC28J60_INIT
	pagesel	$
;dir porta.0 out
	bcf	TRISA,0
;dir porta.5 in
	bsf	TRISA,5
;debug = 0
	clrf	DEBUG
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
;Enc28j60_data = ENC28J60_ReadReg( erevid)
	movlw	114
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "#1"
	movlw	low StringTable3
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable3) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
	pagesel	$
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$
;HSerPrint "Rx   : ERXST  ERXND  ERXWRPT ERXRDPT ERXFCON EPKTCNT"
	movlw	low StringTable4
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable4) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable5
	movwf	SysStringA
	movlw	(high StringTable5) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable6
	movwf	SysStringA
	movlw	(high StringTable6) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable6
	movwf	SysStringA
	movlw	(high StringTable6) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable7
	movwf	SysStringA
	movlw	(high StringTable7) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable7
	movwf	SysStringA
	movlw	(high StringTable7) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable8
	movwf	SysStringA
	movlw	(high StringTable8) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
	pagesel	$
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$
;HSerPrint "Write ARP"
	movlw	low StringTable9
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable9) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
	pagesel	$
;HSerPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
;Enc28j60writebufferARP
	pagesel	ENC28J60WRITEBUFFERARP
	call	ENC28J60WRITEBUFFERARP
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg( erevid)
	movlw	114
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "#2"
	movlw	low StringTable10
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable10) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
	pagesel	$
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$
;HSerPrint "Rx   : ERXST  ERXND  ERXWRPT ERXRDPT ERXFCON EPKTCNT"
	movlw	low StringTable4
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable4) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable5
	movwf	SysStringA
	movlw	(high StringTable5) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable6
	movwf	SysStringA
	movlw	(high StringTable6) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable6
	movwf	SysStringA
	movlw	(high StringTable6) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable7
	movwf	SysStringA
	movlw	(high StringTable7) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable7
	movwf	SysStringA
	movlw	(high StringTable7) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable8
	movwf	SysStringA
	movlw	(high StringTable8) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
	pagesel	$
;HSerPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$
;Do forever
SysDoLoop_S1
;if porta.5 = 0 then
;Enc28j60regdump
;eth_read_at ( ENC_TXBUF_ST, 43 )
;debug = 0
;wait while porta.5 = 0
;end if
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

ENC28J60PACKETRECEIVE
;Dim eth_counter, eth_frameLength As Word
;Dim previous_nextpacketptr as word
;ENC28J60_temp = ENC28J60_ReadReg (eir) and EIR_PKTIF
	movlw	28
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movlw	64
	andwf	ENC28J60_READREG,W
	movwf	ENC28J60_TEMP
;If ENC28J60_temp <> EIR_PKTIF Then
	movlw	64
	subwf	ENC28J60_TEMP,W
	btfsc	STATUS, Z
	goto	ENDIF27
;HSerPrint "No packet"
	movlw	low StringTable13
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable13) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
	pagesel	$
;Exit Sub
	return
;End If
ENDIF27
;Enc28j60_data = ENC28J60_ReadReg( erevid)
	movlw	114
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$
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
;HSerPrint "RXWRPT RXRDPT PKTCNT"
	movlw	low StringTable14
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable14) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
	pagesel	$
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$
;do
SysDoLoop_S3
;cnt = ENC28J60_ReadReg(epktcnt)
	movlw	57
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	CNT
;Enc28j60_datal = ENC28J60_ReadReg(erxwrptl)
	movlw	14
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATAL
;Enc28j60_datah = ENC28J60_ReadReg(erxwrpth)
	movlw	15
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATAH
;while cnt <> ENC28J60_ReadReg(epktcnt)
SysDoLoop_S4
	movlw	57
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
;HSerPrint Hex(enc28j60_datah);
	movf	ENC28J60_DATAH,W
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
	pagesel	$
;HSerPrint Hex(enc28j60_datal);
	movf	ENC28J60_DATAL,W
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
	pagesel	$
;HSerPrint "RXRDPT PKTCNT"
;HSerPrintCRLF
;Enc28j60_data = ENC28J60_ReadReg(erxrdpth)
	movlw	13
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "   " + Hex(enc28j60_data);
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable6
	movwf	SysStringA
	movlw	(high StringTable6) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
	pagesel	$
;Enc28j60_data = ENC28J60_ReadReg(epktcnt)
	movlw	57
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movf	ENC28J60_READREG,W
	movwf	ENC28J60_DATA
;HSerPrint "     " + Hex(enc28j60_data);
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable15
	movwf	SysStringA
	movlw	(high StringTable15) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
	pagesel	$
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$
;Setup memory pointers to Read in this RX'd packet.
;ENC28J60_writeReg(ERXRDPTL,  [byte]nextpacketptr )
;ENC28J60_writeReg(ERXRDPTH,  nextpacketptr_h )
;'This resolve Chip Errata 14.  See the Errata datasheet
;if ((nextpacketptr - 1) > ENC_RXBUF_ND )  then
;'Free up memory in that 8kb buffer by adjusting the RX Read pointer,
;'since we are done with the packet.
;ENC28J60_writeReg(ERXRDPTL, ENC_RXBUF_STL)
;ENC28J60_writeReg(ERXRDPTH, ENC_RXBUF_STH) 'RX Pointers (same)
;else
;
;eth_counter_h =  Enc28j60_datah
;eth_counter = [byte]Enc28j60_datal
;if ( eth_counter and 1 ) = 0 then
;eth_counter = eth_counter1
;end if
;ENC28J60_writeReg(ERXRDPTL,  [byte]eth_counter )
;ENC28J60_writeReg(ERXRDPTH,  eth_counter_h )
;
;end if
;Enc28j60readbuffer(6)
	movlw	6
	movwf	ETHERGETLENGTH
	clrf	ETHERGETLENGTH_H
	pagesel	ENC28J60READBUFFER
	call	ENC28J60READBUFFER
	pagesel	$
;for tt = 1 to 6
	clrf	TT
SysForLoop4
	incf	TT,F
;HSerPrint hex(etherbuffer(tt))
	movlw	low(ETHERBUFFER)
	addwf	TT,W
	movwf	AFSR0
	clrf	SysTemp2
	movlw	high(ETHERBUFFER)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
	pagesel	$
;HSerPrint ","
	movlw	low StringTable16
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable16) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
	pagesel	$
;next
	movlw	6
	subwf	TT,W
	btfss	STATUS, C
	goto	SysForLoop4
SysForLoopEnd4
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
;HSerPrint "Len:" : HserPrint Hex( eth_frameLength_h ) : HserPrint Hex( eth_frameLength )
	movlw	low StringTable17
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable17) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
	pagesel	$
	movf	ETH_FRAMELENGTH_H,W
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
	pagesel	$
	movf	ETH_FRAMELENGTH,W
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
	pagesel	$
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
;HSerPrint " - Rxstat:" : HserPrint ByteToBin( RxStat_h ) : HserPrint ByteToBin(RxStat )
	movlw	low StringTable18
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable18) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
	pagesel	$
	movf	RXSTAT_H,W
	movwf	BYTENUM
	pagesel	FN_BYTETOBIN
	call	FN_BYTETOBIN
	pagesel	$
	movlw	low BYTETOBIN
	movwf	SysPRINTDATAHandler
	movlw	high BYTETOBIN
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
	pagesel	$
	movf	RXSTAT,W
	movwf	BYTENUM
	pagesel	FN_BYTETOBIN
	call	FN_BYTETOBIN
	pagesel	$
	movlw	low BYTETOBIN
	movwf	SysPRINTDATAHandler
	movlw	high BYTETOBIN
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
	pagesel	$
;If eth_frameLength > Maxlen Then
;eth_frameLength = Maxlen
;HSerPrint "Length truncated to MaxLen"
;HSerPrintCRLF
;End If
;Enc28j60readbuffer(eth_frameLength)
	movf	ETH_FRAMELENGTH,W
	movwf	ETHERGETLENGTH
	movf	ETH_FRAMELENGTH_H,W
	movwf	ETHERGETLENGTH_H
	pagesel	ENC28J60READBUFFER
	call	ENC28J60READBUFFER
	pagesel	$
ENDPACKET
;IF ( nextpacketptr and 1 ) = 0 THEN
;nextpacketptr--
;END IF
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
;ENC28J60_bitSet( ECON2, ECON2_PKTDEC )
	movlw	30
	movwf	ADDR
	movlw	64
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_BITSET
	goto	ENC28J60_BITSET

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
;wait while ( (ENC28J60_ReadReg( ECON1 ) & ECON1_TXRTS ) = ECON1_TXRTS )
SysWaitLoop15
	movlw	31
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movlw	8
	andwf	ENC28J60_READREG,W
	movwf	SysTemp1
	movwf	SysBYTETempA
	movlw	8
	movwf	SysBYTETempB
	pagesel	SysCompEqual
	call	SysCompEqual
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysWaitLoop15
;ENC28J60_writeReg(etxndl , (ENC_TXBUF_STL + pcktlen ) & 0xFF )
	movlw	6
	movwf	ADDR
	movlw	112
	addwf	PCKTLEN,W
	movwf	SysTemp1
	movlw	0
	addwfc	PCKTLEN_H,W
	movwf	SysTemp1_H
	movf	SysTemp1,W
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(etxndh , ENC_TXBUF_STH + pcktlen_h )
	movlw	7
	movwf	ADDR
	movlw	22
	addwf	PCKTLEN_H,W
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;if debug = 1 then
	decf	DEBUG,W
	btfss	STATUS, Z
	goto	ENDIF26
;Enc28j60regdump
	pagesel	ENC28J60REGDUMP
	call	ENC28J60REGDUMP
	pagesel	$
;end if
ENDIF26
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
SysWaitLoop16
	movlw	31
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movlw	8
	andwf	ENC28J60_READREG,W
	movwf	SysTemp1
	movwf	SysBYTETempA
	movlw	8
	movwf	SysBYTETempB
	pagesel	SysCompEqual
	call	SysCompEqual
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysWaitLoop16
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

SysStringTables
	movf	SysStringA_H,W
	movwf	PCLATH
	movf	SysStringA,W
	incf	SysStringA,F
	btfsc	STATUS,Z
	incf	SysStringA_H,F
	movwf	PCL

StringTable1
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
	retlw	48	;0


StringTable2
	retlw	9
	retlw	73	;I
	retlw	110	;n
	retlw	105	;i
	retlw	116	;t
	retlw	32	; 
	retlw	84	;T
	retlw	101	;e
	retlw	115	;s
	retlw	116	;t


StringTable3
	retlw	2
	retlw	35	;#
	retlw	49	;1


StringTable4
	retlw	52
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


StringTable5
	retlw	7
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 


StringTable6
	retlw	3
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 


StringTable7
	retlw	4
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 


StringTable8
	retlw	6
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 


StringTable9
	retlw	9
	retlw	87	;W
	retlw	114	;r
	retlw	105	;i
	retlw	116	;t
	retlw	101	;e
	retlw	32	; 
	retlw	65	;A
	retlw	82	;R
	retlw	80	;P


StringTable10
	retlw	2
	retlw	35	;#
	retlw	50	;2


StringTable11
	retlw	4
	retlw	32	; 
	retlw	82	;R
	retlw	100	;d
	retlw	58	;:


StringTable12
	retlw	2
	retlw	32	; 
	retlw	45	;-


StringTable13
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


StringTable14
	retlw	20
	retlw	82	;R
	retlw	88	;X
	retlw	87	;W
	retlw	82	;R
	retlw	80	;P
	retlw	84	;T
	retlw	32	; 
	retlw	82	;R
	retlw	88	;X
	retlw	82	;R
	retlw	68	;D
	retlw	80	;P
	retlw	84	;T
	retlw	32	; 
	retlw	80	;P
	retlw	75	;K
	retlw	84	;T
	retlw	67	;C
	retlw	78	;N
	retlw	84	;T


StringTable15
	retlw	5
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 


StringTable16
	retlw	1
	retlw	44	;,


StringTable17
	retlw	4
	retlw	76	;L
	retlw	101	;e
	retlw	110	;n
	retlw	58	;:


StringTable18
	retlw	10
	retlw	32	; 
	retlw	45	;-
	retlw	32	; 
	retlw	82	;R
	retlw	120	;x
	retlw	115	;s
	retlw	116	;t
	retlw	97	;a
	retlw	116	;t
	retlw	58	;:


StringTable29
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


StringTable30
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


StringTable31
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


StringTable32
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


StringTable33
	retlw	1
	retlw	46	;.


StringTable34
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


StringTable35
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


StringTable61
	retlw	0


StringTable62
	retlw	1
	retlw	49	;1


StringTable63
	retlw	1
	retlw	48	;0


;********************************************************************************

;Start of program memory page 1
	ORG	2048
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
	movlw	low StringTable29
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable29) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	clrf	SYSVALTEMP_H
	pagesel	FN_STR
	call	FN_STR
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable30
	movwf	SysStringA
	movlw	(high StringTable30) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movlw	low StringTable31
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable31) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable5
	movwf	SysStringA
	movlw	(high StringTable5) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable7
	movwf	SysStringA
	movlw	(high StringTable7) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable7
	movwf	SysStringA
	movlw	(high StringTable7) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
	pagesel	$
;ENC28J60_ReadReg (eir)
	movlw	28
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
;HSerPrint "     " + Hex(enc28j60_data);
	movf	ENC28J60_DATA,W
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable15
	movwf	SysStringA
	movlw	(high StringTable15) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable6
	movwf	SysStringA
	movlw	(high StringTable6) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movlw	low StringTable32
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable32) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable5
	movwf	SysStringA
	movlw	(high StringTable5) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable8
	movwf	SysStringA
	movlw	(high StringTable8) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable8
	movwf	SysStringA
	movlw	(high StringTable8) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable8
	movwf	SysStringA
	movlw	(high StringTable8) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable8
	movwf	SysStringA
	movlw	(high StringTable8) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable33
	movwf	SysStringA
	movlw	(high StringTable33) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable33
	movwf	SysStringA
	movlw	(high StringTable33) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable33
	movwf	SysStringA
	movlw	(high StringTable33) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable33
	movwf	SysStringA
	movlw	(high StringTable33) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable33
	movwf	SysStringA
	movlw	(high StringTable33) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movlw	low StringTable34
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable34) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable5
	movwf	SysStringA
	movlw	(high StringTable5) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable6
	movwf	SysStringA
	movlw	(high StringTable6) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable6
	movwf	SysStringA
	movlw	(high StringTable6) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable7
	movwf	SysStringA
	movlw	(high StringTable7) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable7
	movwf	SysStringA
	movlw	(high StringTable7) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable8
	movwf	SysStringA
	movlw	(high StringTable8) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable8
	movwf	SysStringA
	movlw	(high StringTable8) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movlw	low StringTable35
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable35) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable5
	movwf	SysStringA
	movlw	(high StringTable5) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable6
	movwf	SysStringA
	movlw	(high StringTable6) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable6
	movwf	SysStringA
	movlw	(high StringTable6) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable6
	movwf	SysStringA
	movlw	(high StringTable6) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable5
	movwf	SysStringA
	movlw	(high StringTable5) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
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
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable5
	movwf	SysStringA
	movlw	(high StringTable5) & 127
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
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT238
	call	HSERPRINT238
	pagesel	$
;HSerPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	goto	HSERPRINTCRLF

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
SysWaitLoop9
	btfss	SSP1STAT,BF
	goto	SysWaitLoop9
;temp = SSPBUF
	movf	SSPBUF,W
	banksel	TEMP
	movwf	TEMP
;SSPBUF = 0x0E
	movlw	14
	banksel	SSPBUF
	movwf	SSPBUF
;Wait While BF = Off
SysWaitLoop10
	btfss	SSP1STAT,BF
	goto	SysWaitLoop10
;temp = SSPBUF
	movf	SSPBUF,W
	banksel	TEMP
	movwf	TEMP
;for eth_counter = 1 to pcktlen
	clrf	ETH_COUNTER
	clrf	ETH_COUNTER_H
	movlw	1
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	movf	PCKTLEN,W
	movwf	SysWORDTempA
	movf	PCKTLEN_H,W
	movwf	SysWORDTempA_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd1
SysForLoop1
	incf	ETH_COUNTER,F
	btfsc	STATUS,Z
	incf	ETH_COUNTER_H,F
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
SysWaitLoop11
	btfss	SSP1STAT,BF
	goto	SysWaitLoop11
;temp = SSPBUF
	movf	SSPBUF,W
	banksel	TEMP
	movwf	TEMP
;next
	movf	ETH_COUNTER,W
	movwf	SysWORDTempA
	movf	ETH_COUNTER_H,W
	movwf	SysWORDTempA_H
	movf	PCKTLEN,W
	movwf	SysWORDTempB
	movf	PCKTLEN_H,W
	movwf	SysWORDTempB_H
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
;SPIMode MasterSlow, 0
	movlw	11
	movwf	SPICURRENTMODE
	clrf	SPICLOCKMODE
	pagesel	SPIMODE194
	call	SPIMODE194
	pagesel	$
;ENC28J60_Reset_CMD
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
;FastHWSPITransfer( ENC28J60_SOFT_RESET, temp )
	movlw	255
	movwf	SPITXDATA
	pagesel	FASTHWSPITRANSFER
	call	FASTHWSPITRANSFER
	pagesel	$
;lastselectedBank = 99
	movlw	99
	movwf	LASTSELECTEDBANK
;wait while ( (ENC28J60_ReadReg( ESTAT ) & ESTAT_CLKRDY ) <> ESTAT_CLKRDY)
SysWaitLoop3
	movlw	29
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movlw	1
	andwf	ENC28J60_READREG,W
	movwf	SysTemp1
	movwf	SysBYTETempA
	movlw	1
	movwf	SysBYTETempB
	pagesel	SysCompEqual
	call	SysCompEqual
	pagesel	$
	comf	SysByteTempX,F
	btfsc	SysByteTempX,0
	goto	SysWaitLoop3
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
SysWaitLoop4
	movlw	29
	movwf	ADDR
	pagesel	FN_ENC28J60_READREG
	call	FN_ENC28J60_READREG
	pagesel	$
	movlw	1
	andwf	ENC28J60_READREG,W
	movwf	SysTemp1
	movwf	SysBYTETempA
	movlw	1
	movwf	SysBYTETempB
	pagesel	SysCompEqual
	call	SysCompEqual
	pagesel	$
	comf	SysByteTempX,F
	btfsc	SysByteTempX,0
	goto	SysWaitLoop4
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
	movlw	194
	movwf	ADDR
	movlw	177
	movwf	ENC_OUTBYTE
	pagesel	ENC28J60_WRITEREG
	call	ENC28J60_WRITEREG
	pagesel	$
;ENC28J60_writeReg(MACON3, 0x30)  'Auto Pad to 60 bytes + CRC + Half Duplex
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
;ENC28J60_writeReg(MAMXFLH, 0x5)  'Maximum frame length
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
	clrf	PHYREGADDR
	clrf	ENC_OUTBYTE1
	clrf	ENC_OUTBYTE2
	pagesel	ENC28J60_WRITEPHYREG
	call	ENC28J60_WRITEPHYREG
	pagesel	$
;ENC28J60_writePhyReg(PHCON2, 0x00, 0x00)
	movlw	16
	movwf	PHYREGADDR
	clrf	ENC_OUTBYTE1
	clrf	ENC_OUTBYTE2
	pagesel	ENC28J60_WRITEPHYREG
	call	ENC28J60_WRITEPHYREG
	pagesel	$
;ENC28J60_writePhyReg(PHLCON, B'00000100', B'01110110')
	movlw	20
	movwf	PHYREGADDR
	movlw	4
	movwf	ENC_OUTBYTE1
	movlw	118
	movwf	ENC_OUTBYTE2
	pagesel	ENC28J60_WRITEPHYREG
	call	ENC28J60_WRITEPHYREG
	pagesel	$
;ENC28J60_writePhyReg(PHIE, 0x00, 0x00)  'Disable interrupts
	movlw	18
	movwf	PHYREGADDR
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
	movwf	PHYREGADDR
	movlw	118
	movwf	ENC_OUTBYTE1
	movlw	4
	movwf	ENC_OUTBYTE2
	pagesel	ENC28J60_WRITEPHYREG
	goto	ENC28J60_WRITEPHYREG

;********************************************************************************

;Start of program memory page 2
	ORG	4096
FN_BYTETOBIN
;ByteToBin = ""
	movlw	low BYTETOBIN
	movwf	FSR1L
	movlw	high BYTETOBIN
	movwf	FSR1H
	movlw	low StringTable61
	movwf	SysStringA
	movlw	(high StringTable61) & 127
	movwf	SysStringA_H
	call	SysReadString
;Repeat 8
	movlw	8
	movwf	SysRepeatTemp2
SysRepeatLoop2
;If ByteNum.7 = 1 Then
	btfss	BYTENUM,7
	goto	ELSE33_1
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
	movlw	low StringTable62
	movwf	SysStringA
	movlw	(high StringTable62) & 127
	movwf	SysStringA_H
	call	SysReadStringPart
	movlw	low BYTETOBIN
	movwf	FSR0L
	movlw	high BYTETOBIN
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
;Else
	goto	ENDIF33
ELSE33_1
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
	movlw	low StringTable63
	movwf	SysStringA
	movlw	(high StringTable63) & 127
	movwf	SysStringA_H
	call	SysReadStringPart
	movlw	low BYTETOBIN
	movwf	FSR0L
	movlw	high BYTETOBIN
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
;End If
ENDIF33
;Rotate ByteNum Left
	rlf	BYTENUM,F
;End Repeat
	decfsz	SysRepeatTemp2,F
	goto	SysRepeatLoop2
SysRepeatLoopEnd2
	return

;********************************************************************************

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
;If ENC28J60_ReadReg(epktcnt) > 0 Then
	movlw	57
	movwf	ADDR
	call	FN_ENC28J60_READREG
	movf	ENC28J60_READREG,W
	sublw	0
	btfsc	STATUS, C
	goto	ENDIF15
;Enc28j60packetreceive(64)
	movlw	64
	movwf	MAXLEN
	clrf	MAXLEN_H
	pagesel	ENC28J60PACKETRECEIVE
	call	ENC28J60PACKETRECEIVE
	pagesel	$
;End If
ENDIF15
	return

;********************************************************************************

ENC28J60READBUFFER
;dim eth_counter as Word
;ENC28J60_Select
	bcf	LATB,2
;Set WCOL Off
	banksel	SSP1CON1
	bcf	SSP1CON1,WCOL
;SSPBUF = ENC28J60_READ_BUF_MEM
	movlw	58
	movwf	SSPBUF
;Wait While BF = Off
SysWaitLoop17
	btfss	SSP1STAT,BF
	goto	SysWaitLoop17
;temp = SSPBUF
	movf	SSPBUF,W
	banksel	TEMP
	movwf	TEMP
;if etherGetLength < 65 then
	movf	ETHERGETLENGTH,W
	movwf	SysWORDTempA
	movf	ETHERGETLENGTH_H,W
	movwf	SysWORDTempA_H
	movlw	65
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0
	goto	ENDIF34
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
	call	SysCompLessThan16
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd5
SysForLoop5
	incf	ETH_COUNTER,F
	btfsc	STATUS,Z
	incf	ETH_COUNTER_H,F
;SSPBUF = 0
	banksel	SSPBUF
	clrf	SSPBUF
;Wait While BF = Off
SysWaitLoop18
	btfss	SSP1STAT,BF
	goto	SysWaitLoop18
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
	call	SysCompLessThan16
	btfsc	SysByteTempX,0
	goto	SysForLoop5
SysForLoopEnd5
;End if
ENDIF34
;if etherGetLength > 64 then
	movf	ETHERGETLENGTH,W
	movwf	SysWORDTempB
	movf	ETHERGETLENGTH_H,W
	movwf	SysWORDTempB_H
	movlw	64
	movwf	SysWORDTempA
	clrf	SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0
	goto	ENDIF35
;for eth_counter = 65 to etherGetLength
	movlw	64
	movwf	ETH_COUNTER
	clrf	ETH_COUNTER_H
	movlw	65
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	movf	ETHERGETLENGTH,W
	movwf	SysWORDTempA
	movf	ETHERGETLENGTH_H,W
	movwf	SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd6
SysForLoop6
	incf	ETH_COUNTER,F
	btfsc	STATUS,Z
	incf	ETH_COUNTER_H,F
;SSPBUF = 0
	banksel	SSPBUF
	clrf	SSPBUF
;Wait While BF = Off
SysWaitLoop19
	btfss	SSP1STAT,BF
	goto	SysWaitLoop19
;temp = SSPBUF
	movf	SSPBUF,W
	banksel	TEMP
	movwf	TEMP
;next
	movf	ETH_COUNTER,W
	movwf	SysWORDTempA
	movf	ETH_COUNTER_H,W
	movwf	SysWORDTempA_H
	movf	ETHERGETLENGTH,W
	movwf	SysWORDTempB
	movf	ETHERGETLENGTH_H,W
	movwf	SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0
	goto	SysForLoop6
SysForLoopEnd6
;End if
ENDIF35
;HSerPrint " Rd:"
	movlw	low StringTable11
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable11) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT238
;HSerPrint eth_counter
	movf	ETH_COUNTER,W
	movwf	SERPRINTVAL
	movf	ETH_COUNTER_H,W
	movwf	SERPRINTVAL_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT240
;HSerPrint " -"
	movlw	low StringTable12
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable12) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT238
;ENC28J60_Deselect
	bsf	LATB,2
	return

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
;etherbuffer(8) = macaddr(2)
	banksel	SYSMACADDR_2
	movf	SYSMACADDR_2,W
	banksel	SYSETHERBUFFER_8
	movwf	SYSETHERBUFFER_8
;etherbuffer(9) = macaddr(3)
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
	pagesel	ENC28J60WRITEBUFFER
	call	ENC28J60WRITEBUFFER
	pagesel	$
;Enc28j60packetsend( 60 )
	movlw	60
	movwf	PCKTLEN
	clrf	PCKTLEN_H
	pagesel	ENC28J60PACKETSEND
	goto	ENC28J60PACKETSEND

;********************************************************************************

ENC28J60_BITCLEAR
;banktobeselected = ( addr & BANK_MASK) / 32
	movlw	96
	andwf	ADDR,W
	movwf	SysTemp1
	movwf	SysBYTETempA
	movlw	32
	movwf	SysBYTETempB
	call	SysDivSub
	movf	SysBYTETempA,W
	movwf	BANKTOBESELECTED
;if lastselectedBank <> banktobeselected then
	subwf	LASTSELECTEDBANK,W
	btfsc	STATUS, Z
	goto	ELSE11_1
;if ( ( addr & ADDR_MASK )  <= EIE  ) then
	movlw	31
	andwf	ADDR,W
	movwf	SysTemp1
	movwf	SysBYTETempB
	movlw	27
	movwf	SysBYTETempA
	call	SysCompLessThan
	comf	SysByteTempX,F
	btfsc	SysByteTempX,0
;ENC28J60_selectBank ( banktobeselected, addr )
	call	ENC28J60_SELECTBANK
;end if
;Else
	goto	ENDIF11
ELSE11_1
;lastselectedBank = banktobeselected
	movf	BANKTOBESELECTED,W
	movwf	LASTSELECTEDBANK
;end if
ENDIF11
;ENC28J60_Select
	bcf	LATB,2
;FastHWSPITransfer( ENC28J60_BIT_FIELD_CLR | (addr AND ADDR_MASK ), temp )
	movlw	31
	andwf	ADDR,W
	movwf	SysTemp1
	movlw	160
	iorwf	SysTemp1,W
	movwf	SPITXDATA
	call	FASTHWSPITRANSFER
;FastHWSPITransfer( ENC_Outbyte, temp )
	movf	ENC_OUTBYTE,W
	movwf	SPITXDATA
	call	FASTHWSPITRANSFER
;ENC28J60_Deselect
	bsf	LATB,2
	return

;********************************************************************************

ENC28J60_BITSET
;banktobeselected = ( addr & BANK_MASK) / 32
	movlw	96
	andwf	ADDR,W
	movwf	SysTemp1
	movwf	SysBYTETempA
	movlw	32
	movwf	SysBYTETempB
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
	movwf	SysTemp1
	movwf	SysBYTETempB
	movlw	27
	movwf	SysBYTETempA
	call	SysCompLessThan
	comf	SysByteTempX,F
	btfsc	SysByteTempX,0
;ENC28J60_selectBank ( banktobeselected, addr )
	call	ENC28J60_SELECTBANK
;end if
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
;FastHWSPITransfer( ENC28J60_BIT_FIELD_SET | (addr AND ADDR_MASK ), temp )
	movlw	31
	andwf	ADDR,W
	movwf	SysTemp1
	movlw	128
	iorwf	SysTemp1,W
	movwf	SPITXDATA
	call	FASTHWSPITRANSFER
;FastHWSPITransfer( ENC_Outbyte, temp )
	movf	ENC_OUTBYTE,W
	movwf	SPITXDATA
	call	FASTHWSPITRANSFER
;ENC28J60_Deselect
	bsf	LATB,2
	return

;********************************************************************************

FN_ENC28J60_READREG
;banktobeselected =  ( addr & BANK_MASK) / 32
	movlw	96
	andwf	ADDR,W
	movwf	SysTemp1
	movwf	SysBYTETempA
	movlw	32
	movwf	SysBYTETempB
	call	SysDivSub
	movf	SysBYTETempA,W
	movwf	BANKTOBESELECTED
;				'These registers (EIE, EIR, ESTAT, ECON2, ECON1)
;				'are present in all banks, no need to switch bank
;if lastselectedBank <> banktobeselected then
	subwf	LASTSELECTEDBANK,W
	btfsc	STATUS, Z
	goto	ENDIF7
;if ( ( addr & ADDR_MASK ) <= EIE  ) then
	movlw	31
	andwf	ADDR,W
	movwf	SysTemp1
	movwf	SysBYTETempB
	movlw	27
	movwf	SysBYTETempA
	call	SysCompLessThan
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ELSE8_1
;ENC28J60_selectBank ( banktobeselected, addr )
	call	ENC28J60_SELECTBANK
;else
	goto	ENDIF8
ELSE8_1
;lastselectedBank = banktobeselected
	movf	BANKTOBESELECTED,W
	movwf	LASTSELECTEDBANK
;end if
ENDIF8
;end if
ENDIF7
;ENC28J60_Select
	bcf	LATB,2
;Set WCOL Off
	banksel	SSP1CON1
	bcf	SSP1CON1,WCOL
;SSPBUF = ENC28J60_READ_CTRL_REG | ( addr AND ADDR_MASK )
	movlw	31
	banksel	ADDR
	andwf	ADDR,W
	movwf	SysTemp1
	banksel	SSPBUF
	movwf	SSPBUF
;Wait While BF = Off
SysWaitLoop6
	btfss	SSP1STAT,BF
	goto	SysWaitLoop6
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
SysWaitLoop7
	btfss	SSP1STAT,BF
	goto	SysWaitLoop7
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
SysWaitLoop8
	btfss	SSP1STAT,BF
	goto	SysWaitLoop8
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
	movwf	SPITXDATA
	call	FASTHWSPITRANSFER
;FastHWSPITransfer(b'00000011', temp)
	movlw	3
	movwf	SPITXDATA
	call	FASTHWSPITRANSFER
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
	movwf	SPITXDATA
	call	FASTHWSPITRANSFER
;FastHWSPITransfer(b'00000001' , temp)
	movlw	1
	movwf	SPITXDATA
	call	FASTHWSPITRANSFER
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
	movwf	SPITXDATA
	call	FASTHWSPITRANSFER
;FastHWSPITransfer(b'00000010' , temp)
	movlw	2
	movwf	SPITXDATA
	call	FASTHWSPITRANSFER
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
	movwf	SPITXDATA
	call	FASTHWSPITRANSFER
;FastHWSPITransfer(b'00000011' , temp)
	movlw	3
	movwf	SPITXDATA
	call	FASTHWSPITRANSFER
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

ENC28J60_WRITEPHYREG
;		while ((ENC28J60_ReadReg(MISTAT) & MISTAT_BUSY ) = MISTAT_BUSY )
SysDoLoop_S2
	movlw	234
	movwf	ADDR
	call	FN_ENC28J60_READREG
;ENC28J60_writeReg( MIREGADR, PhyRegaddr )
	movlw	212
	movwf	ADDR
	movf	PHYREGADDR,W
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
SysWaitLoop5
	movlw	234
	movwf	ADDR
	call	FN_ENC28J60_READREG
	movlw	1
	andwf	ENC28J60_READREG,W
	movwf	SysTemp1
	movwf	SysBYTETempA
	movlw	1
	movwf	SysBYTETempB
	call	SysCompEqual
	btfsc	SysByteTempX,0
	goto	SysWaitLoop5
	return

;********************************************************************************

ENC28J60_WRITEREG
;banktobeselected = ( addr & BANK_MASK) / 32
	movlw	96
	andwf	ADDR,W
	movwf	SysTemp1
	movwf	SysBYTETempA
	movlw	32
	movwf	SysBYTETempB
	call	SysDivSub
	movf	SysBYTETempA,W
	movwf	BANKTOBESELECTED
;if lastselectedBank <> banktobeselected then
	subwf	LASTSELECTEDBANK,W
	btfsc	STATUS, Z
	goto	ELSE5_1
;if ( ( addr & ADDR_MASK )  <= EIE  ) then
	movlw	31
	andwf	ADDR,W
	movwf	SysTemp1
	movwf	SysBYTETempB
	movlw	27
	movwf	SysBYTETempA
	call	SysCompLessThan
	comf	SysByteTempX,F
	btfsc	SysByteTempX,0
;ENC28J60_selectBank ( banktobeselected, addr )
	call	ENC28J60_SELECTBANK
;end if
;Else
	goto	ENDIF5
ELSE5_1
;lastselectedBank = banktobeselected
	movf	BANKTOBESELECTED,W
	movwf	LASTSELECTEDBANK
;end if
ENDIF5
;ENC28J60_Select
	bcf	LATB,2
;FastHWSPITransfer( ENC28J60_WRITE_CTRL_REG | (addr AND ADDR_MASK ), temp )
	movlw	31
	andwf	ADDR,W
	movwf	SysTemp1
	movlw	64
	iorwf	SysTemp1,W
	movwf	SPITXDATA
	call	FASTHWSPITRANSFER
;FastHWSPITransfer( ENC_Outbyte, temp )
	movf	ENC_OUTBYTE,W
	movwf	SPITXDATA
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
SysWaitLoop12
	btfss	SSPSTAT,BF
	goto	SysWaitLoop12
;Set SSPSTAT.BF Off
	bcf	SSPSTAT,BF
;SPIRxData = SSPBUF
	movf	SSPBUF,W
	banksel	SPIRXDATA
	movwf	SPIRXDATA
	return

;********************************************************************************

FN_FNNOTBIT
;If BitIn then
	movf	BITIN,F
	btfsc	STATUS,Z
	goto	ELSE16_1
;FnNOTBit = 0
	bcf	FNNOTBIT
;Else
	goto	ENDIF16
ELSE16_1
;FnNOTBit = 1
	bsf	FNNOTBIT
;End If
ENDIF16
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
	goto	ENDIF19
	movlw	7
	addwf	SYSSTRINGTEMP,F
ENDIF19
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
	goto	ENDIF21
	movlw	7
	addwf	SYSSTRINGTEMP,F
ENDIF21
;Hex(1) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W
	banksel	SYSHEX_1
	movwf	SYSHEX_1
	banksel	STATUS
	return

;********************************************************************************

;Overloaded signature: STRING:byte:
HSERPRINT238
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
	goto	ENDIF23
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
	goto	SysForLoop3
SysForLoopEnd3
;End If
ENDIF23
	return

;********************************************************************************

;Overloaded signature: WORD:byte:
HSERPRINT240
;Dim SysCalcTempX As Word
;OutValueTemp = 0
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
	call	SysCompLessThan16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF42
;OutValueTemp = SerPrintVal / 10000 [word]
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB
	movlw	39
	movwf	SysWORDTempB_H
	call	SysDivSub16
	movf	SysWORDTempA,W
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
	call	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;Goto HSerPrintWord1000
	goto	HSERPRINTWORD1000
;End If
ENDIF42
;If SerPrintVal >= 1000 then
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB
	movlw	3
	movwf	SysWORDTempB_H
	call	SysCompLessThan16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF43
HSERPRINTWORD1000
;OutValueTemp = SerPrintVal / 1000 [word]
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB
	movlw	3
	movwf	SysWORDTempB_H
	call	SysDivSub16
	movf	SysWORDTempA,W
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
	call	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;Goto HSerPrintWord100
	goto	HSERPRINTWORD100
;End If
ENDIF43
;If SerPrintVal >= 100 then
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysCompLessThan16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF44
HSERPRINTWORD100
;OutValueTemp = SerPrintVal / 100 [word]
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysDivSub16
	movf	SysWORDTempA,W
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
	call	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;Goto HSerPrintWord10
	goto	HSERPRINTWORD10
;End If
ENDIF44
;If SerPrintVal >= 10 then
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysCompLessThan16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF45
HSERPRINTWORD10
;OutValueTemp = SerPrintVal / 10 [word]
	movf	SERPRINTVAL,W
	movwf	SysWORDTempA
	movf	SERPRINTVAL_H,W
	movwf	SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysDivSub16
	movf	SysWORDTempA,W
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
	call	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;End If
ENDIF45
;HSerSend(SerPrintVal + 48 ,comport  )
	movlw	48
	addwf	SERPRINTVAL,W
	movwf	SERDATA
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
	movwf	SysRepeatTemp1
	btfsc	STATUS,Z
	goto	SysRepeatLoopEnd1
SysRepeatLoop1
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
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop1
SysRepeatLoopEnd1
	return

;********************************************************************************

HSERSEND
;if comport = 1 Then
	decf	COMPORT,W
	btfss	STATUS, Z
	goto	ENDIF22
;Wait While TXIF = Off
SysWaitLoop13
	banksel	PIR3
	btfss	PIR3,TXIF
	goto	SysWaitLoop13
;Wait While TXIF = Off
SysWaitLoop14
	btfss	PIR3,TXIF
	goto	SysWaitLoop14
;TXREG1 = SerData
	banksel	SERDATA
	movf	SERDATA,W
	banksel	TXREG1
	movwf	TXREG1
;end if
ENDIF22
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
SPIMODE194
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
	goto	ENDIF17
;Set SSPSTAT.CKE On
	banksel	SSPSTAT
	bsf	SSPSTAT,CKE
;End If
ENDIF17
;Set SSPCON1.CKP Off
	banksel	SSPCON1
	bcf	SSPCON1,CKP
;If SPIClockMode.1 = On Then
	banksel	SPICLOCKMODE
	btfss	SPICLOCKMODE,1
	goto	ENDIF18
;Set SSPCON1.CKP On
	banksel	SSPCON1
	bsf	SSPCON1,CKP
;End If
ENDIF18
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

FN_STR
;SysCharCount = 0
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
	call	SysCompLessThan16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF29
;SysStrData = SysValTemp / 10000
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB
	movlw	39
	movwf	SysWORDTempB_H
	call	SysDivSub16
	movf	SysWORDTempA,W
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
	clrf	SysTemp2
	movlw	high(STR)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF0
;Goto SysValThousands
	goto	SYSVALTHOUSANDS
;End If
ENDIF29
;IF SysValTemp >= 1000 then
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB
	movlw	3
	movwf	SysWORDTempB_H
	call	SysCompLessThan16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF30
SYSVALTHOUSANDS
;SysStrData = SysValTemp / 1000
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB
	movlw	3
	movwf	SysWORDTempB_H
	call	SysDivSub16
	movf	SysWORDTempA,W
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
	clrf	SysTemp2
	movlw	high(STR)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF0
;Goto SysValHundreds
	goto	SYSVALHUNDREDS
;End If
ENDIF30
;IF SysValTemp >= 100 then
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysCompLessThan16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF31
SYSVALHUNDREDS
;SysStrData = SysValTemp / 100
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysDivSub16
	movf	SysWORDTempA,W
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
	clrf	SysTemp2
	movlw	high(STR)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF0
;Goto SysValTens
	goto	SYSVALTENS
;End If
ENDIF31
;IF SysValTemp >= 10 Then
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysCompLessThan16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF32
SYSVALTENS
;SysStrData = SysValTemp / 10
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysDivSub16
	movf	SysWORDTempA,W
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
	clrf	SysTemp2
	movlw	high(STR)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF0
;End If
ENDIF32
;SysCharCount += 1
	incf	SYSCHARCOUNT,F
;Str(SysCharCount) = SysValTemp + 48
	movlw	low(STR)
	addwf	SYSCHARCOUNT,W
	movwf	AFSR0
	clrf	SysTemp2
	movlw	high(STR)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movlw	48
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
	call	SysCompEqual16
	btfss	SysByteTempX,0
	goto	ENDIF40
;SysWordTempA = 0
	clrf	SYSWORDTEMPA
	clrf	SYSWORDTEMPA_H
;exit sub
	return
;end if
ENDIF40
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
	goto	ENDIF41
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	addwfc	SYSDIVMULTX_H,F
;End If
ENDIF41
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

;Start of program memory page 3
	ORG	6144

 END
