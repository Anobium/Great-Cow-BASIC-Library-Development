;Program compiled by Great Cow BASIC (0.95 2016-04-25)
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F4520, r=DEC
#include <P18F4520.inc>
 CONFIG LVP = OFF, STVREN = OFF, MCLRE = ON, PBADEN = OFF, WDT = OFF, BOREN = OFF, OSC = HS

;********************************************************************************

;Set aside memory locations for variables
ACKPSH	EQU	13
ADDR	EQU	14
BANKTOBESELECTED	EQU	15
BITIN	EQU	16
BUTTONSTATE	EQU	17
CLIENT_SEQNUM	EQU	18
CLIENT_SEQNUM_E	EQU	22
CLIENT_SEQNUM_H	EQU	23
CLIENT_SEQNUM_U	EQU	24
CNT	EQU	25
COMPORT	EQU	26
DELAYTEMP	EQU	0
DELAYTEMP2	EQU	1
ENC28J60_DATA	EQU	27
ENC28J60_READREG	EQU	28
ENC28J60_TEMP	EQU	29
ENC_OUTBYTE	EQU	30
ENC_OUTBYTE1	EQU	31
ENC_OUTBYTE2	EQU	32
ENDPTR	EQU	33
ENDPTR_H	EQU	34
EPOCH_SECONDS	EQU	35
EPOCH_SECONDS_E	EQU	39
EPOCH_SECONDS_H	EQU	40
EPOCH_SECONDS_U	EQU	41
ETHERBUFFER	EQU	1233
ETHERGETLENGTH	EQU	42
ETHERGETLENGTH_H	EQU	43
ETH_COUNTER	EQU	44
ETH_COUNTER_H	EQU	46
ETH_FRAMELENGTH	EQU	47
ETH_FRAMELENGTH_H	EQU	49
EXPECTED_ACK	EQU	50
EXPECTED_ACK_E	EQU	53
EXPECTED_ACK_H	EQU	51
EXPECTED_ACK_U	EQU	52
FLAGS	EQU	54
FNLSL	EQU	55
FNLSL_E	EQU	58
FNLSL_H	EQU	56
FNLSL_U	EQU	57
FNLSR	EQU	59
FNLSR_E	EQU	62
FNLSR_H	EQU	60
FNLSR_U	EQU	61
FNNOTBIT	EQU	63
HEX	EQU	1128
HSERPRINTCRLFCOUNT	EQU	64
HULP2	EQU	65
HULP2_H	EQU	66
HULP3	EQU	67
I2CACK	EQU	68
I2CACKPOLLSTATE	EQU	69
I2CBYTE	EQU	70
I2CMATCH	EQU	71
I2COLDSTATE	EQU	72
I2CSTATE	EQU	73
I2CTEMP	EQU	74
I2C_LCD_BYTE	EQU	75
II	EQU	76
II_H	EQU	77
INCOMING_ACK	EQU	78
INCOMING_ACK_E	EQU	82
INCOMING_ACK_H	EQU	83
INCOMING_ACK_U	EQU	84
IPADDR	EQU	1152
IPPORT	EQU	85
IPROUTER	EQU	1147
IPSERVER	EQU	1142
IP_CHECKSUM16	EQU	86
IP_CHECKSUM16_H	EQU	87
IP_CHKSUM32	EQU	88
IP_CHKSUM32_E	EQU	91
IP_CHKSUM32_H	EQU	89
IP_CHKSUM32_U	EQU	90
IP_HEADER_LENGTH	EQU	92
IP_HULP1	EQU	93
IP_ID	EQU	94
IP_ID_H	EQU	96
IP_TEMP16	EQU	97
IP_TEMP16_H	EQU	98
IP_X	EQU	99
I_CHECKSUM16	EQU	100
I_CHECKSUM16_H	EQU	102
I_CHKSUM32	EQU	103
I_CHKSUM32_E	EQU	106
I_CHKSUM32_H	EQU	104
I_CHKSUM32_U	EQU	107
I_ODD	EQU	108
I_X	EQU	109
I_X_H	EQU	110
L2	EQU	111
L2_E	EQU	114
L2_H	EQU	112
L2_U	EQU	113
LASTSELECTEDBANK	EQU	115
LCDBYTE	EQU	116
LCDCOLUMN	EQU	117
LCDLINE	EQU	118
LCDTEMP	EQU	119
LCD_BACKLIGHT	EQU	120
LCD_I2C_ADDRESS_CURRENT	EQU	121
LCD_STATE	EQU	122
LOCALTMP	EQU	123
LOCALTMP_H	EQU	125
MACADDR	EQU	1163
MACADDRROUTER	EQU	1137
MACON2	EQU	126
MAPHSUP	EQU	127
MAXLEN	EQU	128
MAXLEN_H	EQU	129
MSG_TEMP2	EQU	1181
MYDEBUGCOUNT	EQU	130
MYDEBUGCOUNT_E	EQU	133
MYDEBUGCOUNT_H	EQU	131
MYDEBUGCOUNT_U	EQU	132
NEXTPACKETPTR	EQU	134
NEXTPACKETPTR_H	EQU	136
NUMBITS	EQU	137
OLDPACKETCOUNTERIN	EQU	138
OLDPACKETCOUNTERIN_E	EQU	141
OLDPACKETCOUNTERIN_H	EQU	139
OLDPACKETCOUNTERIN_U	EQU	140
OLDPACKETCOUNTEROUT	EQU	142
OLDPACKETCOUNTEROUT_E	EQU	145
OLDPACKETCOUNTEROUT_H	EQU	143
OLDPACKETCOUNTEROUT_U	EQU	144
OUTVALUETEMP	EQU	146
PACKETCOUNTERIN	EQU	147
PACKETCOUNTERIN_E	EQU	150
PACKETCOUNTERIN_H	EQU	148
PACKETCOUNTERIN_U	EQU	149
PACKETCOUNTEROUT	EQU	151
PACKETCOUNTEROUT_E	EQU	154
PACKETCOUNTEROUT_H	EQU	152
PACKETCOUNTEROUT_U	EQU	153
PACKETLENGTH	EQU	155
PACKETLENGTH_H	EQU	156
PCKTLEN	EQU	157
PCKTLEN_H	EQU	159
PHYREGADDR	EQU	160
PREVIOUS_NEXTPACKETPTR	EQU	161
PREVIOUS_NEXTPACKETPTR_H	EQU	162
PRINTLEN	EQU	163
RESULT	EQU	164
RESULT_H	EQU	165
RXSTAT	EQU	166
RXSTAT_H	EQU	167
SERDATA	EQU	168
SERPRINTVAL	EQU	169
SERPRINTVAL_E	EQU	172
SERPRINTVAL_H	EQU	170
SERPRINTVAL_U	EQU	171
SNTPSERVERADDR	EQU	1132
SPICLOCKMODE	EQU	173
SPICURRENTMODE	EQU	174
SPIRXDATA	EQU	175
SPITXDATA	EQU	176
STARTPTR	EQU	177
STARTPTR_H	EQU	178
STR	EQU	1157
STRINGPOINTER	EQU	179
SUM	EQU	180
SUM_E	EQU	183
SUM_H	EQU	181
SUM_U	EQU	182
SYSARRAYTEMP1	EQU	184
SYSARRAYTEMP2	EQU	185
SYSBITVAR0	EQU	186
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
SYSCHARCOUNT	EQU	187
SYSDIVLOOP	EQU	4
SYSDIVMULTA	EQU	7
SYSDIVMULTA_H	EQU	8
SYSDIVMULTB	EQU	11
SYSDIVMULTB_H	EQU	12
SYSDIVMULTX	EQU	2
SYSDIVMULTX_H	EQU	3
SYSFNBYTE1	EQU	188
SYSLCDTEMP	EQU	189
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
SYSMACADDRHANDLER	EQU	202
SYSMACADDRHANDLER_H	EQU	203
SYSPRINTBUFFER	EQU	1170
SYSPRINTBUFFLEN	EQU	204
SYSPRINTDATAHANDLER	EQU	205
SYSPRINTDATAHANDLER_H	EQU	206
SYSPRINTTEMP	EQU	207
SYSREPEATTEMP1	EQU	208
SYSREPEATTEMP2	EQU	209
SYSREPEATTEMP3	EQU	210
SYSREPEATTEMP4	EQU	211
SYSREPEATTEMP5	EQU	212
SYSREPEATTEMP6	EQU	213
SYSSTRDATA	EQU	214
SYSSTRINGA	EQU	7
SYSSTRINGA_H	EQU	8
SYSSTRINGLENGTH	EQU	6
SYSSTRINGPARAM1	EQU	1192
SYSSTRINGTEMP	EQU	215
SYSTEMP1	EQU	216
SYSTEMP1_E	EQU	219
SYSTEMP1_H	EQU	217
SYSTEMP1_U	EQU	218
SYSTEMP2	EQU	220
SYSTEMP2_H	EQU	221
SYSTEMP3	EQU	222
SYSVALTEMP	EQU	223
SYSVALTEMP_H	EQU	224
SYSWAITTEMP10US	EQU	5
SYSWAITTEMPMS	EQU	2
SYSWAITTEMPMS_H	EQU	3
SYSWAITTEMPUS	EQU	5
SYSWAITTEMPUS_H	EQU	6
SYSWORDTEMPA	EQU	5
SYSWORDTEMPA_H	EQU	6
SYSWORDTEMPB	EQU	9
SYSWORDTEMPB_H	EQU	10
SYSWORDTEMPX	EQU	0
SYSWORDTEMPX_H	EQU	1
TCPDATALEN_IN	EQU	225
TCPDATALEN_IN_H	EQU	226
TCPDATALEN_OUT	EQU	227
TCPDATALEN_OUT_H	EQU	228
TEMP	EQU	229
TEMPSTRING1	EQU	1125
TEMPWORD3	EQU	230
TEMPWORD3_H	EQU	231
TT	EQU	232
T_UDP_DESTPORT	EQU	233
T_UDP_DESTPORT_H	EQU	234
VAL1	EQU	235
VAL2	EQU	236
VAL2_H	EQU	237
VAL3	EQU	238
VAL4	EQU	239
WORK	EQU	240

;********************************************************************************

