;Program compiled by Great Cow BASIC (0.98.<<>> 2019-01-21 (Windows 32 bit))
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F1939, r=DEC
#include <P16F1939.inc>
 __CONFIG _CONFIG1, _CLKOUTEN_OFF & _MCLRE_ON & _WDTE_OFF & _FOSC_INTOSC
 __CONFIG _CONFIG2, _LVP_OFF & _PLLEN_ON & _VCAPEN_OFF

;********************************************************************************

;Set aside memory locations for variables
ADDR	EQU	32
ADDR_H	EQU	33
ANSWER	EQU	34
ANSWER_E	EQU	37
ANSWER_H	EQU	35
ANSWER_U	EQU	36
BYTENUMBER	EQU	38
CCOUNT	EQU	39
CHR	EQU	9030
COL_T6963	EQU	40
COL_T6963_H	EQU	41
COMPORT	EQU	42
DEFAULTDISPLAYMODESTATE_T6963	EQU	43
DELAYTEMP	EQU	112
DELAYTEMP2	EQU	113
GCBBUILDSTR	EQU	8952
GCBBUILDTIMESTR	EQU	8969
GLCDBACKGROUND	EQU	44
GLCDBACKGROUND_H	EQU	45
GLCDFNTDEFAULT	EQU	46
GLCDFNTDEFAULTSIZE	EQU	47
GLCDFONTWIDTH	EQU	48
GLCDFOREGROUND	EQU	49
GLCDFOREGROUND_H	EQU	50
GLCD_YORDINATE	EQU	51
GLCD_YORDINATE_H	EQU	52
HIGHCHAR	EQU	53
LCDBYTE	EQU	54
LCDCHAR	EQU	55
LCDCMDBYTE	EQU	56
LCDCOLUMN	EQU	57
LCDCRSR	EQU	58
LCDDATABYTE	EQU	59
LCDDATAWORD	EQU	60
LCDDATAWORD_H	EQU	61
LCDLINE	EQU	62
LCDPUTCOLUMN	EQU	63
LCDPUTLINE	EQU	64
LCDVALUE	EQU	65
LCDVALUETEMP	EQU	69
LCDVALUE_E	EQU	68
LCDVALUE_H	EQU	66
LCDVALUE_U	EQU	67
LCD_STATE	EQU	70
LINE_X_CURSOR	EQU	71
LONGNUMBER	EQU	72
LONGNUMBER_E	EQU	75
LONGNUMBER_H	EQU	73
LONGNUMBER_U	EQU	74
LOWCHAR	EQU	76
MYBYTE	EQU	77
MYLONG	EQU	78
MYLONG_E	EQU	81
MYLONG_H	EQU	79
MYLONG_U	EQU	80
MYLOOP	EQU	82
MYSTRING	EQU	9071
MYWORD	EQU	83
MYWORD_H	EQU	84
PRINTLEN	EQU	85
REFB	EQU	86
REFB_E	EQU	89
REFB_H	EQU	87
REFB_U	EQU	88
ROW_T6963	EQU	90
ROW_T6963_H	EQU	91
SERDATA	EQU	92
STRINGPOINTER	EQU	93
SYSBYTETEMPA	EQU	117
SYSBYTETEMPB	EQU	121
SYSBYTETEMPX	EQU	112
SYSCALCTEMPA	EQU	117
SYSCALCTEMPA_E	EQU	120
SYSCALCTEMPA_H	EQU	118
SYSCALCTEMPA_U	EQU	119
SYSCALCTEMPX	EQU	112
SYSCALCTEMPX_H	EQU	113
SYSCHAR	EQU	94
SYSDIVLOOP	EQU	116
SYSDIVMULTA	EQU	119
SYSDIVMULTA_H	EQU	120
SYSDIVMULTB	EQU	123
SYSDIVMULTB_H	EQU	124
SYSDIVMULTX	EQU	114
SYSDIVMULTX_H	EQU	115
SYSLCDTEMP	EQU	95
SYSLONGDIVMULTA	EQU	96
SYSLONGDIVMULTA_E	EQU	99
SYSLONGDIVMULTA_H	EQU	97
SYSLONGDIVMULTA_U	EQU	98
SYSLONGDIVMULTB	EQU	100
SYSLONGDIVMULTB_E	EQU	103
SYSLONGDIVMULTB_H	EQU	101
SYSLONGDIVMULTB_U	EQU	102
SYSLONGDIVMULTX	EQU	104
SYSLONGDIVMULTX_E	EQU	107
SYSLONGDIVMULTX_H	EQU	105
SYSLONGDIVMULTX_U	EQU	106
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
SYSPRINTBUFFER	EQU	8958
SYSPRINTBUFFLEN	EQU	108
SYSPRINTDATAHANDLER	EQU	109
SYSPRINTDATAHANDLER_H	EQU	110
SYSPRINTTEMP	EQU	111
SYSREPEATTEMP1	EQU	160
SYSSTRINGA	EQU	119
SYSSTRINGA_H	EQU	120
SYSSTRINGLENGTH	EQU	118
SYSTEMP1	EQU	161
SYSTEMP1_E	EQU	164
SYSTEMP1_H	EQU	162
SYSTEMP1_U	EQU	163
SYSTEMP2	EQU	165
SYSTEMP2_H	EQU	166
SYSWAITTEMPMS	EQU	114
SYSWAITTEMPMS_H	EQU	115
SYSWAITTEMPS	EQU	116
SYSWAITTEMPUS	EQU	117
SYSWAITTEMPUS_H	EQU	118
SYSWORDTEMPA	EQU	117
SYSWORDTEMPA_H	EQU	118
SYSWORDTEMPB	EQU	121
SYSWORDTEMPB_H	EQU	122
SYSWORDTEMPX	EQU	112
SYSWORDTEMPX_H	EQU	113
TEMPVAL	EQU	167
TEMPVAL_E	EQU	170
TEMPVAL_H	EQU	168
TEMPVAL_U	EQU	169
VERSIONSTRING	EQU	8989
WORDNUMBER	EQU	171
WORDNUMBER_H	EQU	172

;********************************************************************************

;Alias variables
AFSR0	EQU	4
AFSR0_H	EQU	5
SYSCHR_0	EQU	1350
SYSCHR_1	EQU	1351

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
	call	INITUSART
	call	INITLCD

;Start of the main program
;''A demonstration program for GCGB and GCB.
;''--------------------------------------------------------------------------------------------------------------------------------
;''This program is a simple GLCD demonstration of the T6963 GLCD capabilities.
;''This program will draws lines, boxes, circles and prints strings and numbers.
;''The GLCD is connected to the microprocessor as shown in the hardware section of this code.
;''@author  EvanV
;''@licence GPL
;''@version 0.9a
;''@date    3.1.19
;''********************************************************************************
;#define GLCD_TYPE 0               ' This is the devlopment value, will be set later, leave a zero.
;#define GLCD_TYPE_T6963 0
;#startup InitGLCD_T6963
;USART settings
;#define USART_BAUD_RATE 9600
;#define USART_TX_BLOCKING
;#define GLCD_DATA_PORT PORTD
;#define STA0         GLCD_DATA_PORT.0   'Check command execution capability
;#define STA1         GLCD_DATA_PORT.1   'Check data read/write capability
;#define STA2         GLCD_DATA_PORT.2   'Check Auto mode data read capability
;#define STA3         GLCD_DATA_PORT.3   'Check Auto mode data write capability
;#define STA5         GLCD_DATA_PORT.5   'Check controller operation capability
;#define STA6         GLCD_DATA_PORT.6   'Error flag. Used for screen peek and screen copy
;#define STA7         GLCD_DATA_PORT.7   'Check the blink condition
;#define GLCD_CS        PORTa.7          'Chip Enable (Active Low)
;#define GLCD_CD        PORTa.0
;#define GLCD_RD        PORTA.1           'LCD Read control line  pin number
;#define GLCD_WR        PORTA.2           'LCD Write control line pin number
;#define GLCD_RESET     PORTA.3
;#define GLCD_FS        PORTA.5            'FS1 I Font Select 6x8 font: FS1=“High”=1 8x8 font FS1=“Low”=1 for GLCD_FS_SELECT
;#define GLCD_FS_SELECT 1
;***********************************************************************************************
;* Note    :   The T6963 controller's RAM address space from $0000 - $FFFF, total 64kbyte RAM.
;*       It is just the RAM address set, not the actual RAM amount can be set!
;*
;***********************************************************************************************
;#define TEXT_HOME_ADDR      0x0000                                                         'This is specific to the GLCD display
;#define GRH_HOME_ADDR       0x3FFF                                                         'This is specific to the GLCD display
;#define CG_HOME_ADDR        0x77FF                                                        'This is specific to the GLCD display
;#define COLUMN              40    'Set column number to be 40 , 32, 30 etc.                 This is specific to the GLCD display
;#define MAX_ROW_PIXEL       64    'MAX_ROW_PIXEL the physical matrix length (y direction)   This is specific to the GLCD display
;#define MAX_COL_PIXEL       240   'MAX_COL_PIXEL the physical matrix width (x direction)    This is specific to the GLCD display
;Change timing for 32 mhz
;#define T6963ReadDelay    1    ; = 1 normal usage
;#define T6963WriteDelay   1    ; = 1 normal usage
;#define T6963ClockDelay   1    ; = 1 normal usage
;Dim BYTENUMBER, CCOUNT as Byte
;CCount = 0
	clrf	CCOUNT
;dim longNumber as long
;longNumber = 4294967290 ' max value = 4294967296
	movlw	250
	movwf	LONGNUMBER
	movlw	255
	movwf	LONGNUMBER_H
	movwf	LONGNUMBER_U
	movwf	LONGNUMBER_E
;dim wordNumber as Word
;dim outString as string
;wordNumber = 0
	banksel	WORDNUMBER
	clrf	WORDNUMBER
	clrf	WORDNUMBER_H
;byteNumber = 0
	banksel	BYTENUMBER
	clrf	BYTENUMBER
;#define debugc4 portc.4
;dir debugc4 out
	banksel	TRISC
	bcf	TRISC,4
;dir GLCD_DATA_PORT out
;dir GLCD_CS        out
;dir GLCD_CD        out
;dir GLCD_RD        out
;dir GLCD_WR        out
;dir GLCD_RESET     out
;dir GLCD_FS        out
;debugc4 = 0
	banksel	LATC
	bcf	LATC,4
;InitGLCD_T6963
	banksel	STATUS
	call	INITGLCD_T6963
	pagesel	$
;------ Version Control - optional
;Include the GCBVersionNumber.cnt to increment versionString and create the build time string called GCBBuildTimeStr.
;versionString a string is created automatically.
;GCBBuildTimeStr is a string that is also created automatically.
;use "GCBVersionNumber.cnt" as this will create a local copy of the versionString tracker.
;if you use <GCBVersionNumber.cnt> this is a system wide versionString tracker.
;dim versionString as string * 40
;versionString = "Build"+GCBBuildStr
	pagesel	FN_GCBBUILDSTR
	call	FN_GCBBUILDSTR
	pagesel	$
	movlw	low VERSIONSTRING
	movwf	FSR1L
	movlw	high VERSIONSTRING
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable2
	movwf	SysStringA
	movlw	(high StringTable2) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low GCBBUILDSTR
	movwf	FSR0L
	movlw	high GCBBUILDSTR
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low VERSIONSTRING
	movwf	FSR0L
	movlw	high VERSIONSTRING
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
;versionString = versionString + "@"+GCBBuildTimeStr
	pagesel	FN_GCBBUILDTIMESTR
	call	FN_GCBBUILDTIMESTR
	pagesel	$
	movlw	low VERSIONSTRING
	movwf	FSR1L
	movlw	high VERSIONSTRING
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low VERSIONSTRING
	movwf	FSR0L
	movlw	high VERSIONSTRING
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low StringTable3
	movwf	SysStringA
	movlw	(high StringTable3) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low GCBBUILDTIMESTR
	movwf	FSR0L
	movlw	high GCBBUILDTIMESTR
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low VERSIONSTRING
	movwf	FSR0L
	movlw	high VERSIONSTRING
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
;print versionString
	movlw	low VERSIONSTRING
	movwf	SysPRINTDATAHandler
	movlw	high VERSIONSTRING
	movwf	SysPRINTDATAHandler_H
	call	PRINT431
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
;Cls
	pagesel	CLS_T6963
	call	CLS_T6963
	pagesel	$
;print "Hello"
	movlw	low StringTable4
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable4) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT431
;locate 4, 30
	movlw	4
	movwf	LCDLINE
	movlw	30
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;print "World"
	movlw	low StringTable5
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable5) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT431
;dim myLoop as Byte
;for myLoop = 0 to 255
	movlw	255
	movwf	MYLOOP
SysForLoop1
	incf	MYLOOP,F
;locate 4,4
	movlw	4
	movwf	LCDLINE
	movlw	4
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;print "0x"
	movlw	low StringTable6
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable6) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT431
;lcdhex ( myLoop, LeadingZeroActive )
	movf	MYLOOP,W
	movwf	LCDVALUE
	movlw	2
	movwf	LCDCHAR
	call	LCDHEX_T6963
;wait 50 ms
;next
	movlw	255
	subwf	MYLOOP,W
	btfss	STATUS, C
	goto	SysForLoop1
ENDIF1
SysForLoopEnd1
;end
	goto	BASPROGRAMEND
;end
	goto	BASPROGRAMEND
;----- Main body of program commences here.
;Do Forever
SysDoLoop_S1
;CLS
	pagesel	CLS_T6963
	call	CLS_T6963
	pagesel	$
;PRINT "START TEST"
	movlw	low StringTable7
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable7) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT431
;locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;PRINT "DISPLAY ON"
	movlw	low StringTable8
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable8) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT431
;wait 3 s
	movlw	3
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
;CLS
	pagesel	CLS_T6963
	call	CLS_T6963
	pagesel	$
