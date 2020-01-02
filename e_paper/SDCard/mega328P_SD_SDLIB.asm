;Program compiled by Great Cow BASIC (0.98.<<>> 2019-12-08 (Windows 32 bit))
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
.EQU	ADDRESS_SECTOR=2036
.EQU	ADDRESS_SECTOR_E=2039
.EQU	ADDRESS_SECTOR_H=2037
.EQU	ADDRESS_SECTOR_U=2038
.EQU	ARG=2040
.EQU	ARG_E=2043
.EQU	ARG_H=2041
.EQU	ARG_U=2042
.EQU	B0=2044
.EQU	B0_E=2047
.EQU	B0_H=2045
.EQU	B0_U=2046
.EQU	B1=2048
.EQU	B1_E=2051
.EQU	B1_H=2049
.EQU	B1_U=2050
.EQU	B2=2052
.EQU	B2_E=2055
.EQU	B2_H=2053
.EQU	B2_U=2054
.EQU	B3=2056
.EQU	B3_E=2059
.EQU	B3_H=2057
.EQU	B3_U=2058
.EQU	BLOCK_START=2060
.EQU	BLOCK_START_E=2063
.EQU	BLOCK_START_H=2061
.EQU	BLOCK_START_U=2062
.EQU	BOOT_FLAG=2064
.EQU	CHR=1681
.EQU	CLUSTER_BEGIN_LBA=2065
.EQU	CLUSTER_BEGIN_LBA_E=2068
.EQU	CLUSTER_BEGIN_LBA_H=2066
.EQU	CLUSTER_BEGIN_LBA_U=2067
.EQU	CODE=2069
.EQU	COMPORT=2070
.EQU	COUNTER=2071
.EQU	CRC=2072
.EQU	CRLF1=2073
.EQU	CRLF2=2074
.EQU	DIR_OR_FILE_NAME=2007
.EQU	DIR_RECORD=2016
.EQU	FAT_BEGIN_LBA=2075
.EQU	FAT_BEGIN_LBA_E=2078
.EQU	FAT_BEGIN_LBA_H=2076
.EQU	FAT_BEGIN_LBA_U=2077
.EQU	FILE_EXTENSION=2028
.EQU	FILE_RECORD=2022
.EQU	FILE_SYSTEM_VER_NUM=2079
.EQU	FNLSL=2080
.EQU	FNLSL_E=2084
.EQU	FNLSL_H=2085
.EQU	FNLSL_U=2086
.EQU	HSERINBYTE=2087
.EQU	HSERINDEX=2088
.EQU	HSERPRINTCRLFCOUNT=2089
.EQU	HSERRECEIVE=2090
.EQU	IND1=2091
.EQU	IND2=2092
.EQU	INF_ADDR_BUFF=2093
.EQU	INF_ADDR_BUFF_H=2094
.EQU	INITSUCC=2095
.EQU	INPUTB=2096
.EQU	INPUTL=2097
.EQU	INPUTL_E=2100
.EQU	INPUTL_H=2098
.EQU	INPUTL_U=2099
.EQU	INPUTW=2101
.EQU	INPUTW_H=2102
.EQU	LEFT=1722
.EQU	LEN=2103
.EQU	LINE_TYPE=2104
.EQU	MAIN_IND=2105
.EQU	MAIN_IND_H=2106
.EQU	MAIN_IND_TRANS=2107
.EQU	MAIN_IND_TRANS_H=2108
.EQU	MAIN_MYSTRING=1763
.EQU	NRESPONSE=2109
.EQU	NUMBITS=2110
.EQU	N_BYTES=2111
.EQU	N_BYTES_PER_SECTOR=2112
.EQU	N_BYTES_PER_SECTOR_H=2113
.EQU	N_CHAR=2114
.EQU	N_FATS=2115
.EQU	N_RESERVED_SECTOR=2116
.EQU	N_RESERVED_SECTOR_H=2117
.EQU	N_SECTORS_PER_FAT=2118
.EQU	N_SECTORS_PER_FAT_E=2121
.EQU	N_SECTORS_PER_FAT_H=2119
.EQU	N_SECTORS_PER_FAT_U=2120
.EQU	N_SECTOR_OF_FAT2=2122
.EQU	N_SECTOR_PER_CLUSTER=2123
.EQU	OUTPUT=2124
.EQU	OUTPUT_E=2127
.EQU	OUTPUT_H=2125
.EQU	OUTPUT_U=2126
.EQU	OUTVALUETEMP=2128
.EQU	PARTITION_BEGIN_LBA=2129
.EQU	PARTITION_BEGIN_LBA_E=2132
.EQU	PARTITION_BEGIN_LBA_H=2130
.EQU	PARTITION_BEGIN_LBA_U=2131
.EQU	PRINTLEN=2133
.EQU	RECORD_LOCATION=2134
.EQU	RECORD_LOCATION_H=2135
.EQU	RECORD_LOCATION_LAST=2136
.EQU	RECORD_LOCATION_LAST_H=2137
.EQU	RECORD_NUMBER=2138
.EQU	RIGHT=1804
.EQU	SDBUFF_IND=2139
.EQU	SDBUFF_IND_H=2140
.EQU	SDBYTE=2141
.EQU	SDBYTE_H=2142
.EQU	SDDATA=2143
.EQU	SDDATABUFFER=256
.EQU	SDLOCATION=2144
.EQU	SDLOCATION0=2148
.EQU	SDLOCATION0_E=2151
.EQU	SDLOCATION0_H=2149
.EQU	SDLOCATION0_U=2150
.EQU	SDLOCATION_E=2147
.EQU	SDLOCATION_H=2145
.EQU	SDLOCATION_HEADER=2152
.EQU	SDLOCATION_HEADER_E=2155
.EQU	SDLOCATION_HEADER_H=2153
.EQU	SDLOCATION_HEADER_U=2154
.EQU	SDLOCATION_LAST=2156
.EQU	SDLOCATION_LAST_E=2159
.EQU	SDLOCATION_LAST_H=2157
.EQU	SDLOCATION_LAST_U=2158
.EQU	SDLOCATION_U=2146
.EQU	SDRESP=2160
.EQU	SDRESPONSE=2161
.EQU	SDRESPONSE2=2162
.EQU	SDRESPONSE3=2163
.EQU	SDRESPONSE4=2164
.EQU	SDRESPONSE5=2165
.EQU	SDTOKEN=2166
.EQU	SD_COUNTER=2167
.EQU	SD_COUNTER1=2169
.EQU	SD_COUNTER1_H=2170
.EQU	SD_COUNTER2=2171
.EQU	SD_COUNTER2_H=2172
.EQU	SD_COUNTER3=2173
.EQU	SD_COUNTER3_H=2174
.EQU	SD_COUNTER_H=2168
.EQU	SD_MYSTRING=1960
.EQU	SD_MYSTRING1=1972
.EQU	SD_MYSTRING2=1984
.EQU	SD_SD_COUNTER=2175
.EQU	SERDATA=2176
.EQU	SERPRINTVAL=2177
.EQU	SERPRINTVAL_E=2180
.EQU	SERPRINTVAL_H=2178
.EQU	SERPRINTVAL_U=2179
.EQU	SPICLOCKMODE=2181
.EQU	SPICURRENTMODE=2182
.EQU	SPIRXDATA=2183
.EQU	SPITXDATA=2184
.EQU	STRINGPOINTER=2185
.EQU	SYSARRAYTEMP1=2186
.EQU	SYSARRAYTEMP2=2187
.EQU	SYSCHAR=2188
.EQU	SYSCHARCOUNT=2189
.EQU	SYSCHARHANDLER=2190
.EQU	SYSCHARHANDLER_H=2191
.EQU	SYSCHARSTART=2192
.EQU	SYSHSERSTRINGHANDLER=2193
.EQU	SYSHSERSTRINGHANDLER_H=2194
.EQU	SYSINPUTSHANDLER=2195
.EQU	SYSINPUTSHANDLER_H=2196
.EQU	SYSLENTEMPHANDLER=2197
.EQU	SYSLENTEMPHANDLER_H=2198
.EQU	SYSLONGDIVMULTA=2199
.EQU	SYSLONGDIVMULTA_E=2202
.EQU	SYSLONGDIVMULTA_H=2200
.EQU	SYSLONGDIVMULTA_U=2201
.EQU	SYSLONGDIVMULTB=2203
.EQU	SYSLONGDIVMULTB_E=2206
.EQU	SYSLONGDIVMULTB_H=2204
.EQU	SYSLONGDIVMULTB_U=2205
.EQU	SYSLONGDIVMULTX=2207
.EQU	SYSLONGDIVMULTX_E=2210
.EQU	SYSLONGDIVMULTX_H=2208
.EQU	SYSLONGDIVMULTX_U=2209
.EQU	SYSNAMEHANDLER=2211
.EQU	SYSNAMEHANDLER_H=2212
.EQU	SYSPRINTBUFFER=1996
.EQU	SYSPRINTBUFFLEN=2213
.EQU	SYSPRINTDATAHANDLER=2214
.EQU	SYSPRINTDATAHANDLER_H=2215
.EQU	SYSPRINTTEMP=2216
.EQU	SYSREPEATTEMP1=2217
.EQU	SYSREPEATTEMP10=2218
.EQU	SYSREPEATTEMP11=2219
.EQU	SYSREPEATTEMP11_H=2220
.EQU	SYSREPEATTEMP13=2221
.EQU	SYSREPEATTEMP14=2222
.EQU	SYSREPEATTEMP15=2223
.EQU	SYSREPEATTEMP16=2224
.EQU	SYSREPEATTEMP3=2225
.EQU	SYSREPEATTEMP3_H=2226
.EQU	SYSREPEATTEMP4=2227
.EQU	SYSREPEATTEMP4_H=2228
.EQU	SYSREPEATTEMP5=2229
.EQU	SYSSTRDATA=2230
.EQU	SYSSTRINGAHANDLER=2231
.EQU	SYSSTRINGAHANDLER_H=2232
.EQU	SYSSTRINGPARAM1=769
.EQU	SYSSTRINGPARAM10=826
.EQU	SYSSTRINGPARAM11=883
.EQU	SYSSTRINGPARAM12=940
.EQU	SYSSTRINGPARAM13=997
.EQU	SYSSTRINGPARAM14=1054
.EQU	SYSSTRINGPARAM15=1111
.EQU	SYSSTRINGPARAM16=1168
.EQU	SYSSTRINGPARAM17=1225
.EQU	SYSSTRINGPARAM18=1282
.EQU	SYSSTRINGPARAM2=1886
.EQU	SYSSTRINGPARAM3=1339
.EQU	SYSSTRINGPARAM4=1396
.EQU	SYSSTRINGPARAM5=1453
.EQU	SYSSTRINGPARAM6=1510
.EQU	SYSSTRINGPARAM7=1923
.EQU	SYSSTRINGPARAM8=1567
.EQU	SYSSTRINGPARAM9=1624
.EQU	SYSSTRINGTEMP=2233
.EQU	SYSSYSINSTRINGHANDLER=2234
.EQU	SYSSYSINSTRINGHANDLER_H=2235
.EQU	SYSTEMPARRAY=1845
.EQU	UPPERPAGE=2236
.EQU	VAL=2237
.EQU	VAL_H=2238
.EQU	VERBOSE=2032
.EQU	_GLCDPAGE=2239

;********************************************************************************

;Register variables
.DEF	DELAYTEMP=r25
.DEF	DELAYTEMP2=r26
.DEF	SYSBITTEST=r5
.DEF	SYSBYTETEMPA=r22
.DEF	SYSBYTETEMPB=r28
.DEF	SYSBYTETEMPX=r0
.DEF	SYSCALCTEMPA=r22
.DEF	SYSCALCTEMPA_H=r23
.DEF	SYSCALCTEMPA_U=r24
.DEF	SYSCALCTEMPA_E=r25
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
.DEF	SYSLONGTEMPA=r22
.DEF	SYSLONGTEMPA_H=r23
.DEF	SYSLONGTEMPA_U=r24
.DEF	SYSLONGTEMPA_E=r25
.DEF	SYSLONGTEMPB=r28
.DEF	SYSLONGTEMPB_H=r29
.DEF	SYSLONGTEMPB_U=r30
.DEF	SYSLONGTEMPB_E=r31
.DEF	SYSLONGTEMPX=r0
.DEF	SYSLONGTEMPX_H=r1
.DEF	SYSLONGTEMPX_U=r2
.DEF	SYSLONGTEMPX_E=r3
.DEF	SYSREADA=r30
.DEF	SYSREADA_H=r31
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
.DEF	SYSTEMP1_U=r8
.DEF	SYSTEMP1_E=r9
.DEF	SYSTEMP2=r10
.DEF	SYSTEMP2_H=r11
.DEF	SYSTEMP2_U=r12
.DEF	SYSTEMP2_E=r13
.DEF	SYSTEMP3=r4
.DEF	SYSTEMP4=r16
.DEF	SYSTEMP5=r17

;********************************************************************************

;Alias variables
#define	SYSCHR_0	1681
#define	SYSCHR_1	1682
#define	SYSFNLSLLONG	2080
#define	SYSFNLSLLONG_H	2085
#define	SYSFNLSLLONG_U	2086
#define	SYSFNLSLLONG_E	2084
#define	SYSLEFT_0	1722
#define	SYSRIGHT_0	1804
#define	SYSSDDATABUFFER_11	267
#define	SYSSDDATABUFFER_12	268
#define	SYSSDDATABUFFER_13	269
#define	SYSSDDATABUFFER_14	270
#define	SYSSDDATABUFFER_15	271
#define	SYSSDDATABUFFER_16	272
#define	SYSSDDATABUFFER_36	292
#define	SYSSDDATABUFFER_37	293
#define	SYSSDDATABUFFER_38	294
#define	SYSSDDATABUFFER_39	295
#define	SYSSDDATABUFFER_42	298
#define	SYSSDDATABUFFER_43	299
#define	SYSSDDATABUFFER_50	306
#define	SYSSDDATABUFFER_71	327
#define	SYSSDDATABUFFER_82	338

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
	call	INITSYS
	call	INITUNO
	call	INITUSART

;Start of the main program
;''A demonstration program for Explicit-Paper.
;''-------------------------------------------------------------------------
;-------------------------------------------------------
;''This has been tested using the hardware and software SPI option.
;''*************************************************************************
;*******
;Chip Settings.
;______________
;USART
;#define USART_BAUD_RATE 57600'9600
;#define USART_DELAY     5 ms
;#define USART_BLOCKING
;******************************************************************************************************
;The following should be used   '#define EPD_EPD2in13D_HardwareSPI     'remove comment out if you want to use software SPI.
;#define EPD_HardwareSPI
;#define SPI_BAUD_RATE_REGISTER 7 '**********||||||****|||****|
;#DEFINE SD_HardwareSPI
;***************************************************************************
;***************************
;Setup the E-Paper
;#include <glcd.h>
;#include <xpt2046.h>    'include per il touch driver di ili9341
;#define GLCD_TYPE GLCD_TYPE_EPD_EPD2in13D
;NONE GLCD_TYPE_EPD2in13D_LOWMEMORYx_GLCD_MODE def.==>'BuffWidth=2756,n_page=1
;#define GLCD_TYPE_EPD2in13D_LOWMEMORY1_GLCD_MODE ON  'BuffWidth=13,  n_page=212
;#define GLCD_TYPE_EPD2in13D_LOWMEMORY2_GLCD_MODE ON  'BuffWidth=104, n_page=26
;#define GLCD_TYPE_EPD2in13D_LOWMEMORY3_GLCD_MODE ON  'BuffWidth=208, n_page=13
;#define GLCD_TYPE_EPD2in13D_LOWMEMORY4_GLCD_MODE ON  'BuffWidth=1378,n_page=2
;Pin mappings for SPI - this GLCD driver supports Hardware SPI and Software SPI
;ERV These need to GLCD_DC ETC = was wrong naming convention
;#define GLCD_DC     DIGITAL_9
;#define GLCD_CS     DIGITAL_10
;#define GLCD_RESET  DIGITAL_8
;#define GLCD_DO     DIGITAL_11
;#define GLCD_SCK    DIGITAL_13
;#define GLCD_Busy   DIGITAL_7
;--------------*-----------------*------------------*-----------------*--
;Setup SD pins (sono presenti sia l'EPD2in13D card adapter che
;un HW SD Card Adapter chip)
;#define SD_Adaper_CS DIGITAL_10
;#define SD_SCK DIGITAL_13
;#define SD_DO DIGITAL_11
;#define SD_DI DIGITAL_12
;Dir     SD_Adaper_CS  OUT
	sbi	DDRB,2
;Dir     SD_DO         OUT
	sbi	DDRB,3
;Dir     SD_SCK        OUT
	sbi	DDRB,5
;Dir     SD_DI         IN
	cbi	DDRB,4
;GLCDRotate ( Landscape_rev )     ' optionally you can rotate the screen.
;Dim Inf_Addr_Buff, SDBuff_ind  as word
;Dim Main_counter, Main_Counter1, Main_Counter2, Main_Counter3 as Word
;Dim Main_Ind, Main_Ind_trans as word
;Dim Main_MyString, Main_MyString1 as String
;******************************************************************************************************
;Main program
;SPIMode MasterSlow, 0
	ldi	SysValueCopy,11
	sts	SPICURRENTMODE,SysValueCopy
	ldi	SysValueCopy,0
	sts	SPICLOCKMODE,SysValueCopy
	call	SPIMODE241
;HSerPrint CHR(12)           'Clear Serial terminal
	ldi	SysValueCopy,12
	sts	SYSCHAR,SysValueCopy
	call	FN_CHR
	ldi	SysValueCopy,low(CHR)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(CHR)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	call	HSERPRINT286
;sertxd(1,"*=*","E-Paper EPD2in13(D)",0):sertxd(0,"*=*","==",0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable3<<1)
	ldi	SysReadA_H,high(StringTable3<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM2)
	ldi	SysStringB_H,high(SYSSTRINGPARAM2)
	ldi	SysReadA,low(StringTable4<<1)
	ldi	SysReadA_H,high(StringTable4<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM2)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM2)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable3<<1)
	ldi	SysReadA_H,high(StringTable3<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM2)
	ldi	SysStringB_H,high(SYSSTRINGPARAM2)
	ldi	SysReadA,low(StringTable5<<1)
	ldi	SysReadA_H,high(StringTable5<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM2)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM2)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
;sertxd(1,"*=*FontSize=", GLCDFontWidth,0):sertxd(0,"*=*","==",0)
;dim upperPage, lowerPage as Byte
;upperPage = 0
	ldi	SysValueCopy,0
	sts	UPPERPAGE,SysValueCopy
;lowerPage = EPD_N_PAGE-1
;SET SD_Adaper_CS ON
	sbi	PORTB,2
REQUEST:
;sertxd(1,"CARD already ","initialized? s/n ",0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable6<<1)
	ldi	SysReadA_H,high(StringTable6<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM2)
	ldi	SysStringB_H,high(SYSSTRINGPARAM2)
	ldi	SysReadA,low(StringTable7<<1)
	ldi	SysReadA_H,high(StringTable7<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM2)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM2)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
;HSerGetstring Main_MyString
	ldi	SysValueCopy,low(MAIN_MYSTRING)
	sts	SysHSERSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(MAIN_MYSTRING)
	sts	SysHSERSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	call	HSERGETSTRING
;if Main_MyString<>"s" then
	ldi	SysStringB,low(SYSTEMPARRAY)
	ldi	SysStringB_H,high(SYSTEMPARRAY)
	ldi	SysReadA,low(StringTable8<<1)
	ldi	SysReadA_H,high(StringTable8<<1)
	call	SysReadString
	ldi	SysStringA,low(MAIN_MYSTRING)
	ldi	SysStringA_H,high(MAIN_MYSTRING)
	ldi	SysStringB,low(SYSTEMPARRAY)
	ldi	SysStringB_H,high(SYSTEMPARRAY)
	call	SysCompEqualString
	com	SysByteTempX
	sbrc	SysByteTempX,0
;SDInitialize                      'Card Initialization
	call	SDINITIALIZE
;end if
;Partition_Entry_and_Relevant_Data 'Find Partition Entry and Partition Relevant Data
	call	PARTITION_ENTRY_AND_RELEVANT_DATA
CARD_OPERATION_ROOT:
;Disk_Explorer(Cluster_Begin_LBA,"BOOT")  'Explore Directory and Files in BOOT
	lds	SysValueCopy,CLUSTER_BEGIN_LBA
	sts	ADDRESS_SECTOR,SysValueCopy
	lds	SysValueCopy,CLUSTER_BEGIN_LBA_H
	sts	ADDRESS_SECTOR_H,SysValueCopy
	lds	SysValueCopy,CLUSTER_BEGIN_LBA_U
	sts	ADDRESS_SECTOR_U,SysValueCopy
	lds	SysValueCopy,CLUSTER_BEGIN_LBA_E
	sts	ADDRESS_SECTOR_E,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable9<<1)
	ldi	SysReadA_H,high(StringTable9<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysNAMEHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysNAMEHandler_H,SysValueCopy
	call	DISK_EXPLORER
;SDLocation0=Cluster_Begin_LBA
	lds	SysValueCopy,CLUSTER_BEGIN_LBA
	sts	SDLOCATION0,SysValueCopy
	lds	SysValueCopy,CLUSTER_BEGIN_LBA_H
	sts	SDLOCATION0_H,SysValueCopy
	lds	SysValueCopy,CLUSTER_BEGIN_LBA_U
	sts	SDLOCATION0_U,SysValueCopy
	lds	SysValueCopy,CLUSTER_BEGIN_LBA_E
	sts	SDLOCATION0_E,SysValueCopy
CARD_OPERATION:
;Draw_Line(1,25," ")
;sertxd(0," MENU: "," ",0)
;sertxd(1,"     EXPLORE/EXECUTE: File or Directory"," ",0)
;sertxd(1,"  I) Fn= execute"," File num n",0)
;sertxd(1," II) Dn= Explore"," Directory num n",0)
;sertxd(1," III)En= Run Gra","ph Example num n",0)
;sertxd(1," VI) R = GO TO ROOT"," ",0)
;Draw_Line(1,10," "):sertxd(0,"  Please give your choice"," ",0)
	ldi	SysValueCopy,1
	sts	LINE_TYPE,SysValueCopy
	ldi	SysValueCopy,10
	sts	N_CHAR,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable10<<1)
	ldi	SysReadA_H,high(StringTable10<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysCHARHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysCHARHandler_H,SysValueCopy
	call	DRAW_LINE
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable11<<1)
	ldi	SysReadA_H,high(StringTable11<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM2)
	ldi	SysStringB_H,high(SYSSTRINGPARAM2)
	ldi	SysReadA,low(StringTable10<<1)
	ldi	SysReadA_H,high(StringTable10<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM2)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM2)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
;HSerGetstring Main_MyString
	ldi	SysValueCopy,low(MAIN_MYSTRING)
	sts	SysHSERSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(MAIN_MYSTRING)
	sts	SysHSERSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	call	HSERGETSTRING
;if Main_MyString="R" or Main_MyString="r" then
	ldi	SysStringB,low(SYSTEMPARRAY)
	ldi	SysStringB_H,high(SYSTEMPARRAY)
	ldi	SysReadA,low(StringTable12<<1)
	ldi	SysReadA_H,high(StringTable12<<1)
	call	SysReadString
	ldi	SysStringA,low(MAIN_MYSTRING)
	ldi	SysStringA_H,high(MAIN_MYSTRING)
	ldi	SysStringB,low(SYSTEMPARRAY)
	ldi	SysStringB_H,high(SYSTEMPARRAY)
	call	SysCompEqualString
	mov	SysTemp1,SysByteTempX
	ldi	SysStringB,low(SYSTEMPARRAY)
	ldi	SysStringB_H,high(SYSTEMPARRAY)
	ldi	SysReadA,low(StringTable13<<1)
	ldi	SysReadA_H,high(StringTable13<<1)
	call	SysReadString
	ldi	SysStringA,low(MAIN_MYSTRING)
	ldi	SysStringA_H,high(MAIN_MYSTRING)
	ldi	SysStringB,low(SYSTEMPARRAY)
	ldi	SysStringB_H,high(SYSTEMPARRAY)
	call	SysCompEqualString
	mov	SysTemp3,SysByteTempX
	or	SysTemp3,SysTemp1
	mov	SysTemp2,SysTemp3
	sbrc	SysTemp2,0
;goto CARD_Operation_Root
	rjmp	CARD_OPERATION_ROOT
;End if
;if Left(Main_MyString,1)<> "D" then
	ldi	SysValueCopy,low(MAIN_MYSTRING)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(MAIN_MYSTRING)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	SYSCHARCOUNT,SysValueCopy
	call	FN_LEFT
	ldi	SysStringB,low(SYSTEMPARRAY)
	ldi	SysStringB_H,high(SYSTEMPARRAY)
	ldi	SysReadA,low(StringTable14<<1)
	ldi	SysReadA_H,high(StringTable14<<1)
	call	SysReadString
	ldi	SysStringA,low(LEFT)
	ldi	SysStringA_H,high(LEFT)
	ldi	SysStringB,low(SYSTEMPARRAY)
	ldi	SysStringB_H,high(SYSTEMPARRAY)
	call	SysCompEqualString
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF3
;if Left(Main_MyString,1)<> "F" then
	ldi	SysValueCopy,low(MAIN_MYSTRING)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(MAIN_MYSTRING)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	SYSCHARCOUNT,SysValueCopy
	call	FN_LEFT
	ldi	SysStringB,low(SYSTEMPARRAY)
	ldi	SysStringB_H,high(SYSTEMPARRAY)
	ldi	SysReadA,low(StringTable15<<1)
	ldi	SysReadA_H,high(StringTable15<<1)
	call	SysReadString
	ldi	SysStringA,low(LEFT)
	ldi	SysStringA_H,high(LEFT)
	ldi	SysStringB,low(SYSTEMPARRAY)
	ldi	SysStringB_H,high(SYSTEMPARRAY)
	call	SysCompEqualString
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF5
;if Left(Main_MyString,1)<> "E" then
	ldi	SysValueCopy,low(MAIN_MYSTRING)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(MAIN_MYSTRING)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	SYSCHARCOUNT,SysValueCopy
	call	FN_LEFT
	ldi	SysStringB,low(SYSTEMPARRAY)
	ldi	SysStringB_H,high(SYSTEMPARRAY)
	ldi	SysReadA,low(StringTable16<<1)
	ldi	SysReadA_H,high(StringTable16<<1)
	call	SysReadString
	ldi	SysStringA,low(LEFT)
	ldi	SysStringA_H,high(LEFT)
	ldi	SysStringB,low(SYSTEMPARRAY)
	ldi	SysStringB_H,high(SYSTEMPARRAY)
	call	SysCompEqualString
	com	SysByteTempX
	sbrc	SysByteTempX,0
;goto CARD_Operation
	rjmp	CARD_OPERATION
;end if
;end if
ENDIF5:
;end if
ENDIF3:
;--------------------------------------
;SD_Counter=Val(Right(Main_MyString,Len(Main_MyString)-1))  'il numero può essere a più cifre!
	ldi	SysValueCopy,low(MAIN_MYSTRING)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(MAIN_MYSTRING)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,low(MAIN_MYSTRING)
	sts	SysLENTEMPHandler,SysValueCopy
	ldi	SysValueCopy,high(MAIN_MYSTRING)
	sts	SysLENTEMPHandler_H,SysValueCopy
	call	FN_LEN
	lds	SysTemp1,LEN
	dec	SysTemp1
	sts	SYSCHARCOUNT,SysTemp1
	call	FN_RIGHT
	ldi	SysValueCopy,low(RIGHT)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(RIGHT)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	call	FN_VAL
	lds	SysValueCopy,VAL
	sts	SD_COUNTER,SysValueCopy
	lds	SysValueCopy,VAL_H
	sts	SD_COUNTER_H,SysValueCopy
;if Left(Main_MyString,1)<>"E" then
	ldi	SysValueCopy,low(MAIN_MYSTRING)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(MAIN_MYSTRING)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	SYSCHARCOUNT,SysValueCopy
	call	FN_LEFT
	ldi	SysStringB,low(SYSTEMPARRAY)
	ldi	SysStringB_H,high(SYSTEMPARRAY)
	ldi	SysReadA,low(StringTable16<<1)
	ldi	SysReadA_H,high(StringTable16<<1)
	call	SysReadString
	ldi	SysStringA,low(LEFT)
	ldi	SysStringA_H,high(LEFT)
	ldi	SysStringB,low(SYSTEMPARRAY)
	ldi	SysStringB_H,high(SYSTEMPARRAY)
	call	SysCompEqualString
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ELSE4_1
;if Left(Main_MyString,1)="D" then
	ldi	SysValueCopy,low(MAIN_MYSTRING)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(MAIN_MYSTRING)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	SYSCHARCOUNT,SysValueCopy
	call	FN_LEFT
	ldi	SysStringB,low(SYSTEMPARRAY)
	ldi	SysStringB_H,high(SYSTEMPARRAY)
	ldi	SysReadA,low(StringTable14<<1)
	ldi	SysReadA_H,high(StringTable14<<1)
	call	SysReadString
	ldi	SysStringA,low(LEFT)
	ldi	SysStringA_H,high(LEFT)
	ldi	SysStringB,low(SYSTEMPARRAY)
	ldi	SysStringB_H,high(SYSTEMPARRAY)
	call	SysCompEqualString
	sbrs	SysByteTempX,0
	rjmp	ELSE6_1
;Record_Number=Dir_Record(SD_Counter)
	lds	SysTemp2,SD_COUNTER
	ldi	SysTemp4,low(DIR_RECORD)
	add	SysTemp2,SysTemp4
	mov	SysStringA,SysTemp2
	lds	SysTemp2,SD_COUNTER_H
	ldi	SysTemp4,high(DIR_RECORD)
	adc	SysTemp2,SysTemp4
	mov	SysStringA_H,SysTemp2
	ld	SysValueCopy,X
	sts	RECORD_NUMBER,SysValueCopy
;else
	rjmp	ENDIF6
ELSE6_1:
;Record_Number=File_Record(SD_Counter)   'N. del record di info
	lds	SysTemp2,SD_COUNTER
	ldi	SysTemp4,low(FILE_RECORD)
	add	SysTemp2,SysTemp4
	mov	SysStringA,SysTemp2
	lds	SysTemp2,SD_COUNTER_H
	ldi	SysTemp4,high(FILE_RECORD)
	adc	SysTemp2,SysTemp4
	mov	SysStringA_H,SysTemp2
	ld	SysValueCopy,X
	sts	RECORD_NUMBER,SysValueCopy
;end if
ENDIF6:
;IF VERBOSE="ON" then
	ldi	SysStringB,low(SYSTEMPARRAY)
	ldi	SysStringB_H,high(SYSTEMPARRAY)
	ldi	SysReadA,low(StringTable17<<1)
	ldi	SysReadA_H,high(StringTable17<<1)
	call	SysReadString
	ldi	SysStringA,low(VERBOSE)
	ldi	SysStringA_H,high(VERBOSE)
	ldi	SysStringB,low(SYSTEMPARRAY)
	ldi	SysStringB_H,high(SYSTEMPARRAY)
	call	SysCompEqualString
	sbrs	SysByteTempX,0
	rjmp	ENDIF7
