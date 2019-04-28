;Program compiled by Great Cow BASIC (0.95 2016-02-24)
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F4520, r=DEC
#include <P18F4520.inc>
 CONFIG LVP = OFF, MCLRE = ON, WDT = OFF, OSC = HS

;********************************************************************************

;Set aside memory locations for variables
DELAYTEMP	EQU	0
DELAYTEMP2	EQU	1
SYSCALCTEMPX	EQU	0
SYSDIVMULTA	EQU	7
SYSDIVMULTA_H	EQU	8
SYSDIVMULTB	EQU	11
SYSDIVMULTB_H	EQU	12
SYSDIVMULTX	EQU	2
SYSDIVMULTX_H	EQU	3
SYSINTEGERTEMPA	EQU	5
SYSINTEGERTEMPA_H	EQU	6
SYSINTEGERTEMPB	EQU	9
SYSINTEGERTEMPB_H	EQU	10
SYSINTEGERTEMPX	EQU	0
SYSINTEGERTEMPX_H	EQU	1
SYSSIGNBYTE	EQU	13
SYSWORDTEMPX	EQU	0
SYSWORDTEMPX_H	EQU	1
SysBYTETempA	EQU	5
SysBYTETempB	EQU	9
SysByteTempX	EQU	0
SysDivLoop	EQU	4
SysStringA	EQU	7
SysStringA_H	EQU	8
SysWORDTempA	EQU	5
SysWORDTempA_H	EQU	6
SysWORDTempB	EQU	9
SysWORDTempB_H	EQU	10
SysWaitTemp10US	EQU	5
SysWaitTempMS	EQU	2
SysWaitTempMS_H	EQU	3
CHR	EQU	1493
HTMLMAPPING	EQU	1488
HTMLMAPPINGTYPE	EQU	1483
ADN_PORT	EQU	14
ADREADPORT	EQU	15
COMPORT	EQU	16
HTMLELEMENTTRACKER	EQU	17
INBYTE	EQU	18
OUTVALUETEMP	EQU	19
PRINTLEN	EQU	20
READAD10	EQU	21
READAD10_H	EQU	22
SERDATA	EQU	24
SERPRINTVAL	EQU	25
SYSCHAR	EQU	26
SYSPRINTTEMP	EQU	27
SysPRINTDATAHandler	EQU	28
SysPRINTDATAHandler_H	EQU	29
SysTemp1	EQU	30
SysTemp1_H	EQU	31
SysTemp2	EQU	32
TABLELOC	EQU	33
TABLELOC_H	EQU	34

;********************************************************************************

;Alias variables
AFSR0	EQU	4073
AFSR0_H	EQU	4074
SYSCHR_0	EQU	1493
SYSCHR_1	EQU	1494
SYSHTMLMAPPINGTYPE_1	EQU	1484
SYSHTMLMAPPINGTYPE_2	EQU	1485
SYSHTMLMAPPINGTYPE_3	EQU	1486
SYSHTMLMAPPINGTYPE_4	EQU	1487
SYSHTMLMAPPING_1	EQU	1489
SYSHTMLMAPPING_2	EQU	1490
SYSHTMLMAPPING_3	EQU	1491
SYSHTMLMAPPING_4	EQU	1492

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
	call	INITUSART
;Automatic pin direction setting
	bcf	TRISC,2,ACCESS

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
;#define USART_BAUD_RATE 9600
;#define USART_BLOCKING
;#define USART_TX_BLOCKING
;#Define Heartbeat 			PortC.2
;#Define TX 							PortC.7
;#Define RX							PortC.6
;#define AN6_GCB_HTML    HTMLMapping(1)					'AN4   ---> AN6
;#define AN4_GCB_HTML    HTMLMapping(2)					'AN3	 ---> AN4
;#define PORTB_GCB_HTML  HTMLMapping(3)					'PortC ---> PortB
;#define PORTD_GCB_HTML  HTMLMapping(4)					'PortB ---> PORTD
;dir porta.4 in          'switch
	bsf	TRISA,4,ACCESS
;dir porta.3 in          'adc3
	bsf	TRISA,3,ACCESS
;#define Potentiometer 	PORTE.1									' PortA.4  ---> PortE.1
;dir Potentiometer 	in
	bsf	TRISE,1,ACCESS
