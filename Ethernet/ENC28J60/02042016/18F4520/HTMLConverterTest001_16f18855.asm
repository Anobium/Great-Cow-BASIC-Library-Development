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
SYSCALCTEMPX	EQU	112
SYSDIVMULTA	EQU	119
SYSDIVMULTA_H	EQU	120
SYSDIVMULTB	EQU	123
SYSDIVMULTB_H	EQU	124
SYSDIVMULTX	EQU	114
SYSDIVMULTX_H	EQU	115
SYSINTEGERTEMPA	EQU	117
SYSINTEGERTEMPA_H	EQU	118
SYSINTEGERTEMPB	EQU	121
SYSINTEGERTEMPB_H	EQU	122
SYSINTEGERTEMPX	EQU	112
SYSINTEGERTEMPX_H	EQU	113
SYSSIGNBYTE	EQU	125
SYSWORDTEMPX	EQU	112
SYSWORDTEMPX_H	EQU	113
SysBYTETempA	EQU	117
SysBYTETempB	EQU	121
SysByteTempX	EQU	112
SysDivLoop	EQU	116
SysStringA	EQU	119
SysStringA_H	EQU	120
SysWORDTempA	EQU	117
SysWORDTempA_H	EQU	118
SysWORDTempB	EQU	121
SysWORDTempB_H	EQU	122
SysWaitTemp10US	EQU	117
SysWaitTempMS	EQU	114
SysWaitTempMS_H	EQU	115
CHR	EQU	9157
HTMLMAPPING	EQU	9152
HTMLMAPPINGTYPE	EQU	9147
ADCON	EQU	32
ADCPH	EQU	33
ADN_PORT	EQU	34
ADREADPORT	EQU	35
COMPORT	EQU	36
HTMLELEMENTTRACKER	EQU	37
INBYTE	EQU	38
OUTVALUETEMP	EQU	39
PRINTLEN	EQU	40
READAD10	EQU	41
READAD10_H	EQU	42
SERDATA	EQU	44
SERPRINTVAL	EQU	45
SYSBITVAR0	EQU	46
SYSCHAR	EQU	47
SYSPRINTTEMP	EQU	48
SysPRINTDATAHandler	EQU	49
SysPRINTDATAHandler_H	EQU	50
SysTemp1	EQU	51
SysTemp1_H	EQU	52
SysTemp2	EQU	53
TABLELOC	EQU	54
TABLELOC_H	EQU	55

;********************************************************************************

;Alias variables
AFSR0	EQU	4
AFSR0_H	EQU	5
SYSCHR_0	EQU	1573
SYSCHR_1	EQU	1574
SYSHTMLMAPPINGTYPE_1	EQU	1516
SYSHTMLMAPPINGTYPE_2	EQU	1517
SYSHTMLMAPPINGTYPE_3	EQU	1518
SYSHTMLMAPPINGTYPE_4	EQU	1519
SYSHTMLMAPPING_1	EQU	1569
SYSHTMLMAPPING_2	EQU	1570
SYSHTMLMAPPING_3	EQU	1571
SYSHTMLMAPPING_4	EQU	1572

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
	call	INITUSART

;Start of the main program
;''A demonstration program for GCGB and GCB.
;''--------------------------------------------------------------------------------------------------------------------------------
;''This program
;''
;''
;''@author
;''@licence	GPL
;''@version
;''@date   	01.11.2015
;''********************************************************************************
;----- Configuration
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
;#define AN4_GCB_HTML    HTMLMapping(1)
;#define AN3_GCB_HTML    HTMLMapping(2)
;#define PORTC_GCB_HTML  HTMLMapping(3)
;#define PORTB_GCB_HTML  HTMLMapping(4)
;dir porta.5 in          'switch
	bsf	TRISA,5
;dir porta.3 in          'adc3
	bsf	TRISA,3
;#define Potentiometer 	PORTA.4
;dir Potentiometer 	in
	bsf	TRISA,4
;dir portc Out           'led array
	clrf	TRISC
;dir PORTB Out           'led array
	clrf	TRISB
;dim TableLoc as Word
;do Forever
SysDoLoop_S1
;readtable gray_code, ( ReadAD10 ( AN4 ) / 64 ), AN4_GCB_HTML      'This maps to the first element in the array... but, we use the constant! Easier.
	movlw	4
	movwf	ADREADPORT
	movlw	255
	movwf	ADN_PORT
	call	FN_READAD10
	movf	READAD10,W
	movwf	SysINTEGERTempA
	movf	READAD10_H,W
	movwf	SysINTEGERTempA_H
	movlw	64
	movwf	SysINTEGERTempB
	clrf	SysINTEGERTempB_H
	call	SysDivSubINT
	movf	SysINTEGERTempA,W
	movwf	SYSSTRINGA
	call	GRAY_CODE
	banksel	SYSHTMLMAPPING_1
	movwf	SYSHTMLMAPPING_1
;readtable gray_code, ( ReadAD10 ( AN3 ) / 64 ), AN3_GCB_HTML
	movlw	3
	banksel	ADREADPORT
	movwf	ADREADPORT
	movlw	255
	movwf	ADN_PORT
	call	FN_READAD10
	movf	READAD10,W
	movwf	SysINTEGERTempA
	movf	READAD10_H,W
	movwf	SysINTEGERTempA_H
	movlw	64
	movwf	SysINTEGERTempB
	clrf	SysINTEGERTempB_H
	call	SysDivSubINT
	movf	SysINTEGERTempA,W
	movwf	SYSSTRINGA
	call	GRAY_CODE
	banksel	SYSHTMLMAPPING_2
	movwf	SYSHTMLMAPPING_2
;AN4_GCB_HTML = AN4_GCB_HTML & 0x0F
	movlw	15
	andwf	SYSHTMLMAPPING_1,F
;AN3_GCB_HTML = AN3_GCB_HTML & 0x0F
	movlw	15
	andwf	SYSHTMLMAPPING_2,F
;portc = AN4_GCB_HTML
	movf	SYSHTMLMAPPING_1,W
	banksel	PORTC
	movwf	PORTC
;PORTB = AN3_GCB_HTML
	banksel	SYSHTMLMAPPING_2
	movf	SYSHTMLMAPPING_2,W
	banksel	PORTB
	movwf	PORTB
;PORTC_GCB_HTML = portc   'portc
	movf	PORTC,W
	banksel	SYSHTMLMAPPING_3
	movwf	SYSHTMLMAPPING_3
;PORTB_GCB_HTML = PORTB   'PORTB
	banksel	PORTB
	movf	PORTB,W
	banksel	SYSHTMLMAPPING_4
	movwf	SYSHTMLMAPPING_4
;if porta.5 = 0 then DisplayHTMLPage
	banksel	PORTA
	btfss	PORTA,5
	call	DISPLAYHTMLPAGE
;loop
	goto	SysDoLoop_S1
SysDoLoop_E1
;DisplayHTMLPage
	call	DISPLAYHTMLPAGE