;Draw_Line(2,20,"=")
	ldi	SysValueCopy,2
	sts	LINE_TYPE,SysValueCopy
	ldi	SysValueCopy,20
	sts	N_CHAR,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable18<<1)
	ldi	SysReadA_H,high(StringTable18<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysCHARHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysCHARHandler_H,SysValueCopy
	call	DRAW_LINE
;sertxd(1,"  The entry of the chosen File/Dir is  at Boot record n.",SDLocation,0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable19<<1)
	ldi	SysReadA_H,high(StringTable19<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysValueCopy,SDLOCATION
	sts	INPUTL,SysValueCopy
	lds	SysValueCopy,SDLOCATION_H
	sts	INPUTL_H,SysValueCopy
	lds	SysValueCopy,SDLOCATION_U
	sts	INPUTL_U,SysValueCopy
	lds	SysValueCopy,SDLOCATION_E
	sts	INPUTL_E,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD10
;Draw_Line(2,20,"=")
	ldi	SysValueCopy,2
	sts	LINE_TYPE,SysValueCopy
	ldi	SysValueCopy,20
	sts	N_CHAR,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable18<<1)
	ldi	SysReadA_H,high(StringTable18<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysCHARHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysCHARHandler_H,SysValueCopy
	call	DRAW_LINE
;end if
ENDIF7:
;if Record_Number>15 then
	ldi	SysCalcTempA,15
	lds	SysCalcTempB,RECORD_NUMBER
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF8
;SDLocation=SDLocation0+(Record_Number/16)
	lds	SysBYTETempA,RECORD_NUMBER
	ldi	SysBYTETempB,16
	call	SysDivSub
	mov	SysTemp2,SysBYTETempA
	lds	SysTemp3,SDLOCATION0
	add	SysTemp3,SysTemp2
	sts	SDLOCATION,SysTemp3
	lds	SysTemp2,SDLOCATION0_H
	ldi	SysTemp4,0
	adc	SysTemp2,SysTemp4
	sts	SDLOCATION_H,SysTemp2
	lds	SysTemp2,SDLOCATION0_U
	ldi	SysTemp4,0
	adc	SysTemp2,SysTemp4
	sts	SDLOCATION_U,SysTemp2
	lds	SysTemp2,SDLOCATION0_E
	ldi	SysTemp4,0
	adc	SysTemp2,SysTemp4
	sts	SDLOCATION_E,SysTemp2
;SDRead_Block(SDLocation)              'Nuovo settore che contiene le info
	lds	SysValueCopy,SDLOCATION
	sts	BLOCK_START,SysValueCopy
	lds	SysValueCopy,SDLOCATION_H
	sts	BLOCK_START_H,SysValueCopy
	lds	SysValueCopy,SDLOCATION_U
	sts	BLOCK_START_U,SysValueCopy
	lds	SysValueCopy,SDLOCATION_E
	sts	BLOCK_START_E,SysValueCopy
	call	SDREAD_BLOCK
;end if
ENDIF8:
;SDByte=Record_number-(Record_Number/16)*16'N.record delle info nel nuovo settore
	lds	SysBYTETempA,RECORD_NUMBER
	ldi	SysBYTETempB,16
	call	SysDivSub
	mov	SysTemp2,SysBYTETempA
	mov	SysBYTETempA,SysTemp2
	ldi	SysBYTETempB,16
	mul	SysByteTempA,SysByteTempB
	lds	SysTemp2,RECORD_NUMBER
	sub	SysTemp2,SysByteTempX
	sts	SDBYTE,SysTemp2
	clr	SysTemp2
	brcc	PC + 2
	dec	SysTemp2
	sts	SDBYTE_H,SysTemp2
;SDByte=SDByte*32                          'n. record dell'info del file
	lds	SysWORDTempA,SDBYTE
	lds	SysWORDTempA_H,SDBYTE_H
	ldi	SysWORDTempB,32
	ldi	SysWORDTempB_H,0
	call	SysMultSub16
	sts	SDBYTE,SysWORDTempX
	sts	SDBYTE_H,SysWORDTempX_H
;SDLocation=Record_number-(Record_Number/16)*16
	lds	SysBYTETempA,RECORD_NUMBER
	ldi	SysBYTETempB,16
	call	SysDivSub
	mov	SysTemp2,SysBYTETempA
	mov	SysBYTETempA,SysTemp2
	ldi	SysBYTETempB,16
	mul	SysByteTempA,SysByteTempB
	lds	SysTemp2,RECORD_NUMBER
	sub	SysTemp2,SysByteTempX
	sts	SDLOCATION,SysTemp2
	clr	SysTemp2
	brcc	PC + 2
	dec	SysTemp2
	sts	SDLOCATION_H,SysTemp2
	ldi	SysValueCopy,0
	sts	SDLOCATION_U,SysValueCopy
	ldi	SysValueCopy,0
	sts	SDLOCATION_E,SysValueCopy
;SDLocation=SdLocation*32          'Nota:questo valore era in SDByte (di appoggio)
	lds	SysLONGTempA,SDLOCATION
	lds	SysLONGTempA_H,SDLOCATION_H
	lds	SysLONGTempA_U,SDLOCATION_U
	lds	SysLONGTempA_E,SDLOCATION_E
	ldi	SysLONGTempB,32
	ldi	SysLONGTempB_H,0
	ldi	SysLONGTempB_U,0
	ldi	SysLONGTempB_E,0
	call	SysMultSub32
	sts	SDLOCATION,SysLONGTempX
	sts	SDLOCATION_H,SysLONGTempX_H
	sts	SDLOCATION_U,SysLONGTempX_U
	sts	SDLOCATION_E,SysLONGTempX_E
;B0=SDDataBuffer(SDLocation+26)    ' ma e stato mofidificato da SDWrite_Block
	lds	SysTemp2,SDLOCATION
	ldi	SysTemp4,26
	add	SysTemp2,SysTemp4
	mov	SysTemp1,SysTemp2
	lds	SysTemp2,SDLOCATION_H
	ldi	SysTemp4,0
	adc	SysTemp2,SysTemp4
	mov	SysTemp1_H,SysTemp2
	lds	SysTemp2,SDLOCATION_U
	ldi	SysTemp4,0
	adc	SysTemp2,SysTemp4
	mov	SysTemp1_U,SysTemp2
	lds	SysTemp2,SDLOCATION_E
	ldi	SysTemp4,0
	adc	SysTemp2,SysTemp4
	mov	SysTemp1_E,SysTemp2
	ldi	SysTemp4,low(SDDATABUFFER)
	add	SysTemp1,SysTemp4
	mov	SysStringA,SysTemp1
	ldi	SysTemp4,high(SDDATABUFFER)
	adc	SysTemp1_H,SysTemp4
	mov	SysStringA_H,SysTemp1_H
	ld	SysValueCopy,X
	sts	B0,SysValueCopy
	ldi	SysValueCopy,0
	sts	B0_H,SysValueCopy
	sts	B0_U,SysValueCopy
	sts	B0_E,SysValueCopy
;B1=SDDataBuffer(SDLocation+27)
	lds	SysTemp3,SDLOCATION
	ldi	SysTemp4,27
	add	SysTemp3,SysTemp4
	mov	SysTemp1,SysTemp3
	lds	SysTemp3,SDLOCATION_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	mov	SysTemp1_H,SysTemp3
	lds	SysTemp3,SDLOCATION_U
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	mov	SysTemp1_U,SysTemp3
	lds	SysTemp3,SDLOCATION_E
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	mov	SysTemp1_E,SysTemp3
	ldi	SysTemp4,low(SDDATABUFFER)
	add	SysTemp1,SysTemp4
	mov	SysStringA,SysTemp1
	ldi	SysTemp4,high(SDDATABUFFER)
	adc	SysTemp1_H,SysTemp4
	mov	SysStringA_H,SysTemp1_H
	ld	SysValueCopy,X
	sts	B1,SysValueCopy
	ldi	SysValueCopy,0
	sts	B1_H,SysValueCopy
	sts	B1_U,SysValueCopy
	sts	B1_E,SysValueCopy
;B2=SDDataBuffer(SDLocation+20)
	lds	SysTemp3,SDLOCATION
	ldi	SysTemp4,20
	add	SysTemp3,SysTemp4
	mov	SysTemp1,SysTemp3
	lds	SysTemp3,SDLOCATION_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	mov	SysTemp1_H,SysTemp3
	lds	SysTemp3,SDLOCATION_U
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	mov	SysTemp1_U,SysTemp3
	lds	SysTemp3,SDLOCATION_E
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	mov	SysTemp1_E,SysTemp3
	ldi	SysTemp4,low(SDDATABUFFER)
	add	SysTemp1,SysTemp4
	mov	SysStringA,SysTemp1
	ldi	SysTemp4,high(SDDATABUFFER)
	adc	SysTemp1_H,SysTemp4
	mov	SysStringA_H,SysTemp1_H
	ld	SysValueCopy,X
	sts	B2,SysValueCopy
	ldi	SysValueCopy,0
	sts	B2_H,SysValueCopy
	sts	B2_U,SysValueCopy
	sts	B2_E,SysValueCopy
;B3=SDDataBuffer(SDLocation+21)
	lds	SysTemp3,SDLOCATION
	ldi	SysTemp4,21
	add	SysTemp3,SysTemp4
	mov	SysTemp1,SysTemp3
	lds	SysTemp3,SDLOCATION_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	mov	SysTemp1_H,SysTemp3
	lds	SysTemp3,SDLOCATION_U
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	mov	SysTemp1_U,SysTemp3
	lds	SysTemp3,SDLOCATION_E
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	mov	SysTemp1_E,SysTemp3
	ldi	SysTemp4,low(SDDATABUFFER)
	add	SysTemp1,SysTemp4
	mov	SysStringA,SysTemp1
	ldi	SysTemp4,high(SDDATABUFFER)
	adc	SysTemp1_H,SysTemp4
	mov	SysStringA_H,SysTemp1_H
	ld	SysValueCopy,X
	sts	B3,SysValueCopy
	ldi	SysValueCopy,0
	sts	B3_H,SysValueCopy
	sts	B3_U,SysValueCopy
	sts	B3_E,SysValueCopy
;LSB_to_MSB(SDLocation)
	lds	SysValueCopy,SDLOCATION
	sts	OUTPUT,SysValueCopy
	lds	SysValueCopy,SDLOCATION_H
	sts	OUTPUT_H,SysValueCopy
	lds	SysValueCopy,SDLOCATION_U
	sts	OUTPUT_U,SysValueCopy
	lds	SysValueCopy,SDLOCATION_E
	sts	OUTPUT_E,SysValueCopy
	call	LSB_TO_MSB
	lds	SysValueCopy,OUTPUT
	sts	SDLOCATION,SysValueCopy
	lds	SysValueCopy,OUTPUT_H
	sts	SDLOCATION_H,SysValueCopy
	lds	SysValueCopy,OUTPUT_U
	sts	SDLOCATION_U,SysValueCopy
	lds	SysValueCopy,OUTPUT_E
	sts	SDLOCATION_E,SysValueCopy
;B3=SDLocation
	lds	SysValueCopy,SDLOCATION
	sts	B3,SysValueCopy
	lds	SysValueCopy,SDLOCATION_H
	sts	B3_H,SysValueCopy
	lds	SysValueCopy,SDLOCATION_U
	sts	B3_U,SysValueCopy
	lds	SysValueCopy,SDLOCATION_E
	sts	B3_E,SysValueCopy
;SDLocation=Cluster_Begin_LBA+(SDLocation-2)*N_Sector_per_cluster'indirizzo LBA inizio del file
	lds	SysTemp3,SDLOCATION
	ldi	SysTemp4,2
	sub	SysTemp3,SysTemp4
	mov	SysTemp1,SysTemp3
	lds	SysTemp3,SDLOCATION_H
	ldi	SysTemp4,0
	sbc	SysTemp3,SysTemp4
	mov	SysTemp1_H,SysTemp3
	lds	SysTemp3,SDLOCATION_U
	ldi	SysTemp4,0
	sbc	SysTemp3,SysTemp4
	mov	SysTemp1_U,SysTemp3
	lds	SysTemp3,SDLOCATION_E
	ldi	SysTemp4,0
	sbc	SysTemp3,SysTemp4
	mov	SysTemp1_E,SysTemp3
	mov	SysLONGTempA,SysTemp1
	mov	SysLONGTempA_H,SysTemp1_H
	mov	SysLONGTempA_U,SysTemp1_U
	mov	SysLONGTempA_E,SysTemp1_E
	lds	SysLONGTempB,N_SECTOR_PER_CLUSTER
	ldi	SysLONGTempB_H,0
	ldi	SysLONGTempB_U,0
	ldi	SysLONGTempB_E,0
	call	SysMultSub32
	lds	SysTemp3,CLUSTER_BEGIN_LBA
	add	SysTemp3,SysLONGTempX
	sts	SDLOCATION,SysTemp3
	lds	SysTemp3,CLUSTER_BEGIN_LBA_H
	adc	SysTemp3,SysLONGTempX_H
	sts	SDLOCATION_H,SysTemp3
	lds	SysTemp3,CLUSTER_BEGIN_LBA_U
	adc	SysTemp3,SysLONGTempX_U
	sts	SDLOCATION_U,SysTemp3
	lds	SysTemp3,CLUSTER_BEGIN_LBA_E
	adc	SysTemp3,SysLONGTempX_E
	sts	SDLOCATION_E,SysTemp3
;IF VERBOSE="ON" then
	ldi	SysStringB,low(SYSTEMPARRAY)
	ldi	SysStringB_H,high(SYSTEMPARRAY)
	ldi	SysReadA,low(StringTable17<<1)
	ldi	SysReadA_H,high(StringTable17<<1)
	call	SysReadString
	ldi	SysStringA,low(VERBOSE)
	ldi	SysStringA_H,high(VERBOSE)
	ldi	SysStringB,low(SYSTEMPARRAY)
	ldi	SysStringB_H,high(SYSTEMPARRAY)
	call	SysCompEqualString
	sbrs	SysByteTempX,0
	rjmp	ENDIF9
;Draw_Line(2,20,"=")
	ldi	SysValueCopy,2
	sts	LINE_TYPE,SysValueCopy
	ldi	SysValueCopy,20
	sts	N_CHAR,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable18<<1)
	ldi	SysReadA_H,high(StringTable18<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysCHARHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysCHARHandler_H,SysValueCopy
	call	DRAW_LINE
;sertxd(1,"  The choosen File/Dir is at cluster n.=",B3,0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable20<<1)
	ldi	SysReadA_H,high(StringTable20<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysValueCopy,B3
	sts	INPUTL,SysValueCopy
	lds	SysValueCopy,B3_H
	sts	INPUTL_H,SysValueCopy
	lds	SysValueCopy,B3_U
	sts	INPUTL_U,SysValueCopy
	lds	SysValueCopy,B3_E
	sts	INPUTL_E,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD10
;sertxd(1,"  LBA Address of the chosen File/Dir=",SDLocation,0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable21<<1)
	ldi	SysReadA_H,high(StringTable21<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysValueCopy,SDLOCATION
	sts	INPUTL,SysValueCopy
	lds	SysValueCopy,SDLOCATION_H
	sts	INPUTL_H,SysValueCopy
	lds	SysValueCopy,SDLOCATION_U
	sts	INPUTL_U,SysValueCopy
	lds	SysValueCopy,SDLOCATION_E
	sts	INPUTL_E,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD10
;Draw_Line(2,20,"=")
	ldi	SysValueCopy,2
	sts	LINE_TYPE,SysValueCopy
	ldi	SysValueCopy,20
	sts	N_CHAR,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable18<<1)
	ldi	SysReadA_H,high(StringTable18<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysCHARHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysCHARHandler_H,SysValueCopy
	call	DRAW_LINE
;End if
ENDIF9:
;if Left(Main_MyString,1)="D" then
	ldi	SysValueCopy,low(MAIN_MYSTRING)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(MAIN_MYSTRING)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	SYSCHARCOUNT,SysValueCopy
	call	FN_LEFT
	ldi	SysStringB,low(SYSTEMPARRAY)
	ldi	SysStringB_H,high(SYSTEMPARRAY)
	ldi	SysReadA,low(StringTable14<<1)
	ldi	SysReadA_H,high(StringTable14<<1)
	call	SysReadString
	ldi	SysStringA,low(LEFT)
	ldi	SysStringA_H,high(LEFT)
	ldi	SysStringB,low(SYSTEMPARRAY)
	ldi	SysStringB_H,high(SYSTEMPARRAY)
	call	SysCompEqualString
	sbrs	SysByteTempX,0
	rjmp	ELSE10_1
;SDLocation0=SDLocation
	lds	SysValueCopy,SDLOCATION
	sts	SDLOCATION0,SysValueCopy
	lds	SysValueCopy,SDLOCATION_H
	sts	SDLOCATION0_H,SysValueCopy
	lds	SysValueCopy,SDLOCATION_U
	sts	SDLOCATION0_U,SysValueCopy
	lds	SysValueCopy,SDLOCATION_E
	sts	SDLOCATION0_E,SysValueCopy
;Disk_Explorer(SDLocation,Left(Main_MyString,SD_Counter1-1))
	lds	SysValueCopy,SDLOCATION
	sts	ADDRESS_SECTOR,SysValueCopy
	lds	SysValueCopy,SDLOCATION_H
	sts	ADDRESS_SECTOR_H,SysValueCopy
	lds	SysValueCopy,SDLOCATION_U
	sts	ADDRESS_SECTOR_U,SysValueCopy
	lds	SysValueCopy,SDLOCATION_E
	sts	ADDRESS_SECTOR_E,SysValueCopy
	ldi	SysValueCopy,low(MAIN_MYSTRING)
	sts	SysSYSINSTRINGHandler,SysValueCopy
	ldi	SysValueCopy,high(MAIN_MYSTRING)
	sts	SysSYSINSTRINGHandler_H,SysValueCopy
	lds	SysTemp3,SD_COUNTER1
	dec	SysTemp3
	sts	SYSCHARCOUNT,SysTemp3
	call	FN_LEFT
	ldi	SysValueCopy,low(LEFT)
	sts	SysNAMEHandler,SysValueCopy
	ldi	SysValueCopy,high(LEFT)
	sts	SysNAMEHandler_H,SysValueCopy
	call	DISK_EXPLORER
;goto CARD_Operation
	rjmp	CARD_OPERATION
;else
	rjmp	ENDIF10
ELSE10_1:
;Draw_Line(1,15," "):Draw_Line(1,60,"-")
	ldi	SysValueCopy,1
	sts	LINE_TYPE,SysValueCopy
	ldi	SysValueCopy,15
	sts	N_CHAR,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable10<<1)
	ldi	SysReadA_H,high(StringTable10<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysCHARHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysCHARHandler_H,SysValueCopy
	call	DRAW_LINE
	ldi	SysValueCopy,1
	sts	LINE_TYPE,SysValueCopy
	ldi	SysValueCopy,60
	sts	N_CHAR,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable22<<1)
	ldi	SysReadA_H,high(StringTable22<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysCHARHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysCHARHandler_H,SysValueCopy
	call	DRAW_LINE
;Draw_Line(1,15," "):sertxd(0,"A .bin File is assumed"," in the following",0)
	ldi	SysValueCopy,1
	sts	LINE_TYPE,SysValueCopy
	ldi	SysValueCopy,15
	sts	N_CHAR,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable10<<1)
	ldi	SysReadA_H,high(StringTable10<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysCHARHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysCHARHandler_H,SysValueCopy
	call	DRAW_LINE
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable23<<1)
	ldi	SysReadA_H,high(StringTable23<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM2)
	ldi	SysStringB_H,high(SYSSTRINGPARAM2)
	ldi	SysReadA,low(StringTable24<<1)
	ldi	SysReadA_H,high(StringTable24<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM2)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM2)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
;Draw_Line(1,60,"-"):Draw_Line(1,15," ")
	ldi	SysValueCopy,1
	sts	LINE_TYPE,SysValueCopy
	ldi	SysValueCopy,60
	sts	N_CHAR,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable22<<1)
	ldi	SysReadA_H,high(StringTable22<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysCHARHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysCHARHandler_H,SysValueCopy
	call	DRAW_LINE
	ldi	SysValueCopy,1
	sts	LINE_TYPE,SysValueCopy
	ldi	SysValueCopy,15
	sts	N_CHAR,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable10<<1)
	ldi	SysReadA_H,high(StringTable10<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysCHARHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysCHARHandler_H,SysValueCopy
	call	DRAW_LINE
;SDLocation_header=SDLocation
	lds	SysValueCopy,SDLOCATION
	sts	SDLOCATION_HEADER,SysValueCopy
	lds	SysValueCopy,SDLOCATION_H
	sts	SDLOCATION_HEADER_H,SysValueCopy
	lds	SysValueCopy,SDLOCATION_U
	sts	SDLOCATION_HEADER_U,SysValueCopy
	lds	SysValueCopy,SDLOCATION_E
	sts	SDLOCATION_HEADER_E,SysValueCopy
;sertxd(1,"  ===MAKING THE PICTURE"," ",1)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable25<<1)
	ldi	SysReadA_H,high(StringTable25<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM2)
	ldi	SysStringB_H,high(SYSSTRINGPARAM2)
	ldi	SysReadA,low(StringTable10<<1)
	ldi	SysReadA_H,high(StringTable10<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM2)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM2)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	CRLF2,SysValueCopy
	call	SERTXD7
;DIM _GLCDPagE AS BYTE
;FOR _GLCDPage = 0 TO 212
	ldi	SysValueCopy,255
	sts	_GLCDPAGE,SysValueCopy
SysForLoop1:
	lds	SysTemp3,_GLCDPAGE
	inc	SysTemp3
	sts	_GLCDPAGE,SysTemp3
;SET GLCD_CS ON
	sbi	PORTB,2
;SET SD_Adaper_CS OFF
	cbi	PORTB,2
;wait 2 ms
	ldi	SysWaitTempMS,2
	ldi	SysWaitTempMS_H,0
	call	Delay_MS
;SDLocation=SDLocation_header
	lds	SysValueCopy,SDLOCATION_HEADER
	sts	SDLOCATION,SysValueCopy
	lds	SysValueCopy,SDLOCATION_HEADER_H
	sts	SDLOCATION_H,SysValueCopy
	lds	SysValueCopy,SDLOCATION_HEADER_U
	sts	SDLOCATION_U,SysValueCopy
	lds	SysValueCopy,SDLOCATION_HEADER_E
	sts	SDLOCATION_E,SysValueCopy
;SDRead_Block(SDLocation)        'indirizzo in byte dell'header del file della immagine
	lds	SysValueCopy,SDLOCATION
	sts	BLOCK_START,SysValueCopy
	lds	SysValueCopy,SDLOCATION_H
	sts	BLOCK_START_H,SysValueCopy
	lds	SysValueCopy,SDLOCATION_U
	sts	BLOCK_START_U,SysValueCopy
	lds	SysValueCopy,SDLOCATION_E
	sts	BLOCK_START_E,SysValueCopy
	call	SDREAD_BLOCK
;Inf_Addr_Buff=_GLCDPage*BuffWidth
;Main_Ind=0
	ldi	SysValueCopy,0
	sts	MAIN_IND,SysValueCopy
	sts	MAIN_IND_H,SysValueCopy
;SDBuff_Ind=0
	ldi	SysValueCopy,0
	sts	SDBUFF_IND,SysValueCopy
	sts	SDBUFF_IND_H,SysValueCopy
;for SD_Counter2=1 to GLCD_Height
;for SD_Counter3=1 to GLCD_Width8
;Main_Ind=Main_Ind+1           'allo 0 del SDData_Buffer corrisponde 1 EPDBuffer
	lds	SysTemp3,MAIN_IND
	inc	SysTemp3
	sts	MAIN_IND,SysTemp3
	lds	SysTemp3,MAIN_IND_H
	brne	PC + 2
	inc	SysTemp3
	sts	MAIN_IND_H,SysTemp3
;if SDBuff_Ind>511 then
	lds	SysWORDTempB,SDBUFF_IND
	lds	SysWORDTempB_H,SDBUFF_IND_H
	ldi	SysWORDTempA,255
	ldi	SysWORDTempA_H,1
	call	SysCompLessThan16
	sbrs	SysByteTempX,0
	rjmp	ENDIF12
;SDLocation=SDlocation+1
	lds	SysTemp3,SDLOCATION
	inc	SysTemp3
	sts	SDLOCATION,SysTemp3
	lds	SysTemp3,SDLOCATION_H
	brne	PC + 2
	inc	SysTemp3
	sts	SDLOCATION_H,SysTemp3
	lds	SysTemp3,SDLOCATION_U
	brne	PC + 2
	inc	SysTemp3
	sts	SDLOCATION_U,SysTemp3
	lds	SysTemp3,SDLOCATION_E
	brne	PC + 2
	inc	SysTemp3
	sts	SDLOCATION_E,SysTemp3
;SDRead_Block(SDLocation)
	lds	SysValueCopy,SDLOCATION
	sts	BLOCK_START,SysValueCopy
	lds	SysValueCopy,SDLOCATION_H
	sts	BLOCK_START_H,SysValueCopy
	lds	SysValueCopy,SDLOCATION_U
	sts	BLOCK_START_U,SysValueCopy
	lds	SysValueCopy,SDLOCATION_E
	sts	BLOCK_START_E,SysValueCopy
	call	SDREAD_BLOCK
;SDBuff_ind=0
	ldi	SysValueCopy,0
	sts	SDBUFF_IND,SysValueCopy
	sts	SDBUFF_IND_H,SysValueCopy
;end if
ENDIF12:
;Main_Ind_trans=Main_Ind-Inf_Addr_Buff
	lds	SysTemp3,MAIN_IND
	lds	SysTemp1,INF_ADDR_BUFF
	sub	SysTemp3,SysTemp1
	sts	MAIN_IND_TRANS,SysTemp3
	lds	SysTemp3,MAIN_IND_H
	lds	SysTemp1,INF_ADDR_BUFF_H
	sbc	SysTemp3,SysTemp1
	sts	MAIN_IND_TRANS_H,SysTemp3
;if Main_Ind_trans<=BuffWidth then
;EPD_Buffer(Main_Ind_trans)=SDDataBuffer(SDBuff_Ind)
;end if
;SDBuff_Ind=SDBuff_Ind+1
	lds	SysTemp3,SDBUFF_IND
	inc	SysTemp3
	sts	SDBUFF_IND,SysTemp3
	lds	SysTemp3,SDBUFF_IND_H
	brne	PC + 2
	inc	SysTemp3
	sts	SDBUFF_IND_H,SysTemp3
;next
;next
;SET GLCD_CS OFF
	cbi	PORTB,2
;SET SD_Adaper_CS ON
	sbi	PORTB,2
;wait 2 ms
	ldi	SysWaitTempMS,2
	ldi	SysWaitTempMS_H,0
	call	Delay_MS
;NEXT
	lds	SysCalcTempA,_GLCDPAGE
	cpi	SysCalcTempA,212
	brsh	ENDIF13
	rjmp	SysForLoop1
