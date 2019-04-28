;Program compiled by Great Cow BASIC (0.94 2015-08-05)
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F886, r=DEC
#include <P16F886.inc>
 __CONFIG _CONFIG1, _LVP_OFF & _MCLRE_OFF & _WDTE_OFF & _FOSC_HS

;********************************************************************************

;Set aside memory locations for variables
DELAYTEMP	EQU	112
DELAYTEMP2	EQU	113
SYSCALCTEMPA	EQU	117
SYSCALCTEMPX	EQU	112
SYSDIVMULTA	EQU	119
SYSDIVMULTA_H	EQU	120
SYSDIVMULTB	EQU	123
SYSDIVMULTB_H	EQU	124
SYSDIVMULTX	EQU	114
SYSDIVMULTX_H	EQU	115
SYSSTRINGA	EQU	119
SYSSTRINGA_H	EQU	120
SYSSTRINGLENGTH	EQU	118
SysBYTETempA	EQU	117
SysBYTETempB	EQU	121
SysByteTempX	EQU	112
SysDivLoop	EQU	116
SysStringB	EQU	114
SysStringB_H	EQU	115
SysWORDTempA	EQU	117
SysWORDTempA_H	EQU	118
SysWORDTempB	EQU	121
SysWORDTempB_H	EQU	122
SysWORDTempX	EQU	112
SysWORDTempX_H	EQU	113
SysWaitTempMS	EQU	114
SysWaitTempMS_H	EQU	115
SysWaitTempS	EQU	116
SysWaitTempUS	EQU	117
SysWaitTempUS_H	EQU	118
STR1	EQU	453
SYSSTRINGPARAM1	EQU	412
KS0108	EQU	404
CHARBITS	EQU	32
CHARBYTES	EQU	33
CHARCODE	EQU	34
CHARCOL	EQU	35
CHARCOL_H	EQU	36
CHARCOLS	EQU	37
CHARCOLS_H	EQU	38
CHARDISCR	EQU	39
CHARDISCR_H	EQU	40
CHARLOCX	EQU	41
CHARLOCX_H	EQU	42
CHARLOCY	EQU	43
CHARLOCY_H	EQU	44
CHARNUM	EQU	45
CHAROFFSETBEGIN	EQU	46
CHAROFFSETBEGIN_H	EQU	47
CHAROFFSETEND	EQU	48
CHAROFFSETEND_H	EQU	49
CHAROLDBYTES	EQU	50
CHARROW	EQU	51
CHARROW_H	EQU	52
CHARROWS	EQU	53
CHARROWS_H	EQU	54
CHARSTR	EQU	55
CURRCHARVAL	EQU	56
CURRCOL	EQU	57
CURRPAGE	EQU	58
DIGITALDEFAULTSIZE	EQU	59
GLCDBACKGROUND	EQU	60
GLCDBACKGROUND_H	EQU	61
GLCDBITNO	EQU	62
GLCDCHANGE	EQU	63
GLCDCOLOUR	EQU	64
GLCDCOLOUR_H	EQU	65
GLCDDATATEMP	EQU	66
GLCDDEVICEHEIGHT	EQU	67
GLCDDEVICEHEIGHT_H	EQU	68
GLCDDEVICEWIDTH	EQU	69
GLCDDEVICEWIDTH_H	EQU	70
GLCDFNTDEFAULT	EQU	71
GLCDFNTDEFAULTSIZE	EQU	72
GLCDFONTWIDTH	EQU	73
GLCDFONTWIDTH_H	EQU	74
GLCDFOREGROUND	EQU	75
GLCDFOREGROUND_H	EQU	76
GLCDPRINTLOC	EQU	77
GLCDPRINTLOC_H	EQU	78
GLCDREADBYTE_KS0108	EQU	79
GLCDX	EQU	80
GLCDY	EQU	81
GLCD_COUNT	EQU	82
GLCD_YORDINATE	EQU	83
GLCD_YORDINATE_H	EQU	84
KS0108_CLOCK_DELAY	EQU	85
LCDBYTE	EQU	86
PRINTLEN	EQU	87
PRINTLOCX	EQU	88
PRINTLOCX_H	EQU	89
PRINTLOCY	EQU	90
PRINTLOCY_H	EQU	91
SIZE	EQU	92
SYSBITVAR0	EQU	93
SYSPRINTTEM	EQU	94
StringPointer	EQU	95
SysPRINTDATAHandler	EQU	96
SysPRINTDATAHandler_H	EQU	97
SysRepeatTemp1	EQU	98
SysTemp1	EQU	99
SysTemp2	EQU	100
SysTemp2_H	EQU	101
SysTemp3	EQU	102
SysTemp3_H	EQU	103

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
	pagesel	INITSYS
	call	INITSYS
	pagesel	$
	call	DIGITALINIT
	call	INITGLCD_KS0108
	pagesel	$

;Start of the main program
;Chip Settings
;Include
;#include "TTF.h"
;GLCD selected extension font set. ASCII characters 31-254, the extended font uses 1358 bytes of program memory
;#define GLCD_EXTENDEDFONTSET1
;#define DigitalfntSize DigitalMediumSize
;Defines (Constants)
;#define GLCD_RW PORTB.1  'D9 to pin 5 of LCD
;#define GLCD_RESET PORTB.5 'D13 to pin 17 of LCD
;#define GLCD_CS1 PORTB.3 'D12 to actually since CS1, CS2 can be reversed on some devices
;#define GLCD_CS2 PORTB.4 'D11 to actually since CS1, CS2 can be reversed on some devices
;#define GLCD_RS PORTB.0  'D8 to pin 4 D/I pin on LCD
;#define GLCD_ENABLE PORTB.2 'D10 to Pin 6 on LCD
;#define GLCD_DB0 PORTC.7 'D0 to pin 7 on LCD
;#define GLCD_DB1 PORTC.6 'D1 to pin 8 on LCD
;#define GLCD_DB2 PORTC.5 'D2 to pin 9 on LCD
;#define GLCD_DB3 PORTC.4 'D3 to pin 10 on LCD
;#define GLCD_DB4 PORTC.3 'D4 to pin 11 on LCD
;#define GLCD_DB5 PORTC.2 'D5 to pin 12 on LCD
;#define GLCD_DB6 PORTC.1 'D6 to pin 13 on LCD
;#define GLCD_DB7 PORTC.0 'D7 to pin 14 on LCD
;Dim CharStr as Byte
;Dim str1 as string
;Wait 1 s
	movlw	1
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;Main Program
;InitGLCD
	call	INITGLCD_KS0108
	pagesel	$
;GLCDForeground= 1
	movlw	1
	movwf	GLCDFOREGROUND
	clrf	GLCDFOREGROUND_H
;PrintDigital 10 , 10 , "12345oC", 1  , 16
	movlw	10
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	10
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low SYSSTRINGPARAM1
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM1
	movwf	SysStringB_H
	movlw	low StringTable1
	movwf	SysStringA
	movlw	high StringTable1
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	GLCDFOREGROUND
	clrf	GLCDFOREGROUND_H
	movlw	16
	movwf	SIZE
	pagesel	PRINTDIGITAL
	call	PRINTDIGITAL
	pagesel	$
;PrintDigital 10 , 60 , "12345oC", 1  ,
;PrintDigital 10 , 120 , "12345oC", 1  , 38
;PrintDigital 10 , 190 , "12345oC", 1  , 40
;Do Forever
SysDoLoop_S1
;Loop
	goto	SysDoLoop_S1
SysDoLoop_E1
;#define DigitalVerySmallSize 1   '8-10
;#define DigitalSmallSize  2      '12-16
;#define DigitalMediumSize 3      '18-24
;#define DigitalLargeSize 4       '26-32
;#define DigitalXLargeSize 5      '34-40
;#define DigitalXXLargeSize 6     '42-48
;#define DigitalXXXLargeSize 7    '72
;#define KS0108ReadDelay   9     ; 2 normal usage, 3 for 32 mhz!
;#define KS0108WriteDelay  1     ; 1 normal usage, 0 works
;#define KS0108ClockDelay  1     ; 1 normal usage, 0 works
;#define GLCDDirection     0     ; 0 normal mode
;#define InitGLCD_ILI9341 nop
;#define ST7920ReadDelay = 20
;#define ST7920WriteDelay = 2
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

;********************************************************************************

DIGITAL7_22
	movf	SYSSTRINGA,W
	movwf	SysWORDTempA
	movf	SYSSTRINGA_H,W
	movwf	SysWORDTempA_H
	movlw	47
	movwf	SysWORDTempB
	movlw	3
	movwf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	retlw	0
	movf	SysStringA, W
	addlw	low TableDIGITAL7_22
	movwf	SysStringA
	movlw	high TableDIGITAL7_22
	btfsc	STATUS, C
	addlw	1
	addwf	SysStringA_H, W
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableDIGITAL7_22
	retlw	46
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	24
	retlw	24
	retlw	24
	retlw	255
	retlw	255
	retlw	24
	retlw	24
	retlw	24
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	192
	retlw	192
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	160
	retlw	127
	retlw	224
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	128
	retlw	32
	retlw	0
	retlw	0
	retlw	128
	retlw	32
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	127
	retlw	224
	retlw	255
	retlw	160
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	64
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	64
	retlw	0
	retlw	64
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	64
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	160
	retlw	127
	retlw	224
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	32
	retlw	127
	retlw	192
	retlw	255
	retlw	192
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	127
	retlw	128
	retlw	255
	retlw	192
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	160
	retlw	127
	retlw	224
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	32
	retlw	63
	retlw	192
	retlw	63
	retlw	224
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	127
	retlw	224
	retlw	255
	retlw	160
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	128
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	128
	retlw	32
	retlw	127
	retlw	192
	retlw	127
	retlw	224
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	32
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	192
	retlw	127
	retlw	128
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	128
	retlw	0
	retlw	127
	retlw	192
	retlw	127
	retlw	224
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	127
	retlw	224
	retlw	255
	retlw	160
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	192
	retlw	127
	retlw	128
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	128
	retlw	0
	retlw	127
	retlw	192
	retlw	255
	retlw	224
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	127
	retlw	224
	retlw	255
	retlw	160
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	160
	retlw	127
	retlw	224
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	128
	retlw	32
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	32
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	160
	retlw	127
	retlw	224
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	128
	retlw	32
	retlw	127
	retlw	192
	retlw	255
	retlw	224
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	127
	retlw	224
	retlw	255
	retlw	160
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	160
	retlw	127
	retlw	224
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	128
	retlw	32
	retlw	127
	retlw	192
	retlw	127
	retlw	224
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	127
	retlw	224
	retlw	255
	retlw	160
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	127
	retlw	192
	retlw	127
	retlw	192
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	128
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	127
	retlw	128
	retlw	255
	retlw	192
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	127
	retlw	192
	retlw	127
	retlw	192
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	128
	retlw	0
	retlw	127
	retlw	128
	retlw	255
	retlw	128
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	128
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	128
	retlw	32
	retlw	255
	retlw	192
	retlw	255
	retlw	224
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	128
	retlw	32
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	64
	retlw	127
	retlw	192
	retlw	192
	retlw	192
	retlw	204
	retlw	192
	retlw	204
	retlw	192
	retlw	204
	retlw	192
	retlw	204
	retlw	192
	retlw	204
	retlw	192
	retlw	140
	retlw	64
	retlw	0
	retlw	0
	retlw	128
	retlw	64
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	128
	retlw	64
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	63
	retlw	128
	retlw	63
	retlw	192
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	128
	retlw	32
	retlw	0
	retlw	0
	retlw	128
	retlw	32
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	63
	retlw	192
	retlw	63
	retlw	128
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	192
	retlw	254
	retlw	192
	retlw	1
	retlw	192
	retlw	1
	retlw	128
	retlw	3
	retlw	128
	retlw	3
	retlw	0
	retlw	7
	retlw	0
	retlw	6
	retlw	0
	retlw	6
	retlw	0
	retlw	0
	retlw	0
	retlw	24
	retlw	0
	retlw	24
	retlw	0
	retlw	56
	retlw	0
	retlw	48
	retlw	0
	retlw	112
	retlw	0
	retlw	96
	retlw	0
	retlw	224
	retlw	0
	retlw	223
	retlw	128
	retlw	255
	retlw	128
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	160
	retlw	127
	retlw	224
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	128
	retlw	32
	retlw	127
	retlw	192
	retlw	255
	retlw	224

