;Program compiled by Great Cow BASIC (0.98.<<>> 2020-04-09 (Windows 32 bit))
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F18855, r=DEC
#include <P16F18855.inc>
 __CONFIG _CONFIG1, _CLKOUTEN_OFF & _RSTOSC_HFINT32 & _FEXTOSC_OFF
 __CONFIG _CONFIG2, _MCLRE_OFF
 __CONFIG _CONFIG3, _WDTE_OFF
 __CONFIG _CONFIG4, _LVP_OFF
 __CONFIG _CONFIG5, _CPD_OFF & _CP_OFF

;********************************************************************************

;Set aside memory locations for variables
CCOUNT	EQU	32
CHARCODE	EQU	33
CHARCOL	EQU	34
CHARCOL_H	EQU	35
CHARLOCX	EQU	36
CHARLOCX_H	EQU	37
CHARLOCY	EQU	38
CHARLOCY_H	EQU	39
COLSPERFONT	EQU	40
CURRCHARCOL	EQU	41
CURRCHARROW	EQU	42
CURRCHARVAL	EQU	43
DDF_X	EQU	44
DDF_X_H	EQU	45
DDF_Y	EQU	46
DDF_Y_H	EQU	47
DELAYTEMP	EQU	112
DELAYTEMP2	EQU	113
DRAWLINE	EQU	48
DRAWLINE_H	EQU	49
FEATHERWINGREGISTER	EQU	50
FEATHERWINGREGISTER_E	EQU	53
FEATHERWINGREGISTER_H	EQU	51
FEATHERWINGREGISTER_U	EQU	52
FF	EQU	54
FF_H	EQU	55
FILLCIRCLEXX	EQU	56
FILLCIRCLEYY	EQU	57
GLCDBACKGROUND	EQU	58
GLCDBACKGROUND_H	EQU	59
GLCDCOLOUR	EQU	60
GLCDCOLOUR_H	EQU	61
GLCDDEVICEHEIGHT	EQU	62
GLCDDEVICEHEIGHT_H	EQU	63
GLCDDEVICEWIDTH	EQU	64
GLCDDEVICEWIDTH_H	EQU	65
GLCDFNTDEFAULT	EQU	66
GLCDFNTDEFAULTHEIGHT	EQU	67
GLCDFNTDEFAULTSIZE	EQU	68
GLCDFONTWIDTH	EQU	69
GLCDFOREGROUND	EQU	70
GLCDFOREGROUND_H	EQU	71
GLCDPIXELCOUNT	EQU	72
GLCDPIXELCOUNT_H	EQU	73
GLCDPRINTLEN	EQU	74
GLCDPRINTLOC	EQU	75
GLCDPRINTLOC_H	EQU	76
GLCDPRINT_STRING_COUNTER	EQU	77
GLCDROTATESTATE	EQU	78
GLCDTEMP	EQU	79
GLCDTEMP_H	EQU	80
GLCDX	EQU	81
GLCDY	EQU	82
GLCD_YORDINATE	EQU	83
GLCD_YORDINATE_H	EQU	84
HEX	EQU	9179
HI2CACKPOLLSTATE	EQU	85
HI2CCURRENTMODE	EQU	86
HI2CGETACK	EQU	87
HI2CWAITMSSPTIMEOUT	EQU	88
I2CBYTE	EQU	89
INXRADIUS	EQU	90
INXRADIUS_H	EQU	91
LCDVALUE	EQU	92
LCDVALUE_E	EQU	95
LCDVALUE_H	EQU	93
LCDVALUE_U	EQU	94
LINECOLOUR	EQU	96
LINECOLOUR_H	EQU	97
LINEDIFFX	EQU	98
LINEDIFFX_H	EQU	99
LINEDIFFX_X2	EQU	100
LINEDIFFX_X2_H	EQU	101
LINEDIFFY	EQU	102
LINEDIFFY_H	EQU	103
LINEDIFFY_X2	EQU	104
LINEDIFFY_X2_H	EQU	105
LINEERR	EQU	106
LINEERR_H	EQU	107
LINESTEPX	EQU	108
LINESTEPX_H	EQU	109
LINESTEPY	EQU	110
LINESTEPY_H	EQU	111
LINEX1	EQU	160
LINEX1_H	EQU	161
LINEX2	EQU	162
LINEX2_H	EQU	163
LINEY1	EQU	164
LINEY1_H	EQU	165
LINEY2	EQU	166
LINEY2_H	EQU	167
LOCALCHARCODE	EQU	168
LOCALCHARCODE_H	EQU	169
OLDFEATHERWINGREGISTER	EQU	170
OLDFEATHERWINGREGISTER_E	EQU	173
OLDFEATHERWINGREGISTER_H	EQU	171
OLDFEATHERWINGREGISTER_U	EQU	172
OLDGLCDFONTWIDTH	EQU	174
PRINTLOCX	EQU	175
PRINTLOCX_H	EQU	176
PRINTLOCY	EQU	177
PRINTLOCY_H	EQU	178
RADIUSERR	EQU	179
RADIUSERR_H	EQU	180
ROWSPERFONT	EQU	181
ST7735ADDRESSTYPE	EQU	182
ST7735END	EQU	183
ST7735END_H	EQU	184
ST7735SENDBYTE	EQU	185
ST7735SENDWORD	EQU	186
ST7735SENDWORD_H	EQU	187
ST7735START	EQU	188
ST7735START_H	EQU	189
STR	EQU	9183
STRINGPOINTER	EQU	190
SYSBYTETEMPA	EQU	117
SYSBYTETEMPB	EQU	121
SYSBYTETEMPX	EQU	112
SYSCALCTEMPA	EQU	117
SYSCALCTEMPA_E	EQU	120
SYSCALCTEMPA_H	EQU	118
SYSCALCTEMPA_U	EQU	119
SYSCALCTEMPX	EQU	112
SYSCALCTEMPX_H	EQU	113
SYSCHARCOUNT	EQU	191
SYSDIVLOOP	EQU	116
SYSDIVMULTA	EQU	119
SYSDIVMULTA_H	EQU	120
SYSDIVMULTB	EQU	123
SYSDIVMULTB_H	EQU	124
SYSDIVMULTX	EQU	114
SYSDIVMULTX_H	EQU	115
SYSINTEGERTEMPA	EQU	117
SYSINTEGERTEMPA_H	EQU	118
SYSINTEGERTEMPB	EQU	121
SYSINTEGERTEMPB_H	EQU	122
SYSINTEGERTEMPX	EQU	112
SYSINTEGERTEMPX_H	EQU	113
SYSLCDPRINTDATAHANDLER	EQU	192
SYSLCDPRINTDATAHANDLER_H	EQU	193
SYSLONGDIVMULTA	EQU	194
SYSLONGDIVMULTA_E	EQU	197
SYSLONGDIVMULTA_H	EQU	195
SYSLONGDIVMULTA_U	EQU	196
SYSLONGDIVMULTB	EQU	198
SYSLONGDIVMULTB_E	EQU	201
SYSLONGDIVMULTB_H	EQU	199
SYSLONGDIVMULTB_U	EQU	200
SYSLONGDIVMULTX	EQU	202
SYSLONGDIVMULTX_E	EQU	205
SYSLONGDIVMULTX_H	EQU	203
SYSLONGDIVMULTX_U	EQU	204
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
SYSPRINTBUFFER	EQU	9189
SYSPRINTBUFFLEN	EQU	206
SYSREPEATTEMP1	EQU	207
SYSREPEATTEMP1_H	EQU	208
SYSREPEATTEMP2	EQU	209
SYSREPEATTEMP2_H	EQU	210
SYSREPEATTEMP3	EQU	211
SYSREPEATTEMP4	EQU	212
SYSREPEATTEMP5	EQU	213
SYSSIGNBYTE	EQU	125
SYSSTRDATA	EQU	214
SYSSTRINGA	EQU	119
SYSSTRINGA_H	EQU	120
SYSSTRINGTEMP	EQU	215
SYSTEMP1	EQU	216
SYSTEMP1_E	EQU	219
SYSTEMP1_H	EQU	217
SYSTEMP1_U	EQU	218
SYSTEMP2	EQU	220
SYSTEMP2_H	EQU	221
SYSTEMP3	EQU	222
SYSTEMP3_H	EQU	223
SYSVALTEMP	EQU	224
SYSVALTEMP_H	EQU	225
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
XOFFSET	EQU	226
XOFFSET_H	EQU	227
XRADIUS	EQU	228
XRADIUS_H	EQU	229
YCALC1	EQU	230
YCALC1_H	EQU	231
YCALC2	EQU	232
YCALC2_H	EQU	233
YOFFSET	EQU	234
YOFFSET_H	EQU	235
YORDINATE	EQU	236

;********************************************************************************

;Alias variables
AFSR0	EQU	4
AFSR0_H	EQU	5
FOURTH_BYTE	EQU	53
SYSHEX_0	EQU	1595
SYSHEX_1	EQU	1596
SYSHEX_2	EQU	1597
SYSSTR_0	EQU	1599
THIRD_BYTE	EQU	52
BUTTON_ABS	EQU	51
BUTTON_XY	EQU	50

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
	call	INITGLCD_ST7735
	call	INITGLCD_ST7735R
	pagesel	$

;Start of the main program
;Generated by PIC PPS Tool for Great Cow Basic
;PPS Tool version: 0.0.5.2
;PinManager data: 09/02/2017
;
;Template comment at the start of the config file
;
;Template comment at the end of the config file
;#DEFINE USART_BAUD_RATE 19200
;#DEFINE USART_TX_BLOCKING
;----- Define Hardware settings for hwi2c
;Define I2C settings - CHANGE PORTS if required for your specific device.
;#DEFINE hi2c_BAUD_RATE 400
;#DEFINE hi2c_DATA PORTC.3
;#DEFINE hi2c_CLOCK PORTC.4
;Initialise I2C Master
;I2C pins need to be input for SSP2 module
;Dir hi2c_DATA In
	bsf	TRISC,3
;Dir hi2c_CLOCK In
	bsf	TRISC,4
;HI2CMode Master
	movlw	12
	movwf	HI2CCURRENTMODE
	pagesel	HI2CMODE
	call	HI2CMODE
	pagesel	$
