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
SYSCALCTEMPA	EQU	5
SYSSTRINGLENGTH	EQU	6
SysStringA	EQU	7
SysStringA_H	EQU	8
SysWaitTempMS	EQU	2
SysWaitTempMS_H	EQU	3
SysWaitTempS	EQU	4
SYSSTRINGPARAM1	EQU	1493
COMPORT	EQU	9
HSERPRINTCRLFCOUNT	EQU	10
LINETEST	EQU	11
PRINTLEN	EQU	12
SERDATA	EQU	13
SYSPRINTTEMP	EQU	14
SYSREPEATTEMP1	EQU	15
StringPointer	EQU	16
SysPRINTDATAHandler	EQU	17
SysPRINTDATAHandler_H	EQU	18

;********************************************************************************

;Alias variables
AFSR0	EQU	4073
AFSR0_H	EQU	4074

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
	rcall	INITSYS
	rcall	INITUSART
;Automatic pin direction setting
	bcf	TRISB,0,ACCESS

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
;----- Constants
;#Define Heartbeat 			PortC.2
;#define ENC28J60_DI			PortC.4							'Connected to Device SO
;#define ENC28J60_DO			PortC.5							'Connected to Device SI
;#define ENC28J60_SCK		PortC.3							'Connected to Clock
;#define ENC28J60_CS 		PortD.3							'Chip select line
;#define ENC28J60_RESET  PortD.2							'Reset line
;#define debugport portb.0
;USART settings
;#define USART_BAUD_RATE 9600
;#define USART_BLOCKING
;#define USART_TX_BLOCKING
;----- Define Hardware settings
;set debugport off
	bcf	LATB,0,ACCESS
;----- Variables
;----- Quick Command Reference:
;----- Main body of program commences here.
;wait 1 s
	movlw	1
	movwf	SysWaitTempS,ACCESS
	rcall	Delay_S
;HSerPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF
;HserPrint "ENC28J60 Ethernet Driver Initial Hardware Tests" : HSerPrintCRLF
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable1
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable1
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT207
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF
;HserPrint "Init Test": HSerPrintCRLF
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable2
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable2
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT207
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF
;#define ENC28J60_Select         Set ENC28J60_CS off
;#define ENC28J60_Deselect       Set ENC28J60_CS on
;#define ENC28J60_Reset_CMD			Set ENC28J60_RESET on: Wait 10 ms :Set ENC28J60_RESET off: Wait 10 ms :Set ENC28J60_RESET on: Wait 10 ms
;Dir ENC28J60_DI OUT
	bcf	TRISC,4,ACCESS
;Dir ENC28J60_DO Out
	bcf	TRISC,5,ACCESS
;Dir ENC28J60_SCK Out
	bcf	TRISC,3,ACCESS
;Dir ENC28J60_CS OUT
	bcf	TRISD,3,ACCESS
;Dir ENC28J60_RESET OUT
	bcf	TRISD,2,ACCESS
;Dir Heartbeat Out
	bcf	TRISC,2,ACCESS
;linetest = 5
	movlw	5
	movwf	LINETEST,BANKED
;select case linetest
;	case 1
SysSelect1Case1
	decf	LINETEST,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case2
;	do Forever
SysDoLoop_S1
;PulseOut Heartbeat, 15 Ms
;Set Pin On
	bsf	LATC,2,ACCESS
;Wait Time
	movlw	15
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Set Pin Off
	bcf	LATC,2,ACCESS
;Wait 10 Ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Set ENC28J60_SCK On
	bsf	LATC,3,ACCESS
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Set ENC28J60_SCK Off
	bcf	LATC,3,ACCESS
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;	Loop
	bra	SysDoLoop_S1
SysDoLoop_E1
;	case 2
	bra	SysSelectEnd1
SysSelect1Case2
	movlw	2
	subwf	LINETEST,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case3
;	do Forever
SysDoLoop_S2
;PulseOut Heartbeat, 15 Ms
;Set Pin On
	bsf	LATC,2,ACCESS
;Wait Time
	movlw	15
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Set Pin Off
	bcf	LATC,2,ACCESS
;Wait 10 Ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Set ENC28J60_DO On
	bsf	LATC,5,ACCESS
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Set ENC28J60_DO Off
	bcf	LATC,5,ACCESS
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;	Loop
	bra	SysDoLoop_S2
