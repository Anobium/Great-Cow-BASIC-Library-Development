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
DEFAULTDISPLAYMODESTATE_T6963	EQU	56
DELAYTEMP	EQU	112
DELAYTEMP2	EQU	113
GLCDBACKGROUND	EQU	57
GLCDBACKGROUND_H	EQU	58
GLCDCOLOUR	EQU	59
GLCDCOLOUR_H	EQU	60
GLCDDEVICEHEIGHT	EQU	61
GLCDDEVICEHEIGHT_H	EQU	62
GLCDDEVICEWIDTH	EQU	63
GLCDDEVICEWIDTH_H	EQU	64
GLCDFNTDEFAULT	EQU	65
GLCDFNTDEFAULTSIZE	EQU	66
GLCDFONTWIDTH	EQU	67
GLCDFOREGROUND	EQU	68
GLCDFOREGROUND_H	EQU	69
GLCDPRINTLEN	EQU	70
GLCDPRINTLOC	EQU	71
GLCDPRINTLOC_H	EQU	72
GLCDPRINT_STRING_COUNTER	EQU	73
GLCDROTATESTATE	EQU	74
GLCDX	EQU	75
GLCDX_H	EQU	76
GLCDY	EQU	77
GLCDY_H	EQU	78
GLCD_YORDINATE	EQU	79
GLCD_YORDINATE_H	EQU	80
LCDCMDBYTE	EQU	81
LCDDATABYTE	EQU	82
LCDDATAWORD	EQU	83
LCDDATAWORD_H	EQU	84
LINECOLOUR	EQU	85
LINECOLOUR_H	EQU	86
LOCX	EQU	87
LOCX_H	EQU	88
LOCY	EQU	89
LOCY_H	EQU	90
PRINTLEN	EQU	91
PRINTLOCX	EQU	92
PRINTLOCX_H	EQU	93
PRINTLOCY	EQU	94
PRINTLOCY_H	EQU	95
ROW	EQU	96
ROW_T6963	EQU	97
ROW_T6963_H	EQU	98
STRINGPOINTER	EQU	99
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
SYSLCDPRINTDATAHANDLER	EQU	100
SYSLCDPRINTDATAHANDLER_H	EQU	101
SYSPRINTDATAHANDLER	EQU	102
SYSPRINTDATAHANDLER_H	EQU	103
SYSPRINTTEMP	EQU	104
SYSSTRINGA	EQU	119
SYSSTRINGA_H	EQU	120
SYSSTRINGLENGTH	EQU	118
SYSSTRINGPARAM1	EQU	9183
SYSTEMP1	EQU	105
SYSTEMP1_H	EQU	106
SYSTEMP2	EQU	107
SYSTEMP2_H	EQU	108
SYSTEMP3	EQU	109
SYSTEMP3_H	EQU	110
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
;do Forever
SysDoLoop_S1
;BigPrint ( 0, 0, "WG24064A-TMI-TZ#")
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
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movf	GLCDFOREGROUND,W
	movwf	COLOR
	movf	GLCDFOREGROUND_H,W
	movwf	COLOR_H
	pagesel	BIGPRINT_ILI9486L
	call	BIGPRINT_ILI9486L
	pagesel	$
;BigPrint ( 0, 20, "Feb 2019")
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
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
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
GLCDTEST
;#DEFINE GLCD_OLED_FONT
;CLS
	pagesel	CLS_T6963
	call	CLS_T6963
	pagesel	$
;GLCDCLS
	pagesel	GLCDCLS_T6963
	call	GLCDCLS_T6963
	pagesel	$
;glcdprint 50, 40, "Ge?? s?? ??sµe"
	movlw	50
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	40
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable3
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable3) | 128
	movwf	SysLCDPRINTDATAHandler_H
	call	GLCDPRINT3
