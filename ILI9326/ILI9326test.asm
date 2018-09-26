;Program compiled by Great Cow BASIC (0.98.<<>> 2018-09-23)
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F1789, r=DEC
#include <P16F1789.inc>
 __CONFIG _CONFIG1, _BOREN_OFF & _MCLRE_OFF & _WDTE_OFF & _FOSC_INTOSC
 __CONFIG _CONFIG2, _LVP_OFF & _PLLEN_OFF

;********************************************************************************

;Set aside memory locations for variables
DELAYTEMP	EQU	112
DELAYTEMP2	EQU	113
GLCD_HEIGHT	EQU	32
GLCD_HEIGHT_H	EQU	33
GLCD_WIDTH	EQU	34
GLCD_WIDTH_H	EQU	35
ILI9326SENDWORD	EQU	36
ILI9326SENDWORD_H	EQU	37
ILI9326_ANGLE	EQU	38
ILI9326_ANGLE_H	EQU	39
SYSBYTETEMPX	EQU	112
SYSREPEATTEMP1	EQU	40
SYSREPEATTEMP1_H	EQU	41
SYSREPEATTEMP2	EQU	42
SYSREPEATTEMP2_H	EQU	43
SYSREPEATTEMP3	EQU	44
SYSREPEATTEMP3_H	EQU	45
SYSREPEATTEMP4	EQU	46
SYSREPEATTEMP4_H	EQU	47
SYSTEMP1	EQU	48
SYSWAITTEMPMS	EQU	114
SYSWAITTEMPMS_H	EQU	115
SYSWORDTEMPA	EQU	117
SYSWORDTEMPA_H	EQU	118
SYSWORDTEMPB	EQU	121
SYSWORDTEMPB_H	EQU	122
XX1	EQU	49
XX1_H	EQU	50

;********************************************************************************

;Vectors
	ORG	0
	pagesel	BASPROGRAMSTART
	goto	BASPROGRAMSTART
	ORG	4
	retfie

;********************************************************************************

;Start of program memory page 0
	ORG	5
BASPROGRAMSTART
;Call initialisation routines
	call	INITSYS
;Automatic pin direction setting
	banksel	TRISA
	bcf	TRISA,5
	bcf	TRISA,3
	bcf	TRISA,2
	bcf	TRISA,1
	bcf	TRISA,0

;Start of the main program
;wait 1 ms
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	banksel	STATUS
	call	Delay_MS
;#include <glcd.h>
;#include<glcd_ili9326.h>
;#define GLCD_TYPE GLCD_TYPE_ILI9326
;#define GLCD_RD       porta.3        ' read command line
;#define GLCD_WR       porta.2         ' write command line
;#define GLCD_RS       porta.1         ' Command/Data line
;#define GLCD_CS       porta.0         ' Chip select line
;#define GLCD_RST      porta.5         ' Reset line
;#define GLCD_DB0       portd.0
;#define GLCD_DB1       portd.1
;#define GLCD_DB2       portd.2
;#define GLCD_DB3       portd.3
;#define GLCD_DB4       portd.4
;#define GLCD_DB5       portd.5
;#define GLCD_DB6       portd.6
;#define GLCD_DB7       portd.7
;#define GLCD_DataPort portD
;#define ILI9326_DataPort GLCD_DataPort
;#define ILI9326_GLCD_RST GLCD_RST
;#define ILI9326_GLCD_CS GLCD_CS
;#define ILI9326_GLCD_RS GLCD_RS
;#define ILI9326_GLCD_WR GLCD_WR
;#define ILI9326_GLCD_RD GLCD_RD
;dir ILI9326_dataPort out
	banksel	TRISD
	clrf	TRISD
;dim ILI9326SendWord, GLCD_width,GLCD_height,ILI9326_angle as word
;dim xx1 as word
;GLCD_WIDTH = 400
	movlw	144
	banksel	GLCD_WIDTH
	movwf	GLCD_WIDTH
	movlw	1
	movwf	GLCD_WIDTH_H
