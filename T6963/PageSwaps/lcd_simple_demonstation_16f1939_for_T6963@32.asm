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
ADCWAIT	EQU	32
ADCWAIT_H	EQU	33
ADDR	EQU	34
ADDR_H	EQU	35
ADREADPORT	EQU	36
COL_T6963	EQU	37
COL_T6963_H	EQU	38
CURRENT_GRH_HOME_ADDR	EQU	39
CURRENT_GRH_HOME_ADDR_H	EQU	40
CURRENT_TEXT_HOME_ADDR	EQU	41
CURRENT_TEXT_HOME_ADDR_H	EQU	42
DEFAULTDISPLAYMODESTATE_T6963	EQU	43
DELAYTEMP	EQU	112
DELAYTEMP2	EQU	113
GLCDBACKGROUND	EQU	44
GLCDBACKGROUND_H	EQU	45
GLCDDEVICEHEIGHT	EQU	46
GLCDDEVICEHEIGHT_H	EQU	47
GLCDDEVICEWIDTH	EQU	48
GLCDDEVICEWIDTH_H	EQU	49
GLCDFNTDEFAULT	EQU	50
GLCDFNTDEFAULTSIZE	EQU	51
GLCDFONTWIDTH	EQU	52
GLCDFOREGROUND	EQU	53
GLCDFOREGROUND_H	EQU	54
GLCDROTATESTATE	EQU	55
GLCD_YORDINATE	EQU	56
GLCD_YORDINATE_H	EQU	57
HEX	EQU	9196
LCDBYTE	EQU	58
LCDCHAR	EQU	59
LCDCMDBYTE	EQU	60
LCDCOLUMN	EQU	61
LCDDATABYTE	EQU	62
LCDDATAWORD	EQU	63
LCDDATAWORD_H	EQU	64
LCDLINE	EQU	65
LCDPUTCOLUMN	EQU	66
LCDPUTLINE	EQU	67
LCDVALUE	EQU	68
LCDVALUETEMP	EQU	70
LCDVALUE_H	EQU	69
LCD_STATE	EQU	71
PRINTLEN	EQU	72
READAD10	EQU	73
READAD10_H	EQU	75
ROW_T6963	EQU	76
ROW_T6963_H	EQU	77
STRINGPOINTER	EQU	78
SYSBYTETEMPA	EQU	117
SYSBYTETEMPB	EQU	121
SYSBYTETEMPX	EQU	112
SYSCALCTEMPX	EQU	112
SYSCALCTEMPX_H	EQU	113
SYSDIVLOOP	EQU	116
SYSDIVMULTA	EQU	119
SYSDIVMULTA_H	EQU	120
SYSDIVMULTB	EQU	123
SYSDIVMULTB_H	EQU	124
SYSDIVMULTX	EQU	114
SYSDIVMULTX_H	EQU	115
SYSLCDTEMP	EQU	79
SYSPRINTDATAHANDLER	EQU	80
SYSPRINTDATAHANDLER_H	EQU	81
SYSPRINTTEMP	EQU	82
SYSSTRINGA	EQU	119
SYSSTRINGA_H	EQU	120
SYSSTRINGTEMP	EQU	83
SYSTEMP1	EQU	84
SYSTEMP1_H	EQU	85
SYSTEMP2	EQU	86
SYSTEMP2_H	EQU	87
SYSVALTEMP	EQU	88
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
XPOSITION	EQU	89
YPOSITION	EQU	90

;********************************************************************************

;Alias variables
AFSR0	EQU	4
AFSR0_H	EQU	5
SYSHEX_0	EQU	1612
SYSHEX_1	EQU	1613
SYSHEX_2	EQU	1614
SYSREADAD10WORD	EQU	73
SYSREADAD10WORD_H	EQU	75

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
	call	INITGLCD_T6963
	pagesel	$
	call	INITLCD

;Start of the main program
;''A demonstration program for GCGB and GCB.
;''--------------------------------------------------------------------------------------------------------------------------------
;''This program is a simple GLCD demonstration of the T6963 GLCD capabilities.
;''This program will show page swapping for the LCD (text mode).  The pages are swapped and the ADC is used to aquire the wait in ms.
;''The GLCD is connected to the microprocessor as shown in the hardware section of this code.
;''@author  EvanV
;''@licence GPL
;''@version 1.0
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
;Print "WG24064A-TMI-TZ#"
	movlw	low StringTable1
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable1) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;LCDSpace 16
	movlw	16
	movwf	LCDVALUE
	pagesel	LCDSPACE_T6963
	call	LCDSPACE_T6963
	pagesel	$
;Print "Feb 2019"
	movlw	low StringTable2
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable2) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;Locate 7,0
	movlw	7
	movwf	LCDLINE
	clrf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print "LCDPAGESIZE = "
	movlw	low StringTable3
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable3) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;Print LCDPAGESIZE
	movlw	64
	movwf	LCDVALUE
	movlw	1
	movwf	LCDVALUE_H
	call	PRINT437
	pagesel	$
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;CLS
	call	CLS_T6963
	pagesel	$
;LCDBox
	call	LCDBOX
;Locate 2, 2
	movlw	2
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print"Page 0"
	movlw	low StringTable4
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable4) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;Locate 3, 20
	movlw	3
	movwf	LCDLINE
	movlw	20
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print "Address: 0x"
	movlw	low StringTable5
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable5) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;Print hex(current_text_home_addr_h)
	movf	CURRENT_TEXT_HOME_ADDR_H,W
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;Print hex(current_text_home_addr)
	movf	CURRENT_TEXT_HOME_ADDR,W
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;locate 5,2
	movlw	5
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;print "LCD methods used to create page"
	movlw	low StringTable6
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable6) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;SelectLCDPage ( LCDPage1_T6963 )
	movlw	64
	movwf	ADDR
	movlw	1
	movwf	ADDR_H
	pagesel	SELECTLCDPAGE_T6963
	call	SELECTLCDPAGE_T6963
	pagesel	$
;CLS
	call	CLS_T6963
	pagesel	$
;LCDBox
	call	LCDBOX
;Locate 2, 2
	movlw	2
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print"Page 1"
	movlw	low StringTable7
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable7) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;Locate 3, 20
	movlw	3
	movwf	LCDLINE
	movlw	20
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print "Address: 0x"
	movlw	low StringTable5
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable5) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;Print hex(current_text_home_addr_h)
	movf	CURRENT_TEXT_HOME_ADDR_H,W
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;Print hex(current_text_home_addr)
	movf	CURRENT_TEXT_HOME_ADDR,W
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;locate 5,2
	movlw	5
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;print "LCD methods used to create page"
	movlw	low StringTable6
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable6) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;SelectLCDPage ( LCDPage2_T6963 )
	movlw	128
	movwf	ADDR
	movlw	2
	movwf	ADDR_H
	pagesel	SELECTLCDPAGE_T6963
	call	SELECTLCDPAGE_T6963
	pagesel	$
;CLS
	call	CLS_T6963
	pagesel	$
;LCDBox
	call	LCDBOX
;Locate 2, 2
	movlw	2
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print"Page 2"
	movlw	low StringTable8
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable8) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;Locate 3, 20
	movlw	3
	movwf	LCDLINE
	movlw	20
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print "Address: 0x"
	movlw	low StringTable5
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable5) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;Print hex(current_text_home_addr_h)
	movf	CURRENT_TEXT_HOME_ADDR_H,W
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;Print hex(current_text_home_addr)
	movf	CURRENT_TEXT_HOME_ADDR,W
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;locate 5,2
	movlw	5
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;print "LCD methods used to create page"
	movlw	low StringTable6
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable6) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;SelectLCDPage ( LCDPage3_T6963 )
	movlw	192
	movwf	ADDR
	movlw	3
	movwf	ADDR_H
	pagesel	SELECTLCDPAGE_T6963
	call	SELECTLCDPAGE_T6963
	pagesel	$
;CLS
	call	CLS_T6963
	pagesel	$
;LCDBox
	call	LCDBOX
;Locate 2, 2
	movlw	2
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print"Page 3"
	movlw	low StringTable9
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable9) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;Locate 3, 20
	movlw	3
	movwf	LCDLINE
	movlw	20
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print "Address: 0x"
	movlw	low StringTable5
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable5) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;Print hex(current_text_home_addr_h)
	movf	CURRENT_TEXT_HOME_ADDR_H,W
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;Print hex(current_text_home_addr)
	movf	CURRENT_TEXT_HOME_ADDR,W
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;locate 5,2
	movlw	5
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;print "LCD methods used to create page"
	movlw	low StringTable6
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable6) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;SelectLCDPage ( LCDPage4_T6963 )
	clrf	ADDR
	movlw	5
	movwf	ADDR_H
	pagesel	SELECTLCDPAGE_T6963
	call	SELECTLCDPAGE_T6963
	pagesel	$
;CLS
	call	CLS_T6963
	pagesel	$
;LCDBox
	call	LCDBOX
;Locate 2, 2
	movlw	2
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print"Page 4"
	movlw	low StringTable10
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable10) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;Locate 3, 20
	movlw	3
	movwf	LCDLINE
	movlw	20
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print "Address: 0x"
	movlw	low StringTable5
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable5) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;Print hex(current_text_home_addr_h)
	movf	CURRENT_TEXT_HOME_ADDR_H,W
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;Print hex(current_text_home_addr)
	movf	CURRENT_TEXT_HOME_ADDR,W
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;locate 5,2
	movlw	5
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;print "LCD methods used to create page"
	movlw	low StringTable6
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable6) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;SelectLCDPage ( LCDPage5_T6963 )
	movlw	64
	movwf	ADDR
	movlw	6
	movwf	ADDR_H
	pagesel	SELECTLCDPAGE_T6963
	call	SELECTLCDPAGE_T6963
	pagesel	$