;end
	goto	BASPROGRAMEND
	movlw	1
	banksel	SYSHTMLMAPPINGTYPE_1
	movwf	SYSHTMLMAPPINGTYPE_1
	movlw	255
	banksel	SYSHTMLMAPPING_1
	movwf	SYSHTMLMAPPING_1
	movlw	1
	banksel	SYSHTMLMAPPINGTYPE_2
	movwf	SYSHTMLMAPPINGTYPE_2
	banksel	SYSHTMLMAPPING_2
	clrf	SYSHTMLMAPPING_2
	banksel	SYSHTMLMAPPINGTYPE_3
	clrf	SYSHTMLMAPPINGTYPE_3
	movlw	170
	banksel	SYSHTMLMAPPING_3
	movwf	SYSHTMLMAPPING_3
	banksel	SYSHTMLMAPPINGTYPE_4
	clrf	SYSHTMLMAPPINGTYPE_4
	movlw	85
	banksel	SYSHTMLMAPPING_4
	movwf	SYSHTMLMAPPING_4
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

;********************************************************************************

FN_CHR
;If SysChar < 0 Then
	movlw	0
	subwf	SYSCHAR,W
	btfsc	STATUS, C
	goto	ENDIF12
;Chr(0) = 0
	banksel	SYSCHR_0
	clrf	SYSCHR_0
;Exit Function
	banksel	STATUS
	return
;End If
ENDIF12
;Chr(0) = 1
	movlw	1
	banksel	SYSCHR_0
	movwf	SYSCHR_0
;Chr(1) = SysChar
	banksel	SYSCHAR
	movf	SYSCHAR,W
	banksel	SYSCHR_1
	movwf	SYSCHR_1
	banksel	STATUS
	return

;********************************************************************************

DISPLAYHTMLPAGE
;HTMLElementTracker = 1
	movlw	1
	movwf	HTMLELEMENTTRACKER
;for TableLoc = 1 to SizeofTable1
	clrf	TABLELOC
	clrf	TABLELOC_H
SysForLoop1
	incf	TABLELOC,F
	btfsc	STATUS,Z
	incf	TABLELOC_H,F
;ReadTable index1, TableLoc, inByte
	movf	TABLELOC,W
	movwf	SysStringA
	movf	TABLELOC_H,W
	movwf	SysStringA_H
	pagesel	INDEX1
	call	INDEX1
	pagesel	$
	movwf	INBYTE
;OutputHTMLVariable ( inByte )
	call	OUTPUTHTMLVARIABLE
;Next
	movf	TABLELOC,W
	movwf	SysWORDTempA
	movf	TABLELOC_H,W
	movwf	SysWORDTempA_H
	movlw	203
	movwf	SysWORDTempB
	movlw	7
	movwf	SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0
	goto	SysForLoop1
SysForLoopEnd1
;for TableLoc = 1 to SizeofTable2
	clrf	TABLELOC
	clrf	TABLELOC_H
SysForLoop2
	incf	TABLELOC,F
	btfsc	STATUS,Z
	incf	TABLELOC_H,F
;ReadTable index2, TableLoc, inByte
	movf	TABLELOC,W
	movwf	SysStringA
	call	INDEX2
	movwf	INBYTE
;OutputHTMLVariable ( inByte )
	call	OUTPUTHTMLVARIABLE
;Next
	movf	TABLELOC,W
	movwf	SysWORDTempA
	movf	TABLELOC_H,W
	movwf	SysWORDTempA_H
	movlw	102
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0
	goto	SysForLoop2
SysForLoopEnd2
	return

;********************************************************************************

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

GRAY_CODE
	movlw	17
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableGRAY_CODE
	movwf	SysStringA
	movlw	(high TableGRAY_CODE) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableGRAY_CODE
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	1
	retlw	1
	retlw	3
	retlw	3
	retlw	3
	retlw	3
	retlw	7
	retlw	7
	retlw	7
	retlw	15
	retlw	15
	retlw	15

;********************************************************************************

;Overloaded signature: STRING:byte:
HSERPRINT216
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
	goto	ENDIF13
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
ENDIF13
	return

;********************************************************************************

;Overloaded signature: BYTE:byte:
HSERPRINT217
;OutValueTemp = 0
	clrf	OUTVALUETEMP
;IF SerPrintVal >= 100 Then
	movlw	100
	subwf	SERPRINTVAL,W
	btfss	STATUS, C
	goto	ENDIF16
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
ENDIF16
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
	goto	ENDIF17
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
ENDIF17
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

HSERSEND
;if comport = 1 Then
	decf	COMPORT,W
	btfss	STATUS, Z
	goto	ENDIF20
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
ENDIF20
	banksel	STATUS
	return

;********************************************************************************

INDEX1_H
	movf	SYSSTRINGA,W
	movwf	SysWORDTempA
	movf	SYSSTRINGA_H,W
	movwf	SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0
	retlw	0
	movf	SysStringA, W
	addlw	low TableINDEX1_H
	movwf	SysStringA
	movlw	(high TableINDEX1_H) & 127
	btfsc	STATUS, C
	addlw	1
	addwf	SysStringA_H, W
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableINDEX1_H
	retlw	7

;********************************************************************************

INDEX2
	movlw	103
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableINDEX2
	movwf	SysStringA
	movlw	(high TableINDEX2) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableINDEX2
	retlw	102
	retlw	84
	retlw	104
	retlw	105
	retlw	115
	retlw	32
	retlw	105
	retlw	115
	retlw	32
	retlw	72
	retlw	84
	retlw	84
	retlw	80
	retlw	32
	retlw	114
	retlw	101
	retlw	113
	retlw	117
	retlw	101
	retlw	115
	retlw	116
	retlw	32
	retlw	35
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
	retlw	109
	retlw	97
	retlw	108
	retlw	108
	retlw	62
	retlw	60
	retlw	115
	retlw	109
	retlw	97
	retlw	108
	retlw	108
	retlw	62
	retlw	60
	retlw	115
	retlw	99
	retlw	114
	retlw	105
	retlw	112
	retlw	116
	retlw	62
	retlw	100
	retlw	111
	retlw	99
	retlw	117
	retlw	109
	retlw	101
	retlw	110
	retlw	116
	retlw	46
	retlw	119
	retlw	114
	retlw	105
	retlw	116
	retlw	101
	retlw	40
	retlw	82
	retlw	69
	retlw	81
	retlw	41
	retlw	60
	retlw	47
	retlw	115
	retlw	99
	retlw	114
	retlw	105
	retlw	112
	retlw	116
	retlw	62
	retlw	60
	retlw	47
	retlw	115
	retlw	109
	retlw	97
	retlw	108
	retlw	108
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

OUTPUTHTMLVARIABLE
;if inByte = 0 then
	movf	INBYTE,F
	btfss	STATUS, Z
	goto	ELSE6_1
