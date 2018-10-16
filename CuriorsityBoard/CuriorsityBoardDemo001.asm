;Program compiled by Great Cow BASIC (0.98.<<>> 2018-10-03 (Windows 32 bit))
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F1829, r=DEC
#include <P16F1829.inc>
 __CONFIG _CONFIG1, _MCLRE_OFF & _WDTE_SWDTEN & _FOSC_INTOSC
 __CONFIG _CONFIG2, _LVP_ON & _PLLEN_OFF

;********************************************************************************

;Set aside memory locations for variables
ADREADPORT	EQU	32
CCPCONCACHE	EQU	33
COMPORT	EQU	34
DELAYTEMP	EQU	112
DELAYTEMP2	EQU	113
G_BTNSTATE	EQU	35
G_LABNUMBER	EQU	36
G_LABSTATE	EQU	37
G_LASTCASECHOICE	EQU	38
G_ROTATEREG	EQU	39
G_SWITCHEVENT	EQU	40
HSERPRINTCRLFCOUNT	EQU	41
L_ADCRESULT	EQU	42
L_DELAY	EQU	43
L_EEADDR	EQU	44
PRINTLEN	EQU	45
PRX_TEMP	EQU	46
PRX_TEMP_E	EQU	49
PRX_TEMP_H	EQU	47
PRX_TEMP_U	EQU	48
PWMCHANNEL	EQU	50
PWMDUTY	EQU	51
PWMDUTY_H	EQU	52
PWMFREQ	EQU	53
PWMRESOLUTION	EQU	54
PWMRESOLUTION_H	EQU	55
READAD	EQU	56
SAVEPCLATH	EQU	57
SERDATA	EQU	58
STR	EQU	9180
STRINGPOINTER	EQU	59
SYSBSR	EQU	60
SYSBYTETEMPA	EQU	117
SYSBYTETEMPB	EQU	121
SYSBYTETEMPX	EQU	112
SYSCALCTEMPA	EQU	117
SYSCALCTEMPX	EQU	112
SYSCALCTEMPX_H	EQU	113
SYSCHARCOUNT	EQU	61
SYSDIVLOOP	EQU	116
SYSDIVMULTA	EQU	119
SYSDIVMULTA_H	EQU	120
SYSDIVMULTB	EQU	123
SYSDIVMULTB_H	EQU	124
SYSDIVMULTX	EQU	114
SYSDIVMULTX_H	EQU	115
SYSINTSTATESAVE0	EQU	62
SYSLONGDIVMULTA	EQU	63
SYSLONGDIVMULTA_E	EQU	66
SYSLONGDIVMULTA_H	EQU	64
SYSLONGDIVMULTA_U	EQU	65
SYSLONGDIVMULTB	EQU	67
SYSLONGDIVMULTB_E	EQU	70
SYSLONGDIVMULTB_H	EQU	68
SYSLONGDIVMULTB_U	EQU	69
SYSLONGDIVMULTX	EQU	71
SYSLONGDIVMULTX_E	EQU	74
SYSLONGDIVMULTX_H	EQU	72
SYSLONGDIVMULTX_U	EQU	73
SYSLONGTEMPA	EQU	117
SYSLONGTEMPA_E	EQU	120
SYSLONGTEMPA_H	EQU	118
SYSLONGTEMPA_U	EQU	119
SYSLONGTEMPB	EQU	121
SYSLONGTEMPB_E	EQU	124
SYSLONGTEMPB_H	EQU	122
SYSLONGTEMPB_U	EQU	123
SYSLONGTEMPX	EQU	112
SYSLONGTEMPX_E	EQU	115
SYSLONGTEMPX_H	EQU	113
SYSLONGTEMPX_U	EQU	114
SYSPRINTDATAHANDLER	EQU	75
SYSPRINTDATAHANDLER_H	EQU	76
SYSPRINTTEMP	EQU	77
SYSREPEATTEMP1	EQU	78
SYSREPEATTEMP2	EQU	79
SYSSTATUS	EQU	127
SYSSTRDATA	EQU	80
SYSSTRINGA	EQU	119
SYSSTRINGA_H	EQU	120
SYSSTRINGLENGTH	EQU	118
SYSSTRINGPARAM1	EQU	9186
SYSTEMP1	EQU	81
SYSTEMP1_E	EQU	84
SYSTEMP1_H	EQU	82
SYSTEMP1_U	EQU	83
SYSVALTEMP	EQU	85
SYSVALTEMP_H	EQU	86
SYSW	EQU	126
SYSWAITTEMP10US	EQU	117
SYSWAITTEMPMS	EQU	114
SYSWAITTEMPMS_H	EQU	115
SYSWAITTEMPS	EQU	116
SYSWORDTEMPA	EQU	117
SYSWORDTEMPA_H	EQU	118
SYSWORDTEMPB	EQU	121
SYSWORDTEMPB_H	EQU	122
SYSWORDTEMPX	EQU	112
SYSWORDTEMPX_H	EQU	113
TIMERSELECTIONBITS	EQU	87
TMRNUMBER	EQU	88
TMRPRES	EQU	89
TMRSOURCE	EQU	90
TMRVALUE	EQU	91
TMRVALUE_H	EQU	92
TX_PR	EQU	93
WRITEDATA	EQU	94
_PWMTIMERSELECTED	EQU	95

;********************************************************************************

;Alias variables
AFSR0	EQU	4
AFSR0_H	EQU	5
EEADDRESS	EQU	401
EEADDRESS_H	EQU	402
EEDATAVALUE	EQU	403
SYSREADADBYTE	EQU	56
SYSSTR_0	EQU	1596

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
	movf	PCLATH,W
	movwf	SavePCLATH
	clrf	PCLATH
;On Interrupt handlers
	btfss	INTCON,TMR0IE
	goto	NotTMR0IF
	btfss	INTCON,TMR0IF
	goto	NotTMR0IF
	call	LAB_ISR
	bcf	INTCON,TMR0IF
	goto	INTERRUPTDONE
NotTMR0IF
;User Interrupt routine
INTERRUPTDONE
;Restore Context
;Restore system variables
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
	ORG	30
BASPROGRAMSTART
;Call initialisation routines
	call	INITSYS
	call	INITUSART
	call	INITPWM
;Enable interrupts
	bsf	INTCON,GIE
	bsf	INTCON,PEIE

;Start of the main program
;''A demonstration program for GCGB and GCB.
;''--------------------------------------------------------------------------------------------------------------------------------
;''This program is intended to show the capabilities of Curiosity Board
;''This program uses the software implementation for the Microchip microprocessors.
;''The hardware serial connections are shown in the program but this is a hardware specific solution.
;'':
;''This will show the 10 demonstrations sequencially. Press the button to proceed to the next demonstration.
;'':
;''@author  EvanV
;''@licence GPL
;''@version 1.0a
;''@date    10.02.18
;''********************************************************************************
;Initialise the hardware for serial communications
;Initialise Module: USART
;USART settings
;#define USART_BAUD_RATE 9600
;#define USART_TX_BLOCKING
;Define constants for the ports, and set the direction
;#define S1_PORT      portc.0
;#define LED_D4_LAT   portb.4
;#define LED_D5_LAT   portb.5
;#define LED_D6_LAT   portb.6
;#define LED_D7_LAT   portb.7
;#define CCP1_PORT    portc.5   'CCP1 port
;#define ADCPORT      AN2       'ADC port
;dir S1_PORT          In
	banksel	TRISC
	bsf	TRISC,0
;dir LED_D4_LAT       Out
	bcf	TRISB,4
;dir LED_D5_LAT       Out
	bcf	TRISB,5
;dir LED_D6_LAT       Out
	bcf	TRISB,6
;dir LED_D7_LAT       Out
	bcf	TRISB,7
;Define constants that the demos use a macros
;#define LED_D4_SetHigh  LED_D4_LAT = On
;#define LED_D4_Toggle   LED_D4_LAT = !LED_D4_LAT
;Define constant values - do not change
;#define LOW                 0
;#define HIGH                1
;#define PRESSED             1
;#define NOT_PRESSED         0
;#define RUNNING             1
;#define NOT_RUNNING         0
;#define OVERFLOW            3
;#define LAST                16
;Define variables and Initialise
;dim g_rotateReg, g_labNumber, g_switchEvent,g_labState, g_btnState, g_lastcasechoice  as byte
;g_labNumber = 0
	banksel	G_LABNUMBER
	clrf	G_LABNUMBER
;g_switchEvent = 0
	clrf	G_SWITCHEVENT
;g_lastcasechoice = 0
	clrf	G_LASTCASECHOICE
;g_labState = NOT_RUNNING
	clrf	G_LABSTATE
;g_btnState = NOT_PRESSED
	clrf	G_BTNSTATE
;The main application
;HSerPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$
;HSerPrint "Curiosity Board Labs: "
	movlw	low StringTable1
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable1) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT277
	call	HSERPRINT277
	pagesel	$
;HSerPrint ChipNameStr
	movlw	low StringTable53
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable53) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT277
	call	HSERPRINT277
	pagesel	$
;HSerPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTCRLF
	call	HSERPRINTCRLF
	pagesel	$
;FlashLEDs()
	call	FLASHLEDS
;HSerPrintStringCRLF "Ready .."
	movlw	low StringTable2
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable2) | 128
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINTSTRINGCRLF
	call	HSERPRINTSTRINGCRLF
	pagesel	$
;do forever
SysDoLoop_S1
;checkButtonS1()
	pagesel	CHECKBUTTONS1
	call	CHECKBUTTONS1
	pagesel	$
;Display which is the demo is use
;if g_lastcasechoice <> g_labNumber then
	movf	G_LABNUMBER,W
	subwf	G_LASTCASECHOICE,W
	btfsc	STATUS, Z
	goto	ENDIF1
;HSerPrintStringCRLF "Lab Number: " + str( g_labNumber )
	movf	G_LABNUMBER,W
	movwf	SYSVALTEMP
	clrf	SYSVALTEMP_H
	call	FN_STR
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable3
	movwf	SysStringA
	movlw	(high StringTable3) & 127
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
	pagesel	HSERPRINTSTRINGCRLF
	call	HSERPRINTSTRINGCRLF
	pagesel	$
;g_lastcasechoice = g_labNumber
	movf	G_LABNUMBER,W
	movwf	G_LASTCASECHOICE
;end if
ENDIF1
;select case g_labNumber
;case 1:
SysSelect1Case1
	decf	G_LABNUMBER,W
	btfss	STATUS, Z
	goto	SysSelect1Case2
;HelloWorld()
	pagesel	HELLOWORLD
	call	HELLOWORLD
	pagesel	$
;case 2:
	goto	SysSelectEnd1
SysSelect1Case2
	movlw	2
	subwf	G_LABNUMBER,W
	btfss	STATUS, Z
	goto	SysSelect1Case3
;BlinkLED()
	pagesel	BLINKLED
	call	BLINKLED
	pagesel	$
;case 3:
	goto	SysSelectEnd1
SysSelect1Case3
	movlw	3
	subwf	G_LABNUMBER,W
	btfss	STATUS, Z
	goto	SysSelect1Case4
;RotateLEDS()
	call	ROTATELEDS
;case 4:
	goto	SysSelectEnd1
SysSelect1Case4
	movlw	4
	subwf	G_LABNUMBER,W
	btfss	STATUS, Z
	goto	SysSelect1Case5
;ADC2LEDs()
	call	ADC2LEDS
;case 5:
	goto	SysSelectEnd1
SysSelect1Case5
	movlw	5
	subwf	G_LABNUMBER,W
	btfss	STATUS, Z
	goto	SysSelect1Case6
;VSRLEDs()
	call	VSRLEDS
;case 6:
	goto	SysSelectEnd1
SysSelect1Case6
	movlw	6
	subwf	G_LABNUMBER,W
	btfss	STATUS, Z
	goto	SysSelect1Case7
;PWM2LEDs()
	call	PWM2LEDS
;case 7:
	goto	SysSelectEnd1
SysSelect1Case7
	movlw	7
	subwf	G_LABNUMBER,W
	btfss	STATUS, Z
	goto	SysSelect1Case8
;TimerLEDs()
	call	TIMERLEDS
;case 8:
	goto	SysSelectEnd1
SysSelect1Case8
	movlw	8
	subwf	G_LABNUMBER,W
	btfss	STATUS, Z
	goto	SysSelect1Case9
;Interrupt2LEDs()
	pagesel	INTERRUPT2LEDS
	call	INTERRUPT2LEDS
	pagesel	$
;case 9:
	goto	SysSelectEnd1
SysSelect1Case9
	movlw	9
	subwf	G_LABNUMBER,W
	btfss	STATUS, Z
	goto	SysSelect1Case10
;SleepWakeUp2LEDs()
	call	SLEEPWAKEUP2LEDS
;case 10:
	goto	SysSelectEnd1
SysSelect1Case10
	movlw	10
	subwf	G_LABNUMBER,W
	btfss	STATUS, Z
	goto	SysSelectEnd1
