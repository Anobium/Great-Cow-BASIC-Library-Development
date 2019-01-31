;Program compiled by Great Cow BASIC (0.98.<<>> 2019-01-21 (Windows 32 bit))
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F648A, r=DEC
#include <P16F648A.inc>
 __CONFIG _LVP_OFF & _MCLRE_OFF & _WDTE_OFF & _INTRC_OSC_NOCLKOUT

;********************************************************************************

;Set aside memory locations for variables
CHARARRAY	EQU	341
DELAYTEMP	EQU	112
DELAYTEMP2	EQU	113
LCD3_RSSTATE	EQU	32
LCDBYTE	EQU	33
LCDCHAR	EQU	34
LCDCHARLOC	EQU	35
LCDCOLUMN	EQU	36
LCDLINE	EQU	37
LCDTEMP	EQU	38
LCDVALUE	EQU	39
LCD_STATE	EQU	40
PRINTLEN	EQU	41
STRINGPOINTER	EQU	42
SYSBYTETEMPA	EQU	117
SYSBYTETEMPB	EQU	121
SYSBYTETEMPX	EQU	112
SYSCALCTEMPA	EQU	117
SYSLCDCHARDATAHANDLER	EQU	43
SYSLCDCHARDATAHANDLER_H	EQU	44
SYSPRINTDATAHANDLER	EQU	45
SYSPRINTDATAHANDLER_H	EQU	46
SYSPRINTTEMP	EQU	47
SYSREPEATTEMP1	EQU	48
SYSSTRINGA	EQU	119
SYSSTRINGA_H	EQU	120
SYSSTRINGB	EQU	114
SYSSTRINGB_H	EQU	115
SYSSTRINGLENGTH	EQU	118
SYSSTRINGPARAM1	EQU	350
SYSTEMP1	EQU	49
SYSWAITTEMP10US	EQU	117
SYSWAITTEMPMS	EQU	114
SYSWAITTEMPMS_H	EQU	115
SYSWAITTEMPS	EQU	116

;********************************************************************************

;Alias variables
SYSCHARARRAY_1	EQU	342
SYSCHARARRAY_2	EQU	343
SYSCHARARRAY_3	EQU	344
SYSCHARARRAY_4	EQU	345
SYSCHARARRAY_5	EQU	346
SYSCHARARRAY_6	EQU	347
SYSCHARARRAY_7	EQU	348
SYSCHARARRAY_8	EQU	349

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
	call	INITLCD

;Start of the main program
;''@author          EvanV
;''@licence GPL
;''@version 0.9a
;''@date    29.1.2019
;''********************************************************************************
;Setup LCD Parameters
;#define LCD_IO 3
;Change as necessary
;#define LCD_DB     PORTb.3            ; databit
;#define LCD_CB     PORTb.4            ; clockbit
;#define LCD_EB     PORTa.0            ; enable bit
;Main Program
;CreateCustomCharacters
	call	CREATECUSTOMCHARACTERS
;CLS
	call	CLS
;Print "Great Cow BASIC"
	movlw	low SYSSTRINGPARAM1
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM1
	movwf	SysStringB_H
	movlw	low StringTable1
	movwf	SysStringA
	movlw	high StringTable1
	movwf	SysStringA_H
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	call	PRINT108
;locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE
;Print "2019"
	movlw	low SYSSTRINGPARAM1
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM1
	movwf	SysStringB_H
	movlw	low StringTable2
	movwf	SysStringA
	movlw	high StringTable2
	movwf	SysStringA_H
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	call	PRINT108
;wait 4 s
	movlw	4
	movwf	SysWaitTempS
	call	Delay_S
;CLS
	call	CLS
;print "Smiley face"
	movlw	low SYSSTRINGPARAM1
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM1
	movwf	SysStringB_H
	movlw	low StringTable3
	movwf	SysStringA
	movlw	high StringTable3
	movwf	SysStringA_H
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	call	PRINT108
;locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE
;LCDWriteChar 0
	clrf	LCDCHAR
	call	LCDWRITECHAR
;print " : "
	movlw	low SYSSTRINGPARAM1
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM1
	movwf	SysStringB_H
	movlw	low StringTable4
	movwf	SysStringA
	movlw	high StringTable4
	movwf	SysStringA_H
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	call	PRINT108
;LCDWriteChar 1
	movlw	1
	movwf	LCDCHAR
	call	LCDWRITECHAR
;end
	goto	BASPROGRAMEND
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

;********************************************************************************

CLS
;SET LCD_RS OFF
	bcf	PORTB,3
;Clear screen
;LCDWriteByte (0b00000001)
	movlw	1
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
;Wait 4 ms
	movlw	4
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;Move to start of visible DDRAM
;LCDWriteByte(0x80)
	movlw	128
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
;Wait 12 10us
	movlw	12
	movwf	SysWaitTemp10US
	goto	Delay_10US