;CLS
	call	CLS_T6963
	pagesel	$
;LCDBox
	call	LCDBOX
;Locate 2, 2
	movlw	2
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print"Page 5"
	movlw	low StringTable11
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable11) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;Locate 3, 20
	movlw	3
	movwf	LCDLINE
	movlw	20
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print "Address: 0x"
	movlw	low StringTable5
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable5) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;Print hex(current_text_home_addr_h)
	movf	CURRENT_TEXT_HOME_ADDR_H,W
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;Print hex(current_text_home_addr)
	movf	CURRENT_TEXT_HOME_ADDR,W
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;locate 5,2
	movlw	5
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;print "LCD methods used to create page"
	movlw	low StringTable6
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable6) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;SelectLCDPage ( LCDPage6_T6963 )
	movlw	128
	movwf	ADDR
	movlw	7
	movwf	ADDR_H
	pagesel	SELECTLCDPAGE_T6963
	call	SELECTLCDPAGE_T6963
	pagesel	$
;CLS
	call	CLS_T6963
	pagesel	$
;LCDBox
	call	LCDBOX
;Locate 2, 2
	movlw	2
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print"Page 6"
	movlw	low StringTable12
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable12) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;Locate 3, 20
	movlw	3
	movwf	LCDLINE
	movlw	20
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print "Address: 0x"
	movlw	low StringTable5
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable5) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;Print hex(current_text_home_addr_h)
	movf	CURRENT_TEXT_HOME_ADDR_H,W
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;Print hex(current_text_home_addr)
	movf	CURRENT_TEXT_HOME_ADDR,W
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;locate 5,2
	movlw	5
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;print "LCD methods used to create page"
	movlw	low StringTable6
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable6) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;SelectLCDPage ( LCDPage7_T6963 )
	movlw	192
	movwf	ADDR
	movlw	8
	movwf	ADDR_H
	pagesel	SELECTLCDPAGE_T6963
	call	SELECTLCDPAGE_T6963
	pagesel	$
;CLS
	call	CLS_T6963
	pagesel	$
;LCDBox
	call	LCDBOX
;Locate 2, 2
	movlw	2
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print"Page 7"
	movlw	low StringTable13
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable13) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;Locate 3, 20
	movlw	3
	movwf	LCDLINE
	movlw	20
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print "Address: 0x"
	movlw	low StringTable5
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable5) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;Print hex(current_text_home_addr_h)
	movf	CURRENT_TEXT_HOME_ADDR_H,W
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;Print hex(current_text_home_addr)
	movf	CURRENT_TEXT_HOME_ADDR,W
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;locate 5,2
	movlw	5
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;print "LCD methods used to create page"
	movlw	low StringTable6
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable6) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;SelectLCDPage ( LCDPage8_T6963 )
	clrf	ADDR
	movlw	10
	movwf	ADDR_H
	pagesel	SELECTLCDPAGE_T6963
	call	SELECTLCDPAGE_T6963
	pagesel	$
;CLS
	call	CLS_T6963
	pagesel	$
;LCDBox
	call	LCDBOX
;Locate 2, 2
	movlw	2
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print"Page 8"
	movlw	low StringTable14
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable14) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;Locate 3, 20
	movlw	3
	movwf	LCDLINE
	movlw	20
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print "Address: 0x"
	movlw	low StringTable5
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable5) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;Print hex(current_text_home_addr_h)
	movf	CURRENT_TEXT_HOME_ADDR_H,W
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;Print hex(current_text_home_addr)
	movf	CURRENT_TEXT_HOME_ADDR,W
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;locate 5,2
	movlw	5
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;print "LCD methods used to create page"
	movlw	low StringTable6
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable6) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;SelectLCDPage ( LCDPage9_T6963 )
	movlw	64
	movwf	ADDR
	movlw	11
	movwf	ADDR_H
	pagesel	SELECTLCDPAGE_T6963
	call	SELECTLCDPAGE_T6963
	pagesel	$
;CLS
	call	CLS_T6963
	pagesel	$
;LCDBox
	call	LCDBOX
;Locate 2, 2
	movlw	2
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print"Page 9"
	movlw	low StringTable15
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable15) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;Locate 3, 20
	movlw	3
	movwf	LCDLINE
	movlw	20
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print "Address: 0x"
	movlw	low StringTable5
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable5) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;Print hex(current_text_home_addr_h)
	movf	CURRENT_TEXT_HOME_ADDR_H,W
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;Print hex(current_text_home_addr)
	movf	CURRENT_TEXT_HOME_ADDR,W
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;locate 5,2
	movlw	5
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;print "LCD methods used to create page"
	movlw	low StringTable6
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable6) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;SelectLCDPage ( LCDPage10_T6963 )
	movlw	128
	movwf	ADDR
	movlw	12
	movwf	ADDR_H
	pagesel	SELECTLCDPAGE_T6963
	call	SELECTLCDPAGE_T6963
	pagesel	$
;CLS
	call	CLS_T6963
	pagesel	$
;LCDBox
	call	LCDBOX
;Locate 2, 2
	movlw	2
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print"Page 10"
	movlw	low StringTable16
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable16) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;Locate 3, 20
	movlw	3
	movwf	LCDLINE
	movlw	20
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print "Address: 0x"
	movlw	low StringTable5
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable5) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;Print hex(current_text_home_addr_h)
	movf	CURRENT_TEXT_HOME_ADDR_H,W
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;Print hex(current_text_home_addr)
	movf	CURRENT_TEXT_HOME_ADDR,W
	movwf	SYSVALTEMP
	pagesel	FN_HEX
	call	FN_HEX
	pagesel	$
	movlw	low HEX
	movwf	SysPRINTDATAHandler
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;locate 5,2
	movlw	5
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;print "LCD methods used to create page"
	movlw	low StringTable6
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable6) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;wait 2 s
	movlw	2
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;Swap pages back into focus
;SelectLCDPage ( LCDPage0_T6963 )
	clrf	ADDR
	clrf	ADDR_H
	pagesel	SELECTLCDPAGE_T6963
	call	SELECTLCDPAGE_T6963
	pagesel	$
;Locate 5, 2
	movlw	5
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print"Page 0 swapped into focus"
	movlw	low StringTable17
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable17) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;LCDSpace 6
	movlw	6
	movwf	LCDVALUE
	pagesel	LCDSPACE_T6963
	call	LCDSPACE_T6963
	pagesel	$
;Wait 2 s
	movlw	2
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;SelectLCDPage ( LCDPage1_T6963 )
	movlw	64
	movwf	ADDR
	movlw	1
	movwf	ADDR_H
	pagesel	SELECTLCDPAGE_T6963
	call	SELECTLCDPAGE_T6963
	pagesel	$
;Locate 5, 2
	movlw	5
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print"Page 1 swapped into focus"
	movlw	low StringTable18
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable18) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;LCDSpace 6
	movlw	6
	movwf	LCDVALUE
	pagesel	LCDSPACE_T6963
	call	LCDSPACE_T6963
	pagesel	$
;Wait 2 s
	movlw	2
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;SelectLCDPage ( LCDPage2_T6963 )
	movlw	128
	movwf	ADDR
	movlw	2
	movwf	ADDR_H
	pagesel	SELECTLCDPAGE_T6963
	call	SELECTLCDPAGE_T6963
	pagesel	$
;Locate 5, 2
	movlw	5
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print"Page 2 swapped into focus"
	movlw	low StringTable19
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable19) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;LCDSpace 6
	movlw	6
	movwf	LCDVALUE
	pagesel	LCDSPACE_T6963
	call	LCDSPACE_T6963
	pagesel	$
;Wait 2 s
	movlw	2
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;SelectLCDPage ( LCDPage3_T6963 )
	movlw	192
	movwf	ADDR
	movlw	3
	movwf	ADDR_H
	pagesel	SELECTLCDPAGE_T6963
	call	SELECTLCDPAGE_T6963
	pagesel	$
;Locate 5, 2
	movlw	5
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print"Page 3 swapped into focus"
	movlw	low StringTable20
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable20) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;LCDSpace 6
	movlw	6
	movwf	LCDVALUE
	pagesel	LCDSPACE_T6963
	call	LCDSPACE_T6963
	pagesel	$
;Wait 2 s
	movlw	2
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;SelectLCDPage ( LCDPage4_T6963 )
	clrf	ADDR
	movlw	5
	movwf	ADDR_H
	pagesel	SELECTLCDPAGE_T6963
	call	SELECTLCDPAGE_T6963
	pagesel	$
;Locate 5, 2
	movlw	5
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print"Page 4 swapped into focus"
	movlw	low StringTable21
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable21) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;LCDSpace 6
	movlw	6
	movwf	LCDVALUE
	pagesel	LCDSPACE_T6963
	call	LCDSPACE_T6963
	pagesel	$
;Wait 2 s
	movlw	2
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;SelectLCDPage ( LCDPage5_T6963 )
	movlw	64
	movwf	ADDR
	movlw	6
	movwf	ADDR_H
	pagesel	SELECTLCDPAGE_T6963
	call	SELECTLCDPAGE_T6963
	pagesel	$
;Locate 5, 2
	movlw	5
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print"Page 5 swapped into focus"
	movlw	low StringTable22
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable22) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;LCDSpace 6
	movlw	6
	movwf	LCDVALUE
	pagesel	LCDSPACE_T6963
	call	LCDSPACE_T6963
	pagesel	$
;Wait 2 s
	movlw	2
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;SelectLCDPage ( LCDPage6_T6963 )
	movlw	128
	movwf	ADDR
	movlw	7
	movwf	ADDR_H
	pagesel	SELECTLCDPAGE_T6963
	call	SELECTLCDPAGE_T6963
	pagesel	$
