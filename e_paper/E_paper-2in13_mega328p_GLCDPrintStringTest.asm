;Program compiled by Great Cow BASIC (0.98.<<>> 2019-11-14 (Windows 32 bit))
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Chip Model: MEGA328P
;Assembler header file
.INCLUDE "m328pdef.inc"

;SREG bit names (for AVR Assembler compatibility, GCBASIC uses different names)
#define C 0
#define H 5
#define I 7
#define N 2
#define S 4
#define T 6
#define V 3
#define Z 1

;********************************************************************************

;Set aside memory locations for variables
.EQU	CHARCODE=1704
.EQU	CHARCOL=1705
.EQU	CHARCOL_H=1706
.EQU	CHARLOCX=1707
.EQU	CHARLOCX_H=1708
.EQU	CHARLOCY=1709
.EQU	CHARLOCY_H=1710
.EQU	COLSPERFONT=1711
.EQU	COMPORT=1712
.EQU	CURRCHARCOL=1713
.EQU	CURRCHARROW=1714
.EQU	CURRCHARVAL=1715
.EQU	DATAVAR=1716
.EQU	EPD2IN13DADDRESSTYPE=1717
.EQU	EPD2IN13D_COMMAND=1718
.EQU	EPD2IN13D_DATA=1719
.EQU	EPD_BUFFER=256
.EQU	EPD_COUNTER=1720
.EQU	EPD_IND=1721
.EQU	EPD_IND_COL=1723
.EQU	EPD_IND_COL_H=1724
.EQU	EPD_IND_H=1722
.EQU	EPD_IND_RAW=1725
.EQU	EPD_IND_RAW_H=1726
.EQU	EPD_IND_TRANS=1727
.EQU	EPD_IND_TRANS_H=1728
.EQU	EPD_N_COL=1729
.EQU	EPD_N_COL_H=1730
.EQU	EPD_N_RAW=1731
.EQU	EPD_N_RAW_H=1732
.EQU	GLCDBACKGROUND=1733
.EQU	GLCDBACKGROUND_H=1734
.EQU	GLCDCOLOUR=1735
.EQU	GLCDCOLOUR_H=1736
.EQU	GLCDDATATEMP=1737
.EQU	GLCDDATATEMP_H=1738
.EQU	GLCDDEVICEHEIGHT=1739
.EQU	GLCDDEVICEHEIGHT_H=1740
.EQU	GLCDDEVICEWIDTH=1741
.EQU	GLCDDEVICEWIDTH_H=1742
.EQU	GLCDFNTDEFAULT=1743
.EQU	GLCDFNTDEFAULTHEIGHT=1744
.EQU	GLCDFNTDEFAULTSIZE=1745
.EQU	GLCDFONTWIDTH=1746
.EQU	GLCDFOREGROUND=1747
.EQU	GLCDFOREGROUND_H=1748
.EQU	GLCDPRINTLEN=1749
.EQU	GLCDPRINTLOC=1750
.EQU	GLCDPRINTLOC_H=1751
.EQU	GLCDPRINT_STRING_COUNTER=1752
.EQU	GLCDTEMP=1753
.EQU	GLCDTEMP_H=1754
.EQU	GLCDX=1755
.EQU	GLCDX_H=1756
.EQU	GLCDY=1757
.EQU	GLCDY_H=1758
.EQU	GLCD_TIME_BUFF=1759
.EQU	GLCD_TIME_BUFF_H=1760
.EQU	GLCD_YORDINATE=1761
.EQU	GLCD_YORDINATE_H=1762
.EQU	HSERPRINTCRLFCOUNT=1763
.EQU	LINECOLOUR=1764
.EQU	LINECOLOUR_H=1765
.EQU	LINEDIFFX=1766
.EQU	LINEDIFFX_H=1767
.EQU	LINEDIFFX_X2=1768
.EQU	LINEDIFFX_X2_H=1769
.EQU	LINEDIFFY=1770
.EQU	LINEDIFFY_H=1771
.EQU	LINEDIFFY_X2=1772
.EQU	LINEDIFFY_X2_H=1773
.EQU	LINEERR=1774
.EQU	LINEERR_H=1775
.EQU	LINESTEPX=1776
.EQU	LINESTEPX_H=1777
.EQU	LINESTEPY=1778
.EQU	LINESTEPY_H=1779
.EQU	LINEX1=1780
.EQU	LINEX1_H=1781
.EQU	LINEX2=1782
.EQU	LINEX2_H=1783
.EQU	LINEY1=1784
.EQU	LINEY1_H=1785
.EQU	LINEY2=1786
.EQU	LINEY2_H=1787
.EQU	LOCALCHARCODE=1788
.EQU	LOCALCHARCODE_H=1789
.EQU	LOWERPAGE=1790
.EQU	OLDGLCDFONTWIDTH=1791
.EQU	OUTVALUETEMP=1792
.EQU	PRINTLEN=1793
.EQU	PRINTLOCX=1794
.EQU	PRINTLOCX_H=1795
.EQU	PRINTLOCY=1796
.EQU	PRINTLOCY_H=1797
.EQU	REMAINDER=1798
.EQU	ROWSPERFONT=1799
.EQU	SERDATA=1800
.EQU	SERPRINTVAL=1801
.EQU	SERPRINTVAL_H=1802
.EQU	SPICLOCKMODE=1803
.EQU	SPICURRENTMODE=1804
.EQU	SPITXDATA=1805
.EQU	STRINGPOINTER=1806
.EQU	SYSLCDPRINTDATAHANDLER=1807
.EQU	SYSLCDPRINTDATAHANDLER_H=1808
.EQU	SYSPRINTDATAHANDLER=1809
.EQU	SYSPRINTDATAHANDLER_H=1810
.EQU	SYSPRINTTEMP=1811
.EQU	SYSREPEATTEMP1=1812
.EQU	SYSSTRINGPARAM1=1635
.EQU	SYSSTRINGPARAM2=1658
.EQU	SYSSTRINGPARAM3=1681
.EQU	UPPERPAGE=1813
.EQU	_GLCDPAGE=1814
.EQU	_GLCDPAGESH=1815
.EQU	_GLCDPAGESL=1816

;********************************************************************************

;Register variables
.DEF	DELAYTEMP=r25
.DEF	DELAYTEMP2=r26
.DEF	SYSBITTEST=r5
.DEF	SYSBYTETEMPA=r22
.DEF	SYSBYTETEMPB=r28
.DEF	SYSBYTETEMPX=r0
.DEF	SYSCALCTEMPA=r22
.DEF	SYSCALCTEMPB=r28
.DEF	SYSCALCTEMPX=r0
.DEF	SYSCALCTEMPX_H=r1
.DEF	SYSDIVLOOP=r5
.DEF	SYSDIVMULTA=r24
.DEF	SYSDIVMULTA_H=r25
.DEF	SYSDIVMULTB=r30
.DEF	SYSDIVMULTB_H=r31
.DEF	SYSDIVMULTX=r2
.DEF	SYSDIVMULTX_H=r3
.DEF	SYSINTEGERTEMPA=r22
.DEF	SYSINTEGERTEMPA_H=r23
.DEF	SYSINTEGERTEMPB=r28
.DEF	SYSINTEGERTEMPB_H=r29
.DEF	SYSINTEGERTEMPX=r0
.DEF	SYSINTEGERTEMPX_H=r1
.DEF	SYSREADA=r30
.DEF	SYSREADA_H=r31
.DEF	SYSSIGNBYTE=r4
.DEF	SYSSTRINGA=r26
.DEF	SYSSTRINGA_H=r27
.DEF	SYSSTRINGB=r28
.DEF	SYSSTRINGB_H=r29
.DEF	SYSSTRINGLENGTH=r25
.DEF	SYSVALUECOPY=r21
.DEF	SYSWAITTEMPMS=r29
.DEF	SYSWAITTEMPMS_H=r30
.DEF	SYSWAITTEMPS=r31
.DEF	SYSWORDTEMPA=r22
.DEF	SYSWORDTEMPA_H=r23
.DEF	SYSWORDTEMPB=r28
.DEF	SYSWORDTEMPB_H=r29
.DEF	SYSWORDTEMPX=r0
.DEF	SYSWORDTEMPX_H=r1
.DEF	SYSTEMP1=r6
.DEF	SYSTEMP1_H=r7
.DEF	SYSTEMP2=r8
.DEF	SYSTEMP2_H=r9
.DEF	SYSTEMP3=r10
.DEF	SYSTEMP4=r16

;********************************************************************************

;Vectors
;Interrupt vectors
.ORG	0
	rjmp	BASPROGRAMSTART ;Reset
.ORG	2
	reti	;INT0
.ORG	4
	reti	;INT1
.ORG	6
	reti	;PCINT0
.ORG	8
	reti	;PCINT1
.ORG	10
	reti	;PCINT2
.ORG	12
	reti	;WDT
.ORG	14
	reti	;TIMER2_COMPA
.ORG	16
	reti	;TIMER2_COMPB
.ORG	18
	reti	;TIMER2_OVF
.ORG	20
	reti	;TIMER1_CAPT
.ORG	22
	reti	;TIMER1_COMPA
.ORG	24
	reti	;TIMER1_COMPB
.ORG	26
	reti	;TIMER1_OVF
.ORG	28
	reti	;TIMER0_COMPA
.ORG	30
	reti	;TIMER0_COMPB
.ORG	32
	reti	;TIMER0_OVF
.ORG	34
	reti	;SPI_STC
.ORG	36
	reti	;USART_RX
.ORG	38
	reti	;USART_UDRE
.ORG	40
	reti	;USART_TX
.ORG	42
	reti	;ADC
.ORG	44
	reti	;EE_READY
.ORG	46
	reti	;ANALOG_COMP
.ORG	48
	reti	;TWI
.ORG	50
	reti	;SPM_READY

;********************************************************************************

;Start of program memory page 0
.ORG	52
BASPROGRAMSTART:
;Initialise stack
	ldi	SysValueCopy,high(RAMEND)
	out	SPH, SysValueCopy
	ldi	SysValueCopy,low(RAMEND)
	out	SPL, SysValueCopy
;Call initialisation routines
	rcall	INITSYS
	rcall	INITUSART
	rcall	INIT_EPD2IN13D

;Start of the main program
;''A demonstration program for Explicit-Paper.
;''-------------------------------------------------------------------------
;-------------------------------------------------------
;''This has been tested using the hardware and software SPI option.
;''*************************************************************************
;*******
;Chip Settings.
;USART settings
;#define USART_BAUD_RATE 9600
;#define USART_TX_BLOCKING
;______________
;USART
;#define USART_BAUD_RATE 57600'9600
;#define USART_DELAY     5 ms
;#define USART_BLOCKING
;Set pin USART directions
;******************************************************************************************************
;The following should be used   '#define EPD_HardwareSPI     'remove comment out if you want to use software SPI.
;#define EPD_HardwareSPI
;#define HWSPIMode MasterUltraFast
;***************************************************************************
;***************************
;Setup the E-Paper
;#define GLCD_TYPE GLCD_TYPE_EPD_EPD2in13D
;#define GLCD_EXTENDEDFONTSET1
;#define GLCD_TYPE_EPD2in13D_LOWMEMORY4_GLCD_MODE
;#define GLCD_OLED_FONT
;#define GLCD_PROTECTOVERRUN
;Pin mappings for SPI - this GLCD driver supports Hardware SPI and Software SPI
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
	ldi	SysValueCopy,0
	sts	UPPERPAGE,SysValueCopy
;lowerPage = EPD_N_PAGE-1
	ldi	SysValueCopy,1
	sts	LOWERPAGE,SysValueCopy
;GLCDForeground = TFT_BLACK
	ldi	SysValueCopy,0
	sts	GLCDFOREGROUND,SysValueCopy
	sts	GLCDFOREGROUND_H,SysValueCopy
;GLCDBackground = TFT_WHITE
	ldi	SysValueCopy,255
	sts	GLCDBACKGROUND,SysValueCopy
	sts	GLCDBACKGROUND_H,SysValueCopy
;Tests
;GLCDRotate Portrait
;GLCD_Open_PageTransaction
;GLCDPrint 0,0, "Test @ Portrait"
;
;GLCDPrintStringLn ( "1.First Line - P" )
;GLCDPrintStringLn ( "2.Second Ln" )
;
;GLCDPrintStringLn ( "" )
;GLCDPrintStringLn ( "4.Forth Ln" )
;GLCDLocateString( 0, 5 )
;'        GLCDPrintStringLn ( "5." )
;'        GLCDPrintStringLn ( "Fifth Ln" )
;'
;'        GLCDPrintStringLn ( "6.Sixth Ln" )
;'        GLCDLocateString( 0, 3 )
;'        dim val3 as Byte
;'        val3 = 3
;'        GLCDPrintStringLn ( str( val3 ) + ".Third Ln" )
;
;GLCD_Close_PageTransaction
;wait 2 s
;GLCDRotate Portrait
	ldi	SysValueCopy,4
	sts	EPD2IN13DADDRESSTYPE,SysValueCopy
	call	ROTATE_EPD2IN13D
;GLCD_Open_PageTransaction
;Macro Source: epd_epd2in13d.h (912)
;dim _GLCDPage as byte
;dim _GLCDPagesL, _GLCDPagesH as byte
;Clear_buffer_EPD2in13D
	rcall	CLEAR_BUFFER_EPD2IN13D
;for _GLCDPage = _GLCDPagesL to _GLCDPagesH    '_GLCDPage is a global variable - DO NOT CHANGE!!!
	lds	SysTemp1,_GLCDPAGESL
	dec	SysTemp1
	sts	_GLCDPAGE,SysTemp1
	lds	SysCalcTempA,_GLCDPAGESH
	lds	SysCalcTempB,_GLCDPAGESL
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF1
	rjmp	SysForLoopEnd1
ENDIF1:
SysForLoop1:
	lds	SysTemp1,_GLCDPAGE
	inc	SysTemp1
	sts	_GLCDPAGE,SysTemp1
