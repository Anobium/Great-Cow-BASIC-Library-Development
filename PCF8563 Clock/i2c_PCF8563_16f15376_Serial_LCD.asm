;Program compiled by Great Cow BASIC (0.98.<<>> 2019-01-21 (Windows 32 bit))
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F15376, r=DEC
#include <P16F15376.inc>
 __CONFIG _CONFIG1, _RSTOSC_HFINT32
 __CONFIG _CONFIG2, _MCLRE_OFF
 __CONFIG _CONFIG3, _WDTE_OFF
 __CONFIG _CONFIG4, _LVP_OFF

;********************************************************************************

;Set aside memory locations for variables
BCDTODEC	EQU	32
BYTENUM	EQU	33
BYTETOBIN	EQU	10174
CHARARRAY	EQU	10165
DATE	EQU	34
DAYSMAX	EQU	35
DECTOBCD	EQU	36
DELAYTEMP	EQU	112
DELAYTEMP2	EQU	113
DOW	EQU	37
DS_DATE	EQU	38
DS_DOW	EQU	39
DS_HOUR	EQU	40
DS_MIN	EQU	41
DS_MONTH	EQU	42
DS_REG	EQU	43
DS_SEC	EQU	44
DS_VAL	EQU	45
DS_VALUE	EQU	46
DS_YEAR	EQU	47
HI2CACKPOLLSTATE	EQU	48
HI2CCURRENTMODE	EQU	49
HI2CGETACK	EQU	50
HI2CWAITMSSPTIMEOUT	EQU	51
HOUR	EQU	52
I2CBYTE	EQU	53
I2C_LCD_BYTE	EQU	54
LCDBYTE	EQU	55
LCDCHAR	EQU	56
LCDCHARLOC	EQU	57
LCDCOLUMN	EQU	58
LCDCRSR	EQU	59
LCDLINE	EQU	60
LCDLOC	EQU	61
LCDNORMALREADBYTE	EQU	62
LCDTEMP	EQU	63
LCDVALUE	EQU	64
LCDVALUETEMP	EQU	65
LCD_BACKLIGHT	EQU	66
LCD_I2C_ADDRESS_CURRENT	EQU	67
LCD_STATE	EQU	68
LEFTPAD	EQU	10183
MIN	EQU	69
MONTH	EQU	70
MYREG	EQU	71
OLDSEC	EQU	72
PCF85X3_READVL	EQU	73
PRINTLEN	EQU	74
SEC	EQU	75
STR	EQU	10159
STRINGPOINTER	EQU	76
SYSARRAYTEMP1	EQU	77
SYSARRAYTEMP2	EQU	78
SYSBITVAR0	EQU	79
SYSBYTETEMPA	EQU	117
SYSBYTETEMPB	EQU	121
SYSBYTETEMPX	EQU	112
SYSCALCTEMPA	EQU	117
SYSCALCTEMPX	EQU	112
SYSCALCTEMPX_H	EQU	113
SYSCHARCOUNT	EQU	80
SYSDIVLOOP	EQU	116
SYSDIVMULTA	EQU	119
SYSDIVMULTA_H	EQU	120
SYSDIVMULTB	EQU	123
SYSDIVMULTB_H	EQU	124
SYSDIVMULTX	EQU	114
SYSDIVMULTX_H	EQU	115
SYSLCDCHARDATAHANDLER	EQU	81
SYSLCDCHARDATAHANDLER_H	EQU	82
SYSLCDTEMP	EQU	83
SYSPRINTDATAHANDLER	EQU	84
SYSPRINTDATAHANDLER_H	EQU	85
SYSPRINTTEMP	EQU	86
SYSREPEATTEMP1	EQU	87
SYSREPEATTEMP2	EQU	88
SYSSTRDATA	EQU	89
SYSSTRINGA	EQU	119
SYSSTRINGA_H	EQU	120
SYSSTRINGLENGTH	EQU	118
SYSSTRINGPARAM1	EQU	160
SYSSTRINGTEMP	EQU	90
SYSSTRLEN	EQU	91
SYSSYSINSTRING2HANDLER	EQU	92
SYSSYSINSTRING2HANDLER_H	EQU	93
SYSSYSINSTRINGHANDLER	EQU	94
SYSSYSINSTRINGHANDLER_H	EQU	95
SYSTEMP1	EQU	96
SYSTEMP1_H	EQU	97
SYSTEMP2	EQU	98
SYSTEMP3	EQU	99
SYSVALTEMP	EQU	100
SYSVALTEMP_H	EQU	101
SYSWAITTEMP10US	EQU	117
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
VA	EQU	102
YEAR	EQU	103
_HEF_DUMMY	EQU	104

;********************************************************************************

;Alias variables
AFSR0	EQU	4
AFSR0_H	EQU	5
SYSCHARARRAY_1	EQU	3158
SYSCHARARRAY_2	EQU	3159
SYSCHARARRAY_3	EQU	3160
SYSCHARARRAY_4	EQU	3161
SYSCHARARRAY_5	EQU	3162
SYSCHARARRAY_6	EQU	3163
SYSCHARARRAY_7	EQU	3164
SYSCHARARRAY_8	EQU	3165
SYSLEFTPAD_0	EQU	3175
SYSSTR_0	EQU	3151
DS_ENABLESTATE	EQU	44

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
	call	INITPPS
	call	HIC2INIT
	call	INITLCD

;Start of the main program
;''A demonstration program for GCGB and GCB.
;''--------------------------------------------------------------------------------------------------------------------------------
;''This program shows the real time clock on a LCD. The LCD is driven by a LCD I2C adapter.
;''Two types of LCD are supported using this method, as shown below:
;'':        Set LCD_10 to 10 for the YwRobot LCD1602 IIC V1 or the Sainsmart LCD_PIC I2C adapter
;'':        Set LCD_10 to 12 for the Ywmjkdz I2C adapter with pot bent over top of chip
;''The PCF85x3 is attached to the I2C ports with appropiate resistors to the supply voltage.  Typically a 5k or 2.2k resistor 'pulling up' to the supply voltage can be used.
;'':
;'':    There are two pushbuttons: Mode and Set equates to Key1 and Key2. Connected to portb.0 and portb.1 resepectively.
;'':
;'':    During normal operation, the Mode button will toggle
;'':    between 12- and 24-hours modes.
;'':
;'':    This has two modes US date and UK date style.
;'':    Change ''':clocktype''': to 0 for US and 1 for UK
;'':
;'':    To set a new date and time, press the Set button
;'':    which will take you consecutively to Month, Day, Year,
;'':    Day of the Week, Hour, Minute and Second. Within each of
;'':    these, press Mode to cycle through the possible values.
;'':    You may hold the Mode button to increment automatically,
;'':    or press momentarily for a single increment. Time is
;'':    always set in 24-hour clock format.
;''@author          EvanV
;''@licence GPL
;''@version 0.9a
;''@date    29.1.2019
;''********************************************************************************
;----- Configuration
;Generated by PIC PPS Tool for Great Cow Basic
;PPS Tool version: 0.0.5.22
;PinManager data: Not available (3)
;Generated for 16F15376
;
;Template comment at the start of the config file
;
;#define PPSToolPart 16F15376
;Template comment at the end of the config file
;#define DS_AddrWrite 0xA2
;#define DS_AddrRead  0xA3
;''Set up LCD
;#define LCD_IO 10
;#define LCD_I2C_Address_1 0x4C ; default to 0x4E
;You may need to use SLOW or MEDIUM if your LCD is a slower device.
;#define LCD_SPEED FAST
;You may need to invert these states. Dependent of LCD I2C adapter.
;#define LCD_Backlight_On_State  1
;#define LCD_Backlight_Off_State 0
;----- Define Hardware settings for hwi2c
;Define I2C settings - CHANGE PORTS if required for your specific device.
;#define hi2c_BAUD_RATE 100
;#define hi2c_DATA PORTb.5
;#define hi2c_CLOCK PORTb.7
;Initialise I2C Master
;I2C pins need to be input for SSP2 module
;Dir hi2c_DATA in
	bsf	TRISB,5
;Dir hi2c_CLOCK in
	bsf	TRISB,7
;----- Define Clock and the input switch hardware settings
;#define setBut      portb.0         ;Set pushbutton
;#define modeBut     portb.1         ;Mode pushbutton
;dir setBut in
	bsf	TRISB,0
;dir modeBut in
	bsf	TRISB,1
;#define clocktype   1               ;0 is US or 1 is UK style
;#define debounce    50 ms           ;settling time for switches
;#define delay       150 ms          ;delay time for pushbutton
;#define pressed     1               ;flag for pressed pushbutton
;#define Alarm0 0x00                 ;a reference to the alarm 0
;#define Alarm1 0x01                 ;a reference to the alarm 1
;----- Variables
;Dim DAYSMAX, DAYSMAX as Byte
;dim changed as bit
;dim hour, min, sec as byte
;dim oldsec as byte
;dim date, month, year, DOW as byte
;dim dayMax as byte
;oldsec = 255                        ;      init value
	movlw	255
	movwf	OLDSEC
;----- Tables
;----- Program
;CreateCustomCharacters
	pagesel	CREATECUSTOMCHARACTERS
	call	CREATECUSTOMCHARACTERS
	pagesel	$
;LCDCursor CURSOROFF
	movlw	13
	movwf	LCDCRSR
	call	LCDCURSOR
;locate 0,0
	clrf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;Print "PCF85x3 Clock"
	movlw	low StringTable2
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable2) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT136
	call	PRINT136
	pagesel	$
;locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;Print "Great Cow Basic 2019"
	movlw	low StringTable3
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable3) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT136
	call	PRINT136
	pagesel	$
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
;CLS
	pagesel	CLS
	call	CLS
	pagesel	$
;Constants when calling PCF85x3_ResetClock that can/could be set.
;#define  PCF85x3_DEFAULT_SEC         0
;#define  PCF85x3_DEFAULT_MIN         52
;#define  PCF85x3_DEFAULT_HOUR        15
;#define  PCF85x3_DEFAULT_DAY         29
;#define  PCF85x3_DEFAULT_WEEKDAY     2
;#define  PCF85x3_DEFAULT_MONTH       1
;#define  PCF85x3_DEFAULT_YEAR        19
;The constants above are used as the defaults when you reset the clock
;PCF85x3_ResetClock
	call	PCF85X3_RESETCLOCK
	pagesel	$
;PCF85x3_Enable
	movlw	255
	movwf	DS_VALUE
	pagesel	PCF85X3_ENABLE
	call	PCF85X3_ENABLE
	pagesel	$
;or, set the clock this way
;PCF85x3_SetClock(        20,         17,        0,         2,          29,        1,          19)
	movlw	20
	movwf	DS_HOUR
	movlw	17
	movwf	DS_MIN
	clrf	DS_SEC
	movlw	2
	movwf	DS_DOW
	movlw	29
	movwf	DS_DATE
	movlw	1
	movwf	DS_MONTH
	movlw	19
	movwf	DS_YEAR
	call	PCF85X3_SETCLOCK
	pagesel	$
;set the ClockOut by enabling like this
;PCF85x3_EnableClockout ( true )
	movlw	255
	movwf	DS_VALUE
	pagesel	PCF85X3_ENABLECLOCKOUT
	call	PCF85X3_ENABLECLOCKOUT
	pagesel	$
;set the ClockOut frequency like this, using the following Constants
;PCF85x3_CLKOUT_CTRL_REG_32_768_kHz
;PCF85x3_CLKOUT_CTRL_REG_1_024_kHz
;PCF85x3_CLKOUT_CTRL_REG_32_Hz
;PCF85x3_CLKOUT_CTRL_REG_1_Hz
;PCF85x3_EnableClockoutFrequency ( PCF85x3_CLKOUT_CTRL_REG_1_Hz )
	movlw	3
	movwf	DS_VALUE
	pagesel	PCF85X3_ENABLECLOCKOUTFREQUENCY
	call	PCF85X3_ENABLECLOCKOUTFREQUENCY
	pagesel	$
;set the alarm like this...
;PCF85x3_SetAlarm( hour, mins )
;or
;PCF85x3_SetAlarm( hour, mins, day of the week[0-6], day of the month [1-31] )
;set the alarm for 07:00 hrs
;PCF85x3_SetAlarm( 7, 15 )
	movlw	7
	movwf	DS_HOUR
	movlw	15
	movwf	DS_MIN
	pagesel	PCF85X3_SETALARM18
	call	PCF85X3_SETALARM18
	pagesel	$
;PCF85x3_EnableAlarm ( PCF85x3_Alarm2Assertion_MinuteHour )
	movlw	3
	movwf	DS_VAL
	pagesel	PCF85X3_ENABLEALARM
	call	PCF85X3_ENABLEALARM
	pagesel	$
;Main body of program commences here.
;PCF85x3_ReadDate(DOW, date, month, year)   ;get initial date
	call	PCF85X3_READDATE
	pagesel	$
	movf	DS_DOW,W
	movwf	DOW
	movf	DS_DATE,W
	movwf	DATE
	movf	DS_MONTH,W
	movwf	MONTH
	movf	DS_YEAR,W
	movwf	YEAR
;do
SysDoLoop_S1
;updateDisp                        ;show time and date
	pagesel	UPDATEDISP
	call	UPDATEDISP
	pagesel	$
;if setBut = pressed then
	btfss	PORTB,0
	goto	ENDIF1
