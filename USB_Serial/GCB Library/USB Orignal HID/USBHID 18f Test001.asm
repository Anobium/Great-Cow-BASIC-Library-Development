;Program compiled by Great Cow BASIC (0.98.02 2018-05-10)
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F25K50, r=DEC
#include <P18F25K50.inc>
 CONFIG LVP = OFF, MCLRE = OFF, WDTEN = OFF, FOSC = INTOSCIO, LS48MHZ = SYS48X8, CPUDIV = NOCLKDIV, CFGPLLEN = OFF, PLLSEL = PLL4X

;********************************************************************************

;Set aside memory locations for variables
ADREADPORT	EQU	10
COMPORT	EQU	11
DELAYTEMP	EQU	0
DELAYTEMP2	EQU	1
HEX	EQU	1968
HSERPRINTCRLFCOUNT	EQU	12
MEMDATA	EQU	13
OUTVALUETEMP	EQU	16
PEEK	EQU	17
PRINTLEN	EQU	18
READAD10	EQU	19
READAD10_H	EQU	20
SAVEDELAYTEMP2	EQU	21
SAVEFSR0H	EQU	22
SAVEFSR0L	EQU	23
SAVEFSR1H	EQU	24
SAVEFSR1L	EQU	25
SAVESYSBYTETEMPA	EQU	26
SAVESYSBYTETEMPB	EQU	27
SAVESYSBYTETEMPX	EQU	28
SAVESYSDIVLOOP	EQU	29
SAVESYSSTRINGA	EQU	30
SAVESYSSTRINGLENGTH	EQU	31
SAVESYSTEMP1	EQU	32
SAVESYSTEMP2	EQU	33
SAVESYSWAITTEMPMS	EQU	34
SAVESYSWAITTEMPMS_H	EQU	35
SENSORVALUE1	EQU	36
SENSORVALUE1_H	EQU	37
SENSORVALUE2	EQU	38
SENSORVALUE2_H	EQU	39
SENSORVALUE3	EQU	40
SENSORVALUE3_H	EQU	41
SENSORVALUE4	EQU	42
SENSORVALUE4_H	EQU	43
SERDATA	EQU	44
SERPRINTVAL	EQU	45
STRINGPOINTER	EQU	46
SYSBSR	EQU	47
SYSBYTETEMPA	EQU	5
SYSBYTETEMPB	EQU	9
SYSBYTETEMPX	EQU	0
SYSCALCTEMPA	EQU	5
SYSCALCTEMPX	EQU	0
SYSDIVLOOP	EQU	4
SYSPRINTDATAHANDLER	EQU	48
SYSPRINTDATAHANDLER_H	EQU	49
SYSPRINTTEMP	EQU	50
SYSREPEATTEMP1	EQU	51
SYSSTATUS	EQU	15
SYSSTRINGA	EQU	7
SYSSTRINGA_H	EQU	8
SYSSTRINGLENGTH	EQU	6
SYSSTRINGPARAM1	EQU	1980
SYSSTRINGPARAM2	EQU	1972
SYSSTRINGTEMP	EQU	52
SYSTEMP1	EQU	53
SYSTEMP1_H	EQU	54
SYSTEMP2	EQU	55
SYSVALTEMP	EQU	56
SYSW	EQU	14
SYSWAITTEMP10US	EQU	5
SYSWAITTEMPMS	EQU	2
SYSWAITTEMPMS_H	EQU	3
USBBMREQUESTTYPE	EQU	57
USBBUFFERSTAT	EQU	58
USBCURRBYTE	EQU	59
USBCURRCONFIGURATION	EQU	60
USBCURRENDPOINT	EQU	61
USBDESCINDEX	EQU	62
USBDESCSIZEIN	EQU	63
USBDESCSTART	EQU	64
USBDESCTYPE	EQU	65
USBHASDATA	EQU	66
USBLASTCONTROL	EQU	67
USBNEWADDRESS	EQU	68
USBPID	EQU	69
USBSIZE	EQU	70
USBSTATE	EQU	71
USBTEMPBUFFER	EQU	1988
USBTEMPBYTE	EQU	72
USBTEMPSTRING	EQU	2005
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
AFSR0	EQU	4073
AFSR0_H	EQU	4074
MEMADR	EQU	4073
MEMADR_H	EQU	4074
SYSHEX_0	EQU	1968
SYSHEX_1	EQU	1969
SYSHEX_2	EQU	1970
SYSREADAD10WORD	EQU	19
SYSREADAD10WORD_H	EQU	20
SYSUSBTEMPBUFFER_0	EQU	1988
SYSUSBTEMPBUFFER_1	EQU	1989
SYSUSBTEMPBUFFER_2	EQU	1990
SYSUSBTEMPBUFFER_3	EQU	1991
SYSUSBTEMPBUFFER_6	EQU	1994
SYSUSBTEMPSTRING_0	EQU	2005

;********************************************************************************

;Vectors
	ORG	0
	goto	BASPROGRAMSTART
	ORG	8
	bra	INTERRUPT

;********************************************************************************

;Start of program memory page 0
	ORG	12
BASPROGRAMSTART
;Call initialisation routines
	rcall	INITSYS
	rcall	INITUSART
	rcall	INITUSB
;Enable interrupts
	bsf	INTCON,GIE,ACCESS
	bsf	INTCON,PEIE,ACCESS
;Automatic pin direction setting
	bcf	TRISB,5,ACCESS

;Start of the main program
;Very basic first program for USB
;16 Mhz crystal, run at 48 MHz
;#config OSC = HSH, CFGPLLEN = On, PLLSEL = PLL3X
;// SCS FOSC; IDLEN disabled; IRCF 16MHz;
;OSCCON = 0x70;
	movlw	112
	movwf	OSCCON,ACCESS
;// INTSRC INTRC_31_25KHz; PLLEN enabled; PRISD disabled; SOSCGO disabled;
;OSCCON2 = 0x10;
	movlw	16
	movwf	OSCCON2,ACCESS
;// SPLLMULT 3xPLL; TUN 0;
;OSCTUNE = 0x80;
	movlw	128
	movwf	OSCTUNE,ACCESS
;// ACTSRC SOSC; ACTUD enabled; ACTEN disabled;
;ACTCON = 0x00;
	clrf	ACTCON,ACCESS
;// Wait for PLL to stabilize
;wait while (PLLRDY = 0)
SysWaitLoop1
	btfss	OSCCON2,PLLRDY,ACCESS
	bra	SysWaitLoop1
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
	bcf	TRISC,6,ACCESS
;dir led out
	bcf	TRISB,0,ACCESS
;Set LED ON
	bsf	LATB,0,ACCESS
;HSerPrint "USB CGB"
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
	rcall	HSERPRINT264
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF
;LED=!LED
	clrf	SysTemp1,BANKED
	btfsc	PORTB,0,ACCESS
	incf	SysTemp1,F,BANKED
ENDIF1
	comf	SysTemp1,F,BANKED
	bcf	LATB,0,ACCESS
	btfsc	SysTemp1,0,BANKED
	bsf	LATB,0,ACCESS
ENDIF2
;InitUSB
	rcall	INITUSB
;Main loop, read from ADC and cache
;Do
SysDoLoop_S1
;SensorValue1 = ReadAD10(AN0)
	clrf	ADREADPORT,BANKED
	rcall	FN_READAD1016
	movff	SYSREADAD10WORD,SENSORVALUE1
	movff	SYSREADAD10WORD_H,SENSORVALUE1_H
;Wait 1 ms
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;SensorValue2 = ReadAD10(AN1)
	movlw	1
	movwf	ADREADPORT,BANKED
	rcall	FN_READAD1016
	movff	SYSREADAD10WORD,SENSORVALUE2
	movff	SYSREADAD10WORD_H,SENSORVALUE2_H
;Wait 1 ms
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;SensorValue3 = ReadAD10(AN2)
	movlw	2
	movwf	ADREADPORT,BANKED
	rcall	FN_READAD1016
	movff	SYSREADAD10WORD,SENSORVALUE3
	movff	SYSREADAD10WORD_H,SENSORVALUE3_H
