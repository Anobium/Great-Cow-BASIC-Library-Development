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
CMD	EQU	45
COL	EQU	46
COLOR	EQU	47
COLOR_H	EQU	48
COL_T6963	EQU	49
COL_T6963_H	EQU	50
CURRCHARCOL	EQU	51
CURRCHARROW	EQU	52
CURRCHARVAL	EQU	53
CURRCOL	EQU	54
CURRCOL_H	EQU	55
CURRENT_GRH_HOME_ADDR	EQU	56
CURRENT_GRH_HOME_ADDR_H	EQU	57
CURRENT_TEXT_HOME_ADDR	EQU	58
CURRENT_TEXT_HOME_ADDR_H	EQU	59
DEFAULTDISPLAYMODESTATE_T6963	EQU	60
DELAYTEMP	EQU	112
DELAYTEMP2	EQU	113
DRAWLINE	EQU	61
DRAWLINE_H	EQU	62
GLCDBACKGROUND	EQU	63
GLCDBACKGROUND_H	EQU	64
GLCDCOLOUR	EQU	65
GLCDCOLOUR_H	EQU	66
GLCDDEVICEHEIGHT	EQU	67
GLCDDEVICEHEIGHT_H	EQU	68
GLCDDEVICEWIDTH	EQU	69
GLCDDEVICEWIDTH_H	EQU	70
GLCDFNTDEFAULT	EQU	71
GLCDFNTDEFAULTSIZE	EQU	72
GLCDFONTWIDTH	EQU	73
GLCDFOREGROUND	EQU	74
GLCDFOREGROUND_H	EQU	75
GLCDPRINTLEN	EQU	76
GLCDPRINTLOC	EQU	77
GLCDPRINTLOC_H	EQU	78
GLCDPRINT_STRING_COUNTER	EQU	79
GLCDROTATESTATE	EQU	80
GLCDTEMP	EQU	81
GLCDTEMP_H	EQU	82
GLCDX	EQU	83
GLCDXPOS	EQU	85
GLCDX_H	EQU	84
GLCDY	EQU	86
GLCDYPOS	EQU	88
GLCDY_H	EQU	87
GLCD_YORDINATE	EQU	89
GLCD_YORDINATE_H	EQU	90
HCOUNT	EQU	91
LCDBYTE	EQU	92
LCDCMDBYTE	EQU	93
LCDCOLUMN	EQU	94
LCDDATABYTE	EQU	95
LCDDATAWORD	EQU	96
LCDDATAWORD_H	EQU	97
LCDLINE	EQU	98
LCD_STATE	EQU	99
LINECOLOUR	EQU	100
LINECOLOUR_H	EQU	101
LINEX1	EQU	102
LINEX1_H	EQU	103
LINEX2	EQU	104
LINEX2_H	EQU	105
LINEY1	EQU	106
LINEY1_H	EQU	107
LINEY2	EQU	108
LINEY2_H	EQU	109
LOCX	EQU	110
LOCX_H	EQU	111
LOCY	EQU	160
LOCY_H	EQU	161
MAXHEIGHT	EQU	162
OBJHEIGHT	EQU	163
OBJWIDTH	EQU	164
OLDGLCDXPOS	EQU	165
ONPAGEBOUNDARY	EQU	166
OPTMISEGLCDDRAW	EQU	167
PRINTLEN	EQU	168
PRINTLOCX	EQU	169
PRINTLOCX_H	EQU	170
PRINTLOCY	EQU	171
PRINTLOCY_H	EQU	172
ROW	EQU	173
ROW_T6963	EQU	174
ROW_T6963_H	EQU	175
SELECTEDTABLE	EQU	176
SELECTEDTABLE_H	EQU	177
STRINGPOINTER	EQU	178
SYSBYTETEMPA	EQU	117
SYSBYTETEMPB	EQU	121
SYSBYTETEMPX	EQU	112
SYSCALCTEMPA	EQU	117
SYSDIVLOOP	EQU	116
SYSDIVMULTA	EQU	119
SYSDIVMULTA_H	EQU	120
SYSDIVMULTB	EQU	123
SYSDIVMULTB_H	EQU	124
SYSDIVMULTX	EQU	114
SYSDIVMULTX_H	EQU	115
SYSLCDPRINTDATAHANDLER	EQU	179
SYSLCDPRINTDATAHANDLER_H	EQU	180
SYSLCDTEMP	EQU	181
SYSPRINTDATAHANDLER	EQU	182
SYSPRINTDATAHANDLER_H	EQU	183
SYSPRINTTEMP	EQU	184
SYSSTRINGA	EQU	119
SYSSTRINGA_H	EQU	120
SYSSTRINGLENGTH	EQU	118
SYSSTRINGPARAM1	EQU	9183
SYSTEMP1	EQU	185
SYSTEMP1_H	EQU	186
SYSTEMP2	EQU	187
SYSTEMP2_H	EQU	188
SYSTEMP3	EQU	189
SYSTEMP3_H	EQU	190
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
TABLEREADPOSITION	EQU	191
TABLEREADPOSITION_H	EQU	192
WBYTE	EQU	193
WHOLEYBYTES	EQU	194
WIDTHCOUNT	EQU	195

;********************************************************************************

;Alias variables
AFSR0	EQU	4
AFSR0_H	EQU	5

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
;wait 3 s
	movlw	3
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
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
;GLCDPrint( 0, 50, "BMP load" )
	banksel	PRINTLOCX
	clrf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	50
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable3
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable3) | 128
	movwf	SysLCDPRINTDATAHandler_H
	banksel	STATUS
	pagesel	GLCDPRINT5
	call	GLCDPRINT5
	pagesel	$
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;----- Variables
;OptmiseGLCDDraw  = 0            ; either 0 or 1.  Needs to match the background pixel state. Makes drawing faster.
	banksel	OPTMISEGLCDDRAW
	clrf	OPTMISEGLCDDRAW
;These must be WORDs as this is required to handle large tables.
;Dim TableReadPosition, TableLen,SelectedTable as word
;Dim OPTMISEGLCDDRAW, OBJWIDTH, OBJHEIGHT, OLDGLCDXPOS, WHOLEYBYTES, HCOUNT, GLCDY, WIDTHCOUNT, WBYTE, ONPAGEBOUNDARY, GLCDX, CURRPAGE, CURRPAGE, MAXHEIGHT, CURRCHARROW, WBYTE as Byte
;----- Quick Command Reference:
;You should then do the following.
;Replace the existing table data with your data BMP to a table.
;You can define five BMP as a table.
;Pick any of the five tables.  YOU MUST RETAIN THE GCLDTABLEn NAMING CONVENTION
;Then, so, you can easily remember the name of you BMP use a define
;Then, call the subroutine, an example GLCDBMPLoad ( 0, 0, Anobium  )
;#define Anobium      @GLCDTable1
;#define GCB          @GLCDTable2
;#define Another1     @GLCDTable3
;#define Another2     @GLCDTable4
;#define Another3     @GLCDTable5
;----- Main body of program commences here.
;GLCDCLS
	banksel	STATUS
	pagesel	GLCDCLS_T6963
	call	GLCDCLS_T6963
	pagesel	$
;GLCDBMPLoad ( 150, 0, Anobium  )
	movlw	150
	movwf	GLCDXPOS
	clrf	GLCDYPOS
	movlw	low(GLCDTABLE1)
	banksel	SELECTEDTABLE
	movwf	SELECTEDTABLE
	movlw	high(GLCDTABLE1)
	movwf	SELECTEDTABLE_H
	banksel	STATUS
	call	GLCDBMPLOAD
;wait 750 ms
	movlw	238
	movwf	SysWaitTempMS
	movlw	2
	movwf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;GLCDBMPLoad ( 0, 0, GCB )
	clrf	GLCDXPOS
	clrf	GLCDYPOS
	movlw	low(GLCDTABLE2)
	banksel	SELECTEDTABLE
	movwf	SELECTEDTABLE
	movlw	high(GLCDTABLE2)
	movwf	SELECTEDTABLE_H
	banksel	STATUS
	call	GLCDBMPLOAD
;box 0, 0, 239, 63
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
	movf	GLCDFOREGROUND,W
	movwf	LINECOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	LINECOLOUR_H
	pagesel	BOX
	call	BOX
	pagesel	$
;wait 750 ms
	movlw	238
	movwf	SysWaitTempMS
	movlw	2
	movwf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;do forever
SysDoLoop_S1
;SelectGLCDPage ( GLCDPage1_T6963 )
	movlw	79
	movwf	ADDR
	movlw	74
	movwf	ADDR_H
	pagesel	SELECTGLCDPAGE_T6963
	call	SELECTGLCDPAGE_T6963
;GLCDCLSCLS
	pagesel	GLCDCLSCLS
	call	GLCDCLSCLS
	pagesel	$
;BigPrint ( 0, 0, "Page 1")
	banksel	PRINTLOCX
	clrf	PRINTLOCX
	clrf	PRINTLOCX_H
	clrf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable4
	movwf	SysStringA
	movlw	(high StringTable4) & 127
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
;locate 7,1
	movlw	7
	movwf	LCDLINE
	movlw	1
	movwf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;print "GLCD methods used to create page"
	movlw	low StringTable5
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable5) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
;GLCDCLSCLS
	pagesel	GLCDCLSCLS
	call	GLCDCLSCLS
	pagesel	$