;changeSetting                   ;change time and date
	call	CHANGESETTING
	pagesel	$
;end if
ENDIF1
;if modeBut = pressed then
	btfsc	PORTB,1
;ShowAlarm
	call	SHOWALARM
;end if
ENDIF2
;loop
	goto	SysDoLoop_S1
SysDoLoop_E1
;end
	goto	BASPROGRAMEND
;----- Subroutines
;-----
;-----
;-----
;-----
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

;********************************************************************************

FN_BYTETOBIN
;ByteToBin = ""
	movlw	low BYTETOBIN
	movwf	FSR1L
	movlw	high BYTETOBIN
	movwf	FSR1H
	movlw	low StringTable49
	movwf	SysStringA
	movlw	(high StringTable49) & 127
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
;Repeat 8
	movlw	8
	movwf	SysRepeatTemp2
SysRepeatLoop2
;If ByteNum.7 = 1 Then
	btfss	BYTENUM,7
	goto	ELSE49_1
;ByteToBin = ByteToBin +"1"
	movlw	low BYTETOBIN
	movwf	FSR1L
	movlw	high BYTETOBIN
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low BYTETOBIN
	movwf	FSR0L
	movlw	high BYTETOBIN
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low StringTable50
	movwf	SysStringA
	movlw	(high StringTable50) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low BYTETOBIN
	movwf	FSR0L
	movlw	high BYTETOBIN
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
;Else
	goto	ENDIF49
ELSE49_1
;ByteToBin = ByteToBin +"0"
	movlw	low BYTETOBIN
	movwf	FSR1L
	movlw	high BYTETOBIN
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low BYTETOBIN
	movwf	FSR0L
	movlw	high BYTETOBIN
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low StringTable4
	movwf	SysStringA
	movlw	(high StringTable4) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low BYTETOBIN
	movwf	FSR0L
	movlw	high BYTETOBIN
	movwf	FSR0H
	movf	SysStringLength,W
	movwf	INDF0
;End If
ENDIF49
;Rotate ByteNum Left
	rlf	BYTENUM,F
;End Repeat
	decfsz	SysRepeatTemp2,F
	goto	SysRepeatLoop2
SysRepeatLoopEnd2
	return

;********************************************************************************

CHANGESETTING
;changed = false                   ;assume no change will be made
	bcf	SYSBITVAR0,0
;do while setBut = pressed         ;wait for Set release
SysDoLoop_S2
	btfss	PORTB,0
	goto	SysDoLoop_E2
;wait debounce
	movlw	50
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;loop
	goto	SysDoLoop_S2
SysDoLoop_E2
;wait while ( setBut = pressed ) or ( modeBut = pressed )
SysWaitLoop1
	clrf	SysByteTempX
	btfsc	PORTB,0
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	movwf	SysTemp1
	clrf	SysByteTempX
	btfsc	PORTB,1
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	movwf	SysTemp2
	movf	SysTemp1,W
	iorwf	SysTemp2,W
	movwf	SysTemp3
	btfsc	SysTemp3,0
	goto	SysWaitLoop1
;if clocktype = 0 then             ; handle US and UK clock type
;SetDate
	pagesel	SETDATE
	call	SETDATE
;SetMonth
	pagesel	SETMONTH
	call	SETMONTH
;end if
;SetYear
	pagesel	SETYEAR
	call	SETYEAR
;***** Day of the Week
;cls
	pagesel	CLS
	call	CLS
	pagesel	$
;Print "Set Weekday:"
	movlw	low StringTable17
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable17) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT136
	call	PRINT136
	pagesel	$
;locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;printDate
	call	PRINTDATE
	pagesel	$
;do
SysDoLoop_S3
;do while modeBut = pressed      ;Mode button held
SysDoLoop_S4
	btfss	PORTB,1
	goto	SysDoLoop_E4
;DOW++                         ;increment while pressed
	incf	DOW,F
;if DOW > 6 then               ;0 = Sunday, etc.
	movf	DOW,W
	sublw	6
	btfss	STATUS, C
;DOW = 0
	clrf	DOW
;end if
ENDIF7
;locate 1,0                    ;Print updated display
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;printDate
	call	PRINTDATE
	pagesel	$
;wait while modeBut = pressed  ;wait for repeat
SysWaitLoop2
	btfsc	PORTB,1
	goto	SysWaitLoop2
;changed = true                ;a change was made
	bsf	SYSBITVAR0,0
;loop
	goto	SysDoLoop_S4
SysDoLoop_E4
;loop while setBut <> pressed
	btfss	PORTB,0
	goto	SysDoLoop_S3
SysDoLoop_E3
;do while setBut = pressed         ;wait for Set release
SysDoLoop_S5
	btfss	PORTB,0
	goto	SysDoLoop_E5
;wait debounce
	movlw	50
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;loop
	goto	SysDoLoop_S5
SysDoLoop_E5
;***** Hour
;cls
	pagesel	CLS
	call	CLS
	pagesel	$
;Print "Set Hours:"
	movlw	low StringTable18
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable18) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT136
	call	PRINT136
	pagesel	$
;locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;printTime
	call	PRINTTIME
	pagesel	$
;do
SysDoLoop_S6
;do while modeBut = pressed      ;Mode button held
SysDoLoop_S7
	btfss	PORTB,1
	goto	SysDoLoop_E7
;hour++                        ;increment while pressed
	incf	HOUR,F
;if hour > 23 then             ;remember, set in 24-hour mode
	movf	HOUR,W
	sublw	23
	btfss	STATUS, C
;hour = 0
	clrf	HOUR
;end if
ENDIF8
;locate 1,0                    ;Print updated display
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;printTime
	call	PRINTTIME
	pagesel	$
;wait while modeBut = pressed  ;wait for repeat
SysWaitLoop3
	btfsc	PORTB,1
	goto	SysWaitLoop3
;changed = true                ;a change was made
	bsf	SYSBITVAR0,0
;loop
	goto	SysDoLoop_S7
SysDoLoop_E7
;loop while setBut <> pressed
	btfss	PORTB,0
	goto	SysDoLoop_S6
SysDoLoop_E6
;do while setBut = pressed         ;wait for Set release
SysDoLoop_S8
	btfss	PORTB,0
	goto	SysDoLoop_E8
;wait debounce
	movlw	50
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;loop
	goto	SysDoLoop_S8
SysDoLoop_E8
;***** Minutes
;cls
	pagesel	CLS
	call	CLS
	pagesel	$
;Print "Set Minutes:"
	movlw	low StringTable19
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable19) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT136
	call	PRINT136
	pagesel	$
;locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;printTime
	call	PRINTTIME
	pagesel	$
;do
SysDoLoop_S9
;do while modeBut = pressed      ;Mode button held
SysDoLoop_S10
	btfss	PORTB,1
	goto	SysDoLoop_E10
;min++                         ;increment while pressed
	incf	MIN,F
;if min > 59 then              ;0 to 59 minutes
	movf	MIN,W
	sublw	59
	btfss	STATUS, C
;min = 0
	clrf	MIN
;end if
ENDIF9
;locate 1,0                    ;Print updated display
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;printTime
	call	PRINTTIME
	pagesel	$
;wait while modeBut = pressed  ;wait for repeat
SysWaitLoop4
	btfsc	PORTB,1
	goto	SysWaitLoop4
;changed = true                ;a change was made
	bsf	SYSBITVAR0,0
;loop
	goto	SysDoLoop_S10
SysDoLoop_E10
;loop while setBut <> pressed
	btfss	PORTB,0
	goto	SysDoLoop_S9
SysDoLoop_E9
;do while setBut = pressed         ;wait for Set release
SysDoLoop_S11
	btfss	PORTB,0
	goto	SysDoLoop_E11
;wait debounce
	movlw	50
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;loop
	goto	SysDoLoop_S11
SysDoLoop_E11
;***** Second
;cls
	pagesel	CLS
	call	CLS
	pagesel	$
;Print "Set Seconds:"
	movlw	low StringTable20
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable20) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT136
	call	PRINT136
	pagesel	$
;locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;printTime
	call	PRINTTIME
	pagesel	$
;do
SysDoLoop_S12
;do while modeBut = pressed      ;Mode button held
SysDoLoop_S13
	btfss	PORTB,1
	goto	SysDoLoop_E13
;sec++                         ;increment while pressed
	incf	SEC,F
;if sec > 59 then              ;0 to 59 seconds
	movf	SEC,W
	sublw	59
	btfss	STATUS, C
;sec = 0
	clrf	SEC
;end if
ENDIF10
;locate 1,0                    ;Print updated display
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;printTime
	call	PRINTTIME
	pagesel	$
;wait while modeBut = pressed  ;wait for repeat
SysWaitLoop5
	btfsc	PORTB,1
	goto	SysWaitLoop5
;changed = true                ;a change was made
	bsf	SYSBITVAR0,0
;loop
	goto	SysDoLoop_S13
SysDoLoop_E13
;loop while setBut <> pressed
	btfss	PORTB,0
	goto	SysDoLoop_S12
SysDoLoop_E12
;do while setBut = pressed         ;wait for Set release
SysDoLoop_S14
	btfss	PORTB,0
	goto	SysDoLoop_E14
;wait debounce
	movlw	50
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;loop
	goto	SysDoLoop_S14
SysDoLoop_E14
;***** Execute the new settings
;if changed then
	btfss	SYSBITVAR0,0
	goto	ENDIF11
;cls
	pagesel	CLS
	call	CLS
	pagesel	$
;Print "Press Set, or"
	movlw	low StringTable21
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable21) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT136
	call	PRINT136
	pagesel	$
;locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;Print "Mode to revert"
	movlw	low StringTable22
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable22) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT136
	call	PRINT136
	pagesel	$
;do while (setBut <> pressed)          ;wait for the Set button
SysDoLoop_S15
	btfsc	PORTB,0
	goto	SysDoLoop_E15
;wait debounce
	movlw	50
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;if ModeBut = pressed then
	btfss	PORTB,1
	goto	ENDIF12
;cls                               ;clear last message
	pagesel	CLS
	call	CLS
	pagesel	$
;do nothing - you could add setting the clock
;exit Sub                          ;exit set routine
	return
;end if
ENDIF12
;loop
	goto	SysDoLoop_S15
SysDoLoop_E15
;PCF85x3_SetClock(hour, min, sec, DOW, date, month, year)
	movf	HOUR,W
	movwf	DS_HOUR
	movf	MIN,W
	movwf	DS_MIN
	movf	SEC,W
	movwf	DS_SEC
	movf	DOW,W
	movwf	DS_DOW
	movf	DATE,W
	movwf	DS_DATE
	movf	MONTH,W
	movwf	DS_MONTH
	movf	YEAR,W
	movwf	DS_YEAR
	call	PCF85X3_SETCLOCK
	pagesel	$
;end if
ENDIF11
;do while (setBut = pressed)       ;wait for Set release
SysDoLoop_S16
	btfss	PORTB,0
	goto	SysDoLoop_E16
;loop
	goto	SysDoLoop_S16
SysDoLoop_E16
;wait debounce                     ;let it settle
	movlw	50
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
;cls                               ;clear last message
	pagesel	CLS
	call	CLS
	pagesel	$
;PCF85x3_Enable                    ;ensure the clock is running
	movlw	255
	movwf	DS_VALUE
	pagesel	PCF85X3_ENABLE
	goto	PCF85X3_ENABLE

;********************************************************************************

HI2CRECEIVE
;Enable receive
;Master mode
;If HI2CCurrentMode > 10 Then
	movf	HI2CCURRENTMODE,W
	sublw	10
	btfsc	STATUS, C
	goto	ELSE65_1
;if HI2CGetAck.0 = 1 then
	btfss	HI2CGETACK,0
	goto	ELSE67_1
;Acknowledge
;ACKDT = 0
	banksel	SSP1CON2
	bcf	SSP1CON2,ACKDT
;else
	goto	ENDIF67
ELSE67_1
;Not Acknowledge
;ACKDT = 1
	banksel	SSP1CON2
	bsf	SSP1CON2,ACKDT
;end if
ENDIF67
;RCEN = 1
	bsf	SSP1CON2,RCEN
;Slave mode
;Else
	goto	ENDIF65
ELSE65_1
;SET SSPSTAT.R_NOT_W ON
	banksel	SSP1STAT
	bsf	SSP1STAT,R_NOT_W
;End If
ENDIF65
;Clear Collisions
;SET SSPCON1.WCOL OFF
	bcf	SSP1CON1,WCOL
;SET SSPCON1.SSPOV Off
	bcf	SSP1CON1,SSPOV
;Wait for receive
;Wait Until SSPSTAT.BF = 1 AND SSPIF = 1
SysWaitLoop12
	clrf	SysByteTempX
	banksel	SSP1STAT
	btfsc	SSP1STAT,BF
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	clrf	SysByteTempX
	banksel	PIR3
	btfsc	PIR3,SSP1IF
	comf	SysByteTempX,F
	banksel	SYSTEMP2
	movf	SysTemp2,W
	andwf	SysByteTempX,W
	movwf	SysTemp3
	btfss	SysTemp3,0
	goto	SysWaitLoop12
;I2CByte = SSPBUF
	banksel	SSP1BUF
	movf	SSP1BUF,W
	banksel	I2CBYTE
	movwf	I2CBYTE
;SSPIF = 0''Support for SSPIF
	banksel	PIR3
	bcf	PIR3,SSP1IF