;Wait 1 ms
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;SensorValue4 = ReadAD10(AN3)
	movlw	3
	movwf	ADREADPORT,BANKED
	rcall	FN_READAD1016
	movff	SYSREADAD10WORD,SENSORVALUE4
	movff	SYSREADAD10WORD_H,SENSORVALUE4_H
;Loop
	bra	SysDoLoop_S1
SysDoLoop_E1
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

DESCRIPTORHANDLER
;HSerPrint "Desc "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable5
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable5
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT264
;HSerPrint USBDescType
	movff	USBDESCTYPE,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT265
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	bra	HSERPRINTCRLF

;********************************************************************************

Delay_10US
D10US_START
	movlw	39
	movwf	DELAYTEMP,ACCESS
DelayUS0
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS0
	decfsz	SysWaitTemp10US, F,ACCESS
	bra	D10US_START
	return

;********************************************************************************

Delay_MS
	incf	SysWaitTempMS_H, F,ACCESS
DMS_START
	movlw	179
	movwf	DELAYTEMP2,ACCESS
DMS_OUTER
	movlw	21
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

ERRORHANDLER
;HSerPrint "E"
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable3
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable3
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT264
;HSerPrint Hex(UEIR)
	movff	UEIR,SYSVALTEMP
	rcall	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT264
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	bra	HSERPRINTCRLF

;********************************************************************************

FN_HEX
;Hex(0) = 2
	movlw	2
	banksel	SYSHEX_0
	movwf	SYSHEX_0,BANKED
;Low nibble
;SysStringTemp = SysValTemp And 0x0F
	movlw	15
	banksel	SYSVALTEMP
	andwf	SYSVALTEMP,W,BANKED
	movwf	SYSSTRINGTEMP,BANKED
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	sublw	9
	btfsc	STATUS, C,ACCESS
	bra	ENDIF42
	movlw	7
	addwf	SYSSTRINGTEMP,F,BANKED
ENDIF42
;Hex(2) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W,BANKED
	banksel	SYSHEX_2
	movwf	SYSHEX_2,BANKED
;Get high nibble
;For SysStringTemp = 1 to 4
	banksel	SYSSTRINGTEMP
	clrf	SYSSTRINGTEMP,BANKED
SysForLoop7
	incf	SYSSTRINGTEMP,F,BANKED
;Rotate SysValTemp Right
	rrcf	SYSVALTEMP,F,BANKED
;Next
	movlw	4
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop7
ENDIF43
SysForLoopEnd7
;SysStringTemp = SysValTemp And 0x0F
	movlw	15
	andwf	SYSVALTEMP,W,BANKED
	movwf	SYSSTRINGTEMP,BANKED
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	sublw	9
	btfsc	STATUS, C,ACCESS
	bra	ENDIF44
	movlw	7
	addwf	SYSSTRINGTEMP,F,BANKED
ENDIF44
;Hex(1) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W,BANKED
	banksel	SYSHEX_1
	movwf	SYSHEX_1,BANKED
	banksel	0
	return

;********************************************************************************

;Overloaded signature: STRING:byte:
HSERPRINT264
;PrintLen = LEN(PrintData$)
;PrintLen = PrintData(0)
	movff	SysPRINTDATAHandler,AFSR0
	movff	SysPRINTDATAHandler_H,AFSR0_H
	movff	INDF0,PRINTLEN
;If PrintLen <> 0 then
	movf	PRINTLEN,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF38
;Write Data
;for SysPrintTemp = 1 to PrintLen
	clrf	SYSPRINTTEMP,BANKED
	movlw	1
	subwf	PRINTLEN,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd6
ENDIF39
SysForLoop6
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
	bra	SysForLoop6
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
	clrf	OUTVALUETEMP,BANKED
;IF SerPrintVal >= 100 Then
	movlw	100
	subwf	SERPRINTVAL,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	ENDIF45
;OutValueTemp = SerPrintVal / 100
	movff	SERPRINTVAL,SysBYTETempA
	movlw	100
	movwf	SysBYTETempB,ACCESS
	rcall	SysDivSub
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
ENDIF45
;If OutValueTemp > 0 Or SerPrintVal >= 10 Then
	movff	OUTVALUETEMP,SysBYTETempB
	clrf	SysBYTETempA,ACCESS
	rcall	SysCompLessThan
	movff	SysByteTempX,SysTemp2
	movff	SERPRINTVAL,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	rcall	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movf	SysTemp2,W,BANKED
	iorwf	SysByteTempX,W,ACCESS
	movwf	SysTemp1,BANKED
	btfss	SysTemp1,0,BANKED
	bra	ENDIF46
;OutValueTemp = SerPrintVal / 10
	movff	SERPRINTVAL,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	rcall	SysDivSub
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
ENDIF46
;HSerSend(SerPrintVal + 48 ,comport)
	movlw	48
	addwf	SERPRINTVAL,W,BANKED
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;CR
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
;Block before sending (if needed)
;Send byte
;if comport = 1 Then
	decf	COMPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF37
;HSerSendBlocker
;Wait While TXIF = Off
SysWaitLoop4
	btfss	PIR1,TXIF,ACCESS
	bra	SysWaitLoop4
;Wait While TX1IF = Off
SysWaitLoop5
	btfss	PIR1,TX1IF,ACCESS
	bra	SysWaitLoop5
;TXREG = SerData
	movff	SERDATA,TXREG
;exit sub
	return
;TXREG1 = SerData
	movff	SERDATA,TXREG1
;exit sub
	return
;end if
ENDIF37
	return

;********************************************************************************

INITSYS
;The section now handles two true table for frequency
;Supports 18f2425 (type1 max frq of 8mhz) classes and 18f26k22 (type2 max frq of 16mhz) classes
;Assumes that testing the ChipMaxMHz >= 48 is a valid test for type2 microcontrollers
;Supports IntOsc MaxMhz of 64 and not 64 ... there may be others true tables that GCB needs to support
;asm showdebug OSCCON type is 104' NoBit(SPLLEN) And NoBit(IRCF3) Or Bit(INTSRC)) and ifdef Bit(HFIOFS)
;osccon type is 104
;Clear BSR on 18F chips
;BSR = 0
	clrf	BSR,ACCESS
;TBLPTRU = 0
	clrf	TBLPTRU,ACCESS
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
	bcf	ADCON2,ADFM,ACCESS
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON,ACCESS
;Commence clearing any ANSEL variants in the part
;ANSELA = 0
	banksel	ANSELA
	clrf	ANSELA,BANKED
;ANSELB = 0
	clrf	ANSELB,BANKED
;ANSELC = 0
	clrf	ANSELC,BANKED
;End clearing any ANSEL variants in the part
;Comparator register bits for 12F510,16F506, PIC16F1535 classes
;C2ON = 0
	bcf	CM2CON0,C2ON,ACCESS
;C1ON = 0
	bcf	CM1CON0,C1ON,ACCESS
;Turn off all ports
;PORTA = 0
	clrf	PORTA,ACCESS
;PORTB = 0
	clrf	PORTB,ACCESS
;PORTC = 0
	clrf	PORTC,ACCESS
;PORTE = 0
	clrf	PORTE,ACCESS
	banksel	0
	return

;********************************************************************************

INITUSART
;Set the default value for comport
;comport = 1
	movlw	1
	movwf	COMPORT,BANKED
;Set baud rate for legacy chips
;SPBRG = SPBRGL_TEMP
	movlw	103
	movwf	SPBRG,ACCESS
;SPBRGH = SPBRGH_TEMP
	clrf	SPBRGH,ACCESS
;BRG16 = BRG16_TEMP
	bsf	BAUDCON,BRG16,ACCESS
;BRGH = BRGH_TEMP
	bsf	TXSTA,BRGH,ACCESS
;Enable async mode
;Set SYNC Off
	bcf	TXSTA,SYNC,ACCESS
