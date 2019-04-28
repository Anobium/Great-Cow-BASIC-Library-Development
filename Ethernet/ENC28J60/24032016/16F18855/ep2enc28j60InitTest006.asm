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
SysBYTETempA	EQU	117
SysBYTETempB	EQU	121
SysBYTETempX	EQU	112
SysDivLoop	EQU	116
SysStringA	EQU	119
SysStringA_H	EQU	120
SysStringLength	EQU	118
SysWaitTempMS	EQU	114
SysWaitTempMS_H	EQU	115
ETHERBUFFER	EQU	9069
SYSSTRINGPARAM1	EQU	9028
MACADDR	EQU	9021
IPADDR	EQU	9016
IPSERVER	EQU	9011
HEX	EQU	9007
ADDR	EQU	32
BANKTOBESELECTED	EQU	33
COMPORT	EQU	34
ENC28J60_READREG	EQU	35
ENC_LAST_TXBUF	EQU	36
ENC_LAST_TXBUF_H	EQU	37
ENC_OUTBYTE	EQU	38
ENC_OUTBYTE1	EQU	39
ENC_OUTBYTE2	EQU	40
FRAMELENGTH	EQU	41
HSERPRINTCRLFCOUNT	EQU	42
IPPORT	EQU	43
LASTSELECTEDBANK	EQU	44
MACON2	EQU	45
MICON1	EQU	46
MICON2	EQU	47
OUTVALUETEMP	EQU	48
PHYREGADDR	EQU	49
PRINTLEN	EQU	50
SERDATA	EQU	51
SERPRINTVAL	EQU	52
SPICLOCKMODE	EQU	53
SPICURRENTMODE	EQU	54
SPIRXDATA	EQU	55
SPITXDATA	EQU	56
SYSBITVAR0	EQU	57
SYSPRINTTEMP	EQU	58
SYSSTRINGTEMP	EQU	59
SYSVALTEMP	EQU	60
StringPointer	EQU	61
SysMACADDRHandler	EQU	62
SysMACADDRHandler_H	EQU	63
SysPRINTDATAHandler	EQU	64
SysPRINTDATAHandler_H	EQU	65
SysRepeatTemp1	EQU	66
SysTemp1	EQU	67
SysTemp2	EQU	68
TEMP	EQU	69
XX	EQU	70

;********************************************************************************

;Alias variables
AFSR0	EQU	4
AFSR0_H	EQU	5
SSPBUF	EQU	396
SSPCON1	EQU	400
SSPSTAT	EQU	399
SYSHEX_0	EQU	1327
SYSHEX_1	EQU	1328
SYSHEX_2	EQU	1329
SYSMACADDR_1	EQU	1342
SYSMACADDR_2	EQU	1343
SYSMACADDR_3	EQU	1344
SYSMACADDR_4	EQU	1345
SYSMACADDR_5	EQU	1346
SYSMACADDR_6	EQU	1347

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
	call	INITSYS
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
	call	HSERPRINTCRLF
;HserPrint "ENC28J60 Ethernet Driver 006" : HSerPrintCRLF
	movlw	low StringTable1
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable1) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT222
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	call	HSERPRINTCRLF
;HserPrint "Init Test": HSerPrintCRLF
	movlw	low StringTable2
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable2) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT222
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	call	HSERPRINTCRLF
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
;ipserver = 192,168,0,249
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
	movlw	249
	movwf	INDF0
;macaddr = 0x42, 0x00, 0x33, 0x44, 0x55, 0x65
	movlw	low MACADDR
	movwf	FSR0L
	movlw	high MACADDR
	movwf	FSR0H
	movlw	6
	movwf	INDF0
	incf	FSR0L,F
	movlw	66
	movwf	INDF0
	incf	FSR0L,F
	clrf	INDF0
	incf	FSR0L,F
	movlw	51
	movwf	INDF0
	incf	FSR0L,F
	movlw	68
	movwf	INDF0
	incf	FSR0L,F
	movlw	85
	movwf	INDF0
	incf	FSR0L,F
	movlw	101
	movwf	INDF0
;ENC28J60_Init ( macaddr )
	movlw	low MACADDR
	movwf	SysMACADDRHandler
	movlw	high MACADDR
	movwf	SysMACADDRHandler_H
	call	ENC28J60_INIT