;dir PORTD Out           'led array
	clrf	TRISD,ACCESS
;dir PortB Out           'led array
	clrf	TRISB,ACCESS
;dim TableLoc as Word
;do Forever
SysDoLoop_S1
;PulseOut HeartBeat, 10 Ms
;Set Pin On
	bsf	LATC,2,ACCESS
;Wait Time
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	banksel	0
	rcall	Delay_MS
;Set Pin Off
	bcf	LATC,2,ACCESS
;Wait 100 Ms
	movlw	100
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;readtable gray_code, ( ReadAD10 ( AN6 ) / 64 ), AN6_GCB_HTML      'This maps to the first element in the array... but, we use the constant! Easier.
	movlw	6
	movwf	ADREADPORT,BANKED
	setf	ADN_PORT,BANKED
	call	FN_READAD10
	movff	READAD10,SysINTEGERTempA
	movff	READAD10_H,SysINTEGERTempA_H
	movlw	64
	movwf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SysDivSubINT
	movff	SysINTEGERTempA,SYSSTRINGA
	rcall	GRAY_CODE
	banksel	SYSHTMLMAPPING_1
	movwf	SYSHTMLMAPPING_1,BANKED
;readtable gray_code, ( ReadAD10 ( AN4 ) / 64 ), AN4_GCB_HTML
	movlw	4
	banksel	ADREADPORT
	movwf	ADREADPORT,BANKED
	setf	ADN_PORT,BANKED
	call	FN_READAD10
	movff	READAD10,SysINTEGERTempA
	movff	READAD10_H,SysINTEGERTempA_H
	movlw	64
	movwf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SysDivSubINT
	movff	SysINTEGERTempA,SYSSTRINGA
	rcall	GRAY_CODE
	banksel	SYSHTMLMAPPING_2
	movwf	SYSHTMLMAPPING_2,BANKED
;AN6_GCB_HTML = AN6_GCB_HTML & 0x0F
	movlw	15
	andwf	SYSHTMLMAPPING_1,F,BANKED
;AN4_GCB_HTML = AN4_GCB_HTML & 0x0F
	movlw	15
	andwf	SYSHTMLMAPPING_2,F,BANKED
;PortB = AN6_GCB_HTML
	movff	SYSHTMLMAPPING_1,PORTB
;PortD = AN4_GCB_HTML
	movff	SYSHTMLMAPPING_2,PORTD
;PORTB_GCB_HTML = PortB   'PortB
	movff	PORTB,SYSHTMLMAPPING_3
;PORTD_GCB_HTML = PortD   'PortD
	movff	PORTD,SYSHTMLMAPPING_4
;if PortA.4 = 1 then DisplayHTMLPage
	btfss	PORTA,4,ACCESS
	bra	ENDIF1
	banksel	0
	rcall	DISPLAYHTMLPAGE
ENDIF1
;loop
	bra	SysDoLoop_S1
SysDoLoop_E1
;DisplayHTMLPage
	rcall	DISPLAYHTMLPAGE
;end
	bra	BASPROGRAMEND
