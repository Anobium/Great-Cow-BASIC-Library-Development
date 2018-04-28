;Program compiled by Great Cow BASIC (0.98.02 RC01 2018-02-27)
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F18446, r=DEC
#include <P16F18446.inc>
 __CONFIG _CONFIG1, _RSTOSC_HFINT32
 __CONFIG _CONFIG2, _MCLRE_OFF
 __CONFIG _CONFIG3, _WDTE_OFF
 __CONFIG _CONFIG4, _LVP_OFF

;********************************************************************************

;Set aside memory locations for variables
DELAYTEMP	EQU	112
DELAYTEMP2	EQU	113
SAVEDELAYTEMP	EQU	32
SAVEDELAYTEMP2	EQU	33
SAVEPCLATH	EQU	34
SAVESYSWAITTEMPMS	EQU	35
SAVESYSWAITTEMPMS_H	EQU	36
SYSBSR	EQU	37
SYSSTATUS	EQU	127
SYSTEMP1	EQU	38
SYSW	EQU	126
SYSWAITTEMPMS	EQU	114
SYSWAITTEMPMS_H	EQU	115
TMRNUMBER	EQU	39
TMRPOST	EQU	40
TMRPRES	EQU	41
TMRSOURCE	EQU	42
TMRVALUE	EQU	43
TMRVALUE_H	EQU	44
_DIRECTION	EQU	45

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
	movf	SysWaitTempMS,W
	movwf	SaveSysWaitTempMS
	movf	SysWaitTempMS_H,W
	movwf	SaveSysWaitTempMS_H
	movf	DelayTemp2,W
	movwf	SaveDelayTemp2
	movf	DelayTemp,W
	movwf	SaveDelayTemp
	movf	PCLATH,W
	movwf	SavePCLATH
	clrf	PCLATH
;On Interrupt handlers
	banksel	PIE0
	btfss	PIE0,TMR0IE
	goto	NotTMR0IF
	btfss	PIR0,TMR0IF
	goto	NotTMR0IF
	banksel	STATUS
	call	INTERRUPTHANDLER
	banksel	PIR0
	bcf	PIR0,TMR0IF
	goto	INTERRUPTDONE
NotTMR0IF
	btfss	PIE0,IOCIE
	goto	NotIOCIF
	btfss	PIR0,IOCIF
	goto	NotIOCIF
	banksel	STATUS
	call	INTERRUPTHANDLER
	banksel	PIR0
	bcf	PIR0,IOCIF
	goto	INTERRUPTDONE
NotIOCIF
;User Interrupt routine
INTERRUPTDONE
;Restore Context
;Restore system variables
	banksel	SAVESYSWAITTEMPMS
	movf	SaveSysWaitTempMS,W
	movwf	SysWaitTempMS
	movf	SaveSysWaitTempMS_H,W
	movwf	SysWaitTempMS_H
	movf	SaveDelayTemp2,W
	movwf	DelayTemp2
	movf	SaveDelayTemp,W
	movwf	DelayTemp
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
	ORG	59
BASPROGRAMSTART
;Call initialisation routines
	call	INITSYS
;Enable interrupts
	bsf	INTCON,GIE
	bsf	INTCON,PEIE

;Start of the main program
;''
;''******************************************************************
;''  Lesson 10 - "Interrupts and Pull-ups"
;''
;''  This lesson will introduce interrupts and how they are useful. It will
;''  also introduce internal weak pull-ups that are available on most PICs.
;''
;''  It should be noted that this lesson is more efficent than the last
;''  one, "Timer0". Notice how the processor is no longer waiting for
;''  Timer0 to roll over. Instead, we let the hardware modules do the work,
;''  freeing the CPU to do other things in the main loop
;''
;''  The switch is no longer continuously polled for a button press. Instead,
;''  an interrupt will occur which will automically place the program counter
;''  inside of the ISR where we can change directions outisde of normal code execution
;''
;''  LEDs rotate at a constant speed and the switch reverses their direction
;''
;''  PIC: 16f18446
;''  Compiler: GCB
;''  IDE: GCB@SYN
;''
;''  Board: PICkit 2 Low Pin Count Demo Board
;''  Date: 28.4.2018
;''
;'''''******************************************************************
;'' See Low Pin Count Demo Board User's Guide for Lesson Information*
;'''''*****************************************************************
;''
;#define DOWN                0
;#define UP                  1
;#define SWITCH              PORTA.3
;#define LED_RIGHT           1
;#define LED_LEFT            0
;#define PULL_UPS      'if this is uncommented, the trace under JP5 can be cut                                                   'with no affect on the output
;#define TMR0_16BIT
;dir portc out
	clrf	TRISC