;Locate 0,0
	clrf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print "Cursor ON"
	movlw	low StringTable9
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable9) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT431
;Locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;LCDcursor CursorOn
	movlw	2
	movwf	LCDCRSR
	movlw	1
	movwf	LINE_X_CURSOR
	call	LCDCURSOR_T6963
	pagesel	$
;wait 3 S
	movlw	3
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
;CLS
	pagesel	CLS_T6963
	call	CLS_T6963
	pagesel	$
;LCDcursor CursorOFF
	movlw	253
	movwf	LCDCRSR
	movlw	1
	movwf	LINE_X_CURSOR
	call	LCDCURSOR_T6963
	pagesel	$
;locate 0,0
	clrf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print "Cursor OFF"
	movlw	low StringTable10
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable10) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT431
;wait 3 s
	movlw	3
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
;CLS
	pagesel	CLS_T6963
	call	CLS_T6963
	pagesel	$
;Locate 0,0
	clrf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print "FLASH ON"
	movlw	low StringTable11
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable11) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT431
;Locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;LCDcursor FLASHON
	movlw	3
	movwf	LCDCRSR
	movlw	1
	movwf	LINE_X_CURSOR
	call	LCDCURSOR_T6963
	pagesel	$
;wait 3 s
	movlw	3
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
;CLS
	pagesel	CLS_T6963
	call	CLS_T6963
	pagesel	$
;locate 0,0
	clrf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print "FLASH OFF"
	movlw	low StringTable12
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable12) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT431
;LCDCURSOR FLASHOFF
	movlw	252
	movwf	LCDCRSR
	movlw	1
	movwf	LINE_X_CURSOR
	call	LCDCURSOR_T6963
	pagesel	$
;wait 3 sec
	movlw	3
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;Locate 0,0
	clrf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print "CURSR & FLSH ON"
	movlw	low StringTable13
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable13) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT431
;locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;LCDCURSOR CURSORON
	movlw	2
	movwf	LCDCRSR
	movlw	1
	movwf	LINE_X_CURSOR
	call	LCDCURSOR_T6963
	pagesel	$
;LCDCURSOR FLASHON, 8
	movlw	3
	movwf	LCDCRSR
	movlw	8
	movwf	LINE_X_CURSOR
	call	LCDCURSOR_T6963
	pagesel	$
;Wait 3 sec
	movlw	3
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;Locate 0,0
	clrf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print "CURSR & FLSH OFF"
	movlw	low StringTable14
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable14) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT431
;locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;LCDCURSOR CursorOFF
	movlw	253
	movwf	LCDCRSR
	movlw	1
	movwf	LINE_X_CURSOR
	call	LCDCURSOR_T6963
	pagesel	$
;LCDCURSOR FLASHOFF
	movlw	252
	movwf	LCDCRSR
	movlw	1
	movwf	LINE_X_CURSOR
	call	LCDCURSOR_T6963
	pagesel	$
;Wait 3 sec
	movlw	3
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
;CLS
	pagesel	CLS_T6963
	call	CLS_T6963
	pagesel	$
;Locate 0,4
	clrf	LCDLINE
	movlw	4
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;PRINT "Flashing"
	movlw	low StringTable15
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable15) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT431
;Locate 1,4
	movlw	1
	movwf	LCDLINE
	movlw	4
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print "Display"
	movlw	low StringTable16
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable16) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT431
;wait 500 ms
	movlw	244
	movwf	SysWaitTempMS
	movlw	1
	movwf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;repeat 10
	movlw	10
	banksel	SYSREPEATTEMP1
	movwf	SysRepeatTemp1
SysRepeatLoop1
;LCDCURSOR LCDOFF
	movlw	251
	banksel	LCDCRSR
	movwf	LCDCRSR
	movlw	1
	movwf	LINE_X_CURSOR
	call	LCDCURSOR_T6963
	pagesel	$
;wait 500 ms
	movlw	244
	movwf	SysWaitTempMS
	movlw	1
	movwf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;LCDCURSOR LCDON
	movlw	4
	movwf	LCDCRSR
	movlw	1
	movwf	LINE_X_CURSOR
	call	LCDCURSOR_T6963
	pagesel	$
;wait 500 ms
	movlw	244
	movwf	SysWaitTempMS
	movlw	1
	movwf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;end repeat
	banksel	SYSREPEATTEMP1
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop1
SysRepeatLoopEnd1
;CLS
	banksel	STATUS
	pagesel	CLS_T6963
	call	CLS_T6963
	pagesel	$
;Locate 0,0
	clrf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print "DISPLAY OFF"
	movlw	low StringTable17
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable17) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT431
;Locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print "FOR 5 SEC"
	movlw	low StringTable18
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable18) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT431
;Wait 2 SEC
	movlw	2
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;LCDCURSOR LCDOFF
	movlw	251
	movwf	LCDCRSR
	movlw	1
	movwf	LINE_X_CURSOR
	call	LCDCURSOR_T6963
	pagesel	$
;WAIT 5 s
	movlw	5
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
;CLS
	pagesel	CLS_T6963
	call	CLS_T6963
	pagesel	$
;Locate 0,0
	clrf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;LCDCURSOR LCDON
	movlw	4
	movwf	LCDCRSR
	movlw	1
	movwf	LINE_X_CURSOR
	call	LCDCURSOR_T6963
	pagesel	$
;Print "END TEST"
	movlw	low StringTable19
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable19) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT431
;wait 3 s
	movlw	3
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;loop
	goto	SysDoLoop_S1
SysDoLoop_E1
;------ Version Control - optional
;#include "GCBVersionNumber.cnt"
;'Include the GCBVersionNumber.cnt to increment versionString and create the build time string called GCBBuildTimeStr.
;' versionString a string is created automatically.
;' GCBBuildTimeStr is a string that is also created automatically.
;' use "GCBVersionNumber.cnt" as this will create a local copy of the versionString tracker.
;' if you use <GCBVersionNumber.cnt> this is a system wide versionString tracker.
;
;
;dim versionString as string * 40
;versionString = "Build"+GCBBuildStr
;versionString = versionString + "@"+GCBBuildTimeStr
;locate 0,0
	clrf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;GLCDSendCommand_T6963(TEXT_GRH_CURSOR_ON_BLINK_ON)
	movlw	159
	movwf	LCDCMDBYTE
	pagesel	GLCDSENDCOMMAND_T6963
	call	GLCDSENDCOMMAND_T6963
	pagesel	$
;GLCDSendCommand_T6963(LINE_8_CURSOR)
	movlw	167
	movwf	LCDCMDBYTE
	pagesel	GLCDSENDCOMMAND_T6963
	call	GLCDSENDCOMMAND_T6963
	pagesel	$
;print "Hello"
	movlw	low StringTable4
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable4) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT431
;wait 4 s
	movlw	4
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;locate 0,0
	clrf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;LCDSpace ( 10 )
	movlw	10
	movwf	LCDVALUE
	pagesel	LCDSPACE_T6963
	call	LCDSPACE_T6963
	pagesel	$
;wait 1 s
	movlw	1
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;end
	goto	BASPROGRAMEND
;#define INT_CG_MODE         0x80    '0b10000xxx, Internal CG ROM mode
;#define EXT_CG_MODE         0x88    '0b10001xxx, External CG RAM mode
;#define OR_MODE             0x80    '0b1000x000, OR mode, internal CG ROM mODE
;#define XOR_MODE            0x81    '0b1000x001, XOR mode, internal CG ROM mode
;#define AND_MODE            0x83    '0b1000x011, AND mode, internal CG ROM mode
;#define TEXT_ATTR_MODE      0x84    '0b1000x100, text attribute mode, internal CG ROM mode
;GLCDispCmdSend(AUTO_WR_OFF)
;
;GLCDispCmdSend(AUTO_WR_ON)
;GLCDispCmdSend(ATTR_REVERSE)
;GLCDispCmdSend(AUTO_WR_OFF)
;GLCDispCmdSend(TEXT_ATTR_MODE)
;GLCDispCmdSend(CURSOR_BLINK_ON)
;GLCDispCmdSend(TEXT_GRH_ON)
;GLCDispCmdSend(LINE_8_CURSOR)
;LOCATE 0,0
	clrf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;do
SysDoLoop_S2
;loop
	goto	SysDoLoop_S2
SysDoLoop_E2
;end
	goto	BASPROGRAMEND
;GLCDCLS_T6963
	pagesel	GLCDCLS_T6963
	call	GLCDCLS_T6963
	pagesel	$
;
;debugc4 = 1
	banksel	LATC
	bsf	LATC,4
;
;
;dim TempSTR as String
;dim TempVal as Long
;systat calculation
;dim refa as long
;dim refb as Long
;dim answer as Long
;refb =236
	movlw	236
	banksel	REFB
	movwf	REFB
	clrf	REFB_H
	clrf	REFB_U
	clrf	REFB_E
;Tempval=2000
	movlw	208
	banksel	TEMPVAL
	movwf	TEMPVAL
	movlw	7
	movwf	TEMPVAL_H
	clrf	TEMPVAL_U
	clrf	TEMPVAL_E
;answer= refb*Tempval
	banksel	REFB
	movf	REFB,W
	movwf	SysLONGTempA
	movf	REFB_H,W
	movwf	SysLONGTempA_H
	movf	REFB_U,W
	movwf	SysLONGTempA_U
	movf	REFB_E,W
	movwf	SysLONGTempA_E
	banksel	TEMPVAL
	movf	TEMPVAL,W
	movwf	SysLONGTempB
	movf	TEMPVAL_H,W
	movwf	SysLONGTempB_H
	movf	TEMPVAL_U,W
	movwf	SysLONGTempB_U
	movf	TEMPVAL_E,W
	movwf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SysMultSub32
	call	SysMultSub32
	pagesel	$
	movf	SysLONGTempX,W
	movwf	ANSWER
	movf	SysLONGTempX_H,W
	movwf	ANSWER_H
	movf	SysLONGTempX_U,W
	movwf	ANSWER_U
	movf	SysLONGTempX_E,W
	movwf	ANSWER_E
;dim myString as String * 128
;locate 0,0
	clrf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;myString = "basil HATZILAIOS [hatzbs@yahoo.gr]"
	movlw	low MYSTRING
	movwf	FSR1L
	movlw	high MYSTRING
	movwf	FSR1H
	movlw	low StringTable20
	movwf	SysStringA
	movlw	(high StringTable20) & 127
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
;print myString
	movlw	low MYSTRING
	movwf	SysPRINTDATAHandler
	movlw	high MYSTRING
	movwf	SysPRINTDATAHandler_H
	call	PRINT431
;locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;#define myConstant 10
;print myConstant
	movlw	10
	movwf	LCDVALUE
	pagesel	PRINT432
	call	PRINT432
	pagesel	$
;locate 2,0
	movlw	2
	movwf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;dim myByte as byte
;myByte = 20
	movlw	20
	movwf	MYBYTE
;print myByte
	movwf	LCDVALUE
	pagesel	PRINT432
	call	PRINT432
	pagesel	$
;locate 3,0
	movlw	3
	movwf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;dim myWord as word
;myWord = 0xffff
	movlw	255
	movwf	MYWORD
	movwf	MYWORD_H
;print myWord
	movf	MYWORD,W
	movwf	LCDVALUE
	movf	MYWORD_H,W
	movwf	LCDVALUE_H
	call	PRINT433
	pagesel	$
;locate 4,0
	movlw	4
	movwf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;dim mylong as long
;mylong =0xffffffff
	movlw	255
	movwf	MYLONG
	movwf	MYLONG_H
	movwf	MYLONG_U
	movwf	MYLONG_E
;print mylong
	movf	MYLONG,W
	movwf	LCDVALUE
	movf	MYLONG_H,W
	movwf	LCDVALUE_H
	movf	MYLONG_U,W
	movwf	LCDVALUE_U
	movf	MYLONG_E,W
	movwf	LCDVALUE_E
	call	PRINT435
;locate 5,0
	movlw	5
	movwf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;myString = "This is line 5"
	movlw	low MYSTRING
	movwf	FSR1L
	movlw	high MYSTRING
	movwf	FSR1H
	movlw	low StringTable21
	movwf	SysStringA
	movlw	(high StringTable21) & 127
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
;HSerPrint myString
	movlw	low MYSTRING
	movwf	SysPRINTDATAHandler
	movlw	high MYSTRING
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT580
	call	HSERPRINT580
	pagesel	$
;print myString
	movlw	low MYSTRING
	movwf	SysPRINTDATAHandler
	movlw	high MYSTRING
	movwf	SysPRINTDATAHandler_H
	call	PRINT431
;locate 6,0
	movlw	6
	movwf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;myString = "This is line 6"
	movlw	low MYSTRING
	movwf	FSR1L
	movlw	high MYSTRING
	movwf	FSR1H
	movlw	low StringTable22
	movwf	SysStringA
	movlw	(high StringTable22) & 127
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
;print myString
	movlw	low MYSTRING
	movwf	SysPRINTDATAHandler
	movlw	high MYSTRING
	movwf	SysPRINTDATAHandler_H
	call	PRINT431
;locate 7,0
	movlw	7
	movwf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;myString = "This is line 7"
	movlw	low MYSTRING
	movwf	FSR1L
	movlw	high MYSTRING
	movwf	FSR1H
	movlw	low StringTable23
	movwf	SysStringA
	movlw	(high StringTable23) & 127
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
;print myString
	movlw	low MYSTRING
	movwf	SysPRINTDATAHandler
	movlw	high MYSTRING
	movwf	SysPRINTDATAHandler_H
	call	PRINT431