;ENC28J60_WriteReg(MIREGADR, PHLCON)
	movlw	212
	movwf	ADDR
	movlw	20
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_WriteReg(MIWRL, 0b01110010)
;ENC28J60_WriteReg(MIWRH, 0b00000100)
;ENC28J60_WriteReg( MIWRL, 0x04 )
	movlw	214
	movwf	ADDR
	movlw	4
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_WriteReg( MIWRH, 0x76 )
	movlw	215
	movwf	ADDR
	movlw	118
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;for xx = 1 to 5
	clrf	XX
SysForLoop1
	incf	XX,F
;ENC28J60_WriteReg(ECOCON, xx)
	movlw	117
	movwf	ADDR
	movf	XX,W
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;next
	movlw	5
	subwf	XX,W
	btfss	STATUS, C
	goto	SysForLoop1
SysForLoopEnd1
;HserPrint         "Mac Address:         "
	movlw	low StringTable3
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable3) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT222
;HserPrint hex(ENC28J60_ReadReg(MAADR1))+"-"
	movlw	224
	movwf	ADDR
	call	FN_ENC28J60_READREG
	movf	ENC28J60_READREG,W
	movwf	SYSVALTEMP
	call	FN_HEX
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	call	SysCopyStringPart
	movlw	low StringTable4
	movwf	SysStringA
	movlw	(high StringTable4) & 127
	movwf	SysStringA_H
	call	SysReadStringPart
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
	call	HSERPRINT222
;HserPrint hex(ENC28J60_ReadReg(MAADR0))+"-"
	movlw	225
	movwf	ADDR
	call	FN_ENC28J60_READREG
	movf	ENC28J60_READREG,W
	movwf	SYSVALTEMP
	call	FN_HEX
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	call	SysCopyStringPart
	movlw	low StringTable4
	movwf	SysStringA
	movlw	(high StringTable4) & 127
	movwf	SysStringA_H
	call	SysReadStringPart
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
	call	HSERPRINT222
;HserPrint hex(ENC28J60_ReadReg(MAADR3))+"-"
	movlw	226
	movwf	ADDR
	call	FN_ENC28J60_READREG
	movf	ENC28J60_READREG,W
	movwf	SYSVALTEMP
	call	FN_HEX
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	call	SysCopyStringPart
	movlw	low StringTable4
	movwf	SysStringA
	movlw	(high StringTable4) & 127
	movwf	SysStringA_H
	call	SysReadStringPart
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
	call	HSERPRINT222
;HserPrint hex(ENC28J60_ReadReg(MAADR2))+"-"
	movlw	227
	movwf	ADDR
	call	FN_ENC28J60_READREG
	movf	ENC28J60_READREG,W
	movwf	SYSVALTEMP
	call	FN_HEX
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	call	SysCopyStringPart
	movlw	low StringTable4
	movwf	SysStringA
	movlw	(high StringTable4) & 127
	movwf	SysStringA_H
	call	SysReadStringPart
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
	call	HSERPRINT222
;HserPrint hex(ENC28J60_ReadReg(MAADR5))+"-"
	movlw	228
	movwf	ADDR
	call	FN_ENC28J60_READREG
	movf	ENC28J60_READREG,W
	movwf	SYSVALTEMP
	call	FN_HEX
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low HEX
	movwf	FSR0L
	movlw	high HEX
	movwf	FSR0H
	call	SysCopyStringPart
	movlw	low StringTable4
	movwf	SysStringA
	movlw	(high StringTable4) & 127
	movwf	SysStringA_H
	call	SysReadStringPart
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
	call	HSERPRINT222
;HserPrint hex(ENC28J60_ReadReg(MAADR4)): HSerPrintCRLF
	movlw	229
	movwf	ADDR
	call	FN_ENC28J60_READREG
	movf	ENC28J60_READREG,W
	movwf	SYSVALTEMP
	call	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT222
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	call	HSERPRINTCRLF
;do
SysDoLoop_S1
;if (ENC28J60_ReadReg(EPKTCNT) <> 0 ) then '* We received a packet
	movlw	57
	movwf	ADDR
	call	FN_ENC28J60_READREG
	movf	ENC28J60_READREG,F
	btfsc	STATUS, Z
	goto	ELSE2_1
