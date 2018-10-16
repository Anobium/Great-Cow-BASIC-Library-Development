;Program compiled by Great Cow BASIC (0.98.<<>> 2018-09-23)
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F1789, r=DEC
#include <P16F1789.inc>
 __CONFIG _CONFIG1, _MCLRE_ON & _WDTE_OFF & _FOSC_INTOSC
 __CONFIG _CONFIG2, _LVP_OFF & _PLLEN_OFF

;********************************************************************************

;Set aside memory locations for variables
BYTENUMBER	EQU	32
CCOUNT	EQU	33
CHARCODE	EQU	34
CHARCOL	EQU	35
CHARCOLS	EQU	37
CHARCOL_H	EQU	36
CHARLOCX	EQU	38
CHARLOCX_H	EQU	39
CHARLOCY	EQU	40
CHARLOCY_H	EQU	41
CHARROW	EQU	42
CHARROWS	EQU	44
CHARROW_H	EQU	43
COL	EQU	45
CURRCHARCOL	EQU	46
CURRCHARROW	EQU	47
CURRCHARVAL	EQU	48
DDF_X	EQU	49
DDF_X_H	EQU	50
DDF_Y	EQU	51
DDF_Y_H	EQU	52
DELAYTEMP	EQU	112
DELAYTEMP2	EQU	113
DRAWLINE	EQU	53
DRAWLINE_H	EQU	54
FF	EQU	55
FF_H	EQU	56
FILLCIRCLEXX	EQU	57
FILLCIRCLEYY	EQU	58
GLCDBACKGROUND	EQU	59
GLCDBACKGROUND_H	EQU	60
GLCDCOLOUR	EQU	61
GLCDCOLOUR_H	EQU	62
GLCDDEVICEHEIGHT	EQU	63
GLCDDEVICEHEIGHT_H	EQU	64
GLCDDEVICEWIDTH	EQU	65
GLCDDEVICEWIDTH_H	EQU	66
GLCDFNTDEFAULTSIZE	EQU	67
GLCDFONTWIDTH	EQU	68
GLCDFOREGROUND	EQU	69
GLCDFOREGROUND_H	EQU	70
GLCDPRINTLEN	EQU	71
GLCDPRINTLOC	EQU	72
GLCDPRINTLOC_H	EQU	73
GLCDPRINT_STRING_COUNTER	EQU	74
GLCDTEMP	EQU	75
GLCDTEMP_H	EQU	76
GLCDX	EQU	77
GLCDX_H	EQU	78
GLCDY	EQU	79
GLCDY_H	EQU	80
GLCD_YORDINATE	EQU	81
GLCD_YORDINATE_H	EQU	82
ILI9326_ADDRESSTYPE	EQU	83
ILI9326_GLCD_HEIGHT_ADJ	EQU	84
ILI9326_GLCD_HEIGHT_ADJ_H	EQU	85
ILI9326_GLCD_WIDTH_ADJ	EQU	86
ILI9326_GLCD_WIDTH_ADJ_H	EQU	87
ILI9326_SENDWORD	EQU	88
ILI9326_SENDWORD_H	EQU	89
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
LONGNUMBER	EQU	168
LONGNUMBER_E	EQU	171
LONGNUMBER_H	EQU	169
LONGNUMBER_U	EQU	170
OLDFONT	EQU	172
PAD	EQU	10183
PRINTLOCX	EQU	173
PRINTLOCX_H	EQU	174
PRINTLOCY	EQU	175
PRINTLOCY_H	EQU	176
RADIUSERR	EQU	177
RADIUSERR_H	EQU	178
ROW	EQU	179
STR	EQU	10166
STRINGLOCX	EQU	180
STRINGLOCX_H	EQU	181
STRINGPOINTER	EQU	182
SYSARRAYTEMP1	EQU	183
SYSARRAYTEMP2	EQU	184
SYSBYTETEMPA	EQU	117
SYSBYTETEMPB	EQU	121
SYSBYTETEMPX	EQU	112
SYSCALCTEMPA	EQU	117
SYSCALCTEMPA_E	EQU	120
SYSCALCTEMPA_H	EQU	118
SYSCALCTEMPA_U	EQU	119
SYSCALCTEMPX	EQU	112
SYSCALCTEMPX_H	EQU	113
SYSCHARCOUNT	EQU	185
SYSCHARSHANDLER	EQU	186
SYSCHARSHANDLER_H	EQU	187
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
SYSLCDPRINTDATAHANDLER	EQU	188
SYSLCDPRINTDATAHANDLER_H	EQU	189
SYSLONGDIVMULTA	EQU	190
SYSLONGDIVMULTA_E	EQU	193
SYSLONGDIVMULTA_H	EQU	191
SYSLONGDIVMULTA_U	EQU	192
SYSLONGDIVMULTB	EQU	194
SYSLONGDIVMULTB_E	EQU	197
SYSLONGDIVMULTB_H	EQU	195
SYSLONGDIVMULTB_U	EQU	196
SYSLONGDIVMULTX	EQU	198
SYSLONGDIVMULTX_E	EQU	201
SYSLONGDIVMULTX_H	EQU	199
SYSLONGDIVMULTX_U	EQU	200
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
SYSPRINTBUFFER	EQU	10172
SYSPRINTBUFFLEN	EQU	202
SYSREPEATTEMP1	EQU	203
SYSREPEATTEMP2	EQU	204
SYSREPEATTEMP2_H	EQU	205
SYSREPEATTEMP3	EQU	206
SYSSIGNBYTE	EQU	125
SYSSTRDATA	EQU	207
SYSSTRINGA	EQU	119
SYSSTRINGA_H	EQU	120
SYSSTRINGLENGTH	EQU	118
SYSSTRINGPARAM1	EQU	10161
SYSSTRINGTEMP	EQU	208
SYSSTRLEN	EQU	209
SYSSYSINSTRING3HANDLER	EQU	210
SYSSYSINSTRING3HANDLER_H	EQU	211
SYSSYSINSTRINGHANDLER	EQU	212
SYSSYSINSTRINGHANDLER_H	EQU	213
SYSTEMP1	EQU	214
SYSTEMP1_E	EQU	217
SYSTEMP1_H	EQU	215
SYSTEMP1_U	EQU	216
SYSTEMP2	EQU	218
SYSTEMP2_H	EQU	219
SYSTEMP3	EQU	220
SYSTEMP3_H	EQU	221
SYSVALTEMP	EQU	222
SYSVALTEMP_H	EQU	223
SYSWAITTEMPMS	EQU	114
SYSWAITTEMPMS_H	EQU	115
SYSWORDTEMPA	EQU	117
SYSWORDTEMPA_H	EQU	118
SYSWORDTEMPB	EQU	121
SYSWORDTEMPB_H	EQU	122
SYSWORDTEMPX	EQU	112
SYSWORDTEMPX_H	EQU	113
WORDNUMBER	EQU	224
WORDNUMBER_H	EQU	225
XCHAR	EQU	226
XOFFSET	EQU	227
XOFFSET_H	EQU	228
XRADIUS	EQU	229
XRADIUS_H	EQU	230
YCALC1	EQU	231
YCALC1_H	EQU	232
YCALC2	EQU	233
YCALC2_H	EQU	234
YOFFSET	EQU	235
YOFFSET_H	EQU	236
YORDINATE	EQU	237

;********************************************************************************

;Alias variables
AFSR0	EQU	4
AFSR0_H	EQU	5
SYSPAD_0	EQU	3175
SYSSTR_0	EQU	3158

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
	call	INITGLCD_ILI9326
	pagesel	$

;Start of the main program
;''A demonstration program for GCGB and GCB.
;''--------------------------------------------------------------------------------------------------------------------------------
;''This program is a simple GLCD demonstration of the ILI9326 GLCD capabilities.  It is a nice graphical LCD, suitable for a lot of various projects.
;''This program draws lines, boxes, circles and prints strings and numbers.
;''The GLCD is connected to the microprocessor as shown in the hardware section of this code.   This use an 8-bit bus.  All the dataport connection must be on one port.
;''@author  EvanV
;''@licence GPL
;''@version 1.0
;''@date    27.09.2018
;''********************************************************************************
;Chip Settings
;#define GLCD_TYPE GLCD_TYPE_ILI9326
;#define GLCD_RD       porta.3        ' read command line
;#define GLCD_WR       porta.2         ' write command line
;#define GLCD_RS       porta.1         ' Command/Data line
;#define GLCD_CS       porta.0         ' Chip select line
;#define GLCD_RST      porta.5         ' Reset line
;#define GLCD_DataPort portD
;You can try BigPrint_ILI9326 - this is an alternative font set.  See the library for lots details.
;BigPrint_ILI9326 ( 10, ILI9326_GLCD_HEIGHT - 20 , "BigPrint ILI9326" )
;wait 4 s
;GLCD selected extension font set. ASCII characters 31-254, the extended font uses 1358 bytes of program memory
;#define GLCD_EXTENDEDFONTSET1
;GLCDfntDefaultsize = 1
	movlw	1
	movwf	GLCDFNTDEFAULTSIZE
;GLCDCLS  supports GLCDBackground as default
;GLCDCLS  also support passing color parameter.
;GLCDCLS [color]
;Available colors
;TFT_WHITE
;TFT_BLACK
;TFT_RED
;ILI9326_GREEN
;TFT_BLUE
;TFT_YELLOW
;TFT_CYAN
;TFT_MAGENTA
;ILI9326_NAVY
;ILI9326_DARKGREEN
;ILI9326_DARKCYAN
;ILI9326_MAROON
;ILI9326_PURPLE
;ILI9326_OLIVE
;TFT_LIGHTGREY
;TFT_DARKGREY
;ILI9326_ORANGE
;ILI9326_GREENYELLOW
;ILI9326_PINK
;Dim CCOUNT, BYTENUMBER, OLDFONT, OLDFONT as Byte
;CCount = 31
	movlw	31
	movwf	CCOUNT
;dim longNumber as long
;longNumber = 0 ' max value = 4294967290
	banksel	LONGNUMBER
	clrf	LONGNUMBER
	clrf	LONGNUMBER_H
	clrf	LONGNUMBER_U
	clrf	LONGNUMBER_E
;dim wordNumber as Word
;wordNumber = 0
	clrf	WORDNUMBER
	clrf	WORDNUMBER_H
;byteNumber = 0
	banksel	BYTENUMBER
	clrf	BYTENUMBER
;repeat 2
	movlw	2
	banksel	SYSREPEATTEMP1
	movwf	SysRepeatTemp1
SysRepeatLoop1
;GLCDCLS TFT_BLUE
	movlw	31
	banksel	GLCDBACKGROUND
	movwf	GLCDBACKGROUND
	clrf	GLCDBACKGROUND_H
	pagesel	GLCDCLS_ILI9326
	call	GLCDCLS_ILI9326
	pagesel	$
;GLCDForeground = TFT_MAGENTA
	movlw	31
	movwf	GLCDFOREGROUND
	movlw	248
	movwf	GLCDFOREGROUND_H
;GLCDfntDefaultsize = 1
	movlw	1
	movwf	GLCDFNTDEFAULTSIZE
;GLCDPrint ( 2, 2, "GLCDPrint String" )
	movlw	2
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	2
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable1
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable1) | 128
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	pagesel	GLCDPRINT5
	call	GLCDPRINT5
	pagesel	$
;GLCDForeground = TFT_WHITE
	movlw	255
	movwf	GLCDFOREGROUND
	movwf	GLCDFOREGROUND_H
;GLCDfntDefaultsize = 2
	movlw	2
	movwf	GLCDFNTDEFAULTSIZE
;GLCDPrint ( 2, 12, "GLCDPrint String" )
	movlw	2
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	12
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable1
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable1) | 128
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	pagesel	GLCDPRINT5
	call	GLCDPRINT5
	pagesel	$
;GLCDForeground = TFT_YELLOW
	movlw	224
	movwf	GLCDFOREGROUND
	movlw	255
	movwf	GLCDFOREGROUND_H
;GLCDfntDefaultsize = 3
	movlw	3
	movwf	GLCDFNTDEFAULTSIZE
;GLCDPrint ( 2,30, "GLCDPrint String" )
	movlw	2
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	30
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable1
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable1) | 128
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	pagesel	GLCDPRINT5
	call	GLCDPRINT5
	pagesel	$
;longNumber = 0xFFFFFFFF
	movlw	255
	banksel	LONGNUMBER
	movwf	LONGNUMBER
	movwf	LONGNUMBER_H
	movwf	LONGNUMBER_U
	movwf	LONGNUMBER_E
;wordNumber = 0xFFFF
	movlw	255
	movwf	WORDNUMBER
	movwf	WORDNUMBER_H
;byteNumber = 0xFF
	movlw	255
	banksel	BYTENUMBER
	movwf	BYTENUMBER
;GLCDCLS TFT_WHITE
	movlw	255
	movwf	GLCDBACKGROUND
	movwf	GLCDBACKGROUND_H
	pagesel	GLCDCLS_ILI9326
	call	GLCDCLS_ILI9326
	pagesel	$
;GLCDForeground = TFT_MAGENTA
	movlw	31
	movwf	GLCDFOREGROUND
	movlw	248
	movwf	GLCDFOREGROUND_H
;GLCDfntDefaultsize = 1
	movlw	1
	movwf	GLCDFNTDEFAULTSIZE
;GLCDPrint ( 2, 2, bytenumber )
	movlw	2
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	2
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	banksel	BYTENUMBER
	movf	BYTENUMBER,W
	movwf	LCDVALUE
	clrf	LCDVALUE_H
	clrf	LCDVALUE_U
	clrf	LCDVALUE_E
	pagesel	GLCDPRINT7
	call	GLCDPRINT7
	pagesel	$
;GLCDForeground = TFT_BLACK
	clrf	GLCDFOREGROUND
	clrf	GLCDFOREGROUND_H
;GLCDfntDefaultsize = 2
	movlw	2
	movwf	GLCDFNTDEFAULTSIZE
;GLCDPrint ( 2, 12, wordNumber )
	movlw	2
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	12
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movf	WORDNUMBER,W
	banksel	LCDVALUE
	movwf	LCDVALUE
	banksel	WORDNUMBER_H
	movf	WORDNUMBER_H,W
	banksel	LCDVALUE_H
	movwf	LCDVALUE_H
	clrf	LCDVALUE_U
	clrf	LCDVALUE_E
	pagesel	GLCDPRINT7
	call	GLCDPRINT7
	pagesel	$
;GLCDForeground = TFT_CYAN
	movlw	255
	movwf	GLCDFOREGROUND
	movlw	7
	movwf	GLCDFOREGROUND_H
;GLCDfntDefaultsize = 3
	movlw	3
	movwf	GLCDFNTDEFAULTSIZE
;GLCDPrint ( 2,30, longnumber )
	movlw	2
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	30
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movf	LONGNUMBER,W
	banksel	LCDVALUE
	movwf	LCDVALUE
	banksel	LONGNUMBER_H
	movf	LONGNUMBER_H,W
	banksel	LCDVALUE_H
	movwf	LCDVALUE_H
	banksel	LONGNUMBER_U
	movf	LONGNUMBER_U,W
	banksel	LCDVALUE_U
	movwf	LCDVALUE_U
	banksel	LONGNUMBER_E
	movf	LONGNUMBER_E,W
	banksel	LCDVALUE_E
	movwf	LCDVALUE_E
	pagesel	GLCDPRINT7
	call	GLCDPRINT7
	pagesel	$
;GLCDRotate ( Portrait_Rev )
	movlw	2
	movwf	ILI9326_ADDRESSTYPE
	pagesel	GLCDROTATE_ILI9326
	call	GLCDROTATE_ILI9326
	pagesel	$
;end Repeat
	banksel	SYSREPEATTEMP1
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop1
SysRepeatLoopEnd1
;GLCDRotate ( Portrait )
	movlw	4
	banksel	ILI9326_ADDRESSTYPE
	movwf	ILI9326_ADDRESSTYPE
	pagesel	GLCDROTATE_ILI9326
	call	GLCDROTATE_ILI9326
	pagesel	$
;GLCDCLS TFT_BLUE
	movlw	31
	movwf	GLCDBACKGROUND
	clrf	GLCDBACKGROUND_H
	pagesel	GLCDCLS_ILI9326
	call	GLCDCLS_ILI9326
	pagesel	$
;Set font size.
;GLCDfntDefaultsize = 2
	movlw	2
	movwf	GLCDFNTDEFAULTSIZE
;longNumber = 0 ' max value = 4294967290
	banksel	LONGNUMBER
	clrf	LONGNUMBER
	clrf	LONGNUMBER_H
	clrf	LONGNUMBER_U
	clrf	LONGNUMBER_E
;wordNumber = 0
	clrf	WORDNUMBER
	clrf	WORDNUMBER_H
;byteNumber = 0
	banksel	BYTENUMBER
	clrf	BYTENUMBER
;Using the global variable GLCDfntDefaultsize to show the different capabilities
;Select Case GLCDfntDefaultsize
;Case 1
SysSelect1Case1
	decf	GLCDFNTDEFAULTSIZE,W
	btfss	STATUS, Z
	goto	SysSelect1Case2
;ShowCase1
	pagesel	SHOWCASE1
	call	SHOWCASE1
	pagesel	$
;Case 2
	goto	SysSelectEnd1
SysSelect1Case2
	movlw	2
	subwf	GLCDFNTDEFAULTSIZE,W
	btfss	STATUS, Z
	goto	SysSelect1Case3
;ShowCase2
	call	SHOWCASE2
;Case 3
	goto	SysSelectEnd1
SysSelect1Case3
	movlw	3
	subwf	GLCDFNTDEFAULTSIZE,W
	btfss	STATUS, Z
	goto	SysSelectEnd1
;GLCDDrawString (2, 1, "GLCD font")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX
	clrf	STRINGLOCX_H
	movlw	1
	banksel	CHARLOCY
	movwf	CHARLOCY
	clrf	CHARLOCY_H
	movlw	low StringTable2
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler
	movlw	(high StringTable2) | 128
	movwf	SysCHARSHandler_H
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	movwf	LINECOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	LINECOLOUR_H
	pagesel	GLCDDRAWSTRING_ILI9326
	call	GLCDDRAWSTRING_ILI9326
	pagesel	$
;GLCDDrawString (2, 25, "size = 3")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX
	clrf	STRINGLOCX_H
	movlw	25
	banksel	CHARLOCY
	movwf	CHARLOCY
	clrf	CHARLOCY_H
	movlw	low StringTable3
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler
	movlw	(high StringTable3) | 128
	movwf	SysCHARSHandler_H
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	movwf	LINECOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	LINECOLOUR_H
	pagesel	GLCDDRAWSTRING_ILI9326
	call	GLCDDRAWSTRING_ILI9326
	pagesel	$