;Locate 5, 2
	movlw	5
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print"Page 6 swapped into focus"
	movlw	low StringTable23
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable23) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;LCDSpace 6
	movlw	6
	movwf	LCDVALUE
	pagesel	LCDSPACE_T6963
	call	LCDSPACE_T6963
	pagesel	$
;Wait 2 s
	movlw	2
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;SelectLCDPage ( LCDPage7_T6963 )
	movlw	192
	movwf	ADDR
	movlw	8
	movwf	ADDR_H
	pagesel	SELECTLCDPAGE_T6963
	call	SELECTLCDPAGE_T6963
	pagesel	$
;Locate 5, 2
	movlw	5
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print"Page 7 swapped into focus"
	movlw	low StringTable24
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable24) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;LCDSpace 6
	movlw	6
	movwf	LCDVALUE
	pagesel	LCDSPACE_T6963
	call	LCDSPACE_T6963
	pagesel	$
;Wait 2 s
	movlw	2
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;SelectLCDPage ( LCDPage8_T6963 )
	clrf	ADDR
	movlw	10
	movwf	ADDR_H
	pagesel	SELECTLCDPAGE_T6963
	call	SELECTLCDPAGE_T6963
	pagesel	$
;Locate 5, 2
	movlw	5
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print"Page 8 swapped into focus"
	movlw	low StringTable25
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable25) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;LCDSpace 6
	movlw	6
	movwf	LCDVALUE
	pagesel	LCDSPACE_T6963
	call	LCDSPACE_T6963
	pagesel	$
;Wait 2 s
	movlw	2
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;SelectLCDPage ( LCDPage9_T6963 )
	movlw	64
	movwf	ADDR
	movlw	11
	movwf	ADDR_H
	pagesel	SELECTLCDPAGE_T6963
	call	SELECTLCDPAGE_T6963
	pagesel	$
;Locate 5, 2
	movlw	5
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print"Page 9 swapped into focus"
	movlw	low StringTable26
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable26) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;LCDSpace 6
	movlw	6
	movwf	LCDVALUE
	pagesel	LCDSPACE_T6963
	call	LCDSPACE_T6963
	pagesel	$
;Wait 2 s
	movlw	2
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
	pagesel	$
;SelectLCDPage ( LCDPage10_T6963 )
	movlw	128
	movwf	ADDR
	movlw	12
	movwf	ADDR_H
	pagesel	SELECTLCDPAGE_T6963
	call	SELECTLCDPAGE_T6963
	pagesel	$
;Locate 5, 2
	movlw	5
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print"Page 10 swapped into focus"
	movlw	low StringTable27
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable27) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;LCDSpace 6
	movlw	6
	movwf	LCDVALUE
	pagesel	LCDSPACE_T6963
	call	LCDSPACE_T6963
	pagesel	$
;Wait 2 s
	movlw	2
	movwf	SysWaitTempS
	pagesel	Delay_S
	call	Delay_S
;ShowLoop
	pagesel	SHOWLOOP
	call	SHOWLOOP
	pagesel	$
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
	movwf	ROW_T6963
	movwf	ROW_T6963_H
SysForLoop4
	incf	ROW_T6963,F
	btfsc	STATUS,Z
	incf	ROW_T6963_H,F
;write blank to clear screen the first page only, col = 0...(COLUMN-1)
;for col_T6963 = 0 to COLUMN - 1
	movlw	255
	movwf	COL_T6963
	movwf	COL_T6963_H
SysForLoop5
	incf	COL_T6963,F
	btfsc	STATUS,Z
	incf	COL_T6963_H,F
;GLCDispAutoDataWr_T6963 ( 0 )
	clrf	LCDDATABYTE
	pagesel	GLCDISPAUTODATAWR_T6963
	call	GLCDISPAUTODATAWR_T6963
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
	goto	SysForLoop5
ENDIF11
SysForLoopEnd5
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
	goto	SysForLoop4
ENDIF12
SysForLoopEnd4
;GLCDSendCommand_T6963(AUTO_WR_OFF)
	movlw	178
	movwf	LCDCMDBYTE
	pagesel	GLCDSENDCOMMAND_T6963
	call	GLCDSENDCOMMAND_T6963
	pagesel	$
;GLCDCmdAddrSend_T6963(current_text_home_addr,ADDR_PTR_SET)
	movf	CURRENT_TEXT_HOME_ADDR,W
	movwf	LCDDATAWORD
	movf	CURRENT_TEXT_HOME_ADDR_H,W
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
	goto	GLCDSENDCOMMAND_T6963

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

LCDBOX
;Dim Xposition, Yposition as byte
;locate 20, 4
	movlw	20
	movwf	LCDLINE
	movlw	4
	movwf	LCDCOLUMN
	call	LOCATE_T6963
	pagesel	$
;Print "Put ( row, column, ascii character )"
	movlw	low StringTable41
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable41) | 128
	movwf	SysPRINTDATAHandler_H
	pagesel	PRINT435
	call	PRINT435
	pagesel	$
;for Yposition = 0 to MAX_ROWS -1
	movlw	255
	movwf	YPOSITION
SysForLoop1
	incf	YPOSITION,F
;put Yposition, 0, "*"
	movf	YPOSITION,W
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
	movf	YPOSITION,W
	movwf	SysBYTETempA
	movlw	7
	movwf	SysBYTETempB
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop1
ENDIF2
SysForLoopEnd1
;for Xposition = 0 to MAX_COLUMNS -1
	movlw	255
	movwf	XPOSITION
SysForLoop2
	incf	XPOSITION,F
;put 0, Xposition ,"*"
	clrf	LCDPUTLINE
	movf	XPOSITION,W
	movwf	LCDPUTCOLUMN
	movlw	42
	movwf	LCDCHAR
	pagesel	PUT_T6963
	call	PUT_T6963
	pagesel	$
;put MAX_ROWS -1, Xposition, "*"
	movlw	7
	movwf	LCDPUTLINE
	movf	XPOSITION,W
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
	movf	XPOSITION,W
	movwf	SysBYTETempA
	movlw	39
	movwf	SysBYTETempB
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop2
ENDIF4
SysForLoopEnd2
;for Yposition = 0 to MAX_ROWS -1
	movlw	255
	movwf	YPOSITION
SysForLoop3
	incf	YPOSITION,F
;put Yposition, MAX_COLUMNS -1 , "*"
	movf	YPOSITION,W
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
	movf	YPOSITION,W
	movwf	SysBYTETempA
	movlw	7
	movwf	SysBYTETempB
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop3
ENDIF6
SysForLoopEnd3
	return

;********************************************************************************

LCDNORMALWRITEBYTE_T6963
;GLCDSendData_T6963( LCDByte - 0x20 )      'Adjust standard ASCII to T6963 ASCII
	movlw	32
	subwf	LCDBYTE,W
	movwf	LCDDATABYTE
	pagesel	GLCDSENDDATA_T6963
	call	GLCDSENDDATA_T6963
	pagesel	$
;GLCDSendCommand_T6963(DATA_WR_INC)          'Address pointer increment ON
	movlw	192
	movwf	LCDCMDBYTE
	pagesel	GLCDSENDCOMMAND_T6963
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
;addr = (LCDLine*[word]COLUMN) + [word]LCDColumn + [word]current_text_home_addr
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
	movwf	SysTemp1
	movf	SysWORDTempX_H,W
	movwf	SysTemp1_H
	movf	LCDCOLUMN,W
	addwf	SysTemp1,W
	movwf	SysTemp2
	movlw	0
	addwfc	SysTemp1_H,W
	movwf	SysTemp2_H
	movf	CURRENT_TEXT_HOME_ADDR,W
	addwf	SysTemp2,W
	movwf	ADDR
	movf	CURRENT_TEXT_HOME_ADDR_H,W
	addwfc	SysTemp2_H,W
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

;Overloaded signature: WORD:
PRINT437
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
	goto	ENDIF29
;LCDValueTemp = LCDValue / 10000 [word]
	movf	LCDVALUE,W
	movwf	SysWORDTempA
	movf	LCDVALUE_H,W
	movwf	SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB
	movlw	39
	movwf	SysWORDTempB_H
	call	SysDivSub16
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
	call	LCDNORMALWRITEBYTE_T6963
	pagesel	$
;Goto LCDPrintWord1000
	goto	LCDPRINTWORD1000
;End If
ENDIF29
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
	goto	ENDIF30
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
	call	SysDivSub16
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
	call	LCDNORMALWRITEBYTE_T6963
	pagesel	$
;Goto LCDPrintWord100
	goto	LCDPRINTWORD100
;End If
ENDIF30
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
	goto	ENDIF31
LCDPRINTWORD100
;LCDValueTemp = LCDValue / 100 [word]
	movf	LCDVALUE,W
	movwf	SysWORDTempA
	movf	LCDVALUE_H,W
	movwf	SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysDivSub16
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
	call	LCDNORMALWRITEBYTE_T6963
	pagesel	$
;Goto LCDPrintWord10
	goto	LCDPRINTWORD10
;End If
ENDIF31
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
	goto	ENDIF32
LCDPRINTWORD10
;LCDValueTemp = LCDValue / 10 [word]
	movf	LCDVALUE,W
	movwf	SysWORDTempA
	movf	LCDVALUE_H,W
	movwf	SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	call	SysDivSub16
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
	call	LCDNORMALWRITEBYTE_T6963
	pagesel	$
;End If
ENDIF32
;LCDWriteByte (LCDValue + 48)
	movlw	48
	addwf	LCDVALUE,W
	movwf	LCDBYTE
	goto	LCDNORMALWRITEBYTE_T6963

;********************************************************************************

;Overloaded signature: BYTE:
FN_READAD10332
;Always RIGHT justified
;SET ADFM ON
	banksel	ADCON1
	bsf	ADCON1,ADFM