;GLCD_HEIGHT = 240
	movlw	240
	movwf	GLCD_HEIGHT
	clrf	GLCD_HEIGHT_H
;ili9326_angle=0
	clrf	ILI9326_ANGLE
	clrf	ILI9326_ANGLE_H
;ili9326init
	call	ILI9326INIT
;ILI9326Orientation(ILI9326_angle)
	call	ILI9326ORIENTATION
;GLCDCLS_ILI9326
	call	GLCDCLS_ILI9326
;glcdStripes_ILI9326
	call	GLCDSTRIPES_ILI9326
;sleep
	sleep
;end
	goto	BASPROGRAMEND
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

;********************************************************************************

Delay_MS
	incf	SysWaitTempMS_H, F
DMS_START
	movlw	4
	movwf	DELAYTEMP2
DMS_OUTER
	movlw	165
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

GLCDCLS_ILI9326
;SendCommand_ili9326(0x0202)
	movlw	2
	movwf	ILI9326SENDWORD
	movwf	ILI9326SENDWORD_H
	call	SENDCOMMAND_ILI9326
;repeat GLCD_width
	movf	GLCD_WIDTH,W
	movwf	SysRepeatTemp1
	movf	GLCD_WIDTH_H,W
	movwf	SysRepeatTemp1_H
	movf	SYSREPEATTEMP1,W
	movwf	SysWORDTempA
	movf	SYSREPEATTEMP1_H,W
	movwf	SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0
	goto	SysRepeatLoopEnd1
	movf	SYSREPEATTEMP1,F
	btfss	STATUS, Z
	incf	SysRepeatTemp1_H,F
ENDIF1
SysRepeatLoop1
;repeat GLCD_height
	movf	GLCD_HEIGHT,W
	movwf	SysRepeatTemp2
	movf	GLCD_HEIGHT_H,W
	movwf	SysRepeatTemp2_H
	movf	SYSREPEATTEMP2,W
	movwf	SysWORDTempA
	movf	SYSREPEATTEMP2_H,W
	movwf	SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0
	goto	SysRepeatLoopEnd2
	movf	SYSREPEATTEMP2,F
	btfss	STATUS, Z
	incf	SysRepeatTemp2_H,F
ENDIF2
SysRepeatLoop2
;sendData_ILI9326(0x0000)
	clrf	ILI9326SENDWORD
	clrf	ILI9326SENDWORD_H
	call	SENDDATA_ILI9326
;end repeat
	decfsz	SysRepeatTemp2,F
	goto	SysRepeatLoop2
	decfsz	SysRepeatTemp2_H,F
	goto	SysRepeatLoop2
SysRepeatLoopEnd2
;end repeat
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop1
	decfsz	SysRepeatTemp1_H,F
	goto	SysRepeatLoop1
SysRepeatLoopEnd1
	return

;********************************************************************************

GLCDSTRIPES_ILI9326
;test for horizontal/vertical alignment
;xx1=0x0000
	clrf	XX1
	clrf	XX1_H
;SendCommand_ili9326(0x0202)
	movlw	2
	movwf	ILI9326SENDWORD
	movwf	ILI9326SENDWORD_H
	call	SENDCOMMAND_ILI9326
;repeat GLCD_width
	movf	GLCD_WIDTH,W
	movwf	SysRepeatTemp3
	movf	GLCD_WIDTH_H,W
	movwf	SysRepeatTemp3_H
	movf	SYSREPEATTEMP3,W
	movwf	SysWORDTempA
	movf	SYSREPEATTEMP3_H,W
	movwf	SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0
	goto	SysRepeatLoopEnd3
	movf	SYSREPEATTEMP3,F
	btfss	STATUS, Z
	incf	SysRepeatTemp3_H,F
