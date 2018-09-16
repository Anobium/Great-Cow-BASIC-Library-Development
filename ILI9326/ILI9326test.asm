;Program compiled by Great Cow BASIC (0.98.02 2018-05-10)
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Chip Model: MEGA328P
;Assembler header file
.INCLUDE "m328pdef.inc"

;SREG bit names (for AVR Assembler compatibility, GCBASIC uses different names)
#define C 0
#define H 5
#define I 7
#define N 2
#define S 4
#define T 6
#define V 3
#define Z 1

;********************************************************************************

;Set aside memory locations for variables
.EQU	GLCD_HEIGHT=256
.EQU	GLCD_HEIGHT_H=257
.EQU	GLCD_WIDTH=258
.EQU	GLCD_WIDTH_H=259
.EQU	ILI9326SENDWORD=260
.EQU	ILI9326SENDWORD_H=261
.EQU	ILI9326_ANGLE=262
.EQU	ILI9326_ANGLE_H=263
.EQU	SYSREPEATTEMP1=264
.EQU	SYSREPEATTEMP1_H=265
.EQU	SYSREPEATTEMP2=266
.EQU	SYSREPEATTEMP2_H=267
.EQU	SYSREPEATTEMP3=268
.EQU	SYSREPEATTEMP3_H=269
.EQU	SYSREPEATTEMP4=270
.EQU	SYSREPEATTEMP4_H=271
.EQU	XX1=272
.EQU	XX1_H=273

;********************************************************************************

;Register variables
.DEF	DELAYTEMP=r25
.DEF	DELAYTEMP2=r26
.DEF	SYSBYTETEMPX=r0
.DEF	SYSCALCTEMPA=r22
.DEF	SYSVALUECOPY=r21
.DEF	SYSWAITTEMPMS=r29
.DEF	SYSWAITTEMPMS_H=r30
.DEF	SYSWORDTEMPA=r22
.DEF	SYSWORDTEMPA_H=r23
.DEF	SYSWORDTEMPB=r28
.DEF	SYSWORDTEMPB_H=r29
.DEF	SYSTEMP1=r1
.DEF	SYSTEMP1_H=r2
.DEF	SYSTEMP2=r16
.DEF	SYSTEMP3=r3
.DEF	SYSTEMP4=r4

;********************************************************************************

;Vectors
;Interrupt vectors
.ORG	0
	rjmp	BASPROGRAMSTART ;Reset
.ORG	2
	reti	;INT0
.ORG	4
	reti	;INT1
.ORG	6
	reti	;PCINT0
.ORG	8
	reti	;PCINT1
.ORG	10
	reti	;PCINT2
.ORG	12
	reti	;WDT
.ORG	14
	reti	;TIMER2_COMPA
.ORG	16
	reti	;TIMER2_COMPB
.ORG	18
	reti	;TIMER2_OVF
.ORG	20
	reti	;TIMER1_CAPT
.ORG	22
	reti	;TIMER1_COMPA
.ORG	24
	reti	;TIMER1_COMPB
.ORG	26
	reti	;TIMER1_OVF
.ORG	28
	reti	;TIMER0_COMPA
.ORG	30
	reti	;TIMER0_COMPB
.ORG	32
	reti	;TIMER0_OVF
.ORG	34
	reti	;SPI_STC
.ORG	36
	reti	;USART_RX
.ORG	38
	reti	;USART_UDRE
.ORG	40
	reti	;USART_TX
.ORG	42
	reti	;ADC
.ORG	44
	reti	;EE_READY
.ORG	46
	reti	;ANALOG_COMP
.ORG	48
	reti	;TWI
.ORG	50
	reti	;SPM_READY

;********************************************************************************

;Start of program memory page 0
.ORG	52
BASPROGRAMSTART:
;Initialise stack
	ldi	SysValueCopy,high(RAMEND)
	out	SPH, SysValueCopy
	ldi	SysValueCopy,low(RAMEND)
	out	SPL, SysValueCopy
;Call initialisation routines
	rcall	INITSYS