;********************************************************************************

CREATECUSTOMCHARACTERS
;Create an array to store the character until it is copied
;Dim CharArray(8)
;Set the array to hold the character
;Binary has been used to improve the readability of the code, but is not essential
;CharArray(1) = b'00011011'
	movlw	27
	banksel	SYSCHARARRAY_1
	movwf	SYSCHARARRAY_1
;CharArray(2) = b'00011011'
	movlw	27
	movwf	SYSCHARARRAY_2
;CharArray(3) = b'00000000'
	clrf	SYSCHARARRAY_3
;CharArray(4) = b'00000100'
	movlw	4
	movwf	SYSCHARARRAY_4
;CharArray(5) = b'00000000'
	clrf	SYSCHARARRAY_5
;CharArray(6) = b'00010001'
	movlw	17
	movwf	SYSCHARARRAY_6
;CharArray(7) = b'00010001'
	movlw	17
	movwf	SYSCHARARRAY_7
;CharArray(8) = b'00001110'
	movlw	14
	movwf	SYSCHARARRAY_8
;Copy the character from the array to the LCD
;LCDCreateChar 0, CharArray()
	banksel	LCDCHARLOC
	clrf	LCDCHARLOC
	movlw	low CHARARRAY
	movwf	SysLCDCHARDATAHandler
	movlw	high CHARARRAY
	movwf	SysLCDCHARDATAHandler_H
	call	LCDCREATECHAR
;Set the array to hold the character
;Binary has been used to improve the readability of the code, but is not essential
;CharArray(1) = b'00011011'
	movlw	27
	banksel	SYSCHARARRAY_1
	movwf	SYSCHARARRAY_1
;CharArray(2) = b'00011011'
	movlw	27
	movwf	SYSCHARARRAY_2
;CharArray(3) = b'00000000'
	clrf	SYSCHARARRAY_3
;CharArray(4) = b'00000100'
	movlw	4
	movwf	SYSCHARARRAY_4
;CharArray(5) = b'00000000'
	clrf	SYSCHARARRAY_5
;CharArray(6) = b'00001110'
	movlw	14
	movwf	SYSCHARARRAY_6
;CharArray(7) = b'00010001'
	movlw	17
	movwf	SYSCHARARRAY_7
;CharArray(8) = b'00010001'
	movlw	17
	movwf	SYSCHARARRAY_8
;Copy the character from the array to the LCD
;LCDCreateChar 1, CharArray()
	movlw	1
	banksel	LCDCHARLOC
	movwf	LCDCHARLOC
	movlw	low CHARARRAY
	movwf	SysLCDCHARDATAHandler
	movlw	high CHARARRAY
	movwf	SysLCDCHARDATAHandler_H
	goto	LCDCREATECHAR

;********************************************************************************

Delay_10US
D10US_START
	movlw	2
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
	movlw	142
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

INITLCD
;LCD_I0 3 code
;LCDBacklight Off  'this is to prevent an error during compiling if LCDbacklight is not used in the script
	clrf	LCDTEMP
	call	LCDBACKLIGHT
;Dir LCD_EB out
	banksel	TRISA
	bcf	TRISA,0
;Dir LCD_RS out
	bcf	TRISB,3
;Dir LCD_CB out
	bcf	TRISB,4
;SET LCD_EB OFF
	banksel	PORTA
	bcf	PORTA,0
;SET LCD_RS OFF
	bcf	PORTB,3
;SET LCD_CB OFF
	bcf	PORTB,4
;wait 20 ms
	movlw	20
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;SET LCD_EB ON
	bsf	PORTA,0
;LCD3_CMD(0x30)
	movlw	48
	movwf	LCDVALUE
	call	LCD3_CMD
;wait 5 ms
	movlw	5
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;LCD3_CMD(0x30)
	movlw	48
	movwf	LCDVALUE
	call	LCD3_CMD
;wait 1 ms
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;LCD3_CMD(0x38)
	movlw	56
	movwf	LCDVALUE
	call	LCD3_CMD
;LCD3_CMD(0x08)
	movlw	8
	movwf	LCDVALUE
	call	LCD3_CMD
;LCD3_CMD(0x0F)
	movlw	15
	movwf	LCDVALUE
	call	LCD3_CMD
;LCD3_CMD(0x01)
	movlw	1
	movwf	LCDVALUE
	call	LCD3_CMD
;LCD3_CMD(0x38)
	movlw	56
	movwf	LCDVALUE
	call	LCD3_CMD
;LCD3_CMD(0x80)
	movlw	128
	movwf	LCDVALUE
	call	LCD3_CMD
;Initialization routines based upon code examples
;in HD44780 datasheet
;Configure RS,Enable & RW pin directions
;***********************************
;I2C pcf8574 initialization routine
;***********************************
;LCD_State = 12
	movlw	12
	movwf	LCD_STATE
	return