;wait 1 s
	movlw	1
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
;#define DISPLAY_OFF         0x90    '0b10010000, display off
;#define CURSOR_ON_BLINK_OFF 0x92    '0b1001xx10, cursor on without blinking
;#define CURSOR_BLINK_ON     0x93    '0b1001xx11, cursor on with blinking
;#define TEXT_ON             0x94    '0b100101xx, text on, graphics off
;#define GRAPHIC_ON          0x98    '0b100110xx, text off, graphics on
;#define TEXT_GRH_ON         0x9C    '0b100111xx, text on, graphics on
;#define INT_CG_MODE         0x80    '0b10000xxx, Internal CG ROM mode
;#define EXT_CG_MODE         0x88    '0b10001xxx, External CG RAM mode
;#define OR_MODE             0x80    '0b1000x000, OR mode, internal CG ROM mODE
;#define XOR_MODE            0x81    '0b1000x001, XOR mode, internal CG ROM mode
;#define AND_MODE            0x83    '0b1000x011, AND mode, internal CG ROM mode
;#define TEXT_ATTR_MODE      0x84    '0b1000x100, text attribute mode, internal CG ROM mode
;#define LINE_8_CURSOR   0xA7    '8-line cursor mode
;#define LINE_7_CURSOR   0xA6  '7-line cursor mode
;#define LINE_6_CURSOR   0xA5  '6-line cursor mode
;#define LINE_5_CURSOR   0xA4  '5-line cursor mode
;#define LINE_4_CURSOR   0xA3  '4-line cursor mode
;#define LINE_3_CURSOR   0xA2  '3-Line cursor mode
;#define LINE_2_CURSOR   0xA1  '2-Line cursor mode
;#define LINE_1_CURSOR   0xA0    '1-Line cursor mode
;cls
	pagesel	CLS_T6963
	call	CLS_T6963
	pagesel	$
;locate 0,0
	clrf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;print "Turning off"
	movlw	low StringTable24
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable24) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT431
;wait 1 s
	movlw	1
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;GLCDSendCommand_T6963  0x9d
	movlw	157
	movwf	LCDCMDBYTE
	pagesel	GLCDSENDCOMMAND_T6963
	call	GLCDSENDCOMMAND_T6963
	pagesel	$
;GLCDSendCommand_T6963  0xa7
	movlw	167
	movwf	LCDCMDBYTE
	pagesel	GLCDSENDCOMMAND_T6963
	call	GLCDSENDCOMMAND_T6963
	pagesel	$
;GLCDSendCommand_T6963 0x92
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
;cls
	pagesel	CLS_T6963
	call	CLS_T6963
	pagesel	$
;print "Turning on"
	movlw	low StringTable25
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable25) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT431
;wait 1 s
	movlw	1
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;GLCDSendCommand_T6963  0x9d
	movlw	157
	movwf	LCDCMDBYTE
	pagesel	GLCDSENDCOMMAND_T6963
	call	GLCDSENDCOMMAND_T6963
	pagesel	$
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
;cls
	pagesel	CLS_T6963
	call	CLS_T6963
	pagesel	$
;locate 7,39
	movlw	7
	movwf	LCDLINE
	movlw	39
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;myString = "*"
	movlw	low MYSTRING
	movwf	FSR1L
	movlw	high MYSTRING
	movwf	FSR1H
	movlw	low StringTable26
	movwf	SysStringA
	movlw	(high StringTable26) & 127
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
;print myString
	movlw	low MYSTRING
	movwf	SysPRINTDATAHandler
	movlw	high MYSTRING
	movwf	SysPRINTDATAHandler_H
	call	PRINT431
;Put ( 3, 0, 0x21 )
	movlw	3
	movwf	LCDPUTLINE
	clrf	LCDPUTCOLUMN
	movlw	33
	movwf	LCDCHAR
	pagesel	PUT_T6963
	call	PUT_T6963
	pagesel	$
;for mylong = 0 to 255
	movlw	255
	movwf	MYLONG
	movwf	MYLONG_H
	movwf	MYLONG_U
	movwf	MYLONG_E
SysForLoop2
	incf	MYLONG,F
	btfsc	STATUS,Z
	incf	MYLONG_H,F
	btfsc	STATUS,Z
	incf	MYLONG_U,F
	btfsc	STATUS,Z
	incf	MYLONG_E,F
;locate 0,0
	clrf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;LCDhex ( mylong, LeadingZeroActive )
	movf	MYLONG,W
	movwf	LCDVALUE
	movlw	2
	movwf	LCDCHAR
	call	LCDHEX_T6963
;wait 500 ms
	movlw	244
	movwf	SysWaitTempMS
	movlw	1
	movwf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;next
	movf	MYLONG,W
	movwf	SysLONGTempA
	movf	MYLONG_H,W
	movwf	SysLONGTempA_H
	movf	MYLONG_U,W
	movwf	SysLONGTempA_U
	movf	MYLONG_E,W
	movwf	SysLONGTempA_E
	movlw	255
	movwf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop2
ENDIF2
SysForLoopEnd2
;end
	goto	BASPROGRAMEND
;wait 5 s
	movlw	5
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;GLCDCmdAddrSend_T6963( 320 ,TEXT_HOME_SET)
	movlw	64
	movwf	LCDDATAWORD
	movlw	1
	movwf	LCDDATAWORD_H
	movlw	64
	movwf	LCDCMDBYTE
	pagesel	GLCDCMDADDRSEND_T6963
	call	GLCDCMDADDRSEND_T6963
	pagesel	$
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;dim addr as word
;GLCDispCmdAddrSend(320,ADDR_PTR_SET) 'Set address pointer
	movlw	64
	movwf	LCDDATAWORD
	movlw	1
	movwf	LCDDATAWORD_H
	movlw	36
	movwf	LCDCMDBYTE
	pagesel	GLCDCMDADDRSEND_T6963
	call	GLCDCMDADDRSEND_T6963
	pagesel	$
;Set Auto Write ON
;GLCDispCmdSend(AUTO_WR_ON)
	movlw	176
	movwf	LCDCMDBYTE
	pagesel	GLCDSENDCOMMAND_T6963
	call	GLCDSENDCOMMAND_T6963
	pagesel	$
;dim row_T6963, col_T6963 as word
;row runs from 0 ... (MAX_ROW_PIXEL/8 -1), in form of a cell of (FontSize x 8) bits
;for  row_T6963 =  0 to ( MAX_ROW_PIXEL/8 ) -1
	movlw	255
	movwf	ROW_T6963
	movwf	ROW_T6963_H
SysForLoop3
	incf	ROW_T6963,F
	btfsc	STATUS,Z
	incf	ROW_T6963_H,F
;write blank to clear screen the first page only, col = 0...(COLUMN-1)
;for col_T6963 = 0 to COLUMN - 1
	movlw	255
	movwf	COL_T6963
	movwf	COL_T6963_H
SysForLoop4
	incf	COL_T6963,F
	btfsc	STATUS,Z
	incf	COL_T6963_H,F
;GLCDispAutoDataWr ( 0 )
	clrf	LCDDATABYTE
	pagesel	GLCDISPAUTODATAWR
	call	GLCDISPAUTODATAWR
	pagesel	$
;next
	movf	COL_T6963,W
	movwf	SysWORDTempA
	movf	COL_T6963_H,W
	movwf	SysWORDTempA_H
	movlw	39
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop4
ENDIF5
SysForLoopEnd4
;next
	movf	ROW_T6963,W
	movwf	SysWORDTempA
	movf	ROW_T6963_H,W
	movwf	SysWORDTempA_H
	movlw	7
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop3
ENDIF6
SysForLoopEnd3
;GLCDispCmdAddrSend(320,ADDR_PTR_SET)
	movlw	64
	movwf	LCDDATAWORD
	movlw	1
	movwf	LCDDATAWORD_H
	movlw	36
	movwf	LCDCMDBYTE
	pagesel	GLCDCMDADDRSEND_T6963
	call	GLCDCMDADDRSEND_T6963
	pagesel	$
;myString = "This is line 1 Page 2"
	movlw	low MYSTRING
	movwf	FSR1L
	movlw	high MYSTRING
	movwf	FSR1H
	movlw	low StringTable27
	movwf	SysStringA
	movlw	(high StringTable27) & 127
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
;HSerPrint myString
	movlw	low MYSTRING
	movwf	SysPRINTDATAHandler
	movlw	high MYSTRING
	movwf	SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT
	pagesel	HSERPRINT580
	call	HSERPRINT580
	pagesel	$
;print myString
	movlw	low MYSTRING
	movwf	SysPRINTDATAHandler
	movlw	high MYSTRING
	movwf	SysPRINTDATAHandler_H
	call	PRINT431
