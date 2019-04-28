;Program compiled by Great Cow BASIC (0.95 2016-04-30)
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F4520, r=DEC
#include <P18F4520.inc>
 CONFIG LVP = OFF, STVREN = OFF, MCLRE = ON, PBADEN = OFF, WDT = OFF, BOREN = OFF, PWRT = ON, OSC = HS

;********************************************************************************

;Set aside memory locations for variables
01	EQU	13
ACKPSH	EQU	14
ADDR	EQU	15
ARRAYLOC	EQU	16
ARRAYLOC_H	EQU	17
BANKTOBESELECTED	EQU	18
BUTTONSTATE	EQU	19
CHR	EQU	792
CLIENT_SEQNUM	EQU	20
CLIENT_SEQNUM_E	EQU	24
CLIENT_SEQNUM_H	EQU	25
CLIENT_SEQNUM_U	EQU	26
CNT	EQU	27
COMPORT	EQU	28
COUNTLOOP	EQU	29
COUNTLOOP_H	EQU	30
CRL	EQU	31
DELAYTEMP	EQU	0
DELAYTEMP2	EQU	1
ENC28J60_DATA	EQU	32
ENC28J60_READREG	EQU	33
ENC28J60_TEMP	EQU	34
ENC_OUTBYTE	EQU	35
ENC_OUTBYTE1	EQU	36
ENC_OUTBYTE2	EQU	37
ENDPTR	EQU	38
ENDPTR_H	EQU	39
EPOCH_SECONDS	EQU	40
EPOCH_SECONDS_E	EQU	44
EPOCH_SECONDS_H	EQU	45
EPOCH_SECONDS_U	EQU	46
ETHERBUFFER	EQU	833
ETHERGETLENGTH	EQU	47
ETHERGETLENGTH_H	EQU	48
ETH_COUNTER	EQU	49
ETH_COUNTER_H	EQU	51
ETH_FRAMELENGTH	EQU	52
ETH_FRAMELENGTH_H	EQU	54
EXPECTED_ACK	EQU	55
EXPECTED_ACK_E	EQU	58
EXPECTED_ACK_H	EQU	56
EXPECTED_ACK_U	EQU	57
FLAGS	EQU	59
FNLSL	EQU	60
FNLSL_E	EQU	63
FNLSL_H	EQU	61
FNLSL_U	EQU	62
FNLSR	EQU	64
FNLSR_E	EQU	67
FNLSR_H	EQU	65
FNLSR_U	EQU	66
HEX	EQU	693
HSERPRINTCRLFCOUNT	EQU	68
HTMLMAPPING	EQU	69
HTMLMAPPINGTYPE	EQU	70
HULP2	EQU	71
HULP2_H	EQU	73
HULP3	EQU	74
I2CACK	EQU	75
I2CACKPOLLSTATE	EQU	76
I2CBYTE	EQU	77
I2CMATCH	EQU	78
I2COLDSTATE	EQU	79
I2CSTATE	EQU	80
I2CTEMP	EQU	81
I2C_LCD_BYTE	EQU	82
II	EQU	83
II_H	EQU	84
INCOMING_ACK	EQU	85
INCOMING_ACK_E	EQU	89
INCOMING_ACK_H	EQU	90
INCOMING_ACK_U	EQU	91
IPADDR	EQU	717
IPPORT	EQU	92
IPROUTER	EQU	712
IPSERVER	EQU	707
IP_CHECKSUM16	EQU	93
IP_CHECKSUM16_H	EQU	94
IP_CHKSUM32	EQU	95
IP_CHKSUM32_E	EQU	98
IP_CHKSUM32_H	EQU	96
IP_CHKSUM32_U	EQU	97
IP_HEADER_LENGTH	EQU	99
IP_HULP1	EQU	100
IP_ID	EQU	101
IP_ID_H	EQU	103
IP_TEMP16	EQU	104
IP_TEMP16_H	EQU	105
IP_X	EQU	106
I_CHECKSUM16	EQU	107
I_CHECKSUM16_H	EQU	109
I_CHKSUM32	EQU	110
I_CHKSUM32_E	EQU	113
I_CHKSUM32_H	EQU	111
I_CHKSUM32_U	EQU	114
I_ODD	EQU	115
I_X	EQU	116
I_X_H	EQU	117
L2	EQU	118
L2_E	EQU	121
L2_H	EQU	119
L2_U	EQU	120
LASTSELECTEDBANK	EQU	122
LCDBYTE	EQU	123
LCDCOLUMN	EQU	124
LCDLINE	EQU	125
LCD_BACKLIGHT	EQU	126
LCD_I2C_ADDRESS_CURRENT	EQU	127
LCD_STATE	EQU	128
LOCALTMP	EQU	129
LOCALTMP_H	EQU	131
MACADDR	EQU	722
MACADDRROUTER	EQU	702
MAXLEN	EQU	132
MAXLEN_H	EQU	133
MSG_TEMP2	EQU	740
MYDEBUGCOUNT	EQU	134
MYDEBUGCOUNT_E	EQU	137
MYDEBUGCOUNT_H	EQU	135
MYDEBUGCOUNT_U	EQU	136
NEXTPACKETPTR	EQU	138
NEXTPACKETPTR_H	EQU	140
NUMBITS	EQU	141
OLDPACKETCOUNTERIN	EQU	142
OLDPACKETCOUNTERIN_E	EQU	145
OLDPACKETCOUNTERIN_H	EQU	143
OLDPACKETCOUNTERIN_U	EQU	144
OLDPACKETCOUNTEROUT	EQU	146
OLDPACKETCOUNTEROUT_E	EQU	149
OLDPACKETCOUNTEROUT_H	EQU	147
OLDPACKETCOUNTEROUT_U	EQU	148
OUTVALUETEMP	EQU	150
PACKETCOUNTERIN	EQU	151
PACKETCOUNTERIN_E	EQU	154
PACKETCOUNTERIN_H	EQU	152
PACKETCOUNTERIN_U	EQU	153
PACKETCOUNTEROUT	EQU	155
PACKETCOUNTEROUT_E	EQU	158
PACKETCOUNTEROUT_H	EQU	156
PACKETCOUNTEROUT_U	EQU	157
PACKETLENGTH	EQU	159
PACKETLENGTH_H	EQU	161
PCKTLEN	EQU	162
PCKTLEN_H	EQU	163
PHYREGADDR	EQU	164
PREVIOUS_NEXTPACKETPTR	EQU	165
PREVIOUS_NEXTPACKETPTR_H	EQU	166
PRINTLEN	EQU	167
RESULT	EQU	168
RESULT_H	EQU	169
RXSTAT	EQU	170
RXSTAT_H	EQU	171
SERDATA	EQU	172
SERPRINTVAL	EQU	173
SERPRINTVAL_E	EQU	176
SERPRINTVAL_H	EQU	174
SERPRINTVAL_U	EQU	175
SNTPSERVERADDR	EQU	697
SPICLOCKMODE	EQU	177
SPICURRENTMODE	EQU	178
SPIRXDATA	EQU	179
SPITXDATA	EQU	180
STARTPTR	EQU	181
STARTPTR_H	EQU	182
STRINGPOINTER	EQU	183
SUM	EQU	184
SUM_E	EQU	187
SUM_H	EQU	185
SUM_U	EQU	186
SYSARRAYTEMP1	EQU	188
SYSARRAYTEMP2	EQU	189
SYSBITVAR0	EQU	190
SYSBYTETEMPA	EQU	5
SYSBYTETEMPB	EQU	9
SYSBYTETEMPX	EQU	0
SYSCALCTEMPA	EQU	5
SYSCALCTEMPA_E	EQU	8
SYSCALCTEMPA_H	EQU	6
SYSCALCTEMPA_U	EQU	7
SYSCALCTEMPB	EQU	9
SYSCALCTEMPX	EQU	0
SYSCALCTEMPX_H	EQU	1
SYSCHAR	EQU	191
SYSDIVLOOP	EQU	4
SYSDIVMULTA	EQU	7
SYSDIVMULTA_H	EQU	8
SYSDIVMULTB	EQU	11
SYSDIVMULTB_H	EQU	12
SYSDIVMULTX	EQU	2
SYSDIVMULTX_H	EQU	3
SYSFNBYTE1	EQU	192
SYSLCDTEMP	EQU	193
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
SYSMACADDRHANDLER	EQU	206
SYSMACADDRHANDLER_H	EQU	207
SYSPRINTBUFFER	EQU	729
SYSPRINTBUFFLEN	EQU	208
SYSPRINTDATAHANDLER	EQU	209
SYSPRINTDATAHANDLER_H	EQU	210
SYSPRINTTEMP	EQU	211
SYSREPEATTEMP1	EQU	212
SYSREPEATTEMP10	EQU	213
SYSREPEATTEMP11	EQU	214
SYSREPEATTEMP2	EQU	215
SYSREPEATTEMP3	EQU	216
SYSREPEATTEMP4	EQU	217
SYSREPEATTEMP5	EQU	218
SYSREPEATTEMP6	EQU	219
SYSREPEATTEMP7	EQU	220
SYSREPEATTEMP8	EQU	221
SYSREPEATTEMP9	EQU	222
SYSSTRINGA	EQU	7
SYSSTRINGA_H	EQU	8
SYSSTRINGLENGTH	EQU	6
SYSSTRINGPARAM1	EQU	751
SYSSTRINGTEMP	EQU	223
SYSTEMP1	EQU	224
SYSTEMP1_E	EQU	227
SYSTEMP1_H	EQU	225
SYSTEMP1_U	EQU	226
SYSTEMP2	EQU	228
SYSTEMP3	EQU	229
SYSVALTEMP	EQU	230
SYSWAITTEMP10US	EQU	5
SYSWAITTEMPMS	EQU	2
SYSWAITTEMPMS_H	EQU	3
SYSWAITTEMPS	EQU	4
SYSWAITTEMPUS	EQU	5
SYSWAITTEMPUS_H	EQU	6
SYSWORDTEMPA	EQU	5
SYSWORDTEMPA_H	EQU	6
SYSWORDTEMPB	EQU	9
SYSWORDTEMPB_H	EQU	10
SYSWORDTEMPX	EQU	0
SYSWORDTEMPX_H	EQU	1
T1	EQU	231
T1_H	EQU	233
T2	EQU	234
T2_H	EQU	236
TABLELOC	EQU	237
TABLELOC_H	EQU	238
TCPDATALEN_IN	EQU	239
TCPDATALEN_IN_H	EQU	240
TCPDATALEN_OUT	EQU	241
TCPDATALEN_OUT_H	EQU	242
TCPRESULT16	EQU	243
TCPRESULT16_H	EQU	245
TEMP	EQU	246
TEMPSTRING1	EQU	690
TEMPWORD3	EQU	247
TEMPWORD3_H	EQU	248
TEMPWORD4	EQU	249
TEMPWORD4_H	EQU	250
TT	EQU	251
TT_H	EQU	252
T_UDP_DESTPORT	EQU	253
T_UDP_DESTPORT_H	EQU	254
VAL1	EQU	255
VAL2	EQU	256
VAL2_H	EQU	257
VAL3	EQU	258
VAL4	EQU	259
WORK	EQU	260
X_ODD	EQU	261

;********************************************************************************

;Alias variables
AFSR0	EQU	4073
AFSR0_H	EQU	4074
I_VALUE16	EQU	107
I_VALUE16_H	EQU	109
SYSCHR_0	EQU	792
SYSCHR_1	EQU	793
SYSETHERBUFFER_1	EQU	834
SYSETHERBUFFER_10	EQU	843
SYSETHERBUFFER_11	EQU	844
SYSETHERBUFFER_12	EQU	845
SYSETHERBUFFER_13	EQU	846
SYSETHERBUFFER_14	EQU	847
SYSETHERBUFFER_15	EQU	848
SYSETHERBUFFER_16	EQU	849
SYSETHERBUFFER_17	EQU	850
SYSETHERBUFFER_18	EQU	851
SYSETHERBUFFER_19	EQU	852
SYSETHERBUFFER_2	EQU	835
SYSETHERBUFFER_20	EQU	853
SYSETHERBUFFER_21	EQU	854
SYSETHERBUFFER_22	EQU	855
SYSETHERBUFFER_23	EQU	856
SYSETHERBUFFER_24	EQU	857
SYSETHERBUFFER_25	EQU	858
SYSETHERBUFFER_26	EQU	859
SYSETHERBUFFER_27	EQU	860
SYSETHERBUFFER_28	EQU	861
SYSETHERBUFFER_29	EQU	862
SYSETHERBUFFER_3	EQU	836
SYSETHERBUFFER_30	EQU	863
SYSETHERBUFFER_31	EQU	864
SYSETHERBUFFER_32	EQU	865
SYSETHERBUFFER_33	EQU	866
SYSETHERBUFFER_34	EQU	867
SYSETHERBUFFER_35	EQU	868
SYSETHERBUFFER_36	EQU	869
SYSETHERBUFFER_37	EQU	870
SYSETHERBUFFER_38	EQU	871
SYSETHERBUFFER_39	EQU	872
SYSETHERBUFFER_4	EQU	837
SYSETHERBUFFER_40	EQU	873
SYSETHERBUFFER_41	EQU	874
SYSETHERBUFFER_42	EQU	875
SYSETHERBUFFER_43	EQU	876
SYSETHERBUFFER_44	EQU	877
SYSETHERBUFFER_45	EQU	878
SYSETHERBUFFER_46	EQU	879
SYSETHERBUFFER_47	EQU	880
SYSETHERBUFFER_48	EQU	881
SYSETHERBUFFER_49	EQU	882
SYSETHERBUFFER_5	EQU	838
SYSETHERBUFFER_50	EQU	883
SYSETHERBUFFER_51	EQU	884
SYSETHERBUFFER_52	EQU	885
SYSETHERBUFFER_53	EQU	886
SYSETHERBUFFER_54	EQU	887
SYSETHERBUFFER_55	EQU	888
SYSETHERBUFFER_56	EQU	889
SYSETHERBUFFER_57	EQU	890
SYSETHERBUFFER_58	EQU	891
SYSETHERBUFFER_59	EQU	892
SYSETHERBUFFER_6	EQU	839
SYSETHERBUFFER_60	EQU	893
SYSETHERBUFFER_61	EQU	894
SYSETHERBUFFER_62	EQU	895
SYSETHERBUFFER_63	EQU	896
SYSETHERBUFFER_64	EQU	897
SYSETHERBUFFER_65	EQU	898
SYSETHERBUFFER_66	EQU	899
SYSETHERBUFFER_67	EQU	900
SYSETHERBUFFER_68	EQU	901
SYSETHERBUFFER_69	EQU	902
SYSETHERBUFFER_7	EQU	840
SYSETHERBUFFER_70	EQU	903
SYSETHERBUFFER_8	EQU	841
SYSETHERBUFFER_9	EQU	842
SYSHEX_0	EQU	693
SYSHEX_1	EQU	694
SYSHEX_2	EQU	695
SYSIPADDR_1	EQU	718
SYSIPADDR_2	EQU	719
SYSIPADDR_3	EQU	720
SYSIPADDR_4	EQU	721
SYSMACADDRROUTER_1	EQU	703
SYSMACADDRROUTER_2	EQU	704
SYSMACADDRROUTER_3	EQU	705
SYSMACADDRROUTER_4	EQU	706
SYSMACADDRROUTER_5	EQU	707
SYSMACADDRROUTER_6	EQU	708
SYSMACADDR_1	EQU	723
SYSMACADDR_2	EQU	724
SYSMACADDR_3	EQU	725
SYSMACADDR_4	EQU	726
SYSMACADDR_5	EQU	727
SYSMACADDR_6	EQU	728
SYSSNTPSERVERADDR_1	EQU	698
SYSSNTPSERVERADDR_2	EQU	699
SYSSNTPSERVERADDR_3	EQU	700
SYSSNTPSERVERADDR_4	EQU	701

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
	call	ENC28J60_INITIALISE
	call	INITLCD
	call	INITUSART
	call	INITI2C

;Start of the main program
;''A program  for GCGB and GCB.
;''A program  for GCGB and GCB.
;''--------------------------------------------------------------------------------------------------------------------------------
;'' Description  :  Setup ENC28j60, then reads data from the Ethernet stream to a PC terminal.
;''
;''	You NEED a PC terminal connected to the serial out on the microprocessor.
;''
;''@author 		[todo]
;''@licence		GPL
;''@version		[todo]
;''@date   		[todo]
;''********************************************************************************
;___________
;MCLR - MCLR/E.3 -|1    U   40|- B.7/PGD - BUS 1 = Address Digit 4
;Wireless Data In (D0) - A.0 -|2        39|- B.6/PGC - BUS 1 = Address Digit 3
;Wireless Data In (D1) - A.1 -|3        38|- B.5/PGM - BUS 1 = Address Digit 2
;Wireless Data In (D2) - A.2 -|4        37|- B.4 - BUS 1 = Address Digit 1
;Wireless Data In (D3) - A.3 -|5        36|- B.3 - Data Bit 8
;Button Input 1 - A.4 -|6        35|- B.2 - Data Bit 4
;Button Input 2 - A.5 -|7        34|- B.1 - Data Bit 2
;Button Input 4 - E.0 -|8        33|- B.0 - Data Bit 1
;Square Wave Input (I2C Bus) - E.1 -|9        32|- (+)
;Hooter Out - E.2 -|10       31|- (-)
;(+) -|11       30|- D.7 - BUS 2 = Address Digit 4
;(-) -|12       29|- D.6 - BUS 2 = Address Digit 3
;OSC1 -|13       28|- D.5 - BUS 2 = Address Digit 2
;OSC2 -|14       27|- D.4 - BUS 2 = Address Digit 1
;BUS 1 = Address Digit 5 - C.0 -|15       26|- C.7/RX - RS232 RX
;BUS 1 = Address Digit 6 - C.1 -|16       25|- C.6/TX - RS232 TX
;Aux I/O 1 + Heartbeat LED - C.2 -|17       24|- C.5 - Button Input 3
;I2C Bus (Clock) - C.3/SCL -|18       23|- C.4/SDA - I2C Bus (Data)
;BUS 2 = Address Digit 5 - D.0 -|19       22|- D.3 - Aux I/O 3 -
;BUS 2 = Address Digit 6 - D.1 -|20_______21|- D.2 - Aux I/O 2 -
;
;#define USART_BAUD_RATE 9600
;#define USART_BLOCKING
;#define USART_TX_BLOCKING
;----- Define Hardware settings
;#Define ENC28J60_DI								PortC.4							'Connected to Device SO
;#Define ENC28J60_DO								PortC.5							'Connected to Device SI
;#Define ENC28J60_SCK							PortC.3							'Connected to Clock
;#Define ENC28J60_CS 							PortA.5							'Chip select line
;#Define ENC28J60_RESET  					PortD.2							'Reset line
;#Define Heartbeat 								PortC.2
;#Define TX 												PortC.7
;#Define RX												PortC.6
;#Define Button										PortA.4
;#Define I2C_MODE 						  		Master
;#Define I2C_DATA 						  	 	PortC.4 'PortB.1
;#Define I2C_CLOCK 								PortB.0
;#Define I2C_DISABLE_INTERRUPTS 		On
;#Define LCD_IO 										10
;#Define LCD_2C_Address_1 					0x4E ; default to 0x4E
;#Define LCD_SPEED 								Fast
;#Define LCD_Backlight_On_State  	1
;#Define LCD_Backlight_Off_State 	0
;#Define Delay											1 S
;----- Variables
;----- Quick Command Reference:
;----- Main body of program commences here.
RESET_ENC26J60
;Cls
	rcall	CLS
;Locate (1,1)
	movlw	1
	movwf	LCDLINE,BANKED
	movlw	1
	movwf	LCDCOLUMN,BANKED
	call	LOCATE
;Print "ENC28j60 Ethernet"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable4
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable4
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	call	PRINT113
;Locate (2,5)
	movlw	2
	movwf	LCDLINE,BANKED
	movlw	5
	movwf	LCDCOLUMN,BANKED
	call	LOCATE
;Print "Driver 024"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable5
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable5
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	call	PRINT113
;Wait Delay
	movlw	1
	movwf	SysWaitTempS,ACCESS
	rcall	Delay_S
;Cls
	rcall	CLS
;HSerPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;HserPrint "ENC28j60 Ethernet Driver 024" : HSerPrintCRLF
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable6
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable6
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT245
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;HSerSend 7
	movlw	7
	movwf	SERDATA,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERSEND
;ipaddr = 10,0,0,35
	lfsr	0,IPADDR
	movlw	4
	movwf	POSTINC0,ACCESS
	movlw	10
	movwf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	movlw	35
	movwf	POSTINC0,ACCESS
;macaddr = 0x00, 0x1E, 0xC0, 0x00, 0x00, 0x02
	lfsr	0,MACADDR
	movlw	6
	movwf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	movlw	30
	movwf	POSTINC0,ACCESS
	movlw	192
	movwf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	movlw	2
	movwf	POSTINC0,ACCESS
;ipport = 80
	movlw	80
	movwf	IPPORT,BANKED
;ipserver = 10,0,0,36
	lfsr	0,IPSERVER
	movlw	4
	movwf	POSTINC0,ACCESS
	movlw	10
	movwf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	movlw	36
	movwf	POSTINC0,ACCESS
;iprouter = 10,0,0,2
	lfsr	0,IPROUTER
	movlw	4
	movwf	POSTINC0,ACCESS
	movlw	10
	movwf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	movlw	2
	movwf	POSTINC0,ACCESS
;macaddrrouter = 0x44, 0x94, 0xfc, 0xa3, 0xe5, 0x8f
	lfsr	0,MACADDRROUTER
	movlw	6
	movwf	POSTINC0,ACCESS
	movlw	68
	movwf	POSTINC0,ACCESS
	movlw	148
	movwf	POSTINC0,ACCESS
	movlw	252
	movwf	POSTINC0,ACCESS
	movlw	163
	movwf	POSTINC0,ACCESS
	movlw	229
	movwf	POSTINC0,ACCESS
	movlw	143
	movwf	POSTINC0,ACCESS
;sntpserveraddr = 129, 6, 15, 28
	lfsr	0,SNTPSERVERADDR
	movlw	4
	movwf	POSTINC0,ACCESS
	movlw	129
	movwf	POSTINC0,ACCESS
	movlw	6
	movwf	POSTINC0,ACCESS
	movlw	15
	movwf	POSTINC0,ACCESS
	movlw	28
	movwf	POSTINC0,ACCESS
;ENC28j60_Init ( macaddr )
	movlw	low MACADDR
	movwf	SysMACADDRHandler,BANKED
	movlw	high MACADDR
	movwf	SysMACADDRHandler_H,BANKED
	call	ENC28J60_INIT
;HserPrint "Initialised"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable7
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable7
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT245
;		Locate (1,4)
	movlw	1
	movwf	LCDLINE,BANKED
	movlw	4
	movwf	LCDCOLUMN,BANKED
	call	LOCATE
;Print "Initialised."
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable8
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable8
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	call	PRINT113
;dir Heartbeat out
	bcf	TRISC,2,ACCESS
;dir Button in
	bsf	TRISA,4,ACCESS
;#define ButtonDown = 1
;buttonstate = ButtonDown
	movlw	1
	movwf	BUTTONSTATE,BANKED
;ENC28j60_bitSet( ECON1 , econ1_txrst )
	movlw	31
	movwf	ADDR,BANKED
	movlw	128
	movwf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_BITSET
;ENC28j60_bitClear( ECON1 , econ1_txrst )
	movlw	31
	movwf	ADDR,BANKED
	movlw	128
	movwf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_BITCLEAR
;ENC28j60_Ntp_get                       'get the Network Time once
;HSerPrint "..."
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable9
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable9
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT245
;HSerPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;ENC28j60_writeReg(ERXFCON, 0x00)
	movlw	56
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;Do forever
SysDoLoop_S1
;if Button = buttonstate then
	clrf	SysCalcTempA,ACCESS
	btfsc	PORTA,4,ACCESS
	incf	SysCalcTempA,F,ACCESS
	movf	BUTTONSTATE,W,BANKED
	subwf	SysCalcTempA,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF2
;if buttonstate  = ButtonDown then
	decf	BUTTONSTATE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF3
;HserPrint cnt
	movff	CNT,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT246
;HserPrint ", "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable10
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable10
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT245
;HserPrint packetCounterOut
	movff	PACKETCOUNTEROUT,SERPRINTVAL
	movff	PACKETCOUNTEROUT_H,SERPRINTVAL_H
	movff	PACKETCOUNTEROUT_U,SERPRINTVAL_U
	movff	PACKETCOUNTEROUT_E,SERPRINTVAL_E
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT249
;HserPrint ", "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable10
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable10
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT245
;HserPrint packetCounterIn
	movff	PACKETCOUNTERIN,SERPRINTVAL
	movff	PACKETCOUNTERIN_H,SERPRINTVAL_H
	movff	PACKETCOUNTERIN_U,SERPRINTVAL_U
	movff	PACKETCOUNTERIN_E,SERPRINTVAL_E
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT249
;HserPrint ", "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable10
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable10
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT245
;OldpacketCounterIn = packetCounterIn
	movff	PACKETCOUNTERIN,OLDPACKETCOUNTERIN
	movff	PACKETCOUNTERIN_H,OLDPACKETCOUNTERIN_H
	movff	PACKETCOUNTERIN_U,OLDPACKETCOUNTERIN_U
	movff	PACKETCOUNTERIN_E,OLDPACKETCOUNTERIN_E
;OldpacketCounterOut = packetCounterOut
	movff	PACKETCOUNTEROUT,OLDPACKETCOUNTEROUT
	movff	PACKETCOUNTEROUT_H,OLDPACKETCOUNTEROUT_H
	movff	PACKETCOUNTEROUT_U,OLDPACKETCOUNTEROUT_U
	movff	PACKETCOUNTEROUT_E,OLDPACKETCOUNTEROUT_E
;ENC28j60_regdump
	call	ENC28J60_REGDUMP
;end if
ENDIF3
;end if
ENDIF2
;ENC28j60_poll 'Start the process.
	call	ENC28J60_POLL
;Loop
	bra	SysDoLoop_S1
SysDoLoop_E1
;end
	bra	BASPROGRAMEND
;----- Support methods.  Subroutines and Functions
;CHANGE Epoch_seconds  TO SUIT LOCAL NEEDS.. IN SECONDS!!
;#define ENC28j60_Handle_udp My_udp_handler
;If you want use the CALCULATED UDP checksum.  Not required typically.
;#define ENC28j60_UDP_checkSum_Supported
;If you want the ENC28j60 to respond to ICMP/Ping requests
;#define ENC28j60_ping_Supported
;If you want the ENC28j60 to put things on the LCD
;#define ENC28j60_Lcd_Supported
;If you want the ENC28j60 to put things on the terminal
;#define ENC28j60_Hserial_Supported
;#define ENC28j60_packetCounting_Supported
;If you want the UDP protocols to be supported.  You cannot turn off UDP/ARP
;#define ENC28j60_UDP_Supported
;#define ENC28j60_reinitialisation_Supported
;#define ENC28j60_sntp_Supported
;#define ENC28j60_sntp_UTC_adjust_supported
;#define ENC28j60_sntp_Remote_Supported
;#define ENC28j60_Echo7_Supported
;#define ENC28j60regdump_Supported
;If you want the TCP protocols to be supported.
;#define ENC28j60_tcp_supported
;#define ENC28j60_http_supported
;#define ENC28j60_telnet_supported
;#define ENC28j60_Select         Set ENC28j60_CS off
;#define ENC28j60_Deselect       Set ENC28j60_CS on
;#define ENC28j60_Reset_CMD			Set ENC28j60_RESET on: Wait 20 ms :Set ENC28j60_RESET off: Wait 20 ms :Set ENC28j60_RESET on: Wait 20 ms
;#define Synflag = 0
;#define Finflag = 1
CONFIGURATIONDETAILS
MEMORY_LOCATIONS_SCRIPT
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

FN_CHR
;If SysChar < 0 Then
	movlw	0
	subwf	SYSCHAR,W,BANKED
	btfsc	STATUS, C,ACCESS
	bra	ENDIF118
;Chr(0) = 0
	banksel	SYSCHR_0
	clrf	SYSCHR_0,BANKED
;Exit Function
	banksel	0
	return
;End If
ENDIF118
;Chr(0) = 1
	movlw	1
	banksel	SYSCHR_0
	movwf	SYSCHR_0,BANKED
;Chr(1) = SysChar
	movff	SYSCHAR,SYSCHR_1
	banksel	0
	return

;********************************************************************************