;Do conversion
;LLReadAD 0
;ANSEL0/ANSEL
;Code for devcies with ANSELA/ANSELB/ANSELE registers
;Select Case ADReadPort ' #IFDEF Var(ANSELA). ANSELA exists @DebugADC_H
;#ifNdef Bit(CHS5) ChipPins = 28  Or ChipPins = 40 @DebugADC_H
;Case 0: Set ANSELA.0 On
SysSelect2Case1
	banksel	ADREADPORT
	movf	ADREADPORT,F
	btfss	STATUS, Z
	goto	SysSelect2Case2
	banksel	ANSELA
	bsf	ANSELA,0
;Case 1: Set ANSELA.1 On
	goto	SysSelectEnd2
SysSelect2Case2
	decf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case3
	banksel	ANSELA
	bsf	ANSELA,1
;Case 2: Set ANSELA.2 On
	goto	SysSelectEnd2
SysSelect2Case3
	movlw	2
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case4
	banksel	ANSELA
	bsf	ANSELA,2
;Case 3: Set ANSELA.3 On
	goto	SysSelectEnd2
SysSelect2Case4
	movlw	3
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case5
	banksel	ANSELA
	bsf	ANSELA,3
;Case 4: Set ANSELA.5 On
	goto	SysSelectEnd2
SysSelect2Case5
	movlw	4
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case6
	banksel	ANSELA
	bsf	ANSELA,5
;Case 12: Set ANSELB.0 On
	goto	SysSelectEnd2
SysSelect2Case6
	movlw	12
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case7
	banksel	ANSELB
	bsf	ANSELB,0
;Case 10: Set ANSELB.1 On
	goto	SysSelectEnd2
SysSelect2Case7
	movlw	10
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case8
	banksel	ANSELB
	bsf	ANSELB,1
;Case 8: Set ANSELB.2 On
	goto	SysSelectEnd2
SysSelect2Case8
	movlw	8
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case9
	banksel	ANSELB
	bsf	ANSELB,2
;Case 9: Set ANSELB.3 On
	goto	SysSelectEnd2
SysSelect2Case9
	movlw	9
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case10
	banksel	ANSELB
	bsf	ANSELB,3
;Case 11: Set ANSELB.4 On
	goto	SysSelectEnd2
SysSelect2Case10
	movlw	11
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case11
	banksel	ANSELB
	bsf	ANSELB,4
;Case 13: Set ANSELB.5 On
	goto	SysSelectEnd2
SysSelect2Case11
	movlw	13
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case12
	banksel	ANSELB
	bsf	ANSELB,5
;Case 20: Set ANSELD.0 On
	goto	SysSelectEnd2
SysSelect2Case12
	movlw	20
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case13
	banksel	ANSELD
	bsf	ANSELD,0
;Case 21: Set ANSELD.1 On
	goto	SysSelectEnd2
SysSelect2Case13
	movlw	21
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case14
	banksel	ANSELD
	bsf	ANSELD,1
;Case 22: Set ANSELD.2 On
	goto	SysSelectEnd2
SysSelect2Case14
	movlw	22
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case15
	banksel	ANSELD
	bsf	ANSELD,2
;Case 23: Set ANSELD.3 On
	goto	SysSelectEnd2
SysSelect2Case15
	movlw	23
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case16
	banksel	ANSELD
	bsf	ANSELD,3
;Case 24: Set ANSELD.4 On
	goto	SysSelectEnd2
SysSelect2Case16
	movlw	24
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case17
	banksel	ANSELD
	bsf	ANSELD,4
;Case 25: Set ANSELD.5 On
	goto	SysSelectEnd2
SysSelect2Case17
	movlw	25
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case18
	banksel	ANSELD
	bsf	ANSELD,5
;Case 26: Set ANSELD.6 On
	goto	SysSelectEnd2
SysSelect2Case18
	movlw	26
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case19
	banksel	ANSELD
	bsf	ANSELD,6
;Case 27: Set ANSELD.7 On
	goto	SysSelectEnd2
SysSelect2Case19
	movlw	27
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case20
	banksel	ANSELD
	bsf	ANSELD,7
;Case 5: Set ANSELE.0 On
	goto	SysSelectEnd2
SysSelect2Case20
	movlw	5
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case21
	banksel	ANSELE
	bsf	ANSELE,0
;Case 6: Set ANSELE.1 On
	goto	SysSelectEnd2
SysSelect2Case21
	movlw	6
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelect2Case22
	banksel	ANSELE
	bsf	ANSELE,1
;Case 7: Set ANSELE.2 On
	goto	SysSelectEnd2
SysSelect2Case22
	movlw	7
	subwf	ADREADPORT,W
	btfss	STATUS, Z
	goto	SysSelectEnd2
	banksel	ANSELE
	bsf	ANSELE,2
;End Select  'End Select #1
SysSelectEnd2
;Set conversion clock - improved to handle ADCS2
;SET ADCS2 OFF
	banksel	ADCON1
	bcf	ADCON1,ADCS2
;SET ADCS1 OFF
	bcf	ADCON1,ADCS1
;SET ADCS0 ON
	bsf	ADCON1,ADCS0
;Choose port
;SET CHS0 OFF
	bcf	ADCON0,CHS0
;SET CHS1 OFF
	bcf	ADCON0,CHS1
;SET CHS2 OFF
	bcf	ADCON0,CHS2
;SET CHS3 OFF
	bcf	ADCON0,CHS3
;SET CHS4 OFF
	bcf	ADCON0,CHS4
;IF ADReadPort.0 On Then Set CHS0 On
	banksel	ADREADPORT
	btfss	ADREADPORT,0
	goto	ENDIF21
	banksel	ADCON0
	bsf	ADCON0,CHS0
ENDIF21
;IF ADReadPort.1 On Then Set CHS1 On
	banksel	ADREADPORT
	btfss	ADREADPORT,1
	goto	ENDIF22
	banksel	ADCON0
	bsf	ADCON0,CHS1
ENDIF22
;IF ADReadPort.2 On Then Set CHS2 On
	banksel	ADREADPORT
	btfss	ADREADPORT,2
	goto	ENDIF23
	banksel	ADCON0
	bsf	ADCON0,CHS2
ENDIF23
;If ADReadPort.3 On Then Set CHS3 On
	banksel	ADREADPORT
	btfss	ADREADPORT,3
	goto	ENDIF24
	banksel	ADCON0
	bsf	ADCON0,CHS3
ENDIF24
;If ADReadPort.4 On Then Set CHS4 On
	banksel	ADREADPORT
	btfss	ADREADPORT,4
	goto	ENDIF25
	banksel	ADCON0
	bsf	ADCON0,CHS4
ENDIF25
;Enable A/D
;SET ADON ON
	banksel	ADCON0
	bsf	ADCON0,ADON
;Acquisition Delay
;Wait AD_Delay
	movlw	2
	movwf	SysWaitTemp10US
	banksel	STATUS
	pagesel	Delay_10US
	call	Delay_10US
	pagesel	$
;Read A/D
;SET GO_NOT_DONE ON
	banksel	ADCON0
	bsf	ADCON0,GO_NOT_DONE
;nop
	nop
;Wait While GO_NOT_DONE ON
SysWaitLoop4
	btfsc	ADCON0,GO_NOT_DONE
	goto	SysWaitLoop4
;Switch off A/D
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON
;Clear whatever ANSEL variants the chip has
;ANSELA = 0
	banksel	ANSELA
	clrf	ANSELA
;ANSELB = 0
	clrf	ANSELB
;ANSELD = 0
	clrf	ANSELD
;ANSELE = 0
	clrf	ANSELE
;Write output
;ReadAD10 = ADRESL
	banksel	ADRESL
	movf	ADRESL,W
	banksel	READAD10
	movwf	READAD10
	clrf	READAD10_H
;ReadAD10_H = ADRESH
	banksel	ADRESH
	movf	ADRESH,W
	banksel	READAD10_H
	movwf	READAD10_H
;Put A/D format back to normal
;SET ADFM OFF
	banksel	ADCON1
	bcf	ADCON1,ADFM
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
	goto	ENDIF35
;SysWordTempA = 0
	clrf	SYSWORDTEMPA
	clrf	SYSWORDTEMPA_H
;exit sub
	return
;end if
ENDIF35
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
	goto	ENDIF36
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	addwfc	SYSDIVMULTX_H,F
;End If
ENDIF36
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

;Start of program memory page 1
	ORG	2048
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
ENDIF18
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
ENDIF19
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
	movwf	ROW_T6963
SysForLoop6
	incf	ROW_T6963,F
;write blank to clear screen the first page only, col = 0...(COLUMN-1)
;for col_T6963 = 0 to COLUMN - 1
	movlw	255
	movwf	COL_T6963
SysForLoop7
	incf	COL_T6963,F
;GLCDispAutoDataWr_T6963 ( 0x00 )
	clrf	LCDDATABYTE
	call	GLCDISPAUTODATAWR_T6963
;next
	movf	COL_T6963,W
	movwf	SysBYTETempA
	movlw	39
	movwf	SysBYTETempB
	call	SysCompLessThan
	btfsc	SysByteTempX,0
	goto	SysForLoop7
ENDIF16
SysForLoopEnd7
;next
	movf	ROW_T6963,W
	movwf	SysBYTETempA
	movlw	63
	movwf	SysBYTETempB
	call	SysCompLessThan
	btfsc	SysByteTempX,0
	goto	SysForLoop6
ENDIF17
SysForLoopEnd6
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
	banksel	SYSTEMP2
	clrf	SysTemp2
	btfsc	PORTD,3
	incf	SysTemp2,F
ENDIF20
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

GLCDROTATE_T6963
;dim T6963_GLCD_HEIGHT, T6963_GLCD_WIDTH as word
;select case GLCDRotateState
;case LANDSCAPE   '0 degree
SysSelect1Case1
	decf	GLCDROTATESTATE,W
	btfss	STATUS, Z
	goto	SysSelect1Case2