;Start of the main program
;#config osc=INTosc, MCLRE=off, WDTE=Off, boren=off
;wait 1 ms
	ldi	SysWaitTempMS,1
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;#include <glcd.h>
;#include<glcd_ili9326.h>
;#define GLCD_TYPE GLCD_TYPE_ILI9326
;#define GLCD_RST      portc.4         ' Reset line
;#define GLCD_RD       portc.3        ' read command line
;#define GLCD_WR       portc.2         ' write command line
;#define GLCD_RS       portc.1         ' Command/Data line
;#define GLCD_CS       portc.0         ' Chip select line
;#define GLCD_DB0       DIGITAL_8
;#define GLCD_DB1       DIGITAL_9
;#define GLCD_DB2       DIGITAL_2
;#define GLCD_DB3       DIGITAL_3
;#define GLCD_DB4       DIGITAL_4
;#define GLCD_DB5       DIGITAL_5
;#define GLCD_DB6       DIGITAL_6
;#define GLCD_DB7       DIGITAL_7
;#define GLCD_DB0       portd.0
;#define GLCD_DB1       portd.1
;#define GLCD_DB2       portd.2
;#define GLCD_DB3       portd.3
;#define GLCD_DB4       portd.4
;#define GLCD_DB5       portd.5
;#define GLCD_DB6       portd.6
;#define GLCD_DB7       portd.7
;dir portc out
	ldi	SysValueCopy,255
	out	DDRC,SysValueCopy
;dir portb out
	ldi	SysValueCopy,255
	out	DDRB,SysValueCopy
;#define GLCD_DataPort portD
;#define ILI9326_DataPort GLCD_DataPort
;#define ILI9326_GLCD_RST GLCD_RST
;#define ILI9326_GLCD_CS GLCD_CS
;#define ILI9326_GLCD_RS GLCD_RS
;#define ILI9326_GLCD_WR GLCD_WR
;#define ILI9326_GLCD_RD GLCD_RD
;dir ILI9326_dataPort out
	ldi	SysValueCopy,255
	out	DDRD,SysValueCopy
;dim ILI9326SendWord, GLCD_width,GLCD_height,ILI9326_angle as word
;dim xx1 as word
;GLCD_WIDTH = 400
	ldi	SysValueCopy,144
	sts	GLCD_WIDTH,SysValueCopy
	ldi	SysValueCopy,1
	sts	GLCD_WIDTH_H,SysValueCopy
;GLCD_HEIGHT = 240
	ldi	SysValueCopy,240
	sts	GLCD_HEIGHT,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCD_HEIGHT_H,SysValueCopy
;ili9326_angle=0
	ldi	SysValueCopy,0
	sts	ILI9326_ANGLE,SysValueCopy
	sts	ILI9326_ANGLE_H,SysValueCopy
;do
SysDoLoop_S1:
;ili9326init
	rcall	ILI9326INIT
;ILI9326Orientation(ILI9326_angle)
	rcall	ILI9326ORIENTATION
;GLCDCLS_ILI9326
	rcall	GLCDCLS_ILI9326
;glcdStripes_ILI9326
	rcall	GLCDSTRIPES_ILI9326
;loop
	rjmp	SysDoLoop_S1
SysDoLoop_E1:
;sleep
	sleep
;end
	rjmp	BASPROGRAMEND
BASPROGRAMEND:
	sleep
	rjmp	BASPROGRAMEND

;********************************************************************************

Delay_MS:
	inc	SysWaitTempMS_H
DMS_START:
	ldi	DELAYTEMP2,113
DMS_OUTER:
	ldi	DELAYTEMP,58
DMS_INNER:
	dec	DELAYTEMP
	brne	DMS_INNER
	dec	DELAYTEMP2
	brne	DMS_OUTER
	dec	SysWaitTempMS
	brne	DMS_START
	dec	SysWaitTempMS_H
	brne	DMS_START
	ret

;********************************************************************************

GLCDCLS_ILI9326:
;SendCommand_ili9326(0x0202)
	ldi	SysValueCopy,2
	sts	ILI9326SENDWORD,SysValueCopy
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDCOMMAND_ILI9326
;repeat GLCD_width
	lds	SysValueCopy,GLCD_WIDTH
	sts	SysRepeatTemp1,SysValueCopy
	lds	SysValueCopy,GLCD_WIDTH_H
	sts	SysRepeatTemp1_H,SysValueCopy
	lds	SysWORDTempA,SYSREPEATTEMP1
	lds	SysWORDTempA_H,SYSREPEATTEMP1_H
	ldi	SysWORDTempB,1
	ldi	SysWORDTempB_H,0
	rcall	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysRepeatLoopEnd1
	lds	SysCalcTempA,SYSREPEATTEMP1
	tst	SysCalcTempA
	breq	ENDIF1
	lds	SysTemp1,SysRepeatTemp1_H
	inc	SysTemp1
	sts	SysRepeatTemp1_H,SysTemp1