;ACKEN = 1; Send ACK DATA now. ' bsf SSPCON2,ACKEN
	banksel	SSP1CON2
	bsf	SSP1CON2,ACKEN
;Clear flag - this is required
;SSPSTAT.BF = 0
	bcf	SSP1STAT,BF
;HI2CWaitMSSP
	banksel	STATUS
	pagesel	HI2CWAITMSSP
	call	HI2CWAITMSSP
	pagesel	$
;Disable receive (master mode)
;Master mode
;If HI2CCurrentMode > 10 Then
	movf	HI2CCURRENTMODE,W
	sublw	10
	btfsc	STATUS, C
	goto	ELSE66_1
;Set SSPCON2.RCEN Off
	banksel	SSP1CON2
	bcf	SSP1CON2,RCEN
;Slave mode
;Else
	goto	ENDIF66
ELSE66_1
;SET SSPSTAT.R_NOT_W Off
	banksel	SSP1STAT
	bcf	SSP1STAT,R_NOT_W
;End If
ENDIF66
	banksel	STATUS
	return

;********************************************************************************

HIC2INIT
;HI2CCurrentMode = 0
	clrf	HI2CCURRENTMODE
;Initialise the I2C module
	return

;********************************************************************************

INITI2CLCD
;moved to a sub support multiple devices
;wait 15 ms
	movlw	15
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;LCDWriteByte 0x03: wait 5 ms
	movlw	3
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
	movlw	5
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;LCDWriteByte 0x03: wait 1 ms
	movlw	3
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;LCDWriteByte 0x03: wait 1 ms
	movlw	3
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;LCDWriteByte 0x03: wait 1 ms
	movlw	3
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;LCDWriteByte 0x02: wait 1 ms
	movlw	2
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;LCDWriteByte 0x28: wait 1 ms
	movlw	40
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;LCDWriteByte 0x0c: wait 1 ms
	movlw	12
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;LCDWriteByte 0x01: wait 15 ms
	movlw	1
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
	movlw	15
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;LCDWriteByte 0x06: wait 1 ms
	movlw	6
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;CLS
	pagesel	CLS
	goto	CLS

;********************************************************************************

INITLCD
;Initialization routines based upon code examples
;in HD44780 datasheet
;Configure RS,Enable & RW pin directions
;***********************************
;I2C pcf8574 initialization routine
;***********************************
;HI2CMode Master    ;call to Master required to init I2C Baud Rate here!
	movlw	12
	movwf	HI2CCURRENTMODE
	pagesel	HI2CMODE
	call	HI2CMODE
	pagesel	$
;LCD_Backlight = LCD_Backlight_On_State
	movlw	1
	movwf	LCD_BACKLIGHT
;wait 2 ms
	movlw	2
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;repeat 2  ; called to ensure reset is complete.  Needed for cheap LCDs!!
	movlw	2
	movwf	SysRepeatTemp1
SysRepeatLoop1
;LCD_I2C_Address_Current = LCD_I2C_Address_1
	movlw	76
	movwf	LCD_I2C_ADDRESS_CURRENT
;initI2CLCD
	call	INITI2CLCD
	pagesel	$
;end repeat
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop1
SysRepeatLoopEnd1
;LCD_State = 12
	movlw	12
	movwf	LCD_STATE
	return

;********************************************************************************

INITPPS
;Module: MSSP1
;RB5PPS = 0x0016    'SDA1 > RB5
	movlw	22
	banksel	RB5PPS
	movwf	RB5PPS
;SSP1DATPPS = 0x000D    'RB5 > SDA1 (bi-directional)
	movlw	13
	banksel	SSP1DATPPS
	movwf	SSP1DATPPS
;RB7PPS = 0x0015    'SCL1 > RB7
	movlw	21
	banksel	RB7PPS
	movwf	RB7PPS
;SSP1CLKPPS = 0x000F    'RB7 > SCL1 (bi-directional)
	movlw	15
	banksel	SSP1CLKPPS
	movwf	SSP1CLKPPS
;Module: EUSART1
;RB6PPS = 0x000F    'TX1 > RB6
	movlw	15
	banksel	RB6PPS
	movwf	RB6PPS
	banksel	STATUS
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
;asm showdebug OSCCON type is 102 'therefore not CHIPFamily 16
;osccon type is 102
;OSCFRQ = 0b00000110 'OSCSTAT chip.... the 16f18855 style chip
	movlw	6
	movwf	OSCFRQ
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
	banksel	ADCON1
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
;PORTD = 0
	clrf	PORTD
;PORTE = 0
	clrf	PORTE
	return

;********************************************************************************

LCDCURSOR
;Revised Evan Venn March 2014
;Revised William Roth Jan 2105
;Can be LCDON, LCDOFF, CURSORON, CURSOROFF, FLASHON, Or FLASHOFF
;1) FLASH is the same as FLASHON and has been retained
;for compatibility but should be considererd depricated.
;
;2) ON & OFF Have been superceded with LCDON & LCDOFF for clarity.
;However they Will still work as usual. This was done
;because LCDCURSOR(OFF | ON) was confusing and implied
;control of the cursor instead of the entire display.
;
;3) With this revision, changing one setting does not change the others.
;eg.  FlashOFF does turn off the cursor and CURSOROFF does not
;turn off Flash. Cursor and flash states are not changed when the
;display is turned OFF or ON with LCDCURSOR LCDON OR LCDCURSOR LCDOFF.
;
;4) See Help For New Commands  LCD_OFF and LCD_ON
;LCD_ON & LCD OFF are separate Subs that when called
;will also turn off the cursor and flash if they are on
;-------------------------------------------------------------------
;Set LCD_RS OFF
	bcf	SYSLCDTEMP,1
;If LCDCRSR = ON  Then LCDTemp = LCD_State OR LCDON
	decf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF35
	movlw	12
	iorwf	LCD_STATE,W
	movwf	LCDTEMP
ENDIF35
;IF LCDCRSR = LCDON Then LCDTemp = LCD_State OR LCDON
	movlw	12
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF36
	movlw	12
	iorwf	LCD_STATE,W
	movwf	LCDTEMP
ENDIF36
;If LCDCRSR = OFF Then LCDTemp = LCD_State AND LCDOFF
	movf	LCDCRSR,F
	btfss	STATUS, Z
	goto	ENDIF37
	movlw	11
	andwf	LCD_STATE,W
	movwf	LCDTEMP
ENDIF37
;If LCDCRSR = LCDOFF Then LCDTemp = LCD_State AND LCDOFF
	movlw	11
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF38
	movlw	11
	andwf	LCD_STATE,W
	movwf	LCDTEMP
ENDIF38
;If LCDCRSR = CursorOn Then LCDTemp = LCD_State OR CursorON
	movlw	10
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF39
	movlw	10
	iorwf	LCD_STATE,W
	movwf	LCDTEMP
ENDIF39
;If LCDCRSR = CursorOFF then LCDTemp = LCD_State and CursorOFF
	movlw	13
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF40
	movlw	13
	andwf	LCD_STATE,W
	movwf	LCDTEMP
ENDIF40
;If LCDCRSR = FLASH  Then LCDTemp = LCD_State OR FLASHON
	movlw	9
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF41
	movlw	9
	iorwf	LCD_STATE,W
	movwf	LCDTEMP
ENDIF41
;If LCDCRSR = FLASHON  Then LCDTemp = LCD_State OR FLASHON
	movlw	9
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF42
	movlw	9
	iorwf	LCD_STATE,W
	movwf	LCDTEMP
ENDIF42
;If LCDCRSR = FLASHOFF then LCDTemp = LCD_State and FLASHOFF
	movlw	14
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF43
	movlw	14
	andwf	LCD_STATE,W
	movwf	LCDTEMP
ENDIF43
;LCDWriteByte(LCDTemp)
	movf	LCDTEMP,W
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
;LCD_State = LCDtemp  'save last state
	movf	LCDTEMP,W
	movwf	LCD_STATE
	return

;********************************************************************************

LCDNORMALWRITEBYTE
;IF LCD_RS = 1 then
	btfss	SYSLCDTEMP,1
	goto	ELSE23_1
;i2c_lcd_rs=1;   ''' Data
	bsf	I2C_LCD_BYTE,0
;ELSE
	goto	ENDIF23
ELSE23_1
;i2c_lcd_rs=0;   ''' Command
	bcf	I2C_LCD_BYTE,0
;end if
ENDIF23
;i2c_lcd_rw  = 0;
	bcf	I2C_LCD_BYTE,1
;i2c_lcd_bl  = LCD_Backlight.0;
	bcf	I2C_LCD_BYTE,3
	btfsc	LCD_BACKLIGHT,0
	bsf	I2C_LCD_BYTE,3
ENDIF26
;HI2CStart                        ;generate a start signal
	pagesel	HI2CSTART
	call	HI2CSTART
	pagesel	$
;HI2CSend LCD_I2C_Address_Current   ;indicate a write
	movf	LCD_I2C_ADDRESS_CURRENT,W
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;i2c_lcd_d7 = LCDByte.7
	bcf	I2C_LCD_BYTE,7
	btfsc	LCDBYTE,7
	bsf	I2C_LCD_BYTE,7
ENDIF27
;i2c_lcd_d6 = LCDByte.6
	bcf	I2C_LCD_BYTE,6
	btfsc	LCDBYTE,6
	bsf	I2C_LCD_BYTE,6
ENDIF28
;i2c_lcd_d5 = LCDByte.5
	bcf	I2C_LCD_BYTE,5
	btfsc	LCDBYTE,5
	bsf	I2C_LCD_BYTE,5
ENDIF29
;i2c_lcd_d4 = LCDByte.4
	bcf	I2C_LCD_BYTE,4
	btfsc	LCDBYTE,4
	bsf	I2C_LCD_BYTE,4
ENDIF30
;i2c_lcd_e = 0;
	bcf	I2C_LCD_BYTE,2
;HI2CSend i2c_lcd_byte
	movf	I2C_LCD_BYTE,W
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;i2c_lcd_e = 1;
	bsf	I2C_LCD_BYTE,2
;HI2CSend i2c_lcd_byte
	movf	I2C_LCD_BYTE,W
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;i2c_lcd_e = 0;
	bcf	I2C_LCD_BYTE,2
;HI2CSend i2c_lcd_byte
	movf	I2C_LCD_BYTE,W
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;'' Send lower nibble
;i2c_lcd_d7 = LCDByte.3
	bcf	I2C_LCD_BYTE,7
	btfsc	LCDBYTE,3
	bsf	I2C_LCD_BYTE,7
ENDIF31
;i2c_lcd_d6 = LCDByte.2
	bcf	I2C_LCD_BYTE,6
	btfsc	LCDBYTE,2
	bsf	I2C_LCD_BYTE,6
ENDIF32
;i2c_lcd_d5 = LCDByte.1
	bcf	I2C_LCD_BYTE,5
	btfsc	LCDBYTE,1
	bsf	I2C_LCD_BYTE,5
ENDIF33
;i2c_lcd_d4 = LCDByte.0
	bcf	I2C_LCD_BYTE,4
	btfsc	LCDBYTE,0
	bsf	I2C_LCD_BYTE,4
ENDIF34
;i2c_lcd_e = 0;
	bcf	I2C_LCD_BYTE,2
;HI2CSend i2c_lcd_byte
	movf	I2C_LCD_BYTE,W
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;i2c_lcd_e = 1;
	bsf	I2C_LCD_BYTE,2
;HI2CSend i2c_lcd_byte
	movf	I2C_LCD_BYTE,W
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;i2c_lcd_e = 0;
	bcf	I2C_LCD_BYTE,2
;HI2CSend i2c_lcd_byte
	movf	I2C_LCD_BYTE,W
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
;HI2CStop
	pagesel	HI2CSTOP
	call	HI2CSTOP
	pagesel	$
;LCD_State = 12
	movlw	12
	movwf	LCD_STATE
;character delay settings
;wait fast_us us
	movlw	26
	movwf	DELAYTEMP
DelayUS1
	decfsz	DELAYTEMP,F
	goto	DelayUS1
	nop
;IF LCDByte < 16 then
	movlw	16
	subwf	LCDBYTE,W
	btfsc	STATUS, C
	goto	ENDIF24
;if LCDByte > 7 then
	movf	LCDBYTE,W
	sublw	7
	btfsc	STATUS, C
	goto	ENDIF25
;LCD_State = LCDByte
	movf	LCDBYTE,W
	movwf	LCD_STATE
;end if
ENDIF25
;END IF
ENDIF24
	return

;********************************************************************************

FN_LEFTPAD
;check input length
;return if too short or equal SysStrLen
;If SysStrLen > SysInString(0) Then
	movf	SysSYSINSTRINGHandler,W
	movwf	AFSR0
	movf	SysSYSINSTRINGHandler_H,W
	movwf	AFSR0_H
	movf	SYSSTRLEN,W
	subwf	INDF0,W
	btfsc	STATUS, C
	goto	ELSE50_1
;LeftPad = ""
	movlw	low LEFTPAD
	movwf	FSR1L
	movlw	high LEFTPAD
	movwf	FSR1H
	movlw	low StringTable49
	movwf	SysStringA
	movlw	(high StringTable49) & 127
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
;LeftPad(0) = SysStrLen       'set string to new length
	movf	SYSSTRLEN,W
	banksel	SYSLEFTPAD_0
	movwf	SYSLEFTPAD_0