ENDIF13:
SysForLoopEnd1:
;GLCD_Close_PageTransaction                 'Close Transaction
;Draw_Line(1,15," "):Draw_Line(1,15," ")
	ldi	SysValueCopy,1
	sts	LINE_TYPE,SysValueCopy
	ldi	SysValueCopy,15
	sts	N_CHAR,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable10<<1)
	ldi	SysReadA_H,high(StringTable10<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysCHARHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysCHARHandler_H,SysValueCopy
	call	DRAW_LINE
	ldi	SysValueCopy,1
	sts	LINE_TYPE,SysValueCopy
	ldi	SysValueCopy,15
	sts	N_CHAR,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable10<<1)
	ldi	SysReadA_H,high(StringTable10<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysCHARHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysCHARHandler_H,SysValueCopy
	call	DRAW_LINE
;end if
ENDIF10:
;else
	rjmp	ENDIF4
ELSE4_1:
;
;SET SD_Adaper_CS ON
;
;GLCD_Open_PageTransaction ( upperPage, lowerPage )
;
;select case SD_Counter
;
;case 1   :   Box_example
;
;'        case 2   :   String_example
;'
;'        case 3   :   BigString_example
;'
;'        case 4   :   PrintString_example
;'
;'        case 5   :   Complex_Graph_example
;
;end select
;
;GLCD_Close_PageTransaction                 'Close Transaction
;end if
ENDIF4:
;goto CARD_Operation_Root
	rjmp	CARD_OPERATION_ROOT
;end
	rjmp	BASPROGRAMEND
;____________________________________________________________________________________
;spi constant used equates to 13
	ldi	SysValueCopy,13
	sts	SPICURRENTMODE,SysValueCopy
	ldi	SysValueCopy,0
	sts	SPICLOCKMODE,SysValueCopy
	call	SPIMODE241
BASPROGRAMEND:
	sleep
	rjmp	BASPROGRAMEND

;********************************************************************************

;Source: MySDLib.h (178)
CALLACMD41:
;SD_Counter=0
	ldi	SysValueCopy,0
	sts	SD_COUNTER,SysValueCopy
	sts	SD_COUNTER_H,SysValueCopy
;SD_Counter1=0
	ldi	SysValueCopy,0
	sts	SD_COUNTER1,SysValueCopy
	sts	SD_COUNTER1_H,SysValueCopy
;repeat 1000'  do while SDResponse <> 0x00
	ldi	SysValueCopy,232
	sts	SysRepeatTemp3,SysValueCopy
	ldi	SysValueCopy,4
	sts	SysRepeatTemp3_H,SysValueCopy
SysRepeatLoop3:
;SD_Counter=SD_Counter+1
	lds	SysTemp3,SD_COUNTER
	inc	SysTemp3
	sts	SD_COUNTER,SysTemp3
	lds	SysTemp3,SD_COUNTER_H
	brne	PC + 2
	inc	SysTemp3
	sts	SD_COUNTER_H,SysTemp3
;SDResponse=100
	ldi	SysValueCopy,100
	sts	SDRESPONSE,SysValueCopy
;SDResponse2=100
	ldi	SysValueCopy,100
	sts	SDRESPONSE2,SysValueCopy
;SD_Counter1=1
	ldi	SysValueCopy,1
	sts	SD_COUNTER1,SysValueCopy
	ldi	SysValueCopy,0
	sts	SD_COUNTER1_H,SysValueCopy
;SendCommand(0x77, 0x00000000, 0xFF)       'CMD55
	ldi	SysValueCopy,119
	sts	CODE,SysValueCopy
	ldi	SysValueCopy,0
	sts	ARG,SysValueCopy
	sts	ARG_H,SysValueCopy
	sts	ARG_U,SysValueCopy
	sts	ARG_E,SysValueCopy
	ldi	SysValueCopy,255
	sts	CRC,SysValueCopy
	call	SENDCOMMAND
;do until SDResponse2<2 or SD_Counter1 > 100
SysDoLoop_S5:
	lds	SysBYTETempA,sdresponse2
	ldi	SysBYTETempB,2
	call	SysCompLessThan
	mov	SysTemp3,SysByteTempX
	lds	SysWORDTempB,sd_counter1
	lds	SysWORDTempB_H,sd_counter1_H
	ldi	SysWORDTempA,100
	ldi	SysWORDTempA_H,0
	call	SysCompLessThan16
	mov	SysTemp2,SysByteTempX
	or	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	sbrc	SysTemp1,0
	rjmp	SysDoLoop_E5
;GetSDResponse(1,SDResponse2)
	ldi	SysValueCopy,1
	sts	NRESPONSE,SysValueCopy
	lds	SysValueCopy,SDRESPONSE2
	sts	SDRESP,SysValueCopy
	call	GETSDRESPONSE
	lds	SysValueCopy,SDRESP
	sts	SDRESPONSE2,SysValueCopy
;SD_Counter1=SD_Counter1+1
	lds	SysTemp3,SD_COUNTER1
	inc	SysTemp3
	sts	SD_COUNTER1,SysTemp3
	lds	SysTemp3,SD_COUNTER1_H
	brne	PC + 2
	inc	SysTemp3
	sts	SD_COUNTER1_H,SysTemp3
;loop
	rjmp	SysDoLoop_S5
SysDoLoop_E5:
;SD_Counter1=1
	ldi	SysValueCopy,1
	sts	SD_COUNTER1,SysValueCopy
	ldi	SysValueCopy,0
	sts	SD_COUNTER1_H,SysValueCopy
;SendCommand(0x69, 0x40000000, 0xFF)       'CMD41
	ldi	SysValueCopy,105
	sts	CODE,SysValueCopy
	ldi	SysValueCopy,0
	sts	ARG,SysValueCopy
	sts	ARG_H,SysValueCopy
	sts	ARG_U,SysValueCopy
	ldi	SysValueCopy,64
	sts	ARG_E,SysValueCopy
	ldi	SysValueCopy,255
	sts	CRC,SysValueCopy
	call	SENDCOMMAND
;do until SDResponse<2 or SD_Counter1 > 100
SysDoLoop_S6:
	lds	SysBYTETempA,sdresponse
	ldi	SysBYTETempB,2
	call	SysCompLessThan
	mov	SysTemp3,SysByteTempX
	lds	SysWORDTempB,sd_counter1
	lds	SysWORDTempB_H,sd_counter1_H
	ldi	SysWORDTempA,100
	ldi	SysWORDTempA_H,0
	call	SysCompLessThan16
	mov	SysTemp2,SysByteTempX
	or	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	sbrc	SysTemp1,0
	rjmp	SysDoLoop_E6
;GetSDResponse(1,SDResponse)
	ldi	SysValueCopy,1
	sts	NRESPONSE,SysValueCopy
	lds	SysValueCopy,SDRESPONSE
	sts	SDRESP,SysValueCopy
	call	GETSDRESPONSE
	lds	SysValueCopy,SDRESP
	sts	SDRESPONSE,SysValueCopy
;SD_Counter1=SD_Counter1+1
	lds	SysTemp3,SD_COUNTER1
	inc	SysTemp3
	sts	SD_COUNTER1,SysTemp3
	lds	SysTemp3,SD_COUNTER1_H
	brne	PC + 2
	inc	SysTemp3
	sts	SD_COUNTER1_H,SysTemp3
;loop
	rjmp	SysDoLoop_S6
SysDoLoop_E6:
;set SD_Adaper_CS ON
;if SDResponse=0  then
	lds	SysCalcTempA,SDRESPONSE
	tst	SysCalcTempA
	brne	ENDIF25
;exit repeat
	rjmp	SysRepeatLoopEnd3
;end if
ENDIF25:
;end repeat
	lds	SysTemp2,SysRepeatTemp3
	lds	SysTemp2_H,SysRepeatTemp3_H
	dec	SysTemp2
	sts	SysRepeatTemp3,SysTemp2
	breq	PC + 2
	rjmp	SysRepeatLoop3
	dec	SysTemp2_H
	sts	SysRepeatTemp3_H,SysTemp2_H
	breq	PC + 2
	rjmp	SysRepeatLoop3
SysRepeatLoopEnd3:
;sertxd(1,"-ACMD41 ","Executed.",0):sertxd(0," after ",SD_Counter,0):sertxd(0," attempts","   ",0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM5)
	ldi	SysStringB_H,high(SYSSTRINGPARAM5)
	ldi	SysReadA,low(StringTable68<<1)
	ldi	SysReadA_H,high(StringTable68<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable69<<1)
	ldi	SysReadA_H,high(StringTable69<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM5)
	ldi	SysStringB_H,high(SYSSTRINGPARAM5)
	ldi	SysReadA,low(StringTable70<<1)
	ldi	SysReadA_H,high(StringTable70<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysValueCopy,SD_COUNTER
	sts	INPUTW,SysValueCopy
	lds	SysValueCopy,SD_COUNTER_H
	sts	INPUTW_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD9
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM5)
	ldi	SysStringB_H,high(SYSSTRINGPARAM5)
	ldi	SysReadA,low(StringTable71<<1)
	ldi	SysReadA_H,high(StringTable71<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable58<<1)
	ldi	SysReadA_H,high(StringTable58<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
;sertxd(1,"        CMD41 Response=",SDResponse,0):sertxd(0," CMD55 Response=",SDResponse2,0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM5)
	ldi	SysStringB_H,high(SYSSTRINGPARAM5)
	ldi	SysReadA,low(StringTable72<<1)
	ldi	SysReadA_H,high(StringTable72<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysValueCopy,SDRESPONSE
	sts	INPUTB,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD8
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM5)
	ldi	SysStringB_H,high(SYSSTRINGPARAM5)
	ldi	SysReadA,low(StringTable73<<1)
	ldi	SysReadA_H,high(StringTable73<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysValueCopy,SDRESPONSE2
	sts	INPUTB,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	jmp	SERTXD8

;********************************************************************************

;Source: MySDLib.h (118)
CALLCMD0:
;HserPrint "    CMD0"
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable46<<1)
	ldi	SysReadA_H,high(StringTable46<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	call	HSERPRINT286
;SET SD_Adaper_CS OFF
	cbi	PORTB,2
;wait 500 ms
	ldi	SysWaitTempMS,244
	ldi	SysWaitTempMS_H,1
	call	Delay_MS
;SET SD_Adaper_CS ON
	sbi	PORTB,2
;sembra necessario
;do while SDResponse <> 0x01
SysDoLoop_S2:
	lds	SysCalcTempA,SDRESPONSE
	cpi	SysCalcTempA,1
	brne	PC + 2
	rjmp	SysDoLoop_E2
;SD_Counter=0
	ldi	SysValueCopy,0
	sts	SD_COUNTER,SysValueCopy
	sts	SD_COUNTER_H,SysValueCopy
;SET SD_Adaper_CS ON
	sbi	PORTB,2
;SendDummyBytes (10)         'lascia SD_Adaper_CS Off
	ldi	SysValueCopy,10
	sts	N_BYTES,SysValueCopy
	call	SENDDUMMYBYTES
;wait 50 ms
	ldi	SysWaitTempMS,50
	ldi	SysWaitTempMS_H,0
	call	Delay_MS
;SendCommand(0x40, 0x00000000, 0x95)
	ldi	SysValueCopy,64
	sts	CODE,SysValueCopy
	ldi	SysValueCopy,0
	sts	ARG,SysValueCopy
	sts	ARG_H,SysValueCopy
	sts	ARG_U,SysValueCopy
	sts	ARG_E,SysValueCopy
	ldi	SysValueCopy,149
	sts	CRC,SysValueCopy
	call	SENDCOMMAND
;do while SDResponse <> 0x01 and SD_Counter<50
SysDoLoop_S3:
	lds	SysBYTETempA,sdresponse
	ldi	SysBYTETempB,1
	call	SysCompEqual
	com	SysByteTempX
	mov	SysTemp3,SysByteTempX
	lds	SysWORDTempA,sd_counter
	lds	SysWORDTempA_H,sd_counter_H
	ldi	SysWORDTempB,50
	ldi	SysWORDTempB_H,0
	call	SysCompLessThan16
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	sbrs	SysTemp1,0
	rjmp	SysDoLoop_E3
;GetSDResponse(1,SDResponse)
	ldi	SysValueCopy,1
	sts	NRESPONSE,SysValueCopy
	lds	SysValueCopy,SDRESPONSE
	sts	SDRESP,SysValueCopy
	call	GETSDRESPONSE
	lds	SysValueCopy,SDRESP
	sts	SDRESPONSE,SysValueCopy
;Loop
	rjmp	SysDoLoop_S3
SysDoLoop_E3:
;Loop
	rjmp	SysDoLoop_S2
SysDoLoop_E2:
;SET SD_Adaper_CS ON
	sbi	PORTB,2
;sertxd(1,"-CMD0 ","  Executed",0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable47<<1)
	ldi	SysReadA_H,high(StringTable47<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM5)
	ldi	SysStringB_H,high(SYSSTRINGPARAM5)
	ldi	SysReadA,low(StringTable48<<1)
	ldi	SysReadA_H,high(StringTable48<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM5)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM5)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	jmp	SERTXD7

;********************************************************************************

;Source: MySDLib.h (313)
CALLCMD16:
;SDResponse=100                  'Block size setting
	ldi	SysValueCopy,100
	sts	SDRESPONSE,SysValueCopy
;SD_Counter=0
	ldi	SysValueCopy,0
	sts	SD_COUNTER,SysValueCopy
	sts	SD_COUNTER_H,SysValueCopy
;repeat 100
	ldi	SysValueCopy,100
	sts	SysRepeatTemp10,SysValueCopy
SysRepeatLoop10:
;SD_Counter=SD_Counter+1
	lds	SysTemp3,SD_COUNTER
	inc	SysTemp3
	sts	SD_COUNTER,SysTemp3
	lds	SysTemp3,SD_COUNTER_H
	brne	PC + 2
	inc	SysTemp3
	sts	SD_COUNTER_H,SysTemp3
;SD_Counter1=0
	ldi	SysValueCopy,0
	sts	SD_COUNTER1,SysValueCopy
	sts	SD_COUNTER1_H,SysValueCopy
;sendCommand(0x51,512,0xFF)
	ldi	SysValueCopy,81
	sts	CODE,SysValueCopy
	ldi	SysValueCopy,0
	sts	ARG,SysValueCopy
	ldi	SysValueCopy,2
	sts	ARG_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	ARG_U,SysValueCopy
	sts	ARG_E,SysValueCopy
	ldi	SysValueCopy,255
	sts	CRC,SysValueCopy
	call	SENDCOMMAND
;do until SDResponse=0 or SD_Counter1 > 100
SysDoLoop_S7:
	lds	SysBYTETempA,sdresponse
	ldi	SysBYTETempB,0
	call	SysCompEqual
	mov	SysTemp3,SysByteTempX
	lds	SysWORDTempB,sd_counter1
	lds	SysWORDTempB_H,sd_counter1_H
	ldi	SysWORDTempA,100
	ldi	SysWORDTempA_H,0
	call	SysCompLessThan16
	mov	SysTemp2,SysByteTempX
	or	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	sbrc	SysTemp1,0
	rjmp	SysDoLoop_E7
;GetSDResponse(1,SDResponse)
	ldi	SysValueCopy,1
	sts	NRESPONSE,SysValueCopy
	lds	SysValueCopy,SDRESPONSE
	sts	SDRESP,SysValueCopy
	call	GETSDRESPONSE
	lds	SysValueCopy,SDRESP
	sts	SDRESPONSE,SysValueCopy
;SD_Counter1=SD_Counter1+1
	lds	SysTemp3,SD_COUNTER1
	inc	SysTemp3
	sts	SD_COUNTER1,SysTemp3
	lds	SysTemp3,SD_COUNTER1_H
	brne	PC + 2
	inc	SysTemp3
	sts	SD_COUNTER1_H,SysTemp3
;loop
	rjmp	SysDoLoop_S7
SysDoLoop_E7:
;if SDResponse=0 then
	lds	SysCalcTempA,SDRESPONSE
	tst	SysCalcTempA
	brne	ENDIF34
;exit repeat
	rjmp	SysRepeatLoopEnd10
;end if
ENDIF34:
;End Repeat
	lds	SysTemp3,SysRepeatTemp10
	dec	SysTemp3
	sts	SysRepeatTemp10,SysTemp3
	breq	PC + 2
	rjmp	SysRepeatLoop10
SysRepeatLoopEnd10:
;if SDResponse=0 then
	lds	SysCalcTempA,SDRESPONSE
	tst	SysCalcTempA
	brne	ELSE35_1
;sertxd(1,"-CMD16  OK  Executed","  ",0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM5)
	ldi	SysStringB_H,high(SYSSTRINGPARAM5)
	ldi	SysReadA,low(StringTable91<<1)
	ldi	SysReadA_H,high(StringTable91<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable92<<1)
	ldi	SysReadA_H,high(StringTable92<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
;else
	rjmp	ENDIF35
ELSE35_1:
;sertxd(1,"-CMD16  !OK Executed","  ",0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM5)
	ldi	SysStringB_H,high(SYSSTRINGPARAM5)
	ldi	SysReadA,low(StringTable93<<1)
	ldi	SysReadA_H,high(StringTable93<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable92<<1)
	ldi	SysReadA_H,high(StringTable92<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
;end if
ENDIF35:
;sertxd(0,"       Response=",SDResponse,0):sertxd(0,", SD_Counter=",SD_Counter,0)
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM5)
	ldi	SysStringB_H,high(SYSSTRINGPARAM5)
	ldi	SysReadA,low(StringTable94<<1)
	ldi	SysReadA_H,high(StringTable94<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysValueCopy,SDRESPONSE
	sts	INPUTB,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD8
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM5)
	ldi	SysStringB_H,high(SYSSTRINGPARAM5)
	ldi	SysReadA,low(StringTable95<<1)
	ldi	SysReadA_H,high(StringTable95<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysValueCopy,SD_COUNTER
	sts	INPUTW,SysValueCopy
	lds	SysValueCopy,SD_COUNTER_H
	sts	INPUTW_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	jmp	SERTXD9

;********************************************************************************

;Source: MySDLib.h (208)
CALLCMD58:
;INITSucc=0
	ldi	SysValueCopy,0
	sts	INITSUCC,SysValueCopy
;SDResponse=100
	ldi	SysValueCopy,100
	sts	SDRESPONSE,SysValueCopy
;SDResponse2=100
;SDResponse3=100
;SD_Counter=0
	ldi	SysValueCopy,0
	sts	SD_COUNTER,SysValueCopy
	sts	SD_COUNTER_H,SysValueCopy
;repeat 1000
	ldi	SysValueCopy,232
	sts	SysRepeatTemp4,SysValueCopy
	ldi	SysValueCopy,4
	sts	SysRepeatTemp4_H,SysValueCopy
SysRepeatLoop4:
;SD_Counter=SD_Counter+1
	lds	SysTemp3,SD_COUNTER
	inc	SysTemp3
	sts	SD_COUNTER,SysTemp3
	lds	SysTemp3,SD_COUNTER_H
	brne	PC + 2
	inc	SysTemp3
	sts	SD_COUNTER_H,SysTemp3
;SendCommand(0x7A, 0x00000000, 0xFF) 'return R3 response
	ldi	SysValueCopy,122
	sts	CODE,SysValueCopy
	ldi	SysValueCopy,0
	sts	ARG,SysValueCopy
	sts	ARG_H,SysValueCopy
	sts	ARG_U,SysValueCopy
	sts	ARG_E,SysValueCopy
	ldi	SysValueCopy,255
	sts	CRC,SysValueCopy
	call	SENDCOMMAND
;repeat 50
	ldi	SysValueCopy,50
	sts	SysRepeatTemp5,SysValueCopy
SysRepeatLoop5:
;GetSDResponse(1,SDResponse)
	ldi	SysValueCopy,1
	sts	NRESPONSE,SysValueCopy
	lds	SysValueCopy,SDRESPONSE
	sts	SDRESP,SysValueCopy
	call	GETSDRESPONSE
	lds	SysValueCopy,SDRESP
	sts	SDRESPONSE,SysValueCopy
;if SDResponse=0 then
	lds	SysCalcTempA,SDRESPONSE
	tst	SysCalcTempA
	brne	ENDIF26
;exit repeat
	rjmp	SysRepeatLoopEnd5
;end if
ENDIF26:
;end repeat
	lds	SysTemp3,SysRepeatTemp5
	dec	SysTemp3
	sts	SysRepeatTemp5,SysTemp3
	brne	SysRepeatLoop5
SysRepeatLoopEnd5:
;repeat 50
	ldi	SysValueCopy,50
	sts	SysRepeatTemp5,SysValueCopy
SysRepeatLoop6:
;GetSDResponse(1,SDResponse2)
	ldi	SysValueCopy,1
	sts	NRESPONSE,SysValueCopy
	lds	SysValueCopy,SDRESPONSE2
	sts	SDRESP,SysValueCopy
	call	GETSDRESPONSE
	lds	SysValueCopy,SDRESP
	sts	SDRESPONSE2,SysValueCopy
;if SDResponse2<>255 then
	lds	SysCalcTempA,SDRESPONSE2
	cpi	SysCalcTempA,255
	breq	ENDIF27
;exit repeat
	rjmp	SysRepeatLoopEnd6
;end if
ENDIF27:
;end repeat
	lds	SysTemp3,SysRepeatTemp5
	dec	SysTemp3
	sts	SysRepeatTemp5,SysTemp3
	brne	SysRepeatLoop6
SysRepeatLoopEnd6:
;repeat 50
	ldi	SysValueCopy,50
	sts	SysRepeatTemp5,SysValueCopy
SysRepeatLoop7:
;GetSDResponse(1,SDResponse3)
	ldi	SysValueCopy,1
	sts	NRESPONSE,SysValueCopy
	lds	SysValueCopy,SDRESPONSE3
	sts	SDRESP,SysValueCopy
	call	GETSDRESPONSE
	lds	SysValueCopy,SDRESP
	sts	SDRESPONSE3,SysValueCopy
;if SDResponse3<>255 then
	lds	SysCalcTempA,SDRESPONSE3
	cpi	SysCalcTempA,255
	breq	ENDIF28
;exit repeat
	rjmp	SysRepeatLoopEnd7
;end if
ENDIF28:
;end repeat
	lds	SysTemp3,SysRepeatTemp5
	dec	SysTemp3
	sts	SysRepeatTemp5,SysTemp3
	brne	SysRepeatLoop7
SysRepeatLoopEnd7:
;repeat 50
	ldi	SysValueCopy,50
	sts	SysRepeatTemp5,SysValueCopy
SysRepeatLoop8:
;GetSDResponse(1,SDResponse4)
	ldi	SysValueCopy,1
	sts	NRESPONSE,SysValueCopy
	lds	SysValueCopy,SDRESPONSE4
	sts	SDRESP,SysValueCopy
	call	GETSDRESPONSE
	lds	SysValueCopy,SDRESP
	sts	SDRESPONSE4,SysValueCopy
;if SDResponse4<>255 then
	lds	SysCalcTempA,SDRESPONSE4
	cpi	SysCalcTempA,255
	breq	ENDIF29
;exit repeat
	rjmp	SysRepeatLoopEnd8
;end if
ENDIF29:
;end repeat
	lds	SysTemp3,SysRepeatTemp5
	dec	SysTemp3
	sts	SysRepeatTemp5,SysTemp3
	brne	SysRepeatLoop8
SysRepeatLoopEnd8:
;repeat 50
	ldi	SysValueCopy,50
	sts	SysRepeatTemp5,SysValueCopy
SysRepeatLoop9:
;GetSDResponse(1,SDResponse5)
	ldi	SysValueCopy,1
	sts	NRESPONSE,SysValueCopy
	lds	SysValueCopy,SDRESPONSE5
	sts	SDRESP,SysValueCopy
	call	GETSDRESPONSE
	lds	SysValueCopy,SDRESP
	sts	SDRESPONSE5,SysValueCopy
;if SDResponse2<>255 then
	lds	SysCalcTempA,SDRESPONSE2
	cpi	SysCalcTempA,255
	breq	ENDIF30
;exit repeat
	rjmp	SysRepeatLoopEnd9
;end if
ENDIF30:
;end repeat
	lds	SysTemp3,SysRepeatTemp5
	dec	SysTemp3
	sts	SysRepeatTemp5,SysTemp3
	brne	SysRepeatLoop9
SysRepeatLoopEnd9:
;if SDResponse=0 then
	lds	SysCalcTempA,SDRESPONSE
	tst	SysCalcTempA
	brne	ENDIF31
;exit repeat
	rjmp	SysRepeatLoopEnd4
;end if
ENDIF31:
;end repeat
	lds	SysTemp1,SysRepeatTemp4
	lds	SysTemp1_H,SysRepeatTemp4_H
	dec	SysTemp1
	sts	SysRepeatTemp4,SysTemp1
	breq	PC + 2
	rjmp	SysRepeatLoop4
	dec	SysTemp1_H
	sts	SysRepeatTemp4_H,SysTemp1_H
	breq	PC + 2
	rjmp	SysRepeatLoop4
SysRepeatLoopEnd4:
;set SD_Adaper_CS ON
;if  SDResponse=0 then
	lds	SysCalcTempA,SDRESPONSE
	tst	SysCalcTempA
	breq	PC + 2
	rjmp	ELSE32_1
;INITSucc=1
	ldi	SysValueCopy,1
	sts	INITSUCC,SysValueCopy
;sertxd(1,"-CMD58 "," Executed OK. ",0):sertxd(0,"Attempts number=",SD_SD_Counter,0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable74<<1)
	ldi	SysReadA_H,high(StringTable74<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM5)
	ldi	SysStringB_H,high(SYSSTRINGPARAM5)
	ldi	SysReadA,low(StringTable75<<1)
	ldi	SysReadA_H,high(StringTable75<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM5)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM5)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable76<<1)
	ldi	SysReadA_H,high(StringTable76<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysValueCopy,SD_SD_COUNTER
	sts	INPUTB,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD8
;sertxd(1,"        First SDResponse=",SDResponse,0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable77<<1)
	ldi	SysReadA_H,high(StringTable77<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysValueCopy,SDRESPONSE
	sts	INPUTB,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD8
;sertxd(1,"        SDResponses2-3-4-5=(",SDResponse2,0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable78<<1)
	ldi	SysReadA_H,high(StringTable78<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysValueCopy,SDRESPONSE2
	sts	INPUTB,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD8
;sertxd(0,",",SDResponse3,0):sertxd(0,",",SDResponse4,0):sertxd(0,",",SDResponse5,0):sertxd(0,")"," ",0)
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable79<<1)
	ldi	SysReadA_H,high(StringTable79<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysValueCopy,SDRESPONSE3
	sts	INPUTB,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD8
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable79<<1)
	ldi	SysReadA_H,high(StringTable79<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysValueCopy,SDRESPONSE4
	sts	INPUTB,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD8
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable79<<1)
	ldi	SysReadA_H,high(StringTable79<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysValueCopy,SDRESPONSE5
	sts	INPUTB,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD8
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable80<<1)
	ldi	SysReadA_H,high(StringTable80<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM5)
	ldi	SysStringB_H,high(SYSSTRINGPARAM5)
	ldi	SysReadA,low(StringTable10<<1)
	ldi	SysReadA_H,high(StringTable10<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM5)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM5)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
;If SDResponse2.6=0 then       'uses byte address data (nota 10 pag 222)
	lds	SysBitTest,SDRESPONSE2
	sbrc	SysBitTest,6
	rjmp	ELSE33_1
;sertxd(1,"        The Card is V2 SDSC ","with Standard capacity (CCS=0)",0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable81<<1)
	ldi	SysReadA_H,high(StringTable81<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM5)
	ldi	SysStringB_H,high(SYSSTRINGPARAM5)
	ldi	SysReadA,low(StringTable82<<1)
	ldi	SysReadA_H,high(StringTable82<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM5)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM5)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
;else                          'uses block address data
	rjmp	ENDIF33
ELSE33_1:
;sertxd(1,"        The Card is V2 SCXC or"," SDHC with Extended capacity (CCS=1)",0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable83<<1)
	ldi	SysReadA_H,high(StringTable83<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM5)
	ldi	SysStringB_H,high(SYSSTRINGPARAM5)
	ldi	SysReadA,low(StringTable84<<1)
	ldi	SysReadA_H,high(StringTable84<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM5)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM5)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
;end if
ENDIF33:
;else
	rjmp	ENDIF32
ELSE32_1:
;SET SD_Adaper_CS ON
	sbi	PORTB,2
;sertxd(1,"-CMD58 "," Executed !OK.",0):sertxd(0,"N. attempts=",SD_Counter,0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable74<<1)
	ldi	SysReadA_H,high(StringTable74<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM5)
	ldi	SysStringB_H,high(SYSSTRINGPARAM5)
	ldi	SysReadA,low(StringTable85<<1)
	ldi	SysReadA_H,high(StringTable85<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM5)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM5)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable86<<1)
	ldi	SysReadA_H,high(StringTable86<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysValueCopy,SD_COUNTER
	sts	INPUTW,SysValueCopy
	lds	SysValueCopy,SD_COUNTER_H
	sts	INPUTW_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD9
;sertxd(1,"*","*",0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable87<<1)
	ldi	SysReadA_H,high(StringTable87<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM5)
	ldi	SysStringB_H,high(SYSSTRINGPARAM5)
	ldi	SysReadA,low(StringTable87<<1)
	ldi	SysReadA_H,high(StringTable87<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM5)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM5)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
;end if
ENDIF32:
	ret

;********************************************************************************

;Source: MySDLib.h (138)
CALLCMD8:
;SDResponse=100
	ldi	SysValueCopy,100
	sts	SDRESPONSE,SysValueCopy
;Counter=0
	ldi	SysValueCopy,0
	sts	COUNTER,SysValueCopy
;do until SDResponse = 0x01 or SDResponse = 0x05 or SD_Counter >50
SysDoLoop_S4:
	lds	SysBYTETempA,sdresponse
	ldi	SysBYTETempB,1
	call	SysCompEqual
	mov	SysTemp3,SysByteTempX
	lds	SysBYTETempA,sdresponse
	ldi	SysBYTETempB,5
	call	SysCompEqual
	mov	SysTemp1,SysByteTempX
	lds	SysWORDTempB,sd_counter
	lds	SysWORDTempB_H,sd_counter_H
	ldi	SysWORDTempA,50
	ldi	SysWORDTempA_H,0
	call	SysCompLessThan16
	or	SysTemp1,SysTemp3
	mov	SysTemp2,SysTemp1
	mov	SysTemp1,SysByteTempX
	or	SysTemp1,SysTemp2
	mov	SysTemp3,SysTemp1
	sbrc	SysTemp3,0
	rjmp	SysDoLoop_E4
;SD_Counter=SD_Counter+1
	lds	SysTemp3,SD_COUNTER
	inc	SysTemp3
	sts	SD_COUNTER,SysTemp3
	lds	SysTemp3,SD_COUNTER_H
	brne	PC + 2
	inc	SysTemp3
	sts	SD_COUNTER_H,SysTemp3
;SendCommand(0x48, 0x000001AA, 0x87) 'return R7 response
	ldi	SysValueCopy,72
	sts	CODE,SysValueCopy
	ldi	SysValueCopy,170
	sts	ARG,SysValueCopy
	ldi	SysValueCopy,1
	sts	ARG_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	ARG_U,SysValueCopy
	sts	ARG_E,SysValueCopy
	ldi	SysValueCopy,135
	sts	CRC,SysValueCopy
	call	SENDCOMMAND
;GetSDResponse(1,SDResponse)
	ldi	SysValueCopy,1
	sts	NRESPONSE,SysValueCopy
	lds	SysValueCopy,SDRESPONSE
	sts	SDRESP,SysValueCopy
	call	GETSDRESPONSE
	lds	SysValueCopy,SDRESP
	sts	SDRESPONSE,SysValueCopy
;GetSDResponse(3,SDResponse2)
	ldi	SysValueCopy,3
	sts	NRESPONSE,SysValueCopy
	lds	SysValueCopy,SDRESPONSE2
	sts	SDRESP,SysValueCopy
	call	GETSDRESPONSE
	lds	SysValueCopy,SDRESP
	sts	SDRESPONSE2,SysValueCopy
;GetSDResponse(1,SDResponse3)
	ldi	SysValueCopy,1
	sts	NRESPONSE,SysValueCopy
	lds	SysValueCopy,SDRESPONSE3
	sts	SDRESP,SysValueCopy
	call	GETSDRESPONSE
	lds	SysValueCopy,SDRESP
	sts	SDRESPONSE3,SysValueCopy
;GetSDResponse(1,SDData)
	ldi	SysValueCopy,1
	sts	NRESPONSE,SysValueCopy
	lds	SysValueCopy,SDDATA
	sts	SDRESP,SysValueCopy
	call	GETSDRESPONSE
	lds	SysValueCopy,SDRESP
	sts	SDDATA,SysValueCopy
;loop
	rjmp	SysDoLoop_S4
SysDoLoop_E4:
;SET SD_Adaper_CS ON
	sbi	PORTB,2
;if SD_Counter >50  then
	lds	SysWORDTempB,SD_COUNTER
	lds	SysWORDTempB_H,SD_COUNTER_H
	ldi	SysWORDTempA,50
	ldi	SysWORDTempA_H,0
	call	SysCompLessThan16
	sbrs	SysByteTempX,0
	rjmp	ELSE20_1