;T6963_GLCD_WIDTH = GLCD_WIDTH
	movlw	240
	movwf	GLCDDEVICEWIDTH
	clrf	GLCDDEVICEWIDTH_H
;T6963_GLCD_HEIGHT = GLCD_HEIGHT
	movlw	64
	movwf	GLCDDEVICEHEIGHT
	clrf	GLCDDEVICEHEIGHT_H
;case Portrait
	goto	SysSelectEnd1
SysSelect1Case2
	movlw	4
	subwf	GLCDROTATESTATE,W
	btfss	STATUS, Z
	goto	SysSelect1Case3
;T6963_GLCD_WIDTH = GLCD_HEIGHT
	movlw	64
	movwf	GLCDDEVICEWIDTH
	clrf	GLCDDEVICEWIDTH_H
;T6963_GLCD_HEIGHT = GLCD_WIDTH
	movlw	240
	movwf	GLCDDEVICEHEIGHT
	clrf	GLCDDEVICEHEIGHT_H
;case LANDSCAPE_REV
	goto	SysSelectEnd1
SysSelect1Case3
	movlw	3
	subwf	GLCDROTATESTATE,W
	btfss	STATUS, Z
	goto	SysSelect1Case4
;T6963_GLCD_WIDTH = GLCD_WIDTH
	movlw	240
	movwf	GLCDDEVICEWIDTH
	clrf	GLCDDEVICEWIDTH_H
;T6963_GLCD_HEIGHT = GLCD_HEIGHT
	movlw	64
	movwf	GLCDDEVICEHEIGHT
	clrf	GLCDDEVICEHEIGHT_H
;case PORTRAIT_REV
	goto	SysSelectEnd1
SysSelect1Case4
	movlw	2
	subwf	GLCDROTATESTATE,W
	btfss	STATUS, Z
	goto	SysSelect1Case5
;T6963_GLCD_WIDTH = GLCD_HEIGHT
	movlw	64
	movwf	GLCDDEVICEWIDTH
	clrf	GLCDDEVICEWIDTH_H
;T6963_GLCD_HEIGHT = GLCD_WIDTH
	movlw	240
	movwf	GLCDDEVICEHEIGHT
	clrf	GLCDDEVICEHEIGHT_H
;case else
	goto	SysSelectEnd1
SysSelect1Case5
;T6963_GLCD_WIDTH = GLCD_WIDTH
	movlw	240
	movwf	GLCDDEVICEWIDTH
	clrf	GLCDDEVICEWIDTH_H
;T6963_GLCD_HEIGHT = GLCD_HEIGHT
	movlw	64
	movwf	GLCDDEVICEHEIGHT
	clrf	GLCDDEVICEHEIGHT_H
;end select
SysSelectEnd1
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
	goto	ENDIF37
	movlw	7
	addwf	SYSSTRINGTEMP,F
ENDIF37
;Hex(2) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W
	banksel	SYSHEX_2
	movwf	SYSHEX_2
;Get high nibble
;For SysStringTemp = 1 to 4
	banksel	SYSSTRINGTEMP
	clrf	SYSSTRINGTEMP
SysForLoop9
	incf	SYSSTRINGTEMP,F
;Rotate SysValTemp Right
	rrf	SYSVALTEMP,F
;Next
	movlw	4
	subwf	SYSSTRINGTEMP,W
	btfss	STATUS, C
	goto	SysForLoop9
ENDIF38
SysForLoopEnd9
;SysStringTemp = SysValTemp And 0x0F
	movlw	15
	andwf	SYSVALTEMP,W
	movwf	SYSSTRINGTEMP
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	sublw	9
	btfsc	STATUS, C
	goto	ENDIF39
	movlw	7
	addwf	SYSSTRINGTEMP,F
ENDIF39
;Hex(1) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W
	banksel	SYSHEX_1
	movwf	SYSHEX_1
	banksel	STATUS
	return

;********************************************************************************

LCDSPACE_T6963
;if LCDValue > COLUMN then LCDValue = COLUMN
	movf	LCDVALUE,W
	sublw	40
	btfsc	STATUS, C
	goto	ENDIF13
	movlw	40
	movwf	LCDVALUE
ENDIF13
;do until LCDValue = 0
SysDoLoop_S2
	movf	LCDVALUE,F
	btfsc	STATUS, Z
	goto	SysDoLoop_E2
;Print " "
	movlw	low StringTable76
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable76) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT435
;LCDValue --
	decf	LCDVALUE,F
;loop
	goto	SysDoLoop_S2
SysDoLoop_E2
	return

;********************************************************************************

;Overloaded signature: STRING:
PRINT435
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
ENDIF26
;Set LCD_RS On
	bsf	SYSLCDTEMP,1
;Write Data
;For SysPrintTemp = 1 To PrintLen
	clrf	SYSPRINTTEMP
	movlw	1
	subwf	PRINTLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd8
ENDIF27
SysForLoop8
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
	goto	SysForLoop8
ENDIF28
SysForLoopEnd8
	return

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

SELECTLCDPAGE_T6963
;dim current_text_home_addr as word
;GLCDCmdAddrSend_T6963( addr , TEXT_HOME_SET )
	movf	ADDR,W
	movwf	LCDDATAWORD
	movf	ADDR_H,W
	movwf	LCDDATAWORD_H
	movlw	64
	movwf	LCDCMDBYTE
	call	GLCDCMDADDRSEND_T6963
;current_text_home_addr = addr
	movf	ADDR,W
	movwf	CURRENT_TEXT_HOME_ADDR
	movf	ADDR_H,W
	movwf	CURRENT_TEXT_HOME_ADDR_H
	return

;********************************************************************************

SHOWLOOP
;do Forever
SysDoLoop_S1
;dim adcwait as Word
;SelectLCDPage ( LCDPage0_T6963 )
	clrf	ADDR
	clrf	ADDR_H
	call	SELECTLCDPAGE_T6963
;Locate 5, 2
	movlw	5
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;Print"Page 0 swapped on timeout"
	movlw	low StringTable28
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable28) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT435
;LCDSpace 7
	movlw	7
	movwf	LCDVALUE
	call	LCDSPACE_T6963
;adcwait = ReadAD10(an12)
	movlw	12
	movwf	ADREADPORT
	pagesel	FN_READAD10332
	call	FN_READAD10332
	pagesel	$
	movf	SYSREADAD10WORD,W
	movwf	ADCWAIT
	movf	SYSREADAD10WORD_H,W
	movwf	ADCWAIT_H
;Print "ADC/Wait: ": Print adcwait
	movlw	low StringTable29
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable29) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT435
	movf	ADCWAIT,W
	movwf	LCDVALUE
	movf	ADCWAIT_H,W
	movwf	LCDVALUE_H
	pagesel	PRINT437
	call	PRINT437
	pagesel	$
;print "  "
	movlw	low StringTable30
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable30) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT435
;Wait adcwait ms
	movf	ADCWAIT,W
	movwf	SysWaitTempMS
	movf	ADCWAIT_H,W
	movwf	SysWaitTempMS_H
	call	Delay_MS
;SelectLCDPage ( LCDPage1_T6963 )
	movlw	64
	movwf	ADDR
	movlw	1
	movwf	ADDR_H
	call	SELECTLCDPAGE_T6963
;Locate 5, 2
	movlw	5
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;Print"Page 1 swapped on timeout"
	movlw	low StringTable31
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable31) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT435
;LCDSpace 6
	movlw	6
	movwf	LCDVALUE
	call	LCDSPACE_T6963
;locate 6, 2
	movlw	6
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;adcwait = ReadAD10(an12)
	movlw	12
	movwf	ADREADPORT
	pagesel	FN_READAD10332
	call	FN_READAD10332
	pagesel	$
	movf	SYSREADAD10WORD,W
	movwf	ADCWAIT
	movf	SYSREADAD10WORD_H,W
	movwf	ADCWAIT_H
;Print "ADC/Wait: ": Print adcwait
	movlw	low StringTable29
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable29) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT435
	movf	ADCWAIT,W
	movwf	LCDVALUE
	movf	ADCWAIT_H,W
	movwf	LCDVALUE_H
	pagesel	PRINT437
	call	PRINT437
	pagesel	$
;print "  "
	movlw	low StringTable30
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable30) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT435
;Wait adcwait ms
	movf	ADCWAIT,W
	movwf	SysWaitTempMS
	movf	ADCWAIT_H,W
	movwf	SysWaitTempMS_H
	call	Delay_MS
;SelectLCDPage ( LCDPage2_T6963 )
	movlw	128
	movwf	ADDR
	movlw	2
	movwf	ADDR_H
	call	SELECTLCDPAGE_T6963
;Locate 5, 2
	movlw	5
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;Print"Page 2 swapped on timeout"
	movlw	low StringTable32
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable32) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT435
;LCDSpace 6
	movlw	6
	movwf	LCDVALUE
	call	LCDSPACE_T6963
;locate 6, 2
	movlw	6
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;adcwait = ReadAD10(an12)
	movlw	12
	movwf	ADREADPORT
	pagesel	FN_READAD10332
	call	FN_READAD10332
	pagesel	$
	movf	SYSREADAD10WORD,W
	movwf	ADCWAIT
	movf	SYSREADAD10WORD_H,W
	movwf	ADCWAIT_H
;Print "ADC/Wait: ": Print adcwait
	movlw	low StringTable29
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable29) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT435
	movf	ADCWAIT,W
	movwf	LCDVALUE
	movf	ADCWAIT_H,W
	movwf	LCDVALUE_H
	pagesel	PRINT437
	call	PRINT437
	pagesel	$
;print "  "
	movlw	low StringTable30
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable30) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT435
;Wait adcwait ms
	movf	ADCWAIT,W
	movwf	SysWaitTempMS
	movf	ADCWAIT_H,W
	movwf	SysWaitTempMS_H
	call	Delay_MS