;box 0,0,ILI9326_GLCD_WIDTH-1, ILI9326_GLCD_HEIGHT-1, TFT_BLUE
	banksel	LINEX1
	clrf	LINEX1
	clrf	LINEX1_H
	clrf	LINEY1
	clrf	LINEY1_H
	movlw	1
	banksel	GLCDDEVICEWIDTH
	subwf	GLCDDEVICEWIDTH,W
	banksel	LINEX2
	movwf	LINEX2
	movlw	0
	banksel	GLCDDEVICEWIDTH_H
	subwfb	GLCDDEVICEWIDTH_H,W
	banksel	LINEX2_H
	movwf	LINEX2_H
	movlw	1
	banksel	GLCDDEVICEHEIGHT
	subwf	GLCDDEVICEHEIGHT,W
	banksel	LINEY2
	movwf	LINEY2
	movlw	0
	banksel	GLCDDEVICEHEIGHT_H
	subwfb	GLCDDEVICEHEIGHT_H,W
	banksel	LINEY2_H
	movwf	LINEY2_H
	movlw	31
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	clrf	LINECOLOUR_H
	pagesel	BOX
	call	BOX
	pagesel	$
;box ILI9326_GLCD_WIDTH-5, ILI9326_GLCD_HEIGHT-5,ILI9326_GLCD_WIDTH-1, ILI9326_GLCD_HEIGHT-1, TFT_WHITE
	movlw	5
	subwf	GLCDDEVICEWIDTH,W
	banksel	LINEX1
	movwf	LINEX1
	movlw	0
	banksel	GLCDDEVICEWIDTH_H
	subwfb	GLCDDEVICEWIDTH_H,W
	banksel	LINEX1_H
	movwf	LINEX1_H
	movlw	5
	banksel	GLCDDEVICEHEIGHT
	subwf	GLCDDEVICEHEIGHT,W
	banksel	LINEY1
	movwf	LINEY1
	movlw	0
	banksel	GLCDDEVICEHEIGHT_H
	subwfb	GLCDDEVICEHEIGHT_H,W
	banksel	LINEY1_H
	movwf	LINEY1_H
	movlw	1
	banksel	GLCDDEVICEWIDTH
	subwf	GLCDDEVICEWIDTH,W
	banksel	LINEX2
	movwf	LINEX2
	movlw	0
	banksel	GLCDDEVICEWIDTH_H
	subwfb	GLCDDEVICEWIDTH_H,W
	banksel	LINEX2_H
	movwf	LINEX2_H
	movlw	1
	banksel	GLCDDEVICEHEIGHT
	subwf	GLCDDEVICEHEIGHT,W
	banksel	LINEY2
	movwf	LINEY2
	movlw	0
	banksel	GLCDDEVICEHEIGHT_H
	subwfb	GLCDDEVICEHEIGHT_H,W
	banksel	LINEY2_H
	movwf	LINEY2_H
	movlw	255
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	movwf	LINECOLOUR_H
	pagesel	BOX
	call	BOX
	pagesel	$
;End Select
SysSelectEnd1
;end
	goto	BASPROGRAMEND
TABLEFOROLEDFONT2
INDEXFOROLEDEXTENDEDFONT1
DATAFOROLEDFONT1
TABLEFOROLEDEXTENDEDFONT2
;#define KS0108ReadDelay   9     ; 2 normal usage, 3 for 32 mhz!
;#define KS0108WriteDelay  1     ; 1 normal usage, 0 works
;#define KS0108ClockDelay  1     ; 1 normal usage, 0 works
;#define GLCDDirection     0     ; 0 normal mode
;#define InitGLCD_ILI9341 nop
;#define ST7920ReadDelay = 20
;#define ST7920WriteDelay = 2
;#define ILI9326_DataPort GLCD_DataPort
;#define ILI9326_GLCD_RST GLCD_RST
;#define ILI9326_GLCD_CS  GLCD_CS
;#define ILI9326_GLCD_RS  GLCD_RS
;#define ILI9326_GLCD_WR  GLCD_WR
;#define ILI9326_GLCD_RD  GLCD_RD
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
;#define HX8347_GLCD_RST GLCD_RST
;#define HX8347_GLCD_CS GLCD_CS
;#define HX8347_GLCD_RS GLCD_RS
;#define HX8347_GLCD_WR GLCD_WR
;#define HX8347_GLCD_RD GLCD_RD
;#define HX8347_GLCD_DB0 GLCD_DB0
;#define HX8347_GLCD_DB1 GLCD_DB1
;#define HX8347_GLCD_DB2 GLCD_DB2
;#define HX8347_GLCD_DB3 GLCD_DB3
;#define HX8347_GLCD_DB4 GLCD_DB4
;#define HX8347_GLCD_DB5 GLCD_DB5
;#define HX8347_GLCD_DB6 GLCD_DB6
;#define HX8347_GLCD_DB7 GLCD_DB7
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

;********************************************************************************

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
SysDoLoop_S4
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
	goto	SysDoLoop_E4
;Pset ((xoffset + xradius), (yoffset + yordinate), LineColour)
	banksel	XRADIUS
	movf	XRADIUS,W
	addwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	XRADIUS_H
	movf	XRADIUS_H,W
	addwfc	XOFFSET_H,W
	banksel	GLCDX_H
	movwf	GLCDX_H
	banksel	YORDINATE
	movf	YORDINATE,W
	addwf	YOFFSET,W
	banksel	GLCDY
	movwf	GLCDY
	movlw	0
	banksel	YOFFSET_H
	addwfc	YOFFSET_H,W
	banksel	GLCDY_H
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ILI9326
	call	PSET_ILI9326
	pagesel	$
;Pset ((xoffset + yordinate), (yoffset + xradius), LineColour)
	banksel	YORDINATE
	movf	YORDINATE,W
	addwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	movlw	0
	banksel	XOFFSET_H
	addwfc	XOFFSET_H,W
	banksel	GLCDX_H
	movwf	GLCDX_H
	banksel	XRADIUS
	movf	XRADIUS,W
	addwf	YOFFSET,W
	banksel	GLCDY
	movwf	GLCDY
	banksel	XRADIUS_H
	movf	XRADIUS_H,W
	addwfc	YOFFSET_H,W
	banksel	GLCDY_H
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ILI9326
	call	PSET_ILI9326
	pagesel	$
;Pset ((xoffset - xradius), (yoffset + yordinate), LineColour)
	banksel	XRADIUS
	movf	XRADIUS,W
	subwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	XRADIUS_H
	movf	XRADIUS_H,W
	subwfb	XOFFSET_H,W
	banksel	GLCDX_H
	movwf	GLCDX_H
	banksel	YORDINATE
	movf	YORDINATE,W
	addwf	YOFFSET,W
	banksel	GLCDY
	movwf	GLCDY
	movlw	0
	banksel	YOFFSET_H
	addwfc	YOFFSET_H,W
	banksel	GLCDY_H
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ILI9326
	call	PSET_ILI9326
	pagesel	$
;Pset ((xoffset - yordinate), (yoffset + xradius), LineColour)
	banksel	YORDINATE
	movf	YORDINATE,W
	subwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	movlw	0
	banksel	XOFFSET_H
	subwfb	XOFFSET_H,W
	banksel	GLCDX_H
	movwf	GLCDX_H
	banksel	XRADIUS
	movf	XRADIUS,W
	addwf	YOFFSET,W
	banksel	GLCDY
	movwf	GLCDY
	banksel	XRADIUS_H
	movf	XRADIUS_H,W
	addwfc	YOFFSET_H,W
	banksel	GLCDY_H
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ILI9326
	call	PSET_ILI9326
	pagesel	$
;Pset ((xoffset - xradius), (yoffset - yordinate), LineColour)
	banksel	XRADIUS
	movf	XRADIUS,W
	subwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	XRADIUS_H
	movf	XRADIUS_H,W
	subwfb	XOFFSET_H,W
	banksel	GLCDX_H
	movwf	GLCDX_H
	banksel	YORDINATE
	movf	YORDINATE,W
	subwf	YOFFSET,W
	banksel	GLCDY
	movwf	GLCDY
	movlw	0
	banksel	YOFFSET_H
	subwfb	YOFFSET_H,W
	banksel	GLCDY_H
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ILI9326
	call	PSET_ILI9326
	pagesel	$
;Pset ((xoffset - yordinate), (yoffset - xradius), LineColour)
	banksel	YORDINATE
	movf	YORDINATE,W
	subwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	movlw	0
	banksel	XOFFSET_H
	subwfb	XOFFSET_H,W
	banksel	GLCDX_H
	movwf	GLCDX_H
	banksel	XRADIUS
	movf	XRADIUS,W
	subwf	YOFFSET,W
	banksel	GLCDY
	movwf	GLCDY
	banksel	XRADIUS_H
	movf	XRADIUS_H,W
	subwfb	YOFFSET_H,W
	banksel	GLCDY_H
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ILI9326
	call	PSET_ILI9326
	pagesel	$
;Pset ((xoffset + xradius), (yoffset - yordinate), LineColour)
	banksel	XRADIUS
	movf	XRADIUS,W
	addwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	XRADIUS_H
	movf	XRADIUS_H,W
	addwfc	XOFFSET_H,W
	banksel	GLCDX_H
	movwf	GLCDX_H
	banksel	YORDINATE
	movf	YORDINATE,W
	subwf	YOFFSET,W
	banksel	GLCDY
	movwf	GLCDY
	movlw	0
	banksel	YOFFSET_H
	subwfb	YOFFSET_H,W
	banksel	GLCDY_H
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ILI9326
	call	PSET_ILI9326
	pagesel	$
;Pset ((xoffset + yordinate), (yoffset - xradius), LineColour)
	banksel	YORDINATE
	movf	YORDINATE,W
	addwf	XOFFSET,W
	banksel	GLCDX
	movwf	GLCDX
	movlw	0
	banksel	XOFFSET_H
	addwfc	XOFFSET_H,W
	banksel	GLCDX_H
	movwf	GLCDX_H
	banksel	XRADIUS
	movf	XRADIUS,W
	subwf	YOFFSET,W
	banksel	GLCDY
	movwf	GLCDY
	banksel	XRADIUS_H
	movf	XRADIUS_H,W
	subwfb	YOFFSET_H,W
	banksel	GLCDY_H
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ILI9326
	call	PSET_ILI9326
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
	goto	ELSE16_1
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
	goto	ENDIF16
ELSE16_1
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
	call	SysMultSubINT
	movf	SysINTEGERTempX,W
	banksel	RADIUSERR
	addwf	RADIUSERR,F
	movf	SysINTEGERTempX_H,W
	addwfc	RADIUSERR_H,F
;end if
ENDIF16
;Loop
	goto	SysDoLoop_S4
SysDoLoop_E4
	return

;********************************************************************************

INITGLCD_ILI9326
;dir ILI9326_dataPort out
	banksel	TRISD
	clrf	TRISD
;dir ILI9326_GLCD_RST out
	bcf	TRISA,5
;dir ILI9326_GLCD_CS  out
	bcf	TRISA,0
;dir ILI9326_GLCD_RS  out
	bcf	TRISA,1
;dir ILI9326_GLCD_WR  out
	bcf	TRISA,2
;dir ILI9326_GLCD_RD  out
	bcf	TRISA,3
;Dim ILI9326_GLCD_WIDTH, ILI9326_GLCD_HEIGHT as word
;Dim ILI9326_GLCD_WIDTH_ADJ, ILI9326_GLCD_HEIGHT_ADJ as word
;Dim ILI9326_AddressType as byte
;Reset*********************
;Set ILI9326_GLCD_RST On
	banksel	LATA
	bsf	LATA,5
;Wait 15 ms
	movlw	15
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	banksel	STATUS
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;Set ILI9326_GLCD_RST Off
	banksel	LATA
	bcf	LATA,5
;Wait 15 ms
	movlw	15
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	banksel	STATUS
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;Set ILI9326_GLCD_RST On
	banksel	LATA
	bsf	LATA,5
;Wait 15 ms
	movlw	15
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	banksel	STATUS
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;//*************Power On sequence ****************//
;parameters below taken from...
;*  Module for Microchip Graphics Library
;*  LCD controller driver*  ILI9326
;discharge*********************
;SendCommand_ILI9326(ILI9326_PWR_CTRL_1)
	clrf	ILI9326_SENDWORD
	movlw	1
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0000)
	clrf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(ILI9326_PWR_CTRL_3)
	movlw	2
	movwf	ILI9326_SENDWORD
	movlw	1
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0000)
	clrf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(ILI9326_PWR_CTRL_4)
	movlw	3
	movwf	ILI9326_SENDWORD
	movlw	1
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0000)
	clrf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;wait 200 ms 'power settings*****
	movlw	200
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;SendCommand_ILI9326(ILI9326_PWR_CTRL_1)
	clrf	ILI9326_SENDWORD
	movlw	1
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x1190)
	movlw	144
	movwf	ILI9326_SENDWORD
	movlw	17
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(ILI9326_PWR_CTRL_2)
	movlw	1
	movwf	ILI9326_SENDWORD
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0017)
	movlw	23
	movwf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(ILI9326_PWR_CTRL_3)
	movlw	2
	movwf	ILI9326_SENDWORD
	movlw	1
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x01BD)
	movlw	189
	movwf	ILI9326_SENDWORD
	movlw	1
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(ILI9326_PWR_CTRL_4)
	movlw	3
	movwf	ILI9326_SENDWORD
	movlw	1
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0350)
	movlw	80
	movwf	ILI9326_SENDWORD
	movlw	3
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(ILI9326_VCOMH)
	movlw	129
	movwf	ILI9326_SENDWORD
	movlw	2
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0017)
	movlw	23
	movwf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(ILI9326_GRAM_ADDR_H_SET)
	clrf	ILI9326_SENDWORD
	movlw	2
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0000)
	clrf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(ILI9326_GRAM_ADDR_V_SET)
	movlw	1
	movwf	ILI9326_SENDWORD
	movlw	2
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0000)
	clrf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;set gamma curve**************
;SendCommand_ILI9326(0x0300)
	clrf	ILI9326_SENDWORD
	movlw	3
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0000)
	clrf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(0x0301)
	movlw	1
	movwf	ILI9326_SENDWORD
	movlw	3
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0707)
	movlw	7
	movwf	ILI9326_SENDWORD
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(0x0302)
	movlw	2
	movwf	ILI9326_SENDWORD
	movlw	3
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0606)
	movlw	6
	movwf	ILI9326_SENDWORD
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(0x0305)
	movlw	5
	movwf	ILI9326_SENDWORD
	movlw	3
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0006)
	movlw	6
	movwf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(0x0306)
	movlw	6
	movwf	ILI9326_SENDWORD
	movlw	3
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0A09)
	movlw	9
	movwf	ILI9326_SENDWORD
	movlw	10
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(0x0307)
	movlw	7
	movwf	ILI9326_SENDWORD
	movlw	3
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0203)
	movlw	3
	movwf	ILI9326_SENDWORD
	movlw	2
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(0x0308)
	movlw	8
	movwf	ILI9326_SENDWORD
	movlw	3
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0005)
	movlw	5
	movwf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(0x0309)
	movlw	9
	movwf	ILI9326_SENDWORD
	movlw	3
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0007)
	movlw	7
	movwf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(0x030C)
	movlw	12
	movwf	ILI9326_SENDWORD
	movlw	3
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0400)
	clrf	ILI9326_SENDWORD
	movlw	4
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(0x030D)
	movlw	13
	movwf	ILI9326_SENDWORD
	movlw	3
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x000A)
	movlw	10
	movwf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;set GRAM area**************
;SendCommand_ILI9326(ILI9326_H_ADDR_START_POS)
	movlw	16
	movwf	ILI9326_SENDWORD
	movlw	2
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0000)
	clrf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(ILI9326_H_ADDR_END_POS)
	movlw	17
	movwf	ILI9326_SENDWORD
	movlw	2
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x00EF)' 240 pixels
	movlw	239
	movwf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(ILI9326_V_ADDR_START_POS)
	movlw	18
	movwf	ILI9326_SENDWORD
	movlw	2
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0000)
	clrf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(ILI9326_V_ADDR_END_POS)
	movlw	19
	movwf	ILI9326_SENDWORD
	movlw	2
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x018F) '400 pixels
	movlw	143
	movwf	ILI9326_SENDWORD
	movlw	1
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(ILI9326_BASE_IMG_DISP_CTRL_1)
	clrf	ILI9326_SENDWORD
	movlw	4
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x3500)
	clrf	ILI9326_SENDWORD
	movlw	53
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(ILI9326_BASE_IMG_DISP_CTRL_2)
	movlw	1
	movwf	ILI9326_SENDWORD
	movlw	4
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0001)
	movlw	1
	movwf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(ILI9326_BASE_IMG_DISP_CTRL_3)
	movlw	4
	movwf	ILI9326_SENDWORD
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0000)
	clrf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(ILI9326_PANEL_INTF_CTRL_1) 'set screen defaults
	movlw	16
	movwf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0010)
	movlw	16
	movwf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(ILI9326_PANEL_INTF_CTRL_2) 'last set of commands
	movlw	17
	movwf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0000)
	clrf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(ILI9326_FRAME_RATE_COLOR_CTRL)
	movlw	11
	movwf	ILI9326_SENDWORD
	movlw	2
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0000)
	clrf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ILI9326(ILI9326_DISP_CTRL_1)
	movlw	7
	movwf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326(0x0173) 'display on
	movlw	115
	movwf	ILI9326_SENDWORD
	movlw	1
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;Change to RGB TFT color and standard orientation
;SendCommand_ILI9326(ILI9326_ENTRY_MODE)
	movlw	3
	movwf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDCOMMAND_ILI9326
	call	SENDCOMMAND_ILI9326
	pagesel	$
;SendData_ili9326( ILI9326_ENTRY_MODE_BGR )
	clrf	ILI9326_SENDWORD
	movlw	16
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;ILI9326_AddressType = Portrait
	movlw	4
	movwf	ILI9326_ADDRESSTYPE
;ILI9326_GLCD_WIDTH_ADJ = 0
	clrf	ILI9326_GLCD_WIDTH_ADJ
	clrf	ILI9326_GLCD_WIDTH_ADJ_H
;ILI9326_GLCD_HEIGHT_ADJ = GLCD_HEIGHT - 1
	movlw	143
	movwf	ILI9326_GLCD_HEIGHT_ADJ
	movlw	1
	movwf	ILI9326_GLCD_HEIGHT_ADJ_H
;Default Colours
;GLCDBackground = ILI9326_BLACK
	clrf	GLCDBACKGROUND
	clrf	GLCDBACKGROUND_H
;GLCDForeground = ILI9326_WHITE
	movlw	255
	movwf	GLCDFOREGROUND
	movwf	GLCDFOREGROUND_H
;Variables required for device
;ILI9326_GLCD_WIDTH = GLCD_WIDTH
	movlw	240
	movwf	GLCDDEVICEWIDTH
	clrf	GLCDDEVICEWIDTH_H