;sertxd(1,"-CMD8 ","failed.",0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM5)
	ldi	SysStringB_H,high(SYSSTRINGPARAM5)
	ldi	SysReadA,low(StringTable49<<1)
	ldi	SysReadA_H,high(StringTable49<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable50<<1)
	ldi	SysReadA_H,high(StringTable50<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
;else
	rjmp	ENDIF20
ELSE20_1:
;if SDResponse=0x01 then
	lds	SysCalcTempA,SDRESPONSE
	cpi	SysCalcTempA,1
	breq	PC + 2
	rjmp	ENDIF21
;sertxd(1,"-CMD8 ","  Executed.",0):sertxd(1,"        Card"," is V2",0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM5)
	ldi	SysStringB_H,high(SYSSTRINGPARAM5)
	ldi	SysReadA,low(StringTable49<<1)
	ldi	SysReadA_H,high(StringTable49<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable51<<1)
	ldi	SysReadA_H,high(StringTable51<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM5)
	ldi	SysStringB_H,high(SYSSTRINGPARAM5)
	ldi	SysReadA,low(StringTable52<<1)
	ldi	SysReadA_H,high(StringTable52<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable53<<1)
	ldi	SysReadA_H,high(StringTable53<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
;end if
ENDIF21:
;if SDResponse=0x05 then
	lds	SysCalcTempA,SDRESPONSE
	cpi	SysCalcTempA,5
	breq	PC + 2
	rjmp	ENDIF22
;sertxd(1,"-CMD8  "," Executed.",0):sertxd(1,"        Card"," is V1",0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM5)
	ldi	SysStringB_H,high(SYSSTRINGPARAM5)
	ldi	SysReadA,low(StringTable54<<1)
	ldi	SysReadA_H,high(StringTable54<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable55<<1)
	ldi	SysReadA_H,high(StringTable55<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM5)
	ldi	SysStringB_H,high(SYSSTRINGPARAM5)
	ldi	SysReadA,low(StringTable52<<1)
	ldi	SysReadA_H,high(StringTable52<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable56<<1)
	ldi	SysReadA_H,high(StringTable56<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
;end if
ENDIF22:
;If SDResponse3=0xAA then
	lds	SysCalcTempA,SDRESPONSE3
	cpi	SysCalcTempA,170
	breq	PC + 2
	rjmp	ELSE23_1
;sertxd(1,"    ","   ",0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM5)
	ldi	SysStringB_H,high(SYSSTRINGPARAM5)
	ldi	SysReadA,low(StringTable57<<1)
	ldi	SysReadA_H,high(StringTable57<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable58<<1)
	ldi	SysReadA_H,high(StringTable58<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
;sertxd(0," The CMD8 check ","pattern is confirmed",0)
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM5)
	ldi	SysStringB_H,high(SYSSTRINGPARAM5)
	ldi	SysReadA,low(StringTable59<<1)
	ldi	SysReadA_H,high(StringTable59<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable60<<1)
	ldi	SysReadA_H,high(StringTable60<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
;else
	rjmp	ENDIF23
ELSE23_1:
;sertxd(1,"    ","   ",0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM5)
	ldi	SysStringB_H,high(SYSSTRINGPARAM5)
	ldi	SysReadA,low(StringTable57<<1)
	ldi	SysReadA_H,high(StringTable57<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable58<<1)
	ldi	SysReadA_H,high(StringTable58<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
;sertxd(0," The CMD8 check ","pattern is not confirmed",0):sertxd(0, "SDResponse3=",SDResponse3,0)
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM5)
	ldi	SysStringB_H,high(SYSSTRINGPARAM5)
	ldi	SysReadA,low(StringTable59<<1)
	ldi	SysReadA_H,high(StringTable59<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable61<<1)
	ldi	SysReadA_H,high(StringTable61<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM5)
	ldi	SysStringB_H,high(SYSSTRINGPARAM5)
	ldi	SysReadA,low(StringTable62<<1)
	ldi	SysReadA_H,high(StringTable62<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysValueCopy,SDRESPONSE3
	sts	INPUTB,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD8
;end if
ENDIF23:
;If SDResponse2=1 then
	lds	SysCalcTempA,SDRESPONSE2
	cpi	SysCalcTempA,1
	breq	PC + 2
	rjmp	ELSE24_1
;sertxd(1,"    ","   ",0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM5)
	ldi	SysStringB_H,high(SYSSTRINGPARAM5)
	ldi	SysReadA,low(StringTable57<<1)
	ldi	SysReadA_H,high(StringTable57<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable58<<1)
	ldi	SysReadA_H,high(StringTable58<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
;sertxd(0," The CMD8 confirm ","voltage Card",0)
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM5)
	ldi	SysStringB_H,high(SYSSTRINGPARAM5)
	ldi	SysReadA,low(StringTable63<<1)
	ldi	SysReadA_H,high(StringTable63<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable64<<1)
	ldi	SysReadA_H,high(StringTable64<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
;else
	rjmp	ENDIF24
ELSE24_1:
;sertxd(1,"    ","   ",0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM5)
	ldi	SysStringB_H,high(SYSSTRINGPARAM5)
	ldi	SysReadA,low(StringTable57<<1)
	ldi	SysReadA_H,high(StringTable57<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable58<<1)
	ldi	SysReadA_H,high(StringTable58<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
;sertxd(0," The CMD8 does not ","confirm Voltage Card",0):sertxd(0, "SDResponse2=",SDResponse2,0)
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM5)
	ldi	SysStringB_H,high(SYSSTRINGPARAM5)
	ldi	SysReadA,low(StringTable65<<1)
	ldi	SysReadA_H,high(StringTable65<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable66<<1)
	ldi	SysReadA_H,high(StringTable66<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM5)
	ldi	SysStringB_H,high(SYSSTRINGPARAM5)
	ldi	SysReadA,low(StringTable67<<1)
	ldi	SysReadA_H,high(StringTable67<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM5)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysValueCopy,SDRESPONSE2
	sts	INPUTB,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD8
;end if
ENDIF24:
;end if
ENDIF20:
	ret

;********************************************************************************

;Source: string.h (536)
FN_CHR:
;Empty input?
;If SysChar < 0 Then
	lds	SysCalcTempA,SYSCHAR
	cpi	SysCalcTempA,0
	brsh	ENDIF78
;Chr(0) = 0
	ldi	SysValueCopy,0
	sts	SYSCHR_0,SysValueCopy
;Exit Function
	ret
;End If
ENDIF78:
;Chr(0) = 1
	ldi	SysValueCopy,1
	sts	SYSCHR_0,SysValueCopy
;Copy characters
;Chr(1) = SysChar
	lds	SysValueCopy,SYSCHAR
	sts	SYSCHR_1,SysValueCopy
	ret

;********************************************************************************

;Source: MySDLib.h (476)
DISK_EXPLORER:
;dim boot_flag as Byte
;SDRead_Block(Address_Sector)
	lds	SysValueCopy,ADDRESS_SECTOR
	sts	BLOCK_START,SysValueCopy
	lds	SysValueCopy,ADDRESS_SECTOR_H
	sts	BLOCK_START_H,SysValueCopy
	lds	SysValueCopy,ADDRESS_SECTOR_U
	sts	BLOCK_START_U,SysValueCopy
	lds	SysValueCopy,ADDRESS_SECTOR_E
	sts	BLOCK_START_E,SysValueCopy
	call	SDREAD_BLOCK
;SDLocation_last=Address_Sector
	lds	SysValueCopy,ADDRESS_SECTOR
	sts	SDLOCATION_LAST,SysValueCopy
	lds	SysValueCopy,ADDRESS_SECTOR_H
	sts	SDLOCATION_LAST_H,SysValueCopy
	lds	SysValueCopy,ADDRESS_SECTOR_U
	sts	SDLOCATION_LAST_U,SysValueCopy
	lds	SysValueCopy,ADDRESS_SECTOR_E
	sts	SDLOCATION_LAST_E,SysValueCopy
;if Address_Sector=Cluster_Begin_LBA then
	lds	SysLONGTempA,ADDRESS_SECTOR
	lds	SysLONGTempA_H,ADDRESS_SECTOR_H
	lds	SysLONGTempA_U,ADDRESS_SECTOR_U
	lds	SysLONGTempA_E,ADDRESS_SECTOR_E
	lds	SysLONGTempB,CLUSTER_BEGIN_LBA
	lds	SysLONGTempB_H,CLUSTER_BEGIN_LBA_H
	lds	SysLONGTempB_U,CLUSTER_BEGIN_LBA_U
	lds	SysLONGTempB_E,CLUSTER_BEGIN_LBA_E
	call	SysCompEqual32
	sbrs	SysByteTempX,0
	rjmp	ELSE42_1
;boot_Flag=1
	ldi	SysValueCopy,1
	sts	BOOT_FLAG,SysValueCopy
;else
	rjmp	ENDIF42
ELSE42_1:
;boot_flag=0
	ldi	SysValueCopy,0
	sts	BOOT_FLAG,SysValueCopy
;end if
ENDIF42:
;Record_Location=0  'ora la base di indirizzo è il byte 0 del blocco letto
	ldi	SysValueCopy,0
	sts	RECORD_LOCATION,SysValueCopy
	sts	RECORD_LOCATION_H,SysValueCopy
;B0=100
	ldi	SysValueCopy,100
	sts	B0,SysValueCopy
	ldi	SysValueCopy,0
	sts	B0_H,SysValueCopy
	sts	B0_U,SysValueCopy
	sts	B0_E,SysValueCopy
;SD_Counter2=0     'SD_Counter, SD_Counter1 non utilizzabili perche usati da CallReadBlock
	ldi	SysValueCopy,0
	sts	SD_COUNTER2,SysValueCopy
	sts	SD_COUNTER2_H,SysValueCopy
;ind1=0
	ldi	SysValueCopy,0
	sts	IND1,SysValueCopy
;ind2=0
	ldi	SysValueCopy,0
	sts	IND2,SysValueCopy
;do until B0 =0
SysDoLoop_S10:
	lds	SysLONGTempA,b0
	lds	SysLONGTempA_H,b0_H
	lds	SysLONGTempA_U,b0_U
	lds	SysLONGTempA_E,b0_E
	ldi	SysLONGTempB,0
	ldi	SysLONGTempB_H,0
	ldi	SysLONGTempB_U,0
	ldi	SysLONGTempB_E,0
	call	SysCompEqual32
	sbrc	SysByteTempX,0
	rjmp	SysDoLoop_E10
;B1=SDDataBuffer(Record_Location)
	lds	SysTemp3,RECORD_LOCATION
	ldi	SysTemp4,low(SDDATABUFFER)
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	lds	SysTemp3,RECORD_LOCATION_H
	ldi	SysTemp4,high(SDDATABUFFER)
	adc	SysTemp3,SysTemp4
	mov	SysStringA_H,SysTemp3
	ld	SysValueCopy,X
	sts	B1,SysValueCopy
	ldi	SysValueCopy,0
	sts	B1_H,SysValueCopy
	sts	B1_U,SysValueCopy
	sts	B1_E,SysValueCopy
;if B1<>0xE5 then
	lds	SysLONGTempA,B1
	lds	SysLONGTempA_H,B1_H
	lds	SysLONGTempA_U,B1_U
	lds	SysLONGTempA_E,B1_E
	ldi	SysLONGTempB,229
	ldi	SysLONGTempB_H,0
	ldi	SysLONGTempB_U,0
	ldi	SysLONGTempB_E,0
	call	SysCompEqual32
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF43
;B1=SDDataBuffer(Record_Location+11)
	lds	SysTemp3,RECORD_LOCATION
	ldi	SysTemp4,11
	add	SysTemp3,SysTemp4
	mov	SysTemp1,SysTemp3
	lds	SysTemp3,RECORD_LOCATION_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	mov	SysTemp1_H,SysTemp3
	ldi	SysTemp4,low(SDDATABUFFER)
	add	SysTemp1,SysTemp4
	mov	SysStringA,SysTemp1
	ldi	SysTemp4,high(SDDATABUFFER)
	adc	SysTemp1_H,SysTemp4
	mov	SysStringA_H,SysTemp1_H
	ld	SysValueCopy,X
	sts	B1,SysValueCopy
	ldi	SysValueCopy,0
	sts	B1_H,SysValueCopy
	sts	B1_U,SysValueCopy
	sts	B1_E,SysValueCopy
;if B1.0<>1 or B1.1<>1 or B1.2 <>1 or B1.3<>1  then
	clr	SysByteTempX
	lds	SysBitTest,B1
	sbrc	SysBitTest,0
	com	SysByteTempX,F
	mov	SysTemp3,SysByteTempX
	clr	SysByteTempX
	lds	SysBitTest,B1
	sbrc	SysBitTest,1
	com	SysByteTempX,F
	mov	SysTemp1,SysByteTempX
	clr	SysByteTempX
	lds	SysBitTest,B1
	sbrc	SysBitTest,2
	com	SysByteTempX,F
	mov	SysTemp2,SysByteTempX
	clr	SysByteTempX
	lds	SysBitTest,B1
	sbrc	SysBitTest,3
	com	SysByteTempX,F
	or	SysTemp1,SysTemp3
	mov	SysTemp4,SysTemp1
	or	SysTemp2,SysTemp4
	mov	SysTemp3,SysTemp2
	mov	SysTemp2,SysByteTempX
	or	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	sbrs	SysTemp1,0
	rjmp	ENDIF47
;If B1.4 =1  then                                'is a directory
	lds	SysBitTest,B1
	sbrs	SysBitTest,4
	rjmp	ELSE50_1
;SD_MyString=CHR(SDDataBuffer(Record_Location))
	lds	SysTemp3,RECORD_LOCATION
	ldi	SysTemp4,low(SDDATABUFFER)
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	lds	SysTemp3,RECORD_LOCATION_H
	ldi	SysTemp4,high(SDDATABUFFER)
	adc	SysTemp3,SysTemp4
	mov	SysStringA_H,SysTemp3
	ld	SysValueCopy,X
	sts	SYSCHAR,SysValueCopy
	rcall	FN_CHR
	ldi	SysStringB,low(SD_MYSTRING)
	ldi	SysStringB_H,high(SD_MYSTRING)
	ldi	SysStringA,low(CHR)
	ldi	SysStringA_H,high(CHR)
	call	SysCopyString
;for SD_Counter3=1 to 7
	ldi	SysValueCopy,0
	sts	SD_COUNTER3,SysValueCopy
	sts	SD_COUNTER3_H,SysValueCopy
SysForLoop4:
	lds	SysTemp3,SD_COUNTER3
	inc	SysTemp3
	sts	SD_COUNTER3,SysTemp3
	lds	SysTemp3,SD_COUNTER3_H
	brne	PC + 2
	inc	SysTemp3
	sts	SD_COUNTER3_H,SysTemp3
;Dir_or_File_Name=SD_MyString+CHR(SDDataBuffer(Record_Location+SD_Counter3))
	lds	SysTemp3,RECORD_LOCATION
	lds	SysTemp2,SD_COUNTER3
	add	SysTemp3,SysTemp2
	mov	SysTemp1,SysTemp3
	lds	SysTemp3,RECORD_LOCATION_H
	lds	SysTemp2,SD_COUNTER3_H
	adc	SysTemp3,SysTemp2
	mov	SysTemp1_H,SysTemp3
	ldi	SysTemp4,low(SDDATABUFFER)
	add	SysTemp1,SysTemp4
	mov	SysStringA,SysTemp1
	ldi	SysTemp4,high(SDDATABUFFER)
	adc	SysTemp1_H,SysTemp4
	mov	SysStringA_H,SysTemp1_H
	ld	SysValueCopy,X
	sts	SYSCHAR,SysValueCopy
	rcall	FN_CHR
	ldi	SysStringB,low(DIR_OR_FILE_NAME)
	ldi	SysStringB_H,high(DIR_OR_FILE_NAME)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysStringA,low(SD_MYSTRING)
	ldi	SysStringA_H,high(SD_MYSTRING)
	call	SysCopyStringPart
	ldi	SysStringA,low(CHR)
	ldi	SysStringA_H,high(CHR)
	call	SysCopyStringPart
	ldi	SysStringA,low(DIR_OR_FILE_NAME)
	ldi	SysStringA_H,high(DIR_OR_FILE_NAME)
	st	X, SysStringLength
;SD_MyString=Dir_or_File_Name
	ldi	SysStringB,low(SD_MYSTRING)
	ldi	SysStringB_H,high(SD_MYSTRING)
	ldi	SysStringA,low(DIR_OR_FILE_NAME)
	ldi	SysStringA_H,high(DIR_OR_FILE_NAME)
	call	SysCopyString
;next
	lds	SysWORDTempA,SD_COUNTER3
	lds	SysWORDTempA_H,SD_COUNTER3_H
	ldi	SysWORDTempB,7
	ldi	SysWORDTempB_H,0
	call	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop4
SysForLoopEnd4:
;ind1=ind1+1
	lds	SysTemp3,IND1
	inc	SysTemp3
	sts	IND1,SysTemp3
;Dir_Record(ind1)=SD_Counter2
	ldi	SysTemp4,low(DIR_RECORD)
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	ldi	SysTemp4,0
	ldi	SysTemp5,high(DIR_RECORD)
	adc	SysTemp4,SysTemp5
	mov	SysStringA_H,SysTemp4
	lds	SysValueCopy,SD_COUNTER2
	st	X,SysValueCopy
;if ind1=1 and ind2=0 then
	lds	SysBYTETempA,IND1
	ldi	SysBYTETempB,1
	call	SysCompEqual
	mov	SysTemp3,SysByteTempX
	lds	SysBYTETempA,IND2
	ldi	SysBYTETempB,0
	call	SysCompEqual
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	sbrs	SysTemp1,0
	rjmp	ENDIF52
;Draw_Line(1,60,"-")
	ldi	SysValueCopy,1
	sts	LINE_TYPE,SysValueCopy
	ldi	SysValueCopy,60
	sts	N_CHAR,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable22<<1)
	ldi	SysReadA_H,high(StringTable22<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysCHARHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysCHARHandler_H,SysValueCopy
	rcall	DRAW_LINE
;Draw_Line(1,8," "):Sertxd(0,"Directories and"," Files List in "+Name,0)
	ldi	SysValueCopy,1
	sts	LINE_TYPE,SysValueCopy
	ldi	SysValueCopy,8
	sts	N_CHAR,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable10<<1)
	ldi	SysReadA_H,high(StringTable10<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysCHARHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysCHARHandler_H,SysValueCopy
	rcall	DRAW_LINE
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable120<<1)
	ldi	SysReadA_H,high(StringTable120<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM4)
	ldi	SysStringB_H,high(SYSSTRINGPARAM4)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysReadA,low(StringTable121<<1)
	ldi	SysReadA_H,high(StringTable121<<1)
	call	SysReadStringPart
	lds	SysStringA,SysNAMEHandler
	lds	SysStringA_H,SysNAMEHandler_H
	call	SysCopyStringPart
	ldi	SysStringA,low(SYSSTRINGPARAM4)
	ldi	SysStringA_H,high(SYSSTRINGPARAM4)
	st	X, SysStringLength
	ldi	SysValueCopy,low(SYSSTRINGPARAM4)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM4)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
;Draw_Line(1,60,"-"):Draw_Line(1,60," ")
	ldi	SysValueCopy,1
	sts	LINE_TYPE,SysValueCopy
	ldi	SysValueCopy,60
	sts	N_CHAR,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable22<<1)
	ldi	SysReadA_H,high(StringTable22<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysCHARHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysCHARHandler_H,SysValueCopy
	rcall	DRAW_LINE
	ldi	SysValueCopy,1
	sts	LINE_TYPE,SysValueCopy
	ldi	SysValueCopy,60
	sts	N_CHAR,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable10<<1)
	ldi	SysReadA_H,high(StringTable10<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysCHARHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysCHARHandler_H,SysValueCopy
	rcall	DRAW_LINE
;end if
ENDIF52:
;sertxd(1,"  Dir  n.=",ind1,0):sertxd(0," "+CHR(254)+" ",Dir_or_File_Name,0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable122<<1)
	ldi	SysReadA_H,high(StringTable122<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysValueCopy,IND1
	sts	INPUTB,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD8
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysValueCopy,254
	sts	SYSCHAR,SysValueCopy
	rcall	FN_CHR
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysReadA,low(StringTable10<<1)
	ldi	SysReadA_H,high(StringTable10<<1)
	call	SysReadStringPart
	ldi	SysStringA,low(CHR)
	ldi	SysStringA_H,high(CHR)
	call	SysCopyStringPart
	ldi	SysReadA,low(StringTable10<<1)
	ldi	SysReadA_H,high(StringTable10<<1)
	call	SysReadStringPart
	ldi	SysStringA,low(SYSSTRINGPARAM3)
	ldi	SysStringA_H,high(SYSSTRINGPARAM3)
	st	X, SysStringLength
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysValueCopy,low(DIR_OR_FILE_NAME)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(DIR_OR_FILE_NAME)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
;sertxd(0,"     at Record n.",Dir_Record(ind1),0)
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable123<<1)
	ldi	SysReadA_H,high(StringTable123<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysTemp3,IND1
	ldi	SysTemp4,low(DIR_RECORD)
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	ldi	SysTemp4,0
	ldi	SysTemp5,high(DIR_RECORD)
	adc	SysTemp4,SysTemp5
	mov	SysStringA_H,SysTemp4
	ld	SysValueCopy,X
	sts	INPUTB,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD8
;else
	rjmp	ENDIF50
ELSE50_1:
;SD_MyString=CHR(SDDataBuffer(Record_Location))    'is a file or Boot record
	lds	SysTemp3,RECORD_LOCATION
	ldi	SysTemp4,low(SDDATABUFFER)
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	lds	SysTemp3,RECORD_LOCATION_H
	ldi	SysTemp4,high(SDDATABUFFER)
	adc	SysTemp3,SysTemp4
	mov	SysStringA_H,SysTemp3
	ld	SysValueCopy,X
	sts	SYSCHAR,SysValueCopy
	rcall	FN_CHR
	ldi	SysStringB,low(SD_MYSTRING)
	ldi	SysStringB_H,high(SD_MYSTRING)
	ldi	SysStringA,low(CHR)
	ldi	SysStringA_H,high(CHR)
	call	SysCopyString
;for SD_Counter3=1 to 7
	ldi	SysValueCopy,0
	sts	SD_COUNTER3,SysValueCopy
	sts	SD_COUNTER3_H,SysValueCopy
SysForLoop5:
	lds	SysTemp3,SD_COUNTER3
	inc	SysTemp3
	sts	SD_COUNTER3,SysTemp3
	lds	SysTemp3,SD_COUNTER3_H
	brne	PC + 2
	inc	SysTemp3
	sts	SD_COUNTER3_H,SysTemp3
;Dir_or_File_Name=SD_MyString+CHR(SDDataBuffer(Record_Location+SD_Counter3))
	lds	SysTemp3,RECORD_LOCATION
	lds	SysTemp2,SD_COUNTER3
	add	SysTemp3,SysTemp2
	mov	SysTemp1,SysTemp3
	lds	SysTemp3,RECORD_LOCATION_H
	lds	SysTemp2,SD_COUNTER3_H
	adc	SysTemp3,SysTemp2
	mov	SysTemp1_H,SysTemp3
	ldi	SysTemp4,low(SDDATABUFFER)
	add	SysTemp1,SysTemp4
	mov	SysStringA,SysTemp1
	ldi	SysTemp4,high(SDDATABUFFER)
	adc	SysTemp1_H,SysTemp4
	mov	SysStringA_H,SysTemp1_H
	ld	SysValueCopy,X
	sts	SYSCHAR,SysValueCopy
	rcall	FN_CHR
	ldi	SysStringB,low(DIR_OR_FILE_NAME)
	ldi	SysStringB_H,high(DIR_OR_FILE_NAME)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysStringA,low(SD_MYSTRING)
	ldi	SysStringA_H,high(SD_MYSTRING)
	call	SysCopyStringPart
	ldi	SysStringA,low(CHR)
	ldi	SysStringA_H,high(CHR)
	call	SysCopyStringPart
	ldi	SysStringA,low(DIR_OR_FILE_NAME)
	ldi	SysStringA_H,high(DIR_OR_FILE_NAME)
	st	X, SysStringLength
;SD_MyString=Dir_or_File_Name
	ldi	SysStringB,low(SD_MYSTRING)
	ldi	SysStringB_H,high(SD_MYSTRING)
	ldi	SysStringA,low(DIR_OR_FILE_NAME)
	ldi	SysStringA_H,high(DIR_OR_FILE_NAME)
	call	SysCopyString
;next
	lds	SysWORDTempA,SD_COUNTER3
	lds	SysWORDTempA_H,SD_COUNTER3_H
	ldi	SysWORDTempB,7
	ldi	SysWORDTempB_H,0
	call	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop5
SysForLoopEnd5:
;SD_MyString=CHR(SDDataBuffer(Record_Location+8))
	lds	SysTemp3,RECORD_LOCATION
	ldi	SysTemp4,8
	add	SysTemp3,SysTemp4
	mov	SysTemp1,SysTemp3
	lds	SysTemp3,RECORD_LOCATION_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	mov	SysTemp1_H,SysTemp3
	ldi	SysTemp4,low(SDDATABUFFER)
	add	SysTemp1,SysTemp4
	mov	SysStringA,SysTemp1
	ldi	SysTemp4,high(SDDATABUFFER)
	adc	SysTemp1_H,SysTemp4
	mov	SysStringA_H,SysTemp1_H
	ld	SysValueCopy,X
	sts	SYSCHAR,SysValueCopy
	rcall	FN_CHR
	ldi	SysStringB,low(SD_MYSTRING)
	ldi	SysStringB_H,high(SD_MYSTRING)
	ldi	SysStringA,low(CHR)
	ldi	SysStringA_H,high(CHR)
	call	SysCopyString
;for SD_Counter3=1 to 2
	ldi	SysValueCopy,0
	sts	SD_COUNTER3,SysValueCopy
	sts	SD_COUNTER3_H,SysValueCopy
SysForLoop6:
	lds	SysTemp3,SD_COUNTER3
	inc	SysTemp3
	sts	SD_COUNTER3,SysTemp3
	lds	SysTemp3,SD_COUNTER3_H
	brne	PC + 2
	inc	SysTemp3
	sts	SD_COUNTER3_H,SysTemp3
;File_Extension=SD_MyString+CHR(SDDataBuffer(Record_Location+SD_Counter3+8))
	lds	SysTemp3,RECORD_LOCATION
	lds	SysTemp2,SD_COUNTER3
	add	SysTemp3,SysTemp2
	mov	SysTemp1,SysTemp3
	lds	SysTemp3,RECORD_LOCATION_H
	lds	SysTemp2,SD_COUNTER3_H
	adc	SysTemp3,SysTemp2
	mov	SysTemp1_H,SysTemp3
	ldi	SysTemp4,8
	add	SysTemp1,SysTemp4
	mov	SysTemp2,SysTemp1
	ldi	SysTemp4,0
	adc	SysTemp1_H,SysTemp4
	mov	SysTemp2_H,SysTemp1_H
	ldi	SysTemp4,low(SDDATABUFFER)
	add	SysTemp2,SysTemp4
	mov	SysStringA,SysTemp2
	ldi	SysTemp4,high(SDDATABUFFER)
	adc	SysTemp2_H,SysTemp4
	mov	SysStringA_H,SysTemp2_H
	ld	SysValueCopy,X
	sts	SYSCHAR,SysValueCopy
	rcall	FN_CHR
	ldi	SysStringB,low(FILE_EXTENSION)
	ldi	SysStringB_H,high(FILE_EXTENSION)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysStringA,low(SD_MYSTRING)
	ldi	SysStringA_H,high(SD_MYSTRING)
	call	SysCopyStringPart
	ldi	SysStringA,low(CHR)
	ldi	SysStringA_H,high(CHR)
	call	SysCopyStringPart
	ldi	SysStringA,low(FILE_EXTENSION)
	ldi	SysStringA_H,high(FILE_EXTENSION)
	st	X, SysStringLength
;SD_MyString=File_Extension
	ldi	SysStringB,low(SD_MYSTRING)
	ldi	SysStringB_H,high(SD_MYSTRING)
	ldi	SysStringA,low(FILE_EXTENSION)
	ldi	SysStringA_H,high(FILE_EXTENSION)
	call	SysCopyString
;next
	lds	SysWORDTempA,SD_COUNTER3
	lds	SysWORDTempA_H,SD_COUNTER3_H
	ldi	SysWORDTempB,2
	ldi	SysWORDTempB_H,0
	call	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop6
SysForLoopEnd6:
;ind2=ind2+1
	lds	SysTemp3,IND2
	inc	SysTemp3
	sts	IND2,SysTemp3
;File_Record(ind2)=SD_Counter2
	ldi	SysTemp4,low(FILE_RECORD)
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	ldi	SysTemp4,0
	ldi	SysTemp5,high(FILE_RECORD)
	adc	SysTemp4,SysTemp5
	mov	SysStringA_H,SysTemp4
	lds	SysValueCopy,SD_COUNTER2
	st	X,SysValueCopy
;if ind2=1 and ind1=0 then
	lds	SysBYTETempA,IND2
	ldi	SysBYTETempB,1
	call	SysCompEqual
	mov	SysTemp3,SysByteTempX
	lds	SysBYTETempA,IND1
	ldi	SysBYTETempB,0
	call	SysCompEqual
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	sbrs	SysTemp1,0
	rjmp	ENDIF55
;Draw_Line(1,60,"-")
	ldi	SysValueCopy,1
	sts	LINE_TYPE,SysValueCopy
	ldi	SysValueCopy,60
	sts	N_CHAR,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable22<<1)
	ldi	SysReadA_H,high(StringTable22<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysCHARHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysCHARHandler_H,SysValueCopy
	rcall	DRAW_LINE
;Draw_Line(1,8," "):Sertxd(0,"Directories and ","Files List in "+Name,0)
	ldi	SysValueCopy,1
	sts	LINE_TYPE,SysValueCopy
	ldi	SysValueCopy,8
	sts	N_CHAR,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable10<<1)
	ldi	SysReadA_H,high(StringTable10<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysCHARHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysCHARHandler_H,SysValueCopy
	rcall	DRAW_LINE
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable124<<1)
	ldi	SysReadA_H,high(StringTable124<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM4)
	ldi	SysStringB_H,high(SYSSTRINGPARAM4)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysReadA,low(StringTable125<<1)
	ldi	SysReadA_H,high(StringTable125<<1)
	call	SysReadStringPart
	lds	SysStringA,SysNAMEHandler
	lds	SysStringA_H,SysNAMEHandler_H
	call	SysCopyStringPart
	ldi	SysStringA,low(SYSSTRINGPARAM4)
	ldi	SysStringA_H,high(SYSSTRINGPARAM4)
	st	X, SysStringLength
	ldi	SysValueCopy,low(SYSSTRINGPARAM4)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM4)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
;Draw_Line(1,60,"-"):Draw_Line(1,60," ")
	ldi	SysValueCopy,1
	sts	LINE_TYPE,SysValueCopy
	ldi	SysValueCopy,60
	sts	N_CHAR,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable22<<1)
	ldi	SysReadA_H,high(StringTable22<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysCHARHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysCHARHandler_H,SysValueCopy
	rcall	DRAW_LINE
	ldi	SysValueCopy,1
	sts	LINE_TYPE,SysValueCopy
	ldi	SysValueCopy,60
	sts	N_CHAR,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable10<<1)
	ldi	SysReadA_H,high(StringTable10<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysCHARHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysCHARHandler_H,SysValueCopy
	rcall	DRAW_LINE
;end if
ENDIF55:
;if boot_flag=1 then
	lds	SysCalcTempA,BOOT_FLAG
	cpi	SysCalcTempA,1
	breq	PC + 2
	rjmp	ELSE56_1
;if ind2=1 then
	lds	SysCalcTempA,IND2
	cpi	SysCalcTempA,1
	breq	PC + 2
	rjmp	ELSE57_1
;sertxd(1,"  BOOT"," SECT.",0):sertxd(0,CHR(233)+" ",Dir_or_File_Name,0):sertxd(0,"  ","  ",0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable126<<1)
	ldi	SysReadA_H,high(StringTable126<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM4)
	ldi	SysStringB_H,high(SYSSTRINGPARAM4)
	ldi	SysReadA,low(StringTable127<<1)
	ldi	SysReadA_H,high(StringTable127<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM4)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM4)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysValueCopy,233
	sts	SYSCHAR,SysValueCopy
	rcall	FN_CHR
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysStringA,low(CHR)
	ldi	SysStringA_H,high(CHR)
	call	SysCopyStringPart
	ldi	SysReadA,low(StringTable10<<1)
	ldi	SysReadA_H,high(StringTable10<<1)
	call	SysReadStringPart
	ldi	SysStringA,low(SYSSTRINGPARAM3)
	ldi	SysStringA_H,high(SYSSTRINGPARAM3)
	st	X, SysStringLength
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysValueCopy,low(DIR_OR_FILE_NAME)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(DIR_OR_FILE_NAME)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable92<<1)
	ldi	SysReadA_H,high(StringTable92<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM4)
	ldi	SysStringB_H,high(SYSSTRINGPARAM4)
	ldi	SysReadA,low(StringTable92<<1)
	ldi	SysReadA_H,high(StringTable92<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM4)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM4)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