ENDIF1:
SysRepeatLoop1:
;repeat GLCD_height
	lds	SysValueCopy,GLCD_HEIGHT
	sts	SysRepeatTemp2,SysValueCopy
	lds	SysValueCopy,GLCD_HEIGHT_H
	sts	SysRepeatTemp2_H,SysValueCopy
	lds	SysWORDTempA,SYSREPEATTEMP2
	lds	SysWORDTempA_H,SYSREPEATTEMP2_H
	ldi	SysWORDTempB,1
	ldi	SysWORDTempB_H,0
	rcall	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysRepeatLoopEnd2
	lds	SysCalcTempA,SYSREPEATTEMP2
	tst	SysCalcTempA
	breq	ENDIF2
	lds	SysTemp1,SysRepeatTemp2_H
	inc	SysTemp1
	sts	SysRepeatTemp2_H,SysTemp1
ENDIF2:
SysRepeatLoop2:
;sendData_ILI9326(0x0000)
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD,SysValueCopy
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDDATA_ILI9326
;end repeat
	lds	SysTemp1,SysRepeatTemp2
	lds	SysTemp1_H,SysRepeatTemp2_H
	dec	SysTemp1
	sts	SysRepeatTemp2,SysTemp1
	brne	SysRepeatLoop2
	dec	SysTemp1_H
	sts	SysRepeatTemp2_H,SysTemp1_H
	brne	SysRepeatLoop2
SysRepeatLoopEnd2:
;end repeat
	lds	SysTemp1,SysRepeatTemp1
	lds	SysTemp1_H,SysRepeatTemp1_H
	dec	SysTemp1
	sts	SysRepeatTemp1,SysTemp1
	brne	SysRepeatLoop1
	dec	SysTemp1_H
	sts	SysRepeatTemp1_H,SysTemp1_H
	brne	SysRepeatLoop1
SysRepeatLoopEnd1:
	ret

;********************************************************************************

GLCDSTRIPES_ILI9326:
;test for horizontal/vertical alignment
;xx1=0x0000
	ldi	SysValueCopy,0
	sts	XX1,SysValueCopy
	sts	XX1_H,SysValueCopy
;SendCommand_ili9326(0x0202)
	ldi	SysValueCopy,2
	sts	ILI9326SENDWORD,SysValueCopy
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDCOMMAND_ILI9326
;repeat GLCD_width
	lds	SysValueCopy,GLCD_WIDTH
	sts	SysRepeatTemp3,SysValueCopy
	lds	SysValueCopy,GLCD_WIDTH_H
	sts	SysRepeatTemp3_H,SysValueCopy
	lds	SysWORDTempA,SYSREPEATTEMP3
	lds	SysWORDTempA_H,SYSREPEATTEMP3_H
	ldi	SysWORDTempB,1
	ldi	SysWORDTempB_H,0
	rcall	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysRepeatLoopEnd3
	lds	SysCalcTempA,SYSREPEATTEMP3
	tst	SysCalcTempA
	breq	ENDIF3
	lds	SysTemp1,SysRepeatTemp3_H
	inc	SysTemp1
	sts	SysRepeatTemp3_H,SysTemp1
ENDIF3:
SysRepeatLoop3:
;repeat GLCD_height
	lds	SysValueCopy,GLCD_HEIGHT
	sts	SysRepeatTemp4,SysValueCopy
	lds	SysValueCopy,GLCD_HEIGHT_H
	sts	SysRepeatTemp4_H,SysValueCopy
	lds	SysWORDTempA,SYSREPEATTEMP4
	lds	SysWORDTempA_H,SYSREPEATTEMP4_H
	ldi	SysWORDTempB,1
	ldi	SysWORDTempB_H,0
	rcall	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysRepeatLoopEnd4
	lds	SysCalcTempA,SYSREPEATTEMP4
	tst	SysCalcTempA
	breq	ENDIF4
	lds	SysTemp1,SysRepeatTemp4_H
	inc	SysTemp1
	sts	SysRepeatTemp4_H,SysTemp1