;
;#define pset PSet_T6963
;#define LCD_IO T36363
;Non-functional - the device does not support BYTE read of a character only bit read of pixel
;Sub to print a number of spaces - upto COLUMN
;#define LCDON 4
;#define FLASHON 3
;#define FLASH 3
;#define CursorON 2
;#define FLASHOFF 0xFC   'an AND MASK
;#define CursorOFF 0xFD  'an AND MASK
;#define LCDOFF 0xFB     'an AND MASK
;' Prepare the static components of the screen
;GLCDPrint ( 0,   0, "PrintStr")                                ; Print some text
;GLCDPrint ( 64,  0, "LAT@")                                    ; Print some more text
;GLCDPrint ( 88,  0, ChipMhz)                                   ; Print chip speed
;GLCDPrint ( 100, 0, "Mhz")                                     ; Print some text
;GLCDDrawString( 0,8,"DrawStr")                                 ; Draw some text
;box 0,0,GLCD_WIDTH-1, GLCD_HEIGHT-1                            ; Draw a box
;box GLCD_WIDTH-5, GLCD_HEIGHT-5,GLCD_WIDTH-1, GLCD_HEIGHT-1    ; Draw a box
;Circle( 44,41,15)                                              ; Draw a circle
;line 64,31,0,31                                                ; Draw a line
;
;DO forever
;for CCount = 32 to 127
;GLCDPrint ( 64 ,  36,  hex(longNumber_E ) )                 ; Print a HEX string
;GLCDPrint ( 76 ,  36,  hex(longNumber_U ) )                 ; Print a HEX string
;GLCDPrint ( 88 ,  36,  hex(longNumber_H ) )                 ; Print a HEX string
;GLCDPrint ( 100 ,  36, hex(longNumber   ) )                 ; Print a HEX string
;GLCDPrint ( 112 ,  36, "h" )                                ; Print a HEX string
;
;
;GLCDPrint ( 64 ,  44, pad(str(wordNumber), 5 ) )           ; Print a padded string
;GLCDPrint ( 64 ,  52, pad(str(byteNumber), 3 ) )           ; Print a padded string
;
;
;box (46,9,56,19)                                           ; Draw a Box
;GLCDDrawChar(48, 9, CCount )                               ; Draw a character
;outString = str( CCount )                                  ; Prepare a string
;GLCDDrawString(64, 9, pad(outString,3) )                   ; Draw a string
;
;filledbox 3,43,11,51, wordNumber                           ; Draw a filled box
;
;FilledCircle( 44,41,9, longNumber xor 1)                   ; Draw a filled box
;line 0,63,64,31                                            ; Draw a line
;
;; Do some simple maths
;longNumber = longNumber + 7 : wordNumber = wordNumber + 3 : byteNumber++
;NEXT
;LOOP
;
;end
;#define ENABLE              1
;#define DISABLE             0
;#define BLACK               1
;#define WHITE               0
;#define DISPLAY_OFF                            0x90    '0b10010000, display off
;#define CURSOR_ON_BLINK_OFF                    0x92    '0b1001xx10, cursor on without blinking
;#define CURSOR_BLINK_ON                        0x93    '0b1001xx11, cursor on with blinking
;#define TEXT_ON                                0x94    '0b100101xx, text on, graphics off
;#define TEXT_ON                                0x94    '0b100101xx, text on, graphics off
;#define TEXT_ON                                0x94    '0b100101xx, text on, graphics off
;#define TEXT_ON_CURSOR_ON_BLINK_OFF            0x96    '0b10010110, text on, graphics off, cursor on without blinking
;#define TEXT_ON_CURSOR_ON_BLINK_ON             0x97    '0b10010111, text on, graphics off, cursor on with blinking
;#define GRAPHIC_ON                             0x98    '0b100110xx, text off, graphics on
;#define TEXT_GRH_ON                            0x9C    '0b100111xx, text on, graphics on
;#define TEXT_GRH_C                             0x9C    '0b100111xx, text on, graphics on
;#define TEXT_GRH_CURSOR_ON_BLINK_OFF           0x9E    '0b10011110, text on, graphics on, cursor on without blinking
;#define TEXT_GRH_CURSOR_ON_BLINK_ON            0x9F    '0b10011111, text on, graphics on, cursor on with blinking
;#define INT_CG_MODE         0x80    '0b10000xxx, Internal CG ROM mode
;#define EXT_CG_MODE         0x88    '0b10001xxx, External CG RAM mode
;#define OR_MODE             0x80    '0b1000x000, OR mode, internal CG ROM mODE
;#define XOR_MODE            0x81    '0b1000x001, XOR mode, internal CG ROM mode
;#define AND_MODE            0x83    '0b1000x011, AND mode, internal CG ROM mode
;#define TEXT_ATTR_MODE      0x84    '0b1000x100, text attribute mode, internal CG ROM mode
;#define LINE_8_CURSOR   0xA7    '8-line cursor mode
;#define LINE_7_CURSOR   0xA6  '7-line cursor mode
;#define LINE_6_CURSOR   0xA5  '6-line cursor mode
;#define LINE_5_CURSOR   0xA4  '5-line cursor mode
;#define LINE_4_CURSOR   0xA3  '4-line cursor mode
;#define LINE_3_CURSOR   0xA2  '3-Line cursor mode
;#define LINE_2_CURSOR   0xA1  '2-Line cursor mode
;#define LINE_1_CURSOR   0xA0    '1-Line cursor mode
;#define ATTR_NORMAL         0x00    'Normal Display
;#define ATTR_REVERSE        0x05    'Reverse Display
;#define ATTR_INHIBIT        0x03    'Inhibit Display
;#define ATTR_BLINK          0x08    'Blinking of Normal Display
;#define ATTR_BLINK_REVERSE  0x0D    'Blinking of Reverse Display
;#define ATTR_BLINK_INHIBIT  0x0B    'Blinking of Inhibit Display
;#define CURSOR_PTR_SET      0x21    'Cursor Pointer Set
;#define OFFSET_REG_SET      0x22    'Set Offset Command
;#define ADDR_PTR_SET        0x24    'Set Address Pointer Command
;#define TEXT_HOME_SET       0x40    'Text Home Address Set: Data = low, high addr
;#define TEXT_AREA_SET       0x41    'Text Area Set: Data = columns, 0
;#define GRAPH_HOME_SET      0x42    'Graphics Home address Set: Data = low, high addr
;#define GRAPH_AREA_SET      0x43    'Graphics Area Set: Data = columns, 0
;#define SCREEN_PEEK         0xE0    'Read data from screen command
;#define SCREEN_COPY         0xE8    'Screen Copy
;#define AUTO_WR_ON          0xB0
;#define DATA_AUTO_RD        0xB1
;#define AUTO_WR_OFF         0xB2
;#define DATA_WR_INC         0xC0    ' Data write and increment addrespointer
;#define DATA_RD_INC         0xC1    ' Data read and increment  addrespointer
;#define DATA_WR_DEC         0xC2    ' Data write and decrement addrespointer
;#define DATA_RD_DEC         0xC3    ' Data read and decrement  addrespointer
;#define DATA_WR             0xC4    ' Data write - no addr change
;#define DATA_RD             0xC5    ' Data read  - no addr change
;Subs
;''Clears the GLCD screen
;''Draws a pixel on the GLCD
;''@param GLCDX X coordinate of pixel
;''@param GLCDY Y coordinate of pixel
;''@param GLCDColour State of pixel (0 = background, 1 = foreground )
;#define FontSize 8
;#define GLCDispCmdAddrSend  GLCDCmdAddrSend_T6963
;#define  GLCDispCmdSend GLCDSendCommand_T6963
;#define GLCDispDataWr  GLCDSendData_T6963
;FONTSELECT VAR PORTJ.6'SET FONT SIZE PIN
;*MD VAR PORTJ.5'I THINK THIS IS FOR SELECTING THE HALF OF DISPLAY TO WRITE TO
;*RESET VAR PORTJ.4'RESET PIN
;*CS VAR PORTJ.3'CHIP SELECT PIN
;*WR VAR PORTJ.2'WRITE PIN
;*RD VAR PORTJ.1'READ PIN
;*CD VAR PORTJ.0'COMMAND DATA PIN
;DATAOUT VAR PORTH 'DATA PORT
;B0 VAR WORD
;
;HIGH RESET
;HIGH CS'ENABLE WRITE MODE
;LOW CD'SET TO DATA MODE
;HIGH WR'SET WRITE PIN TO HIGH
;HIGH RD'SET READ PIN TO HIGH
;HIGH FONTSELECT'SET FONT SIZE
;HIGH MD'I THINK THIS IS FOR SELECTING THE HALF OF DISPLAY TO WRITE TO
;
;PAUSE 1000
;
;PULSOUT RESET,1 :PAUSE 1000
;CD=1:DATAOUT=$80:PAUSEUS 1:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 1:CD=0:PAUSEUS 1'MODE SET
;CD=1:DATAOUT=$94:PAUSEUS 1:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 1:CD=0:PAUSEUS 1'DISPLAY ON IN TEXT ONLY MODE
;
;PAUSE 1000
;
;CD=0:DATAOUT=$00:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'LSB
;CD=0:DATAOUT=$10:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'MSB
;CD=1:DATAOUT=$42:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'GRAPHIC HOME ADDRESS
;
;CD=0:DATAOUT=$28:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'LSB
;CD=0:DATAOUT=$00:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'MSB
;CD=1:DATAOUT=$43:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'GRAPHIC AREA SET COMMAND
;
;CD=0:DATAOUT=$00:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'LSB
;CD=0:DATAOUT=$00:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'MSB
;CD=1:DATAOUT=$40:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'TEXT HOME ADDRESS
;
;CD=0:DATAOUT=$28:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'LSB
;CD=0:DATAOUT=$00:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'MSB
;CD=1:DATAOUT=$41:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'TEXT AREA SET COMMAND
;
;PAUSE 1000
;GOSUB CLEARSCREEN
;PAUSE 1000
;
;'WRITE HELLO START OF LINE 1
;CD=0:DATAOUT=$00:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'LSB
;CD=0:DATAOUT=$00:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'MSB
;CD=1:DATAOUT=$24:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'TEXT POINTER SET(SETS WHERE TEXT IS TO START WRITING ON SCREEN)
;CD=0:DATAOUT=$28:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'LETTER H
;CD=1:DATAOUT=$C0:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'DATA INCREMENT
;CD=0:DATAOUT=$25:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'LETTER E
;CD=1:DATAOUT=$C0:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'DATA INCREMENT
;CD=0:DATAOUT=$2C:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'LETTER L
;CD=1:DATAOUT=$C0:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'DATA INCREMENT
;CD=0:DATAOUT=$2C:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'LETTER L
;CD=1:DATAOUT=$C0:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'DATA INCREMENT
;CD=0:DATAOUT=$2F:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'LETTER O
;CD=1:DATAOUT=$C0:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'DATA INCREMENT
;
;'WRITE WORLD START OF LINE 2
;CD=0:DATAOUT=$28:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'LSB
;CD=0:DATAOUT=$00:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'MSB
;CD=1:DATAOUT=$24:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'TEXT POINTER SET(SETS WHERE TEXT IS TO START WRITING ON SCREEN)
;CD=0:DATAOUT=$37:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'LETTER W
;CD=1:DATAOUT=$C0:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'DATA INCREMENT
;CD=0:DATAOUT=$2F:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'LETTER O
;CD=1:DATAOUT=$C0:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'DATA INCREMENT
;CD=0:DATAOUT=$32:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'LETTER R
;CD=1:DATAOUT=$C0:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'DATA INCREMENT
;CD=0:DATAOUT=$2C:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'LETTER L
;CD=1:DATAOUT=$C0:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'DATA INCREMENT
;CD=0:DATAOUT=$24:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'LETTER D
;CD=1:DATAOUT=$C0:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'DATA INCREMENT
;
;Q:
;GOTO Q
;
;CLEARSCREEN:
;CD=0:DATAOUT=$00:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'LSB
;CD=0:DATAOUT=$00:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'MSB
;CD=1:DATAOUT=$24:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'TEXT POINTER SET(SETS WHERE TEXT IS TO START WRITING ON SCREEN)
;FOR B0=0 TO 319
;CD=0:DATAOUT=$00:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'SEND A SPACE
;CD=1:DATAOUT=$C0:PAUSEUS 2:CS=0:PULSOUT WR,1:CS=1:PAUSEUS 2:CD=0:PAUSEUS 2'DATA INCREMENT
;NEXT B0
;RETURN
;#define ST7920ReadDelay = 20
;#define ST7920WriteDelay = 2
;#define ILI9326_DataPort GLCD_DataPort
;#define ILI9326_GLCD_RST GLCD_RST
;#define ILI9326_GLCD_CS  GLCD_CS
;#define ILI9326_GLCD_RS  GLCD_RS
;#define ILI9326_GLCD_WR  GLCD_WR
;#define ILI9326_GLCD_RD  GLCD_RD
;#define ILI9486L_RST GLCD_RST
;#define ILI9486L_CS GLCD_CS
;#define ILI9486L_DC GLCD_DC
;#define ILI9486L_WR GLCD_WR
;#define ILI9486L_RD GLCD_RD
;#define ILI9486L_DB0 GLCD_DB0
;#define ILI9486L_DB1 GLCD_DB1
;#define ILI9486L_DB2 GLCD_DB2
;#define ILI9486L_DB3 GLCD_DB3
;#define ILI9486L_DB4 GLCD_DB4
;#define ILI9486L_DB5 GLCD_DB5
;#define ILI9486L_DB6 GLCD_DB6
;#define ILI9486L_DB7 GLCD_DB7
;#define ILI9486L_RST GLCD_RST
;#define ILI9486L_CS GLCD_CS
;#define ILI9486L_DC GLCD_DC
;#define ILI9486L_WR GLCD_WR
;#define ILI9486L_RD GLCD_RD
;#define tinyDelay nop:nop
;#define ILI9481_GLCD_RST GLCD_RST
;#define ILI9481_GLCD_CS GLCD_CS
;#define ILI9481_GLCD_RS GLCD_RS
;#define ILI9481_GLCD_WR GLCD_WR
;#define ILI9481_GLCD_RD GLCD_RD
;#define ILI9481_GLCD_DB0 GLCD_DB0
;#define ILI9481_GLCD_DB1 GLCD_DB1
;#define ILI9481_GLCD_DB2 GLCD_DB2
;#define ILI9481_GLCD_DB3 GLCD_DB3
;#define ILI9481_GLCD_DB4 GLCD_DB4
;#define ILI9481_GLCD_DB5 GLCD_DB5
;#define ILI9481_GLCD_DB6 GLCD_DB6
;#define ILI9481_GLCD_DB7 GLCD_DB7
;#define ILI9481_GLCD_RST GLCD_RST
;#define ILI9481_GLCD_CS GLCD_CS
;#define ILI9481_GLCD_RS GLCD_RS
;#define ILI9481_GLCD_WR GLCD_WR
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

;********************************************************************************

INITGLCD_T6963
;Setup code for T6963 controllers
;#define T6963ReadDelay   9     ; 2 normal usage, 3 for 32 mhz!
;#define T6963WriteDelay  1     ; 1 normal usage, 0 works
;#define T6963ClockDelay  1     ; 1 normal usage, 0 works
;#define GLCDDirection    0     ; 0 normal mode
;Set pin directions
;dir GLCD_DATA_PORT out
	banksel	TRISD
	clrf	TRISD
;dir GLCD_CS        out
	bcf	TRISA,7
;dir GLCD_CD        out
	bcf	TRISA,0
;dir GLCD_RD        out
	bcf	TRISA,1
;dir GLCD_WR        out
	bcf	TRISA,2
;dir GLCD_RESET     out
	bcf	TRISA,3
;dir GLCD_FS        out
	bcf	TRISA,5
;Reset cycle
;GLCD_RESET = 0
	banksel	LATA
	bcf	LATA,3
;GLCD_CD = 1
	bsf	LATA,0
;GLCD_CS = 1
	bsf	LATA,7
;GLCD_RD = 1
	bsf	LATA,1
;GLCD_WR = 1
	bsf	LATA,2
;GLCD_FS  = GLCD_FS_SELECT
	bsf	LATA,5
;GLCD_DATA_PORT = 0
	banksel	PORTD
	clrf	PORTD
;wait 5 ms
	movlw	5
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;GLCD_RESET = 1
	banksel	LATA
	bsf	LATA,3
;
;***********************************************************************************************
;*                   GLOBAL CONSTANTS
;***********************************************************************************************
;
;
;***********************************************************************************************
;*                   DISPLAY MODE
;***********************************************************************************************
;
;
;***********************************************************************************************
;*                     MODE
;***********************************************************************************************
;* Example:  OR_MODE|EXT_CG_MODE   ->  OR mode, external CG ram mode
;*       AND_MODE        ->  AND mode, internal CG ROM mode
;***********************************************************************************************
;
;
;***********************************************************************************************
;*   In internal CG ROM MODE (INT_CG_MODE), character codes 00h - 7Fh represent the
;*   pre-defined "internal" CG ROM characters, and codes 80h - FFh represent the
;*   users own "external" characters. In external CG ROM MODE (EXT_CG_MODE),
;*   all 256 codes from 00h - FFh can be used to represent the users own characters.
;***********************************************************************************************
;
;
;***********************************************************************************************
;*                   CURSOR MODE
;***********************************************************************************************
;
;
;***********************************************************************************************
;*                 TEXT ATTRIBUTE MODE
;***********************************************************************************************
;
;Set Text Home address to TEXT_HOME_ADDR
;GLCDCmdAddrSend_T6963(TEXT_HOME_ADDR,TEXT_HOME_SET)
	banksel	LCDDATAWORD
	clrf	LCDDATAWORD
	clrf	LCDDATAWORD_H
	movlw	64
	movwf	LCDCMDBYTE
	pagesel	GLCDCMDADDRSEND_T6963
	call	GLCDCMDADDRSEND_T6963
	pagesel	$
;Set Graph Home address to GRH_HOME_ADDR
;GLCDCmdAddrSend_T6963(GRH_HOME_ADDR,GRAPH_HOME_SET)
	movlw	255
	movwf	LCDDATAWORD
	movlw	63
	movwf	LCDDATAWORD_H
	movlw	66
	movwf	LCDCMDBYTE
	pagesel	GLCDCMDADDRSEND_T6963
	call	GLCDCMDADDRSEND_T6963
	pagesel	$
;Set Text Area to COLUMN column mode
;GLCDCmdAddrSend_T6963(COLUMN,TEXT_AREA_SET)
	movlw	40
	movwf	LCDDATAWORD
	clrf	LCDDATAWORD_H
	movlw	65
	movwf	LCDCMDBYTE
	pagesel	GLCDCMDADDRSEND_T6963
	call	GLCDCMDADDRSEND_T6963
	pagesel	$
;Set Graph Area to COLUMN column mode
;GLCDCmdAddrSend_T6963(COLUMN,GRAPH_AREA_SET)
	movlw	40
	movwf	LCDDATAWORD
	clrf	LCDDATAWORD_H
	movlw	67
	movwf	LCDCMDBYTE
	pagesel	GLCDCMDADDRSEND_T6963
	call	GLCDCMDADDRSEND_T6963
	pagesel	$
;Set Offset register to 0x0002, CG Ram start address = $1400 (CG_HOME_ADDR)
;first character code $80 for CG Ram
;GLCDCmdAddrSend_T6963(0x0002,OFFSET_REG_SET)
	movlw	2
	movwf	LCDDATAWORD
	clrf	LCDDATAWORD_H
	movlw	34
	movwf	LCDCMDBYTE
	pagesel	GLCDCMDADDRSEND_T6963
	call	GLCDCMDADDRSEND_T6963
	pagesel	$
