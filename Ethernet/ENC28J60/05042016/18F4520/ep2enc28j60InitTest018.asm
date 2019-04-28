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
ADDR	EQU	13
ASC	EQU	14
BANKTOBESELECTED	EQU	15
BITIN	EQU	16
BUTTONSTATE	EQU	17
CNT	EQU	18
COMPORT	EQU	19
CRASH	EQU	20
DELAYTEMP	EQU	0
DELAYTEMP2	EQU	1
ENC28J60_DATA	EQU	21
ENC28J60_READREG	EQU	22
ENC28J60_TEMP	EQU	23
ENC_LAST_TXBUF	EQU	24
ENC_LAST_TXBUF_H	EQU	25
ENC_OUTBYTE	EQU	26
ENC_OUTBYTE1	EQU	27
ENC_OUTBYTE2	EQU	28
ENDPTR	EQU	29
ENDPTR_H	EQU	30
ETHERBUFFER	EQU	1405
ETHERGETLENGTH	EQU	31
ETHERGETLENGTH_H	EQU	32
ETH_COUNTER	EQU	33
ETH_COUNTER_H	EQU	35
ETH_FRAMELENGTH	EQU	36
ETH_FRAMELENGTH_H	EQU	38
FNLSL	EQU	39
FNLSL_E	EQU	42
FNLSL_H	EQU	40
FNLSL_U	EQU	41
FNLSR	EQU	43
FNLSR_E	EQU	46
FNLSR_H	EQU	44
FNLSR_U	EQU	45
FNNOTBIT	EQU	47
HEX	EQU	1322
HSERPRINTCRLFCOUNT	EQU	48
HULP1	EQU	49
HULP2	EQU	50
HULP2_H	EQU	51
HULP3	EQU	52
II	EQU	53
II_H	EQU	54
IPADDR	EQU	1346
IPPORT	EQU	55
IPROUTER	EQU	1341
IPSERVER	EQU	1336
IP_CHECKSUM16	EQU	56
IP_CHECKSUM16_H	EQU	57
IP_CHKSUM32	EQU	58
IP_CHKSUM32_E	EQU	61
IP_CHKSUM32_H	EQU	59
IP_CHKSUM32_U	EQU	60
IP_HEADER_LENGTH	EQU	62
IP_HULP1	EQU	63
IP_ID	EQU	64
IP_ID_H	EQU	66
IP_TEMP16	EQU	67
IP_TEMP16_H	EQU	68
IP_X	EQU	69
I_CHECKSUM16	EQU	70
I_CHECKSUM16_H	EQU	72
I_CHKSUM32	EQU	73
I_CHKSUM32_E	EQU	76
I_CHKSUM32_H	EQU	74
I_CHKSUM32_U	EQU	75
I_ODD	EQU	77
I_VALUE16	EQU	78
I_VALUE16_H	EQU	79
I_X	EQU	80
I_X_H	EQU	81
L1	EQU	82
L1_E	EQU	86
L1_H	EQU	87
L1_U	EQU	88
L2	EQU	89
LASTSELECTEDBANK	EQU	90
LOCALTMP	EQU	91
LOCALTMP_H	EQU	93
MACADDR	EQU	1357
MACADDRROUTER	EQU	1331
MACON2	EQU	94
MAPHSUP	EQU	95
MAXLEN	EQU	96
MAXLEN_H	EQU	97
MYDEBUGCOUNT	EQU	98
MYDEBUGCOUNT_E	EQU	101
MYDEBUGCOUNT_H	EQU	99
MYDEBUGCOUNT_U	EQU	100
NEXTPACKETPTR	EQU	102
NEXTPACKETPTR_H	EQU	104
NTPSERVERADDR	EQU	1326
NUMBITS	EQU	105
OLDPACKETCOUNTERIN	EQU	106
OLDPACKETCOUNTERIN_E	EQU	109
OLDPACKETCOUNTERIN_H	EQU	107
OLDPACKETCOUNTERIN_U	EQU	108
OLDPACKETCOUNTEROUT	EQU	110
OLDPACKETCOUNTEROUT_E	EQU	113
OLDPACKETCOUNTEROUT_H	EQU	111
OLDPACKETCOUNTEROUT_U	EQU	112
OUTVALUETEMP	EQU	114
PACKETCOUNTERIN	EQU	115
PACKETCOUNTERIN_E	EQU	118
PACKETCOUNTERIN_H	EQU	116
PACKETCOUNTERIN_U	EQU	117
PACKETCOUNTEROUT	EQU	119
PACKETCOUNTEROUT_E	EQU	122
PACKETCOUNTEROUT_H	EQU	120
PACKETCOUNTEROUT_U	EQU	121
PACKETLENGTH	EQU	123
PACKETLENGTH_H	EQU	124
PCKTLEN	EQU	125
PCKTLEN_H	EQU	127
PHYREGADDR	EQU	128
PREVIOUS_NEXTPACKETPTR	EQU	129
PREVIOUS_NEXTPACKETPTR_H	EQU	130
PRINTLEN	EQU	131
RESULT	EQU	132
RESULT16	EQU	134
RESULT16_H	EQU	135
RESULT_H	EQU	133
RXSTAT	EQU	136
RXSTAT_H	EQU	137
SERDATA	EQU	138
SERPRINTVAL	EQU	139
SPICLOCKMODE	EQU	140
SPICURRENTMODE	EQU	141
SPIRXDATA	EQU	142
SPITXDATA	EQU	143
STARTPTR	EQU	144
STARTPTR_H	EQU	145
STR	EQU	1351
STRINGPOINTER	EQU	146
SUM	EQU	147
SUM_E	EQU	150
SUM_H	EQU	148
SUM_U	EQU	149
SYSARRAYTEMP1	EQU	151
SYSARRAYTEMP2	EQU	152
SYSBYTETEMPA	EQU	5
SYSBYTETEMPB	EQU	9
SYSBYTETEMPX	EQU	0
SYSCALCTEMPA	EQU	5
SYSCALCTEMPB	EQU	9
SYSCALCTEMPX	EQU	0
SYSCALCTEMPX_H	EQU	1
SYSCHAR	EQU	153
SYSCHARCOUNT	EQU	154
SYSDIVLOOP	EQU	4
SYSDIVMULTA	EQU	7
SYSDIVMULTA_H	EQU	8
SYSDIVMULTB	EQU	11
SYSDIVMULTB_H	EQU	12
SYSDIVMULTX	EQU	2
SYSDIVMULTX_H	EQU	3
SYSFNBYTE1	EQU	155
SYSLONGTEMPB	EQU	9
SYSLONGTEMPB_E	EQU	12
SYSLONGTEMPB_H	EQU	10
SYSLONGTEMPB_U	EQU	11
SYSMACADDRHANDLER	EQU	156
SYSMACADDRHANDLER_H	EQU	157
SYSPRINTDATAHANDLER	EQU	158
SYSPRINTDATAHANDLER_H	EQU	159
SYSPRINTTEMP	EQU	160
SYSREPEATTEMP1	EQU	161
SYSREPEATTEMP2	EQU	162
SYSREPEATTEMP3	EQU	163
SYSREPEATTEMP4	EQU	164
SYSREPEATTEMP5	EQU	165
SYSSTRDATA	EQU	166
SYSSTRINGA	EQU	7
SYSSTRINGA_H	EQU	8
SYSSTRINGLENGTH	EQU	6
SYSSTRINGPARAM1	EQU	1364
SYSSTRINGTEMP	EQU	167
SYSSYSINSTRINGAHANDLER	EQU	168
SYSSYSINSTRINGAHANDLER_H	EQU	169
SYSTEMP1	EQU	170
SYSTEMP1_H	EQU	171
SYSTEMP2	EQU	172
SYSTEMP3	EQU	173
SYSVALTEMP	EQU	174
SYSVALTEMP_H	EQU	175
SYSWAITTEMPMS	EQU	2
SYSWAITTEMPMS_H	EQU	3
SYSWORDTEMPA	EQU	5
SYSWORDTEMPA_H	EQU	6
SYSWORDTEMPB	EQU	9
SYSWORDTEMPB_H	EQU	10
SYSWORDTEMPX	EQU	0
SYSWORDTEMPX_H	EQU	1
TEMP	EQU	176
T_IP_HDR_CKSUM	EQU	177
T_UDP_DESTPORT	EQU	178
T_UDP_DESTPORT_H	EQU	179
VAL1	EQU	180
VAL2	EQU	181
VAL2_H	EQU	182
VAL3	EQU	183
VAL4	EQU	184

;********************************************************************************

;Alias variables
AFSR0	EQU	4073
AFSR0_H	EQU	4074
SYSETHERBUFFER_1	EQU	1406
SYSETHERBUFFER_10	EQU	1415
SYSETHERBUFFER_11	EQU	1416
SYSETHERBUFFER_12	EQU	1417
SYSETHERBUFFER_13	EQU	1418
SYSETHERBUFFER_14	EQU	1419
SYSETHERBUFFER_15	EQU	1420
SYSETHERBUFFER_16	EQU	1421
SYSETHERBUFFER_17	EQU	1422
SYSETHERBUFFER_18	EQU	1423
SYSETHERBUFFER_19	EQU	1424
SYSETHERBUFFER_2	EQU	1407
SYSETHERBUFFER_20	EQU	1425
SYSETHERBUFFER_21	EQU	1426
SYSETHERBUFFER_22	EQU	1427
SYSETHERBUFFER_23	EQU	1428
SYSETHERBUFFER_24	EQU	1429
SYSETHERBUFFER_25	EQU	1430
SYSETHERBUFFER_26	EQU	1431
SYSETHERBUFFER_27	EQU	1432
SYSETHERBUFFER_28	EQU	1433
SYSETHERBUFFER_29	EQU	1434
SYSETHERBUFFER_3	EQU	1408
SYSETHERBUFFER_30	EQU	1435
SYSETHERBUFFER_31	EQU	1436
SYSETHERBUFFER_32	EQU	1437
SYSETHERBUFFER_33	EQU	1438
SYSETHERBUFFER_34	EQU	1439
SYSETHERBUFFER_35	EQU	1440
SYSETHERBUFFER_36	EQU	1441
SYSETHERBUFFER_37	EQU	1442
SYSETHERBUFFER_38	EQU	1443
SYSETHERBUFFER_39	EQU	1444
SYSETHERBUFFER_4	EQU	1409
SYSETHERBUFFER_40	EQU	1445
SYSETHERBUFFER_41	EQU	1446
SYSETHERBUFFER_42	EQU	1447
SYSETHERBUFFER_43	EQU	1448
SYSETHERBUFFER_44	EQU	1449
SYSETHERBUFFER_45	EQU	1450
SYSETHERBUFFER_46	EQU	1451
SYSETHERBUFFER_47	EQU	1452
SYSETHERBUFFER_48	EQU	1453
SYSETHERBUFFER_49	EQU	1454
SYSETHERBUFFER_5	EQU	1410
SYSETHERBUFFER_50	EQU	1455
SYSETHERBUFFER_51	EQU	1456
SYSETHERBUFFER_52	EQU	1457
SYSETHERBUFFER_53	EQU	1458
SYSETHERBUFFER_54	EQU	1459
SYSETHERBUFFER_55	EQU	1460
SYSETHERBUFFER_56	EQU	1461
SYSETHERBUFFER_57	EQU	1462
SYSETHERBUFFER_58	EQU	1463
SYSETHERBUFFER_59	EQU	1464
SYSETHERBUFFER_6	EQU	1411
SYSETHERBUFFER_60	EQU	1465
SYSETHERBUFFER_61	EQU	1466
SYSETHERBUFFER_62	EQU	1467
SYSETHERBUFFER_63	EQU	1468
SYSETHERBUFFER_64	EQU	1469
SYSETHERBUFFER_65	EQU	1470
SYSETHERBUFFER_66	EQU	1471
SYSETHERBUFFER_67	EQU	1472
SYSETHERBUFFER_68	EQU	1473
SYSETHERBUFFER_69	EQU	1474
SYSETHERBUFFER_7	EQU	1412
SYSETHERBUFFER_70	EQU	1475
SYSETHERBUFFER_8	EQU	1413
SYSETHERBUFFER_9	EQU	1414
SYSHEX_0	EQU	1322
SYSHEX_1	EQU	1323
SYSHEX_2	EQU	1324
SYSIPADDR_1	EQU	1347
SYSIPADDR_2	EQU	1348
SYSIPADDR_3	EQU	1349
SYSIPADDR_4	EQU	1350
SYSIPROUTER_1	EQU	1342
SYSIPROUTER_2	EQU	1343
SYSIPROUTER_3	EQU	1344
SYSIPROUTER_4	EQU	1345
SYSMACADDRROUTER_1	EQU	1332
SYSMACADDRROUTER_2	EQU	1333
SYSMACADDRROUTER_3	EQU	1334
SYSMACADDRROUTER_4	EQU	1335
SYSMACADDRROUTER_5	EQU	1336
SYSMACADDRROUTER_6	EQU	1337
SYSMACADDR_1	EQU	1358
SYSMACADDR_2	EQU	1359
SYSMACADDR_3	EQU	1360
SYSMACADDR_4	EQU	1361
SYSMACADDR_5	EQU	1362
SYSMACADDR_6	EQU	1363
SYSNTPSERVERADDR_1	EQU	1327
SYSNTPSERVERADDR_2	EQU	1328
SYSNTPSERVERADDR_3	EQU	1329
SYSNTPSERVERADDR_4	EQU	1330
SYSSTR_0	EQU	1351

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
	call	INITUSART