;GLCDPrint 0,0, "Test @ Portrait_rev"
;GLCDPrintStringLn ( "P" )
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable1<<1)
	ldi	SysReadA_H,high(StringTable1<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	rcall	GLCDPRINTSTRINGLN
;pset 0,0,0
	ldi	SysValueCopy,0
	sts	GLCDX,SysValueCopy
	sts	GLCDX_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDY,SysValueCopy
	sts	GLCDY_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDCOLOUR,SysValueCopy
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_EPD2IN13D
;line 103,211,103-10,211-10
	ldi	SysValueCopy,103
	sts	LINEX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,211
	sts	LINEY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1_H,SysValueCopy
	ldi	SysValueCopy,93
	sts	LINEX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEX2_H,SysValueCopy
	ldi	SysValueCopy,201
	sts	LINEY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY2_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	rcall	LINE
;line 0,0,103,211
;GLCDPrintStringLn ( "0" )
;GLCDPrintStringLn ( "1.First Line - PR" )
;GLCDPrintStringLn ( "2.Second Ln" )
;
;GLCDPrintStringLn ( "" )
;GLCDPrintStringLn ( "4.Forth Ln" )
;GLCDLocateString( 0, 5 )
;GLCDPrintStringLn ( "5." )
;GLCDPrintStringLn ( "Fifth Ln" )
;
;GLCDPrintStringLn ( "6.Sixth Ln" )
;GLCDLocateString( 0, 3 )
;dim val3 as Byte
;val3 = 3
;GLCDPrintStringLn ( str( val3 ) + ".Third Ln" )
;GLCD_Close_PageTransaction
;Macro Source: epd_epd2in13d.h (924)
;Pixel_To_Display_EPD2in13D
	call	PIXEL_TO_DISPLAY_EPD2IN13D
;next
	lds	SysCalcTempA,_GLCDPAGE
	lds	SysCalcTempB,_GLCDPAGESH
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF2
	rjmp	SysForLoop1
ENDIF2:
SysForLoopEnd1:
;SendCommand_EPD2in13D(DISPLAY_REFRESH)
	ldi	SysValueCopy,18
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;HSerPrintCRLF 2
	ldi	SysValueCopy,2
	sts	HSERPRINTCRLFCOUNT,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINTCRLF
;GLCDRotate Portrait_rev
	ldi	SysValueCopy,2
	sts	EPD2IN13DADDRESSTYPE,SysValueCopy
	call	ROTATE_EPD2IN13D
;GLCD_Open_PageTransaction
;Macro Source: epd_epd2in13d.h (912)
;dim _GLCDPage as byte
;dim _GLCDPagesL, _GLCDPagesH as byte
;Clear_buffer_EPD2in13D
	rcall	CLEAR_BUFFER_EPD2IN13D
;for _GLCDPage = _GLCDPagesL to _GLCDPagesH    '_GLCDPage is a global variable - DO NOT CHANGE!!!
	lds	SysTemp1,_GLCDPAGESL
	dec	SysTemp1
	sts	_GLCDPAGE,SysTemp1
	lds	SysCalcTempA,_GLCDPAGESH
	lds	SysCalcTempB,_GLCDPAGESL
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF3
	rjmp	SysForLoopEnd2
ENDIF3:
SysForLoop2:
	lds	SysTemp1,_GLCDPAGE
	inc	SysTemp1
	sts	_GLCDPAGE,SysTemp1
;GLCDPrint 0,0, "Test @ Portrait_rev"
;GLCDPrint 0,0, "S"
;GLCDPrintStringLn ( "R" )
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable2<<1)
	ldi	SysReadA_H,high(StringTable2<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	rcall	GLCDPRINTSTRINGLN
;pset 0,0,0
	ldi	SysValueCopy,0
	sts	GLCDX,SysValueCopy
	sts	GLCDX_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDY,SysValueCopy
	sts	GLCDY_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDCOLOUR,SysValueCopy
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_EPD2IN13D
;line 103,211,103-10,211-10
	ldi	SysValueCopy,103
	sts	LINEX1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEX1_H,SysValueCopy
	ldi	SysValueCopy,211
	sts	LINEY1,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY1_H,SysValueCopy
	ldi	SysValueCopy,93
	sts	LINEX2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEX2_H,SysValueCopy
	ldi	SysValueCopy,201
	sts	LINEY2,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINEY2_H,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	rcall	LINE
;GLCDPrintStringLn ( "0" )
;GLCDPrintStringLn ( "1.First Line - PR" )
;GLCDPrintStringLn ( "2.Second Ln" )
;
;GLCDPrintStringLn ( "" )
;GLCDPrintStringLn ( "4.Forth Ln" )
;GLCDLocateString( 0, 5 )
;GLCDPrintStringLn ( "5." )
;GLCDPrintStringLn ( "Fifth Ln" )
;
;GLCDPrintStringLn ( "6.Sixth Ln" )
;GLCDLocateString( 0, 3 )
;dim val3 as Byte
;val3 = 3
;GLCDPrintStringLn ( str( val3 ) + ".Third Ln" )
;GLCD_Close_PageTransaction
;Macro Source: epd_epd2in13d.h (924)
;Pixel_To_Display_EPD2in13D
	call	PIXEL_TO_DISPLAY_EPD2IN13D
;next
	lds	SysCalcTempA,_GLCDPAGE
	lds	SysCalcTempB,_GLCDPAGESH
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF4
	rjmp	SysForLoop2
ENDIF4:
SysForLoopEnd2:
;SendCommand_EPD2in13D(DISPLAY_REFRESH)
	ldi	SysValueCopy,18
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;wait 5 s
	ldi	SysWaitTempS,5
	rcall	Delay_S
;GLCDRotate Landscape
;GLCD_Open_PageTransaction
;GLCDPrint 0,0, "Test @ Landscape"
;
;GLCDPrintStringLn ( "1.First Line - L" )
;GLCDPrintStringLn ( "2.Second Ln" )
;
;GLCDPrintStringLn ( "" )
;GLCDPrintStringLn ( "4.Forth Ln" )
;'        GLCDLocateString( 0, 5 )
;'        GLCDPrintStringLn ( "5." )
;'        GLCDPrintStringLn ( "Fifth Ln" )
;'
;'        GLCDPrintStringLn ( "6.Sixth Ln" )
;'        GLCDLocateString( 0, 3 )
;'        dim val3 as Byte
;'        val3 = 3
;'        GLCDPrintStringLn ( str( val3 ) + ".Third Ln" )
;
;GLCD_Close_PageTransaction
;wait 2 s
;
;
;GLCDRotate Landscape_Rev
;GLCD_Open_PageTransaction
;GLCDPrint 0,0, "Test @ Landscape_Rev"
;
;GLCDPrintStringLn ( "1.First Line - LR" )
;GLCDPrintStringLn ( "2.Second Ln" )
;
;GLCDPrintStringLn ( "" )
;GLCDPrintStringLn ( "4.Forth Ln" )
;'        GLCDLocateString( 0, 5 )
;'        GLCDPrintStringLn ( "5." )
;'        GLCDPrintStringLn ( "Fifth Ln" )
;'
;'        GLCDPrintStringLn ( "6.Sixth Ln" )
;'        GLCDLocateString( 0, 3 )
;'        dim val3 as Byte
;'        val3 = 3
;'        GLCDPrintStringLn ( str( val3 ) + ".Third Ln" )
;
;GLCD_Close_PageTransaction
;wait 2 s
;GLCDCLS
	rcall	CLS_EPD2IN13D
;GLCDSleep
	call	SLEEP_EPD2IN13D
;do
SysDoLoop_S1:
;loop
	rjmp	SysDoLoop_S1
SysDoLoop_E1:
BASPROGRAMEND:
	sleep
	rjmp	BASPROGRAMEND

;********************************************************************************

;Source: epd_epd2in13d.h (406)
CLEAR_BUFFER_EPD2IN13D:
;Dim EPD_Ind_raw as Word
;for EPD_Ind_raw=1 to BUFFWIDTH                 'clear the buffer
	ldi	SysValueCopy,0
	sts	EPD_IND_RAW,SysValueCopy
	sts	EPD_IND_RAW_H,SysValueCopy
SysForLoop6:
	lds	SysTemp3,EPD_IND_RAW
	inc	SysTemp3
	sts	EPD_IND_RAW,SysTemp3
	lds	SysTemp3,EPD_IND_RAW_H
	brne	PC + 2
	inc	SysTemp3
	sts	EPD_IND_RAW_H,SysTemp3
;EPD_Buffer(EPD_Ind_raw)=GLCDBackground
	lds	SysTemp3,EPD_IND_RAW
	ldi	SysTemp4,low(EPD_BUFFER)
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	lds	SysTemp3,EPD_IND_RAW_H
	ldi	SysTemp4,high(EPD_BUFFER)
	adc	SysTemp3,SysTemp4
	mov	SysStringA_H,SysTemp3
	lds	SysValueCopy,GLCDBACKGROUND
	st	X,SysValueCopy
;next
	lds	SysWORDTempA,EPD_IND_RAW
	lds	SysWORDTempA_H,EPD_IND_RAW_H
	ldi	SysWORDTempB,98
	ldi	SysWORDTempB_H,5
	call	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop6
SysForLoopEnd6:
	ret

;********************************************************************************

;Source: epd_epd2in13d.h (346)
CLS_EPD2IN13D:
;CLS_EPD2in13D_init
	rcall	CLS_EPD2IN13D_INIT
;Refresh_EPD2in13D
	jmp	REFRESH_EPD2IN13D

;********************************************************************************

;Source: epd_epd2in13d.h (298)
CLS_EPD2IN13D_INIT:
;initialise global variable. Required variable for Circle - DO NOT DELETE
;GLCD_yordinate = 0
	ldi	SysValueCopy,0
	sts	GLCD_YORDINATE,SysValueCopy
	sts	GLCD_YORDINATE_H,SysValueCopy
;Dim EPD_Ind_raw, EPD_Ind_col as word
;Dim PrintLocX, PrintLocY as word
;PrintLocX = 0
	ldi	SysValueCopy,0
	sts	PRINTLOCX,SysValueCopy
	sts	PRINTLOCX_H,SysValueCopy
;PrintLocY = 0
	ldi	SysValueCopy,0
	sts	PRINTLOCY,SysValueCopy
	sts	PRINTLOCY_H,SysValueCopy
;For EPD_Ind_raw=1 to BUFFWIDTH
	ldi	SysValueCopy,0
	sts	EPD_IND_RAW,SysValueCopy
	sts	EPD_IND_RAW_H,SysValueCopy
SysForLoop13:
	lds	SysTemp3,EPD_IND_RAW
	inc	SysTemp3
	sts	EPD_IND_RAW,SysTemp3
	lds	SysTemp3,EPD_IND_RAW_H
	brne	PC + 2
	inc	SysTemp3
	sts	EPD_IND_RAW_H,SysTemp3
;EPD_Buffer(EPD_Ind_raw)=GLCDBackground
	lds	SysTemp3,EPD_IND_RAW
	ldi	SysTemp4,low(EPD_BUFFER)
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	lds	SysTemp3,EPD_IND_RAW_H
	ldi	SysTemp4,high(EPD_BUFFER)
	adc	SysTemp3,SysTemp4
	mov	SysStringA_H,SysTemp3
	lds	SysValueCopy,GLCDBACKGROUND
	st	X,SysValueCopy
;next
	lds	SysWORDTempA,EPD_IND_RAW
	lds	SysWORDTempA_H,EPD_IND_RAW_H
	ldi	SysWORDTempB,98
	ldi	SysWORDTempB_H,5
	call	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop13
SysForLoopEnd13:
;Clear down "OLD" data
;SendCommand_EPD2in13D(Data_Transmission_1)
	ldi	SysValueCopy,16
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;wait 2 ms
	ldi	SysWaitTempMS,2
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;for EPD_Ind_raw=1 to GLCD_Height
	ldi	SysValueCopy,0
	sts	EPD_IND_RAW,SysValueCopy
	sts	EPD_IND_RAW_H,SysValueCopy
SysForLoop14:
	lds	SysTemp3,EPD_IND_RAW
	inc	SysTemp3
	sts	EPD_IND_RAW,SysTemp3
	lds	SysTemp3,EPD_IND_RAW_H
	brne	PC + 2
	inc	SysTemp3
	sts	EPD_IND_RAW_H,SysTemp3
;for EPD_Ind_col=1 to GLCD_Width
	ldi	SysValueCopy,0
	sts	EPD_IND_COL,SysValueCopy
	sts	EPD_IND_COL_H,SysValueCopy
SysForLoop15:
	lds	SysTemp3,EPD_IND_COL
	inc	SysTemp3
	sts	EPD_IND_COL,SysTemp3
	lds	SysTemp3,EPD_IND_COL_H
	brne	PC + 2
	inc	SysTemp3
	sts	EPD_IND_COL_H,SysTemp3
;Was.. speed optimised with macro              SendData_EPD2in13D(GLCDBackGround)
;EPD2in13D_Data = GLCDBackGround
	lds	SysValueCopy,GLCDBACKGROUND
	sts	EPD2IN13D_DATA,SysValueCopy
;SET EPD_CS OFF
	cbi	PORTB,2
;SET EPD_DC ON
	sbi	PORTB,1
;SendData_EPD2in13D_Macro
;Macro Source: epd_epd2in13d.h (485)
;FastHWSPITransfer EPD2in13D_Data
	lds	SysValueCopy,EPD2IN13D_DATA
	sts	SPITXDATA,SysValueCopy
	rcall	FASTHWSPITRANSFER
;SET EPD_CS ON
	sbi	PORTB,2
;next
	lds	SysWORDTempA,EPD_IND_COL
	lds	SysWORDTempA_H,EPD_IND_COL_H
	ldi	SysWORDTempB,104
	ldi	SysWORDTempB_H,0
	call	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop15
SysForLoopEnd15:
;next
	lds	SysWORDTempA,EPD_IND_RAW
	lds	SysWORDTempA_H,EPD_IND_RAW_H
	ldi	SysWORDTempB,212
	ldi	SysWORDTempB_H,0
	call	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop14
SysForLoopEnd14:
;wait 10 ms
	ldi	SysWaitTempMS,10
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;Clear down "NEW" data
;SendCommand_EPD2in13D(Data_Transmission_2)
	ldi	SysValueCopy,19
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;wait 2 ms
	ldi	SysWaitTempMS,2
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;for EPD_Ind_raw=1 to GLCD_Height
	ldi	SysValueCopy,0
	sts	EPD_IND_RAW,SysValueCopy
	sts	EPD_IND_RAW_H,SysValueCopy
SysForLoop16:
	lds	SysTemp3,EPD_IND_RAW
	inc	SysTemp3
	sts	EPD_IND_RAW,SysTemp3
	lds	SysTemp3,EPD_IND_RAW_H
	brne	PC + 2
	inc	SysTemp3
	sts	EPD_IND_RAW_H,SysTemp3
;for EPD_Ind_col=1 to GLCD_Width
	ldi	SysValueCopy,0
	sts	EPD_IND_COL,SysValueCopy
	sts	EPD_IND_COL_H,SysValueCopy
SysForLoop17:
	lds	SysTemp3,EPD_IND_COL
	inc	SysTemp3
	sts	EPD_IND_COL,SysTemp3
	lds	SysTemp3,EPD_IND_COL_H
	brne	PC + 2
	inc	SysTemp3
	sts	EPD_IND_COL_H,SysTemp3
;Was.. speed optimised with macro              SendData_EPD2in13D(GLCDBackGround)
;EPD2in13D_Data = GLCDBackGround
	lds	SysValueCopy,GLCDBACKGROUND
	sts	EPD2IN13D_DATA,SysValueCopy
;SET EPD_CS OFF
	cbi	PORTB,2
;SET EPD_DC ON
	sbi	PORTB,1
;SendData_EPD2in13D_Macro
;Macro Source: epd_epd2in13d.h (485)
;FastHWSPITransfer EPD2in13D_Data
	lds	SysValueCopy,EPD2IN13D_DATA
	sts	SPITXDATA,SysValueCopy
	rcall	FASTHWSPITRANSFER
;SET EPD_CS ON
	sbi	PORTB,2
;next
	lds	SysWORDTempA,EPD_IND_COL
	lds	SysWORDTempA_H,EPD_IND_COL_H
	ldi	SysWORDTempB,104
	ldi	SysWORDTempB_H,0
	call	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop17
SysForLoopEnd17:
;next
	lds	SysWORDTempA,EPD_IND_RAW
	lds	SysWORDTempA_H,EPD_IND_RAW_H
	ldi	SysWORDTempB,212
	ldi	SysWORDTempB_H,0
	call	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop16
SysForLoopEnd16:
;wait 10 ms
	ldi	SysWaitTempMS,10
	ldi	SysWaitTempMS_H,0
	rjmp	Delay_MS

;********************************************************************************

;Source: epd_epd2in13d.h (534)
DRAWCHAR_EPD2IN13D:
;HSerPrintCRLF
	ldi	SysValueCopy,1
	sts	HSERPRINTCRLFCOUNT,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINTCRLF
;HSerPrint "in DrawChar_EPD2in13D-"
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable56<<1)
	ldi	SysReadA_H,high(StringTable56<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT690
;HSerPrint CharLocX
	lds	SysValueCopy,CHARLOCX
	sts	SERPRINTVAL,SysValueCopy
	lds	SysValueCopy,CHARLOCX_H
	sts	SERPRINTVAL_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT692
;HSerPrint ","
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable28<<1)
	ldi	SysReadA_H,high(StringTable28<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT690
;HSerPrint CharLocY
	lds	SysValueCopy,CHARLOCY
	sts	SERPRINTVAL,SysValueCopy
	lds	SysValueCopy,CHARLOCY_H
	sts	SERPRINTVAL_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT692
;HSerPrint " : "
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable57<<1)
	ldi	SysReadA_H,high(StringTable57<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT690
;This has got a tad complex
;We have three major pieces
;1 The preamble - this just adjusted color and the input character
;2 The code that deals with GCB fontset
;3 The code that deals with OLED fontset
;
;You can make independent change to section 2 and 3 but they are mutual exclusive with many common pieces
;dim CharCol, CharRow, GLCDTemp as word
;CharCode -= 15
	lds	SysTemp3,CHARCODE
	ldi	SysTemp4,15
	sub	SysTemp3,SysTemp4
	sts	CHARCODE,SysTemp3
;CharCode needs to have 15 subtracted, table starts at char 16 not char 0
;CharCol=0
	ldi	SysValueCopy,0
	sts	CHARCOL,SysValueCopy
	sts	CHARCOL_H,SysValueCopy
;Calculate the pointer to the OLED fonts.
;These fonts are not multiple tables one is a straight list the other is a lookup table with data.
;Dim LocalCharCode as word
;Get key information and set up the fonts parameters
;Select case GLCDfntDefaultSize
;case 1 'This font is two font tables of an index and data
SysSelect4Case1:
	lds	SysCalcTempA,GLCDFNTDEFAULTSIZE
	cpi	SysCalcTempA,1
	brne	SysSelect4Case2
;CharCode = CharCode - 16
	lds	SysTemp3,CHARCODE
	ldi	SysTemp4,16
	sub	SysTemp3,SysTemp4
	sts	CHARCODE,SysTemp3
;ReadTable OLEDFont1Index, CharCode, LocalCharCode
	lds	SYSSTRINGA,CHARCODE
	rcall	OLEDFONT1INDEX
	sts	LOCALCHARCODE,SysByteTempX
	lds	SYSSTRINGA,CHARCODE
	call	OLEDFONT1INDEX_H
	sts	LOCALCHARCODE_H,SysByteTempX
;ReadTable OLEDFont1Data, LocalCharCode , COLSperfont
	lds	SYSSTRINGA,LOCALCHARCODE
	lds	SYSSTRINGA_H,LOCALCHARCODE_H
	rcall	OLEDFONT1DATA
	sts	COLSPERFONT,SysByteTempX
;GLCDFontWidth = COLSperfont + 1
	lds	SysTemp3,COLSPERFONT
	inc	SysTemp3
	sts	GLCDFONTWIDTH,SysTemp3
;ROWSperfont = 7  'which is really 8 as we start at 0
	ldi	SysValueCopy,7
	sts	ROWSPERFONT,SysValueCopy
;case 2 'This is one font table
	rjmp	SysSelectEnd4
SysSelect4Case2:
	lds	SysCalcTempA,GLCDFNTDEFAULTSIZE
	cpi	SysCalcTempA,2
	brne	SysSelectEnd4
;CharCode = CharCode - 17
	lds	SysTemp3,CHARCODE
	ldi	SysTemp4,17
	sub	SysTemp3,SysTemp4
	sts	CHARCODE,SysTemp3
;Pointer to table of font elements
;LocalCharCode = (CharCode * 20)
	lds	SysWORDTempA,CHARCODE
	ldi	SysWORDTempA_H,0
	ldi	SysWORDTempB,20
	ldi	SysWORDTempB_H,0
	call	SysMultSub16
	sts	LOCALCHARCODE,SysWORDTempX
	sts	LOCALCHARCODE_H,SysWORDTempX_H
;COLSperfont = 9  'which is really 10 as we start at 0
	ldi	SysValueCopy,9
	sts	COLSPERFONT,SysValueCopy
;ROWSperfont=15  'which is really 16 as we start at 0
	ldi	SysValueCopy,15
	sts	ROWSPERFONT,SysValueCopy
;End Select
SysSelectEnd4:
;The main loop - loop throught the number of columns
;For CurrCharCol = 0 to COLSperfont  'number of columns in the font , with two row of data
	ldi	SysValueCopy,255
	sts	CURRCHARCOL,SysValueCopy
	lds	SysCalcTempA,COLSPERFONT
	cpi	SysCalcTempA,0
	brsh	ENDIF38
	rjmp	SysForLoopEnd18
ENDIF38:
SysForLoop18:
	lds	SysTemp3,CURRCHARCOL
	inc	SysTemp3
	sts	CURRCHARCOL,SysTemp3
;Index the pointer to the code that we are looking for as we need to do this lookup many times getting more font data
;LocalCharCode++
	lds	SysTemp3,LOCALCHARCODE
	inc	SysTemp3
	sts	LOCALCHARCODE,SysTemp3
	lds	SysTemp3,LOCALCHARCODE_H
	brne	PC + 2
	inc	SysTemp3
	sts	LOCALCHARCODE_H,SysTemp3
;Select case GLCDfntDefaultSize
;case 1
SysSelect5Case1:
	lds	SysCalcTempA,GLCDFNTDEFAULTSIZE
	cpi	SysCalcTempA,1
	brne	SysSelect5Case2
;ReadTable OLEDFont1Data, LocalCharCode, CurrCharVal
	lds	SYSSTRINGA,LOCALCHARCODE
	lds	SYSSTRINGA_H,LOCALCHARCODE_H
	rcall	OLEDFONT1DATA
	sts	CURRCHARVAL,SysByteTempX
;case 2
	rjmp	SysSelectEnd5
SysSelect5Case2:
	lds	SysCalcTempA,GLCDFNTDEFAULTSIZE
	cpi	SysCalcTempA,2
	brne	SysSelectEnd5
;Read this 20 times... (0..COLSperfont) [ * 2 ]
;ReadTable OLEDFont2, LocalCharCode, CurrCharVal
	lds	SYSSTRINGA,LOCALCHARCODE
	lds	SYSSTRINGA_H,LOCALCHARCODE_H
	rcall	OLEDFONT2
	sts	CURRCHARVAL,SysByteTempX
;End Select
SysSelectEnd5:
;we handle 8 or 16 pixels of height
;For CurrCharRow = 0 to ROWSperfont
	ldi	SysValueCopy,255
	sts	CURRCHARROW,SysValueCopy
	lds	SysCalcTempA,ROWSPERFONT
	cpi	SysCalcTempA,0
	brsh	ENDIF39
	rjmp	SysForLoopEnd19
ENDIF39:
SysForLoop19:
	lds	SysTemp3,CURRCHARROW
	inc	SysTemp3
	sts	CURRCHARROW,SysTemp3
;Set the pixel
;If CurrCharVal.0 = 0 Then
	lds	SysBitTest,CURRCHARVAL
	sbrc	SysBitTest,0
	rjmp	ELSE40_1
;PSet CharLocX + CurrCharCol, CharLocY + CurrCharRow, GLCDBACKGROUND
	lds	SysTemp3,CHARLOCX
	lds	SysTemp1,CURRCHARCOL
	add	SysTemp3,SysTemp1
	sts	GLCDX,SysTemp3
	lds	SysTemp3,CHARLOCX_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	sts	GLCDX_H,SysTemp3
	lds	SysTemp3,CHARLOCY
	lds	SysTemp1,CURRCHARROW
	add	SysTemp3,SysTemp1
	sts	GLCDY,SysTemp3
	lds	SysTemp3,CHARLOCY_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	sts	GLCDY_H,SysTemp3
	lds	SysValueCopy,GLCDBACKGROUND
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDBACKGROUND_H
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_EPD2IN13D
;Else
	rjmp	ENDIF40
ELSE40_1:
;PSet CharLocX + CurrCharCol, CharLocY + CurrCharRow, LineColour
	lds	SysTemp3,CHARLOCX
	lds	SysTemp1,CURRCHARCOL
	add	SysTemp3,SysTemp1
	sts	GLCDX,SysTemp3
	lds	SysTemp3,CHARLOCX_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	sts	GLCDX_H,SysTemp3
	lds	SysTemp3,CHARLOCY
	lds	SysTemp1,CURRCHARROW
	add	SysTemp3,SysTemp1
	sts	GLCDY,SysTemp3
	lds	SysTemp3,CHARLOCY_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	sts	GLCDY_H,SysTemp3
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_EPD2IN13D
;End If
ENDIF40:
;Rotate CurrCharVal Right
	lds	SysValueCopy,CURRCHARVAL
	ror	SysValueCopy
	sts	CURRCHARVAL,SysValueCopy
;Set to next row of date, a second row
;if GLCDfntDefaultSize = 2 and CurrCharRow = 7 then
	lds	SysBYTETempA,GLCDFNTDEFAULTSIZE
	ldi	SysBYTETempB,2
	call	SysCompEqual
	mov	SysTemp3,SysByteTempX
	lds	SysBYTETempA,CURRCHARROW
	ldi	SysBYTETempB,7
	call	SysCompEqual
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	sbrs	SysTemp1,0
	rjmp	ENDIF41
;LocalCharCode++
	lds	SysTemp3,LOCALCHARCODE
	inc	SysTemp3
	sts	LOCALCHARCODE,SysTemp3
	lds	SysTemp3,LOCALCHARCODE_H
	brne	PC + 2
	inc	SysTemp3
	sts	LOCALCHARCODE_H,SysTemp3
;ReadTable OLEDFont2, LocalCharCode, CurrCharVal
	lds	SYSSTRINGA,LOCALCHARCODE
	lds	SYSSTRINGA_H,LOCALCHARCODE_H
	rcall	OLEDFONT2
	sts	CURRCHARVAL,SysByteTempX
;end if
ENDIF41:
;It is the intercharacter space, put out one pixel row
;if CurrCharCol = COLSperfont then
	lds	SysCalcTempA,CURRCHARCOL
	lds	SysCalcTempB,COLSPERFONT
	cp	SysCalcTempA,SysCalcTempB
	brne	ENDIF42
;Put out a white intercharacter pixel/space
;GLCDTemp = CharLocX + CurrCharCol
	lds	SysTemp3,CHARLOCX
	lds	SysTemp1,CURRCHARCOL
	add	SysTemp3,SysTemp1
	sts	GLCDTEMP,SysTemp3
	lds	SysTemp3,CHARLOCX_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	sts	GLCDTEMP_H,SysTemp3
;if GLCDfntDefaultSize = 2 then
	lds	SysCalcTempA,GLCDFNTDEFAULTSIZE
	cpi	SysCalcTempA,2
	brne	ENDIF45
;GLCDTemp++
	lds	SysTemp3,GLCDTEMP
	inc	SysTemp3
	sts	GLCDTEMP,SysTemp3
	lds	SysTemp3,GLCDTEMP_H
	brne	PC + 2
	inc	SysTemp3
	sts	GLCDTEMP_H,SysTemp3
;end if
ENDIF45:
;PSet GLCDTemp , CharLocY + CurrCharRow, GLCDBACKGROUND
	lds	SysValueCopy,GLCDTEMP
	sts	GLCDX,SysValueCopy
	lds	SysValueCopy,GLCDTEMP_H
	sts	GLCDX_H,SysValueCopy
	lds	SysTemp3,CHARLOCY
	lds	SysTemp1,CURRCHARROW
	add	SysTemp3,SysTemp1
	sts	GLCDY,SysTemp3
	lds	SysTemp3,CHARLOCY_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	sts	GLCDY_H,SysTemp3
	lds	SysValueCopy,GLCDBACKGROUND
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDBACKGROUND_H
	sts	GLCDCOLOUR_H,SysValueCopy
	call	PSET_EPD2IN13D
;end if
ENDIF42:
;Next
	lds	SysCalcTempA,CURRCHARROW
	lds	SysCalcTempB,ROWSPERFONT
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF43
	rjmp	SysForLoop19
ENDIF43:
SysForLoopEnd19:
;Next
	lds	SysCalcTempA,CURRCHARCOL
	lds	SysCalcTempB,COLSPERFONT
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF44
	rjmp	SysForLoop18
ENDIF44:
SysForLoopEnd18:
	ret

;********************************************************************************

Delay_MS:
	inc	SysWaitTempMS_H
DMS_START:
	ldi	DELAYTEMP2,254
DMS_OUTER:
	ldi	DELAYTEMP,20
DMS_INNER:
	dec	DELAYTEMP
	brne	DMS_INNER
	dec	DELAYTEMP2
	brne	DMS_OUTER
	dec	SysWaitTempMS
	brne	DMS_START
	dec	SysWaitTempMS_H
	brne	DMS_START
	ret

;********************************************************************************

Delay_S:
DS_START:
	ldi	SysWaitTempMS,232
	ldi	SysWaitTempMS_H,3
	rcall	Delay_MS
	dec	SysWaitTempS
	brne	DS_START
	ret

;********************************************************************************

;Source: hwspi.h (665)
FASTHWSPITRANSFER:
;Master mode only
;Master mode only
;Do
SysDoLoop_S5:
;SPDR = SPITxData
	lds	SysValueCopy,SPITXDATA
	out	SPDR,SysValueCopy
;Loop While SPSR.WCOL
	in	SysBitTest,SPSR
	sbrc	SysBitTest,WCOL
	rjmp	SysDoLoop_S5
SysDoLoop_E5:
;Read buffer
;Same for master and slave
;Wait While SPSR.SPIF = Off
SysWaitLoop1:
	in	SysBitTest,SPSR
	sbrs	SysBitTest,SPIF
	rjmp	SysWaitLoop1
	ret

;********************************************************************************

;Overloaded signature: WORD:WORD:STRING:, Source: glcd.h (846)
GLCDPRINT5:
;GLCD.h Sub GLCDPrint
;Dim GLCDPrintLoc  as word
;Dim GLCDPrint_String_Counter, GLCDPrintLen as byte
;GLCDPrintLen = LCDPrintData(0)
	lds	SysStringA,SysLCDPRINTDATAHandler
	lds	SysStringA_H,SysLCDPRINTDATAHandler_H
	ld	SysValueCopy,X
	sts	GLCDPRINTLEN,SysValueCopy
;If GLCDPrintLen = 0 Then Exit Sub
	lds	SysCalcTempA,GLCDPRINTLEN
	tst	SysCalcTempA
	brne	ENDIF25
	ret
ENDIF25:
;dim OldGLCDFontWidth as Byte
;OldGLCDFontWidth = GLCDFontWidth
	lds	SysValueCopy,GLCDFONTWIDTH
	sts	OLDGLCDFONTWIDTH,SysValueCopy
;HSerPrint "In GLCDPrint-"
	ldi	SysStringB,low(SYSSTRINGPARAM2)
	ldi	SysStringB_H,high(SYSSTRINGPARAM2)
	ldi	SysReadA,low(StringTable27<<1)
	ldi	SysReadA_H,high(StringTable27<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM2)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM2)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT690
