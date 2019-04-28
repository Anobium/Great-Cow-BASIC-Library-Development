;Program compiled by Great Cow BASIC (0.95 2016-03-13)
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F877A, r=DEC
#include <P16F877A.inc>
 __CONFIG _LVP_OFF & _WDTE_OFF & _FOSC_XT

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
SysWaitTempS	EQU	116
CHR	EQU	453
HTMLMAPPING	EQU	447
HTMLMAPPINGTYPE	EQU	441
ADN_PORT	EQU	32
ADREADPORT	EQU	33
COMPORT	EQU	34
HTMLELEMENTTRACKER	EQU	35
INBYTE	EQU	36
OUTVALUETEMP	EQU	37
PRINTLEN	EQU	38
READAD10	EQU	39
READAD10_H	EQU	40
SERDATA	EQU	42
SERPRINTVAL	EQU	43
SYSBITVAR0	EQU	44
SYSCHAR	EQU	45
SYSPRINTTEMP	EQU	46
SysPRINTDATAHandler	EQU	47
SysPRINTDATAHandler_H	EQU	48
SysTemp1	EQU	49
SysTemp1_H	EQU	50
SysTemp2	EQU	51
TABLELOC	EQU	52
TABLELOC_H	EQU	53

;********************************************************************************

;Alias variables
SYSCHR_0	EQU	453
SYSCHR_1	EQU	454
SYSHTMLMAPPINGTYPE_1	EQU	442
SYSHTMLMAPPINGTYPE_2	EQU	443
SYSHTMLMAPPINGTYPE_3	EQU	444
SYSHTMLMAPPINGTYPE_4	EQU	445
SYSHTMLMAPPINGTYPE_5	EQU	446
SYSHTMLMAPPING_1	EQU	448
SYSHTMLMAPPING_2	EQU	449
SYSHTMLMAPPING_3	EQU	450
SYSHTMLMAPPING_4	EQU	451
SYSHTMLMAPPING_5	EQU	452

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
;#define USART_BAUD_RATE 9600
;#define USART_BLOCKING
;#define debug
;#define AN2_GCB_HTML          HTMLMapping(1)
;#define AN3_GCB_HTML          HTMLMapping(2)
;#define PAGECOUNT_GCB_HTML    HTMLMapping(3)
;#define PORTC_GCB_HTML        HTMLMapping(4)
;#define PORTB_GCB_HTML        HTMLMapping(5)
;dir porta.0 in          'switch
	banksel	TRISA
	bsf	TRISA,0
;dir porta.2 in          'adc2
	bsf	TRISA,2
;dir porta.3 in          'adc3
	bsf	TRISA,3
;dir portc Out           'led array
	clrf	TRISC
;dir portd Out           'led array
	clrf	TRISD
;dim TableLoc as Word
;do Forever
SysDoLoop_S1
;readtable gray_code, ( ReadAD10 ( AN2 ) / 64 ), AN2_GCB_HTML      'This maps to the first element in the array... but, we use the constant! Easier.
	movlw	2
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
;AN2_GCB_HTML = AN2_GCB_HTML & 0x0F
	movlw	15
	andwf	SYSHTMLMAPPING_1,F
;AN3_GCB_HTML = AN3_GCB_HTML & 0x0F
	movlw	15
	andwf	SYSHTMLMAPPING_2,F
;portc = AN2_GCB_HTML
	movf	SYSHTMLMAPPING_1,W
	banksel	PORTC
	movwf	PORTC
;portd = AN3_GCB_HTML
	banksel	SYSHTMLMAPPING_2
	movf	SYSHTMLMAPPING_2,W
	banksel	PORTD
	movwf	PORTD
;PORTC_GCB_HTML = portc   'portc
	movf	PORTC,W
	banksel	SYSHTMLMAPPING_4
	movwf	SYSHTMLMAPPING_4
;PORTB_GCB_HTML = portd   'portd
	banksel	PORTD
	movf	PORTD,W
	banksel	SYSHTMLMAPPING_5
	movwf	SYSHTMLMAPPING_5
;if porta.0 = 1 then DisplayHTMLPage
	banksel	PORTA
	btfsc	PORTA,0
	call	DISPLAYHTMLPAGE
;loop
	goto	SysDoLoop_S1