CLS
;SET LCD_RS OFF
	bcf	SYSLCDTEMP,1,BANKED
;LCDWriteByte (b'00000001')
	movlw	1
	movwf	LCDBYTE,BANKED
	call	LCDNORMALWRITEBYTE
;Wait 4 ms
	movlw	4
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;LCDWriteByte(0x80)
	movlw	128
	movwf	LCDBYTE,BANKED
	call	LCDNORMALWRITEBYTE
;Wait 12 10us
	movlw	12
	movwf	SysWaitTemp10US,ACCESS
	bra	Delay_10US

;********************************************************************************

Delay_10US
D10US_START
	movlw	15
	movwf	DELAYTEMP,ACCESS
DelayUS0
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS0
	nop
	decfsz	SysWaitTemp10US, F,ACCESS
	bra	D10US_START
	return

;********************************************************************************

Delay_MS
	incf	SysWaitTempMS_H, F,ACCESS
DMS_START
	movlw	227
	movwf	DELAYTEMP2,ACCESS
DMS_OUTER
	movlw	6
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

Delay_S
DS_START
	movlw	232
	movwf	SysWaitTempMS,ACCESS
	movlw	3
	movwf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
	decfsz	SysWaitTempS, F,ACCESS
	bra	DS_START
	return

;********************************************************************************

ENC28J60_ARPREPLY
;ENC28j60_set_response_macaddress
	call	ENC28J60_SET_RESPONSE_MACADDRESS
;For II = 1 To 6
;etherBuffer(32 + II) = etherBuffer(II)
;Next
;T_arp_dest_enetpacket0 = T_enetpacketdest0
	movff	SYSETHERBUFFER_1,SYSETHERBUFFER_33
;T_arp_dest_enetpacket1 = T_enetpacketdest1
	movff	SYSETHERBUFFER_2,SYSETHERBUFFER_34
;T_arp_dest_enetpacket2 = T_enetpacketdest2
	movff	SYSETHERBUFFER_3,SYSETHERBUFFER_35
;T_arp_dest_enetpacket3 = T_enetpacketdest3
	movff	SYSETHERBUFFER_4,SYSETHERBUFFER_36
;T_arp_dest_enetpacket4 = T_enetpacketdest4
	movff	SYSETHERBUFFER_5,SYSETHERBUFFER_37
;T_arp_dest_enetpacket5 = T_enetpacketdest5
	movff	SYSETHERBUFFER_6,SYSETHERBUFFER_38
;For II = 1 To 4
;etherBuffer(38 + II) = etherBuffer(28 + II)
;Next
;T_arp_tipaddr0 = T_arp_sipaddr0
	movff	SYSETHERBUFFER_29,SYSETHERBUFFER_39
;T_arp_tipaddr1 = T_arp_sipaddr1
	movff	SYSETHERBUFFER_30,SYSETHERBUFFER_40
;T_arp_tipaddr2 = T_arp_sipaddr2
	movff	SYSETHERBUFFER_31,SYSETHERBUFFER_41
;T_arp_tipaddr3 = T_arp_sipaddr3
	movff	SYSETHERBUFFER_32,SYSETHERBUFFER_42
;For II = 1 To 6
;etherBuffer(22 + II) = etherBuffer(6 + II)
;Next
;T_arp_src_enetpacket0 = T_enetpacketsrc0
	movff	SYSETHERBUFFER_7,SYSETHERBUFFER_23
;T_arp_src_enetpacket1 = T_enetpacketsrc1
	movff	SYSETHERBUFFER_8,SYSETHERBUFFER_24
;T_arp_src_enetpacket2 = T_enetpacketsrc2
	movff	SYSETHERBUFFER_9,SYSETHERBUFFER_25
;T_arp_src_enetpacket3 = T_enetpacketsrc3
	movff	SYSETHERBUFFER_10,SYSETHERBUFFER_26
;T_arp_src_enetpacket4 = T_enetpacketsrc4
	movff	SYSETHERBUFFER_11,SYSETHERBUFFER_27
;T_arp_src_enetpacket5 = T_enetpacketsrc5
	movff	SYSETHERBUFFER_12,SYSETHERBUFFER_28
;T_arp_sipaddr0 = ipaddr(1)
	movff	SYSIPADDR_1,SYSETHERBUFFER_29
;T_arp_sipaddr1 = ipaddr(2)
	movff	SYSIPADDR_2,SYSETHERBUFFER_30
;T_arp_sipaddr2 = ipaddr(3)
	movff	SYSIPADDR_3,SYSETHERBUFFER_31
;T_arp_sipaddr3 = ipaddr(4)
	movff	SYSIPADDR_4,SYSETHERBUFFER_32
;etherBuffer(22) = 2
	movlw	2
	banksel	SYSETHERBUFFER_22
	movwf	SYSETHERBUFFER_22,BANKED
;ENC28j60_writebuffer( 42 )
	movlw	42
	banksel	PCKTLEN
	movwf	PCKTLEN,BANKED
	clrf	PCKTLEN_H,BANKED
	call	ENC28J60_WRITEBUFFER
;ENC28j60_packetsend(42)
	movlw	42
	movwf	PCKTLEN,BANKED
	clrf	PCKTLEN_H,BANKED
	goto	ENC28J60_PACKETSEND

;********************************************************************************

ENC28J60_BITCLEAR
;				banktobeselected = ( addr & BANK_MASK) / 32
;banktobeselected = ( addr & BANK_MASK)
	movlw	96
	andwf	ADDR,W,BANKED
	movwf	BANKTOBESELECTED,BANKED
;Repeat 5
	movlw	5
	movwf	SysRepeatTemp3,BANKED
SysRepeatLoop3
;set c off
	bcf	STATUS,C,ACCESS
;rotate banktobeselected right
	rrcf	BANKTOBESELECTED,F,BANKED
;end repeat
	decfsz	SysRepeatTemp3,F,BANKED
	bra	SysRepeatLoop3
SysRepeatLoopEnd3
;if lastselectedBank <> banktobeselected then
	movf	BANKTOBESELECTED,W,BANKED
	subwf	LASTSELECTEDBANK,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ELSE6_1
;if ( ( addr & ADDR_MASK )  <= EIE  ) then
	movlw	31
	andwf	ADDR,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SysBYTETempB
	movlw	27
	movwf	SysBYTETempA,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	btfsc	SysByteTempX,0,ACCESS
;ENC28j60_selectBank ( banktobeselected, addr )
	call	ENC28J60_SELECTBANK
;end if
;Else
	bra	ENDIF6
ELSE6_1
;lastselectedBank = banktobeselected
	movff	BANKTOBESELECTED,LASTSELECTEDBANK
;end if
ENDIF6
;ENC28j60_Select
	bcf	LATA,5,ACCESS
;FastHWSPITransfer( ENC28j60_BIT_FIELD_CLR | (addr AND ADDR_MASK ), temp )
	movlw	31
	andwf	ADDR,W,BANKED
	movwf	SysTemp1,BANKED
	movlw	160
	iorwf	SysTemp1,W,BANKED
	movwf	SPITXDATA,BANKED
	call	FASTHWSPITRANSFER
;FastHWSPITransfer( ENC_Outbyte, temp )
	movff	ENC_OUTBYTE,SPITXDATA
	call	FASTHWSPITRANSFER
;ENC28j60_Deselect
	bsf	LATA,5,ACCESS
	return

;********************************************************************************

ENC28J60_BITSET
;				banktobeselected = ( addr & BANK_MASK) / 32
;HSerPrintByteCRLF banktobeselected
;banktobeselected = ( addr & BANK_MASK)
	movlw	96
	andwf	ADDR,W,BANKED
	movwf	BANKTOBESELECTED,BANKED
;Repeat 5
	movlw	5
	movwf	SysRepeatTemp2,BANKED
SysRepeatLoop2
;set c off
	bcf	STATUS,C,ACCESS
;rotate banktobeselected right
	rrcf	BANKTOBESELECTED,F,BANKED
;end repeat
	decfsz	SysRepeatTemp2,F,BANKED
	bra	SysRepeatLoop2
SysRepeatLoopEnd2
;HSerPrintByteCRLF banktobeselected
;HSerPrintCRLF
;if lastselectedBank <> banktobeselected then
	movf	BANKTOBESELECTED,W,BANKED
	subwf	LASTSELECTEDBANK,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ELSE4_1
;if ( ( addr & ADDR_MASK )  <= EIE  ) then
	movlw	31
	andwf	ADDR,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SysBYTETempB
	movlw	27
	movwf	SysBYTETempA,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	btfsc	SysByteTempX,0,ACCESS
;ENC28j60_selectBank ( banktobeselected, addr )
	call	ENC28J60_SELECTBANK
;end if
;Else
	bra	ENDIF4
ELSE4_1
;lastselectedBank = banktobeselected
	movff	BANKTOBESELECTED,LASTSELECTEDBANK
;end if
ENDIF4
;ENC28j60_Select
	bcf	LATA,5,ACCESS
;FastHWSPITransfer( ENC28j60_BIT_FIELD_SET | (addr AND ADDR_MASK ), temp )
	movlw	31
	andwf	ADDR,W,BANKED
	movwf	SysTemp1,BANKED
	movlw	128
	iorwf	SysTemp1,W,BANKED
	movwf	SPITXDATA,BANKED
	call	FASTHWSPITRANSFER
;FastHWSPITransfer( ENC_Outbyte, temp )
	movff	ENC_OUTBYTE,SPITXDATA
	call	FASTHWSPITRANSFER
;ENC28j60_Deselect
	bsf	LATA,5,ACCESS
	return

;********************************************************************************

ENC28J60_CALCCHECKSUM
;Dim II As Word
;Dim LocalTmp As Word
;Dim Sum As Long
;Sum = 0
	clrf	SUM,BANKED
	clrf	SUM_H,BANKED
	clrf	SUM_U,BANKED
	clrf	SUM_E,BANKED
;LocalTmp = 0
	clrf	LOCALTMP,BANKED
	clrf	LOCALTMP_H,BANKED
;I_odd = (Endptr - startptr ) Mod 2
	movf	STARTPTR,W,BANKED
	subwf	ENDPTR,W,BANKED
	movwf	SysTemp3,BANKED
	clrf	I_ODD,BANKED
	btfsc	SysTemp3,0,BANKED
	incf	I_ODD,F,BANKED
;if I_odd = 1 then HSerPrint "!"
	decf	I_ODD,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF96
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable21
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable21
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT245
ENDIF96
;For II = Startptr To Endptr Step 2
	movlw	2
	subwf	STARTPTR,W,BANKED
	movwf	II,BANKED
	movlw	0
	subwfb	STARTPTR_H,W,BANKED
	movwf	II_H,BANKED
	movff	STARTPTR,SysWORDTempB
	movff	STARTPTR_H,SysWORDTempB_H
	movff	ENDPTR,SysWORDTempA
	movff	ENDPTR_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd9
SysForLoop9
	movlw	2
	addwf	II,F,BANKED
	movlw	0
	addwfc	II_H,F,BANKED
;Sum = Sum + etherBuffer(II + 1)
	lfsr	0,ETHERBUFFER
	movf	II,W,BANKED
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp1,BANKED
	movlw	0
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movlw	1
	addwf	SysTemp1,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movf	INDF0,W,ACCESS
	addwf	SUM,F,BANKED
	movlw	0
	addwfc	SUM_H,F,BANKED
	movlw	0
	addwfc	SUM_U,F,BANKED
	movlw	0
	addwfc	SUM_E,F,BANKED
;LocalTmp_h  = etherBuffer(II)
	lfsr	0,ETHERBUFFER
	movf	II,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	INDF0,LOCALTMP_H
;Sum = Sum + LocalTmp
	movf	LOCALTMP,W,BANKED
	addwf	SUM,F,BANKED
	movf	LOCALTMP_H,W,BANKED
	addwfc	SUM_H,F,BANKED
	movlw	0
	addwfc	SUM_U,F,BANKED
	movlw	0
	addwfc	SUM_E,F,BANKED
;Next I
	movff	II,SysWORDTempA
	movff	II_H,SysWORDTempA_H
	movff	ENDPTR,SysWORDTempB
	movff	ENDPTR_H,SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop9
SysForLoopEnd9
;II = FnLsr( sum, 16 )
	movff	SUM,SYSLONGTEMPB
	movff	SUM_H,SYSLONGTEMPB_H
	movff	SUM_U,SYSLONGTEMPB_U
	movff	SUM_E,SYSLONGTEMPB_E
	movlw	16
	movwf	NUMBITS,BANKED
	call	FN_FNLSR
	movff	FNLSR,II
	movff	FNLSR_H,II_H
;LocalTmp  = [word]Sum
	movff	SUM,LOCALTMP
	movff	SUM_H,LOCALTMP_H
;LocalTmp  = LocalTmp  + II
	movf	II,W,BANKED
	addwf	LOCALTMP,F,BANKED
	movf	II_H,W,BANKED
	addwfc	LOCALTMP_H,F,BANKED
;LocalTmp  = Not LocalTmp
	comf	LOCALTMP,F,BANKED
	comf	LOCALTMP_H,F,BANKED
;etherBuffer(result) = LocalTmp_h
	lfsr	0,ETHERBUFFER
	movf	RESULT,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	LOCALTMP_H,INDF0
;etherBuffer(result + 1) = [byte]LocalTmp
	lfsr	0,ETHERBUFFER
	movf	RESULT,W,BANKED
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp1,BANKED
	movlw	0
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movlw	1
	addwf	SysTemp1,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	LOCALTMP,INDF0
	return

;********************************************************************************

ENC28J60_GENERAL_CHECKSUM
;dim I_x as word
;dim I_chksum32 as long
;X_odd = (Val2 - Val1 ) Mod 2
	movf	VAL1,W,BANKED
	banksel	VAL2
	subwf	VAL2,W,BANKED
	banksel	SYSTEMP3
	movwf	SysTemp3,BANKED
	banksel	X_ODD
	clrf	X_ODD,BANKED
	banksel	SYSTEMP3
	btfss	SysTemp3,0,BANKED
	bra	ENDIF122
	banksel	X_ODD
	incf	X_ODD,F,BANKED
ENDIF122
;if X_odd = 1 then HSerPrint "$"
;I_chksum32 = 0
	banksel	I_CHKSUM32
	clrf	I_CHKSUM32,BANKED
	clrf	I_CHKSUM32_H,BANKED
	clrf	I_CHKSUM32_U,BANKED
	clrf	I_CHKSUM32_E,BANKED
;For I_x = Val1 To Val2 Step 2
	movlw	2
	subwf	VAL1,W,BANKED
	movwf	I_X,BANKED
	clrf	I_X_H,BANKED
	btfss	STATUS,C,ACCESS
	decf	I_X_H,F,BANKED
	movff	VAL1,SysWORDTempB
	clrf	SysWORDTempB_H,ACCESS
	movff	VAL2,SysWORDTempA
	movff	VAL2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd12
SysForLoop12
	movlw	2
	addwf	I_X,F,BANKED
	movlw	0
	addwfc	I_X_H,F,BANKED
;I_value16 = FnLsl( etherbuffer(i_x), 8 )
	lfsr	0,ETHERBUFFER
	movf	I_X,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	INDF0,SYSLONGTEMPB
	clrf	SYSLONGTEMPB_H,ACCESS
	clrf	SYSLONGTEMPB_U,ACCESS
	clrf	SYSLONGTEMPB_E,ACCESS
	movlw	8
	movwf	NUMBITS,BANKED
	call	FN_FNLSL
	movff	FNLSL,I_VALUE16
	movff	FNLSL_H,I_VALUE16_H
;Hulp3 = I_x + 1
	incf	I_X,W,BANKED
	movwf	HULP3,BANKED
;I_value16 = I_value16 + etherBuffer(hulp3)
	lfsr	0,ETHERBUFFER
	movf	HULP3,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movf	INDF0,W,ACCESS
	addwf	I_VALUE16,F,ACCESS
	movlw	0
	addwfc	I_VALUE16_H,F,ACCESS
;I_chksum32 = I_chksum32 + I_value16
	movf	I_VALUE16,W,ACCESS
	addwf	I_CHKSUM32,F,BANKED
	movf	I_VALUE16_H,W,ACCESS
	addwfc	I_CHKSUM32_H,F,BANKED
	movlw	0
	addwfc	I_CHKSUM32_U,F,BANKED
	movlw	0
	addwfc	I_CHKSUM32_E,F,BANKED
;Next I_x
	movff	I_X,SysWORDTempA
	movff	I_X_H,SysWORDTempA_H
	movff	VAL2,SysWORDTempB
	movff	VAL2_H,SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop12
SysForLoopEnd12
;If I_odd = 1 Then
	decf	I_ODD,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF121
;Val2 = Val2 + 3
	movlw	3
	banksel	VAL2
	addwf	VAL2,F,BANKED
	movlw	0
	addwfc	VAL2_H,F,BANKED
;I_value16 = FnLsl( etherbuffer(val2), 8 )
	lfsr	0,ETHERBUFFER
	movf	VAL2,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	INDF0,SYSLONGTEMPB
	clrf	SYSLONGTEMPB_H,ACCESS
	clrf	SYSLONGTEMPB_U,ACCESS
	clrf	SYSLONGTEMPB_E,ACCESS
	movlw	8
	banksel	NUMBITS
	movwf	NUMBITS,BANKED
	call	FN_FNLSL
	movff	FNLSL,I_VALUE16
	movff	FNLSL_H,I_VALUE16_H
;I_chksum32 = I_chksum32 + I_value16
	movf	I_VALUE16,W,ACCESS
	addwf	I_CHKSUM32,F,BANKED
	movf	I_VALUE16_H,W,ACCESS
	addwfc	I_CHKSUM32_H,F,BANKED
	movlw	0
	addwfc	I_CHKSUM32_U,F,BANKED
	movlw	0
	addwfc	I_CHKSUM32_E,F,BANKED
;End If
ENDIF121
;I_checksum16 = Fnlsr(i_chksum32, 16)
	movff	I_CHKSUM32,SYSLONGTEMPB
	movff	I_CHKSUM32_H,SYSLONGTEMPB_H
	movff	I_CHKSUM32_U,SYSLONGTEMPB_U
	movff	I_CHKSUM32_E,SYSLONGTEMPB_E
	movlw	16
	movwf	NUMBITS,BANKED
	call	FN_FNLSR
	movff	FNLSR,I_CHECKSUM16
	movff	FNLSR_H,I_CHECKSUM16_H
;I_checksum16 = I_checksum16 + I_chksum32 ' only 16 lower bits of i_chksum32 is taken...
	movf	I_CHKSUM32,W,BANKED
	addwf	I_CHECKSUM16,F,BANKED
	movf	I_CHKSUM32_H,W,BANKED
	addwfc	I_CHECKSUM16_H,F,BANKED
;I_checksum16 = Not I_checksum16
	comf	I_CHECKSUM16,F,BANKED
	comf	I_CHECKSUM16_H,F,BANKED
;Val3 = i_checksum16_h
	movff	I_CHECKSUM16_H,VAL3
;Val4 = i_checksum16
	movff	I_CHECKSUM16,VAL4
	return

;********************************************************************************

ENC28J60_HANDLE_SNTP
;dim Epoch_seconds as long
;DIM L2 AS long
;Epoch_seconds = T_udp_data3
	movff	SYSETHERBUFFER_46,EPOCH_SECONDS
	clrf	EPOCH_SECONDS_H,BANKED
	clrf	EPOCH_SECONDS_U,BANKED
	clrf	EPOCH_SECONDS_E,BANKED
;Epoch_seconds_H = T_udp_data2
	movff	SYSETHERBUFFER_45,EPOCH_SECONDS_H
;Epoch_seconds_U = T_udp_data1
	movff	SYSETHERBUFFER_44,EPOCH_SECONDS_U
;Epoch_seconds_E   = T_udp_data0
	movff	SYSETHERBUFFER_43,EPOCH_SECONDS_E
;Epoch_seconds = Epoch_seconds - [Long]3660595200  'ADJUSTS TO 1/1/2016
	movlw	0
	subwf	EPOCH_SECONDS,F,BANKED
	movlw	64
	subwfb	EPOCH_SECONDS_H,F,BANKED
	movlw	48
	subwfb	EPOCH_SECONDS_U,F,BANKED
	movlw	218
	subwfb	EPOCH_SECONDS_E,F,BANKED
;ENC28j60_UTC_Adjust ( Epoch_seconds )
	call	ENC28J60_UTC_ADJUST
;HserPrint "Date "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable34
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable34
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT245
;l2 = ( Epoch_seconds / 86400 ) + 1
	movff	EPOCH_SECONDS,SysLONGTempA
	movff	EPOCH_SECONDS_H,SysLONGTempA_H
	movff	EPOCH_SECONDS_U,SysLONGTempA_U
	movff	EPOCH_SECONDS_E,SysLONGTempA_E
	movlw	128
	movwf	SysLONGTempB,ACCESS
	movlw	81
	movwf	SysLONGTempB_H,ACCESS
	movlw	1
	movwf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	call	SysDivSub32
	movff	SysLONGTempA,SysTemp1
	movff	SysLONGTempA_H,SysTemp1_H
	movff	SysLONGTempA_U,SysTemp1_U
	movff	SysLONGTempA_E,SysTemp1_E
	movlw	1
	addwf	SysTemp1,W,BANKED
	movwf	L2,BANKED
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	L2_H,BANKED
	movlw	0
	addwfc	SysTemp1_U,W,BANKED
	movwf	L2_U,BANKED
	movlw	0
	addwfc	SysTemp1_E,W,BANKED
	movwf	L2_E,BANKED
;HSerPrint l2
	movff	L2,SERPRINTVAL
	movff	L2_H,SERPRINTVAL_H
	movff	L2_U,SERPRINTVAL_U
	movff	L2_E,SERPRINTVAL_E
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT249
;l2 = Epoch_seconds / 31536000  ' CALC year
	movff	EPOCH_SECONDS,SysLONGTempA
	movff	EPOCH_SECONDS_H,SysLONGTempA_H
	movff	EPOCH_SECONDS_U,SysLONGTempA_U
	movff	EPOCH_SECONDS_E,SysLONGTempA_E
	movlw	128
	movwf	SysLONGTempB,ACCESS
	movlw	51
	movwf	SysLONGTempB_H,ACCESS
	movlw	225
	movwf	SysLONGTempB_U,ACCESS
	movlw	1
	movwf	SysLONGTempB_E,ACCESS
	call	SysDivSub32
	movff	SysLONGTempA,L2
	movff	SysLONGTempA_H,L2_H
	movff	SysLONGTempA_U,L2_U
	movff	SysLONGTempA_E,L2_E
;l2 = l2 + 2016
	movlw	224
	addwf	L2,F,BANKED
	movlw	7
	addwfc	L2_H,F,BANKED
	movlw	0
	addwfc	L2_U,F,BANKED
	movlw	0
	addwfc	L2_E,F,BANKED
;HSerPrint "D/"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable35
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable35
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT245
;HSerPrint l2
	movff	L2,SERPRINTVAL
	movff	L2_H,SERPRINTVAL_H
	movff	L2_U,SERPRINTVAL_U
	movff	L2_E,SERPRINTVAL_E
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT249
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;HserPrint "Time "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable36
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable36
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT245
;l2 = Epoch_seconds % 86400
	movff	EPOCH_SECONDS,SysLONGTempA
	movff	EPOCH_SECONDS_H,SysLONGTempA_H
	movff	EPOCH_SECONDS_U,SysLONGTempA_U
	movff	EPOCH_SECONDS_E,SysLONGTempA_E
	movlw	128
	movwf	SysLONGTempB,ACCESS
	movlw	81
	movwf	SysLONGTempB_H,ACCESS
	movlw	1
	movwf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	call	SysDivSub32
	movff	SysLONGTempX,L2
	movff	SysLONGTempX_H,L2_H
	movff	SysLONGTempX_U,L2_U
	movff	SysLONGTempX_E,L2_E
;l2 = l2 / 3600
	movff	L2,SysLONGTempA
	movff	L2_H,SysLONGTempA_H
	movff	L2_U,SysLONGTempA_U
	movff	L2_E,SysLONGTempA_E
	movlw	16
	movwf	SysLONGTempB,ACCESS
	movlw	14
	movwf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	call	SysDivSub32
	movff	SysLONGTempA,L2
	movff	SysLONGTempA_H,L2_H
	movff	SysLONGTempA_U,L2_U
	movff	SysLONGTempA_E,L2_E
;if l2 < 10 then HSerPrint "0"
	movff	L2,SysLONGTempA
	movff	L2_H,SysLONGTempA_H
	movff	L2_U,SysLONGTempA_U
	movff	L2_E,SysLONGTempA_E
	movlw	10
	movwf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	call	SysCompLessThan32
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF82
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable37
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable37
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT245
ENDIF82
;HSerPrint l2
	movff	L2,SERPRINTVAL
	movff	L2_H,SERPRINTVAL_H
	movff	L2_U,SERPRINTVAL_U
	movff	L2_E,SERPRINTVAL_E
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT249
;HSerPrint ":"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable38
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable38
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT245
;l2 = Epoch_seconds % 3600
	movff	EPOCH_SECONDS,SysLONGTempA
	movff	EPOCH_SECONDS_H,SysLONGTempA_H
	movff	EPOCH_SECONDS_U,SysLONGTempA_U
	movff	EPOCH_SECONDS_E,SysLONGTempA_E
	movlw	16
	movwf	SysLONGTempB,ACCESS
	movlw	14
	movwf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	call	SysDivSub32
	movff	SysLONGTempX,L2
	movff	SysLONGTempX_H,L2_H
	movff	SysLONGTempX_U,L2_U
	movff	SysLONGTempX_E,L2_E
;l2 = l2 / 60
	movff	L2,SysLONGTempA
	movff	L2_H,SysLONGTempA_H
	movff	L2_U,SysLONGTempA_U
	movff	L2_E,SysLONGTempA_E
	movlw	60
	movwf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	call	SysDivSub32
	movff	SysLONGTempA,L2
	movff	SysLONGTempA_H,L2_H
	movff	SysLONGTempA_U,L2_U
	movff	SysLONGTempA_E,L2_E
;if l2 < 10 then HSerPrint "0"
	movff	L2,SysLONGTempA
	movff	L2_H,SysLONGTempA_H
	movff	L2_U,SysLONGTempA_U
	movff	L2_E,SysLONGTempA_E
	movlw	10
	movwf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	call	SysCompLessThan32
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF83
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable37
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable37
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT245
ENDIF83
;HSerPrint l2
	movff	L2,SERPRINTVAL
	movff	L2_H,SERPRINTVAL_H
	movff	L2_U,SERPRINTVAL_U
	movff	L2_E,SERPRINTVAL_E
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT249
;l2 = Epoch_seconds % [LONG]60
	movff	EPOCH_SECONDS,SysLONGTempA
	movff	EPOCH_SECONDS_H,SysLONGTempA_H
	movff	EPOCH_SECONDS_U,SysLONGTempA_U
	movff	EPOCH_SECONDS_E,SysLONGTempA_E
	movlw	60
	movwf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	call	SysDivSub32
	movff	SysLONGTempX,L2
	movff	SysLONGTempX_H,L2_H
	movff	SysLONGTempX_U,L2_U
	movff	SysLONGTempX_E,L2_E
;HSerPrint ":"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable38
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable38
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT245
;if l2 < 10 then HSerPrint "0"
	movff	L2,SysLONGTempA
	movff	L2_H,SysLONGTempA_H
	movff	L2_U,SysLONGTempA_U
	movff	L2_E,SysLONGTempA_E
	movlw	10
	movwf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	call	SysCompLessThan32
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF84
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable37
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable37
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT245
ENDIF84
;HSerPrint l2
	movff	L2,SERPRINTVAL
	movff	L2_H,SERPRINTVAL_H
	movff	L2_U,SERPRINTVAL_U
	movff	L2_E,SERPRINTVAL_E
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT249
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	goto	HSERPRINTCRLF

;********************************************************************************

ENC28J60_HTTP
;Dim Tcp_fin As Bit
;Dim Tcp_syn As Bit
;Dim Tcp_rst As Bit
;Dim Tcp_psh As Bit
;Dim Tcp_ack As Bit
;Dim Tcp_urg As Bit
;Dim Tcpdatalen_in As Word
;Dim Tcpdatalen_out As Word
;Dim Expected_ack As Long
;Dim Flags As Byte
;Dim Client_seqnum As Long
;Dim Msg_temp2 As String * 10
;dim Tempword3 As Word
;dim Tempstring1 As String * 1
;Dim Ackpsh As Byte
;Work = Tcp_flags   'in the TCP Buffer, see aliases
	movff	SYSETHERBUFFER_48,WORK