;SelectLCDPage ( LCDPage3_T6963 )
	movlw	192
	movwf	ADDR
	movlw	3
	movwf	ADDR_H
	call	SELECTLCDPAGE_T6963
;Locate 5, 2
	movlw	5
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;Print"Page 3 swapped on timeout"
	movlw	low StringTable33
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable33) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT435
;LCDSpace 6
	movlw	6
	movwf	LCDVALUE
	call	LCDSPACE_T6963
;locate 6, 2
	movlw	6
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;adcwait = ReadAD10(an12)
	movlw	12
	movwf	ADREADPORT
	pagesel	FN_READAD10332
	call	FN_READAD10332
	pagesel	$
	movf	SYSREADAD10WORD,W
	movwf	ADCWAIT
	movf	SYSREADAD10WORD_H,W
	movwf	ADCWAIT_H
;Print "ADC/Wait: ": Print adcwait
	movlw	low StringTable29
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable29) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT435
	movf	ADCWAIT,W
	movwf	LCDVALUE
	movf	ADCWAIT_H,W
	movwf	LCDVALUE_H
	pagesel	PRINT437
	call	PRINT437
	pagesel	$
;print "  "
	movlw	low StringTable30
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable30) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT435
;Wait adcwait ms
	movf	ADCWAIT,W
	movwf	SysWaitTempMS
	movf	ADCWAIT_H,W
	movwf	SysWaitTempMS_H
	call	Delay_MS
;SelectLCDPage ( LCDPage4_T6963 )
	clrf	ADDR
	movlw	5
	movwf	ADDR_H
	call	SELECTLCDPAGE_T6963
;Locate 5, 2
	movlw	5
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;Print"Page 4 swapped on timeout"
	movlw	low StringTable34
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable34) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT435
;LCDSpace 6
	movlw	6
	movwf	LCDVALUE
	call	LCDSPACE_T6963
;locate 6, 2
	movlw	6
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;adcwait = ReadAD10(an12)
	movlw	12
	movwf	ADREADPORT
	pagesel	FN_READAD10332
	call	FN_READAD10332
	pagesel	$
	movf	SYSREADAD10WORD,W
	movwf	ADCWAIT
	movf	SYSREADAD10WORD_H,W
	movwf	ADCWAIT_H
;Print "ADC/Wait: ": Print adcwait
	movlw	low StringTable29
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable29) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT435
	movf	ADCWAIT,W
	movwf	LCDVALUE
	movf	ADCWAIT_H,W
	movwf	LCDVALUE_H
	pagesel	PRINT437
	call	PRINT437
	pagesel	$
;print "  "
	movlw	low StringTable30
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable30) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT435
;Wait adcwait ms
	movf	ADCWAIT,W
	movwf	SysWaitTempMS
	movf	ADCWAIT_H,W
	movwf	SysWaitTempMS_H
	call	Delay_MS
;SelectLCDPage ( LCDPage5_T6963 )
	movlw	64
	movwf	ADDR
	movlw	6
	movwf	ADDR_H
	call	SELECTLCDPAGE_T6963
;Locate 5, 2
	movlw	5
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;Print"Page 5 swapped on timeout"
	movlw	low StringTable35
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable35) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT435
;LCDSpace 6
	movlw	6
	movwf	LCDVALUE
	call	LCDSPACE_T6963
;locate 6, 2
	movlw	6
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;adcwait = ReadAD10(an12)
	movlw	12
	movwf	ADREADPORT
	pagesel	FN_READAD10332
	call	FN_READAD10332
	pagesel	$
	movf	SYSREADAD10WORD,W
	movwf	ADCWAIT
	movf	SYSREADAD10WORD_H,W
	movwf	ADCWAIT_H
;Print "ADC/Wait: ": Print adcwait
	movlw	low StringTable29
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable29) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT435
	movf	ADCWAIT,W
	movwf	LCDVALUE
	movf	ADCWAIT_H,W
	movwf	LCDVALUE_H
	pagesel	PRINT437
	call	PRINT437
	pagesel	$
;print "  "
	movlw	low StringTable30
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable30) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT435
;Wait adcwait ms
	movf	ADCWAIT,W
	movwf	SysWaitTempMS
	movf	ADCWAIT_H,W
	movwf	SysWaitTempMS_H
	call	Delay_MS
;SelectLCDPage ( LCDPage6_T6963 )
	movlw	128
	movwf	ADDR
	movlw	7
	movwf	ADDR_H
	call	SELECTLCDPAGE_T6963
;Locate 5, 2
	movlw	5
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;Print"Page 6 swapped on timeout"
	movlw	low StringTable36
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable36) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT435
;LCDSpace 6
	movlw	6
	movwf	LCDVALUE
	call	LCDSPACE_T6963
;locate 6, 2
	movlw	6
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;adcwait = ReadAD10(an12)
	movlw	12
	movwf	ADREADPORT
	pagesel	FN_READAD10332
	call	FN_READAD10332
	pagesel	$
	movf	SYSREADAD10WORD,W
	movwf	ADCWAIT
	movf	SYSREADAD10WORD_H,W
	movwf	ADCWAIT_H
;Print "ADC/Wait: ": Print adcwait
	movlw	low StringTable29
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable29) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT435
	movf	ADCWAIT,W
	movwf	LCDVALUE
	movf	ADCWAIT_H,W
	movwf	LCDVALUE_H
	pagesel	PRINT437
	call	PRINT437
	pagesel	$
;print "  "
	movlw	low StringTable30
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable30) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT435
;Wait adcwait ms
	movf	ADCWAIT,W
	movwf	SysWaitTempMS
	movf	ADCWAIT_H,W
	movwf	SysWaitTempMS_H
	call	Delay_MS
;SelectLCDPage ( LCDPage7_T6963 )
	movlw	192
	movwf	ADDR
	movlw	8
	movwf	ADDR_H
	call	SELECTLCDPAGE_T6963
;Locate 5, 2
	movlw	5
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;Print"Page 7 swapped on timeout"
	movlw	low StringTable37
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable37) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT435
;LCDSpace 6
	movlw	6
	movwf	LCDVALUE
	call	LCDSPACE_T6963
;locate 6, 2
	movlw	6
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;adcwait = ReadAD10(an12)
	movlw	12
	movwf	ADREADPORT
	pagesel	FN_READAD10332
	call	FN_READAD10332
	pagesel	$
	movf	SYSREADAD10WORD,W
	movwf	ADCWAIT
	movf	SYSREADAD10WORD_H,W
	movwf	ADCWAIT_H
;Print "ADC/Wait: ": Print adcwait
	movlw	low StringTable29
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable29) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT435
	movf	ADCWAIT,W
	movwf	LCDVALUE
	movf	ADCWAIT_H,W
	movwf	LCDVALUE_H
	pagesel	PRINT437
	call	PRINT437
	pagesel	$
;print "  "
	movlw	low StringTable30
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable30) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT435
;Wait adcwait ms
	movf	ADCWAIT,W
	movwf	SysWaitTempMS
	movf	ADCWAIT_H,W
	movwf	SysWaitTempMS_H
	call	Delay_MS
;SelectLCDPage ( LCDPage8_T6963 )
	clrf	ADDR
	movlw	10
	movwf	ADDR_H
	call	SELECTLCDPAGE_T6963
;Locate 5, 2
	movlw	5
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;Print"Page 8 swapped on timeout"
	movlw	low StringTable38
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable38) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT435
;LCDSpace 6
	movlw	6
	movwf	LCDVALUE
	call	LCDSPACE_T6963
;locate 6, 2
	movlw	6
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;adcwait = ReadAD10(an12)
	movlw	12
	movwf	ADREADPORT
	pagesel	FN_READAD10332
	call	FN_READAD10332
	pagesel	$
	movf	SYSREADAD10WORD,W
	movwf	ADCWAIT
	movf	SYSREADAD10WORD_H,W
	movwf	ADCWAIT_H
;Print "ADC/Wait: ": Print adcwait
	movlw	low StringTable29
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable29) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT435
	movf	ADCWAIT,W
	movwf	LCDVALUE
	movf	ADCWAIT_H,W
	movwf	LCDVALUE_H
	pagesel	PRINT437
	call	PRINT437
	pagesel	$
;print "  "
	movlw	low StringTable30
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable30) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT435
;Wait adcwait ms
	movf	ADCWAIT,W
	movwf	SysWaitTempMS
	movf	ADCWAIT_H,W
	movwf	SysWaitTempMS_H
	call	Delay_MS
;SelectLCDPage ( LCDPage9_T6963 )
	movlw	64
	movwf	ADDR
	movlw	11
	movwf	ADDR_H
	call	SELECTLCDPAGE_T6963
;Locate 5, 2
	movlw	5
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;Print"Page 9 swapped on timeout"
	movlw	low StringTable39
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable39) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT435
;LCDSpace 6
	movlw	6
	movwf	LCDVALUE
	call	LCDSPACE_T6963
;locate 6, 2
	movlw	6
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;adcwait = ReadAD10(an12)
	movlw	12
	movwf	ADREADPORT
	pagesel	FN_READAD10332
	call	FN_READAD10332
	pagesel	$
	movf	SYSREADAD10WORD,W
	movwf	ADCWAIT
	movf	SYSREADAD10WORD_H,W
	movwf	ADCWAIT_H
;Print "ADC/Wait: ": Print adcwait
	movlw	low StringTable29
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable29) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT435
	movf	ADCWAIT,W
	movwf	LCDVALUE
	movf	ADCWAIT_H,W
	movwf	LCDVALUE_H
	pagesel	PRINT437
	call	PRINT437
	pagesel	$
;print "  "
	movlw	low StringTable30
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable30) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT435
;Wait adcwait ms
	movf	ADCWAIT,W
	movwf	SysWaitTempMS
	movf	ADCWAIT_H,W
	movwf	SysWaitTempMS_H
	call	Delay_MS