;SelectGLCDPage ( GLCDPage0_T6963 )
	movlw	255
	movwf	ADDR
	movlw	63
	movwf	ADDR_H
	pagesel	SELECTGLCDPAGE_T6963
	call	SELECTGLCDPAGE_T6963
	pagesel	$
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;loop
	goto	SysDoLoop_S1
SysDoLoop_E1
;end
	goto	BASPROGRAMEND
;----- Support methods.  Subroutines and Functions
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

GLCDBMPLOAD
;Start of code
;TableReadPosition = 1
	movlw	1
	banksel	TABLEREADPOSITION
	movwf	TABLEREADPOSITION
	clrf	TABLEREADPOSITION_H
;Read selected table
;Select Case SelectedTable
;Case @GLCDTable1: ReadTable GLCDTable1, TableReadPosition, objwidth
SysSelect1Case1
	movf	SELECTEDTABLE,W
	movwf	SysWORDTempA
	movf	SELECTEDTABLE_H,W
	movwf	SysWORDTempA_H
	movlw	low(GLCDTABLE1)
	movwf	SysWORDTempB
	movlw	high(GLCDTABLE1)
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	SysSelect1Case2
	banksel	TABLEREADPOSITION
	movf	TABLEREADPOSITION,W
	movwf	SYSSTRINGA
	movf	TABLEREADPOSITION_H,W
	movwf	SYSSTRINGA_H
	banksel	STATUS
	pagesel	GLCDTABLE1
	call	GLCDTABLE1
	pagesel	$
	banksel	OBJWIDTH
	movwf	OBJWIDTH
;TableReadPosition++
	incf	TABLEREADPOSITION,F
	btfsc	STATUS,Z
	incf	TABLEREADPOSITION_H,F
;ReadTable GLCDTable1, TableReadPosition, objHeight
	movf	TABLEREADPOSITION,W
	movwf	SYSSTRINGA
	movf	TABLEREADPOSITION_H,W
	movwf	SYSSTRINGA_H
	banksel	STATUS
	pagesel	GLCDTABLE1
	call	GLCDTABLE1
	pagesel	$
	banksel	OBJHEIGHT
	movwf	OBJHEIGHT
;Case @GLCDTable2: ReadTable GLCDTable2, TableReadPosition, objwidth
	goto	SysSelectEnd1
SysSelect1Case2
	banksel	SELECTEDTABLE
	movf	SELECTEDTABLE,W
	movwf	SysWORDTempA
	movf	SELECTEDTABLE_H,W
	movwf	SysWORDTempA_H
	movlw	low(GLCDTABLE2)
	movwf	SysWORDTempB
	movlw	high(GLCDTABLE2)
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	SysSelect1Case3
	banksel	TABLEREADPOSITION
	movf	TABLEREADPOSITION,W
	movwf	SYSSTRINGA
	movf	TABLEREADPOSITION_H,W
	movwf	SYSSTRINGA_H
	banksel	STATUS
	call	GLCDTABLE2
	banksel	OBJWIDTH
	movwf	OBJWIDTH
;TableReadPosition++
	incf	TABLEREADPOSITION,F
	btfsc	STATUS,Z
	incf	TABLEREADPOSITION_H,F
;ReadTable GLCDTable2, TableReadPosition, objHeight
	movf	TABLEREADPOSITION,W
	movwf	SYSSTRINGA
	movf	TABLEREADPOSITION_H,W
	movwf	SYSSTRINGA_H
	banksel	STATUS
	call	GLCDTABLE2
	banksel	OBJHEIGHT
	movwf	OBJHEIGHT
;Case @GLCDTable3: ReadTable GLCDTable3, TableReadPosition, objwidth
	goto	SysSelectEnd1
SysSelect1Case3
	banksel	SELECTEDTABLE
	movf	SELECTEDTABLE,W
	movwf	SysWORDTempA
	movf	SELECTEDTABLE_H,W
	movwf	SysWORDTempA_H
	movlw	low(GLCDTABLE3)
	movwf	SysWORDTempB
	movlw	high(GLCDTABLE3)
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	SysSelect1Case4
	banksel	TABLEREADPOSITION
	movf	TABLEREADPOSITION,W
	movwf	SYSSTRINGA
	banksel	STATUS
	call	GLCDTABLE3
	banksel	OBJWIDTH
	movwf	OBJWIDTH
;TableReadPosition++
	incf	TABLEREADPOSITION,F
	btfsc	STATUS,Z
	incf	TABLEREADPOSITION_H,F
;ReadTable GLCDTable3, TableReadPosition, objHeight
	movf	TABLEREADPOSITION,W
	movwf	SYSSTRINGA
	banksel	STATUS
	call	GLCDTABLE3
	banksel	OBJHEIGHT
	movwf	OBJHEIGHT
;Case @GLCDTable4: ReadTable GLCDTable4, TableReadPosition, objwidth
	goto	SysSelectEnd1
SysSelect1Case4
	banksel	SELECTEDTABLE
	movf	SELECTEDTABLE,W
	movwf	SysWORDTempA
	movf	SELECTEDTABLE_H,W
	movwf	SysWORDTempA_H
	movlw	low(GLCDTABLE4)
	movwf	SysWORDTempB
	movlw	high(GLCDTABLE4)
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	SysSelect1Case5
	banksel	TABLEREADPOSITION
	movf	TABLEREADPOSITION,W
	movwf	SYSSTRINGA
	banksel	STATUS
	pagesel	GLCDTABLE4
	call	GLCDTABLE4
	pagesel	$
	banksel	OBJWIDTH
	movwf	OBJWIDTH
;TableReadPosition++
	incf	TABLEREADPOSITION,F
	btfsc	STATUS,Z
	incf	TABLEREADPOSITION_H,F
;ReadTable GLCDTable4, TableReadPosition, objHeight
	movf	TABLEREADPOSITION,W
	movwf	SYSSTRINGA
	banksel	STATUS
	pagesel	GLCDTABLE4
	call	GLCDTABLE4
	pagesel	$
	banksel	OBJHEIGHT
	movwf	OBJHEIGHT
;Case @GLCDTable5: ReadTable GLCDTable5, TableReadPosition, objwidth
	goto	SysSelectEnd1
SysSelect1Case5
	banksel	SELECTEDTABLE
	movf	SELECTEDTABLE,W
	movwf	SysWORDTempA
	movf	SELECTEDTABLE_H,W
	movwf	SysWORDTempA_H
	movlw	low(GLCDTABLE5)
	movwf	SysWORDTempB
	movlw	high(GLCDTABLE5)
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	SysSelectEnd1
	banksel	TABLEREADPOSITION
	movf	TABLEREADPOSITION,W
	movwf	SYSSTRINGA
	banksel	STATUS
	pagesel	GLCDTABLE5
	call	GLCDTABLE5
	pagesel	$
	banksel	OBJWIDTH
	movwf	OBJWIDTH
;TableReadPosition++
	incf	TABLEREADPOSITION,F
	btfsc	STATUS,Z
	incf	TABLEREADPOSITION_H,F
;ReadTable GLCDTable5, TableReadPosition, objHeight
	movf	TABLEREADPOSITION,W
	movwf	SYSSTRINGA
	banksel	STATUS
	pagesel	GLCDTABLE5
	call	GLCDTABLE5
	pagesel	$
	banksel	OBJHEIGHT
	movwf	OBJHEIGHT
;End Select
SysSelectEnd1
;oldGLCDXPos = GLCDXPos
	banksel	GLCDXPOS
	movf	GLCDXPOS,W
	banksel	OLDGLCDXPOS
	movwf	OLDGLCDXPOS
;TableReadPosition = 3
	movlw	3
	movwf	TABLEREADPOSITION
	clrf	TABLEREADPOSITION_H
;WholeYBytes = objHeight /  8               ; Number of whole bytes within Y Axis.  This is integer maths!
	movf	OBJHEIGHT,W
	movwf	SysBYTETempA
	movlw	8
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SysDivSub
	call	SysDivSub
	pagesel	$
	movf	SysBYTETempA,W
	banksel	WHOLEYBYTES
	movwf	WHOLEYBYTES
;onPageBoundary = ( GLCDYPos % 8 ) = 0      ; If GLCDYPos as a memory page boundary.  Used to fast write the byte
	banksel	GLCDYPOS
	movf	GLCDYPOS,W
	movwf	SysBYTETempA
	movlw	8
	movwf	SysBYTETempB
	pagesel	SysDivSub
	call	SysDivSub
	pagesel	$
	movf	SysBYTETempX,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	movwf	SysBYTETempA
	clrf	SysBYTETempB
	banksel	STATUS
	pagesel	SysCompEqual
	call	SysCompEqual
	pagesel	$
	movf	SysByteTempX,W
	banksel	ONPAGEBOUNDARY
	movwf	ONPAGEBOUNDARY
;if WholeYBytes <> 0 then
	movf	WHOLEYBYTES,F
	btfsc	STATUS, Z
	goto	ENDIF1
;for hCount = 0 to (WholeYBytes - 1)  ; counter to number of whole bytes
	movlw	255
	banksel	HCOUNT
	movwf	HCOUNT
	banksel	WHOLEYBYTES
	decf	WHOLEYBYTES,W
	movwf	SysTemp1
	clrf	SysBYTETempB
	movf	SysTemp1,W
	movwf	SysBYTETempA
	banksel	STATUS
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd1
ENDIF3
SysForLoop1
	incf	HCOUNT,F
;it is safe to use GLCDY and X here as PSET is not called when this is used as a variable
;GLCDY = GLCDYPos+hCount
	movf	HCOUNT,W
	addwf	GLCDYPOS,W
	movwf	GLCDY