;Alias variables
AFSR0	EQU	4073
AFSR0_H	EQU	4074
I_VALUE16	EQU	100
I_VALUE16_H	EQU	102
SYSETHERBUFFER_1	EQU	1234
SYSETHERBUFFER_10	EQU	1243
SYSETHERBUFFER_11	EQU	1244
SYSETHERBUFFER_12	EQU	1245
SYSETHERBUFFER_13	EQU	1246
SYSETHERBUFFER_14	EQU	1247
SYSETHERBUFFER_15	EQU	1248
SYSETHERBUFFER_16	EQU	1249
SYSETHERBUFFER_17	EQU	1250
SYSETHERBUFFER_18	EQU	1251
SYSETHERBUFFER_19	EQU	1252
SYSETHERBUFFER_2	EQU	1235
SYSETHERBUFFER_20	EQU	1253
SYSETHERBUFFER_21	EQU	1254
SYSETHERBUFFER_22	EQU	1255
SYSETHERBUFFER_23	EQU	1256
SYSETHERBUFFER_24	EQU	1257
SYSETHERBUFFER_25	EQU	1258
SYSETHERBUFFER_26	EQU	1259
SYSETHERBUFFER_27	EQU	1260
SYSETHERBUFFER_28	EQU	1261
SYSETHERBUFFER_29	EQU	1262
SYSETHERBUFFER_3	EQU	1236
SYSETHERBUFFER_30	EQU	1263
SYSETHERBUFFER_31	EQU	1264
SYSETHERBUFFER_32	EQU	1265
SYSETHERBUFFER_33	EQU	1266
SYSETHERBUFFER_34	EQU	1267
SYSETHERBUFFER_35	EQU	1268
SYSETHERBUFFER_36	EQU	1269
SYSETHERBUFFER_37	EQU	1270
SYSETHERBUFFER_38	EQU	1271
SYSETHERBUFFER_39	EQU	1272
SYSETHERBUFFER_4	EQU	1237
SYSETHERBUFFER_40	EQU	1273
SYSETHERBUFFER_41	EQU	1274
SYSETHERBUFFER_42	EQU	1275
SYSETHERBUFFER_43	EQU	1276
SYSETHERBUFFER_44	EQU	1277
SYSETHERBUFFER_45	EQU	1278
SYSETHERBUFFER_46	EQU	1279
SYSETHERBUFFER_47	EQU	1280
SYSETHERBUFFER_48	EQU	1281
SYSETHERBUFFER_49	EQU	1282
SYSETHERBUFFER_5	EQU	1238
SYSETHERBUFFER_50	EQU	1283
SYSETHERBUFFER_51	EQU	1284
SYSETHERBUFFER_52	EQU	1285
SYSETHERBUFFER_53	EQU	1286
SYSETHERBUFFER_54	EQU	1287
SYSETHERBUFFER_55	EQU	1288
SYSETHERBUFFER_56	EQU	1289
SYSETHERBUFFER_57	EQU	1290
SYSETHERBUFFER_58	EQU	1291
SYSETHERBUFFER_59	EQU	1292
SYSETHERBUFFER_6	EQU	1239
SYSETHERBUFFER_60	EQU	1293
SYSETHERBUFFER_61	EQU	1294
SYSETHERBUFFER_62	EQU	1295
SYSETHERBUFFER_63	EQU	1296
SYSETHERBUFFER_64	EQU	1297
SYSETHERBUFFER_65	EQU	1298
SYSETHERBUFFER_66	EQU	1299
SYSETHERBUFFER_67	EQU	1300
SYSETHERBUFFER_68	EQU	1301
SYSETHERBUFFER_69	EQU	1302
SYSETHERBUFFER_7	EQU	1240
SYSETHERBUFFER_70	EQU	1303
SYSETHERBUFFER_8	EQU	1241
SYSETHERBUFFER_9	EQU	1242
SYSHEX_0	EQU	1128
SYSHEX_1	EQU	1129
SYSHEX_2	EQU	1130
SYSIPADDR_1	EQU	1153
SYSIPADDR_2	EQU	1154
SYSIPADDR_3	EQU	1155
SYSIPADDR_4	EQU	1156
SYSMACADDRROUTER_1	EQU	1138
SYSMACADDRROUTER_2	EQU	1139
SYSMACADDRROUTER_3	EQU	1140
SYSMACADDRROUTER_4	EQU	1141
SYSMACADDRROUTER_5	EQU	1142
SYSMACADDRROUTER_6	EQU	1143
SYSMACADDR_1	EQU	1164
SYSMACADDR_2	EQU	1165
SYSMACADDR_3	EQU	1166
SYSMACADDR_4	EQU	1167
SYSMACADDR_5	EQU	1168
SYSMACADDR_6	EQU	1169
SYSSNTPSERVERADDR_1	EQU	1133
SYSSNTPSERVERADDR_2	EQU	1134
SYSSNTPSERVERADDR_3	EQU	1135
SYSSNTPSERVERADDR_4	EQU	1136
SYSSTR_0	EQU	1157

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
;#Define Delay											200 Ms
;#Define I2C_MODE 									Master
;#Define I2C_DATA 									PortC.4
;#Define I2C_CLOCK 								PortC.3
;#Define I2C_DISABLE_INTERRUPTS 		On
;#Define LCD_IO 										10
;#Define LCD_2C_Address_1 					0x4E ; default to 0x4E
;#Define LCD_SPEED 								Fast
;#Define LCD_Backlight_On_State  	1
;#Define LCD_Backlight_Off_State 	0
;LCDBacklight (On)
	movlw	1
	movwf	LCDTEMP,BANKED
	call	LCDBACKLIGHT
;Cls
	rcall	CLS
;Locate (0,0)
	clrf	LCDLINE,BANKED
	clrf	LCDCOLUMN,BANKED
	call	LOCATE
;Print "Initialising"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable3
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable3
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	call	PRINT107
;Wait Delay
	movlw	200
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Cls
	rcall	CLS
;Locate (0,0)
	clrf	LCDLINE,BANKED
	clrf	LCDCOLUMN,BANKED
	call	LOCATE
;Print "Initialising."
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
	call	PRINT107
;Wait Delay
	movlw	200
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Cls
	rcall	CLS
;Locate (0,0)
	clrf	LCDLINE,BANKED
	clrf	LCDCOLUMN,BANKED
	call	LOCATE
;Print "Initialising.."
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
	call	PRINT107
;Wait Delay
	movlw	200
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Cls
	rcall	CLS
;Locate (0,0)
	clrf	LCDLINE,BANKED
	clrf	LCDCOLUMN,BANKED
	call	LOCATE
;Print "Initialising..."
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
	call	PRINT107
;Wait Delay
	movlw	200
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	rcall	Delay_MS
;Cls
	rcall	CLS
;LCDBacklight (Off)
	clrf	LCDTEMP,BANKED
	call	LCDBACKLIGHT
;----- Variables
;----- Quick Command Reference:
;----- Main body of program commences here.
RESET_ENC26J60
;HSerPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;HserPrint "ENC28j60 Ethernet Driver 022" : HSerPrintCRLF
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
	call	HSERPRINT239
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
	movlw	low StringTable8
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable8
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT239
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
	call	HSERPRINT239
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
;Setwith ( Heartbeat, FnNotBit ( Heartbeat ))
;if Source then
	clrf	BITIN,BANKED
	btfsc	PORTC,2,ACCESS
	incf	BITIN,F,BANKED
	call	FN_FNNOTBIT
	btfss	FNNOTBIT,BANKED
	bra	ELSE1_1
;TargetBit = 1
	bsf	LATC,2,ACCESS
;else
	bra	ENDIF1
ELSE1_1
;TargetBit = 0
	bcf	LATC,2,ACCESS
;end if
ENDIF1
;if Button = buttonstate then
	clrf	SysCalcTempA,ACCESS
	btfsc	PORTA,4,ACCESS
	incf	SysCalcTempA,F,ACCESS
	movf	BUTTONSTATE,W,BANKED
	subwf	SysCalcTempA,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF3
;if buttonstate  = ButtonDown then
	decf	BUTTONSTATE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF4
;HserPrint cnt
	movff	CNT,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT240
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
	call	HSERPRINT239
;HserPrint packetCounterOut
	movff	PACKETCOUNTEROUT,SERPRINTVAL
	movff	PACKETCOUNTEROUT_H,SERPRINTVAL_H
	movff	PACKETCOUNTEROUT_U,SERPRINTVAL_U
	movff	PACKETCOUNTEROUT_E,SERPRINTVAL_E
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT243
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
	call	HSERPRINT239
;HserPrint packetCounterIn
	movff	PACKETCOUNTERIN,SERPRINTVAL
	movff	PACKETCOUNTERIN_H,SERPRINTVAL_H
	movff	PACKETCOUNTERIN_U,SERPRINTVAL_U
	movff	PACKETCOUNTERIN_E,SERPRINTVAL_E
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT243
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
	call	HSERPRINT239
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
ENDIF4
;end if
ENDIF3
;ENC28j60_poll 'Start the process.
	call	ENC28J60_POLL
;Loop
	bra	SysDoLoop_S1
SysDoLoop_E1
;end
	bra	BASPROGRAMEND
;----- Support methods.  Subroutines and Functions
;CHANGE Epoch_seconds  TO SUIT LOCAL NEEDS.. IN SECONDS!!
;If you want use the CALCULATED UDP checksum.  Not required typically.
;#define ENC28j60_UDP_checkSum_Supported
;If you want the ENC28j60 to respond to ICMP/Ping requests
;#define ENC28j60_ping_Supported
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
;#define debug0
CONFIGURATIONDETAILS
MEMORY_LOCATIONS_SCRIPT
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

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

ENC28J60_ARPREPLY
;ENC28j60_Setst_mac
	call	ENC28J60_SETST_MAC
;For II = 1 To 6
	clrf	II,BANKED
SysForLoop9
	incf	II,F,BANKED
;etherBuffer(32 + II) = etherBuffer(II)
	lfsr	0,ETHERBUFFER
	movf	II,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	INDF0,SysArrayTemp2
	movff	SysArrayTemp2,SysArrayTemp1
	lfsr	0,ETHERBUFFER
	movlw	32
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
	movff	SysArrayTemp1,INDF0
;Next
	movlw	6
	subwf	II,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop9
SysForLoopEnd9
;For II = 1 To 4
	clrf	II,BANKED
SysForLoop10
	incf	II,F,BANKED
;etherBuffer(38 + II) = etherBuffer(28 + II)
	lfsr	0,ETHERBUFFER
	movlw	28
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
	movlw	38
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
	movff	SysArrayTemp1,INDF0
