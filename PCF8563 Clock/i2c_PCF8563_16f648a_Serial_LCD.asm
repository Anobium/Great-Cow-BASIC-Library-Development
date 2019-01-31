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
BCDTODEC	EQU	32
CHARARRAY	EQU	294
DATE	EQU	33
DAYSMAX	EQU	34
DECTOBCD	EQU	35
DELAYTEMP	EQU	112
DELAYTEMP2	EQU	113
DOW	EQU	36
DS_DATE	EQU	37
DS_DOW	EQU	38
DS_HOUR	EQU	39
DS_MIN	EQU	40
DS_MONTH	EQU	41
DS_REG	EQU	42
DS_SEC	EQU	43
DS_VAL	EQU	44
DS_VALUE	EQU	45
DS_YEAR	EQU	46
HOUR	EQU	47
I2CACK	EQU	48
I2CACKPOLLSTATE	EQU	49
I2CBYTE	EQU	50
I2CMATCH	EQU	51
I2CSTATE	EQU	52
LCD3_RSSTATE	EQU	53
LCDBYTE	EQU	54
LCDCHAR	EQU	55
LCDCHARLOC	EQU	56
LCDCOLUMN	EQU	57
LCDCRSR	EQU	58
LCDLINE	EQU	59
LCDTEMP	EQU	60
LCDVALUE	EQU	61
LCDVALUETEMP	EQU	62
LCD_STATE	EQU	63
LEFTPAD	EQU	345
MIN	EQU	64
MONTH	EQU	65
MYREG	EQU	66
OLDSEC	EQU	67
PCF85X3_READVL	EQU	68
PRINTLEN	EQU	69
SEC	EQU	70
STR	EQU	288
STRINGPOINTER	EQU	71
SYSARRAYTEMP1	EQU	72
SYSARRAYTEMP2	EQU	73
SYSBITVAR0	EQU	74
SYSBYTETEMPA	EQU	117
SYSBYTETEMPB	EQU	121
SYSBYTETEMPX	EQU	112
SYSCALCTEMPA	EQU	117
SYSCALCTEMPB	EQU	121
SYSCALCTEMPX	EQU	112
SYSCALCTEMPX_H	EQU	113
SYSCHARCOUNT	EQU	75
SYSDIVLOOP	EQU	116
SYSDIVMULTA	EQU	119
SYSDIVMULTA_H	EQU	120
SYSDIVMULTB	EQU	123
SYSDIVMULTB_H	EQU	124
SYSDIVMULTX	EQU	114
SYSDIVMULTX_H	EQU	115
SYSLCDCHARDATAHANDLER	EQU	76
SYSLCDCHARDATAHANDLER_H	EQU	77
SYSPRINTDATAHANDLER	EQU	78
SYSPRINTDATAHANDLER_H	EQU	79
SYSPRINTTEMP	EQU	80
SYSREPEATTEMP1	EQU	81
SYSREPEATTEMP2	EQU	82
SYSREPEATTEMP3	EQU	83
SYSSTRDATA	EQU	84
SYSSTRINGA	EQU	119
SYSSTRINGA_H	EQU	120
SYSSTRINGB	EQU	114
SYSSTRINGB_H	EQU	115
SYSSTRINGLENGTH	EQU	118
SYSSTRINGPARAM1	EQU	324
SYSSTRINGPARAM2	EQU	303
SYSSTRINGPARAM3	EQU	219
SYSSTRINGPARAM4	EQU	198
SYSSTRINGPARAM5	EQU	177
SYSSTRINGTEMP	EQU	85
SYSSTRLEN	EQU	86
SYSSYSINSTRING2HANDLER	EQU	87
SYSSYSINSTRING2HANDLER_H	EQU	88
SYSSYSINSTRINGHANDLER	EQU	89
SYSSYSINSTRINGHANDLER_H	EQU	90
SYSTEMP1	EQU	91
SYSTEMP1_H	EQU	92
SYSTEMP2	EQU	93
SYSTEMP3	EQU	94
SYSVALTEMP	EQU	95
SYSVALTEMP_H	EQU	96
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
VA	EQU	97
YEAR	EQU	98

;********************************************************************************