;********************************************************************************

DIGITAL7_DESCRIPTORS
	movf	SYSSTRINGA,W
	movwf	SysWORDTempA
	movf	SYSSTRINGA_H,W
	movwf	SysWORDTempA_H
	movlw	245
	movwf	SysWORDTempB
	movlw	3
	movwf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	retlw	0
	movf	SysStringA, W
	addlw	low TableDIGITAL7_DESCRIPTORS
	movwf	SysStringA
	movlw	high TableDIGITAL7_DESCRIPTORS
	btfsc	STATUS, C
	addlw	1
	addwf	SysStringA_H, W
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableDIGITAL7_DESCRIPTORS
	retlw	244
	retlw	2
	retlw	0
	retlw	3
	retlw	8
	retlw	1
	retlw	16
	retlw	4
	retlw	24
	retlw	1
	retlw	32
	retlw	4
	retlw	40
	retlw	1
	retlw	48
	retlw	4
	retlw	56
	retlw	4
	retlw	64
	retlw	4
	retlw	72
	retlw	4
	retlw	80
	retlw	4
	retlw	88
	retlw	4
	retlw	96
	retlw	4
	retlw	104
	retlw	4
	retlw	112
	retlw	4
	retlw	120
	retlw	4
	retlw	128
	retlw	4
	retlw	136
	retlw	5
	retlw	144
	retlw	4
	retlw	152
	retlw	4
	retlw	160
	retlw	4
	retlw	168
	retlw	4
	retlw	175
	retlw	2
	retlw	0
	retlw	5
	retlw	10
	retlw	1
	retlw	20
	retlw	4
	retlw	30
	retlw	1
	retlw	40
	retlw	5
	retlw	50
	retlw	1
	retlw	60
	retlw	5
	retlw	70
	retlw	5
	retlw	80
	retlw	5
	retlw	90
	retlw	5
	retlw	100
	retlw	5
	retlw	110
	retlw	5
	retlw	120
	retlw	5
	retlw	130
	retlw	5
	retlw	140
	retlw	4
	retlw	150
	retlw	5
	retlw	160
	retlw	5
	retlw	170
	retlw	5
	retlw	180
	retlw	5
	retlw	190
	retlw	5
	retlw	200
	retlw	5
	retlw	210
	retlw	5
	retlw	215
	retlw	2
	retlw	0
	retlw	5
	retlw	12
	retlw	1
	retlw	24
	retlw	5
	retlw	36
	retlw	1
	retlw	48
	retlw	6
	retlw	60
	retlw	1
	retlw	72
	retlw	6
	retlw	84
	retlw	6
	retlw	96
	retlw	6
	retlw	108
	retlw	6
	retlw	120
	retlw	6
	retlw	132
	retlw	6
	retlw	144
	retlw	6
	retlw	156
	retlw	6
	retlw	168
	retlw	5
	retlw	180
	retlw	5
	retlw	192
	retlw	6
	retlw	204
	retlw	5
	retlw	216
	retlw	6
	retlw	228
	retlw	6
	retlw	240
	retlw	6
	retlw	252
	retlw	4
	retlw	1
	retlw	2
	retlw	0
	retlw	5
	retlw	14
	retlw	1
	retlw	28
	retlw	6
	retlw	42
	retlw	1
	retlw	56
	retlw	7
	retlw	70
	retlw	1
	retlw	84
	retlw	7
	retlw	98
	retlw	7
	retlw	112
	retlw	7
	retlw	126
	retlw	7
	retlw	140
	retlw	7
	retlw	154
	retlw	7
	retlw	168
	retlw	7
	retlw	182
	retlw	7
	retlw	196
	retlw	6
	retlw	210
	retlw	6
	retlw	224
	retlw	7
	retlw	238
	retlw	7
	retlw	252
	retlw	7
	retlw	10
	retlw	7
	retlw	24
	retlw	7
	retlw	38
	retlw	7
	retlw	45
	retlw	2
	retlw	0
	retlw	6
	retlw	16
	retlw	2
	retlw	32
	retlw	6
	retlw	48
	retlw	2
	retlw	64
	retlw	8
	retlw	80
	retlw	2
	retlw	96
	retlw	8
	retlw	112
	retlw	8
	retlw	128
	retlw	8
	retlw	144
	retlw	8
	retlw	160
	retlw	8
	retlw	176
	retlw	8
	retlw	192
	retlw	8
	retlw	208
	retlw	8
	retlw	224
	retlw	8
	retlw	240
	retlw	7
	retlw	0
	retlw	8
	retlw	16
	retlw	8
	retlw	32
	retlw	8
	retlw	48
	retlw	8
	retlw	64
	retlw	8
	retlw	80
	retlw	8
	retlw	88
	retlw	2
	retlw	0
	retlw	6
	retlw	19
	retlw	2
	retlw	38
	retlw	6
	retlw	57
	retlw	2
	retlw	76
	retlw	10
	retlw	95
	retlw	2
	retlw	133
	retlw	10
	retlw	152
	retlw	9
	retlw	190
	retlw	10
	retlw	228
	retlw	10
	retlw	10
	retlw	10
	retlw	48
	retlw	10
	retlw	86
	retlw	10
	retlw	124
	retlw	10
	retlw	162
	retlw	8
	retlw	200
	retlw	8
	retlw	219
	retlw	10
	retlw	238
	retlw	10
	retlw	20
	retlw	10
	retlw	58
	retlw	9
	retlw	96
	retlw	10
	retlw	134
	retlw	10
	retlw	151
	retlw	2
	retlw	0
	retlw	8
	retlw	21
	retlw	2
	retlw	42
	retlw	7
	retlw	63
	retlw	2
	retlw	84
	retlw	11
	retlw	105
	retlw	2
	retlw	147
	retlw	11
	retlw	168
	retlw	10
	retlw	210
	retlw	11
	retlw	252
	retlw	11
	retlw	38
	retlw	11
	retlw	80
	retlw	11
	retlw	122
	retlw	11
	retlw	164
	retlw	11
	retlw	206
	retlw	9
	retlw	248
	retlw	9
	retlw	34
	retlw	11
	retlw	76
	retlw	10
	retlw	118
	retlw	11
	retlw	160
	retlw	9
	retlw	202
	retlw	11
	retlw	244
	retlw	11
	retlw	7
	retlw	2
	retlw	0
	retlw	8
	retlw	22
	retlw	2
	retlw	44
	retlw	8
	retlw	66
	retlw	2
	retlw	88
	retlw	11
	retlw	110
	retlw	2
	retlw	154
	retlw	11
	retlw	176
	retlw	11
	retlw	220
	retlw	11
	retlw	8
	retlw	11
	retlw	52
	retlw	11
	retlw	96
	retlw	11
	retlw	140
	retlw	11
	retlw	184
	retlw	11
	retlw	228
	retlw	10
	retlw	16
	retlw	10
	retlw	60
	retlw	11
	retlw	104
	retlw	10
	retlw	148
	retlw	11
	retlw	192
	retlw	10
	retlw	236
	retlw	11
	retlw	24
	retlw	11
	retlw	45
	retlw	2
	retlw	0
	retlw	8
	retlw	24
	retlw	2
	retlw	48
	retlw	9
	retlw	72
	retlw	2
	retlw	120
	retlw	12
	retlw	144
	retlw	2
	retlw	192
	retlw	12
	retlw	216
	retlw	11
	retlw	8
	retlw	12
	retlw	56
	retlw	12
	retlw	104
	retlw	12
	retlw	152
	retlw	12
	retlw	200
	retlw	12
	retlw	248
	retlw	12
	retlw	40
	retlw	11
	retlw	88
	retlw	10
	retlw	136
	retlw	12
	retlw	184
	retlw	12
	retlw	232
	retlw	12
	retlw	24
	retlw	12
	retlw	72
	retlw	12
	retlw	120
	retlw	12
	retlw	144
	retlw	2
	retlw	0
	retlw	11
	retlw	27
	retlw	3
	retlw	81
	retlw	10
	retlw	108
	retlw	3
	retlw	162
	retlw	13
	retlw	189
	retlw	3
	retlw	243
	retlw	13
	retlw	14
	retlw	14
	retlw	68
	retlw	13
	retlw	122
	retlw	13
	retlw	176
	retlw	13
	retlw	230
	retlw	13
	retlw	28
	retlw	13
	retlw	82
	retlw	13
	retlw	136
	retlw	13
	retlw	190
	retlw	13
	retlw	244
	retlw	13
	retlw	42
	retlw	13
	retlw	96
	retlw	13
	retlw	150
	retlw	13
	retlw	204
	retlw	13
	retlw	2
	retlw	13
	retlw	27
	retlw	2
	retlw	0
	retlw	11
	retlw	28
	retlw	3
	retlw	84
	retlw	11
	retlw	112
	retlw	3
	retlw	168
	retlw	14
	retlw	196
	retlw	3
	retlw	252
	retlw	14
	retlw	24
	retlw	14
	retlw	80
	retlw	14
	retlw	136
	retlw	14
	retlw	192
	retlw	14
	retlw	248
	retlw	14
	retlw	48
	retlw	14
	retlw	104
	retlw	14
	retlw	160
	retlw	13
	retlw	216
	retlw	13
	retlw	16
	retlw	14
	retlw	72
	retlw	15
	retlw	128
	retlw	14
	retlw	184
	retlw	14
	retlw	240
	retlw	14
	retlw	40
	retlw	14
	retlw	65
	retlw	2
	retlw	0
	retlw	13
	retlw	30
	retlw	3
	retlw	90
	retlw	12
	retlw	120
	retlw	3
	retlw	180
	retlw	15
	retlw	210
	retlw	3
	retlw	14
	retlw	15
	retlw	44
	retlw	15
	retlw	104
	retlw	15
	retlw	164
	retlw	15
	retlw	224
	retlw	15
	retlw	28
	retlw	15
	retlw	88
	retlw	15
	retlw	148
	retlw	15
	retlw	208
	retlw	14
	retlw	12
	retlw	14
	retlw	72
	retlw	15
	retlw	132
	retlw	15
	retlw	192
	retlw	15
	retlw	252
	retlw	15
	retlw	56
	retlw	15
	retlw	116
	retlw	15
	retlw	144
	retlw	2
	retlw	0
	retlw	13
	retlw	33
	retlw	3
	retlw	99
	retlw	13
	retlw	132
	retlw	3
	retlw	198
	retlw	16
	retlw	231
	retlw	3
	retlw	41
	retlw	16
	retlw	74
	retlw	16
	retlw	140
	retlw	16
	retlw	206
	retlw	16
	retlw	16
	retlw	16
	retlw	82
	retlw	16
	retlw	148
	retlw	16
	retlw	214
	retlw	16
	retlw	24
	retlw	15
	retlw	90
	retlw	15
	retlw	156
	retlw	16
	retlw	222
	retlw	17
	retlw	32
	retlw	16
	retlw	131
	retlw	16
	retlw	197
	retlw	16
	retlw	7
	retlw	16
	retlw	36
	retlw	2
	retlw	0
	retlw	13
	retlw	34
	retlw	3
	retlw	102
	retlw	14
	retlw	136
	retlw	3
	retlw	204
	retlw	17
	retlw	238
	retlw	3
	retlw	84
	retlw	17
	retlw	118
	retlw	17
	retlw	220
	retlw	17
	retlw	66
	retlw	17
	retlw	168
	retlw	17
	retlw	14
	retlw	17
	retlw	116
	retlw	17
	retlw	218
	retlw	17
	retlw	64
	retlw	15
	retlw	166
	retlw	15
	retlw	234
	retlw	17
	retlw	46
	retlw	17
	retlw	148
	retlw	17
	retlw	250
	retlw	17
	retlw	96
	retlw	17
	retlw	198
	retlw	17
	retlw	246
	retlw	2
	retlw	0
	retlw	15
	retlw	37
	retlw	3
	retlw	111
	retlw	15
	retlw	148
	retlw	3
	retlw	222
	retlw	18
	retlw	3
	retlw	3
	retlw	114
	retlw	18
	retlw	151
	retlw	19
	retlw	6
	retlw	18
	retlw	117
	retlw	18
	retlw	228
	retlw	18
	retlw	83
	retlw	18
	retlw	194
	retlw	18
	retlw	49
	retlw	18
	retlw	160
	retlw	17
	retlw	15
	retlw	17
	retlw	126
	retlw	18
	retlw	237
	retlw	17
	retlw	92
	retlw	18
	retlw	203
	retlw	18
	retlw	58
	retlw	18
	retlw	169
	retlw	18
	retlw	223
	retlw	2
	retlw	0
	retlw	16
	retlw	40
	retlw	4
	retlw	120
	retlw	15
	retlw	160
	retlw	4
	retlw	240
	retlw	20
	retlw	24
	retlw	4
	retlw	144
	retlw	20
	retlw	184
	retlw	20
	retlw	48
	retlw	20
	retlw	168
	retlw	20
	retlw	32
	retlw	20
	retlw	152
	retlw	20
	retlw	16
	retlw	20
	retlw	136
	retlw	20
	retlw	0
	retlw	18
	retlw	120
	retlw	18
	retlw	240
	retlw	20
	retlw	104
	retlw	20
	retlw	224
	retlw	20
	retlw	88
	retlw	20
	retlw	208
	retlw	20
	retlw	72
	retlw	20
	retlw	126
	retlw	2
	retlw	0
	retlw	16
	retlw	41
	retlw	4
	retlw	123
	retlw	15
	retlw	164
	retlw	4
	retlw	246
	retlw	21
	retlw	31
	retlw	4
	retlw	154
	retlw	21
	retlw	195
	retlw	20
	retlw	62
	retlw	21
	retlw	185
	retlw	21
	retlw	52
	retlw	21
	retlw	175
	retlw	21
	retlw	42
	retlw	21
	retlw	165
	retlw	21
	retlw	32
	retlw	19
	retlw	155
	retlw	19
	retlw	22
	retlw	21
	retlw	145
	retlw	20
	retlw	12
	retlw	21
	retlw	135
	retlw	20
	retlw	2
	retlw	21
	retlw	125
	retlw	21
	retlw	182
	retlw	2
	retlw	0
	retlw	16
	retlw	43
	retlw	4
	retlw	129
	retlw	16
	retlw	172
	retlw	4
	retlw	2
	retlw	21
	retlw	45
	retlw	4
	retlw	174
	retlw	21
	retlw	217
	retlw	21
	retlw	90
	retlw	21
	retlw	219
	retlw	21
	retlw	92
	retlw	21
	retlw	221
	retlw	21
	retlw	94
	retlw	21
	retlw	223
	retlw	21
	retlw	96
	retlw	19
	retlw	225
	retlw	19
	retlw	98
	retlw	21
	retlw	227
	retlw	22
	retlw	100
	retlw	21
	retlw	229
	retlw	21
	retlw	102
	retlw	21
	retlw	231
	retlw	21
	retlw	35
	retlw	2
	retlw	0
	retlw	16
	retlw	45
	retlw	4
	retlw	135
	retlw	17
	retlw	180
	retlw	4
	retlw	59
	retlw	22
	retlw	104
	retlw	4
	retlw	239
	retlw	22
	retlw	28
	retlw	22
	retlw	163
	retlw	22
	retlw	42
	retlw	22
	retlw	177
	retlw	22
	retlw	56
	retlw	22
	retlw	191
	retlw	22
	retlw	70
	retlw	22
	retlw	205
	retlw	20
	retlw	84
	retlw	20
	retlw	219
	retlw	22
	retlw	98
	retlw	22
	retlw	233
	retlw	22
	retlw	112
	retlw	22
	retlw	247
	retlw	22
	retlw	126
	retlw	22
	retlw	189
	retlw	2
	retlw	0
	retlw	18
	retlw	46
	retlw	4
	retlw	184
	retlw	18
	retlw	230
	retlw	4
	retlw	112
	retlw	23
	retlw	158
	retlw	4
	retlw	40
	retlw	23
	retlw	86
	retlw	23
	retlw	224
	retlw	23
	retlw	106
	retlw	23
	retlw	244
	retlw	23
	retlw	126
	retlw	23
	retlw	8
	retlw	23
	retlw	146
	retlw	23
	retlw	28
	retlw	21
	retlw	166
	retlw	21
	retlw	48
	retlw	23
	retlw	186
	retlw	22
	retlw	68
	retlw	23
	retlw	206
	retlw	23
	retlw	88
	retlw	23
	retlw	229
	retlw	23
	retlw	39
	retlw	2
	retlw	0
	retlw	21
	retlw	49
	retlw	5
	retlw	196
	retlw	20
	retlw	245
	retlw	5
	retlw	136
	retlw	25
	retlw	185
	retlw	5
	retlw	125
	retlw	25
	retlw	174
	retlw	25
	retlw	114
	retlw	25
	retlw	54
	retlw	25
	retlw	250
	retlw	25
	retlw	190
	retlw	25
	retlw	130
	retlw	25
	retlw	70
	retlw	25
	retlw	10
	retlw	22
	retlw	206
	retlw	22
	retlw	97
	retlw	25
	retlw	244
	retlw	25
	retlw	184
	retlw	25
	retlw	124
	retlw	24
	retlw	64
	retlw	25
	retlw	211
	retlw	25
	retlw	43
	retlw	2
	retlw	0
	retlw	29
	retlw	73
	retlw	7
	retlw	109
	retlw	30
	retlw	182
	retlw	7
	retlw	218
	retlw	37
	retlw	35
	retlw	7
	retlw	144
	retlw	37
	retlw	217
	retlw	36
	retlw	70
	retlw	37
	retlw	179
	retlw	37
	retlw	32
	retlw	37
	retlw	141
	retlw	37
	retlw	250
	retlw	37
	retlw	103
	retlw	37
	retlw	212
	retlw	33
	retlw	65
	retlw	33
	retlw	174
	retlw	37
	retlw	27
	retlw	37
	retlw	136
	retlw	37
	retlw	245
	retlw	37
	retlw	98
	retlw	37
	retlw	207
	retlw	37
	retlw	111