;ENC28J60_Select
	bcf	LATB,2
;FastHWSPITransfer  0b00111010, temp
	movlw	58
	movwf	SPITXDATA
	call	FASTHWSPITRANSFER
;for xx = 1 to 6
	clrf	XX
SysForLoop2
	incf	XX,F
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
SysWaitLoop1
	btfss	SSP1STAT,BF
	goto	SysWaitLoop1
;Set BF Off
	bcf	SSP1STAT,BF
;next
	movlw	6
	banksel	XX
	subwf	XX,W
	btfss	STATUS, C
	goto	SysForLoop2
SysForLoopEnd2
;HSerPrint "Destination address: "
	movlw	low StringTable5
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable5) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT222
;for xx = 1 to 6
	clrf	XX
SysForLoop3
	incf	XX,F
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
SysWaitLoop2
	btfss	SSP1STAT,BF
	goto	SysWaitLoop2
;HSerPrint hex(SSPBUF)
	movf	SSPBUF,W
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	call	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT222
;Set BF Off
	banksel	SSP1STAT
	bcf	SSP1STAT,BF
;if xx < 6 then HSerPrint "-"
	movlw	6
	banksel	XX
	subwf	XX,W
	btfsc	STATUS, C
	goto	ENDIF4
	movlw	low StringTable4
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable4) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT222
ENDIF4
;next
	movlw	6
	subwf	XX,W
	btfss	STATUS, C
	goto	SysForLoop3
SysForLoopEnd3
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	call	HSERPRINTCRLF
;HSerPrint "Source address:      "
	movlw	low StringTable6
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable6) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT222
;for xx = 1 to 6
	clrf	XX
SysForLoop4
	incf	XX,F
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
SysWaitLoop3
	btfss	SSP1STAT,BF
	goto	SysWaitLoop3
;HSerPrint hex(SSPBUF)
	movf	SSPBUF,W
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	call	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT222
;Set BF Off
	banksel	SSP1STAT
	bcf	SSP1STAT,BF
;if xx < 6 then HSerPrint "-"
	movlw	6
	banksel	XX
	subwf	XX,W
	btfsc	STATUS, C
	goto	ENDIF6
	movlw	low StringTable4
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable4) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT222
ENDIF6
;next
	movlw	6
	subwf	XX,W
	btfss	STATUS, C
	goto	SysForLoop4
SysForLoopEnd4
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	call	HSERPRINTCRLF
;HSerPrint "Type/Length:         "
	movlw	low StringTable7
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable7) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT222
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
SysWaitLoop4
	btfss	SSP1STAT,BF
	goto	SysWaitLoop4
;temp = SSPBUF
	movf	SSPBUF,W
	banksel	TEMP
	movwf	TEMP
;HSerPrint hex(temp)
	movwf	SYSVALTEMP
	call	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT222
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
SysWaitLoop5
	btfss	SSP1STAT,BF
	goto	SysWaitLoop5
;framelength = SSPBUF
	movf	SSPBUF,W
	banksel	FRAMELENGTH
	movwf	FRAMELENGTH
;Set BF Off
	banksel	SSP1STAT
	bcf	SSP1STAT,BF
;HSerPrint hex(framelength)
	banksel	FRAMELENGTH
	movf	FRAMELENGTH,W
	movwf	SYSVALTEMP
	call	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT222
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	call	HSERPRINTCRLF
;for xx = 14 to 59
	movlw	13
	movwf	XX
SysForLoop5
	incf	XX,F
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
;HSerPrint SSPBUF
	movf	SSPBUF,W
	banksel	SERPRINTVAL
	movwf	SERPRINTVAL
	movlw	1
	movwf	COMPORT
	call	HSERPRINT223
;Set BF Off
	banksel	SSP1STAT
	bcf	SSP1STAT,BF
;HSerPrint ","
	movlw	low StringTable8
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable8) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT222
;next
	movlw	59
	subwf	XX,W
	btfss	STATUS, C
	goto	SysForLoop5