;********************************************************************************

INITSYS
;Set up internal oscillator
;Handle OSCCON1 register for parts that have this register
;Turn off comparator - this default setting not changed since 2013
;CMCON = 7
	movlw	7
	movwf	CMCON
;Turn off all ports
;PORTA = 0
	clrf	PORTA
;PORTB = 0
	clrf	PORTB
	return

;********************************************************************************

LCD3_CMD
;LCD_DB = 0  'really maps to the LCD_RS
	bcf	PORTB,3
;LCDWriteByte(LCDValue)
	movf	LCDVALUE,W
	movwf	LCDBYTE
	goto	LCDNORMALWRITEBYTE

;********************************************************************************

LCDBACKLIGHT
	return

;********************************************************************************

LCDCREATECHAR
;Store old location
;Select location
;Set LCD_RS Off
	bcf	PORTB,3
;LCDWriteByte (64 + LCDCharLoc * 8)
	movf	LCDCHARLOC,W
	movwf	SysBYTETempA
	movlw	8
	movwf	SysBYTETempB
	call	SysMultSub
	movlw	64
	addwf	SysBYTETempX,W
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
;wait 5 10us
	movlw	5
	movwf	SysWaitTemp10US
	call	Delay_10US
;Write char
;Set LCD_RS On
	bsf	PORTB,3
;For LCDTemp = 1 to 8
	clrf	LCDTEMP
SysForLoop2
	incf	LCDTEMP,F
;LCDWriteByte LCDCharData(LCDTemp)
	movf	LCDTEMP,W
	addwf	SysLCDCHARDATAHandler,W
	movwf	FSR
	bcf	STATUS, IRP
	btfsc	SysLCDCHARDATAHandler_H,0
	bsf	STATUS, IRP
	movf	INDF,W
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
;wait 5 10us
	movlw	5
	movwf	SysWaitTemp10US
	call	Delay_10US
;Next
	movlw	8
	subwf	LCDTEMP,W
	btfss	STATUS, C
	goto	SysForLoop2
ENDIF10
SysForLoopEnd2
;Restore location
;set LCD_RS off
	bcf	PORTB,3
;LCDWriteByte(0x80)
	movlw	128
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
;wait 5 10us
	movlw	5
	movwf	SysWaitTemp10US
	goto	Delay_10US

;********************************************************************************

LCDNORMALWRITEBYTE
;LCD_I0 3 code
;LCD3_RSState = LCD_RS
	clrf	LCD3_RSSTATE
	btfsc	PORTB,3
	incf	LCD3_RSSTATE,F
ENDIF7
;LCD_EB = 1
	bsf	PORTA,0
;LCD_CB = 0
	bcf	PORTB,4
;REPEAT 8
	movlw	8
	movwf	SysRepeatTemp1
SysRepeatLoop1
;LCD_RS = LCDByte.7
	bcf	PORTB,3
	btfsc	LCDBYTE,7
	bsf	PORTB,3
ENDIF8
;ROTATE LCDByte LEFT
	rlf	LCDBYTE,F
;Clock it Out
;LCD_CB = 1
	bsf	PORTB,4
;LCD_CB = 0
	bcf	PORTB,4
;END REPEAT
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop1
SysRepeatLoopEnd1
;wait 3 ms
	movlw	3
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;LCD_RS = LCD3_RSState  'passed from call.
	bcf	PORTB,3
	btfsc	LCD3_RSSTATE,0
	bsf	PORTB,3
ENDIF9
;wait 3 ms
	movlw	3
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;LCD_EB = 0
	bcf	PORTA,0
;wait 3 ms
	movlw	3
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;LCD_EB = 1
	bsf	PORTA,0
;IF LCDByte < 16 then
	movlw	16
	subwf	LCDBYTE,W
	btfsc	STATUS, C
	goto	ENDIF5
;if LCDByte > 7 then
	movf	LCDBYTE,W
	sublw	7
	btfsc	STATUS, C
	goto	ENDIF6
;LCD_State = LCDByte
	movf	LCDBYTE,W
	movwf	LCD_STATE
;end if
ENDIF6
;END IF
ENDIF5
	return

;********************************************************************************

LCDWRITECHAR
;set LCD_RS on
	bsf	PORTB,3
;LCDWriteByte(LCDChar)
	movf	LCDCHAR,W
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
;wait 5 10us
	return

;********************************************************************************

LOCATE
;Set LCD_RS Off
	bcf	PORTB,3
;If LCDLine > 1 Then
	movf	LCDLINE,W
	sublw	1
	btfsc	STATUS, C
	goto	ENDIF1
;LCDLine = LCDLine - 2
	movlw	2
	subwf	LCDLINE,F