;********************************************************************************

DIGITALINIT
;DigitalDefaultSize=12
	movlw	12
	movwf	DIGITALDEFAULTSIZE
	return

;********************************************************************************

INITGLCD_KS0108
;Dir GLCD_RS Out
	banksel	TRISB
	bcf	TRISB,0
;Dir GLCD_RW Out
	bcf	TRISB,1
;Dir GLCD_ENABLE Out
	bcf	TRISB,2
;Dir GLCD_CS1 Out
	bcf	TRISB,3
;Dir GLCD_CS2 Out
	bcf	TRISB,4
;Dir GLCD_RESET Out
	bcf	TRISB,5
;Set GLCD_RESET Off
	banksel	PORTB
	bcf	PORTB,5
;Wait 1 ms
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;Set GLCD_RESET On
	bsf	PORTB,5
;Wait 1 ms
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;Set GLCD_CS1 On
	bsf	PORTB,3
;Set GLCD_CS2 On
	bsf	PORTB,4
;Set GLCD_RS Off
	bcf	PORTB,0
;GLCDWriteByte 63
	movlw	63
	movwf	LCDBYTE
	pagesel	GLCDWRITEBYTE_KS0108
	call	GLCDWRITEBYTE_KS0108
	pagesel	$
;GLCDWriteByte 192
	movlw	192
	movwf	LCDBYTE
	pagesel	GLCDWRITEBYTE_KS0108
	call	GLCDWRITEBYTE_KS0108
	pagesel	$
;Set GLCD_CS1 Off
	bcf	PORTB,3
;Set GLCD_CS2 Off
	bcf	PORTB,4
;GLCDBackground = 0
	clrf	GLCDBACKGROUND
	clrf	GLCDBACKGROUND_H
;GLCDForeground = 1
	movlw	1
	movwf	GLCDFOREGROUND
	clrf	GLCDFOREGROUND_H
;GLCDFontWidth = 6
	movlw	6
	movwf	GLCDFONTWIDTH
	clrf	GLCDFONTWIDTH_H
;GLCDfntDefault = 0
	clrf	GLCDFNTDEFAULT
;GLCDfntDefaultsize = 1
	movlw	1
	movwf	GLCDFNTDEFAULTSIZE
;GLCDCLS_KS0108
	pagesel	GLCDCLS_KS0108
	goto	GLCDCLS_KS0108

;********************************************************************************

SYSMULTSUB16
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
MUL16LOOP
;IF SysDivMultB.0 ON then SysDivMultX += SysDivMultA
	btfss	SYSDIVMULTB,0
	goto	ENDIF41
	movf	SYSDIVMULTA,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTA_H,W
	btfsc	STATUS,C
	addlw	1
	addwf	SYSDIVMULTX_H,F
ENDIF41
;set STATUS.C OFF
	bcf	STATUS,C
;rotate SysDivMultB right
	rrf	SYSDIVMULTB_H,F
	rrf	SYSDIVMULTB,F
;set STATUS.C off
	bcf	STATUS,C
;rotate SysDivMultA left
	rlf	SYSDIVMULTA,F
	rlf	SYSDIVMULTA_H,F
;if SysDivMultB > 0 then goto MUL16LOOP
	movf	SYSDIVMULTB,W
	movwf	SysWORDTempB
	movf	SYSDIVMULTB_H,W
	movwf	SysWORDTempB_H
	clrf	SysWORDTempA
	clrf	SysWORDTempA_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	MUL16LOOP
;SysWordTempX = SysDivMultX
	movf	SYSDIVMULTX,W
	movwf	SYSWORDTEMPX
	movf	SYSDIVMULTX_H,W
	movwf	SYSWORDTEMPX_H
	return

;********************************************************************************

;Start of program memory page 1
	ORG	2048