;SysCharCount = SysStrLen - SysInString(0) 'diff-length To incoming string
	banksel	SYSSYSINSTRINGHANDLER
	movf	SysSYSINSTRINGHandler,W
	movwf	AFSR0
	movf	SysSYSINSTRINGHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	subwf	SYSSTRLEN,W
	movwf	SYSCHARCOUNT
;add sysInString2 to new String
;for SysStringTemp = 1 to SysCharCount
	clrf	SYSSTRINGTEMP
	movlw	1
	subwf	SYSCHARCOUNT,W
	btfss	STATUS, C
	goto	SysForLoopEnd3
ENDIF51
SysForLoop3
	incf	SYSSTRINGTEMP,F
;LeftPad(sysStringTemp) = SysInString2(1)
	movlw	1
	addwf	SysSYSINSTRING2Handler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysSYSINSTRING2Handler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SysArrayTemp1
	movwf	SysArrayTemp2
	movlw	low(LEFTPAD)
	addwf	SYSSTRINGTEMP,W
	movwf	AFSR0
	clrf	SysTemp2
	movlw	high(LEFTPAD)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movf	SysArrayTemp2,W
	movwf	INDF0
;Next
	movf	SYSCHARCOUNT,W
	subwf	SYSSTRINGTEMP,W
	btfss	STATUS, C
	goto	SysForLoop3
ENDIF52
SysForLoopEnd3
;add old content to new string
;For SysStringTemp = 1 To sysInString(0)
	clrf	SYSSTRINGTEMP
	movf	SysSYSINSTRINGHandler,W
	movwf	AFSR0
	movf	SysSYSINSTRINGHandler_H,W
	movwf	AFSR0_H
	movlw	1
	subwf	INDF0,W
	btfss	STATUS, C
	goto	SysForLoopEnd4
ENDIF53
SysForLoop4
	incf	SYSSTRINGTEMP,F
;LeftPad(sysCharCount + sysStringTemp) = SysInString(SysStringTemp)
	movf	SYSSTRINGTEMP,W
	addwf	SysSYSINSTRINGHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysSYSINSTRINGHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SysArrayTemp1
	movwf	SysArrayTemp2
	movf	SYSSTRINGTEMP,W
	addwf	SYSCHARCOUNT,W
	movwf	SysTemp2
	movlw	low(LEFTPAD)
	addwf	SysTemp2,W
	movwf	AFSR0
	clrf	SysTemp3
	movlw	high(LEFTPAD)
	addwfc	SysTemp3,W
	movwf	AFSR0_H
	movf	SysArrayTemp2,W
	movwf	INDF0
;Next
	movf	SysSYSINSTRINGHandler,W
	movwf	AFSR0
	movf	SysSYSINSTRINGHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	subwf	SYSSTRINGTEMP,W
	btfss	STATUS, C
	goto	SysForLoop4
ENDIF54
SysForLoopEnd4
;Else
	goto	ENDIF50
ELSE50_1
;LeftPad = SysInString
	movlw	low LEFTPAD
	movwf	FSR1L
	movlw	high LEFTPAD
	movwf	FSR1H
	movf	SysSYSINSTRINGHandler,W
	movwf	FSR0L
	movf	SysSYSINSTRINGHandler_H,W
	movwf	FSR0H
	pagesel	SysCopyString
	call	SysCopyString
	pagesel	$
;end if
ENDIF50
	return

;********************************************************************************

PCF85X3_READDATE
;Get date only: day of week, date, month, year
;do
SysDoLoop_S33
;HI2CReStart                          ;generate a start signal
	pagesel	HI2CRESTART
	call	HI2CRESTART
	pagesel	$
;HI2CSend(DS_AddrWrite)                     ;inidcate a write
	movlw	162
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;loop While HI2CAckPollState
	movf	hi2cackpollstate,F
	btfss	STATUS,Z
	goto	SysDoLoop_S33
SysDoLoop_E33
;HI2CSend( PCF85x3_DAYS_REG )                      ;begin
	movlw	5
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
;HI2CReStart
	pagesel	HI2CRESTART
	call	HI2CRESTART
	pagesel	$
;HI2CSend(DS_AddrRead)
	movlw	163
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CReceive(DS_Date)             ;get date
	movlw	1
	movwf	HI2CGETACK
	call	HI2CRECEIVE
	movf	I2CBYTE,W
	movwf	DS_DATE
;DS_Date = BcdToDec(DS_Date  & PCF85x3_DAYS_REG_MASK)
	movlw	63
	andwf	DS_DATE,W
	movwf	VA
	pagesel	FN_BCDTODEC
	call	FN_BCDTODEC
	pagesel	$
	movf	BCDTODEC,W
	movwf	DS_DATE
;HI2CReceive(DS_DOW)              ;get day of week
	movlw	1
	movwf	HI2CGETACK
	call	HI2CRECEIVE
	movf	I2CBYTE,W
	movwf	DS_DOW
;DS_DOW = BcdToDec(DS_DOW & PCF85x3_WKDAY_REG_MASK )
	movlw	3
	andwf	DS_DOW,W
	movwf	VA
	pagesel	FN_BCDTODEC
	call	FN_BCDTODEC
	pagesel	$
	movf	BCDTODEC,W
	movwf	DS_DOW
;HI2CReceive(DS_Month)            ;get month
	movlw	1
	movwf	HI2CGETACK
	call	HI2CRECEIVE
	movf	I2CBYTE,W
	movwf	DS_MONTH
;DS_Month = BcdToDec(DS_Month & PCF85x3_MONTHS_REG_MASK)
	movlw	31
	andwf	DS_MONTH,W
	movwf	VA
	pagesel	FN_BCDTODEC
	call	FN_BCDTODEC
	pagesel	$
	movf	BCDTODEC,W
	movwf	DS_MONTH
;HI2CReceive(DS_Year, NACK)       ;get year
	clrf	HI2CGETACK
	call	HI2CRECEIVE
	movf	I2CBYTE,W
	movwf	DS_YEAR
;DS_Year = BcdToDec(DS_Year & PCF85x3_YEARS_REG_MASK)
	movwf	VA
	pagesel	FN_BCDTODEC
	call	FN_BCDTODEC
	pagesel	$
	movf	BCDTODEC,W
	movwf	DS_YEAR
;HI2CStop
	pagesel	HI2CSTOP
	goto	HI2CSTOP

;********************************************************************************

PCF85X3_RESETCLOCK
;Reset clock to default date/Time
;do
SysDoLoop_S27
;HI2CReStart                          ;generate a start signal
	pagesel	HI2CRESTART
	call	HI2CRESTART
	pagesel	$
;HI2CSend(DS_AddrWrite)                     ;inidcate a write
	movlw	162
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;loop While HI2CAckPollState
	movf	hi2cackpollstate,F
	btfss	STATUS,Z
	goto	SysDoLoop_S27
SysDoLoop_E27
;HI2CSend(PCF85x3_VL_SEC_REG)              ;begin
	movlw	2
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CSend(DecToBcd ( PCF85x3_DEFAULT_SEC ))                      ;then set the seven
	clrf	VA
	pagesel	FN_DECTOBCD
	call	FN_DECTOBCD
	pagesel	$
	movf	DECTOBCD,W
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CSend(DecToBcd ( PCF85x3_DEFAULT_MIN ))                      ;consecutive locations
	movlw	52
	movwf	VA
	pagesel	FN_DECTOBCD
	call	FN_DECTOBCD
	pagesel	$
	movf	DECTOBCD,W
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CSend(DecToBcd ( PCF85x3_DEFAULT_HOUR ))
	movlw	15
	movwf	VA
	pagesel	FN_DECTOBCD
	call	FN_DECTOBCD
	pagesel	$
	movf	DECTOBCD,W
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CSend( DecToBcd ( PCF85x3_DEFAULT_DAY ) )
	movlw	29
	movwf	VA
	pagesel	FN_DECTOBCD
	call	FN_DECTOBCD
	pagesel	$
	movf	DECTOBCD,W
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CSend( DecToBcd ( PCF85x3_DEFAULT_WEEKDAY ) )
	movlw	2
	movwf	VA
	pagesel	FN_DECTOBCD
	call	FN_DECTOBCD
	pagesel	$
	movf	DECTOBCD,W
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CSend( DecToBcd ( PCF85x3_DEFAULT_MONTH ) )
	movlw	1
	movwf	VA
	pagesel	FN_DECTOBCD
	call	FN_DECTOBCD
	pagesel	$
	movf	DECTOBCD,W
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CSend( DecToBcd ( PCF85x3_DEFAULT_YEAR ) )
	movlw	19
	movwf	VA
	pagesel	FN_DECTOBCD
	call	FN_DECTOBCD
	pagesel	$
	movf	DECTOBCD,W
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CStop
	pagesel	HI2CSTOP
	goto	HI2CSTOP

;********************************************************************************

PCF85X3_SETCLOCK
;Set entire clock: hours, minutes, seconds, day of week, date, month, year
;do
SysDoLoop_S28
;HI2CReStart                          ;generate a start signal
	pagesel	HI2CRESTART
	call	HI2CRESTART
	pagesel	$
;HI2CSend(DS_AddrWrite)                     ;inidcate a write
	movlw	162
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;loop While HI2CAckPollState
	movf	hi2cackpollstate,F
	btfss	STATUS,Z
	goto	SysDoLoop_S28
SysDoLoop_E28
;HI2CSend( PCF85x3_VL_SEC_REG )   ;begin
	movlw	2
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CSend(DecToBcd(DS_Sec))       ;then set the seven
	movf	DS_SEC,W
	movwf	VA
	pagesel	FN_DECTOBCD
	call	FN_DECTOBCD
	pagesel	$
	movf	DECTOBCD,W
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CSend(DecToBcd(DS_Min))       ;consecutive values
	movf	DS_MIN,W
	movwf	VA
	pagesel	FN_DECTOBCD
	call	FN_DECTOBCD
	pagesel	$
	movf	DECTOBCD,W
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CSend(DecToBcd(DS_Hour))
	movf	DS_HOUR,W
	movwf	VA
	pagesel	FN_DECTOBCD
	call	FN_DECTOBCD
	pagesel	$
	movf	DECTOBCD,W
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CSend(DecToBcd(DS_Date))
	movf	DS_DATE,W
	movwf	VA
	pagesel	FN_DECTOBCD
	call	FN_DECTOBCD
	pagesel	$
	movf	DECTOBCD,W
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CSend(DecToBcd(DS_DOW))
	movf	DS_DOW,W
	movwf	VA
	pagesel	FN_DECTOBCD
	call	FN_DECTOBCD
	pagesel	$
	movf	DECTOBCD,W
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CSend(DecToBcd(DS_Month))
	movf	DS_MONTH,W
	movwf	VA
	pagesel	FN_DECTOBCD
	call	FN_DECTOBCD
	pagesel	$
	movf	DECTOBCD,W
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CSend(DecToBcd(DS_Year))
	movf	DS_YEAR,W
	movwf	VA
	pagesel	FN_DECTOBCD
	call	FN_DECTOBCD
	pagesel	$
	movf	DECTOBCD,W
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CStop
	pagesel	HI2CSTOP
	goto	HI2CSTOP

;********************************************************************************

;Overloaded signature: BYTE:
PRINT137
;LCDValueTemp = 0
	clrf	LCDVALUETEMP
;Set LCD_RS On
	bsf	SYSLCDTEMP,1
;IF LCDValue >= 100 Then
	movlw	100
	subwf	LCDVALUE,W
	btfss	STATUS, C
	goto	ENDIF76
;LCDValueTemp = LCDValue / 100
	movf	LCDVALUE,W
	movwf	SysBYTETempA
	movlw	100
	movwf	SysBYTETempB
	pagesel	SysDivSub
	call	SysDivSub
	pagesel	$
	movf	SysBYTETempA,W
	movwf	LCDVALUETEMP
;LCDValue = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	LCDVALUE
;LCDWriteByte(LCDValueTemp + 48)
	movlw	48
	addwf	LCDVALUETEMP,W
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
;End If
ENDIF76
;If LCDValueTemp > 0 Or LCDValue >= 10 Then
	movf	LCDVALUETEMP,W
	movwf	SysBYTETempB
	clrf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	movf	SysByteTempX,W
	movwf	SysTemp2
	movf	LCDVALUE,W
	movwf	SysBYTETempA
	movlw	10
	movwf	SysBYTETempB
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysTemp2,W
	iorwf	SysByteTempX,W
	movwf	SysTemp3
	btfss	SysTemp3,0
	goto	ENDIF77
;LCDValueTemp = LCDValue / 10
	movf	LCDVALUE,W
	movwf	SysBYTETempA
	movlw	10
	movwf	SysBYTETempB
	pagesel	SysDivSub
	call	SysDivSub
	pagesel	$
	movf	SysBYTETempA,W
	movwf	LCDVALUETEMP
;LCDValue = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	LCDVALUE
;LCDWriteByte(LCDValueTemp + 48)
	movlw	48
	addwf	LCDVALUETEMP,W
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
;End If
ENDIF77
;LCDWriteByte (LCDValue + 48)
	movlw	48
	addwf	LCDVALUE,W
	movwf	LCDBYTE
	goto	LCDNORMALWRITEBYTE

;********************************************************************************

PRINTDATE
;select case DOW                   ;day of the week
;case 0:
SysSelect1Case1
	movf	DOW,F
	btfss	STATUS, Z
	goto	SysSelect1Case2