;if HTMLMappingType(HTMLElementTracker) = StringVar then
	movlw	low(HTMLMAPPINGTYPE)
	addwf	HTMLELEMENTTRACKER,W
	movwf	AFSR0
	clrf	SysTemp1
	movlw	high(HTMLMAPPINGTYPE)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	decf	INDF0,W
	btfss	STATUS, Z
	goto	ELSE7_1
;HserPrint HTMLMapping(HTMLElementTracker)
	movlw	low(HTMLMAPPING)
	addwf	HTMLELEMENTTRACKER,W
	movwf	AFSR0
	clrf	SysTemp1
	movlw	high(HTMLMAPPING)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SERPRINTVAL
	movlw	1
	movwf	COMPORT
	call	HSERPRINT217
;else
	goto	ENDIF7
ELSE7_1
;HserPrint HTMLMapping(HTMLElementTracker)
	movlw	low(HTMLMAPPING)
	addwf	HTMLELEMENTTRACKER,W
	movwf	AFSR0
	clrf	SysTemp1
	movlw	high(HTMLMAPPING)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SERPRINTVAL
	movlw	1
	movwf	COMPORT
	call	HSERPRINT217
;end if
ENDIF7
;HTMLElementTracker++
	incf	HTMLELEMENTTRACKER,F
;Else
	goto	ENDIF6
ELSE6_1
;HSerPrint chr(inByte)
	movf	INBYTE,W
	movwf	SYSCHAR
	call	FN_CHR
	movlw	low CHR
	movwf	SysPRINTDATAHandler
	movlw	high CHR
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT216
;end if
ENDIF6
	return

;********************************************************************************

FN_READAD10
;		ADPCH = ADReadPort
	movf	ADREADPORT,W
	banksel	ADPCH
	movwf	ADPCH
;Do conversion
;LLReadAD 0
;'Configure ANSELA/B/C/D for 16F1885x
;Select Case ADReadPort
;Case 0: Set ANSELA.0 On
SysSelect1Case1
	banksel	ADREADPORT
	movf	ADREADPORT,F
	btfss	STATUS, Z
	goto	SysSelect1Case2
	banksel	ANSELA
	bsf	ANSELA,0
;Case 1: Set ANSELA.1 On
	goto	SysSelectEnd1
SysSelect1Case2
	decf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case3
	banksel	ANSELA
	bsf	ANSELA,1
;Case 2: Set ANSELA.2 On
	goto	SysSelectEnd1
SysSelect1Case3
	movlw	2
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case4
	banksel	ANSELA
	bsf	ANSELA,2
;Case 3: Set ANSELA.3 On
	goto	SysSelectEnd1
SysSelect1Case4
	movlw	3
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case5
	banksel	ANSELA
	bsf	ANSELA,3
;Case 4: Set ANSELA.4 ON
	goto	SysSelectEnd1
SysSelect1Case5
	movlw	4
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case6
	banksel	ANSELA
	bsf	ANSELA,4
;Case 5: Set ANSELA.5 On
	goto	SysSelectEnd1
SysSelect1Case6
	movlw	5
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case7
	banksel	ANSELA
	bsf	ANSELA,5
;Case 6: Set ANSELA.6 On
	goto	SysSelectEnd1
SysSelect1Case7
	movlw	6
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case8
	banksel	ANSELA
	bsf	ANSELA,6
;Case 7: Set ANSELA.7 On
	goto	SysSelectEnd1
SysSelect1Case8
	movlw	7
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case9
	banksel	ANSELA
	bsf	ANSELA,7
;Case 8: Set ANSELB.0 On
	goto	SysSelectEnd1
SysSelect1Case9
	movlw	8
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case10
	banksel	ANSELB
	bsf	ANSELB,0
;Case 9: Set ANSELB.1 On
	goto	SysSelectEnd1
SysSelect1Case10
	movlw	9
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case11
	banksel	ANSELB
	bsf	ANSELB,1
;Case 10: Set ANSELB.2 On
	goto	SysSelectEnd1
SysSelect1Case11
	movlw	10
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case12
	banksel	ANSELB
	bsf	ANSELB,2
;Case 11: Set ANSELB.3 On
	goto	SysSelectEnd1
SysSelect1Case12
	movlw	11
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case13
	banksel	ANSELB
	bsf	ANSELB,3
;Case 12: Set ANSELB.4 On
	goto	SysSelectEnd1
SysSelect1Case13
	movlw	12
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case14
	banksel	ANSELB
	bsf	ANSELB,4
;Case 13: Set ANSELB.5 On
	goto	SysSelectEnd1
SysSelect1Case14
	movlw	13
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case15
	banksel	ANSELB
	bsf	ANSELB,5
;Case 14: Set ANSELB.6 On
	goto	SysSelectEnd1
SysSelect1Case15
	movlw	14
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case16
	banksel	ANSELB
	bsf	ANSELB,6
;Case 15: Set ANSELB.7 On
	goto	SysSelectEnd1
SysSelect1Case16
	movlw	15
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case17
	banksel	ANSELB
	bsf	ANSELB,7
;Case 16: Set ANSELC.0 On
	goto	SysSelectEnd1
SysSelect1Case17
	movlw	16
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case18
	banksel	ANSELC
	bsf	ANSELC,0
;Case 17: Set ANSELC.1 On
	goto	SysSelectEnd1
SysSelect1Case18
	movlw	17
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case19
	banksel	ANSELC
	bsf	ANSELC,1
;Case 18: Set ANSELC.2 On
	goto	SysSelectEnd1
SysSelect1Case19
	movlw	18
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case20
	banksel	ANSELC
	bsf	ANSELC,2
;Case 19: Set ANSELC.3 On
	goto	SysSelectEnd1
SysSelect1Case20
	movlw	19
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case21
	banksel	ANSELC
	bsf	ANSELC,3
;Case 20: Set ANSELC.4 On
	goto	SysSelectEnd1
SysSelect1Case21
	movlw	20
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case22
	banksel	ANSELC
	bsf	ANSELC,4
;Case 21: Set ANSELC.5 On
	goto	SysSelectEnd1
SysSelect1Case22
	movlw	21
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case23
	banksel	ANSELC
	bsf	ANSELC,5
;Case 22: Set ANSELC.6 On
	goto	SysSelectEnd1
SysSelect1Case23
	movlw	22
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case24
	banksel	ANSELC
	bsf	ANSELC,6
;Case 23: Set ANSELC.7 On
	goto	SysSelectEnd1
SysSelect1Case24
	movlw	23
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect1Case25
	banksel	ANSELC
	bsf	ANSELC,7
;End Select
SysSelect1Case25
SysSelectEnd1
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
;Set ADCON0.2 ON     '10-bit
	bsf	ADCON0,2
;Else
;ADCPH = ADReadPort  'Configure AD read Channel
	banksel	ADREADPORT
	movf	ADREADPORT,W
	movwf	ADCPH
;SET ADCON0.ADON ON
	banksel	ADCON0
	bsf	ADCON0,ADON