;SPEN=1
	bsf	RCSTA,SPEN,ACCESS
;Enable TX and RX
;CREN=1
	bsf	RCSTA,CREN,ACCESS
;Set TXEN On
	bsf	TXSTA,TXEN,ACCESS
;PIC USART 2 Init
	return

;********************************************************************************

INITUSB
;Time for PLL to stabilise
;Wait 2 ms
	movlw	2
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Add interrupt handlers
;UIE = 127
	movlw	127
	movwf	UIE,ACCESS
;UEIE = b'10011111'
	movlw	159
	movwf	UEIE,ACCESS
;On Interrupt USB Call USBInterruptHandler
	bsf	PIE3,USBIE,ACCESS
;Set up USB module
;Set UCFG.FSEN On
	bsf	UCFG,FSEN,ACCESS
;Set UCFG.UTRDIS Off
	bcf	UCFG,UTRDIS,ACCESS
;Set UCFG.UPUEN On
	bsf	UCFG,UPUEN,ACCESS
;USBResetEndpoints
;Take ownership of all endpoints
;USB_OUT0_STAT = 8
	movlw	8
	banksel	USB_OUT0_STAT
	movwf	USB_OUT0_STAT,BANKED
;USB_IN0_STAT = 8
	movlw	8
	movwf	USB_IN0_STAT,BANKED
;Clear transmission complete flag
;Do While TRNIF
SysDoLoop_S2
	btfss	UIR,TRNIF,ACCESS
	bra	SysDoLoop_E2
;TRNIF = 0
	bcf	UIR,TRNIF,ACCESS
;Loop
	bra	SysDoLoop_S2
SysDoLoop_E2
;Disable endpoints
;UEP0 = 0
	clrf	UEP0,ACCESS
;USB_IN0_ADDR = USB_RAM_START + 64
	movlw	64
	movwf	USB_IN0_ADDR,BANKED
	movlw	4
	movwf	USB_IN0_ADDR_H,BANKED
;USB_OUT0_ADDR = USB_RAM_START + 64 + USB_MAX_PACKET
	movlw	192
	movwf	USB_OUT0_ADDR,BANKED
	movlw	4
	movwf	USB_OUT0_ADDR_H,BANKED
;Set buffer data counts to 0
;USB_IN0_CNT = 0
	clrf	USB_IN0_CNT,BANKED
;USB_OUT0_CNT = USB_MAX_PACKET
	movlw	128
	movwf	USB_OUT0_CNT,BANKED
;USB_IN0_STAT = 8
	movlw	8
	movwf	USB_IN0_STAT,BANKED
;USB_OUT0_STAT = 0x88
	movlw	136
	movwf	USB_OUT0_STAT,BANKED
;Set up endpoint 0 for handshaking, setup, in and out, but not stalled
;PKTDIS = 0
	bcf	UCON,PKTDIS,ACCESS
;UEP0 = b'00010110'
	movlw	22
	movwf	UEP0,ACCESS
;Clear interrupt flags
;UIR = 0
	clrf	UIR,ACCESS
;UEIR = 0
	clrf	UEIR,ACCESS
;UADDR = 0
	clrf	UADDR,ACCESS
;USBState = USB_STATE_POWERED
	banksel	USBSTATE
	clrf	USBSTATE,BANKED
;USBCurrConfiguration = 0
	clrf	USBCURRCONFIGURATION,BANKED
;Enable
;Set UCON.USBEN On
	bsf	UCON,USBEN,ACCESS
	return

;********************************************************************************

Interrupt
;Save Context
	movff	WREG,SysW
	movff	STATUS,SysSTATUS
	movff	BSR,SysBSR
;Store system variables
	movff	SysTemp1,SaveSysTemp1
	movff	SysByteTempA,SaveSysByteTempA
	movff	SysByteTempB,SaveSysByteTempB
	movff	FSR0L,SaveFSR0L
	movff	FSR0H,SaveFSR0H
	movff	SysByteTempX,SaveSysByteTempX
	movff	SysDivLoop,SaveSysDivLoop
	movff	FSR1L,SaveFSR1L
	movff	FSR1H,SaveFSR1H
	movff	SysStringLength,SaveSysStringLength
	movff	SysWaitTempMS,SaveSysWaitTempMS
	movff	SysWaitTempMS_H,SaveSysWaitTempMS_H
	movff	DelayTemp2,SaveDelayTemp2
	movff	SysTemp2,SaveSysTemp2
	movff	SysStringA,SaveSysStringA
;On Interrupt handlers
	btfss	PIE3,USBIE,ACCESS
	bra	NotUSBIF
	btfss	PIR3,USBIF,ACCESS
	bra	NotUSBIF
	rcall	USBINTERRUPTHANDLER
	bcf	PIR3,USBIF,ACCESS
	bra	INTERRUPTDONE
NotUSBIF
;User Interrupt routine
INTERRUPTDONE
;Restore Context
;Restore system variables
	movff	SaveSysTemp1,SysTemp1
	movff	SaveSysByteTempA,SysByteTempA
	movff	SaveSysByteTempB,SysByteTempB
	movff	SaveFSR0L,FSR0L
	movff	SaveFSR0H,FSR0H
	movff	SaveSysByteTempX,SysByteTempX
	movff	SaveSysDivLoop,SysDivLoop
	movff	SaveFSR1L,FSR1L
	movff	SaveFSR1H,FSR1H
	movff	SaveSysStringLength,SysStringLength
	movff	SaveSysWaitTempMS,SysWaitTempMS
	movff	SaveSysWaitTempMS_H,SysWaitTempMS_H
	movff	SaveDelayTemp2,DelayTemp2
	movff	SaveSysTemp2,SysTemp2
	movff	SaveSysStringA,SysStringA
	movff	SysW,WREG
	movff	SysSTATUS,STATUS
	movff	SysBSR,BSR
	retfie	0

;********************************************************************************

FN_PEEK
;FSR0H = MemAdr_H
	movff	MEMADR_H,FSR0H
;FSR0L = MemAdr
	movff	MEMADR,FSR0L
;PEEK = INDF0
	movff	INDF0,PEEK
	return

;********************************************************************************

POKE
;Dim MemAdr As Word Alias FSR0H, FSR0L
;FSR0H = MemAdr_H
;FSR0L = MemAdr
;INDF0 = MemData
	movff	MEMDATA,INDF0
	return

;********************************************************************************

;Overloaded signature: BYTE:
FN_READAD1016
;Always RIGHT justified
;SET ADFM ON
	bsf	ADCON2,ADFM,ACCESS
;A differential ADC
;Do conversion
;LLReadAD 0
;Set up A/D
;Make necessary ports analog
;Code for PICs with older A/D (No ANSEL register)
;Code for 16F193x chips (and others?) with ANSELA/ANSELB/ANSELE registers
;Select Case ADReadPort ' #IFDEF Var(ANSELA). ANSELA exists @DebugADC_H
;Case 0: Set ANSELA.0 On
SysSelect6Case1
	movf	ADREADPORT,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case2
	banksel	ANSELA
	bsf	ANSELA,0,BANKED
;Case 1: Set ANSELA.1 On
	bra	SysSelectEnd6
SysSelect6Case2
	decf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case3
	banksel	ANSELA
	bsf	ANSELA,1,BANKED
;Case 2: Set ANSELA.2 On
	bra	SysSelectEnd6
SysSelect6Case3
	movlw	2
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case4
	banksel	ANSELA
	bsf	ANSELA,2,BANKED
;Case 3: Set ANSELA.3 On
	bra	SysSelectEnd6
SysSelect6Case4
	movlw	3
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case5
	banksel	ANSELA
	bsf	ANSELA,3,BANKED
;Case 4: Set ANSELA.5 On
	bra	SysSelectEnd6
SysSelect6Case5
	movlw	4
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case6
	banksel	ANSELA
	bsf	ANSELA,5,BANKED