;Start of the main program
;''A program  for GCGB and GCB.
;''A program  for GCGB and GCB.
;''--------------------------------------------------------------------------------------------------------------------------------
;'' Description  :  Setup ENC28J60, then reads data from the Ethernet stream to a PC terminal.
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
;#define debug
;#define USART_BAUD_RATE 9600
;#define USART_BLOCKING
;#define USART_TX_BLOCKING
;----- Define Hardware settings
;#Define ENC28J60_DI			PortC.4							'Connected to Device SO
;#Define ENC28J60_DO			PortC.5							'Connected to Device SI
;#Define ENC28J60_SCK		PortC.3							'Connected to Clock
;#Define ENC28J60_CS 		PortA.5							'Chip select line
;#Define ENC28J60_RESET  PortD.2							'Reset line
;#Define Heartbeat 			PortC.2
;#Define TX 							PortC.7
;#Define RX							PortC.6
;#Define Button					PortA.4
;----- Variables
;----- Quick Command Reference:
;----- Main body of program commences here.
RESTART
;HSerPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;HserPrint "ENC28J60 Ethernet Driver 018" : HSerPrintCRLF
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
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT243
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
;0x68, 0xb5, 0x99, 0xe7, 0x11, 0xe0
;ntpserveraddr = 23,102,23,44
	lfsr	0,NTPSERVERADDR
	movlw	4
	movwf	POSTINC0,ACCESS
	movlw	23
	movwf	POSTINC0,ACCESS
	movlw	102
	movwf	POSTINC0,ACCESS
	movlw	23
	movwf	POSTINC0,ACCESS
	movlw	44
	movwf	POSTINC0,ACCESS
;192,168,0,2
;ENC28J60_Init ( macaddr )
	movlw	low MACADDR
	movwf	SysMACADDRHandler,BANKED
	movlw	high MACADDR
	movwf	SysMACADDRHandler_H,BANKED
	call	ENC28J60_INIT
;HserPrint "Initialised"
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
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT243
;dir Heartbeat out
	bcf	TRISC,2,ACCESS
;dir Button in
	bsf	TRISA,4,ACCESS
;ENC28J60_bitSet( ECON1 , econ1_txrst )
	movlw	31
	movwf	ADDR,BANKED
	movlw	128
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_BITSET
;ENC28J60_bitClear( ECON1 , econ1_txrst )
	movlw	31
	movwf	ADDR,BANKED
	movlw	128
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_BITCLEAR
;ENC28J60_Ntp_get                       'get the Network Time once
;HSerPrint "..."
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
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT243
;HSerPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;Enc28j60_data = ENC28J60_ReadReg( erevid)
;HSerPrint "#1"
;HSerPrintCRLF
;HSerPrint "Rx   : ERXST  ERXND  ERXWRPT ERXRDPT ERXFCON EPKTCNT"
;HSerPrintCRLF
;Enc28j60_data = ENC28J60_ReadReg(erxsth)
;HSerPrint "       " + Hex(enc28j60_data);
;Enc28j60_data = ENC28J60_ReadReg(erxstl)
;HSerPrint Hex(enc28j60_data);
;Enc28j60_data = ENC28J60_ReadReg(erxndh)
;HSerPrint "   " + Hex(enc28j60_data);
;Enc28j60_data = ENC28J60_ReadReg(erxndl)
;HSerPrint Hex(enc28j60_data);
;Enc28j60_data = ENC28J60_ReadReg(erxwrpth)
;HSerPrint "   " + Hex(enc28j60_data);
;Enc28j60_data = ENC28J60_ReadReg(erxwrptl)
;HSerPrint Hex(enc28j60_data);
;Enc28j60_data = ENC28J60_ReadReg(erxrdpth)
;HSerPrint "    " + Hex(enc28j60_data);
;Enc28j60_data = ENC28J60_ReadReg(erxrdptl)
;HSerPrint Hex(enc28j60_data);
;Enc28j60_data = ENC28J60_ReadReg(erxfcon)
;HSerPrint "    " + Hex(enc28j60_data);
;Enc28j60_data = ENC28J60_ReadReg(epktcnt)
;HSerPrint "      " + Hex(enc28j60_data);
;HSerPrintCRLF
;HSerPrint "Write ARP"
;HSerPrintCRLF 2
;Enc28j60regdump
;repeat 5
	movlw	5
	movwf	SysRepeatTemp1,BANKED
SysRepeatLoop1
;ARP-test. Fill buffer and send it on its way.
;Enc28j60writebufferARP
	call	ENC28J60WRITEBUFFERARP
;end Repeat
	decfsz	SysRepeatTemp1,F,BANKED
	bra	SysRepeatLoop1
SysRepeatLoopEnd1
;Enc28j60_data = ENC28J60_ReadReg( erevid)
;HSerPrint "#2"
;HSerPrintCRLF
;HSerPrint "Rx   : ERXST  ERXND  ERXWRPT ERXRDPT ERXFCON EPKTCNT"
;HSerPrintCRLF
;Enc28j60_data = ENC28J60_ReadReg(erxsth)
;HSerPrint "       " + Hex(enc28j60_data);
;Enc28j60_data = ENC28J60_ReadReg(erxstl)
;HSerPrint Hex(enc28j60_data);
;Enc28j60_data = ENC28J60_ReadReg(erxndh)
;HSerPrint "   " + Hex(enc28j60_data);
;Enc28j60_data = ENC28J60_ReadReg(erxndl)
;HSerPrint Hex(enc28j60_data);
;Enc28j60_data = ENC28J60_ReadReg(erxwrpth)
;HSerPrint "   " + Hex(enc28j60_data);
;Enc28j60_data = ENC28J60_ReadReg(erxwrptl)
;HSerPrint Hex(enc28j60_data);
;Enc28j60_data = ENC28J60_ReadReg(erxrdpth)
;HSerPrint "    " + Hex(enc28j60_data);
;Enc28j60_data = ENC28J60_ReadReg(erxrdptl)
;HSerPrint Hex(enc28j60_data);
;Enc28j60_data = ENC28J60_ReadReg(erxfcon)
;HSerPrint "    " + Hex(enc28j60_data);
;Enc28j60_data = ENC28J60_ReadReg(epktcnt)
;HSerPrint "      " + Hex(enc28j60_data);
;HSerPrintCRLF 2
;HSerPrintCRLF 2
;dim OldpacketCounterOut, OldpacketCounterIn, mydebugcount as long
;mydebugcount = 0
	clrf	MYDEBUGCOUNT,BANKED
	clrf	MYDEBUGCOUNT_H,BANKED
	clrf	MYDEBUGCOUNT_U,BANKED
	clrf	MYDEBUGCOUNT_E,BANKED
;ENC28J60_writeReg(ERXFCON, 0x00)
	movlw	56
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;#define ButtonDown = 0
;buttonstate = ButtonDown
	clrf	BUTTONSTATE,BANKED
;Enc28j60regdump
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
;HSerPrint mydebugcount
;HSerPrintCRLF
;if porta.5 = buttonstate then
;if buttonstate  = ButtonDown then
;
;HserPrint cnt
;HserPrint ", "
;HserPrint packetCounterOut
;HserPrint ", "
;HserPrint packetCounterIn
;HserPrint ", "
;HSerPrint crash
;
;HSerPrintCRLF
;OldpacketCounterIn = packetCounterIn
;OldpacketCounterOut = packetCounterOut
;
;Enc28j60regdump
;
;end if
;
;SetWith( buttonstate, FnNotBit ( buttonstate ))
;end if
;Enc28j60poll 'watch the terminal screen.... All traffic visible
	rcall	ENC28J60POLL
;Loop
	bra	SysDoLoop_S1
SysDoLoop_E1
;end
	bra	BASPROGRAMEND
;----- Support methods.  Subroutines and Functions
;#define ENC28J60_Select         Set ENC28J60_CS off
;#define ENC28J60_Deselect       Set ENC28J60_CS on
;#define ENC28J60_Reset_CMD			Set ENC28J60_RESET on: Wait 10 ms :Set ENC28J60_RESET off: Wait 10 ms :Set ENC28J60_RESET on: Wait 10 ms
CONFIGURATIONDETAILS
MEMORY_LOCATIONS_SCRIPT
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

ARPREPLY
;ENC28J60_Setst_mac
	call	ENC28J60_SETST_MAC
;For II = 1 To 6
	clrf	II,BANKED
SysForLoop3
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
	bra	SysForLoop3
SysForLoopEnd3
;For II = 1 To 4
	clrf	II,BANKED
SysForLoop4
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
	bra	SysForLoop4
SysForLoopEnd4
;For II = 1 To 6
	clrf	II,BANKED
SysForLoop5
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
	bra	SysForLoop5
SysForLoopEnd5
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
;HSerSend 9
;HSerPrint "       >"
;
;for ii = 1 to 24
;HSerPrint hex(etherbuffer(ii))
;HSerPrint ":"
;next
;HSerPrintCRLF
;Enc28j60writebuffer( 42 )
	movlw	42
	banksel	PCKTLEN
	movwf	PCKTLEN,BANKED
	clrf	PCKTLEN_H,BANKED
	call	ENC28J60WRITEBUFFER
;Enc28j60packetsend(42)
	movlw	42
	movwf	PCKTLEN,BANKED
	clrf	PCKTLEN_H,BANKED
	bra	ENC28J60PACKETSEND

;********************************************************************************

FN_ASC
;Asc = 0
	clrf	ASC,BANKED
;SysCharCount = SysInStringA(0)
	movff	SysSYSINSTRINGAHandler,AFSR0
	movff	SysSYSINSTRINGAHandler_H,AFSR0_H
	movff	INDF0,SYSCHARCOUNT
;If SysCharCount = 0 Then Exit Function
	movf	SYSCHARCOUNT,F,BANKED
	btfsc	STATUS, Z,ACCESS
	return
;if Syschar > SysCharCount Then Exit Function
	movf	SYSCHAR,W,BANKED
	subwf	SYSCHARCOUNT,W,BANKED
	btfss	STATUS, C,ACCESS
	return
;Asc = SysInStringA( Syschar )
	movf	SYSCHAR,W,BANKED
	addwf	SysSYSINSTRINGAHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysSYSINSTRINGAHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movff	INDF0,ASC
	return

;********************************************************************************

CALCCHECKSUM
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

ENC28J60PACKETRECEIVE
;Dim eth_counter, eth_frameLength As Word
;Dim previous_nextpacketptr as word
;ENC28J60_temp = ENC28J60_ReadReg (eir) and EIR_PKTIF
	movlw	28
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movlw	64
	andwf	ENC28J60_READREG,W,BANKED
	movwf	ENC28J60_TEMP,BANKED
;If ENC28J60_temp <> EIR_PKTIF Then
	movlw	64
	subwf	ENC28J60_TEMP,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF22
;HSerPrint "No packet"
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
	call	HSERPRINT243
;ENC28J60_bitSet( ECON2, ECON2_PKTDEC )
	movlw	30
	movwf	ADDR,BANKED
	movlw	64
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_BITSET
;Exit Sub
	return
;End If
ENDIF22
;packetCounterIn++
	incf	PACKETCOUNTERIN,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	PACKETCOUNTERIN_H,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	PACKETCOUNTERIN_U,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	PACKETCOUNTERIN_E,F,BANKED
;Enc28j60_data = ENC28J60_ReadReg( erevid )
	movlw	114
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;do
;ENC28J60_writeReg(ERDPTL, [byte]nextpacketptr )
	clrf	ADDR,BANKED
	movff	NEXTPACKETPTR,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(ERDPTH, nextpacketptr_h )
	movlw	1
	movwf	ADDR,BANKED
	movff	NEXTPACKETPTR_H,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;loop while (ENC28J60_ReadReg(ERDPTL) <>  [byte]nextpacketptr) or (ENC28J60_ReadReg(ERDPTH) <> nextpacketptr_h )
;Enc28j60readbuffer(6)
	movlw	6
	movwf	ETHERGETLENGTH,BANKED
	clrf	ETHERGETLENGTH_H,BANKED
	rcall	ENC28J60READBUFFER
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
;HSerPrint hex(etherbuffer(5))
;HSerSend 9
;HSerPrint hex(etherbuffer(5) and 0x80 )
;HSerPrintCRLF
;HSerPrint hex(etherbuffer(6))
;HSerPrintCRLF
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
	bra	ENDIF23
;Enc28j60readbuffer(eth_frameLength)
	movff	ETH_FRAMELENGTH,ETHERGETLENGTH
	movff	ETH_FRAMELENGTH_H,ETHERGETLENGTH_H
	rcall	ENC28J60READBUFFER
;end if
ENDIF23
ENDPACKET
;do
SysDoLoop_S3
;ENC28J60_writeReg(ERDPTL, [byte]nextpacketptr )
	clrf	ADDR,BANKED
	movff	NEXTPACKETPTR,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(ERDPTH, nextpacketptr_h )
	movlw	1
	movwf	ADDR,BANKED
	movff	NEXTPACKETPTR_H,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;loop while (ENC28J60_ReadReg(ERDPTL) <>  [byte]nextpacketptr) or (ENC28J60_ReadReg(ERDPTH) <> nextpacketptr_h )
	clrf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,SysFnBYTE1
	movlw	1
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
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
	bra	SysDoLoop_S3
SysDoLoop_E3
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
	bra	ENDIF24
;eth_counter = nextpacketptr -1
	movlw	1
	subwf	NEXTPACKETPTR,W,BANKED
	movwf	ETH_COUNTER,BANKED
	movlw	0
	subwfb	NEXTPACKETPTR_H,W,BANKED
	movwf	ETH_COUNTER_H,BANKED