;Next
	movlw	4
	subwf	II,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop10
SysForLoopEnd10
;For II = 1 To 6
	clrf	II,BANKED
SysForLoop11
	incf	II,F,BANKED
;etherBuffer(22 + II) = etherBuffer(6 + II)
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
	movlw	22
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
	movff	SysArrayTemp1,INDF0
;Next
	movlw	6
	subwf	II,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop11
SysForLoopEnd11
;etherBuffer(29) = ipaddr(1)
	movff	SYSIPADDR_1,SYSETHERBUFFER_29
;etherBuffer(30) = ipaddr(2)
	movff	SYSIPADDR_2,SYSETHERBUFFER_30
;etherBuffer(31) = ipaddr(3)
	movff	SYSIPADDR_3,SYSETHERBUFFER_31
;etherBuffer(32) = ipaddr(4)
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
;banktobeselected = ( addr & BANK_MASK) / 32
	movlw	96
	andwf	ADDR,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SysBYTETempA
	movlw	32
	movwf	SysBYTETempB,ACCESS
	call	SysDivSub
	movff	SysBYTETempA,BANKTOBESELECTED
;if lastselectedBank <> banktobeselected then
	movf	BANKTOBESELECTED,W,BANKED
	subwf	LASTSELECTEDBANK,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ELSE8_1
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
	bra	ENDIF8
ELSE8_1
;lastselectedBank = banktobeselected
	movff	BANKTOBESELECTED,LASTSELECTEDBANK
;end if
ENDIF8
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
;banktobeselected = ( addr & BANK_MASK) / 32
	movlw	96
	andwf	ADDR,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SysBYTETempA
	movlw	32
	movwf	SysBYTETempB,ACCESS
	call	SysDivSub
	movff	SysBYTETempA,BANKTOBESELECTED
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
	bra	SysForLoopEnd12
SysForLoop12
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
;LocalTmp  = etherBuffer(II) * 256
	lfsr	0,ETHERBUFFER
	movf	II,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	INDF0,SysWORDTempA
	clrf	SysWORDTempA_H,ACCESS
	clrf	SysWORDTempB,ACCESS
	movlw	1
	movwf	SysWORDTempB_H,ACCESS
	call	SysMultSub16
	movff	SysWORDTempX,LOCALTMP
	movff	SysWORDTempX_H,LOCALTMP_H
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
	bra	SysForLoop12
SysForLoopEnd12
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
;I_chksum32 = 0
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
	bra	SysForLoopEnd14
SysForLoop14
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
	bra	SysForLoop14
SysForLoopEnd14
;If I_odd = 1 Then
	decf	I_ODD,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF126
;Val2 = Val2 + 3
	movlw	3
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
ENDIF126
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
;Dim Incoming_ack as Long
;Dim Msg_temp2 As String * 10
;dim Tempword3 As Word
;dim Tempstring1 As String * 1
;Dim Ackpsh As Byte
;Work = Tcp_flags   'in the TCP Buffer, see aliases
	movff	SYSETHERBUFFER_48,WORK
;Tcp_fin = Work.0
	bcf	SYSBITVAR0,0,BANKED
	btfsc	WORK,0,BANKED
	bsf	SYSBITVAR0,0,BANKED
;Tcp_syn = Work.1
	bcf	SYSBITVAR0,1,BANKED
	btfsc	WORK,1,BANKED
	bsf	SYSBITVAR0,1,BANKED
;Tcp_rst = Work.2
	bcf	SYSBITVAR0,2,BANKED
	btfsc	WORK,2,BANKED
	bsf	SYSBITVAR0,2,BANKED
;Tcp_psh = Work.3
	bcf	SYSBITVAR0,3,BANKED
	btfsc	WORK,3,BANKED
	bsf	SYSBITVAR0,3,BANKED
;Tcp_ack = Work.4
	bcf	SYSBITVAR0,4,BANKED
	btfsc	WORK,4,BANKED
	bsf	SYSBITVAR0,4,BANKED
;Tcp_urg = Work.5
	bcf	SYSBITVAR0,5,BANKED
	btfsc	WORK,5,BANKED
	bsf	SYSBITVAR0,5,BANKED
;HserPrint "Handling HTTP"
;HSerPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;HSerPrint "Flags:"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable11
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable11
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT239
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;HserPrint "FIN "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT239
;HSerSend 9
	movlw	9
	movwf	SERDATA,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERSEND
;HserPrint "SYN "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable13
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable13
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT239
;HSerSend 9
	movlw	9
	movwf	SERDATA,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERSEND
;HserPrint  "RST "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable14
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable14
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT239
;HSerSend 9
	movlw	9
	movwf	SERDATA,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERSEND
;HserPrint  "PSH "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable15
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable15
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT239
;HSerSend 9
	movlw	9
	movwf	SERDATA,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERSEND
;HserPrint  "ACK "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable16
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable16
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT239
;HSerSend 9
	movlw	9
	movwf	SERDATA,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERSEND
;HserPrint "TCP_URG "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable17
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable17
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT239
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;HserPrint Tcp_fin
	clrf	SERPRINTVAL,BANKED
	btfsc	SYSBITVAR0,0,BANKED
	incf	SERPRINTVAL,F,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT240
;HSerSend 9
	movlw	9
	movwf	SERDATA,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERSEND
;HserPrint Tcp_syn
	clrf	SERPRINTVAL,BANKED
	btfsc	SYSBITVAR0,1,BANKED
	incf	SERPRINTVAL,F,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT240
;HSerSend 9
	movlw	9
	movwf	SERDATA,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERSEND
;HserPrint Tcp_rst
	clrf	SERPRINTVAL,BANKED
	btfsc	SYSBITVAR0,2,BANKED
	incf	SERPRINTVAL,F,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT240
;HSerSend 9
	movlw	9
	movwf	SERDATA,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERSEND
;HserPrint Tcp_psh
	clrf	SERPRINTVAL,BANKED
	btfsc	SYSBITVAR0,3,BANKED
	incf	SERPRINTVAL,F,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT240
;HSerSend 9
	movlw	9
	movwf	SERDATA,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERSEND
;HserPrint Tcp_ack
	clrf	SERPRINTVAL,BANKED
	btfsc	SYSBITVAR0,4,BANKED
	incf	SERPRINTVAL,F,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT240
;HSerSend 9
	movlw	9
	movwf	SERDATA,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERSEND
;HserPrint Tcp_urg
	clrf	SERPRINTVAL,BANKED
	btfsc	SYSBITVAR0,5,BANKED
	incf	SERPRINTVAL,F,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT240
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;If Tcp_syn = 1 Then
	btfss	SYSBITVAR0,1,BANKED
	bra	ENDIF98
;HSerPrint "1) Handler"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable18
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable18
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT239
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
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
	call	SWAP79
	movff	SYSCALCTEMPA,SYSETHERBUFFER_36
	movff	SYSCALCTEMPB,SYSETHERBUFFER_38
;Swap Tcp_srcporth , Tcp_destporth
	movff	SYSETHERBUFFER_35,SYSCALCTEMPA
	movff	SYSETHERBUFFER_37,SYSCALCTEMPB
	call	SWAP79
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
;ENC28j60_packetshape
	banksel	0
	call	ENC28J60_PACKETSHAPE
;Flags.synflag = 1
	bsf	FLAGS,0,BANKED
;Tcp_flags = 0
	banksel	SYSETHERBUFFER_48
	clrf	SYSETHERBUFFER_48,BANKED
;Tcp_flags.1 = 1
	bsf	SYSETHERBUFFER_48,1,BANKED
;Tcp_flags.4 = 1
	bsf	SYSETHERBUFFER_48,4,BANKED
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
	movwf	SysTemp2,BANKED
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	SysTemp2_H,BANKED
	movlw	14
	addwf	SysTemp2,W,BANKED
	movwf	TT,BANKED
;ENC28j60_ip_header_checksum
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
	rcall	ENC28J60_PACKETSEND
;End If
ENDIF98
;
;' If an ACK and PSH is received and the destination port address is valid
;If Tcp_ack = 1 Then
	btfss	SYSBITVAR0,4,BANKED
	bra	ENDIF99
;If Tcp_psh = 1 Then
	btfss	SYSBITVAR0,3,BANKED
	bra	ENDIF101
;hserPrint "2) Handler"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable19
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable19
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT239
;
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
	call	SWAP79
	movff	SYSCALCTEMPA,SYSETHERBUFFER_36
	movff	SYSCALCTEMPB,SYSETHERBUFFER_38
;Swap Tcp_srcporth , Tcp_destporth
	movff	SYSETHERBUFFER_35,SYSCALCTEMPA
	movff	SYSETHERBUFFER_37,SYSCALCTEMPB
	call	SWAP79
	movff	SYSCALCTEMPA,SYSETHERBUFFER_35
	movff	SYSCALCTEMPB,SYSETHERBUFFER_37
;'           'swap mac
;'           Call Packetshape
;ENC28j60_Packetshape
	rcall	ENC28J60_PACKETSHAPE
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
;Incoming_ack = Incoming_ack + 475          '489 - 14
	movlw	219
	addwf	INCOMING_ACK,F,BANKED
	movlw	1
	addwfc	INCOMING_ACK_H,F,BANKED
	movlw	0
	addwfc	INCOMING_ACK_U,F,BANKED
	movlw	0
	addwfc	INCOMING_ACK_E,F,BANKED
;
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
;
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
	banksel	SYSETHERBUFFER_47
	movwf	SYSETHERBUFFER_47,BANKED
;'flag ACK
;etherBuffer(48) = 0x10
	movlw	16
	movwf	SYSETHERBUFFER_48,BANKED
;
;'padding
;etherBuffer(55) = 0
	clrf	SYSETHERBUFFER_55,BANKED
;etherBuffer(56) = 0
	clrf	SYSETHERBUFFER_56,BANKED
;etherBuffer(57) = 0
	clrf	SYSETHERBUFFER_57,BANKED
;etherBuffer(58) = 0
	clrf	SYSETHERBUFFER_58,BANKED
;etherBuffer(59) = 0
	clrf	SYSETHERBUFFER_59,BANKED
;etherBuffer(60) = 0
	clrf	SYSETHERBUFFER_60,BANKED
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
;ENC28j60_writebuffer(60)
	movlw	60
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
ENDIF101
;End If
ENDIF99
;If Tcp_ack = 1 Then
	btfss	SYSBITVAR0,4,BANKED
	bra	ENDIF100