;Case 12: Set ANSELB.0 On
	bra	SysSelectEnd6
SysSelect6Case6
	movlw	12
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case7
	banksel	ANSELB
	bsf	ANSELB,0,BANKED
;Case 10: Set ANSELB.1 On
	bra	SysSelectEnd6
SysSelect6Case7
	movlw	10
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case8
	banksel	ANSELB
	bsf	ANSELB,1,BANKED
;Case 8: Set ANSELB.2 On
	bra	SysSelectEnd6
SysSelect6Case8
	movlw	8
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case9
	banksel	ANSELB
	bsf	ANSELB,2,BANKED
;Case 9: Set ANSELB.3 On
	bra	SysSelectEnd6
SysSelect6Case9
	movlw	9
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case10
	banksel	ANSELB
	bsf	ANSELB,3,BANKED
;Case 11: Set ANSELB.4 On
	bra	SysSelectEnd6
SysSelect6Case10
	movlw	11
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case11
	banksel	ANSELB
	bsf	ANSELB,4,BANKED
;Case 13: Set ANSELB.5 On
	bra	SysSelectEnd6
SysSelect6Case11
	movlw	13
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case12
	banksel	ANSELB
	bsf	ANSELB,5,BANKED
;Case 14: Set ANSELC.2 On
	bra	SysSelectEnd6
SysSelect6Case12
	movlw	14
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case13
	banksel	ANSELC
	bsf	ANSELC,2,BANKED
;Case 15: Set ANSELC.3 On
	bra	SysSelectEnd6
SysSelect6Case13
	movlw	15
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case14
	banksel	ANSELC
	bsf	ANSELC,3,BANKED
;Case 16: Set ANSELC.4 On
	bra	SysSelectEnd6
SysSelect6Case14
	movlw	16
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case15
	banksel	ANSELC
	bsf	ANSELC,4,BANKED
;Case 17: Set ANSELC.5 On
	bra	SysSelectEnd6
SysSelect6Case15
	movlw	17
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case16
	banksel	ANSELC
	bsf	ANSELC,5,BANKED
;Case 18: Set ANSELC.6 On
	bra	SysSelectEnd6
SysSelect6Case16
	movlw	18
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case17
	banksel	ANSELC
	bsf	ANSELC,6,BANKED
;Case 19: Set ANSELC.7 On
	bra	SysSelectEnd6
SysSelect6Case17
	movlw	19
	subwf	ADREADPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd6
	banksel	ANSELC
	bsf	ANSELC,7,BANKED
;End Select  'End Select #1
SysSelectEnd6
;ANSEL0/ANSEL
;Code for PICs with newer A/D (with ANSEL register)
;Code for 18F4431, uses ANSEL0 and ANSEL1
;Set Auto or Single Convert Mode
;Set conversion clock - improved to handle ADCS2
;SET ADCS2 OFF
	bcf	ADCON2,ADCS2,ACCESS
;SET ADCS1 ON
	bsf	ADCON2,ADCS1,ACCESS
;SET ADCS0 OFF
	bcf	ADCON2,ADCS0,ACCESS
;Choose port
;SET CHS0 OFF
	bcf	ADCON0,CHS0,ACCESS
;SET CHS1 OFF
	bcf	ADCON0,CHS1,ACCESS
;SET CHS2 OFF
	bcf	ADCON0,CHS2,ACCESS
;SET CHS3 OFF
	bcf	ADCON0,CHS3,ACCESS
;SET CHS4 OFF
	bcf	ADCON0,CHS4,ACCESS
;IF ADReadPort.0 On Then Set CHS0 On
	banksel	ADREADPORT
	btfsc	ADREADPORT,0,BANKED
	bsf	ADCON0,CHS0,ACCESS
ENDIF32
;IF ADReadPort.1 On Then Set CHS1 On
	btfsc	ADREADPORT,1,BANKED
	bsf	ADCON0,CHS1,ACCESS
ENDIF33
;IF ADReadPort.2 On Then Set CHS2 On
	btfsc	ADREADPORT,2,BANKED
	bsf	ADCON0,CHS2,ACCESS
ENDIF34
;If ADReadPort.3 On Then Set CHS3 On
	btfsc	ADREADPORT,3,BANKED
	bsf	ADCON0,CHS3,ACCESS
ENDIF35
;If ADReadPort.4 On Then Set CHS4 On
	btfsc	ADREADPORT,4,BANKED
	bsf	ADCON0,CHS4,ACCESS
ENDIF36
;***  'Special section for 16F1688x Chips ***
;Enable A/D
;SET ADON ON
	bsf	ADCON0,ADON,ACCESS
;Acquisition Delay
;Wait AD_Delay
	movlw	2
	movwf	SysWaitTemp10US,ACCESS
	rcall	Delay_10US
;Read A/D
;SET GO_NOT_DONE ON
	bsf	ADCON0,GO_NOT_DONE,ACCESS
;nop
	nop
;Wait While GO_NOT_DONE ON
SysWaitLoop3
	btfsc	ADCON0,GO_NOT_DONE,ACCESS
	bra	SysWaitLoop3
;Switch off A/D
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON,ACCESS
;Clear whatever ANSEL variants the chip has
;ANSELA = 0
	banksel	ANSELA
	clrf	ANSELA,BANKED
;ANSELB = 0
	clrf	ANSELB,BANKED
;ANSELC = 0
	clrf	ANSELC,BANKED
;Write output
;ReadAD10 = ADRESL
	movff	ADRESL,READAD10
	banksel	READAD10_H
	clrf	READAD10_H,BANKED
;ReadAD10_H = ADRESH
	movff	ADRESH,READAD10_H
;Put A/D format back to normal
;SET ADFM OFF
	bcf	ADCON2,ADFM,ACCESS
	return

;********************************************************************************

SETUPHANDLER
;Select Case USBTempBuffer(1)
;Control transfer 131, turn on LED
;Case 131
SysSelect7Case1
	movlw	131
	banksel	SYSUSBTEMPBUFFER_1
	subwf	SYSUSBTEMPBUFFER_1,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect7Case2
;Set PORTB.5 On
	bsf	LATB,5,ACCESS
;USBSendData1Ack
	banksel	0
	rcall	USBSENDDATA1ACK
;Control transfer 132, turn off LED
;Case 132
	bra	SysSelectEnd7
SysSelect7Case2
	movlw	132
	subwf	SYSUSBTEMPBUFFER_1,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect7Case3
;Set PORTB.5 Off
	bcf	LATB,5,ACCESS
;USBSendData1Ack
	banksel	0
	rcall	USBSENDDATA1ACK
;Control transfer 133, send back ADC readings
;Case 133
	bra	SysSelectEnd7
SysSelect7Case3
	movlw	133
	subwf	SYSUSBTEMPBUFFER_1,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect7Case4
;USB_IN0_CNT = 8
	movlw	8
	banksel	USB_IN0_CNT
	movwf	USB_IN0_CNT,BANKED
;Poke USB_IN0_ADDR, SensorValue1
	movff	USB_IN0_ADDR,MEMADR
	movff	USB_IN0_ADDR_H,MEMADR_H
	movff	SENSORVALUE1,MEMDATA
	banksel	0
	rcall	POKE
;Poke USB_IN0_ADDR + 1, SensorValue1_H
	movlw	1
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movff	SENSORVALUE1_H,MEMDATA
	banksel	0
	rcall	POKE
;Poke USB_IN0_ADDR + 2, SensorValue2
	movlw	2
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movff	SENSORVALUE2,MEMDATA
	banksel	0
	rcall	POKE
;Poke USB_IN0_ADDR + 3, SensorValue2_H
	movlw	3
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movff	SENSORVALUE2_H,MEMDATA
	banksel	0
	rcall	POKE
;Poke USB_IN0_ADDR + 4, SensorValue3
	movlw	4
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movff	SENSORVALUE3,MEMDATA
	banksel	0
	rcall	POKE