;increment the lab counter - do this because there are chips that do not support HEF or EEPROM
;g_labNumber++
	incf	G_LABNUMBER,F
;EEPROM2LEDs()
	call	EEPROM2LEDS
;g_labNumber--    'revert this counter as we executed a lab
	decf	G_LABNUMBER,F
;end select
SysSelectEnd1
;if (g_switchEvent) then
	movf	G_SWITCHEVENT,F
	btfsc	STATUS,Z
	goto	ENDIF2
;nextLab()
	pagesel	NEXTLAB
	call	NEXTLAB
	pagesel	$
;end if
ENDIF2
;loop
	goto	SysDoLoop_S1
SysDoLoop_E1
;Methods - these are all ported from the C version in the demonstration archive
;#define ADSpeed LowSpeed
;#define Timer1ReloadValue 0x0BDC
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

;********************************************************************************

ADC2LEDS
;dim l_adcResult as byte
;if ( g_labState <> RUNNING) then
	decf	G_LABSTATE,W
	btfsc	STATUS, Z
	goto	ENDIF31
;LED_D4_LAT = OFF
	banksel	LATB
	bcf	LATB,4
;LED_D5_LAT = OFF
	bcf	LATB,5
;LED_D6_LAT = OFF
	bcf	LATB,6
;LED_D7_LAT = OFF
	bcf	LATB,7
;g_labState = RUNNING
	movlw	1
	banksel	G_LABSTATE
	movwf	G_LABSTATE
;end if
ENDIF31
;if ( g_labState = RUNNING) then
	decf	G_LABSTATE,W
	btfss	STATUS, Z
	goto	ENDIF32
;Get the top 4 MSBs and display it on the LEDs
;l_adcResult = ReadAD( ADCPORT ) / 16
	movlw	2
	movwf	ADREADPORT
	call	FN_READAD26
	movf	SYSREADADBYTE,W
	movwf	SysBYTETempA
	movlw	16
	movwf	SysBYTETempB
	pagesel	SysDivSub
	call	SysDivSub
	pagesel	$
	movf	SysBYTETempA,W
	movwf	L_ADCRESULT
;Determine which LEDs will light up
;LED_D4_LAT = l_adcResult.0
	banksel	LATB
	bcf	LATB,4
	banksel	L_ADCRESULT
	btfss	L_ADCRESULT,0
	goto	ENDIF34
	banksel	LATB
	bsf	LATB,4
ENDIF34
;LED_D5_LAT = l_adcResult.1
	banksel	LATB
	bcf	LATB,5
	banksel	L_ADCRESULT
	btfss	L_ADCRESULT,1
	goto	ENDIF35
	banksel	LATB
	bsf	LATB,5
ENDIF35
;LED_D6_LAT = l_adcResult.2
	banksel	LATB
	bcf	LATB,6
	banksel	L_ADCRESULT
	btfss	L_ADCRESULT,2
	goto	ENDIF36
	banksel	LATB
	bsf	LATB,6
ENDIF36
;LED_D7_LAT = l_adcResult.3
	banksel	LATB
	bcf	LATB,7
	banksel	L_ADCRESULT
	btfss	L_ADCRESULT,3
	goto	ENDIF37
	banksel	LATB
	bsf	LATB,7
ENDIF37
;end if
ENDIF32
;Check if a switch event occurs
;if ( g_switchEvent = 1 ) then
	banksel	G_SWITCHEVENT
	decf	G_SWITCHEVENT,W
	btfsc	STATUS, Z
;g_labState = NOT_RUNNING
	clrf	G_LABSTATE
;end if
ENDIF33
	return

;********************************************************************************

Delay_MS
	incf	SysWaitTempMS_H, F
DMS_START
	movlw	17
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

EEPROM2LEDS
;dim l_adcResult as byte
;if ( g_labState <> RUNNING ) then
	decf	G_LABSTATE,W
	btfsc	STATUS, Z
	goto	ENDIF76
;LED_D4_LAT = OFF
	banksel	LATB
	bcf	LATB,4
;LED_D5_LAT = OFF
	bcf	LATB,5
;LED_D6_LAT = OFF
	bcf	LATB,6
;LED_D7_LAT = OFF
	bcf	LATB,7
;g_labState = RUNNING
	movlw	1
	banksel	G_LABSTATE
	movwf	G_LABSTATE
;end if
ENDIF76
;if ( g_labState = RUNNING)  Then
	decf	G_LABSTATE,W
	btfss	STATUS, Z
	goto	ENDIF77
;dim l_eeAddr, writeData as byte
;EEProm location, a value between 0 and 127 for the 128 EEProm memory
;l_eeAddr = 0x00
	clrf	L_EEADDR
;Get the top 4 MSBs of the ADC and write them to EEPROM
;l_adcResult = ReadAD( ADCPORT ) / 16
	movlw	2
	movwf	ADREADPORT
	call	FN_READAD26
	movf	SYSREADADBYTE,W
	movwf	SysBYTETempA
	movlw	16
	movwf	SysBYTETempB
	pagesel	SysDivSub
	call	SysDivSub
	pagesel	$
	movf	SysBYTETempA,W
	movwf	L_ADCRESULT
;EPWrite l_eeAddr, l_adcResult
	movf	L_EEADDR,W
	banksel	EEADDRESS
	movwf	EEADDRESS
	clrf	EEADDRESS_H
	banksel	L_ADCRESULT
	movf	L_ADCRESULT,W
	banksel	EEDATAVALUE
	movwf	EEDATAVALUE
	banksel	STATUS
	pagesel	EPWRITE
	call	EPWRITE
	pagesel	$
;ensure value is cleared
;writeData = 0x00
	clrf	WRITEDATA
;Read back value and then subsuently display on LEDs
;EPWrite l_eeAddr, writeData
	movf	L_EEADDR,W
	banksel	EEADDRESS
	movwf	EEADDRESS
	clrf	EEADDRESS_H
	banksel	WRITEDATA
	movf	WRITEDATA,W
	banksel	EEDATAVALUE
	movwf	EEDATAVALUE
	banksel	STATUS
	pagesel	EPWRITE
	call	EPWRITE
	pagesel	$
;Determine which LEDs will light up
;LED_D4_LAT = writeData.0
	banksel	LATB
	bcf	LATB,4
	banksel	WRITEDATA
	btfss	WRITEDATA,0
	goto	ENDIF79
	banksel	LATB
	bsf	LATB,4
ENDIF79
;LED_D5_LAT = writeData.1
	banksel	LATB
	bcf	LATB,5
	banksel	WRITEDATA
	btfss	WRITEDATA,1
	goto	ENDIF80
	banksel	LATB
	bsf	LATB,5
ENDIF80
;LED_D6_LAT = writeData.2
	banksel	LATB
	bcf	LATB,6
	banksel	WRITEDATA
	btfss	WRITEDATA,2
	goto	ENDIF81
	banksel	LATB
	bsf	LATB,6
ENDIF81
;LED_D7_LAT = writeData.3
	banksel	LATB
	bcf	LATB,7
	banksel	WRITEDATA
	btfss	WRITEDATA,3
	goto	ENDIF82
	banksel	LATB
	bsf	LATB,7
ENDIF82
;end if
ENDIF77
;Check if a switch event occurs
;if ( g_switchEvent = 1 ) then
	banksel	G_SWITCHEVENT
	decf	G_SWITCHEVENT,W
	btfsc	STATUS, Z
;g_labState = NOT_RUNNING
	clrf	G_LABSTATE
;end if
ENDIF78
	return

;********************************************************************************

FLASHLEDS
;LED_D4_LAT = OFF
	banksel	LATB
	bcf	LATB,4
;LED_D5_LAT = OFF
	bcf	LATB,5
;LED_D6_LAT = OFF
	bcf	LATB,6
;LED_D7_LAT = OFF
	bcf	LATB,7
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	banksel	STATUS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;Repeat 20
	movlw	20
	movwf	SysRepeatTemp1
SysRepeatLoop1
;LED_D4_LAT = !LED_D4_LAT
	clrf	SysTemp1
	btfsc	PORTB,4
	incf	SysTemp1,F
ENDIF10
	comf	SysTemp1,F
	banksel	LATB
	bcf	LATB,4
	banksel	SYSTEMP1
	btfss	SysTemp1,0
	goto	ENDIF11
	banksel	LATB
	bsf	LATB,4
ENDIF11
;LED_D6_LAT = !LED_D6_LAT
	banksel	SYSTEMP1
	clrf	SysTemp1
	btfsc	PORTB,6
	incf	SysTemp1,F
ENDIF12
	comf	SysTemp1,F
	banksel	LATB
	bcf	LATB,6
	banksel	SYSTEMP1
	btfss	SysTemp1,0
	goto	ENDIF13
	banksel	LATB
	bsf	LATB,6
ENDIF13
;LED_D5_LAT = !LED_D5_LAT
	banksel	SYSTEMP1
	clrf	SysTemp1
	btfsc	PORTB,5
	incf	SysTemp1,F
ENDIF14
	comf	SysTemp1,F
	banksel	LATB
	bcf	LATB,5
	banksel	SYSTEMP1
	btfss	SysTemp1,0
	goto	ENDIF15
	banksel	LATB
	bsf	LATB,5
ENDIF15
;LED_D7_LAT = !LED_D7_LAT
	banksel	SYSTEMP1
	clrf	SysTemp1
	btfsc	PORTB,7
	incf	SysTemp1,F
ENDIF16
	comf	SysTemp1,F
	banksel	LATB
	bcf	LATB,7
	banksel	SYSTEMP1
	btfss	SysTemp1,0
	goto	ENDIF17
	banksel	LATB
	bsf	LATB,7
ENDIF17
;wait 100 ms
	movlw	100
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	banksel	STATUS
	call	Delay_MS
;end Repeat
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop1
SysRepeatLoopEnd1
;LED_D4_LAT = OFF
	banksel	LATB
	bcf	LATB,4
;LED_D5_LAT = OFF
	bcf	LATB,5
;LED_D6_LAT = OFF
	bcf	LATB,6
;LED_D7_LAT = OFF
	bcf	LATB,7
	banksel	STATUS
	return

;********************************************************************************

;Overloaded signature: BYTE:BYTE:BYTE:
HPWM46
;Dim PRx_Temp as LONG
;Dim PRx_Temp_Cache as Long
;dim PWMDuty as word
;dim PWMResolution as word: PWMResolution = 255
	movlw	255
	movwf	PWMRESOLUTION
	clrf	PWMRESOLUTION_H
;If HPWM_FAST operation selected, only recalculate timer prescaler when
;needed. Gives faster operation, but uses extra byte of RAM and may cause
;problems if HPWM and PWMOn are used together in a program.
;(No issues using HPWM and PWMOff in the same program with HPWM_FAST.)
;Commence calculations of PMW parameters
;This figures out Postscaler required.  We can set to 1, 4 or 16 to set Tx_PR
;So, start with 1 - check the remainder. If the remainder in the high byte is greater then zero then do same with a prescaler value of 4
;So, using 4 - check the remainder. If the remainder in the high byte is greater then zero then do same with a prescaler value of 16
;So, using 16
;This simply set Tx_PR to 1,4 or 16
;Tx_PR = 1
	movlw	1
	movwf	TX_PR
;PRx_Temp = PWMOsc1 / PWMFreq
	movlw	125
	movwf	SysLONGTempA
	clrf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	movf	PWMFREQ,W
	movwf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	call	SysDivSub32
	movf	SysLONGTempA,W
	movwf	PRX_TEMP
	movf	SysLONGTempA_H,W
	movwf	PRX_TEMP_H
	movf	SysLONGTempA_U,W
	movwf	PRX_TEMP_U
	movf	SysLONGTempA_E,W
	movwf	PRX_TEMP_E
;IF PRx_Temp_H > 0 then
	movf	PRX_TEMP_H,W
	sublw	0
	btfsc	STATUS, C
	goto	ENDIF88
;Tx_PR = 4
	movlw	4
	movwf	TX_PR
;Divide by 4
;set STATUS.C off
	bcf	STATUS,C
;rotate PRx_Temp right
	rrf	PRX_TEMP_E,F
	rrf	PRX_TEMP_U,F
	rrf	PRX_TEMP_H,F
	rrf	PRX_TEMP,F
;set STATUS.C off
	bcf	STATUS,C
;rotate PRx_Temp right
	rrf	PRX_TEMP_E,F
	rrf	PRX_TEMP_U,F
	rrf	PRX_TEMP_H,F
	rrf	PRX_TEMP,F
;end if
ENDIF88
;IF PRx_Temp_H > 0 then
	movf	PRX_TEMP_H,W
	sublw	0
	btfsc	STATUS, C
	goto	ENDIF89
;Tx_PR = 16
	movlw	16
	movwf	TX_PR
;Divide by 4
;set STATUS.C off
	bcf	STATUS,C
;rotate PRx_Temp right
	rrf	PRX_TEMP_E,F
	rrf	PRX_TEMP_U,F
	rrf	PRX_TEMP_H,F
	rrf	PRX_TEMP,F
;set STATUS.C off
	bcf	STATUS,C