;''' GCB Optimisation file
;
;'Optmise PWM.h
;#define USE_HPWMCCP1 FALSE
;#define USE_HPWMCCP2 FALSE
;#define USE_HPWMCCP3 FALSE
;#define USE_HPWMCCP4 FALSE
;
;#define USE_HPWM6 FALSE
;#define USE_HPWM7 FALSE
;
;#define USE_HPWM_TIMER2 FALSE
;#define USE_HPWM_TIMER4 FALSE
;#define USE_HPWM_TIMER6 FALSE
;
;'Optimise A-d.h
;'Standard family chips
;#define USE_AD0 FALSE
;#define USE_AD1 FALSE
;#define USE_AD2 FALSE
;#define USE_AD2 FALSE
;#define USE_AD3 FALSE
;#define USE_AD4 TRUE
;#define USE_AD5 FALSE
;#define USE_AD6 FALSE
;#define USE_AD7 FALSE
;#define USE_AD8 FALSE
;#define USE_AD9 FALSE
;#define USE_AD10 FALSE
;#define USE_AD11 FALSE
;#define USE_AD12 FALSE
;#define USE_AD13 FALSE
;#define USE_AD14 FALSE
;#define USE_AD15 FALSE
;#define USE_AD16 FALSE
;#define USE_AD17 FALSE
;#define USE_AD18 FALSE
;#define USE_AD19 FALSE
;#define USE_AD20 FALSE
;#define USE_AD21 FALSE
;#define USE_AD22 FALSE
;#define USE_AD23 FALSE
;#define USE_AD24 FALSE
;#define USE_AD25 FALSE
;#define USE_AD26 FALSE
;#define USE_AD27 FALSE
;#define USE_AD28 FALSE
;#define USE_AD29 FALSE
;#define USE_AD30 FALSE
;#define USE_AD31 FALSE
;#define USE_AD32 FALSE
;#define USE_AD33 FALSE
;#define USE_AD34 FALSE
;
;'Family of chips based on 16f1688x with ADCON3 register
;#define USE_ADA0 FALSE
;#define USE_ADA1 FALSE
;#define USE_ADA2 FALSE
;#define USE_ADA3 FALSE
;#define USE_ADA4 FALSE
;#define USE_ADA5 FALSE
;#define USE_ADA6 FALSE
;#define USE_ADA7 FALSE
;#define USE_ADB0 FALSE
;#define USE_ADB1 FALSE
;#define USE_ADB2 FALSE
;#define USE_ADB3 FALSE
;#define USE_ADB4 FALSE
;#define USE_ADB5 FALSE
;#define USE_ADB6 FALSE
;#define USE_ADB7 FALSE
;#define USE_ADC0 FALSE
;#define USE_ADC1 FALSE
;#define USE_ADC2 FALSE
;#define USE_ADC3 FALSE
;#define USE_ADC4 FALSE
;#define USE_ADC5 FALSE
;#define USE_ADC6 FALSE
;#define USE_ADC7 FALSE
;#define USE_ADD0 FALSE
;#define USE_ADD1 FALSE
;#define USE_ADD2 FALSE
;#define USE_ADD3 FALSE
;#define USE_ADD4 FALSE
;#define USE_ADD5 FALSE
;#define USE_ADD6 FALSE
;#define USE_ADD7 FALSE
;#define USE_ADE0 FALSE
;#define USE_ADE1 FALSE
;#define USE_ADE2 FALSE
	movlw	1
	banksel	SYSHTMLMAPPINGTYPE_1
	movwf	SYSHTMLMAPPINGTYPE_1,BANKED
	setf	SYSHTMLMAPPING_1,BANKED
	movlw	1
	movwf	SYSHTMLMAPPINGTYPE_2,BANKED
	clrf	SYSHTMLMAPPING_2,BANKED
	clrf	SYSHTMLMAPPINGTYPE_3,BANKED
	movlw	170
	movwf	SYSHTMLMAPPING_3,BANKED
	clrf	SYSHTMLMAPPINGTYPE_4,BANKED
	movlw	85
	movwf	SYSHTMLMAPPING_4,BANKED
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

FN_CHR
;If SysChar < 0 Then
	movlw	0
	subwf	SYSCHAR,W,BANKED
	btfsc	STATUS, C,ACCESS
	bra	ENDIF13
;Chr(0) = 0
	banksel	SYSCHR_0
	clrf	SYSCHR_0,BANKED
;Exit Function
	banksel	0
	return
;End If
ENDIF13
;Chr(0) = 1
	movlw	1
	banksel	SYSCHR_0
	movwf	SYSCHR_0,BANKED
;Chr(1) = SysChar
	movff	SYSCHAR,SYSCHR_1
	banksel	0
	return

;********************************************************************************

DISPLAYHTMLPAGE
;HTMLElementTracker = 1
	movlw	1
	movwf	HTMLELEMENTTRACKER,BANKED
;for TableLoc = 1 to SizeofTable1
	clrf	TABLELOC,BANKED
	clrf	TABLELOC_H,BANKED
SysForLoop1
	incf	TABLELOC,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	TABLELOC_H,F,BANKED
;ReadTable index1, TableLoc, inByte
	movff	TABLELOC,SysStringA
	movff	TABLELOC_H,SysStringA_H
	rcall	INDEX1
	movwf	INBYTE,BANKED
;OutputHTMLVariable ( inByte )
	call	OUTPUTHTMLVARIABLE
;Next
	movff	TABLELOC,SysWORDTempA
	movff	TABLELOC_H,SysWORDTempA_H
	movlw	199
	movwf	SysWORDTempB,ACCESS
	movlw	7
	movwf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop1
SysForLoopEnd1
;for TableLoc = 1 to SizeofTable2
	clrf	TABLELOC,BANKED
	clrf	TABLELOC_H,BANKED
SysForLoop2
	incf	TABLELOC,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	TABLELOC_H,F,BANKED
;ReadTable index2, TableLoc, inByte
	movff	TABLELOC,SysStringA
	call	INDEX2
	movwf	INBYTE,BANKED
;OutputHTMLVariable ( inByte )
	call	OUTPUTHTMLVARIABLE
;Next
	movff	TABLELOC,SysWORDTempA
	movff	TABLELOC_H,SysWORDTempA_H
	movlw	102
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop2
SysForLoopEnd2
	return

;********************************************************************************

Delay_10US
D10US_START
	movlw	15
	movwf	DELAYTEMP,ACCESS
DelayUS0
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS0
	nop
	decfsz	SysWaitTemp10US, F,ACCESS
	bra	D10US_START
	return

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

GRAY_CODE
	movlw	17
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableGRAY_CODE
	movwf	TBLPTRL,ACCESS
	movlw	high TableGRAY_CODE
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableGRAY_CODE
	db	16,0,0,0,1,1,1,3,3,3,3,7,7,7,15,15,15

;********************************************************************************

;Overloaded signature: STRING:byte:
HSERPRINT209
;PrintLen = PrintData(0)
	movff	SysPRINTDATAHandler,AFSR0
	movff	SysPRINTDATAHandler_H,AFSR0_H
	movff	INDF0,PRINTLEN
;If PrintLen <> 0 then
	movf	PRINTLEN,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF14
;for SysPrintTemp = 1 to PrintLen
	clrf	SYSPRINTTEMP,BANKED
	movlw	1
	subwf	PRINTLEN,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd3
SysForLoop3
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
	rcall	Delay_MS
;next
	movf	PRINTLEN,W,BANKED
	subwf	SYSPRINTTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop3
SysForLoopEnd3
;End If
ENDIF14
	return

;********************************************************************************

;Overloaded signature: BYTE:byte:
HSERPRINT210
;OutValueTemp = 0
	clrf	OUTVALUETEMP,BANKED
;IF SerPrintVal >= 100 Then
	movlw	100
	subwf	SERPRINTVAL,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	ENDIF17
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
	rcall	Delay_MS
;End If
ENDIF17
;If OutValueTemp > 0 Or SerPrintVal >= 10 Then
	movff	OUTVALUETEMP,SysBYTETempB
	clrf	SysBYTETempA,ACCESS
	call	SysCompLessThan
	movff	SysByteTempX,SysTemp1
	movff	SERPRINTVAL,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movf	SysTemp1,W,BANKED
	iorwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,BANKED
	btfss	SysTemp2,0,BANKED
	bra	ENDIF18
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
	rcall	Delay_MS
;End If
ENDIF18
;HSerSend(SerPrintVal + 48 ,comport)
	movlw	48
	addwf	SERPRINTVAL,W,BANKED
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	bra	Delay_MS

;********************************************************************************

HSERSEND
;if comport = 1 Then
	decf	COMPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF21
;Wait While TXIF = Off
SysWaitLoop2
	btfss	PIR1,TXIF,ACCESS
	bra	SysWaitLoop2
;Wait While TXIF = Off
SysWaitLoop3
	btfss	PIR1,TXIF,ACCESS
	bra	SysWaitLoop3
;TXREG = SerData
	movff	SERDATA,TXREG
;end if
ENDIF21
	return

;********************************************************************************

INDEX1
	movff	SYSSTRINGA,SysWORDTempA
	movff	SYSSTRINGA_H,SysWORDTempA_H
	movlw	200
	movwf	SysWORDTempB,ACCESS
	movlw	7
	movwf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableINDEX1
	movwf	TBLPTRL,ACCESS
	movlw	high TableINDEX1
	btfsc	STATUS, C,ACCESS
	addlw	1
	addwf	SysStringA_H, W,ACCESS
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableINDEX1
	db	199,60,33,68,79,67,84,89,80,69,32,72,84,77,76,32,80,85,66,76,73,67,32,34,45,47
	db	47,87,51,67,47,47,68,84,68,32,72,84,77,76,32,52,46,48,49,32,84,114,97,110,115,105
	db	116,105,111,110,97,108,47,47,69,78,34,62,60,104,116,109,108,62,60,104,101,97
	db	100,62,60,109,101,116,97,32,99,111,110,116,101,110,116,61,34,117,114,108,61,104
	db	116,116,112,58,47,47,49,48,46,48,46,48,46,51,52,34,32,104,116,116,112,45,101,113
	db	117,105,118,61,34,114,101,102,114,101,115,104,34,62,60,47,104,101,97,100,62,60
	db	98,111,100,121,62,60,104,49,32,115,116,121,108,101,61,34,102,111,110,116,45,102
	db	97,109,105,108,121,58,32,72,101,108,118,101,116,105,99,97,44,65,114,105,97,108
	db	44,115,97,110,115,45,115,101,114,105,102,59,32,104,101,105,103,104,116,58,32,49
	db	56,112,120,59,34,62,60,115,109,97,108,108,62,60,115,109,97,108,108,62,71,114
	db	101,97,116,67,111,119,32,66,65,83,73,67,32,69,78,67,50,56,74,54,48,32,77,105
	db	110,105,32,87,101,98,32,83,101,114,118,101,114,60,47,115,109,97,108,108,62,60
	db	47,115,109,97,108,108,62,60,47,104,49,62,60,115,109,97,108,108,62,60,97,32,115,116
	db	121,108,101,61,34,102,111,110,116,45,102,97,109,105,108,121,58,32,72,101,108,118
	db	101,116,105,99,97,44,65,114,105,97,108,44,115,97,110,115,45,115,101,114,105,102
	db	59,32,102,111,110,116,45,119,101,105,103,104,116,58,32,98,111,108,100,59,34,32
	db	104,114,101,102,61,34,47,34,62,82,101,108,111,97,100,60,47,97,62,60,98,114,62,60
	db	98,114,62,60,115,99,114,105,112,116,32,115,114,99,61,34,47,115,34,62,60,47,115,99
	db	114,105,112,116,62,60,47,115,109,97,108,108,62,60,116,97,98,108,101,32,115,116
	db	121,108,101,61,34,102,111,110,116,45,102,97,109,105,108,121,58,32,72,101,108,118
	db	101,116,105,99,97,44,65,114,105,97,108,44,115,97,110,115,45,115,101,114,105,102
	db	59,34,62,60,116,98,111,100,121,62,60,116,114,62,60,116,100,32,118,97,108,105
	db	103,110,61,34,116,111,112,34,62,60,115,109,97,108,108,62,60,47,115,109,97,108
	db	108,62,60,116,97,98,108,101,32,115,116,121,108,101,61,34,102,111,110,116,45,115
	db	105,122,101,58,32,50,48,112,120,59,34,32,116,101,114,109,105,110,97,108,61,34
	db	34,32,98,111,114,100,101,114,61,34,49,34,62,60,116,98,111,100,121,62,60,116,114,62
	db	60,116,104,32,99,111,108,115,112,97,110,61,34,50,34,62,60,115,109,97,108,108,62,65
	db	68,67,60,47,115,109,97,108,108,62,60,47,116,104,62,60,47,116,114,62,60,116,114,62
	db	60,116,100,32,115,116,121,108,101,61,34,102,111,110,116,45,119,101,105,103,104,116
	db	58,32,98,111,108,100,59,34,62,60,115,109,97,108,108,62,65,78,54,60,47,115,109,97
	db	108,108,62,60,47,116,100,62,60,116,100,32,115,116,121,108,101,61,34,116,101,120
	db	116,45,97,108,105,103,110,58,32,114,105,103,104,116,59,32,119,105,100,116,104,58
	db	32,51,50,112,120,59,34,62,60,115,109,97,108,108,62,60,115,99,114,105,112,116,62,118
	db	97,114,32,65,78,54,95,71,67,66,95,83,84,82,73,78,71,32,61,32,34,0,34,59,100,111
	db	99,117,109,101,110,116,46,119,114,105,116,101,40,65,78,54,95,71,67,66,95,83,84,82
	db	73,78,71,41,60,47,115,99,114,105,112,116,62,60,47,115,109,97,108,108,62,60,47,116
	db	100,62,60,47,116,114,62,60,116,114,62,60,116,100,32,115,116,121,108,101,61,34
	db	102,111,110,116,45,119,101,105,103,104,116,58,32,98,111,108,100,59,34,62,60,115
	db	109,97,108,108,62,65,78,52,60,47,115,109,97,108,108,62,60,47,116,100,62,60,116,100
	db	32,115,116,121,108,101,61,34,116,101,120,116,45,97,108,105,103,110,58,32,114,105
	db	103,104,116,59,34,62,60,115,109,97,108,108,62,60,115,99,114,105,112,116,62,118
	db	97,114,32,65,78,52,95,71,67,66,95,83,84,82,73,78,71,32,61,32,34,0,34,59,100,111
	db	99,117,109,101,110,116,46,119,114,105,116,101,40,65,78,52,95,71,67,66,95,83,84,82
	db	73,78,71,41,60,47,115,99,114,105,112,116,62,60,47,115,109,97,108,108,62,60,47,116
	db	100,62,60,47,116,114,62,60,47,116,98,111,100,121,62,60,47,116,97,98,108,101,62,60
	db	47,116,100,62,60,116,100,62,60,115,109,97,108,108,62,60,47,115,109,97,108,108
	db	62,60,116,97,98,108,101,32,115,116,121,108,101,61,34,102,111,110,116,45,115,105
	db	122,101,58,32,50,48,112,120,59,34,32,59,102,111,110,116,45,102,97,109,105,108
	db	121,61,34,34,32,116,101,114,109,105,110,97,108,61,34,34,32,59,61,34,34,32,98,111
	db	114,100,101,114,61,34,49,34,62,60,116,98,111,100,121,62,60,116,114,62,60,116
	db	104,32,99,111,108,115,112,97,110,61,34,50,34,62,60,115,109,97,108,108,62,80,79,82
	db	84,66,60,47,115,109,97,108,108,62,60,47,116,104,62,60,47,116,114,62,60,115,99,114
	db	105,112,116,62,118,97,114,32,115,116,114,44,105,44,80,79,82,84,66,95,71,67,66,95
	db	66,89,84,69,44,32,82,69,81,59,82,69,81,61,48,59,80,79,82,84,66,95,71,67,66,95
	db	66,89,84,69,32,61,0,59,115,116,114,61,34,34,59,102,111,114,40,105,61,48,59,105
	db	60,56,59,105,43,43,41,123,115,116,114,43,61,34,60,116,114,62,60,116,100,32,98,103
	db	99,111,108,111,114,61,112,105,110,107,62,66,85,84,84,79,78,32,35,34,43,105,43,34
	db	60,47,116,100,62,34,59,105,102,40,80,79,82,84,66,95,71,67,66,95,66,89,84,69,38,40
	db	49,60,60,105,41,41,123,32,32,115,116,114,43,61,34,60,116,100,32,98,103,99,111,108
	db	111,114,61,114,101,100,62,79,78,34,59,32,32,125,101,108,115,101,32,123,115,116
	db	114,43,61,34,60,116,100,32,98,103,99,111,108,111,114,61,35,99,99,99,99,99,99,62
	db	79,70,70,34,59,125,115,116,114,43,61,34,60,47,116,100,62,60,47,116,114,62,34,59
	db	125,100,111,99,117,109,101,110,116,46,119,114,105,116,101,40,115,116,114,41,32,59
	db	60,47,115,99,114,105,112,116,62,60,47,116,98,111,100,121,62,60,47,116,97,98,108,101
	db	62,60,47,116,100,62,60,116,100,62,60,115,109,97,108,108,62,60,47,115,109,97,108,108
	db	62,60,116,97,98,108,101,32,115,116,121,108,101,61,34,102,111,110,116,45,115,105
	db	122,101,58,32,50,48,112,120,59,34,32,59,102,111,110,116,45,102,97,109,105,108
	db	121,61,34,34,32,116,101,114,109,105,110,97,108,61,34,34,32,59,61,34,34,32,98,111
	db	114,100,101,114,61,34,49,34,62,60,116,98,111,100,121,62,60,116,114,62,60,116
	db	104,32,99,111,108,115,112,97,110,61,34,51,34,62,60,115,109,97,108,108,62,80,79,82
	db	84,68,60,47,115,109,97,108,108,62,60,47,116,104,62,60,47,116,114,62,60,115,99,114
	db	105,112,116,62,118,97,114,32,115,116,114,44,105,44,80,79,82,84,68,95,71,67,66,95
	db	66,89,84,69,59,82,69,81,43,43,59,80,79,82,84,68,95,71,67,66,95,66,89,84,69,32
	db	61,0,59,115,116,114,61,34,34,59,102,111,114,40,105,61,48,59,105,60,56,59,105,43
	db	43,41,123,115,116,114,43,61,34,60,116,114,62,60,116,100,32,98,103,99,111,108
	db	111,114,61,121,101,108,108,111,119,62,76,69,68,32,35,34,43,105,43,34,60,47,116,100
	db	62,34,59,105,102,40,80,79,82,84,68,95,71,67,66,95,66,89,84,69,38,40,49,60,60,105
	db	41,41,123,32,32,115,116,114,43,61,34,60,116,100,32,98,103,99,111,108,111,114,61,114
	db	101,100,62,79,78,34,59,32,32,125,101,108,115,101,32,123,115,116,114,43,61,34,60,116
	db	100,32,98,103,99,111,108,111,114,61,35,99,99,99,99,99,99,62,79,70,70,34,59,125
	db	115,116,114,43,61,34,60,47,116,100,62,60,116,100,62,60,97,32,104,114,101,102,61,47
	db	116,34,43,105,43,34,62,84,111,103,103,108,101,60,47,97,62,60,47,116,100,62,60,47
	db	116,114,62,34,59,125,100,111,99,117,109,101,110,116,46,119,114,105,116,101,40,115
	db	116,114,41,32,59,60,47,115,99,114,105,112,116,62,60,47,116,98,111,100,121,62,60,47
	db	116,97,98,108,101,62,60,47,116,100,62,60,47,116,114,62,60,47,116,98,111,100,121,62
	db	60,47,116,97,98,108,101,62

;********************************************************************************

INDEX1_H
	movff	SYSSTRINGA,SysWORDTempA
	movff	SYSSTRINGA_H,SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableINDEX1_H
	movwf	TBLPTRL,ACCESS
	movlw	high TableINDEX1_H
	btfsc	STATUS, C,ACCESS
	addlw	1
	addwf	SysStringA_H, W,ACCESS
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableINDEX1_H
	db	7

;********************************************************************************

INDEX2
	movlw	103
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableINDEX2
	movwf	TBLPTRL,ACCESS
	movlw	high TableINDEX2
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableINDEX2
	db	102,84,104,105,115,32,105,115,32,72,84,84,80,32,114,101,113,117,101,115,116,32
	db	35,60,47,115,112,97,110,62,60,47,115,109,97,108,108,62,60,115,109,97,108,108,62,60
	db	115,99,114,105,112,116,62,100,111,99,117,109,101,110,116,46,119,114,105,116,101,40
	db	82,69,81,41,60,47,115,99,114,105,112,116,62,60,47,115,109,97,108,108,62,60,47,98
	db	111,100,121,62,60,47,104,116,109,108,62

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
;CMCON = 7
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
	movlw	7
	movwf	SPBRG,ACCESS
;SPBRGH = SPBRGH_TEMP
	movlw	2
	movwf	SPBRGH,ACCESS
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

OUTPUTHTMLVARIABLE
;if inByte = 0 then
	movf	INBYTE,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE4_1
;if HTMLMappingType(HTMLElementTracker) = StringVar then
	lfsr	0,HTMLMAPPINGTYPE
	movf	HTMLELEMENTTRACKER,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	decf	INDF0,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ELSE5_1
;HserPrint HTMLMapping(HTMLElementTracker)
	lfsr	0,HTMLMAPPING
	movf	HTMLELEMENTTRACKER,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	INDF0,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT210
;else
	bra	ENDIF5
ELSE5_1
;HserPrint HTMLMapping(HTMLElementTracker)
	lfsr	0,HTMLMAPPING
	movf	HTMLELEMENTTRACKER,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	INDF0,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT210
;end if
ENDIF5
;HTMLElementTracker++
	incf	HTMLELEMENTTRACKER,F,BANKED
;Else
	bra	ENDIF4
ELSE4_1
;HSerPrint chr(inByte)
	movff	INBYTE,SYSCHAR
	call	FN_CHR
	movlw	low CHR
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high CHR
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT209
;end if
ENDIF4
	return

;********************************************************************************

FN_READAD10
;SET ADFM ON
	bsf	ADCON2,ADFM,ACCESS
;Do conversion
;LLReadAD 0
;SET PCFG3 OFF
	bcf	ADCON1,PCFG3,ACCESS
;SET PCFG2 OFF
	bcf	ADCON1,PCFG2,ACCESS
;SET PCFG1 OFF
	bcf	ADCON1,PCFG1,ACCESS
;SET PCFG0 OFF
	bcf	ADCON1,PCFG0,ACCESS
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
;IF ADReadPort.0 On Then Set ADCON0.CHS0 On
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
;SET ADCON0.ADON ON
	bsf	ADCON0,ADON,ACCESS
;Wait AD_Delay
	movlw	2
	movwf	SysWaitTemp10US,ACCESS
	call	Delay_10US
;SET ADCON0.GO_NOT_DONE ON
	bsf	ADCON0,GO_NOT_DONE,ACCESS
;Wait While ADCON0.GO_NOT_DONE ON
SysWaitLoop1
	btfsc	ADCON0,GO_NOT_DONE,ACCESS
	bra	SysWaitLoop1
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
;ReadAD10 = ADRESL
	movff	ADRESL,READAD10
	clrf	READAD10_H,BANKED
;ReadAD10_H = ADRESH
	movff	ADRESH,READAD10_H
;SET ADFM OFF
	bcf	ADCON2,ADFM,ACCESS
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
	bra	ENDIF19
;SysWordTempA = 0
	clrf	SYSWORDTEMPA,ACCESS
	clrf	SYSWORDTEMPA_H,ACCESS
;exit sub
	return
;end if
ENDIF19
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
	bra	ENDIF20
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0,ACCESS
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W,ACCESS
	addwf	SYSDIVMULTX,F,ACCESS
	movf	SYSDIVMULTB_H,W,ACCESS
	addwfc	SYSDIVMULTX_H,F,ACCESS
;End If
ENDIF20
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

SYSDIVSUBINT
;Dim SysIntegerTempA, SysIntegerTempB, SysIntegerTempX As Integer
;Dim SysSignByte As Byte
;SysSignByte = SysIntegerTempA_H xor SysIntegerTempB_H
	movf	SYSINTEGERTEMPA_H,W,ACCESS
	xorwf	SYSINTEGERTEMPB_H,W,ACCESS
	movwf	SYSSIGNBYTE,ACCESS
;If SysIntegerTempA.15 Then SysIntegerTempA = -SysIntegerTempA
	btfss	SYSINTEGERTEMPA_H,7,ACCESS
	bra	ENDIF10
	comf	SYSINTEGERTEMPA,F,ACCESS
	comf	SYSINTEGERTEMPA_H,F,ACCESS
	incf	SYSINTEGERTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPA_H,F,ACCESS
ENDIF10
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
	btfss	SYSINTEGERTEMPB_H,7,ACCESS
	bra	ENDIF11
	comf	SYSINTEGERTEMPB,F,ACCESS
	comf	SYSINTEGERTEMPB_H,F,ACCESS
	incf	SYSINTEGERTEMPB,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPB_H,F,ACCESS
ENDIF11
;SysDivSub16
	rcall	SYSDIVSUB16
;If SysSignByte.7 Then
	btfss	SYSSIGNBYTE,7,ACCESS
	bra	ENDIF12
;SysIntegerTempA = -SysIntegerTempA
	comf	SYSINTEGERTEMPA,F,ACCESS
	comf	SYSINTEGERTEMPA_H,F,ACCESS
	incf	SYSINTEGERTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPA_H,F,ACCESS
;SysIntegerTempX = -SysIntegerTempX
	comf	SYSINTEGERTEMPX,F,ACCESS
	comf	SYSINTEGERTEMPX_H,F,ACCESS
	incf	SYSINTEGERTEMPX,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPX_H,F,ACCESS
;End If
ENDIF12
	return

;********************************************************************************


 END