ENDIF3
SysRepeatLoop3
;repeat GLCD_height
	movf	GLCD_HEIGHT,W
	movwf	SysRepeatTemp4
	movf	GLCD_HEIGHT_H,W
	movwf	SysRepeatTemp4_H
	movf	SYSREPEATTEMP4,W
	movwf	SysWORDTempA
	movf	SYSREPEATTEMP4_H,W
	movwf	SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0
	goto	SysRepeatLoopEnd4
	movf	SYSREPEATTEMP4,F
	btfss	STATUS, Z
	incf	SysRepeatTemp4_H,F
ENDIF4
SysRepeatLoop4
;sendData_ILI9326(xx1)
	movf	XX1,W
	movwf	ILI9326SENDWORD
	movf	XX1_H,W
	movwf	ILI9326SENDWORD_H
	call	SENDDATA_ILI9326
	movf	ILI9326SENDWORD,W
	movwf	XX1
	movf	ILI9326SENDWORD_H,W
	movwf	XX1_H
;end repeat
	decfsz	SysRepeatTemp4,F
	goto	SysRepeatLoop4
	decfsz	SysRepeatTemp4_H,F
	goto	SysRepeatLoop4
SysRepeatLoopEnd4
;xx1=xx1+123
	movlw	123
	addwf	XX1,F
	movlw	0
	addwfc	XX1_H,F
;end repeat
	decfsz	SysRepeatTemp3,F
	goto	SysRepeatLoop3
	decfsz	SysRepeatTemp3_H,F
	goto	SysRepeatLoop3
SysRepeatLoopEnd3
	return

;********************************************************************************

ILI9326INIT
;Reset*********************
;Set ILI9326_GLCD_RST On
	banksel	LATA
	bsf	LATA,5
;Wait 15 ms
	movlw	15
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	banksel	STATUS
	call	Delay_MS
;Set ILI9326_GLCD_RST Off
	banksel	LATA
	bcf	LATA,5
;Wait 15 ms
	movlw	15
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	banksel	STATUS
	call	Delay_MS
;Set ILI9326_GLCD_RST On
	banksel	LATA
	bsf	LATA,5
;Wait 15 ms
	movlw	15
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	banksel	STATUS
	call	Delay_MS
;//*************Power On sequence ****************//
;parameters below taken from...
;*  Module for Microchip Graphics Library
;*  LCD controller driver*  ILI9326
;discharge*********************
;SendCommand_ILI9326(0x0100)
	clrf	ILI9326SENDWORD
	movlw	1
	movwf	ILI9326SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0000)
	clrf	ILI9326SENDWORD
	clrf	ILI9326SENDWORD_H
	call	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0102)
	movlw	2
	movwf	ILI9326SENDWORD
	movlw	1
	movwf	ILI9326SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0000)
	clrf	ILI9326SENDWORD
	clrf	ILI9326SENDWORD_H
	call	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0103)
	movlw	3
	movwf	ILI9326SENDWORD
	movlw	1
	movwf	ILI9326SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0000)
	clrf	ILI9326SENDWORD
	clrf	ILI9326SENDWORD_H
	call	SENDDATA_ILI9326
;wait 200 ms 'power settings*****
	movlw	200
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;SendCommand_ILI9326(0x0100)
	clrf	ILI9326SENDWORD
	movlw	1
	movwf	ILI9326SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326(0x1190)
	movlw	144
	movwf	ILI9326SENDWORD
	movlw	17
	movwf	ILI9326SENDWORD_H
	call	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0101)
	movlw	1
	movwf	ILI9326SENDWORD
	movwf	ILI9326SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0017)
	movlw	23
	movwf	ILI9326SENDWORD
	clrf	ILI9326SENDWORD_H
	call	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0102)
	movlw	2
	movwf	ILI9326SENDWORD
	movlw	1
	movwf	ILI9326SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326(0x01BD)
	movlw	189
	movwf	ILI9326SENDWORD
	movlw	1
	movwf	ILI9326SENDWORD_H
	call	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0103)
	movlw	3
	movwf	ILI9326SENDWORD
	movlw	1
	movwf	ILI9326SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0350)
	movlw	80
	movwf	ILI9326SENDWORD
	movlw	3
	movwf	ILI9326SENDWORD_H
	call	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0281)
	movlw	129
	movwf	ILI9326SENDWORD
	movlw	2
	movwf	ILI9326SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0017)
	movlw	23
	movwf	ILI9326SENDWORD
	clrf	ILI9326SENDWORD_H
	call	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0200)
	clrf	ILI9326SENDWORD
	movlw	2
	movwf	ILI9326SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0000)
	clrf	ILI9326SENDWORD
	clrf	ILI9326SENDWORD_H
	call	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0201)
	movlw	1
	movwf	ILI9326SENDWORD
	movlw	2
	movwf	ILI9326SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0000)
	clrf	ILI9326SENDWORD
	clrf	ILI9326SENDWORD_H
	call	SENDDATA_ILI9326