ENDIF4:
SysRepeatLoop4:
;sendData_ILI9326(xx1)
	lds	SysValueCopy,XX1
	sts	ILI9326SENDWORD,SysValueCopy
	lds	SysValueCopy,XX1_H
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDDATA_ILI9326
	lds	SysValueCopy,ILI9326SENDWORD
	sts	XX1,SysValueCopy
	lds	SysValueCopy,ILI9326SENDWORD_H
	sts	XX1_H,SysValueCopy
;end repeat
	lds	SysTemp1,SysRepeatTemp4
	lds	SysTemp1_H,SysRepeatTemp4_H
	dec	SysTemp1
	sts	SysRepeatTemp4,SysTemp1
	brne	SysRepeatLoop4
	dec	SysTemp1_H
	sts	SysRepeatTemp4_H,SysTemp1_H
	brne	SysRepeatLoop4
SysRepeatLoopEnd4:
;xx1=xx1+123
	lds	SysTemp1,XX1
	ldi	SysTemp2,123
	add	SysTemp1,SysTemp2
	sts	XX1,SysTemp1
	lds	SysTemp1,XX1_H
	ldi	SysTemp2,0
	adc	SysTemp1,SysTemp2
	sts	XX1_H,SysTemp1
;end repeat
	lds	SysTemp1,SysRepeatTemp3
	lds	SysTemp1_H,SysRepeatTemp3_H
	dec	SysTemp1
	sts	SysRepeatTemp3,SysTemp1
	breq	PC + 2
	rjmp	SysRepeatLoop3
	dec	SysTemp1_H
	sts	SysRepeatTemp3_H,SysTemp1_H
	breq	PC + 2
	rjmp	SysRepeatLoop3
SysRepeatLoopEnd3:
	ret

;********************************************************************************

ILI9326INIT:
;Reset*********************
;Set ILI9326_GLCD_RST On
	sbi	PORTC,4
;Wait 15 ms
	ldi	SysWaitTempMS,15
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;Set ILI9326_GLCD_RST Off
	cbi	PORTC,4
;Wait 15 ms
	ldi	SysWaitTempMS,15
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;Set ILI9326_GLCD_RST On
	sbi	PORTC,4