;for widthCount = 0 to (objwidth - 1)  ; increment thru bytes horizontally
	movlw	255
	banksel	WIDTHCOUNT
	movwf	WIDTHCOUNT
	decf	OBJWIDTH,W
	movwf	SysTemp1
	clrf	SysBYTETempB
	movf	SysTemp1,W
	movwf	SysBYTETempA
	banksel	STATUS
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd2
ENDIF4
SysForLoop2
	banksel	WIDTHCOUNT
	incf	WIDTHCOUNT,F
;Read selected table
;Select Case SelectedTable
;Case @GLCDTable1: ReadTable GLCDTable1, TableReadPosition, wByte
SysSelect2Case1
	movf	SELECTEDTABLE,W
	movwf	SysWORDTempA
	movf	SELECTEDTABLE_H,W
	movwf	SysWORDTempA_H
	movlw	low(GLCDTABLE1)
	movwf	SysWORDTempB
	movlw	high(GLCDTABLE1)
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	SysSelect2Case2
	banksel	TABLEREADPOSITION
	movf	TABLEREADPOSITION,W
	movwf	SYSSTRINGA
	movf	TABLEREADPOSITION_H,W
	movwf	SYSSTRINGA_H
	banksel	STATUS
	pagesel	GLCDTABLE1
	call	GLCDTABLE1
	pagesel	$
	banksel	WBYTE
	movwf	WBYTE
;Case @GLCDTable2: ReadTable GLCDTable2, TableReadPosition, wByte
	goto	SysSelectEnd2
SysSelect2Case2
	banksel	SELECTEDTABLE
	movf	SELECTEDTABLE,W
	movwf	SysWORDTempA
	movf	SELECTEDTABLE_H,W
	movwf	SysWORDTempA_H
	movlw	low(GLCDTABLE2)
	movwf	SysWORDTempB
	movlw	high(GLCDTABLE2)
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	SysSelect2Case3
	banksel	TABLEREADPOSITION
	movf	TABLEREADPOSITION,W
	movwf	SYSSTRINGA
	movf	TABLEREADPOSITION_H,W
	movwf	SYSSTRINGA_H
	banksel	STATUS
	call	GLCDTABLE2
	banksel	WBYTE
	movwf	WBYTE
;Case @GLCDTable3: ReadTable GLCDTable3, TableReadPosition, wByte
	goto	SysSelectEnd2
SysSelect2Case3
	banksel	SELECTEDTABLE
	movf	SELECTEDTABLE,W
	movwf	SysWORDTempA
	movf	SELECTEDTABLE_H,W
	movwf	SysWORDTempA_H
	movlw	low(GLCDTABLE3)
	movwf	SysWORDTempB
	movlw	high(GLCDTABLE3)
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	SysSelect2Case4
	banksel	TABLEREADPOSITION
	movf	TABLEREADPOSITION,W
	movwf	SYSSTRINGA
	banksel	STATUS
	call	GLCDTABLE3
	banksel	WBYTE
	movwf	WBYTE
;Case @GLCDTable4: ReadTable GLCDTable4, TableReadPosition, wByte
	goto	SysSelectEnd2
SysSelect2Case4
	banksel	SELECTEDTABLE
	movf	SELECTEDTABLE,W
	movwf	SysWORDTempA
	movf	SELECTEDTABLE_H,W
	movwf	SysWORDTempA_H
	movlw	low(GLCDTABLE4)
	movwf	SysWORDTempB
	movlw	high(GLCDTABLE4)
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	SysSelect2Case5
	banksel	TABLEREADPOSITION
	movf	TABLEREADPOSITION,W
	movwf	SYSSTRINGA
	banksel	STATUS
	pagesel	GLCDTABLE4
	call	GLCDTABLE4
	pagesel	$
	banksel	WBYTE
	movwf	WBYTE
;Case @GLCDTable5: ReadTable GLCDTable5, TableReadPosition, wByte
	goto	SysSelectEnd2
SysSelect2Case5
	banksel	SELECTEDTABLE
	movf	SELECTEDTABLE,W
	movwf	SysWORDTempA
	movf	SELECTEDTABLE_H,W
	movwf	SysWORDTempA_H
	movlw	low(GLCDTABLE5)
	movwf	SysWORDTempB
	movlw	high(GLCDTABLE5)
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	SysSelectEnd2
	banksel	TABLEREADPOSITION
	movf	TABLEREADPOSITION,W
	movwf	SYSSTRINGA
	banksel	STATUS
	pagesel	GLCDTABLE5
	call	GLCDTABLE5
	pagesel	$
	banksel	WBYTE
	movwf	WBYTE
;End Select
SysSelectEnd2
;TableReadPosition++
	banksel	TABLEREADPOSITION
	incf	TABLEREADPOSITION,F
	btfsc	STATUS,Z
	incf	TABLEREADPOSITION_H,F
;if wByte <> OptmiseGLCDDraw then             ; if the incoming byte is the same as the background, dont draw
	movf	OPTMISEGLCDDRAW,W
	subwf	WBYTE,W
	btfsc	STATUS, Z
	goto	ENDIF5
;For CurrCharRow = 0 to 7
	movlw	255
	banksel	CURRCHARROW
	movwf	CURRCHARROW
SysForLoop3
	incf	CURRCHARROW,F
;If wByte.0 = 0 Then
	banksel	WBYTE
	btfsc	WBYTE,0
	goto	ELSE13_1
;PSet GLCDXPos+widthCount, CurrCharRow + GLCDYPos, GLCDBackground
	movf	WIDTHCOUNT,W
	banksel	GLCDXPOS
	addwf	GLCDXPOS,W
	movwf	GLCDX
	clrf	GLCDX_H
	btfsc	STATUS,C
	incf	GLCDX_H,F
	movf	GLCDYPOS,W
	addwf	CURRCHARROW,W
	movwf	GLCDY
	clrf	GLCDY_H
	btfsc	STATUS,C
	incf	GLCDY_H,F
	movf	GLCDBACKGROUND,W
	movwf	GLCDCOLOUR
	movf	GLCDBACKGROUND_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_T6963
	call	PSET_T6963
	pagesel	$
;Else
	goto	ENDIF13
ELSE13_1
;PSet GLCDXPos+widthCount, CurrCharRow + GLCDYPos, GLCDForeground
	movf	WIDTHCOUNT,W
	banksel	GLCDXPOS
	addwf	GLCDXPOS,W
	movwf	GLCDX
	clrf	GLCDX_H
	btfsc	STATUS,C
	incf	GLCDX_H,F
	movf	GLCDYPOS,W
	addwf	CURRCHARROW,W
	movwf	GLCDY
	clrf	GLCDY_H
	btfsc	STATUS,C
	incf	GLCDY_H,F
	movf	GLCDFOREGROUND,W
	movwf	GLCDCOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_T6963
	call	PSET_T6963
	pagesel	$
;End If
ENDIF13
;Rotate wByte Right
	banksel	WBYTE
	rrf	WBYTE,F
;Next
	movlw	7
	banksel	CURRCHARROW
	subwf	CURRCHARROW,W
	btfss	STATUS, C
	goto	SysForLoop3
ENDIF14
SysForLoopEnd3
;end if
ENDIF5
;next widthCount
	banksel	OBJWIDTH
	decf	OBJWIDTH,W
	movwf	SysTemp1
	movf	WIDTHCOUNT,W
	movwf	SysBYTETempA
	movf	SysTemp1,W
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop2
ENDIF6
SysForLoopEnd2
;GLCDXPos =  oldGLCDXPos
	banksel	OLDGLCDXPOS
	movf	OLDGLCDXPOS,W
	banksel	GLCDXPOS
	movwf	GLCDXPOS
;GLCDYPos = GLCDYPos + 8
	movlw	8
	addwf	GLCDYPOS,F
;next hCount
	banksel	WHOLEYBYTES
	decf	WHOLEYBYTES,W
	movwf	SysTemp1
	banksel	HCOUNT
	movf	HCOUNT,W
	movwf	SysBYTETempA
	banksel	SYSTEMP1
	movf	SysTemp1,W
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop1
ENDIF7
SysForLoopEnd1
;end if
ENDIF1
;maxHeight = objHeight % 8       ; calculate the remaining bits
	banksel	OBJHEIGHT
	movf	OBJHEIGHT,W
	movwf	SysBYTETempA
	movlw	8
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SysDivSub
	call	SysDivSub
	pagesel	$
	movf	SysBYTETempX,W
	banksel	MAXHEIGHT
	movwf	MAXHEIGHT
;writes and remaining bits, if any
;if maxHeight <> 0 then
	movf	MAXHEIGHT,F
	btfsc	STATUS, Z
	goto	ENDIF2
;for widthCount = 0 to objwidth - 1
	movlw	255
	movwf	WIDTHCOUNT
	decf	OBJWIDTH,W
	movwf	SysTemp1
	clrf	SysBYTETempB
	movf	SysTemp1,W
	movwf	SysBYTETempA
	banksel	STATUS
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd4
ENDIF8
SysForLoop4
	banksel	WIDTHCOUNT
	incf	WIDTHCOUNT,F