;'Set Text Home address to TEXT_HOME_ADDR
;GLCDSendData_T6963 ( 0x00 )    'Send LSB of 'Addr' first
;GLCDSendData_T6963 ( 0x00 )    'Send MSB of 'Addr' afterwards
;GLCDSendCommand_T6963 ( 0x40 )
;
;'Set Graph Home address to GRH_HOME_ADDR
;GLCDSendData_T6963 ( 0x00 )
;GLCDSendData_T6963 ( 0x02 )
;GLCDSendCommand_T6963 ( 0x42 )
;
;'Set Text Area to COLUMN column mode
;GLCDSendData_T6963 ( 0x20 )
;GLCDSendData_T6963 ( 0x00 )
;GLCDSendCommand_T6963 ( 0x41 )
;
;'Set Graph Area to COLUMN column mode
;GLCDSendData_T6963 ( 0x20 )
;GLCDSendData_T6963 ( 0x00 )
;GLCDSendCommand_T6963 ( 0x43 )
;
;'Set Offset register to 0x0002, CG Ram start address = $1400 (CG_HOME_ADDR)
;'first character code $80 for CG Ram
;GLCDSendData_T6963 ( 0x02 )
;GLCDSendData_T6963 ( 0x00 )
;GLCDSendCommand_T6963 ( 0x22 )
;
;GLCDSendCommand_T6963 ( OR_MODE )
	movlw	128
	movwf	LCDCMDBYTE
	pagesel	GLCDSENDCOMMAND_T6963
	call	GLCDSENDCOMMAND_T6963
	pagesel	$
;dim DefaultDisplayModeState_T6963 as byte
;DefaultDisplayModeState_T6963 = DefaultDisplayModeInitialState_T6963_script
	movlw	156
	movwf	DEFAULTDISPLAYMODESTATE_T6963
;GLCDSendCommand_T6963 ( DefaultDisplayModeState_T6963 )
	movwf	LCDCMDBYTE
	pagesel	GLCDSENDCOMMAND_T6963
	call	GLCDSENDCOMMAND_T6963
	pagesel	$
;GLCDSendCommand_T6963(LINE_1_CURSOR)
	movlw	160
	movwf	LCDCMDBYTE
	pagesel	GLCDSENDCOMMAND_T6963
	call	GLCDSENDCOMMAND_T6963
	pagesel	$
;wait 1 s
;GLCDSendData_T6963 ( 0x00 )
;GLCDSendData_T6963 ( 0x10 )
;GLCDSendCommand_T6963 ( 0x42 )
;
;GLCDSendData_T6963 ( 0x28 )
;GLCDSendData_T6963 ( 0x00 )
;GLCDSendCommand_T6963 ( 0x43 )
;
;GLCDSendData_T6963 ( 0x00 )
;GLCDSendData_T6963 ( 0x00 )
;GLCDSendCommand_T6963 ( 0x40 )
;
;GLCDSendData_T6963 ( 0x28 )
;GLCDSendData_T6963 ( 0x00 )
;GLCDSendCommand_T6963 ( 0x41 )
;Colours
;GLCDBackground = 0
	clrf	GLCDBACKGROUND
	clrf	GLCDBACKGROUND_H
;GLCDForeground = 1
	movlw	1
	movwf	GLCDFOREGROUND
	clrf	GLCDFOREGROUND_H
;GLCDFontWidth = 5
	movlw	5
	movwf	GLCDFONTWIDTH
;GLCDfntDefault = 0
	clrf	GLCDFNTDEFAULT
;GLCDfntDefaultsize = 1
	movlw	1
	movwf	GLCDFNTDEFAULTSIZE
;Clear screen
;GLCDCLS_T6963
	pagesel	GLCDCLS_T6963
	call	GLCDCLS_T6963
	pagesel	$
;CLS
	pagesel	CLS_T6963
	goto	CLS_T6963

;********************************************************************************

INITLCD
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
;asm showdebug OSCCON type is 105 'Bit(SPLLEN) Or Bit(IRCF3) And NoBit(INTSRC) and ifdef Bit(IRCF3)
;osccon type is 105
;Same as for 8, assuming 32 MHz clock is 8 MHz x 4
;OSCCON = OSCCON AND b'10000111'
;OSCCON = OSCCON OR b'11110000'
;Set IRCF3 On
	banksel	OSCCON
	bsf	OSCCON,IRCF3
;Set IRCF2 On
	bsf	OSCCON,IRCF2
;Set IRCF1 On
	bsf	OSCCON,IRCF1
;Set IRCF0 Off
	bcf	OSCCON,IRCF0
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

INITUSART
;Set the default value for comport
;comport = 1
	movlw	1
	movwf	COMPORT
;Set baud rate for legacy chips
;SPBRG = SPBRGL_TEMP
	movlw	64
	banksel	SPBRG
	movwf	SPBRG
;SPBRGH = SPBRGH_TEMP
	movlw	3
	movwf	SP1BRGH
;BRG16 = BRG16_TEMP
	bsf	BAUDCON,BRG16
;BRGH = BRGH_TEMP
	bsf	TXSTA,BRGH
;Enable async and TX mode for most non K42
;Set SYNC Off
	bcf	TXSTA,SYNC
;Set TXEN On
	bsf	TXSTA,TXEN
;SPEN=1
	bsf	RCSTA,SPEN
;Enable TX and RX
;CREN=1
	bsf	RCSTA,CREN
	banksel	STATUS
	return

;********************************************************************************

LCDCURSOR_T6963
;for LCDCURSOR Sub
;dim DefaultDisplayModeState_T6963 as byte
;adjust for line count
;line_x_cursor = line_x_cursor - 1
	decf	LINE_X_CURSOR,F
;protect if zero is passed as parameter and well as the default
;if line_x_cursor > 8 then
	movf	LINE_X_CURSOR,W
	sublw	8
	btfss	STATUS, C
;line_x_cursor = 0
	clrf	LINE_X_CURSOR
;end if
ENDIF19
;If LCDCRSR = ON  Then DefaultDisplayModeState_T6963 = DefaultDisplayModeState_T6963 OR LCDON
	decf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF20
	movlw	4
	iorwf	DEFAULTDISPLAYMODESTATE_T6963,F
ENDIF20
;IF LCDCRSR = LCDON Then DefaultDisplayModeState_T6963 = DefaultDisplayModeState_T6963 OR LCDON
	movlw	4
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF21
	movlw	4
	iorwf	DEFAULTDISPLAYMODESTATE_T6963,F
ENDIF21
;If LCDCRSR = OFF Then DefaultDisplayModeState_T6963 = DefaultDisplayModeState_T6963 AND LCDOFF
	movf	LCDCRSR,F
	btfss	STATUS, Z
	goto	ENDIF22
	movlw	251
	andwf	DEFAULTDISPLAYMODESTATE_T6963,F
ENDIF22
;If LCDCRSR = LCDOFF Then DefaultDisplayModeState_T6963 = DefaultDisplayModeState_T6963 AND LCDOFF
	movlw	251
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF23
	movlw	251
	andwf	DEFAULTDISPLAYMODESTATE_T6963,F
ENDIF23
;If LCDCRSR = CursorOn Then
	movlw	2
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF24
;DefaultDisplayModeState_T6963 = DefaultDisplayModeState_T6963 OR CursorON
	movlw	2
	iorwf	DEFAULTDISPLAYMODESTATE_T6963,F
;GLCDSendCommand_T6963(line_x_cursor)
	movf	LINE_X_CURSOR,W
	movwf	LCDCMDBYTE
	pagesel	GLCDSENDCOMMAND_T6963
	call	GLCDSENDCOMMAND_T6963
	pagesel	$
;end if
ENDIF24
;If LCDCRSR = CursorOFF then
	movlw	253
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF25
;DefaultDisplayModeState_T6963 = DefaultDisplayModeState_T6963 and CursorOFF
	movlw	253
	andwf	DEFAULTDISPLAYMODESTATE_T6963,F
;GLCDSendCommand_T6963(LINE_1_CURSOR)
	movlw	160
	movwf	LCDCMDBYTE
	pagesel	GLCDSENDCOMMAND_T6963
	call	GLCDSENDCOMMAND_T6963
	pagesel	$
;end if
ENDIF25
;If LCDCRSR = FLASH  Then
	movlw	3
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF26
;DefaultDisplayModeState_T6963 = DefaultDisplayModeState_T6963 OR FLASHON
	movlw	3
	iorwf	DEFAULTDISPLAYMODESTATE_T6963,F
;line_x_cursor = line_x_cursor or line_1_cursor
	movlw	160
	iorwf	LINE_X_CURSOR,F
;GLCDSendCommand_T6963( line_x_cursor )
	movf	LINE_X_CURSOR,W
	movwf	LCDCMDBYTE
	pagesel	GLCDSENDCOMMAND_T6963
	call	GLCDSENDCOMMAND_T6963
	pagesel	$
;End if
ENDIF26
;If LCDCRSR = FLASHOFF then
	movlw	252
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF27
;DefaultDisplayModeState_T6963 = DefaultDisplayModeState_T6963 and FLASHOFF
	movlw	252
	andwf	DEFAULTDISPLAYMODESTATE_T6963,F
;GLCDSendCommand_T6963( line_1_cursor )
	movlw	160
	movwf	LCDCMDBYTE
	pagesel	GLCDSENDCOMMAND_T6963
	call	GLCDSENDCOMMAND_T6963
	pagesel	$
;end if
ENDIF27
;GLCDSendCommand_T6963(DefaultDisplayModeState_T6963)
	movf	DEFAULTDISPLAYMODESTATE_T6963,W
	movwf	LCDCMDBYTE
	pagesel	GLCDSENDCOMMAND_T6963
	goto	GLCDSENDCOMMAND_T6963

;********************************************************************************

LCDHEX_T6963
;dim HighChar, LowChar as Byte
;Extract nibbles and convert to ascii values
;HighChar = (LCDValue / 16)  + 48
	movf	LCDVALUE,W
	movwf	SysBYTETempA
	movlw	16
	movwf	SysBYTETempB
	pagesel	SysDivSub
	call	SysDivSub
	pagesel	$
	movf	SysBYTETempA,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	48
	addwf	SysTemp1,W
	banksel	HIGHCHAR
	movwf	HIGHCHAR
;LowChar  = (LCDValue and 15) + 48
	movlw	15
	andwf	LCDVALUE,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	48
	addwf	SysTemp1,W
	banksel	LOWCHAR
	movwf	LOWCHAR
;Check for alpha and convert.
;If HighChar > 57 Then HighChar = HighChar + 7
	movf	HIGHCHAR,W
	sublw	57
	btfsc	STATUS, C
	goto	ENDIF13
	movlw	7
	addwf	HIGHCHAR,F
ENDIF13
;If LowChar > 57 Then  LowChar = LowChar + 7
	movf	LOWCHAR,W
	sublw	57
	btfsc	STATUS, C
	goto	ENDIF14
	movlw	7
	addwf	LOWCHAR,F
ENDIF14
;Write chars to LCD - if user specifies LeadingZeroActive then print the leading char
;IF LCDChar = LeadingZeroActive then
	movlw	2
	subwf	LCDCHAR,W
	btfss	STATUS, Z
	goto	ENDIF15
;if LCDValue < 16 then
	movlw	16
	subwf	LCDVALUE,W
	btfsc	STATUS, C
	goto	ENDIF17
;Print "0"
	movlw	low StringTable28
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable28) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT431
;end if
ENDIF17
;END IF
ENDIF15
;Write high char if LCDValue is > 15 (DEC)
;IF LCDValue > 15 then Print Chr(HighChar)
	movf	LCDVALUE,W
	sublw	15
	btfsc	STATUS, C
	goto	ENDIF16
	movf	HIGHCHAR,W
	movwf	SYSCHAR
	pagesel	FN_CHR
	call	FN_CHR
	pagesel	$
	movlw	low CHR
	movwf	SysPRINTDATAHandler
	movlw	high CHR
	movwf	SysPRINTDATAHandler_H
	call	PRINT431
ENDIF16
;Print Chr(LowChar)
	movf	LOWCHAR,W
	movwf	SYSCHAR
	pagesel	FN_CHR
	call	FN_CHR
	pagesel	$
	movlw	low CHR
	movwf	SysPRINTDATAHandler
	movlw	high CHR
	movwf	SysPRINTDATAHandler_H
	goto	PRINT431

;********************************************************************************

LOCATE_T6963
;dim addr as word
;addr = LCDColumn
	movf	LCDCOLUMN,W
	movwf	ADDR
	clrf	ADDR_H
;addr_h =  LCDLine
	movf	LCDLINE,W
	movwf	ADDR_H
;Set address pointer
;GLCDispCmdAddrSend(addr,ADDR_PTR_SET)
	movf	ADDR,W
	movwf	LCDDATAWORD
	movf	ADDR_H,W
	movwf	LCDDATAWORD_H
	movlw	36
	movwf	LCDCMDBYTE
	pagesel	GLCDCMDADDRSEND_T6963
	call	GLCDCMDADDRSEND_T6963
	pagesel	$
;GLCDispCmdSend(CURSOR_PTR_SET)
	movlw	33
	movwf	LCDCMDBYTE
	pagesel	GLCDSENDCOMMAND_T6963
	call	GLCDSENDCOMMAND_T6963
	pagesel	$
;if LCDLine > MAX_ROWS -1 then
	movf	LCDLINE,W
	movwf	SysBYTETempB
	movlw	7
	movwf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	btfsc	SysByteTempX,0
;exit Sub
	return
;end if
ENDIF7
;if LCDColumn >  MAX_COLUMNS -1  then
	movf	LCDCOLUMN,W
	movwf	SysBYTETempB
	movlw	39
	movwf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	btfsc	SysByteTempX,0
;exit Sub
	return