;portc = 0
	clrf	PORTC
;portc.3 = 1
	bsf	LATC,3
;start with LEDs rotating from right to left
;_direction = LED_RIGHT
	movlw	1
	movwf	_DIRECTION
;setup switch (SW1)
;dir switch in
	bsf	TRISA,3
;Dim _DIRECTION as Byte
;TMR0IE = 1
	banksel	PIE0
	bsf	PIE0,TMR0IE
;InitTimer0 Osc, PRE0_256 + TMR0_HFINTOSC ,  POST0_2
	movlw	1
	banksel	TMRSOURCE
	movwf	TMRSOURCE
	movlw	104
	movwf	TMRPRES
	movlw	1
	movwf	TMRPOST
	call	INITTIMER0149
;On Interrupt Timer0Overflow Call InterruptHandler
	banksel	PIE0
	bsf	PIE0,TMR0IE
;Settimer ( 0 , 0x0bdc  )  'Every 1 sec
	banksel	TMRNUMBER
	clrf	TMRNUMBER
	movlw	220
	movwf	TMRVALUE
	movlw	11
	movwf	TMRVALUE_H
	call	SETTIMER
;StartTimer 0
	clrf	TMRNUMBER
	call	STARTTIMER
;IOCIE = 1
	banksel	PIE0
	bsf	PIE0,IOCIE
;On Interrupt PortChange Call InterruptHandler
	bsf	PIE0,IOCIE
;do
SysDoLoop_S1
;loop
	goto	SysDoLoop_S1
SysDoLoop_E1
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

INITSYS
;Set up internal oscillator
;Handle OSCCON1 register for parts that have this register
;asm showdebug OSCCON type is 100 'This is the routine to support OSCCON1 config addresss
;osccon type is 100
;OSCCON1 = 0x60 ' NOSC HFINTOSC; NDIV 1 - Common as this simply sets the HFINTOSC
	movlw	96
	banksel	OSCCON1
	movwf	OSCCON1
;OSCCON3 = 0x00 ' CSWHOLD may proceed; SOSCPWR Low power
	clrf	OSCCON3
;OSCEN = 0x00   ' MFOEN disabled; LFOEN disabled; ADOEN disabled; SOSCEN disabled; EXTOEN disabled; HFOEN disabled
	clrf	OSCEN
;OSCTUNE = 0x00 ' HFTUN 0
	clrf	OSCTUNE
;asm showdebug OSCCON type is 102 '#IFNDEF CHIPFamily 16
;osccon type is 102
;OSCFRQ = 0b00000110 'OSCSTAT chip.... the 16f18855 style chip
	movlw	6
	movwf	OSCFRQ
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
	banksel	ADCON0
	bcf	ADCON0,ADFM0
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
;C2EN = 0
	banksel	CM2CON0
	bcf	CM2CON0,C2EN
;C1EN = 0
	bcf	CM1CON0,C1EN
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

;Overloaded signature: BYTE:BYTE:BYTE:
INITTIMER0149
;Equate to      T0CON1 7:5      3:0        T0CON0 3:0
;Assumed for code below Timer0 is 16-bit capable as we have been passed three parameters
;Set prescaler
;T0CON1 Sets up  CLK Source (7:5)  Sync (4) & Prescale 3:0
;T0CON1 POR Val = b'00000000'
;Re-Use TMRPres as T0CON1 Temp register
;Keep T0CON1 7:4 and write bits 3:0 to  register
;Bits therefore will be cleared!
;TMRPres = (T0CON1 And 240 ) OR TMRPres
	movlw	240
	banksel	T0CON1
	andwf	T0CON1,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	iorwf	TMRPRES,F
;Set the Source bit
;IF TMRSource <> OSC  THEN
	decf	TMRSOURCE,W
	btfsc	STATUS, Z
	goto	ELSE21_1
;SET TMRPost.5 ON
	bsf	TMRPOST,5
;ELSE
	goto	ENDIF21
ELSE21_1
;SET TMRPost.5 OFF
	bcf	TMRPOST,5
;END IF
ENDIF21
;Write the TOCON register
;T0CON1 = TMRPres
	movf	TMRPRES,W
	banksel	T0CON1
	movwf	T0CON1