;END IF
ENDIF24
;ENC28J60_writeReg(ERXRDPTL, [byte]eth_counter )
	movlw	12
	movwf	ADDR,BANKED
	movff	ETH_COUNTER,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(ERXRDPTH, eth_counter_h )
	movlw	13
	movwf	ADDR,BANKED
	movff	ETH_COUNTER_H,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_bitSet( ECON2, ECON2_PKTDEC )
	movlw	30
	movwf	ADDR,BANKED
	movlw	64
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_BITSET
;
;HSerPrintCRLF
;HSerSend 9
;HSerSend 9
;
;for ii = 1 to 24
;HSerPrint hex(etherbuffer(ii))
;HSerPrint ":"
;next
;HSerPrintCRLF
;If etherBuffer(13) = 0X08 Then
	movlw	8
	banksel	SYSETHERBUFFER_13
	subwf	SYSETHERBUFFER_13,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF25
;HSerPrint "13@1,"
;If etherBuffer(14) = 0X06 Then                             'Type:ARP
	movlw	6
	subwf	SYSETHERBUFFER_14,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF26
;HSerPrint "14@1,"
;If etherBuffer(21) = 0X00 Then                          'ARP request
	movf	SYSETHERBUFFER_21,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF28
;If etherBuffer(22) = 0X01 Then                       'ARP request
	decf	SYSETHERBUFFER_22,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF30
;If etherBuffer(39) = ipaddr(1) Then                  'ARP for us
	movf	SYSIPADDR_1,W,BANKED
	subwf	SYSETHERBUFFER_39,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF32
;If etherBuffer(40) = ipaddr(2) Then
	movf	SYSIPADDR_2,W,BANKED
	subwf	SYSETHERBUFFER_40,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF34
;If etherBuffer(41) = ipaddr(3) Then
	movf	SYSIPADDR_3,W,BANKED
	subwf	SYSETHERBUFFER_41,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF36
;If etherBuffer(42) = ipaddr(4) Then
	movf	SYSIPADDR_4,W,BANKED
	subwf	SYSETHERBUFFER_42,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF38
;Arpreply
	banksel	0
	rcall	ARPREPLY
;HSerPrint "ARP Replied": HSerPrintCRLF
;End If
ENDIF38
;End If
ENDIF36
;End If
ENDIF34
;End If
ENDIF32
;End If
ENDIF30
;End If
ENDIF28
;End If
ENDIF26
;If etherBuffer(14) = 0X00 Then                             'Type:IP
	banksel	SYSETHERBUFFER_14
	movf	SYSETHERBUFFER_14,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF27
;HSerPrint "14@2,"
;If etherBuffer(15) = 0X45 Then                          'We handle only simple IP packets
	movlw	69
	subwf	SYSETHERBUFFER_15,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF29
;HSerPrint "15@2,"
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
	bra	ENDIF31
;HSerPrint "21@2,"
;If etherBuffer(31) = ipaddr(1) Then                  'Ip packet for us
	banksel	SYSIPADDR_1
	movf	SYSIPADDR_1,W,BANKED
	subwf	SYSETHERBUFFER_31,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF33
;If etherBuffer(32) = ipaddr(2) Then
	movf	SYSIPADDR_2,W,BANKED
	subwf	SYSETHERBUFFER_32,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF35
;If etherBuffer(33) = ipaddr(3) Then
	movf	SYSIPADDR_3,W,BANKED
	subwf	SYSETHERBUFFER_33,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF37
;If etherBuffer(34) = ipaddr(4) Then
	movf	SYSIPADDR_4,W,BANKED
	subwf	SYSETHERBUFFER_34,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF39
;If etherBuffer(24) = 1 Then              'Protocol:ICMP
	decf	SYSETHERBUFFER_24,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF40
;If etherBuffer(35) = 0X08 Then        'ICMP echo request
	movlw	8
	subwf	SYSETHERBUFFER_35,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF43
;Pingreply
	banksel	0
	call	PINGREPLY
;HSerPrint "Pinged ": HSerPrintCRLF
;End If
ENDIF43
;End If
ENDIF40
;If etherBuffer(24) = 17 Then             'Protocol:UDP
	movlw	17
	banksel	SYSETHERBUFFER_24
	subwf	SYSETHERBUFFER_24,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF41
;Udp_receive                    'werkt wel
;ENC28J60_Udp
	banksel	0
	call	ENC28J60_UDP
;End If
ENDIF41
;If etherBuffer(24) = 6 Then              'Protocol:TCP
	movlw	6
	banksel	SYSETHERBUFFER_24
	subwf	SYSETHERBUFFER_24,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF42
;Tcp                            'werkt niet
;HSerPrint "TCP Reply Needed": HSerPrintCRLF
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable15
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable15
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT243
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;End If
ENDIF42
;End If
ENDIF39
;End If
ENDIF37
;End If
ENDIF35
;End If
ENDIF33
;End If
ENDIF31
;End If
ENDIF29
;End If
ENDIF27
;End If
ENDIF25
	banksel	0
	return

;********************************************************************************

ENC28J60PACKETSEND
;ENC28J60_bitSet( ECON1 , econ1_txrst )
	movlw	31
	movwf	ADDR,BANKED
	movlw	128
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_BITSET
;ENC28J60_bitClear( ECON1 , econ1_txrst )
	movlw	31
	movwf	ADDR,BANKED
	movlw	128
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_BITCLEAR
;added
;ENC28J60_bitClear( EIR , EIR_TXERIF )
	movlw	28
	movwf	ADDR,BANKED
	movlw	2
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_BITCLEAR
;wait while ( (ENC28J60_ReadReg( ECON1 ) & ECON1_TXRTS ) = ECON1_TXRTS )
SysWaitLoop13
	movlw	31
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movlw	8
	andwf	ENC28J60_READREG,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SysBYTETempA
	movlw	8
	movwf	SysBYTETempB,ACCESS
	call	SysCompEqual
	btfsc	SysByteTempX,0,ACCESS
	bra	SysWaitLoop13
;ENC28J60_writeReg(etxndl , (ENC_TXBUF_STL + pcktlen ) & 0xFF )
	movlw	6
	movwf	ADDR,BANKED
	movlw	112
	addwf	PCKTLEN,W,BANKED
	movwf	SysTemp1,BANKED
	movlw	0
	addwfc	PCKTLEN_H,W,BANKED
	movwf	SysTemp1_H,BANKED
	movff	SysTemp1,ENC_OUTBYTE
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(etxndh , ENC_TXBUF_STH + pcktlen_h )
	movlw	7
	movwf	ADDR,BANKED
	movlw	22
	addwf	PCKTLEN_H,W,BANKED
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28J60_bitSet( EIR , EIR_TXIF )
	movlw	28
	movwf	ADDR,BANKED
	movlw	8
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_BITSET
;ENC28J60_bitClear( EIE , EIE_TXIE )
	movlw	27
	movwf	ADDR,BANKED
	movlw	8
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_BITCLEAR
;ENC28J60_bitSet( ECON1 , econ1_txrts )
	movlw	31
	movwf	ADDR,BANKED
	movlw	8
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_BITSET
;wait while ( (ENC28J60_ReadReg( ECON1 ) & ECON1_TXRTS ) = ECON1_TXRTS )
SysWaitLoop14
	movlw	31
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movlw	8
	andwf	ENC28J60_READREG,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SysBYTETempA
	movlw	8
	movwf	SysBYTETempB,ACCESS
	call	SysCompEqual
	btfsc	SysByteTempX,0,ACCESS
	bra	SysWaitLoop14
;packetCounterOut++
	incf	PACKETCOUNTEROUT,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	PACKETCOUNTEROUT_H,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	PACKETCOUNTEROUT_U,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	PACKETCOUNTEROUT_E,F,BANKED
;Value = 0
;Value.econ1_txrst = 1
;Call Enc28j60bitfield_set(econ1 , Value)
;
;Value.econ1_txrst = 1
;Call Enc28j60bitfield_clear(econ1 , Value)
;
;'set the write pointer to start of transmit buffer area
;Value = Low(txstart_init)
;Call Enc28j60writecontrolregbyte(ewrptl , Value)
;
;Value = High(txstart_init)
;Call Enc28j60writecontrolregbyte(ewrpth , Value)
;
;'set the TXND pointer to correspond to the packet size given
;Value = Low(txstart_init)
;Value = Value + Low(pcktlen)
;Call Enc28j60writecontrolregbyte(etxndl , Value)
;
;Value = High(txstart_init)
;Value = Value + High(pcktlen)
;
;Call Enc28j60writecontrolregbyte(etxndh , Value)
;
;'send the contents of the transmit buffer onto the network
;Value = 0
;Value.econ1_txrts = 1
;Call Enc28j60bitfield_set(econ1 , Value)
	return

;********************************************************************************

ENC28J60POLL
;ENC28J60_selectBank ( 0x20, epktcnt )
;Enc28j60_data = ENC28J60_ReadReg( erevid )
	movlw	114
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;cnt = ENC28J60_ReadReg( epktcnt )
	movlw	57
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,CNT
;If cnt > 0 Then
	movf	CNT,W,BANKED
	sublw	0
	btfsc	STATUS, C,ACCESS
	bra	ENDIF14
;Enc28j60packetreceive(etherBufferSize)
	movlw	128
	movwf	MAXLEN,BANKED
	clrf	MAXLEN_H,BANKED
	rcall	ENC28J60PACKETRECEIVE
;End If
ENDIF14
	return

;********************************************************************************

ENC28J60READBUFFER
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
;ENC28J60_Select
	bcf	LATA,5,ACCESS
;Set WCOL Off
	bcf	SSPCON1,WCOL,ACCESS
;SSPBUF = ENC28J60_READ_BUF_MEM
	movlw	58
	movwf	SSPBUF,ACCESS
;Wait While BF = Off
SysWaitLoop15
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop15
;temp = SSPBUF
	movff	SSPBUF,TEMP
;if etherGetLength < etherBufferSize+1 then
	movff	ETHERGETLENGTH,SysWORDTempA
	movff	ETHERGETLENGTH_H,SysWORDTempA_H
	movlw	129
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF67
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
	bra	SysForLoopEnd11
SysForLoop11
	incf	ETH_COUNTER,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	ETH_COUNTER_H,F,BANKED
;SSPBUF = 0
	clrf	SSPBUF,ACCESS
;Wait While BF = Off
SysWaitLoop16
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop16
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
	bra	SysForLoop11
SysForLoopEnd11
;End if
ENDIF67
;if etherGetLength > etherBufferSize then
;
;for eth_counter = 65 to etherGetLength
;SSPBUF = 0
;Wait While BF = Off
;temp = SSPBUF
;
;next
;
;End if
;ENC28J60_Deselect
	bsf	LATA,5,ACCESS
	return

;********************************************************************************

ENC28J60REGDUMP
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;HSerPrint "Registerdump ENC28J60"
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
	call	HSERPRINT243