;Tcp_fin = Work.0
	bcf	SYSBITVAR0,0,BANKED
	banksel	WORK
	btfss	WORK,0,BANKED
	bra	ENDIF103
	banksel	SYSBITVAR0
	bsf	SYSBITVAR0,0,BANKED
ENDIF103
;Tcp_syn = Work.1
	banksel	SYSBITVAR0
	bcf	SYSBITVAR0,1,BANKED
	banksel	WORK
	btfss	WORK,1,BANKED
	bra	ENDIF104
	banksel	SYSBITVAR0
	bsf	SYSBITVAR0,1,BANKED
ENDIF104
;Tcp_rst = Work.2
	banksel	SYSBITVAR0
	bcf	SYSBITVAR0,2,BANKED
	banksel	WORK
	btfss	WORK,2,BANKED
	bra	ENDIF105
	banksel	SYSBITVAR0
	bsf	SYSBITVAR0,2,BANKED
ENDIF105
;Tcp_psh = Work.3
	banksel	SYSBITVAR0
	bcf	SYSBITVAR0,3,BANKED
	banksel	WORK
	btfss	WORK,3,BANKED
	bra	ENDIF106
	banksel	SYSBITVAR0
	bsf	SYSBITVAR0,3,BANKED
ENDIF106
;Tcp_ack = Work.4
	banksel	SYSBITVAR0
	bcf	SYSBITVAR0,4,BANKED
	banksel	WORK
	btfss	WORK,4,BANKED
	bra	ENDIF107
	banksel	SYSBITVAR0
	bsf	SYSBITVAR0,4,BANKED
ENDIF107
;Tcp_urg = Work.5
	banksel	SYSBITVAR0
	bcf	SYSBITVAR0,5,BANKED
	banksel	WORK
	btfss	WORK,5,BANKED
	bra	ENDIF108
	banksel	SYSBITVAR0
	bsf	SYSBITVAR0,5,BANKED
ENDIF108
;#define debug0
HTTPPART1
;If Tcp_syn = 1 Then
	banksel	SYSBITVAR0
	btfss	SYSBITVAR0,1,BANKED
	bra	ENDIF100
;ENC28j60_set_response_IPpacket
	call	ENC28J60_SET_RESPONSE_IPPACKET
;T_ip_destaddr0 = T_ip_srcaddr0
;T_ip_destaddr1 = T_ip_srcaddr1
;T_ip_destaddr2 = T_ip_srcaddr2
;T_ip_destaddr3 = T_ip_srcaddr3
;
;'Set source IP in IP header, pos 27
;T_ip_srcaddr0 = ipaddr(1)
;T_ip_srcaddr1 = ipaddr(2)
;T_ip_srcaddr2 = ipaddr(3)
;T_ip_srcaddr3 = ipaddr(4)
;
;ENC28j60_packetshape
;ENC28j60_ip_header_checksum
;Swap Tcp_srcportl , Tcp_destportl
	movff	SYSETHERBUFFER_36,SYSCALCTEMPA
	movff	SYSETHERBUFFER_38,SYSCALCTEMPB
	call	SWAP85
	movff	SYSCALCTEMPA,SYSETHERBUFFER_36
	movff	SYSCALCTEMPB,SYSETHERBUFFER_38
;Swap Tcp_srcporth , Tcp_destporth
	movff	SYSETHERBUFFER_35,SYSCALCTEMPA
	movff	SYSETHERBUFFER_37,SYSCALCTEMPB
	call	SWAP85
	movff	SYSCALCTEMPA,SYSETHERBUFFER_35
	movff	SYSCALCTEMPB,SYSETHERBUFFER_37
;Tcpdatalen_in = 1
	movlw	1
	movwf	TCPDATALEN_IN,BANKED
	clrf	TCPDATALEN_IN_H,BANKED
;[byte]Client_seqnum_E = Tcp_seqnum3
	movff	SYSETHERBUFFER_39,CLIENT_SEQNUM_E
;[byte]Client_seqnum_U = Tcp_seqnum2
	movff	SYSETHERBUFFER_40,CLIENT_SEQNUM_U
;[byte]Client_seqnum_H = Tcp_seqnum1
	movff	SYSETHERBUFFER_41,CLIENT_SEQNUM_H
;[byte]Client_seqnum   = Tcp_seqnum0
	movff	SYSETHERBUFFER_42,CLIENT_SEQNUM
;Client_seqnum = Client_seqnum + Tcpdatalen_in
	movf	TCPDATALEN_IN,W,BANKED
	addwf	CLIENT_SEQNUM,F,BANKED
	movf	TCPDATALEN_IN_H,W,BANKED
	addwfc	CLIENT_SEQNUM_H,F,BANKED
	movlw	0
	addwfc	CLIENT_SEQNUM_U,F,BANKED
	movlw	0
	addwfc	CLIENT_SEQNUM_E,F,BANKED
;Tcp_acknum0 = Client_seqnum
	movff	CLIENT_SEQNUM,SYSETHERBUFFER_46
;Tcp_acknum1 = Client_seqnum_H
	movff	CLIENT_SEQNUM_H,SYSETHERBUFFER_45
;Tcp_acknum2 = Client_seqnum_U
	movff	CLIENT_SEQNUM_U,SYSETHERBUFFER_44
;Tcp_acknum3 = Client_seqnum_E
	movff	CLIENT_SEQNUM_E,SYSETHERBUFFER_43
;Tcp_seqnum0 = 0xFF                                 'Initial sequencenumber
	banksel	SYSETHERBUFFER_42
	setf	SYSETHERBUFFER_42,BANKED
;Tcp_seqnum1 = 0xFF                                 '
	setf	SYSETHERBUFFER_41,BANKED
;Tcp_seqnum2 = 0x10                                 '
	movlw	16
	movwf	SYSETHERBUFFER_40,BANKED
;Tcp_seqnum3 = 0x11                                 '
	movlw	17
	movwf	SYSETHERBUFFER_39,BANKED
;Flags.synflag = 1
	banksel	FLAGS
	bsf	FLAGS,0,BANKED
;Tcp_flags = 0
	banksel	SYSETHERBUFFER_48
	clrf	SYSETHERBUFFER_48,BANKED
;Tcp_flags.1 = 1
	bsf	SYSETHERBUFFER_48,1,BANKED
;Tcp_flags.4 = 1
	bsf	SYSETHERBUFFER_48,4,BANKED
;etherbuffer(49) = 0X02
	movlw	2
	movwf	SYSETHERBUFFER_49,BANKED
;etherbuffer(50) = 0X00
	clrf	SYSETHERBUFFER_50,BANKED
;etherbuffer(60) = 01
	movff	01,SYSETHERBUFFER_60
;etherbuffer(61) = 01
	movff	01,SYSETHERBUFFER_61
;I_value16 = T_ip_vers_len And 0x0F
	movlw	15
	andwf	SYSETHERBUFFER_15,W,BANKED
	movwf	I_VALUE16,ACCESS
	clrf	I_VALUE16_H,ACCESS
;I_value16 = I_value16 * 4
	movff	I_VALUE16,SysWORDTempA
	movff	I_VALUE16_H,SysWORDTempA_H
	movlw	4
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	call	SysMultSub16
	movff	SysWORDTempX,I_VALUE16
	movff	SysWORDTempX_H,I_VALUE16_H
;tt = (( T_ip_pktlen0 * 256 )+ T_ip_pktlen1 ) + 14
	movff	SYSETHERBUFFER_17,SysWORDTempA
	clrf	SysWORDTempA_H,ACCESS
	clrf	SysWORDTempB,ACCESS
	movlw	1
	movwf	SysWORDTempB_H,ACCESS
	call	SysMultSub16
	movff	SysWORDTempX,SysTemp1
	movff	SysWORDTempX_H,SysTemp1_H
	banksel	SYSETHERBUFFER_18
	movf	SYSETHERBUFFER_18,W,BANKED
	banksel	SYSTEMP1
	addwf	SysTemp1,W,BANKED
	movwf	SysTemp3,BANKED
	movlw	14
	addwf	SysTemp3,W,BANKED
	movwf	TT,BANKED
;ENC28j60_Ip_header_checksum
	rcall	ENC28J60_IP_HEADER_CHECKSUM
;ENC28j60_tcp_checksum
	call	ENC28J60_TCP_CHECKSUM
;ENC28j60_writebuffer(tt)
	movff	TT,PCKTLEN
	clrf	PCKTLEN_H,BANKED
	call	ENC28J60_WRITEBUFFER
;ENC28j60_packetsend(tt)
	movff	TT,PCKTLEN
	clrf	PCKTLEN_H,BANKED
	call	ENC28J60_PACKETSEND
;Ackpsh = 0
	clrf	ACKPSH,BANKED
;End If
ENDIF100
HTTPPART2
;' If an ACK and PSH is received and the destination port address is valid
;If Tcp_ack = 1 Then
	btfss	SYSBITVAR0,4,BANKED
	bra	ENDIF101
;If Tcp_psh = 1 Then
	btfss	SYSBITVAR0,3,BANKED
	bra	ENDIF102
;'ACK and PSH
;
;'set flags
;Tcp_flags = 0
	banksel	SYSETHERBUFFER_48
	clrf	SYSETHERBUFFER_48,BANKED
;Tcp_flags.4 = 1                           'ack
	bsf	SYSETHERBUFFER_48,4,BANKED
;
;'           'Move IP source address to destination address
;'           T_ip_destaddr = T_ip_srcaddr
;'           'Make ethernet module IP address source address
;'           T_ip_srcaddr = My_ip
;'           Swap Tcp_srcportl , Tcp_destportl
;'           Swap Tcp_srcporth , Tcp_destporth
;T_ip_destaddr0 = T_ip_srcaddr0
	movff	SYSETHERBUFFER_27,SYSETHERBUFFER_31
;T_ip_destaddr1 = T_ip_srcaddr1
	movff	SYSETHERBUFFER_28,SYSETHERBUFFER_32
;T_ip_destaddr2 = T_ip_srcaddr2
	movff	SYSETHERBUFFER_29,SYSETHERBUFFER_33
;T_ip_destaddr3 = T_ip_srcaddr3
	movff	SYSETHERBUFFER_30,SYSETHERBUFFER_34
;T_ip_srcaddr0 = ipaddr(1)
	movff	SYSIPADDR_1,SYSETHERBUFFER_27
;T_ip_srcaddr1 = ipaddr(2)
	movff	SYSIPADDR_2,SYSETHERBUFFER_28
;T_ip_srcaddr2 = ipaddr(3)
	movff	SYSIPADDR_3,SYSETHERBUFFER_29
;T_ip_srcaddr3 = ipaddr(4)
	movff	SYSIPADDR_4,SYSETHERBUFFER_30
;Swap Tcp_srcportl , Tcp_destportl
	movff	SYSETHERBUFFER_36,SYSCALCTEMPA
	movff	SYSETHERBUFFER_38,SYSCALCTEMPB
	banksel	0
	call	SWAP85
	movff	SYSCALCTEMPA,SYSETHERBUFFER_36
	movff	SYSCALCTEMPB,SYSETHERBUFFER_38
;Swap Tcp_srcporth , Tcp_destporth
	movff	SYSETHERBUFFER_35,SYSCALCTEMPA
	movff	SYSETHERBUFFER_37,SYSCALCTEMPB
	call	SWAP85
	movff	SYSCALCTEMPA,SYSETHERBUFFER_35
	movff	SYSCALCTEMPB,SYSETHERBUFFER_37
;'           'swap mac
;'           Call Packetshape
;ENC28j60_Packetshape
	call	ENC28J60_PACKETSHAPE
;'
;'           Incoming_ack0 = Tcp_seqnum0
;'           Incoming_ack1 = Tcp_seqnum1
;'           Incoming_ack2 = Tcp_seqnum2
;'           Incoming_ack3 = Tcp_seqnum3
;[byte]Incoming_ack_E = Tcp_seqnum3
	movff	SYSETHERBUFFER_39,INCOMING_ACK_E
;[byte]Incoming_ack_U = Tcp_seqnum2
	movff	SYSETHERBUFFER_40,INCOMING_ACK_U
;[byte]Incoming_ack_H = Tcp_seqnum1
	movff	SYSETHERBUFFER_41,INCOMING_ACK_H
;[byte]Incoming_ack   = Tcp_seqnum0
	movff	SYSETHERBUFFER_42,INCOMING_ACK
;HSerPrint hex(Tcp_seqnum3)
;HSerPrint hex(Tcp_seqnum2)
;HSerPrint hex(Tcp_seqnum1)
;HSerPrint hex(Tcp_seqnum0)
;HSerSend 9
;HSerPrint hex(Incoming_ack_E)
;HSerPrint hex(Incoming_ack_U)
;HSerPrint hex(Incoming_ack_H)
;HSerPrint hex(Incoming_ack)
;HSerPrintCRLF
;Incoming_ack = Incoming_ack + ((( T_ip_pktlen0 * 256 )+ T_ip_pktlen1 )) - 40         '489 - 14
	movff	SYSETHERBUFFER_17,SysWORDTempA
	clrf	SysWORDTempA_H,ACCESS
	clrf	SysWORDTempB,ACCESS
	movlw	1
	movwf	SysWORDTempB_H,ACCESS
	call	SysMultSub16
	movff	SysWORDTempX,SysTemp1
	movff	SysWORDTempX_H,SysTemp1_H
	banksel	SYSETHERBUFFER_18
	movf	SYSETHERBUFFER_18,W,BANKED
	banksel	SYSTEMP1
	addwf	SysTemp1,W,BANKED
	movwf	SysTemp3,BANKED
	addwf	INCOMING_ACK,W,BANKED
	movwf	SysTemp1,BANKED
	movlw	0
	addwfc	INCOMING_ACK_H,W,BANKED
	movwf	SysTemp1_H,BANKED
	movlw	0
	addwfc	INCOMING_ACK_U,W,BANKED
	movwf	SysTemp1_U,BANKED
	movlw	0
	addwfc	INCOMING_ACK_E,W,BANKED
	movwf	SysTemp1_E,BANKED
	movlw	40
	subwf	SysTemp1,W,BANKED
	movwf	INCOMING_ACK,BANKED
	movlw	0
	subwfb	SysTemp1_H,W,BANKED
	movwf	INCOMING_ACK_H,BANKED
	movlw	0
	subwfb	SysTemp1_U,W,BANKED
	movwf	INCOMING_ACK_U,BANKED
	movlw	0
	subwfb	SysTemp1_E,W,BANKED
	movwf	INCOMING_ACK_E,BANKED
;HSerPrint hex(Incoming_ack_E)
;HSerPrint hex(Incoming_ack_U)
;HSerPrint hex(Incoming_ack_H)
;HSerPrint hex(Incoming_ack)
;HSerSend 9
;Tcp_seqnum0 = Tcp_acknum0
	movff	SYSETHERBUFFER_46,SYSETHERBUFFER_42
;Tcp_seqnum1 = Tcp_acknum1
	movff	SYSETHERBUFFER_45,SYSETHERBUFFER_41
;Tcp_seqnum2 = Tcp_acknum2
	movff	SYSETHERBUFFER_44,SYSETHERBUFFER_40
;Tcp_seqnum3 = Tcp_acknum3
	movff	SYSETHERBUFFER_43,SYSETHERBUFFER_39
;
;Tcp_acknum0 = Incoming_ack
	movff	INCOMING_ACK,SYSETHERBUFFER_46
;Tcp_acknum1 = Incoming_ack_H
	movff	INCOMING_ACK_H,SYSETHERBUFFER_45
;Tcp_acknum2 = Incoming_ack_U
	movff	INCOMING_ACK_U,SYSETHERBUFFER_44
;Tcp_acknum3 = Incoming_ack_E
	movff	INCOMING_ACK_E,SYSETHERBUFFER_43
;HSerPrint hex(Tcp_seqnum3)
;HSerPrint hex(Tcp_seqnum2)
;HSerPrint hex(Tcp_seqnum1)
;HSerPrint hex(Tcp_seqnum0)
;HSerPrintCRLF
;etherBuffer(17) = 0
	banksel	SYSETHERBUFFER_17
	clrf	SYSETHERBUFFER_17,BANKED
;etherBuffer(18) = 40
	movlw	40
	movwf	SYSETHERBUFFER_18,BANKED
;
;'5 x 4 = 20 bytes
;etherBuffer(47) = 0x50
	movlw	80
	movwf	SYSETHERBUFFER_47,BANKED
;'flag ACK
;etherBuffer(48) = 0x10
	movlw	16
	movwf	SYSETHERBUFFER_48,BANKED
;
;etherBuffer(49) = 0x00
	clrf	SYSETHERBUFFER_49,BANKED
;etherBuffer(50) = 0x72
	movlw	114
	movwf	SYSETHERBUFFER_50,BANKED
;'padding
;etherBuffer(55) = 0x00
	clrf	SYSETHERBUFFER_55,BANKED
;etherBuffer(56) = 0x00
	clrf	SYSETHERBUFFER_56,BANKED
;etherBuffer(57) = 0x00
	clrf	SYSETHERBUFFER_57,BANKED
;etherBuffer(58) = 0x00
	clrf	SYSETHERBUFFER_58,BANKED
;etherBuffer(59) = 0x00
	clrf	SYSETHERBUFFER_59,BANKED
;etherBuffer(60) = 0x00
	clrf	SYSETHERBUFFER_60,BANKED
;etherBuffer(55) = 0x01
;etherBuffer(56) = 0x01
;etherBuffer(57) = 0x08
;etherBuffer(58) = 0x0a
;etherBuffer(59) = 0x12
;etherBuffer(60) = 0xcc
;etherBuffer(61) = 0x00
;'           etherBuffer(62) = 0x7d
;etherBuffer(63) = 0x00
;etherBuffer(64) = 0x0d
;etherBuffer(65) = 0x2b
;etherBuffer(66) = 0xe0
;
;
;Call Ip_header_checksum
;Call Tcp_checksum
;Call ENC28j60packetsend(60)
;ENC28j60_ip_header_checksum
	banksel	0
	rcall	ENC28J60_IP_HEADER_CHECKSUM
;ENC28j60_tcp_checksum
	call	ENC28J60_TCP_CHECKSUM
;tt = (( T_ip_pktlen0 * 256 )+ T_ip_pktlen1 ) + 14
	movff	SYSETHERBUFFER_17,SysWORDTempA
	clrf	SysWORDTempA_H,ACCESS
	clrf	SysWORDTempB,ACCESS
	movlw	1
	movwf	SysWORDTempB_H,ACCESS
	call	SysMultSub16
	movff	SysWORDTempX,SysTemp1
	movff	SysWORDTempX_H,SysTemp1_H
	banksel	SYSETHERBUFFER_18
	movf	SYSETHERBUFFER_18,W,BANKED
	banksel	SYSTEMP1
	addwf	SysTemp1,W,BANKED
	movwf	SysTemp3,BANKED
	movlw	14
	addwf	SysTemp3,W,BANKED
	movwf	TT,BANKED
;T_ip_pktlen1 = 40
	movlw	40
	banksel	SYSETHERBUFFER_18
	movwf	SYSETHERBUFFER_18,BANKED
;ENC28j60_writebuffer(60)
	movlw	60
	banksel	PCKTLEN
	movwf	PCKTLEN,BANKED
	clrf	PCKTLEN_H,BANKED
	call	ENC28J60_WRITEBUFFER
;ENC28j60_packetsend(60)
	movlw	60
	movwf	PCKTLEN,BANKED
	clrf	PCKTLEN_H,BANKED
	rcall	ENC28J60_PACKETSEND
;Ackpsh = 1
	movlw	1
	movwf	ACKPSH,BANKED
;End If
ENDIF102
;End If
ENDIF101
;
;HTTPPart3
	goto	HTTPPART3

;********************************************************************************

ENC28J60_INIT
;Dir ENC28j60_DI in
	bsf	TRISC,4,ACCESS
;Dir ENC28j60_DO Out
	bcf	TRISC,5,ACCESS
;Dir ENC28j60_SCK Out
	bcf	TRISC,3,ACCESS
;Dir ENC28j60_CS out
	bcf	TRISA,5,ACCESS
;Dir ENC28j60_RESET out
	bcf	TRISD,2,ACCESS
;set ENC28j60_DO off
	bcf	LATC,5,ACCESS
;set ENC28j60_SCK off
	bcf	LATC,3,ACCESS
;set ENC28j60_CS off
	bcf	LATA,5,ACCESS
;ENC28j60_Deselect
	bsf	LATA,5,ACCESS
;Repeat 5
	movlw	5
	movwf	SysRepeatTemp1,BANKED
SysRepeatLoop1
;ENC28j60_Reset_CMD
	bsf	LATD,2,ACCESS
	movlw	20
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
	bcf	LATD,2,ACCESS
	movlw	20
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
	bsf	LATD,2,ACCESS
	movlw	20
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;End Repeat
	decfsz	SysRepeatTemp1,F,BANKED
	bra	SysRepeatLoop1
SysRepeatLoopEnd1
;ENC28j60_Select
	bcf	LATA,5,ACCESS
;SPIMode MasterSlow, 0
	movlw	11
	movwf	SPICURRENTMODE,BANKED
	clrf	SPICLOCKMODE,BANKED
	call	SPIMODE201
;FastHWSPITransfer( ENC28j60_SOFT_RESET, temp )
	setf	SPITXDATA,BANKED
	call	FASTHWSPITRANSFER
;lastselectedBank = 99
	movlw	99
	movwf	LASTSELECTEDBANK,BANKED
;wait while ( (ENC28j60_ReadReg( ESTAT ) & ESTAT_CLKRDY ) <> ESTAT_CLKRDY)
SysWaitLoop1
	movlw	29
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movlw	1
	andwf	ENC28J60_READREG,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SysBYTETempA
	movlw	1
	movwf	SysBYTETempB,ACCESS
	call	SysCompEqual
	comf	SysByteTempX,F,ACCESS
	btfsc	SysByteTempX,0,ACCESS
	bra	SysWaitLoop1
;ENC28j60_writeReg(ECON1, 0xC0) 'Hold it in Reset
	movlw	31
	movwf	ADDR,BANKED
	movlw	192
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ECON2, 0x80) 'Set the AUTOINC bit
	movlw	30
	movwf	ADDR,BANKED
	movlw	128
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(EIR, 0x00) 'Reset interrupt flags
	movlw	28
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(EIE,  0xC1)  'Interrupts: Packet reception and buffer errors
	movlw	27
	movwf	ADDR,BANKED
	movlw	193
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(EWOLIE, 0x00)  'Disable wake-on-lan interrupts
	movlw	54
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(EWOLIR, 0x00)  'Clear wake-on-lan interrupt flags
	movlw	55
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ETXSTL, ENC_TXBUF_STL)
	movlw	4
	movwf	ADDR,BANKED
	movlw	112
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ETXSTH, ENC_TXBUF_STH)
	movlw	5
	movwf	ADDR,BANKED
	movlw	22
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ETXNDL, ENC_TXBUF_NDL)
	movlw	6
	movwf	ADDR,BANKED
	setf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ETXNDH, ENC_TXBUF_NDH)  'TX Buffer : 1800 bytes
	movlw	7
	movwf	ADDR,BANKED
	movlw	31
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ERXSTL, ENC_RXBUF_STL)
	movlw	8
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ERXSTH, ENC_RXBUF_STH)
	movlw	9
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ERXNDL, ENC_RXBUF_NDL)
	movlw	10
	movwf	ADDR,BANKED
	movlw	110
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ERXNDH, ENC_RXBUF_NDH)  'RX Buffer : 6390 bytes
	movlw	11
	movwf	ADDR,BANKED
	movlw	22
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ERDPTL, ENC_RXBUF_STL)
	clrf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ERDPTH, ENC_RXBUF_STH)
	movlw	1
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ERXRDPTL, ENC_RXBUF_STL)
	movlw	12
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ERXRDPTH, ENC_RXBUF_STH) 'RX Pointers (same)
	movlw	13
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;nextpacketptr = ENC_RXBUF_ST
	clrf	NEXTPACKETPTR,BANKED
	clrf	NEXTPACKETPTR_H,BANKED
;ENC28j60_writeReg(ERXFCON, 0xA1) 'Receive unicasts or broadcasts
	movlw	56
	movwf	ADDR,BANKED
	movlw	161
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(EFLOCON, 0x00) 'Disable flow control sending
	movlw	119
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ECOCON, 0x00) 'Disable Clock Out pin
	movlw	117
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(EBSTCON, 0x00) 'Disable built-in self test controller
	movlw	103
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;wait while ( (ENC28j60_ReadReg(ESTAT) & ESTAT_CLKRDY) <> ESTAT_CLKRDY)
SysWaitLoop2
	movlw	29
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movlw	1
	andwf	ENC28J60_READREG,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SysBYTETempA
	movlw	1
	movwf	SysBYTETempB,ACCESS
	call	SysCompEqual
	comf	SysByteTempX,F,ACCESS
	btfsc	SysByteTempX,0,ACCESS
	bra	SysWaitLoop2
;ENC28j60_writeReg(MISTAT, 0x00)  'Clear MII status register
	movlw	234
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(MICMD, 0x00)   'Clear MII command register
	movlw	210
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(MICON1, 0x02)  'Fast MII operation
;ENC28j60_writeReg(MICON2, 0x00)  'Release MII interface from reset
;ENC28j60_writeReg(MACON1, b'00001101' )  'Enable packet reception
	movlw	192
	movwf	ADDR,BANKED
	movlw	13
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(MACON2, 0x00)  'Release the MAC subsystem from reset
;ENC28j60_writeReg(MACON3, 0xB1)  'Auto Pad + CRC + Full Duplex
;ENC28j60_writeReg(MACON3, 0x32)  'Auto Pad to 60 bytes + CRC + Half Duplex + Check frame length
	movlw	194
	movwf	ADDR,BANKED
	movlw	50
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(MACON4, 0x01)  'Need valid preamble
	movlw	195
	movwf	ADDR,BANKED
	movlw	1
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(MAPHSUP, b'00010000') 'Release MAC-PHY support from Reset
;ENC28j60_writeReg(MAMXFLL, 0xEE)
	movlw	202
	movwf	ADDR,BANKED
	movlw	238
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(MAMXFLH, 0x05)  'Maximum frame length
	movlw	203
	movwf	ADDR,BANKED
	movlw	5
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(MABBIPG, 0x12) 'IEEE BTB Inter Packet Gap
	movlw	196
	movwf	ADDR,BANKED
	movlw	18
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(MAIPGL, 0x12)
	movlw	198
	movwf	ADDR,BANKED
	movlw	18
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(MAIPGH, 0x0C)  'IEEE Non BTB Inter Packet Gap
	movlw	199
	movwf	ADDR,BANKED
	movlw	12
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(MAADR0, macaddr(2))
	movlw	225
	movwf	ADDR,BANKED
	movlw	2
	addwf	SysMACADDRHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysMACADDRHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(MAADR1, macaddr(1))
	movlw	224
	movwf	ADDR,BANKED
	movlw	1
	addwf	SysMACADDRHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysMACADDRHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(MAADR2, macaddr(4))
	movlw	227
	movwf	ADDR,BANKED
	movlw	4
	addwf	SysMACADDRHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysMACADDRHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(MAADR3, macaddr(3))
	movlw	226
	movwf	ADDR,BANKED
	movlw	3
	addwf	SysMACADDRHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysMACADDRHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(MAADR4, macaddr(6))
	movlw	229
	movwf	ADDR,BANKED
	movlw	6
	addwf	SysMACADDRHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysMACADDRHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(MAADR5, macaddr(5))
	movlw	228
	movwf	ADDR,BANKED
	movlw	5
	addwf	SysMACADDRHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysMACADDRHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;'Initialize PHY subsystem
;ENC28j60_writePhyReg(PHCON1, 0x00, 0x00)  'Half duplex
	clrf	PHYREGADDR,BANKED
	clrf	ENC_OUTBYTE1,BANKED
	clrf	ENC_OUTBYTE2,BANKED
	call	ENC28J60_WRITEPHYREG
;ENC28j60_writePhyReg(PHCON2, 0x00, 0x00)
	movlw	16
	movwf	PHYREGADDR,BANKED
	clrf	ENC_OUTBYTE1,BANKED
	clrf	ENC_OUTBYTE2,BANKED
	call	ENC28J60_WRITEPHYREG
;ENC28j60_writePhyReg(PHLCON, B'00000100', B'01110110')
	movlw	20
	movwf	PHYREGADDR,BANKED
	movlw	4
	movwf	ENC_OUTBYTE1,BANKED
	movlw	118
	movwf	ENC_OUTBYTE2,BANKED
	call	ENC28J60_WRITEPHYREG
