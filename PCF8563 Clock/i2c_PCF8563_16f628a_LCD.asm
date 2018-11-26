;Program compiled by Great Cow BASIC (0.98.03 2018-10-20 (Windows 32 bit))
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F628A, r=DEC
#include <P16F628A.inc>
 __CONFIG _LVP_OFF & _MCLRE_OFF & _WDTE_OFF & _INTRC_OSC_NOCLKOUT

;********************************************************************************

;Set aside memory locations for variables
BCDTODEC	EQU	32
DATE	EQU	33
DELAYTEMP	EQU	112
DELAYTEMP2	EQU	113
DOW	EQU	34
DS_DATE	EQU	35
DS_DOW	EQU	36
DS_MONTH	EQU	37
DS_YEAR	EQU	38
I2CACK	EQU	39
I2CACKPOLLSTATE	EQU	40
I2CBYTE	EQU	41
I2CMATCH	EQU	42
I2CSTATE	EQU	43
LCD3_RSSTATE	EQU	44
LCDBYTE	EQU	45
LCDCOLUMN	EQU	46
LCDCRSR	EQU	47
LCDLINE	EQU	48
LCDTEMP	EQU	49
LCDVALUE	EQU	50
LCD_STATE	EQU	51
MONTH	EQU	52
OLDSEC	EQU	53
PRINTLEN	EQU	54
STRINGPOINTER	EQU	55
SYSBYTETEMPA	EQU	117
SYSBYTETEMPB	EQU	121
SYSBYTETEMPX	EQU	112
SYSCALCTEMPA	EQU	117
SYSDIVLOOP	EQU	116
SYSPRINTDATAHANDLER	EQU	56
SYSPRINTDATAHANDLER_H	EQU	57
SYSPRINTTEMP	EQU	58
SYSREPEATTEMP1	EQU	59
SYSREPEATTEMP2	EQU	60
SYSREPEATTEMP3	EQU	61
SYSSTRINGA	EQU	119
SYSSTRINGA_H	EQU	120
SYSSTRINGB	EQU	114
SYSSTRINGB_H	EQU	115
SYSSTRINGLENGTH	EQU	118
SYSSTRINGPARAM1	EQU	318
SYSTEMP1	EQU	62
SYSTEMP2	EQU	63
SYSWAITTEMP10US	EQU	117
SYSWAITTEMPMS	EQU	114
SYSWAITTEMPMS_H	EQU	115
SYSWAITTEMPS	EQU	116
SYSWAITTEMPUS	EQU	117
SYSWAITTEMPUS_H	EQU	118
VA	EQU	64
YEAR	EQU	65

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
;''The PCF8563 is attached to the I2C ports with appropiate resistors to the supply voltage.  Typically a 5k or 2.2k resistor 'pulling up' to the supply voltage can be used.
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
;''@version 1.2a
;''@date    23.02.15
;''********************************************************************************
;----- Configuration
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
;#define DS_AddrWrite 0xA2
;#define DS_AddrRead  0xA3
;----- Define Hardware settings
;dir setBut in
	banksel	TRISB
	bsf	TRISB,0
;dir modeBut in
	bsf	TRISB,1
;#define clocktype   0               ;0 is US or 1 is UK style
;#define debounce    50 mS            ;settling time for switches
;#define delay       150 mS          ;delay time for pushbutton
;#define pressed     1               ;flag for pressed pushbutton
;#define setBut      portb.0         ;Set pushbutton
;#define modeBut     portb.1         ;Mode pushbutton
;#define Alarm0 0x00                 ;a reference to the alarm 0
;#define Alarm1 0x01                 ;a reference to the alarm 1
;----- Variables
;Dim DAYSMAX, DAYSMAX as Byte
;dim changed as bit
;dim hour, min, sec, am_pm as byte
;dim oldsec as byte
;dim date, month, year, DOW as byte
;dim mode, Oldmode, dayMax as byte
;oldsec = 255                        ;      init value
	movlw	255
	banksel	OLDSEC
	movwf	OLDSEC
;----- Tables
;----- Program
;LCDCursor CURSOROFF
	movlw	13
	movwf	LCDCRSR
	call	LCDCURSOR
;locate 0,0
	clrf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE
;Print "PCF8563"
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
	call	PRINT127
;locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE
;Print "Great Cow Basic"
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
	call	PRINT127
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	call	Delay_S
;CLS
	call	CLS