;glcdprint 5, 55, "GLCD ???????? ?p?st????? ???ssa?"
	movlw	5
	movwf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	55
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low StringTable4
	movwf	SysLCDPRINTDATAHandler
	movlw	(high StringTable4) | 128
	movwf	SysLCDPRINTDATAHandler_H
	call	GLCDPRINT3
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
;BigPrint ( 0, 0, "WG24064A-TMI-TZ#")
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
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
	movf	GLCDFOREGROUND,W
	movwf	COLOR
	movf	GLCDFOREGROUND_H,W
	movwf	COLOR_H
	pagesel	BIGPRINT_ILI9486L
	call	BIGPRINT_ILI9486L
	pagesel	$
;BigPrint ( 0, 40, "Anobium :-)")
	clrf	PRINTLOCX
	clrf	PRINTLOCX_H
	movlw	40
	movwf	PRINTLOCY
	clrf	PRINTLOCY_H
	movlw	low SYSSTRINGPARAM1
	movwf	FSR1L
	movlw	high SYSSTRINGPARAM1
	movwf	FSR1H
	movlw	low StringTable5
	movwf	SysStringA
	movlw	(high StringTable5) & 127
	movwf	SysStringA_H
	pagesel	SysReadString
	call	SysReadString
	pagesel	$
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H
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

DRAWBIGCHAR_ILI9486L
;dim Locx, Locy, CurrCol as Word
;if CharCode <=126 Then
	movf	CHARCODE,W
	sublw	126
	btfss	STATUS, C
	goto	ENDIF16
;CharCode -=32
	movlw	32
	subwf	CHARCODE,F
;Goto GCBBigTables
	goto	GCBBIGTABLES
;end if
ENDIF16
;if CharCode <=210 Then
	movf	CHARCODE,W
	sublw	210
	btfss	STATUS, C
	goto	ENDIF17
;CharCode -=33
	movlw	33
	subwf	CHARCODE,F
;Goto GCBBigTables
	goto	GCBBIGTABLES
;end if
ENDIF17
;if CharCode <= 250 Then
	movf	CHARCODE,W
	sublw	250
	btfss	STATUS, C
	goto	ENDIF18
;CharCode -=34
	movlw	34
	subwf	CHARCODE,F
;Goto GCBBigTables
	goto	GCBBIGTABLES
;end if
ENDIF18
GCBBIGTABLES
;For CurrCharCol = 1 to 24
	clrf	CURRCHARCOL
SysForLoop7
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
	movwf	SysTemp1
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	24
	movwf	SysBYTETempB
	pagesel	SysMultSub
	call	SysMultSub
	pagesel	$
	movf	SysBYTETempX,W
	movwf	SysTemp2
	movf	SysTemp1,W
	movwf	SysBYTETempA
	movlw	240
	movwf	SysBYTETempB
	pagesel	SysMultSub
	call	SysMultSub
	pagesel	$
	movf	SysTemp2,W
	addwf	CURRCHARCOL,W
	movwf	SysTemp1
	clrf	SysTemp1_H
	btfsc	STATUS,C
	incf	SysTemp1_H,F
	movf	SysBYTETempX,W
	subwf	SysTemp1,W
	movwf	CURRCOL
	movlw	0
	subwfb	SysTemp1_H,W
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
	movwf	SysTemp1
	movf	CHARCODE,W
	movwf	SysBYTETempB
	movlw	9
	movwf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfss	SysTemp2,0
	goto	ENDIF19
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT32_41
	call	BIGFONT32_41
	pagesel	$
	movwf	CURRCHARVAL
ENDIF19
;if CharCode>=10 and CharCode<=19 then ReadTable BigFont42_51 , CurrCol, CurrCharVal
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	10
	movwf	SysBYTETempB
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	movwf	SysTemp1
	movf	CHARCODE,W
	movwf	SysBYTETempB
	movlw	19
	movwf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfss	SysTemp2,0
	goto	ENDIF20
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT42_51
	call	BIGFONT42_51
	pagesel	$
	movwf	CURRCHARVAL