;Wait 15 ms
	ldi	SysWaitTempMS,15
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;//*************Power On sequence ****************//
;parameters below taken from...
;*  Module for Microchip Graphics Library
;*  LCD controller driver*  ILI9326
;discharge*********************
;SendCommand_ILI9326(0x0100)
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,1
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0000)
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD,SysValueCopy
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0102)
	ldi	SysValueCopy,2
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,1
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0000)
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD,SysValueCopy
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0103)
	ldi	SysValueCopy,3
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,1
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0000)
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD,SysValueCopy
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDDATA_ILI9326
;wait 200 ms 'power settings*****
	ldi	SysWaitTempMS,200
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;SendCommand_ILI9326(0x0100)
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,1
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDCOMMAND_ILI9326
;SendData_ili9326(0x1190)
	ldi	SysValueCopy,144
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,17
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0101)
	ldi	SysValueCopy,1
	sts	ILI9326SENDWORD,SysValueCopy
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0017)
	ldi	SysValueCopy,23
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0102)
	ldi	SysValueCopy,2
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,1
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDCOMMAND_ILI9326
;SendData_ili9326(0x01BD)
	ldi	SysValueCopy,189
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,1
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0103)
	ldi	SysValueCopy,3
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,1
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0350)
	ldi	SysValueCopy,80
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,3
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0281)
	ldi	SysValueCopy,129
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,2
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0017)
	ldi	SysValueCopy,23
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0200)
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,2
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0000)
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD,SysValueCopy
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0201)
	ldi	SysValueCopy,1
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,2
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0000)
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD,SysValueCopy
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDDATA_ILI9326
;set gamma curve**************
;SendCommand_ILI9326(0x0300)
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,3
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0000)
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD,SysValueCopy
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0301)
	ldi	SysValueCopy,1
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,3
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0707)
	ldi	SysValueCopy,7
	sts	ILI9326SENDWORD,SysValueCopy
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0302)
	ldi	SysValueCopy,2
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,3
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0606)
	ldi	SysValueCopy,6
	sts	ILI9326SENDWORD,SysValueCopy
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0305)
	ldi	SysValueCopy,5
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,3
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0006)
	ldi	SysValueCopy,6
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0306)
	ldi	SysValueCopy,6
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,3
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0A09)
	ldi	SysValueCopy,9
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,10
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0307)
	ldi	SysValueCopy,7
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,3
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0203)
	ldi	SysValueCopy,3
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,2
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0308)
	ldi	SysValueCopy,8
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,3
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0005)
	ldi	SysValueCopy,5
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0309)
	ldi	SysValueCopy,9
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,3
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0007)
	ldi	SysValueCopy,7
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDDATA_ILI9326
;SendCommand_ILI9326(0x030C)
	ldi	SysValueCopy,12
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,3
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0400)
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,4
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDDATA_ILI9326
;SendCommand_ILI9326(0x030D)
	ldi	SysValueCopy,13
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,3
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDCOMMAND_ILI9326
;SendData_ili9326(0x000A)
	ldi	SysValueCopy,10
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDDATA_ILI9326
;set GRAM area**************
;SendCommand_ILI9326(0x0210)
	ldi	SysValueCopy,16
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,2
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0000)
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD,SysValueCopy
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0211)
	ldi	SysValueCopy,17
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,2
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDCOMMAND_ILI9326
;SendData_ili9326(0x00EF)' 240
	ldi	SysValueCopy,239
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDDATA_ILI9326
;SendCommand_ILI9326(0x212)
	ldi	SysValueCopy,18
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,2
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0000)
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD,SysValueCopy
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0213)
	ldi	SysValueCopy,19
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,2
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDCOMMAND_ILI9326
;SendData_ili9326(0x018F) '400
	ldi	SysValueCopy,143
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,1
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0400)
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,4
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDCOMMAND_ILI9326
;SendData_ili9326(0x3500)
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,53
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0401)
	ldi	SysValueCopy,1
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,4
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0001)
	ldi	SysValueCopy,1
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0404)
	ldi	SysValueCopy,4
	sts	ILI9326SENDWORD,SysValueCopy
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0000)
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD,SysValueCopy
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0010) 'set screen defaults
	ldi	SysValueCopy,16
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0010)
	ldi	SysValueCopy,16
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0011) 'last set of commands
	ldi	SysValueCopy,17
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0000)
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD,SysValueCopy
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDDATA_ILI9326
;SendCommand_ILI9326(0x020B)
	ldi	SysValueCopy,11
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,2
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0000)
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD,SysValueCopy
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0007)
	ldi	SysValueCopy,7
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0173) 'display on
	ldi	SysValueCopy,115
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,1
	sts	ILI9326SENDWORD_H,SysValueCopy
	rjmp	SENDDATA_ILI9326

;********************************************************************************

ILI9326ORIENTATION:
;if ILI9326_angle=0 then
	lds	SysWORDTempA,ILI9326_ANGLE
	lds	SysWORDTempA_H,ILI9326_ANGLE_H
	ldi	SysWORDTempB,0
	ldi	SysWORDTempB_H,0
	rcall	SysCompEqual16
	sbrs	SysByteTempX,0
	rjmp	ENDIF5
;SendCommand_ILI9326(0x0003)
	ldi	SysValueCopy,3
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0030)
	ldi	SysValueCopy,48
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDDATA_ILI9326
;end if
ENDIF5:
;if ILI9326_angle=90 then
	lds	SysWORDTempA,ILI9326_ANGLE
	lds	SysWORDTempA_H,ILI9326_ANGLE_H
	ldi	SysWORDTempB,90
	ldi	SysWORDTempB_H,0
	rcall	SysCompEqual16
	sbrs	SysByteTempX,0
	rjmp	ENDIF6
;SendCommand_ILI9326(0x0003)
	ldi	SysValueCopy,3
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0028)
	ldi	SysValueCopy,40
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDDATA_ILI9326
;end if
ENDIF6:
;if ILI9326_angle=180 then
	lds	SysWORDTempA,ILI9326_ANGLE
	lds	SysWORDTempA_H,ILI9326_ANGLE_H
	ldi	SysWORDTempB,180
	ldi	SysWORDTempB_H,0
	rcall	SysCompEqual16
	sbrs	SysByteTempX,0
	rjmp	ENDIF7