;Wait AD_Delay
	movlw	2
	movwf	SysWaitTemp10US
	banksel	STATUS
	call	Delay_10US
;SET ADCON0.GO_NOT_DONE ON
	banksel	ADCON0
	bsf	ADCON0,GO_NOT_DONE
;nop
	nop
;	Wait While ADCON0.GO_NOT_DONE ON
SysWaitLoop1
	btfsc	ADCON0,GO_NOT_DONE
	goto	SysWaitLoop1
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON
;ANSELA = 0
	banksel	ANSELA
	clrf	ANSELA
;ANSELB = 0
	clrf	ANSELB
;ANSELC = 0
	clrf	ANSELC
;ReadAD10 = ADRESL
	banksel	ADRESL
	movf	ADRESL,W
	banksel	READAD10
	movwf	READAD10
	clrf	READAD10_H
;ReadAD10_H = ADRESH
	banksel	ADRESH
	movf	ADRESH,W
	banksel	READAD10_H
	movwf	READAD10_H
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
	goto	ENDIF18
;SysWordTempA = 0
	clrf	SYSWORDTEMPA
	clrf	SYSWORDTEMPA_H
;exit sub
	return
;end if
ENDIF18
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
	goto	ENDIF19
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	addwfc	SYSDIVMULTX_H,F
;End If
ENDIF19
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

SYSDIVSUBINT
;Dim SysIntegerTempA, SysIntegerTempB, SysIntegerTempX As Integer
;Dim SysSignByte As Byte
;SysSignByte = SysIntegerTempA_H xor SysIntegerTempB_H
	movf	SYSINTEGERTEMPA_H,W
	xorwf	SYSINTEGERTEMPB_H,W
	movwf	SYSSIGNBYTE
;If SysIntegerTempA.15 Then SysIntegerTempA = -SysIntegerTempA
	btfss	SYSINTEGERTEMPA_H,7
	goto	ENDIF9
	comf	SYSINTEGERTEMPA,F
	comf	SYSINTEGERTEMPA_H,F
	incf	SYSINTEGERTEMPA,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPA_H,F
ENDIF9
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
	btfss	SYSINTEGERTEMPB_H,7
	goto	ENDIF10
	comf	SYSINTEGERTEMPB,F
	comf	SYSINTEGERTEMPB_H,F
	incf	SYSINTEGERTEMPB,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPB_H,F
ENDIF10
;SysDivSub16
	call	SYSDIVSUB16
;If SysSignByte.7 Then
	btfss	SYSSIGNBYTE,7
	goto	ENDIF11
;SysIntegerTempA = -SysIntegerTempA
	comf	SYSINTEGERTEMPA,F
	comf	SYSINTEGERTEMPA_H,F
	incf	SYSINTEGERTEMPA,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPA_H,F
;SysIntegerTempX = -SysIntegerTempX
	comf	SYSINTEGERTEMPX,F
	comf	SYSINTEGERTEMPX_H,F
	incf	SYSINTEGERTEMPX,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPX_H,F
;End If
ENDIF11
	return

;********************************************************************************

;Start of program memory page 1
	ORG	2048