ENDIF20
;if CharCode>=20 and CharCode<=29 then ReadTable BigFont52_61 , CurrCol, CurrCharVal
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	20
	movwf	SysBYTETempB
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	movwf	SysTemp1
	movf	CHARCODE,W
	movwf	SysBYTETempB
	movlw	29
	movwf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfss	SysTemp2,0
	goto	ENDIF21
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	call	BIGFONT52_61
	movwf	CURRCHARVAL
ENDIF21
;if CharCode>=30 and CharCode<=39 then ReadTable BigFont62_71 , CurrCol, CurrCharVal
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	30
	movwf	SysBYTETempB
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	movwf	SysTemp1
	movf	CHARCODE,W
	movwf	SysBYTETempB
	movlw	39
	movwf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfss	SysTemp2,0
	goto	ENDIF22
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT62_71
	call	BIGFONT62_71
	pagesel	$
	movwf	CURRCHARVAL
ENDIF22
;if CharCode>=40 and CharCode<=49 then ReadTable BigFont72_81 , CurrCol, CurrCharVal
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	40
	movwf	SysBYTETempB
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	movwf	SysTemp1
	movf	CHARCODE,W
	movwf	SysBYTETempB
	movlw	49
	movwf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfss	SysTemp2,0
	goto	ENDIF23
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	call	BIGFONT72_81
	movwf	CURRCHARVAL
ENDIF23
;if CharCode>=50 and CharCode<=59 then ReadTable BigFont82_91 , CurrCol, CurrCharVal
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	50
	movwf	SysBYTETempB
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	movwf	SysTemp1
	movf	CHARCODE,W
	movwf	SysBYTETempB
	movlw	59
	movwf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfss	SysTemp2,0
	goto	ENDIF24
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT82_91
	call	BIGFONT82_91
	pagesel	$
	movwf	CURRCHARVAL
ENDIF24
;if CharCode>=60 and CharCode<=69 then ReadTable BigFont92_101 , CurrCol, CurrCharVal
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	60
	movwf	SysBYTETempB
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	movwf	SysTemp1
	movf	CHARCODE,W
	movwf	SysBYTETempB
	movlw	69
	movwf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfss	SysTemp2,0
	goto	ENDIF25
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT92_101
	call	BIGFONT92_101
	pagesel	$
	movwf	CURRCHARVAL
ENDIF25
;if CharCode>=70 and CharCode<=79 then ReadTable BigFont102_111 , CurrCol, CurrCharVal
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	70
	movwf	SysBYTETempB
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	movwf	SysTemp1
	movf	CHARCODE,W
	movwf	SysBYTETempB
	movlw	79
	movwf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfss	SysTemp2,0
	goto	ENDIF26
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT102_111
	call	BIGFONT102_111
	pagesel	$
	movwf	CURRCHARVAL
ENDIF26
;if CharCode>=80 and CharCode<=89 then ReadTable BigFont112_121 , CurrCol, CurrCharVal
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	80
	movwf	SysBYTETempB
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	movwf	SysTemp1
	movf	CHARCODE,W
	movwf	SysBYTETempB
	movlw	89
	movwf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfss	SysTemp2,0
	goto	ENDIF27
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT112_121
	call	BIGFONT112_121
	pagesel	$
	movwf	CURRCHARVAL
ENDIF27
;if CharCode>=90 and CharCode<=99 then ReadTable BigFont122_126 , CurrCol, CurrCharVal
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	90
	movwf	SysBYTETempB
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	movwf	SysTemp1
	movf	CHARCODE,W
	movwf	SysBYTETempB
	movlw	99
	movwf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfss	SysTemp2,0
	goto	ENDIF28
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT122_126
	call	BIGFONT122_126
	pagesel	$
	movwf	CURRCHARVAL