;Print "Sun."
	movlw	low StringTable7
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable7) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT136
	call	PRINT136
	pagesel	$
;case 1:
	goto	SysSelectEnd1
SysSelect1Case2
	decf	DOW,W
	btfss	STATUS, Z
	goto	SysSelect1Case3
;Print "Mon."
	movlw	low StringTable8
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable8) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT136
	call	PRINT136
	pagesel	$
;case 2:
	goto	SysSelectEnd1
SysSelect1Case3
	movlw	2
	subwf	DOW,W
	btfss	STATUS, Z
	goto	SysSelect1Case4
;Print "Tue."
	movlw	low StringTable9
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable9) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT136
	call	PRINT136
	pagesel	$
;case 3:
	goto	SysSelectEnd1
SysSelect1Case4
	movlw	3
	subwf	DOW,W
	btfss	STATUS, Z
	goto	SysSelect1Case5
;Print "Wed."
	movlw	low StringTable10
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable10) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT136
	call	PRINT136
	pagesel	$
;case 4:
	goto	SysSelectEnd1
SysSelect1Case5
	movlw	4
	subwf	DOW,W
	btfss	STATUS, Z
	goto	SysSelect1Case6
;Print "Thu."
	movlw	low StringTable11
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable11) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT136
	call	PRINT136
	pagesel	$
;case 5:
	goto	SysSelectEnd1
SysSelect1Case6
	movlw	5
	subwf	DOW,W
	btfss	STATUS, Z
	goto	SysSelect1Case7
;Print "Fri."
	movlw	low StringTable12
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable12) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT136
	call	PRINT136
	pagesel	$
;case 6:
	goto	SysSelectEnd1
SysSelect1Case7
	movlw	6
	subwf	DOW,W
	btfss	STATUS, Z
	goto	SysSelect1Case8
;Print "Sat."
	movlw	low StringTable13
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable13) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT136
	call	PRINT136
	pagesel	$
;case else
	goto	SysSelectEnd1
SysSelect1Case8
;Print str(DOW)+":"
	movf	DOW,W
	movwf	SYSVALTEMP
	clrf	SYSVALTEMP_H
	call	FN_STR
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low STR
	movwf	FSR0L
	movlw	high STR
	movwf	FSR0H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low StringTable5
	movwf	SysStringA
	movlw	(high StringTable5) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
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
	pagesel	PRINT136
	call	PRINT136
	pagesel	$
;end select
SysSelectEnd1
;if clocktype = 0 then
;Print date
	movf	DATE,W
	movwf	LCDVALUE
	call	PRINT137
;Print "/"
	movlw	low StringTable14
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable14) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT136
	call	PRINT136
	pagesel	$
;Print month
	movf	MONTH,W
	movwf	LCDVALUE
	call	PRINT137
;Print "/20"                       ;make four-digit year
	movlw	low StringTable15
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable15) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT136
	call	PRINT136
	pagesel	$
;if year < 10 then
	movlw	10
	subwf	YEAR,W
	btfsc	STATUS, C
	goto	ENDIF75
;Print "0"
	movlw	low StringTable4
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable4) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT136
	call	PRINT136
	pagesel	$
;end if
ENDIF75
;end if
;Print year
	movf	YEAR,W
	movwf	LCDVALUE
	call	PRINT137
;Print " "                        ;blank any garbage
	movlw	low StringTable16
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable16) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT136
	goto	PRINT136

;********************************************************************************

PRINTTIME
;if hour < 10 then                 ;left pad with zero
	movlw	10
	subwf	HOUR,W
	btfsc	STATUS, C
	goto	ENDIF71
;Print "0"
	movlw	low StringTable4
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable4) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT136
	call	PRINT136
	pagesel	$
;end if
ENDIF71
;Print hour
	movf	HOUR,W
	movwf	LCDVALUE
	call	PRINT137
;Print ":"
	movlw	low StringTable5
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable5) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT136
	call	PRINT136
	pagesel	$
;if min < 10 then                  ;left pad with zero
	movlw	10
	subwf	MIN,W
	btfsc	STATUS, C
	goto	ENDIF72
;Print "0"
	movlw	low StringTable4
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable4) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT136
	call	PRINT136
	pagesel	$
;end if
ENDIF72
;Print min
	movf	MIN,W
	movwf	LCDVALUE
	call	PRINT137
;Print ":"
	movlw	low StringTable5
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable5) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT136
	call	PRINT136
	pagesel	$
;if sec < 10 then                  ;left pad with zero
	movlw	10
	subwf	SEC,W
	btfsc	STATUS, C
	goto	ENDIF73
;Print "0"
	movlw	low StringTable4
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable4) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT136
	call	PRINT136
	pagesel	$
;end if
ENDIF73
;Print sec
	movf	SEC,W
	movwf	LCDVALUE
	call	PRINT137
;Print "     "                    ;wipe out any garbage
	movlw	low StringTable6
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable6) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT136
	goto	PRINT136

;********************************************************************************

SHOWALARM
;locate 3,0
	movlw	3
	movwf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;dim myreg as Byte
;print "Alarm "
	movlw	low StringTable26
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable26) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT136
	call	PRINT136
	pagesel	$
;PCF85x3_ReadRegister ( 0x0a, myreg )
	movlw	10
	movwf	DS_REG
	pagesel	PCF85X3_READREGISTER
	call	PCF85X3_READREGISTER
	pagesel	$
	movf	DS_VAL,W
	movwf	MYREG
;print leftpad( str(BcdToDec( myreg  & 0x7f )),2, "0" )
	movlw	127
	andwf	MYREG,W
	movwf	VA
	pagesel	FN_BCDTODEC
	call	FN_BCDTODEC
	pagesel	$
	movf	BCDTODEC,W
	movwf	SYSVALTEMP
	clrf	SYSVALTEMP_H
	call	FN_STR
	movlw	low STR
	movwf	SysSYSINSTRINGHandler
	movlw	high STR
	movwf	SysSYSINSTRINGHandler_H
	movlw	2
	movwf	SYSSTRLEN
	movlw	low StringTable4
	movwf	SysSYSINSTRING2Handler
	movlw	(high StringTable4) | 128
	movwf	SysSYSINSTRING2Handler_H
	call	FN_LEFTPAD
	movlw	low LEFTPAD
	movwf	SysPRINTDATAHandler
	movlw	high LEFTPAD
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT136
	call	PRINT136
	pagesel	$
;print ":"
	movlw	low StringTable5
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable5) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT136
	call	PRINT136
	pagesel	$
;PCF85x3_ReadRegister ( 0x09, myreg )
	movlw	9
	movwf	DS_REG
	pagesel	PCF85X3_READREGISTER
	call	PCF85X3_READREGISTER
	pagesel	$
	movf	DS_VAL,W
	movwf	MYREG
;print leftpad( str(BcdToDec( myreg  & 0x7f )),2, "0" )
	movlw	127
	andwf	MYREG,W
	movwf	VA
	pagesel	FN_BCDTODEC
	call	FN_BCDTODEC
	pagesel	$
	movf	BCDTODEC,W
	movwf	SYSVALTEMP
	clrf	SYSVALTEMP_H
	call	FN_STR
	movlw	low STR
	movwf	SysSYSINSTRINGHandler
	movlw	high STR
	movwf	SysSYSINSTRINGHandler_H
	movlw	2
	movwf	SYSSTRLEN
	movlw	low StringTable4
	movwf	SysSYSINSTRING2Handler
	movlw	(high StringTable4) | 128
	movwf	SysSYSINSTRING2Handler_H
	call	FN_LEFTPAD
	movlw	low LEFTPAD
	movwf	SysPRINTDATAHandler
	movlw	high LEFTPAD
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT136
	call	PRINT136
	pagesel	$
;locate 2,12
;PCF85x3_ReadRegister ( 0x09, myreg )
;print ByteToBin ( BcdToDec( myreg ) )
;
;locate 3,12
;PCF85x3_ReadRegister ( 0x0a, myreg )
;print ByteToBin ( BcdToDec( myreg ) )
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
	goto	ENDIF45
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
	clrf	SysTemp2
	movlw	high(STR)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF0
;Goto SysValThousands
	goto	SYSVALTHOUSANDS
;End If
ENDIF45
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
	goto	ENDIF46
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
	clrf	SysTemp2
	movlw	high(STR)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF0
;Goto SysValHundreds
	goto	SYSVALHUNDREDS
;End If
ENDIF46
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
	goto	ENDIF47
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
	clrf	SysTemp2
	movlw	high(STR)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF0
;Goto SysValTens
	goto	SYSVALTENS
;End If
ENDIF47
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
	goto	ENDIF48
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
	clrf	SysTemp2
	movlw	high(STR)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF0
;End If
ENDIF48
;Ones
;SysCharCount += 1
	incf	SYSCHARCOUNT,F
;Str(SysCharCount) = SysValTemp + 48
	movlw	low(STR)
	addwf	SYSCHARCOUNT,W
	movwf	AFSR0
	clrf	SysTemp2
	movlw	high(STR)
	addwfc	SysTemp2,W
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
	goto	ENDIF78
;SysWordTempA = 0
	clrf	SYSWORDTEMPA
	clrf	SYSWORDTEMPA_H
;exit sub
	return
;end if
ENDIF78
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
	goto	ENDIF79
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	addwfc	SYSDIVMULTX_H,F
;End If
ENDIF79
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

SysStringTables
	movf	SysStringA_H,W
	movwf	PCLATH
	movf	SysStringA,W
	incf	SysStringA,F
	btfsc	STATUS,Z
	incf	SysStringA_H,F
	movwf	PCL

StringTable2
	retlw	13
	retlw	80	;P
	retlw	67	;C
	retlw	70	;F
	retlw	56	;8
	retlw	53	;5
	retlw	120	;x
	retlw	51	;3
	retlw	32	; 
	retlw	67	;C
	retlw	108	;l
	retlw	111	;o
	retlw	99	;c
	retlw	107	;k


StringTable3
	retlw	20
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
	retlw	97	;a
	retlw	115	;s
	retlw	105	;i
	retlw	99	;c
	retlw	32	; 
	retlw	50	;2
	retlw	48	;0
	retlw	49	;1
	retlw	57	;9


StringTable4
	retlw	1
	retlw	48	;0


StringTable5
	retlw	1
	retlw	58	;:


StringTable6
	retlw	5
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 


StringTable7
	retlw	4
	retlw	83	;S
	retlw	117	;u
	retlw	110	;n
	retlw	46	;.


StringTable8
	retlw	4
	retlw	77	;M
	retlw	111	;o
	retlw	110	;n
	retlw	46	;.


StringTable9
	retlw	4
	retlw	84	;T
	retlw	117	;u
	retlw	101	;e
	retlw	46	;.


StringTable10
	retlw	4
	retlw	87	;W
	retlw	101	;e
	retlw	100	;d
	retlw	46	;.


StringTable11
	retlw	4
	retlw	84	;T
	retlw	104	;h
	retlw	117	;u
	retlw	46	;.


StringTable12
	retlw	4
	retlw	70	;F
	retlw	114	;r
	retlw	105	;i
	retlw	46	;.


StringTable13
	retlw	4
	retlw	83	;S
	retlw	97	;a
	retlw	116	;t
	retlw	46	;.


StringTable14
	retlw	1
	retlw	47	;/


StringTable15
	retlw	3
	retlw	47	;/
	retlw	50	;2
	retlw	48	;0


StringTable16
	retlw	1
	retlw	32	; 


StringTable17
	retlw	12
	retlw	83	;S
	retlw	101	;e
	retlw	116	;t
	retlw	32	; 
	retlw	87	;W
	retlw	101	;e
	retlw	101	;e
	retlw	107	;k
	retlw	100	;d
	retlw	97	;a
	retlw	121	;y
	retlw	58	;:


StringTable18
	retlw	10
	retlw	83	;S
	retlw	101	;e
	retlw	116	;t
	retlw	32	; 
	retlw	72	;H
	retlw	111	;o
	retlw	117	;u
	retlw	114	;r
	retlw	115	;s
	retlw	58	;:


StringTable19
	retlw	12
	retlw	83	;S
	retlw	101	;e
	retlw	116	;t
	retlw	32	; 
	retlw	77	;M
	retlw	105	;i
	retlw	110	;n
	retlw	117	;u
	retlw	116	;t
	retlw	101	;e
	retlw	115	;s
	retlw	58	;:


StringTable20
	retlw	12
	retlw	83	;S
	retlw	101	;e
	retlw	116	;t
	retlw	32	; 
	retlw	83	;S
	retlw	101	;e
	retlw	99	;c
	retlw	111	;o
	retlw	110	;n
	retlw	100	;d
	retlw	115	;s
	retlw	58	;:


StringTable21
	retlw	13
	retlw	80	;P
	retlw	114	;r
	retlw	101	;e
	retlw	115	;s
	retlw	115	;s
	retlw	32	; 
	retlw	83	;S
	retlw	101	;e
	retlw	116	;t
	retlw	44	;,
	retlw	32	; 
	retlw	111	;o
	retlw	114	;r


StringTable22
	retlw	14
	retlw	77	;M
	retlw	111	;o
	retlw	100	;d
	retlw	101	;e
	retlw	32	; 
	retlw	116	;t
	retlw	111	;o
	retlw	32	; 
	retlw	114	;r
	retlw	101	;e
	retlw	118	;v
	retlw	101	;e
	retlw	114	;r
	retlw	116	;t


