;Program compiled by Great Cow BASIC (0.98.02 2018-05-10)
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F1459, r=DEC
#include <P16F1459.inc>
 __CONFIG _CONFIG1, _MCLRE_OFF & _WDTE_OFF & _FOSC_INTOSC
 __CONFIG _CONFIG2, _LVP_OFF & _PLLEN_DISABLED & _CPUDIV_NOCLKDIV

;********************************************************************************

;Set aside memory locations for variables
ADREADPORT	EQU	32
COMPORT	EQU	33
DELAYTEMP	EQU	112
DELAYTEMP2	EQU	113
HEX	EQU	9136
HSERPRINTCRLFCOUNT	EQU	34
MEMDATA	EQU	35
OUTVALUETEMP	EQU	36
PEEK	EQU	37
PRINTLEN	EQU	38
READAD10	EQU	39
READAD10_H	EQU	40
SAVEDELAYTEMP2	EQU	41
SAVEFSR0H	EQU	42
SAVEFSR0L	EQU	43
SAVEFSR1H	EQU	44
SAVEPCLATH	EQU	45
SAVESYSBYTETEMPA	EQU	46
SAVESYSBYTETEMPB	EQU	47
SAVESYSBYTETEMPX	EQU	48
SAVESYSDIVLOOP	EQU	49
SAVESYSSTRINGA	EQU	50
SAVESYSSTRINGA_H	EQU	51
SAVESYSSTRINGLENGTH	EQU	52
SAVESYSTEMP1	EQU	53
SAVESYSTEMP2	EQU	54
SAVESYSWAITTEMPMS	EQU	55
SAVESYSWAITTEMPMS_H	EQU	56
SENSORVALUE1	EQU	57
SENSORVALUE1_H	EQU	58
SENSORVALUE2	EQU	59
SENSORVALUE2_H	EQU	60
SENSORVALUE3	EQU	61
SENSORVALUE3_H	EQU	62
SENSORVALUE4	EQU	63
SENSORVALUE4_H	EQU	64
SERDATA	EQU	65
SERPRINTVAL	EQU	66
STRINGPOINTER	EQU	67
SYSBSR	EQU	68
SYSBYTETEMPA	EQU	117
SYSBYTETEMPB	EQU	121
SYSBYTETEMPX	EQU	112
SYSCALCTEMPA	EQU	117
SYSCALCTEMPX	EQU	112
SYSDIVLOOP	EQU	116
SYSPRINTDATAHANDLER	EQU	69
SYSPRINTDATAHANDLER_H	EQU	70
SYSPRINTTEMP	EQU	71
SYSREPEATTEMP1	EQU	72
SYSSTATUS	EQU	127
SYSSTRINGA	EQU	119
SYSSTRINGA_H	EQU	120
SYSSTRINGLENGTH	EQU	118
SYSSTRINGTEMP	EQU	73
SYSTEMP1	EQU	74
SYSTEMP1_H	EQU	75
SYSTEMP2	EQU	76
SYSVALTEMP	EQU	77
SYSW	EQU	126
SYSWAITTEMP10US	EQU	117
SYSWAITTEMPMS	EQU	114
SYSWAITTEMPMS_H	EQU	115
USBBMREQUESTTYPE	EQU	78
USBBUFFERSTAT	EQU	79
USBCURRBYTE	EQU	80
USBCURRCONFIGURATION	EQU	81
USBCURRENDPOINT	EQU	82
USBDESCINDEX	EQU	83
USBDESCSIZEIN	EQU	84
USBDESCSTART	EQU	85
USBDESCTYPE	EQU	86
USBHASDATA	EQU	87
USBLASTCONTROL	EQU	88
USBNEWADDRESS	EQU	89
USBPID	EQU	90
USBSIZE	EQU	91
USBSTATE	EQU	92
USBTEMPBUFFER	EQU	9140
USBTEMPBYTE	EQU	93
USBTEMPSTRING	EQU	9157
USB_IN0_ADDR	EQU	1030
USB_IN0_ADDR_H	EQU	1031
USB_IN0_CNT	EQU	1029
USB_IN0_STAT	EQU	1028
USB_OUT0_ADDR	EQU	1026
USB_OUT0_ADDR_H	EQU	1027
USB_OUT0_CNT	EQU	1025
USB_OUT0_STAT	EQU	1024

;********************************************************************************

;Alias variables
AFSR0	EQU	4
AFSR0_H	EQU	5
MEMADR	EQU	4
MEMADR_H	EQU	5
SYSHEX_0	EQU	1504
SYSHEX_1	EQU	1505
SYSHEX_2	EQU	1506
SYSREADAD10WORD	EQU	39
SYSREADAD10WORD_H	EQU	40
SYSUSBTEMPBUFFER_0	EQU	1508
SYSUSBTEMPBUFFER_1	EQU	1509
SYSUSBTEMPBUFFER_2	EQU	1510
SYSUSBTEMPBUFFER_3	EQU	1511
SYSUSBTEMPBUFFER_6	EQU	1514
SYSUSBTEMPSTRING_0	EQU	1573

;********************************************************************************

;Vectors
	ORG	0
	pagesel	BASPROGRAMSTART
	goto	BASPROGRAMSTART
	ORG	4
Interrupt

;********************************************************************************

;Save Context
	movwf	SysW
	swapf	STATUS,W
	movwf	SysSTATUS
	movf	BSR,W
	banksel	STATUS
	movwf	SysBSR
;Store system variables
	movf	SysTemp1,W
	movwf	SaveSysTemp1
	movf	SysByteTempA,W
	movwf	SaveSysByteTempA
	movf	SysByteTempB,W
	movwf	SaveSysByteTempB
	movf	FSR0L,W
	movwf	SaveFSR0L
	movf	FSR0H,W
	movwf	SaveFSR0H
	movf	SysByteTempX,W
	movwf	SaveSysByteTempX
	movf	SysDivLoop,W
	movwf	SaveSysDivLoop
	movf	SysWaitTempMS,W
	movwf	SaveSysWaitTempMS
	movf	SysWaitTempMS_H,W
	movwf	SaveSysWaitTempMS_H
	movf	DelayTemp2,W
	movwf	SaveDelayTemp2
	movf	SysTemp2,W
	movwf	SaveSysTemp2
	movf	SysStringA,W
	movwf	SaveSysStringA
	movf	FSR1H,W
	movwf	SaveFSR1H
	movf	SysStringA_H,W
	movwf	SaveSysStringA_H
	movf	SysStringLength,W
	movwf	SaveSysStringLength
	movf	PCLATH,W
	movwf	SavePCLATH
	clrf	PCLATH
;On Interrupt handlers
	banksel	PIE2
	btfss	PIE2,USBIE
	goto	NotUSBIF
	banksel	PIR2
	btfss	PIR2,USBIF
	goto	NotUSBIF
	call	USBINTERRUPTHANDLER
	bcf	PIR2,USBIF
	goto	INTERRUPTDONE
NotUSBIF
;User Interrupt routine
INTERRUPTDONE
;Restore Context
;Restore system variables
	banksel	SAVESYSTEMP1
	movf	SaveSysTemp1,W
	movwf	SysTemp1
	movf	SaveSysByteTempA,W
	movwf	SysByteTempA
	movf	SaveSysByteTempB,W
	movwf	SysByteTempB
	movf	SaveFSR0L,W
	movwf	FSR0L
	movf	SaveFSR0H,W
	movwf	FSR0H
	movf	SaveSysByteTempX,W
	movwf	SysByteTempX
	movf	SaveSysDivLoop,W
	movwf	SysDivLoop
	movf	SaveSysWaitTempMS,W
	movwf	SysWaitTempMS
	movf	SaveSysWaitTempMS_H,W
	movwf	SysWaitTempMS_H
	movf	SaveDelayTemp2,W
	movwf	DelayTemp2
	movf	SaveSysTemp2,W
	movwf	SysTemp2
	movf	SaveSysStringA,W
	movwf	SysStringA
	movf	SaveFSR1H,W
	movwf	FSR1H
	movf	SaveSysStringA_H,W
	movwf	SysStringA_H
	movf	SaveSysStringLength,W
	movwf	SysStringLength
	movf	SavePCLATH,W
	movwf	PCLATH
	movf	SysBSR,W
	movwf	BSR
	swapf	SysSTATUS,W
	movwf	STATUS
	swapf	SysW,F
	swapf	SysW,W
	retfie

;********************************************************************************

;Start of program memory page 0
	ORG	93
BASPROGRAMSTART
;Call initialisation routines
	call	INITSYS
	call	INITUSART
	call	INITUSB