ENDIF28
;if CharCode>=160 and CharCode<=169 then ReadTable BigFont193_202 , CurrCol, CurrCharVal
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	160
	movwf	SysBYTETempB
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	movwf	SysTemp1
	movf	CHARCODE,W
	movwf	SysBYTETempB
	movlw	169
	movwf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfss	SysTemp2,0
	goto	ENDIF29
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT193_202
	call	BIGFONT193_202
	pagesel	$
	movwf	CURRCHARVAL
ENDIF29
;if CharCode>=170 and CharCode<=179 then ReadTable BigFont203_212 , CurrCol, CurrCharVal
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	170
	movwf	SysBYTETempB
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	movwf	SysTemp1
	movf	CHARCODE,W
	movwf	SysBYTETempB
	movlw	179
	movwf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfss	SysTemp2,0
	goto	ENDIF30
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT203_212
	call	BIGFONT203_212
	pagesel	$
	movwf	CURRCHARVAL
ENDIF30
;if CharCode>=180 and CharCode<=183 then ReadTable BigFont213_216 , CurrCol, CurrCharVal
	movf	CHARCODE,W
	movwf	SysBYTETempA
	movlw	180
	movwf	SysBYTETempB
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	movwf	SysTemp1
	movf	CHARCODE,W
	movwf	SysBYTETempB
	movlw	183
	movwf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfss	SysTemp2,0
	goto	ENDIF31
	movf	CURRCOL,W
	movwf	SYSSTRINGA
	pagesel	BIGFONT213_216
	call	BIGFONT213_216
	pagesel	$
	movwf	CURRCHARVAL
ENDIF31
;if CurrCharVal=36 then CurrCharVal=33
	movlw	36
	subwf	CURRCHARVAL,W
	btfss	STATUS, Z
	goto	ENDIF32
	movlw	33
	movwf	CURRCHARVAL
ENDIF32
;For CurrCharRow = 1 to 8
	clrf	CURRCHARROW
SysForLoop8
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
	movwf	LOCY
	movlw	0
	addwfc	CHARLOCY_H,W
	movwf	LOCY_H
;if CurrCharCol>12 then
	movf	CURRCHARCOL,W
	sublw	12
	btfsc	STATUS, C
	goto	ENDIF33
;LocX= LocX - 12
	movlw	12
	subwf	LOCX,F
	movlw	0
	subwfb	LOCX_H,F
;LocY= LocY + 8
	movlw	8
	addwf	LOCY,F
	movlw	0
	addwfc	LOCY_H,F
;end if
ENDIF33
;if CurrCharVal.0=1 then
	btfss	CURRCHARVAL,0
	goto	ENDIF34
;PSet LocX , LocY , Color
	movf	LOCX,W
	movwf	GLCDX
	movf	LOCX_H,W
	movwf	GLCDX_H
	movf	LOCY,W
	movwf	GLCDY
	movf	LOCY_H,W
	movwf	GLCDY_H
	movf	COLOR,W
	movwf	GLCDCOLOUR
	movf	COLOR_H,W
	movwf	GLCDCOLOUR_H
	call	PSET_T6963
	pagesel	$
;end if
ENDIF34
;Rotate CurrCharVal Right
	rrf	CURRCHARVAL,F
;Next
	movlw	8
	subwf	CURRCHARROW,W
	btfss	STATUS, C
	goto	SysForLoop8
ENDIF35
SysForLoopEnd8
;Next
	movlw	24
	subwf	CURRCHARCOL,W
	btfss	STATUS, C
	goto	SysForLoop7
ENDIF36
SysForLoopEnd7
	return

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

;Overloaded signature: WORD:WORD:STRING:
GLCDPRINT3
;GLCD.h Sub GLCDPrint
;Dim GLCDPrintLoc  as word
;Dim GLCDPrint_String_Counter, GLCDPrintLen as byte
;GLCDPrintLen = LCDPrintData(0)
	movf	SysLCDPRINTDATAHandler,W
	movwf	AFSR0
	movf	SysLCDPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	movwf	GLCDPRINTLEN