;Poke USB_IN0_ADDR + 5, SensorValue3_H
	movlw	5
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movff	SENSORVALUE3_H,MEMDATA
	banksel	0
	rcall	POKE
;Poke USB_IN0_ADDR + 6, SensorValue4
	movlw	6
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movff	SENSORVALUE4,MEMDATA
	banksel	0
	rcall	POKE
;Poke USB_IN0_ADDR + 7, SensorValue4_H
	movlw	7
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movff	SENSORVALUE4_H,MEMDATA
	banksel	0
	rcall	POKE
;USBStartSend
;If USB_IN0_STAT.6 Then
	banksel	USB_IN0_STAT
	btfss	USB_IN0_STAT,6,BANKED
	bra	ELSE41_1
;USB_IN0_STAT = b'10001000'
	movlw	136
	movwf	USB_IN0_STAT,BANKED
;Else
	bra	ENDIF41
ELSE41_1
;USB_IN0_STAT = b'11001000'
	movlw	200
	movwf	USB_IN0_STAT,BANKED
;End If
ENDIF41
;It broke
;Case Else
	bra	SysSelectEnd7
SysSelect7Case4
;HSerPrint "Req "
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable4
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable4
	movwf	TBLPTRH,ACCESS
	banksel	0
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT264
;HSerPrint USBTempBuffer(1)
	movff	SYSUSBTEMPBUFFER_1,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT265
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF
;End Select
SysSelectEnd7
	banksel	0
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

SYSDIVSUB
;dim SysByteTempA as byte
;dim SysByteTempB as byte
;dim SysByteTempX as byte
;Check for div/0
;movf SysByteTempB, F
	movf	SYSBYTETEMPB, F,ACCESS
;btfsc STATUS, Z
	btfsc	STATUS, Z,ACCESS
;return
	return
;Main calc routine
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

SYSREADSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Get length
;TBLRD*+
	tblrd*+
;movff TABLAT,SysCalcTempA
	movff	TABLAT,SYSCALCTEMPA
;movff TABLAT,INDF1
	movff	TABLAT,INDF1
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
;Check length
SYSSTRINGREADCHECK
;If length is 0, exit
;movf SysCalcTempA,F
	movf	SYSCALCTEMPA,F,ACCESS
;btfsc STATUS,Z
	btfsc	STATUS,Z,ACCESS
;return
	return
;Copy
SYSSTRINGREAD
;Copy char
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
	db	16,71,67,66,65,83,73,67,32,85,83,66,32,84,101,115,116


StringTable2
	db	7,85,83,66,32,67,71,66


StringTable3
	db	1,69


StringTable4
	db	4,82,101,113,32


StringTable5
	db	5,68,101,115,99,32


StringTable6
	db	9,71,114,101,97,116,32,67,111,119


StringTable9
	db	0


;********************************************************************************

USBCONFIGDESCRIPTOR
	movlw	18
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableUSBCONFIGDESCRIPTOR
	movwf	TBLPTRL,ACCESS
	movlw	high TableUSBCONFIGDESCRIPTOR
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableUSBCONFIGDESCRIPTOR
	db	18,9,2,18,0,1,1,0,128,25,9,4,0,0,0,255,0,255

;********************************************************************************

USBDEVICEDESCRIPTOR
	movlw	19
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableUSBDEVICEDESCRIPTOR
	movwf	TBLPTRL,ACCESS
	movlw	high TableUSBDEVICEDESCRIPTOR
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableUSBDEVICEDESCRIPTOR
	db	18,18,1,0,2,0,0,0,64,85,240,0,16,1,1,1,2,0,1

;********************************************************************************

USBDEVICEQUALDESCRIPTOR
	movlw	10
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableUSBDEVICEQUALDESCRIPTOR
	movwf	TBLPTRL,ACCESS
	movlw	high TableUSBDEVICEQUALDESCRIPTOR
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableUSBDEVICEQUALDESCRIPTOR
	db	10,10,6,0,2,0,0,0,64,1

;********************************************************************************

USBINTERRUPTHANDLER
;Event that should be handled by library?
;Reset
;If URSTIF Then
	btfss	UIR,URSTIF,ACCESS
	bra	ENDIF3
;USBResetEndpoints
;Take ownership of all endpoints
;USB_OUT0_STAT = 8
	movlw	8
	banksel	USB_OUT0_STAT
	movwf	USB_OUT0_STAT,BANKED
;USB_IN0_STAT = 8
	movlw	8
	movwf	USB_IN0_STAT,BANKED
;Clear transmission complete flag
;Do While TRNIF
SysDoLoop_S3
	btfss	UIR,TRNIF,ACCESS
	bra	SysDoLoop_E3
;TRNIF = 0
	bcf	UIR,TRNIF,ACCESS
;Loop
	bra	SysDoLoop_S3
SysDoLoop_E3
;Disable endpoints
;UEP0 = 0
	clrf	UEP0,ACCESS
;USB_IN0_ADDR = USB_RAM_START + 64
	movlw	64
	movwf	USB_IN0_ADDR,BANKED
	movlw	4
	movwf	USB_IN0_ADDR_H,BANKED
;USB_OUT0_ADDR = USB_RAM_START + 64 + USB_MAX_PACKET
	movlw	192
	movwf	USB_OUT0_ADDR,BANKED
	movlw	4
	movwf	USB_OUT0_ADDR_H,BANKED
;Set buffer data counts to 0
;USB_IN0_CNT = 0
	clrf	USB_IN0_CNT,BANKED
;USB_OUT0_CNT = USB_MAX_PACKET
	movlw	128
	movwf	USB_OUT0_CNT,BANKED
;USB_IN0_STAT = 8
	movlw	8
	movwf	USB_IN0_STAT,BANKED
;USB_OUT0_STAT = 0x88
	movlw	136
	movwf	USB_OUT0_STAT,BANKED
;Set up endpoint 0 for handshaking, setup, in and out, but not stalled
;PKTDIS = 0
	bcf	UCON,PKTDIS,ACCESS
;UEP0 = b'00010110'
	movlw	22
	movwf	UEP0,ACCESS
;UADDR = 0
	clrf	UADDR,ACCESS
;Clear interrupt flags
;UEIR = 0
	clrf	UEIR,ACCESS
;UIR = 0
	clrf	UIR,ACCESS
;SUSPND = 0
	bcf	UCON,SUSPND,ACCESS
;Wait for single ended zero to clear
;Wait While UCON.SE0
SysWaitLoop2
	btfsc	UCON,SE0,ACCESS
	bra	SysWaitLoop2
;USBLastControl = USB_NONE
	banksel	USBLASTCONTROL
	setf	USBLASTCONTROL,BANKED
;USBState = USB_STATE_DEFAULT
	movlw	1
	movwf	USBSTATE,BANKED
;USBCurrConfiguration = 0
	clrf	USBCURRCONFIGURATION,BANKED
;End If
ENDIF3
;Error
;If UERRIF Then
	btfss	UIR,UERRIF,ACCESS
	bra	ENDIF4
;USB_ERROR_HANDLER
	rcall	ERRORHANDLER
;UEIR = 0
	clrf	UEIR,ACCESS
;UERRIF = 0
	bcf	UIR,UERRIF,ACCESS
;End If
ENDIF4
;Activity on D+/D-
;If ACTVIF Then
	btfss	UIR,ACTVIF,ACCESS
	bra	ENDIF5
;If activity detected, switch from suspend to normal
;SUSPND = 0
	bcf	UCON,SUSPND,ACCESS
;Clear ACTVIF
;Do While ACTVIF
;Set ACTVIF Off
	bcf	UIR,ACTVIF,ACCESS
;Loop
;End If
ENDIF5
;Transfer complete
;If TRNIF Then
	btfss	UIR,TRNIF,ACCESS
	bra	ENDIF6
;Determine transfer that has occurred
;USBCurrEndpoint = (USTAT And 0x78) / 8
	movlw	120
	andwf	USTAT,W,ACCESS
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SysBYTETempA
	movlw	8
	movwf	SysBYTETempB,ACCESS
	rcall	SysDivSub
	movff	SysBYTETempA,USBCURRENDPOINT