;Assumed for code below Timer0 is 16-bit capable
;Set Postscaler
;Re-Use TMRPost as T0CON0 Temp register
;Keep T0CON0 7:5  and write bits 5:0 to register
;Bits therefore will be cleared!
;TMRPost = (T0CON0 And 224) OR TMRPost
	movlw	224
	andwf	T0CON0,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	iorwf	TMRPOST,F
;Set TO16BIT
;Set TMRPost.4 ON '16-bit Timer0
	bsf	TMRPOST,4
;Write the TOCON register
;T0CON0 = TMRPost
	movf	TMRPOST,W
	banksel	T0CON0
	movwf	T0CON0
	banksel	STATUS
	return

;********************************************************************************

INTERRUPTHANDLER
;if  IOCIF = 1 then                         ' SW1 was just pressed
	banksel	PIR0
	btfss	PIR0,IOCIF
	goto	ENDIF1
;IOCIF = 0                              ' must clear the flag in software
	bcf	PIR0,IOCIF
;wait 5 ms                              ' debounce by waiting and seeing if still held down
	movlw	5
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	banksel	STATUS
	call	Delay_MS
;if ( SWITCH = DOWN ) then
	btfsc	PORTA,3
	goto	ENDIF3
;_direction = 1 XOR _direction     ' change directions
	movlw	1
	xorwf	_DIRECTION,F
;end if
ENDIF3
;end if
ENDIF1
;if TMR0IF = 1 then                           ' Timer has overflowed
	banksel	PIR0
	btfss	PIR0,TMR0IF
	goto	ENDIF2
;TMR0IF = 0
	bcf	PIR0,TMR0IF
;Settimer ( 0 , 0x0bdc  )
	banksel	TMRNUMBER
	clrf	TMRNUMBER
	movlw	220
	movwf	TMRVALUE
	movlw	11
	movwf	TMRVALUE_H
	call	SETTIMER
;if  _direction.0 = LED_RIGHT  then
	btfss	_DIRECTION,0
	goto	ELSE4_1
;shift to the right by 1
;Set C off
	bcf	STATUS,C
;Rotate portc right
	rrf	PORTC,F
;when the last LED is lit, restart the pattern
;if C = 1 then
	btfsc	STATUS,C
;portc.3 = 1
	bsf	LATC,3
;end if
ENDIF5
;else
	goto	ENDIF4
ELSE4_1
;shift to the left by 1
;Set C off
	bcf	STATUS,C
;Rotate portc left
	rlf	PORTC,F
;when the last LED is lit, restart the pattern
;if  portC.4 = 1 then
	btfss	PORTC,4
	goto	ENDIF6
;portC.0 = 1
	bsf	LATC,0
;portC.4 = 0
	bcf	LATC,4
;end if
ENDIF6
;end if
ENDIF4
;end if
ENDIF2
	banksel	STATUS
	return

;********************************************************************************

SETTIMER
;If TMRNumber = 0 Then
	movf	TMRNUMBER,F
	btfss	STATUS, Z
	goto	ENDIF14
;Handle chips withOUT TMR0H
;Handle chips with TMR0H
;TMR0H = TMRValue_H
	movf	TMRVALUE_H,W
	banksel	TMR0H
	movwf	TMR0H
;TMR0L = TMRValue
	banksel	TMRVALUE
	movf	TMRVALUE,W
	banksel	TMR0L
	movwf	TMR0L
;exit to prevent default setting TMR0L = TMRValue
;exit sub
	banksel	STATUS
	return
;This is therefore the default action of any chip with TMR0H and the TMR0_16BIT is NOT defined
;Added to resolve 16f18855 (chip type) using 8bit Timer0
;High byte is timer0 register
;End If
ENDIF14
;If TMRNumber = 1 then
	decf	TMRNUMBER,W
	btfss	STATUS, Z
	goto	ENDIF15
;TMR1H = TMRValue_H
	movf	TMRVALUE_H,W
	banksel	TMR1H
	movwf	TMR1H
;TMR1L = TMRValue
	banksel	TMRVALUE
	movf	TMRVALUE,W
	banksel	TMR1L
	movwf	TMR1L
;End If
ENDIF15
;If TMRNumber = 2 Then
	movlw	2
	banksel	TMRNUMBER
	subwf	TMRNUMBER,W
	btfss	STATUS, Z
	goto	ENDIF16
;TMR2 = TMRValue
	movf	TMRVALUE,W
	banksel	TMR2
	movwf	TMR2