DIGITAL7_24
	movf	SYSSTRINGA,W
	movwf	SysWORDTempA
	movf	SYSSTRINGA_H,W
	movwf	SysWORDTempA_H
	movlw	145
	movwf	SysWORDTempB
	movlw	3
	movwf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	retlw	0
	movf	SysStringA, W
	addlw	low TableDIGITAL7_24
	movwf	SysStringA
	movlw	high TableDIGITAL7_24
	btfsc	STATUS, C
	addlw	1
	addwf	SysStringA_H, W
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableDIGITAL7_24
	retlw	144
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	24
	retlw	24
	retlw	24
	retlw	255
	retlw	255
	retlw	24
	retlw	24
	retlw	24
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	128
	retlw	255
	retlw	128
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	192
	retlw	192
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	240
	retlw	127
	retlw	240
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	128
	retlw	16
	retlw	0
	retlw	0
	retlw	128
	retlw	16
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	255
	retlw	240
	retlw	255
	retlw	240
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	64
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	64
	retlw	0
	retlw	64
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	64
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	240
	retlw	127
	retlw	240
	retlw	0
	retlw	48
	retlw	0
	retlw	48
	retlw	0
	retlw	48
	retlw	0
	retlw	48
	retlw	0
	retlw	48
	retlw	0
	retlw	48
	retlw	0
	retlw	48
	retlw	0
	retlw	16
	retlw	127
	retlw	224
	retlw	255
	retlw	224
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	255
	retlw	192
	retlw	255
	retlw	224
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	224
	retlw	255
	retlw	224
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	32
	retlw	127
	retlw	192
	retlw	127
	retlw	224
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	255
	retlw	224
	retlw	255
	retlw	224
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	16
	retlw	128
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	128
	retlw	16
	retlw	127
	retlw	224
	retlw	127
	retlw	240
	retlw	0
	retlw	48
	retlw	0
	retlw	48
	retlw	0
	retlw	48
	retlw	0
	retlw	48
	retlw	0
	retlw	48
	retlw	0
	retlw	48
	retlw	0
	retlw	48
	retlw	0
	retlw	48
	retlw	0
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	224
	retlw	127
	retlw	192
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	128
	retlw	0
	retlw	127
	retlw	224
	retlw	127
	retlw	240
	retlw	0
	retlw	48
	retlw	0
	retlw	48
	retlw	0
	retlw	48
	retlw	0
	retlw	48
	retlw	0
	retlw	48
	retlw	0
	retlw	48
	retlw	0
	retlw	48
	retlw	127
	retlw	240
	retlw	255
	retlw	240
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	224
	retlw	127
	retlw	192
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	128
	retlw	0
	retlw	127
	retlw	224
	retlw	255
	retlw	240
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	255
	retlw	240
	retlw	255
	retlw	240
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	240
	retlw	127
	retlw	240
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	128
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	16
	retlw	0
	retlw	48
	retlw	0
	retlw	48
	retlw	0
	retlw	48
	retlw	0
	retlw	48
	retlw	0
	retlw	48
	retlw	0
	retlw	48
	retlw	0
	retlw	48
	retlw	0
	retlw	48
	retlw	0
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	240
	retlw	127
	retlw	240
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	128
	retlw	16
	retlw	127
	retlw	224
	retlw	255
	retlw	240
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	255
	retlw	240
	retlw	255
	retlw	240
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	240
	retlw	127
	retlw	240
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	128
	retlw	16
	retlw	127
	retlw	224
	retlw	127
	retlw	240
	retlw	0
	retlw	48
	retlw	0
	retlw	48
	retlw	0
	retlw	48
	retlw	0
	retlw	48
	retlw	0
	retlw	48
	retlw	0
	retlw	48
	retlw	0
	retlw	48
	retlw	127
	retlw	240
	retlw	255
	retlw	240
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	192
	retlw	255
	retlw	192
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	128
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	255
	retlw	192
	retlw	255
	retlw	224
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	192
	retlw	255
	retlw	192
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	128
	retlw	0
	retlw	127
	retlw	192
	retlw	255
	retlw	192
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	128
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	16
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	128
	retlw	16
	retlw	255
	retlw	224
	retlw	255
	retlw	240
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	128
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	240
	retlw	127
	retlw	240
	retlw	192
	retlw	48
	retlw	198
	retlw	48
	retlw	198
	retlw	48
	retlw	198
	retlw	48
	retlw	198
	retlw	48
	retlw	198
	retlw	48
	retlw	198
	retlw	48
	retlw	134
	retlw	16
	retlw	0
	retlw	0
	retlw	128
	retlw	16
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	128
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	31
	retlw	192
	retlw	31
	retlw	192
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	128
	retlw	16
	retlw	0
	retlw	0
	retlw	128
	retlw	16
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	31
	retlw	224
	retlw	31
	retlw	192
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	224
	retlw	255
	retlw	112
	retlw	0
	retlw	224
	retlw	0
	retlw	224
	retlw	1
	retlw	192
	retlw	1
	retlw	192
	retlw	3
	retlw	128
	retlw	3
	retlw	128
	retlw	3
	retlw	0
	retlw	3
	retlw	0
	retlw	0
	retlw	0
	retlw	12
	retlw	0
	retlw	28
	retlw	0
	retlw	24
	retlw	0
	retlw	56
	retlw	0
	retlw	48
	retlw	0
	retlw	112
	retlw	0
	retlw	96
	retlw	0
	retlw	224
	retlw	0
	retlw	255
	retlw	192
	retlw	255
	retlw	192
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	240
	retlw	127
	retlw	240
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	192
	retlw	48
	retlw	128
	retlw	16
	retlw	127
	retlw	224
	retlw	255
	retlw	240

;********************************************************************************

DIGITAL7_DESCRIPTORS_H
	movf	SYSSTRINGA,W
	movwf	SysWORDTempA
	movf	SYSSTRINGA_H,W
	movwf	SysWORDTempA_H
	movlw	245
	movwf	SysWORDTempB
	movlw	3
	movwf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	retlw	0
	movf	SysStringA, W
	addlw	low TableDIGITAL7_DESCRIPTORS_H
	movwf	SysStringA
	movlw	high TableDIGITAL7_DESCRIPTORS_H
	btfsc	STATUS, C
	addlw	1
	addwf	SysStringA_H, W
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableDIGITAL7_DESCRIPTORS_H
	retlw	3
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	3
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	3
	retlw	0
	retlw	3
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	3
	retlw	0
	retlw	3
	retlw	0
	retlw	3
	retlw	0
	retlw	3
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	3
	retlw	0
	retlw	3
	retlw	0
	retlw	3
	retlw	0
	retlw	3
	retlw	0
	retlw	4
	retlw	0
	retlw	4
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	3
	retlw	0
	retlw	3
	retlw	0
	retlw	3
	retlw	0
	retlw	3
	retlw	0
	retlw	3
	retlw	0
	retlw	4
	retlw	0
	retlw	4
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	3
	retlw	0
	retlw	3
	retlw	0
	retlw	3
	retlw	0
	retlw	3
	retlw	0
	retlw	3
	retlw	0
	retlw	4
	retlw	0
	retlw	4
	retlw	0
	retlw	4
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	3
	retlw	0
	retlw	3
	retlw	0
	retlw	3
	retlw	0
	retlw	3
	retlw	0
	retlw	4
	retlw	0
	retlw	4
	retlw	0
	retlw	4
	retlw	0
	retlw	5
	retlw	0
	retlw	5
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	3
	retlw	0
	retlw	3
	retlw	0
	retlw	3
	retlw	0
	retlw	4
	retlw	0
	retlw	4
	retlw	0
	retlw	4
	retlw	0
	retlw	5
	retlw	0
	retlw	5
	retlw	0
	retlw	5
	retlw	0
	retlw	6
	retlw	0
	retlw	6
	retlw	0
	retlw	6
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	3
	retlw	0
	retlw	3
	retlw	0
	retlw	4
	retlw	0
	retlw	4
	retlw	0
	retlw	5
	retlw	0
	retlw	5
	retlw	0
	retlw	5
	retlw	0
	retlw	6
	retlw	0
	retlw	6
	retlw	0
	retlw	7
	retlw	0
	retlw	7
	retlw	0
	retlw	7
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	3
	retlw	0
	retlw	3
	retlw	0
	retlw	4
	retlw	0
	retlw	4
	retlw	0
	retlw	5
	retlw	0
	retlw	5
	retlw	0
	retlw	5
	retlw	0
	retlw	6
	retlw	0
	retlw	6
	retlw	0
	retlw	7
	retlw	0
	retlw	7
	retlw	0
	retlw	8
	retlw	0
	retlw	8
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	3
	retlw	0
	retlw	3
	retlw	0
	retlw	4
	retlw	0
	retlw	4
	retlw	0
	retlw	5
	retlw	0
	retlw	5
	retlw	0
	retlw	6
	retlw	0
	retlw	6
	retlw	0
	retlw	7
	retlw	0
	retlw	7
	retlw	0
	retlw	8
	retlw	0
	retlw	8
	retlw	0
	retlw	8
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	3
	retlw	0
	retlw	3
	retlw	0
	retlw	4
	retlw	0
	retlw	4
	retlw	0
	retlw	5
	retlw	0
	retlw	5
	retlw	0
	retlw	6
	retlw	0
	retlw	6
	retlw	0
	retlw	7
	retlw	0
	retlw	7
	retlw	0
	retlw	8
	retlw	0
	retlw	8
	retlw	0
	retlw	9
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	3
	retlw	0
	retlw	3
	retlw	0
	retlw	4
	retlw	0
	retlw	4
	retlw	0
	retlw	5
	retlw	0
	retlw	5
	retlw	0
	retlw	6
	retlw	0
	retlw	6
	retlw	0
	retlw	7
	retlw	0
	retlw	7
	retlw	0
	retlw	8
	retlw	0
	retlw	8
	retlw	0
	retlw	9
	retlw	0
	retlw	9
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	3
	retlw	0
	retlw	3
	retlw	0
	retlw	4
	retlw	0
	retlw	5
	retlw	0
	retlw	5
	retlw	0
	retlw	6
	retlw	0
	retlw	6
	retlw	0
	retlw	7
	retlw	0
	retlw	7
	retlw	0
	retlw	8
	retlw	0
	retlw	8
	retlw	0
	retlw	9
	retlw	0
	retlw	9
	retlw	0
	retlw	10
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	3
	retlw	0
	retlw	4
	retlw	0
	retlw	4
	retlw	0
	retlw	5
	retlw	0
	retlw	6
	retlw	0
	retlw	7
	retlw	0
	retlw	8
	retlw	0
	retlw	8
	retlw	0
	retlw	9
	retlw	0
	retlw	9
	retlw	0
	retlw	10
	retlw	0
	retlw	11
	retlw	0
	retlw	12
	retlw	0
	retlw	12
	retlw	0
	retlw	13
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	2
	retlw	0
	retlw	3
	retlw	0
	retlw	4
	retlw	0
	retlw	4
	retlw	0
	retlw	6
	retlw	0
	retlw	7
	retlw	0
	retlw	9
	retlw	0
	retlw	10
	retlw	0
	retlw	11
	retlw	0
	retlw	13
	retlw	0
	retlw	14
	retlw	0
	retlw	16
	retlw	0
	retlw	17
	retlw	0
	retlw	19
	retlw	0
	retlw	20
	retlw	0
	retlw	21
	retlw	0
	retlw	23
	retlw	0
	retlw	24
	retlw	0
	retlw	25

;********************************************************************************