;If GLCDPrintLen = 0 Then Exit Sub
	movf	GLCDPRINTLEN,F
	btfsc	STATUS, Z
	return
ENDIF1
;GLCDPrintLoc = PrintLocX
	movf	PRINTLOCX,W
	movwf	GLCDPRINTLOC
	movf	PRINTLOCX_H,W
	movwf	GLCDPRINTLOC_H
;Write Data
;For GLCDPrint_String_Counter = 1 To GLCDPrintLen
	clrf	GLCDPRINT_STRING_COUNTER
	movlw	1
	subwf	GLCDPRINTLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd1
ENDIF2
SysForLoop1
	incf	GLCDPRINT_STRING_COUNTER,F
;GLCDDrawChar  GLCDPrintLoc, PrintLocY, LCDPrintData(GLCDPrint_String_Counter)
	movf	GLCDPRINTLOC,W
	movwf	CHARLOCX
	movf	GLCDPRINTLOC_H,W
	movwf	CHARLOCX_H
	movf	PRINTLOCY,W
	movwf	CHARLOCY
	movf	PRINTLOCY_H,W
	movwf	CHARLOCY_H
	movf	GLCDPRINT_STRING_COUNTER,W
	addwf	SysLCDPRINTDATAHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysLCDPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
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
	movwf	SysTemp1
	addwf	GLCDPRINTLOC,W
	movwf	SysTemp2
	movlw	0
	addwfc	GLCDPRINTLOC_H,W
	movwf	SysTemp2_H
	movlw	1
	addwf	SysTemp2,W
	movwf	GLCDPRINTLOC
	movlw	0
	addwfc	SysTemp2_H,W
	movwf	GLCDPRINTLOC_H
;Next
	movf	GLCDPRINTLEN,W
	subwf	GLCDPRINT_STRING_COUNTER,W
	btfss	STATUS, C
	goto	SysForLoop1
ENDIF3
SysForLoopEnd1
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
	movwf	SysTemp1
	movf	GLCDX_H,W
	subwfb	GLCDDEVICEWIDTH_H,W
	movwf	SysTemp1_H
	movlw	1
	subwf	SysTemp1,W
	movwf	GLCDX
	movlw	0
	subwfb	SysTemp1_H,W
	movwf	GLCDX_H
;GLCDY  = T6963_GLCD_HEIGHT - GLCDY - 1
	movf	GLCDY,W
	subwf	GLCDDEVICEHEIGHT,W
	movwf	SysTemp1
	movf	GLCDY_H,W
	subwfb	GLCDDEVICEHEIGHT_H,W
	movwf	SysTemp1_H
	movlw	1
	subwf	SysTemp1,W
	movwf	GLCDY
	movlw	0
	subwfb	SysTemp1_H,W
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
	movwf	SysTemp1
	movf	SysWORDTempX_H,W
	movwf	SysTemp1_H
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
	movwf	ADDR
	movlw	63
	addwfc	SysTemp3_H,W
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
	goto	ELSE45_1
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
	movwf	CMD
;else
	goto	ENDIF45
ELSE45_1
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
	movwf	CMD
;end if
ENDIF45
;GLCDSendCommand_T6963(cmd)
	movf	CMD,W
	movwf	LCDCMDBYTE
	pagesel	GLCDSENDCOMMAND_T6963
	goto	GLCDSENDCOMMAND_T6963

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

;Start of program memory page 1
	ORG	2048
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
	btfsc	PORTD,3
	incf	SysTemp2,F
ENDIF48
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

BIGPRINT_ILI9486L
;Dim GLCDPrintLoc as word
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
ENDIF13
;GLCDPrintLoc = PrintLocX
	movf	PRINTLOCX,W
	movwf	GLCDPRINTLOC
	movf	PRINTLOCX_H,W
	movwf	GLCDPRINTLOC_H