;Alias variables
SYSCHARARRAY_1	EQU	295
SYSCHARARRAY_2	EQU	296
SYSCHARARRAY_3	EQU	297
SYSCHARARRAY_4	EQU	298
SYSCHARARRAY_5	EQU	299
SYSCHARARRAY_6	EQU	300
SYSCHARARRAY_7	EQU	301
SYSCHARARRAY_8	EQU	302
SYSLEFTPAD_0	EQU	345
SYSSTR_0	EQU	288
DS_ENABLESTATE	EQU	43

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
	call	INITI2C
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
;'':
;'':    This has two modes US date and UK date style.
;'':    Change ''':clocktype''': to 0 for US and 1 for UK
;'':
;'':    To set a new date and time, press the Set button
;'':    which will take you consecutively to Month, Day, Year,
;'':    Day of the Week, Hour, Minute and Second. Within each of
;'':    these, press Mode to cycle through the possible values.
;'':    You may hold the Mode button to increment automatically,
;'':    or press momentarily for a single increment.
;'':     Time is always set in 24-hour clock format.
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
;Define I2C settings - CHANGE PORTS
;#define I2C_MODE Master
;#define I2C_DATA PORTa.4
;#define I2C_CLOCK PORTa.3
;#define I2C_DISABLE_INTERRUPTS ON
;; ----- Configuration
;#chip 16f15376, 32
;#option explicit
;
;'Generated by PIC PPS Tool for Great Cow Basic
;'PPS Tool version: 0.0.5.22
;'PinManager data: Not available (3)
;'Generated for 16F15376
;'
;'Template comment at the start of the config file
;'
;#startup InitPPS, 85
;#define PPSToolPart 16F15376
;
;Sub InitPPS
;
;'Module: MSSP1
;RB5PPS = 0x0016    'SDA1 > RB5
;SSP1DATPPS = 0x000D    'RB5 > SDA1 (bi-directional)
;RB7PPS = 0x0015    'SCL1 > RB7
;SSP1CLKPPS = 0x000F    'RB7 > SCL1 (bi-directional)
;'Module: EUSART1
;RB6PPS = 0x000F    'TX1 > RB6
;End Sub
;'Template comment at the end of the config file
;
;#define DS_AddrWrite 0xA2
;#define DS_AddrRead  0xA3
;
;
;'''Set up LCD
;#define LCD_IO 10
;#define LCD_I2C_Address_1 0x4C ; default to 0x4E
;'You may need to use SLOW or MEDIUM if your LCD is a slower device.
;#define LCD_SPEED FAST
;'You may need to invert these states. Dependent of LCD I2C adapter.
;#define LCD_Backlight_On_State  1
;#define LCD_Backlight_Off_State 0
;
;; ----- Define Hardware settings for hwi2c
;' Define I2C settings - CHANGE PORTS if required for your specific device.
;#define hi2c_BAUD_RATE 100
;#define hi2c_DATA PORTb.5
;#define hi2c_CLOCK PORTb.7
;'Initialise I2C Master
;'I2C pins need to be input for SSP2 module
;Dir hi2c_DATA in
;Dir hi2c_CLOCK in
;----- Define Clock and the input switch hardware settings
;#define setBut      portb.1         ;Set pushbutton
;#define modeBut     portb.2         ;Mode pushbutton
;dir setBut in
	banksel	TRISB
	bsf	TRISB,1
;dir modeBut in
	bsf	TRISB,2
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
	banksel	OLDSEC
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
	movlw	low SYSSTRINGPARAM1
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM1
	movwf	SysStringB_H
	movlw	low StringTable2
	movwf	SysStringA
	movlw	high StringTable2
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	call	PRINT138
;locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;Print "Great Cow Basic 2019"
	movlw	low SYSSTRINGPARAM1
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM1
	movwf	SysStringB_H
	movlw	low StringTable3
	movwf	SysStringA
	movlw	high StringTable3
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	call	PRINT138
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
;PCF85x3_Enable
	movlw	255
	movwf	DS_VALUE
	pagesel	PCF85X3_ENABLE
	call	PCF85X3_ENABLE
	pagesel	$
;or, set the clock this way
;PCF85x3_SetClock(        20,         17,        0,         2,          29,        1,          19)
;set the ClockOut by enabling like this
;PCF85x3_EnableClockout ( true )
;set the ClockOut frequency like this, using the following Constants
;PCF85x3_CLKOUT_CTRL_REG_32_768_kHz
;PCF85x3_CLKOUT_CTRL_REG_1_024_kHz
;PCF85x3_CLKOUT_CTRL_REG_32_Hz
;PCF85x3_CLKOUT_CTRL_REG_1_Hz
;PCF85x3_EnableClockoutFrequency ( PCF85x3_CLKOUT_CTRL_REG_1_Hz )
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
	pagesel	PCF85X3_SETALARM17
	call	PCF85X3_SETALARM17
	pagesel	$
;PCF85x3_EnableAlarm ( PCF85x3_Alarm2Assertion_MinuteHour )
;Main body of program commences here.
;PCF85x3_ReadDate(DOW, date, month, year)   ;get initial date
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
;do
SysDoLoop_S1
;updateDisp                        ;show time and date
	pagesel	UPDATEDISP
	call	UPDATEDISP
	pagesel	$
;if setBut = pressed then
	btfss	PORTB,1
	goto	ENDIF1
;changeSetting                   ;change time and date
	call	CHANGESETTING
	pagesel	$
;end if
ENDIF1
;if modeBut = pressed then
	btfsc	PORTB,2
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

CHANGESETTING
;changed = false                   ;assume no change will be made
	bcf	SYSBITVAR0,0
;do while setBut = pressed         ;wait for Set release
SysDoLoop_S2
	btfss	PORTB,1
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
	btfsc	PORTB,1
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	movwf	SysTemp1
	clrf	SysByteTempX
	btfsc	PORTB,2
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
	movlw	low SYSSTRINGPARAM2
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM2
	movwf	SysStringB_H
	movlw	low StringTable17
	movwf	SysStringA
	movlw	high StringTable17
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H
	call	PRINT138
;locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;printDate
	call	PRINTDATE
;do
SysDoLoop_S3
;do while modeBut = pressed      ;Mode button held
SysDoLoop_S4
	btfss	PORTB,2
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
;wait while modeBut = pressed  ;wait for repeat
SysWaitLoop2
	btfsc	PORTB,2
	goto	SysWaitLoop2
;changed = true                ;a change was made
	bsf	SYSBITVAR0,0
;loop
	goto	SysDoLoop_S4
SysDoLoop_E4
;loop while setBut <> pressed
	btfss	PORTB,1
	goto	SysDoLoop_S3
SysDoLoop_E3
;do while setBut = pressed         ;wait for Set release
SysDoLoop_S5
	btfss	PORTB,1
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
	movlw	low SYSSTRINGPARAM2
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM2
	movwf	SysStringB_H
	movlw	low StringTable18
	movwf	SysStringA
	movlw	high StringTable18
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H
	call	PRINT138
;locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;printTime
	call	PRINTTIME
;do
SysDoLoop_S6
;do while modeBut = pressed      ;Mode button held
SysDoLoop_S7
	btfss	PORTB,2
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
;wait while modeBut = pressed  ;wait for repeat
SysWaitLoop3
	btfsc	PORTB,2
	goto	SysWaitLoop3
;changed = true                ;a change was made
	bsf	SYSBITVAR0,0
;loop
	goto	SysDoLoop_S7
SysDoLoop_E7
;loop while setBut <> pressed
	btfss	PORTB,1
	goto	SysDoLoop_S6
SysDoLoop_E6
;do while setBut = pressed         ;wait for Set release
SysDoLoop_S8
	btfss	PORTB,1
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
	movlw	low SYSSTRINGPARAM2
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM2
	movwf	SysStringB_H
	movlw	low StringTable19
	movwf	SysStringA
	movlw	high StringTable19
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H
	call	PRINT138
;locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;printTime
	call	PRINTTIME
;do
SysDoLoop_S9
;do while modeBut = pressed      ;Mode button held
SysDoLoop_S10
	btfss	PORTB,2
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
;wait while modeBut = pressed  ;wait for repeat
SysWaitLoop4
	btfsc	PORTB,2
	goto	SysWaitLoop4
;changed = true                ;a change was made
	bsf	SYSBITVAR0,0
;loop
	goto	SysDoLoop_S10
SysDoLoop_E10
;loop while setBut <> pressed
	btfss	PORTB,1
	goto	SysDoLoop_S9
SysDoLoop_E9
;do while setBut = pressed         ;wait for Set release
SysDoLoop_S11
	btfss	PORTB,1
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
	movlw	low SYSSTRINGPARAM2
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM2
	movwf	SysStringB_H
	movlw	low StringTable20
	movwf	SysStringA
	movlw	high StringTable20
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H
	call	PRINT138
;locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;printTime
	call	PRINTTIME
;do
SysDoLoop_S12
;do while modeBut = pressed      ;Mode button held
SysDoLoop_S13
	btfss	PORTB,2
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
;wait while modeBut = pressed  ;wait for repeat
SysWaitLoop5
	btfsc	PORTB,2
	goto	SysWaitLoop5
;changed = true                ;a change was made
	bsf	SYSBITVAR0,0
;loop
	goto	SysDoLoop_S13
SysDoLoop_E13
;loop while setBut <> pressed
	btfss	PORTB,1
	goto	SysDoLoop_S12
SysDoLoop_E12
;do while setBut = pressed         ;wait for Set release
SysDoLoop_S14
	btfss	PORTB,1
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
	movlw	low SYSSTRINGPARAM2
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM2
	movwf	SysStringB_H
	movlw	low StringTable21
	movwf	SysStringA
	movlw	high StringTable21
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H
	call	PRINT138
;locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;Print "Mode to revert"
	movlw	low SYSSTRINGPARAM2
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM2
	movwf	SysStringB_H
	movlw	low StringTable22
	movwf	SysStringA
	movlw	high StringTable22
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H
	call	PRINT138
;do while (setBut <> pressed)          ;wait for the Set button
SysDoLoop_S15
	btfsc	PORTB,1
	goto	SysDoLoop_E15
;wait debounce
	movlw	50
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;if ModeBut = pressed then
	btfss	PORTB,2
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
	pagesel	PCF85X3_SETCLOCK
	call	PCF85X3_SETCLOCK
	pagesel	$
;end if
ENDIF11
;do while (setBut = pressed)       ;wait for Set release
SysDoLoop_S16
	btfss	PORTB,1
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

I2CSEND
;I2C_CLOCK_LOW                 'begin with SCL=0
	banksel	TRISA
	bcf	TRISA,3
	banksel	PORTA
	bcf	PORTA,3
;wait I2C_END_DELAY            'let port settle
	nop
;repeat 8                      '8 data bits
	movlw	8
	movwf	SysRepeatTemp2
SysRepeatLoop2
;if I2CByte.7 = ON then      'put most significant bit on SDA line
	btfss	I2CBYTE,7
	goto	ELSE45_1
;I2C_DATA_HIGH
	banksel	TRISA
	bsf	TRISA,4
;else
	goto	ENDIF45
ELSE45_1
;I2C_DATA_LOW
	banksel	TRISA
	bcf	TRISA,4
	banksel	PORTA
	bcf	PORTA,4
;end if
ENDIF45
;rotate I2CByte left         'shift in bit for the next time
	banksel	I2CBYTE
	rlf	I2CBYTE,F
;I2C_CLOCK_HIGH              'now clock it in
	banksel	TRISA
	bsf	TRISA,3
;wait while I2C_CLOCK = OFF    'permit clock stretching here
SysWaitLoop9
	banksel	PORTA
	btfss	PORTA,3
	goto	SysWaitLoop9
;wait I2C_CLOCK_DELAY        'clock pulse width given here
	nop
;I2C_CLOCK_LOW               'done clocking that bit
	banksel	TRISA
	bcf	TRISA,3
	banksel	PORTA
	bcf	PORTA,3
;wait I2C_END_DELAY          'time between clock pulses
	nop
;end repeat                    'then do next bit
	decfsz	SysRepeatTemp2,F
	goto	SysRepeatLoop2
SysRepeatLoopEnd2
;wait I2C_BIT_DELAY            'pad timing just a little
	goto	$+1
;I2C_DATA_HIGH                 'idle SDA to let Slave respond
	banksel	TRISA
	bsf	TRISA,4
;wait I2C_END_DELAY            'let SDA port line settle
	nop
;I2C_CLOCK_HIGH                'clock for the ACK/NAK bit
	bsf	TRISA,3
;wait while I2C_CLOCK = OFF    'permit clock stretching here
SysWaitLoop10
	banksel	PORTA
	btfss	PORTA,3
	goto	SysWaitLoop10
;restored 'I2CSendState' variable for backwards compatibility
;if I2C_DATA then              'read 9th bit in from Slave
	btfss	PORTA,4
	goto	ELSE46_1
;I2CAck = FALSE              'return a NAK to the program
	clrf	I2CACK
;I2CSendState =  FALSE        'state of target device with respect. Retained for backwards compatibility
	clrf	I2CACKPOLLSTATE
;else
	goto	ENDIF46
ELSE46_1
;I2CAck = TRUE               'else, return an ACK to the program
	movlw	255
	movwf	I2CACK
;I2CSendState =  TRUE        'state of target device with respect. Retained for backwards compatibility
	movlw	255
	movwf	I2CACKPOLLSTATE
;end if
ENDIF46
;I2C_CLOCK_LOW                 'may be more bytes to clock out
	banksel	TRISA
	bcf	TRISA,3
	banksel	PORTA
	bcf	PORTA,3
;wait I2C_END_DELAY            'so keep idling both
	nop
;I2C_DATA_LOW                  'SCL and SDA low
	banksel	TRISA
	bcf	TRISA,4
	banksel	PORTA
	bcf	PORTA,4
;wait I2C_BIT_DELAY            'wait the usual bit length
	goto	$+1
	return

;********************************************************************************

INITI2C
;Moved to prevent variable defintion when not required
;dim I2COldState, I2CState, I2CMatch, I2CTemp as byte
;dim I2CCount alias I2CState
;I2C_DATA_HIGH                   'release SDA (open drain floats high)
	banksel	TRISA
	bsf	TRISA,4
;I2C_CLOCK_HIGH                  'release SCL (open drain floats high)
	bsf	TRISA,3
;I2CMatch = FALSE                'address doesn't match (Slave mode)
	banksel	I2CMATCH
	clrf	I2CMATCH
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
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;SET LCD_EB ON
	bsf	PORTA,0
;LCD3_CMD(0x30)
	movlw	48
	movwf	LCDVALUE
	pagesel	LCD3_CMD
	call	LCD3_CMD
	pagesel	$
;wait 5 ms
	movlw	5
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;LCD3_CMD(0x30)
	movlw	48
	movwf	LCDVALUE
	pagesel	LCD3_CMD
	call	LCD3_CMD
	pagesel	$
;wait 1 ms
	movlw	1
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;LCD3_CMD(0x38)
	movlw	56
	movwf	LCDVALUE
	pagesel	LCD3_CMD
	call	LCD3_CMD
	pagesel	$
;LCD3_CMD(0x08)
	movlw	8
	movwf	LCDVALUE
	pagesel	LCD3_CMD
	call	LCD3_CMD
	pagesel	$
;LCD3_CMD(0x0F)
	movlw	15
	movwf	LCDVALUE
	pagesel	LCD3_CMD
	call	LCD3_CMD
	pagesel	$
;LCD3_CMD(0x01)
	movlw	1
	movwf	LCDVALUE
	pagesel	LCD3_CMD
	call	LCD3_CMD
	pagesel	$
;LCD3_CMD(0x38)
	movlw	56
	movwf	LCDVALUE
	pagesel	LCD3_CMD
	call	LCD3_CMD
	pagesel	$
;LCD3_CMD(0x80)
	movlw	128
	movwf	LCDVALUE
	pagesel	LCD3_CMD
	call	LCD3_CMD
	pagesel	$
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

LCDBACKLIGHT
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
	bcf	PORTB,3
;If LCDCRSR = ON  Then LCDTemp = LCD_State OR LCDON
	decf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF26
	movlw	12
	iorwf	LCD_STATE,W
	movwf	LCDTEMP
ENDIF26
;IF LCDCRSR = LCDON Then LCDTemp = LCD_State OR LCDON
	movlw	12
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF27
	movlw	12
	iorwf	LCD_STATE,W
	movwf	LCDTEMP
ENDIF27
;If LCDCRSR = OFF Then LCDTemp = LCD_State AND LCDOFF
	movf	LCDCRSR,F
	btfss	STATUS, Z
	goto	ENDIF28
	movlw	11
	andwf	LCD_STATE,W
	movwf	LCDTEMP
ENDIF28
;If LCDCRSR = LCDOFF Then LCDTemp = LCD_State AND LCDOFF
	movlw	11
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF29
	movlw	11
	andwf	LCD_STATE,W
	movwf	LCDTEMP
ENDIF29
;If LCDCRSR = CursorOn Then LCDTemp = LCD_State OR CursorON
	movlw	10
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF30
	movlw	10
	iorwf	LCD_STATE,W
	movwf	LCDTEMP
ENDIF30
;If LCDCRSR = CursorOFF then LCDTemp = LCD_State and CursorOFF
	movlw	13
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF31
	movlw	13
	andwf	LCD_STATE,W
	movwf	LCDTEMP
ENDIF31
;If LCDCRSR = FLASH  Then LCDTemp = LCD_State OR FLASHON
	movlw	9
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF32
	movlw	9
	iorwf	LCD_STATE,W
	movwf	LCDTEMP
ENDIF32
;If LCDCRSR = FLASHON  Then LCDTemp = LCD_State OR FLASHON
	movlw	9
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF33
	movlw	9
	iorwf	LCD_STATE,W
	movwf	LCDTEMP
ENDIF33
;If LCDCRSR = FLASHOFF then LCDTemp = LCD_State and FLASHOFF
	movlw	14
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF34
	movlw	14
	andwf	LCD_STATE,W
	movwf	LCDTEMP
ENDIF34
;LCDWriteByte(LCDTemp)
	movf	LCDTEMP,W
	movwf	LCDBYTE
	pagesel	LCDNORMALWRITEBYTE
	call	LCDNORMALWRITEBYTE
	pagesel	$
;LCD_State = LCDtemp  'save last state
	movf	LCDTEMP,W
	movwf	LCD_STATE
	return

;********************************************************************************

FN_LEFTPAD
;check input length
;return if too short or equal SysStrLen
;If SysStrLen > SysInString(0) Then
	movf	SysSYSINSTRINGHandler,W
	movwf	FSR
	bcf	STATUS, IRP
	btfsc	SysSYSINSTRINGHandler_H,0
	bsf	STATUS, IRP
	movf	SYSSTRLEN,W
	subwf	INDF,W
	btfsc	STATUS, C
	goto	ELSE40_1
;LeftPad = ""
	movlw	low LEFTPAD
	movwf	SysStringB
	movlw	high LEFTPAD
	movwf	SysStringB_H
	movlw	low StringTable49
	movwf	SysStringA
	movlw	high StringTable49
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
	movwf	FSR
	bcf	STATUS, IRP
	btfsc	SysSYSINSTRINGHandler_H,0
	bsf	STATUS, IRP
	movf	INDF,W
	subwf	SYSSTRLEN,W
	movwf	SYSCHARCOUNT
;add sysInString2 to new String
;for SysStringTemp = 1 to SysCharCount
	clrf	SYSSTRINGTEMP
	movlw	1
	subwf	SYSCHARCOUNT,W
	btfss	STATUS, C
	goto	SysForLoopEnd3
ENDIF41
SysForLoop3
	incf	SYSSTRINGTEMP,F
;LeftPad(sysStringTemp) = SysInString2(1)
	incf	SysSYSINSTRING2Handler,W
	movwf	FSR
	bcf	STATUS, IRP
	btfsc	SysSYSINSTRING2Handler_H,0
	bsf	STATUS, IRP
	movf	INDF,W
	movwf	SysArrayTemp1
	movwf	SysArrayTemp2
	movlw	low(LEFTPAD)
	addwf	SYSSTRINGTEMP,W
	movwf	FSR
	bankisel	LEFTPAD
	movf	SysArrayTemp2,W
	movwf	INDF
;Next
	movf	SYSCHARCOUNT,W
	subwf	SYSSTRINGTEMP,W
	btfss	STATUS, C
	goto	SysForLoop3
ENDIF42
SysForLoopEnd3
;add old content to new string
;For SysStringTemp = 1 To sysInString(0)
	clrf	SYSSTRINGTEMP
	movf	SysSYSINSTRINGHandler,W
	movwf	FSR
	bcf	STATUS, IRP
	btfsc	SysSYSINSTRINGHandler_H,0
	bsf	STATUS, IRP
	movlw	1
	subwf	INDF,W
	btfss	STATUS, C
	goto	SysForLoopEnd4
ENDIF43
SysForLoop4
	incf	SYSSTRINGTEMP,F
;LeftPad(sysCharCount + sysStringTemp) = SysInString(SysStringTemp)
	movf	SYSSTRINGTEMP,W
	addwf	SysSYSINSTRINGHandler,W
	movwf	FSR
	bcf	STATUS, IRP
	btfsc	SysSYSINSTRINGHandler_H,0
	bsf	STATUS, IRP
	movf	INDF,W
	movwf	SysArrayTemp1
	movwf	SysArrayTemp2
	movf	SYSSTRINGTEMP,W
	addwf	SYSCHARCOUNT,W
	movwf	SysTemp2
	movlw	low(LEFTPAD)
	addwf	SysTemp2,W
	movwf	FSR
	bankisel	LEFTPAD
	movf	SysArrayTemp2,W
	movwf	INDF
;Next
	movf	SysSYSINSTRINGHandler,W
	movwf	FSR
	bcf	STATUS, IRP
	btfsc	SysSYSINSTRINGHandler_H,0
	bsf	STATUS, IRP
	movf	INDF,W
	subwf	SYSSTRINGTEMP,W
	btfss	STATUS, C
	goto	SysForLoop4
ENDIF44
SysForLoopEnd4
;Else
	goto	ENDIF40
ELSE40_1
;LeftPad = SysInString
	movlw	low LEFTPAD
	movwf	SysStringB
	movlw	high LEFTPAD
	movwf	SysStringB_H
	movf	SysSYSINSTRINGHandler,W
	movwf	SysStringA
	movf	SysSYSINSTRINGHandler_H,W
	movwf	SysStringA_H
	pagesel	SysCopyString
	call	SysCopyString
	pagesel	$
;end if
ENDIF40
	return

;********************************************************************************

;Overloaded signature: STRING:
PRINT138
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
ENDIF18
;Set LCD_RS On
	bsf	PORTB,3
;Write Data
;For SysPrintTemp = 1 To PrintLen
	clrf	SYSPRINTTEMP
	movlw	1
	subwf	PRINTLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd1
ENDIF19
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
	pagesel	LCDNORMALWRITEBYTE
	call	LCDNORMALWRITEBYTE
	pagesel	$
;Next
	movf	PRINTLEN,W
	subwf	SYSPRINTTEMP,W
	btfss	STATUS, C
	goto	SysForLoop1
ENDIF20
SysForLoopEnd1
	return

;********************************************************************************

PRINTDATE
;select case DOW                   ;day of the week
;case 0:
SysSelect1Case1
	movf	DOW,F
	btfss	STATUS, Z
	goto	SysSelect1Case2
;Print "Sun."
	movlw	low SYSSTRINGPARAM5
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM5
	movwf	SysStringB_H
	movlw	low StringTable7
	movwf	SysStringA
	movlw	high StringTable7
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM5
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM5
	movwf	SysPRINTDATAHandler_H
	call	PRINT138
;case 1:
	goto	SysSelectEnd1
SysSelect1Case2
	decf	DOW,W
	btfss	STATUS, Z
	goto	SysSelect1Case3
;Print "Mon."
	movlw	low SYSSTRINGPARAM5
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM5
	movwf	SysStringB_H
	movlw	low StringTable8
	movwf	SysStringA
	movlw	high StringTable8
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM5
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM5
	movwf	SysPRINTDATAHandler_H
	call	PRINT138
;case 2:
	goto	SysSelectEnd1
SysSelect1Case3
	movlw	2
	subwf	DOW,W
	btfss	STATUS, Z
	goto	SysSelect1Case4
;Print "Tue."
	movlw	low SYSSTRINGPARAM5
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM5
	movwf	SysStringB_H
	movlw	low StringTable9
	movwf	SysStringA
	movlw	high StringTable9
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM5
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM5
	movwf	SysPRINTDATAHandler_H
	call	PRINT138
;case 3:
	goto	SysSelectEnd1
SysSelect1Case4
	movlw	3
	subwf	DOW,W
	btfss	STATUS, Z
	goto	SysSelect1Case5
;Print "Wed."
	movlw	low SYSSTRINGPARAM5
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM5
	movwf	SysStringB_H
	movlw	low StringTable10
	movwf	SysStringA
	movlw	high StringTable10
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM5
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM5
	movwf	SysPRINTDATAHandler_H
	call	PRINT138
;case 4:
	goto	SysSelectEnd1
SysSelect1Case5
	movlw	4
	subwf	DOW,W
	btfss	STATUS, Z
	goto	SysSelect1Case6
;Print "Thu."
	movlw	low SYSSTRINGPARAM5
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM5
	movwf	SysStringB_H
	movlw	low StringTable11
	movwf	SysStringA
	movlw	high StringTable11
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM5
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM5
	movwf	SysPRINTDATAHandler_H
	call	PRINT138
;case 5:
	goto	SysSelectEnd1
SysSelect1Case6
	movlw	5
	subwf	DOW,W
	btfss	STATUS, Z
	goto	SysSelect1Case7
;Print "Fri."
	movlw	low SYSSTRINGPARAM5
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM5
	movwf	SysStringB_H
	movlw	low StringTable12
	movwf	SysStringA
	movlw	high StringTable12
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM5
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM5
	movwf	SysPRINTDATAHandler_H
	call	PRINT138
;case 6:
	goto	SysSelectEnd1
SysSelect1Case7
	movlw	6
	subwf	DOW,W
	btfss	STATUS, Z
	goto	SysSelect1Case8
;Print "Sat."
	movlw	low SYSSTRINGPARAM5
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM5
	movwf	SysStringB_H
	movlw	low StringTable13
	movwf	SysStringA
	movlw	high StringTable13
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM5
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM5
	movwf	SysPRINTDATAHandler_H
	call	PRINT138
;case else
	goto	SysSelectEnd1
SysSelect1Case8
;Print str(DOW)+":"
	movf	DOW,W
	movwf	SYSVALTEMP
	clrf	SYSVALTEMP_H
	call	FN_STR
	movlw	low SYSSTRINGPARAM5
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM5
	movwf	SysStringB_H
	clrf	SysStringLength
	movlw	low STR
	movwf	SysStringA
	movlw	high STR
	movwf	SysStringA_H
	pagesel	SysCopyStringPart
	call	SysCopyStringPart
	pagesel	$
	movlw	low StringTable5
	movwf	SysStringA
	movlw	high StringTable5
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low SYSSTRINGPARAM5
	movwf	FSR
	bankisel	SYSSTRINGPARAM5
	movf	SysStringLength,W
	movwf	INDF
	movlw	low SYSSTRINGPARAM5
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM5
	movwf	SysPRINTDATAHandler_H
	call	PRINT138
;end select
SysSelectEnd1
;if clocktype = 0 then
;Print date
	movf	DATE,W
	movwf	LCDVALUE
	pagesel	PRINT139
	call	PRINT139
	pagesel	$
;Print "/"
	movlw	low SYSSTRINGPARAM5
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM5
	movwf	SysStringB_H
	movlw	low StringTable14
	movwf	SysStringA
	movlw	high StringTable14
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM5
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM5
	movwf	SysPRINTDATAHandler_H
	call	PRINT138
;Print month
	movf	MONTH,W
	movwf	LCDVALUE
	pagesel	PRINT139
	call	PRINT139
	pagesel	$
;Print "/20"                       ;make four-digit year
	movlw	low SYSSTRINGPARAM5
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM5
	movwf	SysStringB_H
	movlw	low StringTable15
	movwf	SysStringA
	movlw	high StringTable15
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM5
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM5
	movwf	SysPRINTDATAHandler_H
	call	PRINT138
;if year < 10 then
	movlw	10
	subwf	YEAR,W
	btfsc	STATUS, C
	goto	ENDIF53
;Print "0"
	movlw	low SYSSTRINGPARAM5
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM5
	movwf	SysStringB_H
	movlw	low StringTable4
	movwf	SysStringA
	movlw	high StringTable4
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM5
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM5
	movwf	SysPRINTDATAHandler_H
	call	PRINT138
;end if
ENDIF53
;end if
;Print year
	movf	YEAR,W
	movwf	LCDVALUE
	pagesel	PRINT139
	call	PRINT139
	pagesel	$
;Print " "                        ;blank any garbage
	movlw	low SYSSTRINGPARAM5
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM5
	movwf	SysStringB_H
	movlw	low StringTable16
	movwf	SysStringA
	movlw	high StringTable16
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM5
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM5
	movwf	SysPRINTDATAHandler_H
	goto	PRINT138

;********************************************************************************

PRINTTIME
;if hour < 10 then                 ;left pad with zero
	movlw	10
	subwf	HOUR,W
	btfsc	STATUS, C
	goto	ENDIF49
;Print "0"
	movlw	low SYSSTRINGPARAM3
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM3
	movwf	SysStringB_H
	movlw	low StringTable4
	movwf	SysStringA
	movlw	high StringTable4
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H
	call	PRINT138
;end if
ENDIF49
;Print hour
	movf	HOUR,W
	movwf	LCDVALUE
	pagesel	PRINT139
	call	PRINT139
	pagesel	$
;Print ":"
	movlw	low SYSSTRINGPARAM3
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM3
	movwf	SysStringB_H
	movlw	low StringTable5
	movwf	SysStringA
	movlw	high StringTable5
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H
	call	PRINT138
;if min < 10 then                  ;left pad with zero
	movlw	10
	subwf	MIN,W
	btfsc	STATUS, C
	goto	ENDIF50
;Print "0"
	movlw	low SYSSTRINGPARAM3
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM3
	movwf	SysStringB_H
	movlw	low StringTable4
	movwf	SysStringA
	movlw	high StringTable4
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H
	call	PRINT138
;end if
ENDIF50
;Print min
	movf	MIN,W
	movwf	LCDVALUE
	pagesel	PRINT139
	call	PRINT139
	pagesel	$
;Print ":"
	movlw	low SYSSTRINGPARAM3
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM3
	movwf	SysStringB_H
	movlw	low StringTable5
	movwf	SysStringA
	movlw	high StringTable5
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H
	call	PRINT138
;if sec < 10 then                  ;left pad with zero
	movlw	10
	subwf	SEC,W
	btfsc	STATUS, C
	goto	ENDIF51
;Print "0"
	movlw	low SYSSTRINGPARAM3
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM3
	movwf	SysStringB_H
	movlw	low StringTable4
	movwf	SysStringA
	movlw	high StringTable4
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H
	call	PRINT138
;end if
ENDIF51
;Print sec
	movf	SEC,W
	movwf	LCDVALUE
	pagesel	PRINT139
	call	PRINT139
	pagesel	$
;Print "     "                    ;wipe out any garbage
	movlw	low SYSSTRINGPARAM3
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM3
	movwf	SysStringB_H
	movlw	low StringTable6
	movwf	SysStringA
	movlw	high StringTable6
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H
	goto	PRINT138

;********************************************************************************

SHOWALARM
;cls
	pagesel	CLS
	call	CLS
	pagesel	$
;locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;dim myreg as Byte
;print "Alarm "
	movlw	low SYSSTRINGPARAM2
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM2
	movwf	SysStringB_H
	movlw	low StringTable26
	movwf	SysStringA
	movlw	high StringTable26
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H
	call	PRINT138
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
	movlw	low SYSSTRINGPARAM2
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM2
	movwf	SysStringB_H
	movlw	low StringTable4
	movwf	SysStringA
	movlw	high StringTable4
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM2
	movwf	SysSYSINSTRING2Handler
	movlw	high SYSSTRINGPARAM2
	movwf	SysSYSINSTRING2Handler_H
	call	FN_LEFTPAD
	movlw	low LEFTPAD
	movwf	SysPRINTDATAHandler
	movlw	high LEFTPAD
	movwf	SysPRINTDATAHandler_H
	call	PRINT138
;print ":"
	movlw	low SYSSTRINGPARAM2
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM2
	movwf	SysStringB_H
	movlw	low StringTable5
	movwf	SysStringA
	movlw	high StringTable5
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM2
	movwf	SysPRINTDATAHandler_H
	call	PRINT138
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
	movlw	low SYSSTRINGPARAM2
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM2
	movwf	SysStringB_H
	movlw	low StringTable4
	movwf	SysStringA
	movlw	high StringTable4
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM2
	movwf	SysSYSINSTRING2Handler
	movlw	high SYSSTRINGPARAM2
	movwf	SysSYSINSTRING2Handler_H
	call	FN_LEFTPAD
	movlw	low LEFTPAD
	movwf	SysPRINTDATAHandler
	movlw	high LEFTPAD
	movwf	SysPRINTDATAHandler_H
	call	PRINT138
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
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
	goto	ENDIF36
;SysStrData = SysValTemp / 10000
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB
	movlw	39
	movwf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
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
	movwf	FSR
	bankisel	STR
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF
;Goto SysValThousands
	goto	SYSVALTHOUSANDS
;End If
ENDIF36
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
	goto	ENDIF37
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
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
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
	movwf	FSR
	bankisel	STR
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF
;Goto SysValHundreds
	goto	SYSVALHUNDREDS
;End If
ENDIF37
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
	goto	ENDIF38
SYSVALHUNDREDS
;SysStrData = SysValTemp / 100
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
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
	movwf	FSR
	bankisel	STR
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF
;Goto SysValTens
	goto	SYSVALTENS
;End If
ENDIF38
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
	goto	ENDIF39
SYSVALTENS
;SysStrData = SysValTemp / 10
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
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
	movwf	FSR
	bankisel	STR
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF
;End If
ENDIF39
;Ones
;SysCharCount += 1
	incf	SYSCHARCOUNT,F
;Str(SysCharCount) = SysValTemp + 48
	movlw	low(STR)
	addwf	SYSCHARCOUNT,W
	movwf	FSR
	bankisel	STR
	movlw	48
	addwf	SYSVALTEMP,W
	movwf	INDF
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

I2CRECEIVE
;I2C_CLOCK_LOW                 'SCL begins low
	banksel	TRISA
	bcf	TRISA,3
	banksel	PORTA
	bcf	PORTA,3
;I2C_DATA_HIGH                 'this makes SDA an input now
	banksel	TRISA
	bsf	TRISA,4
;I2CByte = 0                   'received byte built up here
	banksel	I2CBYTE
	clrf	I2CBYTE
;repeat 8                      'fetch the 8 bits
	movlw	8
	movwf	SysRepeatTemp3
SysRepeatLoop3
;wait I2C_END_DELAY          'let port lines settle down
	nop
;I2C_CLOCK_HIGH              'send a clock pulse
	banksel	TRISA
	bsf	TRISA,3
;wait while I2C_CLOCK = OFF  'permit clock stretching
SysWaitLoop11
	banksel	PORTA
	btfss	PORTA,3
	goto	SysWaitLoop11
;rotate I2CByte left         'make room for next bit
	rlf	I2CBYTE,F
;set I2CByte.0 OFF           'assume it's a zero
	bcf	I2CBYTE,0
;if I2C_DATA = ON then       'else, it's a one
	btfsc	PORTA,4
;set I2CByte.0 ON
	bsf	I2CBYTE,0
;end if
ENDIF47
;wait I2C_CLOCK_DELAY        'clock high this amount of time
	nop
;I2C_CLOCK_LOW               'SCL now low
	banksel	TRISA
	bcf	TRISA,3
	banksel	PORTA
	bcf	PORTA,3
;wait I2C_END_DELAY          'time before next clock pulse
	nop
;end repeat
	decfsz	SysRepeatTemp3,F
	goto	SysRepeatLoop3
SysRepeatLoopEnd3
;if I2CAck then
	movf	I2CACK,F
	btfsc	STATUS,Z
	goto	ELSE48_1
;I2C_DATA_LOW                'SDA=0 means ACK
	banksel	TRISA
	bcf	TRISA,4
	banksel	PORTA
	bcf	PORTA,4
;else
	goto	ENDIF48
ELSE48_1
;I2C_DATA_HIGH               'SDA=1 means NAK
	banksel	TRISA
	bsf	TRISA,4
;end if
ENDIF48
;wait I2C_END_DELAY            'either way, let it settle
	nop
;I2C_CLOCK_HIGH                'then clock it out
	banksel	TRISA
	bsf	TRISA,3
;wait while I2C_CLOCK = OFF    'permit clock stretching
SysWaitLoop12
	banksel	PORTA
	btfss	PORTA,3
	goto	SysWaitLoop12
;wait I2C_CLOCK_DELAY          'keep high long enough
	nop
;I2C_CLOCK_LOW                 'then SCL goes low again
	banksel	TRISA
	bcf	TRISA,3
	banksel	PORTA
	bcf	PORTA,3
;wait I2C_END_DELAY            'and settles before proceeding
	nop
	return

;********************************************************************************

I2CSTART
;I2C_DATA_HIGH                 'SDA and SCL idle high
	banksel	TRISA
	bsf	TRISA,4
;I2C_CLOCK_HIGH
	bsf	TRISA,3
;wait I2C_END_DELAY            'let settle a while
	nop
;I2C_DATA_LOW                  'then, SDA low while SCL still high
	bcf	TRISA,4
	banksel	PORTA
	bcf	PORTA,4
;wait I2C_CLOCK_DELAY          'for this amount of time
	nop
;I2C_CLOCK_LOW                 'end with SCL low, ready to clock
	banksel	TRISA
	bcf	TRISA,3
	banksel	PORTA
	bcf	PORTA,3
	return

;********************************************************************************

I2CSTOP
;I2C_CLOCK_LOW                 'begin with SCL=0 and SDA=0
	banksel	TRISA
	bcf	TRISA,3
	banksel	PORTA
	bcf	PORTA,3
;I2C_DATA_LOW
	banksel	TRISA
	bcf	TRISA,4
	banksel	PORTA
	bcf	PORTA,4
;wait I2C_END_DELAY            'let ports settle
	nop
;I2C_CLOCK_HIGH                'make SCL=1 first
	banksel	TRISA
	bsf	TRISA,3
;wait I2C_CLOCK_DELAY          'hold for normal clock width time
	nop
;I2C_DATA_HIGH                 'then make SDA=1 afterwards
	bsf	TRISA,4
;wait I2C_END_DELAY            'hold for normal between-time
	nop
;back idling with SCL=1 and SDA=1 at this point
	banksel	STATUS
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
ENDIF35
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
ENDIF23
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
ENDIF24
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
ENDIF25
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
	goto	ENDIF21
;if LCDByte > 7 then
	movf	LCDBYTE,W
	sublw	7
	btfsc	STATUS, C
	goto	ENDIF22
;LCD_State = LCDByte
	movf	LCDBYTE,W
	movwf	LCD_STATE
;end if
ENDIF22
;END IF
ENDIF21
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
	goto	ENDIF17
;LCDLine = LCDLine - 2
	movlw	2
	subwf	LCDLINE,F
;LCDColumn = LCDColumn + LCD_WIDTH
	movlw	20
	addwf	LCDCOLUMN,F
;End If
ENDIF17
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

MONTHDAYS
	movlw	13
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableMONTHDAYS
	movwf	SysStringA
	movlw	high TableMONTHDAYS
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
;Enables clock if DS_Value = TRUE, disables if DS_Value = FALSE
;I2CStart
	call	I2CSTART
;I2CSend(DS_AddrWrite)
	movlw	162
	movwf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;I2CSend( PCF85x3_CTRL_REG_1 )                     ;indicate register 0
	clrf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;I2CStart
	call	I2CSTART
;I2CSend(DS_AddrRead)
	movlw	163
	movwf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;I2CReceive(DS_EnableState, NACK)       ;get the current seconds
	clrf	I2CACK
	call	I2CRECEIVE
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
;I2CStart
	call	I2CSTART
;I2CSend(DS_AddrWrite)
	movlw	162
	movwf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;I2CSend( PCF85x3_CTRL_REG_1 )                     ;indicate register 0
	clrf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;I2CSend(DS_EnableState)                ;now send updated value
	movf	DS_ENABLESTATE,W
	movwf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;I2CStop
	goto	I2CSTOP

;********************************************************************************

PCF85X3_READDATE
;Get date only: day of week, date, month, year
;I2CStart
	call	I2CSTART
;I2CSend(DS_AddrWrite)
	movlw	162
	movwf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;I2CSend( PCF85x3_DAYS_REG )                      ;begin
	movlw	5
	movwf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;I2CStart
	call	I2CSTART
;I2CSend(DS_AddrRead)
	movlw	163
	movwf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;I2CReceive(DS_Date, ACK)             ;get date
	movlw	255
	movwf	I2CACK
	call	I2CRECEIVE
	movf	I2CBYTE,W
	movwf	DS_DATE
;DS_Date = BcdToDec(DS_Date  & PCF85x3_DAYS_REG_MASK)
	movlw	63
	andwf	DS_DATE,W
	movwf	VA
	call	FN_BCDTODEC
	movf	BCDTODEC,W
	movwf	DS_DATE
;I2CReceive(DS_DOW, ACK)              ;get day of week
	movlw	255
	movwf	I2CACK
	call	I2CRECEIVE
	movf	I2CBYTE,W
	movwf	DS_DOW
;DS_DOW = BcdToDec(DS_DOW & PCF85x3_WKDAY_REG_MASK )
	movlw	3
	andwf	DS_DOW,W
	movwf	VA
	call	FN_BCDTODEC
	movf	BCDTODEC,W
	movwf	DS_DOW
;I2CReceive(DS_Month, ACK)            ;get month
	movlw	255
	movwf	I2CACK
	call	I2CRECEIVE
	movf	I2CBYTE,W
	movwf	DS_MONTH
;DS_Month = BcdToDec(DS_Month & PCF85x3_MONTHS_REG_MASK)
	movlw	31
	andwf	DS_MONTH,W
	movwf	VA
	call	FN_BCDTODEC
	movf	BCDTODEC,W
	movwf	DS_MONTH
;I2CReceive(DS_Year, NACK)       ;get year
	clrf	I2CACK
	call	I2CRECEIVE
	movf	I2CBYTE,W
	movwf	DS_YEAR
;DS_Year = BcdToDec(DS_Year & PCF85x3_YEARS_REG_MASK)
	movwf	VA
	call	FN_BCDTODEC
	movf	BCDTODEC,W
	movwf	DS_YEAR
;I2CStop
	goto	I2CSTOP

;********************************************************************************

PCF85X3_READREGISTER
;I2CStart
	call	I2CSTART
;I2CSend(DS_AddrWrite)
	movlw	162
	movwf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;I2CSend( DS_reg )   ;begin
	movf	DS_REG,W
	movwf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;I2CStart
	call	I2CSTART
;I2CSend(DS_AddrRead)
	movlw	163
	movwf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;I2CReceive(DS_val, NACK)
	clrf	I2CACK
	call	I2CRECEIVE
	movf	I2CBYTE,W
	movwf	DS_VAL
;I2CStop
	goto	I2CSTOP

;********************************************************************************

PCF85X3_READTIME
;I2CStart
	call	I2CSTART
;I2CSend(DS_AddrWrite)
	movlw	162
	movwf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;I2CSend( PCF85x3_VL_SEC_REG )                      ;begin
	movlw	2
	movwf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;I2CStart
	call	I2CSTART
;I2CSend(DS_AddrRead)
	movlw	163
	movwf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;I2CReceive(DS_Sec, ACK)              ;get seconds
	movlw	255
	movwf	I2CACK
	call	I2CRECEIVE
	movf	I2CBYTE,W
	movwf	DS_SEC
;DS_Sec = BcdToDec(DS_Sec & PCF85x3_SEC_REG_MASK ) ;strip off VL bit
	movlw	127
	andwf	DS_SEC,W
	movwf	VA
	call	FN_BCDTODEC
	movf	BCDTODEC,W
	movwf	DS_SEC
;I2CReceive(DS_Min, ACK)              ;get minutes
	movlw	255
	movwf	I2CACK
	call	I2CRECEIVE
	movf	I2CBYTE,W
	movwf	DS_MIN
;DS_Min = BcdToDec(DS_Min & PCF85x3_MINS_REG_MASK)       ;bit 7 is always 0
	movlw	127
	andwf	DS_MIN,W
	movwf	VA
	call	FN_BCDTODEC
	movf	BCDTODEC,W
	movwf	DS_MIN
;I2CReceive(DS_Hour, ACK)             ;get hours
	movlw	255
	movwf	I2CACK
	call	I2CRECEIVE
	movf	I2CBYTE,W
	movwf	DS_HOUR
;DS_Hour = BcdToDec(DS_Hour & PCF85x3_HOURS_REG_MASK )
	movlw	63
	andwf	DS_HOUR,W
	movwf	VA
	call	FN_BCDTODEC
	movf	BCDTODEC,W
	movwf	DS_HOUR
;I2CStop
	goto	I2CSTOP

;********************************************************************************

FN_PCF85X3_READVL
;I2CStart
	call	I2CSTART
;I2CSend(DS_AddrWrite)
	movlw	162
	movwf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;I2CSend( PCF85x3_VL_SEC_REG )                      ;begin
	movlw	2
	movwf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;I2CStart
	call	I2CSTART
;I2CSend(DS_AddrRead)
	movlw	163
	movwf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;I2CReceive(DS_Sec, NACK)              ;get seconds
	clrf	I2CACK
	call	I2CRECEIVE
	movf	I2CBYTE,W
	movwf	DS_SEC
;PCF85x3_ReadVL = BcdToDec(DS_Sec & PCF85x3_VL_REG_MASK ) ;strip off VL bit
	movlw	128
	andwf	DS_SEC,W
	movwf	VA
	call	FN_BCDTODEC
	movf	BCDTODEC,W
	movwf	PCF85X3_READVL
;I2CStop
	goto	I2CSTOP

;********************************************************************************

;Overloaded signature: BYTE:BYTE:
PCF85X3_SETALARM17
;Set alarm: hours, minutes
;I2CStart
	call	I2CSTART
;I2CSend(DS_AddrWrite)
	movlw	162
	movwf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;I2CSend( PCF85x3_MINS_ALARM_REG )   ;begin
	movlw	9
	movwf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;I2CSend(DecToBcd(DS_Min))       ;consecutive values
	movf	DS_MIN,W
	movwf	VA
	call	FN_DECTOBCD
	movf	DECTOBCD,W
	movwf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;I2CSend(DecToBcd(DS_Hour))
	movf	DS_HOUR,W
	movwf	VA
	call	FN_DECTOBCD
	movf	DECTOBCD,W
	movwf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;I2CStop
	goto	I2CSTOP

;********************************************************************************

PCF85X3_SETCLOCK
;Set entire clock: hours, minutes, seconds, day of week, date, month, year
;I2CStart
	call	I2CSTART
;I2CSend(DS_AddrWrite)
	movlw	162
	movwf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;I2CSend( PCF85x3_VL_SEC_REG )   ;begin
	movlw	2
	movwf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;I2CSend(DecToBcd(DS_Sec))       ;then set the seven
	movf	DS_SEC,W
	movwf	VA
	call	FN_DECTOBCD
	movf	DECTOBCD,W
	movwf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;I2CSend(DecToBcd(DS_Min))       ;consecutive values
	movf	DS_MIN,W
	movwf	VA
	call	FN_DECTOBCD
	movf	DECTOBCD,W
	movwf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;I2CSend(DecToBcd(DS_Hour))
	movf	DS_HOUR,W
	movwf	VA
	call	FN_DECTOBCD
	movf	DECTOBCD,W
	movwf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;I2CSend(DecToBcd(DS_Date))
	movf	DS_DATE,W
	movwf	VA
	call	FN_DECTOBCD
	movf	DECTOBCD,W
	movwf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;I2CSend(DecToBcd(DS_DOW))
	movf	DS_DOW,W
	movwf	VA
	call	FN_DECTOBCD
	movf	DECTOBCD,W
	movwf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;I2CSend(DecToBcd(DS_Month))
	movf	DS_MONTH,W
	movwf	VA
	call	FN_DECTOBCD
	movf	DECTOBCD,W
	movwf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;I2CSend(DecToBcd(DS_Year))
	movf	DS_YEAR,W
	movwf	VA
	call	FN_DECTOBCD
	movf	DECTOBCD,W
	movwf	I2CBYTE
	pagesel	I2CSEND
	call	I2CSEND
	pagesel	$
;I2CStop
	goto	I2CSTOP

;********************************************************************************

;Overloaded signature: BYTE:
PRINT139
;LCDValueTemp = 0
	clrf	LCDVALUETEMP
;Set LCD_RS On
	bsf	PORTB,3
;IF LCDValue >= 100 Then
	movlw	100
	subwf	LCDVALUE,W
	btfss	STATUS, C
	goto	ENDIF54
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
	call	LCDNORMALWRITEBYTE
;End If
ENDIF54
;If LCDValueTemp > 0 Or LCDValue >= 10 Then
	movf	LCDVALUETEMP,W
	movwf	SysBYTETempB
	clrf	SysBYTETempA
	call	SysCompLessThan
	movf	SysByteTempX,W
	movwf	SysTemp2
	movf	LCDVALUE,W
	movwf	SysBYTETempA
	movlw	10
	movwf	SysBYTETempB
	call	SysCompLessThan
	comf	SysByteTempX,F
	movf	SysTemp2,W
	iorwf	SysByteTempX,W
	movwf	SysTemp3
	btfss	SysTemp3,0
	goto	ENDIF55
;LCDValueTemp = LCDValue / 10
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
	call	LCDNORMALWRITEBYTE
;End If
ENDIF55
;LCDWriteByte (LCDValue + 48)
	movlw	48
	addwf	LCDVALUE,W
	movwf	LCDBYTE
	goto	LCDNORMALWRITEBYTE

;********************************************************************************

SETDATE
;***** Date
;cls
	call	CLS
;Print "Set Date:"
	movlw	low SYSSTRINGPARAM3
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM3
	movwf	SysStringB_H
	movlw	low StringTable24
	movwf	SysStringA
	movlw	high StringTable24
	movwf	SysStringA_H
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT138
	call	PRINT138
	pagesel	$
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
	btfss	PORTB,2
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
	btfsc	PORTB,2
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
	btfss	PORTB,1
	goto	SysDoLoop_S20
SysDoLoop_E20
;do while setBut = pressed         ;wait for Set release
SysDoLoop_S22
	btfss	PORTB,1
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
	movlw	low SYSSTRINGPARAM3
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM3
	movwf	SysStringB_H
	movlw	low StringTable23
	movwf	SysStringA
	movlw	high StringTable23
	movwf	SysStringA_H
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT138
	call	PRINT138
	pagesel	$
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
	btfss	PORTB,2
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
	btfsc	PORTB,2
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
	btfss	PORTB,1
	goto	SysDoLoop_S17
SysDoLoop_E17
;readTable monthDays, month, daysMax
	movf	MONTH,W
	movwf	SYSSTRINGA
	call	MONTHDAYS
	movwf	DAYSMAX
;do while setBut = pressed         ;wait for Set release
SysDoLoop_S19
	btfss	PORTB,1
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
	movlw	low SYSSTRINGPARAM3
	movwf	SysStringB
	movlw	high SYSSTRINGPARAM3
	movwf	SysStringB_H
	movlw	low StringTable25
	movwf	SysStringA
	movlw	high StringTable25
	movwf	SysStringA_H
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM3
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT138
	call	PRINT138
	pagesel	$
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
	btfss	PORTB,2
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
	btfsc	PORTB,2
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
	btfss	PORTB,1
	goto	SysDoLoop_S23
SysDoLoop_E23
;do while setBut = pressed         ;wait for Set release
SysDoLoop_S25
	btfss	PORTB,1
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
;Dim SysCalcTempB As Byte
;Get length
;movf SysStringA, W
	movf	SYSSTRINGA, W
;movwf FSR
	movwf	FSR
;bcf STATUS, IRP
	bcf	STATUS, IRP
;btfsc SysStringA_H, 0
	btfsc	SYSSTRINGA_H, 0
;bsf STATUS, IRP
	bsf	STATUS, IRP
;movf INDF, W
	movf	INDF, W
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA
;Set length
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
;movf SysCalcTempA, W
	movf	SYSCALCTEMPA, W
;movwf INDF
	movwf	INDF
;goto SysCopyStringCheck
	goto	SYSCOPYSTRINGCHECK
;When appending, add length to counter
SYSCOPYSTRINGPART
;movf SysStringA, W
	movf	SYSSTRINGA, W
;movwf FSR
	movwf	FSR
;bcf STATUS, IRP
	bcf	STATUS, IRP
;btfsc SysStringA_H, 0
	btfsc	SYSSTRINGA_H, 0
;bsf STATUS, IRP
	bsf	STATUS, IRP
;movf INDF, W
	movf	INDF, W
;addwf SysStringLength, F
	addwf	SYSSTRINGLENGTH, F
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA
;if source length = 0, exit
SYSCOPYSTRINGCHECK
;movf SysCalcTempA,W
	movf	SYSCALCTEMPA,W
;btfsc STATUS,Z
	btfsc	STATUS,Z
;return
	return
;Copy char-by-char
SYSSTRINGCOPY
;Increment pointers
;incf SysStringA, F
	incf	SYSSTRINGA, F
;incf SysStringB, F
	incf	SYSSTRINGB, F
;Strings cannot span banks, so no need to increment pointer high byte
;Get char
;movf SysStringA, W
	movf	SYSSTRINGA, W
;movwf FSR
	movwf	FSR
;bcf STATUS, IRP
	bcf	STATUS, IRP
;btfsc SysStringA_H, 0
	btfsc	SYSSTRINGA_H, 0
;bsf STATUS, IRP
	bsf	STATUS, IRP
;movf INDF, W
	movf	INDF, W
;movwf SysCalcTempB
	movwf	SYSCALCTEMPB
;Set char
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
;movf SysCalcTempB, W
	movf	SYSCALCTEMPB, W
;movwf INDF
	movwf	INDF
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
	goto	ENDIF56
;SysWordTempA = 0
	clrf	SYSWORDTEMPA
	clrf	SYSWORDTEMPA_H
;exit sub
	return
;end if
ENDIF56
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
	btfss	STATUS,C
	incfsz	SYSDIVMULTB_H,W
	subwf	SYSDIVMULTX_H,F
ENDIF58
;Set SysDivMultA.0 On
	bsf	SYSDIVMULTA,0
;If C Off Then
	btfsc	STATUS,C
	goto	ENDIF57
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	btfsc	STATUS,C
	incfsz	SYSDIVMULTB_H,W
	addwf	SYSDIVMULTX_H,F
ENDIF59
;End If
ENDIF57
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
	pagesel	SYSSTRINGTABLES
	call	SYSSTRINGTABLES
	pagesel	$
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
	pagesel	SYSSTRINGTABLES
	call	SYSSTRINGTABLES
	pagesel	$
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
;Show clock integrity
;locate 0, 15
	clrf	LCDLINE
	movlw	15
	movwf	LCDCOLUMN
	call	LOCATE
;If PCF85x3_ReadVL is 0 then the clock integrity is good... show a happy face
;if PCF85x3_ReadVL = 0 then
	call	FN_PCF85X3_READVL
	movf	PCF85X3_READVL,F
	btfss	STATUS, Z
	goto	ELSE3_1
;print "+"
;LCDWriteChar 0
	clrf	LCDCHAR
	call	LCDWRITECHAR
;else
	goto	ENDIF3
ELSE3_1
;print "-"
;LCDWriteChar 1
	movlw	1
	movwf	LCDCHAR
	call	LCDWRITECHAR
;end if
ENDIF3
;if oldsec <> sec then
	movf	SEC,W
	subwf	OLDSEC,W
	btfsc	STATUS, Z
	goto	ENDIF4
;if sec = 0 then                             ;time to update
	movf	SEC,F
	btfss	STATUS, Z
	goto	ENDIF5
;PCF85x3_ReadDate(DOW, date, month, year)
	call	PCF85X3_READDATE
	movf	DS_DOW,W
	movwf	DOW
	movf	DS_DATE,W
	movwf	DATE
	movf	DS_MONTH,W
	movwf	MONTH
	movf	DS_YEAR,W
	movwf	YEAR
;end if
ENDIF5
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
ENDIF4
	return

;********************************************************************************


 END