;ENC28j60_writePhyReg(PHIE, 0x00, 0x00)  'Disable interrupts
	movlw	18
	movwf	PHYREGADDR,BANKED
	clrf	ENC_OUTBYTE1,BANKED
	clrf	ENC_OUTBYTE2,BANKED
	call	ENC28J60_WRITEPHYREG
;ENC28j60_writeReg(ECON1, B'00010100')
	movlw	31
	movwf	ADDR,BANKED
	movlw	20
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ECON1, B'00000100')
;ENC28j60_writePhyReg ( PHLCON, 0xA2, 0x0A )
;wait 5 s
;ENC28j60_writePhyReg ( PHLCON, 0x76, 0x04 )
	movlw	20
	movwf	PHYREGADDR,BANKED
	movlw	118
	movwf	ENC_OUTBYTE1,BANKED
	movlw	4
	movwf	ENC_OUTBYTE2,BANKED
	goto	ENC28J60_WRITEPHYREG

;********************************************************************************

ENC28J60_INITIALISE
;macaddr =   0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	lfsr	0,MACADDR
	movlw	6
	movwf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
;ipaddr =    0,0,0,0
	lfsr	0,IPADDR
	movlw	4
	movwf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
;ipserver =  0,0,0,0
	lfsr	0,IPSERVER
	movlw	4
	movwf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
	clrf	POSTINC0,ACCESS
;ipport = 80   'set a default value
	movlw	80
	movwf	IPPORT,BANKED
;packetCounterOut = 0
	clrf	PACKETCOUNTEROUT,BANKED
	clrf	PACKETCOUNTEROUT_H,BANKED
	clrf	PACKETCOUNTEROUT_U,BANKED
	clrf	PACKETCOUNTEROUT_E,BANKED
;packetCounterIn = 0
	clrf	PACKETCOUNTERIN,BANKED
	clrf	PACKETCOUNTERIN_H,BANKED
	clrf	PACKETCOUNTERIN_U,BANKED
	clrf	PACKETCOUNTERIN_E,BANKED
;Ip_id = 0
	clrf	IP_ID,BANKED
	clrf	IP_ID_H,BANKED
	return

;********************************************************************************

ENC28J60_IP_HEADER_CHECKSUM
;Dim Ip_x As Byte
;Dim Ip_hulp1 As Byte
;Dim Ip_chksum32 As Long
;Dim Ip_checksum16 As Word
;Dim Ip_temp16 As Word
;Dim Ip_header_length As Byte
;Dim Val2 as word
;I_chksum32 = 0
	clrf	I_CHKSUM32,BANKED
;Ip_header_length = T_ip_vers_len And 0x0F
	movlw	15
	banksel	SYSETHERBUFFER_15
	andwf	SYSETHERBUFFER_15,W,BANKED
	banksel	IP_HEADER_LENGTH
	movwf	IP_HEADER_LENGTH,BANKED
;Ip_header_length = 4 * Ip_header_length
;repeat 2
	movlw	2
	movwf	SysRepeatTemp9,BANKED
SysRepeatLoop9
;set C off
	bcf	STATUS,C,ACCESS
;rotate Ip_header_length left
	rlcf	IP_HEADER_LENGTH,F,BANKED
;end repeat
	decfsz	SysRepeatTemp9,F,BANKED
	bra	SysRepeatLoop9
SysRepeatLoopEnd9
;I_chksum32 = 0
	clrf	I_CHKSUM32,BANKED
;I_odd = 0
	clrf	I_ODD,BANKED
;Val1 = 15
	movlw	15
	movwf	VAL1,BANKED
;Val2 = 0x0E + Ip_header_length - 1
	movlw	14
	addwf	IP_HEADER_LENGTH,W,BANKED
	movwf	SysTemp1,BANKED
	clrf	SysTemp1_H,BANKED
	btfsc	STATUS,C,ACCESS
	incf	SysTemp1_H,F,BANKED
	movlw	1
	subwf	SysTemp1,W,BANKED
	banksel	VAL2
	movwf	VAL2,BANKED
	movlw	0
	banksel	SYSTEMP1_H
	subwfb	SysTemp1_H,W,BANKED
	banksel	VAL2_H
	movwf	VAL2_H,BANKED
;T_ip_hdr_cksum0 = 0
	banksel	SYSETHERBUFFER_25
	clrf	SYSETHERBUFFER_25,BANKED
;T_ip_hdr_cksum1 = 0
	clrf	SYSETHERBUFFER_26,BANKED
;ENC28j60_General_checksum(val1 , Val2)
	banksel	0
	call	ENC28J60_GENERAL_CHECKSUM
;T_ip_hdr_cksum0 = Val3
	movff	VAL3,SYSETHERBUFFER_25
;T_ip_hdr_cksum1 = Val4
	movff	VAL4,SYSETHERBUFFER_26
	return

;********************************************************************************

ENC28J60_PACKETRECEIVE
;Dim eth_counter, eth_frameLength As Word
;Dim previous_nextpacketptr as word
;ENC28j60_temp = ENC28j60_ReadReg (eir) and EIR_PKTIF
	movlw	28
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movlw	64
	andwf	ENC28J60_READREG,W,BANKED
	movwf	ENC28J60_TEMP,BANKED
;If ENC28j60_temp <> EIR_PKTIF Then
	movlw	64
	subwf	ENC28J60_TEMP,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF50
;#ifdef ENC28j60_Hserial_Supported
;todo erv
;HSerPrint "No packet"
;reset
	reset
;#endif
;ENC28j60_bitSet( ECON2, ECON2_PKTDEC )
;goto Reset_ENC26j60
	goto	RESET_ENC26J60
;Exit Sub
	return
;End If
ENDIF50
;packetCounterIn++
	incf	PACKETCOUNTERIN,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	PACKETCOUNTERIN_H,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	PACKETCOUNTERIN_U,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	PACKETCOUNTERIN_E,F,BANKED
;ENC28j60_data = ENC28j60_ReadReg( erevid )
	movlw	114
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;eth_counter = 1
	movlw	1
	movwf	ETH_COUNTER,BANKED
	clrf	ETH_COUNTER_H,BANKED
;do
SysDoLoop_S4
;HSerPrint "2"
;ENC28j60_writeReg(ERDPTL, [byte]nextpacketptr )
	clrf	ADDR,BANKED
	movff	NEXTPACKETPTR,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ERDPTH, nextpacketptr_h )
	movlw	1
	movwf	ADDR,BANKED
	movff	NEXTPACKETPTR_H,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;eth_counter++
	incf	ETH_COUNTER,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	ETH_COUNTER_H,F,BANKED
;if eth_counter = 0 then
	movff	ETH_COUNTER,SysWORDTempA
	movff	ETH_COUNTER_H,SysWORDTempA_H
	clrf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompEqual16
	btfsc	SysByteTempX,0,ACCESS
;HSerPrint "#1ERDPTL and ERDPTH error"
;HSerPrintCRLF
;exit do
	bra	SysDoLoop_E4
;end if
;loop while (ENC28j60_ReadReg(ERDPTL) <>  [byte]nextpacketptr) or (ENC28j60_ReadReg(ERDPTH) <> nextpacketptr_h )
	clrf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,SysFnBYTE1
	movlw	1
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	sysfnbyte1,SysBYTETempA
	movff	NEXTPACKETPTR,SysBYTETempB
	call	SysCompEqual
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp2
	movff	enc28j60_readreg,SysBYTETempA
	movff	nextpacketptr_h,SysBYTETempB
	call	SysCompEqual
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movf	SysTemp2,W,BANKED
	iorwf	SysTemp1,W,BANKED
	movwf	SysTemp3,BANKED
	btfsc	SysTemp3,0,BANKED
	bra	SysDoLoop_S4
SysDoLoop_E4
;HSerPrint "4"
;ENC28j60_readbuffer(6)
	movlw	6
	movwf	ETHERGETLENGTH,BANKED
	clrf	ETHERGETLENGTH_H,BANKED
	rcall	ENC28J60_READBUFFER
;HSerPrint "5"
;nextpacketptr = etherbuffer(1)
	movff	SYSETHERBUFFER_1,NEXTPACKETPTR
	clrf	NEXTPACKETPTR_H,BANKED
;nextpacketptr_h = etherbuffer(2)
	movff	SYSETHERBUFFER_2,NEXTPACKETPTR_H
;eth_frameLength = etherbuffer(3)
	movff	SYSETHERBUFFER_3,ETH_FRAMELENGTH
	clrf	ETH_FRAMELENGTH_H,BANKED
;eth_frameLength_h = etherbuffer(4)
	movff	SYSETHERBUFFER_4,ETH_FRAMELENGTH_H
;RxStat = etherbuffer(5)
	movff	SYSETHERBUFFER_5,RXSTAT
;RxStat_h = etherbuffer(6)
	movff	SYSETHERBUFFER_6,RXSTAT_H
;if ( etherbuffer(5) AND 0x80 ) = 0x80 then
;ENC28j60_readbuffer(eth_frameLength)
	movff	ETH_FRAMELENGTH,ETHERGETLENGTH
	movff	ETH_FRAMELENGTH_H,ETHERGETLENGTH_H
	rcall	ENC28J60_READBUFFER
;end if
;HSerPrint "6"
ENDPACKET
;eth_counter = 1
	movlw	1
	movwf	ETH_COUNTER,BANKED
	clrf	ETH_COUNTER_H,BANKED
;do
SysDoLoop_S5
;ENC28j60_writeReg(ERDPTL, [byte]nextpacketptr )
	clrf	ADDR,BANKED
	movff	NEXTPACKETPTR,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ERDPTH, nextpacketptr_h )
	movlw	1
	movwf	ADDR,BANKED
	movff	NEXTPACKETPTR_H,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;eth_counter++
	incf	ETH_COUNTER,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	ETH_COUNTER_H,F,BANKED
;if eth_counter = 0 then
	movff	ETH_COUNTER,SysWORDTempA
	movff	ETH_COUNTER_H,SysWORDTempA_H
	clrf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF52
;HSerPrint "#2ERDPTL and ERDPTH error"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable30
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable30
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT245
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;exit do
	bra	SysDoLoop_E5
;end if
ENDIF52
;loop while (ENC28j60_ReadReg(ERDPTL) <>  [byte]nextpacketptr) or (ENC28j60_ReadReg(ERDPTH) <> nextpacketptr_h )
	clrf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,SysFnBYTE1
	movlw	1
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	sysfnbyte1,SysBYTETempA
	movff	NEXTPACKETPTR,SysBYTETempB
	call	SysCompEqual
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp2
	movff	enc28j60_readreg,SysBYTETempA
	movff	nextpacketptr_h,SysBYTETempB
	call	SysCompEqual
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	movf	SysTemp2,W,BANKED
	iorwf	SysTemp1,W,BANKED
	movwf	SysTemp3,BANKED
	btfsc	SysTemp3,0,BANKED
	bra	SysDoLoop_S5
SysDoLoop_E5
;'Packet is finished
;HSerPrint eth_counter
;HSerPrintCRLF
;IF ( nextpacketptr and 1 ) = 0 THEN
	movlw	1
	andwf	NEXTPACKETPTR,W,BANKED
	movwf	SysTemp3,BANKED
	movff	SysTemp3,SysBYTETempA
	clrf	SysBYTETempB,ACCESS
	call	SysCompEqual
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF53
;eth_counter = nextpacketptr -1
	movlw	1
	subwf	NEXTPACKETPTR,W,BANKED
	movwf	ETH_COUNTER,BANKED
	movlw	0
	subwfb	NEXTPACKETPTR_H,W,BANKED
	movwf	ETH_COUNTER_H,BANKED
;END IF
ENDIF53
;ENC28j60_writeReg(ERXRDPTL, [byte]eth_counter )
	movlw	12
	movwf	ADDR,BANKED
	movff	ETH_COUNTER,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ERXRDPTH, [byte]eth_counter_h )
	movlw	13
	movwf	ADDR,BANKED
	movff	ETH_COUNTER_H,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28j60_bitSet( ECON2, ECON2_PKTDEC )
	movlw	30
	movwf	ADDR,BANKED
	movlw	64
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_BITSET
;If etherBuffer(13) = 0X08 Then
	movlw	8
	banksel	SYSETHERBUFFER_13
	subwf	SYSETHERBUFFER_13,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF54
;If etherBuffer(14) = 0X06 Then                             'Type:ARP
	movlw	6
	subwf	SYSETHERBUFFER_14,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF55
;If etherBuffer(21) = 0X00 Then                          'ARP request
	movf	SYSETHERBUFFER_21,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF57
;If etherBuffer(22) = 0X01 Then                       'ARP request
	decf	SYSETHERBUFFER_22,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF59
;If etherBuffer(39) = ipaddr(1) Then                  'ARP for us
	banksel	SYSIPADDR_1
	movf	SYSIPADDR_1,W,BANKED
	banksel	SYSETHERBUFFER_39
	subwf	SYSETHERBUFFER_39,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF61
;If etherBuffer(40) = ipaddr(2) Then
	banksel	SYSIPADDR_2
	movf	SYSIPADDR_2,W,BANKED
	banksel	SYSETHERBUFFER_40
	subwf	SYSETHERBUFFER_40,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF63
;If etherBuffer(41) = ipaddr(3) Then
	banksel	SYSIPADDR_3
	movf	SYSIPADDR_3,W,BANKED
	banksel	SYSETHERBUFFER_41
	subwf	SYSETHERBUFFER_41,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF65
;If etherBuffer(42) = ipaddr(4) Then
	banksel	SYSIPADDR_4
	movf	SYSIPADDR_4,W,BANKED
	banksel	SYSETHERBUFFER_42
	subwf	SYSETHERBUFFER_42,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF67
;ENC28j60_Arpreply
	banksel	0
	call	ENC28J60_ARPREPLY
;End If
ENDIF67
;End If
ENDIF65
;End If
ENDIF63
;End If
ENDIF61
;End If
ENDIF59
;End If
ENDIF57
;End If
ENDIF55
;If etherBuffer(14) = 0X00 Then                             'Type:IP
	banksel	SYSETHERBUFFER_14
	movf	SYSETHERBUFFER_14,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF56
;If etherBuffer(15) = 0X45 Then                          'We handle only simple IP packets
	movlw	69
	subwf	SYSETHERBUFFER_15,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF58
;If etherBuffer(21) = 0 or etherBuffer(21) = 0x40 Then                          'We handle only non fragmented packets
	movff	SYSETHERBUFFER_21,SysBYTETempA
	clrf	SysBYTETempB,ACCESS
	banksel	0
	call	SysCompEqual
	movff	SysByteTempX,SysTemp2
	movff	SYSETHERBUFFER_21,SysBYTETempA
	movlw	64
	movwf	SysBYTETempB,ACCESS
	call	SysCompEqual
	movf	SysTemp2,W,BANKED
	iorwf	SysByteTempX,W,ACCESS
	movwf	SysTemp3,BANKED
	btfss	SysTemp3,0,BANKED
	bra	ENDIF60
;If etherBuffer(31) = ipaddr(1) Then                  'Ip packet for us
	banksel	SYSIPADDR_1
	movf	SYSIPADDR_1,W,BANKED
	banksel	SYSETHERBUFFER_31
	subwf	SYSETHERBUFFER_31,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF62
;If etherBuffer(32) = ipaddr(2) Then
	banksel	SYSIPADDR_2
	movf	SYSIPADDR_2,W,BANKED
	banksel	SYSETHERBUFFER_32
	subwf	SYSETHERBUFFER_32,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF64
;If etherBuffer(33) = ipaddr(3) Then
	banksel	SYSIPADDR_3
	movf	SYSIPADDR_3,W,BANKED
	banksel	SYSETHERBUFFER_33
	subwf	SYSETHERBUFFER_33,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF66
;If etherBuffer(34) = ipaddr(4) Then
	banksel	SYSIPADDR_4
	movf	SYSIPADDR_4,W,BANKED
	banksel	SYSETHERBUFFER_34
	subwf	SYSETHERBUFFER_34,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF68
;If etherBuffer(24) = 1 Then              'Protocol:ICMP
	decf	SYSETHERBUFFER_24,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF69
;If etherBuffer(35) = 0X08 Then        'ICMP echo request
	movlw	8
	subwf	SYSETHERBUFFER_35,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF72
;PORTC.2 = 1
	bsf	LATC,2,ACCESS
;ENC28j60_Pingreply
	banksel	0
	rcall	ENC28J60_PINGREPLY
;PORTC.2 = 0
	bcf	LATC,2,ACCESS
;End If
ENDIF72
;End If
ENDIF69
;If etherBuffer(24) = 17 Then             'Protocol:UDP
	movlw	17
	banksel	SYSETHERBUFFER_24
	subwf	SYSETHERBUFFER_24,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF70
;T_udp_destport = ( T_udp_destport0 * 256 ) + T_udp_destport1
	movff	SYSETHERBUFFER_37,SysWORDTempA
	clrf	SysWORDTempA_H,ACCESS
	clrf	SysWORDTempB,ACCESS
	movlw	1
	movwf	SysWORDTempB_H,ACCESS
	banksel	0
	call	SysMultSub16
	movff	SysWORDTempX,SysTemp1
	movff	SysWORDTempX_H,SysTemp1_H
	banksel	SYSETHERBUFFER_38
	movf	SYSETHERBUFFER_38,W,BANKED
	banksel	SYSTEMP1
	addwf	SysTemp1,W,BANKED
	movwf	T_UDP_DESTPORT,BANKED
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	T_UDP_DESTPORT_H,BANKED
;ENC28j60_Handle_Udp
	call	MY_UDP_HANDLER
;select case T_udp_srcport1
;case 0x25
SysSelect3Case1
	movlw	37
	banksel	SYSETHERBUFFER_36
	subwf	SYSETHERBUFFER_36,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case2
;ENC28j60_handle_sntp
	banksel	0
	call	ENC28J60_HANDLE_SNTP
;Exit Sub
	return
;end select
SysSelect3Case2
SysSelectEnd3
;if T_udp_destport = 7 then
	movff	T_UDP_DESTPORT,SysWORDTempA
	movff	T_UDP_DESTPORT_H,SysWORDTempA_H
	movlw	7
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	call	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF73
;ENC28j60_Setipaddrs
	rcall	ENC28J60_SETIPADDRS
;Swap T_udp_srcport0 , T_udp_destport0
	movff	SYSETHERBUFFER_35,SYSCALCTEMPA
	movff	SYSETHERBUFFER_37,SYSCALCTEMPB
	call	SWAP85
	movff	SYSCALCTEMPA,SYSETHERBUFFER_35
	movff	SYSCALCTEMPB,SYSETHERBUFFER_37
;Swap T_udp_srcport1 , T_udp_destport1
	movff	SYSETHERBUFFER_36,SYSCALCTEMPA
	movff	SYSETHERBUFFER_38,SYSCALCTEMPB
	call	SWAP85
	movff	SYSCALCTEMPA,SYSETHERBUFFER_36
	movff	SYSCALCTEMPB,SYSETHERBUFFER_38
;ENC28j60_Udp_checksum
	call	ENC28J60_UDP_CHECKSUM
;Hulp2 = T_udp_len0 * 256
	movff	SYSETHERBUFFER_39,SysWORDTempA
	clrf	SysWORDTempA_H,ACCESS
	clrf	SysWORDTempB,ACCESS
	movlw	1
	movwf	SysWORDTempB_H,ACCESS
	call	SysMultSub16
	movff	SysWORDTempX,HULP2
	movff	SysWORDTempX_H,HULP2_H
;Hulp2 = Hulp2 + T_udp_len1
	banksel	SYSETHERBUFFER_40
	movf	SYSETHERBUFFER_40,W,BANKED
	banksel	HULP2
	addwf	HULP2,F,BANKED
	movlw	0
	addwfc	HULP2_H,F,BANKED
;Hulp2 = Hulp2 + 34
	movlw	34
	addwf	HULP2,F,BANKED
	movlw	0
	addwfc	HULP2_H,F,BANKED
;ENC28j60_writebuffer( hulp2 )
	movff	HULP2,PCKTLEN
	movff	HULP2_H,PCKTLEN_H
	rcall	ENC28J60_WRITEBUFFER
;ENC28j60_packetsend( hulp2 )
	movff	HULP2,PCKTLEN
	movff	HULP2_H,PCKTLEN_H
	rcall	ENC28J60_PACKETSEND
;end if
ENDIF73
;End If
ENDIF70
;If etherBuffer(24) = 6 Then              'Protocol:TCP
	movlw	6
	banksel	SYSETHERBUFFER_24
	subwf	SYSETHERBUFFER_24,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF71
;If Tcp_destporth = 0 Then
	movf	SYSETHERBUFFER_37,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF74
;Select Case Tcp_destportl
;Case 80 : ENC28j60_http
SysSelect4Case1
	movlw	80
	subwf	SYSETHERBUFFER_38,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case2
	banksel	0
	call	ENC28J60_HTTP
;End Select
SysSelect4Case2
SysSelectEnd4
;End If
ENDIF74
;End If
ENDIF71
;End If
ENDIF68
;End If
ENDIF66
;End If
ENDIF64
;End If
ENDIF62
;End If
ENDIF60
;End If
ENDIF58
;End If
ENDIF56
;End If
ENDIF54
	banksel	0
	return

;********************************************************************************

ENC28J60_PACKETSEND
;ENC28j60_bitSet( ECON1 , econ1_txrst )
	movlw	31
	movwf	ADDR,BANKED
	movlw	128
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_BITSET
;ENC28j60_bitClear( ECON1 , econ1_txrst )
	movlw	31
	movwf	ADDR,BANKED
	movlw	128
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_BITCLEAR
;ENC28j60_bitClear( EIR , EIR_TXERIF )
	movlw	28
	movwf	ADDR,BANKED
	movlw	2
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_BITCLEAR
;wait while ( (ENC28j60_ReadReg( ECON1 ) & ECON1_TXRTS ) = ECON1_TXRTS )
SysWaitLoop11
	movlw	31
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movlw	8
	andwf	ENC28J60_READREG,W,BANKED
	movwf	SysTemp3,BANKED
	movff	SysTemp3,SysBYTETempA
	movlw	8
	movwf	SysBYTETempB,ACCESS
	call	SysCompEqual
	btfsc	SysByteTempX,0,ACCESS
	bra	SysWaitLoop11
;ENC28j60_writeReg(etxndl , (ENC_TXBUF_STL + pcktlen ) & 0xFF )
;ENC28j60_writeReg(etxndh , ENC_TXBUF_STH + pcktlen_h )
;todo erv
;hulp2 =  ENC_TXBUF_ST + pcktlen
	movlw	112
	addwf	PCKTLEN,W,BANKED
	movwf	HULP2,BANKED
	movlw	22
	addwfc	PCKTLEN_H,W,BANKED
	movwf	HULP2_H,BANKED
;HSerPrint hex(hulp2_h)
;HSerPrint hex(hulp2)
;HSerPrintCRLF
;ENC28j60_writeReg(etxndl , hulp2 & 0xFF )
	movlw	6
	movwf	ADDR,BANKED
	movff	HULP2,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(etxndh , hulp2_h )
	movlw	7
	movwf	ADDR,BANKED
	movff	HULP2_H,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28j60_bitSet( EIR , EIR_TXIF )
	movlw	28
	movwf	ADDR,BANKED
	movlw	8
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_BITSET
;ENC28j60_bitClear( EIE , EIE_TXIE )
	movlw	27
	movwf	ADDR,BANKED
	movlw	8
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_BITCLEAR
;ENC28j60_bitSet( ECON1 , econ1_txrts )
	movlw	31
	movwf	ADDR,BANKED
	movlw	8
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_BITSET
;wait while ( (ENC28j60_ReadReg( ECON1 ) & ECON1_TXRTS ) = ECON1_TXRTS )
SysWaitLoop12
	movlw	31
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movlw	8
	andwf	ENC28J60_READREG,W,BANKED
	movwf	SysTemp3,BANKED
	movff	SysTemp3,SysBYTETempA
	movlw	8
	movwf	SysBYTETempB,ACCESS
	call	SysCompEqual
	btfsc	SysByteTempX,0,ACCESS
	bra	SysWaitLoop12
;packetCounterOut++
	incf	PACKETCOUNTEROUT,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	PACKETCOUNTEROUT_H,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	PACKETCOUNTEROUT_U,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	PACKETCOUNTEROUT_E,F,BANKED
	return

;********************************************************************************

ENC28J60_PACKETSHAPE
;T_enetpacketdest0 = T_enetpacketsrc0
	movff	SYSETHERBUFFER_7,SYSETHERBUFFER_1
;T_enetpacketdest1 = T_enetpacketsrc1
	movff	SYSETHERBUFFER_8,SYSETHERBUFFER_2
;T_enetpacketdest2 = T_enetpacketsrc2
	movff	SYSETHERBUFFER_9,SYSETHERBUFFER_3
;T_enetpacketdest3 = T_enetpacketsrc3
	movff	SYSETHERBUFFER_10,SYSETHERBUFFER_4
;T_enetpacketdest4 = T_enetpacketsrc4
	movff	SYSETHERBUFFER_11,SYSETHERBUFFER_5
;T_enetpacketdest5 = T_enetpacketsrc5
	movff	SYSETHERBUFFER_12,SYSETHERBUFFER_6
;T_enetpacketsrc0 = macaddr(1)
	movff	SYSMACADDR_1,SYSETHERBUFFER_7
;T_enetpacketsrc1 = macaddr(2)
	movff	SYSMACADDR_2,SYSETHERBUFFER_8
;T_enetpacketsrc2 = macaddr(3)
	movff	SYSMACADDR_3,SYSETHERBUFFER_9
;T_enetpacketsrc3 = macaddr(4)
	movff	SYSMACADDR_4,SYSETHERBUFFER_10
;T_enetpacketsrc4 = macaddr(5)
	movff	SYSMACADDR_5,SYSETHERBUFFER_11
;T_enetpacketsrc5 = macaddr(6)
	movff	SYSMACADDR_6,SYSETHERBUFFER_12
	return

;********************************************************************************

ENC28J60_PINGREPLY
;Dim Packetlength As Word
;T_id0 = ip_id_h
	movff	IP_ID_H,SYSETHERBUFFER_19
;T_id1 = [byte]ip_id
	movff	IP_ID,SYSETHERBUFFER_20
;Ip_id = Ip_id + 1
	incf	IP_ID,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	IP_ID_H,F,BANKED
;ENC28j60_set_response_IPpacket
	rcall	ENC28J60_SET_RESPONSE_IPPACKET
;'Swap IP addresses
;T_ip_destaddr0 = T_ip_srcaddr0
;T_ip_destaddr1 = T_ip_srcaddr1
;T_ip_destaddr2 = T_ip_srcaddr2
;T_ip_destaddr3 = T_ip_srcaddr3
;
;'Set source IP in IP header, pos 27
;T_ip_srcaddr0 = ipaddr(1)
;T_ip_srcaddr1 = ipaddr(2)
;T_ip_srcaddr2 = ipaddr(3)
;T_ip_srcaddr3 = ipaddr(4)
;'Swap MAC addresses
;ENC28j60_set_response_macaddress
;T_ip_hdr_cksum0 = 0
	banksel	SYSETHERBUFFER_25
	clrf	SYSETHERBUFFER_25,BANKED
;T_ip_hdr_cksum1 = 0
	clrf	SYSETHERBUFFER_26,BANKED
;ENC28j60_Calcchecksum( T_ip_header_pointer0 , T_ip_header_pointer1 , T_ip_hdr_cksum0_pointer )
	movlw	15
	banksel	STARTPTR
	movwf	STARTPTR,BANKED
	clrf	STARTPTR_H,BANKED
	movlw	33
	movwf	ENDPTR,BANKED
	clrf	ENDPTR_H,BANKED
	movlw	25
	movwf	RESULT,BANKED
	clrf	RESULT_H,BANKED
	call	ENC28J60_CALCCHECKSUM
;T_icmp_type = 0
	banksel	SYSETHERBUFFER_35
	clrf	SYSETHERBUFFER_35,BANKED
;T_icmp_cksum0 = 0
	clrf	SYSETHERBUFFER_37,BANKED
;T_icmp_cksum1 = 0
	clrf	SYSETHERBUFFER_38,BANKED
;Packetlength_h = etherBuffer(17)
	movff	SYSETHERBUFFER_17,PACKETLENGTH_H
;[byte]Packetlength = etherBuffer(18)
	movff	SYSETHERBUFFER_18,PACKETLENGTH