;end if
ENDIF8
;addr = (LCDLine*[word]COLUMN) + [word]LCDColumn + [word]TEXT_HOME_ADDR
	movf	LCDLINE,W
	movwf	SysWORDTempA
	clrf	SysWORDTempA_H
	movlw	40
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysMultSub16
	call	SysMultSub16
	pagesel	$
	movf	SysWORDTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movf	SysWORDTempX_H,W
	movwf	SysTemp1_H
	banksel	LCDCOLUMN
	movf	LCDCOLUMN,W
	banksel	SYSTEMP1
	addwf	SysTemp1,W
	movwf	SysTemp2
	movlw	0
	addwfc	SysTemp1_H,W
	movwf	SysTemp2_H
	movlw	0
	addwf	SysTemp2,W
	banksel	ADDR
	movwf	ADDR
	movlw	0
	banksel	SYSTEMP2_H
	addwfc	SysTemp2_H,W
	banksel	ADDR_H
	movwf	ADDR_H
;Set address pointer
;GLCDispCmdAddrSend(addr,ADDR_PTR_SET)
	movf	ADDR,W
	movwf	LCDDATAWORD
	movf	ADDR_H,W
	movwf	LCDDATAWORD_H
	movlw	36
	movwf	LCDCMDBYTE
	pagesel	GLCDCMDADDRSEND_T6963
	goto	GLCDCMDADDRSEND_T6963

;********************************************************************************

;Overloaded signature: STRING:
PRINT431
;PrintLen = LEN(PrintData$)
;PrintLen = PrintData(0)
	movf	SysPRINTDATAHandler,W
	movwf	AFSR0
	movf	SysPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	PRINTLEN
;If PrintLen = 0 Then Exit Sub
	movf	PRINTLEN,F
	btfsc	STATUS, Z
	return
ENDIF35
;Set LCD_RS On
	bsf	SYSLCDTEMP,1
;Write Data
;For SysPrintTemp = 1 To PrintLen
	clrf	SYSPRINTTEMP
	movlw	1
	subwf	PRINTLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd9
ENDIF36
SysForLoop9
	incf	SYSPRINTTEMP,F
;LCDWriteByte PrintData(SysPrintTemp)
	movf	SYSPRINTTEMP,W
	addwf	SysPRINTDATAHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	LCDBYTE
	pagesel	LCDNORMALWRITEBYTE_T6963
	call	LCDNORMALWRITEBYTE_T6963
	pagesel	$
;Next
	movf	PRINTLEN,W
	subwf	SYSPRINTTEMP,W
	btfss	STATUS, C
	goto	SysForLoop9
ENDIF37
SysForLoopEnd9
	return

;********************************************************************************

;Overloaded signature: WORD:
PRINT433
;Dim SysCalcTempX As Word
;Set LCD_RS On
	bsf	SYSLCDTEMP,1
;LCDValueTemp = 0
	clrf	LCDVALUETEMP
;If LCDValue >= 10000 then
	movf	LCDVALUE,W
	movwf	SysWORDTempA
	movf	LCDVALUE_H,W
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
	goto	ENDIF40
;LCDValueTemp = LCDValue / 10000 [word]
	movf	LCDVALUE,W
	movwf	SysWORDTempA
	movf	LCDVALUE_H,W
	movwf	SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB
	movlw	39
	movwf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempA,W
	movwf	LCDVALUETEMP
;LCDValue = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	LCDVALUE
	movf	SYSCALCTEMPX_H,W
	movwf	LCDVALUE_H
;LCDWriteByte(LCDValueTemp + 48)
	movlw	48
	addwf	LCDVALUETEMP,W
	movwf	LCDBYTE
	pagesel	LCDNORMALWRITEBYTE_T6963
	call	LCDNORMALWRITEBYTE_T6963
	pagesel	$
;Goto LCDPrintWord1000
	goto	LCDPRINTWORD1000
;End If
ENDIF40
;If LCDValue >= 1000 then
	movf	LCDVALUE,W
	movwf	SysWORDTempA
	movf	LCDVALUE_H,W
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
	goto	ENDIF41
LCDPRINTWORD1000
;LCDValueTemp = LCDValue / 1000 [word]
	movf	LCDVALUE,W
	movwf	SysWORDTempA
	movf	LCDVALUE_H,W
	movwf	SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB
	movlw	3
	movwf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempA,W
	movwf	LCDVALUETEMP
;LCDValue = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	LCDVALUE
	movf	SYSCALCTEMPX_H,W
	movwf	LCDVALUE_H
;LCDWriteByte(LCDValueTemp + 48)
	movlw	48
	addwf	LCDVALUETEMP,W
	movwf	LCDBYTE
	pagesel	LCDNORMALWRITEBYTE_T6963
	call	LCDNORMALWRITEBYTE_T6963
	pagesel	$
;Goto LCDPrintWord100
	goto	LCDPRINTWORD100
;End If
ENDIF41
;If LCDValue >= 100 then
	movf	LCDVALUE,W
	movwf	SysWORDTempA
	movf	LCDVALUE_H,W
	movwf	SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF42
LCDPRINTWORD100
;LCDValueTemp = LCDValue / 100 [word]
	movf	LCDVALUE,W
	movwf	SysWORDTempA
	movf	LCDVALUE_H,W
	movwf	SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempA,W
	movwf	LCDVALUETEMP
;LCDValue = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	LCDVALUE
	movf	SYSCALCTEMPX_H,W
	movwf	LCDVALUE_H
;LCDWriteByte(LCDValueTemp + 48)
	movlw	48
	addwf	LCDVALUETEMP,W
	movwf	LCDBYTE
	pagesel	LCDNORMALWRITEBYTE_T6963
	call	LCDNORMALWRITEBYTE_T6963
	pagesel	$
;Goto LCDPrintWord10
	goto	LCDPRINTWORD10
;End If
ENDIF42
;If LCDValue >= 10 then
	movf	LCDVALUE,W
	movwf	SysWORDTempA
	movf	LCDVALUE_H,W
	movwf	SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF43
LCDPRINTWORD10
;LCDValueTemp = LCDValue / 10 [word]
	movf	LCDVALUE,W
	movwf	SysWORDTempA
	movf	LCDVALUE_H,W
	movwf	SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempA,W
	movwf	LCDVALUETEMP
;LCDValue = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	LCDVALUE
	movf	SYSCALCTEMPX_H,W
	movwf	LCDVALUE_H
;LCDWriteByte(LCDValueTemp + 48)
	movlw	48
	addwf	LCDVALUETEMP,W
	movwf	LCDBYTE
	pagesel	LCDNORMALWRITEBYTE_T6963
	call	LCDNORMALWRITEBYTE_T6963
	pagesel	$
;End If
ENDIF43
;LCDWriteByte (LCDValue + 48)
	movlw	48
	addwf	LCDVALUE,W
	movwf	LCDBYTE
	pagesel	LCDNORMALWRITEBYTE_T6963
	goto	LCDNORMALWRITEBYTE_T6963

;********************************************************************************

;Overloaded signature: LONG:
PRINT435
;Dim SysCalcTempA As Long
;Dim SysPrintBuffer(10)
;SysPrintBuffLen = 0
	clrf	SYSPRINTBUFFLEN
;Do
SysDoLoop_S4
;Divide number by 10, remainder into buffer
;SysPrintBuffLen += 1
	incf	SYSPRINTBUFFLEN,F
;SysPrintBuffer(SysPrintBuffLen) = LCDValue % 10
	movlw	low(SYSPRINTBUFFER)
	addwf	SYSPRINTBUFFLEN,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(SYSPRINTBUFFER)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	banksel	LCDVALUE
	movf	LCDVALUE,W
	movwf	SysLONGTempA
	movf	LCDVALUE_H,W
	movwf	SysLONGTempA_H
	movf	LCDVALUE_U,W
	movwf	SysLONGTempA_U
	movf	LCDVALUE_E,W
	movwf	SysLONGTempA_E
	movlw	10
	movwf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	call	SysDivSub32
	movf	SysLONGTempX,W
	movwf	INDF0
;LCDValue = SysCalcTempA
	movf	SYSCALCTEMPA,W
	movwf	LCDVALUE
	movf	SYSCALCTEMPA_H,W
	movwf	LCDVALUE_H
	movf	SYSCALCTEMPA_U,W
	movwf	LCDVALUE_U
	movf	SYSCALCTEMPA_E,W
	movwf	LCDVALUE_E
;Loop While LCDValue <> 0
	movf	lcdvalue,W
	movwf	SysLONGTempA
	movf	lcdvalue_H,W
	movwf	SysLONGTempA_H
	movf	lcdvalue_U,W
	movwf	SysLONGTempA_U
	movf	lcdvalue_E,W
	movwf	SysLONGTempA_E
	clrf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	pagesel	SysCompEqual32
	call	SysCompEqual32
	pagesel	$
	comf	SysByteTempX,F
	btfsc	SysByteTempX,0
	goto	SysDoLoop_S4
SysDoLoop_E4
;Display
;Set LCD_RS On
	bsf	SYSLCDTEMP,1
;For SysPrintTemp = SysPrintBuffLen To 1 Step -1
	incf	SYSPRINTBUFFLEN,W
	movwf	SYSPRINTTEMP
	movlw	1
	subwf	SYSPRINTBUFFLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd10
ENDIF44
SysForLoop10
	decf	SYSPRINTTEMP,F
;LCDWriteByte(SysPrintBuffer(SysPrintTemp) + 48)
	movlw	low(SYSPRINTBUFFER)
	addwf	SYSPRINTTEMP,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(SYSPRINTBUFFER)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movlw	48
	addwf	INDF0,W
	banksel	LCDBYTE
	movwf	LCDBYTE
	pagesel	LCDNORMALWRITEBYTE_T6963
	call	LCDNORMALWRITEBYTE_T6963
	pagesel	$
;Next
	movf	SYSPRINTTEMP,W
	sublw	1
	btfss	STATUS, C
	goto	SysForLoop10
ENDIF45
SysForLoopEnd10
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
	goto	ENDIF52
;SysLongTempA = 0
	clrf	SYSLONGTEMPA
	clrf	SYSLONGTEMPA_H
	clrf	SYSLONGTEMPA_U
	clrf	SYSLONGTEMPA_E
;exit sub
	return
;end if
ENDIF52
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
	goto	ENDIF53
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
ENDIF53
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

SysStringTables
	movf	SysStringA_H,W
	movwf	PCLATH
	movf	SysStringA,W
	incf	SysStringA,F
	btfsc	STATUS,Z
	incf	SysStringA_H,F
	movwf	PCL

StringTable2
	retlw	5
	retlw	66	;B
	retlw	117	;u
	retlw	105	;i
	retlw	108	;l
	retlw	100	;d


StringTable3
	retlw	1
	retlw	64	;


StringTable4
	retlw	5
	retlw	72	;H
	retlw	101	;e
	retlw	108	;l
	retlw	108	;l
	retlw	111	;o


StringTable5
	retlw	5
	retlw	87	;W
	retlw	111	;o
	retlw	114	;r
	retlw	108	;l
	retlw	100	;d


StringTable6
	retlw	2
	retlw	48	;0
	retlw	120	;x


StringTable7
	retlw	10
	retlw	83	;S
	retlw	84	;T
	retlw	65	;A
	retlw	82	;R
	retlw	84	;T
	retlw	32	; 
	retlw	84	;T
	retlw	69	;E
	retlw	83	;S
	retlw	84	;T


StringTable8
	retlw	10
	retlw	68	;D
	retlw	73	;I
	retlw	83	;S
	retlw	80	;P
	retlw	76	;L
	retlw	65	;A
	retlw	89	;Y
	retlw	32	; 
	retlw	79	;O
	retlw	78	;N


StringTable9
	retlw	9
	retlw	67	;C
	retlw	117	;u
	retlw	114	;r
	retlw	115	;s
	retlw	111	;o
	retlw	114	;r
	retlw	32	; 
	retlw	79	;O
	retlw	78	;N


StringTable10
	retlw	10
	retlw	67	;C
	retlw	117	;u
	retlw	114	;r
	retlw	115	;s
	retlw	111	;o
	retlw	114	;r
	retlw	32	; 
	retlw	79	;O
	retlw	70	;F
	retlw	70	;F


StringTable11
	retlw	8
	retlw	70	;F
	retlw	76	;L
	retlw	65	;A
	retlw	83	;S
	retlw	72	;H
	retlw	32	; 
	retlw	79	;O
	retlw	78	;N


StringTable12
	retlw	9
	retlw	70	;F
	retlw	76	;L
	retlw	65	;A
	retlw	83	;S
	retlw	72	;H
	retlw	32	; 
	retlw	79	;O
	retlw	70	;F
	retlw	70	;F


StringTable13
	retlw	15
	retlw	67	;C
	retlw	85	;U
	retlw	82	;R
	retlw	83	;S
	retlw	82	;R
	retlw	32	; 
	retlw	38	;&
	retlw	32	; 
	retlw	70	;F
	retlw	76	;L
	retlw	83	;S
	retlw	72	;H
	retlw	32	; 
	retlw	79	;O
	retlw	78	;N


StringTable14
	retlw	16
	retlw	67	;C
	retlw	85	;U
	retlw	82	;R
	retlw	83	;S
	retlw	82	;R
	retlw	32	; 
	retlw	38	;&
	retlw	32	; 
	retlw	70	;F
	retlw	76	;L
	retlw	83	;S
	retlw	72	;H
	retlw	32	; 
	retlw	79	;O
	retlw	70	;F
	retlw	70	;F


StringTable15
	retlw	8
	retlw	70	;F
	retlw	108	;l
	retlw	97	;a
	retlw	115	;s
	retlw	104	;h
	retlw	105	;i
	retlw	110	;n
	retlw	103	;g


StringTable16
	retlw	7
	retlw	68	;D
	retlw	105	;i
	retlw	115	;s
	retlw	112	;p
	retlw	108	;l
	retlw	97	;a
	retlw	121	;y