;sertxd(0," at Record n.",File_Record(ind2),0)
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable128<<1)
	ldi	SysReadA_H,high(StringTable128<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysTemp3,IND2
	ldi	SysTemp4,low(FILE_RECORD)
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	ldi	SysTemp4,0
	ldi	SysTemp5,high(FILE_RECORD)
	adc	SysTemp4,SysTemp5
	mov	SysStringA_H,SysTemp4
	ld	SysValueCopy,X
	sts	INPUTB,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD8
;else
	rjmp	ENDIF57
ELSE57_1:
;sertxd(1,"  File n.=",ind2-1,0):sertxd(0," "+CHR(233)+" ",Dir_or_File_Name,0):Sertxd(0,".",File_Extension,0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable129<<1)
	ldi	SysReadA_H,high(StringTable129<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysTemp3,IND2
	dec	SysTemp3
	sts	INPUTB,SysTemp3
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD8
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysValueCopy,233
	sts	SYSCHAR,SysValueCopy
	rcall	FN_CHR
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysReadA,low(StringTable10<<1)
	ldi	SysReadA_H,high(StringTable10<<1)
	call	SysReadStringPart
	ldi	SysStringA,low(CHR)
	ldi	SysStringA_H,high(CHR)
	call	SysCopyStringPart
	ldi	SysReadA,low(StringTable10<<1)
	ldi	SysReadA_H,high(StringTable10<<1)
	call	SysReadStringPart
	ldi	SysStringA,low(SYSSTRINGPARAM3)
	ldi	SysStringA_H,high(SYSSTRINGPARAM3)
	st	X, SysStringLength
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysValueCopy,low(DIR_OR_FILE_NAME)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(DIR_OR_FILE_NAME)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable130<<1)
	ldi	SysReadA_H,high(StringTable130<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysValueCopy,low(FILE_EXTENSION)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(FILE_EXTENSION)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
;sertxd(0," at Record n.",File_Record(ind2),0)
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable128<<1)
	ldi	SysReadA_H,high(StringTable128<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysTemp3,IND2
	ldi	SysTemp4,low(FILE_RECORD)
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	ldi	SysTemp4,0
	ldi	SysTemp5,high(FILE_RECORD)
	adc	SysTemp4,SysTemp5
	mov	SysStringA_H,SysTemp4
	ld	SysValueCopy,X
	sts	INPUTB,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD8
;end if
ENDIF57:
;else
	rjmp	ENDIF56
ELSE56_1:
;sertxd(1,"  File n.=",ind2,0):sertxd(0," "+CHR(233)+" ",Dir_or_File_Name,0):Sertxd(0,".",File_Extension,0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable129<<1)
	ldi	SysReadA_H,high(StringTable129<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysValueCopy,IND2
	sts	INPUTB,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD8
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysValueCopy,233
	sts	SYSCHAR,SysValueCopy
	rcall	FN_CHR
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysReadA,low(StringTable10<<1)
	ldi	SysReadA_H,high(StringTable10<<1)
	call	SysReadStringPart
	ldi	SysStringA,low(CHR)
	ldi	SysStringA_H,high(CHR)
	call	SysCopyStringPart
	ldi	SysReadA,low(StringTable10<<1)
	ldi	SysReadA_H,high(StringTable10<<1)
	call	SysReadStringPart
	ldi	SysStringA,low(SYSSTRINGPARAM3)
	ldi	SysStringA_H,high(SYSSTRINGPARAM3)
	st	X, SysStringLength
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysValueCopy,low(DIR_OR_FILE_NAME)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(DIR_OR_FILE_NAME)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable130<<1)
	ldi	SysReadA_H,high(StringTable130<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysValueCopy,low(FILE_EXTENSION)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(FILE_EXTENSION)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD7
;sertxd(0," at Record n.",File_Record(ind2),0)
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable128<<1)
	ldi	SysReadA_H,high(StringTable128<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysTemp3,IND2
	ldi	SysTemp4,low(FILE_RECORD)
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	ldi	SysTemp4,0
	ldi	SysTemp5,high(FILE_RECORD)
	adc	SysTemp4,SysTemp5
	mov	SysStringA_H,SysTemp4
	ld	SysValueCopy,X
	sts	INPUTB,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	call	SERTXD8
;end if
ENDIF56:
;end if
ENDIF50:
;end if
ENDIF47:
;end if
ENDIF43:
;Record_Location=Record_Location+32
	lds	SysTemp3,RECORD_LOCATION
	ldi	SysTemp4,32
	add	SysTemp3,SysTemp4
	sts	RECORD_LOCATION,SysTemp3
	lds	SysTemp3,RECORD_LOCATION_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	sts	RECORD_LOCATION_H,SysTemp3
;SD_Counter2=SD_Counter2+1
	lds	SysTemp3,SD_COUNTER2
	inc	SysTemp3
	sts	SD_COUNTER2,SysTemp3
	lds	SysTemp3,SD_COUNTER2_H
	brne	PC + 2
	inc	SysTemp3
	sts	SD_COUNTER2_H,SysTemp3
;if Record_Location=512 then
	lds	SysWORDTempA,RECORD_LOCATION
	lds	SysWORDTempA_H,RECORD_LOCATION_H
	ldi	SysWORDTempB,0
	ldi	SysWORDTempB_H,2
	call	SysCompEqual16
	sbrs	SysByteTempX,0
	rjmp	ENDIF44
;Record_Location=0
	ldi	SysValueCopy,0
	sts	RECORD_LOCATION,SysValueCopy
	sts	RECORD_LOCATION_H,SysValueCopy
;SDLocation_Last=Address_Sector+SD_Counter2/16
	lds	SysWORDTempA,SD_COUNTER2
	lds	SysWORDTempA_H,SD_COUNTER2_H
	ldi	SysWORDTempB,16
	ldi	SysWORDTempB_H,0
	call	SysDivSub16
	lds	SysTemp3,ADDRESS_SECTOR
	add	SysTemp3,SysWORDTempA
	sts	SDLOCATION_LAST,SysTemp3
	lds	SysTemp3,ADDRESS_SECTOR_H
	adc	SysTemp3,SysWORDTempA_H
	sts	SDLOCATION_LAST_H,SysTemp3
	lds	SysTemp3,ADDRESS_SECTOR_U
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	sts	SDLOCATION_LAST_U,SysTemp3
	lds	SysTemp3,ADDRESS_SECTOR_E
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	sts	SDLOCATION_LAST_E,SysTemp3
;SDRead_Block(SDLocation_Last)
	lds	SysValueCopy,SDLOCATION_LAST
	sts	BLOCK_START,SysValueCopy
	lds	SysValueCopy,SDLOCATION_LAST_H
	sts	BLOCK_START_H,SysValueCopy
	lds	SysValueCopy,SDLOCATION_LAST_U
	sts	BLOCK_START_U,SysValueCopy
	lds	SysValueCopy,SDLOCATION_LAST_E
	sts	BLOCK_START_E,SysValueCopy
	call	SDREAD_BLOCK
;end if
ENDIF44:
;B0=SDDataBuffer(Record_Location)
	lds	SysTemp3,RECORD_LOCATION
	ldi	SysTemp4,low(SDDATABUFFER)
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	lds	SysTemp3,RECORD_LOCATION_H
	ldi	SysTemp4,high(SDDATABUFFER)
	adc	SysTemp3,SysTemp4
	mov	SysStringA_H,SysTemp3
	ld	SysValueCopy,X
	sts	B0,SysValueCopy
	ldi	SysValueCopy,0
	sts	B0_H,SysValueCopy
	sts	B0_U,SysValueCopy
	sts	B0_E,SysValueCopy
;Loop
	rjmp	SysDoLoop_S10
SysDoLoop_E10:
;Record_location_Last=Record_Location
	lds	SysValueCopy,RECORD_LOCATION
	sts	RECORD_LOCATION_LAST,SysValueCopy
	lds	SysValueCopy,RECORD_LOCATION_H
	sts	RECORD_LOCATION_LAST_H,SysValueCopy
;If Boot_Flag=1 then                      'NOTA: Per la presenza di BOOT,
	lds	SysCalcTempA,BOOT_FLAG
	cpi	SysCalcTempA,1
	breq	PC + 2
	rjmp	ENDIF45
;ind2=ind2-1                            ' le Info del file n-mo
	lds	SysTemp3,IND2
	dec	SysTemp3
	sts	IND2,SysTemp3
;For ind1=1 to ind2                     ' in File_Record sono nell'elemento
	ldi	SysValueCopy,0
	sts	IND1,SysValueCopy
	lds	SysCalcTempA,IND2
	cpi	SysCalcTempA,1
	brlo	SysForLoopEnd7
SysForLoop7:
	lds	SysTemp3,IND1
	inc	SysTemp3
	sts	IND1,SysTemp3
;File_Record(ind1)=File_Record(ind1+1)' (n+1)-mo. Con queste istruzione
	lds	SysTemp1,IND1
	inc	SysTemp1
	mov	SysTemp3,SysTemp1
	ldi	SysTemp4,low(FILE_RECORD)
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	ldi	SysTemp4,0
	ldi	SysTemp5,high(FILE_RECORD)
	adc	SysTemp4,SysTemp5
	mov	SysStringA_H,SysTemp4
	ld	SysValueCopy,X+
	sts	SysArrayTemp2,SysValueCopy
	sts	SysArrayTemp1,SysValueCopy
	lds	SysTemp3,IND1
	ldi	SysTemp4,low(FILE_RECORD)
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	ldi	SysTemp4,0
	ldi	SysTemp5,high(FILE_RECORD)
	adc	SysTemp4,SysTemp5
	mov	SysStringA_H,SysTemp4
	lds	SysValueCopy,SysArrayTemp1
	st	X+,SysValueCopy
;Next                                   ' le si riportano all-n-mo
	lds	SysCalcTempA,IND1
	lds	SysCalcTempB,IND2
	cp	SysCalcTempA,SysCalcTempB
	brlo	SysForLoop7
SysForLoopEnd7:
;End If
ENDIF45:
;if SD_Counter2>15 then
	lds	SysWORDTempB,SD_COUNTER2
	lds	SysWORDTempB_H,SD_COUNTER2_H
	ldi	SysWORDTempA,15
	ldi	SysWORDTempA_H,0
	call	SysCompLessThan16
	sbrs	SysByteTempX,0
	rjmp	ENDIF46
;SDRead_Block(Address_Sector) 'Necessario per ripristinare il buffer iniziale
	lds	SysValueCopy,ADDRESS_SECTOR
	sts	BLOCK_START,SysValueCopy
	lds	SysValueCopy,ADDRESS_SECTOR_H
	sts	BLOCK_START_H,SysValueCopy
	lds	SysValueCopy,ADDRESS_SECTOR_U
	sts	BLOCK_START_U,SysValueCopy
	lds	SysValueCopy,ADDRESS_SECTOR_E
	sts	BLOCK_START_E,SysValueCopy
	call	SDREAD_BLOCK
;'Naturalmente la poca RAM non consente di fare
;end if                           'diversamente
ENDIF46:
;Draw_Line(1,60,"-"):Draw_Line(1,60," ")
	ldi	SysValueCopy,1
	sts	LINE_TYPE,SysValueCopy
	ldi	SysValueCopy,60
	sts	N_CHAR,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable22<<1)
	ldi	SysReadA_H,high(StringTable22<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysCHARHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysCHARHandler_H,SysValueCopy
	rcall	DRAW_LINE
	ldi	SysValueCopy,1
	sts	LINE_TYPE,SysValueCopy
	ldi	SysValueCopy,60
	sts	N_CHAR,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable10<<1)
	ldi	SysReadA_H,high(StringTable10<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysCHARHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysCHARHandler_H,SysValueCopy
	rjmp	DRAW_LINE

;********************************************************************************

;Source: Sertxd.h (77)
DRAW_LINE:
;If N_Char <100 then
	lds	SysCalcTempA,N_CHAR
	cpi	SysCalcTempA,100
	brsh	ELSE18_1
;HSerPrintCRLF 1
	ldi	SysValueCopy,1
	sts	HSERPRINTCRLFCOUNT,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINTCRLF
;else
	rjmp	ENDIF18
ELSE18_1:
;N_Char=N_Char-100
	lds	SysTemp3,N_CHAR
	ldi	SysTemp4,100
	sub	SysTemp3,SysTemp4
	sts	N_CHAR,SysTemp3
;end if
ENDIF18:
;Select Case Line_Type
;Case 1
SysSelect1Case1:
	lds	SysCalcTempA,LINE_TYPE
	cpi	SysCalcTempA,1
	brne	SysSelect1Case2
;repeat N_Char
	lds	SysValueCopy,N_CHAR
	sts	SysRepeatTemp1,SysValueCopy
	lds	SysCalcTempA,SYSREPEATTEMP1
	tst	SysCalcTempA
	brne	PC + 2
	rjmp	SysRepeatLoopEnd1
SysRepeatLoop1:
;HSerprint Char
	lds	SysValueCopy,SysCHARHandler
	sts	SysPRINTDATAHandler,SysValueCopy
	lds	SysValueCopy,SysCHARHandler_H
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT286
;end repeat
	lds	SysTemp3,SysRepeatTemp1
	dec	SysTemp3
	sts	SysRepeatTemp1,SysTemp3
	brne	SysRepeatLoop1
SysRepeatLoopEnd1:
;Case 2
	rjmp	SysSelectEnd1
SysSelect1Case2:
	lds	SysCalcTempA,LINE_TYPE
	cpi	SysCalcTempA,2
	brne	SysSelectEnd1
;repeat N_Char
	lds	SysValueCopy,N_CHAR
	sts	SysRepeatTemp1,SysValueCopy
	lds	SysCalcTempA,SYSREPEATTEMP1
	tst	SysCalcTempA
	brne	PC + 2
	rjmp	SysRepeatLoopEnd2
SysRepeatLoop2:
;HSerprint Char
	lds	SysValueCopy,SysCHARHandler
	sts	SysPRINTDATAHandler,SysValueCopy
	lds	SysValueCopy,SysCHARHandler_H
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT286
;HSerPrint " "
	ldi	SysStringB,low(SYSSTRINGPARAM18)
	ldi	SysStringB_H,high(SYSSTRINGPARAM18)
	ldi	SysReadA,low(StringTable10<<1)
	ldi	SysReadA_H,high(StringTable10<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM18)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM18)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT286
;end repeat
	lds	SysTemp3,SysRepeatTemp1
	dec	SysTemp3
	sts	SysRepeatTemp1,SysTemp3
	brne	SysRepeatLoop2
SysRepeatLoopEnd2:
;End Select
SysSelectEnd1:
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

;Overloaded signature: LONG:BYTE:, Source: stdbasic.h (408)
FN_FNLSL115:
;Repeat NumBits
	lds	SysValueCopy,NUMBITS
	sts	SysRepeatTemp13,SysValueCopy
	lds	SysCalcTempA,SYSREPEATTEMP13
	tst	SysCalcTempA
	brne	PC + 2
	rjmp	SysRepeatLoopEnd13
SysRepeatLoop13:
;Set C Off
	clc
;Rotate SysLongTempB Left
	rol	SYSLONGTEMPB
	rol	SYSLONGTEMPB_H
	rol	SYSLONGTEMPB_U
	rol	SYSLONGTEMPB_E
;End Repeat
	lds	SysTemp3,SysRepeatTemp13
	dec	SysTemp3
	sts	SysRepeatTemp13,SysTemp3
	brne	SysRepeatLoop13
SysRepeatLoopEnd13:
;FnLSL = SysLongTempB
	sts	FNLSL,SYSLONGTEMPB
	sts	FNLSL_H,SYSLONGTEMPB_H
	sts	FNLSL_U,SYSLONGTEMPB_U
	sts	FNLSL_E,SYSLONGTEMPB_E
	ret

;********************************************************************************

;Source: MySDLib.h (108)
GETSDRESPONSE:
;Dim SDResp as Byte
;repeat NResponse
	lds	SysValueCopy,NRESPONSE
	sts	SysRepeatTemp16,SysValueCopy
	lds	SysCalcTempA,SYSREPEATTEMP16
	tst	SysCalcTempA
	brne	PC + 2
	rjmp	SysRepeatLoopEnd16
SysRepeatLoop16:
;SPITransfer 255, SDResp
	ldi	SysValueCopy,255
	sts	SPITXDATA,SysValueCopy
	rcall	HWSPITRANSFER
	lds	SysValueCopy,SPIRXDATA
	sts	SDRESP,SysValueCopy
;end Repeat
	lds	SysTemp3,SysRepeatTemp16
	dec	SysTemp3
	sts	SysRepeatTemp16,SysTemp3
	brne	SysRepeatLoop16
SysRepeatLoopEnd16:
	ret

;********************************************************************************

;Source: usart.h (1216)
HSERGETSTRING:
;HSerIndex = 0
	ldi	SysValueCopy,0
	sts	HSERINDEX,SysValueCopy
;Do
SysDoLoop_S13:
;comport = comport 'not really required but added for clarity
;HSerReceive ( HSerInByte )
	rcall	HSERRECEIVE281
	lds	SysValueCopy,SERDATA
	sts	HSERINBYTE,SysValueCopy
;Enter key?
;If HSerInByte = 13 Then
	lds	SysCalcTempA,HSERINBYTE
	cpi	SysCalcTempA,13
	brne	ENDIF79
;Exit Sub
	ret
;End If
ENDIF79:
;letters,numbers,punctuation
;If HSerInByte >= 32 and HSerInByte <= 126 Then
	lds	SysBYTETempA,HSERINBYTE
	ldi	SysBYTETempB,32
	call	SysCompLessThan
	com	SysByteTempX
	mov	SysTemp3,SysByteTempX
	lds	SysBYTETempB,HSERINBYTE
	ldi	SysBYTETempA,126
	call	SysCompLessThan
	com	SysByteTempX
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	sbrs	SysTemp1,0
	rjmp	ENDIF80
;HSerIndex++
	lds	SysTemp3,HSERINDEX
	inc	SysTemp3
	sts	HSERINDEX,SysTemp3
;HSerString(HSerIndex) = HSerInByte
	lds	SysTemp3,SysHSERSTRINGHandler
	lds	SysTemp1,HSERINDEX
	add	SysTemp3,SysTemp1
	mov	SysStringA,SysTemp3
	lds	SysTemp3,SysHSERSTRINGHandler_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	mov	SysStringA_H,SysTemp3
	lds	SysValueCopy,HSERINBYTE
	st	X,SysValueCopy
;HSerString(0) = HSerIndex
	lds	SysStringA,SysHSERSTRINGHandler
	lds	SysStringA_H,SysHSERSTRINGHandler_H
	lds	SysValueCopy,HSERINDEX
	st	X,SysValueCopy
;End If
ENDIF80:
;Loop
	rjmp	SysDoLoop_S13
SysDoLoop_E13:
	ret

;********************************************************************************

;Overloaded signature: STRING:byte:, Source: usart.h (1251)
HSERPRINT286:
;PrintLen = PrintData(0)
	lds	SysStringA,SysPRINTDATAHandler
	lds	SysStringA_H,SysPRINTDATAHandler_H
	ld	SysValueCopy,X
	sts	PRINTLEN,SysValueCopy
;If PrintLen <> 0 then
	lds	SysCalcTempA,PRINTLEN
	tst	SysCalcTempA
	breq	ENDIF81
;Write Data
;for SysPrintTemp = 1 to PrintLen
	ldi	SysValueCopy,0
	sts	SYSPRINTTEMP,SysValueCopy
	lds	SysCalcTempA,PRINTLEN
	cpi	SysCalcTempA,1
	brlo	SysForLoopEnd11
SysForLoop11:
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
	rcall	HSERSEND276
;next
	lds	SysCalcTempA,SYSPRINTTEMP
	lds	SysCalcTempB,PRINTLEN
	cp	SysCalcTempA,SysCalcTempB
	brlo	SysForLoop11
SysForLoopEnd11:
;End If
ENDIF81:
;CR
	ret

;********************************************************************************

;Overloaded signature: BYTE:byte:, Source: usart.h (1274)
HSERPRINT287:
;OutValueTemp = 0
	ldi	SysValueCopy,0
	sts	OUTVALUETEMP,SysValueCopy
;IF SerPrintVal >= 100 Then
	lds	SysCalcTempA,SERPRINTVAL
	cpi	SysCalcTempA,100
	brlo	ENDIF95
;OutValueTemp = SerPrintVal / 100
	lds	SysBYTETempA,SERPRINTVAL
	ldi	SysBYTETempB,100
	call	SysDivSub
	sts	OUTVALUETEMP,SysBYTETempA
;SerPrintVal = SysCalcTempX
	sts	SERPRINTVAL,SYSCALCTEMPX
;HSerSend(OutValueTemp + 48 ,comport )
	lds	SysTemp3,OUTVALUETEMP
	ldi	SysTemp4,48
	add	SysTemp3,SysTemp4
	sts	SERDATA,SysTemp3
	rcall	HSERSEND276
;End If
ENDIF95:
;If OutValueTemp > 0 Or SerPrintVal >= 10 Then
	lds	SysBYTETempB,OUTVALUETEMP
	ldi	SysBYTETempA,0
	call	SysCompLessThan
	mov	SysTemp3,SysByteTempX
	lds	SysBYTETempA,SERPRINTVAL
	ldi	SysBYTETempB,10
	call	SysCompLessThan
	com	SysByteTempX
	mov	SysTemp2,SysByteTempX
	or	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	sbrs	SysTemp1,0
	rjmp	ENDIF96
;OutValueTemp = SerPrintVal / 10
	lds	SysBYTETempA,SERPRINTVAL
	ldi	SysBYTETempB,10
	call	SysDivSub
	sts	OUTVALUETEMP,SysBYTETempA
;SerPrintVal = SysCalcTempX
	sts	SERPRINTVAL,SYSCALCTEMPX
;HSerSend(OutValueTemp + 48 ,comport )
	lds	SysTemp3,OUTVALUETEMP
	ldi	SysTemp4,48
	add	SysTemp3,SysTemp4
	sts	SERDATA,SysTemp3
	rcall	HSERSEND276
;End If
ENDIF96:
;HSerSend(SerPrintVal + 48 ,comport)
	lds	SysTemp3,SERPRINTVAL
	ldi	SysTemp4,48
	add	SysTemp3,SysTemp4
	sts	SERDATA,SysTemp3
	rcall	HSERSEND276
;CR
	ret

;********************************************************************************

;Overloaded signature: WORD:byte:, Source: usart.h (1302)
HSERPRINT288:
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
	rjmp	ENDIF97
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
	rcall	HSERSEND276
;Goto HSerPrintWord1000
	rjmp	HSERPRINTWORD1000
;End If
ENDIF97:
;If SerPrintVal >= 1000 then
	lds	SysWORDTempA,SERPRINTVAL
	lds	SysWORDTempA_H,SERPRINTVAL_H
	ldi	SysWORDTempB,232
	ldi	SysWORDTempB_H,3
	call	SysCompLessThan16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF98
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
	rcall	HSERSEND276
;Goto HSerPrintWord100
	rjmp	HSERPRINTWORD100
;End If
ENDIF98:
;If SerPrintVal >= 100 then
	lds	SysWORDTempA,SERPRINTVAL
	lds	SysWORDTempA_H,SERPRINTVAL_H
	ldi	SysWORDTempB,100
	ldi	SysWORDTempB_H,0
	call	SysCompLessThan16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF99
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
	rcall	HSERSEND276
;Goto HSerPrintWord10
	rjmp	HSERPRINTWORD10
;End If
ENDIF99:
;If SerPrintVal >= 10 then
	lds	SysWORDTempA,SERPRINTVAL
	lds	SysWORDTempA_H,SERPRINTVAL_H
	ldi	SysWORDTempB,10
	ldi	SysWORDTempB_H,0
	call	SysCompLessThan16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF100
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
	rcall	HSERSEND276
;End If
ENDIF100:
;HSerSend(SerPrintVal + 48 ,comport  )
	lds	SysTemp3,SERPRINTVAL
	ldi	SysTemp4,48
	add	SysTemp3,SysTemp4
	sts	SERDATA,SysTemp3
	rcall	HSERSEND275
;CR
	ret

;********************************************************************************

;Overloaded signature: LONG:byte:, Source: usart.h (1368)
HSERPRINT290:
;Dim SysCalcTempA As Long
;Dim SysPrintBuffer(10)
;SysPrintBuffLen = 0
	ldi	SysValueCopy,0
	sts	SYSPRINTBUFFLEN,SysValueCopy
;Do
SysDoLoop_S14:
;Divide number by 10, remainder into buffer
;SysPrintBuffLen += 1
	lds	SysTemp3,SYSPRINTBUFFLEN
	inc	SysTemp3
	sts	SYSPRINTBUFFLEN,SysTemp3
;SysPrintBuffer(SysPrintBuffLen) = SerPrintVal % 10
	ldi	SysTemp4,low(SYSPRINTBUFFER)
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	ldi	SysTemp4,0
	ldi	SysTemp5,high(SYSPRINTBUFFER)
	adc	SysTemp4,SysTemp5
	mov	SysStringA_H,SysTemp4
	lds	SysLONGTempA,SERPRINTVAL
	lds	SysLONGTempA_H,SERPRINTVAL_H
	lds	SysLONGTempA_U,SERPRINTVAL_U
	lds	SysLONGTempA_E,SERPRINTVAL_E
	ldi	SysLONGTempB,10
	ldi	SysLONGTempB_H,0
	ldi	SysLONGTempB_U,0
	ldi	SysLONGTempB_E,0
	call	SysDivSub32
	st	X,SysLONGTempX
;SerPrintVal = SysCalcTempA
	sts	SERPRINTVAL,SYSCALCTEMPA
	sts	SERPRINTVAL_H,SYSCALCTEMPA_H
	sts	SERPRINTVAL_U,SYSCALCTEMPA_U
	sts	SERPRINTVAL_E,SYSCALCTEMPA_E
;Loop While SerPrintVal <> 0
	lds	SysLONGTempA,serprintval
	lds	SysLONGTempA_H,serprintval_H
	lds	SysLONGTempA_U,serprintval_U
	lds	SysLONGTempA_E,serprintval_E
	ldi	SysLONGTempB,0
	ldi	SysLONGTempB_H,0
	ldi	SysLONGTempB_U,0
	ldi	SysLONGTempB_E,0
	call	SysCompEqual32
	com	SysByteTempX
	sbrc	SysByteTempX,0
	rjmp	SysDoLoop_S14
SysDoLoop_E14:
;Display
;For SysPrintTemp = SysPrintBuffLen To 1 Step -1
	lds	SysTemp3,SYSPRINTBUFFLEN
	inc	SysTemp3
	sts	SYSPRINTTEMP,SysTemp3
	lds	SysCalcTempA,SYSPRINTBUFFLEN
	ldi	SysCalcTempA_H,0
	ldi	SysCalcTempA_U,0
	ldi	SysCalcTempA_E,0
	cpi	SysCalcTempA,1
	brlo	SysForLoopEnd12
SysForLoop12:
	lds	SysTemp3,SYSPRINTTEMP
	dec	SysTemp3
	sts	SYSPRINTTEMP,SysTemp3
;HSerSend(SysPrintBuffer(SysPrintTemp) + 48, comport  )
	ldi	SysTemp4,low(SYSPRINTBUFFER)
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	ldi	SysTemp4,0
	ldi	SysTemp5,high(SYSPRINTBUFFER)
	adc	SysTemp4,SysTemp5
	mov	SysStringA_H,SysTemp4
	ld	SysTemp3,X
	ldi	SysTemp4,48
	add	SysTemp3,SysTemp4
	sts	SERDATA,SysTemp3
	rcall	HSERSEND276
;Next
	ldi	SysCalcTempA,1
	ldi	SysCalcTempA_H,0
	ldi	SysCalcTempA_U,0
	ldi	SysCalcTempA_E,0
	lds	SysCalcTempB,SYSPRINTTEMP
	cp	SysCalcTempA,SysCalcTempB
	brlo	SysForLoop12
SysForLoopEnd12:
;CR
	ret

;********************************************************************************

;Source: usart.h (1403)
HSERPRINTCRLF:
;repeat HSerPrintCRLFCount
	lds	SysValueCopy,HSERPRINTCRLFCOUNT
	sts	SysRepeatTemp14,SysValueCopy
	lds	SysCalcTempA,SYSREPEATTEMP14
	tst	SysCalcTempA
	brne	PC + 2
	rjmp	SysRepeatLoopEnd14
SysRepeatLoop14:
;HSerSend(13,comport)
	ldi	SysValueCopy,13
	sts	SERDATA,SysValueCopy
	rcall	HSERSEND276
;HSerSend(10,comport)
	ldi	SysValueCopy,10
	sts	SERDATA,SysValueCopy
	rcall	HSERSEND276
;end Repeat
	lds	SysTemp3,SysRepeatTemp14
	dec	SysTemp3
	sts	SysRepeatTemp14,SysTemp3
	brne	SysRepeatLoop14
SysRepeatLoopEnd14:
	ret

;********************************************************************************

;Overloaded signature: BYTE:, Source: usart.h (954)
HSERRECEIVE281:
;Needs comport to be set first by calling routines
;AVR USART 1 receive
;if comport = 1 Then
	lds	SysCalcTempA,COMPORT
	cpi	SysCalcTempA,1
	brne	ENDIF93
;SerData = DefaultUsartReturnValue
	ldi	SysValueCopy,255
	sts	SERDATA,SysValueCopy
;If set up to block, wait for data
;Wait Until USARTHasData
SysWaitLoop4:
	lds	SysBitTest,UCSR0A
	sbrs	SysBitTest,RXC0
	rjmp	SysWaitLoop4
;If USARTHasData Then
	lds	SysBitTest,UCSR0A
	sbrs	SysBitTest,RXC0
	rjmp	ENDIF94
;SerData = UDR0
	lds	SysValueCopy,UDR0
	sts	SERDATA,SysValueCopy
;End If
ENDIF94:
;End If
ENDIF93:
	ret

;********************************************************************************

;Overloaded signature: BYTE:, Source: usart.h (653)
HSERSEND275:
;AVR USART1 Send
;Wait While UDRE0 = Off    'Blocking Both Transmit buffer empty ,ready for data
SysWaitLoop2:
	lds	SysBitTest,UCSR0A
	sbrs	SysBitTest,UDRE0
	rjmp	SysWaitLoop2
;UDR0 = SerData ' *******************
	lds	SysValueCopy,SERDATA
	sts	UDR0,SysValueCopy
	ret

;********************************************************************************

;Overloaded signature: BYTE:byte:, Source: usart.h (736)
HSERSEND276:
;AVR USART1 Send
;if comport = 1 Then
	lds	SysCalcTempA,COMPORT
	cpi	SysCalcTempA,1
	brne	ENDIF92
;HSerSendBlocker    'comport 1 blocker
;Wait While UDRE0 = Off    'Blocking Both Transmit buffer empty ,ready for data
SysWaitLoop3:
	lds	SysBitTest,UCSR0A
	sbrs	SysBitTest,UDRE0
	rjmp	SysWaitLoop3
;#ifndef Var(UDR0)
;#ifdef Var(UDR1)
;UDR1 = SerData    '? second comport
;#endif
;#endif
;UDR0 = SerData ' *******************
	lds	SysValueCopy,SERDATA
	sts	UDR0,SysValueCopy
;End If
ENDIF92:
;----------------------------------------------------
;AVR USART 2 send
;AVR USART 3 send
;AVR USART 4 send
	ret

;********************************************************************************

;Source: hwspi.h (595)
HWSPITRANSFER:
;Master mode
;If SPICurrentMode > 10 Then
	ldi	SysCalcTempA,10
	lds	SysCalcTempB,SPICURRENTMODE
	cp	SysCalcTempA,SysCalcTempB
	brsh	ELSE64_1
;Put byte to send into buffer
;Will start transfer
;Do
SysDoLoop_S11:
;SPDR = SPITxData
	lds	SysValueCopy,SPITXDATA
	out	SPDR,SysValueCopy
;Loop While SPSR.WCOL
	in	SysBitTest,SPSR
	sbrc	SysBitTest,WCOL
	rjmp	SysDoLoop_S11
SysDoLoop_E11:
;Slave mode
;Else
	rjmp	ENDIF64
ELSE64_1:
;Retry until send succeeds
;Do
SysDoLoop_S12:
;SPDR = SPITxData
	lds	SysValueCopy,SPITXDATA
	out	SPDR,SysValueCopy
;Loop While SPSR.WCOL = On
	in	SysBitTest,SPSR
	sbrc	SysBitTest,WCOL
	rjmp	SysDoLoop_S12
SysDoLoop_E12:
;End If
ENDIF64:
;Read buffer
;Same for master and slave
;Wait While SPSR.SPIF = Off
SysWaitLoop1:
	in	SysBitTest,SPSR
	sbrs	SysBitTest,SPIF
	rjmp	SysWaitLoop1
;SPIRxData = SPDR
	in	SysValueCopy,SPDR
	sts	SPIRXDATA,SysValueCopy
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

;Source: uno_mega328p.h (61)
INITUNO:
;Set UART pin directions
;Dir PORTD.0 In
	cbi	DDRD,0
;Dir PORTD.1 Out
	sbi	DDRD,1
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
	ldi	SysValueCopy,33
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

;Source: string.h (354)
FN_LEFT:
;Empty input?
;If SysInString(0) = 0 Then
	lds	SysStringA,SysSYSINSTRINGHandler
	lds	SysStringA_H,SysSYSINSTRINGHandler_H
	ld	SysCalcTempA,X
	tst	SysCalcTempA
	brne	ENDIF70
;Left(0) = 0
	ldi	SysValueCopy,0
	sts	SYSLEFT_0,SysValueCopy
;Exit Function
	ret
;End If
ENDIF70:
;Input length too high?
;If SysInString(0) < SysCharCount Then
	lds	SysStringA,SysSYSINSTRINGHandler
	lds	SysStringA_H,SysSYSINSTRINGHandler_H
	ld	SysCalcTempA,X
	lds	SysCalcTempB,SYSCHARCOUNT
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF71
;SysCharCount = SysInString(0)
	lds	SysStringA,SysSYSINSTRINGHandler
	lds	SysStringA_H,SysSYSINSTRINGHandler_H
	ld	SysValueCopy,X
	sts	SYSCHARCOUNT,SysValueCopy
;End If
ENDIF71:
;Copy leftmost characters
;For SysStringTemp = 1 To SysCharCount
	ldi	SysValueCopy,0
	sts	SYSSTRINGTEMP,SysValueCopy
	lds	SysCalcTempA,SYSCHARCOUNT
	cpi	SysCalcTempA,1
	brlo	SysForLoopEnd9
SysForLoop9:
	lds	SysTemp3,SYSSTRINGTEMP
	inc	SysTemp3
	sts	SYSSTRINGTEMP,SysTemp3
;Left(SysStringTemp) = SysInString(SysStringTemp)
	lds	SysTemp3,SysSYSINSTRINGHandler
	lds	SysTemp1,SYSSTRINGTEMP
	add	SysTemp3,SysTemp1
	mov	SysStringA,SysTemp3
	lds	SysTemp3,SysSYSINSTRINGHandler_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	mov	SysStringA_H,SysTemp3
	ld	SysValueCopy,X+
	sts	SysArrayTemp2,SysValueCopy
	sts	SysArrayTemp1,SysValueCopy
	lds	SysTemp3,SYSSTRINGTEMP
	ldi	SysTemp4,low(LEFT)
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	ldi	SysTemp4,0
	ldi	SysTemp5,high(LEFT)
	adc	SysTemp4,SysTemp5
	mov	SysStringA_H,SysTemp4
	lds	SysValueCopy,SysArrayTemp1
	st	X+,SysValueCopy
;Next
	lds	SysCalcTempA,SYSSTRINGTEMP
	lds	SysCalcTempB,SYSCHARCOUNT
	cp	SysCalcTempA,SysCalcTempB
	brlo	SysForLoop9
SysForLoopEnd9:
;Left(0) = SysCharCount
	lds	SysValueCopy,SYSCHARCOUNT
	sts	SYSLEFT_0,SysValueCopy
	ret

;********************************************************************************

;Source: string.h (40)
FN_LEN:
;Len = LENTemp(0)
	lds	SysStringA,SysLENTEMPHandler
	lds	SysStringA_H,SysLENTEMPHandler_H
	ld	SysValueCopy,X
	sts	LEN,SysValueCopy
	ret

;********************************************************************************

;Source: MySDLib.h (434)
LSB_TO_MSB:
;B1=FnLSL(B1,8)
	lds	SYSLONGTEMPB,B1
	lds	SYSLONGTEMPB_H,B1_H
	lds	SYSLONGTEMPB_U,B1_U
	lds	SYSLONGTEMPB_E,B1_E
	ldi	SysValueCopy,8
	sts	NUMBITS,SysValueCopy
	rcall	FN_FNLSL115
	lds	SysValueCopy,SYSFNLSLLONG
	sts	B1,SysValueCopy
	lds	SysValueCopy,SYSFNLSLLONG_H
	sts	B1_H,SysValueCopy
	lds	SysValueCopy,SYSFNLSLLONG_U
	sts	B1_U,SysValueCopy
	lds	SysValueCopy,SYSFNLSLLONG_E
	sts	B1_E,SysValueCopy
;B2=FnLSL(B2,16)
	lds	SYSLONGTEMPB,B2
	lds	SYSLONGTEMPB_H,B2_H
	lds	SYSLONGTEMPB_U,B2_U
	lds	SYSLONGTEMPB_E,B2_E
	ldi	SysValueCopy,16
	sts	NUMBITS,SysValueCopy
	rcall	FN_FNLSL115
	lds	SysValueCopy,SYSFNLSLLONG
	sts	B2,SysValueCopy
	lds	SysValueCopy,SYSFNLSLLONG_H
	sts	B2_H,SysValueCopy
	lds	SysValueCopy,SYSFNLSLLONG_U
	sts	B2_U,SysValueCopy
	lds	SysValueCopy,SYSFNLSLLONG_E
	sts	B2_E,SysValueCopy
;B3=FnLSL(B3,24)
	lds	SYSLONGTEMPB,B3
	lds	SYSLONGTEMPB_H,B3_H
	lds	SYSLONGTEMPB_U,B3_U
	lds	SYSLONGTEMPB_E,B3_E
	ldi	SysValueCopy,24
	sts	NUMBITS,SysValueCopy
	rcall	FN_FNLSL115
	lds	SysValueCopy,SYSFNLSLLONG
	sts	B3,SysValueCopy
	lds	SysValueCopy,SYSFNLSLLONG_H
	sts	B3_H,SysValueCopy
	lds	SysValueCopy,SYSFNLSLLONG_U
	sts	B3_U,SysValueCopy
	lds	SysValueCopy,SYSFNLSLLONG_E
	sts	B3_E,SysValueCopy
;Output=B0+B1+B2+B3
	lds	SysTemp3,B0
	lds	SysTemp2,B1
	add	SysTemp3,SysTemp2
	mov	SysTemp1,SysTemp3
	lds	SysTemp3,B0_H
	lds	SysTemp2,B1_H
	adc	SysTemp3,SysTemp2
	mov	SysTemp1_H,SysTemp3
	lds	SysTemp3,B0_U
	lds	SysTemp2,B1_U
	adc	SysTemp3,SysTemp2
	mov	SysTemp1_U,SysTemp3
	lds	SysTemp3,B0_E
	lds	SysTemp2,B1_E
	adc	SysTemp3,SysTemp2
	mov	SysTemp1_E,SysTemp3
	lds	SysTemp3,B2
	add	SysTemp1,SysTemp3
	mov	SysTemp2,SysTemp1
	lds	SysTemp3,B2_H
	adc	SysTemp1_H,SysTemp3
	mov	SysTemp2_H,SysTemp1_H
	lds	SysTemp3,B2_U
	adc	SysTemp1_U,SysTemp3
	mov	SysTemp2_U,SysTemp1_U
	lds	SysTemp3,B2_E
	adc	SysTemp1_E,SysTemp3
	mov	SysTemp2_E,SysTemp1_E
	lds	SysTemp3,B3
	add	SysTemp2,SysTemp3
	sts	OUTPUT,SysTemp2
	lds	SysTemp3,B3_H
	adc	SysTemp2_H,SysTemp3
	sts	OUTPUT_H,SysTemp2_H
	lds	SysTemp3,B3_U
	adc	SysTemp2_U,SysTemp3
	sts	OUTPUT_U,SysTemp2_U
	lds	SysTemp3,B3_E
	adc	SysTemp2_E,SysTemp3
	sts	OUTPUT_E,SysTemp2_E
	ret

;********************************************************************************

;Source: MySDLib.h (390)
PARTITION_ENTRY_AND_RELEVANT_DATA:
;Draw_Line(1,60,"-")
	ldi	SysValueCopy,1
	sts	LINE_TYPE,SysValueCopy
	ldi	SysValueCopy,60
	sts	N_CHAR,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable22<<1)
	ldi	SysReadA_H,high(StringTable22<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysCHARHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysCHARHandler_H,SysValueCopy
	rcall	DRAW_LINE
;sertxd(1,"     Reading MBR at 0x1BE and ","Partition Volume ID data",0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable105<<1)
	ldi	SysReadA_H,high(StringTable105<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM4)
	ldi	SysStringB_H,high(SYSSTRINGPARAM4)
	ldi	SysReadA,low(StringTable106<<1)
	ldi	SysReadA_H,high(StringTable106<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM4)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM4)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	rcall	SERTXD7
;Draw_Line(1,60,"-"):Draw_Line(1,60," ")
	ldi	SysValueCopy,1
	sts	LINE_TYPE,SysValueCopy
	ldi	SysValueCopy,60
	sts	N_CHAR,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable22<<1)
	ldi	SysReadA_H,high(StringTable22<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysCHARHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysCHARHandler_H,SysValueCopy
	rcall	DRAW_LINE
	ldi	SysValueCopy,1
	sts	LINE_TYPE,SysValueCopy
	ldi	SysValueCopy,60
	sts	N_CHAR,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable10<<1)
	ldi	SysReadA_H,high(StringTable10<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysCHARHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysCHARHandler_H,SysValueCopy
	rcall	DRAW_LINE
;Read_Partit_Entry          'Read Partition begin address at 0x1BE
	rcall	READ_PARTIT_ENTRY
;Read_Relevant_Partit_Data  'Read most relevant Partition Data
	rcall	READ_RELEVANT_PARTIT_DATA
;sertxd(1,"  File System ",SD_MyString,0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable107<<1)
	ldi	SysReadA_H,high(StringTable107<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysValueCopy,low(SD_MYSTRING)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SD_MYSTRING)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	rcall	SERTXD7
;sertxd(1,"  File System Ver Num.=",File_System_Ver_Num,0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable108<<1)
	ldi	SysReadA_H,high(StringTable108<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysValueCopy,FILE_SYSTEM_VER_NUM
	sts	INPUTB,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	rcall	SERTXD8
;sertxd(1,"  Volume_Label=",SD_MyString1,0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable109<<1)
	ldi	SysReadA_H,high(StringTable109<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysValueCopy,low(SD_MYSTRING1)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SD_MYSTRING1)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	rcall	SERTXD7
;sertxd(1,"  N. Bytes per Sector=",N_Bytes_per_Sector,0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable110<<1)
	ldi	SysReadA_H,high(StringTable110<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysValueCopy,N_BYTES_PER_SECTOR
	sts	INPUTW,SysValueCopy
	lds	SysValueCopy,N_BYTES_PER_SECTOR_H
	sts	INPUTW_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	rcall	SERTXD9
;sertxd(1,"  N. Sector per Cluster=",N_Sector_per_cluster,0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable111<<1)
	ldi	SysReadA_H,high(StringTable111<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysValueCopy,N_SECTOR_PER_CLUSTER
	sts	INPUTB,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	rcall	SERTXD8
;sertxd(1,"  N. Reserved Sectors=",N_Reserved_Sector,0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable112<<1)
	ldi	SysReadA_H,high(StringTable112<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysValueCopy,N_RESERVED_SECTOR
	sts	INPUTW,SysValueCopy
	lds	SysValueCopy,N_RESERVED_SECTOR_H
	sts	INPUTW_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	rcall	SERTXD9
;sertxd(1,"  N. FATS=",N_FATS,0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable113<<1)
	ldi	SysReadA_H,high(StringTable113<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysValueCopy,N_FATS
	sts	INPUTB,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	rcall	SERTXD8
;sertxd(1,"  N. Sector per Fat=",N_Sectors_per_Fat,0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable114<<1)
	ldi	SysReadA_H,high(StringTable114<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysValueCopy,N_SECTORS_PER_FAT
	sts	INPUTL,SysValueCopy
	lds	SysValueCopy,N_SECTORS_PER_FAT_H
	sts	INPUTL_H,SysValueCopy
	lds	SysValueCopy,N_SECTORS_PER_FAT_U
	sts	INPUTL_U,SysValueCopy
	lds	SysValueCopy,N_SECTORS_PER_FAT_E
	sts	INPUTL_E,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	rcall	SERTXD10
;sertxd(1,"  N. Cluster of Root Dir=","2",0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable115<<1)
	ldi	SysReadA_H,high(StringTable115<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM4)
	ldi	SysStringB_H,high(SYSSTRINGPARAM4)
	ldi	SysReadA,low(StringTable116<<1)
	ldi	SysReadA_H,high(StringTable116<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM4)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM4)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	rcall	SERTXD7
;Draw_Line(1,60," "): Draw_Line(2,30,"-"):Draw_Line(1,60," ")
	ldi	SysValueCopy,1
	sts	LINE_TYPE,SysValueCopy
	ldi	SysValueCopy,60
	sts	N_CHAR,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable10<<1)
	ldi	SysReadA_H,high(StringTable10<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysCHARHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysCHARHandler_H,SysValueCopy
	rcall	DRAW_LINE
	ldi	SysValueCopy,2
	sts	LINE_TYPE,SysValueCopy
	ldi	SysValueCopy,30
	sts	N_CHAR,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable22<<1)
	ldi	SysReadA_H,high(StringTable22<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysCHARHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysCHARHandler_H,SysValueCopy
	rcall	DRAW_LINE
	ldi	SysValueCopy,1
	sts	LINE_TYPE,SysValueCopy
	ldi	SysValueCopy,60
	sts	N_CHAR,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable10<<1)
	ldi	SysReadA_H,high(StringTable10<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysCHARHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysCHARHandler_H,SysValueCopy
	rcall	DRAW_LINE
;sertxd(1,"  Partition_Begin_LBA=",Partition_Begin_LBA,0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable117<<1)
	ldi	SysReadA_H,high(StringTable117<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysValueCopy,PARTITION_BEGIN_LBA
	sts	INPUTL,SysValueCopy
	lds	SysValueCopy,PARTITION_BEGIN_LBA_H
	sts	INPUTL_H,SysValueCopy
	lds	SysValueCopy,PARTITION_BEGIN_LBA_U
	sts	INPUTL_U,SysValueCopy
	lds	SysValueCopy,PARTITION_BEGIN_LBA_E
	sts	INPUTL_E,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	rcall	SERTXD10
;Fat_Begin_LBA=Partition_Begin_LBA+N_Reserved_Sector
	lds	SysTemp3,PARTITION_BEGIN_LBA
	lds	SysTemp1,N_RESERVED_SECTOR
	add	SysTemp3,SysTemp1
	sts	FAT_BEGIN_LBA,SysTemp3
	lds	SysTemp3,PARTITION_BEGIN_LBA_H
	lds	SysTemp1,N_RESERVED_SECTOR_H
	adc	SysTemp3,SysTemp1
	sts	FAT_BEGIN_LBA_H,SysTemp3
	lds	SysTemp3,PARTITION_BEGIN_LBA_U
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	sts	FAT_BEGIN_LBA_U,SysTemp3
	lds	SysTemp3,PARTITION_BEGIN_LBA_E
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	sts	FAT_BEGIN_LBA_E,SysTemp3
;Cluster_Begin_LBA=Fat_Begin_LBA+N_FATS*N_Sectors_per_Fat
	lds	SysLONGTempA,N_FATS
	ldi	SysLONGTempA_H,0
	ldi	SysLONGTempA_U,0
	ldi	SysLONGTempA_E,0
	lds	SysLONGTempB,N_SECTORS_PER_FAT
	lds	SysLONGTempB_H,N_SECTORS_PER_FAT_H
	lds	SysLONGTempB_U,N_SECTORS_PER_FAT_U
	lds	SysLONGTempB_E,N_SECTORS_PER_FAT_E
	call	SysMultSub32
	lds	SysTemp3,FAT_BEGIN_LBA
	add	SysTemp3,SysLONGTempX
	sts	CLUSTER_BEGIN_LBA,SysTemp3
	lds	SysTemp3,FAT_BEGIN_LBA_H
	adc	SysTemp3,SysLONGTempX_H
	sts	CLUSTER_BEGIN_LBA_H,SysTemp3
	lds	SysTemp3,FAT_BEGIN_LBA_U
	adc	SysTemp3,SysLONGTempX_U
	sts	CLUSTER_BEGIN_LBA_U,SysTemp3
	lds	SysTemp3,FAT_BEGIN_LBA_E
	adc	SysTemp3,SysLONGTempX_E
	sts	CLUSTER_BEGIN_LBA_E,SysTemp3
;sertxd(1,"  Fat_Begin_LBA=",Fat_Begin_LBA,0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable118<<1)
	ldi	SysReadA_H,high(StringTable118<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysValueCopy,FAT_BEGIN_LBA
	sts	INPUTL,SysValueCopy
	lds	SysValueCopy,FAT_BEGIN_LBA_H
	sts	INPUTL_H,SysValueCopy
	lds	SysValueCopy,FAT_BEGIN_LBA_U
	sts	INPUTL_U,SysValueCopy
	lds	SysValueCopy,FAT_BEGIN_LBA_E
	sts	INPUTL_E,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	rcall	SERTXD10
;sertxd(1,"  Cluster_Begin_LBA=",Cluster_Begin_LBA,0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable119<<1)
	ldi	SysReadA_H,high(StringTable119<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysValueCopy,CLUSTER_BEGIN_LBA
	sts	INPUTL,SysValueCopy
	lds	SysValueCopy,CLUSTER_BEGIN_LBA_H
	sts	INPUTL_H,SysValueCopy
	lds	SysValueCopy,CLUSTER_BEGIN_LBA_U
	sts	INPUTL_U,SysValueCopy
	lds	SysValueCopy,CLUSTER_BEGIN_LBA_E
	sts	INPUTL_E,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	rcall	SERTXD10
;Draw_Line(1,60,"-"): Draw_Line(1,60," ")
	ldi	SysValueCopy,1
	sts	LINE_TYPE,SysValueCopy
	ldi	SysValueCopy,60
	sts	N_CHAR,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable22<<1)
	ldi	SysReadA_H,high(StringTable22<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysCHARHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysCHARHandler_H,SysValueCopy
	rcall	DRAW_LINE
	ldi	SysValueCopy,1
	sts	LINE_TYPE,SysValueCopy
	ldi	SysValueCopy,60
	sts	N_CHAR,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable10<<1)
	ldi	SysReadA_H,high(StringTable10<<1)
	call	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysCHARHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysCHARHandler_H,SysValueCopy
	rjmp	DRAW_LINE

;********************************************************************************

;Source: MySDLib.h (421)
READ_PARTIT_ENTRY:
;SDRead_Block(0)
	ldi	SysValueCopy,0
	sts	BLOCK_START,SysValueCopy
	sts	BLOCK_START_H,SysValueCopy
	sts	BLOCK_START_U,SysValueCopy
	sts	BLOCK_START_E,SysValueCopy
	rcall	SDREAD_BLOCK
;SDByte=446
	ldi	SysValueCopy,190
	sts	SDBYTE,SysValueCopy
	ldi	SysValueCopy,1
	sts	SDBYTE_H,SysValueCopy
;B0=SDDataBuffer(SDByte+8)
	lds	SysTemp3,SDBYTE
	ldi	SysTemp4,8
	add	SysTemp3,SysTemp4
	mov	SysTemp1,SysTemp3
	lds	SysTemp3,SDBYTE_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	mov	SysTemp1_H,SysTemp3
	ldi	SysTemp4,low(SDDATABUFFER)
	add	SysTemp1,SysTemp4
	mov	SysStringA,SysTemp1
	ldi	SysTemp4,high(SDDATABUFFER)
	adc	SysTemp1_H,SysTemp4
	mov	SysStringA_H,SysTemp1_H
	ld	SysValueCopy,X
	sts	B0,SysValueCopy
	ldi	SysValueCopy,0
	sts	B0_H,SysValueCopy
	sts	B0_U,SysValueCopy
	sts	B0_E,SysValueCopy
;B1=SDDataBuffer(SDByte+9)
	lds	SysTemp3,SDBYTE
	ldi	SysTemp4,9
	add	SysTemp3,SysTemp4
	mov	SysTemp1,SysTemp3
	lds	SysTemp3,SDBYTE_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	mov	SysTemp1_H,SysTemp3
	ldi	SysTemp4,low(SDDATABUFFER)
	add	SysTemp1,SysTemp4
	mov	SysStringA,SysTemp1
	ldi	SysTemp4,high(SDDATABUFFER)
	adc	SysTemp1_H,SysTemp4
	mov	SysStringA_H,SysTemp1_H
	ld	SysValueCopy,X
	sts	B1,SysValueCopy
	ldi	SysValueCopy,0
	sts	B1_H,SysValueCopy
	sts	B1_U,SysValueCopy
	sts	B1_E,SysValueCopy
;B2=SDDataBuffer(SDByte+10)
	lds	SysTemp3,SDBYTE
	ldi	SysTemp4,10
	add	SysTemp3,SysTemp4
	mov	SysTemp1,SysTemp3
	lds	SysTemp3,SDBYTE_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	mov	SysTemp1_H,SysTemp3
	ldi	SysTemp4,low(SDDATABUFFER)
	add	SysTemp1,SysTemp4
	mov	SysStringA,SysTemp1
	ldi	SysTemp4,high(SDDATABUFFER)
	adc	SysTemp1_H,SysTemp4
	mov	SysStringA_H,SysTemp1_H
	ld	SysValueCopy,X
	sts	B2,SysValueCopy
	ldi	SysValueCopy,0
	sts	B2_H,SysValueCopy
	sts	B2_U,SysValueCopy
	sts	B2_E,SysValueCopy
;B3=SDDataBuffer(SDByte+11)
	lds	SysTemp3,SDBYTE
	ldi	SysTemp4,11
	add	SysTemp3,SysTemp4
	mov	SysTemp1,SysTemp3
	lds	SysTemp3,SDBYTE_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	mov	SysTemp1_H,SysTemp3
	ldi	SysTemp4,low(SDDATABUFFER)
	add	SysTemp1,SysTemp4
	mov	SysStringA,SysTemp1
	ldi	SysTemp4,high(SDDATABUFFER)
	adc	SysTemp1_H,SysTemp4
	mov	SysStringA_H,SysTemp1_H
	ld	SysValueCopy,X
	sts	B3,SysValueCopy
	ldi	SysValueCopy,0
	sts	B3_H,SysValueCopy
	sts	B3_U,SysValueCopy
	sts	B3_E,SysValueCopy
;LSB_to_MSB(Partition_Begin_LBA)
	lds	SysValueCopy,PARTITION_BEGIN_LBA
	sts	OUTPUT,SysValueCopy
	lds	SysValueCopy,PARTITION_BEGIN_LBA_H
	sts	OUTPUT_H,SysValueCopy
	lds	SysValueCopy,PARTITION_BEGIN_LBA_U
	sts	OUTPUT_U,SysValueCopy
	lds	SysValueCopy,PARTITION_BEGIN_LBA_E
	sts	OUTPUT_E,SysValueCopy
	rcall	LSB_TO_MSB
	lds	SysValueCopy,OUTPUT
	sts	PARTITION_BEGIN_LBA,SysValueCopy
	lds	SysValueCopy,OUTPUT_H
	sts	PARTITION_BEGIN_LBA_H,SysValueCopy
	lds	SysValueCopy,OUTPUT_U
	sts	PARTITION_BEGIN_LBA_U,SysValueCopy
	lds	SysValueCopy,OUTPUT_E
	sts	PARTITION_BEGIN_LBA_E,SysValueCopy
	ret

;********************************************************************************

;Source: MySDLib.h (442)
READ_RELEVANT_PARTIT_DATA:
;SDRead_Block(Partition_Begin_LBA)
	lds	SysValueCopy,PARTITION_BEGIN_LBA
	sts	BLOCK_START,SysValueCopy
	lds	SysValueCopy,PARTITION_BEGIN_LBA_H
	sts	BLOCK_START_H,SysValueCopy
	lds	SysValueCopy,PARTITION_BEGIN_LBA_U
	sts	BLOCK_START_U,SysValueCopy
	lds	SysValueCopy,PARTITION_BEGIN_LBA_E
	sts	BLOCK_START_E,SysValueCopy
	rcall	SDREAD_BLOCK
;B0=SDDataBuffer(11)
	lds	SysValueCopy,SYSSDDATABUFFER_11
	sts	B0,SysValueCopy
	ldi	SysValueCopy,0
	sts	B0_H,SysValueCopy
	sts	B0_U,SysValueCopy
	sts	B0_E,SysValueCopy
;B1=SDDataBuffer(12)
	lds	SysValueCopy,SYSSDDATABUFFER_12
	sts	B1,SysValueCopy
	ldi	SysValueCopy,0
	sts	B1_H,SysValueCopy
	sts	B1_U,SysValueCopy
	sts	B1_E,SysValueCopy
;N_Bytes_per_Sector=B0+FnLSL(B1,8)
	lds	SYSLONGTEMPB,B1
	lds	SYSLONGTEMPB_H,B1_H
	lds	SYSLONGTEMPB_U,B1_U
	lds	SYSLONGTEMPB_E,B1_E
	ldi	SysValueCopy,8
	sts	NUMBITS,SysValueCopy
	rcall	FN_FNLSL115
	lds	SysTemp3,B0
	lds	SysTemp1,SYSFNLSLLONG
	add	SysTemp3,SysTemp1
	sts	N_BYTES_PER_SECTOR,SysTemp3
	lds	SysTemp3,B0_H
	lds	SysTemp1,SYSFNLSLLONG_H
	adc	SysTemp3,SysTemp1
	sts	N_BYTES_PER_SECTOR_H,SysTemp3
;N_Sector_per_cluster=SDDataBuffer(13)
	lds	SysValueCopy,SYSSDDATABUFFER_13
	sts	N_SECTOR_PER_CLUSTER,SysValueCopy
;B0=SDDataBuffer(14)
	lds	SysValueCopy,SYSSDDATABUFFER_14
	sts	B0,SysValueCopy
	ldi	SysValueCopy,0
	sts	B0_H,SysValueCopy
	sts	B0_U,SysValueCopy
	sts	B0_E,SysValueCopy
;B1=SDDataBuffer(15)
	lds	SysValueCopy,SYSSDDATABUFFER_15
	sts	B1,SysValueCopy
	ldi	SysValueCopy,0
	sts	B1_H,SysValueCopy
	sts	B1_U,SysValueCopy
	sts	B1_E,SysValueCopy
;N_Reserved_Sector=B0+FnLSL(B1,8)
	lds	SYSLONGTEMPB,B1
	lds	SYSLONGTEMPB_H,B1_H
	lds	SYSLONGTEMPB_U,B1_U
	lds	SYSLONGTEMPB_E,B1_E
	ldi	SysValueCopy,8
	sts	NUMBITS,SysValueCopy
	rcall	FN_FNLSL115
	lds	SysTemp3,B0
	lds	SysTemp1,SYSFNLSLLONG
	add	SysTemp3,SysTemp1
	sts	N_RESERVED_SECTOR,SysTemp3
	lds	SysTemp3,B0_H
	lds	SysTemp1,SYSFNLSLLONG_H
	adc	SysTemp3,SysTemp1
	sts	N_RESERVED_SECTOR_H,SysTemp3
;N_FATS=SDDataBuffer(16)
	lds	SysValueCopy,SYSSDDATABUFFER_16
	sts	N_FATS,SysValueCopy
;B0=SDDataBuffer(36)
	lds	SysValueCopy,SYSSDDATABUFFER_36
	sts	B0,SysValueCopy
	ldi	SysValueCopy,0
	sts	B0_H,SysValueCopy
	sts	B0_U,SysValueCopy
	sts	B0_E,SysValueCopy
;B1=SDDataBuffer(37)
	lds	SysValueCopy,SYSSDDATABUFFER_37
	sts	B1,SysValueCopy
	ldi	SysValueCopy,0
	sts	B1_H,SysValueCopy
	sts	B1_U,SysValueCopy
	sts	B1_E,SysValueCopy
;B2=SDDataBuffer(38)
	lds	SysValueCopy,SYSSDDATABUFFER_38
	sts	B2,SysValueCopy
	ldi	SysValueCopy,0
	sts	B2_H,SysValueCopy
	sts	B2_U,SysValueCopy
	sts	B2_E,SysValueCopy
;B3=SDDataBuffer(39)
	lds	SysValueCopy,SYSSDDATABUFFER_39
	sts	B3,SysValueCopy
	ldi	SysValueCopy,0
	sts	B3_H,SysValueCopy
	sts	B3_U,SysValueCopy
	sts	B3_E,SysValueCopy
;LSB_to_MSB(N_Sectors_per_Fat)
	lds	SysValueCopy,N_SECTORS_PER_FAT
	sts	OUTPUT,SysValueCopy
	lds	SysValueCopy,N_SECTORS_PER_FAT_H
	sts	OUTPUT_H,SysValueCopy
	lds	SysValueCopy,N_SECTORS_PER_FAT_U
	sts	OUTPUT_U,SysValueCopy
	lds	SysValueCopy,N_SECTORS_PER_FAT_E
	sts	OUTPUT_E,SysValueCopy
	rcall	LSB_TO_MSB
	lds	SysValueCopy,OUTPUT
	sts	N_SECTORS_PER_FAT,SysValueCopy
	lds	SysValueCopy,OUTPUT_H
	sts	N_SECTORS_PER_FAT_H,SysValueCopy
	lds	SysValueCopy,OUTPUT_U
	sts	N_SECTORS_PER_FAT_U,SysValueCopy
	lds	SysValueCopy,OUTPUT_E
	sts	N_SECTORS_PER_FAT_E,SysValueCopy
;B0=SDDataBuffer(42)
	lds	SysValueCopy,SYSSDDATABUFFER_42
	sts	B0,SysValueCopy
	ldi	SysValueCopy,0
	sts	B0_H,SysValueCopy
	sts	B0_U,SysValueCopy
	sts	B0_E,SysValueCopy
;B1=SDDataBuffer(43)
	lds	SysValueCopy,SYSSDDATABUFFER_43
	sts	B1,SysValueCopy
	ldi	SysValueCopy,0
	sts	B1_H,SysValueCopy
	sts	B1_U,SysValueCopy
	sts	B1_E,SysValueCopy
;File_System_Ver_Num=B0+FnLSL(B1,8)
	lds	SYSLONGTEMPB,B1
	lds	SYSLONGTEMPB_H,B1_H
	lds	SYSLONGTEMPB_U,B1_U
	lds	SYSLONGTEMPB_E,B1_E
	ldi	SysValueCopy,8
	sts	NUMBITS,SysValueCopy
	rcall	FN_FNLSL115
	lds	SysTemp3,B0
	lds	SysTemp1,SYSFNLSLLONG
	add	SysTemp3,SysTemp1
	sts	FILE_SYSTEM_VER_NUM,SysTemp3
;N_Sector_of_FAT2=SDDataBuffer(50)
	lds	SysValueCopy,SYSSDDATABUFFER_50
	sts	N_SECTOR_OF_FAT2,SysValueCopy
;SD_MyString1=CHR(SDDataBuffer(71))
	lds	SysValueCopy,SYSSDDATABUFFER_71
	sts	SYSCHAR,SysValueCopy
	call	FN_CHR
	ldi	SysStringB,low(SD_MYSTRING1)
	ldi	SysStringB_H,high(SD_MYSTRING1)
	ldi	SysStringA,low(CHR)
	ldi	SysStringA_H,high(CHR)
	rcall	SysCopyString
;for SD_Counter=1 to 10
	ldi	SysValueCopy,0
	sts	SD_COUNTER,SysValueCopy
	sts	SD_COUNTER_H,SysValueCopy
SysForLoop2:
	lds	SysTemp3,SD_COUNTER
	inc	SysTemp3
	sts	SD_COUNTER,SysTemp3
	lds	SysTemp3,SD_COUNTER_H
	brne	PC + 2
	inc	SysTemp3
	sts	SD_COUNTER_H,SysTemp3
;SD_MyString2=SD_MyString1+CHR(SDDataBuffer(71+SD_Counter))
	lds	SysTemp3,SD_COUNTER
	ldi	SysTemp4,71
	add	SysTemp3,SysTemp4
	mov	SysTemp1,SysTemp3
	lds	SysTemp3,SD_COUNTER_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	mov	SysTemp1_H,SysTemp3
	ldi	SysTemp4,low(SDDATABUFFER)
	add	SysTemp1,SysTemp4
	mov	SysStringA,SysTemp1
	ldi	SysTemp4,high(SDDATABUFFER)
	adc	SysTemp1_H,SysTemp4
	mov	SysStringA_H,SysTemp1_H
	ld	SysValueCopy,X
	sts	SYSCHAR,SysValueCopy
	call	FN_CHR
	ldi	SysStringB,low(SD_MYSTRING2)
	ldi	SysStringB_H,high(SD_MYSTRING2)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysStringA,low(SD_MYSTRING1)
	ldi	SysStringA_H,high(SD_MYSTRING1)
	rcall	SysCopyStringPart
	ldi	SysStringA,low(CHR)
	ldi	SysStringA_H,high(CHR)
	rcall	SysCopyStringPart
	ldi	SysStringA,low(SD_MYSTRING2)
	ldi	SysStringA_H,high(SD_MYSTRING2)
	st	X, SysStringLength
;SD_MyString1=SD_MyString2
	ldi	SysStringB,low(SD_MYSTRING1)
	ldi	SysStringB_H,high(SD_MYSTRING1)
	ldi	SysStringA,low(SD_MYSTRING2)
	ldi	SysStringA_H,high(SD_MYSTRING2)
	rcall	SysCopyString
;next
	lds	SysWORDTempA,SD_COUNTER
	lds	SysWORDTempA_H,SD_COUNTER_H
	ldi	SysWORDTempB,10
	ldi	SysWORDTempB_H,0
	rcall	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop2
SysForLoopEnd2:
;SD_MyString=CHR(SDDataBuffer(82))
	lds	SysValueCopy,SYSSDDATABUFFER_82
	sts	SYSCHAR,SysValueCopy
	call	FN_CHR
	ldi	SysStringB,low(SD_MYSTRING)
	ldi	SysStringB_H,high(SD_MYSTRING)
	ldi	SysStringA,low(CHR)
	ldi	SysStringA_H,high(CHR)
	rcall	SysCopyString
;for SD_Counter=1 to 7
	ldi	SysValueCopy,0
	sts	SD_COUNTER,SysValueCopy
	sts	SD_COUNTER_H,SysValueCopy
SysForLoop3:
	lds	SysTemp3,SD_COUNTER
	inc	SysTemp3
	sts	SD_COUNTER,SysTemp3
	lds	SysTemp3,SD_COUNTER_H
	brne	PC + 2
	inc	SysTemp3
	sts	SD_COUNTER_H,SysTemp3
;SD_MyString2=SD_MyString+CHR(SDDataBuffer(82+SD_Counter))
	lds	SysTemp3,SD_COUNTER
	ldi	SysTemp4,82
	add	SysTemp3,SysTemp4
	mov	SysTemp1,SysTemp3
	lds	SysTemp3,SD_COUNTER_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	mov	SysTemp1_H,SysTemp3
	ldi	SysTemp4,low(SDDATABUFFER)
	add	SysTemp1,SysTemp4
	mov	SysStringA,SysTemp1
	ldi	SysTemp4,high(SDDATABUFFER)
	adc	SysTemp1_H,SysTemp4
	mov	SysStringA_H,SysTemp1_H
	ld	SysValueCopy,X
	sts	SYSCHAR,SysValueCopy
	call	FN_CHR
	ldi	SysStringB,low(SD_MYSTRING2)
	ldi	SysStringB_H,high(SD_MYSTRING2)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysStringA,low(SD_MYSTRING)
	ldi	SysStringA_H,high(SD_MYSTRING)
	rcall	SysCopyStringPart
	ldi	SysStringA,low(CHR)
	ldi	SysStringA_H,high(CHR)
	rcall	SysCopyStringPart
	ldi	SysStringA,low(SD_MYSTRING2)
	ldi	SysStringA_H,high(SD_MYSTRING2)
	st	X, SysStringLength
;SD_MyString=SD_MyString2
	ldi	SysStringB,low(SD_MYSTRING)
	ldi	SysStringB_H,high(SD_MYSTRING)
	ldi	SysStringA,low(SD_MYSTRING2)
	ldi	SysStringA_H,high(SD_MYSTRING2)
	rcall	SysCopyString
;next
	lds	SysWORDTempA,SD_COUNTER
	lds	SysWORDTempA_H,SD_COUNTER_H
	ldi	SysWORDTempB,7
	ldi	SysWORDTempB_H,0
	rcall	SysCompLessThan16
	sbrc	SysByteTempX,0
	rjmp	SysForLoop3
SysForLoopEnd3:
	ret

;********************************************************************************

;Source: string.h (373)
FN_RIGHT:
;Empty input?
;If SysInString(0) = 0 Then
	lds	SysStringA,SysSYSINSTRINGHandler
	lds	SysStringA_H,SysSYSINSTRINGHandler_H
	ld	SysCalcTempA,X
	tst	SysCalcTempA
	brne	ENDIF74
;Right(0) = 0
	ldi	SysValueCopy,0
	sts	SYSRIGHT_0,SysValueCopy
;Exit Function
	ret
;End If
ENDIF74:
;Input length too high?
;If SysInString(0) < SysCharCount Then
	lds	SysStringA,SysSYSINSTRINGHandler
	lds	SysStringA_H,SysSYSINSTRINGHandler_H
	ld	SysCalcTempA,X
	lds	SysCalcTempB,SYSCHARCOUNT
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF75
;SysCharCount = SysInString(0)
	lds	SysStringA,SysSYSINSTRINGHandler
	lds	SysStringA_H,SysSYSINSTRINGHandler_H
	ld	SysValueCopy,X
	sts	SYSCHARCOUNT,SysValueCopy
;End If
ENDIF75:
;Copy rightmost characters
;SysCharStart = SysInString(0) - SysCharCount
	lds	SysStringA,SysSYSINSTRINGHandler
	lds	SysStringA_H,SysSYSINSTRINGHandler_H
	ld	SysTemp3,X
	lds	SysTemp1,SYSCHARCOUNT
	sub	SysTemp3,SysTemp1
	sts	SYSCHARSTART,SysTemp3
;For SysStringTemp = 1 To SysCharCount
	ldi	SysValueCopy,0
	sts	SYSSTRINGTEMP,SysValueCopy
	lds	SysCalcTempA,SYSCHARCOUNT
	cpi	SysCalcTempA,1
	brlo	SysForLoopEnd10
SysForLoop10:
	lds	SysTemp3,SYSSTRINGTEMP
	inc	SysTemp3
	sts	SYSSTRINGTEMP,SysTemp3
;Right(SysStringTemp) = SysInString(SysCharStart + SysStringTemp)
	lds	SysTemp1,SYSCHARSTART
	lds	SysTemp2,SYSSTRINGTEMP
	add	SysTemp1,SysTemp2
	mov	SysTemp3,SysTemp1
	lds	SysTemp1,SysSYSINSTRINGHandler
	add	SysTemp1,SysTemp3
	mov	SysStringA,SysTemp1
	lds	SysTemp3,SysSYSINSTRINGHandler_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	mov	SysStringA_H,SysTemp3
	ld	SysValueCopy,X+
	sts	SysArrayTemp2,SysValueCopy
	sts	SysArrayTemp1,SysValueCopy
	lds	SysTemp3,SYSSTRINGTEMP
	ldi	SysTemp4,low(RIGHT)
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	ldi	SysTemp4,0
	ldi	SysTemp5,high(RIGHT)
	adc	SysTemp4,SysTemp5
	mov	SysStringA_H,SysTemp4
	lds	SysValueCopy,SysArrayTemp1
	st	X+,SysValueCopy
;Next
	lds	SysCalcTempA,SYSSTRINGTEMP
	lds	SysCalcTempB,SYSCHARCOUNT
	cp	SysCalcTempA,SysCalcTempB
	brlo	SysForLoop10
SysForLoopEnd10:
;Right(0) = SysCharCount
	lds	SysValueCopy,SYSCHARCOUNT
	sts	SYSRIGHT_0,SysValueCopy
	ret

;********************************************************************************

;Source: MySDLib.h (36)
SDINITIALIZE:
;INITIALIZATION TO Transfer state
;Syncronization and CMD0 Command
;INITSucc=0
	ldi	SysValueCopy,0
	sts	INITSUCC,SysValueCopy
;SDResponse=100
	ldi	SysValueCopy,100
	sts	SDRESPONSE,SysValueCopy
;do until INITSucc=1
SysDoLoop_S1:
	lds	SysCalcTempA,INITSUCC
	cpi	SysCalcTempA,1
	brne	PC + 2
	rjmp	SysDoLoop_E1
;Draw_Line(1,20," ")
	ldi	SysValueCopy,1
	sts	LINE_TYPE,SysValueCopy
	ldi	SysValueCopy,20
	sts	N_CHAR,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM4)
	ldi	SysStringB_H,high(SYSSTRINGPARAM4)
	ldi	SysReadA,low(StringTable10<<1)
	ldi	SysReadA_H,high(StringTable10<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM4)
	sts	SysCHARHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM4)
	sts	SysCHARHandler_H,SysValueCopy
	call	DRAW_LINE
;sertxd(1,"* Initialization"," Starts *",1)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM4)
	ldi	SysStringB_H,high(SYSSTRINGPARAM4)
	ldi	SysReadA,low(StringTable42<<1)
	ldi	SysReadA_H,high(StringTable42<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM4)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM4)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable43<<1)
	ldi	SysReadA_H,high(StringTable43<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	CRLF2,SysValueCopy
	rcall	SERTXD7
;CallCMD0              'CMD0 Command
	call	CALLCMD0
;CallCMD8              'CMD8 Command
	call	CALLCMD8
;CallCMD58             'CMD58 Command
	call	CALLCMD58
;CallACMD41            'ACDMD41 Command
	call	CALLACMD41
;CallCMD13             'CMD13 Command  sembra che con le sanDisk non sia gradito
;ma con le SD PNY funziona bene!!
;CallCMD58             'CMD58 Command
	call	CALLCMD58
;CallCMD16             'CMD16 Command
	call	CALLCMD16
;Loop
	rjmp	SysDoLoop_S1
SysDoLoop_E1:
;if INITSucc=1 then
	lds	SysCalcTempA,INITSUCC
	cpi	SysCalcTempA,1
	brne	ELSE19_1
;sertxd(2,"* Initialization"," successfull *",1)
	ldi	SysValueCopy,2
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM4)
	ldi	SysStringB_H,high(SYSSTRINGPARAM4)
	ldi	SysReadA,low(StringTable42<<1)
	ldi	SysReadA_H,high(StringTable42<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM4)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM4)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable44<<1)
	ldi	SysReadA_H,high(StringTable44<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	CRLF2,SysValueCopy
	rcall	SERTXD7
;else
	rjmp	ENDIF19
ELSE19_1:
;sertxd(2,"* Initialization"," UNSUCCESSFULL *",1)
	ldi	SysValueCopy,2
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM4)
	ldi	SysStringB_H,high(SYSSTRINGPARAM4)
	ldi	SysReadA,low(StringTable42<<1)
	ldi	SysReadA_H,high(StringTable42<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM4)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM4)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM3)
	ldi	SysStringB_H,high(SYSSTRINGPARAM3)
	ldi	SysReadA,low(StringTable45<<1)
	ldi	SysReadA_H,high(StringTable45<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM3)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM3)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	CRLF2,SysValueCopy
	rcall	SERTXD7