;Enable interrupts
	bsf	INTCON,GIE
	bsf	INTCON,PEIE
;Automatic pin direction setting
	banksel	TRISB
	bcf	TRISB,5

;Start of the main program
;Very basic first program for USB
;#define USB_VID 0xF055
;#define USB_PID 0x1000
;#define USB_ERROR_HANDLER ErrorHandler
;#define USB_SETUP_HANDLER SetupHandler
;#define USB_DESCRIPTOR_HANDLER DescriptorHandler
;#define USB_PRODUCT_NAME "GCBASIC USB Test"
;#define LED PORTB.0
;#define ADSpeed LowSpeed
;Dim SensorValue1 As Word
;Dim SensorValue2 As Word
;Dim SensorValue3 As Word
;Dim SensorValue4 As Word
;USART
;#define USART_BAUD_RATE 115200
;#define USART_BLOCKING
;Dir PORTC.6 Out
	bcf	TRISC,6
;dir led out
	bcf	TRISB,0
;Set LED ON
	banksel	LATB
	bsf	LATB,0
;HSerPrint "USB CGB"
	movlw	low StringTable2
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable2) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT264
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	call	HSERPRINTCRLF
;LED=!LED
	clrf	SysTemp1
	btfsc	PORTB,0
	incf	SysTemp1,F
ENDIF1
	comf	SysTemp1,F
	banksel	LATB
	bcf	LATB,0
	banksel	SYSTEMP1
	btfss	SysTemp1,0
	goto	ENDIF2
	banksel	LATB
	bsf	LATB,0
ENDIF2
;InitUSB
	banksel	STATUS
	call	INITUSB
;Main loop, read from ADC and cache
;Do
SysDoLoop_S1
;SensorValue1 = ReadAD10(AN0)
	clrf	ADREADPORT
	call	FN_READAD1016
	movf	SYSREADAD10WORD,W
	movwf	SENSORVALUE1
	movf	SYSREADAD10WORD_H,W
	movwf	SENSORVALUE1_H
;Wait 1 ms
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;SensorValue2 = ReadAD10(AN1)
	movlw	1
	movwf	ADREADPORT
	call	FN_READAD1016
	movf	SYSREADAD10WORD,W
	movwf	SENSORVALUE2
	movf	SYSREADAD10WORD_H,W
	movwf	SENSORVALUE2_H
;Wait 1 ms
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;SensorValue3 = ReadAD10(AN2)
	movlw	2
	movwf	ADREADPORT
	call	FN_READAD1016
	movf	SYSREADAD10WORD,W
	movwf	SENSORVALUE3
	movf	SYSREADAD10WORD_H,W
	movwf	SENSORVALUE3_H
;Wait 1 ms
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;SensorValue4 = ReadAD10(AN3)
	movlw	3
	movwf	ADREADPORT
	call	FN_READAD1016
	movf	SYSREADAD10WORD,W
	movwf	SENSORVALUE4
	movf	SYSREADAD10WORD_H,W
	movwf	SENSORVALUE4_H
;Loop
	goto	SysDoLoop_S1
SysDoLoop_E1
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

;********************************************************************************

DESCRIPTORHANDLER
;HSerPrint "Desc "
	movlw	low StringTable5
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable5) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT264
;HSerPrint USBDescType
	movf	USBDESCTYPE,W
	movwf	SERPRINTVAL
	movlw	1
	movwf	COMPORT
	call	HSERPRINT265
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	goto	HSERPRINTCRLF

;********************************************************************************

Delay_10US
D10US_START
	movlw	39
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
	movlw	179
	movwf	DELAYTEMP2
DMS_OUTER
	movlw	21
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

ERRORHANDLER
;HSerPrint "E"
	movlw	low StringTable3
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable3) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT264
;HSerPrint Hex(UEIR)
	banksel	UEIR
	movf	UEIR,W
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	call	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT264
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	goto	HSERPRINTCRLF

;********************************************************************************

FN_HEX
;Hex(0) = 2
	movlw	2
	banksel	SYSHEX_0
	movwf	SYSHEX_0
;Low nibble
;SysStringTemp = SysValTemp And 0x0F
	movlw	15
	banksel	SYSVALTEMP
	andwf	SYSVALTEMP,W
	movwf	SYSSTRINGTEMP
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	sublw	9
	btfsc	STATUS, C
	goto	ENDIF42
	movlw	7
	addwf	SYSSTRINGTEMP,F
ENDIF42
;Hex(2) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W
	banksel	SYSHEX_2
	movwf	SYSHEX_2
;Get high nibble
;For SysStringTemp = 1 to 4
	banksel	SYSSTRINGTEMP
	clrf	SYSSTRINGTEMP
SysForLoop7
	incf	SYSSTRINGTEMP,F
;Rotate SysValTemp Right
	rrf	SYSVALTEMP,F
;Next
	movlw	4
	subwf	SYSSTRINGTEMP,W
	btfss	STATUS, C
	goto	SysForLoop7
ENDIF43
SysForLoopEnd7
;SysStringTemp = SysValTemp And 0x0F
	movlw	15
	andwf	SYSVALTEMP,W
	movwf	SYSSTRINGTEMP
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	sublw	9
	btfsc	STATUS, C
	goto	ENDIF44
	movlw	7
	addwf	SYSSTRINGTEMP,F
ENDIF44
;Hex(1) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W
	banksel	SYSHEX_1
	movwf	SYSHEX_1
	banksel	STATUS
	return

;********************************************************************************

;Overloaded signature: STRING:byte:
HSERPRINT264
;PrintLen = LEN(PrintData$)
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
	goto	ENDIF38
;Write Data
;for SysPrintTemp = 1 to PrintLen
	clrf	SYSPRINTTEMP
	movlw	1
	subwf	PRINTLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd6
ENDIF39
SysForLoop6
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
	goto	SysForLoop6
ENDIF40
SysForLoopEnd6
;End If
ENDIF38
;CR
	return

;********************************************************************************

;Overloaded signature: BYTE:byte:
HSERPRINT265
;OutValueTemp = 0
	clrf	OUTVALUETEMP
;IF SerPrintVal >= 100 Then
	movlw	100
	subwf	SERPRINTVAL,W
	btfss	STATUS, C
	goto	ENDIF45
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
ENDIF45
;If OutValueTemp > 0 Or SerPrintVal >= 10 Then
	movf	OUTVALUETEMP,W
	movwf	SysBYTETempB
	clrf	SysBYTETempA
	call	SysCompLessThan
	movf	SysByteTempX,W
	movwf	SysTemp2
	movf	SERPRINTVAL,W
	movwf	SysBYTETempA
	movlw	10
	movwf	SysBYTETempB
	call	SysCompLessThan
	comf	SysByteTempX,F
	movf	SysTemp2,W
	iorwf	SysByteTempX,W
	movwf	SysTemp1
	btfss	SysTemp1,0
	goto	ENDIF46
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
ENDIF46
;HSerSend(SerPrintVal + 48 ,comport)
	movlw	48
	addwf	SERPRINTVAL,W
	movwf	SERDATA
	call	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;CR
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
;Block before sending (if needed)
;Send byte
;if comport = 1 Then
	decf	COMPORT,W
	btfss	STATUS, Z
	goto	ENDIF37
;HSerSendBlocker
;Wait While TXIF = Off
SysWaitLoop3
	btfss	PIR1,TXIF
	goto	SysWaitLoop3
;TXREG = SerData
	movf	SERDATA,W
	banksel	TXREG
	movwf	TXREG
;exit sub
	banksel	STATUS
	return
;end if
ENDIF37
	return

;********************************************************************************

INITSYS
;asm showdebug OSCCON type is 105 'Bit(SPLLEN) Or Bit(IRCF3) And NoBit(INTSRC) and ifdef Bit(IRCF3)
;osccon type is 105
;Same as for 16, assuming 48 MHz clock is 16 MHz x 3
;OSCCON = OSCCON OR b'01111000'
;Set IRCF3 On
	banksel	OSCCON
	bsf	OSCCON,IRCF3
;Set IRCF2 On
	bsf	OSCCON,IRCF2
;Set IRCF1 On
	bsf	OSCCON,IRCF1
;Set IRCF0 On
	bsf	OSCCON,IRCF0
;Set SPLLMULT On
	bsf	OSCCON,SPLLMULT
;Set SPLLEN On
	bsf	OSCCON,SPLLEN
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
	bcf	ADCON1,ADFM
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON
;Commence clearing any ANSEL variants in the part
;ANSELA = 0
	banksel	ANSELA
	clrf	ANSELA