Delay_US
	incf	SysWaitTempUS_H, F
	movf	SysWaitTempUS, F
	btfsc	STATUS,Z
	goto	DUS_END
DUS_START
	nop
	decfsz	SysWaitTempUS, F
	goto	DUS_START
DUS_END
	decfsz	SysWaitTempUS_H, F
	goto	DUS_START
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
	retlw	7
	retlw	49	;1
	retlw	50	;2
	retlw	51	;3
	retlw	52	;4
	retlw	53	;5
	retlw	111	;o
	retlw	67	;C


StringTable10
	retlw	1
	retlw	32	; 


StringTable11
	retlw	1
	retlw	43	;+


StringTable12
	retlw	1
	retlw	44	;,


StringTable13
	retlw	1
	retlw	45	;-


StringTable14
	retlw	1
	retlw	46	;.


StringTable15
	retlw	1
	retlw	48	;0


StringTable16
	retlw	1
	retlw	49	;1


StringTable17
	retlw	1
	retlw	50	;2


StringTable18
	retlw	1
	retlw	51	;3


StringTable19
	retlw	1
	retlw	52	;4


StringTable20
	retlw	1
	retlw	53	;5


StringTable21
	retlw	1
	retlw	54	;6


StringTable22
	retlw	1
	retlw	55	;7


StringTable23
	retlw	1
	retlw	56	;8


StringTable24
	retlw	1
	retlw	57	;9


StringTable25
	retlw	1
	retlw	67	;C


StringTable26
	retlw	1
	retlw	70	;F


StringTable27
	retlw	1
	retlw	72	;H


StringTable28
	retlw	1
	retlw	77	;M


StringTable29
	retlw	1
	retlw	79	;O


StringTable30
	retlw	1
	retlw	90	;Z


StringTable31
	retlw	1
	retlw	111	;o


;********************************************************************************

;Start of program memory page 2
	ORG	4096
DIGITAL7_18
	movf	SYSSTRINGA,W
	movwf	SysWORDTempA
	movf	SYSSTRINGA_H,W
	movwf	SysWORDTempA_H
	movlw	153
	movwf	SysWORDTempB
	movlw	2
	movwf	SysWORDTempB_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0
	retlw	0
	movf	SysStringA, W
	addlw	low TableDIGITAL7_18
	movwf	SysStringA
	movlw	high TableDIGITAL7_18
	btfsc	STATUS, C
	addlw	1
	addwf	SysStringA_H, W
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableDIGITAL7_18
	retlw	152
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	48
	retlw	48
	retlw	48
	retlw	252
	retlw	252
	retlw	48
	retlw	48
	retlw	48
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	252
	retlw	252
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	192
	retlw	192
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	0
	retlw	127
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	128
	retlw	64
	retlw	128
	retlw	64
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	127
	retlw	192
	retlw	127
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	64
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	64
	retlw	64
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	64
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	0
	retlw	127
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	63
	retlw	64
	retlw	255
	retlw	128
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	127
	retlw	0
	retlw	127
	retlw	128
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	254
	retlw	0
	retlw	255
	retlw	128
	retlw	1
	retlw	128
	retlw	1
	retlw	128
	retlw	1
	retlw	128
	retlw	1
	retlw	128
	retlw	1
	retlw	128
	retlw	126
	retlw	128
	retlw	127
	retlw	128
	retlw	1
	retlw	128
	retlw	1
	retlw	128
	retlw	1
	retlw	128
	retlw	1
	retlw	128
	retlw	1
	retlw	128
	retlw	255
	retlw	128
	retlw	254
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	64
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	191
	retlw	64
	retlw	127
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	64
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	128
	retlw	127
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	191
	retlw	0
	retlw	127
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	127
	retlw	192
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	128
	retlw	127
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	191
	retlw	0
	retlw	255
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	127
	retlw	192
	retlw	127
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	0
	retlw	127
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	128
	retlw	64
	retlw	0
	retlw	64
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	64
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	0
	retlw	127
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	191
	retlw	64
	retlw	255
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	127
	retlw	192
	retlw	127
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	0
	retlw	127
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	191
	retlw	64
	retlw	127
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	127
	retlw	192
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	127
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	128
	retlw	128
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	127
	retlw	127
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	127
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	191
	retlw	255
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	128
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	64
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	191
	retlw	64
	retlw	255
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	128
	retlw	64
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	0
	retlw	127
	retlw	192
	retlw	204
	retlw	192
	retlw	204
	retlw	192
	retlw	204
	retlw	192
	retlw	204
	retlw	192
	retlw	204
	retlw	192
	retlw	140
	retlw	64
	retlw	128
	retlw	64
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	128
	retlw	64
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	63
	retlw	0
	retlw	255
	retlw	0
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	128
	retlw	64
	retlw	128
	retlw	64
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	127
	retlw	128
	retlw	63
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	128
	retlw	125
	retlw	128
	retlw	3
	retlw	0
	retlw	3
	retlw	0
	retlw	6
	retlw	0
	retlw	6
	retlw	0
	retlw	6
	retlw	0
	retlw	4
	retlw	0
	retlw	8
	retlw	0
	retlw	24
	retlw	0
	retlw	48
	retlw	0
	retlw	48
	retlw	0
	retlw	112
	retlw	0
	retlw	96
	retlw	0
	retlw	255
	retlw	0
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	0
	retlw	127
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	191
	retlw	64
	retlw	255
	retlw	192

;********************************************************************************

DIGITAL7_20
	movf	SYSSTRINGA,W
	movwf	SysWORDTempA
	movf	SYSSTRINGA_H,W
	movwf	SysWORDTempA_H
	movlw	9
	movwf	SysWORDTempB
	movlw	3
	movwf	SysWORDTempB_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0
	retlw	0
	movf	SysStringA, W
	addlw	low TableDIGITAL7_20
	movwf	SysStringA
	movlw	high TableDIGITAL7_20
	btfsc	STATUS, C
	addlw	1
	addwf	SysStringA_H, W
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableDIGITAL7_20
	retlw	8
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	24
	retlw	24
	retlw	24
	retlw	255
	retlw	255
	retlw	24
	retlw	24
	retlw	24
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	254
	retlw	254
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	192
	retlw	192
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	160
	retlw	127
	retlw	224
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	128
	retlw	32
	retlw	128
	retlw	32
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	127
	retlw	224
	retlw	255
	retlw	160
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	64
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	64
	retlw	64
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	64
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	160
	retlw	127
	retlw	224
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	63
	retlw	160
	retlw	255
	retlw	192
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	127
	retlw	128
	retlw	255
	retlw	192
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	64
	retlw	255
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	127
	retlw	64
	retlw	127
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	255
	retlw	192
	retlw	255
	retlw	64
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	128
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	191
	retlw	160
	retlw	127
	retlw	224
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	32
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	192
	retlw	127
	retlw	128
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	191
	retlw	128
	retlw	127
	retlw	224
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	127
	retlw	224
	retlw	255
	retlw	160
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	192
	retlw	127
	retlw	128
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	191
	retlw	128
	retlw	255
	retlw	224
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	127
	retlw	224
	retlw	255
	retlw	160
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	160
	retlw	127
	retlw	224
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	128
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	32
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	160
	retlw	127
	retlw	224
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	191
	retlw	160
	retlw	255
	retlw	224
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	127
	retlw	224
	retlw	255
	retlw	160
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	160
	retlw	127
	retlw	224
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	191
	retlw	160
	retlw	127
	retlw	224
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	127
	retlw	224
	retlw	255
	retlw	160
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	127
	retlw	128
	retlw	127
	retlw	128
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	128
	retlw	0
	retlw	128
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	127
	retlw	128
	retlw	255
	retlw	128
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	127
	retlw	128
	retlw	127
	retlw	128
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	191
	retlw	128
	retlw	255
	retlw	128
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	192
	retlw	0
	retlw	128
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	191
	retlw	160
	retlw	255
	retlw	224
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	128
	retlw	32
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	64
	retlw	127
	retlw	192
	retlw	192
	retlw	192
	retlw	204
	retlw	192
	retlw	204
	retlw	192
	retlw	204
	retlw	192
	retlw	204
	retlw	192
	retlw	204
	retlw	192
	retlw	140
	retlw	64
	retlw	128
	retlw	64
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	128
	retlw	64
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	63
	retlw	128
	retlw	63
	retlw	128
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	128
	retlw	32
	retlw	128
	retlw	32
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	127
	retlw	192
	retlw	63
	retlw	128
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	128
	retlw	253
	retlw	128
	retlw	3
	retlw	128
	retlw	3
	retlw	0
	retlw	3
	retlw	0
	retlw	6
	retlw	0
	retlw	6
	retlw	0
	retlw	12
	retlw	0
	retlw	12
	retlw	0
	retlw	24
	retlw	0
	retlw	24
	retlw	0
	retlw	48
	retlw	0
	retlw	48
	retlw	0
	retlw	96
	retlw	0
	retlw	96
	retlw	0
	retlw	192
	retlw	0
	retlw	255
	retlw	0
	retlw	191
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	160
	retlw	127
	retlw	224
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	192
	retlw	96
	retlw	191
	retlw	160
	retlw	255
	retlw	224

;********************************************************************************

DRAWDIGITAL
;CharNum=0
	clrf	CHARNUM
;Select Case CharCode
;Case  " " : CharNum=1
SysSelect1Case1
	movlw	32
	subwf	CHARCODE,W
	btfss	STATUS, Z
	goto	SysSelect1Case2
	movlw	1
	movwf	CHARNUM
;Case  "+" : CharNum=2
	goto	SysSelectEnd1
SysSelect1Case2
	movlw	43
	subwf	CHARCODE,W
	btfss	STATUS, Z
	goto	SysSelect1Case3
	movlw	2
	movwf	CHARNUM
;Case  "," : CharNum=3
	goto	SysSelectEnd1
SysSelect1Case3
	movlw	44
	subwf	CHARCODE,W
	btfss	STATUS, Z
	goto	SysSelect1Case4
	movlw	3
	movwf	CHARNUM
;Case  "-" : CharNum=4
	goto	SysSelectEnd1
SysSelect1Case4
	movlw	45
	subwf	CHARCODE,W
	btfss	STATUS, Z
	goto	SysSelect1Case5
	movlw	4
	movwf	CHARNUM
;Case  "." : CharNum=5
	goto	SysSelectEnd1
SysSelect1Case5
	movlw	46
	subwf	CHARCODE,W
	btfss	STATUS, Z
	goto	SysSelect1Case6
	movlw	5
	movwf	CHARNUM
;Case  "0" : CharNum=6
	goto	SysSelectEnd1
SysSelect1Case6
	movlw	48
	subwf	CHARCODE,W
	btfss	STATUS, Z
	goto	SysSelect1Case7
	movlw	6
	movwf	CHARNUM
;Case  "1" : CharNum=7
	goto	SysSelectEnd1
SysSelect1Case7
	movlw	49
	subwf	CHARCODE,W
	btfss	STATUS, Z
	goto	SysSelect1Case8
	movlw	7
	movwf	CHARNUM
;Case  "2" : CharNum=8
	goto	SysSelectEnd1
SysSelect1Case8
	movlw	50
	subwf	CHARCODE,W
	btfss	STATUS, Z
	goto	SysSelect1Case9
	movlw	8
	movwf	CHARNUM
;Case  "3" : CharNum=9
	goto	SysSelectEnd1
SysSelect1Case9
	movlw	51
	subwf	CHARCODE,W
	btfss	STATUS, Z
	goto	SysSelect1Case10
	movlw	9
	movwf	CHARNUM