;SendCommand_ILI9326(0x0003)
	ldi	SysValueCopy,3
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0000)
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD,SysValueCopy
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDDATA_ILI9326
;end if
ENDIF7:
;if ILI9326_angle=270 then
	lds	SysWORDTempA,ILI9326_ANGLE
	lds	SysWORDTempA_H,ILI9326_ANGLE_H
	ldi	SysWORDTempB,14
	ldi	SysWORDTempB_H,1
	rcall	SysCompEqual16
	sbrs	SysByteTempX,0
	rjmp	ENDIF8
;SendCommand_ILI9326(0x0003)
	ldi	SysValueCopy,3
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0018)
	ldi	SysValueCopy,24
	sts	ILI9326SENDWORD,SysValueCopy
	ldi	SysValueCopy,0
	sts	ILI9326SENDWORD_H,SysValueCopy
	rcall	SENDDATA_ILI9326
;end if
ENDIF8:
	ret

;********************************************************************************

INITSYS:
;Turn off all ports
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

SENDCOMMAND_ILI9326:
;set ILI9326_GLCD_CS off
	cbi	PORTC,0
;set ILI9326_GLCD_RS OFF
	cbi	PORTC,1
;set ILI9326_GLCD_RD ON
	sbi	PORTC,3
;set ILI9326_GLCD_WR ON
	sbi	PORTC,2
;PORTD = (PORTD & 0B00000011) | ((ILI9326SendWord_H) & 0B11111100);
	ldi	SysTemp2,3
	in	SysTemp3,PORTD
	and	SysTemp3,SysTemp2
	mov	SysTemp1,SysTemp3
	ldi	SysTemp2,252
	lds	SysTemp4,ILI9326SENDWORD_H
	and	SysTemp4,SysTemp2
	mov	SysTemp3,SysTemp4
	or	SysTemp3,SysTemp1
	out	PORTD,SysTemp3
;PORTB = (PORTB & 0B11111100) | ((ILI9326SendWord_H) & 0B00000011);
	ldi	SysTemp2,252
	in	SysTemp4,PORTB
	and	SysTemp4,SysTemp2
	mov	SysTemp3,SysTemp4
	ldi	SysTemp2,3
	lds	SysTemp1,ILI9326SENDWORD_H
	and	SysTemp1,SysTemp2
	mov	SysTemp4,SysTemp1
	or	SysTemp4,SysTemp3
	out	PORTB,SysTemp4
;set ILI9326_GLCD_WR OFF
	cbi	PORTC,2
;set ILI9326_GLCD_WR ON
	sbi	PORTC,2
;PORTD = (PORTD & 0B00000011) | ((ILI9326SendWord) & 0B11111100);
	ldi	SysTemp2,3
	in	SysTemp4,PORTD
	and	SysTemp4,SysTemp2
	mov	SysTemp3,SysTemp4
	ldi	SysTemp2,252
	lds	SysTemp4,ILI9326SENDWORD
	and	SysTemp4,SysTemp2
	mov	SysTemp1,SysTemp4
	ldi	SysValueCopy,0
	mov	SysTemp1_H,SysValueCopy
	or	SysTemp1,SysTemp3
	out	PORTD,SysTemp1
;PORTB = (PORTB & 0B11111100) | ((ILI9326SendWord) & 0B00000011);
	ldi	SysTemp2,252
	in	SysTemp4,PORTB
	and	SysTemp4,SysTemp2
	mov	SysTemp3,SysTemp4
	ldi	SysTemp2,3
	lds	SysTemp4,ILI9326SENDWORD
	and	SysTemp4,SysTemp2
	mov	SysTemp1,SysTemp4
	ldi	SysValueCopy,0
	mov	SysTemp1_H,SysValueCopy
	or	SysTemp1,SysTemp3
	out	PORTB,SysTemp1
;set ILI9326_GLCD_WR OFF
	cbi	PORTC,2
;set ILI9326_GLCD_WR ON
	sbi	PORTC,2
	ret

;********************************************************************************

SENDDATA_ILI9326:
;set ILI9326_GLCD_RS ON
	sbi	PORTC,1