;ANSELB = 0
	clrf	ANSELB
;ANSELC = 0
	clrf	ANSELC
;End clearing any ANSEL variants in the part
;Comparator register bits for 12F510,16F506, PIC16F1535 classes
;C2ON = 0
	banksel	CM2CON0
	bcf	CM2CON0,C2ON
;C1ON = 0
	bcf	CM1CON0,C1ON
;Turn off all ports
;PORTA = 0
	banksel	PORTA
	clrf	PORTA
;PORTB = 0
	clrf	PORTB
;PORTC = 0
	clrf	PORTC
	return

;********************************************************************************

INITUSART
;Set the default value for comport
;comport = 1
	movlw	1
	movwf	COMPORT
;Set baud rate for legacy chips
;SPBRG = SPBRGL_TEMP
	movlw	103
	banksel	SPBRG
	movwf	SPBRG
;SPBRGH = SPBRGH_TEMP
	clrf	SPBRGH
;BRG16 = BRG16_TEMP
	bsf	BAUDCON,BRG16
;BRGH = BRGH_TEMP
	bsf	TXSTA,BRGH
;Enable async mode
;Set SYNC Off
	bcf	TXSTA,SYNC
;SPEN=1
	bsf	RCSTA,SPEN
;Enable TX and RX
;CREN=1
	bsf	RCSTA,CREN
;Set TXEN On
	bsf	TXSTA,TXEN
;PIC USART 2 Init
	banksel	STATUS
	return

;********************************************************************************

INITUSB
;Time for PLL to stabilise
;Wait 2 ms
	movlw	2
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;Add interrupt handlers
;UIE = 127
	movlw	127
	banksel	UIE
	movwf	UIE
;UEIE = b'10011111'
	movlw	159
	movwf	UEIE
;On Interrupt USB Call USBInterruptHandler
	banksel	PIE2
	bsf	PIE2,USBIE
;Set up USB module
;Set UCFG.FSEN On
	banksel	UCFG
	bsf	UCFG,FSEN
;Set UCFG.UPUEN On
	bsf	UCFG,UPUEN
;USBResetEndpoints
;Take ownership of all endpoints
;USB_OUT0_STAT = 8
	movlw	8
	banksel	USB_OUT0_STAT
	movwf	USB_OUT0_STAT
;USB_IN0_STAT = 8
	movlw	8
	movwf	USB_IN0_STAT
;Clear transmission complete flag
;Do While TRNIF
SysDoLoop_S2
	banksel	UIR
	btfss	UIR,TRNIF
	goto	SysDoLoop_E2
;TRNIF = 0
	bcf	UIR,TRNIF
;Loop
	goto	SysDoLoop_S2
SysDoLoop_E2
;Disable endpoints
;UEP0 = 0
	clrf	UEP0
;USB_IN0_ADDR = USB_RAM_START + 64
	movlw	64
	banksel	USB_IN0_ADDR
	movwf	USB_IN0_ADDR
	movlw	4
	movwf	USB_IN0_ADDR_H
;USB_OUT0_ADDR = USB_RAM_START + 64 + USB_MAX_PACKET
	movlw	192
	movwf	USB_OUT0_ADDR
	movlw	4
	movwf	USB_OUT0_ADDR_H
;Set buffer data counts to 0
;USB_IN0_CNT = 0
	clrf	USB_IN0_CNT
;USB_OUT0_CNT = USB_MAX_PACKET
	movlw	128
	movwf	USB_OUT0_CNT
;USB_IN0_STAT = 8
	movlw	8
	movwf	USB_IN0_STAT
;USB_OUT0_STAT = 0x88
	movlw	136
	movwf	USB_OUT0_STAT
;Set up endpoint 0 for handshaking, setup, in and out, but not stalled
;PKTDIS = 0
	banksel	UCON
	bcf	UCON,PKTDIS
;UEP0 = b'00010110'
	movlw	22
	movwf	UEP0
;Clear interrupt flags
;UIR = 0
	clrf	UIR
;UEIR = 0
	clrf	UEIR
;UADDR = 0
	clrf	UADDR
;USBState = USB_STATE_POWERED
	banksel	USBSTATE
	clrf	USBSTATE
;USBCurrConfiguration = 0
	clrf	USBCURRCONFIGURATION
;Enable
;Set UCON.USBEN On
	banksel	UCON
	bsf	UCON,USBEN
	banksel	STATUS
	return

;********************************************************************************

FN_PEEK
;FSR0H = MemAdr_H
	movf	MEMADR_H,W
	movwf	FSR0H
;FSR0L = MemAdr
	movf	MEMADR,W
	movwf	FSR0L
;PEEK = INDF0
	movf	INDF0,W
	movwf	PEEK
	return

;********************************************************************************

POKE
;Dim MemAdr As Word Alias FSR0H, FSR0L
;FSR0H = MemAdr_H
;FSR0L = MemAdr
;INDF0 = MemData
	movf	MEMDATA,W
	movwf	INDF0
	return

;********************************************************************************

;Overloaded signature: BYTE:
FN_READAD1016
;Always RIGHT justified
;SET ADFM ON
	banksel	ADCON1
	bsf	ADCON1,ADFM
;A differential ADC
;Do conversion
;LLReadAD 0
;Set up A/D
;Make necessary ports analog
;Code for PICs with older A/D (No ANSEL register)
;Code for 16F193x chips (and others?) with ANSELA/ANSELB/ANSELE registers
;Select Case ADReadPort ' #IFDEF Var(ANSELA). ANSELA exists @DebugADC_H
;based on 16f1709 annd 16f685
;Case 0: Set ANSELA.0 On
SysSelect6Case1
	banksel	ADREADPORT
	movf	ADREADPORT,F
	btfss	STATUS, Z
	goto	SysSelect6Case2
	banksel	ANSELA
	bsf	ANSELA,0
;Case 1: Set ANSELA.1 On
	goto	SysSelectEnd6
SysSelect6Case2
	decf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect6Case3
	banksel	ANSELA
	bsf	ANSELA,1
;Case 2: Set ANSELA.2 On
	goto	SysSelectEnd6
SysSelect6Case3
	movlw	2
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect6Case4
	banksel	ANSELA
	bsf	ANSELA,2
;Case 3: Set ANSELA.4 On
	goto	SysSelectEnd6
SysSelect6Case4
	movlw	3
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect6Case5
	banksel	ANSELA
	bsf	ANSELA,4
;Case 4: Set ANSELc.0 On
	goto	SysSelectEnd6
SysSelect6Case5
	movlw	4
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect6Case6
	banksel	ANSELC
	bsf	ANSELC,0
;Case 5: Set ANSELc.1 On
	goto	SysSelectEnd6
SysSelect6Case6
	movlw	5
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect6Case7
	banksel	ANSELC
	bsf	ANSELC,1
;Case 6: Set ANSELc.2 On
	goto	SysSelectEnd6
SysSelect6Case7
	movlw	6
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect6Case8
	banksel	ANSELC
	bsf	ANSELC,2
;Case 7: Set ANSELc.3 On
	goto	SysSelectEnd6
SysSelect6Case8
	movlw	7
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect6Case9
	banksel	ANSELC
	bsf	ANSELC,3
;Case 8: Set ANSELc.6 On
	goto	SysSelectEnd6
SysSelect6Case9
	movlw	8
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect6Case10
	banksel	ANSELC
	bsf	ANSELC,6
;Case 9: Set ANSELc.7 On
	goto	SysSelectEnd6
SysSelect6Case10
	movlw	9
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect6Case11
	banksel	ANSELC
	bsf	ANSELC,7
;Case 10: Set ANSELb.4 On
	goto	SysSelectEnd6
SysSelect6Case11
	movlw	10
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect6Case12
	banksel	ANSELB
	bsf	ANSELB,4
;Case 11: Set ANSELb.5 On
	goto	SysSelectEnd6
SysSelect6Case12
	movlw	11
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelectEnd6
	banksel	ANSELB
	bsf	ANSELB,5
;End Select  'End Select #1
SysSelectEnd6
;ANSEL0/ANSEL
;Code for PICs with newer A/D (with ANSEL register)
;Code for 18F4431, uses ANSEL0 and ANSEL1
;Set Auto or Single Convert Mode
;Set conversion clock - improved to handle ADCS2
;SET ADCS2 OFF
	banksel	ADCON1
	bcf	ADCON1,ADCS2
;SET ADCS1 ON
	bsf	ADCON1,ADCS1
;SET ADCS0 OFF
	bcf	ADCON1,ADCS0