SysForLoopEnd5
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	call	HSERPRINTCRLF
;ENC28J60_DeSelect
	bsf	LATB,2
;ENC28J60_Select
	bcf	LATB,2
;FastHWSPITransfer(BFSCMD | ECON2, temp)
	movlw	158
	movwf	SPITXDATA
	call	FASTHWSPITRANSFER
;FastHWSPITransfer(EPKTDEC , temp)
	movlw	64
	movwf	SPITXDATA
	call	FASTHWSPITRANSFER
;ENC28J60_Deselect
	bsf	LATB,2
;else
ELSE2_1
;end if
;loop
	goto	SysDoLoop_S1
SysDoLoop_E1
;end
	goto	BASPROGRAMEND
;----- Support methods.  Subroutines and Functions
;#define ENC28J60_Select         Set ENC28J60_CS off
;#define ENC28J60_Deselect       Set ENC28J60_CS on
;#define ENC28J60_Reset_CMD			Set ENC28J60_RESET on: Wait 10 ms :Set ENC28J60_RESET off: Wait 10 ms :Set ENC28J60_RESET on: Wait 10 ms
CONFIGURATIONDETAILS
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

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
;SPIMode Master, 0
	movlw	12
	movwf	SPICURRENTMODE
	clrf	SPICLOCKMODE
	call	SPIMODE178
;ENC28J60_Reset_CMD
	bsf	LATB,1
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
	bcf	LATB,1
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
	bsf	LATB,1
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;FastHWSPITransfer( ENC28J60_SOFT_RESET, temp )
	movlw	255
	movwf	SPITXDATA
	call	FASTHWSPITRANSFER
;lastselectedBank = 99
	movlw	99
	movwf	LASTSELECTEDBANK
;wait while ( (ENC28J60_ReadReg( ESTAT ) & ESTAT_CLKRDY ) <> ESTAT_CLKRDY)
SysWaitLoop7
	movlw	29
	movwf	ADDR
	call	FN_ENC28J60_READREG
	movlw	1
	andwf	ENC28J60_READREG,W
	movwf	SysTemp1
	movwf	SysBYTETempA
	movlw	1
	movwf	SysBYTETempB
	call	SysCompEqual
	comf	SysByteTempX,F
	btfsc	SysByteTempX,0
	goto	SysWaitLoop7
;ENC28J60_writeReg(ECON1, 0xC0) 'Hold it in Reset
	movlw	31
	movwf	ADDR
	movlw	192
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(ECON2, 0x80) 'Set the AUTOINC bit
	movlw	30
	movwf	ADDR
	movlw	128
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(EIR, 0x00) 'Reset interrupt flags
	movlw	28
	movwf	ADDR
	clrf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(EIE,  0xC0)  'Interrupts: Packet reception
	movlw	27
	movwf	ADDR
	movlw	192
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(EWOLIE, 0x00)  'Disable wake-on-lan interrupts
	movlw	54
	movwf	ADDR
	clrf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(EWOLIR, 0x00)  'Clear wake-on-lan interrupt flags
	movlw	55
	movwf	ADDR
	clrf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(ETXSTL, ENC_TXBUF_STL)
	movlw	4
	movwf	ADDR
	movlw	112
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(ETXSTH, ENC_TXBUF_STH)
	movlw	5
	movwf	ADDR
	movlw	22
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(ETXNDL, ENC_TXBUF_NDL)
	movlw	6
	movwf	ADDR
	movlw	255
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(ETXNDH, ENC_TXBUF_NDH)  'TX Buffer : 1800 bytes
	movlw	7
	movwf	ADDR
	movlw	31
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(ERXSTL, ENC_RXBUF_STL)
	movlw	8
	movwf	ADDR
	clrf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(ERXSTH, ENC_RXBUF_STH)
	movlw	9
	movwf	ADDR
	clrf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(ERXNDL, ENC_RXBUF_NDL)
	movlw	10
	movwf	ADDR
	movlw	110
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(ERXNDH, ENC_RXBUF_NDH)  'RX Buffer : 6390 bytes
	movlw	11
	movwf	ADDR
	clrf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(ERDPTL, ENC_RXBUF_STL)
	clrf	ADDR
	clrf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(ERDPTH, ENC_RXBUF_STH)
	movlw	1
	movwf	ADDR
	clrf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(ERXRDPTL, ENC_RXBUF_STL)
	movlw	12
	movwf	ADDR
	clrf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(ERXRDPTH, ENC_RXBUF_STH) 'RX Pointers (same)
	movlw	13
	movwf	ADDR
	clrf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(ERXFCON, 0xA1) 'Receive unicasts or broadcasts
	movlw	56
	movwf	ADDR
	movlw	161
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(EFLOCON, 0x00) 'Disable flow control sending
	movlw	119
	movwf	ADDR
	clrf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(ECOCON, 0x00) 'Disable Clock Out pin
	movlw	117
	movwf	ADDR
	clrf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(EBSTCON, 0x00) 'Disable built-in self test controller
	movlw	103
	movwf	ADDR
	clrf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;wait while ( (ENC28J60_ReadReg(ESTAT) & ESTAT_CLKRDY) <> ESTAT_CLKRDY)