;For SysPrintTemp = 1 To PrintLen
	clrf	SYSPRINTTEMP
	movlw	1
	subwf	PRINTLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd6
ENDIF14
SysForLoop6
	incf	SYSPRINTTEMP,F
;DrawBigChar_ILI9486L GLCDPrintLoc, PrintLocY, PrintData(SysPrintTemp), Color
	movf	GLCDPRINTLOC,W
	movwf	CHARLOCX
	movf	GLCDPRINTLOC_H,W
	movwf	CHARLOCX_H
	movf	PRINTLOCY,W
	movwf	CHARLOCY
	movf	PRINTLOCY_H,W
	movwf	CHARLOCY_H
	movf	SYSPRINTTEMP,W
	addwf	SysPRINTDATAHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
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
	movf	PRINTLEN,W
	subwf	SYSPRINTTEMP,W
	btfss	STATUS, C
	goto	SysForLoop6
ENDIF15
SysForLoopEnd6
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
	call	GLCDCMDADDRSEND_T6963
;Set Auto Write ON
;GLCDSendCommand_T6963(AUTO_WR_ON)
	movlw	176
	movwf	LCDCMDBYTE
	call	GLCDSENDCOMMAND_T6963
;row runs from 0 ... (MAX_ROW_PIXEL/8 -1), in form of a cell of (FontSize x 8) bits
;for  row_T6963 =  0 to ( MAX_ROW_PIXEL/8 ) -1
	movlw	255
	movwf	ROW_T6963
	movwf	ROW_T6963_H
SysForLoop9
	incf	ROW_T6963,F
	btfsc	STATUS,Z
	incf	ROW_T6963_H,F
;write blank to clear screen the first page only, col = 0...(COLUMN-1)
;for col_T6963 = 0 to COLUMN - 1
	movlw	255
	movwf	COL_T6963
	movwf	COL_T6963_H
SysForLoop10
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
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop10
ENDIF39
SysForLoopEnd10
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
	goto	SysForLoop9
ENDIF40
SysForLoopEnd9
;GLCDSendCommand_T6963(AUTO_WR_OFF)
	movlw	178
	movwf	LCDCMDBYTE
	call	GLCDSENDCOMMAND_T6963
;GLCDCmdAddrSend_T6963(TEXT_HOME_ADDR,ADDR_PTR_SET)
	clrf	LCDDATAWORD
	clrf	LCDDATAWORD_H
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
	btfsc	PORTD,0
	incf	SysTemp2,F
ENDIF46
	comf	SysTemp2,W
	movwf	SysTemp1
	btfsc	SysTemp1,0
	goto	SysWaitLoop1
;wait T6963ClockDelay us
;wait while (!STA1)
SysWaitLoop2
	clrf	SysTemp2
	btfsc	PORTD,1
	incf	SysTemp2,F
ENDIF47
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
	movwf	ROW_T6963
SysForLoop11
	incf	ROW_T6963,F
;write blank to clear screen the first page only, col = 0...(COLUMN-1)
;for col_T6963 = 0 to COLUMN - 1
	movlw	255
	movwf	COL_T6963
SysForLoop12
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
	goto	SysForLoop12
ENDIF43
SysForLoopEnd12
;next
	movf	ROW_T6963,W
	movwf	SysBYTETempA
	movlw	63
	movwf	SysBYTETempB
	call	SysCompLessThan
	btfsc	SysByteTempX,0
	goto	SysForLoop11
ENDIF44
SysForLoopEnd11
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
	call	SysCompEqual16
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF4
;Inverted Colours
;GLCDBackground = 1
	movlw	1
	movwf	GLCDBACKGROUND
	clrf	GLCDBACKGROUND_H
;GLCDForeground = 0
	clrf	GLCDFOREGROUND
	clrf	GLCDFOREGROUND_H