;ILI9326_GLCD_HEIGHT = GLCD_HEIGHT
	movlw	144
	movwf	GLCDDEVICEHEIGHT
	movlw	1
	movwf	GLCDDEVICEHEIGHT_H
;GLCDFontWidth = 6
	movlw	6
	movwf	GLCDFONTWIDTH
;GLCDfntDefaultsize = 1
	movlw	1
	movwf	GLCDFNTDEFAULTSIZE
;GLCDRotate( Portrait  )
;Clear screen
;GLCDCLS ( GLCDBackground )
	pagesel	GLCDCLS_ILI9326
	goto	GLCDCLS_ILI9326

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

SHOWCASE2
;GLCDDrawString (2, 1,  "GCB",TFT_WHITE)
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX
	clrf	STRINGLOCX_H
	movlw	1
	banksel	CHARLOCY
	movwf	CHARLOCY
	clrf	CHARLOCY_H
	movlw	low StringTable4
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler
	movlw	(high StringTable4) | 128
	movwf	SysCHARSHandler_H
	movlw	255
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	movwf	LINECOLOUR_H
	pagesel	GLCDDRAWSTRING_ILI9326
	call	GLCDDRAWSTRING_ILI9326
	pagesel	$
;GLCDDrawString (56,1,  "v.98",TFT_YELLOW)
	movlw	56
	banksel	STRINGLOCX
	movwf	STRINGLOCX
	clrf	STRINGLOCX_H
	movlw	1
	banksel	CHARLOCY
	movwf	CHARLOCY
	clrf	CHARLOCY_H
	movlw	low StringTable5
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler
	movlw	(high StringTable5) | 128
	movwf	SysCHARSHandler_H
	movlw	224
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	movlw	255
	movwf	LINECOLOUR_H
	pagesel	GLCDDRAWSTRING_ILI9326
	call	GLCDDRAWSTRING_ILI9326
	pagesel	$
;GLCDDrawString (2, 20, "DrawStr",TFT_WHITE)
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX
	clrf	STRINGLOCX_H
	movlw	20
	banksel	CHARLOCY
	movwf	CHARLOCY
	clrf	CHARLOCY_H
	movlw	low StringTable6
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler
	movlw	(high StringTable6) | 128
	movwf	SysCHARSHandler_H
	movlw	255
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	movwf	LINECOLOUR_H
	pagesel	GLCDDRAWSTRING_ILI9326
	call	GLCDDRAWSTRING_ILI9326
	pagesel	$
;GLCDDrawString ( 2, 52, "Long:" )
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX
	clrf	STRINGLOCX_H
	movlw	52
	banksel	CHARLOCY
	movwf	CHARLOCY
	clrf	CHARLOCY_H
	movlw	low StringTable14
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler
	movlw	(high StringTable14) | 128
	movwf	SysCHARSHandler_H
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	movwf	LINECOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	LINECOLOUR_H
	pagesel	GLCDDRAWSTRING_ILI9326
	call	GLCDDRAWSTRING_ILI9326
	pagesel	$
;GLCDDrawString ( 2, 70, "Word:" )
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX
	clrf	STRINGLOCX_H
	movlw	70
	banksel	CHARLOCY
	movwf	CHARLOCY
	clrf	CHARLOCY_H
	movlw	low StringTable15
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler
	movlw	(high StringTable15) | 128
	movwf	SysCHARSHandler_H
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	movwf	LINECOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	LINECOLOUR_H
	pagesel	GLCDDRAWSTRING_ILI9326
	call	GLCDDRAWSTRING_ILI9326
	pagesel	$
;GLCDDrawString ( 2, 88, "Byte:" )
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX
	clrf	STRINGLOCX_H
	movlw	88
	banksel	CHARLOCY
	movwf	CHARLOCY
	clrf	CHARLOCY_H
	movlw	low StringTable16
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler
	movlw	(high StringTable16) | 128
	movwf	SysCHARSHandler_H
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	movwf	LINECOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	LINECOLOUR_H
	pagesel	GLCDDRAWSTRING_ILI9326
	call	GLCDDRAWSTRING_ILI9326
	pagesel	$
;GLCDDrawString ( 128, 20, "Asc:"+"  " )
	movlw	128
	banksel	STRINGLOCX
	movwf	STRINGLOCX
	clrf	STRINGLOCX_H
	movlw	20
	banksel	CHARLOCY
	movwf	CHARLOCY
	clrf	CHARLOCY_H
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	clrf	SysStringLength
	movlw	low StringTable10
	movwf	SysStringA
	movlw	(high StringTable10) & 127
	movwf	SysStringA_H
	pagesel	SysReadStringPart
	call	SysReadStringPart
	pagesel	$
	movlw	low StringTable17
	movwf	SysStringA
	movlw	(high StringTable17) & 127
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
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	movwf	LINECOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	LINECOLOUR_H
	pagesel	GLCDDRAWSTRING_ILI9326
	call	GLCDDRAWSTRING_ILI9326
	pagesel	$
;box 0,0,ILI9326_GLCD_WIDTH-1, ILI9326_GLCD_HEIGHT-1, TFT_RED
	banksel	LINEX1
	clrf	LINEX1
	clrf	LINEX1_H
	clrf	LINEY1
	clrf	LINEY1_H
	movlw	1
	banksel	GLCDDEVICEWIDTH
	subwf	GLCDDEVICEWIDTH,W
	banksel	LINEX2
	movwf	LINEX2
	movlw	0
	banksel	GLCDDEVICEWIDTH_H
	subwfb	GLCDDEVICEWIDTH_H,W
	banksel	LINEX2_H
	movwf	LINEX2_H
	movlw	1
	banksel	GLCDDEVICEHEIGHT
	subwf	GLCDDEVICEHEIGHT,W
	banksel	LINEY2
	movwf	LINEY2
	movlw	0
	banksel	GLCDDEVICEHEIGHT_H
	subwfb	GLCDDEVICEHEIGHT_H,W
	banksel	LINEY2_H
	movwf	LINEY2_H
	banksel	LINECOLOUR
	clrf	LINECOLOUR
	movlw	248
	movwf	LINECOLOUR_H
	pagesel	BOX
	call	BOX
	pagesel	$
;box ILI9326_GLCD_WIDTH-5, ILI9326_GLCD_HEIGHT-5,ILI9326_GLCD_WIDTH-1, ILI9326_GLCD_HEIGHT-1, TFT_WHITE
	movlw	5
	subwf	GLCDDEVICEWIDTH,W
	banksel	LINEX1
	movwf	LINEX1
	movlw	0
	banksel	GLCDDEVICEWIDTH_H
	subwfb	GLCDDEVICEWIDTH_H,W
	banksel	LINEX1_H
	movwf	LINEX1_H
	movlw	5
	banksel	GLCDDEVICEHEIGHT
	subwf	GLCDDEVICEHEIGHT,W
	banksel	LINEY1
	movwf	LINEY1
	movlw	0
	banksel	GLCDDEVICEHEIGHT_H
	subwfb	GLCDDEVICEHEIGHT_H,W
	banksel	LINEY1_H
	movwf	LINEY1_H
	movlw	1
	banksel	GLCDDEVICEWIDTH
	subwf	GLCDDEVICEWIDTH,W
	banksel	LINEX2
	movwf	LINEX2
	movlw	0
	banksel	GLCDDEVICEWIDTH_H
	subwfb	GLCDDEVICEWIDTH_H,W
	banksel	LINEX2_H
	movwf	LINEX2_H
	movlw	1
	banksel	GLCDDEVICEHEIGHT
	subwf	GLCDDEVICEHEIGHT,W
	banksel	LINEY2
	movwf	LINEY2
	movlw	0
	banksel	GLCDDEVICEHEIGHT_H
	subwfb	GLCDDEVICEHEIGHT_H,W
	banksel	LINEY2_H
	movwf	LINEY2_H
	movlw	255
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	movwf	LINECOLOUR_H
	pagesel	BOX
	call	BOX
	pagesel	$
;Circle( ILI9326_GLCD_WIDTH/2, ILI9326_GLCD_HEIGHT/2, 50, TFT_LIGHTGREY )            ;center
	movf	GLCDDEVICEWIDTH,W
	movwf	SysWORDTempA
	movf	GLCDDEVICEWIDTH_H,W
	movwf	SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempA,W
	banksel	XOFFSET
	movwf	XOFFSET
	movf	SysWORDTempA_H,W
	movwf	XOFFSET_H
	banksel	GLCDDEVICEHEIGHT
	movf	GLCDDEVICEHEIGHT,W
	movwf	SysWORDTempA
	movf	GLCDDEVICEHEIGHT_H,W
	movwf	SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempA,W
	banksel	YOFFSET
	movwf	YOFFSET
	movf	SysWORDTempA_H,W
	movwf	YOFFSET_H
	movlw	50
	banksel	INXRADIUS
	movwf	INXRADIUS
	clrf	INXRADIUS_H
	movlw	24
	movwf	LINECOLOUR
	movlw	198
	movwf	LINECOLOUR_H
	movf	GLCD_YORDINATE,W
	banksel	YORDINATE
	movwf	YORDINATE
	banksel	STATUS
	call	CIRCLE
;FilledCircle( ILI9326_GLCD_WIDTH/2, ILI9326_GLCD_HEIGHT/2, 25, TFT_DARKGREY  )
	movf	GLCDDEVICEWIDTH,W
	movwf	SysWORDTempA
	movf	GLCDDEVICEWIDTH_H,W
	movwf	SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempA,W
	banksel	XOFFSET
	movwf	XOFFSET
	movf	SysWORDTempA_H,W
	movwf	XOFFSET_H
	banksel	GLCDDEVICEHEIGHT
	movf	GLCDDEVICEHEIGHT,W
	movwf	SysWORDTempA
	movf	GLCDDEVICEHEIGHT_H,W
	movwf	SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempA,W
	banksel	YOFFSET
	movwf	YOFFSET
	movf	SysWORDTempA_H,W
	movwf	YOFFSET_H
	movlw	25
	movwf	XRADIUS
	clrf	XRADIUS_H
	movlw	239
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	movlw	123
	movwf	LINECOLOUR_H
	pagesel	FILLEDCIRCLE
	call	FILLEDCIRCLE
	pagesel	$
;line 0,  ILI9326_GLCD_HEIGHT-1 , ILI9326_GLCD_WIDTH/2 +100,  (ILI9326_GLCD_HEIGHT /2) - 50, TFT_CYAN
	banksel	LINEX1
	clrf	LINEX1
	clrf	LINEX1_H
	movlw	1
	banksel	GLCDDEVICEHEIGHT
	subwf	GLCDDEVICEHEIGHT,W
	banksel	LINEY1
	movwf	LINEY1
	movlw	0
	banksel	GLCDDEVICEHEIGHT_H
	subwfb	GLCDDEVICEHEIGHT_H,W
	banksel	LINEY1_H
	movwf	LINEY1_H
	banksel	GLCDDEVICEWIDTH
	movf	GLCDDEVICEWIDTH,W
	movwf	SysWORDTempA
	movf	GLCDDEVICEWIDTH_H,W
	movwf	SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movlw	100
	addwf	SysWORDTempA,W
	banksel	LINEX2
	movwf	LINEX2
	movlw	0
	addwfc	SysWORDTempA_H,W
	movwf	LINEX2_H
	banksel	GLCDDEVICEHEIGHT
	movf	GLCDDEVICEHEIGHT,W
	movwf	SysWORDTempA
	movf	GLCDDEVICEHEIGHT_H,W
	movwf	SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempA,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movf	SysWORDTempA_H,W
	movwf	SysTemp1_H
	movlw	50
	subwf	SysTemp1,W
	movwf	LINEY2
	movlw	0
	subwfb	SysTemp1_H,W
	movwf	LINEY2_H
	movlw	255
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	movlw	7
	movwf	LINECOLOUR_H
	pagesel	LINE
	call	LINE
	pagesel	$
;line  0, (ILI9326_GLCD_HEIGHT /2) - 50, ILI9326_GLCD_WIDTH/2 +100, (ILI9326_GLCD_HEIGHT /2) - 50, TFT_CYAN
	banksel	LINEX1
	clrf	LINEX1
	clrf	LINEX1_H
	banksel	GLCDDEVICEHEIGHT
	movf	GLCDDEVICEHEIGHT,W
	movwf	SysWORDTempA
	movf	GLCDDEVICEHEIGHT_H,W
	movwf	SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempA,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movf	SysWORDTempA_H,W
	movwf	SysTemp1_H
	movlw	50
	subwf	SysTemp1,W
	movwf	LINEY1
	movlw	0
	subwfb	SysTemp1_H,W
	movwf	LINEY1_H
	banksel	GLCDDEVICEWIDTH
	movf	GLCDDEVICEWIDTH,W
	movwf	SysWORDTempA
	movf	GLCDDEVICEWIDTH_H,W
	movwf	SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movlw	100
	addwf	SysWORDTempA,W
	banksel	LINEX2
	movwf	LINEX2
	movlw	0
	addwfc	SysWORDTempA_H,W
	movwf	LINEX2_H
	banksel	GLCDDEVICEHEIGHT
	movf	GLCDDEVICEHEIGHT,W
	movwf	SysWORDTempA
	movf	GLCDDEVICEHEIGHT_H,W
	movwf	SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempA,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movf	SysWORDTempA_H,W
	movwf	SysTemp1_H
	movlw	50
	subwf	SysTemp1,W
	movwf	LINEY2
	movlw	0
	subwfb	SysTemp1_H,W
	movwf	LINEY2_H
	movlw	255
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	movlw	7
	movwf	LINECOLOUR_H
	pagesel	LINE
	call	LINE
	pagesel	$
;filledbox 2,ILI9326_GLCD_HEIGHT/2+10,42,ILI9326_GLCD_HEIGHT/2+50, TFT_RED
	movlw	2
	banksel	LINEX1
	movwf	LINEX1
	clrf	LINEX1_H
	banksel	GLCDDEVICEHEIGHT
	movf	GLCDDEVICEHEIGHT,W
	movwf	SysWORDTempA
	movf	GLCDDEVICEHEIGHT_H,W
	movwf	SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movlw	10
	addwf	SysWORDTempA,W
	banksel	LINEY1
	movwf	LINEY1
	movlw	0
	addwfc	SysWORDTempA_H,W
	movwf	LINEY1_H
	movlw	42
	movwf	LINEX2
	clrf	LINEX2_H
	banksel	GLCDDEVICEHEIGHT
	movf	GLCDDEVICEHEIGHT,W
	movwf	SysWORDTempA
	movf	GLCDDEVICEHEIGHT_H,W
	movwf	SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movlw	50
	addwf	SysWORDTempA,W
	banksel	LINEY2
	movwf	LINEY2
	movlw	0
	addwfc	SysWORDTempA_H,W
	movwf	LINEY2_H
	banksel	LINECOLOUR
	clrf	LINECOLOUR
	movlw	248
	movwf	LINECOLOUR_H
	pagesel	FILLEDBOX_ILI9326
	call	FILLEDBOX_ILI9326
	pagesel	$
;oldfont = GLCDfntDefaultsize
	movf	GLCDFNTDEFAULTSIZE,W
	banksel	OLDFONT
	movwf	OLDFONT
;GLCDfntDefaultsize = 3
	movlw	3
	banksel	GLCDFNTDEFAULTSIZE
	movwf	GLCDFNTDEFAULTSIZE
;GLCDDrawString ( 42, ILI9326_GLCD_HEIGHT - 30 , "ILI9326" , TFT_WHITE )
	movlw	42
	banksel	STRINGLOCX
	movwf	STRINGLOCX
	clrf	STRINGLOCX_H
	movlw	30
	banksel	GLCDDEVICEHEIGHT
	subwf	GLCDDEVICEHEIGHT,W
	movwf	CHARLOCY
	movlw	0
	subwfb	GLCDDEVICEHEIGHT_H,W
	movwf	CHARLOCY_H
	movlw	low StringTable11
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler
	movlw	(high StringTable11) | 128
	movwf	SysCHARSHandler_H
	movlw	255
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	movwf	LINECOLOUR_H
	pagesel	GLCDDRAWSTRING_ILI9326
	call	GLCDDRAWSTRING_ILI9326
	pagesel	$
;GLCDfntDefaultsize = 1
	movlw	1
	movwf	GLCDFNTDEFAULTSIZE
;GLCDDrawString ( ILI9326_GLCD_WIDTH - 32, 2 , "2018" , TFT_WHITE )
	movlw	32
	subwf	GLCDDEVICEWIDTH,W
	banksel	STRINGLOCX
	movwf	STRINGLOCX
	movlw	0
	banksel	GLCDDEVICEWIDTH_H
	subwfb	GLCDDEVICEWIDTH_H,W
	banksel	STRINGLOCX_H
	movwf	STRINGLOCX_H
	movlw	2
	banksel	CHARLOCY
	movwf	CHARLOCY
	clrf	CHARLOCY_H
	movlw	low StringTable12
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler
	movlw	(high StringTable12) | 128
	movwf	SysCHARSHandler_H
	movlw	255
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	movwf	LINECOLOUR_H
	pagesel	GLCDDRAWSTRING_ILI9326
	call	GLCDDRAWSTRING_ILI9326
	pagesel	$
;GLCDDrawString ( ILI9326_GLCD_WIDTH - 66, 10 , "8 bit bus" , TFT_WHITE )
	movlw	66
	subwf	GLCDDEVICEWIDTH,W
	banksel	STRINGLOCX
	movwf	STRINGLOCX
	movlw	0
	banksel	GLCDDEVICEWIDTH_H
	subwfb	GLCDDEVICEWIDTH_H,W
	banksel	STRINGLOCX_H
	movwf	STRINGLOCX_H
	movlw	10
	banksel	CHARLOCY
	movwf	CHARLOCY
	clrf	CHARLOCY_H
	movlw	low StringTable13
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler
	movlw	(high StringTable13) | 128
	movwf	SysCHARSHandler_H
	movlw	255
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	movwf	LINECOLOUR_H
	pagesel	GLCDDRAWSTRING_ILI9326
	call	GLCDDRAWSTRING_ILI9326
	pagesel	$
;Revert the font size
;GLCDfntDefaultsize = oldfont
	banksel	OLDFONT
	movf	OLDFONT,W
	banksel	GLCDFNTDEFAULTSIZE
	movwf	GLCDFNTDEFAULTSIZE
;GLCDForeground = TFT_RED
	clrf	GLCDFOREGROUND
	movlw	248
	movwf	GLCDFOREGROUND_H
;GLCDPrint ( 25, ILI9326_GLCD_HEIGHT - 60 , "Great Cow BASIC" )
	movlw	25
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	60
	banksel	GLCDDEVICEHEIGHT
	subwf	GLCDDEVICEHEIGHT,W
	banksel	PRINTLOCY
	movwf	PRINTLOCY
	movlw	0
	banksel	GLCDDEVICEHEIGHT_H
	subwfb	GLCDDEVICEHEIGHT_H,W
	banksel	PRINTLOCY_H
	movwf	PRINTLOCY_H
	movlw	low StringTable18
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable18) | 128
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	pagesel	GLCDPRINT5
	call	GLCDPRINT5
	pagesel	$