;Choose port
;SET CHS0 OFF
	bcf	ADCON0,CHS0
;SET CHS1 OFF
	bcf	ADCON0,CHS1
;SET CHS2 OFF
	bcf	ADCON0,CHS2
;SET CHS3 OFF
	bcf	ADCON0,CHS3
;SET CHS4 OFF
	bcf	ADCON0,CHS4
;IF ADReadPort.0 On Then Set CHS0 On
	banksel	ADREADPORT
	btfss	ADREADPORT,0
	goto	ENDIF32
	banksel	ADCON0
	bsf	ADCON0,CHS0
ENDIF32
;IF ADReadPort.1 On Then Set CHS1 On
	banksel	ADREADPORT
	btfss	ADREADPORT,1
	goto	ENDIF33
	banksel	ADCON0
	bsf	ADCON0,CHS1
ENDIF33
;IF ADReadPort.2 On Then Set CHS2 On
	banksel	ADREADPORT
	btfss	ADREADPORT,2
	goto	ENDIF34
	banksel	ADCON0
	bsf	ADCON0,CHS2
ENDIF34
;If ADReadPort.3 On Then Set CHS3 On
	banksel	ADREADPORT
	btfss	ADREADPORT,3
	goto	ENDIF35
	banksel	ADCON0
	bsf	ADCON0,CHS3
ENDIF35
;If ADReadPort.4 On Then Set CHS4 On
	banksel	ADREADPORT
	btfss	ADREADPORT,4
	goto	ENDIF36
	banksel	ADCON0
	bsf	ADCON0,CHS4
ENDIF36
;***  'Special section for 16F1688x Chips ***
;Enable A/D
;SET ADON ON
	banksel	ADCON0
	bsf	ADCON0,ADON
;Acquisition Delay
;Wait AD_Delay
	movlw	2
	movwf	SysWaitTemp10US
	banksel	STATUS
	call	Delay_10US
;Read A/D
;SET GO_NOT_DONE ON
	banksel	ADCON0
	bsf	ADCON0,GO_NOT_DONE
;nop
	nop
;Wait While GO_NOT_DONE ON
SysWaitLoop2
	btfsc	ADCON0,GO_NOT_DONE
	goto	SysWaitLoop2
;Switch off A/D
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON
;Clear whatever ANSEL variants the chip has
;ANSELA = 0
	banksel	ANSELA
	clrf	ANSELA
;ANSELB = 0
	clrf	ANSELB
;ANSELC = 0
	clrf	ANSELC
;Write output
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
;Put A/D format back to normal
;SET ADFM OFF
	banksel	ADCON1
	bcf	ADCON1,ADFM
	banksel	STATUS
	return

;********************************************************************************

SETUPHANDLER
;Select Case USBTempBuffer(1)
;Control transfer 131, turn on LED
;Case 131
SysSelect7Case1
	movlw	131
	banksel	SYSUSBTEMPBUFFER_1
	subwf	SYSUSBTEMPBUFFER_1,W
	btfss	STATUS, Z
	goto	SysSelect7Case2
;Set PORTB.5 On
	banksel	LATB
	bsf	LATB,5
;USBSendData1Ack
	banksel	STATUS
	call	USBSENDDATA1ACK
;Control transfer 132, turn off LED
;Case 132
	goto	SysSelectEnd7
SysSelect7Case2
	movlw	132
	subwf	SYSUSBTEMPBUFFER_1,W
	btfss	STATUS, Z
	goto	SysSelect7Case3
;Set PORTB.5 Off
	banksel	LATB
	bcf	LATB,5
;USBSendData1Ack
	banksel	STATUS
	call	USBSENDDATA1ACK
;Control transfer 133, send back ADC readings
;Case 133
	goto	SysSelectEnd7
SysSelect7Case3
	movlw	133
	subwf	SYSUSBTEMPBUFFER_1,W
	btfss	STATUS, Z
	goto	SysSelect7Case4
;USB_IN0_CNT = 8
	movlw	8
	banksel	USB_IN0_CNT
	movwf	USB_IN0_CNT
;Poke USB_IN0_ADDR, SensorValue1
	movf	USB_IN0_ADDR,W
	movwf	MEMADR
	movf	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	banksel	SENSORVALUE1
	movf	SENSORVALUE1,W
	movwf	MEMDATA
	call	POKE
;Poke USB_IN0_ADDR + 1, SensorValue1_H
	movlw	1
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W
	movwf	MEMADR
	movlw	0
	addwfc	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	banksel	SENSORVALUE1_H
	movf	SENSORVALUE1_H,W
	movwf	MEMDATA
	call	POKE
;Poke USB_IN0_ADDR + 2, SensorValue2
	movlw	2
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W
	movwf	MEMADR
	movlw	0
	addwfc	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	banksel	SENSORVALUE2
	movf	SENSORVALUE2,W
	movwf	MEMDATA
	call	POKE
;Poke USB_IN0_ADDR + 3, SensorValue2_H
	movlw	3
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W
	movwf	MEMADR
	movlw	0
	addwfc	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	banksel	SENSORVALUE2_H
	movf	SENSORVALUE2_H,W
	movwf	MEMDATA
	call	POKE
;Poke USB_IN0_ADDR + 4, SensorValue3
	movlw	4
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W
	movwf	MEMADR
	movlw	0
	addwfc	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	banksel	SENSORVALUE3
	movf	SENSORVALUE3,W
	movwf	MEMDATA
	call	POKE
;Poke USB_IN0_ADDR + 5, SensorValue3_H
	movlw	5
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W
	movwf	MEMADR
	movlw	0
	addwfc	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	banksel	SENSORVALUE3_H
	movf	SENSORVALUE3_H,W
	movwf	MEMDATA
	call	POKE
;Poke USB_IN0_ADDR + 6, SensorValue4
	movlw	6
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W
	movwf	MEMADR
	movlw	0
	addwfc	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	banksel	SENSORVALUE4
	movf	SENSORVALUE4,W
	movwf	MEMDATA
	call	POKE
;Poke USB_IN0_ADDR + 7, SensorValue4_H
	movlw	7
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W
	movwf	MEMADR
	movlw	0
	addwfc	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	banksel	SENSORVALUE4_H
	movf	SENSORVALUE4_H,W
	movwf	MEMDATA
	call	POKE
;USBStartSend
;If USB_IN0_STAT.6 Then
	banksel	USB_IN0_STAT
	btfss	USB_IN0_STAT,6
	goto	ELSE41_1
;USB_IN0_STAT = b'10001000'
	movlw	136
	movwf	USB_IN0_STAT
;Else
	goto	ENDIF41
ELSE41_1
;USB_IN0_STAT = b'11001000'
	movlw	200
	movwf	USB_IN0_STAT
;End If
ENDIF41
;It broke
;Case Else
	goto	SysSelectEnd7
SysSelect7Case4
;HSerPrint "Req "
	movlw	low StringTable4
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable4) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	call	HSERPRINT264
;HSerPrint USBTempBuffer(1)
	banksel	SYSUSBTEMPBUFFER_1
	movf	SYSUSBTEMPBUFFER_1,W
	banksel	SERPRINTVAL
	movwf	SERPRINTVAL
	movlw	1
	movwf	COMPORT
	call	HSERPRINT265
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	call	HSERPRINTCRLF
;End Select
SysSelectEnd7
	banksel	STATUS
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

SYSDIVSUB
;dim SysByteTempA as byte
;dim SysByteTempB as byte
;dim SysByteTempX as byte
;Check for div/0
;movf SysByteTempB, F
	movf	SYSBYTETEMPB, F
;btfsc STATUS, Z
	btfsc	STATUS, Z
;return
	return
;Main calc routine
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
;Get length
;call SysStringTables
	call	SYSSTRINGTABLES
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA
;movwf INDF1
	movwf	INDF1
;goto SysStringReadCheck
	goto	SYSSTRINGREADCHECK
SYSREADSTRINGPART
;Get length
;call SysStringTables
	call	SYSSTRINGTABLES
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA
;addwf SysStringLength,F
	addwf	SYSSTRINGLENGTH,F
;Check length
SYSSTRINGREADCHECK
;If length is 0, exit
;movf SysCalcTempA,F
	movf	SYSCALCTEMPA,F
;btfsc STATUS,Z
	btfsc	STATUS,Z
;return
	return
;Copy
SYSSTRINGREAD
;Get char
;call SysStringTables
	call	SYSSTRINGTABLES