;If USTAT.DIR Then
	btfss	USTAT,DIR,ACCESS
	bra	ELSE10_1
;In
;USBBufferStat = USB_IN0_STAT
	movff	USB_IN0_STAT,USBBUFFERSTAT
;Else
	bra	ENDIF10
ELSE10_1
;Setup/Out
;USBBufferStat = USB_OUT0_STAT
	movff	USB_OUT0_STAT,USBBUFFERSTAT
;USB_OUT0_STAT.UOWN = 0
	banksel	USB_OUT0_STAT
	bcf	USB_OUT0_STAT,7,BANKED
;End If
ENDIF10
;Get PID (is multiplied by 4)
;USBPID = USBBufferStat And 0x3C
	movlw	60
	banksel	USBBUFFERSTAT
	andwf	USBBUFFERSTAT,W,BANKED
	movwf	USBPID,BANKED
;Select Case USBPID
;Case USB_PID_OUT
SysSelect1Case1
	movlw	4
	subwf	USBPID,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case2
;Out transfer
;HSerPrint "OUT"
;HSerPrintCRLF
;USB_OUT0_CNT = USB_MAX_PACKET
	movlw	128
	banksel	USB_OUT0_CNT
	movwf	USB_OUT0_CNT,BANKED
;USB_OUT0_STAT.UOWN = 1
	bsf	USB_OUT0_STAT,7,BANKED
;Case USB_PID_IN
	bra	SysSelectEnd1
SysSelect1Case2
	movlw	36
	subwf	USBPID,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case3
;In transfer completed
;HSerPrint "IN"
;HSerPrintCRLF
;Select Case USBLastControl
;Set address completed
;Case USB_SET_ADDRESS
SysSelect2Case1
	movlw	5
	subwf	USBLASTCONTROL,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case2
;UADDR = USBNewAddress
	movff	USBNEWADDRESS,UADDR
;USBState = USB_STATE_ADDRESS
	movlw	2
	movwf	USBSTATE,BANKED
;USBLastControl = USB_NONE
	setf	USBLASTCONTROL,BANKED
;Continue responding to Get Descriptor
;Case USB_GET_DESCRIPTOR
	bra	SysSelectEnd2
SysSelect2Case2
	movlw	6
	subwf	USBLASTCONTROL,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case3
;USBSendDescriptor
	rcall	USBSENDDESCRIPTOR
;Case Else
	bra	SysSelectEnd2
SysSelect2Case3
;Prepare incoming buffer again
;USB_OUT0_CNT = USB_MAX_PACKET
	movlw	128
	banksel	USB_OUT0_CNT
	movwf	USB_OUT0_CNT,BANKED
;USB_OUT0_STAT = 0x88
	movlw	136
	movwf	USB_OUT0_STAT,BANKED
;End Select
SysSelectEnd2
;Case USB_PID_SETUP
	bra	SysSelectEnd1
SysSelect1Case3
	movlw	52
	subwf	USBPID,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case4
;Setup transfer
;Copy data to buffer
;For USBCurrByte = 0 to 7
	setf	USBCURRBYTE,BANKED
SysForLoop1
	incf	USBCURRBYTE,F,BANKED
;USBTempBuffer(USBCurrByte) = Peek(USB_OUT0_ADDR + USBCurrByte)
	movf	USBCURRBYTE,W,BANKED
	banksel	USB_OUT0_ADDR
	addwf	USB_OUT0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_OUT0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	banksel	0
	rcall	FN_PEEK
	lfsr	0,USBTEMPBUFFER
	movf	USBCURRBYTE,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	PEEK,INDF0
;Next
	movlw	7
	subwf	USBCURRBYTE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop1
ENDIF11
SysForLoopEnd1
;Stop any outgoing transmissions
;USB_IN0_STAT = 8
	movlw	8
	banksel	USB_IN0_STAT
	movwf	USB_IN0_STAT,BANKED
;Prepare incoming buffer again
;USB_OUT0_CNT = USB_MAX_PACKET
	movlw	128
	movwf	USB_OUT0_CNT,BANKED
;USB_OUT0_STAT = 0x88
	movlw	136
	movwf	USB_OUT0_STAT,BANKED
;USBProcessSetup
	banksel	0
	rcall	USBPROCESSSETUP
;USBDumpControlIn
;HSerPrint "S"
;HSerPrintCRLF
;Case Else
	bra	SysSelectEnd1
SysSelect1Case4
;HSerPrint "PID Err "
;HSerPrint USBPID
;HSerPrintCRLF
;End Select
SysSelectEnd1
;USBHasData = True
	banksel	USBHASDATA
	setf	USBHASDATA,BANKED
;TRNIF = 0
	bcf	UIR,TRNIF,ACCESS
;End If
ENDIF6
;Idle
;If IDLEIF Then
	btfsc	UIR,IDLEIF,ACCESS
;IDLEIF = 0
	bcf	UIR,IDLEIF,ACCESS
;End If
ENDIF7
;Stalled
;If STALLIF Then
	btfsc	UIR,STALLIF,ACCESS
;STALLIF = 0
	bcf	UIR,STALLIF,ACCESS
;End If
ENDIF8
;Start of frame
;If SOFIF Then
	btfsc	UIR,SOFIF,ACCESS
;SOFIF = 0
	bcf	UIR,SOFIF,ACCESS
;End If
ENDIF9
	return

;********************************************************************************

USBPROCESSSETUP
;Buffer format:
;0:bmRequestType 1:bRequest 3-2:wValue 5-4:wIndex 7-6:wLength
;USBbmRequestType = USBTempBuffer(0) And 0x7F
	movlw	127
	banksel	SYSUSBTEMPBUFFER_0
	andwf	SYSUSBTEMPBUFFER_0,W,BANKED
	banksel	USBBMREQUESTTYPE
	movwf	USBBMREQUESTTYPE,BANKED
;Re-enable input processing
;PKTDIS = 0
	bcf	UCON,PKTDIS,ACCESS
;Device requests
;If USBbmRequestType = 0 Then
	movf	USBBMREQUESTTYPE,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE12_1
;USBLastControl = USB_NONE
	setf	USBLASTCONTROL,BANKED
;Select Case USBTempBuffer(1)
;Case USB_GET_STATUS
;Case USB_CLEAR_FEATURE
;Case USB_SET_FEATURE
;Case USB_SET_ADDRESS
SysSelect3Case1
	movlw	5
	banksel	SYSUSBTEMPBUFFER_1
	subwf	SYSUSBTEMPBUFFER_1,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case2
;USBLastControl = USB_SET_ADDRESS
	movlw	5
	banksel	USBLASTCONTROL
	movwf	USBLASTCONTROL,BANKED
;USBNewAddress = USBTempBuffer(2)
	movff	SYSUSBTEMPBUFFER_2,USBNEWADDRESS
;Send empty DATA1 packet
;USBSendDATA1Ack
	rcall	USBSENDDATA1ACK
;Case USB_GET_DESCRIPTOR
	bra	SysSelectEnd3
SysSelect3Case2
	movlw	6
	subwf	SYSUSBTEMPBUFFER_1,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case3
;USBLastControl = USB_GET_DESCRIPTOR
	movlw	6
	banksel	USBLASTCONTROL
	movwf	USBLASTCONTROL,BANKED
;USBDescType = USBTempBuffer(3)
	movff	SYSUSBTEMPBUFFER_3,USBDESCTYPE
;USBDescIndex = USBTempBuffer(2)
	movff	SYSUSBTEMPBUFFER_2,USBDESCINDEX
;USBDescSizeIn = USBTempBuffer(6)
	movff	SYSUSBTEMPBUFFER_6,USBDESCSIZEIN
;USBDescStart = 0
	clrf	USBDESCSTART,BANKED
;USBSendDescriptor
	rcall	USBSENDDESCRIPTOR