;Read selected table
;Select Case SelectedTable
;Case @GLCDTable1: ReadTable GLCDTable1, TableReadPosition, wByte
SysSelect3Case1
	movf	SELECTEDTABLE,W
	movwf	SysWORDTempA
	movf	SELECTEDTABLE_H,W
	movwf	SysWORDTempA_H
	movlw	low(GLCDTABLE1)
	movwf	SysWORDTempB
	movlw	high(GLCDTABLE1)
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	SysSelect3Case2
	banksel	TABLEREADPOSITION
	movf	TABLEREADPOSITION,W
	movwf	SYSSTRINGA
	movf	TABLEREADPOSITION_H,W
	movwf	SYSSTRINGA_H
	banksel	STATUS
	pagesel	GLCDTABLE1
	call	GLCDTABLE1
	pagesel	$
	banksel	WBYTE
	movwf	WBYTE
;Case @GLCDTable2: ReadTable GLCDTable2, TableReadPosition, wByte
	goto	SysSelectEnd3
SysSelect3Case2
	banksel	SELECTEDTABLE
	movf	SELECTEDTABLE,W
	movwf	SysWORDTempA
	movf	SELECTEDTABLE_H,W
	movwf	SysWORDTempA_H
	movlw	low(GLCDTABLE2)
	movwf	SysWORDTempB
	movlw	high(GLCDTABLE2)
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	SysSelect3Case3
	banksel	TABLEREADPOSITION
	movf	TABLEREADPOSITION,W
	movwf	SYSSTRINGA
	movf	TABLEREADPOSITION_H,W
	movwf	SYSSTRINGA_H
	banksel	STATUS
	call	GLCDTABLE2
	banksel	WBYTE
	movwf	WBYTE
;Case @GLCDTable3: ReadTable GLCDTable3, TableReadPosition, wByte
	goto	SysSelectEnd3
SysSelect3Case3
	banksel	SELECTEDTABLE
	movf	SELECTEDTABLE,W
	movwf	SysWORDTempA
	movf	SELECTEDTABLE_H,W
	movwf	SysWORDTempA_H
	movlw	low(GLCDTABLE3)
	movwf	SysWORDTempB
	movlw	high(GLCDTABLE3)
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	SysSelect3Case4
	banksel	TABLEREADPOSITION
	movf	TABLEREADPOSITION,W
	movwf	SYSSTRINGA
	banksel	STATUS
	call	GLCDTABLE3
	banksel	WBYTE
	movwf	WBYTE
;Case @GLCDTable4: ReadTable GLCDTable4, TableReadPosition, wByte
	goto	SysSelectEnd3
SysSelect3Case4
	banksel	SELECTEDTABLE
	movf	SELECTEDTABLE,W
	movwf	SysWORDTempA
	movf	SELECTEDTABLE_H,W
	movwf	SysWORDTempA_H
	movlw	low(GLCDTABLE4)
	movwf	SysWORDTempB
	movlw	high(GLCDTABLE4)
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	SysSelect3Case5
	banksel	TABLEREADPOSITION
	movf	TABLEREADPOSITION,W
	movwf	SYSSTRINGA
	banksel	STATUS
	pagesel	GLCDTABLE4
	call	GLCDTABLE4
	pagesel	$
	banksel	WBYTE
	movwf	WBYTE
;Case @GLCDTable5: ReadTable GLCDTable5, TableReadPosition, wByte
	goto	SysSelectEnd3
SysSelect3Case5
	banksel	SELECTEDTABLE
	movf	SELECTEDTABLE,W
	movwf	SysWORDTempA
	movf	SELECTEDTABLE_H,W
	movwf	SysWORDTempA_H
	movlw	low(GLCDTABLE5)
	movwf	SysWORDTempB
	movlw	high(GLCDTABLE5)
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	SysSelectEnd3
	banksel	TABLEREADPOSITION
	movf	TABLEREADPOSITION,W
	movwf	SYSSTRINGA
	banksel	STATUS
	pagesel	GLCDTABLE5
	call	GLCDTABLE5
	pagesel	$
	banksel	WBYTE
	movwf	WBYTE
;End Select
SysSelectEnd3
;TableReadPosition++
	banksel	TABLEREADPOSITION
	incf	TABLEREADPOSITION,F
	btfsc	STATUS,Z
	incf	TABLEREADPOSITION_H,F
;slow draw using X Y position and interate throught the bits
;For CurrCharRow = 0 to maxHeight-1
	movlw	255
	banksel	CURRCHARROW
	movwf	CURRCHARROW
	banksel	MAXHEIGHT
	decf	MAXHEIGHT,W
	movwf	SysTemp1
	clrf	SysBYTETempB
	movf	SysTemp1,W
	movwf	SysBYTETempA
	banksel	STATUS
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd5
ENDIF9
SysForLoop5
	incf	CURRCHARROW,F
;If wByte.0 = 0 Then
	banksel	WBYTE
	btfsc	WBYTE,0
	goto	ELSE10_1
;PSet GLCDXPos+widthCount, ( CurrCharRow + GLCDYPos ), GLCDBackground
	movf	WIDTHCOUNT,W
	banksel	GLCDXPOS
	addwf	GLCDXPOS,W
	movwf	GLCDX
	clrf	GLCDX_H
	btfsc	STATUS,C
	incf	GLCDX_H,F
	movf	GLCDYPOS,W
	addwf	CURRCHARROW,W
	movwf	GLCDY
	clrf	GLCDY_H
	btfsc	STATUS,C
	incf	GLCDY_H,F
	movf	GLCDBACKGROUND,W
	movwf	GLCDCOLOUR
	movf	GLCDBACKGROUND_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_T6963
	call	PSET_T6963
	pagesel	$
;Else
	goto	ENDIF10
ELSE10_1
;PSet GLCDXPos+widthCount, ( CurrCharRow + GLCDYPos ), GLCDForeground
	movf	WIDTHCOUNT,W
	banksel	GLCDXPOS
	addwf	GLCDXPOS,W
	movwf	GLCDX
	clrf	GLCDX_H
	btfsc	STATUS,C
	incf	GLCDX_H,F
	movf	GLCDYPOS,W
	addwf	CURRCHARROW,W
	movwf	GLCDY
	clrf	GLCDY_H
	btfsc	STATUS,C
	incf	GLCDY_H,F
	movf	GLCDFOREGROUND,W
	movwf	GLCDCOLOUR
	movf	GLCDFOREGROUND_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_T6963
	call	PSET_T6963
	pagesel	$
;End If
ENDIF10
;Rotate wByte Right
	banksel	WBYTE
	rrf	WBYTE,F
;Next
	decf	MAXHEIGHT,W
	movwf	SysTemp1
	banksel	CURRCHARROW
	movf	CURRCHARROW,W
	movwf	SysBYTETempA
	banksel	SYSTEMP1
	movf	SysTemp1,W
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop5
ENDIF11
SysForLoopEnd5
;next
	banksel	OBJWIDTH
	decf	OBJWIDTH,W
	movwf	SysTemp1
	movf	WIDTHCOUNT,W
	movwf	SysBYTETempA
	movf	SysTemp1,W
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop4
ENDIF12
SysForLoopEnd4
;end if
ENDIF2
	banksel	STATUS
	return

;********************************************************************************

GLCDTABLE2
	movf	SYSSTRINGA,W
	movwf	SysWORDTempA
	movf	SYSSTRINGA_H,W
	movwf	SysWORDTempA_H
	movlw	137
	movwf	SysWORDTempB
	movlw	2
	movwf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	retlw	0
	movf	SysStringA, W
	addlw	low TableGLCDTABLE2
	movwf	SysStringA
	movlw	(high TableGLCDTABLE2) & 127
	btfsc	STATUS, C
	addlw	1
	addwf	SysStringA_H, W
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableGLCDTABLE2
	retlw	162
	retlw	84
	retlw	63
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	32
	retlw	96
	retlw	192
	retlw	128
	retlw	128
	retlw	192
	retlw	224
	retlw	224
	retlw	224
	retlw	240
	retlw	184
	retlw	222
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
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	192
	retlw	224
	retlw	240
	retlw	248
	retlw	248
	retlw	248
	retlw	248
	retlw	248
	retlw	248
	retlw	248
	retlw	240
	retlw	240
	retlw	240
	retlw	240
	retlw	240
	retlw	224
	retlw	224
	retlw	224
	retlw	224
	retlw	224
	retlw	224
	retlw	224
	retlw	224
	retlw	224
	retlw	224
	retlw	224
	retlw	224
	retlw	224
	retlw	224
	retlw	224
	retlw	224
	retlw	224
	retlw	224
	retlw	240
	retlw	240
	retlw	240
	retlw	240
	retlw	240
	retlw	248
	retlw	248
	retlw	248
	retlw	248
	retlw	252
	retlw	252
	retlw	252
	retlw	252
	retlw	252
	retlw	252
	retlw	252
	retlw	252
	retlw	254
	retlw	254
	retlw	254
	retlw	254
	retlw	254
	retlw	254
	retlw	254
	retlw	254
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	241
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
	retlw	248
	retlw	254
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	127
	retlw	63
	retlw	63
	retlw	63
	retlw	63
	retlw	30
	retlw	12
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	224
	retlw	255
	retlw	7
	retlw	63
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	63
	retlw	63
	retlw	63
	retlw	25
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
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
	retlw	252
	retlw	255
	retlw	255
	retlw	0
	retlw	0
	retlw	1
	retlw	15
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	127
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	127
	retlw	127
	retlw	127
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	127
	retlw	63
	retlw	31
	retlw	15
	retlw	7
	retlw	3
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
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	128
	retlw	255
	retlw	255
	retlw	255
	retlw	31
	retlw	0
	retlw	0
	retlw	240
	retlw	252
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	255
	retlw	15
	retlw	31
	retlw	15
	retlw	7
	retlw	15
	retlw	1
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
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	255
	retlw	63
	retlw	15
	retlw	3
	retlw	0
	retlw	47
	retlw	255
	retlw	255
	retlw	255
	retlw	127
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
	retlw	0
	retlw	0
	retlw	0
	retlw	0
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
	retlw	3
	retlw	1
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	255
	retlw	255
	retlw	7
	retlw	1
	retlw	7
	retlw	31
	retlw	255
	retlw	255
	retlw	240
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
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	20
	retlw	31
	retlw	31
	retlw	31
	retlw	16
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	255
	retlw	255
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
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
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
	retlw	63
	retlw	127
	retlw	127
	retlw	120
	retlw	0
	retlw	0
	retlw	0
	retlw	3
	retlw	3
	retlw	7
	retlw	3
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
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
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