;Set char
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
	retlw	16
	retlw	71	;G
	retlw	67	;C
	retlw	66	;B
	retlw	65	;A
	retlw	83	;S
	retlw	73	;I
	retlw	67	;C
	retlw	32	; 
	retlw	85	;U
	retlw	83	;S
	retlw	66	;B
	retlw	32	; 
	retlw	84	;T
	retlw	101	;e
	retlw	115	;s
	retlw	116	;t


StringTable2
	retlw	7
	retlw	85	;U
	retlw	83	;S
	retlw	66	;B
	retlw	32	; 
	retlw	67	;C
	retlw	71	;G
	retlw	66	;B


StringTable3
	retlw	1
	retlw	69	;E


StringTable4
	retlw	4
	retlw	82	;R
	retlw	101	;e
	retlw	113	;q
	retlw	32	; 


StringTable5
	retlw	5
	retlw	68	;D
	retlw	101	;e
	retlw	115	;s
	retlw	99	;c
	retlw	32	; 


StringTable6
	retlw	9
	retlw	71	;G
	retlw	114	;r
	retlw	101	;e
	retlw	97	;a
	retlw	116	;t
	retlw	32	; 
	retlw	67	;C
	retlw	111	;o
	retlw	119	;w


StringTable9
	retlw	0


;********************************************************************************

USBCONFIGDESCRIPTOR
	movlw	18
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableUSBCONFIGDESCRIPTOR
	movwf	SysStringA
	movlw	(high TableUSBCONFIGDESCRIPTOR) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableUSBCONFIGDESCRIPTOR
	retlw	18
	retlw	9
	retlw	2
	retlw	18
	retlw	0
	retlw	1
	retlw	1
	retlw	0
	retlw	128
	retlw	25
	retlw	9
	retlw	4
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	0
	retlw	255

;********************************************************************************

USBDEVICEDESCRIPTOR
	movlw	19
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableUSBDEVICEDESCRIPTOR
	movwf	SysStringA
	movlw	(high TableUSBDEVICEDESCRIPTOR) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableUSBDEVICEDESCRIPTOR
	retlw	18
	retlw	18
	retlw	1
	retlw	0
	retlw	2
	retlw	0
	retlw	0
	retlw	0
	retlw	64
	retlw	85
	retlw	240
	retlw	0
	retlw	16
	retlw	1
	retlw	1
	retlw	1
	retlw	2
	retlw	0
	retlw	1

;********************************************************************************

USBDEVICEQUALDESCRIPTOR
	movlw	10
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableUSBDEVICEQUALDESCRIPTOR
	movwf	SysStringA
	movlw	(high TableUSBDEVICEQUALDESCRIPTOR) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableUSBDEVICEQUALDESCRIPTOR
	retlw	10
	retlw	10
	retlw	6
	retlw	0
	retlw	2
	retlw	0
	retlw	0
	retlw	0
	retlw	64
	retlw	1

;********************************************************************************

USBINTERRUPTHANDLER
;Event that should be handled by library?
;Reset
;If URSTIF Then
	banksel	UIR
	btfss	UIR,URSTIF
	goto	ENDIF3
;USBResetEndpoints
;Take ownership of all endpoints
;USB_OUT0_STAT = 8
	movlw	8
	banksel	USB_OUT0_STAT
	movwf	USB_OUT0_STAT
;USB_IN0_STAT = 8
	movlw	8
	movwf	USB_IN0_STAT
;Clear transmission complete flag
;Do While TRNIF
SysDoLoop_S3
	banksel	UIR
	btfss	UIR,TRNIF
	goto	SysDoLoop_E3
;TRNIF = 0
	bcf	UIR,TRNIF
;Loop
	goto	SysDoLoop_S3
SysDoLoop_E3
;Disable endpoints
;UEP0 = 0
	clrf	UEP0
;USB_IN0_ADDR = USB_RAM_START + 64
	movlw	64
	banksel	USB_IN0_ADDR
	movwf	USB_IN0_ADDR
	movlw	4
	movwf	USB_IN0_ADDR_H
;USB_OUT0_ADDR = USB_RAM_START + 64 + USB_MAX_PACKET
	movlw	192
	movwf	USB_OUT0_ADDR
	movlw	4
	movwf	USB_OUT0_ADDR_H
;Set buffer data counts to 0
;USB_IN0_CNT = 0
	clrf	USB_IN0_CNT
;USB_OUT0_CNT = USB_MAX_PACKET
	movlw	128
	movwf	USB_OUT0_CNT
;USB_IN0_STAT = 8
	movlw	8
	movwf	USB_IN0_STAT
;USB_OUT0_STAT = 0x88
	movlw	136
	movwf	USB_OUT0_STAT
;Set up endpoint 0 for handshaking, setup, in and out, but not stalled
;PKTDIS = 0
	banksel	UCON
	bcf	UCON,PKTDIS
;UEP0 = b'00010110'
	movlw	22
	movwf	UEP0
;UADDR = 0
	clrf	UADDR
;Clear interrupt flags
;UEIR = 0
	clrf	UEIR
;UIR = 0
	clrf	UIR
;SUSPND = 0
	bcf	UCON,SUSPND
;Wait for single ended zero to clear
;Wait While UCON.SE0
SysWaitLoop1
	btfsc	UCON,SE0
	goto	SysWaitLoop1
;USBLastControl = USB_NONE
	movlw	255
	banksel	USBLASTCONTROL
	movwf	USBLASTCONTROL
;USBState = USB_STATE_DEFAULT
	movlw	1
	movwf	USBSTATE
;USBCurrConfiguration = 0
	clrf	USBCURRCONFIGURATION
;End If
ENDIF3
;Error
;If UERRIF Then
	banksel	UIR
	btfss	UIR,UERRIF
	goto	ENDIF4
;USB_ERROR_HANDLER
	banksel	STATUS
	call	ERRORHANDLER
;UEIR = 0
	banksel	UEIR
	clrf	UEIR
;UERRIF = 0
	bcf	UIR,UERRIF
;End If
ENDIF4
;Activity on D+/D-
;If ACTVIF Then
	btfss	UIR,ACTVIF
	goto	ENDIF5
;If activity detected, switch from suspend to normal
;SUSPND = 0
	bcf	UCON,SUSPND
;Clear ACTVIF
;Do While ACTVIF
;Set ACTVIF Off
	bcf	UIR,ACTVIF
;Loop
;End If
ENDIF5
;Transfer complete
;If TRNIF Then
	btfss	UIR,TRNIF
	goto	ENDIF6
;Determine transfer that has occurred
;USBCurrEndpoint = (USTAT And 0x78) / 8
	movlw	120
	andwf	USTAT,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movwf	SysBYTETempA
	movlw	8
	movwf	SysBYTETempB
	call	SysDivSub
	movf	SysBYTETempA,W
	movwf	USBCURRENDPOINT
;If USTAT.DIR Then
	banksel	USTAT
	btfss	USTAT,DIR
	goto	ELSE10_1
;In
;USBBufferStat = USB_IN0_STAT
	banksel	USB_IN0_STAT
	movf	USB_IN0_STAT,W
	banksel	USBBUFFERSTAT
	movwf	USBBUFFERSTAT
;Else
	goto	ENDIF10
ELSE10_1
;Setup/Out
;USBBufferStat = USB_OUT0_STAT
	banksel	USB_OUT0_STAT
	movf	USB_OUT0_STAT,W
	banksel	USBBUFFERSTAT
	movwf	USBBUFFERSTAT
;USB_OUT0_STAT.UOWN = 0
	banksel	USB_OUT0_STAT
	bcf	USB_OUT0_STAT,7
;End If
ENDIF10
;Get PID (is multiplied by 4)
;USBPID = USBBufferStat And 0x3C
	movlw	60
	banksel	USBBUFFERSTAT
	andwf	USBBUFFERSTAT,W
	movwf	USBPID
;Select Case USBPID
;Case USB_PID_OUT
SysSelect1Case1
	movlw	4
	subwf	USBPID,W
	btfss	STATUS, Z
	goto	SysSelect1Case2
;Out transfer
;HSerPrint "OUT"
;HSerPrintCRLF
;USB_OUT0_CNT = USB_MAX_PACKET
	movlw	128
	banksel	USB_OUT0_CNT
	movwf	USB_OUT0_CNT
;USB_OUT0_STAT.UOWN = 1
	bsf	USB_OUT0_STAT,7
;Case USB_PID_IN
	goto	SysSelectEnd1
SysSelect1Case2
	movlw	36
	subwf	USBPID,W
	btfss	STATUS, Z
	goto	SysSelect1Case3