;rotate PRx_Temp right
	rrf	PRX_TEMP_E,F
	rrf	PRX_TEMP_U,F
	rrf	PRX_TEMP_H,F
	rrf	PRX_TEMP,F
;end if
ENDIF89
;IF PRx_Temp_H > 0 then
	movf	PRX_TEMP_H,W
	sublw	0
	btfsc	STATUS, C
	goto	ENDIF90
;Tx_PR = 64
	movlw	64
	movwf	TX_PR
;Divide by 4
;set STATUS.C off
	bcf	STATUS,C
;rotate PRx_Temp right
	rrf	PRX_TEMP_E,F
	rrf	PRX_TEMP_U,F
	rrf	PRX_TEMP_H,F
	rrf	PRX_TEMP,F
;set STATUS.C off
	bcf	STATUS,C
;rotate PRx_Temp right
	rrf	PRX_TEMP_E,F
	rrf	PRX_TEMP_U,F
	rrf	PRX_TEMP_H,F
	rrf	PRX_TEMP,F
;end if
ENDIF90
;added to handle different timer sources
;added to support HPWM_CCPTimerN. Makes the code longer but more flexible
;user optimisation to reduce code.
CCPPWMSETUPCLOCKSOURCE
;select case _PWMTimerSelected
;case 2:
SysSelect3Case1
	movlw	2
	subwf	_PWMTIMERSELECTED,W
	btfss	STATUS, Z
	goto	SysSelect3Case2
;PR2 = PRx_Temp
	movf	PRX_TEMP,W
	movwf	PR2
;Set the Bits for the Postscaler
;Setup Timerx by clearing the Prescaler bits - it is set next....
;Revised to show overflow issue
;SET T2CKPS0 OFF
	bcf	T2CON,T2CKPS0
;SET T2CKPS1 OFF
	bcf	T2CON,T2CKPS1
;Set Prescaler bits
;if Tx_PR = 4  then SET T2CKPS0 ON
	movlw	4
	subwf	TX_PR,W
	btfsc	STATUS, Z
	bsf	T2CON,T2CKPS0
ENDIF91
;if Tx_PR = 16 then SET T2CKPS1 ON
	movlw	16
	subwf	TX_PR,W
	btfsc	STATUS, Z
	bsf	T2CON,T2CKPS1
ENDIF92
;Overflowed - this chip cannot handle the desired PWMFrequency. Lower clock speed.
;if T2CON and 3 = 3 then an overflow has occured!
;if Tx_PR = 64 then SET T2CKPS0 ON: SET T2CKPS1 ON
	movlw	64
	subwf	TX_PR,W
	btfss	STATUS, Z
	goto	ENDIF93
	bsf	T2CON,T2CKPS0
	bsf	T2CON,T2CKPS1
ENDIF93
;Set Clock Source, if required
;case 4:
	goto	SysSelectEnd3
SysSelect3Case2
	movlw	4
	subwf	_PWMTIMERSELECTED,W
	btfss	STATUS, Z
	goto	SysSelect3Case3
;PR4 = PRx_Temp
	movf	PRX_TEMP,W
	banksel	PR4
	movwf	PR4
;Set the Bits for the Postscaler
;Setup Timerx by clearing the Prescaler bits - it is set next....
;Revised to show overflow issue
;SET T4CKPS0 OFF
	bcf	T4CON,T4CKPS0
;SET T4CKPS1 OFF
	bcf	T4CON,T4CKPS1
;Set Prescaler bits
;if Tx_PR = 4  then SET T4CKPS0 ON
	movlw	4
	banksel	TX_PR
	subwf	TX_PR,W
	btfss	STATUS, Z
	goto	ENDIF94
	banksel	T4CON
	bsf	T4CON,T4CKPS0
ENDIF94
;if Tx_PR = 16 then SET T4CKPS1 ON
	movlw	16
	banksel	TX_PR
	subwf	TX_PR,W
	btfss	STATUS, Z
	goto	ENDIF95
	banksel	T4CON
	bsf	T4CON,T4CKPS1
ENDIF95
;Overflowed - this chip cannot handle the desired PWMFrequency. Lower clock speed.
;if T4CON and 3 = 3 then an overflow has occured!
;if Tx_PR = 64 then SET T4CKPS0 ON: SET T4CKPS1 ON
	movlw	64
	banksel	TX_PR
	subwf	TX_PR,W
	btfss	STATUS, Z
	goto	ENDIF96
	banksel	T4CON
	bsf	T4CON,T4CKPS0
	bsf	T4CON,T4CKPS1
ENDIF96
;Set Clock Source, if required
;case 6:
	goto	SysSelectEnd3
SysSelect3Case3
	movlw	6
	subwf	_PWMTIMERSELECTED,W
	btfss	STATUS, Z
	goto	SysSelectEnd3
;PR6 = PRx_Temp
	movf	PRX_TEMP,W
	banksel	PR6
	movwf	PR6
;Set the Bits for the Postscaler
;Setup Timerx by clearing the Prescaler bits - it is set next....
;Revised to show overflow issue
;SET T6CKPS0 OFF
	bcf	T6CON,T6CKPS0
;SET T6CKPS1 OFF
	bcf	T6CON,T6CKPS1
;Set Prescaler bits
;if Tx_PR = 4  then SET T6CKPS0 ON
	movlw	4
	banksel	TX_PR
	subwf	TX_PR,W
	btfss	STATUS, Z
	goto	ENDIF97
	banksel	T6CON
	bsf	T6CON,T6CKPS0
ENDIF97
;if Tx_PR = 16 then SET T6CKPS1 ON
	movlw	16
	banksel	TX_PR
	subwf	TX_PR,W
	btfss	STATUS, Z
	goto	ENDIF98
	banksel	T6CON
	bsf	T6CON,T6CKPS1
ENDIF98
;Overflowed - this chip cannot handle the desired PWMFrequency. Lower clock speed.
;if T6CON and 3 = 3 then an overflow has occured!
;if Tx_PR = 64 then SET T6CKPS0 ON: SET T6CKPS1 ON
	movlw	64
	banksel	TX_PR
	subwf	TX_PR,W
	btfss	STATUS, Z
	goto	ENDIF99
	banksel	T6CON
	bsf	T6CON,T6CKPS0
	bsf	T6CON,T6CKPS1
ENDIF99
;Set Clock Source, if required
;end Select
SysSelectEnd3
END_OF_CCPPWMSETUPCLOCKSOURCE
;this code can be optimised by using defines USE_HPWMCCP1|2|3|4|5
;and, you can define user setup and exit commands using AddHPWMCCPSetupN and  AddHPWMCCPExitN
;These can be used to FIX little errors!
SETUPTHECORRECTTIMERBITS
;ChipPWMTimerVariant some chips have variants on CCPTMRS0
;TimerSelectionBits =  (_PWMTimerSelected / 2 )-1
	bcf	STATUS,C
	banksel	_PWMTIMERSELECTED
	rrf	_PWMTIMERSELECTED,W
	movwf	SysTemp1
	decf	SysTemp1,W
	movwf	TIMERSELECTIONBITS
SETUPCCPPWMREGISTERS
;C1TSEL0 = TimerSelectionBits.0
	banksel	CCPTMRS
	bcf	CCPTMRS,C1TSEL0
	banksel	TIMERSELECTIONBITS
	btfss	TIMERSELECTIONBITS,0
	goto	ENDIF108
	banksel	CCPTMRS
	bsf	CCPTMRS,C1TSEL0
ENDIF108
;C1TSEL1 = TimerSelectionBits.1
	banksel	CCPTMRS
	bcf	CCPTMRS,C1TSEL1
	banksel	TIMERSELECTIONBITS
	btfss	TIMERSELECTIONBITS,1
	goto	ENDIF109
	banksel	CCPTMRS
	bsf	CCPTMRS,C1TSEL1
ENDIF109
;Devices with more than one CCP
;if PWMChannel = 1 then
	banksel	PWMCHANNEL
	decf	PWMCHANNEL,W
	btfss	STATUS, Z
	goto	ENDIF100
;Testing this bit is to identify the 2016 chip that use CCPR1H and CCPR1L of PWM
;PRx_Temp = PWMDuty * (PRx_Temp + 2)  'Correction  - WMR
	movlw	2
	addwf	PRX_TEMP,W
	movwf	SysTemp1
	movlw	0
	addwfc	PRX_TEMP_H,W
	movwf	SysTemp1_H
	movlw	0
	addwfc	PRX_TEMP_U,W
	movwf	SysTemp1_U
	movlw	0
	addwfc	PRX_TEMP_E,W
	movwf	SysTemp1_E
	movf	PWMDUTY,W
	movwf	SysLONGTempA
	movf	PWMDUTY_H,W
	movwf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	movf	SysTemp1,W
	movwf	SysLONGTempB
	movf	SysTemp1_H,W
	movwf	SysLONGTempB_H
	movf	SysTemp1_U,W
	movwf	SysLONGTempB_U
	movf	SysTemp1_E,W
	movwf	SysLONGTempB_E
	call	SysMultSub32
	movf	SysLONGTempX,W
	movwf	PRX_TEMP
	movf	SysLONGTempX_H,W
	movwf	PRX_TEMP_H
	movf	SysLONGTempX_U,W
	movwf	PRX_TEMP_U
	movf	SysLONGTempX_E,W
	movwf	PRX_TEMP_E
;CCPR1L = PRx_Temp_H
	movf	PRX_TEMP_H,W
	banksel	CCPR1L
	movwf	CCPR1L
;If PWMDuty = 0 Then CCPR1L = 0  ' Assure OFF at Zero - WMR
	banksel	PWMDUTY
	movf	PWMDUTY,W
	movwf	SysWORDTempA
	movf	PWMDUTY_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF104
	banksel	CCPR1L
	clrf	CCPR1L
ENDIF104
;SET CCP1M3 ON
	banksel	CCP1CON
	bsf	CCP1CON,CCP1M3
;SET CCP1M2 ON
	bsf	CCP1CON,CCP1M2
;SET CCP1M1 OFF
	bcf	CCP1CON,CCP1M1
;SET CCP1M0 OFF
	bcf	CCP1CON,CCP1M0
;Testing this bit is to identify the 2016 chip that use CCPR1H and CCPR1L of PWM
;C1TSEL0 = TimerSelectionBits.0
	bcf	CCPTMRS,C1TSEL0
	banksel	TIMERSELECTIONBITS
	btfss	TIMERSELECTIONBITS,0
	goto	ENDIF110
	banksel	CCPTMRS
	bsf	CCPTMRS,C1TSEL0
ENDIF110
;C1TSEL1 = TimerSelectionBits.1
	banksel	CCPTMRS
	bcf	CCPTMRS,C1TSEL1
	banksel	TIMERSELECTIONBITS
	btfss	TIMERSELECTIONBITS,1
	goto	ENDIF111
	banksel	CCPTMRS
	bsf	CCPTMRS,C1TSEL1
ENDIF111
;end if
ENDIF100
;if PWMChannel = 2 then
	movlw	2
	banksel	PWMCHANNEL
	subwf	PWMCHANNEL,W
	btfss	STATUS, Z
	goto	ENDIF101
;PRx_Temp = PWMDuty * ( PRx_Temp + 2)  'Correction  - WMR
	movlw	2
	addwf	PRX_TEMP,W
	movwf	SysTemp1
	movlw	0
	addwfc	PRX_TEMP_H,W
	movwf	SysTemp1_H
	movlw	0
	addwfc	PRX_TEMP_U,W
	movwf	SysTemp1_U
	movlw	0
	addwfc	PRX_TEMP_E,W
	movwf	SysTemp1_E
	movf	PWMDUTY,W
	movwf	SysLONGTempA
	movf	PWMDUTY_H,W
	movwf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	movf	SysTemp1,W
	movwf	SysLONGTempB
	movf	SysTemp1_H,W
	movwf	SysLONGTempB_H
	movf	SysTemp1_U,W
	movwf	SysLONGTempB_U
	movf	SysTemp1_E,W
	movwf	SysLONGTempB_E
	call	SysMultSub32
	movf	SysLONGTempX,W
	movwf	PRX_TEMP
	movf	SysLONGTempX_H,W
	movwf	PRX_TEMP_H
	movf	SysLONGTempX_U,W
	movwf	PRX_TEMP_U
	movf	SysLONGTempX_E,W
	movwf	PRX_TEMP_E
;CCPR2L = PRx_Temp_H
	movf	PRX_TEMP_H,W
	banksel	CCPR2L
	movwf	CCPR2L
;If PWMDuty = 0 Then CCPR2L = 0  ' Assure OFF at Zero - WMR
	banksel	PWMDUTY
	movf	PWMDUTY,W
	movwf	SysWORDTempA
	movf	PWMDUTY_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF105
	banksel	CCPR2L
	clrf	CCPR2L
ENDIF105
;SET CCP2M3 ON
	banksel	CCP2CON
	bsf	CCP2CON,CCP2M3
;SET CCP2M2 ON
	bsf	CCP2CON,CCP2M2