SysDoLoop_E2
;	case 3
	bra	SysSelectEnd1
SysSelect1Case3
	movlw	3
	subwf	LINETEST,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case4
;	do Forever
SysDoLoop_S3
;PulseOut Heartbeat, 15 Ms
;Set Pin On
	bsf	LATC,2,ACCESS
;Wait Time
	movlw	15
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Set Pin Off
	bcf	LATC,2,ACCESS
;Wait 10 Ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Set ENC28J60_DI On
	bsf	LATC,4,ACCESS
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Set ENC28J60_DI Off
	bcf	LATC,4,ACCESS
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;	Loop
	bra	SysDoLoop_S3
SysDoLoop_E3
;	case 4
	bra	SysSelectEnd1
SysSelect1Case4
	movlw	4
	subwf	LINETEST,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case5
;	do Forever
SysDoLoop_S4
;PulseOut Heartbeat, 15 Ms
;Set Pin On
	bsf	LATC,2,ACCESS
;Wait Time
	movlw	15
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Set Pin Off
	bcf	LATC,2,ACCESS
;Wait 10 Ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Set ENC28J60_CS On
	bsf	LATD,3,ACCESS
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Set ENC28J60_CS Off
	bcf	LATD,3,ACCESS
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;	Loop
	bra	SysDoLoop_S4
SysDoLoop_E4
;	case 5
	bra	SysSelectEnd1
SysSelect1Case5
	movlw	5
	subwf	LINETEST,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case6
;	do Forever
SysDoLoop_S5
;PulseOut Heartbeat, 15 Ms
;Wait 10 Ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Set ENC28J60_RESET On
	bsf	LATD,2,ACCESS
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Set ENC28J60_RESET Off
	bcf	LATD,2,ACCESS
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;	Loop
	bra	SysDoLoop_S5
SysDoLoop_E5
;End Select
SysSelect1Case6
SysSelectEnd1
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

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

Delay_S
DS_START
	movlw	232
	movwf	SysWaitTempMS,ACCESS
	movlw	3
	movwf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
	decfsz	SysWaitTempS, F,ACCESS
	bra	DS_START
	return

;********************************************************************************

;Overloaded signature: STRING:byte:
HSERPRINT207
;PrintLen = PrintData(0)
	movff	SysPRINTDATAHandler,AFSR0
	movff	SysPRINTDATAHandler_H,AFSR0_H
	movff	INDF0,PRINTLEN
;If PrintLen <> 0 then
	movf	PRINTLEN,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF2
;for SysPrintTemp = 1 to PrintLen
	clrf	SYSPRINTTEMP,BANKED
	movlw	1
	subwf	PRINTLEN,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd1
SysForLoop1
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
	bra	SysForLoop1
SysForLoopEnd1
;End If
ENDIF2
	return

;********************************************************************************

HSERPRINTCRLF
;repeat HSerPrintCRLFCount
	movff	HSERPRINTCRLFCOUNT,SysRepeatTemp1
	movf	SYSREPEATTEMP1,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd1
SysRepeatLoop1
;HSerSend(13,comport)
	movlw	13
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;HSerSend(10,comport)
	movlw	10
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;end Repeat
	decfsz	SysRepeatTemp1,F,BANKED
	bra	SysRepeatLoop1
SysRepeatLoopEnd1
	return

;********************************************************************************

HSERSEND
;if comport = 1 Then
	decf	COMPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF1
;Wait While TXIF = Off
SysWaitLoop1
	btfss	PIR1,TXIF,ACCESS
	bra	SysWaitLoop1
;Wait While TXIF = Off
SysWaitLoop2
	btfss	PIR1,TXIF,ACCESS
	bra	SysWaitLoop2
;TXREG = SerData
	movff	SERDATA,TXREG
;end if
ENDIF1
	return

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

SYSREADSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;TBLRD*+
	tblrd*+
;movff TABLAT,SysCalcTempA
	movff	TABLAT,SYSCALCTEMPA
;movff TABLAT,INDF1
	movff	TABLAT,INDF1
;TBLRD*+
	tblrd*+
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
;TBLRD*+
	tblrd*+
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

StringTable1
	dw	12079,"ENC28J60 Ethernet Driver Initial Hardware Tests"


StringTable2
	dw	2313,"Init Test"


;********************************************************************************


 END