;HSerPrint "Tcp_ack = 1 "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable20
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable20
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT239
;If etherBuffer(17) = 0 Then
	banksel	SYSETHERBUFFER_17
	movf	SYSETHERBUFFER_17,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF102
;HSerPrint "Buffer(17) = 0 "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable21
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable21
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT239
;If etherBuffer(18) = 40 Then
	movlw	40
	banksel	SYSETHERBUFFER_18
	subwf	SYSETHERBUFFER_18,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF103
;HSerPrint "Buffer(18) = 40 "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable22
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable22
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT239
;If Ackpsh = 1 Then
	decf	ACKPSH,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF104
;HSerPrint "3) Handler"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable23
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable23
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT239
;'ACK after a ACK-PSH
;
;'set flags
;Tcp_flags = 0
;Set Tcp_flags.4                            'ack
;Set Tcp_flags.3                            'psh
;Set Tcp_flags.0                            'fin
;
;'Move IP source address to destination address
;T_ip_destaddr = T_ip_srcaddr
;'Make ethernet module IP address source address
;T_ip_srcaddr = My_ip
;Swap Tcp_srcportl , Tcp_destportl
;Swap Tcp_srcporth , Tcp_destporth
;
;'swap mac
;Call Packetshape
;
;Incoming_ack0 = Tcp_seqnum0
;Incoming_ack1 = Tcp_seqnum1
;Incoming_ack2 = Tcp_seqnum2
;Incoming_ack3 = Tcp_seqnum3
;
;Tcp_seqnum0 = Tcp_acknum0
;Tcp_seqnum1 = Tcp_acknum1
;Tcp_seqnum2 = Tcp_acknum2
;Tcp_seqnum3 = Tcp_acknum3
;
;Tcp_acknum0 = Incoming_ack0
;Tcp_acknum1 = Incoming_ack1
;Tcp_acknum2 = Incoming_ack2
;Tcp_acknum3 = Incoming_ack3
;
;Buffer(17) = 0
;Buffer(18) = 40
;
;Tempword3 = &H37
;
;Restore Htmlcode
;Do
;
;Read Msg_temp
;Print Msg_temp
;Msg_temp2 = Right(msg_temp , 8)
;If Msg_temp2 = "endblock" Then
;Exit Do
;End If
;For Y = 1 To Len(msg_temp)
;Tempstring1 = Mid(msg_temp , Y , 1)
;Buffer(tempword3) = Asc(tempstring1)
;Incr Tempword3
;Next Y
;Loop
;Buffer(181) = &H0D
;Buffer(182) = &H0A
;
;T_ip_pktlen0 = 0
;T_ip_pktlen1 = 48
;
;Buffer(17) = 0                             'HTML-code + 40
;Buffer(18) = &HA8
;
;Call Ip_header_checksum
;
;Call Tcp_checksum
;Call ENC28j60packetsend(182)
;
;End If
ENDIF104
;End If
ENDIF103
;End If
ENDIF102
;HSerPrintCRLF
	movlw	1
	banksel	HSERPRINTCRLFCOUNT
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;End If
ENDIF100
	return

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
;SPIMode Master, 0
	movlw	12
	movwf	SPICURRENTMODE,BANKED
	clrf	SPICLOCKMODE,BANKED
	call	SPIMODE195
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
	rcall	FN_ENC28J60_READREG
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
;ENC28j60_writeReg(EIE,  0xC0)  'Interrupts: Packet reception
	movlw	27
	movwf	ADDR,BANKED
	movlw	192
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
	rcall	FN_ENC28J60_READREG
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
	mullw	4
	movff	PRODL,IP_HEADER_LENGTH
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
	movwf	SysTemp3,BANKED
	movlw	1
	subwf	SysTemp3,W,BANKED
	movwf	VAL2,BANKED
	clrf	VAL2_H,BANKED
	btfss	STATUS,C,ACCESS
	decf	VAL2_H,F,BANKED
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
	bra	ENDIF53
;HSerPrint "No packet"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable24
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable24
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT239
;ENC28j60_bitSet( ECON2, ECON2_PKTDEC )
	movlw	30
	movwf	ADDR,BANKED
	movlw	64
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_BITSET
;goto Reset_ENC26j60
	goto	RESET_ENC26J60
;Exit Sub
	return
;End If
ENDIF53
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
;do
;ENC28j60_writeReg(ERDPTL, [byte]nextpacketptr )
	clrf	ADDR,BANKED
	movff	NEXTPACKETPTR,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ERDPTH, nextpacketptr_h )
	movlw	1
	movwf	ADDR,BANKED
	movff	NEXTPACKETPTR_H,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;loop while (ENC28j60_ReadReg(ERDPTL) <>  [byte]nextpacketptr) or (ENC28j60_ReadReg(ERDPTH) <> nextpacketptr_h )
;ENC28j60_readbuffer(6)
	movlw	6
	movwf	ETHERGETLENGTH,BANKED
	clrf	ETHERGETLENGTH_H,BANKED
	rcall	ENC28J60_READBUFFER
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
	movlw	128
	banksel	SYSETHERBUFFER_5
	andwf	SYSETHERBUFFER_5,W,BANKED
	banksel	SYSTEMP2
	movwf	SysTemp2,BANKED
	movff	SysTemp2,SysBYTETempA
	movlw	128
	movwf	SysBYTETempB,ACCESS
	call	SysCompEqual
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF54
;ENC28j60_readbuffer(eth_frameLength)
	movff	ETH_FRAMELENGTH,ETHERGETLENGTH
	movff	ETH_FRAMELENGTH_H,ETHERGETLENGTH_H
	rcall	ENC28J60_READBUFFER
;end if
ENDIF54
ENDPACKET
;do
SysDoLoop_S4
;ENC28j60_writeReg(ERDPTL, [byte]nextpacketptr )
	clrf	ADDR,BANKED
	movff	NEXTPACKETPTR,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ERDPTH, nextpacketptr_h )
	movlw	1
	movwf	ADDR,BANKED
	movff	NEXTPACKETPTR_H,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
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
;IF ( nextpacketptr and 1 ) = 0 THEN
	movlw	1
	andwf	NEXTPACKETPTR,W,BANKED
	movwf	SysTemp1,BANKED
	clrf	SysTemp1_H,BANKED
	movff	SysTemp1,SysWORDTempA
	movff	SysTemp1_H,SysWORDTempA_H
	clrf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF55
;eth_counter = nextpacketptr -1
	movlw	1
	subwf	NEXTPACKETPTR,W,BANKED
	movwf	ETH_COUNTER,BANKED
	movlw	0
	subwfb	NEXTPACKETPTR_H,W,BANKED
	movwf	ETH_COUNTER_H,BANKED
;END IF
ENDIF55
;ENC28j60_writeReg(ERXRDPTL, [byte]eth_counter )
	movlw	12
	movwf	ADDR,BANKED
	movff	ETH_COUNTER,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(ERXRDPTH, eth_counter_h )
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
	bra	ENDIF56
;If etherBuffer(14) = 0X06 Then                             'Type:ARP
	movlw	6
	subwf	SYSETHERBUFFER_14,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF57
;If etherBuffer(21) = 0X00 Then                          'ARP request
	movf	SYSETHERBUFFER_21,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF59
;If etherBuffer(22) = 0X01 Then                       'ARP request
	decf	SYSETHERBUFFER_22,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF61
;If etherBuffer(39) = ipaddr(1) Then                  'ARP for us
	movf	SYSIPADDR_1,W,BANKED
	subwf	SYSETHERBUFFER_39,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF63
;If etherBuffer(40) = ipaddr(2) Then
	movf	SYSIPADDR_2,W,BANKED
	subwf	SYSETHERBUFFER_40,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF65
;If etherBuffer(41) = ipaddr(3) Then
	movf	SYSIPADDR_3,W,BANKED
	subwf	SYSETHERBUFFER_41,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF67
;If etherBuffer(42) = ipaddr(4) Then
	movf	SYSIPADDR_4,W,BANKED
	subwf	SYSETHERBUFFER_42,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF69
;ENC28j60_Arpreply
	banksel	0
	call	ENC28J60_ARPREPLY
;End If
ENDIF69
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
;If etherBuffer(14) = 0X00 Then                             'Type:IP
	banksel	SYSETHERBUFFER_14
	movf	SYSETHERBUFFER_14,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF58
;If etherBuffer(15) = 0X45 Then                          'We handle only simple IP packets
	movlw	69
	subwf	SYSETHERBUFFER_15,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF60
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
	bra	ENDIF62
;If etherBuffer(31) = ipaddr(1) Then                  'Ip packet for us
	banksel	SYSIPADDR_1
	movf	SYSIPADDR_1,W,BANKED
	subwf	SYSETHERBUFFER_31,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF64
;If etherBuffer(32) = ipaddr(2) Then
	movf	SYSIPADDR_2,W,BANKED
	subwf	SYSETHERBUFFER_32,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF66
;If etherBuffer(33) = ipaddr(3) Then
	movf	SYSIPADDR_3,W,BANKED
	subwf	SYSETHERBUFFER_33,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF68
;If etherBuffer(34) = ipaddr(4) Then
	movf	SYSIPADDR_4,W,BANKED
	subwf	SYSETHERBUFFER_34,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF70
;If etherBuffer(24) = 1 Then              'Protocol:ICMP
	decf	SYSETHERBUFFER_24,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF71
;If etherBuffer(35) = 0X08 Then        'ICMP echo request
	movlw	8
	subwf	SYSETHERBUFFER_35,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF74
;ENC28j60_Pingreply
	banksel	0
	rcall	ENC28J60_PINGREPLY
;End If
ENDIF74
;End If
ENDIF71
;If etherBuffer(24) = 17 Then             'Protocol:UDP
	movlw	17
	banksel	SYSETHERBUFFER_24
	subwf	SYSETHERBUFFER_24,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF72
;ENC28j60_Udp
	banksel	0
	call	ENC28J60_UDP
;End If
ENDIF72
;If etherBuffer(24) = 6 Then              'Protocol:TCP
	movlw	6
	banksel	SYSETHERBUFFER_24
	subwf	SYSETHERBUFFER_24,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF73
;If Tcp_destporth = 0 Then
	movf	SYSETHERBUFFER_37,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF75