;SET CCP2M1 OFF
	bcf	CCP2CON,CCP2M1
;SET CCP2M0 OFF
	bcf	CCP2CON,CCP2M0
;C2TSEL0 = TimerSelectionBits.0
	bcf	CCPTMRS,C2TSEL0
	banksel	TIMERSELECTIONBITS
	btfss	TIMERSELECTIONBITS,0
	goto	ENDIF112
	banksel	CCPTMRS
	bsf	CCPTMRS,C2TSEL0
ENDIF112
;C2TSEL1 = TimerSelectionBits.1
	banksel	CCPTMRS
	bcf	CCPTMRS,C2TSEL1
	banksel	TIMERSELECTIONBITS
	btfss	TIMERSELECTIONBITS,1
	goto	ENDIF113
	banksel	CCPTMRS
	bsf	CCPTMRS,C2TSEL1
ENDIF113
;end if
ENDIF101
;if PWMChannel = 3 then 'USE_HPWMCCP3 TRUE
	movlw	3
	banksel	PWMCHANNEL
	subwf	PWMCHANNEL,W
	btfss	STATUS, Z
	goto	ENDIF102
;PRx_Temp = PWMDuty * (PRx_Temp + 2)  'Correction  - WMR
	movlw	2
	addwf	PRX_TEMP,W
	movwf	SysTemp1
	movlw	0
	addwfc	PRX_TEMP_H,W
	movwf	SysTemp1_H
	movlw	0
	addwfc	PRX_TEMP_U,W
	movwf	SysTemp1_U
	movlw	0
	addwfc	PRX_TEMP_E,W
	movwf	SysTemp1_E
	movf	PWMDUTY,W
	movwf	SysLONGTempA
	movf	PWMDUTY_H,W
	movwf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	movf	SysTemp1,W
	movwf	SysLONGTempB
	movf	SysTemp1_H,W
	movwf	SysLONGTempB_H
	movf	SysTemp1_U,W
	movwf	SysLONGTempB_U
	movf	SysTemp1_E,W
	movwf	SysLONGTempB_E
	call	SysMultSub32
	movf	SysLONGTempX,W
	movwf	PRX_TEMP
	movf	SysLONGTempX_H,W
	movwf	PRX_TEMP_H
	movf	SysLONGTempX_U,W
	movwf	PRX_TEMP_U
	movf	SysLONGTempX_E,W
	movwf	PRX_TEMP_E
;CCPR3L = PRx_Temp_H
	movf	PRX_TEMP_H,W
	banksel	CCPR3L
	movwf	CCPR3L
;If PWMDuty = 0 Then CCPR3L = 0  ' Assure OFF at Zero - WMR
	banksel	PWMDUTY
	movf	PWMDUTY,W
	movwf	SysWORDTempA
	movf	PWMDUTY_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF106
	banksel	CCPR3L
	clrf	CCPR3L
ENDIF106
;SET CCP3M3 ON
	banksel	CCP3CON
	bsf	CCP3CON,CCP3M3
;SET CCP3M2 ON
	bsf	CCP3CON,CCP3M2
;SET CCP3M1 OFF
	bcf	CCP3CON,CCP3M1
;SET CCP3M0 OFF
	bcf	CCP3CON,CCP3M0
;C3TSEL0 = TimerSelectionBits.0
	banksel	CCPTMRS
	bcf	CCPTMRS,C3TSEL0
	banksel	TIMERSELECTIONBITS
	btfss	TIMERSELECTIONBITS,0
	goto	ENDIF114
	banksel	CCPTMRS
	bsf	CCPTMRS,C3TSEL0
ENDIF114
;C3TSEL1 = TimerSelectionBits.1
	banksel	CCPTMRS
	bcf	CCPTMRS,C3TSEL1
	banksel	TIMERSELECTIONBITS
	btfss	TIMERSELECTIONBITS,1
	goto	ENDIF115
	banksel	CCPTMRS
	bsf	CCPTMRS,C3TSEL1
ENDIF115
;end if
ENDIF102
;if PWMChannel = 4 then  'USE_HPWMCCP4 TRUE
	movlw	4
	banksel	PWMCHANNEL
	subwf	PWMCHANNEL,W
	btfss	STATUS, Z
	goto	ENDIF103
;PRx_Temp = PWMDuty * (PRx_Temp + 2)  '
	movlw	2
	addwf	PRX_TEMP,W
	movwf	SysTemp1
	movlw	0
	addwfc	PRX_TEMP_H,W
	movwf	SysTemp1_H
	movlw	0
	addwfc	PRX_TEMP_U,W
	movwf	SysTemp1_U
	movlw	0
	addwfc	PRX_TEMP_E,W
	movwf	SysTemp1_E
	movf	PWMDUTY,W
	movwf	SysLONGTempA
	movf	PWMDUTY_H,W
	movwf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	movf	SysTemp1,W
	movwf	SysLONGTempB
	movf	SysTemp1_H,W
	movwf	SysLONGTempB_H
	movf	SysTemp1_U,W
	movwf	SysLONGTempB_U
	movf	SysTemp1_E,W
	movwf	SysLONGTempB_E
	call	SysMultSub32
	movf	SysLONGTempX,W
	movwf	PRX_TEMP
	movf	SysLONGTempX_H,W
	movwf	PRX_TEMP_H
	movf	SysLONGTempX_U,W
	movwf	PRX_TEMP_U
	movf	SysLONGTempX_E,W
	movwf	PRX_TEMP_E
;CCPR4L = PRx_Temp_H
	movf	PRX_TEMP_H,W
	banksel	CCPR4L
	movwf	CCPR4L
;If PWMDuty = 0 Then CCPR4L = 0  ' Assure OFF at Zero - WMR
	banksel	PWMDUTY
	movf	PWMDUTY,W
	movwf	SysWORDTempA
	movf	PWMDUTY_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF107
	banksel	CCPR4L
	clrf	CCPR4L
ENDIF107
;SET CCP4M3 ON'These my have been remapped using a script - do check ASM and script in INITPWM @1@CCP4
	banksel	CCP4CON
	bsf	CCP4CON,CCP4M3
;SET CCP4M2 ON'These my have been remapped using a script - do check ASM and script in INITPWM
	bsf	CCP4CON,CCP4M2
;SET CCP4M1 OFF'These my have been remapped using a script - do check ASM and script in INITPWM
	bcf	CCP4CON,CCP4M1
;SET CCP4M0 OFF'These my have been remapped using a script - do check ASM and script in INITPWM
	bcf	CCP4CON,CCP4M0
;C4TSEL0 = TimerSelectionBits.0
	banksel	CCPTMRS
	bcf	CCPTMRS,C4TSEL0
	banksel	TIMERSELECTIONBITS
	btfss	TIMERSELECTIONBITS,0
	goto	ENDIF116
	banksel	CCPTMRS
	bsf	CCPTMRS,C4TSEL0
ENDIF116
;C4TSEL1 = TimerSelectionBits.1
	banksel	CCPTMRS
	bcf	CCPTMRS,C4TSEL1
	banksel	TIMERSELECTIONBITS
	btfss	TIMERSELECTIONBITS,1
	goto	ENDIF117
	banksel	CCPTMRS
	bsf	CCPTMRS,C4TSEL1
ENDIF117
;end if
ENDIF103
	banksel	STATUS
	return

;********************************************************************************

INITPWM
;_PWMTimerSelected = 2
	movlw	2
	movwf	_PWMTIMERSELECTED
;Dim PRx_Temp as LONG
;Script to calculate constants required for given Frequency and Duty Cycle
LEGACY_STARTOFFIXEDCCPPWMMODECODE
;You can disable all the legacy CCPPWM fixed mode code to reduce program size
;This section is Library code, so it generates ASM
;This section uses the constants defined the script above.
;Essentially, sets CCPCONCache with the bits set correctly.
;And, timer 2.  Remember timer 2 can be the timer for CCP/PWM but the other timers can be specified for certain parts.
;If CCP1CON does not exist then there is NO CCP1 so no point in setting, as all this is to set up the CCP1 using constants method
;DIM CCPCONCache as BYTE
;CCPCONCache = 0
	clrf	CCPCONCACHE
;Set PWM Period
;PR2 = PR2_CPP_PWM_Temp
	movlw	3
	movwf	PR2
;SET T2CON.T2CKPS0 OFF
	bcf	T2CON,T2CKPS0
;SET T2CON.T2CKPS1 OFF
	bcf	T2CON,T2CKPS1
;Set Duty cycle
;This is the legacy code to support only one CCPPWM channel
;CCPR1L = DutyCycleH
	movlw	2
	banksel	CCPR1L
	movwf	CCPR1L
;SET CCPCONCache.DC1B1 OFF
	banksel	CCPCONCACHE
	bcf	CCPCONCACHE,DC1B1
;SET CCPCONCache.DC1B0 OFF
	bcf	CCPCONCACHE,DC1B0
;legacy code, replaced by canskip
;Finish preparing CCP*CON
;SET CCPCONCache.CCP1M3 ON
;SET CCPCONCache.CCP1M2 ON
;SET CCPCONCache.CCP1M1 OFF
;SET CCPCONCache.CCP1M0 OFF'
;CCPCONCache.CCP1M3, CCPCONCache.CCP1M2, CCPCONCache.CCP1M1, CCPCONCache.CCP1M0 = b'1100'
	bsf	CCPCONCACHE,CCP1M3
	bsf	CCPCONCACHE,CCP1M2
	bcf	CCPCONCACHE,CCP1M1
	bcf	CCPCONCACHE,CCP1M0
;Enable Timer 2
;SET T2CON.TMR2ON ON
	bsf	T2CON,TMR2ON
;This is the end of script section, now we use the constants created to updated registers.
STARTOFFIXEDPWMMODECODE
;Set registers using the constants from script
;This is repeated for timer 2, 4 and 6 - and the two timer variants and the 9 PWM channels
;This uses the user defined constants to set the appropiate registers.
SETPWMDUTYCODE
;This section finally, sets the Duty using the constants from the script.
;This uses the user defined constants to set the appropiate registers.
REV2018_ENDOFFIXEDPWMMODECODE
;This is the end of the fixed PWM Mode handler
	return

;********************************************************************************

INITSYS
;asm showdebug OSCCON type is 105 'Bit(SPLLEN) Or Bit(IRCF3) And NoBit(INTSRC) and ifdef Bit(IRCF3)
;osccon type is 105
;OSCCON = OSCCON AND b'10000111'
;OSCCON = OSCCON OR b'00111000'
;Set IRCF3 Off
	banksel	OSCCON
	bcf	OSCCON,IRCF3
;Set IRCF2 On
	bsf	OSCCON,IRCF2
;Set IRCF1 On
	bsf	OSCCON,IRCF1
;Set IRCF0 On
	bsf	OSCCON,IRCF0
;Set SPLLEN Off
	bcf	OSCCON,SPLLEN
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

INITTIMER1
;Pwr On Reset State of TxCON for 1/3/5/7 is "0"
;TXCON Timer REGISTER for 1/3/5/7 are NOT the Same on ALL PICS
;TMRON is Bit0 on all Chips
;** OSCEN & SOSCEN are always TxCON.3 and perform the same function
;See Datasheet for Detailed Register Information
;Test for valid Pres parameter
;uses less memory than multiple boulean "AND"
;If TMRPres <> 0 then
	movf	TMRPRES,F
	btfsc	STATUS, Z
	goto	ENDIF133
;IF TMRPres <> 16 then
	movlw	16
	subwf	TMRPRES,W
	btfsc	STATUS, Z
	goto	ENDIF138
;IF TMRPres <> 32 then
	movlw	32
	subwf	TMRPRES,W
	btfsc	STATUS, Z
	goto	ENDIF139
;IF TMRPres <> 48 then
	movlw	48
	subwf	TMRPRES,W
	btfss	STATUS, Z
;TMRPres = 0
	clrf	TMRPRES
;END IF
ENDIF140
;END IF
ENDIF139
;END IF
ENDIF138
;END IF
ENDIF133
;Re-Using TMRPres as TxCON Temp Register
;IF TMR1ON = 1 then Set TMRPres.0 ON  'The timer running/ Dont Stop !
	btfsc	T1CON,TMR1ON
	bsf	TMRPRES,0
ENDIF134
;Select Case uses too much memory - changed
;IF TMRSource = OSC then
	decf	TMRSOURCE,W
	btfss	STATUS, Z
	goto	ENDIF135
;Set TMRPres.7 OFF
	bcf	TMRPRES,7
;Set TMRPres.3 OFF  'SOSCEN and OSCEN are Always Bit 3
	bcf	TMRPRES,3
;END IF
ENDIF135
;IF TMRSource = EXT then
	movlw	2
	subwf	TMRSOURCE,W
	btfss	STATUS, Z
	goto	ENDIF136
;Set TMRPres.7 ON
	bsf	TMRPRES,7
;Set TMRPres.3 OFF
	bcf	TMRPRES,3