;HSerPrint PrintLocX
	lds	SysValueCopy,PRINTLOCX
	sts	SERPRINTVAL,SysValueCopy
	lds	SysValueCopy,PRINTLOCX_H
	sts	SERPRINTVAL_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT692
;HSerPrint ","
	ldi	SysStringB,low(SYSSTRINGPARAM2)
	ldi	SysStringB_H,high(SYSSTRINGPARAM2)
	ldi	SysReadA,low(StringTable28<<1)
	ldi	SysReadA_H,high(StringTable28<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM2)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM2)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT690
;HSerPrint PrintLocY
	lds	SysValueCopy,PRINTLOCY
	sts	SERPRINTVAL,SysValueCopy
	lds	SysValueCopy,PRINTLOCY_H
	sts	SERPRINTVAL_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT692
;HSerPrint ": "
	ldi	SysStringB,low(SYSSTRINGPARAM2)
	ldi	SysStringB_H,high(SYSSTRINGPARAM2)
	ldi	SysReadA,low(StringTable29<<1)
	ldi	SysReadA_H,high(StringTable29<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM2)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM2)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT690
;GLCDPrintLoc = PrintLocX
	lds	SysValueCopy,PRINTLOCX
	sts	GLCDPRINTLOC,SysValueCopy
	lds	SysValueCopy,PRINTLOCX_H
	sts	GLCDPRINTLOC_H,SysValueCopy
;Write Data
;For GLCDPrint_String_Counter = 1 To GLCDPrintLen
	ldi	SysValueCopy,0
	sts	GLCDPRINT_STRING_COUNTER,SysValueCopy
	lds	SysCalcTempA,GLCDPRINTLEN
	cpi	SysCalcTempA,1
	brsh	ENDIF26
	rjmp	SysForLoopEnd7
ENDIF26:
SysForLoop7:
	lds	SysTemp3,GLCDPRINT_STRING_COUNTER
	inc	SysTemp3
	sts	GLCDPRINT_STRING_COUNTER,SysTemp3
;GLCDDrawChar  GLCDPrintLoc, PrintLocY, LCDPrintData(GLCDPrint_String_Counter)
	lds	SysValueCopy,GLCDPRINTLOC
	sts	CHARLOCX,SysValueCopy
	lds	SysValueCopy,GLCDPRINTLOC_H
	sts	CHARLOCX_H,SysValueCopy
	lds	SysValueCopy,PRINTLOCY
	sts	CHARLOCY,SysValueCopy
	lds	SysValueCopy,PRINTLOCY_H
	sts	CHARLOCY_H,SysValueCopy
	lds	SysTemp3,SysLCDPRINTDATAHandler
	lds	SysTemp1,GLCDPRINT_STRING_COUNTER
	add	SysTemp3,SysTemp1
	mov	SysStringA,SysTemp3
	lds	SysTemp3,SysLCDPRINTDATAHandler_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	mov	SysStringA_H,SysTemp3
	ld	SysValueCopy,X
	sts	CHARCODE,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND
	sts	LINECOLOUR,SysValueCopy
	lds	SysValueCopy,GLCDFOREGROUND_H
	sts	LINECOLOUR_H,SysValueCopy
	rcall	DRAWCHAR_EPD2IN13D
;GLCDPrintIncrementPixelPositionMacro
;Macro Source: glcd.h (1089)
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize ) + GLCDfntDefaultsize - 1
	lds	SysBYTETempA,GLCDFONTWIDTH
	lds	SysBYTETempB,GLCDFNTDEFAULTSIZE
	mul	SysByteTempA,SysByteTempB
	mov	SysTemp3,SysByteTempX
	lds	SysTemp1,GLCDPRINTLOC
	add	SysTemp1,SysTemp3
	mov	SysTemp2,SysTemp1
	lds	SysTemp3,GLCDPRINTLOC_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	mov	SysTemp2_H,SysTemp3
	lds	SysTemp3,GLCDFNTDEFAULTSIZE
	add	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	ldi	SysTemp4,0
	adc	SysTemp2_H,SysTemp4
	mov	SysTemp1_H,SysTemp2_H
	ldi	SysTemp4,1
	sub	SysTemp1,SysTemp4
	sts	GLCDPRINTLOC,SysTemp1
	ldi	SysTemp4,0
	sbc	SysTemp1_H,SysTemp4
	sts	GLCDPRINTLOC_H,SysTemp1_H
;Next
	lds	SysCalcTempA,GLCDPRINT_STRING_COUNTER
	lds	SysCalcTempB,GLCDPRINTLEN
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF27
	rjmp	SysForLoop7
ENDIF27:
SysForLoopEnd7:
;Update the current X position for GLCDPrintString
;PrintLocX = GLCDPrintLoc
	lds	SysValueCopy,GLCDPRINTLOC
	sts	PRINTLOCX,SysValueCopy
	lds	SysValueCopy,GLCDPRINTLOC_H
	sts	PRINTLOCX_H,SysValueCopy
;GLCDFontWidth = OldGLCDFontWidth
	lds	SysValueCopy,OLDGLCDFONTWIDTH
	sts	GLCDFONTWIDTH,SysValueCopy
	ret

;********************************************************************************

;Source: glcd.h (1114)
GLCDPRINTSTRINGLN:
;dim PrintLocX, PrintLocY as word
;GLCDPrint( PrintLocX , PrintLocY , LCDPrintData )
	lds	SysValueCopy,SysLCDPRINTDATAHandler
	sts	SysLCDPRINTDATAHandler,SysValueCopy
	lds	SysValueCopy,SysLCDPRINTDATAHandler_H
	sts	SysLCDPRINTDATAHandler_H,SysValueCopy
	rcall	GLCDPRINT5
;Update the current X and Y position
;PrintLocX = 0
	ldi	SysValueCopy,0
	sts	PRINTLOCX,SysValueCopy
	sts	PRINTLOCX_H,SysValueCopy
;When using Transaction  PrintLocY will get incremented. This needs to be protected
;PrintLocY = ( PrintLocY + ( GLCDfntDefaultHeight * GLCDfntDefaultSize ) ) mod EPD_CORRECTED_HEIGHT
	lds	SysBYTETempA,GLCDFNTDEFAULTHEIGHT
	lds	SysBYTETempB,GLCDFNTDEFAULTSIZE
	mul	SysByteTempA,SysByteTempB
	mov	SysTemp1,SysByteTempX
	lds	SysTemp3,PRINTLOCY
	add	SysTemp3,SysTemp1
	mov	SysTemp2,SysTemp3
	lds	SysTemp1,PRINTLOCY_H
	ldi	SysTemp4,0
	adc	SysTemp1,SysTemp4
	mov	SysTemp2_H,SysTemp1
	mov	SysWORDTempA,SysTemp2
	mov	SysWORDTempA_H,SysTemp2_H
	ldi	SysWORDTempB,208
	ldi	SysWORDTempB_H,0
	call	SysDivSub16
	sts	PRINTLOCY,SysWORDTempX
	sts	PRINTLOCY_H,SysWORDTempX_H
	ret

;********************************************************************************

;Overloaded signature: STRING:byte:, Source: usart.h (1251)
HSERPRINT690:
;PrintLen = PrintData(0)
	lds	SysStringA,SysPRINTDATAHandler
	lds	SysStringA_H,SysPRINTDATAHandler_H
	ld	SysValueCopy,X
	sts	PRINTLEN,SysValueCopy
;If PrintLen <> 0 then
	lds	SysCalcTempA,PRINTLEN
	tst	SysCalcTempA
	breq	ENDIF49
;Write Data
;for SysPrintTemp = 1 to PrintLen
	ldi	SysValueCopy,0
	sts	SYSPRINTTEMP,SysValueCopy
	lds	SysCalcTempA,PRINTLEN
	cpi	SysCalcTempA,1
	brlo	SysForLoopEnd20
SysForLoop20:
	lds	SysTemp3,SYSPRINTTEMP
	inc	SysTemp3
	sts	SYSPRINTTEMP,SysTemp3
;HSerSend(PrintData(SysPrintTemp),comport )
	lds	SysTemp3,SysPRINTDATAHandler
	lds	SysTemp1,SYSPRINTTEMP
	add	SysTemp3,SysTemp1
	mov	SysStringA,SysTemp3
	lds	SysTemp3,SysPRINTDATAHandler_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	mov	SysStringA_H,SysTemp3
	ld	SysValueCopy,X
	sts	SERDATA,SysValueCopy
	rcall	HSERSEND680
;next
	lds	SysCalcTempA,SYSPRINTTEMP
	lds	SysCalcTempB,PRINTLEN
	cp	SysCalcTempA,SysCalcTempB
	brlo	SysForLoop20
SysForLoopEnd20:
;End If
ENDIF49:
;CR
	ret

;********************************************************************************

;Overloaded signature: WORD:byte:, Source: usart.h (1302)
HSERPRINT692:
;Dim SysCalcTempX As Word
;OutValueTemp = 0
	ldi	SysValueCopy,0
	sts	OUTVALUETEMP,SysValueCopy
;If SerPrintVal >= 10000 then
	lds	SysWORDTempA,SERPRINTVAL
	lds	SysWORDTempA_H,SERPRINTVAL_H
	ldi	SysWORDTempB,16
	ldi	SysWORDTempB_H,39
	call	SysCompLessThan16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF52
;OutValueTemp = SerPrintVal / 10000 [word]
	lds	SysWORDTempA,SERPRINTVAL
	lds	SysWORDTempA_H,SERPRINTVAL_H
	ldi	SysWORDTempB,16
	ldi	SysWORDTempB_H,39
	call	SysDivSub16
	sts	OUTVALUETEMP,SysWORDTempA
;SerPrintVal = SysCalcTempX
	sts	SERPRINTVAL,SYSCALCTEMPX
	sts	SERPRINTVAL_H,SYSCALCTEMPX_H
;HSerSend(OutValueTemp + 48 ,comport )
	lds	SysTemp3,OUTVALUETEMP
	ldi	SysTemp4,48
	add	SysTemp3,SysTemp4
	sts	SERDATA,SysTemp3
	rcall	HSERSEND680
;Goto HSerPrintWord1000
	rjmp	HSERPRINTWORD1000
;End If
ENDIF52:
;If SerPrintVal >= 1000 then
	lds	SysWORDTempA,SERPRINTVAL
	lds	SysWORDTempA_H,SERPRINTVAL_H
	ldi	SysWORDTempB,232
	ldi	SysWORDTempB_H,3
	call	SysCompLessThan16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF53
HSERPRINTWORD1000:
;OutValueTemp = SerPrintVal / 1000 [word]
	lds	SysWORDTempA,SERPRINTVAL
	lds	SysWORDTempA_H,SERPRINTVAL_H
	ldi	SysWORDTempB,232
	ldi	SysWORDTempB_H,3
	call	SysDivSub16
	sts	OUTVALUETEMP,SysWORDTempA
;SerPrintVal = SysCalcTempX
	sts	SERPRINTVAL,SYSCALCTEMPX
	sts	SERPRINTVAL_H,SYSCALCTEMPX_H
;HSerSend(OutValueTemp + 48 ,comport  )
	lds	SysTemp3,OUTVALUETEMP
	ldi	SysTemp4,48
	add	SysTemp3,SysTemp4
	sts	SERDATA,SysTemp3
	rcall	HSERSEND680
;Goto HSerPrintWord100
	rjmp	HSERPRINTWORD100
;End If
ENDIF53:
;If SerPrintVal >= 100 then
	lds	SysWORDTempA,SERPRINTVAL
	lds	SysWORDTempA_H,SERPRINTVAL_H
	ldi	SysWORDTempB,100
	ldi	SysWORDTempB_H,0
	call	SysCompLessThan16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF54
HSERPRINTWORD100:
;OutValueTemp = SerPrintVal / 100 [word]
	lds	SysWORDTempA,SERPRINTVAL
	lds	SysWORDTempA_H,SERPRINTVAL_H
	ldi	SysWORDTempB,100
	ldi	SysWORDTempB_H,0
	call	SysDivSub16
	sts	OUTVALUETEMP,SysWORDTempA
;SerPrintVal = SysCalcTempX
	sts	SERPRINTVAL,SYSCALCTEMPX
	sts	SERPRINTVAL_H,SYSCALCTEMPX_H
;HSerSend(OutValueTemp + 48 ,comport )
	lds	SysTemp3,OUTVALUETEMP
	ldi	SysTemp4,48
	add	SysTemp3,SysTemp4
	sts	SERDATA,SysTemp3
	rcall	HSERSEND680