;end if
ENDIF4
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
	call	SysCompLessThan
	comf	SysByteTempX,F
	movf	SysByteTempX,W
	movwf	SysTemp1
	movf	CHARCODE,W
	movwf	SysBYTETempB
	movlw	202
	movwf	SysBYTETempA
	call	SysCompLessThan
	comf	SysByteTempX,F
	movf	SysTemp1,W
	andwf	SysByteTempX,W
	movwf	SysTemp2
	btfss	SysTemp2,0
	goto	ENDIF5
;CharLocY=CharLocY-1
	movlw	1
	subwf	CHARLOCY,F
	movlw	0
	subwfb	CHARLOCY_H,F
;end if
ENDIF5
;For CurrCharCol = 1 to 5
	clrf	CURRCHARCOL
SysForLoop2
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
SysForLoop3
	incf	CURRCHARROW,F
;CharColS=0
	clrf	CHARCOLS
;For Col=1 to GLCDfntDefaultsize
	clrf	COL
	movlw	1
	subwf	GLCDFNTDEFAULTSIZE,W
	btfss	STATUS, C
	goto	SysForLoopEnd4
ENDIF6
SysForLoop4
	incf	COL,F
;CharRowS=0
	clrf	CHARROWS
;For Row=1 to GLCDfntDefaultsize
	clrf	ROW
	movlw	1
	subwf	GLCDFNTDEFAULTSIZE,W
	btfss	STATUS, C
	goto	SysForLoopEnd5
ENDIF7
SysForLoop5
	incf	ROW,F
;if CurrCharVal.0=1 then
	btfss	CURRCHARVAL,0
	goto	ELSE8_1
;PSet [word]CharLocX + CharCol+ CharColS, [word]CharLocY + CharRow+CharRowS, LineColour
	movf	CHARCOL,W
	addwf	CHARLOCX,W
	movwf	SysTemp2
	movf	CHARCOL_H,W
	addwfc	CHARLOCX_H,W
	movwf	SysTemp2_H
	movf	CHARCOLS,W
	addwf	SysTemp2,W
	movwf	GLCDX
	movlw	0
	addwfc	SysTemp2_H,W
	movwf	GLCDX_H
	movf	CHARROW,W
	addwf	CHARLOCY,W
	movwf	SysTemp2
	movf	CHARROW_H,W
	addwfc	CHARLOCY_H,W
	movwf	SysTemp2_H
	movf	CHARROWS,W
	addwf	SysTemp2,W
	movwf	GLCDY
	movlw	0
	addwfc	SysTemp2_H,W
	movwf	GLCDY_H
	movf	LINECOLOUR,W
	movwf	GLCDCOLOUR
	movf	LINECOLOUR_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_T6963
	call	PSET_T6963
	pagesel	$
;Else
	goto	ENDIF8
ELSE8_1
;PSet [word]CharLocX + CharCol+ CharColS, [word]CharLocY + CharRow+CharRowS, GLCDBackground
	movf	CHARCOL,W
	addwf	CHARLOCX,W
	movwf	SysTemp2
	movf	CHARCOL_H,W
	addwfc	CHARLOCX_H,W
	movwf	SysTemp2_H
	movf	CHARCOLS,W
	addwf	SysTemp2,W
	movwf	GLCDX
	movlw	0
	addwfc	SysTemp2_H,W
	movwf	GLCDX_H
	movf	CHARROW,W
	addwf	CHARLOCY,W
	movwf	SysTemp2
	movf	CHARROW_H,W
	addwfc	CHARLOCY_H,W
	movwf	SysTemp2_H
	movf	CHARROWS,W
	addwf	SysTemp2,W
	movwf	GLCDY
	movlw	0
	addwfc	SysTemp2_H,W
	movwf	GLCDY_H
	movf	GLCDBACKGROUND,W
	movwf	GLCDCOLOUR
	movf	GLCDBACKGROUND_H,W
	movwf	GLCDCOLOUR_H
	pagesel	PSET_T6963
	call	PSET_T6963
	pagesel	$