;Main body of program commences here.
;PCF8563_ReadDate(DOW, date, month, year)   ;get initial date
	call	PCF8563_READDATE
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
;if setBut = pressed then
;changeSetting                   ;change time and date
;end if
;
;if modeBut = pressed then
;changeMode                      ;12 or 24 hour mode
;end if
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

FN_BCDTODEC
;Convert binary coded decimal to pure decimal
;BcdToDec=( va /16)*10+ va %16
	movf	VA,W
	movwf	SysBYTETempA
	movlw	16
	movwf	SysBYTETempB
	call	SysDivSub
	movf	SysBYTETempA,W
	movwf	SysTemp1
	movwf	SysBYTETempA
	movlw	10
	movwf	SysBYTETempB
	call	SysMultSub
	movf	SysBYTETempX,W
	movwf	SysTemp2
	movf	VA,W
	movwf	SysBYTETempA
	movlw	16
	movwf	SysBYTETempB
	call	SysDivSub
	movf	SysBYTETempX,W
	addwf	SysTemp2,W
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
SysWaitLoop3
	banksel	PORTA
	btfss	PORTA,3
	goto	SysWaitLoop3
;rotate I2CByte left         'make room for next bit
	rlf	I2CBYTE,F
;set I2CByte.0 OFF           'assume it's a zero
	bcf	I2CBYTE,0
;if I2C_DATA = ON then       'else, it's a one
	btfsc	PORTA,4
;set I2CByte.0 ON
	bsf	I2CBYTE,0
;end if
ENDIF21
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
	goto	ELSE22_1
;I2C_DATA_LOW                'SDA=0 means ACK
	banksel	TRISA
	bcf	TRISA,4
	banksel	PORTA
	bcf	PORTA,4
;else
	goto	ENDIF22
ELSE22_1
;I2C_DATA_HIGH               'SDA=1 means NAK
	banksel	TRISA
	bsf	TRISA,4
;end if
ENDIF22
;wait I2C_END_DELAY            'either way, let it settle
	nop
;I2C_CLOCK_HIGH                'then clock it out
	banksel	TRISA
	bsf	TRISA,3
;wait while I2C_CLOCK = OFF    'permit clock stretching
SysWaitLoop4
	banksel	PORTA
	btfss	PORTA,3
	goto	SysWaitLoop4
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

I2CRESTART
;I2CStart
	goto	I2CSTART

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
	goto	ELSE19_1
;I2C_DATA_HIGH
	banksel	TRISA
	bsf	TRISA,4
;else
	goto	ENDIF19
ELSE19_1
;I2C_DATA_LOW
	banksel	TRISA
	bcf	TRISA,4
	banksel	PORTA
	bcf	PORTA,4
;end if
ENDIF19
;rotate I2CByte left         'shift in bit for the next time
	banksel	I2CBYTE
	rlf	I2CBYTE,F
;I2C_CLOCK_HIGH              'now clock it in
	banksel	TRISA
	bsf	TRISA,3
;wait while I2C_CLOCK = OFF    'permit clock stretching here
SysWaitLoop1
	banksel	PORTA
	btfss	PORTA,3
	goto	SysWaitLoop1
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
SysWaitLoop2
	banksel	PORTA
	btfss	PORTA,3
	goto	SysWaitLoop2
;restored 'I2CSendState' variable for backwards compatibility
;if I2C_DATA then              'read 9th bit in from Slave
	btfss	PORTA,4
	goto	ELSE20_1
;I2CAck = FALSE              'return a NAK to the program
	clrf	I2CACK
;I2CSendState =  FALSE        'state of target device with respect. Retained for backwards compatibility
	clrf	I2CACKPOLLSTATE
;else
	goto	ENDIF20
ELSE20_1
;I2CAck = TRUE               'else, return an ACK to the program
	movlw	255
	movwf	I2CACK
;I2CSendState =  TRUE        'state of target device with respect. Retained for backwards compatibility
	movlw	255
	movwf	I2CACKPOLLSTATE
;end if
ENDIF20
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
	goto	ENDIF10
	movlw	12
	iorwf	LCD_STATE,W
	movwf	LCDTEMP
ENDIF10
;IF LCDCRSR = LCDON Then LCDTemp = LCD_State OR LCDON
	movlw	12
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF11
	movlw	12
	iorwf	LCD_STATE,W
	movwf	LCDTEMP