;wait 1 s
	ldi	SysWaitTempS,1
	call	Delay_S
;end if
ENDIF19:
;SET SD_Adaper_CS ON
	sbi	PORTB,2
	ret

;********************************************************************************

;Source: MySDLib.h (339)
SDREAD_BLOCK:
;SDResponse=100
	ldi	SysValueCopy,100
	sts	SDRESPONSE,SysValueCopy
;SDToken=100
	ldi	SysValueCopy,100
	sts	SDTOKEN,SysValueCopy
;SD_Counter=0
	ldi	SysValueCopy,0
	sts	SD_COUNTER,SysValueCopy
	sts	SD_COUNTER_H,SysValueCopy
;if Verbose="ON" then
	ldi	SysStringB,low(SYSTEMPARRAY)
	ldi	SysStringB_H,high(SYSTEMPARRAY)
	ldi	SysReadA,low(StringTable17<<1)
	ldi	SysReadA_H,high(StringTable17<<1)
	rcall	SysReadString
	ldi	SysStringA,low(VERBOSE)
	ldi	SysStringA_H,high(VERBOSE)
	ldi	SysStringB,low(SYSTEMPARRAY)
	ldi	SysStringB_H,high(SYSTEMPARRAY)
	rcall	SysCompEqualString
	sbrs	SysByteTempX,0
	rjmp	ENDIF36