StringTable17
	retlw	11
	retlw	68	;D
	retlw	73	;I
	retlw	83	;S
	retlw	80	;P
	retlw	76	;L
	retlw	65	;A
	retlw	89	;Y
	retlw	32	; 
	retlw	79	;O
	retlw	70	;F
	retlw	70	;F


StringTable18
	retlw	9
	retlw	70	;F
	retlw	79	;O
	retlw	82	;R
	retlw	32	; 
	retlw	53	;5
	retlw	32	; 
	retlw	83	;S
	retlw	69	;E
	retlw	67	;C


StringTable19
	retlw	8
	retlw	69	;E
	retlw	78	;N
	retlw	68	;D
	retlw	32	; 
	retlw	84	;T
	retlw	69	;E
	retlw	83	;S
	retlw	84	;T


StringTable20
	retlw	34
	retlw	98	;b
	retlw	97	;a
	retlw	115	;s
	retlw	105	;i
	retlw	108	;l
	retlw	32	; 
	retlw	72	;H
	retlw	65	;A
	retlw	84	;T
	retlw	90	;Z
	retlw	73	;I
	retlw	76	;L
	retlw	65	;A
	retlw	73	;I
	retlw	79	;O
	retlw	83	;S
	retlw	32	; 
	retlw	91	;[
	retlw	104	;h
	retlw	97	;a
	retlw	116	;t
	retlw	122	;z
	retlw	98	;b
	retlw	115	;s
	retlw	64	;
	retlw	121	;y
	retlw	97	;a
	retlw	104	;h
	retlw	111	;o
	retlw	111	;o
	retlw	46	;.
	retlw	103	;g
	retlw	114	;r
	retlw	93	;]


StringTable21
	retlw	14
	retlw	84	;T
	retlw	104	;h
	retlw	105	;i
	retlw	115	;s
	retlw	32	; 
	retlw	105	;i
	retlw	115	;s
	retlw	32	; 
	retlw	108	;l
	retlw	105	;i
	retlw	110	;n
	retlw	101	;e
	retlw	32	; 
	retlw	53	;5


StringTable22
	retlw	14
	retlw	84	;T
	retlw	104	;h
	retlw	105	;i
	retlw	115	;s
	retlw	32	; 
	retlw	105	;i
	retlw	115	;s
	retlw	32	; 
	retlw	108	;l
	retlw	105	;i
	retlw	110	;n
	retlw	101	;e
	retlw	32	; 
	retlw	54	;6


StringTable23
	retlw	14
	retlw	84	;T
	retlw	104	;h
	retlw	105	;i
	retlw	115	;s
	retlw	32	; 
	retlw	105	;i
	retlw	115	;s
	retlw	32	; 
	retlw	108	;l
	retlw	105	;i
	retlw	110	;n
	retlw	101	;e
	retlw	32	; 
	retlw	55	;7


StringTable24
	retlw	11
	retlw	84	;T
	retlw	117	;u
	retlw	114	;r
	retlw	110	;n
	retlw	105	;i
	retlw	110	;n
	retlw	103	;g
	retlw	32	; 
	retlw	111	;o
	retlw	102	;f
	retlw	102	;f


StringTable25
	retlw	10
	retlw	84	;T
	retlw	117	;u
	retlw	114	;r
	retlw	110	;n
	retlw	105	;i
	retlw	110	;n
	retlw	103	;g
	retlw	32	; 
	retlw	111	;o
	retlw	110	;n


StringTable26
	retlw	1
	retlw	42	;*


StringTable27
	retlw	21
	retlw	84	;T
	retlw	104	;h
	retlw	105	;i
	retlw	115	;s
	retlw	32	; 
	retlw	105	;i
	retlw	115	;s
	retlw	32	; 
	retlw	108	;l
	retlw	105	;i
	retlw	110	;n
	retlw	101	;e
	retlw	32	; 
	retlw	49	;1
	retlw	32	; 
	retlw	80	;P
	retlw	97	;a
	retlw	103	;g
	retlw	101	;e
	retlw	32	; 
	retlw	50	;2


StringTable28
	retlw	1
	retlw	48	;0


StringTable29
	retlw	1
	retlw	32	; 


StringTable47
	retlw	3
	retlw	49	;1
	retlw	48	;0
	retlw	51	;3


StringTable48
	retlw	19
	retlw	48	;0
	retlw	50	;2
	retlw	45	;-
	retlw	48	;0
	retlw	55	;7
	retlw	45	;-
	retlw	50	;2
	retlw	48	;0
	retlw	49	;1
	retlw	57	;9
	retlw	32	; 
	retlw	49	;1
	retlw	52	;4
	retlw	58	;:
	retlw	52	;4
	retlw	53	;5
	retlw	58	;:
	retlw	49	;1
	retlw	55	;7


;********************************************************************************

;Start of program memory page 1
	ORG	2048
FN_CHR
;Empty input?
;If SysChar < 0 Then
	movlw	0
	subwf	SYSCHAR,W
	btfsc	STATUS, C
	goto	ENDIF54
;Chr(0) = 0
	banksel	SYSCHR_0
	clrf	SYSCHR_0
;Exit Function
	banksel	STATUS
	return
;End If
ENDIF54
;Chr(0) = 1
	movlw	1
	banksel	SYSCHR_0
	movwf	SYSCHR_0
;Copy characters
;Chr(1) = SysChar
	banksel	SYSCHAR
	movf	SYSCHAR,W
	banksel	SYSCHR_1
	movwf	SYSCHR_1
	banksel	STATUS
	return

;********************************************************************************

CLS_T6963
;dim row_T6963, col_T6963 as word
;Set address pointer to address (TEXT_HOME_ADDR)
;GLCDispCmdAddrSend(TEXT_HOME_ADDR,ADDR_PTR_SET)
	clrf	LCDDATAWORD
	clrf	LCDDATAWORD_H
	movlw	36
	movwf	LCDCMDBYTE
	call	GLCDCMDADDRSEND_T6963
;Set Auto Write ON
;GLCDispCmdSend(AUTO_WR_ON)
	movlw	176
	movwf	LCDCMDBYTE
	call	GLCDSENDCOMMAND_T6963
;row runs from 0 ... (MAX_ROW_PIXEL/8 -1), in form of a cell of (FontSize x 8) bits
;for  row_T6963 =  0 to ( MAX_ROW_PIXEL/8 ) -1
	movlw	255
	movwf	ROW_T6963
	movwf	ROW_T6963_H
SysForLoop5
	incf	ROW_T6963,F
	btfsc	STATUS,Z
	incf	ROW_T6963_H,F
;write blank to clear screen the first page only, col = 0...(COLUMN-1)
;for col_T6963 = 0 to COLUMN - 1
	movlw	255
	movwf	COL_T6963
	movwf	COL_T6963_H
SysForLoop6
	incf	COL_T6963,F
	btfsc	STATUS,Z
	incf	COL_T6963_H,F
;GLCDispAutoDataWr ( 0 )
	clrf	LCDDATABYTE
	call	GLCDISPAUTODATAWR
;next
	movf	COL_T6963,W
	movwf	SysWORDTempA
	movf	COL_T6963_H,W
	movwf	SysWORDTempA_H
	movlw	39
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0
	goto	SysForLoop6
ENDIF11
SysForLoopEnd6
;next
	movf	ROW_T6963,W
	movwf	SysWORDTempA
	movf	ROW_T6963_H,W
	movwf	SysWORDTempA_H
	movlw	7
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0
	goto	SysForLoop5
ENDIF12
SysForLoopEnd5
;GLCDispCmdSend(AUTO_WR_OFF)
	movlw	178
	movwf	LCDCMDBYTE
	call	GLCDSENDCOMMAND_T6963
;GLCDispCmdAddrSend(TEXT_HOME_ADDR,ADDR_PTR_SET)
	clrf	LCDDATAWORD
	clrf	LCDDATAWORD_H
	movlw	36
	movwf	LCDCMDBYTE
	call	GLCDCMDADDRSEND_T6963
;GLCDispCmdSend(CURSOR_PTR_SET)
	movlw	33
	movwf	LCDCMDBYTE
	goto	GLCDSENDCOMMAND_T6963

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

FN_GCBBUILDSTR
;GCBBuildStr="103"
	movlw	low GCBBUILDSTR
	movwf	FSR1L
	movlw	high GCBBUILDSTR
	movwf	FSR1H
	movlw	low StringTable47
	movwf	SysStringA
	movlw	(high StringTable47) & 127
	movwf	SysStringA_H
	goto	SysReadString

;********************************************************************************

FN_GCBBUILDTIMESTR
;GCBBuildTimeStr="02-07-2019 14:45:17"
	movlw	low GCBBUILDTIMESTR
	movwf	FSR1L
	movlw	high GCBBUILDTIMESTR
	movwf	FSR1H
	movlw	low StringTable48
	movwf	SysStringA
	movlw	(high StringTable48) & 127
	movwf	SysStringA_H
	goto	SysReadString

;********************************************************************************

GLCDBUSYCHECK_T6963
;dir GLCD_DATA_PORT in
	movlw	255
	banksel	TRISD
	movwf	TRISD
;GLCD_CD = 1
	banksel	LATA
	bsf	LATA,0
;wait T6963ClockDelay us
	movlw	2
	movwf	DELAYTEMP
DelayUS16
	decfsz	DELAYTEMP,F
	goto	DelayUS16
	nop
;GLCD_WR = 1
	bsf	LATA,2
;wait T6963ClockDelay us
	movlw	2
	movwf	DELAYTEMP
DelayUS17
	decfsz	DELAYTEMP,F
	goto	DelayUS17
	nop
;GLCD_RD = 0
	bcf	LATA,1
;wait T6963ClockDelay us
	movlw	2
	movwf	DELAYTEMP
DelayUS18
	decfsz	DELAYTEMP,F
	goto	DelayUS18
	nop
;GLCD_CS = 0
	bcf	LATA,7
;wait T6963ClockDelay us
	movlw	2
	movwf	DELAYTEMP
DelayUS19
	decfsz	DELAYTEMP,F
	goto	DelayUS19
	nop
;wait while (!STA0)  'Busy Check here
SysWaitLoop1
	banksel	SYSTEMP2
	clrf	SysTemp2
	banksel	PORTD
	btfss	PORTD,0
	goto	ENDIF32
	banksel	SYSTEMP2
	incf	SysTemp2,F
ENDIF32
	banksel	SYSTEMP2
	comf	SysTemp2,W
	movwf	SysTemp1
	btfsc	SysTemp1,0
	goto	SysWaitLoop1
;wait T6963ClockDelay us
	movlw	2
	movwf	DELAYTEMP
DelayUS20
	decfsz	DELAYTEMP,F
	goto	DelayUS20
	nop
;wait while (!STA1)
SysWaitLoop2
	clrf	SysTemp2
	banksel	PORTD
	btfss	PORTD,1
	goto	ENDIF33
	banksel	SYSTEMP2
	incf	SysTemp2,F
ENDIF33
	banksel	SYSTEMP2
	comf	SysTemp2,W
	movwf	SysTemp1
	btfsc	SysTemp1,0
	goto	SysWaitLoop2
;GLCD_CS = 1
	banksel	LATA
	bsf	LATA,7
;dir GLCD_DATA_PORT out
	banksel	TRISD
	clrf	TRISD
	banksel	STATUS
	return

;********************************************************************************

GLCDCLS_T6963
;initialise global variable. Required variable for Circle in all DEVICE DRIVERS- DO NOT DELETE
;GLCD_yordinate = 0
	clrf	GLCD_YORDINATE
	clrf	GLCD_YORDINATE_H
;Set address pointer to address (GRH_HOME_ADDR)
;GLCDispCmdAddrSend(GRH_HOME_ADDR, ADDR_PTR_SET)
	movlw	255
	movwf	LCDDATAWORD
	movlw	63
	movwf	LCDDATAWORD_H
	movlw	36
	movwf	LCDCMDBYTE
	call	GLCDCMDADDRSEND_T6963
;Set Auto Write ON
;GLCDispCmdSend(AUTO_WR_ON)
	movlw	176
	movwf	LCDCMDBYTE
	call	GLCDSENDCOMMAND_T6963
;Row runs from 0 ... (MAX_ROW_PIXEL-1), in form of a byte size of (FontSize x 1) bits
;for  row_T6963 =  0 to  MAX_ROW_PIXEL -1
	movlw	255
	movwf	ROW_T6963
	movwf	ROW_T6963_H
SysForLoop7
	incf	ROW_T6963,F
	btfsc	STATUS,Z
	incf	ROW_T6963_H,F
;write blank to clear screen the first page only, col = 0...(COLUMN-1)
;for col_T6963 = 0 to COLUMN - 1
	movlw	255
	movwf	COL_T6963
	movwf	COL_T6963_H
SysForLoop8
	incf	COL_T6963,F
	btfsc	STATUS,Z
	incf	COL_T6963_H,F
;GLCDispAutoDataWr ( 0x00 )
	clrf	LCDDATABYTE
	call	GLCDISPAUTODATAWR
;next
	movf	COL_T6963,W
	movwf	SysWORDTempA
	movf	COL_T6963_H,W
	movwf	SysWORDTempA_H
	movlw	39
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0
	goto	SysForLoop8
ENDIF30
SysForLoopEnd8
;next
	movf	ROW_T6963,W
	movwf	SysWORDTempA
	movf	ROW_T6963_H,W
	movwf	SysWORDTempA_H
	movlw	63
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0
	goto	SysForLoop7
ENDIF31
SysForLoopEnd7
;GLCDispCmdAddrSend(GRH_HOME_ADDR, ADDR_PTR_SET)
	movlw	255
	movwf	LCDDATAWORD
	movlw	63
	movwf	LCDDATAWORD_H
	movlw	36
	movwf	LCDCMDBYTE
	goto	GLCDCMDADDRSEND_T6963

;********************************************************************************