;Goto HSerPrintWord10
	rjmp	HSERPRINTWORD10
;End If
ENDIF54:
;If SerPrintVal >= 10 then
	lds	SysWORDTempA,SERPRINTVAL
	lds	SysWORDTempA_H,SERPRINTVAL_H
	ldi	SysWORDTempB,10
	ldi	SysWORDTempB_H,0
	call	SysCompLessThan16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF55
HSERPRINTWORD10:
;OutValueTemp = SerPrintVal / 10 [word]
	lds	SysWORDTempA,SERPRINTVAL
	lds	SysWORDTempA_H,SERPRINTVAL_H
	ldi	SysWORDTempB,10
	ldi	SysWORDTempB_H,0
	call	SysDivSub16
	sts	OUTVALUETEMP,SysWORDTempA
;SerPrintVal = SysCalcTempX
	sts	SERPRINTVAL,SYSCALCTEMPX
	sts	SERPRINTVAL_H,SYSCALCTEMPX_H
;HSerSend(OutValueTemp + 48 ,comport )
	lds	SysTemp3,OUTVALUETEMP
	ldi	SysTemp4,48
	add	SysTemp3,SysTemp4
	sts	SERDATA,SysTemp3
	rcall	HSERSEND680
;End If
ENDIF55:
;HSerSend(SerPrintVal + 48 ,comport  )
	lds	SysTemp3,SERPRINTVAL
	ldi	SysTemp4,48
	add	SysTemp3,SysTemp4
	sts	SERDATA,SysTemp3
	rcall	HSERSEND679
;CR
	ret

;********************************************************************************

;Source: usart.h (1403)
HSERPRINTCRLF:
;repeat HSerPrintCRLFCount
	lds	SysValueCopy,HSERPRINTCRLFCOUNT
	sts	SysRepeatTemp1,SysValueCopy
	lds	SysCalcTempA,SYSREPEATTEMP1
	tst	SysCalcTempA
	brne	PC + 2
	rjmp	SysRepeatLoopEnd1
SysRepeatLoop1:
;HSerSend(13,comport)
	ldi	SysValueCopy,13
	sts	SERDATA,SysValueCopy
	rcall	HSERSEND680
;HSerSend(10,comport)
	ldi	SysValueCopy,10
	sts	SERDATA,SysValueCopy
	rcall	HSERSEND680
;end Repeat
	lds	SysTemp3,SysRepeatTemp1
	dec	SysTemp3
	sts	SysRepeatTemp1,SysTemp3
	brne	SysRepeatLoop1
SysRepeatLoopEnd1:
	ret

;********************************************************************************

;Overloaded signature: BYTE:, Source: usart.h (653)
HSERSEND679:
;AVR USART1 Send
;Wait While UDRE0 = Off    'Blocking Transmit buffer empty ,ready for data
SysWaitLoop3:
	lds	SysBitTest,UCSR0A
	sbrs	SysBitTest,UDRE0
	rjmp	SysWaitLoop3
;UDR0 = SerData ' *******************
	lds	SysValueCopy,SERDATA
	sts	UDR0,SysValueCopy
	ret

;********************************************************************************

;Overloaded signature: BYTE:byte:, Source: usart.h (736)
HSERSEND680:
;AVR USART1 Send
;if comport = 1 Then
	lds	SysCalcTempA,COMPORT
	cpi	SysCalcTempA,1
	brne	ENDIF48
;HSerSendBlocker    'comport 1 blocker
;Wait While UDRE0 = Off    'Blocking Transmit buffer empty ,ready for data
SysWaitLoop2:
	lds	SysBitTest,UCSR0A
	sbrs	SysBitTest,UDRE0
	rjmp	SysWaitLoop2
;#ifndef Var(UDR0)
;#ifdef Var(UDR1)
;UDR1 = SerData    '? second comport
;#endif
;#endif
;UDR0 = SerData ' *******************
	lds	SysValueCopy,SERDATA
	sts	UDR0,SysValueCopy
;End If
ENDIF48:
;----------------------------------------------------
;AVR USART 2 send
;AVR USART 3 send
;AVR USART 4 send
	ret

;********************************************************************************

;Source: system.h (99)
INITSYS:
;Commence clearing any ANSEL variants in the part
;End clearing any ANSEL variants in the part
;Turn off all ports
;PORTB = 0
	ldi	SysValueCopy,0
	out	PORTB,SysValueCopy
;PORTC = 0
	ldi	SysValueCopy,0
	out	PORTC,SysValueCopy
;PORTD = 0
	ldi	SysValueCopy,0
	out	PORTD,SysValueCopy
	ret

;********************************************************************************

;Source: usart.h (454)
INITUSART:
;Set the default value for comport
;comport = 1
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
;Set baud rate
;U2X0 = U2X0_TEMP        'U2X0 ex: mega328P
	lds	SysValueCopy,UCSR0A
	sbr	SysValueCopy,1<<U2X0
	sts	UCSR0A,SysValueCopy
;UBRR0L = UBRRL_TEMP
	ldi	SysValueCopy,207
	sts	UBRR0L,SysValueCopy
;UBRR0H = UBRRH_TEMP
	ldi	SysValueCopy,0
	sts	UBRR0H,SysValueCopy
;Enable TX and RX
;RXEN0 = On
	lds	SysValueCopy,UCSR0B
	sbr	SysValueCopy,1<<RXEN0
	sts	UCSR0B,SysValueCopy
;TXEN0 = On
	sbr	SysValueCopy,1<<TXEN0
	sts	UCSR0B,SysValueCopy
	ret

;********************************************************************************

;Source: epd_epd2in13d.h (156)
INIT_EPD2IN13D:
;dim _GLCDPagesL, _GLCDPagesH  as byte
;asm showdebug Current_buffer_size_is BUFFWIDTH
;current_buffer_size_is 1378
;Dir   EPD_DC     OUT
	sbi	DDRB,1
;Dir   EPD_CS     OUT
	sbi	DDRB,2
;Dir   EPD_RESET  OUT
	sbi	DDRB,0
;Dir   EPD_DO     OUT
	sbi	DDRB,3
;Dir   EPD_SCK    OUT
	sbi	DDRB,5
;Dir   EPD_Busy   IN
	cbi	DDRD,7
;SET EPD_RESET ON
	sbi	PORTB,0
;wait 200 ms
	ldi	SysWaitTempMS,200
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;SET EPD_RESET OFF
	cbi	PORTB,0
;wait 20 ms
	ldi	SysWaitTempMS,20
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;SET EPD_RESET ON
	sbi	PORTB,0
;wait 200 ms
	ldi	SysWaitTempMS,200
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;harware SPI mode
;asm showdebug SPI constant used equates to HWSPIMODESCRIPT
;spi constant used equates to 14
;SPIMode HWSPIMODESCRIPT, 0
	ldi	SysValueCopy,14
	sts	SPICURRENTMODE,SysValueCopy
	ldi	SysValueCopy,0
	sts	SPICLOCKMODE,SysValueCopy
	call	SPIMODE645
;SendCommand_EPD2in13D(BOOSTER_SOFT_START)
	ldi	SysValueCopy,6
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0x17)
	ldi	SysValueCopy,23
	sts	EPD2IN13D_DATA,SysValueCopy
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x17)
	ldi	SysValueCopy,23
	sts	EPD2IN13D_DATA,SysValueCopy
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x17)
	ldi	SysValueCopy,23
	sts	EPD2IN13D_DATA,SysValueCopy
	call	SENDDATA_EPD2IN13D
;wait 20 ms
	ldi	SysWaitTempMS,20
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;SendCommand_EPD2in13D(POWER_SETTING)
	ldi	SysValueCopy,1
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0x03)
	ldi	SysValueCopy,3
	sts	EPD2IN13D_DATA,SysValueCopy
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x00)
	ldi	SysValueCopy,0
	sts	EPD2IN13D_DATA,SysValueCopy
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x2B)
	ldi	SysValueCopy,43
	sts	EPD2IN13D_DATA,SysValueCopy
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x2B)
	ldi	SysValueCopy,43
	sts	EPD2IN13D_DATA,SysValueCopy
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x03)
	ldi	SysValueCopy,3
	sts	EPD2IN13D_DATA,SysValueCopy
	call	SENDDATA_EPD2IN13D
;wait 2 ms
	ldi	SysWaitTempMS,2
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;SendCommand_EPD2in13D(POWER_ON)
	ldi	SysValueCopy,4
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;SendCommand_EPD2in13D(PANEL_SETTING)
	ldi	SysValueCopy,0
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(PANEL_SETTING_VALUE or PANEL_SETTING_KWR )
	ldi	SysValueCopy,191
	sts	EPD2IN13D_DATA,SysValueCopy
	call	SENDDATA_EPD2IN13D
;SendCommand_EPD2in13D(PLL_CONTROL)
	ldi	SysValueCopy,48
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0x3C)
	ldi	SysValueCopy,60
	sts	EPD2IN13D_DATA,SysValueCopy
	call	SENDDATA_EPD2IN13D
;SendCommand_EPD2in13D(RESOLUTION_SETTING)
	ldi	SysValueCopy,97
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0x68)
	ldi	SysValueCopy,104
	sts	EPD2IN13D_DATA,SysValueCopy
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x00)
	ldi	SysValueCopy,0
	sts	EPD2IN13D_DATA,SysValueCopy
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0xD4)
	ldi	SysValueCopy,212
	sts	EPD2IN13D_DATA,SysValueCopy
	call	SENDDATA_EPD2IN13D
;SendCommand_EPD2in13D(VCM_DC_SETTING)
	ldi	SysValueCopy,130
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0x12)
	ldi	SysValueCopy,18
	sts	EPD2IN13D_DATA,SysValueCopy
	call	SENDDATA_EPD2IN13D
;LoadLUTS_EPD2in13D
	rcall	LOADLUTS_EPD2IN13D
;Colours
;GLCDForeground =TFT_WHITE
	ldi	SysValueCopy,255
	sts	GLCDFOREGROUND,SysValueCopy
	sts	GLCDFOREGROUND_H,SysValueCopy
;Default Colours
;GLCDBackground = TFT_BLACK
	ldi	SysValueCopy,0
	sts	GLCDBACKGROUND,SysValueCopy
	sts	GLCDBACKGROUND_H,SysValueCopy
;GLCDFontWidth = 5
	ldi	SysValueCopy,5
	sts	GLCDFONTWIDTH,SysValueCopy
;Variables required for device
;GLCDDeviceWidth = GLCD_WIDTH - 1
	ldi	SysValueCopy,103
	sts	GLCDDEVICEWIDTH,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDDEVICEWIDTH_H,SysValueCopy
;GLCDDeviceHeight= GLCD_HEIGHT- 1
	ldi	SysValueCopy,211
	sts	GLCDDEVICEHEIGHT,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDDEVICEHEIGHT_H,SysValueCopy
;GLCDRotate Portrait
	ldi	SysValueCopy,4
	sts	EPD2IN13DADDRESSTYPE,SysValueCopy
	call	ROTATE_EPD2IN13D
;GLCDfntDefault = 0
	ldi	SysValueCopy,0
	sts	GLCDFNTDEFAULT,SysValueCopy
;GLCDfntDefaultsize = 1
	ldi	SysValueCopy,1
	sts	GLCDFNTDEFAULTSIZE,SysValueCopy
;GLCDfntDefaultHeight = 8
	ldi	SysValueCopy,8
	sts	GLCDFNTDEFAULTHEIGHT,SysValueCopy
;CLS_EPD2in13D_init
	rcall	CLS_EPD2IN13D_INIT
;_GLCDPagesH = EPD_N_PAGE - 1
	ldi	SysValueCopy,1
	sts	_GLCDPAGESH,SysValueCopy
;_GLCDPagesL = 0
	ldi	SysValueCopy,0
	sts	_GLCDPAGESL,SysValueCopy
	ret

;********************************************************************************

;Source: glcd.h (1487)
LINE:
;dim LineStepX as integer
;dim LineStepY as integer
;dim LineDiffX, LineDiffY as integer
;dim LineDiffX_x2, LineDiffY_x2 as integer
;dim LineErr as integer
;LineDiffX = 0
	ldi	SysValueCopy,0
	sts	LINEDIFFX,SysValueCopy
	sts	LINEDIFFX_H,SysValueCopy
;LineDiffY = 0
	ldi	SysValueCopy,0
	sts	LINEDIFFY,SysValueCopy
	sts	LINEDIFFY_H,SysValueCopy
;LineStepX = 0
	ldi	SysValueCopy,0
	sts	LINESTEPX,SysValueCopy
	sts	LINESTEPX_H,SysValueCopy
;LineStepY = 0
	ldi	SysValueCopy,0
	sts	LINESTEPY,SysValueCopy
	sts	LINESTEPY_H,SysValueCopy
;LineDiffX_x2 = 0
	ldi	SysValueCopy,0
	sts	LINEDIFFX_X2,SysValueCopy
	sts	LINEDIFFX_X2_H,SysValueCopy
;LineDiffY_x2 = 0
	ldi	SysValueCopy,0
	sts	LINEDIFFY_X2,SysValueCopy
	sts	LINEDIFFY_X2_H,SysValueCopy
;LineErr = 0
	ldi	SysValueCopy,0
	sts	LINEERR,SysValueCopy
	sts	LINEERR_H,SysValueCopy
;LineDiffX =  LineX2 -   LineX1
	lds	SysTemp1,LINEX2
	lds	SysTemp3,LINEX1
	sub	SysTemp1,SysTemp3
	sts	LINEDIFFX,SysTemp1
	lds	SysTemp1,LINEX2_H
	lds	SysTemp3,LINEX1_H
	sbc	SysTemp1,SysTemp3
	sts	LINEDIFFX_H,SysTemp1
;LineDiffY =  LineY2 -   LineY1
	lds	SysTemp1,LINEY2
	lds	SysTemp3,LINEY1
	sub	SysTemp1,SysTemp3
	sts	LINEDIFFY,SysTemp1
	lds	SysTemp1,LINEY2_H
	lds	SysTemp3,LINEY1_H
	sbc	SysTemp1,SysTemp3
	sts	LINEDIFFY_H,SysTemp1
;if (LineDiffX > 0) then
	lds	SysINTEGERTempB,LINEDIFFX
	lds	SysINTEGERTempB_H,LINEDIFFX_H
	ldi	SysINTEGERTempA,0
	ldi	SysINTEGERTempA_H,0
	call	SysCompLessThanINT
	sbrs	SysByteTempX,0
	rjmp	ELSE5_1
;LineStepX = 1
	ldi	SysValueCopy,1
	sts	LINESTEPX,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINESTEPX_H,SysValueCopy
;else
	rjmp	ENDIF5
ELSE5_1:
;LineStepX = -1
	ldi	SysValueCopy,255
	sts	LINESTEPX,SysValueCopy
	sts	LINESTEPX_H,SysValueCopy
;end if
ENDIF5:
;if (LineDiffY > 0) then
	lds	SysINTEGERTempB,LINEDIFFY
	lds	SysINTEGERTempB_H,LINEDIFFY_H
	ldi	SysINTEGERTempA,0
	ldi	SysINTEGERTempA_H,0
	call	SysCompLessThanINT
	sbrs	SysByteTempX,0
	rjmp	ELSE6_1
;LineStepY = 1
	ldi	SysValueCopy,1
	sts	LINESTEPY,SysValueCopy
	ldi	SysValueCopy,0
	sts	LINESTEPY_H,SysValueCopy
;else
	rjmp	ENDIF6
ELSE6_1:
;LineStepY = -1
	ldi	SysValueCopy,255
	sts	LINESTEPY,SysValueCopy
	sts	LINESTEPY_H,SysValueCopy
;end if
ENDIF6:
;LineDiffX = LineStepX * LineDiffX
	lds	SysINTEGERTempA,LINESTEPX
	lds	SysINTEGERTempA_H,LINESTEPX_H
	lds	SysINTEGERTempB,LINEDIFFX
	lds	SysINTEGERTempB_H,LINEDIFFX_H
	call	SysMultSubINT
	sts	LINEDIFFX,SysINTEGERTempX
	sts	LINEDIFFX_H,SysINTEGERTempX_H
;LineDiffY = LineStepY * LineDiffY
	lds	SysINTEGERTempA,LINESTEPY
	lds	SysINTEGERTempA_H,LINESTEPY_H
	lds	SysINTEGERTempB,LINEDIFFY
	lds	SysINTEGERTempB_H,LINEDIFFY_H
	call	SysMultSubINT
	sts	LINEDIFFY,SysINTEGERTempX
	sts	LINEDIFFY_H,SysINTEGERTempX_H
;LineDiffX_x2 = LineDiffX*2
	lds	SysINTEGERTempA,LINEDIFFX
	lds	SysINTEGERTempA_H,LINEDIFFX_H
	ldi	SysINTEGERTempB,2
	ldi	SysINTEGERTempB_H,0
	call	SysMultSubINT
	sts	LINEDIFFX_X2,SysINTEGERTempX
	sts	LINEDIFFX_X2_H,SysINTEGERTempX_H
;LineDiffY_x2 = LineDiffY*2
	lds	SysINTEGERTempA,LINEDIFFY
	lds	SysINTEGERTempA_H,LINEDIFFY_H
	ldi	SysINTEGERTempB,2
	ldi	SysINTEGERTempB_H,0
	call	SysMultSubINT
	sts	LINEDIFFY_X2,SysINTEGERTempX
	sts	LINEDIFFY_X2_H,SysINTEGERTempX_H
;if ( LineDiffX >= LineDiffY) then
	lds	SysINTEGERTempA,LINEDIFFX
	lds	SysINTEGERTempA_H,LINEDIFFX_H
	lds	SysINTEGERTempB,LINEDIFFY
	lds	SysINTEGERTempB_H,LINEDIFFY_H
	call	SysCompLessThanINT
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ELSE7_1
;LineErr = LineDiffY_x2 - LineDiffX
	lds	SysTemp1,LINEDIFFY_X2
	lds	SysTemp3,LINEDIFFX
	sub	SysTemp1,SysTemp3
	sts	LINEERR,SysTemp1
	lds	SysTemp1,LINEDIFFY_X2_H
	lds	SysTemp3,LINEDIFFX_H
	sbc	SysTemp1,SysTemp3
	sts	LINEERR_H,SysTemp1
;do while (   LineX1 <>  LineX2 )
SysDoLoop_S2:
	lds	SysWORDTempA,linex1
	lds	SysWORDTempA_H,linex1_H
	lds	SysWORDTempB,linex2
	lds	SysWORDTempB_H,linex2_H
	call	SysCompEqual16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	SysDoLoop_E2
;PSet (   LineX1,   LineY1, LineColour )
	lds	SysValueCopy,LINEX1
	sts	GLCDX,SysValueCopy
	lds	SysValueCopy,LINEX1_H
	sts	GLCDX_H,SysValueCopy
	lds	SysValueCopy,LINEY1
	sts	GLCDY,SysValueCopy
	lds	SysValueCopy,LINEY1_H
	sts	GLCDY_H,SysValueCopy
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	rcall	PSET_EPD2IN13D
;LineX1 += LineStepX
	lds	SysTemp1,LINEX1
	lds	SysTemp3,LINESTEPX
	add	SysTemp1,SysTemp3
	sts	LINEX1,SysTemp1
	lds	SysTemp1,LINEX1_H
	lds	SysTemp3,LINESTEPX_H
	adc	SysTemp1,SysTemp3
	sts	LINEX1_H,SysTemp1