;Case  "4" : CharNum=10
	goto	SysSelectEnd1
SysSelect1Case10
	movlw	52
	subwf	CHARCODE,W
	btfss	STATUS, Z
	goto	SysSelect1Case11
	movlw	10
	movwf	CHARNUM
;Case  "5" : CharNum=11
	goto	SysSelectEnd1
SysSelect1Case11
	movlw	53
	subwf	CHARCODE,W
	btfss	STATUS, Z
	goto	SysSelect1Case12
	movlw	11
	movwf	CHARNUM
;Case  "6" : CharNum=12
	goto	SysSelectEnd1
SysSelect1Case12
	movlw	54
	subwf	CHARCODE,W
	btfss	STATUS, Z
	goto	SysSelect1Case13
	movlw	12
	movwf	CHARNUM
;Case  "7" : CharNum=13
	goto	SysSelectEnd1
SysSelect1Case13
	movlw	55
	subwf	CHARCODE,W
	btfss	STATUS, Z
	goto	SysSelect1Case14
	movlw	13
	movwf	CHARNUM
;Case  "8" : CharNum=14
	goto	SysSelectEnd1
SysSelect1Case14
	movlw	56
	subwf	CHARCODE,W
	btfss	STATUS, Z
	goto	SysSelect1Case15
	movlw	14
	movwf	CHARNUM
;Case  "9" : CharNum=15
	goto	SysSelectEnd1
SysSelect1Case15
	movlw	57
	subwf	CHARCODE,W
	btfss	STATUS, Z
	goto	SysSelect1Case16
	movlw	15
	movwf	CHARNUM
;Case  "C" : CharNum=16
	goto	SysSelectEnd1
SysSelect1Case16
	movlw	67
	subwf	CHARCODE,W
	btfss	STATUS, Z
	goto	SysSelect1Case17
	movlw	16
	movwf	CHARNUM
;Case  "F" : CharNum=17
	goto	SysSelectEnd1
SysSelect1Case17
	movlw	70
	subwf	CHARCODE,W
	btfss	STATUS, Z
	goto	SysSelect1Case18
	movlw	17
	movwf	CHARNUM
;Case  "H" : CharNum=18
	goto	SysSelectEnd1
SysSelect1Case18
	movlw	72
	subwf	CHARCODE,W
	btfss	STATUS, Z
	goto	SysSelect1Case19
	movlw	18
	movwf	CHARNUM
;Case  "M" : CharNum=19
	goto	SysSelectEnd1
SysSelect1Case19
	movlw	77
	subwf	CHARCODE,W
	btfss	STATUS, Z
	goto	SysSelect1Case20
	movlw	19
	movwf	CHARNUM
;Case  "O" : CharNum=20
	goto	SysSelectEnd1
SysSelect1Case20
	movlw	79
	subwf	CHARCODE,W
	btfss	STATUS, Z
	goto	SysSelect1Case21
	movlw	20
	movwf	CHARNUM
;Case  "Z" : CharNum=21
	goto	SysSelectEnd1
SysSelect1Case21
	movlw	90
	subwf	CHARCODE,W
	btfss	STATUS, Z
	goto	SysSelect1Case22
	movlw	21
	movwf	CHARNUM
;Case  "o" : CharNum=22
	goto	SysSelectEnd1
SysSelect1Case22
	movlw	111
	subwf	CHARCODE,W
	btfss	STATUS, Z
	goto	SysSelect1Case23
	movlw	22
	movwf	CHARNUM
;End Select
SysSelect1Case23
SysSelectEnd1
;CharDiscr = [Word](Size-8)*23+CharNum*2-1
	movlw	8
	subwf	SIZE,W
	movwf	SysTemp1
	movwf	SysWORDTempA
	clrf	SysWORDTempA_H
	movlw	23
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysMultSub16
	call	SysMultSub16
	pagesel	$
	movf	SysWORDTempX,W
	movwf	SysTemp2
	movf	SysWORDTempX_H,W
	movwf	SysTemp2_H
	bcf	STATUS,C
	rlf	CHARNUM,W
	movwf	SysTemp1
	addwf	SysTemp2,W
	movwf	SysTemp3
	movlw	0
	btfsc	STATUS,C
	addlw	1
	addwf	SysTemp2_H,W
	movwf	SysTemp3_H
	movlw	1
	subwf	SysTemp3,W
	movwf	CHARDISCR
	movlw	0
	btfss	STATUS,C
	addlw	1
	subwf	SysTemp3_H,W
	movwf	CHARDISCR_H
;ReadTable digital7_Descriptors, CharDiscr ,  CharBits
	movf	CHARDISCR,W
	movwf	SysStringA
	movf	CHARDISCR_H,W
	movwf	SysStringA_H
	pagesel	DIGITAL7_DESCRIPTORS
	call	DIGITAL7_DESCRIPTORS
	pagesel	$
	movwf	CHARBITS
;ReadTable digital7_Descriptors, CharDiscr+1,  CharOffSetBegin
	movlw	1
	addwf	CHARDISCR,W
	movwf	SYSSTRINGA
	movlw	0
	btfsc	STATUS,C
	addlw	1
	addwf	CHARDISCR_H,W
	movwf	SYSSTRINGA_H
	pagesel	DIGITAL7_DESCRIPTORS
	call	DIGITAL7_DESCRIPTORS
	pagesel	$
	movwf	CHAROFFSETBEGIN
	movlw	1
	addwf	CHARDISCR,W
	movwf	SYSSTRINGA
	movlw	0
	btfsc	STATUS,C
	addlw	1
	addwf	CHARDISCR_H,W
	movwf	SYSSTRINGA_H
	pagesel	DIGITAL7_DESCRIPTORS_H
	call	DIGITAL7_DESCRIPTORS_H
	pagesel	$
	movwf	CHAROFFSETBEGIN_H
;ReadTable digital7_Descriptors, CharDiscr+3,  CharOffSetEnd
	movlw	3
	addwf	CHARDISCR,W
	movwf	SYSSTRINGA
	movlw	0
	btfsc	STATUS,C
	addlw	1
	addwf	CHARDISCR_H,W
	movwf	SYSSTRINGA_H
	pagesel	DIGITAL7_DESCRIPTORS
	call	DIGITAL7_DESCRIPTORS
	pagesel	$
	movwf	CHAROFFSETEND
	movlw	3
	addwf	CHARDISCR,W
	movwf	SYSSTRINGA
	movlw	0
	btfsc	STATUS,C
	addlw	1
	addwf	CHARDISCR_H,W
	movwf	SYSSTRINGA_H
	pagesel	DIGITAL7_DESCRIPTORS_H
	call	DIGITAL7_DESCRIPTORS_H
	pagesel	$
	movwf	CHAROFFSETEND_H
;GLCDFontWidth=CharBits+2
	movlw	2
	addwf	CHARBITS,W
	movwf	GLCDFONTWIDTH
	clrf	GLCDFONTWIDTH_H
	btfsc	STATUS,C
	incf	GLCDFONTWIDTH_H,F
;CharBytes=CharBits/8
	movf	CHARBITS,W
	movwf	SysBYTETempA
	movlw	8
	movwf	SysBYTETempB
	pagesel	SysDivSub
	call	SysDivSub
	pagesel	$
	movf	SysBYTETempA,W
	movwf	CHARBYTES
;if SysCalcTempX<>0 then CharBytes++
	movf	SYSCALCTEMPX,F
	btfss	STATUS, Z
	incf	CHARBYTES,F
;CharOffSetBegin++
	incf	CHAROFFSETBEGIN,F
	btfsc	STATUS,Z
	incf	CHAROFFSETBEGIN_H,F
;CharOldBytes=CharBytes
	movf	CHARBYTES,W
	movwf	CHAROLDBYTES
;CharCols=0
	clrf	CHARCOLS
	clrf	CHARCOLS_H
;CharRowS=0
	clrf	CHARROWS
	clrf	CHARROWS_H
;For CharRow=CharOffSetBegin to CharOffSetEnd
	movlw	1
	subwf	CHAROFFSETBEGIN,W
	movwf	CHARROW
	movlw	0
	btfss	STATUS,C
	addlw	1
	subwf	CHAROFFSETBEGIN_H,W
	movwf	CHARROW_H
	movf	CHAROFFSETBEGIN,W
	movwf	SysWORDTempB
	movf	CHAROFFSETBEGIN_H,W
	movwf	SysWORDTempB_H
	movf	CHAROFFSETEND,W
	movwf	SysWORDTempA
	movf	CHAROFFSETEND_H,W
	movwf	SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd2
SysForLoop2
	incf	CHARROW,F
	btfsc	STATUS,Z
	incf	CHARROW_H,F
;Select Case Size
;Case 18 : ReadTable digital7_18 , CharRow , CurrCharVal
SysSelect2Case1
	movlw	18
	subwf	SIZE,W
	btfss	STATUS, Z
	goto	SysSelect2Case2
	movf	CHARROW,W
	movwf	SysStringA
	movf	CHARROW_H,W
	movwf	SysStringA_H
	call	DIGITAL7_18
	movwf	CURRCHARVAL
;Case 20 : ReadTable digital7_20 , CharRow , CurrCharVal
	goto	SysSelectEnd2
SysSelect2Case2
	movlw	20
	subwf	SIZE,W
	btfss	STATUS, Z
	goto	SysSelect2Case3
	movf	CHARROW,W
	movwf	SysStringA
	movf	CHARROW_H,W
	movwf	SysStringA_H
	call	DIGITAL7_20
	movwf	CURRCHARVAL
;Case 22 : ReadTable digital7_22 , CharRow , CurrCharVal
	goto	SysSelectEnd2
SysSelect2Case3
	movlw	22
	subwf	SIZE,W
	btfss	STATUS, Z
	goto	SysSelect2Case4
	movf	CHARROW,W
	movwf	SysStringA
	movf	CHARROW_H,W
	movwf	SysStringA_H
	pagesel	DIGITAL7_22
	call	DIGITAL7_22
	pagesel	$
	movwf	CURRCHARVAL
;Case 24 : ReadTable digital7_24 , CharRow , CurrCharVal
	goto	SysSelectEnd2
SysSelect2Case4
	movlw	24
	subwf	SIZE,W
	btfss	STATUS, Z
	goto	SysSelect2Case5
	movf	CHARROW,W
	movwf	SysStringA
	movf	CHARROW_H,W
	movwf	SysStringA_H
	pagesel	DIGITAL7_24
	call	DIGITAL7_24
	pagesel	$
	movwf	CURRCHARVAL
;End Select
SysSelect2Case5
SysSelectEnd2
;For CharCol=0 to 7
	movlw	255
	movwf	CHARCOL
	movwf	CHARCOL_H
SysForLoop3
	incf	CHARCOL,F
	btfsc	STATUS,Z
	incf	CHARCOL_H,F
;if CurrCharVal.7=1 then
	btfss	CURRCHARVAL,7
	goto	ELSE7_1
;PSet CharLocX + CharCol + CharColS, CharLocY + CharRowS, GLCDForeground
	movf	CHARCOL,W
	addwf	CHARLOCX,W
	movwf	SysTemp2
	movf	CHARCOL_H,W
	btfsc	STATUS,C
	addlw	1
	addwf	CHARLOCX_H,W
	movwf	SysTemp2_H
	movf	CHARCOLS,W
	addwf	SysTemp2,W
	movwf	GLCDX
	movf	CHARROWS,W
	addwf	CHARLOCY,W
	movwf	GLCDY
	movf	GLCDFOREGROUND,W
	movwf	GLCDCOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_KS0108
	call	PSET_KS0108
	pagesel	$