;END IF
ENDIF136
;If TMRSource = ExtOsc Then
	movlw	3
	subwf	TMRSOURCE,W
	btfss	STATUS, Z
	goto	ENDIF137
;Set TMRPres.7 ON
	bsf	TMRPRES,7
;Set TMRPres.3 ON
	bsf	TMRPRES,3
;END IF
ENDIF137
;Done building Temp Variable. Now write register
;T1CON = TMRPres
	movf	TMRPRES,W
	movwf	T1CON
;33 Newer Chips have TxCLK Register ( TIMER 1/3/5/7 )
;
;12/16F16xx   Series
;16F153xx     Series
;16F188xx     Series
;18F1xxK40    series
	return

;********************************************************************************

INITUSART
;Set the default value for comport
;comport = 1
	movlw	1
	movwf	COMPORT
;Set baud rate for legacy chips
;SPBRG = SPBRGL_TEMP
	movlw	12
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

LAB_ISR
;Clear timer0 event
;TMR0IF = 0
	bcf	INTCON,TMR0IF
;If the last LED has been lit, restart the pattern
;if ( g_rotateReg = 1 ) then
	decf	G_ROTATEREG,W
	btfss	STATUS, Z
	goto	ENDIF59
;g_rotateReg = LAST
	movlw	16
	movwf	G_ROTATEREG
;end if
ENDIF59
;rotate g_rotateReg right simple
	rrf	G_ROTATEREG,W
	rrf	G_ROTATEREG,F
;Determine which LEDs will light up
;LED_D4_LAT = g_rotateReg.0
	banksel	LATB
	bcf	LATB,4
	banksel	G_ROTATEREG
	btfss	G_ROTATEREG,0
	goto	ENDIF60
	banksel	LATB
	bsf	LATB,4
ENDIF60
;LED_D5_LAT = g_rotateReg.1
	banksel	LATB
	bcf	LATB,5
	banksel	G_ROTATEREG
	btfss	G_ROTATEREG,1
	goto	ENDIF61
	banksel	LATB
	bsf	LATB,5
ENDIF61
;LED_D6_LAT = g_rotateReg.2
	banksel	LATB
	bcf	LATB,6
	banksel	G_ROTATEREG
	btfss	G_ROTATEREG,2
	goto	ENDIF62
	banksel	LATB
	bsf	LATB,6
ENDIF62
;LED_D7_LAT = g_rotateReg.3
	banksel	LATB
	bcf	LATB,7
	banksel	G_ROTATEREG
	btfss	G_ROTATEREG,3
	goto	ENDIF63
	banksel	LATB
	bsf	LATB,7
ENDIF63
	banksel	STATUS
	return

;********************************************************************************

PWM2LEDS
;dim l_adcResult as byte
;if ( g_labState <> RUNNING ) then
	decf	G_LABSTATE,W
	btfsc	STATUS, Z
	goto	ENDIF46
;LED_D4_LAT = OFF
	banksel	LATB
	bcf	LATB,4
;LED_D5_LAT = OFF
	bcf	LATB,5
;LED_D6_LAT = OFF
	bcf	LATB,6
;LED_D7_LAT = OFF
	bcf	LATB,7
;dir CCP1_PORT out
	banksel	TRISC
	bcf	TRISC,5
;Set LEDs as output of CCP1 using PPS
;g_labState = RUNNING
	movlw	1
	banksel	G_LABSTATE
	movwf	G_LABSTATE
;end if
ENDIF46
;if ( g_labState = RUNNING ) then
	decf	G_LABSTATE,W
	btfss	STATUS, Z
	goto	ENDIF47
;Start ADC conversion
;l_adcResult = ReadAD( ADCPORT )
	movlw	2
	movwf	ADREADPORT
	call	FN_READAD26
	movf	SYSREADADBYTE,W
	movwf	L_ADCRESULT
;Make the adcResult the PWM duty cycle
;HPWM 1, 10, l_adcResult
	movlw	1
	movwf	PWMCHANNEL
	movlw	10
	movwf	PWMFREQ
	movf	L_ADCRESULT,W
	movwf	PWMDUTY
	clrf	PWMDUTY_H
	call	HPWM46
	movf	PWMDUTY,W
	movwf	L_ADCRESULT
;Make sure the ADC is NOT read every few nano seconds, so, wait 1 ms
;wait 1 ms
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;end if
ENDIF47
;Check if a switch event occurs
;if ( g_switchEvent = 1 ) then
	decf	G_SWITCHEVENT,W
	btfss	STATUS, Z
	goto	ENDIF48
;HPWMOff               'turn off CCP channel 1
	pagesel	PWMOFF42
	call	PWMOFF42
	pagesel	$
;Restore to normal output
;g_labState = NOT_RUNNING
	clrf	G_LABSTATE
;end if
ENDIF48
	return

;********************************************************************************

;Overloaded signature: BYTE:
FN_READAD26
;ADFM must be OFF! BACKWARDS Compatbility!
;ADFM should be be changed.
;Always LEFT justified
;SET ADFM OFF
	banksel	ADCON1
	bcf	ADCON1,ADFM
;for 16F1885x and possibly future others
;A differential ADC
;***************************************
;Perform conversion
;LLReadAD 1
;Set up A/D
;Make necessary ports analog
;Code for PICs with older A/D (No ANSEL register)
;Code for 16F193x chips (and others?) with ANSELA/ANSELB/ANSELE registers
;Select Case ADReadPort ' #IFDEF Var(ANSELA). ANSELA exists @DebugADC_H
;based on 16f1709 annd 16f685
;Case 0: Set ANSELA.0 On
SysSelect2Case1
	banksel	ADREADPORT
	movf	ADREADPORT,F
	btfss	STATUS, Z
	goto	SysSelect2Case2
	banksel	ANSELA
	bsf	ANSELA,0
;Case 1: Set ANSELA.1 On
	goto	SysSelectEnd2
SysSelect2Case2
	decf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case3
	banksel	ANSELA
	bsf	ANSELA,1
;Case 2: Set ANSELA.2 On
	goto	SysSelectEnd2
SysSelect2Case3
	movlw	2
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case4
	banksel	ANSELA
	bsf	ANSELA,2
;Case 3: Set ANSELA.4 On
	goto	SysSelectEnd2
SysSelect2Case4
	movlw	3
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case5
	banksel	ANSELA
	bsf	ANSELA,4
;Case 4: Set ANSELc.0 On
	goto	SysSelectEnd2
SysSelect2Case5
	movlw	4
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case6
	banksel	ANSELC
	bsf	ANSELC,0
;Case 5: Set ANSELc.1 On
	goto	SysSelectEnd2
SysSelect2Case6
	movlw	5
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case7
	banksel	ANSELC
	bsf	ANSELC,1
;Case 6: Set ANSELc.2 On
	goto	SysSelectEnd2
SysSelect2Case7
	movlw	6
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case8
	banksel	ANSELC
	bsf	ANSELC,2
;Case 7: Set ANSELc.3 On
	goto	SysSelectEnd2
SysSelect2Case8
	movlw	7
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case9
	banksel	ANSELC
	bsf	ANSELC,3
;Case 8: Set ANSELc.6 On
	goto	SysSelectEnd2
SysSelect2Case9
	movlw	8
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case10
	banksel	ANSELC
	bsf	ANSELC,6
;Case 9: Set ANSELc.7 On
	goto	SysSelectEnd2
SysSelect2Case10
	movlw	9
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case11
	banksel	ANSELC
	bsf	ANSELC,7
;Case 10: Set ANSELb.4 On
	goto	SysSelectEnd2
SysSelect2Case11
	movlw	10
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case12
	banksel	ANSELB
	bsf	ANSELB,4
;Case 11: Set ANSELb.5 On
	goto	SysSelectEnd2
SysSelect2Case12
	movlw	11
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelectEnd2
	banksel	ANSELB
	bsf	ANSELB,5
;End Select  'End Select #1
SysSelectEnd2
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
	goto	ENDIF83
	banksel	ADCON0
	bsf	ADCON0,CHS0
ENDIF83
;IF ADReadPort.1 On Then Set CHS1 On
	banksel	ADREADPORT
	btfss	ADREADPORT,1
	goto	ENDIF84
	banksel	ADCON0
	bsf	ADCON0,CHS1
ENDIF84
;IF ADReadPort.2 On Then Set CHS2 On
	banksel	ADREADPORT
	btfss	ADREADPORT,2
	goto	ENDIF85
	banksel	ADCON0
	bsf	ADCON0,CHS2
ENDIF85
;If ADReadPort.3 On Then Set CHS3 On
	banksel	ADREADPORT
	btfss	ADREADPORT,3
	goto	ENDIF86
	banksel	ADCON0
	bsf	ADCON0,CHS3
ENDIF86
;If ADReadPort.4 On Then Set CHS4 On
	banksel	ADREADPORT
	btfss	ADREADPORT,4
	goto	ENDIF87
	banksel	ADCON0
	bsf	ADCON0,CHS4
ENDIF87
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
	pagesel	Delay_10US
	call	Delay_10US
	pagesel	$
;Read A/D
;SET GO_NOT_DONE ON
	banksel	ADCON0
	bsf	ADCON0,GO_NOT_DONE
;nop
	nop
;Wait While GO_NOT_DONE ON
SysWaitLoop3
	btfsc	ADCON0,GO_NOT_DONE
	goto	SysWaitLoop3
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
;ReadAD = ADRESH
	banksel	ADRESH
	movf	ADRESH,W
	banksel	READAD
	movwf	READAD
;Support 8-bit differential reads
;SET ADFM OFF
	banksel	ADCON1
	bcf	ADCON1,ADFM
	banksel	STATUS
	return

;********************************************************************************

ROTATELEDS
;if ( g_labState <> RUNNING ) then
	decf	G_LABSTATE,W
	btfsc	STATUS, Z
	goto	ENDIF23
;LED_D4_LAT = ON
	banksel	LATB
	bsf	LATB,4
;LED_D5_LAT = OFF
	bcf	LATB,5
;LED_D6_LAT = OFF
	bcf	LATB,6
;LED_D7_LAT = OFF
	bcf	LATB,7
;Initialize temporary register to begin at 1
;g_rotateReg = 1
	movlw	1
	banksel	G_ROTATEREG
	movwf	G_ROTATEREG
;g_labState = RUNNING;
	movlw	1
	movwf	G_LABSTATE
;end if
ENDIF23
;if ( g_labState = RUNNING ) then
	decf	G_LABSTATE,W
	btfss	STATUS, Z
	goto	ENDIF24
;wait 500 ms
	movlw	244
	movwf	SysWaitTempMS
	movlw	1
	movwf	SysWaitTempMS_H
	call	Delay_MS
;rotate g_rotateReg left simple
	rlf	G_ROTATEREG,W
	rlf	G_ROTATEREG,F
;If the last LED has been lit, restart the pattern
;if ( g_rotateReg = LAST ) then
	movlw	16
	subwf	G_ROTATEREG,W
	btfss	STATUS, Z
	goto	ENDIF26
;g_rotateReg = 1
	movlw	1
	movwf	G_ROTATEREG
;end if
ENDIF26
;Determine which LED will light up
;ie. which bit in the register the 1 has rotated to.
;LED_D4_LAT = g_rotateReg.0
	banksel	LATB
	bcf	LATB,4
	banksel	G_ROTATEREG
	btfss	G_ROTATEREG,0
	goto	ENDIF27
	banksel	LATB
	bsf	LATB,4
ENDIF27
;LED_D5_LAT = g_rotateReg.1
	banksel	LATB
	bcf	LATB,5
	banksel	G_ROTATEREG
	btfss	G_ROTATEREG,1
	goto	ENDIF28
	banksel	LATB
	bsf	LATB,5
ENDIF28
;LED_D6_LAT = g_rotateReg.2
	banksel	LATB
	bcf	LATB,6
	banksel	G_ROTATEREG
	btfss	G_ROTATEREG,2
	goto	ENDIF29
	banksel	LATB
	bsf	LATB,6
ENDIF29
;LED_D7_LAT = g_rotateReg.3
	banksel	LATB
	bcf	LATB,7
	banksel	G_ROTATEREG
	btfss	G_ROTATEREG,3
	goto	ENDIF30
	banksel	LATB
	bsf	LATB,7
ENDIF30
;end if
ENDIF24
;Check if a switch event occurs
;if ( g_switchEvent = 1 ) then
	banksel	G_SWITCHEVENT
	decf	G_SWITCHEVENT,W
	btfsc	STATUS, Z
;g_labState = NOT_RUNNING
	clrf	G_LABSTATE
;end if
ENDIF25
	return

;********************************************************************************

SETTIMER
;If TMRNumber = 0 Then
	movf	TMRNUMBER,F
	btfss	STATUS, Z
	goto	ENDIF122
;Handle chips withOUT TMR0H
;TMR0 = TMRValue
	movf	TMRVALUE,W
	movwf	TMR0
;exit sub 'just get out faster
	return
;Handle chips with TMR0H
;End If
ENDIF122
;If TMRNumber = 1 then
	decf	TMRNUMBER,W
	btfss	STATUS, Z
	goto	ENDIF123