SysDoLoop_E1
;end
	goto	BASPROGRAMEND
	movlw	1
	banksel	SYSHTMLMAPPINGTYPE_1
	movwf	SYSHTMLMAPPINGTYPE_1
	movlw	255
	movwf	SYSHTMLMAPPING_1
	movlw	1
	movwf	SYSHTMLMAPPINGTYPE_2
	clrf	SYSHTMLMAPPING_2
	clrf	SYSHTMLMAPPINGTYPE_3
	clrf	SYSHTMLMAPPING_3
	clrf	SYSHTMLMAPPINGTYPE_4
	movlw	170
	movwf	SYSHTMLMAPPING_4
	clrf	SYSHTMLMAPPINGTYPE_5
	movlw	85
	movwf	SYSHTMLMAPPING_5
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
;PAGECOUNT_GCB_HTML++
	banksel	SYSHTMLMAPPING_3
	incf	SYSHTMLMAPPING_3,F
;for TableLoc = 1 to SizeofTable1
	banksel	TABLELOC
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
	movlw	214
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
	movlw	111
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
	movlw	2
	movwf	DELAYTEMP
DelayUS0
	decfsz	DELAYTEMP,F
	goto	DelayUS0
	decfsz	SysWaitTemp10US, F
	goto	D10US_START
	return

;********************************************************************************

Delay_MS
	incf	SysWaitTempMS_H, F
DMS_START
	movlw	142
	movwf	DELAYTEMP2
DMS_OUTER
	movlw	1
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

Delay_S
DS_START
	movlw	232
	movwf	SysWaitTempMS
	movlw	3
	movwf	SysWaitTempMS_H
	call	Delay_MS
	decfsz	SysWaitTempS, F
	goto	DS_START
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
	movlw	high TableGRAY_CODE
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
	movwf	FSR
	bcf	STATUS, IRP
	btfsc	SysPRINTDATAHandler_H,0
	bsf	STATUS, IRP
	movf	INDF,W
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
	movwf	FSR
	bcf	STATUS, IRP
	btfsc	SysPRINTDATAHandler_H,0
	bsf	STATUS, IRP
	movf	INDF,W
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
	btfss	PIR1,TXIF
	goto	SysWaitLoop2
;TXREG = SerData
	movf	SERDATA,W
	movwf	TXREG
;end if
ENDIF20
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
	movlw	high TableINDEX1_H
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
	movlw	112
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableINDEX2
	movwf	SysStringA
	movlw	high TableINDEX2
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableINDEX2
	retlw	111
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
	retlw	95
	retlw	71
	retlw	67
	retlw	66
	retlw	95
	retlw	66
	retlw	89
	retlw	84
	retlw	69
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
;SET ADFM OFF
	banksel	ADCON1
	bcf	ADCON1,ADFM
;SET ADCON0.ADON OFF
	banksel	ADCON0
	bcf	ADCON0,ADON
;SET PCFG3 OFF
	banksel	ADCON1
	bcf	ADCON1,PCFG3
;SET PCFG2 ON
	bsf	ADCON1,PCFG2
;SET PCFG1 ON
	bsf	ADCON1,PCFG1
;SET PCFG0 OFF
	bcf	ADCON1,PCFG0
;CMCON = 7
	movlw	7
	movwf	CMCON
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
	movlw	25
	banksel	SPBRG
	movwf	SPBRG
;BRGH = BRGH_TEMP
	bsf	TXSTA,BRGH
;Set SYNC Off
	bcf	TXSTA,SYNC
;Set SPEN On
	banksel	RCSTA
	bsf	RCSTA,SPEN
;Set CREN On
	bsf	RCSTA,CREN
;Set TXEN On
	banksel	TXSTA
	bsf	TXSTA,TXEN
;PIC USART 2 Init
	banksel	STATUS
	return

;********************************************************************************

OUTPUTHTMLVARIABLE
;if inByte = 0 then
	movf	INBYTE,F
	btfss	STATUS, Z
	goto	ELSE4_1
;if HTMLMappingType(HTMLElementTracker) = StringVar then
	movlw	low(HTMLMAPPINGTYPE)
	addwf	HTMLELEMENTTRACKER,W
	movwf	FSR
	bankisel	HTMLMAPPINGTYPE
	decf	INDF,W
	btfss	STATUS, Z
	goto	ELSE5_1