;if ( LineErr < 0) then
	lds	SysINTEGERTempA,LINEERR
	lds	SysINTEGERTempA_H,LINEERR_H
	ldi	SysINTEGERTempB,0
	ldi	SysINTEGERTempB_H,0
	call	SysCompLessThanINT
	sbrs	SysByteTempX,0
	rjmp	ELSE8_1
;LineErr += LineDiffY_x2
	lds	SysTemp1,LINEERR
	lds	SysTemp3,LINEDIFFY_X2
	add	SysTemp1,SysTemp3
	sts	LINEERR,SysTemp1
	lds	SysTemp1,LINEERR_H
	lds	SysTemp3,LINEDIFFY_X2_H
	adc	SysTemp1,SysTemp3
	sts	LINEERR_H,SysTemp1
;else
	rjmp	ENDIF8
ELSE8_1:
;LineErr += ( LineDiffY_x2 - LineDiffX_x2 )
	lds	SysTemp3,LINEDIFFY_X2
	lds	SysTemp2,LINEDIFFX_X2
	sub	SysTemp3,SysTemp2
	mov	SysTemp1,SysTemp3
	lds	SysTemp3,LINEDIFFY_X2_H
	lds	SysTemp2,LINEDIFFX_X2_H
	sbc	SysTemp3,SysTemp2
	mov	SysTemp1_H,SysTemp3
	lds	SysTemp3,LINEERR
	add	SysTemp3,SysTemp1
	sts	LINEERR,SysTemp3
	lds	SysTemp3,LINEERR_H
	adc	SysTemp3,SysTemp1_H
	sts	LINEERR_H,SysTemp3
;LineY1 += LineStepY
	lds	SysTemp3,LINEY1
	lds	SysTemp1,LINESTEPY
	add	SysTemp3,SysTemp1
	sts	LINEY1,SysTemp3
	lds	SysTemp3,LINEY1_H
	lds	SysTemp1,LINESTEPY_H
	adc	SysTemp3,SysTemp1
	sts	LINEY1_H,SysTemp3
;end if
ENDIF8:
;loop
	rjmp	SysDoLoop_S2
SysDoLoop_E2:
;PSet (   LineX1,   LineY1, LineColour )
	lds	SysValueCopy,LINEX1
	sts	GLCDX,SysValueCopy
	lds	SysValueCopy,LINEX1_H
	sts	GLCDX_H,SysValueCopy
	lds	SysValueCopy,LINEY1
	sts	GLCDY,SysValueCopy
	lds	SysValueCopy,LINEY1_H
	sts	GLCDY_H,SysValueCopy
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	rcall	PSET_EPD2IN13D
;else
	rjmp	ENDIF7
ELSE7_1:
;LineErr = LineDiffX_x2 - LineDiffY
	lds	SysTemp3,LINEDIFFX_X2
	lds	SysTemp1,LINEDIFFY
	sub	SysTemp3,SysTemp1
	sts	LINEERR,SysTemp3
	lds	SysTemp3,LINEDIFFX_X2_H
	lds	SysTemp1,LINEDIFFY_H
	sbc	SysTemp3,SysTemp1
	sts	LINEERR_H,SysTemp3
;do while (   LineY1 <>  LineY2)
SysDoLoop_S3:
	lds	SysWORDTempA,liney1
	lds	SysWORDTempA_H,liney1_H
	lds	SysWORDTempB,liney2
	lds	SysWORDTempB_H,liney2_H
	call	SysCompEqual16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	SysDoLoop_E3
;PSet (   LineX1,   LineY1, LineColour )
	lds	SysValueCopy,LINEX1
	sts	GLCDX,SysValueCopy
	lds	SysValueCopy,LINEX1_H
	sts	GLCDX_H,SysValueCopy
	lds	SysValueCopy,LINEY1
	sts	GLCDY,SysValueCopy
	lds	SysValueCopy,LINEY1_H
	sts	GLCDY_H,SysValueCopy
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	rcall	PSET_EPD2IN13D
;LineY1 += LineStepY
	lds	SysTemp3,LINEY1
	lds	SysTemp1,LINESTEPY
	add	SysTemp3,SysTemp1
	sts	LINEY1,SysTemp3
	lds	SysTemp3,LINEY1_H
	lds	SysTemp1,LINESTEPY_H
	adc	SysTemp3,SysTemp1
	sts	LINEY1_H,SysTemp3
;if ( LineErr < 0) then
	lds	SysINTEGERTempA,LINEERR
	lds	SysINTEGERTempA_H,LINEERR_H
	ldi	SysINTEGERTempB,0
	ldi	SysINTEGERTempB_H,0
	call	SysCompLessThanINT
	sbrs	SysByteTempX,0
	rjmp	ELSE9_1
;LineErr += LineDiffX_x2
	lds	SysTemp3,LINEERR
	lds	SysTemp1,LINEDIFFX_X2
	add	SysTemp3,SysTemp1
	sts	LINEERR,SysTemp3
	lds	SysTemp3,LINEERR_H
	lds	SysTemp1,LINEDIFFX_X2_H
	adc	SysTemp3,SysTemp1
	sts	LINEERR_H,SysTemp3
;else
	rjmp	ENDIF9
ELSE9_1:
;LineErr += ( LineDiffX_x2 - LineDiffY_x2 )
	lds	SysTemp3,LINEDIFFX_X2
	lds	SysTemp2,LINEDIFFY_X2
	sub	SysTemp3,SysTemp2
	mov	SysTemp1,SysTemp3
	lds	SysTemp3,LINEDIFFX_X2_H
	lds	SysTemp2,LINEDIFFY_X2_H
	sbc	SysTemp3,SysTemp2
	mov	SysTemp1_H,SysTemp3
	lds	SysTemp3,LINEERR
	add	SysTemp3,SysTemp1
	sts	LINEERR,SysTemp3
	lds	SysTemp3,LINEERR_H
	adc	SysTemp3,SysTemp1_H
	sts	LINEERR_H,SysTemp3
;LineX1 += LineStepX
	lds	SysTemp3,LINEX1
	lds	SysTemp1,LINESTEPX
	add	SysTemp3,SysTemp1
	sts	LINEX1,SysTemp3
	lds	SysTemp3,LINEX1_H
	lds	SysTemp1,LINESTEPX_H
	adc	SysTemp3,SysTemp1
	sts	LINEX1_H,SysTemp3
;end if
ENDIF9:
;loop
	rjmp	SysDoLoop_S3
SysDoLoop_E3:
;PSet (   LineX1,   LineY1, LineColour )
	lds	SysValueCopy,LINEX1
	sts	GLCDX,SysValueCopy
	lds	SysValueCopy,LINEX1_H
	sts	GLCDX_H,SysValueCopy
	lds	SysValueCopy,LINEY1
	sts	GLCDY,SysValueCopy
	lds	SysValueCopy,LINEY1_H
	sts	GLCDY_H,SysValueCopy
	lds	SysValueCopy,LINECOLOUR
	sts	GLCDCOLOUR,SysValueCopy
	lds	SysValueCopy,LINECOLOUR_H
	sts	GLCDCOLOUR_H,SysValueCopy
	rcall	PSET_EPD2IN13D
;end if
ENDIF7:
	ret

;********************************************************************************

;Source: epd_epd2in13d.h (251)
LOADLUTS_EPD2IN13D:
;Dim DataVar as byte
;Dim Counter as Word
;SendCommand_EPD2in13D(VCM_DC_SETTING)
	ldi	SysValueCopy,130
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0x00)
	ldi	SysValueCopy,0
	sts	EPD2IN13D_DATA,SysValueCopy
	call	SENDDATA_EPD2IN13D
;SendCommand_EPD2in13D(VCOM_AND_DATA_INTERVAL_SETTING)
	ldi	SysValueCopy,80
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;Mask VCOM_AND_DATA_INTERVAL bits and then Mask the user bits.
;SendData_EPD2in13D( (0x90 AND 0xF0 ) or ( VCOM_AND_DATA_INTERVAL AND 0X0F ))
	ldi	SysValueCopy,151
	sts	EPD2IN13D_DATA,SysValueCopy
	call	SENDDATA_EPD2IN13D
;SendCommand_EPD2in13D(0x20) 'VCOM LUT
	ldi	SysValueCopy,32
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;for EPD_Counter=1 to 44
	ldi	SysValueCopy,0
	sts	EPD_COUNTER,SysValueCopy
SysForLoop8:
	lds	SysTemp3,EPD_COUNTER
	inc	SysTemp3
	sts	EPD_COUNTER,SysTemp3
;ReadTable Lut_Vcom, EPD_Counter, DataVar
	lds	SYSSTRINGA,EPD_COUNTER
	rcall	LUT_VCOM
	sts	DATAVAR,SysByteTempX
;SendData_EPD2in13D(DataVar)
	lds	SysValueCopy,DATAVAR
	sts	EPD2IN13D_DATA,SysValueCopy
	call	SENDDATA_EPD2IN13D
;next
	lds	SysCalcTempA,EPD_COUNTER
	cpi	SysCalcTempA,44
	brlo	SysForLoop8
SysForLoopEnd8:
;SendCommand_EPD2in13D(0x21) 'WW LUT
	ldi	SysValueCopy,33
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;for EPD_Counter=1 to 42
	ldi	SysValueCopy,0
	sts	EPD_COUNTER,SysValueCopy
SysForLoop9:
	lds	SysTemp3,EPD_COUNTER
	inc	SysTemp3
	sts	EPD_COUNTER,SysTemp3
;ReadTable Lut_WW, EPD_Counter, DataVar
	lds	SYSSTRINGA,EPD_COUNTER
	rcall	LUT_WW
	sts	DATAVAR,SysByteTempX
;SendData_EPD2in13D(DataVar)
	lds	SysValueCopy,DATAVAR
	sts	EPD2IN13D_DATA,SysValueCopy
	call	SENDDATA_EPD2IN13D
;next
	lds	SysCalcTempA,EPD_COUNTER
	cpi	SysCalcTempA,42
	brlo	SysForLoop9
SysForLoopEnd9:
;SendCommand_EPD2in13D(0x22) 'BW LUT
	ldi	SysValueCopy,34
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;for EPD_Counter=1 to 42
	ldi	SysValueCopy,0
	sts	EPD_COUNTER,SysValueCopy
SysForLoop10:
	lds	SysTemp3,EPD_COUNTER
	inc	SysTemp3
	sts	EPD_COUNTER,SysTemp3
;ReadTable Lut_BW, EPD_Counter, DataVar
	lds	SYSSTRINGA,EPD_COUNTER
	rcall	LUT_BW
	sts	DATAVAR,SysByteTempX
;SendData_EPD2in13D(DataVar)
	lds	SysValueCopy,DATAVAR
	sts	EPD2IN13D_DATA,SysValueCopy
	call	SENDDATA_EPD2IN13D
;next
	lds	SysCalcTempA,EPD_COUNTER
	cpi	SysCalcTempA,42
	brlo	SysForLoop10
SysForLoopEnd10:
;SendCommand_EPD2in13D(0x23) 'WB LUT
	ldi	SysValueCopy,35
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;for EPD_Counter=1 to 42
	ldi	SysValueCopy,0
	sts	EPD_COUNTER,SysValueCopy
SysForLoop11:
	lds	SysTemp3,EPD_COUNTER
	inc	SysTemp3
	sts	EPD_COUNTER,SysTemp3
;ReadTable Lut_WB, EPD_Counter, DataVar
	lds	SYSSTRINGA,EPD_COUNTER
	rcall	LUT_WB
	sts	DATAVAR,SysByteTempX
;SendData_EPD2in13D(DataVar)
	lds	SysValueCopy,DATAVAR
	sts	EPD2IN13D_DATA,SysValueCopy
	call	SENDDATA_EPD2IN13D
;next
	lds	SysCalcTempA,EPD_COUNTER
	cpi	SysCalcTempA,42
	brlo	SysForLoop11
SysForLoopEnd11:
;SendCommand_EPD2in13D(0x24) 'BB LUT
	ldi	SysValueCopy,36
	sts	EPD2IN13D_COMMAND,SysValueCopy
	call	SENDCOMMAND_EPD2IN13D
;for EPD_Counter=1 to 42
	ldi	SysValueCopy,0
	sts	EPD_COUNTER,SysValueCopy
SysForLoop12:
	lds	SysTemp3,EPD_COUNTER
	inc	SysTemp3
	sts	EPD_COUNTER,SysTemp3
;ReadTable Lut_BB, EPD_Counter, DataVar
	lds	SYSSTRINGA,EPD_COUNTER
	rcall	LUT_BB
	sts	DATAVAR,SysByteTempX
;SendData_EPD2in13D(DataVar)
	lds	SysValueCopy,DATAVAR
	sts	EPD2IN13D_DATA,SysValueCopy
	call	SENDDATA_EPD2IN13D
;next
	lds	SysCalcTempA,EPD_COUNTER
	cpi	SysCalcTempA,42
	brlo	SysForLoop12
SysForLoopEnd12:
	ret

;********************************************************************************

LUT_BB:
	cpi	SysStringA, 25
	brlo	PC + 3
	clr	SysByteTempX
	ret
	ldi	SysReadA, low(TableLUT_BB<<1)
	ldi	SysReadA_H, high(TableLUT_BB<<1)
	add	SysReadA, SysStringA
	brcc	PC + 2
	inc	SysReadA_H
	lpm
	ret
TableLUT_BB:
	.DB	42,128,8,0,0,0,2,144,40,40,0,0,1,128,20,0,0,0,1,80,18,18,0,0,1

;********************************************************************************

LUT_BW:
	cpi	SysStringA, 25
	brlo	PC + 3
	clr	SysByteTempX
	ret
	ldi	SysReadA, low(TableLUT_BW<<1)
	ldi	SysReadA_H, high(TableLUT_BW<<1)
	add	SysReadA, SysStringA
	brcc	PC + 2
	inc	SysReadA_H
	lpm
	ret
TableLUT_BW:
	.DB	42,64,23,0,0,0,2,144,15,15,0,0,3,64,10,1,0,0,1,160,14,14,0,0,2

;********************************************************************************

LUT_VCOM:
	cpi	SysStringA, 25
	brlo	PC + 3
	clr	SysByteTempX
	ret
	ldi	SysReadA, low(TableLUT_VCOM<<1)
	ldi	SysReadA_H, high(TableLUT_VCOM<<1)
	add	SysReadA, SysStringA
	brcc	PC + 2
	inc	SysReadA_H
	lpm
	ret
TableLUT_VCOM:
	.DB	44,0,8,0,0,0,2,96,40,40,0,0,1,0,20,0,0,0,1,0,18,18,0,0,1

;********************************************************************************

LUT_WB:
	cpi	SysStringA, 25
	brlo	PC + 3
	clr	SysByteTempX
	ret
	ldi	SysReadA, low(TableLUT_WB<<1)
	ldi	SysReadA_H, high(TableLUT_WB<<1)
	add	SysReadA, SysStringA
	brcc	PC + 2
	inc	SysReadA_H
	lpm
	ret
TableLUT_WB:
	.DB	42,128,8,0,0,0,2,144,40,40,0,0,1,128,20,0,0,0,1,80,18,18,0,0,1

;********************************************************************************

LUT_WW:
	cpi	SysStringA, 25
	brlo	PC + 3
	clr	SysByteTempX
	ret
	ldi	SysReadA, low(TableLUT_WW<<1)
	ldi	SysReadA_H, high(TableLUT_WW<<1)
	add	SysReadA, SysStringA
	brcc	PC + 2
	inc	SysReadA_H
	lpm
	ret
TableLUT_WW:
	.DB	42,64,8,0,0,0,2,144,40,40,0,0,1,64,20,0,0,0,1,160,18,18,0,0,1

;********************************************************************************

OLEDFONT1DATA:
	mov	SysWORDTempA,SYSSTRINGA
	mov	SysWORDTempA_H,SYSSTRINGA_H
	ldi	SysWORDTempB,165
	ldi	SysWORDTempB_H,1
	call	SysCompLessThan16
	sbrs	SysByteTempX,0
	ret
	ldi	SysReadA, low(TableOLEDFONT1DATA<<1)
	ldi	SysReadA_H, high(TableOLEDFONT1DATA<<1)
	add	SysReadA, SysStringA
	adc	SysReadA_H, SysStringA_H
	lpm
	ret
TableOLEDFONT1DATA:
	.DB	165,1,0,1,94,3,6,0,6,5,40,124,40,124,40,5,36,42,127,42,16,3,98,24,70,5,48,76,90,36
	.DB	80,1,6,2,60,66,2,66,60,5,40,16,124,16,40,3,16,56,16,1,192,3,16,16,16,1,64,3,96,24
	.DB	6,4,60,66,66,60,3,68,126,64,4,68,98,82,76,3,74,74,52,4,30,16,124,16,3,78,74,50
	.DB	4,60,74,74,48,3,98,18,14,4,52,74,74,52,4,12,82,82,60,1,72,2,128,104,3,16,40,68
	.DB	3,40,40,40,3,68,40,16,3,2,82,12,5,56,68,84,84,88,4,124,18,18,124,4,126,74,74,52
	.DB	4,60,66,66,36,4,126,66,66,60,3,126,74,74,3,126,10,10,4,60,66,82,52,4,126,8,8,126
	.DB	3,66,126,66,3,66,66,62,4,126,8,20,98,3,126,64,64,5,126,4,8,4,126,5,126,4,24,32
	.DB	126,4,60,66,66,60,4,126,18,18,12,4,60,66,66,188,4,126,18,18,108,4,68,74,74,48,3,2
	.DB	126,2,4,62,64,64,62,5,6,24,96,24,6,5,62,64,62,64,62,5,66,36,24,36,66,4,158,160
	.DB	160,126,4,98,82,74,70,2,126,66,3,6,24,96,2,66,126,3,32,16,32,4,128,128,128,128
	.DB	2,4,8,4,32,84,84,120,4,126,68,68,56,4,56,68,68,40,4,56,68,68,126,4,56,84,84,88
	.DB	2,124,10,4,152,164,164,124,4,126,4,4,120,1,122,2,64,58,4,126,16,40,68,1,126,5
	.DB	124,4,120,4,120,4,124,4,4,120,4,56,68,68,56,4,252,36,36,24,4,24,36,36,252,2,124,4
	.DB	4,72,84,84,32,3,4,62,68,4,60,64,64,60,5,12,48,64,48,12,5,60,64,60,64,60,5,68,40,16
	.DB	40,68,4,156,160,160,124,3,100,84,76,3,8,54,65,1,255,3,65,54,8,4,32,16,32,16,1

;********************************************************************************

OLEDFONT1DATA_H:
	mov	SysWORDTempA,SYSSTRINGA
	mov	SysWORDTempA_H,SYSSTRINGA_H
	ldi	SysWORDTempB,1
	ldi	SysWORDTempB_H,0
	rcall	SysCompLessThan16
	sbrs	SysByteTempX,0
	ret
	ldi	SysReadA, low(TableOLEDFONT1DATA_H<<1)
	ldi	SysReadA_H, high(TableOLEDFONT1DATA_H<<1)
	add	SysReadA, SysStringA
	adc	SysReadA_H, SysStringA_H
	lpm
	ret
TableOLEDFONT1DATA_H:
	.DB	1

;********************************************************************************

OLEDFONT1INDEX:
	cpi	SysStringA, 97
	brlo	PC + 3
	clr	SysByteTempX
	ret
	ldi	SysReadA, low(TableOLEDFONT1INDEX<<1)
	ldi	SysReadA_H, high(TableOLEDFONT1INDEX<<1)
	add	SysReadA, SysStringA
	brcc	PC + 2
	inc	SysReadA_H
	lpm
	ret