;GLCDForeground = TFT_WHITE
	movlw	255
	movwf	GLCDFOREGROUND
	movwf	GLCDFOREGROUND_H
;DO forever
SysDoLoop_S2
;GLCDPrint ( 64 , 52, longNumber)
	movlw	64
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	52
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movf	LONGNUMBER,W
	banksel	LCDVALUE
	movwf	LCDVALUE
	banksel	LONGNUMBER_H
	movf	LONGNUMBER_H,W
	banksel	LCDVALUE_H
	movwf	LCDVALUE_H
	banksel	LONGNUMBER_U
	movf	LONGNUMBER_U,W
	banksel	LCDVALUE_U
	movwf	LCDVALUE_U
	banksel	LONGNUMBER_E
	movf	LONGNUMBER_E,W
	banksel	LCDVALUE_E
	movwf	LCDVALUE_E
	pagesel	GLCDPRINT7
	call	GLCDPRINT7
	pagesel	$
;GLCDPrint ( 64 , 70, pad( str(wordnumber),5))
	movlw	64
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	70
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movf	WORDNUMBER,W
	movwf	SYSVALTEMP
	movf	WORDNUMBER_H,W
	movwf	SYSVALTEMP_H
	banksel	STATUS
	pagesel	FN_STR
	call	FN_STR
	pagesel	$
	movlw	low STR
	banksel	SYSSYSINSTRINGHANDLER
	movwf	SysSYSINSTRINGHandler
	movlw	high STR
	movwf	SysSYSINSTRINGHandler_H
	movlw	5
	movwf	SYSSTRLEN
	movlw	low StringTable46
	movwf	SysSYSINSTRING3Handler
	movlw	(high StringTable46) | 128
	movwf	SysSYSINSTRING3Handler_H
	banksel	STATUS
	pagesel	FN_PAD
	call	FN_PAD
	pagesel	$
	movlw	low PAD
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler
	movlw	high PAD
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	pagesel	GLCDPRINT5
	call	GLCDPRINT5
	pagesel	$
;GLCDPrint ( 64 , 88, pad( str(bytenumber),3))
	movlw	64
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	88
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	banksel	BYTENUMBER
	movf	BYTENUMBER,W
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	clrf	SYSVALTEMP_H
	banksel	STATUS
	pagesel	FN_STR
	call	FN_STR
	pagesel	$
	movlw	low STR
	banksel	SYSSYSINSTRINGHANDLER
	movwf	SysSYSINSTRINGHandler
	movlw	high STR
	movwf	SysSYSINSTRINGHandler_H
	movlw	3
	movwf	SYSSTRLEN
	movlw	low StringTable46
	movwf	SysSYSINSTRING3Handler
	movlw	(high StringTable46) | 128
	movwf	SysSYSINSTRING3Handler_H
	banksel	STATUS
	pagesel	FN_PAD
	call	FN_PAD
	pagesel	$
	movlw	low PAD
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler
	movlw	high PAD
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	pagesel	GLCDPRINT5
	call	GLCDPRINT5
	pagesel	$
;GLCDDrawChar(99, 20, CCount )
	movlw	99
	movwf	CHARLOCX
	clrf	CHARLOCX_H
	movlw	20
	movwf	CHARLOCY
	clrf	CHARLOCY_H
	movf	CCOUNT,W
	movwf	CHARCODE
	movf	GLCDFOREGROUND,W
	movwf	LINECOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	LINECOLOUR_H
	pagesel	GLCDDRAWCHAR_ILI9326
	call	GLCDDRAWCHAR_ILI9326
	pagesel	$
;Box 98,20,117,44, TFT_WHITE               'Draw a box around the Char below
	movlw	98
	banksel	LINEX1
	movwf	LINEX1
	clrf	LINEX1_H
	movlw	20
	movwf	LINEY1
	clrf	LINEY1_H
	movlw	117
	movwf	LINEX2
	clrf	LINEX2_H
	movlw	44
	movwf	LINEY2
	clrf	LINEY2_H
	movlw	255
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	movwf	LINECOLOUR_H
	pagesel	BOX
	call	BOX
	pagesel	$
;GLCDDrawString ( 180, 20 , pad( str(CCount),3) )
	movlw	180
	banksel	STRINGLOCX
	movwf	STRINGLOCX
	clrf	STRINGLOCX_H
	movlw	20
	banksel	CHARLOCY
	movwf	CHARLOCY
	clrf	CHARLOCY_H
	movf	CCOUNT,W
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	clrf	SYSVALTEMP_H
	banksel	STATUS
	pagesel	FN_STR
	call	FN_STR
	pagesel	$
	movlw	low STR
	banksel	SYSSYSINSTRINGHANDLER
	movwf	SysSYSINSTRINGHandler
	movlw	high STR
	movwf	SysSYSINSTRINGHandler_H
	movlw	3
	movwf	SYSSTRLEN
	movlw	low StringTable46
	movwf	SysSYSINSTRING3Handler
	movlw	(high StringTable46) | 128
	movwf	SysSYSINSTRING3Handler_H
	banksel	STATUS
	pagesel	FN_PAD
	call	FN_PAD
	pagesel	$
	movlw	low PAD
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler
	movlw	high PAD
	movwf	SysCHARSHandler_H
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	movwf	LINECOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	LINECOLOUR_H
	pagesel	GLCDDRAWSTRING_ILI9326
	call	GLCDDRAWSTRING_ILI9326
	pagesel	$
;CCount++
	incf	CCOUNT,F
;if CCount = 0 then CCount = 31
	movf	CCOUNT,F
	btfss	STATUS, Z
	goto	ENDIF3
	movlw	31
	movwf	CCOUNT
ENDIF3
;if CCount = 128 then CCount = 192
	movlw	128
	subwf	CCOUNT,W
	btfss	STATUS, Z
	goto	ENDIF4
	movlw	192
	movwf	CCOUNT
ENDIF4
;longNumber = longNumber + 7
	movlw	7
	banksel	LONGNUMBER
	addwf	LONGNUMBER,F
	movlw	0
	addwfc	LONGNUMBER_H,F
	movlw	0
	addwfc	LONGNUMBER_U,F
	movlw	0
	addwfc	LONGNUMBER_E,F
;wordNumber = wordNumber + 3
	movlw	3
	addwf	WORDNUMBER,F
	movlw	0
	addwfc	WORDNUMBER_H,F
;byteNumber++
	banksel	BYTENUMBER
	incf	BYTENUMBER,F
;LOOP
	goto	SysDoLoop_S2
SysDoLoop_E2
	return

;********************************************************************************

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
	goto	ENDIF39
	comf	SYSINTEGERTEMPA,F
	comf	SYSINTEGERTEMPA_H,F
	incf	SYSINTEGERTEMPA,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPA_H,F
ENDIF39
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
	btfss	SYSINTEGERTEMPB_H,7
	goto	ENDIF40
	comf	SYSINTEGERTEMPB,F
	comf	SYSINTEGERTEMPB_H,F
	incf	SYSINTEGERTEMPB,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPB_H,F
ENDIF40
;Call word multiply routine
;SysMultSub16
	pagesel	SYSMULTSUB16
	call	SYSMULTSUB16
	pagesel	$
;Negate result if necessary
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
	btfss	SYSSIGNBYTE,7
	goto	ENDIF41
	comf	SYSINTEGERTEMPX,F
	comf	SYSINTEGERTEMPX_H,F
	incf	SYSINTEGERTEMPX,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPX_H,F
ENDIF41
	return

;********************************************************************************

;Start of program memory page 1
	ORG	2048
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
	goto	ENDIF10
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
ENDIF10
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
	goto	ENDIF11
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
ENDIF11
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
	goto	SysForLoopEnd3
ENDIF12
SysForLoop3
	incf	DRAWLINE,F
	btfsc	STATUS,Z
	incf	DRAWLINE_H,F
;PSet DrawLine, LineY1, LineColour
	movf	DRAWLINE,W
	movwf	GLCDX
	movf	DRAWLINE_H,W
	movwf	GLCDX_H
	banksel	LINEY1
	movf	LINEY1,W
	banksel	GLCDY
	movwf	GLCDY
	banksel	LINEY1_H
	movf	LINEY1_H,W
	banksel	GLCDY_H
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ILI9326
	call	PSET_ILI9326
	pagesel	$
;PSet DrawLine, LineY2, LineColour
	movf	DRAWLINE,W
	movwf	GLCDX
	movf	DRAWLINE_H,W
	movwf	GLCDX_H
	banksel	LINEY2
	movf	LINEY2,W
	banksel	GLCDY
	movwf	GLCDY
	banksel	LINEY2_H
	movf	LINEY2_H,W
	banksel	GLCDY_H
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ILI9326
	call	PSET_ILI9326
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
	goto	SysForLoop3
ENDIF13
SysForLoopEnd3
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
	goto	SysForLoopEnd4
ENDIF14
SysForLoop4
	incf	DRAWLINE,F
	btfsc	STATUS,Z
	incf	DRAWLINE_H,F
;PSet LineX1, DrawLine, LineColour
	banksel	LINEX1
	movf	LINEX1,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	LINEX1_H
	movf	LINEX1_H,W
	banksel	GLCDX_H
	movwf	GLCDX_H
	movf	DRAWLINE,W
	movwf	GLCDY
	movf	DRAWLINE_H,W
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ILI9326
	call	PSET_ILI9326
	pagesel	$
;PSet LineX2, DrawLine, LineColour
	banksel	LINEX2
	movf	LINEX2,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	LINEX2_H
	movf	LINEX2_H,W
	banksel	GLCDX_H
	movwf	GLCDX_H
	movf	DRAWLINE,W
	movwf	GLCDY
	movf	DRAWLINE_H,W
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ILI9326
	call	PSET_ILI9326
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
	goto	SysForLoop4
ENDIF15
SysForLoopEnd4
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
	call	LINE
;do while (FillCircleXX < FillCircleYY)
SysDoLoop_S5
	movf	FILLCIRCLEYY,W
	subwf	FILLCIRCLEXX,W
	btfsc	STATUS, C
	goto	SysDoLoop_E5
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
	goto	ENDIF17
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
ENDIF17
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
	call	LINE
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
	call	LINE
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
	call	LINE
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
	call	LINE
;loop
	goto	SysDoLoop_S5
SysDoLoop_E5
	return

;********************************************************************************

GLCDDRAWCHAR_ILI9326
;This has got a tad complex
;We have three major pieces
;1 The preamble - this just adjusted color and the input character
;2 The code that deals with GCB fontset
;3 The code that deals with OLED fontset
;
;You can make independent change to section 2 and 3 but they are mutual exclusive with many common pieces
;dim CharCol, CharRow, GLCDTemp as word
;dim COLSperfont, CurrCharVal, CurrCharRow, CurrCharCol, ROWSperfont as byte
;CharCode -= 15
	movlw	15
	subwf	CHARCODE,F
;CharCol=0
	clrf	CHARCOL
	clrf	CHARCOL_H
;if CharCode>=178 and CharCode<=202 then
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	178
	movwf	SysBYTETempB
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempB
	movlw	202
	movwf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	banksel	SYSTEMP1
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfss	SysTemp2,0
	goto	ENDIF23
;CharLocY=CharLocY-1
	movlw	1
	banksel	CHARLOCY
	subwf	CHARLOCY,F
	movlw	0
	subwfb	CHARLOCY_H,F
;end if
ENDIF23
;For CurrCharCol = 1 to 5
	banksel	CURRCHARCOL
	clrf	CURRCHARCOL
SysForLoop5
	incf	CURRCHARCOL,F
;Select Case CurrCharCol
;Case 1: ReadTable GLCDCharCol3, CharCode, CurrCharVal
SysSelect5Case1
	decf	CURRCHARCOL,W
	btfss	STATUS, Z
	goto	SysSelect5Case2
	movf	CHARCODE,W
	movwf	SYSSTRINGA
	pagesel	GLCDCHARCOL3
	call	GLCDCHARCOL3
	pagesel	$
	movwf	CURRCHARVAL
;Case 2: ReadTable GLCDCharCol4, CharCode, CurrCharVal
	goto	SysSelectEnd5
SysSelect5Case2
	movlw	2
	subwf	CURRCHARCOL,W
	btfss	STATUS, Z
	goto	SysSelect5Case3
	movf	CHARCODE,W
	movwf	SYSSTRINGA
	pagesel	GLCDCHARCOL4
	call	GLCDCHARCOL4
	pagesel	$
	movwf	CURRCHARVAL
;Case 3: ReadTable GLCDCharCol5, CharCode, CurrCharVal
	goto	SysSelectEnd5
SysSelect5Case3
	movlw	3
	subwf	CURRCHARCOL,W
	btfss	STATUS, Z
	goto	SysSelect5Case4
	movf	CHARCODE,W
	movwf	SYSSTRINGA
	pagesel	GLCDCHARCOL5
	call	GLCDCHARCOL5
	pagesel	$
	movwf	CURRCHARVAL
;Case 4: ReadTable GLCDCharCol6, CharCode, CurrCharVal
	goto	SysSelectEnd5
SysSelect5Case4
	movlw	4
	subwf	CURRCHARCOL,W
	btfss	STATUS, Z
	goto	SysSelect5Case5
	movf	CHARCODE,W
	movwf	SYSSTRINGA
	pagesel	GLCDCHARCOL6
	call	GLCDCHARCOL6
	pagesel	$
	movwf	CURRCHARVAL
;Case 5: ReadTable GLCDCharCol7, CharCode, CurrCharVal
	goto	SysSelectEnd5
SysSelect5Case5
	movlw	5
	subwf	CURRCHARCOL,W
	btfss	STATUS, Z
	goto	SysSelectEnd5
	movf	CHARCODE,W
	movwf	SYSSTRINGA
	pagesel	GLCDCHARCOL7
	call	GLCDCHARCOL7
	pagesel	$
	movwf	CURRCHARVAL
;End Select
SysSelectEnd5
;CharRow=0
	clrf	CHARROW
	clrf	CHARROW_H
;For CurrCharRow = 1 to 8
	clrf	CURRCHARROW
SysForLoop6
	incf	CURRCHARROW,F
;CharColS=0
	clrf	CHARCOLS
;For Col=1 to GLCDfntDefaultsize
	clrf	COL
	movlw	1
	subwf	GLCDFNTDEFAULTSIZE,W
	btfss	STATUS, C
	goto	SysForLoopEnd7
ENDIF24
SysForLoop7
	incf	COL,F
;CharColS +=1
	incf	CHARCOLS,F
;CharRowS=0
	clrf	CHARROWS
;For Row=1 to GLCDfntDefaultsize
	banksel	ROW
	clrf	ROW
	movlw	1
	banksel	GLCDFNTDEFAULTSIZE
	subwf	GLCDFNTDEFAULTSIZE,W
	btfss	STATUS, C
	goto	SysForLoopEnd8
ENDIF25
SysForLoop8
	banksel	ROW
	incf	ROW,F
;CharRowS +=1
	banksel	CHARROWS
	incf	CHARROWS,F
;if CurrCharVal.0=1 then
	btfss	CURRCHARVAL,0
	goto	ELSE26_1
;PSet [word]CharLocX + CharCol+ CharColS, [word]CharLocY + CharRow+CharRowS, LineColour
	movf	CHARCOL,W
	addwf	CHARLOCX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	CHARCOL_H
	movf	CHARCOL_H,W
	addwfc	CHARLOCX_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	banksel	CHARCOLS
	movf	CHARCOLS,W
	banksel	SYSTEMP1
	addwf	SysTemp1,W
	banksel	GLCDX
	movwf	GLCDX
	movlw	0
	banksel	SYSTEMP1_H
	addwfc	SysTemp1_H,W
	banksel	GLCDX_H
	movwf	GLCDX_H
	movf	CHARROW,W
	addwf	CHARLOCY,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	CHARROW_H
	movf	CHARROW_H,W
	addwfc	CHARLOCY_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	banksel	CHARROWS
	movf	CHARROWS,W
	banksel	SYSTEMP1
	addwf	SysTemp1,W
	banksel	GLCDY
	movwf	GLCDY
	movlw	0
	banksel	SYSTEMP1_H
	addwfc	SysTemp1_H,W
	banksel	GLCDY_H
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ILI9326
	call	PSET_ILI9326
	pagesel	$
;Else
	goto	ENDIF26
ELSE26_1
;PSet [word]CharLocX + CharCol+ CharColS, [word]CharLocY + CharRow+CharRowS, GLCDBackground
	movf	CHARCOL,W
	addwf	CHARLOCX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	CHARCOL_H
	movf	CHARCOL_H,W
	addwfc	CHARLOCX_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	banksel	CHARCOLS
	movf	CHARCOLS,W
	banksel	SYSTEMP1
	addwf	SysTemp1,W
	banksel	GLCDX
	movwf	GLCDX
	movlw	0
	banksel	SYSTEMP1_H
	addwfc	SysTemp1_H,W
	banksel	GLCDX_H
	movwf	GLCDX_H
	movf	CHARROW,W
	addwf	CHARLOCY,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	CHARROW_H
	movf	CHARROW_H,W
	addwfc	CHARLOCY_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	banksel	CHARROWS
	movf	CHARROWS,W
	banksel	SYSTEMP1
	addwf	SysTemp1,W
	banksel	GLCDY
	movwf	GLCDY
	movlw	0
	banksel	SYSTEMP1_H
	addwfc	SysTemp1_H,W
	banksel	GLCDY_H
	movwf	GLCDY_H
	movf	GLCDBACKGROUND,W
	movwf	GLCDCOLOUR
	movf	GLCDBACKGROUND_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ILI9326
	call	PSET_ILI9326
	pagesel	$
;End if
ENDIF26
;Next Row
	movf	GLCDFNTDEFAULTSIZE,W
	banksel	ROW
	subwf	ROW,W
	btfss	STATUS, C
	goto	SysForLoop8
ENDIF27
SysForLoopEnd8
;Next Col
	banksel	GLCDFNTDEFAULTSIZE
	movf	GLCDFNTDEFAULTSIZE,W
	subwf	COL,W
	btfss	STATUS, C
	goto	SysForLoop7
ENDIF28
SysForLoopEnd7
;Rotate CurrCharVal Right
	rrf	CURRCHARVAL,F
;CharRow +=GLCDfntDefaultsize
	movf	GLCDFNTDEFAULTSIZE,W
	addwf	CHARROW,F
	movlw	0
	addwfc	CHARROW_H,F
;Next
	movlw	8
	subwf	CURRCHARROW,W
	btfss	STATUS, C
	goto	SysForLoop6