;set gamma curve**************
;SendCommand_ILI9326(0x0300)
	clrf	ILI9326SENDWORD
	movlw	3
	movwf	ILI9326SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0000)
	clrf	ILI9326SENDWORD
	clrf	ILI9326SENDWORD_H
	call	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0301)
	movlw	1
	movwf	ILI9326SENDWORD
	movlw	3
	movwf	ILI9326SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0707)
	movlw	7
	movwf	ILI9326SENDWORD
	movwf	ILI9326SENDWORD_H
	call	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0302)
	movlw	2
	movwf	ILI9326SENDWORD
	movlw	3
	movwf	ILI9326SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0606)
	movlw	6
	movwf	ILI9326SENDWORD
	movwf	ILI9326SENDWORD_H
	call	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0305)
	movlw	5
	movwf	ILI9326SENDWORD
	movlw	3
	movwf	ILI9326SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0006)
	movlw	6
	movwf	ILI9326SENDWORD
	clrf	ILI9326SENDWORD_H
	call	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0306)
	movlw	6
	movwf	ILI9326SENDWORD
	movlw	3
	movwf	ILI9326SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0A09)
	movlw	9
	movwf	ILI9326SENDWORD
	movlw	10
	movwf	ILI9326SENDWORD_H
	call	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0307)
	movlw	7
	movwf	ILI9326SENDWORD
	movlw	3
	movwf	ILI9326SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0203)
	movlw	3
	movwf	ILI9326SENDWORD
	movlw	2
	movwf	ILI9326SENDWORD_H
	call	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0308)
	movlw	8
	movwf	ILI9326SENDWORD
	movlw	3
	movwf	ILI9326SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0005)
	movlw	5
	movwf	ILI9326SENDWORD
	clrf	ILI9326SENDWORD_H
	call	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0309)
	movlw	9
	movwf	ILI9326SENDWORD
	movlw	3
	movwf	ILI9326SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0007)
	movlw	7
	movwf	ILI9326SENDWORD
	clrf	ILI9326SENDWORD_H
	call	SENDDATA_ILI9326
;SendCommand_ILI9326(0x030C)
	movlw	12
	movwf	ILI9326SENDWORD
	movlw	3
	movwf	ILI9326SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0400)
	clrf	ILI9326SENDWORD
	movlw	4
	movwf	ILI9326SENDWORD_H
	call	SENDDATA_ILI9326
;SendCommand_ILI9326(0x030D)
	movlw	13
	movwf	ILI9326SENDWORD
	movlw	3
	movwf	ILI9326SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326(0x000A)
	movlw	10
	movwf	ILI9326SENDWORD
	clrf	ILI9326SENDWORD_H
	call	SENDDATA_ILI9326
;set GRAM area**************
;SendCommand_ILI9326(0x0210)
	movlw	16
	movwf	ILI9326SENDWORD
	movlw	2
	movwf	ILI9326SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0000)
	clrf	ILI9326SENDWORD
	clrf	ILI9326SENDWORD_H
	call	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0211)
	movlw	17
	movwf	ILI9326SENDWORD
	movlw	2
	movwf	ILI9326SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326(0x00EF)' 240
	movlw	239
	movwf	ILI9326SENDWORD
	clrf	ILI9326SENDWORD_H
	call	SENDDATA_ILI9326