;ILI9326_DataPort=ILI9326SendWord_h
;PORTD = (PORTD & 0B00000011) | ((ILI9326SendWord_H) & 0B11111100);
	ldi	SysTemp2,3
	in	SysTemp4,PORTD
	and	SysTemp4,SysTemp2
	mov	SysTemp3,SysTemp4
	ldi	SysTemp2,252
	lds	SysTemp1,ILI9326SENDWORD_H
	and	SysTemp1,SysTemp2
	mov	SysTemp4,SysTemp1
	or	SysTemp4,SysTemp3
	out	PORTD,SysTemp4
;PORTB = (PORTB & 0B11111100) | ((ILI9326SendWord_H) & 0B00000011);
	ldi	SysTemp2,252
	in	SysTemp4,PORTB
	and	SysTemp4,SysTemp2
	mov	SysTemp3,SysTemp4
	ldi	SysTemp2,3
	lds	SysTemp1,ILI9326SENDWORD_H
	and	SysTemp1,SysTemp2
	mov	SysTemp4,SysTemp1
	or	SysTemp4,SysTemp3
	out	PORTB,SysTemp4
;set ILI9326_GLCD_WR OFF
	cbi	PORTC,2
;set ILI9326_GLCD_WR ON
	sbi	PORTC,2
;ILI9326_DataPort=ILI9326SendWord
;PORTD = (PORTD & 0B00000011) | ((ILI9326SendWord) & 0B11111100);
	ldi	SysTemp2,3
	in	SysTemp4,PORTD
	and	SysTemp4,SysTemp2
	mov	SysTemp3,SysTemp4
	ldi	SysTemp2,252
	lds	SysTemp4,ILI9326SENDWORD
	and	SysTemp4,SysTemp2
	mov	SysTemp1,SysTemp4
	ldi	SysValueCopy,0
	mov	SysTemp1_H,SysValueCopy
	or	SysTemp1,SysTemp3
	out	PORTD,SysTemp1
;PORTB = (PORTB & 0B11111100) | ((ILI9326SendWord) & 0B00000011);
	ldi	SysTemp2,252
	in	SysTemp4,PORTB
	and	SysTemp4,SysTemp2
	mov	SysTemp3,SysTemp4
	ldi	SysTemp2,3
	lds	SysTemp4,ILI9326SENDWORD
	and	SysTemp4,SysTemp2
	mov	SysTemp1,SysTemp4
	ldi	SysValueCopy,0
	mov	SysTemp1_H,SysValueCopy
	or	SysTemp1,SysTemp3
	out	PORTB,SysTemp1
;set ILI9326_GLCD_WR OFF
	cbi	PORTC,2
;set ILI9326_GLCD_WR ON
	sbi	PORTC,2
	ret

;********************************************************************************

SYSCOMPEQUAL16:
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clr SysByteTempX
	clr	SYSBYTETEMPX
;cp SysWordTempA, SysWordTempB
	cp	SYSWORDTEMPA, SYSWORDTEMPB
;brne SCE16False
	brne	SCE16FALSE
;cp SysWordTempA_H, SysWordTempB_H
	cp	SYSWORDTEMPA_H, SYSWORDTEMPB_H
;brne SCE16False
	brne	SCE16FALSE
;com SysByteTempX
	com	SYSBYTETEMPX
SCE16FALSE:
	ret

;********************************************************************************

SYSCOMPLESSTHAN16:
;clr SysByteTempX
	clr	SYSBYTETEMPX
;Test High, exit false if more
;cp SysWordTempB_H,SysWordTempA_H
	cp	SYSWORDTEMPB_H,SYSWORDTEMPA_H
;brlo SCLT16False
	brlo	SCLT16FALSE
;Test high, exit true if less
;cp SysWordTempA_H,SysWordTempB_H
	cp	SYSWORDTEMPA_H,SYSWORDTEMPB_H
;brlo SCLT16True
	brlo	SCLT16TRUE
;Test Low, exit if more or equal
;cp SysWordTempA,SysWordTempB
	cp	SYSWORDTEMPA,SYSWORDTEMPB
;brlo SCLT16True
	brlo	SCLT16TRUE
;ret
	ret
SCLT16TRUE:
;com SysByteTempX
	com	SYSBYTETEMPX
SCLT16FALSE:
	ret

;********************************************************************************