;End If
ENDIF16
;If TMRNumber = 3 then
	movlw	3
	banksel	TMRNUMBER
	subwf	TMRNUMBER,W
	btfss	STATUS, Z
	goto	ENDIF17
;TMR3H = TMRValue_H
	movf	TMRVALUE_H,W
	banksel	TMR3H
	movwf	TMR3H
;TMR3L = TMRValue
	banksel	TMRVALUE
	movf	TMRVALUE,W
	banksel	TMR3L
	movwf	TMR3L
;End If
ENDIF17
;If TMRNumber = 4 Then
	movlw	4
	banksel	TMRNUMBER
	subwf	TMRNUMBER,W
	btfss	STATUS, Z
	goto	ENDIF18
;TMR4 = TMRValue
	movf	TMRVALUE,W
	banksel	TMR4
	movwf	TMR4
;End If
ENDIF18
;If TMRNumber = 5 then
	movlw	5
	banksel	TMRNUMBER
	subwf	TMRNUMBER,W
	btfss	STATUS, Z
	goto	ENDIF19
;TMR5H = TMRValue_H
	movf	TMRVALUE_H,W
	banksel	TMR5H
	movwf	TMR5H
;TMR5L = TMRValue
	banksel	TMRVALUE
	movf	TMRVALUE,W
	banksel	TMR5L
	movwf	TMR5L
;End If
ENDIF19
;If TMRNumber = 6 Then
	movlw	6
	banksel	TMRNUMBER
	subwf	TMRNUMBER,W
	btfss	STATUS, Z
	goto	ENDIF20
;TMR6 = TMRValue
	movf	TMRVALUE,W
	banksel	TMR6
	movwf	TMR6
;End If
ENDIF20
	banksel	STATUS
	return

;********************************************************************************

STARTTIMER
;IF TMRNumber = 0 then Set T0EN on
	movf	TMRNUMBER,F
	btfss	STATUS, Z
	goto	ENDIF7
	banksel	T0CON0
	bsf	T0CON0,T0EN
ENDIF7
;IF TMRNumber = 1 then Set TMR1ON on
	banksel	TMRNUMBER
	decf	TMRNUMBER,W
	btfss	STATUS, Z
	goto	ENDIF8
	banksel	T1CON
	bsf	T1CON,TMR1ON
ENDIF8
;IF TMRNumber = 2 then Set TMR2ON on
	movlw	2
	banksel	TMRNUMBER
	subwf	TMRNUMBER,W
	btfss	STATUS, Z
	goto	ENDIF9
	banksel	T2CON
	bsf	T2CON,TMR2ON
ENDIF9
;IF TMRNumber = 3 then Set TMR3ON on
	movlw	3
	banksel	TMRNUMBER
	subwf	TMRNUMBER,W
	btfss	STATUS, Z
	goto	ENDIF10
	banksel	T3CON
	bsf	T3CON,TMR3ON
ENDIF10
;IF TMRNumber = 4 then Set TMR4ON on
	movlw	4
	banksel	TMRNUMBER
	subwf	TMRNUMBER,W
	btfss	STATUS, Z
	goto	ENDIF11
	banksel	T4CON
	bsf	T4CON,TMR4ON
ENDIF11
;IF TMRNumber = 5 then Set TMR5ON on
	movlw	5
	banksel	TMRNUMBER
	subwf	TMRNUMBER,W
	btfss	STATUS, Z
	goto	ENDIF12
	banksel	T5CON
	bsf	T5CON,TMR5ON
ENDIF12
;IF TMRNumber = 6 then Set TMR6ON on
	movlw	6
	banksel	TMRNUMBER
	subwf	TMRNUMBER,W
	btfss	STATUS, Z
	goto	ENDIF13
	banksel	T6CON
	bsf	T6CON,TMR6ON
ENDIF13
	banksel	STATUS
	return

;********************************************************************************

;Start of program memory page 1
	ORG	2048
;Start of program memory page 2
	ORG	4096
;Start of program memory page 3
	ORG	6144
;Start of program memory page 4
	ORG	8192
;Start of program memory page 5
	ORG	10240
;Start of program memory page 6
	ORG	12288
;Start of program memory page 7
	ORG	14336
;Start of program memory page 8
	ORG	16384
;Start of program memory page 9
	ORG	18432
;Start of program memory page 10
	ORG	20480
;Start of program memory page 11
	ORG	22528
;Start of program memory page 12
	ORG	24576
;Start of program memory page 13
	ORG	26624

 END