;Packetlength = etherBuffer(17) * 256
;Packetlength = Packetlength + etherBuffer(18)
;Packetlength = Packetlength + 13                         'We are going to calculate the checksum till the end of packet (IP length + 14 byte of the ethernet stuff), -1 to get word start
	movlw	13
	banksel	PACKETLENGTH
	addwf	PACKETLENGTH,F,BANKED
	movlw	0
	addwfc	PACKETLENGTH_H,F,BANKED
;ENC28j60_Calcchecksum(35 , Packetlength , 37)
	movlw	35
	movwf	STARTPTR,BANKED
	clrf	STARTPTR_H,BANKED
	movff	PACKETLENGTH,ENDPTR
	movff	PACKETLENGTH_H,ENDPTR_H
	movlw	37
	movwf	RESULT,BANKED
	clrf	RESULT_H,BANKED
	call	ENC28J60_CALCCHECKSUM
;Packetlength = Packetlength + 1
	incf	PACKETLENGTH,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	PACKETLENGTH_H,F,BANKED
;ENC28j60_writebuffer( packetlength )
	movff	PACKETLENGTH,PCKTLEN
	movff	PACKETLENGTH_H,PCKTLEN_H
	rcall	ENC28J60_WRITEBUFFER
;ENC28j60_packetsend(packetlength)
	movff	PACKETLENGTH,PCKTLEN
	movff	PACKETLENGTH_H,PCKTLEN_H
	bra	ENC28J60_PACKETSEND

;********************************************************************************

ENC28J60_POLL
;if crl = 1 then
	decf	CRL,W,BANKED
	btfsc	STATUS, Z,ACCESS
;HSerPrintCRLF
;crl = 0
	clrf	CRL,BANKED
;Else
;if bck = 1 Then
;HSerPrint "<"
;bck=0
;end if
;end if
;HSerPrint "EIE :"
;HSerPrint ByteToBin( ENC28j60_ReadReg( EIE ))
;HSerSend 9
;HSerPrint "EIR :"
;HSerPrint ByteToBin( ENC28j60_ReadReg( EIR ))
;HSerSend 9
;HSerPrintCRLF
;ENC28j60_data = ENC28j60_ReadReg( erevid )
;ENC28j60_selectBank ( 1, epktcnt )
;lastselectedBank = 99
	movlw	99
	movwf	LASTSELECTEDBANK,BANKED
;HSerPrint ENC28j60_ReadReg( epktcnt )
;HSerPrintCRLF
;wait while ( ENC28j60_ReadReg( ESTAT ) and ESTAT_RXBUSY ) = ESTAT_RXBUSY
;if ENC28j60_ReadReg( epktcnt ) > 0 Then
	movlw	57
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movf	ENC28J60_READREG,W,BANKED
	sublw	0
	btfsc	STATUS, C,ACCESS
	bra	ELSE9_1
;HSerPrint "1"
;ENC28j60_packetreceive(300)
	movlw	44
	movwf	MAXLEN,BANKED
	movlw	1
	movwf	MAXLEN_H,BANKED
	rcall	ENC28J60_PACKETRECEIVE
;crl = 1
	movlw	1
	movwf	CRL,BANKED
;bck = 1
;else
ELSE9_1
;ENC28j60_bitSet( ECON2, ECON2_PKTDEC )
;end if
ERRORHANDLER
;if ENC28j60_ReadReg( EIR ) & 0x01 = 0X01 Then
	movlw	28
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,SysTemp1
	btfss	SysTemp1,0,BANKED
	bra	ENDIF10
;HSerPrint "Buffer Overun"
;HSerSend 7
;HSerPrint "B"
;ENC28j60_bitClear( EIR, EIR_RXERIF )
	movlw	28
	movwf	ADDR,BANKED
	movlw	1
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_BITCLEAR
;end if
ENDIF10
	return

;********************************************************************************

ENC28J60_READBUFFER
;dim eth_counter as Word
;ENC28j60_regdump
;if etherGetLength  > 1518 then Exit Sub
;ENC28j60_Select
	bcf	LATA,5,ACCESS
;Set WCOL Off
	bcf	SSPCON1,WCOL,ACCESS
;SSPBUF = ENC28j60_READ_BUF_MEM
	movlw	58
	movwf	SSPBUF,ACCESS
;Wait While BF = Off
SysWaitLoop13
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop13
;temp = SSPBUF
	movff	SSPBUF,TEMP
;for eth_counter = 1 to etherGetLength
	clrf	ETH_COUNTER,BANKED
	clrf	ETH_COUNTER_H,BANKED
	movlw	1
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	movff	ETHERGETLENGTH,SysWORDTempA
	movff	ETHERGETLENGTH_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd5
SysForLoop5
	incf	ETH_COUNTER,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	ETH_COUNTER_H,F,BANKED
;if eth_counter > etherBufferSize then
	movff	ETH_COUNTER,SysWORDTempB
	movff	ETH_COUNTER_H,SysWORDTempB_H
	movlw	188
	movwf	SysWORDTempA,ACCESS
	movlw	2
	movwf	SysWORDTempA_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
;exit for
	bra	SysForLoopEnd5
;end if
;SSPBUF = 0
	clrf	SSPBUF,ACCESS
;Wait While BF = Off
SysWaitLoop14
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop14
;etherbuffer( eth_counter ) = SSPBUF
	lfsr	0,ETHERBUFFER
	movf	ETH_COUNTER,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	SSPBUF,INDF0
;next
	movff	ETH_COUNTER,SysWORDTempA
	movff	ETH_COUNTER_H,SysWORDTempA_H
	movff	ETHERGETLENGTH,SysWORDTempB
	movff	ETHERGETLENGTH_H,SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop5
SysForLoopEnd5
;if etherGetLength > etherBufferSize then
	movff	ETHERGETLENGTH,SysWORDTempB
	movff	ETHERGETLENGTH_H,SysWORDTempB_H
	movlw	188
	movwf	SysWORDTempA,ACCESS
	movlw	2
	movwf	SysWORDTempA_H,ACCESS
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF78
;for eth_counter = etherBufferSize+1 to etherGetLength
	movlw	188
	movwf	ETH_COUNTER,BANKED
	movlw	2
	movwf	ETH_COUNTER_H,BANKED
	movlw	189
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	movff	ETHERGETLENGTH,SysWORDTempA
	movff	ETHERGETLENGTH_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd6
SysForLoop6
	incf	ETH_COUNTER,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	ETH_COUNTER_H,F,BANKED
;SSPBUF = 0
	clrf	SSPBUF,ACCESS
;Wait While BF = Off
SysWaitLoop15
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop15
;temp = SSPBUF
	movff	SSPBUF,TEMP
;next
	movff	ETH_COUNTER,SysWORDTempA
	movff	ETH_COUNTER_H,SysWORDTempA_H
	movff	ETHERGETLENGTH,SysWORDTempB
	movff	ETHERGETLENGTH_H,SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop6
SysForLoopEnd6
;End if
ENDIF78
;ENC28j60_Deselect
	bsf	LATA,5,ACCESS
	return

;********************************************************************************

FN_ENC28J60_READREG
;banktobeselected =  ( addr & BANK_MASK) / 32
;banktobeselected =  ( addr & BANK_MASK)
	movlw	96
	andwf	ADDR,W,BANKED
	movwf	BANKTOBESELECTED,BANKED
;Repeat 5
	movlw	5
	movwf	SysRepeatTemp4,BANKED
SysRepeatLoop4
;set c off
	bcf	STATUS,C,ACCESS
;rotate banktobeselected right
	rrcf	BANKTOBESELECTED,F,BANKED
;end repeat
	decfsz	SysRepeatTemp4,F,BANKED
	bra	SysRepeatLoop4
SysRepeatLoopEnd4
;HSerPrint "$"
;HSerPrint banktobeselected
;HSerPrint ":"
;				'These registers (EIE, EIR, ESTAT, ECON2, ECON1)
;				'are present in all banks, no need to switch bank
;if lastselectedBank <> banktobeselected then
	movf	BANKTOBESELECTED,W,BANKED
	subwf	LASTSELECTEDBANK,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF11
;if ( ( addr & ADDR_MASK ) <= EIE  ) then
	movlw	31
	andwf	ADDR,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SysBYTETempB
	movlw	27
	movwf	SysBYTETempA,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE12_1
;ENC28j60_selectBank ( banktobeselected, addr )
	rcall	ENC28J60_SELECTBANK
;else
	bra	ENDIF12
ELSE12_1
;lastselectedBank = banktobeselected
	movff	BANKTOBESELECTED,LASTSELECTEDBANK
;end if
ENDIF12
;end if
ENDIF11
;ENC28j60_Select
	bcf	LATA,5,ACCESS
;Set WCOL Off
	bcf	SSPCON1,WCOL,ACCESS
;SSPBUF = ENC28j60_READ_CTRL_REG | ( addr AND ADDR_MASK )
	movlw	31
	andwf	ADDR,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SSPBUF
;Wait While BF = Off
SysWaitLoop3
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop3
;temp = SSPBUF
	movff	SSPBUF,TEMP
;Set WCOL Off
	bcf	SSPCON1,WCOL,ACCESS
;SSPBUF = temp
	movff	TEMP,SSPBUF
;Wait While BF = Off
SysWaitLoop4
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop4
;temp = SSPBUF
	movff	SSPBUF,TEMP
;Set WCOL Off
	bcf	SSPCON1,WCOL,ACCESS
;SSPBUF = temp
	movff	TEMP,SSPBUF
;Wait While BF = Off
SysWaitLoop5
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop5
;ENC28j60_ReadReg = SSPBUF
	movff	SSPBUF,ENC28J60_READREG
;ENC28j60_Deselect
	bsf	LATA,5,ACCESS
	return

;********************************************************************************

ENC28J60_REGDUMP
;HSerPrintCRLF
;HSerPrint "Registerdump ENC28j60"
;
;ENC28j60_data = ENC28j60_ReadReg( erevid)
;HSerPrint " Version: " + str( ENC28j60_data )
;HSerPrintCRLF
;'ok
;HSerPrint "Cntrl: ECON1 ECON2 ESTAT  EIR  EIE"
;HSerPrintCRLF
;ENC28j60_data = ENC28j60_ReadReg( econ1)
;HSerPrint "       " + Hex(ENC28j60_data);
;ENC28j60_data = ENC28j60_ReadReg( econ2)
;HSerPrint "    " + Hex(ENC28j60_data);
;ENC28j60_data = ENC28j60_ReadReg( estat)
;HSerPrint "    " + Hex(ENC28j60_data);
;ENC28j60_ReadReg (eir)
;HSerPrint "     " + Hex(ENC28j60_data);
;ENC28j60_data = ENC28j60_ReadReg( eie)
;HSerPrint "   " + Hex(ENC28j60_data)
;HSerPrintCRLF
;'ok
;HSerPrint "MAC  : MACON1  MACON2  MACON3  MACON4  MAC-Address"
;HSerPrintCRLF
;ENC28j60_data = ENC28j60_ReadReg( macon1)
;HSerPrint "       " + Hex(ENC28j60_data);
;ENC28j60_data = ENC28j60_ReadReg( macon2)
;HSerPrint "      " + Hex(ENC28j60_data);
;ENC28j60_data = ENC28j60_ReadReg( macon3)
;HSerPrint "      " + Hex(ENC28j60_data);
;ENC28j60_data = ENC28j60_ReadReg( macon4)
;HSerPrint "      " + Hex(ENC28j60_data);
;ENC28j60_data = ENC28j60_ReadReg( maadr5)
;HSerPrint "      " + Hex(ENC28j60_data);
;ENC28j60_data = ENC28j60_ReadReg( maadr4)
;HSerPrint "." + Hex(ENC28j60_data);
;ENC28j60_data = ENC28j60_ReadReg( maadr3)
;HSerPrint "." + Hex(ENC28j60_data);
;ENC28j60_data = ENC28j60_ReadReg( maadr2)
;HSerPrint "." + Hex(ENC28j60_data);
;ENC28j60_data = ENC28j60_ReadReg( maadr1)
;HSerPrint "." + Hex(ENC28j60_data);
;ENC28j60_data = ENC28j60_ReadReg( maadr0)
;HSerPrint "." + Hex(ENC28j60_data)
;HSerPrintCRLF
;HSerPrint "Rx   : ERXST  ERXND  ERXWRPT ERXRDPT ERXFCON EPKTCNT MAMXFL"
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;ENC28j60_data = ENC28j60_ReadReg(erxsth)
;HSerPrint "       " + Hex(ENC28j60_data);
;ENC28j60_data = ENC28j60_ReadReg(erxstl)
;HSerPrint Hex(ENC28j60_data);
;ENC28j60_data = ENC28j60_ReadReg(erxndh)
;HSerPrint "   " + Hex(ENC28j60_data);
;ENC28j60_data = ENC28j60_ReadReg(erxndl)
;HSerPrint Hex(ENC28j60_data);
;dim t1, t2 as word
;ENC28j60_data = ENC28j60_ReadReg(erxwrpth)
	movlw	15
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "   " + Hex(ENC28j60_data);
;t1_h = ENC28j60_data
	movff	ENC28J60_DATA,T1_H
;ENC28j60_data = ENC28j60_ReadReg(erxwrptl)
	movlw	14
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint Hex(ENC28j60_data);
;[byte]t1 = ENC28j60_data
	movff	ENC28J60_DATA,T1
;ENC28j60_data = ENC28j60_ReadReg(erxrdpth)
	movlw	13
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "    " + Hex(ENC28j60_data);
;t2_h = ENC28j60_data
	movff	ENC28J60_DATA,T2_H
;ENC28j60_data = ENC28j60_ReadReg(erxrdptl)
	movlw	12
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint Hex(ENC28j60_data);
;[byte]t2 = ENC28j60_data
	movff	ENC28J60_DATA,T2
;ENC28j60_data = ENC28j60_ReadReg(erxfcon)
;HSerPrint "    " + Hex(ENC28j60_data);
;ENC28j60_data = ENC28j60_ReadReg(epktcnt)
	movlw	57
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "      " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	rcall	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable33
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable33
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,HEX
	call	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT245
;HSerSend 9
	movlw	9
	movwf	SERDATA,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERSEND
;HSerPrint t1 - t2
	movf	T2,W,BANKED
	subwf	T1,W,BANKED
	movwf	SERPRINTVAL,BANKED
	movf	T2_H,W,BANKED
	subwfb	T1_H,W,BANKED
	movwf	SERPRINTVAL_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT247
;ENC28j60_data = ENC28j60_ReadReg(mamxflh)
;HSerPrint "      " + Hex(ENC28j60_data);
;ENC28j60_data = ENC28j60_ReadReg(mamxfll)
;HSerPrint Hex(ENC28j60_data)
;HSerPrintCRLF
;HSerPrint "Tx   : ETXST  ETXND  EWRPT  MACLCON1 MACLCON2 MAPHSUP"
;HSerPrintCRLF
;ENC28j60_data = ENC28j60_ReadReg(etxsth)
;HSerPrint "       " + Hex(ENC28j60_data);
;ENC28j60_data = ENC28j60_ReadReg(etxstl)
;HSerPrint Hex(ENC28j60_data);
;ENC28j60_data = ENC28j60_ReadReg(etxndh)
;HSerPrint "   " + Hex(ENC28j60_data);
;ENC28j60_data = ENC28j60_ReadReg(etxndl)
;HSerPrint Hex(ENC28j60_data);
;
;ENC28j60_data = ENC28j60_ReadReg(EWRPTH)
;HSerPrint "   " +  Hex(ENC28j60_data);
;ENC28j60_data = ENC28j60_ReadReg(EWRPTl)
;HSerPrint Hex(ENC28j60_data);
;
;
;ENC28j60_data = ENC28j60_ReadReg(maclcon1)
;HSerPrint "   " + Hex(ENC28j60_data);
;ENC28j60_data = ENC28j60_ReadReg(maclcon2)
;HSerPrint "       " + Hex(ENC28j60_data);
;ENC28j60_data = ENC28j60_ReadReg(maphsup)
;HSerPrint "       " + Hex(ENC28j60_data)
;HSerPrintCRLF 2
	return

;********************************************************************************

ENC28J60_SELECTBANK
;ENC28j60_Select
	bcf	LATA,5,ACCESS
;FastHWSPITransfer(BFCCMD | ECON1, temp)
	movlw	191
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;FastHWSPITransfer(b'00000011', temp)
	movlw	3
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;ENC28j60_Deselect
	bsf	LATA,5,ACCESS
;ENC28j60_Select
	bcf	LATA,5,ACCESS
;FastHWSPITransfer(BFSCMD | ECON1, temp)
	movlw	159
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;Select case banktobeselected
;case 1
SysSelect1Case1
	decf	BANKTOBESELECTED,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case2
;FastHWSPITransfer(b'00000001' , temp)
	movlw	1
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;case 2
	bra	SysSelectEnd1
SysSelect1Case2
	movlw	2
	subwf	BANKTOBESELECTED,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case3
;FastHWSPITransfer(b'00000010' , temp)
	movlw	2
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;case 3
	bra	SysSelectEnd1
SysSelect1Case3
	movlw	3
	subwf	BANKTOBESELECTED,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case4
;FastHWSPITransfer(b'00000011' , temp)
	movlw	3
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;End Select
SysSelect1Case4
SysSelectEnd1
;ENC28j60_Deselect
	bsf	LATA,5,ACCESS
;lastselectedBank = banktobeselected
	movff	BANKTOBESELECTED,LASTSELECTEDBANK
	return

;********************************************************************************

ENC28J60_SETIPADDRS
;T_ip_destaddr0 = T_ip_srcaddr0
	movff	SYSETHERBUFFER_27,SYSETHERBUFFER_31
;T_ip_destaddr1 = T_ip_srcaddr1
	movff	SYSETHERBUFFER_28,SYSETHERBUFFER_32
;T_ip_destaddr2 = T_ip_srcaddr2
	movff	SYSETHERBUFFER_29,SYSETHERBUFFER_33
;T_ip_destaddr3 = T_ip_srcaddr3
	movff	SYSETHERBUFFER_30,SYSETHERBUFFER_34
;T_ip_srcaddr0 = ipaddr(1)
	movff	SYSIPADDR_1,SYSETHERBUFFER_27
;T_ip_srcaddr1 = ipaddr(2)
	movff	SYSIPADDR_2,SYSETHERBUFFER_28
;T_ip_srcaddr2 = ipaddr(3)
	movff	SYSIPADDR_3,SYSETHERBUFFER_29
;T_ip_srcaddr3 = ipaddr(4)
	movff	SYSIPADDR_4,SYSETHERBUFFER_30
;ENC28j60_set_response_macaddress
	rcall	ENC28J60_SET_RESPONSE_MACADDRESS
;ENC28j60_Ip_header_checksum
	bra	ENC28J60_IP_HEADER_CHECKSUM

;********************************************************************************

ENC28J60_SET_RESPONSE_IPPACKET
;T_ip_destaddr0 = T_ip_srcaddr0
	movff	SYSETHERBUFFER_27,SYSETHERBUFFER_31
;T_ip_destaddr1 = T_ip_srcaddr1
	movff	SYSETHERBUFFER_28,SYSETHERBUFFER_32
;T_ip_destaddr2 = T_ip_srcaddr2
	movff	SYSETHERBUFFER_29,SYSETHERBUFFER_33
;T_ip_destaddr3 = T_ip_srcaddr3
	movff	SYSETHERBUFFER_30,SYSETHERBUFFER_34
;T_ip_srcaddr0 = ipaddr(1)
	movff	SYSIPADDR_1,SYSETHERBUFFER_27
;T_ip_srcaddr1 = ipaddr(2)
	movff	SYSIPADDR_2,SYSETHERBUFFER_28
;T_ip_srcaddr2 = ipaddr(3)
	movff	SYSIPADDR_3,SYSETHERBUFFER_29
;T_ip_srcaddr3 = ipaddr(4)
	movff	SYSIPADDR_4,SYSETHERBUFFER_30
;ENC28j60_set_response_macaddress
	rcall	ENC28J60_SET_RESPONSE_MACADDRESS
;ENC28j60_Ip_header_checksum
	bra	ENC28J60_IP_HEADER_CHECKSUM

;********************************************************************************

ENC28J60_SET_RESPONSE_MACADDRESS
;For II = 1 To 6
	clrf	II,BANKED
SysForLoop7
	incf	II,F,BANKED
;etherBuffer(II)= etherBuffer(6 + II)
	lfsr	0,ETHERBUFFER
	movlw	6
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp1,BANKED
	movlw	0
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movf	II,W,BANKED
	addwf	SysTemp1,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,SysArrayTemp2
	movff	SysArrayTemp2,SysArrayTemp1
	lfsr	0,ETHERBUFFER
	movf	II,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	SysArrayTemp1,INDF0
;Next
	movlw	6
	subwf	II,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop7
SysForLoopEnd7
;etherBuffer(7) = macaddr(1)
	movff	SYSMACADDR_1,SYSETHERBUFFER_7
;etherBuffer(8) = macaddr(2)
	movff	SYSMACADDR_2,SYSETHERBUFFER_8
;etherBuffer(9) = macaddr(3)
	movff	SYSMACADDR_3,SYSETHERBUFFER_9
;etherBuffer(10) = macaddr(4)
	movff	SYSMACADDR_4,SYSETHERBUFFER_10
;etherBuffer(11) = macaddr(5)
	movff	SYSMACADDR_5,SYSETHERBUFFER_11
;etherBuffer(12) = macaddr(6)
	movff	SYSMACADDR_6,SYSETHERBUFFER_12
	return

;********************************************************************************

ENC28J60_SNTP_GET
;T_enetpacketdest0 = macaddrrouter(1)
	movff	SYSMACADDRROUTER_1,SYSETHERBUFFER_1
;T_enetpacketdest1 = macaddrrouter(2)
	movff	SYSMACADDRROUTER_2,SYSETHERBUFFER_2
;T_enetpacketdest2 = macaddrrouter(3)
	movff	SYSMACADDRROUTER_3,SYSETHERBUFFER_3
;T_enetpacketdest3 = macaddrrouter(4)
	movff	SYSMACADDRROUTER_4,SYSETHERBUFFER_4
;T_enetpacketdest4 = macaddrrouter(5)
	movff	SYSMACADDRROUTER_5,SYSETHERBUFFER_5
;T_enetpacketdest5 = macaddrrouter(6)
	movff	SYSMACADDRROUTER_6,SYSETHERBUFFER_6
;T_enetpacketsrc0 = macaddr(1)
	movff	SYSMACADDR_1,SYSETHERBUFFER_7
;T_enetpacketsrc1 = macaddr(2)
	movff	SYSMACADDR_2,SYSETHERBUFFER_8
;T_enetpacketsrc2 = macaddr(3)
	movff	SYSMACADDR_3,SYSETHERBUFFER_9
;T_enetpacketsrc3 = macaddr(4)
	movff	SYSMACADDR_4,SYSETHERBUFFER_10
;T_enetpacketsrc4 = macaddr(5)
	movff	SYSMACADDR_5,SYSETHERBUFFER_11
;T_enetpacketsrc5 = macaddr(6)
	movff	SYSMACADDR_6,SYSETHERBUFFER_12
;T_enetpackettype0 = 0X08
	movlw	8
	banksel	SYSETHERBUFFER_13
	movwf	SYSETHERBUFFER_13,BANKED
;T_enetpackettype1 = 0X00                              ' = 0X0800
	clrf	SYSETHERBUFFER_14,BANKED
;T_ip_vers_len = 0X45
	movlw	69
	movwf	SYSETHERBUFFER_15,BANKED
;T_tos = 0X00
	clrf	SYSETHERBUFFER_16,BANKED
;T_ip_pktlen0 = 0X00
	clrf	SYSETHERBUFFER_17,BANKED
;T_ip_pktlen1 = 0X30
	movlw	48
	movwf	SYSETHERBUFFER_18,BANKED
;T_id0 = 0X4A
	movlw	74
	movwf	SYSETHERBUFFER_19,BANKED
;T_id1 = 0XA5
	movlw	165
	movwf	SYSETHERBUFFER_20,BANKED
;T_flags = 0X00
	clrf	SYSETHERBUFFER_21,BANKED
;T_offset = 0X00
	clrf	SYSETHERBUFFER_22,BANKED
;T_ttl = 0X80
	movlw	128
	movwf	SYSETHERBUFFER_23,BANKED
;T_ip_proto = 0X11
	movlw	17
	movwf	SYSETHERBUFFER_24,BANKED
;T_ip_srcaddr0 = ipaddr(1)
	movff	SYSIPADDR_1,SYSETHERBUFFER_27
;T_ip_srcaddr1 = ipaddr(2)
	movff	SYSIPADDR_2,SYSETHERBUFFER_28
;T_ip_srcaddr2 = ipaddr(3)
	movff	SYSIPADDR_3,SYSETHERBUFFER_29
;T_ip_srcaddr3 = ipaddr(4)
	movff	SYSIPADDR_4,SYSETHERBUFFER_30
;T_ip_destaddr0 = sntpserveraddr(1)                               'the NTP-server here
	movff	SYSSNTPSERVERADDR_1,SYSETHERBUFFER_31
;T_ip_destaddr1 = sntpserveraddr(2)
	movff	SYSSNTPSERVERADDR_2,SYSETHERBUFFER_32
;T_ip_destaddr2 = sntpserveraddr(3)
	movff	SYSSNTPSERVERADDR_3,SYSETHERBUFFER_33
;T_ip_destaddr3 = sntpserveraddr(4)
	movff	SYSSNTPSERVERADDR_4,SYSETHERBUFFER_34
;T_udp_srcport0 = 0X13
	movlw	19
	movwf	SYSETHERBUFFER_35,BANKED
;T_udp_srcport1 = 0X88
	movlw	136
	movwf	SYSETHERBUFFER_36,BANKED
;T_udp_destport0 = 0X00                                        'port 0025 = 37 SNTP
	clrf	SYSETHERBUFFER_37,BANKED
;T_udp_destport1 = 0X25
	movlw	37
	movwf	SYSETHERBUFFER_38,BANKED
;T_udp_len0 = 0X00
	clrf	SYSETHERBUFFER_39,BANKED
;T_udp_len1 = 0X1C
	movlw	28
	movwf	SYSETHERBUFFER_40,BANKED
;T_udp_data0 = 0X58 'Asc( "X")
	movlw	88
	movwf	SYSETHERBUFFER_43,BANKED
;T_udp_data1 = 0X0A ' lf
	movlw	10
	movwf	SYSETHERBUFFER_44,BANKED
;T_udp_data2 = 0X0D ' cr
	movlw	13
	movwf	SYSETHERBUFFER_45,BANKED
;T_udp_data4 = 0
	clrf	SYSETHERBUFFER_47,BANKED
;T_udp_data5 = 0
	clrf	SYSETHERBUFFER_48,BANKED
;T_udp_data6 = 0
	clrf	SYSETHERBUFFER_49,BANKED
;T_udp_data7 = 0
	clrf	SYSETHERBUFFER_50,BANKED
;T_udp_data8 = 0
	clrf	SYSETHERBUFFER_51,BANKED
;T_udp_data9 = 0
	clrf	SYSETHERBUFFER_52,BANKED
;T_udp_data10 = 0
	clrf	SYSETHERBUFFER_53,BANKED
;T_udp_data11 = 0
	clrf	SYSETHERBUFFER_54,BANKED
;T_udp_data12 = 0
	clrf	SYSETHERBUFFER_55,BANKED
;T_udp_data13 = 0
	clrf	SYSETHERBUFFER_56,BANKED
;T_udp_data14 = 0
	clrf	SYSETHERBUFFER_57,BANKED
;T_udp_data15 = 0
	clrf	SYSETHERBUFFER_58,BANKED
;T_udp_data16 = 0
	clrf	SYSETHERBUFFER_59,BANKED
;T_udp_data17 = 0
	clrf	SYSETHERBUFFER_60,BANKED
;T_udp_data18 = 0
	clrf	SYSETHERBUFFER_61,BANKED
;T_udp_data19 = 0
	clrf	SYSETHERBUFFER_62,BANKED
;T_udp_data20 = 0
	clrf	SYSETHERBUFFER_63,BANKED
;T_udp_data21 = 0
	clrf	SYSETHERBUFFER_64,BANKED
;T_udp_data22 = 0
	clrf	SYSETHERBUFFER_65,BANKED
;T_udp_data23 = 0
	clrf	SYSETHERBUFFER_66,BANKED
;T_udp_data24 = 0
	clrf	SYSETHERBUFFER_67,BANKED
;T_udp_data25 = 0
	clrf	SYSETHERBUFFER_68,BANKED
;T_udp_data26 = 0
	clrf	SYSETHERBUFFER_69,BANKED