;********************************************************************************

GLCDTABLE3
	movlw	4
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableGLCDTABLE3
	movwf	SysStringA
	movlw	(high TableGLCDTABLE3) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableGLCDTABLE3
	retlw	3
	retlw	1
	retlw	0
	retlw	255

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
;Set Offset register
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
	pagesel	$
;Clear screen to current memory locations
;dim current_grh_home_addr as word
;current_grh_home_addr = GRH_HOME_ADDR
	movlw	255
	movwf	CURRENT_GRH_HOME_ADDR
	movlw	63
	movwf	CURRENT_GRH_HOME_ADDR_H
;GLCDCLS
	pagesel	GLCDCLS_T6963
	call	GLCDCLS_T6963
	pagesel	$
;dim current_text_home_addr as word
;current_text_home_addr = TEXT_HOME_ADDR
	clrf	CURRENT_TEXT_HOME_ADDR
	clrf	CURRENT_TEXT_HOME_ADDR_H
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

;Start of program memory page 1
	ORG	2048
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

DRAWBIGCHAR_ILI9486L
;dim Locx, Locy, CurrCol as Word
;if CharCode <=126 Then
	movf	CHARCODE,W
	sublw	126
	btfss	STATUS, C
	goto	ENDIF36
;CharCode -=32
	movlw	32
	subwf	CHARCODE,F
;Goto GCBBigTables
	goto	GCBBIGTABLES
;end if
ENDIF36
;if CharCode <=210 Then
	movf	CHARCODE,W
	sublw	210
	btfss	STATUS, C
	goto	ENDIF37
;CharCode -=33
	movlw	33
	subwf	CHARCODE,F
;Goto GCBBigTables
	goto	GCBBIGTABLES
;end if
ENDIF37
;if CharCode <= 250 Then
	movf	CHARCODE,W
	sublw	250
	btfss	STATUS, C
	goto	ENDIF38
;CharCode -=34
	movlw	34
	subwf	CHARCODE,F
;Goto GCBBigTables
	goto	GCBBIGTABLES
;end if
ENDIF38
GCBBIGTABLES
;For CurrCharCol = 1 to 24
	clrf	CURRCHARCOL
SysForLoop14
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
	goto	ENDIF39
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT32_41
	call	BIGFONT32_41
	pagesel	$
	movwf	CURRCHARVAL
ENDIF39
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
	goto	ENDIF40
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	call	BIGFONT42_51
	movwf	CURRCHARVAL
ENDIF40
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
	goto	ENDIF41
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT52_61
	call	BIGFONT52_61
	pagesel	$
	movwf	CURRCHARVAL
ENDIF41
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
	goto	ENDIF42
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT62_71
	call	BIGFONT62_71
	pagesel	$
	movwf	CURRCHARVAL
ENDIF42
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
	goto	ENDIF43
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	call	BIGFONT72_81
	movwf	CURRCHARVAL
ENDIF43
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
	goto	ENDIF44
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT82_91
	call	BIGFONT82_91
	pagesel	$
	movwf	CURRCHARVAL
ENDIF44
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
	goto	ENDIF45
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT92_101
	call	BIGFONT92_101
	pagesel	$
	movwf	CURRCHARVAL
ENDIF45
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
	goto	ENDIF46
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT102_111
	call	BIGFONT102_111
	pagesel	$
	movwf	CURRCHARVAL
ENDIF46
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
	goto	ENDIF47
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT112_121
	call	BIGFONT112_121
	pagesel	$
	movwf	CURRCHARVAL
ENDIF47
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
	goto	ENDIF48
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT122_126
	call	BIGFONT122_126
	pagesel	$
	movwf	CURRCHARVAL
ENDIF48
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
	goto	ENDIF49
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT193_202
	call	BIGFONT193_202
	pagesel	$
	movwf	CURRCHARVAL
ENDIF49
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
	goto	ENDIF50
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT203_212
	call	BIGFONT203_212
	pagesel	$
	movwf	CURRCHARVAL
ENDIF50
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
	goto	ENDIF51
	banksel	CURRCOL
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT213_216
	call	BIGFONT213_216
	pagesel	$
	movwf	CURRCHARVAL
ENDIF51
;if CurrCharVal=36 then CurrCharVal=33
	movlw	36
	banksel	CURRCHARVAL
	subwf	CURRCHARVAL,W
	btfss	STATUS, Z
	goto	ENDIF52
	movlw	33
	movwf	CURRCHARVAL
ENDIF52
;For CurrCharRow = 1 to 8
	clrf	CURRCHARROW
SysForLoop15
	incf	CURRCHARROW,F
;LocX=[word]CharLocX+CurrCharCol
	movf	CURRCHARCOL,W
	addwf	CHARLOCX,W
	movwf	LOCX
	movlw	0
	addwfc	CHARLOCX_H,W
	movwf	LOCX_H
;LocY=[Word]CharLocY+CurrCharRow
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
	goto	ENDIF53
;LocX= LocX - 12
	movlw	12
	subwf	LOCX,F
	movlw	0
	subwfb	LOCX_H,F
;LocY= LocY + 8
	movlw	8
	banksel	LOCY
	addwf	LOCY,F
	movlw	0
	addwfc	LOCY_H,F
;end if
ENDIF53
;if CurrCharVal.0=1 then
	banksel	CURRCHARVAL
	btfss	CURRCHARVAL,0
	goto	ENDIF54
;PSet LocX , LocY , Color
	movf	LOCX,W
	movwf	GLCDX
	movf	LOCX_H,W
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
ENDIF54
;Rotate CurrCharVal Right
	rrf	CURRCHARVAL,F
;Next
	movlw	8
	subwf	CURRCHARROW,W
	btfss	STATUS, C
	goto	SysForLoop15
ENDIF55
SysForLoopEnd15
;Next
	movlw	24
	subwf	CURRCHARCOL,W
	btfss	STATUS, C
	goto	SysForLoop14
ENDIF56
SysForLoopEnd14
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
	goto	ENDIF18
;Inverted Colours
;GLCDBackground = 1
	movlw	1
	movwf	GLCDBACKGROUND
	clrf	GLCDBACKGROUND_H
;GLCDForeground = 0
	clrf	GLCDFOREGROUND
	clrf	GLCDFOREGROUND_H
;end if
ENDIF18
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
	goto	ENDIF19
;CharLocY=CharLocY-1
	movlw	1
	banksel	CHARLOCY
	subwf	CHARLOCY,F
	movlw	0
	subwfb	CHARLOCY_H,F
;end if
ENDIF19
;For CurrCharCol = 1 to 5
	banksel	CURRCHARCOL
	clrf	CURRCHARCOL
SysForLoop7
	incf	CURRCHARCOL,F
;Select Case CurrCharCol
;Case 1: ReadTable GLCDCharCol3, CharCode, CurrCharVal
SysSelect4Case1
	decf	CURRCHARCOL,W
	btfss	STATUS, Z
	goto	SysSelect4Case2
	movf	CHARCODE,W
	movwf	SYSSTRINGA
	call	GLCDCHARCOL3
	movwf	CURRCHARVAL
;Case 2: ReadTable GLCDCharCol4, CharCode, CurrCharVal
	goto	SysSelectEnd4
SysSelect4Case2
	movlw	2
	subwf	CURRCHARCOL,W
	btfss	STATUS, Z
	goto	SysSelect4Case3
	movf	CHARCODE,W
	movwf	SYSSTRINGA
	pagesel	GLCDCHARCOL4
	call	GLCDCHARCOL4
	pagesel	$
	movwf	CURRCHARVAL
;Case 3: ReadTable GLCDCharCol5, CharCode, CurrCharVal
	goto	SysSelectEnd4
SysSelect4Case3
	movlw	3
	subwf	CURRCHARCOL,W
	btfss	STATUS, Z
	goto	SysSelect4Case4
	movf	CHARCODE,W
	movwf	SYSSTRINGA
	pagesel	GLCDCHARCOL5
	call	GLCDCHARCOL5
	pagesel	$
	movwf	CURRCHARVAL
;Case 4: ReadTable GLCDCharCol6, CharCode, CurrCharVal
	goto	SysSelectEnd4
SysSelect4Case4
	movlw	4
	subwf	CURRCHARCOL,W
	btfss	STATUS, Z
	goto	SysSelect4Case5
	movf	CHARCODE,W
	movwf	SYSSTRINGA
	pagesel	GLCDCHARCOL6
	call	GLCDCHARCOL6
	pagesel	$
	movwf	CURRCHARVAL
;Case 5: ReadTable GLCDCharCol7, CharCode, CurrCharVal
	goto	SysSelectEnd4