StringTable23
	retlw	10
	retlw	83	;S
	retlw	101	;e
	retlw	116	;t
	retlw	32	; 
	retlw	77	;M
	retlw	111	;o
	retlw	110	;n
	retlw	116	;t
	retlw	104	;h
	retlw	58	;:


StringTable24
	retlw	9
	retlw	83	;S
	retlw	101	;e
	retlw	116	;t
	retlw	32	; 
	retlw	68	;D
	retlw	97	;a
	retlw	116	;t
	retlw	101	;e
	retlw	58	;:


StringTable25
	retlw	9
	retlw	83	;S
	retlw	101	;e
	retlw	116	;t
	retlw	32	; 
	retlw	89	;Y
	retlw	101	;e
	retlw	97	;a
	retlw	114	;r
	retlw	58	;:


StringTable26
	retlw	6
	retlw	65	;A
	retlw	108	;l
	retlw	97	;a
	retlw	114	;r
	retlw	109	;m
	retlw	32	; 


StringTable49
	retlw	0


StringTable50
	retlw	1
	retlw	49	;1


;********************************************************************************

;Start of program memory page 1
	ORG	2048
FN_BCDTODEC
;Convert binary coded decimal to pure decimal
;BcdToDec=( va /16)*10+ ( va % 16 )
	movf	VA,W
	movwf	SysBYTETempA
	movlw	16
	movwf	SysBYTETempB
	call	SysDivSub
	movf	SysBYTETempA,W
	movwf	SysTemp1
	movf	VA,W
	movwf	SysBYTETempA
	movlw	16
	movwf	SysBYTETempB
	call	SysDivSub
	movf	SysBYTETempX,W
	movwf	SysTemp2
	movf	SysTemp1,W
	movwf	SysBYTETempA
	movlw	10
	movwf	SysBYTETempB
	call	SysMultSub
	movf	SysTemp2,W
	addwf	SysBYTETempX,W
	movwf	BCDTODEC
	return

;********************************************************************************

CLS
;SET LCD_RS OFF
	bcf	SYSLCDTEMP,1
;Clear screen
;LCDWriteByte (0b00000001)
	movlw	1
	movwf	LCDBYTE
	pagesel	LCDNORMALWRITEBYTE
	call	LCDNORMALWRITEBYTE
	pagesel	$
;Wait 4 ms
	movlw	4
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;Move to start of visible DDRAM
;LCDWriteByte(0x80)
	movlw	128
	movwf	LCDBYTE
	pagesel	LCDNORMALWRITEBYTE
	call	LCDNORMALWRITEBYTE
	pagesel	$
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

FN_DECTOBCD
;Convert pure decimal number to binary coded decimal
;DecToBcd=( va /10)*16+ va % 10
	movf	VA,W
	movwf	SysBYTETempA
	movlw	10
	movwf	SysBYTETempB
	call	SysDivSub
	movf	SysBYTETempA,W
	movwf	SysTemp1
	movwf	SysBYTETempA
	movlw	16
	movwf	SysBYTETempB
	call	SysMultSub
	movf	SysBYTETempX,W
	movwf	SysTemp2
	movf	VA,W
	movwf	SysBYTETempA
	movlw	10
	movwf	SysBYTETempB
	call	SysDivSub
	movf	SysBYTETempX,W
	addwf	SysTemp2,W
	movwf	DECTOBCD
	return

;********************************************************************************

Delay_10US
D10US_START
	movlw	25
	movwf	DELAYTEMP
DelayUS0
	decfsz	DELAYTEMP,F
	goto	DelayUS0
	nop
	decfsz	SysWaitTemp10US, F
	goto	D10US_START
	return

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

HI2CMODE
;#ifndef Var(SSPCON1)
;#ifdef Var(SSPCON)
;Dim SSPCON1 Alias SSPCON
;#endif
;#endif
;added to seperate from newer i2C module which does not have an MSSP
;set SSPSTAT.SMP on
	banksel	SSP1STAT
	bsf	SSP1STAT,SMP
;set SSPCON1.CKP on
	bsf	SSP1CON1,CKP
;set SSPCON1.WCOL Off
	bcf	SSP1CON1,WCOL
;Select mode and clock
;If HI2CCurrentMode = Master Then
	movlw	12
	banksel	HI2CCURRENTMODE
	subwf	HI2CCURRENTMODE,W
	btfss	STATUS, Z
	goto	ENDIF55
;set SSPCON1.SSPM3 on
	banksel	SSP1CON1
	bsf	SSP1CON1,SSPM3
;set SSPCON1.SSPM2 off
	bcf	SSP1CON1,SSPM2
;set SSPCON1.SSPM1 off
	bcf	SSP1CON1,SSPM1
;set SSPCON1.SSPM0 off
	bcf	SSP1CON1,SSPM0
;SSPADD = HI2C_BAUD_TEMP And 127
	movlw	79
	movwf	SSP1ADD
;end if
ENDIF55
;if HI2CCurrentMode = Slave then
	banksel	HI2CCURRENTMODE
	movf	HI2CCURRENTMODE,F
	btfss	STATUS, Z
	goto	ENDIF56
;set SSPCON1.SSPM3 off
	banksel	SSP1CON1
	bcf	SSP1CON1,SSPM3
;set SSPCON1.SSPM2 on
	bsf	SSP1CON1,SSPM2
;set SSPCON1.SSPM1 on
	bsf	SSP1CON1,SSPM1
;set SSPCON1.SSPM0 off
	bcf	SSP1CON1,SSPM0
;end if
ENDIF56
;if HI2CCurrentMode = Slave10 then
	movlw	3
	banksel	HI2CCURRENTMODE
	subwf	HI2CCURRENTMODE,W
	btfss	STATUS, Z
	goto	ENDIF57
;set SSPCON1.SSPM3 off
	banksel	SSP1CON1
	bcf	SSP1CON1,SSPM3
;set SSPCON1.SSPM2 on
	bsf	SSP1CON1,SSPM2
;set SSPCON1.SSPM1 on
	bsf	SSP1CON1,SSPM1
;set SSPCON1.SSPM0 on
	bsf	SSP1CON1,SSPM0
;end if
ENDIF57
;Enable I2C
;set SSPCON1.SSPEN on
	banksel	SSP1CON1
	bsf	SSP1CON1,SSPEN
	banksel	STATUS
	return

;********************************************************************************

HI2CRESTART
;Master mode
;If HI2CCurrentMode > 10 Then
	movf	HI2CCURRENTMODE,W
	sublw	10
	btfsc	STATUS, C
	goto	ENDIF59
;Set RSEN On
	banksel	SSP1CON2
	bsf	SSP1CON2,RSEN
;HI2CWaitMSSP
	banksel	STATUS
	call	HI2CWAITMSSP
;End If
ENDIF59
	return

;********************************************************************************

HI2CSEND
RETRYHI2CSEND
;Clear WCOL
;SET SSPCON1.WCOL OFF
	banksel	SSP1CON1
	bcf	SSP1CON1,WCOL
;Load data to send
;SSPBUF = I2CByte
	banksel	I2CBYTE
	movf	I2CBYTE,W
	banksel	SSP1BUF
	movwf	SSP1BUF
;HI2CWaitMSSP
	banksel	STATUS
	call	HI2CWAITMSSP
;if ACKSTAT =  1 then
	banksel	SSP1CON2
	btfss	SSP1CON2,ACKSTAT
	goto	ELSE61_1
;HI2CAckPollState = true
	movlw	255
	banksel	HI2CACKPOLLSTATE
	movwf	HI2CACKPOLLSTATE
;else
	goto	ENDIF61
ELSE61_1
;HI2CAckPollState = false
	banksel	HI2CACKPOLLSTATE
	clrf	HI2CACKPOLLSTATE
;end if
ENDIF61
;If SSPCON1.WCOL = On Then
	banksel	SSP1CON1
	btfss	SSP1CON1,WCOL
	goto	ENDIF62
;If HI2CCurrentMode <= 10 Then Goto RetryHI2CSend
	banksel	HI2CCURRENTMODE
	movf	HI2CCURRENTMODE,W
	sublw	10
	btfsc	STATUS, C
	goto	RETRYHI2CSEND
ENDIF64
;End If
ENDIF62
;Release clock (only needed by slave)
;If HI2CCurrentMode <= 10 Then Set SSPCON1.CKP On
	banksel	HI2CCURRENTMODE
	movf	HI2CCURRENTMODE,W
	sublw	10
	btfss	STATUS, C
	goto	ENDIF63
	banksel	SSP1CON1
	bsf	SSP1CON1,CKP
ENDIF63
	banksel	STATUS
	return

;********************************************************************************

HI2CSTART
;Master mode
;If HI2CCurrentMode > 10 Then
	movf	HI2CCURRENTMODE,W
	sublw	10
	btfsc	STATUS, C
	goto	ELSE58_1
;Set SEN On
	banksel	SSP1CON2
	bsf	SSP1CON2,SEN
;HI2CWaitMSSP
	banksel	STATUS
	call	HI2CWAITMSSP
;for device with SEN_SSP1CON2 and therefore devices including the 18FxxK40
;Slave mode
;Else
	goto	ENDIF58
ELSE58_1
;Wait Until SSPSTAT.S = On
SysWaitLoop9
	banksel	SSP1STAT
	btfss	SSP1STAT,S
	goto	SysWaitLoop9
;End If
ENDIF58
	banksel	STATUS
	return

;********************************************************************************

HI2CSTOP
;Master mode
;If HI2CCurrentMode > 10 Then
	movf	HI2CCURRENTMODE,W
	sublw	10
	btfsc	STATUS, C
	goto	ELSE60_1
;set SSPIE OFF; disable SSP interrupt, tested by Anobium but not implemented.
;wait while R_NOT_W = 1   'wait for completion of activities
SysWaitLoop10
	banksel	SSP1STAT
	btfsc	SSP1STAT,R_NOT_W
	goto	SysWaitLoop10
;Set SSPCON2.PEN On
	bsf	SSP1CON2,PEN
;HI2CWaitMSSP
	banksel	STATUS
	call	HI2CWAITMSSP
;Slave mode
;Else
	goto	ENDIF60
ELSE60_1
;Wait Until SSPSTAT.P = On
SysWaitLoop11
	banksel	SSP1STAT
	btfss	SSP1STAT,P
	goto	SysWaitLoop11
;End If
ENDIF60
	banksel	STATUS
	return

;********************************************************************************

HI2CWAITMSSP
;HI2CWaitMSSPTimeout = 0
	clrf	HI2CWAITMSSPTIMEOUT
HI2CWAITMSSPWAIT
;HI2CWaitMSSPTimeout++
	banksel	HI2CWAITMSSPTIMEOUT
	incf	HI2CWAITMSSPTIMEOUT,F
;if HI2CWaitMSSPTimeout < 255 then
	movlw	255
	subwf	HI2CWAITMSSPTIMEOUT,W
	btfsc	STATUS, C
	goto	ENDIF68
;'Support for SSP1IF
;if SSP1IF = 0 then goto HI2CWaitMSSPWait
	banksel	PIR3
	btfss	PIR3,SSP1IF
	goto	HI2CWAITMSSPWAIT
ENDIF69
;SSP1IF = 0
	bcf	PIR3,SSP1IF
;exit Sub
	banksel	STATUS
	return
;'Support for SSPIF
;if SSPIF = 0 then goto HI2CWaitMSSPWait
	banksel	PIR3
	btfss	PIR3,SSP1IF
	goto	HI2CWAITMSSPWAIT
ENDIF70
;SSPIF = 0
	bcf	PIR3,SSP1IF
;exit Sub
	banksel	STATUS
	return
;end if
ENDIF68
	return

;********************************************************************************

LCDCREATECHAR
;Store old location
;Set LCD_RS Off
	bcf	SYSLCDTEMP,1
;LCDLoc = LCDReadByte
	call	FN_LCDNORMALREADBYTE
	movf	LCDNORMALREADBYTE,W
	movwf	LCDLOC
;Set LCDLoc.7 On
	bsf	LCDLOC,7
;Select location
;Set LCD_RS Off
	bcf	SYSLCDTEMP,1
;LCDWriteByte (64 + LCDCharLoc * 8)
	movf	LCDCHARLOC,W
	movwf	SysBYTETempA
	movlw	8
	movwf	SysBYTETempB
	call	SysMultSub
	movlw	64
	addwf	SysBYTETempX,W
	movwf	LCDBYTE
	pagesel	LCDNORMALWRITEBYTE
	call	LCDNORMALWRITEBYTE
	pagesel	$
;wait 5 10us
	movlw	5
	movwf	SysWaitTemp10US
	call	Delay_10US
;Write char
;Set LCD_RS On
	bsf	SYSLCDTEMP,1
;For LCDTemp = 1 to 8
	clrf	LCDTEMP
SysForLoop2
	incf	LCDTEMP,F
;LCDWriteByte LCDCharData(LCDTemp)
	movf	LCDTEMP,W
	addwf	SysLCDCHARDATAHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysLCDCHARDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	LCDBYTE
	pagesel	LCDNORMALWRITEBYTE
	call	LCDNORMALWRITEBYTE
	pagesel	$
;wait 5 10us
	movlw	5
	movwf	SysWaitTemp10US
	call	Delay_10US
;Next
	movlw	8
	subwf	LCDTEMP,W
	btfss	STATUS, C
	goto	SysForLoop2