;Draw_Line(2,20,"=")
	ldi	SysValueCopy,2
	sts	LINE_TYPE,SysValueCopy
	ldi	SysValueCopy,20
	sts	N_CHAR,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable18<<1)
	ldi	SysReadA_H,high(StringTable18<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysCHARHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysCHARHandler_H,SysValueCopy
	call	DRAW_LINE
;sertxd(1,"-CMD17  ","Waiting for Token",0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable96<<1)
	ldi	SysReadA_H,high(StringTable96<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM8)
	ldi	SysStringB_H,high(SYSSTRINGPARAM8)
	ldi	SysReadA,low(StringTable97<<1)
	ldi	SysReadA_H,high(StringTable97<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM8)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM8)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	rcall	SERTXD7
;Draw_Line(2,20,"=")
	ldi	SysValueCopy,2
	sts	LINE_TYPE,SysValueCopy
	ldi	SysValueCopy,20
	sts	N_CHAR,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable18<<1)
	ldi	SysReadA_H,high(StringTable18<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysCHARHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysCHARHandler_H,SysValueCopy
	call	DRAW_LINE
;end if
ENDIF36:
;repeat 1000         'portato a 1000 da 100
	ldi	SysValueCopy,232
	sts	SysRepeatTemp11,SysValueCopy
	ldi	SysValueCopy,4
	sts	SysRepeatTemp11_H,SysValueCopy
SysRepeatLoop11:
;SD_Counter=SD_Counter+1
	lds	SysTemp3,SD_COUNTER
	inc	SysTemp3
	sts	SD_COUNTER,SysTemp3
	lds	SysTemp3,SD_COUNTER_H
	brne	PC + 2
	inc	SysTemp3
	sts	SD_COUNTER_H,SysTemp3
;HSerPrint ". "
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable98<<1)
	ldi	SysReadA_H,high(StringTable98<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	call	HSERPRINT286
;SD_Counter1=0
	ldi	SysValueCopy,0
	sts	SD_COUNTER1,SysValueCopy
	sts	SD_COUNTER1_H,SysValueCopy
;SendCommand (0x51, Block_Start, 0xFF)    'CMD17
	ldi	SysValueCopy,81
	sts	CODE,SysValueCopy
	lds	SysValueCopy,BLOCK_START
	sts	ARG,SysValueCopy
	lds	SysValueCopy,BLOCK_START_H
	sts	ARG_H,SysValueCopy
	lds	SysValueCopy,BLOCK_START_U
	sts	ARG_U,SysValueCopy
	lds	SysValueCopy,BLOCK_START_E
	sts	ARG_E,SysValueCopy
	ldi	SysValueCopy,255
	sts	CRC,SysValueCopy
	rcall	SENDCOMMAND
;do until SDResponse=0 or SD_Counter1 > 100
SysDoLoop_S8:
	lds	SysBYTETempA,sdresponse
	ldi	SysBYTETempB,0
	rcall	SysCompEqual
	mov	SysTemp3,SysByteTempX
	lds	SysWORDTempB,sd_counter1
	lds	SysWORDTempB_H,sd_counter1_H
	ldi	SysWORDTempA,100
	ldi	SysWORDTempA_H,0
	rcall	SysCompLessThan16
	mov	SysTemp2,SysByteTempX
	or	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	sbrc	SysTemp1,0
	rjmp	SysDoLoop_E8
;GetSDResponse(1,SDResponse)
	ldi	SysValueCopy,1
	sts	NRESPONSE,SysValueCopy
	lds	SysValueCopy,SDRESPONSE
	sts	SDRESP,SysValueCopy
	call	GETSDRESPONSE
	lds	SysValueCopy,SDRESP
	sts	SDRESPONSE,SysValueCopy
;SD_Counter1=SD_Counter1+1
	lds	SysTemp3,SD_COUNTER1
	inc	SysTemp3
	sts	SD_COUNTER1,SysTemp3
	lds	SysTemp3,SD_COUNTER1_H
	brne	PC + 2
	inc	SysTemp3
	sts	SD_COUNTER1_H,SysTemp3
;loop
	rjmp	SysDoLoop_S8
SysDoLoop_E8:
;SD_Counter1=0
	ldi	SysValueCopy,0
	sts	SD_COUNTER1,SysValueCopy
	sts	SD_COUNTER1_H,SysValueCopy
;do until SDToken=0xFE or SD_Counter1 > 1000
SysDoLoop_S9:
	lds	SysBYTETempA,sdtoken
	ldi	SysBYTETempB,254
	rcall	SysCompEqual
	mov	SysTemp3,SysByteTempX
	lds	SysWORDTempB,sd_counter1
	lds	SysWORDTempB_H,sd_counter1_H
	ldi	SysWORDTempA,232
	ldi	SysWORDTempA_H,3
	rcall	SysCompLessThan16
	mov	SysTemp2,SysByteTempX
	or	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	sbrc	SysTemp1,0
	rjmp	SysDoLoop_E9
;GetSDResponse(1,SDToken)
	ldi	SysValueCopy,1
	sts	NRESPONSE,SysValueCopy
	lds	SysValueCopy,SDTOKEN
	sts	SDRESP,SysValueCopy
	call	GETSDRESPONSE
	lds	SysValueCopy,SDRESP
	sts	SDTOKEN,SysValueCopy
;SD_Counter1=SD_Counter1+1
	lds	SysTemp3,SD_COUNTER1
	inc	SysTemp3
	sts	SD_COUNTER1,SysTemp3
	lds	SysTemp3,SD_COUNTER1_H
	brne	PC + 2
	inc	SysTemp3
	sts	SD_COUNTER1_H,SysTemp3
;loop
	rjmp	SysDoLoop_S9
SysDoLoop_E9:
;if SDToken=0xFE and SDResponse=0 then
	lds	SysBYTETempA,SDTOKEN
	ldi	SysBYTETempB,254
	rcall	SysCompEqual
	mov	SysTemp3,SysByteTempX
	lds	SysBYTETempA,SDRESPONSE
	ldi	SysBYTETempB,0
	rcall	SysCompEqual
	mov	SysTemp2,SysByteTempX
	and	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	sbrs	SysTemp1,0
	rjmp	ENDIF37
;if Verbose="ON" then
	ldi	SysStringB,low(SYSTEMPARRAY)
	ldi	SysStringB_H,high(SYSTEMPARRAY)
	ldi	SysReadA,low(StringTable17<<1)
	ldi	SysReadA_H,high(StringTable17<<1)
	rcall	SysReadString
	ldi	SysStringA,low(VERBOSE)
	ldi	SysStringA_H,high(VERBOSE)
	ldi	SysStringB,low(SYSTEMPARRAY)
	ldi	SysStringB_H,high(SYSTEMPARRAY)
	rcall	SysCompEqualString
	sbrs	SysByteTempX,0
	rjmp	ENDIF39
;Draw_Line(2,20,"=")
	ldi	SysValueCopy,2
	sts	LINE_TYPE,SysValueCopy
	ldi	SysValueCopy,20
	sts	N_CHAR,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable18<<1)
	ldi	SysReadA_H,high(StringTable18<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysCHARHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysCHARHandler_H,SysValueCopy
	call	DRAW_LINE
;sertxd(1,"-CMD17  OK ","Executed",0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable99<<1)
	ldi	SysReadA_H,high(StringTable99<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM8)
	ldi	SysStringB_H,high(SYSSTRINGPARAM8)
	ldi	SysReadA,low(StringTable100<<1)
	ldi	SysReadA_H,high(StringTable100<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM8)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM8)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	rcall	SERTXD7
;sertxd(0,", First Response=",SDResponse,0):sertxd(0,", Token(254)=",SDToken,0)
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable101<<1)
	ldi	SysReadA_H,high(StringTable101<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysValueCopy,SDRESPONSE
	sts	INPUTB,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	rcall	SERTXD8
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable102<<1)
	ldi	SysReadA_H,high(StringTable102<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysValueCopy,SDTOKEN
	sts	INPUTB,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	rcall	SERTXD8
;sertxd(0," n. attempts=",SD_Counter,0)
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable103<<1)
	ldi	SysReadA_H,high(StringTable103<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysValueCopy,SD_COUNTER
	sts	INPUTW,SysValueCopy
	lds	SysValueCopy,SD_COUNTER_H
	sts	INPUTW_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	rcall	SERTXD9
;Draw_Line(2,20,"=")
	ldi	SysValueCopy,2
	sts	LINE_TYPE,SysValueCopy
	ldi	SysValueCopy,20
	sts	N_CHAR,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable18<<1)
	ldi	SysReadA_H,high(StringTable18<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysCHARHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysCHARHandler_H,SysValueCopy
	call	DRAW_LINE
;end if
ENDIF39:
;exit repeat
	rjmp	SysRepeatLoopEnd11
;end if
ENDIF37:
;End Repeat
	lds	SysTemp2,SysRepeatTemp11
	lds	SysTemp2_H,SysRepeatTemp11_H
	dec	SysTemp2
	sts	SysRepeatTemp11,SysTemp2
	breq	PC + 2
	rjmp	SysRepeatLoop11
	dec	SysTemp2_H
	sts	SysRepeatTemp11_H,SysTemp2_H
	breq	PC + 2
	rjmp	SysRepeatLoop11
SysRepeatLoopEnd11:
;SDByte=0
	ldi	SysValueCopy,0
	sts	SDBYTE,SysValueCopy
	sts	SDBYTE_H,SysValueCopy
;if SDToken=0xFE  then
	lds	SysCalcTempA,SDTOKEN
	cpi	SysCalcTempA,254
	brne	ELSE38_1
;Repeat 512
	ldi	SysValueCopy,0
	sts	SysRepeatTemp11,SysValueCopy
	ldi	SysValueCopy,2
	sts	SysRepeatTemp11_H,SysValueCopy
SysRepeatLoop12:
;SPITransfer 255, SDData
	ldi	SysValueCopy,255
	sts	SPITXDATA,SysValueCopy
	call	HWSPITRANSFER
	lds	SysValueCopy,SPIRXDATA
	sts	SDDATA,SysValueCopy
;SDDataBuffer(SDByte) = SDData
	lds	SysTemp3,SDBYTE
	ldi	SysTemp4,low(SDDATABUFFER)
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	lds	SysTemp3,SDBYTE_H
	ldi	SysTemp4,high(SDDATABUFFER)
	adc	SysTemp3,SysTemp4
	mov	SysStringA_H,SysTemp3
	lds	SysValueCopy,SDDATA
	st	X,SysValueCopy
;SDByte += 1
	lds	SysTemp3,SDBYTE
	inc	SysTemp3
	sts	SDBYTE,SysTemp3
	lds	SysTemp3,SDBYTE_H
	brne	PC + 2
	inc	SysTemp3
	sts	SDBYTE_H,SysTemp3
;End Repeat
	lds	SysTemp2,SysRepeatTemp11
	lds	SysTemp2_H,SysRepeatTemp11_H
	dec	SysTemp2
	sts	SysRepeatTemp11,SysTemp2
	brne	SysRepeatLoop12
	dec	SysTemp2_H
	sts	SysRepeatTemp11_H,SysTemp2_H
	brne	SysRepeatLoop12
SysRepeatLoopEnd12:
;else
	rjmp	ENDIF38
ELSE38_1:
;sertxd(1,"-CMD17  !OK Executed","  ",0)
	ldi	SysValueCopy,1
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable104<<1)
	ldi	SysReadA_H,high(StringTable104<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler_H,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM8)
	ldi	SysStringB_H,high(SYSSTRINGPARAM8)
	ldi	SysReadA,low(StringTable92<<1)
	ldi	SysReadA_H,high(StringTable92<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM8)
	sts	SysINPUTSHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM8)
	sts	SysINPUTSHandler_H,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	rcall	SERTXD7
