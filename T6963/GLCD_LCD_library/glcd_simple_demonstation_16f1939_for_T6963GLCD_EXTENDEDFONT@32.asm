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
BYTENUMBER	EQU	34
CCOUNT	EQU	35
CHARCODE	EQU	36
CHARCOL	EQU	37
CHARCOLS	EQU	39
CHARCOL_H	EQU	38
CHARLOCX	EQU	40
CHARLOCX_H	EQU	41
CHARLOCY	EQU	42
CHARLOCY_H	EQU	43
CHARROW	EQU	44
CHARROWS	EQU	46
CHARROW_H	EQU	45
CHR	EQU	9159
CMD	EQU	47
COL	EQU	48
COLOR	EQU	49
COLOR_H	EQU	50
COL_T6963	EQU	51
COL_T6963_H	EQU	52
CURRCHARCOL	EQU	53
CURRCHARROW	EQU	54
CURRCHARVAL	EQU	55
CURRCOL	EQU	56
CURRCOL_H	EQU	57
DDF_X	EQU	58
DDF_X_H	EQU	59
DDF_Y	EQU	60
DDF_Y_H	EQU	61
DEFAULTDISPLAYMODESTATE_T6963	EQU	62
DELAYTEMP	EQU	112
DELAYTEMP2	EQU	113
DRAWLINE	EQU	63
DRAWLINE_H	EQU	64
FF	EQU	65
FF_H	EQU	66
FILLCIRCLEXX	EQU	67
FILLCIRCLEYY	EQU	68
GLCDBACKGROUND	EQU	69
GLCDBACKGROUND_H	EQU	70
GLCDCOLOUR	EQU	71
GLCDCOLOUR_H	EQU	72
GLCDDEVICEHEIGHT	EQU	73
GLCDDEVICEHEIGHT_H	EQU	74
GLCDDEVICEWIDTH	EQU	75
GLCDDEVICEWIDTH_H	EQU	76
GLCDFNTDEFAULT	EQU	77
GLCDFNTDEFAULTSIZE	EQU	78
GLCDFONTWIDTH	EQU	79
GLCDFOREGROUND	EQU	80
GLCDFOREGROUND_H	EQU	81
GLCDPRINTLEN	EQU	82
GLCDPRINTLOC	EQU	83
GLCDPRINTLOC_H	EQU	84
GLCDPRINT_STRING_COUNTER	EQU	85
GLCDROTATESTATE	EQU	86
GLCDTEMP	EQU	87
GLCDTEMP_H	EQU	88
GLCDX	EQU	89
GLCDX_H	EQU	90
GLCDY	EQU	91
GLCDY_H	EQU	92
GLCD_YORDINATE	EQU	93
GLCD_YORDINATE_H	EQU	94
HEX	EQU	9039
HIGHCHAR	EQU	95
INXRADIUS	EQU	96
INXRADIUS_H	EQU	97
LCDBYTE	EQU	98
LCDCHAR	EQU	99
LCDCMDBYTE	EQU	100
LCDCOLUMN	EQU	101
LCDCRSR	EQU	102
LCDDATABYTE	EQU	103
LCDDATAWORD	EQU	104
LCDDATAWORD_H	EQU	105
LCDLINE	EQU	106
LCDPUTCOLUMN	EQU	107
LCDPUTLINE	EQU	108
LCDVALUE	EQU	160
LCDVALUE_E	EQU	163
LCDVALUE_H	EQU	161
LCDVALUE_U	EQU	162
LCD_STATE	EQU	109
LINECOLOUR	EQU	110
LINECOLOUR_H	EQU	111
LINEDIFFX	EQU	164
LINEDIFFX_H	EQU	165
LINEDIFFX_X2	EQU	166
LINEDIFFX_X2_H	EQU	167
LINEDIFFY	EQU	168
LINEDIFFY_H	EQU	169
LINEDIFFY_X2	EQU	170
LINEDIFFY_X2_H	EQU	171
LINEERR	EQU	172
LINEERR_H	EQU	173
LINESTEPX	EQU	174
LINESTEPX_H	EQU	175
LINESTEPY	EQU	176
LINESTEPY_H	EQU	177
LINEX1	EQU	178
LINEX1_H	EQU	179
LINEX2	EQU	180
LINEX2_H	EQU	181
LINEY1	EQU	182
LINEY1_H	EQU	183
LINEY2	EQU	184
LINEY2_H	EQU	185
LINE_X_CURSOR	EQU	186
LOCX	EQU	187
LOCX_H	EQU	188
LOCY	EQU	189
LOCY_H	EQU	190
LONGNUMBER	EQU	191
LONGNUMBER_E	EQU	194
LONGNUMBER_H	EQU	192
LONGNUMBER_U	EQU	193
LOWCHAR	EQU	195
OUTSTRING	EQU	9118
PAD	EQU	9077
PRINTLEN	EQU	196
PRINTLOCX	EQU	197
PRINTLOCX_H	EQU	198
PRINTLOCY	EQU	199
PRINTLOCY_H	EQU	200
RADIUSERR	EQU	201
RADIUSERR_H	EQU	202
ROW	EQU	203
ROW_T6963	EQU	204
ROW_T6963_H	EQU	205
STR	EQU	9043
STRINGLOCX	EQU	206
STRINGPOINTER	EQU	207
SYSARRAYTEMP1	EQU	208
SYSARRAYTEMP2	EQU	209
SYSBYTETEMPA	EQU	117
SYSBYTETEMPB	EQU	121
SYSBYTETEMPX	EQU	112
SYSCALCTEMPA	EQU	117
SYSCALCTEMPA_E	EQU	120
SYSCALCTEMPA_H	EQU	118
SYSCALCTEMPA_U	EQU	119
SYSCALCTEMPX	EQU	112
SYSCALCTEMPX_H	EQU	113
SYSCHAR	EQU	210
SYSCHARCOUNT	EQU	211
SYSCHARSHANDLER	EQU	212
SYSCHARSHANDLER_H	EQU	213
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
SYSLCDPRINTDATAHANDLER	EQU	214
SYSLCDPRINTDATAHANDLER_H	EQU	215
SYSLCDTEMP	EQU	216
SYSLONGDIVMULTA	EQU	217
SYSLONGDIVMULTA_E	EQU	220
SYSLONGDIVMULTA_H	EQU	218
SYSLONGDIVMULTA_U	EQU	219
SYSLONGDIVMULTB	EQU	221
SYSLONGDIVMULTB_E	EQU	224
SYSLONGDIVMULTB_H	EQU	222
SYSLONGDIVMULTB_U	EQU	223
SYSLONGDIVMULTX	EQU	225
SYSLONGDIVMULTX_E	EQU	228
SYSLONGDIVMULTX_H	EQU	226
SYSLONGDIVMULTX_U	EQU	227
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
SYSPRINTBUFFER	EQU	9049
SYSPRINTBUFFLEN	EQU	229
SYSPRINTDATAHANDLER	EQU	230
SYSPRINTDATAHANDLER_H	EQU	231
SYSPRINTTEMP	EQU	232
SYSREPEATTEMP1	EQU	233
SYSREPEATTEMP2	EQU	234
SYSSIGNBYTE	EQU	125
SYSSTRDATA	EQU	235
SYSSTRINGA	EQU	119
SYSSTRINGA_H	EQU	120
SYSSTRINGLENGTH	EQU	118
SYSSTRINGPARAM1	EQU	9060
SYSSTRINGTEMP	EQU	236
SYSSTRLEN	EQU	237
SYSSYSINSTRING3HANDLER	EQU	238
SYSSYSINSTRING3HANDLER_H	EQU	239
SYSSYSINSTRINGHANDLER	EQU	288
SYSSYSINSTRINGHANDLER_H	EQU	289
SYSTEMP1	EQU	290
SYSTEMP1_E	EQU	293
SYSTEMP1_H	EQU	291
SYSTEMP1_U	EQU	292
SYSTEMP2	EQU	294
SYSTEMP2_H	EQU	295
SYSTEMP3	EQU	296
SYSTEMP3_H	EQU	297
SYSVALTEMP	EQU	298
SYSVALTEMP_H	EQU	299
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
WORDNUMBER	EQU	300
WORDNUMBER_H	EQU	301
XCHAR	EQU	302
XOFFSET	EQU	303
XOFFSET_H	EQU	304
XPOSITION	EQU	305
XRADIUS	EQU	306
XRADIUS_H	EQU	307
YCALC1	EQU	308
YCALC1_H	EQU	309
YCALC2	EQU	310
YCALC2_H	EQU	311
YOFFSET	EQU	312
YOFFSET_H	EQU	313
YORDINATE	EQU	314
YPOSITION	EQU	315

;********************************************************************************

;Alias variables
AFSR0	EQU	4
AFSR0_H	EQU	5
SYSCHR_0	EQU	1575
SYSCHR_1	EQU	1576
SYSHEX_0	EQU	1359
SYSHEX_1	EQU	1360
SYSHEX_2	EQU	1361
SYSPAD_0	EQU	1445
SYSSTR_0	EQU	1363

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
	call	INITGLCD_ILI9486L
	call	INITGLCD_T6963
	pagesel	$
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
;#define GLCD_TYPE GLCD_TYPE_T6963_64
;#define GLCD_EXTENDEDFONTSET1
;***********************************************************************************************
;define the connectivity - the ports
;#define GLCD_DATA_PORT PORTD             'Library only support contigous 8-bit port
;#define GLCD_CS        PORTa.7           'Chip Enable (Active Low)
;#define GLCD_CD        PORTa.0           'Command or Data conrol line port
;#define GLCD_RD        PORTA.1           'Read control line  port
;#define GLCD_WR        PORTA.2           'Write control line port
;#define GLCD_RESET     PORTA.3           'Reset port
;#define GLCD_FS        PORTA.5           'FS port
;#define GLCD_FS_SELECT 1                 'FS1 Font Select port. 6x8 font: FS1=“High”=1 8x8 font FS1=“Low”=0 for GLCD_FS_SELECT
;***********************************************************************************************
;*
;* Note    :   The T6963 controller's RAM address space from $0000 - $7FFF, total 32kbyte RAM, or it could be 64kbyte RAM best check!!
;*
;***********************************************************************************************
;#define TEXT_HOME_ADDR      0x0000                                                         'This is specific to the GLCD display
;#define GRH_HOME_ADDR       0x3FFF                                                         'This is specific to the GLCD display
;#define CG_HOME_ADDR        0x77FF                                                         'This is specific to the GLCD display
;#define COLUMN              40    'Set column number to be 40 , 32, 30 etc.                 This is specific to the GLCD display
;#define MAX_ROW_PIXEL       64    'MAX_ROW_PIXEL the physical matrix length (y direction)   This is specific to the GLCD display
;#define MAX_COL_PIXEL       240   'MAX_COL_PIXEL the physical matrix width (x direction)    This is specific to the GLCD display
;***********************************************************************************************
;* End of configuration
;***********************************************************************************************
;Start of demonstration main program
;goto GLCDTest
	goto	GLCDTEST
;do Forever
SysDoLoop_S1
;BigPrint ( 0, 0, "WG24064A-TMI-TZ#")
	banksel	PRINTLOCX
	clrf	PRINTLOCX
	clrf	PRINTLOCX_H
	clrf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable1
	movwf	SysStringA
	movlw	(high StringTable1) & 127
	movwf	SysStringA_H
	banksel	STATUS
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	movwf	COLOR
	movf	GLCDFOREGROUND_H,W
	movwf	COLOR_H
	pagesel	BIGPRINT_ILI9486L
	call	BIGPRINT_ILI9486L
	pagesel	$
;BigPrint ( 0, 20, "Feb 2019")
	banksel	PRINTLOCX
	clrf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	20
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable2
	movwf	SysStringA
	movlw	(high StringTable2) & 127
	movwf	SysStringA_H
	banksel	STATUS
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	movwf	COLOR
	movf	GLCDFOREGROUND_H,W
	movwf	COLOR_H
	pagesel	BIGPRINT_ILI9486L
	call	BIGPRINT_ILI9486L
	pagesel	$
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
;CLS
	pagesel	CLS_T6963
	call	CLS_T6963
	pagesel	$
;locate 5, 3
	movlw	5
	movwf	LCDLINE
	movlw	3
	movwf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;Print "40cols x 8rows character mode"
	movlw	low StringTable3
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable3) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	call	PRINT431
;locate 6, 3
	movlw	6
	movwf	LCDLINE
	movlw	3
	movwf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;Print "Mixed mode LCD and GLCD!!"
	movlw	low StringTable4
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable4) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	call	PRINT431
;locate 7, 32
	movlw	7
	movwf	LCDLINE
	movlw	32
	movwf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;Print "Anobium"
	movlw	low StringTable5
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable5) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	call	PRINT431
;wait 4 s
	movlw	4
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
;cls
	pagesel	CLS_T6963
	call	CLS_T6963
	pagesel	$
;GLCDCLS
	pagesel	GLCDCLS_T6963
	call	GLCDCLS_T6963
	pagesel	$
;BigPrint ( 0, 0, "WG24064A-TMI-TZ#")
	banksel	PRINTLOCX
	clrf	PRINTLOCX
	clrf	PRINTLOCX_H
	clrf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable1
	movwf	SysStringA
	movlw	(high StringTable1) & 127
	movwf	SysStringA_H
	banksel	STATUS
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	movwf	COLOR
	movf	GLCDFOREGROUND_H,W
	movwf	COLOR_H
	pagesel	BIGPRINT_ILI9486L
	call	BIGPRINT_ILI9486L
	pagesel	$
;BigPrint ( 0, 20, "LCD Capability")
	banksel	PRINTLOCX
	clrf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	20
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable6
	movwf	SysStringA
	movlw	(high StringTable6) & 127
	movwf	SysStringA_H
	banksel	STATUS
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	movwf	COLOR
	movf	GLCDFOREGROUND_H,W
	movwf	COLOR_H
	pagesel	BIGPRINT_ILI9486L
	call	BIGPRINT_ILI9486L
	pagesel	$
;wait 4 s
	movlw	4
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
;CLS
	pagesel	CLS_T6963
	call	CLS_T6963
	pagesel	$
;GLCDCLS
	pagesel	GLCDCLS_T6963
	call	GLCDCLS_T6963
	pagesel	$
;----- Main body of program commences here.
;Repeat 1
	movlw	1
	banksel	SYSREPEATTEMP1
	movwf	SysRepeatTemp1
SysRepeatLoop1
;CLS
	banksel	STATUS
	pagesel	CLS_T6963
	call	CLS_T6963
	pagesel	$
;PRINT "START TEST"
	movlw	low StringTable7
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable7) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	call	PRINT431
;locate 1,12
	movlw	1
	movwf	LCDLINE
	movlw	12
	movwf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;PRINT "Version 0x"
	movlw	low StringTable8
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable8) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	call	PRINT431
;LCDHex ( 1, LeadingZeroActive )
	movlw	1
	banksel	LCDVALUE
	movwf	LCDVALUE
	movlw	2
	banksel	LCDCHAR
	movwf	LCDCHAR
	pagesel	LCDHEX_T6963
	call	LCDHEX_T6963
	pagesel	$
;locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;PRINT "DISPLAY ON"
	movlw	low StringTable9
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable9) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	call	PRINT431
;wait 2 s
	movlw	2
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
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;Print "Cursor ON"
	movlw	low StringTable10
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable10) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	call	PRINT431
;Locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;LCDcursor CursorOn
	movlw	2
	movwf	LCDCRSR
	movlw	1
	banksel	LINE_X_CURSOR
	movwf	LINE_X_CURSOR
	banksel	STATUS
	pagesel	LCDCURSOR_T6963
	call	LCDCURSOR_T6963
	pagesel	$
;wait 1 S
	movlw	1
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
	banksel	LINE_X_CURSOR
	movwf	LINE_X_CURSOR
	banksel	STATUS
	pagesel	LCDCURSOR_T6963
	call	LCDCURSOR_T6963
	pagesel	$
;locate 0,0
	clrf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;Print "Cursor OFF"
	movlw	low StringTable11
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable11) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	call	PRINT431
;wait 1 s
	movlw	1
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
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;Print "FLASH ON"
	movlw	low StringTable12
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable12) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	call	PRINT431
;Locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;LCDcursor FLASHON
	movlw	3
	movwf	LCDCRSR
	movlw	1
	banksel	LINE_X_CURSOR
	movwf	LINE_X_CURSOR
	banksel	STATUS
	pagesel	LCDCURSOR_T6963
	call	LCDCURSOR_T6963
	pagesel	$
;wait 1 s
	movlw	1
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
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;Print "FLASH OFF"
	movlw	low StringTable13
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable13) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	call	PRINT431
;LCDCURSOR FLASHOFF
	movlw	252
	movwf	LCDCRSR
	movlw	1
	banksel	LINE_X_CURSOR
	movwf	LINE_X_CURSOR
	banksel	STATUS
	pagesel	LCDCURSOR_T6963
	call	LCDCURSOR_T6963
	pagesel	$
;wait 1 sec
	movlw	1
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;Locate 0,0
	clrf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;Print "CURSR & FLSH ON"
	movlw	low StringTable14
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable14) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	call	PRINT431
;locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;LCDCURSOR CURSORON
	movlw	2
	movwf	LCDCRSR
	movlw	1
	banksel	LINE_X_CURSOR
	movwf	LINE_X_CURSOR
	banksel	STATUS
	pagesel	LCDCURSOR_T6963
	call	LCDCURSOR_T6963
	pagesel	$
;LCDCURSOR FLASHON, 8
	movlw	3
	movwf	LCDCRSR
	movlw	8
	banksel	LINE_X_CURSOR
	movwf	LINE_X_CURSOR
	banksel	STATUS
	pagesel	LCDCURSOR_T6963
	call	LCDCURSOR_T6963
	pagesel	$
;Wait 1 sec
	movlw	1
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;Locate 0,0
	clrf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;Print "CURSR & FLSH OFF"
	movlw	low StringTable15
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable15) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	call	PRINT431
;locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;LCDCURSOR CursorOFF
	movlw	253
	movwf	LCDCRSR
	movlw	1
	banksel	LINE_X_CURSOR
	movwf	LINE_X_CURSOR
	banksel	STATUS
	pagesel	LCDCURSOR_T6963
	call	LCDCURSOR_T6963
	pagesel	$
;LCDCURSOR FLASHOFF
	movlw	252
	movwf	LCDCRSR
	movlw	1
	banksel	LINE_X_CURSOR
	movwf	LINE_X_CURSOR
	banksel	STATUS
	pagesel	LCDCURSOR_T6963
	call	LCDCURSOR_T6963
	pagesel	$
;Wait 1 sec
	movlw	1
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
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;PRINT "Flashing"
	movlw	low StringTable16
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable16) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	call	PRINT431
;Locate 1,4
	movlw	1
	movwf	LCDLINE
	movlw	4
	movwf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;Print "Display"
	movlw	low StringTable17
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable17) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
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
	banksel	SYSREPEATTEMP2
	movwf	SysRepeatTemp2
SysRepeatLoop2
;LCDCURSOR LCDOFF
	movlw	251
	banksel	LCDCRSR
	movwf	LCDCRSR
	movlw	1
	banksel	LINE_X_CURSOR
	movwf	LINE_X_CURSOR
	banksel	STATUS
	pagesel	LCDCURSOR_T6963
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
	banksel	LINE_X_CURSOR
	movwf	LINE_X_CURSOR
	banksel	STATUS
	pagesel	LCDCURSOR_T6963
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
	banksel	SYSREPEATTEMP2
	decfsz	SysRepeatTemp2,F
	goto	SysRepeatLoop2
SysRepeatLoopEnd2
;CLS
	banksel	STATUS
	pagesel	CLS_T6963
	call	CLS_T6963
	pagesel	$
;Locate 0,0
	clrf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;Print "DISPLAY OFF"
	movlw	low StringTable18
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable18) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	call	PRINT431
;Locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;Print "FOR 2 SEC"
	movlw	low StringTable19
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable19) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
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
	banksel	LINE_X_CURSOR
	movwf	LINE_X_CURSOR
	banksel	STATUS
	pagesel	LCDCURSOR_T6963
	call	LCDCURSOR_T6963
	pagesel	$
;WAIT 2 s
	movlw	2
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
;CLS
	pagesel	CLS_T6963
	call	CLS_T6963
	pagesel	$
;Dim Xposition, Yposition as byte
;locate 20, 4
	movlw	20
	movwf	LCDLINE
	movlw	4
	movwf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;Print "Put ( row, column, ascii character )"
	movlw	low StringTable20
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable20) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	call	PRINT431
;for Yposition = 0 to MAX_ROWS -1
	movlw	255
	banksel	YPOSITION
	movwf	YPOSITION
SysForLoop1
	banksel	YPOSITION
	incf	YPOSITION,F
;put Yposition, 0, "*"
	movf	YPOSITION,W
	banksel	LCDPUTLINE
	movwf	LCDPUTLINE
	clrf	LCDPUTCOLUMN
	movlw	42
	movwf	LCDCHAR
	pagesel	PUT_T6963
	call	PUT_T6963
	pagesel	$
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;next
	banksel	YPOSITION
	movf	YPOSITION,W
	movwf	SysBYTETempA
	movlw	7
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop1
ENDIF2
SysForLoopEnd1
;for Xposition = 0 to MAX_COLUMNS -1
	movlw	255
	banksel	XPOSITION
	movwf	XPOSITION
SysForLoop2
	banksel	XPOSITION
	incf	XPOSITION,F