;TMR1H = TMRValue_H
	movf	TMRVALUE_H,W
	movwf	TMR1H
;TMR1L = TMRValue
	movf	TMRVALUE,W
	movwf	TMR1L
;End If
ENDIF123
;If TMRNumber = 2 Then
	movlw	2
	subwf	TMRNUMBER,W
	btfss	STATUS, Z
	goto	ENDIF124
;TMR2 = TMRValue
	movf	TMRVALUE,W
	movwf	TMR2
;End If
ENDIF124
;If TMRNumber = 4 Then
	movlw	4
	subwf	TMRNUMBER,W
	btfss	STATUS, Z
	goto	ENDIF125
;TMR4 = TMRValue
	movf	TMRVALUE,W
	banksel	TMR4
	movwf	TMR4
;End If
ENDIF125
;If TMRNumber = 6 Then
	movlw	6
	banksel	TMRNUMBER
	subwf	TMRNUMBER,W
	btfss	STATUS, Z
	goto	ENDIF126
;TMR6 = TMRValue
	movf	TMRVALUE,W
	banksel	TMR6
	movwf	TMR6
;End If
ENDIF126
	banksel	STATUS
	return

;********************************************************************************

SLEEPWAKEUP2LEDS
;if ( g_labState <> RUNNING )  then
	decf	G_LABSTATE,W
	btfsc	STATUS, Z
	goto	ENDIF64
;LED_D4_LAT = ON
	banksel	LATB
	bsf	LATB,4
;LED_D6_LAT = ON
	bsf	LATB,6
;LED_D5_LAT = OFF
	bcf	LATB,5
;LED_D7_LAT = OFF
	bcf	LATB,7
;Enable Watchdog Timer
;Initially WDTPS 1:131072 & SWDTEN OFF by setting the register byte value
;WDTCON = 0x18
	movlw	24
	banksel	WDTCON
	movwf	WDTCON
;Enable SWDTEN by setting the bit value
;WDTCON.SWDTEN = 1
	bsf	WDTCON,SWDTEN
;Sleep
	sleep
;g_labState = RUNNING
	movlw	1
	banksel	G_LABSTATE
	movwf	G_LABSTATE
;end if
ENDIF64
;if ( g_labState = RUNNING ) then
	decf	G_LABSTATE,W
	btfss	STATUS, Z
	goto	ENDIF65
;Wait 4 seconds for the WDT time out
;and reverse the states of the LEDs
;LED_D4_LAT = !LED_D4_LAT
	clrf	SysTemp1
	btfsc	PORTB,4
	incf	SysTemp1,F
ENDIF68
	comf	SysTemp1,F
	banksel	LATB
	bcf	LATB,4
	banksel	SYSTEMP1
	btfss	SysTemp1,0
	goto	ENDIF69
	banksel	LATB
	bsf	LATB,4
ENDIF69
;LED_D6_LAT = !LED_D6_LAT
	banksel	SYSTEMP1
	clrf	SysTemp1
	btfsc	PORTB,6
	incf	SysTemp1,F
ENDIF70
	comf	SysTemp1,F
	banksel	LATB
	bcf	LATB,6
	banksel	SYSTEMP1
	btfss	SysTemp1,0
	goto	ENDIF71
	banksel	LATB
	bsf	LATB,6
ENDIF71
;LED_D5_LAT = !LED_D5_LAT
	banksel	SYSTEMP1
	clrf	SysTemp1
	btfsc	PORTB,5
	incf	SysTemp1,F
ENDIF72
	comf	SysTemp1,F
	banksel	LATB
	bcf	LATB,5
	banksel	SYSTEMP1
	btfss	SysTemp1,0
	goto	ENDIF73
	banksel	LATB
	bsf	LATB,5
ENDIF73
;LED_D7_LAT = !LED_D7_LAT
	banksel	SYSTEMP1
	clrf	SysTemp1
	btfsc	PORTB,7
	incf	SysTemp1,F
ENDIF74
	comf	SysTemp1,F
	banksel	LATB
	bcf	LATB,7
	banksel	SYSTEMP1
	btfss	SysTemp1,0
	goto	ENDIF75
	banksel	LATB
	bsf	LATB,7
ENDIF75
;Sleep
	sleep
;end if
ENDIF65
;Check if a switch event occurs
;if ( g_switchEvent = 1 ) then
	banksel	G_SWITCHEVENT
	decf	G_SWITCHEVENT,W
	btfss	STATUS, Z
	goto	ENDIF66
;Disable Watchdog Timer
;if ( WDTCON.SWDTEN = 1 ) then
	banksel	WDTCON
	btfsc	WDTCON,SWDTEN
;WDTCON.SWDTEN = 0
	bcf	WDTCON,SWDTEN
;end if
ENDIF67
;g_labState = NOT_RUNNING
	banksel	G_LABSTATE
	clrf	G_LABSTATE
;end if
ENDIF66
	return

;********************************************************************************

FN_STR
;SysCharCount = 0
	clrf	SYSCHARCOUNT
;Dim SysCalcTempX As Word
;Ten Thousands
;IF SysValTemp >= 10000 then
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB
	movlw	39
	movwf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF145
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
	clrf	SysTemp1
	movlw	high(STR)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF0
;Goto SysValThousands
	goto	SYSVALTHOUSANDS
;End If
ENDIF145
;Thousands
;IF SysValTemp >= 1000 then
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB
	movlw	3
	movwf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF146
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
	clrf	SysTemp1
	movlw	high(STR)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF0
;Goto SysValHundreds
	goto	SYSVALHUNDREDS
;End If
ENDIF146
;Hundreds
;IF SysValTemp >= 100 then
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF147
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
	clrf	SysTemp1
	movlw	high(STR)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF0
;Goto SysValTens
	goto	SYSVALTENS
;End If
ENDIF147
;Tens
;IF SysValTemp >= 10 Then
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF148
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
	clrf	SysTemp1
	movlw	high(STR)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF0
;End If
ENDIF148
;Ones
;SysCharCount += 1
	incf	SYSCHARCOUNT,F
;Str(SysCharCount) = SysValTemp + 48
	movlw	low(STR)
	addwf	SYSCHARCOUNT,W
	movwf	AFSR0
	clrf	SysTemp1
	movlw	high(STR)
	addwfc	SysTemp1,W
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
;Avoid division by zero
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
	goto	ENDIF156
;SysWordTempA = 0
	clrf	SYSWORDTEMPA
	clrf	SYSWORDTEMPA_H
;exit sub
	return
;end if
ENDIF156
;Main calc routine
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
	goto	ENDIF157
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	addwfc	SYSDIVMULTX_H,F
;End If
ENDIF157
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

SYSDIVSUB32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysLongTempX as long
;#ifdef PIC
;dim SysLongDivMultA as long
;dim SysLongDivMultB as long
;dim SysLongDivMultX as long
;#endif
;SysLongDivMultA = SysLongTempA
	movf	SYSLONGTEMPA,W
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
;Avoid division by zero
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
	pagesel	SysCompEqual32
	call	SysCompEqual32
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF143
;SysLongTempA = 0
	clrf	SYSLONGTEMPA
	clrf	SYSLONGTEMPA_H
	clrf	SYSLONGTEMPA_U
	clrf	SYSLONGTEMPA_E
;exit sub
	return
;end if
ENDIF143
;Main calc routine
;SysDivLoop = 32
	movlw	32
	movwf	SYSDIVLOOP
SYSDIV32START
;set C off
	bcf	STATUS,C
;Rotate SysLongDivMultA Left
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
	goto	ENDIF144
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
ENDIF144
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
	return

;********************************************************************************

SYSMULTSUB32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysLongTempX as long
;Can't use normal SysDivMult variables for 32 bit, they overlap with
;SysLongTemp variables
;dim SysLongDivMultA as long
;dim SysLongDivMultB as long
;dim SysLongDivMultX as long
;SysLongDivMultA = SysLongTempA
	movf	SYSLONGTEMPA,W
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
MUL32LOOP
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
	btfss	SYSLONGDIVMULTB,0
	goto	ENDIF141
	movf	SYSLONGDIVMULTA,W
	addwf	SYSLONGDIVMULTX,F
	movf	SYSLONGDIVMULTA_H,W
	addwfc	SYSLONGDIVMULTX_H,F
	movf	SYSLONGDIVMULTA_U,W
	addwfc	SYSLONGDIVMULTX_U,F
	movf	SYSLONGDIVMULTA_E,W
	addwfc	SYSLONGDIVMULTX_E,F
ENDIF141
;set STATUS.C OFF
	bcf	STATUS,C
;rotate SysLongDivMultB right
	rrf	SYSLONGDIVMULTB_E,F
	rrf	SYSLONGDIVMULTB_U,F
	rrf	SYSLONGDIVMULTB_H,F
	rrf	SYSLONGDIVMULTB,F
;set STATUS.C off
	bcf	STATUS,C
;rotate SysLongDivMultA left
	rlf	SYSLONGDIVMULTA,F
	rlf	SYSLONGDIVMULTA_H,F
	rlf	SYSLONGDIVMULTA_U,F
	rlf	SYSLONGDIVMULTA_E,F
;if SysLongDivMultB > 0 then goto MUL32LOOP
	movf	SYSLONGDIVMULTB,W
	movwf	SysLONGTempB
	movf	SYSLONGDIVMULTB_H,W
	movwf	SysLONGTempB_H
	movf	SYSLONGDIVMULTB_U,W
	movwf	SysLONGTempB_U
	movf	SYSLONGDIVMULTB_E,W
	movwf	SysLONGTempB_E
	clrf	SysLONGTempA
	clrf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	btfsc	SysByteTempX,0
	goto	MUL32LOOP
ENDIF142
;SysLongTempX = SysLongDivMultX
	movf	SYSLONGDIVMULTX,W
	movwf	SYSLONGTEMPX
	movf	SYSLONGDIVMULTX_H,W
	movwf	SYSLONGTEMPX_H
	movf	SYSLONGDIVMULTX_U,W
	movwf	SYSLONGTEMPX_U
	movf	SYSLONGDIVMULTX_E,W
	movwf	SYSLONGTEMPX_E
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
	retlw	22
	retlw	67	;C
	retlw	117	;u
	retlw	114	;r
	retlw	105	;i
	retlw	111	;o
	retlw	115	;s
	retlw	105	;i
	retlw	116	;t
	retlw	121	;y
	retlw	32	; 
	retlw	66	;B
	retlw	111	;o
	retlw	97	;a
	retlw	114	;r
	retlw	100	;d
	retlw	32	; 
	retlw	76	;L
	retlw	97	;a
	retlw	98	;b
	retlw	115	;s
	retlw	58	;:
	retlw	32	; 


StringTable2
	retlw	8
	retlw	82	;R
	retlw	101	;e
	retlw	97	;a
	retlw	100	;d
	retlw	121	;y
	retlw	32	; 
	retlw	46	;.
	retlw	46	;.


StringTable3
	retlw	12
	retlw	76	;L
	retlw	97	;a
	retlw	98	;b
	retlw	32	; 
	retlw	78	;N
	retlw	117	;u
	retlw	109	;m
	retlw	98	;b
	retlw	101	;e
	retlw	114	;r
	retlw	58	;:
	retlw	32	; 


StringTable53
	retlw	7
	retlw	49	;1
	retlw	54	;6
	retlw	70	;F
	retlw	49	;1
	retlw	56	;8
	retlw	50	;2
	retlw	57	;9


;********************************************************************************

TIMERLEDS
;if ( g_labState <> RUNNING ) then
	decf	G_LABSTATE,W
	btfsc	STATUS, Z
	goto	ENDIF49
;LED_D4_LAT = ON
	banksel	LATB
	bsf	LATB,4
;LED_D5_LAT = ON
	bsf	LATB,5
;LED_D6_LAT = ON
	bsf	LATB,6
;LED_D7_LAT = ON
	bsf	LATB,7
;Initialize the timer, set the initial value and start the timer.
;InitTimer1 Osc, PS_1
	movlw	1
	banksel	TMRSOURCE
	movwf	TMRSOURCE
	movlw	1
	movwf	TMRPRES
	call	INITTIMER1
;SetTimer 1, Timer1ReloadValue
	movlw	1
	movwf	TMRNUMBER
	movlw	220
	movwf	TMRVALUE
	movlw	11
	movwf	TMRVALUE_H
	call	SETTIMER
;StartTimer 1
	movlw	1
	movwf	TMRNUMBER
	pagesel	STARTTIMER
	call	STARTTIMER
	pagesel	$
;LED_D4_LAT = ON
	banksel	LATB
	bsf	LATB,4
;LED_D5_LAT = OFF
	bcf	LATB,5
;LED_D6_LAT = OFF
	bcf	LATB,6
;LED_D7_LAT = OFF
	bcf	LATB,7
;Initialize temporary register to begin at 1
;g_rotateReg = 1
	movlw	1
	banksel	G_ROTATEREG
	movwf	G_ROTATEREG
;g_labState = RUNNING
	movlw	1
	movwf	G_LABSTATE
