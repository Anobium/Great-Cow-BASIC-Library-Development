;Program compiled by Great Cow BASIC (0.98.<<>> 2019-11-14 (Windows 32 bit))
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F47K42, r=DEC
#include <P18F47K42.inc>
 CONFIG CP = OFF, LVP = OFF, WRTD = OFF, WDTE = OFF, MVECEN = OFF, MCLRE = EXTMCLR, CLKOUTEN = OFF, RSTOSC = HFINTOSC_1MHZ, FEXTOSC = OFF

;********************************************************************************

;Set aside memory locations for variables
A_AXIS	EQU	14
A_AXIS_H	EQU	15
A_SQ	EQU	16
A_SQ2	EQU	18
A_SQ2_E	EQU	21
A_SQ2_H	EQU	19
A_SQ2_U	EQU	20
A_SQ4	EQU	22
A_SQ4_E	EQU	25
A_SQ4_H	EQU	23
A_SQ4_U	EQU	24
A_SQ_H	EQU	17
B_AXIS	EQU	26
B_AXIS_H	EQU	27
B_SQ	EQU	28
B_SQ2	EQU	30
B_SQ2_E	EQU	33
B_SQ2_H	EQU	31
B_SQ2_U	EQU	32
B_SQ4	EQU	34
B_SQ4_E	EQU	37
B_SQ4_H	EQU	35
B_SQ4_U	EQU	36
B_SQ_H	EQU	29
CHARCODE	EQU	38
CHARCOL	EQU	39
CHARCOL_H	EQU	40
CHARLOCX	EQU	41
CHARLOCX_H	EQU	42
CHARLOCY	EQU	43
CHARLOCY_H	EQU	44
COLOR	EQU	45
COLOR_H	EQU	46
COLSPERFONT	EQU	47
CURRCHARCOL	EQU	48
CURRCHARROW	EQU	49
CURRCHARVAL	EQU	50
DATAVAR	EQU	51
DDF_X	EQU	52
DDF_X_H	EQU	53
DDF_Y	EQU	54
DDF_Y_H	EQU	55
DELAYTEMP	EQU	0
DELAYTEMP2	EQU	1
DIST	EQU	56
DIST_E	EQU	59
DIST_H	EQU	57
DIST_SIGN	EQU	60
DIST_U	EQU	58
DRAWLINE	EQU	61
DRAWLINE_H	EQU	62
DXOFFSET01	EQU	63
DXOFFSET01_H	EQU	64
DXOFFSET02	EQU	65
DXOFFSET02_H	EQU	66
DXOFFSET12	EQU	67
DXOFFSET12_H	EQU	68
DYOFFSET01	EQU	69
DYOFFSET01_H	EQU	70
DYOFFSET02	EQU	71
DYOFFSET02_H	EQU	72
DYOFFSET12	EQU	73
DYOFFSET12_H	EQU	74
EPD2IN13DADDRESSTYPE	EQU	75
EPD2IN13D_COMMAND	EQU	76
EPD2IN13D_DATA	EQU	77
EPD_BUFFER	EQU	8085
EPD_COUNTER	EQU	78
EPD_IND	EQU	79
EPD_IND_COL	EQU	81
EPD_IND_COL_H	EQU	82
EPD_IND_H	EQU	80
EPD_IND_RAW	EQU	83
EPD_IND_RAW_H	EQU	84
EPD_IND_TRANS	EQU	85
EPD_IND_TRANS_H	EQU	86
EPD_N_COL	EQU	87
EPD_N_COL_H	EQU	88
EPD_N_RAW	EQU	89
EPD_N_RAW_H	EQU	90
FF	EQU	91
FF_H	EQU	92
FILLCIRCLEXX	EQU	93
FILLCIRCLEYY	EQU	94
FILLED_ELLIPSE	EQU	95
FNLSR	EQU	96
FNLSR_E	EQU	100
FNLSR_H	EQU	101
FNLSR_U	EQU	102
FRI	EQU	103
FRI_H	EQU	104
GLCDBACKGROUND	EQU	105
GLCDBACKGROUND_H	EQU	106
GLCDCOLOUR	EQU	107
GLCDCOLOUR_H	EQU	108
GLCDDATATEMP	EQU	109
GLCDDATATEMP_H	EQU	110
GLCDDEVICEHEIGHT	EQU	111
GLCDDEVICEHEIGHT_H	EQU	112
GLCDDEVICEWIDTH	EQU	113
GLCDDEVICEWIDTH_H	EQU	114
GLCDFNTDEFAULT	EQU	115
GLCDFNTDEFAULTHEIGHT	EQU	116
GLCDFNTDEFAULTSIZE	EQU	117
GLCDFONTWIDTH	EQU	118
GLCDFOREGROUND	EQU	119
GLCDFOREGROUND_H	EQU	120
GLCDPRINTLEN	EQU	121
GLCDPRINTLOC	EQU	122
GLCDPRINTLOC_H	EQU	123
GLCDPRINT_STRING_COUNTER	EQU	124
GLCDTEMP	EQU	125
GLCDTEMP_H	EQU	126
GLCDX	EQU	127
GLCDX_H	EQU	128
GLCDY	EQU	129
GLCDY_H	EQU	130
GLCD_AA	EQU	131
GLCD_AA_H	EQU	132
GLCD_BB	EQU	133
GLCD_BB_H	EQU	134
GLCD_EX2	EQU	135
GLCD_EX2_E	EQU	138
GLCD_EX2_H	EQU	136
GLCD_EX2_U	EQU	137
GLCD_EY2	EQU	139
GLCD_EY2_E	EQU	142
GLCD_EY2_H	EQU	140
GLCD_EY2_U	EQU	141
GLCD_FX2	EQU	143
GLCD_FX2_E	EQU	146
GLCD_FX2_H	EQU	144
GLCD_FX2_U	EQU	145
GLCD_FY2	EQU	147
GLCD_FY2_E	EQU	150
GLCD_FY2_H	EQU	148
GLCD_FY2_U	EQU	149
GLCD_LAST	EQU	151
GLCD_LAST_H	EQU	152
GLCD_PP	EQU	153
GLCD_PP_E	EQU	156
GLCD_PP_H	EQU	154
GLCD_PP_TEMP	EQU	157
GLCD_PP_TEMP_E	EQU	160
GLCD_PP_TEMP_H	EQU	158
GLCD_PP_TEMP_U	EQU	159
GLCD_PP_U	EQU	155
GLCD_PX	EQU	161
GLCD_PX_E	EQU	164
GLCD_PX_H	EQU	162
GLCD_PX_U	EQU	163
GLCD_PY	EQU	165
GLCD_PY_E	EQU	168
GLCD_PY_H	EQU	166
GLCD_PY_U	EQU	167
GLCD_RX2	EQU	169
GLCD_RX2_H	EQU	170
GLCD_RY2	EQU	171
GLCD_RY2_H	EQU	172
GLCD_SA	EQU	173
GLCD_SA_H	EQU	174
GLCD_SB	EQU	175
GLCD_SB_H	EQU	176
GLCD_TIME_BUFF	EQU	177
GLCD_TIME_BUFF_H	EQU	178
GLCD_XX	EQU	179
GLCD_XX_H	EQU	180
GLCD_Y	EQU	181
GLCD_YORDINATE	EQU	183
GLCD_YORDINATE_H	EQU	184
GLCD_YY	EQU	185
GLCD_YY1	EQU	187
GLCD_YY_H	EQU	186
GLCD_Y_H	EQU	182
HALF_AB_SQ	EQU	188
HALF_AB_SQ_E	EQU	191
HALF_AB_SQ_H	EQU	189
HALF_AB_SQ_U	EQU	190
HALF_A_SQ	EQU	192
HALF_A_SQ_H	EQU	193
HALF_B_SQ	EQU	194
HALF_B_SQ_H	EQU	195
HYPERBOLECONDITION	EQU	196
INTERSECT	EQU	197
INXRADIUS	EQU	198
INXRADIUS_H	EQU	199
INYRADIUS	EQU	200
INYRADIUS_H	EQU	201
LEFTPAD	EQU	8044
LINECOLOUR	EQU	202
LINECOLOUR_H	EQU	203
LINEDIFFX	EQU	204
LINEDIFFX_H	EQU	205
LINEDIFFX_X2	EQU	206
LINEDIFFX_X2_H	EQU	207
LINEDIFFY	EQU	208
LINEDIFFY_H	EQU	209
LINEDIFFY_X2	EQU	210
LINEDIFFY_X2_H	EQU	211
LINEERR	EQU	212
LINEERR_H	EQU	213
LINESTEPX	EQU	214
LINESTEPX_H	EQU	215
LINESTEPY	EQU	216
LINESTEPY_H	EQU	217
LINEX1	EQU	218
LINEX1_H	EQU	219
LINEX2	EQU	220
LINEX2_H	EQU	221
LINEY1	EQU	222
LINEY1_H	EQU	223
LINEY2	EQU	224
LINEY2_H	EQU	225
LOCALCHARCODE	EQU	226
LOCALCHARCODE_H	EQU	227
LOWERPAGE	EQU	228
MODESTOP	EQU	229
NUMBITS	EQU	230
OLDGLCDFONTWIDTH	EQU	231
PRINTLOCX	EQU	232
PRINTLOCX_H	EQU	233
PRINTLOCY	EQU	234
PRINTLOCY_H	EQU	235
RANDOM	EQU	236
RANDOMSEED	EQU	237
RANDOMSEED_H	EQU	238
RANDOMTEMP	EQU	239
RANDOMTEMP_H	EQU	240
REMAINDER	EQU	241
RNUMBER	EQU	242
ROWSPERFONT	EQU	243
RX1	EQU	244
RX1_H	EQU	245
RX2	EQU	246
RX2_H	EQU	247
RY1	EQU	248
RY1_H	EQU	249
RY2	EQU	250
RY2_H	EQU	251
SIGN	EQU	252
SPICLOCKMODE	EQU	253
SPICURRENTMODE	EQU	254
SPIRXDATA	EQU	255
SPITXDATA	EQU	256
STR	EQU	8016
STRINGLOCX	EQU	257
STRINGLOCX_H	EQU	258
STRINGPOINTER	EQU	259
SYSARRAYTEMP1	EQU	260
SYSARRAYTEMP2	EQU	261
SYSBYTETEMPA	EQU	5
SYSBYTETEMPB	EQU	9
SYSBYTETEMPX	EQU	0
SYSCALCTEMPA	EQU	5
SYSCALCTEMPA_H	EQU	6
SYSCALCTEMPB	EQU	9
SYSCALCTEMPB_H	EQU	10
SYSCALCTEMPX	EQU	0
SYSCALCTEMPX_H	EQU	1
SYSCHARCOUNT	EQU	262
SYSCHARSHANDLER	EQU	263
SYSCHARSHANDLER_H	EQU	264
SYSDIVLOOP	EQU	4
SYSDIVMULTA	EQU	7
SYSDIVMULTA_H	EQU	8
SYSDIVMULTB	EQU	11
SYSDIVMULTB_H	EQU	12
SYSDIVMULTX	EQU	2
SYSDIVMULTX_H	EQU	3
SYSINTEGERTEMPA	EQU	5
SYSINTEGERTEMPA_H	EQU	6
SYSINTEGERTEMPB	EQU	9
SYSINTEGERTEMPB_H	EQU	10
SYSINTEGERTEMPX	EQU	0
SYSINTEGERTEMPX_H	EQU	1
SYSLCDPRINTDATAHANDLER	EQU	265
SYSLCDPRINTDATAHANDLER_H	EQU	266
SYSLONGDIVMULTA	EQU	267
SYSLONGDIVMULTA_E	EQU	270
SYSLONGDIVMULTA_H	EQU	268
SYSLONGDIVMULTA_U	EQU	269
SYSLONGDIVMULTB	EQU	271
SYSLONGDIVMULTB_E	EQU	274
SYSLONGDIVMULTB_H	EQU	272
SYSLONGDIVMULTB_U	EQU	273
SYSLONGDIVMULTX	EQU	275
SYSLONGDIVMULTX_E	EQU	278
SYSLONGDIVMULTX_H	EQU	276
SYSLONGDIVMULTX_U	EQU	277
SYSLONGTEMPA	EQU	5
SYSLONGTEMPA_E	EQU	8
SYSLONGTEMPA_H	EQU	6
SYSLONGTEMPA_U	EQU	7
SYSLONGTEMPB	EQU	9
SYSLONGTEMPB_E	EQU	12
SYSLONGTEMPB_H	EQU	10
SYSLONGTEMPB_U	EQU	11
SYSLONGTEMPX	EQU	0
SYSLONGTEMPX_E	EQU	3
SYSLONGTEMPX_H	EQU	1
SYSLONGTEMPX_U	EQU	2
SYSREPEATTEMP1	EQU	279
SYSREPEATTEMP2	EQU	280
SYSREPEATTEMP3	EQU	281
SYSSIGNBYTE	EQU	13
SYSSTRDATA	EQU	282
SYSSTRINGA	EQU	7
SYSSTRINGA_H	EQU	8
SYSSTRINGLENGTH	EQU	6
SYSSTRINGPARAM1	EQU	8022
SYSSTRINGTEMP	EQU	283
SYSSTRLEN	EQU	284
SYSSYSINSTRING2HANDLER	EQU	285
SYSSYSINSTRING2HANDLER_H	EQU	286
SYSSYSINSTRINGHANDLER	EQU	287
SYSSYSINSTRINGHANDLER_H	EQU	288
SYSTEMP1	EQU	289
SYSTEMP1_H	EQU	290
SYSTEMP2	EQU	291
SYSTEMP2_H	EQU	292
SYSTEMP3	EQU	293
SYSVALTEMP	EQU	294
SYSVALTEMP_H	EQU	295
SYSWAITTEMPMS	EQU	2
SYSWAITTEMPMS_H	EQU	3
SYSWORDTEMPA	EQU	5
SYSWORDTEMPA_H	EQU	6
SYSWORDTEMPB	EQU	9
SYSWORDTEMPB_H	EQU	10
SYSWORDTEMPX	EQU	0
SYSWORDTEMPX_H	EQU	1
TYPE	EQU	296
UPPERPAGE	EQU	297
VAL3	EQU	298
VAR1	EQU	299
VAR1_E	EQU	302
VAR1_H	EQU	300
VAR1_U	EQU	301
VAR2	EQU	303
VAR2_E	EQU	306
VAR2_H	EQU	304
VAR2_U	EQU	305
XCHAR	EQU	307
XLOOP	EQU	308
XOFFSET	EQU	309
XOFFSET2	EQU	311
XOFFSET2_H	EQU	312
XOFFSET3	EQU	313
XOFFSET3_H	EQU	314
XOFFSET_H	EQU	310
XRADIUS	EQU	315
XRADIUS_H	EQU	316
X_0	EQU	317
X_0_H	EQU	318
X_COORD	EQU	319
X_COORD_H	EQU	320
X_MAX	EQU	321
X_MAX_H	EQU	322
X_MINUS	EQU	323
X_MINUS_H	EQU	324
X_OFFSET	EQU	325
X_OFFSET_H	EQU	326
X_PLUS	EQU	327
X_PLUS_H	EQU	328
X_SLOPE	EQU	329
X_SLOPE_E	EQU	332
X_SLOPE_H	EQU	330
X_SLOPE_U	EQU	331
YCALC1	EQU	333
YCALC1_H	EQU	334
YCALC2	EQU	335
YCALC2_H	EQU	336
YOFFSET	EQU	337
YOFFSET2	EQU	339
YOFFSET2_H	EQU	340
YOFFSET3	EQU	341
YOFFSET3_H	EQU	342
YOFFSET_H	EQU	338
Y_0	EQU	343
Y_0_H	EQU	344
Y_COORD	EQU	345
Y_COORD_H	EQU	346
Y_MAX	EQU	347
Y_MAX_H	EQU	348
Y_MINUS	EQU	349
Y_MINUS_H	EQU	350
Y_OFFSET	EQU	351
Y_OFFSET_H	EQU	352
Y_PLUS	EQU	353
Y_PLUS_H	EQU	354
Y_SLOPE	EQU	355
Y_SLOPE_E	EQU	358
Y_SLOPE_H	EQU	356
Y_SLOPE_U	EQU	357
_GLCDPAGE	EQU	359
_GLCDPAGESH	EQU	360
_GLCDPAGESL	EQU	361

;********************************************************************************

;Alias variables
AFSR0	EQU	16361
AFSR0_H	EQU	16362
SYSFNLSRLONG	EQU	96
SYSFNLSRLONG_H	EQU	101
SYSFNLSRLONG_U	EQU	102
SYSFNLSRLONG_E	EQU	100
SYSFNLSRWORD	EQU	96
SYSFNLSRWORD_H	EQU	101
SYSLEFTPAD_0	EQU	8044
SYSSTR_0	EQU	8016

;********************************************************************************

;Vectors
	ORG	0
	goto	BASPROGRAMSTART
	ORG	8
	retfie

;********************************************************************************

;Start of program memory page 0
	ORG	12
BASPROGRAMSTART
;Call initialisation routines
	call	INITSYS
	call	INITPPS
	call	INIT_EPD2IN13D
	call	INITRANDOM

;Start of the main program
;''A demonstration program for Explicit-Paper.
;''-------------------------------------------------------------------------
;-------------------------------------------------------
;''This has been tested using the hardware and software SPI option.
;''*************************************************************************
;*******
;Chip Settings.
;PPS Tool version: 0.0.5.27
;PinManager data: v1.78
;Generated for 18F47K42
;
;Template comment at the start of the config file
;
;#define PPSToolPart 18F47K42
;Template comment at the end of the config file
;******************************************************************************************************
;The following should be used   '#define EPD_HardwareSPI     'remove comment out if you want to use software SPI.
;#define EPD_HardwareSPI
;***************************************************************************
;***************************
;Setup the E-Paper
;#define GLCD_TYPE GLCD_TYPE_EPD_EPD2in13D
;#define GLCD_EXTENDEDFONTSET1
;#define GLCD_TYPE_EPD2in13D_LOWMEMORY2_GLCD_MODE
;#define GLCD_OLED_FONT
;#define GLCD_PROTECTOVERRUN
;Pin mappings for SPI - this GLCD driver supports Hardware SPI and Software SPI
;#define GLCD_DC     portB.7   ' Data(hight)/ command(low) line
;#define GLCD_CS     portC.1   ' Chip select line (negate)
;#define GLCD_RESET  portD.2   ' Reset line       (negate)
;#define GLCD_DO     portC.5   ' GLCD MOSI connect to MCU SDO
;#define GLCD_SCK    portC.3   ' Clock Line
;#define GLCD_Busy   portC.0   ' Busy Line
;#define GLCD_DC     DIGITAL_9
;#define GLCD_CS     DIGITAL_10
;#define GLCD_RESET  DIGITAL_8
;#define GLCD_DO     DIGITAL_11
;#define GLCD_SCK    DIGITAL_13
;#define GLCD_Busy   DIGITAL_7
;Dim ind, counter, ind_raw, ind_col as word
;Dim DataVar, dummy, Flag, VERBOSE as byte
;Dim x_min, x_max, y_min, y_max as Word
;Dim MyString, MyString1 as String
;******************************************************************************************************
;******************************************************************************************************
;Main program
;dim upperPage, lowerPage as Byte
;upperPage = 0
	banksel	UPPERPAGE
	clrf	UPPERPAGE,BANKED
;lowerPage = EPD_N_PAGE-1
	movlw	25
	banksel	LOWERPAGE
	movwf	LOWERPAGE,BANKED
;GLCDForeground = TFT_BLACK
	clrf	GLCDFOREGROUND,BANKED
	clrf	GLCDFOREGROUND_H,BANKED
;GLCDBackground = TFT_WHITE
	setf	GLCDBACKGROUND,BANKED
	setf	GLCDBACKGROUND_H,BANKED
;GLCD_Open_PageTransaction
;Macro Source: epd_epd2in13d.h (921)
;dim _GLCDPage as byte
;dim _GLCDPagesL, _GLCDPagesH as byte
;Clear_buffer_EPD2in13D
	call	CLEAR_BUFFER_EPD2IN13D
;for _GLCDPage = _GLCDPagesL to _GLCDPagesH    '_GLCDPage is a global variable - DO NOT CHANGE!!!
	banksel	_GLCDPAGESL
	decf	_GLCDPAGESL,W,BANKED
	movwf	_GLCDPAGE,BANKED
	movf	_GLCDPAGESL,W,BANKED
	subwf	_GLCDPAGESH,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd1
SysForLoop1
	incf	_GLCDPAGE,F,BANKED
;GLCDPrint 0,0, STR(GLCDVERSION)
	banksel	PRINTLOCX
	clrf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	clrf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	movlw	1
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP,BANKED
	clrf	SYSVALTEMP_H,BANKED
	banksel	0
	call	FN_STR
	movlw	low STR
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high STR
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	banksel	0
	call	GLCDPRINT4
;GLCDPrint 0,8, STR(EPD2_13VERSION)
	clrf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	8
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	movlw	1
	banksel	SYSVALTEMP
	movwf	SYSVALTEMP,BANKED
	clrf	SYSVALTEMP_H,BANKED
	banksel	0
	call	FN_STR
	movlw	low STR
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high STR
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	banksel	0
	call	GLCDPRINT4
;GLCD_Close_PageTransaction
;Macro Source: epd_epd2in13d.h (933)
;Pixel_To_Display_EPD2in13D
	call	PIXEL_TO_DISPLAY_EPD2IN13D
;next
	banksel	_GLCDPAGESH
	movf	_GLCDPAGESH,W,BANKED
	subwf	_GLCDPAGE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop1
SysForLoopEnd1
;SendCommand_EPD2in13D(DISPLAY_REFRESH)
	movlw	18
	movwf	EPD2IN13D_COMMAND,ACCESS
	banksel	0
	call	SENDCOMMAND_EPD2IN13D
;end
	goto	BASPROGRAMEND
;GLCDCLS
;GLCDSleep
;
;do
;
;loop
;
;
;
;
MM
;GLCD_Open_PageTransaction
;Macro Source: epd_epd2in13d.h (921)
;dim _GLCDPage as byte
;dim _GLCDPagesL, _GLCDPagesH as byte
;Clear_buffer_EPD2in13D
	call	CLEAR_BUFFER_EPD2IN13D
;for _GLCDPage = _GLCDPagesL to _GLCDPagesH    '_GLCDPage is a global variable - DO NOT CHANGE!!!
	banksel	_GLCDPAGESL
	decf	_GLCDPAGESL,W,BANKED
	movwf	_GLCDPAGE,BANKED
	movf	_GLCDPAGESL,W,BANKED
	subwf	_GLCDPAGESH,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd2
SysForLoop2
	incf	_GLCDPAGE,F,BANKED
;GLCDDrawString(2,2 ,"1Caso Probabile")
	movlw	2
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	2
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable1
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable1
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;GLCDDrawString(2,12 ,"perche la rela")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	12
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable2
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable2
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;GLCDDrawString(2,22 ,"zione non era")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	22
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable3
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable3
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;GLCDDrawString(2,32 ,"attendibile.")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	32
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable4
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable4
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;GLCDDrawString(2,42 ,"Comunque la ")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	42
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable5
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable5
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;GLCDDrawString(2,52 ,"nuova versione")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	52
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable6
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable6
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;GLCDDrawString(2,62 ,"dara risultati")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	62
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable7
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable7
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;GLCDDrawString(2,72 ,"migliori?")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	72
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable8
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable8
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;GLCDDrawString(2,108,"Seconda Parte")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	108
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable9
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable9
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;GLCDDrawString(2,118,"dello schermo")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	118
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable10
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable10
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;GLCDDrawString(2,128,"con un buffer")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	128
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable11
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable11
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;GLCDDrawString(2,138,"ridotto. Si puo")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	138
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;GLCDDrawString(2,148,"anche disegnare")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	148
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable13
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable13
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;GLCDDrawString(2,158,"fig. geometriche")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	158
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable14
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable14
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;GLCD_Close_PageTransaction
;Macro Source: epd_epd2in13d.h (933)
;Pixel_To_Display_EPD2in13D
	call	PIXEL_TO_DISPLAY_EPD2IN13D
;next
	banksel	_GLCDPAGESH
	movf	_GLCDPAGESH,W,BANKED
	subwf	_GLCDPAGE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop2
SysForLoopEnd2
;SendCommand_EPD2in13D(DISPLAY_REFRESH)
	movlw	18
	movwf	EPD2IN13D_COMMAND,ACCESS
	banksel	0
	call	SENDCOMMAND_EPD2IN13D
;wait 1000 ms
	movlw	232
	movwf	SysWaitTempMS,ACCESS
	movlw	3
	movwf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;GLCD_Open_PageTransaction
;Macro Source: epd_epd2in13d.h (921)
;dim _GLCDPage as byte
;dim _GLCDPagesL, _GLCDPagesH as byte
;Clear_buffer_EPD2in13D
	call	CLEAR_BUFFER_EPD2IN13D
;for _GLCDPage = _GLCDPagesL to _GLCDPagesH    '_GLCDPage is a global variable - DO NOT CHANGE!!!
	banksel	_GLCDPAGESL
	decf	_GLCDPAGESL,W,BANKED
	movwf	_GLCDPAGE,BANKED
	movf	_GLCDPAGESL,W,BANKED
	subwf	_GLCDPAGESH,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd3
SysForLoop3
	incf	_GLCDPAGE,F,BANKED
;box 1,1,GLCDDeviceWidth-1, GLCDDeviceHeight-1
	movlw	1
	banksel	LINEX1
	movwf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	1
	movwf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	1
	subwf	GLCDDEVICEWIDTH,W,BANKED
	movwf	LINEX2,BANKED
	movlw	0
	subwfb	GLCDDEVICEWIDTH_H,W,BANKED
	movwf	LINEX2_H,BANKED
	movlw	1
	subwf	GLCDDEVICEHEIGHT,W,BANKED
	movwf	LINEY2,BANKED
	movlw	0
	subwfb	GLCDDEVICEHEIGHT_H,W,BANKED
	movwf	LINEY2_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	BOX
;GLCDPrintStringLn ( "1.First Ln" )
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable15
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable15
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	banksel	0
	call	GLCDPRINTSTRINGLN
;GLCDPrintStringLn ( "2.Second Ln" )
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable16
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable16
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	banksel	0
	call	GLCDPRINTSTRINGLN
;GLCDPrintStringLn ( "" )
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable17
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable17
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	banksel	0
	call	GLCDPRINTSTRINGLN
;GLCDPrintStringLn ( "4.Forth Ln" )
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable18
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable18
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	banksel	0
	call	GLCDPRINTSTRINGLN
;GLCDLocateString( 0, 5 )
	clrf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	5
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	call	GLCDLOCATESTRING
;GLCDPrintString ( "5." )
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable19
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable19
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	banksel	0
	call	GLCDPRINTSTRING
;GLCDPrintStringLn ( "Fifth Ln" )
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable20
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable20
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	banksel	0
	call	GLCDPRINTSTRINGLN
;GLCDPrintStringLn ( "6.Sixth Ln" )
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable21
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable21
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	banksel	0
	call	GLCDPRINTSTRINGLN
;GLCDLocateString( 0, 3 )
	clrf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	movlw	3
	movwf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	call	GLCDLOCATESTRING
;dim val3 as Byte
;val3 = 3
	movlw	3
	banksel	VAL3
	movwf	VAL3,BANKED
;GLCDPrintStringLn ( str( val3 ) + ".Third Ln" )
	movff	VAL3,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	banksel	0
	call	FN_STR
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	lfsr	0,STR
	call	SysCopyStringPart
	movlw	low StringTable22
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable22
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,SYSSTRINGPARAM1
	movffl	SysStringLength,INDF0
	movlw	low SYSSTRINGPARAM1
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	banksel	0
	call	GLCDPRINTSTRINGLN
;GLCD_Close_PageTransaction
;Macro Source: epd_epd2in13d.h (933)
;Pixel_To_Display_EPD2in13D
	call	PIXEL_TO_DISPLAY_EPD2IN13D
;next
	banksel	_GLCDPAGESH
	movf	_GLCDPAGESH,W,BANKED
	subwf	_GLCDPAGE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop3
SysForLoopEnd3
;SendCommand_EPD2in13D(DISPLAY_REFRESH)
	movlw	18
	movwf	EPD2IN13D_COMMAND,ACCESS
	banksel	0
	call	SENDCOMMAND_EPD2IN13D
;wait 1000 ms
	movlw	232
	movwf	SysWaitTempMS,ACCESS
	movlw	3
	movwf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;GLCD_Open_PageTransaction
;Macro Source: epd_epd2in13d.h (921)
;dim _GLCDPage as byte
;dim _GLCDPagesL, _GLCDPagesH as byte
;Clear_buffer_EPD2in13D
	call	CLEAR_BUFFER_EPD2IN13D
;for _GLCDPage = _GLCDPagesL to _GLCDPagesH    '_GLCDPage is a global variable - DO NOT CHANGE!!!
	banksel	_GLCDPAGESL
	decf	_GLCDPAGESL,W,BANKED
	movwf	_GLCDPAGE,BANKED
	movf	_GLCDPAGESL,W,BANKED
	subwf	_GLCDPAGESH,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd4
SysForLoop4
	incf	_GLCDPAGE,F,BANKED
;box 10, 10,GLCDDeviceWidth-10, GLCDDeviceHeight-10
	movlw	10
	banksel	LINEX1
	movwf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	10
	movwf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	10
	subwf	GLCDDEVICEWIDTH,W,BANKED
	movwf	LINEX2,BANKED
	movlw	0
	subwfb	GLCDDEVICEWIDTH_H,W,BANKED
	movwf	LINEX2_H,BANKED
	movlw	10
	subwf	GLCDDEVICEHEIGHT,W,BANKED
	movwf	LINEY2,BANKED
	movlw	0
	subwfb	GLCDDEVICEHEIGHT_H,W,BANKED
	movwf	LINEY2_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	BOX
;box 20, 20,GLCDDeviceWidth-20, GLCDDeviceHeight-20
	movlw	20
	movwf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	20
	movwf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	20
	subwf	GLCDDEVICEWIDTH,W,BANKED
	movwf	LINEX2,BANKED
	movlw	0
	subwfb	GLCDDEVICEWIDTH_H,W,BANKED
	movwf	LINEX2_H,BANKED
	movlw	20
	subwf	GLCDDEVICEHEIGHT,W,BANKED
	movwf	LINEY2,BANKED
	movlw	0
	subwfb	GLCDDEVICEHEIGHT_H,W,BANKED
	movwf	LINEY2_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	BOX
;box 30, 30,GLCDDeviceWidth-30, GLCDDeviceHeight-30
	movlw	30
	movwf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	30
	movwf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	30
	subwf	GLCDDEVICEWIDTH,W,BANKED
	movwf	LINEX2,BANKED
	movlw	0
	subwfb	GLCDDEVICEWIDTH_H,W,BANKED
	movwf	LINEX2_H,BANKED
	movlw	30
	subwf	GLCDDEVICEHEIGHT,W,BANKED
	movwf	LINEY2,BANKED
	movlw	0
	subwfb	GLCDDEVICEHEIGHT_H,W,BANKED
	movwf	LINEY2_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	BOX
;Filledbox 40, 40,GLCDDeviceWidth-40, GLCDDeviceHeight-40
	movlw	40
	movwf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	40
	movwf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	40
	subwf	GLCDDEVICEWIDTH,W,BANKED
	movwf	LINEX2,BANKED
	movlw	0
	subwfb	GLCDDEVICEWIDTH_H,W,BANKED
	movwf	LINEX2_H,BANKED
	movlw	40
	subwf	GLCDDEVICEHEIGHT,W,BANKED
	movwf	LINEY2,BANKED
	movlw	0
	subwfb	GLCDDEVICEHEIGHT_H,W,BANKED
	movwf	LINEY2_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	FILLEDBOX_EPD2IN13D
;GLCD_Close_PageTransaction
;Macro Source: epd_epd2in13d.h (933)
;Pixel_To_Display_EPD2in13D
	call	PIXEL_TO_DISPLAY_EPD2IN13D
;next
	banksel	_GLCDPAGESH
	movf	_GLCDPAGESH,W,BANKED
	subwf	_GLCDPAGE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop4
SysForLoopEnd4
;SendCommand_EPD2in13D(DISPLAY_REFRESH)
	movlw	18
	movwf	EPD2IN13D_COMMAND,ACCESS
	banksel	0
	call	SENDCOMMAND_EPD2IN13D
;wait 1000 ms
	movlw	232
	movwf	SysWaitTempMS,ACCESS
	movlw	3
	movwf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;GLCD_Open_PageTransaction
;Macro Source: epd_epd2in13d.h (921)
;dim _GLCDPage as byte
;dim _GLCDPagesL, _GLCDPagesH as byte
;Clear_buffer_EPD2in13D
	call	CLEAR_BUFFER_EPD2IN13D
;for _GLCDPage = _GLCDPagesL to _GLCDPagesH    '_GLCDPage is a global variable - DO NOT CHANGE!!!
	banksel	_GLCDPAGESL
	decf	_GLCDPAGESL,W,BANKED
	movwf	_GLCDPAGE,BANKED
	movf	_GLCDPAGESL,W,BANKED
	subwf	_GLCDPAGESH,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd5
SysForLoop5
	incf	_GLCDPAGE,F,BANKED
;GLCDDrawString(2,2 ,"Caso Probabile")
	movlw	2
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	2
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable23
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable23
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;GLCDDrawString(2,12 ,"perché la rela")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	12
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable24
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable24
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;GLCDDrawString(2,22 ,"zione non era")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	22
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable3
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable3
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;GLCDDrawString(2,32 ,"attendibile.")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	32
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable4
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable4
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;GLCDDrawString(2,42 ,"Comunque la ")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	42
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable5
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable5
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;GLCDDrawString(2,52 ,"nuova versione")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	52
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable6
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable6
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;GLCDDrawString(2,62 ,"darà risultati")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	62
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable25
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable25
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;GLCDDrawString(2,72 ,"migliori?")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	72
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable8
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable8
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;GLCDDrawString(2,108,"Seconda Parte")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	108
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable9
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable9
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;GLCDDrawString(2,118,"dello schermo")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	118
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable10
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable10
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;GLCDDrawString(2,128,"con un buffer")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	128
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable11
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable11
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;GLCDDrawString(2,138,"ridotto. Si può")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	138
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable26
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable26
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;GLCDDrawString(2,148,"anche disegnare")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	148
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable13
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable13
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;GLCDDrawString(2,158,"fig. geometriche")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	158
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable14
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable14
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;GLCDDrawString(2,168,"OLD FONT WILL ERROR!!")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	168
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable27
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable27
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;GLCD_Close_PageTransaction
;Macro Source: epd_epd2in13d.h (933)
;Pixel_To_Display_EPD2in13D
	call	PIXEL_TO_DISPLAY_EPD2IN13D
;next
	banksel	_GLCDPAGESH
	movf	_GLCDPAGESH,W,BANKED
	subwf	_GLCDPAGE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop5
SysForLoopEnd5
;SendCommand_EPD2in13D(DISPLAY_REFRESH)
	movlw	18
	movwf	EPD2IN13D_COMMAND,ACCESS
	banksel	0
	call	SENDCOMMAND_EPD2IN13D
;wait 1000 ms
	movlw	232
	movwf	SysWaitTempMS,ACCESS
	movlw	3
	movwf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;GLCD_Open_PageTransaction
;Macro Source: epd_epd2in13d.h (921)
;dim _GLCDPage as byte
;dim _GLCDPagesL, _GLCDPagesH as byte
;Clear_buffer_EPD2in13D
	call	CLEAR_BUFFER_EPD2IN13D
;for _GLCDPage = _GLCDPagesL to _GLCDPagesH    '_GLCDPage is a global variable - DO NOT CHANGE!!!
	banksel	_GLCDPAGESL
	decf	_GLCDPAGESL,W,BANKED
	movwf	_GLCDPAGE,BANKED
	movf	_GLCDPAGESL,W,BANKED
	subwf	_GLCDPAGESH,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd6
SysForLoop6
	incf	_GLCDPAGE,F,BANKED
;GLCDLocateString( 0, 0)
	banksel	PRINTLOCX
	clrf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	clrf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	call	GLCDLOCATESTRING
;dim xloop as byte
;for xloop = 1 to 26
	banksel	XLOOP
	clrf	XLOOP,BANKED
SysForLoop7
	incf	XLOOP,F,BANKED
;GLCDPrintString leftpad(Str(xloop),2)
	movff	XLOOP,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	banksel	0
	call	FN_STR
	movlw	low STR
	banksel	SYSSYSINSTRINGHANDLER
	movwf	SysSYSINSTRINGHandler,BANKED
	movlw	high STR
	movwf	SysSYSINSTRINGHandler_H,BANKED
	movlw	2
	movwf	SYSSTRLEN,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable77
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable77
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSSYSINSTRING2HANDLER
	movwf	SysSYSINSTRING2Handler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysSYSINSTRING2Handler_H,BANKED
	banksel	0
	call	FN_LEFTPAD
	movlw	low LEFTPAD
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high LEFTPAD
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	banksel	0
	call	GLCDPRINTSTRING
;GLCDPrintStringLN "-WaveShare"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable28
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable28
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	banksel	0
	call	GLCDPRINTSTRINGLN
;next
	movlw	26
	banksel	XLOOP
	subwf	XLOOP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop7
SysForLoopEnd7
;GLCD_Close_PageTransaction
;Macro Source: epd_epd2in13d.h (933)
;Pixel_To_Display_EPD2in13D
	banksel	0
	call	PIXEL_TO_DISPLAY_EPD2IN13D
;next
	banksel	_GLCDPAGESH
	movf	_GLCDPAGESH,W,BANKED
	subwf	_GLCDPAGE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop6
SysForLoopEnd6
;SendCommand_EPD2in13D(DISPLAY_REFRESH)
	movlw	18
	movwf	EPD2IN13D_COMMAND,ACCESS
	banksel	0
	call	SENDCOMMAND_EPD2IN13D
;wait 1000 ms
	movlw	232
	movwf	SysWaitTempMS,ACCESS
	movlw	3
	movwf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;GLCD_Open_PageTransaction
;Macro Source: epd_epd2in13d.h (921)
;dim _GLCDPage as byte
;dim _GLCDPagesL, _GLCDPagesH as byte
;Clear_buffer_EPD2in13D
	call	CLEAR_BUFFER_EPD2IN13D
;for _GLCDPage = _GLCDPagesL to _GLCDPagesH    '_GLCDPage is a global variable - DO NOT CHANGE!!!
	banksel	_GLCDPAGESL
	decf	_GLCDPAGESL,W,BANKED
	movwf	_GLCDPAGE,BANKED
	movf	_GLCDPAGESL,W,BANKED
	subwf	_GLCDPAGESH,W,BANKED
	btfss	STATUS, C,ACCESS
	goto	SysForLoopEnd8
SysForLoop8
	incf	_GLCDPAGE,F,BANKED
;FilledBox( 4, 4,42, 42, GLCDForeground)  'Filled Rectangle
	movlw	4
	banksel	LINEX1
	movwf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	4
	movwf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	42
	movwf	LINEX2,BANKED
	clrf	LINEX2_H,BANKED
	movlw	42
	movwf	LINEY2,BANKED
	clrf	LINEY2_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	FILLEDBOX_EPD2IN13D
;FilledBox( 5, 5,41, 41, GLCDBackground)
	movlw	5
	movwf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	5
	movwf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	41
	movwf	LINEX2,BANKED
	clrf	LINEX2_H,BANKED
	movlw	41
	movwf	LINEY2,BANKED
	clrf	LINEY2_H,BANKED
	movff	GLCDBACKGROUND,LINECOLOUR
	movff	GLCDBACKGROUND_H,LINECOLOUR_H
	call	FILLEDBOX_EPD2IN13D
;FilledBox( 6, 6,40, 40, GLCDForeground)
	movlw	6
	movwf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	6
	movwf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	40
	movwf	LINEX2,BANKED
	clrf	LINEX2_H,BANKED
	movlw	40
	movwf	LINEY2,BANKED
	clrf	LINEY2_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	FILLEDBOX_EPD2IN13D
;FilledBox( 7, 7,39, 39, GLCDBackground)
	movlw	7
	movwf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	7
	movwf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	39
	movwf	LINEX2,BANKED
	clrf	LINEX2_H,BANKED
	movlw	39
	movwf	LINEY2,BANKED
	clrf	LINEY2_H,BANKED
	movff	GLCDBACKGROUND,LINECOLOUR
	movff	GLCDBACKGROUND_H,LINECOLOUR_H
	call	FILLEDBOX_EPD2IN13D
;FilledBox( 8, 8,38, 38, GLCDForeground)
	movlw	8
	movwf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	8
	movwf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	38
	movwf	LINEX2,BANKED
	clrf	LINEX2_H,BANKED
	movlw	38
	movwf	LINEY2,BANKED
	clrf	LINEY2_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	FILLEDBOX_EPD2IN13D
;FilledBox( 9, 9,37, 37, GLCDBackground)
	movlw	9
	movwf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	9
	movwf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	37
	movwf	LINEX2,BANKED
	clrf	LINEX2_H,BANKED
	movlw	37
	movwf	LINEY2,BANKED
	clrf	LINEY2_H,BANKED
	movff	GLCDBACKGROUND,LINECOLOUR
	movff	GLCDBACKGROUND_H,LINECOLOUR_H
	call	FILLEDBOX_EPD2IN13D
;FilledBox(10,10,36, 36, GLCDForeground)
	movlw	10
	movwf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	10
	movwf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	36
	movwf	LINEX2,BANKED
	clrf	LINEX2_H,BANKED
	movlw	36
	movwf	LINEY2,BANKED
	clrf	LINEY2_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	FILLEDBOX_EPD2IN13D
;FilledBox(11,11,35, 35, GLCDBackground)
	movlw	11
	movwf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	11
	movwf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	35
	movwf	LINEX2,BANKED
	clrf	LINEX2_H,BANKED
	movlw	35
	movwf	LINEY2,BANKED
	clrf	LINEY2_H,BANKED
	movff	GLCDBACKGROUND,LINECOLOUR
	movff	GLCDBACKGROUND_H,LINECOLOUR_H
	call	FILLEDBOX_EPD2IN13D
;FilledBox(12,12,34, 34, GLCDForeground)
	movlw	12
	movwf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	12
	movwf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	34
	movwf	LINEX2,BANKED
	clrf	LINEX2_H,BANKED
	movlw	34
	movwf	LINEY2,BANKED
	clrf	LINEY2_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	FILLEDBOX_EPD2IN13D
;FilledBox(13,13,33, 33, GLCDBackground)
	movlw	13
	movwf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	13
	movwf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	33
	movwf	LINEX2,BANKED
	clrf	LINEX2_H,BANKED
	movlw	33
	movwf	LINEY2,BANKED
	clrf	LINEY2_H,BANKED
	movff	GLCDBACKGROUND,LINECOLOUR
	movff	GLCDBACKGROUND_H,LINECOLOUR_H
	call	FILLEDBOX_EPD2IN13D
;FilledBox(14,14,32, 32, GLCDForeground)
	movlw	14
	movwf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	14
	movwf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	32
	movwf	LINEX2,BANKED
	clrf	LINEX2_H,BANKED
	movlw	32
	movwf	LINEY2,BANKED
	clrf	LINEY2_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	FILLEDBOX_EPD2IN13D
;FilledBox(15,15,31, 31, GLCDBackground)
	movlw	15
	movwf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	15
	movwf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	31
	movwf	LINEX2,BANKED
	clrf	LINEX2_H,BANKED
	movlw	31
	movwf	LINEY2,BANKED
	clrf	LINEY2_H,BANKED
	movff	GLCDBACKGROUND,LINECOLOUR
	movff	GLCDBACKGROUND_H,LINECOLOUR_H
	call	FILLEDBOX_EPD2IN13D
;FilledCircle(77,25,23, GLCDForeground)              'Filled Circle
	movlw	77
	banksel	XOFFSET
	movwf	XOFFSET,BANKED
	clrf	XOFFSET_H,BANKED
	movlw	25
	movwf	YOFFSET,BANKED
	clrf	YOFFSET_H,BANKED
	movlw	23
	movwf	XRADIUS,BANKED
	clrf	XRADIUS_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	FILLEDCIRCLE
;FilledCircle(77,25,19, GLCDBackground)
	movlw	77
	banksel	XOFFSET
	movwf	XOFFSET,BANKED
	clrf	XOFFSET_H,BANKED
	movlw	25
	movwf	YOFFSET,BANKED
	clrf	YOFFSET_H,BANKED
	movlw	19
	movwf	XRADIUS,BANKED
	clrf	XRADIUS_H,BANKED
	movff	GLCDBACKGROUND,LINECOLOUR
	movff	GLCDBACKGROUND_H,LINECOLOUR_H
	banksel	0
	call	FILLEDCIRCLE
;FilledCircle(77,25,14, GLCDForeground)
	movlw	77
	banksel	XOFFSET
	movwf	XOFFSET,BANKED
	clrf	XOFFSET_H,BANKED
	movlw	25
	movwf	YOFFSET,BANKED
	clrf	YOFFSET_H,BANKED
	movlw	14
	movwf	XRADIUS,BANKED
	clrf	XRADIUS_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	FILLEDCIRCLE
;FilledCircle(77,25,11, GLCDBackground)
	movlw	77
	banksel	XOFFSET
	movwf	XOFFSET,BANKED
	clrf	XOFFSET_H,BANKED
	movlw	25
	movwf	YOFFSET,BANKED
	clrf	YOFFSET_H,BANKED
	movlw	11
	movwf	XRADIUS,BANKED
	clrf	XRADIUS_H,BANKED
	movff	GLCDBACKGROUND,LINECOLOUR
	movff	GLCDBACKGROUND_H,LINECOLOUR_H
	banksel	0
	call	FILLEDCIRCLE
;FilledCircle(77,25,5 , GLCDForeground)
	movlw	77
	banksel	XOFFSET
	movwf	XOFFSET,BANKED
	clrf	XOFFSET_H,BANKED
	movlw	25
	movwf	YOFFSET,BANKED
	clrf	YOFFSET_H,BANKED
	movlw	5
	movwf	XRADIUS,BANKED
	clrf	XRADIUS_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	FILLEDCIRCLE
;FilledCircle(77,25,2 , GLCDBackground)
	movlw	77
	banksel	XOFFSET
	movwf	XOFFSET,BANKED
	clrf	XOFFSET_H,BANKED
	movlw	25
	movwf	YOFFSET,BANKED
	clrf	YOFFSET_H,BANKED
	movlw	2
	movwf	XRADIUS,BANKED
	clrf	XRADIUS_H,BANKED
	movff	GLCDBACKGROUND,LINECOLOUR
	movff	GLCDBACKGROUND_H,LINECOLOUR_H
	banksel	0
	call	FILLEDCIRCLE
;FilledEllipse(25,60,16,8, GLCDForeground)           'Filled Ellipse
	movlw	25
	banksel	XOFFSET
	movwf	XOFFSET,BANKED
	clrf	XOFFSET_H,BANKED
	movlw	60
	movwf	YOFFSET,BANKED
	clrf	YOFFSET_H,BANKED
	movlw	16
	banksel	INXRADIUS
	movwf	INXRADIUS,BANKED
	clrf	INXRADIUS_H,BANKED
	movlw	8
	movwf	INYRADIUS,BANKED
	clrf	INYRADIUS_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	FILLEDELLIPSE
;FilledEllipse(25,60,14,7, GLCDBackground)
	movlw	25
	banksel	XOFFSET
	movwf	XOFFSET,BANKED
	clrf	XOFFSET_H,BANKED
	movlw	60
	movwf	YOFFSET,BANKED
	clrf	YOFFSET_H,BANKED
	movlw	14
	banksel	INXRADIUS
	movwf	INXRADIUS,BANKED
	clrf	INXRADIUS_H,BANKED
	movlw	7
	movwf	INYRADIUS,BANKED
	clrf	INYRADIUS_H,BANKED
	movff	GLCDBACKGROUND,LINECOLOUR
	movff	GLCDBACKGROUND_H,LINECOLOUR_H
	call	FILLEDELLIPSE
;FilledEllipse(25,60,12,6, GLCDForeground)
	movlw	25
	banksel	XOFFSET
	movwf	XOFFSET,BANKED
	clrf	XOFFSET_H,BANKED
	movlw	60
	movwf	YOFFSET,BANKED
	clrf	YOFFSET_H,BANKED
	movlw	12
	banksel	INXRADIUS
	movwf	INXRADIUS,BANKED
	clrf	INXRADIUS_H,BANKED
	movlw	6
	movwf	INYRADIUS,BANKED
	clrf	INYRADIUS_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	FILLEDELLIPSE
;FilledEllipse(25,60,10,5, GLCDBackground)
	movlw	25
	banksel	XOFFSET
	movwf	XOFFSET,BANKED
	clrf	XOFFSET_H,BANKED
	movlw	60
	movwf	YOFFSET,BANKED
	clrf	YOFFSET_H,BANKED
	movlw	10
	banksel	INXRADIUS
	movwf	INXRADIUS,BANKED
	clrf	INXRADIUS_H,BANKED
	movlw	5
	movwf	INYRADIUS,BANKED
	clrf	INYRADIUS_H,BANKED
	movff	GLCDBACKGROUND,LINECOLOUR
	movff	GLCDBACKGROUND_H,LINECOLOUR_H
	call	FILLEDELLIPSE
;FilledEllipse(25,60,8 ,4, GLCDForeground)
	movlw	25
	banksel	XOFFSET
	movwf	XOFFSET,BANKED
	clrf	XOFFSET_H,BANKED
	movlw	60
	movwf	YOFFSET,BANKED
	clrf	YOFFSET_H,BANKED
	movlw	8
	banksel	INXRADIUS
	movwf	INXRADIUS,BANKED
	clrf	INXRADIUS_H,BANKED
	movlw	4
	movwf	INYRADIUS,BANKED
	clrf	INYRADIUS_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	FILLEDELLIPSE
;FilledEllipse(25,60,6, 3, GLCDBackground)
	movlw	25
	banksel	XOFFSET
	movwf	XOFFSET,BANKED
	clrf	XOFFSET_H,BANKED
	movlw	60
	movwf	YOFFSET,BANKED
	clrf	YOFFSET_H,BANKED
	movlw	6
	banksel	INXRADIUS
	movwf	INXRADIUS,BANKED
	clrf	INXRADIUS_H,BANKED
	movlw	3
	movwf	INYRADIUS,BANKED
	clrf	INYRADIUS_H,BANKED
	movff	GLCDBACKGROUND,LINECOLOUR
	movff	GLCDBACKGROUND_H,LINECOLOUR_H
	call	FILLEDELLIPSE
;FillRoundRect(50,50,100,100,GLCDForeground)         'Filled rounded
	movlw	50
	movwf	RX1,BANKED
	clrf	RX1_H,BANKED
	movlw	50
	movwf	RY1,BANKED
	clrf	RY1_H,BANKED
	movlw	100
	movwf	RX2,BANKED
	clrf	RX2_H,BANKED
	movlw	100
	movwf	RY2,BANKED
	clrf	RY2_H,BANKED
	movff	GLCDFOREGROUND,COLOR
	movff	GLCDFOREGROUND_H,COLOR_H
	call	FILLROUNDRECT
;FillRoundRect(55,55,95 ,95, GLCDBackground)
	movlw	55
	movwf	RX1,BANKED
	clrf	RX1_H,BANKED
	movlw	55
	movwf	RY1,BANKED
	clrf	RY1_H,BANKED
	movlw	95
	movwf	RX2,BANKED
	clrf	RX2_H,BANKED
	movlw	95
	movwf	RY2,BANKED
	clrf	RY2_H,BANKED
	movff	GLCDBACKGROUND,COLOR
	movff	GLCDBACKGROUND_H,COLOR_H
	call	FILLROUNDRECT
;FillRoundRect(60,60,90 ,90, GLCDForeground)
	movlw	60
	movwf	RX1,BANKED
	clrf	RX1_H,BANKED
	movlw	60
	movwf	RY1,BANKED
	clrf	RY1_H,BANKED
	movlw	90
	movwf	RX2,BANKED
	clrf	RX2_H,BANKED
	movlw	90
	movwf	RY2,BANKED
	clrf	RY2_H,BANKED
	movff	GLCDFOREGROUND,COLOR
	movff	GLCDFOREGROUND_H,COLOR_H
	call	FILLROUNDRECT
;FillRoundRect(65,65,85 ,85, GLCDBackground)
	movlw	65
	movwf	RX1,BANKED
	clrf	RX1_H,BANKED
	movlw	65
	movwf	RY1,BANKED
	clrf	RY1_H,BANKED
	movlw	85
	movwf	RX2,BANKED
	clrf	RX2_H,BANKED
	movlw	85
	movwf	RY2,BANKED
	clrf	RY2_H,BANKED
	movff	GLCDBACKGROUND,COLOR
	movff	GLCDBACKGROUND_H,COLOR_H
	call	FILLROUNDRECT
;FillRoundRect(70,70,80 ,80, GLCDForeground)
	movlw	70
	movwf	RX1,BANKED
	clrf	RX1_H,BANKED
	movlw	70
	movwf	RY1,BANKED
	clrf	RY1_H,BANKED
	movlw	80
	movwf	RX2,BANKED
	clrf	RX2_H,BANKED
	movlw	80
	movwf	RY2,BANKED
	clrf	RY2_H,BANKED
	movff	GLCDFOREGROUND,COLOR
	movff	GLCDFOREGROUND_H,COLOR_H
	call	FILLROUNDRECT
;FillRoundRect(75,75,75 ,75, GLCDBackground)
	movlw	75
	movwf	RX1,BANKED
	clrf	RX1_H,BANKED
	movlw	75
	movwf	RY1,BANKED
	clrf	RY1_H,BANKED
	movlw	75
	movwf	RX2,BANKED
	clrf	RX2_H,BANKED
	movlw	75
	movwf	RY2,BANKED
	clrf	RY2_H,BANKED
	movff	GLCDBACKGROUND,COLOR
	movff	GLCDBACKGROUND_H,COLOR_H
	call	FILLROUNDRECT
;FillRoundRect(80,80,80 ,80, GLCDForeground)
	movlw	80
	movwf	RX1,BANKED
	clrf	RX1_H,BANKED
	movlw	80
	movwf	RY1,BANKED
	clrf	RY1_H,BANKED
	movlw	80
	movwf	RX2,BANKED
	clrf	RX2_H,BANKED
	movlw	80
	movwf	RY2,BANKED
	clrf	RY2_H,BANKED
	movff	GLCDFOREGROUND,COLOR
	movff	GLCDFOREGROUND_H,COLOR_H
	call	FILLROUNDRECT
;FilledTriangle(25,70,2,102,46,102, GLCDForeground)  'Filled Triangle
	movlw	25
	banksel	XOFFSET
	movwf	XOFFSET,BANKED
	clrf	XOFFSET_H,BANKED
	movlw	70
	movwf	YOFFSET,BANKED
	clrf	YOFFSET_H,BANKED
	movlw	2
	movwf	XOFFSET2,BANKED
	clrf	XOFFSET2_H,BANKED
	movlw	102
	movwf	YOFFSET2,BANKED
	clrf	YOFFSET2_H,BANKED
	movlw	46
	movwf	XOFFSET3,BANKED
	clrf	XOFFSET3_H,BANKED
	movlw	102
	movwf	YOFFSET3,BANKED
	clrf	YOFFSET3_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	FILLEDTRIANGLE
;FilledTriangle(25,78,10,98,38,98 , GLCDBackground)
	movlw	25
	banksel	XOFFSET
	movwf	XOFFSET,BANKED
	clrf	XOFFSET_H,BANKED
	movlw	78
	movwf	YOFFSET,BANKED
	clrf	YOFFSET_H,BANKED
	movlw	10
	movwf	XOFFSET2,BANKED
	clrf	XOFFSET2_H,BANKED
	movlw	98
	movwf	YOFFSET2,BANKED
	clrf	YOFFSET2_H,BANKED
	movlw	38
	movwf	XOFFSET3,BANKED
	clrf	XOFFSET3_H,BANKED
	movlw	98
	movwf	YOFFSET3,BANKED
	clrf	YOFFSET3_H,BANKED
	movff	GLCDBACKGROUND,LINECOLOUR
	movff	GLCDBACKGROUND_H,LINECOLOUR_H
	banksel	0
	call	FILLEDTRIANGLE
;FilledTriangle(25,86,18,94,30,94 , GLCDForeground)
	movlw	25
	banksel	XOFFSET
	movwf	XOFFSET,BANKED
	clrf	XOFFSET_H,BANKED
	movlw	86
	movwf	YOFFSET,BANKED
	clrf	YOFFSET_H,BANKED
	movlw	18
	movwf	XOFFSET2,BANKED
	clrf	XOFFSET2_H,BANKED
	movlw	94
	movwf	YOFFSET2,BANKED
	clrf	YOFFSET2_H,BANKED
	movlw	30
	movwf	XOFFSET3,BANKED
	clrf	XOFFSET3_H,BANKED
	movlw	94
	movwf	YOFFSET3,BANKED
	clrf	YOFFSET3_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	FILLEDTRIANGLE
;FilledBox(8, 108,90,148, GLCDForeground) 'Filled rectangle
	movlw	8
	movwf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	108
	movwf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	90
	movwf	LINEX2,BANKED
	clrf	LINEX2_H,BANKED
	movlw	148
	movwf	LINEY2,BANKED
	clrf	LINEY2_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	FILLEDBOX_EPD2IN13D
;FilledBox(18,118,80, 136, GLCDBackground)
	movlw	18
	movwf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	118
	movwf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	80
	movwf	LINEX2,BANKED
	clrf	LINEX2_H,BANKED
	movlw	136
	movwf	LINEY2,BANKED
	clrf	LINEY2_H,BANKED
	movff	GLCDBACKGROUND,LINECOLOUR
	movff	GLCDBACKGROUND_H,LINECOLOUR_H
	call	FILLEDBOX_EPD2IN13D
;FilledBox(28,128,70, 126, GLCDForeground)
	movlw	28
	movwf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	128
	movwf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	70
	movwf	LINEX2,BANKED
	clrf	LINEX2_H,BANKED
	movlw	126
	movwf	LINEY2,BANKED
	clrf	LINEY2_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	FILLEDBOX_EPD2IN13D
;GLCDDrawString(9,108 ,"Rectangle..1")
	movlw	9
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	108
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable29
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable29
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;GLCDDrawString(19,117 ,"Rectangle..2")
	movlw	19
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	117
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable30
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable30
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;GLCDDrawString(19,149 ,"Hyperbole")
	movlw	19
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	149
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable31
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable31
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;Hyperbole(50,181, 4, 2, 1,1, GLCDForeground)        'Hyperbole
	movlw	50
	banksel	X_0
	movwf	X_0,BANKED
	clrf	X_0_H,BANKED
	movlw	181
	movwf	Y_0,BANKED
	clrf	Y_0_H,BANKED
	movlw	4
	movwf	A_AXIS,ACCESS
	clrf	A_AXIS_H,ACCESS
	movlw	2
	movwf	B_AXIS,ACCESS
	clrf	B_AXIS_H,ACCESS
	movlw	1
	movwf	TYPE,BANKED
	movlw	1
	banksel	MODESTOP
	movwf	MODESTOP,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	HYPERBOLE
	movff	LINECOLOUR,GLCDFOREGROUND
	movff	LINECOLOUR_H,GLCDFOREGROUND_H
;Hyperbole(50,181, 6, 3, 1,1, GLCDBackground)
	movlw	50
	banksel	X_0
	movwf	X_0,BANKED
	clrf	X_0_H,BANKED
	movlw	181
	movwf	Y_0,BANKED
	clrf	Y_0_H,BANKED
	movlw	6
	movwf	A_AXIS,ACCESS
	clrf	A_AXIS_H,ACCESS
	movlw	3
	movwf	B_AXIS,ACCESS
	clrf	B_AXIS_H,ACCESS
	movlw	1
	movwf	TYPE,BANKED
	movlw	1
	banksel	MODESTOP
	movwf	MODESTOP,BANKED
	movff	GLCDBACKGROUND,LINECOLOUR
	movff	GLCDBACKGROUND_H,LINECOLOUR_H
	call	HYPERBOLE
	movff	LINECOLOUR,GLCDBACKGROUND
	movff	LINECOLOUR_H,GLCDBACKGROUND_H
;Hyperbole(50,181,10, 5, 1,1, GLCDForeground)
	movlw	50
	banksel	X_0
	movwf	X_0,BANKED
	clrf	X_0_H,BANKED
	movlw	181
	movwf	Y_0,BANKED
	clrf	Y_0_H,BANKED
	movlw	10
	movwf	A_AXIS,ACCESS
	clrf	A_AXIS_H,ACCESS
	movlw	5
	movwf	B_AXIS,ACCESS
	clrf	B_AXIS_H,ACCESS
	movlw	1
	movwf	TYPE,BANKED
	movlw	1
	banksel	MODESTOP
	movwf	MODESTOP,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	HYPERBOLE
	movff	LINECOLOUR,GLCDFOREGROUND
	movff	LINECOLOUR_H,GLCDFOREGROUND_H
;Hyperbole(50,181,14, 7, 1,1, GLCDBackground)
	movlw	50
	banksel	X_0
	movwf	X_0,BANKED
	clrf	X_0_H,BANKED
	movlw	181
	movwf	Y_0,BANKED
	clrf	Y_0_H,BANKED
	movlw	14
	movwf	A_AXIS,ACCESS
	clrf	A_AXIS_H,ACCESS
	movlw	7
	movwf	B_AXIS,ACCESS
	clrf	B_AXIS_H,ACCESS
	movlw	1
	movwf	TYPE,BANKED
	movlw	1
	banksel	MODESTOP
	movwf	MODESTOP,BANKED
	movff	GLCDBACKGROUND,LINECOLOUR
	movff	GLCDBACKGROUND_H,LINECOLOUR_H
	call	HYPERBOLE
	movff	LINECOLOUR,GLCDBACKGROUND
	movff	LINECOLOUR_H,GLCDBACKGROUND_H
;Hyperbole(50,181,18, 9, 1,1, GLCDForeground)
	movlw	50
	banksel	X_0
	movwf	X_0,BANKED
	clrf	X_0_H,BANKED
	movlw	181
	movwf	Y_0,BANKED
	clrf	Y_0_H,BANKED
	movlw	18
	movwf	A_AXIS,ACCESS
	clrf	A_AXIS_H,ACCESS
	movlw	9
	movwf	B_AXIS,ACCESS
	clrf	B_AXIS_H,ACCESS
	movlw	1
	movwf	TYPE,BANKED
	movlw	1
	banksel	MODESTOP
	movwf	MODESTOP,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	HYPERBOLE
	movff	LINECOLOUR,GLCDFOREGROUND
	movff	LINECOLOUR_H,GLCDFOREGROUND_H
;Hyperbole(50,181,22,11, 1,1, GLCDBackground)
	movlw	50
	banksel	X_0
	movwf	X_0,BANKED
	clrf	X_0_H,BANKED
	movlw	181
	movwf	Y_0,BANKED
	clrf	Y_0_H,BANKED
	movlw	22
	movwf	A_AXIS,ACCESS
	clrf	A_AXIS_H,ACCESS
	movlw	11
	movwf	B_AXIS,ACCESS
	clrf	B_AXIS_H,ACCESS
	movlw	1
	movwf	TYPE,BANKED
	movlw	1
	banksel	MODESTOP
	movwf	MODESTOP,BANKED
	movff	GLCDBACKGROUND,LINECOLOUR
	movff	GLCDBACKGROUND_H,LINECOLOUR_H
	call	HYPERBOLE
	movff	LINECOLOUR,GLCDBACKGROUND
	movff	LINECOLOUR_H,GLCDBACKGROUND_H
;Hyperbole(50,181,26,13, 1,1, GLCDForeground)
	movlw	50
	banksel	X_0
	movwf	X_0,BANKED
	clrf	X_0_H,BANKED
	movlw	181
	movwf	Y_0,BANKED
	clrf	Y_0_H,BANKED
	movlw	26
	movwf	A_AXIS,ACCESS
	clrf	A_AXIS_H,ACCESS
	movlw	13
	movwf	B_AXIS,ACCESS
	clrf	B_AXIS_H,ACCESS
	movlw	1
	movwf	TYPE,BANKED
	movlw	1
	banksel	MODESTOP
	movwf	MODESTOP,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	HYPERBOLE
	movff	LINECOLOUR,GLCDFOREGROUND
	movff	LINECOLOUR_H,GLCDFOREGROUND_H
;Hyperbole(50,181,30,15, 1,1, GLCDBackground)
	movlw	50
	banksel	X_0
	movwf	X_0,BANKED
	clrf	X_0_H,BANKED
	movlw	181
	movwf	Y_0,BANKED
	clrf	Y_0_H,BANKED
	movlw	30
	movwf	A_AXIS,ACCESS
	clrf	A_AXIS_H,ACCESS
	movlw	15
	movwf	B_AXIS,ACCESS
	clrf	B_AXIS_H,ACCESS
	movlw	1
	movwf	TYPE,BANKED
	movlw	1
	banksel	MODESTOP
	movwf	MODESTOP,BANKED
	movff	GLCDBACKGROUND,LINECOLOUR
	movff	GLCDBACKGROUND_H,LINECOLOUR_H
	call	HYPERBOLE
	movff	LINECOLOUR,GLCDBACKGROUND
	movff	LINECOLOUR_H,GLCDBACKGROUND_H
;Hyperbole(50,181,34,17, 1,1, GLCDForeground)
	movlw	50
	banksel	X_0
	movwf	X_0,BANKED
	clrf	X_0_H,BANKED
	movlw	181
	movwf	Y_0,BANKED
	clrf	Y_0_H,BANKED
	movlw	34
	movwf	A_AXIS,ACCESS
	clrf	A_AXIS_H,ACCESS
	movlw	17
	movwf	B_AXIS,ACCESS
	clrf	B_AXIS_H,ACCESS
	movlw	1
	movwf	TYPE,BANKED
	movlw	1
	banksel	MODESTOP
	movwf	MODESTOP,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	call	HYPERBOLE
	movff	LINECOLOUR,GLCDFOREGROUND
	movff	LINECOLOUR_H,GLCDFOREGROUND_H
;GLCD_Close_PageTransaction                 'Close Transaction
;Macro Source: epd_epd2in13d.h (933)
;Pixel_To_Display_EPD2in13D
	call	PIXEL_TO_DISPLAY_EPD2IN13D
;next
	banksel	_GLCDPAGESH
	movf	_GLCDPAGESH,W,BANKED
	subwf	_GLCDPAGE,W,BANKED
	btfss	STATUS, C,ACCESS
	goto	SysForLoop8
SysForLoopEnd8
;SendCommand_EPD2in13D(DISPLAY_REFRESH)
	movlw	18
	movwf	EPD2IN13D_COMMAND,ACCESS
	banksel	0
	call	SENDCOMMAND_EPD2IN13D
;wait 1000 ms
	movlw	232
	movwf	SysWaitTempMS,ACCESS
	movlw	3
	movwf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;dim xloop, rnumber as byte
;rnumber=RANDOM
	call	FN_RANDOM
	movff	RANDOM,RNUMBER
;GLCD_Open_PageTransaction
;Macro Source: epd_epd2in13d.h (921)
;dim _GLCDPage as byte
;dim _GLCDPagesL, _GLCDPagesH as byte
;Clear_buffer_EPD2in13D
	rcall	CLEAR_BUFFER_EPD2IN13D
;for _GLCDPage = _GLCDPagesL to _GLCDPagesH    '_GLCDPage is a global variable - DO NOT CHANGE!!!
	banksel	_GLCDPAGESL
	decf	_GLCDPAGESL,W,BANKED
	movwf	_GLCDPAGE,BANKED
	movf	_GLCDPAGESL,W,BANKED
	subwf	_GLCDPAGESH,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd9
SysForLoop9
	incf	_GLCDPAGE,F,BANKED
;for xloop = 1 to 26
	clrf	XLOOP,BANKED
SysForLoop10
	incf	XLOOP,F,BANKED
;GLCDPrintString Str(xloop)
	movff	XLOOP,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	banksel	0
	call	FN_STR
	movlw	low STR
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high STR
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	banksel	0
	call	GLCDPRINTSTRING
;GLCDPrintStringLN "-WaveShare"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable28
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable28
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	banksel	0
	call	GLCDPRINTSTRINGLN
;next
	movlw	26
	banksel	XLOOP
	subwf	XLOOP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop10
SysForLoopEnd10
;GLCD_Close_PageTransaction
;Macro Source: epd_epd2in13d.h (933)
;Pixel_To_Display_EPD2in13D
	banksel	0
	call	PIXEL_TO_DISPLAY_EPD2IN13D
;next
	banksel	_GLCDPAGESH
	movf	_GLCDPAGESH,W,BANKED
	subwf	_GLCDPAGE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop9
SysForLoopEnd9
;SendCommand_EPD2in13D(DISPLAY_REFRESH)
	movlw	18
	movwf	EPD2IN13D_COMMAND,ACCESS
	banksel	0
	call	SENDCOMMAND_EPD2IN13D
;wait 1000 ms
	movlw	232
	movwf	SysWaitTempMS,ACCESS
	movlw	3
	movwf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;GLCD_Open_PageTransaction
;Macro Source: epd_epd2in13d.h (921)
;dim _GLCDPage as byte
;dim _GLCDPagesL, _GLCDPagesH as byte
;Clear_buffer_EPD2in13D
	rcall	CLEAR_BUFFER_EPD2IN13D
;for _GLCDPage = _GLCDPagesL to _GLCDPagesH    '_GLCDPage is a global variable - DO NOT CHANGE!!!
	banksel	_GLCDPAGESL
	decf	_GLCDPAGESL,W,BANKED
	movwf	_GLCDPAGE,BANKED
	movf	_GLCDPAGESL,W,BANKED
	subwf	_GLCDPAGESH,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd11
SysForLoop11
	incf	_GLCDPAGE,F,BANKED
;GLCDLocateString( 0, 0)
;dim xloop as byte
;for xloop = 27 to 52
	movlw	26
	movwf	XLOOP,BANKED
SysForLoop12
	incf	XLOOP,F,BANKED
;GLCDPrintString Str(xloop)
	movff	XLOOP,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	banksel	0
	call	FN_STR
	movlw	low STR
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high STR
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	banksel	0
	call	GLCDPRINTSTRING
;GLCDPrintStringLN "-WaveShare"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable28
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable28
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSLCDPRINTDATAHANDLER
	movwf	SysLCDPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysLCDPRINTDATAHandler_H,BANKED
	banksel	0
	call	GLCDPRINTSTRINGLN
;next
	movlw	52
	banksel	XLOOP
	subwf	XLOOP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop12
SysForLoopEnd12
;GLCD_Close_PageTransaction
;Macro Source: epd_epd2in13d.h (933)
;Pixel_To_Display_EPD2in13D
	banksel	0
	call	PIXEL_TO_DISPLAY_EPD2IN13D
;next
	banksel	_GLCDPAGESH
	movf	_GLCDPAGESH,W,BANKED
	subwf	_GLCDPAGE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop11
SysForLoopEnd11
;SendCommand_EPD2in13D(DISPLAY_REFRESH)
	movlw	18
	movwf	EPD2IN13D_COMMAND,ACCESS
	banksel	0
	call	SENDCOMMAND_EPD2IN13D
;wait 1000 ms
	movlw	232
	movwf	SysWaitTempMS,ACCESS
	movlw	3
	movwf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;goto mm
	goto	MM
;end
	bra	BASPROGRAMEND
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

;Source: glcd.h (1349)
BOX
;dim GLCDTemp as word
;Make sure that starting point (1) is always less than end point (2)
;If LineX1 > LineX2 Then
	movff	LINEX1,SysWORDTempB
	movff	LINEX1_H,SysWORDTempB_H
	movff	LINEX2,SysWORDTempA
	movff	LINEX2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF26
;GLCDTemp = LineX1
	movff	LINEX1,GLCDTEMP
	movff	LINEX1_H,GLCDTEMP_H
;LineX1 = LineX2
	movff	LINEX2,LINEX1
	movff	LINEX2_H,LINEX1_H
;LineX2 = GLCDTemp
	movff	GLCDTEMP,LINEX2
	movff	GLCDTEMP_H,LINEX2_H
;End If
ENDIF26
;If LineY1 > LineY2 Then
	movff	LINEY1,SysWORDTempB
	movff	LINEY1_H,SysWORDTempB_H
	movff	LINEY2,SysWORDTempA
	movff	LINEY2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF27
;GLCDTemp = LineY1
	movff	LINEY1,GLCDTEMP
	movff	LINEY1_H,GLCDTEMP_H
;LineY1 = LineY2
	movff	LINEY2,LINEY1
	movff	LINEY2_H,LINEY1_H
;LineY2 = GLCDTemp
	movff	GLCDTEMP,LINEY2
	movff	GLCDTEMP_H,LINEY2_H
;End If
ENDIF27
;dim DrawLine as word
;Draw lines going across
;For DrawLine = LineX1 To LineX2
	movlw	1
	subwf	LINEX1,W,BANKED
	movwf	DRAWLINE,ACCESS
	movlw	0
	subwfb	LINEX1_H,W,BANKED
	movwf	DRAWLINE_H,ACCESS
	movff	LINEX1,SysWORDTempB
	movff	LINEX1_H,SysWORDTempB_H
	movff	LINEX2,SysWORDTempA
	movff	LINEX2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd14
SysForLoop14
	incf	DRAWLINE,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	DRAWLINE_H,F,ACCESS
;PSet DrawLine, LineY1, LineColour
	movff	DRAWLINE,GLCDX
	movff	DRAWLINE_H,GLCDX_H
	movff	LINEY1,GLCDY
	movff	LINEY1_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;PSet DrawLine, LineY2, LineColour
	movff	DRAWLINE,GLCDX
	movff	DRAWLINE_H,GLCDX_H
	movff	LINEY2,GLCDY
	movff	LINEY2_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;Next
	movff	DRAWLINE,SysWORDTempA
	movff	DRAWLINE_H,SysWORDTempA_H
	movff	LINEX2,SysWORDTempB
	movff	LINEX2_H,SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop14
SysForLoopEnd14
;Draw lines going down
;For DrawLine = LineY1 To LineY2
	movlw	1
	subwf	LINEY1,W,BANKED
	movwf	DRAWLINE,ACCESS
	movlw	0
	subwfb	LINEY1_H,W,BANKED
	movwf	DRAWLINE_H,ACCESS
	movff	LINEY1,SysWORDTempB
	movff	LINEY1_H,SysWORDTempB_H
	movff	LINEY2,SysWORDTempA
	movff	LINEY2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd15
SysForLoop15
	incf	DRAWLINE,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	DRAWLINE_H,F,ACCESS
;PSet LineX1, DrawLine, LineColour
	movff	LINEX1,GLCDX
	movff	LINEX1_H,GLCDX_H
	movff	DRAWLINE,GLCDY
	movff	DRAWLINE_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;PSet LineX2, DrawLine, LineColour
	movff	LINEX2,GLCDX
	movff	LINEX2_H,GLCDX_H
	movff	DRAWLINE,GLCDY
	movff	DRAWLINE_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;Next
	movff	DRAWLINE,SysWORDTempA
	movff	DRAWLINE_H,SysWORDTempA_H
	movff	LINEY2,SysWORDTempB
	movff	LINEY2_H,SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop15
SysForLoopEnd15
	return

;********************************************************************************

;Source: epd_epd2in13d.h (411)
CLEAR_BUFFER_EPD2IN13D
;initialise global variable. Required variable for Circle - DO NOT DELETE
;GLCD_yordinate = 0
	clrf	GLCD_YORDINATE,BANKED
	clrf	GLCD_YORDINATE_H,BANKED
;Dim EPD_Ind_raw, EPD_Ind_col as word
;Dim PrintLocX, PrintLocY as word
;PrintLocX = 0
	clrf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
;PrintLocY = 0
	clrf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
;Dim EPD_Ind_raw as Word
;for EPD_Ind_raw=1 to BUFFWIDTH                 'clear the buffer
	clrf	EPD_IND_RAW,ACCESS
	clrf	EPD_IND_RAW_H,ACCESS
SysForLoop23
	incf	EPD_IND_RAW,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	EPD_IND_RAW_H,F,ACCESS
;EPD_Buffer(EPD_Ind_raw)=GLCDBackground
	lfsr	0,EPD_BUFFER
	movf	EPD_IND_RAW,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movf	EPD_IND_RAW_H,W,ACCESS
	addwfc	AFSR0_H,F,ACCESS
	movffl	GLCDBACKGROUND,INDF0
;next
	movff	EPD_IND_RAW,SysWORDTempA
	movff	EPD_IND_RAW_H,SysWORDTempA_H
	movlw	106
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop23
SysForLoopEnd23
	return

;********************************************************************************

;Source: epd_epd2in13d.h (302)
CLS_EPD2IN13D_INIT
;initialise global variable. Required variable for Circle - DO NOT DELETE
;GLCD_yordinate = 0
	clrf	GLCD_YORDINATE,BANKED
	clrf	GLCD_YORDINATE_H,BANKED
;Dim EPD_Ind_raw, EPD_Ind_col as word
;Dim PrintLocX, PrintLocY as word
;PrintLocX = 0
	clrf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
;PrintLocY = 0
	clrf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
;For EPD_Ind_raw=1 to BUFFWIDTH
	clrf	EPD_IND_RAW,ACCESS
	clrf	EPD_IND_RAW_H,ACCESS
SysForLoop36
	incf	EPD_IND_RAW,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	EPD_IND_RAW_H,F,ACCESS
;EPD_Buffer(EPD_Ind_raw)=GLCDBackground
	lfsr	0,EPD_BUFFER
	movf	EPD_IND_RAW,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movf	EPD_IND_RAW_H,W,ACCESS
	addwfc	AFSR0_H,F,ACCESS
	movffl	GLCDBACKGROUND,INDF0
;next
	movff	EPD_IND_RAW,SysWORDTempA
	movff	EPD_IND_RAW_H,SysWORDTempA_H
	movlw	106
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop36
SysForLoopEnd36
;Clear down "OLD" data
;SendCommand_EPD2in13D(Data_Transmission_1)
	movlw	16
	movwf	EPD2IN13D_COMMAND,ACCESS
	call	SENDCOMMAND_EPD2IN13D
;wait 2 ms
	movlw	2
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;for EPD_Ind_raw=1 to GLCD_Height
	clrf	EPD_IND_RAW,ACCESS
	clrf	EPD_IND_RAW_H,ACCESS
SysForLoop37
	incf	EPD_IND_RAW,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	EPD_IND_RAW_H,F,ACCESS
;for EPD_Ind_col=1 to GLCD_Width
	clrf	EPD_IND_COL,ACCESS
	clrf	EPD_IND_COL_H,ACCESS
SysForLoop38
	incf	EPD_IND_COL,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	EPD_IND_COL_H,F,ACCESS
;Was.. speed optimised with macro              SendData_EPD2in13D(GLCDBackGround)
;EPD2in13D_Data = GLCDBackGround
	movff	GLCDBACKGROUND,EPD2IN13D_DATA
;SET EPD_CS OFF
	bcf	LATC,1,ACCESS
;SET EPD_DC ON
	bsf	LATB,7,ACCESS
;SendData_EPD2in13D_Macro
;Macro Source: epd_epd2in13d.h (494)
;FastHWSPITransfer EPD2in13D_Data
	movff	EPD2IN13D_DATA,SPITXDATA
	call	FASTHWSPITRANSFER
;SET EPD_CS ON
	bsf	LATC,1,ACCESS
;next
	movff	EPD_IND_COL,SysWORDTempA
	movff	EPD_IND_COL_H,SysWORDTempA_H
	movlw	104
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop38
SysForLoopEnd38
;next
	movff	EPD_IND_RAW,SysWORDTempA
	movff	EPD_IND_RAW_H,SysWORDTempA_H
	movlw	212
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop37
SysForLoopEnd37
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;Clear down "NEW" data
;SendCommand_EPD2in13D(Data_Transmission_2)
	movlw	19
	movwf	EPD2IN13D_COMMAND,ACCESS
	call	SENDCOMMAND_EPD2IN13D
;wait 2 ms
	movlw	2
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;for EPD_Ind_raw=1 to GLCD_Height
	clrf	EPD_IND_RAW,ACCESS
	clrf	EPD_IND_RAW_H,ACCESS
SysForLoop39
	incf	EPD_IND_RAW,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	EPD_IND_RAW_H,F,ACCESS
;for EPD_Ind_col=1 to GLCD_Width
	clrf	EPD_IND_COL,ACCESS
	clrf	EPD_IND_COL_H,ACCESS
SysForLoop40
	incf	EPD_IND_COL,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	EPD_IND_COL_H,F,ACCESS
;Was.. speed optimised with macro              SendData_EPD2in13D(GLCDBackGround)
;EPD2in13D_Data = GLCDBackGround
	movff	GLCDBACKGROUND,EPD2IN13D_DATA
;SET EPD_CS OFF
	bcf	LATC,1,ACCESS
;SET EPD_DC ON
	bsf	LATB,7,ACCESS
;SendData_EPD2in13D_Macro
;Macro Source: epd_epd2in13d.h (494)
;FastHWSPITransfer EPD2in13D_Data
	movff	EPD2IN13D_DATA,SPITXDATA
	rcall	FASTHWSPITRANSFER
;SET EPD_CS ON
	bsf	LATC,1,ACCESS
;next
	movff	EPD_IND_COL,SysWORDTempA
	movff	EPD_IND_COL_H,SysWORDTempA_H
	movlw	104
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop40
SysForLoopEnd40
;next
	movff	EPD_IND_RAW,SysWORDTempA
	movff	EPD_IND_RAW_H,SysWORDTempA_H
	movlw	212
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop39
SysForLoopEnd39
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	bra	Delay_MS

;********************************************************************************

;Source: epd_epd2in13d.h (543)
DRAWCHAR_EPD2IN13D
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
	subwf	CHARCODE,F,ACCESS
;CharCode needs to have 15 subtracted, table starts at char 16 not char 0
;CharCol=0
	clrf	CHARCOL,ACCESS
	clrf	CHARCOL_H,ACCESS
;Calculate the pointer to the OLED fonts.
;These fonts are not multiple tables one is a straight list the other is a lookup table with data.
;Dim LocalCharCode as word
;Get key information and set up the fonts parameters
;Select case GLCDfntDefaultSize
;case 1 'This font is two font tables of an index and data
SysSelect2Case1
	decf	GLCDFNTDEFAULTSIZE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case2
;CharCode = CharCode - 16
	movlw	16
	subwf	CHARCODE,F,ACCESS
;ReadTable OLEDFont1Index, CharCode, LocalCharCode
	movff	CHARCODE,SYSSTRINGA
	call	OLEDFONT1INDEX
	movwf	LOCALCHARCODE,BANKED
	movff	CHARCODE,SYSSTRINGA
	call	OLEDFONT1INDEX_H
	movwf	LOCALCHARCODE_H,BANKED
;ReadTable OLEDFont1Data, LocalCharCode , COLSperfont
	movff	LOCALCHARCODE,SYSSTRINGA
	movff	LOCALCHARCODE_H,SYSSTRINGA_H
	call	OLEDFONT1DATA
	movwf	COLSPERFONT,ACCESS
;GLCDFontWidth = COLSperfont + 1
	incf	COLSPERFONT,W,ACCESS
	movwf	GLCDFONTWIDTH,BANKED
;ROWSperfont = 7  'which is really 8 as we start at 0
	movlw	7
	movwf	ROWSPERFONT,BANKED
;case 2 'This is one font table
	bra	SysSelectEnd2
SysSelect2Case2
	movlw	2
	subwf	GLCDFNTDEFAULTSIZE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd2
;CharCode = CharCode - 17
	movlw	17
	subwf	CHARCODE,F,ACCESS
;Pointer to table of font elements
;LocalCharCode = (CharCode * 20)
	movff	CHARCODE,SysWORDTempA
	clrf	SysWORDTempA_H,ACCESS
	movlw	20
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysMultSub16
	movff	SysWORDTempX,LOCALCHARCODE
	movff	SysWORDTempX_H,LOCALCHARCODE_H
;COLSperfont = 9  'which is really 10 as we start at 0
	movlw	9
	movwf	COLSPERFONT,ACCESS
;ROWSperfont=15  'which is really 16 as we start at 0
	movlw	15
	movwf	ROWSPERFONT,BANKED
;End Select
SysSelectEnd2
;The main loop - loop throught the number of columns
;For CurrCharCol = 0 to COLSperfont  'number of columns in the font , with two row of data
	setf	CURRCHARCOL,ACCESS
	movlw	0
	subwf	COLSPERFONT,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd25
SysForLoop25
	incf	CURRCHARCOL,F,ACCESS
;Index the pointer to the code that we are looking for as we need to do this lookup many times getting more font data
;LocalCharCode++
	incf	LOCALCHARCODE,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	LOCALCHARCODE_H,F,BANKED
;Select case GLCDfntDefaultSize
;case 1
SysSelect3Case1
	decf	GLCDFNTDEFAULTSIZE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case2
;ReadTable OLEDFont1Data, LocalCharCode, CurrCharVal
	movff	LOCALCHARCODE,SYSSTRINGA
	movff	LOCALCHARCODE_H,SYSSTRINGA_H
	call	OLEDFONT1DATA
	movwf	CURRCHARVAL,ACCESS
;case 2
	bra	SysSelectEnd3
SysSelect3Case2
	movlw	2
	subwf	GLCDFNTDEFAULTSIZE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd3
;Read this 20 times... (0..COLSperfont) [ * 2 ]
;ReadTable OLEDFont2, LocalCharCode, CurrCharVal
	movff	LOCALCHARCODE,SYSSTRINGA
	movff	LOCALCHARCODE_H,SYSSTRINGA_H
	call	OLEDFONT2
	movwf	CURRCHARVAL,ACCESS
;End Select
SysSelectEnd3
;we handle 8 or 16 pixels of height
;For CurrCharRow = 0 to ROWSperfont
	setf	CURRCHARROW,ACCESS
	movlw	0
	subwf	ROWSPERFONT,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd26
SysForLoop26
	incf	CURRCHARROW,F,ACCESS
;Set the pixel
;If CurrCharVal.0 = 0 Then
	btfsc	CURRCHARVAL,0,ACCESS
	bra	ELSE100_1
;PSet CharLocX + CurrCharCol, CharLocY + CurrCharRow, GLCDBACKGROUND
	movf	CURRCHARCOL,W,ACCESS
	addwf	CHARLOCX,W,ACCESS
	movwf	GLCDX,BANKED
	movlw	0
	addwfc	CHARLOCX_H,W,ACCESS
	movwf	GLCDX_H,BANKED
	movf	CURRCHARROW,W,ACCESS
	addwf	CHARLOCY,W,ACCESS
	movwf	GLCDY,BANKED
	movlw	0
	addwfc	CHARLOCY_H,W,ACCESS
	movwf	GLCDY_H,BANKED
	movff	GLCDBACKGROUND,GLCDCOLOUR
	movff	GLCDBACKGROUND_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;Else
	bra	ENDIF100
ELSE100_1
;PSet CharLocX + CurrCharCol, CharLocY + CurrCharRow, LineColour
	movf	CURRCHARCOL,W,ACCESS
	addwf	CHARLOCX,W,ACCESS
	movwf	GLCDX,BANKED
	movlw	0
	addwfc	CHARLOCX_H,W,ACCESS
	movwf	GLCDX_H,BANKED
	movf	CURRCHARROW,W,ACCESS
	addwf	CHARLOCY,W,ACCESS
	movwf	GLCDY,BANKED
	movlw	0
	addwfc	CHARLOCY_H,W,ACCESS
	movwf	GLCDY_H,BANKED
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;End If
ENDIF100
;Rotate CurrCharVal Right
	rrcf	CURRCHARVAL,F,ACCESS
;Set to next row of date, a second row
;if GLCDfntDefaultSize = 2 and CurrCharRow = 7 then
	movff	GLCDFNTDEFAULTSIZE,SysBYTETempA
	movlw	2
	movwf	SysBYTETempB,ACCESS
	call	SysCompEqual
	movff	SysByteTempX,SysTemp3
	movff	CURRCHARROW,SysBYTETempA
	movlw	7
	movwf	SysBYTETempB,ACCESS
	call	SysCompEqual
	banksel	SYSTEMP3
	movf	SysTemp3,W,BANKED
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp1,BANKED
	btfss	SysTemp1,0,BANKED
	bra	ENDIF101
;LocalCharCode++
	banksel	LOCALCHARCODE
	incf	LOCALCHARCODE,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	LOCALCHARCODE_H,F,BANKED
;ReadTable OLEDFont2, LocalCharCode, CurrCharVal
	movff	LOCALCHARCODE,SYSSTRINGA
	movff	LOCALCHARCODE_H,SYSSTRINGA_H
	call	OLEDFONT2
	movwf	CURRCHARVAL,ACCESS
;end if
ENDIF101
;It is the intercharacter space, put out one pixel row
;if CurrCharCol = COLSperfont then
	movf	COLSPERFONT,W,ACCESS
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF102
;Put out a white intercharacter pixel/space
;GLCDTemp = CharLocX + CurrCharCol
	movf	CURRCHARCOL,W,ACCESS
	addwf	CHARLOCX,W,ACCESS
	banksel	GLCDTEMP
	movwf	GLCDTEMP,BANKED
	movlw	0
	addwfc	CHARLOCX_H,W,ACCESS
	movwf	GLCDTEMP_H,BANKED
;if GLCDfntDefaultSize = 2 then
	movlw	2
	subwf	GLCDFNTDEFAULTSIZE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF105
;GLCDTemp++
	incf	GLCDTEMP,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	GLCDTEMP_H,F,BANKED
;end if
ENDIF105
;PSet GLCDTemp , CharLocY + CurrCharRow, GLCDBACKGROUND
	movff	GLCDTEMP,GLCDX
	movff	GLCDTEMP_H,GLCDX_H
	movf	CURRCHARROW,W,ACCESS
	addwf	CHARLOCY,W,ACCESS
	movwf	GLCDY,BANKED
	movlw	0
	addwfc	CHARLOCY_H,W,ACCESS
	movwf	GLCDY_H,BANKED
	movff	GLCDBACKGROUND,GLCDCOLOUR
	movff	GLCDBACKGROUND_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;end if
ENDIF102
;Next
	banksel	ROWSPERFONT
	movf	ROWSPERFONT,W,BANKED
	subwf	CURRCHARROW,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop26
SysForLoopEnd26
;Next
	movf	COLSPERFONT,W,ACCESS
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop25
SysForLoopEnd25
	return

;********************************************************************************

;Source: glcd.h (3482)
DRAWELLIPSEROUTINE
;Version 1.00 (08/20/2017) by Joseph Realmuto
;Version 1.01 (14/04/2019) by Giuseppe D'Elia
;draws an ellipse outline at location (xoffset, yoffset) if filled_ellipse = 0
;draws a filled ellipse at location (xoffset, yoffset) if filled_ellipse = 1
;Inxradius is x radius of ellipse
;Inyradius is y radius of ellipse
;IF Inxradius = Inyradius THEN
;IF filled_ellipse = 0 THEN
;Circle Xoffset, Yoffset, Inxradius, LineColour
;ELSE
;FilledCircle Xoffset, Yoffset, Inxradius, LineColour
;END IF
;GLCD_exit sub
;END IF
;IF Inxradius<2 THEN exit sub
	movff	INXRADIUS,SysWORDTempA
	movff	INXRADIUS_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	return
;IF Inyradius<2 THEN exit sub
	movff	INYRADIUS,SysWORDTempA
	movff	INYRADIUS_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	return
;dim GLCD_xx, GLCD_yy, GLCD_rx2, GLCD_ry2 as Word
;dim  GLCD_fx2, GLCD_fy2, GLCD_ex2, GLCD_ey2 as Long
;dim GLCD_px, GLCD_py, GLCD_pp, GLCD_pp_temp as Long
;GLCD_rx2 = Inxradius * Inxradius
	movff	INXRADIUS,SysWORDTempA
	movff	INXRADIUS_H,SysWORDTempA_H
	movff	INXRADIUS,SysWORDTempB
	movff	INXRADIUS_H,SysWORDTempB_H
	call	SysMultSub16
	movff	SysWORDTempX,GLCD_RX2
	movff	SysWORDTempX_H,GLCD_RX2_H
;GLCD_ry2 = Inyradius * Inyradius
	movff	INYRADIUS,SysWORDTempA
	movff	INYRADIUS_H,SysWORDTempA_H
	movff	INYRADIUS,SysWORDTempB
	movff	INYRADIUS_H,SysWORDTempB_H
	call	SysMultSub16
	movff	SysWORDTempX,GLCD_RY2
	movff	SysWORDTempX_H,GLCD_RY2_H
;GLCD_fx2 = 4 * GLCD_rx2
;GLCD_fx2 = GLCD_rx2 + GLCD_rx2
	movf	GLCD_RX2,W,BANKED
	addwf	GLCD_RX2,W,BANKED
	movwf	GLCD_FX2,BANKED
	movf	GLCD_RX2_H,W,BANKED
	addwfc	GLCD_RX2_H,W,BANKED
	movwf	GLCD_FX2_H,BANKED
	clrf	GLCD_FX2_U,BANKED
	btfsc	STATUS,C,ACCESS
	incf	GLCD_FX2_U,F,BANKED
	clrf	GLCD_FX2_E,BANKED
;GLCD_fx2 = GLCD_fx2 + GLCD_fx2
	movf	GLCD_FX2,W,BANKED
	addwf	GLCD_FX2,F,BANKED
	movf	GLCD_FX2_H,W,BANKED
	addwfc	GLCD_FX2_H,F,BANKED
	movf	GLCD_FX2_U,W,BANKED
	addwfc	GLCD_FX2_U,F,BANKED
	movf	GLCD_FX2_E,W,BANKED
	addwfc	GLCD_FX2_E,F,BANKED
;GLCD_fy2 = 4 * GLCD_ry2
;GLCD_fy2 = GLCD_ry2 + GLCD_ry2
	movf	GLCD_RY2,W,BANKED
	addwf	GLCD_RY2,W,BANKED
	movwf	GLCD_FY2,BANKED
	movf	GLCD_RY2_H,W,BANKED
	addwfc	GLCD_RY2_H,W,BANKED
	movwf	GLCD_FY2_H,BANKED
	clrf	GLCD_FY2_U,BANKED
	btfsc	STATUS,C,ACCESS
	incf	GLCD_FY2_U,F,BANKED
	clrf	GLCD_FY2_E,BANKED
;GLCD_fy2 = GLCD_fy2 + GLCD_fy2
	movf	GLCD_FY2,W,BANKED
	addwf	GLCD_FY2,F,BANKED
	movf	GLCD_FY2_H,W,BANKED
	addwfc	GLCD_FY2_H,F,BANKED
	movf	GLCD_FY2_U,W,BANKED
	addwfc	GLCD_FY2_U,F,BANKED
	movf	GLCD_FY2_E,W,BANKED
	addwfc	GLCD_FY2_E,F,BANKED
;GLCD_ex2 = 2 * GLCD_fx2
;GLCD_ex2 = GLCD_fx2 + GLCD_fx2
	movf	GLCD_FX2,W,BANKED
	addwf	GLCD_FX2,W,BANKED
	movwf	GLCD_EX2,BANKED
	movf	GLCD_FX2_H,W,BANKED
	addwfc	GLCD_FX2_H,W,BANKED
	movwf	GLCD_EX2_H,BANKED
	movf	GLCD_FX2_U,W,BANKED
	addwfc	GLCD_FX2_U,W,BANKED
	movwf	GLCD_EX2_U,BANKED
	movf	GLCD_FX2_E,W,BANKED
	addwfc	GLCD_FX2_E,W,BANKED
	movwf	GLCD_EX2_E,BANKED
;GLCD_ey2 = 2 * GLCD_fy2
;GLCD_ey2 = GLCD_fy2 + GLCD_fy2
	movf	GLCD_FY2,W,BANKED
	addwf	GLCD_FY2,W,BANKED
	movwf	GLCD_EY2,BANKED
	movf	GLCD_FY2_H,W,BANKED
	addwfc	GLCD_FY2_H,W,BANKED
	movwf	GLCD_EY2_H,BANKED
	movf	GLCD_FY2_U,W,BANKED
	addwfc	GLCD_FY2_U,W,BANKED
	movwf	GLCD_EY2_U,BANKED
	movf	GLCD_FY2_E,W,BANKED
	addwfc	GLCD_FY2_E,W,BANKED
	movwf	GLCD_EY2_E,BANKED
;GLCD_xx = 0
	clrf	GLCD_XX,BANKED
	clrf	GLCD_XX_H,BANKED
;GLCD_yy = Inyradius
	movff	INYRADIUS,GLCD_YY
	movff	INYRADIUS_H,GLCD_YY_H
;GLCD_px = 0
	clrf	GLCD_PX,BANKED
	clrf	GLCD_PX_H,BANKED
	clrf	GLCD_PX_U,BANKED
	clrf	GLCD_PX_E,BANKED
;GLCD_py = GLCD_ex2 * GLCD_yy
	movff	GLCD_EX2,SysLONGTempA
	movff	GLCD_EX2_H,SysLONGTempA_H
	movff	GLCD_EX2_U,SysLONGTempA_U
	movff	GLCD_EX2_E,SysLONGTempA_E
	movff	GLCD_YY,SysLONGTempB
	movff	GLCD_YY_H,SysLONGTempB_H
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	call	SysMultSub32
	movff	SysLONGTempX,GLCD_PY
	movff	SysLONGTempX_H,GLCD_PY_H
	movff	SysLONGTempX_U,GLCD_PY_U
	movff	SysLONGTempX_E,GLCD_PY_E
;GLCD_pp = 2 + GLCD_fy2 -  GLCD_fx2 * Inyradius + GLCD_rx2
;GLCD_pp_temp = GLCD_fx2 * Inyradius
	movff	GLCD_FX2,SysLONGTempA
	movff	GLCD_FX2_H,SysLONGTempA_H
	movff	GLCD_FX2_U,SysLONGTempA_U
	movff	GLCD_FX2_E,SysLONGTempA_E
	movff	INYRADIUS,SysLONGTempB
	movff	INYRADIUS_H,SysLONGTempB_H
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	call	SysMultSub32
	movff	SysLONGTempX,GLCD_PP_TEMP
	movff	SysLONGTempX_H,GLCD_PP_TEMP_H
	movff	SysLONGTempX_U,GLCD_PP_TEMP_U
	movff	SysLONGTempX_E,GLCD_PP_TEMP_E
;GLCD_pp = 2 + GLCD_fy2
	movlw	2
	addwf	GLCD_FY2,W,BANKED
	movwf	GLCD_PP,BANKED
	movlw	0
	addwfc	GLCD_FY2_H,W,BANKED
	movwf	GLCD_PP_H,BANKED
	movlw	0
	addwfc	GLCD_FY2_U,W,BANKED
	movwf	GLCD_PP_U,BANKED
	movlw	0
	addwfc	GLCD_FY2_E,W,BANKED
	movwf	GLCD_PP_E,BANKED
;GLCD_pp = GLCD_pp + GLCD_rx2
	movf	GLCD_RX2,W,BANKED
	addwf	GLCD_PP,F,BANKED
	movf	GLCD_RX2_H,W,BANKED
	addwfc	GLCD_PP_H,F,BANKED
	movlw	0
	addwfc	GLCD_PP_U,F,BANKED
	movlw	0
	addwfc	GLCD_PP_E,F,BANKED
;GLCD_pp = GLCD_pp - GLCD_pp_temp
	movf	GLCD_PP_TEMP,W,BANKED
	subwf	GLCD_PP,F,BANKED
	movf	GLCD_PP_TEMP_H,W,BANKED
	subwfb	GLCD_PP_H,F,BANKED
	movf	GLCD_PP_TEMP_U,W,BANKED
	subwfb	GLCD_PP_U,F,BANKED
	movf	GLCD_PP_TEMP_E,W,BANKED
	subwfb	GLCD_PP_E,F,BANKED
;IF filled_ellipse = 0 THEN
	movf	FILLED_ELLIPSE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ELSE45_1
;Draw_Ellipse_Points
	rcall	DRAW_ELLIPSE_POINTS
;ELSE
	bra	ENDIF45
ELSE45_1
;Draw_Filled_Ellipse_Points
	rcall	DRAW_FILLED_ELLIPSE_POINTS
;END IF
ENDIF45
;DO WHILE GLCD_px < GLCD_py
SysDoLoop_S4
	movff	glcd_px,SysLONGTempA
	movff	glcd_px_H,SysLONGTempA_H
	movff	glcd_px_U,SysLONGTempA_U
	movff	glcd_px_E,SysLONGTempA_E
	movff	glcd_py,SysLONGTempB
	movff	glcd_py_H,SysLONGTempB_H
	movff	glcd_py_U,SysLONGTempB_U
	movff	glcd_py_E,SysLONGTempB_E
	call	SysCompLessThan32
	btfss	SysByteTempX,0,ACCESS
	bra	SysDoLoop_E4
;GLCD_xx++
	incf	GLCD_XX,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	GLCD_XX_H,F,BANKED
;GLCD_px = GLCD_px + GLCD_ey2
	movf	GLCD_EY2,W,BANKED
	addwf	GLCD_PX,F,BANKED
	movf	GLCD_EY2_H,W,BANKED
	addwfc	GLCD_PX_H,F,BANKED
	movf	GLCD_EY2_U,W,BANKED
	addwfc	GLCD_PX_U,F,BANKED
	movf	GLCD_EY2_E,W,BANKED
	addwfc	GLCD_PX_E,F,BANKED
;IF GLCD_pp_E.7 = 0 THEN
	btfsc	GLCD_PP_E,7,BANKED
	bra	ENDIF46
;GLCD_yy--
	movlw	1
	subwf	GLCD_YY,F,BANKED
	movlw	0
	subwfb	GLCD_YY_H,F,BANKED
;GLCD_py = GLCD_py - GLCD_ex2
	movf	GLCD_EX2,W,BANKED
	subwf	GLCD_PY,F,BANKED
	movf	GLCD_EX2_H,W,BANKED
	subwfb	GLCD_PY_H,F,BANKED
	movf	GLCD_EX2_U,W,BANKED
	subwfb	GLCD_PY_U,F,BANKED
	movf	GLCD_EX2_E,W,BANKED
	subwfb	GLCD_PY_E,F,BANKED
;GLCD_pp = GLCD_pp - GLCD_py
	movf	GLCD_PY,W,BANKED
	subwf	GLCD_PP,F,BANKED
	movf	GLCD_PY_H,W,BANKED
	subwfb	GLCD_PP_H,F,BANKED
	movf	GLCD_PY_U,W,BANKED
	subwfb	GLCD_PP_U,F,BANKED
	movf	GLCD_PY_E,W,BANKED
	subwfb	GLCD_PP_E,F,BANKED
;END IF
ENDIF46
;GLCD_pp = GLCD_pp + GLCD_fy2 + GLCD_px
;GLCD_pp = GLCD_pp + GLCD_fy2
	movf	GLCD_FY2,W,BANKED
	addwf	GLCD_PP,F,BANKED
	movf	GLCD_FY2_H,W,BANKED
	addwfc	GLCD_PP_H,F,BANKED
	movf	GLCD_FY2_U,W,BANKED
	addwfc	GLCD_PP_U,F,BANKED
	movf	GLCD_FY2_E,W,BANKED
	addwfc	GLCD_PP_E,F,BANKED
;GLCD_pp = GLCD_pp + GLCD_px
	movf	GLCD_PX,W,BANKED
	addwf	GLCD_PP,F,BANKED
	movf	GLCD_PX_H,W,BANKED
	addwfc	GLCD_PP_H,F,BANKED
	movf	GLCD_PX_U,W,BANKED
	addwfc	GLCD_PP_U,F,BANKED
	movf	GLCD_PX_E,W,BANKED
	addwfc	GLCD_PP_E,F,BANKED
;IF filled_ellipse = 0 THEN
	movf	FILLED_ELLIPSE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ELSE47_1
;Draw_Ellipse_Points
	rcall	DRAW_ELLIPSE_POINTS
;ELSE
	bra	ENDIF47
ELSE47_1
;Draw_Filled_Ellipse_Points
	rcall	DRAW_FILLED_ELLIPSE_POINTS
;END IF
ENDIF47
;LOOP
	bra	SysDoLoop_S4
SysDoLoop_E4
;GLCD_pp = 2 + GLCD_ry2 * (2 * GLCD_xx + 1) * (2 * GLCD_xx + 1) + GLCD_fx2 * (GLCD_yy - 1) * (GLCD_yy - 1) -  GLCD_fx2 * GLCD_ry2
;change GLCD_xx and GLCD_yy to do calculation
;GLCD_xx = GLCD_xx + GLCD_xx
	movf	GLCD_XX,W,BANKED
	addwf	GLCD_XX,F,BANKED
	movf	GLCD_XX_H,W,BANKED
	addwfc	GLCD_XX_H,F,BANKED
;GLCD_xx++
	incf	GLCD_XX,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	GLCD_XX_H,F,BANKED
;GLCD_yy--
	movlw	1
	subwf	GLCD_YY,F,BANKED
	movlw	0
	subwfb	GLCD_YY_H,F,BANKED
;GLCD_pp_temp = GLCD_xx * GLCD_xx
	movff	GLCD_XX,SysLONGTempA
	movff	GLCD_XX_H,SysLONGTempA_H
	clrf	SysLONGTempA_U,ACCESS
	clrf	SysLONGTempA_E,ACCESS
	movff	GLCD_XX,SysLONGTempB
	movff	GLCD_XX_H,SysLONGTempB_H
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	call	SysMultSub32
	movff	SysLONGTempX,GLCD_PP_TEMP
	movff	SysLONGTempX_H,GLCD_PP_TEMP_H
	movff	SysLONGTempX_U,GLCD_PP_TEMP_U
	movff	SysLONGTempX_E,GLCD_PP_TEMP_E
;GLCD_pp_temp = GLCD_ry2 * GLCD_pp_temp
	movff	GLCD_RY2,SysLONGTempA
	movff	GLCD_RY2_H,SysLONGTempA_H
	clrf	SysLONGTempA_U,ACCESS
	clrf	SysLONGTempA_E,ACCESS
	movff	GLCD_PP_TEMP,SysLONGTempB
	movff	GLCD_PP_TEMP_H,SysLONGTempB_H
	movff	GLCD_PP_TEMP_U,SysLONGTempB_U
	movff	GLCD_PP_TEMP_E,SysLONGTempB_E
	call	SysMultSub32
	movff	SysLONGTempX,GLCD_PP_TEMP
	movff	SysLONGTempX_H,GLCD_PP_TEMP_H
	movff	SysLONGTempX_U,GLCD_PP_TEMP_U
	movff	SysLONGTempX_E,GLCD_PP_TEMP_E
;GLCD_pp = 2 + GLCD_pp_temp
	movlw	2
	addwf	GLCD_PP_TEMP,W,BANKED
	movwf	GLCD_PP,BANKED
	movlw	0
	addwfc	GLCD_PP_TEMP_H,W,BANKED
	movwf	GLCD_PP_H,BANKED
	movlw	0
	addwfc	GLCD_PP_TEMP_U,W,BANKED
	movwf	GLCD_PP_U,BANKED
	movlw	0
	addwfc	GLCD_PP_TEMP_E,W,BANKED
	movwf	GLCD_PP_E,BANKED
;GLCD_pp_temp = GLCD_yy * GLCD_yy
	movff	GLCD_YY,SysLONGTempA
	movff	GLCD_YY_H,SysLONGTempA_H
	clrf	SysLONGTempA_U,ACCESS
	clrf	SysLONGTempA_E,ACCESS
	movff	GLCD_YY,SysLONGTempB
	movff	GLCD_YY_H,SysLONGTempB_H
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	call	SysMultSub32
	movff	SysLONGTempX,GLCD_PP_TEMP
	movff	SysLONGTempX_H,GLCD_PP_TEMP_H
	movff	SysLONGTempX_U,GLCD_PP_TEMP_U
	movff	SysLONGTempX_E,GLCD_PP_TEMP_E
;GLCD_pp_temp = GLCD_fx2 * GLCD_pp_temp
	movff	GLCD_FX2,SysLONGTempA
	movff	GLCD_FX2_H,SysLONGTempA_H
	movff	GLCD_FX2_U,SysLONGTempA_U
	movff	GLCD_FX2_E,SysLONGTempA_E
	movff	GLCD_PP_TEMP,SysLONGTempB
	movff	GLCD_PP_TEMP_H,SysLONGTempB_H
	movff	GLCD_PP_TEMP_U,SysLONGTempB_U
	movff	GLCD_PP_TEMP_E,SysLONGTempB_E
	call	SysMultSub32
	movff	SysLONGTempX,GLCD_PP_TEMP
	movff	SysLONGTempX_H,GLCD_PP_TEMP_H
	movff	SysLONGTempX_U,GLCD_PP_TEMP_U
	movff	SysLONGTempX_E,GLCD_PP_TEMP_E
;GLCD_pp = GLCD_pp + GLCD_pp_temp
	movf	GLCD_PP_TEMP,W,BANKED
	addwf	GLCD_PP,F,BANKED
	movf	GLCD_PP_TEMP_H,W,BANKED
	addwfc	GLCD_PP_H,F,BANKED
	movf	GLCD_PP_TEMP_U,W,BANKED
	addwfc	GLCD_PP_U,F,BANKED
	movf	GLCD_PP_TEMP_E,W,BANKED
	addwfc	GLCD_PP_E,F,BANKED
;GLCD_pp_temp = GLCD_fx2 * GLCD_ry2
	movff	GLCD_FX2,SysLONGTempA
	movff	GLCD_FX2_H,SysLONGTempA_H
	movff	GLCD_FX2_U,SysLONGTempA_U
	movff	GLCD_FX2_E,SysLONGTempA_E
	movff	GLCD_RY2,SysLONGTempB
	movff	GLCD_RY2_H,SysLONGTempB_H
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	call	SysMultSub32
	movff	SysLONGTempX,GLCD_PP_TEMP
	movff	SysLONGTempX_H,GLCD_PP_TEMP_H
	movff	SysLONGTempX_U,GLCD_PP_TEMP_U
	movff	SysLONGTempX_E,GLCD_PP_TEMP_E
;GLCD_pp = GLCD_pp - GLCD_pp_temp
	movf	GLCD_PP_TEMP,W,BANKED
	subwf	GLCD_PP,F,BANKED
	movf	GLCD_PP_TEMP_H,W,BANKED
	subwfb	GLCD_PP_H,F,BANKED
	movf	GLCD_PP_TEMP_U,W,BANKED
	subwfb	GLCD_PP_U,F,BANKED
	movf	GLCD_PP_TEMP_E,W,BANKED
	subwfb	GLCD_PP_E,F,BANKED
;restore original GLCD_xx and GLCD_yy values
;GLCD_xx--
	movlw	1
	subwf	GLCD_XX,F,BANKED
	movlw	0
	subwfb	GLCD_XX_H,F,BANKED
;GLCD_xx/2
;set C off
	bcf	STATUS,C,ACCESS
;rotate GLCD_xx_H right
	rrcf	GLCD_XX_H,F,BANKED
;rotate GLCD_xx right
	rrcf	GLCD_XX_H,F,BANKED
	rrcf	GLCD_XX,F,BANKED
;GLCD_yy++
	incf	GLCD_YY,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	GLCD_YY_H,F,BANKED
;DO WHILE GLCD_yy > 0
SysDoLoop_S5
	movff	glcd_yy,SysWORDTempB
	movff	glcd_yy_H,SysWORDTempB_H
	clrf	SysWORDTempA,ACCESS
	clrf	SysWORDTempA_H,ACCESS
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	SysDoLoop_E5
;GLCD_yy--
	movlw	1
	subwf	GLCD_YY,F,BANKED
	movlw	0
	subwfb	GLCD_YY_H,F,BANKED
;GLCD_py = GLCD_py - GLCD_ex2
	movf	GLCD_EX2,W,BANKED
	subwf	GLCD_PY,F,BANKED
	movf	GLCD_EX2_H,W,BANKED
	subwfb	GLCD_PY_H,F,BANKED
	movf	GLCD_EX2_U,W,BANKED
	subwfb	GLCD_PY_U,F,BANKED
	movf	GLCD_EX2_E,W,BANKED
	subwfb	GLCD_PY_E,F,BANKED
;IF GLCD_pp_E.7 = 1 THEN
	btfss	GLCD_PP_E,7,BANKED
	bra	ENDIF48
;GLCD_xx++
	incf	GLCD_XX,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	GLCD_XX_H,F,BANKED
;GLCD_px = GLCD_px + GLCD_ey2
	movf	GLCD_EY2,W,BANKED
	addwf	GLCD_PX,F,BANKED
	movf	GLCD_EY2_H,W,BANKED
	addwfc	GLCD_PX_H,F,BANKED
	movf	GLCD_EY2_U,W,BANKED
	addwfc	GLCD_PX_U,F,BANKED
	movf	GLCD_EY2_E,W,BANKED
	addwfc	GLCD_PX_E,F,BANKED
;GLCD_pp = GLCD_pp + GLCD_px
	movf	GLCD_PX,W,BANKED
	addwf	GLCD_PP,F,BANKED
	movf	GLCD_PX_H,W,BANKED
	addwfc	GLCD_PP_H,F,BANKED
	movf	GLCD_PX_U,W,BANKED
	addwfc	GLCD_PP_U,F,BANKED
	movf	GLCD_PX_E,W,BANKED
	addwfc	GLCD_PP_E,F,BANKED
;END IF
ENDIF48
;GLCD_pp = GLCD_pp + GLCD_fx2 - GLCD_py
;GLCD_pp = GLCD_pp + GLCD_fx2
	movf	GLCD_FX2,W,BANKED
	addwf	GLCD_PP,F,BANKED
	movf	GLCD_FX2_H,W,BANKED
	addwfc	GLCD_PP_H,F,BANKED
	movf	GLCD_FX2_U,W,BANKED
	addwfc	GLCD_PP_U,F,BANKED
	movf	GLCD_FX2_E,W,BANKED
	addwfc	GLCD_PP_E,F,BANKED
;GLCD_pp = GLCD_pp - GLCD_py
	movf	GLCD_PY,W,BANKED
	subwf	GLCD_PP,F,BANKED
	movf	GLCD_PY_H,W,BANKED
	subwfb	GLCD_PP_H,F,BANKED
	movf	GLCD_PY_U,W,BANKED
	subwfb	GLCD_PP_U,F,BANKED
	movf	GLCD_PY_E,W,BANKED
	subwfb	GLCD_PP_E,F,BANKED
;IF filled_ellipse = 0 THEN
	movf	FILLED_ELLIPSE,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ELSE49_1
;Draw_Ellipse_Points
	rcall	DRAW_ELLIPSE_POINTS
;ELSE
	bra	ENDIF49
ELSE49_1
;Draw_Filled_Ellipse_Points
	rcall	DRAW_FILLED_ELLIPSE_POINTS
;END IF
ENDIF49
;LOOP
	bra	SysDoLoop_S5
SysDoLoop_E5
	return

;********************************************************************************

;Source: epd_epd2in13d.h (515)
DRAWSTRING_EPD2IN13D
;dim GLCDPrintLoc as word
;GLCDPrintLoc = StringLocX
	movff	STRINGLOCX,GLCDPRINTLOC
	movff	STRINGLOCX_H,GLCDPRINTLOC_H
;dim OldGLCDFontWidth as Byte
;OldGLCDFontWidth = GLCDFontWidth
	movff	GLCDFONTWIDTH,OLDGLCDFONTWIDTH
;for xchar = 1 to Chars(0)
	banksel	XCHAR
	clrf	XCHAR,BANKED
	movffl	SysCHARSHandler,AFSR0
	movffl	SysCHARSHandler_H,AFSR0_H
	movlw	1
	subwf	INDF0,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd24
SysForLoop24
	incf	XCHAR,F,BANKED
;GLCDDrawChar GLCDPrintLoc , CharLocY , Chars(xchar), LineColour
	movff	GLCDPRINTLOC,CHARLOCX
	movff	GLCDPRINTLOC_H,CHARLOCX_H
	movf	XCHAR,W,BANKED
	addwf	SysCHARSHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysCHARSHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movffl	INDF0,CHARCODE
	banksel	0
	rcall	DRAWCHAR_EPD2IN13D
;GLCDPrintIncrementPixelPositionMacro
;Macro Source: glcd.h (1084)
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize ) + GLCDfntDefaultsize - 1
	movf	GLCDFONTWIDTH,W,BANKED
	mulwf	GLCDFNTDEFAULTSIZE,BANKED
	movffl	PRODL,SysTemp3
	banksel	SYSTEMP3
	movf	SysTemp3,W,BANKED
	banksel	GLCDPRINTLOC
	addwf	GLCDPRINTLOC,W,BANKED
	banksel	SYSTEMP2
	movwf	SysTemp2,BANKED
	movlw	0
	banksel	GLCDPRINTLOC_H
	addwfc	GLCDPRINTLOC_H,W,BANKED
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H,BANKED
	banksel	GLCDFNTDEFAULTSIZE
	movf	GLCDFNTDEFAULTSIZE,W,BANKED
	banksel	SYSTEMP2
	addwf	SysTemp2,W,BANKED
	movwf	SysTemp1,BANKED
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	SysTemp1_H,BANKED
	movlw	1
	subwf	SysTemp1,W,BANKED
	banksel	GLCDPRINTLOC
	movwf	GLCDPRINTLOC,BANKED
	movlw	0
	banksel	SYSTEMP1_H
	subwfb	SysTemp1_H,W,BANKED
	banksel	GLCDPRINTLOC_H
	movwf	GLCDPRINTLOC_H,BANKED
;next
	movffl	SysCHARSHandler,AFSR0
	movffl	SysCHARSHandler_H,AFSR0_H
	movf	INDF0,W,ACCESS
	banksel	XCHAR
	subwf	XCHAR,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop24
SysForLoopEnd24
;GLCDFontWidth = OldGLCDFontWidth
	movff	OLDGLCDFONTWIDTH,GLCDFONTWIDTH
	banksel	0
	return

;********************************************************************************

;Source: glcd.h (3618)
DRAW_ELLIPSE_POINTS
;dim LineColour as word
;Pset ((xoffset + GLCD_xx), (yoffset + GLCD_yy), LineColour)
	movf	GLCD_XX,W,BANKED
	banksel	XOFFSET
	addwf	XOFFSET,W,BANKED
	banksel	GLCDX
	movwf	GLCDX,BANKED
	clrf	GLCDX_H,BANKED
	btfsc	STATUS,C,ACCESS
	incf	GLCDX_H,F,BANKED
	movf	GLCD_YY,W,BANKED
	banksel	YOFFSET
	addwf	YOFFSET,W,BANKED
	banksel	GLCDY
	movwf	GLCDY,BANKED
	clrf	GLCDY_H,BANKED
	btfsc	STATUS,C,ACCESS
	incf	GLCDY_H,F,BANKED
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;Pset ((xoffset - GLCD_xx), (yoffset + GLCD_yy), LineColour)
	movf	GLCD_XX,W,BANKED
	banksel	XOFFSET
	subwf	XOFFSET,W,BANKED
	banksel	GLCDX
	movwf	GLCDX,BANKED
	clrf	GLCDX_H,BANKED
	btfss	STATUS,C,ACCESS
	decf	GLCDX_H,F,BANKED
	movf	GLCD_YY,W,BANKED
	banksel	YOFFSET
	addwf	YOFFSET,W,BANKED
	banksel	GLCDY
	movwf	GLCDY,BANKED
	clrf	GLCDY_H,BANKED
	btfsc	STATUS,C,ACCESS
	incf	GLCDY_H,F,BANKED
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;Pset ((xoffset - GLCD_xx), (yoffset - GLCD_yy), LineColour)
	movf	GLCD_XX,W,BANKED
	banksel	XOFFSET
	subwf	XOFFSET,W,BANKED
	banksel	GLCDX
	movwf	GLCDX,BANKED
	clrf	GLCDX_H,BANKED
	btfss	STATUS,C,ACCESS
	decf	GLCDX_H,F,BANKED
	movf	GLCD_YY,W,BANKED
	banksel	YOFFSET
	subwf	YOFFSET,W,BANKED
	banksel	GLCDY
	movwf	GLCDY,BANKED
	clrf	GLCDY_H,BANKED
	btfss	STATUS,C,ACCESS
	decf	GLCDY_H,F,BANKED
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;Pset ((xoffset + GLCD_xx), (yoffset - GLCD_yy), LineColour)
	movf	GLCD_XX,W,BANKED
	banksel	XOFFSET
	addwf	XOFFSET,W,BANKED
	banksel	GLCDX
	movwf	GLCDX,BANKED
	clrf	GLCDX_H,BANKED
	btfsc	STATUS,C,ACCESS
	incf	GLCDX_H,F,BANKED
	movf	GLCD_YY,W,BANKED
	banksel	YOFFSET
	subwf	YOFFSET,W,BANKED
	banksel	GLCDY
	movwf	GLCDY,BANKED
	clrf	GLCDY_H,BANKED
	btfss	STATUS,C,ACCESS
	decf	GLCDY_H,F,BANKED
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	goto	PSET_EPD2IN13D

;********************************************************************************

;Source: glcd.h (3627)
DRAW_FILLED_ELLIPSE_POINTS
;dim LineColour as word
;FOR GLCD_yy1 = (yoffset) to (yoffset + 2 * GLCD_yy)
	banksel	YOFFSET
	decf	YOFFSET,W,BANKED
	banksel	GLCD_YY1
	movwf	GLCD_YY1,BANKED
	movf	GLCD_YY,W,BANKED
	mullw	2
	movffl	PRODL,SysTemp3
	banksel	SYSTEMP3
	movf	SysTemp3,W,BANKED
	addwf	YOFFSET,W,BANKED
	movwf	SysTemp1,BANKED
	movff	YOFFSET,SysBYTETempB
	movff	SysTemp1,SysBYTETempA
	banksel	0
	call	SysCompLessThan
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd17
SysForLoop17
	incf	GLCD_YY1,F,BANKED
;Pset ((xoffset + GLCD_xx), (GLCD_yy1 - GLCD_yy), LineColour)
	movf	GLCD_XX,W,BANKED
	banksel	XOFFSET
	addwf	XOFFSET,W,BANKED
	banksel	GLCDX
	movwf	GLCDX,BANKED
	clrf	GLCDX_H,BANKED
	btfsc	STATUS,C,ACCESS
	incf	GLCDX_H,F,BANKED
	movf	GLCD_YY,W,BANKED
	subwf	GLCD_YY1,W,BANKED
	movwf	GLCDY,BANKED
	clrf	GLCDY_H,BANKED
	btfss	STATUS,C,ACCESS
	decf	GLCDY_H,F,BANKED
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;Pset ((xoffset - GLCD_xx), (GLCD_yy1 - GLCD_yy), LineColour)
	movf	GLCD_XX,W,BANKED
	banksel	XOFFSET
	subwf	XOFFSET,W,BANKED
	banksel	GLCDX
	movwf	GLCDX,BANKED
	clrf	GLCDX_H,BANKED
	btfss	STATUS,C,ACCESS
	decf	GLCDX_H,F,BANKED
	movf	GLCD_YY,W,BANKED
	subwf	GLCD_YY1,W,BANKED
	movwf	GLCDY,BANKED
	clrf	GLCDY_H,BANKED
	btfss	STATUS,C,ACCESS
	decf	GLCDY_H,F,BANKED
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;NEXT
	movf	GLCD_YY,W,BANKED
	mullw	2
	movffl	PRODL,SysTemp3
	banksel	SYSTEMP3
	movf	SysTemp3,W,BANKED
	addwf	YOFFSET,W,BANKED
	movwf	SysTemp1,BANKED
	movff	GLCD_YY1,SysBYTETempA
	movff	SysTemp1,SysBYTETempB
	banksel	0
	call	SysCompLessThan
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop17
SysForLoopEnd17
	return

;********************************************************************************

Delay_MS
	incf	SysWaitTempMS_H, F,ACCESS
DMS_START
	movlw	129
	movwf	DELAYTEMP2,ACCESS
DMS_OUTER
	movlw	40
	movwf	DELAYTEMP,ACCESS
DMS_INNER
	decfsz	DELAYTEMP, F,ACCESS
	bra	DMS_INNER
	decfsz	DELAYTEMP2, F,ACCESS
	bra	DMS_OUTER
	decfsz	SysWaitTempMS, F,ACCESS
	bra	DMS_START
	decfsz	SysWaitTempMS_H, F,ACCESS
	bra	DMS_START
	return

;********************************************************************************

;Source: hwspi.h (665)
FASTHWSPITRANSFER
;Master mode only
;One byte transfer count
;SPI1TCNTL = 1
	movlw	1
	banksel	SPI1TCNTL
	movwf	SPI1TCNTL,BANKED
;SPI1TXB = SPITxData
	movffl	SPITXDATA,SPI1TXB
;wait while SPI1RXIF = SPI_RX_IN_PROGRESS
SysWaitLoop1
	banksel	PIR2
	btfss	PIR2,SPI1RXIF,BANKED
	bra	SysWaitLoop1
;SPIRxData = SPI1RXB
	movffl	SPI1RXB,SPIRXDATA
	banksel	0
	return

;********************************************************************************

;Source: epd_epd2in13d.h (782)
FILLEDBOX_EPD2IN13D
;Make sure that starting point (1) is always less than end point (2)
;Dim EPD_Ind_raw, EPD_Ind_col as Word
;If LineX1 > LineX2 Then
	movff	LINEX1,SysWORDTempB
	movff	LINEX1_H,SysWORDTempB_H
	movff	LINEX2,SysWORDTempA
	movff	LINEX2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF116
;GLCDTemp = LineX1
	movff	LINEX1,GLCDTEMP
;LineX1 = LineX2
	movff	LINEX2,LINEX1
	movff	LINEX2_H,LINEX1_H
;LineX2 = GLCDTemp
	movff	GLCDTEMP,LINEX2
	clrf	LINEX2_H,BANKED
;End If
ENDIF116
;If LineY1 > LineY2 Then
	movff	LINEY1,SysWORDTempB
	movff	LINEY1_H,SysWORDTempB_H
	movff	LINEY2,SysWORDTempA
	movff	LINEY2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF117
;GLCDTemp = LineY1
	movff	LINEY1,GLCDTEMP
;LineY1 = LineY2
	movff	LINEY2,LINEY1
	movff	LINEY2_H,LINEY1_H
;LineY2 = GLCDTemp
	movff	GLCDTEMP,LINEY2
	clrf	LINEY2_H,BANKED
;End If
ENDIF117
;for EPD_Ind_raw=LineY1  to LineY2
	movlw	1
	subwf	LINEY1,W,BANKED
	movwf	EPD_IND_RAW,ACCESS
	movlw	0
	subwfb	LINEY1_H,W,BANKED
	movwf	EPD_IND_RAW_H,ACCESS
	movff	LINEY1,SysWORDTempB
	movff	LINEY1_H,SysWORDTempB_H
	movff	LINEY2,SysWORDTempA
	movff	LINEY2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd27
SysForLoop27
	incf	EPD_IND_RAW,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	EPD_IND_RAW_H,F,ACCESS
;for EPD_Ind_col=LineX1 to lineX2
	movlw	1
	subwf	LINEX1,W,BANKED
	movwf	EPD_IND_COL,ACCESS
	movlw	0
	subwfb	LINEX1_H,W,BANKED
	movwf	EPD_IND_COL_H,ACCESS
	movff	LINEX1,SysWORDTempB
	movff	LINEX1_H,SysWORDTempB_H
	movff	LINEX2,SysWORDTempA
	movff	LINEX2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd28
SysForLoop28
	incf	EPD_IND_COL,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	EPD_IND_COL_H,F,ACCESS
;PSet_EPD2in13D(EPD_Ind_Col, EPD_Ind_raw, LineColour)
	movff	EPD_IND_COL,GLCDX
	movff	EPD_IND_COL_H,GLCDX_H
	movff	EPD_IND_RAW,GLCDY
	movff	EPD_IND_RAW_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;next
	movff	EPD_IND_COL,SysWORDTempA
	movff	EPD_IND_COL_H,SysWORDTempA_H
	movff	LINEX2,SysWORDTempB
	movff	LINEX2_H,SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop28
SysForLoopEnd28
;next
	movff	EPD_IND_RAW,SysWORDTempA
	movff	EPD_IND_RAW_H,SysWORDTempA_H
	movff	LINEY2,SysWORDTempB
	movff	LINEY2_H,SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop27
SysForLoopEnd27
	return

;********************************************************************************

;Source: glcd.h (1429)
FILLEDCIRCLE
;Circle fill Code is merely a modification of the midpoint
;circle algorithem which is an adaption of Bresenham's line algorithm
;http://en.wikipedia.org/wiki/Midpoint_circle_algorithm
;http://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm
;dim ff, ddF_x, ddF_y as integer
;dim YCalc2, YCalc1 as word
;ff = 1 - xradius
	banksel	XRADIUS
	movf	XRADIUS,W,BANKED
	sublw	1
	movwf	FF,ACCESS
	clrf	SysTemp1,BANKED
	movf	XRADIUS_H,W,BANKED
	subwfb	SysTemp1,W,BANKED
	movwf	FF_H,ACCESS
;ddF_x = 1
	movlw	1
	movwf	DDF_X,ACCESS
	clrf	DDF_X_H,ACCESS
;ddF_y = -2 * xradius
	movff	XRADIUS,SysINTEGERTempA
	movff	XRADIUS_H,SysINTEGERTempA_H
	movlw	254
	movwf	SysINTEGERTempB,ACCESS
	setf	SysINTEGERTempB_H,ACCESS
	banksel	0
	call	SysMultSubINT
	movff	SysINTEGERTempX,DDF_Y
	movff	SysINTEGERTempX_H,DDF_Y_H
;FillCircleXX = 0
	clrf	FILLCIRCLEXX,ACCESS
;FillCircleYY = xradius
	movff	XRADIUS,FILLCIRCLEYY
;Fill in the center between the two halves
;YCalc2 = yoffset+xradius
	banksel	XRADIUS
	movf	XRADIUS,W,BANKED
	addwf	YOFFSET,W,BANKED
	movwf	YCALC2,BANKED
	movf	XRADIUS_H,W,BANKED
	addwfc	YOFFSET_H,W,BANKED
	movwf	YCALC2_H,BANKED
;YCalc1 = yoffset-xradius
	movf	XRADIUS,W,BANKED
	subwf	YOFFSET,W,BANKED
	movwf	YCALC1,BANKED
	movf	XRADIUS_H,W,BANKED
	subwfb	YOFFSET_H,W,BANKED
	movwf	YCALC1_H,BANKED
;Line( xoffset, YCalc1 , xoffset, YCalc2, LineColour)
	movff	XOFFSET,LINEX1
	movff	XOFFSET_H,LINEX1_H
	movff	YCALC1,LINEY1
	movff	YCALC1_H,LINEY1_H
	movff	XOFFSET,LINEX2
	movff	XOFFSET_H,LINEX2_H
	movff	YCALC2,LINEY2
	movff	YCALC2_H,LINEY2_H
	banksel	0
	call	LINE
;do while (FillCircleXX < FillCircleYY)
SysDoLoop_S1
	movf	FILLCIRCLEYY,W,ACCESS
	subwf	FILLCIRCLEXX,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	SysDoLoop_E1
;if ff >= 0 then
	movff	FF,SysINTEGERTempA
	movff	FF_H,SysINTEGERTempA_H
	clrf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SysCompLessThanINT
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF32
;FillCircleYY--
	decf	FILLCIRCLEYY,F,ACCESS
;ddF_y += 2
	movlw	2
	addwf	DDF_Y,F,ACCESS
	movlw	0
	addwfc	DDF_Y_H,F,ACCESS
;ff += ddF_y
	movf	DDF_Y,W,ACCESS
	addwf	FF,F,ACCESS
	movf	DDF_Y_H,W,ACCESS
	addwfc	FF_H,F,ACCESS
;end if
ENDIF32
;FillCircleXX++
	incf	FILLCIRCLEXX,F,ACCESS
;ddF_x += 2
	movlw	2
	addwf	DDF_X,F,ACCESS
	movlw	0
	addwfc	DDF_X_H,F,ACCESS
;ff += ddF_x
	movf	DDF_X,W,ACCESS
	addwf	FF,F,ACCESS
	movf	DDF_X_H,W,ACCESS
	addwfc	FF_H,F,ACCESS
;Now draw vertical lines between the points on the circle rather than
;draw the points of the circle. This draws lines between the
;perimeter points on the upper and lower quadrants of the 2 halves of the circle.
;Line(xoffset+FillCircleXX, yoffset+FillCircleYY, xoffset+FillCircleXX, yoffset-FillCircleYY, LineColour);
	movf	FILLCIRCLEXX,W,ACCESS
	banksel	XOFFSET
	addwf	XOFFSET,W,BANKED
	banksel	LINEX1
	movwf	LINEX1,BANKED
	movlw	0
	banksel	XOFFSET_H
	addwfc	XOFFSET_H,W,BANKED
	banksel	LINEX1_H
	movwf	LINEX1_H,BANKED
	movf	FILLCIRCLEYY,W,ACCESS
	banksel	YOFFSET
	addwf	YOFFSET,W,BANKED
	banksel	LINEY1
	movwf	LINEY1,BANKED
	movlw	0
	banksel	YOFFSET_H
	addwfc	YOFFSET_H,W,BANKED
	banksel	LINEY1_H
	movwf	LINEY1_H,BANKED
	movf	FILLCIRCLEXX,W,ACCESS
	banksel	XOFFSET
	addwf	XOFFSET,W,BANKED
	banksel	LINEX2
	movwf	LINEX2,BANKED
	movlw	0
	banksel	XOFFSET_H
	addwfc	XOFFSET_H,W,BANKED
	banksel	LINEX2_H
	movwf	LINEX2_H,BANKED
	movf	FILLCIRCLEYY,W,ACCESS
	banksel	YOFFSET
	subwf	YOFFSET,W,BANKED
	banksel	LINEY2
	movwf	LINEY2,BANKED
	movlw	0
	banksel	YOFFSET_H
	subwfb	YOFFSET_H,W,BANKED
	banksel	LINEY2_H
	movwf	LINEY2_H,BANKED
	call	LINE
;Line(xoffset-FillCircleXX, yoffset+FillCircleYY, xoffset-FillCircleXX, yoffset-FillCircleYY, LineColour);
	movf	FILLCIRCLEXX,W,ACCESS
	banksel	XOFFSET
	subwf	XOFFSET,W,BANKED
	banksel	LINEX1
	movwf	LINEX1,BANKED
	movlw	0
	banksel	XOFFSET_H
	subwfb	XOFFSET_H,W,BANKED
	banksel	LINEX1_H
	movwf	LINEX1_H,BANKED
	movf	FILLCIRCLEYY,W,ACCESS
	banksel	YOFFSET
	addwf	YOFFSET,W,BANKED
	banksel	LINEY1
	movwf	LINEY1,BANKED
	movlw	0
	banksel	YOFFSET_H
	addwfc	YOFFSET_H,W,BANKED
	banksel	LINEY1_H
	movwf	LINEY1_H,BANKED
	movf	FILLCIRCLEXX,W,ACCESS
	banksel	XOFFSET
	subwf	XOFFSET,W,BANKED
	banksel	LINEX2
	movwf	LINEX2,BANKED
	movlw	0
	banksel	XOFFSET_H
	subwfb	XOFFSET_H,W,BANKED
	banksel	LINEX2_H
	movwf	LINEX2_H,BANKED
	movf	FILLCIRCLEYY,W,ACCESS
	banksel	YOFFSET
	subwf	YOFFSET,W,BANKED
	banksel	LINEY2
	movwf	LINEY2,BANKED
	movlw	0
	banksel	YOFFSET_H
	subwfb	YOFFSET_H,W,BANKED
	banksel	LINEY2_H
	movwf	LINEY2_H,BANKED
	call	LINE
;Line(xoffset+FillCircleYY, yoffset+FillCircleXX, FillCircleYY+xoffset, yoffset-FillCircleXX, LineColour);
	movf	FILLCIRCLEYY,W,ACCESS
	banksel	XOFFSET
	addwf	XOFFSET,W,BANKED
	banksel	LINEX1
	movwf	LINEX1,BANKED
	movlw	0
	banksel	XOFFSET_H
	addwfc	XOFFSET_H,W,BANKED
	banksel	LINEX1_H
	movwf	LINEX1_H,BANKED
	movf	FILLCIRCLEXX,W,ACCESS
	banksel	YOFFSET
	addwf	YOFFSET,W,BANKED
	banksel	LINEY1
	movwf	LINEY1,BANKED
	movlw	0
	banksel	YOFFSET_H
	addwfc	YOFFSET_H,W,BANKED
	banksel	LINEY1_H
	movwf	LINEY1_H,BANKED
	banksel	XOFFSET
	movf	XOFFSET,W,BANKED
	addwf	FILLCIRCLEYY,W,ACCESS
	banksel	LINEX2
	movwf	LINEX2,BANKED
	movlw	0
	banksel	SYSTEMP1
	movwf	SysTemp1,BANKED
	movf	XOFFSET_H,W,BANKED
	addwfc	SysTemp1,W,BANKED
	banksel	LINEX2_H
	movwf	LINEX2_H,BANKED
	movf	FILLCIRCLEXX,W,ACCESS
	banksel	YOFFSET
	subwf	YOFFSET,W,BANKED
	banksel	LINEY2
	movwf	LINEY2,BANKED
	movlw	0
	banksel	YOFFSET_H
	subwfb	YOFFSET_H,W,BANKED
	banksel	LINEY2_H
	movwf	LINEY2_H,BANKED
	call	LINE
;Line(xoffset-FillCircleYY, yoffset+FillCircleXX, xoffset-FillCircleYY, yoffset-FillCircleXX, LineColour);
	movf	FILLCIRCLEYY,W,ACCESS
	banksel	XOFFSET
	subwf	XOFFSET,W,BANKED
	banksel	LINEX1
	movwf	LINEX1,BANKED
	movlw	0
	banksel	XOFFSET_H
	subwfb	XOFFSET_H,W,BANKED
	banksel	LINEX1_H
	movwf	LINEX1_H,BANKED
	movf	FILLCIRCLEXX,W,ACCESS
	banksel	YOFFSET
	addwf	YOFFSET,W,BANKED
	banksel	LINEY1
	movwf	LINEY1,BANKED
	movlw	0
	banksel	YOFFSET_H
	addwfc	YOFFSET_H,W,BANKED
	banksel	LINEY1_H
	movwf	LINEY1_H,BANKED
	movf	FILLCIRCLEYY,W,ACCESS
	banksel	XOFFSET
	subwf	XOFFSET,W,BANKED
	banksel	LINEX2
	movwf	LINEX2,BANKED
	movlw	0
	banksel	XOFFSET_H
	subwfb	XOFFSET_H,W,BANKED
	banksel	LINEX2_H
	movwf	LINEX2_H,BANKED
	movf	FILLCIRCLEXX,W,ACCESS
	banksel	YOFFSET
	subwf	YOFFSET,W,BANKED
	banksel	LINEY2
	movwf	LINEY2,BANKED
	movlw	0
	banksel	YOFFSET_H
	subwfb	YOFFSET_H,W,BANKED
	banksel	LINEY2_H
	movwf	LINEY2_H,BANKED
	call	LINE
;loop
	bra	SysDoLoop_S1
SysDoLoop_E1
	return

;********************************************************************************

;Source: glcd.h (3470)
FILLEDELLIPSE
;Version 1.00 (08/20/2017) by Joseph Realmuto
;draws a filled ellipse at location (xoffset, yoffset)
;Inxradius is x radius of ellipse
;Inyradius is y radius of ellipse
;filled_ellipse = 1
	movlw	1
	movwf	FILLED_ELLIPSE,ACCESS
;DrawEllipseRoutine( xoffset, yoffset, Inxradius, Inyradius, LineColour )
	goto	DRAWELLIPSEROUTINE

;********************************************************************************

;Source: glcd.h (4069)
FILLEDTRIANGLE
;dim  GLCD_aa, GLCD_bb, GLCD_last as word
;Sort coordinates by Y order (yoffset3 >= yoffset2 >= yoffset)
;if (yoffset > yoffset2) then
	movff	YOFFSET,SysWORDTempB
	movff	YOFFSET_H,SysWORDTempB_H
	movff	YOFFSET2,SysWORDTempA
	movff	YOFFSET2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF78
;swap(yoffset, yoffset2)
	movff	YOFFSET,SYSCALCTEMPA
	movff	YOFFSET_H,SYSCALCTEMPA_H
	movff	YOFFSET2,SYSCALCTEMPB
	movff	YOFFSET2_H,SYSCALCTEMPB_H
	call	SWAP509
	movff	SYSCALCTEMPA,YOFFSET
	movff	SYSCALCTEMPA_H,YOFFSET_H
	movff	SYSCALCTEMPB,YOFFSET2
	movff	SYSCALCTEMPB_H,YOFFSET2_H
;swap(xoffset, xoffset2)
	movff	XOFFSET,SYSCALCTEMPA
	movff	XOFFSET_H,SYSCALCTEMPA_H
	movff	XOFFSET2,SYSCALCTEMPB
	movff	XOFFSET2_H,SYSCALCTEMPB_H
	call	SWAP509
	movff	SYSCALCTEMPA,XOFFSET
	movff	SYSCALCTEMPA_H,XOFFSET_H
	movff	SYSCALCTEMPB,XOFFSET2
	movff	SYSCALCTEMPB_H,XOFFSET2_H
;end if
ENDIF78
;if (yoffset2 > yoffset3) then
	movff	YOFFSET2,SysWORDTempB
	movff	YOFFSET2_H,SysWORDTempB_H
	movff	YOFFSET3,SysWORDTempA
	movff	YOFFSET3_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF79
;swap(yoffset3, yoffset2)
	movff	YOFFSET3,SYSCALCTEMPA
	movff	YOFFSET3_H,SYSCALCTEMPA_H
	movff	YOFFSET2,SYSCALCTEMPB
	movff	YOFFSET2_H,SYSCALCTEMPB_H
	call	SWAP509
	movff	SYSCALCTEMPA,YOFFSET3
	movff	SYSCALCTEMPA_H,YOFFSET3_H
	movff	SYSCALCTEMPB,YOFFSET2
	movff	SYSCALCTEMPB_H,YOFFSET2_H
;swap(xoffset3, xoffset2)
	movff	XOFFSET3,SYSCALCTEMPA
	movff	XOFFSET3_H,SYSCALCTEMPA_H
	movff	XOFFSET2,SYSCALCTEMPB
	movff	XOFFSET2_H,SYSCALCTEMPB_H
	call	SWAP509
	movff	SYSCALCTEMPA,XOFFSET3
	movff	SYSCALCTEMPA_H,XOFFSET3_H
	movff	SYSCALCTEMPB,XOFFSET2
	movff	SYSCALCTEMPB_H,XOFFSET2_H
;end if
ENDIF79
;if (yoffset > yoffset2) then
	movff	YOFFSET,SysWORDTempB
	movff	YOFFSET_H,SysWORDTempB_H
	movff	YOFFSET2,SysWORDTempA
	movff	YOFFSET2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF80
;swap(yoffset, yoffset2)
	movff	YOFFSET,SYSCALCTEMPA
	movff	YOFFSET_H,SYSCALCTEMPA_H
	movff	YOFFSET2,SYSCALCTEMPB
	movff	YOFFSET2_H,SYSCALCTEMPB_H
	call	SWAP509
	movff	SYSCALCTEMPA,YOFFSET
	movff	SYSCALCTEMPA_H,YOFFSET_H
	movff	SYSCALCTEMPB,YOFFSET2
	movff	SYSCALCTEMPB_H,YOFFSET2_H
;swap(xoffset, xoffset2)
	movff	XOFFSET,SYSCALCTEMPA
	movff	XOFFSET_H,SYSCALCTEMPA_H
	movff	XOFFSET2,SYSCALCTEMPB
	movff	XOFFSET2_H,SYSCALCTEMPB_H
	call	SWAP509
	movff	SYSCALCTEMPA,XOFFSET
	movff	SYSCALCTEMPA_H,XOFFSET_H
	movff	SYSCALCTEMPB,XOFFSET2
	movff	SYSCALCTEMPB_H,XOFFSET2_H
;end if
ENDIF80
;Handle awkward all-on-same-line case as its own thing
;if (yoffset = yoffset3) then
	movff	YOFFSET,SysWORDTempA
	movff	YOFFSET_H,SysWORDTempA_H
	movff	YOFFSET3,SysWORDTempB
	movff	YOFFSET3_H,SysWORDTempB_H
	call	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF81
;GLCD_bb = xoffset
	movff	XOFFSET,GLCD_BB
	movff	XOFFSET_H,GLCD_BB_H
;GLCD_aa = xoffset
	movff	XOFFSET,GLCD_AA
	movff	XOFFSET_H,GLCD_AA_H
;if (xoffset2 < GLCD_aa ) Then
	movff	XOFFSET2,SysWORDTempA
	movff	XOFFSET2_H,SysWORDTempA_H
	movff	GLCD_AA,SysWORDTempB
	movff	GLCD_AA_H,SysWORDTempB_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE89_1
;GLCD_aa = xoffset2
	movff	XOFFSET2,GLCD_AA
	movff	XOFFSET2_H,GLCD_AA_H
;else if (xoffset2 > GLCD_bb ) then
	bra	ENDIF89
ELSE89_1
	movff	XOFFSET2,SysWORDTempB
	movff	XOFFSET2_H,SysWORDTempB_H
	movff	GLCD_BB,SysWORDTempA
	movff	GLCD_BB_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF89
;GLCD_bb = xoffset2
	movff	XOFFSET2,GLCD_BB
	movff	XOFFSET2_H,GLCD_BB_H
;end if
ENDIF89
;if (xoffset3 < GLCD_aa) Then
	movff	XOFFSET3,SysWORDTempA
	movff	XOFFSET3_H,SysWORDTempA_H
	movff	GLCD_AA,SysWORDTempB
	movff	GLCD_AA_H,SysWORDTempB_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE90_1
;GLCD_aa = xoffset3
	movff	XOFFSET3,GLCD_AA
	movff	XOFFSET3_H,GLCD_AA_H
;else if ( xoffset3 > GLCD_bb) then
	bra	ENDIF90
ELSE90_1
	movff	XOFFSET3,SysWORDTempB
	movff	XOFFSET3_H,SysWORDTempB_H
	movff	GLCD_BB,SysWORDTempA
	movff	GLCD_BB_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF90
;GLCD_bb = xoffset3
	movff	XOFFSET3,GLCD_BB
	movff	XOFFSET3_H,GLCD_BB_H
;end if
ENDIF90
;Line( GLCD_aa, yoffset, GLCD_bb - GLCD_aa + 1, yoffset, LineColour)
	movff	GLCD_AA,LINEX1
	movff	GLCD_AA_H,LINEX1_H
	movff	YOFFSET,LINEY1
	movff	YOFFSET_H,LINEY1_H
	movf	GLCD_AA,W,BANKED
	subwf	GLCD_BB,W,BANKED
	banksel	SYSTEMP2
	movwf	SysTemp2,BANKED
	banksel	GLCD_AA_H
	movf	GLCD_AA_H,W,BANKED
	subwfb	GLCD_BB_H,W,BANKED
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H,BANKED
	movlw	1
	addwf	SysTemp2,W,BANKED
	banksel	LINEX2
	movwf	LINEX2,BANKED
	movlw	0
	banksel	SYSTEMP2_H
	addwfc	SysTemp2_H,W,BANKED
	banksel	LINEX2_H
	movwf	LINEX2_H,BANKED
	movff	YOFFSET,LINEY2
	movff	YOFFSET_H,LINEY2_H
	call	LINE
;exit sub
	return
;end if
ENDIF81
;dim dxoffset01, dyoffset01, dxoffset02, dyoffset02, dxoffset12, dyoffset12, glcd_y as word
;dim glcd_sa, glcd_sb as Integer
;dxoffset01 = xoffset2 - xoffset
	banksel	XOFFSET
	movf	XOFFSET,W,BANKED
	subwf	XOFFSET2,W,BANKED
	movwf	DXOFFSET01,ACCESS
	movf	XOFFSET_H,W,BANKED
	subwfb	XOFFSET2_H,W,BANKED
	movwf	DXOFFSET01_H,ACCESS
;dyoffset01 = yoffset2 - yoffset
	movf	YOFFSET,W,BANKED
	subwf	YOFFSET2,W,BANKED
	movwf	DYOFFSET01,ACCESS
	movf	YOFFSET_H,W,BANKED
	subwfb	YOFFSET2_H,W,BANKED
	movwf	DYOFFSET01_H,ACCESS
;dxoffset02 = xoffset3 - xoffset
	movf	XOFFSET,W,BANKED
	subwf	XOFFSET3,W,BANKED
	movwf	DXOFFSET02,ACCESS
	movf	XOFFSET_H,W,BANKED
	subwfb	XOFFSET3_H,W,BANKED
	movwf	DXOFFSET02_H,ACCESS
;dyoffset02 = yoffset3 - yoffset
	movf	YOFFSET,W,BANKED
	subwf	YOFFSET3,W,BANKED
	movwf	DYOFFSET02,ACCESS
	movf	YOFFSET_H,W,BANKED
	subwfb	YOFFSET3_H,W,BANKED
	movwf	DYOFFSET02_H,ACCESS
;dxoffset12 = xoffset3 - xoffset2
	movf	XOFFSET2,W,BANKED
	subwf	XOFFSET3,W,BANKED
	movwf	DXOFFSET12,ACCESS
	movf	XOFFSET2_H,W,BANKED
	subwfb	XOFFSET3_H,W,BANKED
	movwf	DXOFFSET12_H,ACCESS
;dyoffset12 = yoffset3 - yoffset2
	movf	YOFFSET2,W,BANKED
	subwf	YOFFSET3,W,BANKED
	movwf	DYOFFSET12,ACCESS
	movf	YOFFSET2_H,W,BANKED
	subwfb	YOFFSET3_H,W,BANKED
	movwf	DYOFFSET12_H,ACCESS
;glcd_sa   = 0
	banksel	GLCD_SA
	clrf	GLCD_SA,BANKED
	clrf	GLCD_SA_H,BANKED
;glcd_sb   = 0
	clrf	GLCD_SB,BANKED
	clrf	GLCD_SB_H,BANKED
;
;For upper part of triangle, find scanline crossings for segments
;0-1 and 0-2.  If yoffset2=yoffset3 (flat-bottomed triangle), the scanline yoffset2
;is included here (and second loop will be skipped, avoiding a /0
;error there), otherwise scanline yoffset2 is skipped here and handled
;in the second loop...which also avoids a /0 error here if yoffset=yoffset2
;(flat-topped triangle).
;if ( yoffset2 = yoffset3) then
	movff	YOFFSET2,SysWORDTempA
	movff	YOFFSET2_H,SysWORDTempA_H
	movff	YOFFSET3,SysWORDTempB
	movff	YOFFSET3_H,SysWORDTempB_H
	call	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE82_1
;GLCD_last = yoffset2 ;   Include yoffset2 scanline
	movff	YOFFSET2,GLCD_LAST
	movff	YOFFSET2_H,GLCD_LAST_H
;else
	bra	ENDIF82
ELSE82_1
;GLCD_last = yoffset2 - 1;  Skip it
	movlw	1
	banksel	YOFFSET2
	subwf	YOFFSET2,W,BANKED
	banksel	GLCD_LAST
	movwf	GLCD_LAST,BANKED
	movlw	0
	banksel	YOFFSET2_H
	subwfb	YOFFSET2_H,W,BANKED
	banksel	GLCD_LAST_H
	movwf	GLCD_LAST_H,BANKED
;end if
ENDIF82
;for glcd_y = yoffset to glcd_last
	movlw	1
	banksel	YOFFSET
	subwf	YOFFSET,W,BANKED
	banksel	GLCD_Y
	movwf	GLCD_Y,BANKED
	movlw	0
	banksel	YOFFSET_H
	subwfb	YOFFSET_H,W,BANKED
	banksel	GLCD_Y_H
	movwf	GLCD_Y_H,BANKED
	movff	YOFFSET,SysWORDTempB
	movff	YOFFSET_H,SysWORDTempB_H
	movff	GLCD_LAST,SysWORDTempA
	movff	GLCD_LAST_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd18
SysForLoop18
	incf	GLCD_Y,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	GLCD_Y_H,F,BANKED
;glcd_aa   = xoffset +  glcd_sa / dyoffset01
	movff	GLCD_SA,SysINTEGERTempA
	movff	GLCD_SA_H,SysINTEGERTempA_H
	movff	DYOFFSET01,SysINTEGERTempB
	movff	DYOFFSET01_H,SysINTEGERTempB_H
	call	SysDivSubINT
	movf	SysINTEGERTempA,W,ACCESS
	banksel	XOFFSET
	addwf	XOFFSET,W,BANKED
	banksel	GLCD_AA
	movwf	GLCD_AA,BANKED
	movf	SysINTEGERTempA_H,W,ACCESS
	banksel	XOFFSET_H
	addwfc	XOFFSET_H,W,BANKED
	banksel	GLCD_AA_H
	movwf	GLCD_AA_H,BANKED
;glcd_bb   = xoffset +  glcd_sb / dyoffset02
	movff	GLCD_SB,SysINTEGERTempA
	movff	GLCD_SB_H,SysINTEGERTempA_H
	movff	DYOFFSET02,SysINTEGERTempB
	movff	DYOFFSET02_H,SysINTEGERTempB_H
	call	SysDivSubINT
	movf	SysINTEGERTempA,W,ACCESS
	banksel	XOFFSET
	addwf	XOFFSET,W,BANKED
	banksel	GLCD_BB
	movwf	GLCD_BB,BANKED
	movf	SysINTEGERTempA_H,W,ACCESS
	banksel	XOFFSET_H
	addwfc	XOFFSET_H,W,BANKED
	banksel	GLCD_BB_H
	movwf	GLCD_BB_H,BANKED
;glcd_sa = glcd_sa + dxoffset01
	movf	DXOFFSET01,W,ACCESS
	addwf	GLCD_SA,F,BANKED
	movf	DXOFFSET01_H,W,ACCESS
	addwfc	GLCD_SA_H,F,BANKED
;glcd_sb = glcd_sb + dxoffset02
	movf	DXOFFSET02,W,ACCESS
	addwf	GLCD_SB,F,BANKED
	movf	DXOFFSET02_H,W,ACCESS
	addwfc	GLCD_SB_H,F,BANKED
;if (glcd_aa > glcd_bb)  then
	movff	GLCD_AA,SysWORDTempB
	movff	GLCD_AA_H,SysWORDTempB_H
	movff	GLCD_BB,SysWORDTempA
	movff	GLCD_BB_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF84
;swap(glcd_aa, glcd_bb)
	movff	GLCD_AA,SYSCALCTEMPA
	movff	GLCD_AA_H,SYSCALCTEMPA_H
	movff	GLCD_BB,SYSCALCTEMPB
	movff	GLCD_BB_H,SYSCALCTEMPB_H
	call	SWAP509
	movff	SYSCALCTEMPA,GLCD_AA
	movff	SYSCALCTEMPA_H,GLCD_AA_H
	movff	SYSCALCTEMPB,GLCD_BB
	movff	SYSCALCTEMPB_H,GLCD_BB_H
;end if
ENDIF84
;Line(glcd_aa, glcd_y, glcd_bb , glcd_y, LineColour)
	movff	GLCD_AA,LINEX1
	movff	GLCD_AA_H,LINEX1_H
	movff	GLCD_Y,LINEY1
	movff	GLCD_Y_H,LINEY1_H
	movff	GLCD_BB,LINEX2
	movff	GLCD_BB_H,LINEX2_H
	movff	GLCD_Y,LINEY2
	movff	GLCD_Y_H,LINEY2_H
	call	LINE
;next
	movff	GLCD_Y,SysWORDTempA
	movff	GLCD_Y_H,SysWORDTempA_H
	movff	GLCD_LAST,SysWORDTempB
	movff	GLCD_LAST_H,SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop18
SysForLoopEnd18
;For lower part of triangle, find scanline crossings for segments
;0-2 and 1-2.  This loop is skipped if yoffset2=yoffset3.
;glcd_sa = dxoffset12 * (glcd_y - yoffset2);
	banksel	YOFFSET2
	movf	YOFFSET2,W,BANKED
	banksel	GLCD_Y
	subwf	GLCD_Y,W,BANKED
	banksel	SYSTEMP2
	movwf	SysTemp2,BANKED
	movf	YOFFSET2_H,W,BANKED
	banksel	GLCD_Y_H
	subwfb	GLCD_Y_H,W,BANKED
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H,BANKED
	movff	DXOFFSET12,SysINTEGERTempA
	movff	DXOFFSET12_H,SysINTEGERTempA_H
	movff	SysTemp2,SysINTEGERTempB
	movff	SysTemp2_H,SysINTEGERTempB_H
	banksel	0
	call	SysMultSubINT
	movff	SysINTEGERTempX,GLCD_SA
	movff	SysINTEGERTempX_H,GLCD_SA_H
;glcd_sb = dxoffset02 * (glcd_y - yoffset);
	banksel	YOFFSET
	movf	YOFFSET,W,BANKED
	banksel	GLCD_Y
	subwf	GLCD_Y,W,BANKED
	banksel	SYSTEMP2
	movwf	SysTemp2,BANKED
	movf	YOFFSET_H,W,BANKED
	banksel	GLCD_Y_H
	subwfb	GLCD_Y_H,W,BANKED
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H,BANKED
	movff	DXOFFSET02,SysINTEGERTempA
	movff	DXOFFSET02_H,SysINTEGERTempA_H
	movff	SysTemp2,SysINTEGERTempB
	movff	SysTemp2_H,SysINTEGERTempB_H
	banksel	0
	call	SysMultSubINT
	movff	SysINTEGERTempX,GLCD_SB
	movff	SysINTEGERTempX_H,GLCD_SB_H
;for glcd_y = glcd_last to yoffset3
	movlw	1
	subwf	GLCD_LAST,W,BANKED
	movwf	GLCD_Y,BANKED
	movlw	0
	subwfb	GLCD_LAST_H,W,BANKED
	movwf	GLCD_Y_H,BANKED
	movff	GLCD_LAST,SysWORDTempB
	movff	GLCD_LAST_H,SysWORDTempB_H
	movff	YOFFSET3,SysWORDTempA
	movff	YOFFSET3_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd19
SysForLoop19
	incf	GLCD_Y,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	GLCD_Y_H,F,BANKED
;glcd_aa   = xoffset2 +  glcd_sa / dyoffset12
	movff	GLCD_SA,SysINTEGERTempA
	movff	GLCD_SA_H,SysINTEGERTempA_H
	movff	DYOFFSET12,SysINTEGERTempB
	movff	DYOFFSET12_H,SysINTEGERTempB_H
	call	SysDivSubINT
	movf	SysINTEGERTempA,W,ACCESS
	banksel	XOFFSET2
	addwf	XOFFSET2,W,BANKED
	banksel	GLCD_AA
	movwf	GLCD_AA,BANKED
	movf	SysINTEGERTempA_H,W,ACCESS
	banksel	XOFFSET2_H
	addwfc	XOFFSET2_H,W,BANKED
	banksel	GLCD_AA_H
	movwf	GLCD_AA_H,BANKED
;glcd_bb   = xoffset +  glcd_sb / dyoffset02
	movff	GLCD_SB,SysINTEGERTempA
	movff	GLCD_SB_H,SysINTEGERTempA_H
	movff	DYOFFSET02,SysINTEGERTempB
	movff	DYOFFSET02_H,SysINTEGERTempB_H
	call	SysDivSubINT
	movf	SysINTEGERTempA,W,ACCESS
	banksel	XOFFSET
	addwf	XOFFSET,W,BANKED
	banksel	GLCD_BB
	movwf	GLCD_BB,BANKED
	movf	SysINTEGERTempA_H,W,ACCESS
	banksel	XOFFSET_H
	addwfc	XOFFSET_H,W,BANKED
	banksel	GLCD_BB_H
	movwf	GLCD_BB_H,BANKED
;glcd_sa = glcd_sa + dxoffset12
	movf	DXOFFSET12,W,ACCESS
	addwf	GLCD_SA,F,BANKED
	movf	DXOFFSET12_H,W,ACCESS
	addwfc	GLCD_SA_H,F,BANKED
;glcd_sb = glcd_sb + dxoffset02
	movf	DXOFFSET02,W,ACCESS
	addwf	GLCD_SB,F,BANKED
	movf	DXOFFSET02_H,W,ACCESS
	addwfc	GLCD_SB_H,F,BANKED
;if (glcd_aa > glcd_bb)  then
	movff	GLCD_AA,SysWORDTempB
	movff	GLCD_AA_H,SysWORDTempB_H
	movff	GLCD_BB,SysWORDTempA
	movff	GLCD_BB_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF87
;swap(glcd_aa, glcd_bb)
	movff	GLCD_AA,SYSCALCTEMPA
	movff	GLCD_AA_H,SYSCALCTEMPA_H
	movff	GLCD_BB,SYSCALCTEMPB
	movff	GLCD_BB_H,SYSCALCTEMPB_H
	call	SWAP509
	movff	SYSCALCTEMPA,GLCD_AA
	movff	SYSCALCTEMPA_H,GLCD_AA_H
	movff	SYSCALCTEMPB,GLCD_BB
	movff	SYSCALCTEMPB_H,GLCD_BB_H
;end if
ENDIF87
;Line(glcd_aa, glcd_y, glcd_bb , glcd_y, LineColour)
	movff	GLCD_AA,LINEX1
	movff	GLCD_AA_H,LINEX1_H
	movff	GLCD_Y,LINEY1
	movff	GLCD_Y_H,LINEY1_H
	movff	GLCD_BB,LINEX2
	movff	GLCD_BB_H,LINEX2_H
	movff	GLCD_Y,LINEY2
	movff	GLCD_Y_H,LINEY2_H
	call	LINE
;next
	movff	GLCD_Y,SysWORDTempA
	movff	GLCD_Y_H,SysWORDTempA_H
	movff	YOFFSET3,SysWORDTempB
	movff	YOFFSET3_H,SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop19
SysForLoopEnd19
	return

;********************************************************************************

;Source: glcd.h (1619)
FILLROUNDRECT
;Dim FRI as Word
;if RX1>RX2 then SWAP (RX1 , RX2)
	movff	RX1,SysWORDTempB
	movff	RX1_H,SysWORDTempB_H
	movff	RX2,SysWORDTempA
	movff	RX2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF38
	movff	RX1,SYSCALCTEMPA
	movff	RX1_H,SYSCALCTEMPA_H
	movff	RX2,SYSCALCTEMPB
	movff	RX2_H,SYSCALCTEMPB_H
	call	SWAP509
	movff	SYSCALCTEMPA,RX1
	movff	SYSCALCTEMPA_H,RX1_H
	movff	SYSCALCTEMPB,RX2
	movff	SYSCALCTEMPB_H,RX2_H
ENDIF38
;if RY1>RY2 then SWAP (RY1 , RY2)
	movff	RY1,SysWORDTempB
	movff	RY1_H,SysWORDTempB_H
	movff	RY2,SysWORDTempA
	movff	RY2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF39
	movff	RY1,SYSCALCTEMPA
	movff	RY1_H,SYSCALCTEMPA_H
	movff	RY2,SYSCALCTEMPB
	movff	RY2_H,SYSCALCTEMPB_H
	call	SWAP509
	movff	SYSCALCTEMPA,RY1
	movff	SYSCALCTEMPA_H,RY1_H
	movff	SYSCALCTEMPB,RY2
	movff	SYSCALCTEMPB_H,RY2_H
ENDIF39
;if (RX2-RX1>4) and (RY2-RY1>4) Then
	movf	RX1,W,BANKED
	subwf	RX2,W,BANKED
	banksel	SYSTEMP2
	movwf	SysTemp2,BANKED
	banksel	RX1_H
	movf	RX1_H,W,BANKED
	subwfb	RX2_H,W,BANKED
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H,BANKED
	movff	SysTemp2,SysWORDTempB
	movff	SysTemp2_H,SysWORDTempB_H
	movlw	4
	movwf	SysWORDTempA,ACCESS
	clrf	SysWORDTempA_H,ACCESS
	banksel	0
	call	SysCompLessThan16
	movff	SysByteTempX,SysTemp1
	movf	RY1,W,BANKED
	subwf	RY2,W,BANKED
	banksel	SYSTEMP2
	movwf	SysTemp2,BANKED
	banksel	RY1_H
	movf	RY1_H,W,BANKED
	subwfb	RY2_H,W,BANKED
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H,BANKED
	movff	SysTemp2,SysWORDTempB
	movff	SysTemp2_H,SysWORDTempB_H
	movlw	4
	movwf	SysWORDTempA,ACCESS
	clrf	SysWORDTempA_H,ACCESS
	banksel	0
	call	SysCompLessThan16
	movff	SysByteTempX,SysTemp3
	banksel	SYSTEMP1
	movf	SysTemp1,W,BANKED
	andwf	SysTemp3,W,BANKED
	movwf	SysTemp2,BANKED
	btfss	SysTemp2,0,BANKED
	bra	ENDIF40
;for FRI=0 to (RY2-RY1)/2
	banksel	FRI
	setf	FRI,BANKED
	setf	FRI_H,BANKED
	movf	RY1,W,BANKED
	subwf	RY2,W,BANKED
	banksel	SYSTEMP2
	movwf	SysTemp2,BANKED
	banksel	RY1_H
	movf	RY1_H,W,BANKED
	subwfb	RY2_H,W,BANKED
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H,BANKED
	movff	SysTemp2,SysWORDTempA
	movff	SysTemp2_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	call	SysDivSub16
	movff	SysWORDTempA,SysTemp1
	movff	SysWORDTempA_H,SysTemp1_H
	clrf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	movff	SysTemp1,SysWORDTempA
	movff	SysTemp1_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd16
SysForLoop16
	incf	FRI,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	FRI_H,F,BANKED
;Select Case FRI
;Case 0
SysSelect1Case1
	movff	FRI,SysWORDTempA
	movff	FRI_H,SysWORDTempA_H
	clrf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect1Case2
;Line RX1+3 , RY1 , RX2-3, RY1 , Color
	movlw	3
	addwf	RX1,W,BANKED
	movwf	LINEX1,BANKED
	movlw	0
	addwfc	RX1_H,W,BANKED
	movwf	LINEX1_H,BANKED
	movff	RY1,LINEY1
	movff	RY1_H,LINEY1_H
	movlw	3
	subwf	RX2,W,BANKED
	movwf	LINEX2,BANKED
	movlw	0
	subwfb	RX2_H,W,BANKED
	movwf	LINEX2_H,BANKED
	movff	RY1,LINEY2
	movff	RY1_H,LINEY2_H
	movff	COLOR,LINECOLOUR
	movff	COLOR_H,LINECOLOUR_H
	call	LINE
;Line RX1+3 , RY2 , RX2-3, RY2 , Color
	movlw	3
	addwf	RX1,W,BANKED
	movwf	LINEX1,BANKED
	movlw	0
	addwfc	RX1_H,W,BANKED
	movwf	LINEX1_H,BANKED
	movff	RY2,LINEY1
	movff	RY2_H,LINEY1_H
	movlw	3
	subwf	RX2,W,BANKED
	movwf	LINEX2,BANKED
	movlw	0
	subwfb	RX2_H,W,BANKED
	movwf	LINEX2_H,BANKED
	movff	RY2,LINEY2
	movff	RY2_H,LINEY2_H
	movff	COLOR,LINECOLOUR
	movff	COLOR_H,LINECOLOUR_H
	call	LINE
;Case 1
	bra	SysSelectEnd1
SysSelect1Case2
	movff	FRI,SysWORDTempA
	movff	FRI_H,SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect1Case3
;Line RX1+2 , RY1+1 , RX2-2, RY1+1 , Color
	movlw	2
	addwf	RX1,W,BANKED
	movwf	LINEX1,BANKED
	movlw	0
	addwfc	RX1_H,W,BANKED
	movwf	LINEX1_H,BANKED
	movlw	1
	addwf	RY1,W,BANKED
	movwf	LINEY1,BANKED
	movlw	0
	addwfc	RY1_H,W,BANKED
	movwf	LINEY1_H,BANKED
	movlw	2
	subwf	RX2,W,BANKED
	movwf	LINEX2,BANKED
	movlw	0
	subwfb	RX2_H,W,BANKED
	movwf	LINEX2_H,BANKED
	movlw	1
	addwf	RY1,W,BANKED
	movwf	LINEY2,BANKED
	movlw	0
	addwfc	RY1_H,W,BANKED
	movwf	LINEY2_H,BANKED
	movff	COLOR,LINECOLOUR
	movff	COLOR_H,LINECOLOUR_H
	call	LINE
;Line RX1+2 , RY2-1 , RX2-1, RY2-1 , Color
	movlw	2
	addwf	RX1,W,BANKED
	movwf	LINEX1,BANKED
	movlw	0
	addwfc	RX1_H,W,BANKED
	movwf	LINEX1_H,BANKED
	movlw	1
	subwf	RY2,W,BANKED
	movwf	LINEY1,BANKED
	movlw	0
	subwfb	RY2_H,W,BANKED
	movwf	LINEY1_H,BANKED
	movlw	1
	subwf	RX2,W,BANKED
	movwf	LINEX2,BANKED
	movlw	0
	subwfb	RX2_H,W,BANKED
	movwf	LINEX2_H,BANKED
	movlw	1
	subwf	RY2,W,BANKED
	movwf	LINEY2,BANKED
	movlw	0
	subwfb	RY2_H,W,BANKED
	movwf	LINEY2_H,BANKED
	movff	COLOR,LINECOLOUR
	movff	COLOR_H,LINECOLOUR_H
	call	LINE
;Case 2
	bra	SysSelectEnd1
SysSelect1Case3
	movff	FRI,SysWORDTempA
	movff	FRI_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect1Case4
;Line RX1+1 , RY1+2 , RX2-1, RY1+2 , Color
	movlw	1
	addwf	RX1,W,BANKED
	movwf	LINEX1,BANKED
	movlw	0
	addwfc	RX1_H,W,BANKED
	movwf	LINEX1_H,BANKED
	movlw	2
	addwf	RY1,W,BANKED
	movwf	LINEY1,BANKED
	movlw	0
	addwfc	RY1_H,W,BANKED
	movwf	LINEY1_H,BANKED
	movlw	1
	subwf	RX2,W,BANKED
	movwf	LINEX2,BANKED
	movlw	0
	subwfb	RX2_H,W,BANKED
	movwf	LINEX2_H,BANKED
	movlw	2
	addwf	RY1,W,BANKED
	movwf	LINEY2,BANKED
	movlw	0
	addwfc	RY1_H,W,BANKED
	movwf	LINEY2_H,BANKED
	movff	COLOR,LINECOLOUR
	movff	COLOR_H,LINECOLOUR_H
	call	LINE
;Line RX1+1 , RY2-2 , RX2-1, RY2-2 , Color
	movlw	1
	addwf	RX1,W,BANKED
	movwf	LINEX1,BANKED
	movlw	0
	addwfc	RX1_H,W,BANKED
	movwf	LINEX1_H,BANKED
	movlw	2
	subwf	RY2,W,BANKED
	movwf	LINEY1,BANKED
	movlw	0
	subwfb	RY2_H,W,BANKED
	movwf	LINEY1_H,BANKED
	movlw	1
	subwf	RX2,W,BANKED
	movwf	LINEX2,BANKED
	movlw	0
	subwfb	RX2_H,W,BANKED
	movwf	LINEX2_H,BANKED
	movlw	2
	subwf	RY2,W,BANKED
	movwf	LINEY2,BANKED
	movlw	0
	subwfb	RY2_H,W,BANKED
	movwf	LINEY2_H,BANKED
	movff	COLOR,LINECOLOUR
	movff	COLOR_H,LINECOLOUR_H
	call	LINE
;Case Else
	bra	SysSelectEnd1
SysSelect1Case4
;Line RX1 , RY1+FRI , RX2, RY1+FRI , Color
	movff	RX1,LINEX1
	movff	RX1_H,LINEX1_H
	movf	FRI,W,BANKED
	addwf	RY1,W,BANKED
	movwf	LINEY1,BANKED
	movf	FRI_H,W,BANKED
	addwfc	RY1_H,W,BANKED
	movwf	LINEY1_H,BANKED
	movff	RX2,LINEX2
	movff	RX2_H,LINEX2_H
	movf	FRI,W,BANKED
	addwf	RY1,W,BANKED
	movwf	LINEY2,BANKED
	movf	FRI_H,W,BANKED
	addwfc	RY1_H,W,BANKED
	movwf	LINEY2_H,BANKED
	movff	COLOR,LINECOLOUR
	movff	COLOR_H,LINECOLOUR_H
	call	LINE
;Line RX1 , RY2-FRI , RX2, RY2-FRI , Color
	movff	RX1,LINEX1
	movff	RX1_H,LINEX1_H
	movf	FRI,W,BANKED
	subwf	RY2,W,BANKED
	movwf	LINEY1,BANKED
	movf	FRI_H,W,BANKED
	subwfb	RY2_H,W,BANKED
	movwf	LINEY1_H,BANKED
	movff	RX2,LINEX2
	movff	RX2_H,LINEX2_H
	movf	FRI,W,BANKED
	subwf	RY2,W,BANKED
	movwf	LINEY2,BANKED
	movf	FRI_H,W,BANKED
	subwfb	RY2_H,W,BANKED
	movwf	LINEY2_H,BANKED
	movff	COLOR,LINECOLOUR
	movff	COLOR_H,LINECOLOUR_H
	call	LINE
;End Select
SysSelectEnd1
;Next
	movf	RY1,W,BANKED
	subwf	RY2,W,BANKED
	banksel	SYSTEMP2
	movwf	SysTemp2,BANKED
	banksel	RY1_H
	movf	RY1_H,W,BANKED
	subwfb	RY2_H,W,BANKED
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H,BANKED
	movff	SysTemp2,SysWORDTempA
	movff	SysTemp2_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	call	SysDivSub16
	movff	SysWORDTempA,SysTemp1
	movff	SysWORDTempA_H,SysTemp1_H
	movff	FRI,SysWORDTempA
	movff	FRI_H,SysWORDTempA_H
	movff	SysTemp1,SysWORDTempB
	movff	SysTemp1_H,SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop16
SysForLoopEnd16
;End if
ENDIF40
	banksel	0
	return

;********************************************************************************

;Overloaded signature: LONG:BYTE:, Source: stdbasic.h (378)
FN_FNLSR515
;Repeat NumBits
	movff	NUMBITS,SysRepeatTemp1
	banksel	SYSREPEATTEMP1
	movf	SYSREPEATTEMP1,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd1
SysRepeatLoop1
;Set C Off
	bcf	STATUS,C,ACCESS
;Rotate SysLongTempB Right
	rrcf	SYSLONGTEMPB_E,F,ACCESS
	rrcf	SYSLONGTEMPB_U,F,ACCESS
	rrcf	SYSLONGTEMPB_H,F,ACCESS
	rrcf	SYSLONGTEMPB,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp1,F,BANKED
	bra	SysRepeatLoop1
SysRepeatLoopEnd1
;FnLSR = SysLongTempB
	movff	SYSLONGTEMPB,FNLSR
	movff	SYSLONGTEMPB_H,FNLSR_H
	movff	SYSLONGTEMPB_U,FNLSR_U
	movff	SYSLONGTEMPB_E,FNLSR_E
	banksel	0
	return

;********************************************************************************

;Overloaded signature: WORD:BYTE:, Source: stdbasic.h (386)
FN_FNLSR516
;Repeat NumBits
	movff	NUMBITS,SysRepeatTemp2
	banksel	SYSREPEATTEMP2
	movf	SYSREPEATTEMP2,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd2
SysRepeatLoop2
;Set C Off
	bcf	STATUS,C,ACCESS
;Rotate SysWordTempB Right
	rrcf	SYSWORDTEMPB_H,F,ACCESS
	rrcf	SYSWORDTEMPB,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp2,F,BANKED
	bra	SysRepeatLoop2
SysRepeatLoopEnd2
;FnLSR = SysWordTempB
	movff	SYSWORDTEMPB,FNLSR
	movff	SYSWORDTEMPB_H,FNLSR_H
	banksel	0
	return

;********************************************************************************

;Source: glcd.h (1125)
GLCDLOCATESTRING
;dim PrintLocY as word
;if PrintLocY < 2 then
	movff	PRINTLOCY,SysWORDTempA
	movff	PRINTLOCY_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE25_1
;PrintLocY = 0
	clrf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
;else
	bra	ENDIF25
ELSE25_1
;PrintLocY--
	movlw	1
	subwf	PRINTLOCY,F,BANKED
	movlw	0
	subwfb	PRINTLOCY_H,F,BANKED
;PrintLocY = ( PrintLocY * ( GLCDfntDefaultHeight * GLCDfntDefaultSize ) ) mod EPD_CORRECTED_HEIGHT
	movf	GLCDFNTDEFAULTHEIGHT,W,BANKED
	mulwf	GLCDFNTDEFAULTSIZE,BANKED
	movffl	PRODL,SysTemp1
	movff	PRINTLOCY,SysWORDTempA
	movff	PRINTLOCY_H,SysWORDTempA_H
	movff	SysTemp1,SysWORDTempB
	clrf	SysWORDTempB_H,ACCESS
	call	SysMultSub16
	movff	SysWORDTempX,SysTemp2
	movff	SysWORDTempX_H,SysTemp2_H
	movff	SysTemp2,SysWORDTempA
	movff	SysTemp2_H,SysWORDTempA_H
	movlw	208
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysDivSub16
	movff	SysWORDTempX,PRINTLOCY
	movff	SysWORDTempX_H,PRINTLOCY_H
;end if
ENDIF25
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:STRING:, Source: glcd.h (846)
GLCDPRINT4
;GLCD.h Sub GLCDPrint
;Dim GLCDPrintLoc  as word
;Dim GLCDPrint_String_Counter, GLCDPrintLen as byte
;GLCDPrintLen = LCDPrintData(0)
	movffl	SysLCDPRINTDATAHandler,AFSR0
	movffl	SysLCDPRINTDATAHandler_H,AFSR0_H
	movffl	INDF0,GLCDPRINTLEN
;If GLCDPrintLen = 0 Then Exit Sub
	movf	GLCDPRINTLEN,F,BANKED
	btfsc	STATUS, Z,ACCESS
	return
;dim OldGLCDFontWidth as Byte
;OldGLCDFontWidth = GLCDFontWidth
	movff	GLCDFONTWIDTH,OLDGLCDFONTWIDTH
;GLCDPrintLoc = PrintLocX
	movff	PRINTLOCX,GLCDPRINTLOC
	movff	PRINTLOCX_H,GLCDPRINTLOC_H
;Write Data
;For GLCDPrint_String_Counter = 1 To GLCDPrintLen
	clrf	GLCDPRINT_STRING_COUNTER,BANKED
	movlw	1
	subwf	GLCDPRINTLEN,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd13
SysForLoop13
	incf	GLCDPRINT_STRING_COUNTER,F,BANKED
;GLCDDrawChar  GLCDPrintLoc, PrintLocY, LCDPrintData(GLCDPrint_String_Counter)
	movff	GLCDPRINTLOC,CHARLOCX
	movff	GLCDPRINTLOC_H,CHARLOCX_H
	movff	PRINTLOCY,CHARLOCY
	movff	PRINTLOCY_H,CHARLOCY_H
	movf	GLCDPRINT_STRING_COUNTER,W,BANKED
	banksel	SYSLCDPRINTDATAHANDLER
	addwf	SysLCDPRINTDATAHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysLCDPRINTDATAHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movffl	INDF0,CHARCODE
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWCHAR_EPD2IN13D
;GLCDPrintIncrementPixelPositionMacro
;Macro Source: glcd.h (1084)
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize ) + GLCDfntDefaultsize - 1
	movf	GLCDFONTWIDTH,W,BANKED
	mulwf	GLCDFNTDEFAULTSIZE,BANKED
	movffl	PRODL,SysTemp1
	banksel	SYSTEMP1
	movf	SysTemp1,W,BANKED
	banksel	GLCDPRINTLOC
	addwf	GLCDPRINTLOC,W,BANKED
	banksel	SYSTEMP2
	movwf	SysTemp2,BANKED
	movlw	0
	banksel	GLCDPRINTLOC_H
	addwfc	GLCDPRINTLOC_H,W,BANKED
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H,BANKED
	banksel	GLCDFNTDEFAULTSIZE
	movf	GLCDFNTDEFAULTSIZE,W,BANKED
	banksel	SYSTEMP2
	addwf	SysTemp2,W,BANKED
	movwf	SysTemp1,BANKED
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	SysTemp1_H,BANKED
	movlw	1
	subwf	SysTemp1,W,BANKED
	banksel	GLCDPRINTLOC
	movwf	GLCDPRINTLOC,BANKED
	movlw	0
	banksel	SYSTEMP1_H
	subwfb	SysTemp1_H,W,BANKED
	banksel	GLCDPRINTLOC_H
	movwf	GLCDPRINTLOC_H,BANKED
;Next
	movf	GLCDPRINTLEN,W,BANKED
	subwf	GLCDPRINT_STRING_COUNTER,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop13
SysForLoopEnd13
;Update the current X position for GLCDPrintString
;PrintLocX = GLCDPrintLoc
	movff	GLCDPRINTLOC,PRINTLOCX
	movff	GLCDPRINTLOC_H,PRINTLOCX_H
;GLCDFontWidth = OldGLCDFontWidth
	movff	OLDGLCDFONTWIDTH,GLCDFONTWIDTH
	return

;********************************************************************************

;Source: glcd.h (1097)
GLCDPRINTSTRING
;dim PrintLocX as word
;Print at the current X and Y post
;GLCDPrint( PrintLocX , PrintLocY , LCDPrintData )
	movff	SysLCDPRINTDATAHandler,SysLCDPRINTDATAHandler
	movff	SysLCDPRINTDATAHandler_H,SysLCDPRINTDATAHandler_H
	bra	GLCDPRINT4

;********************************************************************************

;Source: glcd.h (1105)
GLCDPRINTSTRINGLN
;dim PrintLocX, PrintLocY as word
;GLCDPrint( PrintLocX , PrintLocY , LCDPrintData )
	movff	SysLCDPRINTDATAHandler,SysLCDPRINTDATAHandler
	movff	SysLCDPRINTDATAHandler_H,SysLCDPRINTDATAHandler_H
	rcall	GLCDPRINT4
;Update the current X and Y position
;PrintLocX = 0
	clrf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
;When using Transaction  PrintLocY will get incremented. This needs to be protected
;PrintLocY = ( PrintLocY + ( GLCDfntDefaultHeight * GLCDfntDefaultSize ) ) mod EPD_CORRECTED_HEIGHT
	movf	GLCDFNTDEFAULTHEIGHT,W,BANKED
	mulwf	GLCDFNTDEFAULTSIZE,BANKED
	movffl	PRODL,SysTemp1
	banksel	SYSTEMP1
	movf	SysTemp1,W,BANKED
	banksel	PRINTLOCY
	addwf	PRINTLOCY,W,BANKED
	banksel	SYSTEMP2
	movwf	SysTemp2,BANKED
	movlw	0
	banksel	PRINTLOCY_H
	addwfc	PRINTLOCY_H,W,BANKED
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H,BANKED
	movff	SysTemp2,SysWORDTempA
	movff	SysTemp2_H,SysWORDTempA_H
	movlw	208
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	call	SysDivSub16
	movff	SysWORDTempX,PRINTLOCY
	movff	SysWORDTempX_H,PRINTLOCY_H
	return

;********************************************************************************

;Source: glcd.h (3650)
HYPERBOLE
;if type=1 is alined along x
;if type=2 is alined along y
;if ModeStop=1 drawing stops when one of the borders has been encountered
;if ModeStop=2 drawing stops when all (possible) borders has been encountered
;ModeStop is not relevant for hyperbola centered on the display
;Dim a_axis, b_axis, a_sq, b_sq, half_a_sq, half_b_sq as word  'axis smaller than 254
;Dim dist as Long
;Dim a_sq2, b_sq2, a_sq4, b_sq4, half_ab_sq as Long
;Dim x_slope, y_slope as Long
;Dim dist_sign as byte
;Dim x_offset, y_offset, x_0, y_0  as word
;Dim x_coord, y_coord, x_max, y_max as Word
;Dim x_plus, x_minus, y_plus, y_minus as Word
;Dim type, ModeStop as byte
;Dim Linecolour as word
;Dim HyperboleCondition, intersect as byte
;if Type=1 then
	banksel	TYPE
	decf	TYPE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE52_1
;x_offset=x_0
	movff	X_0,X_OFFSET
	movff	X_0_H,X_OFFSET_H
;y_offset=y_0
	movff	Y_0,Y_OFFSET
	movff	Y_0_H,Y_OFFSET_H
;x_max=GLCD_WIDTH
	movlw	104
	movwf	X_MAX,BANKED
	clrf	X_MAX_H,BANKED
;y_max=GLCD_HEIGHT
	movlw	212
	movwf	Y_MAX,BANKED
	clrf	Y_MAX_H,BANKED
;else
	bra	ENDIF52
ELSE52_1
;y_offset=x_0
	movff	X_0,Y_OFFSET
	movff	X_0_H,Y_OFFSET_H
;x_offset=y_0
	movff	Y_0,X_OFFSET
	movff	Y_0_H,X_OFFSET_H
;y_max=GLCD_WIDTH
	movlw	104
	movwf	Y_MAX,BANKED
	clrf	Y_MAX_H,BANKED
;x_max=GLCD_HEIGHT
	movlw	212
	movwf	X_MAX,BANKED
	clrf	X_MAX_H,BANKED
;end if
ENDIF52
;x_coord=a_axis
	movff	A_AXIS,X_COORD
	movff	A_AXIS_H,X_COORD_H
;y_coord=0
	clrf	Y_COORD,BANKED
	clrf	Y_COORD_H,BANKED
;a_sq=a_axis*a_axis
	movff	A_AXIS,SysWORDTempA
	movff	A_AXIS_H,SysWORDTempA_H
	movff	A_AXIS,SysWORDTempB
	movff	A_AXIS_H,SysWORDTempB_H
	banksel	0
	call	SysMultSub16
	movff	SysWORDTempX,A_SQ
	movff	SysWORDTempX_H,A_SQ_H
;b_sq=b_axis*b_axis
	movff	B_AXIS,SysWORDTempA
	movff	B_AXIS_H,SysWORDTempA_H
	movff	B_AXIS,SysWORDTempB
	movff	B_AXIS_H,SysWORDTempB_H
	call	SysMultSub16
	movff	SysWORDTempX,B_SQ
	movff	SysWORDTempX_H,B_SQ_H
;a_sq2=a_sq+a_sq
	movf	A_SQ,W,ACCESS
	addwf	A_SQ,W,ACCESS
	movwf	A_SQ2,ACCESS
	movf	A_SQ_H,W,ACCESS
	addwfc	A_SQ_H,W,ACCESS
	movwf	A_SQ2_H,ACCESS
	clrf	A_SQ2_U,ACCESS
	btfsc	STATUS,C,ACCESS
	incf	A_SQ2_U,F,ACCESS
	clrf	A_SQ2_E,ACCESS
;b_sq2=b_sq+b_sq
	movf	B_SQ,W,ACCESS
	addwf	B_SQ,W,ACCESS
	movwf	B_SQ2,ACCESS
	movf	B_SQ_H,W,ACCESS
	addwfc	B_SQ_H,W,ACCESS
	movwf	B_SQ2_H,ACCESS
	clrf	B_SQ2_U,ACCESS
	btfsc	STATUS,C,ACCESS
	incf	B_SQ2_U,F,ACCESS
	clrf	B_SQ2_E,ACCESS
;a_sq4=a_sq2+a_sq2
	movf	A_SQ2,W,ACCESS
	addwf	A_SQ2,W,ACCESS
	movwf	A_SQ4,ACCESS
	movf	A_SQ2_H,W,ACCESS
	addwfc	A_SQ2_H,W,ACCESS
	movwf	A_SQ4_H,ACCESS
	movf	A_SQ2_U,W,ACCESS
	addwfc	A_SQ2_U,W,ACCESS
	movwf	A_SQ4_U,ACCESS
	movf	A_SQ2_E,W,ACCESS
	addwfc	A_SQ2_E,W,ACCESS
	movwf	A_SQ4_E,ACCESS
;b_sq4=b_sq2+b_sq2
	movf	B_SQ2,W,ACCESS
	addwf	B_SQ2,W,ACCESS
	movwf	B_SQ4,ACCESS
	movf	B_SQ2_H,W,ACCESS
	addwfc	B_SQ2_H,W,ACCESS
	movwf	B_SQ4_H,ACCESS
	movf	B_SQ2_U,W,ACCESS
	addwfc	B_SQ2_U,W,ACCESS
	movwf	B_SQ4_U,ACCESS
	movf	B_SQ2_E,W,ACCESS
	addwfc	B_SQ2_E,W,ACCESS
	movwf	B_SQ4_E,ACCESS
;x_slope=a_sq4*(x_coord+1)
	movlw	1
	banksel	X_COORD
	addwf	X_COORD,W,BANKED
	movwf	SysTemp2,BANKED
	movlw	0
	addwfc	X_COORD_H,W,BANKED
	movwf	SysTemp2_H,BANKED
	movff	A_SQ4,SysLONGTempA
	movff	A_SQ4_H,SysLONGTempA_H
	movff	A_SQ4_U,SysLONGTempA_U
	movff	A_SQ4_E,SysLONGTempA_E
	movff	SysTemp2,SysLONGTempB
	movff	SysTemp2_H,SysLONGTempB_H
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	banksel	0
	call	SysMultSub32
	movff	SysLONGTempX,X_SLOPE
	movff	SysLONGTempX_H,X_SLOPE_H
	movff	SysLONGTempX_U,X_SLOPE_U
	movff	SysLONGTempX_E,X_SLOPE_E
;y_slope=b_sq4             '*(y_coord+1)
	movff	B_SQ4,Y_SLOPE
	movff	B_SQ4_H,Y_SLOPE_H
	movff	B_SQ4_U,Y_SLOPE_U
	movff	B_SQ4_E,Y_SLOPE_E
;half_a_sq=FNLSR(a_sq,1)
	movff	A_SQ,SYSWORDTEMPB
	movff	A_SQ_H,SYSWORDTEMPB_H
	movlw	1
	movwf	NUMBITS,BANKED
	rcall	FN_FNLSR516
	movff	SYSFNLSRWORD,HALF_A_SQ
	movff	SYSFNLSRWORD_H,HALF_A_SQ_H
;half_b_sq=FNLSR(b_sq,1)
	movff	B_SQ,SYSWORDTEMPB
	movff	B_SQ_H,SYSWORDTEMPB_H
	movlw	1
	movwf	NUMBITS,BANKED
	rcall	FN_FNLSR516
	movff	SYSFNLSRWORD,HALF_B_SQ
	movff	SYSFNLSRWORD_H,HALF_B_SQ_H
;half_ab_sq=half_a_sq+half_b_sq
	movf	HALF_B_SQ,W,BANKED
	addwf	HALF_A_SQ,W,BANKED
	movwf	HALF_AB_SQ,BANKED
	movf	HALF_B_SQ_H,W,BANKED
	addwfc	HALF_A_SQ_H,W,BANKED
	movwf	HALF_AB_SQ_H,BANKED
	clrf	HALF_AB_SQ_U,BANKED
	btfsc	STATUS,C,ACCESS
	incf	HALF_AB_SQ_U,F,BANKED
	clrf	HALF_AB_SQ_E,BANKED
;dist=a_sq2+half_b_sq
	movf	HALF_B_SQ,W,BANKED
	addwf	A_SQ2,W,ACCESS
	movwf	DIST,ACCESS
	movf	HALF_B_SQ_H,W,BANKED
	addwfc	A_SQ2_H,W,ACCESS
	movwf	DIST_H,ACCESS
	movlw	0
	addwfc	A_SQ2_U,W,ACCESS
	movwf	DIST_U,ACCESS
	movlw	0
	addwfc	A_SQ2_E,W,ACCESS
	movwf	DIST_E,ACCESS
;dist_sign=0
	clrf	DIST_SIGN,ACCESS
;HyperboleParabolaDiffvar(dist, b_sq*(1+2*a_axis), dist_sign)
	movff	DIST,VAR1
	movff	DIST_H,VAR1_H
	movff	DIST_U,VAR1_U
	movff	DIST_E,VAR1_E
	movff	A_AXIS,SysWORDTempA
	movff	A_AXIS_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysMultSub16
	movff	SysWORDTempX,SysTemp2
	movff	SysWORDTempX_H,SysTemp2_H
	movlw	1
	banksel	SYSTEMP2
	addwf	SysTemp2,W,BANKED
	movwf	SysTemp1,BANKED
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	SysTemp1_H,BANKED
	movff	B_SQ,SysLONGTempA
	movff	B_SQ_H,SysLONGTempA_H
	clrf	SysLONGTempA_U,ACCESS
	clrf	SysLONGTempA_E,ACCESS
	movff	SysTemp1,SysLONGTempB
	movff	SysTemp1_H,SysLONGTempB_H
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	banksel	0
	call	SysMultSub32
	movff	SysLONGTempX,VAR2
	movff	SysLONGTempX_H,VAR2_H
	movff	SysLONGTempX_U,VAR2_U
	movff	SysLONGTempX_E,VAR2_E
	movff	DIST_SIGN,SIGN
	rcall	HYPERBOLEPARABOLADIFFVAR
	movff	VAR1,DIST
	movff	VAR1_H,DIST_H
	movff	VAR1_U,DIST_U
	movff	VAR1_E,DIST_E
	movff	SIGN,DIST_SIGN
;intersect=0
	clrf	INTERSECT,BANKED
;x_plus=x_offset+x_coord
	banksel	X_COORD
	movf	X_COORD,W,BANKED
	addwf	X_OFFSET,W,BANKED
	movwf	X_PLUS,BANKED
	movf	X_COORD_H,W,BANKED
	addwfc	X_OFFSET_H,W,BANKED
	movwf	X_PLUS_H,BANKED
;x_minus=x_offset-x_coord
	movf	X_COORD,W,BANKED
	subwf	X_OFFSET,W,BANKED
	movwf	X_MINUS,BANKED
	movf	X_COORD_H,W,BANKED
	subwfb	X_OFFSET_H,W,BANKED
	movwf	X_MINUS_H,BANKED
;y_plus=y_offset+y_coord
	movf	Y_COORD,W,BANKED
	addwf	Y_OFFSET,W,BANKED
	movwf	Y_PLUS,BANKED
	movf	Y_COORD_H,W,BANKED
	addwfc	Y_OFFSET_H,W,BANKED
	movwf	Y_PLUS_H,BANKED
;y_minus=y_offset-y_coord
	movf	Y_COORD,W,BANKED
	subwf	Y_OFFSET,W,BANKED
	movwf	Y_MINUS,BANKED
	movf	Y_COORD_H,W,BANKED
	subwfb	Y_OFFSET_H,W,BANKED
	movwf	Y_MINUS_H,BANKED
;do while (dist_sign=1 or (dist_sign=0 and dist<=x_slope))
SysDoLoop_S6
	movff	dist_sign,SysBYTETempA
	clrf	SysBYTETempB,ACCESS
	banksel	0
	call	SysCompEqual
	movff	SysByteTempX,SysTemp3
	movff	dist,SysLONGTempB
	movff	dist_H,SysLONGTempB_H
	movff	dist_U,SysLONGTempB_U
	movff	dist_E,SysLONGTempB_E
	movff	x_slope,SysLONGTempA
	movff	x_slope_H,SysLONGTempA_H
	movff	x_slope_U,SysLONGTempA_U
	movff	x_slope_E,SysLONGTempA_E
	call	SysCompLessThan32
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	banksel	SYSTEMP3
	movf	SysTemp3,W,BANKED
	andwf	SysTemp1,W,BANKED
	movwf	SysTemp2,BANKED
	movff	dist_sign,SysBYTETempA
	movlw	1
	movwf	SysBYTETempB,ACCESS
	banksel	0
	call	SysCompEqual
	movf	SysByteTempX,W,ACCESS
	banksel	SYSTEMP2
	iorwf	SysTemp2,W,BANKED
	movwf	SysTemp3,BANKED
	btfss	SysTemp3,0,BANKED
	bra	SysDoLoop_E6
;if HyperboleCondition(ModeStop)=0 then
	banksel	0
	rcall	FN_HYPERBOLECONDITION
	movf	HYPERBOLECONDITION,F,BANKED
	btfsc	STATUS, Z,ACCESS
;exit do
	bra	SysDoLoop_E6
;end if
;HyperboleDisplayPixel(LineColour)
	rcall	HYPERBOLEDISPLAYPIXEL
;if dist_sign=0 then
	movf	DIST_SIGN,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF54
;HyperboleParabolaDiffvar (dist, x_slope, dist_sign)
	movff	DIST,VAR1
	movff	DIST_H,VAR1_H
	movff	DIST_U,VAR1_U
	movff	DIST_E,VAR1_E
	movff	X_SLOPE,VAR2
	movff	X_SLOPE_H,VAR2_H
	movff	X_SLOPE_U,VAR2_U
	movff	X_SLOPE_E,VAR2_E
	movff	DIST_SIGN,SIGN
	rcall	HYPERBOLEPARABOLADIFFVAR
	movff	VAR1,DIST
	movff	VAR1_H,DIST_H
	movff	VAR1_U,DIST_U
	movff	VAR1_E,DIST_E
	movff	VAR2,X_SLOPE
	movff	VAR2_H,X_SLOPE_H
	movff	VAR2_U,X_SLOPE_U
	movff	VAR2_E,X_SLOPE_E
	movff	SIGN,DIST_SIGN
;x_coord=x_coord+1
	banksel	X_COORD
	incf	X_COORD,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	X_COORD_H,F,BANKED
;x_slope=x_slope+b_sq4
	movf	B_SQ4,W,ACCESS
	addwf	X_SLOPE,F,BANKED
	movf	B_SQ4_H,W,ACCESS
	addwfc	X_SLOPE_H,F,BANKED
	movf	B_SQ4_U,W,ACCESS
	addwfc	X_SLOPE_U,F,BANKED
	movf	B_SQ4_E,W,ACCESS
	addwfc	X_SLOPE_E,F,BANKED
;end if
ENDIF54
;HyperboleParabolaSumvar(dist, a_sq2+y_slope, dist_sign)
	movff	DIST,VAR1
	movff	DIST_H,VAR1_H
	movff	DIST_U,VAR1_U
	movff	DIST_E,VAR1_E
	banksel	Y_SLOPE
	movf	Y_SLOPE,W,BANKED
	addwf	A_SQ2,W,ACCESS
	movwf	VAR2,BANKED
	movf	Y_SLOPE_H,W,BANKED
	addwfc	A_SQ2_H,W,ACCESS
	movwf	VAR2_H,BANKED
	movf	Y_SLOPE_U,W,BANKED
	addwfc	A_SQ2_U,W,ACCESS
	movwf	VAR2_U,BANKED
	movf	Y_SLOPE_E,W,BANKED
	addwfc	A_SQ2_E,W,ACCESS
	movwf	VAR2_E,BANKED
	movff	DIST_SIGN,SIGN
	banksel	0
	rcall	HYPERBOLEPARABOLASUMVAR
	movff	VAR1,DIST
	movff	VAR1_H,DIST_H
	movff	VAR1_U,DIST_U
	movff	VAR1_E,DIST_E
	movff	SIGN,DIST_SIGN
;y_coord=y_coord+1
	banksel	Y_COORD
	incf	Y_COORD,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	Y_COORD_H,F,BANKED
;y_slope=y_slope+a_sq4
	movf	A_SQ4,W,ACCESS
	addwf	Y_SLOPE,F,BANKED
	movf	A_SQ4_H,W,ACCESS
	addwfc	Y_SLOPE_H,F,BANKED
	movf	A_SQ4_U,W,ACCESS
	addwfc	Y_SLOPE_U,F,BANKED
	movf	A_SQ4_E,W,ACCESS
	addwfc	Y_SLOPE_E,F,BANKED
;x_plus=x_offset+x_coord
	movf	X_COORD,W,BANKED
	addwf	X_OFFSET,W,BANKED
	movwf	X_PLUS,BANKED
	movf	X_COORD_H,W,BANKED
	addwfc	X_OFFSET_H,W,BANKED
	movwf	X_PLUS_H,BANKED
;x_minus=x_offset-x_coord
	movf	X_COORD,W,BANKED
	subwf	X_OFFSET,W,BANKED
	movwf	X_MINUS,BANKED
	movf	X_COORD_H,W,BANKED
	subwfb	X_OFFSET_H,W,BANKED
	movwf	X_MINUS_H,BANKED
;y_plus=y_offset+y_coord
	movf	Y_COORD,W,BANKED
	addwf	Y_OFFSET,W,BANKED
	movwf	Y_PLUS,BANKED
	movf	Y_COORD_H,W,BANKED
	addwfc	Y_OFFSET_H,W,BANKED
	movwf	Y_PLUS_H,BANKED
;y_minus=y_offset-y_coord
	movf	Y_COORD,W,BANKED
	subwf	Y_OFFSET,W,BANKED
	movwf	Y_MINUS,BANKED
	movf	Y_COORD_H,W,BANKED
	subwfb	Y_OFFSET_H,W,BANKED
	movwf	Y_MINUS_H,BANKED
;Loop
	bra	SysDoLoop_S6
SysDoLoop_E6
;HyperboleParabolaSumvar(dist,a_sq+b_sq, dist_sign)
	movff	DIST,VAR1
	movff	DIST_H,VAR1_H
	movff	DIST_U,VAR1_U
	movff	DIST_E,VAR1_E
	movf	B_SQ,W,ACCESS
	addwf	A_SQ,W,ACCESS
	banksel	VAR2
	movwf	VAR2,BANKED
	movf	B_SQ_H,W,ACCESS
	addwfc	A_SQ_H,W,ACCESS
	movwf	VAR2_H,BANKED
	clrf	VAR2_U,BANKED
	btfsc	STATUS,C,ACCESS
	incf	VAR2_U,F,BANKED
	clrf	VAR2_E,BANKED
	movff	DIST_SIGN,SIGN
	banksel	0
	rcall	HYPERBOLEPARABOLASUMVAR
	movff	VAR1,DIST
	movff	VAR1_H,DIST_H
	movff	VAR1_U,DIST_U
	movff	VAR1_E,DIST_E
	movff	SIGN,DIST_SIGN
;HyperboleParabolaDiffvar(dist,FNLSR(x_slope+y_slope,1)+half_ab_sq, dist_sign)
	movff	DIST,VAR1
	movff	DIST_H,VAR1_H
	movff	DIST_U,VAR1_U
	movff	DIST_E,VAR1_E
	banksel	Y_SLOPE
	movf	Y_SLOPE,W,BANKED
	addwf	X_SLOPE,W,BANKED
	movwf	SYSLONGTEMPB,ACCESS
	movf	Y_SLOPE_H,W,BANKED
	addwfc	X_SLOPE_H,W,BANKED
	movwf	SYSLONGTEMPB_H,ACCESS
	movf	Y_SLOPE_U,W,BANKED
	addwfc	X_SLOPE_U,W,BANKED
	movwf	SYSLONGTEMPB_U,ACCESS
	movf	Y_SLOPE_E,W,BANKED
	addwfc	X_SLOPE_E,W,BANKED
	movwf	SYSLONGTEMPB_E,ACCESS
	movlw	1
	banksel	NUMBITS
	movwf	NUMBITS,BANKED
	rcall	FN_FNLSR515
	movf	HALF_AB_SQ,W,BANKED
	addwf	SYSFNLSRLONG,W,BANKED
	banksel	VAR2
	movwf	VAR2,BANKED
	banksel	HALF_AB_SQ_H
	movf	HALF_AB_SQ_H,W,BANKED
	addwfc	SYSFNLSRLONG_H,W,BANKED
	banksel	VAR2_H
	movwf	VAR2_H,BANKED
	banksel	HALF_AB_SQ_U
	movf	HALF_AB_SQ_U,W,BANKED
	addwfc	SYSFNLSRLONG_U,W,BANKED
	banksel	VAR2_U
	movwf	VAR2_U,BANKED
	banksel	HALF_AB_SQ_E
	movf	HALF_AB_SQ_E,W,BANKED
	addwfc	SYSFNLSRLONG_E,W,BANKED
	banksel	VAR2_E
	movwf	VAR2_E,BANKED
	movff	DIST_SIGN,SIGN
	banksel	0
	rcall	HYPERBOLEPARABOLADIFFVAR
	movff	VAR1,DIST
	movff	VAR1_H,DIST_H
	movff	VAR1_U,DIST_U
	movff	VAR1_E,DIST_E
	movff	SIGN,DIST_SIGN
;intersect=0
	clrf	INTERSECT,BANKED
;if a_axis>b_axis then
	movff	A_AXIS,SysWORDTempB
	movff	A_AXIS_H,SysWORDTempB_H
	movff	B_AXIS,SysWORDTempA
	movff	B_AXIS_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF55
;do
SysDoLoop_S7
;if HyperboleCondition(ModeStop)=0 then
	banksel	0
	rcall	FN_HYPERBOLECONDITION
	movf	HYPERBOLECONDITION,F,BANKED
	btfsc	STATUS, Z,ACCESS
;exit do
	bra	SysDoLoop_E7
;end if
;HyperboleDisplayPixel(LineColour)
	rcall	HYPERBOLEDISPLAYPIXEL
;if dist_sign=1 then
	decf	DIST_SIGN,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF57
;HyperboleParabolaSumvar(dist,y_slope,dist_sign)
	movff	DIST,VAR1
	movff	DIST_H,VAR1_H
	movff	DIST_U,VAR1_U
	movff	DIST_E,VAR1_E
	movff	Y_SLOPE,VAR2
	movff	Y_SLOPE_H,VAR2_H
	movff	Y_SLOPE_U,VAR2_U
	movff	Y_SLOPE_E,VAR2_E
	movff	DIST_SIGN,SIGN
	rcall	HYPERBOLEPARABOLASUMVAR
	movff	VAR1,DIST
	movff	VAR1_H,DIST_H
	movff	VAR1_U,DIST_U
	movff	VAR1_E,DIST_E
	movff	VAR2,Y_SLOPE
	movff	VAR2_H,Y_SLOPE_H
	movff	VAR2_U,Y_SLOPE_U
	movff	VAR2_E,Y_SLOPE_E
	movff	SIGN,DIST_SIGN
;y_coord=y_coord+1
	banksel	Y_COORD
	incf	Y_COORD,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	Y_COORD_H,F,BANKED
;y_slope=y_slope+a_sq4
	movf	A_SQ4,W,ACCESS
	addwf	Y_SLOPE,F,BANKED
	movf	A_SQ4_H,W,ACCESS
	addwfc	Y_SLOPE_H,F,BANKED
	movf	A_SQ4_U,W,ACCESS
	addwfc	Y_SLOPE_U,F,BANKED
	movf	A_SQ4_E,W,ACCESS
	addwfc	Y_SLOPE_E,F,BANKED
;end if
ENDIF57
;HyperboleParabolaDiffvar(dist,b_sq2+x_slope,dist_sign)
	movff	DIST,VAR1
	movff	DIST_H,VAR1_H
	movff	DIST_U,VAR1_U
	movff	DIST_E,VAR1_E
	banksel	X_SLOPE
	movf	X_SLOPE,W,BANKED
	addwf	B_SQ2,W,ACCESS
	movwf	VAR2,BANKED
	movf	X_SLOPE_H,W,BANKED
	addwfc	B_SQ2_H,W,ACCESS
	movwf	VAR2_H,BANKED
	movf	X_SLOPE_U,W,BANKED
	addwfc	B_SQ2_U,W,ACCESS
	movwf	VAR2_U,BANKED
	movf	X_SLOPE_E,W,BANKED
	addwfc	B_SQ2_E,W,ACCESS
	movwf	VAR2_E,BANKED
	movff	DIST_SIGN,SIGN
	banksel	0
	rcall	HYPERBOLEPARABOLADIFFVAR
	movff	VAR1,DIST
	movff	VAR1_H,DIST_H
	movff	VAR1_U,DIST_U
	movff	VAR1_E,DIST_E
	movff	SIGN,DIST_SIGN
;x_coord=x_coord+1
	banksel	X_COORD
	incf	X_COORD,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	X_COORD_H,F,BANKED
;x_slope=x_slope+b_sq4
	movf	B_SQ4,W,ACCESS
	addwf	X_SLOPE,F,BANKED
	movf	B_SQ4_H,W,ACCESS
	addwfc	X_SLOPE_H,F,BANKED
	movf	B_SQ4_U,W,ACCESS
	addwfc	X_SLOPE_U,F,BANKED
	movf	B_SQ4_E,W,ACCESS
	addwfc	X_SLOPE_E,F,BANKED
;x_plus=x_offset+x_coord
	movf	X_COORD,W,BANKED
	addwf	X_OFFSET,W,BANKED
	movwf	X_PLUS,BANKED
	movf	X_COORD_H,W,BANKED
	addwfc	X_OFFSET_H,W,BANKED
	movwf	X_PLUS_H,BANKED
;x_minus=x_offset-x_coord
	movf	X_COORD,W,BANKED
	subwf	X_OFFSET,W,BANKED
	movwf	X_MINUS,BANKED
	movf	X_COORD_H,W,BANKED
	subwfb	X_OFFSET_H,W,BANKED
	movwf	X_MINUS_H,BANKED
;y_plus=y_offset+y_coord
	movf	Y_COORD,W,BANKED
	addwf	Y_OFFSET,W,BANKED
	movwf	Y_PLUS,BANKED
	movf	Y_COORD_H,W,BANKED
	addwfc	Y_OFFSET_H,W,BANKED
	movwf	Y_PLUS_H,BANKED
;y_minus=y_offset-y_coord
	movf	Y_COORD,W,BANKED
	subwf	Y_OFFSET,W,BANKED
	movwf	Y_MINUS,BANKED
	movf	Y_COORD_H,W,BANKED
	subwfb	Y_OFFSET_H,W,BANKED
	movwf	Y_MINUS_H,BANKED
;loop
	bra	SysDoLoop_S7
SysDoLoop_E7
;end if
ENDIF55
	return

;********************************************************************************

;Source: glcd.h (3759)
FN_HYPERBOLECONDITION
;Dim HyperboleCondition, ModeStop as Byte
;Dim x_coord, y_coord, x_max, y_max, x_offset, y_offset, x_plus, y_plus as Word
;Dim intersect as Byte
;if ModeStop=1 then
	decf	MODESTOP,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE58_1
;if (y_plus<y_max and x_plus<x_max) and (x_coord<=x_offset and y_coord<=y_offset) then
;if intersect=0 then
	movf	INTERSECT,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE59_1
;HyperboleCondition=1
	movlw	1
	movwf	HYPERBOLECONDITION,BANKED
;else
	bra	ENDIF59
ELSE59_1
;HyperboleCondition=0
	clrf	HYPERBOLECONDITION,BANKED
;end if
ENDIF59
;else
	bra	ENDIF58
ELSE58_1
;if (y_plus<y_max or x_plus<x_max) or (x_coord<=x_offset or y_coord<=y_offset) then
;if intersect=0b1111 then
	movlw	15
	subwf	INTERSECT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE60_1
;HyperboleCondition=0
	clrf	HYPERBOLECONDITION,BANKED
;else
	bra	ENDIF60
ELSE60_1
;HyperboleCondition=1
	movlw	1
	movwf	HYPERBOLECONDITION,BANKED
;end if
ENDIF60
;end if
ENDIF58
	return

;********************************************************************************

;Source: glcd.h (3782)
HYPERBOLEDISPLAYPIXEL
;Dim x_max, y_max, x_plus, x_minus, y_plus, y_minus as Word
;Dim LineColour as word
;Dim Type, intersect as Byte
;if Type = 1 then
	banksel	TYPE
	decf	TYPE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE61_1
;if x_plus<=x_max  then
	movff	X_PLUS,SysWORDTempB
	movff	X_PLUS_H,SysWORDTempB_H
	movff	X_MAX,SysWORDTempA
	movff	X_MAX_H,SysWORDTempA_H
	banksel	0
	call	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE62_1
;if y_plus<=y_max then
	movff	Y_PLUS,SysWORDTempB
	movff	Y_PLUS_H,SysWORDTempB_H
	movff	Y_MAX,SysWORDTempA
	movff	Y_MAX_H,SysWORDTempA_H
	call	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE66_1
;Pset(x_plus, y_plus, Linecolour)
	movff	X_PLUS,GLCDX
	movff	X_PLUS_H,GLCDX_H
	movff	Y_PLUS,GLCDY
	movff	Y_PLUS_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;else
	bra	ENDIF66
ELSE66_1
;intersect.0=1
	bsf	INTERSECT,0,BANKED
;end if
ENDIF66
;if y_minus.15=0 then
	banksel	Y_MINUS_H
	btfsc	Y_MINUS_H,7,BANKED
	bra	ELSE67_1
;Pset(x_plus, y_minus, Linecolour)
	movff	X_PLUS,GLCDX
	movff	X_PLUS_H,GLCDX_H
	movff	Y_MINUS,GLCDY
	movff	Y_MINUS_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	banksel	0
	call	PSET_EPD2IN13D
;else
	bra	ENDIF67
ELSE67_1
;intersect.1=1
	banksel	INTERSECT
	bsf	INTERSECT,1,BANKED
;end if
ENDIF67
;else
	bra	ENDIF62
ELSE62_1
;intersect.0=1
	bsf	INTERSECT,0,BANKED
;intersect.1=1
	bsf	INTERSECT,1,BANKED
;end if
ENDIF62
;if x_minus.15=0 then
	banksel	X_MINUS_H
	btfsc	X_MINUS_H,7,BANKED
	bra	ELSE63_1
;if y_plus<=y_max then
	movff	Y_PLUS,SysWORDTempB
	movff	Y_PLUS_H,SysWORDTempB_H
	movff	Y_MAX,SysWORDTempA
	movff	Y_MAX_H,SysWORDTempA_H
	banksel	0
	call	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE68_1
;Pset(x_minus,y_plus, LineColour)
	movff	X_MINUS,GLCDX
	movff	X_MINUS_H,GLCDX_H
	movff	Y_PLUS,GLCDY
	movff	Y_PLUS_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;else
	bra	ENDIF68
ELSE68_1
;intersect.2=1
	bsf	INTERSECT,2,BANKED
;end if
ENDIF68
;if y_minus.15=0 then
	banksel	Y_MINUS_H
	btfsc	Y_MINUS_H,7,BANKED
	bra	ELSE69_1
;Pset(x_minus, y_minus, Linecolour)
	movff	X_MINUS,GLCDX
	movff	X_MINUS_H,GLCDX_H
	movff	Y_MINUS,GLCDY
	movff	Y_MINUS_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	banksel	0
	call	PSET_EPD2IN13D
;else
	bra	ENDIF69
ELSE69_1
;intersect.3=1
	banksel	INTERSECT
	bsf	INTERSECT,3,BANKED
;end if
ENDIF69
;else
	bra	ENDIF63
ELSE63_1
;intersect.2=1
	banksel	INTERSECT
	bsf	INTERSECT,2,BANKED
;intersect.3=1
	bsf	INTERSECT,3,BANKED
;end if
ENDIF63
;else '---------------------------------------------------
	bra	ENDIF61
ELSE61_1
;if x_plus<=x_max then
	movff	X_PLUS,SysWORDTempB
	movff	X_PLUS_H,SysWORDTempB_H
	movff	X_MAX,SysWORDTempA
	movff	X_MAX_H,SysWORDTempA_H
	banksel	0
	call	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE64_1
;if y_plus<=y_max then
	movff	Y_PLUS,SysWORDTempB
	movff	Y_PLUS_H,SysWORDTempB_H
	movff	Y_MAX,SysWORDTempA
	movff	Y_MAX_H,SysWORDTempA_H
	call	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE70_1
;Pset(y_plus, x_plus, Linecolour)
	movff	Y_PLUS,GLCDX
	movff	Y_PLUS_H,GLCDX_H
	movff	X_PLUS,GLCDY
	movff	X_PLUS_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;else
	bra	ENDIF70
ELSE70_1
;intersect.0=1
	bsf	INTERSECT,0,BANKED
;end if
ENDIF70
;if y_minus.15=0 then
	banksel	Y_MINUS_H
	btfsc	Y_MINUS_H,7,BANKED
	bra	ELSE71_1
;Pset(y_minus, x_plus, Linecolour)
	movff	Y_MINUS,GLCDX
	movff	Y_MINUS_H,GLCDX_H
	movff	X_PLUS,GLCDY
	movff	X_PLUS_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	banksel	0
	call	PSET_EPD2IN13D
;else
	bra	ENDIF71
ELSE71_1
;intersect.1=1
	banksel	INTERSECT
	bsf	INTERSECT,1,BANKED
;end if
ENDIF71
;else
	bra	ENDIF64
ELSE64_1
;intersect.0=1
	bsf	INTERSECT,0,BANKED
;intersect.1=1
	bsf	INTERSECT,1,BANKED
;end if
ENDIF64
;if x_minus.15=0 then
	banksel	X_MINUS_H
	btfsc	X_MINUS_H,7,BANKED
	bra	ELSE65_1
;if y_plus<=y_max then
	movff	Y_PLUS,SysWORDTempB
	movff	Y_PLUS_H,SysWORDTempB_H
	movff	Y_MAX,SysWORDTempA
	movff	Y_MAX_H,SysWORDTempA_H
	banksel	0
	call	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE72_1
;Pset(y_plus, x_minus, Linecolour)
	movff	Y_PLUS,GLCDX
	movff	Y_PLUS_H,GLCDX_H
	movff	X_MINUS,GLCDY
	movff	X_MINUS_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;else
	bra	ENDIF72
ELSE72_1
;intersect.2=1
	bsf	INTERSECT,2,BANKED
;end if
ENDIF72
;if y_minus.15=0 then
	banksel	Y_MINUS_H
	btfsc	Y_MINUS_H,7,BANKED
	bra	ELSE73_1
;Pset(y_minus, x_minus, Linecolour)
	movff	Y_MINUS,GLCDX
	movff	Y_MINUS_H,GLCDX_H
	movff	X_MINUS,GLCDY
	movff	X_MINUS_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	banksel	0
	call	PSET_EPD2IN13D
;else
	bra	ENDIF73
ELSE73_1
;intersect.3=1
	banksel	INTERSECT
	bsf	INTERSECT,3,BANKED
;end if
ENDIF73
;else
	bra	ENDIF65
ELSE65_1
;intersect.2=1
	banksel	INTERSECT
	bsf	INTERSECT,2,BANKED
;intersect.3=1
	bsf	INTERSECT,3,BANKED
;end if
ENDIF65
;end if
ENDIF61
	return

;********************************************************************************

;Source: glcd.h (3854)
HYPERBOLEPARABOLADIFFVAR
;var2 MUST be >=0
;Dim var1, var2 as Long
;Dim sign as Byte
;if sign=0 then
	movf	SIGN,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE74_1
;if var1 > var2 then
	movff	VAR1,SysLONGTempB
	movff	VAR1_H,SysLONGTempB_H
	movff	VAR1_U,SysLONGTempB_U
	movff	VAR1_E,SysLONGTempB_E
	movff	VAR2,SysLONGTempA
	movff	VAR2_H,SysLONGTempA_H
	movff	VAR2_U,SysLONGTempA_U
	movff	VAR2_E,SysLONGTempA_E
	call	SysCompLessThan32
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE75_1
;var1=var1-var2
	banksel	VAR2
	movf	VAR2,W,BANKED
	subwf	VAR1,F,BANKED
	movf	VAR2_H,W,BANKED
	subwfb	VAR1_H,F,BANKED
	movf	VAR2_U,W,BANKED
	subwfb	VAR1_U,F,BANKED
	movf	VAR2_E,W,BANKED
	subwfb	VAR1_E,F,BANKED
;else
	bra	ENDIF75
ELSE75_1
;var1=var2-var1
	banksel	VAR1
	movf	VAR1,W,BANKED
	subwf	VAR2,W,BANKED
	movwf	VAR1,BANKED
	movf	VAR1_H,W,BANKED
	subwfb	VAR2_H,W,BANKED
	movwf	VAR1_H,BANKED
	movf	VAR1_U,W,BANKED
	subwfb	VAR2_U,W,BANKED
	movwf	VAR1_U,BANKED
	movf	VAR1_E,W,BANKED
	subwfb	VAR2_E,W,BANKED
	movwf	VAR1_E,BANKED
;sign=1
	movlw	1
	banksel	SIGN
	movwf	SIGN,BANKED
;end if
ENDIF75
;else
	bra	ENDIF74
ELSE74_1
;var1=var1+var2
	banksel	VAR2
	movf	VAR2,W,BANKED
	addwf	VAR1,F,BANKED
	movf	VAR2_H,W,BANKED
	addwfc	VAR1_H,F,BANKED
	movf	VAR2_U,W,BANKED
	addwfc	VAR1_U,F,BANKED
	movf	VAR2_E,W,BANKED
	addwfc	VAR1_E,F,BANKED
;end if
ENDIF74
	banksel	0
	return

;********************************************************************************

;Source: glcd.h (3874)
HYPERBOLEPARABOLASUMVAR
;var2 MUST be >=0
;Dim var1, var2 as Long
;Dim sign as Byte
;if sign=0 then
	movf	SIGN,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE76_1
;var1=var1+var2
	banksel	VAR2
	movf	VAR2,W,BANKED
	addwf	VAR1,F,BANKED
	movf	VAR2_H,W,BANKED
	addwfc	VAR1_H,F,BANKED
	movf	VAR2_U,W,BANKED
	addwfc	VAR1_U,F,BANKED
	movf	VAR2_E,W,BANKED
	addwfc	VAR1_E,F,BANKED
;else
	bra	ENDIF76
ELSE76_1
;if var1 < var2 then
	movff	VAR1,SysLONGTempA
	movff	VAR1_H,SysLONGTempA_H
	movff	VAR1_U,SysLONGTempA_U
	movff	VAR1_E,SysLONGTempA_E
	movff	VAR2,SysLONGTempB
	movff	VAR2_H,SysLONGTempB_H
	movff	VAR2_U,SysLONGTempB_U
	movff	VAR2_E,SysLONGTempB_E
	call	SysCompLessThan32
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE77_1
;var1=var2-var1
	banksel	VAR1
	movf	VAR1,W,BANKED
	subwf	VAR2,W,BANKED
	movwf	VAR1,BANKED
	movf	VAR1_H,W,BANKED
	subwfb	VAR2_H,W,BANKED
	movwf	VAR1_H,BANKED
	movf	VAR1_U,W,BANKED
	subwfb	VAR2_U,W,BANKED
	movwf	VAR1_U,BANKED
	movf	VAR1_E,W,BANKED
	subwfb	VAR2_E,W,BANKED
	movwf	VAR1_E,BANKED
;sign=0
	banksel	SIGN
	clrf	SIGN,BANKED
;else
	bra	ENDIF77
ELSE77_1
;var1=var1-var2
	banksel	VAR2
	movf	VAR2,W,BANKED
	subwf	VAR1,F,BANKED
	movf	VAR2_H,W,BANKED
	subwfb	VAR1_H,F,BANKED
	movf	VAR2_U,W,BANKED
	subwfb	VAR1_U,F,BANKED
	movf	VAR2_E,W,BANKED
	subwfb	VAR1_E,F,BANKED
;sign=1
	movlw	1
	banksel	SIGN
	movwf	SIGN,BANKED
;end if
ENDIF77
;end if
ENDIF76
	banksel	0
	return

;********************************************************************************

;Source: E_paper-2in13_PIC_PPS.gcb (24)
INITPPS
;This has been added to turn off PPS SPI when in SPI software mode
;Module: SPI1
;RC3PPS = 0x001E    'SCK1 > RC3
	movlw	30
	banksel	RC3PPS
	movwf	RC3PPS,BANKED
;SPI1SCKPPS = 0x0013    'RC3 > SCK1 (bi-directional)
	movlw	19
	movwf	SPI1SCKPPS,BANKED
;RC5PPS = 0x001F    'SDO1 > RC5
	movlw	31
	movwf	RC5PPS,BANKED
	banksel	0
	return

;********************************************************************************

;Source: random.h (28)
INITRANDOM
;Dim RandomSeed As Word
;RandomSeed = RandStart
	movlw	241
	movwf	RANDOMSEED,BANKED
	movlw	239
	movwf	RANDOMSEED_H,BANKED
	return

;********************************************************************************

;Source: system.h (99)
INITSYS
;Set up internal oscillator
;Handle OSCCON1 register for parts that have this register
;asm showdebug OSCCON type is 100 'This is the routine to support OSCCON1 config addresss
;osccon type is 100
;OSCCON1 = 0x60 ' NOSC HFINTOSC; NDIV 1 - Common as this simply sets the HFINTOSC
	movlw	96
	banksel	OSCCON1
	movwf	OSCCON1,BANKED
;OSCCON3 = 0x00 ' CSWHOLD may proceed; SOSCPWR Low power
	clrf	OSCCON3,BANKED
;OSCEN = 0x00   ' MFOEN disabled; LFOEN disabled; ADOEN disabled; SOSCEN disabled; EXTOEN disabled; HFOEN disabled
	clrf	OSCEN,BANKED
;OSCTUNE = 0x00 ' HFTUN 0
	clrf	OSCTUNE,BANKED
;The MCU is a ChipFamily16
;Section support many MCUs, 18FxxK40, 18FxxK42 etc etc all have NDIV3 bit
;asm showdebug OSCCON type is 101 ' ChipFamily16 and NDIV3 bit
;osccon type is 101
;Clear NDIV3:0
;NDIV3 = 0
	bcf	OSCCON1,NDIV3,BANKED
;NDIV2 = 0
	bcf	OSCCON1,NDIV2,BANKED
;NDIV1 = 0
	bcf	OSCCON1,NDIV1,BANKED
;NDIV0 = 0
	bcf	OSCCON1,NDIV0,BANKED
;OSCFRQ = 0b00001000  '64mhz
	movlw	8
	movwf	OSCFRQ,BANKED
;Clear BSR on ChipFamily16 MCUs
;BSR = 0
	clrf	BSR,ACCESS
;Clear TBLPTRU on MCUs with this bit as this must be zero
;TBLPTRU = 0
	clrf	TBLPTRU,ACCESS
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
	banksel	ADCON0
	bcf	ADCON0,ADFM0,BANKED
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON,BANKED
;Commence clearing any ANSEL variants in the part
;ANSELA = 0
	banksel	ANSELA
	clrf	ANSELA,BANKED
;ANSELB = 0
	clrf	ANSELB,BANKED
;ANSELC = 0
	clrf	ANSELC,BANKED
;ANSELD = 0
	clrf	ANSELD,BANKED
;ANSELE = 0
	clrf	ANSELE,BANKED
;End clearing any ANSEL variants in the part
;Set comparator register bits for many MCUs with register CM2CON0
;C2EN = 0
	banksel	CM2CON0
	bcf	CM2CON0,C2EN,BANKED
;C1EN = 0
	bcf	CM1CON0,C1EN,BANKED
;Turn off all ports
;PORTA = 0
	clrf	PORTA,ACCESS
;PORTB = 0
	clrf	PORTB,ACCESS
;PORTC = 0
	clrf	PORTC,ACCESS
;PORTD = 0
	clrf	PORTD,ACCESS
;PORTE = 0
	clrf	PORTE,ACCESS
	banksel	0
	return

;********************************************************************************

;Source: epd_epd2in13d.h (160)
INIT_EPD2IN13D
;dim _GLCDPagesL, _GLCDPagesH  as byte
;asm showdebug Current_buffer_size_is BUFFWIDTH
;current_buffer_size_is 106
;Dir   EPD_DC     OUT
	bcf	TRISB,7,ACCESS
;Dir   EPD_CS     OUT
	bcf	TRISC,1,ACCESS
;Dir   EPD_RESET  OUT
	bcf	TRISD,2,ACCESS
;Dir   EPD_DO     OUT
	bcf	TRISC,5,ACCESS
;Dir   EPD_SCK    OUT
	bcf	TRISC,3,ACCESS
;Dir   EPD_Busy   IN
	bsf	TRISC,0,ACCESS
;SET EPD_RESET ON
	bsf	LATD,2,ACCESS
;wait 200 ms
	movlw	200
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;SET EPD_RESET OFF
	bcf	LATD,2,ACCESS
;wait 20 ms
	movlw	20
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;SET EPD_RESET ON
	bsf	LATD,2,ACCESS
;wait 200 ms
	movlw	200
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;harware SPI mode
;asm showdebug SPI constant used equates to HWSPIMODESCRIPT
;spi constant used equates to 12
;SPIMode HWSPIMODESCRIPT, 0
	movlw	12
	movwf	SPICURRENTMODE,BANKED
	clrf	SPICLOCKMODE,BANKED
	call	SPIMODE644
;SendCommand_EPD2in13D(BOOSTER_SOFT_START)
	movlw	6
	movwf	EPD2IN13D_COMMAND,ACCESS
	call	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0x17)
	movlw	23
	movwf	EPD2IN13D_DATA,ACCESS
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x17)
	movlw	23
	movwf	EPD2IN13D_DATA,ACCESS
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x17)
	movlw	23
	movwf	EPD2IN13D_DATA,ACCESS
	call	SENDDATA_EPD2IN13D
;wait 200 ms
	movlw	200
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;SendCommand_EPD2in13D(POWER_SETTING)
	movlw	1
	movwf	EPD2IN13D_COMMAND,ACCESS
	call	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0x03)
	movlw	3
	movwf	EPD2IN13D_DATA,ACCESS
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x00)
	clrf	EPD2IN13D_DATA,ACCESS
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x2B)
	movlw	43
	movwf	EPD2IN13D_DATA,ACCESS
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x2B)
	movlw	43
	movwf	EPD2IN13D_DATA,ACCESS
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x03)
	movlw	3
	movwf	EPD2IN13D_DATA,ACCESS
	call	SENDDATA_EPD2IN13D
;wait 200 ms
	movlw	200
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;SendCommand_EPD2in13D(POWER_ON)
	movlw	4
	movwf	EPD2IN13D_COMMAND,ACCESS
	call	SENDCOMMAND_EPD2IN13D
;SendCommand_EPD2in13D(PANEL_SETTING)
	clrf	EPD2IN13D_COMMAND,ACCESS
	call	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(PANEL_SETTING_VALUE or PANEL_SETTING_KWR )
	movlw	191
	movwf	EPD2IN13D_DATA,ACCESS
	call	SENDDATA_EPD2IN13D
;SendCommand_EPD2in13D(PLL_CONTROL)
	movlw	48
	movwf	EPD2IN13D_COMMAND,ACCESS
	call	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0x3C)
	movlw	60
	movwf	EPD2IN13D_DATA,ACCESS
	call	SENDDATA_EPD2IN13D
;SendCommand_EPD2in13D(RESOLUTION_SETTING)
	movlw	97
	movwf	EPD2IN13D_COMMAND,ACCESS
	call	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0x68)
	movlw	104
	movwf	EPD2IN13D_DATA,ACCESS
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x00)
	clrf	EPD2IN13D_DATA,ACCESS
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0xD4)
	movlw	212
	movwf	EPD2IN13D_DATA,ACCESS
	call	SENDDATA_EPD2IN13D
;SendCommand_EPD2in13D(VCM_DC_SETTING)
	movlw	130
	movwf	EPD2IN13D_COMMAND,ACCESS
	call	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0x12)
	movlw	18
	movwf	EPD2IN13D_DATA,ACCESS
	call	SENDDATA_EPD2IN13D
;LoadLUTS_EPD2in13D
	rcall	LOADLUTS_EPD2IN13D
;Colours
;GLCDForeground =TFT_WHITE
	setf	GLCDFOREGROUND,BANKED
	setf	GLCDFOREGROUND_H,BANKED
;Default Colours
;GLCDBackground = TFT_BLACK
	clrf	GLCDBACKGROUND,BANKED
	clrf	GLCDBACKGROUND_H,BANKED
;GLCDFontWidth = 5
	movlw	5
	movwf	GLCDFONTWIDTH,BANKED
;Variables required for device
;GLCDDeviceWidth = GLCD_WIDTH - 1
	movlw	103
	movwf	GLCDDEVICEWIDTH,BANKED
	clrf	GLCDDEVICEWIDTH_H,BANKED
;GLCDDeviceHeight= GLCD_HEIGHT- 1
	movlw	211
	movwf	GLCDDEVICEHEIGHT,BANKED
	clrf	GLCDDEVICEHEIGHT_H,BANKED
;GLCDRotate Portrait
	movlw	4
	movwf	EPD2IN13DADDRESSTYPE,ACCESS
	call	ROTATE_EPD2IN13D
;GLCDfntDefault = 0
	clrf	GLCDFNTDEFAULT,BANKED
;GLCDfntDefaultsize = 1
	movlw	1
	movwf	GLCDFNTDEFAULTSIZE,BANKED
;GLCDfntDefaultHeight = 8
	movlw	8
	movwf	GLCDFNTDEFAULTHEIGHT,BANKED
;CLS_EPD2in13D_init
	call	CLS_EPD2IN13D_INIT
;_GLCDPagesH = EPD_N_PAGE - 1
	movlw	25
	banksel	_GLCDPAGESH
	movwf	_GLCDPAGESH,BANKED
;_GLCDPagesL = 0
	clrf	_GLCDPAGESL,BANKED
	banksel	0
	return

;********************************************************************************

;Source: string.h (641)
FN_LEFTPAD
;check input length
;return if too short or equal SysStrLen
;If SysStrLen > SysInString(0) Then
	movffl	SysSYSINSTRINGHandler,AFSR0
	movffl	SysSYSINSTRINGHandler_H,AFSR0_H
	banksel	SYSSTRLEN
	movf	SYSSTRLEN,W,BANKED
	subwf	INDF0,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	ELSE139_1
;LeftPad = ""
	lfsr	1,LEFTPAD
	movlw	low StringTable17
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable17
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
;LeftPad(0) = SysStrLen       'set string to new length
	movffl	SYSSTRLEN,SYSLEFTPAD_0
;SysCharCount = SysStrLen - SysInString(0) 'diff-length To incoming string
	movffl	SysSYSINSTRINGHandler,AFSR0
	movffl	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	INDF0,W,ACCESS
	banksel	SYSSTRLEN
	subwf	SYSSTRLEN,W,BANKED
	movwf	SYSCHARCOUNT,BANKED
;add sysInString2 to new String
;for SysStringTemp = 1 to SysCharCount
	clrf	SYSSTRINGTEMP,BANKED
	movlw	1
	subwf	SYSCHARCOUNT,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd29
SysForLoop29
	incf	SYSSTRINGTEMP,F,BANKED
;LeftPad(sysStringTemp) = SysInString2(1)
	movlw	1
	addwf	SysSYSINSTRING2Handler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysSYSINSTRING2Handler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movffl	POSTINC0,SysArrayTemp1
	movff	SysArrayTemp1,SysArrayTemp2
	lfsr	0,LEFTPAD
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movffl	SysArrayTemp2,POSTINC0
;Next
	movf	SYSCHARCOUNT,W,BANKED
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop29
SysForLoopEnd29
;add old content to new string
;For SysStringTemp = 1 To sysInString(0)
	clrf	SYSSTRINGTEMP,BANKED
	movffl	SysSYSINSTRINGHandler,AFSR0
	movffl	SysSYSINSTRINGHandler_H,AFSR0_H
	movlw	1
	subwf	INDF0,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd30
SysForLoop30
	incf	SYSSTRINGTEMP,F,BANKED
;LeftPad(sysCharCount + sysStringTemp) = SysInString(SysStringTemp)
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	SysSYSINSTRINGHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysSYSINSTRINGHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movffl	POSTINC0,SysArrayTemp1
	movff	SysArrayTemp1,SysArrayTemp2
	lfsr	0,LEFTPAD
	movf	SYSCHARCOUNT,W,BANKED
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp2,BANKED
	movlw	0
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp2_H,BANKED
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	SysTemp2,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movffl	SysArrayTemp2,POSTINC0
;Next
	movffl	SysSYSINSTRINGHandler,AFSR0
	movffl	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	INDF0,W,ACCESS
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop30
SysForLoopEnd30
;Else
	bra	ENDIF139
ELSE139_1
;LeftPad = SysInString
	lfsr	1,LEFTPAD
	movffl	SysSYSINSTRINGHandler,FSR0L
	movffl	SysSYSINSTRINGHandler_H,FSR0H
	banksel	0
	call	SysCopyString
;end if
ENDIF139
	banksel	0
	return

;********************************************************************************

;Source: glcd.h (1478)
LINE
;dim LineStepX as integer
;dim LineStepY as integer
;dim LineDiffX, LineDiffY as integer
;dim LineDiffX_x2, LineDiffY_x2 as integer
;dim LineErr as integer
;LineDiffX = 0
	clrf	LINEDIFFX,BANKED
	clrf	LINEDIFFX_H,BANKED
;LineDiffY = 0
	clrf	LINEDIFFY,BANKED
	clrf	LINEDIFFY_H,BANKED
;LineStepX = 0
	clrf	LINESTEPX,BANKED
	clrf	LINESTEPX_H,BANKED
;LineStepY = 0
	clrf	LINESTEPY,BANKED
	clrf	LINESTEPY_H,BANKED
;LineDiffX_x2 = 0
	clrf	LINEDIFFX_X2,BANKED
	clrf	LINEDIFFX_X2_H,BANKED
;LineDiffY_x2 = 0
	clrf	LINEDIFFY_X2,BANKED
	clrf	LINEDIFFY_X2_H,BANKED
;LineErr = 0
	clrf	LINEERR,BANKED
	clrf	LINEERR_H,BANKED
;LineDiffX =  LineX2 -   LineX1
	movf	LINEX1,W,BANKED
	subwf	LINEX2,W,BANKED
	movwf	LINEDIFFX,BANKED
	movf	LINEX1_H,W,BANKED
	subwfb	LINEX2_H,W,BANKED
	movwf	LINEDIFFX_H,BANKED
;LineDiffY =  LineY2 -   LineY1
	movf	LINEY1,W,BANKED
	subwf	LINEY2,W,BANKED
	movwf	LINEDIFFY,BANKED
	movf	LINEY1_H,W,BANKED
	subwfb	LINEY2_H,W,BANKED
	movwf	LINEDIFFY_H,BANKED
;if (LineDiffX > 0) then
	movff	LINEDIFFX,SysINTEGERTempB
	movff	LINEDIFFX_H,SysINTEGERTempB_H
	clrf	SysINTEGERTempA,ACCESS
	clrf	SysINTEGERTempA_H,ACCESS
	call	SysCompLessThanINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE33_1
;LineStepX = 1
	movlw	1
	movwf	LINESTEPX,BANKED
	clrf	LINESTEPX_H,BANKED
;else
	bra	ENDIF33
ELSE33_1
;LineStepX = -1
	setf	LINESTEPX,BANKED
	setf	LINESTEPX_H,BANKED
;end if
ENDIF33
;if (LineDiffY > 0) then
	movff	LINEDIFFY,SysINTEGERTempB
	movff	LINEDIFFY_H,SysINTEGERTempB_H
	clrf	SysINTEGERTempA,ACCESS
	clrf	SysINTEGERTempA_H,ACCESS
	call	SysCompLessThanINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE34_1
;LineStepY = 1
	movlw	1
	movwf	LINESTEPY,BANKED
	clrf	LINESTEPY_H,BANKED
;else
	bra	ENDIF34
ELSE34_1
;LineStepY = -1
	setf	LINESTEPY,BANKED
	setf	LINESTEPY_H,BANKED
;end if
ENDIF34
;LineDiffX = LineStepX * LineDiffX
	movff	LINESTEPX,SysINTEGERTempA
	movff	LINESTEPX_H,SysINTEGERTempA_H
	movff	LINEDIFFX,SysINTEGERTempB
	movff	LINEDIFFX_H,SysINTEGERTempB_H
	call	SysMultSubINT
	movff	SysINTEGERTempX,LINEDIFFX
	movff	SysINTEGERTempX_H,LINEDIFFX_H
;LineDiffY = LineStepY * LineDiffY
	movff	LINESTEPY,SysINTEGERTempA
	movff	LINESTEPY_H,SysINTEGERTempA_H
	movff	LINEDIFFY,SysINTEGERTempB
	movff	LINEDIFFY_H,SysINTEGERTempB_H
	call	SysMultSubINT
	movff	SysINTEGERTempX,LINEDIFFY
	movff	SysINTEGERTempX_H,LINEDIFFY_H
;LineDiffX_x2 = LineDiffX*2
	movff	LINEDIFFX,SysINTEGERTempA
	movff	LINEDIFFX_H,SysINTEGERTempA_H
	movlw	2
	movwf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SysMultSubINT
	movff	SysINTEGERTempX,LINEDIFFX_X2
	movff	SysINTEGERTempX_H,LINEDIFFX_X2_H
;LineDiffY_x2 = LineDiffY*2
	movff	LINEDIFFY,SysINTEGERTempA
	movff	LINEDIFFY_H,SysINTEGERTempA_H
	movlw	2
	movwf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SysMultSubINT
	movff	SysINTEGERTempX,LINEDIFFY_X2
	movff	SysINTEGERTempX_H,LINEDIFFY_X2_H
;if ( LineDiffX >= LineDiffY) then
	movff	LINEDIFFX,SysINTEGERTempA
	movff	LINEDIFFX_H,SysINTEGERTempA_H
	movff	LINEDIFFY,SysINTEGERTempB
	movff	LINEDIFFY_H,SysINTEGERTempB_H
	call	SysCompLessThanINT
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE35_1
;LineErr = LineDiffY_x2 - LineDiffX
	movf	LINEDIFFX,W,BANKED
	subwf	LINEDIFFY_X2,W,BANKED
	movwf	LINEERR,BANKED
	movf	LINEDIFFX_H,W,BANKED
	subwfb	LINEDIFFY_X2_H,W,BANKED
	movwf	LINEERR_H,BANKED
;do while (   LineX1 <>  LineX2 )
SysDoLoop_S2
	movff	linex1,SysWORDTempA
	movff	linex1_H,SysWORDTempA_H
	movff	linex2,SysWORDTempB
	movff	linex2_H,SysWORDTempB_H
	call	SysCompEqual16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	SysDoLoop_E2
;PSet (   LineX1,   LineY1, LineColour )
	movff	LINEX1,GLCDX
	movff	LINEX1_H,GLCDX_H
	movff	LINEY1,GLCDY
	movff	LINEY1_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;LineX1 += LineStepX
	movf	LINESTEPX,W,BANKED
	addwf	LINEX1,F,BANKED
	movf	LINESTEPX_H,W,BANKED
	addwfc	LINEX1_H,F,BANKED
;if ( LineErr < 0) then
	movff	LINEERR,SysINTEGERTempA
	movff	LINEERR_H,SysINTEGERTempA_H
	clrf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SysCompLessThanINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE36_1
;LineErr += LineDiffY_x2
	movf	LINEDIFFY_X2,W,BANKED
	addwf	LINEERR,F,BANKED
	movf	LINEDIFFY_X2_H,W,BANKED
	addwfc	LINEERR_H,F,BANKED
;else
	bra	ENDIF36
ELSE36_1
;LineErr += ( LineDiffY_x2 - LineDiffX_x2 )
	movf	LINEDIFFX_X2,W,BANKED
	subwf	LINEDIFFY_X2,W,BANKED
	banksel	SYSTEMP1
	movwf	SysTemp1,BANKED
	banksel	LINEDIFFX_X2_H
	movf	LINEDIFFX_X2_H,W,BANKED
	subwfb	LINEDIFFY_X2_H,W,BANKED
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H,BANKED
	movf	SysTemp1,W,BANKED
	banksel	LINEERR
	addwf	LINEERR,F,BANKED
	banksel	SYSTEMP1_H
	movf	SysTemp1_H,W,BANKED
	banksel	LINEERR_H
	addwfc	LINEERR_H,F,BANKED
;LineY1 += LineStepY
	movf	LINESTEPY,W,BANKED
	addwf	LINEY1,F,BANKED
	movf	LINESTEPY_H,W,BANKED
	addwfc	LINEY1_H,F,BANKED
;end if
ENDIF36
;loop
	bra	SysDoLoop_S2
SysDoLoop_E2
;PSet (   LineX1,   LineY1, LineColour )
	movff	LINEX1,GLCDX
	movff	LINEX1_H,GLCDX_H
	movff	LINEY1,GLCDY
	movff	LINEY1_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;else
	bra	ENDIF35
ELSE35_1
;LineErr = LineDiffX_x2 - LineDiffY
	movf	LINEDIFFY,W,BANKED
	subwf	LINEDIFFX_X2,W,BANKED
	movwf	LINEERR,BANKED
	movf	LINEDIFFY_H,W,BANKED
	subwfb	LINEDIFFX_X2_H,W,BANKED
	movwf	LINEERR_H,BANKED
;do while (   LineY1 <>  LineY2)
SysDoLoop_S3
	movff	liney1,SysWORDTempA
	movff	liney1_H,SysWORDTempA_H
	movff	liney2,SysWORDTempB
	movff	liney2_H,SysWORDTempB_H
	call	SysCompEqual16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	SysDoLoop_E3
;PSet (   LineX1,   LineY1, LineColour )
	movff	LINEX1,GLCDX
	movff	LINEX1_H,GLCDX_H
	movff	LINEY1,GLCDY
	movff	LINEY1_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;LineY1 += LineStepY
	movf	LINESTEPY,W,BANKED
	addwf	LINEY1,F,BANKED
	movf	LINESTEPY_H,W,BANKED
	addwfc	LINEY1_H,F,BANKED
;if ( LineErr < 0) then
	movff	LINEERR,SysINTEGERTempA
	movff	LINEERR_H,SysINTEGERTempA_H
	clrf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	call	SysCompLessThanINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE37_1
;LineErr += LineDiffX_x2
	movf	LINEDIFFX_X2,W,BANKED
	addwf	LINEERR,F,BANKED
	movf	LINEDIFFX_X2_H,W,BANKED
	addwfc	LINEERR_H,F,BANKED
;else
	bra	ENDIF37
ELSE37_1
;LineErr += ( LineDiffX_x2 - LineDiffY_x2 )
	movf	LINEDIFFY_X2,W,BANKED
	subwf	LINEDIFFX_X2,W,BANKED
	banksel	SYSTEMP1
	movwf	SysTemp1,BANKED
	banksel	LINEDIFFY_X2_H
	movf	LINEDIFFY_X2_H,W,BANKED
	subwfb	LINEDIFFX_X2_H,W,BANKED
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H,BANKED
	movf	SysTemp1,W,BANKED
	banksel	LINEERR
	addwf	LINEERR,F,BANKED
	banksel	SYSTEMP1_H
	movf	SysTemp1_H,W,BANKED
	banksel	LINEERR_H
	addwfc	LINEERR_H,F,BANKED
;LineX1 += LineStepX
	movf	LINESTEPX,W,BANKED
	addwf	LINEX1,F,BANKED
	movf	LINESTEPX_H,W,BANKED
	addwfc	LINEX1_H,F,BANKED
;end if
ENDIF37
;loop
	bra	SysDoLoop_S3
SysDoLoop_E3
;PSet (   LineX1,   LineY1, LineColour )
	movff	LINEX1,GLCDX
	movff	LINEX1_H,GLCDX_H
	movff	LINEY1,GLCDY
	movff	LINEY1_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;end if
ENDIF35
	return

;********************************************************************************

;Source: epd_epd2in13d.h (255)
LOADLUTS_EPD2IN13D
;Dim DataVar as byte
;Dim Counter as Word
;SendCommand_EPD2in13D(VCM_DC_SETTING)
	movlw	130
	movwf	EPD2IN13D_COMMAND,ACCESS
	call	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0x00)
	clrf	EPD2IN13D_DATA,ACCESS
	call	SENDDATA_EPD2IN13D
;SendCommand_EPD2in13D(VCOM_AND_DATA_INTERVAL_SETTING)
	movlw	80
	movwf	EPD2IN13D_COMMAND,ACCESS
	call	SENDCOMMAND_EPD2IN13D
;Mask VCOM_AND_DATA_INTERVAL bits and then Mask the user bits.
;SendData_EPD2in13D( (0x90 AND 0xF0 ) or ( VCOM_AND_DATA_INTERVAL AND 0X0F ))
	movlw	151
	movwf	EPD2IN13D_DATA,ACCESS
	call	SENDDATA_EPD2IN13D
;SendCommand_EPD2in13D(0x20) 'VCOM LUT
	movlw	32
	movwf	EPD2IN13D_COMMAND,ACCESS
	call	SENDCOMMAND_EPD2IN13D
;for EPD_Counter=1 to 44
	clrf	EPD_COUNTER,ACCESS
SysForLoop31
	incf	EPD_COUNTER,F,ACCESS
;ReadTable Lut_Vcom, EPD_Counter, DataVar
	movff	EPD_COUNTER,SYSSTRINGA
	rcall	LUT_VCOM
	movwf	DATAVAR,ACCESS
;SendData_EPD2in13D(DataVar)
	movff	DATAVAR,EPD2IN13D_DATA
	call	SENDDATA_EPD2IN13D
;next
	movlw	44
	subwf	EPD_COUNTER,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop31
SysForLoopEnd31
;SendCommand_EPD2in13D(0x21) 'WW LUT
	movlw	33
	movwf	EPD2IN13D_COMMAND,ACCESS
	call	SENDCOMMAND_EPD2IN13D
;for EPD_Counter=1 to 42
	clrf	EPD_COUNTER,ACCESS
SysForLoop32
	incf	EPD_COUNTER,F,ACCESS
;ReadTable Lut_WW, EPD_Counter, DataVar
	movff	EPD_COUNTER,SYSSTRINGA
	rcall	LUT_WW
	movwf	DATAVAR,ACCESS
;SendData_EPD2in13D(DataVar)
	movff	DATAVAR,EPD2IN13D_DATA
	call	SENDDATA_EPD2IN13D
;next
	movlw	42
	subwf	EPD_COUNTER,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop32
SysForLoopEnd32
;SendCommand_EPD2in13D(0x22) 'BW LUT
	movlw	34
	movwf	EPD2IN13D_COMMAND,ACCESS
	call	SENDCOMMAND_EPD2IN13D
;for EPD_Counter=1 to 42
	clrf	EPD_COUNTER,ACCESS
SysForLoop33
	incf	EPD_COUNTER,F,ACCESS
;ReadTable Lut_BW, EPD_Counter, DataVar
	movff	EPD_COUNTER,SYSSTRINGA
	rcall	LUT_BW
	movwf	DATAVAR,ACCESS
;SendData_EPD2in13D(DataVar)
	movff	DATAVAR,EPD2IN13D_DATA
	call	SENDDATA_EPD2IN13D
;next
	movlw	42
	subwf	EPD_COUNTER,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop33
SysForLoopEnd33
;SendCommand_EPD2in13D(0x23) 'WB LUT
	movlw	35
	movwf	EPD2IN13D_COMMAND,ACCESS
	call	SENDCOMMAND_EPD2IN13D
;for EPD_Counter=1 to 42
	clrf	EPD_COUNTER,ACCESS
SysForLoop34
	incf	EPD_COUNTER,F,ACCESS
;ReadTable Lut_WB, EPD_Counter, DataVar
	movff	EPD_COUNTER,SYSSTRINGA
	rcall	LUT_WB
	movwf	DATAVAR,ACCESS
;SendData_EPD2in13D(DataVar)
	movff	DATAVAR,EPD2IN13D_DATA
	call	SENDDATA_EPD2IN13D
;next
	movlw	42
	subwf	EPD_COUNTER,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop34
SysForLoopEnd34
;SendCommand_EPD2in13D(0x24) 'BB LUT
	movlw	36
	movwf	EPD2IN13D_COMMAND,ACCESS
	call	SENDCOMMAND_EPD2IN13D
;for EPD_Counter=1 to 42
	clrf	EPD_COUNTER,ACCESS
SysForLoop35
	incf	EPD_COUNTER,F,ACCESS
;ReadTable Lut_BB, EPD_Counter, DataVar
	movff	EPD_COUNTER,SYSSTRINGA
	rcall	LUT_BB
	movwf	DATAVAR,ACCESS
;SendData_EPD2in13D(DataVar)
	movff	DATAVAR,EPD2IN13D_DATA
	call	SENDDATA_EPD2IN13D
;next
	movlw	42
	subwf	EPD_COUNTER,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop35
SysForLoopEnd35
	return

;********************************************************************************

LUT_BB
	movlw	25
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableLUT_BB
	movwf	TBLPTRL,ACCESS
	movlw	high TableLUT_BB
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableLUT_BB
	db	42,128,8,0,0,0,2,144,40,40,0,0,1,128,20,0,0,0,1,80,18,18,0,0,1

;********************************************************************************

LUT_BW
	movlw	25
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableLUT_BW
	movwf	TBLPTRL,ACCESS
	movlw	high TableLUT_BW
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableLUT_BW
	db	42,64,23,0,0,0,2,144,15,15,0,0,3,64,10,1,0,0,1,160,14,14,0,0,2

;********************************************************************************

LUT_VCOM
	movlw	25
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableLUT_VCOM
	movwf	TBLPTRL,ACCESS
	movlw	high TableLUT_VCOM
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableLUT_VCOM
	db	44,0,8,0,0,0,2,96,40,40,0,0,1,0,20,0,0,0,1,0,18,18,0,0,1

;********************************************************************************

LUT_WB
	movlw	25
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableLUT_WB
	movwf	TBLPTRL,ACCESS
	movlw	high TableLUT_WB
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableLUT_WB
	db	42,128,8,0,0,0,2,144,40,40,0,0,1,128,20,0,0,0,1,80,18,18,0,0,1

;********************************************************************************

LUT_WW
	movlw	25
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableLUT_WW
	movwf	TBLPTRL,ACCESS
	movlw	high TableLUT_WW
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableLUT_WW
	db	42,64,8,0,0,0,2,144,40,40,0,0,1,64,20,0,0,0,1,160,18,18,0,0,1

;********************************************************************************

OLEDFONT1DATA
	movff	SYSSTRINGA,SysWORDTempA
	movff	SYSSTRINGA_H,SysWORDTempA_H
	movlw	165
	movwf	SysWORDTempB,ACCESS
	movlw	1
	movwf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableOLEDFONT1DATA
	movwf	TBLPTRL,ACCESS
	movlw	high TableOLEDFONT1DATA
	addwfc	SysStringA_H, W,ACCESS
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableOLEDFONT1DATA
	db	165,1,0,1,94,3,6,0,6,5,40,124,40,124,40,5,36,42,127,42,16,3,98,24,70,5,48,76,90,36
	db	80,1,6,2,60,66,2,66,60,5,40,16,124,16,40,3,16,56,16,1,192,3,16,16,16,1,64,3,96,24
	db	6,4,60,66,66,60,3,68,126,64,4,68,98,82,76,3,74,74,52,4,30,16,124,16,3,78,74,50
	db	4,60,74,74,48,3,98,18,14,4,52,74,74,52,4,12,82,82,60,1,72,2,128,104,3,16,40,68
	db	3,40,40,40,3,68,40,16,3,2,82,12,5,56,68,84,84,88,4,124,18,18,124,4,126,74,74,52
	db	4,60,66,66,36,4,126,66,66,60,3,126,74,74,3,126,10,10,4,60,66,82,52,4,126,8,8,126
	db	3,66,126,66,3,66,66,62,4,126,8,20,98,3,126,64,64,5,126,4,8,4,126,5,126,4,24,32
	db	126,4,60,66,66,60,4,126,18,18,12,4,60,66,66,188,4,126,18,18,108,4,68,74,74,48,3,2
	db	126,2,4,62,64,64,62,5,6,24,96,24,6,5,62,64,62,64,62,5,66,36,24,36,66,4,158,160
	db	160,126,4,98,82,74,70,2,126,66,3,6,24,96,2,66,126,3,32,16,32,4,128,128,128,128
	db	2,4,8,4,32,84,84,120,4,126,68,68,56,4,56,68,68,40,4,56,68,68,126,4,56,84,84,88
	db	2,124,10,4,152,164,164,124,4,126,4,4,120,1,122,2,64,58,4,126,16,40,68,1,126,5
	db	124,4,120,4,120,4,124,4,4,120,4,56,68,68,56,4,252,36,36,24,4,24,36,36,252,2,124,4
	db	4,72,84,84,32,3,4,62,68,4,60,64,64,60,5,12,48,64,48,12,5,60,64,60,64,60,5,68,40,16
	db	40,68,4,156,160,160,124,3,100,84,76,3,8,54,65,1,255,3,65,54,8,4,32,16,32,16,1

;********************************************************************************

OLEDFONT1DATA_H
	movff	SYSSTRINGA,SysWORDTempA
	movff	SYSSTRINGA_H,SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableOLEDFONT1DATA_H
	movwf	TBLPTRL,ACCESS
	movlw	high TableOLEDFONT1DATA_H
	addwfc	SysStringA_H, W,ACCESS
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableOLEDFONT1DATA_H
	db	1

;********************************************************************************

OLEDFONT1INDEX
	movlw	97
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableOLEDFONT1INDEX
	movwf	TBLPTRL,ACCESS
	movlw	high TableOLEDFONT1INDEX
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableOLEDFONT1INDEX
	db	96,1,3,5,9,15,21,25,31,33,36,39,45,49,51,55,57,61,66,70,75,79,84,88,93,97,102,107
	db	109,112,116,120,124,128,134,139,144,149,154,158,162,167,172,176,180,185,189,195
	db	201,206,211,216,221,226,230,235,241,247,253,2,7,10,14,17,21,26,29,34,39,44,49,54
	db	57,62,67,69,72,77,79,85,90,95,100,105,108,113,117,122,128,134,140,145,149,153
	db	155,159,164

;********************************************************************************

OLEDFONT1INDEX_H
	movlw	97
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableOLEDFONT1INDEX_H
	movwf	TBLPTRL,ACCESS
	movlw	high TableOLEDFONT1INDEX_H
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableOLEDFONT1INDEX_H
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	db	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

;********************************************************************************

OLEDFONT2
	movff	SYSSTRINGA,SysWORDTempA
	movff	SYSSTRINGA_H,SysWORDTempA_H
	movlw	145
	movwf	SysWORDTempB,ACCESS
	movlw	7
	movwf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableOLEDFONT2
	movwf	TBLPTRL,ACCESS
	movlw	high TableOLEDFONT2
	addwfc	SysStringA_H, W,ACCESS
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableOLEDFONT2
	db	147,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,254,27,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,30,0,0,0,0,0,0,0,30,0,0,0,0,0,0,0,0,1,32,25,160,7,120,1,38,25,160
	db	7,120,1,38,1,32,1,0,0,0,0,0,0,28,24,38,16,66,16,255,63,130,17,2,15,0,0,0,0,28
	db	16,34,8,34,4,34,3,156,0,64,14,48,17,8,17,4,17,2,14,0,7,128,8,92,16,98,16,162,17,50
	db	19,28,28,0,24,0,22,128,1,0,0,0,0,0,0,0,0,30,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,224
	db	7,24,24,12,48,4,32,2,64,2,64,0,0,0,0,2,64,2,64,4,32,12,48,24,24,224,7,0,0,0,0,0
	db	0,0,0,8,0,24,0,240,0,78,0,240,0,24,0,8,0,0,0,0,0,0,2,0,2,0,2,0,2,224,31,0,2,0,2,0
	db	2,0,2,0,0,0,0,0,0,0,0,0,152,0,120,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,1,0,1,0
	db	1,0,1,0,0,0,0,0,0,0,0,0,0,0,24,0,24,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,48,0,12,0,3,192
	db	0,48,0,12,0,2,0,0,0,0,0,240,3,12,12,2,16,2,16,2,16,12,12,240,3,0,0,0,0,0,0,4,16,4
	db	16,4,16,254,31,0,16,0,16,0,16,0,0,0,0,0,0,6,24,2,20,2,18,2,17,194,16,60,16,0,0,0
	db	0,0,0,0,0,0,0,2,16,66,16,66,16,66,16,188,15,0,0,0,0,0,0,0,3,192,2,32,2,24,2,4,2,254
	db	31,0,2,0,2,0,0,0,0,0,0,0,0,62,16,34,16,34,16,66,8,130,7,0,0,0,0,0,0,0,0,240,7,76
	db	8,34,16,34,16,34,16,66,8,128,7,0,0,0,0,0,0,2,0,2,24,2,7,194,0,50,0,10,0,6,0,0,0,0
	db	0,0,0,28,15,162,16,66,16,66,16,162,16,162,9,28,6,0,0,0,0,0,0,120,0,132,16,2,17,2
	db	17,2,17,132,12,248,3,0,0,0,0,0,0,0,0,0,0,96,24,96,24,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,96,152,96,120,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,3,128,4,128,4,64,8,64,8,32
	db	16,0,0,0,0,128,4,128,4,128,4,128,4,128,4,128,4,128,4,128,4,0,0,0,0,32,16,64,8,64
	db	8,128,4,128,4,0,3,0,3,0,0,0,0,0,0,14,0,2,0,2,27,130,0,66,0,38,0,28,0,0,0,0,0,240
	db	3,24,12,4,24,226,19,18,20,10,22,138,27,252,7,0,4,0,4,0,16,0,14,128,3,112,2,24,2,48
	db	2,192,2,0,3,0,12,0,16,0,0,248,31,136,16,136,16,136,16,136,16,72,17,48,14,0,0,0
	db	0,192,3,48,12,16,8,8,16,8,16,8,16,8,16,24,16,0,0,0,0,0,0,248,31,8,16,8,16,8,16,8
	db	16,16,8,224,7,0,0,0,0,0,0,248,31,8,17,8,17,8,17,8,17,8,17,8,16,0,0,0,0,0,0,248
	db	31,8,1,8,1,8,1,8,1,8,1,8,0,0,0,0,0,0,0,192,3,48,12,16,8,8,16,8,16,8,17,8,17,24
	db	31,0,0,0,0,248,31,0,1,0,1,0,1,0,1,0,1,248,31,0,0,0,0,0,0,8,16,8,16,8,16,248,31,8
	db	16,8,16,8,16,0,0,0,0,0,0,0,0,0,16,8,16,8,16,8,16,248,15,0,0,0,0,0,0,0,0,248,31,128
	db	0,128,1,64,2,32,4,16,4,8,8,0,16,0,0,0,0,248,31,0,16,0,16,0,16,0,16,0,16,0,16,0
	db	0,0,0,248,31,56,0,224,1,0,7,0,6,192,1,56,0,248,31,0,0,0,0,0,0,248,31,16,0,96,0,128
	db	1,0,6,0,8,248,31,0,0,0,0,0,0,224,7,16,8,8,16,8,16,8,16,8,16,16,8,224,7,0,0,0,0,248
	db	31,8,1,8,1,8,1,8,1,136,0,112,0,0,0,0,0,0,0,224,7,16,8,8,16,8,16,8,16,8,48,16,72,224
	db	71,0,0,0,0,248,31,8,1,8,1,8,3,136,4,112,8,0,16,0,0,0,0,0,0,112,24,72,16,136,16,136
	db	16,8,17,8,9,24,14,0,0,0,0,8,0,8,0,8,0,8,0,248,31,8,0,8,0,8,0,8,0,0,0,0,0,248,7,0
	db	24,0,16,0,16,0,16,0,8,248,7,0,0,0,0,8,0,48,0,192,1,0,6,0,24,0,24,0,7,192,0,48,0,8
	db	0,24,0,224,3,0,28,0,15,224,0,192,1,0,14,0,28,224,3,24,0,8,16,16,8,32,4,64,2,128
	db	1,128,1,64,2,32,4,16,8,8,16,8,0,16,0,96,0,128,0,0,31,128,0,64,0,32,0,16,0,8,0,0
	db	0,8,24,8,20,8,18,8,17,136,16,72,16,40,16,24,16,0,0,0,0,0,0,0,0,254,127,2,64,2
	db	64,2,64,2,64,0,0,0,0,0,0,2,0,12,0,48,0,192,0,0,3,0,12,0,48,0,64,0,0,0,0,2,64,2
	db	64,2,64,2,64,254,127,0,0,0,0,0,0,0,0,0,0,0,4,0,3,224,0,56,0,14,0,112,0,128,3,0
	db	4,0,0,0,32,0,32,0,32,0,32,0,32,0,32,0,32,0,32,0,32,0,32,0,0,0,0,0,0,0,0,1,0,2,0,0
	db	0,0,0,0,0,0,0,0,0,0,12,32,18,32,17,32,17,32,9,192,31,0,16,0,0,0,0,0,0,254,31,64
	db	8,32,16,32,16,32,16,96,8,128,7,0,0,0,0,0,0,128,7,64,8,32,16,32,16,32,16,32,16,32
	db	16,0,0,0,0,0,0,128,7,64,24,32,16,32,16,32,16,64,8,254,31,0,0,0,0,0,0,128,7,64,9,32
	db	17,32,17,32,17,32,17,192,17,0,0,0,0,0,0,32,0,32,0,252,31,36,0,34,0,34,0,34,0,34
	db	0,0,0,0,0,128,7,64,152,32,144,32,144,32,144,64,72,224,63,0,0,0,0,0,0,254,31,128
	db	0,64,0,32,0,32,0,32,0,192,31,0,0,0,0,0,0,32,0,32,0,38,0,230,31,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,128,32,128,32,128,38,128,230,127,0,0,0,0,0,0,0,0,0,0,254,31,0,1,0,3,128
	db	4,64,4,64,8,32,16,0,0,0,0,0,0,0,0,2,0,2,0,2,0,254,31,0,0,0,0,0,0,0,0,224,31,64
	db	0,32,0,32,0,192,31,64,0,32,0,32,0,192,31,0,0,0,0,224,31,192,0,64,0,32,0,32,0,32
	db	0,192,31,0,0,0,0,0,0,128,7,64,8,32,16,32,16,32,16,64,8,128,7,0,0,0,0,0,0,224
	db	255,64,8,32,16,32,16,32,16,96,8,128,7,0,0,0,0,0,0,128,7,64,24,32,16,32,16,32,16,64
	db	8,224,255,0,0,0,0,0,0,0,0,224,31,128,0,64,0,32,0,32,0,224,0,0,0,0,0,0,0,192,24,32
	db	17,32,17,32,18,32,18,32,12,0,0,0,0,0,0,0,0,32,0,32,0,248,15,32,16,32,16,32,16,32
	db	16,0,0,0,0,0,0,224,15,0,16,0,16,0,16,0,8,224,31,0,0,0,0,0,0,32,0,192,1,0,6,0,24,0
	db	16,0,12,0,3,192,0,32,0,0,0,96,0,128,7,0,24,0,14,192,1,128,1,0,14,0,24,128,7,96
	db	0,0,0,32,16,64,8,128,4,0,3,0,3,128,4,64,8,32,16,0,0,32,128,192,128,0,131,0,70,0
	db	56,0,24,0,6,0,1,192,0,32,0,0,0,32,16,32,24,32,20,32,18,32,17,160,16,96,16,32,16,0
	db	0,0,0,0,0,0,1,0,1,252,62,2,64,2,64,2,64,0,0,0,0,0,0,0,0,0,0,0,0,254,127,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,2,64,2,64,2,64,252,62,0,1,0,1,0,0,0,0,0,3,128,0,128,0,128,0,0
	db	1,0,1,0,2,0,2,0,2,128,1,0,0,128,31,192,16,32,16,16,16,32,16,192,16,128,31,0,0,0
	db	0,192,3,48,12,16,8,8,16,8,16,8,144,8,176,24,208

;********************************************************************************

OLEDFONT2_H
	movff	SYSSTRINGA,SysWORDTempA
	movff	SYSSTRINGA_H,SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableOLEDFONT2_H
	movwf	TBLPTRL,ACCESS
	movlw	high TableOLEDFONT2_H
	addwfc	SysStringA_H, W,ACCESS
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableOLEDFONT2_H
	db	7

;********************************************************************************

;Source: epd_epd2in13d.h (360)
PIXEL_TO_DISPLAY_EPD2IN13D
;Dim EPD_Ind_raw, EPD_Ind_col as Word
;if _GLCDPage = 0 then
	banksel	_GLCDPAGE
	movf	_GLCDPAGE,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF91
;Clear down 'OLD' data - to prevent flashing
;SendCommand_EPD2in13D(Data_Transmission_1)
	movlw	16
	movwf	EPD2IN13D_COMMAND,ACCESS
	banksel	0
	rcall	SENDCOMMAND_EPD2IN13D
;SET EPD_CS OFF
	bcf	LATC,1,ACCESS
;SET EPD_DC ON
	bsf	LATB,7,ACCESS
;for EPD_Ind_raw=1 to GLCD_Height
	clrf	EPD_IND_RAW,ACCESS
	clrf	EPD_IND_RAW_H,ACCESS
SysForLoop20
	incf	EPD_IND_RAW,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	EPD_IND_RAW_H,F,ACCESS
;for EPD_Ind_col=1 to GLCD_Width
	clrf	EPD_IND_COL,ACCESS
	clrf	EPD_IND_COL_H,ACCESS
SysForLoop21
	incf	EPD_IND_COL,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	EPD_IND_COL_H,F,ACCESS
;Replaced with macro for speed              SendData_EPD2in13D(GLCDBackGround)
;EPD2in13D_Data = GLCDBackGround
	movff	GLCDBACKGROUND,EPD2IN13D_DATA
;SendData_EPD2in13D_Macro
;Macro Source: epd_epd2in13d.h (494)
;FastHWSPITransfer EPD2in13D_Data
	movff	EPD2IN13D_DATA,SPITXDATA
	call	FASTHWSPITRANSFER
;next
	movff	EPD_IND_COL,SysWORDTempA
	movff	EPD_IND_COL_H,SysWORDTempA_H
	movlw	104
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop21
SysForLoopEnd21
;next
	movff	EPD_IND_RAW,SysWORDTempA
	movff	EPD_IND_RAW_H,SysWORDTempA_H
	movlw	212
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop20
SysForLoopEnd20
;SET EPD_CS ON
	bsf	LATC,1,ACCESS
;SendCommand_EPD2in13D(DATA_TRANSMISSION_2)
	movlw	19
	movwf	EPD2IN13D_COMMAND,ACCESS
	rcall	SENDCOMMAND_EPD2IN13D
;end if
ENDIF91
;dim EPD2in13D_Data as byte
;We need to set the signals as we are optimising the code by using the macro
;SET EPD_CS OFF
	bcf	LATC,1,ACCESS
;SET EPD_DC ON
	bsf	LATB,7,ACCESS
;for EPD_Ind_raw=1 to BUFFWIDTH
	clrf	EPD_IND_RAW,ACCESS
	clrf	EPD_IND_RAW_H,ACCESS
SysForLoop22
	incf	EPD_IND_RAW,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	EPD_IND_RAW_H,F,ACCESS
;replaced with macro for speed
;SendData_EPD2in13D(EPD_Buffer(EPD_Ind_raw))
;EPD2in13D_Data = EPD_Buffer(EPD_Ind_raw)
	lfsr	0,EPD_BUFFER
	movf	EPD_IND_RAW,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movf	EPD_IND_RAW_H,W,ACCESS
	addwfc	AFSR0_H,F,ACCESS
	movffl	INDF0,EPD2IN13D_DATA
;The following line is intentionally commented out, but, it shows the orientation of the pixels to the array. Uncomment to force a two (when the value is 3!) byte write to the Display
;You can then examine the display to see the orientation of the pixels.
;This will write the bytes at the top of each page - so, do not be surprised!
;if EPD_Ind_raw < 3 then EPD2in13D_Data = GLCDForeground
;This macro assumes the use of the variable EPD2in13D_Data
;SendData_EPD2in13D_Macro
;Macro Source: epd_epd2in13d.h (494)
;FastHWSPITransfer EPD2in13D_Data
	movff	EPD2IN13D_DATA,SPITXDATA
	banksel	0
	call	FASTHWSPITRANSFER
;Now clear the buffer
;EPD_Buffer(EPD_Ind_raw) = GLCDBackground
	lfsr	0,EPD_BUFFER
	movf	EPD_IND_RAW,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movf	EPD_IND_RAW_H,W,ACCESS
	addwfc	AFSR0_H,F,ACCESS
	movffl	GLCDBACKGROUND,INDF0
;next
	movff	EPD_IND_RAW,SysWORDTempA
	movff	EPD_IND_RAW_H,SysWORDTempA_H
	movlw	106
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop22
SysForLoopEnd22
;SET EPD_CS ON
	bsf	LATC,1,ACCESS
	return

;********************************************************************************

;Source: epd_epd2in13d.h (690)
PSET_EPD2IN13D
;Dim EPD_Ind, EPD_N_Col, EPD_N_raw, EPD_Ind_Trans as word
;Dim remainder as byte
;Dim DataVar as byte
;Dim value as bit
;Dim GLCD_Time_Buff as word
;Dim GLCDDataTemp as word
;Select Case EPD2in13DAddressType
;case Landscape
SysSelect4Case1
	decf	EPD2IN13DADDRESSTYPE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case2
;GLCDDataTemp = GLCDX
	movff	GLCDX,GLCDDATATEMP
	movff	GLCDX_H,GLCDDATATEMP_H
;GLCDX = GLCDY
	movff	GLCDY,GLCDX
	movff	GLCDY_H,GLCDX_H
;GLCDY = GLCD_HEIGHT - GLCDDataTemp - 1
	movf	GLCDDATATEMP,W,BANKED
	sublw	212
	banksel	SYSTEMP2
	movwf	SysTemp2,BANKED
	clrf	SysTemp3,BANKED
	banksel	GLCDDATATEMP_H
	movf	GLCDDATATEMP_H,W,BANKED
	banksel	SYSTEMP3
	subwfb	SysTemp3,W,BANKED
	movwf	SysTemp2_H,BANKED
	movlw	1
	subwf	SysTemp2,W,BANKED
	banksel	GLCDY
	movwf	GLCDY,BANKED
	movlw	0
	banksel	SYSTEMP2_H
	subwfb	SysTemp2_H,W,BANKED
	banksel	GLCDY_H
	movwf	GLCDY_H,BANKED
;case Landscape_Rev
	bra	SysSelectEnd4
SysSelect4Case2
	movlw	3
	subwf	EPD2IN13DADDRESSTYPE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case3
;GLCDDataTemp = GLCDX
	movff	GLCDX,GLCDDATATEMP
	movff	GLCDX_H,GLCDDATATEMP_H
;GLCDX = GLCD_WIDTH  - GLCDY - 1
	movf	GLCDY,W,BANKED
	sublw	104
	banksel	SYSTEMP2
	movwf	SysTemp2,BANKED
	clrf	SysTemp3,BANKED
	banksel	GLCDY_H
	movf	GLCDY_H,W,BANKED
	banksel	SYSTEMP3
	subwfb	SysTemp3,W,BANKED
	movwf	SysTemp2_H,BANKED
	movlw	1
	subwf	SysTemp2,W,BANKED
	banksel	GLCDX
	movwf	GLCDX,BANKED
	movlw	0
	banksel	SYSTEMP2_H
	subwfb	SysTemp2_H,W,BANKED
	banksel	GLCDX_H
	movwf	GLCDX_H,BANKED
;GLCDY = GLCDDataTemp
	movff	GLCDDATATEMP,GLCDY
	movff	GLCDDATATEMP_H,GLCDY_H
;case Portrait
	bra	SysSelectEnd4
SysSelect4Case3
	movlw	4
	subwf	EPD2IN13DADDRESSTYPE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case4
;Default do nothing
;case Portrait_Rev
	bra	SysSelectEnd4
SysSelect4Case4
	movlw	2
	subwf	EPD2IN13DADDRESSTYPE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd4
;GLCDY = GLCD_HEIGHT - GLCDY - 1
	movf	GLCDY,W,BANKED
	sublw	212
	banksel	SYSTEMP2
	movwf	SysTemp2,BANKED
	clrf	SysTemp3,BANKED
	banksel	GLCDY_H
	movf	GLCDY_H,W,BANKED
	banksel	SYSTEMP3
	subwfb	SysTemp3,W,BANKED
	movwf	SysTemp2_H,BANKED
	movlw	1
	subwf	SysTemp2,W,BANKED
	banksel	GLCDY
	movwf	GLCDY,BANKED
	movlw	0
	banksel	SYSTEMP2_H
	subwfb	SysTemp2_H,W,BANKED
	banksel	GLCDY_H
	movwf	GLCDY_H,BANKED
;GLCDX = GLCD_WIDTH - GLCDX - 1
	movf	GLCDX,W,BANKED
	sublw	104
	banksel	SYSTEMP2
	movwf	SysTemp2,BANKED
	clrf	SysTemp3,BANKED
	banksel	GLCDX_H
	movf	GLCDX_H,W,BANKED
	banksel	SYSTEMP3
	subwfb	SysTemp3,W,BANKED
	movwf	SysTemp2_H,BANKED
	movlw	1
	subwf	SysTemp2,W,BANKED
	banksel	GLCDX
	movwf	GLCDX,BANKED
	movlw	0
	banksel	SYSTEMP2_H
	subwfb	SysTemp2_H,W,BANKED
	banksel	GLCDX_H
	movwf	GLCDX_H,BANKED
;end select
SysSelectEnd4
;EPD_N_Col=(GLCDX+1)/8                   'number of the column of the byte to be set
	movlw	1
	addwf	GLCDX,W,BANKED
	banksel	SYSTEMP2
	movwf	SysTemp2,BANKED
	movlw	0
	banksel	GLCDX_H
	addwfc	GLCDX_H,W,BANKED
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H,BANKED
	movff	SysTemp2,SysWORDTempA
	movff	SysTemp2_H,SysWORDTempA_H
	movlw	8
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	rcall	SysDivSub16
	movff	SysWORDTempA,EPD_N_COL
	movff	SysWORDTempA_H,EPD_N_COL_H
;remainder=(GLCDX+1)%8
	movlw	1
	addwf	GLCDX,W,BANKED
	banksel	SYSTEMP2
	movwf	SysTemp2,BANKED
	movlw	0
	banksel	GLCDX_H
	addwfc	GLCDX_H,W,BANKED
	banksel	SYSTEMP2_H
	movwf	SysTemp2_H,BANKED
	movff	SysTemp2,SysWORDTempA
	movff	SysTemp2_H,SysWORDTempA_H
	movlw	8
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	rcall	SysDivSub16
	movff	SysWORDTempX,REMAINDER
;EPD_N_raw=(GLCDY)*GLCD_Width8       'number of the column of the byte to be set
	movff	GLCDY,SysWORDTempA
	movff	GLCDY_H,SysWORDTempA_H
	movlw	13
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysMultSub16
	movff	SysWORDTempX,EPD_N_RAW
	movff	SysWORDTempX_H,EPD_N_RAW_H
;if remainder=0 then
	movf	REMAINDER,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE106_1
;EPD_Ind=EPD_N_raw+EPD_N_Col
	movf	EPD_N_COL,W,ACCESS
	addwf	EPD_N_RAW,W,ACCESS
	movwf	EPD_IND,ACCESS
	movf	EPD_N_COL_H,W,ACCESS
	addwfc	EPD_N_RAW_H,W,ACCESS
	movwf	EPD_IND_H,ACCESS
;else
	bra	ENDIF106
ELSE106_1
;EPD_Ind=EPD_N_raw+EPD_N_Col+1       'Number of the byte to be set (starting from 1)
	movf	EPD_N_COL,W,ACCESS
	addwf	EPD_N_RAW,W,ACCESS
	banksel	SYSTEMP2
	movwf	SysTemp2,BANKED
	movf	EPD_N_COL_H,W,ACCESS
	addwfc	EPD_N_RAW_H,W,ACCESS
	movwf	SysTemp2_H,BANKED
	movlw	1
	addwf	SysTemp2,W,BANKED
	movwf	EPD_IND,ACCESS
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	EPD_IND_H,ACCESS
;end if
ENDIF106
;GLCD_Time_Buff=_GLCDPage*BUFFWIDTH
	movff	_GLCDPAGE,SysWORDTempA
	clrf	SysWORDTempA_H,ACCESS
	movlw	106
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	rcall	SysMultSub16
	movff	SysWORDTempX,GLCD_TIME_BUFF
	movff	SysWORDTempX_H,GLCD_TIME_BUFF_H
;EPD_Ind_Trans=EPD_Ind
	movff	EPD_IND,EPD_IND_TRANS
	movff	EPD_IND_H,EPD_IND_TRANS_H
;EPD_Ind_Trans=EPD_Ind_Trans-GLCD_Time_Buff
	movf	GLCD_TIME_BUFF,W,BANKED
	subwf	EPD_IND_TRANS,F,ACCESS
	movf	GLCD_TIME_BUFF_H,W,BANKED
	subwfb	EPD_IND_TRANS_H,F,ACCESS
;if EPD_Ind_Trans>BUFFWIDTH then       'NOTE:it should be a control also for a
	movff	EPD_IND_TRANS,SysWORDTempB
	movff	EPD_IND_TRANS_H,SysWORDTempB_H
	movlw	106
	movwf	SysWORDTempA,ACCESS
	clrf	SysWORDTempA_H,ACCESS
	rcall	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
;EXIT SUB                            'lower bound of ind (ind>GLCD_Time_Buff)
	return
;end if                                'However when the lower bound is violated,
;DataVar=EPD_Buffer(EPD_Ind_Trans)     'Ind_Trans should be negative and, due to
	lfsr	0,EPD_BUFFER
	movf	EPD_IND_TRANS,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movf	EPD_IND_TRANS_H,W,ACCESS
	addwfc	AFSR0_H,F,ACCESS
	movffl	INDF0,DATAVAR
;Select Case remainder                 'non signed arithmetic, it will be very
;case 0                                'large, thus Exits sub is executed.
SysSelect5Case1
	movf	REMAINDER,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case2
;DataVar.0=GLCDColour.0
	bcf	DATAVAR,0,ACCESS
	btfsc	GLCDCOLOUR,0,BANKED
	bsf	DATAVAR,0,ACCESS
;case 1
	bra	SysSelectEnd5
SysSelect5Case2
	decf	REMAINDER,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case3
;DataVar.7=GLCDColour.0
	bcf	DATAVAR,7,ACCESS
	btfsc	GLCDCOLOUR,0,BANKED
	bsf	DATAVAR,7,ACCESS
;case 2
	bra	SysSelectEnd5
SysSelect5Case3
	movlw	2
	subwf	REMAINDER,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case4
;DataVar.6=GLCDColour.0
	bcf	DATAVAR,6,ACCESS
	btfsc	GLCDCOLOUR,0,BANKED
	bsf	DATAVAR,6,ACCESS
;case 3
	bra	SysSelectEnd5
SysSelect5Case4
	movlw	3
	subwf	REMAINDER,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case5
;DataVar.5=GLCDColour.0
	bcf	DATAVAR,5,ACCESS
	btfsc	GLCDCOLOUR,0,BANKED
	bsf	DATAVAR,5,ACCESS
;case 4
	bra	SysSelectEnd5
SysSelect5Case5
	movlw	4
	subwf	REMAINDER,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case6
;DataVar.4=GLCDColour.0
	bcf	DATAVAR,4,ACCESS
	btfsc	GLCDCOLOUR,0,BANKED
	bsf	DATAVAR,4,ACCESS
;case 5
	bra	SysSelectEnd5
SysSelect5Case6
	movlw	5
	subwf	REMAINDER,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case7
;DataVar.3=GLCDColour.0
	bcf	DATAVAR,3,ACCESS
	btfsc	GLCDCOLOUR,0,BANKED
	bsf	DATAVAR,3,ACCESS
;case 6
	bra	SysSelectEnd5
SysSelect5Case7
	movlw	6
	subwf	REMAINDER,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case8
;DataVar.2=GLCDColour.0
	bcf	DATAVAR,2,ACCESS
	btfsc	GLCDCOLOUR,0,BANKED
	bsf	DATAVAR,2,ACCESS
;case 7
	bra	SysSelectEnd5
SysSelect5Case8
	movlw	7
	subwf	REMAINDER,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd5
;DataVar.1=GLCDColour.0
	bcf	DATAVAR,1,ACCESS
	btfsc	GLCDCOLOUR,0,BANKED
	bsf	DATAVAR,1,ACCESS
;End Select
SysSelectEnd5
;EPD_Buffer(EPD_Ind_Trans)=DataVar
	lfsr	0,EPD_BUFFER
	movf	EPD_IND_TRANS,W,ACCESS
	addwf	AFSR0,F,ACCESS
	movf	EPD_IND_TRANS_H,W,ACCESS
	addwfc	AFSR0_H,F,ACCESS
	movffl	DATAVAR,INDF0
	return

;********************************************************************************

;Source: random.h (34)
FN_RANDOM
;Repeat 7
	movlw	7
	banksel	SYSREPEATTEMP3
	movwf	SysRepeatTemp3,BANKED
SysRepeatLoop3
;Dim RandomTemp As Word
;Dim RandomSeed As Word
;RandomTemp = RandomSeed
	movff	RANDOMSEED,RANDOMTEMP
	movff	RANDOMSEED_H,RANDOMTEMP_H
;Rotate RandomTemp Left Simple
	banksel	RANDOMTEMP_H
	rlcf	RANDOMTEMP_H,W,BANKED
	rlcf	RANDOMTEMP,F,BANKED
	rlcf	RANDOMTEMP_H,F,BANKED
;Taps at 16, 15, 13, 11, And with b'1101 0100 0000 0000' = D800
;RandomSeed = RandomTemp XOR (Not (RandomSeed And 1) + 1 And 0xB400)
	movlw	1
	andwf	RANDOMSEED,W,BANKED
	banksel	SYSTEMP2
	movwf	SysTemp2,BANKED
	clrf	SysTemp2_H,BANKED
	comf	SysTemp2,W,BANKED
	movwf	SysTemp1,BANKED
	comf	SysTemp2_H,W,BANKED
	movwf	SysTemp1_H,BANKED
	movlw	1
	addwf	SysTemp1,W,BANKED
	movwf	SysTemp2,BANKED
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	SysTemp2_H,BANKED
	clrf	SysTemp1,BANKED
	movlw	180
	andwf	SysTemp2_H,W,BANKED
	movwf	SysTemp1_H,BANKED
	banksel	RANDOMTEMP
	movf	RANDOMTEMP,W,BANKED
	banksel	SYSTEMP1
	xorwf	SysTemp1,W,BANKED
	banksel	RANDOMSEED
	movwf	RANDOMSEED,BANKED
	movf	RANDOMTEMP_H,W,BANKED
	banksel	SYSTEMP1_H
	xorwf	SysTemp1_H,W,BANKED
	banksel	RANDOMSEED_H
	movwf	RANDOMSEED_H,BANKED
;Random = Random Xor RandomSeed_H
	movf	RANDOM,W,BANKED
	xorwf	RANDOMSEED_H,W,BANKED
	movwf	RANDOM,BANKED
;End Repeat
	banksel	SYSREPEATTEMP3
	decfsz	SysRepeatTemp3,F,BANKED
	bra	SysRepeatLoop3
SysRepeatLoopEnd3
	banksel	0
	return

;********************************************************************************

;Source: epd_epd2in13d.h (883)
ROTATE_EPD2IN13D
;Reset PrintLocY
;PrintLocY = 0
	clrf	PRINTLOCY,BANKED
;select case EPD2in13DAddressType
;case PORTRAIT
SysSelect6Case1
	movlw	4
	subwf	EPD2IN13DADDRESSTYPE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case2
;GLCDDeviceHeight = GLCD_HEIGHT - 1
	movlw	211
	movwf	GLCDDEVICEHEIGHT,BANKED
	clrf	GLCDDEVICEHEIGHT_H,BANKED
;GLCDDeviceWidth = GLCD_WIDTH - 1
	movlw	103
	movwf	GLCDDEVICEWIDTH,BANKED
	clrf	GLCDDEVICEWIDTH_H,BANKED
;case LANDSCAPE
	bra	SysSelectEnd6
SysSelect6Case2
	decf	EPD2IN13DADDRESSTYPE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case3
;GLCDDeviceHeight = GLCD_WIDTH - 1
	movlw	103
	movwf	GLCDDEVICEHEIGHT,BANKED
	clrf	GLCDDEVICEHEIGHT_H,BANKED
;GLCDDeviceWidth  = GLCD_HEIGHT - 1
	movlw	211
	movwf	GLCDDEVICEWIDTH,BANKED
	clrf	GLCDDEVICEWIDTH_H,BANKED
;case PORTRAIT_REV
	bra	SysSelectEnd6
SysSelect6Case3
	movlw	2
	subwf	EPD2IN13DADDRESSTYPE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case4
;GLCDDeviceHeight = GLCD_HEIGHT - 1
	movlw	211
	movwf	GLCDDEVICEHEIGHT,BANKED
	clrf	GLCDDEVICEHEIGHT_H,BANKED
;GLCDDeviceWidth  = GLCD_WIDTH - 1
	movlw	103
	movwf	GLCDDEVICEWIDTH,BANKED
	clrf	GLCDDEVICEWIDTH_H,BANKED
;case LANDSCAPE_REV
	bra	SysSelectEnd6
SysSelect6Case4
	movlw	3
	subwf	EPD2IN13DADDRESSTYPE,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case5
;GLCDDeviceHeight = GLCD_WIDTH - 1
	movlw	103
	movwf	GLCDDEVICEHEIGHT,BANKED
	clrf	GLCDDEVICEHEIGHT_H,BANKED
;GLCDDeviceWidth  = GLCD_HEIGHT - 1
	movlw	211
	movwf	GLCDDEVICEWIDTH,BANKED
	clrf	GLCDDEVICEWIDTH_H,BANKED
;case else
	bra	SysSelectEnd6
SysSelect6Case5
;GLCDDeviceHeight = GLCD_HEIGHT - 1
	movlw	211
	movwf	GLCDDEVICEHEIGHT,BANKED
	clrf	GLCDDEVICEHEIGHT_H,BANKED
;GLCDDeviceWidth  = GLCD_WIDTH - 1
	movlw	103
	movwf	GLCDDEVICEWIDTH,BANKED
	clrf	GLCDDEVICEWIDTH_H,BANKED
;end select
SysSelectEnd6
	return

;********************************************************************************

;Source: epd_epd2in13d.h (451)
SENDCOMMAND_EPD2IN13D
;SET EPD_CS OFF
	bcf	LATC,1,ACCESS
;SET EPD_DC OFF
	bcf	LATB,7,ACCESS
;FastHWSPITransfer EPD2in13D_Command
	movff	EPD2IN13D_COMMAND,SPITXDATA
	call	FASTHWSPITRANSFER
;SET EPD_CS ON
	bsf	LATC,1,ACCESS
;do
SysDoLoop_S8
;loop while EPD_Busy=Off
	btfss	PORTC,0,ACCESS
	bra	SysDoLoop_S8
SysDoLoop_E8
;Exit sub
	return
	return

;********************************************************************************

;Source: epd_epd2in13d.h (484)
SENDDATA_EPD2IN13D
;SET EPD_CS OFF
	bcf	LATC,1,ACCESS
;SET EPD_DC ON
	bsf	LATB,7,ACCESS
;SendData_EPD2in13D_Macro
;Macro Source: epd_epd2in13d.h (494)
;FastHWSPITransfer EPD2in13D_Data
	movff	EPD2IN13D_DATA,SPITXDATA
	call	FASTHWSPITRANSFER
;SET EPD_CS ON
	bsf	LATC,1,ACCESS
	return

;********************************************************************************

;Overloaded signature: BYTE:BYTE:, Source: hwspi.h (354)
SPIMODE644
;Supports K mode SPI using the specific SPI module
;Turn off SPI
;(Prevents any weird glitches during setup)
;SPI1CON0_EN = 0
	banksel	SPI1CON0
	bcf	SPI1CON0,SPI1CON0_EN,BANKED
;Set clock pulse settings to middle
;SPI1CON1.SMP = 0
	bcf	SPI1CON1,SMP,BANKED
;Data write on rising (idle > active) clock (CPHA = 1)
;SPI1CON1.CKE = 0
	bcf	SPI1CON1,CKE,BANKED
;Clock idle low (CPOL = 0)
;SPI1CON1.CKP = 0
	bcf	SPI1CON1,CKP,BANKED
;If SPIClockMode.0 = Off Then
	banksel	SPICLOCKMODE
	btfsc	SPICLOCKMODE,0,BANKED
	bra	ENDIF154
;SPI1CON1.CKE = 1
	banksel	SPI1CON1
	bsf	SPI1CON1,CKE,BANKED
;End If
ENDIF154
;If SPIClockMode.1 = On Then
	banksel	SPICLOCKMODE
	btfss	SPICLOCKMODE,1,BANKED
	bra	ENDIF155
;SPI1CON1.CKP = 1
	banksel	SPI1CON1
	bsf	SPI1CON1,CKP,BANKED
;End If
ENDIF155
;SPI1CON1 = 0x40
	movlw	64
	banksel	SPI1CON1
	movwf	SPI1CON1,BANKED
;Transfer
;SPI1CON2 = SPI1CON2 or 3
	movlw	3
	iorwf	SPI1CON2,F,BANKED
;Select mode and clock
;SPI1CLK = SSP1_FOSC
	clrf	SPI1CLK,BANKED
;Select Case SPICurrentMode
;Case MasterFast or MasterUltraFast
SysSelect7Case1
	movff	SPICURRENTMODE,SysBYTETempA
	movlw	13
	movwf	SysBYTETempB,ACCESS
	banksel	0
	rcall	SysCompEqual
	movlw	14
	iorwf	SysByteTempX,W,ACCESS
	banksel	SYSTEMP3
	movwf	SysTemp3,BANKED
	btfss	SysTemp3,0,BANKED
	bra	SysSelect7Case2
;asm showdebug Script value is calculated as SPIBAUDRATE_SCRIPT
;script sysbitvar0.2 is calculated as 3
;SPI1BAUD = SPIBAUDRATE_SCRIPT
	movlw	3
	banksel	SPI1BAUD
	movwf	SPI1BAUD,BANKED
;SPI1CON0.MST = 1
	bsf	SPI1CON0,MST,BANKED
;Case Master
	bra	SysSelectEnd7
SysSelect7Case2
	movlw	12
	banksel	SPICURRENTMODE
	subwf	SPICURRENTMODE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect7Case3
;asm showdebug Script value is calculated as SPIBAUDRATE_SCRIPT_MASTER
;script sysbitvar0.2 is calculated as 9
;SPI1BAUD = SPIBAUDRATE_SCRIPT_MASTER
	movlw	9
	banksel	SPI1BAUD
	movwf	SPI1BAUD,BANKED
;SPI1CON0.MST = 1
	bsf	SPI1CON0,MST,BANKED
;Case MasterSlow
	bra	SysSelectEnd7
SysSelect7Case3
	movlw	11
	subwf	SPICURRENTMODE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect7Case4
;asm showdebug Script value is calculated as SPIBAUDRATE_SCRIPT_MASTERSLOW
;script sysbitvar0.2 is calculated as 33
;SPI1BAUD = SPIBAUDRATE_SCRIPT_MASTERSLOW
	movlw	33
	banksel	SPI1BAUD
	movwf	SPI1BAUD,BANKED
;SPI1CON0.MST = 1
	bsf	SPI1CON0,MST,BANKED
;Case Slave
	bra	SysSelectEnd7
SysSelect7Case4
	movf	SPICURRENTMODE,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect7Case5
;SPI1CON0.MST = 0
	banksel	SPI1CON0
	bcf	SPI1CON0,MST,BANKED
;Case SlaveSS
	bra	SysSelectEnd7
SysSelect7Case5
	decf	SPICURRENTMODE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd7
;SPI1CON0.MST = 0
	banksel	SPI1CON0
	bcf	SPI1CON0,MST,BANKED
;End Select
SysSelectEnd7
;Enable SPI
;SPI1CON0.EN = 1
	banksel	SPI1CON0
	bsf	SPI1CON0,EN,BANKED
	banksel	0
	return

;********************************************************************************

;Source: string.h (75)
FN_STR
;SysCharCount = 0
	banksel	SYSCHARCOUNT
	clrf	SYSCHARCOUNT,BANKED
;Dim SysCalcTempX As Word
;Ten Thousands
;IF SysValTemp >= 10000 then
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB,ACCESS
	movlw	39
	movwf	SysWORDTempB_H,ACCESS
	banksel	0
	rcall	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF135
;SysStrData = SysValTemp / 10000
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB,ACCESS
	movlw	39
	movwf	SysWORDTempB_H,ACCESS
	rcall	SysDivSub16
	movff	SysWORDTempA,SYSSTRDATA
;SysValTemp = SysCalcTempX
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
;SysCharCount += 1
	banksel	SYSCHARCOUNT
	incf	SYSCHARCOUNT,F,BANKED
;Str(SysCharCount) = SysStrData + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSSTRDATA,W,BANKED
	movwf	INDF0,ACCESS
;Goto SysValThousands
	bra	SYSVALTHOUSANDS
;End If
ENDIF135
;Thousands
;IF SysValTemp >= 1000 then
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB,ACCESS
	movlw	3
	movwf	SysWORDTempB_H,ACCESS
	rcall	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF136
SYSVALTHOUSANDS
;SysStrData = SysValTemp / 1000
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB,ACCESS
	movlw	3
	movwf	SysWORDTempB_H,ACCESS
	banksel	0
	rcall	SysDivSub16
	movff	SysWORDTempA,SYSSTRDATA
;SysValTemp = SysCalcTempX
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
;SysCharCount += 1
	banksel	SYSCHARCOUNT
	incf	SYSCHARCOUNT,F,BANKED
;Str(SysCharCount) = SysStrData + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSSTRDATA,W,BANKED
	movwf	INDF0,ACCESS
;Goto SysValHundreds
	bra	SYSVALHUNDREDS
;End If
ENDIF136
;Hundreds
;IF SysValTemp >= 100 then
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF137
SYSVALHUNDREDS
;SysStrData = SysValTemp / 100
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	rcall	SysDivSub16
	movff	SysWORDTempA,SYSSTRDATA
;SysValTemp = SysCalcTempX
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
;SysCharCount += 1
	banksel	SYSCHARCOUNT
	incf	SYSCHARCOUNT,F,BANKED
;Str(SysCharCount) = SysStrData + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSSTRDATA,W,BANKED
	movwf	INDF0,ACCESS
;Goto SysValTens
	bra	SYSVALTENS
;End If
ENDIF137
;Tens
;IF SysValTemp >= 10 Then
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF138
SYSVALTENS
;SysStrData = SysValTemp / 10
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	rcall	SysDivSub16
	movff	SysWORDTempA,SYSSTRDATA
;SysValTemp = SysCalcTempX
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
;SysCharCount += 1
	banksel	SYSCHARCOUNT
	incf	SYSCHARCOUNT,F,BANKED
;Str(SysCharCount) = SysStrData + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSSTRDATA,W,BANKED
	movwf	INDF0,ACCESS
;End If
ENDIF138
;Ones
;SysCharCount += 1
	banksel	SYSCHARCOUNT
	incf	SYSCHARCOUNT,F,BANKED
;Str(SysCharCount) = SysValTemp + 48
	lfsr	0,STR
	movf	SYSCHARCOUNT,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	SYSVALTEMP,W,BANKED
	movwf	INDF0,ACCESS
;SysValTemp = SysCalcTempX
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
;Str(0) = SysCharCount
	movffl	SYSCHARCOUNT,SYSSTR_0
	banksel	0
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:, Source: stdbasic.h (284)
SWAP509
;Dim SysCalcTempX As Word
;SysCalcTempX = SysCalcTempA
	movff	SYSCALCTEMPA,SYSCALCTEMPX
	movff	SYSCALCTEMPA_H,SYSCALCTEMPX_H
;SysCalcTempA = SysCalcTempB
	movff	SYSCALCTEMPB,SYSCALCTEMPA
	movff	SYSCALCTEMPB_H,SYSCALCTEMPA_H
;SysCalcTempB = SysCalcTempX
	movff	SYSCALCTEMPX,SYSCALCTEMPB
	movff	SYSCALCTEMPX_H,SYSCALCTEMPB_H
	return

;********************************************************************************

;Source: system.h (2613)
SYSCOMPEQUAL
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;setf SysByteTempX
	setf	SYSBYTETEMPX,ACCESS
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W,ACCESS
;cpfseq SysByteTempA
	cpfseq	SYSBYTETEMPA,ACCESS
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
	return

;********************************************************************************

;Source: system.h (2639)
SYSCOMPEQUAL16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
;Test low, exit if false
;movf SysWordTempB, W
	movf	SYSWORDTEMPB, W,ACCESS
;cpfseq SysWordTempA
	cpfseq	SYSWORDTEMPA,ACCESS
;return
	return
;Test high, exit if false
;movf SysWordTempB_H, W
	movf	SYSWORDTEMPB_H, W,ACCESS
;cpfseq SysWordTempA_H
	cpfseq	SYSWORDTEMPA_H,ACCESS
;return
	return
;setf SysByteTempX
	setf	SYSBYTETEMPX,ACCESS
	return

;********************************************************************************

;Source: system.h (2780)
SYSCOMPLESSTHAN
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;setf SysByteTempX
	setf	SYSBYTETEMPX,ACCESS
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W,ACCESS
;cpfslt SysByteTempA
	cpfslt	SYSBYTETEMPA,ACCESS
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
	return

;********************************************************************************

;Source: system.h (2810)
SYSCOMPLESSTHAN16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
;Test High, exit if more
;movf SysWordTempA_H,W
	movf	SYSWORDTEMPA_H,W,ACCESS
;subwf SysWordTempB_H,W
	subwf	SYSWORDTEMPB_H,W,ACCESS
;btfss STATUS,C
	btfss	STATUS,C,ACCESS
;return
	return
;Test high, exit true if less
;movf SysWordTempB_H,W
	movf	SYSWORDTEMPB_H,W,ACCESS
;subwf SysWordTempA_H,W
	subwf	SYSWORDTEMPA_H,W,ACCESS
;bnc SCLT16True
	bnc	SCLT16TRUE
;Test Low, exit if more or equal
;movf SysWordTempB,W
	movf	SYSWORDTEMPB,W,ACCESS
;subwf SysWordTempA,W
	subwf	SYSWORDTEMPA,W,ACCESS
;btfsc STATUS,C
	btfsc	STATUS,C,ACCESS
;return
	return
SCLT16TRUE
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F,ACCESS
	return

;********************************************************************************

;Source: system.h (2868)
SYSCOMPLESSTHAN32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
;Test Exp, exit if more
;movf SysLongTempA_E,W
	movf	SYSLONGTEMPA_E,W,ACCESS
;subwf SysLongTempB_E,W
	subwf	SYSLONGTEMPB_E,W,ACCESS
;btfss STATUS,C
	btfss	STATUS,C,ACCESS
;return
	return
;If not more and not zero, is less
;bnz SCLT32True
	bnz	SCLT32TRUE
;Test Upper, exit if more
;movf SysLongTempA_U,W
	movf	SYSLONGTEMPA_U,W,ACCESS
;subwf SysLongTempB_U,W
	subwf	SYSLONGTEMPB_U,W,ACCESS
;btfss STATUS,C
	btfss	STATUS,C,ACCESS
;return
	return
;If not more and not zero, is less
;bnz SCLT32True
	bnz	SCLT32TRUE
;Test High, exit if more
;movf SysLongTempA_H,W
	movf	SYSLONGTEMPA_H,W,ACCESS
;subwf SysLongTempB_H,W
	subwf	SYSLONGTEMPB_H,W,ACCESS
;btfss STATUS,C
	btfss	STATUS,C,ACCESS
;return
	return
;If not more and not zero, is less
;bnz SCLT32True
	bnz	SCLT32TRUE
;Test Low, exit if more or equal
;movf SysLongTempB,W
	movf	SYSLONGTEMPB,W,ACCESS
;subwf SysLongTempA,W
	subwf	SYSLONGTEMPA,W,ACCESS
;btfsc STATUS,C
	btfsc	STATUS,C,ACCESS
;return
	return
SCLT32TRUE
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F,ACCESS
	return

;********************************************************************************

;Source: system.h (2962)
SYSCOMPLESSTHANINT
;Dim SysIntegerTempA, SysIntegerTempB, SysDivMultA as Integer
;Clear result
;SysByteTempX = 0
	clrf	SYSBYTETEMPX,ACCESS
;Compare sign bits
;-A
;If SysIntegerTempA.15 = On Then
	btfss	SYSINTEGERTEMPA_H,7,ACCESS
	bra	ELSE132_1
;-A, +B, return true
;If SysIntegerTempB.15 = Off Then
	btfsc	SYSINTEGERTEMPB_H,7,ACCESS
	bra	ENDIF133
;Set SysByteTempX to 255
;SysByteTempX = Not SysByteTempX
	comf	SYSBYTETEMPX,F,ACCESS
;Exit Sub
	return
;End If
ENDIF133
;-A, -B, negate both and swap
;SysDivMultA = -SysIntegerTempA
	comf	SYSINTEGERTEMPA,W,ACCESS
	movwf	SYSDIVMULTA,ACCESS
	comf	SYSINTEGERTEMPA_H,W,ACCESS
	movwf	SYSDIVMULTA_H,ACCESS
	incf	SYSDIVMULTA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSDIVMULTA_H,F,ACCESS
;SysIntegerTempA = -SysIntegerTempB
	comf	SYSINTEGERTEMPB,W,ACCESS
	movwf	SYSINTEGERTEMPA,ACCESS
	comf	SYSINTEGERTEMPB_H,W,ACCESS
	movwf	SYSINTEGERTEMPA_H,ACCESS
	incf	SYSINTEGERTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPA_H,F,ACCESS
;SysIntegerTempB = SysDivMultA
	movff	SYSDIVMULTA,SYSINTEGERTEMPB
	movff	SYSDIVMULTA_H,SYSINTEGERTEMPB_H
;+A
;Else
	bra	ENDIF132
ELSE132_1
;+A, -B, return false
;If SysIntegerTempB.15 = On Then
	btfsc	SYSINTEGERTEMPB_H,7,ACCESS
;Exit Sub
	return
;End If
;End If
ENDIF132
;Test High, exit if more
;movf SysIntegerTempA_H,W
	movf	SYSINTEGERTEMPA_H,W,ACCESS
;subwf SysIntegerTempB_H,W
	subwf	SYSINTEGERTEMPB_H,W,ACCESS
;btfss STATUS,C
	btfss	STATUS,C,ACCESS
;return
	return
;Test high, exit true if less
;movf SysIntegerTempB_H,W
	movf	SYSINTEGERTEMPB_H,W,ACCESS
;subwf SysIntegerTempA_H,W
	subwf	SYSINTEGERTEMPA_H,W,ACCESS
;bnc SCLTIntTrue
	bnc	SCLTINTTRUE
;Test Low, exit if more or equal
;movf SysIntegerTempB,W
	movf	SYSINTEGERTEMPB,W,ACCESS
;subwf SysIntegerTempA,W
	subwf	SYSINTEGERTEMPA,W,ACCESS
;btfsc STATUS,C
	btfsc	STATUS,C,ACCESS
;return
	return
SCLTINTTRUE
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F,ACCESS
	return

;********************************************************************************

;Source: system.h (1043)
SYSCOPYSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Get and copy length
;movff INDF0, SysCalcTempA
	movffl	INDF0,SYSCALCTEMPA
;movff SysCalcTempA, INDF1
	movffl	SYSCALCTEMPA,INDF1
;goto SysCopyStringCheck
	bra	SYSCOPYSTRINGCHECK
;When appending, add length to counter
SYSCOPYSTRINGPART
;movf INDF0, W
	movf	INDF0, W,ACCESS
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA,ACCESS
;addwf SysStringLength, F
	addwf	SYSSTRINGLENGTH, F,ACCESS
SYSCOPYSTRINGCHECK
;Exit if length = 0
;movf SysCalcTempA,F
	movf	SYSCALCTEMPA,F,ACCESS
;btfsc STATUS,Z
	btfsc	STATUS,Z,ACCESS
;return
	return
SYSSTRINGCOPY
;Copy character
;movff PREINC0, PREINC1
	movffl	PREINC0,PREINC1
;decfsz SysCalcTempA, F
	decfsz	SYSCALCTEMPA, F,ACCESS
;goto SysStringCopy
	bra	SYSSTRINGCOPY
	return

;********************************************************************************

;Source: system.h (2457)
SYSDIVSUB16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;dim SysDivMultA as word
;dim SysDivMultB as word
;dim SysDivMultX as word
;SysDivMultA = SysWordTempA
	movff	SYSWORDTEMPA,SYSDIVMULTA
	movff	SYSWORDTEMPA_H,SYSDIVMULTA_H
;SysDivMultB = SysWordTempB
	movff	SYSWORDTEMPB,SYSDIVMULTB
	movff	SYSWORDTEMPB_H,SYSDIVMULTB_H
;SysDivMultX = 0
	clrf	SYSDIVMULTX,ACCESS
	clrf	SYSDIVMULTX_H,ACCESS
;Avoid division by zero
;if SysDivMultB = 0 then
	movff	SYSDIVMULTB,SysWORDTempA
	movff	SYSDIVMULTB_H,SysWORDTempA_H
	clrf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF127
;SysWordTempA = 0
	clrf	SYSWORDTEMPA,ACCESS
	clrf	SYSWORDTEMPA_H,ACCESS
;exit sub
	return
;end if
ENDIF127
;Main calc routine
;SysDivLoop = 16
	movlw	16
	movwf	SYSDIVLOOP,ACCESS
SYSDIV16START
;set C off
	bcf	STATUS,C,ACCESS
;Rotate SysDivMultA Left
	rlcf	SYSDIVMULTA,F,ACCESS
	rlcf	SYSDIVMULTA_H,F,ACCESS
;Rotate SysDivMultX Left
	rlcf	SYSDIVMULTX,F,ACCESS
	rlcf	SYSDIVMULTX_H,F,ACCESS
;SysDivMultX = SysDivMultX - SysDivMultB
	movf	SYSDIVMULTB,W,ACCESS
	subwf	SYSDIVMULTX,F,ACCESS
	movf	SYSDIVMULTB_H,W,ACCESS
	subwfb	SYSDIVMULTX_H,F,ACCESS
;Set SysDivMultA.0 On
	bsf	SYSDIVMULTA,0,ACCESS
;If C Off Then
	btfsc	STATUS,C,ACCESS
	bra	ENDIF128
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0,ACCESS
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W,ACCESS
	addwf	SYSDIVMULTX,F,ACCESS
	movf	SYSDIVMULTB_H,W,ACCESS
	addwfc	SYSDIVMULTX_H,F,ACCESS
;End If
ENDIF128
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F,ACCESS
;goto SysDiv16Start
	bra	SYSDIV16START
;SysWordTempA = SysDivMultA
	movff	SYSDIVMULTA,SYSWORDTEMPA
	movff	SYSDIVMULTA_H,SYSWORDTEMPA_H
;SysWordTempX = SysDivMultX
	movff	SYSDIVMULTX,SYSWORDTEMPX
	movff	SYSDIVMULTX_H,SYSWORDTEMPX_H
	return

;********************************************************************************

;Source: system.h (2511)
SYSDIVSUBINT
;Dim SysIntegerTempA, SysIntegerTempB, SysIntegerTempX As Integer
;Dim SysSignByte As Byte
;Make both inputs positive, decide output type
;SysSignByte = SysIntegerTempA_H xor SysIntegerTempB_H
	movf	SYSINTEGERTEMPA_H,W,ACCESS
	xorwf	SYSINTEGERTEMPB_H,W,ACCESS
	movwf	SYSSIGNBYTE,ACCESS
;If SysIntegerTempA.15 Then SysIntegerTempA = -SysIntegerTempA
	btfss	SYSINTEGERTEMPA_H,7,ACCESS
	bra	ENDIF129
	comf	SYSINTEGERTEMPA,F,ACCESS
	comf	SYSINTEGERTEMPA_H,F,ACCESS
	incf	SYSINTEGERTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPA_H,F,ACCESS
ENDIF129
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
	btfss	SYSINTEGERTEMPB_H,7,ACCESS
	bra	ENDIF130
	comf	SYSINTEGERTEMPB,F,ACCESS
	comf	SYSINTEGERTEMPB_H,F,ACCESS
	incf	SYSINTEGERTEMPB,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPB_H,F,ACCESS
ENDIF130
;Call word divide routine
;SysDivSub16
	rcall	SYSDIVSUB16
;Negate result if necessary
;If SysSignByte.7 Then
	btfss	SYSSIGNBYTE,7,ACCESS
	bra	ENDIF131
;SysIntegerTempA = -SysIntegerTempA
	comf	SYSINTEGERTEMPA,F,ACCESS
	comf	SYSINTEGERTEMPA_H,F,ACCESS
	incf	SYSINTEGERTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPA_H,F,ACCESS
;SysIntegerTempX = -SysIntegerTempX
	comf	SYSINTEGERTEMPX,F,ACCESS
	comf	SYSINTEGERTEMPX_H,F,ACCESS
	incf	SYSINTEGERTEMPX,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPX_H,F,ACCESS
;End If
ENDIF131
	return

;********************************************************************************

;Source: system.h (2212)
SYSMULTSUB16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;X = LowA * LowB
;movf SysWordTempA, W
	movf	SYSWORDTEMPA, W,ACCESS
;mulwf SysWordTempB
	mulwf	SYSWORDTEMPB,ACCESS
;movff PRODL, SysWordTempX
	movffl	PRODL,SYSWORDTEMPX
;movff PRODH, SysWordTempX_H
	movffl	PRODH,SYSWORDTEMPX_H
;HighX += LowA * HighB
;movf SysWordTempA, W
	movf	SYSWORDTEMPA, W,ACCESS
;mulwf SysWordTempB_H
	mulwf	SYSWORDTEMPB_H,ACCESS
;movf PRODL, W
	movf	PRODL, W,ACCESS
;addwf SysWordTempX_H, F
	addwf	SYSWORDTEMPX_H, F,ACCESS
;HighX += HighA * LowB
;movf SysWordTempA_H, W
	movf	SYSWORDTEMPA_H, W,ACCESS
;mulwf SysWordTempB
	mulwf	SYSWORDTEMPB,ACCESS
;movf PRODL, W
	movf	PRODL, W,ACCESS
;addwf SysWordTempX_H, F
	addwf	SYSWORDTEMPX_H, F,ACCESS
;PRODL = HighA * HighB
;movf SysWordTempA_H, F
	movf	SYSWORDTEMPA_H, F,ACCESS
;mulwf SysWordTempB_H
	mulwf	SYSWORDTEMPB_H,ACCESS
	return

;********************************************************************************

;Source: system.h (2329)
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
	movff	SYSLONGTEMPA,SYSLONGDIVMULTA
	movff	SYSLONGTEMPA_H,SYSLONGDIVMULTA_H
	movff	SYSLONGTEMPA_U,SYSLONGDIVMULTA_U
	movff	SYSLONGTEMPA_E,SYSLONGDIVMULTA_E
;SysLongDivMultB = SysLongTempB
	movff	SYSLONGTEMPB,SYSLONGDIVMULTB
	movff	SYSLONGTEMPB_H,SYSLONGDIVMULTB_H
	movff	SYSLONGTEMPB_U,SYSLONGDIVMULTB_U
	movff	SYSLONGTEMPB_E,SYSLONGDIVMULTB_E
;SysLongDivMultX = 0
	banksel	SYSLONGDIVMULTX
	clrf	SYSLONGDIVMULTX,BANKED
	clrf	SYSLONGDIVMULTX_H,BANKED
	clrf	SYSLONGDIVMULTX_U,BANKED
	clrf	SYSLONGDIVMULTX_E,BANKED
MUL32LOOP
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
	banksel	SYSLONGDIVMULTB
	btfss	SYSLONGDIVMULTB,0,BANKED
	bra	ENDIF125
	movf	SYSLONGDIVMULTA,W,BANKED
	addwf	SYSLONGDIVMULTX,F,BANKED
	movf	SYSLONGDIVMULTA_H,W,BANKED
	addwfc	SYSLONGDIVMULTX_H,F,BANKED
	movf	SYSLONGDIVMULTA_U,W,BANKED
	addwfc	SYSLONGDIVMULTX_U,F,BANKED
	movf	SYSLONGDIVMULTA_E,W,BANKED
	addwfc	SYSLONGDIVMULTX_E,F,BANKED
ENDIF125
;set STATUS.C OFF
	bcf	STATUS,C,ACCESS
;rotate SysLongDivMultB right
	rrcf	SYSLONGDIVMULTB_E,F,BANKED
	rrcf	SYSLONGDIVMULTB_U,F,BANKED
	rrcf	SYSLONGDIVMULTB_H,F,BANKED
	rrcf	SYSLONGDIVMULTB,F,BANKED
;set STATUS.C off
	bcf	STATUS,C,ACCESS
;rotate SysLongDivMultA left
	rlcf	SYSLONGDIVMULTA,F,BANKED
	rlcf	SYSLONGDIVMULTA_H,F,BANKED
	rlcf	SYSLONGDIVMULTA_U,F,BANKED
	rlcf	SYSLONGDIVMULTA_E,F,BANKED
;if SysLongDivMultB > 0 then goto MUL32LOOP
	movff	SYSLONGDIVMULTB,SysLONGTempB
	movff	SYSLONGDIVMULTB_H,SysLONGTempB_H
	movff	SYSLONGDIVMULTB_U,SysLONGTempB_U
	movff	SYSLONGDIVMULTB_E,SysLONGTempB_E
	clrf	SysLONGTempA,ACCESS
	clrf	SysLONGTempA_H,ACCESS
	clrf	SysLONGTempA_U,ACCESS
	clrf	SysLONGTempA_E,ACCESS
	banksel	0
	rcall	SysCompLessThan32
	btfsc	SysByteTempX,0,ACCESS
	bra	MUL32LOOP
;SysLongTempX = SysLongDivMultX
	movff	SYSLONGDIVMULTX,SYSLONGTEMPX
	movff	SYSLONGDIVMULTX_H,SYSLONGTEMPX_H
	movff	SYSLONGDIVMULTX_U,SYSLONGTEMPX_U
	movff	SYSLONGDIVMULTX_E,SYSLONGTEMPX_E
	return

;********************************************************************************

;Source: system.h (2310)
SYSMULTSUBINT
;Dim SysIntegerTempA, SysIntegerTempB, SysIntegerTempX As Integer
;Dim SysSignByte As Byte
;Make both inputs positive, decide output type
;SysSignByte = SysIntegerTempA_H xor SysIntegerTempB_H
	movf	SYSINTEGERTEMPA_H,W,ACCESS
	xorwf	SYSINTEGERTEMPB_H,W,ACCESS
	movwf	SYSSIGNBYTE,ACCESS
;if SysIntegerTempA.15 then SysIntegerTempA = -SysIntegerTempA
	btfss	SYSINTEGERTEMPA_H,7,ACCESS
	bra	ENDIF122
	comf	SYSINTEGERTEMPA,F,ACCESS
	comf	SYSINTEGERTEMPA_H,F,ACCESS
	incf	SYSINTEGERTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPA_H,F,ACCESS
ENDIF122
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
	btfss	SYSINTEGERTEMPB_H,7,ACCESS
	bra	ENDIF123
	comf	SYSINTEGERTEMPB,F,ACCESS
	comf	SYSINTEGERTEMPB_H,F,ACCESS
	incf	SYSINTEGERTEMPB,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPB_H,F,ACCESS
ENDIF123
;Call word multiply routine
;SysMultSub16
	rcall	SYSMULTSUB16
;Negate result if necessary
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
	btfss	SYSSIGNBYTE,7,ACCESS
	bra	ENDIF124
	comf	SYSINTEGERTEMPX,F,ACCESS
	comf	SYSINTEGERTEMPX_H,F,ACCESS
	incf	SYSINTEGERTEMPX,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPX_H,F,ACCESS
ENDIF124
	return

;********************************************************************************

;Source: system.h (1240)
SYSREADSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Get length
;TBLRD*+
	tblrd*+
;movff TABLAT,SysCalcTempA
	movffl	TABLAT,SYSCALCTEMPA
;movff TABLAT,INDF1
	movffl	TABLAT,INDF1
;goto SysStringReadCheck
	bra	SYSSTRINGREADCHECK
SYSREADSTRINGPART
;TBLRD*+
	tblrd*+
;movf TABLAT, W
	movf	TABLAT, W,ACCESS
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA,ACCESS
;addwf SysStringLength,F
	addwf	SYSSTRINGLENGTH,F,ACCESS
;Check length
SYSSTRINGREADCHECK
;If length is 0, exit
;movf SysCalcTempA,F
	movf	SYSCALCTEMPA,F,ACCESS
;btfsc STATUS,Z
	btfsc	STATUS,Z,ACCESS
;return
	return
;Copy
SYSSTRINGREAD
;Copy char
;TBLRD*+
	tblrd*+
;movff TABLAT,PREINC1
	movffl	TABLAT,PREINC1
;decfsz SysCalcTempA, F
	decfsz	SYSCALCTEMPA, F,ACCESS
;goto SysStringRead
	bra	SYSSTRINGREAD
	return

;********************************************************************************

SysStringTables

StringTable1
	db	15,49,67,97,115,111,32,80,114,111,98,97,98,105,108,101


StringTable2
	db	14,112,101,114,99,104,101,32,108,97,32,114,101,108,97


StringTable3
	db	13,122,105,111,110,101,32,110,111,110,32,101,114,97


StringTable4
	db	12,97,116,116,101,110,100,105,98,105,108,101,46


StringTable5
	db	12,67,111,109,117,110,113,117,101,32,108,97,32


StringTable6
	db	14,110,117,111,118,97,32,118,101,114,115,105,111,110,101


StringTable7
	db	14,100,97,114,97,32,114,105,115,117,108,116,97,116,105


StringTable8
	db	9,109,105,103,108,105,111,114,105,63


StringTable9
	db	13,83,101,99,111,110,100,97,32,80,97,114,116,101


StringTable10
	db	13,100,101,108,108,111,32,115,99,104,101,114,109,111


StringTable11
	db	13,99,111,110,32,117,110,32,98,117,102,102,101,114


StringTable12
	db	15,114,105,100,111,116,116,111,46,32,83,105,32,112,117,111


StringTable13
	db	15,97,110,99,104,101,32,100,105,115,101,103,110,97,114,101


StringTable14
	db	16,102,105,103,46,32,103,101,111,109,101,116,114,105,99,104,101


StringTable15
	db	10,49,46,70,105,114,115,116,32,76,110


StringTable16
	db	11,50,46,83,101,99,111,110,100,32,76,110


StringTable17
	db	0


StringTable18
	db	10,52,46,70,111,114,116,104,32,76,110


StringTable19
	db	2,53,46


StringTable20
	db	8,70,105,102,116,104,32,76,110


StringTable21
	db	10,54,46,83,105,120,116,104,32,76,110


StringTable22
	db	9,46,84,104,105,114,100,32,76,110


StringTable23
	db	14,67,97,115,111,32,80,114,111,98,97,98,105,108,101


StringTable24
	db	14,112,101,114,99,104,233,32,108,97,32,114,101,108,97


StringTable25
	db	14,100,97,114,224,32,114,105,115,117,108,116,97,116,105


StringTable26
	db	15,114,105,100,111,116,116,111,46,32,83,105,32,112,117,242


StringTable27
	db	21,79,76,68,32,70,79,78,84,32,87,73,76,76,32,69,82,82,79,82,33,33


StringTable28
	db	10,45,87,97,118,101,83,104,97,114,101


StringTable29
	db	12,82,101,99,116,97,110,103,108,101,46,46,49


StringTable30
	db	12,82,101,99,116,97,110,103,108,101,46,46,50


StringTable31
	db	9,72,121,112,101,114,98,111,108,101


StringTable77
	db	1,32


;********************************************************************************


 END