TableOLEDFONT1INDEX:
	.DB	96,1,3,5,9,15,21,25,31,33,36,39,45,49,51,55,57,61,66,70,75,79,84,88,93,97,102,107
	.DB	109,112,116,120,124,128,134,139,144,149,154,158,162,167,172,176,180,185,189,195
	.DB	201,206,211,216,221,226,230,235,241,247,253,2,7,10,14,17,21,26,29,34,39,44,49,54
	.DB	57,62,67,69,72,77,79,85,90,95,100,105,108,113,117,122,128,134,140,145,149,153
	.DB	155,159,164

;********************************************************************************

OLEDFONT1INDEX_H:
	cpi	SysStringA, 97
	brlo	PC + 3
	clr	SysByteTempX
	ret
	ldi	SysReadA, low(TableOLEDFONT1INDEX_H<<1)
	ldi	SysReadA_H, high(TableOLEDFONT1INDEX_H<<1)
	add	SysReadA, SysStringA
	brcc	PC + 2
	inc	SysReadA_H
	lpm
	ret
TableOLEDFONT1INDEX_H:
	.DB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	.DB	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	.DB	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

;********************************************************************************

OLEDFONT2:
	mov	SysWORDTempA,SYSSTRINGA
	mov	SysWORDTempA_H,SYSSTRINGA_H
	ldi	SysWORDTempB,145
	ldi	SysWORDTempB_H,7
	rcall	SysCompLessThan16
	sbrs	SysByteTempX,0
	ret
	ldi	SysReadA, low(TableOLEDFONT2<<1)
	ldi	SysReadA_H, high(TableOLEDFONT2<<1)
	add	SysReadA, SysStringA
	adc	SysReadA_H, SysStringA_H
	lpm
	ret
TableOLEDFONT2:
	.DB	147,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,254,27,0,0,0,0,0,0,0
	.DB	0,0,0,0,0,0,0,30,0,0,0,0,0,0,0,30,0,0,0,0,0,0,0,0,1,32,25,160,7,120,1,38,25,160
	.DB	7,120,1,38,1,32,1,0,0,0,0,0,0,28,24,38,16,66,16,255,63,130,17,2,15,0,0,0,0,28
	.DB	16,34,8,34,4,34,3,156,0,64,14,48,17,8,17,4,17,2,14,0,7,128,8,92,16,98,16,162,17,50
	.DB	19,28,28,0,24,0,22,128,1,0,0,0,0,0,0,0,0,30,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,224
	.DB	7,24,24,12,48,4,32,2,64,2,64,0,0,0,0,2,64,2,64,4,32,12,48,24,24,224,7,0,0,0,0,0
	.DB	0,0,0,8,0,24,0,240,0,78,0,240,0,24,0,8,0,0,0,0,0,0,2,0,2,0,2,0,2,224,31,0,2,0,2,0
	.DB	2,0,2,0,0,0,0,0,0,0,0,0,152,0,120,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,1,0,1,0
	.DB	1,0,1,0,0,0,0,0,0,0,0,0,0,0,24,0,24,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,48,0,12,0,3,192
	.DB	0,48,0,12,0,2,0,0,0,0,0,240,3,12,12,2,16,2,16,2,16,12,12,240,3,0,0,0,0,0,0,4,16,4
	.DB	16,4,16,254,31,0,16,0,16,0,16,0,0,0,0,0,0,6,24,2,20,2,18,2,17,194,16,60,16,0,0,0
	.DB	0,0,0,0,0,0,0,2,16,66,16,66,16,66,16,188,15,0,0,0,0,0,0,0,3,192,2,32,2,24,2,4,2,254
	.DB	31,0,2,0,2,0,0,0,0,0,0,0,0,62,16,34,16,34,16,66,8,130,7,0,0,0,0,0,0,0,0,240,7,76
	.DB	8,34,16,34,16,34,16,66,8,128,7,0,0,0,0,0,0,2,0,2,24,2,7,194,0,50,0,10,0,6,0,0,0,0
	.DB	0,0,0,28,15,162,16,66,16,66,16,162,16,162,9,28,6,0,0,0,0,0,0,120,0,132,16,2,17,2
	.DB	17,2,17,132,12,248,3,0,0,0,0,0,0,0,0,0,0,96,24,96,24,0,0,0,0,0,0,0,0,0,0,0,0,0
	.DB	0,0,0,96,152,96,120,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,3,128,4,128,4,64,8,64,8,32
	.DB	16,0,0,0,0,128,4,128,4,128,4,128,4,128,4,128,4,128,4,128,4,0,0,0,0,32,16,64,8,64
	.DB	8,128,4,128,4,0,3,0,3,0,0,0,0,0,0,14,0,2,0,2,27,130,0,66,0,38,0,28,0,0,0,0,0,240
	.DB	3,24,12,4,24,226,19,18,20,10,22,138,27,252,7,0,4,0,4,0,16,0,14,128,3,112,2,24,2,48
	.DB	2,192,2,0,3,0,12,0,16,0,0,248,31,136,16,136,16,136,16,136,16,72,17,48,14,0,0,0
	.DB	0,192,3,48,12,16,8,8,16,8,16,8,16,8,16,24,16,0,0,0,0,0,0,248,31,8,16,8,16,8,16,8
	.DB	16,16,8,224,7,0,0,0,0,0,0,248,31,8,17,8,17,8,17,8,17,8,17,8,16,0,0,0,0,0,0,248
	.DB	31,8,1,8,1,8,1,8,1,8,1,8,0,0,0,0,0,0,0,192,3,48,12,16,8,8,16,8,16,8,17,8,17,24
	.DB	31,0,0,0,0,248,31,0,1,0,1,0,1,0,1,0,1,248,31,0,0,0,0,0,0,8,16,8,16,8,16,248,31,8
	.DB	16,8,16,8,16,0,0,0,0,0,0,0,0,0,16,8,16,8,16,8,16,248,15,0,0,0,0,0,0,0,0,248,31,128
	.DB	0,128,1,64,2,32,4,16,4,8,8,0,16,0,0,0,0,248,31,0,16,0,16,0,16,0,16,0,16,0,16,0
	.DB	0,0,0,248,31,56,0,224,1,0,7,0,6,192,1,56,0,248,31,0,0,0,0,0,0,248,31,16,0,96,0,128
	.DB	1,0,6,0,8,248,31,0,0,0,0,0,0,224,7,16,8,8,16,8,16,8,16,8,16,16,8,224,7,0,0,0,0,248
	.DB	31,8,1,8,1,8,1,8,1,136,0,112,0,0,0,0,0,0,0,224,7,16,8,8,16,8,16,8,16,8,48,16,72,224
	.DB	71,0,0,0,0,248,31,8,1,8,1,8,3,136,4,112,8,0,16,0,0,0,0,0,0,112,24,72,16,136,16,136
	.DB	16,8,17,8,9,24,14,0,0,0,0,8,0,8,0,8,0,8,0,248,31,8,0,8,0,8,0,8,0,0,0,0,0,248,7,0
	.DB	24,0,16,0,16,0,16,0,8,248,7,0,0,0,0,8,0,48,0,192,1,0,6,0,24,0,24,0,7,192,0,48,0,8
	.DB	0,24,0,224,3,0,28,0,15,224,0,192,1,0,14,0,28,224,3,24,0,8,16,16,8,32,4,64,2,128
	.DB	1,128,1,64,2,32,4,16,8,8,16,8,0,16,0,96,0,128,0,0,31,128,0,64,0,32,0,16,0,8,0,0
	.DB	0,8,24,8,20,8,18,8,17,136,16,72,16,40,16,24,16,0,0,0,0,0,0,0,0,254,127,2,64,2
	.DB	64,2,64,2,64,0,0,0,0,0,0,2,0,12,0,48,0,192,0,0,3,0,12,0,48,0,64,0,0,0,0,2,64,2
	.DB	64,2,64,2,64,254,127,0,0,0,0,0,0,0,0,0,0,0,4,0,3,224,0,56,0,14,0,112,0,128,3,0
	.DB	4,0,0,0,32,0,32,0,32,0,32,0,32,0,32,0,32,0,32,0,32,0,32,0,0,0,0,0,0,0,0,1,0,2,0,0
	.DB	0,0,0,0,0,0,0,0,0,0,12,32,18,32,17,32,17,32,9,192,31,0,16,0,0,0,0,0,0,254,31,64
	.DB	8,32,16,32,16,32,16,96,8,128,7,0,0,0,0,0,0,128,7,64,8,32,16,32,16,32,16,32,16,32
	.DB	16,0,0,0,0,0,0,128,7,64,24,32,16,32,16,32,16,64,8,254,31,0,0,0,0,0,0,128,7,64,9,32
	.DB	17,32,17,32,17,32,17,192,17,0,0,0,0,0,0,32,0,32,0,252,31,36,0,34,0,34,0,34,0,34
	.DB	0,0,0,0,0,128,7,64,152,32,144,32,144,32,144,64,72,224,63,0,0,0,0,0,0,254,31,128
	.DB	0,64,0,32,0,32,0,32,0,192,31,0,0,0,0,0,0,32,0,32,0,38,0,230,31,0,0,0,0,0,0,0,0,0
	.DB	0,0,0,0,128,32,128,32,128,38,128,230,127,0,0,0,0,0,0,0,0,0,0,254,31,0,1,0,3,128
	.DB	4,64,4,64,8,32,16,0,0,0,0,0,0,0,0,2,0,2,0,2,0,254,31,0,0,0,0,0,0,0,0,224,31,64
	.DB	0,32,0,32,0,192,31,64,0,32,0,32,0,192,31,0,0,0,0,224,31,192,0,64,0,32,0,32,0,32
	.DB	0,192,31,0,0,0,0,0,0,128,7,64,8,32,16,32,16,32,16,64,8,128,7,0,0,0,0,0,0,224
	.DB	255,64,8,32,16,32,16,32,16,96,8,128,7,0,0,0,0,0,0,128,7,64,24,32,16,32,16,32,16,64
	.DB	8,224,255,0,0,0,0,0,0,0,0,224,31,128,0,64,0,32,0,32,0,224,0,0,0,0,0,0,0,192,24,32
	.DB	17,32,17,32,18,32,18,32,12,0,0,0,0,0,0,0,0,32,0,32,0,248,15,32,16,32,16,32,16,32
	.DB	16,0,0,0,0,0,0,224,15,0,16,0,16,0,16,0,8,224,31,0,0,0,0,0,0,32,0,192,1,0,6,0,24,0
	.DB	16,0,12,0,3,192,0,32,0,0,0,96,0,128,7,0,24,0,14,192,1,128,1,0,14,0,24,128,7,96
	.DB	0,0,0,32,16,64,8,128,4,0,3,0,3,128,4,64,8,32,16,0,0,32,128,192,128,0,131,0,70,0
	.DB	56,0,24,0,6,0,1,192,0,32,0,0,0,32,16,32,24,32,20,32,18,32,17,160,16,96,16,32,16,0
	.DB	0,0,0,0,0,0,1,0,1,252,62,2,64,2,64,2,64,0,0,0,0,0,0,0,0,0,0,0,0,254,127,0,0,0,0,0
	.DB	0,0,0,0,0,0,0,0,0,2,64,2,64,2,64,252,62,0,1,0,1,0,0,0,0,0,3,128,0,128,0,128,0,0
	.DB	1,0,1,0,2,0,2,0,2,128,1,0,0,128,31,192,16,32,16,16,16,32,16,192,16,128,31,0,0,0
	.DB	0,192,3,48,12,16,8,8,16,8,16,8,144,8,176,24,208

;********************************************************************************

OLEDFONT2_H:
	mov	SysWORDTempA,SYSSTRINGA
	mov	SysWORDTempA_H,SYSSTRINGA_H
	ldi	SysWORDTempB,1
	ldi	SysWORDTempB_H,0
	rcall	SysCompLessThan16
	sbrs	SysByteTempX,0
	ret
	ldi	SysReadA, low(TableOLEDFONT2_H<<1)
	ldi	SysReadA_H, high(TableOLEDFONT2_H<<1)
	add	SysReadA, SysStringA
	adc	SysReadA_H, SysStringA_H
	lpm
	ret
TableOLEDFONT2_H:
	.DB	7

;********************************************************************************

;Source: epd_epd2in13d.h (355)
PIXEL_TO_DISPLAY_EPD2IN13D:
;Dim EPD_Ind_raw, EPD_Ind_col as Word
;if _GLCDPage = 0 then
	lds	SysCalcTempA,_GLCDPAGE
	tst	SysCalcTempA
	breq	PC + 2
	rjmp	ENDIF10
;Clear down 'OLD' data - to prevent flashing
;SendCommand_EPD2in13D(Data_Transmission_1)
	ldi	SysValueCopy,16
	sts	EPD2IN13D_COMMAND,SysValueCopy
	rcall	SENDCOMMAND_EPD2IN13D
;SET EPD_CS OFF
	cbi	PORTB,2
;SET EPD_DC ON
	sbi	PORTB,1
;for EPD_Ind_raw=1 to GLCD_Height
	ldi	SysValueCopy,0
	sts	EPD_IND_RAW,SysValueCopy
	sts	EPD_IND_RAW_H,SysValueCopy
SysForLoop3:
	lds	SysTemp3,EPD_IND_RAW
	inc	SysTemp3
	sts	EPD_IND_RAW,SysTemp3
	lds	SysTemp3,EPD_IND_RAW_H
	brne	PC + 2
	inc	SysTemp3
	sts	EPD_IND_RAW_H,SysTemp3
;for EPD_Ind_col=1 to GLCD_Width
	ldi	SysValueCopy,0
	sts	EPD_IND_COL,SysValueCopy
	sts	EPD_IND_COL_H,SysValueCopy
SysForLoop4:
	lds	SysTemp3,EPD_IND_COL
	inc	SysTemp3
	sts	EPD_IND_COL,SysTemp3
	lds	SysTemp3,EPD_IND_COL_H
	brne	PC + 2
	inc	SysTemp3
	sts	EPD_IND_COL_H,SysTemp3
;Replaced with macro for speed              SendData_EPD2in13D(GLCDBackGround)
;EPD2in13D_Data = GLCDBackGround
	lds	SysValueCopy,GLCDBACKGROUND
	sts	EPD2IN13D_DATA,SysValueCopy
;SendData_EPD2in13D_Macro
;Macro Source: epd_epd2in13d.h (485)
;FastHWSPITransfer EPD2in13D_Data
	sts	SPITXDATA,SysValueCopy
	call	FASTHWSPITRANSFER
;next
	lds	SysWORDTempA,EPD_IND_COL
	lds	SysWORDTempA_H,EPD_IND_COL_H
	ldi	SysWORDTempB,104
	ldi	SysWORDTempB_H,0
	rcall	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop4
SysForLoopEnd4:
;next
	lds	SysWORDTempA,EPD_IND_RAW
	lds	SysWORDTempA_H,EPD_IND_RAW_H
	ldi	SysWORDTempB,212
	ldi	SysWORDTempB_H,0
	rcall	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop3
SysForLoopEnd3:
;SET EPD_CS ON
	sbi	PORTB,2
;SendCommand_EPD2in13D(DATA_TRANSMISSION_2)
	ldi	SysValueCopy,19
	sts	EPD2IN13D_COMMAND,SysValueCopy
	rcall	SENDCOMMAND_EPD2IN13D
;end if
ENDIF10:
;dim EPD2in13D_Data as byte
;We need to set the signals as we are optimising the code by using the macro
;SET EPD_CS OFF
	cbi	PORTB,2
;SET EPD_DC ON
	sbi	PORTB,1
;for EPD_Ind_raw=1 to BUFFWIDTH
	ldi	SysValueCopy,0
	sts	EPD_IND_RAW,SysValueCopy
	sts	EPD_IND_RAW_H,SysValueCopy
SysForLoop5:
	lds	SysTemp3,EPD_IND_RAW
	inc	SysTemp3
	sts	EPD_IND_RAW,SysTemp3
	lds	SysTemp3,EPD_IND_RAW_H
	brne	PC + 2
	inc	SysTemp3
	sts	EPD_IND_RAW_H,SysTemp3
;replaced with macro for speed
;SendData_EPD2in13D(EPD_Buffer(EPD_Ind_raw))
;EPD2in13D_Data = EPD_Buffer(EPD_Ind_raw)
	lds	SysTemp3,EPD_IND_RAW
	ldi	SysTemp4,low(EPD_BUFFER)
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	lds	SysTemp3,EPD_IND_RAW_H
	ldi	SysTemp4,high(EPD_BUFFER)
	adc	SysTemp3,SysTemp4
	mov	SysStringA_H,SysTemp3
	ld	SysValueCopy,X
	sts	EPD2IN13D_DATA,SysValueCopy
;The following line is intentionally commented out, but, it shows the orientation of the pixels to the array. Uncomment to force a two (when the value is 3!) byte write to the Display
;You can then examine the display to see the orientation of the pixels.
;This will write the bytes at the top of each page - so, do not be surprised!
;if EPD_Ind_raw < 3 then EPD2in13D_Data = GLCDForeground
;This macro assumes the use of the variable EPD2in13D_Data
;SendData_EPD2in13D_Macro
;Macro Source: epd_epd2in13d.h (485)
;FastHWSPITransfer EPD2in13D_Data
	sts	SPITXDATA,SysValueCopy
	call	FASTHWSPITRANSFER
;Now clear the buffer
;EPD_Buffer(EPD_Ind_raw) = GLCDBackground
	lds	SysTemp3,EPD_IND_RAW
	ldi	SysTemp4,low(EPD_BUFFER)
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	lds	SysTemp3,EPD_IND_RAW_H
	ldi	SysTemp4,high(EPD_BUFFER)
	adc	SysTemp3,SysTemp4
	mov	SysStringA_H,SysTemp3
	lds	SysValueCopy,GLCDBACKGROUND
	st	X,SysValueCopy
;next
	lds	SysWORDTempA,EPD_IND_RAW
	lds	SysWORDTempA_H,EPD_IND_RAW_H
	ldi	SysWORDTempB,98
	ldi	SysWORDTempB_H,5
	rcall	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop5
SysForLoopEnd5:
;SET EPD_CS ON
	sbi	PORTB,2
	ret

;********************************************************************************

;Source: epd_epd2in13d.h (687)
PSET_EPD2IN13D:
;Dim EPD_Ind, EPD_N_Col, EPD_N_raw, EPD_Ind_Trans as word
;Dim remainder as byte
;Dim DataVar as byte
;Dim value as bit
;Dim GLCD_Time_Buff as word
;Dim GLCDDataTemp as word
;Select Case EPD2in13DAddressType
;case Landscape
SysSelect1Case1:
	lds	SysCalcTempA,EPD2IN13DADDRESSTYPE
	cpi	SysCalcTempA,1
	brne	SysSelect1Case2
;GLCDDataTemp = GLCDX
	lds	SysValueCopy,GLCDX
	sts	GLCDDATATEMP,SysValueCopy
	lds	SysValueCopy,GLCDX_H
	sts	GLCDDATATEMP_H,SysValueCopy
;GLCDX = GLCDY
	lds	SysValueCopy,GLCDY
	sts	GLCDX,SysValueCopy
	lds	SysValueCopy,GLCDY_H
	sts	GLCDX_H,SysValueCopy