SysSelect4Case5
	movlw	5
	subwf	CURRCHARCOL,W
	btfss	STATUS, Z
	goto	SysSelectEnd4
	movf	CHARCODE,W
	movwf	SYSSTRINGA
	pagesel	GLCDCHARCOL7
	call	GLCDCHARCOL7
	pagesel	$
	movwf	CURRCHARVAL
;End Select
SysSelectEnd4
;CharRow=0
	clrf	CHARROW
	clrf	CHARROW_H
;For CurrCharRow = 1 to 8
	clrf	CURRCHARROW
SysForLoop8
	incf	CURRCHARROW,F
;CharColS=0
	clrf	CHARCOLS
;For Col=1 to GLCDfntDefaultsize
	clrf	COL
	movlw	1
	subwf	GLCDFNTDEFAULTSIZE,W
	btfss	STATUS, C
	goto	SysForLoopEnd9
ENDIF20
SysForLoop9
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
	goto	SysForLoopEnd10
ENDIF21
SysForLoop10
	banksel	ROW
	incf	ROW,F
;if CurrCharVal.0=1 then
	banksel	CURRCHARVAL
	btfss	CURRCHARVAL,0
	goto	ELSE22_1
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
	goto	ENDIF22
ELSE22_1
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
ENDIF22
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
	goto	SysForLoop10
ENDIF23
SysForLoopEnd10
;CharColS +=1
	banksel	CHARCOLS
	incf	CHARCOLS,F
;Next Col
	movf	GLCDFNTDEFAULTSIZE,W
	subwf	COL,W
	btfss	STATUS, C
	goto	SysForLoop9
ENDIF24
SysForLoopEnd9
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
	goto	SysForLoop8
ENDIF25
SysForLoopEnd8
;CharCol +=GLCDfntDefaultsize
	movf	GLCDFNTDEFAULTSIZE,W
	addwf	CHARCOL,F
	movlw	0
	addwfc	CHARCOL_H,F
;Next
	movlw	5
	subwf	CURRCHARCOL,W
	btfss	STATUS, C
	goto	SysForLoop7
ENDIF26
SysForLoopEnd7
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
	banksel	SYSTEMP2
	clrf	SysTemp2
	banksel	PORTD
	btfss	PORTD,3
	goto	ENDIF70
	banksel	SYSTEMP2
	incf	SysTemp2,F
ENDIF70
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

GLCDTABLE1
	movf	SYSSTRINGA,W
	movwf	SysWORDTempA
	movf	SYSSTRINGA_H,W
	movwf	SysWORDTempA_H
	movlw	227
	movwf	SysWORDTempB
	movlw	1
	movwf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	retlw	0
	movf	SysStringA, W
	addlw	low TableGLCDTABLE1
	movwf	SysStringA
	movlw	(high TableGLCDTABLE1) & 127
	btfsc	STATUS, C
	addlw	1
	addwf	SysStringA_H, W
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableGLCDTABLE1
	retlw	226
	retlw	60
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
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
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
	retlw	224
	retlw	0
	retlw	192
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
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
	retlw	192
	retlw	176
	retlw	96
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
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
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
	retlw	112
	retlw	222
	retlw	115
	retlw	28
	retlw	7
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
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	1
	retlw	1
	retlw	3
	retlw	6
	retlw	13
	retlw	27
	retlw	62
	retlw	236
	retlw	24
	retlw	16
	retlw	16
	retlw	16
	retlw	24
	retlw	24
	retlw	8
	retlw	8
	retlw	12
	retlw	12
	retlw	12
	retlw	4
	retlw	4
	retlw	4
	retlw	6
	retlw	6
	retlw	2
	retlw	2
	retlw	2
	retlw	3
	retlw	3
	retlw	1
	retlw	1
	retlw	3
	retlw	15
	retlw	28
	retlw	112
	retlw	224
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
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
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
	retlw	7
	retlw	14
	retlw	56
	retlw	112
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
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	255
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
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
	retlw	99
	retlw	54
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
	retlw	0
	retlw	0
	retlw	7
	retlw	12
	retlw	8
	retlw	24
	retlw	16
	retlw	48
	retlw	48
	retlw	32
	retlw	96
	retlw	64
	retlw	192
	retlw	192
	retlw	128
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
	retlw	0
	retlw	0
	retlw	128
	retlw	192
	retlw	112
	retlw	56
	retlw	28
	retlw	14
	retlw	3
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
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	192
	retlw	32
	retlw	192
	retlw	0
	retlw	0
	retlw	0
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
	retlw	3
	retlw	3
	retlw	2
	retlw	6
	retlw	4
	retlw	12
	retlw	236
	retlw	8
	retlw	12
	retlw	6
	retlw	3
	retlw	1
	retlw	0
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
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
	retlw	0
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
	retlw	56
	retlw	22
	retlw	17
	retlw	16
	retlw	17
	retlw	22
	retlw	56
	retlw	192
	retlw	0
	retlw	255
	retlw	2
	retlw	1
	retlw	1
	retlw	1
	retlw	254
	retlw	0
	retlw	0
	retlw	126
	retlw	129
	retlw	129
	retlw	129
	retlw	129
	retlw	126
	retlw	0
	retlw	0
	retlw	255
	retlw	66
	retlw	129
	retlw	129
	retlw	129
	retlw	126
	retlw	0
	retlw	0
	retlw	255
	retlw	0
	retlw	0
	retlw	127
	retlw	128
	retlw	128
	retlw	128
	retlw	64
	retlw	255
	retlw	0
	retlw	0
	retlw	255
	retlw	2
	retlw	1
	retlw	1
	retlw	1
	retlw	254
	retlw	2
	retlw	1
	retlw	1
	retlw	1
	retlw	254

;********************************************************************************

;Start of program memory page 2
	ORG	4096
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

GLCDTABLE1_H
	movf	SYSSTRINGA,W
	movwf	SysWORDTempA
	movf	SYSSTRINGA_H,W
	movwf	SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	retlw	0
	movf	SysStringA, W
	addlw	low TableGLCDTABLE1_H
	movwf	SysStringA
	movlw	(high TableGLCDTABLE1_H) & 127
	btfsc	STATUS, C
	addlw	1
	addwf	SysStringA_H, W
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableGLCDTABLE1_H
	retlw	1

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

;Start of program memory page 3
	ORG	6144
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
	goto	ENDIF33
	banksel	STATUS
	return
ENDIF33
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
	goto	SysForLoopEnd13
ENDIF34
SysForLoop13
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
	goto	SysForLoop13
ENDIF35
SysForLoopEnd13
	banksel	STATUS
	return

;********************************************************************************

BOX
;dim GLCDTemp as word
;Make sure that starting point (1) is always less than end point (2)
;If LineX1 > LineX2 Then
	movf	LINEX1,W
	movwf	SysWORDTempB
	movf	LINEX1_H,W
	movwf	SysWORDTempB_H
	movf	LINEX2,W
	movwf	SysWORDTempA
	movf	LINEX2_H,W
	movwf	SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0
	goto	ENDIF27
;GLCDTemp = LineX1
	movf	LINEX1,W
	movwf	GLCDTEMP
	movf	LINEX1_H,W
	movwf	GLCDTEMP_H
;LineX1 = LineX2
	movf	LINEX2,W
	movwf	LINEX1
	movf	LINEX2_H,W
	movwf	LINEX1_H
;LineX2 = GLCDTemp
	movf	GLCDTEMP,W
	movwf	LINEX2
	movf	GLCDTEMP_H,W
	movwf	LINEX2_H
;End If
ENDIF27
;If LineY1 > LineY2 Then
	movf	LINEY1,W
	movwf	SysWORDTempB
	movf	LINEY1_H,W
	movwf	SysWORDTempB_H
	movf	LINEY2,W
	movwf	SysWORDTempA
	movf	LINEY2_H,W
	movwf	SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0
	goto	ENDIF28
;GLCDTemp = LineY1
	movf	LINEY1,W
	movwf	GLCDTEMP
	movf	LINEY1_H,W
	movwf	GLCDTEMP_H
;LineY1 = LineY2
	movf	LINEY2,W
	movwf	LINEY1
	movf	LINEY2_H,W
	movwf	LINEY1_H
;LineY2 = GLCDTemp
	movf	GLCDTEMP,W
	movwf	LINEY2
	movf	GLCDTEMP_H,W
	movwf	LINEY2_H
;End If
ENDIF28
;dim DrawLine as word
;Draw lines going across
;For DrawLine = LineX1 To LineX2
	movlw	1
	subwf	LINEX1,W
	movwf	DRAWLINE
	movlw	0
	subwfb	LINEX1_H,W
	movwf	DRAWLINE_H
	movf	LINEX1,W
	movwf	SysWORDTempB
	movf	LINEX1_H,W
	movwf	SysWORDTempB_H
	movf	LINEX2,W
	movwf	SysWORDTempA
	movf	LINEX2_H,W
	movwf	SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd11
ENDIF29
SysForLoop11
	incf	DRAWLINE,F
	btfsc	STATUS,Z
	incf	DRAWLINE_H,F
;PSet DrawLine, LineY1, LineColour
	movf	DRAWLINE,W
	movwf	GLCDX
	movf	DRAWLINE_H,W
	movwf	GLCDX_H
	movf	LINEY1,W
	movwf	GLCDY
	movf	LINEY1_H,W
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	call	PSET_T6963
;PSet DrawLine, LineY2, LineColour
	movf	DRAWLINE,W
	movwf	GLCDX
	movf	DRAWLINE_H,W
	movwf	GLCDX_H
	movf	LINEY2,W
	movwf	GLCDY
	movf	LINEY2_H,W
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	call	PSET_T6963
;Next
	movf	DRAWLINE,W
	movwf	SysWORDTempA
	movf	DRAWLINE_H,W
	movwf	SysWORDTempA_H
	movf	LINEX2,W
	movwf	SysWORDTempB
	movf	LINEX2_H,W
	movwf	SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0
	goto	SysForLoop11