;sertxd(0,", First Response=",SDResponse,0):sertxd(0,", Token(254)=",SDToken,0)
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable101<<1)
	ldi	SysReadA_H,high(StringTable101<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysValueCopy,SDRESPONSE
	sts	INPUTB,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	rcall	SERTXD8
	ldi	SysValueCopy,0
	sts	CRLF1,SysValueCopy
	ldi	SysStringB,low(SYSSTRINGPARAM6)
	ldi	SysStringB_H,high(SYSSTRINGPARAM6)
	ldi	SysReadA,low(StringTable102<<1)
	ldi	SysReadA_H,high(StringTable102<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM6)
	sts	SysSTRINGAHandler_H,SysValueCopy
	lds	SysValueCopy,SDTOKEN
	sts	INPUTB,SysValueCopy
	ldi	SysValueCopy,0
	sts	CRLF2,SysValueCopy
	rcall	SERTXD8
;END
	jmp	BASPROGRAMEND
;end if
ENDIF38:
	ret

;********************************************************************************

;Source: MySDLib.h (83)
SENDCOMMAND:
;SET SD_Adaper_CS OFF
	cbi	PORTB,2
;SPITransfer 0xFF, SDData
	ldi	SysValueCopy,255
	sts	SPITXDATA,SysValueCopy
	call	HWSPITRANSFER
	lds	SysValueCopy,SPIRXDATA
	sts	SDDATA,SysValueCopy
;SPITransfer Code, SDData
	lds	SysValueCopy,CODE
	sts	SPITXDATA,SysValueCopy
	call	HWSPITRANSFER
	lds	SysValueCopy,SPIRXDATA
	sts	SDDATA,SysValueCopy
;SPITransfer Arg_E, SDData
	lds	SysValueCopy,ARG_E
	sts	SPITXDATA,SysValueCopy
	call	HWSPITRANSFER
	lds	SysValueCopy,SPIRXDATA
	sts	SDDATA,SysValueCopy
;SPITransfer Arg_U, SDData
	lds	SysValueCopy,ARG_U
	sts	SPITXDATA,SysValueCopy
	call	HWSPITRANSFER
	lds	SysValueCopy,SPIRXDATA
	sts	SDDATA,SysValueCopy
;SPITransfer Arg_H, SDData
	lds	SysValueCopy,ARG_H
	sts	SPITXDATA,SysValueCopy
	call	HWSPITRANSFER
	lds	SysValueCopy,SPIRXDATA
	sts	SDDATA,SysValueCopy
;SPITransfer [byte]Arg, SDData
	lds	SysValueCopy,ARG
	sts	SPITXDATA,SysValueCopy
	call	HWSPITRANSFER
	lds	SysValueCopy,SPIRXDATA
	sts	SDDATA,SysValueCopy
;SPITransfer CRC, SDData
	lds	SysValueCopy,CRC
	sts	SPITXDATA,SysValueCopy
	call	HWSPITRANSFER
	lds	SysValueCopy,SPIRXDATA
	sts	SDDATA,SysValueCopy
;SendPulses      'NECESSARIO!!!!
	rcall	SENDPULSES
;SPITransfer 0xFF, SDData
	ret

;********************************************************************************

;Source: MySDLib.h (76)
SENDDUMMYBYTES:
;repeat n_bytes
	lds	SysValueCopy,N_BYTES
	sts	SysRepeatTemp15,SysValueCopy
	lds	SysCalcTempA,SYSREPEATTEMP15
	tst	SysCalcTempA
	brne	PC + 2
	rjmp	SysRepeatLoopEnd15
SysRepeatLoop15:
;SPITransfer 0xFF, SDData
	ldi	SysValueCopy,255
	sts	SPITXDATA,SysValueCopy
	call	HWSPITRANSFER
	lds	SysValueCopy,SPIRXDATA
	sts	SDDATA,SysValueCopy
;end repeat
	lds	SysTemp3,SysRepeatTemp15
	dec	SysTemp3
	sts	SysRepeatTemp15,SysTemp3
	brne	SysRepeatLoop15
SysRepeatLoopEnd15:
	ret

;********************************************************************************

;Source: MySDLib.h (100)
SENDPULSES:
;Set SD_Adaper_CS OFF
;SPITransfer 0xFF, SDData
	ldi	SysValueCopy,255
	sts	SPITXDATA,SysValueCopy
	call	HWSPITRANSFER
	lds	SysValueCopy,SPIRXDATA
	sts	SDDATA,SysValueCopy
;Set SD_Adaper_CS ON
	ret

;********************************************************************************

;Overloaded signature: BYTE:STRING:STRING:BYTE:, Source: Sertxd.h (1)
SERTXD7:
;if CRLF1 >0 Then
	ldi	SysCalcTempA,0
	lds	SysCalcTempB,CRLF1
	cp	SysCalcTempA,SysCalcTempB
	brsh	ELSE14_1
;HSerPrintCRLF CRLF1     'carriage return + line feed
	lds	SysValueCopy,CRLF1
	sts	HSERPRINTCRLFCOUNT,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	call	HSERPRINTCRLF
;Else
	rjmp	ENDIF14
ELSE14_1:
;HSerSend CRLF1
	lds	SysValueCopy,CRLF1
	sts	SERDATA,SysValueCopy
	call	HSERSEND275
;End if
ENDIF14:
;HSerPrint stringa
	lds	SysValueCopy,SysSTRINGAHandler
	sts	SysPRINTDATAHandler,SysValueCopy
	lds	SysValueCopy,SysSTRINGAHandler_H
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	call	HSERPRINT286
;HSerPrint inputS
	lds	SysValueCopy,SysINPUTSHandler
	sts	SysPRINTDATAHandler,SysValueCopy
	lds	SysValueCopy,SysINPUTSHandler_H
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	call	HSERPRINT286
;if CRLF2 >0 Then
	ldi	SysCalcTempA,0
	lds	SysCalcTempB,CRLF2
	cp	SysCalcTempA,SysCalcTempB
	brsh	ELSE15_1
;HSerPrintCRLF CRLF2
	lds	SysValueCopy,CRLF2
	sts	HSERPRINTCRLFCOUNT,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	call	HSERPRINTCRLF
;Else
	rjmp	ENDIF15
ELSE15_1:
;HSerSend CRLF2
	lds	SysValueCopy,CRLF2
	sts	SERDATA,SysValueCopy
	call	HSERSEND275
;End if
ENDIF15:
	ret

;********************************************************************************

;Overloaded signature: BYTE:STRING:BYTE:BYTE:, Source: Sertxd.h (21)
SERTXD8:
;if CRLF1 >0 Then
	ldi	SysCalcTempA,0
	lds	SysCalcTempB,CRLF1
	cp	SysCalcTempA,SysCalcTempB
	brsh	ELSE86_1
;HSerPrintCRLF CRLF1
	lds	SysValueCopy,CRLF1
	sts	HSERPRINTCRLFCOUNT,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	call	HSERPRINTCRLF
;Else
	rjmp	ENDIF86
ELSE86_1:
;HSerSend CRLF1
	lds	SysValueCopy,CRLF1
	sts	SERDATA,SysValueCopy
	call	HSERSEND275
;End if
ENDIF86:
;HSerPrint stringa
	lds	SysValueCopy,SysSTRINGAHandler
	sts	SysPRINTDATAHandler,SysValueCopy
	lds	SysValueCopy,SysSTRINGAHandler_H
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	call	HSERPRINT286
;HSerPrint inputB
	lds	SysValueCopy,INPUTB
	sts	SERPRINTVAL,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	call	HSERPRINT287
;if CRLF2 > 0 Then
	ldi	SysCalcTempA,0
	lds	SysCalcTempB,CRLF2
	cp	SysCalcTempA,SysCalcTempB
	brsh	ELSE87_1
;HSerPrintCRLF CRLF2
	lds	SysValueCopy,CRLF2
	sts	HSERPRINTCRLFCOUNT,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	call	HSERPRINTCRLF
;Else
	rjmp	ENDIF87
ELSE87_1:
;HSerSend CRLF2
	lds	SysValueCopy,CRLF2
	sts	SERDATA,SysValueCopy
	call	HSERSEND275
;End if
ENDIF87:
	ret

;********************************************************************************

;Overloaded signature: BYTE:STRING:WORD:BYTE:, Source: Sertxd.h (40)
SERTXD9:
;if CRLF1 >0 Then
	ldi	SysCalcTempA,0
	lds	SysCalcTempB,CRLF1
	cp	SysCalcTempA,SysCalcTempB
	brsh	ELSE88_1
;HSerPrintCRLF CRLF1     'se 1 cambia riga, se 0 no
	lds	SysValueCopy,CRLF1
	sts	HSERPRINTCRLFCOUNT,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	call	HSERPRINTCRLF
;Else
	rjmp	ENDIF88
ELSE88_1:
;HSerSend CRLF1
	lds	SysValueCopy,CRLF1
	sts	SERDATA,SysValueCopy
	call	HSERSEND275
;End if
ENDIF88:
;HSerPrint stringa
	lds	SysValueCopy,SysSTRINGAHandler
	sts	SysPRINTDATAHandler,SysValueCopy
	lds	SysValueCopy,SysSTRINGAHandler_H
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	call	HSERPRINT286
;HSerPrint inputW
	lds	SysValueCopy,INPUTW
	sts	SERPRINTVAL,SysValueCopy
	lds	SysValueCopy,INPUTW_H
	sts	SERPRINTVAL_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	call	HSERPRINT288
;if CRLF2 > 0 Then
	ldi	SysCalcTempA,0
	lds	SysCalcTempB,CRLF2
	cp	SysCalcTempA,SysCalcTempB
	brsh	ELSE89_1
;HSerPrintCRLF CRLF2
	lds	SysValueCopy,CRLF2
	sts	HSERPRINTCRLFCOUNT,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	call	HSERPRINTCRLF
;Else
	rjmp	ENDIF89
ELSE89_1:
;HSerSend CRLF2
	lds	SysValueCopy,CRLF2
	sts	SERDATA,SysValueCopy
	call	HSERSEND275
;End if
ENDIF89:
	ret

;********************************************************************************

;Overloaded signature: BYTE:STRING:LONG:BYTE:, Source: Sertxd.h (59)
SERTXD10:
;if CRLF1 > 0 Then
	ldi	SysCalcTempA,0
	lds	SysCalcTempB,CRLF1
	cp	SysCalcTempA,SysCalcTempB
	brsh	ELSE16_1
;HSerPrintCRLF CRLF1     'se 1 cambia riga, se 0 no
	lds	SysValueCopy,CRLF1
	sts	HSERPRINTCRLFCOUNT,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	call	HSERPRINTCRLF
;Else
	rjmp	ENDIF16
ELSE16_1:
;HSerSend CRLF1
	lds	SysValueCopy,CRLF1
	sts	SERDATA,SysValueCopy
	call	HSERSEND275
;End if
ENDIF16:
;HSerPrint stringa
	lds	SysValueCopy,SysSTRINGAHandler
	sts	SysPRINTDATAHandler,SysValueCopy
	lds	SysValueCopy,SysSTRINGAHandler_H
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	call	HSERPRINT286
;HSerPrint inputL
	lds	SysValueCopy,INPUTL
	sts	SERPRINTVAL,SysValueCopy
	lds	SysValueCopy,INPUTL_H
	sts	SERPRINTVAL_H,SysValueCopy
	lds	SysValueCopy,INPUTL_U
	sts	SERPRINTVAL_U,SysValueCopy
	lds	SysValueCopy,INPUTL_E
	sts	SERPRINTVAL_E,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	call	HSERPRINT290
;if CRLF2 > 0 Then
	ldi	SysCalcTempA,0
	lds	SysCalcTempB,CRLF2
	cp	SysCalcTempA,SysCalcTempB
	brsh	ELSE17_1
;HSerPrintCRLF CRLF2
	lds	SysValueCopy,CRLF2
	sts	HSERPRINTCRLFCOUNT,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	call	HSERPRINTCRLF
;Else
	rjmp	ENDIF17
ELSE17_1:
;HSerSend CRLF2
	lds	SysValueCopy,CRLF2
	sts	SERDATA,SysValueCopy
	call	HSERSEND275
;End if
ENDIF17:
	ret

;********************************************************************************

;Overloaded signature: BYTE:BYTE:, Source: hwspi.h (354)
SPIMODE241:
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
	rjmp	ENDIF62
;Set SPCR.CPHA On
	in	SysValueCopy,SPCR
	sbr	SysValueCopy,1<<CPHA
	out	SPCR,SysValueCopy
;End If
ENDIF62:
;Set SPCR.CPOL Off
	in	SysValueCopy,SPCR
	cbr	SysValueCopy,1<<CPOL
	out	SPCR,SysValueCopy
;If SPIClockMode.1 = On Then
	lds	SysBitTest,SPICLOCKMODE
	sbrs	SysBitTest,1
	rjmp	ENDIF63
;Set SPCR.CPOL On
	in	SysValueCopy,SPCR
	sbr	SysValueCopy,1<<CPOL
	out	SPCR,SysValueCopy
;End If
ENDIF63:
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
SysSelect2Case1:
	lds	SysCalcTempA,SPICURRENTMODE
	cpi	SysCalcTempA,14
	brne	SysSelect2Case2
;Set SPCR.MSTR On
	in	SysValueCopy,SPCR
	sbr	SysValueCopy,1<<MSTR
	out	SPCR,SysValueCopy
;Set SPSR.SPI2X On
	in	SysValueCopy,SPSR
	sbr	SysValueCopy,1<<SPI2X
	out	SPSR,SysValueCopy
;Case MasterFast
	rjmp	SysSelectEnd2
SysSelect2Case2:
	lds	SysCalcTempA,SPICURRENTMODE
	cpi	SysCalcTempA,13
	brne	SysSelect2Case3
;Set SPCR.MSTR On
	in	SysValueCopy,SPCR
	sbr	SysValueCopy,1<<MSTR
	out	SPCR,SysValueCopy
;Case Master
	rjmp	SysSelectEnd2
SysSelect2Case3:
	lds	SysCalcTempA,SPICURRENTMODE
	cpi	SysCalcTempA,12
	brne	SysSelect2Case4
;Set SPCR.MSTR On
	in	SysValueCopy,SPCR
	sbr	SysValueCopy,1<<MSTR
	out	SPCR,SysValueCopy
;Set SPCR.SPR0 On
	in	SysValueCopy,SPCR
	sbr	SysValueCopy,1<<SPR0
	out	SPCR,SysValueCopy
;Case MasterSlow
	rjmp	SysSelectEnd2
SysSelect2Case4:
	lds	SysCalcTempA,SPICURRENTMODE
	cpi	SysCalcTempA,11
	brne	SysSelectEnd2
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
SysSelectEnd2:
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

;Source: system.h (2693)
SYSCOMPEQUAL32:
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clr SysByteTempX
	clr	SYSBYTETEMPX
;cp SysLongTempA, SysLongTempB
	cp	SYSLONGTEMPA, SYSLONGTEMPB
;brne SCE32False
	brne	SCE32FALSE
;cp SysLongTempA_H, SysLongTempB_H
	cp	SYSLONGTEMPA_H, SYSLONGTEMPB_H
;brne SCE32False
	brne	SCE32FALSE
;cp SysLongTempA_U, SysLongTempB_U
	cp	SYSLONGTEMPA_U, SYSLONGTEMPB_U
;brne SCE32False
	brne	SCE32FALSE
;cp SysLongTempA_E, SysLongTempB_E
	cp	SYSLONGTEMPA_E, SYSLONGTEMPB_E
;brne SCE32False
	brne	SCE32FALSE
;com SysByteTempX
	com	SYSBYTETEMPX
SCE32FALSE:
	ret

;********************************************************************************

;Source: system.h (1419)
SYSCOMPEQUALSTRING:
;Dim SysByteTempA As Byte
;Dim SysByteTempX As Byte
;SysByteTempX = 0
	ldi	SysValueCopy,0
	mov	SYSBYTETEMPX,SysValueCopy
;Dim SysReadA As Word
;Dim SysByteTempA As Byte
;SysByteTempX = 0
	ldi	SysValueCopy,0
	mov	SYSBYTETEMPX,SysValueCopy
;Check length matches
;ld SysReadA, X+
	ld	SYSREADA, X+
;ld SysReadA_H, Y+
	ld	SYSREADA_H, Y+
;cpse SysReadA, SysReadA_H
	cpse	SYSREADA, SYSREADA_H
;ret
	ret
;mov SysByteTempA, SysReadA
	mov	SYSBYTETEMPA, SYSREADA
;Check if length 0
;tst SysReadA
	tst	SYSREADA
;breq SCEStrTrue
	breq	SCESTRTRUE
;Check each char, exit if not equal
SYSSTRINGCOMP:
;Compare, exit if <>
;ld SysReadA, X+
	ld	SYSREADA, X+
;ld SysReadA_H, Y+
	ld	SYSREADA_H, Y+
;cpse SysReadA, SysReadA_H
	cpse	SYSREADA, SYSREADA_H
;ret
	ret
;dec SysByteTempA
	dec	SYSBYTETEMPA
;brne SysStringComp
	brne	SYSSTRINGCOMP
SCESTRTRUE:
;com SysByteTempX
	com	SYSBYTETEMPX
	ret

;********************************************************************************

;Source: system.h (2780)
SYSCOMPLESSTHAN:
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;clr SysByteTempX
	clr	SYSBYTETEMPX
;cp SysByteTempA,SysByteTempB
	cp	SYSBYTETEMPA,SYSBYTETEMPB
;brlo SCLTTrue
	brlo	SCLTTRUE
;ret
	ret
SCLTTRUE:
;com SysByteTempX
	com	SYSBYTETEMPX
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

;Source: system.h (2868)
SYSCOMPLESSTHAN32:
;clr SysByteTempX
	clr	SYSBYTETEMPX
;Test Exp, exit false if more
;cp SysLongTempB_E,SysLongTempA_E
	cp	SYSLONGTEMPB_E,SYSLONGTEMPA_E
;brlo SCLT32False
	brlo	SCLT32FALSE
;Test Exp, exit true not equal
;brne SCLT32True
	brne	SCLT32TRUE
;Test Upper, exit false if more
;cp SysLongTempB_U,SysLongTempA_U
	cp	SYSLONGTEMPB_U,SYSLONGTEMPA_U
;brlo SCLT32False
	brlo	SCLT32FALSE
;Test Upper, exit true not equal
;brne SCLT32True
	brne	SCLT32TRUE
;Test High, exit false if more
;cp SysLongTempB_H,SysLongTempA_H
	cp	SYSLONGTEMPB_H,SYSLONGTEMPA_H
;brlo SCLT32False
	brlo	SCLT32FALSE
;Test high, exit true not equal
;brne SCLT32True
	brne	SCLT32TRUE
;Test Low, exit if more or equal
;cp SysLongTempA,SysLongTempB
	cp	SYSLONGTEMPA,SYSLONGTEMPB
;brlo SCLT32True
	brlo	SCLT32TRUE
;ret
	ret
SCLT32TRUE:
;com SysByteTempX
	com	SYSBYTETEMPX
SCLT32FALSE:
	ret

;********************************************************************************

;Source: system.h (1043)
SYSCOPYSTRING:
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;SysStringA (X) stores source
;SysStringB (Y) stores destination
;SysStringLength is counter, keeps track of size of destination string
;SysCalcTempA is loop counter
;Dim SysReadA As Byte
;Get and copy length
;ld SysCalcTempA, X+
	ld	SYSCALCTEMPA, X+
;st Y+, SysCalcTempA
	st	Y+, SYSCALCTEMPA
;rjmp SysCopyStringCheck
	rjmp	SYSCOPYSTRINGCHECK
;When appending, add length to counter
SYSCOPYSTRINGPART:
;ld SysCalcTempA, X+
	ld	SYSCALCTEMPA, X+
;add SysStringLength, SysCalcTempA
	add	SYSSTRINGLENGTH, SYSCALCTEMPA
SYSCOPYSTRINGCHECK:
;Exit if length = 0
;cpi SysCalcTempA,0
	cpi	SYSCALCTEMPA,0
;brne SysStringCopy
	brne	SYSSTRINGCOPY
;ret
	ret
SYSSTRINGCOPY:
;Copy character
;ld SysReadA, X+
	ld	SYSREADA, X+
;st Y+, SysReadA
	st	Y+, SYSREADA
;dec SysCalcTempA
	dec	SYSCALCTEMPA
;brne SysStringCopy
	brne	SYSSTRINGCOPY
	ret

;********************************************************************************

;Source: system.h (2389)
SYSDIVSUB:
;Check for div/0
;tst SysByteTempB
	tst	SYSBYTETEMPB
;brne DIV8Cont
	brne	DIV8CONT
;ret
	ret
DIV8CONT:
;Main calc routine
;clr SysByteTempX
	clr	SYSBYTETEMPX
;SysDivLoop = 8
	ldi	SysValueCopy,8
	mov	SYSDIVLOOP,SysValueCopy
SYSDIV8START:
;lsl SysByteTempA
	lsl	SYSBYTETEMPA
;rol SysByteTempX
	rol	SYSBYTETEMPX
;asm sub SysByteTempX,SysByteTempB 'asm needed, or else sub will be used as start of sub
	sub	SYSBYTETEMPX,SYSBYTETEMPB
;sbr SysByteTempA,1
	sbr	SYSBYTETEMPA,1
;brsh Div8NotNeg
	brsh	DIV8NOTNEG
;cbr SysByteTempA,1
	cbr	SYSBYTETEMPA,1
;add SysByteTempX,SysByteTempB
	add	SYSBYTETEMPX,SYSBYTETEMPB
DIV8NOTNEG:
;dec SysDivLoop
	dec	SYSDIVLOOP
;brne SysDiv8Start
	brne	SYSDIV8START
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
	rjmp	ENDIF60
;SysWordTempA = 0
	ldi	SYSWORDTEMPA,0
	ldi	SYSWORDTEMPA_H,0
;exit sub
	ret
;end if
ENDIF60:
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
	brbc	C,ENDIF61
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
ENDIF61:
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

;Source: system.h (2533)
SYSDIVSUB32:
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysLongTempX as long
;#ifdef PIC
;dim SysLongDivMultA as long
;dim SysLongDivMultB as long
;dim SysLongDivMultX as long
;#endif
;SysLongDivMultA = SysLongTempA
	sts	SYSLONGDIVMULTA,SYSLONGTEMPA
	sts	SYSLONGDIVMULTA_H,SYSLONGTEMPA_H
	sts	SYSLONGDIVMULTA_U,SYSLONGTEMPA_U
	sts	SYSLONGDIVMULTA_E,SYSLONGTEMPA_E
;SysLongDivMultB = SysLongTempB
	sts	SYSLONGDIVMULTB,SYSLONGTEMPB
	sts	SYSLONGDIVMULTB_H,SYSLONGTEMPB_H
	sts	SYSLONGDIVMULTB_U,SYSLONGTEMPB_U
	sts	SYSLONGDIVMULTB_E,SYSLONGTEMPB_E
;SysLongDivMultX = 0
	ldi	SysValueCopy,0
	sts	SYSLONGDIVMULTX,SysValueCopy
	sts	SYSLONGDIVMULTX_H,SysValueCopy
	sts	SYSLONGDIVMULTX_U,SysValueCopy
	sts	SYSLONGDIVMULTX_E,SysValueCopy
;Avoid division by zero
;if SysLongDivMultB = 0 then
	lds	SysLONGTempA,SYSLONGDIVMULTB
	lds	SysLONGTempA_H,SYSLONGDIVMULTB_H
	lds	SysLONGTempA_U,SYSLONGDIVMULTB_U
	lds	SysLONGTempA_E,SYSLONGDIVMULTB_E
	ldi	SysLONGTempB,0
	ldi	SysLONGTempB_H,0
	ldi	SysLONGTempB_U,0
	ldi	SysLONGTempB_E,0
	rcall	SysCompEqual32
	sbrs	SysByteTempX,0
	rjmp	ENDIF90
;SysLongTempA = 0
	ldi	SYSLONGTEMPA,0
	ldi	SYSLONGTEMPA_H,0
	ldi	SYSLONGTEMPA_U,0
	ldi	SYSLONGTEMPA_E,0
;exit sub
	ret
;end if
ENDIF90:
;Main calc routine
;SysDivLoop = 32
	ldi	SysValueCopy,32
	mov	SYSDIVLOOP,SysValueCopy
SYSDIV32START:
;set C off
	clc
;Rotate SysLongDivMultA Left
	lds	SysValueCopy,SYSLONGDIVMULTA
	rol	SysValueCopy
	sts	SYSLONGDIVMULTA,SysValueCopy
	lds	SysValueCopy,SYSLONGDIVMULTA_H
	rol	SysValueCopy
	sts	SYSLONGDIVMULTA_H,SysValueCopy
	lds	SysValueCopy,SYSLONGDIVMULTA_U
	rol	SysValueCopy
	sts	SYSLONGDIVMULTA_U,SysValueCopy
	lds	SysValueCopy,SYSLONGDIVMULTA_E
	rol	SysValueCopy
	sts	SYSLONGDIVMULTA_E,SysValueCopy
;Rotate SysLongDivMultX Left
	lds	SysValueCopy,SYSLONGDIVMULTX
	rol	SysValueCopy
	sts	SYSLONGDIVMULTX,SysValueCopy
	lds	SysValueCopy,SYSLONGDIVMULTX_H
	rol	SysValueCopy
	sts	SYSLONGDIVMULTX_H,SysValueCopy
	lds	SysValueCopy,SYSLONGDIVMULTX_U
	rol	SysValueCopy
	sts	SYSLONGDIVMULTX_U,SysValueCopy
	lds	SysValueCopy,SYSLONGDIVMULTX_E
	rol	SysValueCopy
	sts	SYSLONGDIVMULTX_E,SysValueCopy
;SysLongDivMultX = SysLongDivMultX - SysLongDivMultB
	lds	SysTemp3,SYSLONGDIVMULTX
	lds	SysTemp1,SYSLONGDIVMULTB
	sub	SysTemp3,SysTemp1
	sts	SYSLONGDIVMULTX,SysTemp3
	lds	SysTemp3,SYSLONGDIVMULTX_H
	lds	SysTemp1,SYSLONGDIVMULTB_H
	sbc	SysTemp3,SysTemp1
	sts	SYSLONGDIVMULTX_H,SysTemp3
	lds	SysTemp3,SYSLONGDIVMULTX_U
	lds	SysTemp1,SYSLONGDIVMULTB_U
	sbc	SysTemp3,SysTemp1
	sts	SYSLONGDIVMULTX_U,SysTemp3
	lds	SysTemp3,SYSLONGDIVMULTX_E
	lds	SysTemp1,SYSLONGDIVMULTB_E
	sbc	SysTemp3,SysTemp1
	sts	SYSLONGDIVMULTX_E,SysTemp3
;Set SysLongDivMultA.0 On
	lds	SysValueCopy,SYSLONGDIVMULTA
	sbr	SysValueCopy,1<<0
	sts	SYSLONGDIVMULTA,SysValueCopy
;If C On Then
	brbc	C,ENDIF91
;Set SysLongDivMultA.0 Off
	lds	SysValueCopy,SYSLONGDIVMULTA
	cbr	SysValueCopy,1<<0
	sts	SYSLONGDIVMULTA,SysValueCopy
;SysLongDivMultX = SysLongDivMultX + SysLongDivMultB
	lds	SysTemp3,SYSLONGDIVMULTX
	lds	SysTemp1,SYSLONGDIVMULTB
	add	SysTemp3,SysTemp1
	sts	SYSLONGDIVMULTX,SysTemp3
	lds	SysTemp3,SYSLONGDIVMULTX_H
	lds	SysTemp1,SYSLONGDIVMULTB_H
	adc	SysTemp3,SysTemp1
	sts	SYSLONGDIVMULTX_H,SysTemp3
	lds	SysTemp3,SYSLONGDIVMULTX_U
	lds	SysTemp1,SYSLONGDIVMULTB_U
	adc	SysTemp3,SysTemp1
	sts	SYSLONGDIVMULTX_U,SysTemp3
	lds	SysTemp3,SYSLONGDIVMULTX_E
	lds	SysTemp1,SYSLONGDIVMULTB_E
	adc	SysTemp3,SysTemp1
	sts	SYSLONGDIVMULTX_E,SysTemp3
;End If
ENDIF91:
;dec SysDivLoop
	dec	SYSDIVLOOP
;breq SysDiv32End
	breq	SYSDIV32END
;goto SysDiv32Start
	rjmp	SYSDIV32START
SYSDIV32END:
;SysLongTempA = SysLongDivMultA
	lds	SYSLONGTEMPA,SYSLONGDIVMULTA
	lds	SYSLONGTEMPA_H,SYSLONGDIVMULTA_H
	lds	SYSLONGTEMPA_U,SYSLONGDIVMULTA_U
	lds	SYSLONGTEMPA_E,SYSLONGDIVMULTA_E
;SysLongTempX = SysLongDivMultX
	lds	SYSLONGTEMPX,SYSLONGDIVMULTX
	lds	SYSLONGTEMPX_H,SYSLONGDIVMULTX_H
	lds	SYSLONGTEMPX_U,SYSLONGDIVMULTX_U
	lds	SYSLONGTEMPX_E,SYSLONGDIVMULTX_E
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

;Source: system.h (2329)
SYSMULTSUB32:
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysLongTempX as long
;dim SysLongDivMultA as long
;dim SysLongDivMultB as long
;dim SysLongDivMultX as long
;SysLongDivMultA = SysLongTempA
	sts	SYSLONGDIVMULTA,SYSLONGTEMPA
	sts	SYSLONGDIVMULTA_H,SYSLONGTEMPA_H
	sts	SYSLONGDIVMULTA_U,SYSLONGTEMPA_U
	sts	SYSLONGDIVMULTA_E,SYSLONGTEMPA_E
;SysLongDivMultB = SysLongTempB
	sts	SYSLONGDIVMULTB,SYSLONGTEMPB
	sts	SYSLONGDIVMULTB_H,SYSLONGTEMPB_H
	sts	SYSLONGDIVMULTB_U,SYSLONGTEMPB_U
	sts	SYSLONGDIVMULTB_E,SYSLONGTEMPB_E
;SysLongDivMultX = 0
	ldi	SysValueCopy,0
	sts	SYSLONGDIVMULTX,SysValueCopy
	sts	SYSLONGDIVMULTX_H,SysValueCopy
	sts	SYSLONGDIVMULTX_U,SysValueCopy
	sts	SYSLONGDIVMULTX_E,SysValueCopy
MUL32LOOP:
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
	lds	SysBitTest,SYSLONGDIVMULTB
	sbrs	SysBitTest,0
	rjmp	ENDIF58
	lds	SysTemp3,SYSLONGDIVMULTX
	lds	SysTemp1,SYSLONGDIVMULTA
	add	SysTemp3,SysTemp1
	sts	SYSLONGDIVMULTX,SysTemp3
	lds	SysTemp3,SYSLONGDIVMULTX_H
	lds	SysTemp1,SYSLONGDIVMULTA_H
	adc	SysTemp3,SysTemp1
	sts	SYSLONGDIVMULTX_H,SysTemp3
	lds	SysTemp3,SYSLONGDIVMULTX_U
	lds	SysTemp1,SYSLONGDIVMULTA_U
	adc	SysTemp3,SysTemp1
	sts	SYSLONGDIVMULTX_U,SysTemp3
	lds	SysTemp3,SYSLONGDIVMULTX_E
	lds	SysTemp1,SYSLONGDIVMULTA_E
	adc	SysTemp3,SysTemp1
	sts	SYSLONGDIVMULTX_E,SysTemp3
ENDIF58:
;Set C Off
	clc
;rotate SysLongDivMultB right
	lds	SysValueCopy,SYSLONGDIVMULTB_E
	ror	SysValueCopy
	sts	SYSLONGDIVMULTB_E,SysValueCopy
	lds	SysValueCopy,SYSLONGDIVMULTB_U
	ror	SysValueCopy
	sts	SYSLONGDIVMULTB_U,SysValueCopy
	lds	SysValueCopy,SYSLONGDIVMULTB_H
	ror	SysValueCopy
	sts	SYSLONGDIVMULTB_H,SysValueCopy
	lds	SysValueCopy,SYSLONGDIVMULTB
	ror	SysValueCopy
	sts	SYSLONGDIVMULTB,SysValueCopy
;Set C Off
	clc
;rotate SysLongDivMultA left
	lds	SysValueCopy,SYSLONGDIVMULTA
	rol	SysValueCopy
	sts	SYSLONGDIVMULTA,SysValueCopy
	lds	SysValueCopy,SYSLONGDIVMULTA_H
	rol	SysValueCopy
	sts	SYSLONGDIVMULTA_H,SysValueCopy
	lds	SysValueCopy,SYSLONGDIVMULTA_U
	rol	SysValueCopy
	sts	SYSLONGDIVMULTA_U,SysValueCopy
	lds	SysValueCopy,SYSLONGDIVMULTA_E
	rol	SysValueCopy
	sts	SYSLONGDIVMULTA_E,SysValueCopy
;if SysLongDivMultB > 0 then goto MUL32LOOP
	lds	SysLONGTempB,SYSLONGDIVMULTB
	lds	SysLONGTempB_H,SYSLONGDIVMULTB_H
	lds	SysLONGTempB_U,SYSLONGDIVMULTB_U
	lds	SysLONGTempB_E,SYSLONGDIVMULTB_E
	ldi	SysLONGTempA,0
	ldi	SysLONGTempA_H,0
	ldi	SysLONGTempA_U,0
	ldi	SysLONGTempA_E,0
	rcall	SysCompLessThan32
	sbrc	SysByteTempX,0
	rjmp	MUL32LOOP
;SysLongTempX = SysLongDivMultX
	lds	SYSLONGTEMPX,SYSLONGDIVMULTX
	lds	SYSLONGTEMPX_H,SYSLONGDIVMULTX_H
	lds	SYSLONGTEMPX_U,SYSLONGDIVMULTX_U
	lds	SYSLONGTEMPX_E,SYSLONGDIVMULTX_E
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

StringTable3:
.DB	3,42,61,42


StringTable4:
.DB	19,69,45,80,97,112,101,114,32,69,80,68,50,105,110,49,51,40,68,41


StringTable5:
.DB	2,61,61,0


StringTable6:
.DB	13,67,65,82,68,32,97,108,114,101,97,100,121,32


StringTable7:
.DB	17,105,110,105,116,105,97,108,105,122,101,100,63,32,115,47,110,32


StringTable8:
.DB	1,115


StringTable9:
.DB	4,66,79,79,84,0


StringTable10:
.DB	1,32


StringTable11:
.DB	25,32,32,80,108,101,97,115,101,32,103,105,118,101,32,121,111,117,114,32,99,104,111,105,99,101


StringTable12:
.DB	1,82


StringTable13:
.DB	1,114


StringTable14:
.DB	1,68


StringTable15:
.DB	1,70


StringTable16:
.DB	1,69


StringTable17:
.DB	2,79,78,0


StringTable18:
.DB	1,61


StringTable19:
.DB	56,32,32,84,104,101,32,101,110,116,114,121,32,111,102,32,116,104,101,32,99,104,111,115,101,110,32,70,105,108,101,47,68,105,114,32,105,115,32,32,97,116,32,66,111,111,116,32,114,101,99,111,114,100,32,110,46,0


StringTable20:
.DB	40,32,32,84,104,101,32,99,104,111,111,115,101,110,32,70,105,108,101,47,68,105,114,32,105,115,32,97,116,32,99,108,117,115,116,101,114,32,110,46,61,0


StringTable21:
.DB	37,32,32,76,66,65,32,65,100,100,114,101,115,115,32,111,102,32,116,104,101,32,99,104,111,115,101,110,32,70,105,108,101,47,68,105,114,61


StringTable22:
.DB	1,45


StringTable23:
.DB	22,65,32,46,98,105,110,32,70,105,108,101,32,105,115,32,97,115,115,117,109,101,100,0


StringTable24:
.DB	17,32,105,110,32,116,104,101,32,102,111,108,108,111,119,105,110,103


StringTable25:
.DB	23,32,32,61,61,61,77,65,75,73,78,71,32,84,72,69,32,80,73,67,84,85,82,69


StringTable42:
.DB	16,42,32,73,110,105,116,105,97,108,105,122,97,116,105,111,110,0


StringTable43:
.DB	9,32,83,116,97,114,116,115,32,42


StringTable44:
.DB	14,32,115,117,99,99,101,115,115,102,117,108,108,32,42,0


StringTable45:
.DB	16,32,85,78,83,85,67,67,69,83,83,70,85,76,76,32,42,0


StringTable46:
.DB	8,32,32,32,32,67,77,68,48,0


StringTable47:
.DB	6,45,67,77,68,48,32,0


StringTable48:
.DB	10,32,32,69,120,101,99,117,116,101,100,0


StringTable49:
.DB	6,45,67,77,68,56,32,0


StringTable50:
.DB	7,102,97,105,108,101,100,46


StringTable51:
.DB	11,32,32,69,120,101,99,117,116,101,100,46


StringTable52:
.DB	12,32,32,32,32,32,32,32,32,67,97,114,100,0


StringTable53:
.DB	6,32,105,115,32,86,50,0


StringTable54:
.DB	7,45,67,77,68,56,32,32


StringTable55:
.DB	10,32,69,120,101,99,117,116,101,100,46,0


StringTable56:
.DB	6,32,105,115,32,86,49,0


StringTable57:
.DB	4,32,32,32,32,0


StringTable58:
.DB	3,32,32,32


StringTable59:
.DB	16,32,84,104,101,32,67,77,68,56,32,99,104,101,99,107,32,0


StringTable60:
.DB	20,112,97,116,116,101,114,110,32,105,115,32,99,111,110,102,105,114,109,101,100,0


StringTable61:
.DB	24,112,97,116,116,101,114,110,32,105,115,32,110,111,116,32,99,111,110,102,105,114,109,101,100,0


StringTable62:
.DB	12,83,68,82,101,115,112,111,110,115,101,51,61,0


StringTable63:
.DB	18,32,84,104,101,32,67,77,68,56,32,99,111,110,102,105,114,109,32,0


StringTable64:
.DB	12,118,111,108,116,97,103,101,32,67,97,114,100,0


StringTable65:
.DB	19,32,84,104,101,32,67,77,68,56,32,100,111,101,115,32,110,111,116,32


StringTable66:
.DB	20,99,111,110,102,105,114,109,32,86,111,108,116,97,103,101,32,67,97,114,100,0


StringTable67:
.DB	12,83,68,82,101,115,112,111,110,115,101,50,61,0


StringTable68:
.DB	8,45,65,67,77,68,52,49,32,0


StringTable69:
.DB	9,69,120,101,99,117,116,101,100,46


StringTable70:
.DB	7,32,97,102,116,101,114,32


StringTable71:
.DB	9,32,97,116,116,101,109,112,116,115


StringTable72:
.DB	23,32,32,32,32,32,32,32,32,67,77,68,52,49,32,82,101,115,112,111,110,115,101,61


StringTable73:
.DB	16,32,67,77,68,53,53,32,82,101,115,112,111,110,115,101,61,0


StringTable74:
.DB	7,45,67,77,68,53,56,32


StringTable75:
.DB	14,32,69,120,101,99,117,116,101,100,32,79,75,46,32,0


StringTable76:
.DB	16,65,116,116,101,109,112,116,115,32,110,117,109,98,101,114,61,0


StringTable77:
.DB	25,32,32,32,32,32,32,32,32,70,105,114,115,116,32,83,68,82,101,115,112,111,110,115,101,61


StringTable78:
.DB	28,32,32,32,32,32,32,32,32,83,68,82,101,115,112,111,110,115,101,115,50,45,51,45,52,45,53,61,40,0


StringTable79:
.DB	1,44


StringTable80:
.DB	1,41


StringTable81:
.DB	28,32,32,32,32,32,32,32,32,84,104,101,32,67,97,114,100,32,105,115,32,86,50,32,83,68,83,67,32,0


StringTable82:
.DB	30,119,105,116,104,32,83,116,97,110,100,97,114,100,32,99,97,112,97,99,105,116,121,32,40,67,67,83,61,48,41,0


StringTable83:
.DB	30,32,32,32,32,32,32,32,32,84,104,101,32,67,97,114,100,32,105,115,32,86,50,32,83,67,88,67,32,111,114,0


StringTable84:
.DB	36,32,83,68,72,67,32,119,105,116,104,32,69,120,116,101,110,100,101,100,32,99,97,112,97,99,105,116,121,32,40,67,67,83,61,49,41,0


StringTable85:
.DB	14,32,69,120,101,99,117,116,101,100,32,33,79,75,46,0


StringTable86:
.DB	12,78,46,32,97,116,116,101,109,112,116,115,61,0


StringTable87:
.DB	1,42


StringTable91:
.DB	20,45,67,77,68,49,54,32,32,79,75,32,32,69,120,101,99,117,116,101,100,0


StringTable92:
.DB	2,32,32,0


StringTable93:
.DB	20,45,67,77,68,49,54,32,32,33,79,75,32,69,120,101,99,117,116,101,100,0


StringTable94:
.DB	16,32,32,32,32,32,32,32,82,101,115,112,111,110,115,101,61,0


StringTable95:
.DB	13,44,32,83,68,95,67,111,117,110,116,101,114,61


StringTable96:
.DB	8,45,67,77,68,49,55,32,32,0


StringTable97:
.DB	17,87,97,105,116,105,110,103,32,102,111,114,32,84,111,107,101,110


StringTable98:
.DB	2,46,32,0


StringTable99:
.DB	11,45,67,77,68,49,55,32,32,79,75,32


StringTable100:
.DB	8,69,120,101,99,117,116,101,100,0


StringTable101:
.DB	17,44,32,70,105,114,115,116,32,82,101,115,112,111,110,115,101,61


StringTable102:
.DB	13,44,32,84,111,107,101,110,40,50,53,52,41,61


StringTable103:
.DB	13,32,110,46,32,97,116,116,101,109,112,116,115,61


StringTable104:
.DB	20,45,67,77,68,49,55,32,32,33,79,75,32,69,120,101,99,117,116,101,100,0


StringTable105:
.DB	30,32,32,32,32,32,82,101,97,100,105,110,103,32,77,66,82,32,97,116,32,48,120,49,66,69,32,97,110,100,32,0


StringTable106:
.DB	24,80,97,114,116,105,116,105,111,110,32,86,111,108,117,109,101,32,73,68,32,100,97,116,97,0


StringTable107:
.DB	14,32,32,70,105,108,101,32,83,121,115,116,101,109,32,0


StringTable108:
.DB	23,32,32,70,105,108,101,32,83,121,115,116,101,109,32,86,101,114,32,78,117,109,46,61


StringTable109:
.DB	15,32,32,86,111,108,117,109,101,95,76,97,98,101,108,61


StringTable110:
.DB	22,32,32,78,46,32,66,121,116,101,115,32,112,101,114,32,83,101,99,116,111,114,61,0


StringTable111:
.DB	24,32,32,78,46,32,83,101,99,116,111,114,32,112,101,114,32,67,108,117,115,116,101,114,61,0


StringTable112:
.DB	22,32,32,78,46,32,82,101,115,101,114,118,101,100,32,83,101,99,116,111,114,115,61,0


StringTable113:
.DB	10,32,32,78,46,32,70,65,84,83,61,0


StringTable114:
.DB	20,32,32,78,46,32,83,101,99,116,111,114,32,112,101,114,32,70,97,116,61,0


StringTable115:
.DB	25,32,32,78,46,32,67,108,117,115,116,101,114,32,111,102,32,82,111,111,116,32,68,105,114,61


StringTable116:
.DB	1,50


StringTable117:
.DB	22,32,32,80,97,114,116,105,116,105,111,110,95,66,101,103,105,110,95,76,66,65,61,0


StringTable118:
.DB	16,32,32,70,97,116,95,66,101,103,105,110,95,76,66,65,61,0


StringTable119:
.DB	20,32,32,67,108,117,115,116,101,114,95,66,101,103,105,110,95,76,66,65,61,0


StringTable120:
.DB	15,68,105,114,101,99,116,111,114,105,101,115,32,97,110,100


StringTable121:
.DB	15,32,70,105,108,101,115,32,76,105,115,116,32,105,110,32


StringTable122:
.DB	10,32,32,68,105,114,32,32,110,46,61,0


StringTable123:
.DB	17,32,32,32,32,32,97,116,32,82,101,99,111,114,100,32,110,46


StringTable124:
.DB	16,68,105,114,101,99,116,111,114,105,101,115,32,97,110,100,32,0


StringTable125:
.DB	14,70,105,108,101,115,32,76,105,115,116,32,105,110,32,0


StringTable126:
.DB	6,32,32,66,79,79,84,0


StringTable127:
.DB	6,32,83,69,67,84,46,0


StringTable128:
.DB	13,32,97,116,32,82,101,99,111,114,100,32,110,46


StringTable129:
.DB	10,32,32,70,105,108,101,32,110,46,61,0


StringTable130:
.DB	1,46


;********************************************************************************

;Source: string.h (299)
FN_VAL:
;Parse SysInString, convert to word
;Stop parsing and exit on any non-number character
;Clear output value
;Val = 0
	ldi	SysValueCopy,0
	sts	VAL,SysValueCopy
	sts	VAL_H,SysValueCopy
;Get input length
;SysCharCount = SysInString(0)
	lds	SysStringA,SysSYSINSTRINGHandler
	lds	SysStringA_H,SysSYSINSTRINGHandler_H
	ld	SysValueCopy,X
	sts	SYSCHARCOUNT,SysValueCopy
;If SysCharCount = 0 Then Exit Function
	lds	SysCalcTempA,SYSCHARCOUNT
	tst	SysCalcTempA
	brne	ENDIF65
	ret
ENDIF65:
;Parse
;For SysStringTemp = 1 to SysCharCount
	ldi	SysValueCopy,0
	sts	SYSSTRINGTEMP,SysValueCopy
	lds	SysCalcTempA,SYSCHARCOUNT
	cpi	SysCalcTempA,1
	brsh	ENDIF66
	rjmp	SysForLoopEnd8
ENDIF66:
SysForLoop8:
	lds	SysTemp3,SYSSTRINGTEMP
	inc	SysTemp3
	sts	SYSSTRINGTEMP,SysTemp3
;SysStrData = SysInString(SysStringTemp)
	lds	SysTemp3,SysSYSINSTRINGHandler
	lds	SysTemp1,SYSSTRINGTEMP
	add	SysTemp3,SysTemp1
	mov	SysStringA,SysTemp3
	lds	SysTemp3,SysSYSINSTRINGHandler_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	mov	SysStringA_H,SysTemp3
	ld	SysValueCopy,X
	sts	SYSSTRDATA,SysValueCopy
;Exit if non-digit encountered
;If SysStrData < 48 Then Exit Sub
	lds	SysCalcTempA,SYSSTRDATA
	cpi	SysCalcTempA,48
	brsh	ENDIF67
	ret
ENDIF67:
;If SysStrData > 57 Then Exit Sub
	ldi	SysCalcTempA,57
	lds	SysCalcTempB,SYSSTRDATA
	cp	SysCalcTempA,SysCalcTempB
	brsh	ENDIF68
	ret
ENDIF68:
;Add to output value
;Val = Val * 10 + SysStrData - 48
	lds	SysWORDTempA,VAL
	lds	SysWORDTempA_H,VAL_H
	ldi	SysWORDTempB,10
	ldi	SysWORDTempB_H,0
	rcall	SysMultSub16
	mov	SysTemp3,SysWORDTempX
	lds	SysTemp2,SYSSTRDATA
	add	SysTemp3,SysTemp2
	mov	SysTemp1,SysTemp3
	mov	SysTemp3,SysWORDTempX_H
	ldi	SysTemp4,0
	adc	SysTemp3,SysTemp4
	mov	SysTemp1_H,SysTemp3
	ldi	SysTemp4,48
	sub	SysTemp1,SysTemp4
	sts	VAL,SysTemp1
	ldi	SysTemp4,0
	sbc	SysTemp1_H,SysTemp4
	sts	VAL_H,SysTemp1_H
;Next
	lds	SysCalcTempA,SYSSTRINGTEMP
	lds	SysCalcTempB,SYSCHARCOUNT
	cp	SysCalcTempA,SysCalcTempB
	brlo	SysForLoop8
SysForLoopEnd8:
	ret

;********************************************************************************