;GLCDY = GLCD_HEIGHT - GLCDDataTemp - 1
	ldi	SysTemp4,212
	lds	SysTemp3,GLCDDATATEMP
	sub	SysTemp4,SysTemp3
	mov	SysTemp2,SysTemp4
	ldi	SysTemp4,0
	lds	SysTemp3,GLCDDATATEMP_H
	sbc	SysTemp4,SysTemp3
	mov	SysTemp2_H,SysTemp4
	ldi	SysTemp4,1
	sub	SysTemp2,SysTemp4
	sts	GLCDY,SysTemp2
	ldi	SysTemp4,0
	sbc	SysTemp2_H,SysTemp4
	sts	GLCDY_H,SysTemp2_H
;case Landscape_Rev
	rjmp	SysSelectEnd1
SysSelect1Case2:
	lds	SysCalcTempA,EPD2IN13DADDRESSTYPE
	cpi	SysCalcTempA,3
	brne	SysSelect1Case3
;GLCDDataTemp = GLCDX
	lds	SysValueCopy,GLCDX
	sts	GLCDDATATEMP,SysValueCopy
	lds	SysValueCopy,GLCDX_H
	sts	GLCDDATATEMP_H,SysValueCopy
;GLCDX = GLCD_WIDTH  - GLCDY - 1
	ldi	SysTemp4,104
	lds	SysTemp3,GLCDY
	sub	SysTemp4,SysTemp3
	mov	SysTemp2,SysTemp4
	ldi	SysTemp4,0
	lds	SysTemp3,GLCDY_H
	sbc	SysTemp4,SysTemp3
	mov	SysTemp2_H,SysTemp4
	ldi	SysTemp4,1
	sub	SysTemp2,SysTemp4
	sts	GLCDX,SysTemp2
	ldi	SysTemp4,0
	sbc	SysTemp2_H,SysTemp4
	sts	GLCDX_H,SysTemp2_H
;GLCDY = GLCDDataTemp
	lds	SysValueCopy,GLCDDATATEMP
	sts	GLCDY,SysValueCopy
	lds	SysValueCopy,GLCDDATATEMP_H
	sts	GLCDY_H,SysValueCopy
;case Portrait
	rjmp	SysSelectEnd1
SysSelect1Case3:
	lds	SysCalcTempA,EPD2IN13DADDRESSTYPE
	cpi	SysCalcTempA,4
	brne	SysSelect1Case4
;Default do nothing
;case Portrait_Rev
	rjmp	SysSelectEnd1
SysSelect1Case4:
	lds	SysCalcTempA,EPD2IN13DADDRESSTYPE
	cpi	SysCalcTempA,2
	brne	SysSelectEnd1
;GLCDY = GLCD_HEIGHT - GLCDY - 1
	ldi	SysTemp4,212
	lds	SysTemp3,GLCDY
	sub	SysTemp4,SysTemp3
	mov	SysTemp2,SysTemp4
	ldi	SysTemp4,0
	lds	SysTemp3,GLCDY_H
	sbc	SysTemp4,SysTemp3
	mov	SysTemp2_H,SysTemp4
	ldi	SysTemp4,1
	sub	SysTemp2,SysTemp4
	sts	GLCDY,SysTemp2
	ldi	SysTemp4,0
	sbc	SysTemp2_H,SysTemp4
	sts	GLCDY_H,SysTemp2_H
;GLCDX = GLCD_WIDTH - GLCDX - 1
	ldi	SysTemp4,104
	lds	SysTemp3,GLCDX
	sub	SysTemp4,SysTemp3
	mov	SysTemp2,SysTemp4
	ldi	SysTemp4,0
	lds	SysTemp3,GLCDX_H
	sbc	SysTemp4,SysTemp3
	mov	SysTemp2_H,SysTemp4
	ldi	SysTemp4,1
	sub	SysTemp2,SysTemp4
	sts	GLCDX,SysTemp2
	ldi	SysTemp4,0
	sbc	SysTemp2_H,SysTemp4
	sts	GLCDX_H,SysTemp2_H
;end select
SysSelectEnd1:
;EPD_N_Col=(GLCDX+1)/8                   'number of the column of the byte to be set
	lds	SysTemp3,GLCDX
	ldi	SysTemp4,1
	add	SysTemp3,SysTemp4
	mov	SysTemp2,SysTemp3
	lds	SysTemp3,GLCDX_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	mov	SysTemp2_H,SysTemp3
	mov	SysWORDTempA,SysTemp2
	mov	SysWORDTempA_H,SysTemp2_H
	ldi	SysWORDTempB,8
	ldi	SysWORDTempB_H,0
	rcall	SysDivSub16
	sts	EPD_N_COL,SysWORDTempA
	sts	EPD_N_COL_H,SysWORDTempA_H
;remainder=(GLCDX+1)%8
	lds	SysTemp3,GLCDX
	ldi	SysTemp4,1
	add	SysTemp3,SysTemp4
	mov	SysTemp2,SysTemp3
	lds	SysTemp3,GLCDX_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	mov	SysTemp2_H,SysTemp3
	mov	SysWORDTempA,SysTemp2
	mov	SysWORDTempA_H,SysTemp2_H
	ldi	SysWORDTempB,8
	ldi	SysWORDTempB_H,0
	rcall	SysDivSub16
	sts	REMAINDER,SysWORDTempX
;EPD_N_raw=(GLCDY)*GLCD_Width8       'number of the column of the byte to be set
	lds	SysWORDTempA,GLCDY
	lds	SysWORDTempA_H,GLCDY_H
	ldi	SysWORDTempB,13
	ldi	SysWORDTempB_H,0
	rcall	SysMultSub16
	sts	EPD_N_RAW,SysWORDTempX
	sts	EPD_N_RAW_H,SysWORDTempX_H
;if remainder=0 then
	lds	SysCalcTempA,REMAINDER
	tst	SysCalcTempA
	brne	ELSE15_1
;EPD_Ind=EPD_N_raw+EPD_N_Col
	lds	SysTemp3,EPD_N_RAW
	lds	SysTemp1,EPD_N_COL
	add	SysTemp3,SysTemp1
	sts	EPD_IND,SysTemp3
	lds	SysTemp3,EPD_N_RAW_H
	lds	SysTemp1,EPD_N_COL_H
	adc	SysTemp3,SysTemp1
	sts	EPD_IND_H,SysTemp3
;else
	rjmp	ENDIF15
ELSE15_1:
;EPD_Ind=EPD_N_raw+EPD_N_Col+1       'Number of the byte to be set (starting from 1)
	lds	SysTemp3,EPD_N_RAW
	lds	SysTemp1,EPD_N_COL
	add	SysTemp3,SysTemp1
	mov	SysTemp2,SysTemp3
	lds	SysTemp3,EPD_N_RAW_H
	lds	SysTemp1,EPD_N_COL_H
	adc	SysTemp3,SysTemp1
	mov	SysTemp2_H,SysTemp3
	ldi	SysTemp4,1
	add	SysTemp2,SysTemp4
	sts	EPD_IND,SysTemp2
	ldi	SysTemp4,0
	adc	SysTemp2_H,SysTemp4
	sts	EPD_IND_H,SysTemp2_H
;end if
ENDIF15:
;GLCD_Time_Buff=_GLCDPage*BUFFWIDTH
	lds	SysWORDTempA,_GLCDPAGE
	ldi	SysWORDTempA_H,0
	ldi	SysWORDTempB,98
	ldi	SysWORDTempB_H,5
	rcall	SysMultSub16
	sts	GLCD_TIME_BUFF,SysWORDTempX
	sts	GLCD_TIME_BUFF_H,SysWORDTempX_H
;EPD_Ind_Trans=EPD_Ind
	lds	SysValueCopy,EPD_IND
	sts	EPD_IND_TRANS,SysValueCopy
	lds	SysValueCopy,EPD_IND_H
	sts	EPD_IND_TRANS_H,SysValueCopy
;EPD_Ind_Trans=EPD_Ind_Trans-GLCD_Time_Buff
	lds	SysTemp3,EPD_IND_TRANS
	lds	SysTemp1,GLCD_TIME_BUFF
	sub	SysTemp3,SysTemp1
	sts	EPD_IND_TRANS,SysTemp3
	lds	SysTemp3,EPD_IND_TRANS_H
	lds	SysTemp1,GLCD_TIME_BUFF_H
	sbc	SysTemp3,SysTemp1
	sts	EPD_IND_TRANS_H,SysTemp3
;if EPD_Ind_Trans>BUFFWIDTH then       'NOTE:it should be a control also for a
	lds	SysWORDTempB,EPD_IND_TRANS
	lds	SysWORDTempB_H,EPD_IND_TRANS_H
	ldi	SysWORDTempA,98
	ldi	SysWORDTempA_H,5
	rcall	SysCompLessThan16
	sbrc	SysByteTempX,0
;EXIT SUB                            'lower bound of ind (ind>GLCD_Time_Buff)
	ret
;end if                                'However when the lower bound is violated,
;DataVar=EPD_Buffer(EPD_Ind_Trans)     'Ind_Trans should be negative and, due to
	lds	SysTemp3,EPD_IND_TRANS
	ldi	SysTemp4,low(EPD_BUFFER)
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	lds	SysTemp3,EPD_IND_TRANS_H
	ldi	SysTemp4,high(EPD_BUFFER)
	adc	SysTemp3,SysTemp4
	mov	SysStringA_H,SysTemp3
	ld	SysValueCopy,X
	sts	DATAVAR,SysValueCopy
;Select Case remainder                 'non signed arithmetic, it will be very
;case 0                                'large, thus Exits sub is executed.
SysSelect2Case1:
	lds	SysCalcTempA,REMAINDER
	tst	SysCalcTempA
	brne	SysSelect2Case2
;DataVar.0=GLCDColour.0
	lds	SysValueCopy,DATAVAR
	cbr	SysValueCopy,1<<0
	lds	SysBitTest,GLCDCOLOUR
	sbrc	SysBitTest,0
	sbr	SysValueCopy,1<<0
	sts	DATAVAR,SysValueCopy
;case 1
	rjmp	SysSelectEnd2
SysSelect2Case2:
	lds	SysCalcTempA,REMAINDER
	cpi	SysCalcTempA,1
	brne	SysSelect2Case3
;DataVar.7=GLCDColour.0
	lds	SysValueCopy,DATAVAR
	cbr	SysValueCopy,1<<7
	lds	SysBitTest,GLCDCOLOUR
	sbrc	SysBitTest,0
	sbr	SysValueCopy,1<<7
	sts	DATAVAR,SysValueCopy
;case 2
	rjmp	SysSelectEnd2
SysSelect2Case3:
	lds	SysCalcTempA,REMAINDER
	cpi	SysCalcTempA,2
	brne	SysSelect2Case4
;DataVar.6=GLCDColour.0
	lds	SysValueCopy,DATAVAR
	cbr	SysValueCopy,1<<6
	lds	SysBitTest,GLCDCOLOUR
	sbrc	SysBitTest,0
	sbr	SysValueCopy,1<<6
	sts	DATAVAR,SysValueCopy
;case 3
	rjmp	SysSelectEnd2
SysSelect2Case4:
	lds	SysCalcTempA,REMAINDER
	cpi	SysCalcTempA,3
	brne	SysSelect2Case5
;DataVar.5=GLCDColour.0
	lds	SysValueCopy,DATAVAR
	cbr	SysValueCopy,1<<5
	lds	SysBitTest,GLCDCOLOUR
	sbrc	SysBitTest,0
	sbr	SysValueCopy,1<<5
	sts	DATAVAR,SysValueCopy
;case 4
	rjmp	SysSelectEnd2
SysSelect2Case5:
	lds	SysCalcTempA,REMAINDER
	cpi	SysCalcTempA,4
	brne	SysSelect2Case6
;DataVar.4=GLCDColour.0
	lds	SysValueCopy,DATAVAR
	cbr	SysValueCopy,1<<4
	lds	SysBitTest,GLCDCOLOUR
	sbrc	SysBitTest,0
	sbr	SysValueCopy,1<<4
	sts	DATAVAR,SysValueCopy
;case 5
	rjmp	SysSelectEnd2
SysSelect2Case6:
	lds	SysCalcTempA,REMAINDER
	cpi	SysCalcTempA,5
	brne	SysSelect2Case7
;DataVar.3=GLCDColour.0
	lds	SysValueCopy,DATAVAR
	cbr	SysValueCopy,1<<3
	lds	SysBitTest,GLCDCOLOUR
	sbrc	SysBitTest,0
	sbr	SysValueCopy,1<<3
	sts	DATAVAR,SysValueCopy
;case 6
	rjmp	SysSelectEnd2
SysSelect2Case7:
	lds	SysCalcTempA,REMAINDER
	cpi	SysCalcTempA,6
	brne	SysSelect2Case8
;DataVar.2=GLCDColour.0
	lds	SysValueCopy,DATAVAR
	cbr	SysValueCopy,1<<2
	lds	SysBitTest,GLCDCOLOUR
	sbrc	SysBitTest,0
	sbr	SysValueCopy,1<<2
	sts	DATAVAR,SysValueCopy
;case 7
	rjmp	SysSelectEnd2
SysSelect2Case8:
	lds	SysCalcTempA,REMAINDER
	cpi	SysCalcTempA,7
	brne	SysSelectEnd2
;DataVar.1=GLCDColour.0
	lds	SysValueCopy,DATAVAR
	cbr	SysValueCopy,1<<1
	lds	SysBitTest,GLCDCOLOUR
	sbrc	SysBitTest,0
	sbr	SysValueCopy,1<<1
	sts	DATAVAR,SysValueCopy
;End Select
SysSelectEnd2:
;EPD_Buffer(EPD_Ind_Trans)=DataVar
	lds	SysTemp3,EPD_IND_TRANS
	ldi	SysTemp4,low(EPD_BUFFER)
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	lds	SysTemp3,EPD_IND_TRANS_H
	ldi	SysTemp4,high(EPD_BUFFER)
	adc	SysTemp3,SysTemp4
	mov	SysStringA_H,SysTemp3
	lds	SysValueCopy,DATAVAR
	st	X,SysValueCopy
	ret

;********************************************************************************

;Source: epd_epd2in13d.h (417)
REFRESH_EPD2IN13D:
;Not required as this process has already happenend from INIT
;LoadLUTS_EPD2in13D
;SendCommand_EPD2in13D(DISPLAY_REFRESH)
	ldi	SysValueCopy,18
	sts	EPD2IN13D_COMMAND,SysValueCopy
	rjmp	SENDCOMMAND_EPD2IN13D

;********************************************************************************

;Source: epd_epd2in13d.h (874)
ROTATE_EPD2IN13D:
;Reset PrintLocY
;PrintLocY = 0
	ldi	SysValueCopy,0
	sts	PRINTLOCY,SysValueCopy
;select case EPD2in13DAddressType
;case PORTRAIT
SysSelect3Case1:
	lds	SysCalcTempA,EPD2IN13DADDRESSTYPE
	cpi	SysCalcTempA,4
	brne	SysSelect3Case2
;GLCDDeviceHeight = GLCD_HEIGHT - 1
	ldi	SysValueCopy,211
	sts	GLCDDEVICEHEIGHT,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDDEVICEHEIGHT_H,SysValueCopy
;GLCDDeviceWidth = GLCD_WIDTH - 1
	ldi	SysValueCopy,103
	sts	GLCDDEVICEWIDTH,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDDEVICEWIDTH_H,SysValueCopy
;case LANDSCAPE
	rjmp	SysSelectEnd3
SysSelect3Case2:
	lds	SysCalcTempA,EPD2IN13DADDRESSTYPE
	cpi	SysCalcTempA,1
	brne	SysSelect3Case3
;GLCDDeviceHeight = GLCD_WIDTH - 1
	ldi	SysValueCopy,103
	sts	GLCDDEVICEHEIGHT,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDDEVICEHEIGHT_H,SysValueCopy
;GLCDDeviceWidth  = GLCD_HEIGHT - 1
	ldi	SysValueCopy,211
	sts	GLCDDEVICEWIDTH,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDDEVICEWIDTH_H,SysValueCopy
;case PORTRAIT_REV
	rjmp	SysSelectEnd3
SysSelect3Case3:
	lds	SysCalcTempA,EPD2IN13DADDRESSTYPE
	cpi	SysCalcTempA,2
	brne	SysSelect3Case4
;GLCDDeviceHeight = GLCD_HEIGHT - 1
	ldi	SysValueCopy,211
	sts	GLCDDEVICEHEIGHT,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDDEVICEHEIGHT_H,SysValueCopy
;GLCDDeviceWidth  = GLCD_WIDTH - 1
	ldi	SysValueCopy,103
	sts	GLCDDEVICEWIDTH,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDDEVICEWIDTH_H,SysValueCopy
;case LANDSCAPE_REV
	rjmp	SysSelectEnd3
SysSelect3Case4:
	lds	SysCalcTempA,EPD2IN13DADDRESSTYPE
	cpi	SysCalcTempA,3
	brne	SysSelect3Case5
;GLCDDeviceHeight = GLCD_WIDTH - 1
	ldi	SysValueCopy,103
	sts	GLCDDEVICEHEIGHT,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDDEVICEHEIGHT_H,SysValueCopy
;GLCDDeviceWidth  = GLCD_HEIGHT - 1
	ldi	SysValueCopy,211
	sts	GLCDDEVICEWIDTH,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDDEVICEWIDTH_H,SysValueCopy
;case else
	rjmp	SysSelectEnd3
SysSelect3Case5:
;GLCDDeviceHeight = GLCD_HEIGHT - 1
	ldi	SysValueCopy,211
	sts	GLCDDEVICEHEIGHT,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDDEVICEHEIGHT_H,SysValueCopy
;GLCDDeviceWidth  = GLCD_WIDTH - 1
	ldi	SysValueCopy,103
	sts	GLCDDEVICEWIDTH,SysValueCopy
	ldi	SysValueCopy,0
	sts	GLCDDEVICEWIDTH_H,SysValueCopy
;end select
SysSelectEnd3:
	ret

;********************************************************************************

;Source: epd_epd2in13d.h (442)
SENDCOMMAND_EPD2IN13D:
;SET EPD_CS OFF
	cbi	PORTB,2
;SET EPD_DC OFF
	cbi	PORTB,1
;FastHWSPITransfer EPD2in13D_Command
	lds	SysValueCopy,EPD2IN13D_COMMAND
	sts	SPITXDATA,SysValueCopy
	call	FASTHWSPITRANSFER
;SET EPD_CS ON
	sbi	PORTB,2
;do
SysDoLoop_S4:
;loop while EPD_Busy=Off
	sbis	PIND,7
	rjmp	SysDoLoop_S4
SysDoLoop_E4:
;Exit sub
	ret
	ret

;********************************************************************************

;Source: epd_epd2in13d.h (475)
SENDDATA_EPD2IN13D:
;SET EPD_CS OFF
	cbi	PORTB,2
;SET EPD_DC ON
	sbi	PORTB,1
;SendData_EPD2in13D_Macro
;Macro Source: epd_epd2in13d.h (485)
;FastHWSPITransfer EPD2in13D_Data
	lds	SysValueCopy,EPD2IN13D_DATA
	sts	SPITXDATA,SysValueCopy
	call	FASTHWSPITRANSFER
;SET EPD_CS ON
	sbi	PORTB,2
	ret

;********************************************************************************

;Source: epd_epd2in13d.h (425)
SLEEP_EPD2IN13D:
;SendCommand_EPD2in13D(Vcom_and_data_interval_setting)
	ldi	SysValueCopy,80
	sts	EPD2IN13D_COMMAND,SysValueCopy
	rcall	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0xF7)
	ldi	SysValueCopy,247
	sts	EPD2IN13D_DATA,SysValueCopy
	rcall	SENDDATA_EPD2IN13D