;In transfer completed
;HSerPrint "IN"
;HSerPrintCRLF
;Select Case USBLastControl
;Set address completed
;Case USB_SET_ADDRESS
SysSelect2Case1
	movlw	5
	subwf	USBLASTCONTROL,W
	btfss	STATUS, Z
	goto	SysSelect2Case2
;UADDR = USBNewAddress
	movf	USBNEWADDRESS,W
	banksel	UADDR
	movwf	UADDR
;USBState = USB_STATE_ADDRESS
	movlw	2
	banksel	USBSTATE
	movwf	USBSTATE
;USBLastControl = USB_NONE
	movlw	255
	movwf	USBLASTCONTROL
;Continue responding to Get Descriptor
;Case USB_GET_DESCRIPTOR
	goto	SysSelectEnd2
SysSelect2Case2
	movlw	6
	subwf	USBLASTCONTROL,W
	btfss	STATUS, Z
	goto	SysSelect2Case3
;USBSendDescriptor
	call	USBSENDDESCRIPTOR
;Case Else
	goto	SysSelectEnd2
SysSelect2Case3
;Prepare incoming buffer again
;USB_OUT0_CNT = USB_MAX_PACKET
	movlw	128
	banksel	USB_OUT0_CNT
	movwf	USB_OUT0_CNT
;USB_OUT0_STAT = 0x88
	movlw	136
	movwf	USB_OUT0_STAT
;End Select
SysSelectEnd2
;Case USB_PID_SETUP
	goto	SysSelectEnd1
SysSelect1Case3
	movlw	52
	subwf	USBPID,W
	btfss	STATUS, Z
	goto	SysSelect1Case4
;Setup transfer
;Copy data to buffer
;For USBCurrByte = 0 to 7
	movlw	255
	movwf	USBCURRBYTE
SysForLoop1
	incf	USBCURRBYTE,F
;USBTempBuffer(USBCurrByte) = Peek(USB_OUT0_ADDR + USBCurrByte)
	movf	USBCURRBYTE,W
	banksel	USB_OUT0_ADDR
	addwf	USB_OUT0_ADDR,W
	movwf	MEMADR
	movlw	0
	addwfc	USB_OUT0_ADDR_H,W
	movwf	MEMADR_H
	banksel	STATUS
	call	FN_PEEK
	movlw	low(USBTEMPBUFFER)
	addwf	USBCURRBYTE,W
	movwf	AFSR0
	clrf	SysTemp1
	movlw	high(USBTEMPBUFFER)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movf	PEEK,W
	movwf	INDF0
;Next
	movlw	7
	subwf	USBCURRBYTE,W
	btfss	STATUS, C
	goto	SysForLoop1
ENDIF11
SysForLoopEnd1
;Stop any outgoing transmissions
;USB_IN0_STAT = 8
	movlw	8
	banksel	USB_IN0_STAT
	movwf	USB_IN0_STAT
;Prepare incoming buffer again
;USB_OUT0_CNT = USB_MAX_PACKET
	movlw	128
	movwf	USB_OUT0_CNT
;USB_OUT0_STAT = 0x88
	movlw	136
	movwf	USB_OUT0_STAT
;USBProcessSetup
	banksel	STATUS
	call	USBPROCESSSETUP
;USBDumpControlIn
;HSerPrint "S"
;HSerPrintCRLF
;Case Else
	goto	SysSelectEnd1
SysSelect1Case4
;HSerPrint "PID Err "
;HSerPrint USBPID
;HSerPrintCRLF
;End Select
SysSelectEnd1
;USBHasData = True
	movlw	255
	banksel	USBHASDATA
	movwf	USBHASDATA
;TRNIF = 0
	banksel	UIR
	bcf	UIR,TRNIF
;End If
ENDIF6
;Idle
;If IDLEIF Then
	btfsc	UIR,IDLEIF
;IDLEIF = 0
	bcf	UIR,IDLEIF
;End If
ENDIF7
;Stalled
;If STALLIF Then
	btfsc	UIR,STALLIF
;STALLIF = 0
	bcf	UIR,STALLIF
;End If
ENDIF8
;Start of frame
;If SOFIF Then
	btfsc	UIR,SOFIF
;SOFIF = 0
	bcf	UIR,SOFIF
;End If
ENDIF9
	banksel	STATUS
	return

;********************************************************************************

USBPROCESSSETUP
;Buffer format:
;0:bmRequestType 1:bRequest 3-2:wValue 5-4:wIndex 7-6:wLength
;USBbmRequestType = USBTempBuffer(0) And 0x7F
	movlw	127
	banksel	SYSUSBTEMPBUFFER_0
	andwf	SYSUSBTEMPBUFFER_0,W
	banksel	USBBMREQUESTTYPE
	movwf	USBBMREQUESTTYPE
;Re-enable input processing
;PKTDIS = 0
	banksel	UCON
	bcf	UCON,PKTDIS
;Device requests
;If USBbmRequestType = 0 Then
	banksel	USBBMREQUESTTYPE
	movf	USBBMREQUESTTYPE,F
	btfss	STATUS, Z
	goto	ELSE12_1
;USBLastControl = USB_NONE
	movlw	255
	movwf	USBLASTCONTROL
;Select Case USBTempBuffer(1)
;Case USB_GET_STATUS
;Case USB_CLEAR_FEATURE
;Case USB_SET_FEATURE
;Case USB_SET_ADDRESS
SysSelect3Case1
	movlw	5
	banksel	SYSUSBTEMPBUFFER_1
	subwf	SYSUSBTEMPBUFFER_1,W
	btfss	STATUS, Z
	goto	SysSelect3Case2
;USBLastControl = USB_SET_ADDRESS
	movlw	5
	banksel	USBLASTCONTROL
	movwf	USBLASTCONTROL
;USBNewAddress = USBTempBuffer(2)
	banksel	SYSUSBTEMPBUFFER_2
	movf	SYSUSBTEMPBUFFER_2,W
	banksel	USBNEWADDRESS
	movwf	USBNEWADDRESS
;Send empty DATA1 packet
;USBSendDATA1Ack
	call	USBSENDDATA1ACK
;Case USB_GET_DESCRIPTOR
	goto	SysSelectEnd3
SysSelect3Case2
	movlw	6
	subwf	SYSUSBTEMPBUFFER_1,W
	btfss	STATUS, Z
	goto	SysSelect3Case3
;USBLastControl = USB_GET_DESCRIPTOR
	movlw	6
	banksel	USBLASTCONTROL
	movwf	USBLASTCONTROL
;USBDescType = USBTempBuffer(3)
	banksel	SYSUSBTEMPBUFFER_3
	movf	SYSUSBTEMPBUFFER_3,W
	banksel	USBDESCTYPE
	movwf	USBDESCTYPE
;USBDescIndex = USBTempBuffer(2)
	banksel	SYSUSBTEMPBUFFER_2
	movf	SYSUSBTEMPBUFFER_2,W
	banksel	USBDESCINDEX
	movwf	USBDESCINDEX
;USBDescSizeIn = USBTempBuffer(6)
	banksel	SYSUSBTEMPBUFFER_6
	movf	SYSUSBTEMPBUFFER_6,W
	banksel	USBDESCSIZEIN
	movwf	USBDESCSIZEIN
;USBDescStart = 0
	clrf	USBDESCSTART
;USBSendDescriptor
	call	USBSENDDESCRIPTOR
;Case USB_SET_DESCRIPTOR
;Case USB_GET_CONFIGURATION
;Case USB_SET_CONFIGURATION
	goto	SysSelectEnd3
SysSelect3Case3
	movlw	9
	subwf	SYSUSBTEMPBUFFER_1,W
	btfss	STATUS, Z
	goto	SysSelect3Case4
;USBCurrConfiguration = USBTempBuffer(2)
	movf	SYSUSBTEMPBUFFER_2,W
	banksel	USBCURRCONFIGURATION
	movwf	USBCURRCONFIGURATION
;If USBCurrConfiguration = 0 Then
	movf	USBCURRCONFIGURATION,F
	btfss	STATUS, Z
	goto	ELSE13_1
;USBState = USB_STATE_ADDRESS
	movlw	2
	movwf	USBSTATE
;Else
	goto	ENDIF13
ELSE13_1
;USBState = USB_STATE_CONFIGURED
	movlw	3
	movwf	USBSTATE
;End If
ENDIF13
;USBSendData1Ack
	call	USBSENDDATA1ACK
;It broke
;Case Else
	goto	SysSelectEnd3
SysSelect3Case4
;USB_SETUP_HANDLER
	banksel	STATUS
	call	SETUPHANDLER