;T_udp_data27 = 0
	clrf	SYSETHERBUFFER_70,BANKED
;ENC28j60_Ip_header_checksum
	banksel	0
	call	ENC28J60_IP_HEADER_CHECKSUM
;ENC28j60_Udp_checksum
	rcall	ENC28J60_UDP_CHECKSUM
;Hulp2 = T_udp_len0 * 256
	movff	SYSETHERBUFFER_39,SysWORDTempA
	clrf	SysWORDTempA_H,ACCESS
	clrf	SysWORDTempB,ACCESS
	movlw	1
	movwf	SysWORDTempB_H,ACCESS
	call	SysMultSub16
	movff	SysWORDTempX,HULP2
	movff	SysWORDTempX_H,HULP2_H
;Hulp2 = Hulp2 + T_udp_len1
	banksel	SYSETHERBUFFER_40
	movf	SYSETHERBUFFER_40,W,BANKED
	banksel	HULP2
	addwf	HULP2,F,BANKED
	movlw	0
	addwfc	HULP2_H,F,BANKED
;Hulp2 = Hulp2 + 34
	movlw	34
	addwf	HULP2,F,BANKED
	movlw	0
	addwfc	HULP2_H,F,BANKED
;ENC28j60_writebuffer( 45 )
	movlw	45
	movwf	PCKTLEN,BANKED
	clrf	PCKTLEN_H,BANKED
	rcall	ENC28J60_WRITEBUFFER
;ENC28j60_packetsend( hulp2 )
	movff	HULP2,PCKTLEN
	movff	HULP2_H,PCKTLEN_H
	bra	ENC28J60_PACKETSEND

;********************************************************************************

ENC28J60_TCP_CHECKSUM
;Dim Whulp1 As Word
;Dim Tempword2 As Word
;dim I_chksum32 as long
;dim Hulp2, I_x as word
;tcp_cksum0 = 0x00
	banksel	SYSETHERBUFFER_51
	clrf	SYSETHERBUFFER_51,BANKED
;tcp_cksum1 = 0x00
	clrf	SYSETHERBUFFER_52,BANKED
;I_chksum32 = 0
	banksel	I_CHKSUM32
	clrf	I_CHKSUM32,BANKED
	clrf	I_CHKSUM32_H,BANKED
	clrf	I_CHKSUM32_U,BANKED
	clrf	I_CHKSUM32_E,BANKED
;I_value16_h = T_ip_srcaddr0
	movff	SYSETHERBUFFER_27,I_VALUE16_H
;[byte]I_value16 = T_ip_srcaddr1
	movff	SYSETHERBUFFER_28,I_VALUE16
;I_chksum32 = I_value16 + I_chksum32
	movf	I_CHKSUM32,W,BANKED
	addwf	I_VALUE16,W,ACCESS
	movwf	I_CHKSUM32,BANKED
	movf	I_CHKSUM32_H,W,BANKED
	addwfc	I_VALUE16_H,W,ACCESS
	movwf	I_CHKSUM32_H,BANKED
	clrf	SysTemp2,BANKED
	movf	I_CHKSUM32_U,W,BANKED
	addwfc	SysTemp2,W,BANKED
	movwf	I_CHKSUM32_U,BANKED
	clrf	SysTemp1,BANKED
	movf	I_CHKSUM32_E,W,BANKED
	addwfc	SysTemp1,W,BANKED
	movwf	I_CHKSUM32_E,BANKED
;I_value16_h = T_ip_srcaddr2
	movff	SYSETHERBUFFER_29,I_VALUE16_H
;[byte]I_value16 = T_ip_srcaddr3
	movff	SYSETHERBUFFER_30,I_VALUE16
;I_chksum32 = I_value16 + I_chksum32
	movf	I_CHKSUM32,W,BANKED
	addwf	I_VALUE16,W,ACCESS
	movwf	I_CHKSUM32,BANKED
	movf	I_CHKSUM32_H,W,BANKED
	addwfc	I_VALUE16_H,W,ACCESS
	movwf	I_CHKSUM32_H,BANKED
	clrf	SysTemp2,BANKED
	movf	I_CHKSUM32_U,W,BANKED
	addwfc	SysTemp2,W,BANKED
	movwf	I_CHKSUM32_U,BANKED
	clrf	SysTemp1,BANKED
	movf	I_CHKSUM32_E,W,BANKED
	addwfc	SysTemp1,W,BANKED
	movwf	I_CHKSUM32_E,BANKED
;I_value16_h = T_ip_destaddr0
	movff	SYSETHERBUFFER_31,I_VALUE16_H
;[byte]I_value16 = T_ip_destaddr1
	movff	SYSETHERBUFFER_32,I_VALUE16
;I_chksum32 = I_value16 + I_chksum32
	movf	I_CHKSUM32,W,BANKED
	addwf	I_VALUE16,W,ACCESS
	movwf	I_CHKSUM32,BANKED
	movf	I_CHKSUM32_H,W,BANKED
	addwfc	I_VALUE16_H,W,ACCESS
	movwf	I_CHKSUM32_H,BANKED
	clrf	SysTemp2,BANKED
	movf	I_CHKSUM32_U,W,BANKED
	addwfc	SysTemp2,W,BANKED
	movwf	I_CHKSUM32_U,BANKED
	clrf	SysTemp1,BANKED
	movf	I_CHKSUM32_E,W,BANKED
	addwfc	SysTemp1,W,BANKED
	movwf	I_CHKSUM32_E,BANKED
;I_value16_h = T_ip_destaddr2
	movff	SYSETHERBUFFER_33,I_VALUE16_H
;[byte]I_value16 = T_ip_destaddr3
	movff	SYSETHERBUFFER_34,I_VALUE16
;I_chksum32 = I_value16 + I_chksum32
	movf	I_CHKSUM32,W,BANKED
	addwf	I_VALUE16,W,ACCESS
	movwf	I_CHKSUM32,BANKED
	movf	I_CHKSUM32_H,W,BANKED
	addwfc	I_VALUE16_H,W,ACCESS
	movwf	I_CHKSUM32_H,BANKED
	clrf	SysTemp2,BANKED
	movf	I_CHKSUM32_U,W,BANKED
	addwfc	SysTemp2,W,BANKED
	movwf	I_CHKSUM32_U,BANKED
	clrf	SysTemp1,BANKED
	movf	I_CHKSUM32_E,W,BANKED
	addwfc	SysTemp1,W,BANKED
	movwf	I_CHKSUM32_E,BANKED
;I_chksum32 = I_chksum32 + T_ip_proto
	banksel	SYSETHERBUFFER_24
	movf	SYSETHERBUFFER_24,W,BANKED
	banksel	I_CHKSUM32
	addwf	I_CHKSUM32,F,BANKED
	movlw	0
	addwfc	I_CHKSUM32_H,F,BANKED
	movlw	0
	addwfc	I_CHKSUM32_U,F,BANKED
	movlw	0
	addwfc	I_CHKSUM32_E,F,BANKED
;ENC28j60_calc_ippartial_checksum
;I_value16 = T_ip_vers_len And 0x0F
	movlw	15
	banksel	SYSETHERBUFFER_15
	andwf	SYSETHERBUFFER_15,W,BANKED
	movwf	I_VALUE16,ACCESS
	clrf	I_VALUE16_H,ACCESS
;I_value16 = I_value16 * 4
	movff	I_VALUE16,SysWORDTempA
	movff	I_VALUE16_H,SysWORDTempA_H
	movlw	4
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	call	SysMultSub16
	movff	SysWORDTempX,I_VALUE16
	movff	SysWORDTempX_H,I_VALUE16_H
;I_chksum32 = I_chksum32 - I_value16
	movf	I_VALUE16,W,ACCESS
	subwf	I_CHKSUM32,F,BANKED
	movf	I_VALUE16_H,W,ACCESS
	subwfb	I_CHKSUM32_H,F,BANKED
	movlw	0
	subwfb	I_CHKSUM32_U,F,BANKED
	movlw	0
	subwfb	I_CHKSUM32_E,F,BANKED
;I_value16_h = T_ip_pktlen0
	movff	SYSETHERBUFFER_17,I_VALUE16_H
;[byte]I_value16 = T_ip_pktlen1
	movff	SYSETHERBUFFER_18,I_VALUE16
;I_chksum32 = I_value16 + I_chksum32
	movf	I_CHKSUM32,W,BANKED
	addwf	I_VALUE16,W,ACCESS
	movwf	I_CHKSUM32,BANKED
	movf	I_CHKSUM32_H,W,BANKED
	addwfc	I_VALUE16_H,W,ACCESS
	movwf	I_CHKSUM32_H,BANKED
	clrf	SysTemp2,BANKED
	movf	I_CHKSUM32_U,W,BANKED
	addwfc	SysTemp2,W,BANKED
	movwf	I_CHKSUM32_U,BANKED
	clrf	SysTemp1,BANKED
	movf	I_CHKSUM32_E,W,BANKED
	addwfc	SysTemp1,W,BANKED
	movwf	I_CHKSUM32_E,BANKED
;I_odd = I_value16 Mod 2
	movff	I_VALUE16,SysWORDTempA
	movff	I_VALUE16_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysDivSub16
	movff	SysWORDTempX,I_ODD
;Hulp2 = 0x23 + I_value16 - 22 'should be 20 bytes (for the IP Header ) be two bytes less for gcb For-next loop
	movlw	35
	addwf	I_VALUE16,W,ACCESS
	movwf	SysTemp1,BANKED
	movlw	0
	addwfc	I_VALUE16_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movlw	22
	subwf	SysTemp1,W,BANKED
	movwf	HULP2,BANKED
	movlw	0
	subwfb	SysTemp1_H,W,BANKED
	movwf	HULP2_H,BANKED
;I_odd = T_udp_len1 Mod 2
	clrf	I_ODD,BANKED
	banksel	SYSETHERBUFFER_40
	btfss	SYSETHERBUFFER_40,0,BANKED
	bra	ENDIF112
	banksel	I_ODD
	incf	I_ODD,F,BANKED
ENDIF112
;If I_odd = 1 Then
	banksel	I_ODD
	decf	I_ODD,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF109
;Hulp2 =  Hulp2 + 1
	incf	HULP2,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	HULP2_H,F,BANKED
;etherbuffer( Hulp2 + 1 ) = 0x00
	lfsr	0,ETHERBUFFER
	movf	HULP2,W,BANKED
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp1,BANKED
	movf	HULP2_H,W,BANKED
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movlw	1
	addwf	SysTemp1,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	clrf	INDF0,ACCESS
;End If
ENDIF109
;For I_x = 0x23 To Hulp2 Step 2
	movlw	33
	movwf	I_X,BANKED
	clrf	I_X_H,BANKED
	movlw	35
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	movff	HULP2,SysWORDTempA
	movff	HULP2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd10
SysForLoop10
	movlw	2
	addwf	I_X,F,BANKED
	movlw	0
	addwfc	I_X_H,F,BANKED
;I_value16_h = etherbuffer(i_x)
	lfsr	0,ETHERBUFFER
	movf	I_X,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	INDF0,I_VALUE16_H
;[byte]I_value16 = etherbuffer( i_x + 1 )
	lfsr	0,ETHERBUFFER
	movf	I_X,W,BANKED
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp1,BANKED
	movlw	0
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movlw	1
	addwf	SysTemp1,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,I_VALUE16
;I_chksum32 = I_value16 + I_chksum32
	movf	I_CHKSUM32,W,BANKED
	addwf	I_VALUE16,W,ACCESS
	movwf	I_CHKSUM32,BANKED
	movf	I_CHKSUM32_H,W,BANKED
	addwfc	I_VALUE16_H,W,ACCESS
	movwf	I_CHKSUM32_H,BANKED
	clrf	SysTemp2,BANKED
	movf	I_CHKSUM32_U,W,BANKED
	addwfc	SysTemp2,W,BANKED
	movwf	I_CHKSUM32_U,BANKED
	clrf	SysTemp1,BANKED
	movf	I_CHKSUM32_E,W,BANKED
	addwfc	SysTemp1,W,BANKED
	movwf	I_CHKSUM32_E,BANKED
;Next
	movff	I_X,SysWORDTempA
	movff	I_X_H,SysWORDTempA_H
	movff	HULP2,SysWORDTempB
	movff	HULP2_H,SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop10
SysForLoopEnd10
;I_checksum16 = i_chksum32
	movff	I_CHKSUM32,I_CHECKSUM16
	movff	I_CHKSUM32_H,I_CHECKSUM16_H
;I_checksum16 = I_checksum16 + [byte]I_chksum32_u
	movf	I_CHKSUM32_U,W,BANKED
	addwf	I_CHECKSUM16,F,BANKED
	movlw	0
	addwfc	I_CHECKSUM16_H,F,BANKED
;I_checksum16 = Not [word]I_checksum16
	comf	I_CHECKSUM16,F,BANKED
	comf	I_CHECKSUM16_H,F,BANKED
;[byte]tcp_cksum0 = I_checksum16_h
	movff	I_CHECKSUM16_H,SYSETHERBUFFER_51
;[byte]tcp_cksum1 = I_checksum16
	movff	I_CHECKSUM16,SYSETHERBUFFER_52
	return

;********************************************************************************

ENC28J60_UDP_CHECKSUM
;dim I_chksum32 as long
;dim Hulp2, I_x as word
;T_udp_chksum0 = 0x00
	banksel	SYSETHERBUFFER_41
	clrf	SYSETHERBUFFER_41,BANKED
;T_udp_chksum1 = 0x00
	clrf	SYSETHERBUFFER_42,BANKED
	banksel	0
	return

;********************************************************************************

ENC28J60_UTC_ADJUST
;Epoch_seconds = Epoch_seconds + 3600
;Epoch_seconds = Epoch_seconds + 7200
	movlw	32
	addwf	EPOCH_SECONDS,F,BANKED
	movlw	28
	addwfc	EPOCH_SECONDS_H,F,BANKED
	movlw	0
	addwfc	EPOCH_SECONDS_U,F,BANKED
	movlw	0
	addwfc	EPOCH_SECONDS_E,F,BANKED
	return

;********************************************************************************

ENC28J60_WRITEBUFFER
;dim eth_counter as Word
;ENC28j60_writeReg(ewrptl, ENC_TXBUF_STL)
	movlw	2
	movwf	ADDR,BANKED
	movlw	112
	movwf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28j60_writeReg(ewrpth, ENC_TXBUF_STH)
	movlw	3
	movwf	ADDR,BANKED
	movlw	22
	movwf	ENC_OUTBYTE,BANKED
	rcall	ENC28J60_WRITEREG
;ENC28j60_Select
	bcf	LATA,5,ACCESS
;Set WCOL Off
	bcf	SSPCON1,WCOL,ACCESS
;SSPBUF = ENC28j60_write_buf_mem
	movlw	122
	movwf	SSPBUF,ACCESS
;Wait While BF = Off
SysWaitLoop16
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop16
;temp = SSPBUF
	movff	SSPBUF,TEMP
;SSPBUF = 0x0E
	movlw	14
	movwf	SSPBUF,ACCESS
;Wait While BF = Off
SysWaitLoop17
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop17
;temp = SSPBUF
	movff	SSPBUF,TEMP
;for eth_counter = 1 to pcktlen
	clrf	ETH_COUNTER,BANKED
	clrf	ETH_COUNTER_H,BANKED
	movlw	1
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	movff	PCKTLEN,SysWORDTempA
	movff	PCKTLEN_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd8
SysForLoop8
	incf	ETH_COUNTER,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	ETH_COUNTER_H,F,BANKED
;if eth_counter > etherBufferSize then Exit For
	movff	ETH_COUNTER,SysWORDTempB
	movff	ETH_COUNTER_H,SysWORDTempB_H
	movlw	188
	movwf	SysWORDTempA,ACCESS
	movlw	2
	movwf	SysWORDTempA_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd8
;SSPBUF = etherbuffer(eth_counter)
	lfsr	0,ETHERBUFFER
	movf	ETH_COUNTER,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	INDF0,SSPBUF
;Wait While BF = Off
SysWaitLoop18
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop18
;temp = SSPBUF
	movff	SSPBUF,TEMP
;next
	movff	ETH_COUNTER,SysWORDTempA
	movff	ETH_COUNTER_H,SysWORDTempA_H
	movff	PCKTLEN,SysWORDTempB
	movff	PCKTLEN_H,SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop8
SysForLoopEnd8
;ENC28j60_Deselect
	bsf	LATA,5,ACCESS
	return

;********************************************************************************

ENC28J60_WRITEPHYREG
;		while ((ENC28j60_ReadReg(MISTAT) & MISTAT_BUSY ) = MISTAT_BUSY )
SysDoLoop_S2
	movlw	234
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
;ENC28j60_writeReg( MIREGADR, PhyRegaddr )
	movlw	212
	movwf	ADDR,BANKED
	movff	PHYREGADDR,ENC_OUTBYTE
	rcall	ENC28J60_WRITEREG
;ENC28j60_writeReg( MIWRL, ENC_Outbyte1 )
	movlw	214
	movwf	ADDR,BANKED
	movff	ENC_OUTBYTE1,ENC_OUTBYTE
	rcall	ENC28J60_WRITEREG
;ENC28j60_writeReg( MIWRH, ENC_Outbyte2 )
	movlw	215
	movwf	ADDR,BANKED
	movff	ENC_OUTBYTE2,ENC_OUTBYTE
	rcall	ENC28J60_WRITEREG
;wait while ( (ENC28j60_ReadReg( MISTAT ) & MISTAT_BUSY ) = MISTAT_BUSY )
SysWaitLoop6
	movlw	234
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movlw	1
	andwf	ENC28J60_READREG,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SysBYTETempA
	movlw	1
	movwf	SysBYTETempB,ACCESS
	call	SysCompEqual
	btfsc	SysByteTempX,0,ACCESS
	bra	SysWaitLoop6
	return

;********************************************************************************

ENC28J60_WRITEREG
;				banktobeselected = ( addr & BANK_MASK) / 32
;banktobeselected =  ( addr & BANK_MASK)
	movlw	96
	andwf	ADDR,W,BANKED
	movwf	BANKTOBESELECTED,BANKED
;Repeat 5
	movlw	5
	movwf	SysRepeatTemp5,BANKED
SysRepeatLoop5
;set c off
	bcf	STATUS,C,ACCESS
;rotate banktobeselected right
	rrcf	BANKTOBESELECTED,F,BANKED
;end Repeat
	decfsz	SysRepeatTemp5,F,BANKED
	bra	SysRepeatLoop5
SysRepeatLoopEnd5
;if lastselectedBank <> banktobeselected then
	movf	BANKTOBESELECTED,W,BANKED
	subwf	LASTSELECTEDBANK,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ELSE13_1
;if ( ( addr & ADDR_MASK )  <= EIE  ) then
	movlw	31
	andwf	ADDR,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SysBYTETempB
	movlw	27
	movwf	SysBYTETempA,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	btfsc	SysByteTempX,0,ACCESS
;ENC28j60_selectBank ( banktobeselected, addr )
	rcall	ENC28J60_SELECTBANK
;end if
;Else
	bra	ENDIF13
ELSE13_1
;lastselectedBank = banktobeselected
	movff	BANKTOBESELECTED,LASTSELECTEDBANK
;end if
ENDIF13
;ENC28j60_Select
	bcf	LATA,5,ACCESS
;FastHWSPITransfer( ENC28j60_WRITE_CTRL_REG | (addr AND ADDR_MASK ), temp )
	movlw	31
	andwf	ADDR,W,BANKED
	movwf	SysTemp1,BANKED
	movlw	64
	iorwf	SysTemp1,W,BANKED
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;FastHWSPITransfer( ENC_Outbyte, temp )
	movff	ENC_OUTBYTE,SPITXDATA
	rcall	FASTHWSPITRANSFER
;ENC28j60_Deselect
	bsf	LATA,5,ACCESS
	return

;********************************************************************************

FASTHWSPITRANSFER
;Set SSPCON1.WCOL Off
	bcf	SSPCON1,WCOL,ACCESS
;SSPBUF = SPITxData
	movff	SPITXDATA,SSPBUF
;Wait While SSPSTAT.BF = Off
SysWaitLoop7
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop7
;Set SSPSTAT.BF Off
	bcf	SSPSTAT,BF,ACCESS
;SPIRxData = SSPBUF
	movff	SSPBUF,SPIRXDATA
	return

;********************************************************************************

FIRSTPAGE1
	movlw	127
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableFIRSTPAGE1
	movwf	TBLPTRL,ACCESS
	movlw	high TableFIRSTPAGE1
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableFIRSTPAGE1
	db	126,60,33,68,79,67,84,89,80,69,32,72,84,77,76,32,80,85,66,76,73,67,32,34,45,47
	db	47,87,51,67,47,47,68,84,68,32,72,84,77,76,32,52,46,48,49,32,84,114,97,110,115,105
	db	116,105,111,110,97,108,47,47,69,78,34,62,60,104,116,109,108,62,60,104,101,97
	db	100,62,60,116,105,116,108,101,62,71,114,101,97,116,32,67,111,119,32,66,65,83,73,67
	db	60,47,116,105,116,108,101,62,60,47,104,101,97,100,62,60,47,98,111,100,121,62,60,47
	db	104,116,109,108,62

;********************************************************************************

FN_FNLSL
;dim SysLongTempB as long
;SysLongTempB  = BitsIn
;Repeat NumBits
	movff	NUMBITS,SysRepeatTemp11
	movf	SYSREPEATTEMP11,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd11
SysRepeatLoop11
;Set C Off
	bcf	STATUS,C,ACCESS
;Rotate SysLongTempB Left
	rlcf	SYSLONGTEMPB,F,ACCESS
	rlcf	SYSLONGTEMPB_H,F,ACCESS
	rlcf	SYSLONGTEMPB_U,F,ACCESS
	rlcf	SYSLONGTEMPB_E,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp11,F,BANKED
	bra	SysRepeatLoop11
SysRepeatLoopEnd11
;FnLSL = SysLongTempB
	movff	SYSLONGTEMPB,FNLSL
	movff	SYSLONGTEMPB_H,FNLSL_H
	movff	SYSLONGTEMPB_U,FNLSL_U
	movff	SYSLONGTEMPB_E,FNLSL_E
	return

;********************************************************************************

FN_FNLSR
;dim SysLongTempB as long
;SysLongTempB  = BitsIn
;Repeat NumBits
	movff	NUMBITS,SysRepeatTemp10
	movf	SYSREPEATTEMP10,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd10
SysRepeatLoop10
;Set C Off
	bcf	STATUS,C,ACCESS
;Rotate SysLongTempB Right
	rrcf	SYSLONGTEMPB_E,F,ACCESS
	rrcf	SYSLONGTEMPB_U,F,ACCESS
	rrcf	SYSLONGTEMPB_H,F,ACCESS
	rrcf	SYSLONGTEMPB,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp10,F,BANKED
	bra	SysRepeatLoop10
SysRepeatLoopEnd10
;FnLSR = SysLongTempB
	movff	SYSLONGTEMPB,FNLSR
	movff	SYSLONGTEMPB_H,FNLSR_H
	movff	SYSLONGTEMPB_U,FNLSR_U
	movff	SYSLONGTEMPB_E,FNLSR_E
	return

;********************************************************************************

FN_HEX
;Hex(0) = 2
	movlw	2
	banksel	SYSHEX_0
	movwf	SYSHEX_0,BANKED
;SysStringTemp = SysValTemp And 0x0F
	movlw	15
	banksel	SYSVALTEMP
	andwf	SYSVALTEMP,W,BANKED
	movwf	SYSSTRINGTEMP,BANKED
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	sublw	9
	btfsc	STATUS, C,ACCESS
	bra	ENDIF33
	movlw	7
	addwf	SYSSTRINGTEMP,F,BANKED
ENDIF33
;Hex(2) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W,BANKED
	banksel	SYSHEX_2
	movwf	SYSHEX_2,BANKED
;For SysStringTemp = 1 to 4
	banksel	SYSSTRINGTEMP
	clrf	SYSSTRINGTEMP,BANKED
SysForLoop2
	incf	SYSSTRINGTEMP,F,BANKED
;Rotate SysValTemp Right
	rrcf	SYSVALTEMP,F,BANKED
;Next
	movlw	4
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop2
SysForLoopEnd2
;SysStringTemp = SysValTemp And 0x0F
	movlw	15
	andwf	SYSVALTEMP,W,BANKED
	movwf	SYSSTRINGTEMP,BANKED
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	sublw	9
	btfsc	STATUS, C,ACCESS
	bra	ENDIF35
	movlw	7
	addwf	SYSSTRINGTEMP,F,BANKED
ENDIF35
;Hex(1) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W,BANKED
	banksel	SYSHEX_1
	movwf	SYSHEX_1,BANKED
	banksel	0
	return

;********************************************************************************

;Overloaded signature: STRING:byte:
HSERPRINT245
;PrintLen = PrintData(0)
	movff	SysPRINTDATAHandler,AFSR0
	movff	SysPRINTDATAHandler_H,AFSR0_H
	movff	INDF0,PRINTLEN
;If PrintLen <> 0 then
	movf	PRINTLEN,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF37
;for SysPrintTemp = 1 to PrintLen
	clrf	SYSPRINTTEMP,BANKED
	movlw	1
	subwf	PRINTLEN,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd3
SysForLoop3
	incf	SYSPRINTTEMP,F,BANKED
;HSerSend(PrintData(SysPrintTemp),comport )
	movf	SYSPRINTTEMP,W,BANKED
	addwf	SysPRINTDATAHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,SERDATA
	rcall	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;next
	movf	PRINTLEN,W,BANKED
	subwf	SYSPRINTTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop3
SysForLoopEnd3
;End If
ENDIF37
	return

;********************************************************************************

;Overloaded signature: BYTE:byte:
HSERPRINT246
;OutValueTemp = 0
	clrf	OUTVALUETEMP,BANKED
;IF SerPrintVal >= 100 Then
	movlw	100
	subwf	SERPRINTVAL,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	ENDIF40
;OutValueTemp = SerPrintVal / 100
	movff	SERPRINTVAL,SysBYTETempA
	movlw	100
	movwf	SysBYTETempB,ACCESS
	call	SysDivSub
	movff	SysBYTETempA,OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movff	SYSCALCTEMPX,SERPRINTVAL
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W,BANKED
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;End If
ENDIF40
;If OutValueTemp > 0 Or SerPrintVal >= 10 Then
	movff	OUTVALUETEMP,SysBYTETempB
	clrf	SysBYTETempA,ACCESS
	call	SysCompLessThan
	movff	SysByteTempX,SysTemp2
	movff	SERPRINTVAL,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movf	SysTemp2,W,BANKED
	iorwf	SysByteTempX,W,ACCESS
	movwf	SysTemp1,BANKED
	btfss	SysTemp1,0,BANKED
	bra	ENDIF41
;OutValueTemp = SerPrintVal / 10
	movff	SERPRINTVAL,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	call	SysDivSub
	movff	SysBYTETempA,OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movff	SYSCALCTEMPX,SERPRINTVAL
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W,BANKED
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;End If
ENDIF41
;HSerSend(SerPrintVal + 48 ,comport)
	movlw	48
	addwf	SERPRINTVAL,W,BANKED
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	goto	Delay_MS

;********************************************************************************

;Overloaded signature: WORD:byte:
HSERPRINT247
;Dim SysCalcTempX As Word
;OutValueTemp = 0
	clrf	OUTVALUETEMP,BANKED
;If SerPrintVal >= 10000 then
	movff	SERPRINTVAL,SysWORDTempA
	movff	SERPRINTVAL_H,SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB,ACCESS
	movlw	39
	movwf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF42
;OutValueTemp = SerPrintVal / 10000 [word]
	movff	SERPRINTVAL,SysWORDTempA
	movff	SERPRINTVAL_H,SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB,ACCESS
	movlw	39
	movwf	SysWORDTempB_H,ACCESS
	call	SysDivSub16
	movff	SysWORDTempA,OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movff	SYSCALCTEMPX,SERPRINTVAL
	movff	SYSCALCTEMPX_H,SERPRINTVAL_H
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W,BANKED
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;Goto HSerPrintWord1000
	bra	HSERPRINTWORD1000
;End If
ENDIF42
;If SerPrintVal >= 1000 then
	movff	SERPRINTVAL,SysWORDTempA
	movff	SERPRINTVAL_H,SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB,ACCESS
	movlw	3
	movwf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF43
HSERPRINTWORD1000
;OutValueTemp = SerPrintVal / 1000 [word]
	movff	SERPRINTVAL,SysWORDTempA
	movff	SERPRINTVAL_H,SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB,ACCESS
	movlw	3
	movwf	SysWORDTempB_H,ACCESS
	call	SysDivSub16
	movff	SysWORDTempA,OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movff	SYSCALCTEMPX,SERPRINTVAL
	movff	SYSCALCTEMPX_H,SERPRINTVAL_H