;SelectLCDPage ( LCDPage10_T6963 )
	movlw	128
	movwf	ADDR
	movlw	12
	movwf	ADDR_H
	call	SELECTLCDPAGE_T6963
;Locate 5, 2
	movlw	5
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;Print"Page 10 swapped on timeout"
	movlw	low StringTable40
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable40) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT435
;LCDSpace 6
	movlw	6
	movwf	LCDVALUE
	call	LCDSPACE_T6963
;locate 6, 2
	movlw	6
	movwf	LCDLINE
	movlw	2
	movwf	LCDCOLUMN
	pagesel	LOCATE_T6963
	call	LOCATE_T6963
	pagesel	$
;adcwait = ReadAD10(an12)
	movlw	12
	movwf	ADREADPORT
	pagesel	FN_READAD10332
	call	FN_READAD10332
	pagesel	$
	movf	SYSREADAD10WORD,W
	movwf	ADCWAIT
	movf	SYSREADAD10WORD_H,W
	movwf	ADCWAIT_H
;Print "ADC/Wait: ": Print adcwait
	movlw	low StringTable29
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable29) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT435
	movf	ADCWAIT,W
	movwf	LCDVALUE
	movf	ADCWAIT_H,W
	movwf	LCDVALUE_H
	pagesel	PRINT437
	call	PRINT437
	pagesel	$
;print "  "
	movlw	low StringTable30
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable30) | 128
	movwf	SysPRINTDATAHandler_H
	call	PRINT435
;Wait adcwait ms
	movf	ADCWAIT,W
	movwf	SysWaitTempMS
	movf	ADCWAIT_H,W
	movwf	SysWaitTempMS_H
	call	Delay_MS
;loop
	goto	SysDoLoop_S1
SysDoLoop_E1
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
	goto	ENDIF33
	movf	SYSDIVMULTA,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTA_H,W
	addwfc	SYSDIVMULTX_H,F
ENDIF33
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
ENDIF34
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
	retlw	14
	retlw	76	;L
	retlw	67	;C
	retlw	68	;D
	retlw	80	;P
	retlw	65	;A
	retlw	71	;G
	retlw	69	;E
	retlw	83	;S
	retlw	73	;I
	retlw	90	;Z
	retlw	69	;E
	retlw	32	; 
	retlw	61	; (equals)
	retlw	32	; 


StringTable4
	retlw	6
	retlw	80	;P
	retlw	97	;a
	retlw	103	;g
	retlw	101	;e
	retlw	32	; 
	retlw	48	;0


StringTable5
	retlw	11
	retlw	65	;A
	retlw	100	;d
	retlw	100	;d
	retlw	114	;r
	retlw	101	;e
	retlw	115	;s
	retlw	115	;s
	retlw	58	;:
	retlw	32	; 
	retlw	48	;0
	retlw	120	;x


StringTable6
	retlw	31
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


StringTable7
	retlw	6
	retlw	80	;P
	retlw	97	;a
	retlw	103	;g
	retlw	101	;e
	retlw	32	; 
	retlw	49	;1


StringTable8
	retlw	6
	retlw	80	;P
	retlw	97	;a
	retlw	103	;g
	retlw	101	;e
	retlw	32	; 
	retlw	50	;2


StringTable9
	retlw	6
	retlw	80	;P
	retlw	97	;a
	retlw	103	;g
	retlw	101	;e
	retlw	32	; 
	retlw	51	;3


StringTable10
	retlw	6
	retlw	80	;P
	retlw	97	;a
	retlw	103	;g
	retlw	101	;e
	retlw	32	; 
	retlw	52	;4


StringTable11
	retlw	6
	retlw	80	;P
	retlw	97	;a
	retlw	103	;g
	retlw	101	;e
	retlw	32	; 
	retlw	53	;5


StringTable12
	retlw	6
	retlw	80	;P
	retlw	97	;a
	retlw	103	;g
	retlw	101	;e
	retlw	32	; 
	retlw	54	;6


StringTable13
	retlw	6
	retlw	80	;P
	retlw	97	;a
	retlw	103	;g
	retlw	101	;e
	retlw	32	; 
	retlw	55	;7


StringTable14
	retlw	6
	retlw	80	;P
	retlw	97	;a
	retlw	103	;g
	retlw	101	;e
	retlw	32	; 
	retlw	56	;8


StringTable15
	retlw	6
	retlw	80	;P
	retlw	97	;a
	retlw	103	;g
	retlw	101	;e
	retlw	32	; 
	retlw	57	;9


StringTable16
	retlw	7
	retlw	80	;P
	retlw	97	;a
	retlw	103	;g
	retlw	101	;e
	retlw	32	; 
	retlw	49	;1
	retlw	48	;0


StringTable17
	retlw	25
	retlw	80	;P
	retlw	97	;a
	retlw	103	;g
	retlw	101	;e
	retlw	32	; 
	retlw	48	;0
	retlw	32	; 
	retlw	115	;s
	retlw	119	;w
	retlw	97	;a
	retlw	112	;p
	retlw	112	;p
	retlw	101	;e
	retlw	100	;d
	retlw	32	; 
	retlw	105	;i
	retlw	110	;n
	retlw	116	;t
	retlw	111	;o
	retlw	32	; 
	retlw	102	;f
	retlw	111	;o
	retlw	99	;c
	retlw	117	;u
	retlw	115	;s


StringTable18
	retlw	25
	retlw	80	;P
	retlw	97	;a
	retlw	103	;g
	retlw	101	;e
	retlw	32	; 
	retlw	49	;1
	retlw	32	; 
	retlw	115	;s
	retlw	119	;w
	retlw	97	;a
	retlw	112	;p
	retlw	112	;p
	retlw	101	;e
	retlw	100	;d
	retlw	32	; 
	retlw	105	;i
	retlw	110	;n
	retlw	116	;t
	retlw	111	;o
	retlw	32	; 
	retlw	102	;f
	retlw	111	;o
	retlw	99	;c
	retlw	117	;u
	retlw	115	;s


StringTable19
	retlw	25
	retlw	80	;P
	retlw	97	;a
	retlw	103	;g
	retlw	101	;e
	retlw	32	; 
	retlw	50	;2
	retlw	32	; 
	retlw	115	;s
	retlw	119	;w
	retlw	97	;a
	retlw	112	;p
	retlw	112	;p
	retlw	101	;e
	retlw	100	;d
	retlw	32	; 
	retlw	105	;i
	retlw	110	;n
	retlw	116	;t
	retlw	111	;o
	retlw	32	; 
	retlw	102	;f
	retlw	111	;o
	retlw	99	;c
	retlw	117	;u
	retlw	115	;s


StringTable20
	retlw	25
	retlw	80	;P
	retlw	97	;a
	retlw	103	;g
	retlw	101	;e
	retlw	32	; 
	retlw	51	;3
	retlw	32	; 
	retlw	115	;s
	retlw	119	;w
	retlw	97	;a
	retlw	112	;p
	retlw	112	;p
	retlw	101	;e
	retlw	100	;d
	retlw	32	; 
	retlw	105	;i
	retlw	110	;n
	retlw	116	;t
	retlw	111	;o
	retlw	32	; 
	retlw	102	;f
	retlw	111	;o
	retlw	99	;c
	retlw	117	;u
	retlw	115	;s


StringTable21
	retlw	25
	retlw	80	;P
	retlw	97	;a
	retlw	103	;g
	retlw	101	;e
	retlw	32	; 
	retlw	52	;4
	retlw	32	; 
	retlw	115	;s
	retlw	119	;w
	retlw	97	;a
	retlw	112	;p
	retlw	112	;p
	retlw	101	;e
	retlw	100	;d
	retlw	32	; 
	retlw	105	;i
	retlw	110	;n
	retlw	116	;t
	retlw	111	;o
	retlw	32	; 
	retlw	102	;f
	retlw	111	;o
	retlw	99	;c
	retlw	117	;u
	retlw	115	;s


StringTable22
	retlw	25
	retlw	80	;P
	retlw	97	;a
	retlw	103	;g
	retlw	101	;e
	retlw	32	; 
	retlw	53	;5
	retlw	32	; 
	retlw	115	;s
	retlw	119	;w
	retlw	97	;a
	retlw	112	;p
	retlw	112	;p
	retlw	101	;e
	retlw	100	;d
	retlw	32	; 
	retlw	105	;i
	retlw	110	;n
	retlw	116	;t
	retlw	111	;o
	retlw	32	; 
	retlw	102	;f
	retlw	111	;o
	retlw	99	;c
	retlw	117	;u
	retlw	115	;s


StringTable23
	retlw	25
	retlw	80	;P
	retlw	97	;a
	retlw	103	;g
	retlw	101	;e
	retlw	32	; 
	retlw	54	;6
	retlw	32	; 
	retlw	115	;s
	retlw	119	;w
	retlw	97	;a
	retlw	112	;p
	retlw	112	;p
	retlw	101	;e
	retlw	100	;d
	retlw	32	; 
	retlw	105	;i
	retlw	110	;n
	retlw	116	;t
	retlw	111	;o
	retlw	32	; 
	retlw	102	;f
	retlw	111	;o
	retlw	99	;c
	retlw	117	;u
	retlw	115	;s


StringTable24
	retlw	25
	retlw	80	;P
	retlw	97	;a
	retlw	103	;g
	retlw	101	;e
	retlw	32	; 
	retlw	55	;7
	retlw	32	; 
	retlw	115	;s
	retlw	119	;w
	retlw	97	;a
	retlw	112	;p
	retlw	112	;p
	retlw	101	;e
	retlw	100	;d
	retlw	32	; 
	retlw	105	;i
	retlw	110	;n
	retlw	116	;t
	retlw	111	;o
	retlw	32	; 
	retlw	102	;f
	retlw	111	;o
	retlw	99	;c
	retlw	117	;u
	retlw	115	;s