INDEX1
	movf	SYSSTRINGA,W
	movwf	SysWORDTempA
	movf	SYSSTRINGA_H,W
	movwf	SysWORDTempA_H
	movlw	204
	movwf	SysWORDTempB
	movlw	7
	movwf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	retlw	0
	movf	SysStringA, W
	addlw	low TableINDEX1
	movwf	SysStringA
	movlw	(high TableINDEX1) & 127
	btfsc	STATUS, C
	addlw	1
	addwf	SysStringA_H, W
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableINDEX1
	retlw	203
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
	retlw	72
	retlw	84
	retlw	77
	retlw	76
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
	retlw	109
	retlw	101
	retlw	116
	retlw	97
	retlw	32
	retlw	99
	retlw	111
	retlw	110
	retlw	116
	retlw	101
	retlw	110
	retlw	116
	retlw	61
	retlw	34
	retlw	117
	retlw	114
	retlw	108
	retlw	61
	retlw	104
	retlw	116
	retlw	116
	retlw	112
	retlw	58
	retlw	47
	retlw	47
	retlw	49
	retlw	57
	retlw	50
	retlw	46
	retlw	49
	retlw	54
	retlw	56
	retlw	46
	retlw	48
	retlw	46
	retlw	50
	retlw	52
	retlw	56
	retlw	34
	retlw	32
	retlw	104
	retlw	116
	retlw	116
	retlw	112
	retlw	45
	retlw	101
	retlw	113
	retlw	117
	retlw	105
	retlw	118
	retlw	61
	retlw	34
	retlw	114
	retlw	101
	retlw	102
	retlw	114
	retlw	101
	retlw	115
	retlw	104
	retlw	34
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
	retlw	104
	retlw	49
	retlw	32
	retlw	115
	retlw	116
	retlw	121
	retlw	108
	retlw	101
	retlw	61
	retlw	34
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
	retlw	72
	retlw	101
	retlw	108
	retlw	118
	retlw	101
	retlw	116
	retlw	105
	retlw	99
	retlw	97
	retlw	44
	retlw	65
	retlw	114
	retlw	105
	retlw	97
	retlw	108
	retlw	44
	retlw	115
	retlw	97
	retlw	110
	retlw	115
	retlw	45
	retlw	115
	retlw	101
	retlw	114
	retlw	105
	retlw	102
	retlw	59
	retlw	32
	retlw	104
	retlw	101
	retlw	105
	retlw	103
	retlw	104
	retlw	116
	retlw	58
	retlw	32
	retlw	49
	retlw	56
	retlw	112
	retlw	120
	retlw	59
	retlw	34
	retlw	62
	retlw	60
	retlw	115
	retlw	109
	retlw	97
	retlw	108
	retlw	108
	retlw	62
	retlw	60
	retlw	115
	retlw	109
	retlw	97
	retlw	108
	retlw	108
	retlw	62
	retlw	71
	retlw	114
	retlw	101
	retlw	97
	retlw	116
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
	retlw	69
	retlw	78
	retlw	67
	retlw	50
	retlw	56
	retlw	74
	retlw	54
	retlw	48
	retlw	32
	retlw	77
	retlw	105
	retlw	110
	retlw	105
	retlw	32
	retlw	87
	retlw	101
	retlw	98
	retlw	32
	retlw	83
	retlw	101
	retlw	114
	retlw	118
	retlw	101
	retlw	114
	retlw	60
	retlw	47
	retlw	115
	retlw	109
	retlw	97
	retlw	108
	retlw	108
	retlw	62
	retlw	60
	retlw	47
	retlw	115
	retlw	109
	retlw	97
	retlw	108
	retlw	108
	retlw	62
	retlw	60
	retlw	47
	retlw	104
	retlw	49
	retlw	62
	retlw	60
	retlw	115
	retlw	109
	retlw	97
	retlw	108
	retlw	108
	retlw	62
	retlw	60
	retlw	97
	retlw	32
	retlw	115
	retlw	116
	retlw	121
	retlw	108
	retlw	101
	retlw	61
	retlw	34
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
	retlw	72
	retlw	101
	retlw	108
	retlw	118
	retlw	101
	retlw	116
	retlw	105
	retlw	99
	retlw	97
	retlw	44
	retlw	65
	retlw	114
	retlw	105
	retlw	97
	retlw	108
	retlw	44
	retlw	115
	retlw	97
	retlw	110
	retlw	115
	retlw	45
	retlw	115
	retlw	101
	retlw	114
	retlw	105
	retlw	102
	retlw	59
	retlw	32
	retlw	102
	retlw	111
	retlw	110
	retlw	116
	retlw	45
	retlw	119
	retlw	101
	retlw	105
	retlw	103
	retlw	104
	retlw	116
	retlw	58
	retlw	32
	retlw	98
	retlw	111
	retlw	108
	retlw	100
	retlw	59
	retlw	34
	retlw	32
	retlw	104
	retlw	114
	retlw	101
	retlw	102
	retlw	61
	retlw	34
	retlw	47
	retlw	34
	retlw	62
	retlw	82
	retlw	101
	retlw	108
	retlw	111
	retlw	97
	retlw	100
	retlw	60
	retlw	47
	retlw	97
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
	retlw	99
	retlw	114
	retlw	105
	retlw	112
	retlw	116
	retlw	32
	retlw	115
	retlw	114
	retlw	99
	retlw	61
	retlw	34
	retlw	47
	retlw	115
	retlw	34
	retlw	62
	retlw	60
	retlw	47
	retlw	115
	retlw	99
	retlw	114
	retlw	105
	retlw	112
	retlw	116
	retlw	62
	retlw	60
	retlw	47
	retlw	115
	retlw	109
	retlw	97
	retlw	108
	retlw	108
	retlw	62
	retlw	60
	retlw	116
	retlw	97
	retlw	98
	retlw	108
	retlw	101
	retlw	32
	retlw	115
	retlw	116
	retlw	121
	retlw	108
	retlw	101
	retlw	61
	retlw	34
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
	retlw	72
	retlw	101
	retlw	108
	retlw	118
	retlw	101
	retlw	116
	retlw	105
	retlw	99
	retlw	97
	retlw	44
	retlw	65
	retlw	114
	retlw	105
	retlw	97
	retlw	108
	retlw	44
	retlw	115
	retlw	97
	retlw	110
	retlw	115
	retlw	45
	retlw	115
	retlw	101
	retlw	114
	retlw	105
	retlw	102
	retlw	59
	retlw	34
	retlw	62
	retlw	60
	retlw	116
	retlw	98
	retlw	111
	retlw	100
	retlw	121
	retlw	62
	retlw	60
	retlw	116
	retlw	114
	retlw	62
	retlw	60
	retlw	116
	retlw	100
	retlw	32
	retlw	118
	retlw	97
	retlw	108
	retlw	105
	retlw	103
	retlw	110
	retlw	61
	retlw	34
	retlw	116
	retlw	111
	retlw	112
	retlw	34
	retlw	62
	retlw	60
	retlw	115
	retlw	109
	retlw	97
	retlw	108
	retlw	108
	retlw	62
	retlw	60
	retlw	47
	retlw	115
	retlw	109
	retlw	97
	retlw	108
	retlw	108
	retlw	62
	retlw	60
	retlw	116
	retlw	97
	retlw	98
	retlw	108
	retlw	101
	retlw	32
	retlw	115
	retlw	116
	retlw	121
	retlw	108
	retlw	101
	retlw	61
	retlw	34
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
	retlw	50
	retlw	48
	retlw	112
	retlw	120
	retlw	59
	retlw	34
	retlw	32
	retlw	116
	retlw	101
	retlw	114
	retlw	109
	retlw	105
	retlw	110
	retlw	97
	retlw	108
	retlw	61
	retlw	34
	retlw	34
	retlw	32
	retlw	98
	retlw	111
	retlw	114
	retlw	100
	retlw	101
	retlw	114
	retlw	61
	retlw	34
	retlw	49
	retlw	34
	retlw	62
	retlw	60
	retlw	116
	retlw	98
	retlw	111
	retlw	100
	retlw	121
	retlw	62
	retlw	60
	retlw	116
	retlw	114
	retlw	62
	retlw	60
	retlw	116
	retlw	104
	retlw	32
	retlw	99
	retlw	111
	retlw	108
	retlw	115
	retlw	112
	retlw	97
	retlw	110
	retlw	61
	retlw	34
	retlw	50
	retlw	34
	retlw	62
	retlw	60
	retlw	115
	retlw	109
	retlw	97
	retlw	108
	retlw	108
	retlw	62
	retlw	65
	retlw	68
	retlw	67
	retlw	60
	retlw	47
	retlw	115
	retlw	109
	retlw	97
	retlw	108
	retlw	108
	retlw	62
	retlw	60
	retlw	47
	retlw	116
	retlw	104
	retlw	62
	retlw	60
	retlw	47
	retlw	116
	retlw	114
	retlw	62
	retlw	60
	retlw	116
	retlw	114
	retlw	62
	retlw	60
	retlw	116
	retlw	100
	retlw	32
	retlw	115
	retlw	116
	retlw	121
	retlw	108
	retlw	101
	retlw	61
	retlw	34
	retlw	102
	retlw	111
	retlw	110
	retlw	116
	retlw	45
	retlw	119
	retlw	101
	retlw	105
	retlw	103
	retlw	104
	retlw	116
	retlw	58
	retlw	32
	retlw	98
	retlw	111
	retlw	108
	retlw	100
	retlw	59
	retlw	34
	retlw	62
	retlw	60
	retlw	115
	retlw	109
	retlw	97
	retlw	108
	retlw	108
	retlw	62
	retlw	65
	retlw	78
	retlw	52
	retlw	60
	retlw	47
	retlw	115
	retlw	109
	retlw	97
	retlw	108
	retlw	108
	retlw	62
	retlw	60
	retlw	47
	retlw	116
	retlw	100
	retlw	62
	retlw	60
	retlw	116
	retlw	100
	retlw	32
	retlw	115
	retlw	116
	retlw	121
	retlw	108
	retlw	101
	retlw	61
	retlw	34
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
	retlw	114
	retlw	105
	retlw	103
	retlw	104
	retlw	116
	retlw	59
	retlw	32
	retlw	119
	retlw	105
	retlw	100
	retlw	116
	retlw	104
	retlw	58
	retlw	32
	retlw	51
	retlw	50
	retlw	112
	retlw	120
	retlw	59
	retlw	34
	retlw	62
	retlw	60
	retlw	115
	retlw	109
	retlw	97
	retlw	108
	retlw	108
	retlw	62
	retlw	60
	retlw	115
	retlw	99
	retlw	114
	retlw	105
	retlw	112
	retlw	116
	retlw	62
	retlw	118
	retlw	97
	retlw	114
	retlw	32
	retlw	65
	retlw	78
	retlw	52
	retlw	95
	retlw	71
	retlw	67
	retlw	66
	retlw	95
	retlw	83
	retlw	84
	retlw	82
	retlw	73
	retlw	78
	retlw	71
	retlw	32
	retlw	61
	retlw	32
	retlw	34
	retlw	0
	retlw	34
	retlw	59
	retlw	100
	retlw	111
	retlw	99
	retlw	117
	retlw	109
	retlw	101
	retlw	110
	retlw	116
	retlw	46
	retlw	119
	retlw	114
	retlw	105
	retlw	116
	retlw	101
	retlw	40
	retlw	65
	retlw	78
	retlw	52
	retlw	95
	retlw	71
	retlw	67
	retlw	66
	retlw	95
	retlw	83
	retlw	84
	retlw	82
	retlw	73
	retlw	78
	retlw	71
	retlw	41
	retlw	60
	retlw	47
	retlw	115
	retlw	99
	retlw	114
	retlw	105
	retlw	112
	retlw	116
	retlw	62
	retlw	60
	retlw	47
	retlw	115
	retlw	109
	retlw	97
	retlw	108
	retlw	108
	retlw	62
	retlw	60
	retlw	47
	retlw	116
	retlw	100
	retlw	62
	retlw	60
	retlw	47
	retlw	116
	retlw	114
	retlw	62
	retlw	60
	retlw	116
	retlw	114
	retlw	62
	retlw	60
	retlw	116
	retlw	100
	retlw	32
	retlw	115
	retlw	116
	retlw	121
	retlw	108
	retlw	101
	retlw	61
	retlw	34
	retlw	102
	retlw	111
	retlw	110
	retlw	116
	retlw	45
	retlw	119
	retlw	101
	retlw	105
	retlw	103
	retlw	104
	retlw	116
	retlw	58
	retlw	32
	retlw	98
	retlw	111
	retlw	108
	retlw	100
	retlw	59
	retlw	34
	retlw	62
	retlw	60
	retlw	115
	retlw	109
	retlw	97
	retlw	108
	retlw	108
	retlw	62
	retlw	65
	retlw	78
	retlw	51
	retlw	60
	retlw	47
	retlw	115
	retlw	109
	retlw	97
	retlw	108
	retlw	108
	retlw	62
	retlw	60
	retlw	47
	retlw	116
	retlw	100
	retlw	62
	retlw	60
	retlw	116
	retlw	100
	retlw	32
	retlw	115
	retlw	116
	retlw	121
	retlw	108
	retlw	101
	retlw	61
	retlw	34
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
	retlw	114
	retlw	105
	retlw	103
	retlw	104
	retlw	116
	retlw	59
	retlw	34
	retlw	62
	retlw	60
	retlw	115
	retlw	109
	retlw	97
	retlw	108
	retlw	108
	retlw	62
	retlw	60
	retlw	115
	retlw	99
	retlw	114
	retlw	105
	retlw	112
	retlw	116
	retlw	62
	retlw	118
	retlw	97
	retlw	114
	retlw	32
	retlw	65
	retlw	78
	retlw	51
	retlw	95
	retlw	71
	retlw	67
	retlw	66
	retlw	95
	retlw	83
	retlw	84
	retlw	82
	retlw	73
	retlw	78
	retlw	71
	retlw	32
	retlw	61
	retlw	32
	retlw	34
	retlw	0
	retlw	34
	retlw	59
	retlw	100
	retlw	111
	retlw	99
	retlw	117
	retlw	109
	retlw	101
	retlw	110
	retlw	116
	retlw	46
	retlw	119
	retlw	114
	retlw	105
	retlw	116
	retlw	101
	retlw	40
	retlw	65
	retlw	78
	retlw	51
	retlw	95
	retlw	71
	retlw	67
	retlw	66
	retlw	95
	retlw	83
	retlw	84
	retlw	82
	retlw	73
	retlw	78
	retlw	71
	retlw	41
	retlw	60
	retlw	47
	retlw	115
	retlw	99
	retlw	114
	retlw	105
	retlw	112
	retlw	116
	retlw	62
	retlw	60
	retlw	47
	retlw	115
	retlw	109
	retlw	97
	retlw	108
	retlw	108
	retlw	62
	retlw	60
	retlw	47
	retlw	116
	retlw	100
	retlw	62
	retlw	60
	retlw	47
	retlw	116
	retlw	114
	retlw	62
	retlw	60
	retlw	47
	retlw	116
	retlw	98
	retlw	111
	retlw	100
	retlw	121
	retlw	62
	retlw	60
	retlw	47
	retlw	116
	retlw	97
	retlw	98
	retlw	108
	retlw	101
	retlw	62
	retlw	60
	retlw	47
	retlw	116
	retlw	100
	retlw	62
	retlw	60
	retlw	116
	retlw	100
	retlw	62
	retlw	60
	retlw	115
	retlw	109
	retlw	97
	retlw	108
	retlw	108
	retlw	62
	retlw	60
	retlw	47
	retlw	115
	retlw	109
	retlw	97
	retlw	108
	retlw	108
	retlw	62
	retlw	60
	retlw	116
	retlw	97
	retlw	98
	retlw	108
	retlw	101
	retlw	32
	retlw	115
	retlw	116
	retlw	121
	retlw	108
	retlw	101
	retlw	61
	retlw	34
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
	retlw	50
	retlw	48
	retlw	112
	retlw	120
	retlw	59
	retlw	34
	retlw	32
	retlw	59
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
	retlw	61
	retlw	34
	retlw	34
	retlw	32
	retlw	116
	retlw	101
	retlw	114
	retlw	109
	retlw	105
	retlw	110
	retlw	97
	retlw	108
	retlw	61
	retlw	34
	retlw	34
	retlw	32
	retlw	59
	retlw	61
	retlw	34
	retlw	34
	retlw	32
	retlw	98
	retlw	111
	retlw	114
	retlw	100
	retlw	101
	retlw	114
	retlw	61
	retlw	34
	retlw	49
	retlw	34
	retlw	62
	retlw	60
	retlw	116
	retlw	98
	retlw	111
	retlw	100
	retlw	121
	retlw	62
	retlw	60
	retlw	116
	retlw	114
	retlw	62
	retlw	60
	retlw	116
	retlw	104
	retlw	32
	retlw	99
	retlw	111
	retlw	108
	retlw	115
	retlw	112
	retlw	97
	retlw	110
	retlw	61
	retlw	34
	retlw	50
	retlw	34
	retlw	62
	retlw	60
	retlw	115
	retlw	109
	retlw	97
	retlw	108
	retlw	108
	retlw	62
	retlw	80
	retlw	79
	retlw	82
	retlw	84
	retlw	67
	retlw	60
	retlw	47
	retlw	115
	retlw	109
	retlw	97
	retlw	108
	retlw	108
	retlw	62
	retlw	60
	retlw	47
	retlw	116
	retlw	104
	retlw	62
	retlw	60
	retlw	47
	retlw	116
	retlw	114
	retlw	62
	retlw	60
	retlw	115
	retlw	99
	retlw	114
	retlw	105
	retlw	112
	retlw	116
	retlw	62
	retlw	118
	retlw	97
	retlw	114
	retlw	32
	retlw	115
	retlw	116
	retlw	114
	retlw	44
	retlw	105
	retlw	44
	retlw	80
	retlw	79
	retlw	82
	retlw	84
	retlw	67
	retlw	95
	retlw	71
	retlw	67
	retlw	66
	retlw	95
	retlw	66
	retlw	89
	retlw	84
	retlw	69
	retlw	44
	retlw	32
	retlw	82
	retlw	69
	retlw	81
	retlw	59
	retlw	82
	retlw	69
	retlw	81
	retlw	61
	retlw	48
	retlw	59
	retlw	80
	retlw	79
	retlw	82
	retlw	84
	retlw	67
	retlw	95
	retlw	71
	retlw	67
	retlw	66
	retlw	95
	retlw	66
	retlw	89
	retlw	84
	retlw	69
	retlw	32
	retlw	61
	retlw	0
	retlw	59
	retlw	115
	retlw	116
	retlw	114
	retlw	61
	retlw	34
	retlw	34
	retlw	59
	retlw	102
	retlw	111
	retlw	114
	retlw	40
	retlw	105
	retlw	61
	retlw	48
	retlw	59
	retlw	105
	retlw	60
	retlw	56
	retlw	59
	retlw	105
	retlw	43
	retlw	43
	retlw	41
	retlw	123
	retlw	115
	retlw	116
	retlw	114
	retlw	43
	retlw	61
	retlw	34
	retlw	60
	retlw	116
	retlw	114
	retlw	62
	retlw	60
	retlw	116
	retlw	100
	retlw	32
	retlw	98
	retlw	103
	retlw	99
	retlw	111
	retlw	108
	retlw	111
	retlw	114
	retlw	61
	retlw	112
	retlw	105
	retlw	110
	retlw	107
	retlw	62
	retlw	66
	retlw	85
	retlw	84
	retlw	84
	retlw	79
	retlw	78
	retlw	32
	retlw	35
	retlw	34
	retlw	43
	retlw	105
	retlw	43
	retlw	34
	retlw	60
	retlw	47
	retlw	116
	retlw	100
	retlw	62
	retlw	34
	retlw	59
	retlw	105
	retlw	102
	retlw	40
	retlw	80
	retlw	79
	retlw	82
	retlw	84
	retlw	67
	retlw	95
	retlw	71
	retlw	67
	retlw	66
	retlw	95
	retlw	66
	retlw	89
	retlw	84
	retlw	69
	retlw	38
	retlw	40
	retlw	49
	retlw	60
	retlw	60
	retlw	105
	retlw	41
	retlw	41
	retlw	123
	retlw	32
	retlw	32
	retlw	115
	retlw	116
	retlw	114
	retlw	43
	retlw	61
	retlw	34
	retlw	60
	retlw	116
	retlw	100
	retlw	32
	retlw	98
	retlw	103
	retlw	99
	retlw	111
	retlw	108
	retlw	111
	retlw	114
	retlw	61
	retlw	114
	retlw	101
	retlw	100
	retlw	62
	retlw	79
	retlw	78
	retlw	34
	retlw	59
	retlw	32
	retlw	32
	retlw	125
	retlw	101
	retlw	108
	retlw	115
	retlw	101
	retlw	32
	retlw	123
	retlw	115
	retlw	116
	retlw	114
	retlw	43
	retlw	61
	retlw	34
	retlw	60
	retlw	116
	retlw	100
	retlw	32
	retlw	98
	retlw	103
	retlw	99
	retlw	111
	retlw	108
	retlw	111
	retlw	114
	retlw	61
	retlw	35
	retlw	99
	retlw	99
	retlw	99
	retlw	99
	retlw	99
	retlw	99
	retlw	62
	retlw	79
	retlw	70
	retlw	70
	retlw	34
	retlw	59
	retlw	125
	retlw	115
	retlw	116
	retlw	114
	retlw	43
	retlw	61
	retlw	34
	retlw	60
	retlw	47
	retlw	116
	retlw	100
	retlw	62
	retlw	60
	retlw	47
	retlw	116
	retlw	114
	retlw	62
	retlw	34
	retlw	59
	retlw	125
	retlw	100
	retlw	111
	retlw	99
	retlw	117
	retlw	109
	retlw	101
	retlw	110
	retlw	116
	retlw	46
	retlw	119
	retlw	114
	retlw	105
	retlw	116
	retlw	101
	retlw	40
	retlw	115
	retlw	116
	retlw	114
	retlw	41
	retlw	32
	retlw	59
	retlw	60
	retlw	47
	retlw	115
	retlw	99
	retlw	114
	retlw	105
	retlw	112
	retlw	116
	retlw	62
	retlw	60
	retlw	47
	retlw	116
	retlw	98
	retlw	111
	retlw	100
	retlw	121
	retlw	62
	retlw	60
	retlw	47
	retlw	116
	retlw	97
	retlw	98
	retlw	108
	retlw	101
	retlw	62
	retlw	60
	retlw	47
	retlw	116
	retlw	100
	retlw	62
	retlw	60
	retlw	116
	retlw	100
	retlw	62
	retlw	60
	retlw	115
	retlw	109
	retlw	97
	retlw	108
	retlw	108
	retlw	62
	retlw	60
	retlw	47
	retlw	115
	retlw	109
	retlw	97
	retlw	108
	retlw	108
	retlw	62
	retlw	60
	retlw	116
	retlw	97
	retlw	98
	retlw	108
	retlw	101
	retlw	32
	retlw	115
	retlw	116
	retlw	121
	retlw	108
	retlw	101
	retlw	61
	retlw	34
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
	retlw	50
	retlw	48
	retlw	112
	retlw	120
	retlw	59
	retlw	34
	retlw	32
	retlw	59
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
	retlw	61
	retlw	34
	retlw	34
	retlw	32
	retlw	116
	retlw	101
	retlw	114
	retlw	109
	retlw	105
	retlw	110
	retlw	97
	retlw	108
	retlw	61
	retlw	34
	retlw	34
	retlw	32
	retlw	59
	retlw	61
	retlw	34
	retlw	34
	retlw	32
	retlw	98
	retlw	111
	retlw	114
	retlw	100
	retlw	101
	retlw	114
	retlw	61
	retlw	34
	retlw	49
	retlw	34
	retlw	62
	retlw	60
	retlw	116
	retlw	98
	retlw	111
	retlw	100
	retlw	121
	retlw	62
	retlw	60
	retlw	116
	retlw	114
	retlw	62
	retlw	60
	retlw	116
	retlw	104
	retlw	32
	retlw	99
	retlw	111
	retlw	108
	retlw	115
	retlw	112
	retlw	97
	retlw	110
	retlw	61
	retlw	34
	retlw	51
	retlw	34
	retlw	62
	retlw	60
	retlw	115
	retlw	109
	retlw	97
	retlw	108
	retlw	108
	retlw	62
	retlw	80
	retlw	79
	retlw	82
	retlw	84
	retlw	66
	retlw	60
	retlw	47
	retlw	115
	retlw	109
	retlw	97
	retlw	108
	retlw	108
	retlw	62
	retlw	60
	retlw	47
	retlw	116
	retlw	104
	retlw	62
	retlw	60
	retlw	47
	retlw	116
	retlw	114
	retlw	62
	retlw	60
	retlw	115
	retlw	99
	retlw	114
	retlw	105
	retlw	112
	retlw	116
	retlw	62
	retlw	118
	retlw	97
	retlw	114
	retlw	32
	retlw	115
	retlw	116
	retlw	114
	retlw	44
	retlw	105
	retlw	44
	retlw	80
	retlw	79
	retlw	82
	retlw	84
	retlw	66
	retlw	95
	retlw	71
	retlw	67
	retlw	66
	retlw	95
	retlw	66
	retlw	89
	retlw	84
	retlw	69
	retlw	59
	retlw	82
	retlw	69
	retlw	81
	retlw	43
	retlw	43
	retlw	59
	retlw	80
	retlw	79
	retlw	82
	retlw	84
	retlw	66
	retlw	95
	retlw	71
	retlw	67
	retlw	66
	retlw	95
	retlw	66
	retlw	89
	retlw	84
	retlw	69
	retlw	32
	retlw	61
	retlw	0
	retlw	59
	retlw	115
	retlw	116
	retlw	114
	retlw	61
	retlw	34
	retlw	34
	retlw	59
	retlw	102
	retlw	111
	retlw	114
	retlw	40
	retlw	105
	retlw	61
	retlw	48
	retlw	59
	retlw	105
	retlw	60
	retlw	56
	retlw	59
	retlw	105
	retlw	43
	retlw	43
	retlw	41
	retlw	123
	retlw	115
	retlw	116
	retlw	114
	retlw	43
	retlw	61
	retlw	34
	retlw	60
	retlw	116
	retlw	114
	retlw	62
	retlw	60
	retlw	116
	retlw	100
	retlw	32
	retlw	98
	retlw	103
	retlw	99
	retlw	111
	retlw	108
	retlw	111
	retlw	114
	retlw	61
	retlw	121
	retlw	101
	retlw	108
	retlw	108
	retlw	111
	retlw	119
	retlw	62
	retlw	76
	retlw	69
	retlw	68
	retlw	32
	retlw	35
	retlw	34
	retlw	43
	retlw	105
	retlw	43
	retlw	34
	retlw	60
	retlw	47
	retlw	116
	retlw	100
	retlw	62
	retlw	34
	retlw	59
	retlw	105
	retlw	102
	retlw	40
	retlw	80
	retlw	79
	retlw	82
	retlw	84
	retlw	66
	retlw	95
	retlw	71
	retlw	67
	retlw	66
	retlw	95
	retlw	66
	retlw	89
	retlw	84
	retlw	69
	retlw	38
	retlw	40
	retlw	49
	retlw	60
	retlw	60
	retlw	105
	retlw	41
	retlw	41
	retlw	123
	retlw	32
	retlw	32
	retlw	115
	retlw	116
	retlw	114
	retlw	43
	retlw	61
	retlw	34
	retlw	60
	retlw	116
	retlw	100
	retlw	32
	retlw	98
	retlw	103
	retlw	99
	retlw	111
	retlw	108
	retlw	111
	retlw	114
	retlw	61
	retlw	114
	retlw	101
	retlw	100
	retlw	62
	retlw	79
	retlw	78
	retlw	34
	retlw	59
	retlw	32
	retlw	32
	retlw	125
	retlw	101
	retlw	108
	retlw	115
	retlw	101
	retlw	32
	retlw	123
	retlw	115
	retlw	116
	retlw	114
	retlw	43
	retlw	61
	retlw	34
	retlw	60
	retlw	116
	retlw	100
	retlw	32
	retlw	98
	retlw	103
	retlw	99
	retlw	111
	retlw	108
	retlw	111
	retlw	114
	retlw	61
	retlw	35
	retlw	99
	retlw	99
	retlw	99
	retlw	99
	retlw	99
	retlw	99
	retlw	62
	retlw	79
	retlw	70
	retlw	70
	retlw	34
	retlw	59
	retlw	125
	retlw	115
	retlw	116
	retlw	114
	retlw	43
	retlw	61
	retlw	34
	retlw	60
	retlw	47
	retlw	116
	retlw	100
	retlw	62
	retlw	60
	retlw	116
	retlw	100
	retlw	62
	retlw	60
	retlw	97
	retlw	32
	retlw	104
	retlw	114
	retlw	101
	retlw	102
	retlw	61
	retlw	47
	retlw	116
	retlw	34
	retlw	43
	retlw	105
	retlw	43
	retlw	34
	retlw	62
	retlw	84
	retlw	111
	retlw	103
	retlw	103
	retlw	108
	retlw	101
	retlw	60
	retlw	47
	retlw	97
	retlw	62
	retlw	60
	retlw	47
	retlw	116
	retlw	100
	retlw	62
	retlw	60
	retlw	47
	retlw	116
	retlw	114
	retlw	62
	retlw	34
	retlw	59
	retlw	125
	retlw	100
	retlw	111
	retlw	99
	retlw	117
	retlw	109
	retlw	101
	retlw	110
	retlw	116
	retlw	46
	retlw	119
	retlw	114
	retlw	105
	retlw	116
	retlw	101
	retlw	40
	retlw	115
	retlw	116
	retlw	114
	retlw	41
	retlw	32
	retlw	59
	retlw	60
	retlw	47
	retlw	115
	retlw	99
	retlw	114
	retlw	105
	retlw	112
	retlw	116
	retlw	62
	retlw	60
	retlw	47
	retlw	116
	retlw	98
	retlw	111
	retlw	100
	retlw	121
	retlw	62
	retlw	60
	retlw	47
	retlw	116
	retlw	97
	retlw	98
	retlw	108
	retlw	101
	retlw	62
	retlw	60
	retlw	47
	retlw	116
	retlw	100
	retlw	62
	retlw	60
	retlw	47
	retlw	116
	retlw	114
	retlw	62
	retlw	60
	retlw	47
	retlw	116
	retlw	98
	retlw	111
	retlw	100
	retlw	121
	retlw	62
	retlw	60
	retlw	47
	retlw	116
	retlw	97
	retlw	98
	retlw	108
	retlw	101
	retlw	62

;********************************************************************************

;Start of program memory page 2
	ORG	4096
;Start of program memory page 3
	ORG	6144

 END