SysWaitLoop8
	movlw	29
	movwf	ADDR
	call	FN_ENC28J60_READREG
	movlw	1
	andwf	ENC28J60_READREG,W
	movwf	SysTemp1
	movwf	SysBYTETempA
	movlw	1
	movwf	SysBYTETempB
	call	SysCompEqual
	comf	SysByteTempX,F
	btfsc	SysByteTempX,0
	goto	SysWaitLoop8
;ENC28J60_writeReg(MISTAT, 0x00)  'Clear MII status register
	movlw	234
	movwf	ADDR
	clrf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(MICMD, 0x00)   'Clear MII command register
	movlw	210
	movwf	ADDR
	clrf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(MICON1, 0x02)  'Fast MII operation
	movf	MICON1,W
	movwf	ADDR
	movlw	2
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(MICON2, 0x00)  'Release MII interface from reset
	movf	MICON2,W
	movwf	ADDR
	clrf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(MACON1, b'00001101' )  'Enable packet reception
	movlw	192
	movwf	ADDR
	movlw	13
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(MACON2, 0x00)  'Release the MAC subsystem from reset
	movf	MACON2,W
	movwf	ADDR
	clrf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(MACON3, 0xF0)  'Auto Pad + CRC + Half Duplex
	movlw	194
	movwf	ADDR
	movlw	240
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(MACON4, 0x01)  'Need valid preamble
	movlw	195
	movwf	ADDR
	movlw	1
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(MAPHSUP, b'00010000') 'Release MAC-PHY support from Reset
	movlw	205
	movwf	ADDR
	movlw	16
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(MAMXFLL, 0xEE)
	movlw	202
	movwf	ADDR
	movlw	238
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(MAMXFLH, 0x5)  'Maximum frame length
	movlw	203
	movwf	ADDR
	movlw	5
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(MABBIPG, 0x12) 'IEEE BTB Inter Packet Gap
	movlw	196
	movwf	ADDR
	movlw	18
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(MAIPGL, 0x12)
	movlw	198
	movwf	ADDR
	movlw	18
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(MAIPGH, 0x0C)  'IEEE Non BTB Inter Packet Gap
	movlw	199
	movwf	ADDR
	movlw	12
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(MAADR0, macaddr(2))
	movlw	225
	movwf	ADDR
	banksel	SYSMACADDR_2
	movf	SYSMACADDR_2,W
	banksel	ENC_OUTBYTE
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(MAADR1, macaddr(1))
	movlw	224
	movwf	ADDR
	banksel	SYSMACADDR_1
	movf	SYSMACADDR_1,W
	banksel	ENC_OUTBYTE
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(MAADR2, macaddr(4))
	movlw	227
	movwf	ADDR
	banksel	SYSMACADDR_4
	movf	SYSMACADDR_4,W
	banksel	ENC_OUTBYTE
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(MAADR3, macaddr(3))
	movlw	226
	movwf	ADDR
	banksel	SYSMACADDR_3
	movf	SYSMACADDR_3,W
	banksel	ENC_OUTBYTE
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(MAADR4, macaddr(6))
	movlw	229
	movwf	ADDR
	banksel	SYSMACADDR_6
	movf	SYSMACADDR_6,W
	banksel	ENC_OUTBYTE
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(MAADR5, macaddr(5))
	movlw	228
	movwf	ADDR
	banksel	SYSMACADDR_5
	movf	SYSMACADDR_5,W
	banksel	ENC_OUTBYTE
	movwf	ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;'Initialize PHY subsystem