;End Select
SysSelectEnd3
;Else
	goto	ENDIF12
ELSE12_1
;USBDumpControlIn
;USB_SETUP_HANDLER
	call	SETUPHANDLER
;End If
ENDIF12
	return

;********************************************************************************

USBSENDDATA1ACK
;USB_IN0_CNT = 0
	banksel	USB_IN0_CNT
	clrf	USB_IN0_CNT
;USB_IN0_STAT = 0xC8
	movlw	200
	movwf	USB_IN0_STAT
	banksel	STATUS
	return

;********************************************************************************

USBSENDDESCRIPTOR
;Descriptor types:
;1: Device
;2: Configuration
;4: Interface
;5: Endpoint
;3: String
;To send, need to copy into EP0 IN buffer
;Take ownership
;USB_IN0_STAT.UOWN = 0
	banksel	USB_IN0_STAT
	bcf	USB_IN0_STAT,7
;Select Case USBDescType
;Device
;Case 1
SysSelect4Case1
	banksel	USBDESCTYPE
	decf	USBDESCTYPE,W
	btfss	STATUS, Z
	goto	SysSelect4Case2
;Copy bytes into buffer
;ReadTable USB_DEVICE_DESCRIPTOR, 1, USBSize
	movlw	18
	movwf	USBSIZE
;If USBSize > USBDescSizeIn Then USBSize = USBDescSizeIn
	subwf	USBDESCSIZEIN,W
	btfsc	STATUS, C
	goto	ENDIF14
	movf	USBDESCSIZEIN,W
	movwf	USBSIZE
ENDIF14
;If USBDescStart >= USBSize Then
	movf	USBSIZE,W
	subwf	USBDESCSTART,W
	btfss	STATUS, C
	goto	ELSE15_1
;USBSize = 0
	clrf	USBSIZE
;USBLastControl = USB_NONE
	movlw	255
	movwf	USBLASTCONTROL
;Else
	goto	ENDIF15
ELSE15_1
;USBSize -= USBDescStart
	movf	USBDESCSTART,W
	subwf	USBSIZE,F
;End If
ENDIF15
;For USBCurrByte = 1 To USBSize
	clrf	USBCURRBYTE
	movlw	1
	subwf	USBSIZE,W
	btfss	STATUS, C
	goto	SysForLoopEnd2
ENDIF16
SysForLoop2
	incf	USBCURRBYTE,F
;ReadTable USB_DEVICE_DESCRIPTOR, USBCurrByte + USBDescStart, USBTempByte
	movf	USBDESCSTART,W
	addwf	USBCURRBYTE,W
	movwf	SYSSTRINGA
	call	USBDEVICEDESCRIPTOR
	movwf	USBTEMPBYTE
;Poke USB_IN0_ADDR + (USBCurrByte - 1), USBTempByte
	decf	USBCURRBYTE,W
	movwf	SysTemp1
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W
	movwf	MEMADR
	movlw	0
	addwfc	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	banksel	USBTEMPBYTE
	movf	USBTEMPBYTE,W
	movwf	MEMDATA
	call	POKE
;Next
	movf	USBSIZE,W
	subwf	USBCURRBYTE,W
	btfss	STATUS, C
	goto	SysForLoop2
ENDIF17
SysForLoopEnd2
;USB_IN0_CNT = USBSize
	movf	USBSIZE,W
	banksel	USB_IN0_CNT
	movwf	USB_IN0_CNT
;USBDescStart += USBSize
	banksel	USBSIZE
	movf	USBSIZE,W
	addwf	USBDESCSTART,F
;Configuration
;Case 2
	goto	SysSelectEnd4
SysSelect4Case2
	movlw	2
	subwf	USBDESCTYPE,W
	btfss	STATUS, Z
	goto	SysSelect4Case3
;Copy bytes into buffer
;ReadTable USB_CONFIG_DESCRIPTOR, 0, USBSize
	movlw	18
	movwf	USBSIZE
;If USBSize > USBDescSizeIn Then USBSize = USBDescSizeIn
	subwf	USBDESCSIZEIN,W
	btfsc	STATUS, C
	goto	ENDIF18
	movf	USBDESCSIZEIN,W
	movwf	USBSIZE
ENDIF18
;If USBDescStart >= USBSize Then
	movf	USBSIZE,W
	subwf	USBDESCSTART,W
	btfss	STATUS, C
	goto	ELSE19_1
;USBSize = 0
	clrf	USBSIZE
;USBLastControl = USB_NONE
	movlw	255
	movwf	USBLASTCONTROL
;Else
	goto	ENDIF19
ELSE19_1
;USBSize -= USBDescStart
	movf	USBDESCSTART,W
	subwf	USBSIZE,F
;End If
ENDIF19
;For USBCurrByte = 1 To USBSize
	clrf	USBCURRBYTE
	movlw	1
	subwf	USBSIZE,W
	btfss	STATUS, C
	goto	SysForLoopEnd3
ENDIF20
SysForLoop3
	incf	USBCURRBYTE,F
;ReadTable USB_CONFIG_DESCRIPTOR, USBCurrByte + USBDescStart, USBTempByte
	movf	USBDESCSTART,W
	addwf	USBCURRBYTE,W
	movwf	SYSSTRINGA
	call	USBCONFIGDESCRIPTOR
	movwf	USBTEMPBYTE
;Poke USB_IN0_ADDR + (USBCurrByte - 1), USBTempByte
	decf	USBCURRBYTE,W
	movwf	SysTemp1
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W
	movwf	MEMADR
	movlw	0
	addwfc	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	banksel	USBTEMPBYTE
	movf	USBTEMPBYTE,W
	movwf	MEMDATA
	call	POKE
;Next
	movf	USBSIZE,W
	subwf	USBCURRBYTE,W
	btfss	STATUS, C
	goto	SysForLoop3
ENDIF21
SysForLoopEnd3
;USB_IN0_CNT = USBSize
	movf	USBSIZE,W
	banksel	USB_IN0_CNT
	movwf	USB_IN0_CNT
;USBDescStart += USBSize
	banksel	USBSIZE
	movf	USBSIZE,W
	addwf	USBDESCSTART,F
;Device Qualifier
;Case 6
	goto	SysSelectEnd4
SysSelect4Case3
	movlw	6
	subwf	USBDESCTYPE,W
	btfss	STATUS, Z
	goto	SysSelect4Case4
;Copy bytes into buffer
;ReadTable USBDeviceQualDescriptor, 0, USBSize
	movlw	10
	movwf	USBSIZE
;If USBSize > USBDescSizeIn Then USBSize = USBDescSizeIn
	subwf	USBDESCSIZEIN,W
	btfsc	STATUS, C
	goto	ENDIF22
	movf	USBDESCSIZEIN,W
	movwf	USBSIZE
ENDIF22
;If USBDescStart >= USBSize Then
	movf	USBSIZE,W
	subwf	USBDESCSTART,W
	btfss	STATUS, C
	goto	ELSE23_1
;USBSize = 0
	clrf	USBSIZE
;USBLastControl = USB_NONE
	movlw	255
	movwf	USBLASTCONTROL
;Else
	goto	ENDIF23
ELSE23_1
;USBSize -= USBDescStart
	movf	USBDESCSTART,W
	subwf	USBSIZE,F
;End If
ENDIF23
;For USBCurrByte = 1 To USBSize
	clrf	USBCURRBYTE
	movlw	1
	subwf	USBSIZE,W
	btfss	STATUS, C
	goto	SysForLoopEnd4
ENDIF24
SysForLoop4
	incf	USBCURRBYTE,F
;ReadTable USBDeviceQualDescriptor, USBCurrByte + USBDescStart, USBTempByte
	movf	USBDESCSTART,W
	addwf	USBCURRBYTE,W
	movwf	SYSSTRINGA
	call	USBDEVICEQUALDESCRIPTOR
	movwf	USBTEMPBYTE
;Poke USB_IN0_ADDR + (USBCurrByte - 1), USBTempByte
	decf	USBCURRBYTE,W
	movwf	SysTemp1
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W
	movwf	MEMADR
	movlw	0
	addwfc	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	banksel	USBTEMPBYTE
	movf	USBTEMPBYTE,W
	movwf	MEMDATA
	call	POKE
;Next
	movf	USBSIZE,W
	subwf	USBCURRBYTE,W
	btfss	STATUS, C
	goto	SysForLoop4
ENDIF25
SysForLoopEnd4
;USB_IN0_CNT = USBSize
	movf	USBSIZE,W
	banksel	USB_IN0_CNT
	movwf	USB_IN0_CNT