ENDIF29
SysForLoopEnd6
;CharCol +=GLCDfntDefaultsize
	movf	GLCDFNTDEFAULTSIZE,W
	addwf	CHARCOL,F
	movlw	0
	addwfc	CHARCOL_H,F
;Next
	movlw	5
	subwf	CURRCHARCOL,W
	btfss	STATUS, C
	goto	SysForLoop5
ENDIF30
SysForLoopEnd5
	return

;********************************************************************************

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
	goto	ELSE18_1
;LineStepX = 1
	movlw	1
	movwf	LINESTEPX
	clrf	LINESTEPX_H
;else
	goto	ENDIF18
ELSE18_1
;LineStepX = -1
	movlw	255
	movwf	LINESTEPX
	movwf	LINESTEPX_H
;end if
ENDIF18
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
	goto	ELSE19_1
;LineStepY = 1
	movlw	1
	movwf	LINESTEPY
	clrf	LINESTEPY_H
;else
	goto	ENDIF19
ELSE19_1
;LineStepY = -1
	movlw	255
	movwf	LINESTEPY
	movwf	LINESTEPY_H
;end if
ENDIF19
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
	goto	ELSE20_1
;LineErr = LineDiffY_x2 - LineDiffX
	movf	LINEDIFFX,W
	subwf	LINEDIFFY_X2,W
	movwf	LINEERR
	movf	LINEDIFFX_H,W
	subwfb	LINEDIFFY_X2_H,W
	movwf	LINEERR_H
;do while (   LineX1 <>  LineX2 )
SysDoLoop_S6
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
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	SysDoLoop_E6
;PSet (   LineX1,   LineY1, LineColour )
	banksel	LINEX1
	movf	LINEX1,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	LINEX1_H
	movf	LINEX1_H,W
	banksel	GLCDX_H
	movwf	GLCDX_H
	banksel	LINEY1
	movf	LINEY1,W
	banksel	GLCDY
	movwf	GLCDY
	banksel	LINEY1_H
	movf	LINEY1_H,W
	banksel	GLCDY_H
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ILI9326
	call	PSET_ILI9326
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
	goto	ELSE21_1
;LineErr += LineDiffY_x2
	movf	LINEDIFFY_X2,W
	addwf	LINEERR,F
	movf	LINEDIFFY_X2_H,W
	addwfc	LINEERR_H,F
;else
	goto	ENDIF21
ELSE21_1
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
ENDIF21
;loop
	goto	SysDoLoop_S6
SysDoLoop_E6
;PSet (   LineX1,   LineY1, LineColour )
	banksel	LINEX1
	movf	LINEX1,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	LINEX1_H
	movf	LINEX1_H,W
	banksel	GLCDX_H
	movwf	GLCDX_H
	banksel	LINEY1
	movf	LINEY1,W
	banksel	GLCDY
	movwf	GLCDY
	banksel	LINEY1_H
	movf	LINEY1_H,W
	banksel	GLCDY_H
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ILI9326
	call	PSET_ILI9326
	pagesel	$
;else
	goto	ENDIF20
ELSE20_1
;LineErr = LineDiffX_x2 - LineDiffY
	movf	LINEDIFFY,W
	subwf	LINEDIFFX_X2,W
	movwf	LINEERR
	movf	LINEDIFFY_H,W
	subwfb	LINEDIFFX_X2_H,W
	movwf	LINEERR_H
;do while (   LineY1 <>  LineY2)
SysDoLoop_S7
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
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	SysDoLoop_E7
;PSet (   LineX1,   LineY1, LineColour )
	banksel	LINEX1
	movf	LINEX1,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	LINEX1_H
	movf	LINEX1_H,W
	banksel	GLCDX_H
	movwf	GLCDX_H
	banksel	LINEY1
	movf	LINEY1,W
	banksel	GLCDY
	movwf	GLCDY
	banksel	LINEY1_H
	movf	LINEY1_H,W
	banksel	GLCDY_H
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ILI9326
	call	PSET_ILI9326
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
	goto	ELSE22_1
;LineErr += LineDiffX_x2
	movf	LINEDIFFX_X2,W
	addwf	LINEERR,F
	movf	LINEDIFFX_X2_H,W
	addwfc	LINEERR_H,F
;else
	goto	ENDIF22
ELSE22_1
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
ENDIF22
;loop
	goto	SysDoLoop_S7
SysDoLoop_E7
;PSet (   LineX1,   LineY1, LineColour )
	banksel	LINEX1
	movf	LINEX1,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	LINEX1_H
	movf	LINEX1_H,W
	banksel	GLCDX_H
	movwf	GLCDX_H
	banksel	LINEY1
	movf	LINEY1,W
	banksel	GLCDY
	movwf	GLCDY
	banksel	LINEY1_H
	movf	LINEY1_H,W
	banksel	GLCDY_H
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_ILI9326
	call	PSET_ILI9326
	pagesel	$
;end if
ENDIF20
	return

;********************************************************************************

SHOWCASE1
;GLCDDrawString (2, 1, "GCB", TFT_WHITE )
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX
	clrf	STRINGLOCX_H
	movlw	1
	banksel	CHARLOCY
	movwf	CHARLOCY
	clrf	CHARLOCY_H
	movlw	low StringTable4
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler
	movlw	(high StringTable4) | 128
	movwf	SysCHARSHandler_H
	movlw	255
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	movwf	LINECOLOUR_H
	pagesel	GLCDDRAWSTRING_ILI9326
	call	GLCDDRAWSTRING_ILI9326
	pagesel	$
;GLCDDrawString (56,1,"v.98", TFT_YELLOW )
	movlw	56
	banksel	STRINGLOCX
	movwf	STRINGLOCX
	clrf	STRINGLOCX_H
	movlw	1
	banksel	CHARLOCY
	movwf	CHARLOCY
	clrf	CHARLOCY_H
	movlw	low StringTable5
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler
	movlw	(high StringTable5) | 128
	movwf	SysCHARSHandler_H
	movlw	224
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	movlw	255
	movwf	LINECOLOUR_H
	pagesel	GLCDDRAWSTRING_ILI9326
	call	GLCDDRAWSTRING_ILI9326
	pagesel	$
;GLCDDrawString (2, 16, "DrawStr", TFT_WHITE )
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX
	clrf	STRINGLOCX_H
	movlw	16
	banksel	CHARLOCY
	movwf	CHARLOCY
	clrf	CHARLOCY_H
	movlw	low StringTable6
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler
	movlw	(high StringTable6) | 128
	movwf	SysCHARSHandler_H
	movlw	255
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	movwf	LINECOLOUR_H
	pagesel	GLCDDRAWSTRING_ILI9326
	call	GLCDDRAWSTRING_ILI9326
	pagesel	$
;GLCDDrawString ( 60, 31, "Long Number" )
	movlw	60
	banksel	STRINGLOCX
	movwf	STRINGLOCX
	clrf	STRINGLOCX_H
	movlw	31
	banksel	CHARLOCY
	movwf	CHARLOCY
	clrf	CHARLOCY_H
	movlw	low StringTable7
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler
	movlw	(high StringTable7) | 128
	movwf	SysCHARSHandler_H
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	movwf	LINECOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	LINECOLOUR_H
	pagesel	GLCDDRAWSTRING_ILI9326
	call	GLCDDRAWSTRING_ILI9326
	pagesel	$
;GLCDDrawString ( 60, 39, "Word Number" )
	movlw	60
	banksel	STRINGLOCX
	movwf	STRINGLOCX
	clrf	STRINGLOCX_H
	movlw	39
	banksel	CHARLOCY
	movwf	CHARLOCY
	clrf	CHARLOCY_H
	movlw	low StringTable8
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler
	movlw	(high StringTable8) | 128
	movwf	SysCHARSHandler_H
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	movwf	LINECOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	LINECOLOUR_H
	pagesel	GLCDDRAWSTRING_ILI9326
	call	GLCDDRAWSTRING_ILI9326
	pagesel	$
;GLCDDrawString ( 60, 47, "Byte Number" )
	movlw	60
	banksel	STRINGLOCX
	movwf	STRINGLOCX
	clrf	STRINGLOCX_H
	movlw	47
	banksel	CHARLOCY
	movwf	CHARLOCY
	clrf	CHARLOCY_H
	movlw	low StringTable9
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler
	movlw	(high StringTable9) | 128
	movwf	SysCHARSHandler_H
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	movwf	LINECOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	LINECOLOUR_H
	pagesel	GLCDDRAWSTRING_ILI9326
	call	GLCDDRAWSTRING_ILI9326
	pagesel	$
;GLCDDrawString ( 74, 16, "Asc:" )
	movlw	74
	banksel	STRINGLOCX
	movwf	STRINGLOCX
	clrf	STRINGLOCX_H
	movlw	16
	banksel	CHARLOCY
	movwf	CHARLOCY
	clrf	CHARLOCY_H
	movlw	low StringTable10
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler
	movlw	(high StringTable10) | 128
	movwf	SysCHARSHandler_H
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	movwf	LINECOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	LINECOLOUR_H
	pagesel	GLCDDRAWSTRING_ILI9326
	call	GLCDDRAWSTRING_ILI9326
	pagesel	$
;box 0,0,ILI9326_GLCD_WIDTH-1, ILI9326_GLCD_HEIGHT-1, TFT_YELLOW
	banksel	LINEX1
	clrf	LINEX1
	clrf	LINEX1_H
	clrf	LINEY1
	clrf	LINEY1_H
	movlw	1
	banksel	GLCDDEVICEWIDTH
	subwf	GLCDDEVICEWIDTH,W
	banksel	LINEX2
	movwf	LINEX2
	movlw	0
	banksel	GLCDDEVICEWIDTH_H
	subwfb	GLCDDEVICEWIDTH_H,W
	banksel	LINEX2_H
	movwf	LINEX2_H
	movlw	1
	banksel	GLCDDEVICEHEIGHT
	subwf	GLCDDEVICEHEIGHT,W
	banksel	LINEY2
	movwf	LINEY2
	movlw	0
	banksel	GLCDDEVICEHEIGHT_H
	subwfb	GLCDDEVICEHEIGHT_H,W
	banksel	LINEY2_H
	movwf	LINEY2_H
	movlw	224
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	movlw	255
	movwf	LINECOLOUR_H
	call	BOX
;box ILI9326_GLCD_WIDTH-5, ILI9326_GLCD_HEIGHT-5,ILI9326_GLCD_WIDTH-1, ILI9326_GLCD_HEIGHT-1, TFT_WHITE
	movlw	5
	subwf	GLCDDEVICEWIDTH,W
	banksel	LINEX1
	movwf	LINEX1
	movlw	0
	banksel	GLCDDEVICEWIDTH_H
	subwfb	GLCDDEVICEWIDTH_H,W
	banksel	LINEX1_H
	movwf	LINEX1_H
	movlw	5
	banksel	GLCDDEVICEHEIGHT
	subwf	GLCDDEVICEHEIGHT,W
	banksel	LINEY1
	movwf	LINEY1
	movlw	0
	banksel	GLCDDEVICEHEIGHT_H
	subwfb	GLCDDEVICEHEIGHT_H,W
	banksel	LINEY1_H
	movwf	LINEY1_H
	movlw	1
	banksel	GLCDDEVICEWIDTH
	subwf	GLCDDEVICEWIDTH,W
	banksel	LINEX2
	movwf	LINEX2
	movlw	0
	banksel	GLCDDEVICEWIDTH_H
	subwfb	GLCDDEVICEWIDTH_H,W
	banksel	LINEX2_H
	movwf	LINEX2_H
	movlw	1
	banksel	GLCDDEVICEHEIGHT
	subwf	GLCDDEVICEHEIGHT,W
	banksel	LINEY2
	movwf	LINEY2
	movlw	0
	banksel	GLCDDEVICEHEIGHT_H
	subwfb	GLCDDEVICEHEIGHT_H,W
	banksel	LINEY2_H
	movwf	LINEY2_H
	movlw	255
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	movwf	LINECOLOUR_H
	call	BOX
;Circle( ILI9326_GLCD_WIDTH/2, ILI9326_GLCD_HEIGHT/2, 50, TFT_LIGHTGREY )            ;center
	movf	GLCDDEVICEWIDTH,W
	movwf	SysWORDTempA
	movf	GLCDDEVICEWIDTH_H,W
	movwf	SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempA,W
	banksel	XOFFSET
	movwf	XOFFSET
	movf	SysWORDTempA_H,W
	movwf	XOFFSET_H
	banksel	GLCDDEVICEHEIGHT
	movf	GLCDDEVICEHEIGHT,W
	movwf	SysWORDTempA
	movf	GLCDDEVICEHEIGHT_H,W
	movwf	SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempA,W
	banksel	YOFFSET
	movwf	YOFFSET
	movf	SysWORDTempA_H,W
	movwf	YOFFSET_H
	movlw	50
	banksel	INXRADIUS
	movwf	INXRADIUS
	clrf	INXRADIUS_H
	movlw	24
	movwf	LINECOLOUR
	movlw	198
	movwf	LINECOLOUR_H
	movf	GLCD_YORDINATE,W
	banksel	YORDINATE
	movwf	YORDINATE
	banksel	STATUS
	pagesel	CIRCLE
	call	CIRCLE
	pagesel	$
;FilledCircle( ILI9326_GLCD_WIDTH/2, ILI9326_GLCD_HEIGHT/2, 25, TFT_DARKGREY  )
	movf	GLCDDEVICEWIDTH,W
	movwf	SysWORDTempA
	movf	GLCDDEVICEWIDTH_H,W
	movwf	SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempA,W
	banksel	XOFFSET
	movwf	XOFFSET
	movf	SysWORDTempA_H,W
	movwf	XOFFSET_H
	banksel	GLCDDEVICEHEIGHT
	movf	GLCDDEVICEHEIGHT,W
	movwf	SysWORDTempA
	movf	GLCDDEVICEHEIGHT_H,W
	movwf	SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempA,W
	banksel	YOFFSET
	movwf	YOFFSET
	movf	SysWORDTempA_H,W
	movwf	YOFFSET_H
	movlw	25
	movwf	XRADIUS
	clrf	XRADIUS_H
	movlw	239
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	movlw	123
	movwf	LINECOLOUR_H
	call	FILLEDCIRCLE
;line 0,  ILI9326_GLCD_HEIGHT-1 , ILI9326_GLCD_WIDTH/2 +100,  (ILI9326_GLCD_HEIGHT /2) - 50, TFT_CYAN
	banksel	LINEX1
	clrf	LINEX1
	clrf	LINEX1_H
	movlw	1
	banksel	GLCDDEVICEHEIGHT
	subwf	GLCDDEVICEHEIGHT,W
	banksel	LINEY1
	movwf	LINEY1
	movlw	0
	banksel	GLCDDEVICEHEIGHT_H
	subwfb	GLCDDEVICEHEIGHT_H,W
	banksel	LINEY1_H
	movwf	LINEY1_H
	banksel	GLCDDEVICEWIDTH
	movf	GLCDDEVICEWIDTH,W
	movwf	SysWORDTempA
	movf	GLCDDEVICEWIDTH_H,W
	movwf	SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movlw	100
	addwf	SysWORDTempA,W
	banksel	LINEX2
	movwf	LINEX2
	movlw	0
	addwfc	SysWORDTempA_H,W
	movwf	LINEX2_H
	banksel	GLCDDEVICEHEIGHT
	movf	GLCDDEVICEHEIGHT,W
	movwf	SysWORDTempA
	movf	GLCDDEVICEHEIGHT_H,W
	movwf	SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempA,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movf	SysWORDTempA_H,W
	movwf	SysTemp1_H
	movlw	50
	subwf	SysTemp1,W
	movwf	LINEY2
	movlw	0
	subwfb	SysTemp1_H,W
	movwf	LINEY2_H
	movlw	255
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	movlw	7
	movwf	LINECOLOUR_H
	call	LINE
;line  0, (ILI9326_GLCD_HEIGHT /2) - 50, ILI9326_GLCD_WIDTH/2 +100, (ILI9326_GLCD_HEIGHT /2) - 50, TFT_CYAN
	banksel	LINEX1
	clrf	LINEX1
	clrf	LINEX1_H
	banksel	GLCDDEVICEHEIGHT
	movf	GLCDDEVICEHEIGHT,W
	movwf	SysWORDTempA
	movf	GLCDDEVICEHEIGHT_H,W
	movwf	SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempA,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movf	SysWORDTempA_H,W
	movwf	SysTemp1_H
	movlw	50
	subwf	SysTemp1,W
	movwf	LINEY1
	movlw	0
	subwfb	SysTemp1_H,W
	movwf	LINEY1_H
	banksel	GLCDDEVICEWIDTH
	movf	GLCDDEVICEWIDTH,W
	movwf	SysWORDTempA
	movf	GLCDDEVICEWIDTH_H,W
	movwf	SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movlw	100
	addwf	SysWORDTempA,W
	banksel	LINEX2
	movwf	LINEX2
	movlw	0
	addwfc	SysWORDTempA_H,W
	movwf	LINEX2_H
	banksel	GLCDDEVICEHEIGHT
	movf	GLCDDEVICEHEIGHT,W
	movwf	SysWORDTempA
	movf	GLCDDEVICEHEIGHT_H,W
	movwf	SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempA,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movf	SysWORDTempA_H,W
	movwf	SysTemp1_H
	movlw	50
	subwf	SysTemp1,W
	movwf	LINEY2
	movlw	0
	subwfb	SysTemp1_H,W
	movwf	LINEY2_H
	movlw	255
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	movlw	7
	movwf	LINECOLOUR_H
	call	LINE
;filledbox 2,ILI9326_GLCD_HEIGHT/2+10,42,ILI9326_GLCD_HEIGHT/2+50, TFT_RED
	movlw	2
	banksel	LINEX1
	movwf	LINEX1
	clrf	LINEX1_H
	banksel	GLCDDEVICEHEIGHT
	movf	GLCDDEVICEHEIGHT,W
	movwf	SysWORDTempA
	movf	GLCDDEVICEHEIGHT_H,W
	movwf	SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movlw	10
	addwf	SysWORDTempA,W
	banksel	LINEY1
	movwf	LINEY1
	movlw	0
	addwfc	SysWORDTempA_H,W
	movwf	LINEY1_H
	movlw	42
	movwf	LINEX2
	clrf	LINEX2_H
	banksel	GLCDDEVICEHEIGHT
	movf	GLCDDEVICEHEIGHT,W
	movwf	SysWORDTempA
	movf	GLCDDEVICEHEIGHT_H,W
	movwf	SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movlw	50
	addwf	SysWORDTempA,W
	banksel	LINEY2
	movwf	LINEY2
	movlw	0
	addwfc	SysWORDTempA_H,W
	movwf	LINEY2_H
	banksel	LINECOLOUR
	clrf	LINECOLOUR
	movlw	248
	movwf	LINECOLOUR_H
	pagesel	FILLEDBOX_ILI9326
	call	FILLEDBOX_ILI9326
	pagesel	$