ENDIF30
SysForLoopEnd11
;Draw lines going down
;For DrawLine = LineY1 To LineY2
	movlw	1
	subwf	LINEY1,W
	movwf	DRAWLINE
	movlw	0
	subwfb	LINEY1_H,W
	movwf	DRAWLINE_H
	movf	LINEY1,W
	movwf	SysWORDTempB
	movf	LINEY1_H,W
	movwf	SysWORDTempB_H
	movf	LINEY2,W
	movwf	SysWORDTempA
	movf	LINEY2_H,W
	movwf	SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd12
ENDIF31
SysForLoop12
	incf	DRAWLINE,F
	btfsc	STATUS,Z
	incf	DRAWLINE_H,F
;PSet LineX1, DrawLine, LineColour
	movf	LINEX1,W
	movwf	GLCDX
	movf	LINEX1_H,W
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
;PSet LineX2, DrawLine, LineColour
	movf	LINEX2,W
	movwf	GLCDX
	movf	LINEX2_H,W
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
;Next
	movf	DRAWLINE,W
	movwf	SysWORDTempA
	movf	DRAWLINE_H,W
	movwf	SysWORDTempA_H
	movf	LINEY2,W
	movwf	SysWORDTempB
	movf	LINEY2_H,W
	movwf	SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0
	goto	SysForLoop12
ENDIF32
SysForLoopEnd12
	return

;********************************************************************************

CLS_T6963
;dim row_T6963, col_T6963 as word
;dim current_text_home_addr as word
;Set address pointer to address (TEXT_HOME_ADDR)
;GLCDCmdAddrSend_T6963(current_text_home_addr, ADDR_PTR_SET)
	movf	CURRENT_TEXT_HOME_ADDR,W
	movwf	LCDDATAWORD
	movf	CURRENT_TEXT_HOME_ADDR_H,W
	movwf	LCDDATAWORD_H
	movlw	36
	movwf	LCDCMDBYTE
	call	GLCDCMDADDRSEND_T6963
;Set Auto Write ON
;GLCDSendCommand_T6963(AUTO_WR_ON)
	movlw	176
	movwf	LCDCMDBYTE
	call	GLCDSENDCOMMAND_T6963
;row runs from 0 ... (MAX_ROW_PIXEL/8 -1), in form of a cell of (FontSize x 8) bits
;for  row_T6963 =  0 to ( MAX_ROW_PIXEL/8 ) -1
	movlw	255
	banksel	ROW_T6963
	movwf	ROW_T6963
	movwf	ROW_T6963_H
SysForLoop16
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
SysForLoop17
	incf	COL_T6963,F
	btfsc	STATUS,Z
	incf	COL_T6963_H,F
;GLCDispAutoDataWr_T6963 ( 0 )
	clrf	LCDDATABYTE
	call	GLCDISPAUTODATAWR_T6963
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
	goto	SysForLoop17
ENDIF61
SysForLoopEnd17
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
	call	SysCompLessThan16
	btfsc	SysByteTempX,0
	goto	SysForLoop16
ENDIF62
SysForLoopEnd16
;GLCDSendCommand_T6963(AUTO_WR_OFF)
	movlw	178
	movwf	LCDCMDBYTE
	call	GLCDSENDCOMMAND_T6963
;GLCDCmdAddrSend_T6963(current_text_home_addr,ADDR_PTR_SET)
	movf	CURRENT_TEXT_HOME_ADDR,W
	movwf	LCDDATAWORD
	movf	CURRENT_TEXT_HOME_ADDR_H,W
	movwf	LCDDATAWORD_H
	movlw	36
	movwf	LCDCMDBYTE
	call	GLCDCMDADDRSEND_T6963
;GLCDSendCommand_T6963(CURSOR_PTR_SET)
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
	banksel	SYSTEMP2
	clrf	SysTemp2
	banksel	PORTD
	btfss	PORTD,0
	goto	ENDIF68
	banksel	SYSTEMP2
	incf	SysTemp2,F
ENDIF68
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
	goto	ENDIF69
	banksel	SYSTEMP2
	incf	SysTemp2,F
ENDIF69
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

GLCDCLSCLS
;GLCDCLS
	call	GLCDCLS_T6963
;CLS
	goto	CLS_T6963

;********************************************************************************

GLCDCLS_T6963
;initialise global variable. Required variable for Circle in all DEVICE DRIVERS- DO NOT DELETE
;GLCD_yordinate = 0
	clrf	GLCD_YORDINATE
	clrf	GLCD_YORDINATE_H
;dim current_grh_home_addr as word
;dim row_T6963, col_T6963 as byte
;Set address pointer to address (GRH_HOME_ADDR)
;GLCDCmdAddrSend_T6963(current_grh_home_addr, ADDR_PTR_SET)
	movf	CURRENT_GRH_HOME_ADDR,W
	movwf	LCDDATAWORD
	movf	CURRENT_GRH_HOME_ADDR_H,W
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
SysForLoop18
	banksel	ROW_T6963
	incf	ROW_T6963,F
;write blank to clear screen the first page only, col = 0...(COLUMN-1)
;for col_T6963 = 0 to COLUMN - 1
	movlw	255
	banksel	COL_T6963
	movwf	COL_T6963
SysForLoop19
	incf	COL_T6963,F
;GLCDispAutoDataWr_T6963 ( 0x00 )
	clrf	LCDDATABYTE
	call	GLCDISPAUTODATAWR_T6963
;next
	movf	COL_T6963,W
	movwf	SysBYTETempA
	movlw	39
	movwf	SysBYTETempB
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop19
ENDIF65
SysForLoopEnd19
;next
	banksel	ROW_T6963
	movf	ROW_T6963,W
	movwf	SysBYTETempA
	movlw	63
	movwf	SysBYTETempB
	banksel	STATUS
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop18
ENDIF66
SysForLoopEnd18
;GLCDSendCommand_T6963(AUTO_WR_OFF)
	movlw	178
	movwf	LCDCMDBYTE
	call	GLCDSENDCOMMAND_T6963
;GLCDCmdAddrSend_T6963(current_grh_home_addr, ADDR_PTR_SET)
	movf	CURRENT_GRH_HOME_ADDR,W
	movwf	LCDDATAWORD
	movf	CURRENT_GRH_HOME_ADDR_H,W
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

GLCDISPAUTODATAWR_T6963
;GLCDispAutoWrChk_T6963
	pagesel	GLCDISPAUTOWRCHK_T6963
	call	GLCDISPAUTOWRCHK_T6963
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

;Overloaded signature: WORD:WORD:STRING:
GLCDPRINT5
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
ENDIF15
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
	goto	SysForLoopEnd6
ENDIF16
SysForLoop6
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
	goto	SysForLoop6
ENDIF17
SysForLoopEnd6
	return

;********************************************************************************

GLCDROTATE_T6963
;dim T6963_GLCD_HEIGHT, T6963_GLCD_WIDTH as word
;select case GLCDRotateState
;case LANDSCAPE   '0 degree
SysSelect6Case1
	decf	GLCDROTATESTATE,W
	btfss	STATUS, Z
	goto	SysSelect6Case2
;T6963_GLCD_WIDTH = GLCD_WIDTH
	movlw	240
	movwf	GLCDDEVICEWIDTH
	clrf	GLCDDEVICEWIDTH_H
;T6963_GLCD_HEIGHT = GLCD_HEIGHT
	movlw	64
	movwf	GLCDDEVICEHEIGHT
	clrf	GLCDDEVICEHEIGHT_H
;case Portrait
	goto	SysSelectEnd6
SysSelect6Case2
	movlw	4
	subwf	GLCDROTATESTATE,W
	btfss	STATUS, Z
	goto	SysSelect6Case3
;T6963_GLCD_WIDTH = GLCD_HEIGHT
	movlw	64
	movwf	GLCDDEVICEWIDTH
	clrf	GLCDDEVICEWIDTH_H
;T6963_GLCD_HEIGHT = GLCD_WIDTH
	movlw	240
	movwf	GLCDDEVICEHEIGHT
	clrf	GLCDDEVICEHEIGHT_H
;case LANDSCAPE_REV
	goto	SysSelectEnd6
SysSelect6Case3
	movlw	3
	subwf	GLCDROTATESTATE,W
	btfss	STATUS, Z
	goto	SysSelect6Case4
;T6963_GLCD_WIDTH = GLCD_WIDTH
	movlw	240
	movwf	GLCDDEVICEWIDTH
	clrf	GLCDDEVICEWIDTH_H
;T6963_GLCD_HEIGHT = GLCD_HEIGHT
	movlw	64
	movwf	GLCDDEVICEHEIGHT
	clrf	GLCDDEVICEHEIGHT_H
;case PORTRAIT_REV
	goto	SysSelectEnd6
SysSelect6Case4
	movlw	2
	subwf	GLCDROTATESTATE,W
	btfss	STATUS, Z
	goto	SysSelect6Case5
;T6963_GLCD_WIDTH = GLCD_HEIGHT
	movlw	64
	movwf	GLCDDEVICEWIDTH
	clrf	GLCDDEVICEWIDTH_H