;put 0, Xposition ,"*"
	banksel	LCDPUTLINE
	clrf	LCDPUTLINE
	banksel	XPOSITION
	movf	XPOSITION,W
	banksel	LCDPUTCOLUMN
	movwf	LCDPUTCOLUMN
	movlw	42
	movwf	LCDCHAR
	pagesel	PUT_T6963
	call	PUT_T6963
	pagesel	$
;put MAX_ROWS -1, Xposition, "*"
	movlw	7
	movwf	LCDPUTLINE
	banksel	XPOSITION
	movf	XPOSITION,W
	banksel	LCDPUTCOLUMN
	movwf	LCDPUTCOLUMN
	movlw	42
	movwf	LCDCHAR
	pagesel	PUT_T6963
	call	PUT_T6963
	pagesel	$
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;next
	banksel	XPOSITION
	movf	XPOSITION,W
	movwf	SysBYTETempA
	movlw	39
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop2
ENDIF4
SysForLoopEnd2
;for Yposition = 0 to MAX_ROWS -1
	movlw	255
	banksel	YPOSITION
	movwf	YPOSITION
SysForLoop3
	banksel	YPOSITION
	incf	YPOSITION,F
;put Yposition, MAX_COLUMNS -1 , "*"
	movf	YPOSITION,W
	banksel	LCDPUTLINE
	movwf	LCDPUTLINE
	movlw	39
	movwf	LCDPUTCOLUMN
	movlw	42
	movwf	LCDCHAR
	pagesel	PUT_T6963
	call	PUT_T6963
	pagesel	$
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;next
	banksel	YPOSITION
	movf	YPOSITION,W
	movwf	SysBYTETempA
	movlw	7
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop3
ENDIF6
SysForLoopEnd3
;wait 2 s
	movlw	2
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
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;LCDCURSOR LCDON
	movlw	4
	movwf	LCDCRSR
	movlw	1
	banksel	LINE_X_CURSOR
	movwf	LINE_X_CURSOR
	banksel	STATUS
	pagesel	LCDCURSOR_T6963
	call	LCDCURSOR_T6963
	pagesel	$
;Print "END TEST"
	movlw	low StringTable22
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable22) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	call	PRINT431
;wait 1 s
	movlw	1
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;end Repeat
	banksel	SYSREPEATTEMP1
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop1
SysRepeatLoopEnd1
GLCDTEST
;#DEFINE GLCD_OLED_FONT
;CLS
	banksel	STATUS
	pagesel	CLS_T6963
	call	CLS_T6963
	pagesel	$
;GLCDCLS
	pagesel	GLCDCLS_T6963
	call	GLCDCLS_T6963
	pagesel	$
;BigPrint ( 0, 0, "WG24064A-TMI-TZ#")
	banksel	PRINTLOCX
	clrf	PRINTLOCX
	clrf	PRINTLOCX_H
	clrf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable1
	movwf	SysStringA
	movlw	(high StringTable1) & 127
	movwf	SysStringA_H
	banksel	STATUS
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	movwf	COLOR
	movf	GLCDFOREGROUND_H,W
	movwf	COLOR_H
	pagesel	BIGPRINT_ILI9486L
	call	BIGPRINT_ILI9486L
	pagesel	$
;BigPrint ( 0, 20, "GLCD Capability")
	banksel	PRINTLOCX
	clrf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	20
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable23
	movwf	SysStringA
	movlw	(high StringTable23) & 127
	movwf	SysStringA_H
	banksel	STATUS
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	movwf	COLOR
	movf	GLCDFOREGROUND_H,W
	movwf	COLOR_H
	pagesel	BIGPRINT_ILI9486L
	call	BIGPRINT_ILI9486L
	pagesel	$
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;glcdprint 50, 40, "240 * 64  pixels mode"
	movlw	50
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	40
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable24
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable24) | 128
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	pagesel	GLCDPRINT3
	call	GLCDPRINT3
	pagesel	$
;glcdprint 50, 50, "Full GCB GLCD capable"
	movlw	50
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	50
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable25
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable25) | 128
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	pagesel	GLCDPRINT3
	call	GLCDPRINT3
	pagesel	$
;wait 4 s
	movlw	4
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
;CLS
	pagesel	CLS_T6963
	call	CLS_T6963
	pagesel	$
;GLCDCLS
	pagesel	GLCDCLS_T6963
	call	GLCDCLS_T6963
	pagesel	$
;Dim BYTENUMBER, CCOUNT as Byte
;CCount = 0
	clrf	CCOUNT
;dim longNumber as long
;longNumber = 4294967290 ' max value = 4294967296
	movlw	250
	banksel	LONGNUMBER
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
;Prepare the static components of the screen
;GLCDPrint ( 2,   0, "PrintStr")                                ; Print some text
	movlw	2
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	clrf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable26
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable26) | 128
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	pagesel	GLCDPRINT3
	call	GLCDPRINT3
	pagesel	$
;GLCDPrint ( 64,  0, "LAT@")                                    ; Print some more text
	movlw	64
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	clrf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable27
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable27) | 128
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	pagesel	GLCDPRINT3
	call	GLCDPRINT3
	pagesel	$
;GLCDPrint ( 88,  0, ChipMhz)                                   ; Print chip speed
	movlw	88
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	clrf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	32
	movwf	LCDVALUE
	clrf	LCDVALUE_H
	clrf	LCDVALUE_U
	clrf	LCDVALUE_E
	banksel	STATUS
	pagesel	GLCDPRINT5
	call	GLCDPRINT5
	pagesel	$
;GLCDPrint ( 100, 0, "Mhz")                                     ; Print some text
	movlw	100
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	clrf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable28
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable28) | 128
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	pagesel	GLCDPRINT3
	call	GLCDPRINT3
	pagesel	$
;GLCDDrawString( 2,8,"DrawStr")                                 ; Draw some text
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX
	movlw	8
	banksel	CHARLOCY
	movwf	CHARLOCY
	movlw	low StringTable29
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler
	movlw	(high StringTable29) | 128
	movwf	SysCHARSHandler_H
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	movwf	LINECOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	LINECOLOUR_H
	pagesel	GLCDDRAWSTRING
	call	GLCDDRAWSTRING
	pagesel	$
;box 0,0,GLCD_WIDTH-1, GLCD_HEIGHT-1                            ; Draw a box
	banksel	LINEX1
	clrf	LINEX1
	clrf	LINEX1_H
	clrf	LINEY1
	clrf	LINEY1_H
	movlw	239
	movwf	LINEX2
	clrf	LINEX2_H
	movlw	63
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
;box GLCD_WIDTH-5, GLCD_HEIGHT-5,GLCD_WIDTH-1, GLCD_HEIGHT-1    ; Draw a box
	movlw	235
	banksel	LINEX1
	movwf	LINEX1
	clrf	LINEX1_H
	movlw	59
	movwf	LINEY1
	clrf	LINEY1_H
	movlw	239
	movwf	LINEX2
	clrf	LINEX2_H
	movlw	63
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
;Circle( 44,41,15)                                              ; Draw a circle
	movlw	44
	banksel	XOFFSET
	movwf	XOFFSET
	clrf	XOFFSET_H
	movlw	41
	movwf	YOFFSET
	clrf	YOFFSET_H
	movlw	15
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
	call	CIRCLE
;line 64,31,0,31                                                ; Draw a line
	movlw	64
	banksel	LINEX1
	movwf	LINEX1
	clrf	LINEX1_H
	movlw	31
	movwf	LINEY1
	clrf	LINEY1_H
	clrf	LINEX2
	clrf	LINEX2_H
	movlw	31
	movwf	LINEY2
	clrf	LINEY2_H
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	movwf	LINECOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	LINECOLOUR_H
	pagesel	LINE
	call	LINE
	pagesel	$
;Repeat 1
	movlw	1
	banksel	SYSREPEATTEMP1
	movwf	SysRepeatTemp1
SysRepeatLoop3
;for CCount = 32 to 255
	movlw	31
	banksel	CCOUNT
	movwf	CCOUNT
SysForLoop4
	incf	CCOUNT,F
;GLCDPrint ( 64 ,  36,  hex(longNumber_E ) )                ; Print a HEX string
	movlw	64
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	36
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movf	LONGNUMBER_E,W
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
	pagesel	GLCDPRINT3
	call	GLCDPRINT3
	pagesel	$
;GLCDPrint ( 76 ,  36,  hex(longNumber_U ) )                ; Print a HEX string
	movlw	76
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	36
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movf	LONGNUMBER_U,W
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
	pagesel	GLCDPRINT3
	call	GLCDPRINT3
	pagesel	$
;GLCDPrint ( 88 ,  36,  hex(longNumber_H ) )                ; Print a HEX string
	movlw	88
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	36
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movf	LONGNUMBER_H,W
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
	pagesel	GLCDPRINT3
	call	GLCDPRINT3
	pagesel	$
;GLCDPrint ( 100 ,  36, hex(longNumber   ) )                ; Print a HEX string
	movlw	100
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	36
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movf	LONGNUMBER,W
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
	pagesel	GLCDPRINT3
	call	GLCDPRINT3
	pagesel	$
;GLCDPrint ( 112 ,  36, "h" )                               ; Print a HEX string
	movlw	112
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	36
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable30
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable30) | 128
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	pagesel	GLCDPRINT3
	call	GLCDPRINT3
	pagesel	$
;GLCDPrint ( 64 ,  44, pad(str(wordNumber), 5 ) )           ; Print a padded string
	movlw	64
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	44
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	banksel	WORDNUMBER
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
	banksel	SYSSTRLEN
	movwf	SYSSTRLEN
	movlw	low StringTable65
	movwf	SysSYSINSTRING3Handler
	movlw	(high StringTable65) | 128
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
	pagesel	GLCDPRINT3
	call	GLCDPRINT3
	pagesel	$
;GLCDPrint ( 64 ,  52, pad(str(byteNumber), 3 ) )           ; Print a padded string
	movlw	64
	banksel	PRINTLOCX
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	52
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
	banksel	SYSSTRLEN
	movwf	SYSSTRLEN
	movlw	low StringTable65
	movwf	SysSYSINSTRING3Handler
	movlw	(high StringTable65) | 128
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
	pagesel	GLCDPRINT3
	call	GLCDPRINT3
	pagesel	$
;filledbox (46,9,56,19,0)                                   ; Draw a Box
	movlw	46
	banksel	LINEX1
	movwf	LINEX1
	clrf	LINEX1_H
	movlw	9
	movwf	LINEY1
	clrf	LINEY1_H
	movlw	56
	movwf	LINEX2
	clrf	LINEX2_H
	movlw	19
	movwf	LINEY2
	clrf	LINEY2_H
	banksel	LINECOLOUR
	clrf	LINECOLOUR
	clrf	LINECOLOUR_H
	pagesel	FILLEDBOX_T6963
	call	FILLEDBOX_T6963
	pagesel	$
;box (46,9,56,19)
	movlw	46
	banksel	LINEX1
	movwf	LINEX1
	clrf	LINEX1_H
	movlw	9
	movwf	LINEY1
	clrf	LINEY1_H
	movlw	56
	movwf	LINEX2
	clrf	LINEX2_H
	movlw	19
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
;GLCDDrawChar(49, 10, CCount )                              ; Draw a character
	movlw	49
	movwf	CHARLOCX
	clrf	CHARLOCX_H
	movlw	10
	movwf	CHARLOCY
	clrf	CHARLOCY_H
	movf	CCOUNT,W
	movwf	CHARCODE
	movf	GLCDFOREGROUND,W
	movwf	LINECOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	LINECOLOUR_H
	pagesel	GLCDDRAWCHAR
	call	GLCDDRAWCHAR
	pagesel	$
;outString = str( CCount )                                  ; Prepare a string
	movf	CCOUNT,W
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	clrf	SYSVALTEMP_H
	banksel	STATUS
	pagesel	FN_STR
	call	FN_STR
	pagesel	$
	movlw	low OUTSTRING
	movwf	FSR1L
	movlw	high OUTSTRING
	movwf	FSR1H
	movlw	low STR
	movwf	FSR0L
	movlw	high STR
	movwf	FSR0H
	pagesel	SysCopyString
	call	SysCopyString
	pagesel	$
;GLCDDrawString(64, 9, pad(outString,3) )                   ; Draw a string
	movlw	64
	banksel	STRINGLOCX
	movwf	STRINGLOCX
	movlw	9
	banksel	CHARLOCY
	movwf	CHARLOCY
	movlw	low OUTSTRING
	banksel	SYSSYSINSTRINGHANDLER
	movwf	SysSYSINSTRINGHandler
	movlw	high OUTSTRING
	movwf	SysSYSINSTRINGHandler_H
	movlw	3
	banksel	SYSSTRLEN
	movwf	SYSSTRLEN
	movlw	low StringTable65
	movwf	SysSYSINSTRING3Handler
	movlw	(high StringTable65) | 128
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
	pagesel	GLCDDRAWSTRING
	call	GLCDDRAWSTRING
	pagesel	$
;filledbox 3,43,11,51, wordNumber.1                         ; Draw a filled box
	movlw	3
	banksel	LINEX1
	movwf	LINEX1
	clrf	LINEX1_H
	movlw	43
	movwf	LINEY1
	clrf	LINEY1_H
	movlw	11
	movwf	LINEX2
	clrf	LINEX2_H
	movlw	51
	movwf	LINEY2
	clrf	LINEY2_H
	banksel	LINECOLOUR
	clrf	LINECOLOUR
	clrf	LINECOLOUR_H
	banksel	WORDNUMBER
	btfss	WORDNUMBER,1
	goto	ENDIF8
	banksel	LINECOLOUR
	incf	LINECOLOUR,F
ENDIF8
	banksel	STATUS
	pagesel	FILLEDBOX_T6963
	call	FILLEDBOX_T6963
	pagesel	$
;FilledCircle( 44,41,9, longNumber.3)                       ; Draw a filled box
	movlw	44
	banksel	XOFFSET
	movwf	XOFFSET
	clrf	XOFFSET_H
	movlw	41
	movwf	YOFFSET
	clrf	YOFFSET_H
	movlw	9
	movwf	XRADIUS
	clrf	XRADIUS_H
	banksel	LINECOLOUR
	clrf	LINECOLOUR
	clrf	LINECOLOUR_H
	banksel	LONGNUMBER
	btfss	LONGNUMBER,3
	goto	ENDIF9
	banksel	LINECOLOUR
	incf	LINECOLOUR,F
ENDIF9
	banksel	STATUS
	pagesel	FILLEDCIRCLE
	call	FILLEDCIRCLE
	pagesel	$
;line 0,63,64,31                                            ; Draw a line
	banksel	LINEX1
	clrf	LINEX1
	clrf	LINEX1_H
	movlw	63
	movwf	LINEY1
	clrf	LINEY1_H
	movlw	64
	movwf	LINEX2
	clrf	LINEX2_H
	movlw	31
	movwf	LINEY2
	clrf	LINEY2_H
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	movwf	LINECOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	LINECOLOUR_H
	pagesel	LINE
	call	LINE
	pagesel	$
;Do some simple maths
;longNumber = longNumber + 7 : wordNumber = wordNumber + 3 : byteNumber++
	movlw	7
	banksel	LONGNUMBER
	addwf	LONGNUMBER,F
	movlw	0
	addwfc	LONGNUMBER_H,F
	movlw	0
	addwfc	LONGNUMBER_U,F
	movlw	0
	addwfc	LONGNUMBER_E,F
	movlw	3
	banksel	WORDNUMBER
	addwf	WORDNUMBER,F
	movlw	0
	addwfc	WORDNUMBER_H,F
	banksel	BYTENUMBER
	incf	BYTENUMBER,F
;NEXT
	movlw	255
	subwf	CCOUNT,W
	btfss	STATUS, C
	goto	SysForLoop4
ENDIF7
SysForLoopEnd4
;End repeat
	banksel	SYSREPEATTEMP1
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop3
SysRepeatLoopEnd3
;CLS
	banksel	STATUS
	pagesel	CLS_T6963
	call	CLS_T6963
	pagesel	$
;GLCDCLS
	pagesel	GLCDCLS_T6963
	call	GLCDCLS_T6963
	pagesel	$
;BigPrint ( 0, 0, "WG24064A-TMI-TZ#")
	banksel	PRINTLOCX
	clrf	PRINTLOCX
	clrf	PRINTLOCX_H
	clrf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable1
	movwf	SysStringA
	movlw	(high StringTable1) & 127
	movwf	SysStringA_H
	banksel	STATUS
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	movwf	COLOR
	movf	GLCDFOREGROUND_H,W
	movwf	COLOR_H
	pagesel	BIGPRINT_ILI9486L
	call	BIGPRINT_ILI9486L
	pagesel	$
;BigPrint ( 0, 40, "Anobium :-)")
	banksel	PRINTLOCX
	clrf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	40
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable31
	movwf	SysStringA
	movlw	(high StringTable31) & 127
	movwf	SysStringA_H
	banksel	STATUS
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	banksel	GLCDFOREGROUND
	movf	GLCDFOREGROUND,W
	movwf	COLOR
	movf	GLCDFOREGROUND_H,W
	movwf	COLOR_H
	pagesel	BIGPRINT_ILI9486L
	call	BIGPRINT_ILI9486L
	pagesel	$
;wait 5 s
	movlw	5
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
;CLS
	pagesel	CLS_T6963
	call	CLS_T6963
	pagesel	$
;GLCDCLS
	pagesel	GLCDCLS_T6963
	call	GLCDCLS_T6963
	pagesel	$
;loop
	goto	SysDoLoop_S1
SysDoLoop_E1
;end
	goto	BASPROGRAMEND
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
;#define LCDON 4
;#define FLASHON 3
;#define FLASH 3
;#define CursorON 2
;#define FLASHOFF 0xFC   'an AND MASK
;#define CursorOFF 0xFD  'an AND MASK
;#define LCDOFF 0xFB     'an AND MASK
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
	banksel	RADIUSERR
	movwf	RADIUSERR
	banksel	SYSTEMP1_H
	comf	SysTemp1_H,W
	banksel	RADIUSERR_H
	movwf	RADIUSERR_H
	incf	RADIUSERR,F
	btfsc	STATUS,Z
	incf	RADIUSERR_H,F
;Do While xradius >=  yordinate
SysDoLoop_S3
	banksel	XRADIUS
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
	pagesel	PSET_T6963
	call	PSET_T6963
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
	pagesel	PSET_T6963
	call	PSET_T6963
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
	pagesel	PSET_T6963
	call	PSET_T6963
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
	pagesel	PSET_T6963
	call	PSET_T6963
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
	pagesel	PSET_T6963
	call	PSET_T6963
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
	pagesel	PSET_T6963
	call	PSET_T6963
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
	pagesel	PSET_T6963
	call	PSET_T6963
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
	pagesel	PSET_T6963
	call	PSET_T6963
	pagesel	$
;yordinate ++
	banksel	YORDINATE
	incf	YORDINATE,F
;If radiusErr < 0 Then
	banksel	RADIUSERR
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
	goto	ELSE32_1
;radiusErr = radiusErr + 2 * yordinate + 1
	bcf	STATUS,C
	banksel	YORDINATE
	rlf	YORDINATE,W
	movwf	SysTemp1
	banksel	RADIUSERR
	addwf	RADIUSERR,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	0
	banksel	RADIUSERR_H
	addwfc	RADIUSERR_H,W
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H
	movlw	1
	addwf	SysTemp2,W
	banksel	RADIUSERR
	movwf	RADIUSERR
	movlw	0
	banksel	SYSTEMP2_H
	addwfc	SysTemp2_H,W
	banksel	RADIUSERR_H
	movwf	RADIUSERR_H
;else
	goto	ENDIF32
ELSE32_1
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
ENDIF32
;Loop
	goto	SysDoLoop_S3
SysDoLoop_E3
	return

;********************************************************************************

INITGLCD_ILI9486L
;Mapped to global variables to same RAM
;dim ILI9486L_GLCD_HEIGHT, ILI9486L_GLCD_WIDTH as word
	return

;********************************************************************************

INITGLCD_T6963
;Setup code for T6963 controllers
;dim T6963_GLCD_HEIGHT, T6963_GLCD_WIDTH as word
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
;Set the font control port
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
;Set the operating mode
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
;T6963_GLCD_WIDTH = GLCD_WIDTH
	movlw	240
	movwf	GLCDDEVICEWIDTH
	clrf	GLCDDEVICEWIDTH_H
;T6963_GLCD_HEIGHT = GLCD_HEIGHT
	movlw	64
	movwf	GLCDDEVICEHEIGHT
	clrf	GLCDDEVICEHEIGHT_H
;GLCDRotate
	movlw	1
	movwf	GLCDROTATESTATE
	pagesel	GLCDROTATE_T6963
	call	GLCDROTATE_T6963
;Clear screen
;GLCDCLS
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

;Overloaded signature: STRING:
PRINT431
;PrintLen = LEN(PrintData$)
;PrintLen = PrintData(0)
	banksel	SYSPRINTDATAHANDLER
	movf	SysPRINTDATAHandler,W
	movwf	AFSR0
	movf	SysPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	PRINTLEN
;If PrintLen = 0 Then Exit Sub
	movf	PRINTLEN,F
	btfss	STATUS, Z
	goto	ENDIF97
	banksel	STATUS
	return
ENDIF97
;Set LCD_RS On
	bsf	SYSLCDTEMP,1
;Write Data
;For SysPrintTemp = 1 To PrintLen
	clrf	SYSPRINTTEMP
	movlw	1
	subwf	PRINTLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd23