;Else
	goto	ENDIF7
ELSE7_1
;PSet CharLocX + CharCol + CharColS, CharLocY + CharRowS, GLCDBackground
	movf	CHARCOL,W
	addwf	CHARLOCX,W
	movwf	SysTemp2
	movf	CHARCOL_H,W
	btfsc	STATUS,C
	addlw	1
	addwf	CHARLOCX_H,W
	movwf	SysTemp2_H
	movf	CHARCOLS,W
	addwf	SysTemp2,W
	movwf	GLCDX
	movf	CHARROWS,W
	addwf	CHARLOCY,W
	movwf	GLCDY
	movf	GLCDBACKGROUND,W
	movwf	GLCDCOLOUR
	movf	GLCDBACKGROUND_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_KS0108
	call	PSET_KS0108
	pagesel	$
;End if
ENDIF7
;Rotate CurrCharVal Left
	rlf	CURRCHARVAL,F
;Next CharCol
	movf	CHARCOL,W
	movwf	SysWORDTempA
	movf	CHARCOL_H,W
	movwf	SysWORDTempA_H
	movlw	7
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0
	goto	SysForLoop3
SysForLoopEnd3
;if CharBytes<>0 then CharBytes--
	movf	CHARBYTES,F
	btfss	STATUS, Z
	decf	CHARBYTES,F
;if CharBytes<>0 Then
	movf	CHARBYTES,F
	btfsc	STATUS, Z
	goto	ELSE10_1
;CharColS =CharColS+8
	movlw	8
	addwf	CHARCOLS,F
	movlw	0
	btfsc	STATUS,C
	addlw	1
	addwf	CHARCOLS_H,F
;Else
	goto	ENDIF10
ELSE10_1
;CharColS=0
	clrf	CHARCOLS
	clrf	CHARCOLS_H
;CharRowS++
	incf	CHARROWS,F
	btfsc	STATUS,Z
	incf	CHARROWS_H,F
;CharBytes=CharOldBytes
	movf	CHAROLDBYTES,W
	movwf	CHARBYTES
;end if
ENDIF10
;Next
	movf	CHARROW,W
	movwf	SysWORDTempA
	movf	CHARROW_H,W
	movwf	SysWORDTempA_H
	movf	CHAROFFSETEND,W
	movwf	SysWORDTempB
	movf	CHAROFFSETEND_H,W
	movwf	SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0
	goto	SysForLoop2
SysForLoopEnd2
	return

;********************************************************************************

GLCDWRITEBYTE_KS0108
;Dim GLCDSaveRS As Bit
;Dim GLCDSaveCS2 As Bit
;GLCDSaveRS = GLCD_RS
	bcf	SYSBITVAR0,0
	btfsc	PORTB,0
	bsf	SYSBITVAR0,0
;GLCDSaveCS2 = GLCD_CS2
	bcf	SYSBITVAR0,1
	btfsc	PORTB,4
	bsf	SYSBITVAR0,1
;If GLCD_CS1 = 1 Then
	btfsc	PORTB,3
;GLCD_CS2 = 0
	bcf	PORTB,4
;End If
;Set GLCD_RS Off
	bcf	PORTB,0
;Wait Until GLCDReadByte.7 = Off
SysWaitLoop1
	pagesel	FN_GLCDREADBYTE_KS0108
	call	FN_GLCDREADBYTE_KS0108
	pagesel	$
	btfsc	GLCDREADBYTE_KS0108,7
	goto	SysWaitLoop1
;GLCD_RS = GLCDSaveRS
	bcf	PORTB,0
	btfsc	SYSBITVAR0,0
	bsf	PORTB,0
;GLCD_CS2 = GLCDSaveCS2
	bcf	PORTB,4
	btfsc	SYSBITVAR0,1
	bsf	PORTB,4
;Set GLCD_RW Off
	bcf	PORTB,1
;DIR GLCD_DB0 OUT
	banksel	TRISC
	bcf	TRISC,7
;DIR GLCD_DB1 OUT
	bcf	TRISC,6
;DIR GLCD_DB2 OUT
	bcf	TRISC,5
;DIR GLCD_DB3 OUT
	bcf	TRISC,4
;DIR GLCD_DB4 OUT
	bcf	TRISC,3
;DIR GLCD_DB5 OUT
	bcf	TRISC,2
;DIR GLCD_DB6 OUT
	bcf	TRISC,1
;DIR GLCD_DB7 OUT
	bcf	TRISC,0
;GLCD_DB7 = LCDByte.7
	banksel	PORTC
	bcf	PORTC,0
	btfsc	LCDBYTE,7
	bsf	PORTC,0
;GLCD_DB6 = LCDByte.6
	bcf	PORTC,1
	btfsc	LCDBYTE,6
	bsf	PORTC,1
;GLCD_DB5 = LCDByte.5
	bcf	PORTC,2
	btfsc	LCDBYTE,5
	bsf	PORTC,2
;GLCD_DB4 = LCDByte.4
	bcf	PORTC,3
	btfsc	LCDBYTE,4
	bsf	PORTC,3
;GLCD_DB3 = LCDByte.3
	bcf	PORTC,4
	btfsc	LCDBYTE,3
	bsf	PORTC,4
;GLCD_DB2 = LCDByte.2
	bcf	PORTC,5
	btfsc	LCDBYTE,2
	bsf	PORTC,5
;GLCD_DB1 = LCDByte.1
	bcf	PORTC,6
	btfsc	LCDBYTE,1
	bsf	PORTC,6
;GLCD_DB0 = LCDByte.0
	bcf	PORTC,7
	btfsc	LCDBYTE,0
	bsf	PORTC,7
;Wait KS0108WriteDelay us
	goto	$+1
	goto	$+1
;Set GLCD_ENABLE On
	bsf	PORTB,2
;Wait KS0108_Clock_Delay us
	movf	KS0108_CLOCK_DELAY,W
	movwf	SysWaitTempUS
	clrf	SysWaitTempUS_H
	pagesel	Delay_US
	call	Delay_US
	pagesel	$
;Set GLCD_ENABLE Off
	bcf	PORTB,2
;Wait KS0108WriteDelay us
	goto	$+1
	goto	$+1
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

;Start of program memory page 3
	ORG	6144
DIGITAL7_18_H
	movf	SYSSTRINGA,W
	movwf	SysWORDTempA
	movf	SYSSTRINGA_H,W
	movwf	SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	retlw	0
	movf	SysStringA, W
	addlw	low TableDIGITAL7_18_H
	movwf	SysStringA
	movlw	high TableDIGITAL7_18_H
	btfsc	STATUS, C
	addlw	1
	addwf	SysStringA_H, W
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableDIGITAL7_18_H
	retlw	2

;********************************************************************************

DIGITAL7_20_H
	movf	SYSSTRINGA,W
	movwf	SysWORDTempA
	movf	SYSSTRINGA_H,W
	movwf	SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	retlw	0
	movf	SysStringA, W
	addlw	low TableDIGITAL7_20_H
	movwf	SysStringA
	movlw	high TableDIGITAL7_20_H
	btfsc	STATUS, C
	addlw	1
	addwf	SysStringA_H, W
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableDIGITAL7_20_H
	retlw	3

;********************************************************************************

DIGITAL7_22_H
	movf	SYSSTRINGA,W
	movwf	SysWORDTempA
	movf	SYSSTRINGA_H,W
	movwf	SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	retlw	0
	movf	SysStringA, W
	addlw	low TableDIGITAL7_22_H
	movwf	SysStringA
	movlw	high TableDIGITAL7_22_H
	btfsc	STATUS, C
	addlw	1
	addwf	SysStringA_H, W
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableDIGITAL7_22_H
	retlw	3

;********************************************************************************

DIGITAL7_24_H
	movf	SYSSTRINGA,W
	movwf	SysWORDTempA
	movf	SYSSTRINGA_H,W
	movwf	SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	retlw	0
	movf	SysStringA, W
	addlw	low TableDIGITAL7_24_H
	movwf	SysStringA
	movlw	high TableDIGITAL7_24_H
	btfsc	STATUS, C
	addlw	1
	addwf	SysStringA_H, W
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableDIGITAL7_24_H
	retlw	3

;********************************************************************************

Delay_MS
	incf	SysWaitTempMS_H, F
DMS_START
	movlw	108
	movwf	DELAYTEMP2
DMS_OUTER
	movlw	11
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

GLCDCLS_KS0108
;GLCD_yordinate = 0
	clrf	GLCD_YORDINATE
	clrf	GLCD_YORDINATE_H
;Set GLCD_CS1 On
	bsf	PORTB,3
;Set GLCD_CS2 Off
	bcf	PORTB,4
;for GLCD_Count = 1 to 2
	clrf	GLCD_COUNT
SysForLoop4
	incf	GLCD_COUNT,F
;For CurrPage = 0 to 7
	movlw	255
	movwf	CURRPAGE
SysForLoop5
	incf	CURRPAGE,F
;Set GLCD_RS Off
	bcf	PORTB,0
;GLCDWriteByte b'10111000' Or CurrPage
	movlw	184
	iorwf	CURRPAGE,W
	movwf	LCDBYTE
	pagesel	GLCDWRITEBYTE_KS0108
	call	GLCDWRITEBYTE_KS0108
	pagesel	$
;For CurrCol = 0 to 63
	movlw	255
	movwf	CURRCOL
SysForLoop6
	incf	CURRCOL,F
;Set GLCD_RS Off
	bcf	PORTB,0
;GLCDWriteByte 64 Or CurrCol
	movlw	64
	iorwf	CURRCOL,W
	movwf	LCDBYTE
	pagesel	GLCDWRITEBYTE_KS0108
	call	GLCDWRITEBYTE_KS0108
	pagesel	$
;Set GLCD_RS On
	bsf	PORTB,0
;GLCDWriteByte 0
	clrf	LCDBYTE
	pagesel	GLCDWRITEBYTE_KS0108
	call	GLCDWRITEBYTE_KS0108
	pagesel	$
;Next
	movlw	63
	subwf	CURRCOL,W
	btfss	STATUS, C
	goto	SysForLoop6
SysForLoopEnd6
;Next
	movlw	7
	subwf	CURRPAGE,W
	btfss	STATUS, C
	goto	SysForLoop5
SysForLoopEnd5
;Set GLCD_CS1 Off
	bcf	PORTB,3
;Set GLCD_CS2 On
	bsf	PORTB,4
;next
	movlw	2
	subwf	GLCD_COUNT,W
	btfss	STATUS, C
	goto	SysForLoop4
SysForLoopEnd4
;Set GLCD_CS1 OFF
	bcf	PORTB,3
;Set GLCD_CS2 Off
	bcf	PORTB,4
	return

;********************************************************************************

FN_GLCDREADBYTE_KS0108
;Dir GLCD_DB7 In
	banksel	TRISC
	bsf	TRISC,0
;Dir GLCD_DB6 In
	bsf	TRISC,1
;Dir GLCD_DB5 In
	bsf	TRISC,2
;Dir GLCD_DB4 In
	bsf	TRISC,3
;Dir GLCD_DB3 In
	bsf	TRISC,4
;Dir GLCD_DB2 In
	bsf	TRISC,5
;Dir GLCD_DB1 In
	bsf	TRISC,6