GLCDCMDADDRSEND_T6963
;GLCDSendData_T6963 ( LCDDataWord )
	movf	LCDDATAWORD,W
	movwf	LCDDATABYTE
	call	GLCDSENDDATA_T6963
;GLCDSendData_T6963 ( LCDDataWord_h )
	movf	LCDDATAWORD_H,W
	movwf	LCDDATABYTE
	call	GLCDSENDDATA_T6963
;GLCDSendCommand_T6963 ( LCDCmdByte )
	goto	GLCDSENDCOMMAND_T6963

;********************************************************************************

GLCDISPAUTODATAWR
;GLCDispAutoWrChk_T6963
	call	GLCDISPAUTOWRCHK_T6963
;GLCD_DATA_PORT = LCDDataByte
	movf	LCDDATABYTE,W
	movwf	PORTD
;wait T6963ClockDelay us
	movlw	2
	movwf	DELAYTEMP
DelayUS6
	decfsz	DELAYTEMP,F
	goto	DelayUS6
	nop
;GLCD_CD = 0
	banksel	LATA
	bcf	LATA,0
;wait T6963ClockDelay us
	movlw	2
	movwf	DELAYTEMP
DelayUS7
	decfsz	DELAYTEMP,F
	goto	DelayUS7
	nop
;GLCD_WR = 0
	bcf	LATA,2
;wait T6963ClockDelay us
	movlw	2
	movwf	DELAYTEMP
DelayUS8
	decfsz	DELAYTEMP,F
	goto	DelayUS8
	nop
;GLCD_RD = 1
	bsf	LATA,1
;wait T6963ClockDelay us
	movlw	2
	movwf	DELAYTEMP
DelayUS9
	decfsz	DELAYTEMP,F
	goto	DelayUS9
	nop
;GLCD_CS = 0
	bcf	LATA,7
;wait T6963WriteDelay us
	movlw	2
	movwf	DELAYTEMP
DelayUS10
	decfsz	DELAYTEMP,F
	goto	DelayUS10
	nop
;GLCD_CS = 1
	bsf	LATA,7
	banksel	STATUS
	return

;********************************************************************************

GLCDISPAUTOWRCHK_T6963
;dir GLCD_DATA_PORT in
	movlw	255
	banksel	TRISD
	movwf	TRISD
;GLCD_CD = 1
	banksel	LATA
	bsf	LATA,0
;wait T6963ClockDelay us
	movlw	2
	movwf	DELAYTEMP
DelayUS21
	decfsz	DELAYTEMP,F
	goto	DelayUS21
	nop
;GLCD_WR = 1
	bsf	LATA,2
;wait T6963ClockDelay us
	movlw	2
	movwf	DELAYTEMP
DelayUS22
	decfsz	DELAYTEMP,F
	goto	DelayUS22
	nop
;GLCD_RD = 0
	bcf	LATA,1
;wait T6963ClockDelay us
	movlw	2
	movwf	DELAYTEMP
DelayUS23
	decfsz	DELAYTEMP,F
	goto	DelayUS23
	nop
;GLCD_CS = 0
	bcf	LATA,7
;wait T6963ClockDelay us
	movlw	2
	movwf	DELAYTEMP
DelayUS24
	decfsz	DELAYTEMP,F
	goto	DelayUS24
	nop
;wait while (!STA3)  'Busy Check here
SysWaitLoop3
	banksel	SYSTEMP2
	clrf	SysTemp2
	banksel	PORTD
	btfss	PORTD,3
	goto	ENDIF34
	banksel	SYSTEMP2
	incf	SysTemp2,F
ENDIF34
	banksel	SYSTEMP2
	comf	SysTemp2,W
	movwf	SysTemp1
	btfsc	SysTemp1,0
	goto	SysWaitLoop3
;GLCD_CS = 1
	banksel	LATA
	bsf	LATA,7
;dir GLCD_DATA_PORT out
	banksel	TRISD
	clrf	TRISD
	banksel	STATUS
	return

;********************************************************************************

GLCDSENDCOMMAND_T6963
;GLCDBusyCheck_T6963
	call	GLCDBUSYCHECK_T6963
;GLCD_DATA_PORT = LCDCmdByte
	movf	LCDCMDBYTE,W
	movwf	PORTD
;wait T6963ClockDelay us
	movlw	2
	movwf	DELAYTEMP
DelayUS1
	decfsz	DELAYTEMP,F
	goto	DelayUS1
	nop
;GLCD_CD = 1
	banksel	LATA
	bsf	LATA,0
;wait T6963ClockDelay us
	movlw	2
	movwf	DELAYTEMP
DelayUS2
	decfsz	DELAYTEMP,F
	goto	DelayUS2
	nop
;GLCD_WR = 0
	bcf	LATA,2
;wait T6963ClockDelay us
	movlw	2
	movwf	DELAYTEMP
DelayUS3
	decfsz	DELAYTEMP,F
	goto	DelayUS3
	nop
;GLCD_RD = 1
	bsf	LATA,1
;wait T6963ClockDelay us
	movlw	2
	movwf	DELAYTEMP
DelayUS4
	decfsz	DELAYTEMP,F
	goto	DelayUS4
	nop
;GLCD_CS = 0
	bcf	LATA,7
;wait T6963WriteDelay us
	movlw	2
	movwf	DELAYTEMP
DelayUS5
	decfsz	DELAYTEMP,F
	goto	DelayUS5
	nop
;GLCD_CS = 1
	bsf	LATA,7
	banksel	STATUS
	return

;********************************************************************************

GLCDSENDDATA_T6963
;GLCDBusyCheck_T6963
	call	GLCDBUSYCHECK_T6963
;GLCD_DATA_PORT = LCDDataByte
	movf	LCDDATABYTE,W
	movwf	PORTD
;wait T6963ClockDelay us
	movlw	2
	movwf	DELAYTEMP
DelayUS11
	decfsz	DELAYTEMP,F
	goto	DelayUS11
	nop
;GLCD_CD = 0
	banksel	LATA
	bcf	LATA,0
;wait T6963ClockDelay us
	movlw	2
	movwf	DELAYTEMP
DelayUS12
	decfsz	DELAYTEMP,F
	goto	DelayUS12
	nop
;GLCD_WR = 0
	bcf	LATA,2
;wait T6963ClockDelay us
	movlw	2
	movwf	DELAYTEMP
DelayUS13
	decfsz	DELAYTEMP,F
	goto	DelayUS13
	nop
;GLCD_RD = 1
	bsf	LATA,1
;wait T6963ClockDelay us
	movlw	2
	movwf	DELAYTEMP
DelayUS14
	decfsz	DELAYTEMP,F
	goto	DelayUS14
	nop
;GLCD_CS = 0
	bcf	LATA,7
;wait T6963WriteDelay us
	movlw	2
	movwf	DELAYTEMP
DelayUS15
	decfsz	DELAYTEMP,F
	goto	DelayUS15
	nop
;GLCD_CS = 1
	bsf	LATA,7
	banksel	STATUS
	return

;********************************************************************************

;Overloaded signature: STRING:byte:
HSERPRINT580
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
	goto	ENDIF55
;Write Data
;for SysPrintTemp = 1 to PrintLen
	clrf	SYSPRINTTEMP
	movlw	1
	subwf	PRINTLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd11
ENDIF56
SysForLoop11
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
	goto	SysForLoop11
ENDIF57
SysForLoopEnd11
;End If
ENDIF55
;CR
	return

;********************************************************************************

HSERSEND
;Block before sending (if needed)
;Send byte
;Registers/Bits determined by #samevar at top of file
;if comport = 1 Then
	decf	COMPORT,W
	btfss	STATUS, Z
	goto	ENDIF58
;HSerSendBlocker
;Wait While TXIF = Off
SysWaitLoop4
	btfss	PIR1,TXIF
	goto	SysWaitLoop4
;asm showdebug TXREG equals SerData below will assign SerData to TXREG or TXREG1 or U1TXB  via the #samevar
;txreg equals serdata below will assign serdata to txreg | txreg | txreg via the #samevar
;
;TXREG = SerData
	movf	SERDATA,W
	banksel	TXREG
	movwf	TXREG
;Add USART_DELAY After all bits are shifted out
;Wait until TRMT = 1
SysWaitLoop5
	btfss	TXSTA,TRMT
	goto	SysWaitLoop5
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	banksel	STATUS
	call	Delay_MS
;exit sub
	return
;end if
ENDIF58
	return

;********************************************************************************

LCDNORMALWRITEBYTE_T6963
;GLCDispDataWr( LCDByte - 0x20 )      'Adjust standard ASCII to T6963 ASCII
	movlw	32
	subwf	LCDBYTE,W
	movwf	LCDDATABYTE
	call	GLCDSENDDATA_T6963
;GLCDispCmdSend(DATA_WR_INC)          'Address pointer increment ON
	movlw	192
	movwf	LCDCMDBYTE
	goto	GLCDSENDCOMMAND_T6963

;********************************************************************************

LCDSPACE_T6963
;if LCDValue > COLUMN then LCDValue = COLUMN
	movf	LCDVALUE,W
	sublw	40
	btfsc	STATUS, C
	goto	ENDIF18
	movlw	40
	movwf	LCDVALUE
ENDIF18
;do until LCDValue = 0
SysDoLoop_S3
	movf	LCDVALUE,F
	btfsc	STATUS, Z
	goto	SysDoLoop_E3
;Print " "
	movlw	low StringTable29
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable29) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT431
	call	PRINT431
	pagesel	$
;LCDValue --
	decf	LCDVALUE,F
;loop
	goto	SysDoLoop_S3
SysDoLoop_E3
	return

;********************************************************************************

;Overloaded signature: BYTE:
PRINT432
;LCDValueTemp = 0
	clrf	LCDVALUETEMP
;Set LCD_RS On
	bsf	SYSLCDTEMP,1
;IF LCDValue >= 100 Then
	movlw	100
	subwf	LCDVALUE,W
	btfss	STATUS, C
	goto	ENDIF38
;LCDValueTemp = LCDValue / 100
	movf	LCDVALUE,W
	movwf	SysBYTETempA
	movlw	100
	movwf	SysBYTETempB
	call	SysDivSub
	movf	SysBYTETempA,W
	movwf	LCDVALUETEMP
;LCDValue = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	LCDVALUE
;LCDWriteByte(LCDValueTemp + 48)
	movlw	48
	addwf	LCDVALUETEMP,W
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE_T6963
;End If
ENDIF38
;If LCDValueTemp > 0 Or LCDValue >= 10 Then
	movf	LCDVALUETEMP,W
	movwf	SysBYTETempB
	clrf	SysBYTETempA
	call	SysCompLessThan
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	LCDVALUE
	movf	LCDVALUE,W
	movwf	SysBYTETempA
	movlw	10
	movwf	SysBYTETempB
	call	SysCompLessThan
	comf	SysByteTempX,F
	banksel	SYSTEMP1
	movf	SysTemp1,W
	iorwf	SysByteTempX,W
	movwf	SysTemp2
	btfss	SysTemp2,0
	goto	ENDIF39
;LCDValueTemp = LCDValue / 10
	banksel	LCDVALUE
	movf	LCDVALUE,W
	movwf	SysBYTETempA
	movlw	10
	movwf	SysBYTETempB
	call	SysDivSub
	movf	SysBYTETempA,W
	movwf	LCDVALUETEMP
;LCDValue = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	LCDVALUE
;LCDWriteByte(LCDValueTemp + 48)
	movlw	48
	addwf	LCDVALUETEMP,W
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE_T6963
;End If
ENDIF39
;LCDWriteByte (LCDValue + 48)
	movlw	48
	banksel	LCDVALUE
	addwf	LCDVALUE,W
	movwf	LCDBYTE
	goto	LCDNORMALWRITEBYTE_T6963

;********************************************************************************

PUT_T6963
;LOCATE LCDPutLine, LCDPutColumn
	movf	LCDPUTLINE,W
	movwf	LCDLINE
	movf	LCDPUTCOLUMN,W
	movwf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;GLCDispDataWr( LCDChar )      'Adjust standard ASCII to T6963 ASCII
	movf	LCDCHAR,W
	movwf	LCDDATABYTE
	call	GLCDSENDDATA_T6963
;GLCDispCmdSend(DATA_WR)       'Write data
	movlw	196
	movwf	LCDCMDBYTE
	goto	GLCDSENDCOMMAND_T6963

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
	call	SysCompEqual16
	btfss	SysByteTempX,0
	goto	ENDIF50
;SysWordTempA = 0
	clrf	SYSWORDTEMPA
	clrf	SYSWORDTEMPA_H
;exit sub
	return
;end if
ENDIF50
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
	goto	ENDIF51
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	addwfc	SYSDIVMULTX_H,F
;End If
ENDIF51
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
	goto	ENDIF46
	movf	SYSDIVMULTA,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTA_H,W
	addwfc	SYSDIVMULTX_H,F
ENDIF46
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
	call	SysCompLessThan16
	btfsc	SysByteTempX,0
	goto	MUL16LOOP
ENDIF47
;SysWordTempX = SysDivMultX
	movf	SYSDIVMULTX,W
	movwf	SYSWORDTEMPX
	movf	SYSDIVMULTX_H,W
	movwf	SYSWORDTEMPX_H
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
	goto	ENDIF48
	movf	SYSLONGDIVMULTA,W
	addwf	SYSLONGDIVMULTX,F
	movf	SYSLONGDIVMULTA_H,W
	addwfc	SYSLONGDIVMULTX_H,F
	movf	SYSLONGDIVMULTA_U,W
	addwfc	SYSLONGDIVMULTX_U,F
	movf	SYSLONGDIVMULTA_E,W
	addwfc	SYSLONGDIVMULTX_E,F
ENDIF48
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
	call	SysCompLessThan32
	btfsc	SysByteTempX,0
	goto	MUL32LOOP
ENDIF49
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
;Start of program memory page 4
	ORG	8192
;Start of program memory page 5
	ORG	10240
;Start of program memory page 6
	ORG	12288
;Start of program memory page 7
	ORG	14336

 END