;USBDescStart += USBSize
	banksel	USBSIZE
	movf	USBSIZE,W
	addwf	USBDESCSTART,F
;String
;Case 3
	goto	SysSelectEnd4
SysSelect4Case4
	movlw	3
	subwf	USBDESCTYPE,W
	btfss	STATUS, Z
	goto	SysSelect4Case5
;If USBDescIndex = 0 Then
	movf	USBDESCINDEX,F
	btfss	STATUS, Z
	goto	ELSE26_1
;Assume that these aren't continued over
;USBLastControl = USB_NONE
	movlw	255
	movwf	USBLASTCONTROL
;Language ID
;Poke USB_IN0_ADDR, 4
	banksel	USB_IN0_ADDR
	movf	USB_IN0_ADDR,W
	movwf	MEMADR
	movf	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	movlw	4
	banksel	MEMDATA
	movwf	MEMDATA
	call	POKE
;Poke USB_IN0_ADDR + 1, 3
	movlw	1
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W
	movwf	MEMADR
	movlw	0
	addwfc	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	movlw	3
	banksel	MEMDATA
	movwf	MEMDATA
	call	POKE
;Poke USB_IN0_ADDR + 2, 0x09
	movlw	2
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W
	movwf	MEMADR
	movlw	0
	addwfc	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	movlw	9
	banksel	MEMDATA
	movwf	MEMDATA
	call	POKE
;Poke USB_IN0_ADDR + 3, 0x04
	movlw	3
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W
	movwf	MEMADR
	movlw	0
	addwfc	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	movlw	4
	banksel	MEMDATA
	movwf	MEMDATA
	call	POKE
;USB_IN0_CNT = 4
	movlw	4
	banksel	USB_IN0_CNT
	movwf	USB_IN0_CNT
;Else
	goto	ENDIF26
ELSE26_1
;Get requested string
;Select Case USBDescIndex
;Vendor name
;Case 1: USBTempString = USB_VENDOR_NAME
SysSelect5Case1
	decf	USBDESCINDEX,W
	btfss	STATUS, Z
	goto	SysSelect5Case2
	movlw	low USBTEMPSTRING
	movwf	FSR1L
	movlw	high USBTEMPSTRING
	movwf	FSR1H
	movlw	low StringTable6
	movwf	SysStringA
	movlw	(high StringTable6) & 127
	movwf	SysStringA_H
	call	SysReadString
;Product name
;Case 2: USBTempString = USB_PRODUCT_NAME
	goto	SysSelectEnd5
SysSelect5Case2
	movlw	2
	subwf	USBDESCINDEX,W
	btfss	STATUS, Z
	goto	SysSelect5Case3
	movlw	low USBTEMPSTRING
	movwf	FSR1L
	movlw	high USBTEMPSTRING
	movwf	FSR1H
	movlw	low StringTable1
	movwf	SysStringA
	movlw	(high StringTable1) & 127
	movwf	SysStringA_H
	call	SysReadString
;Other
;Case Else: USBTempString = ""
	goto	SysSelectEnd5
SysSelect5Case3
	movlw	low USBTEMPSTRING
	movwf	FSR1L
	movlw	high USBTEMPSTRING
	movwf	FSR1H
	movlw	low StringTable9
	movwf	SysStringA
	movlw	(high StringTable9) & 127
	movwf	SysStringA_H
	call	SysReadString
;End Select
SysSelectEnd5
;Format string into unicode string descriptor
;USB_IN0_CNT = 2 + (USBTempString(0) * 2)
	bcf	STATUS,C
	banksel	SYSUSBTEMPSTRING_0
	rlf	SYSUSBTEMPSTRING_0,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	2
	addwf	SysTemp1,W
	banksel	USB_IN0_CNT
	movwf	USB_IN0_CNT
;If USBDescStart > USB_IN0_CNT Then
	banksel	USBDESCSTART
	movf	USBDESCSTART,W
	banksel	USB_IN0_CNT
	subwf	USB_IN0_CNT,W
	btfsc	STATUS, C
	goto	ELSE28_1
;USB_IN0_CNT = 0
	clrf	USB_IN0_CNT
;USBLastControl = USB_NONE
	movlw	255
	banksel	USBLASTCONTROL
	movwf	USBLASTCONTROL
;Else
	goto	ENDIF28
ELSE28_1
;USB_IN0_CNT -= USBDescStart
	banksel	USBDESCSTART
	movf	USBDESCSTART,W
	banksel	USB_IN0_CNT
	subwf	USB_IN0_CNT,F
;End If
ENDIF28
;Poke USB_IN0_ADDR, USB_IN0_CNT
	banksel	USB_IN0_ADDR
	movf	USB_IN0_ADDR,W
	movwf	MEMADR
	movf	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	movf	USB_IN0_CNT,W
	banksel	MEMDATA
	movwf	MEMDATA
	call	POKE
;Poke USB_IN0_ADDR + 1, 3
	movlw	1
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W
	movwf	MEMADR
	movlw	0
	addwfc	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	movlw	3
	banksel	MEMDATA
	movwf	MEMDATA
	call	POKE
;For USBCurrByte = 1 to USBTempString(0)
	clrf	USBCURRBYTE
	movlw	1
	banksel	SYSUSBTEMPSTRING_0
	subwf	SYSUSBTEMPSTRING_0,W
	btfss	STATUS, C
	goto	SysForLoopEnd5
ENDIF29
SysForLoop5
	banksel	USBCURRBYTE
	incf	USBCURRBYTE,F
;USBTempByte = USBTempString(USBCurrByte)
	movlw	low(USBTEMPSTRING)
	addwf	USBCURRBYTE,W
	movwf	AFSR0
	clrf	SysTemp1
	movlw	high(USBTEMPSTRING)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	USBTEMPBYTE
;Poke USB_IN0_ADDR + (USBCurrByte * 2), USBTempByte
	bcf	STATUS,C
	rlf	USBCURRBYTE,W
	movwf	SysTemp1
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W
	movwf	MEMADR
	movlw	0
	addwfc	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	banksel	USBTEMPBYTE
	movf	USBTEMPBYTE,W
	movwf	MEMDATA
	call	POKE
;Poke USB_IN0_ADDR + (USBCurrByte * 2 + 1), 0
	bcf	STATUS,C
	rlf	USBCURRBYTE,W
	movwf	SysTemp1
	incf	SysTemp1,W
	movwf	SysTemp2
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W
	movwf	MEMADR
	movlw	0
	addwfc	USB_IN0_ADDR_H,W
	movwf	MEMADR_H
	banksel	MEMDATA
	clrf	MEMDATA
	call	POKE
;Next
	banksel	SYSUSBTEMPSTRING_0
	movf	SYSUSBTEMPSTRING_0,W
	banksel	USBCURRBYTE
	subwf	USBCURRBYTE,W
	btfss	STATUS, C
	goto	SysForLoop5
ENDIF30
SysForLoopEnd5
;If USB_IN0_CNT > USBDescSizeIn Then USB_IN0_CNT = USBDescSizeIn
	banksel	USB_IN0_CNT
	movf	USB_IN0_CNT,W
	banksel	USBDESCSIZEIN
	subwf	USBDESCSIZEIN,W
	btfsc	STATUS, C
	goto	ENDIF31
	movf	USBDESCSIZEIN,W
	banksel	USB_IN0_CNT
	movwf	USB_IN0_CNT
ENDIF31
;USBDescStart += USB_IN0_CNT
	banksel	USB_IN0_CNT
	movf	USB_IN0_CNT,W
	banksel	USBDESCSTART
	addwf	USBDESCSTART,F
;End If
ENDIF26
;Interface
;Case 4
;Endpoint
;Case 5
;Other
;Case Else
	goto	SysSelectEnd4
SysSelect4Case5
;USB_DESCRIPTOR_HANDLER
	call	DESCRIPTORHANDLER
;Exit Sub
	return
;End Select
SysSelectEnd4
;USBStartSend
;If USB_IN0_STAT.6 Then
	banksel	USB_IN0_STAT
	btfss	USB_IN0_STAT,6
	goto	ELSE27_1
;USB_IN0_STAT = b'10001000'
	movlw	136
	movwf	USB_IN0_STAT
;Else
	goto	ENDIF27
ELSE27_1
;USB_IN0_STAT = b'11001000'
	movlw	200
	movwf	USB_IN0_STAT
;End If
ENDIF27
	banksel	STATUS
	return

;********************************************************************************

;Start of program memory page 1
	ORG	2048
;Start of program memory page 2
	ORG	4096
;Start of program memory page 3
	ORG	6144

 END