ENDIF98
SysForLoop23
	incf	SYSPRINTTEMP,F
;LCDWriteByte PrintData(SysPrintTemp)
	movf	SYSPRINTTEMP,W
	addwf	SysPRINTDATAHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	LCDBYTE
	movwf	LCDBYTE
	pagesel	LCDNORMALWRITEBYTE_T6963
	call	LCDNORMALWRITEBYTE_T6963
	pagesel	$
;Next
	banksel	PRINTLEN
	movf	PRINTLEN,W
	subwf	SYSPRINTTEMP,W
	btfss	STATUS, C
	goto	SysForLoop23
ENDIF99
SysForLoopEnd23
	banksel	STATUS
	return

;********************************************************************************

;Start of program memory page 1
	ORG	2048
DRAWBIGCHAR_ILI9486L
;dim Locx, Locy, CurrCol as Word
;if CharCode <=126 Then
	movf	CHARCODE,W
	sublw	126
	btfss	STATUS, C
	goto	ENDIF42
;CharCode -=32
	movlw	32
	subwf	CHARCODE,F
;Goto GCBBigTables
	goto	GCBBIGTABLES
;end if
ENDIF42
;if CharCode <=210 Then
	movf	CHARCODE,W
	sublw	210
	btfss	STATUS, C
	goto	ENDIF43
;CharCode -=33
	movlw	33
	subwf	CHARCODE,F
;Goto GCBBigTables
	goto	GCBBIGTABLES
;end if
ENDIF43
;if CharCode <= 250 Then
	movf	CHARCODE,W
	sublw	250
	btfss	STATUS, C
	goto	ENDIF44
;CharCode -=34
	movlw	34
	subwf	CHARCODE,F
;Goto GCBBigTables
	goto	GCBBIGTABLES
;end if
ENDIF44
GCBBIGTABLES
;For CurrCharCol = 1 to 24
	clrf	CURRCHARCOL
SysForLoop15
	incf	CURRCHARCOL,F
;CurrCol=CurrCharCol+CharCode*24-(CharCode/10)*240
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	10
	movwf	SysBYTETempB
	pagesel	SysDivSub
	call	SysDivSub
	pagesel	$
	movf	SysBYTETempA,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	24
	movwf	SysBYTETempB
	pagesel	SysMultSub
	call	SysMultSub
	pagesel	$
	movf	SysBYTETempX,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movf	SysTemp1,W
	movwf	SysBYTETempA
	movlw	240
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SysMultSub
	call	SysMultSub
	pagesel	$
	banksel	SYSTEMP2
	movf	SysTemp2,W
	banksel	CURRCHARCOL
	addwf	CURRCHARCOL,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	clrf	SysTemp1_H
	btfsc	STATUS,C
	incf	SysTemp1_H,F
	movf	SysBYTETempX,W
	subwf	SysTemp1,W
	banksel	CURRCOL
	movwf	CURRCOL
	movlw	0
	banksel	SYSTEMP1_H
	subwfb	SysTemp1_H,W
	banksel	CURRCOL_H
	movwf	CURRCOL_H
;if CharCode>=0 and CharCode<=9 then ReadTable BigFont32_41 , CurrCol, CurrCharVal
	movf	CHARCODE,W
	movwf	SysBYTETempA
	clrf	SysBYTETempB
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
	movlw	9
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
	goto	ENDIF45
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT32_41
	call	BIGFONT32_41
	pagesel	$
	movwf	CURRCHARVAL
ENDIF45
;if CharCode>=10 and CharCode<=19 then ReadTable BigFont42_51 , CurrCol, CurrCharVal
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	10
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
	movlw	19
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
	goto	ENDIF46
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT42_51
	call	BIGFONT42_51
	pagesel	$
	movwf	CURRCHARVAL
ENDIF46
;if CharCode>=20 and CharCode<=29 then ReadTable BigFont52_61 , CurrCol, CurrCharVal
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	20
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
	movlw	29
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
	goto	ENDIF47
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT52_61
	call	BIGFONT52_61
	pagesel	$
	movwf	CURRCHARVAL
ENDIF47
;if CharCode>=30 and CharCode<=39 then ReadTable BigFont62_71 , CurrCol, CurrCharVal
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	30
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
	movlw	39
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
	goto	ENDIF48
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT62_71
	call	BIGFONT62_71
	pagesel	$
	movwf	CURRCHARVAL
ENDIF48
;if CharCode>=40 and CharCode<=49 then ReadTable BigFont72_81 , CurrCol, CurrCharVal
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	40
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
	movlw	49
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
	goto	ENDIF49
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT72_81
	call	BIGFONT72_81
	pagesel	$
	movwf	CURRCHARVAL
ENDIF49
;if CharCode>=50 and CharCode<=59 then ReadTable BigFont82_91 , CurrCol, CurrCharVal
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	50
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
	movlw	59
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
	goto	ENDIF50
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT82_91
	call	BIGFONT82_91
	pagesel	$
	movwf	CURRCHARVAL
ENDIF50
;if CharCode>=60 and CharCode<=69 then ReadTable BigFont92_101 , CurrCol, CurrCharVal
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	60
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
	movlw	69
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
	goto	ENDIF51
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT92_101
	call	BIGFONT92_101
	pagesel	$
	movwf	CURRCHARVAL
ENDIF51
;if CharCode>=70 and CharCode<=79 then ReadTable BigFont102_111 , CurrCol, CurrCharVal
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	70
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
	movlw	79
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
	goto	ENDIF52
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT102_111
	call	BIGFONT102_111
	pagesel	$
	movwf	CURRCHARVAL
ENDIF52
;if CharCode>=80 and CharCode<=89 then ReadTable BigFont112_121 , CurrCol, CurrCharVal
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	80
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
	movlw	89
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
	goto	ENDIF53
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT112_121
	call	BIGFONT112_121
	pagesel	$
	movwf	CURRCHARVAL
ENDIF53
;if CharCode>=90 and CharCode<=99 then ReadTable BigFont122_126 , CurrCol, CurrCharVal
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	90
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
	movlw	99
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
	goto	ENDIF54
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT122_126
	call	BIGFONT122_126
	pagesel	$
	movwf	CURRCHARVAL
ENDIF54
;if CharCode>=160 and CharCode<=169 then ReadTable BigFont193_202 , CurrCol, CurrCharVal
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	160
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
	movlw	169
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
	goto	ENDIF55
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT193_202
	call	BIGFONT193_202
	pagesel	$
	movwf	CURRCHARVAL
ENDIF55
;if CharCode>=170 and CharCode<=179 then ReadTable BigFont203_212 , CurrCol, CurrCharVal
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	170
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
	movlw	179
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
	goto	ENDIF56
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT203_212
	call	BIGFONT203_212
	pagesel	$
	movwf	CURRCHARVAL
ENDIF56
;if CharCode>=180 and CharCode<=183 then ReadTable BigFont213_216 , CurrCol, CurrCharVal
	banksel	CHARCODE
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	180
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
	movlw	183
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
	goto	ENDIF57
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT213_216
	call	BIGFONT213_216
	pagesel	$
	movwf	CURRCHARVAL
ENDIF57
;if CurrCharVal=36 then CurrCharVal=33
	movlw	36
	banksel	CURRCHARVAL
	subwf	CURRCHARVAL,W
	btfss	STATUS, Z
	goto	ENDIF58
	movlw	33
	movwf	CURRCHARVAL
ENDIF58
;For CurrCharRow = 1 to 8
	clrf	CURRCHARROW
SysForLoop16
	incf	CURRCHARROW,F
;LocX=[word]CharLocX+CurrCharCol
	movf	CURRCHARCOL,W
	addwf	CHARLOCX,W
	banksel	LOCX
	movwf	LOCX
	movlw	0
	banksel	CHARLOCX_H
	addwfc	CHARLOCX_H,W
	banksel	LOCX_H
	movwf	LOCX_H
;LocY=[Word]CharLocY+CurrCharRow
	banksel	CURRCHARROW
	movf	CURRCHARROW,W
	addwf	CHARLOCY,W
	banksel	LOCY
	movwf	LOCY
	movlw	0
	banksel	CHARLOCY_H
	addwfc	CHARLOCY_H,W
	banksel	LOCY_H
	movwf	LOCY_H
;if CurrCharCol>12 then
	banksel	CURRCHARCOL
	movf	CURRCHARCOL,W
	sublw	12
	btfsc	STATUS, C
	goto	ENDIF59
;LocX= LocX - 12
	movlw	12
	banksel	LOCX
	subwf	LOCX,F
	movlw	0
	subwfb	LOCX_H,F
;LocY= LocY + 8
	movlw	8
	addwf	LOCY,F
	movlw	0
	addwfc	LOCY_H,F
;end if
ENDIF59
;if CurrCharVal.0=1 then
	banksel	CURRCHARVAL
	btfss	CURRCHARVAL,0
	goto	ENDIF60
;PSet LocX , LocY , Color
	banksel	LOCX
	movf	LOCX,W
	banksel	GLCDX
	movwf	GLCDX
	banksel	LOCX_H
	movf	LOCX_H,W
	banksel	GLCDX_H
	movwf	GLCDX_H
	banksel	LOCY
	movf	LOCY,W
	banksel	GLCDY
	movwf	GLCDY
	banksel	LOCY_H
	movf	LOCY_H,W
	banksel	GLCDY_H
	movwf	GLCDY_H
	movf	COLOR,W
	movwf	GLCDCOLOUR
	movf	COLOR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_T6963
	call	PSET_T6963
	pagesel	$
;end if
ENDIF60
;Rotate CurrCharVal Right
	rrf	CURRCHARVAL,F
;Next
	movlw	8
	subwf	CURRCHARROW,W
	btfss	STATUS, C
	goto	SysForLoop16
ENDIF61
SysForLoopEnd16
;Next
	movlw	24
	subwf	CURRCHARCOL,W
	btfss	STATUS, C
	goto	SysForLoop15
ENDIF62
SysForLoopEnd15
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
	banksel	LINEX1
	movwf	LINEX1
	banksel	XOFFSET_H
	movf	XOFFSET_H,W
	banksel	LINEX1_H
	movwf	LINEX1_H
	banksel	YCALC1
	movf	YCALC1,W
	banksel	LINEY1
	movwf	LINEY1
	banksel	YCALC1_H
	movf	YCALC1_H,W
	banksel	LINEY1_H
	movwf	LINEY1_H
	banksel	XOFFSET
	movf	XOFFSET,W
	banksel	LINEX2
	movwf	LINEX2
	banksel	XOFFSET_H
	movf	XOFFSET_H,W
	banksel	LINEX2_H
	movwf	LINEX2_H
	banksel	YCALC2
	movf	YCALC2,W
	banksel	LINEY2
	movwf	LINEY2
	banksel	YCALC2_H
	movf	YCALC2_H,W
	banksel	LINEY2_H
	movwf	LINEY2_H
	banksel	STATUS
	call	LINE
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
	goto	ENDIF33
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
ENDIF33
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
	banksel	LINEX1
	movwf	LINEX1
	movlw	0
	banksel	XOFFSET_H
	addwfc	XOFFSET_H,W
	banksel	LINEX1_H
	movwf	LINEX1_H
	banksel	FILLCIRCLEYY
	movf	FILLCIRCLEYY,W
	banksel	YOFFSET
	addwf	YOFFSET,W
	banksel	LINEY1
	movwf	LINEY1
	movlw	0
	banksel	YOFFSET_H
	addwfc	YOFFSET_H,W
	banksel	LINEY1_H
	movwf	LINEY1_H
	banksel	FILLCIRCLEXX
	movf	FILLCIRCLEXX,W
	banksel	XOFFSET
	addwf	XOFFSET,W
	banksel	LINEX2
	movwf	LINEX2
	movlw	0
	banksel	XOFFSET_H
	addwfc	XOFFSET_H,W
	banksel	LINEX2_H
	movwf	LINEX2_H
	banksel	FILLCIRCLEYY
	movf	FILLCIRCLEYY,W
	banksel	YOFFSET
	subwf	YOFFSET,W
	banksel	LINEY2
	movwf	LINEY2
	movlw	0
	banksel	YOFFSET_H
	subwfb	YOFFSET_H,W
	banksel	LINEY2_H
	movwf	LINEY2_H
	banksel	STATUS
	call	LINE
;Line(xoffset-FillCircleXX, yoffset+FillCircleYY, xoffset-FillCircleXX, yoffset-FillCircleYY, LineColour);
	movf	FILLCIRCLEXX,W
	banksel	XOFFSET
	subwf	XOFFSET,W
	banksel	LINEX1
	movwf	LINEX1
	movlw	0
	banksel	XOFFSET_H
	subwfb	XOFFSET_H,W
	banksel	LINEX1_H
	movwf	LINEX1_H
	banksel	FILLCIRCLEYY
	movf	FILLCIRCLEYY,W
	banksel	YOFFSET
	addwf	YOFFSET,W
	banksel	LINEY1
	movwf	LINEY1
	movlw	0
	banksel	YOFFSET_H
	addwfc	YOFFSET_H,W
	banksel	LINEY1_H
	movwf	LINEY1_H
	banksel	FILLCIRCLEXX
	movf	FILLCIRCLEXX,W
	banksel	XOFFSET
	subwf	XOFFSET,W
	banksel	LINEX2
	movwf	LINEX2
	movlw	0
	banksel	XOFFSET_H
	subwfb	XOFFSET_H,W
	banksel	LINEX2_H
	movwf	LINEX2_H
	banksel	FILLCIRCLEYY
	movf	FILLCIRCLEYY,W
	banksel	YOFFSET
	subwf	YOFFSET,W
	banksel	LINEY2
	movwf	LINEY2
	movlw	0
	banksel	YOFFSET_H
	subwfb	YOFFSET_H,W
	banksel	LINEY2_H
	movwf	LINEY2_H
	banksel	STATUS
	call	LINE
;Line(xoffset+FillCircleYY, yoffset+FillCircleXX, FillCircleYY+xoffset, yoffset-FillCircleXX, LineColour);
	movf	FILLCIRCLEYY,W
	banksel	XOFFSET
	addwf	XOFFSET,W
	banksel	LINEX1
	movwf	LINEX1
	movlw	0
	banksel	XOFFSET_H
	addwfc	XOFFSET_H,W
	banksel	LINEX1_H
	movwf	LINEX1_H
	banksel	FILLCIRCLEXX
	movf	FILLCIRCLEXX,W
	banksel	YOFFSET
	addwf	YOFFSET,W
	banksel	LINEY1
	movwf	LINEY1
	movlw	0
	banksel	YOFFSET_H
	addwfc	YOFFSET_H,W
	banksel	LINEY1_H
	movwf	LINEY1_H
	banksel	XOFFSET
	movf	XOFFSET,W
	banksel	FILLCIRCLEYY
	addwf	FILLCIRCLEYY,W
	banksel	LINEX2
	movwf	LINEX2
	movlw	0
	banksel	SYSTEMP1
	movwf	SysTemp1
	movf	XOFFSET_H,W
	addwfc	SysTemp1,W
	banksel	LINEX2_H
	movwf	LINEX2_H
	banksel	FILLCIRCLEXX
	movf	FILLCIRCLEXX,W
	banksel	YOFFSET
	subwf	YOFFSET,W
	banksel	LINEY2
	movwf	LINEY2
	movlw	0
	banksel	YOFFSET_H
	subwfb	YOFFSET_H,W
	banksel	LINEY2_H
	movwf	LINEY2_H
	banksel	STATUS
	call	LINE
;Line(xoffset-FillCircleYY, yoffset+FillCircleXX, xoffset-FillCircleYY, yoffset-FillCircleXX, LineColour);
	movf	FILLCIRCLEYY,W
	banksel	XOFFSET
	subwf	XOFFSET,W
	banksel	LINEX1
	movwf	LINEX1
	movlw	0
	banksel	XOFFSET_H
	subwfb	XOFFSET_H,W
	banksel	LINEX1_H
	movwf	LINEX1_H
	banksel	FILLCIRCLEXX
	movf	FILLCIRCLEXX,W
	banksel	YOFFSET
	addwf	YOFFSET,W
	banksel	LINEY1
	movwf	LINEY1
	movlw	0
	banksel	YOFFSET_H
	addwfc	YOFFSET_H,W
	banksel	LINEY1_H
	movwf	LINEY1_H
	banksel	FILLCIRCLEYY
	movf	FILLCIRCLEYY,W
	banksel	XOFFSET
	subwf	XOFFSET,W
	banksel	LINEX2
	movwf	LINEX2
	movlw	0
	banksel	XOFFSET_H
	subwfb	XOFFSET_H,W
	banksel	LINEX2_H
	movwf	LINEX2_H
	banksel	FILLCIRCLEXX
	movf	FILLCIRCLEXX,W
	banksel	YOFFSET
	subwf	YOFFSET,W
	banksel	LINEY2
	movwf	LINEY2
	movlw	0
	banksel	YOFFSET_H
	subwfb	YOFFSET_H,W
	banksel	LINEY2_H
	movwf	LINEY2_H
	banksel	STATUS
	call	LINE
;loop
	goto	SysDoLoop_S4
SysDoLoop_E4
	return

;********************************************************************************

GLCDDRAWCHAR
;This has got a tad complex
;We have three major pieces
;1 The preamble - this just adjusted color and the input character
;2 The code that deals with GCB fontset
;3 The code that deals with OLED fontset
;
;You can make independent change to section 2 and 3 but they are mutual exclusive with many common pieces
;invert colors if required
;if LineColour <> GLCDForeground  then
	movf	LINECOLOUR,W
	movwf	SysWORDTempA
	movf	LINECOLOUR_H,W
	movwf	SysWORDTempA_H
	movf	GLCDFOREGROUND,W
	movwf	SysWORDTempB
	movf	GLCDFOREGROUND_H,W
	movwf	SysWORDTempB_H
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF17
;Inverted Colours
;GLCDBackground = 1
	movlw	1
	movwf	GLCDBACKGROUND
	clrf	GLCDBACKGROUND_H
;GLCDForeground = 0
	clrf	GLCDFOREGROUND
	clrf	GLCDFOREGROUND_H
;end if
ENDIF17
;dim CharCol, CharRow as word
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
	goto	ENDIF18
;CharLocY=CharLocY-1
	movlw	1
	banksel	CHARLOCY
	subwf	CHARLOCY,F
	movlw	0
	subwfb	CHARLOCY_H,F
;end if
ENDIF18
;For CurrCharCol = 1 to 5
	banksel	CURRCHARCOL
	clrf	CURRCHARCOL
SysForLoop8
	incf	CURRCHARCOL,F
;Select Case CurrCharCol
;Case 1: ReadTable GLCDCharCol3, CharCode, CurrCharVal
SysSelect1Case1
	decf	CURRCHARCOL,W
	btfss	STATUS, Z
	goto	SysSelect1Case2
	movf	CHARCODE,W
	movwf	SYSSTRINGA
	pagesel	GLCDCHARCOL3EXTENDED1
	call	GLCDCHARCOL3EXTENDED1
	pagesel	$
	movwf	CURRCHARVAL
;Case 2: ReadTable GLCDCharCol4, CharCode, CurrCharVal
	goto	SysSelectEnd1
SysSelect1Case2
	movlw	2
	subwf	CURRCHARCOL,W
	btfss	STATUS, Z
	goto	SysSelect1Case3
	movf	CHARCODE,W
	movwf	SYSSTRINGA
	pagesel	GLCDCHARCOL4EXTENDED1
	call	GLCDCHARCOL4EXTENDED1
	pagesel	$
	movwf	CURRCHARVAL
;Case 3: ReadTable GLCDCharCol5, CharCode, CurrCharVal
	goto	SysSelectEnd1
SysSelect1Case3
	movlw	3
	subwf	CURRCHARCOL,W
	btfss	STATUS, Z
	goto	SysSelect1Case4
	movf	CHARCODE,W
	movwf	SYSSTRINGA
	pagesel	GLCDCHARCOL5EXTENDED1
	call	GLCDCHARCOL5EXTENDED1
	pagesel	$
	movwf	CURRCHARVAL
;Case 4: ReadTable GLCDCharCol6, CharCode, CurrCharVal
	goto	SysSelectEnd1
SysSelect1Case4
	movlw	4
	subwf	CURRCHARCOL,W
	btfss	STATUS, Z
	goto	SysSelect1Case5
	movf	CHARCODE,W
	movwf	SYSSTRINGA
	pagesel	GLCDCHARCOL6EXTENDED1
	call	GLCDCHARCOL6EXTENDED1
	pagesel	$
	movwf	CURRCHARVAL
;Case 5: ReadTable GLCDCharCol7, CharCode, CurrCharVal
	goto	SysSelectEnd1
SysSelect1Case5
	movlw	5
	subwf	CURRCHARCOL,W
	btfss	STATUS, Z
	goto	SysSelectEnd1
	movf	CHARCODE,W
	movwf	SYSSTRINGA
	pagesel	GLCDCHARCOL7EXTENDED1
	call	GLCDCHARCOL7EXTENDED1
	pagesel	$
	movwf	CURRCHARVAL
;End Select
SysSelectEnd1
;CharRow=0
	clrf	CHARROW
	clrf	CHARROW_H
;For CurrCharRow = 1 to 8
	clrf	CURRCHARROW
SysForLoop9
	incf	CURRCHARROW,F
;CharColS=0
	clrf	CHARCOLS
;For Col=1 to GLCDfntDefaultsize
	clrf	COL
	movlw	1
	subwf	GLCDFNTDEFAULTSIZE,W
	btfss	STATUS, C
	goto	SysForLoopEnd10