;#define GLCD_TYPE GLCD_TYPE_ST7735R_160_80
;'''   #define ST7735R_HardwareSPI     ' remove comment out if you want to use software SPI.
;#define ST7735TABCOLOR ST7735_GREENTAB  ' can be ST7735_BLACKTAB, ST7735_GREENTAB or ST7735_REDTAB.  Each tab is a different ST7735 configuration.
;you may have to try all three - if you do not know what chipset you have.
;Pin mappings for SPI
;#define GLCD_DC         portC.2              'Data/Command select
;#define GLCD_CS         portB.2              'CS Chip select
;#define GLCD_RESET      portB.1              'RESET
;#define GLCD_DO         portB.5              'SPI SDO (MOSI)
;#define GLCD_DI         portB.5              'SPI SDI (MISO)  assume bi-directional DO/DI
;#define GLCD_SCK        portB.3              'SPI SCK
;GLCDRotate ( Landscape )
	movlw	1
	movwf	GLCDROTATESTATE
	pagesel	GLCDROTATE_ST7735
	call	GLCDROTATE_ST7735
	pagesel	$
;GLCDPrint (4, 0, "Great", TFT_YELLOW )
	movlw	4
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	clrf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable1
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable1) | 128
	movwf	SysLCDPRINTDATAHandler_H
	movlw	224
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	movlw	255
	movwf	LINECOLOUR_H
	pagesel	GLCDPRINT5
	call	GLCDPRINT5
	pagesel	$
;GLCDForeground = TFT_GREEN
	movlw	224
	movwf	GLCDFOREGROUND
	movlw	7
	movwf	GLCDFOREGROUND_H
;GLCDPrintString (" Cow")
	movlw	low StringTable2
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable2) | 128
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	pagesel	GLCDPRINTSTRING
	call	GLCDPRINTSTRING
	pagesel	$
;GLCDForeground = TFT_WHITE
	movlw	255
	movwf	GLCDFOREGROUND
	movwf	GLCDFOREGROUND_H
;GLCDPrintString ( " BASIC 2020" )
	movlw	low StringTable3
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable3) | 128
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	pagesel	GLCDPRINTSTRING
	call	GLCDPRINTSTRING
	pagesel	$
;Circle  80,40, 10
	movlw	80
	banksel	XOFFSET
	movwf	XOFFSET
	clrf	XOFFSET_H
	movlw	40
	movwf	YOFFSET
	clrf	YOFFSET_H
	movlw	10
	banksel	INXRADIUS
	movwf	INXRADIUS
	clrf	INXRADIUS_H
	movf	GLCDFOREGROUND,W
	movwf	LINECOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	LINECOLOUR_H
	movf	GLCD_YORDINATE,W
	banksel	YORDINATE
	movwf	YORDINATE
	banksel	STATUS
	pagesel	CIRCLE
	call	CIRCLE
	pagesel	$
;FilledCircle  80,40, 9, TFT_RED
	movlw	80
	banksel	XOFFSET
	movwf	XOFFSET
	clrf	XOFFSET_H
	movlw	40
	movwf	YOFFSET
	clrf	YOFFSET_H
	movlw	9
	movwf	XRADIUS
	clrf	XRADIUS_H
	banksel	LINECOLOUR
	clrf	LINECOLOUR
	movlw	248
	movwf	LINECOLOUR_H
	call	FILLEDCIRCLE
;#define MiniTFT_WRITEADDR 188 ;0xBC
;#define MiniTFT_READADDR 189 ;0xBD
;#define Module_Base_Address_GPIO 1 ;GPIO = 1  Pg 21 of Seesaw Tutorial
;#define GPIO_BULK 4 ;GPIO = 4 Reading this register reads all pins on PORTA of the seesaw device.
;Buttons
;#define DirClr_GPIO 3 ;0x03 Pg 22 of Seesaw Tutorial - Writing a 1 to any bit in this register sets the direction of the corresponding pin to INPUT.
;#define PullenSet_GPIO 11 ;0x0B Pg 23 of Seesaw Tutorial - Writing a 1 to any bit in this register enables the internal pullup or pulldown on the corresponding pin.
;#define Set_FunctionReg 5 ;Writing a 1 to any bit in this register writes the corresponding pin HIGH. pg 22
;#define Module_Base_Address_AD 9 ;AD = 9  Pg 24 of Seesaw Tutorial
;#define Module_function_register_address_AD0 7 ;PA02_A0 AD  = 7
;#define Module_function_register_address_AD1 8 ;PA03_A1 AD  = 8
;dim FeatherWingRegister, oldFeatherWingRegister as long
;dim Fourth_Byte as byte alias FeatherWingRegister_e
;dim Third_Byte  as byte alias FeatherWingRegister_u
;dim Button_ABS  as byte alias FeatherWingRegister_h
;dim Button_XY   as byte alias FeatherWingRegister
;dim ccount as byte
;#Define FEATHERWING_BUTTON_A  Button_ABS.2
;Wait 2 s
	movlw	2
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
;GLCDCLS
	pagesel	GLCDCLS_ST7735
	call	GLCDCLS_ST7735
	pagesel	$
;ccount = 0
	clrf	CCOUNT
;#DEFINE GLCD_OLED_FONT
;oldFeatherWingRegister = 0xffff
	movlw	255
	banksel	OLDFEATHERWINGREGISTER
	movwf	OLDFEATHERWINGREGISTER
	movwf	OLDFEATHERWINGREGISTER_H
	clrf	OLDFEATHERWINGREGISTER_U
	clrf	OLDFEATHERWINGREGISTER_E
;box 0, 5, 158, 79
	clrf	LINEX1
	clrf	LINEX1_H
	movlw	5
	movwf	LINEY1
	clrf	LINEY1_H
	movlw	158
	movwf	LINEX2
	clrf	LINEX2_H
	movlw	79
	movwf	LINEY2
	clrf	LINEY2_H
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	movwf	LINECOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	LINECOLOUR_H
	pagesel	BOX
	call	BOX
	pagesel	$
;filledbox 33,1,132,7, GLCDBackground
	movlw	33
	banksel	LINEX1
	movwf	LINEX1
	movlw	1
	movwf	LINEY1
	movlw	132
	movwf	LINEX2
	movlw	7
	movwf	LINEY2
	banksel	GLCDBACKGROUND
	movf	GLCDBACKGROUND,W
	movwf	LINECOLOUR
	movf	GLCDBACKGROUND_H,W
	movwf	LINECOLOUR_H
	pagesel	FILLEDBOX_ST7735
	call	FILLEDBOX_ST7735
	pagesel	$
;GLCDPrint(35, 1, "ADAFRUIT MINI COLOR TFT", TFT_WHITE )
	movlw	35
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	1
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable4
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable4) | 128
	movwf	SysLCDPRINTDATAHandler_H
	movlw	255
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	movwf	LINECOLOUR_H
	pagesel	GLCDPRINT5
	call	GLCDPRINT5
	pagesel	$
;GLCDPrint(30, 9,  "WITH JOYSTICK FEATHERWING", TFT_WHITE )
	movlw	30
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	9
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable5
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable5) | 128
	movwf	SysLCDPRINTDATAHandler_H
	movlw	255
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	movwf	LINECOLOUR_H
	pagesel	GLCDPRINT5
	call	GLCDPRINT5
	pagesel	$
;GLCDPrint(4, 16, "Button A", TFT_RED )
	movlw	4
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	16
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable6
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable6) | 128
	movwf	SysLCDPRINTDATAHandler_H
	banksel	LINECOLOUR
	clrf	LINECOLOUR
	movlw	248
	movwf	LINECOLOUR_H
	pagesel	GLCDPRINT5
	call	GLCDPRINT5
	pagesel	$
;GLCDPrint(4, 24, "Button B", TFT_RED )
	movlw	4
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	24
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable7
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable7) | 128
	movwf	SysLCDPRINTDATAHandler_H
	banksel	LINECOLOUR
	clrf	LINECOLOUR
	movlw	248
	movwf	LINECOLOUR_H
	pagesel	GLCDPRINT5
	call	GLCDPRINT5
	pagesel	$
;GLCDPrint(4, 32, "Select", TFT_GREEN )
	movlw	4
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	32
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable8
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable8) | 128
	movwf	SysLCDPRINTDATAHandler_H
	movlw	224
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	movlw	7
	movwf	LINECOLOUR_H
	pagesel	GLCDPRINT5
	call	GLCDPRINT5
	pagesel	$
;GLCDPrint(4, 40, "Up  ", TFT_GREEN )
	movlw	4
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	40
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable9
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable9) | 128
	movwf	SysLCDPRINTDATAHandler_H
	movlw	224
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	movlw	7
	movwf	LINECOLOUR_H
	pagesel	GLCDPRINT5
	call	GLCDPRINT5
	pagesel	$
;GLCDPrint(4, 48, "Left  ", TFT_GREEN )
	movlw	4
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	48
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable10
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable10) | 128
	movwf	SysLCDPRINTDATAHandler_H
	movlw	224
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	movlw	7
	movwf	LINECOLOUR_H
	pagesel	GLCDPRINT5
	call	GLCDPRINT5
	pagesel	$
;GLCDPrint(4, 56, "Down", TFT_GREEN )
	movlw	4
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	56
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable11
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable11) | 128
	movwf	SysLCDPRINTDATAHandler_H
	movlw	224
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	movlw	7
	movwf	LINECOLOUR_H
	pagesel	GLCDPRINT5
	call	GLCDPRINT5
	pagesel	$
;GLCDPrint(4, 64, "Right  ", TFT_GREEN )
	movlw	4
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	64
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable12
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable12) | 128
	movwf	SysLCDPRINTDATAHandler_H
	movlw	224
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	movlw	7
	movwf	LINECOLOUR_H
	pagesel	GLCDPRINT5
	call	GLCDPRINT5
	pagesel	$
;DO
SysDoLoop_S1
;Button B problem occurs AFTER it prints "Button B" on the GLCD.  i.e. it happens after the HI2C WRITES or READ. The LCD still works properly.
;HI2CStart
	banksel	STATUS
	pagesel	HI2CSTART
	call	HI2CSTART
	pagesel	$
;HI2CSend MiniTFT_WRITEADDR
	movlw	188
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CSend Module_Base_Address_GPIO
	movlw	1
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CSend DirClr_GPIO
	movlw	3
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CSend 211 ;Writing a 1 to any bit in this register sets the direction of the corresponding pin to INPUT.
	movlw	211
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CSend 195 ;Writing zeros to this register has no effect.
	movlw	195
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CSend 207 ;PA15:PA08 = 1100 1111 - Pin 12 to Pin 7
	movlw	207
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CSend 220 ;PA07:PA02 = 1101 1100 - Pin 6 to Pin 1   LSB
	movlw	220
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
;HI2CStop
;HI2CStart
	pagesel	HI2CSTART
	call	HI2CSTART
	pagesel	$
;HI2CSend MiniTFT_WRITEADDR
	movlw	188
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CSend Module_Base_Address_GPIO ;Writing a 1 to any bit in this register enables the internal pullup or pulldown on the corresponding pin. The pull direction
	movlw	1
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CSend PullenSet_GPIO ;(up/down) is determined by the GPIO (output) value - if the corresponding GPIO register bit is low, its a pulldown. High, its a pullup.
	movlw	11
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CSend 211
	movlw	211
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CSend 195
	movlw	195
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CSend 207
	movlw	207
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CSend 220
	movlw	220
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
;HI2CStop
;HI2CStart
	pagesel	HI2CSTART
	call	HI2CSTART
	pagesel	$
;HI2CSend MiniTFT_WRITEADDR
	movlw	188
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CSend Module_Base_Address_GPIO ;Writing a 1 to any bit in this register writes the corresponding pin HIGH.  Writing zeros to this register has no effect.
	movlw	1
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CSend Set_FunctionReg
	movlw	5
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CSend 211
	movlw	211
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CSend 195
	movlw	195
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CSend 207
	movlw	207
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CSend 220
	movlw	220
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
;HI2CStop
;HI2CStart
	pagesel	HI2CSTART
	call	HI2CSTART
	pagesel	$
;HI2CSend MiniTFT_WRITEADDR
	movlw	188
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CSend Module_Base_Address_GPIO
	movlw	1
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CSend GPIO_BULK ;Reading this register reads all pins on PORTA of the seesaw device.
	movlw	4
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
;HI2CRestart
	pagesel	HI2CRESTART
	call	HI2CRESTART
	pagesel	$
;HI2CSend MiniTFT_READADDR
	movlw	189
	movwf	I2CBYTE
	pagesel	HI2CSEND
	call	HI2CSEND
	pagesel	$
;HI2CReceive Fourth_Byte ;Bits [31:24] MSB      Seems like BIG_ENDIAN is being used - Data sheet says LITTLE_ENDIAN ????????????
	movlw	1
	movwf	HI2CGETACK
	pagesel	HI2CRECEIVE
	call	HI2CRECEIVE
	pagesel	$
	movf	I2CBYTE,W
	movwf	FOURTH_BYTE
;HI2CReceive Third_Byte ;Bits [23:16]         I show bit order as if it is BIG ENDIAN
	movlw	1
	movwf	HI2CGETACK
	pagesel	HI2CRECEIVE
	call	HI2CRECEIVE
	pagesel	$
	movf	I2CBYTE,W
	movwf	THIRD_BYTE
;HI2CReceive Button_ABS ;Bits [15:8]
	movlw	1
	movwf	HI2CGETACK
	pagesel	HI2CRECEIVE
	call	HI2CRECEIVE
	pagesel	$
	movf	I2CBYTE,W
	movwf	BUTTON_ABS
;HI2CReceive Button_XY, Nack ;Bits [7:0] LSB
	clrf	HI2CGETACK
	pagesel	HI2CRECEIVE
	call	HI2CRECEIVE
	pagesel	$
	movf	I2CBYTE,W
	movwf	BUTTON_XY
;HI2CStop
	pagesel	HI2CSTOP
	call	HI2CSTOP
	pagesel	$
;if [word]FeatherWingRegister <>  [word]oldFeatherWingRegister then
	movf	FEATHERWINGREGISTER,W
	movwf	SysWORDTempA
	movf	FEATHERWINGREGISTER_H,W
	movwf	SysWORDTempA_H
	banksel	OLDFEATHERWINGREGISTER
	movf	OLDFEATHERWINGREGISTER,W
	movwf	SysWORDTempB
	movf	OLDFEATHERWINGREGISTER_H,W
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF1
;GLCDPrint(100, 16, hex(FeatherWingRegister_E) )
	movlw	100
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	16
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	banksel	FEATHERWINGREGISTER_E
	movf	FEATHERWINGREGISTER_E,W
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler
	movlw	high HEX
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	pagesel	GLCDPRINT4
	call	GLCDPRINT4
	pagesel	$
;GLCDPrintString hex(FeatherWingRegister_U)
	movf	FEATHERWINGREGISTER_U,W
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler
	movlw	high HEX
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	pagesel	GLCDPRINTSTRING
	call	GLCDPRINTSTRING
	pagesel	$
;GLCDPrintString hex(FeatherWingRegister_h)
	movf	FEATHERWINGREGISTER_H,W
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler
	movlw	high HEX
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	pagesel	GLCDPRINTSTRING
	call	GLCDPRINTSTRING
	pagesel	$
;GLCDPrintString hex(FeatherWingRegister)
	movf	FEATHERWINGREGISTER,W
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler
	movlw	high HEX
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	pagesel	GLCDPRINTSTRING
	call	GLCDPRINTSTRING
	pagesel	$
;GLCDPrint(100, 25, hex(oldFeatherWingRegister_E) )
	movlw	100
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	25
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movf	OLDFEATHERWINGREGISTER_E,W
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler
	movlw	high HEX
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	pagesel	GLCDPRINT4
	call	GLCDPRINT4
	pagesel	$
;GLCDPrintString hex(oldFeatherWingRegister_U)
	banksel	OLDFEATHERWINGREGISTER_U
	movf	OLDFEATHERWINGREGISTER_U,W
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler
	movlw	high HEX
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	pagesel	GLCDPRINTSTRING
	call	GLCDPRINTSTRING
	pagesel	$
;GLCDPrintString hex(oldFeatherWingRegister_h)
	banksel	OLDFEATHERWINGREGISTER_H
	movf	OLDFEATHERWINGREGISTER_H,W
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler
	movlw	high HEX
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	pagesel	GLCDPRINTSTRING
	call	GLCDPRINTSTRING
	pagesel	$
;GLCDPrintString hex(oldFeatherWingRegister)
	banksel	OLDFEATHERWINGREGISTER
	movf	OLDFEATHERWINGREGISTER,W
	movwf	SYSVALTEMP
	banksel	STATUS
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler
	movlw	high HEX
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	pagesel	GLCDPRINTSTRING
	call	GLCDPRINTSTRING
	pagesel	$
;Button A
;GLCDLocateString 66, 3
	movlw	66
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	3
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	banksel	STATUS
	pagesel	GLCDLOCATESTRING
	call	GLCDLOCATESTRING
	pagesel	$
;GLCDPrintString str(FEATHERWING_BUTTON_A)
	banksel	SYSVALTEMP
	clrf	SYSVALTEMP
	clrf	SYSVALTEMP_H
	banksel	BUTTON_ABS
	btfss	BUTTON_ABS,2
	goto	ENDIF2
	banksel	SYSVALTEMP
	incf	SYSVALTEMP,F
ENDIF2
	banksel	STATUS
	pagesel	FN_STR
	call	FN_STR
	pagesel	$
	movlw	low STR
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler
	movlw	high STR
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	pagesel	GLCDPRINTSTRING
	call	GLCDPRINTSTRING
	pagesel	$
;Button B
;GLCDLocateString 66, 4
	movlw	66
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	4
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	banksel	STATUS
	pagesel	GLCDLOCATESTRING
	call	GLCDLOCATESTRING
	pagesel	$
;GLCDPrintString str(Button_ABS.1)
	banksel	SYSVALTEMP
	clrf	SYSVALTEMP
	clrf	SYSVALTEMP_H
	banksel	BUTTON_ABS
	btfss	BUTTON_ABS,1
	goto	ENDIF3
	banksel	SYSVALTEMP
	incf	SYSVALTEMP,F
ENDIF3
	banksel	STATUS
	pagesel	FN_STR
	call	FN_STR
	pagesel	$
	movlw	low STR
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler
	movlw	high STR
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	pagesel	GLCDPRINTSTRING
	call	GLCDPRINTSTRING
	pagesel	$
;Select
;GLCDLocateString 66, 5
	movlw	66
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	5
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	banksel	STATUS
	pagesel	GLCDLOCATESTRING
	call	GLCDLOCATESTRING
	pagesel	$
;GLCDPrintString str(Button_ABS.3)
	banksel	SYSVALTEMP
	clrf	SYSVALTEMP
	clrf	SYSVALTEMP_H
	banksel	BUTTON_ABS
	btfss	BUTTON_ABS,3
	goto	ENDIF4
	banksel	SYSVALTEMP
	incf	SYSVALTEMP,F
ENDIF4
	banksel	STATUS
	pagesel	FN_STR
	call	FN_STR
	pagesel	$
	movlw	low STR
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler
	movlw	high STR
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	pagesel	GLCDPRINTSTRING
	call	GLCDPRINTSTRING
	pagesel	$
;Up
;GLCDLocateString 66, 6
	movlw	66
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	6
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	banksel	STATUS
	pagesel	GLCDLOCATESTRING
	call	GLCDLOCATESTRING
	pagesel	$
;GLCDPrintString str(Button_XY.2)
	banksel	SYSVALTEMP
	clrf	SYSVALTEMP
	clrf	SYSVALTEMP_H
	banksel	BUTTON_XY
	btfss	BUTTON_XY,2
	goto	ENDIF5
	banksel	SYSVALTEMP
	incf	SYSVALTEMP,F
ENDIF5
	banksel	STATUS
	pagesel	FN_STR
	call	FN_STR
	pagesel	$
	movlw	low STR
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler
	movlw	high STR
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	pagesel	GLCDPRINTSTRING
	call	GLCDPRINTSTRING
	pagesel	$
;GLCDLocateString 66, 7
	movlw	66
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	7
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	banksel	STATUS
	pagesel	GLCDLOCATESTRING
	call	GLCDLOCATESTRING
	pagesel	$
;GLCDPrintString str(Button_XY.3)
	banksel	SYSVALTEMP
	clrf	SYSVALTEMP
	clrf	SYSVALTEMP_H
	banksel	BUTTON_XY
	btfss	BUTTON_XY,3
	goto	ENDIF6
	banksel	SYSVALTEMP
	incf	SYSVALTEMP,F
ENDIF6
	banksel	STATUS
	pagesel	FN_STR
	call	FN_STR
	pagesel	$
	movlw	low STR
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler
	movlw	high STR
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	pagesel	GLCDPRINTSTRING
	call	GLCDPRINTSTRING
	pagesel	$
;GLCDLocateString 66, 8
	movlw	66
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	8
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	banksel	STATUS
	pagesel	GLCDLOCATESTRING
	call	GLCDLOCATESTRING
	pagesel	$
;GLCDPrintString str(Button_XY.4)
	banksel	SYSVALTEMP
	clrf	SYSVALTEMP
	clrf	SYSVALTEMP_H
	banksel	BUTTON_XY
	btfss	BUTTON_XY,4
	goto	ENDIF7
	banksel	SYSVALTEMP
	incf	SYSVALTEMP,F
ENDIF7
	banksel	STATUS
	pagesel	FN_STR
	call	FN_STR
	pagesel	$
	movlw	low STR
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler
	movlw	high STR
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	pagesel	GLCDPRINTSTRING
	call	GLCDPRINTSTRING
	pagesel	$
;GLCDLocateString 66, 9
	movlw	66
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	9
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	banksel	STATUS
	pagesel	GLCDLOCATESTRING
	call	GLCDLOCATESTRING
	pagesel	$
;GLCDPrintString str(Button_XY.7)
	banksel	SYSVALTEMP
	clrf	SYSVALTEMP
	clrf	SYSVALTEMP_H
	banksel	BUTTON_XY
	btfss	BUTTON_XY,7
	goto	ENDIF8
	banksel	SYSVALTEMP
	incf	SYSVALTEMP,F
ENDIF8
	banksel	STATUS
	pagesel	FN_STR
	call	FN_STR
	pagesel	$
	movlw	low STR
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler
	movlw	high STR
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	pagesel	GLCDPRINTSTRING
	call	GLCDPRINTSTRING
	pagesel	$
;FilledBox 100,66, 130, 78, GLCDBackground
	movlw	100
	banksel	LINEX1
	movwf	LINEX1
	movlw	66
	movwf	LINEY1
	movlw	130
	movwf	LINEX2
	movlw	78
	movwf	LINEY2
	banksel	GLCDBACKGROUND
	movf	GLCDBACKGROUND,W
	movwf	LINECOLOUR
	movf	GLCDBACKGROUND_H,W
	movwf	LINECOLOUR_H
	pagesel	FILLEDBOX_ST7735
	call	FILLEDBOX_ST7735
	pagesel	$
;GLCDPrint 100,66, ccount
	movlw	100
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	66
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	banksel	CCOUNT
	movf	CCOUNT,W
	movwf	LCDVALUE
	clrf	LCDVALUE_H
	clrf	LCDVALUE_U
	clrf	LCDVALUE_E
	pagesel	GLCDPRINT7
	call	GLCDPRINT7
	pagesel	$
;ccount++
	incf	CCOUNT,F
;oldFeatherWingRegister = [word]FeatherWingRegister
	movf	FEATHERWINGREGISTER,W
	banksel	OLDFEATHERWINGREGISTER
	movwf	OLDFEATHERWINGREGISTER
	banksel	FEATHERWINGREGISTER_H
	movf	FEATHERWINGREGISTER_H,W
	banksel	OLDFEATHERWINGREGISTER_H
	movwf	OLDFEATHERWINGREGISTER_H
	clrf	OLDFEATHERWINGREGISTER_U
	clrf	OLDFEATHERWINGREGISTER_E
;End if
ENDIF1
;LOOP
	goto	SysDoLoop_S1
SysDoLoop_E1
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

;********************************************************************************

;Source: glcd.h (1520)
FILLEDCIRCLE
;Circle fill Code is merely a modification of the midpoint
;circle algorithem which is an adaption of Bresenham's line algorithm
;http://en.wikipedia.org/wiki/Midpoint_circle_algorithm
;http://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm
;dim ff, ddF_x, ddF_y as integer
;dim YCalc2, YCalc1 as word
;ff = 1 - xradius
	banksel	XRADIUS
	movf	XRADIUS,W
	sublw	1
	banksel	FF
	movwf	FF
	movlw	0
	banksel	SYSTEMP1
	movwf	SysTemp1
	movf	XRADIUS_H,W
	subwfb	SysTemp1,W
	banksel	FF_H
	movwf	FF_H
;ddF_x = 1
	movlw	1
	movwf	DDF_X
	clrf	DDF_X_H
;ddF_y = -2 * xradius
	banksel	XRADIUS
	movf	XRADIUS,W
	movwf	SysINTEGERTempA
	movf	XRADIUS_H,W
	movwf	SysINTEGERTempA_H
	movlw	254
	movwf	SysINTEGERTempB
	movlw	255
	movwf	SysINTEGERTempB_H
	banksel	STATUS
	pagesel	SysMultSubINT
	call	SysMultSubINT
	pagesel	$
	movf	SysINTEGERTempX,W
	movwf	DDF_Y
	movf	SysINTEGERTempX_H,W
	movwf	DDF_Y_H
;FillCircleXX = 0
	clrf	FILLCIRCLEXX
;FillCircleYY = xradius
	banksel	XRADIUS
	movf	XRADIUS,W
	banksel	FILLCIRCLEYY
	movwf	FILLCIRCLEYY
;Fill in the center between the two halves
;YCalc2 = yoffset+xradius
	banksel	XRADIUS
	movf	XRADIUS,W
	addwf	YOFFSET,W
	movwf	YCALC2
	movf	XRADIUS_H,W
	addwfc	YOFFSET_H,W
	movwf	YCALC2_H
;YCalc1 = yoffset-xradius
	movf	XRADIUS,W
	subwf	YOFFSET,W
	movwf	YCALC1
	movf	XRADIUS_H,W
	subwfb	YOFFSET_H,W
	movwf	YCALC1_H
;Line( xoffset, YCalc1 , xoffset, YCalc2, LineColour)
	movf	XOFFSET,W
	movwf	LINEX1
	movf	XOFFSET_H,W
	movwf	LINEX1_H
	movf	YCALC1,W
	movwf	LINEY1
	movf	YCALC1_H,W
	movwf	LINEY1_H
	movf	XOFFSET,W
	movwf	LINEX2
	movf	XOFFSET_H,W
	movwf	LINEX2_H
	movf	YCALC2,W
	movwf	LINEY2
	movf	YCALC2_H,W
	movwf	LINEY2_H
	banksel	STATUS
	pagesel	LINE
	call	LINE
	pagesel	$
;do while (FillCircleXX < FillCircleYY)
SysDoLoop_S4
	movf	FILLCIRCLEYY,W
	subwf	FILLCIRCLEXX,W
	btfsc	STATUS, C
	goto	SysDoLoop_E4
;if ff >= 0 then
	movf	FF,W
	movwf	SysINTEGERTempA
	movf	FF_H,W
	movwf	SysINTEGERTempA_H
	clrf	SysINTEGERTempB
	clrf	SysINTEGERTempB_H
	pagesel	SysCompLessThanINT
	call	SysCompLessThanINT
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF25
;FillCircleYY--
	decf	FILLCIRCLEYY,F
;ddF_y += 2
	movlw	2
	addwf	DDF_Y,F
	movlw	0
	addwfc	DDF_Y_H,F
;ff += ddF_y
	movf	DDF_Y,W
	addwf	FF,F
	movf	DDF_Y_H,W
	addwfc	FF_H,F
;end if
ENDIF25
;FillCircleXX++
	incf	FILLCIRCLEXX,F
;ddF_x += 2
	movlw	2
	addwf	DDF_X,F
	movlw	0
	addwfc	DDF_X_H,F
;ff += ddF_x
	movf	DDF_X,W
	addwf	FF,F
	movf	DDF_X_H,W
	addwfc	FF_H,F
;Now draw vertical lines between the points on the circle rather than
;draw the points of the circle. This draws lines between the
;perimeter points on the upper and lower quadrants of the 2 halves of the circle.
;Line(xoffset+FillCircleXX, yoffset+FillCircleYY, xoffset+FillCircleXX, yoffset-FillCircleYY, LineColour);
	movf	FILLCIRCLEXX,W
	banksel	XOFFSET
	addwf	XOFFSET,W
	movwf	LINEX1
	movlw	0
	addwfc	XOFFSET_H,W
	movwf	LINEX1_H
	banksel	FILLCIRCLEYY
	movf	FILLCIRCLEYY,W
	banksel	YOFFSET
	addwf	YOFFSET,W
	movwf	LINEY1
	movlw	0
	addwfc	YOFFSET_H,W
	movwf	LINEY1_H
	banksel	FILLCIRCLEXX
	movf	FILLCIRCLEXX,W
	banksel	XOFFSET
	addwf	XOFFSET,W
	movwf	LINEX2
	movlw	0
	addwfc	XOFFSET_H,W
	movwf	LINEX2_H
	banksel	FILLCIRCLEYY
	movf	FILLCIRCLEYY,W
	banksel	YOFFSET
	subwf	YOFFSET,W
	movwf	LINEY2
	movlw	0
	subwfb	YOFFSET_H,W
	movwf	LINEY2_H
	banksel	STATUS
	pagesel	LINE
	call	LINE
	pagesel	$
;Line(xoffset-FillCircleXX, yoffset+FillCircleYY, xoffset-FillCircleXX, yoffset-FillCircleYY, LineColour);
	movf	FILLCIRCLEXX,W
	banksel	XOFFSET
	subwf	XOFFSET,W
	movwf	LINEX1
	movlw	0
	subwfb	XOFFSET_H,W
	movwf	LINEX1_H
	banksel	FILLCIRCLEYY
	movf	FILLCIRCLEYY,W
	banksel	YOFFSET
	addwf	YOFFSET,W
	movwf	LINEY1
	movlw	0
	addwfc	YOFFSET_H,W
	movwf	LINEY1_H
	banksel	FILLCIRCLEXX
	movf	FILLCIRCLEXX,W
	banksel	XOFFSET
	subwf	XOFFSET,W
	movwf	LINEX2
	movlw	0
	subwfb	XOFFSET_H,W
	movwf	LINEX2_H
	banksel	FILLCIRCLEYY
	movf	FILLCIRCLEYY,W
	banksel	YOFFSET
	subwf	YOFFSET,W
	movwf	LINEY2
	movlw	0
	subwfb	YOFFSET_H,W
	movwf	LINEY2_H
	banksel	STATUS
	pagesel	LINE
	call	LINE
	pagesel	$
;Line(xoffset+FillCircleYY, yoffset+FillCircleXX, FillCircleYY+xoffset, yoffset-FillCircleXX, LineColour);
	movf	FILLCIRCLEYY,W
	banksel	XOFFSET
	addwf	XOFFSET,W
	movwf	LINEX1
	movlw	0
	addwfc	XOFFSET_H,W
	movwf	LINEX1_H
	banksel	FILLCIRCLEXX
	movf	FILLCIRCLEXX,W
	banksel	YOFFSET
	addwf	YOFFSET,W
	movwf	LINEY1
	movlw	0
	addwfc	YOFFSET_H,W
	movwf	LINEY1_H
	movf	XOFFSET,W
	banksel	FILLCIRCLEYY
	addwf	FILLCIRCLEYY,W
	banksel	LINEX2
	movwf	LINEX2
	clrf	SysTemp1
	movf	XOFFSET_H,W
	addwfc	SysTemp1,W
	movwf	LINEX2_H
	banksel	FILLCIRCLEXX
	movf	FILLCIRCLEXX,W
	banksel	YOFFSET
	subwf	YOFFSET,W
	movwf	LINEY2
	movlw	0
	subwfb	YOFFSET_H,W
	movwf	LINEY2_H
	banksel	STATUS
	pagesel	LINE
	call	LINE
	pagesel	$
;Line(xoffset-FillCircleYY, yoffset+FillCircleXX, xoffset-FillCircleYY, yoffset-FillCircleXX, LineColour);
	movf	FILLCIRCLEYY,W
	banksel	XOFFSET
	subwf	XOFFSET,W
	movwf	LINEX1
	movlw	0
	subwfb	XOFFSET_H,W
	movwf	LINEX1_H
	banksel	FILLCIRCLEXX
	movf	FILLCIRCLEXX,W
	banksel	YOFFSET
	addwf	YOFFSET,W
	movwf	LINEY1
	movlw	0
	addwfc	YOFFSET_H,W
	movwf	LINEY1_H
	banksel	FILLCIRCLEYY
	movf	FILLCIRCLEYY,W
	banksel	XOFFSET
	subwf	XOFFSET,W
	movwf	LINEX2
	movlw	0
	subwfb	XOFFSET_H,W
	movwf	LINEX2_H
	banksel	FILLCIRCLEXX
	movf	FILLCIRCLEXX,W
	banksel	YOFFSET
	subwf	YOFFSET,W
	movwf	LINEY2
	movlw	0
	subwfb	YOFFSET_H,W
	movwf	LINEY2_H
	banksel	STATUS
	pagesel	LINE
	call	LINE
	pagesel	$
;loop
	goto	SysDoLoop_S4
SysDoLoop_E4
	return

;********************************************************************************

;Source: hwi2c.h (695)
HIC2INIT
;asm showdebug  This method sets the variable `HI2CCurrentMode`, and, if required calls the method `SI2CInit` to set up new MSSP modules - aka K42s family chips
;this method sets the variable `hi2ccurrentmode`, &, if required calls the method `si2cinit` to set up new mssp modules - aka k42s family chips
;HI2CCurrentMode = 0
	clrf	HI2CCURRENTMODE
;Initialise the I2C module
	return

;********************************************************************************

;Source: glcd_st7735.h (238)
INITGLCD_ST7735
;This method is called when the about GLCD types are selected.
;Why? This is a shared library and therefore this INIT is called, but, this will be empty. Cannot avoid this.
	return

;********************************************************************************

;Source: glcd_st7735r.h (54)
INITGLCD_ST7735R
;Setup code for GLCD_TYPE_ST7735R  or GLCD_TYPE_ST7735R_160_80
;mapped to global variable
;dim GLCDDeviceWidth, GLCDDeviceHeight as byte
;dim GLCDForeground, GLCDBackground as word
;Pin directions
;Dir ST7735_CS Out
	bcf	TRISB,2
;Dir ST7735_DC Out
	bcf	TRISC,2
;Dir ST7735_RST Out
	bcf	TRISB,1
;Dir ST7735_DO Out
	bcf	TRISB,5
;Dir ST7735_SCK Out
	bcf	TRISB,3
;Reset display
;Set ST7735_RST On
	bsf	LATB,1
;Wait 150 ms
	movlw	150
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;Reset sequence (lower line for at least 10 us)
;Set ST7735_RST Off
	bcf	LATB,1
;Wait 150 us
	movlw	1
	movwf	DELAYTEMP2
DelayUSO1
	clrf	DELAYTEMP
DelayUS1
	decfsz	DELAYTEMP,F
	goto	DelayUS1
	decfsz	DELAYTEMP2,F
	goto	DelayUSO1
	movlw	142
	movwf	DELAYTEMP
DelayUS2
	decfsz	DELAYTEMP,F
	goto	DelayUS2
	nop
;Set ST7735_RST On
	bsf	LATB,1
;Wait 150 ms
	movlw	150
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;Software reset
;SendCommand_ST7735 ST7735_SWRESET
	movlw	1
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDCOMMAND_ST7735
	call	SENDCOMMAND_ST7735
	pagesel	$
;Wait 150 ms
	movlw	150
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;Software reset
;SendCommand_ST7735 ST7735_SWRESET
	movlw	1
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDCOMMAND_ST7735
	call	SENDCOMMAND_ST7735
	pagesel	$
;Wait 150 ms
	movlw	150
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;Out of sleep mode
;SendCommand_ST7735 ST7735_SLPOUT
	movlw	17
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDCOMMAND_ST7735
	call	SENDCOMMAND_ST7735
	pagesel	$
;Wait 1 s
	movlw	1
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;asm showdebug _GLCD_TYPE_ST7735R_160_80
;_glcd_type_st7735r_160_80
;SendCommand_ST7735(ST7735_FRMCTR1)
	movlw	177
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDCOMMAND_ST7735
	call	SENDCOMMAND_ST7735
	pagesel	$
;SendData_ST7735(0x01)
	movlw	1
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x2C)
	movlw	44
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x2D)
	movlw	45
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;Wait 10 ms
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;SendCommand_ST7735(ST7735_FRMCTR2)
	movlw	178
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDCOMMAND_ST7735
	call	SENDCOMMAND_ST7735
	pagesel	$
;SendData_ST7735(0x01)
	movlw	1
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x2C)
	movlw	44
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x2D)
	movlw	45
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;Wait 10 ms
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;SendCommand_ST7735(ST7735_FRMCTR3)
	movlw	179
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDCOMMAND_ST7735
	call	SENDCOMMAND_ST7735
	pagesel	$
;SendData_ST7735(0x01)
	movlw	1
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x2C)
	movlw	44
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x2D)
	movlw	45
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x01)
	movlw	1
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x2C)
	movlw	44
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x2D)
	movlw	45
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;Wait 10 ms
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;SendCommand_ST7735(ST7735_INVCTR)
	movlw	180
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDCOMMAND_ST7735
	call	SENDCOMMAND_ST7735
	pagesel	$
;SendData_ST7735(0x07)
	movlw	7
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;wait 10 ms;
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;SendCommand_ST7735(ST7735_PWCTR1)
	movlw	192
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDCOMMAND_ST7735
	call	SENDCOMMAND_ST7735
	pagesel	$
;SendData_ST7735(0xA2)
	movlw	162
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x02)
	movlw	2
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x84)
	movlw	132
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;wait 10 ms;
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;SendCommand_ST7735(ST7735_PWCTR2)
	movlw	193
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDCOMMAND_ST7735
	call	SENDCOMMAND_ST7735
	pagesel	$
;SendData_ST7735(0xC5)
	movlw	197
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;wait 10 ms;
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;SendCommand_ST7735(ST7735_PWCTR3)
	movlw	194
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDCOMMAND_ST7735
	call	SENDCOMMAND_ST7735
	pagesel	$
;SendData_ST7735(0x0A)
	movlw	10
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x00)
	banksel	ST7735SENDBYTE
	clrf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;wait 10 ms;
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;SendCommand_ST7735(ST7735_PWCTR4)
	movlw	195
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDCOMMAND_ST7735
	call	SENDCOMMAND_ST7735
	pagesel	$
;SendData_ST7735(0x8A)
	movlw	138
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x2A)
	movlw	42
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;wait 10 ms;
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;SendCommand_ST7735(ST7735_PWCTR5)
	movlw	196
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDCOMMAND_ST7735
	call	SENDCOMMAND_ST7735
	pagesel	$
;SendData_ST7735(0x8A)
	movlw	138
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0xEE)
	movlw	238
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;wait 10 ms;
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;SendCommand_ST7735(ST7735_VMCTR1)
	movlw	197
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDCOMMAND_ST7735
	call	SENDCOMMAND_ST7735
	pagesel	$
;SendData_ST7735(0x0E)
	movlw	14
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;wait 10 ms;
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;SendCommand_ST7735(ST7735_INVOFF)
	movlw	32
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDCOMMAND_ST7735
	call	SENDCOMMAND_ST7735
	pagesel	$
;wait 10 ms;
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;SendCommand_ST7735(ST7735_MADCTL)
	movlw	54
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDCOMMAND_ST7735
	call	SENDCOMMAND_ST7735
	pagesel	$
;SendData_ST7735(0xC8)     'row address/col address, bottom to top refresh/GBR.
	movlw	200
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;wait 20 ms
	movlw	20
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;SendCommand_ST7735(ST7735_COLMOD)
	movlw	58
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDCOMMAND_ST7735
	call	SENDCOMMAND_ST7735
	pagesel	$
;SendData_ST7735(0x05)
	movlw	5
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendCommand_ST7735(ST7735_CASET)
	movlw	42
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDCOMMAND_ST7735
	call	SENDCOMMAND_ST7735
	pagesel	$
;GreenTab
;SendData_ST7735(0x00)
	banksel	ST7735SENDBYTE
	clrf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x00+ST7735_CASET_ADJUSTMENT)
	banksel	ST7735SENDBYTE
	clrf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x00)
	banksel	ST7735SENDBYTE
	clrf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(GLCD_WIDTH -1 +ST7735_CASET_ADJUSTMENT)
	movlw	79
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;wait 20 ms
	movlw	20
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;SendCommand_ST7735(ST7735_RASET)
	movlw	43
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDCOMMAND_ST7735
	call	SENDCOMMAND_ST7735
	pagesel	$
;GreenTab
;SendData_ST7735(0x00)
	banksel	ST7735SENDBYTE
	clrf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x00+ST7735_RASET_ADJUSTMENT)
	banksel	ST7735SENDBYTE
	clrf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x00)
	banksel	ST7735SENDBYTE
	clrf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(GLCD_HEIGHT -1 +ST7735_RASET_ADJUSTMENT)
	movlw	159
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;wait 20 ms
	movlw	20
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;SendCommand_ST7735(ST7735_GMCTRP1)
	movlw	224
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDCOMMAND_ST7735
	call	SENDCOMMAND_ST7735
	pagesel	$
;SendData_ST7735(0x02)
	movlw	2
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x1c)
	movlw	28
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x07)
	movlw	7
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x12)
	movlw	18
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x37)
	movlw	55
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x32)
	movlw	50
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x29)
	movlw	41
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x2d)
	movlw	45
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x29)
	movlw	41
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x25)
	movlw	37
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x2b)
	movlw	43
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x39)
	movlw	57
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x00)
	banksel	ST7735SENDBYTE
	clrf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x01)
	movlw	1
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x03)
	movlw	3
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x10)
	movlw	16
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;SendCommand_ST7735(ST7735_GMCTRN1)
	movlw	225
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDCOMMAND_ST7735
	call	SENDCOMMAND_ST7735
	pagesel	$
;SendData_ST7735(0x03)
	movlw	3
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x1d)
	movlw	29
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x07)
	movlw	7
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x06)
	movlw	6
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x2e)
	movlw	46
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x2c)
	movlw	44
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x29)
	movlw	41
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x2d)
	movlw	45
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x2e)
	movlw	46
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x2e)
	movlw	46
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x37)
	movlw	55
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x37)
	movlw	55
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x00)
	banksel	ST7735SENDBYTE
	clrf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x00)
	banksel	ST7735SENDBYTE
	clrf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x02)
	movlw	2
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735(0x10)
	movlw	16
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;Display on
;SendCommand_ST7735 ST7735_NORON
	movlw	19
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDCOMMAND_ST7735
	call	SENDCOMMAND_ST7735
	pagesel	$
;Wait 100 ms
	movlw	100
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;Display on
;SendCommand_ST7735 ST7735_DISPON
	movlw	41
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDCOMMAND_ST7735
	call	SENDCOMMAND_ST7735
	pagesel	$
;Wait 100 ms
	movlw	100
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;Colours
;GLCDForeground = TFT_WHITE
	movlw	255
	movwf	GLCDFOREGROUND
	movwf	GLCDFOREGROUND_H
;Default Colours
;GLCDBackground = TFT_BLACK
	clrf	GLCDBACKGROUND
	clrf	GLCDBACKGROUND_H
;Variables required for device
;GLCDDeviceWidth = GLCD_WIDTH - 1
	movlw	79
	movwf	GLCDDEVICEWIDTH
	clrf	GLCDDEVICEWIDTH_H
;GLCDDeviceHeight = GLCD_HEIGHT - 1
	movlw	159
	movwf	GLCDDEVICEHEIGHT
	clrf	GLCDDEVICEHEIGHT_H
;GLCDFontWidth = 5
	movlw	5
	movwf	GLCDFONTWIDTH
;GLCDfntDefault = 0
	clrf	GLCDFNTDEFAULT
;GLCDfntDefaultsize = 1
	movlw	1
	movwf	GLCDFNTDEFAULTSIZE
;GLCDfntDefaultHeight = 8
	movlw	8
	movwf	GLCDFNTDEFAULTHEIGHT
;GLCDRotate ( Landscape )
	movlw	1
	movwf	GLCDROTATESTATE
	pagesel	GLCDROTATE_ST7735
	call	GLCDROTATE_ST7735
	pagesel	$
;Clear screen
;GLCDCLS
	pagesel	GLCDCLS_ST7735
	goto	GLCDCLS_ST7735

;********************************************************************************

;Source: FeatherLite001.gcb (12)
INITPPS
;Module: EUSART
;TX > RC0
;RC0PPS = 0x0010
	movlw	16
	banksel	RC0PPS
	movwf	RC0PPS
;RC0 > TX (bi-directional)
;TXPPS = 0x0008
	movlw	8
	banksel	TXPPS
	movwf	TXPPS
;Module: MSSP1
;RC3 > SDA1
;SSP1DATPPS = 0x0013
	movlw	19
	movwf	SSP1DATPPS
;SDA1 > RC3 (bi-directional)
;RC3PPS = 0x0015
	movlw	21
	banksel	RC3PPS
	movwf	RC3PPS
;SCL1 > RC4
;RC4PPS = 0x0014
	movlw	20
	movwf	RC4PPS
;RC4 > SCL1 (bi-directional)
;SSP1CLKPPS = 0x0014
	movlw	20
	banksel	SSP1CLKPPS
	movwf	SSP1CLKPPS
	banksel	STATUS
	return

;********************************************************************************

;Source: system.h (111)
INITSYS
;asm showdebug This code block sets the internal oscillator to ChipMHz
;this code block sets the internal oscillator to 32
;asm showdebug Default settings for microcontrollers with _OSCCON1_
;default settings for microcontrollers with _osccon1_
;Default OSCCON1 typically, NOSC HFINTOSC; NDIV 1 - Common as this simply sets the HFINTOSC
;asm showdebug OSCCON type is default
;osccon type is default
;OSCCON1 = 0x60
	movlw	96
	banksel	OSCCON1
	movwf	OSCCON1
;Default value typically, CSWHOLD may proceed; SOSCPWR Low power
;OSCCON3 = 0x00
	clrf	OSCCON3
;Default value typically, MFOEN disabled; LFOEN disabled; ADOEN disabled; SOSCEN disabled; EXTOEN disabled; HFOEN disabled
;OSCEN = 0x00
	clrf	OSCEN
;Default value
;OSCTUNE = 0x00
	clrf	OSCTUNE
;asm showdebug The MCU is a chip family ChipFamily
;the mcu is a chip family 15
;asm showdebug OSCCON type is 102
;osccon type is 102
;Set OSCFRQ values for MCUs with OSCSTAT... the 16F18855 MCU family
;OSCFRQ = 0b00000110
	movlw	6
	movwf	OSCFRQ
;asm showdebug _Complete_the_chip_setup_of_BSR,ADCs,ANSEL_and_other_key_setup_registers_or_register_bits
;_complete_the_chip_setup_of_bsr,adcs,ansel_and_other_key_setup_registers_or_register_bits
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
	banksel	ADCON0
	bcf	ADCON0,ADFRM0
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON
;Commence clearing any ANSELx variants in the part, if the ANSEL regsier/bit exists
;ANSELA = 0
	banksel	ANSELA
	clrf	ANSELA
;ANSELB = 0
	clrf	ANSELB
;ANSELC = 0
	clrf	ANSELC
;End  clearing ANSEL
;Set comparator register bits for many MCUs with register CM2CON0
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
;PORTE = 0
	clrf	PORTE
	return

;********************************************************************************

;Source: glcd_st7735r.h (583)
PSET_ST7735R
;SetAddress_ST7735 ST7735_COLUMN, GLCDX, GLCDX
	movlw	42
	banksel	ST7735ADDRESSTYPE
	movwf	ST7735ADDRESSTYPE
	banksel	GLCDX
	movf	GLCDX,W
	banksel	ST7735START
	movwf	ST7735START
	clrf	ST7735START_H
	banksel	GLCDX
	movf	GLCDX,W
	banksel	ST7735END
	movwf	ST7735END
	clrf	ST7735END_H
	banksel	STATUS
	pagesel	SETADDRESS_ST7735
	call	SETADDRESS_ST7735
	pagesel	$
;SetAddress_ST7735 ST7735_ROW, GLCDY, GLCDY
	movlw	43
	banksel	ST7735ADDRESSTYPE
	movwf	ST7735ADDRESSTYPE
	banksel	GLCDY
	movf	GLCDY,W
	banksel	ST7735START
	movwf	ST7735START
	clrf	ST7735START_H
	banksel	GLCDY
	movf	GLCDY,W
	banksel	ST7735END
	movwf	ST7735END
	clrf	ST7735END_H
	banksel	STATUS
	pagesel	SETADDRESS_ST7735
	call	SETADDRESS_ST7735
	pagesel	$
;SendCommand_ST7735 0x2C
	movlw	44
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDCOMMAND_ST7735
	call	SENDCOMMAND_ST7735
	pagesel	$
;SendWord_ST7735 GLCDColour
	movf	GLCDCOLOUR,W
	banksel	ST7735SENDWORD
	movwf	ST7735SENDWORD
	banksel	GLCDCOLOUR_H
	movf	GLCDCOLOUR_H,W
	banksel	ST7735SENDWORD_H
	movwf	ST7735SENDWORD_H
	banksel	STATUS
	pagesel	SENDWORD_ST7735
	goto	SENDWORD_ST7735

;********************************************************************************

;Start of program memory page 1
	ORG	2048
OLEDFONT2
	movf	SYSSTRINGA,W
	movwf	SysWORDTempA
	movf	SYSSTRINGA_H,W
	movwf	SysWORDTempA_H
	movlw	145
	movwf	SysWORDTempB
	movlw	7
	movwf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	retlw	0
	movf	SysStringA, W
	addlw	low TableOLEDFONT2
	movwf	SysStringA
	movlw	(high TableOLEDFONT2) & 127
	btfsc	STATUS, C
	addlw	1
	addwf	SysStringA_H, W
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableOLEDFONT2
	retlw	147
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	254
	retlw	27
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	30
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	30
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	32
	retlw	25
	retlw	160
	retlw	7
	retlw	120
	retlw	1
	retlw	38
	retlw	25
	retlw	160
	retlw	7
	retlw	120
	retlw	1
	retlw	38
	retlw	1
	retlw	32
	retlw	1
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	28
	retlw	24
	retlw	38
	retlw	16
	retlw	66
	retlw	16
	retlw	255
	retlw	63
	retlw	130
	retlw	17
	retlw	2
	retlw	15
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	28
	retlw	16
	retlw	34
	retlw	8
	retlw	34
	retlw	4
	retlw	34
	retlw	3
	retlw	156
	retlw	0
	retlw	64
	retlw	14
	retlw	48
	retlw	17
	retlw	8
	retlw	17
	retlw	4
	retlw	17
	retlw	2
	retlw	14
	retlw	0
	retlw	7
	retlw	128
	retlw	8
	retlw	92
	retlw	16
	retlw	98
	retlw	16
	retlw	162
	retlw	17
	retlw	50
	retlw	19
	retlw	28
	retlw	28
	retlw	0
	retlw	24
	retlw	0
	retlw	22
	retlw	128
	retlw	1
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	30
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	7
	retlw	24
	retlw	24
	retlw	12
	retlw	48
	retlw	4
	retlw	32
	retlw	2
	retlw	64
	retlw	2
	retlw	64
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	2
	retlw	64
	retlw	2
	retlw	64
	retlw	4
	retlw	32
	retlw	12
	retlw	48
	retlw	24
	retlw	24
	retlw	224
	retlw	7
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	8
	retlw	0
	retlw	24
	retlw	0
	retlw	240
	retlw	0
	retlw	78
	retlw	0
	retlw	240
	retlw	0
	retlw	24
	retlw	0
	retlw	8
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	224
	retlw	31
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
	retlw	152
	retlw	0
	retlw	120
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
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
	retlw	0
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
	retlw	0
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
	retlw	64
	retlw	0
	retlw	48
	retlw	0
	retlw	12
	retlw	0
	retlw	3
	retlw	192
	retlw	0
	retlw	48
	retlw	0
	retlw	12
	retlw	0
	retlw	2
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	240
	retlw	3
	retlw	12
	retlw	12
	retlw	2
	retlw	16
	retlw	2
	retlw	16
	retlw	2
	retlw	16
	retlw	12
	retlw	12
	retlw	240
	retlw	3
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	4
	retlw	16
	retlw	4
	retlw	16
	retlw	4
	retlw	16
	retlw	254
	retlw	31
	retlw	0
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	6
	retlw	24
	retlw	2
	retlw	20
	retlw	2
	retlw	18
	retlw	2
	retlw	17
	retlw	194
	retlw	16
	retlw	60
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	2
	retlw	16
	retlw	66
	retlw	16
	retlw	66
	retlw	16
	retlw	66
	retlw	16
	retlw	188
	retlw	15
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	3
	retlw	192
	retlw	2
	retlw	32
	retlw	2
	retlw	24
	retlw	2
	retlw	4
	retlw	2
	retlw	254
	retlw	31
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
	retlw	62
	retlw	16
	retlw	34
	retlw	16
	retlw	34
	retlw	16
	retlw	66
	retlw	8
	retlw	130
	retlw	7
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	240
	retlw	7
	retlw	76
	retlw	8
	retlw	34
	retlw	16
	retlw	34
	retlw	16
	retlw	34
	retlw	16
	retlw	66
	retlw	8
	retlw	128
	retlw	7
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	24
	retlw	2
	retlw	7
	retlw	194
	retlw	0
	retlw	50
	retlw	0
	retlw	10
	retlw	0
	retlw	6
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	28
	retlw	15
	retlw	162
	retlw	16
	retlw	66
	retlw	16
	retlw	66
	retlw	16
	retlw	162
	retlw	16
	retlw	162
	retlw	9
	retlw	28
	retlw	6
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	120
	retlw	0
	retlw	132
	retlw	16
	retlw	2
	retlw	17
	retlw	2
	retlw	17
	retlw	2
	retlw	17
	retlw	132
	retlw	12
	retlw	248
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
	retlw	96
	retlw	24
	retlw	96
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
	retlw	96
	retlw	152
	retlw	96
	retlw	120
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	3
	retlw	0
	retlw	3
	retlw	128
	retlw	4
	retlw	128
	retlw	4
	retlw	64
	retlw	8
	retlw	64
	retlw	8
	retlw	32
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	4
	retlw	128
	retlw	4
	retlw	128
	retlw	4
	retlw	128
	retlw	4
	retlw	128
	retlw	4
	retlw	128
	retlw	4
	retlw	128
	retlw	4
	retlw	128
	retlw	4
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	16
	retlw	64
	retlw	8
	retlw	64
	retlw	8
	retlw	128
	retlw	4
	retlw	128
	retlw	4
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
	retlw	14
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	27
	retlw	130
	retlw	0
	retlw	66
	retlw	0
	retlw	38
	retlw	0
	retlw	28
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	240
	retlw	3
	retlw	24
	retlw	12
	retlw	4
	retlw	24
	retlw	226
	retlw	19
	retlw	18
	retlw	20
	retlw	10
	retlw	22
	retlw	138
	retlw	27
	retlw	252
	retlw	7
	retlw	0
	retlw	4
	retlw	0
	retlw	4
	retlw	0
	retlw	16
	retlw	0
	retlw	14
	retlw	128
	retlw	3
	retlw	112
	retlw	2
	retlw	24
	retlw	2
	retlw	48
	retlw	2
	retlw	192
	retlw	2
	retlw	0
	retlw	3
	retlw	0
	retlw	12
	retlw	0
	retlw	16
	retlw	0
	retlw	0
	retlw	248
	retlw	31
	retlw	136
	retlw	16
	retlw	136
	retlw	16
	retlw	136
	retlw	16
	retlw	136
	retlw	16
	retlw	72
	retlw	17
	retlw	48
	retlw	14
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	192
	retlw	3
	retlw	48
	retlw	12
	retlw	16
	retlw	8
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	24
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	31
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	16
	retlw	8
	retlw	224
	retlw	7
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	31
	retlw	8
	retlw	17
	retlw	8
	retlw	17
	retlw	8
	retlw	17
	retlw	8
	retlw	17
	retlw	8
	retlw	17
	retlw	8
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	31
	retlw	8
	retlw	1
	retlw	8
	retlw	1
	retlw	8
	retlw	1
	retlw	8
	retlw	1
	retlw	8
	retlw	1
	retlw	8
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	192
	retlw	3
	retlw	48
	retlw	12
	retlw	16
	retlw	8
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	17
	retlw	8
	retlw	17
	retlw	24
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	31
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
	retlw	248
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	248
	retlw	31
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	248
	retlw	15
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	31
	retlw	128
	retlw	0
	retlw	128
	retlw	1
	retlw	64
	retlw	2
	retlw	32
	retlw	4
	retlw	16
	retlw	4
	retlw	8
	retlw	8
	retlw	0
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	31
	retlw	0
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	31
	retlw	56
	retlw	0
	retlw	224
	retlw	1
	retlw	0
	retlw	7
	retlw	0
	retlw	6
	retlw	192
	retlw	1
	retlw	56
	retlw	0
	retlw	248
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	31
	retlw	16
	retlw	0
	retlw	96
	retlw	0
	retlw	128
	retlw	1
	retlw	0
	retlw	6
	retlw	0
	retlw	8
	retlw	248
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	7
	retlw	16
	retlw	8
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	16
	retlw	8
	retlw	224
	retlw	7
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	31
	retlw	8
	retlw	1
	retlw	8
	retlw	1
	retlw	8
	retlw	1
	retlw	8
	retlw	1
	retlw	136
	retlw	0
	retlw	112
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	7
	retlw	16
	retlw	8
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	48
	retlw	16
	retlw	72
	retlw	224
	retlw	71
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	31
	retlw	8
	retlw	1
	retlw	8
	retlw	1
	retlw	8
	retlw	3
	retlw	136
	retlw	4
	retlw	112
	retlw	8
	retlw	0
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	112
	retlw	24
	retlw	72
	retlw	16
	retlw	136
	retlw	16
	retlw	136
	retlw	16
	retlw	8
	retlw	17
	retlw	8
	retlw	9
	retlw	24
	retlw	14
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	8
	retlw	0
	retlw	8
	retlw	0
	retlw	8
	retlw	0
	retlw	8
	retlw	0
	retlw	248
	retlw	31
	retlw	8
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
	retlw	248
	retlw	7
	retlw	0
	retlw	24
	retlw	0
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	8
	retlw	248
	retlw	7
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	8
	retlw	0
	retlw	48
	retlw	0
	retlw	192
	retlw	1
	retlw	0
	retlw	6
	retlw	0
	retlw	24
	retlw	0
	retlw	24
	retlw	0
	retlw	7
	retlw	192
	retlw	0
	retlw	48
	retlw	0
	retlw	8
	retlw	0
	retlw	24
	retlw	0
	retlw	224
	retlw	3
	retlw	0
	retlw	28
	retlw	0
	retlw	15
	retlw	224
	retlw	0
	retlw	192
	retlw	1
	retlw	0
	retlw	14
	retlw	0
	retlw	28
	retlw	224
	retlw	3
	retlw	24
	retlw	0
	retlw	8
	retlw	16
	retlw	16
	retlw	8
	retlw	32
	retlw	4
	retlw	64
	retlw	2
	retlw	128
	retlw	1
	retlw	128
	retlw	1
	retlw	64
	retlw	2
	retlw	32
	retlw	4
	retlw	16
	retlw	8
	retlw	8
	retlw	16
	retlw	8
	retlw	0
	retlw	16
	retlw	0
	retlw	96
	retlw	0
	retlw	128
	retlw	0
	retlw	0
	retlw	31
	retlw	128
	retlw	0
	retlw	64
	retlw	0
	retlw	32
	retlw	0
	retlw	16
	retlw	0
	retlw	8
	retlw	0
	retlw	0
	retlw	0
	retlw	8
	retlw	24
	retlw	8
	retlw	20
	retlw	8
	retlw	18
	retlw	8
	retlw	17
	retlw	136
	retlw	16
	retlw	72
	retlw	16
	retlw	40
	retlw	16
	retlw	24
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	254
	retlw	127
	retlw	2
	retlw	64
	retlw	2
	retlw	64
	retlw	2
	retlw	64
	retlw	2
	retlw	64
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	2
	retlw	0
	retlw	12
	retlw	0
	retlw	48
	retlw	0
	retlw	192
	retlw	0
	retlw	0
	retlw	3
	retlw	0
	retlw	12
	retlw	0
	retlw	48
	retlw	0
	retlw	64
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	2
	retlw	64
	retlw	2
	retlw	64
	retlw	2
	retlw	64
	retlw	2
	retlw	64
	retlw	254
	retlw	127
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	4
	retlw	0
	retlw	3
	retlw	224
	retlw	0
	retlw	56
	retlw	0
	retlw	14
	retlw	0
	retlw	112
	retlw	0
	retlw	128
	retlw	3
	retlw	0
	retlw	4
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	32
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
	retlw	12
	retlw	32
	retlw	18
	retlw	32
	retlw	17
	retlw	32
	retlw	17
	retlw	32
	retlw	9
	retlw	192
	retlw	31
	retlw	0
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	254
	retlw	31
	retlw	64
	retlw	8
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	96
	retlw	8
	retlw	128
	retlw	7
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	7
	retlw	64
	retlw	8
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	7
	retlw	64
	retlw	24
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	64
	retlw	8
	retlw	254
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	7
	retlw	64
	retlw	9
	retlw	32
	retlw	17
	retlw	32
	retlw	17
	retlw	32
	retlw	17
	retlw	32
	retlw	17
	retlw	192
	retlw	17
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	252
	retlw	31
	retlw	36
	retlw	0
	retlw	34
	retlw	0
	retlw	34
	retlw	0
	retlw	34
	retlw	0
	retlw	34
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	7
	retlw	64
	retlw	152
	retlw	32
	retlw	144
	retlw	32
	retlw	144
	retlw	32
	retlw	144
	retlw	64
	retlw	72
	retlw	224
	retlw	63
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	254
	retlw	31
	retlw	128
	retlw	0
	retlw	64
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	192
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	38
	retlw	0
	retlw	230
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	32
	retlw	128
	retlw	32
	retlw	128
	retlw	38
	retlw	128
	retlw	230
	retlw	127
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	254
	retlw	31
	retlw	0
	retlw	1
	retlw	0
	retlw	3
	retlw	128
	retlw	4
	retlw	64
	retlw	4
	retlw	64
	retlw	8
	retlw	32
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	2
	retlw	0
	retlw	254
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	31
	retlw	64
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	192
	retlw	31
	retlw	64
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	192
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	31
	retlw	192
	retlw	0
	retlw	64
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	192
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	7
	retlw	64
	retlw	8
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	64
	retlw	8
	retlw	128
	retlw	7
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	255
	retlw	64
	retlw	8
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	96
	retlw	8
	retlw	128
	retlw	7
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	7
	retlw	64
	retlw	24
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	64
	retlw	8
	retlw	224
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	31
	retlw	128
	retlw	0
	retlw	64
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	224
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	192
	retlw	24
	retlw	32
	retlw	17
	retlw	32
	retlw	17
	retlw	32
	retlw	18
	retlw	32
	retlw	18
	retlw	32
	retlw	12
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	0
	retlw	32
	retlw	0
	retlw	248
	retlw	15
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	15
	retlw	0
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	8
	retlw	224
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	0
	retlw	192
	retlw	1
	retlw	0
	retlw	6
	retlw	0
	retlw	24
	retlw	0
	retlw	16
	retlw	0
	retlw	12
	retlw	0
	retlw	3
	retlw	192
	retlw	0
	retlw	32
	retlw	0
	retlw	0
	retlw	0
	retlw	96
	retlw	0
	retlw	128
	retlw	7
	retlw	0
	retlw	24
	retlw	0
	retlw	14
	retlw	192
	retlw	1
	retlw	128
	retlw	1
	retlw	0
	retlw	14
	retlw	0
	retlw	24
	retlw	128
	retlw	7
	retlw	96
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	16
	retlw	64
	retlw	8
	retlw	128
	retlw	4
	retlw	0
	retlw	3
	retlw	0
	retlw	3
	retlw	128
	retlw	4
	retlw	64
	retlw	8
	retlw	32
	retlw	16
	retlw	0
	retlw	0
	retlw	32
	retlw	128
	retlw	192
	retlw	128
	retlw	0
	retlw	131
	retlw	0
	retlw	70
	retlw	0
	retlw	56
	retlw	0
	retlw	24
	retlw	0
	retlw	6
	retlw	0
	retlw	1
	retlw	192
	retlw	0
	retlw	32
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	16
	retlw	32
	retlw	24
	retlw	32
	retlw	20
	retlw	32
	retlw	18
	retlw	32
	retlw	17
	retlw	160
	retlw	16
	retlw	96
	retlw	16
	retlw	32
	retlw	16
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
	retlw	252
	retlw	62
	retlw	2
	retlw	64
	retlw	2
	retlw	64
	retlw	2
	retlw	64
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	254
	retlw	127
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	2
	retlw	64
	retlw	2
	retlw	64
	retlw	2
	retlw	64
	retlw	252
	retlw	62
	retlw	0
	retlw	1
	retlw	0
	retlw	1
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	3
	retlw	128
	retlw	0
	retlw	128
	retlw	0
	retlw	128
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
	retlw	128
	retlw	1
	retlw	0
	retlw	0
	retlw	128
	retlw	31
	retlw	192
	retlw	16
	retlw	32
	retlw	16
	retlw	16
	retlw	16
	retlw	32
	retlw	16
	retlw	192
	retlw	16
	retlw	128
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	192
	retlw	3
	retlw	48
	retlw	12
	retlw	16
	retlw	8
	retlw	8
	retlw	16
	retlw	8
	retlw	16
	retlw	8
	retlw	144
	retlw	8
	retlw	176
	retlw	24
	retlw	208

;********************************************************************************

;Source: glcd_st7735.h (1029)
SETADDRESS_ST7735
;if GLCDRotateState.0 = 0 then
	btfsc	GLCDROTATESTATE,0
	goto	ELSE46_1
;if ST7735AddressType = ST7735_COLUMN then
	movlw	42
	banksel	ST7735ADDRESSTYPE
	subwf	ST7735ADDRESSTYPE,W
	btfss	STATUS, Z
	goto	ENDIF47
;ST7735Start += ST7735_XSTART
	movlw	24
	addwf	ST7735START,F
	movlw	0
	addwfc	ST7735START_H,F
;ST7735End   += ST7735_XSTART
	movlw	24
	addwf	ST7735END,F
	movlw	0
	addwfc	ST7735END_H,F
;end if
ENDIF47
;if ST7735AddressType = ST7735_ROW then
	movlw	43
	subwf	ST7735ADDRESSTYPE,W
	btfss	STATUS, Z
	goto	ENDIF48
;ST7735Start += ST7735_YSTART
	movlw	0
	addwf	ST7735START,F
	movlw	0
	addwfc	ST7735START_H,F
;ST7735End   += ST7735_YSTART
	movlw	0
	addwf	ST7735END,F
	movlw	0
	addwfc	ST7735END_H,F
;end if
ENDIF48
;else
	goto	ENDIF46
ELSE46_1
;if ST7735AddressType = ST7735_COLUMN then
	movlw	42
	banksel	ST7735ADDRESSTYPE
	subwf	ST7735ADDRESSTYPE,W
	btfss	STATUS, Z
	goto	ENDIF49
;ST7735Start += ST7735_YSTART
	movlw	0
	addwf	ST7735START,F
	movlw	0
	addwfc	ST7735START_H,F
;ST7735End   += ST7735_YSTART
	movlw	0
	addwf	ST7735END,F
	movlw	0
	addwfc	ST7735END_H,F
;end if
ENDIF49
;if ST7735AddressType = ST7735_ROW then
	movlw	43
	subwf	ST7735ADDRESSTYPE,W
	btfss	STATUS, Z
	goto	ENDIF50
;ST7735Start += ST7735_XSTART
	movlw	24
	addwf	ST7735START,F
	movlw	0
	addwfc	ST7735START_H,F
;ST7735End   += ST7735_XSTART
	movlw	24
	addwf	ST7735END,F
	movlw	0
	addwfc	ST7735END_H,F
;end if
ENDIF50
;end if
ENDIF46
;SendCommand_ST7735 ST7735AddressType
	movf	ST7735ADDRESSTYPE,W
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDCOMMAND_ST7735
	call	SENDCOMMAND_ST7735
	pagesel	$
;SendData_ST7735 ST7735Start_H
	banksel	ST7735START_H
	movf	ST7735START_H,W
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735 ST7735Start
	banksel	ST7735START
	movf	ST7735START,W
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735 ST7735End_H
	banksel	ST7735END_H
	movf	ST7735END_H,W
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	call	SENDDATA_ST7735
	pagesel	$
;SendData_ST7735 ST7735End
	banksel	ST7735END
	movf	ST7735END,W
	movwf	ST7735SENDBYTE
	banksel	STATUS
	pagesel	SENDDATA_ST7735
	goto	SENDDATA_ST7735

;********************************************************************************

;Start of program memory page 2
	ORG	4096
;Source: glcd.h (1440)
BOX
;dim GLCDTemp as word
;Make sure that starting point (1) is always less than end point (2)
;If LineX1 > LineX2 Then
	banksel	LINEX1
	movf	LINEX1,W
	movwf	SysWORDTempB
	movf	LINEX1_H,W
	movwf	SysWORDTempB_H
	movf	LINEX2,W
	movwf	SysWORDTempA
	movf	LINEX2_H,W
	movwf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF18
;GLCDTemp = LineX1
	banksel	LINEX1
	movf	LINEX1,W
	banksel	GLCDTEMP
	movwf	GLCDTEMP
	banksel	LINEX1_H
	movf	LINEX1_H,W
	banksel	GLCDTEMP_H
	movwf	GLCDTEMP_H
;LineX1 = LineX2
	banksel	LINEX2
	movf	LINEX2,W
	movwf	LINEX1
	movf	LINEX2_H,W
	movwf	LINEX1_H
;LineX2 = GLCDTemp
	banksel	GLCDTEMP
	movf	GLCDTEMP,W
	banksel	LINEX2
	movwf	LINEX2
	banksel	GLCDTEMP_H
	movf	GLCDTEMP_H,W
	banksel	LINEX2_H
	movwf	LINEX2_H
;End If
ENDIF18
;If LineY1 > LineY2 Then
	banksel	LINEY1
	movf	LINEY1,W
	movwf	SysWORDTempB
	movf	LINEY1_H,W
	movwf	SysWORDTempB_H
	movf	LINEY2,W
	movwf	SysWORDTempA
	movf	LINEY2_H,W
	movwf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF19
;GLCDTemp = LineY1
	banksel	LINEY1
	movf	LINEY1,W
	banksel	GLCDTEMP
	movwf	GLCDTEMP
	banksel	LINEY1_H
	movf	LINEY1_H,W
	banksel	GLCDTEMP_H
	movwf	GLCDTEMP_H
;LineY1 = LineY2
	banksel	LINEY2
	movf	LINEY2,W
	movwf	LINEY1
	movf	LINEY2_H,W
	movwf	LINEY1_H
;LineY2 = GLCDTemp
	banksel	GLCDTEMP
	movf	GLCDTEMP,W
	banksel	LINEY2
	movwf	LINEY2
	banksel	GLCDTEMP_H
	movf	GLCDTEMP_H,W
	banksel	LINEY2_H
	movwf	LINEY2_H
;End If
ENDIF19
;dim DrawLine as word
;Draw lines going across
;For DrawLine = LineX1 To LineX2
	movlw	1
	banksel	LINEX1
	subwf	LINEX1,W
	banksel	DRAWLINE
	movwf	DRAWLINE
	movlw	0
	banksel	LINEX1_H
	subwfb	LINEX1_H,W
	banksel	DRAWLINE_H
	movwf	DRAWLINE_H
	banksel	LINEX1
	movf	LINEX1,W
	movwf	SysWORDTempB
	movf	LINEX1_H,W
	movwf	SysWORDTempB_H
	movf	LINEX2,W
	movwf	SysWORDTempA
	movf	LINEX2_H,W
	movwf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd4
SysForLoop4
	incf	DRAWLINE,F
	btfsc	STATUS,Z
	incf	DRAWLINE_H,F
;PSet DrawLine, LineY1, LineColour
	movf	DRAWLINE,W
	movwf	GLCDX
	banksel	LINEY1
	movf	LINEY1,W
	banksel	GLCDY
	movwf	GLCDY
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ST7735R
	call	PSET_ST7735R
	pagesel	$
;PSet DrawLine, LineY2, LineColour
	movf	DRAWLINE,W
	movwf	GLCDX
	banksel	LINEY2
	movf	LINEY2,W
	banksel	GLCDY
	movwf	GLCDY
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ST7735R
	call	PSET_ST7735R
	pagesel	$
;Next
	movf	DRAWLINE,W
	movwf	SysWORDTempA
	movf	DRAWLINE_H,W
	movwf	SysWORDTempA_H
	banksel	LINEX2
	movf	LINEX2,W
	movwf	SysWORDTempB
	movf	LINEX2_H,W
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop4
SysForLoopEnd4
;Draw lines going down
;For DrawLine = LineY1 To LineY2
	movlw	1
	banksel	LINEY1
	subwf	LINEY1,W
	banksel	DRAWLINE
	movwf	DRAWLINE
	movlw	0
	banksel	LINEY1_H
	subwfb	LINEY1_H,W
	banksel	DRAWLINE_H
	movwf	DRAWLINE_H
	banksel	LINEY1
	movf	LINEY1,W
	movwf	SysWORDTempB
	movf	LINEY1_H,W
	movwf	SysWORDTempB_H
	movf	LINEY2,W
	movwf	SysWORDTempA
	movf	LINEY2_H,W
	movwf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd5
SysForLoop5
	incf	DRAWLINE,F
	btfsc	STATUS,Z
	incf	DRAWLINE_H,F
;PSet LineX1, DrawLine, LineColour
	banksel	LINEX1
	movf	LINEX1,W
	banksel	GLCDX
	movwf	GLCDX
	movf	DRAWLINE,W
	movwf	GLCDY
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ST7735R
	call	PSET_ST7735R
	pagesel	$
;PSet LineX2, DrawLine, LineColour
	banksel	LINEX2
	movf	LINEX2,W
	banksel	GLCDX
	movwf	GLCDX
	movf	DRAWLINE,W
	movwf	GLCDY
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ST7735R
	call	PSET_ST7735R
	pagesel	$
;Next
	movf	DRAWLINE,W
	movwf	SysWORDTempA
	movf	DRAWLINE_H,W
	movwf	SysWORDTempA_H
	banksel	LINEY2
	movf	LINEY2,W
	movwf	SysWORDTempB
	movf	LINEY2_H,W
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop5
SysForLoopEnd5
	return

;********************************************************************************

;Source: glcd.h (1487)
CIRCLE
;dim  radiusErr, xradius as Integer
;xradius = Inxradius
	movf	INXRADIUS,W
	banksel	XRADIUS
	movwf	XRADIUS
	banksel	INXRADIUS_H
	movf	INXRADIUS_H,W
	banksel	XRADIUS_H
	movwf	XRADIUS_H
;radiusErr = -(xradius/2)
	movf	XRADIUS,W
	movwf	SysINTEGERTempA
	movf	XRADIUS_H,W
	movwf	SysINTEGERTempA_H
	movlw	2
	movwf	SysINTEGERTempB
	clrf	SysINTEGERTempB_H
	banksel	STATUS
	pagesel	SysDivSubINT
	call	SysDivSubINT
	pagesel	$
	movf	SysINTEGERTempA,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movf	SysINTEGERTempA_H,W
	movwf	SysTemp1_H
	comf	SysTemp1,W
	movwf	RADIUSERR
	comf	SysTemp1_H,W
	movwf	RADIUSERR_H
	incf	RADIUSERR,F
	btfsc	STATUS,Z
	incf	RADIUSERR_H,F
;Do While xradius >=  yordinate
SysDoLoop_S3
	movf	xradius,W
	movwf	SysINTEGERTempA
	movf	xradius_H,W
	movwf	SysINTEGERTempA_H
	movf	yordinate,W
	movwf	SysINTEGERTempB
	clrf	SysINTEGERTempB_H
	banksel	STATUS
	pagesel	SysCompLessThanINT
	call	SysCompLessThanINT
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	SysDoLoop_E3
;Pset ((xoffset + xradius), (yoffset + yordinate), LineColour)
	banksel	XRADIUS
	movf	XRADIUS,W
	addwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	YORDINATE
	movf	YORDINATE,W
	addwf	YOFFSET,W
	banksel	GLCDY
	movwf	GLCDY
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ST7735R
	call	PSET_ST7735R
	pagesel	$
;Pset ((xoffset + yordinate), (yoffset + xradius), LineColour)
	banksel	YORDINATE
	movf	YORDINATE,W
	addwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	XRADIUS
	movf	XRADIUS,W
	addwf	YOFFSET,W
	banksel	GLCDY
	movwf	GLCDY
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ST7735R
	call	PSET_ST7735R
	pagesel	$
;Pset ((xoffset - xradius), (yoffset + yordinate), LineColour)
	banksel	XRADIUS
	movf	XRADIUS,W
	subwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	YORDINATE
	movf	YORDINATE,W
	addwf	YOFFSET,W
	banksel	GLCDY
	movwf	GLCDY
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ST7735R
	call	PSET_ST7735R
	pagesel	$
;Pset ((xoffset - yordinate), (yoffset + xradius), LineColour)
	banksel	YORDINATE
	movf	YORDINATE,W
	subwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	XRADIUS
	movf	XRADIUS,W
	addwf	YOFFSET,W
	banksel	GLCDY
	movwf	GLCDY
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ST7735R
	call	PSET_ST7735R
	pagesel	$
;Pset ((xoffset - xradius), (yoffset - yordinate), LineColour)
	banksel	XRADIUS
	movf	XRADIUS,W
	subwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	YORDINATE
	movf	YORDINATE,W
	subwf	YOFFSET,W
	banksel	GLCDY
	movwf	GLCDY
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ST7735R
	call	PSET_ST7735R
	pagesel	$
;Pset ((xoffset - yordinate), (yoffset - xradius), LineColour)
	banksel	YORDINATE
	movf	YORDINATE,W
	subwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	XRADIUS
	movf	XRADIUS,W
	subwf	YOFFSET,W
	banksel	GLCDY
	movwf	GLCDY
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ST7735R
	call	PSET_ST7735R
	pagesel	$
;Pset ((xoffset + xradius), (yoffset - yordinate), LineColour)
	banksel	XRADIUS
	movf	XRADIUS,W
	addwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	YORDINATE
	movf	YORDINATE,W
	subwf	YOFFSET,W
	banksel	GLCDY
	movwf	GLCDY
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ST7735R
	call	PSET_ST7735R
	pagesel	$
;Pset ((xoffset + yordinate), (yoffset - xradius), LineColour)
	banksel	YORDINATE
	movf	YORDINATE,W
	addwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	XRADIUS
	movf	XRADIUS,W
	subwf	YOFFSET,W
	banksel	GLCDY
	movwf	GLCDY
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ST7735R
	call	PSET_ST7735R
	pagesel	$
;yordinate ++
	banksel	YORDINATE
	incf	YORDINATE,F
;If radiusErr < 0 Then
	movf	RADIUSERR,W
	movwf	SysINTEGERTempA
	movf	RADIUSERR_H,W
	movwf	SysINTEGERTempA_H
	clrf	SysINTEGERTempB
	clrf	SysINTEGERTempB_H
	banksel	STATUS
	pagesel	SysCompLessThanINT
	call	SysCompLessThanINT
	pagesel	$
	btfss	SysByteTempX,0
	goto	ELSE24_1
;radiusErr = radiusErr + 2 * yordinate + 1
	bcf	STATUS,C
	banksel	YORDINATE
	rlf	YORDINATE,W
	movwf	SysTemp1
	addwf	RADIUSERR,W
	movwf	SysTemp2
	movlw	0
	addwfc	RADIUSERR_H,W
	movwf	SysTemp2_H
	movlw	1
	addwf	SysTemp2,W
	movwf	RADIUSERR
	movlw	0
	addwfc	SysTemp2_H,W
	movwf	RADIUSERR_H
;else
	goto	ENDIF24
ELSE24_1
;xradius --
	movlw	1
	banksel	XRADIUS
	subwf	XRADIUS,F
	movlw	0
	subwfb	XRADIUS_H,F
;radiusErr = radiusErr + 2 * (yordinate - xradius + 1)
	movf	XRADIUS,W
	subwf	YORDINATE,W
	movwf	SysTemp2
	clrf	SysTemp1
	movf	XRADIUS_H,W
	subwfb	SysTemp1,W
	movwf	SysTemp2_H
	movlw	1
	addwf	SysTemp2,W
	movwf	SysTemp3
	movlw	0
	addwfc	SysTemp2_H,W
	movwf	SysTemp3_H
	movf	SysTemp3,W
	movwf	SysINTEGERTempA
	movf	SysTemp3_H,W
	movwf	SysINTEGERTempA_H
	movlw	2
	movwf	SysINTEGERTempB
	clrf	SysINTEGERTempB_H
	banksel	STATUS
	pagesel	SysMultSubINT
	call	SysMultSubINT
	pagesel	$
	movf	SysINTEGERTempX,W
	banksel	RADIUSERR
	addwf	RADIUSERR,F
	movf	SysINTEGERTempX_H,W
	addwfc	RADIUSERR_H,F
;end if
ENDIF24
;Loop
	goto	SysDoLoop_S3
SysDoLoop_E3
	return

;********************************************************************************

;Source: glcd_st7735.h (672)
GLCDDRAWCHAR_ST7735
;This has got a tad complex
;We have three major pieces
;1 The preamble - this just adjusted color and the input character
;2 The code that deals with GCB fontset
;3 The code that deals with OLED fontset
;
;You can make independent change to section 2 and 3 but they are mutual exclusive with many common pieces
;dim CharCol, CharRow, GLCDTemp as word
;CharCode -= 15
	movlw	15
	subwf	CHARCODE,F
;CharCol=0
	clrf	CHARCOL
	clrf	CHARCOL_H
;Calculate the pointer to the OLED fonts.
;These fonts are not multiple tables one is a straight list the other is a lookup table with data.
;Dim LocalCharCode as word
;Get key information and set up the fonts parameters
;Select case GLCDfntDefaultSize
;case 1 'This font is two font tables of an index and data
SysSelect1Case1
	decf	GLCDFNTDEFAULTSIZE,W
	btfss	STATUS, Z
	goto	SysSelect1Case2
;CharCode = CharCode - 16
	movlw	16
	subwf	CHARCODE,F
;ReadTable OLEDFont1Index, CharCode, LocalCharCode
	movf	CHARCODE,W
	movwf	SYSSTRINGA
	pagesel	OLEDFONT1INDEX
	call	OLEDFONT1INDEX
	pagesel	$
	banksel	LOCALCHARCODE
	movwf	LOCALCHARCODE
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SYSSTRINGA
	pagesel	OLEDFONT1INDEX_H
	call	OLEDFONT1INDEX_H
	pagesel	$
	banksel	LOCALCHARCODE_H
	movwf	LOCALCHARCODE_H
;ReadTable OLEDFont1Data, LocalCharCode , COLSperfont
	movf	LOCALCHARCODE,W
	movwf	SYSSTRINGA
	movf	LOCALCHARCODE_H,W
	movwf	SYSSTRINGA_H
	banksel	STATUS
	call	OLEDFONT1DATA
	movwf	COLSPERFONT
;If the char is the ASC(32) a SPACE set the fontwidth =1 (not 2)
;if LocalCharCode = 1 then
	banksel	LOCALCHARCODE
	movf	LOCALCHARCODE,W
	movwf	SysWORDTempA
	movf	LOCALCHARCODE_H,W
	movwf	SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	call	SysCompEqual16
	btfss	SysByteTempX,0
	goto	ELSE32_1
;GLCDFontWidth = 1
	movlw	1
	movwf	GLCDFONTWIDTH
;else
	goto	ENDIF32
ELSE32_1
;GLCDFontWidth = COLSperfont+1
	incf	COLSPERFONT,W
	movwf	GLCDFONTWIDTH
;end if
ENDIF32
;ROWSperfont = 7  'which is really 8 as we start at 0
	movlw	7
	banksel	ROWSPERFONT
	movwf	ROWSPERFONT
;case 2 'This is one font table
	goto	SysSelectEnd1
SysSelect1Case2
	movlw	2
	subwf	GLCDFNTDEFAULTSIZE,W
	btfss	STATUS, Z
	goto	SysSelectEnd1
;CharCode = CharCode - 17
	movlw	17
	subwf	CHARCODE,F
;Pointer to table of font elements
;LocalCharCode = (CharCode * 20)
	movf	CHARCODE,W
	movwf	SysWORDTempA
	clrf	SysWORDTempA_H
	movlw	20
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysMultSub16
	call	SysMultSub16
	pagesel	$
	movf	SysWORDTempX,W
	banksel	LOCALCHARCODE
	movwf	LOCALCHARCODE
	movf	SysWORDTempX_H,W
	movwf	LOCALCHARCODE_H
;COLSperfont = 9  'which is really 10 as we start at 0
	movlw	9
	banksel	COLSPERFONT
	movwf	COLSPERFONT
;ROWSperfont=15  'which is really 16 as we start at 0
	movlw	15
	banksel	ROWSPERFONT
	movwf	ROWSPERFONT
;End Select
SysSelectEnd1
;The main loop - loop throught the number of columns
;For CurrCharCol = 0 to COLSperfont  'number of columns in the font , with two row of data
	movlw	255
	banksel	CURRCHARCOL
	movwf	CURRCHARCOL
	movlw	0
	subwf	COLSPERFONT,W
	btfss	STATUS, C
	goto	SysForLoopEnd6
SysForLoop6
	incf	CURRCHARCOL,F
;Index the pointer to the code that we are looking for as we need to do this lookup many times getting more font data
;LocalCharCode++
	banksel	LOCALCHARCODE
	incf	LOCALCHARCODE,F
	btfsc	STATUS,Z
	incf	LOCALCHARCODE_H,F
;Select case GLCDfntDefaultSize
;case 1
SysSelect2Case1
	banksel	GLCDFNTDEFAULTSIZE
	decf	GLCDFNTDEFAULTSIZE,W
	btfss	STATUS, Z
	goto	SysSelect2Case2
;ReadTable OLEDFont1Data, LocalCharCode, CurrCharVal
	banksel	LOCALCHARCODE
	movf	LOCALCHARCODE,W
	movwf	SYSSTRINGA
	movf	LOCALCHARCODE_H,W
	movwf	SYSSTRINGA_H
	banksel	STATUS
	call	OLEDFONT1DATA
	movwf	CURRCHARVAL
;case 2
	goto	SysSelectEnd2
SysSelect2Case2
	movlw	2
	subwf	GLCDFNTDEFAULTSIZE,W
	btfss	STATUS, Z
	goto	SysSelectEnd2
;Read this 20 times... (0..COLSperfont) [ * 2 ]
;ReadTable OLEDFont2, LocalCharCode, CurrCharVal
	banksel	LOCALCHARCODE
	movf	LOCALCHARCODE,W
	movwf	SYSSTRINGA
	movf	LOCALCHARCODE_H,W
	movwf	SYSSTRINGA_H
	banksel	STATUS
	pagesel	OLEDFONT2
	call	OLEDFONT2
	pagesel	$
	movwf	CURRCHARVAL
;End Select
SysSelectEnd2
;we handle 8 or 16 pixels of height
;For CurrCharRow = 0 to ROWSperfont
	movlw	255
	movwf	CURRCHARROW
	movlw	0
	banksel	ROWSPERFONT
	subwf	ROWSPERFONT,W
	btfss	STATUS, C
	goto	SysForLoopEnd7
SysForLoop7
	banksel	CURRCHARROW
	incf	CURRCHARROW,F
;Set the pixel
;If CurrCharVal.0 = 0 Then
	btfsc	CURRCHARVAL,0
	goto	ELSE35_1
;PSet CharLocX + CurrCharCol, CharLocY + CurrCharRow, GLCDBackground
	movf	CURRCHARCOL,W
	addwf	CHARLOCX,W
	movwf	GLCDX
	movf	CURRCHARROW,W
	addwf	CHARLOCY,W
	movwf	GLCDY
	movf	GLCDBACKGROUND,W
	movwf	GLCDCOLOUR
	movf	GLCDBACKGROUND_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ST7735R
	call	PSET_ST7735R
	pagesel	$
;Else
	goto	ENDIF35
ELSE35_1
;PSet CharLocX + CurrCharCol, CharLocY + CurrCharRow, LineColour
	movf	CURRCHARCOL,W
	addwf	CHARLOCX,W
	movwf	GLCDX
	movf	CURRCHARROW,W
	addwf	CHARLOCY,W
	movwf	GLCDY
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ST7735R
	call	PSET_ST7735R
	pagesel	$
;End If
ENDIF35
;Rotate CurrCharVal Right
	rrf	CURRCHARVAL,F
;Set to next row of date, a second row
;if GLCDfntDefaultSize = 2 and CurrCharRow = 7 then
	movf	GLCDFNTDEFAULTSIZE,W
	movwf	SysBYTETempA
	movlw	2
	movwf	SysBYTETempB
	pagesel	SysCompEqual
	call	SysCompEqual
	pagesel	$
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	CURRCHARROW
	movf	CURRCHARROW,W
	movwf	SysBYTETempA
	movlw	7
	movwf	SysBYTETempB
	pagesel	SysCompEqual
	call	SysCompEqual
	pagesel	$
	banksel	SYSTEMP1
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfss	SysTemp2,0
	goto	ENDIF36
;LocalCharCode++
	incf	LOCALCHARCODE,F
	btfsc	STATUS,Z
	incf	LOCALCHARCODE_H,F
;ReadTable OLEDFont2, LocalCharCode, CurrCharVal
	movf	LOCALCHARCODE,W
	movwf	SYSSTRINGA
	movf	LOCALCHARCODE_H,W
	movwf	SYSSTRINGA_H
	banksel	STATUS
	pagesel	OLEDFONT2
	call	OLEDFONT2
	pagesel	$
	movwf	CURRCHARVAL
;end if
ENDIF36
;It is the intercharacter space, put out one pixel row
;if CurrCharCol = COLSperfont then
	banksel	COLSPERFONT
	movf	COLSPERFONT,W
	subwf	CURRCHARCOL,W
	btfss	STATUS, Z
	goto	ENDIF37
;Put out a white intercharacter pixel/space
;GLCDTemp = CharLocX + CurrCharCol
	movf	CURRCHARCOL,W
	addwf	CHARLOCX,W
	movwf	GLCDTEMP
	movlw	0
	addwfc	CHARLOCX_H,W
	movwf	GLCDTEMP_H
;if GLCDfntDefaultSize = 2 then
	movlw	2
	subwf	GLCDFNTDEFAULTSIZE,W
	btfss	STATUS, Z
	goto	ENDIF40
;GLCDTemp++
	incf	GLCDTEMP,F
	btfsc	STATUS,Z
	incf	GLCDTEMP_H,F
;end if
ENDIF40
;PSet GLCDTemp , CharLocY + CurrCharRow, GLCDBackground
	movf	GLCDTEMP,W
	movwf	GLCDX
	movf	CURRCHARROW,W
	addwf	CHARLOCY,W
	movwf	GLCDY
	movf	GLCDBACKGROUND,W
	movwf	GLCDCOLOUR
	movf	GLCDBACKGROUND_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ST7735R
	call	PSET_ST7735R
	pagesel	$
;end if
ENDIF37
;Next
	banksel	ROWSPERFONT
	movf	ROWSPERFONT,W
	banksel	CURRCHARROW
	subwf	CURRCHARROW,W
	btfss	STATUS, C
	goto	SysForLoop7
SysForLoopEnd7
;Next
	banksel	COLSPERFONT
	movf	COLSPERFONT,W
	subwf	CURRCHARCOL,W
	btfss	STATUS, C
	goto	SysForLoop6
SysForLoopEnd6
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:LONG:, Source: glcd.h (1045)
GLCDPRINT7
;Dim SysCalcTempA As Long
;Dim GLCDPrintLoc as word
;Dim SysPrintBuffer(10)
;SysPrintBuffLen = 0
	banksel	SYSPRINTBUFFLEN
	clrf	SYSPRINTBUFFLEN
;dim OldGLCDFontWidth as Byte
;OldGLCDFontWidth = GLCDFontWidth
	banksel	GLCDFONTWIDTH
	movf	GLCDFONTWIDTH,W
	banksel	OLDGLCDFONTWIDTH
	movwf	OLDGLCDFONTWIDTH
;Do
SysDoLoop_S2
;Divide number by 10, remainder into buffer
;SysPrintBuffLen += 1
	banksel	SYSPRINTBUFFLEN
	incf	SYSPRINTBUFFLEN,F
;SysPrintBuffer(SysPrintBuffLen) = LCDValue % 10
	movlw	low(SYSPRINTBUFFER)
	addwf	SYSPRINTBUFFLEN,W
	movwf	AFSR0
	clrf	SysTemp1
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
	pagesel	SysDivSub32
	call	SysDivSub32
	pagesel	$
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
	goto	SysDoLoop_S2
SysDoLoop_E2
;Display
;GLCDPrintLoc = PrintLocX
	banksel	PRINTLOCX
	movf	PRINTLOCX,W
	banksel	GLCDPRINTLOC
	movwf	GLCDPRINTLOC
	banksel	PRINTLOCX_H
	movf	PRINTLOCX_H,W
	banksel	GLCDPRINTLOC_H
	movwf	GLCDPRINTLOC_H
;For GLCDPrint_String_Counter = SysPrintBuffLen To 1 Step -1
	banksel	SYSPRINTBUFFLEN
	incf	SYSPRINTBUFFLEN,W
	banksel	GLCDPRINT_STRING_COUNTER
	movwf	GLCDPRINT_STRING_COUNTER
	movlw	1
	banksel	SYSPRINTBUFFLEN
	subwf	SYSPRINTBUFFLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd3
SysForLoop3
	banksel	GLCDPRINT_STRING_COUNTER
	decf	GLCDPRINT_STRING_COUNTER,F
;GLCDDrawChar GLCDPrintLoc, PrintLocY, SysPrintBuffer(GLCDPrint_String_Counter) + 48
	movf	GLCDPRINTLOC,W
	movwf	CHARLOCX
	movf	GLCDPRINTLOC_H,W
	movwf	CHARLOCX_H
	banksel	PRINTLOCY
	movf	PRINTLOCY,W
	banksel	CHARLOCY
	movwf	CHARLOCY
	banksel	PRINTLOCY_H
	movf	PRINTLOCY_H,W
	banksel	CHARLOCY_H
	movwf	CHARLOCY_H
	movlw	low(SYSPRINTBUFFER)
	addwf	GLCDPRINT_STRING_COUNTER,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(SYSPRINTBUFFER)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movlw	48
	addwf	INDF0,W
	banksel	CHARCODE
	movwf	CHARCODE
	movf	GLCDFOREGROUND,W
	movwf	LINECOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	LINECOLOUR_H
	call	GLCDDRAWCHAR_ST7735
;GLCDPrintIncrementPixelPositionMacro
;Macro Source: glcd.h (1170)
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize ) + GLCDfntDefaultsize - 1
	movf	GLCDFONTWIDTH,W
	movwf	SysBYTETempA
	movf	GLCDFNTDEFAULTSIZE,W
	movwf	SysBYTETempB
	pagesel	SysMultSub
	call	SysMultSub
	pagesel	$
	movf	SysBYTETempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	GLCDPRINTLOC
	addwf	GLCDPRINTLOC,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	0
	banksel	GLCDPRINTLOC_H
	addwfc	GLCDPRINTLOC_H,W
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H
	banksel	GLCDFNTDEFAULTSIZE
	movf	GLCDFNTDEFAULTSIZE,W
	banksel	SYSTEMP2
	addwf	SysTemp2,W
	movwf	SysTemp1
	movlw	0
	addwfc	SysTemp2_H,W
	movwf	SysTemp1_H
	movlw	1
	subwf	SysTemp1,W
	banksel	GLCDPRINTLOC
	movwf	GLCDPRINTLOC
	movlw	0
	banksel	SYSTEMP1_H
	subwfb	SysTemp1_H,W
	banksel	GLCDPRINTLOC_H
	movwf	GLCDPRINTLOC_H
;Next
	movf	GLCDPRINT_STRING_COUNTER,W
	sublw	1
	btfss	STATUS, C
	goto	SysForLoop3
SysForLoopEnd3
;Update the current X position for GLCDPrintString
;PrintLocX = GLCDPrintLoc
	banksel	GLCDPRINTLOC
	movf	GLCDPRINTLOC,W
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	banksel	GLCDPRINTLOC_H
	movf	GLCDPRINTLOC_H,W
	banksel	PRINTLOCX_H
	movwf	PRINTLOCX_H
;GLCDFontWidth = OldGLCDFontWidth
	movf	OLDGLCDFONTWIDTH,W
	banksel	GLCDFONTWIDTH
	movwf	GLCDFONTWIDTH
	return

;********************************************************************************

;Source: hwi2c.h (441)
HI2CRECEIVE
;Enable receive
;Master_mode
;If HI2CCurrentMode > 10 Then
	movf	HI2CCURRENTMODE,W
	sublw	10
	btfsc	STATUS, C
	goto	ELSE88_1
;if HI2CGetAck.0 = 1 then
	btfss	HI2CGETACK,0
	goto	ELSE90_1
;Acknowledge
;ACKDT = 0
	banksel	SSP1CON2
	bcf	SSP1CON2,ACKDT
;else
	goto	ENDIF90
ELSE90_1
;Not Acknowledge
;ACKDT = 1
	banksel	SSP1CON2
	bsf	SSP1CON2,ACKDT
;end if
ENDIF90
;RCEN = 1
	bsf	SSP1CON2,RCEN
;Slave mode
;Else
	goto	ENDIF88
ELSE88_1
;SET SSPSTAT.R_NOT_W ON
	banksel	SSP1STAT
	bsf	SSP1STAT,R_NOT_W
;End If
ENDIF88
;Clear Collisions
;SET SSPCON1.WCOL OFF
	bcf	SSP1CON1,WCOL
;SET SSPCON1.SSPOV Off
	bcf	SSP1CON1,SSPOV
;Wait for receive
;Wait Until SSPSTAT.BF = 1 AND SSPIF = 1
SysWaitLoop4
	clrf	SysByteTempX
	banksel	SSP1STAT
	btfsc	SSP1STAT,BF
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	clrf	SysByteTempX
	banksel	PIR3
	btfsc	PIR3,SSP1IF
	comf	SysByteTempX,F
	banksel	SYSTEMP1
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfss	SysTemp2,0
	goto	SysWaitLoop4
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
;Disable receive (Master_mode)
;Master_mode
;If HI2CCurrentMode > 10 Then
	movf	HI2CCURRENTMODE,W
	sublw	10
	btfsc	STATUS, C
	goto	ELSE89_1
;Set SSPCON2.RCEN Off
	banksel	SSP1CON2
	bcf	SSP1CON2,RCEN
;Slave mode
;Else
	goto	ENDIF89
ELSE89_1
;SET SSPSTAT.R_NOT_W Off
	banksel	SSP1STAT
	bcf	SSP1STAT,R_NOT_W
;End If
ENDIF89
	banksel	STATUS
	return

;********************************************************************************

;Source: glcd.h (1569)
LINE
;dim LineStepX as integer
;dim LineStepY as integer
;dim LineDiffX, LineDiffY as integer
;dim LineDiffX_x2, LineDiffY_x2 as integer
;dim LineErr as integer
;LineDiffX = 0
	clrf	LINEDIFFX
	clrf	LINEDIFFX_H
;LineDiffY = 0
	clrf	LINEDIFFY
	clrf	LINEDIFFY_H
;LineStepX = 0
	clrf	LINESTEPX
	clrf	LINESTEPX_H
;LineStepY = 0
	clrf	LINESTEPY
	clrf	LINESTEPY_H
;LineDiffX_x2 = 0
	clrf	LINEDIFFX_X2
	clrf	LINEDIFFX_X2_H
;LineDiffY_x2 = 0
	clrf	LINEDIFFY_X2
	clrf	LINEDIFFY_X2_H
;LineErr = 0
	clrf	LINEERR
	clrf	LINEERR_H
;LineDiffX =  LineX2 -   LineX1
	banksel	LINEX1
	movf	LINEX1,W
	subwf	LINEX2,W
	banksel	LINEDIFFX
	movwf	LINEDIFFX
	banksel	LINEX1_H
	movf	LINEX1_H,W
	subwfb	LINEX2_H,W
	banksel	LINEDIFFX_H
	movwf	LINEDIFFX_H
;LineDiffY =  LineY2 -   LineY1
	banksel	LINEY1
	movf	LINEY1,W
	subwf	LINEY2,W
	banksel	LINEDIFFY
	movwf	LINEDIFFY
	banksel	LINEY1_H
	movf	LINEY1_H,W
	subwfb	LINEY2_H,W
	banksel	LINEDIFFY_H
	movwf	LINEDIFFY_H
;if (LineDiffX > 0) then
	movf	LINEDIFFX,W
	movwf	SysINTEGERTempB
	movf	LINEDIFFX_H,W
	movwf	SysINTEGERTempB_H
	clrf	SysINTEGERTempA
	clrf	SysINTEGERTempA_H
	pagesel	SysCompLessThanINT
	call	SysCompLessThanINT
	pagesel	$
	btfss	SysByteTempX,0
	goto	ELSE26_1
;LineStepX = 1
	movlw	1
	movwf	LINESTEPX
	clrf	LINESTEPX_H
;else
	goto	ENDIF26
ELSE26_1
;LineStepX = -1
	movlw	255
	movwf	LINESTEPX
	movwf	LINESTEPX_H
;end if
ENDIF26
;if (LineDiffY > 0) then
	movf	LINEDIFFY,W
	movwf	SysINTEGERTempB
	movf	LINEDIFFY_H,W
	movwf	SysINTEGERTempB_H
	clrf	SysINTEGERTempA
	clrf	SysINTEGERTempA_H
	pagesel	SysCompLessThanINT
	call	SysCompLessThanINT
	pagesel	$
	btfss	SysByteTempX,0
	goto	ELSE27_1
;LineStepY = 1
	movlw	1
	movwf	LINESTEPY
	clrf	LINESTEPY_H
;else
	goto	ENDIF27
ELSE27_1
;LineStepY = -1
	movlw	255
	movwf	LINESTEPY
	movwf	LINESTEPY_H
;end if
ENDIF27
;LineDiffX = LineStepX * LineDiffX
	movf	LINESTEPX,W
	movwf	SysINTEGERTempA
	movf	LINESTEPX_H,W
	movwf	SysINTEGERTempA_H
	movf	LINEDIFFX,W
	movwf	SysINTEGERTempB
	movf	LINEDIFFX_H,W
	movwf	SysINTEGERTempB_H
	pagesel	SysMultSubINT
	call	SysMultSubINT
	pagesel	$
	movf	SysINTEGERTempX,W
	movwf	LINEDIFFX
	movf	SysINTEGERTempX_H,W
	movwf	LINEDIFFX_H
;LineDiffY = LineStepY * LineDiffY
	movf	LINESTEPY,W
	movwf	SysINTEGERTempA
	movf	LINESTEPY_H,W
	movwf	SysINTEGERTempA_H
	movf	LINEDIFFY,W
	movwf	SysINTEGERTempB
	movf	LINEDIFFY_H,W
	movwf	SysINTEGERTempB_H
	pagesel	SysMultSubINT
	call	SysMultSubINT
	pagesel	$
	movf	SysINTEGERTempX,W
	movwf	LINEDIFFY
	movf	SysINTEGERTempX_H,W
	movwf	LINEDIFFY_H
;LineDiffX_x2 = LineDiffX*2
	movf	LINEDIFFX,W
	movwf	SysINTEGERTempA
	movf	LINEDIFFX_H,W
	movwf	SysINTEGERTempA_H
	movlw	2
	movwf	SysINTEGERTempB
	clrf	SysINTEGERTempB_H
	pagesel	SysMultSubINT
	call	SysMultSubINT
	pagesel	$
	movf	SysINTEGERTempX,W
	movwf	LINEDIFFX_X2
	movf	SysINTEGERTempX_H,W
	movwf	LINEDIFFX_X2_H
;LineDiffY_x2 = LineDiffY*2
	movf	LINEDIFFY,W
	movwf	SysINTEGERTempA
	movf	LINEDIFFY_H,W
	movwf	SysINTEGERTempA_H
	movlw	2
	movwf	SysINTEGERTempB
	clrf	SysINTEGERTempB_H
	pagesel	SysMultSubINT
	call	SysMultSubINT
	pagesel	$
	movf	SysINTEGERTempX,W
	movwf	LINEDIFFY_X2
	movf	SysINTEGERTempX_H,W
	movwf	LINEDIFFY_X2_H
;if ( LineDiffX >= LineDiffY) then
	movf	LINEDIFFX,W
	movwf	SysINTEGERTempA
	movf	LINEDIFFX_H,W
	movwf	SysINTEGERTempA_H
	movf	LINEDIFFY,W
	movwf	SysINTEGERTempB
	movf	LINEDIFFY_H,W
	movwf	SysINTEGERTempB_H
	pagesel	SysCompLessThanINT
	call	SysCompLessThanINT
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ELSE28_1
;LineErr = LineDiffY_x2 - LineDiffX
	movf	LINEDIFFX,W
	subwf	LINEDIFFY_X2,W
	movwf	LINEERR
	movf	LINEDIFFX_H,W
	subwfb	LINEDIFFY_X2_H,W
	movwf	LINEERR_H
;do while (   LineX1 <>  LineX2 )
SysDoLoop_S5
	banksel	LINEX1
	movf	linex1,W
	movwf	SysWORDTempA
	movf	linex1_H,W
	movwf	SysWORDTempA_H
	movf	linex2,W
	movwf	SysWORDTempB
	movf	linex2_H,W
	movwf	SysWORDTempB_H
	banksel	STATUS
	call	SysCompEqual16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	SysDoLoop_E5
;PSet (   LineX1,   LineY1, LineColour )
	banksel	LINEX1
	movf	LINEX1,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	LINEY1
	movf	LINEY1,W
	banksel	GLCDY
	movwf	GLCDY
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ST7735R
	call	PSET_ST7735R
	pagesel	$
;LineX1 += LineStepX
	movf	LINESTEPX,W
	banksel	LINEX1
	addwf	LINEX1,F
	banksel	LINESTEPX_H
	movf	LINESTEPX_H,W
	banksel	LINEX1_H
	addwfc	LINEX1_H,F
;if ( LineErr < 0) then
	banksel	LINEERR
	movf	LINEERR,W
	movwf	SysINTEGERTempA
	movf	LINEERR_H,W
	movwf	SysINTEGERTempA_H
	clrf	SysINTEGERTempB
	clrf	SysINTEGERTempB_H
	pagesel	SysCompLessThanINT
	call	SysCompLessThanINT
	pagesel	$
	btfss	SysByteTempX,0
	goto	ELSE29_1
;LineErr += LineDiffY_x2
	movf	LINEDIFFY_X2,W
	addwf	LINEERR,F
	movf	LINEDIFFY_X2_H,W
	addwfc	LINEERR_H,F
;else
	goto	ENDIF29
ELSE29_1
;LineErr += ( LineDiffY_x2 - LineDiffX_x2 )
	movf	LINEDIFFX_X2,W
	subwf	LINEDIFFY_X2,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	banksel	LINEDIFFX_X2_H
	movf	LINEDIFFX_X2_H,W
	subwfb	LINEDIFFY_X2_H,W
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H
	movf	SysTemp2,W
	banksel	LINEERR
	addwf	LINEERR,F
	banksel	SYSTEMP2_H
	movf	SysTemp2_H,W
	banksel	LINEERR_H
	addwfc	LINEERR_H,F
;LineY1 += LineStepY
	movf	LINESTEPY,W
	banksel	LINEY1
	addwf	LINEY1,F
	banksel	LINESTEPY_H
	movf	LINESTEPY_H,W
	banksel	LINEY1_H
	addwfc	LINEY1_H,F
;end if
ENDIF29
;loop
	goto	SysDoLoop_S5
SysDoLoop_E5
;PSet (   LineX1,   LineY1, LineColour )
	banksel	LINEX1
	movf	LINEX1,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	LINEY1
	movf	LINEY1,W
	banksel	GLCDY
	movwf	GLCDY
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ST7735R
	call	PSET_ST7735R
	pagesel	$
;else
	goto	ENDIF28
ELSE28_1
;LineErr = LineDiffX_x2 - LineDiffY
	movf	LINEDIFFY,W
	subwf	LINEDIFFX_X2,W
	movwf	LINEERR
	movf	LINEDIFFY_H,W
	subwfb	LINEDIFFX_X2_H,W
	movwf	LINEERR_H
;do while (   LineY1 <>  LineY2)
SysDoLoop_S6
	banksel	LINEY1
	movf	liney1,W
	movwf	SysWORDTempA
	movf	liney1_H,W
	movwf	SysWORDTempA_H
	movf	liney2,W
	movwf	SysWORDTempB
	movf	liney2_H,W
	movwf	SysWORDTempB_H
	banksel	STATUS
	call	SysCompEqual16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	SysDoLoop_E6
;PSet (   LineX1,   LineY1, LineColour )
	banksel	LINEX1
	movf	LINEX1,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	LINEY1
	movf	LINEY1,W
	banksel	GLCDY
	movwf	GLCDY
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ST7735R
	call	PSET_ST7735R
	pagesel	$
;LineY1 += LineStepY
	movf	LINESTEPY,W
	banksel	LINEY1
	addwf	LINEY1,F
	banksel	LINESTEPY_H
	movf	LINESTEPY_H,W
	banksel	LINEY1_H
	addwfc	LINEY1_H,F
;if ( LineErr < 0) then
	banksel	LINEERR
	movf	LINEERR,W
	movwf	SysINTEGERTempA
	movf	LINEERR_H,W
	movwf	SysINTEGERTempA_H
	clrf	SysINTEGERTempB
	clrf	SysINTEGERTempB_H
	pagesel	SysCompLessThanINT
	call	SysCompLessThanINT
	pagesel	$
	btfss	SysByteTempX,0
	goto	ELSE30_1
;LineErr += LineDiffX_x2
	movf	LINEDIFFX_X2,W
	addwf	LINEERR,F
	movf	LINEDIFFX_X2_H,W
	addwfc	LINEERR_H,F
;else
	goto	ENDIF30
ELSE30_1
;LineErr += ( LineDiffX_x2 - LineDiffY_x2 )
	movf	LINEDIFFY_X2,W
	subwf	LINEDIFFX_X2,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	banksel	LINEDIFFY_X2_H
	movf	LINEDIFFY_X2_H,W
	subwfb	LINEDIFFX_X2_H,W
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H
	movf	SysTemp2,W
	banksel	LINEERR
	addwf	LINEERR,F
	banksel	SYSTEMP2_H
	movf	SysTemp2_H,W
	banksel	LINEERR_H
	addwfc	LINEERR_H,F
;LineX1 += LineStepX
	movf	LINESTEPX,W
	banksel	LINEX1
	addwf	LINEX1,F
	banksel	LINESTEPX_H
	movf	LINESTEPX_H,W
	banksel	LINEX1_H
	addwfc	LINEX1_H,F
;end if
ENDIF30
;loop
	goto	SysDoLoop_S6
SysDoLoop_E6
;PSet (   LineX1,   LineY1, LineColour )
	banksel	LINEX1
	movf	LINEX1,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	LINEY1
	movf	LINEY1,W
	banksel	GLCDY
	movwf	GLCDY
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ST7735R
	call	PSET_ST7735R
	pagesel	$
;end if
ENDIF28
	return

;********************************************************************************

OLEDFONT1DATA
	movf	SYSSTRINGA,W
	movwf	SysWORDTempA
	movf	SYSSTRINGA_H,W
	movwf	SysWORDTempA_H
	movlw	165
	movwf	SysWORDTempB
	movlw	1
	movwf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	retlw	0
	movf	SysStringA, W
	addlw	low TableOLEDFONT1DATA
	movwf	SysStringA
	movlw	(high TableOLEDFONT1DATA) & 127
	btfsc	STATUS, C
	addlw	1
	addwf	SysStringA_H, W
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableOLEDFONT1DATA
	retlw	165
	retlw	1
	retlw	0
	retlw	1
	retlw	94
	retlw	3
	retlw	6
	retlw	0
	retlw	6
	retlw	5
	retlw	40
	retlw	124
	retlw	40
	retlw	124
	retlw	40
	retlw	5
	retlw	36
	retlw	42
	retlw	127
	retlw	42
	retlw	16
	retlw	3
	retlw	98
	retlw	24
	retlw	70
	retlw	5
	retlw	48
	retlw	76
	retlw	90
	retlw	36
	retlw	80
	retlw	1
	retlw	6
	retlw	2
	retlw	60
	retlw	66
	retlw	2
	retlw	66
	retlw	60
	retlw	5
	retlw	40
	retlw	16
	retlw	124
	retlw	16
	retlw	40
	retlw	3
	retlw	16
	retlw	56
	retlw	16
	retlw	1
	retlw	192
	retlw	3
	retlw	16
	retlw	16
	retlw	16
	retlw	1
	retlw	64
	retlw	3
	retlw	96
	retlw	24
	retlw	6
	retlw	4
	retlw	60
	retlw	66
	retlw	66
	retlw	60
	retlw	3
	retlw	68
	retlw	126
	retlw	64
	retlw	4
	retlw	68
	retlw	98
	retlw	82
	retlw	76
	retlw	3
	retlw	74
	retlw	74
	retlw	52
	retlw	4
	retlw	30
	retlw	16
	retlw	124
	retlw	16
	retlw	3
	retlw	78
	retlw	74
	retlw	50
	retlw	4
	retlw	60
	retlw	74
	retlw	74
	retlw	48
	retlw	3
	retlw	98
	retlw	18
	retlw	14
	retlw	4
	retlw	52
	retlw	74
	retlw	74
	retlw	52
	retlw	4
	retlw	12
	retlw	82
	retlw	82
	retlw	60
	retlw	1
	retlw	72
	retlw	2
	retlw	128
	retlw	104
	retlw	3
	retlw	16
	retlw	40
	retlw	68
	retlw	3
	retlw	40
	retlw	40
	retlw	40
	retlw	3
	retlw	68
	retlw	40
	retlw	16
	retlw	3
	retlw	2
	retlw	82
	retlw	12
	retlw	5
	retlw	56
	retlw	68
	retlw	84
	retlw	84
	retlw	88
	retlw	4
	retlw	124
	retlw	18
	retlw	18
	retlw	124
	retlw	4
	retlw	126
	retlw	74
	retlw	74
	retlw	52
	retlw	4
	retlw	60
	retlw	66
	retlw	66
	retlw	36
	retlw	4
	retlw	126
	retlw	66
	retlw	66
	retlw	60
	retlw	3
	retlw	126
	retlw	74
	retlw	74
	retlw	3
	retlw	126
	retlw	10
	retlw	10
	retlw	4
	retlw	60
	retlw	66
	retlw	82
	retlw	52
	retlw	4
	retlw	126
	retlw	8
	retlw	8
	retlw	126
	retlw	3
	retlw	66
	retlw	126
	retlw	66
	retlw	3
	retlw	66
	retlw	66
	retlw	62
	retlw	4
	retlw	126
	retlw	8
	retlw	20
	retlw	98
	retlw	3
	retlw	126
	retlw	64
	retlw	64
	retlw	5
	retlw	126
	retlw	4
	retlw	8
	retlw	4
	retlw	126
	retlw	5
	retlw	126
	retlw	4
	retlw	24
	retlw	32
	retlw	126
	retlw	4
	retlw	60
	retlw	66
	retlw	66
	retlw	60
	retlw	4
	retlw	126
	retlw	18
	retlw	18
	retlw	12
	retlw	4
	retlw	60
	retlw	66
	retlw	66
	retlw	188
	retlw	4
	retlw	126
	retlw	18
	retlw	18
	retlw	108
	retlw	4
	retlw	68
	retlw	74
	retlw	74
	retlw	48
	retlw	3
	retlw	2
	retlw	126
	retlw	2
	retlw	4
	retlw	62
	retlw	64
	retlw	64
	retlw	62
	retlw	5
	retlw	6
	retlw	24
	retlw	96
	retlw	24
	retlw	6
	retlw	5
	retlw	62
	retlw	64
	retlw	62
	retlw	64
	retlw	62
	retlw	5
	retlw	66
	retlw	36
	retlw	24
	retlw	36
	retlw	66
	retlw	4
	retlw	158
	retlw	160
	retlw	160
	retlw	126
	retlw	4
	retlw	98
	retlw	82
	retlw	74
	retlw	70
	retlw	2
	retlw	126
	retlw	66
	retlw	3
	retlw	6
	retlw	24
	retlw	96
	retlw	2
	retlw	66
	retlw	126
	retlw	3
	retlw	32
	retlw	16
	retlw	32
	retlw	4
	retlw	128
	retlw	128
	retlw	128
	retlw	128
	retlw	2
	retlw	4
	retlw	8
	retlw	4
	retlw	32
	retlw	84
	retlw	84
	retlw	120
	retlw	4
	retlw	126
	retlw	68
	retlw	68
	retlw	56
	retlw	4
	retlw	56
	retlw	68
	retlw	68
	retlw	40
	retlw	4
	retlw	56
	retlw	68
	retlw	68
	retlw	126
	retlw	4
	retlw	56
	retlw	84
	retlw	84
	retlw	88
	retlw	2
	retlw	124
	retlw	10
	retlw	4
	retlw	152
	retlw	164
	retlw	164
	retlw	124
	retlw	4
	retlw	126
	retlw	4
	retlw	4
	retlw	120
	retlw	1
	retlw	122
	retlw	2
	retlw	64
	retlw	58
	retlw	4
	retlw	126
	retlw	16
	retlw	40
	retlw	68
	retlw	1
	retlw	126
	retlw	5
	retlw	124
	retlw	4
	retlw	120
	retlw	4
	retlw	120
	retlw	4
	retlw	124
	retlw	4
	retlw	4
	retlw	120
	retlw	4
	retlw	56
	retlw	68
	retlw	68
	retlw	56
	retlw	4
	retlw	252
	retlw	36
	retlw	36
	retlw	24
	retlw	4
	retlw	24
	retlw	36
	retlw	36
	retlw	252
	retlw	2
	retlw	124
	retlw	4
	retlw	4
	retlw	72
	retlw	84
	retlw	84
	retlw	32
	retlw	3
	retlw	4
	retlw	62
	retlw	68
	retlw	4
	retlw	60
	retlw	64
	retlw	64
	retlw	60
	retlw	5
	retlw	12
	retlw	48
	retlw	64
	retlw	48
	retlw	12
	retlw	5
	retlw	60
	retlw	64
	retlw	60
	retlw	64
	retlw	60
	retlw	5
	retlw	68
	retlw	40
	retlw	16
	retlw	40
	retlw	68
	retlw	4
	retlw	156
	retlw	160
	retlw	160
	retlw	124
	retlw	3
	retlw	100
	retlw	84
	retlw	76
	retlw	3
	retlw	8
	retlw	54
	retlw	65
	retlw	1
	retlw	255
	retlw	3
	retlw	65
	retlw	54
	retlw	8
	retlw	4
	retlw	32
	retlw	16
	retlw	32
	retlw	16
	retlw	1

;********************************************************************************

;Source: string.h (75)
FN_STR
;SysCharCount = 0
	banksel	SYSCHARCOUNT
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
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF71
;SysStrData = SysValTemp / 10000
	banksel	SYSVALTEMP
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB
	movlw	39
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempA,W
	banksel	SYSSTRDATA
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
	clrf	SysTemp1
	movlw	high(STR)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF0
;Goto SysValThousands
	goto	SYSVALTHOUSANDS
;End If
ENDIF71
;Thousands
;IF SysValTemp >= 1000 then
	banksel	SYSVALTEMP
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB
	movlw	3
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF72
SYSVALTHOUSANDS
;SysStrData = SysValTemp / 1000
	banksel	SYSVALTEMP
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB
	movlw	3
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempA,W
	banksel	SYSSTRDATA
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
	clrf	SysTemp1
	movlw	high(STR)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF0
;Goto SysValHundreds
	goto	SYSVALHUNDREDS
;End If
ENDIF72
;Hundreds
;IF SysValTemp >= 100 then
	banksel	SYSVALTEMP
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF73
SYSVALHUNDREDS
;SysStrData = SysValTemp / 100
	banksel	SYSVALTEMP
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempA,W
	banksel	SYSSTRDATA
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
	clrf	SysTemp1
	movlw	high(STR)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF0
;Goto SysValTens
	goto	SYSVALTENS
;End If
ENDIF73
;Tens
;IF SysValTemp >= 10 Then
	banksel	SYSVALTEMP
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF74
SYSVALTENS
;SysStrData = SysValTemp / 10
	banksel	SYSVALTEMP
	movf	SYSVALTEMP,W
	movwf	SysWORDTempA
	movf	SYSVALTEMP_H,W
	movwf	SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempA,W
	banksel	SYSSTRDATA
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
	clrf	SysTemp1
	movlw	high(STR)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movlw	48
	addwf	SYSSTRDATA,W
	movwf	INDF0
;End If
ENDIF74
;Ones
;SysCharCount += 1
	banksel	SYSCHARCOUNT
	incf	SYSCHARCOUNT,F
;Str(SysCharCount) = SysValTemp + 48
	movlw	low(STR)
	addwf	SYSCHARCOUNT,W
	movwf	AFSR0
	clrf	SysTemp1
	movlw	high(STR)
	addwfc	SysTemp1,W
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

;Source: system.h (2702)
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

SysStringTables
	movf	SysStringA_H,W
	movwf	PCLATH
	movf	SysStringA,W
	incf	SysStringA,F
	btfsc	STATUS,Z
	incf	SysStringA_H,F
	movwf	PCL

StringTable1
	retlw	5
	retlw	71	;G
	retlw	114	;r
	retlw	101	;e
	retlw	97	;a
	retlw	116	;t


StringTable2
	retlw	4
	retlw	32	; 
	retlw	67	;C
	retlw	111	;o
	retlw	119	;w


StringTable3
	retlw	11
	retlw	32	; 
	retlw	66	;B
	retlw	65	;A
	retlw	83	;S
	retlw	73	;I
	retlw	67	;C
	retlw	32	; 
	retlw	50	;2
	retlw	48	;0
	retlw	50	;2
	retlw	48	;0


StringTable4
	retlw	23
	retlw	65	;A
	retlw	68	;D
	retlw	65	;A
	retlw	70	;F
	retlw	82	;R
	retlw	85	;U
	retlw	73	;I
	retlw	84	;T
	retlw	32	; 
	retlw	77	;M
	retlw	73	;I
	retlw	78	;N
	retlw	73	;I
	retlw	32	; 
	retlw	67	;C
	retlw	79	;O
	retlw	76	;L
	retlw	79	;O
	retlw	82	;R
	retlw	32	; 
	retlw	84	;T
	retlw	70	;F
	retlw	84	;T


StringTable5
	retlw	25
	retlw	87	;W
	retlw	73	;I
	retlw	84	;T
	retlw	72	;H
	retlw	32	; 
	retlw	74	;J
	retlw	79	;O
	retlw	89	;Y
	retlw	83	;S
	retlw	84	;T
	retlw	73	;I
	retlw	67	;C
	retlw	75	;K
	retlw	32	; 
	retlw	70	;F
	retlw	69	;E
	retlw	65	;A
	retlw	84	;T
	retlw	72	;H
	retlw	69	;E
	retlw	82	;R
	retlw	87	;W
	retlw	73	;I
	retlw	78	;N
	retlw	71	;G


StringTable6
	retlw	8
	retlw	66	;B
	retlw	117	;u
	retlw	116	;t
	retlw	116	;t
	retlw	111	;o
	retlw	110	;n
	retlw	32	; 
	retlw	65	;A


StringTable7
	retlw	8
	retlw	66	;B
	retlw	117	;u
	retlw	116	;t
	retlw	116	;t
	retlw	111	;o
	retlw	110	;n
	retlw	32	; 
	retlw	66	;B


StringTable8
	retlw	6
	retlw	83	;S
	retlw	101	;e
	retlw	108	;l
	retlw	101	;e
	retlw	99	;c
	retlw	116	;t


StringTable9
	retlw	4
	retlw	85	;U
	retlw	112	;p
	retlw	32	; 
	retlw	32	; 


StringTable10
	retlw	6
	retlw	76	;L
	retlw	101	;e
	retlw	102	;f
	retlw	116	;t
	retlw	32	; 
	retlw	32	; 


StringTable11
	retlw	4
	retlw	68	;D
	retlw	111	;o
	retlw	119	;w
	retlw	110	;n


StringTable12
	retlw	7
	retlw	82	;R
	retlw	105	;i
	retlw	103	;g
	retlw	104	;h
	retlw	116	;t
	retlw	32	; 
	retlw	32	; 


;********************************************************************************

;Start of program memory page 3
	ORG	6144
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

;Source: glcd_st7735.h (824)
FILLEDBOX_ST7735
;Make sure that starting point (1) is always less than end point (2)
;If LineX1 > LineX2 Then
	banksel	LINEX1
	movf	LINEX1,W
	subwf	LINEX2,W
	btfsc	STATUS, C
	goto	ENDIF41
;GLCDTemp = LineX1
	movf	LINEX1,W
	banksel	GLCDTEMP
	movwf	GLCDTEMP
;LineX1 = LineX2
	banksel	LINEX2
	movf	LINEX2,W
	movwf	LINEX1
;LineX2 = GLCDTemp
	banksel	GLCDTEMP
	movf	GLCDTEMP,W
	banksel	LINEX2
	movwf	LINEX2
;End If
ENDIF41
;If LineY1 > LineY2 Then
	movf	LINEY1,W
	subwf	LINEY2,W
	btfsc	STATUS, C
	goto	ENDIF42
;GLCDTemp = LineY1
	movf	LINEY1,W
	banksel	GLCDTEMP
	movwf	GLCDTEMP
;LineY1 = LineY2
	banksel	LINEY2
	movf	LINEY2,W
	movwf	LINEY1
;LineY2 = GLCDTemp
	banksel	GLCDTEMP
	movf	GLCDTEMP,W
	banksel	LINEY2
	movwf	LINEY2
;End If
ENDIF42
;Set address window
;SetAddress_ST7735 ST7735_COLUMN, LineX1, LineX2
	movlw	42
	movwf	ST7735ADDRESSTYPE
	movf	LINEX1,W
	movwf	ST7735START
	clrf	ST7735START_H
	movf	LINEX2,W
	movwf	ST7735END
	clrf	ST7735END_H
	banksel	STATUS
	pagesel	SETADDRESS_ST7735
	call	SETADDRESS_ST7735
	pagesel	$
;SetAddress_ST7735 ST7735_ROW, LineY1, LineY2
	movlw	43
	banksel	ST7735ADDRESSTYPE
	movwf	ST7735ADDRESSTYPE
	movf	LINEY1,W
	movwf	ST7735START
	clrf	ST7735START_H
	movf	LINEY2,W
	movwf	ST7735END
	clrf	ST7735END_H
	banksel	STATUS
	pagesel	SETADDRESS_ST7735
	call	SETADDRESS_ST7735
	pagesel	$
;Fill with colour
;Dim GLCDPixelCount As Word
;GLCDPixelCount = (LineX2 - LineX1 + 1) * (LineY2 - LineY1 + 1)
	banksel	LINEX1
	movf	LINEX1,W
	subwf	LINEX2,W
	movwf	SysTemp1
	incf	SysTemp1,W
	movwf	SysTemp2
	movf	LINEY1,W
	subwf	LINEY2,W
	movwf	SysTemp1
	incf	SysTemp1,W
	movwf	SysTemp3
	movf	SysTemp2,W
	movwf	SysWORDTempA
	clrf	SysWORDTempA_H
	movf	SysTemp3,W
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	call	SysMultSub16
	movf	SysWORDTempX,W
	movwf	GLCDPIXELCOUNT
	movf	SysWORDTempX_H,W
	movwf	GLCDPIXELCOUNT_H
;SendCommand_ST7735 0x2C
	movlw	44
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	call	SENDCOMMAND_ST7735
;Repeat GLCDPixelCount
	movf	GLCDPIXELCOUNT,W
	banksel	SYSREPEATTEMP2
	movwf	SysRepeatTemp2
	banksel	GLCDPIXELCOUNT_H
	movf	GLCDPIXELCOUNT_H,W
	banksel	SYSREPEATTEMP2_H
	movwf	SysRepeatTemp2_H
	movf	SYSREPEATTEMP2,W
	movwf	SysWORDTempA
	movf	SYSREPEATTEMP2_H,W
	movwf	SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0
	goto	SysRepeatLoopEnd2
	banksel	SYSREPEATTEMP2
	movf	SYSREPEATTEMP2,F
	btfss	STATUS, Z
	incf	SysRepeatTemp2_H,F
SysRepeatLoop2
;SendWord_ST7735 LineColour
	banksel	LINECOLOUR
	movf	LINECOLOUR,W
	banksel	ST7735SENDWORD
	movwf	ST7735SENDWORD
	banksel	LINECOLOUR_H
	movf	LINECOLOUR_H,W
	banksel	ST7735SENDWORD_H
	movwf	ST7735SENDWORD_H
	banksel	STATUS
	call	SENDWORD_ST7735
;End Repeat
	banksel	SYSREPEATTEMP2
	decfsz	SysRepeatTemp2,F
	goto	SysRepeatLoop2
	decfsz	SysRepeatTemp2_H,F
	goto	SysRepeatLoop2
SysRepeatLoopEnd2
	banksel	STATUS
	return

;********************************************************************************

;Source: glcd_st7735.h (602)
GLCDCLS_ST7735
;initialise global variable. Required variable for Circle in all DEVICE DRIVERS- DO NOT DELETE
;GLCD_yordinate = 0
	clrf	GLCD_YORDINATE
	clrf	GLCD_YORDINATE_H
;Dim PrintLocX, PrintLocY as word
;PrintLocX = 0
	banksel	PRINTLOCX
	clrf	PRINTLOCX
	clrf	PRINTLOCX_H
;PrintLocY = 0
	clrf	PRINTLOCY
	clrf	PRINTLOCY_H
;SetAddress_ST7735 ST7735_COLUMN, 0, GLCDDeviceWidth
	movlw	42
	movwf	ST7735ADDRESSTYPE
	clrf	ST7735START
	clrf	ST7735START_H
	banksel	GLCDDEVICEWIDTH
	movf	GLCDDEVICEWIDTH,W
	banksel	ST7735END
	movwf	ST7735END
	banksel	GLCDDEVICEWIDTH_H
	movf	GLCDDEVICEWIDTH_H,W
	banksel	ST7735END_H
	movwf	ST7735END_H
	banksel	STATUS
	pagesel	SETADDRESS_ST7735
	call	SETADDRESS_ST7735
	pagesel	$
;wait 2 ms
	movlw	2
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;SetAddress_ST7735 ST7735_ROW, 0, GLCDDeviceHeight
	movlw	43
	banksel	ST7735ADDRESSTYPE
	movwf	ST7735ADDRESSTYPE
	clrf	ST7735START
	clrf	ST7735START_H
	banksel	GLCDDEVICEHEIGHT
	movf	GLCDDEVICEHEIGHT,W
	banksel	ST7735END
	movwf	ST7735END
	banksel	GLCDDEVICEHEIGHT_H
	movf	GLCDDEVICEHEIGHT_H,W
	banksel	ST7735END_H
	movwf	ST7735END_H
	banksel	STATUS
	pagesel	SETADDRESS_ST7735
	call	SETADDRESS_ST7735
	pagesel	$
;wait 2 ms
	movlw	2
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;SendCommand_ST7735 ST7735_RAMWR
	movlw	44
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	call	SENDCOMMAND_ST7735
;wait 2 ms
	movlw	2
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;Repeat [word] GLCD_WIDTH * GLCD_HEIGHT
	banksel	SYSREPEATTEMP1
	clrf	SYSREPEATTEMP1
	movlw	50
	movwf	SYSREPEATTEMP1_H
	movf	SYSREPEATTEMP1,W
	movwf	SysWORDTempA
	movf	SYSREPEATTEMP1_H,W
	movwf	SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0
	goto	SysRepeatLoopEnd1
	banksel	SYSREPEATTEMP1
	movf	SYSREPEATTEMP1,F
	btfss	STATUS, Z
	incf	SysRepeatTemp1_H,F
SysRepeatLoop1
;SendWord_ST7735 GLCDBackground
	banksel	GLCDBACKGROUND
	movf	GLCDBACKGROUND,W
	banksel	ST7735SENDWORD
	movwf	ST7735SENDWORD
	banksel	GLCDBACKGROUND_H
	movf	GLCDBACKGROUND_H,W
	banksel	ST7735SENDWORD_H
	movwf	ST7735SENDWORD_H
	banksel	STATUS
	call	SENDWORD_ST7735
;End Repeat
	banksel	SYSREPEATTEMP1
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop1
	decfsz	SysRepeatTemp1_H,F
	goto	SysRepeatLoop1
SysRepeatLoopEnd1
	banksel	STATUS
	return

;********************************************************************************

;Source: glcd.h (1211)
GLCDLOCATESTRING
;dim PrintLocY as word
;if PrintLocY < 2 then
	banksel	PRINTLOCY
	movf	PRINTLOCY,W
	movwf	SysWORDTempA
	movf	PRINTLOCY_H,W
	movwf	SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	call	SysCompLessThan16
	btfss	SysByteTempX,0
	goto	ELSE17_1
;PrintLocY = 0
	banksel	PRINTLOCY
	clrf	PRINTLOCY
	clrf	PRINTLOCY_H
;else
	goto	ENDIF17
ELSE17_1
;PrintLocY--
	movlw	1
	banksel	PRINTLOCY
	subwf	PRINTLOCY,F
	movlw	0
	subwfb	PRINTLOCY_H,F
;PrintLocY = ( PrintLocY * ( GLCDfntDefaultHeight * GLCDfntDefaultSize ) ) mod GLCD_HEIGHT
	banksel	GLCDFNTDEFAULTHEIGHT
	movf	GLCDFNTDEFAULTHEIGHT,W
	movwf	SysBYTETempA
	movf	GLCDFNTDEFAULTSIZE,W
	movwf	SysBYTETempB
	call	SysMultSub
	movf	SysBYTETempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movf	PRINTLOCY,W
	movwf	SysWORDTempA
	movf	PRINTLOCY_H,W
	movwf	SysWORDTempA_H
	movf	SysTemp1,W
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	call	SysMultSub16
	movf	SysWORDTempX,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movf	SysWORDTempX_H,W
	movwf	SysTemp2_H
	movf	SysTemp2,W
	movwf	SysWORDTempA
	movf	SysTemp2_H,W
	movwf	SysWORDTempA_H
	movlw	160
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	call	SysDivSub16
	movf	SysWORDTempX,W
	banksel	PRINTLOCY
	movwf	PRINTLOCY
	movf	SysWORDTempX_H,W
	movwf	PRINTLOCY_H
;end if
ENDIF17
	banksel	STATUS
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:STRING:, Source: glcd.h (932)
GLCDPRINT4
;GLCD.h Sub GLCDPrint
;Dim GLCDPrintLoc  as word
;Dim GLCDPrint_String_Counter, GLCDPrintLen as byte
;GLCDPrintLen = LCDPrintData(0)
	banksel	SYSLCDPRINTDATAHANDLER
	movf	SysLCDPRINTDATAHandler,W
	movwf	AFSR0
	movf	SysLCDPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	GLCDPRINTLEN
	movwf	GLCDPRINTLEN
;If GLCDPrintLen = 0 Then Exit Sub
	movf	GLCDPRINTLEN,F
	btfsc	STATUS, Z
	return
;dim OldGLCDFontWidth as Byte
;OldGLCDFontWidth = GLCDFontWidth
	movf	GLCDFONTWIDTH,W
	banksel	OLDGLCDFONTWIDTH
	movwf	OLDGLCDFONTWIDTH
;GLCDPrintLoc = PrintLocX
	movf	PRINTLOCX,W
	banksel	GLCDPRINTLOC
	movwf	GLCDPRINTLOC
	banksel	PRINTLOCX_H
	movf	PRINTLOCX_H,W
	banksel	GLCDPRINTLOC_H
	movwf	GLCDPRINTLOC_H
;Write Data
;For GLCDPrint_String_Counter = 1 To GLCDPrintLen
	clrf	GLCDPRINT_STRING_COUNTER
	movlw	1
	subwf	GLCDPRINTLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd1
SysForLoop1
	incf	GLCDPRINT_STRING_COUNTER,F
;GLCDDrawChar  GLCDPrintLoc, PrintLocY, LCDPrintData(GLCDPrint_String_Counter)
	movf	GLCDPRINTLOC,W
	movwf	CHARLOCX
	movf	GLCDPRINTLOC_H,W
	movwf	CHARLOCX_H
	banksel	PRINTLOCY
	movf	PRINTLOCY,W
	banksel	CHARLOCY
	movwf	CHARLOCY
	banksel	PRINTLOCY_H
	movf	PRINTLOCY_H,W
	banksel	CHARLOCY_H
	movwf	CHARLOCY_H
	movf	GLCDPRINT_STRING_COUNTER,W
	banksel	SYSLCDPRINTDATAHANDLER
	addwf	SysLCDPRINTDATAHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysLCDPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	CHARCODE
	movwf	CHARCODE
	movf	GLCDFOREGROUND,W
	movwf	LINECOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	LINECOLOUR_H
	pagesel	GLCDDRAWCHAR_ST7735
	call	GLCDDRAWCHAR_ST7735
	pagesel	$
;GLCDPrintIncrementPixelPositionMacro
;Macro Source: glcd.h (1170)
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize ) + GLCDfntDefaultsize - 1
	movf	GLCDFONTWIDTH,W
	movwf	SysBYTETempA
	movf	GLCDFNTDEFAULTSIZE,W
	movwf	SysBYTETempB
	call	SysMultSub
	movf	SysBYTETempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	GLCDPRINTLOC
	addwf	GLCDPRINTLOC,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	0
	banksel	GLCDPRINTLOC_H
	addwfc	GLCDPRINTLOC_H,W
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H
	banksel	GLCDFNTDEFAULTSIZE
	movf	GLCDFNTDEFAULTSIZE,W
	banksel	SYSTEMP2
	addwf	SysTemp2,W
	movwf	SysTemp1
	movlw	0
	addwfc	SysTemp2_H,W
	movwf	SysTemp1_H
	movlw	1
	subwf	SysTemp1,W
	banksel	GLCDPRINTLOC
	movwf	GLCDPRINTLOC
	movlw	0
	banksel	SYSTEMP1_H
	subwfb	SysTemp1_H,W
	banksel	GLCDPRINTLOC_H
	movwf	GLCDPRINTLOC_H
;Next
	movf	GLCDPRINTLEN,W
	subwf	GLCDPRINT_STRING_COUNTER,W
	btfss	STATUS, C
	goto	SysForLoop1
SysForLoopEnd1
;Update the current X position for GLCDPrintString
;PrintLocX = GLCDPrintLoc
	movf	GLCDPRINTLOC,W
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	banksel	GLCDPRINTLOC_H
	movf	GLCDPRINTLOC_H,W
	banksel	PRINTLOCX_H
	movwf	PRINTLOCX_H
;GLCDFontWidth = OldGLCDFontWidth
	movf	OLDGLCDFONTWIDTH,W
	banksel	GLCDFONTWIDTH
	movwf	GLCDFONTWIDTH
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:STRING:WORD:, Source: glcd.h (961)
GLCDPRINT5
;Dim GLCDPrintLoc as word
;GLCDPrintLen = LCDPrintData(0)
	banksel	SYSLCDPRINTDATAHANDLER
	movf	SysLCDPRINTDATAHandler,W
	movwf	AFSR0
	movf	SysLCDPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	GLCDPRINTLEN
	movwf	GLCDPRINTLEN
;If GLCDPrintLen = 0 Then Exit Sub
	movf	GLCDPRINTLEN,F
	btfsc	STATUS, Z
	return
;dim OldGLCDFontWidth as Byte
;OldGLCDFontWidth = GLCDFontWidth
	movf	GLCDFONTWIDTH,W
	banksel	OLDGLCDFONTWIDTH
	movwf	OLDGLCDFONTWIDTH
;GLCDPrintLoc = PrintLocX
	movf	PRINTLOCX,W
	banksel	GLCDPRINTLOC
	movwf	GLCDPRINTLOC
	banksel	PRINTLOCX_H
	movf	PRINTLOCX_H,W
	banksel	GLCDPRINTLOC_H
	movwf	GLCDPRINTLOC_H
;Write Data
;For GLCDPrint_String_Counter = 1 To GLCDPrintLen
	clrf	GLCDPRINT_STRING_COUNTER
	movlw	1
	subwf	GLCDPRINTLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd2
SysForLoop2
	incf	GLCDPRINT_STRING_COUNTER,F
;GLCDDrawChar GLCDPrintLoc, PrintLocY, LCDPrintData(GLCDPrint_String_Counter), LineColour
	movf	GLCDPRINTLOC,W
	movwf	CHARLOCX
	movf	GLCDPRINTLOC_H,W
	movwf	CHARLOCX_H
	banksel	PRINTLOCY
	movf	PRINTLOCY,W
	banksel	CHARLOCY
	movwf	CHARLOCY
	banksel	PRINTLOCY_H
	movf	PRINTLOCY_H,W
	banksel	CHARLOCY_H
	movwf	CHARLOCY_H
	movf	GLCDPRINT_STRING_COUNTER,W
	banksel	SYSLCDPRINTDATAHANDLER
	addwf	SysLCDPRINTDATAHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysLCDPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	CHARCODE
	movwf	CHARCODE
	pagesel	GLCDDRAWCHAR_ST7735
	call	GLCDDRAWCHAR_ST7735
	pagesel	$
;GLCDPrintIncrementPixelPositionMacro
;Macro Source: glcd.h (1170)
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize ) + GLCDfntDefaultsize - 1
	movf	GLCDFONTWIDTH,W
	movwf	SysBYTETempA
	movf	GLCDFNTDEFAULTSIZE,W
	movwf	SysBYTETempB
	call	SysMultSub
	movf	SysBYTETempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	GLCDPRINTLOC
	addwf	GLCDPRINTLOC,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	0
	banksel	GLCDPRINTLOC_H
	addwfc	GLCDPRINTLOC_H,W
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H
	banksel	GLCDFNTDEFAULTSIZE
	movf	GLCDFNTDEFAULTSIZE,W
	banksel	SYSTEMP2
	addwf	SysTemp2,W
	movwf	SysTemp1
	movlw	0
	addwfc	SysTemp2_H,W
	movwf	SysTemp1_H
	movlw	1
	subwf	SysTemp1,W
	banksel	GLCDPRINTLOC
	movwf	GLCDPRINTLOC
	movlw	0
	banksel	SYSTEMP1_H
	subwfb	SysTemp1_H,W
	banksel	GLCDPRINTLOC_H
	movwf	GLCDPRINTLOC_H
;Next
	movf	GLCDPRINTLEN,W
	subwf	GLCDPRINT_STRING_COUNTER,W
	btfss	STATUS, C
	goto	SysForLoop2
SysForLoopEnd2
;Update the current X position for GLCDPrintString
;PrintLocX = GLCDPrintLoc
	movf	GLCDPRINTLOC,W
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	banksel	GLCDPRINTLOC_H
	movf	GLCDPRINTLOC_H,W
	banksel	PRINTLOCX_H
	movwf	PRINTLOCX_H
;GLCDFontWidth = OldGLCDFontWidth
	movf	OLDGLCDFONTWIDTH,W
	banksel	GLCDFONTWIDTH
	movwf	GLCDFONTWIDTH
	return

;********************************************************************************

;Source: glcd.h (1183)
GLCDPRINTSTRING
;dim PrintLocX as word
;Print at the current X and Y post
;GLCDPrint( PrintLocX , PrintLocY , LCDPrintData )
	banksel	SYSLCDPRINTDATAHANDLER
	movf	SysLCDPRINTDATAHandler,W
	movwf	SysLCDPRINTDATAHandler
	movf	SysLCDPRINTDATAHandler_H,W
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	goto	GLCDPRINT4

;********************************************************************************

;Source: glcd_st7735.h (1060)
GLCDROTATE_ST7735
;SendCommand_ST7735 ( ST7735_MADCTL )
	movlw	54
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	call	SENDCOMMAND_ST7735
;select case GLCDRotateState
;case LANDSCAPE
SysSelect3Case1
	decf	GLCDROTATESTATE,W
	btfss	STATUS, Z
	goto	SysSelect3Case2
;IF ST7735TABCOLOR = ST7735_BLACKTAB or ST7735TABCOLOR = ST7735_MINI160x80 or GLCD_TYPE = GLCD_TYPE_ST7735R_160_80 then
;SendData_ST7735( ST7735_MADCTL_MX | ST7735_MADCTL_MV |  ST7735_MADCTL_RGB )
	movlw	96
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	call	SENDDATA_ST7735
;else
;GLCDDeviceWidth = GLCD_HEIGHT - 1
	movlw	159
	movwf	GLCDDEVICEWIDTH
	clrf	GLCDDEVICEWIDTH_H
;GLCDDeviceHeight = GLCD_WIDTH - 1
	movlw	79
	movwf	GLCDDEVICEHEIGHT
	clrf	GLCDDEVICEHEIGHT_H
;case PORTRAIT_REV
	goto	SysSelectEnd3
SysSelect3Case2
	movlw	2
	subwf	GLCDROTATESTATE,W
	btfss	STATUS, Z
	goto	SysSelect3Case3
;GLCDDeviceWidth = GLCD_WIDTH - 1
	movlw	79
	movwf	GLCDDEVICEWIDTH
	clrf	GLCDDEVICEWIDTH_H
;GLCDDeviceHeight = GLCD_HEIGHT - 1
	movlw	159
	movwf	GLCDDEVICEHEIGHT
	clrf	GLCDDEVICEHEIGHT_H
;IF ST7735TABCOLOR = ST7735_BLACKTAB or ST7735TABCOLOR = ST7735_MINI160x80 or GLCD_TYPE = GLCD_TYPE_ST7735R_160_80 then
;SendData_ST7735( ST7735_MADCTL_RGB )
	banksel	ST7735SENDBYTE
	clrf	ST7735SENDBYTE
	banksel	STATUS
	call	SENDDATA_ST7735
;else
;case LANDSCAPE_REV
	goto	SysSelectEnd3
SysSelect3Case3
	movlw	3
	subwf	GLCDROTATESTATE,W
	btfss	STATUS, Z
	goto	SysSelect3Case4
;IF ST7735TABCOLOR = ST7735_BLACKTAB or ST7735TABCOLOR = ST7735_MINI160x80 or GLCD_TYPE = GLCD_TYPE_ST7735R_160_80 then
;SendData_ST7735( ST7735_MADCTL_MV | ST7735_MADCTL_MY | ST7735_MADCTL_RGB )
	movlw	160
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	call	SENDDATA_ST7735
;else
;GLCDDeviceWidth = GLCD_HEIGHT - 1
	movlw	159
	movwf	GLCDDEVICEWIDTH
	clrf	GLCDDEVICEWIDTH_H
;GLCDDeviceHeight = GLCD_WIDTH - 1
	movlw	79
	movwf	GLCDDEVICEHEIGHT
	clrf	GLCDDEVICEHEIGHT_H
;case PORTRAIT
	goto	SysSelectEnd3
SysSelect3Case4
	movlw	4
	subwf	GLCDROTATESTATE,W
	btfss	STATUS, Z
	goto	SysSelect3Case5
;GLCDDeviceWidth = GLCD_WIDTH - 1
	movlw	79
	movwf	GLCDDEVICEWIDTH
	clrf	GLCDDEVICEWIDTH_H
;GLCDDeviceHeight = GLCD_HEIGHT - 1
	movlw	159
	movwf	GLCDDEVICEHEIGHT
	clrf	GLCDDEVICEHEIGHT_H
;IF ST7735TABCOLOR = ST7735_BLACKTAB or ST7735TABCOLOR = ST7735_MINI160x80 or GLCD_TYPE = GLCD_TYPE_ST7735R_160_80 then
;SendData_ST7735( ST7735_MADCTL_MX | ST7735_MADCTL_MY | ST7735_MADCTL_RGB )
	movlw	192
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	call	SENDDATA_ST7735
;else
;case else
	goto	SysSelectEnd3
SysSelect3Case5
;GLCDDeviceWidth = GLCD_WIDTH - 1
	movlw	79
	movwf	GLCDDEVICEWIDTH
	clrf	GLCDDEVICEWIDTH_H
;GLCDDeviceHeight = GLCD_HEIGHT - 1
	movlw	159
	movwf	GLCDDEVICEHEIGHT
	clrf	GLCDDEVICEHEIGHT_H
;IF ST7735TABCOLOR = ST7735_BLACKTAB or ST7735TABCOLOR = ST7735_MINI160x80 or GLCD_TYPE = GLCD_TYPE_ST7735R_160_80 then
;SendData_ST7735( ST7735_MADCTL_MX | ST7735_MADCTL_MY | ST7735_MADCTL_RGB )
	movlw	192
	banksel	ST7735SENDBYTE
	movwf	ST7735SENDBYTE
	banksel	STATUS
	call	SENDDATA_ST7735
;else
;end select
SysSelectEnd3
	return

;********************************************************************************

;Source: string.h (335)
FN_HEX
;Hex(0) = 2
	movlw	2
	banksel	SYSHEX_0
	movwf	SYSHEX_0
;Low nibble
;SysStringTemp = SysValTemp And 0x0F
	movlw	15
	banksel	SYSVALTEMP
	andwf	SYSVALTEMP,W
	movwf	SYSSTRINGTEMP
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	sublw	9
	btfsc	STATUS, C
	goto	ENDIF75
	movlw	7
	addwf	SYSSTRINGTEMP,F
ENDIF75
;Hex(2) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W
	banksel	SYSHEX_2
	movwf	SYSHEX_2
;Get high nibble
;For SysStringTemp = 1 to 4
	banksel	SYSSTRINGTEMP
	clrf	SYSSTRINGTEMP
SysForLoop8
	incf	SYSSTRINGTEMP,F
;Rotate SysValTemp Right
	rrf	SYSVALTEMP,F
;Next
	movlw	4
	subwf	SYSSTRINGTEMP,W
	btfss	STATUS, C
	goto	SysForLoop8
SysForLoopEnd8
;SysStringTemp = SysValTemp And 0x0F
	movlw	15
	andwf	SYSVALTEMP,W
	movwf	SYSSTRINGTEMP
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	sublw	9
	btfsc	STATUS, C
	goto	ENDIF77
	movlw	7
	addwf	SYSSTRINGTEMP,F
ENDIF77
;Hex(1) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W
	banksel	SYSHEX_1
	movwf	SYSHEX_1
	banksel	STATUS
	return

;********************************************************************************

;Source: hwi2c.h (246)
HI2CMODE
;asm showdebug  This method sets the variable `HI2CCurrentMode`, and, if required, sets the SSPCON1.bits
;this method sets the variable `hi2ccurrentmode`, &, if required, sets the ssp1con1.bits
;#ifdef var(SSPCON1) added to separate from newer i2C module which does not have an SSPCON1
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
	goto	ENDIF78
;set SSPCON1.SSPM3 on
	banksel	SSP1CON1
	bsf	SSP1CON1,SSPM3
;set SSPCON1.SSPM2 off
	bcf	SSP1CON1,SSPM2
;set SSPCON1.SSPM1 off
	bcf	SSP1CON1,SSPM1
;set SSPCON1.SSPM0 off
	bcf	SSP1CON1,SSPM0
;SSPADD = HI2C_BAUD_TEMP and 127
	movlw	19
	movwf	SSP1ADD
;end if
ENDIF78
;if HI2CCurrentMode = Slave then
	banksel	HI2CCURRENTMODE
	movf	HI2CCURRENTMODE,F
	btfss	STATUS, Z
	goto	ENDIF79
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
ENDIF79
;if HI2CCurrentMode = Slave10 then
	movlw	3
	banksel	HI2CCURRENTMODE
	subwf	HI2CCURRENTMODE,W
	btfss	STATUS, Z
	goto	ENDIF80
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
ENDIF80
;Enable I2C
;set SSPCON1.SSPEN on
	banksel	SSP1CON1
	bsf	SSP1CON1,SSPEN
	banksel	STATUS
	return

;********************************************************************************

;Source: hwi2c.h (331)
HI2CRESTART
;asm showdebug  This method sets the registers and register bits to generate the I2C  RESTART signal
;this method sets the registers & register bits to generate the i2c restart signal
;If HI2CCurrentMode > 10 Then
	movf	HI2CCURRENTMODE,W
	sublw	10
	btfsc	STATUS, C
	goto	ENDIF82
;Master_mode operational
;Set RSEN On
	banksel	SSP1CON2
	bsf	SSP1CON2,RSEN
;HI2CWaitMSSP
	banksel	STATUS
	call	HI2CWAITMSSP
;End If
ENDIF82
	return

;********************************************************************************

;Source: hwi2c.h (413)
HI2CSEND
;asm showdebug  This method sets the registers and register bits to send I2C data
;this method sets the registers & register bits to send i2c data
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
	goto	ELSE84_1
;HI2CAckPollState = true
	movlw	255
	banksel	HI2CACKPOLLSTATE
	movwf	HI2CACKPOLLSTATE
;else
	goto	ENDIF84
ELSE84_1
;HI2CAckPollState = false
	banksel	HI2CACKPOLLSTATE
	clrf	HI2CACKPOLLSTATE
;end if
ENDIF84
;If SSPCON1.WCOL = On Then
	banksel	SSP1CON1
	btfss	SSP1CON1,WCOL
	goto	ENDIF85
;If HI2CCurrentMode <= 10 Then Goto RetryHI2CSend
	banksel	HI2CCURRENTMODE
	movf	HI2CCURRENTMODE,W
	sublw	10
	btfsc	STATUS, C
	goto	RETRYHI2CSEND
;End If
ENDIF85
;Release clock (only needed by slave)
;If HI2CCurrentMode <= 10 Then Set SSPCON1.CKP On
	banksel	HI2CCURRENTMODE
	movf	HI2CCURRENTMODE,W
	sublw	10
	btfss	STATUS, C
	goto	ENDIF86
	banksel	SSP1CON1
	bsf	SSP1CON1,CKP
ENDIF86
	banksel	STATUS
	return

;********************************************************************************

;Source: hwi2c.h (301)
HI2CSTART
;asm showdebug  This method sets the registers and register bits to generate the I2C  START signal
;this method sets the registers & register bits to generate the i2c start signal
;If HI2CCurrentMode > 10 Then
	movf	HI2CCURRENTMODE,W
	sublw	10
	btfsc	STATUS, C
	goto	ELSE81_1
;Master_mode operational
;Set SEN On
	banksel	SSP1CON2
	bsf	SSP1CON2,SEN
;HI2CWaitMSSP
	banksel	STATUS
	call	HI2CWAITMSSP
;for device with SEN_SSP1CON2 and therefore devices including the 18FxxK40
;Else
	goto	ENDIF81
ELSE81_1
;Slave mode operational
;Wait Until SSPSTAT.S = On
SysWaitLoop1
	banksel	SSP1STAT
	btfss	SSP1STAT,S
	goto	SysWaitLoop1
;End If
ENDIF81
	banksel	STATUS
	return

;********************************************************************************

;Source: hwi2c.h (348)
HI2CSTOP
;Master_mode
;If HI2CCurrentMode > 10 Then
	movf	HI2CCURRENTMODE,W
	sublw	10
	btfsc	STATUS, C
	goto	ELSE83_1
;set SSPIE OFF; disable SSP interrupt, tested by Anobium but not implemented.
;wait while R_NOT_W = 1   'wait for completion of activities
SysWaitLoop2
	banksel	SSP1STAT
	btfsc	SSP1STAT,R_NOT_W
	goto	SysWaitLoop2
;Set SSPCON2.PEN On
	bsf	SSP1CON2,PEN
;HI2CWaitMSSP
	banksel	STATUS
	call	HI2CWAITMSSP
;Slave mode
;Else
	goto	ENDIF83
ELSE83_1
;Wait Until SSPSTAT.P = On
SysWaitLoop3
	banksel	SSP1STAT
	btfss	SSP1STAT,P
	goto	SysWaitLoop3
;End If
ENDIF83
	banksel	STATUS
	return

;********************************************************************************

;Source: hwi2c.h (499)
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
	goto	ENDIF91
;'Support for SSP1IF
;if SSP1IF = 0 then goto HI2CWaitMSSPWait
	banksel	PIR3
	btfss	PIR3,SSP1IF
	goto	HI2CWAITMSSPWAIT
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
;SSPIF = 0
	bcf	PIR3,SSP1IF
;exit Sub
	banksel	STATUS
	return
;end if
ENDIF91
	return

;********************************************************************************

OLEDFONT1DATA_H
	movf	SYSSTRINGA,W
	movwf	SysWORDTempA
	movf	SYSSTRINGA_H,W
	movwf	SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0
	retlw	0
	movf	SysStringA, W
	addlw	low TableOLEDFONT1DATA_H
	movwf	SysStringA
	movlw	(high TableOLEDFONT1DATA_H) & 127
	btfsc	STATUS, C
	addlw	1
	addwf	SysStringA_H, W
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableOLEDFONT1DATA_H
	retlw	1

;********************************************************************************

OLEDFONT1INDEX
	movlw	97
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableOLEDFONT1INDEX
	movwf	SysStringA
	movlw	(high TableOLEDFONT1INDEX) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableOLEDFONT1INDEX
	retlw	96
	retlw	1
	retlw	3
	retlw	5
	retlw	9
	retlw	15
	retlw	21
	retlw	25
	retlw	31
	retlw	33
	retlw	36
	retlw	39
	retlw	45
	retlw	49
	retlw	51
	retlw	55
	retlw	57
	retlw	61
	retlw	66
	retlw	70
	retlw	75
	retlw	79
	retlw	84
	retlw	88
	retlw	93
	retlw	97
	retlw	102
	retlw	107
	retlw	109
	retlw	112
	retlw	116
	retlw	120
	retlw	124
	retlw	128
	retlw	134
	retlw	139
	retlw	144
	retlw	149
	retlw	154
	retlw	158
	retlw	162
	retlw	167
	retlw	172
	retlw	176
	retlw	180
	retlw	185
	retlw	189
	retlw	195
	retlw	201
	retlw	206
	retlw	211
	retlw	216
	retlw	221
	retlw	226
	retlw	230
	retlw	235
	retlw	241
	retlw	247
	retlw	253
	retlw	2
	retlw	7
	retlw	10
	retlw	14
	retlw	17
	retlw	21
	retlw	26
	retlw	29
	retlw	34
	retlw	39
	retlw	44
	retlw	49
	retlw	54
	retlw	57
	retlw	62
	retlw	67
	retlw	69
	retlw	72
	retlw	77
	retlw	79
	retlw	85
	retlw	90
	retlw	95
	retlw	100
	retlw	105
	retlw	108
	retlw	113
	retlw	117
	retlw	122
	retlw	128
	retlw	134
	retlw	140
	retlw	145
	retlw	149
	retlw	153
	retlw	155
	retlw	159
	retlw	164

;********************************************************************************

OLEDFONT1INDEX_H
	movlw	97
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableOLEDFONT1INDEX_H
	movwf	SysStringA
	movlw	(high TableOLEDFONT1INDEX_H) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableOLEDFONT1INDEX_H
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
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
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	1

;********************************************************************************

OLEDFONT2_H
	movf	SYSSTRINGA,W
	movwf	SysWORDTempA
	movf	SYSSTRINGA_H,W
	movwf	SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0
	retlw	0
	movf	SysStringA, W
	addlw	low TableOLEDFONT2_H
	movwf	SysStringA
	movlw	(high TableOLEDFONT2_H) & 127
	btfsc	STATUS, C
	addlw	1
	addwf	SysStringA_H, W
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableOLEDFONT2_H
	retlw	7

;********************************************************************************

;Source: glcd_st7735.h (925)
SENDCOMMAND_ST7735
;set ST7735_CS OFF;
	bcf	LATB,2
;set ST7735_DC OFF;
	bcf	LATC,2
;repeat 8
	movlw	8
	banksel	SYSREPEATTEMP3
	movwf	SysRepeatTemp3
SysRepeatLoop3
;if ST7735SendByte.7 = ON  then
	btfss	ST7735SENDBYTE,7
	goto	ELSE44_1
;set ST7735_DO ON;
	banksel	LATB
	bsf	LATB,5
;else
	goto	ENDIF44
ELSE44_1
;set ST7735_DO OFF;
	banksel	LATB
	bcf	LATB,5
;end if
ENDIF44
;SET GLCD_SCK OFF;
	bcf	LATB,3
;rotate ST7735SendByte left
	banksel	ST7735SENDBYTE
	rlf	ST7735SENDBYTE,F
;set GLCD_SCK ON;
	banksel	LATB
	bsf	LATB,3
;end repeat
	banksel	SYSREPEATTEMP3
	decfsz	SysRepeatTemp3,F
	goto	SysRepeatLoop3
SysRepeatLoopEnd3
;set ST7735_CS ON;
	banksel	LATB
	bsf	LATB,2
	return

;********************************************************************************

;Source: glcd_st7735.h (959)
SENDDATA_ST7735
;set ST7735_CS OFF;
	bcf	LATB,2
;set ST7735_DC ON;
	bsf	LATC,2
;repeat 8
	movlw	8
	banksel	SYSREPEATTEMP5
	movwf	SysRepeatTemp5
SysRepeatLoop5
;if ST7735SendByte.7 = ON then
	btfss	ST7735SENDBYTE,7
	goto	ELSE94_1
;set ST7735_DO ON;
	banksel	LATB
	bsf	LATB,5
;else
	goto	ENDIF94
ELSE94_1
;set ST7735_DO OFF;
	banksel	LATB
	bcf	LATB,5
;end if
ENDIF94
;SET GLCD_SCK OFF;
	bcf	LATB,3
;rotate ST7735SendByte left
	banksel	ST7735SENDBYTE
	rlf	ST7735SENDBYTE,F
;set GLCD_SCK ON;
	banksel	LATB
	bsf	LATB,3
;end Repeat
	banksel	SYSREPEATTEMP5
	decfsz	SysRepeatTemp5,F
	goto	SysRepeatLoop5
SysRepeatLoopEnd5
;set ST7735_CS ON;
	banksel	LATB
	bsf	LATB,2
	return

;********************************************************************************

;Source: glcd_st7735.h (993)
SENDWORD_ST7735
;set ST7735_CS OFF;
	bcf	LATB,2
;set ST7735_DC ON;
	bsf	LATC,2
;repeat 16
	movlw	16
	banksel	SYSREPEATTEMP4
	movwf	SysRepeatTemp4
SysRepeatLoop4
;if ST7735SendWord.15 = ON then
	btfss	ST7735SENDWORD_H,7
	goto	ELSE45_1
;set ST7735_DO ON;
	banksel	LATB
	bsf	LATB,5
;else
	goto	ENDIF45
ELSE45_1
;set ST7735_DO OFF;
	banksel	LATB
	bcf	LATB,5
;end if
ENDIF45
;SET GLCD_SCK OFF;
	bcf	LATB,3
;rotate ST7735SendWord left
	banksel	ST7735SENDWORD
	rlf	ST7735SENDWORD,F
	rlf	ST7735SENDWORD_H,F
;set GLCD_SCK ON;
	banksel	LATB
	bsf	LATB,3
;end repeat
	banksel	SYSREPEATTEMP4
	decfsz	SysRepeatTemp4,F
	goto	SysRepeatLoop4
SysRepeatLoopEnd4
;set ST7735_CS ON;
	banksel	LATB
	bsf	LATB,2
	return

;********************************************************************************

;Source: system.h (2676)
SYSCOMPEQUAL
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;movf SysByteTempA, W
	movf	SYSBYTETEMPA, W
;subwf SysByteTempB, W
	subwf	SYSBYTETEMPB, W
;btfsc STATUS, Z
	btfsc	STATUS, Z
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

;Source: system.h (2756)
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

;Source: system.h (2873)
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

;Source: system.h (3025)
SYSCOMPLESSTHANINT
;Dim SysIntegerTempA, SysIntegerTempB, SysDivMultA as Integer
;Clear result
;SysByteTempX = 0
	clrf	SYSBYTETEMPX
;Compare sign bits
;-A
;If SysIntegerTempA.15 = On Then
	btfss	SYSINTEGERTEMPA_H,7
	goto	ELSE68_1
;-A, +B, return true
;If SysIntegerTempB.15 = Off Then
	btfsc	SYSINTEGERTEMPB_H,7
	goto	ENDIF69
;Set SysByteTempX to 255
;SysByteTempX = Not SysByteTempX
	comf	SYSBYTETEMPX,F
;Exit Sub
	return
;End If
ENDIF69
;-A, -B, negate both and swap
;SysDivMultA = -SysIntegerTempA
	comf	SYSINTEGERTEMPA,W
	movwf	SYSDIVMULTA
	comf	SYSINTEGERTEMPA_H,W
	movwf	SYSDIVMULTA_H
	incf	SYSDIVMULTA,F
	btfsc	STATUS,Z
	incf	SYSDIVMULTA_H,F
;SysIntegerTempA = -SysIntegerTempB
	comf	SYSINTEGERTEMPB,W
	movwf	SYSINTEGERTEMPA
	comf	SYSINTEGERTEMPB_H,W
	movwf	SYSINTEGERTEMPA_H
	incf	SYSINTEGERTEMPA,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPA_H,F
;SysIntegerTempB = SysDivMultA
	movf	SYSDIVMULTA,W
	movwf	SYSINTEGERTEMPB
	movf	SYSDIVMULTA_H,W
	movwf	SYSINTEGERTEMPB_H
;+A
;Else
	goto	ENDIF68
ELSE68_1
;+A, -B, return false
;If SysIntegerTempB.15 = On Then
	btfsc	SYSINTEGERTEMPB_H,7
;Exit Sub
	return
;End If
;End If
ENDIF68
;Test High, exit if more
;movf SysIntegerTempA_H,W
	movf	SYSINTEGERTEMPA_H,W
;subwf SysIntegerTempB_H,W
	subwf	SYSINTEGERTEMPB_H,W
;btfss STATUS,C
	btfss	STATUS,C
;return
	return
;Test high, exit true if less
;movf SysIntegerTempB_H,W
	movf	SYSINTEGERTEMPB_H,W
;subwf SysIntegerTempA_H,W
	subwf	SYSINTEGERTEMPA_H,W
;btfss STATUS,C
	btfss	STATUS,C
;goto SCLTIntTrue
	goto	SCLTINTTRUE
;Test Low, exit if more or equal
;movf SysIntegerTempB,W
	movf	SYSINTEGERTEMPB,W
;subwf SysIntegerTempA,W
	subwf	SYSINTEGERTEMPA,W
;btfsc STATUS,C
	btfsc	STATUS,C
;return
	return
SCLTINTTRUE
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F
	return

;********************************************************************************

;Source: system.h (2520)
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
	goto	ENDIF61
;SysWordTempA = 0
	clrf	SYSWORDTEMPA
	clrf	SYSWORDTEMPA_H
;exit sub
	return
;end if
ENDIF61
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
	goto	ENDIF62
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	addwfc	SYSDIVMULTX_H,F
;End If
ENDIF62
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

;Source: system.h (2596)
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
	banksel	SYSLONGDIVMULTA
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
	banksel	STATUS
	call	SysCompEqual32
	btfss	SysByteTempX,0
	goto	ENDIF66
;SysLongTempA = 0
	clrf	SYSLONGTEMPA
	clrf	SYSLONGTEMPA_H
	clrf	SYSLONGTEMPA_U
	clrf	SYSLONGTEMPA_E
;exit sub
	return
;end if
ENDIF66
;Main calc routine
;SysDivLoop = 32
	movlw	32
	movwf	SYSDIVLOOP
SYSDIV32START
;set C off
	bcf	STATUS,C
;Rotate SysLongDivMultA Left
	banksel	SYSLONGDIVMULTA
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
	goto	ENDIF67
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
ENDIF67
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
	banksel	STATUS
	return

;********************************************************************************

;Source: system.h (2574)
SYSDIVSUBINT
;Dim SysIntegerTempA, SysIntegerTempB, SysIntegerTempX As Integer
;Dim SysSignByte As Byte
;Make both inputs positive, decide output type
;SysSignByte = SysIntegerTempA_H xor SysIntegerTempB_H
	movf	SYSINTEGERTEMPA_H,W
	xorwf	SYSINTEGERTEMPB_H,W
	movwf	SYSSIGNBYTE
;If SysIntegerTempA.15 Then SysIntegerTempA = -SysIntegerTempA
	btfss	SYSINTEGERTEMPA_H,7
	goto	ENDIF63
	comf	SYSINTEGERTEMPA,F
	comf	SYSINTEGERTEMPA_H,F
	incf	SYSINTEGERTEMPA,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPA_H,F
ENDIF63
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
	btfss	SYSINTEGERTEMPB_H,7
	goto	ENDIF64
	comf	SYSINTEGERTEMPB,F
	comf	SYSINTEGERTEMPB_H,F
	incf	SYSINTEGERTEMPB,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPB_H,F
ENDIF64
;Call word divide routine
;SysDivSub16
	call	SYSDIVSUB16
;Negate result if necessary
;If SysSignByte.7 Then
	btfss	SYSSIGNBYTE,7
	goto	ENDIF65
;SysIntegerTempA = -SysIntegerTempA
	comf	SYSINTEGERTEMPA,F
	comf	SYSINTEGERTEMPA_H,F
	incf	SYSINTEGERTEMPA,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPA_H,F
;SysIntegerTempX = -SysIntegerTempX
	comf	SYSINTEGERTEMPX,F
	comf	SYSINTEGERTEMPX_H,F
	incf	SYSINTEGERTEMPX,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPX_H,F
;End If
ENDIF65
	return

;********************************************************************************

;Source: system.h (2228)
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

;Source: system.h (2275)
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
	goto	ENDIF56
	movf	SYSDIVMULTA,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTA_H,W
	addwfc	SYSDIVMULTX_H,F
ENDIF56
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
;SysWordTempX = SysDivMultX
	movf	SYSDIVMULTX,W
	movwf	SYSWORDTEMPX
	movf	SYSDIVMULTX_H,W
	movwf	SYSWORDTEMPX_H
	return

;********************************************************************************

;Source: system.h (2373)
SYSMULTSUBINT
;Dim SysIntegerTempA, SysIntegerTempB, SysIntegerTempX As Integer
;Dim SysSignByte As Byte
;Make both inputs positive, decide output type
;SysSignByte = SysIntegerTempA_H xor SysIntegerTempB_H
	movf	SYSINTEGERTEMPA_H,W
	xorwf	SYSINTEGERTEMPB_H,W
	movwf	SYSSIGNBYTE
;if SysIntegerTempA.15 then SysIntegerTempA = -SysIntegerTempA
	btfss	SYSINTEGERTEMPA_H,7
	goto	ENDIF58
	comf	SYSINTEGERTEMPA,F
	comf	SYSINTEGERTEMPA_H,F
	incf	SYSINTEGERTEMPA,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPA_H,F
ENDIF58
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
	btfss	SYSINTEGERTEMPB_H,7
	goto	ENDIF59
	comf	SYSINTEGERTEMPB,F
	comf	SYSINTEGERTEMPB_H,F
	incf	SYSINTEGERTEMPB,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPB_H,F
ENDIF59
;Call word multiply routine
;SysMultSub16
	call	SYSMULTSUB16
;Negate result if necessary
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
	btfss	SYSSIGNBYTE,7
	goto	ENDIF60
	comf	SYSINTEGERTEMPX,F
	comf	SYSINTEGERTEMPX_H,F
	incf	SYSINTEGERTEMPX,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPX_H,F
ENDIF60
	return

;********************************************************************************


 END
