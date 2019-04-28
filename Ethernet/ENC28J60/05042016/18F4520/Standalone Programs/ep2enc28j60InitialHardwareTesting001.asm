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
SysStringA	EQU	119
SysStringA_H	EQU	120
SysWaitTempMS	EQU	114
SysWaitTempMS_H	EQU	115
SysWaitTempS	EQU	116
COMPORT	EQU	32
HSERPRINTCRLFCOUNT	EQU	33
LINETEST	EQU	34
PRINTLEN	EQU	35
SERDATA	EQU	36
SYSBITVAR0	EQU	37
SYSPRINTTEMP	EQU	38
StringPointer	EQU	39
SysPRINTDATAHandler	EQU	40
SysPRINTDATAHandler_H	EQU	41
SysRepeatTemp1	EQU	42

;********************************************************************************

;Alias variables
AFSR0	EQU	4
AFSR0_H	EQU	5

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
;Automatic pin direction setting
	bcf	TRISB,0

;Start of the main program
;''A program  for GCGB and GCB.
;''--------------------------------------------------------------------------------------------------------------------------------
;''
;'':		Simple set linetest to 1 thru 5.  Then, test the line using a scope.
;''			This does not use SPI but simply toggles line state for m hi to lo.
;''@author 		[todo]
;''@licence		GPL
;''@version		[todo]
;''@date   		[todo]
;''********************************************************************************
;----- Configuration
;#define ENC28J60_DI			portb.4						'Connected to Device SO
;#define ENC28J60_DO			portb.5							'Connected to Device SI
;#define ENC28J60_SCK		portb.3							'Connected to Clock
;#define ENC28J60_CS 		portb.2							'Chip select line
;#define ENC28J60_RESET  PORTb.1							'Reset line
;#define debugport portb.0
;USART settings
;#define USART_BAUD_RATE 9600
;#define USART_BLOCKING
;#define USART_TX_BLOCKING
;----- Define Hardware settings
;set debugport off
	bcf	LATB,0
;----- Variables
;----- Quick Command Reference:
;----- Main body of program commences here.
;wait 1 s
	movlw	1
	movwf	SysWaitTempS
	call	Delay_S
;HSerPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	call	HSERPRINTCRLF
;HserPrint "ENC28J60 Ethernet Driver Initial Hardware Tests" : HSerPrintCRLF
	movlw	low StringTable1
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable1) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT214
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
	call	HSERPRINT214
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	call	HSERPRINTCRLF
;#define ENC28J60_Select         Set ENC28J60_CS off
;#define ENC28J60_Deselect       Set ENC28J60_CS on
;#define ENC28J60_Reset_CMD			Set ENC28J60_RESET on: Wait 10 ms :Set ENC28J60_RESET off: Wait 10 ms :Set ENC28J60_RESET on: Wait 10 ms
;Dir ENC28J60_DI OUT
	bcf	TRISB,4
;Dir ENC28J60_DO Out
	bcf	TRISB,5
;Dir ENC28J60_SCK Out
	bcf	TRISB,3
;Dir ENC28J60_CS OUT
	bcf	TRISB,2
;Dir ENC28J60_RESET OUT
	bcf	TRISB,1
;linetest = 1
	movlw	1
	movwf	LINETEST
;select case linetest
;	case 1
SysSelect1Case1
	decf	LINETEST,W
	btfss	STATUS, Z
	goto	SysSelect1Case2
;	do Forever
SysDoLoop_S1
;Set ENC28J60_SCK On
	bsf	LATB,3
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;Set ENC28J60_SCK Off
	bcf	LATB,3
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;	Loop
	goto	SysDoLoop_S1
SysDoLoop_E1
;	case 2
	goto	SysSelectEnd1
SysSelect1Case2
	movlw	2
	subwf	LINETEST,W
	btfss	STATUS, Z
	goto	SysSelect1Case3
;	do Forever
SysDoLoop_S2
;Set ENC28J60_DO On
	bsf	LATB,5
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;Set ENC28J60_DO Off
	bcf	LATB,5
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;	Loop
	goto	SysDoLoop_S2
SysDoLoop_E2
;	case 3
	goto	SysSelectEnd1
SysSelect1Case3
	movlw	3
	subwf	LINETEST,W
	btfss	STATUS, Z
	goto	SysSelect1Case4
;	do Forever
SysDoLoop_S3
;Set ENC28J60_DI On
	bsf	LATB,4
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;Set ENC28J60_DI Off
	bcf	LATB,4
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;	Loop
	goto	SysDoLoop_S3
SysDoLoop_E3
;	case 4
	goto	SysSelectEnd1
SysSelect1Case4
	movlw	4
	subwf	LINETEST,W
	btfss	STATUS, Z
	goto	SysSelect1Case5
;	do Forever
SysDoLoop_S4
;Set ENC28J60_CS On
	bsf	LATB,2
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;Set ENC28J60_CS Off
	bcf	LATB,2
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;	Loop
	goto	SysDoLoop_S4
SysDoLoop_E4
;	case 5
	goto	SysSelectEnd1
SysSelect1Case5
	movlw	5
	subwf	LINETEST,W
	btfss	STATUS, Z
	goto	SysSelect1Case6
;	do Forever
SysDoLoop_S5
;Set ENC28J60_RESET On
	bsf	LATB,1
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;Set ENC28J60_RESET Off
	bcf	LATB,1
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;	Loop
	goto	SysDoLoop_S5
SysDoLoop_E5
;End Select
SysSelect1Case6
SysSelectEnd1
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

;Overloaded signature: STRING:byte:
HSERPRINT214
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
	goto	ENDIF2
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
	goto	SysForLoop1
SysForLoopEnd1
;End If
ENDIF2
	return

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
	goto	ENDIF1
;Wait While TXIF = Off
SysWaitLoop1
	banksel	PIR3
	btfss	PIR3,TXIF
	goto	SysWaitLoop1
;Wait While TXIF = Off
SysWaitLoop2
	btfss	PIR3,TXIF
	goto	SysWaitLoop2
;TXREG1 = SerData
	banksel	SERDATA
	movf	SERDATA,W
	banksel	TXREG1
	movwf	TXREG1
;end if
ENDIF1
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

SysStringTables
	movf	SysStringA_H,W
	movwf	PCLATH
	movf	SysStringA,W
	incf	SysStringA,F
	btfsc	STATUS,Z
	incf	SysStringA_H,F
	movwf	PCL

StringTable1
	retlw	47
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
	retlw	73	;I
	retlw	110	;n
	retlw	105	;i
	retlw	116	;t
	retlw	105	;i
	retlw	97	;a
	retlw	108	;l
	retlw	32	; 
	retlw	72	;H
	retlw	97	;a
	retlw	114	;r
	retlw	100	;d
	retlw	119	;w
	retlw	97	;a
	retlw	114	;r
	retlw	101	;e
	retlw	32	; 
	retlw	84	;T
	retlw	101	;e
	retlw	115	;s
	retlw	116	;t
	retlw	115	;s


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


;********************************************************************************

;Start of program memory page 1
	ORG	2048
;Start of program memory page 2
	ORG	4096
;Start of program memory page 3
	ORG	6144

 END