;Select Case Tcp_destportl
;Case 80 : ENC28j60_http
SysSelect3Case1
	movlw	80
	subwf	SYSETHERBUFFER_38,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case2
	banksel	0
	call	ENC28J60_HTTP
;End Select
SysSelect3Case2
SysSelectEnd3
;End If
ENDIF75
;End If
ENDIF73
;End If
ENDIF70
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
SysWaitLoop18
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
	bra	SysWaitLoop18
;ENC28j60_writeReg(etxndl , (ENC_TXBUF_STL + pcktlen ) & 0xFF )
	movlw	6
	movwf	ADDR,BANKED
	movlw	112
	addwf	PCKTLEN,W,BANKED
	movwf	SysTemp2,BANKED
	movlw	0
	addwfc	PCKTLEN_H,W,BANKED
	movwf	SysTemp2_H,BANKED
	movff	SysTemp2,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28j60_writeReg(etxndh , ENC_TXBUF_STH + pcktlen_h )
	movlw	7
	movwf	ADDR,BANKED
	movlw	22
	addwf	PCKTLEN_H,W,BANKED
	movwf	ENC_OUTBYTE,BANKED
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
SysWaitLoop19
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
	bra	SysWaitLoop19
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
;ENC28j60_Setst_mac
	call	ENC28J60_SETST_MAC
;T_id0 = ip_id_h
	movff	IP_ID_H,SYSETHERBUFFER_19
;T_id1 = [byte]ip_id
	movff	IP_ID,SYSETHERBUFFER_20
;Ip_id = Ip_id + 1
	incf	IP_ID,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	IP_ID_H,F,BANKED
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
;Packetlength = etherBuffer(17) * 256
	movff	SYSETHERBUFFER_17,SysWORDTempA
	clrf	SysWORDTempA_H,ACCESS
	clrf	SysWORDTempB,ACCESS
	movlw	1
	movwf	SysWORDTempB_H,ACCESS
	banksel	0
	call	SysMultSub16
	movff	SysWORDTempX,PACKETLENGTH
	movff	SysWORDTempX_H,PACKETLENGTH_H
;Packetlength = Packetlength + etherBuffer(18)
	banksel	SYSETHERBUFFER_18
	movf	SYSETHERBUFFER_18,W,BANKED
	banksel	PACKETLENGTH
	addwf	PACKETLENGTH,F,BANKED
	movlw	0
	addwfc	PACKETLENGTH_H,F,BANKED
;Packetlength = Packetlength + 13                         'We are going to calculate the checksum till the end of packet (IP length + 14 byte of the ethernet stuff), -1 to get word start
	movlw	13
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
	call	ENC28J60_WRITEBUFFER
;ENC28j60_packetsend(packetlength)
	movff	PACKETLENGTH,PCKTLEN
	movff	PACKETLENGTH_H,PCKTLEN_H
	bra	ENC28J60_PACKETSEND

;********************************************************************************

ENC28J60_POLL
;ENC28j60_data = ENC28j60_ReadReg( erevid )
	movlw	114
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;If ENC28j60_ReadReg( epktcnt ) > 0 Then
	movlw	57
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movf	ENC28J60_READREG,W,BANKED
	sublw	0
	btfsc	STATUS, C,ACCESS
	bra	ENDIF10
;ENC28j60_packetreceive(etherBufferSize)
	movlw	44
	movwf	MAXLEN,BANKED
	movlw	1
	movwf	MAXLEN_H,BANKED
	rcall	ENC28J60_PACKETRECEIVE
;End If
ENDIF10
	return

;********************************************************************************

ENC28J60_READBUFFER
;dim eth_counter as Word
;if etherGetLength  > 1518 then Exit Sub
	movff	ETHERGETLENGTH,SysWORDTempB
	movff	ETHERGETLENGTH_H,SysWORDTempB_H
	movlw	238
	movwf	SysWORDTempA,ACCESS
	movlw	5
	movwf	SysWORDTempA_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	return
;ENC28j60_Select
	bcf	LATA,5,ACCESS
;Set WCOL Off
	bcf	SSPCON1,WCOL,ACCESS
;SSPBUF = ENC28j60_READ_BUF_MEM
	movlw	58
	movwf	SSPBUF,ACCESS
;Wait While BF = Off
SysWaitLoop12
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop12
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
	movlw	44
	movwf	SysWORDTempA,ACCESS
	movlw	1
	movwf	SysWORDTempA_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
;exit for
	bra	SysForLoopEnd5
;end if
;SSPBUF = 0
	clrf	SSPBUF,ACCESS
;Wait While BF = Off
SysWaitLoop13
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop13
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
	movlw	44
	movwf	SysWORDTempA,ACCESS
	movlw	1
	movwf	SysWORDTempA_H,ACCESS
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF80
;for eth_counter = etherBufferSize+1 to etherGetLength
	movlw	44
	movwf	ETH_COUNTER,BANKED
	movlw	1
	movwf	ETH_COUNTER_H,BANKED
	movlw	45
	movwf	SysWORDTempB,ACCESS
	movlw	1
	movwf	SysWORDTempB_H,ACCESS
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
SysWaitLoop14
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop14
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
ENDIF80
;ENC28j60_Deselect
	bsf	LATA,5,ACCESS
	return

;********************************************************************************

FN_ENC28J60_READREG
;banktobeselected =  ( addr & BANK_MASK) / 32
	movlw	96
	andwf	ADDR,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SysBYTETempA
	movlw	32
	movwf	SysBYTETempB,ACCESS
	call	SysDivSub
	movff	SysBYTETempA,BANKTOBESELECTED
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
	call	ENC28J60_SELECTBANK
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
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;HSerPrint "Registerdump ENC28j60"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable27
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable27
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT239
;ENC28j60_data = ENC28j60_ReadReg( erevid)
	movlw	114
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint " Version: " + str( ENC28j60_data )
	movff	ENC28J60_DATA,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	call	FN_STR
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable28
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable28
	movwf	TBLPTRH,ACCESS
	call	SysReadStringPart
	lfsr	0,STR
	call	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM1
	movff	SysStringLength, INDF0
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT239
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;HSerPrint "Cntrl: ECON1 ECON2 ESTAT  EIR  EIE"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable29
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable29
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT239
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;ENC28j60_data = ENC28j60_ReadReg( econ1)
	movlw	31
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "       " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable30
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable30
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
	call	HSERPRINT239
;ENC28j60_data = ENC28j60_ReadReg( econ2)
	movlw	30
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "    " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable31
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable31
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
	call	HSERPRINT239
;ENC28j60_data = ENC28j60_ReadReg( estat)
	movlw	29
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "    " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable31
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable31
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
	call	HSERPRINT239
;ENC28j60_ReadReg (eir)
	movlw	28
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
;HSerPrint "     " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable32
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable32
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
	call	HSERPRINT239
;ENC28j60_data = ENC28j60_ReadReg( eie)
	movlw	27
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "   " + Hex(ENC28j60_data)
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
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
	call	HSERPRINT239
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;HSerPrint "MAC  : MACON1  MACON2  MACON3  MACON4  MAC-Address"
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
	call	HSERPRINT239
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;ENC28j60_data = ENC28j60_ReadReg( macon1)
	movlw	192
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "       " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable30
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable30
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
	call	HSERPRINT239
;ENC28j60_data = ENC28j60_ReadReg( macon2)
	movff	MACON2,ADDR
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "      " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable35
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable35
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
	call	HSERPRINT239
;ENC28j60_data = ENC28j60_ReadReg( macon3)
	movlw	194
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "      " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable35
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable35
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
	call	HSERPRINT239
;ENC28j60_data = ENC28j60_ReadReg( macon4)
	movlw	195
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "      " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable35
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable35
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
	call	HSERPRINT239
;ENC28j60_data = ENC28j60_ReadReg( maadr5)
	movlw	228
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "      " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable35
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable35
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
	call	HSERPRINT239
;ENC28j60_data = ENC28j60_ReadReg( maadr4)
	movlw	229
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "." + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable36
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable36
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
	call	HSERPRINT239
;ENC28j60_data = ENC28j60_ReadReg( maadr3)
	movlw	226
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "." + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable36
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable36
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
	call	HSERPRINT239
;ENC28j60_data = ENC28j60_ReadReg( maadr2)
	movlw	227
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "." + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable36
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable36
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
	call	HSERPRINT239
;ENC28j60_data = ENC28j60_ReadReg( maadr1)
	movlw	224
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "." + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable36
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable36
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
	call	HSERPRINT239
;ENC28j60_data = ENC28j60_ReadReg( maadr0)
	movlw	225
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "." + Hex(ENC28j60_data)
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable36
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable36
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
	call	HSERPRINT239
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;HSerPrint "Rx   : ERXST  ERXND  ERXWRPT ERXRDPT ERXFCON EPKTCNT MAMXFL"
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
	call	HSERPRINT239
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;ENC28j60_data = ENC28j60_ReadReg(erxsth)
	movlw	9
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "       " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable30
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable30
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
	call	HSERPRINT239
;ENC28j60_data = ENC28j60_ReadReg(erxstl)
	movlw	8
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT239
;ENC28j60_data = ENC28j60_ReadReg(erxndh)
	movlw	11
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "   " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
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
	call	HSERPRINT239
;ENC28j60_data = ENC28j60_ReadReg(erxndl)
	movlw	10
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT239
;ENC28j60_data = ENC28j60_ReadReg(erxwrpth)
	movlw	15
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "   " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
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
	call	HSERPRINT239
;ENC28j60_data = ENC28j60_ReadReg(erxwrptl)
	movlw	14
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT239
;ENC28j60_data = ENC28j60_ReadReg(erxrdpth)
	movlw	13
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "    " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable31
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable31
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
	call	HSERPRINT239
;ENC28j60_data = ENC28j60_ReadReg(erxrdptl)
	movlw	12
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT239
;ENC28j60_data = ENC28j60_ReadReg(erxfcon)
	movlw	56
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "    " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable31
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable31
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
	call	HSERPRINT239
;ENC28j60_data = ENC28j60_ReadReg(epktcnt)
	movlw	57
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "      " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable35
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable35
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
	call	HSERPRINT239
;ENC28j60_data = ENC28j60_ReadReg(mamxflh)
	movlw	203
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "      " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable35
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable35
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
	call	HSERPRINT239