;ENC28J60_writePhyReg(PHCON1, 0x00, 0x00)  'Half duplex
	clrf	PHYREGADDR
	clrf	ENC_OUTBYTE1
	clrf	ENC_OUTBYTE2
	call	ENC28J60_WRITEPHYREG
;ENC28J60_writePhyReg(PHCON2, 0x00, 0x00)
	movlw	16
	movwf	PHYREGADDR
	clrf	ENC_OUTBYTE1
	clrf	ENC_OUTBYTE2
	call	ENC28J60_WRITEPHYREG
;ENC28J60_writePhyReg(PHLCON, B'00000100', B'01110110')
	movlw	20
	movwf	PHYREGADDR
	movlw	4
	movwf	ENC_OUTBYTE1
	movlw	118
	movwf	ENC_OUTBYTE2
	call	ENC28J60_WRITEPHYREG
;ENC28J60_writePhyReg(PHIE, 0x00, 0x00)  'Disable interrupts
	movlw	18
	movwf	PHYREGADDR
	clrf	ENC_OUTBYTE1
	clrf	ENC_OUTBYTE2
	call	ENC28J60_WRITEPHYREG
;ENC28J60_writeReg(ECON1, B'00010100')
	movlw	31
	movwf	ADDR
	movlw	20
	movwf	ENC_OUTBYTE
	goto	ENC28J60_WRITEREG

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
	goto	ENDIF13
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
	goto	ELSE14_1
;ENC28J60_selectBank ( banktobeselected, addr )
	call	ENC28J60_SELECTBANK
;else
	goto	ENDIF14
ELSE14_1
;lastselectedBank = banktobeselected
	movf	BANKTOBESELECTED,W
	movwf	LASTSELECTEDBANK
;end if
ENDIF14
;end if
ENDIF13
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
SysWaitLoop9
	btfss	SSP1STAT,BF
	goto	SysWaitLoop9
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
SysWaitLoop10
	btfss	SSP1STAT,BF
	goto	SysWaitLoop10
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
SysWaitLoop11
	btfss	SSP1STAT,BF
	goto	SysWaitLoop11
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
;		while ((ENC28J60_ReadReg(MISTAT) & MISTAT_BUSY ) = 1)
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
	goto	ENC28J60_WRITEREG

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
	goto	ENDIF17
	movlw	7
	addwf	SYSSTRINGTEMP,F
ENDIF17
;Hex(2) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W
	banksel	SYSHEX_2
	movwf	SYSHEX_2
;For SysStringTemp = 1 to 4
	banksel	SYSSTRINGTEMP
	clrf	SYSSTRINGTEMP
SysForLoop6
	incf	SYSSTRINGTEMP,F
;Rotate SysValTemp Right
	rrf	SYSVALTEMP,F
;Next
	movlw	4
	subwf	SYSSTRINGTEMP,W
	btfss	STATUS, C
	goto	SysForLoop6
SysForLoopEnd6
;SysStringTemp = SysValTemp And 0x0F
	movlw	15
	andwf	SYSVALTEMP,W
	movwf	SYSSTRINGTEMP
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	sublw	9
	btfsc	STATUS, C
	goto	ENDIF19
	movlw	7
	addwf	SYSSTRINGTEMP,F
ENDIF19
;Hex(1) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W
	banksel	SYSHEX_1
	movwf	SYSHEX_1
	banksel	STATUS
	return

;********************************************************************************

;Overloaded signature: STRING:byte:
HSERPRINT222
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
	goto	ENDIF21
;for SysPrintTemp = 1 to PrintLen
	clrf	SYSPRINTTEMP
	movlw	1
	subwf	PRINTLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd7
SysForLoop7
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
	goto	SysForLoop7
SysForLoopEnd7
;End If
ENDIF21
	return

;********************************************************************************

;Overloaded signature: BYTE:byte:
HSERPRINT223
;OutValueTemp = 0
	clrf	OUTVALUETEMP