;end if
ENDIF49
;if ( g_labState = RUNNING ) then
	decf	G_LABSTATE,W
	btfss	STATUS, Z
	goto	ENDIF50
;Wait for Timer1 to overflow. When timer1 overflows TMR1IF will be set to 1
;wait while ( TMR1IF <> 1 )
SysWaitLoop2
	btfss	PIR1,TMR1IF
	goto	SysWaitLoop2
;SetTimer 1, Timer1ReloadValue
	movlw	1
	movwf	TMRNUMBER
	movlw	220
	movwf	TMRVALUE
	movlw	11
	movwf	TMRVALUE_H
	call	SETTIMER
;rotate g_rotateReg left simple
	rlf	G_ROTATEREG,W
	rlf	G_ROTATEREG,F
;If the last LED has been lit, restart the pattern
;if ( g_rotateReg = LAST ) then
	movlw	16
	subwf	G_ROTATEREG,W
	btfss	STATUS, Z
	goto	ENDIF52
;g_rotateReg = 1
	movlw	1
	movwf	G_ROTATEREG
;end if
ENDIF52
;Determine which LEDs will light up
;LED_D4_LAT = g_rotateReg.0
	banksel	LATB
	bcf	LATB,4
	banksel	G_ROTATEREG
	btfss	G_ROTATEREG,0
	goto	ENDIF53
	banksel	LATB
	bsf	LATB,4
ENDIF53
;LED_D5_LAT = g_rotateReg.1
	banksel	LATB
	bcf	LATB,5
	banksel	G_ROTATEREG
	btfss	G_ROTATEREG,1
	goto	ENDIF54
	banksel	LATB
	bsf	LATB,5
ENDIF54
;LED_D6_LAT = g_rotateReg.2
	banksel	LATB
	bcf	LATB,6
	banksel	G_ROTATEREG
	btfss	G_ROTATEREG,2
	goto	ENDIF55
	banksel	LATB
	bsf	LATB,6
ENDIF55
;LED_D7_LAT = g_rotateReg.3
	banksel	LATB
	bcf	LATB,7
	banksel	G_ROTATEREG
	btfss	G_ROTATEREG,3
	goto	ENDIF56
	banksel	LATB
	bsf	LATB,7
ENDIF56
;Clear the timer
;TMR1IF = 0
	banksel	PIR1
	bcf	PIR1,TMR1IF
;end if
ENDIF50
;Check if a switch event occurs
;if ( g_switchEvent = 1 ) then
	decf	G_SWITCHEVENT,W
	btfss	STATUS, Z
	goto	ENDIF51
;StopTimer 1
	movlw	1
	movwf	TMRNUMBER
	pagesel	STOPTIMER
	call	STOPTIMER
	pagesel	$
;g_labState = NOT_RUNNING
	clrf	G_LABSTATE
;end if
ENDIF51
	return

;********************************************************************************

VSRLEDS
;dim l_delay as byte
;if ( g_labState <> RUNNING ) then
	decf	G_LABSTATE,W
	btfsc	STATUS, Z
	goto	ENDIF38
;LED_D4_LAT = OFF
	banksel	LATB
	bcf	LATB,4
;LED_D5_LAT = OFF
	bcf	LATB,5
;LED_D6_LAT = OFF
	bcf	LATB,6
;LED_D7_LAT = OFF
	bcf	LATB,7
;Initialize temporary register to begin at 1
;g_rotateReg = 1
	movlw	1
	banksel	G_ROTATEREG
	movwf	G_ROTATEREG
;g_labState = RUNNING
	movlw	1
	movwf	G_LABSTATE
;end if
ENDIF38
;if ( g_labState = RUNNING ) then
	decf	G_LABSTATE,W
	btfss	STATUS, Z
	goto	ENDIF39
;l_delay = ReadAD( ADCPORT ) / 4
	movlw	2
	movwf	ADREADPORT
	call	FN_READAD26
	movf	SYSREADADBYTE,W
	movwf	SysBYTETempA
	movlw	4
	movwf	SysBYTETempB
	pagesel	SysDivSub
	call	SysDivSub
	pagesel	$
	movf	SysBYTETempA,W
	movwf	L_DELAY
;wait 5 ms
	movlw	5
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;Delay 2 ms until l_delay decrements to 0
;do while ( l_delay <> 0)
SysDoLoop_S2
	movf	L_DELAY,F
	btfsc	STATUS, Z
	goto	SysDoLoop_E2
;wait 2 ms
	movlw	2
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;l_delay--
	decf	L_DELAY,F
;loop
	goto	SysDoLoop_S2
SysDoLoop_E2
;Determine which LED will light up
;ie. which bit in the register the 1 has rotated to.
;LED_D4_LAT = g_rotateReg.0
	banksel	LATB
	bcf	LATB,4
	banksel	G_ROTATEREG
	btfss	G_ROTATEREG,0
	goto	ENDIF42
	banksel	LATB
	bsf	LATB,4
ENDIF42
;LED_D5_LAT = g_rotateReg.1
	banksel	LATB
	bcf	LATB,5
	banksel	G_ROTATEREG
	btfss	G_ROTATEREG,1
	goto	ENDIF43
	banksel	LATB
	bsf	LATB,5
ENDIF43
;LED_D6_LAT = g_rotateReg.2
	banksel	LATB
	bcf	LATB,6
	banksel	G_ROTATEREG
	btfss	G_ROTATEREG,2
	goto	ENDIF44
	banksel	LATB
	bsf	LATB,6
ENDIF44
;LED_D7_LAT = g_rotateReg.3
	banksel	LATB
	bcf	LATB,7
	banksel	G_ROTATEREG
	btfss	G_ROTATEREG,3
	goto	ENDIF45
	banksel	LATB
	bsf	LATB,7
ENDIF45
;rotate g_rotateReg left simple
	banksel	G_ROTATEREG
	rlf	G_ROTATEREG,W
	rlf	G_ROTATEREG,F
;If the last LED has been lit, restart the pattern
;if ( g_rotateReg = LAST ) then
	movlw	16
	subwf	G_ROTATEREG,W
	btfss	STATUS, Z
	goto	ENDIF41
;g_rotateReg = 1
	movlw	1
	movwf	G_ROTATEREG
;end if
ENDIF41
;end if
ENDIF39
;Check if a switch event occurs
;if ( g_switchEvent = 1 ) then
	decf	G_SWITCHEVENT,W
	btfsc	STATUS, Z
;g_labState = NOT_RUNNING
	clrf	G_LABSTATE
;end if
ENDIF40
	return

;********************************************************************************

;Start of program memory page 1
	ORG	2048
BLINKLED
;dim l_counter as byte
;if ( g_labState <> RUNNING ) then
	decf	G_LABSTATE,W
	btfsc	STATUS, Z
	goto	ENDIF18
;LED_D4_LAT = OFF
	banksel	LATB
	bcf	LATB,4
;LED_D5_LAT = OFF
	bcf	LATB,5
;LED_D6_LAT = OFF
	bcf	LATB,6
;LED_D7_LAT = OFF
	bcf	LATB,7
;g_labState = RUNNING
	movlw	1
	banksel	G_LABSTATE
	movwf	G_LABSTATE
;end if
ENDIF18
;if ( g_labState = RUNNING ) then
	decf	G_LABSTATE,W
	btfss	STATUS, Z
	goto	ENDIF19
;Wait for 1.5 sec delay
;wait 1500 ms
	movlw	220
	movwf	SysWaitTempMS
	movlw	5
	movwf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;LED_D4_Toggle
	clrf	SysTemp1
	btfsc	PORTB,4
	incf	SysTemp1,F
ENDIF21
	comf	SysTemp1,F
	banksel	LATB
	bcf	LATB,4
	banksel	SYSTEMP1
	btfss	SysTemp1,0
	goto	ENDIF22
	banksel	LATB
	bsf	LATB,4
ENDIF22
;end if
ENDIF19
;Check if a switch event occurs
;if ( g_switchEvent = 1 ) then
	banksel	G_SWITCHEVENT
	decf	G_SWITCHEVENT,W
	btfsc	STATUS, Z
;g_labState = NOT_RUNNING
	clrf	G_LABSTATE
;end if
ENDIF20
	return

;********************************************************************************

CHECKBUTTONS1
;Check if S1 is previously down (pressed).
;if ( g_btnState = NOT_PRESSED ) then
	movf	G_BTNSTATE,F
	btfss	STATUS, Z
	goto	ELSE3_1
;Check if S1 is LOW (pressed)
;if ( S1_PORT = OFF ) then
	btfsc	PORTC,0
	goto	ENDIF4
;g_btnState = PRESSED
	movlw	1
	movwf	G_BTNSTATE
;Show the LED is depressed
;LED_D4_LAT = On
	banksel	LATB
	bsf	LATB,4
;LED_D5_LAT = On
	bsf	LATB,5
;LED_D6_LAT = On
	bsf	LATB,6
;LED_D7_LAT = On
	bsf	LATB,7
;wait while S1_PORT = OFF
SysWaitLoop1
	banksel	PORTC
	btfss	PORTC,0
	goto	SysWaitLoop1
;LED_D4_LAT = OFF
	banksel	LATB
	bcf	LATB,4
;LED_D5_LAT = OFF
	bcf	LATB,5
;LED_D6_LAT = OFF
	bcf	LATB,6
;LED_D7_LAT = OFF
	bcf	LATB,7
;end if
ENDIF4
;else
	goto	ENDIF3
ELSE3_1
;Check if S1 is high (not pressed)
;if ( S1_PORT = ON ) then
	btfss	PORTC,0
	goto	ENDIF5
;Change the button's state to NOT_PRESSED
;g_btnState = NOT_PRESSED
	clrf	G_BTNSTATE
;Indicate a switch event
;g_switchEvent = 1
	movlw	1
	movwf	G_SWITCHEVENT
;end if
ENDIF5
;end if
ENDIF3
	banksel	STATUS
	return

;********************************************************************************

Delay_10US
D10US_START
	decfsz	SysWaitTemp10US, F
	goto	D10US_START
	return

;********************************************************************************

Delay_S
DS_START
	movlw	232
	movwf	SysWaitTempMS
	movlw	3
	movwf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
	decfsz	SysWaitTempS, F
	goto	DS_START
	return

;********************************************************************************

EPWRITE
;Variable alias
;Dim EEAddress As Word Alias EEADRH, EEADR
;Dim EEDataValue Alias EEDATL_REF
;Disable interrupt
;IntOff
	bcf	SYSINTSTATESAVE0,0
	btfsc	INTCON,GIE
	bsf	SYSINTSTATESAVE0,0
ENDIF158
	bcf	INTCON,GIE
;Select data memory
;SET EEPGD OFF
	banksel	EECON1
	bcf	EECON1,EEPGD
;Set CFGS OFF
	bcf	EECON1,CFGS
;Start write
;SET WREN ON
	bsf	EECON1,WREN
;EECON2 = 0x55
	movlw	85
	movwf	EECON2
;EECON2 = 0xAA
	movlw	170
	movwf	EECON2
;SET WR ON
	bsf	EECON1,WR
;SET WREN OFF
	bcf	EECON1,WREN
;Wait for write to complete
;WAIT WHILE WR ON
SysWaitLoop4
	btfsc	EECON1,WR
	goto	SysWaitLoop4
;SET WREN OFF
	bcf	EECON1,WREN
;Restore interrupt
;IntOn
	banksel	SYSINTSTATESAVE0
	btfss	SYSINTSTATESAVE0,0
	bcf	INTCON,GIE
ENDIF159
	btfsc	SYSINTSTATESAVE0,0
	bsf	INTCON,GIE
ENDIF160
	return

;********************************************************************************

HELLOWORLD
;if ( g_labState <> RUNNING )  then
	decf	G_LABSTATE,W
	btfsc	STATUS, Z
	goto	ENDIF7
;LED_D4_LAT = OFF
	banksel	LATB
	bcf	LATB,4
;LED_D5_LAT = OFF
	bcf	LATB,5
;LED_D6_LAT = OFF
	bcf	LATB,6
;LED_D7_LAT = OFF
	bcf	LATB,7
;g_labState = RUNNING
	movlw	1
	banksel	G_LABSTATE
	movwf	G_LABSTATE
;end if
ENDIF7
;if ( g_labState = RUNNING ) then
	decf	G_LABSTATE,W
	btfss	STATUS, Z
	goto	ENDIF8
;LED_D4_SetHigh  'use a macro to set the Port High
	banksel	LATB
	bsf	LATB,4
;end if
ENDIF8
;Check if a switch event occurs
;if ( g_switchEvent = 1 ) then
	banksel	G_SWITCHEVENT
	decf	G_SWITCHEVENT,W
	btfsc	STATUS, Z
;g_labState = NOT_RUNNING
	clrf	G_LABSTATE
;end if
ENDIF9
	return

;********************************************************************************

;Overloaded signature: STRING:byte:
HSERPRINT277
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
	goto	ENDIF153