StringTable25
	retlw	25
	retlw	80	;P
	retlw	97	;a
	retlw	103	;g
	retlw	101	;e
	retlw	32	; 
	retlw	56	;8
	retlw	32	; 
	retlw	115	;s
	retlw	119	;w
	retlw	97	;a
	retlw	112	;p
	retlw	112	;p
	retlw	101	;e
	retlw	100	;d
	retlw	32	; 
	retlw	105	;i
	retlw	110	;n
	retlw	116	;t
	retlw	111	;o
	retlw	32	; 
	retlw	102	;f
	retlw	111	;o
	retlw	99	;c
	retlw	117	;u
	retlw	115	;s


StringTable26
	retlw	25
	retlw	80	;P
	retlw	97	;a
	retlw	103	;g
	retlw	101	;e
	retlw	32	; 
	retlw	57	;9
	retlw	32	; 
	retlw	115	;s
	retlw	119	;w
	retlw	97	;a
	retlw	112	;p
	retlw	112	;p
	retlw	101	;e
	retlw	100	;d
	retlw	32	; 
	retlw	105	;i
	retlw	110	;n
	retlw	116	;t
	retlw	111	;o
	retlw	32	; 
	retlw	102	;f
	retlw	111	;o
	retlw	99	;c
	retlw	117	;u
	retlw	115	;s


StringTable27
	retlw	26
	retlw	80	;P
	retlw	97	;a
	retlw	103	;g
	retlw	101	;e
	retlw	32	; 
	retlw	49	;1
	retlw	48	;0
	retlw	32	; 
	retlw	115	;s
	retlw	119	;w
	retlw	97	;a
	retlw	112	;p
	retlw	112	;p
	retlw	101	;e
	retlw	100	;d
	retlw	32	; 
	retlw	105	;i
	retlw	110	;n
	retlw	116	;t
	retlw	111	;o
	retlw	32	; 
	retlw	102	;f
	retlw	111	;o
	retlw	99	;c
	retlw	117	;u
	retlw	115	;s


StringTable28
	retlw	25
	retlw	80	;P
	retlw	97	;a
	retlw	103	;g
	retlw	101	;e
	retlw	32	; 
	retlw	48	;0
	retlw	32	; 
	retlw	115	;s
	retlw	119	;w
	retlw	97	;a
	retlw	112	;p
	retlw	112	;p
	retlw	101	;e
	retlw	100	;d
	retlw	32	; 
	retlw	111	;o
	retlw	110	;n
	retlw	32	; 
	retlw	116	;t
	retlw	105	;i
	retlw	109	;m
	retlw	101	;e
	retlw	111	;o
	retlw	117	;u
	retlw	116	;t


StringTable29
	retlw	10
	retlw	65	;A
	retlw	68	;D
	retlw	67	;C
	retlw	47	;/
	retlw	87	;W
	retlw	97	;a
	retlw	105	;i
	retlw	116	;t
	retlw	58	;:
	retlw	32	; 


StringTable30
	retlw	2
	retlw	32	; 
	retlw	32	; 


StringTable31
	retlw	25
	retlw	80	;P
	retlw	97	;a
	retlw	103	;g
	retlw	101	;e
	retlw	32	; 
	retlw	49	;1
	retlw	32	; 
	retlw	115	;s
	retlw	119	;w
	retlw	97	;a
	retlw	112	;p
	retlw	112	;p
	retlw	101	;e
	retlw	100	;d
	retlw	32	; 
	retlw	111	;o
	retlw	110	;n
	retlw	32	; 
	retlw	116	;t
	retlw	105	;i
	retlw	109	;m
	retlw	101	;e
	retlw	111	;o
	retlw	117	;u
	retlw	116	;t


StringTable32
	retlw	25
	retlw	80	;P
	retlw	97	;a
	retlw	103	;g
	retlw	101	;e
	retlw	32	; 
	retlw	50	;2
	retlw	32	; 
	retlw	115	;s
	retlw	119	;w
	retlw	97	;a
	retlw	112	;p
	retlw	112	;p
	retlw	101	;e
	retlw	100	;d
	retlw	32	; 
	retlw	111	;o
	retlw	110	;n
	retlw	32	; 
	retlw	116	;t
	retlw	105	;i
	retlw	109	;m
	retlw	101	;e
	retlw	111	;o
	retlw	117	;u
	retlw	116	;t


StringTable33
	retlw	25
	retlw	80	;P
	retlw	97	;a
	retlw	103	;g
	retlw	101	;e
	retlw	32	; 
	retlw	51	;3
	retlw	32	; 
	retlw	115	;s
	retlw	119	;w
	retlw	97	;a
	retlw	112	;p
	retlw	112	;p
	retlw	101	;e
	retlw	100	;d
	retlw	32	; 
	retlw	111	;o
	retlw	110	;n
	retlw	32	; 
	retlw	116	;t
	retlw	105	;i
	retlw	109	;m
	retlw	101	;e
	retlw	111	;o
	retlw	117	;u
	retlw	116	;t


StringTable34
	retlw	25
	retlw	80	;P
	retlw	97	;a
	retlw	103	;g
	retlw	101	;e
	retlw	32	; 
	retlw	52	;4
	retlw	32	; 
	retlw	115	;s
	retlw	119	;w
	retlw	97	;a
	retlw	112	;p
	retlw	112	;p
	retlw	101	;e
	retlw	100	;d
	retlw	32	; 
	retlw	111	;o
	retlw	110	;n
	retlw	32	; 
	retlw	116	;t
	retlw	105	;i
	retlw	109	;m
	retlw	101	;e
	retlw	111	;o
	retlw	117	;u
	retlw	116	;t


StringTable35
	retlw	25
	retlw	80	;P
	retlw	97	;a
	retlw	103	;g
	retlw	101	;e
	retlw	32	; 
	retlw	53	;5
	retlw	32	; 
	retlw	115	;s
	retlw	119	;w
	retlw	97	;a
	retlw	112	;p
	retlw	112	;p
	retlw	101	;e
	retlw	100	;d
	retlw	32	; 
	retlw	111	;o
	retlw	110	;n
	retlw	32	; 
	retlw	116	;t
	retlw	105	;i
	retlw	109	;m
	retlw	101	;e
	retlw	111	;o
	retlw	117	;u
	retlw	116	;t


StringTable36
	retlw	25
	retlw	80	;P
	retlw	97	;a
	retlw	103	;g
	retlw	101	;e
	retlw	32	; 
	retlw	54	;6
	retlw	32	; 
	retlw	115	;s
	retlw	119	;w
	retlw	97	;a
	retlw	112	;p
	retlw	112	;p
	retlw	101	;e
	retlw	100	;d
	retlw	32	; 
	retlw	111	;o
	retlw	110	;n
	retlw	32	; 
	retlw	116	;t
	retlw	105	;i
	retlw	109	;m
	retlw	101	;e
	retlw	111	;o
	retlw	117	;u
	retlw	116	;t


StringTable37
	retlw	25
	retlw	80	;P
	retlw	97	;a
	retlw	103	;g
	retlw	101	;e
	retlw	32	; 
	retlw	55	;7
	retlw	32	; 
	retlw	115	;s
	retlw	119	;w
	retlw	97	;a
	retlw	112	;p
	retlw	112	;p
	retlw	101	;e
	retlw	100	;d
	retlw	32	; 
	retlw	111	;o
	retlw	110	;n
	retlw	32	; 
	retlw	116	;t
	retlw	105	;i
	retlw	109	;m
	retlw	101	;e
	retlw	111	;o
	retlw	117	;u
	retlw	116	;t


StringTable38
	retlw	25
	retlw	80	;P
	retlw	97	;a
	retlw	103	;g
	retlw	101	;e
	retlw	32	; 
	retlw	56	;8
	retlw	32	; 
	retlw	115	;s
	retlw	119	;w
	retlw	97	;a
	retlw	112	;p
	retlw	112	;p
	retlw	101	;e
	retlw	100	;d
	retlw	32	; 
	retlw	111	;o
	retlw	110	;n
	retlw	32	; 
	retlw	116	;t
	retlw	105	;i
	retlw	109	;m
	retlw	101	;e
	retlw	111	;o
	retlw	117	;u
	retlw	116	;t


StringTable39
	retlw	25
	retlw	80	;P
	retlw	97	;a
	retlw	103	;g
	retlw	101	;e
	retlw	32	; 
	retlw	57	;9
	retlw	32	; 
	retlw	115	;s
	retlw	119	;w
	retlw	97	;a
	retlw	112	;p
	retlw	112	;p
	retlw	101	;e
	retlw	100	;d
	retlw	32	; 
	retlw	111	;o
	retlw	110	;n
	retlw	32	; 
	retlw	116	;t
	retlw	105	;i
	retlw	109	;m
	retlw	101	;e
	retlw	111	;o
	retlw	117	;u
	retlw	116	;t


StringTable40
	retlw	26
	retlw	80	;P
	retlw	97	;a
	retlw	103	;g
	retlw	101	;e
	retlw	32	; 
	retlw	49	;1
	retlw	48	;0
	retlw	32	; 
	retlw	115	;s
	retlw	119	;w
	retlw	97	;a
	retlw	112	;p
	retlw	112	;p
	retlw	101	;e
	retlw	100	;d
	retlw	32	; 
	retlw	111	;o
	retlw	110	;n
	retlw	32	; 
	retlw	116	;t
	retlw	105	;i
	retlw	109	;m
	retlw	101	;e
	retlw	111	;o
	retlw	117	;u
	retlw	116	;t


StringTable41
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


StringTable42
	retlw	1
	retlw	42	;*


StringTable76
	retlw	1
	retlw	32	; 


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