ENDIF11
;If LCDCRSR = OFF Then LCDTemp = LCD_State AND LCDOFF
	movf	LCDCRSR,F
	btfss	STATUS, Z
	goto	ENDIF12
	movlw	11
	andwf	LCD_STATE,W
	movwf	LCDTEMP
ENDIF12
;If LCDCRSR = LCDOFF Then LCDTemp = LCD_State AND LCDOFF
	movlw	11
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF13
	movlw	11
	andwf	LCD_STATE,W
	movwf	LCDTEMP
ENDIF13
;If LCDCRSR = CursorOn Then LCDTemp = LCD_State OR CursorON
	movlw	10
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF14
	movlw	10
	iorwf	LCD_STATE,W
	movwf	LCDTEMP
ENDIF14
;If LCDCRSR = CursorOFF then LCDTemp = LCD_State and CursorOFF
	movlw	13
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF15
	movlw	13
	andwf	LCD_STATE,W
	movwf	LCDTEMP
ENDIF15
;If LCDCRSR = FLASH  Then LCDTemp = LCD_State OR FLASHON
	movlw	9
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF16
	movlw	9
	iorwf	LCD_STATE,W
	movwf	LCDTEMP
ENDIF16
;If LCDCRSR = FLASHON  Then LCDTemp = LCD_State OR FLASHON
	movlw	9
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF17
	movlw	9
	iorwf	LCD_STATE,W
	movwf	LCDTEMP
ENDIF17
;If LCDCRSR = FLASHOFF then LCDTemp = LCD_State and FLASHOFF
	movlw	14
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF18
	movlw	14
	andwf	LCD_STATE,W
	movwf	LCDTEMP
ENDIF18
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

PCF8563_READDATE
;Get date only: day of week, date, month, year
;I2CStart
	call	I2CSTART
;I2CSend(DS_AddrWrite)
	movlw	162
	movwf	I2CBYTE
	call	I2CSEND
;I2CSend(5)                      ;begin with address 3
	movlw	5
	movwf	I2CBYTE
	call	I2CSEND
;I2CReStart
	call	I2CRESTART
;I2CSend(DS_AddrRead)
	movlw	163
	movwf	I2CBYTE
	call	I2CSEND
;I2CReceive(DS_Date, ACK)              ;get date
	movlw	255
	movwf	I2CACK
	call	I2CRECEIVE
	movf	I2CBYTE,W
	movwf	DS_DATE
;DS_Date = BcdToDec(DS_Date)
	movwf	VA
	call	FN_BCDTODEC
	movf	BCDTODEC,W
	movwf	DS_DATE
;I2CReceive(DS_DOW, ACK)             ;get dow the week
	movlw	255
	movwf	I2CACK
	call	I2CRECEIVE
	movf	I2CBYTE,W
	movwf	DS_DOW
;DS_DOW = BcdToDec(DS_DOW)
	movwf	VA
	call	FN_BCDTODEC
	movf	BCDTODEC,W
	movwf	DS_DOW
;DS_DOW = ( DS_DOW and 7 ) + 1
	movlw	7
	andwf	DS_DOW,W
	movwf	SysTemp1
	incf	SysTemp1,W
	movwf	DS_DOW
;I2CReceive(DS_Month, ACK)            ;get month
	movlw	255
	movwf	I2CACK
	call	I2CRECEIVE
	movf	I2CBYTE,W
	movwf	DS_MONTH
;DS_Month.7 = 0
	bcf	DS_MONTH,7
;DS_Month = BcdToDec(DS_Month)
	movf	DS_MONTH,W
	movwf	VA
	call	FN_BCDTODEC
	movf	BCDTODEC,W
	movwf	DS_MONTH
;I2CReceive(DS_Year, NACK)       ;get year
	clrf	I2CACK
	call	I2CRECEIVE
	movf	I2CBYTE,W
	movwf	DS_YEAR
;DS_Year = BcdToDec(DS_Year)
	movwf	VA
	call	FN_BCDTODEC
	movf	BCDTODEC,W
	movwf	DS_YEAR
;I2CStop
	goto	I2CSTOP

;********************************************************************************

;Overloaded signature: STRING:
PRINT127
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

StringTable2
	retlw	7
	retlw	80	;P
	retlw	67	;C
	retlw	70	;F
	retlw	56	;8
	retlw	53	;5
	retlw	54	;6
	retlw	51	;3


StringTable3
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
	retlw	97	;a
	retlw	115	;s
	retlw	105	;i
	retlw	99	;c


;********************************************************************************


 END