;HSerSend(OutValueTemp + 48 ,comport  )
	movlw	48
	addwf	OUTVALUETEMP,W,BANKED
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;Goto HSerPrintWord100
	bra	HSERPRINTWORD100
;End If
ENDIF43
;If SerPrintVal >= 100 then
	movff	SERPRINTVAL,SysWORDTempA
	movff	SERPRINTVAL_H,SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF44
HSERPRINTWORD100
;OutValueTemp = SerPrintVal / 100 [word]
	movff	SERPRINTVAL,SysWORDTempA
	movff	SERPRINTVAL_H,SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysDivSub16
	movff	SysWORDTempA,OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movff	SYSCALCTEMPX,SERPRINTVAL
	movff	SYSCALCTEMPX_H,SERPRINTVAL_H
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W,BANKED
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;Goto HSerPrintWord10
	bra	HSERPRINTWORD10
;End If
ENDIF44
;If SerPrintVal >= 10 then
	movff	SERPRINTVAL,SysWORDTempA
	movff	SERPRINTVAL_H,SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF45
HSERPRINTWORD10
;OutValueTemp = SerPrintVal / 10 [word]
	movff	SERPRINTVAL,SysWORDTempA
	movff	SERPRINTVAL_H,SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysDivSub16
	movff	SysWORDTempA,OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movff	SYSCALCTEMPX,SERPRINTVAL
	movff	SYSCALCTEMPX_H,SERPRINTVAL_H
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	addwf	OUTVALUETEMP,W,BANKED
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;End If
ENDIF45
;HSerSend(SerPrintVal + 48 ,comport  )
	movlw	48
	addwf	SERPRINTVAL,W,BANKED
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	goto	Delay_MS

;********************************************************************************

;Overloaded signature: LONG:byte:
HSERPRINT249
;Dim SysCalcTempA As Long
;Dim SysPrintBuffer(10)
;SysPrintBuffLen = 0
	clrf	SYSPRINTBUFFLEN,BANKED
;Do
SysDoLoop_S3
;SysPrintBuffLen += 1
	incf	SYSPRINTBUFFLEN,F,BANKED
;SysPrintBuffer(SysPrintBuffLen) = SerPrintVal % 10
	lfsr	0,SYSPRINTBUFFER
	movf	SYSPRINTBUFFLEN,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	SERPRINTVAL,SysLONGTempA
	movff	SERPRINTVAL_H,SysLONGTempA_H
	movff	SERPRINTVAL_U,SysLONGTempA_U
	movff	SERPRINTVAL_E,SysLONGTempA_E
	movlw	10
	movwf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	call	SysDivSub32
	movff	SysLONGTempX,INDF0
;SerPrintVal = SysCalcTempA
	movff	SYSCALCTEMPA,SERPRINTVAL
	movff	SYSCALCTEMPA_H,SERPRINTVAL_H
	movff	SYSCALCTEMPA_U,SERPRINTVAL_U
	movff	SYSCALCTEMPA_E,SERPRINTVAL_E
;Loop While SerPrintVal <> 0
	movff	serprintval,SysLONGTempA
	movff	serprintval_H,SysLONGTempA_H
	movff	serprintval_U,SysLONGTempA_U
	movff	serprintval_E,SysLONGTempA_E
	clrf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	call	SysCompEqual32
	comf	SysByteTempX,F,ACCESS
	btfsc	SysByteTempX,0,ACCESS
	bra	SysDoLoop_S3
SysDoLoop_E3
;For SysPrintTemp = SysPrintBuffLen To 1 Step -1
	incf	SYSPRINTBUFFLEN,W,BANKED
	movwf	SYSPRINTTEMP,BANKED
	movlw	1
	subwf	SYSPRINTBUFFLEN,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd4
SysForLoop4
	decf	SYSPRINTTEMP,F,BANKED
;HSerSend(SysPrintBuffer(SysPrintTemp) + 48, comport  )
	lfsr	0,SYSPRINTBUFFER
	movf	SYSPRINTTEMP,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	48
	addwf	INDF0,W,ACCESS
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;Next
	movf	SYSPRINTTEMP,W,BANKED
	sublw	1
	btfss	STATUS, C,ACCESS
	bra	SysForLoop4
SysForLoopEnd4
	return

;********************************************************************************

HSERPRINTCRLF
;repeat HSerPrintCRLFCount
	movff	HSERPRINTCRLFCOUNT,SysRepeatTemp7
	movf	SYSREPEATTEMP7,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd7
SysRepeatLoop7
;HSerSend(13,comport)
	movlw	13
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;Wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;HSerSend(10,comport)
	movlw	10
	movwf	SERDATA,BANKED
	rcall	HSERSEND
;wait USART_DELAY
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;end Repeat
	decfsz	SysRepeatTemp7,F,BANKED
	bra	SysRepeatLoop7
SysRepeatLoopEnd7
	return

;********************************************************************************

HSERSEND
;if comport = 1 Then
	decf	COMPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF36
;Wait While TXIF = Off
SysWaitLoop8
	btfss	PIR1,TXIF,ACCESS
	bra	SysWaitLoop8
;TXREG = SerData
	movff	SERDATA,TXREG
;end if
ENDIF36
	return

;********************************************************************************

HTTPPART3
;If Tcp_ack = 1 Then
	btfss	SYSBITVAR0,4,BANKED
	bra	ENDIF113
;If etherBuffer(17) = 0 Then
	banksel	SYSETHERBUFFER_17
	movf	SYSETHERBUFFER_17,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF114
;HSerPrint "Buffer(17) = 0 "
;If etherBuffer(18) = 40 Then
	movlw	40
	subwf	SYSETHERBUFFER_18,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF115
;HSerPrint "Buffer(18) = 40 "
;If Ackpsh = 1 Then
	banksel	ACKPSH
	decf	ACKPSH,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF116
;HSerPrint "(3)"
;HSerPrintCRLF
;'ACK after a ACK-PSH
;dim I_x, Tempword3 as word
;dim Tempword4 As Word
;'set flags
;Tcp_flags = 0
	banksel	SYSETHERBUFFER_48
	clrf	SYSETHERBUFFER_48,BANKED
;Tcp_flags.4  = 1                          'ack
	bsf	SYSETHERBUFFER_48,4,BANKED
;Tcp_flags.3  = 1                          'psh
	bsf	SYSETHERBUFFER_48,3,BANKED
;Tcp_flags.0  = 1                          'fin
	bsf	SYSETHERBUFFER_48,0,BANKED
;Tcp_acknum0 = Incoming_ack
	movff	INCOMING_ACK,SYSETHERBUFFER_46
;Tcp_acknum1 = Incoming_ack_H
	movff	INCOMING_ACK_H,SYSETHERBUFFER_45
;Tcp_acknum2 = Incoming_ack_U
	movff	INCOMING_ACK_U,SYSETHERBUFFER_44
;Tcp_acknum3 = Incoming_ack_E
	movff	INCOMING_ACK_E,SYSETHERBUFFER_43
;#define SizeofTable1 0x0100
;Tempword3 = 0x37 ' pointer to TCP data for HTTP
	movlw	55
	banksel	TEMPWORD3
	movwf	TEMPWORD3,BANKED
	clrf	TEMPWORD3_H,BANKED
;Tempword4 = 0x37
	movlw	55
	movwf	TEMPWORD4,BANKED
	clrf	TEMPWORD4_H,BANKED
;HSerPrint "SizeofTable1 = "
;HSerPrint SizeofTable1
;HSerPrintCRLF 2
;dim tt, countloop as word
;HSerPrint T_ip_destaddr0
	movff	SYSETHERBUFFER_31,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT246
;HSerPrint "."
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable51
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable51
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT245
;HSerPrint T_ip_destaddr1
	movff	SYSETHERBUFFER_32,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT246
;HSerPrint "."
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable51
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable51
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT245
;HSerPrint T_ip_destaddr2
	movff	SYSETHERBUFFER_33,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT246
;HSerPrint "."
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable51
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable51
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT245
;HSerPrint T_ip_destaddr3
	movff	SYSETHERBUFFER_34,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT246
;HSerPrint ":"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable38
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable38
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT245
;tt = Tcp_destportl + ( Tcp_destporth * 256)
	movff	SYSETHERBUFFER_37,SysWORDTempA
	clrf	SysWORDTempA_H,ACCESS
	clrf	SysWORDTempB,ACCESS
	movlw	1
	movwf	SysWORDTempB_H,ACCESS
	call	SysMultSub16
	movff	SysWORDTempX,SysTemp1
	movff	SysWORDTempX_H,SysTemp1_H
	movf	SysTemp1,W,BANKED
	banksel	SYSETHERBUFFER_38
	addwf	SYSETHERBUFFER_38,W,BANKED
	banksel	TT
	movwf	TT,BANKED
	clrf	SysTemp2,BANKED
	movf	SysTemp1_H,W,BANKED
	addwfc	SysTemp2,W,BANKED
	movwf	TT_H,BANKED
;HSerPrint tt
	movff	TT,SERPRINTVAL
	movff	TT_H,SERPRINTVAL_H
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT247
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF
;HSerPrint "-------------------------------------------------------------"
;HSerPrintCRLF
;countloop = 1
;for i_x = 1 to SizeofTable1 - 1
;ReadTable firstpage1, countloop , inbyte
;countloop = countloop + 1
;etherBuffer( Tempword4 ) = inbyte
;HSerPrint chr(inbyte)
;Tempword4 = Tempword4 + 1
;if Tempword4++ = etherBufferSize  Then
;HSerSend 7
;HSerPrint "Out of Buffer"
;HSerPrintCRLF
;end if
;next
;
;dim arrayloc,TableLoc as word
;arrayloc = 0x37
	movlw	55
	movwf	ARRAYLOC,BANKED
	clrf	ARRAYLOC_H,BANKED
;For TableLoc = 1 to SizeofTable1
	clrf	TABLELOC,BANKED
	clrf	TABLELOC_H,BANKED
SysForLoop11
	incf	TABLELOC,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	TABLELOC_H,F,BANKED
;ReadTable firstpage1, TableLoc, etherBuffer(arrayloc)
	lfsr	0,ETHERBUFFER
	movf	ARRAYLOC,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	TABLELOC,SYSSTRINGA
	rcall	FIRSTPAGE1
	movwf	INDF0,ACCESS
;HSerSend etherBuffer(arrayloc)
;arrayloc = arrayloc + 1
	incf	ARRAYLOC,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	ARRAYLOC_H,F,BANKED
;Next
	movff	TABLELOC,SysWORDTempA
	movff	TABLELOC_H,SysWORDTempA_H
	movlw	126
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop11
SysForLoopEnd11
;etherBuffer(arrayloc) = 0x0d
	lfsr	0,ETHERBUFFER
	movf	ARRAYLOC,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	13
	movwf	INDF0,ACCESS
;arrayloc = arrayloc + 1
	incf	ARRAYLOC,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	ARRAYLOC_H,F,BANKED
;etherBuffer(arrayloc) = 0x0a
	lfsr	0,ETHERBUFFER
	movf	ARRAYLOC,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	10
	movwf	INDF0,ACCESS
;arrayloc = arrayloc + 1
	incf	ARRAYLOC,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	ARRAYLOC_H,F,BANKED
;etherBuffer(arrayloc) = 0x0d
	lfsr	0,ETHERBUFFER
	movf	ARRAYLOC,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	13
	movwf	INDF0,ACCESS
;arrayloc = arrayloc + 1
	incf	ARRAYLOC,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	ARRAYLOC_H,F,BANKED
;etherBuffer(arrayloc) = 0x0a
	lfsr	0,ETHERBUFFER
	movf	ARRAYLOC,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movlw	10
	movwf	INDF0,ACCESS
;dim TCPresult16 as word
;TCPresult16 = [word]SizeofTable1 + 40 + 4
	movlw	170
	movwf	TCPRESULT16,BANKED
	clrf	TCPRESULT16_H,BANKED
;HSerPrint "TCP Packet = "
;HSerPrint TCPresult16
;HSerPrintCRLF
;HSerPrintCRLF
;HSerPrint "-------------------------------------------------------------"
;HSerPrintCRLF 2
;T_ip_pktlen0 = TCPresult16_H                             'HTML-code + 40
	movff	TCPRESULT16_H,SYSETHERBUFFER_17
;T_ip_pktlen1 = TCPresult16
	movff	TCPRESULT16,SYSETHERBUFFER_18
;ENC28j60_ip_header_checksum
	call	ENC28J60_IP_HEADER_CHECKSUM
;ENC28j60_tcp_checksum
	call	ENC28J60_TCP_CHECKSUM
;if showt = 0 then
;
;HSerPrintCRLF
;For I_x = 0x37 To Tempword3 + SizeofTable1
;HSerPrint chr(etherbuffer(I_x))
;Next
;HSerPrintCRLF
;showt=1
;end if
;ENC28j60_writebuffer( TCPresult16 + 14   )
	movlw	14
	addwf	TCPRESULT16,W,BANKED
	movwf	PCKTLEN,BANKED
	movlw	0
	addwfc	TCPRESULT16_H,W,BANKED
	movwf	PCKTLEN_H,BANKED
	rcall	ENC28J60_WRITEBUFFER
;ENC28j60_packetsend( TCPresult16 + 14   )
	movlw	14
	addwf	TCPRESULT16,W,BANKED
	movwf	PCKTLEN,BANKED
	movlw	0
	addwfc	TCPRESULT16_H,W,BANKED
	movwf	PCKTLEN_H,BANKED
	call	ENC28J60_PACKETSEND
;End If
ENDIF116
;End If
ENDIF115
;End If
ENDIF114
;Ackpsh = 0
	banksel	ACKPSH
	clrf	ACKPSH,BANKED
;End If
ENDIF113
	return

;********************************************************************************

I2CRESTART
;I2CStart
	bra	I2CSTART

;********************************************************************************

I2CSEND
;I2C_CLOCK_LOW                 'begin with SCL=0
	bcf	TRISB,0,ACCESS
	bcf	LATB,0,ACCESS
;wait I2C_END_DELAY            'let port settle
	movlw	1
	movwf	DELAYTEMP,ACCESS
DelayUS5
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS5
	nop
;repeat 8                      '8 data bits
	movlw	8
	movwf	SysRepeatTemp8,BANKED
SysRepeatLoop8
;if I2CByte.7 = ON then      'put most significant bit on SDA line
	btfss	I2CBYTE,7,BANKED
	bra	ELSE48_1
;I2C_DATA_HIGH
	bsf	TRISC,4,ACCESS
;else
	bra	ENDIF48
ELSE48_1
;I2C_DATA_LOW
	bcf	TRISC,4,ACCESS
	bcf	LATC,4,ACCESS
;end if
ENDIF48
;rotate I2CByte left         'shift in bit for the next time
	rlcf	I2CBYTE,F,BANKED
;I2C_CLOCK_HIGH              'now clock it in
	bsf	TRISB,0,ACCESS
;wait while I2C_CLOCK = OFF  'permit clock stretching here
SysWaitLoop9
	btfss	PORTB,0,ACCESS
	bra	SysWaitLoop9
;wait I2C_CLOCK_DELAY        'clock pulse width given here
	movlw	1
	movwf	DELAYTEMP,ACCESS
DelayUS6
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS6
	nop
;I2C_CLOCK_LOW               'done clocking that bit
	bcf	TRISB,0,ACCESS
	bcf	LATB,0,ACCESS
;wait I2C_END_DELAY          'time between clock pulses
	movlw	1
	movwf	DELAYTEMP,ACCESS
DelayUS7
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS7
	nop
;end repeat                    'then do next bit
	decfsz	SysRepeatTemp8,F,BANKED
	bra	SysRepeatLoop8
SysRepeatLoopEnd8
;wait I2C_BIT_DELAY            'pad timing just a little
	movlw	3
	movwf	DELAYTEMP,ACCESS
DelayUS8
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS8
;I2C_DATA_HIGH                 'idle SDA to let Slave respond
	bsf	TRISC,4,ACCESS
;wait I2C_END_DELAY            'let SDA port line settle
	movlw	1
	movwf	DELAYTEMP,ACCESS
DelayUS9
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS9
	nop
;I2C_CLOCK_HIGH                'clock for the ACK/NAK bit
	bsf	TRISB,0,ACCESS
;wait while I2C_CLOCK = OFF    'permit clock stretching here
SysWaitLoop10
	btfss	PORTB,0,ACCESS
	bra	SysWaitLoop10
;if I2C_DATA then              'read 9th bit in from Slave
	btfss	PORTC,4,ACCESS
	bra	ELSE49_1
;I2CAck = FALSE              'return a NAK to the program
	clrf	I2CACK,BANKED
;I2CSendState =  FALSE        'state of target device with respect. Retained for backwards compatibility
	clrf	I2CACKPOLLSTATE,BANKED
;else
	bra	ENDIF49
ELSE49_1
;I2CAck = TRUE               'else, return an ACK to the program
	setf	I2CACK,BANKED
;I2CSendState =  TRUE        'state of target device with respect. Retained for backwards compatibility
	setf	I2CACKPOLLSTATE,BANKED
;end if
ENDIF49
;I2C_CLOCK_LOW                 'may be more bytes to clock out
	bcf	TRISB,0,ACCESS
	bcf	LATB,0,ACCESS
;wait I2C_END_DELAY            'so keep idling both
	movlw	1
	movwf	DELAYTEMP,ACCESS
DelayUS10
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS10
	nop
;I2C_DATA_LOW                  'SCL and SDA low
	bcf	TRISC,4,ACCESS
	bcf	LATC,4,ACCESS
;wait I2C_BIT_DELAY            'wait the usual bit length
	movlw	3
	movwf	DELAYTEMP,ACCESS
DelayUS11
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS11
	return

;********************************************************************************

I2CSTART
;I2C_DATA_HIGH                 'SDA and SCL idle high
	bsf	TRISC,4,ACCESS
;I2C_CLOCK_HIGH
	bsf	TRISB,0,ACCESS
;wait I2C_END_DELAY            'let settle a while
	movlw	1
	movwf	DELAYTEMP,ACCESS
DelayUS12
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS12
	nop
;I2C_DATA_LOW                  'then, SDA low while SCL still high
	bcf	TRISC,4,ACCESS
	bcf	LATC,4,ACCESS
;wait I2C_CLOCK_DELAY          'for this amount of time
	movlw	1
	movwf	DELAYTEMP,ACCESS
DelayUS13
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS13
	nop
;I2C_CLOCK_LOW                 'end with SCL low, ready to clock
	bcf	TRISB,0,ACCESS
	bcf	LATB,0,ACCESS
	return

;********************************************************************************

I2CSTOP
;I2C_CLOCK_LOW                 'begin with SCL=0 and SDA=0
	bcf	TRISB,0,ACCESS
	bcf	LATB,0,ACCESS
;I2C_DATA_LOW
	bcf	TRISC,4,ACCESS
	bcf	LATC,4,ACCESS
;wait I2C_END_DELAY            'let ports settle
	movlw	1
	movwf	DELAYTEMP,ACCESS
DelayUS2
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS2
	nop
;I2C_CLOCK_HIGH                'make SCL=1 first
	bsf	TRISB,0,ACCESS
;wait I2C_CLOCK_DELAY          'hold for normal clock width time
	movlw	1
	movwf	DELAYTEMP,ACCESS
DelayUS3
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS3
	nop
;I2C_DATA_HIGH                 'then make SDA=1 afterwards
	bsf	TRISC,4,ACCESS
;wait I2C_END_DELAY            'hold for normal between-time
	movlw	1
	movwf	DELAYTEMP,ACCESS
DelayUS4
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS4
	nop
	return

;********************************************************************************

INITI2C
;dim I2COldState, I2CState, I2CMatch, I2CTemp as byte
;dim I2CCount alias I2CState
;I2C_DATA_HIGH                   'release SDA (open drain floats high)
	bsf	TRISC,4,ACCESS
;I2C_CLOCK_HIGH                  'release SCL (open drain floats high)
	bsf	TRISB,0,ACCESS
;I2CMatch = FALSE                'address doesn't match (Slave mode)
	clrf	I2CMATCH,BANKED
	return

;********************************************************************************

INITI2CLCD
;wait 15 ms
	movlw	15
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;LCDWriteByte 0x03: wait 5 ms
	movlw	3
	movwf	LCDBYTE,BANKED
	rcall	LCDNORMALWRITEBYTE
	movlw	5
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;LCDWriteByte 0x03: wait 1 ms
	movlw	3
	movwf	LCDBYTE,BANKED
	rcall	LCDNORMALWRITEBYTE
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;LCDWriteByte 0x03: wait 1 ms
	movlw	3
	movwf	LCDBYTE,BANKED
	rcall	LCDNORMALWRITEBYTE
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;LCDWriteByte 0x03: wait 1 ms
	movlw	3
	movwf	LCDBYTE,BANKED
	rcall	LCDNORMALWRITEBYTE
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;LCDWriteByte 0x02: wait 1 ms
	movlw	2
	movwf	LCDBYTE,BANKED
	rcall	LCDNORMALWRITEBYTE
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;LCDWriteByte 0x28: wait 1 ms
	movlw	40
	movwf	LCDBYTE,BANKED
	rcall	LCDNORMALWRITEBYTE
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;LCDWriteByte 0x0c: wait 1 ms
	movlw	12
	movwf	LCDBYTE,BANKED
	rcall	LCDNORMALWRITEBYTE
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;LCDWriteByte 0x01: wait 15 ms
	movlw	1
	movwf	LCDBYTE,BANKED
	rcall	LCDNORMALWRITEBYTE
	movlw	15
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;LCDWriteByte 0x06: wait 1 ms
	movlw	6
	movwf	LCDBYTE,BANKED
	rcall	LCDNORMALWRITEBYTE
	movlw	1
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;CLS
	goto	CLS

;********************************************************************************

INITLCD
;InitI2C       ;call to init i2c is required here!
	rcall	INITI2C
;LCD_Backlight = LCD_Backlight_On_State
	movlw	1
	movwf	LCD_BACKLIGHT,BANKED
;wait 2 ms
	movlw	2
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;repeat 2	; called to ensure reset is complete.  Needed for cheap LCDs!!
	movlw	2
	movwf	SysRepeatTemp6,BANKED
SysRepeatLoop6
;LCD_I2C_Address_Current = LCD_I2C_Address_1
	movlw	78
	movwf	LCD_I2C_ADDRESS_CURRENT,BANKED
;initI2CLCD
	rcall	INITI2CLCD
;end repeat
	decfsz	SysRepeatTemp6,F,BANKED
	bra	SysRepeatLoop6
SysRepeatLoopEnd6
;LCD_State = 12
	movlw	12
	movwf	LCD_STATE,BANKED
	return

;********************************************************************************

INITSYS
;BSR = 0
	clrf	BSR,ACCESS
;TBLPTRU = 0
	clrf	TBLPTRU,ACCESS
;SET ADFM OFF
	bcf	ADCON2,ADFM,ACCESS
;SET ADCON0.ADON OFF
	bcf	ADCON0,ADON,ACCESS
;SET PCFG3 ON
	bsf	ADCON1,PCFG3,ACCESS
;SET PCFG2 ON
	bsf	ADCON1,PCFG2,ACCESS
;SET PCFG1 ON
	bsf	ADCON1,PCFG1,ACCESS
;SET PCFG0 ON
	bsf	ADCON1,PCFG0,ACCESS
;CMCON = 7
	movlw	7
	movwf	CMCON,ACCESS
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
	return

;********************************************************************************

INITUSART
;comport = 1
	movlw	1
	movwf	COMPORT,BANKED
;SPBRG = SPBRGL_TEMP
	movlw	7
	movwf	SPBRG,ACCESS
;SPBRGH = SPBRGH_TEMP
	movlw	2
	movwf	SPBRGH,ACCESS
;BRG16 = BRG16_TEMP
	bsf	BAUDCON,BRG16,ACCESS
;BRGH = BRGH_TEMP
	bsf	TXSTA,BRGH,ACCESS
;Set SYNC Off
	bcf	TXSTA,SYNC,ACCESS
;Set SPEN On
	bsf	RCSTA,SPEN,ACCESS
;Set CREN On
	bsf	RCSTA,CREN,ACCESS
;Set TXEN On
	bsf	TXSTA,TXEN,ACCESS
;PIC USART 2 Init
	return

;********************************************************************************

LCDNORMALWRITEBYTE
;*****    This subroutine  modified by William Roth *****
;Reduced enable pulse to 2 us
;Added define for LCD_SPEED Slow , Medium , fast
;IF LCD_RS = 1 then
	btfss	SYSLCDTEMP,1,BANKED
	bra	ELSE19_1
;i2c_lcd_rs=1;   ''' Data
	bsf	I2C_LCD_BYTE,0,BANKED
;ELSE
	bra	ENDIF19
ELSE19_1
;i2c_lcd_rs=0;   ''' Command
	bcf	I2C_LCD_BYTE,0,BANKED
;end if
ENDIF19
;i2c_lcd_rw  = 0;
	bcf	I2C_LCD_BYTE,1,BANKED
;i2c_lcd_bl  = LCD_Backlight.0;
	bcf	I2C_LCD_BYTE,3,BANKED
	btfsc	LCD_BACKLIGHT,0,BANKED
	bsf	I2C_LCD_BYTE,3,BANKED
;I2CReStart
	rcall	I2CRESTART
;I2CSend LCD_I2C_Address_Current
	movff	LCD_I2C_ADDRESS_CURRENT,I2CBYTE
	rcall	I2CSEND
;i2c_lcd_d7 = LCDByte.7
	bcf	I2C_LCD_BYTE,7,BANKED
	btfsc	LCDBYTE,7,BANKED
	bsf	I2C_LCD_BYTE,7,BANKED
;i2c_lcd_d6 = LCDByte.6
	bcf	I2C_LCD_BYTE,6,BANKED
	btfsc	LCDBYTE,6,BANKED
	bsf	I2C_LCD_BYTE,6,BANKED
;i2c_lcd_d5 = LCDByte.5
	bcf	I2C_LCD_BYTE,5,BANKED
	btfsc	LCDBYTE,5,BANKED
	bsf	I2C_LCD_BYTE,5,BANKED
;i2c_lcd_d4 = LCDByte.4
	bcf	I2C_LCD_BYTE,4,BANKED
	btfsc	LCDBYTE,4,BANKED
	bsf	I2C_LCD_BYTE,4,BANKED
;i2c_lcd_e = 0;
	bcf	I2C_LCD_BYTE,2,BANKED
;I2CSend i2c_lcd_byte
	movff	I2C_LCD_BYTE,I2CBYTE
	rcall	I2CSEND
;i2c_lcd_e = 1;
	bsf	I2C_LCD_BYTE,2,BANKED
;I2CSend i2c_lcd_byte
	movff	I2C_LCD_BYTE,I2CBYTE
	rcall	I2CSEND
;i2c_lcd_e = 0;
	bcf	I2C_LCD_BYTE,2,BANKED
;I2CSend i2c_lcd_byte
	movff	I2C_LCD_BYTE,I2CBYTE
	rcall	I2CSEND
;i2c_lcd_d7 = LCDByte.3
	bcf	I2C_LCD_BYTE,7,BANKED
	btfsc	LCDBYTE,3,BANKED
	bsf	I2C_LCD_BYTE,7,BANKED
;i2c_lcd_d6 = LCDByte.2
	bcf	I2C_LCD_BYTE,6,BANKED
	btfsc	LCDBYTE,2,BANKED
	bsf	I2C_LCD_BYTE,6,BANKED
;i2c_lcd_d5 = LCDByte.1
	bcf	I2C_LCD_BYTE,5,BANKED
	btfsc	LCDBYTE,1,BANKED
	bsf	I2C_LCD_BYTE,5,BANKED
;i2c_lcd_d4 = LCDByte.0
	bcf	I2C_LCD_BYTE,4,BANKED
	btfsc	LCDBYTE,0,BANKED
	bsf	I2C_LCD_BYTE,4,BANKED
;i2c_lcd_e = 0;
	bcf	I2C_LCD_BYTE,2,BANKED
;I2CSend i2c_lcd_byte
	movff	I2C_LCD_BYTE,I2CBYTE
	rcall	I2CSEND
;i2c_lcd_e = 1;
	bsf	I2C_LCD_BYTE,2,BANKED
;I2CSend i2c_lcd_byte
	movff	I2C_LCD_BYTE,I2CBYTE
	rcall	I2CSEND