ENDIF44
SysForLoopEnd2
;Restore location
;Set LCD_RS Off
	bcf	SYSLCDTEMP,1
;LCDWriteByte (LCDLoc)
	movf	LCDLOC,W
	movwf	LCDBYTE
	pagesel	LCDNORMALWRITEBYTE
	call	LCDNORMALWRITEBYTE
	pagesel	$
;wait 5 10us
	movlw	5
	movwf	SysWaitTemp10US
	goto	Delay_10US

;********************************************************************************

FN_LCDNORMALREADBYTE
;set LCD_RW ON 'Read mode
	bsf	SYSLCDTEMP,0
;LCDReadByte = 0
	clrf	LCDNORMALREADBYTE
	return

;********************************************************************************

LCDWRITECHAR
;set LCD_RS on
	bsf	SYSLCDTEMP,1
;LCDWriteByte(LCDChar)
	movf	LCDCHAR,W
	movwf	LCDBYTE
	pagesel	LCDNORMALWRITEBYTE
	call	LCDNORMALWRITEBYTE
	pagesel	$
;wait 5 10us
	return

;********************************************************************************

LOCATE
;Set LCD_RS Off
	bcf	SYSLCDTEMP,1
;If LCDLine > 1 Then
	movf	LCDLINE,W
	sublw	1
	btfsc	STATUS, C
	goto	ENDIF19
;LCDLine = LCDLine - 2
	movlw	2
	subwf	LCDLINE,F
;LCDColumn = LCDColumn + LCD_WIDTH
	movlw	20
	addwf	LCDCOLUMN,F
;End If
ENDIF19
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
	pagesel	LCDNORMALWRITEBYTE
	call	LCDNORMALWRITEBYTE
	pagesel	$
;wait 5 10us 'test
	movlw	5
	movwf	SysWaitTemp10US
	goto	Delay_10US

;********************************************************************************

MONTHDAYS
	movlw	13
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableMONTHDAYS
	movwf	SysStringA
	movlw	(high TableMONTHDAYS) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableMONTHDAYS
	retlw	12
	retlw	31
	retlw	29
	retlw	31
	retlw	30
	retlw	31
	retlw	30
	retlw	31
	retlw	31
	retlw	30
	retlw	31
	retlw	30
	retlw	31

;********************************************************************************

PCF85X3_ENABLE
;dim DS_EnableState as byte alias DS_Sec
;do
SysDoLoop_S26
;HI2CReStart                                   ;generate a start signal
	call	HI2CRESTART
;HI2CSend(DS_AddrWrite)                        ;indicate a write
	movlw	162
	movwf	I2CBYTE
	call	HI2CSEND
;loop While HI2CAckPollState
	movf	hi2cackpollstate,F
	btfss	STATUS,Z
	goto	SysDoLoop_S26
SysDoLoop_E26
;HI2CSend(PCF85x3_CTRL_REG_1)                     ;indicate register
	clrf	I2CBYTE
	call	HI2CSEND
;HI2CReStart
	call	HI2CRESTART
;HI2CSend(DS_AddrRead)
	movlw	163
	movwf	I2CBYTE
	call	HI2CSEND
;HI2CReceive(DS_EnableState, NACK)                ;get theregiser
	clrf	HI2CGETACK
	pagesel	HI2CRECEIVE
	call	HI2CRECEIVE
	pagesel	$
	movf	I2CBYTE,W
	movwf	DS_ENABLESTATE
;if DS_Value.1 then
	btfss	DS_VALUE,1
	goto	ELSE16_1
;set DS_EnableState.PCF85x3_CTRL_REG_1_STOPBIT off              ;enables
	bcf	DS_ENABLESTATE,5
;else
	goto	ENDIF16
ELSE16_1
;set DS_EnableState.PCF85x3_CTRL_REG_1_STOPBIT on             ;disables
	bsf	DS_ENABLESTATE,5
;end if
ENDIF16
;HI2CReStart
	call	HI2CRESTART
;HI2CSend(DS_AddrWrite)
	movlw	162
	movwf	I2CBYTE
	call	HI2CSEND
;HI2CSend(PCF85x3_CTRL_REG_1)                     ;indicate register
	clrf	I2CBYTE
	call	HI2CSEND
;HI2CSend(DS_EnableState)                         ;now send updated value
	movf	DS_ENABLESTATE,W
	movwf	I2CBYTE
	call	HI2CSEND
;HI2CStop
	goto	HI2CSTOP

;********************************************************************************

PCF85X3_ENABLEALARM
;exit sub
	return
;dim DS_EnableState as byte alias DS_Sec
;'read register by register, read and set bit 7
;cls
	call	CLS
;PCF85x3_ReadRegister( PCF85x3_MINS_ALARM_REG, DS_EnableState )
	movlw	9
	movwf	DS_REG
	call	PCF85X3_READREGISTER
	movf	DS_VAL,W
	movwf	DS_ENABLESTATE
;print ByteToBin(DS_EnableState)
;DS_EnableState = BcdToDec(DS_EnableState)
;locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE
;print ByteToBin(DS_EnableState)
	movf	DS_ENABLESTATE,W
	movwf	BYTENUM
	pagesel	FN_BYTETOBIN
	call	FN_BYTETOBIN
	pagesel	$
	movlw	low BYTETOBIN
	movwf	SysPRINTDATAHandler
	movlw	high BYTETOBIN
	movwf	SysPRINTDATAHandler_H
	call	PRINT136
;DS_EnableState.7 =  DS_val.0
	bcf	DS_ENABLESTATE,7
	btfsc	DS_VAL,0
	bsf	DS_ENABLESTATE,7
ENDIF17
;locate 2,0
	movlw	2
	movwf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE
;print ByteToBin(DS_EnableState)
	movf	DS_ENABLESTATE,W
	movwf	BYTENUM
	pagesel	FN_BYTETOBIN
	call	FN_BYTETOBIN
	pagesel	$
	movlw	low BYTETOBIN
	movwf	SysPRINTDATAHandler
	movlw	high BYTETOBIN
	movwf	SysPRINTDATAHandler_H
	call	PRINT136
;PCF85x3_WriteRegister( PCF85x3_MINS_ALARM_REG, DS_EnableState)
	movlw	9
	movwf	DS_REG
	movf	DS_ENABLESTATE,W
	movwf	DS_VAL
	call	PCF85X3_WRITEREGISTER
;
;PCF85x3_ReadRegister( PCF85x3_HOURS_ALARM_REG, DS_EnableState )
;DS_EnableState = BcdToDec(DS_EnableState)
;DS_EnableState.7 =  DS_val.1
;PCF85x3_WriteRegister( PCF85x3_HOURS_ALARM_REG, DecToBcd(DS_EnableState) )
;
;PCF85x3_ReadRegister( PCF85x3_DAY_ALARM_REG, DS_EnableState )
;DS_EnableState = BcdToDec(DS_EnableState)
;DS_EnableState.7 =  DS_val.2
;PCF85x3_WriteRegister( PCF85x3_DAY_ALARM_REG, DecToBcd(DS_EnableState) )
;
;PCF85x3_ReadRegister( PCF85x3_WKDAY_ALARM_REG, DS_EnableState )
;DS_EnableState = BcdToDec(DS_EnableState)
;DS_EnableState.7 =  DS_val.3
;PCF85x3_WriteRegister( PCF85x3_WKDAY_ALARM_REG, DecToBcd(DS_EnableState) )
;wait 3 s
	movlw	3
	movwf	SysWaitTempS
	goto	Delay_S

;********************************************************************************

PCF85X3_ENABLECLOCKOUT
;dim DS_EnableState as byte alias DS_Sec
;do
SysDoLoop_S35
;HI2CReStart                                   ;generate a start signal
	call	HI2CRESTART
;HI2CSend(DS_AddrWrite)                        ;indicate a write
	movlw	162
	movwf	I2CBYTE
	call	HI2CSEND
;loop While HI2CAckPollState
	movf	hi2cackpollstate,F
	btfss	STATUS,Z
	goto	SysDoLoop_S35
SysDoLoop_E35
;HI2CSend(PCF85x3_CLKOUT_CTRL_REG)                     ;indicate register
	movlw	13
	movwf	I2CBYTE
	call	HI2CSEND
;HI2CReStart
	call	HI2CRESTART
;HI2CSend(DS_AddrRead)
	movlw	163
	movwf	I2CBYTE
	call	HI2CSEND
;HI2CReceive(DS_EnableState, NACK)                ;get theregiser
	clrf	HI2CGETACK
	pagesel	HI2CRECEIVE
	call	HI2CRECEIVE
	pagesel	$
	movf	I2CBYTE,W
	movwf	DS_ENABLESTATE
;if DS_Value.1 then
	btfss	DS_VALUE,1
	goto	ELSE18_1
;set DS_EnableState.PCF85x3_CLKOUT_CTRL_REG_ENABLEBIT on              ;enables
	bsf	DS_ENABLESTATE,7
;else
	goto	ENDIF18
ELSE18_1
;set DS_EnableState.PCF85x3_CLKOUT_CTRL_REG_ENABLEBIT off             ;disables
	bcf	DS_ENABLESTATE,7
;end if
ENDIF18
;HI2CReStart
	call	HI2CRESTART
;HI2CSend(DS_AddrWrite)
	movlw	162
	movwf	I2CBYTE
	call	HI2CSEND
;HI2CSend(PCF85x3_CLKOUT_CTRL_REG)                     ;indicate register
	movlw	13
	movwf	I2CBYTE
	call	HI2CSEND
;HI2CSend(DS_EnableState)                         ;now send updated value
	movf	DS_ENABLESTATE,W
	movwf	I2CBYTE
	call	HI2CSEND
;HI2CStop
	goto	HI2CSTOP

;********************************************************************************

PCF85X3_ENABLECLOCKOUTFREQUENCY
;use DS_Sec as a temp variable
;do
SysDoLoop_S36
;HI2CReStart                          ;generate a start signal
	call	HI2CRESTART
;HI2CSend(DS_AddrWrite)                     ;inidcate a write
	movlw	162
	movwf	I2CBYTE
	call	HI2CSEND
;loop While HI2CAckPollState
	movf	hi2cackpollstate,F
	btfss	STATUS,Z
	goto	SysDoLoop_S36
SysDoLoop_E36
;HI2CSend(PCF85x3_CLKOUT_CTRL_REG)                     ;indicate register CLKOUT_CTRL_REG
	movlw	13
	movwf	I2CBYTE
	call	HI2CSEND
;HI2CReStart
	call	HI2CRESTART
;HI2CSend(DS_AddrRead)
	movlw	163
	movwf	I2CBYTE
	call	HI2CSEND
;HI2CReceive(DS_Sec, NACK)       ;get the current
	clrf	HI2CGETACK
	pagesel	HI2CRECEIVE
	call	HI2CRECEIVE
	pagesel	$
	movf	I2CBYTE,W
	movwf	DS_SEC
;DS_Sec = DS_Sec and 0xFC        ;mask the lower two bits
	movlw	252
	andwf	DS_SEC,F
;DS_Sec = DS_Sec or DS_Value     ;or the lower two bits
	movf	DS_SEC,W
	iorwf	DS_VALUE,W
	movwf	DS_SEC
;HI2CReStart
	call	HI2CRESTART
;HI2CSend(DS_AddrWrite)
	movlw	162
	movwf	I2CBYTE
	call	HI2CSEND
;HI2CSend(PCF85x3_CLKOUT_CTRL_REG)                     ;indicate register
	movlw	13
	movwf	I2CBYTE
	call	HI2CSEND
;HI2CSend(DS_Sec)                ;now send updated value
	movf	DS_SEC,W
	movwf	I2CBYTE
	call	HI2CSEND
;HI2CStop
	goto	HI2CSTOP

;********************************************************************************

PCF85X3_READREGISTER
;do
SysDoLoop_S31
;HI2CReStart                          ;generate a start signal
	call	HI2CRESTART
;HI2CSend(DS_AddrWrite)                     ;inidcate a write
	movlw	162
	movwf	I2CBYTE
	call	HI2CSEND
;loop While HI2CAckPollState
	movf	hi2cackpollstate,F
	btfss	STATUS,Z
	goto	SysDoLoop_S31
SysDoLoop_E31
;HI2CSend( DS_reg )   ;begin
	movf	DS_REG,W
	movwf	I2CBYTE
	call	HI2CSEND
;HI2CReStart
	call	HI2CRESTART
;HI2CSend(DS_AddrRead)
	movlw	163
	movwf	I2CBYTE
	call	HI2CSEND
;HI2CReceive(DS_val, NACK)
	clrf	HI2CGETACK
	pagesel	HI2CRECEIVE
	call	HI2CRECEIVE
	pagesel	$
	movf	I2CBYTE,W
	movwf	DS_VAL
;HI2CStop
	goto	HI2CSTOP

;********************************************************************************

PCF85X3_READTIME
;do
SysDoLoop_S32
;HI2CReStart                          ;generate a start signal
	call	HI2CRESTART
;HI2CSend(DS_AddrWrite)                     ;inidcate a write
	movlw	162
	movwf	I2CBYTE
	call	HI2CSEND
;loop While HI2CAckPollState
	movf	hi2cackpollstate,F
	btfss	STATUS,Z
	goto	SysDoLoop_S32
SysDoLoop_E32
;HI2CSend( PCF85x3_VL_SEC_REG )                      ;begin
	movlw	2
	movwf	I2CBYTE
	call	HI2CSEND