;ENC28j60_data = ENC28j60_ReadReg(mamxfll)
	movlw	202
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint Hex(ENC28j60_data)
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT239
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;HSerPrint "Tx   : ETXST  ETXND  EWRPT  MACLCON1 MACLCON2 MAPHSUP"
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
	call	HSERPRINT239
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;ENC28j60_data = ENC28j60_ReadReg(etxsth)
	movlw	5
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "       " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable30
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable30
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
	call	HSERPRINT239
;ENC28j60_data = ENC28j60_ReadReg(etxstl)
	movlw	4
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT239
;ENC28j60_data = ENC28j60_ReadReg(etxndh)
	movlw	7
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "   " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
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
	call	HSERPRINT239
;ENC28j60_data = ENC28j60_ReadReg(etxndl)
	movlw	6
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT239
;ENC28j60_data = ENC28j60_ReadReg(EWRPTH)
	movlw	3
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "   " +  Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
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
	call	HSERPRINT239
;ENC28j60_data = ENC28j60_ReadReg(EWRPTl)
	movlw	2
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT239
;ENC28j60_data = ENC28j60_ReadReg(maclcon1)
	movlw	200
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "   " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
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
	call	HSERPRINT239
;ENC28j60_data = ENC28j60_ReadReg(maclcon2)
	movlw	201
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "       " + Hex(ENC28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable30
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable30
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
	call	HSERPRINT239
;ENC28j60_data = ENC28j60_ReadReg(maphsup)
	movff	MAPHSUP,ADDR
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "       " + Hex(ENC28j60_data)
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable30
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable30
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
	call	HSERPRINT239
;HSerPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	goto	HSERPRINTCRLF

;********************************************************************************

ENC28J60_SELECTBANK
;ENC28j60_Select
	bcf	LATA,5,ACCESS
;FastHWSPITransfer(BFCCMD | ECON1, temp)
	movlw	191
	movwf	SPITXDATA,BANKED
	call	FASTHWSPITRANSFER
;FastHWSPITransfer(b'00000011', temp)
	movlw	3
	movwf	SPITXDATA,BANKED
	call	FASTHWSPITRANSFER
;ENC28j60_Deselect
	bsf	LATA,5,ACCESS
;ENC28j60_Select
	bcf	LATA,5,ACCESS
;FastHWSPITransfer(BFSCMD | ECON1, temp)
	movlw	159
	movwf	SPITXDATA,BANKED
	call	FASTHWSPITRANSFER
;Select case banktobeselected
;case 1
SysSelect1Case1
	decf	BANKTOBESELECTED,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case2
;FastHWSPITransfer(b'00000001' , temp)
	movlw	1
	movwf	SPITXDATA,BANKED
	call	FASTHWSPITRANSFER
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
	call	FASTHWSPITRANSFER
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
	call	FASTHWSPITRANSFER
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
;ENC28j60_Setst_mac
	rcall	ENC28J60_SETST_MAC
;ENC28j60_Ip_header_checksum
	call	ENC28J60_IP_HEADER_CHECKSUM
;Calcchecksum(15 , 33 , 25)
	return

;********************************************************************************

ENC28J60_SETST_MAC
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

ENC28J60_SNTP
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
	rcall	ENC28J60_UTC_ADJUST
;HserPrint "Date "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable39
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable39
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT239
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
	call	HSERPRINT243
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
	movlw	low StringTable40
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable40
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT239
;HSerPrint l2
	movff	L2,SERPRINTVAL
	movff	L2_H,SERPRINTVAL_H
	movff	L2_U,SERPRINTVAL_U
	movff	L2_E,SERPRINTVAL_E
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT243
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;HserPrint "Time "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable41
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable41
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT239
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
	bra	ENDIF117
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable42
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable42
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT239
ENDIF117
;HSerPrint l2
	movff	L2,SERPRINTVAL
	movff	L2_H,SERPRINTVAL_H
	movff	L2_U,SERPRINTVAL_U
	movff	L2_E,SERPRINTVAL_E
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT243
;HSerPrint ":"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable43
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable43
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT239
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
	bra	ENDIF118
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable42
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable42
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT239
ENDIF118
;HSerPrint l2
	movff	L2,SERPRINTVAL
	movff	L2_H,SERPRINTVAL_H
	movff	L2_U,SERPRINTVAL_U
	movff	L2_E,SERPRINTVAL_E
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT243
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
	movlw	low StringTable43
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable43
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT239
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
	bra	ENDIF119
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable42
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable42
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT239
ENDIF119
;HSerPrint l2
	movff	L2,SERPRINTVAL
	movff	L2_H,SERPRINTVAL_H
	movff	L2_U,SERPRINTVAL_U
	movff	L2_E,SERPRINTVAL_E
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT243
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	bra	HSERPRINTCRLF

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
	banksel	SYSETHERBUFFER_47
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
;Hulp2 = Hulp2 + T_udp_len1
	banksel	SYSETHERBUFFER_40
	movf	SYSETHERBUFFER_40,W,BANKED
	banksel	HULP2
	addwf	HULP2,F,BANKED
;Hulp2 = Hulp2 + 34
	movlw	34
	addwf	HULP2,F,BANKED
;ENC28j60_writebuffer( 45 )
	movlw	45
	movwf	PCKTLEN,BANKED
	clrf	PCKTLEN_H,BANKED
	rcall	ENC28J60_WRITEBUFFER
;ENC28j60_packetsend( hulp2 )
	movff	HULP2,PCKTLEN
	clrf	PCKTLEN_H,BANKED
	goto	ENC28J60_PACKETSEND

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
	clrf	SysTemp3,BANKED
	movf	I_CHKSUM32_U,W,BANKED
	addwfc	SysTemp3,W,BANKED
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
	clrf	SysTemp3,BANKED
	movf	I_CHKSUM32_U,W,BANKED
	addwfc	SysTemp3,W,BANKED
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
	clrf	SysTemp3,BANKED
	movf	I_CHKSUM32_U,W,BANKED
	addwfc	SysTemp3,W,BANKED
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
	clrf	SysTemp3,BANKED
	movf	I_CHKSUM32_U,W,BANKED
	addwfc	SysTemp3,W,BANKED
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
	clrf	SysTemp3,BANKED
	movf	I_CHKSUM32_U,W,BANKED
	addwfc	SysTemp3,W,BANKED
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
	movwf	SysTemp2,BANKED
	movlw	0
	addwfc	I_VALUE16_H,W,ACCESS
	movwf	SysTemp2_H,BANKED
	movlw	22
	subwf	SysTemp2,W,BANKED
	movwf	HULP2,BANKED
	movlw	0
	subwfb	SysTemp2_H,W,BANKED
	movwf	HULP2_H,BANKED
;I_odd = T_udp_len1 Mod 2
	clrf	I_ODD,BANKED
	banksel	SYSETHERBUFFER_40
	btfss	SYSETHERBUFFER_40,0,BANKED
	bra	ENDIF123
	banksel	I_ODD
	incf	I_ODD,F,BANKED
ENDIF123
;If I_odd = 1 Then
	banksel	I_ODD
	decf	I_ODD,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF120
;Hulp2 =  Hulp2 + 1
	incf	HULP2,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	HULP2_H,F,BANKED
;etherbuffer( Hulp2 + 1 ) = 0x00
	lfsr	0,ETHERBUFFER
	movf	HULP2,W,BANKED
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp2,BANKED
	movlw	0
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp2_H,BANKED
	movlw	1
	addwf	SysTemp2,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	clrf	INDF0,ACCESS
;End If
ENDIF120
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
	bra	SysForLoopEnd13
SysForLoop13
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
	movwf	SysTemp2,BANKED
	movlw	0
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp2_H,BANKED
	movlw	1
	addwf	SysTemp2,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,I_VALUE16
;I_chksum32 = I_value16 + I_chksum32
	movf	I_CHKSUM32,W,BANKED
	addwf	I_VALUE16,W,ACCESS
	movwf	I_CHKSUM32,BANKED
	movf	I_CHKSUM32_H,W,BANKED
	addwfc	I_VALUE16_H,W,ACCESS
	movwf	I_CHKSUM32_H,BANKED
	clrf	SysTemp3,BANKED
	movf	I_CHKSUM32_U,W,BANKED
	addwfc	SysTemp3,W,BANKED
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
	bra	SysForLoop13
SysForLoopEnd13
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

ENC28J60_UDP
;dim T_udp_destport as word
;Dim hulp2 As Word
;T_udp_destport = ( T_udp_destport0 * 256 ) + T_udp_destport1
	movff	SYSETHERBUFFER_37,SysWORDTempA
	clrf	SysWORDTempA_H,ACCESS
	clrf	SysWORDTempB,ACCESS
	movlw	1
	movwf	SysWORDTempB_H,ACCESS
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
;select case T_udp_srcport1
;case 0x25
SysSelect4Case1
	movlw	37
	banksel	SYSETHERBUFFER_36
	subwf	SYSETHERBUFFER_36,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case2
;ENC28j60_SNTP
	banksel	0
	rcall	ENC28J60_SNTP
;Exit Sub
	return
;end select
SysSelect4Case2
SysSelectEnd4
;select case T_udp_destport
;case 6000
SysSelect5Case1
	movff	T_UDP_DESTPORT,SysWORDTempA
	movff	T_UDP_DESTPORT_H,SysWORDTempA_H
	movlw	112
	movwf	SysWORDTempB,ACCESS
	movlw	23
	movwf	SysWORDTempB_H,ACCESS
	banksel	0
	call	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect5Case2
;if T_udp_data = "R" then
	movlw	82
	banksel	SYSETHERBUFFER_43
	subwf	SYSETHERBUFFER_43,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF84
;ENC28j60_Initialise
	banksel	0
	call	ENC28J60_INITIALISE
;goto Reset_ENC26j60
	goto	RESET_ENC26J60
;end if
ENDIF84
;if T_udp_data = "D" then
	movlw	68
	subwf	SYSETHERBUFFER_43,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF85
;ENC28j60_regdump
	banksel	0
	call	ENC28J60_REGDUMP
;end if
ENDIF85
;case 5000
	bra	SysSelectEnd5
SysSelect5Case2
	movff	T_UDP_DESTPORT,SysWORDTempA
	movff	T_UDP_DESTPORT_H,SysWORDTempA_H
	movlw	136
	movwf	SysWORDTempB,ACCESS
	movlw	19
	movwf	SysWORDTempB_H,ACCESS
	call	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect5Case3
;Select Case T_udp_data
;Case "A" : HSerPrint "Action A"
;Case "B" : HSerPrint "Action B"
;Case "C" : HSerPrint "Action C"
;Case "D" : HSerPrint "Action D"
;Case "E" : HSerPrint "Action E"
;Case "T" : HserPrint "Time..."
;CASE "T"
SysSelect6Case1
	movlw	84
	banksel	SYSETHERBUFFER_43
	subwf	SYSETHERBUFFER_43,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case2
;ENC28j60_sntp_get
	banksel	0
	rcall	ENC28J60_SNTP_GET
;Case "a" : HSerPrint "Action a"
;Case "b" : HSerPrint "Action b"
;Case "c" : HSerPrint "Action c"
;Case "d" : HSerPrint "Action d"
;Case "e" : HSerPrint "Action e"
;
;Case Else : HSerPrint "Action F"
;End Select
SysSelect6Case2
SysSelectEnd6
;'         HSerPrintCRLF
;case 7
	bra	SysSelectEnd5
SysSelect5Case3
	movff	T_UDP_DESTPORT,SysWORDTempA
	movff	T_UDP_DESTPORT_H,SysWORDTempA_H
	movlw	7
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect5Case4
;ENC28j60_Setipaddrs
	rcall	ENC28J60_SETIPADDRS
;Swap T_udp_srcport0 , T_udp_destport0
	movff	SYSETHERBUFFER_35,SYSCALCTEMPA
	movff	SYSETHERBUFFER_37,SYSCALCTEMPB
	call	SWAP79
	movff	SYSCALCTEMPA,SYSETHERBUFFER_35
	movff	SYSCALCTEMPB,SYSETHERBUFFER_37
;Swap T_udp_srcport1 , T_udp_destport1
	movff	SYSETHERBUFFER_36,SYSCALCTEMPA
	movff	SYSETHERBUFFER_38,SYSCALCTEMPB
	call	SWAP79
	movff	SYSCALCTEMPA,SYSETHERBUFFER_36
	movff	SYSCALCTEMPB,SYSETHERBUFFER_38
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
;ENC28j60_writebuffer( hulp2 )
	movff	HULP2,PCKTLEN
	movff	HULP2_H,PCKTLEN_H
	rcall	ENC28J60_WRITEBUFFER
;ENC28j60_packetsend( hulp2 )
	movff	HULP2,PCKTLEN
	movff	HULP2_H,PCKTLEN_H
	call	ENC28J60_PACKETSEND
;end select
SysSelect5Case4
SysSelectEnd5
	banksel	0
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
SysWaitLoop15
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop15
;temp = SSPBUF
	movff	SSPBUF,TEMP
;SSPBUF = 0x0E
	movlw	14
	movwf	SSPBUF,ACCESS
;Wait While BF = Off
SysWaitLoop16
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop16
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
	movlw	44
	movwf	SysWORDTempA,ACCESS
	movlw	1
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
SysWaitLoop17
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop17
;temp = SSPBUF
	movff	SSPBUF,TEMP
;next
	movff	ETH_COUNTER,SysWORDTempA
	movff	ETH_COUNTER_H,SysWORDTempA_H
	movff	PCKTLEN,SysWORDTempB
	movff	PCKTLEN_H,SysWORDTempB_H
	rcall	SysCompLessThan16
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
	call	FN_ENC28J60_READREG
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
	call	FN_ENC28J60_READREG
	movlw	1
	andwf	ENC28J60_READREG,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SysBYTETempA
	movlw	1
	movwf	SysBYTETempB,ACCESS
	rcall	SysCompEqual
	btfsc	SysByteTempX,0,ACCESS
	bra	SysWaitLoop6
	return

;********************************************************************************

ENC28J60_WRITEREG
;banktobeselected = ( addr & BANK_MASK) / 32
	movlw	96
	andwf	ADDR,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SysBYTETempA
	movlw	32
	movwf	SysBYTETempB,ACCESS
	rcall	SysDivSub
	movff	SysBYTETempA,BANKTOBESELECTED
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
	rcall	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	btfsc	SysByteTempX,0,ACCESS
;ENC28j60_selectBank ( banktobeselected, addr )
	call	ENC28J60_SELECTBANK
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

FN_FNLSL
;dim SysLongTempB as long
;SysLongTempB  = BitsIn
;Repeat NumBits
	movff	NUMBITS,SysRepeatTemp6
	movf	SYSREPEATTEMP6,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd6
SysRepeatLoop6
;Set C Off
	bcf	STATUS,C,ACCESS
;Rotate SysLongTempB Left
	rlcf	SYSLONGTEMPB,F,ACCESS
	rlcf	SYSLONGTEMPB_H,F,ACCESS
	rlcf	SYSLONGTEMPB_U,F,ACCESS
	rlcf	SYSLONGTEMPB_E,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp6,F,BANKED
	bra	SysRepeatLoop6
SysRepeatLoopEnd6
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
	movff	NUMBITS,SysRepeatTemp5
	movf	SYSREPEATTEMP5,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd5
SysRepeatLoop5
;Set C Off
	bcf	STATUS,C,ACCESS
;Rotate SysLongTempB Right
	rrcf	SYSLONGTEMPB_E,F,ACCESS
	rrcf	SYSLONGTEMPB_U,F,ACCESS
	rrcf	SYSLONGTEMPB_H,F,ACCESS
	rrcf	SYSLONGTEMPB,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp5,F,BANKED
	bra	SysRepeatLoop5
SysRepeatLoopEnd5
;FnLSR = SysLongTempB
	movff	SYSLONGTEMPB,FNLSR
	movff	SYSLONGTEMPB_H,FNLSR_H
	movff	SYSLONGTEMPB_U,FNLSR_U
	movff	SYSLONGTEMPB_E,FNLSR_E
	return

;********************************************************************************

FN_FNNOTBIT
;If BitIn then
	movf	BITIN,F,BANKED
	btfsc	STATUS,Z,ACCESS
	bra	ELSE15_1
;FnNOTBit = 0
	bcf	FNNOTBIT,BANKED
;Else
	bra	ENDIF15
ELSE15_1
;FnNOTBit = 1
	bsf	FNNOTBIT,BANKED
;End If
ENDIF15
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
	bra	ENDIF40
	movlw	7
	addwf	SYSSTRINGTEMP,F,BANKED
ENDIF40
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
	bra	ENDIF42
	movlw	7
	addwf	SYSSTRINGTEMP,F,BANKED
ENDIF42
;Hex(1) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W,BANKED
	banksel	SYSHEX_1
	movwf	SYSHEX_1,BANKED
	banksel	0
	return

;********************************************************************************

;Overloaded signature: STRING:byte:
HSERPRINT239
;PrintLen = PrintData(0)
	movff	SysPRINTDATAHandler,AFSR0
	movff	SysPRINTDATAHandler_H,AFSR0_H
	movff	INDF0,PRINTLEN
;If PrintLen <> 0 then
	movf	PRINTLEN,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF44
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
ENDIF44
	return

;********************************************************************************

;Overloaded signature: BYTE:byte:
HSERPRINT240
;OutValueTemp = 0
	clrf	OUTVALUETEMP,BANKED
;IF SerPrintVal >= 100 Then
	movlw	100
	subwf	SERPRINTVAL,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	ENDIF47
;OutValueTemp = SerPrintVal / 100
	movff	SERPRINTVAL,SysBYTETempA
	movlw	100
	movwf	SysBYTETempB,ACCESS
	rcall	SysDivSub
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
ENDIF47
;If OutValueTemp > 0 Or SerPrintVal >= 10 Then
	movff	OUTVALUETEMP,SysBYTETempB
	clrf	SysBYTETempA,ACCESS
	rcall	SysCompLessThan
	movff	SysByteTempX,SysTemp2
	movff	SERPRINTVAL,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	rcall	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movf	SysTemp2,W,BANKED
	iorwf	SysByteTempX,W,ACCESS
	movwf	SysTemp1,BANKED
	btfss	SysTemp1,0,BANKED
	bra	ENDIF48
;OutValueTemp = SerPrintVal / 10
	movff	SERPRINTVAL,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	rcall	SysDivSub
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
ENDIF48
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

;Overloaded signature: LONG:byte:
HSERPRINT243
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
	rcall	SysDivSub32
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
	rcall	SysCompEqual32
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
	movff	HSERPRINTCRLFCOUNT,SysRepeatTemp3
	movf	SYSREPEATTEMP3,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd3
SysRepeatLoop3
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
	decfsz	SysRepeatTemp3,F,BANKED
	bra	SysRepeatLoop3
SysRepeatLoopEnd3
	return

;********************************************************************************

HSERSEND
;if comport = 1 Then
	decf	COMPORT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF43
;Wait While TXIF = Off
SysWaitLoop8
	btfss	PIR1,TXIF,ACCESS
	bra	SysWaitLoop8
;Wait While TXIF = Off
SysWaitLoop9
	btfss	PIR1,TXIF,ACCESS
	bra	SysWaitLoop9
;TXREG = SerData
	movff	SERDATA,TXREG
;end if
ENDIF43
	return

;********************************************************************************

I2CRESTART
;I2CStart
	bra	I2CSTART

;********************************************************************************

I2CSEND
;I2C_CLOCK_LOW                 'begin with SCL=0
	bcf	TRISC,3,ACCESS
	bcf	LATC,3,ACCESS
;wait I2C_END_DELAY            'let port settle
	movlw	1
	movwf	DELAYTEMP,ACCESS
DelayUS5
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS5
	nop
;repeat 8                      '8 data bits
	movlw	8
	movwf	SysRepeatTemp4,BANKED
SysRepeatLoop4
;if I2CByte.7 = ON then      'put most significant bit on SDA line
	btfss	I2CBYTE,7,BANKED
	bra	ELSE51_1
;I2C_DATA_HIGH
	bsf	TRISC,4,ACCESS
;else
	bra	ENDIF51
ELSE51_1
;I2C_DATA_LOW
	bcf	TRISC,4,ACCESS
	bcf	LATC,4,ACCESS
;end if
ENDIF51
;rotate I2CByte left         'shift in bit for the next time
	rlcf	I2CBYTE,F,BANKED
;I2C_CLOCK_HIGH              'now clock it in
	bsf	TRISC,3,ACCESS
;wait while I2C_CLOCK = OFF  'permit clock stretching here
SysWaitLoop10
	btfss	PORTC,3,ACCESS
	bra	SysWaitLoop10
;wait I2C_CLOCK_DELAY        'clock pulse width given here
	movlw	1
	movwf	DELAYTEMP,ACCESS
DelayUS6
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS6
	nop
;I2C_CLOCK_LOW               'done clocking that bit
	bcf	TRISC,3,ACCESS
	bcf	LATC,3,ACCESS
;wait I2C_END_DELAY          'time between clock pulses
	movlw	1
	movwf	DELAYTEMP,ACCESS
DelayUS7
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS7
	nop
;end repeat                    'then do next bit
	decfsz	SysRepeatTemp4,F,BANKED
	bra	SysRepeatLoop4
SysRepeatLoopEnd4
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
	bsf	TRISC,3,ACCESS
;wait while I2C_CLOCK = OFF    'permit clock stretching here
SysWaitLoop11
	btfss	PORTC,3,ACCESS
	bra	SysWaitLoop11
;if I2C_DATA then              'read 9th bit in from Slave
	btfss	PORTC,4,ACCESS
	bra	ELSE52_1
;I2CAck = FALSE              'return a NAK to the program
	clrf	I2CACK,BANKED
;I2CSendState =  FALSE        'state of target device with respect. Retained for backwards compatibility
	clrf	I2CACKPOLLSTATE,BANKED
;else
	bra	ENDIF52
ELSE52_1
;I2CAck = TRUE               'else, return an ACK to the program
	setf	I2CACK,BANKED
;I2CSendState =  TRUE        'state of target device with respect. Retained for backwards compatibility
	setf	I2CACKPOLLSTATE,BANKED
;end if
ENDIF52
;I2C_CLOCK_LOW                 'may be more bytes to clock out
	bcf	TRISC,3,ACCESS
	bcf	LATC,3,ACCESS
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
	bsf	TRISC,3,ACCESS
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
	bcf	TRISC,3,ACCESS
	bcf	LATC,3,ACCESS
	return

;********************************************************************************

I2CSTOP
;I2C_CLOCK_LOW                 'begin with SCL=0 and SDA=0
	bcf	TRISC,3,ACCESS
	bcf	LATC,3,ACCESS
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
	bsf	TRISC,3,ACCESS
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
	bsf	TRISC,3,ACCESS
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
	movwf	SysRepeatTemp2,BANKED
SysRepeatLoop2
;LCD_I2C_Address_Current = LCD_I2C_Address_1
	movlw	78
	movwf	LCD_I2C_ADDRESS_CURRENT,BANKED
;initI2CLCD
	rcall	INITI2CLCD
;end repeat
	decfsz	SysRepeatTemp2,F,BANKED
	bra	SysRepeatLoop2
SysRepeatLoopEnd2
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

LCDBACKLIGHT
;IF LCDTemp = OFF then LCD_Backlight = LCD_Backlight_Off_State
	movf	LCDTEMP,F,BANKED
	btfsc	STATUS, Z,ACCESS
	clrf	LCD_BACKLIGHT,BANKED
;IF LCDTemp = ON then  LCD_Backlight = LCD_Backlight_On_State
	decf	LCDTEMP,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF33
	movlw	1
	movwf	LCD_BACKLIGHT,BANKED
ENDIF33
;Set LCD_RS OFF
	bcf	SYSLCDTEMP,1,BANKED
;LCDWriteByte(0)
	clrf	LCDBYTE,BANKED
	bra	LCDNORMALWRITEBYTE

;********************************************************************************

LCDNORMALWRITEBYTE
;*****    This subroutine  modified by William Roth *****
;Reduced enable pulse to 2 us
;Added define for LCD_SPEED Slow , Medium , fast
;IF LCD_RS = 1 then
	btfss	SYSLCDTEMP,1,BANKED
	bra	ELSE20_1
;i2c_lcd_rs=1;   ''' Data
	bsf	I2C_LCD_BYTE,0,BANKED
;ELSE
	bra	ENDIF20
ELSE20_1
;i2c_lcd_rs=0;   ''' Command
	bcf	I2C_LCD_BYTE,0,BANKED
;end if
ENDIF20
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
	bra	ENDIF21
;if LCDByte > 7 then
	movf	LCDBYTE,W,BANKED
	sublw	7
	btfss	STATUS, C,ACCESS
;LCD_State = LCDByte
	movff	LCDBYTE,LCD_STATE
;end if
;END IF
ENDIF21
	return

;********************************************************************************

LOCATE
;Set LCD_RS Off
	bcf	SYSLCDTEMP,1,BANKED
;If LCDLine > 1 Then
	movf	LCDLINE,W,BANKED
	sublw	1
	btfsc	STATUS, C,ACCESS
	bra	ENDIF16
;LCDLine = LCDLine - 2
	movlw	2
	subwf	LCDLINE,F,BANKED
;LCDColumn = LCDColumn + 20
	movlw	20
	addwf	LCDCOLUMN,F,BANKED
;End If
ENDIF16
;LCDWriteByte(0x80 or 0x40 * LCDLine + LCDColumn)
	movf	LCDLINE,W,BANKED
	mullw	64
	movf	LCDCOLUMN,W,BANKED
	addwf	PRODL,W,ACCESS
	movwf	SysTemp1,BANKED
	movlw	128
	iorwf	SysTemp1,W,BANKED
	movwf	LCDBYTE,BANKED
	rcall	LCDNORMALWRITEBYTE
;wait 5 10us 'test
	movlw	5
	movwf	SysWaitTemp10US,ACCESS
	goto	Delay_10US

;********************************************************************************

;Overloaded signature: STRING:
PRINT107
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
SPIMODE195
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

FN_STR
;SysCharCount = 0
	clrf	SYSCHARCOUNT,BANKED
;Dim SysCalcTempX As Word
;IF SysValTemp >= 10000 then
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB,ACCESS
	movlw	39
	movwf	SysWORDTempB_H,ACCESS
	rcall	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF36
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
ENDIF36
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
	bra	ENDIF37
SYSVALTHOUSANDS
;SysStrData = SysValTemp / 1000
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB,ACCESS
	movlw	3
	movwf	SysWORDTempB_H,ACCESS
	rcall	SysDivSub16
	movff	SysWORDTempA,SYSSTRDATA
;SysValTemp = SysCalcTempX
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
;SysCharCount += 1
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
ENDIF37
;IF SysValTemp >= 100 then
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF38
SYSVALHUNDREDS
;SysStrData = SysValTemp / 100
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysDivSub16
	movff	SysWORDTempA,SYSSTRDATA
;SysValTemp = SysCalcTempX
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
;SysCharCount += 1
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
ENDIF38
;IF SysValTemp >= 10 Then
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF39
SYSVALTENS
;SysStrData = SysValTemp / 10
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysDivSub16
	movff	SysWORDTempA,SYSSTRDATA
;SysValTemp = SysCalcTempX
	movff	SYSCALCTEMPX,SYSVALTEMP
	movff	SYSCALCTEMPX_H,SYSVALTEMP_H
;SysCharCount += 1
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
ENDIF39
;SysCharCount += 1
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
	movff	SYSCHARCOUNT,SYSSTR_0
	return

;********************************************************************************

;Overloaded signature: BYTE:BYTE:
SWAP79
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
	bra	ENDIF89
;SysWordTempA = 0
	clrf	SYSWORDTEMPA,ACCESS
	clrf	SYSWORDTEMPA_H,ACCESS
;exit sub
	return
;end if
ENDIF89
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
	bra	ENDIF90
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0,ACCESS
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W,ACCESS
	addwf	SYSDIVMULTX,F,ACCESS
	movf	SYSDIVMULTB_H,W,ACCESS
	addwfc	SYSDIVMULTX_H,F,ACCESS
;End If
ENDIF90
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
	bra	ENDIF91
;SysLongTempA = 0
	clrf	SYSLONGTEMPA,ACCESS
	clrf	SYSLONGTEMPA_H,ACCESS
	clrf	SYSLONGTEMPA_U,ACCESS
	clrf	SYSLONGTEMPA_E,ACCESS
;exit sub
	return
;end if
ENDIF91
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
	bra	ENDIF92
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
ENDIF92
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

StringTable3
	dw	3084,"Initialising"


StringTable4
	dw	3341,"Initialising."


StringTable5
	dw	3598,"Initialising.."


StringTable6
	dw	3855,"Initialising..."


StringTable7
	dw	7196,"ENC28j60 Ethernet Driver 022"


StringTable8
	dw	2827,"Initialised"


StringTable9
	dw	771,"..."


StringTable10
	dw	514,", "


StringTable11
	dw	1542,"Flags:"


StringTable12
	dw	1028,"FIN "


StringTable13
	dw	1028,"SYN "


StringTable14
	dw	1028,"RST "


StringTable15
	dw	1028,"PSH "


StringTable16
	dw	1028,"ACK "


StringTable17
	dw	2056,"TCP_URG "


StringTable18
	dw	2570,"1) Handler"


StringTable19
	dw	2570,"2) Handler"


StringTable20
	dw	3084,"Tcp_ack = 1 "


StringTable21
	dw	3855,"Buffer(17) = 0 "


StringTable22
	dw	4112,"Buffer(18) = 40 "


StringTable23
	dw	2570,"3) Handler"


StringTable24
	dw	2313,"No packet"


StringTable27
	dw	5397,"Registerdump ENC28j60"


StringTable28
	dw	2570," Version: "


StringTable29
	dw	8738,"Cntrl: ECON1 ECON2 ESTAT  EIR  EIE"


StringTable30
	dw	1799,"       "


StringTable31
	dw	1028,"    "


StringTable32
	dw	1285,"     "


StringTable33
	dw	771,"   "


StringTable34
	dw	12850,"MAC  : MACON1  MACON2  MACON3  MACON4  MAC-Address"


StringTable35
	dw	1542,"      "


StringTable36
	dw	257,"."


StringTable37
	dw	15163,"Rx   : ERXST  ERXND  ERXWRPT ERXRDPT ERXFCON EPKTCNT MAMXFL"


StringTable38
	dw	13621,"Tx   : ETXST  ETXND  EWRPT  MACLCON1 MACLCON2 MAPHSUP"


StringTable39
	dw	1285,"Date "


StringTable40
	dw	514,"D/"


StringTable41
	dw	1285,"Time "


StringTable42
	dw	257,"0"


StringTable43
	dw	257,":"


StringTable44
	dw	257,"R"


StringTable45
	dw	257,"D"


StringTable46
	dw	257,"T"


;********************************************************************************


 END