;IF SerPrintVal >= 100 Then
	movlw	100
	subwf	SERPRINTVAL,W
	btfss	STATUS, C
	goto	ENDIF24
;OutValueTemp = SerPrintVal / 100
	movf	SERPRINTVAL,W
	movwf	SysBYTETempA
	movlw	100
	movwf	SysBYTETempB
	call	SysDivSub
	movf	SysBYTETempA,W
	movwf	OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SERPRINTVAL
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
ENDIF24
;If OutValueTemp > 0 Or SerPrintVal >= 10 Then
	movf	OUTVALUETEMP,W
	movwf	SysBYTETempB
	clrf	SysBYTETempA
	call	SysCompLessThan
	movf	SysByteTempX,W
	movwf	SysTemp1
	movf	SERPRINTVAL,W
	movwf	SysBYTETempA
	movlw	10
	movwf	SysBYTETempB
	call	SysCompLessThan
	comf	SysByteTempX,F
	movf	SysTemp1,W
	iorwf	SysByteTempX,W
	movwf	SysTemp2
	btfss	SysTemp2,0
	goto	ENDIF25
;OutValueTemp = SerPrintVal / 10
	movf	SERPRINTVAL,W
	movwf	SysBYTETempA
	movlw	10
	movwf	SysBYTETempB
	call	SysDivSub
	movf	SysBYTETempA,W
	movwf	OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	SERPRINTVAL
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
ENDIF25
;HSerSend(SerPrintVal + 48 ,comport)
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
	goto	ENDIF20
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

;Overloaded signature: BYTE:BYTE:
SPIMODE178
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
	goto	ENDIF15
;Set SSPSTAT.CKE On
	banksel	SSPSTAT
	bsf	SSPSTAT,CKE
;End If
ENDIF15
;Set SSPCON1.CKP Off
	banksel	SSPCON1
	bcf	SSPCON1,CKP
;If SPIClockMode.1 = On Then
	banksel	SPICLOCKMODE
	btfss	SPICLOCKMODE,1
	goto	ENDIF16
;Set SSPCON1.CKP On
	banksel	SSPCON1
	bsf	SSPCON1,CKP
;End If
ENDIF16
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
	retlw	48	;0
	retlw	54	;6


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
	retlw	21
	retlw	77	;M
	retlw	97	;a
	retlw	99	;c
	retlw	32	; 
	retlw	65	;A
	retlw	100	;d
	retlw	100	;d
	retlw	114	;r
	retlw	101	;e
	retlw	115	;s
	retlw	115	;s
	retlw	58	;:
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 


StringTable4
	retlw	1
	retlw	45	;-


StringTable5
	retlw	21
	retlw	68	;D
	retlw	101	;e
	retlw	115	;s
	retlw	116	;t
	retlw	105	;i
	retlw	110	;n
	retlw	97	;a
	retlw	116	;t
	retlw	105	;i
	retlw	111	;o
	retlw	110	;n
	retlw	32	; 
	retlw	97	;a
	retlw	100	;d
	retlw	100	;d
	retlw	114	;r
	retlw	101	;e
	retlw	115	;s
	retlw	115	;s
	retlw	58	;:
	retlw	32	; 


StringTable6
	retlw	21
	retlw	83	;S
	retlw	111	;o
	retlw	117	;u
	retlw	114	;r
	retlw	99	;c
	retlw	101	;e
	retlw	32	; 
	retlw	97	;a
	retlw	100	;d
	retlw	100	;d
	retlw	114	;r
	retlw	101	;e
	retlw	115	;s
	retlw	115	;s
	retlw	58	;:
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 


StringTable7
	retlw	21
	retlw	84	;T
	retlw	121	;y
	retlw	112	;p
	retlw	101	;e
	retlw	47	;/
	retlw	76	;L
	retlw	101	;e
	retlw	110	;n
	retlw	103	;g
	retlw	116	;t
	retlw	104	;h
	retlw	58	;:
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 


StringTable8
	retlw	1
	retlw	44	;,


;********************************************************************************

;Start of program memory page 1
	ORG	2048
;Start of program memory page 2
	ORG	4096
;Start of program memory page 3
	ORG	6144

 END