;Write Data
;for SysPrintTemp = 1 to PrintLen
	clrf	SYSPRINTTEMP
	movlw	1
	subwf	PRINTLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd2
ENDIF154
SysForLoop2
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
;next
	movf	PRINTLEN,W
	subwf	SYSPRINTTEMP,W
	btfss	STATUS, C
	goto	SysForLoop2
ENDIF155
SysForLoopEnd2
;End If
ENDIF153
;CR
	return

;********************************************************************************

HSERPRINTCRLF
;repeat HSerPrintCRLFCount
	movf	HSERPRINTCRLFCOUNT,W
	movwf	SysRepeatTemp2
	btfsc	STATUS,Z
	goto	SysRepeatLoopEnd2
SysRepeatLoop2
;HSerSend(13,comport)
	movlw	13
	movwf	SERDATA
	call	HSERSEND
;HSerSend(10,comport)
	movlw	10
	movwf	SERDATA
	call	HSERSEND
;end Repeat
	decfsz	SysRepeatTemp2,F
	goto	SysRepeatLoop2
SysRepeatLoopEnd2
	return

;********************************************************************************

HSERPRINTSTRINGCRLF
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
	goto	ENDIF150
;Write Data
;for SysPrintTemp = 1 to PrintLen
	clrf	SYSPRINTTEMP
	movlw	1
	subwf	PRINTLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd1
ENDIF151
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
;next
	movf	PRINTLEN,W
	subwf	SYSPRINTTEMP,W
	btfss	STATUS, C
	goto	SysForLoop1
ENDIF152
SysForLoopEnd1
;End If
ENDIF150
;HSerSend(13,comport)
	movlw	13
	movwf	SERDATA
	call	HSERSEND
;HSerSend(10,comport)
	movlw	10
	movwf	SERDATA
	goto	HSERSEND

;********************************************************************************

HSERSEND
;Block before sending (if needed)
;Send byte
;Registers/Bits determined by #samevar at top of file
;if comport = 1 Then
	decf	COMPORT,W
	btfss	STATUS, Z
	goto	ENDIF149
;HSerSendBlocker
;Wait While TXIF = Off
SysWaitLoop5
	btfss	PIR1,TXIF
	goto	SysWaitLoop5
;asm showdebug TXREG equals SerData below will assign SerData to TXREG or TXREG1 or U1TXB  via the #samevar
;txreg equals serdata below will assign serdata to txreg | txreg | txreg via the #samevar
;
;TXREG = SerData
	movf	SERDATA,W
	banksel	TXREG
	movwf	TXREG
;Add USART_DELAY After all bits are shifted out
;Wait until TRMT = 1
SysWaitLoop6
	btfss	TXSTA,TRMT
	goto	SysWaitLoop6
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	banksel	STATUS
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;exit sub
	return
;end if
ENDIF149
	return

;********************************************************************************

;Overloaded signature: BYTE:BYTE:
INITTIMER0174
;Some PICS (18F+) Use T0CON for timer0 Control
;ALL OTHER PICS USE OPTION_REG for timer0 control
;Sub modified to set all TMR Control bits at once
;* TMRPres, TMRSource & TMRPost now shared *
;if TMRPRes > 7 then TMRPRes = 0 'failsafe
	movf	TMRPRES,W
	sublw	7
	btfss	STATUS, C
	clrf	TMRPRES
ENDIF131
;If Timer0 is 16-bit capable
;Re-Use TMRPres as T0CON Temp_register
;Keep T0CON 7:6 and write bits 2:0 from TMRPres
;Bits 5,4 & 3 will be cleared!
;TMRPres = (OPTION_REG AND 192) OR TMRPres
	movlw	192
	banksel	OPTION_REG
	andwf	OPTION_REG,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	iorwf	TMRPRES,F
;IF TMRSource = EXT then
	movlw	2
	subwf	TMRSOURCE,W
	btfss	STATUS, Z
	goto	ELSE132_1
;Set TMRPres.5 ON   'EXT
	bsf	TMRPRES,5
;ELSE
	goto	ENDIF132
ELSE132_1
;Set TMRPres.5 OFF  'OSC
	bcf	TMRPRES,5
;END IF
ENDIF132
;Now Write the OPTION_REG
;OPTION_REG = TMRPres
	movf	TMRPRES,W
	banksel	OPTION_REG
	movwf	OPTION_REG
;Added For baseline Chips with write only option_reg
;If Timer0 is 16-bit capable
	banksel	STATUS
	return

;********************************************************************************

INTERRUPT2LEDS
;if ( g_labState <> RUNNING ) then
	decf	G_LABSTATE,W
	btfsc	STATUS, Z
	goto	ENDIF57
;LED_D4_LAT = ON
	banksel	LATB
	bsf	LATB,4
;LED_D5_LAT = OFF
	bcf	LATB,5
;LED_D6_LAT = OFF
	bcf	LATB,6
;LED_D7_LAT = OFF
	bcf	LATB,7
;g_rotateReg = 1
	movlw	1
	banksel	G_ROTATEREG
	movwf	G_ROTATEREG
;Enable the TMR0 Interrupts
;InitTimer0 Osc, PS0_256
	movlw	1
	movwf	TMRSOURCE
	movlw	7
	movwf	TMRPRES
	call	INITTIMER0174
;On Interrupt Timer0Overflow call LAB_ISR
	bsf	INTCON,TMR0IE
;g_labState = RUNNING
	movlw	1
	movwf	G_LABSTATE
;end if
ENDIF57
;there is not middle handler?  why? The middle handler is the Interrupt routine LAB_ISR()
;Check if a switch event occurs
;if ( g_switchEvent = 1 ) then
	decf	G_SWITCHEVENT,W
	btfss	STATUS, Z
	goto	ENDIF58
;Disable the TMR0 Interrupts
;On Interrupt Timer0Overflow ignore
	bcf	INTCON,TMR0IE
;g_labState = NOT_RUNNING
	clrf	G_LABSTATE
;end if
ENDIF58
	return

;********************************************************************************

NEXTLAB
;g_switchEvent = 0
	clrf	G_SWITCHEVENT
;g_labNumber++
	incf	G_LABNUMBER,F
;if ( g_labNumber = 11 ) then
	movlw	11
	subwf	G_LABNUMBER,W
	btfss	STATUS, Z
	goto	ENDIF6
;g_labNumber = 1
	movlw	1
	movwf	G_LABNUMBER
;end if
ENDIF6
	return

;********************************************************************************

;Overloaded signature: 
PWMOFF42
;CCP1CON = 0
	banksel	CCP1CON
	clrf	CCP1CON
	banksel	STATUS
	return

;********************************************************************************

STARTTIMER
;IF TMRNumber = 1 then Set TMR1ON on
	decf	TMRNUMBER,W
	btfsc	STATUS, Z
	bsf	T1CON,TMR1ON
ENDIF118
;IF TMRNumber = 2 then Set TMR2ON on
	movlw	2
	subwf	TMRNUMBER,W
	btfsc	STATUS, Z
	bsf	T2CON,TMR2ON
ENDIF119
;IF TMRNumber = 4 then Set TMR4ON on
	movlw	4
	subwf	TMRNUMBER,W
	btfss	STATUS, Z
	goto	ENDIF120
	banksel	T4CON
	bsf	T4CON,TMR4ON
ENDIF120
;IF TMRNumber = 6 then Set TMR6ON on
	movlw	6
	banksel	TMRNUMBER
	subwf	TMRNUMBER,W
	btfss	STATUS, Z
	goto	ENDIF121
	banksel	T6CON
	bsf	T6CON,TMR6ON
ENDIF121
	banksel	STATUS
	return

;********************************************************************************

STOPTIMER
;Timer 0 always runs
;Note: Not Always!  Timer 0 on 18F Can be stopped/started
;If TMRNumber = 1 Then Set TMR1ON OFF
	decf	TMRNUMBER,W
	btfsc	STATUS, Z
	bcf	T1CON,TMR1ON
ENDIF127
;If TMRNumber = 2 Then Set TMR2ON OFF
	movlw	2
	subwf	TMRNUMBER,W
	btfsc	STATUS, Z
	bcf	T2CON,TMR2ON
ENDIF128
;If TMRNumber = 4 Then Set TMR4ON OFF
	movlw	4
	subwf	TMRNUMBER,W
	btfss	STATUS, Z
	goto	ENDIF129
	banksel	T4CON
	bcf	T4CON,TMR4ON
ENDIF129
;If TMRNumber = 6 Then Set TMR6ON OFF
	movlw	6
	banksel	TMRNUMBER
	subwf	TMRNUMBER,W
	btfss	STATUS, Z
	goto	ENDIF130
	banksel	T6CON
	bcf	T6CON,TMR6ON
ENDIF130
	banksel	STATUS
	return

;********************************************************************************

SYSCOMPEQUAL16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;Test low, exit if false
;movf SysWordTempA, W
	movf	SYSWORDTEMPA, W
;subwf SysWordTempB, W
	subwf	SYSWORDTEMPB, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;Test high, exit if false
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
;Test low, exit if false
;movf SysLongTempA, W
	movf	SYSLONGTEMPA, W
;subwf SysLongTempB, W
	subwf	SYSLONGTEMPB, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;Test high, exit if false
;movf SysLongTempA_H, W
	movf	SYSLONGTEMPA_H, W
;subwf SysLongTempB_H, W
	subwf	SYSLONGTEMPB_H, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;Test upper, exit if false
;movf SysLongTempA_U, W
	movf	SYSLONGTEMPA_U, W
;subwf SysLongTempB_U, W
	subwf	SYSLONGTEMPB_U, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;Test exp, exit if false
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

SYSCOMPLESSTHAN16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;Test High, exit if more
;movf SysWordTempA_H,W
	movf	SYSWORDTEMPA_H,W
;subwf SysWordTempB_H,W
	subwf	SYSWORDTEMPB_H,W
;btfss STATUS,C
	btfss	STATUS,C
;return
	return
;Test high, exit true if less
;movf SysWordTempB_H,W
	movf	SYSWORDTEMPB_H,W
;subwf SysWordTempA_H,W
	subwf	SYSWORDTEMPA_H,W
;btfss STATUS,C
	btfss	STATUS,C
;goto SCLT16True
	goto	SCLT16TRUE
;Test Low, exit if more or equal
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

SYSCOMPLESSTHAN32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;Test Exp, exit if more
;movf SysLongTempA_E,W
	movf	SYSLONGTEMPA_E,W
;subwf SysLongTempB_E,W
	subwf	SYSLONGTEMPB_E,W
;btfss STATUS,C
	btfss	STATUS,C
;return
	return
;If not more and not zero, is less
;btfss STATUS,Z
	btfss	STATUS,Z
;goto SCLT32True
	goto	SCLT32TRUE
;Test Upper, exit if more
;movf SysLongTempA_U,W
	movf	SYSLONGTEMPA_U,W
;subwf SysLongTempB_U,W
	subwf	SYSLONGTEMPB_U,W
;btfss STATUS,C
	btfss	STATUS,C
;return
	return
;If not more and not zero, is less
;btfss STATUS,Z
	btfss	STATUS,Z
;goto SCLT32True
	goto	SCLT32TRUE
;Test High, exit if more
;movf SysLongTempA_H,W
	movf	SYSLONGTEMPA_H,W
;subwf SysLongTempB_H,W
	subwf	SYSLONGTEMPB_H,W
;btfss STATUS,C
	btfss	STATUS,C
;return
	return
;If not more and not zero, is less
;btfss STATUS,Z
	btfss	STATUS,Z
;goto SCLT32True
	goto	SCLT32TRUE
;Test Low, exit if more or equal
;movf SysLongTempB,W
	movf	SYSLONGTEMPB,W
;subwf SysLongTempA,W
	subwf	SYSLONGTEMPA,W
;btfsc STATUS,C
	btfsc	STATUS,C
;return
	return
SCLT32TRUE
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

SYSCOPYSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Get and copy length
;movf INDF0, W
	movf	INDF0, W
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA
;movwf INDF1
	movwf	INDF1
;goto SysCopyStringCheck
	goto	SYSCOPYSTRINGCHECK
;When appending, add length to counter
SYSCOPYSTRINGPART
;movf INDF0, W
	movf	INDF0, W
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA
;addwf SysStringLength, F
	addwf	SYSSTRINGLENGTH, F
SYSCOPYSTRINGCHECK
;Exit if length = 0
;movf SysCalcTempA,F
	movf	SYSCALCTEMPA,F
;btfsc STATUS,Z
	btfsc	STATUS,Z
;return
	return
SYSSTRINGCOPY
;Increment pointers
;addfsr 0, 1
	addfsr	0, 1
;addfsr 1, 1
	addfsr	1, 1
;Copy character
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
;Get length
;call SysStringTables
	pagesel	SYSSTRINGTABLES
	call	SYSSTRINGTABLES
	pagesel	$
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
	pagesel	SYSSTRINGTABLES
	call	SYSSTRINGTABLES
	pagesel	$
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

;Start of program memory page 2
	ORG	4096
;Start of program memory page 3
	ORG	6144

 END