;SendCommand_ILI9326(0x212)
	movlw	18
	movwf	ILI9326SENDWORD
	movlw	2
	movwf	ILI9326SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0000)
	clrf	ILI9326SENDWORD
	clrf	ILI9326SENDWORD_H
	call	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0213)
	movlw	19
	movwf	ILI9326SENDWORD
	movlw	2
	movwf	ILI9326SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326(0x018F) '400
	movlw	143
	movwf	ILI9326SENDWORD
	movlw	1
	movwf	ILI9326SENDWORD_H
	call	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0400)
	clrf	ILI9326SENDWORD
	movlw	4
	movwf	ILI9326SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326(0x3500)
	clrf	ILI9326SENDWORD
	movlw	53
	movwf	ILI9326SENDWORD_H
	call	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0401)
	movlw	1
	movwf	ILI9326SENDWORD
	movlw	4
	movwf	ILI9326SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0001)
	movlw	1
	movwf	ILI9326SENDWORD
	clrf	ILI9326SENDWORD_H
	call	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0404)
	movlw	4
	movwf	ILI9326SENDWORD
	movwf	ILI9326SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0000)
	clrf	ILI9326SENDWORD
	clrf	ILI9326SENDWORD_H
	call	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0010) 'set screen defaults
	movlw	16
	movwf	ILI9326SENDWORD
	clrf	ILI9326SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0010)
	movlw	16
	movwf	ILI9326SENDWORD
	clrf	ILI9326SENDWORD_H
	call	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0011) 'last set of commands
	movlw	17
	movwf	ILI9326SENDWORD
	clrf	ILI9326SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0000)
	clrf	ILI9326SENDWORD
	clrf	ILI9326SENDWORD_H
	call	SENDDATA_ILI9326
;SendCommand_ILI9326(0x020B)
	movlw	11
	movwf	ILI9326SENDWORD
	movlw	2
	movwf	ILI9326SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0000)
	clrf	ILI9326SENDWORD
	clrf	ILI9326SENDWORD_H
	call	SENDDATA_ILI9326
;SendCommand_ILI9326(0x0007)
	movlw	7
	movwf	ILI9326SENDWORD
	clrf	ILI9326SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0173) 'display on
	movlw	115
	movwf	ILI9326SENDWORD
	movlw	1
	movwf	ILI9326SENDWORD_H
	goto	SENDDATA_ILI9326

;********************************************************************************

ILI9326ORIENTATION
;if ILI9326_angle=0 then
	movf	ILI9326_ANGLE,W
	movwf	SysWORDTempA
	movf	ILI9326_ANGLE_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysCompEqual16
	btfss	SysByteTempX,0
	goto	ENDIF5
;SendCommand_ILI9326(0x0003)
	movlw	3
	movwf	ILI9326SENDWORD
	clrf	ILI9326SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0030)
	movlw	48
	movwf	ILI9326SENDWORD
	clrf	ILI9326SENDWORD_H
	call	SENDDATA_ILI9326
;end if
ENDIF5
;if ILI9326_angle=90 then
	movf	ILI9326_ANGLE,W
	movwf	SysWORDTempA
	movf	ILI9326_ANGLE_H,W
	movwf	SysWORDTempA_H
	movlw	90
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysCompEqual16
	btfss	SysByteTempX,0
	goto	ENDIF6
;SendCommand_ILI9326(0x0003)
	movlw	3
	movwf	ILI9326SENDWORD
	clrf	ILI9326SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0028)
	movlw	40
	movwf	ILI9326SENDWORD
	clrf	ILI9326SENDWORD_H
	call	SENDDATA_ILI9326
;end if
ENDIF6
;if ILI9326_angle=180 then
	movf	ILI9326_ANGLE,W
	movwf	SysWORDTempA
	movf	ILI9326_ANGLE_H,W
	movwf	SysWORDTempA_H
	movlw	180
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysCompEqual16
	btfss	SysByteTempX,0
	goto	ENDIF7