;Enc28j60_data = ENC28J60_ReadReg( erevid)
	movlw	114
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint " Version: " + str( Enc28j60_data )
	movff	ENC28J60_DATA,SYSVALTEMP
	clrf	SYSVALTEMP_H,BANKED
	call	FN_STR
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable17
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable17
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
	call	HSERPRINT243
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;HSerPrint "Cntrl: ECON1 ECON2 ESTAT  EIR  EIE"
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
	call	HSERPRINT243
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;Enc28j60_data = ENC28J60_ReadReg( econ1)
	movlw	31
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "       " + Hex(enc28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable19
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable19
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
	call	HSERPRINT243
;Enc28j60_data = ENC28J60_ReadReg( econ2)
	movlw	30
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "    " + Hex(enc28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable20
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable20
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
	call	HSERPRINT243
;Enc28j60_data = ENC28J60_ReadReg( estat)
	movlw	29
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "    " + Hex(enc28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable20
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable20
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
	call	HSERPRINT243
;ENC28J60_ReadReg (eir)
	movlw	28
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
;HSerPrint "     " + Hex(enc28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable11
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable11
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
	call	HSERPRINT243
;Enc28j60_data = ENC28J60_ReadReg( eie)
	movlw	27
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "   " + Hex(enc28j60_data)
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable10
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable10
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
	call	HSERPRINT243
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;HSerPrint "MAC  : MACON1  MACON2  MACON3  MACON4  MAC-Address"
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
	call	HSERPRINT243
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;Enc28j60_data = ENC28J60_ReadReg( macon1)
	movlw	192
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "       " + Hex(enc28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable19
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable19
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
	call	HSERPRINT243
;Enc28j60_data = ENC28J60_ReadReg( macon2)
	movff	MACON2,ADDR
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "      " + Hex(enc28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable22
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable22
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
	call	HSERPRINT243
;Enc28j60_data = ENC28J60_ReadReg( macon3)
	movlw	194
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "      " + Hex(enc28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable22
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable22
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
	call	HSERPRINT243
;Enc28j60_data = ENC28J60_ReadReg( macon4)
	movlw	195
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "      " + Hex(enc28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable22
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable22
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
	call	HSERPRINT243
;Enc28j60_data = ENC28J60_ReadReg( maadr5)
	movlw	228
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "      " + Hex(enc28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable22
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable22
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
	call	HSERPRINT243
;Enc28j60_data = ENC28J60_ReadReg( maadr4)
	movlw	229
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "." + Hex(enc28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable23
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable23
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
	call	HSERPRINT243
;Enc28j60_data = ENC28J60_ReadReg( maadr3)
	movlw	226
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "." + Hex(enc28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable23
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable23
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
	call	HSERPRINT243
;Enc28j60_data = ENC28J60_ReadReg( maadr2)
	movlw	227
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "." + Hex(enc28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable23
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable23
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
	call	HSERPRINT243
;Enc28j60_data = ENC28J60_ReadReg( maadr1)
	movlw	224
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "." + Hex(enc28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable23
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable23
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
	call	HSERPRINT243
;Enc28j60_data = ENC28J60_ReadReg( maadr0)
	movlw	225
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "." + Hex(enc28j60_data)
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable23
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable23
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
	call	HSERPRINT243
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;HSerPrint "Rx   : ERXST  ERXND  ERXWRPT ERXRDPT ERXFCON EPKTCNT MAMXFL"
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
	call	HSERPRINT243
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;Enc28j60_data = ENC28J60_ReadReg(erxsth)
	movlw	9
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "       " + Hex(enc28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable19
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable19
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
	call	HSERPRINT243
;Enc28j60_data = ENC28J60_ReadReg(erxstl)
	movlw	8
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint Hex(enc28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT243
;Enc28j60_data = ENC28J60_ReadReg(erxndh)
	movlw	11
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "   " + Hex(enc28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable10
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable10
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
	call	HSERPRINT243
;Enc28j60_data = ENC28J60_ReadReg(erxndl)
	movlw	10
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint Hex(enc28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT243
;Enc28j60_data = ENC28J60_ReadReg(erxwrpth)
	movlw	15
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "   " + Hex(enc28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable10
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable10
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
	call	HSERPRINT243
;Enc28j60_data = ENC28J60_ReadReg(erxwrptl)
	movlw	14
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint Hex(enc28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT243
;Enc28j60_data = ENC28J60_ReadReg(erxrdpth)
	movlw	13
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "    " + Hex(enc28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable20
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable20
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
	call	HSERPRINT243
;Enc28j60_data = ENC28J60_ReadReg(erxrdptl)
	movlw	12
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint Hex(enc28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT243
;Enc28j60_data = ENC28J60_ReadReg(erxfcon)
	movlw	56
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "    " + Hex(enc28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable20
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable20
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
	call	HSERPRINT243
;Enc28j60_data = ENC28J60_ReadReg(epktcnt)
	movlw	57
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "      " + Hex(enc28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable22
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable22
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
	call	HSERPRINT243
;Enc28j60_data = ENC28J60_ReadReg(mamxflh)
	movlw	203
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "      " + Hex(enc28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable22
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable22
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
	call	HSERPRINT243
;Enc28j60_data = ENC28J60_ReadReg(mamxfll)
	movlw	202
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint Hex(enc28j60_data)
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT243
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;HSerPrint "Tx   : ETXST  ETXND  EWRPT  MACLCON1 MACLCON2 MAPHSUP"
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable25
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable25
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT243
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;Enc28j60_data = ENC28J60_ReadReg(etxsth)
	movlw	5
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "       " + Hex(enc28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable19
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable19
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
	call	HSERPRINT243
;Enc28j60_data = ENC28J60_ReadReg(etxstl)
	movlw	4
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint Hex(enc28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT243
;Enc28j60_data = ENC28J60_ReadReg(etxndh)
	movlw	7
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "   " + Hex(enc28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable10
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable10
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
	call	HSERPRINT243
;Enc28j60_data = ENC28J60_ReadReg(etxndl)
	movlw	6
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint Hex(enc28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT243
;Enc28j60_data = ENC28J60_ReadReg(EWRPTH)
	movlw	3
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "   " +  Hex(enc28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable10
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable10
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
	call	HSERPRINT243
;Enc28j60_data = ENC28J60_ReadReg(EWRPTl)
	movlw	2
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint Hex(enc28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT243
;Enc28j60_data = ENC28J60_ReadReg(maclcon1)
	movlw	200
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "   " + Hex(enc28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable10
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable10
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
	call	HSERPRINT243
;Enc28j60_data = ENC28J60_ReadReg(maclcon2)
	movlw	201
	movwf	ADDR,BANKED
	call	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "       " + Hex(enc28j60_data);
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable19
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable19
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
	call	HSERPRINT243
;Enc28j60_data = ENC28J60_ReadReg(maphsup)
	movff	MAPHSUP,ADDR
	rcall	FN_ENC28J60_READREG
	movff	ENC28J60_READREG,ENC28J60_DATA
;HSerPrint "       " + Hex(enc28j60_data)
	movff	ENC28J60_DATA,SYSVALTEMP
	call	FN_HEX
	lfsr	1,SYSSTRINGPARAM1
	clrf	SysStringLength,ACCESS
	movlw	low StringTable19
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable19
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
	call	HSERPRINT243
;HSerPrintCRLF 2
	movlw	2
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	goto	HSERPRINTCRLF

;********************************************************************************

ENC28J60WRITEBUFFER
;dim eth_counter as Word
;ENC28J60_writeReg(ewrptl, ENC_TXBUF_STL)
	movlw	2
	movwf	ADDR,BANKED
	movlw	112
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(ewrpth, ENC_TXBUF_STH)
	movlw	3
	movwf	ADDR,BANKED
	movlw	22
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28J60_Select
	bcf	LATA,5,ACCESS
;Set WCOL Off
	bcf	SSPCON1,WCOL,ACCESS
;SSPBUF = Enc28j60_write_buf_mem
	movlw	122
	movwf	SSPBUF,ACCESS
;Wait While BF = Off
SysWaitLoop7
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop7
;temp = SSPBUF
	movff	SSPBUF,TEMP
;SSPBUF = 0x0E
	movlw	14
	movwf	SSPBUF,ACCESS
;Wait While BF = Off
SysWaitLoop8
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop8
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
	bra	SysForLoopEnd1
SysForLoop1
	incf	ETH_COUNTER,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	ETH_COUNTER_H,F,BANKED
;if eth_counter > etherBufferSize then Exit For
	movff	ETH_COUNTER,SysWORDTempB
	movff	ETH_COUNTER_H,SysWORDTempB_H
	movlw	128
	movwf	SysWORDTempA,ACCESS
	clrf	SysWORDTempA_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd1
;SSPBUF = etherbuffer(eth_counter)
	lfsr	0,ETHERBUFFER
	movf	ETH_COUNTER,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	INDF0,SSPBUF
;Wait While BF = Off
SysWaitLoop9
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop9
;temp = SSPBUF
	movff	SSPBUF,TEMP
;next
	movff	ETH_COUNTER,SysWORDTempA
	movff	ETH_COUNTER_H,SysWORDTempA_H
	movff	PCKTLEN,SysWORDTempB
	movff	PCKTLEN_H,SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop1
SysForLoopEnd1
;ENC28J60_Deselect
	bsf	LATA,5,ACCESS
	return

;********************************************************************************

ENC28J60WRITEBUFFERARP
;etherbuffer(1) = 0xFF 'Broadcast
	banksel	SYSETHERBUFFER_1
	setf	SYSETHERBUFFER_1,BANKED
;etherbuffer(2) = 0xFF
	setf	SYSETHERBUFFER_2,BANKED
;etherbuffer(3) = 0xFF
	setf	SYSETHERBUFFER_3,BANKED
;etherbuffer(4) = 0xFF
	setf	SYSETHERBUFFER_4,BANKED
;etherbuffer(5) = 0xFF
	setf	SYSETHERBUFFER_5,BANKED
;etherbuffer(6) = 0xFF
	setf	SYSETHERBUFFER_6,BANKED
;etherbuffer(7)  = macaddr(1)
	movff	SYSMACADDR_1,SYSETHERBUFFER_7
;etherbuffer(8)  = macaddr(2)
	movff	SYSMACADDR_2,SYSETHERBUFFER_8
;etherbuffer(9)  = macaddr(3)
	movff	SYSMACADDR_3,SYSETHERBUFFER_9
;etherbuffer(10) = macaddr(4)
	movff	SYSMACADDR_4,SYSETHERBUFFER_10
;etherbuffer(11) = macaddr(5)
	movff	SYSMACADDR_5,SYSETHERBUFFER_11
;etherbuffer(12) = macaddr(6)
	movff	SYSMACADDR_6,SYSETHERBUFFER_12
;etherbuffer(13) = 0x08
	movlw	8
	movwf	SYSETHERBUFFER_13,BANKED
;etherbuffer(14) = 0x06
	movlw	6
	movwf	SYSETHERBUFFER_14,BANKED
;arp
;etherbuffer(15) = 0x00
	clrf	SYSETHERBUFFER_15,BANKED
;etherbuffer(16) = 0x01
	movlw	1
	movwf	SYSETHERBUFFER_16,BANKED
;etherbuffer(17) = 0x08
	movlw	8
	movwf	SYSETHERBUFFER_17,BANKED
;etherbuffer(18) = 0x00
	clrf	SYSETHERBUFFER_18,BANKED
;etherbuffer(19) = 0x06
	movlw	6
	movwf	SYSETHERBUFFER_19,BANKED
;etherbuffer(20) = 0x04
	movlw	4
	movwf	SYSETHERBUFFER_20,BANKED
;etherbuffer(21) = 0x00
	clrf	SYSETHERBUFFER_21,BANKED
;etherbuffer(22) = 0x01
	movlw	1
	movwf	SYSETHERBUFFER_22,BANKED
;etherbuffer(23) = macaddr(1)
	movff	SYSMACADDR_1,SYSETHERBUFFER_23
;etherbuffer(24) = macaddr(2)
	movff	SYSMACADDR_2,SYSETHERBUFFER_24
;etherbuffer(25) = macaddr(3)
	movff	SYSMACADDR_3,SYSETHERBUFFER_25
;etherbuffer(26) = macaddr(4)
	movff	SYSMACADDR_4,SYSETHERBUFFER_26
;etherbuffer(27) = macaddr(5)
	movff	SYSMACADDR_5,SYSETHERBUFFER_27
;etherbuffer(28) = macaddr(6)
	movff	SYSMACADDR_6,SYSETHERBUFFER_28
;etherbuffer(29) = ipaddr(1) 'own TUX-IP-number
	movff	SYSIPADDR_1,SYSETHERBUFFER_29
;etherbuffer(30) = ipaddr(2)
	movff	SYSIPADDR_2,SYSETHERBUFFER_30
;etherbuffer(31) = ipaddr(3)
	movff	SYSIPADDR_3,SYSETHERBUFFER_31
;etherbuffer(32) = ipaddr(4)
	movff	SYSIPADDR_4,SYSETHERBUFFER_32
;etherbuffer(33) = 0x00 'MAC-address router
	clrf	SYSETHERBUFFER_33,BANKED
;etherbuffer(34) = 0x00
	clrf	SYSETHERBUFFER_34,BANKED
;etherbuffer(35) = 0x00
	clrf	SYSETHERBUFFER_35,BANKED
;etherbuffer(36) = 0x00
	clrf	SYSETHERBUFFER_36,BANKED
;etherbuffer(37) = 0x00
	clrf	SYSETHERBUFFER_37,BANKED
;etherbuffer(38) = 0x00
	clrf	SYSETHERBUFFER_38,BANKED
;etherbuffer(39) = iprouter(1) 'IP-number router
	movff	SYSIPROUTER_1,SYSETHERBUFFER_39
;etherbuffer(40) = iprouter(2)
	movff	SYSIPROUTER_2,SYSETHERBUFFER_40
;etherbuffer(41) = iprouter(3)
	movff	SYSIPROUTER_3,SYSETHERBUFFER_41
;etherbuffer(42) = iprouter(4)
	movff	SYSIPROUTER_4,SYSETHERBUFFER_42
;Enc28j60writebuffer( 42 )' as 60 is the true length of ARP packet
	movlw	42
	banksel	PCKTLEN
	movwf	PCKTLEN,BANKED
	clrf	PCKTLEN_H,BANKED
	rcall	ENC28J60WRITEBUFFER
;Enc28j60packetsend( 60 )
	movlw	60
	movwf	PCKTLEN,BANKED
	clrf	PCKTLEN_H,BANKED
	goto	ENC28J60PACKETSEND

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
	bra	ELSE9_1
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
;ENC28J60_selectBank ( banktobeselected, addr )
	rcall	ENC28J60_SELECTBANK
;end if
;Else
	bra	ENDIF9
ELSE9_1
;lastselectedBank = banktobeselected
	movff	BANKTOBESELECTED,LASTSELECTEDBANK
;end if
ENDIF9
;ENC28J60_Select
	bcf	LATA,5,ACCESS
;FastHWSPITransfer( ENC28J60_BIT_FIELD_CLR | (addr AND ADDR_MASK ), temp )
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
;ENC28J60_Deselect
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
	bra	ELSE7_1
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
;ENC28J60_selectBank ( banktobeselected, addr )
	rcall	ENC28J60_SELECTBANK
;end if
;Else
	bra	ENDIF7
ELSE7_1
;lastselectedBank = banktobeselected
	movff	BANKTOBESELECTED,LASTSELECTEDBANK
;end if
ENDIF7
;ENC28J60_Select
	bcf	LATA,5,ACCESS
;FastHWSPITransfer( ENC28J60_BIT_FIELD_SET | (addr AND ADDR_MASK ), temp )
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
;ENC28J60_Deselect
	bsf	LATA,5,ACCESS
	return

;********************************************************************************

ENC28J60_INIT
;Dir ENC28J60_DI in
	bsf	TRISC,4,ACCESS
;Dir ENC28J60_DO Out
	bcf	TRISC,5,ACCESS
;Dir ENC28J60_SCK Out
	bcf	TRISC,3,ACCESS
;Dir ENC28J60_CS out
	bcf	TRISA,5,ACCESS
;Dir ENC28J60_RESET out
	bcf	TRISD,2,ACCESS
;set ENC28J60_DO off
	bcf	LATC,5,ACCESS
;set ENC28J60_SCK off
	bcf	LATC,3,ACCESS
;set ENC28J60_CS off
	bcf	LATA,5,ACCESS
;ENC28J60_Deselect
	bsf	LATA,5,ACCESS
;Repeat 5
	movlw	5
	movwf	SysRepeatTemp2,BANKED
SysRepeatLoop2
;ENC28J60_Reset_CMD
	bsf	LATD,2,ACCESS
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
	bcf	LATD,2,ACCESS
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
	bsf	LATD,2,ACCESS
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;End Repeat
	decfsz	SysRepeatTemp2,F,BANKED
	bra	SysRepeatLoop2
SysRepeatLoopEnd2
;ENC28J60_Select
	bcf	LATA,5,ACCESS
;SPIMode Master, 0
	movlw	12
	movwf	SPICURRENTMODE,BANKED
	clrf	SPICLOCKMODE,BANKED
	call	SPIMODE199
;FastHWSPITransfer( ENC28J60_SOFT_RESET, temp )
	setf	SPITXDATA,BANKED
	call	FASTHWSPITRANSFER
;lastselectedBank = 99
	movlw	99
	movwf	LASTSELECTEDBANK,BANKED
;wait while ( (ENC28J60_ReadReg( ESTAT ) & ESTAT_CLKRDY ) <> ESTAT_CLKRDY)
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
;ENC28J60_writeReg(ECON1, 0xC0) 'Hold it in Reset
	movlw	31
	movwf	ADDR,BANKED
	movlw	192
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(ECON2, 0x80) 'Set the AUTOINC bit
	movlw	30
	movwf	ADDR,BANKED
	movlw	128
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(EIR, 0x00) 'Reset interrupt flags
	movlw	28
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(EIE,  0xC0)  'Interrupts: Packet reception
	movlw	27
	movwf	ADDR,BANKED
	movlw	192
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(EWOLIE, 0x00)  'Disable wake-on-lan interrupts
	movlw	54
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(EWOLIR, 0x00)  'Clear wake-on-lan interrupt flags
	movlw	55
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(ETXSTL, ENC_TXBUF_STL)
	movlw	4
	movwf	ADDR,BANKED
	movlw	112
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(ETXSTH, ENC_TXBUF_STH)
	movlw	5
	movwf	ADDR,BANKED
	movlw	22
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(ETXNDL, ENC_TXBUF_NDL)
	movlw	6
	movwf	ADDR,BANKED
	setf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(ETXNDH, ENC_TXBUF_NDH)  'TX Buffer : 1800 bytes
	movlw	7
	movwf	ADDR,BANKED
	movlw	31
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(ERXSTL, ENC_RXBUF_STL)
	movlw	8
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(ERXSTH, ENC_RXBUF_STH)
	movlw	9
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(ERXNDL, ENC_RXBUF_NDL)
	movlw	10
	movwf	ADDR,BANKED
	movlw	110
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(ERXNDH, ENC_RXBUF_NDH)  'RX Buffer : 6390 bytes
	movlw	11
	movwf	ADDR,BANKED
	movlw	22
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(ERDPTL, ENC_RXBUF_STL)
	clrf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(ERDPTH, ENC_RXBUF_STH)
	movlw	1
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ERXND
;ENC28J60_writeReg(ERXRDPTL, ENC_RXBUF_STL)
	movlw	12
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(ERXRDPTH, ENC_RXBUF_STH) 'RX Pointers (same)
	movlw	13
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;nextpacketptr = ENC_RXBUF_ST
	clrf	NEXTPACKETPTR,BANKED
	clrf	NEXTPACKETPTR_H,BANKED
;ENC28J60_writeReg(ERXFCON, 0xA1) 'Receive unicasts or broadcasts
	movlw	56
	movwf	ADDR,BANKED
	movlw	161
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(EFLOCON, 0x00) 'Disable flow control sending
	movlw	119
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(ECOCON, 0x00) 'Disable Clock Out pin
	movlw	117
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(EBSTCON, 0x00) 'Disable built-in self test controller
	movlw	103
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;wait while ( (ENC28J60_ReadReg(ESTAT) & ESTAT_CLKRDY) <> ESTAT_CLKRDY)
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
;ENC28J60_writeReg(MISTAT, 0x00)  'Clear MII status register
	movlw	234
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(MICMD, 0x00)   'Clear MII command register
	movlw	210
	movwf	ADDR,BANKED
	clrf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(MICON1, 0x02)  'Fast MII operation
;ENC28J60_writeReg(MICON2, 0x00)  'Release MII interface from reset
;ENC28J60_writeReg(MACON1, b'00001101' )  'Enable packet reception
	movlw	192
	movwf	ADDR,BANKED
	movlw	13
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(MACON2, 0x00)  'Release the MAC subsystem from reset
;ENC28J60_writeReg(MACON3, 0xB1)  'Auto Pad + CRC + Full Duplex
;ENC28J60_writeReg(MACON3, 0x32)  'Auto Pad to 60 bytes + CRC + Half Duplex + Check frame length
	movlw	194
	movwf	ADDR,BANKED
	movlw	50
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(MACON4, 0x01)  'Need valid preamble
	movlw	195
	movwf	ADDR,BANKED
	movlw	1
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(MAPHSUP, b'00010000') 'Release MAC-PHY support from Reset
;ENC28J60_writeReg(MAMXFLL, 0xEE)
	movlw	202
	movwf	ADDR,BANKED
	movlw	238
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(MAMXFLH, 0x05)  'Maximum frame length
	movlw	203
	movwf	ADDR,BANKED
	movlw	5
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(MABBIPG, 0x12) 'IEEE BTB Inter Packet Gap
	movlw	196
	movwf	ADDR,BANKED
	movlw	18
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(MAIPGL, 0x12)
	movlw	198
	movwf	ADDR,BANKED
	movlw	18
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(MAIPGH, 0x0C)  'IEEE Non BTB Inter Packet Gap
	movlw	199
	movwf	ADDR,BANKED
	movlw	12
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(MAADR0, macaddr(2))
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
;ENC28J60_writeReg(MAADR1, macaddr(1))
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
;ENC28J60_writeReg(MAADR2, macaddr(4))
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
;ENC28J60_writeReg(MAADR3, macaddr(3))
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
;ENC28J60_writeReg(MAADR4, macaddr(6))
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
;ENC28J60_writeReg(MAADR5, macaddr(5))
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
;ENC28J60_writePhyReg(PHCON1, 0x00, 0x00)  'Half duplex
	clrf	PHYREGADDR,BANKED
	clrf	ENC_OUTBYTE1,BANKED
	clrf	ENC_OUTBYTE2,BANKED
	call	ENC28J60_WRITEPHYREG
;ENC28J60_writePhyReg(PHCON2, 0x00, 0x00)
	movlw	16
	movwf	PHYREGADDR,BANKED
	clrf	ENC_OUTBYTE1,BANKED
	clrf	ENC_OUTBYTE2,BANKED
	call	ENC28J60_WRITEPHYREG
;ENC28J60_writePhyReg(PHLCON, B'00000100', B'01110110')
	movlw	20
	movwf	PHYREGADDR,BANKED
	movlw	4
	movwf	ENC_OUTBYTE1,BANKED
	movlw	118
	movwf	ENC_OUTBYTE2,BANKED
	call	ENC28J60_WRITEPHYREG
;ENC28J60_writePhyReg(PHIE, 0x00, 0x00)  'Disable interrupts
	movlw	18
	movwf	PHYREGADDR,BANKED
	clrf	ENC_OUTBYTE1,BANKED
	clrf	ENC_OUTBYTE2,BANKED
	call	ENC28J60_WRITEPHYREG
;ENC28J60_writeReg(ECON1, B'00010100')
	movlw	31
	movwf	ADDR,BANKED
	movlw	20
	movwf	ENC_OUTBYTE,BANKED
	call	ENC28J60_WRITEREG
;ENC28J60_writeReg(ECON1, B'00000100')
;ENC28J60_writePhyReg ( PHLCON, 0xA2, 0x0A )
;wait 5 s
;ENC28J60_writePhyReg ( PHLCON, 0x76, 0x04 )
	movlw	20
	movwf	PHYREGADDR,BANKED
	movlw	118
	movwf	ENC_OUTBYTE1,BANKED
	movlw	4
	movwf	ENC_OUTBYTE2,BANKED
	goto	ENC28J60_WRITEPHYREG

;********************************************************************************

ENC28J60_INITIALISE
;IF NOT_TO = 0 THEN
;crash++
;ELSE
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
;crash = 0
	clrf	CRASH,BANKED
;END IF
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
;T_ip_hdr_cksum = 0x00
	clrf	T_IP_HDR_CKSUM,BANKED
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
	movwf	SysTemp2,BANKED
	movlw	1
	subwf	SysTemp2,W,BANKED
	movwf	VAL2,BANKED
	clrf	VAL2_H,BANKED
	btfss	STATUS,C,ACCESS
	decf	VAL2_H,F,BANKED
;T_ip_hdr_cksum0 = 0
	banksel	SYSETHERBUFFER_25
	clrf	SYSETHERBUFFER_25,BANKED
;T_ip_hdr_cksum1 = 0
	clrf	SYSETHERBUFFER_26,BANKED
;General_part_checksum(val1 , Val2)
	banksel	0
	call	GENERAL_PART_CHECKSUM
;T_ip_hdr_cksum0 = Val3
	movff	VAL3,SYSETHERBUFFER_25
;T_ip_hdr_cksum1 = Val4
	movff	VAL4,SYSETHERBUFFER_26
	return

;********************************************************************************

ENC28J60_NTP
;dim l1 as long
;HSerPrint hex(T_udp_data0)
	movff	SYSETHERBUFFER_43,SYSVALTEMP
	call	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT243
;HSerPrint hex(T_udp_data1)
	movff	SYSETHERBUFFER_44,SYSVALTEMP
	call	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT243
;HSerPrint hex(T_udp_data2)
	movff	SYSETHERBUFFER_45,SYSVALTEMP
	call	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT243
;HSerPrint hex(T_udp_data3)
	movff	SYSETHERBUFFER_46,SYSVALTEMP
	call	FN_HEX
	movlw	low HEX
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high HEX
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT243
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;L1 = T_udp_data0
	movff	SYSETHERBUFFER_43,L1
	clrf	L1_H,BANKED
	clrf	L1_U,BANKED
	clrf	L1_E,BANKED
;L1_H = T_udp_data1
	movff	SYSETHERBUFFER_44,L1_H
;L1_U = T_udp_data2
	movff	SYSETHERBUFFER_45,L1_U
;L1_E   = T_udp_data3
	movff	SYSETHERBUFFER_46,L1_E
;L2 = L1 + 1139293696
	movlw	0
	addwf	L1,W,BANKED
	movwf	L2,BANKED
;L2 = L2 + 3600 ' offset UTC + 1 hour
	movlw	16
	addwf	L2,F,BANKED
;HserPrint "Date : "
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
	call	HSERPRINT243
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINTCRLF
;HserPrint "Time : "
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable52
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable52
	movwf	TBLPTRH,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT243
;HSerPrint L2
	movff	L2,SERPRINTVAL
	movlw	1
	movwf	COMPORT,BANKED
	call	HSERPRINT244
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	goto	HSERPRINTCRLF

;********************************************************************************

ENC28J60_NTP_GET
;T_enetpacketdest0 = macaddrrouter(1)                  ' 00-50-7f-dc-64-48 MAC-address of my router
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
;Nist - time.Nist.gov
;Nist IP:
;128.138.141.172
;T_ip_destaddr0 = ntpserveraddr(1)                                            ' the NTP-server here
	movff	SYSNTPSERVERADDR_1,SYSETHERBUFFER_31
;T_ip_destaddr1 = ntpserveraddr(2)
	movff	SYSNTPSERVERADDR_2,SYSETHERBUFFER_32
;T_ip_destaddr2 = ntpserveraddr(3)
	movff	SYSNTPSERVERADDR_3,SYSETHERBUFFER_33
;T_ip_destaddr3 = ntpserveraddr(4)
	movff	SYSNTPSERVERADDR_4,SYSETHERBUFFER_34
;T_udp_srcport0 = 0X13
	movlw	19
	movwf	SYSETHERBUFFER_35,BANKED
;T_udp_srcport1 = 0X88
	movlw	136
	movwf	SYSETHERBUFFER_36,BANKED
;T_udp_destport0 = 0X00                                        'port 0025 = 37 NTP
	clrf	SYSETHERBUFFER_37,BANKED
;T_udp_destport1 = 0X25
	movlw	37
	movwf	SYSETHERBUFFER_38,BANKED
;T_udp_len0 = 0X00
	clrf	SYSETHERBUFFER_39,BANKED
;T_udp_len1 = 0X1C
	movlw	28
	movwf	SYSETHERBUFFER_40,BANKED
;T_udp_data0 = Asc( "X")
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable50
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable50
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysSYSINSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysSYSINSTRINGAHandler_H,BANKED
	movlw	1
	movwf	SYSCHAR,BANKED
	call	FN_ASC
	movff	ASC,SYSETHERBUFFER_43
;T_udp_data1 = 0X0A ' lf
	movlw	10
	banksel	SYSETHERBUFFER_44
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
;ENC28J60_Ip_header_checksum
	banksel	0
	rcall	ENC28J60_IP_HEADER_CHECKSUM
;ENC28J60_Udp_checksum
	rcall	ENC28J60_UDP_CHECKSUM
;ENC28J60_Echopacket
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
;Enc28j60writebuffer( 45 )
	movlw	45
	movwf	PCKTLEN,BANKED
	clrf	PCKTLEN_H,BANKED
	rcall	ENC28J60WRITEBUFFER
;Enc28j60packetsend( hulp2 )
	movff	HULP2,PCKTLEN
	clrf	PCKTLEN_H,BANKED
	goto	ENC28J60PACKETSEND

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
	bra	ENDIF5
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
	bra	ELSE6_1
;ENC28J60_selectBank ( banktobeselected, addr )
	rcall	ENC28J60_SELECTBANK
;else
	bra	ENDIF6
ELSE6_1
;lastselectedBank = banktobeselected
	movff	BANKTOBESELECTED,LASTSELECTEDBANK
;end if
ENDIF6
;end if
ENDIF5
;ENC28J60_Select
	bcf	LATA,5,ACCESS
;Set WCOL Off
	bcf	SSPCON1,WCOL,ACCESS
;SSPBUF = ENC28J60_READ_CTRL_REG | ( addr AND ADDR_MASK )
	movlw	31
	andwf	ADDR,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SSPBUF
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
;temp = SSPBUF
	movff	SSPBUF,TEMP
;Set WCOL Off
	bcf	SSPCON1,WCOL,ACCESS
;SSPBUF = temp
	movff	TEMP,SSPBUF
;Wait While BF = Off
SysWaitLoop6
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop6
;ENC28J60_ReadReg = SSPBUF
	movff	SSPBUF,ENC28J60_READREG
;ENC28J60_Deselect
	bsf	LATA,5,ACCESS
	return

;********************************************************************************

ENC28J60_SELECTBANK
;ENC28J60_Select
	bcf	LATA,5,ACCESS
;FastHWSPITransfer(BFCCMD | ECON1, temp)
	movlw	191
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;FastHWSPITransfer(b'00000011', temp)
	movlw	3
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;ENC28J60_Deselect
	bsf	LATA,5,ACCESS
;Select case banktobeselected
;case 1
SysSelect1Case1
	decf	BANKTOBESELECTED,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case2
;ENC28J60_Select
	bcf	LATA,5,ACCESS
;FastHWSPITransfer(BFSCMD | ECON1, temp)
	movlw	159
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;FastHWSPITransfer(b'00000001' , temp)
	movlw	1
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;ENC28J60_Deselect
	bsf	LATA,5,ACCESS
;case 2
	bra	SysSelectEnd1
SysSelect1Case2
	movlw	2
	subwf	BANKTOBESELECTED,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case3
;	ENC28J60_Select
	bcf	LATA,5,ACCESS
;FastHWSPITransfer(BFSCMD | ECON1, temp)
	movlw	159
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;FastHWSPITransfer(b'00000010' , temp)
	movlw	2
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;ENC28J60_Deselect
	bsf	LATA,5,ACCESS
;case 3
	bra	SysSelectEnd1
SysSelect1Case3
	movlw	3
	subwf	BANKTOBESELECTED,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect1Case4
;	ENC28J60_Select
	bcf	LATA,5,ACCESS
;FastHWSPITransfer(BFSCMD | ECON1, temp)
	movlw	159
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;FastHWSPITransfer(b'00000011' , temp)
	movlw	3
	movwf	SPITXDATA,BANKED
	rcall	FASTHWSPITRANSFER
;ENC28J60_Deselect
	bsf	LATA,5,ACCESS
;End Select
SysSelect1Case4
SysSelectEnd1
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
;ENC28J60_Setst_mac
	rcall	ENC28J60_SETST_MAC
;ENC28J60_Ip_header_checksum
	rcall	ENC28J60_IP_HEADER_CHECKSUM
;Calcchecksum(15 , 33 , 25)
	return

;********************************************************************************

ENC28J60_SETST_MAC
;For II = 1 To 6
	clrf	II,BANKED
SysForLoop12
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
	bra	SysForLoop12
SysForLoopEnd12
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
SysSelect3Case1
	movlw	37
	banksel	SYSETHERBUFFER_36
	subwf	SYSETHERBUFFER_36,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect3Case2
;ENC28J60_NTP
	banksel	0
	rcall	ENC28J60_NTP
;Exit Sub
	return
;end select
SysSelect3Case2
SysSelectEnd3
;select case T_udp_destport
;case 6000
SysSelect4Case1
	movff	T_UDP_DESTPORT,SysWORDTempA
	movff	T_UDP_DESTPORT_H,SysWORDTempA_H
	movlw	112
	movwf	SysWORDTempB,ACCESS
	movlw	23
	movwf	SysWORDTempB_H,ACCESS
	banksel	0
	call	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect4Case2
;if T_udp_data = "R" then
	movlw	82
	banksel	SYSETHERBUFFER_43
	subwf	SYSETHERBUFFER_43,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF47
;ENC28J60_Initialise
	banksel	0
	rcall	ENC28J60_INITIALISE
;goto Restart
	goto	RESTART
;end if
ENDIF47
;if T_udp_data = "D" then
	movlw	68
	subwf	SYSETHERBUFFER_43,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF48
;Enc28j60regdump
	banksel	0
	call	ENC28J60REGDUMP
;end if
ENDIF48
;case 5000
	bra	SysSelectEnd4
SysSelect4Case2
	movff	T_UDP_DESTPORT,SysWORDTempA
	movff	T_UDP_DESTPORT_H,SysWORDTempA_H
	movlw	136
	movwf	SysWORDTempB,ACCESS
	movlw	19
	movwf	SysWORDTempB_H,ACCESS
	call	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect4Case3
;Select Case T_udp_data
;Case "A" : HSerPrint "Action A"
SysSelect5Case1
	movlw	65
	banksel	SYSETHERBUFFER_43
	subwf	SYSETHERBUFFER_43,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case2
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable29
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable29
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT243
;Case "B" : HSerPrint "Action B"
	bra	SysSelectEnd5
SysSelect5Case2
	movlw	66
	subwf	SYSETHERBUFFER_43,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case3
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable31
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable31
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT243
;Case "C" : HSerPrint "Action C"
	bra	SysSelectEnd5
SysSelect5Case3
	movlw	67
	subwf	SYSETHERBUFFER_43,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case4
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable33
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable33
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT243
;Case "D" : HSerPrint "Action D"
	bra	SysSelectEnd5
SysSelect5Case4
	movlw	68
	subwf	SYSETHERBUFFER_43,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case5
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable34
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable34
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT243
;Case "E" : HSerPrint "Action E"
	bra	SysSelectEnd5
SysSelect5Case5
	movlw	69
	subwf	SYSETHERBUFFER_43,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case6
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable36
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable36
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT243
;Case "T" : HserPrint "Time..."
	bra	SysSelectEnd5
SysSelect5Case6
	movlw	84
	subwf	SYSETHERBUFFER_43,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case7
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable38
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable38
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT243
;ENC28J60_Ntp_get
	rcall	ENC28J60_NTP_GET
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF
;Case "a" : HSerPrint "Action a"
	bra	SysSelectEnd5
SysSelect5Case7
	movlw	97
	subwf	SYSETHERBUFFER_43,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case8
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable40
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable40
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT243
;Case "b" : HSerPrint "Action b"
	bra	SysSelectEnd5
SysSelect5Case8
	movlw	98
	subwf	SYSETHERBUFFER_43,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case9
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable42
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable42
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT243
;Case "c" : HSerPrint "Action c"
	bra	SysSelectEnd5
SysSelect5Case9
	movlw	99
	subwf	SYSETHERBUFFER_43,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case10
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable44
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable44
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT243
;Case "d" : HSerPrint "Action d"
	bra	SysSelectEnd5
SysSelect5Case10
	movlw	100
	subwf	SYSETHERBUFFER_43,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case11
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable46
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable46
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT243
;Case "e" : HSerPrint "Action e"
	bra	SysSelectEnd5
SysSelect5Case11
	movlw	101
	subwf	SYSETHERBUFFER_43,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case12
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable48
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable48
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT243
;Case Else : HSerPrint "Action F"
	bra	SysSelectEnd5
SysSelect5Case12
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable49
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable49
	movwf	TBLPTRH,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINT243
;End Select
SysSelect5Case13
SysSelectEnd5
;HSerPrintCRLF
	movlw	1
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,BANKED
	rcall	HSERPRINTCRLF
;case 7
	bra	SysSelectEnd4
SysSelect4Case3
	movff	T_UDP_DESTPORT,SysWORDTempA
	movff	T_UDP_DESTPORT_H,SysWORDTempA_H
	movlw	7
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect4Case4
;ENC28J60_Setipaddrs
	rcall	ENC28J60_SETIPADDRS
;Swap T_udp_srcport0 , T_udp_destport0
	movff	SYSETHERBUFFER_35,SYSCALCTEMPA
	movff	SYSETHERBUFFER_37,SYSCALCTEMPB
	call	SWAP83
	movff	SYSCALCTEMPA,SYSETHERBUFFER_35
	movff	SYSCALCTEMPB,SYSETHERBUFFER_37
;Swap T_udp_srcport1 , T_udp_destport1
	movff	SYSETHERBUFFER_36,SYSCALCTEMPA
	movff	SYSETHERBUFFER_38,SYSCALCTEMPB
	call	SWAP83
	movff	SYSCALCTEMPA,SYSETHERBUFFER_36
	movff	SYSCALCTEMPB,SYSETHERBUFFER_38
;ENC28J60_Udp_checksum
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
;Enc28j60writebuffer( hulp2 )
	movff	HULP2,PCKTLEN
	movff	HULP2_H,PCKTLEN_H
	call	ENC28J60WRITEBUFFER
;Enc28j60packetsend( hulp2 )
	movff	HULP2,PCKTLEN
	movff	HULP2_H,PCKTLEN_H
	call	ENC28J60PACKETSEND
;end select
SysSelect4Case4
SysSelectEnd4
	banksel	0
	return

;********************************************************************************

ENC28J60_UDP_CHECKSUM
;dim I_chksum32 as long
;dim I_value16, Result16, I_checksum16, Hulp2, I_x as word
;T_udp_chksum0 = 0x00
	banksel	SYSETHERBUFFER_41
	clrf	SYSETHERBUFFER_41,BANKED
;T_udp_chksum1 = 0x00
	clrf	SYSETHERBUFFER_42,BANKED
;tmp = T_id0
;T_id0 = T_id1
;T_id1 = tmp
;T_flags=0x40
;I_chksum32 = 0
	banksel	I_CHKSUM32
	clrf	I_CHKSUM32,BANKED
	clrf	I_CHKSUM32_H,BANKED
	clrf	I_CHKSUM32_U,BANKED
	clrf	I_CHKSUM32_E,BANKED
;I_value16 = 0
	clrf	I_VALUE16,BANKED
	clrf	I_VALUE16_H,BANKED
;I_chksum32 = I_value16 + I_chksum32
	movf	I_CHKSUM32,W,BANKED
	addwf	I_VALUE16,W,BANKED
	movwf	I_CHKSUM32,BANKED
	movf	I_CHKSUM32_H,W,BANKED
	addwfc	I_VALUE16_H,W,BANKED
	movwf	I_CHKSUM32_H,BANKED
	clrf	SysTemp2,BANKED
	movf	I_CHKSUM32_U,W,BANKED
	addwfc	SysTemp2,W,BANKED
	movwf	I_CHKSUM32_U,BANKED
	clrf	SysTemp3,BANKED
	movf	I_CHKSUM32_E,W,BANKED
	addwfc	SysTemp3,W,BANKED
	movwf	I_CHKSUM32_E,BANKED
;I_value16 = FnLsl( T_ip_srcaddr2, 8 ) + T_ip_srcaddr3
	movff	SYSETHERBUFFER_29,SYSLONGTEMPB
	clrf	SYSLONGTEMPB_H,ACCESS
	clrf	SYSLONGTEMPB_U,ACCESS
	clrf	SYSLONGTEMPB_E,ACCESS
	movlw	8
	movwf	NUMBITS,BANKED
	rcall	FN_FNLSL
	banksel	SYSETHERBUFFER_30
	movf	SYSETHERBUFFER_30,W,BANKED
	banksel	FNLSL
	addwf	FNLSL,W,BANKED
	movwf	I_VALUE16,BANKED
	movlw	0
	addwfc	FNLSL_H,W,BANKED
	movwf	I_VALUE16_H,BANKED
;I_chksum32 = I_value16 + I_chksum32
	movf	I_CHKSUM32,W,BANKED
	addwf	I_VALUE16,W,BANKED
	movwf	I_CHKSUM32,BANKED
	movf	I_CHKSUM32_H,W,BANKED
	addwfc	I_VALUE16_H,W,BANKED
	movwf	I_CHKSUM32_H,BANKED
	clrf	SysTemp2,BANKED
	movf	I_CHKSUM32_U,W,BANKED
	addwfc	SysTemp2,W,BANKED
	movwf	I_CHKSUM32_U,BANKED
	clrf	SysTemp3,BANKED
	movf	I_CHKSUM32_E,W,BANKED
	addwfc	SysTemp3,W,BANKED
	movwf	I_CHKSUM32_E,BANKED
;I_value16 = FnLsl( T_ip_destaddr0, 8 ) + T_ip_destaddr1
	movff	SYSETHERBUFFER_31,SYSLONGTEMPB
	clrf	SYSLONGTEMPB_H,ACCESS
	clrf	SYSLONGTEMPB_U,ACCESS
	clrf	SYSLONGTEMPB_E,ACCESS
	movlw	8
	movwf	NUMBITS,BANKED
	rcall	FN_FNLSL
	banksel	SYSETHERBUFFER_32
	movf	SYSETHERBUFFER_32,W,BANKED
	banksel	FNLSL
	addwf	FNLSL,W,BANKED
	movwf	I_VALUE16,BANKED
	movlw	0
	addwfc	FNLSL_H,W,BANKED
	movwf	I_VALUE16_H,BANKED
;I_chksum32 = I_value16 + I_chksum32
	movf	I_CHKSUM32,W,BANKED
	addwf	I_VALUE16,W,BANKED
	movwf	I_CHKSUM32,BANKED
	movf	I_CHKSUM32_H,W,BANKED
	addwfc	I_VALUE16_H,W,BANKED
	movwf	I_CHKSUM32_H,BANKED
	clrf	SysTemp2,BANKED
	movf	I_CHKSUM32_U,W,BANKED
	addwfc	SysTemp2,W,BANKED
	movwf	I_CHKSUM32_U,BANKED
	clrf	SysTemp3,BANKED
	movf	I_CHKSUM32_E,W,BANKED
	addwfc	SysTemp3,W,BANKED
	movwf	I_CHKSUM32_E,BANKED
;I_value16 = FnLsl( T_ip_destaddr2, 8 ) + T_ip_destaddr3
	movff	SYSETHERBUFFER_33,SYSLONGTEMPB
	clrf	SYSLONGTEMPB_H,ACCESS
	clrf	SYSLONGTEMPB_U,ACCESS
	clrf	SYSLONGTEMPB_E,ACCESS
	movlw	8
	movwf	NUMBITS,BANKED
	rcall	FN_FNLSL
	banksel	SYSETHERBUFFER_34
	movf	SYSETHERBUFFER_34,W,BANKED
	banksel	FNLSL
	addwf	FNLSL,W,BANKED
	movwf	I_VALUE16,BANKED
	movlw	0
	addwfc	FNLSL_H,W,BANKED
	movwf	I_VALUE16_H,BANKED
;I_chksum32 = I_value16 + I_chksum32
	movf	I_CHKSUM32,W,BANKED
	addwf	I_VALUE16,W,BANKED
	movwf	I_CHKSUM32,BANKED
	movf	I_CHKSUM32_H,W,BANKED
	addwfc	I_VALUE16_H,W,BANKED
	movwf	I_CHKSUM32_H,BANKED
	clrf	SysTemp2,BANKED
	movf	I_CHKSUM32_U,W,BANKED
	addwfc	SysTemp2,W,BANKED
	movwf	I_CHKSUM32_U,BANKED
	clrf	SysTemp3,BANKED
	movf	I_CHKSUM32_E,W,BANKED
	addwfc	SysTemp3,W,BANKED
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
;I_value16 = FnLsl( T_udp_len0, 8 ) + T_udp_len1
	movff	SYSETHERBUFFER_39,SYSLONGTEMPB
	clrf	SYSLONGTEMPB_H,ACCESS
	clrf	SYSLONGTEMPB_U,ACCESS
	clrf	SYSLONGTEMPB_E,ACCESS
	movlw	8
	movwf	NUMBITS,BANKED
	rcall	FN_FNLSL
	banksel	SYSETHERBUFFER_40
	movf	SYSETHERBUFFER_40,W,BANKED
	banksel	FNLSL
	addwf	FNLSL,W,BANKED
	movwf	I_VALUE16,BANKED
	movlw	0
	addwfc	FNLSL_H,W,BANKED
	movwf	I_VALUE16_H,BANKED
;I_chksum32 = I_value16 + I_chksum32
	movf	I_CHKSUM32,W,BANKED
	addwf	I_VALUE16,W,BANKED
	movwf	I_CHKSUM32,BANKED
	movf	I_CHKSUM32_H,W,BANKED
	addwfc	I_VALUE16_H,W,BANKED
	movwf	I_CHKSUM32_H,BANKED
	clrf	SysTemp2,BANKED
	movf	I_CHKSUM32_U,W,BANKED
	addwfc	SysTemp2,W,BANKED
	movwf	I_CHKSUM32_U,BANKED
	clrf	SysTemp3,BANKED
	movf	I_CHKSUM32_E,W,BANKED
	addwfc	SysTemp3,W,BANKED
	movwf	I_CHKSUM32_E,BANKED
;I_odd = T_udp_len1 Mod 2
	clrf	I_ODD,BANKED
	banksel	SYSETHERBUFFER_40
	btfss	SYSETHERBUFFER_40,0,BANKED
	bra	ENDIF52
	banksel	I_ODD
	incf	I_ODD,F,BANKED
ENDIF52
;Result16 = FnLsl( T_udp_len0, 8 ) + T_udp_len1
	movff	SYSETHERBUFFER_39,SYSLONGTEMPB
	clrf	SYSLONGTEMPB_H,ACCESS
	clrf	SYSLONGTEMPB_U,ACCESS
	clrf	SYSLONGTEMPB_E,ACCESS
	movlw	8
	banksel	NUMBITS
	movwf	NUMBITS,BANKED
	rcall	FN_FNLSL
	banksel	SYSETHERBUFFER_40
	movf	SYSETHERBUFFER_40,W,BANKED
	banksel	FNLSL
	addwf	FNLSL,W,BANKED
	movwf	RESULT16,BANKED
	movlw	0
	addwfc	FNLSL_H,W,BANKED
	movwf	RESULT16_H,BANKED
;Hulp1 = 0x2B
	movlw	43
	movwf	HULP1,BANKED
;Hulp2 = 0x2B + Result16
	movlw	43
	addwf	RESULT16,W,BANKED
	movwf	HULP2,BANKED
	movlw	0
	addwfc	RESULT16_H,W,BANKED
	movwf	HULP2_H,BANKED
;Hulp2 = Hulp2 - 12
	movlw	12
	subwf	HULP2,F,BANKED
	movlw	0
	subwfb	HULP2_H,F,BANKED
;For I_x = Hulp1 To Hulp2 Step 2
	movlw	2
	subwf	HULP1,W,BANKED
	movwf	I_X,BANKED
	clrf	I_X_H,BANKED
	btfss	STATUS,C,ACCESS
	decf	I_X_H,F,BANKED
	movff	HULP1,SysWORDTempB
	clrf	SysWORDTempB_H,ACCESS
	movff	HULP2,SysWORDTempA
	movff	HULP2_H,SysWORDTempA_H
	rcall	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd6
SysForLoop6
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
	rcall	FN_FNLSL
	movff	FNLSL,I_VALUE16
	movff	FNLSL_H,I_VALUE16_H
;Hulp3 = I_x + 1
	incf	I_X,W,BANKED
	movwf	HULP3,BANKED
;I_value16 = I_value16 + etherbuffer(hulp3)
	lfsr	0,ETHERBUFFER
	movf	HULP3,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movf	INDF0,W,ACCESS
	addwf	I_VALUE16,F,BANKED
	movlw	0
	addwfc	I_VALUE16_H,F,BANKED
;I_chksum32 = I_chksum32 + I_value16
	movf	I_VALUE16,W,BANKED
	addwf	I_CHKSUM32,F,BANKED
	movf	I_VALUE16_H,W,BANKED
	addwfc	I_CHKSUM32_H,F,BANKED
	movlw	0
	addwfc	I_CHKSUM32_U,F,BANKED
	movlw	0
	addwfc	I_CHKSUM32_E,F,BANKED
;Next I_x
	movff	I_X,SysWORDTempA
	movff	I_X_H,SysWORDTempA_H
	movff	HULP2,SysWORDTempB
	movff	HULP2_H,SysWORDTempB_H
	rcall	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop6
SysForLoopEnd6
;If I_odd = 1 Then
	decf	I_ODD,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF51
;Hulp2 = Hulp2 + 3
	movlw	3
	addwf	HULP2,F,BANKED
	movlw	0
	addwfc	HULP2_H,F,BANKED
;I_value16 = 0
;I_value16 = FnLsl( etherbuffer(hulp2), 8 )
	lfsr	0,ETHERBUFFER
	movf	HULP2,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movff	INDF0,SYSLONGTEMPB
	clrf	SYSLONGTEMPB_H,ACCESS
	clrf	SYSLONGTEMPB_U,ACCESS
	clrf	SYSLONGTEMPB_E,ACCESS
	movlw	8
	movwf	NUMBITS,BANKED
	rcall	FN_FNLSL
	movff	FNLSL,I_VALUE16
	movff	FNLSL_H,I_VALUE16_H
;I_chksum32 = I_chksum32 + I_value16
	movf	I_VALUE16,W,BANKED
	addwf	I_CHKSUM32,F,BANKED
	movf	I_VALUE16_H,W,BANKED
	addwfc	I_CHKSUM32_H,F,BANKED
	movlw	0
	addwfc	I_CHKSUM32_U,F,BANKED
	movlw	0
	addwfc	I_CHKSUM32_E,F,BANKED
;End If
ENDIF51
;I_checksum16 =  FnLsr( i_chksum32, 16 )
	movff	I_CHKSUM32,SYSLONGTEMPB
	movff	I_CHKSUM32_H,SYSLONGTEMPB_H
	movff	I_CHKSUM32_U,SYSLONGTEMPB_U
	movff	I_CHKSUM32_E,SYSLONGTEMPB_E
	movlw	16
	movwf	NUMBITS,BANKED
	rcall	FN_FNLSR
	movff	FNLSR,I_CHECKSUM16
	movff	FNLSR_H,I_CHECKSUM16_H
;I_checksum16 = I_checksum16 + [word]I_chksum32                 ' only 16 lower bits of i_chksum32 is taken...
	movf	I_CHKSUM32,W,BANKED
	addwf	I_CHECKSUM16,F,BANKED
	movf	I_CHKSUM32_H,W,BANKED
	addwfc	I_CHECKSUM16_H,F,BANKED
;I_checksum16 = Not I_checksum16
	comf	I_CHECKSUM16,F,BANKED
	comf	I_CHECKSUM16_H,F,BANKED
;T_udp_chksum0 = i_checksum16_h
	movff	I_CHECKSUM16_H,SYSETHERBUFFER_41
;T_udp_chksum1 = i_checksum16
	movff	I_CHECKSUM16,SYSETHERBUFFER_42
;T_udp_chksum0 = 0
	banksel	SYSETHERBUFFER_41
	clrf	SYSETHERBUFFER_41,BANKED
;T_udp_chksum1 = 0
	clrf	SYSETHERBUFFER_42,BANKED
	banksel	0
	return

;********************************************************************************

ENC28J60_WRITEPHYREG
;		while ((ENC28J60_ReadReg(MISTAT) & MISTAT_BUSY ) = MISTAT_BUSY )
SysDoLoop_S2
	movlw	234
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
;ENC28J60_writeReg( MIREGADR, PhyRegaddr )
	movlw	212
	movwf	ADDR,BANKED
	movff	PHYREGADDR,ENC_OUTBYTE
	rcall	ENC28J60_WRITEREG
;temp = ENC28J60_ReadReg( MIREGADR )
;ENC28J60_writeReg( MIWRL, ENC_Outbyte1 )
	movlw	214
	movwf	ADDR,BANKED
	movff	ENC_OUTBYTE1,ENC_OUTBYTE
	rcall	ENC28J60_WRITEREG
;ENC28J60_writeReg( MIWRH, ENC_Outbyte2 )
	movlw	215
	movwf	ADDR,BANKED
	movff	ENC_OUTBYTE2,ENC_OUTBYTE
	rcall	ENC28J60_WRITEREG
;wait while ( (ENC28J60_ReadReg( MISTAT ) & MISTAT_BUSY ) = MISTAT_BUSY )
SysWaitLoop3
	movlw	234
	movwf	ADDR,BANKED
	rcall	FN_ENC28J60_READREG
	movlw	1
	andwf	ENC28J60_READREG,W,BANKED
	movwf	SysTemp1,BANKED
	movff	SysTemp1,SysBYTETempA
	movlw	1
	movwf	SysBYTETempB,ACCESS
	rcall	SysCompEqual
	btfsc	SysByteTempX,0,ACCESS
	bra	SysWaitLoop3
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
	bra	ELSE3_1
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
;ENC28J60_selectBank ( banktobeselected, addr )
	rcall	ENC28J60_SELECTBANK
;end if
;Else
	bra	ENDIF3
ELSE3_1
;lastselectedBank = banktobeselected
	movff	BANKTOBESELECTED,LASTSELECTEDBANK
;end if
ENDIF3
;ENC28J60_Select
	bcf	LATA,5,ACCESS
;FastHWSPITransfer( ENC28J60_WRITE_CTRL_REG | (addr AND ADDR_MASK ), temp )
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
;ENC28J60_Deselect
	bsf	LATA,5,ACCESS
	return

;********************************************************************************

FASTHWSPITRANSFER
;Set SSPCON1.WCOL Off
	bcf	SSPCON1,WCOL,ACCESS
;SSPBUF = SPITxData
	movff	SPITXDATA,SSPBUF
;Wait While SSPSTAT.BF = Off
SysWaitLoop10
	btfss	SSPSTAT,BF,ACCESS
	bra	SysWaitLoop10
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
	movff	NUMBITS,SysRepeatTemp5
	movf	SYSREPEATTEMP5,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd5
SysRepeatLoop5
;Set C Off
	bcf	STATUS,C,ACCESS
;Rotate SysLongTempB Left
	rlcf	SYSLONGTEMPB,F,ACCESS
	rlcf	SYSLONGTEMPB_H,F,ACCESS
	rlcf	SYSLONGTEMPB_U,F,ACCESS
	rlcf	SYSLONGTEMPB_E,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp5,F,BANKED
	bra	SysRepeatLoop5
SysRepeatLoopEnd5
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
	movff	NUMBITS,SysRepeatTemp4
	movf	SYSREPEATTEMP4,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd4
SysRepeatLoop4
;Set C Off
	bcf	STATUS,C,ACCESS
;Rotate SysLongTempB Right
	rrcf	SYSLONGTEMPB_E,F,ACCESS
	rrcf	SYSLONGTEMPB_U,F,ACCESS
	rrcf	SYSLONGTEMPB_H,F,ACCESS
	rrcf	SYSLONGTEMPB,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp4,F,BANKED
	bra	SysRepeatLoop4
SysRepeatLoopEnd4
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

GENERAL_PART_CHECKSUM
;dim I_value16, I_x as word
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
	rcall	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd7
SysForLoop7
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
	rcall	FN_FNLSL
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
	addwf	I_VALUE16,F,BANKED
	movlw	0
	addwfc	I_VALUE16_H,F,BANKED
;I_chksum32 = I_chksum32 + I_value16
	movf	I_VALUE16,W,BANKED
	addwf	I_CHKSUM32,F,BANKED
	movf	I_VALUE16_H,W,BANKED
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
	rcall	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop7
SysForLoopEnd7
;If I_odd = 1 Then
	decf	I_ODD,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF55
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
	rcall	FN_FNLSL
	movff	FNLSL,I_VALUE16
	movff	FNLSL_H,I_VALUE16_H
;I_chksum32 = I_chksum32 + I_value16
	movf	I_VALUE16,W,BANKED
	addwf	I_CHKSUM32,F,BANKED
	movf	I_VALUE16_H,W,BANKED
	addwfc	I_CHKSUM32_H,F,BANKED
	movlw	0
	addwfc	I_CHKSUM32_U,F,BANKED
	movlw	0
	addwfc	I_CHKSUM32_E,F,BANKED
;End If
ENDIF55
;I_checksum16 = Fnlsr(i_chksum32, 16)
	movff	I_CHKSUM32,SYSLONGTEMPB
	movff	I_CHKSUM32_H,SYSLONGTEMPB_H
	movff	I_CHKSUM32_U,SYSLONGTEMPB_U
	movff	I_CHKSUM32_E,SYSLONGTEMPB_E
	movlw	16
	movwf	NUMBITS,BANKED
	rcall	FN_FNLSR
	movff	FNLSR,I_CHECKSUM16
	movff	FNLSR_H,I_CHECKSUM16_H
;HSerPrint hex(I_checksum16_h)
;HSerPrint hex(I_checksum16)
;HSerPrintCRLF
;I_checksum16 = I_checksum16 + I_chksum32 ' only 16 lower bits of i_chksum32 is taken...
	movf	I_CHKSUM32,W,BANKED
	addwf	I_CHECKSUM16,F,BANKED
	movf	I_CHKSUM32_H,W,BANKED
	addwfc	I_CHECKSUM16_H,F,BANKED
;HSerPrint hex(I_checksum16_h)
;HSerPrint hex(I_checksum16)
;HSerPrintCRLF
;I_checksum16 = Not I_checksum16
	comf	I_CHECKSUM16,F,BANKED
	comf	I_CHECKSUM16_H,F,BANKED
;HSerPrint hex(I_checksum16_h)
;HSerPrint hex(I_checksum16)
;HSerPrintCRLF
;Val3 = i_checksum16_h
	movff	I_CHECKSUM16_H,VAL3
;Val4 = i_checksum16
	movff	I_CHECKSUM16,VAL4
;HSerPrint hex(val3)
;HSerPrint hex(val4)
;HSerPrintCRLF
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
	bra	ENDIF59
	movlw	7
	addwf	SYSSTRINGTEMP,F,BANKED
ENDIF59
;Hex(2) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W,BANKED
	banksel	SYSHEX_2
	movwf	SYSHEX_2,BANKED
;For SysStringTemp = 1 to 4
	banksel	SYSSTRINGTEMP
	clrf	SYSSTRINGTEMP,BANKED
SysForLoop10
	incf	SYSSTRINGTEMP,F,BANKED
;Rotate SysValTemp Right
	rrcf	SYSVALTEMP,F,BANKED
;Next
	movlw	4
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop10
SysForLoopEnd10
;SysStringTemp = SysValTemp And 0x0F
	movlw	15
	andwf	SYSVALTEMP,W,BANKED
	movwf	SYSSTRINGTEMP,BANKED
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	sublw	9
	btfsc	STATUS, C,ACCESS
	bra	ENDIF61
	movlw	7
	addwf	SYSSTRINGTEMP,F,BANKED
ENDIF61
;Hex(1) = SysStringTemp + 48
	movlw	48
	addwf	SYSSTRINGTEMP,W,BANKED
	banksel	SYSHEX_1
	movwf	SYSHEX_1,BANKED
	banksel	0
	return

;********************************************************************************

;Overloaded signature: STRING:byte:
HSERPRINT243
;PrintLen = PrintData(0)
	movff	SysPRINTDATAHandler,AFSR0
	movff	SysPRINTDATAHandler_H,AFSR0_H
	movff	INDF0,PRINTLEN
;If PrintLen <> 0 then
	movf	PRINTLEN,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF19
;for SysPrintTemp = 1 to PrintLen
	clrf	SYSPRINTTEMP,BANKED
	movlw	1
	subwf	PRINTLEN,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd2
SysForLoop2
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
	bra	SysForLoop2
SysForLoopEnd2
;End If
ENDIF19
	return

;********************************************************************************

;Overloaded signature: BYTE:byte:
HSERPRINT244
;OutValueTemp = 0
	clrf	OUTVALUETEMP,BANKED
;IF SerPrintVal >= 100 Then
	movlw	100
	subwf	SERPRINTVAL,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	ENDIF64
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
ENDIF64
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
	movwf	SysTemp3,BANKED
	btfss	SysTemp3,0,BANKED
	bra	ENDIF65
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
ENDIF65
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
	bra	ENDIF18
;Wait While TXIF = Off
SysWaitLoop11
	btfss	PIR1,TXIF,ACCESS
	bra	SysWaitLoop11
;Wait While TXIF = Off
SysWaitLoop12
	btfss	PIR1,TXIF,ACCESS
	bra	SysWaitLoop12
;TXREG = SerData
	movff	SERDATA,TXREG
;end if
ENDIF18
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

PINGREPLY
;Dim Packetlength As Word
;ENC28J60_Setst_mac
	call	ENC28J60_SETST_MAC
;Setip_id
	rcall	SETIP_ID
;Setst_ip
	rcall	SETST_IP
;etherBuffer(25) = 0
	banksel	SYSETHERBUFFER_25
	clrf	SYSETHERBUFFER_25,BANKED
;etherBuffer(26) = 0
	clrf	SYSETHERBUFFER_26,BANKED
;Calcchecksum(15 , 33 , 25)
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
	call	CALCCHECKSUM
;etherBuffer(35) = 0
	banksel	SYSETHERBUFFER_35
	clrf	SYSETHERBUFFER_35,BANKED
;etherBuffer(37) = 0
	clrf	SYSETHERBUFFER_37,BANKED
;etherBuffer(38) = 0
	clrf	SYSETHERBUFFER_38,BANKED
;Packetlength = etherBuffer(17) * 256
	movff	SYSETHERBUFFER_17,SysWORDTempA
	clrf	SysWORDTempA_H,ACCESS
	clrf	SysWORDTempB,ACCESS
	movlw	1
	movwf	SysWORDTempB_H,ACCESS
	banksel	0
	rcall	SysMultSub16
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
;Calcchecksum(35 , Packetlength , 37)
	movlw	35
	movwf	STARTPTR,BANKED
	clrf	STARTPTR_H,BANKED
	movff	PACKETLENGTH,ENDPTR
	movff	PACKETLENGTH_H,ENDPTR_H
	movlw	37
	movwf	RESULT,BANKED
	clrf	RESULT_H,BANKED
	call	CALCCHECKSUM
;Packetlength = Packetlength + 1
	incf	PACKETLENGTH,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	PACKETLENGTH_H,F,BANKED
;Enc28j60writebuffer( packetlength )
	movff	PACKETLENGTH,PCKTLEN
	movff	PACKETLENGTH_H,PCKTLEN_H
	call	ENC28J60WRITEBUFFER
;Enc28j60packetsend(packetlength)
	movff	PACKETLENGTH,PCKTLEN
	movff	PACKETLENGTH_H,PCKTLEN_H
	goto	ENC28J60PACKETSEND

;********************************************************************************

SETIP_ID
;etherBuffer(19) = ip_id_h
	movff	IP_ID_H,SYSETHERBUFFER_19
;etherBuffer(20) = [byte]ip_id
	movff	IP_ID,SYSETHERBUFFER_20
;Ip_id = Ip_id + 1
	incf	IP_ID,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	IP_ID_H,F,BANKED
	return

;********************************************************************************

SETST_IP
;Dim II As Byte
;For II = 1 To 4
	clrf	II,BANKED
SysForLoop8
	incf	II,F,BANKED
;etherBuffer(30 + II) = etherBuffer(26 + II)
	lfsr	0,ETHERBUFFER
	movlw	26
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
	movlw	30
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
;Next I
	movlw	4
	subwf	II,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop8
SysForLoopEnd8
;etherBuffer(27) = ipaddr(1)
	movff	SYSIPADDR_1,SYSETHERBUFFER_27
;etherBuffer(28) = ipaddr(2)
	movff	SYSIPADDR_2,SYSETHERBUFFER_28
;etherBuffer(29) = ipaddr(3)
	movff	SYSIPADDR_3,SYSETHERBUFFER_29
;etherBuffer(30) = ipaddr(4)
	movff	SYSIPADDR_4,SYSETHERBUFFER_30
	return

;********************************************************************************

;Overloaded signature: BYTE:BYTE:
SPIMODE199
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
	bra	ENDIF71
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
ENDIF71
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
	bra	ENDIF72
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
ENDIF72
;IF SysValTemp >= 100 then
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF73
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
ENDIF73
;IF SysValTemp >= 10 Then
	movff	SYSVALTEMP,SysWORDTempA
	movff	SYSVALTEMP_H,SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	rcall	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF74
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
ENDIF74
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
SWAP83
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
	bra	ENDIF75
;SysWordTempA = 0
	clrf	SYSWORDTEMPA,ACCESS
	clrf	SYSWORDTEMPA_H,ACCESS
;exit sub
	return
;end if
ENDIF75
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
	bra	ENDIF76
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0,ACCESS
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W,ACCESS
	addwf	SYSDIVMULTX,F,ACCESS
	movf	SYSDIVMULTB_H,W,ACCESS
	addwfc	SYSDIVMULTX_H,F,ACCESS
;End If
ENDIF76
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
	dw	7196,"ENC28J60 Ethernet Driver 018"


StringTable4
	dw	2827,"Initialised"


StringTable5
	dw	771,"..."


StringTable8
	dw	2313,"No packet"


StringTable10
	dw	771,"   "


StringTable11
	dw	1285,"     "


StringTable15
	dw	4112,"TCP Reply Needed"


StringTable16
	dw	5397,"Registerdump ENC28J60"


StringTable17
	dw	2570," Version: "


StringTable18
	dw	8738,"Cntrl: ECON1 ECON2 ESTAT  EIR  EIE"


StringTable19
	dw	1799,"       "


StringTable20
	dw	1028,"    "


StringTable21
	dw	12850,"MAC  : MACON1  MACON2  MACON3  MACON4  MAC-Address"


StringTable22
	dw	1542,"      "


StringTable23
	dw	257,"."


StringTable24
	dw	15163,"Rx   : ERXST  ERXND  ERXWRPT ERXRDPT ERXFCON EPKTCNT MAMXFL"


StringTable25
	dw	13621,"Tx   : ETXST  ETXND  EWRPT  MACLCON1 MACLCON2 MAPHSUP"


StringTable26
	dw	257,"R"


StringTable27
	dw	257,"D"


StringTable28
	dw	257,"A"


StringTable29
	dw	2056,"Action A"


StringTable30
	dw	257,"B"


StringTable31
	dw	2056,"Action B"


StringTable32
	dw	257,"C"


StringTable33
	dw	2056,"Action C"


StringTable34
	dw	2056,"Action D"


StringTable35
	dw	257,"E"


StringTable36
	dw	2056,"Action E"


StringTable37
	dw	257,"T"


StringTable38
	dw	1799,"Time..."


StringTable39
	dw	257,"a"


StringTable40
	dw	2056,"Action a"


StringTable41
	dw	257,"b"


StringTable42
	dw	2056,"Action b"


StringTable43
	dw	257,"c"


StringTable44
	dw	2056,"Action c"


StringTable45
	dw	257,"d"


StringTable46
	dw	2056,"Action d"


StringTable47
	dw	257,"e"


StringTable48
	dw	2056,"Action e"


StringTable49
	dw	2056,"Action F"


StringTable50
	dw	257,"X"


StringTable51
	dw	1799,"Date : "


StringTable52
	dw	1799,"Time : "


;********************************************************************************


 END