ENDIF19
SysForLoop10
	incf	COL,F
;CharRowS=0
	clrf	CHARROWS
;For Row=1 to GLCDfntDefaultsize
	banksel	ROW
	clrf	ROW
	movlw	1
	banksel	GLCDFNTDEFAULTSIZE
	subwf	GLCDFNTDEFAULTSIZE,W
	btfss	STATUS, C
	goto	SysForLoopEnd11
ENDIF20
SysForLoop11
	banksel	ROW
	incf	ROW,F
;if CurrCharVal.0=1 then
	banksel	CURRCHARVAL
	btfss	CURRCHARVAL,0
	goto	ELSE21_1
;PSet [word]CharLocX + CharCol+ CharColS, [word]CharLocY + CharRow+CharRowS, LineColour
	movf	CHARCOL,W
	addwf	CHARLOCX,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	banksel	CHARCOL_H
	movf	CHARCOL_H,W
	addwfc	CHARLOCX_H,W
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H
	banksel	CHARCOLS
	movf	CHARCOLS,W
	banksel	SYSTEMP2
	addwf	SysTemp2,W
	banksel	GLCDX
	movwf	GLCDX
	movlw	0
	banksel	SYSTEMP2_H
	addwfc	SysTemp2_H,W
	banksel	GLCDX_H
	movwf	GLCDX_H
	movf	CHARROW,W
	addwf	CHARLOCY,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	banksel	CHARROW_H
	movf	CHARROW_H,W
	addwfc	CHARLOCY_H,W
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H
	banksel	CHARROWS
	movf	CHARROWS,W
	banksel	SYSTEMP2
	addwf	SysTemp2,W
	banksel	GLCDY
	movwf	GLCDY
	movlw	0
	banksel	SYSTEMP2_H
	addwfc	SysTemp2_H,W
	banksel	GLCDY_H
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_T6963
	call	PSET_T6963
	pagesel	$
;Else
	goto	ENDIF21
ELSE21_1
;PSet [word]CharLocX + CharCol+ CharColS, [word]CharLocY + CharRow+CharRowS, GLCDBackground
	movf	CHARCOL,W
	addwf	CHARLOCX,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	banksel	CHARCOL_H
	movf	CHARCOL_H,W
	addwfc	CHARLOCX_H,W
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H
	banksel	CHARCOLS
	movf	CHARCOLS,W
	banksel	SYSTEMP2
	addwf	SysTemp2,W
	banksel	GLCDX
	movwf	GLCDX
	movlw	0
	banksel	SYSTEMP2_H
	addwfc	SysTemp2_H,W
	banksel	GLCDX_H
	movwf	GLCDX_H
	movf	CHARROW,W
	addwf	CHARLOCY,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	banksel	CHARROW_H
	movf	CHARROW_H,W
	addwfc	CHARLOCY_H,W
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H
	banksel	CHARROWS
	movf	CHARROWS,W
	banksel	SYSTEMP2
	addwf	SysTemp2,W
	banksel	GLCDY
	movwf	GLCDY
	movlw	0
	banksel	SYSTEMP2_H
	addwfc	SysTemp2_H,W
	banksel	GLCDY_H
	movwf	GLCDY_H
	movf	GLCDBACKGROUND,W
	movwf	GLCDCOLOUR
	movf	GLCDBACKGROUND_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_T6963
	call	PSET_T6963
	pagesel	$
;End if
ENDIF21
;Put out a white intercharacter pixel/space
;PSet [word]CharLocX + ( GLCDFontWidth * GLCDfntDefaultsize) , [word]CharLocY + CharRow + CharRowS , GLCDBackground
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
	banksel	CHARLOCX
	addwf	CHARLOCX,W
	movwf	GLCDX
	movlw	0
	addwfc	CHARLOCX_H,W
	movwf	GLCDX_H
	movf	CHARROW,W
	addwf	CHARLOCY,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	banksel	CHARROW_H
	movf	CHARROW_H,W
	addwfc	CHARLOCY_H,W
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H
	banksel	CHARROWS
	movf	CHARROWS,W
	banksel	SYSTEMP2
	addwf	SysTemp2,W
	banksel	GLCDY
	movwf	GLCDY
	movlw	0
	banksel	SYSTEMP2_H
	addwfc	SysTemp2_H,W
	banksel	GLCDY_H
	movwf	GLCDY_H
	movf	GLCDBACKGROUND,W
	movwf	GLCDCOLOUR
	movf	GLCDBACKGROUND_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_T6963
	call	PSET_T6963
	pagesel	$
;CharRowS +=1
	incf	CHARROWS,F
;Next Row
	movf	GLCDFNTDEFAULTSIZE,W
	banksel	ROW
	subwf	ROW,W
	btfss	STATUS, C
	goto	SysForLoop11
ENDIF22
SysForLoopEnd11
;CharColS +=1
	banksel	CHARCOLS
	incf	CHARCOLS,F
;Next Col
	movf	GLCDFNTDEFAULTSIZE,W
	subwf	COL,W
	btfss	STATUS, C
	goto	SysForLoop10
ENDIF23
SysForLoopEnd10
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
	goto	SysForLoop9
ENDIF24
SysForLoopEnd9
;CharCol +=GLCDfntDefaultsize
	movf	GLCDFNTDEFAULTSIZE,W
	addwf	CHARCOL,F
	movlw	0
	addwfc	CHARCOL_H,F
;Next
	movlw	5
	subwf	CURRCHARCOL,W
	btfss	STATUS, C
	goto	SysForLoop8
ENDIF25
SysForLoopEnd8
;Restore
;GLCDBackground = 0
	clrf	GLCDBACKGROUND
	clrf	GLCDBACKGROUND_H
;GLCDForeground = 1
	movlw	1
	movwf	GLCDFOREGROUND
	clrf	GLCDFOREGROUND_H
	return

;********************************************************************************

LINE
;dim LineStepX as integer
;dim LineStepY as integer
;dim LineDiffX, LineDiffY as integer
;dim LineDiffX_x2, LineDiffY_x2 as integer
;dim LineErr as integer
;LineDiffX = 0
	banksel	LINEDIFFX
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
	movf	LINEX1,W
	subwf	LINEX2,W
	movwf	LINEDIFFX
	movf	LINEX1_H,W
	subwfb	LINEX2_H,W
	movwf	LINEDIFFX_H
;LineDiffY =  LineY2 -   LineY1
	movf	LINEY1,W
	subwf	LINEY2,W
	movwf	LINEDIFFY
	movf	LINEY1_H,W
	subwfb	LINEY2_H,W
	movwf	LINEDIFFY_H
;if (LineDiffX > 0) then
	movf	LINEDIFFX,W
	movwf	SysINTEGERTempB
	movf	LINEDIFFX_H,W
	movwf	SysINTEGERTempB_H
	clrf	SysINTEGERTempA
	clrf	SysINTEGERTempA_H
	banksel	STATUS
	pagesel	SysCompLessThanINT
	call	SysCompLessThanINT
	pagesel	$
	btfss	SysByteTempX,0
	goto	ELSE34_1
;LineStepX = 1
	movlw	1
	banksel	LINESTEPX
	movwf	LINESTEPX
	clrf	LINESTEPX_H
;else
	goto	ENDIF34
ELSE34_1
;LineStepX = -1
	movlw	255
	banksel	LINESTEPX
	movwf	LINESTEPX
	movwf	LINESTEPX_H
;end if
ENDIF34
;if (LineDiffY > 0) then
	movf	LINEDIFFY,W
	movwf	SysINTEGERTempB
	movf	LINEDIFFY_H,W
	movwf	SysINTEGERTempB_H
	clrf	SysINTEGERTempA
	clrf	SysINTEGERTempA_H
	banksel	STATUS
	pagesel	SysCompLessThanINT
	call	SysCompLessThanINT
	pagesel	$
	btfss	SysByteTempX,0
	goto	ELSE35_1
;LineStepY = 1
	movlw	1
	banksel	LINESTEPY
	movwf	LINESTEPY
	clrf	LINESTEPY_H
;else
	goto	ENDIF35
ELSE35_1
;LineStepY = -1
	movlw	255
	banksel	LINESTEPY
	movwf	LINESTEPY
	movwf	LINESTEPY_H
;end if
ENDIF35
;LineDiffX = LineStepX * LineDiffX
	movf	LINESTEPX,W
	movwf	SysINTEGERTempA
	movf	LINESTEPX_H,W
	movwf	SysINTEGERTempA_H
	movf	LINEDIFFX,W
	movwf	SysINTEGERTempB
	movf	LINEDIFFX_H,W
	movwf	SysINTEGERTempB_H
	banksel	STATUS
	pagesel	SysMultSubINT
	call	SysMultSubINT
	pagesel	$
	movf	SysINTEGERTempX,W
	banksel	LINEDIFFX
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
	banksel	STATUS
	pagesel	SysMultSubINT
	call	SysMultSubINT
	pagesel	$
	movf	SysINTEGERTempX,W
	banksel	LINEDIFFY
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
	banksel	STATUS
	pagesel	SysMultSubINT
	call	SysMultSubINT
	pagesel	$
	movf	SysINTEGERTempX,W
	banksel	LINEDIFFX_X2
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
	banksel	STATUS
	pagesel	SysMultSubINT
	call	SysMultSubINT
	pagesel	$
	movf	SysINTEGERTempX,W
	banksel	LINEDIFFY_X2
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
	banksel	STATUS
	pagesel	SysCompLessThanINT
	call	SysCompLessThanINT
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ELSE36_1
;LineErr = LineDiffY_x2 - LineDiffX
	banksel	LINEDIFFX
	movf	LINEDIFFX,W
	subwf	LINEDIFFY_X2,W
	movwf	LINEERR
	movf	LINEDIFFX_H,W
	subwfb	LINEDIFFY_X2_H,W
	movwf	LINEERR_H
;do while (   LineX1 <>  LineX2 )
SysDoLoop_S5
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
	goto	SysDoLoop_E5
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
	pagesel	PSET_T6963
	call	PSET_T6963
	pagesel	$
;LineX1 += LineStepX
	banksel	LINESTEPX
	movf	LINESTEPX,W
	addwf	LINEX1,F
	movf	LINESTEPX_H,W
	addwfc	LINEX1_H,F
;if ( LineErr < 0) then
	movf	LINEERR,W
	movwf	SysINTEGERTempA
	movf	LINEERR_H,W
	movwf	SysINTEGERTempA_H
	clrf	SysINTEGERTempB
	clrf	SysINTEGERTempB_H
	banksel	STATUS
	pagesel	SysCompLessThanINT
	call	SysCompLessThanINT
	pagesel	$
	btfss	SysByteTempX,0
	goto	ELSE37_1
;LineErr += LineDiffY_x2
	banksel	LINEDIFFY_X2
	movf	LINEDIFFY_X2,W
	addwf	LINEERR,F
	movf	LINEDIFFY_X2_H,W
	addwfc	LINEERR_H,F
;else
	goto	ENDIF37
ELSE37_1
;LineErr += ( LineDiffY_x2 - LineDiffX_x2 )
	banksel	LINEDIFFX_X2
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
	addwf	LINEY1,F
	movf	LINESTEPY_H,W
	addwfc	LINEY1_H,F
;end if
ENDIF37
;loop
	goto	SysDoLoop_S5
SysDoLoop_E5
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
	pagesel	PSET_T6963
	call	PSET_T6963
	pagesel	$
;else
	goto	ENDIF36
ELSE36_1
;LineErr = LineDiffX_x2 - LineDiffY
	banksel	LINEDIFFY
	movf	LINEDIFFY,W
	subwf	LINEDIFFX_X2,W
	movwf	LINEERR
	movf	LINEDIFFY_H,W
	subwfb	LINEDIFFX_X2_H,W
	movwf	LINEERR_H
;do while (   LineY1 <>  LineY2)
SysDoLoop_S6
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
	pagesel	PSET_T6963
	call	PSET_T6963
	pagesel	$
;LineY1 += LineStepY
	banksel	LINESTEPY
	movf	LINESTEPY,W
	addwf	LINEY1,F
	movf	LINESTEPY_H,W
	addwfc	LINEY1_H,F
;if ( LineErr < 0) then
	movf	LINEERR,W
	movwf	SysINTEGERTempA
	movf	LINEERR_H,W
	movwf	SysINTEGERTempA_H
	clrf	SysINTEGERTempB
	clrf	SysINTEGERTempB_H
	banksel	STATUS
	pagesel	SysCompLessThanINT
	call	SysCompLessThanINT
	pagesel	$
	btfss	SysByteTempX,0
	goto	ELSE38_1
;LineErr += LineDiffX_x2
	banksel	LINEDIFFX_X2
	movf	LINEDIFFX_X2,W
	addwf	LINEERR,F
	movf	LINEDIFFX_X2_H,W
	addwfc	LINEERR_H,F
;else
	goto	ENDIF38
ELSE38_1
;LineErr += ( LineDiffX_x2 - LineDiffY_x2 )
	banksel	LINEDIFFY_X2
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
	addwf	LINEX1,F
	movf	LINESTEPX_H,W
	addwfc	LINEX1_H,F
;end if
ENDIF38
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
	pagesel	PSET_T6963
	call	PSET_T6963
	pagesel	$
;end if
ENDIF36
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
	goto	ENDIF105
;SysWordTempA = 0
	clrf	SYSWORDTEMPA
	clrf	SYSWORDTEMPA_H
;exit sub
	return
;end if
ENDIF105
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
	goto	ENDIF106
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	addwfc	SYSDIVMULTX_H,F
;End If
ENDIF106
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

StringTable1
	retlw	16
	retlw	87	;W
	retlw	71	;G
	retlw	50	;2
	retlw	52	;4
	retlw	48	;0
	retlw	54	;6
	retlw	52	;4
	retlw	65	;A
	retlw	45	;-
	retlw	84	;T
	retlw	77	;M
	retlw	73	;I
	retlw	45	;-
	retlw	84	;T
	retlw	90	;Z
	retlw	35	;#


StringTable2
	retlw	8
	retlw	70	;F
	retlw	101	;e
	retlw	98	;b
	retlw	32	; 
	retlw	50	;2
	retlw	48	;0
	retlw	49	;1
	retlw	57	;9


StringTable3
	retlw	29
	retlw	52	;4
	retlw	48	;0
	retlw	99	;c
	retlw	111	;o
	retlw	108	;l
	retlw	115	;s
	retlw	32	; 
	retlw	120	;x
	retlw	32	; 
	retlw	56	;8
	retlw	114	;r
	retlw	111	;o
	retlw	119	;w
	retlw	115	;s
	retlw	32	; 
	retlw	99	;c
	retlw	104	;h
	retlw	97	;a
	retlw	114	;r
	retlw	97	;a
	retlw	99	;c
	retlw	116	;t
	retlw	101	;e
	retlw	114	;r
	retlw	32	; 
	retlw	109	;m
	retlw	111	;o
	retlw	100	;d
	retlw	101	;e


StringTable4
	retlw	25
	retlw	77	;M
	retlw	105	;i
	retlw	120	;x
	retlw	101	;e
	retlw	100	;d
	retlw	32	; 
	retlw	109	;m
	retlw	111	;o
	retlw	100	;d
	retlw	101	;e
	retlw	32	; 
	retlw	76	;L
	retlw	67	;C
	retlw	68	;D
	retlw	32	; 
	retlw	97	;a
	retlw	110	;n
	retlw	100	;d
	retlw	32	; 
	retlw	71	;G
	retlw	76	;L
	retlw	67	;C
	retlw	68	;D
	retlw	33	;!
	retlw	33	;!


StringTable5
	retlw	7
	retlw	65	;A
	retlw	110	;n
	retlw	111	;o
	retlw	98	;b
	retlw	105	;i
	retlw	117	;u
	retlw	109	;m


StringTable6
	retlw	14
	retlw	76	;L
	retlw	67	;C
	retlw	68	;D
	retlw	32	; 
	retlw	67	;C
	retlw	97	;a
	retlw	112	;p
	retlw	97	;a
	retlw	98	;b
	retlw	105	;i
	retlw	108	;l
	retlw	105	;i
	retlw	116	;t
	retlw	121	;y


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
	retlw	86	;V
	retlw	101	;e
	retlw	114	;r
	retlw	115	;s
	retlw	105	;i
	retlw	111	;o
	retlw	110	;n
	retlw	32	; 
	retlw	48	;0
	retlw	120	;x


StringTable9
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


StringTable10
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


StringTable11
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


StringTable12
	retlw	8
	retlw	70	;F
	retlw	76	;L
	retlw	65	;A
	retlw	83	;S
	retlw	72	;H
	retlw	32	; 
	retlw	79	;O
	retlw	78	;N


StringTable13
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


StringTable14
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


StringTable15
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


StringTable16
	retlw	8
	retlw	70	;F
	retlw	108	;l
	retlw	97	;a
	retlw	115	;s
	retlw	104	;h
	retlw	105	;i
	retlw	110	;n
	retlw	103	;g


StringTable17
	retlw	7
	retlw	68	;D
	retlw	105	;i
	retlw	115	;s
	retlw	112	;p
	retlw	108	;l
	retlw	97	;a
	retlw	121	;y


StringTable18
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


StringTable19
	retlw	9
	retlw	70	;F
	retlw	79	;O
	retlw	82	;R
	retlw	32	; 
	retlw	50	;2
	retlw	32	; 
	retlw	83	;S
	retlw	69	;E
	retlw	67	;C


StringTable20
	retlw	36
	retlw	80	;P
	retlw	117	;u
	retlw	116	;t
	retlw	32	; 
	retlw	40	;(
	retlw	32	; 
	retlw	114	;r
	retlw	111	;o
	retlw	119	;w
	retlw	44	;,
	retlw	32	; 
	retlw	99	;c
	retlw	111	;o
	retlw	108	;l
	retlw	117	;u
	retlw	109	;m
	retlw	110	;n
	retlw	44	;,
	retlw	32	; 
	retlw	97	;a
	retlw	115	;s
	retlw	99	;c
	retlw	105	;i
	retlw	105	;i
	retlw	32	; 
	retlw	99	;c
	retlw	104	;h
	retlw	97	;a
	retlw	114	;r
	retlw	97	;a
	retlw	99	;c
	retlw	116	;t
	retlw	101	;e
	retlw	114	;r
	retlw	32	; 
	retlw	41	;)


StringTable21
	retlw	1
	retlw	42	;*


StringTable22
	retlw	8
	retlw	69	;E
	retlw	78	;N
	retlw	68	;D
	retlw	32	; 
	retlw	84	;T
	retlw	69	;E
	retlw	83	;S
	retlw	84	;T


StringTable23
	retlw	15
	retlw	71	;G
	retlw	76	;L
	retlw	67	;C
	retlw	68	;D
	retlw	32	; 
	retlw	67	;C
	retlw	97	;a
	retlw	112	;p
	retlw	97	;a
	retlw	98	;b
	retlw	105	;i
	retlw	108	;l
	retlw	105	;i
	retlw	116	;t
	retlw	121	;y


StringTable24
	retlw	21
	retlw	50	;2
	retlw	52	;4
	retlw	48	;0
	retlw	32	; 
	retlw	42	;*
	retlw	32	; 
	retlw	54	;6
	retlw	52	;4
	retlw	32	; 
	retlw	32	; 
	retlw	112	;p
	retlw	105	;i
	retlw	120	;x
	retlw	101	;e
	retlw	108	;l
	retlw	115	;s
	retlw	32	; 
	retlw	109	;m
	retlw	111	;o
	retlw	100	;d
	retlw	101	;e


StringTable25
	retlw	21
	retlw	70	;F
	retlw	117	;u
	retlw	108	;l
	retlw	108	;l
	retlw	32	; 
	retlw	71	;G
	retlw	67	;C
	retlw	66	;B
	retlw	32	; 
	retlw	71	;G
	retlw	76	;L
	retlw	67	;C
	retlw	68	;D
	retlw	32	; 
	retlw	99	;c
	retlw	97	;a
	retlw	112	;p
	retlw	97	;a
	retlw	98	;b
	retlw	108	;l
	retlw	101	;e


StringTable26
	retlw	8
	retlw	80	;P
	retlw	114	;r
	retlw	105	;i
	retlw	110	;n
	retlw	116	;t
	retlw	83	;S
	retlw	116	;t
	retlw	114	;r


StringTable27
	retlw	4
	retlw	76	;L
	retlw	65	;A
	retlw	84	;T
	retlw	64	;


StringTable28
	retlw	3
	retlw	77	;M
	retlw	104	;h
	retlw	122	;z


StringTable29
	retlw	7
	retlw	68	;D
	retlw	114	;r
	retlw	97	;a
	retlw	119	;w
	retlw	83	;S
	retlw	116	;t
	retlw	114	;r


StringTable30
	retlw	1
	retlw	104	;h


StringTable31
	retlw	11
	retlw	65	;A
	retlw	110	;n
	retlw	111	;o
	retlw	98	;b
	retlw	105	;i
	retlw	117	;u
	retlw	109	;m
	retlw	32	; 
	retlw	58	;:
	retlw	45	;-
	retlw	41	;)


StringTable65
	retlw	1
	retlw	32	; 


StringTable67
	retlw	1
	retlw	48	;0


StringTable90
	retlw	0


;********************************************************************************

;Start of program memory page 2
	ORG	4096