;LCDColumn = LCDColumn + LCD_WIDTH
	movlw	20
	addwf	LCDCOLUMN,F
;End If
ENDIF1
;LCDWriteByte(0x80 or 0x40 * LCDLine + LCDColumn)
	movf	LCDLINE,W
	movwf	SysBYTETempA
	movlw	64
	movwf	SysBYTETempB
	call	SysMultSub
	movf	LCDCOLUMN,W
	addwf	SysBYTETempX,W
	movwf	SysTemp1
	movlw	128
	iorwf	SysTemp1,W
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
;wait 5 10us 'test
	movlw	5
	movwf	SysWaitTemp10US
	goto	Delay_10US

;********************************************************************************

;Overloaded signature: STRING:
PRINT108
;PrintLen = LEN(PrintData$)
;PrintLen = PrintData(0)
	movf	SysPRINTDATAHandler,W
	movwf	FSR
	bcf	STATUS, IRP
	btfsc	SysPRINTDATAHandler_H,0
	bsf	STATUS, IRP
	movf	INDF,W
	movwf	PRINTLEN
;If PrintLen = 0 Then Exit Sub
	movf	PRINTLEN,F
	btfsc	STATUS, Z
	return
ENDIF2
;Set LCD_RS On
	bsf	PORTB,3
;Write Data
;For SysPrintTemp = 1 To PrintLen
	clrf	SYSPRINTTEMP
	movlw	1
	subwf	PRINTLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd1
ENDIF3
SysForLoop1
	incf	SYSPRINTTEMP,F
;LCDWriteByte PrintData(SysPrintTemp)
	movf	SYSPRINTTEMP,W
	addwf	SysPRINTDATAHandler,W
	movwf	FSR
	bcf	STATUS, IRP
	btfsc	SysPRINTDATAHandler_H,0
	bsf	STATUS, IRP
	movf	INDF,W
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
;Next
	movf	PRINTLEN,W
	subwf	SYSPRINTTEMP,W
	btfss	STATUS, C
	goto	SysForLoop1
ENDIF4
SysForLoopEnd1
	return

;********************************************************************************

SYSMULTSUB
;dim SysByteTempA as byte
;dim SysByteTempB as byte
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
MUL8LOOP
;movf SysByteTempA, W
	movf	SYSBYTETEMPA, W
;btfsc SysByteTempB, 0
	btfsc	SYSBYTETEMPB, 0
;addwf SysByteTempX, F
	addwf	SYSBYTETEMPX, F
;bcf STATUS, C
	bcf	STATUS, C
;rrf SysByteTempB, F
	rrf	SYSBYTETEMPB, F
;bcf STATUS, C
	bcf	STATUS, C
;rlf SysByteTempA, F
	rlf	SYSBYTETEMPA, F
;movf SysByteTempB, F
	movf	SYSBYTETEMPB, F
;btfss STATUS, Z
	btfss	STATUS, Z
;goto MUL8LOOP
	goto	MUL8LOOP
	return

;********************************************************************************

SYSREADSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Set pointer
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
;Get length
;call SysStringTables
	call	SYSSTRINGTABLES
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA
;movwf INDF
	movwf	INDF
;addwf SysStringB, F
	addwf	SYSSTRINGB, F
;goto SysStringReadCheck
	goto	SYSSTRINGREADCHECK
SYSREADSTRINGPART
;Set pointer
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
;Get length
;call SysStringTables
	call	SYSSTRINGTABLES
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA
;addwf SysStringLength,F
	addwf	SYSSTRINGLENGTH,F
;addwf SysStringB,F
	addwf	SYSSTRINGB,F
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

SysStringTables
	movf	SysStringA_H,W
	movwf	PCLATH
	movf	SysStringA,W
	incf	SysStringA,F
	btfsc	STATUS,Z
	incf	SysStringA_H,F
	movwf	PCL

StringTable1
	retlw	15
	retlw	71	;G
	retlw	114	;r
	retlw	101	;e
	retlw	97	;a
	retlw	116	;t
	retlw	32	; 
	retlw	67	;C
	retlw	111	;o
	retlw	119	;w
	retlw	32	; 
	retlw	66	;B
	retlw	65	;A
	retlw	83	;S
	retlw	73	;I
	retlw	67	;C


StringTable2
	retlw	4
	retlw	50	;2
	retlw	48	;0
	retlw	49	;1
	retlw	57	;9


StringTable3
	retlw	11
	retlw	83	;S
	retlw	109	;m
	retlw	105	;i
	retlw	108	;l
	retlw	101	;e
	retlw	121	;y
	retlw	32	; 
	retlw	102	;f
	retlw	97	;a
	retlw	99	;c
	retlw	101	;e


StringTable4
	retlw	3
	retlw	32	; 
	retlw	58	;:
	retlw	32	; 


;********************************************************************************

;Start of program memory page 1
	ORG	2048

 END