;oldfont = GLCDfntDefaultsize
	movf	GLCDFNTDEFAULTSIZE,W
	banksel	OLDFONT
	movwf	OLDFONT
;GLCDfntDefaultsize = 3
	movlw	3
	banksel	GLCDFNTDEFAULTSIZE
	movwf	GLCDFNTDEFAULTSIZE
;GLCDDrawString ( 42, ILI9326_GLCD_HEIGHT - 30 , "ILI9326" , TFT_WHITE )
	movlw	42
	banksel	STRINGLOCX
	movwf	STRINGLOCX
	clrf	STRINGLOCX_H
	movlw	30
	banksel	GLCDDEVICEHEIGHT
	subwf	GLCDDEVICEHEIGHT,W
	movwf	CHARLOCY
	movlw	0
	subwfb	GLCDDEVICEHEIGHT_H,W
	movwf	CHARLOCY_H
	movlw	low StringTable11
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler
	movlw	(high StringTable11) | 128
	movwf	SysCHARSHandler_H
	movlw	255
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	movwf	LINECOLOUR_H
	pagesel	GLCDDRAWSTRING_ILI9326
	call	GLCDDRAWSTRING_ILI9326
	pagesel	$
;GLCDfntDefaultsize = 1
	movlw	1
	movwf	GLCDFNTDEFAULTSIZE
;GLCDDrawString ( ILI9326_GLCD_WIDTH - 32, 2 , "2018" , TFT_WHITE )
	movlw	32
	subwf	GLCDDEVICEWIDTH,W
	banksel	STRINGLOCX
	movwf	STRINGLOCX
	movlw	0
	banksel	GLCDDEVICEWIDTH_H
	subwfb	GLCDDEVICEWIDTH_H,W
	banksel	STRINGLOCX_H
	movwf	STRINGLOCX_H
	movlw	2
	banksel	CHARLOCY
	movwf	CHARLOCY
	clrf	CHARLOCY_H
	movlw	low StringTable12
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler
	movlw	(high StringTable12) | 128
	movwf	SysCHARSHandler_H
	movlw	255
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	movwf	LINECOLOUR_H
	pagesel	GLCDDRAWSTRING_ILI9326
	call	GLCDDRAWSTRING_ILI9326
	pagesel	$
;GLCDDrawString ( ILI9326_GLCD_WIDTH - 66, 10 , "8 bit bus" , TFT_WHITE )
	movlw	66
	subwf	GLCDDEVICEWIDTH,W
	banksel	STRINGLOCX
	movwf	STRINGLOCX
	movlw	0
	banksel	GLCDDEVICEWIDTH_H
	subwfb	GLCDDEVICEWIDTH_H,W
	banksel	STRINGLOCX_H
	movwf	STRINGLOCX_H
	movlw	10
	banksel	CHARLOCY
	movwf	CHARLOCY
	clrf	CHARLOCY_H
	movlw	low StringTable13
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler
	movlw	(high StringTable13) | 128
	movwf	SysCHARSHandler_H
	movlw	255
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	movwf	LINECOLOUR_H
	pagesel	GLCDDRAWSTRING_ILI9326
	call	GLCDDRAWSTRING_ILI9326
	pagesel	$
;Revert the font size
;GLCDfntDefaultsize = oldfont
	banksel	OLDFONT
	movf	OLDFONT,W
	banksel	GLCDFNTDEFAULTSIZE
	movwf	GLCDFNTDEFAULTSIZE
;GLCDForeground = TFT_WHITE
	movlw	255
	movwf	GLCDFOREGROUND
	movwf	GLCDFOREGROUND_H
;DO forever
SysDoLoop_S1
;GLCDPrint ( 144 , 31, longNumber)
	movlw	144
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	31
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movf	LONGNUMBER,W
	banksel	LCDVALUE
	movwf	LCDVALUE
	banksel	LONGNUMBER_H
	movf	LONGNUMBER_H,W
	banksel	LCDVALUE_H
	movwf	LCDVALUE_H
	banksel	LONGNUMBER_U
	movf	LONGNUMBER_U,W
	banksel	LCDVALUE_U
	movwf	LCDVALUE_U
	banksel	LONGNUMBER_E
	movf	LONGNUMBER_E,W
	banksel	LCDVALUE_E
	movwf	LCDVALUE_E
	pagesel	GLCDPRINT7
	call	GLCDPRINT7
	pagesel	$
;GLCDPrint ( 144 , 39, pad( str(wordnumber),5))
	movlw	144
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	39
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movf	WORDNUMBER,W
	movwf	SYSVALTEMP
	movf	WORDNUMBER_H,W
	movwf	SYSVALTEMP_H
	banksel	STATUS
	pagesel	FN_STR
	call	FN_STR
	pagesel	$
	movlw	low STR
	banksel	SYSSYSINSTRINGHANDLER
	movwf	SysSYSINSTRINGHandler
	movlw	high STR
	movwf	SysSYSINSTRINGHandler_H
	movlw	5
	movwf	SYSSTRLEN
	movlw	low StringTable46
	movwf	SysSYSINSTRING3Handler
	movlw	(high StringTable46) | 128
	movwf	SysSYSINSTRING3Handler_H
	banksel	STATUS
	pagesel	FN_PAD
	call	FN_PAD
	pagesel	$
	movlw	low PAD
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler
	movlw	high PAD
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	pagesel	GLCDPRINT5
	call	GLCDPRINT5
	pagesel	$
;GLCDPrint ( 144 , 47, pad( str(bytenumber),3))
	movlw	144
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	47
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	banksel	BYTENUMBER
	movf	BYTENUMBER,W
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	clrf	SYSVALTEMP_H
	banksel	STATUS
	pagesel	FN_STR
	call	FN_STR
	pagesel	$
	movlw	low STR
	banksel	SYSSYSINSTRINGHANDLER
	movwf	SysSYSINSTRINGHandler
	movlw	high STR
	movwf	SysSYSINSTRINGHandler_H
	movlw	3
	movwf	SYSSTRLEN
	movlw	low StringTable46
	movwf	SysSYSINSTRING3Handler
	movlw	(high StringTable46) | 128
	movwf	SysSYSINSTRING3Handler_H
	banksel	STATUS
	pagesel	FN_PAD
	call	FN_PAD
	pagesel	$
	movlw	low PAD
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler
	movlw	high PAD
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	pagesel	GLCDPRINT5
	call	GLCDPRINT5
	pagesel	$
;GLCDDrawChar(54, 16, CCount )
	movlw	54
	movwf	CHARLOCX
	clrf	CHARLOCX_H
	movlw	16
	movwf	CHARLOCY
	clrf	CHARLOCY_H
	movf	CCOUNT,W
	movwf	CHARCODE
	movf	GLCDFOREGROUND,W
	movwf	LINECOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	LINECOLOUR_H
	call	GLCDDRAWCHAR_ILI9326
;Box 52,15,62,26, TFT_WHITE                'Draw a box around the Char below
	movlw	52
	banksel	LINEX1
	movwf	LINEX1
	clrf	LINEX1_H
	movlw	15
	movwf	LINEY1
	clrf	LINEY1_H
	movlw	62
	movwf	LINEX2
	clrf	LINEX2_H
	movlw	26
	movwf	LINEY2
	clrf	LINEY2_H
	movlw	255
	banksel	LINECOLOUR
	movwf	LINECOLOUR
	movwf	LINECOLOUR_H
	call	BOX
;GLCDDrawString ( 100, 16 , pad( str(CCount),3) )
	movlw	100
	banksel	STRINGLOCX
	movwf	STRINGLOCX
	clrf	STRINGLOCX_H
	movlw	16
	banksel	CHARLOCY
	movwf	CHARLOCY
	clrf	CHARLOCY_H
	movf	CCOUNT,W
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	clrf	SYSVALTEMP_H
	banksel	STATUS
	pagesel	FN_STR
	call	FN_STR
	pagesel	$
	movlw	low STR
	banksel	SYSSYSINSTRINGHANDLER
	movwf	SysSYSINSTRINGHandler
	movlw	high STR
	movwf	SysSYSINSTRINGHandler_H
	movlw	3
	movwf	SYSSTRLEN
	movlw	low StringTable46
	movwf	SysSYSINSTRING3Handler
	movlw	(high StringTable46) | 128
	movwf	SysSYSINSTRING3Handler_H
	banksel	STATUS
	pagesel	FN_PAD
	call	FN_PAD
	pagesel	$
	movlw	low PAD
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler
	movlw	high PAD
	movwf	SysCHARSHandler_H
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	movwf	LINECOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	LINECOLOUR_H
	pagesel	GLCDDRAWSTRING_ILI9326
	call	GLCDDRAWSTRING_ILI9326
	pagesel	$
;CCount++
	incf	CCOUNT,F
;if CCount = 0 then CCount = 31
	movf	CCOUNT,F
	btfss	STATUS, Z
	goto	ENDIF1
	movlw	31
	movwf	CCOUNT
ENDIF1
;if CCount = 128 then CCount = 192
	movlw	128
	subwf	CCOUNT,W
	btfss	STATUS, Z
	goto	ENDIF2
	movlw	192
	movwf	CCOUNT
ENDIF2
;longNumber = longNumber + 7
	movlw	7
	banksel	LONGNUMBER
	addwf	LONGNUMBER,F
	movlw	0
	addwfc	LONGNUMBER_H,F
	movlw	0
	addwfc	LONGNUMBER_U,F
	movlw	0
	addwfc	LONGNUMBER_E,F
;wordNumber = wordNumber + 3
	movlw	3
	addwf	WORDNUMBER,F
	movlw	0
	addwfc	WORDNUMBER_H,F
;byteNumber++
	banksel	BYTENUMBER
	incf	BYTENUMBER,F
;LOOP
	goto	SysDoLoop_S1
SysDoLoop_E1
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
	retlw	16
	retlw	71	;G
	retlw	76	;L
	retlw	67	;C
	retlw	68	;D
	retlw	80	;P
	retlw	114	;r
	retlw	105	;i
	retlw	110	;n
	retlw	116	;t
	retlw	32	; 
	retlw	83	;S
	retlw	116	;t
	retlw	114	;r
	retlw	105	;i
	retlw	110	;n
	retlw	103	;g


StringTable2
	retlw	9
	retlw	71	;G
	retlw	76	;L
	retlw	67	;C
	retlw	68	;D
	retlw	32	; 
	retlw	102	;f
	retlw	111	;o
	retlw	110	;n
	retlw	116	;t


StringTable3
	retlw	8
	retlw	115	;s
	retlw	105	;i
	retlw	122	;z
	retlw	101	;e
	retlw	32	; 
	retlw	61	; (equals)
	retlw	32	; 
	retlw	51	;3


StringTable4
	retlw	3
	retlw	71	;G
	retlw	67	;C
	retlw	66	;B


StringTable5
	retlw	4
	retlw	118	;v
	retlw	46	;.
	retlw	57	;9
	retlw	56	;8


StringTable6
	retlw	7
	retlw	68	;D
	retlw	114	;r
	retlw	97	;a
	retlw	119	;w
	retlw	83	;S
	retlw	116	;t
	retlw	114	;r


StringTable7
	retlw	11
	retlw	76	;L
	retlw	111	;o
	retlw	110	;n
	retlw	103	;g
	retlw	32	; 
	retlw	78	;N
	retlw	117	;u
	retlw	109	;m
	retlw	98	;b
	retlw	101	;e
	retlw	114	;r


StringTable8
	retlw	11
	retlw	87	;W
	retlw	111	;o
	retlw	114	;r
	retlw	100	;d
	retlw	32	; 
	retlw	78	;N
	retlw	117	;u
	retlw	109	;m
	retlw	98	;b
	retlw	101	;e
	retlw	114	;r


StringTable9
	retlw	11
	retlw	66	;B
	retlw	121	;y
	retlw	116	;t
	retlw	101	;e
	retlw	32	; 
	retlw	78	;N
	retlw	117	;u
	retlw	109	;m
	retlw	98	;b
	retlw	101	;e
	retlw	114	;r


StringTable10
	retlw	4
	retlw	65	;A
	retlw	115	;s
	retlw	99	;c
	retlw	58	;:


StringTable11
	retlw	7
	retlw	73	;I
	retlw	76	;L
	retlw	73	;I
	retlw	57	;9
	retlw	51	;3
	retlw	50	;2
	retlw	54	;6


StringTable12
	retlw	4
	retlw	50	;2
	retlw	48	;0
	retlw	49	;1
	retlw	56	;8


StringTable13
	retlw	9
	retlw	56	;8
	retlw	32	; 
	retlw	98	;b
	retlw	105	;i
	retlw	116	;t
	retlw	32	; 
	retlw	98	;b
	retlw	117	;u
	retlw	115	;s


StringTable14
	retlw	5
	retlw	76	;L
	retlw	111	;o
	retlw	110	;n
	retlw	103	;g
	retlw	58	;:


StringTable15
	retlw	5
	retlw	87	;W
	retlw	111	;o
	retlw	114	;r
	retlw	100	;d
	retlw	58	;:


StringTable16
	retlw	5
	retlw	66	;B
	retlw	121	;y
	retlw	116	;t
	retlw	101	;e
	retlw	58	;:


StringTable17
	retlw	2
	retlw	32	; 
	retlw	32	; 


StringTable18
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


StringTable46
	retlw	1
	retlw	32	; 


StringTable71
	retlw	0


;********************************************************************************

;Start of program memory page 2
	ORG	4096
FILLEDBOX_ILI9326
;dim GLCDTemp, DrawLine as word
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
	goto	ENDIF31
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
ENDIF31
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
	goto	ENDIF32
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
ENDIF32
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
	goto	SysForLoopEnd9
ENDIF33
SysForLoop9
	incf	DRAWLINE,F
	btfsc	STATUS,Z
	incf	DRAWLINE_H,F
;For GLCDTemp = LineY1 To LineY2
	movlw	1
	banksel	LINEY1
	subwf	LINEY1,W
	banksel	GLCDTEMP
	movwf	GLCDTEMP
	movlw	0
	banksel	LINEY1_H
	subwfb	LINEY1_H,W
	banksel	GLCDTEMP_H
	movwf	GLCDTEMP_H
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
	goto	SysForLoopEnd10
ENDIF34
SysForLoop10
	incf	GLCDTEMP,F
	btfsc	STATUS,Z
	incf	GLCDTEMP_H,F
;PSet DrawLine, GLCDTemp, LineColour
	movf	DRAWLINE,W
	movwf	GLCDX
	movf	DRAWLINE_H,W
	movwf	GLCDX_H
	movf	GLCDTEMP,W
	movwf	GLCDY
	movf	GLCDTEMP_H,W
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	call	PSET_ILI9326
;Next
	movf	GLCDTEMP,W
	movwf	SysWORDTempA
	movf	GLCDTEMP_H,W
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
	goto	SysForLoop10
ENDIF35
SysForLoopEnd10
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
	goto	SysForLoop9
ENDIF36
SysForLoopEnd9
	return

;********************************************************************************

GLCDCHARCOL3
	movlw	113
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableGLCDCHARCOL3
	movwf	SysStringA
	movlw	(high TableGLCDCHARCOL3) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableGLCDCHARCOL3
	retlw	112
	retlw	0
	retlw	16
	retlw	12
	retlw	10
	retlw	136
	retlw	34
	retlw	56
	retlw	32
	retlw	8
	retlw	32
	retlw	16
	retlw	16
	retlw	128
	retlw	128
	retlw	64
	retlw	4
	retlw	0
	retlw	0
	retlw	0
	retlw	40
	retlw	72
	retlw	70
	retlw	108
	retlw	0
	retlw	0
	retlw	0
	retlw	40
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	64
	retlw	124
	retlw	0
	retlw	132
	retlw	130
	retlw	48
	retlw	78
	retlw	120
	retlw	6
	retlw	108
	retlw	12
	retlw	0
	retlw	0
	retlw	16
	retlw	40
	retlw	0
	retlw	4
	retlw	100
	retlw	248
	retlw	254
	retlw	124
	retlw	254
	retlw	254
	retlw	254
	retlw	124
	retlw	254
	retlw	0
	retlw	64
	retlw	254
	retlw	254
	retlw	254
	retlw	254
	retlw	124
	retlw	254
	retlw	124
	retlw	254
	retlw	76
	retlw	2
	retlw	126
	retlw	62
	retlw	126
	retlw	198
	retlw	14
	retlw	194
	retlw	0
	retlw	4
	retlw	0
	retlw	8
	retlw	128
	retlw	0
	retlw	64
	retlw	254
	retlw	112
	retlw	112
	retlw	112
	retlw	16
	retlw	16
	retlw	254
	retlw	0
	retlw	64
	retlw	254
	retlw	0
	retlw	248
	retlw	248
	retlw	112
	retlw	248
	retlw	16
	retlw	248
	retlw	144
	retlw	16
	retlw	120
	retlw	56
	retlw	120
	retlw	136
	retlw	24
	retlw	136
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	120

;********************************************************************************

GLCDCHARCOL4
	movlw	113
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableGLCDCHARCOL4
	movwf	SysStringA
	movlw	(high TableGLCDCHARCOL4) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableGLCDCHARCOL4
	retlw	112
	retlw	254
	retlw	56
	retlw	10
	retlw	6
	retlw	204
	retlw	102
	retlw	124
	retlw	112
	retlw	4
	retlw	64
	retlw	16
	retlw	56
	retlw	136
	retlw	162
	retlw	112
	retlw	28
	retlw	0
	retlw	0
	retlw	14
	retlw	254
	retlw	84
	retlw	38
	retlw	146
	retlw	10
	retlw	56
	retlw	130
	retlw	16
	retlw	16
	retlw	160
	retlw	16
	retlw	192
	retlw	32
	retlw	162
	retlw	132
	retlw	194
	retlw	130
	retlw	40
	retlw	138
	retlw	148
	retlw	2
	retlw	146
	retlw	146
	retlw	108
	retlw	172
	retlw	40
	retlw	40
	retlw	130
	retlw	2
	retlw	146
	retlw	36
	retlw	146
	retlw	130
	retlw	130
	retlw	146
	retlw	18
	retlw	130
	retlw	16
	retlw	130
	retlw	128
	retlw	16
	retlw	128
	retlw	4
	retlw	8
	retlw	130
	retlw	18
	retlw	130
	retlw	18
	retlw	146
	retlw	2
	retlw	128
	retlw	64
	retlw	128
	retlw	40
	retlw	16
	retlw	162
	retlw	254
	retlw	8
	retlw	130
	retlw	4
	retlw	128
	retlw	2
	retlw	168
	retlw	144
	retlw	136
	retlw	136
	retlw	168
	retlw	252
	retlw	168
	retlw	16
	retlw	144
	retlw	128
	retlw	32
	retlw	130
	retlw	8
	retlw	16
	retlw	136
	retlw	40
	retlw	40
	retlw	16
	retlw	168
	retlw	124
	retlw	128
	retlw	64
	retlw	128
	retlw	80
	retlw	160
	retlw	200
	retlw	16
	retlw	0
	retlw	130
	retlw	16
	retlw	68