;SendCommand_EPD2in13D(POWER_OFF)
	ldi	SysValueCopy,2
	sts	EPD2IN13D_COMMAND,SysValueCopy
	rcall	SENDCOMMAND_EPD2IN13D
;SendCommand_EPD2in13D(DEEP_SLEEP)
	ldi	SysValueCopy,7
	sts	EPD2IN13D_COMMAND,SysValueCopy
	rcall	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(DEEP_SLEEP_CHECK_CODE)
	ldi	SysValueCopy,165
	sts	EPD2IN13D_DATA,SysValueCopy
	rjmp	SENDDATA_EPD2IN13D

;********************************************************************************

;Overloaded signature: BYTE:BYTE:, Source: hwspi.h (354)
SPIMODE645:
;Turn off SPI
;(Prevents any weird glitches during setup)
;Set SPCR.SPE Off
	in	SysValueCopy,SPCR
	cbr	SysValueCopy,1<<SPE
	out	SPCR,SysValueCopy
;Set clock pulse settings
;Set SPCR.CPHA Off
	in	SysValueCopy,SPCR
	cbr	SysValueCopy,1<<CPHA
	out	SPCR,SysValueCopy
;If SPIClockMode.0 = On Then
	lds	SysBitTest,SPICLOCKMODE
	sbrs	SysBitTest,0
	rjmp	ENDIF46
;Set SPCR.CPHA On
	in	SysValueCopy,SPCR
	sbr	SysValueCopy,1<<CPHA
	out	SPCR,SysValueCopy
;End If
ENDIF46:
;Set SPCR.CPOL Off
	in	SysValueCopy,SPCR
	cbr	SysValueCopy,1<<CPOL
	out	SPCR,SysValueCopy
;If SPIClockMode.1 = On Then
	lds	SysBitTest,SPICLOCKMODE
	sbrs	SysBitTest,1
	rjmp	ENDIF47
;Set SPCR.CPOL On
	in	SysValueCopy,SPCR
	sbr	SysValueCopy,1<<CPOL
	out	SPCR,SysValueCopy
;End If
ENDIF47:
;Select mode and clock
;Set some mode bits off, can set on later
;Set SPCR.MSTR Off
	in	SysValueCopy,SPCR
	cbr	SysValueCopy,1<<MSTR
	out	SPCR,SysValueCopy
;Set SPSR.SPI2X Off
	in	SysValueCopy,SPSR
	cbr	SysValueCopy,1<<SPI2X
	out	SPSR,SysValueCopy
;Set SPCR.SPR0 Off
	in	SysValueCopy,SPCR
	cbr	SysValueCopy,1<<SPR0
	out	SPCR,SysValueCopy
;Set SPCR.SPR1 Off
	in	SysValueCopy,SPCR
	cbr	SysValueCopy,1<<SPR1
	out	SPCR,SysValueCopy
;Select Case SPICurrentMode
;Case MasterUltraFast
SysSelect6Case1:
	lds	SysCalcTempA,SPICURRENTMODE
	cpi	SysCalcTempA,14
	brne	SysSelect6Case2
;Set SPCR.MSTR On
	in	SysValueCopy,SPCR
	sbr	SysValueCopy,1<<MSTR
	out	SPCR,SysValueCopy
;Set SPSR.SPI2X On
	in	SysValueCopy,SPSR
	sbr	SysValueCopy,1<<SPI2X
	out	SPSR,SysValueCopy
;Case MasterFast
	rjmp	SysSelectEnd6
SysSelect6Case2:
	lds	SysCalcTempA,SPICURRENTMODE
	cpi	SysCalcTempA,13
	brne	SysSelect6Case3
;Set SPCR.MSTR On
	in	SysValueCopy,SPCR
	sbr	SysValueCopy,1<<MSTR
	out	SPCR,SysValueCopy
;Case Master
	rjmp	SysSelectEnd6
SysSelect6Case3:
	lds	SysCalcTempA,SPICURRENTMODE
	cpi	SysCalcTempA,12
	brne	SysSelect6Case4
;Set SPCR.MSTR On
	in	SysValueCopy,SPCR
	sbr	SysValueCopy,1<<MSTR
	out	SPCR,SysValueCopy
;Set SPCR.SPR0 On
	in	SysValueCopy,SPCR
	sbr	SysValueCopy,1<<SPR0
	out	SPCR,SysValueCopy
;Case MasterSlow
	rjmp	SysSelectEnd6
SysSelect6Case4:
	lds	SysCalcTempA,SPICURRENTMODE
	cpi	SysCalcTempA,11
	brne	SysSelectEnd6
;Set SPCR.MSTR On
	in	SysValueCopy,SPCR
	sbr	SysValueCopy,1<<MSTR
	out	SPCR,SysValueCopy
;Set SPCR.SPR1 On
	in	SysValueCopy,SPCR
	sbr	SysValueCopy,1<<SPR1
	out	SPCR,SysValueCopy
;Nothing needed for slave
;Case Slave
;Case SlaveSS
;End Select
SysSelectEnd6:
;Enable SPI
;Set SPCR.SPE On
	in	SysValueCopy,SPCR
	sbr	SysValueCopy,1<<SPE
	out	SPCR,SysValueCopy
	ret

;********************************************************************************

;Source: system.h (2613)
SYSCOMPEQUAL:
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;clr SysByteTempX
	clr	SYSBYTETEMPX
;cpse SysByteTempA, SysByteTempB
	cpse	SYSBYTETEMPA, SYSBYTETEMPB
;return
	ret
;com SysByteTempX
	com	SYSBYTETEMPX
	ret

;********************************************************************************

;Source: system.h (2639)
SYSCOMPEQUAL16:
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clr SysByteTempX
	clr	SYSBYTETEMPX
;cp SysWordTempA, SysWordTempB
	cp	SYSWORDTEMPA, SYSWORDTEMPB
;brne SCE16False
	brne	SCE16FALSE
;cp SysWordTempA_H, SysWordTempB_H
	cp	SYSWORDTEMPA_H, SYSWORDTEMPB_H
;brne SCE16False
	brne	SCE16FALSE
;com SysByteTempX
	com	SYSBYTETEMPX
SCE16FALSE:
	ret

;********************************************************************************

;Source: system.h (2810)
SYSCOMPLESSTHAN16:
;clr SysByteTempX
	clr	SYSBYTETEMPX
;Test High, exit false if more
;cp SysWordTempB_H,SysWordTempA_H
	cp	SYSWORDTEMPB_H,SYSWORDTEMPA_H
;brlo SCLT16False
	brlo	SCLT16FALSE
;Test high, exit true if less
;cp SysWordTempA_H,SysWordTempB_H
	cp	SYSWORDTEMPA_H,SYSWORDTEMPB_H
;brlo SCLT16True
	brlo	SCLT16TRUE
;Test Low, exit if more or equal
;cp SysWordTempA,SysWordTempB
	cp	SYSWORDTEMPA,SYSWORDTEMPB
;brlo SCLT16True
	brlo	SCLT16TRUE
;ret
	ret
SCLT16TRUE:
;com SysByteTempX
	com	SYSBYTETEMPX
SCLT16FALSE:
	ret

;********************************************************************************

;Source: system.h (2962)
SYSCOMPLESSTHANINT:
;Dim SysIntegerTempA, SysIntegerTempB, SysDivMultA as Integer
;Clear result
;SysByteTempX = 0
	ldi	SysValueCopy,0
	mov	SYSBYTETEMPX,SysValueCopy
;Compare sign bits
;-A
;If SysIntegerTempA.15 = On Then
	sbrs	SYSINTEGERTEMPA_H,7
	rjmp	ELSE22_1
;-A, +B, return true
;If SysIntegerTempB.15 = Off Then
	sbrc	SYSINTEGERTEMPB_H,7
	rjmp	ENDIF23
;Set SysByteTempX to 255
;SysByteTempX = Not SysByteTempX
	mov	SysTemp3,SYSBYTETEMPX
	com	SysTemp3
	mov	SYSBYTETEMPX,SysTemp3
;Exit Sub
	ret
;End If
ENDIF23:
;-A, -B, negate both and swap
;SysDivMultA = -SysIntegerTempA
	mov	SysTemp1,SYSINTEGERTEMPA
	mov	SysTemp1_H,SYSINTEGERTEMPA_H
	com	SysTemp1
	com	SysTemp1_H
	inc	SysTemp1
	brne	PC + 2
	inc	SysTemp1_H
	mov	SYSDIVMULTA,SysTemp1
	mov	SYSDIVMULTA_H,SysTemp1_H
;SysIntegerTempA = -SysIntegerTempB
	mov	SysTemp1,SYSINTEGERTEMPB
	mov	SysTemp1_H,SYSINTEGERTEMPB_H
	com	SysTemp1
	com	SysTemp1_H
	inc	SysTemp1
	brne	PC + 2
	inc	SysTemp1_H
	mov	SYSINTEGERTEMPA,SysTemp1
	mov	SYSINTEGERTEMPA_H,SysTemp1_H
;SysIntegerTempB = SysDivMultA
	mov	SYSINTEGERTEMPB,SYSDIVMULTA
	mov	SYSINTEGERTEMPB_H,SYSDIVMULTA_H
;+A
;Else
	rjmp	ENDIF22
ELSE22_1:
;+A, -B, return false
;If SysIntegerTempB.15 = On Then
	sbrc	SYSINTEGERTEMPB_H,7
;Exit Sub
	ret
;End If
;End If
ENDIF22:
;Test High, exit false if more
;cp SysIntegerTempB_H,SysIntegerTempA_H
	cp	SYSINTEGERTEMPB_H,SYSINTEGERTEMPA_H
;brlo SCLTIntFalse
	brlo	SCLTINTFALSE
;Test high, exit true if less
;cp SysIntegerTempA_H,SysIntegerTempB_H
	cp	SYSINTEGERTEMPA_H,SYSINTEGERTEMPB_H
;brlo SCLTIntTrue
	brlo	SCLTINTTRUE
;Test Low, exit if more or equal
;cp SysIntegerTempA,SysIntegerTempB
	cp	SYSINTEGERTEMPA,SYSINTEGERTEMPB
;brlo SCLTIntTrue
	brlo	SCLTINTTRUE
;ret
	ret
SCLTINTTRUE:
;com SysByteTempX
	com	SYSBYTETEMPX
SCLTINTFALSE:
	ret

;********************************************************************************

;Source: system.h (2457)
SYSDIVSUB16:
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;dim SysDivMultA as word
;dim SysDivMultB as word
;dim SysDivMultX as word
;SysDivMultA = SysWordTempA
	mov	SYSDIVMULTA,SYSWORDTEMPA
	mov	SYSDIVMULTA_H,SYSWORDTEMPA_H
;SysDivMultB = SysWordTempB
	mov	SYSDIVMULTB,SYSWORDTEMPB
	mov	SYSDIVMULTB_H,SYSWORDTEMPB_H
;SysDivMultX = 0
	ldi	SysValueCopy,0
	mov	SYSDIVMULTX,SysValueCopy
	ldi	SysValueCopy,0
	mov	SYSDIVMULTX_H,SysValueCopy
;Avoid division by zero
;if SysDivMultB = 0 then
	mov	SysWORDTempA,SYSDIVMULTB
	mov	SysWORDTempA_H,SYSDIVMULTB_H
	ldi	SysWORDTempB,0
	ldi	SysWORDTempB_H,0
	rcall	SysCompEqual16
	sbrs	SysByteTempX,0
	rjmp	ENDIF20
;SysWordTempA = 0
	ldi	SYSWORDTEMPA,0
	ldi	SYSWORDTEMPA_H,0
;exit sub
	ret
;end if
ENDIF20:
;Main calc routine
;SysDivLoop = 16
	ldi	SysValueCopy,16
	mov	SYSDIVLOOP,SysValueCopy
SYSDIV16START:
;set C off
	clc
;Rotate SysDivMultA Left
	rol	SYSDIVMULTA
	rol	SYSDIVMULTA_H
;Rotate SysDivMultX Left
	rol	SYSDIVMULTX
	rol	SYSDIVMULTX_H
;SysDivMultX = SysDivMultX - SysDivMultB
	mov	SysTemp3,SYSDIVMULTX
	sub	SysTemp3,SYSDIVMULTB
	mov	SYSDIVMULTX,SysTemp3
	mov	SysTemp3,SYSDIVMULTX_H
	sbc	SysTemp3,SYSDIVMULTB_H
	mov	SYSDIVMULTX_H,SysTemp3
;Set SysDivMultA.0 On
	sbr	 SYSDIVMULTA,1<<0
;If C On Then
	brbc	C,ENDIF21
;Set SysDivMultA.0 Off
	cbr	 SYSDIVMULTA,1<<0
;SysDivMultX = SysDivMultX + SysDivMultB
	mov	SysTemp3,SYSDIVMULTX
	add	SysTemp3,SYSDIVMULTB
	mov	SYSDIVMULTX,SysTemp3
	mov	SysTemp3,SYSDIVMULTX_H
	adc	SysTemp3,SYSDIVMULTB_H
	mov	SYSDIVMULTX_H,SysTemp3
;End If
ENDIF21:
;dec SysDivLoop
	dec	SYSDIVLOOP
;brne SysDiv16Start
	brne	SYSDIV16START
;SysWordTempA = SysDivMultA
	mov	SYSWORDTEMPA,SYSDIVMULTA
	mov	SYSWORDTEMPA_H,SYSDIVMULTA_H
;SysWordTempX = SysDivMultX
	mov	SYSWORDTEMPX,SYSDIVMULTX
	mov	SYSWORDTEMPX_H,SYSDIVMULTX_H
	ret

;********************************************************************************

;Source: system.h (2212)
SYSMULTSUB16:
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;Need to keep result in here because SysWordTempX[_H] gets overwritten by mul
;dim SysDivMultX as word ' alias SysWordTempX_U, SysWordTempX_H
;X = LowA * LowB
;mul SysWordTempA, SysWordTempB
	mul	SYSWORDTEMPA, SYSWORDTEMPB
;movff PRODL, SysWordTempX
;movff PRODH, SysWordTempX_H
;SysDivMultX = SysWordTempX
	mov	SYSDIVMULTX,SYSWORDTEMPX
	mov	SYSDIVMULTX_H,SYSWORDTEMPX_H
;HighX += LowA * HighB
;mul SysWordTempA, SysWordTempB_H
	mul	SYSWORDTEMPA, SYSWORDTEMPB_H
;add SysDivMultX_H, SysWordTempX
	add	SYSDIVMULTX_H, SYSWORDTEMPX
;HighX += HighA * LowB
;mul SysWordTempA_H, SysWordTempB
	mul	SYSWORDTEMPA_H, SYSWORDTEMPB
;add SysDivMultX_H, SysWordTempX
	add	SYSDIVMULTX_H, SYSWORDTEMPX
;Copy result back
;SysWordTempX = SysDivMultX
	mov	SYSWORDTEMPX,SYSDIVMULTX
	mov	SYSWORDTEMPX_H,SYSDIVMULTX_H
	ret

;********************************************************************************

;Source: system.h (2310)
SYSMULTSUBINT:
;Dim SysIntegerTempA, SysIntegerTempB, SysIntegerTempX As Integer
;Dim SysSignByte As Byte
;Make both inputs positive, decide output type
;SysSignByte = SysIntegerTempA_H xor SysIntegerTempB_H
	mov	SysTemp3,SYSINTEGERTEMPB_H
	eor	SysTemp3,SYSINTEGERTEMPA_H
	mov	SYSSIGNBYTE,SysTemp3
;if SysIntegerTempA.15 then SysIntegerTempA = -SysIntegerTempA
	sbrs	SYSINTEGERTEMPA_H,7
	rjmp	ENDIF17
	mov	SysTemp1,SYSINTEGERTEMPA
	mov	SysTemp1_H,SYSINTEGERTEMPA_H
	com	SysTemp1
	com	SysTemp1_H
	inc	SysTemp1
	brne	PC + 2
	inc	SysTemp1_H
	mov	SYSINTEGERTEMPA,SysTemp1
	mov	SYSINTEGERTEMPA_H,SysTemp1_H
ENDIF17:
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
	sbrs	SYSINTEGERTEMPB_H,7
	rjmp	ENDIF18
	mov	SysTemp1,SYSINTEGERTEMPB
	mov	SysTemp1_H,SYSINTEGERTEMPB_H
	com	SysTemp1
	com	SysTemp1_H
	inc	SysTemp1
	brne	PC + 2
	inc	SysTemp1_H
	mov	SYSINTEGERTEMPB,SysTemp1
	mov	SYSINTEGERTEMPB_H,SysTemp1_H
ENDIF18:
;Call word multiply routine
;SysMultSub16
	rcall	SYSMULTSUB16
;Negate result if necessary
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
	sbrs	SYSSIGNBYTE,7
	rjmp	ENDIF19
	mov	SysTemp1,SYSINTEGERTEMPX
	mov	SysTemp1_H,SYSINTEGERTEMPX_H
	com	SysTemp1
	com	SysTemp1_H
	inc	SysTemp1
	brne	PC + 2
	inc	SysTemp1_H
	mov	SYSINTEGERTEMPX,SysTemp1
	mov	SYSINTEGERTEMPX_H,SysTemp1_H
ENDIF19:
	ret

;********************************************************************************

;Source: system.h (1240)
SYSREADSTRING:
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Dim SysCalcTempX As Byte
;Get length
;lpm SysCalcTempA, Z+
;lpm
	lpm
;mov SysCalcTempA, SysCalcTempX
	mov	SYSCALCTEMPA, SYSCALCTEMPX
;SysReadA += 1
	inc	SYSREADA
	brne	PC + 2
	inc	SYSREADA_H
;st Y+, SysCalcTempA
	st	Y+, SYSCALCTEMPA
;rjmp SysStringReadCheck
	rjmp	SYSSTRINGREADCHECK
SYSREADSTRINGPART:
;lpm SysCalcTempA, Z+
;lpm
	lpm
;mov SysCalcTempA, SysCalcTempX
	mov	SYSCALCTEMPA, SYSCALCTEMPX
;SysReadA += 1
	inc	SYSREADA
	brne	PC + 2
	inc	SYSREADA_H
;add SysStringLength, SysCalcTempA
	add	SYSSTRINGLENGTH, SYSCALCTEMPA
;Check length
SYSSTRINGREADCHECK:
;If length is 0, exit
;cpi SysCalcTempA, 0
	cpi	SYSCALCTEMPA, 0
;brne SysStringRead
	brne	SYSSTRINGREAD
;ret
	ret
;Copy
SYSSTRINGREAD:
;Copy char
;lpm SysCalcTempX, Z+
;lpm
	lpm
;SysReadA += 1
	inc	SYSREADA
	brne	PC + 2
	inc	SYSREADA_H
;st Y+, SysCalcTempX
	st	Y+, SYSCALCTEMPX
;dec SysCalcTempA
	dec	SYSCALCTEMPA
;brne SysStringRead
	brne	SYSSTRINGREAD
	ret

;********************************************************************************

SysStringTables:

StringTable1:
.DB	1,80


StringTable2:
.DB	1,82


StringTable27:
.DB	13,73,110,32,71,76,67,68,80,114,105,110,116,45


StringTable28:
.DB	1,44


StringTable29:
.DB	2,58,32,0


StringTable56:
.DB	22,105,110,32,68,114,97,119,67,104,97,114,95,69,80,68,50,105,110,49,51,68,45,0


StringTable57:
.DB	3,32,58,32


;********************************************************************************