;End if
ENDIF8
;Put out a white intercharacter pixel/space
;PSet [word]CharLocX + ( GLCDFontWidth * GLCDfntDefaultsize) , [word]CharLocY + CharRow + CharRowS , GLCDBackground
	movf	GLCDFONTWIDTH,W
	movwf	SysBYTETempA
	movf	GLCDFNTDEFAULTSIZE,W
	movwf	SysBYTETempB
	call	SysMultSub
	movf	SysBYTETempX,W
	movwf	SysTemp1
	addwf	CHARLOCX,W
	movwf	GLCDX
	movlw	0
	addwfc	CHARLOCX_H,W
	movwf	GLCDX_H
	movf	CHARROW,W
	addwf	CHARLOCY,W
	movwf	SysTemp2
	movf	CHARROW_H,W
	addwfc	CHARLOCY_H,W
	movwf	SysTemp2_H
	movf	CHARROWS,W
	addwf	SysTemp2,W
	movwf	GLCDY
	movlw	0
	addwfc	SysTemp2_H,W
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
	subwf	ROW,W
	btfss	STATUS, C
	goto	SysForLoop5
ENDIF9
SysForLoopEnd5
;CharColS +=1
	incf	CHARCOLS,F
;Next Col
	movf	GLCDFNTDEFAULTSIZE,W
	subwf	COL,W
	btfss	STATUS, C
	goto	SysForLoop4
ENDIF10
SysForLoopEnd4
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
	goto	SysForLoop3
ENDIF11
SysForLoopEnd3
;CharCol +=GLCDfntDefaultsize
	movf	GLCDFNTDEFAULTSIZE,W
	addwf	CHARCOL,F
	movlw	0
	addwfc	CHARCOL_H,F
;Next
	movlw	5
	subwf	CURRCHARCOL,W
	btfss	STATUS, C
	goto	SysForLoop2
ENDIF12
SysForLoopEnd2
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

GLCDISPAUTODATAWR
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
	goto	ENDIF51
;SysWordTempA = 0
	clrf	SYSWORDTEMPA
	clrf	SYSWORDTEMPA_H
;exit sub
	return
;end if
ENDIF51
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
	goto	ENDIF52
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	addwfc	SYSDIVMULTX_H,F
;End If
ENDIF52
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
	goto	ENDIF49
	movf	SYSDIVMULTA,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTA_H,W
	addwfc	SYSDIVMULTX_H,F
ENDIF49
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
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	MUL16LOOP
ENDIF50
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
	retlw	14
	retlw	71	;G
	retlw	101	;e
	retlw	63	;?
	retlw	63	;?
	retlw	32	; 
	retlw	115	;s
	retlw	63	;?
	retlw	63	;?
	retlw	32	; 
	retlw	63	;?
	retlw	63	;?
	retlw	115	;s
	retlw	181	;µ
	retlw	101	;e


StringTable4
	retlw	32
	retlw	71	;G
	retlw	76	;L
	retlw	67	;C
	retlw	68	;D
	retlw	32	; 
	retlw	63	;?
	retlw	63	;?
	retlw	63	;?
	retlw	63	;?
	retlw	63	;?
	retlw	63	;?
	retlw	63	;?
	retlw	63	;?
	retlw	32	; 
	retlw	63	;?
	retlw	112	;p
	retlw	63	;?
	retlw	115	;s
	retlw	116	;t
	retlw	63	;?
	retlw	63	;?
	retlw	63	;?
	retlw	63	;?
	retlw	63	;?
	retlw	32	; 
	retlw	63	;?
	retlw	63	;?
	retlw	63	;?
	retlw	115	;s
	retlw	115	;s
	retlw	97	;a
	retlw	63	;?


StringTable5
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


;********************************************************************************

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