;i2c_lcd_e = 0;
	bcf	I2C_LCD_BYTE,2,BANKED
;I2CSend i2c_lcd_byte
	movff	I2C_LCD_BYTE,I2CBYTE
	rcall	I2CSEND
;I2CStop
	rcall	I2CSTOP
;LCD_State = 12
	movlw	12
	movwf	LCD_STATE,BANKED
;wait fast_us us
	movlw	16
	movwf	DELAYTEMP,ACCESS
DelayUS1
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS1
	nop
;IF LCDByte < 16 then
	movlw	16
	subwf	LCDBYTE,W,BANKED
	btfsc	STATUS, C,ACCESS
	bra	ENDIF20
;if LCDByte > 7 then
	movf	LCDBYTE,W,BANKED
	sublw	7
	btfss	STATUS, C,ACCESS
;LCD_State = LCDByte
	movff	LCDBYTE,LCD_STATE
;end if
;END IF
ENDIF20
	return

;********************************************************************************

LOCATE
;Set LCD_RS Off
	bcf	SYSLCDTEMP,1,BANKED
;If LCDLine > 1 Then
	movf	LCDLINE,W,BANKED
	sublw	1
	btfsc	STATUS, C,ACCESS
	bra	ENDIF15
;LCDLine = LCDLine - 2
	movlw	2
	subwf	LCDLINE,F,BANKED
;LCDColumn = LCDColumn + 20
	movlw	20
	addwf	LCDCOLUMN,F,BANKED
;End If
ENDIF15
;LCDWriteByte(0x80 or 0x40 * LCDLine + LCDColumn)
	movf	LCDLINE,W,BANKED
	mullw	64
	movf	LCDCOLUMN,W,BANKED
	addwf	PRODL,W,ACCESS
	movwf	SysTemp2,BANKED
	movlw	128
	iorwf	SysTemp2,W,BANKED
	movwf	LCDBYTE,BANKED
	rcall	LCDNORMALWRITEBYTE
;wait 5 10us 'test
	movlw	5
	movwf	SysWaitTemp10US,ACCESS
	goto	Delay_10US

;********************************************************************************

MY_UDP_HANDLER
;dim I_x as word
;
;;        Calcualte UDP packet length
;I_value16_h = T_udp_len0
;[byte]I_value16 = T_udp_len1
;I_value16 = I_value16 - 8
;
;For I_x = T_udp_data_pointer To ( T_udp_data_pointer + I_value16 - 1 )
;HSerPrint i_x
;HSerPrint "."
;Next
;HSerPrintCRLF
;
;For I_x = T_udp_data_pointer To ( T_udp_data_pointer + I_value16 - 1 )
;HSerPrint hex(etherbuffer(i_x))
;HSerPrint ":"
;Next
;HSerPrintCRLF
;
;For I_x = T_udp_data_pointer To ( T_udp_data_pointer + I_value16 - 1 )
;HSerPrint chr(etherbuffer(i_x))
;HSerPrint ","
;Next
;HSerPrintCRLF
;HSerPrint " -----------------------------------------------"
;HSerPrintCRLF
;select case T_udp_destport
;case 6000
SysSelect5Case1
	movff	T_UDP_DESTPORT,SysWORDTempA
	movff	T_UDP_DESTPORT_H,SysWORDTempA_H
	movlw	112
	movwf	SysWORDTempB,ACCESS
	movlw	23
	movwf	SysWORDTempB_H,ACCESS
	rcall	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect5Case2
;if T_udp_data = "R" then
	movlw	82
	banksel	SYSETHERBUFFER_43
	subwf	SYSETHERBUFFER_43,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF92
;ENC28j60_Initialise
	banksel	0
	call	ENC28J60_INITIALISE
;goto Reset_ENC26j60
	goto	RESET_ENC26J60
;end if
ENDIF92
;if T_udp_data = "D" then
	movlw	68
	subwf	SYSETHERBUFFER_43,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF93
;ENC28j60_regdump
	banksel	0
	call	ENC28J60_REGDUMP
;end if
ENDIF93
;case 5000
	bra	SysSelectEnd5
SysSelect5Case2
	movff	T_UDP_DESTPORT,SysWORDTempA
	movff	T_UDP_DESTPORT_H,SysWORDTempA_H
	movlw	136
	movwf	SysWORDTempB,ACCESS
	movlw	19
	movwf	SysWORDTempB_H,ACCESS
	rcall	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect5Case3
;Select Case T_udp_data
;CASE "T"
SysSelect6Case1
	movlw	84
	banksel	SYSETHERBUFFER_43
	subwf	SYSETHERBUFFER_43,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case2
;HserPrint "Time...": HSerPrintCRLF
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable14
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable14
	movwf	TBLPTRH,ACCESS
	banksel	0
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT245
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF
;ENC28j60_sntp_get
	call	ENC28J60_SNTP_GET
;End Select
SysSelect6Case2
SysSelectEnd6
;case 5002
	bra	SysSelectEnd5
SysSelect5Case3
	movff	T_UDP_DESTPORT,SysWORDTempA
	movff	T_UDP_DESTPORT_H,SysWORDTempA_H
	movlw	138
	movwf	SysWORDTempB,ACCESS
	movlw	19
	movwf	SysWORDTempB_H,ACCESS
	rcall	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect5Case4
;I_value16_h = T_udp_len0
	movff	SYSETHERBUFFER_39,I_VALUE16_H
;[byte]I_value16 = T_udp_len1
	movff	SYSETHERBUFFER_40,I_VALUE16
;I_value16 = I_value16 - 8
	movlw	8
	subwf	I_VALUE16,F,ACCESS
	movlw	0
	subwfb	I_VALUE16_H,F,ACCESS
;If  I_value16 = 2  then 'LCD Command
	movff	I_VALUE16,SysWORDTempA
	movff	I_VALUE16_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE94_1
;select case T_udp_data0
;case 0
SysSelect7Case1
	banksel	SYSETHERBUFFER_43
	movf	SYSETHERBUFFER_43,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect7Case2
;Cls
	banksel	0
	call	CLS
;case 1
	bra	SysSelectEnd7
SysSelect7Case2
	decf	SYSETHERBUFFER_43,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect7Case3
;Locate (0,0)
	banksel	LCDLINE
	clrf	LCDLINE,BANKED
	clrf	LCDCOLUMN,BANKED
	rcall	LOCATE
;Print "locate 1,0"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable15
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable15
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	rcall	PRINT113
;case 2
	bra	SysSelectEnd7
SysSelect7Case3
	movlw	2
	subwf	SYSETHERBUFFER_43,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect7Case4
;Locate (1,0)
	movlw	1
	banksel	LCDLINE
	movwf	LCDLINE,BANKED
	clrf	LCDCOLUMN,BANKED
	rcall	LOCATE
;Print "locate 2,0"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable16
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable16
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	rcall	PRINT113
;case 3
	bra	SysSelectEnd7
SysSelect7Case4
	movlw	3
	subwf	SYSETHERBUFFER_43,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect7Case5
;Locate (2,0)
	movlw	2
	banksel	LCDLINE
	movwf	LCDLINE,BANKED
	clrf	LCDCOLUMN,BANKED
	rcall	LOCATE
;Print "locate 3,0"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable17
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable17
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	rcall	PRINT113
;case 4
	bra	SysSelectEnd7
SysSelect7Case5
	movlw	4
	subwf	SYSETHERBUFFER_43,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect7Case6
;Locate (3,0)
	movlw	3
	banksel	LCDLINE
	movwf	LCDLINE,BANKED
	clrf	LCDCOLUMN,BANKED
	rcall	LOCATE
;Print "locate 4,0"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable18
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable18
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	rcall	PRINT113
;end select
SysSelect7Case6
SysSelectEnd7
;else
	bra	ENDIF94
ELSE94_1
;		CLS
	call	CLS
;Locate (0,0)
	clrf	LCDLINE,BANKED
	clrf	LCDCOLUMN,BANKED
	rcall	LOCATE
;Print "Print "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable19
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable19
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	rcall	PRINT113
;Print chr(T_udp_data0)
	movff	SYSETHERBUFFER_43,SYSCHAR
	call	FN_CHR
	movlw	low CHR
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high CHR
	movwf	SysPRINTDATAHandler_H,BANKED
	rcall	PRINT113
;End If
ENDIF94
;LCD Control on PORT 5002
;if  I_value16 = 2  then 'LCD Command
	movff	I_VALUE16,SysWORDTempA
	movff	I_VALUE16_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	rcall	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE95_1
;select case T_udp_data0
;case 0
SysSelect8Case1
	banksel	SYSETHERBUFFER_43
	movf	SYSETHERBUFFER_43,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect8Case2
;HSerPrint "CLS"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable20
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable20
	movwf	TBLPTRH,ACCESS
	banksel	0
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT245
;case 1
	bra	SysSelectEnd8
SysSelect8Case2
	decf	SYSETHERBUFFER_43,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect8Case3
;HSerPrint "locate 1,0"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable15
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable15
	movwf	TBLPTRH,ACCESS
	banksel	0
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT245
;case 2
	bra	SysSelectEnd8
SysSelect8Case3
	movlw	2
	subwf	SYSETHERBUFFER_43,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect8Case4
;HSerPrint "locate 2,0"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable16
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable16
	movwf	TBLPTRH,ACCESS
	banksel	0
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT245
;case 3
	bra	SysSelectEnd8
SysSelect8Case4
	movlw	3
	subwf	SYSETHERBUFFER_43,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect8Case5
;HSerPrint "locate 3,0"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable17
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable17
	movwf	TBLPTRH,ACCESS
	banksel	0
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT245
;case 4
	bra	SysSelectEnd8
SysSelect8Case5
	movlw	4
	subwf	SYSETHERBUFFER_43,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect8Case6
;HSerPrint "locate 4,0"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable18
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable18
	movwf	TBLPTRH,ACCESS
	banksel	0
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT245
;end select
SysSelect8Case6
SysSelectEnd8
;HSerPrintCRLF
	movlw	1
	banksel	HSERPRINTCRLFCOUNT
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF
;else
	bra	ENDIF95
ELSE95_1
;HSerprint "Print "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable19
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable19
	movwf	TBLPTRH,ACCESS
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT245
;HSerSend T_udp_data0
	movff	SYSETHERBUFFER_43,SERDATA
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERSEND
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF
;end if
ENDIF95
;end select
SysSelect5Case4
SysSelectEnd5
	banksel	0
	return

;********************************************************************************

;Overloaded signature: STRING:
PRINT113
;PrintLen = PrintData(0)
	movff	SysPRINTDATAHandler,AFSR0
	movff	SysPRINTDATAHandler_H,AFSR0_H
	movff	INDF0,PRINTLEN
;If PrintLen = 0 Then Exit Sub
	movf	PRINTLEN,F,BANKED
	btfsc	STATUS, Z,ACCESS
	return
;Set LCD_RS On
	bsf	SYSLCDTEMP,1,BANKED
;For SysPrintTemp = 1 To PrintLen
	clrf	SYSPRINTTEMP,BANKED
	movlw	1
	subwf	PRINTLEN,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd1
SysForLoop1
	incf	SYSPRINTTEMP,F,BANKED
;	LCDWriteByte PrintData(SysPrintTemp)
	movf	SYSPRINTTEMP,W,BANKED
	addwf	SysPRINTDATAHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,LCDBYTE
	rcall	LCDNORMALWRITEBYTE
;Next
	movf	PRINTLEN,W,BANKED
	subwf	SYSPRINTTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop1
SysForLoopEnd1
	return

;********************************************************************************

;Overloaded signature: BYTE:BYTE:
SPIMODE201
;Set SSPCON1.SSPEN Off ;(Prevents any weird glitches during setup)
	bcf	SSPCON1,SSPEN,ACCESS
;Set SSPSTAT.SMP Off
	bcf	SSPSTAT,SMP,ACCESS
;Set SSPSTAT.CKE Off
	bcf	SSPSTAT,CKE,ACCESS
;If SPIClockMode.0 = Off Then
	btfss	SPICLOCKMODE,0,BANKED
;Set SSPSTAT.CKE On
	bsf	SSPSTAT,CKE,ACCESS
;End If
;Set SSPCON1.CKP Off
	bcf	SSPCON1,CKP,ACCESS
;If SPIClockMode.1 = On Then
	btfsc	SPICLOCKMODE,1,BANKED
;Set SSPCON1.CKP On
	bsf	SSPCON1,CKP,ACCESS
;End If
;Set SSPCON1.SSPM3 Off
	bcf	SSPCON1,SSPM3,ACCESS
;Set SSPCON1.SSPM2 Off
	bcf	SSPCON1,SSPM2,ACCESS
;Set SSPCON1.SSPM1 Off
	bcf	SSPCON1,SSPM1,ACCESS
;Set SSPCON1.SSPM0 Off
	bcf	SSPCON1,SSPM0,ACCESS
;Select Case SPICurrentMode
;Case MasterFast
SysSelect2Case1
	movlw	13
	subwf	SPICURRENTMODE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case2
;Case Master
	bra	SysSelectEnd2
SysSelect2Case2
	movlw	12
	subwf	SPICURRENTMODE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case3
;Set SSPCON1.SSPM0 On
	bsf	SSPCON1,SSPM0,ACCESS
;Case MasterSlow
	bra	SysSelectEnd2
SysSelect2Case3
	movlw	11
	subwf	SPICURRENTMODE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case4
;Set SSPCON1.SSPM1 On
	bsf	SSPCON1,SSPM1,ACCESS
;Case Slave
	bra	SysSelectEnd2
SysSelect2Case4
	movf	SPICURRENTMODE,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case5
;Set SSPCON1.SSPM2 On
	bsf	SSPCON1,SSPM2,ACCESS
;Set SSPCON1.SSPM0 On
	bsf	SSPCON1,SSPM0,ACCESS
;Case SlaveSS
	bra	SysSelectEnd2
SysSelect2Case5
	decf	SPICURRENTMODE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case6
;Set SSPCON1.SSPM2 On
	bsf	SSPCON1,SSPM2,ACCESS
;End Select
SysSelect2Case6
SysSelectEnd2
;Set SSPCON1.SSPEN On
	bsf	SSPCON1,SSPEN,ACCESS
	return

;********************************************************************************

;Overloaded signature: BYTE:BYTE:
SWAP85
;SysCalcTempX = SysCalcTempA
	movff	SYSCALCTEMPA,SYSCALCTEMPX
;SysCalcTempA = SysCalcTempB
	movff	SYSCALCTEMPB,SYSCALCTEMPA
;SysCalcTempB = SysCalcTempX
	movff	SYSCALCTEMPX,SYSCALCTEMPB
	return

;********************************************************************************

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

SYSCOMPEQUAL16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
;movf SysWordTempB, W
	movf	SYSWORDTEMPB, W,ACCESS
;cpfseq SysWordTempA
	cpfseq	SYSWORDTEMPA,ACCESS
;return
	return
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

SYSCOMPEQUAL32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
;movf SysLongTempB, W
	movf	SYSLONGTEMPB, W,ACCESS
;cpfseq SysLongTempA
	cpfseq	SYSLONGTEMPA,ACCESS
;return
	return
;movf SysLongTempB_H, W
	movf	SYSLONGTEMPB_H, W,ACCESS
;cpfseq SysLongTempA_H
	cpfseq	SYSLONGTEMPA_H,ACCESS
;return
	return
;movf SysLongTempB_U, W
	movf	SYSLONGTEMPB_U, W,ACCESS
;cpfseq SysLongTempA_U
	cpfseq	SYSLONGTEMPA_U,ACCESS
;return
	return
;movf SysLongTempB_E, W
	movf	SYSLONGTEMPB_E, W,ACCESS
;cpfseq SysLongTempA_E
	cpfseq	SYSLONGTEMPA_E,ACCESS
;return
	return
;setf SysByteTempX
	setf	SYSBYTETEMPX,ACCESS
	return

;********************************************************************************

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

SYSCOMPLESSTHAN16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
;movf SysWordTempA_H,W
	movf	SYSWORDTEMPA_H,W,ACCESS
;subwf SysWordTempB_H,W
	subwf	SYSWORDTEMPB_H,W,ACCESS
;btfss STATUS,C
	btfss	STATUS,C,ACCESS
;return
	return
;movf SysWordTempB_H,W
	movf	SYSWORDTEMPB_H,W,ACCESS
;subwf SysWordTempA_H,W
	subwf	SYSWORDTEMPA_H,W,ACCESS
;bnc SCLT16True
	bnc	SCLT16TRUE
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

SYSCOMPLESSTHAN32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
;movf SysLongTempA_E,W
	movf	SYSLONGTEMPA_E,W,ACCESS
;subwf SysLongTempB_E,W
	subwf	SYSLONGTEMPB_E,W,ACCESS
;btfss STATUS,C
	btfss	STATUS,C,ACCESS
;return
	return
;bnz SCLT32True
	bnz	SCLT32TRUE
;movf SysLongTempA_U,W
	movf	SYSLONGTEMPA_U,W,ACCESS
;subwf SysLongTempB_U,W
	subwf	SYSLONGTEMPB_U,W,ACCESS
;btfss STATUS,C
	btfss	STATUS,C,ACCESS
;return
	return
;bnz SCLT32True
	bnz	SCLT32TRUE
;movf SysLongTempA_H,W
	movf	SYSLONGTEMPA_H,W,ACCESS
;subwf SysLongTempB_H,W
	subwf	SYSLONGTEMPB_H,W,ACCESS
;btfss STATUS,C
	btfss	STATUS,C,ACCESS
;return
	return
;bnz SCLT32True
	bnz	SCLT32TRUE
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

SYSCOPYSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;movff INDF0, SysCalcTempA
	movff	INDF0, SYSCALCTEMPA
;movff SysCalcTempA, INDF1
	movff	SYSCALCTEMPA, INDF1
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
;movf SysCalcTempA,F
	movf	SYSCALCTEMPA,F,ACCESS
;btfsc STATUS,Z
	btfsc	STATUS,Z,ACCESS
;return
	return
SYSSTRINGCOPY
;movff PREINC0, PREINC1
	movff	PREINC0, PREINC1
;decfsz SysCalcTempA, F
	decfsz	SYSCALCTEMPA, F,ACCESS
;goto SysStringCopy
	bra	SYSSTRINGCOPY
	return

;********************************************************************************

SYSDIVSUB
;dim SysByteTempA as byte
;dim SysByteTempB as byte
;dim SysByteTempX as byte
;movf SysByteTempB, F
	movf	SYSBYTETEMPB, F,ACCESS
;btfsc STATUS, Z
	btfsc	STATUS, Z,ACCESS
;return
	return
;SysByteTempX = 0
	clrf	SYSBYTETEMPX,ACCESS
;SysDivLoop = 8
	movlw	8
	movwf	SYSDIVLOOP,ACCESS
SYSDIV8START
;bcf STATUS, C
	bcf	STATUS, C,ACCESS
;rlf SysByteTempA, F
	rlcf	SYSBYTETEMPA, F,ACCESS
;rlf SysByteTempX, F
	rlcf	SYSBYTETEMPX, F,ACCESS
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W,ACCESS
;subwf SysByteTempX, F
	subwf	SYSBYTETEMPX, F,ACCESS
;bsf SysByteTempA, 0
	bsf	SYSBYTETEMPA, 0,ACCESS
;btfsc STATUS, C
	btfsc	STATUS, C,ACCESS
;goto Div8NotNeg
	bra	DIV8NOTNEG
;bcf SysByteTempA, 0
	bcf	SYSBYTETEMPA, 0,ACCESS
;movf SysByteTempB, W
	movf	SYSBYTETEMPB, W,ACCESS
;addwf SysByteTempX, F
	addwf	SYSBYTETEMPX, F,ACCESS
DIV8NOTNEG
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F,ACCESS
;goto SysDiv8Start
	bra	SYSDIV8START
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
	movff	SYSWORDTEMPA,SYSDIVMULTA
	movff	SYSWORDTEMPA_H,SYSDIVMULTA_H
;SysDivMultB = SysWordTempB
	movff	SYSWORDTEMPB,SYSDIVMULTB
	movff	SYSWORDTEMPB_H,SYSDIVMULTB_H
;SysDivMultX = 0
	clrf	SYSDIVMULTX,ACCESS
	clrf	SYSDIVMULTX_H,ACCESS
;if SysDivMultB = 0 then
	movff	SYSDIVMULTB,SysWORDTempA
	movff	SYSDIVMULTB_H,SysWORDTempA_H
	clrf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF88
;SysWordTempA = 0
	clrf	SYSWORDTEMPA,ACCESS
	clrf	SYSWORDTEMPA_H,ACCESS
;exit sub
	return
;end if
ENDIF88
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
	bra	ENDIF89
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0,ACCESS
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W,ACCESS
	addwf	SYSDIVMULTX,F,ACCESS
	movf	SYSDIVMULTB_H,W,ACCESS
	addwfc	SYSDIVMULTX_H,F,ACCESS
;End If
ENDIF89
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

SYSDIVSUB32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysLongTempX as long
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
	clrf	SYSLONGDIVMULTX,BANKED
	clrf	SYSLONGDIVMULTX_H,BANKED
	clrf	SYSLONGDIVMULTX_U,BANKED
	clrf	SYSLONGDIVMULTX_E,BANKED
;if SysLongDivMultB = 0 then
	movff	SYSLONGDIVMULTB,SysLONGTempA
	movff	SYSLONGDIVMULTB_H,SysLONGTempA_H
	movff	SYSLONGDIVMULTB_U,SysLONGTempA_U
	movff	SYSLONGDIVMULTB_E,SysLONGTempA_E
	clrf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	rcall	SysCompEqual32
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF90
;SysLongTempA = 0
	clrf	SYSLONGTEMPA,ACCESS
	clrf	SYSLONGTEMPA_H,ACCESS
	clrf	SYSLONGTEMPA_U,ACCESS
	clrf	SYSLONGTEMPA_E,ACCESS
;exit sub
	return
;end if
ENDIF90
;SysDivLoop = 32
	movlw	32
	movwf	SYSDIVLOOP,ACCESS
SYSDIV32START
;set C off
	bcf	STATUS,C,ACCESS
;Rotate SysLongDivMultA Left
	rlcf	SYSLONGDIVMULTA,F,BANKED
	rlcf	SYSLONGDIVMULTA_H,F,BANKED
	rlcf	SYSLONGDIVMULTA_U,F,BANKED
	rlcf	SYSLONGDIVMULTA_E,F,BANKED
;Rotate SysLongDivMultX Left
	rlcf	SYSLONGDIVMULTX,F,BANKED
	rlcf	SYSLONGDIVMULTX_H,F,BANKED
	rlcf	SYSLONGDIVMULTX_U,F,BANKED
	rlcf	SYSLONGDIVMULTX_E,F,BANKED
;SysLongDivMultX = SysLongDivMultX - SysLongDivMultB
	movf	SYSLONGDIVMULTB,W,BANKED
	subwf	SYSLONGDIVMULTX,F,BANKED
	movf	SYSLONGDIVMULTB_H,W,BANKED
	subwfb	SYSLONGDIVMULTX_H,F,BANKED
	movf	SYSLONGDIVMULTB_U,W,BANKED
	subwfb	SYSLONGDIVMULTX_U,F,BANKED
	movf	SYSLONGDIVMULTB_E,W,BANKED
	subwfb	SYSLONGDIVMULTX_E,F,BANKED
;Set SysLongDivMultA.0 On
	bsf	SYSLONGDIVMULTA,0,BANKED
;If C Off Then
	btfsc	STATUS,C,ACCESS
	bra	ENDIF91
;Set SysLongDivMultA.0 Off
	bcf	SYSLONGDIVMULTA,0,BANKED
;SysLongDivMultX = SysLongDivMultX + SysLongDivMultB
	movf	SYSLONGDIVMULTB,W,BANKED
	addwf	SYSLONGDIVMULTX,F,BANKED
	movf	SYSLONGDIVMULTB_H,W,BANKED
	addwfc	SYSLONGDIVMULTX_H,F,BANKED
	movf	SYSLONGDIVMULTB_U,W,BANKED
	addwfc	SYSLONGDIVMULTX_U,F,BANKED
	movf	SYSLONGDIVMULTB_E,W,BANKED
	addwfc	SYSLONGDIVMULTX_E,F,BANKED
;End If
ENDIF91
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F,ACCESS
;goto SysDiv32Start
	bra	SYSDIV32START
;SysLongTempA = SysLongDivMultA
	movff	SYSLONGDIVMULTA,SYSLONGTEMPA
	movff	SYSLONGDIVMULTA_H,SYSLONGTEMPA_H
	movff	SYSLONGDIVMULTA_U,SYSLONGTEMPA_U
	movff	SYSLONGDIVMULTA_E,SYSLONGTEMPA_E
;SysLongTempX = SysLongDivMultX
	movff	SYSLONGDIVMULTX,SYSLONGTEMPX
	movff	SYSLONGDIVMULTX_H,SYSLONGTEMPX_H
	movff	SYSLONGDIVMULTX_U,SYSLONGTEMPX_U
	movff	SYSLONGDIVMULTX_E,SYSLONGTEMPX_E
	return

;********************************************************************************

SYSMULTSUB16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;movf SysWordTempA, W
	movf	SYSWORDTEMPA, W,ACCESS
;mulwf SysWordTempB
	mulwf	SYSWORDTEMPB,ACCESS
;movff PRODL, SysWordTempX
	movff	PRODL, SYSWORDTEMPX
;movff PRODH, SysWordTempX_H
	movff	PRODH, SYSWORDTEMPX_H
;movf SysWordTempA, W
	movf	SYSWORDTEMPA, W,ACCESS
;mulwf SysWordTempB_H
	mulwf	SYSWORDTEMPB_H,ACCESS
;movf PRODL, W
	movf	PRODL, W,ACCESS
;addwf SysWordTempX_H, F
	addwf	SYSWORDTEMPX_H, F,ACCESS
;movf SysWordTempA_H, W
	movf	SYSWORDTEMPA_H, W,ACCESS
;mulwf SysWordTempB
	mulwf	SYSWORDTEMPB,ACCESS
;movf PRODL, W
	movf	PRODL, W,ACCESS
;addwf SysWordTempX_H, F
	addwf	SYSWORDTEMPX_H, F,ACCESS
;movf SysWordTempA_H, F
	movf	SYSWORDTEMPA_H, F,ACCESS
;mulwf SysWordTempB_H
	mulwf	SYSWORDTEMPB_H,ACCESS
	return

;********************************************************************************

SYSREADSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;TBLRD*+
	tblrd*+
;movff TABLAT,SysCalcTempA
	movff	TABLAT,SYSCALCTEMPA
;movff TABLAT,INDF1
	movff	TABLAT,INDF1
;TBLRD*+
	tblrd*+
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
;TBLRD*+
	tblrd*+
SYSSTRINGREADCHECK
;movf SysCalcTempA,F
	movf	SYSCALCTEMPA,F,ACCESS
;btfsc STATUS,Z
	btfsc	STATUS,Z,ACCESS
;return
	return
SYSSTRINGREAD
;TBLRD*+
	tblrd*+
;movff TABLAT,PREINC1
	movff	TABLAT,PREINC1
;decfsz SysCalcTempA, F
	decfsz	SYSCALCTEMPA, F,ACCESS
;goto SysStringRead
	bra	SYSSTRINGREAD
	return

;********************************************************************************

SysStringTables

StringTable4
	dw	4369,"ENC28j60 Ethernet"


StringTable5
	dw	2570,"Driver 024"


StringTable6
	dw	7196,"ENC28j60 Ethernet Driver 024"


StringTable7
	dw	2827,"Initialised"


StringTable8
	dw	3084,"Initialised."


StringTable9
	dw	771,"..."


StringTable10
	dw	514,", "


StringTable11
	dw	257,"R"


StringTable12
	dw	257,"D"


StringTable13
	dw	257,"T"


StringTable14
	dw	1799,"Time..."


StringTable15
	dw	2570,"locate 1,0"


StringTable16
	dw	2570,"locate 2,0"


StringTable17
	dw	2570,"locate 3,0"


StringTable18
	dw	2570,"locate 4,0"


StringTable19
	dw	1542,"Print "


StringTable20
	dw	771,"CLS"


StringTable21
	dw	257,"!"


StringTable30
	dw	6425,"#2ERDPTL and ERDPTH error"


StringTable33
	dw	1542,"      "


StringTable34
	dw	1285,"Date "


StringTable35
	dw	514,"D/"


StringTable36
	dw	1285,"Time "


StringTable37
	dw	257,"0"


StringTable38
	dw	257,":"


StringTable51
	dw	257,"."


;********************************************************************************


 END