;Dir GLCD_DB0 In
	bsf	TRISC,7
;Set GLCD_RW On
	banksel	PORTB
	bsf	PORTB,1
;Set GLCD_ENABLE On
	bsf	PORTB,2
;Wait 3 us
	movlw	4
	movwf	DELAYTEMP
DelayUS1
	decfsz	DELAYTEMP,F
	goto	DelayUS1
;GLCDReadByte.7 = GLCD_DB7
	bcf	GLCDREADBYTE_KS0108,7
	btfsc	PORTC,0
	bsf	GLCDREADBYTE_KS0108,7
;GLCDReadByte.6 = GLCD_DB6
	bcf	GLCDREADBYTE_KS0108,6
	btfsc	PORTC,1
	bsf	GLCDREADBYTE_KS0108,6
;GLCDReadByte.5 = GLCD_DB5
	bcf	GLCDREADBYTE_KS0108,5
	btfsc	PORTC,2
	bsf	GLCDREADBYTE_KS0108,5
;GLCDReadByte.4 = GLCD_DB4
	bcf	GLCDREADBYTE_KS0108,4
	btfsc	PORTC,3
	bsf	GLCDREADBYTE_KS0108,4
;GLCDReadByte.3 = GLCD_DB3
	bcf	GLCDREADBYTE_KS0108,3
	btfsc	PORTC,4
	bsf	GLCDREADBYTE_KS0108,3
;GLCDReadByte.2 = GLCD_DB2
	bcf	GLCDREADBYTE_KS0108,2
	btfsc	PORTC,5
	bsf	GLCDREADBYTE_KS0108,2
;GLCDReadByte.1 = GLCD_DB1
	bcf	GLCDREADBYTE_KS0108,1
	btfsc	PORTC,6
	bsf	GLCDREADBYTE_KS0108,1
;GLCDReadByte.0 = GLCD_DB0
	bcf	GLCDREADBYTE_KS0108,0
	btfsc	PORTC,7
	bsf	GLCDREADBYTE_KS0108,0
;Set GLCD_ENABLE Off
	bcf	PORTB,2
;Wait 2 us
	movlw	2
	movwf	DELAYTEMP
DelayUS2
	decfsz	DELAYTEMP,F
	goto	DelayUS2
	nop
	return

;********************************************************************************

INITSYS
;SET ADFM OFF
	banksel	ADCON1
	bcf	ADCON1,ADFM
;SET ADCON0.ADON OFF
	banksel	ADCON0
	bcf	ADCON0,ADON
;ANSEL = 0
	banksel	ANSEL
	clrf	ANSEL
;ANSELH = 0
	clrf	ANSELH
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

PRINTDIGITAL
;PrintLen = PrintData(0)
	movf	SysPRINTDATAHandler,W
	movwf	FSR
	bcf	STATUS, IRP
	btfsc	SysPRINTDATAHandler_H,0
	bsf	STATUS, IRP
	movf	INDF,W
	movwf	PRINTLEN
;if Size=72 then Size=50
	movlw	72
	subwf	SIZE,W
	btfss	STATUS, Z
	goto	ENDIF1
	movlw	50
	movwf	SIZE
ENDIF1
;If PrintLen = 0 Then Exit Sub
	movf	PRINTLEN,F
	btfsc	STATUS, Z
	return
;GLCDPrintLoc = PrintLocX
	movf	PRINTLOCX,W
	movwf	GLCDPRINTLOC
	movf	PRINTLOCX_H,W
	movwf	GLCDPRINTLOC_H
;GLCDFontWidth=0
	clrf	GLCDFONTWIDTH
	clrf	GLCDFONTWIDTH_H
;For SysPrintTem = 1 To PrintLen
	clrf	SYSPRINTTEM
	movlw	1
	subwf	PRINTLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd1
SysForLoop1
	incf	SYSPRINTTEM,F
;DrawDigital GLCDPrintLoc, PrintLocY, PrintData(SysPrintTem), GLCDForeground , Size
	movf	GLCDPRINTLOC,W
	movwf	CHARLOCX
	movf	GLCDPRINTLOC_H,W
	movwf	CHARLOCX_H
	movf	PRINTLOCY,W
	movwf	CHARLOCY
	movf	PRINTLOCY_H,W
	movwf	CHARLOCY_H
	movf	SYSPRINTTEM,W
	addwf	SysPRINTDATAHandler,W
	movwf	FSR
	bcf	STATUS, IRP
	btfsc	SysPRINTDATAHandler_H,0
	bsf	STATUS, IRP
	movf	INDF,W
	movwf	CHARCODE
	pagesel	DRAWDIGITAL
	call	DRAWDIGITAL
	pagesel	$
;GLCDPrintLoc = [Word]GLCDPrintLoc + GLCDFontWidth
	movf	GLCDFONTWIDTH,W
	addwf	GLCDPRINTLOC,F
	movf	GLCDFONTWIDTH_H,W
	btfsc	STATUS,C
	addlw	1
	addwf	GLCDPRINTLOC_H,F
;Next
	movf	PRINTLEN,W
	subwf	SYSPRINTTEM,W
	btfss	STATUS, C
	goto	SysForLoop1
SysForLoopEnd1
	return

;********************************************************************************

PSET_KS0108
;if GLCDDirection=1 then
;If GLCDX.6 = Off Then Set GLCD_CS2 On:Set GLCD_CS1 off
	btfsc	GLCDX,6
	goto	ENDIF16
	bsf	PORTB,4
	bcf	PORTB,3
ENDIF16
;If GLCDX.6 = On Then Set GLCD_CS1 On: GLCDX -= 64: Set GLCD_CS2 off
	btfss	GLCDX,6
	goto	ENDIF17
	bsf	PORTB,3
	movlw	64
	subwf	GLCDX,F
	bcf	PORTB,4
ENDIF17
;CurrPage = GLCDY / 8
	movf	GLCDY,W
	movwf	SysBYTETempA
	movlw	8
	movwf	SysBYTETempB
	call	SysDivSub
	movf	SysBYTETempA,W
	movwf	CURRPAGE
;Set GLCD_RS Off
	bcf	PORTB,0
;GLCDWriteByte b'10111000' Or CurrPage
	movlw	184
	iorwf	CURRPAGE,W
	movwf	LCDBYTE
	pagesel	GLCDWRITEBYTE_KS0108
	call	GLCDWRITEBYTE_KS0108
	pagesel	$
;Set GLCD_RS Off
	bcf	PORTB,0
;GLCDWriteByte 64 Or GLCDX
	movlw	64
	iorwf	GLCDX,W
	movwf	LCDBYTE
	pagesel	GLCDWRITEBYTE_KS0108
	call	GLCDWRITEBYTE_KS0108
	pagesel	$
;Set GLCD_RS On
	bsf	PORTB,0
;GLCDDataTemp = GLCDReadByte
	call	FN_GLCDREADBYTE_KS0108
	movf	GLCDREADBYTE_KS0108,W
	movwf	GLCDDATATEMP
;Set GLCD_RS On
	bsf	PORTB,0
;GLCDDataTemp = GLCDReadByte
	call	FN_GLCDREADBYTE_KS0108
	movf	GLCDREADBYTE_KS0108,W
	movwf	GLCDDATATEMP
;GLCDBitNo = GLCDY And 7
	movlw	7
	andwf	GLCDY,W
	movwf	GLCDBITNO
;If GLCDColour.0 = 0 Then
	btfsc	GLCDCOLOUR,0
	goto	ELSE18_1
;GLCDChange = 254
	movlw	254
	movwf	GLCDCHANGE
;Set C On
	bsf	STATUS,C
;Else
	goto	ENDIF18
ELSE18_1
;GLCDChange = 1
	movlw	1
	movwf	GLCDCHANGE
;Set C Off
	bcf	STATUS,C
;End If
ENDIF18
;Repeat GLCDBitNo
	movf	GLCDBITNO,W
	movwf	SysRepeatTemp1
	btfsc	STATUS,Z
	goto	SysRepeatLoopEnd1
SysRepeatLoop1
;Rotate GLCDChange Left
	rlf	GLCDCHANGE,F
;End Repeat
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop1
SysRepeatLoopEnd1
;If GLCDColour.0 = 0 Then
	btfsc	GLCDCOLOUR,0
	goto	ELSE19_1
;GLCDDataTemp = GLCDDataTemp And GLCDChange
	movf	GLCDDATATEMP,W
	andwf	GLCDCHANGE,W
	movwf	GLCDDATATEMP
;Else
	goto	ENDIF19
ELSE19_1
;GLCDDataTemp = GLCDDataTemp Or GLCDChange
	movf	GLCDDATATEMP,W
	iorwf	GLCDCHANGE,W
	movwf	GLCDDATATEMP
;End If
ENDIF19
;Set GLCD_RS Off
	bcf	PORTB,0
;GLCDWriteByte 64 Or GLCDX
	movlw	64
	iorwf	GLCDX,W
	movwf	LCDBYTE
	pagesel	GLCDWRITEBYTE_KS0108
	call	GLCDWRITEBYTE_KS0108
	pagesel	$
;Set GLCD_RS On
	bsf	PORTB,0
;GLCDWriteByte GLCDDataTemp
	movf	GLCDDATATEMP,W
	movwf	LCDBYTE
	pagesel	GLCDWRITEBYTE_KS0108
	call	GLCDWRITEBYTE_KS0108
	pagesel	$
;Set GLCD_CS1 Off
	bcf	PORTB,3
;Set GLCD_CS2 Off
	bcf	PORTB,4
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

SYSREADSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;movf SysStringB, W
	movf	SYSSTRINGB, W
;movwf FSR
	movwf	FSR
;bcf STATUS, IRP
	bcf	STATUS, IRP
;btfsc SysStringB_H, 0
	btfsc	SYSSTRINGB_H, 0
;bsf STATUS, IRP
	bsf	STATUS, IRP
;call SysStringTables
	pagesel	SYSSTRINGTABLES
	call	SYSSTRINGTABLES
	pagesel	$
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA
;movwf INDF
	movwf	INDF
;addwf SysStringB, F
	addwf	SYSSTRINGB, F
;goto SysStringReadCheck
	goto	SYSSTRINGREADCHECK
SYSREADSTRINGPART
;movf SysStringB, W
	movf	SYSSTRINGB, W
;movwf FSR
	movwf	FSR
;decf FSR,F
;bcf STATUS, IRP
	bcf	STATUS, IRP
;btfsc SysStringB_H, 0
	btfsc	SYSSTRINGB_H, 0
;bsf STATUS, IRP
	bsf	STATUS, IRP
;call SysStringTables
	pagesel	SYSSTRINGTABLES
	call	SYSSTRINGTABLES
	pagesel	$
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA
;addwf SysStringLength,F
	addwf	SYSSTRINGLENGTH,F
;addwf SysStringB,F
	addwf	SYSSTRINGB,F
SYSSTRINGREADCHECK
;movf SysCalcTempA,F
	movf	SYSCALCTEMPA,F
;btfsc STATUS,Z
	btfsc	STATUS,Z
;return
	return
SYSSTRINGREAD
;call SysStringTables
	pagesel	SYSSTRINGTABLES
	call	SYSSTRINGTABLES
	pagesel	$
;incf FSR, F
	incf	FSR, F
;movwf INDF
	movwf	INDF
;decfsz SysCalcTempA, F
	decfsz	SYSCALCTEMPA, F
;goto SysStringRead
	goto	SYSSTRINGREAD
	return

;********************************************************************************


 END