;SendCommand_ILI9326(0x0003)
	movlw	3
	movwf	ILI9326SENDWORD
	clrf	ILI9326SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0000)
	clrf	ILI9326SENDWORD
	clrf	ILI9326SENDWORD_H
	call	SENDDATA_ILI9326
;end if
ENDIF7
;if ILI9326_angle=270 then
	movf	ILI9326_ANGLE,W
	movwf	SysWORDTempA
	movf	ILI9326_ANGLE_H,W
	movwf	SysWORDTempA_H
	movlw	14
	movwf	SysWORDTempB
	movlw	1
	movwf	SysWORDTempB_H
	call	SysCompEqual16
	btfss	SysByteTempX,0
	goto	ENDIF8
;SendCommand_ILI9326(0x0003)
	movlw	3
	movwf	ILI9326SENDWORD
	clrf	ILI9326SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326(0x0018)
	movlw	24
	movwf	ILI9326SENDWORD
	clrf	ILI9326SENDWORD_H
	call	SENDDATA_ILI9326
;end if
ENDIF8
	return

;********************************************************************************

INITSYS
;asm showdebug OSCCON type is 105 'Bit(SPLLEN) Or Bit(IRCF3) And NoBit(INTSRC) and ifdef Bit(IRCF3)
;osccon type is 105
;OSCCON = OSCCON AND b'10000111'
;OSCCON = OSCCON OR b'01110000'
;Set IRCF3 On
	banksel	OSCCON
	bsf	OSCCON,IRCF3
;Set IRCF2 On
	bsf	OSCCON,IRCF2
;Set IRCF1 On
	bsf	OSCCON,IRCF1
;Set IRCF0 Off
	bcf	OSCCON,IRCF0
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
;ANSELD = 0
	clrf	ANSELD
;ANSELE = 0
	clrf	ANSELE
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
;PORTD = 0
	clrf	PORTD
;PORTE = 0
	clrf	PORTE
	return

;********************************************************************************

SENDCOMMAND_ILI9326
;set ILI9326_GLCD_CS off
	banksel	LATA
	bcf	LATA,0
;set ILI9326_GLCD_RS OFF
	bcf	LATA,1
;set ILI9326_GLCD_RD ON
	bsf	LATA,3
;set ILI9326_GLCD_WR ON
	bsf	LATA,2
;ILI9326_DataPort=ILI9326SendWord_h
	banksel	ILI9326SENDWORD_H
	movf	ILI9326SENDWORD_H,W
	movwf	PORTD
;set ILI9326_GLCD_WR OFF
	banksel	LATA
	bcf	LATA,2
;set ILI9326_GLCD_WR ON
	bsf	LATA,2
;ILI9326_DataPort=ILI9326SendWord
	banksel	ILI9326SENDWORD
	movf	ILI9326SENDWORD,W
	movwf	PORTD
;set ILI9326_GLCD_WR OFF
	banksel	LATA
	bcf	LATA,2
;set ILI9326_GLCD_WR ON
	bsf	LATA,2
	banksel	STATUS
	return

;********************************************************************************

SENDDATA_ILI9326
;set ILI9326_GLCD_RS ON
	banksel	LATA
	bsf	LATA,1
;ILI9326_DataPort=ILI9326SendWord_h
	banksel	ILI9326SENDWORD_H
	movf	ILI9326SENDWORD_H,W
	movwf	PORTD
;set ILI9326_GLCD_WR OFF
	banksel	LATA
	bcf	LATA,2
;set ILI9326_GLCD_WR ON
	bsf	LATA,2
;ILI9326_DataPort=ILI9326SendWord
	banksel	ILI9326SENDWORD
	movf	ILI9326SENDWORD,W
	movwf	PORTD
;set ILI9326_GLCD_WR OFF
	banksel	LATA
	bcf	LATA,2
;set ILI9326_GLCD_WR ON
	bsf	LATA,2
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

 END