;Case USB_SET_DESCRIPTOR
;Case USB_GET_CONFIGURATION
;Case USB_SET_CONFIGURATION
	bra	SysSelectEnd3
SysSelect3Case3
	movlw	9
	subwf	SYSUSBTEMPBUFFER_1,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case4
;USBCurrConfiguration = USBTempBuffer(2)
	movff	SYSUSBTEMPBUFFER_2,USBCURRCONFIGURATION
;If USBCurrConfiguration = 0 Then
	banksel	USBCURRCONFIGURATION
	movf	USBCURRCONFIGURATION,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE13_1
;USBState = USB_STATE_ADDRESS
	movlw	2
	movwf	USBSTATE,BANKED
;Else
	bra	ENDIF13
ELSE13_1
;USBState = USB_STATE_CONFIGURED
	movlw	3
	movwf	USBSTATE,BANKED
;End If
ENDIF13
;USBSendData1Ack
	rcall	USBSENDDATA1ACK
;It broke
;Case Else
	bra	SysSelectEnd3
SysSelect3Case4
;USB_SETUP_HANDLER
	banksel	0
	rcall	SETUPHANDLER
;End Select
SysSelectEnd3
;Else
	bra	ENDIF12
ELSE12_1
;USBDumpControlIn
;USB_SETUP_HANDLER
	rcall	SETUPHANDLER
;End If
ENDIF12
	return

;********************************************************************************

USBSENDDATA1ACK
;USB_IN0_CNT = 0
	banksel	USB_IN0_CNT
	clrf	USB_IN0_CNT,BANKED
;USB_IN0_STAT = 0xC8
	movlw	200
	movwf	USB_IN0_STAT,BANKED
	banksel	0
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
	bcf	USB_IN0_STAT,7,BANKED
;Select Case USBDescType
;Device
;Case 1
SysSelect4Case1
	banksel	USBDESCTYPE
	decf	USBDESCTYPE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case2
;Copy bytes into buffer
;ReadTable USB_DEVICE_DESCRIPTOR, 1, USBSize
	movlw	18
	movwf	USBSIZE,BANKED
;If USBSize > USBDescSizeIn Then USBSize = USBDescSizeIn
	subwf	USBDESCSIZEIN,W,BANKED
	btfss	STATUS, C,ACCESS
	movff	USBDESCSIZEIN,USBSIZE
ENDIF14
;If USBDescStart >= USBSize Then
	movf	USBSIZE,W,BANKED
	subwf	USBDESCSTART,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	ELSE15_1
;USBSize = 0
	clrf	USBSIZE,BANKED
;USBLastControl = USB_NONE
	setf	USBLASTCONTROL,BANKED
;Else
	bra	ENDIF15
ELSE15_1
;USBSize -= USBDescStart
	movf	USBDESCSTART,W,BANKED
	subwf	USBSIZE,F,BANKED
;End If
ENDIF15
;For USBCurrByte = 1 To USBSize
	clrf	USBCURRBYTE,BANKED
	movlw	1
	subwf	USBSIZE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd2
ENDIF16
SysForLoop2
	incf	USBCURRBYTE,F,BANKED
;ReadTable USB_DEVICE_DESCRIPTOR, USBCurrByte + USBDescStart, USBTempByte
	movf	USBDESCSTART,W,BANKED
	addwf	USBCURRBYTE,W,BANKED
	movwf	SYSSTRINGA,ACCESS
	rcall	USBDEVICEDESCRIPTOR
	movwf	USBTEMPBYTE,BANKED
;Poke USB_IN0_ADDR + (USBCurrByte - 1), USBTempByte
	decf	USBCURRBYTE,W,BANKED
	movwf	SysTemp1,BANKED
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movff	USBTEMPBYTE,MEMDATA
	banksel	0
	rcall	POKE
;Next
	movf	USBSIZE,W,BANKED
	subwf	USBCURRBYTE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop2
ENDIF17
SysForLoopEnd2
;USB_IN0_CNT = USBSize
	movff	USBSIZE,USB_IN0_CNT
;USBDescStart += USBSize
	movf	USBSIZE,W,BANKED
	addwf	USBDESCSTART,F,BANKED
;Configuration
;Case 2
	bra	SysSelectEnd4
SysSelect4Case2
	movlw	2
	subwf	USBDESCTYPE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case3
;Copy bytes into buffer
;ReadTable USB_CONFIG_DESCRIPTOR, 0, USBSize
	movlw	18
	movwf	USBSIZE,BANKED
;If USBSize > USBDescSizeIn Then USBSize = USBDescSizeIn
	subwf	USBDESCSIZEIN,W,BANKED
	btfss	STATUS, C,ACCESS
	movff	USBDESCSIZEIN,USBSIZE
ENDIF18
;If USBDescStart >= USBSize Then
	movf	USBSIZE,W,BANKED
	subwf	USBDESCSTART,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	ELSE19_1
;USBSize = 0
	clrf	USBSIZE,BANKED
;USBLastControl = USB_NONE
	setf	USBLASTCONTROL,BANKED
;Else
	bra	ENDIF19
ELSE19_1
;USBSize -= USBDescStart
	movf	USBDESCSTART,W,BANKED
	subwf	USBSIZE,F,BANKED
;End If
ENDIF19
;For USBCurrByte = 1 To USBSize
	clrf	USBCURRBYTE,BANKED
	movlw	1
	subwf	USBSIZE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd3
ENDIF20
SysForLoop3
	incf	USBCURRBYTE,F,BANKED
;ReadTable USB_CONFIG_DESCRIPTOR, USBCurrByte + USBDescStart, USBTempByte
	movf	USBDESCSTART,W,BANKED
	addwf	USBCURRBYTE,W,BANKED
	movwf	SYSSTRINGA,ACCESS
	rcall	USBCONFIGDESCRIPTOR
	movwf	USBTEMPBYTE,BANKED
;Poke USB_IN0_ADDR + (USBCurrByte - 1), USBTempByte
	decf	USBCURRBYTE,W,BANKED
	movwf	SysTemp1,BANKED
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movff	USBTEMPBYTE,MEMDATA
	banksel	0
	rcall	POKE
;Next
	movf	USBSIZE,W,BANKED
	subwf	USBCURRBYTE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop3
ENDIF21
SysForLoopEnd3
;USB_IN0_CNT = USBSize
	movff	USBSIZE,USB_IN0_CNT
;USBDescStart += USBSize
	movf	USBSIZE,W,BANKED
	addwf	USBDESCSTART,F,BANKED
;Device Qualifier
;Case 6
	bra	SysSelectEnd4
SysSelect4Case3
	movlw	6
	subwf	USBDESCTYPE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case4
;Copy bytes into buffer
;ReadTable USBDeviceQualDescriptor, 0, USBSize
	movlw	10
	movwf	USBSIZE,BANKED
;If USBSize > USBDescSizeIn Then USBSize = USBDescSizeIn
	subwf	USBDESCSIZEIN,W,BANKED
	btfss	STATUS, C,ACCESS
	movff	USBDESCSIZEIN,USBSIZE
ENDIF22
;If USBDescStart >= USBSize Then
	movf	USBSIZE,W,BANKED
	subwf	USBDESCSTART,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	ELSE23_1
;USBSize = 0
	clrf	USBSIZE,BANKED
;USBLastControl = USB_NONE
	setf	USBLASTCONTROL,BANKED
;Else
	bra	ENDIF23
ELSE23_1
;USBSize -= USBDescStart
	movf	USBDESCSTART,W,BANKED
	subwf	USBSIZE,F,BANKED
;End If
ENDIF23
;For USBCurrByte = 1 To USBSize
	clrf	USBCURRBYTE,BANKED
	movlw	1
	subwf	USBSIZE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd4
ENDIF24
SysForLoop4
	incf	USBCURRBYTE,F,BANKED