;********************************************************************************

GLCDCHARCOL5
	movlw	113
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableGLCDCHARCOL5
	movwf	SysStringA
	movlw	(high TableGLCDCHARCOL5) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableGLCDCHARCOL5
	retlw	112
	retlw	124
	retlw	124
	retlw	0
	retlw	0
	retlw	238
	retlw	238
	retlw	124
	retlw	168
	retlw	254
	retlw	254
	retlw	84
	retlw	84
	retlw	148
	retlw	148
	retlw	124
	retlw	124
	retlw	0
	retlw	158
	retlw	0
	retlw	40
	retlw	254
	retlw	16
	retlw	170
	retlw	6
	retlw	68
	retlw	68
	retlw	124
	retlw	124
	retlw	96
	retlw	16
	retlw	192
	retlw	16
	retlw	146
	retlw	254
	retlw	162
	retlw	138
	retlw	36
	retlw	138
	retlw	146
	retlw	226
	retlw	146
	retlw	146
	retlw	108
	retlw	108
	retlw	68
	retlw	40
	retlw	68
	retlw	162
	retlw	242
	retlw	34
	retlw	146
	retlw	130
	retlw	130
	retlw	146
	retlw	18
	retlw	146
	retlw	16
	retlw	254
	retlw	130
	retlw	40
	retlw	128
	retlw	24
	retlw	16
	retlw	130
	retlw	18
	retlw	162
	retlw	50
	retlw	146
	retlw	254
	retlw	128
	retlw	128
	retlw	112
	retlw	16
	retlw	224
	retlw	146
	retlw	130
	retlw	16
	retlw	130
	retlw	2
	retlw	128
	retlw	4
	retlw	168
	retlw	136
	retlw	136
	retlw	136
	retlw	168
	retlw	18
	retlw	168
	retlw	8
	retlw	250
	retlw	136
	retlw	80
	retlw	254
	retlw	240
	retlw	8
	retlw	136
	retlw	40
	retlw	40
	retlw	8
	retlw	168
	retlw	144
	retlw	128
	retlw	128
	retlw	96
	retlw	32
	retlw	160
	retlw	168
	retlw	108
	retlw	254
	retlw	108
	retlw	16
	retlw	66

;********************************************************************************

GLCDCHARCOL6
	movlw	113
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableGLCDCHARCOL6
	movwf	SysStringA
	movlw	(high TableGLCDCHARCOL6) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableGLCDCHARCOL6
	retlw	112
	retlw	56
	retlw	254
	retlw	12
	retlw	10
	retlw	204
	retlw	102
	retlw	124
	retlw	32
	retlw	4
	retlw	64
	retlw	56
	retlw	16
	retlw	162
	retlw	136
	retlw	112
	retlw	28
	retlw	0
	retlw	0
	retlw	14
	retlw	254
	retlw	84
	retlw	200
	retlw	68
	retlw	0
	retlw	130
	retlw	56
	retlw	16
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	8
	retlw	138
	retlw	128
	retlw	146
	retlw	150
	retlw	254
	retlw	138
	retlw	146
	retlw	18
	retlw	146
	retlw	82
	retlw	0
	retlw	0
	retlw	130
	retlw	40
	retlw	40
	retlw	18
	retlw	130
	retlw	36
	retlw	146
	retlw	130
	retlw	68
	retlw	146
	retlw	18
	retlw	146
	retlw	16
	retlw	130
	retlw	126
	retlw	68
	retlw	128
	retlw	4
	retlw	32
	retlw	130
	retlw	18
	retlw	66
	retlw	82
	retlw	146
	retlw	2
	retlw	128
	retlw	64
	retlw	128
	retlw	40
	retlw	16
	retlw	138
	retlw	130
	retlw	32
	retlw	254
	retlw	4
	retlw	128
	retlw	8
	retlw	168
	retlw	136
	retlw	136
	retlw	144
	retlw	168
	retlw	2
	retlw	168
	retlw	8
	retlw	128
	retlw	122
	retlw	136
	retlw	128
	retlw	8
	retlw	8
	retlw	136
	retlw	40
	retlw	48
	retlw	8
	retlw	168
	retlw	128
	retlw	64
	retlw	64
	retlw	128
	retlw	80
	retlw	160
	retlw	152
	retlw	130
	retlw	0
	retlw	16
	retlw	32
	retlw	68

;********************************************************************************

GLCDCHARCOL7
	movlw	113
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableGLCDCHARCOL7
	movwf	SysStringA
	movlw	(high TableGLCDCHARCOL7) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableGLCDCHARCOL7
	retlw	112
	retlw	16
	retlw	0
	retlw	10
	retlw	6
	retlw	136
	retlw	34
	retlw	56
	retlw	62
	retlw	8
	retlw	32
	retlw	16
	retlw	16
	retlw	128
	retlw	128
	retlw	64
	retlw	4
	retlw	0
	retlw	0
	retlw	0
	retlw	40
	retlw	36
	retlw	196
	retlw	160
	retlw	0
	retlw	0
	retlw	0
	retlw	40
	retlw	16
	retlw	0
	retlw	16
	retlw	0
	retlw	4
	retlw	124
	retlw	0
	retlw	140
	retlw	98
	retlw	32
	retlw	114
	retlw	96
	retlw	14
	retlw	108
	retlw	60
	retlw	0
	retlw	0
	retlw	0
	retlw	40
	retlw	16
	retlw	12
	retlw	124
	retlw	248
	retlw	108
	retlw	68
	retlw	56
	retlw	130
	retlw	2
	retlw	244
	retlw	254
	retlw	0
	retlw	2
	retlw	130
	retlw	128
	retlw	254
	retlw	254
	retlw	124
	retlw	12
	retlw	188
	retlw	140
	retlw	100
	retlw	2
	retlw	126
	retlw	62
	retlw	126
	retlw	198
	retlw	14
	retlw	134
	retlw	0
	retlw	64
	retlw	0
	retlw	8
	retlw	128
	retlw	0
	retlw	240
	retlw	112
	retlw	64
	retlw	254
	retlw	48
	retlw	4
	retlw	120
	retlw	240
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	240
	retlw	240
	retlw	112
	retlw	16
	retlw	248
	retlw	16
	retlw	64
	retlw	64
	retlw	248
	retlw	56
	retlw	120
	retlw	136
	retlw	120
	retlw	136
	retlw	0
	retlw	0
	retlw	0
	retlw	16
	retlw	120

;********************************************************************************

GLCDCLS_ILI9326
;initialise global variable. Required variable for Circle in all DEVICE DRIVERS- DO NOT DELETE
;GLCD_yordinate = 0
	clrf	GLCD_YORDINATE
	clrf	GLCD_YORDINATE_H
;sendCommand_ili9326(ILI9326_GRAM_ADDR_V_SET)
	movlw	1
	movwf	ILI9326_SENDWORD
	movlw	2
	movwf	ILI9326_SENDWORD_H
	call	SENDCOMMAND_ILI9326
;sendData_ili9326( 0 )
	clrf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;sendCommand_ili9326(ILI9326_GRAM_ADDR_H_SET)
	clrf	ILI9326_SENDWORD
	movlw	2
	movwf	ILI9326_SENDWORD_H
	call	SENDCOMMAND_ILI9326
;sendData_ili9326( 0 )
	clrf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;SendCommand_ili9326(ILI9326_GRAM_WR_DATA)
	movlw	2
	movwf	ILI9326_SENDWORD
	movwf	ILI9326_SENDWORD_H
	call	SENDCOMMAND_ILI9326
;Use this method rather then call SendData_ili9326( as this is faster
;set ILI9326_GLCD_RS ON
	banksel	LATA
	bsf	LATA,1
;repeat GLCD_HEIGHT
	movlw	144
	banksel	SYSREPEATTEMP2
	movwf	SysRepeatTemp2
	movlw	2
	movwf	SysRepeatTemp2_H
SysRepeatLoop2
;repeat GLCD_WIDTH
	movlw	240
	movwf	SysRepeatTemp3
SysRepeatLoop3
;ILI9326_DataPort=GLCDBackground_h
	banksel	GLCDBACKGROUND_H
	movf	GLCDBACKGROUND_H,W
	movwf	PORTD
;set ILI9326_GLCD_WR OFF
	banksel	LATA
	bcf	LATA,2
;set ILI9326_GLCD_WR ON
	bsf	LATA,2
;ILI9326_DataPort=GLCDBackground
	banksel	GLCDBACKGROUND
	movf	GLCDBACKGROUND,W
	movwf	PORTD
;set ILI9326_GLCD_WR OFF
	banksel	LATA
	bcf	LATA,2
;set ILI9326_GLCD_WR ON
	bsf	LATA,2
;end repeat
	banksel	SYSREPEATTEMP3
	decfsz	SysRepeatTemp3,F
	goto	SysRepeatLoop3
SysRepeatLoopEnd3
;end repeat
	decfsz	SysRepeatTemp2,F
	goto	SysRepeatLoop2
	decfsz	SysRepeatTemp2_H,F
	goto	SysRepeatLoop2
SysRepeatLoopEnd2
;sendCommand_ili9326(ILI9326_GRAM_ADDR_V_SET)
	movlw	1
	banksel	ILI9326_SENDWORD
	movwf	ILI9326_SENDWORD
	movlw	2
	movwf	ILI9326_SENDWORD_H
	call	SENDCOMMAND_ILI9326
;sendData_ili9326( 0 )
	clrf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;sendCommand_ili9326(ILI9326_GRAM_ADDR_H_SET)
	clrf	ILI9326_SENDWORD
	movlw	2
	movwf	ILI9326_SENDWORD_H
	call	SENDCOMMAND_ILI9326
;sendData_ili9326( 0 )
	clrf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	goto	SENDDATA_ILI9326

;********************************************************************************

GLCDDRAWSTRING_ILI9326
;dim GLCDPrintLoc as word
;dim xchar as byte
;GLCDPrintLoc = StringLocX
	banksel	STRINGLOCX
	movf	STRINGLOCX,W
	banksel	GLCDPRINTLOC
	movwf	GLCDPRINTLOC
	banksel	STRINGLOCX_H
	movf	STRINGLOCX_H,W
	banksel	GLCDPRINTLOC_H
	movwf	GLCDPRINTLOC_H
;for xchar = 1 to Chars(0)
	banksel	XCHAR
	clrf	XCHAR
	movf	SysCHARSHandler,W
	movwf	AFSR0
	movf	SysCHARSHandler_H,W
	movwf	AFSR0_H
	movlw	1
	subwf	INDF0,W
	btfss	STATUS, C
	goto	SysForLoopEnd11
ENDIF37
SysForLoop11
	incf	XCHAR,F
;GLCDDrawChar GLCDPrintLoc , CharLocY , Chars(xchar), LineColour
	banksel	GLCDPRINTLOC
	movf	GLCDPRINTLOC,W
	movwf	CHARLOCX
	movf	GLCDPRINTLOC_H,W
	movwf	CHARLOCX_H
	banksel	XCHAR
	movf	XCHAR,W
	addwf	SysCHARSHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysCHARSHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	CHARCODE
	movwf	CHARCODE
	pagesel	GLCDDRAWCHAR_ILI9326
	call	GLCDDRAWCHAR_ILI9326
	pagesel	$
;GLCDPrintIncrementPixelPositionMacro
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize )+1
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
	movlw	1
	addwf	SysTemp2,W
	banksel	GLCDPRINTLOC
	movwf	GLCDPRINTLOC
	movlw	0
	banksel	SYSTEMP2_H
	addwfc	SysTemp2_H,W
	banksel	GLCDPRINTLOC_H
	movwf	GLCDPRINTLOC_H
;next
	banksel	SYSCHARSHANDLER
	movf	SysCHARSHandler,W
	movwf	AFSR0
	movf	SysCHARSHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	subwf	XCHAR,W
	btfss	STATUS, C
	goto	SysForLoop11
ENDIF38
SysForLoopEnd11
	banksel	STATUS
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:STRING:
GLCDPRINT5
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
ENDIF5
;GLCDPrintLoc = PrintLocX
	banksel	PRINTLOCX
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
ENDIF6
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
	pagesel	GLCDDRAWCHAR_ILI9326
	call	GLCDDRAWCHAR_ILI9326
	pagesel	$
;GLCDPrintIncrementPixelPositionMacro
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize )+1
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
	movlw	1
	addwf	SysTemp2,W
	banksel	GLCDPRINTLOC
	movwf	GLCDPRINTLOC
	movlw	0
	banksel	SYSTEMP2_H
	addwfc	SysTemp2_H,W
	banksel	GLCDPRINTLOC_H
	movwf	GLCDPRINTLOC_H
;Next
	movf	GLCDPRINTLEN,W
	subwf	GLCDPRINT_STRING_COUNTER,W
	btfss	STATUS, C
	goto	SysForLoop1
ENDIF7
SysForLoopEnd1
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:LONG:
GLCDPRINT7
;Dim SysCalcTempA As Long
;Dim GLCDPrintLoc as word
;Dim SysPrintBuffer(10)
;SysPrintBuffLen = 0
	banksel	SYSPRINTBUFFLEN
	clrf	SYSPRINTBUFFLEN
;Do
SysDoLoop_S3
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
	goto	SysDoLoop_S3
SysDoLoop_E3
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
	goto	SysForLoopEnd2
ENDIF8
SysForLoop2
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
	pagesel	GLCDDRAWCHAR_ILI9326
	call	GLCDDRAWCHAR_ILI9326
	pagesel	$
;GLCDPrintIncrementPixelPositionMacro
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize )+1
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
	movlw	1
	addwf	SysTemp2,W
	banksel	GLCDPRINTLOC
	movwf	GLCDPRINTLOC
	movlw	0
	banksel	SYSTEMP2_H
	addwfc	SysTemp2_H,W
	banksel	GLCDPRINTLOC_H
	movwf	GLCDPRINTLOC_H
;Next
	movf	GLCDPRINT_STRING_COUNTER,W
	sublw	1
	btfss	STATUS, C
	goto	SysForLoop2
ENDIF9
SysForLoopEnd2
	banksel	STATUS
	return

;********************************************************************************

GLCDROTATE_ILI9326
;Dim ILI9326_GLCD_WIDTH, ILI9326_GLCD_HEIGHT as word
;Dim ILI9326_GLCD_WIDTH_ADJ, ILI9326_GLCD_HEIGHT_ADJ as word
;Select case ILI9326_AddressType
;Case PORTRAIT
SysSelect4Case1
	movlw	4
	subwf	ILI9326_ADDRESSTYPE,W
	btfss	STATUS, Z
	goto	SysSelect4Case2
;ILI9326_GLCD_WIDTH = GLCD_WIDTH
	movlw	240
	movwf	GLCDDEVICEWIDTH
	clrf	GLCDDEVICEWIDTH_H
;ILI9326_GLCD_HEIGHT = GLCD_HEIGHT
	movlw	144
	movwf	GLCDDEVICEHEIGHT
	movlw	1
	movwf	GLCDDEVICEHEIGHT_H
;ILI9326_GLCD_WIDTH_ADJ = 0
	clrf	ILI9326_GLCD_WIDTH_ADJ
	clrf	ILI9326_GLCD_WIDTH_ADJ_H
;ILI9326_GLCD_HEIGHT_ADJ = GLCD_HEIGHT - 1
	movlw	143
	movwf	ILI9326_GLCD_HEIGHT_ADJ
	movlw	1
	movwf	ILI9326_GLCD_HEIGHT_ADJ_H
;Change to RGB TFT color and standard orientation
;SendCommand_ILI9326(ILI9326_ENTRY_MODE)
	movlw	3
	movwf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326( ILI9326_ENTRY_MODE_BGR )
	clrf	ILI9326_SENDWORD
	movlw	16
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;Case Landscape
	goto	SysSelectEnd4
SysSelect4Case2
	decf	ILI9326_ADDRESSTYPE,W
	btfss	STATUS, Z
	goto	SysSelect4Case3
;ILI9326_GLCD_WIDTH = GLCD_HEIGHT
	movlw	144
	movwf	GLCDDEVICEWIDTH
	movlw	1
	movwf	GLCDDEVICEWIDTH_H
;ILI9326_GLCD_HEIGHT = GLCD_WIDTH
	movlw	240
	movwf	GLCDDEVICEHEIGHT
	clrf	GLCDDEVICEHEIGHT_H
;ILI9326_GLCD_WIDTH_ADJ = GLCD_HEIGHT - 1
	movlw	143
	movwf	ILI9326_GLCD_WIDTH_ADJ
	movlw	1
	movwf	ILI9326_GLCD_WIDTH_ADJ_H
;ILI9326_GLCD_HEIGHT_ADJ = GLCD_WIDTH - 1
	movlw	239
	movwf	ILI9326_GLCD_HEIGHT_ADJ
	clrf	ILI9326_GLCD_HEIGHT_ADJ_H
;SendCommand_ILI9326(ILI9326_ENTRY_MODE)
	movlw	3
	movwf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326( ILI9326_ENTRY_MODE_BGR | ILI9326_ENTRY_MODE_ID1 | ILI9326_ENTRY_MODE_AM )
	movlw	40
	movwf	ILI9326_SENDWORD
	movlw	16
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;Case Portrait_Rev
	goto	SysSelectEnd4
SysSelect4Case3
	movlw	2
	subwf	ILI9326_ADDRESSTYPE,W
	btfss	STATUS, Z
	goto	SysSelect4Case4
;ILI9326_GLCD_WIDTH = GLCD_WIDTH
	movlw	240
	movwf	GLCDDEVICEWIDTH
	clrf	GLCDDEVICEWIDTH_H
;ILI9326_GLCD_HEIGHT = GLCD_HEIGHT
	movlw	144
	movwf	GLCDDEVICEHEIGHT
	movlw	1
	movwf	GLCDDEVICEHEIGHT_H
;ILI9326_GLCD_WIDTH_ADJ = GLCD_WIDTH - 1
	movlw	239
	movwf	ILI9326_GLCD_WIDTH_ADJ
	clrf	ILI9326_GLCD_WIDTH_ADJ_H
;ILI9326_GLCD_HEIGHT_ADJ = 0
	clrf	ILI9326_GLCD_HEIGHT_ADJ
	clrf	ILI9326_GLCD_HEIGHT_ADJ_H
;SendCommand_ILI9326(ILI9326_ENTRY_MODE)
	movlw	3
	movwf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326( ILI9326_ENTRY_MODE_BGR | ILI9326_ENTRY_MODE_ID1 )
	movlw	32
	movwf	ILI9326_SENDWORD
	movlw	16
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;Case Landscape_Rev
	goto	SysSelectEnd4