BIGFONT42_51
	movlw	240
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableBIGFONT42_51
	movwf	SysStringA
	movlw	(high TableBIGFONT42_51) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableBIGFONT42_51
	retlw	240
	retlw	128
	retlw	136
	retlw	144
	retlw	224
	retlw	224
	retlw	252
	retlw	252
	retlw	224
	retlw	224
	retlw	144
	retlw	136
	retlw	128
	retlw	1
	retlw	17
	retlw	9
	retlw	7
	retlw	7
	retlw	63
	retlw	63
	retlw	7
	retlw	7
	retlw	9
	retlw	17
	retlw	1
	retlw	0
	retlw	0
	retlw	128
	retlw	128
	retlw	128
	retlw	240
	retlw	240
	retlw	128
	retlw	128
	retlw	128
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	1
	retlw	1
	retlw	15
	retlw	15
	retlw	1
	retlw	1
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
	retlw	64
	retlw	120
	retlw	120
	retlw	56
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	128
	retlw	128
	retlw	128
	retlw	128
	retlw	128
	retlw	128
	retlw	128
	retlw	128
	retlw	128
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
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	56
	retlw	56
	retlw	56
	retlw	0
	retlw	0
	retlw	0
	retlw	0
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
	retlw	192
	retlw	224
	retlw	112
	retlw	56
	retlw	0
	retlw	32
	retlw	48
	retlw	56
	retlw	28
	retlw	14
	retlw	7
	retlw	3
	retlw	1
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	252
	retlw	252
	retlw	4
	retlw	4
	retlw	4
	retlw	4
	retlw	252
	retlw	252
	retlw	248
	retlw	0
	retlw	0
	retlw	31
	retlw	63
	retlw	63
	retlw	32
	retlw	32
	retlw	32
	retlw	32
	retlw	63
	retlw	63
	retlw	31
	retlw	0
	retlw	0
	retlw	96
	retlw	96
	retlw	96
	retlw	240
	retlw	252
	retlw	252
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	32
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	32
	retlw	32
	retlw	32
	retlw	0
	retlw	0
	retlw	0
	retlw	24
	retlw	28
	retlw	28
	retlw	4
	retlw	4
	retlw	132
	retlw	204
	retlw	252
	retlw	120
	retlw	48
	retlw	0
	retlw	0
	retlw	48
	retlw	56
	retlw	60
	retlw	46
	retlw	39
	retlw	35
	retlw	33
	retlw	56
	retlw	56
	retlw	56
	retlw	0
	retlw	0
	retlw	24
	retlw	28
	retlw	28
	retlw	132
	retlw	132
	retlw	132
	retlw	204
	retlw	124
	retlw	120
	retlw	48
	retlw	0
	retlw	0
	retlw	24
	retlw	56
	retlw	56
	retlw	36
	retlw	33
	retlw	33
	retlw	51
	retlw	62
	retlw	30
	retlw	12

;********************************************************************************

BIGFONT52_61
	movlw	241
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableBIGFONT52_61
	movwf	SysStringA
	movlw	(high TableBIGFONT52_61) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableBIGFONT52_61
	retlw	240
	retlw	0
	retlw	128
	retlw	192
	retlw	96
	retlw	48
	retlw	24
	retlw	252
	retlw	252
	retlw	252
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	3
	retlw	3
	retlw	3
	retlw	35
	retlw	35
	retlw	63
	retlw	63
	retlw	63
	retlw	35
	retlw	35
	retlw	0
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	132
	retlw	132
	retlw	132
	retlw	132
	retlw	132
	retlw	4
	retlw	4
	retlw	0
	retlw	0
	retlw	25
	retlw	57
	retlw	57
	retlw	36
	retlw	33
	retlw	33
	retlw	51
	retlw	63
	retlw	31
	retlw	14
	retlw	0
	retlw	0
	retlw	224
	retlw	240
	retlw	248
	retlw	156
	retlw	140
	retlw	132
	retlw	132
	retlw	132
	retlw	128
	retlw	0
	retlw	0
	retlw	0
	retlw	31
	retlw	63
	retlw	63
	retlw	36
	retlw	36
	retlw	33
	retlw	33
	retlw	63
	retlw	63
	retlw	31
	retlw	0
	retlw	0
	retlw	60
	retlw	60
	retlw	60
	retlw	4
	retlw	4
	retlw	4
	retlw	4
	retlw	132
	retlw	252
	retlw	252
	retlw	124
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	56
	retlw	60
	retlw	62
	retlw	7
	retlw	3
	retlw	1
	retlw	0
	retlw	0
	retlw	0
	retlw	120
	retlw	124
	retlw	252
	retlw	196
	retlw	196
	retlw	132
	retlw	132
	retlw	252
	retlw	124
	retlw	120
	retlw	0
	retlw	0
	retlw	30
	retlw	62
	retlw	63
	retlw	33
	retlw	33
	retlw	35
	retlw	35
	retlw	63
	retlw	62
	retlw	30
	retlw	0
	retlw	0
	retlw	248
	retlw	252
	retlw	252
	retlw	132
	retlw	132
	retlw	132
	retlw	132
	retlw	252
	retlw	252
	retlw	248
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	36
	retlw	33
	retlw	33
	retlw	49
	retlw	57
	retlw	31
	retlw	15
	retlw	7
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	112
	retlw	112
	retlw	112
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	14
	retlw	14
	retlw	14
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	112
	retlw	112
	retlw	112
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	16
	retlw	30
	retlw	30
	retlw	14
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	192
	retlw	224
	retlw	112
	retlw	56
	retlw	28
	retlw	14
	retlw	6
	retlw	2
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	3
	retlw	7
	retlw	14
	retlw	28
	retlw	56
	retlw	112
	retlw	96
	retlw	64
	retlw	0
	retlw	0
	retlw	96
	retlw	96
	retlw	96
	retlw	96
	retlw	96
	retlw	96
	retlw	96
	retlw	96
	retlw	96
	retlw	96
	retlw	96
	retlw	96
	retlw	6
	retlw	6
	retlw	6
	retlw	6
	retlw	6
	retlw	6
	retlw	6
	retlw	6
	retlw	6
	retlw	6
	retlw	6
	retlw	6

;********************************************************************************

BIGFONT72_81
	movlw	241
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableBIGFONT72_81
	movwf	SysStringA
	movlw	(high TableBIGFONT72_81) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableBIGFONT72_81
	retlw	240
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	128
	retlw	128
	retlw	128
	retlw	252
	retlw	252
	retlw	252
	retlw	0
	retlw	0
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	1
	retlw	1
	retlw	1
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	4
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	4
	retlw	4
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	32
	retlw	32
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	4
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	4
	retlw	4
	retlw	30
	retlw	30
	retlw	62
	retlw	32
	retlw	32
	retlw	32
	retlw	32
	retlw	63
	retlw	63
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	192
	retlw	224
	retlw	112
	retlw	60
	retlw	28
	retlw	12
	retlw	0
	retlw	0
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	3
	retlw	7
	retlw	14
	retlw	60
	retlw	56
	retlw	48
	retlw	0
	retlw	0
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	4
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	32
	retlw	32
	retlw	32
	retlw	48
	retlw	56
	retlw	60
	retlw	0
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	120
	retlw	240
	retlw	224
	retlw	240
	retlw	120
	retlw	252
	retlw	252
	retlw	252
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	1
	retlw	0
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	112
	retlw	224
	retlw	192
	retlw	128
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	1
	retlw	3
	retlw	7
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	224
	retlw	240
	retlw	248
	retlw	28
	retlw	12
	retlw	12
	retlw	12
	retlw	28
	retlw	248
	retlw	240
	retlw	224
	retlw	0
	retlw	7
	retlw	15
	retlw	31
	retlw	56
	retlw	48
	retlw	48
	retlw	48
	retlw	56
	retlw	31
	retlw	15
	retlw	7
	retlw	0
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	132
	retlw	132
	retlw	132
	retlw	252
	retlw	252
	retlw	120
	retlw	0
	retlw	0
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	33
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	248
	retlw	248
	retlw	28
	retlw	12
	retlw	4
	retlw	12
	retlw	28
	retlw	248
	retlw	248
	retlw	224
	retlw	0
	retlw	7
	retlw	31
	retlw	31
	retlw	24
	retlw	24
	retlw	92
	retlw	94
	retlw	126
	retlw	127
	retlw	127
	retlw	71

;********************************************************************************

GLCDCHARCOL3EXTENDED1
	movlw	240
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableGLCDCHARCOL3EXTENDED1
	movwf	SysStringA
	movlw	(high TableGLCDCHARCOL3EXTENDED1) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableGLCDCHARCOL3EXTENDED1
	retlw	239
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
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	254
	retlw	254
	retlw	248
	retlw	254
	retlw	194
	retlw	254
	retlw	124
	retlw	0
	retlw	254
	retlw	248
	retlw	254
	retlw	254
	retlw	130
	retlw	124
	retlw	254
	retlw	254
	retlw	0
	retlw	198
	retlw	2
	retlw	14
	retlw	56
	retlw	198
	retlw	14
	retlw	188
	retlw	0
	retlw	0
	retlw	56
	retlw	40
	retlw	124
	retlw	0
	retlw	0
	retlw	56
	retlw	254
	retlw	4
	retlw	48
	retlw	40
	retlw	1
	retlw	124
	retlw	48
	retlw	0
	retlw	124
	retlw	64
	retlw	252
	retlw	28
	retlw	0
	retlw	56
	retlw	4
	retlw	248
	retlw	24
	retlw	56
	retlw	4
	retlw	60
	retlw	56
	retlw	68
	retlw	60
	retlw	60
	retlw	0
	retlw	60
	retlw	56
	retlw	60
	retlw	60

;********************************************************************************

GLCDCHARCOL4EXTENDED1
	movlw	240
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableGLCDCHARCOL4EXTENDED1
	movwf	SysStringA
	movlw	(high TableGLCDCHARCOL4EXTENDED1) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableGLCDCHARCOL4EXTENDED1
	retlw	239
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
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	36
	retlw	146
	retlw	2
	retlw	132
	retlw	146
	retlw	162
	retlw	16
	retlw	146
	retlw	130
	retlw	16
	retlw	4
	retlw	4
	retlw	8
	retlw	146
	retlw	130
	retlw	2
	retlw	18
	retlw	0
	retlw	170
	retlw	2
	retlw	16
	retlw	68
	retlw	40
	retlw	16
	retlw	194
	retlw	0
	retlw	0
	retlw	68
	retlw	84
	retlw	8
	retlw	0
	retlw	0
	retlw	68
	retlw	73
	retlw	104
	retlw	73
	retlw	84
	retlw	25
	retlw	8
	retlw	74
	retlw	0
	retlw	16
	retlw	50
	retlw	64
	retlw	32
	retlw	1
	retlw	68
	retlw	124
	retlw	36
	retlw	36
	retlw	68
	retlw	4
	retlw	64
	retlw	68
	retlw	40
	retlw	64
	retlw	64
	retlw	1
	retlw	65
	retlw	68
	retlw	64
	retlw	64

;********************************************************************************

GLCDCHARCOL5EXTENDED1
	movlw	240
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableGLCDCHARCOL5EXTENDED1
	movwf	SysStringA
	movlw	(high TableGLCDCHARCOL5EXTENDED1) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableGLCDCHARCOL5EXTENDED1
	retlw	239
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
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	34
	retlw	146
	retlw	2
	retlw	130
	retlw	146
	retlw	146
	retlw	16
	retlw	146
	retlw	254
	retlw	40
	retlw	2
	retlw	24
	retlw	16
	retlw	146
	retlw	130
	retlw	2
	retlw	18
	retlw	0
	retlw	146
	retlw	254
	retlw	224
	retlw	254
	retlw	16
	retlw	254
	retlw	2
	retlw	0
	retlw	0
	retlw	69
	retlw	84
	retlw	5
	retlw	61
	retlw	0
	retlw	68
	retlw	73
	retlw	144
	retlw	75
	retlw	84
	retlw	165
	retlw	4
	retlw	77
	retlw	60
	retlw	40
	retlw	9
	retlw	64
	retlw	64
	retlw	149
	retlw	68
	retlw	4
	retlw	36
	retlw	164
	retlw	68
	retlw	124
	retlw	64
	retlw	254
	retlw	16
	retlw	248
	retlw	56
	retlw	60
	retlw	64
	retlw	69
	retlw	66
	retlw	58

;********************************************************************************

GLCDCHARCOL6EXTENDED1
	movlw	240
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableGLCDCHARCOL6EXTENDED1
	movwf	SysStringA
	movlw	(high TableGLCDCHARCOL6EXTENDED1) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableGLCDCHARCOL6EXTENDED1
	retlw	239
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
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	36
	retlw	146
	retlw	2
	retlw	132
	retlw	146
	retlw	138
	retlw	16
	retlw	146
	retlw	130
	retlw	68
	retlw	4
	retlw	4
	retlw	32
	retlw	146
	retlw	130
	retlw	2
	retlw	18
	retlw	0
	retlw	130
	retlw	2
	retlw	16
	retlw	68
	retlw	40
	retlw	16
	retlw	194
	retlw	0
	retlw	0
	retlw	56
	retlw	85
	retlw	4
	retlw	64
	retlw	0
	retlw	56
	retlw	78
	retlw	104
	retlw	77
	retlw	84
	retlw	67
	retlw	4
	retlw	73
	retlw	64
	retlw	68
	retlw	9
	retlw	32
	retlw	32
	retlw	171
	retlw	68
	retlw	124
	retlw	36
	retlw	164
	retlw	76
	retlw	4
	retlw	64
	retlw	68
	retlw	40
	retlw	64
	retlw	64
	retlw	65
	retlw	65
	retlw	68
	retlw	65
	retlw	65

;********************************************************************************

GLCDCHARCOL7EXTENDED1
	movlw	240
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableGLCDCHARCOL7EXTENDED1
	movwf	SysStringA
	movlw	(high TableGLCDCHARCOL7EXTENDED1) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableGLCDCHARCOL7EXTENDED1
	retlw	239
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
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	108
	retlw	2
	retlw	248
	retlw	130
	retlw	134
	retlw	254
	retlw	124
	retlw	0
	retlw	130
	retlw	248
	retlw	254
	retlw	254
	retlw	130
	retlw	124
	retlw	254
	retlw	12
	retlw	0
	retlw	130
	retlw	2
	retlw	14
	retlw	56
	retlw	198
	retlw	14
	retlw	188
	retlw	0
	retlw	0
	retlw	68
	retlw	68
	retlw	120
	retlw	32
	retlw	0
	retlw	68
	retlw	48
	retlw	4
	retlw	49
	retlw	68
	retlw	1
	retlw	120
	retlw	62
	retlw	32
	retlw	0
	retlw	126
	retlw	124
	retlw	28
	retlw	65
	retlw	56
	retlw	4
	retlw	24
	retlw	72
	retlw	52
	retlw	4
	retlw	60
	retlw	56
	retlw	68
	retlw	60
	retlw	60
	retlw	32
	retlw	60
	retlw	56
	retlw	60
	retlw	60

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

;Start of program memory page 3
	ORG	6144
BIGFONT102_111
	movlw	239
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableBIGFONT102_111
	movwf	SysStringA
	movlw	(high TableBIGFONT102_111) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableBIGFONT102_111
	retlw	240
	retlw	0
	retlw	128
	retlw	128
	retlw	248
	retlw	252
	retlw	252
	retlw	132
	retlw	156
	retlw	156
	retlw	24
	retlw	0
	retlw	0
	retlw	0
	retlw	33
	retlw	33
	retlw	63
	retlw	63
	retlw	63
	retlw	33
	retlw	33
	retlw	1
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	192
	retlw	192
	retlw	64
	retlw	64
	retlw	64
	retlw	192
	retlw	128
	retlw	192
	retlw	64
	retlw	0
	retlw	0
	retlw	71
	retlw	207
	retlw	223
	retlw	152
	retlw	152
	retlw	152
	retlw	255
	retlw	255
	retlw	127
	retlw	0
	retlw	0
	retlw	0
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	128
	retlw	64
	retlw	64
	retlw	192
	retlw	192
	retlw	128
	retlw	0
	retlw	0
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	1
	retlw	0
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	0
	retlw	64
	retlw	64
	retlw	64
	retlw	220
	retlw	220
	retlw	220
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	32
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	32
	retlw	32
	retlw	32
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	64
	retlw	64
	retlw	64
	retlw	220
	retlw	220
	retlw	220
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	96
	retlw	224
	retlw	128
	retlw	128
	retlw	192
	retlw	255
	retlw	255
	retlw	127
	retlw	0
	retlw	0
	retlw	0
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	0
	retlw	0
	retlw	128
	retlw	192
	retlw	192
	retlw	64
	retlw	0
	retlw	0
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	2
	retlw	7
	retlw	15
	retlw	61
	retlw	56
	retlw	48
	retlw	0
	retlw	0
	retlw	0
	retlw	4
	retlw	4
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	32
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	32
	retlw	32
	retlw	32
	retlw	0
	retlw	0
	retlw	192
	retlw	192
	retlw	192
	retlw	64
	retlw	64
	retlw	192
	retlw	64
	retlw	64
	retlw	192
	retlw	192
	retlw	128
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	63
	retlw	0
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	192
	retlw	192
	retlw	192
	retlw	64
	retlw	64
	retlw	64
	retlw	192
	retlw	192
	retlw	128
	retlw	0
	retlw	0
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	192
	retlw	192
	retlw	64
	retlw	64
	retlw	64
	retlw	192
	retlw	192
	retlw	128
	retlw	0
	retlw	0
	retlw	0
	retlw	31
	retlw	63
	retlw	63
	retlw	32
	retlw	32
	retlw	32
	retlw	63
	retlw	63
	retlw	31

;********************************************************************************

BIGFONT112_121
	movlw	240
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableBIGFONT112_121
	movwf	SysStringA
	movlw	(high TableBIGFONT112_121) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableBIGFONT112_121
	retlw	240
	retlw	0
	retlw	64
	retlw	192
	retlw	128
	retlw	192
	retlw	64
	retlw	64
	retlw	64
	retlw	192
	retlw	192
	retlw	128
	retlw	0
	retlw	0
	retlw	128
	retlw	255
	retlw	255
	retlw	255
	retlw	144
	retlw	16
	retlw	16
	retlw	31
	retlw	31
	retlw	15
	retlw	0
	retlw	128
	retlw	192
	retlw	192
	retlw	64
	retlw	64
	retlw	64
	retlw	192
	retlw	128
	retlw	192
	retlw	64
	retlw	0
	retlw	0
	retlw	15
	retlw	31
	retlw	31
	retlw	16
	retlw	16
	retlw	144
	retlw	255
	retlw	255
	retlw	255
	retlw	128
	retlw	0
	retlw	0
	retlw	0
	retlw	64
	retlw	192
	retlw	192
	retlw	192
	retlw	128
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	128
	retlw	0
	retlw	0
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	33
	retlw	0
	retlw	0
	retlw	1
	retlw	1
	retlw	1
	retlw	0
	retlw	0
	retlw	128
	retlw	192
	retlw	192
	retlw	64
	retlw	64
	retlw	64
	retlw	64
	retlw	192
	retlw	128
	retlw	0
	retlw	0
	retlw	0
	retlw	25
	retlw	59
	retlw	35
	retlw	38
	retlw	38
	retlw	38
	retlw	60
	retlw	61
	retlw	25
	retlw	0
	retlw	0
	retlw	0
	retlw	64
	retlw	64
	retlw	224
	retlw	240
	retlw	248
	retlw	64
	retlw	64
	retlw	64
	retlw	64
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	31
	retlw	63
	retlw	63
	retlw	32
	retlw	56
	retlw	56
	retlw	24
	retlw	0
	retlw	0
	retlw	0
	retlw	192
	retlw	192
	retlw	192
	retlw	0
	retlw	0
	retlw	0
	retlw	192
	retlw	192
	retlw	192
	retlw	0
	retlw	0
	retlw	0
	retlw	31
	retlw	63
	retlw	63
	retlw	32
	retlw	32
	retlw	32
	retlw	63
	retlw	31
	retlw	63
	retlw	32
	retlw	0
	retlw	0
	retlw	192
	retlw	192
	retlw	192
	retlw	0
	retlw	0
	retlw	0
	retlw	192
	retlw	192
	retlw	192
	retlw	0
	retlw	0
	retlw	0
	retlw	7
	retlw	15
	retlw	31
	retlw	56
	retlw	48
	retlw	56
	retlw	31
	retlw	15
	retlw	7
	retlw	0
	retlw	0
	retlw	0
	retlw	192
	retlw	192
	retlw	192
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	192
	retlw	192
	retlw	192
	retlw	0
	retlw	7
	retlw	15
	retlw	63
	retlw	56
	retlw	56
	retlw	14
	retlw	56
	retlw	56
	retlw	63
	retlw	15
	retlw	7
	retlw	0
	retlw	192
	retlw	192
	retlw	192
	retlw	0
	retlw	0
	retlw	192
	retlw	192
	retlw	192
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	48
	retlw	57
	retlw	63
	retlw	15
	retlw	15
	retlw	63
	retlw	57
	retlw	48
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	192
	retlw	192
	retlw	192
	retlw	0
	retlw	0
	retlw	0
	retlw	192
	retlw	192
	retlw	192
	retlw	0
	retlw	0
	retlw	128
	retlw	135
	retlw	143
	retlw	159
	retlw	216
	retlw	248
	retlw	120
	retlw	63
	retlw	15
	retlw	7

;********************************************************************************