;HI2CReStart
	call	HI2CRESTART
;HI2CSend(DS_AddrRead)
	movlw	163
	movwf	I2CBYTE
	call	HI2CSEND
;HI2CReceive(DS_Sec)              ;get seconds
	movlw	1
	movwf	HI2CGETACK
	pagesel	HI2CRECEIVE
	call	HI2CRECEIVE
	pagesel	$
	movf	I2CBYTE,W
	movwf	DS_SEC
;DS_Sec = BcdToDec(DS_Sec & PCF85x3_SEC_REG_MASK ) ;strip off VL bit
	movlw	127
	andwf	DS_SEC,W
	movwf	VA
	call	FN_BCDTODEC
	movf	BCDTODEC,W
	movwf	DS_SEC
;HI2CReceive(DS_Min)              ;get minutes
	movlw	1
	movwf	HI2CGETACK
	pagesel	HI2CRECEIVE
	call	HI2CRECEIVE
	pagesel	$
	movf	I2CBYTE,W
	movwf	DS_MIN
;DS_Min = BcdToDec(DS_Min  & PCF85x3_MINS_REG_MASK)       ;bit 7 is always 0
	movlw	127
	andwf	DS_MIN,W
	movwf	VA
	call	FN_BCDTODEC
	movf	BCDTODEC,W
	movwf	DS_MIN
;HI2CReceive(DS_Hour, NACK)             ;get hours
	clrf	HI2CGETACK
	pagesel	HI2CRECEIVE
	call	HI2CRECEIVE
	pagesel	$
	movf	I2CBYTE,W
	movwf	DS_HOUR
;DS_Hour = BcdToDec(DS_Hour & PCF85x3_HOURS_REG_MASK )
	movlw	63
	andwf	DS_HOUR,W
	movwf	VA
	call	FN_BCDTODEC
	movf	BCDTODEC,W
	movwf	DS_HOUR
;HI2CStop
	goto	HI2CSTOP

;********************************************************************************

FN_PCF85X3_READVL
;do
SysDoLoop_S34
;HI2CReStart                          ;generate a start signal
	call	HI2CRESTART
;HI2CSend(DS_AddrWrite)                     ;inidcate a write
	movlw	162
	movwf	I2CBYTE
	call	HI2CSEND
;loop While HI2CAckPollState
	movf	hi2cackpollstate,F
	btfss	STATUS,Z
	goto	SysDoLoop_S34
SysDoLoop_E34
;HI2CSend( PCF85x3_VL_SEC_REG )                      ;begin
	movlw	2
	movwf	I2CBYTE
	call	HI2CSEND
;HI2CReStart
	call	HI2CRESTART
;HI2CSend(DS_AddrRead)
	movlw	163
	movwf	I2CBYTE
	call	HI2CSEND
;HI2CReceive(DS_Sec, NACK)              ;get seconds
	clrf	HI2CGETACK
	pagesel	HI2CRECEIVE
	call	HI2CRECEIVE
	pagesel	$
	movf	I2CBYTE,W
	movwf	DS_SEC
;PCF85x3_ReadVL = BcdToDec(DS_Sec & PCF85x3_VL_REG_MASK ) ;strip off VL bit
	movlw	128
	andwf	DS_SEC,W
	movwf	VA
	call	FN_BCDTODEC
	movf	BCDTODEC,W
	movwf	PCF85X3_READVL
;HI2CStop
	goto	HI2CSTOP

;********************************************************************************

;Overloaded signature: BYTE:BYTE:
PCF85X3_SETALARM18
;Set alarm: hours, minutes
;do
SysDoLoop_S29
;HI2CReStart                          ;generate a start signal
	call	HI2CRESTART
;HI2CSend(DS_AddrWrite)                     ;inidcate a write
	movlw	162
	movwf	I2CBYTE
	call	HI2CSEND
;loop While HI2CAckPollState
	movf	hi2cackpollstate,F
	btfss	STATUS,Z
	goto	SysDoLoop_S29
SysDoLoop_E29
;HI2CSend( PCF85x3_MINS_ALARM_REG )   ;begin
	movlw	9
	movwf	I2CBYTE
	call	HI2CSEND
;HI2CSend(DecToBcd(DS_Min))       ;consecutive values
	movf	DS_MIN,W
	movwf	VA
	call	FN_DECTOBCD
	movf	DECTOBCD,W
	movwf	I2CBYTE
	call	HI2CSEND
;HI2CSend(DecToBcd(DS_Hour))
	movf	DS_HOUR,W
	movwf	VA
	call	FN_DECTOBCD
	movf	DECTOBCD,W
	movwf	I2CBYTE
	call	HI2CSEND
;HI2CStop
	goto	HI2CSTOP

;********************************************************************************

PCF85X3_WRITEREGISTER
;Set value - should be in BCD
;do
SysDoLoop_S30
;HI2CReStart                          ;generate a start signal
	call	HI2CRESTART
;HI2CSend(DS_AddrWrite)                     ;inidcate a write
	movlw	162
	movwf	I2CBYTE
	call	HI2CSEND
;loop While HI2CAckPollState
	movf	hi2cackpollstate,F
	btfss	STATUS,Z
	goto	SysDoLoop_S30
SysDoLoop_E30
;HI2CSend( DS_reg )   ;begin
	movf	DS_REG,W
	movwf	I2CBYTE
	call	HI2CSEND
;HI2CSend( DS_val )   ;value
	movf	DS_VAL,W
	movwf	I2CBYTE
	call	HI2CSEND
;HI2CStop
	goto	HI2CSTOP

;********************************************************************************

;Overloaded signature: STRING:
PRINT136
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
ENDIF20
;Set LCD_RS On
	bsf	SYSLCDTEMP,1
;Write Data
;For SysPrintTemp = 1 To PrintLen
	clrf	SYSPRINTTEMP
	movlw	1
	subwf	PRINTLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd1
ENDIF21
SysForLoop1
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
	pagesel	LCDNORMALWRITEBYTE
	call	LCDNORMALWRITEBYTE
	pagesel	$
;Next
	movf	PRINTLEN,W
	subwf	SYSPRINTTEMP,W
	btfss	STATUS, C
	goto	SysForLoop1
ENDIF22
SysForLoopEnd1
	return

;********************************************************************************

SETDATE
;***** Date
;cls
	call	CLS
;Print "Set Date:"
	movlw	low StringTable24
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable24) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT136
;locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE
;printDate
	pagesel	PRINTDATE
	call	PRINTDATE
	pagesel	$
;readTable monthDays, month, daysMax
	movf	MONTH,W
	movwf	SYSSTRINGA
	call	MONTHDAYS
	movwf	DAYSMAX
;do
SysDoLoop_S20
;do while modeBut = pressed      ;Mode button held
SysDoLoop_S21
	btfss	PORTB,1
	goto	SysDoLoop_E21
;date++                        ;increment while pressed
	incf	DATE,F
;if date > daysMax then        ;stay within legal days
	movf	DATE,W
	subwf	DAYSMAX,W
	btfsc	STATUS, C
	goto	ENDIF14
;date = 1
	movlw	1
	movwf	DATE
;end if
ENDIF14
;locate 1,0                    ;Print updated display
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE
;printDate
	pagesel	PRINTDATE
	call	PRINTDATE
	pagesel	$
;wait while modeBut = pressed  ;wait for repeatt
SysWaitLoop7
	btfsc	PORTB,1
	goto	SysWaitLoop7
;changed = true                ;a change was made
	bsf	SYSBITVAR0,0
;loop
	goto	SysDoLoop_S21
SysDoLoop_E21
;wait debounce
	movlw	50
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;loop while setBut <> pressed
	btfss	PORTB,0
	goto	SysDoLoop_S20
SysDoLoop_E20
;do while setBut = pressed         ;wait for Set release
SysDoLoop_S22
	btfss	PORTB,0
	goto	SysDoLoop_E22
;wait debounce
	movlw	50
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;loop
	goto	SysDoLoop_S22
SysDoLoop_E22
	return

;********************************************************************************

SETMONTH
;***** Month
;cls
	call	CLS
;Print "Set Month:"
	movlw	low StringTable23
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable23) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT136
;locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE
;printDate
	pagesel	PRINTDATE
	call	PRINTDATE
	pagesel	$
;do
SysDoLoop_S17
;do while modeBut = pressed      ;Mode button held
SysDoLoop_S18
	btfss	PORTB,1
	goto	SysDoLoop_E18
;month++                       ;increment while pressed
	incf	MONTH,F
;if month > 12 then
	movf	MONTH,W
	sublw	12
	btfsc	STATUS, C
	goto	ENDIF13
;month = 1
	movlw	1
	movwf	MONTH
;end if
ENDIF13
;locate 1,0                    ;Print updated display
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE
;printDate
	pagesel	PRINTDATE
	call	PRINTDATE
	pagesel	$
;wait while modeBut = pressed  ;wait for repeat
SysWaitLoop6
	btfsc	PORTB,1
	goto	SysWaitLoop6
;changed = true                ;a change was made
	bsf	SYSBITVAR0,0
;loop
	goto	SysDoLoop_S18
SysDoLoop_E18
;wait debounce
	movlw	50
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;loop while setBut <> pressed      ;Set moves you on
	btfss	PORTB,0
	goto	SysDoLoop_S17
SysDoLoop_E17
;readTable monthDays, month, daysMax
	movf	MONTH,W
	movwf	SYSSTRINGA
	call	MONTHDAYS
	movwf	DAYSMAX
;do while setBut = pressed         ;wait for Set release
SysDoLoop_S19
	btfss	PORTB,0
	goto	SysDoLoop_E19
;wait debounce
	movlw	50
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;loop
	goto	SysDoLoop_S19
SysDoLoop_E19
	return

;********************************************************************************

SETYEAR
;***** Year
;cls
	call	CLS
;Print "Set Year:"
	movlw	low StringTable25
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable25) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT136
;locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE
;printDate
	pagesel	PRINTDATE
	call	PRINTDATE
	pagesel	$
;do
SysDoLoop_S23
;do while modeBut = pressed      ;Mode button held
SysDoLoop_S24
	btfss	PORTB,1
	goto	SysDoLoop_E24
;year++                        ;increment while pressed
	incf	YEAR,F
;if year > 99 then             ;this millennium only
	movf	YEAR,W
	sublw	99
	btfss	STATUS, C
;year = 0
	clrf	YEAR
;end if
ENDIF15
;locate 1,0                    ;Print updated display
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE
;printDate
	pagesel	PRINTDATE
	call	PRINTDATE
	pagesel	$
;wait while modeBut = pressed  ;wait for repeat
SysWaitLoop8
	btfsc	PORTB,1
	goto	SysWaitLoop8
;changed = true                ;a change was made
	bsf	SYSBITVAR0,0
;loop
	goto	SysDoLoop_S24
SysDoLoop_E24
;wait debounce
	movlw	50
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;loop while setBut <> pressed
	btfss	PORTB,0
	goto	SysDoLoop_S23
SysDoLoop_E23
;do while setBut = pressed         ;wait for Set release
SysDoLoop_S25
	btfss	PORTB,0
	goto	SysDoLoop_E25
;wait debounce
	movlw	50
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;loop
	goto	SysDoLoop_S25
SysDoLoop_E25
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

UPDATEDISP
;for best efficiency, date is only updated once a day
;PCF85x3_ReadTime(hour, min, sec)
	call	PCF85X3_READTIME
	movf	DS_HOUR,W
	movwf	HOUR
	movf	DS_MIN,W
	movwf	MIN
	movf	DS_SEC,W
	movwf	SEC
;if oldsec <> sec then
	subwf	OLDSEC,W
	btfsc	STATUS, Z
	goto	ENDIF3
;if sec = 0 then                             ;time to update
	movf	SEC,F
	btfss	STATUS, Z
	goto	ENDIF4
;PCF85x3_ReadDate(DOW, date, month, year)
	pagesel	PCF85X3_READDATE
	call	PCF85X3_READDATE
	pagesel	$
	movf	DS_DOW,W
	movwf	DOW
	movf	DS_DATE,W
	movwf	DATE
	movf	DS_MONTH,W
	movwf	MONTH
	movf	DS_YEAR,W
	movwf	YEAR
;Show clock integrity
;locate 0, 19
	clrf	LCDLINE
	movlw	19
	movwf	LCDCOLUMN
	call	LOCATE
;If PCF85x3_ReadVL is 0 then the clock integrity is good... show a happy face
;if PCF85x3_ReadVL = 0 then
	call	FN_PCF85X3_READVL
	movf	PCF85X3_READVL,F
	btfss	STATUS, Z
	goto	ELSE5_1
;LCDWriteChar 0
	clrf	LCDCHAR
	call	LCDWRITECHAR
;else
	goto	ENDIF5
ELSE5_1
;LCDWriteChar 1
	movlw	1
	movwf	LCDCHAR
	call	LCDWRITECHAR
;end if
ENDIF5
;end if
ENDIF4
;locate 0,0                        ;home the cursor
	clrf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE
;printTime                         ;show time
	pagesel	PRINTTIME
	call	PRINTTIME
	pagesel	$
;locate 1,0                        ;show the date
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE
;printDate
	pagesel	PRINTDATE
	call	PRINTDATE
	pagesel	$
;oldsec =  sec
	movf	SEC,W
	movwf	OLDSEC
;end if
ENDIF3
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
