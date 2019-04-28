;Program compiled by Great Cow BASIC (0.95 2016-03-13)
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Chip Model: MEGA8
;Assembler header file
.INCLUDE "m8def.inc"

;SREG bit names (for AVR Assembler compatibility, GCBASIC uses different names)
#define I 7
#define T 6
#define H 5
#define S 4
#define V 3
#define N 2
#define Z 1
#define C 0

;********************************************************************************

;Set aside memory locations for variables
.EQU	SYSBITVAR0=96

;********************************************************************************

;Register variables
.DEF	SysValueCopy=r21

;********************************************************************************

;Vectors
;Interrupt vectors
.ORG	0
	rjmp	BASPROGRAMSTART ;Reset
.ORG	1
	reti	;INT0
.ORG	2
	reti	;INT1
.ORG	3
	reti	;TIMER2_COMP
.ORG	4
	reti	;TIMER2_OVF
.ORG	5
	reti	;TIMER1_CAPT
.ORG	6
	reti	;TIMER1_COMPA
.ORG	7
	reti	;TIMER1_COMPB
.ORG	8
	reti	;TIMER1_OVF
.ORG	9
	reti	;TIMER0_OVF
.ORG	10
	reti	;SPI_STC
.ORG	11
	reti	;USART_RXC
.ORG	12
	reti	;USART_UDRE
.ORG	13
	reti	;USART_TXC
.ORG	14
	reti	;ADC
.ORG	15
	reti	;EE_RDY
.ORG	16
	reti	;ANA_COMP
.ORG	17
	reti	;TWI
.ORG	18
	reti	;SPM_RDY

;********************************************************************************

;Start of program memory page 0
.ORG	20
BASPROGRAMSTART:
;Initialise stack
	ldi	SysValueCopy,high(RAMEND)
	out	SPH, SysValueCopy
	ldi	SysValueCopy,low(RAMEND)
	out	SPL, SysValueCopy
;Call initialisation routines
	rcall	INITSYS

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
;asm pbyte	0x48,0x54,0x54,0x50,0x2F,0x31,0x2E,0x30,0x20,0x32,0x30,0x30	; HTTP/1.0 200
	PBYTE	0X48,0X54,0X54,0X50,0X2F,0X31,0X2E,0X30,0X20,0X32,0X30,0X30
;----- Constants
;----- Define Hardware settings
;----- Variables
;----- Quick Command Reference:
;----- Main body of program commences here.
;end
	rjmp	BASPROGRAMEND
;----- Support methods.  Subroutines and Functions
BASPROGRAMEND:
	sleep
	rjmp	BASPROGRAMEND

;********************************************************************************

INITSYS:
;PORTB = 0
	ldi	SysValueCopy,0
	out	PORTB,SysValueCopy
;PORTC = 0
	ldi	SysValueCopy,0
	out	PORTC,SysValueCopy
;PORTD = 0
	ldi	SysValueCopy,0
	out	PORTD,SysValueCopy
	ret

;********************************************************************************