BIGFONT193_202
	movlw	240
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableBIGFONT193_202
	movwf	SysStringA
	movlw	(high TableBIGFONT193_202) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableBIGFONT193_202
	retlw	240
	retlw	0
	retlw	224
	retlw	240
	retlw	248
	retlw	28
	retlw	12
	retlw	12
	retlw	28
	retlw	248
	retlw	240
	retlw	224
	retlw	0
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	2
	retlw	2
	retlw	2
	retlw	2
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	132
	retlw	132
	retlw	132
	retlw	252
	retlw	252
	retlw	120
	retlw	0
	retlw	0
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	36
	retlw	36
	retlw	36
	retlw	63
	retlw	63
	retlw	30
	retlw	0
	retlw	0
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	12
	retlw	12
	retlw	12
	retlw	12
	retlw	12
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	240
	retlw	248
	retlw	28
	retlw	12
	retlw	12
	retlw	28
	retlw	248
	retlw	240
	retlw	224
	retlw	0
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	48
	retlw	48
	retlw	48
	retlw	48
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	132
	retlw	132
	retlw	132
	retlw	196
	retlw	204
	retlw	28
	retlw	0
	retlw	0
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	36
	retlw	36
	retlw	36
	retlw	35
	retlw	51
	retlw	56
	retlw	0
	retlw	0
	retlw	60
	retlw	28
	retlw	12
	retlw	4
	retlw	132
	retlw	196
	retlw	228
	retlw	124
	retlw	60
	retlw	28
	retlw	0
	retlw	0
	retlw	56
	retlw	60
	retlw	62
	retlw	39
	retlw	35
	retlw	36
	retlw	32
	retlw	48
	retlw	56
	retlw	60
	retlw	0
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	128
	retlw	128
	retlw	128
	retlw	252
	retlw	252
	retlw	252
	retlw	0
	retlw	0
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	1
	retlw	1
	retlw	1
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	240
	retlw	248
	retlw	156
	retlw	140
	retlw	140
	retlw	140
	retlw	156
	retlw	248
	retlw	240
	retlw	224
	retlw	0
	retlw	7
	retlw	15
	retlw	31
	retlw	57
	retlw	49
	retlw	49
	retlw	49
	retlw	57
	retlw	31
	retlw	15
	retlw	7
	retlw	0
	retlw	0
	retlw	4
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	4
	retlw	4
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	32
	retlw	32
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	192
	retlw	224
	retlw	112
	retlw	60
	retlw	28
	retlw	12
	retlw	0
	retlw	0
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	3
	retlw	7
	retlw	14
	retlw	60
	retlw	56
	retlw	48

;********************************************************************************

BIGFONT203_212
	movlw	238
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableBIGFONT203_212
	movwf	SysStringA
	movlw	(high TableBIGFONT203_212) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableBIGFONT203_212
	retlw	240
	retlw	0
	retlw	224
	retlw	240
	retlw	248
	retlw	28
	retlw	12
	retlw	12
	retlw	28
	retlw	248
	retlw	240
	retlw	224
	retlw	0
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	120
	retlw	240
	retlw	224
	retlw	240
	retlw	120
	retlw	252
	retlw	252
	retlw	252
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	1
	retlw	0
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	112
	retlw	224
	retlw	192
	retlw	128
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	1
	retlw	3
	retlw	7
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	28
	retlw	28
	retlw	156
	retlw	156
	retlw	156
	retlw	156
	retlw	156
	retlw	28
	retlw	28
	retlw	0
	retlw	0
	retlw	0
	retlw	56
	retlw	56
	retlw	57
	retlw	57
	retlw	57
	retlw	57
	retlw	57
	retlw	56
	retlw	56
	retlw	0
	retlw	0
	retlw	224
	retlw	240
	retlw	248
	retlw	28
	retlw	12
	retlw	12
	retlw	12
	retlw	28
	retlw	248
	retlw	240
	retlw	224
	retlw	0
	retlw	7
	retlw	15
	retlw	31
	retlw	56
	retlw	48
	retlw	48
	retlw	48
	retlw	56
	retlw	31
	retlw	15
	retlw	7
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	28
	retlw	28
	retlw	28
	retlw	28
	retlw	252
	retlw	252
	retlw	252
	retlw	0
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	132
	retlw	132
	retlw	132
	retlw	252
	retlw	252
	retlw	120
	retlw	0
	retlw	0
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	36
	retlw	1
	retlw	1
	retlw	1
	retlw	1
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	60
	retlw	124
	retlw	252
	retlw	220
	retlw	156
	retlw	156
	retlw	28
	retlw	28
	retlw	28
	retlw	0
	retlw	0
	retlw	0
	retlw	60
	retlw	62
	retlw	63
	retlw	59
	retlw	57
	retlw	57
	retlw	56
	retlw	56
	retlw	56
	retlw	0
	retlw	0
	retlw	28
	retlw	12
	retlw	4
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	4
	retlw	4
	retlw	12
	retlw	28
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	32
	retlw	32
	retlw	0
	retlw	0
	retlw	0
	retlw	124
	retlw	252
	retlw	252
	retlw	128
	retlw	0
	retlw	128
	retlw	252
	retlw	252
	retlw	124
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	36
	retlw	63
	retlw	63
	retlw	63
	retlw	36
	retlw	32

;********************************************************************************

BIGFONT32_41
	movlw	239
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableBIGFONT32_41
	movwf	SysStringA
	movlw	(high TableBIGFONT32_41) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableBIGFONT32_41
	retlw	240
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	248
	retlw	252
	retlw	252
	retlw	252
	retlw	248
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	115
	retlw	115
	retlw	115
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	30
	retlw	62
	retlw	62
	retlw	0
	retlw	0
	retlw	0
	retlw	62
	retlw	62
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
	retlw	48
	retlw	48
	retlw	254
	retlw	254
	retlw	48
	retlw	48
	retlw	48
	retlw	48
	retlw	254
	retlw	254
	retlw	48
	retlw	48
	retlw	12
	retlw	12
	retlw	127
	retlw	127
	retlw	12
	retlw	12
	retlw	12
	retlw	12
	retlw	127
	retlw	127
	retlw	12
	retlw	12
	retlw	0
	retlw	240
	retlw	248
	retlw	152
	retlw	254
	retlw	152
	retlw	152
	retlw	254
	retlw	152
	retlw	152
	retlw	24
	retlw	0
	retlw	0
	retlw	24
	retlw	25
	retlw	25
	retlw	127
	retlw	25
	retlw	25
	retlw	127
	retlw	25
	retlw	31
	retlw	15
	retlw	0
	retlw	0
	retlw	0
	retlw	56
	retlw	56
	retlw	56
	retlw	128
	retlw	192
	retlw	224
	retlw	112
	retlw	56
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	28
	retlw	14
	retlw	7
	retlw	3
	retlw	1
	retlw	28
	retlw	28
	retlw	28
	retlw	0
	retlw	0
	retlw	0
	retlw	56
	retlw	252
	retlw	196
	retlw	196
	retlw	252
	retlw	56
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	0
	retlw	0
	retlw	30
	retlw	63
	retlw	33
	retlw	33
	retlw	51
	retlw	63
	retlw	30
	retlw	30
	retlw	55
	retlw	35
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	60
	retlw	60
	retlw	28
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
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
	retlw	224
	retlw	240
	retlw	56
	retlw	28
	retlw	12
	retlw	4
	retlw	4
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	3
	retlw	7
	retlw	15
	retlw	28
	retlw	56
	retlw	48
	retlw	32
	retlw	32
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	4
	retlw	4
	retlw	12
	retlw	28
	retlw	56
	retlw	240
	retlw	224
	retlw	192
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	32
	retlw	48
	retlw	56
	retlw	28
	retlw	15
	retlw	7
	retlw	3

;********************************************************************************

BIGFONT62_71
	movlw	240
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableBIGFONT62_71
	movwf	SysStringA
	movlw	(high TableBIGFONT62_71) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableBIGFONT62_71
	retlw	240
	retlw	0
	retlw	2
	retlw	6
	retlw	14
	retlw	28
	retlw	56
	retlw	112
	retlw	224
	retlw	192
	retlw	128
	retlw	0
	retlw	0
	retlw	0
	retlw	64
	retlw	96
	retlw	112
	retlw	56
	retlw	28
	retlw	14
	retlw	7
	retlw	3
	retlw	1
	retlw	0
	retlw	0
	retlw	0
	retlw	24
	retlw	28
	retlw	12
	retlw	14
	retlw	6
	retlw	134
	retlw	206
	retlw	252
	retlw	124
	retlw	56
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	115
	retlw	115
	retlw	115
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	252
	retlw	254
	retlw	254
	retlw	2
	retlw	2
	retlw	194
	retlw	194
	retlw	194
	retlw	254
	retlw	254
	retlw	252
	retlw	0
	retlw	63
	retlw	63
	retlw	127
	retlw	96
	retlw	96
	retlw	99
	retlw	99
	retlw	99
	retlw	99
	retlw	67
	retlw	3
	retlw	0
	retlw	224
	retlw	240
	retlw	248
	retlw	28
	retlw	12
	retlw	12
	retlw	28
	retlw	248
	retlw	240
	retlw	224
	retlw	0
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	2
	retlw	2
	retlw	2
	retlw	2
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	132
	retlw	132
	retlw	132
	retlw	252
	retlw	252
	retlw	120
	retlw	0
	retlw	0
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	36
	retlw	33
	retlw	33
	retlw	63
	retlw	63
	retlw	30
	retlw	0
	retlw	0
	retlw	240
	retlw	248
	retlw	252
	retlw	12
	retlw	4
	retlw	4
	retlw	4
	retlw	28
	retlw	28
	retlw	24
	retlw	0
	retlw	0
	retlw	15
	retlw	31
	retlw	63
	retlw	48
	retlw	32
	retlw	32
	retlw	32
	retlw	56
	retlw	56
	retlw	24
	retlw	0
	retlw	0
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	4
	retlw	4
	retlw	12
	retlw	252
	retlw	248
	retlw	240
	retlw	0
	retlw	0
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	32
	retlw	32
	retlw	48
	retlw	63
	retlw	31
	retlw	15
	retlw	0
	retlw	0
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	132
	retlw	132
	retlw	132
	retlw	196
	retlw	204
	retlw	28
	retlw	0
	retlw	0
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	36
	retlw	33
	retlw	33
	retlw	35
	retlw	51
	retlw	56
	retlw	0
	retlw	0
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	132
	retlw	132
	retlw	132
	retlw	196
	retlw	204
	retlw	28
	retlw	0
	retlw	0
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	33
	retlw	1
	retlw	1
	retlw	3
	retlw	3
	retlw	0
	retlw	0
	retlw	0
	retlw	240
	retlw	248
	retlw	252
	retlw	12
	retlw	4
	retlw	4
	retlw	4
	retlw	60
	retlw	60
	retlw	56
	retlw	0
	retlw	0
	retlw	15
	retlw	31
	retlw	63
	retlw	48
	retlw	32
	retlw	34
	retlw	34
	retlw	62
	retlw	62
	retlw	62

;********************************************************************************

BIGFONT82_91
	movlw	239
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableBIGFONT82_91
	movwf	SysStringA
	movlw	(high TableBIGFONT82_91) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableBIGFONT82_91
	retlw	240
	retlw	0
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	132
	retlw	132
	retlw	132
	retlw	252
	retlw	252
	retlw	120
	retlw	0
	retlw	0
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	1
	retlw	1
	retlw	3
	retlw	63
	retlw	63
	retlw	60
	retlw	0
	retlw	0
	retlw	120
	retlw	252
	retlw	252
	retlw	132
	retlw	132
	retlw	132
	retlw	132
	retlw	188
	retlw	60
	retlw	56
	retlw	0
	retlw	0
	retlw	28
	retlw	60
	retlw	61
	retlw	36
	retlw	36
	retlw	33
	retlw	33
	retlw	63
	retlw	63
	retlw	30
	retlw	0
	retlw	0
	retlw	28
	retlw	12
	retlw	4
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	4
	retlw	4
	retlw	12
	retlw	28
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	32
	retlw	32
	retlw	0
	retlw	0
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	0
	retlw	0
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	0
	retlw	0
	retlw	0
	retlw	31
	retlw	63
	retlw	63
	retlw	32
	retlw	32
	retlw	32
	retlw	63
	retlw	63
	retlw	31
	retlw	0
	retlw	0
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	0
	retlw	0
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	0
	retlw	0
	retlw	0
	retlw	7
	retlw	15
	retlw	31
	retlw	56
	retlw	48
	retlw	56
	retlw	31
	retlw	15
	retlw	7
	retlw	0
	retlw	0
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	0
	retlw	0
	retlw	128
	retlw	0
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	0
	retlw	3
	retlw	15
	retlw	63
	retlw	60
	retlw	60
	retlw	15
	retlw	60
	retlw	60
	retlw	63
	retlw	15
	retlw	3
	retlw	0
	retlw	28
	retlw	60
	retlw	124
	retlw	224
	retlw	192
	retlw	224
	retlw	124
	retlw	60
	retlw	28
	retlw	0
	retlw	0
	retlw	0
	retlw	56
	retlw	60
	retlw	62
	retlw	7
	retlw	3
	retlw	7
	retlw	62
	retlw	60
	retlw	56
	retlw	0
	retlw	0
	retlw	0
	retlw	124
	retlw	252
	retlw	252
	retlw	128
	retlw	0
	retlw	128
	retlw	252
	retlw	252
	retlw	124
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	33
	retlw	63
	retlw	63
	retlw	63
	retlw	33
	retlw	32
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	60
	retlw	28
	retlw	12
	retlw	4
	retlw	132
	retlw	196
	retlw	228
	retlw	124
	retlw	60
	retlw	28
	retlw	0
	retlw	0
	retlw	56
	retlw	60
	retlw	62
	retlw	39
	retlw	35
	retlw	33
	retlw	32
	retlw	48
	retlw	56
	retlw	60
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	4
	retlw	4
	retlw	4
	retlw	4
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	63
	retlw	63
	retlw	63
	retlw	32
	retlw	32
	retlw	32
	retlw	32

;********************************************************************************

BIGFONT92_101
	movlw	239
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableBIGFONT92_101
	movwf	SysStringA
	movlw	(high TableBIGFONT92_101) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableBIGFONT92_101
	retlw	240
	retlw	0
	retlw	28
	retlw	56
	retlw	112
	retlw	224
	retlw	192
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
	retlw	1
	retlw	3
	retlw	7
	retlw	14
	retlw	28
	retlw	24
	retlw	48
	retlw	0
	retlw	0
	retlw	0
	retlw	4
	retlw	4
	retlw	4
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	32
	retlw	32
	retlw	32
	retlw	63
	retlw	63
	retlw	63
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	48
	retlw	56
	retlw	28
	retlw	14
	retlw	14
	retlw	28
	retlw	56
	retlw	48
	retlw	32
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
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
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	192
	retlw	0
	retlw	12
	retlw	12
	retlw	60
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
	retlw	64
	retlw	64
	retlw	64
	retlw	64
	retlw	64
	retlw	192
	retlw	192
	retlw	128
	retlw	0
	retlw	0
	retlw	0
	retlw	28
	retlw	62
	retlw	62
	retlw	34
	retlw	34
	retlw	34
	retlw	63
	retlw	31
	retlw	63
	retlw	32
	retlw	0
	retlw	0
	retlw	4
	retlw	252
	retlw	252
	retlw	252
	retlw	64
	retlw	64
	retlw	64
	retlw	192
	retlw	192
	retlw	128
	retlw	0
	retlw	0
	retlw	32
	retlw	63
	retlw	31
	retlw	63
	retlw	32
	retlw	32
	retlw	32
	retlw	63
	retlw	63
	retlw	31
	retlw	0
	retlw	0
	retlw	128
	retlw	192
	retlw	192
	retlw	64
	retlw	64
	retlw	64
	retlw	192
	retlw	192
	retlw	128
	retlw	0
	retlw	0
	retlw	0
	retlw	31
	retlw	63
	retlw	63
	retlw	32
	retlw	32
	retlw	32
	retlw	57
	retlw	57
	retlw	25
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	192
	retlw	192
	retlw	64
	retlw	64
	retlw	68
	retlw	252
	retlw	252
	retlw	252
	retlw	4
	retlw	0
	retlw	0
	retlw	31
	retlw	63
	retlw	63
	retlw	32
	retlw	32
	retlw	32
	retlw	63
	retlw	31
	retlw	63
	retlw	32
	retlw	0
	retlw	0
	retlw	128
	retlw	192
	retlw	192
	retlw	64
	retlw	64
	retlw	64
	retlw	192
	retlw	192
	retlw	128
	retlw	0
	retlw	0
	retlw	0
	retlw	31
	retlw	63
	retlw	63
	retlw	34
	retlw	34
	retlw	34
	retlw	59
	retlw	59
	retlw	27

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
	goto	ENDIF102
	comf	SYSINTEGERTEMPA,F
	comf	SYSINTEGERTEMPA_H,F
	incf	SYSINTEGERTEMPA,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPA_H,F
ENDIF102
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
	btfss	SYSINTEGERTEMPB_H,7
	goto	ENDIF103
	comf	SYSINTEGERTEMPB,F
	comf	SYSINTEGERTEMPB_H,F
	incf	SYSINTEGERTEMPB,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPB_H,F
ENDIF103
;Call word multiply routine
;SysMultSub16
	pagesel	SYSMULTSUB16
	call	SYSMULTSUB16
	pagesel	$
;Negate result if necessary
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
	btfss	SYSSIGNBYTE,7
	goto	ENDIF104
	comf	SYSINTEGERTEMPX,F
	comf	SYSINTEGERTEMPX_H,F
	incf	SYSINTEGERTEMPX,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPX_H,F
ENDIF104
	return

;********************************************************************************

;Start of program memory page 4
	ORG	8192
BIGFONT122_126
	movlw	109
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableBIGFONT122_126
	movwf	SysStringA
	movlw	(high TableBIGFONT122_126) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableBIGFONT122_126
	retlw	120
	retlw	0
	retlw	192
	retlw	192
	retlw	64
	retlw	64
	retlw	64
	retlw	192
	retlw	192
	retlw	192
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	49
	retlw	56
	retlw	60
	retlw	46
	retlw	39
	retlw	35
	retlw	49
	retlw	56
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	128
	retlw	192
	retlw	120
	retlw	124
	retlw	60
	retlw	4
	retlw	4
	retlw	4
	retlw	4
	retlw	0
	retlw	0
	retlw	1
	retlw	1
	retlw	3
	retlw	30
	retlw	62
	retlw	60
	retlw	32
	retlw	32
	retlw	32
	retlw	32
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	254
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
	retlw	127
	retlw	127
	retlw	127
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	4
	retlw	4
	retlw	4
	retlw	4
	retlw	60
	retlw	124
	retlw	120
	retlw	192
	retlw	128
	retlw	128
	retlw	0
	retlw	0
	retlw	32
	retlw	32
	retlw	32
	retlw	32
	retlw	60
	retlw	62
	retlw	30
	retlw	3
	retlw	1
	retlw	1
	retlw	0
	retlw	56
	retlw	60
	retlw	60
	retlw	4
	retlw	12
	retlw	28
	retlw	56
	retlw	48
	retlw	32
	retlw	60
	retlw	60
	retlw	28

;********************************************************************************

BIGFONT213_216
	movlw	95
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableBIGFONT213_216
	movwf	SysStringA
	movlw	(high TableBIGFONT213_216) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableBIGFONT213_216
	retlw	96
	retlw	224
	retlw	240
	retlw	248
	retlw	56
	retlw	24
	retlw	252
	retlw	252
	retlw	24
	retlw	56
	retlw	248
	retlw	240
	retlw	224
	retlw	7
	retlw	15
	retlw	31
	retlw	28
	retlw	24
	retlw	63
	retlw	63
	retlw	24
	retlw	28
	retlw	31
	retlw	15
	retlw	7
	retlw	0
	retlw	28
	retlw	60
	retlw	124
	retlw	224
	retlw	192
	retlw	224
	retlw	124
	retlw	60
	retlw	28
	retlw	0
	retlw	0
	retlw	0
	retlw	56
	retlw	60
	retlw	62
	retlw	7
	retlw	3
	retlw	7
	retlw	62
	retlw	60
	retlw	56
	retlw	0
	retlw	0
	retlw	0
	retlw	252
	retlw	252
	retlw	252
	retlw	128
	retlw	248
	retlw	248
	retlw	248
	retlw	128
	retlw	252
	retlw	252
	retlw	252
	retlw	0
	retlw	0
	retlw	1
	retlw	3
	retlw	35
	retlw	63
	retlw	63
	retlw	63
	retlw	35
	retlw	3
	retlw	1
	retlw	0
	retlw	0
	retlw	0
	retlw	112
	retlw	252
	retlw	252
	retlw	140
	retlw	140
	retlw	140
	retlw	252
	retlw	252
	retlw	112
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	49
	retlw	51
	retlw	51
	retlw	51
	retlw	51
	retlw	51
	retlw	49

;********************************************************************************

BIGPRINT_ILI9486L
;Dim GLCDPrintLoc as word
;PrintLen = PrintData(0)
	banksel	SYSPRINTDATAHANDLER
	movf	SysPRINTDATAHandler,W
	movwf	AFSR0
	movf	SysPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	PRINTLEN
;If PrintLen = 0 Then Exit Sub
	movf	PRINTLEN,F
	btfss	STATUS, Z
	goto	ENDIF39
	banksel	STATUS
	return