;T6963_GLCD_HEIGHT = GLCD_WIDTH
	movlw	240
	movwf	GLCDDEVICEHEIGHT
	clrf	GLCDDEVICEHEIGHT_H
;case else
	goto	SysSelectEnd6
SysSelect6Case5
;T6963_GLCD_WIDTH = GLCD_WIDTH
	movlw	240
	movwf	GLCDDEVICEWIDTH
	clrf	GLCDDEVICEWIDTH_H
;T6963_GLCD_HEIGHT = GLCD_HEIGHT
	movlw	64
	movwf	GLCDDEVICEHEIGHT
	clrf	GLCDDEVICEHEIGHT_H
;end select
SysSelectEnd6
	return

;********************************************************************************

GLCDSENDCOMMAND_T6963
;GLCDBusyCheck_T6963
	call	GLCDBUSYCHECK_T6963
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
	call	GLCDBUSYCHECK_T6963
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

GLCDTABLE2_H
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
	addlw	low TableGLCDTABLE2_H
	movwf	SysStringA
	movlw	(high TableGLCDTABLE2_H) & 127
	btfsc	STATUS, C
	addlw	1
	addwf	SysStringA_H, W
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableGLCDTABLE2_H
	retlw	2

;********************************************************************************

GLCDTABLE4
	movlw	4
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableGLCDTABLE4
	movwf	SysStringA
	movlw	(high TableGLCDTABLE4) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableGLCDTABLE4
	retlw	3
	retlw	1
	retlw	0
	retlw	255

;********************************************************************************

GLCDTABLE5
	movlw	4
	subwf	SysStringA, W
	btfsc	STATUS, C
	retlw	0
	movf	SysStringA, W
	addlw	low TableGLCDTABLE5
	movwf	SysStringA
	movlw	(high TableGLCDTABLE5) & 127
	btfsc	STATUS, C
	addlw	1
	movwf	PCLATH
	movf	SysStringA, W
	movwf	PCL
TableGLCDTABLE5
	retlw	3
	retlw	1
	retlw	0
	retlw	255

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

LOCATE_T6963
;dim addr as word
;dim current_text_home_addr as word
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
	call	GLCDCMDADDRSEND_T6963
;GLCDSendCommand_T6963(CURSOR_PTR_SET)
	movlw	33
	movwf	LCDCMDBYTE
	call	GLCDSENDCOMMAND_T6963
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
ENDIF57
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
ENDIF58
;addr = (LCDLine*[word]COLUMN) + [word]LCDColumn + [word]current_text_home_addr
	movf	LCDLINE,W
	movwf	SysWORDTempA
	clrf	SysWORDTempA_H
	movlw	40
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysMultSub16
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
	banksel	CURRENT_TEXT_HOME_ADDR
	movf	CURRENT_TEXT_HOME_ADDR,W
	banksel	SYSTEMP2
	addwf	SysTemp2,W
	banksel	ADDR
	movwf	ADDR
	movf	CURRENT_TEXT_HOME_ADDR_H,W
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
	goto	GLCDCMDADDRSEND_T6963

;********************************************************************************

;Overloaded signature: STRING:
PRINT435
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
	goto	ENDIF71
	banksel	STATUS
	return
ENDIF71
;Set LCD_RS On
	bsf	SYSLCDTEMP,1
;Write Data
;For SysPrintTemp = 1 To PrintLen
	clrf	SYSPRINTTEMP
	movlw	1
	subwf	PRINTLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd20
ENDIF72
SysForLoop20
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
	call	LCDNORMALWRITEBYTE_T6963
;Next
	banksel	PRINTLEN
	movf	PRINTLEN,W
	subwf	SYSPRINTTEMP,W
	btfss	STATUS, C
	goto	SysForLoop20
ENDIF73
SysForLoopEnd20
	banksel	STATUS
	return

;********************************************************************************

PSET_T6963
;dim T6963_GLCD_HEIGHT, T6963_GLCD_WIDTH as word
;dim current_grh_home_addr as word
;select case GLCDRotateState
;case PORTRAIT
SysSelect5Case1
	movlw	4
	subwf	GLCDROTATESTATE,W
	btfss	STATUS, Z
	goto	SysSelect5Case2
;NOT supportED
;case LANDSCAPE
	goto	SysSelectEnd5
SysSelect5Case2
	decf	GLCDROTATESTATE,W
	btfss	STATUS, Z
	goto	SysSelect5Case3
;default
;case PORTRAIT_REV
	goto	SysSelectEnd5
SysSelect5Case3
	movlw	2
	subwf	GLCDROTATESTATE,W
	btfss	STATUS, Z
	goto	SysSelect5Case4
;NOT supportED
;case LANDSCAPE_REV
	goto	SysSelectEnd5
SysSelect5Case4
	movlw	3
	subwf	GLCDROTATESTATE,W
	btfss	STATUS, Z
	goto	SysSelect5Case5
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
	goto	SysSelectEnd5
SysSelect5Case5
;default
;end select
SysSelectEnd5
;dim addr as word
;dim cmd as byte
;addr = ( GLCDY  * COLUMN ) + (GLCDX /FontSize_T6963) + current_grh_home_addr
	movf	GLCDY,W
	movwf	SysWORDTempA
	movf	GLCDY_H,W
	movwf	SysWORDTempA_H
	movlw	40
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysMultSub16
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
	call	SysDivSub16
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
	banksel	CURRENT_GRH_HOME_ADDR
	movf	CURRENT_GRH_HOME_ADDR,W
	banksel	SYSTEMP3
	addwf	SysTemp3,W
	banksel	ADDR
	movwf	ADDR
	movf	CURRENT_GRH_HOME_ADDR_H,W
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
	call	GLCDCMDADDRSEND_T6963
;if ( GLCDColour = 1 ) then
	movf	GLCDCOLOUR,W
	movwf	SysWORDTempA
	movf	GLCDCOLOUR_H,W
	movwf	SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysCompEqual16
	btfss	SysByteTempX,0
	goto	ELSE67_1
;cmd = (0b11111000)|(FontSize_T6963- 1 -((GLCDX)%FontSize_T6963))
	movf	GLCDX,W
	movwf	SysWORDTempA
	movf	GLCDX_H,W
	movwf	SysWORDTempA_H
	movlw	6
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysDivSub16
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
	goto	ENDIF67
ELSE67_1
;cmd = (0b11110000)|(FontSize_T6963- 1 -((GLCDX)%FontSize_T6963))
	movf	GLCDX,W
	movwf	SysWORDTempA
	movf	GLCDX_H,W
	movwf	SysWORDTempA_H
	movlw	6
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysDivSub16
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
ENDIF67
;GLCDSendCommand_T6963(cmd)
	movf	CMD,W
	movwf	LCDCMDBYTE
	goto	GLCDSENDCOMMAND_T6963

;********************************************************************************

SELECTGLCDPAGE_T6963
;dim current_grh_home_addr as word
;GLCDCmdAddrSend_T6963( addr , GRAPH_HOME_SET )
	movf	ADDR,W
	movwf	LCDDATAWORD
	movf	ADDR_H,W
	movwf	LCDDATAWORD_H
	movlw	66
	movwf	LCDCMDBYTE
	call	GLCDCMDADDRSEND_T6963
;current_grh_home_addr = addr
	movf	ADDR,W
	movwf	CURRENT_GRH_HOME_ADDR
	movf	ADDR_H,W
	movwf	CURRENT_GRH_HOME_ADDR_H
	return

;********************************************************************************

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
	goto	ENDIF76
;SysWordTempA = 0
	clrf	SYSWORDTEMPA
	clrf	SYSWORDTEMPA_H
;exit sub
	return
;end if
ENDIF76
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
	goto	ENDIF77
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	addwfc	SYSDIVMULTX_H,F
;End If
ENDIF77
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
	goto	ENDIF74
	movf	SYSDIVMULTA,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTA_H,W
	addwfc	SYSDIVMULTX_H,F
ENDIF74
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
ENDIF75
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
	call	SYSSTRINGTABLES
;movwf SysCalcTempA
	movwf	SYSCALCTEMPA
;movwf INDF1
	movwf	INDF1
;goto SysStringReadCheck
	goto	SYSSTRINGREADCHECK
SYSREADSTRINGPART
;Get length
;call SysStringTables
	call	SYSSTRINGTABLES
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
	call	SYSSTRINGTABLES
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
	retlw	8
	retlw	66	;B
	retlw	77	;M
	retlw	80	;P
	retlw	32	; 
	retlw	108	;l
	retlw	111	;o
	retlw	97	;a
	retlw	100	;d


StringTable4
	retlw	6
	retlw	80	;P
	retlw	97	;a
	retlw	103	;g
	retlw	101	;e
	retlw	32	; 
	retlw	49	;1


StringTable5
	retlw	32
	retlw	71	;G
	retlw	76	;L
	retlw	67	;C
	retlw	68	;D
	retlw	32	; 
	retlw	109	;m
	retlw	101	;e
	retlw	116	;t
	retlw	104	;h
	retlw	111	;o
	retlw	100	;d
	retlw	115	;s
	retlw	32	; 
	retlw	117	;u
	retlw	115	;s
	retlw	101	;e
	retlw	100	;d
	retlw	32	; 
	retlw	116	;t
	retlw	111	;o
	retlw	32	; 
	retlw	99	;c
	retlw	114	;r
	retlw	101	;e
	retlw	97	;a
	retlw	116	;t
	retlw	101	;e
	retlw	32	; 
	retlw	112	;p
	retlw	97	;a
	retlw	103	;g
	retlw	101	;e


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