;HserPrint HTMLMapping(HTMLElementTracker)
	movlw	low(HTMLMAPPING)
	addwf	HTMLELEMENTTRACKER,W
	movwf	FSR
	bankisel	HTMLMAPPING
	movf	INDF,W
	movwf	SERPRINTVAL
	movlw	1
	movwf	COMPORT
	call	HSERPRINT217
;else
	goto	ENDIF5
ELSE5_1
;HserPrint HTMLMapping(HTMLElementTracker)
	movlw	low(HTMLMAPPING)
	addwf	HTMLELEMENTTRACKER,W
	movwf	FSR
	bankisel	HTMLMAPPING
	movf	INDF,W
	movwf	SERPRINTVAL
	movlw	1
	movwf	COMPORT
	call	HSERPRINT217
;end if
ENDIF5
;HTMLElementTracker++
	incf	HTMLELEMENTTRACKER,F
;wait 1 s
	movlw	1
	movwf	SysWaitTempS
	call	Delay_S
;Else
	goto	ENDIF4
ELSE4_1
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
ENDIF4
	return

;********************************************************************************

FN_READAD10
;SET ADFM ON
	banksel	ADCON1
	bsf	ADCON1,ADFM
;Do conversion
;LLReadAD 0
;SET PCFG3 OFF
	bcf	ADCON1,PCFG3
;SET PCFG2 OFF
	bcf	ADCON1,PCFG2
;SET PCFG1 OFF
	bcf	ADCON1,PCFG1
;SET PCFG0 OFF
	bcf	ADCON1,PCFG0
;SET ADCS1 OFF
	banksel	ADCON0
	bcf	ADCON0,ADCS1
;SET ADCS0 ON
	bsf	ADCON0,ADCS0
;SET ADCON0.CHS0 OFF
	bcf	ADCON0,CHS0
;SET ADCON0.CHS1 OFF
	bcf	ADCON0,CHS1
;SET ADCON0.CHS2 OFF
	bcf	ADCON0,CHS2
;IF ADReadPort.0 On Then Set ADCON0.CHS0 On
	btfsc	ADREADPORT,0
	bsf	ADCON0,CHS0
;IF ADReadPort.1 On Then Set ADCON0.CHS1 On
	btfsc	ADREADPORT,1
	bsf	ADCON0,CHS1
;IF ADReadPort.2 On Then Set ADCON0.CHS2 On
	btfsc	ADREADPORT,2
	bsf	ADCON0,CHS2
;SET ADCON0.ADON ON
	bsf	ADCON0,ADON
;Wait AD_Delay
	movlw	2
	movwf	SysWaitTemp10US
	call	Delay_10US
;SET ADCON0.GO_NOT_DONE ON
	bsf	ADCON0,GO_NOT_DONE
;nop
	nop
;	Wait While ADCON0.GO_NOT_DONE ON
SysWaitLoop1
	btfsc	ADCON0,GO_NOT_DONE
	goto	SysWaitLoop1
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON
;SET PCFG3 OFF
	banksel	ADCON1
	bcf	ADCON1,PCFG3
;SET PCFG2 ON
	bsf	ADCON1,PCFG2
;SET PCFG1 ON
	bsf	ADCON1,PCFG1
;SET PCFG0 OFF
	bcf	ADCON1,PCFG0
;ReadAD10 = ADRESL
	movf	ADRESL,W
	banksel	READAD10
	movwf	READAD10
	clrf	READAD10_H
;ReadAD10_H = ADRESH
	movf	ADRESH,W
	movwf	READAD10_H
;SET ADFM OFF
	banksel	ADCON1
	bcf	ADCON1,ADFM
	banksel	STATUS
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
	btfss	STATUS,C
	addlw	1
	subwf	SYSDIVMULTX_H,F
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
	btfsc	STATUS,C
	addlw	1
	addwf	SYSDIVMULTX_H,F
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
	movlw	215
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
	movlw	high TableINDEX1
	btfsc	STATUS, C
	addlw	1
	addwf	SysStringA_H, W
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableINDEX1
	retlw	214
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
	retlw	95
	retlw	71
	retlw	67
	retlw	66
	retlw	95
	retlw	66
	retlw	89
	retlw	84
	retlw	69
	retlw	61
	retlw	0
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