SysSelect4Case4
	movlw	3
	subwf	ILI9326_ADDRESSTYPE,W
	btfss	STATUS, Z
	goto	SysSelect4Case5
;ILI9326_GLCD_WIDTH = GLCD_HEIGHT
	movlw	144
	movwf	GLCDDEVICEWIDTH
	movlw	1
	movwf	GLCDDEVICEWIDTH_H
;ILI9326_GLCD_HEIGHT = GLCD_WIDTH
	movlw	240
	movwf	GLCDDEVICEHEIGHT
	clrf	GLCDDEVICEHEIGHT_H
;ILI9326_GLCD_WIDTH_ADJ = 0
	clrf	ILI9326_GLCD_WIDTH_ADJ
	clrf	ILI9326_GLCD_WIDTH_ADJ_H
;ILI9326_GLCD_HEIGHT_ADJ = 0
	clrf	ILI9326_GLCD_HEIGHT_ADJ
	clrf	ILI9326_GLCD_HEIGHT_ADJ_H
;SendCommand_ILI9326(ILI9326_ENTRY_MODE)
	movlw	3
	movwf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326( ILI9326_ENTRY_MODE_BGR | ILI9326_ENTRY_MODE_ID0 | ILI9326_ENTRY_MODE_ID1 | ILI9326_ENTRY_MODE_AM )
	movlw	56
	movwf	ILI9326_SENDWORD
	movlw	16
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;Case Else
	goto	SysSelectEnd4
SysSelect4Case5
;ILI9326_GLCD_WIDTH = GLCD_WIDTH
	movlw	240
	movwf	GLCDDEVICEWIDTH
	clrf	GLCDDEVICEWIDTH_H
;ILI9326_GLCD_HEIGHT = GLCD_HEIGHT
	movlw	144
	movwf	GLCDDEVICEHEIGHT
	movlw	1
	movwf	GLCDDEVICEHEIGHT_H
;ILI9326_GLCD_WIDTH_ADJ = 0
	clrf	ILI9326_GLCD_WIDTH_ADJ
	clrf	ILI9326_GLCD_WIDTH_ADJ_H
;ILI9326_GLCD_HEIGHT_ADJ = GLCD_HEIGHT - 1
	movlw	143
	movwf	ILI9326_GLCD_HEIGHT_ADJ
	movlw	1
	movwf	ILI9326_GLCD_HEIGHT_ADJ_H
;Change to RGB TFT color and standard orientation
;SendCommand_ILI9326(ILI9326_ENTRY_MODE)
	movlw	3
	movwf	ILI9326_SENDWORD
	clrf	ILI9326_SENDWORD_H
	call	SENDCOMMAND_ILI9326
;SendData_ili9326( ILI9326_ENTRY_MODE_BGR )
	clrf	ILI9326_SENDWORD
	movlw	16
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;End Select
SysSelectEnd4
	return

;********************************************************************************

FN_PAD
;Check length of SysInString
;If SysInString(0) = longer or equal SysStrLen then
;give back SysInString and exit function
;If SysInString(0) < SysStrLen Then
	banksel	SYSSYSINSTRINGHANDLER
	movf	SysSYSINSTRINGHandler,W
	movwf	AFSR0
	movf	SysSYSINSTRINGHandler_H,W
	movwf	AFSR0_H
	movf	SYSSTRLEN,W
	subwf	INDF0,W
	btfsc	STATUS, C
	goto	ELSE56_1
;SysCharCount = SysInString(0)
	movf	SysSYSINSTRINGHandler,W
	movwf	AFSR0
	movf	SysSYSINSTRINGHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SYSCHARCOUNT
;clear output string
;Pad=""
	movlw	low PAD
	movwf	FSR1L
	movlw	high PAD
	movwf	FSR1H
	movlw	low StringTable71
	movwf	SysStringA
	movlw	(high StringTable71) & 127
	movwf	SysStringA_H
	banksel	STATUS
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
;Copy leftmost characters
;For SysStringTemp = 1 To SysCharCount
	banksel	SYSSTRINGTEMP
	clrf	SYSSTRINGTEMP
	movlw	1
	subwf	SYSCHARCOUNT,W
	btfss	STATUS, C
	goto	SysForLoopEnd12
ENDIF57
SysForLoop12
	incf	SYSSTRINGTEMP,F
;Pad(SysStringTemp) = SysInString(SysStringTemp)
	movf	SYSSTRINGTEMP,W
	addwf	SysSYSINSTRINGHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysSYSINSTRINGHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SysArrayTemp1
	movwf	SysArrayTemp2
	movlw	low(PAD)
	addwf	SYSSTRINGTEMP,W
	movwf	AFSR0
	clrf	SysTemp1
	movlw	high(PAD)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movf	SysArrayTemp2,W
	movwf	INDF0
;Next
	movf	SYSCHARCOUNT,W
	subwf	SYSSTRINGTEMP,W
	btfss	STATUS, C
	goto	SysForLoop12
ENDIF58
SysForLoopEnd12
;For SysStringTemp = SysCharCount+1 to SysStrLen
	incf	SYSCHARCOUNT,W
	movwf	SysTemp1
	decf	SysTemp1,W
	movwf	SYSSTRINGTEMP
	incf	SYSCHARCOUNT,W
	movwf	SysTemp1
	movwf	SysBYTETempB
	movf	SYSSTRLEN,W
	movwf	SysBYTETempA
	banksel	STATUS
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd13
ENDIF59
SysForLoop13
	banksel	SYSSTRINGTEMP
	incf	SYSSTRINGTEMP,F
;Pad(SysStringTemp) = SysInString3(1)
	movlw	1
	addwf	SysSYSINSTRING3Handler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysSYSINSTRING3Handler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SysArrayTemp2
	movwf	SysArrayTemp1
	movlw	low(PAD)
	addwf	SYSSTRINGTEMP,W
	movwf	AFSR0
	clrf	SysTemp1
	movlw	high(PAD)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movf	SysArrayTemp1,W
	movwf	INDF0
;Next
	movf	SYSSTRLEN,W
	subwf	SYSSTRINGTEMP,W
	btfss	STATUS, C
	goto	SysForLoop13
ENDIF60
SysForLoopEnd13
;set new length to PAD
;Pad(0) = SysStrLen
	banksel	SYSSTRLEN
	movf	SYSSTRLEN,W
	banksel	SYSPAD_0
	movwf	SYSPAD_0
;else
	goto	ENDIF56
ELSE56_1
;SysInString is equal or longer than SysStrLen
;give back old string; copy SysInString to Pad
;For SysStringTemp = 1 To SysInString(0)
	clrf	SYSSTRINGTEMP
	movf	SysSYSINSTRINGHandler,W
	movwf	AFSR0
	movf	SysSYSINSTRINGHandler_H,W
	movwf	AFSR0_H
	movlw	1
	subwf	INDF0,W
	btfss	STATUS, C
	goto	SysForLoopEnd14
ENDIF61
SysForLoop14
	incf	SYSSTRINGTEMP,F
;Pad(SysStringTemp) = SysInString(SysStringTemp)
	movf	SYSSTRINGTEMP,W
	addwf	SysSYSINSTRINGHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysSYSINSTRINGHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SysArrayTemp1
	movwf	SysArrayTemp2
	movlw	low(PAD)
	addwf	SYSSTRINGTEMP,W
	movwf	AFSR0
	clrf	SysTemp1
	movlw	high(PAD)
	addwfc	SysTemp1,W
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
	goto	SysForLoop14
ENDIF62
SysForLoopEnd14
;PAD(0) = SysInString(0)
	movf	SysSYSINSTRINGHandler,W
	movwf	AFSR0
	movf	SysSYSINSTRINGHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	SysArrayTemp1
	banksel	SYSPAD_0
	movwf	SYSPAD_0
;End If
ENDIF56
	banksel	STATUS
	return

;********************************************************************************

PSET_ILI9326
;Dim ILI9326_GLCD_WIDTH_ADJ, ILI9326_GLCD_HEIGHT_ADJ as word
;Dim ILI9326_AddressType as byte
;sendCommand_ili9326(ILI9326_GRAM_ADDR_H_SET)
	clrf	ILI9326_SENDWORD
	movlw	2
	movwf	ILI9326_SENDWORD_H
	call	SENDCOMMAND_ILI9326
;select case ILI9326_AddressType
;case Portrait
SysSelect2Case1
	movlw	4
	subwf	ILI9326_ADDRESSTYPE,W
	btfss	STATUS, Z
	goto	SysSelect2Case2
;sendData_ili9326( GLCDX )
	movf	GLCDX,W
	movwf	ILI9326_SENDWORD
	movf	GLCDX_H,W
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
	movf	ILI9326_SENDWORD,W
	movwf	GLCDX
	movf	ILI9326_SENDWORD_H,W
	movwf	GLCDX_H
;case Portrait_Rev
	goto	SysSelectEnd2
SysSelect2Case2
	movlw	2
	subwf	ILI9326_ADDRESSTYPE,W
	btfss	STATUS, Z
	goto	SysSelect2Case3
;sendData_ili9326( ILI9326_GLCD_WIDTH_ADJ - GLCDX )
	movf	GLCDX,W
	subwf	ILI9326_GLCD_WIDTH_ADJ,W
	movwf	ILI9326_SENDWORD
	movf	GLCDX_H,W
	subwfb	ILI9326_GLCD_WIDTH_ADJ_H,W
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;case Landscape
	goto	SysSelectEnd2
SysSelect2Case3
	decf	ILI9326_ADDRESSTYPE,W
	btfss	STATUS, Z
	goto	SysSelect2Case4
;sendData_ili9326( ILI9326_GLCD_HEIGHT_ADJ - GLCDY )
	movf	GLCDY,W
	subwf	ILI9326_GLCD_HEIGHT_ADJ,W
	movwf	ILI9326_SENDWORD
	movf	GLCDY_H,W
	subwfb	ILI9326_GLCD_HEIGHT_ADJ_H,W
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;case Landscape_Rev
	goto	SysSelectEnd2
SysSelect2Case4
	movlw	3
	subwf	ILI9326_ADDRESSTYPE,W
	btfss	STATUS, Z
	goto	SysSelectEnd2
;sendData_ili9326( GLCDY )
	movf	GLCDY,W
	movwf	ILI9326_SENDWORD
	movf	GLCDY_H,W
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
	movf	ILI9326_SENDWORD,W
	movwf	GLCDY
	movf	ILI9326_SENDWORD_H,W
	movwf	GLCDY_H
;end select
SysSelectEnd2
;sendCommand_ili9326(ILI9326_GRAM_ADDR_V_SET)
	movlw	1
	movwf	ILI9326_SENDWORD
	movlw	2
	movwf	ILI9326_SENDWORD_H
	call	SENDCOMMAND_ILI9326
;select case ILI9326_AddressType
;case Portrait
SysSelect3Case1
	movlw	4
	subwf	ILI9326_ADDRESSTYPE,W
	btfss	STATUS, Z
	goto	SysSelect3Case2
;sendData_ili9326( ILI9326_GLCD_HEIGHT_ADJ - GLCDY )
	movf	GLCDY,W
	subwf	ILI9326_GLCD_HEIGHT_ADJ,W
	movwf	ILI9326_SENDWORD
	movf	GLCDY_H,W
	subwfb	ILI9326_GLCD_HEIGHT_ADJ_H,W
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;case Portrait_Rev
	goto	SysSelectEnd3
SysSelect3Case2
	movlw	2
	subwf	ILI9326_ADDRESSTYPE,W
	btfss	STATUS, Z
	goto	SysSelect3Case3
;sendData_ili9326( GLCDY )
	movf	GLCDY,W
	movwf	ILI9326_SENDWORD
	movf	GLCDY_H,W
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
	movf	ILI9326_SENDWORD,W
	movwf	GLCDY
	movf	ILI9326_SENDWORD_H,W
	movwf	GLCDY_H
;case Landscape
	goto	SysSelectEnd3
SysSelect3Case3
	decf	ILI9326_ADDRESSTYPE,W
	btfss	STATUS, Z
	goto	SysSelect3Case4
;sendData_ili9326( ILI9326_GLCD_WIDTH_ADJ - GLCDX )
	movf	GLCDX,W
	subwf	ILI9326_GLCD_WIDTH_ADJ,W
	movwf	ILI9326_SENDWORD
	movf	GLCDX_H,W
	subwfb	ILI9326_GLCD_WIDTH_ADJ_H,W
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
;case Landscape_Rev
	goto	SysSelectEnd3
SysSelect3Case4
	movlw	3
	subwf	ILI9326_ADDRESSTYPE,W
	btfss	STATUS, Z
	goto	SysSelectEnd3
;sendData_ili9326( GLCDX )
	movf	GLCDX,W
	movwf	ILI9326_SENDWORD
	movf	GLCDX_H,W
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
	movf	ILI9326_SENDWORD,W
	movwf	GLCDX
	movf	ILI9326_SENDWORD_H,W
	movwf	GLCDX_H
;end select
SysSelectEnd3
;sendCommand_ili9326(ILI9326_GRAM_WR_DATA)
	movlw	2
	movwf	ILI9326_SENDWORD
	movwf	ILI9326_SENDWORD_H
	call	SENDCOMMAND_ILI9326
;sendData_ili9326( GLCDColour )
	movf	GLCDCOLOUR,W
	movwf	ILI9326_SENDWORD
	movf	GLCDCOLOUR_H,W
	movwf	ILI9326_SENDWORD_H
	pagesel	SENDDATA_ILI9326
	call	SENDDATA_ILI9326
	pagesel	$
	movf	ILI9326_SENDWORD,W
	movwf	GLCDCOLOUR
	movf	ILI9326_SENDWORD_H,W
	movwf	GLCDCOLOUR_H
	return

;********************************************************************************

SENDCOMMAND_ILI9326
;set ILI9326_GLCD_CS OFF
	banksel	LATA
	bcf	LATA,0
;set ILI9326_GLCD_RS OFF
	bcf	LATA,1
;set ILI9326_GLCD_RD ON
	bsf	LATA,3
;set ILI9326_GLCD_WR ON
	bsf	LATA,2
;ILI9326_DataPort = ILI9326_SENDWORD_h
	banksel	ILI9326_SENDWORD_H
	movf	ILI9326_SENDWORD_H,W
	movwf	PORTD
;set ILI9326_GLCD_WR OFF
	banksel	LATA
	bcf	LATA,2
;set ILI9326_GLCD_WR ON
	bsf	LATA,2
;ILI9326_DataPort = ILI9326_SENDWORD
	banksel	ILI9326_SENDWORD
	movf	ILI9326_SENDWORD,W
	movwf	PORTD
;set ILI9326_GLCD_WR OFF
	banksel	LATA
	bcf	LATA,2
;set ILI9326_GLCD_WR ON
	bsf	LATA,2
	banksel	STATUS
	return

;********************************************************************************

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
	goto	ENDIF52
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
	call	SysDivSub16
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
ENDIF52
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
	goto	ENDIF53
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
	call	SysDivSub16
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
ENDIF53
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
	goto	ENDIF54
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
	call	SysDivSub16
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
ENDIF54
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
	goto	ENDIF55
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
	call	SysDivSub16
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
ENDIF55
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

SYSCOMPLESSTHANINT
;Dim SysIntegerTempA, SysIntegerTempB, SysDivMultA as Integer
;Clear result
;SysByteTempX = 0
	clrf	SYSBYTETEMPX
;Compare sign bits
;-A
;If SysIntegerTempA.15 = On Then
	btfss	SYSINTEGERTEMPA_H,7
	goto	ELSE49_1
;-A, +B, return true
;If SysIntegerTempB.15 = Off Then
	btfsc	SYSINTEGERTEMPB_H,7
	goto	ENDIF50
;Set SysByteTempX to 255
;SysByteTempX = Not SysByteTempX
	comf	SYSBYTETEMPX,F
;Exit Sub
	return
;End If
ENDIF50
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
	goto	ENDIF49
ELSE49_1
;+A, -B, return false
;If SysIntegerTempB.15 = On Then
	btfsc	SYSINTEGERTEMPB_H,7
;Exit Sub
	return
;End If
ENDIF51
;End If
ENDIF49
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
	goto	ENDIF42
;SysWordTempA = 0
	clrf	SYSWORDTEMPA
	clrf	SYSWORDTEMPA_H
;exit sub
	return
;end if
ENDIF42
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
	goto	ENDIF43
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	addwfc	SYSDIVMULTX_H,F
;End If
ENDIF43
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
	pagesel	SysCompEqual32
	call	SysCompEqual32
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF47
;SysLongTempA = 0
	clrf	SYSLONGTEMPA
	clrf	SYSLONGTEMPA_H
	clrf	SYSLONGTEMPA_U
	clrf	SYSLONGTEMPA_E
;exit sub
	return
;end if
ENDIF47
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
	goto	ENDIF48
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
ENDIF48
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

;Start of program memory page 3
	ORG	6144
SENDDATA_ILI9326
;set ILI9326_GLCD_RS ON
	banksel	LATA
	bsf	LATA,1
;ILI9326_DataPort=ILI9326_SENDWORD_h
	banksel	ILI9326_SENDWORD_H
	movf	ILI9326_SENDWORD_H,W
	movwf	PORTD
;set ILI9326_GLCD_WR OFF
	banksel	LATA
	bcf	LATA,2
;set ILI9326_GLCD_WR ON
	bsf	LATA,2
;ILI9326_DataPort=ILI9326_SENDWORD
	banksel	ILI9326_SENDWORD
	movf	ILI9326_SENDWORD,W
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
	goto	ENDIF44
	comf	SYSINTEGERTEMPA,F
	comf	SYSINTEGERTEMPA_H,F
	incf	SYSINTEGERTEMPA,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPA_H,F
ENDIF44
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
	btfss	SYSINTEGERTEMPB_H,7
	goto	ENDIF45
	comf	SYSINTEGERTEMPB,F
	comf	SYSINTEGERTEMPB_H,F
	incf	SYSINTEGERTEMPB,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPB_H,F
ENDIF45
;Call word divide routine
;SysDivSub16
	pagesel	SYSDIVSUB16
	call	SYSDIVSUB16
	pagesel	$
;Negate result if necessary
;If SysSignByte.7 Then
	btfss	SYSSIGNBYTE,7
	goto	ENDIF46
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
ENDIF46
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
	goto	ENDIF63
	movf	SYSDIVMULTA,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTA_H,W
	addwfc	SYSDIVMULTX_H,F
ENDIF63
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
ENDIF64
;SysWordTempX = SysDivMultX
	movf	SYSDIVMULTX,W
	movwf	SYSWORDTEMPX
	movf	SYSDIVMULTX_H,W
	movwf	SYSWORDTEMPX_H
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

;Start of program memory page 4
	ORG	8192
;Start of program memory page 5
	ORG	10240
;Start of program memory page 6
	ORG	12288
;Start of program memory page 7
	ORG	14336

 END