ENDIF39
;GLCDPrintLoc = PrintLocX
	movf	PRINTLOCX,W
	banksel	GLCDPRINTLOC
	movwf	GLCDPRINTLOC
	banksel	PRINTLOCX_H
	movf	PRINTLOCX_H,W
	banksel	GLCDPRINTLOC_H
	movwf	GLCDPRINTLOC_H
;For SysPrintTemp = 1 To PrintLen
	banksel	SYSPRINTTEMP
	clrf	SYSPRINTTEMP
	movlw	1
	subwf	PRINTLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd14
ENDIF40
SysForLoop14
	incf	SYSPRINTTEMP,F
;DrawBigChar_ILI9486L GLCDPrintLoc, PrintLocY, PrintData(SysPrintTemp), Color
	banksel	GLCDPRINTLOC
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
	banksel	SYSPRINTTEMP
	movf	SYSPRINTTEMP,W
	addwf	SysPRINTDATAHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	CHARCODE
	movwf	CHARCODE
	pagesel	DRAWBIGCHAR_ILI9486L
	call	DRAWBIGCHAR_ILI9486L
	pagesel	$
;GLCDPrintLoc += 13
	movlw	13
	addwf	GLCDPRINTLOC,F
	movlw	0
	addwfc	GLCDPRINTLOC_H,F
;Next
	banksel	PRINTLEN
	movf	PRINTLEN,W
	subwf	SYSPRINTTEMP,W
	btfss	STATUS, C
	goto	SysForLoop14
ENDIF41
SysForLoopEnd14
	banksel	STATUS
	return

;********************************************************************************

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
	goto	ENDIF26
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
ENDIF26
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
	goto	ENDIF27
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
ENDIF27
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
	goto	SysForLoopEnd12
ENDIF28
SysForLoop12
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
	call	PSET_T6963
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
	call	PSET_T6963
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
	goto	SysForLoop12
ENDIF29
SysForLoopEnd12
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
	goto	SysForLoopEnd13
ENDIF30
SysForLoop13
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
	call	PSET_T6963
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
	call	PSET_T6963
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
	goto	SysForLoop13
ENDIF31
SysForLoopEnd13
	return

;********************************************************************************

CLS_T6963
;dim row_T6963, col_T6963 as word
;Set address pointer to address (TEXT_HOME_ADDR)
;GLCDCmdAddrSend_T6963(TEXT_HOME_ADDR,ADDR_PTR_SET)
	clrf	LCDDATAWORD
	clrf	LCDDATAWORD_H
	movlw	36
	movwf	LCDCMDBYTE
	pagesel	GLCDCMDADDRSEND_T6963
	call	GLCDCMDADDRSEND_T6963
	pagesel	$
;Set Auto Write ON
;GLCDSendCommand_T6963(AUTO_WR_ON)
	movlw	176
	movwf	LCDCMDBYTE
	pagesel	GLCDSENDCOMMAND_T6963
	call	GLCDSENDCOMMAND_T6963
	pagesel	$
;row runs from 0 ... (MAX_ROW_PIXEL/8 -1), in form of a cell of (FontSize x 8) bits
;for  row_T6963 =  0 to ( MAX_ROW_PIXEL/8 ) -1
	movlw	255
	banksel	ROW_T6963
	movwf	ROW_T6963
	movwf	ROW_T6963_H
SysForLoop17
	banksel	ROW_T6963
	incf	ROW_T6963,F
	btfsc	STATUS,Z
	incf	ROW_T6963_H,F
;write blank to clear screen the first page only, col = 0...(COLUMN-1)
;for col_T6963 = 0 to COLUMN - 1
	movlw	255
	banksel	COL_T6963
	movwf	COL_T6963
	movwf	COL_T6963_H
SysForLoop18
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
	goto	SysForLoop18
ENDIF67
SysForLoopEnd18
;next
	banksel	ROW_T6963
	movf	ROW_T6963,W
	movwf	SysWORDTempA
	movf	ROW_T6963_H,W
	movwf	SysWORDTempA_H
	movlw	7
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop17
ENDIF68
SysForLoopEnd17
;GLCDSendCommand_T6963(AUTO_WR_OFF)
	movlw	178
	movwf	LCDCMDBYTE
	pagesel	GLCDSENDCOMMAND_T6963
	call	GLCDSENDCOMMAND_T6963
	pagesel	$
;GLCDCmdAddrSend_T6963(TEXT_HOME_ADDR,ADDR_PTR_SET)
	clrf	LCDDATAWORD
	clrf	LCDDATAWORD_H
	movlw	36
	movwf	LCDCMDBYTE
	pagesel	GLCDCMDADDRSEND_T6963
	call	GLCDCMDADDRSEND_T6963
	pagesel	$
;GLCDSendCommand_T6963(CURSOR_PTR_SET)
	movlw	33
	movwf	LCDCMDBYTE
	pagesel	GLCDSENDCOMMAND_T6963
	goto	GLCDSENDCOMMAND_T6963

;********************************************************************************

FILLEDBOX_T6963
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
	goto	ENDIF88
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
ENDIF88
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
	goto	ENDIF89
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
ENDIF89
;Fill with colour
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
	goto	SysForLoopEnd21
ENDIF90
SysForLoop21
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
	goto	SysForLoopEnd22
ENDIF91
SysForLoop22
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
	call	PSET_T6963
	pagesel	$
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
	goto	SysForLoop22
ENDIF92
SysForLoopEnd22
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
	goto	SysForLoop21
ENDIF93
SysForLoopEnd21
	return

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
;GLCD_WR = 1
	bsf	LATA,2
;wait T6963ClockDelay us
;GLCD_RD = 0
	bcf	LATA,1
;wait T6963ClockDelay us
;GLCD_CS = 0
	bcf	LATA,7
;wait T6963ClockDelay us
;wait while (!STA0)  'Busy Check here
SysWaitLoop1
	clrf	SysTemp2
	banksel	PORTD
	btfss	PORTD,0
	goto	ENDIF94
	banksel	SYSTEMP2
	incf	SysTemp2,F
ENDIF94
	banksel	SYSTEMP2
	comf	SysTemp2,W
	movwf	SysTemp1
	btfsc	SysTemp1,0
	goto	SysWaitLoop1
;wait T6963ClockDelay us
;wait while (!STA1)
SysWaitLoop2
	clrf	SysTemp2
	banksel	PORTD
	btfss	PORTD,1
	goto	ENDIF95
	banksel	SYSTEMP2
	incf	SysTemp2,F
ENDIF95
	banksel	SYSTEMP2
	comf	SysTemp2,W
	movwf	SysTemp1
	btfsc	SysTemp1,0
	goto	SysWaitLoop2
;GLCD_CS = 1
	bsf	LATA,7
;dir GLCD_DATA_PORT out
	banksel	TRISD
	clrf	TRISD
	banksel	STATUS
	return

;********************************************************************************

GLCDDRAWSTRING
;dim GLCDPrintLoc as word
;GLCDPrintLoc = StringLocX
	banksel	STRINGLOCX
	movf	STRINGLOCX,W
	banksel	GLCDPRINTLOC
	movwf	GLCDPRINTLOC
	clrf	GLCDPRINTLOC_H
;for xchar = 1 to Chars(0)
	banksel	XCHAR
	clrf	XCHAR
	banksel	SYSCHARSHANDLER
	movf	SysCHARSHandler,W
	movwf	AFSR0
	movf	SysCHARSHandler_H,W
	movwf	AFSR0_H
	movlw	1
	subwf	INDF0,W
	btfss	STATUS, C
	goto	SysForLoopEnd7
ENDIF15
SysForLoop7
	banksel	XCHAR
	incf	XCHAR,F
;GLCDDrawChar GLCDPrintLoc , CharLocY , Chars(xchar), LineColour
	banksel	GLCDPRINTLOC
	movf	GLCDPRINTLOC,W
	movwf	CHARLOCX
	movf	GLCDPRINTLOC_H,W
	movwf	CHARLOCX_H
	banksel	XCHAR
	movf	XCHAR,W
	banksel	SYSCHARSHANDLER
	addwf	SysCHARSHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysCHARSHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	CHARCODE
	movwf	CHARCODE
	pagesel	GLCDDRAWCHAR
	call	GLCDDRAWCHAR
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
	banksel	XCHAR
	subwf	XCHAR,W
	btfss	STATUS, C
	goto	SysForLoop7
ENDIF16
SysForLoopEnd7
	banksel	STATUS
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:STRING:
GLCDPRINT3
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
ENDIF10
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
	goto	SysForLoopEnd5
ENDIF11
SysForLoop5
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
	pagesel	GLCDDRAWCHAR
	call	GLCDDRAWCHAR
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
	goto	SysForLoop5
ENDIF12
SysForLoopEnd5
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:LONG:
GLCDPRINT5
;Dim SysCalcTempA As Long
;Dim GLCDPrintLoc as word
;Dim SysPrintBuffer(10)
;SysPrintBuffLen = 0
	banksel	SYSPRINTBUFFLEN
	clrf	SYSPRINTBUFFLEN
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
	banksel	STATUS
	call	SysDivSub32
	movf	SysLONGTempX,W
	movwf	INDF0
;LCDValue = SysCalcTempA
	movf	SYSCALCTEMPA,W
	banksel	LCDVALUE
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
	banksel	STATUS
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
	goto	SysForLoopEnd6
ENDIF13
SysForLoop6
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
	pagesel	GLCDDRAWCHAR
	call	GLCDDRAWCHAR
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
	goto	SysForLoop6
ENDIF14
SysForLoopEnd6
	banksel	STATUS
	return

;********************************************************************************

LCDCURSOR_T6963
;for LCDCURSOR Sub
;dim DefaultDisplayModeState_T6963 as byte
;adjust for line count
;line_x_cursor = line_x_cursor - 1
	banksel	LINE_X_CURSOR
	decf	LINE_X_CURSOR,F
;protect if zero is passed as parameter and well as the default
;if line_x_cursor > 8 then
	movf	LINE_X_CURSOR,W
	sublw	8
	btfss	STATUS, C
;line_x_cursor = 0
	clrf	LINE_X_CURSOR
;end if
ENDIF74
;If LCDCRSR = ON  Then DefaultDisplayModeState_T6963 = DefaultDisplayModeState_T6963 OR LCDON
	banksel	LCDCRSR
	decf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF75
	movlw	4
	iorwf	DEFAULTDISPLAYMODESTATE_T6963,F
ENDIF75
;IF LCDCRSR = LCDON Then DefaultDisplayModeState_T6963 = DefaultDisplayModeState_T6963 OR LCDON
	movlw	4
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF76
	movlw	4
	iorwf	DEFAULTDISPLAYMODESTATE_T6963,F
ENDIF76
;If LCDCRSR = OFF Then DefaultDisplayModeState_T6963 = DefaultDisplayModeState_T6963 AND LCDOFF
	movf	LCDCRSR,F
	btfss	STATUS, Z
	goto	ENDIF77
	movlw	251
	andwf	DEFAULTDISPLAYMODESTATE_T6963,F
ENDIF77
;If LCDCRSR = LCDOFF Then DefaultDisplayModeState_T6963 = DefaultDisplayModeState_T6963 AND LCDOFF
	movlw	251
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF78
	movlw	251
	andwf	DEFAULTDISPLAYMODESTATE_T6963,F
ENDIF78
;If LCDCRSR = CursorOn Then
	movlw	2
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF79
;DefaultDisplayModeState_T6963 = DefaultDisplayModeState_T6963 OR CursorON
	movlw	2
	iorwf	DEFAULTDISPLAYMODESTATE_T6963,F
;GLCDSendCommand_T6963(line_x_cursor)
	banksel	LINE_X_CURSOR
	movf	LINE_X_CURSOR,W
	banksel	LCDCMDBYTE
	movwf	LCDCMDBYTE
	pagesel	GLCDSENDCOMMAND_T6963
	call	GLCDSENDCOMMAND_T6963
	pagesel	$
;end if
ENDIF79
;If LCDCRSR = CursorOFF then
	movlw	253
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF80
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
ENDIF80
;If LCDCRSR = FLASH  Then
	movlw	3
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF81
;DefaultDisplayModeState_T6963 = DefaultDisplayModeState_T6963 OR FLASHON
	movlw	3
	iorwf	DEFAULTDISPLAYMODESTATE_T6963,F
;line_x_cursor = line_x_cursor or line_1_cursor
	movlw	160
	banksel	LINE_X_CURSOR
	iorwf	LINE_X_CURSOR,F
;GLCDSendCommand_T6963( line_x_cursor )
	movf	LINE_X_CURSOR,W
	banksel	LCDCMDBYTE
	movwf	LCDCMDBYTE
	pagesel	GLCDSENDCOMMAND_T6963
	call	GLCDSENDCOMMAND_T6963
	pagesel	$
;End if
ENDIF81
;If LCDCRSR = FLASHOFF then
	movlw	252
	subwf	LCDCRSR,W
	btfss	STATUS, Z
	goto	ENDIF82
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
ENDIF82
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
	banksel	LCDVALUE
	movf	LCDVALUE,W
	movwf	SysBYTETempA
	movlw	16
	movwf	SysBYTETempB
	banksel	STATUS
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
	banksel	LCDVALUE
	andwf	LCDVALUE,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	48
	addwf	SysTemp1,W
	banksel	LOWCHAR
	movwf	LOWCHAR
;Check for alpha and convert.
;If HighChar > 57 Then HighChar = HighChar + 7
	banksel	HIGHCHAR
	movf	HIGHCHAR,W
	sublw	57
	btfsc	STATUS, C
	goto	ENDIF69
	movlw	7
	addwf	HIGHCHAR,F
ENDIF69
;If LowChar > 57 Then  LowChar = LowChar + 7
	banksel	LOWCHAR
	movf	LOWCHAR,W
	sublw	57
	btfsc	STATUS, C
	goto	ENDIF70
	movlw	7
	addwf	LOWCHAR,F
ENDIF70
;Write chars to LCD - if user specifies LeadingZeroActive then print the leading char
;IF LCDChar = LeadingZeroActive then
	movlw	2
	banksel	LCDCHAR
	subwf	LCDCHAR,W
	btfss	STATUS, Z
	goto	ENDIF71
;if LCDValue < 16 then
	movlw	16
	banksel	LCDVALUE
	subwf	LCDVALUE,W
	btfsc	STATUS, C
	goto	ENDIF73
;Print "0"
	movlw	low StringTable67
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable67) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT431
	call	PRINT431
	pagesel	$
;end if
ENDIF73
;END IF
ENDIF71
;Write high char if LCDValue is > 15 (DEC)
;IF LCDValue > 15 then Print Chr(HighChar)
	banksel	LCDVALUE
	movf	LCDVALUE,W
	sublw	15
	btfsc	STATUS, C
	goto	ENDIF72
	banksel	HIGHCHAR
	movf	HIGHCHAR,W
	banksel	SYSCHAR
	movwf	SYSCHAR
	banksel	STATUS
	pagesel	FN_CHR
	call	FN_CHR
	pagesel	$
	movlw	low CHR
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high CHR
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT431
	call	PRINT431
	pagesel	$
ENDIF72
;Print Chr(LowChar)
	banksel	LOWCHAR
	movf	LOWCHAR,W
	movwf	SYSCHAR
	banksel	STATUS
	pagesel	FN_CHR
	call	FN_CHR
	pagesel	$
	movlw	low CHR
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	high CHR
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT431
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
;GLCDCmdAddrSend_T6963(addr,ADDR_PTR_SET)
	movf	ADDR,W
	movwf	LCDDATAWORD
	movf	ADDR_H,W
	movwf	LCDDATAWORD_H
	movlw	36
	movwf	LCDCMDBYTE
	pagesel	GLCDCMDADDRSEND_T6963
	call	GLCDCMDADDRSEND_T6963
	pagesel	$
;GLCDSendCommand_T6963(CURSOR_PTR_SET)
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
ENDIF63
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
ENDIF64
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
;GLCDCmdAddrSend_T6963(addr,ADDR_PTR_SET)
	movf	ADDR,W
	movwf	LCDDATAWORD
	movf	ADDR_H,W
	movwf	LCDDATAWORD_H
	movlw	36
	movwf	LCDCMDBYTE
	pagesel	GLCDCMDADDRSEND_T6963
	goto	GLCDCMDADDRSEND_T6963

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
	banksel	SYSSTRLEN
	movf	SYSSTRLEN,W
	subwf	INDF0,W
	btfsc	STATUS, C
	goto	ELSE123_1
;SysCharCount = SysInString(0)
	banksel	SYSSYSINSTRINGHANDLER
	movf	SysSYSINSTRINGHandler,W
	movwf	AFSR0
	movf	SysSYSINSTRINGHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSCHARCOUNT
	movwf	SYSCHARCOUNT
;clear output string
;Pad=""
	movlw	low PAD
	movwf	FSR1L
	movlw	high PAD
	movwf	FSR1H
	movlw	low StringTable90
	movwf	SysStringA
	movlw	(high StringTable90) & 127
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
	goto	SysForLoopEnd25
ENDIF124
SysForLoop25
	incf	SYSSTRINGTEMP,F
;Pad(SysStringTemp) = SysInString(SysStringTemp)
	movf	SYSSTRINGTEMP,W
	banksel	SYSSYSINSTRINGHANDLER
	addwf	SysSYSINSTRINGHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysSYSINSTRINGHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP1
	movwf	SysArrayTemp1
	movwf	SysArrayTemp2
	movlw	low(PAD)
	addwf	SYSSTRINGTEMP,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(PAD)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	banksel	SYSARRAYTEMP2
	movf	SysArrayTemp2,W
	movwf	INDF0
;Next
	movf	SYSCHARCOUNT,W
	subwf	SYSSTRINGTEMP,W
	btfss	STATUS, C
	goto	SysForLoop25
ENDIF125
SysForLoopEnd25
;For SysStringTemp = SysCharCount+1 to SysStrLen
	incf	SYSCHARCOUNT,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	decf	SysTemp1,W
	banksel	SYSSTRINGTEMP
	movwf	SYSSTRINGTEMP
	incf	SYSCHARCOUNT,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movwf	SysBYTETempB
	banksel	SYSSTRLEN
	movf	SYSSTRLEN,W
	movwf	SysBYTETempA
	banksel	STATUS
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd26
ENDIF126
SysForLoop26
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
	movlw	0
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(PAD)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	banksel	SYSARRAYTEMP1
	movf	SysArrayTemp1,W
	movwf	INDF0
;Next
	movf	SYSSTRLEN,W
	subwf	SYSSTRINGTEMP,W
	btfss	STATUS, C
	goto	SysForLoop26
ENDIF127
SysForLoopEnd26
;set new length to PAD
;Pad(0) = SysStrLen
	banksel	SYSSTRLEN
	movf	SYSSTRLEN,W
	banksel	SYSPAD_0
	movwf	SYSPAD_0
;else
	goto	ENDIF123
ELSE123_1
;SysInString is equal or longer than SysStrLen
;give back old string; copy SysInString to Pad
;For SysStringTemp = 1 To SysInString(0)
	clrf	SYSSTRINGTEMP
	banksel	SYSSYSINSTRINGHANDLER
	movf	SysSYSINSTRINGHandler,W
	movwf	AFSR0
	movf	SysSYSINSTRINGHandler_H,W
	movwf	AFSR0_H
	movlw	1
	subwf	INDF0,W
	btfss	STATUS, C
	goto	SysForLoopEnd27
ENDIF128
SysForLoop27
	banksel	SYSSTRINGTEMP
	incf	SYSSTRINGTEMP,F
;Pad(SysStringTemp) = SysInString(SysStringTemp)
	movf	SYSSTRINGTEMP,W
	banksel	SYSSYSINSTRINGHANDLER
	addwf	SysSYSINSTRINGHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysSYSINSTRINGHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP1
	movwf	SysArrayTemp1
	movwf	SysArrayTemp2
	movlw	low(PAD)
	addwf	SYSSTRINGTEMP,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(PAD)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	banksel	SYSARRAYTEMP2
	movf	SysArrayTemp2,W
	movwf	INDF0
;Next
	banksel	SYSSYSINSTRINGHANDLER
	movf	SysSYSINSTRINGHandler,W
	movwf	AFSR0
	movf	SysSYSINSTRINGHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSSTRINGTEMP
	subwf	SYSSTRINGTEMP,W
	btfss	STATUS, C
	goto	SysForLoop27
ENDIF129
SysForLoopEnd27
;PAD(0) = SysInString(0)
	banksel	SYSSYSINSTRINGHANDLER
	movf	SysSYSINSTRINGHandler,W
	movwf	AFSR0
	movf	SysSYSINSTRINGHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	SYSARRAYTEMP1
	movwf	SysArrayTemp1
	banksel	SYSPAD_0
	movwf	SYSPAD_0
;End If
ENDIF123
	banksel	STATUS
	return

;********************************************************************************

PSET_T6963
;dim T6963_GLCD_HEIGHT, T6963_GLCD_WIDTH as word
;select case GLCDRotateState
;case PORTRAIT
SysSelect2Case1
	movlw	4
	subwf	GLCDROTATESTATE,W
	btfss	STATUS, Z
	goto	SysSelect2Case2
;NOT supportED
;case LANDSCAPE
	goto	SysSelectEnd2
SysSelect2Case2
	decf	GLCDROTATESTATE,W
	btfss	STATUS, Z
	goto	SysSelect2Case3
;default
;case PORTRAIT_REV
	goto	SysSelectEnd2
SysSelect2Case3
	movlw	2
	subwf	GLCDROTATESTATE,W
	btfss	STATUS, Z
	goto	SysSelect2Case4