;ReadTable USBDeviceQualDescriptor, USBCurrByte + USBDescStart, USBTempByte
	movf	USBDESCSTART,W,BANKED
	addwf	USBCURRBYTE,W,BANKED
	movwf	SYSSTRINGA,ACCESS
	rcall	USBDEVICEQUALDESCRIPTOR
	movwf	USBTEMPBYTE,BANKED
;Poke USB_IN0_ADDR + (USBCurrByte - 1), USBTempByte
	decf	USBCURRBYTE,W,BANKED
	movwf	SysTemp1,BANKED
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movff	USBTEMPBYTE,MEMDATA
	banksel	0
	rcall	POKE
;Next
	movf	USBSIZE,W,BANKED
	subwf	USBCURRBYTE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop4
ENDIF25
SysForLoopEnd4
;USB_IN0_CNT = USBSize
	movff	USBSIZE,USB_IN0_CNT
;USBDescStart += USBSize
	movf	USBSIZE,W,BANKED
	addwf	USBDESCSTART,F,BANKED
;String
;Case 3
	bra	SysSelectEnd4
SysSelect4Case4
	movlw	3
	subwf	USBDESCTYPE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case5
;If USBDescIndex = 0 Then
	movf	USBDESCINDEX,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE26_1
;Assume that these aren't continued over
;USBLastControl = USB_NONE
	setf	USBLASTCONTROL,BANKED
;Language ID
;Poke USB_IN0_ADDR, 4
	movff	USB_IN0_ADDR,MEMADR
	movff	USB_IN0_ADDR_H,MEMADR_H
	movlw	4
	movwf	MEMDATA,BANKED
	rcall	POKE
;Poke USB_IN0_ADDR + 1, 3
	movlw	1
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movlw	3
	banksel	MEMDATA
	movwf	MEMDATA,BANKED
	rcall	POKE
;Poke USB_IN0_ADDR + 2, 0x09
	movlw	2
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movlw	9
	banksel	MEMDATA
	movwf	MEMDATA,BANKED
	rcall	POKE
;Poke USB_IN0_ADDR + 3, 0x04
	movlw	3
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movlw	4
	banksel	MEMDATA
	movwf	MEMDATA,BANKED
	rcall	POKE
;USB_IN0_CNT = 4
	movlw	4
	banksel	USB_IN0_CNT
	movwf	USB_IN0_CNT,BANKED
;Else
	bra	ENDIF26
ELSE26_1
;Get requested string
;Select Case USBDescIndex
;Vendor name
;Case 1: USBTempString = USB_VENDOR_NAME
SysSelect5Case1
	decf	USBDESCINDEX,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case2
	lfsr	1,USBTEMPSTRING
	movlw	low StringTable6
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable6
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
;Product name
;Case 2: USBTempString = USB_PRODUCT_NAME
	bra	SysSelectEnd5
SysSelect5Case2
	movlw	2
	subwf	USBDESCINDEX,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case3
	lfsr	1,USBTEMPSTRING
	movlw	low StringTable1
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable1
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
;Other
;Case Else: USBTempString = ""
	bra	SysSelectEnd5
SysSelect5Case3
	lfsr	1,USBTEMPSTRING
	movlw	low StringTable9
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable9
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
;End Select
SysSelectEnd5
;Format string into unicode string descriptor
;USB_IN0_CNT = 2 + (USBTempString(0) * 2)
	banksel	SYSUSBTEMPSTRING_0
	movf	SYSUSBTEMPSTRING_0,W,BANKED
	mullw	2
	movff	PRODL,SysTemp1
	movlw	2
	banksel	SYSTEMP1
	addwf	SysTemp1,W,BANKED
	banksel	USB_IN0_CNT
	movwf	USB_IN0_CNT,BANKED
;If USBDescStart > USB_IN0_CNT Then
	banksel	USBDESCSTART
	movf	USBDESCSTART,W,BANKED
	banksel	USB_IN0_CNT
	subwf	USB_IN0_CNT,W,BANKED
	btfsc	STATUS, C,ACCESS
	bra	ELSE28_1
;USB_IN0_CNT = 0
	clrf	USB_IN0_CNT,BANKED
;USBLastControl = USB_NONE
	banksel	USBLASTCONTROL
	setf	USBLASTCONTROL,BANKED
;Else
	bra	ENDIF28
ELSE28_1
;USB_IN0_CNT -= USBDescStart
	banksel	USBDESCSTART
	movf	USBDESCSTART,W,BANKED
	banksel	USB_IN0_CNT
	subwf	USB_IN0_CNT,F,BANKED
;End If
ENDIF28
;Poke USB_IN0_ADDR, USB_IN0_CNT
	movff	USB_IN0_ADDR,MEMADR
	movff	USB_IN0_ADDR_H,MEMADR_H
	movff	USB_IN0_CNT,MEMDATA
	banksel	0
	rcall	POKE
;Poke USB_IN0_ADDR + 1, 3
	movlw	1
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movlw	3
	banksel	MEMDATA
	movwf	MEMDATA,BANKED
	rcall	POKE
;For USBCurrByte = 1 to USBTempString(0)
	clrf	USBCURRBYTE,BANKED
	movlw	1
	banksel	SYSUSBTEMPSTRING_0
	subwf	SYSUSBTEMPSTRING_0,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd5
ENDIF29
SysForLoop5
	banksel	USBCURRBYTE
	incf	USBCURRBYTE,F,BANKED
;USBTempByte = USBTempString(USBCurrByte)
	lfsr	0,USBTEMPSTRING
	movf	USBCURRBYTE,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	INDF0,USBTEMPBYTE
;Poke USB_IN0_ADDR + (USBCurrByte * 2), USBTempByte
	movf	USBCURRBYTE,W,BANKED
	mullw	2
	movff	PRODL,SysTemp1
	movf	SysTemp1,W,BANKED
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	movff	USBTEMPBYTE,MEMDATA
	banksel	0
	rcall	POKE
;Poke USB_IN0_ADDR + (USBCurrByte * 2 + 1), 0
	movf	USBCURRBYTE,W,BANKED
	mullw	2
	movff	PRODL,SysTemp1
	incf	SysTemp1,W,BANKED
	movwf	SysTemp2,BANKED
	banksel	USB_IN0_ADDR
	addwf	USB_IN0_ADDR,W,BANKED
	movwf	MEMADR,ACCESS
	movlw	0
	addwfc	USB_IN0_ADDR_H,W,BANKED
	movwf	MEMADR_H,ACCESS
	banksel	MEMDATA
	clrf	MEMDATA,BANKED
	rcall	POKE
;Next
	banksel	SYSUSBTEMPSTRING_0
	movf	SYSUSBTEMPSTRING_0,W,BANKED
	banksel	USBCURRBYTE
	subwf	USBCURRBYTE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop5
ENDIF30
SysForLoopEnd5
;If USB_IN0_CNT > USBDescSizeIn Then USB_IN0_CNT = USBDescSizeIn
	banksel	USB_IN0_CNT
	movf	USB_IN0_CNT,W,BANKED
	banksel	USBDESCSIZEIN
	subwf	USBDESCSIZEIN,W,BANKED
	btfss	STATUS, C,ACCESS
	movff	USBDESCSIZEIN,USB_IN0_CNT
ENDIF31
;USBDescStart += USB_IN0_CNT
	banksel	USB_IN0_CNT
	movf	USB_IN0_CNT,W,BANKED
	banksel	USBDESCSTART
	addwf	USBDESCSTART,F,BANKED
;End If
ENDIF26
;Interface
;Case 4
;Endpoint
;Case 5
;Other
;Case Else
	bra	SysSelectEnd4
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
	btfss	USB_IN0_STAT,6,BANKED
	bra	ELSE27_1
;USB_IN0_STAT = b'10001000'
	movlw	136
	movwf	USB_IN0_STAT,BANKED
;Else
	bra	ENDIF27
ELSE27_1
;USB_IN0_STAT = b'11001000'
	movlw	200
	movwf	USB_IN0_STAT,BANKED
;End If
ENDIF27
	banksel	0
	return

;********************************************************************************


 END