;NOT supportED
;case LANDSCAPE_REV
	goto	SysSelectEnd2
SysSelect2Case4
	movlw	3
	subwf	GLCDROTATESTATE,W
	btfss	STATUS, Z
	goto	SysSelect2Case5
;GLCDX  = T6963_GLCD_WIDTH - GLCDX - 1
	movf	GLCDX,W
	subwf	GLCDDEVICEWIDTH,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	GLCDX_H
	movf	GLCDX_H,W
	subwfb	GLCDDEVICEWIDTH_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	movlw	1
	subwf	SysTemp1,W
	banksel	GLCDX
	movwf	GLCDX
	movlw	0
	banksel	SYSTEMP1_H
	subwfb	SysTemp1_H,W
	banksel	GLCDX_H
	movwf	GLCDX_H
;GLCDY  = T6963_GLCD_HEIGHT - GLCDY - 1
	movf	GLCDY,W
	subwf	GLCDDEVICEHEIGHT,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	GLCDY_H
	movf	GLCDY_H,W
	subwfb	GLCDDEVICEHEIGHT_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	movlw	1
	subwf	SysTemp1,W
	banksel	GLCDY
	movwf	GLCDY
	movlw	0
	banksel	SYSTEMP1_H
	subwfb	SysTemp1_H,W
	banksel	GLCDY_H
	movwf	GLCDY_H
;case else
	goto	SysSelectEnd2
SysSelect2Case5
;default
;end select
SysSelectEnd2
;dim addr as word
;dim cmd as byte
;addr = ( GLCDY  * COLUMN ) + (GLCDX /FontSize_T6963) + GRH_HOME_ADDR
	movf	GLCDY,W
	movwf	SysWORDTempA
	movf	GLCDY_H,W
	movwf	SysWORDTempA_H
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
	banksel	GLCDX
	movf	GLCDX,W
	movwf	SysWORDTempA
	movf	GLCDX_H,W
	movwf	SysWORDTempA_H
	movlw	6
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempA,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movf	SysWORDTempA_H,W
	movwf	SysTemp2_H
	movf	SysTemp2,W
	addwf	SysTemp1,W
	movwf	SysTemp3
	movf	SysTemp2_H,W
	addwfc	SysTemp1_H,W
	movwf	SysTemp3_H
	movlw	255
	addwf	SysTemp3,W
	banksel	ADDR
	movwf	ADDR
	movlw	63
	banksel	SYSTEMP3_H
	addwfc	SysTemp3_H,W
	banksel	ADDR_H
	movwf	ADDR_H
;GLCDCmdAddrSend_T6963(addr, ADDR_PTR_SET)
	movf	ADDR,W
	movwf	LCDDATAWORD
	movf	ADDR_H,W
	movwf	LCDDATAWORD_H
	movlw	36
	movwf	LCDCMDBYTE
	pagesel	GLCDCMDADDRSEND_T6963
	call	GLCDCMDADDRSEND_T6963
	pagesel	$
;if ( GLCDColour = 1 ) then
	movf	GLCDCOLOUR,W
	movwf	SysWORDTempA
	movf	GLCDCOLOUR_H,W
	movwf	SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ELSE87_1
;cmd = (0b11111000)|(FontSize_T6963- 1 -((GLCDX)%FontSize_T6963))
	movf	GLCDX,W
	movwf	SysWORDTempA
	movf	GLCDX_H,W
	movwf	SysWORDTempA_H
	movlw	6
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movf	SysWORDTempX_H,W
	movwf	SysTemp1_H
	movf	SysTemp1,W
	sublw	5
	movwf	SysTemp2
	clrf	SysTemp3
	movf	SysTemp1_H,W
	subwfb	SysTemp3,W
	movwf	SysTemp2_H
	movlw	248
	iorwf	SysTemp2,W
	banksel	CMD
	movwf	CMD
;else
	goto	ENDIF87
ELSE87_1
;cmd = (0b11110000)|(FontSize_T6963- 1 -((GLCDX)%FontSize_T6963))
	movf	GLCDX,W
	movwf	SysWORDTempA
	movf	GLCDX_H,W
	movwf	SysWORDTempA_H
	movlw	6
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movf	SysWORDTempX_H,W
	movwf	SysTemp1_H
	movf	SysTemp1,W
	sublw	5
	movwf	SysTemp2
	clrf	SysTemp3
	movf	SysTemp1_H,W
	subwfb	SysTemp3,W
	movwf	SysTemp2_H
	movlw	240
	iorwf	SysTemp2,W
	banksel	CMD
	movwf	CMD
;end if
ENDIF87
;GLCDSendCommand_T6963(cmd)
	movf	CMD,W
	movwf	LCDCMDBYTE
	pagesel	GLCDSENDCOMMAND_T6963
	goto	GLCDSENDCOMMAND_T6963

;********************************************************************************

FN_STR
;SysCharCount = 0
	banksel	SYSCHARCOUNT
	clrf	SYSCHARCOUNT
;Dim SysCalcTempX As Word
;Ten Thousands
;IF SysValTemp >= 10000 then
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
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF115
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
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	movf	SYSCALCTEMPX_H,W
	movwf	SYSVALTEMP_H
;SysCharCount += 1
	banksel	SYSCHARCOUNT
	incf	SYSCHARCOUNT,F
;Str(SysCharCount) = SysStrData + 48
	movlw	low(STR)
	addwf	SYSCHARCOUNT,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(STR)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movlw	48
	banksel	SYSSTRDATA
	addwf	SYSSTRDATA,W
	movwf	INDF0
;Goto SysValThousands
	goto	SYSVALTHOUSANDS
;End If
ENDIF115
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
	goto	ENDIF116
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
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	movf	SYSCALCTEMPX_H,W
	movwf	SYSVALTEMP_H
;SysCharCount += 1
	banksel	SYSCHARCOUNT
	incf	SYSCHARCOUNT,F
;Str(SysCharCount) = SysStrData + 48
	movlw	low(STR)
	addwf	SYSCHARCOUNT,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(STR)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movlw	48
	banksel	SYSSTRDATA
	addwf	SYSSTRDATA,W
	movwf	INDF0
;Goto SysValHundreds
	goto	SYSVALHUNDREDS
;End If
ENDIF116
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
	goto	ENDIF117
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
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	movf	SYSCALCTEMPX_H,W
	movwf	SYSVALTEMP_H
;SysCharCount += 1
	banksel	SYSCHARCOUNT
	incf	SYSCHARCOUNT,F
;Str(SysCharCount) = SysStrData + 48
	movlw	low(STR)
	addwf	SYSCHARCOUNT,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(STR)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movlw	48
	banksel	SYSSTRDATA
	addwf	SYSSTRDATA,W
	movwf	INDF0
;Goto SysValTens
	goto	SYSVALTENS
;End If
ENDIF117
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
	goto	ENDIF118
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
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP
	movf	SYSCALCTEMPX_H,W
	movwf	SYSVALTEMP_H
;SysCharCount += 1
	banksel	SYSCHARCOUNT
	incf	SYSCHARCOUNT,F
;Str(SysCharCount) = SysStrData + 48
	movlw	low(STR)
	addwf	SYSCHARCOUNT,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP1
	movwf	SysTemp1
	movlw	high(STR)
	addwfc	SysTemp1,W
	movwf	AFSR0_H
	movlw	48
	banksel	SYSSTRDATA
	addwf	SYSSTRDATA,W
	movwf	INDF0
;End If
ENDIF118
;Ones
;SysCharCount += 1
	banksel	SYSCHARCOUNT
	incf	SYSCHARCOUNT,F
;Str(SysCharCount) = SysValTemp + 48
	movlw	low(STR)
	addwf	SYSCHARCOUNT,W
	movwf	AFSR0
	movlw	0
	banksel	SYSTEMP1
	movwf	SysTemp1
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
	banksel	SYSCHARCOUNT
	movf	SYSCHARCOUNT,W
	banksel	SYSSTR_0
	movwf	SYSSTR_0
	banksel	STATUS
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
	goto	ENDIF110
;SysLongTempA = 0
	clrf	SYSLONGTEMPA
	clrf	SYSLONGTEMPA_H
	clrf	SYSLONGTEMPA_U
	clrf	SYSLONGTEMPA_E
;exit sub
	return
;end if
ENDIF110
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
	goto	ENDIF111
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
ENDIF111
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

;Start of program memory page 5
	ORG	10240
FN_CHR
;Empty input?
;If SysChar < 0 Then
	movlw	0
	banksel	SYSCHAR
	subwf	SYSCHAR,W
	btfsc	STATUS, C
	goto	ENDIF122
;Chr(0) = 0
	banksel	SYSCHR_0
	clrf	SYSCHR_0
;Exit Function
	banksel	STATUS
	return
;End If
ENDIF122
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

GLCDCLS_T6963
;initialise global variable. Required variable for Circle in all DEVICE DRIVERS- DO NOT DELETE
;GLCD_yordinate = 0
	clrf	GLCD_YORDINATE
	clrf	GLCD_YORDINATE_H
;dim row_T6963, col_T6963 as byte
;Set address pointer to address (GRH_HOME_ADDR)
;GLCDCmdAddrSend_T6963(GRH_HOME_ADDR, ADDR_PTR_SET)
	movlw	255
	movwf	LCDDATAWORD
	movlw	63
	movwf	LCDDATAWORD_H
	movlw	36
	movwf	LCDCMDBYTE
	call	GLCDCMDADDRSEND_T6963
;Set Auto Write ON
;GLCDSendCommand_T6963(AUTO_WR_ON)
	movlw	176
	movwf	LCDCMDBYTE
	call	GLCDSENDCOMMAND_T6963
;Row runs from 0 ... (MAX_ROW_PIXEL-1), in form of a byte size of (FontSize x 1) bits
;for  row_T6963 =  0 to  MAX_ROW_PIXEL -1
	movlw	255
	banksel	ROW_T6963
	movwf	ROW_T6963
SysForLoop19
	banksel	ROW_T6963
	incf	ROW_T6963,F
;write blank to clear screen the first page only, col = 0...(COLUMN-1)
;for col_T6963 = 0 to COLUMN - 1
	movlw	255
	banksel	COL_T6963
	movwf	COL_T6963
SysForLoop20
	incf	COL_T6963,F
;GLCDispAutoDataWr ( 0x00 )
	clrf	LCDDATABYTE
	call	GLCDISPAUTODATAWR
;next
	movf	COL_T6963,W
	movwf	SysBYTETempA
	movlw	39
	movwf	SysBYTETempB
	call	SysCompLessThan
	btfsc	SysByteTempX,0
	goto	SysForLoop20
ENDIF85
SysForLoopEnd20
;next
	banksel	ROW_T6963
	movf	ROW_T6963,W
	movwf	SysBYTETempA
	movlw	63
	movwf	SysBYTETempB
	banksel	STATUS
	call	SysCompLessThan
	btfsc	SysByteTempX,0
	goto	SysForLoop19
ENDIF86
SysForLoopEnd19
;GLCDSendCommand_T6963(AUTO_WR_OFF)
	movlw	178
	movwf	LCDCMDBYTE
	call	GLCDSENDCOMMAND_T6963
;GLCDCmdAddrSend_T6963(GRH_HOME_ADDR, ADDR_PTR_SET)
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
;GLCD_CD = 0
	banksel	LATA
	bcf	LATA,0
;wait T6963ClockDelay us
;GLCD_WR = 0
	bcf	LATA,2
;wait T6963ClockDelay us
;GLCD_RD = 1
	bsf	LATA,1
;wait T6963ClockDelay us
;GLCD_CS = 0
	bcf	LATA,7
;wait T6963WriteDelay us
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
;GLCD_WR = 1
	bsf	LATA,2
;wait T6963ClockDelay us
;GLCD_RD = 0
	bcf	LATA,1
;wait T6963ClockDelay us
;GLCD_CS = 0
	bcf	LATA,7
;wait T6963ClockDelay us
;wait while (!STA3)  'Busy Check here
SysWaitLoop3
	clrf	SysTemp2
	banksel	PORTD
	btfss	PORTD,3
	goto	ENDIF96
	banksel	SYSTEMP2
	incf	SysTemp2,F
ENDIF96
	banksel	SYSTEMP2
	comf	SysTemp2,W
	movwf	SysTemp1
	btfsc	SysTemp1,0
	goto	SysWaitLoop3
;GLCD_CS = 1
	bsf	LATA,7
;dir GLCD_DATA_PORT out
	banksel	TRISD
	clrf	TRISD
	banksel	STATUS
	return

;********************************************************************************

GLCDROTATE_T6963
;dim T6963_GLCD_HEIGHT, T6963_GLCD_WIDTH as word
;select case GLCDRotateState
;case LANDSCAPE   '0 degree
SysSelect3Case1
	decf	GLCDROTATESTATE,W
	btfss	STATUS, Z
	goto	SysSelect3Case2
;T6963_GLCD_WIDTH = GLCD_WIDTH
	movlw	240
	movwf	GLCDDEVICEWIDTH
	clrf	GLCDDEVICEWIDTH_H
;T6963_GLCD_HEIGHT = GLCD_HEIGHT
	movlw	64
	movwf	GLCDDEVICEHEIGHT
	clrf	GLCDDEVICEHEIGHT_H
;case Portrait
	goto	SysSelectEnd3
SysSelect3Case2
	movlw	4
	subwf	GLCDROTATESTATE,W
	btfss	STATUS, Z
	goto	SysSelect3Case3
;T6963_GLCD_WIDTH = GLCD_HEIGHT
	movlw	64
	movwf	GLCDDEVICEWIDTH
	clrf	GLCDDEVICEWIDTH_H
;T6963_GLCD_HEIGHT = GLCD_WIDTH
	movlw	240
	movwf	GLCDDEVICEHEIGHT
	clrf	GLCDDEVICEHEIGHT_H
;case LANDSCAPE_REV
	goto	SysSelectEnd3
SysSelect3Case3
	movlw	3
	subwf	GLCDROTATESTATE,W
	btfss	STATUS, Z
	goto	SysSelect3Case4
;T6963_GLCD_WIDTH = GLCD_WIDTH
	movlw	240
	movwf	GLCDDEVICEWIDTH
	clrf	GLCDDEVICEWIDTH_H
;T6963_GLCD_HEIGHT = GLCD_HEIGHT
	movlw	64
	movwf	GLCDDEVICEHEIGHT
	clrf	GLCDDEVICEHEIGHT_H
;case PORTRAIT_REV
	goto	SysSelectEnd3
SysSelect3Case4
	movlw	2
	subwf	GLCDROTATESTATE,W
	btfss	STATUS, Z
	goto	SysSelect3Case5
;T6963_GLCD_WIDTH = GLCD_HEIGHT
	movlw	64
	movwf	GLCDDEVICEWIDTH
	clrf	GLCDDEVICEWIDTH_H
;T6963_GLCD_HEIGHT = GLCD_WIDTH
	movlw	240
	movwf	GLCDDEVICEHEIGHT
	clrf	GLCDDEVICEHEIGHT_H
;case else
	goto	SysSelectEnd3
SysSelect3Case5
;T6963_GLCD_WIDTH = GLCD_WIDTH
	movlw	240
	movwf	GLCDDEVICEWIDTH
	clrf	GLCDDEVICEWIDTH_H
;T6963_GLCD_HEIGHT = GLCD_HEIGHT
	movlw	64
	movwf	GLCDDEVICEHEIGHT
	clrf	GLCDDEVICEHEIGHT_H
;end select
SysSelectEnd3
	return

;********************************************************************************

GLCDSENDCOMMAND_T6963
;GLCDBusyCheck_T6963
	pagesel	GLCDBUSYCHECK_T6963
	call	GLCDBUSYCHECK_T6963
	pagesel	$
;GLCD_DATA_PORT = LCDCmdByte
	movf	LCDCMDBYTE,W
	movwf	PORTD
;wait T6963ClockDelay us
;GLCD_CD = 1
	banksel	LATA
	bsf	LATA,0
;wait T6963ClockDelay us
;GLCD_WR = 0
	bcf	LATA,2
;wait T6963ClockDelay us
;GLCD_RD = 1
	bsf	LATA,1
;wait T6963ClockDelay us
;GLCD_CS = 0
	bcf	LATA,7
;wait T6963WriteDelay us
;GLCD_CS = 1
	bsf	LATA,7
	banksel	STATUS
	return

;********************************************************************************

GLCDSENDDATA_T6963
;GLCDBusyCheck_T6963
	pagesel	GLCDBUSYCHECK_T6963
	call	GLCDBUSYCHECK_T6963
	pagesel	$
;GLCD_DATA_PORT = LCDDataByte
	movf	LCDDATABYTE,W
	movwf	PORTD
;wait T6963ClockDelay us
;GLCD_CD = 0
	banksel	LATA
	bcf	LATA,0
;wait T6963ClockDelay us
;GLCD_WR = 0
	bcf	LATA,2
;wait T6963ClockDelay us
;GLCD_RD = 1
	bsf	LATA,1
;wait T6963ClockDelay us
;GLCD_CS = 0
	bcf	LATA,7
;wait T6963WriteDelay us
;GLCD_CS = 1
	bsf	LATA,7
	banksel	STATUS
	return

;********************************************************************************

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
	banksel	SYSSTRINGTEMP
	movwf	SYSSTRINGTEMP
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	sublw	9
	btfsc	STATUS, C
	goto	ENDIF119
	movlw	7
	addwf	SYSSTRINGTEMP,F
ENDIF119
;Hex(2) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W
	banksel	SYSHEX_2
	movwf	SYSHEX_2
;Get high nibble
;For SysStringTemp = 1 to 4
	banksel	SYSSTRINGTEMP
	clrf	SYSSTRINGTEMP
SysForLoop24
	incf	SYSSTRINGTEMP,F
;Rotate SysValTemp Right
	banksel	SYSVALTEMP
	rrf	SYSVALTEMP,F
;Next
	movlw	4
	banksel	SYSSTRINGTEMP
	subwf	SYSSTRINGTEMP,W
	btfss	STATUS, C
	goto	SysForLoop24
ENDIF120
SysForLoopEnd24
;SysStringTemp = SysValTemp And 0x0F
	movlw	15
	banksel	SYSVALTEMP
	andwf	SYSVALTEMP,W
	banksel	SYSSTRINGTEMP
	movwf	SYSSTRINGTEMP
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	sublw	9
	btfsc	STATUS, C
	goto	ENDIF121
	movlw	7
	addwf	SYSSTRINGTEMP,F
ENDIF121
;Hex(1) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W
	banksel	SYSHEX_1
	movwf	SYSHEX_1
	banksel	STATUS
	return

;********************************************************************************

LCDNORMALWRITEBYTE_T6963
;GLCDSendData_T6963( LCDByte - 0x20 )      'Adjust standard ASCII to T6963 ASCII
	movlw	32
	subwf	LCDBYTE,W
	movwf	LCDDATABYTE
	call	GLCDSENDDATA_T6963
;GLCDSendCommand_T6963(DATA_WR_INC)          'Address pointer increment ON
	movlw	192
	movwf	LCDCMDBYTE
	goto	GLCDSENDCOMMAND_T6963

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
;GLCDSendData_T6963( LCDChar - 0x20 )        'Adjust standard ASCII to T6963 ASCII
	movlw	32
	subwf	LCDCHAR,W
	movwf	LCDDATABYTE
	call	GLCDSENDDATA_T6963
;GLCDSendCommand_T6963(DATA_WR)              'Write data
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

SYSCOMPLESSTHANINT
;Dim SysIntegerTempA, SysIntegerTempB, SysDivMultA as Integer
;Clear result
;SysByteTempX = 0
	clrf	SYSBYTETEMPX
;Compare sign bits
;-A
;If SysIntegerTempA.15 = On Then
	btfss	SYSINTEGERTEMPA_H,7
	goto	ELSE112_1
;-A, +B, return true
;If SysIntegerTempB.15 = Off Then
	btfsc	SYSINTEGERTEMPB_H,7
	goto	ENDIF113
;Set SysByteTempX to 255
;SysByteTempX = Not SysByteTempX
	comf	SYSBYTETEMPX,F
;Exit Sub
	return
;End If
ENDIF113
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
	goto	ENDIF112
ELSE112_1
;+A, -B, return false
;If SysIntegerTempB.15 = On Then
	btfsc	SYSINTEGERTEMPB_H,7
;Exit Sub
	return
;End If
ENDIF114
;End If
ENDIF112
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
	goto	ENDIF107
	comf	SYSINTEGERTEMPA,F
	comf	SYSINTEGERTEMPA_H,F
	incf	SYSINTEGERTEMPA,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPA_H,F
ENDIF107
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
	btfss	SYSINTEGERTEMPB_H,7
	goto	ENDIF108
	comf	SYSINTEGERTEMPB,F
	comf	SYSINTEGERTEMPB_H,F
	incf	SYSINTEGERTEMPB,F
	btfsc	STATUS,Z
	incf	SYSINTEGERTEMPB_H,F
ENDIF108
;Call word divide routine
;SysDivSub16
	pagesel	SYSDIVSUB16
	call	SYSDIVSUB16
	pagesel	$
;Negate result if necessary
;If SysSignByte.7 Then
	btfss	SYSSIGNBYTE,7
	goto	ENDIF109
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
ENDIF109
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
	goto	ENDIF100
	movf	SYSDIVMULTA,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTA_H,W
	addwfc	SYSDIVMULTX_H,F
ENDIF100
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
ENDIF101
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

;Start of program memory page 6
	ORG	12288
;Start of program memory page 7
	ORG	14336

 END
