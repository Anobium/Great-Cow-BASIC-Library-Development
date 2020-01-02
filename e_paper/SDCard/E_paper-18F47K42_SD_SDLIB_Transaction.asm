;Program compiled by Great Cow BASIC (0.98.<<>> 2019-12-08 (Windows 32 bit))
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=18F47K42, r=DEC
#include <P18F47K42.inc>
 CONFIG CP = OFF, LVP = OFF, WRTD = OFF, WDTE = OFF, MVECEN = OFF, MCLRE = EXTMCLR, CLKOUTEN = OFF, RSTOSC = HFINTOSC_1MHZ, FEXTOSC = OFF

;********************************************************************************

;Set aside memory locations for variables
ADDRESS_SECTOR	EQU	14
ADDRESS_SECTOR_E	EQU	17
ADDRESS_SECTOR_H	EQU	15
ADDRESS_SECTOR_U	EQU	16
ARG	EQU	18
ARG_E	EQU	21
ARG_H	EQU	19
ARG_U	EQU	20
A_AXIS	EQU	22
A_AXIS_H	EQU	23
A_SQ	EQU	24
A_SQ2	EQU	26
A_SQ2_E	EQU	29
A_SQ2_H	EQU	27
A_SQ2_U	EQU	28
A_SQ4	EQU	30
A_SQ4_E	EQU	33
A_SQ4_H	EQU	31
A_SQ4_U	EQU	32
A_SQ_H	EQU	25
B0	EQU	34
B0_E	EQU	37
B0_H	EQU	35
B0_U	EQU	36
B1	EQU	38
B1_E	EQU	41
B1_H	EQU	39
B1_U	EQU	40
B2	EQU	42
B2_E	EQU	45
B2_H	EQU	43
B2_U	EQU	44
B3	EQU	46
B3_E	EQU	49
B3_H	EQU	47
B3_U	EQU	48
BLOCK_START	EQU	50
BLOCK_START_E	EQU	53
BLOCK_START_H	EQU	51
BLOCK_START_U	EQU	52
BOOT_FLAG	EQU	54
B_AXIS	EQU	55
B_AXIS_H	EQU	56
B_SQ	EQU	57
B_SQ2	EQU	59
B_SQ2_E	EQU	62
B_SQ2_H	EQU	60
B_SQ2_U	EQU	61
B_SQ4	EQU	63
B_SQ4_E	EQU	66
B_SQ4_H	EQU	64
B_SQ4_U	EQU	65
B_SQ_H	EQU	58
CHARCODE	EQU	67
CHARCOL	EQU	68
CHARCOLS	EQU	70
CHARCOL_H	EQU	69
CHARLOCX	EQU	71
CHARLOCX_H	EQU	72
CHARLOCY	EQU	73
CHARLOCY_H	EQU	74
CHARROW	EQU	75
CHARROWS	EQU	77
CHARROW_H	EQU	76
CHR	EQU	6411
CLUSTER_BEGIN_LBA	EQU	78
CLUSTER_BEGIN_LBA_E	EQU	81
CLUSTER_BEGIN_LBA_H	EQU	79
CLUSTER_BEGIN_LBA_U	EQU	80
CODE	EQU	82
COL	EQU	83
COLOR	EQU	84
COLOR_H	EQU	85
COMPORT	EQU	86
COUNTER	EQU	87
COUNTER_H	EQU	88
CRC	EQU	89
CRLF1	EQU	90
CRLF2	EQU	91
CURRCHARCOL	EQU	92
CURRCHARROW	EQU	93
CURRCHARVAL	EQU	94
DATAVAR	EQU	95
DDF_X	EQU	96
DDF_X_H	EQU	97
DDF_Y	EQU	98
DDF_Y_H	EQU	99
DELAYTEMP	EQU	0
DELAYTEMP2	EQU	1
DIR_OR_FILE_NAME	EQU	6117
DIR_RECORD	EQU	6503
DIST	EQU	100
DIST_E	EQU	103
DIST_H	EQU	101
DIST_SIGN	EQU	104
DIST_U	EQU	102
DRAWLINE	EQU	105
DRAWLINE_H	EQU	106
DXOFFSET01	EQU	107
DXOFFSET01_H	EQU	108
DXOFFSET02	EQU	109
DXOFFSET02_H	EQU	110
DXOFFSET12	EQU	111
DXOFFSET12_H	EQU	112
DYOFFSET01	EQU	113
DYOFFSET01_H	EQU	114
DYOFFSET02	EQU	115
DYOFFSET02_H	EQU	116
DYOFFSET12	EQU	117
DYOFFSET12_H	EQU	118
EPD2IN13DADDRESSTYPE	EQU	119
EPD2IN13D_COMMAND	EQU	120
EPD2IN13D_DATA	EQU	121
EPD_BUFFER	EQU	7466
EPD_COUNTER	EQU	122
EPD_IND	EQU	123
EPD_IND_COL	EQU	125
EPD_IND_COL_H	EQU	126
EPD_IND_H	EQU	124
EPD_IND_RAW	EQU	127
EPD_IND_RAW_H	EQU	128
EPD_IND_TRANS	EQU	129
EPD_IND_TRANS_H	EQU	130
EPD_N_COL	EQU	131
EPD_N_COL_H	EQU	132
EPD_N_RAW	EQU	133
EPD_N_RAW_H	EQU	134
FAT_BEGIN_LBA	EQU	135
FAT_BEGIN_LBA_E	EQU	138
FAT_BEGIN_LBA_H	EQU	136
FAT_BEGIN_LBA_U	EQU	137
FF	EQU	139
FF_H	EQU	140
FILE_EXTENSION	EQU	6107
FILE_RECORD	EQU	6452
FILE_SYSTEM_VER_NUM	EQU	141
FILLCIRCLEXX	EQU	142
FILLCIRCLEYY	EQU	143
FILLED_ELLIPSE	EQU	144
FNLSL	EQU	145
FNLSL_E	EQU	149
FNLSL_H	EQU	150
FNLSL_U	EQU	151
FNLSR	EQU	152
FNLSR_E	EQU	156
FNLSR_H	EQU	157
FNLSR_U	EQU	158
FRI	EQU	159
FRI_H	EQU	160
GLCDBACKGROUND	EQU	161
GLCDBACKGROUND_H	EQU	162
GLCDCOLOUR	EQU	163
GLCDCOLOUR_H	EQU	164
GLCDDATATEMP	EQU	165
GLCDDATATEMP_H	EQU	166
GLCDDEVICEHEIGHT	EQU	167
GLCDDEVICEHEIGHT_H	EQU	168
GLCDDEVICEWIDTH	EQU	169
GLCDDEVICEWIDTH_H	EQU	170
GLCDFNTDEFAULT	EQU	171
GLCDFNTDEFAULTHEIGHT	EQU	172
GLCDFNTDEFAULTSIZE	EQU	173
GLCDFONTWIDTH	EQU	174
GLCDFOREGROUND	EQU	175
GLCDFOREGROUND_H	EQU	176
GLCDPRINTLEN	EQU	177
GLCDPRINTLOC	EQU	178
GLCDPRINTLOC_H	EQU	179
GLCDPRINT_STRING_COUNTER	EQU	180
GLCDTEMP	EQU	181
GLCDTEMP_H	EQU	182
GLCDX	EQU	183
GLCDX_H	EQU	184
GLCDY	EQU	185
GLCDY_H	EQU	186
GLCD_AA	EQU	187
GLCD_AA_H	EQU	188
GLCD_BB	EQU	189
GLCD_BB_H	EQU	190
GLCD_EX2	EQU	191
GLCD_EX2_E	EQU	194
GLCD_EX2_H	EQU	192
GLCD_EX2_U	EQU	193
GLCD_EY2	EQU	195
GLCD_EY2_E	EQU	198
GLCD_EY2_H	EQU	196
GLCD_EY2_U	EQU	197
GLCD_FX2	EQU	199
GLCD_FX2_E	EQU	202
GLCD_FX2_H	EQU	200
GLCD_FX2_U	EQU	201
GLCD_FY2	EQU	203
GLCD_FY2_E	EQU	206
GLCD_FY2_H	EQU	204
GLCD_FY2_U	EQU	205
GLCD_LAST	EQU	207
GLCD_LAST_H	EQU	208
GLCD_PP	EQU	209
GLCD_PP_E	EQU	212
GLCD_PP_H	EQU	210
GLCD_PP_TEMP	EQU	213
GLCD_PP_TEMP_E	EQU	216
GLCD_PP_TEMP_H	EQU	214
GLCD_PP_TEMP_U	EQU	215
GLCD_PP_U	EQU	211
GLCD_PX	EQU	217
GLCD_PX_E	EQU	220
GLCD_PX_H	EQU	218
GLCD_PX_U	EQU	219
GLCD_PY	EQU	221
GLCD_PY_E	EQU	224
GLCD_PY_H	EQU	222
GLCD_PY_U	EQU	223
GLCD_RX2	EQU	225
GLCD_RX2_H	EQU	226
GLCD_RY2	EQU	227
GLCD_RY2_H	EQU	228
GLCD_SA	EQU	229
GLCD_SA_H	EQU	230
GLCD_SB	EQU	231
GLCD_SB_H	EQU	232
GLCD_TIME_BUFF	EQU	233
GLCD_TIME_BUFF_H	EQU	234
GLCD_XX	EQU	235
GLCD_XX_H	EQU	236
GLCD_Y	EQU	237
GLCD_YORDINATE	EQU	239
GLCD_YORDINATE_H	EQU	240
GLCD_YY	EQU	241
GLCD_YY1	EQU	243
GLCD_YY_H	EQU	242
GLCD_Y_H	EQU	238
HALF_AB_SQ	EQU	244
HALF_AB_SQ_E	EQU	247
HALF_AB_SQ_H	EQU	245
HALF_AB_SQ_U	EQU	246
HALF_A_SQ	EQU	248
HALF_A_SQ_H	EQU	249
HALF_B_SQ	EQU	250
HALF_B_SQ_H	EQU	251
HSERINBYTE	EQU	252
HSERINDEX	EQU	253
HSERPRINTCRLFCOUNT	EQU	254
HSERRECEIVE	EQU	255
HYPERBOLECONDITION	EQU	256
IND1	EQU	257
IND2	EQU	258
INF_ADDR_BUFF	EQU	259
INF_ADDR_BUFF_H	EQU	260
INITSUCC	EQU	261
INPUTB	EQU	262
INPUTL	EQU	263
INPUTL_E	EQU	266
INPUTL_H	EQU	264
INPUTL_U	EQU	265
INPUTW	EQU	267
INPUTW_H	EQU	268
INTERSECT	EQU	269
INXRADIUS	EQU	270
INXRADIUS_H	EQU	271
INYRADIUS	EQU	272
INYRADIUS_H	EQU	273
LEFT	EQU	6370
LEN	EQU	274
LINECOLOUR	EQU	275
LINECOLOUR_H	EQU	276
LINEDIFFX	EQU	277
LINEDIFFX_H	EQU	278
LINEDIFFX_X2	EQU	279
LINEDIFFX_X2_H	EQU	280
LINEDIFFY	EQU	281
LINEDIFFY_H	EQU	282
LINEDIFFY_X2	EQU	283
LINEDIFFY_X2_H	EQU	284
LINEERR	EQU	285
LINEERR_H	EQU	286
LINESTEPX	EQU	287
LINESTEPX_H	EQU	288
LINESTEPY	EQU	289
LINESTEPY_H	EQU	290
LINEX1	EQU	291
LINEX1_H	EQU	292
LINEX2	EQU	293
LINEX2_H	EQU	294
LINEY1	EQU	295
LINEY1_H	EQU	296
LINEY2	EQU	297
LINEY2_H	EQU	298
LINE_TYPE	EQU	299
LOWERPAGE	EQU	300
MAIN_IND	EQU	301
MAIN_IND_H	EQU	302
MAIN_IND_TRANS	EQU	303
MAIN_IND_TRANS_H	EQU	304
MAIN_MYSTRING	EQU	6329
MODESTOP	EQU	305
NRESPONSE	EQU	306
NUMBITS	EQU	307
N_BYTES	EQU	308
N_BYTES_PER_SECTOR	EQU	309
N_BYTES_PER_SECTOR_H	EQU	310
N_CHAR	EQU	311
N_FATS	EQU	312
N_RESERVED_SECTOR	EQU	313
N_RESERVED_SECTOR_H	EQU	314
N_SECTORS_PER_FAT	EQU	315
N_SECTORS_PER_FAT_E	EQU	318
N_SECTORS_PER_FAT_H	EQU	316
N_SECTORS_PER_FAT_U	EQU	317
N_SECTOR_OF_FAT2	EQU	319
N_SECTOR_PER_CLUSTER	EQU	320
OUTPUT	EQU	321
OUTPUT_E	EQU	324
OUTPUT_H	EQU	322
OUTPUT_U	EQU	323
OUTVALUETEMP	EQU	325
PARTITION_BEGIN_LBA	EQU	326
PARTITION_BEGIN_LBA_E	EQU	329
PARTITION_BEGIN_LBA_H	EQU	327
PARTITION_BEGIN_LBA_U	EQU	328
PRINTLEN	EQU	330
PRINTLOCX	EQU	331
PRINTLOCX_H	EQU	332
PRINTLOCY	EQU	333
PRINTLOCY_H	EQU	334
RECORD_LOCATION	EQU	335
RECORD_LOCATION_H	EQU	336
RECORD_LOCATION_LAST	EQU	337
RECORD_LOCATION_LAST_H	EQU	338
RECORD_NUMBER	EQU	339
REMAINDER	EQU	340
RIGHT	EQU	6288
ROW	EQU	341
RX1	EQU	342
RX1_H	EQU	343
RX2	EQU	344
RX2_H	EQU	345
RY1	EQU	346
RY1_H	EQU	347
RY2	EQU	348
RY2_H	EQU	349
SDBUFF_IND	EQU	350
SDBUFF_IND_H	EQU	351
SDBYTE	EQU	352
SDBYTE_H	EQU	353
SDDATA	EQU	354
SDDATABUFFER	EQU	7679
SDLOCATION	EQU	355
SDLOCATION0	EQU	359
SDLOCATION0_E	EQU	362
SDLOCATION0_H	EQU	360
SDLOCATION0_U	EQU	361
SDLOCATION_E	EQU	358
SDLOCATION_H	EQU	356
SDLOCATION_HEADER	EQU	363
SDLOCATION_HEADER_E	EQU	366
SDLOCATION_HEADER_H	EQU	364
SDLOCATION_HEADER_U	EQU	365
SDLOCATION_LAST	EQU	367
SDLOCATION_LAST_E	EQU	370
SDLOCATION_LAST_H	EQU	368
SDLOCATION_LAST_U	EQU	369
SDLOCATION_U	EQU	357
SDRESP	EQU	371
SDRESPONSE	EQU	372
SDRESPONSE2	EQU	373
SDRESPONSE3	EQU	374
SDRESPONSE4	EQU	375
SDRESPONSE5	EQU	376
SDTOKEN	EQU	377
SD_COUNTER	EQU	378
SD_COUNTER1	EQU	380
SD_COUNTER1_H	EQU	381
SD_COUNTER2	EQU	382
SD_COUNTER2_H	EQU	383
SD_COUNTER3	EQU	384
SD_COUNTER3_H	EQU	385
SD_COUNTER_H	EQU	379
SD_MYSTRING	EQU	6161
SD_MYSTRING1	EQU	6149
SD_MYSTRING2	EQU	6137
SD_SD_COUNTER	EQU	386
SERDATA	EQU	387
SERPRINTVAL	EQU	388
SERPRINTVAL_E	EQU	391
SERPRINTVAL_H	EQU	389
SERPRINTVAL_U	EQU	390
SIGN	EQU	392
SPIRXDATA	EQU	393
SPITXDATA	EQU	394
STR	EQU	6111
STRINGLOCX	EQU	395
STRINGLOCX_H	EQU	396
STRINGPOINTER	EQU	397
SYSARRAYTEMP1	EQU	398
SYSARRAYTEMP2	EQU	399
SYSBITVAR0	EQU	400
SYSBYTETEMPA	EQU	5
SYSBYTETEMPB	EQU	9
SYSBYTETEMPX	EQU	0
SYSCALCTEMPA	EQU	5
SYSCALCTEMPA_E	EQU	8
SYSCALCTEMPA_H	EQU	6
SYSCALCTEMPA_U	EQU	7
SYSCALCTEMPB	EQU	9
SYSCALCTEMPB_H	EQU	10
SYSCALCTEMPX	EQU	0
SYSCALCTEMPX_H	EQU	1
SYSCHAR	EQU	401
SYSCHARCOUNT	EQU	402
SYSCHARHANDLER	EQU	403
SYSCHARHANDLER_H	EQU	404
SYSCHARSHANDLER	EQU	405
SYSCHARSHANDLER_H	EQU	406
SYSCHARSTART	EQU	407
SYSDIVLOOP	EQU	4
SYSDIVMULTA	EQU	7
SYSDIVMULTA_H	EQU	8
SYSDIVMULTB	EQU	11
SYSDIVMULTB_H	EQU	12
SYSDIVMULTX	EQU	2
SYSDIVMULTX_H	EQU	3
SYSHSERSTRINGHANDLER	EQU	408
SYSHSERSTRINGHANDLER_H	EQU	409
SYSINPUTSHANDLER	EQU	410
SYSINPUTSHANDLER_H	EQU	411
SYSINTEGERTEMPA	EQU	5
SYSINTEGERTEMPA_H	EQU	6
SYSINTEGERTEMPB	EQU	9
SYSINTEGERTEMPB_H	EQU	10
SYSINTEGERTEMPX	EQU	0
SYSINTEGERTEMPX_H	EQU	1
SYSLCDPRINTDATAHANDLER	EQU	412
SYSLCDPRINTDATAHANDLER_H	EQU	413
SYSLENTEMPHANDLER	EQU	414
SYSLENTEMPHANDLER_H	EQU	415
SYSLONGDIVMULTA	EQU	416
SYSLONGDIVMULTA_E	EQU	419
SYSLONGDIVMULTA_H	EQU	417
SYSLONGDIVMULTA_U	EQU	418
SYSLONGDIVMULTB	EQU	420
SYSLONGDIVMULTB_E	EQU	423
SYSLONGDIVMULTB_H	EQU	421
SYSLONGDIVMULTB_U	EQU	422
SYSLONGDIVMULTX	EQU	424
SYSLONGDIVMULTX_E	EQU	427
SYSLONGDIVMULTX_H	EQU	425
SYSLONGDIVMULTX_U	EQU	426
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
SYSNAMEHANDLER	EQU	428
SYSNAMEHANDLER_H	EQU	429
SYSPRINTBUFFER	EQU	6126
SYSPRINTBUFFLEN	EQU	430
SYSPRINTDATAHANDLER	EQU	431
SYSPRINTDATAHANDLER_H	EQU	432
SYSPRINTTEMP	EQU	433
SYSREPEATTEMP1	EQU	434
SYSREPEATTEMP10	EQU	435
SYSREPEATTEMP11	EQU	436
SYSREPEATTEMP11_H	EQU	437
SYSREPEATTEMP13	EQU	438
SYSREPEATTEMP15	EQU	439
SYSREPEATTEMP16	EQU	440
SYSREPEATTEMP17	EQU	441
SYSREPEATTEMP18	EQU	442
SYSREPEATTEMP19	EQU	443
SYSREPEATTEMP20	EQU	444
SYSREPEATTEMP21	EQU	445
SYSREPEATTEMP22	EQU	446
SYSREPEATTEMP23	EQU	447
SYSREPEATTEMP24	EQU	448
SYSREPEATTEMP3	EQU	449
SYSREPEATTEMP3_H	EQU	450
SYSREPEATTEMP4	EQU	451
SYSREPEATTEMP4_H	EQU	452
SYSREPEATTEMP5	EQU	453
SYSSIGNBYTE	EQU	13
SYSSTRDATA	EQU	454
SYSSTRINGA	EQU	7
SYSSTRINGAHANDLER	EQU	455
SYSSTRINGAHANDLER_H	EQU	456
SYSSTRINGA_H	EQU	8
SYSSTRINGLENGTH	EQU	6
SYSSTRINGPARAM1	EQU	7409
SYSSTRINGPARAM10	EQU	7352
SYSSTRINGPARAM11	EQU	7295
SYSSTRINGPARAM12	EQU	7238
SYSSTRINGPARAM13	EQU	7181
SYSSTRINGPARAM14	EQU	7124
SYSSTRINGPARAM15	EQU	7067
SYSSTRINGPARAM16	EQU	7010
SYSSTRINGPARAM17	EQU	6953
SYSSTRINGPARAM18	EQU	6896
SYSSTRINGPARAM2	EQU	6210
SYSSTRINGPARAM3	EQU	6839
SYSSTRINGPARAM4	EQU	6782
SYSSTRINGPARAM5	EQU	6725
SYSSTRINGPARAM6	EQU	6668
SYSSTRINGPARAM7	EQU	6173
SYSSTRINGPARAM8	EQU	6611
SYSSTRINGPARAM9	EQU	6554
SYSSTRINGTEMP	EQU	457
SYSSYSINSTRINGHANDLER	EQU	458
SYSSYSINSTRINGHANDLER_H	EQU	459
SYSTEMP1	EQU	460
SYSTEMP1_E	EQU	463
SYSTEMP1_H	EQU	461
SYSTEMP1_U	EQU	462
SYSTEMP2	EQU	464
SYSTEMP2_E	EQU	467
SYSTEMP2_H	EQU	465
SYSTEMP2_U	EQU	466
SYSTEMP3	EQU	468
SYSTEMP4	EQU	469
SYSTEMPARRAY	EQU	6247
SYSVALTEMP	EQU	470
SYSVALTEMP_H	EQU	471
SYSWAITTEMPMS	EQU	2
SYSWAITTEMPMS_H	EQU	3
SYSWAITTEMPS	EQU	4
SYSWORDTEMPA	EQU	5
SYSWORDTEMPA_H	EQU	6
SYSWORDTEMPB	EQU	9
SYSWORDTEMPB_H	EQU	10
SYSWORDTEMPX	EQU	0
SYSWORDTEMPX_H	EQU	1
TYPE	EQU	472
UPPERPAGE	EQU	473
VAL	EQU	474
VAL_H	EQU	475
VAR1	EQU	476
VAR1_E	EQU	479
VAR1_H	EQU	477
VAR1_U	EQU	478
VAR2	EQU	480
VAR2_E	EQU	483
VAR2_H	EQU	481
VAR2_U	EQU	482
VERBOSE	EQU	6103
XCHAR	EQU	484
XLOOP	EQU	485
XOFFSET	EQU	486
XOFFSET2	EQU	488
XOFFSET2_H	EQU	489
XOFFSET3	EQU	490
XOFFSET3_H	EQU	491
XOFFSET_H	EQU	487
XRADIUS	EQU	492
XRADIUS_H	EQU	493
X_0	EQU	494
X_0_H	EQU	495
X_COORD	EQU	496
X_COORD_H	EQU	497
X_MAX	EQU	498
X_MAX_H	EQU	499
X_MINUS	EQU	500
X_MINUS_H	EQU	501
X_OFFSET	EQU	502
X_OFFSET_H	EQU	503
X_PLUS	EQU	504
X_PLUS_H	EQU	505
X_SLOPE	EQU	506
X_SLOPE_E	EQU	509
X_SLOPE_H	EQU	507
X_SLOPE_U	EQU	508
YCALC1	EQU	510
YCALC1_H	EQU	511
YCALC2	EQU	512
YCALC2_H	EQU	513
YOFFSET	EQU	514
YOFFSET2	EQU	516
YOFFSET2_H	EQU	517
YOFFSET3	EQU	518
YOFFSET3_H	EQU	519
YOFFSET_H	EQU	515
Y_0	EQU	520
Y_0_H	EQU	521
Y_COORD	EQU	522
Y_COORD_H	EQU	523
Y_MAX	EQU	524
Y_MAX_H	EQU	525
Y_MINUS	EQU	526
Y_MINUS_H	EQU	527
Y_OFFSET	EQU	528
Y_OFFSET_H	EQU	529
Y_PLUS	EQU	530
Y_PLUS_H	EQU	531
Y_SLOPE	EQU	532
Y_SLOPE_E	EQU	535
Y_SLOPE_H	EQU	533
Y_SLOPE_U	EQU	534
_GLCDPAGE	EQU	536
_GLCDPAGESH	EQU	537
_GLCDPAGESL	EQU	538

;********************************************************************************

;Alias variables
AFSR0	EQU	16361
AFSR0_H	EQU	16362
SYSCHR_0	EQU	6411
SYSCHR_1	EQU	6412
SYSFNLSLLONG	EQU	145
SYSFNLSLLONG_H	EQU	150
SYSFNLSLLONG_U	EQU	151
SYSFNLSLLONG_E	EQU	149
SYSFNLSRLONG	EQU	152
SYSFNLSRLONG_H	EQU	157
SYSFNLSRLONG_U	EQU	158
SYSFNLSRLONG_E	EQU	156
SYSFNLSRWORD	EQU	152
SYSFNLSRWORD_H	EQU	157
SYSLEFT_0	EQU	6370
SYSRIGHT_0	EQU	6288
SYSSDDATABUFFER_11	EQU	7690
SYSSDDATABUFFER_12	EQU	7691
SYSSDDATABUFFER_13	EQU	7692
SYSSDDATABUFFER_14	EQU	7693
SYSSDDATABUFFER_15	EQU	7694
SYSSDDATABUFFER_16	EQU	7695
SYSSDDATABUFFER_36	EQU	7715
SYSSDDATABUFFER_37	EQU	7716
SYSSDDATABUFFER_38	EQU	7717
SYSSDDATABUFFER_39	EQU	7718
SYSSDDATABUFFER_42	EQU	7721
SYSSDDATABUFFER_43	EQU	7722
SYSSDDATABUFFER_50	EQU	7729
SYSSDDATABUFFER_71	EQU	7750
SYSSDDATABUFFER_82	EQU	7761
SYSSTR_0	EQU	6111

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
	call	INITUSART
	call	INIT_EPD2IN13D

;Start of the main program
;''A demonstration program for Explicit-Paper.
;''-------------------------------------------------------------------------
;-------------------------------------------------------
;''This has been tested using the hardware and software SPI option.
;''*************************************************************************
;*******
;Chip Settings.
;#define clock_freq 64
;
;Generated by PIC PPS Tool for Great Cow Basic
;PPS Tool version: 0.0.5.25
;PinManager data: Not available (3)
;Generated for 18f25k42
;
;Template comment at the start of the config file
;
;#define PPSToolPart 18F45k42
;______________
;USART
;#define USART_BAUD_RATE 57600'9600
;#define USART_DELAY     5 ms
;#define USART_BLOCKING
;Set pin USART directions
;Dir portC.7 IN
	bsf	TRISC,7,ACCESS
;Dir portC.6 OUT
	bcf	TRISC,6,ACCESS
;******************************************************************************************************
;The following should be used   '#define EPD_EPD2in13D_HardwareSPI     'remove comment out if you want to use software SPI.
;#define EPD2in13D_HardwareSPI
;#define SPI_BAUD_RATE_REGISTER 7 '**********||||||****|||****|
;***************************************************************************
;***************************
;Setup the E-Paper
;#include <xpt2046.h>    'include per il touch driver di ili9341
;#define GLCD_TYPE GLCD_TYPE_EPD_EPD2in13D
;#define GLCD_EXTENDEDFONTSET1
;NONE GLCD_TYPE_EPD2in13D_LOWMEMORYx_GLCD_MODE def.==>'BuffWidth=2756,n_page=1
;#define GLCD_TYPE_EPD2in13D_LOWMEMORY1_GLCD_MODE ON  'BuffWidth=13,  n_page=212
;#define GLCD_TYPE_EPD2in13D_LOWMEMORY2_GLCD_MODE ON  'BuffWidth=104, n_page=26
;#define GLCD_TYPE_EPD2in13D_LOWMEMORY3_GLCD_MODE ON  'BuffWidth=208, n_page=13
;#define GLCD_TYPE_EPD2in13D_LOWMEMORY4_GLCD_MODE ON  'BuffWidth=1378,n_page=2
;Pin mappings for SPI - this GLCD driver supports Hardware SPI and Software SPI
;ERV These need to GLCD_DC ETC = was wrong naming convention
;#define GLCD_DC     portA.0   ' Data(hight)/ command(low) line
;#define GLCD_CS     portC.1   ' Chip select line (negate)
;#define GLCD_RESET  portD.2   ' Reset line       (negate)
;#define GLCD_DO     portC.5   ' GLCD MOSI connect to MCU SDO
;#define GLCD_SCK    portC.3   ' Clock Line
;#define GLCD_Busy   portC.0   ' Busy Line
;--------------*-----------------*------------------*-----------------*--
;Setup SD pins (sono presenti sia l'EPD2in13D card adapter che
;un HW SD Card Adapter chip)
;#define SD_Adaper_CS  portD.7   ' SD-Adapter select line
;#define SD_DO         portC.5   ' MOSI connect to MCU SDO
;#define SD_SCK        portC.3   ' Clock Line
;#define SD_DI         portC.4   ' MISO connect to MCU SDI
;Dir     SD_Adaper_CS  OUT
	bcf	TRISD,7,ACCESS
;Dir     SD_DO         OUT
	bcf	TRISC,5,ACCESS
;Dir     SD_SCK        OUT
	bcf	TRISC,3,ACCESS
;Dir     SD_DI         IN
	bsf	TRISC,4,ACCESS
;GLCDRotate ( Landscape_rev )     ' optionally you can rotate the screen.
;Dim Inf_Addr_Buff, SDBuff_ind  as word
;Dim Main_counter, Main_Counter1, Main_Counter2, Main_Counter3 as Word
;Dim Main_Ind, Main_Ind_trans as word
;Dim Main_MyString, Main_MyString1 as String
;******************************************************************************************************
;Main program
;HSerPrint CHR(12)           'Clear Serial terminal
	movlw	12
	banksel	SYSCHAR
	movwf	SYSCHAR,BANKED
	banksel	0
	call	FN_CHR
	movlw	low CHR
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high CHR
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
	banksel	0
	call	HSERPRINT716
;sertxd(1,"==============","E-Paper EPD2in13(D)",0):sertxd(0,"===================","==",0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable3
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable3
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable3
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable4
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable4
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable4
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM2
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
	clrf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable5
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable5
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable5
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable6
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable6
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable6
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM2
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;sertxd(1,"===================FontSize=", GLCDFontWidth,0):sertxd(0,"===================","==",0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable7
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable7
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable7
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysSTRINGAHandler_H,BANKED
	movff	GLCDFONTWIDTH,INPUTB
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD8
	clrf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable5
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable5
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable5
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable6
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable6
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable6
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM2
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;dim upperPage, lowerPage as Byte
;upperPage = 0
	banksel	UPPERPAGE
	clrf	UPPERPAGE,BANKED
;lowerPage = EPD_N_PAGE-1
	movlw	12
	movwf	LOWERPAGE,BANKED
;SET SD_Adaper_CS ON
	bsf	LATD,7,ACCESS
REQUEST
;sertxd(1,"CARD already ","initialized? s/n ",0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable8
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable8
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable8
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable9
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable9
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable9
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM2
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;HSerGetstring Main_MyString
	movlw	low MAIN_MYSTRING
	banksel	SYSHSERSTRINGHANDLER
	movwf	SysHSERSTRINGHandler,BANKED
	movlw	high MAIN_MYSTRING
	movwf	SysHSERSTRINGHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
	banksel	0
	call	HSERGETSTRING
;if Main_MyString<>"s" then
	lfsr	1,SYSTEMPARRAY
	movlw	low StringTable10
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable10
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable10
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	lfsr	0,MAIN_MYSTRING
	lfsr	1,SYSTEMPARRAY
	call	SysCompEqualString
	comf	SysByteTempX,F,ACCESS
	btfsc	SysByteTempX,0,ACCESS
;SDInitialize                      'Card Initialization
	call	SDINITIALIZE
;end if
;Partition_Entry_and_Relevant_Data 'Find Partition Entry and Partition Relevant Data
	call	PARTITION_ENTRY_AND_RELEVANT_DATA
CARD_OPERATION_ROOT
;Disk_Explorer(Cluster_Begin_LBA,"BOOT")  'Explore Directory and Files in BOOT
	movff	CLUSTER_BEGIN_LBA,ADDRESS_SECTOR
	movff	CLUSTER_BEGIN_LBA_H,ADDRESS_SECTOR_H
	movff	CLUSTER_BEGIN_LBA_U,ADDRESS_SECTOR_U
	movff	CLUSTER_BEGIN_LBA_E,ADDRESS_SECTOR_E
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable11
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable11
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable11
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSNAMEHANDLER
	movwf	SysNAMEHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysNAMEHandler_H,BANKED
	banksel	0
	call	DISK_EXPLORER
;SDLocation0=Cluster_Begin_LBA
	movff	CLUSTER_BEGIN_LBA,SDLOCATION0
	movff	CLUSTER_BEGIN_LBA_H,SDLOCATION0_H
	movff	CLUSTER_BEGIN_LBA_U,SDLOCATION0_U
	movff	CLUSTER_BEGIN_LBA_E,SDLOCATION0_E
CARD_OPERATION
;Draw_Line(1,25," ")
	movlw	1
	banksel	LINE_TYPE
	movwf	LINE_TYPE,BANKED
	movlw	25
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	call	DRAW_LINE
;sertxd(0," MENU: "," ",0)
	clrf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable13
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable13
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable13
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM2
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;sertxd(1,"     EXPLORE/EXECUTE: File or Directory"," ",0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable14
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable14
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable14
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM2
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;sertxd(1,"  I) Fn= execute"," File num n",0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable15
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable15
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable15
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable16
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable16
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable16
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM2
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;sertxd(1," II) Dn= Explore"," Directory num n",0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable17
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable17
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable17
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable18
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable18
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable18
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM2
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;sertxd(1," III)En= Run Gra","ph Example num n",0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable19
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable19
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable19
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable20
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable20
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable20
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM2
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;sertxd(1," VI) R = GO TO ROOT"," ",0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable21
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable21
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable21
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM2
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;Draw_Line(1,10," "):sertxd(0,"  Please give your choice"," ",0)
	movlw	1
	banksel	LINE_TYPE
	movwf	LINE_TYPE,BANKED
	movlw	10
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	call	DRAW_LINE
	clrf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable22
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable22
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable22
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM2
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;HSerGetstring Main_MyString
	movlw	low MAIN_MYSTRING
	banksel	SYSHSERSTRINGHANDLER
	movwf	SysHSERSTRINGHandler,BANKED
	movlw	high MAIN_MYSTRING
	movwf	SysHSERSTRINGHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
	banksel	0
	call	HSERGETSTRING
;if Main_MyString="R" or Main_MyString="r" then
	lfsr	1,SYSTEMPARRAY
	movlw	low StringTable23
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable23
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable23
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	lfsr	0,MAIN_MYSTRING
	lfsr	1,SYSTEMPARRAY
	call	SysCompEqualString
	movff	SysByteTempX,SysTemp1
	lfsr	1,SYSTEMPARRAY
	movlw	low StringTable24
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable24
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable24
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	lfsr	0,MAIN_MYSTRING
	lfsr	1,SYSTEMPARRAY
	call	SysCompEqualString
	banksel	SYSTEMP1
	movf	SysTemp1,W,BANKED
	iorwf	SysByteTempX,W,ACCESS
	movwf	SysTemp2,BANKED
	btfsc	SysTemp2,0,BANKED
;goto CARD_Operation_Root
	bra	CARD_OPERATION_ROOT
;End if
;if Left(Main_MyString,1)<> "D" then
	movlw	low MAIN_MYSTRING
	movwf	SysSYSINSTRINGHandler,BANKED
	movlw	high MAIN_MYSTRING
	movwf	SysSYSINSTRINGHandler_H,BANKED
	movlw	1
	movwf	SYSCHARCOUNT,BANKED
	banksel	0
	call	FN_LEFT
	lfsr	1,SYSTEMPARRAY
	movlw	low StringTable25
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable25
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable25
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	lfsr	0,LEFT
	lfsr	1,SYSTEMPARRAY
	call	SysCompEqualString
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF3
;if Left(Main_MyString,1)<> "F" then
	movlw	low MAIN_MYSTRING
	banksel	SYSSYSINSTRINGHANDLER
	movwf	SysSYSINSTRINGHandler,BANKED
	movlw	high MAIN_MYSTRING
	movwf	SysSYSINSTRINGHandler_H,BANKED
	movlw	1
	movwf	SYSCHARCOUNT,BANKED
	banksel	0
	call	FN_LEFT
	lfsr	1,SYSTEMPARRAY
	movlw	low StringTable26
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable26
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable26
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	lfsr	0,LEFT
	lfsr	1,SYSTEMPARRAY
	call	SysCompEqualString
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF5
;if Left(Main_MyString,1)<> "E" then
	movlw	low MAIN_MYSTRING
	banksel	SYSSYSINSTRINGHANDLER
	movwf	SysSYSINSTRINGHandler,BANKED
	movlw	high MAIN_MYSTRING
	movwf	SysSYSINSTRINGHandler_H,BANKED
	movlw	1
	movwf	SYSCHARCOUNT,BANKED
	banksel	0
	call	FN_LEFT
	lfsr	1,SYSTEMPARRAY
	movlw	low StringTable27
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable27
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable27
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	lfsr	0,LEFT
	lfsr	1,SYSTEMPARRAY
	call	SysCompEqualString
	comf	SysByteTempX,F,ACCESS
	btfsc	SysByteTempX,0,ACCESS
;goto CARD_Operation
	bra	CARD_OPERATION
;end if
;end if
ENDIF5
;end if
ENDIF3
;--------------------------------------
;SD_Counter=Val(Right(Main_MyString,Len(Main_MyString)-1))  'il numero può essere a più cifre!
	movlw	low MAIN_MYSTRING
	banksel	SYSSYSINSTRINGHANDLER
	movwf	SysSYSINSTRINGHandler,BANKED
	movlw	high MAIN_MYSTRING
	movwf	SysSYSINSTRINGHandler_H,BANKED
	movlw	low MAIN_MYSTRING
	movwf	SysLENTEMPHandler,BANKED
	movlw	high MAIN_MYSTRING
	movwf	SysLENTEMPHandler_H,BANKED
	banksel	0
	call	FN_LEN
	banksel	LEN
	decf	LEN,W,BANKED
	movwf	SYSCHARCOUNT,BANKED
	banksel	0
	call	FN_RIGHT
	movlw	low RIGHT
	banksel	SYSSYSINSTRINGHANDLER
	movwf	SysSYSINSTRINGHandler,BANKED
	movlw	high RIGHT
	movwf	SysSYSINSTRINGHandler_H,BANKED
	banksel	0
	call	FN_VAL
	movff	VAL,SD_COUNTER
	movff	VAL_H,SD_COUNTER_H
;if Left(Main_MyString,1)<>"E" then
	movlw	low MAIN_MYSTRING
	banksel	SYSSYSINSTRINGHANDLER
	movwf	SysSYSINSTRINGHandler,BANKED
	movlw	high MAIN_MYSTRING
	movwf	SysSYSINSTRINGHandler_H,BANKED
	movlw	1
	movwf	SYSCHARCOUNT,BANKED
	banksel	0
	call	FN_LEFT
	lfsr	1,SYSTEMPARRAY
	movlw	low StringTable27
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable27
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable27
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	lfsr	0,LEFT
	lfsr	1,SYSTEMPARRAY
	call	SysCompEqualString
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	goto	ELSE4_1
;if Left(Main_MyString,1)="D" then
	movlw	low MAIN_MYSTRING
	banksel	SYSSYSINSTRINGHANDLER
	movwf	SysSYSINSTRINGHandler,BANKED
	movlw	high MAIN_MYSTRING
	movwf	SysSYSINSTRINGHandler_H,BANKED
	movlw	1
	movwf	SYSCHARCOUNT,BANKED
	banksel	0
	call	FN_LEFT
	lfsr	1,SYSTEMPARRAY
	movlw	low StringTable25
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable25
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable25
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	lfsr	0,LEFT
	lfsr	1,SYSTEMPARRAY
	call	SysCompEqualString
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE6_1
;Record_Number=Dir_Record(SD_Counter)
	lfsr	0,DIR_RECORD
	banksel	SD_COUNTER
	movf	SD_COUNTER,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	SD_COUNTER_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movffl	INDF0,RECORD_NUMBER
;else
	bra	ENDIF6
ELSE6_1
;Record_Number=File_Record(SD_Counter)   'N. del record di info
	lfsr	0,FILE_RECORD
	banksel	SD_COUNTER
	movf	SD_COUNTER,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	SD_COUNTER_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movffl	INDF0,RECORD_NUMBER
;end if
ENDIF6
;IF VERBOSE="ON" then
	lfsr	1,SYSTEMPARRAY
	movlw	low StringTable28
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable28
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable28
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	lfsr	0,VERBOSE
	lfsr	1,SYSTEMPARRAY
	call	SysCompEqualString
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF7
;Draw_Line(2,20,"=")
	movlw	2
	banksel	LINE_TYPE
	movwf	LINE_TYPE,BANKED
	movlw	20
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable29
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable29
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable29
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	call	DRAW_LINE
;sertxd(1,"  The entry of the chosen File/Dir is  at Boot record n.",SDLocation,0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable30
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable30
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable30
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysSTRINGAHandler_H,BANKED
	movff	SDLOCATION,INPUTL
	movff	SDLOCATION_H,INPUTL_H
	movff	SDLOCATION_U,INPUTL_U
	movff	SDLOCATION_E,INPUTL_E
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD10
;Draw_Line(2,20,"=")
	movlw	2
	banksel	LINE_TYPE
	movwf	LINE_TYPE,BANKED
	movlw	20
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable29
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable29
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable29
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	call	DRAW_LINE
;end if
ENDIF7
;if Record_Number>15 then
	banksel	RECORD_NUMBER
	movf	RECORD_NUMBER,W,BANKED
	sublw	15
	btfsc	STATUS, C,ACCESS
	bra	ENDIF8
;SDLocation=SDLocation0+(Record_Number/16)
	movff	RECORD_NUMBER,SysBYTETempA
	movlw	16
	movwf	SysBYTETempB,ACCESS
	banksel	0
	call	SysDivSub
	movff	SysBYTETempA,SysTemp1
	banksel	SYSTEMP1
	movf	SysTemp1,W,BANKED
	addwf	SDLOCATION0,W,BANKED
	movwf	SDLOCATION,BANKED
	movlw	0
	addwfc	SDLOCATION0_H,W,BANKED
	movwf	SDLOCATION_H,BANKED
	movlw	0
	addwfc	SDLOCATION0_U,W,BANKED
	movwf	SDLOCATION_U,BANKED
	movlw	0
	addwfc	SDLOCATION0_E,W,BANKED
	movwf	SDLOCATION_E,BANKED
;SDRead_Block(SDLocation)              'Nuovo settore che contiene le info
	movff	SDLOCATION,BLOCK_START
	movff	SDLOCATION_H,BLOCK_START_H
	movff	SDLOCATION_U,BLOCK_START_U
	movff	SDLOCATION_E,BLOCK_START_E
	banksel	0
	call	SDREAD_BLOCK
;end if
ENDIF8
;SDByte=Record_number-(Record_Number/16)*16'N.record delle info nel nuovo settore
	movff	RECORD_NUMBER,SysBYTETempA
	movlw	16
	movwf	SysBYTETempB,ACCESS
	banksel	0
	call	SysDivSub
	movff	SysBYTETempA,SysTemp1
	banksel	SYSTEMP1
	movf	SysTemp1,W,BANKED
	mullw	16
	movf	PRODL,W,ACCESS
	subwf	RECORD_NUMBER,W,BANKED
	movwf	SDBYTE,BANKED
	clrf	SDBYTE_H,BANKED
	btfss	STATUS,C,ACCESS
	decf	SDBYTE_H,F,BANKED
;SDByte=SDByte*32                          'n. record dell'info del file
	movff	SDBYTE,SysWORDTempA
	movff	SDBYTE_H,SysWORDTempA_H
	movlw	32
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	call	SysMultSub16
	movff	SysWORDTempX,SDBYTE
	movff	SysWORDTempX_H,SDBYTE_H
;SDLocation=Record_number-(Record_Number/16)*16
	movff	RECORD_NUMBER,SysBYTETempA
	movlw	16
	movwf	SysBYTETempB,ACCESS
	call	SysDivSub
	movff	SysBYTETempA,SysTemp1
	banksel	SYSTEMP1
	movf	SysTemp1,W,BANKED
	mullw	16
	movf	PRODL,W,ACCESS
	subwf	RECORD_NUMBER,W,BANKED
	movwf	SDLOCATION,BANKED
	clrf	SDLOCATION_H,BANKED
	btfss	STATUS,C,ACCESS
	decf	SDLOCATION_H,F,BANKED
	clrf	SDLOCATION_U,BANKED
	clrf	SDLOCATION_E,BANKED
;SDLocation=SdLocation*32          'Nota:questo valore era in SDByte (di appoggio)
	movff	SDLOCATION,SysLONGTempA
	movff	SDLOCATION_H,SysLONGTempA_H
	movff	SDLOCATION_U,SysLONGTempA_U
	movff	SDLOCATION_E,SysLONGTempA_E
	movlw	32
	movwf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	banksel	0
	call	SysMultSub32
	movff	SysLONGTempX,SDLOCATION
	movff	SysLONGTempX_H,SDLOCATION_H
	movff	SysLONGTempX_U,SDLOCATION_U
	movff	SysLONGTempX_E,SDLOCATION_E
;B0=SDDataBuffer(SDLocation+26)    ' ma e stato mofidificato da SDWrite_Block
	lfsr	0,SDDATABUFFER
	banksel	SDLOCATION
	movf	SDLOCATION,W,BANKED
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp1,BANKED
	movf	SDLOCATION_H,W,BANKED
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movlw	26
	addwf	SysTemp1,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movffl	INDF0,B0
	clrf	B0_H,ACCESS
	clrf	B0_U,ACCESS
	clrf	B0_E,ACCESS
;B1=SDDataBuffer(SDLocation+27)
	lfsr	0,SDDATABUFFER
	movf	SDLOCATION,W,BANKED
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp1,BANKED
	movf	SDLOCATION_H,W,BANKED
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movlw	27
	addwf	SysTemp1,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movffl	INDF0,B1
	clrf	B1_H,ACCESS
	clrf	B1_U,ACCESS
	clrf	B1_E,ACCESS
;B2=SDDataBuffer(SDLocation+20)
	lfsr	0,SDDATABUFFER
	movf	SDLOCATION,W,BANKED
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp1,BANKED
	movf	SDLOCATION_H,W,BANKED
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movlw	20
	addwf	SysTemp1,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movffl	INDF0,B2
	clrf	B2_H,ACCESS
	clrf	B2_U,ACCESS
	clrf	B2_E,ACCESS
;B3=SDDataBuffer(SDLocation+21)
	lfsr	0,SDDATABUFFER
	movf	SDLOCATION,W,BANKED
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp1,BANKED
	movf	SDLOCATION_H,W,BANKED
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movlw	21
	addwf	SysTemp1,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movffl	INDF0,B3
	clrf	B3_H,ACCESS
	clrf	B3_U,ACCESS
	clrf	B3_E,ACCESS
;LSB_to_MSB(SDLocation)
	movff	SDLOCATION,OUTPUT
	movff	SDLOCATION_H,OUTPUT_H
	movff	SDLOCATION_U,OUTPUT_U
	movff	SDLOCATION_E,OUTPUT_E
	banksel	0
	call	LSB_TO_MSB
	movff	OUTPUT,SDLOCATION
	movff	OUTPUT_H,SDLOCATION_H
	movff	OUTPUT_U,SDLOCATION_U
	movff	OUTPUT_E,SDLOCATION_E
;B3=SDLocation
	movff	SDLOCATION,B3
	movff	SDLOCATION_H,B3_H
	movff	SDLOCATION_U,B3_U
	movff	SDLOCATION_E,B3_E
;SDLocation=Cluster_Begin_LBA+(SDLocation-2)*N_Sector_per_cluster'indirizzo LBA inizio del file
	movlw	2
	banksel	SDLOCATION
	subwf	SDLOCATION,W,BANKED
	movwf	SysTemp1,BANKED
	movlw	0
	subwfb	SDLOCATION_H,W,BANKED
	movwf	SysTemp1_H,BANKED
	movlw	0
	subwfb	SDLOCATION_U,W,BANKED
	movwf	SysTemp1_U,BANKED
	movlw	0
	subwfb	SDLOCATION_E,W,BANKED
	movwf	SysTemp1_E,BANKED
	movff	SysTemp1,SysLONGTempA
	movff	SysTemp1_H,SysLONGTempA_H
	movff	SysTemp1_U,SysLONGTempA_U
	movff	SysTemp1_E,SysLONGTempA_E
	movff	N_SECTOR_PER_CLUSTER,SysLONGTempB
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	banksel	0
	call	SysMultSub32
	movf	SysLONGTempX,W,ACCESS
	addwf	CLUSTER_BEGIN_LBA,W,ACCESS
	banksel	SDLOCATION
	movwf	SDLOCATION,BANKED
	movf	SysLONGTempX_H,W,ACCESS
	addwfc	CLUSTER_BEGIN_LBA_H,W,ACCESS
	movwf	SDLOCATION_H,BANKED
	movf	SysLONGTempX_U,W,ACCESS
	addwfc	CLUSTER_BEGIN_LBA_U,W,ACCESS
	movwf	SDLOCATION_U,BANKED
	movf	SysLONGTempX_E,W,ACCESS
	addwfc	CLUSTER_BEGIN_LBA_E,W,ACCESS
	movwf	SDLOCATION_E,BANKED
;IF VERBOSE="ON" then
	lfsr	1,SYSTEMPARRAY
	movlw	low StringTable28
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable28
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable28
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	lfsr	0,VERBOSE
	lfsr	1,SYSTEMPARRAY
	call	SysCompEqualString
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF9
;Draw_Line(2,20,"=")
	movlw	2
	banksel	LINE_TYPE
	movwf	LINE_TYPE,BANKED
	movlw	20
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable29
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable29
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable29
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	call	DRAW_LINE
;sertxd(1,"  The choosen File/Dir is at cluster n.=",B3,0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable31
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable31
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable31
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysSTRINGAHandler_H,BANKED
	movff	B3,INPUTL
	movff	B3_H,INPUTL_H
	movff	B3_U,INPUTL_U
	movff	B3_E,INPUTL_E
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD10
;sertxd(1,"  LBA Address of the chosen File/Dir=",SDLocation,0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable32
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable32
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable32
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysSTRINGAHandler_H,BANKED
	movff	SDLOCATION,INPUTL
	movff	SDLOCATION_H,INPUTL_H
	movff	SDLOCATION_U,INPUTL_U
	movff	SDLOCATION_E,INPUTL_E
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD10
;Draw_Line(2,20,"=")
	movlw	2
	banksel	LINE_TYPE
	movwf	LINE_TYPE,BANKED
	movlw	20
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable29
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable29
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable29
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	call	DRAW_LINE
;End if
ENDIF9
;if Left(Main_MyString,1)="D" then
	movlw	low MAIN_MYSTRING
	banksel	SYSSYSINSTRINGHANDLER
	movwf	SysSYSINSTRINGHandler,BANKED
	movlw	high MAIN_MYSTRING
	movwf	SysSYSINSTRINGHandler_H,BANKED
	movlw	1
	movwf	SYSCHARCOUNT,BANKED
	banksel	0
	call	FN_LEFT
	lfsr	1,SYSTEMPARRAY
	movlw	low StringTable25
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable25
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable25
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	lfsr	0,LEFT
	lfsr	1,SYSTEMPARRAY
	call	SysCompEqualString
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE10_1
;SDLocation0=SDLocation
	movff	SDLOCATION,SDLOCATION0
	movff	SDLOCATION_H,SDLOCATION0_H
	movff	SDLOCATION_U,SDLOCATION0_U
	movff	SDLOCATION_E,SDLOCATION0_E
;Disk_Explorer(SDLocation,Left(Main_MyString,SD_Counter1-1))
	movff	SDLOCATION,ADDRESS_SECTOR
	movff	SDLOCATION_H,ADDRESS_SECTOR_H
	movff	SDLOCATION_U,ADDRESS_SECTOR_U
	movff	SDLOCATION_E,ADDRESS_SECTOR_E
	movlw	low MAIN_MYSTRING
	banksel	SYSSYSINSTRINGHANDLER
	movwf	SysSYSINSTRINGHandler,BANKED
	movlw	high MAIN_MYSTRING
	movwf	SysSYSINSTRINGHandler_H,BANKED
	decf	SD_COUNTER1,W,BANKED
	movwf	SYSCHARCOUNT,BANKED
	banksel	0
	call	FN_LEFT
	movlw	low LEFT
	banksel	SYSNAMEHANDLER
	movwf	SysNAMEHandler,BANKED
	movlw	high LEFT
	movwf	SysNAMEHandler_H,BANKED
	banksel	0
	call	DISK_EXPLORER
;goto CARD_Operation
	goto	CARD_OPERATION
;else
	bra	ENDIF10
ELSE10_1
;Draw_Line(1,15," "):Draw_Line(1,60,"-")
	movlw	1
	banksel	LINE_TYPE
	movwf	LINE_TYPE,BANKED
	movlw	15
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	call	DRAW_LINE
	movlw	1
	banksel	LINE_TYPE
	movwf	LINE_TYPE,BANKED
	movlw	60
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable33
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable33
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable33
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	call	DRAW_LINE
;Draw_Line(1,15," "):sertxd(0,"A .bin File is assumed"," in the following",0)
	movlw	1
	banksel	LINE_TYPE
	movwf	LINE_TYPE,BANKED
	movlw	15
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	call	DRAW_LINE
	clrf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable34
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable34
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable34
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable35
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable35
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable35
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM2
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;Draw_Line(1,60,"-"):Draw_Line(1,15," ")
	movlw	1
	banksel	LINE_TYPE
	movwf	LINE_TYPE,BANKED
	movlw	60
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable33
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable33
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable33
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	call	DRAW_LINE
	movlw	1
	banksel	LINE_TYPE
	movwf	LINE_TYPE,BANKED
	movlw	15
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	call	DRAW_LINE
;SDLocation_header=SDLocation
	movff	SDLOCATION,SDLOCATION_HEADER
	movff	SDLOCATION_H,SDLOCATION_HEADER_H
	movff	SDLOCATION_U,SDLOCATION_HEADER_U
	movff	SDLOCATION_E,SDLOCATION_HEADER_E
;sertxd(1,"  ===MAKING THE PICTURE"," ",1)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable36
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable36
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable36
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM2
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM2
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM2
	movwf	SysINPUTSHandler_H,BANKED
	movlw	1
	movwf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;GLCD_Open_PageTransaction ( upperPage, lowerPage )
;Macro Source: epd_epd2in13d.h (939)
;dim _GLCDPage as byte
;dim _GLCDPagesL, _GLCDPagesH as byte
;Clear_buffer_EPD2in13D
	call	CLEAR_BUFFER_EPD2IN13D
;for _GLCDPage = _GLCDPagesL to _GLCDPagesH    '_GLCDPage is a global variable - DO NOT CHANGE!!!
	banksel	UPPERPAGE
	decf	UPPERPAGE,W,BANKED
	banksel	_GLCDPAGE
	movwf	_GLCDPAGE,BANKED
	banksel	UPPERPAGE
	movf	UPPERPAGE,W,BANKED
	subwf	LOWERPAGE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd1
SysForLoop1
	banksel	_GLCDPAGE
	incf	_GLCDPAGE,F,BANKED
;GLCDLocateString 0,0
	banksel	PRINTLOCX
	clrf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	clrf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	banksel	0
	call	GLCDLOCATESTRING
;SET GLCD_CS ON
	bsf	LATC,1,ACCESS
;SET SD_Adaper_CS OFF
	bcf	LATD,7,ACCESS
;wait 2 ms
	movlw	2
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;SDLocation=SDLocation_header
	movff	SDLOCATION_HEADER,SDLOCATION
	movff	SDLOCATION_HEADER_H,SDLOCATION_H
	movff	SDLOCATION_HEADER_U,SDLOCATION_U
	movff	SDLOCATION_HEADER_E,SDLOCATION_E
;SDRead_Block(SDLocation)        'indirizzo in byte dell'header del file della immagine
	movff	SDLOCATION,BLOCK_START
	movff	SDLOCATION_H,BLOCK_START_H
	movff	SDLOCATION_U,BLOCK_START_U
	movff	SDLOCATION_E,BLOCK_START_E
	call	SDREAD_BLOCK
;Inf_Addr_Buff=_GLCDPage*BuffWidth
	movff	_GLCDPAGE,SysWORDTempA
	clrf	SysWORDTempA_H,ACCESS
	movlw	212
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysMultSub16
	movff	SysWORDTempX,INF_ADDR_BUFF
	movff	SysWORDTempX_H,INF_ADDR_BUFF_H
;Main_Ind=0
	banksel	MAIN_IND
	clrf	MAIN_IND,BANKED
	clrf	MAIN_IND_H,BANKED
;SDBuff_Ind=0
	clrf	SDBUFF_IND,BANKED
	clrf	SDBUFF_IND_H,BANKED
;for SD_Counter2=1 to GLCD_Height
	clrf	SD_COUNTER2,BANKED
	clrf	SD_COUNTER2_H,BANKED
SysForLoop2
	banksel	SD_COUNTER2
	incf	SD_COUNTER2,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	SD_COUNTER2_H,F,BANKED
;for SD_Counter3=1 to GLCD_Width8
	clrf	SD_COUNTER3,BANKED
	clrf	SD_COUNTER3_H,BANKED
SysForLoop3
	banksel	SD_COUNTER3
	incf	SD_COUNTER3,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	SD_COUNTER3_H,F,BANKED
;Main_Ind=Main_Ind+1           'allo 0 del SDData_Buffer corrisponde 1 EPDBuffer
	incf	MAIN_IND,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	MAIN_IND_H,F,BANKED
;if SDBuff_Ind>511 then
	movff	SDBUFF_IND,SysWORDTempB
	movff	SDBUFF_IND_H,SysWORDTempB_H
	setf	SysWORDTempA,ACCESS
	movlw	1
	movwf	SysWORDTempA_H,ACCESS
	banksel	0
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF15
;SDLocation=SDlocation+1
	banksel	SDLOCATION
	incf	SDLOCATION,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	SDLOCATION_H,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	SDLOCATION_U,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	SDLOCATION_E,F,BANKED
;SDRead_Block(SDLocation)
	movff	SDLOCATION,BLOCK_START
	movff	SDLOCATION_H,BLOCK_START_H
	movff	SDLOCATION_U,BLOCK_START_U
	movff	SDLOCATION_E,BLOCK_START_E
	banksel	0
	call	SDREAD_BLOCK
;SDBuff_ind=0
	banksel	SDBUFF_IND
	clrf	SDBUFF_IND,BANKED
	clrf	SDBUFF_IND_H,BANKED
;end if
ENDIF15
;Main_Ind_trans=Main_Ind-Inf_Addr_Buff
	banksel	INF_ADDR_BUFF
	movf	INF_ADDR_BUFF,W,BANKED
	subwf	MAIN_IND,W,BANKED
	movwf	MAIN_IND_TRANS,BANKED
	movf	INF_ADDR_BUFF_H,W,BANKED
	subwfb	MAIN_IND_H,W,BANKED
	movwf	MAIN_IND_TRANS_H,BANKED
;if Main_Ind_trans<=BuffWidth then
	movff	MAIN_IND_TRANS,SysWORDTempB
	movff	MAIN_IND_TRANS_H,SysWORDTempB_H
	movlw	212
	movwf	SysWORDTempA,ACCESS
	clrf	SysWORDTempA_H,ACCESS
	banksel	0
	call	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF16
;EPD_Buffer(Main_Ind_trans)=SDDataBuffer(SDBuff_Ind)
	lfsr	0,SDDATABUFFER
	banksel	SDBUFF_IND
	movf	SDBUFF_IND,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	SDBUFF_IND_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movffl	POSTINC0,SysArrayTemp2
	movff	SysArrayTemp2,SysArrayTemp1
	lfsr	0,EPD_BUFFER
	movf	MAIN_IND_TRANS,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	MAIN_IND_TRANS_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movffl	SysArrayTemp1,POSTINC0
;end if
ENDIF16
;SDBuff_Ind=SDBuff_Ind+1
	banksel	SDBUFF_IND
	incf	SDBUFF_IND,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	SDBUFF_IND_H,F,BANKED
;next
	movff	SD_COUNTER3,SysWORDTempA
	movff	SD_COUNTER3_H,SysWORDTempA_H
	movlw	13
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop3
SysForLoopEnd3
;next
	movff	SD_COUNTER2,SysWORDTempA
	movff	SD_COUNTER2_H,SysWORDTempA_H
	movlw	212
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop2
SysForLoopEnd2
;SET GLCD_CS OFF
	bcf	LATC,1,ACCESS
;SET SD_Adaper_CS ON
	bsf	LATD,7,ACCESS
;wait 2 ms
	movlw	2
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;GLCD_Close_PageTransaction                 'Close Transaction
;Macro Source: epd_epd2in13d.h (952)
;Pixel_To_Display_EPD2in13D
	call	PIXEL_TO_DISPLAY_EPD2IN13D
;next
	banksel	LOWERPAGE
	movf	LOWERPAGE,W,BANKED
	banksel	_GLCDPAGE
	subwf	_GLCDPAGE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop1
SysForLoopEnd1
;SendCommand_EPD2in13D(DISPLAY_REFRESH)
	movlw	18
	banksel	EPD2IN13D_COMMAND
	movwf	EPD2IN13D_COMMAND,BANKED
	call	SENDCOMMAND_EPD2IN13D
;Draw_Line(1,15," "):Draw_Line(1,15," ")
	movlw	1
	banksel	LINE_TYPE
	movwf	LINE_TYPE,BANKED
	movlw	15
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	call	DRAW_LINE
	movlw	1
	banksel	LINE_TYPE
	movwf	LINE_TYPE,BANKED
	movlw	15
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	call	DRAW_LINE
;end if
ENDIF10
;else
	bra	ENDIF4
ELSE4_1
;SET SD_Adaper_CS ON
	bsf	LATD,7,ACCESS
;GLCD_Open_PageTransaction ( upperPage, lowerPage )
;Macro Source: epd_epd2in13d.h (939)
;dim _GLCDPage as byte
;dim _GLCDPagesL, _GLCDPagesH as byte
;Clear_buffer_EPD2in13D
	call	CLEAR_BUFFER_EPD2IN13D
;for _GLCDPage = _GLCDPagesL to _GLCDPagesH    '_GLCDPage is a global variable - DO NOT CHANGE!!!
	banksel	UPPERPAGE
	decf	UPPERPAGE,W,BANKED
	banksel	_GLCDPAGE
	movwf	_GLCDPAGE,BANKED
	banksel	UPPERPAGE
	movf	UPPERPAGE,W,BANKED
	subwf	LOWERPAGE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd4
SysForLoop4
	banksel	_GLCDPAGE
	incf	_GLCDPAGE,F,BANKED
;GLCDLocateString 0,0
	banksel	PRINTLOCX
	clrf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
	clrf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
	banksel	0
	call	GLCDLOCATESTRING
;select case SD_Counter
;case 1   :   Box_example
SysSelect1Case1
	movff	SD_COUNTER,SysWORDTempA
	movff	SD_COUNTER_H,SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect1Case2
	rcall	BOX_EXAMPLE
;case 2   :   String_example
	bra	SysSelectEnd1
SysSelect1Case2
	movff	SD_COUNTER,SysWORDTempA
	movff	SD_COUNTER_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect1Case3
	call	STRING_EXAMPLE
;case 3   :   BigString_example
	bra	SysSelectEnd1
SysSelect1Case3
	movff	SD_COUNTER,SysWORDTempA
	movff	SD_COUNTER_H,SysWORDTempA_H
	movlw	3
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect1Case4
	rcall	BIGSTRING_EXAMPLE
;case 4   :   PrintString_example
	bra	SysSelectEnd1
SysSelect1Case4
	movff	SD_COUNTER,SysWORDTempA
	movff	SD_COUNTER_H,SysWORDTempA_H
	movlw	4
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect1Case5
	call	PRINTSTRING_EXAMPLE
;case 5   :   Complex_Graph_example
	bra	SysSelectEnd1
SysSelect1Case5
	movff	SD_COUNTER,SysWORDTempA
	movff	SD_COUNTER_H,SysWORDTempA_H
	movlw	5
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelectEnd1
	call	COMPLEX_GRAPH_EXAMPLE
;end select
SysSelectEnd1
;GLCD_Close_PageTransaction                 'Close Transaction
;Macro Source: epd_epd2in13d.h (952)
;Pixel_To_Display_EPD2in13D
	call	PIXEL_TO_DISPLAY_EPD2IN13D
;next
	banksel	LOWERPAGE
	movf	LOWERPAGE,W,BANKED
	banksel	_GLCDPAGE
	subwf	_GLCDPAGE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop4
SysForLoopEnd4
;SendCommand_EPD2in13D(DISPLAY_REFRESH)
	movlw	18
	banksel	EPD2IN13D_COMMAND
	movwf	EPD2IN13D_COMMAND,BANKED
	call	SENDCOMMAND_EPD2IN13D
;Draw_Line(1,15," "):Draw_Line(1,15," ")
	movlw	1
	banksel	LINE_TYPE
	movwf	LINE_TYPE,BANKED
	movlw	15
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	call	DRAW_LINE
	movlw	1
	banksel	LINE_TYPE
	movwf	LINE_TYPE,BANKED
	movlw	15
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM1
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM1
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM1
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	call	DRAW_LINE
;end if
ENDIF4
;goto CARD_Operation_Root
	goto	CARD_OPERATION_ROOT
;end
	bra	BASPROGRAMEND
;____________________________________________________________________________________
BASPROGRAMEND
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

;Source: E_paper-18F47K42_SD_SDLIB_Transaction.gcb (295)
BIGSTRING_EXAMPLE
	return

;********************************************************************************

;Source: glcd.h (1355)
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
	bra	ENDIF29
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
ENDIF29
;If LineY1 > LineY2 Then
	movff	LINEY1,SysWORDTempB
	movff	LINEY1_H,SysWORDTempB_H
	movff	LINEY2,SysWORDTempA
	movff	LINEY2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF30
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
ENDIF30
;dim DrawLine as word
;Draw lines going across
;For DrawLine = LineX1 To LineX2
	movlw	1
	banksel	LINEX1
	subwf	LINEX1,W,BANKED
	banksel	DRAWLINE
	movwf	DRAWLINE,BANKED
	movlw	0
	banksel	LINEX1_H
	subwfb	LINEX1_H,W,BANKED
	banksel	DRAWLINE_H
	movwf	DRAWLINE_H,BANKED
	movff	LINEX1,SysWORDTempB
	movff	LINEX1_H,SysWORDTempB_H
	movff	LINEX2,SysWORDTempA
	movff	LINEX2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd6
SysForLoop6
	incf	DRAWLINE,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	DRAWLINE_H,F,BANKED
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
	bra	SysForLoop6
SysForLoopEnd6
;Draw lines going down
;For DrawLine = LineY1 To LineY2
	movlw	1
	banksel	LINEY1
	subwf	LINEY1,W,BANKED
	banksel	DRAWLINE
	movwf	DRAWLINE,BANKED
	movlw	0
	banksel	LINEY1_H
	subwfb	LINEY1_H,W,BANKED
	banksel	DRAWLINE_H
	movwf	DRAWLINE_H,BANKED
	movff	LINEY1,SysWORDTempB
	movff	LINEY1_H,SysWORDTempB_H
	movff	LINEY2,SysWORDTempA
	movff	LINEY2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd7
SysForLoop7
	incf	DRAWLINE,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	DRAWLINE_H,F,BANKED
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
	bra	SysForLoop7
SysForLoopEnd7
	return

;********************************************************************************

;Source: E_paper-18F47K42_SD_SDLIB_Transaction.gcb (269)
BOX_EXAMPLE
;box 10, 10,GLCD_WIDTH-10, GLCD_HEIGHT-10
	movlw	10
	banksel	LINEX1
	movwf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	10
	movwf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	94
	movwf	LINEX2,BANKED
	clrf	LINEX2_H,BANKED
	movlw	202
	movwf	LINEY2,BANKED
	clrf	LINEY2_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	rcall	BOX
;box 20, 20,GLCD_WIDTH-20, GLCD_HEIGHT-20
	movlw	20
	banksel	LINEX1
	movwf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	20
	movwf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	84
	movwf	LINEX2,BANKED
	clrf	LINEX2_H,BANKED
	movlw	192
	movwf	LINEY2,BANKED
	clrf	LINEY2_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	rcall	BOX
;box 30, 30,GLCD_WIDTH-30, GLCD_HEIGHT-30
	movlw	30
	banksel	LINEX1
	movwf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	30
	movwf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	74
	movwf	LINEX2,BANKED
	clrf	LINEX2_H,BANKED
	movlw	182
	movwf	LINEY2,BANKED
	clrf	LINEY2_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	rcall	BOX
;Filledbox 40, 40,GLCD_WIDTH-40, GLCD_HEIGHT-40
	movlw	40
	banksel	LINEX1
	movwf	LINEX1,BANKED
	clrf	LINEX1_H,BANKED
	movlw	40
	movwf	LINEY1,BANKED
	clrf	LINEY1_H,BANKED
	movlw	64
	movwf	LINEX2,BANKED
	clrf	LINEX2_H,BANKED
	movlw	172
	movwf	LINEY2,BANKED
	clrf	LINEY2_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	goto	FILLEDBOX_EPD2IN13D

;********************************************************************************

;Source: MySDLib.h (175)
CALLACMD41
;SD_Counter=0
	banksel	SD_COUNTER
	clrf	SD_COUNTER,BANKED
	clrf	SD_COUNTER_H,BANKED
;SD_Counter1=0
	clrf	SD_COUNTER1,BANKED
	clrf	SD_COUNTER1_H,BANKED
;repeat 1000'  do while SDResponse <> 0x00
	movlw	232
	movwf	SysRepeatTemp3,BANKED
	movlw	4
	movwf	SysRepeatTemp3_H,BANKED
SysRepeatLoop3
;SD_Counter=SD_Counter+1
	incf	SD_COUNTER,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	SD_COUNTER_H,F,BANKED
;SDResponse=100
	movlw	100
	movwf	SDRESPONSE,BANKED
;SDResponse2=100
	movlw	100
	movwf	SDRESPONSE2,BANKED
;SD_Counter1=1
	movlw	1
	movwf	SD_COUNTER1,BANKED
	clrf	SD_COUNTER1_H,BANKED
;SendCommand(0x77, 0x00000000, 0xFF)       'CMD55
	movlw	119
	movwf	CODE,ACCESS
	clrf	ARG,ACCESS
	clrf	ARG_H,ACCESS
	clrf	ARG_U,ACCESS
	clrf	ARG_E,ACCESS
	setf	CRC,ACCESS
	banksel	0
	call	SENDCOMMAND
;do until SDResponse2<2 or SD_Counter1 > 100
SysDoLoop_S12
	movff	sdresponse2,SysBYTETempA
	movlw	2
	movwf	SysBYTETempB,ACCESS
	banksel	0
	call	SysCompLessThan
	movff	SysByteTempX,SysTemp3
	movff	sd_counter1,SysWORDTempB
	movff	sd_counter1_H,SysWORDTempB_H
	movlw	100
	movwf	SysWORDTempA,ACCESS
	clrf	SysWORDTempA_H,ACCESS
	call	SysCompLessThan16
	banksel	SYSTEMP3
	movf	SysTemp3,W,BANKED
	iorwf	SysByteTempX,W,ACCESS
	movwf	SysTemp1,BANKED
	btfsc	SysTemp1,0,BANKED
	bra	SysDoLoop_E12
;GetSDResponse(1,SDResponse2)
	movlw	1
	movwf	NRESPONSE,BANKED
	movff	SDRESPONSE2,SDRESP
	banksel	0
	call	GETSDRESPONSE
	movff	SDRESP,SDRESPONSE2
;SD_Counter1=SD_Counter1+1
	banksel	SD_COUNTER1
	incf	SD_COUNTER1,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	SD_COUNTER1_H,F,BANKED
;loop
	bra	SysDoLoop_S12
SysDoLoop_E12
;SD_Counter1=1
	movlw	1
	movwf	SD_COUNTER1,BANKED
	clrf	SD_COUNTER1_H,BANKED
;SendCommand(0x69, 0x40000000, 0xFF)       'CMD41
	movlw	105
	movwf	CODE,ACCESS
	clrf	ARG,ACCESS
	clrf	ARG_H,ACCESS
	clrf	ARG_U,ACCESS
	movlw	64
	movwf	ARG_E,ACCESS
	setf	CRC,ACCESS
	banksel	0
	call	SENDCOMMAND
;do until SDResponse<2 or SD_Counter1 > 100
SysDoLoop_S13
	movff	sdresponse,SysBYTETempA
	movlw	2
	movwf	SysBYTETempB,ACCESS
	banksel	0
	call	SysCompLessThan
	movff	SysByteTempX,SysTemp3
	movff	sd_counter1,SysWORDTempB
	movff	sd_counter1_H,SysWORDTempB_H
	movlw	100
	movwf	SysWORDTempA,ACCESS
	clrf	SysWORDTempA_H,ACCESS
	call	SysCompLessThan16
	banksel	SYSTEMP3
	movf	SysTemp3,W,BANKED
	iorwf	SysByteTempX,W,ACCESS
	movwf	SysTemp1,BANKED
	btfsc	SysTemp1,0,BANKED
	bra	SysDoLoop_E13
;GetSDResponse(1,SDResponse)
	movlw	1
	movwf	NRESPONSE,BANKED
	movff	SDRESPONSE,SDRESP
	banksel	0
	call	GETSDRESPONSE
	movff	SDRESP,SDRESPONSE
;SD_Counter1=SD_Counter1+1
	banksel	SD_COUNTER1
	incf	SD_COUNTER1,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	SD_COUNTER1_H,F,BANKED
;loop
	bra	SysDoLoop_S13
SysDoLoop_E13
;set SD_Adaper_CS ON
;if SDResponse=0  then
	movf	SDRESPONSE,F,BANKED
	btfsc	STATUS, Z,ACCESS
;exit repeat
	bra	SysRepeatLoopEnd3
;end if
;end repeat
	decfsz	SysRepeatTemp3,F,BANKED
	bra	SysRepeatLoop3
	decfsz	SysRepeatTemp3_H,F,BANKED
	bra	SysRepeatLoop3
SysRepeatLoopEnd3
;sertxd(1,"-ACMD41 ","Executed.",0):sertxd(0," after ",SD_Counter,0):sertxd(0," attempts","   ",0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM5
	movlw	low StringTable104
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable104
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable104
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM5
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM5
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable105
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable105
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable105
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
	clrf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM5
	movlw	low StringTable106
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable106
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable106
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM5
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM5
	movwf	SysSTRINGAHandler_H,BANKED
	movff	SD_COUNTER,INPUTW
	movff	SD_COUNTER_H,INPUTW_H
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD9
	clrf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM5
	movlw	low StringTable107
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable107
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable107
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM5
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM5
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable94
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable94
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable94
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;sertxd(1,"        CMD41 Response=",SDResponse,0):sertxd(0," CMD55 Response=",SDResponse2,0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM5
	movlw	low StringTable108
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable108
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable108
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM5
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM5
	movwf	SysSTRINGAHandler_H,BANKED
	movff	SDRESPONSE,INPUTB
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD8
	clrf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM5
	movlw	low StringTable109
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable109
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable109
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM5
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM5
	movwf	SysSTRINGAHandler_H,BANKED
	movff	SDRESPONSE2,INPUTB
	clrf	CRLF2,ACCESS
	banksel	0
	goto	SERTXD8

;********************************************************************************

;Source: MySDLib.h (113)
CALLCMD0
;SET SD_Adaper_CS OFF
	bcf	LATD,7,ACCESS
;wait 500 ms
	movlw	244
	movwf	SysWaitTempMS,ACCESS
	movlw	1
	movwf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;SET SD_Adaper_CS ON
	bsf	LATD,7,ACCESS
;sembra necessario
;do while SDResponse <> 0x01
SysDoLoop_S9
	banksel	SDRESPONSE
	decf	SDRESPONSE,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysDoLoop_E9
;SD_Counter=0
	clrf	SD_COUNTER,BANKED
	clrf	SD_COUNTER_H,BANKED
;SET SD_Adaper_CS ON
	bsf	LATD,7,ACCESS
;SendDummyBytes (10)         'lascia SD_Adaper_CS Off
	movlw	10
	movwf	N_BYTES,BANKED
	banksel	0
	call	SENDDUMMYBYTES
;wait 50 ms
	movlw	50
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;HserPrint "[]"
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable81
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable81
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable81
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
	banksel	0
	call	HSERPRINT716
;SendCommand(0x40, 0x00000000, 0x95)
	movlw	64
	movwf	CODE,ACCESS
	clrf	ARG,ACCESS
	clrf	ARG_H,ACCESS
	clrf	ARG_U,ACCESS
	clrf	ARG_E,ACCESS
	movlw	149
	movwf	CRC,ACCESS
	call	SENDCOMMAND
;do while SDResponse <> 0x01 and SD_Counter<50
SysDoLoop_S10
	movff	sdresponse,SysBYTETempA
	movlw	1
	movwf	SysBYTETempB,ACCESS
	call	SysCompEqual
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp3
	movff	sd_counter,SysWORDTempA
	movff	sd_counter_H,SysWORDTempA_H
	movlw	50
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	banksel	SYSTEMP3
	movf	SysTemp3,W,BANKED
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp1,BANKED
	btfss	SysTemp1,0,BANKED
	bra	SysDoLoop_E10
;GetSDResponse(1,SDResponse)
	movlw	1
	movwf	NRESPONSE,BANKED
	movff	SDRESPONSE,SDRESP
	banksel	0
	call	GETSDRESPONSE
	movff	SDRESP,SDRESPONSE
;Loop
	bra	SysDoLoop_S10
SysDoLoop_E10
;HSerprint "??"
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable82
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable82
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable82
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
	banksel	0
	call	HSERPRINT716
;Loop
	bra	SysDoLoop_S9
SysDoLoop_E9
;SET SD_Adaper_CS ON
	bsf	LATD,7,ACCESS
;sertxd(1,"-CMD0 ","  Executed",0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable83
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable83
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable83
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM5
	movlw	low StringTable84
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable84
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable84
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM5
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM5
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	goto	SERTXD7

;********************************************************************************

;Source: MySDLib.h (310)
CALLCMD16
;SDResponse=100                  'Block size setting
	movlw	100
	banksel	SDRESPONSE
	movwf	SDRESPONSE,BANKED
;SD_Counter=0
	clrf	SD_COUNTER,BANKED
	clrf	SD_COUNTER_H,BANKED
;repeat 100
	movlw	100
	movwf	SysRepeatTemp10,BANKED
SysRepeatLoop10
;SD_Counter=SD_Counter+1
	incf	SD_COUNTER,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	SD_COUNTER_H,F,BANKED
;SD_Counter1=0
	clrf	SD_COUNTER1,BANKED
	clrf	SD_COUNTER1_H,BANKED
;sendCommand(0x51,512,0xFF)
	movlw	81
	movwf	CODE,ACCESS
	clrf	ARG,ACCESS
	movlw	2
	movwf	ARG_H,ACCESS
	clrf	ARG_U,ACCESS
	clrf	ARG_E,ACCESS
	setf	CRC,ACCESS
	banksel	0
	call	SENDCOMMAND
;do until SDResponse=0 or SD_Counter1 > 100
SysDoLoop_S14
	movff	sdresponse,SysBYTETempA
	clrf	SysBYTETempB,ACCESS
	banksel	0
	call	SysCompEqual
	movff	SysByteTempX,SysTemp3
	movff	sd_counter1,SysWORDTempB
	movff	sd_counter1_H,SysWORDTempB_H
	movlw	100
	movwf	SysWORDTempA,ACCESS
	clrf	SysWORDTempA_H,ACCESS
	call	SysCompLessThan16
	banksel	SYSTEMP3
	movf	SysTemp3,W,BANKED
	iorwf	SysByteTempX,W,ACCESS
	movwf	SysTemp1,BANKED
	btfsc	SysTemp1,0,BANKED
	bra	SysDoLoop_E14
;GetSDResponse(1,SDResponse)
	movlw	1
	movwf	NRESPONSE,BANKED
	movff	SDRESPONSE,SDRESP
	banksel	0
	call	GETSDRESPONSE
	movff	SDRESP,SDRESPONSE
;SD_Counter1=SD_Counter1+1
	banksel	SD_COUNTER1
	incf	SD_COUNTER1,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	SD_COUNTER1_H,F,BANKED
;loop
	bra	SysDoLoop_S14
SysDoLoop_E14
;if SDResponse=0 then
	movf	SDRESPONSE,F,BANKED
	btfsc	STATUS, Z,ACCESS
;exit repeat
	bra	SysRepeatLoopEnd10
;end if
;End Repeat
	decfsz	SysRepeatTemp10,F,BANKED
	bra	SysRepeatLoop10
SysRepeatLoopEnd10
;if SDResponse=0 then
	movf	SDRESPONSE,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE110_1
;sertxd(1,"-CMD16  Successfully  Executed","  ",0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM5
	movlw	low StringTable128
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable128
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable128
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM5
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM5
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable129
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable129
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable129
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;else
	bra	ENDIF110
ELSE110_1
;sertxd(1,"-CMD16  UNSUCCESSFULLY Executed","  ",0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM5
	movlw	low StringTable130
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable130
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable130
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM5
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM5
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable129
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable129
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable129
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;end if
ENDIF110
;sertxd(0,"       Response=",SDResponse,0):sertxd(0,", SD_Counter=",SD_Counter,0)
	clrf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM5
	movlw	low StringTable131
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable131
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable131
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM5
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM5
	movwf	SysSTRINGAHandler_H,BANKED
	movff	SDRESPONSE,INPUTB
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD8
	clrf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM5
	movlw	low StringTable132
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable132
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable132
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM5
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM5
	movwf	SysSTRINGAHandler_H,BANKED
	movff	SD_COUNTER,INPUTW
	movff	SD_COUNTER_H,INPUTW_H
	clrf	CRLF2,ACCESS
	banksel	0
	goto	SERTXD9

;********************************************************************************

;Source: MySDLib.h (205)
CALLCMD58
;INITSucc=0
	banksel	INITSUCC
	clrf	INITSUCC,BANKED
;SDResponse=100
	movlw	100
	movwf	SDRESPONSE,BANKED
;SDResponse2=100
;SDResponse3=100
;SD_Counter=0
	clrf	SD_COUNTER,BANKED
	clrf	SD_COUNTER_H,BANKED
;repeat 1000
	movlw	232
	movwf	SysRepeatTemp4,BANKED
	movlw	4
	movwf	SysRepeatTemp4_H,BANKED
SysRepeatLoop4
;SD_Counter=SD_Counter+1
	incf	SD_COUNTER,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	SD_COUNTER_H,F,BANKED
;SendCommand(0x7A, 0x00000000, 0xFF) 'return R3 response
	movlw	122
	movwf	CODE,ACCESS
	clrf	ARG,ACCESS
	clrf	ARG_H,ACCESS
	clrf	ARG_U,ACCESS
	clrf	ARG_E,ACCESS
	setf	CRC,ACCESS
	banksel	0
	call	SENDCOMMAND
;repeat 50
	movlw	50
	banksel	SYSREPEATTEMP5
	movwf	SysRepeatTemp5,BANKED
SysRepeatLoop5
;GetSDResponse(1,SDResponse)
	movlw	1
	movwf	NRESPONSE,BANKED
	movff	SDRESPONSE,SDRESP
	banksel	0
	call	GETSDRESPONSE
	movff	SDRESP,SDRESPONSE
;if SDResponse=0 then
	banksel	SDRESPONSE
	movf	SDRESPONSE,F,BANKED
	btfsc	STATUS, Z,ACCESS
;exit repeat
	bra	SysRepeatLoopEnd5
;end if
;end repeat
	decfsz	SysRepeatTemp5,F,BANKED
	bra	SysRepeatLoop5
SysRepeatLoopEnd5
;repeat 50
	movlw	50
	movwf	SysRepeatTemp5,BANKED
SysRepeatLoop6
;GetSDResponse(1,SDResponse2)
	movlw	1
	movwf	NRESPONSE,BANKED
	movff	SDRESPONSE2,SDRESP
	banksel	0
	call	GETSDRESPONSE
	movff	SDRESP,SDRESPONSE2
;if SDResponse2<>255 then
	banksel	SDRESPONSE2
	incf	SDRESPONSE2,W,BANKED
	btfss	STATUS, Z,ACCESS
;exit repeat
	bra	SysRepeatLoopEnd6
;end if
;end repeat
	decfsz	SysRepeatTemp5,F,BANKED
	bra	SysRepeatLoop6
SysRepeatLoopEnd6
;repeat 50
	movlw	50
	movwf	SysRepeatTemp5,BANKED
SysRepeatLoop7
;GetSDResponse(1,SDResponse3)
	movlw	1
	movwf	NRESPONSE,BANKED
	movff	SDRESPONSE3,SDRESP
	banksel	0
	call	GETSDRESPONSE
	movff	SDRESP,SDRESPONSE3
;if SDResponse3<>255 then
	banksel	SDRESPONSE3
	incf	SDRESPONSE3,W,BANKED
	btfss	STATUS, Z,ACCESS
;exit repeat
	bra	SysRepeatLoopEnd7
;end if
;end repeat
	decfsz	SysRepeatTemp5,F,BANKED
	bra	SysRepeatLoop7
SysRepeatLoopEnd7
;repeat 50
	movlw	50
	movwf	SysRepeatTemp5,BANKED
SysRepeatLoop8
;GetSDResponse(1,SDResponse4)
	movlw	1
	movwf	NRESPONSE,BANKED
	movff	SDRESPONSE4,SDRESP
	banksel	0
	call	GETSDRESPONSE
	movff	SDRESP,SDRESPONSE4
;if SDResponse4<>255 then
	banksel	SDRESPONSE4
	incf	SDRESPONSE4,W,BANKED
	btfss	STATUS, Z,ACCESS
;exit repeat
	bra	SysRepeatLoopEnd8
;end if
;end repeat
	decfsz	SysRepeatTemp5,F,BANKED
	bra	SysRepeatLoop8
SysRepeatLoopEnd8
;repeat 50
	movlw	50
	movwf	SysRepeatTemp5,BANKED
SysRepeatLoop9
;GetSDResponse(1,SDResponse5)
	movlw	1
	movwf	NRESPONSE,BANKED
	movff	SDRESPONSE5,SDRESP
	banksel	0
	call	GETSDRESPONSE
	movff	SDRESP,SDRESPONSE5
;if SDResponse2<>255 then
	banksel	SDRESPONSE2
	incf	SDRESPONSE2,W,BANKED
	btfss	STATUS, Z,ACCESS
;exit repeat
	bra	SysRepeatLoopEnd9
;end if
;end repeat
	decfsz	SysRepeatTemp5,F,BANKED
	bra	SysRepeatLoop9
SysRepeatLoopEnd9
;if SDResponse=0 then
	movf	SDRESPONSE,F,BANKED
	btfsc	STATUS, Z,ACCESS
;exit repeat
	bra	SysRepeatLoopEnd4
;end if
;end repeat
	decfsz	SysRepeatTemp4,F,BANKED
	bra	SysRepeatLoop4
	decfsz	SysRepeatTemp4_H,F,BANKED
	bra	SysRepeatLoop4
SysRepeatLoopEnd4
;set SD_Adaper_CS ON
;if  SDResponse=0 then
	movf	SDRESPONSE,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE107_1
;INITSucc=1
	movlw	1
	movwf	INITSUCC,BANKED
;sertxd(1,"-CMD58 "," Executed successfully. ",0):sertxd(0,"Attempts number=",SD_SD_Counter,0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable110
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable110
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable110
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM5
	movlw	low StringTable111
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable111
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable111
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM5
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM5
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
	clrf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable112
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable112
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable112
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysSTRINGAHandler_H,BANKED
	movff	SD_SD_COUNTER,INPUTB
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD8
;sertxd(1,"        First SDResponse=",SDResponse,0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable113
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable113
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable113
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysSTRINGAHandler_H,BANKED
	movff	SDRESPONSE,INPUTB
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD8
;sertxd(1,"        SDResponses2-3-4-5=(",SDResponse2,0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable114
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable114
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable114
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysSTRINGAHandler_H,BANKED
	movff	SDRESPONSE2,INPUTB
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD8
;sertxd(0,",",SDResponse3,0):sertxd(0,",",SDResponse4,0):sertxd(0,",",SDResponse5,0):sertxd(0,")"," ",0)
	clrf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable115
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable115
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable115
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysSTRINGAHandler_H,BANKED
	movff	SDRESPONSE3,INPUTB
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD8
	clrf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable115
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable115
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable115
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysSTRINGAHandler_H,BANKED
	movff	SDRESPONSE4,INPUTB
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD8
	clrf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable115
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable115
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable115
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysSTRINGAHandler_H,BANKED
	movff	SDRESPONSE5,INPUTB
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD8
	clrf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable116
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable116
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable116
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM5
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM5
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM5
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;If SDResponse2.6=0 then       'uses byte address data (nota 10 pag 222)
	banksel	SDRESPONSE2
	btfsc	SDRESPONSE2,6,BANKED
	bra	ELSE108_1
;sertxd(1,"        The Card is V2 SDSC ","with Standard capacity (CCS=0)",0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable117
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable117
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable117
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM5
	movlw	low StringTable118
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable118
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable118
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM5
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM5
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;else                          'uses block address data
	bra	ENDIF108
ELSE108_1
;sertxd(1,"        The Card is V2 SCXC or"," SDHC with Extended capacity (CCS=1)",0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable119
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable119
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable119
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM5
	movlw	low StringTable120
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable120
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable120
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM5
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM5
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;end if
ENDIF108
;else
	bra	ENDIF107
ELSE107_1
;SET SD_Adaper_CS ON
	bsf	LATD,7,ACCESS
;sertxd(1,"-CMD58 "," Executed UNsuccessfully.",0):sertxd(0,"N. attempts=",SD_Counter,0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable110
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable110
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable110
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM5
	movlw	low StringTable121
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable121
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable121
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM5
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM5
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
	clrf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable122
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable122
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable122
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysSTRINGAHandler_H,BANKED
	movff	SD_COUNTER,INPUTW
	movff	SD_COUNTER_H,INPUTW_H
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD9
;sertxd(1,"-------------","----------------",0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable123
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable123
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable123
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM5
	movlw	low StringTable124
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable124
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable124
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM5
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM5
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;end if
ENDIF107
	return

;********************************************************************************

;Source: MySDLib.h (135)
CALLCMD8
;SDResponse=100
	movlw	100
	banksel	SDRESPONSE
	movwf	SDRESPONSE,BANKED
;Counter=0
	clrf	COUNTER,ACCESS
;do until SDResponse = 0x01 or SDResponse = 0x05 or SD_Counter >50
SysDoLoop_S11
	movff	sdresponse,SysBYTETempA
	movlw	1
	movwf	SysBYTETempB,ACCESS
	banksel	0
	call	SysCompEqual
	movff	SysByteTempX,SysTemp3
	movff	sdresponse,SysBYTETempA
	movlw	5
	movwf	SysBYTETempB,ACCESS
	call	SysCompEqual
	movff	SysByteTempX,SysTemp1
	movff	sd_counter,SysWORDTempB
	movff	sd_counter_H,SysWORDTempB_H
	movlw	50
	movwf	SysWORDTempA,ACCESS
	clrf	SysWORDTempA_H,ACCESS
	call	SysCompLessThan16
	banksel	SYSTEMP3
	movf	SysTemp3,W,BANKED
	iorwf	SysTemp1,W,BANKED
	movwf	SysTemp2,BANKED
	iorwf	SysByteTempX,W,ACCESS
	movwf	SysTemp3,BANKED
	btfsc	SysTemp3,0,BANKED
	bra	SysDoLoop_E11
;SD_Counter=SD_Counter+1
	incf	SD_COUNTER,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	SD_COUNTER_H,F,BANKED
;SendCommand(0x48, 0x000001AA, 0x87) 'return R7 response
	movlw	72
	movwf	CODE,ACCESS
	movlw	170
	movwf	ARG,ACCESS
	movlw	1
	movwf	ARG_H,ACCESS
	clrf	ARG_U,ACCESS
	clrf	ARG_E,ACCESS
	movlw	135
	movwf	CRC,ACCESS
	banksel	0
	call	SENDCOMMAND
;GetSDResponse(1,SDResponse)
	movlw	1
	banksel	NRESPONSE
	movwf	NRESPONSE,BANKED
	movff	SDRESPONSE,SDRESP
	banksel	0
	call	GETSDRESPONSE
	movff	SDRESP,SDRESPONSE
;GetSDResponse(3,SDResponse2)
	movlw	3
	banksel	NRESPONSE
	movwf	NRESPONSE,BANKED
	movff	SDRESPONSE2,SDRESP
	banksel	0
	call	GETSDRESPONSE
	movff	SDRESP,SDRESPONSE2
;GetSDResponse(1,SDResponse3)
	movlw	1
	banksel	NRESPONSE
	movwf	NRESPONSE,BANKED
	movff	SDRESPONSE3,SDRESP
	banksel	0
	call	GETSDRESPONSE
	movff	SDRESP,SDRESPONSE3
;GetSDResponse(1,SDData)
	movlw	1
	banksel	NRESPONSE
	movwf	NRESPONSE,BANKED
	movff	SDDATA,SDRESP
	banksel	0
	call	GETSDRESPONSE
	movff	SDRESP,SDDATA
;loop
	bra	SysDoLoop_S11
SysDoLoop_E11
;SET SD_Adaper_CS ON
	bsf	LATD,7,ACCESS
;if SD_Counter >50  then
	movff	SD_COUNTER,SysWORDTempB
	movff	SD_COUNTER_H,SysWORDTempB_H
	movlw	50
	movwf	SysWORDTempA,ACCESS
	clrf	SysWORDTempA_H,ACCESS
	banksel	0
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE95_1
;sertxd(1,"-CMD8 ","failed.",0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM5
	movlw	low StringTable85
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable85
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable85
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM5
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM5
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable86
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable86
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable86
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;else
	bra	ENDIF95
ELSE95_1
;if SDResponse=0x01 then
	banksel	SDRESPONSE
	decf	SDRESPONSE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF96
;sertxd(1,"-CMD8 ","  Executed.",0):sertxd(1,"        Card"," is V2",0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM5
	movlw	low StringTable85
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable85
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable85
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM5
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM5
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable87
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable87
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable87
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM5
	movlw	low StringTable88
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable88
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable88
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM5
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM5
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable89
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable89
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable89
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;end if
ENDIF96
;if SDResponse=0x05 then
	movlw	5
	banksel	SDRESPONSE
	subwf	SDRESPONSE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF97
;sertxd(1,"-CMD8  "," Executed.",0):sertxd(1,"        Card"," is V1",0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM5
	movlw	low StringTable90
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable90
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable90
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM5
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM5
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable91
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable91
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable91
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM5
	movlw	low StringTable88
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable88
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable88
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM5
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM5
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable92
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable92
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable92
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;end if
ENDIF97
;If SDResponse3=0xAA then
	movlw	170
	banksel	SDRESPONSE3
	subwf	SDRESPONSE3,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE98_1
;sertxd(1,"    ","   ",0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM5
	movlw	low StringTable93
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable93
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable93
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM5
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM5
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable94
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable94
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable94
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;sertxd(0," The CMD8 check ","pattern is confirmed",0)
	clrf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM5
	movlw	low StringTable95
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable95
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable95
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM5
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM5
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable96
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable96
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable96
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;else
	bra	ENDIF98
ELSE98_1
;sertxd(1,"    ","   ",0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM5
	movlw	low StringTable93
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable93
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable93
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM5
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM5
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable94
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable94
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable94
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;sertxd(0," The CMD8 check ","pattern is not confirmed",0):sertxd(0, "SDResponse3=",SDResponse3,0)
	clrf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM5
	movlw	low StringTable95
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable95
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable95
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM5
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM5
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable97
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable97
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable97
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
	clrf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM5
	movlw	low StringTable98
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable98
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable98
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM5
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM5
	movwf	SysSTRINGAHandler_H,BANKED
	movff	SDRESPONSE3,INPUTB
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD8
;end if
ENDIF98
;If SDResponse2=1 then
	banksel	SDRESPONSE2
	decf	SDRESPONSE2,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE99_1
;sertxd(1,"    ","   ",0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM5
	movlw	low StringTable93
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable93
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable93
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM5
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM5
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable94
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable94
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable94
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;sertxd(0," The CMD8 confirm ","voltage Card",0)
	clrf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM5
	movlw	low StringTable99
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable99
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable99
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM5
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM5
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable100
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable100
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable100
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;else
	bra	ENDIF99
ELSE99_1
;sertxd(1,"    ","   ",0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM5
	movlw	low StringTable93
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable93
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable93
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM5
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM5
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable94
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable94
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable94
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;sertxd(0," The CMD8 does not ","confirm Voltage Card",0):sertxd(0, "SDResponse2=",SDResponse2,0)
	clrf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM5
	movlw	low StringTable101
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable101
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable101
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM5
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM5
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable102
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable102
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable102
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
	clrf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM5
	movlw	low StringTable103
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable103
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable103
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM5
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM5
	movwf	SysSTRINGAHandler_H,BANKED
	movff	SDRESPONSE2,INPUTB
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD8
;end if
ENDIF99
;end if
ENDIF95
	return

;********************************************************************************

;Source: string.h (536)
FN_CHR
;Empty input?
;If SysChar < 0 Then
	movlw	0
	banksel	SYSCHAR
	subwf	SYSCHAR,W,BANKED
	btfsc	STATUS, C,ACCESS
	bra	ENDIF205
;Chr(0) = 0
	banksel	SYSCHR_0
	clrf	SYSCHR_0,BANKED
;Exit Function
	banksel	0
	return
;End If
ENDIF205
;Chr(0) = 1
	movlw	1
	banksel	SYSCHR_0
	movwf	SYSCHR_0,BANKED
;Copy characters
;Chr(1) = SysChar
	movffl	SYSCHAR,SYSCHR_1
	banksel	0
	return

;********************************************************************************

;Source: epd_epd2in13d.h (477)
CLEAR_BUFFER_EPD2IN13D
;initialise global variable. Required variable for Circle - DO NOT DELETE
;GLCD_yordinate = 0
	clrf	GLCD_YORDINATE,BANKED
	clrf	GLCD_YORDINATE_H,BANKED
;Dim EPD_Ind_raw, EPD_Ind_col as word
;Dim PrintLocX, PrintLocY as word
;PrintLocX = 0
	banksel	PRINTLOCX
	clrf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
;PrintLocY = 0
	clrf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
;Dim EPD_Ind_raw as Word
;for EPD_Ind_raw=1 to BUFFWIDTH                 'clear the buffer
	banksel	EPD_IND_RAW
	clrf	EPD_IND_RAW,BANKED
	clrf	EPD_IND_RAW_H,BANKED
SysForLoop21
	incf	EPD_IND_RAW,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	EPD_IND_RAW_H,F,BANKED
;EPD_Buffer(EPD_Ind_raw)=GLCDBackground
	lfsr	0,EPD_BUFFER
	movf	EPD_IND_RAW,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	EPD_IND_RAW_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movffl	GLCDBACKGROUND,INDF0
;next
	movff	EPD_IND_RAW,SysWORDTempA
	movff	EPD_IND_RAW_H,SysWORDTempA_H
	movlw	212
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop21
SysForLoopEnd21
	return

;********************************************************************************

;Source: epd_epd2in13d.h (417)
CLS_EPD2IN13D
;CLS_EPD2in13D_init
	rcall	CLS_EPD2IN13D_INIT
;Refresh_EPD2in13D
	goto	REFRESH_EPD2IN13D

;********************************************************************************

;Source: epd_epd2in13d.h (367)
CLS_EPD2IN13D_INIT
;initialise global variable. Required variable for Circle - DO NOT DELETE
;GLCD_yordinate = 0
	clrf	GLCD_YORDINATE,BANKED
	clrf	GLCD_YORDINATE_H,BANKED
;Dim EPD_Ind_raw, EPD_Ind_col as word
;Dim PrintLocX, PrintLocY as word
;PrintLocX = 0
	banksel	PRINTLOCX
	clrf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
;PrintLocY = 0
	clrf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
;For EPD_Ind_raw=1 to BUFFWIDTH
	banksel	EPD_IND_RAW
	clrf	EPD_IND_RAW,BANKED
	clrf	EPD_IND_RAW_H,BANKED
SysForLoop40
	incf	EPD_IND_RAW,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	EPD_IND_RAW_H,F,BANKED
;EPD_Buffer(EPD_Ind_raw)=GLCDBackground
	lfsr	0,EPD_BUFFER
	movf	EPD_IND_RAW,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	EPD_IND_RAW_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movffl	GLCDBACKGROUND,INDF0
;next
	movff	EPD_IND_RAW,SysWORDTempA
	movff	EPD_IND_RAW_H,SysWORDTempA_H
	movlw	212
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop40
SysForLoopEnd40
;Clear down "OLD" data
;SendCommand_EPD2in13D(Data_Transmission_1)
	movlw	16
	movwf	EPD2IN13D_COMMAND,BANKED
	call	SENDCOMMAND_EPD2IN13D
;wait 2 ms
	movlw	2
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;SET EPD_CS OFF
	bcf	LATC,1,ACCESS
;SET EPD_DC ON
	bsf	LATA,0,ACCESS
;for EPD_Ind_raw=1 to GLCD_Height
	clrf	EPD_IND_RAW,BANKED
	clrf	EPD_IND_RAW_H,BANKED
SysForLoop41
	incf	EPD_IND_RAW,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	EPD_IND_RAW_H,F,BANKED
;for EPD_Ind_col=1 to GLCD_Width
	clrf	EPD_IND_COL,BANKED
	clrf	EPD_IND_COL_H,BANKED
SysForLoop42
	incf	EPD_IND_COL,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	EPD_IND_COL_H,F,BANKED
;Was.. speed optimised with macro              SendData_EPD2in13D(GLCDBackGround)
;EPD2in13D_Data = GLCDBackGround
	movff	GLCDBACKGROUND,EPD2IN13D_DATA
;SendData_EPD2in13D_Macro
;Macro Source: epd_epd2in13d.h (560)
;REPEAT 8
	movlw	8
	banksel	SYSREPEATTEMP24
	movwf	SysRepeatTemp24,BANKED
SysRepeatLoop24
;IF EPD2in13D_Data.7 = ON THEN
	banksel	EPD2IN13D_DATA
	btfss	EPD2IN13D_DATA,7,BANKED
	bra	ELSE237_1
;Set EPD_DO ON
	bsf	LATC,5,ACCESS
;ELSE
	bra	ENDIF237
ELSE237_1
;Set EPD_DO OFF
	bcf	LATC,5,ACCESS
;END IF
ENDIF237
;SET EPD_SCK On
	bsf	LATC,3,ACCESS
;Rotate EPD2in13D_Data left
	rlcf	EPD2IN13D_DATA,F,BANKED
;Set EPD_SCK Off
	bcf	LATC,3,ACCESS
;END REPEAT
	banksel	SYSREPEATTEMP24
	decfsz	SysRepeatTemp24,F,BANKED
	bra	SysRepeatLoop24
SysRepeatLoopEnd24
;next
	movff	EPD_IND_COL,SysWORDTempA
	movff	EPD_IND_COL_H,SysWORDTempA_H
	movlw	104
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop42
SysForLoopEnd42
;next
	movff	EPD_IND_RAW,SysWORDTempA
	movff	EPD_IND_RAW_H,SysWORDTempA_H
	movlw	212
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop41
SysForLoopEnd41
;SET EPD_CS ON
	bsf	LATC,1,ACCESS
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;Clear down "NEW" data
;SendCommand_EPD2in13D(Data_Transmission_2)
	movlw	19
	movwf	EPD2IN13D_COMMAND,BANKED
	call	SENDCOMMAND_EPD2IN13D
;wait 2 ms
	movlw	2
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;SET EPD_CS OFF
	bcf	LATC,1,ACCESS
;SET EPD_DC ON
	bsf	LATA,0,ACCESS
;for EPD_Ind_raw=1 to GLCD_Height
	clrf	EPD_IND_RAW,BANKED
	clrf	EPD_IND_RAW_H,BANKED
SysForLoop43
	incf	EPD_IND_RAW,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	EPD_IND_RAW_H,F,BANKED
;for EPD_Ind_col=1 to GLCD_Width
	clrf	EPD_IND_COL,BANKED
	clrf	EPD_IND_COL_H,BANKED
SysForLoop44
	incf	EPD_IND_COL,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	EPD_IND_COL_H,F,BANKED
;Was.. speed optimised with macro              SendData_EPD2in13D(GLCDBackGround)
;EPD2in13D_Data = GLCDBackGround
	movff	GLCDBACKGROUND,EPD2IN13D_DATA
;SendData_EPD2in13D_Macro
;Macro Source: epd_epd2in13d.h (560)
;REPEAT 8
	movlw	8
	banksel	SYSREPEATTEMP24
	movwf	SysRepeatTemp24,BANKED
SysRepeatLoop25
;IF EPD2in13D_Data.7 = ON THEN
	banksel	EPD2IN13D_DATA
	btfss	EPD2IN13D_DATA,7,BANKED
	bra	ELSE240_1
;Set EPD_DO ON
	bsf	LATC,5,ACCESS
;ELSE
	bra	ENDIF240
ELSE240_1
;Set EPD_DO OFF
	bcf	LATC,5,ACCESS
;END IF
ENDIF240
;SET EPD_SCK On
	bsf	LATC,3,ACCESS
;Rotate EPD2in13D_Data left
	rlcf	EPD2IN13D_DATA,F,BANKED
;Set EPD_SCK Off
	bcf	LATC,3,ACCESS
;END REPEAT
	banksel	SYSREPEATTEMP24
	decfsz	SysRepeatTemp24,F,BANKED
	bra	SysRepeatLoop25
SysRepeatLoopEnd25
;next
	movff	EPD_IND_COL,SysWORDTempA
	movff	EPD_IND_COL_H,SysWORDTempA_H
	movlw	104
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop44
SysForLoopEnd44
;next
	movff	EPD_IND_RAW,SysWORDTempA
	movff	EPD_IND_RAW_H,SysWORDTempA_H
	movlw	212
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop43
SysForLoopEnd43
;SET EPD_CS ON
	bsf	LATC,1,ACCESS
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	goto	Delay_MS

;********************************************************************************

;Source: E_paper-18F47K42_SD_SDLIB_Transaction.gcb (312)
COMPLEX_GRAPH_EXAMPLE
;FilledBox_EPD2in13D( 4, 4,42, 42, GLCDForeground)  'Filled Rectangle
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
	banksel	0
	call	FILLEDBOX_EPD2IN13D
;FilledBox_EPD2in13D( 5, 5,41, 41, GLCDBackground)
	movlw	5
	banksel	LINEX1
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
	banksel	0
	call	FILLEDBOX_EPD2IN13D
;FilledBox_EPD2in13D( 6, 6,40, 40, GLCDForeground)
	movlw	6
	banksel	LINEX1
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
	banksel	0
	call	FILLEDBOX_EPD2IN13D
;FilledBox_EPD2in13D( 7, 7,39, 39, GLCDBackground)
	movlw	7
	banksel	LINEX1
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
	banksel	0
	call	FILLEDBOX_EPD2IN13D
;FilledBox_EPD2in13D( 8, 8,38, 38, GLCDForeground)
	movlw	8
	banksel	LINEX1
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
	banksel	0
	call	FILLEDBOX_EPD2IN13D
;FilledBox_EPD2in13D( 9, 9,37, 37, GLCDBackground)
	movlw	9
	banksel	LINEX1
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
	banksel	0
	call	FILLEDBOX_EPD2IN13D
;FilledBox_EPD2in13D(10,10,36, 36, GLCDForeground)
	movlw	10
	banksel	LINEX1
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
	banksel	0
	call	FILLEDBOX_EPD2IN13D
;FilledBox_EPD2in13D(11,11,35, 35, GLCDBackground)
	movlw	11
	banksel	LINEX1
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
	banksel	0
	call	FILLEDBOX_EPD2IN13D
;FilledBox_EPD2in13D(12,12,34, 34, GLCDForeground)
	movlw	12
	banksel	LINEX1
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
	banksel	0
	call	FILLEDBOX_EPD2IN13D
;FilledBox_EPD2in13D(13,13,33, 33, GLCDBackground)
	movlw	13
	banksel	LINEX1
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
	banksel	0
	call	FILLEDBOX_EPD2IN13D
;FilledBox_EPD2in13D(14,14,32, 32, GLCDForeground)
	movlw	14
	banksel	LINEX1
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
	banksel	0
	call	FILLEDBOX_EPD2IN13D
;FilledBox_EPD2in13D(15,15,31, 31, GLCDBackground)
	movlw	15
	banksel	LINEX1
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
	banksel	0
	call	FILLEDBOX_EPD2IN13D
;FilledCircle(77,25,23, GLCDForeground)              'Filled Circle
	movlw	77
	banksel	XOFFSET
	movwf	XOFFSET,BANKED
	clrf	XOFFSET_H,BANKED
	movlw	25
	banksel	YOFFSET
	movwf	YOFFSET,BANKED
	clrf	YOFFSET_H,BANKED
	movlw	23
	banksel	XRADIUS
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
	banksel	YOFFSET
	movwf	YOFFSET,BANKED
	clrf	YOFFSET_H,BANKED
	movlw	19
	banksel	XRADIUS
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
	banksel	YOFFSET
	movwf	YOFFSET,BANKED
	clrf	YOFFSET_H,BANKED
	movlw	14
	banksel	XRADIUS
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
	banksel	YOFFSET
	movwf	YOFFSET,BANKED
	clrf	YOFFSET_H,BANKED
	movlw	11
	banksel	XRADIUS
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
	banksel	YOFFSET
	movwf	YOFFSET,BANKED
	clrf	YOFFSET_H,BANKED
	movlw	5
	banksel	XRADIUS
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
	banksel	YOFFSET
	movwf	YOFFSET,BANKED
	clrf	YOFFSET_H,BANKED
	movlw	2
	banksel	XRADIUS
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
	banksel	YOFFSET
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
	banksel	0
	call	FILLEDELLIPSE
;FilledEllipse(25,60,14,7, GLCDBackground)
	movlw	25
	banksel	XOFFSET
	movwf	XOFFSET,BANKED
	clrf	XOFFSET_H,BANKED
	movlw	60
	banksel	YOFFSET
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
	banksel	0
	call	FILLEDELLIPSE
;FilledEllipse(25,60,12,6, GLCDForeground)
	movlw	25
	banksel	XOFFSET
	movwf	XOFFSET,BANKED
	clrf	XOFFSET_H,BANKED
	movlw	60
	banksel	YOFFSET
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
	banksel	0
	call	FILLEDELLIPSE
;FilledEllipse(25,60,10,5, GLCDBackground)
	movlw	25
	banksel	XOFFSET
	movwf	XOFFSET,BANKED
	clrf	XOFFSET_H,BANKED
	movlw	60
	banksel	YOFFSET
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
	banksel	0
	call	FILLEDELLIPSE
;FilledEllipse(25,60,8 ,4, GLCDForeground)
	movlw	25
	banksel	XOFFSET
	movwf	XOFFSET,BANKED
	clrf	XOFFSET_H,BANKED
	movlw	60
	banksel	YOFFSET
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
	banksel	0
	call	FILLEDELLIPSE
;FilledEllipse(25,60,6, 3, GLCDBackground)
	movlw	25
	banksel	XOFFSET
	movwf	XOFFSET,BANKED
	clrf	XOFFSET_H,BANKED
	movlw	60
	banksel	YOFFSET
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
	banksel	0
	call	FILLEDELLIPSE
;FillRoundRect(50,50,100,100,GLCDForeground)         'Filled rounded
	movlw	50
	banksel	RX1
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
	banksel	0
	call	FILLROUNDRECT
;FillRoundRect(55,55,95 ,95, GLCDBackground)
	movlw	55
	banksel	RX1
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
	banksel	0
	call	FILLROUNDRECT
;FillRoundRect(60,60,90 ,90, GLCDForeground)
	movlw	60
	banksel	RX1
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
	banksel	0
	call	FILLROUNDRECT
;FillRoundRect(65,65,85 ,85, GLCDBackground)
	movlw	65
	banksel	RX1
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
	banksel	0
	call	FILLROUNDRECT
;FillRoundRect(70,70,80 ,80, GLCDForeground)
	movlw	70
	banksel	RX1
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
	banksel	0
	call	FILLROUNDRECT
;FillRoundRect(75,75,75 ,75, GLCDBackground)
	movlw	75
	banksel	RX1
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
	banksel	0
	call	FILLROUNDRECT
;FillRoundRect(80,80,80 ,80, GLCDForeground)
	movlw	80
	banksel	RX1
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
	banksel	0
	call	FILLROUNDRECT
;FilledTriangle(25,70,2,102,46,102, GLCDForeground)  'Filled Triangle
	movlw	25
	banksel	XOFFSET
	movwf	XOFFSET,BANKED
	clrf	XOFFSET_H,BANKED
	movlw	70
	banksel	YOFFSET
	movwf	YOFFSET,BANKED
	clrf	YOFFSET_H,BANKED
	movlw	2
	banksel	XOFFSET2
	movwf	XOFFSET2,BANKED
	clrf	XOFFSET2_H,BANKED
	movlw	102
	banksel	YOFFSET2
	movwf	YOFFSET2,BANKED
	clrf	YOFFSET2_H,BANKED
	movlw	46
	banksel	XOFFSET3
	movwf	XOFFSET3,BANKED
	clrf	XOFFSET3_H,BANKED
	movlw	102
	banksel	YOFFSET3
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
	banksel	YOFFSET
	movwf	YOFFSET,BANKED
	clrf	YOFFSET_H,BANKED
	movlw	10
	banksel	XOFFSET2
	movwf	XOFFSET2,BANKED
	clrf	XOFFSET2_H,BANKED
	movlw	98
	banksel	YOFFSET2
	movwf	YOFFSET2,BANKED
	clrf	YOFFSET2_H,BANKED
	movlw	38
	banksel	XOFFSET3
	movwf	XOFFSET3,BANKED
	clrf	XOFFSET3_H,BANKED
	movlw	98
	banksel	YOFFSET3
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
	banksel	YOFFSET
	movwf	YOFFSET,BANKED
	clrf	YOFFSET_H,BANKED
	movlw	18
	banksel	XOFFSET2
	movwf	XOFFSET2,BANKED
	clrf	XOFFSET2_H,BANKED
	movlw	94
	banksel	YOFFSET2
	movwf	YOFFSET2,BANKED
	clrf	YOFFSET2_H,BANKED
	movlw	30
	banksel	XOFFSET3
	movwf	XOFFSET3,BANKED
	clrf	XOFFSET3_H,BANKED
	movlw	94
	banksel	YOFFSET3
	movwf	YOFFSET3,BANKED
	clrf	YOFFSET3_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	FILLEDTRIANGLE
;FilledBox_EPD2in13D( 8, 108,90,148, GLCDForeground) 'Filled rectangle
	movlw	8
	banksel	LINEX1
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
	banksel	0
	call	FILLEDBOX_EPD2IN13D
;FilledBox_EPD2in13D(18,118,80, 136, GLCDBackground)
	movlw	18
	banksel	LINEX1
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
	banksel	0
	call	FILLEDBOX_EPD2IN13D
;FilledBox_EPD2in13D(28,128,70, 126, GLCDForeground)
	movlw	28
	banksel	LINEX1
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
	banksel	0
	call	FILLEDBOX_EPD2IN13D
;DrawString_EPD2in13D(9,108 ,"Rectangle",GLCDBackground)
	movlw	9
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	108
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable51
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable51
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable51
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDBACKGROUND,LINECOLOUR
	movff	GLCDBACKGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;DrawString_EPD2in13D(19,117 ,"Rectangle")
	movlw	19
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	117
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable51
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable51
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable51
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;DrawString_EPD2in13D(19,149 ,"Hyperbole")
	movlw	19
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	149
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable52
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable52
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable52
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM3
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
	banksel	Y_0
	movwf	Y_0,BANKED
	clrf	Y_0_H,BANKED
	movlw	4
	movwf	A_AXIS,ACCESS
	clrf	A_AXIS_H,ACCESS
	movlw	2
	movwf	B_AXIS,ACCESS
	clrf	B_AXIS_H,ACCESS
	movlw	1
	banksel	TYPE
	movwf	TYPE,BANKED
	movlw	1
	movwf	MODESTOP,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	HYPERBOLE
	movff	LINECOLOUR,GLCDFOREGROUND
	movff	LINECOLOUR_H,GLCDFOREGROUND_H
;Hyperbole(50,181, 6, 3, 1,1, GLCDBackground)
	movlw	50
	banksel	X_0
	movwf	X_0,BANKED
	clrf	X_0_H,BANKED
	movlw	181
	banksel	Y_0
	movwf	Y_0,BANKED
	clrf	Y_0_H,BANKED
	movlw	6
	movwf	A_AXIS,ACCESS
	clrf	A_AXIS_H,ACCESS
	movlw	3
	movwf	B_AXIS,ACCESS
	clrf	B_AXIS_H,ACCESS
	movlw	1
	banksel	TYPE
	movwf	TYPE,BANKED
	movlw	1
	movwf	MODESTOP,BANKED
	movff	GLCDBACKGROUND,LINECOLOUR
	movff	GLCDBACKGROUND_H,LINECOLOUR_H
	banksel	0
	call	HYPERBOLE
	movff	LINECOLOUR,GLCDBACKGROUND
	movff	LINECOLOUR_H,GLCDBACKGROUND_H
;Hyperbole(50,181,10, 5, 1,1, GLCDForeground)
	movlw	50
	banksel	X_0
	movwf	X_0,BANKED
	clrf	X_0_H,BANKED
	movlw	181
	banksel	Y_0
	movwf	Y_0,BANKED
	clrf	Y_0_H,BANKED
	movlw	10
	movwf	A_AXIS,ACCESS
	clrf	A_AXIS_H,ACCESS
	movlw	5
	movwf	B_AXIS,ACCESS
	clrf	B_AXIS_H,ACCESS
	movlw	1
	banksel	TYPE
	movwf	TYPE,BANKED
	movlw	1
	movwf	MODESTOP,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	HYPERBOLE
	movff	LINECOLOUR,GLCDFOREGROUND
	movff	LINECOLOUR_H,GLCDFOREGROUND_H
;Hyperbole(50,181,14, 7, 1,1, GLCDBackground)
	movlw	50
	banksel	X_0
	movwf	X_0,BANKED
	clrf	X_0_H,BANKED
	movlw	181
	banksel	Y_0
	movwf	Y_0,BANKED
	clrf	Y_0_H,BANKED
	movlw	14
	movwf	A_AXIS,ACCESS
	clrf	A_AXIS_H,ACCESS
	movlw	7
	movwf	B_AXIS,ACCESS
	clrf	B_AXIS_H,ACCESS
	movlw	1
	banksel	TYPE
	movwf	TYPE,BANKED
	movlw	1
	movwf	MODESTOP,BANKED
	movff	GLCDBACKGROUND,LINECOLOUR
	movff	GLCDBACKGROUND_H,LINECOLOUR_H
	banksel	0
	call	HYPERBOLE
	movff	LINECOLOUR,GLCDBACKGROUND
	movff	LINECOLOUR_H,GLCDBACKGROUND_H
;Hyperbole(50,181,18, 9, 1,1, GLCDForeground)
	movlw	50
	banksel	X_0
	movwf	X_0,BANKED
	clrf	X_0_H,BANKED
	movlw	181
	banksel	Y_0
	movwf	Y_0,BANKED
	clrf	Y_0_H,BANKED
	movlw	18
	movwf	A_AXIS,ACCESS
	clrf	A_AXIS_H,ACCESS
	movlw	9
	movwf	B_AXIS,ACCESS
	clrf	B_AXIS_H,ACCESS
	movlw	1
	banksel	TYPE
	movwf	TYPE,BANKED
	movlw	1
	movwf	MODESTOP,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	HYPERBOLE
	movff	LINECOLOUR,GLCDFOREGROUND
	movff	LINECOLOUR_H,GLCDFOREGROUND_H
;Hyperbole(50,181,22,11, 1,1, GLCDBackground)
	movlw	50
	banksel	X_0
	movwf	X_0,BANKED
	clrf	X_0_H,BANKED
	movlw	181
	banksel	Y_0
	movwf	Y_0,BANKED
	clrf	Y_0_H,BANKED
	movlw	22
	movwf	A_AXIS,ACCESS
	clrf	A_AXIS_H,ACCESS
	movlw	11
	movwf	B_AXIS,ACCESS
	clrf	B_AXIS_H,ACCESS
	movlw	1
	banksel	TYPE
	movwf	TYPE,BANKED
	movlw	1
	movwf	MODESTOP,BANKED
	movff	GLCDBACKGROUND,LINECOLOUR
	movff	GLCDBACKGROUND_H,LINECOLOUR_H
	banksel	0
	call	HYPERBOLE
	movff	LINECOLOUR,GLCDBACKGROUND
	movff	LINECOLOUR_H,GLCDBACKGROUND_H
;Hyperbole(50,181,26,13, 1,1, GLCDForeground)
	movlw	50
	banksel	X_0
	movwf	X_0,BANKED
	clrf	X_0_H,BANKED
	movlw	181
	banksel	Y_0
	movwf	Y_0,BANKED
	clrf	Y_0_H,BANKED
	movlw	26
	movwf	A_AXIS,ACCESS
	clrf	A_AXIS_H,ACCESS
	movlw	13
	movwf	B_AXIS,ACCESS
	clrf	B_AXIS_H,ACCESS
	movlw	1
	banksel	TYPE
	movwf	TYPE,BANKED
	movlw	1
	movwf	MODESTOP,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	HYPERBOLE
	movff	LINECOLOUR,GLCDFOREGROUND
	movff	LINECOLOUR_H,GLCDFOREGROUND_H
;Hyperbole(50,181,30,15, 1,1, GLCDBackground)
	movlw	50
	banksel	X_0
	movwf	X_0,BANKED
	clrf	X_0_H,BANKED
	movlw	181
	banksel	Y_0
	movwf	Y_0,BANKED
	clrf	Y_0_H,BANKED
	movlw	30
	movwf	A_AXIS,ACCESS
	clrf	A_AXIS_H,ACCESS
	movlw	15
	movwf	B_AXIS,ACCESS
	clrf	B_AXIS_H,ACCESS
	movlw	1
	banksel	TYPE
	movwf	TYPE,BANKED
	movlw	1
	movwf	MODESTOP,BANKED
	movff	GLCDBACKGROUND,LINECOLOUR
	movff	GLCDBACKGROUND_H,LINECOLOUR_H
	banksel	0
	call	HYPERBOLE
	movff	LINECOLOUR,GLCDBACKGROUND
	movff	LINECOLOUR_H,GLCDBACKGROUND_H
;Hyperbole(50,181,34,17, 1,1, GLCDForeground)
	movlw	50
	banksel	X_0
	movwf	X_0,BANKED
	clrf	X_0_H,BANKED
	movlw	181
	banksel	Y_0
	movwf	Y_0,BANKED
	clrf	Y_0_H,BANKED
	movlw	34
	movwf	A_AXIS,ACCESS
	clrf	A_AXIS_H,ACCESS
	movlw	17
	movwf	B_AXIS,ACCESS
	clrf	B_AXIS_H,ACCESS
	movlw	1
	banksel	TYPE
	movwf	TYPE,BANKED
	movlw	1
	movwf	MODESTOP,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	HYPERBOLE
	movff	LINECOLOUR,GLCDFOREGROUND
	movff	LINECOLOUR_H,GLCDFOREGROUND_H
	return

;********************************************************************************

;Source: MySDLib.h (473)
DISK_EXPLORER
;dim boot_flag as Byte
;SDRead_Block(Address_Sector)
	movff	ADDRESS_SECTOR,BLOCK_START
	movff	ADDRESS_SECTOR_H,BLOCK_START_H
	movff	ADDRESS_SECTOR_U,BLOCK_START_U
	movff	ADDRESS_SECTOR_E,BLOCK_START_E
	call	SDREAD_BLOCK
;SDLocation_last=Address_Sector
	movff	ADDRESS_SECTOR,SDLOCATION_LAST
	movff	ADDRESS_SECTOR_H,SDLOCATION_LAST_H
	movff	ADDRESS_SECTOR_U,SDLOCATION_LAST_U
	movff	ADDRESS_SECTOR_E,SDLOCATION_LAST_E
;if Address_Sector=Cluster_Begin_LBA then
	movff	ADDRESS_SECTOR,SysLONGTempA
	movff	ADDRESS_SECTOR_H,SysLONGTempA_H
	movff	ADDRESS_SECTOR_U,SysLONGTempA_U
	movff	ADDRESS_SECTOR_E,SysLONGTempA_E
	movff	CLUSTER_BEGIN_LBA,SysLONGTempB
	movff	CLUSTER_BEGIN_LBA_H,SysLONGTempB_H
	movff	CLUSTER_BEGIN_LBA_U,SysLONGTempB_U
	movff	CLUSTER_BEGIN_LBA_E,SysLONGTempB_E
	call	SysCompEqual32
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE117_1
;boot_Flag=1
	movlw	1
	movwf	BOOT_FLAG,ACCESS
;else
	bra	ENDIF117
ELSE117_1
;boot_flag=0
	clrf	BOOT_FLAG,ACCESS
;end if
ENDIF117
;Record_Location=0  'ora la base di indirizzo è il byte 0 del blocco letto
	banksel	RECORD_LOCATION
	clrf	RECORD_LOCATION,BANKED
	clrf	RECORD_LOCATION_H,BANKED
;B0=100
	movlw	100
	movwf	B0,ACCESS
	clrf	B0_H,ACCESS
	clrf	B0_U,ACCESS
	clrf	B0_E,ACCESS
;SD_Counter2=0     'SD_Counter, SD_Counter1 non utilizzabili perche usati da CallReadBlock
	clrf	SD_COUNTER2,BANKED
	clrf	SD_COUNTER2_H,BANKED
;ind1=0
	clrf	IND1,BANKED
;ind2=0
	clrf	IND2,BANKED
;do until B0 =0
SysDoLoop_S17
	movff	b0,SysLONGTempA
	movff	b0_H,SysLONGTempA_H
	movff	b0_U,SysLONGTempA_U
	movff	b0_E,SysLONGTempA_E
	clrf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	banksel	0
	call	SysCompEqual32
	btfsc	SysByteTempX,0,ACCESS
	goto	SysDoLoop_E17
;B1=SDDataBuffer(Record_Location)
	lfsr	0,SDDATABUFFER
	banksel	RECORD_LOCATION
	movf	RECORD_LOCATION,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	RECORD_LOCATION_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movffl	INDF0,B1
	clrf	B1_H,ACCESS
	clrf	B1_U,ACCESS
	clrf	B1_E,ACCESS
;if B1<>0xE5 then
	movff	B1,SysLONGTempA
	movff	B1_H,SysLONGTempA_H
	movff	B1_U,SysLONGTempA_U
	movff	B1_E,SysLONGTempA_E
	movlw	229
	movwf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	banksel	0
	call	SysCompEqual32
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	goto	ENDIF118
;B1=SDDataBuffer(Record_Location+11)
	lfsr	0,SDDATABUFFER
	banksel	RECORD_LOCATION
	movf	RECORD_LOCATION,W,BANKED
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp1,BANKED
	movf	RECORD_LOCATION_H,W,BANKED
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movlw	11
	addwf	SysTemp1,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movffl	INDF0,B1
	clrf	B1_H,ACCESS
	clrf	B1_U,ACCESS
	clrf	B1_E,ACCESS
;if B1.0<>1 or B1.1<>1 or B1.2 <>1 or B1.3<>1  then
	clrf	SysByteTempX,ACCESS
	btfss	B1,0,ACCESS
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp3
	clrf	SysByteTempX,ACCESS
	btfss	B1,1,ACCESS
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp1
	clrf	SysByteTempX,ACCESS
	btfss	B1,2,ACCESS
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp2
	clrf	SysByteTempX,ACCESS
	btfss	B1,3,ACCESS
	comf	SysByteTempX,F,ACCESS
	movf	SysTemp3,W,BANKED
	iorwf	SysTemp1,W,BANKED
	movwf	SysTemp4,BANKED
	iorwf	SysTemp2,W,BANKED
	movwf	SysTemp3,BANKED
	iorwf	SysByteTempX,W,ACCESS
	movwf	SysTemp4,BANKED
	btfss	SysTemp4,0,BANKED
	goto	ENDIF122
;If B1.4 =1  then                                'is a directory
	btfss	B1,4,ACCESS
	bra	ELSE125_1
;SD_MyString=CHR(SDDataBuffer(Record_Location))
	lfsr	0,SDDATABUFFER
	movf	RECORD_LOCATION,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	RECORD_LOCATION_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movffl	INDF0,SYSCHAR
	banksel	0
	call	FN_CHR
	lfsr	1,SD_MYSTRING
	lfsr	0,CHR
	call	SysCopyString
;for SD_Counter3=1 to 7
	banksel	SD_COUNTER3
	clrf	SD_COUNTER3,BANKED
	clrf	SD_COUNTER3_H,BANKED
SysForLoop14
	banksel	SD_COUNTER3
	incf	SD_COUNTER3,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	SD_COUNTER3_H,F,BANKED
;Dir_or_File_Name=SD_MyString+CHR(SDDataBuffer(Record_Location+SD_Counter3))
	lfsr	0,SDDATABUFFER
	movf	RECORD_LOCATION,W,BANKED
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp1,BANKED
	movf	RECORD_LOCATION_H,W,BANKED
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movf	SD_COUNTER3,W,BANKED
	addwf	SysTemp1,W,BANKED
	movwf	AFSR0,ACCESS
	movf	SD_COUNTER3_H,W,BANKED
	addwfc	SysTemp1_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movffl	INDF0,SYSCHAR
	banksel	0
	call	FN_CHR
	lfsr	1,DIR_OR_FILE_NAME
	clrf	SysStringLength,ACCESS
	lfsr	0,SD_MYSTRING
	call	SysCopyStringPart
	lfsr	0,CHR
	call	SysCopyStringPart
	lfsr	0,DIR_OR_FILE_NAME
	movffl	SysStringLength,INDF0
;SD_MyString=Dir_or_File_Name
	lfsr	1,SD_MYSTRING
	lfsr	0,DIR_OR_FILE_NAME
	call	SysCopyString
;next
	movff	SD_COUNTER3,SysWORDTempA
	movff	SD_COUNTER3_H,SysWORDTempA_H
	movlw	7
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop14
SysForLoopEnd14
;ind1=ind1+1
	banksel	IND1
	incf	IND1,F,BANKED
;Dir_Record(ind1)=SD_Counter2
	lfsr	0,DIR_RECORD
	movf	IND1,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movffl	SD_COUNTER2,INDF0
;if ind1=1 and ind2=0 then
	movff	IND1,SysBYTETempA
	movlw	1
	movwf	SysBYTETempB,ACCESS
	banksel	0
	call	SysCompEqual
	movff	SysByteTempX,SysTemp3
	movff	IND2,SysBYTETempA
	clrf	SysBYTETempB,ACCESS
	call	SysCompEqual
	banksel	SYSTEMP3
	movf	SysTemp3,W,BANKED
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp4,BANKED
	btfss	SysTemp4,0,BANKED
	bra	ENDIF127
;Draw_Line(1,60,"-")
	movlw	1
	movwf	LINE_TYPE,BANKED
	movlw	60
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable33
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable33
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable33
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	call	DRAW_LINE
;Draw_Line(1,8," "):Sertxd(0,"Directories and"," Files List in "+Name,0)
	movlw	1
	banksel	LINE_TYPE
	movwf	LINE_TYPE,BANKED
	movlw	8
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	call	DRAW_LINE
	clrf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable157
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable157
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable157
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM4
	clrf	SysStringLength,ACCESS
	movlw	low StringTable158
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable158
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable158
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadStringPart
	movffl	SysNAMEHandler,FSR0L
	movffl	SysNAMEHandler_H,FSR0H
	call	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM4
	movffl	SysStringLength,INDF0
	movlw	low SYSSTRINGPARAM4
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM4
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;Draw_Line(1,60,"-"):Draw_Line(1,60," ")
	movlw	1
	banksel	LINE_TYPE
	movwf	LINE_TYPE,BANKED
	movlw	60
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable33
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable33
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable33
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	call	DRAW_LINE
	movlw	1
	banksel	LINE_TYPE
	movwf	LINE_TYPE,BANKED
	movlw	60
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	call	DRAW_LINE
;end if
ENDIF127
;sertxd(1,"  Dir  n.=",ind1,0):sertxd(0," "+CHR(254)+" ",Dir_or_File_Name,0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable159
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable159
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable159
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysSTRINGAHandler_H,BANKED
	movff	IND1,INPUTB
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD8
	clrf	CRLF1,ACCESS
	movlw	254
	banksel	SYSCHAR
	movwf	SYSCHAR,BANKED
	banksel	0
	call	FN_CHR
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	call	SysReadStringPart
	lfsr	0,CHR
	call	SysCopyStringPart
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	call	SysReadStringPart
	lfsr	0,SYSSTRINGPARAM3
	movffl	SysStringLength,INDF0
	movlw	low SYSSTRINGPARAM3
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysSTRINGAHandler_H,BANKED
	movlw	low DIR_OR_FILE_NAME
	movwf	SysINPUTSHandler,BANKED
	movlw	high DIR_OR_FILE_NAME
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;sertxd(0,"     at Record n.",Dir_Record(ind1),0)
	clrf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable160
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable160
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable160
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	0,DIR_RECORD
	movf	IND1,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movffl	INDF0,INPUTB
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD8
;else
	bra	ENDIF125
ELSE125_1
;SD_MyString=CHR(SDDataBuffer(Record_Location))    'is a file or Boot record
	lfsr	0,SDDATABUFFER
	movf	RECORD_LOCATION,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	RECORD_LOCATION_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movffl	INDF0,SYSCHAR
	banksel	0
	call	FN_CHR
	lfsr	1,SD_MYSTRING
	lfsr	0,CHR
	call	SysCopyString
;for SD_Counter3=1 to 7
	banksel	SD_COUNTER3
	clrf	SD_COUNTER3,BANKED
	clrf	SD_COUNTER3_H,BANKED
SysForLoop15
	banksel	SD_COUNTER3
	incf	SD_COUNTER3,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	SD_COUNTER3_H,F,BANKED
;Dir_or_File_Name=SD_MyString+CHR(SDDataBuffer(Record_Location+SD_Counter3))
	lfsr	0,SDDATABUFFER
	movf	RECORD_LOCATION,W,BANKED
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp1,BANKED
	movf	RECORD_LOCATION_H,W,BANKED
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movf	SD_COUNTER3,W,BANKED
	addwf	SysTemp1,W,BANKED
	movwf	AFSR0,ACCESS
	movf	SD_COUNTER3_H,W,BANKED
	addwfc	SysTemp1_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movffl	INDF0,SYSCHAR
	banksel	0
	call	FN_CHR
	lfsr	1,DIR_OR_FILE_NAME
	clrf	SysStringLength,ACCESS
	lfsr	0,SD_MYSTRING
	call	SysCopyStringPart
	lfsr	0,CHR
	call	SysCopyStringPart
	lfsr	0,DIR_OR_FILE_NAME
	movffl	SysStringLength,INDF0
;SD_MyString=Dir_or_File_Name
	lfsr	1,SD_MYSTRING
	lfsr	0,DIR_OR_FILE_NAME
	call	SysCopyString
;next
	movff	SD_COUNTER3,SysWORDTempA
	movff	SD_COUNTER3_H,SysWORDTempA_H
	movlw	7
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop15
SysForLoopEnd15
;SD_MyString=CHR(SDDataBuffer(Record_Location+8))
	lfsr	0,SDDATABUFFER
	banksel	RECORD_LOCATION
	movf	RECORD_LOCATION,W,BANKED
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp1,BANKED
	movf	RECORD_LOCATION_H,W,BANKED
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movlw	8
	addwf	SysTemp1,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movffl	INDF0,SYSCHAR
	banksel	0
	call	FN_CHR
	lfsr	1,SD_MYSTRING
	lfsr	0,CHR
	call	SysCopyString
;for SD_Counter3=1 to 2
	banksel	SD_COUNTER3
	clrf	SD_COUNTER3,BANKED
	clrf	SD_COUNTER3_H,BANKED
SysForLoop16
	banksel	SD_COUNTER3
	incf	SD_COUNTER3,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	SD_COUNTER3_H,F,BANKED
;File_Extension=SD_MyString+CHR(SDDataBuffer(Record_Location+SD_Counter3+8))
	lfsr	0,SDDATABUFFER
	movf	RECORD_LOCATION,W,BANKED
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp1,BANKED
	movf	RECORD_LOCATION_H,W,BANKED
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movf	SD_COUNTER3,W,BANKED
	addwf	SysTemp1,W,BANKED
	movwf	SysTemp2,BANKED
	movf	SD_COUNTER3_H,W,BANKED
	addwfc	SysTemp1_H,W,BANKED
	movwf	SysTemp2_H,BANKED
	movlw	8
	addwf	SysTemp2,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp2_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movffl	INDF0,SYSCHAR
	banksel	0
	call	FN_CHR
	lfsr	1,FILE_EXTENSION
	clrf	SysStringLength,ACCESS
	lfsr	0,SD_MYSTRING
	call	SysCopyStringPart
	lfsr	0,CHR
	call	SysCopyStringPart
	lfsr	0,FILE_EXTENSION
	movffl	SysStringLength,INDF0
;SD_MyString=File_Extension
	lfsr	1,SD_MYSTRING
	lfsr	0,FILE_EXTENSION
	call	SysCopyString
;next
	movff	SD_COUNTER3,SysWORDTempA
	movff	SD_COUNTER3_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop16
SysForLoopEnd16
;ind2=ind2+1
	banksel	IND2
	incf	IND2,F,BANKED
;File_Record(ind2)=SD_Counter2
	lfsr	0,FILE_RECORD
	movf	IND2,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movffl	SD_COUNTER2,INDF0
;if ind2=1 and ind1=0 then
	movff	IND2,SysBYTETempA
	movlw	1
	movwf	SysBYTETempB,ACCESS
	banksel	0
	call	SysCompEqual
	movff	SysByteTempX,SysTemp3
	movff	IND1,SysBYTETempA
	clrf	SysBYTETempB,ACCESS
	call	SysCompEqual
	banksel	SYSTEMP3
	movf	SysTemp3,W,BANKED
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp4,BANKED
	btfss	SysTemp4,0,BANKED
	bra	ENDIF130
;Draw_Line(1,60,"-")
	movlw	1
	movwf	LINE_TYPE,BANKED
	movlw	60
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable33
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable33
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable33
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	call	DRAW_LINE
;Draw_Line(1,8," "):Sertxd(0,"Directories and ","Files List in "+Name,0)
	movlw	1
	banksel	LINE_TYPE
	movwf	LINE_TYPE,BANKED
	movlw	8
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	call	DRAW_LINE
	clrf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable161
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable161
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable161
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM4
	clrf	SysStringLength,ACCESS
	movlw	low StringTable162
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable162
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable162
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadStringPart
	movffl	SysNAMEHandler,FSR0L
	movffl	SysNAMEHandler_H,FSR0H
	call	SysCopyStringPart
	lfsr	0,SYSSTRINGPARAM4
	movffl	SysStringLength,INDF0
	movlw	low SYSSTRINGPARAM4
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM4
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;Draw_Line(1,60,"-"):Draw_Line(1,60," ")
	movlw	1
	banksel	LINE_TYPE
	movwf	LINE_TYPE,BANKED
	movlw	60
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable33
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable33
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable33
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	call	DRAW_LINE
	movlw	1
	banksel	LINE_TYPE
	movwf	LINE_TYPE,BANKED
	movlw	60
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	call	DRAW_LINE
;end if
ENDIF130
;if boot_flag=1 then
	decf	BOOT_FLAG,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ELSE131_1
;if ind2=1 then
	banksel	IND2
	decf	IND2,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE132_1
;sertxd(1,"  BOOT"," SECT.",0):sertxd(0,CHR(233)+" ",Dir_or_File_Name,0):sertxd(0,"  ","  ",0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable163
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable163
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable163
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM4
	movlw	low StringTable164
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable164
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable164
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM4
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM4
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
	clrf	CRLF1,ACCESS
	movlw	233
	banksel	SYSCHAR
	movwf	SYSCHAR,BANKED
	banksel	0
	call	FN_CHR
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	lfsr	0,CHR
	call	SysCopyStringPart
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	call	SysReadStringPart
	lfsr	0,SYSSTRINGPARAM3
	movffl	SysStringLength,INDF0
	movlw	low SYSSTRINGPARAM3
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysSTRINGAHandler_H,BANKED
	movlw	low DIR_OR_FILE_NAME
	movwf	SysINPUTSHandler,BANKED
	movlw	high DIR_OR_FILE_NAME
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
	clrf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable129
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable129
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable129
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM4
	movlw	low StringTable129
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable129
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable129
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM4
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM4
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;sertxd(0," at Record n.",File_Record(ind2),0)
	clrf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable165
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable165
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable165
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	0,FILE_RECORD
	movf	IND2,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movffl	INDF0,INPUTB
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD8
;else
	bra	ENDIF132
ELSE132_1
;sertxd(1,"  File n.=",ind2-1,0):sertxd(0," "+CHR(233)+" ",Dir_or_File_Name,0):Sertxd(0,".",File_Extension,0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable166
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable166
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable166
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysSTRINGAHandler_H,BANKED
	decf	IND2,W,BANKED
	movwf	INPUTB,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD8
	clrf	CRLF1,ACCESS
	movlw	233
	banksel	SYSCHAR
	movwf	SYSCHAR,BANKED
	banksel	0
	call	FN_CHR
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	call	SysReadStringPart
	lfsr	0,CHR
	call	SysCopyStringPart
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	call	SysReadStringPart
	lfsr	0,SYSSTRINGPARAM3
	movffl	SysStringLength,INDF0
	movlw	low SYSSTRINGPARAM3
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysSTRINGAHandler_H,BANKED
	movlw	low DIR_OR_FILE_NAME
	movwf	SysINPUTSHandler,BANKED
	movlw	high DIR_OR_FILE_NAME
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
	clrf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable167
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable167
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable167
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysSTRINGAHandler_H,BANKED
	movlw	low FILE_EXTENSION
	movwf	SysINPUTSHandler,BANKED
	movlw	high FILE_EXTENSION
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;sertxd(0," at Record n.",File_Record(ind2),0)
	clrf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable165
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable165
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable165
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	0,FILE_RECORD
	movf	IND2,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movffl	INDF0,INPUTB
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD8
;end if
ENDIF132
;else
	bra	ENDIF131
ELSE131_1
;sertxd(1,"  File n.=",ind2,0):sertxd(0," "+CHR(233)+" ",Dir_or_File_Name,0):Sertxd(0,".",File_Extension,0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable166
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable166
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable166
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysSTRINGAHandler_H,BANKED
	movff	IND2,INPUTB
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD8
	clrf	CRLF1,ACCESS
	movlw	233
	banksel	SYSCHAR
	movwf	SYSCHAR,BANKED
	banksel	0
	call	FN_CHR
	lfsr	1,SYSSTRINGPARAM3
	clrf	SysStringLength,ACCESS
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	call	SysReadStringPart
	lfsr	0,CHR
	call	SysCopyStringPart
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	call	SysReadStringPart
	lfsr	0,SYSSTRINGPARAM3
	movffl	SysStringLength,INDF0
	movlw	low SYSSTRINGPARAM3
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysSTRINGAHandler_H,BANKED
	movlw	low DIR_OR_FILE_NAME
	movwf	SysINPUTSHandler,BANKED
	movlw	high DIR_OR_FILE_NAME
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
	clrf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable167
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable167
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable167
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysSTRINGAHandler_H,BANKED
	movlw	low FILE_EXTENSION
	movwf	SysINPUTSHandler,BANKED
	movlw	high FILE_EXTENSION
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;sertxd(0," at Record n.",File_Record(ind2),0)
	clrf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable165
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable165
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable165
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	0,FILE_RECORD
	movf	IND2,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movffl	INDF0,INPUTB
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD8
;end if
ENDIF131
;end if
ENDIF125
;end if
ENDIF122
;end if
ENDIF118
;Record_Location=Record_Location+32
	movlw	32
	banksel	RECORD_LOCATION
	addwf	RECORD_LOCATION,F,BANKED
	movlw	0
	addwfc	RECORD_LOCATION_H,F,BANKED
;SD_Counter2=SD_Counter2+1
	incf	SD_COUNTER2,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	SD_COUNTER2_H,F,BANKED
;if Record_Location=512 then
	movff	RECORD_LOCATION,SysWORDTempA
	movff	RECORD_LOCATION_H,SysWORDTempA_H
	clrf	SysWORDTempB,ACCESS
	movlw	2
	movwf	SysWORDTempB_H,ACCESS
	banksel	0
	call	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF119
;Record_Location=0
	banksel	RECORD_LOCATION
	clrf	RECORD_LOCATION,BANKED
	clrf	RECORD_LOCATION_H,BANKED
;SDLocation_Last=Address_Sector+SD_Counter2/16
	movff	SD_COUNTER2,SysWORDTempA
	movff	SD_COUNTER2_H,SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	call	SysDivSub16
	movf	SysWORDTempA,W,ACCESS
	addwf	ADDRESS_SECTOR,W,ACCESS
	banksel	SDLOCATION_LAST
	movwf	SDLOCATION_LAST,BANKED
	movf	SysWORDTempA_H,W,ACCESS
	addwfc	ADDRESS_SECTOR_H,W,ACCESS
	movwf	SDLOCATION_LAST_H,BANKED
	movlw	0
	addwfc	ADDRESS_SECTOR_U,W,ACCESS
	movwf	SDLOCATION_LAST_U,BANKED
	movlw	0
	addwfc	ADDRESS_SECTOR_E,W,ACCESS
	movwf	SDLOCATION_LAST_E,BANKED
;SDRead_Block(SDLocation_Last)
	movff	SDLOCATION_LAST,BLOCK_START
	movff	SDLOCATION_LAST_H,BLOCK_START_H
	movff	SDLOCATION_LAST_U,BLOCK_START_U
	movff	SDLOCATION_LAST_E,BLOCK_START_E
	banksel	0
	call	SDREAD_BLOCK
;end if
ENDIF119
;B0=SDDataBuffer(Record_Location)
	lfsr	0,SDDATABUFFER
	banksel	RECORD_LOCATION
	movf	RECORD_LOCATION,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	RECORD_LOCATION_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movffl	INDF0,B0
	clrf	B0_H,ACCESS
	clrf	B0_U,ACCESS
	clrf	B0_E,ACCESS
;Loop
	goto	SysDoLoop_S17
SysDoLoop_E17
;Record_location_Last=Record_Location
	movff	RECORD_LOCATION,RECORD_LOCATION_LAST
	movff	RECORD_LOCATION_H,RECORD_LOCATION_LAST_H
;If Boot_Flag=1 then                      'NOTA: Per la presenza di BOOT,
	decf	BOOT_FLAG,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF120
;ind2=ind2-1                            ' le Info del file n-mo
	banksel	IND2
	decf	IND2,F,BANKED
;For ind1=1 to ind2                     ' in File_Record sono nell'elemento
	clrf	IND1,BANKED
	movlw	1
	subwf	IND2,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd17
SysForLoop17
	incf	IND1,F,BANKED
;File_Record(ind1)=File_Record(ind1+1)' (n+1)-mo. Con queste istruzione
	lfsr	0,FILE_RECORD
	movf	IND1,W,BANKED
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
	movffl	POSTINC0,SysArrayTemp2
	movff	SysArrayTemp2,SysArrayTemp1
	lfsr	0,FILE_RECORD
	movf	IND1,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movffl	SysArrayTemp1,POSTINC0
;Next                                   ' le si riportano all-n-mo
	movf	IND2,W,BANKED
	subwf	IND1,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop17
SysForLoopEnd17
;End If
ENDIF120
;if SD_Counter2>15 then
	movff	SD_COUNTER2,SysWORDTempB
	movff	SD_COUNTER2_H,SysWORDTempB_H
	movlw	15
	movwf	SysWORDTempA,ACCESS
	clrf	SysWORDTempA_H,ACCESS
	banksel	0
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF121
;SDRead_Block(Address_Sector) 'Necessario per ripristinare il buffer iniziale
	movff	ADDRESS_SECTOR,BLOCK_START
	movff	ADDRESS_SECTOR_H,BLOCK_START_H
	movff	ADDRESS_SECTOR_U,BLOCK_START_U
	movff	ADDRESS_SECTOR_E,BLOCK_START_E
	call	SDREAD_BLOCK
;'Naturalmente la poca RAM non consente di fare
;end if                           'diversamente
ENDIF121
;Draw_Line(1,60,"-"):Draw_Line(1,60," ")
	movlw	1
	banksel	LINE_TYPE
	movwf	LINE_TYPE,BANKED
	movlw	60
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable33
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable33
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable33
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	call	DRAW_LINE
	movlw	1
	banksel	LINE_TYPE
	movwf	LINE_TYPE,BANKED
	movlw	60
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	goto	DRAW_LINE

;********************************************************************************

;Source: epd_epd2in13d.h (609)
DRAWCHAR_EPD2IN13D
;dim oldGLCDBackground, oldGLCDForeground, LineColourToggled as bit
;This has got a tad complex
;We have three major pieces
;1 The preamble - this just adjusted color and the input character
;2 The code that deals with GCB fontset
;3 The code that deals with OLED fontset
;
;You can make independent change to section 2 and 3 but they are mutual exclusive with many common pieces
;invert colors if required
;if LineColour <> GLCDForeground  then
	movff	LINECOLOUR,SysWORDTempA
	movff	LINECOLOUR_H,SysWORDTempA_H
	movff	GLCDFOREGROUND,SysWORDTempB
	movff	GLCDFOREGROUND_H,SysWORDTempB_H
	call	SysCompEqual16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE143_1
;Inverted Colours
;oldGLCDBackground = GLCDBackground
	banksel	SYSBITVAR0
	bcf	SYSBITVAR0,2,BANKED
	banksel	GLCDBACKGROUND
	btfss	GLCDBACKGROUND,0,BANKED
	bra	ENDIF153
	banksel	SYSBITVAR0
	bsf	SYSBITVAR0,2,BANKED
ENDIF153
;oldGLCDForeground = GLCDForeground
	banksel	SYSBITVAR0
	bcf	SYSBITVAR0,3,BANKED
	banksel	GLCDFOREGROUND
	btfss	GLCDFOREGROUND,0,BANKED
	bra	ENDIF154
	banksel	SYSBITVAR0
	bsf	SYSBITVAR0,3,BANKED
ENDIF154
;GLCDForeground = LineColour
	movff	LINECOLOUR,GLCDFOREGROUND
	movff	LINECOLOUR_H,GLCDFOREGROUND_H
;GLCDBackground = oldGLCDForeground
	banksel	GLCDBACKGROUND
	clrf	GLCDBACKGROUND,BANKED
	clrf	GLCDBACKGROUND_H,BANKED
	banksel	SYSBITVAR0
	btfss	SYSBITVAR0,3,BANKED
	bra	ENDIF155
	banksel	GLCDBACKGROUND
	incf	GLCDBACKGROUND,F,BANKED
ENDIF155
;LineColourToggled = 1
	banksel	SYSBITVAR0
	bsf	SYSBITVAR0,4,BANKED
;else
	bra	ENDIF143
ELSE143_1
;LineColourToggled = 0
	banksel	SYSBITVAR0
	bcf	SYSBITVAR0,4,BANKED
;end if
ENDIF143
;dim CharCol, CharRow, GLCDTemp as word
;CharCode -= 15
	movlw	15
	subwf	CHARCODE,F,ACCESS
;CharCode needs to have 15 subtracted, table starts at char 16 not char 0
;CharCol=0
	clrf	CHARCOL,ACCESS
	clrf	CHARCOL_H,ACCESS
;if CharCode>=178 and CharCode<=202 then
	movff	CHARCODE,SysBYTETempA
	movlw	178
	movwf	SysBYTETempB,ACCESS
	banksel	0
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp3
	movff	CHARCODE,SysBYTETempB
	movlw	202
	movwf	SysBYTETempA,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	banksel	SYSTEMP3
	movf	SysTemp3,W,BANKED
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp4,BANKED
	btfss	SysTemp4,0,BANKED
	bra	ENDIF144
;CharLocY=CharLocY-1
	movlw	1
	subwf	CHARLOCY,F,ACCESS
	movlw	0
	subwfb	CHARLOCY_H,F,ACCESS
;end if
ENDIF144
;For CurrCharCol = 1 to 5
	clrf	CURRCHARCOL,ACCESS
SysForLoop23
	incf	CURRCHARCOL,F,ACCESS
;Select Case CurrCharCol
;Case 1: ReadTable GLCDCharCol3, CharCode, CurrCharVal
SysSelect4Case1
	decf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case2
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	call	GLCDCHARCOL3EXTENDED1
	movwf	CURRCHARVAL,ACCESS
;Case 2: ReadTable GLCDCharCol4, CharCode, CurrCharVal
	bra	SysSelectEnd4
SysSelect4Case2
	movlw	2
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case3
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	call	GLCDCHARCOL4EXTENDED1
	movwf	CURRCHARVAL,ACCESS
;Case 3: ReadTable GLCDCharCol5, CharCode, CurrCharVal
	bra	SysSelectEnd4
SysSelect4Case3
	movlw	3
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case4
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	call	GLCDCHARCOL5EXTENDED1
	movwf	CURRCHARVAL,ACCESS
;Case 4: ReadTable GLCDCharCol6, CharCode, CurrCharVal
	bra	SysSelectEnd4
SysSelect4Case4
	movlw	4
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelect4Case5
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	call	GLCDCHARCOL6EXTENDED1
	movwf	CURRCHARVAL,ACCESS
;Case 5: ReadTable GLCDCharCol7, CharCode, CurrCharVal
	bra	SysSelectEnd4
SysSelect4Case5
	movlw	5
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd4
	movff	CHARCODE,SYSSTRINGA
	banksel	0
	call	GLCDCHARCOL7EXTENDED1
	movwf	CURRCHARVAL,ACCESS
;End Select
SysSelectEnd4
;CharRow=0
	clrf	CHARROW,ACCESS
	clrf	CHARROW_H,ACCESS
;For CurrCharRow = 1 to 8
	clrf	CURRCHARROW,ACCESS
SysForLoop24
	incf	CURRCHARROW,F,ACCESS
;CharColS=0
	clrf	CHARCOLS,ACCESS
;For Col=1 to GLCDfntDefaultsize
	clrf	COL,ACCESS
	movlw	1
	banksel	GLCDFNTDEFAULTSIZE
	subwf	GLCDFNTDEFAULTSIZE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd25
SysForLoop25
	incf	COL,F,ACCESS
;CharColS +=1
	incf	CHARCOLS,F,ACCESS
;CharRowS=0
	clrf	CHARROWS,ACCESS
;For Row=1 to GLCDfntDefaultsize
	banksel	ROW
	clrf	ROW,BANKED
	movlw	1
	banksel	GLCDFNTDEFAULTSIZE
	subwf	GLCDFNTDEFAULTSIZE,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd26
SysForLoop26
	banksel	ROW
	incf	ROW,F,BANKED
;CharRowS +=1
	incf	CHARROWS,F,ACCESS
;if CurrCharVal.0=1 then
	btfss	CURRCHARVAL,0,ACCESS
	bra	ELSE147_1
;PSet([word]CharLocX + CharCol+ CharColS, [word]CharLocY + CharRow+CharRowS, LineColour)
	movf	CHARCOL,W,ACCESS
	addwf	CHARLOCX,W,ACCESS
	movwf	SysTemp1,BANKED
	movf	CHARCOL_H,W,ACCESS
	addwfc	CHARLOCX_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movf	CHARCOLS,W,ACCESS
	addwf	SysTemp1,W,BANKED
	banksel	GLCDX
	movwf	GLCDX,BANKED
	movlw	0
	banksel	SYSTEMP1_H
	addwfc	SysTemp1_H,W,BANKED
	banksel	GLCDX_H
	movwf	GLCDX_H,BANKED
	movf	CHARROW,W,ACCESS
	addwf	CHARLOCY,W,ACCESS
	banksel	SYSTEMP1
	movwf	SysTemp1,BANKED
	movf	CHARROW_H,W,ACCESS
	addwfc	CHARLOCY_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movf	CHARROWS,W,ACCESS
	addwf	SysTemp1,W,BANKED
	banksel	GLCDY
	movwf	GLCDY,BANKED
	movlw	0
	banksel	SYSTEMP1_H
	addwfc	SysTemp1_H,W,BANKED
	banksel	GLCDY_H
	movwf	GLCDY_H,BANKED
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;Else
	bra	ENDIF147
ELSE147_1
;PSet([word]CharLocX + CharCol+ CharColS, [word]CharLocY + CharRow+CharRowS, GLCDBACKGROUND)
	movf	CHARCOL,W,ACCESS
	addwf	CHARLOCX,W,ACCESS
	movwf	SysTemp1,BANKED
	movf	CHARCOL_H,W,ACCESS
	addwfc	CHARLOCX_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movf	CHARCOLS,W,ACCESS
	addwf	SysTemp1,W,BANKED
	banksel	GLCDX
	movwf	GLCDX,BANKED
	movlw	0
	banksel	SYSTEMP1_H
	addwfc	SysTemp1_H,W,BANKED
	banksel	GLCDX_H
	movwf	GLCDX_H,BANKED
	movf	CHARROW,W,ACCESS
	addwf	CHARLOCY,W,ACCESS
	banksel	SYSTEMP1
	movwf	SysTemp1,BANKED
	movf	CHARROW_H,W,ACCESS
	addwfc	CHARLOCY_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movf	CHARROWS,W,ACCESS
	addwf	SysTemp1,W,BANKED
	banksel	GLCDY
	movwf	GLCDY,BANKED
	movlw	0
	banksel	SYSTEMP1_H
	addwfc	SysTemp1_H,W,BANKED
	banksel	GLCDY_H
	movwf	GLCDY_H,BANKED
	movff	GLCDBACKGROUND,GLCDCOLOUR
	movff	GLCDBACKGROUND_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;End if
ENDIF147
;Next Row
	movf	GLCDFNTDEFAULTSIZE,W,BANKED
	banksel	ROW
	subwf	ROW,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop26
SysForLoopEnd26
;Next Col
	banksel	GLCDFNTDEFAULTSIZE
	movf	GLCDFNTDEFAULTSIZE,W,BANKED
	subwf	COL,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop25
SysForLoopEnd25
;Rotate CurrCharVal Right
	rrcf	CURRCHARVAL,F,ACCESS
;CharRow +=GLCDfntDefaultsize
	movf	GLCDFNTDEFAULTSIZE,W,BANKED
	addwf	CHARROW,F,ACCESS
	movlw	0
	addwfc	CHARROW_H,F,ACCESS
;Next
	movlw	8
	subwf	CURRCHARROW,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop24
SysForLoopEnd24
;CharCol +=GLCDfntDefaultsize
	movf	GLCDFNTDEFAULTSIZE,W,BANKED
	addwf	CHARCOL,F,ACCESS
	movlw	0
	addwfc	CHARCOL_H,F,ACCESS
;Next
	movlw	5
	subwf	CURRCHARCOL,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoop23
SysForLoopEnd23
;invert colors if required
;if LineColourToggled = 1  then
	banksel	SYSBITVAR0
	btfss	SYSBITVAR0,4,BANKED
	bra	ENDIF152
;GLCDForeground = oldGLCDForeground
	banksel	GLCDFOREGROUND
	clrf	GLCDFOREGROUND,BANKED
	clrf	GLCDFOREGROUND_H,BANKED
	banksel	SYSBITVAR0
	btfss	SYSBITVAR0,3,BANKED
	bra	ENDIF156
	banksel	GLCDFOREGROUND
	incf	GLCDFOREGROUND,F,BANKED
ENDIF156
;GLCDBackground = oldGLCDBackground
	banksel	GLCDBACKGROUND
	clrf	GLCDBACKGROUND,BANKED
	clrf	GLCDBACKGROUND_H,BANKED
	banksel	SYSBITVAR0
	btfss	SYSBITVAR0,2,BANKED
	bra	ENDIF157
	banksel	GLCDBACKGROUND
	incf	GLCDBACKGROUND,F,BANKED
ENDIF157
;end if
ENDIF152
	banksel	0
	return

;********************************************************************************

;Source: glcd.h (3488)
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
	movf	FILLED_ELLIPSE,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE48_1
;Draw_Ellipse_Points
	rcall	DRAW_ELLIPSE_POINTS
;ELSE
	bra	ENDIF48
ELSE48_1
;Draw_Filled_Ellipse_Points
	rcall	DRAW_FILLED_ELLIPSE_POINTS
;END IF
ENDIF48
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
	bra	ENDIF49
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
ENDIF49
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
	movf	FILLED_ELLIPSE,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE50_1
;Draw_Ellipse_Points
	rcall	DRAW_ELLIPSE_POINTS
;ELSE
	bra	ENDIF50
ELSE50_1
;Draw_Filled_Ellipse_Points
	rcall	DRAW_FILLED_ELLIPSE_POINTS
;END IF
ENDIF50
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
	bra	ENDIF51
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
ENDIF51
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
	movf	FILLED_ELLIPSE,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE52_1
;Draw_Ellipse_Points
	rcall	DRAW_ELLIPSE_POINTS
;ELSE
	bra	ENDIF52
ELSE52_1
;Draw_Filled_Ellipse_Points
	rcall	DRAW_FILLED_ELLIPSE_POINTS
;END IF
ENDIF52
;LOOP
	bra	SysDoLoop_S5
SysDoLoop_E5
	return

;********************************************************************************

;Source: epd_epd2in13d.h (581)
DRAWSTRING_EPD2IN13D
;dim GLCDPrintLoc as word
;GLCDPrintLoc = StringLocX
	movff	STRINGLOCX,GLCDPRINTLOC
	movff	STRINGLOCX_H,GLCDPRINTLOC_H
;for xchar = 1 to Chars(0)
	banksel	XCHAR
	clrf	XCHAR,BANKED
	movffl	SysCHARSHandler,AFSR0
	movffl	SysCHARSHandler_H,AFSR0_H
	movlw	1
	subwf	INDF0,W,ACCESS
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd22
SysForLoop22
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
;Macro Source: glcd.h (1090)
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize )+1
	movf	GLCDFONTWIDTH,W,BANKED
	mulwf	GLCDFNTDEFAULTSIZE,BANKED
	movffl	PRODL,SysTemp3
	banksel	SYSTEMP3
	movf	SysTemp3,W,BANKED
	banksel	GLCDPRINTLOC
	addwf	GLCDPRINTLOC,W,BANKED
	banksel	SYSTEMP1
	movwf	SysTemp1,BANKED
	movlw	0
	banksel	GLCDPRINTLOC_H
	addwfc	GLCDPRINTLOC_H,W,BANKED
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H,BANKED
	movlw	1
	addwf	SysTemp1,W,BANKED
	banksel	GLCDPRINTLOC
	movwf	GLCDPRINTLOC,BANKED
	movlw	0
	banksel	SYSTEMP1_H
	addwfc	SysTemp1_H,W,BANKED
	banksel	GLCDPRINTLOC_H
	movwf	GLCDPRINTLOC_H,BANKED
;next
	movffl	SysCHARSHandler,AFSR0
	movffl	SysCHARSHandler_H,AFSR0_H
	movf	INDF0,W,ACCESS
	banksel	XCHAR
	subwf	XCHAR,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop22
SysForLoopEnd22
	banksel	0
	return

;********************************************************************************

;Source: glcd.h (3624)
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

;Source: glcd.h (3633)
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
	banksel	YOFFSET
	addwf	YOFFSET,W,BANKED
	banksel	SYSTEMP1
	movwf	SysTemp1,BANKED
	movff	YOFFSET,SysBYTETempB
	movff	SysTemp1,SysBYTETempA
	banksel	0
	call	SysCompLessThan
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd9
SysForLoop9
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
	banksel	YOFFSET
	addwf	YOFFSET,W,BANKED
	banksel	SYSTEMP1
	movwf	SysTemp1,BANKED
	movff	GLCD_YY1,SysBYTETempA
	movff	SysTemp1,SysBYTETempB
	banksel	0
	call	SysCompLessThan
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop9
SysForLoopEnd9
	return

;********************************************************************************

;Source: Sertxd.h (77)
DRAW_LINE
;If N_Char <100 then
	movlw	100
	banksel	N_CHAR
	subwf	N_CHAR,W,BANKED
	btfsc	STATUS, C,ACCESS
	bra	ELSE27_1
;HSerPrintCRLF 1
	movlw	1
	banksel	HSERPRINTCRLFCOUNT
	movwf	HSERPRINTCRLFCOUNT,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
;else
	bra	ENDIF27
ELSE27_1
;N_Char=N_Char-100
	movlw	100
	subwf	N_CHAR,F,BANKED
;end if
ENDIF27
;Select Case Line_Type
;Case 1
SysSelect2Case1
	banksel	LINE_TYPE
	decf	LINE_TYPE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect2Case2
;repeat N_Char
	movff	N_CHAR,SysRepeatTemp1
	movf	SYSREPEATTEMP1,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd1
SysRepeatLoop1
;HSerprint Char
	movff	SysCHARHandler,SysPRINTDATAHandler
	movff	SysCHARHandler_H,SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT,ACCESS
	banksel	0
	call	HSERPRINT716
;end repeat
	banksel	SYSREPEATTEMP1
	decfsz	SysRepeatTemp1,F,BANKED
	bra	SysRepeatLoop1
SysRepeatLoopEnd1
;Case 2
	bra	SysSelectEnd2
SysSelect2Case2
	movlw	2
	subwf	LINE_TYPE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd2
;repeat N_Char
	movff	N_CHAR,SysRepeatTemp1
	movf	SYSREPEATTEMP1,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd2
SysRepeatLoop2
;HSerprint Char
	movff	SysCHARHandler,SysPRINTDATAHandler
	movff	SysCHARHandler_H,SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT,ACCESS
	banksel	0
	call	HSERPRINT716
;HSerPrint " "
	lfsr	1,SYSSTRINGPARAM18
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM18
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM18
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
	banksel	0
	call	HSERPRINT716
;end repeat
	banksel	SYSREPEATTEMP1
	decfsz	SysRepeatTemp1,F,BANKED
	bra	SysRepeatLoop2
SysRepeatLoopEnd2
;End Select
SysSelectEnd2
	banksel	0
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

;Source: epd_epd2in13d.h (873)
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
	bra	ENDIF169
;GLCDTemp = LineX1
	movff	LINEX1,GLCDTEMP
;LineX1 = LineX2
	movff	LINEX2,LINEX1
	movff	LINEX2_H,LINEX1_H
;LineX2 = GLCDTemp
	movff	GLCDTEMP,LINEX2
	banksel	LINEX2_H
	clrf	LINEX2_H,BANKED
;End If
ENDIF169
;If LineY1 > LineY2 Then
	movff	LINEY1,SysWORDTempB
	movff	LINEY1_H,SysWORDTempB_H
	movff	LINEY2,SysWORDTempA
	movff	LINEY2_H,SysWORDTempA_H
	banksel	0
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF170
;GLCDTemp = LineY1
	movff	LINEY1,GLCDTEMP
;LineY1 = LineY2
	movff	LINEY2,LINEY1
	movff	LINEY2_H,LINEY1_H
;LineY2 = GLCDTemp
	movff	GLCDTEMP,LINEY2
	banksel	LINEY2_H
	clrf	LINEY2_H,BANKED
;End If
ENDIF170
;for EPD_Ind_raw=LineY1  to LineY2
	movlw	1
	banksel	LINEY1
	subwf	LINEY1,W,BANKED
	banksel	EPD_IND_RAW
	movwf	EPD_IND_RAW,BANKED
	movlw	0
	banksel	LINEY1_H
	subwfb	LINEY1_H,W,BANKED
	banksel	EPD_IND_RAW_H
	movwf	EPD_IND_RAW_H,BANKED
	movff	LINEY1,SysWORDTempB
	movff	LINEY1_H,SysWORDTempB_H
	movff	LINEY2,SysWORDTempA
	movff	LINEY2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd27
SysForLoop27
	incf	EPD_IND_RAW,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	EPD_IND_RAW_H,F,BANKED
;for EPD_Ind_col=LineX1 to lineX2
	movlw	1
	banksel	LINEX1
	subwf	LINEX1,W,BANKED
	banksel	EPD_IND_COL
	movwf	EPD_IND_COL,BANKED
	movlw	0
	banksel	LINEX1_H
	subwfb	LINEX1_H,W,BANKED
	banksel	EPD_IND_COL_H
	movwf	EPD_IND_COL_H,BANKED
	movff	LINEX1,SysWORDTempB
	movff	LINEX1_H,SysWORDTempB_H
	movff	LINEX2,SysWORDTempA
	movff	LINEX2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd28
SysForLoop28
	incf	EPD_IND_COL,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	EPD_IND_COL_H,F,BANKED
;PSet(EPD_Ind_Col, EPD_Ind_raw, LineColour)
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

;Source: glcd.h (1435)
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
	banksel	FF
	movwf	FF,BANKED
	movlw	0
	banksel	SYSTEMP1
	movwf	SysTemp1,BANKED
	movf	XRADIUS_H,W,BANKED
	subwfb	SysTemp1,W,BANKED
	banksel	FF_H
	movwf	FF_H,BANKED
;ddF_x = 1
	movlw	1
	movwf	DDF_X,BANKED
	clrf	DDF_X_H,BANKED
;ddF_y = -2 * xradius
	movff	XRADIUS,SysINTEGERTempA
	movff	XRADIUS_H,SysINTEGERTempA_H
	movlw	254
	movwf	SysINTEGERTempB,ACCESS
	setf	SysINTEGERTempB_H,ACCESS
	call	SysMultSubINT
	movff	SysINTEGERTempX,DDF_Y
	movff	SysINTEGERTempX_H,DDF_Y_H
;FillCircleXX = 0
	clrf	FILLCIRCLEXX,BANKED
;FillCircleYY = xradius
	movff	XRADIUS,FILLCIRCLEYY
;Fill in the center between the two halves
;YCalc2 = yoffset+xradius
	banksel	XRADIUS
	movf	XRADIUS,W,BANKED
	banksel	YOFFSET
	addwf	YOFFSET,W,BANKED
	movwf	YCALC2,BANKED
	banksel	XRADIUS_H
	movf	XRADIUS_H,W,BANKED
	banksel	YOFFSET_H
	addwfc	YOFFSET_H,W,BANKED
	movwf	YCALC2_H,BANKED
;YCalc1 = yoffset-xradius
	banksel	XRADIUS
	movf	XRADIUS,W,BANKED
	banksel	YOFFSET
	subwf	YOFFSET,W,BANKED
	banksel	YCALC1
	movwf	YCALC1,BANKED
	movf	XRADIUS_H,W,BANKED
	banksel	YOFFSET_H
	subwfb	YOFFSET_H,W,BANKED
	banksel	YCALC1_H
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
	movf	FILLCIRCLEYY,W,BANKED
	subwf	FILLCIRCLEXX,W,BANKED
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
	bra	ENDIF35
;FillCircleYY--
	decf	FILLCIRCLEYY,F,BANKED
;ddF_y += 2
	movlw	2
	addwf	DDF_Y,F,BANKED
	movlw	0
	addwfc	DDF_Y_H,F,BANKED
;ff += ddF_y
	movf	DDF_Y,W,BANKED
	addwf	FF,F,BANKED
	movf	DDF_Y_H,W,BANKED
	addwfc	FF_H,F,BANKED
;end if
ENDIF35
;FillCircleXX++
	incf	FILLCIRCLEXX,F,BANKED
;ddF_x += 2
	movlw	2
	addwf	DDF_X,F,BANKED
	movlw	0
	addwfc	DDF_X_H,F,BANKED
;ff += ddF_x
	movf	DDF_X,W,BANKED
	addwf	FF,F,BANKED
	movf	DDF_X_H,W,BANKED
	addwfc	FF_H,F,BANKED
;Now draw vertical lines between the points on the circle rather than
;draw the points of the circle. This draws lines between the
;perimeter points on the upper and lower quadrants of the 2 halves of the circle.
;Line(xoffset+FillCircleXX, yoffset+FillCircleYY, xoffset+FillCircleXX, yoffset-FillCircleYY, LineColour);
	movf	FILLCIRCLEXX,W,BANKED
	banksel	XOFFSET
	addwf	XOFFSET,W,BANKED
	movwf	LINEX1,BANKED
	movlw	0
	addwfc	XOFFSET_H,W,BANKED
	movwf	LINEX1_H,BANKED
	banksel	FILLCIRCLEYY
	movf	FILLCIRCLEYY,W,BANKED
	banksel	YOFFSET
	addwf	YOFFSET,W,BANKED
	banksel	LINEY1
	movwf	LINEY1,BANKED
	movlw	0
	banksel	YOFFSET_H
	addwfc	YOFFSET_H,W,BANKED
	banksel	LINEY1_H
	movwf	LINEY1_H,BANKED
	banksel	FILLCIRCLEXX
	movf	FILLCIRCLEXX,W,BANKED
	banksel	XOFFSET
	addwf	XOFFSET,W,BANKED
	movwf	LINEX2,BANKED
	movlw	0
	addwfc	XOFFSET_H,W,BANKED
	movwf	LINEX2_H,BANKED
	banksel	FILLCIRCLEYY
	movf	FILLCIRCLEYY,W,BANKED
	banksel	YOFFSET
	subwf	YOFFSET,W,BANKED
	banksel	LINEY2
	movwf	LINEY2,BANKED
	movlw	0
	banksel	YOFFSET_H
	subwfb	YOFFSET_H,W,BANKED
	banksel	LINEY2_H
	movwf	LINEY2_H,BANKED
	banksel	0
	call	LINE
;Line(xoffset-FillCircleXX, yoffset+FillCircleYY, xoffset-FillCircleXX, yoffset-FillCircleYY, LineColour);
	movf	FILLCIRCLEXX,W,BANKED
	banksel	XOFFSET
	subwf	XOFFSET,W,BANKED
	movwf	LINEX1,BANKED
	movlw	0
	subwfb	XOFFSET_H,W,BANKED
	movwf	LINEX1_H,BANKED
	banksel	FILLCIRCLEYY
	movf	FILLCIRCLEYY,W,BANKED
	banksel	YOFFSET
	addwf	YOFFSET,W,BANKED
	banksel	LINEY1
	movwf	LINEY1,BANKED
	movlw	0
	banksel	YOFFSET_H
	addwfc	YOFFSET_H,W,BANKED
	banksel	LINEY1_H
	movwf	LINEY1_H,BANKED
	banksel	FILLCIRCLEXX
	movf	FILLCIRCLEXX,W,BANKED
	banksel	XOFFSET
	subwf	XOFFSET,W,BANKED
	movwf	LINEX2,BANKED
	movlw	0
	subwfb	XOFFSET_H,W,BANKED
	movwf	LINEX2_H,BANKED
	banksel	FILLCIRCLEYY
	movf	FILLCIRCLEYY,W,BANKED
	banksel	YOFFSET
	subwf	YOFFSET,W,BANKED
	banksel	LINEY2
	movwf	LINEY2,BANKED
	movlw	0
	banksel	YOFFSET_H
	subwfb	YOFFSET_H,W,BANKED
	banksel	LINEY2_H
	movwf	LINEY2_H,BANKED
	banksel	0
	call	LINE
;Line(xoffset+FillCircleYY, yoffset+FillCircleXX, FillCircleYY+xoffset, yoffset-FillCircleXX, LineColour);
	movf	FILLCIRCLEYY,W,BANKED
	banksel	XOFFSET
	addwf	XOFFSET,W,BANKED
	movwf	LINEX1,BANKED
	movlw	0
	addwfc	XOFFSET_H,W,BANKED
	movwf	LINEX1_H,BANKED
	banksel	FILLCIRCLEXX
	movf	FILLCIRCLEXX,W,BANKED
	banksel	YOFFSET
	addwf	YOFFSET,W,BANKED
	banksel	LINEY1
	movwf	LINEY1,BANKED
	movlw	0
	banksel	YOFFSET_H
	addwfc	YOFFSET_H,W,BANKED
	banksel	LINEY1_H
	movwf	LINEY1_H,BANKED
	movf	XOFFSET,W,BANKED
	banksel	FILLCIRCLEYY
	addwf	FILLCIRCLEYY,W,BANKED
	banksel	LINEX2
	movwf	LINEX2,BANKED
	clrf	SysTemp1,BANKED
	movf	XOFFSET_H,W,BANKED
	addwfc	SysTemp1,W,BANKED
	movwf	LINEX2_H,BANKED
	banksel	FILLCIRCLEXX
	movf	FILLCIRCLEXX,W,BANKED
	banksel	YOFFSET
	subwf	YOFFSET,W,BANKED
	banksel	LINEY2
	movwf	LINEY2,BANKED
	movlw	0
	banksel	YOFFSET_H
	subwfb	YOFFSET_H,W,BANKED
	banksel	LINEY2_H
	movwf	LINEY2_H,BANKED
	banksel	0
	call	LINE
;Line(xoffset-FillCircleYY, yoffset+FillCircleXX, xoffset-FillCircleYY, yoffset-FillCircleXX, LineColour);
	movf	FILLCIRCLEYY,W,BANKED
	banksel	XOFFSET
	subwf	XOFFSET,W,BANKED
	movwf	LINEX1,BANKED
	movlw	0
	subwfb	XOFFSET_H,W,BANKED
	movwf	LINEX1_H,BANKED
	banksel	FILLCIRCLEXX
	movf	FILLCIRCLEXX,W,BANKED
	banksel	YOFFSET
	addwf	YOFFSET,W,BANKED
	banksel	LINEY1
	movwf	LINEY1,BANKED
	movlw	0
	banksel	YOFFSET_H
	addwfc	YOFFSET_H,W,BANKED
	banksel	LINEY1_H
	movwf	LINEY1_H,BANKED
	banksel	FILLCIRCLEYY
	movf	FILLCIRCLEYY,W,BANKED
	banksel	XOFFSET
	subwf	XOFFSET,W,BANKED
	movwf	LINEX2,BANKED
	movlw	0
	subwfb	XOFFSET_H,W,BANKED
	movwf	LINEX2_H,BANKED
	banksel	FILLCIRCLEXX
	movf	FILLCIRCLEXX,W,BANKED
	banksel	YOFFSET
	subwf	YOFFSET,W,BANKED
	banksel	LINEY2
	movwf	LINEY2,BANKED
	movlw	0
	banksel	YOFFSET_H
	subwfb	YOFFSET_H,W,BANKED
	banksel	LINEY2_H
	movwf	LINEY2_H,BANKED
	banksel	0
	call	LINE
;loop
	bra	SysDoLoop_S1
SysDoLoop_E1
	return

;********************************************************************************

;Source: glcd.h (3476)
FILLEDELLIPSE
;Version 1.00 (08/20/2017) by Joseph Realmuto
;draws a filled ellipse at location (xoffset, yoffset)
;Inxradius is x radius of ellipse
;Inyradius is y radius of ellipse
;filled_ellipse = 1
	movlw	1
	movwf	FILLED_ELLIPSE,BANKED
;DrawEllipseRoutine( xoffset, yoffset, Inxradius, Inyradius, LineColour )
	goto	DRAWELLIPSEROUTINE

;********************************************************************************

;Source: glcd.h (4075)
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
	bra	ENDIF81
;swap(yoffset, yoffset2)
	movff	YOFFSET,SYSCALCTEMPA
	movff	YOFFSET_H,SYSCALCTEMPA_H
	movff	YOFFSET2,SYSCALCTEMPB
	movff	YOFFSET2_H,SYSCALCTEMPB_H
	call	SWAP536
	movff	SYSCALCTEMPA,YOFFSET
	movff	SYSCALCTEMPA_H,YOFFSET_H
	movff	SYSCALCTEMPB,YOFFSET2
	movff	SYSCALCTEMPB_H,YOFFSET2_H
;swap(xoffset, xoffset2)
	movff	XOFFSET,SYSCALCTEMPA
	movff	XOFFSET_H,SYSCALCTEMPA_H
	movff	XOFFSET2,SYSCALCTEMPB
	movff	XOFFSET2_H,SYSCALCTEMPB_H
	call	SWAP536
	movff	SYSCALCTEMPA,XOFFSET
	movff	SYSCALCTEMPA_H,XOFFSET_H
	movff	SYSCALCTEMPB,XOFFSET2
	movff	SYSCALCTEMPB_H,XOFFSET2_H
;end if
ENDIF81
;if (yoffset2 > yoffset3) then
	movff	YOFFSET2,SysWORDTempB
	movff	YOFFSET2_H,SysWORDTempB_H
	movff	YOFFSET3,SysWORDTempA
	movff	YOFFSET3_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF82
;swap(yoffset3, yoffset2)
	movff	YOFFSET3,SYSCALCTEMPA
	movff	YOFFSET3_H,SYSCALCTEMPA_H
	movff	YOFFSET2,SYSCALCTEMPB
	movff	YOFFSET2_H,SYSCALCTEMPB_H
	call	SWAP536
	movff	SYSCALCTEMPA,YOFFSET3
	movff	SYSCALCTEMPA_H,YOFFSET3_H
	movff	SYSCALCTEMPB,YOFFSET2
	movff	SYSCALCTEMPB_H,YOFFSET2_H
;swap(xoffset3, xoffset2)
	movff	XOFFSET3,SYSCALCTEMPA
	movff	XOFFSET3_H,SYSCALCTEMPA_H
	movff	XOFFSET2,SYSCALCTEMPB
	movff	XOFFSET2_H,SYSCALCTEMPB_H
	call	SWAP536
	movff	SYSCALCTEMPA,XOFFSET3
	movff	SYSCALCTEMPA_H,XOFFSET3_H
	movff	SYSCALCTEMPB,XOFFSET2
	movff	SYSCALCTEMPB_H,XOFFSET2_H
;end if
ENDIF82
;if (yoffset > yoffset2) then
	movff	YOFFSET,SysWORDTempB
	movff	YOFFSET_H,SysWORDTempB_H
	movff	YOFFSET2,SysWORDTempA
	movff	YOFFSET2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF83
;swap(yoffset, yoffset2)
	movff	YOFFSET,SYSCALCTEMPA
	movff	YOFFSET_H,SYSCALCTEMPA_H
	movff	YOFFSET2,SYSCALCTEMPB
	movff	YOFFSET2_H,SYSCALCTEMPB_H
	call	SWAP536
	movff	SYSCALCTEMPA,YOFFSET
	movff	SYSCALCTEMPA_H,YOFFSET_H
	movff	SYSCALCTEMPB,YOFFSET2
	movff	SYSCALCTEMPB_H,YOFFSET2_H
;swap(xoffset, xoffset2)
	movff	XOFFSET,SYSCALCTEMPA
	movff	XOFFSET_H,SYSCALCTEMPA_H
	movff	XOFFSET2,SYSCALCTEMPB
	movff	XOFFSET2_H,SYSCALCTEMPB_H
	call	SWAP536
	movff	SYSCALCTEMPA,XOFFSET
	movff	SYSCALCTEMPA_H,XOFFSET_H
	movff	SYSCALCTEMPB,XOFFSET2
	movff	SYSCALCTEMPB_H,XOFFSET2_H
;end if
ENDIF83
;Handle awkward all-on-same-line case as its own thing
;if (yoffset = yoffset3) then
	movff	YOFFSET,SysWORDTempA
	movff	YOFFSET_H,SysWORDTempA_H
	movff	YOFFSET3,SysWORDTempB
	movff	YOFFSET3_H,SysWORDTempB_H
	call	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF84
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
	bra	ELSE92_1
;GLCD_aa = xoffset2
	movff	XOFFSET2,GLCD_AA
	movff	XOFFSET2_H,GLCD_AA_H
;else if (xoffset2 > GLCD_bb ) then
	bra	ENDIF92
ELSE92_1
	movff	XOFFSET2,SysWORDTempB
	movff	XOFFSET2_H,SysWORDTempB_H
	movff	GLCD_BB,SysWORDTempA
	movff	GLCD_BB_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF92
;GLCD_bb = xoffset2
	movff	XOFFSET2,GLCD_BB
	movff	XOFFSET2_H,GLCD_BB_H
;end if
ENDIF92
;if (xoffset3 < GLCD_aa) Then
	movff	XOFFSET3,SysWORDTempA
	movff	XOFFSET3_H,SysWORDTempA_H
	movff	GLCD_AA,SysWORDTempB
	movff	GLCD_AA_H,SysWORDTempB_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE93_1
;GLCD_aa = xoffset3
	movff	XOFFSET3,GLCD_AA
	movff	XOFFSET3_H,GLCD_AA_H
;else if ( xoffset3 > GLCD_bb) then
	bra	ENDIF93
ELSE93_1
	movff	XOFFSET3,SysWORDTempB
	movff	XOFFSET3_H,SysWORDTempB_H
	movff	GLCD_BB,SysWORDTempA
	movff	GLCD_BB_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF93
;GLCD_bb = xoffset3
	movff	XOFFSET3,GLCD_BB
	movff	XOFFSET3_H,GLCD_BB_H
;end if
ENDIF93
;Line( GLCD_aa, yoffset, GLCD_bb - GLCD_aa + 1, yoffset, LineColour)
	movff	GLCD_AA,LINEX1
	movff	GLCD_AA_H,LINEX1_H
	movff	YOFFSET,LINEY1
	movff	YOFFSET_H,LINEY1_H
	movf	GLCD_AA,W,BANKED
	subwf	GLCD_BB,W,BANKED
	banksel	SYSTEMP1
	movwf	SysTemp1,BANKED
	banksel	GLCD_AA_H
	movf	GLCD_AA_H,W,BANKED
	subwfb	GLCD_BB_H,W,BANKED
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H,BANKED
	movlw	1
	addwf	SysTemp1,W,BANKED
	movwf	LINEX2,BANKED
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	LINEX2_H,BANKED
	movff	YOFFSET,LINEY2
	movff	YOFFSET_H,LINEY2_H
	banksel	0
	call	LINE
;exit sub
	return
;end if
ENDIF84
;dim dxoffset01, dyoffset01, dxoffset02, dyoffset02, dxoffset12, dyoffset12, glcd_y as word
;dim glcd_sa, glcd_sb as Integer
;dxoffset01 = xoffset2 - xoffset
	banksel	XOFFSET
	movf	XOFFSET,W,BANKED
	subwf	XOFFSET2,W,BANKED
	banksel	DXOFFSET01
	movwf	DXOFFSET01,BANKED
	banksel	XOFFSET_H
	movf	XOFFSET_H,W,BANKED
	subwfb	XOFFSET2_H,W,BANKED
	banksel	DXOFFSET01_H
	movwf	DXOFFSET01_H,BANKED
;dyoffset01 = yoffset2 - yoffset
	banksel	YOFFSET
	movf	YOFFSET,W,BANKED
	subwf	YOFFSET2,W,BANKED
	banksel	DYOFFSET01
	movwf	DYOFFSET01,BANKED
	banksel	YOFFSET_H
	movf	YOFFSET_H,W,BANKED
	subwfb	YOFFSET2_H,W,BANKED
	banksel	DYOFFSET01_H
	movwf	DYOFFSET01_H,BANKED
;dxoffset02 = xoffset3 - xoffset
	banksel	XOFFSET
	movf	XOFFSET,W,BANKED
	subwf	XOFFSET3,W,BANKED
	banksel	DXOFFSET02
	movwf	DXOFFSET02,BANKED
	banksel	XOFFSET_H
	movf	XOFFSET_H,W,BANKED
	subwfb	XOFFSET3_H,W,BANKED
	banksel	DXOFFSET02_H
	movwf	DXOFFSET02_H,BANKED
;dyoffset02 = yoffset3 - yoffset
	banksel	YOFFSET
	movf	YOFFSET,W,BANKED
	subwf	YOFFSET3,W,BANKED
	banksel	DYOFFSET02
	movwf	DYOFFSET02,BANKED
	banksel	YOFFSET_H
	movf	YOFFSET_H,W,BANKED
	subwfb	YOFFSET3_H,W,BANKED
	banksel	DYOFFSET02_H
	movwf	DYOFFSET02_H,BANKED
;dxoffset12 = xoffset3 - xoffset2
	banksel	XOFFSET2
	movf	XOFFSET2,W,BANKED
	subwf	XOFFSET3,W,BANKED
	banksel	DXOFFSET12
	movwf	DXOFFSET12,BANKED
	banksel	XOFFSET2_H
	movf	XOFFSET2_H,W,BANKED
	subwfb	XOFFSET3_H,W,BANKED
	banksel	DXOFFSET12_H
	movwf	DXOFFSET12_H,BANKED
;dyoffset12 = yoffset3 - yoffset2
	banksel	YOFFSET2
	movf	YOFFSET2,W,BANKED
	subwf	YOFFSET3,W,BANKED
	banksel	DYOFFSET12
	movwf	DYOFFSET12,BANKED
	banksel	YOFFSET2_H
	movf	YOFFSET2_H,W,BANKED
	subwfb	YOFFSET3_H,W,BANKED
	banksel	DYOFFSET12_H
	movwf	DYOFFSET12_H,BANKED
;glcd_sa   = 0
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
	bra	ELSE85_1
;GLCD_last = yoffset2 ;   Include yoffset2 scanline
	movff	YOFFSET2,GLCD_LAST
	movff	YOFFSET2_H,GLCD_LAST_H
;else
	bra	ENDIF85
ELSE85_1
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
ENDIF85
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
	bra	SysForLoopEnd10
SysForLoop10
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
	movf	DXOFFSET01,W,BANKED
	addwf	GLCD_SA,F,BANKED
	movf	DXOFFSET01_H,W,BANKED
	addwfc	GLCD_SA_H,F,BANKED
;glcd_sb = glcd_sb + dxoffset02
	movf	DXOFFSET02,W,BANKED
	addwf	GLCD_SB,F,BANKED
	movf	DXOFFSET02_H,W,BANKED
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
	call	SWAP536
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
	movff	GLCD_LAST,SysWORDTempB
	movff	GLCD_LAST_H,SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop10
SysForLoopEnd10
;For lower part of triangle, find scanline crossings for segments
;0-2 and 1-2.  This loop is skipped if yoffset2=yoffset3.
;glcd_sa = dxoffset12 * (glcd_y - yoffset2);
	banksel	YOFFSET2
	movf	YOFFSET2,W,BANKED
	banksel	GLCD_Y
	subwf	GLCD_Y,W,BANKED
	banksel	SYSTEMP1
	movwf	SysTemp1,BANKED
	banksel	YOFFSET2_H
	movf	YOFFSET2_H,W,BANKED
	banksel	GLCD_Y_H
	subwfb	GLCD_Y_H,W,BANKED
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H,BANKED
	movff	DXOFFSET12,SysINTEGERTempA
	movff	DXOFFSET12_H,SysINTEGERTempA_H
	movff	SysTemp1,SysINTEGERTempB
	movff	SysTemp1_H,SysINTEGERTempB_H
	banksel	0
	call	SysMultSubINT
	movff	SysINTEGERTempX,GLCD_SA
	movff	SysINTEGERTempX_H,GLCD_SA_H
;glcd_sb = dxoffset02 * (glcd_y - yoffset);
	banksel	YOFFSET
	movf	YOFFSET,W,BANKED
	banksel	GLCD_Y
	subwf	GLCD_Y,W,BANKED
	banksel	SYSTEMP1
	movwf	SysTemp1,BANKED
	banksel	YOFFSET_H
	movf	YOFFSET_H,W,BANKED
	banksel	GLCD_Y_H
	subwfb	GLCD_Y_H,W,BANKED
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H,BANKED
	movff	DXOFFSET02,SysINTEGERTempA
	movff	DXOFFSET02_H,SysINTEGERTempA_H
	movff	SysTemp1,SysINTEGERTempB
	movff	SysTemp1_H,SysINTEGERTempB_H
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
	bra	SysForLoopEnd11
SysForLoop11
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
	movf	DXOFFSET12,W,BANKED
	addwf	GLCD_SA,F,BANKED
	movf	DXOFFSET12_H,W,BANKED
	addwfc	GLCD_SA_H,F,BANKED
;glcd_sb = glcd_sb + dxoffset02
	movf	DXOFFSET02,W,BANKED
	addwf	GLCD_SB,F,BANKED
	movf	DXOFFSET02_H,W,BANKED
	addwfc	GLCD_SB_H,F,BANKED
;if (glcd_aa > glcd_bb)  then
	movff	GLCD_AA,SysWORDTempB
	movff	GLCD_AA_H,SysWORDTempB_H
	movff	GLCD_BB,SysWORDTempA
	movff	GLCD_BB_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF90
;swap(glcd_aa, glcd_bb)
	movff	GLCD_AA,SYSCALCTEMPA
	movff	GLCD_AA_H,SYSCALCTEMPA_H
	movff	GLCD_BB,SYSCALCTEMPB
	movff	GLCD_BB_H,SYSCALCTEMPB_H
	call	SWAP536
	movff	SYSCALCTEMPA,GLCD_AA
	movff	SYSCALCTEMPA_H,GLCD_AA_H
	movff	SYSCALCTEMPB,GLCD_BB
	movff	SYSCALCTEMPB_H,GLCD_BB_H
;end if
ENDIF90
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
	bra	SysForLoop11
SysForLoopEnd11
	return

;********************************************************************************

;Source: glcd.h (1625)
FILLROUNDRECT
;Dim FRI as Word
;if RX1>RX2 then SWAP (RX1 , RX2)
	movff	RX1,SysWORDTempB
	movff	RX1_H,SysWORDTempB_H
	movff	RX2,SysWORDTempA
	movff	RX2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF41
	movff	RX1,SYSCALCTEMPA
	movff	RX1_H,SYSCALCTEMPA_H
	movff	RX2,SYSCALCTEMPB
	movff	RX2_H,SYSCALCTEMPB_H
	call	SWAP536
	movff	SYSCALCTEMPA,RX1
	movff	SYSCALCTEMPA_H,RX1_H
	movff	SYSCALCTEMPB,RX2
	movff	SYSCALCTEMPB_H,RX2_H
ENDIF41
;if RY1>RY2 then SWAP (RY1 , RY2)
	movff	RY1,SysWORDTempB
	movff	RY1_H,SysWORDTempB_H
	movff	RY2,SysWORDTempA
	movff	RY2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF42
	movff	RY1,SYSCALCTEMPA
	movff	RY1_H,SYSCALCTEMPA_H
	movff	RY2,SYSCALCTEMPB
	movff	RY2_H,SYSCALCTEMPB_H
	call	SWAP536
	movff	SYSCALCTEMPA,RY1
	movff	SYSCALCTEMPA_H,RY1_H
	movff	SYSCALCTEMPB,RY2
	movff	SYSCALCTEMPB_H,RY2_H
ENDIF42
;if (RX2-RX1>4) and (RY2-RY1>4) Then
	banksel	RX1
	movf	RX1,W,BANKED
	subwf	RX2,W,BANKED
	movwf	SysTemp1,BANKED
	movf	RX1_H,W,BANKED
	subwfb	RX2_H,W,BANKED
	movwf	SysTemp1_H,BANKED
	movff	SysTemp1,SysWORDTempB
	movff	SysTemp1_H,SysWORDTempB_H
	movlw	4
	movwf	SysWORDTempA,ACCESS
	clrf	SysWORDTempA_H,ACCESS
	banksel	0
	call	SysCompLessThan16
	movff	SysByteTempX,SysTemp2
	banksel	RY1
	movf	RY1,W,BANKED
	subwf	RY2,W,BANKED
	movwf	SysTemp1,BANKED
	movf	RY1_H,W,BANKED
	subwfb	RY2_H,W,BANKED
	movwf	SysTemp1_H,BANKED
	movff	SysTemp1,SysWORDTempB
	movff	SysTemp1_H,SysWORDTempB_H
	movlw	4
	movwf	SysWORDTempA,ACCESS
	clrf	SysWORDTempA_H,ACCESS
	banksel	0
	call	SysCompLessThan16
	movff	SysByteTempX,SysTemp3
	banksel	SYSTEMP2
	movf	SysTemp2,W,BANKED
	andwf	SysTemp3,W,BANKED
	movwf	SysTemp1,BANKED
	btfss	SysTemp1,0,BANKED
	bra	ENDIF43
;for FRI=0 to (RY2-RY1)/2
	banksel	FRI
	setf	FRI,BANKED
	setf	FRI_H,BANKED
	banksel	RY1
	movf	RY1,W,BANKED
	subwf	RY2,W,BANKED
	movwf	SysTemp1,BANKED
	movf	RY1_H,W,BANKED
	subwfb	RY2_H,W,BANKED
	movwf	SysTemp1_H,BANKED
	movff	SysTemp1,SysWORDTempA
	movff	SysTemp1_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	call	SysDivSub16
	movff	SysWORDTempA,SysTemp2
	movff	SysWORDTempA_H,SysTemp2_H
	clrf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	movff	SysTemp2,SysWORDTempA
	movff	SysTemp2_H,SysWORDTempA_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoopEnd8
SysForLoop8
	incf	FRI,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	FRI_H,F,BANKED
;Select Case FRI
;Case 0
SysSelect3Case1
	movff	FRI,SysWORDTempA
	movff	FRI_H,SysWORDTempA_H
	clrf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect3Case2
;Line RX1+3 , RY1 , RX2-3, RY1 , Color
	movlw	3
	banksel	RX1
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
	banksel	0
	call	LINE
;Line RX1+3 , RY2 , RX2-3, RY2 , Color
	movlw	3
	banksel	RX1
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
	banksel	0
	call	LINE
;Case 1
	bra	SysSelectEnd3
SysSelect3Case2
	movff	FRI,SysWORDTempA
	movff	FRI_H,SysWORDTempA_H
	movlw	1
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect3Case3
;Line RX1+2 , RY1+1 , RX2-2, RY1+1 , Color
	movlw	2
	banksel	RX1
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
	banksel	0
	call	LINE
;Line RX1+2 , RY2-1 , RX2-1, RY2-1 , Color
	movlw	2
	banksel	RX1
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
	banksel	0
	call	LINE
;Case 2
	bra	SysSelectEnd3
SysSelect3Case3
	movff	FRI,SysWORDTempA
	movff	FRI_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompEqual16
	btfss	SysByteTempX,0,ACCESS
	bra	SysSelect3Case4
;Line RX1+1 , RY1+2 , RX2-1, RY1+2 , Color
	movlw	1
	banksel	RX1
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
	banksel	0
	call	LINE
;Line RX1+1 , RY2-2 , RX2-1, RY2-2 , Color
	movlw	1
	banksel	RX1
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
	banksel	0
	call	LINE
;Case Else
	bra	SysSelectEnd3
SysSelect3Case4
;Line RX1 , RY1+FRI , RX2, RY1+FRI , Color
	movff	RX1,LINEX1
	movff	RX1_H,LINEX1_H
	movf	FRI,W,BANKED
	banksel	RY1
	addwf	RY1,W,BANKED
	movwf	LINEY1,BANKED
	banksel	FRI_H
	movf	FRI_H,W,BANKED
	banksel	RY1_H
	addwfc	RY1_H,W,BANKED
	movwf	LINEY1_H,BANKED
	movff	RX2,LINEX2
	movff	RX2_H,LINEX2_H
	banksel	FRI
	movf	FRI,W,BANKED
	banksel	RY1
	addwf	RY1,W,BANKED
	movwf	LINEY2,BANKED
	banksel	FRI_H
	movf	FRI_H,W,BANKED
	banksel	RY1_H
	addwfc	RY1_H,W,BANKED
	movwf	LINEY2_H,BANKED
	movff	COLOR,LINECOLOUR
	movff	COLOR_H,LINECOLOUR_H
	banksel	0
	call	LINE
;Line RX1 , RY2-FRI , RX2, RY2-FRI , Color
	movff	RX1,LINEX1
	movff	RX1_H,LINEX1_H
	movf	FRI,W,BANKED
	banksel	RY2
	subwf	RY2,W,BANKED
	movwf	LINEY1,BANKED
	banksel	FRI_H
	movf	FRI_H,W,BANKED
	banksel	RY2_H
	subwfb	RY2_H,W,BANKED
	movwf	LINEY1_H,BANKED
	movff	RX2,LINEX2
	movff	RX2_H,LINEX2_H
	banksel	FRI
	movf	FRI,W,BANKED
	banksel	RY2
	subwf	RY2,W,BANKED
	movwf	LINEY2,BANKED
	banksel	FRI_H
	movf	FRI_H,W,BANKED
	banksel	RY2_H
	subwfb	RY2_H,W,BANKED
	movwf	LINEY2_H,BANKED
	movff	COLOR,LINECOLOUR
	movff	COLOR_H,LINECOLOUR_H
	banksel	0
	call	LINE
;End Select
SysSelectEnd3
;Next
	banksel	RY1
	movf	RY1,W,BANKED
	subwf	RY2,W,BANKED
	movwf	SysTemp1,BANKED
	movf	RY1_H,W,BANKED
	subwfb	RY2_H,W,BANKED
	movwf	SysTemp1_H,BANKED
	movff	SysTemp1,SysWORDTempA
	movff	SysTemp1_H,SysWORDTempA_H
	movlw	2
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	call	SysDivSub16
	movff	SysWORDTempA,SysTemp2
	movff	SysWORDTempA_H,SysTemp2_H
	movff	FRI,SysWORDTempA
	movff	FRI_H,SysWORDTempA_H
	movff	SysTemp2,SysWORDTempB
	movff	SysTemp2_H,SysWORDTempB_H
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop8
SysForLoopEnd8
;End if
ENDIF43
	banksel	0
	return

;********************************************************************************

;Overloaded signature: LONG:BYTE:, Source: stdbasic.h (408)
FN_FNLSL545
;Repeat NumBits
	movff	NUMBITS,SysRepeatTemp19
	banksel	SYSREPEATTEMP19
	movf	SYSREPEATTEMP19,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd19
SysRepeatLoop19
;Set C Off
	bcf	STATUS,C,ACCESS
;Rotate SysLongTempB Left
	rlcf	SYSLONGTEMPB,F,ACCESS
	rlcf	SYSLONGTEMPB_H,F,ACCESS
	rlcf	SYSLONGTEMPB_U,F,ACCESS
	rlcf	SYSLONGTEMPB_E,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp19,F,BANKED
	bra	SysRepeatLoop19
SysRepeatLoopEnd19
;FnLSL = SysLongTempB
	movff	SYSLONGTEMPB,FNLSL
	movff	SYSLONGTEMPB_H,FNLSL_H
	movff	SYSLONGTEMPB_U,FNLSL_U
	movff	SYSLONGTEMPB_E,FNLSL_E
	banksel	0
	return

;********************************************************************************

;Overloaded signature: LONG:BYTE:, Source: stdbasic.h (378)
FN_FNLSR542
;Repeat NumBits
	movff	NUMBITS,SysRepeatTemp17
	banksel	SYSREPEATTEMP17
	movf	SYSREPEATTEMP17,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd17
SysRepeatLoop17
;Set C Off
	bcf	STATUS,C,ACCESS
;Rotate SysLongTempB Right
	rrcf	SYSLONGTEMPB_E,F,ACCESS
	rrcf	SYSLONGTEMPB_U,F,ACCESS
	rrcf	SYSLONGTEMPB_H,F,ACCESS
	rrcf	SYSLONGTEMPB,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp17,F,BANKED
	bra	SysRepeatLoop17
SysRepeatLoopEnd17
;FnLSR = SysLongTempB
	movff	SYSLONGTEMPB,FNLSR
	movff	SYSLONGTEMPB_H,FNLSR_H
	movff	SYSLONGTEMPB_U,FNLSR_U
	movff	SYSLONGTEMPB_E,FNLSR_E
	banksel	0
	return

;********************************************************************************

;Overloaded signature: WORD:BYTE:, Source: stdbasic.h (386)
FN_FNLSR543
;Repeat NumBits
	movff	NUMBITS,SysRepeatTemp18
	banksel	SYSREPEATTEMP18
	movf	SYSREPEATTEMP18,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd18
SysRepeatLoop18
;Set C Off
	bcf	STATUS,C,ACCESS
;Rotate SysWordTempB Right
	rrcf	SYSWORDTEMPB_H,F,ACCESS
	rrcf	SYSWORDTEMPB,F,ACCESS
;End Repeat
	decfsz	SysRepeatTemp18,F,BANKED
	bra	SysRepeatLoop18
SysRepeatLoopEnd18
;FnLSR = SysWordTempB
	movff	SYSWORDTEMPB,FNLSR
	movff	SYSWORDTEMPB_H,FNLSR_H
	banksel	0
	return

;********************************************************************************

;Source: MySDLib.h (103)
GETSDRESPONSE
;Dim SDResp as Byte
;repeat NResponse
	movff	NRESPONSE,SysRepeatTemp22
	banksel	SYSREPEATTEMP22
	movf	SYSREPEATTEMP22,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd22
SysRepeatLoop22
;SPITransfer 255, SDResp
	setf	SPITXDATA,BANKED
	banksel	0
	call	HWSPITRANSFER
	movff	SPIRXDATA,SDRESP
;end Repeat
	banksel	SYSREPEATTEMP22
	decfsz	SysRepeatTemp22,F,BANKED
	bra	SysRepeatLoop22
SysRepeatLoopEnd22
	banksel	0
	return

;********************************************************************************

GLCDCHARCOL3EXTENDED1
	movlw	240
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableGLCDCHARCOL3EXTENDED1
	movwf	TBLPTRL,ACCESS
	movlw	high TableGLCDCHARCOL3EXTENDED1
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TableGLCDCHARCOL3EXTENDED1
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableGLCDCHARCOL3EXTENDED1
	db	239,0,16,12,10,136,34,56,32,8,32,16,16,128,128,64,4,0,0,0,40,72,70,108,0,0,0,40
	db	16,0,16,0,64,124,0,132,130,48,78,120,6,108,12,0,0,16,40,0,4,100,248,254,124,254
	db	254,254,124,254,0,64,254,254,254,254,124,254,124,254,76,2,126,62,126,198,14,194
	db	0,4,0,8,128,0,64,254,112,112,112,16,16,254,0,64,254,0,248,248,112,248,16,248
	db	144,16,120,56,120,136,24,136,0,0,0,32,120,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,248,254,254,248,254,194,254,124,0,254,248,254,254,130,124,254,254,0
	db	198,2,14,56,198,14,188,0,0,56,40,124,0,0,56,254,4,48,40,1,124,48,0,124,64,252
	db	28,0,56,4,248,24,56,4,60,56,68,60,60,0,60,56,60,60

;********************************************************************************

GLCDCHARCOL4EXTENDED1
	movlw	240
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableGLCDCHARCOL4EXTENDED1
	movwf	TBLPTRL,ACCESS
	movlw	high TableGLCDCHARCOL4EXTENDED1
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TableGLCDCHARCOL4EXTENDED1
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableGLCDCHARCOL4EXTENDED1
	db	239,254,56,10,6,204,102,124,112,4,64,16,56,136,162,112,28,0,0,14,254,84,38,146
	db	10,56,130,16,16,160,16,192,32,162,132,194,130,40,138,148,2,146,146,108,172,40
	db	40,130,2,146,36,146,130,130,146,18,130,16,130,128,16,128,4,8,130,18,130,18,146,2
	db	128,64,128,40,16,162,254,8,130,4,128,2,168,144,136,136,168,252,168,16,144,128
	db	32,130,8,16,136,40,40,16,168,124,128,64,128,80,160,200,16,0,130,16,68,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,36,146,2,132,146,162,16,146,130,16,4,4
	db	8,146,130,2,18,0,170,2,16,68,40,16,194,0,0,68,84,8,0,0,68,73,104,73,84,25,8,74
	db	0,16,50,64,32,1,68,124,36,36,68,4,64,68,40,64,64,1,65,68,64,64

;********************************************************************************

GLCDCHARCOL5EXTENDED1
	movlw	240
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableGLCDCHARCOL5EXTENDED1
	movwf	TBLPTRL,ACCESS
	movlw	high TableGLCDCHARCOL5EXTENDED1
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TableGLCDCHARCOL5EXTENDED1
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableGLCDCHARCOL5EXTENDED1
	db	239,124,124,0,0,238,238,124,168,254,254,84,84,148,148,124,124,0,158,0,40,254,16,170
	db	6,68,68,124,124,96,16,192,16,146,254,162,138,36,138,146,226,146,146,108,108,68
	db	40,68,162,242,34,146,130,130,146,18,146,16,254,130,40,128,24,16,130,18,162,50
	db	146,254,128,128,112,16,224,146,130,16,130,2,128,4,168,136,136,136,168,18,168,8
	db	250,136,80,254,240,8,136,40,40,8,168,144,128,128,96,32,160,168,108,254,108,16
	db	66,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,34,146,2,130,146,146,16,146
	db	254,40,2,24,16,146,130,2,18,0,146,254,224,254,16,254,2,0,0,69,84,5,61,0,68,73
	db	144,75,84,165,4,77,60,40,9,64,64,149,68,4,36,164,68,124,64,254,16,248,56,60,64,69
	db	66,58

;********************************************************************************

GLCDCHARCOL6EXTENDED1
	movlw	240
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableGLCDCHARCOL6EXTENDED1
	movwf	TBLPTRL,ACCESS
	movlw	high TableGLCDCHARCOL6EXTENDED1
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TableGLCDCHARCOL6EXTENDED1
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableGLCDCHARCOL6EXTENDED1
	db	239,56,254,12,10,204,102,124,32,4,64,56,16,162,136,112,28,0,0,14,254,84,200,68
	db	0,130,56,16,16,0,16,0,8,138,128,146,150,254,138,146,18,146,82,0,0,130,40,40,18,130
	db	36,146,130,68,146,18,146,16,130,126,68,128,4,32,130,18,66,82,146,2,128,64,128,40
	db	16,138,130,32,254,4,128,8,168,136,136,144,168,2,168,8,128,122,136,128,8,8,136,40
	db	48,8,168,128,64,64,128,80,160,152,130,0,16,32,68,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,36,146,2,132,146,138,16,146,130,68,4,4,32,146,130,2,18,0
	db	130,2,16,68,40,16,194,0,0,56,85,4,64,0,56,78,104,77,84,67,4,73,64,68,9,32,32,171
	db	68,124,36,164,76,4,64,68,40,64,64,65,65,68,65,65

;********************************************************************************

GLCDCHARCOL7EXTENDED1
	movlw	240
	cpfslt	SysStringA,ACCESS
	retlw	0
	movf	SysStringA, W,ACCESS
	addlw	low TableGLCDCHARCOL7EXTENDED1
	movwf	TBLPTRL,ACCESS
	movlw	high TableGLCDCHARCOL7EXTENDED1
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRH,ACCESS
	movlw	upper TableGLCDCHARCOL7EXTENDED1
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableGLCDCHARCOL7EXTENDED1
	db	239,16,0,10,6,136,34,56,62,8,32,16,16,128,128,64,4,0,0,0,40,36,196,160,0,0,0,40
	db	16,0,16,0,4,124,0,140,98,32,114,96,14,108,60,0,0,0,40,16,12,124,248,108,68,56
	db	130,2,244,254,0,2,130,128,254,254,124,12,188,140,100,2,126,62,126,198,14,134,0,64
	db	0,8,128,0,240,112,64,254,48,4,120,240,0,0,0,0,240,240,112,16,248,16,64,64,248,56
	db	120,136,120,136,0,0,0,16,120,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	db	248,108,2,248,130,134,254,124,0,130,248,254,254,130,124,254,12,0,130,2,14,56
	db	198,14,188,0,0,68,68,120,32,0,68,48,4,49,68,1,120,62,32,0,126,124,28,65,56,4,24,72
	db	52,4,60,56,68,60,60,32,60,56,60,60

;********************************************************************************

;Source: glcd.h (1131)
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
	bra	ELSE28_1
;PrintLocY = 0
	banksel	PRINTLOCY
	clrf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
;else
	bra	ENDIF28
ELSE28_1
;PrintLocY--
	movlw	1
	banksel	PRINTLOCY
	subwf	PRINTLOCY,F,BANKED
	movlw	0
	subwfb	PRINTLOCY_H,F,BANKED
;PrintLocY = ( PrintLocY * ( GLCDfntDefaultHeight * GLCDfntDefaultSize ) ) mod EPD_CORRECTED_HEIGHT
	banksel	GLCDFNTDEFAULTHEIGHT
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
ENDIF28
	banksel	0
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:STRING:, Source: glcd.h (852)
GLCDPRINT14
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
;GLCDPrintLoc = PrintLocX
	movff	PRINTLOCX,GLCDPRINTLOC
	movff	PRINTLOCX_H,GLCDPRINTLOC_H
;Write Data
;For GLCDPrint_String_Counter = 1 To GLCDPrintLen
	clrf	GLCDPRINT_STRING_COUNTER,BANKED
	movlw	1
	subwf	GLCDPRINTLEN,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd34
SysForLoop34
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
;Macro Source: glcd.h (1090)
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize )+1
	movf	GLCDFONTWIDTH,W,BANKED
	mulwf	GLCDFNTDEFAULTSIZE,BANKED
	movffl	PRODL,SysTemp3
	banksel	SYSTEMP3
	movf	SysTemp3,W,BANKED
	banksel	GLCDPRINTLOC
	addwf	GLCDPRINTLOC,W,BANKED
	banksel	SYSTEMP1
	movwf	SysTemp1,BANKED
	movlw	0
	banksel	GLCDPRINTLOC_H
	addwfc	GLCDPRINTLOC_H,W,BANKED
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H,BANKED
	movlw	1
	addwf	SysTemp1,W,BANKED
	banksel	GLCDPRINTLOC
	movwf	GLCDPRINTLOC,BANKED
	movlw	0
	banksel	SYSTEMP1_H
	addwfc	SysTemp1_H,W,BANKED
	banksel	GLCDPRINTLOC_H
	movwf	GLCDPRINTLOC_H,BANKED
;Next
	movf	GLCDPRINTLEN,W,BANKED
	subwf	GLCDPRINT_STRING_COUNTER,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop34
SysForLoopEnd34
;Update the current X position for GLCDPrintString
;PrintLocX = GLCDPrintLoc
	movff	GLCDPRINTLOC,PRINTLOCX
	movff	GLCDPRINTLOC_H,PRINTLOCX_H
	return

;********************************************************************************

;Source: glcd.h (1111)
GLCDPRINTSTRINGLN
;dim PrintLocX, PrintLocY as word
;GLCDPrint( PrintLocX , PrintLocY , LCDPrintData )
	movff	SysLCDPRINTDATAHandler,SysLCDPRINTDATAHandler
	movff	SysLCDPRINTDATAHandler_H,SysLCDPRINTDATAHandler_H
	rcall	GLCDPRINT14
;Update the current X and Y position
;PrintLocX = 0
	banksel	PRINTLOCX
	clrf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
;When using Transaction  PrintLocY will get incremented. This needs to be protected
;PrintLocY = ( PrintLocY + ( GLCDfntDefaultHeight * GLCDfntDefaultSize ) ) mod EPD_CORRECTED_HEIGHT
	banksel	GLCDFNTDEFAULTHEIGHT
	movf	GLCDFNTDEFAULTHEIGHT,W,BANKED
	mulwf	GLCDFNTDEFAULTSIZE,BANKED
	movffl	PRODL,SysTemp1
	banksel	SYSTEMP1
	movf	SysTemp1,W,BANKED
	addwf	PRINTLOCY,W,BANKED
	movwf	SysTemp2,BANKED
	movlw	0
	addwfc	PRINTLOCY_H,W,BANKED
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

;Source: usart.h (1216)
HSERGETSTRING
;HSerIndex = 0
	clrf	HSERINDEX,BANKED
;Do
SysDoLoop_S19
;comport = comport 'not really required but added for clarity
;HSerReceive ( HSerInByte )
	banksel	0
	rcall	HSERRECEIVE711
	movff	SERDATA,HSERINBYTE
;Enter key?
;If HSerInByte = 13 Then
	movlw	13
	subwf	HSERINBYTE,W,BANKED
	btfsc	STATUS, Z,ACCESS
;Exit Sub
	return
;End If
;letters,numbers,punctuation
;If HSerInByte >= 32 and HSerInByte <= 126 Then
	movff	HSERINBYTE,SysBYTETempA
	movlw	32
	movwf	SysBYTETempB,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	movff	SysByteTempX,SysTemp3
	movff	HSERINBYTE,SysBYTETempB
	movlw	126
	movwf	SysBYTETempA,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	banksel	SYSTEMP3
	movf	SysTemp3,W,BANKED
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp4,BANKED
	btfss	SysTemp4,0,BANKED
	bra	ENDIF207
;HSerIndex++
	banksel	HSERINDEX
	incf	HSERINDEX,F,BANKED
;HSerString(HSerIndex) = HSerInByte
	movf	HSERINDEX,W,BANKED
	banksel	SYSHSERSTRINGHANDLER
	addwf	SysHSERSTRINGHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysHSERSTRINGHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movffl	HSERINBYTE,INDF0
;HSerString(0) = HSerIndex
	movffl	SysHSERSTRINGHandler,AFSR0
	movffl	SysHSERSTRINGHandler_H,AFSR0_H
	movffl	HSERINDEX,INDF0
;End If
ENDIF207
;Loop
	bra	SysDoLoop_S19
SysDoLoop_E19
	return

;********************************************************************************

;Overloaded signature: STRING:byte:, Source: usart.h (1251)
HSERPRINT716
;PrintLen = PrintData(0)
	movffl	SysPRINTDATAHandler,AFSR0
	movffl	SysPRINTDATAHandler_H,AFSR0_H
	movffl	INDF0,PRINTLEN
;If PrintLen <> 0 then
	banksel	PRINTLEN
	movf	PRINTLEN,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	ENDIF208
;Write Data
;for SysPrintTemp = 1 to PrintLen
	clrf	SYSPRINTTEMP,BANKED
	movlw	1
	subwf	PRINTLEN,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd32
SysForLoop32
	incf	SYSPRINTTEMP,F,BANKED
;HSerSend(PrintData(SysPrintTemp),comport )
	movf	SYSPRINTTEMP,W,BANKED
	addwf	SysPRINTDATAHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysPRINTDATAHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movffl	INDF0,SERDATA
	banksel	0
	rcall	HSERSEND706
;next
	banksel	PRINTLEN
	movf	PRINTLEN,W,BANKED
	subwf	SYSPRINTTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop32
SysForLoopEnd32
;End If
ENDIF208
;CR
	banksel	0
	return

;********************************************************************************

;Overloaded signature: BYTE:byte:, Source: usart.h (1274)
HSERPRINT717
;OutValueTemp = 0
	banksel	OUTVALUETEMP
	clrf	OUTVALUETEMP,BANKED
;IF SerPrintVal >= 100 Then
	movlw	100
	subwf	SERPRINTVAL,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	ENDIF211
;OutValueTemp = SerPrintVal / 100
	movff	SERPRINTVAL,SysBYTETempA
	movlw	100
	movwf	SysBYTETempB,ACCESS
	banksel	0
	call	SysDivSub
	movff	SysBYTETempA,OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movff	SYSCALCTEMPX,SERPRINTVAL
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	banksel	OUTVALUETEMP
	addwf	OUTVALUETEMP,W,BANKED
	movwf	SERDATA,BANKED
	banksel	0
	rcall	HSERSEND706
;End If
ENDIF211
;If OutValueTemp > 0 Or SerPrintVal >= 10 Then
	movff	OUTVALUETEMP,SysBYTETempB
	clrf	SysBYTETempA,ACCESS
	banksel	0
	call	SysCompLessThan
	movff	SysByteTempX,SysTemp3
	movff	SERPRINTVAL,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	call	SysCompLessThan
	comf	SysByteTempX,F,ACCESS
	banksel	SYSTEMP3
	movf	SysTemp3,W,BANKED
	iorwf	SysByteTempX,W,ACCESS
	movwf	SysTemp4,BANKED
	btfss	SysTemp4,0,BANKED
	bra	ENDIF212
;OutValueTemp = SerPrintVal / 10
	movff	SERPRINTVAL,SysBYTETempA
	movlw	10
	movwf	SysBYTETempB,ACCESS
	banksel	0
	call	SysDivSub
	movff	SysBYTETempA,OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	movff	SYSCALCTEMPX,SERPRINTVAL
;HSerSend(OutValueTemp + 48 ,comport )
	movlw	48
	banksel	OUTVALUETEMP
	addwf	OUTVALUETEMP,W,BANKED
	movwf	SERDATA,BANKED
	banksel	0
	rcall	HSERSEND706
;End If
ENDIF212
;HSerSend(SerPrintVal + 48 ,comport)
	movlw	48
	banksel	SERPRINTVAL
	addwf	SERPRINTVAL,W,BANKED
	movwf	SERDATA,BANKED
	banksel	0
	rcall	HSERSEND706
;CR
	return

;********************************************************************************

;Overloaded signature: WORD:byte:, Source: usart.h (1302)
HSERPRINT718
;Dim SysCalcTempX As Word
;OutValueTemp = 0
	banksel	OUTVALUETEMP
	clrf	OUTVALUETEMP,BANKED
;If SerPrintVal >= 10000 then
	movff	SERPRINTVAL,SysWORDTempA
	movff	SERPRINTVAL_H,SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB,ACCESS
	movlw	39
	movwf	SysWORDTempB_H,ACCESS
	banksel	0
	call	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF232
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
	banksel	OUTVALUETEMP
	addwf	OUTVALUETEMP,W,BANKED
	movwf	SERDATA,BANKED
	banksel	0
	rcall	HSERSEND706
;Goto HSerPrintWord1000
	bra	HSERPRINTWORD1000
;End If
ENDIF232
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
	bra	ENDIF233
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
	banksel	OUTVALUETEMP
	addwf	OUTVALUETEMP,W,BANKED
	movwf	SERDATA,BANKED
	banksel	0
	rcall	HSERSEND706
;Goto HSerPrintWord100
	bra	HSERPRINTWORD100
;End If
ENDIF233
;If SerPrintVal >= 100 then
	movff	SERPRINTVAL,SysWORDTempA
	movff	SERPRINTVAL_H,SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF234
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
	banksel	OUTVALUETEMP
	addwf	OUTVALUETEMP,W,BANKED
	movwf	SERDATA,BANKED
	banksel	0
	rcall	HSERSEND706
;Goto HSerPrintWord10
	bra	HSERPRINTWORD10
;End If
ENDIF234
;If SerPrintVal >= 10 then
	movff	SERPRINTVAL,SysWORDTempA
	movff	SERPRINTVAL_H,SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF235
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
	banksel	OUTVALUETEMP
	addwf	OUTVALUETEMP,W,BANKED
	movwf	SERDATA,BANKED
	banksel	0
	rcall	HSERSEND706
;End If
ENDIF235
;HSerSend(SerPrintVal + 48 ,comport  )
	movlw	48
	banksel	SERPRINTVAL
	addwf	SERPRINTVAL,W,BANKED
	movwf	SERDATA,BANKED
	banksel	0
	rcall	HSERSEND705
;CR
	return

;********************************************************************************

;Overloaded signature: LONG:byte:, Source: usart.h (1368)
HSERPRINT720
;Dim SysCalcTempA As Long
;Dim SysPrintBuffer(10)
;SysPrintBuffLen = 0
	banksel	SYSPRINTBUFFLEN
	clrf	SYSPRINTBUFFLEN,BANKED
;Do
SysDoLoop_S20
;Divide number by 10, remainder into buffer
;SysPrintBuffLen += 1
	banksel	SYSPRINTBUFFLEN
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
	banksel	0
	call	SysDivSub32
	movffl	SysLONGTempX,INDF0
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
	bra	SysDoLoop_S20
SysDoLoop_E20
;Display
;For SysPrintTemp = SysPrintBuffLen To 1 Step -1
	banksel	SYSPRINTBUFFLEN
	incf	SYSPRINTBUFFLEN,W,BANKED
	movwf	SYSPRINTTEMP,BANKED
	movlw	1
	subwf	SYSPRINTBUFFLEN,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd33
SysForLoop33
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
	banksel	0
	rcall	HSERSEND706
;Next
	banksel	SYSPRINTTEMP
	movf	SYSPRINTTEMP,W,BANKED
	sublw	1
	btfss	STATUS, C,ACCESS
	bra	SysForLoop33
SysForLoopEnd33
;CR
	banksel	0
	return

;********************************************************************************

;Source: usart.h (1403)
HSERPRINTCRLF
;repeat HSerPrintCRLFCount
	movff	HSERPRINTCRLFCOUNT,SysRepeatTemp20
	banksel	SYSREPEATTEMP20
	movf	SYSREPEATTEMP20,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd20
SysRepeatLoop20
;HSerSend(13,comport)
	movlw	13
	movwf	SERDATA,BANKED
	banksel	0
	rcall	HSERSEND706
;HSerSend(10,comport)
	movlw	10
	banksel	SERDATA
	movwf	SERDATA,BANKED
	banksel	0
	rcall	HSERSEND706
;end Repeat
	banksel	SYSREPEATTEMP20
	decfsz	SysRepeatTemp20,F,BANKED
	bra	SysRepeatLoop20
SysRepeatLoopEnd20
	banksel	0
	return

;********************************************************************************

;Overloaded signature: BYTE:, Source: usart.h (954)
HSERRECEIVE711
;Needs comport to be set first by calling routines
;if comport = 1 Then
	decf	COMPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF229
;SerData = DefaultUsartReturnValue
	banksel	SERDATA
	setf	SERDATA,BANKED
;If set up to block, wait for data
;Wait Until USARTHasData
SysWaitLoop6
	banksel	PIR3
	btfss	PIR3,U1RXIF,BANKED
	bra	SysWaitLoop6
;U1RXEN = 1
	banksel	U1CON0
	bsf	U1CON0,U1RXEN,BANKED
;U1ERRIR=0
	clrf	U1ERRIR,BANKED
;if ( U1FERIF = 1 ) then
	btfss	U1ERRIR,U1FERIF,BANKED
	bra	ENDIF230
;UART1 error - restart
;ON_U1CON1 = 0
	bcf	U1CON1,ON_U1CON1,BANKED
;ON_U1CON1 = 1
	bsf	U1CON1,ON_U1CON1,BANKED
;end if
ENDIF230
;If USARTHasData Then
	banksel	PIR3
	btfsc	PIR3,U1RXIF,BANKED
;SerData = U1RXB
	movffl	U1RXB,SERDATA
;end if
;end if
ENDIF229
	banksel	0
	return

;********************************************************************************

;Overloaded signature: BYTE:, Source: usart.h (653)
HSERSEND705
;Registers/Bits determined by #samevar at top of library
;USART_BLOCKING and NOT USART_TX_BLOCKING
;Wait While TXIF = Off
SysWaitLoop2
	banksel	PIR3
	btfss	PIR3,U1TXIF,BANKED
	bra	SysWaitLoop2
;Write the data byte to the USART.
;Sets register to value of SerData - where register could be TXREG or TXREG1 or U1TXB set via the #samevar
;TXREG = SerData
	movffl	SERDATA,U1TXB
;Wait until TRMT = 1
SysWaitLoop3
	banksel	U1ERRIR
	btfss	U1ERRIR,TXMTIF,BANKED
	bra	SysWaitLoop3
;Add USART_DELAY after the byte is sent by the USART module
;Wait USART_DELAY
	movlw	5
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	banksel	0
	goto	Delay_MS

;********************************************************************************

;Overloaded signature: BYTE:byte:, Source: usart.h (736)
HSERSEND706
;Registers/Bits determined by #samevar at top of library
;if comport = 1 Then
	decf	COMPORT,W,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF228
;USART_BLOCKING and NOT USART_TX_BLOCKING
;Wait While TXIF = Off
SysWaitLoop4
	banksel	PIR3
	btfss	PIR3,U1TXIF,BANKED
	bra	SysWaitLoop4
;Write the data byte to the USART.
;Sets register to value of SerData - where register could be TXREG or TXREG1 or U1TXB set via the #samevar
;TXREG = SerData
	movffl	SERDATA,U1TXB
;Add USART_DELAY after the byte is sent by the USART module
;Wait until TRMT = 1
SysWaitLoop5
	banksel	U1ERRIR
	btfss	U1ERRIR,TXMTIF,BANKED
	bra	SysWaitLoop5
;Wait USART_DELAY
	movlw	5
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	banksel	0
	call	Delay_MS
;exit now to exit asap, if you have more than one comport in use there is no point in processing
;exit sub
	return
;end if
ENDIF228
	return

;********************************************************************************

;Source: hwspi.h (595)
HWSPITRANSFER
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

;Source: glcd.h (3656)
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
	bra	ELSE55_1
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
	banksel	Y_MAX
	movwf	Y_MAX,BANKED
	clrf	Y_MAX_H,BANKED
;else
	bra	ENDIF55
ELSE55_1
;y_offset=x_0
	movff	X_0,Y_OFFSET
	movff	X_0_H,Y_OFFSET_H
;x_offset=y_0
	movff	Y_0,X_OFFSET
	movff	Y_0_H,X_OFFSET_H
;y_max=GLCD_WIDTH
	movlw	104
	banksel	Y_MAX
	movwf	Y_MAX,BANKED
	clrf	Y_MAX_H,BANKED
;x_max=GLCD_HEIGHT
	movlw	212
	banksel	X_MAX
	movwf	X_MAX,BANKED
	clrf	X_MAX_H,BANKED
;end if
ENDIF55
;x_coord=a_axis
	movff	A_AXIS,X_COORD
	movff	A_AXIS_H,X_COORD_H
;y_coord=0
	banksel	Y_COORD
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
	movwf	SysTemp1,BANKED
	movlw	0
	addwfc	X_COORD_H,W,BANKED
	movwf	SysTemp1_H,BANKED
	movff	A_SQ4,SysLONGTempA
	movff	A_SQ4_H,SysLONGTempA_H
	movff	A_SQ4_U,SysLONGTempA_U
	movff	A_SQ4_E,SysLONGTempA_E
	movff	SysTemp1,SysLONGTempB
	movff	SysTemp1_H,SysLONGTempB_H
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
	banksel	NUMBITS
	movwf	NUMBITS,BANKED
	banksel	0
	call	FN_FNLSR543
	movff	SYSFNLSRWORD,HALF_A_SQ
	movff	SYSFNLSRWORD_H,HALF_A_SQ_H
;half_b_sq=FNLSR(b_sq,1)
	movff	B_SQ,SYSWORDTEMPB
	movff	B_SQ_H,SYSWORDTEMPB_H
	movlw	1
	banksel	NUMBITS
	movwf	NUMBITS,BANKED
	banksel	0
	call	FN_FNLSR543
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
	movwf	DIST,BANKED
	movf	HALF_B_SQ_H,W,BANKED
	addwfc	A_SQ2_H,W,ACCESS
	movwf	DIST_H,BANKED
	movlw	0
	addwfc	A_SQ2_U,W,ACCESS
	movwf	DIST_U,BANKED
	movlw	0
	addwfc	A_SQ2_E,W,ACCESS
	movwf	DIST_E,BANKED
;dist_sign=0
	clrf	DIST_SIGN,BANKED
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
	movff	SysWORDTempX,SysTemp1
	movff	SysWORDTempX_H,SysTemp1_H
	movlw	1
	banksel	SYSTEMP1
	addwf	SysTemp1,W,BANKED
	movwf	SysTemp2,BANKED
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	SysTemp2_H,BANKED
	movff	B_SQ,SysLONGTempA
	movff	B_SQ_H,SysLONGTempA_H
	clrf	SysLONGTempA_U,ACCESS
	clrf	SysLONGTempA_E,ACCESS
	movff	SysTemp2,SysLONGTempB
	movff	SysTemp2_H,SysLONGTempB_H
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
	banksel	INTERSECT
	clrf	INTERSECT,BANKED
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
	banksel	Y_COORD
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
	banksel	HYPERBOLECONDITION
	movf	HYPERBOLECONDITION,F,BANKED
	btfsc	STATUS, Z,ACCESS
;exit do
	bra	SysDoLoop_E6
;end if
;HyperboleDisplayPixel(LineColour)
	banksel	0
	rcall	HYPERBOLEDISPLAYPIXEL
;if dist_sign=0 then
	movf	DIST_SIGN,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF57
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
ENDIF57
;HyperboleParabolaSumvar(dist, a_sq2+y_slope, dist_sign)
	movff	DIST,VAR1
	movff	DIST_H,VAR1_H
	movff	DIST_U,VAR1_U
	movff	DIST_E,VAR1_E
	banksel	Y_SLOPE
	movf	Y_SLOPE,W,BANKED
	addwf	A_SQ2,W,ACCESS
	banksel	VAR2
	movwf	VAR2,BANKED
	banksel	Y_SLOPE_H
	movf	Y_SLOPE_H,W,BANKED
	addwfc	A_SQ2_H,W,ACCESS
	banksel	VAR2_H
	movwf	VAR2_H,BANKED
	banksel	Y_SLOPE_U
	movf	Y_SLOPE_U,W,BANKED
	addwfc	A_SQ2_U,W,ACCESS
	banksel	VAR2_U
	movwf	VAR2_U,BANKED
	banksel	Y_SLOPE_E
	movf	Y_SLOPE_E,W,BANKED
	addwfc	A_SQ2_E,W,ACCESS
	banksel	VAR2_E
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
	banksel	Y_COORD
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
	banksel	X_SLOPE
	addwf	X_SLOPE,W,BANKED
	movwf	SYSLONGTEMPB,ACCESS
	banksel	Y_SLOPE_H
	movf	Y_SLOPE_H,W,BANKED
	banksel	X_SLOPE_H
	addwfc	X_SLOPE_H,W,BANKED
	movwf	SYSLONGTEMPB_H,ACCESS
	banksel	Y_SLOPE_U
	movf	Y_SLOPE_U,W,BANKED
	banksel	X_SLOPE_U
	addwfc	X_SLOPE_U,W,BANKED
	movwf	SYSLONGTEMPB_U,ACCESS
	banksel	Y_SLOPE_E
	movf	Y_SLOPE_E,W,BANKED
	banksel	X_SLOPE_E
	addwfc	X_SLOPE_E,W,BANKED
	movwf	SYSLONGTEMPB_E,ACCESS
	movlw	1
	movwf	NUMBITS,BANKED
	banksel	0
	call	FN_FNLSR542
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
	banksel	INTERSECT
	clrf	INTERSECT,BANKED
;if a_axis>b_axis then
	movff	A_AXIS,SysWORDTempB
	movff	A_AXIS_H,SysWORDTempB_H
	movff	B_AXIS,SysWORDTempA
	movff	B_AXIS_H,SysWORDTempA_H
	banksel	0
	call	SysCompLessThan16
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF58
;do
SysDoLoop_S7
;if HyperboleCondition(ModeStop)=0 then
	banksel	0
	rcall	FN_HYPERBOLECONDITION
	banksel	HYPERBOLECONDITION
	movf	HYPERBOLECONDITION,F,BANKED
	btfsc	STATUS, Z,ACCESS
;exit do
	bra	SysDoLoop_E7
;end if
;HyperboleDisplayPixel(LineColour)
	banksel	0
	rcall	HYPERBOLEDISPLAYPIXEL
;if dist_sign=1 then
	decf	DIST_SIGN,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF60
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
ENDIF60
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
	banksel	Y_COORD
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
ENDIF58
	banksel	0
	return

;********************************************************************************

;Source: glcd.h (3765)
FN_HYPERBOLECONDITION
;Dim HyperboleCondition, ModeStop as Byte
;Dim x_coord, y_coord, x_max, y_max, x_offset, y_offset, x_plus, y_plus as Word
;Dim intersect as Byte
;if ModeStop=1 then
	banksel	MODESTOP
	decf	MODESTOP,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE61_1
;if (y_plus<y_max and x_plus<x_max) and (x_coord<=x_offset and y_coord<=y_offset) then
;if intersect=0 then
	movf	INTERSECT,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE62_1
;HyperboleCondition=1
	movlw	1
	movwf	HYPERBOLECONDITION,BANKED
;else
	bra	ENDIF62
ELSE62_1
;HyperboleCondition=0
	clrf	HYPERBOLECONDITION,BANKED
;end if
ENDIF62
;else
	bra	ENDIF61
ELSE61_1
;if (y_plus<y_max or x_plus<x_max) or (x_coord<=x_offset or y_coord<=y_offset) then
;if intersect=0b1111 then
	movlw	15
	subwf	INTERSECT,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE63_1
;HyperboleCondition=0
	clrf	HYPERBOLECONDITION,BANKED
;else
	bra	ENDIF63
ELSE63_1
;HyperboleCondition=1
	movlw	1
	movwf	HYPERBOLECONDITION,BANKED
;end if
ENDIF63
;end if
ENDIF61
	banksel	0
	return

;********************************************************************************

;Source: glcd.h (3788)
HYPERBOLEDISPLAYPIXEL
;Dim x_max, y_max, x_plus, x_minus, y_plus, y_minus as Word
;Dim LineColour as word
;Dim Type, intersect as Byte
;if Type = 1 then
	banksel	TYPE
	decf	TYPE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE64_1
;if x_plus<=x_max  then
	movff	X_PLUS,SysWORDTempB
	movff	X_PLUS_H,SysWORDTempB_H
	movff	X_MAX,SysWORDTempA
	movff	X_MAX_H,SysWORDTempA_H
	banksel	0
	call	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE65_1
;if y_plus<=y_max then
	movff	Y_PLUS,SysWORDTempB
	movff	Y_PLUS_H,SysWORDTempB_H
	movff	Y_MAX,SysWORDTempA
	movff	Y_MAX_H,SysWORDTempA_H
	call	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE69_1
;Pset(x_plus, y_plus, Linecolour)
	movff	X_PLUS,GLCDX
	movff	X_PLUS_H,GLCDX_H
	movff	Y_PLUS,GLCDY
	movff	Y_PLUS_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;else
	bra	ENDIF69
ELSE69_1
;intersect.0=1
	banksel	INTERSECT
	bsf	INTERSECT,0,BANKED
;end if
ENDIF69
;if y_minus.15=0 then
	banksel	Y_MINUS_H
	btfsc	Y_MINUS_H,7,BANKED
	bra	ELSE70_1
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
	bra	ENDIF70
ELSE70_1
;intersect.1=1
	banksel	INTERSECT
	bsf	INTERSECT,1,BANKED
;end if
ENDIF70
;else
	bra	ENDIF65
ELSE65_1
;intersect.0=1
	banksel	INTERSECT
	bsf	INTERSECT,0,BANKED
;intersect.1=1
	bsf	INTERSECT,1,BANKED
;end if
ENDIF65
;if x_minus.15=0 then
	banksel	X_MINUS_H
	btfsc	X_MINUS_H,7,BANKED
	bra	ELSE66_1
;if y_plus<=y_max then
	movff	Y_PLUS,SysWORDTempB
	movff	Y_PLUS_H,SysWORDTempB_H
	movff	Y_MAX,SysWORDTempA
	movff	Y_MAX_H,SysWORDTempA_H
	banksel	0
	call	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE71_1
;Pset(x_minus,y_plus, LineColour)
	movff	X_MINUS,GLCDX
	movff	X_MINUS_H,GLCDX_H
	movff	Y_PLUS,GLCDY
	movff	Y_PLUS_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;else
	bra	ENDIF71
ELSE71_1
;intersect.2=1
	banksel	INTERSECT
	bsf	INTERSECT,2,BANKED
;end if
ENDIF71
;if y_minus.15=0 then
	banksel	Y_MINUS_H
	btfsc	Y_MINUS_H,7,BANKED
	bra	ELSE72_1
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
	bra	ENDIF72
ELSE72_1
;intersect.3=1
	banksel	INTERSECT
	bsf	INTERSECT,3,BANKED
;end if
ENDIF72
;else
	bra	ENDIF66
ELSE66_1
;intersect.2=1
	bsf	INTERSECT,2,BANKED
;intersect.3=1
	bsf	INTERSECT,3,BANKED
;end if
ENDIF66
;else '---------------------------------------------------
	bra	ENDIF64
ELSE64_1
;if x_plus<=x_max then
	movff	X_PLUS,SysWORDTempB
	movff	X_PLUS_H,SysWORDTempB_H
	movff	X_MAX,SysWORDTempA
	movff	X_MAX_H,SysWORDTempA_H
	banksel	0
	call	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE67_1
;if y_plus<=y_max then
	movff	Y_PLUS,SysWORDTempB
	movff	Y_PLUS_H,SysWORDTempB_H
	movff	Y_MAX,SysWORDTempA
	movff	Y_MAX_H,SysWORDTempA_H
	call	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE73_1
;Pset(y_plus, x_plus, Linecolour)
	movff	Y_PLUS,GLCDX
	movff	Y_PLUS_H,GLCDX_H
	movff	X_PLUS,GLCDY
	movff	X_PLUS_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;else
	bra	ENDIF73
ELSE73_1
;intersect.0=1
	banksel	INTERSECT
	bsf	INTERSECT,0,BANKED
;end if
ENDIF73
;if y_minus.15=0 then
	banksel	Y_MINUS_H
	btfsc	Y_MINUS_H,7,BANKED
	bra	ELSE74_1
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
	bra	ENDIF74
ELSE74_1
;intersect.1=1
	banksel	INTERSECT
	bsf	INTERSECT,1,BANKED
;end if
ENDIF74
;else
	bra	ENDIF67
ELSE67_1
;intersect.0=1
	banksel	INTERSECT
	bsf	INTERSECT,0,BANKED
;intersect.1=1
	bsf	INTERSECT,1,BANKED
;end if
ENDIF67
;if x_minus.15=0 then
	banksel	X_MINUS_H
	btfsc	X_MINUS_H,7,BANKED
	bra	ELSE68_1
;if y_plus<=y_max then
	movff	Y_PLUS,SysWORDTempB
	movff	Y_PLUS_H,SysWORDTempB_H
	movff	Y_MAX,SysWORDTempA
	movff	Y_MAX_H,SysWORDTempA_H
	banksel	0
	call	SysCompLessThan16
	comf	SysByteTempX,F,ACCESS
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE75_1
;Pset(y_plus, x_minus, Linecolour)
	movff	Y_PLUS,GLCDX
	movff	Y_PLUS_H,GLCDX_H
	movff	X_MINUS,GLCDY
	movff	X_MINUS_H,GLCDY_H
	movff	LINECOLOUR,GLCDCOLOUR
	movff	LINECOLOUR_H,GLCDCOLOUR_H
	call	PSET_EPD2IN13D
;else
	bra	ENDIF75
ELSE75_1
;intersect.2=1
	banksel	INTERSECT
	bsf	INTERSECT,2,BANKED
;end if
ENDIF75
;if y_minus.15=0 then
	banksel	Y_MINUS_H
	btfsc	Y_MINUS_H,7,BANKED
	bra	ELSE76_1
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
	bra	ENDIF76
ELSE76_1
;intersect.3=1
	banksel	INTERSECT
	bsf	INTERSECT,3,BANKED
;end if
ENDIF76
;else
	bra	ENDIF68
ELSE68_1
;intersect.2=1
	bsf	INTERSECT,2,BANKED
;intersect.3=1
	bsf	INTERSECT,3,BANKED
;end if
ENDIF68
;end if
ENDIF64
	banksel	0
	return

;********************************************************************************

;Source: glcd.h (3860)
HYPERBOLEPARABOLADIFFVAR
;var2 MUST be >=0
;Dim var1, var2 as Long
;Dim sign as Byte
;if sign=0 then
	banksel	SIGN
	movf	SIGN,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE77_1
;if var1 > var2 then
	movff	VAR1,SysLONGTempB
	movff	VAR1_H,SysLONGTempB_H
	movff	VAR1_U,SysLONGTempB_U
	movff	VAR1_E,SysLONGTempB_E
	movff	VAR2,SysLONGTempA
	movff	VAR2_H,SysLONGTempA_H
	movff	VAR2_U,SysLONGTempA_U
	movff	VAR2_E,SysLONGTempA_E
	banksel	0
	call	SysCompLessThan32
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE78_1
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
	bra	ENDIF78
ELSE78_1
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
	movwf	SIGN,BANKED
;end if
ENDIF78
;else
	bra	ENDIF77
ELSE77_1
;var1=var1+var2
	movf	VAR2,W,BANKED
	addwf	VAR1,F,BANKED
	movf	VAR2_H,W,BANKED
	addwfc	VAR1_H,F,BANKED
	movf	VAR2_U,W,BANKED
	addwfc	VAR1_U,F,BANKED
	movf	VAR2_E,W,BANKED
	addwfc	VAR1_E,F,BANKED
;end if
ENDIF77
	banksel	0
	return

;********************************************************************************

;Source: glcd.h (3880)
HYPERBOLEPARABOLASUMVAR
;var2 MUST be >=0
;Dim var1, var2 as Long
;Dim sign as Byte
;if sign=0 then
	banksel	SIGN
	movf	SIGN,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE79_1
;var1=var1+var2
	movf	VAR2,W,BANKED
	addwf	VAR1,F,BANKED
	movf	VAR2_H,W,BANKED
	addwfc	VAR1_H,F,BANKED
	movf	VAR2_U,W,BANKED
	addwfc	VAR1_U,F,BANKED
	movf	VAR2_E,W,BANKED
	addwfc	VAR1_E,F,BANKED
;else
	bra	ENDIF79
ELSE79_1
;if var1 < var2 then
	movff	VAR1,SysLONGTempA
	movff	VAR1_H,SysLONGTempA_H
	movff	VAR1_U,SysLONGTempA_U
	movff	VAR1_E,SysLONGTempA_E
	movff	VAR2,SysLONGTempB
	movff	VAR2_H,SysLONGTempB_H
	movff	VAR2_U,SysLONGTempB_U
	movff	VAR2_E,SysLONGTempB_E
	banksel	0
	call	SysCompLessThan32
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE80_1
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
	clrf	SIGN,BANKED
;else
	bra	ENDIF80
ELSE80_1
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
	movwf	SIGN,BANKED
;end if
ENDIF80
;end if
ENDIF79
	banksel	0
	return

;********************************************************************************

;Source: E_paper-18F47K42_SD_SDLIB_Transaction.gcb (24)
INITPPS
;This has been added to turn off PPS SPI when in SPI software mode
;Module: UART1  (0x.... è in ESADECIMALE)
;U1RXPPS = 0x0017        'RC7 > RX1
	movlw	23
	banksel	U1RXPPS
	movwf	U1RXPPS,BANKED
;RC6PPS  = 0x0013        'TX1 > RC6
	movlw	19
	movwf	RC6PPS,BANKED
;Module: SPI1
;SPI1SDIPPS = 0x0014     'RC4 > SDI1
	movlw	20
	movwf	SPI1SDIPPS,BANKED
;RC5PPS = 0x001F         'SDO1 > RC5
	movlw	31
	movwf	RC5PPS,BANKED
;RC3PPS = 0x001E         'SCK1 > RC3
	movlw	30
	movwf	RC3PPS,BANKED
;SPI1SCKPPS = 0x0013     'RC3 > SCK1 (bi-directional)
	movlw	19
	movwf	SPI1SCKPPS,BANKED
	banksel	0
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

;Source: usart.h (454)
INITUSART
;Set the default value for comport
;comport = 1
	movlw	1
	movwf	COMPORT,ACCESS
;Set baud rate for for 18fxxK42/K83 series UART
;U1BRGH=SPBRGH_TEMP
	movlw	1
	banksel	U1BRGH
	movwf	U1BRGH,BANKED
;U1BRGL=SPBRGL_TEMP
	movlw	20
	movwf	U1BRGL,BANKED
;U1BRGS = BRGS1_SCRIPT
	bsf	U1CON0,U1BRGS,BANKED
;U1TXEN=1   'Enable TX1
	bsf	U1CON0,U1TXEN,BANKED
;U1RXEN=1   'Enable RX1
	bsf	U1CON0,U1RXEN,BANKED
;ON_U1CON1=1 'Enable USART1
	bsf	U1CON1,ON_U1CON1,BANKED
	banksel	0
	return

;********************************************************************************

;Source: epd_epd2in13d.h (160)
INIT_EPD2IN13D
;dim _GLCDPagesL, _GLCDPagesH  as byte
;asm showdebug Current_buffer_size_is BUFFWIDTH
;current_buffer_size_is 212
;Dir   EPD_DC     OUT
	bcf	TRISA,0,ACCESS
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
;wait 300 ms
	movlw	44
	movwf	SysWaitTempMS,ACCESS
	movlw	1
	movwf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;SET EPD_RESET OFF
	bcf	LATD,2,ACCESS
;wait 200 ms
	movlw	200
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;SET EPD_RESET ON
	bsf	LATD,2,ACCESS
;wait 300 ms
	movlw	44
	movwf	SysWaitTempMS,ACCESS
	movlw	1
	movwf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;SendCommand_EPD2in13D(BOOSTER_SOFT_START)
	movlw	6
	movwf	EPD2IN13D_COMMAND,BANKED
	call	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0x17)
	movlw	23
	movwf	EPD2IN13D_DATA,BANKED
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x17)
	movlw	23
	movwf	EPD2IN13D_DATA,BANKED
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x17)
	movlw	23
	movwf	EPD2IN13D_DATA,BANKED
	call	SENDDATA_EPD2IN13D
;wait 200 ms
	movlw	200
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;SendCommand_EPD2in13D(POWER_SETTING)
	movlw	1
	movwf	EPD2IN13D_COMMAND,BANKED
	call	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0x03)
	movlw	3
	movwf	EPD2IN13D_DATA,BANKED
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x00)
	clrf	EPD2IN13D_DATA,BANKED
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x2B)
	movlw	43
	movwf	EPD2IN13D_DATA,BANKED
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x2B)
	movlw	43
	movwf	EPD2IN13D_DATA,BANKED
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x03)
	movlw	3
	movwf	EPD2IN13D_DATA,BANKED
	call	SENDDATA_EPD2IN13D
;wait 200 ms
	movlw	200
	movwf	SysWaitTempMS,ACCESS
	clrf	SysWaitTempMS_H,ACCESS
	call	Delay_MS
;SendCommand_EPD2in13D(POWER_ON)
	movlw	4
	movwf	EPD2IN13D_COMMAND,BANKED
	call	SENDCOMMAND_EPD2IN13D
;SendCommand_EPD2in13D(PANEL_SETTING)
	clrf	EPD2IN13D_COMMAND,BANKED
	call	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(PANEL_SETTING_VALUE or PANEL_SETTING_KWR )
	movlw	191
	movwf	EPD2IN13D_DATA,BANKED
	call	SENDDATA_EPD2IN13D
;SendCommand_EPD2in13D(PLL_CONTROL)
	movlw	48
	movwf	EPD2IN13D_COMMAND,BANKED
	call	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0x3C)
	movlw	60
	movwf	EPD2IN13D_DATA,BANKED
	call	SENDDATA_EPD2IN13D
;SendCommand_EPD2in13D(RESOLUTION_SETTING)
	movlw	97
	movwf	EPD2IN13D_COMMAND,BANKED
	call	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0x68)
	movlw	104
	movwf	EPD2IN13D_DATA,BANKED
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0x00)
	clrf	EPD2IN13D_DATA,BANKED
	call	SENDDATA_EPD2IN13D
;SendData_EPD2in13D(0xD4)
	movlw	212
	movwf	EPD2IN13D_DATA,BANKED
	call	SENDDATA_EPD2IN13D
;SendCommand_EPD2in13D(VCM_DC_SETTING)
	movlw	130
	movwf	EPD2IN13D_COMMAND,BANKED
	call	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0x12)
	movlw	18
	movwf	EPD2IN13D_DATA,BANKED
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
;GLCDFontWidth = 6
	movlw	6
	movwf	GLCDFONTWIDTH,BANKED
;GLCDCLS
	call	CLS_EPD2IN13D
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
	movwf	EPD2IN13DADDRESSTYPE,BANKED
	call	ROTATE_EPD2IN13D
;GLCDfntDefault = 0
	clrf	GLCDFNTDEFAULT,BANKED
;GLCDfntDefaultsize = 1
	movlw	1
	movwf	GLCDFNTDEFAULTSIZE,BANKED
;GLCDfntDefaultHeight = 8
	movlw	8
	movwf	GLCDFNTDEFAULTHEIGHT,BANKED
;_GLCDPagesH = EPD_N_PAGE - 1
	movlw	12
	banksel	_GLCDPAGESH
	movwf	_GLCDPAGESH,BANKED
;_GLCDPagesL = 0
	clrf	_GLCDPAGESL,BANKED
;_GLCDPage = 0
	clrf	_GLCDPAGE,BANKED
	banksel	0
	return

;********************************************************************************

;Source: string.h (354)
FN_LEFT
;Empty input?
;If SysInString(0) = 0 Then
	movffl	SysSYSINSTRINGHandler,AFSR0
	movffl	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	INDF0,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF197
;Left(0) = 0
	banksel	SYSLEFT_0
	clrf	SYSLEFT_0,BANKED
;Exit Function
	banksel	0
	return
;End If
ENDIF197
;Input length too high?
;If SysInString(0) < SysCharCount Then
	movffl	SysSYSINSTRINGHandler,AFSR0
	movffl	SysSYSINSTRINGHandler_H,AFSR0_H
	banksel	SYSCHARCOUNT
	movf	SYSCHARCOUNT,W,BANKED
	subwf	INDF0,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	ENDIF198
;SysCharCount = SysInString(0)
	movffl	SysSYSINSTRINGHandler,AFSR0
	movffl	SysSYSINSTRINGHandler_H,AFSR0_H
	movffl	INDF0,SYSCHARCOUNT
;End If
ENDIF198
;Copy leftmost characters
;For SysStringTemp = 1 To SysCharCount
	clrf	SYSSTRINGTEMP,BANKED
	movlw	1
	subwf	SYSCHARCOUNT,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd30
SysForLoop30
	incf	SYSSTRINGTEMP,F,BANKED
;Left(SysStringTemp) = SysInString(SysStringTemp)
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	SysSYSINSTRINGHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysSYSINSTRINGHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movffl	POSTINC0,SysArrayTemp2
	movff	SysArrayTemp2,SysArrayTemp1
	lfsr	0,LEFT
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movffl	SysArrayTemp1,POSTINC0
;Next
	movf	SYSCHARCOUNT,W,BANKED
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop30
SysForLoopEnd30
;Left(0) = SysCharCount
	movffl	SYSCHARCOUNT,SYSLEFT_0
	banksel	0
	return

;********************************************************************************

;Source: string.h (40)
FN_LEN
;Len = LENTemp(0)
	movffl	SysLENTEMPHandler,AFSR0
	movffl	SysLENTEMPHandler_H,AFSR0_H
	movffl	INDF0,LEN
	return

;********************************************************************************

;Source: glcd.h (1484)
LINE
;dim LineStepX as integer
;dim LineStepY as integer
;dim LineDiffX, LineDiffY as integer
;dim LineDiffX_x2, LineDiffY_x2 as integer
;dim LineErr as integer
;LineDiffX = 0
	banksel	LINEDIFFX
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
	banksel	0
	call	SysCompLessThanINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE36_1
;LineStepX = 1
	movlw	1
	banksel	LINESTEPX
	movwf	LINESTEPX,BANKED
	clrf	LINESTEPX_H,BANKED
;else
	bra	ENDIF36
ELSE36_1
;LineStepX = -1
	banksel	LINESTEPX
	setf	LINESTEPX,BANKED
	setf	LINESTEPX_H,BANKED
;end if
ENDIF36
;if (LineDiffY > 0) then
	movff	LINEDIFFY,SysINTEGERTempB
	movff	LINEDIFFY_H,SysINTEGERTempB_H
	clrf	SysINTEGERTempA,ACCESS
	clrf	SysINTEGERTempA_H,ACCESS
	banksel	0
	call	SysCompLessThanINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE37_1
;LineStepY = 1
	movlw	1
	banksel	LINESTEPY
	movwf	LINESTEPY,BANKED
	clrf	LINESTEPY_H,BANKED
;else
	bra	ENDIF37
ELSE37_1
;LineStepY = -1
	banksel	LINESTEPY
	setf	LINESTEPY,BANKED
	setf	LINESTEPY_H,BANKED
;end if
ENDIF37
;LineDiffX = LineStepX * LineDiffX
	movff	LINESTEPX,SysINTEGERTempA
	movff	LINESTEPX_H,SysINTEGERTempA_H
	movff	LINEDIFFX,SysINTEGERTempB
	movff	LINEDIFFX_H,SysINTEGERTempB_H
	banksel	0
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
	bra	ELSE38_1
;LineErr = LineDiffY_x2 - LineDiffX
	banksel	LINEDIFFX
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
	banksel	0
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
	banksel	LINESTEPX
	movf	LINESTEPX,W,BANKED
	addwf	LINEX1,F,BANKED
	movf	LINESTEPX_H,W,BANKED
	addwfc	LINEX1_H,F,BANKED
;if ( LineErr < 0) then
	movff	LINEERR,SysINTEGERTempA
	movff	LINEERR_H,SysINTEGERTempA_H
	clrf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	banksel	0
	call	SysCompLessThanINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE39_1
;LineErr += LineDiffY_x2
	banksel	LINEDIFFY_X2
	movf	LINEDIFFY_X2,W,BANKED
	addwf	LINEERR,F,BANKED
	movf	LINEDIFFY_X2_H,W,BANKED
	addwfc	LINEERR_H,F,BANKED
;else
	bra	ENDIF39
ELSE39_1
;LineErr += ( LineDiffY_x2 - LineDiffX_x2 )
	banksel	LINEDIFFX_X2
	movf	LINEDIFFX_X2,W,BANKED
	subwf	LINEDIFFY_X2,W,BANKED
	movwf	SysTemp1,BANKED
	movf	LINEDIFFX_X2_H,W,BANKED
	subwfb	LINEDIFFY_X2_H,W,BANKED
	movwf	SysTemp1_H,BANKED
	movf	SysTemp1,W,BANKED
	addwf	LINEERR,F,BANKED
	movf	SysTemp1_H,W,BANKED
	addwfc	LINEERR_H,F,BANKED
;LineY1 += LineStepY
	movf	LINESTEPY,W,BANKED
	addwf	LINEY1,F,BANKED
	movf	LINESTEPY_H,W,BANKED
	addwfc	LINEY1_H,F,BANKED
;end if
ENDIF39
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
	bra	ENDIF38
ELSE38_1
;LineErr = LineDiffX_x2 - LineDiffY
	banksel	LINEDIFFY
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
	banksel	0
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
	banksel	LINESTEPY
	movf	LINESTEPY,W,BANKED
	addwf	LINEY1,F,BANKED
	movf	LINESTEPY_H,W,BANKED
	addwfc	LINEY1_H,F,BANKED
;if ( LineErr < 0) then
	movff	LINEERR,SysINTEGERTempA
	movff	LINEERR_H,SysINTEGERTempA_H
	clrf	SysINTEGERTempB,ACCESS
	clrf	SysINTEGERTempB_H,ACCESS
	banksel	0
	call	SysCompLessThanINT
	btfss	SysByteTempX,0,ACCESS
	bra	ELSE40_1
;LineErr += LineDiffX_x2
	banksel	LINEDIFFX_X2
	movf	LINEDIFFX_X2,W,BANKED
	addwf	LINEERR,F,BANKED
	movf	LINEDIFFX_X2_H,W,BANKED
	addwfc	LINEERR_H,F,BANKED
;else
	bra	ENDIF40
ELSE40_1
;LineErr += ( LineDiffX_x2 - LineDiffY_x2 )
	banksel	LINEDIFFY_X2
	movf	LINEDIFFY_X2,W,BANKED
	subwf	LINEDIFFX_X2,W,BANKED
	movwf	SysTemp1,BANKED
	movf	LINEDIFFY_X2_H,W,BANKED
	subwfb	LINEDIFFX_X2_H,W,BANKED
	movwf	SysTemp1_H,BANKED
	movf	SysTemp1,W,BANKED
	addwf	LINEERR,F,BANKED
	movf	SysTemp1_H,W,BANKED
	addwfc	LINEERR_H,F,BANKED
;LineX1 += LineStepX
	movf	LINESTEPX,W,BANKED
	addwf	LINEX1,F,BANKED
	movf	LINESTEPX_H,W,BANKED
	addwfc	LINEX1_H,F,BANKED
;end if
ENDIF40
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
ENDIF38
	return

;********************************************************************************

;Source: epd_epd2in13d.h (320)
LOADLUTS_EPD2IN13D
;Dim DataVar as byte
;Dim Counter as Word
;SendCommand_EPD2in13D(VCM_DC_SETTING)
	movlw	130
	movwf	EPD2IN13D_COMMAND,BANKED
	call	SENDCOMMAND_EPD2IN13D
;SendData_EPD2in13D(0x00)
	clrf	EPD2IN13D_DATA,BANKED
	call	SENDDATA_EPD2IN13D
;SendCommand_EPD2in13D(VCOM_AND_DATA_INTERVAL_SETTING)
	movlw	80
	movwf	EPD2IN13D_COMMAND,BANKED
	call	SENDCOMMAND_EPD2IN13D
;Mask VCOM_AND_DATA_INTERVAL bits and then Mask the user bits.
;SendData_EPD2in13D( (0x90 AND 0xF0 ) or ( VCOM_AND_DATA_INTERVAL AND 0X0F ))
	movlw	151
	movwf	EPD2IN13D_DATA,BANKED
	call	SENDDATA_EPD2IN13D
;SendCommand_EPD2in13D(0x20) 'VCOM LUT
	movlw	32
	movwf	EPD2IN13D_COMMAND,BANKED
	call	SENDCOMMAND_EPD2IN13D
;for EPD_Counter=1 to 44
	clrf	EPD_COUNTER,BANKED
SysForLoop35
	incf	EPD_COUNTER,F,BANKED
;ReadTable Lut_Vcom, EPD_Counter, DataVar
	movff	EPD_COUNTER,SYSSTRINGA
	rcall	LUT_VCOM
	movwf	DATAVAR,ACCESS
;SendData_EPD2in13D(DataVar)
	movff	DATAVAR,EPD2IN13D_DATA
	call	SENDDATA_EPD2IN13D
;next
	movlw	44
	subwf	EPD_COUNTER,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop35
SysForLoopEnd35
;SendCommand_EPD2in13D(0x21) 'WW LUT
	movlw	33
	movwf	EPD2IN13D_COMMAND,BANKED
	call	SENDCOMMAND_EPD2IN13D
;for EPD_Counter=1 to 42
	clrf	EPD_COUNTER,BANKED
SysForLoop36
	incf	EPD_COUNTER,F,BANKED
;ReadTable Lut_WW, EPD_Counter, DataVar
	movff	EPD_COUNTER,SYSSTRINGA
	rcall	LUT_WW
	movwf	DATAVAR,ACCESS
;SendData_EPD2in13D(DataVar)
	movff	DATAVAR,EPD2IN13D_DATA
	call	SENDDATA_EPD2IN13D
;next
	movlw	42
	subwf	EPD_COUNTER,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop36
SysForLoopEnd36
;SendCommand_EPD2in13D(0x22) 'BW LUT
	movlw	34
	movwf	EPD2IN13D_COMMAND,BANKED
	call	SENDCOMMAND_EPD2IN13D
;for EPD_Counter=1 to 42
	clrf	EPD_COUNTER,BANKED
SysForLoop37
	incf	EPD_COUNTER,F,BANKED
;ReadTable Lut_BW, EPD_Counter, DataVar
	movff	EPD_COUNTER,SYSSTRINGA
	rcall	LUT_BW
	movwf	DATAVAR,ACCESS
;SendData_EPD2in13D(DataVar)
	movff	DATAVAR,EPD2IN13D_DATA
	call	SENDDATA_EPD2IN13D
;next
	movlw	42
	subwf	EPD_COUNTER,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop37
SysForLoopEnd37
;SendCommand_EPD2in13D(0x23) 'WB LUT
	movlw	35
	movwf	EPD2IN13D_COMMAND,BANKED
	call	SENDCOMMAND_EPD2IN13D
;for EPD_Counter=1 to 42
	clrf	EPD_COUNTER,BANKED
SysForLoop38
	incf	EPD_COUNTER,F,BANKED
;ReadTable Lut_WB, EPD_Counter, DataVar
	movff	EPD_COUNTER,SYSSTRINGA
	rcall	LUT_WB
	movwf	DATAVAR,ACCESS
;SendData_EPD2in13D(DataVar)
	movff	DATAVAR,EPD2IN13D_DATA
	call	SENDDATA_EPD2IN13D
;next
	movlw	42
	subwf	EPD_COUNTER,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop38
SysForLoopEnd38
;SendCommand_EPD2in13D(0x24) 'BB LUT
	movlw	36
	movwf	EPD2IN13D_COMMAND,BANKED
	call	SENDCOMMAND_EPD2IN13D
;for EPD_Counter=1 to 42
	clrf	EPD_COUNTER,BANKED
SysForLoop39
	incf	EPD_COUNTER,F,BANKED
;ReadTable Lut_BB, EPD_Counter, DataVar
	movff	EPD_COUNTER,SYSSTRINGA
	rcall	LUT_BB
	movwf	DATAVAR,ACCESS
;SendData_EPD2in13D(DataVar)
	movff	DATAVAR,EPD2IN13D_DATA
	call	SENDDATA_EPD2IN13D
;next
	movlw	42
	subwf	EPD_COUNTER,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop39
SysForLoopEnd39
	return

;********************************************************************************

;Source: MySDLib.h (431)
LSB_TO_MSB
;B1=FnLSL(B1,8)
	movff	B1,SYSLONGTEMPB
	movff	B1_H,SYSLONGTEMPB_H
	movff	B1_U,SYSLONGTEMPB_U
	movff	B1_E,SYSLONGTEMPB_E
	movlw	8
	banksel	NUMBITS
	movwf	NUMBITS,BANKED
	banksel	0
	call	FN_FNLSL545
	movff	SYSFNLSLLONG,B1
	movff	SYSFNLSLLONG_H,B1_H
	movff	SYSFNLSLLONG_U,B1_U
	movff	SYSFNLSLLONG_E,B1_E
;B2=FnLSL(B2,16)
	movff	B2,SYSLONGTEMPB
	movff	B2_H,SYSLONGTEMPB_H
	movff	B2_U,SYSLONGTEMPB_U
	movff	B2_E,SYSLONGTEMPB_E
	movlw	16
	banksel	NUMBITS
	movwf	NUMBITS,BANKED
	banksel	0
	call	FN_FNLSL545
	movff	SYSFNLSLLONG,B2
	movff	SYSFNLSLLONG_H,B2_H
	movff	SYSFNLSLLONG_U,B2_U
	movff	SYSFNLSLLONG_E,B2_E
;B3=FnLSL(B3,24)
	movff	B3,SYSLONGTEMPB
	movff	B3_H,SYSLONGTEMPB_H
	movff	B3_U,SYSLONGTEMPB_U
	movff	B3_E,SYSLONGTEMPB_E
	movlw	24
	banksel	NUMBITS
	movwf	NUMBITS,BANKED
	banksel	0
	call	FN_FNLSL545
	movff	SYSFNLSLLONG,B3
	movff	SYSFNLSLLONG_H,B3_H
	movff	SYSFNLSLLONG_U,B3_U
	movff	SYSFNLSLLONG_E,B3_E
;Output=B0+B1+B2+B3
	movf	B1,W,ACCESS
	addwf	B0,W,ACCESS
	banksel	SYSTEMP1
	movwf	SysTemp1,BANKED
	movf	B1_H,W,ACCESS
	addwfc	B0_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movf	B1_U,W,ACCESS
	addwfc	B0_U,W,ACCESS
	movwf	SysTemp1_U,BANKED
	movf	B1_E,W,ACCESS
	addwfc	B0_E,W,ACCESS
	movwf	SysTemp1_E,BANKED
	movf	B2,W,ACCESS
	addwf	SysTemp1,W,BANKED
	movwf	SysTemp2,BANKED
	movf	B2_H,W,ACCESS
	addwfc	SysTemp1_H,W,BANKED
	movwf	SysTemp2_H,BANKED
	movf	B2_U,W,ACCESS
	addwfc	SysTemp1_U,W,BANKED
	movwf	SysTemp2_U,BANKED
	movf	B2_E,W,ACCESS
	addwfc	SysTemp1_E,W,BANKED
	movwf	SysTemp2_E,BANKED
	movf	B3,W,ACCESS
	addwf	SysTemp2,W,BANKED
	movwf	OUTPUT,BANKED
	movf	B3_H,W,ACCESS
	addwfc	SysTemp2_H,W,BANKED
	movwf	OUTPUT_H,BANKED
	movf	B3_U,W,ACCESS
	addwfc	SysTemp2_U,W,BANKED
	movwf	OUTPUT_U,BANKED
	movf	B3_E,W,ACCESS
	addwfc	SysTemp2_E,W,BANKED
	movwf	OUTPUT_E,BANKED
	banksel	0
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
	movlw	upper TableLUT_BB
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
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
	movlw	upper TableLUT_BW
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
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
	movlw	upper TableLUT_VCOM
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
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
	movlw	upper TableLUT_WB
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
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
	movlw	upper TableLUT_WW
	btfsc	STATUS, C,ACCESS
	addlw	1
	movwf	TBLPTRU,ACCESS
	tblrd*
	movf	TABLAT, W,ACCESS
	return
TableLUT_WW
	db	42,64,8,0,0,0,2,144,40,40,0,0,1,64,20,0,0,0,1,160,18,18,0,0,1

;********************************************************************************

;Source: MySDLib.h (387)
PARTITION_ENTRY_AND_RELEVANT_DATA
;Draw_Line(1,60,"-")
	movlw	1
	banksel	LINE_TYPE
	movwf	LINE_TYPE,BANKED
	movlw	60
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable33
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable33
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable33
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	call	DRAW_LINE
;sertxd(1,"     Reading MBR at 0x1BE and ","Partition Volume ID data",0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable142
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable142
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable142
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM4
	movlw	low StringTable143
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable143
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable143
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM4
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM4
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;Draw_Line(1,60,"-"):Draw_Line(1,60," ")
	movlw	1
	banksel	LINE_TYPE
	movwf	LINE_TYPE,BANKED
	movlw	60
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable33
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable33
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable33
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	call	DRAW_LINE
	movlw	1
	banksel	LINE_TYPE
	movwf	LINE_TYPE,BANKED
	movlw	60
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	call	DRAW_LINE
;Read_Partit_Entry          'Read Partition begin address at 0x1BE
	rcall	READ_PARTIT_ENTRY
;Read_Relevant_Partit_Data  'Read most relevant Partition Data
	call	READ_RELEVANT_PARTIT_DATA
;sertxd(1,"  File System ",SD_MyString,0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable144
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable144
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable144
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysSTRINGAHandler_H,BANKED
	movlw	low SD_MYSTRING
	movwf	SysINPUTSHandler,BANKED
	movlw	high SD_MYSTRING
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;sertxd(1,"  File System Ver Num.=",File_System_Ver_Num,0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable145
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable145
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable145
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysSTRINGAHandler_H,BANKED
	movff	FILE_SYSTEM_VER_NUM,INPUTB
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD8
;sertxd(1,"  Volume_Label=",SD_MyString1,0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable146
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable146
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable146
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysSTRINGAHandler_H,BANKED
	movlw	low SD_MYSTRING1
	movwf	SysINPUTSHandler,BANKED
	movlw	high SD_MYSTRING1
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;sertxd(1,"  N. Bytes per Sector=",N_Bytes_per_Sector,0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable147
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable147
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable147
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysSTRINGAHandler_H,BANKED
	movff	N_BYTES_PER_SECTOR,INPUTW
	movff	N_BYTES_PER_SECTOR_H,INPUTW_H
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD9
;sertxd(1,"  N. Sector per Cluster=",N_Sector_per_cluster,0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable148
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable148
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable148
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysSTRINGAHandler_H,BANKED
	movff	N_SECTOR_PER_CLUSTER,INPUTB
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD8
;sertxd(1,"  N. Reserved Sectors=",N_Reserved_Sector,0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable149
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable149
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable149
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysSTRINGAHandler_H,BANKED
	movff	N_RESERVED_SECTOR,INPUTW
	movff	N_RESERVED_SECTOR_H,INPUTW_H
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD9
;sertxd(1,"  N. FATS=",N_FATS,0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable150
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable150
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable150
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysSTRINGAHandler_H,BANKED
	movff	N_FATS,INPUTB
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD8
;sertxd(1,"  N. Sector per Fat=",N_Sectors_per_Fat,0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable151
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable151
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable151
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysSTRINGAHandler_H,BANKED
	movff	N_SECTORS_PER_FAT,INPUTL
	movff	N_SECTORS_PER_FAT_H,INPUTL_H
	movff	N_SECTORS_PER_FAT_U,INPUTL_U
	movff	N_SECTORS_PER_FAT_E,INPUTL_E
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD10
;sertxd(1,"  N. Cluster of Root Dir=","2",0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable152
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable152
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable152
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM4
	movlw	low StringTable153
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable153
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable153
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM4
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM4
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD7
;Draw_Line(1,60," "): Draw_Line(2,30,"-"):Draw_Line(1,60," ")
	movlw	1
	banksel	LINE_TYPE
	movwf	LINE_TYPE,BANKED
	movlw	60
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	call	DRAW_LINE
	movlw	2
	banksel	LINE_TYPE
	movwf	LINE_TYPE,BANKED
	movlw	30
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable33
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable33
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable33
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	call	DRAW_LINE
	movlw	1
	banksel	LINE_TYPE
	movwf	LINE_TYPE,BANKED
	movlw	60
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	call	DRAW_LINE
;sertxd(1,"  Partition_Begin_LBA=",Partition_Begin_LBA,0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable154
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable154
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable154
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysSTRINGAHandler_H,BANKED
	movff	PARTITION_BEGIN_LBA,INPUTL
	movff	PARTITION_BEGIN_LBA_H,INPUTL_H
	movff	PARTITION_BEGIN_LBA_U,INPUTL_U
	movff	PARTITION_BEGIN_LBA_E,INPUTL_E
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD10
;Fat_Begin_LBA=Partition_Begin_LBA+N_Reserved_Sector
	banksel	N_RESERVED_SECTOR
	movf	N_RESERVED_SECTOR,W,BANKED
	addwf	PARTITION_BEGIN_LBA,W,BANKED
	banksel	FAT_BEGIN_LBA
	movwf	FAT_BEGIN_LBA,BANKED
	banksel	N_RESERVED_SECTOR_H
	movf	N_RESERVED_SECTOR_H,W,BANKED
	addwfc	PARTITION_BEGIN_LBA_H,W,BANKED
	banksel	FAT_BEGIN_LBA_H
	movwf	FAT_BEGIN_LBA_H,BANKED
	movlw	0
	banksel	PARTITION_BEGIN_LBA_U
	addwfc	PARTITION_BEGIN_LBA_U,W,BANKED
	banksel	FAT_BEGIN_LBA_U
	movwf	FAT_BEGIN_LBA_U,BANKED
	movlw	0
	banksel	PARTITION_BEGIN_LBA_E
	addwfc	PARTITION_BEGIN_LBA_E,W,BANKED
	banksel	FAT_BEGIN_LBA_E
	movwf	FAT_BEGIN_LBA_E,BANKED
;Cluster_Begin_LBA=Fat_Begin_LBA+N_FATS*N_Sectors_per_Fat
	movff	N_FATS,SysLONGTempA
	clrf	SysLONGTempA_H,ACCESS
	clrf	SysLONGTempA_U,ACCESS
	clrf	SysLONGTempA_E,ACCESS
	movff	N_SECTORS_PER_FAT,SysLONGTempB
	movff	N_SECTORS_PER_FAT_H,SysLONGTempB_H
	movff	N_SECTORS_PER_FAT_U,SysLONGTempB_U
	movff	N_SECTORS_PER_FAT_E,SysLONGTempB_E
	call	SysMultSub32
	movf	SysLONGTempX,W,ACCESS
	addwf	FAT_BEGIN_LBA,W,BANKED
	movwf	CLUSTER_BEGIN_LBA,ACCESS
	movf	SysLONGTempX_H,W,ACCESS
	addwfc	FAT_BEGIN_LBA_H,W,BANKED
	movwf	CLUSTER_BEGIN_LBA_H,ACCESS
	movf	SysLONGTempX_U,W,ACCESS
	addwfc	FAT_BEGIN_LBA_U,W,BANKED
	movwf	CLUSTER_BEGIN_LBA_U,ACCESS
	movf	SysLONGTempX_E,W,ACCESS
	addwfc	FAT_BEGIN_LBA_E,W,BANKED
	movwf	CLUSTER_BEGIN_LBA_E,ACCESS
;sertxd(1,"  Fat_Begin_LBA=",Fat_Begin_LBA,0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable155
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable155
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable155
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysSTRINGAHandler_H,BANKED
	movff	FAT_BEGIN_LBA,INPUTL
	movff	FAT_BEGIN_LBA_H,INPUTL_H
	movff	FAT_BEGIN_LBA_U,INPUTL_U
	movff	FAT_BEGIN_LBA_E,INPUTL_E
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD10
;sertxd(1,"  Cluster_Begin_LBA=",Cluster_Begin_LBA,0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable156
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable156
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable156
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysSTRINGAHandler_H,BANKED
	movff	CLUSTER_BEGIN_LBA,INPUTL
	movff	CLUSTER_BEGIN_LBA_H,INPUTL_H
	movff	CLUSTER_BEGIN_LBA_U,INPUTL_U
	movff	CLUSTER_BEGIN_LBA_E,INPUTL_E
	clrf	CRLF2,ACCESS
	banksel	0
	call	SERTXD10
;Draw_Line(1,60,"-"): Draw_Line(1,60," ")
	movlw	1
	banksel	LINE_TYPE
	movwf	LINE_TYPE,BANKED
	movlw	60
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable33
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable33
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable33
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	call	DRAW_LINE
	movlw	1
	banksel	LINE_TYPE
	movwf	LINE_TYPE,BANKED
	movlw	60
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	goto	DRAW_LINE

;********************************************************************************

;Source: epd_epd2in13d.h (426)
PIXEL_TO_DISPLAY_EPD2IN13D
;Dim EPD_Ind_raw, EPD_Ind_col as Word
;if _GLCDPage = 0 then
	banksel	_GLCDPAGE
	movf	_GLCDPAGE,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF133
;Clear down 'OLD' data - to prevent flashing
;SendCommand_EPD2in13D(Data_Transmission_1)
	movlw	16
	banksel	EPD2IN13D_COMMAND
	movwf	EPD2IN13D_COMMAND,BANKED
	call	SENDCOMMAND_EPD2IN13D
;SET EPD_CS OFF
	bcf	LATC,1,ACCESS
;SET EPD_DC ON
	bsf	LATA,0,ACCESS
;for EPD_Ind_raw=1 to GLCD_Height
	clrf	EPD_IND_RAW,BANKED
	clrf	EPD_IND_RAW_H,BANKED
SysForLoop18
	incf	EPD_IND_RAW,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	EPD_IND_RAW_H,F,BANKED
;for EPD_Ind_col=1 to GLCD_Width
	clrf	EPD_IND_COL,BANKED
	clrf	EPD_IND_COL_H,BANKED
SysForLoop19
	incf	EPD_IND_COL,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	EPD_IND_COL_H,F,BANKED
;Replaced with macro for speed              SendData_EPD2in13D(GLCDBackGround)
;EPD2in13D_Data = GLCDBackGround
	movff	GLCDBACKGROUND,EPD2IN13D_DATA
;SendData_EPD2in13D_Macro
;Macro Source: epd_epd2in13d.h (560)
;REPEAT 8
	movlw	8
	banksel	SYSREPEATTEMP13
	movwf	SysRepeatTemp13,BANKED
SysRepeatLoop13
;IF EPD2in13D_Data.7 = ON THEN
	banksel	EPD2IN13D_DATA
	btfss	EPD2IN13D_DATA,7,BANKED
	bra	ELSE136_1
;Set EPD_DO ON
	bsf	LATC,5,ACCESS
;ELSE
	bra	ENDIF136
ELSE136_1
;Set EPD_DO OFF
	bcf	LATC,5,ACCESS
;END IF
ENDIF136
;SET EPD_SCK On
	bsf	LATC,3,ACCESS
;Rotate EPD2in13D_Data left
	rlcf	EPD2IN13D_DATA,F,BANKED
;Set EPD_SCK Off
	bcf	LATC,3,ACCESS
;END REPEAT
	banksel	SYSREPEATTEMP13
	decfsz	SysRepeatTemp13,F,BANKED
	bra	SysRepeatLoop13
SysRepeatLoopEnd13
;next
	movff	EPD_IND_COL,SysWORDTempA
	movff	EPD_IND_COL_H,SysWORDTempA_H
	movlw	104
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop19
SysForLoopEnd19
;next
	movff	EPD_IND_RAW,SysWORDTempA
	movff	EPD_IND_RAW_H,SysWORDTempA_H
	movlw	212
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop18
SysForLoopEnd18
;SET EPD_CS ON
	bsf	LATC,1,ACCESS
;SendCommand_EPD2in13D(DATA_TRANSMISSION_2)
	movlw	19
	movwf	EPD2IN13D_COMMAND,BANKED
	call	SENDCOMMAND_EPD2IN13D
;end if
ENDIF133
;dim EPD2in13D_Data as byte
;We need to set the signals as we are optimising the code by using the macro
;SET EPD_CS OFF
	bcf	LATC,1,ACCESS
;SET EPD_DC ON
	bsf	LATA,0,ACCESS
;for EPD_Ind_raw=1 to BUFFWIDTH
	banksel	EPD_IND_RAW
	clrf	EPD_IND_RAW,BANKED
	clrf	EPD_IND_RAW_H,BANKED
SysForLoop20
	incf	EPD_IND_RAW,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	EPD_IND_RAW_H,F,BANKED
;replaced with macro for speed
;SendData_EPD2in13D(EPD_Buffer(EPD_Ind_raw))
;EPD2in13D_Data = EPD_Buffer(EPD_Ind_raw)
	lfsr	0,EPD_BUFFER
	movf	EPD_IND_RAW,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	EPD_IND_RAW_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movffl	INDF0,EPD2IN13D_DATA
;The following line is intentionally commented out, but, it shows the orientation of the pixels to the array. Uncomment to force a two (when the value is 3!) byte write to the Display
;You can then examine the display to see the orientation of the pixels.
;This will write the bytes at the top of each page - so, do not be surprised!
;if EPD_Ind_raw < 3 then EPD2in13D_Data = GLCDForeground
;This macro assumes the use of the variable EPD2in13D_Data
;SendData_EPD2in13D_Macro
;Macro Source: epd_epd2in13d.h (560)
;REPEAT 8
	movlw	8
	banksel	SYSREPEATTEMP13
	movwf	SysRepeatTemp13,BANKED
SysRepeatLoop14
;IF EPD2in13D_Data.7 = ON THEN
	banksel	EPD2IN13D_DATA
	btfss	EPD2IN13D_DATA,7,BANKED
	bra	ELSE134_1
;Set EPD_DO ON
	bsf	LATC,5,ACCESS
;ELSE
	bra	ENDIF134
ELSE134_1
;Set EPD_DO OFF
	bcf	LATC,5,ACCESS
;END IF
ENDIF134
;SET EPD_SCK On
	bsf	LATC,3,ACCESS
;Rotate EPD2in13D_Data left
	rlcf	EPD2IN13D_DATA,F,BANKED
;Set EPD_SCK Off
	bcf	LATC,3,ACCESS
;END REPEAT
	banksel	SYSREPEATTEMP13
	decfsz	SysRepeatTemp13,F,BANKED
	bra	SysRepeatLoop14
SysRepeatLoopEnd14
;Now clear the buffer
;EPD_Buffer(EPD_Ind_raw) = GLCDBackground
	lfsr	0,EPD_BUFFER
	banksel	EPD_IND_RAW
	movf	EPD_IND_RAW,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	EPD_IND_RAW_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movffl	GLCDBACKGROUND,INDF0
;next
	movff	EPD_IND_RAW,SysWORDTempA
	movff	EPD_IND_RAW_H,SysWORDTempA_H
	movlw	212
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop20
SysForLoopEnd20
;SET EPD_CS ON
	bsf	LATC,1,ACCESS
	return

;********************************************************************************

;Source: E_paper-18F47K42_SD_SDLIB_Transaction.gcb (301)
PRINTSTRING_EXAMPLE
;dim xloop as byte
;for xloop = 1 to 26
	banksel	XLOOP
	clrf	XLOOP,BANKED
SysForLoop5
	incf	XLOOP,F,BANKED
;GLCDPrintString ""
;GLCDPrintString "Line "
;GLCDPrintStringLN Str(xloop)
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
	call	GLCDPRINTSTRINGLN
;next
	movlw	26
	banksel	XLOOP
	subwf	XLOOP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop5
SysForLoopEnd5
	banksel	0
	return

;********************************************************************************

;Source: epd_epd2in13d.h (772)
PSET_EPD2IN13D
;Dim EPD_Ind, EPD_N_Col, EPD_N_raw, EPD_Ind_Trans as word
;Dim remainder as byte
;Dim DataVar as byte
;Dim value as bit
;Dim GLCD_Time_Buff as word
;Dim GLCDDataTemp, GLCDY_Temp, GLCDY_withinPage  as word
;Select Case EPD2in13DAddressType
;case Landscape
SysSelect5Case1
	decf	EPD2IN13DADDRESSTYPE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case2
;GLCDDataTemp = GLCDX
	movff	GLCDX,GLCDDATATEMP
	movff	GLCDX_H,GLCDDATATEMP_H
;GLCDX = GLCDY
	movff	GLCDY,GLCDX
	movff	GLCDY_H,GLCDX_H
;GLCDY = GLCD_HEIGHT - GLCDDataTemp - 1
	movf	GLCDDATATEMP,W,BANKED
	sublw	212
	banksel	SYSTEMP1
	movwf	SysTemp1,BANKED
	clrf	SysTemp3,BANKED
	banksel	GLCDDATATEMP_H
	movf	GLCDDATATEMP_H,W,BANKED
	banksel	SYSTEMP3
	subwfb	SysTemp3,W,BANKED
	movwf	SysTemp1_H,BANKED
	movlw	1
	subwf	SysTemp1,W,BANKED
	banksel	GLCDY
	movwf	GLCDY,BANKED
	movlw	0
	banksel	SYSTEMP1_H
	subwfb	SysTemp1_H,W,BANKED
	banksel	GLCDY_H
	movwf	GLCDY_H,BANKED
;case Landscape_Rev
	bra	SysSelectEnd5
SysSelect5Case2
	movlw	3
	subwf	EPD2IN13DADDRESSTYPE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case3
;GLCDDataTemp = GLCDX
	movff	GLCDX,GLCDDATATEMP
	movff	GLCDX_H,GLCDDATATEMP_H
;GLCDX = GLCD_WIDTH  - GLCDY - 1
	movf	GLCDY,W,BANKED
	sublw	104
	banksel	SYSTEMP1
	movwf	SysTemp1,BANKED
	clrf	SysTemp3,BANKED
	banksel	GLCDY_H
	movf	GLCDY_H,W,BANKED
	banksel	SYSTEMP3
	subwfb	SysTemp3,W,BANKED
	movwf	SysTemp1_H,BANKED
	movlw	1
	subwf	SysTemp1,W,BANKED
	banksel	GLCDX
	movwf	GLCDX,BANKED
	movlw	0
	banksel	SYSTEMP1_H
	subwfb	SysTemp1_H,W,BANKED
	banksel	GLCDX_H
	movwf	GLCDX_H,BANKED
;GLCDY = GLCDDataTemp
	movff	GLCDDATATEMP,GLCDY
	movff	GLCDDATATEMP_H,GLCDY_H
;case Portrait
	bra	SysSelectEnd5
SysSelect5Case3
	movlw	4
	subwf	EPD2IN13DADDRESSTYPE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect5Case4
;Default do nothing
;case Portrait_Rev
	bra	SysSelectEnd5
SysSelect5Case4
	movlw	2
	subwf	EPD2IN13DADDRESSTYPE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd5
;GLCDY = GLCD_HEIGHT - GLCDY - 1
	movf	GLCDY,W,BANKED
	sublw	212
	banksel	SYSTEMP1
	movwf	SysTemp1,BANKED
	clrf	SysTemp3,BANKED
	banksel	GLCDY_H
	movf	GLCDY_H,W,BANKED
	banksel	SYSTEMP3
	subwfb	SysTemp3,W,BANKED
	movwf	SysTemp1_H,BANKED
	movlw	1
	subwf	SysTemp1,W,BANKED
	banksel	GLCDY
	movwf	GLCDY,BANKED
	movlw	0
	banksel	SYSTEMP1_H
	subwfb	SysTemp1_H,W,BANKED
	banksel	GLCDY_H
	movwf	GLCDY_H,BANKED
;GLCDX = GLCD_WIDTH - GLCDX - 1
	movf	GLCDX,W,BANKED
	sublw	104
	banksel	SYSTEMP1
	movwf	SysTemp1,BANKED
	clrf	SysTemp3,BANKED
	banksel	GLCDX_H
	movf	GLCDX_H,W,BANKED
	banksel	SYSTEMP3
	subwfb	SysTemp3,W,BANKED
	movwf	SysTemp1_H,BANKED
	movlw	1
	subwf	SysTemp1,W,BANKED
	banksel	GLCDX
	movwf	GLCDX,BANKED
	movlw	0
	banksel	SYSTEMP1_H
	subwfb	SysTemp1_H,W,BANKED
	banksel	GLCDX_H
	movwf	GLCDX_H,BANKED
;end select
SysSelectEnd5
;Exit if not the current page.
;if  ( GLCDY / EPD_PIXELS_PER_PAGE  ) <> _GLCDPage then
	movff	GLCDY,SysWORDTempA
	movff	GLCDY_H,SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysDivSub16
	movff	SysWORDTempA,SysTemp1
	movff	SysWORDTempA_H,SysTemp1_H
	movff	SysTemp1,SysWORDTempA
	movff	SysTemp1_H,SysWORDTempA_H
	movff	_GLCDPAGE,SysWORDTempB
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompEqual16
	comf	SysByteTempX,F,ACCESS
	btfsc	SysByteTempX,0,ACCESS
;exit sub
	return
;end if
;EPD_N_Col=(GLCDX+1)/8                   'number of the column of the byte to be set
;EPD_N_Col=(GLCDX+1)
	movlw	1
	addwf	GLCDX,W,BANKED
	movwf	EPD_N_COL,BANKED
	movlw	0
	addwfc	GLCDX_H,W,BANKED
	movwf	EPD_N_COL_H,BANKED
;Repeat 3
	movlw	3
	banksel	SYSREPEATTEMP16
	movwf	SysRepeatTemp16,BANKED
SysRepeatLoop16
;Set C Off
	bcf	STATUS,C,ACCESS
;Rotate EPD_N_Col Right
	banksel	EPD_N_COL_H
	rrcf	EPD_N_COL_H,F,BANKED
	rrcf	EPD_N_COL,F,BANKED
;End Repeat
	banksel	SYSREPEATTEMP16
	decfsz	SysRepeatTemp16,F,BANKED
	bra	SysRepeatLoop16
SysRepeatLoopEnd16
;remainder=(GLCDX+1) % 8
	movlw	1
	banksel	GLCDX
	addwf	GLCDX,W,BANKED
	banksel	SYSTEMP1
	movwf	SysTemp1,BANKED
	movlw	0
	banksel	GLCDX_H
	addwfc	GLCDX_H,W,BANKED
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H,BANKED
	movff	SysTemp1,SysWORDTempA
	movff	SysTemp1_H,SysWORDTempA_H
	movlw	8
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	call	SysDivSub16
	movff	SysWORDTempX,REMAINDER
;EPD_N_raw=GLCDY * GLCD_Width8       'number of the column of the byte to be set
	movff	GLCDY,SysWORDTempA
	movff	GLCDY_H,SysWORDTempA_H
	movlw	13
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysMultSub16
	movff	SysWORDTempX,EPD_N_RAW
	movff	SysWORDTempX_H,EPD_N_RAW_H
;if remainder=0 then
	banksel	REMAINDER
	movf	REMAINDER,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE159_1
;EPD_Ind=EPD_N_raw+EPD_N_Col
	banksel	EPD_N_COL
	movf	EPD_N_COL,W,BANKED
	addwf	EPD_N_RAW,W,BANKED
	movwf	EPD_IND,BANKED
	movf	EPD_N_COL_H,W,BANKED
	addwfc	EPD_N_RAW_H,W,BANKED
	movwf	EPD_IND_H,BANKED
;else
	bra	ENDIF159
ELSE159_1
;EPD_Ind=EPD_N_raw+EPD_N_Col+1       'Number of the byte to be set (starting from 1)
	banksel	EPD_N_COL
	movf	EPD_N_COL,W,BANKED
	addwf	EPD_N_RAW,W,BANKED
	banksel	SYSTEMP1
	movwf	SysTemp1,BANKED
	banksel	EPD_N_COL_H
	movf	EPD_N_COL_H,W,BANKED
	addwfc	EPD_N_RAW_H,W,BANKED
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H,BANKED
	movlw	1
	addwf	SysTemp1,W,BANKED
	banksel	EPD_IND
	movwf	EPD_IND,BANKED
	movlw	0
	banksel	SYSTEMP1_H
	addwfc	SysTemp1_H,W,BANKED
	banksel	EPD_IND_H
	movwf	EPD_IND_H,BANKED
;end if
ENDIF159
;GLCD_Time_Buff=_GLCDPage*BUFFWIDTH
	movff	_GLCDPAGE,SysWORDTempA
	clrf	SysWORDTempA_H,ACCESS
	movlw	212
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysMultSub16
	movff	SysWORDTempX,GLCD_TIME_BUFF
	movff	SysWORDTempX_H,GLCD_TIME_BUFF_H
;EPD_Ind_Trans=EPD_Ind
	movff	EPD_IND,EPD_IND_TRANS
	movff	EPD_IND_H,EPD_IND_TRANS_H
;EPD_Ind_Trans=EPD_Ind_Trans-GLCD_Time_Buff
	movf	GLCD_TIME_BUFF,W,BANKED
	subwf	EPD_IND_TRANS,F,BANKED
	movf	GLCD_TIME_BUFF_H,W,BANKED
	subwfb	EPD_IND_TRANS_H,F,BANKED
;if EPD_Ind_Trans>BUFFWIDTH then       'NOTE:it should be a control also for a
	movff	EPD_IND_TRANS,SysWORDTempB
	movff	EPD_IND_TRANS_H,SysWORDTempB_H
	movlw	212
	movwf	SysWORDTempA,ACCESS
	clrf	SysWORDTempA_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
;EXIT SUB                            'lower bound of ind (ind>GLCD_Time_Buff)
	return
;end if                                'However when the lower bound is violated,
;DataVar=EPD_Buffer(EPD_Ind_Trans)     'Ind_Trans should be negative and, due to
	lfsr	0,EPD_BUFFER
	movf	EPD_IND_TRANS,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	EPD_IND_TRANS_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movffl	INDF0,DATAVAR
;Select Case remainder                 'non signed arithmetic, it will be very
;case 0                                'large, thus Exits sub is executed.
SysSelect6Case1
	banksel	REMAINDER
	movf	REMAINDER,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case2
;DataVar.0=GLCDColour.0
	bcf	DATAVAR,0,ACCESS
	banksel	GLCDCOLOUR
	btfsc	GLCDCOLOUR,0,BANKED
	bsf	DATAVAR,0,ACCESS
;case 1
	bra	SysSelectEnd6
SysSelect6Case2
	decf	REMAINDER,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case3
;DataVar.7=GLCDColour.0
	bcf	DATAVAR,7,ACCESS
	banksel	GLCDCOLOUR
	btfsc	GLCDCOLOUR,0,BANKED
	bsf	DATAVAR,7,ACCESS
;case 2
	bra	SysSelectEnd6
SysSelect6Case3
	movlw	2
	subwf	REMAINDER,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case4
;DataVar.6=GLCDColour.0
	bcf	DATAVAR,6,ACCESS
	banksel	GLCDCOLOUR
	btfsc	GLCDCOLOUR,0,BANKED
	bsf	DATAVAR,6,ACCESS
;case 3
	bra	SysSelectEnd6
SysSelect6Case4
	movlw	3
	subwf	REMAINDER,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case5
;DataVar.5=GLCDColour.0
	bcf	DATAVAR,5,ACCESS
	banksel	GLCDCOLOUR
	btfsc	GLCDCOLOUR,0,BANKED
	bsf	DATAVAR,5,ACCESS
;case 4
	bra	SysSelectEnd6
SysSelect6Case5
	movlw	4
	subwf	REMAINDER,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case6
;DataVar.4=GLCDColour.0
	bcf	DATAVAR,4,ACCESS
	banksel	GLCDCOLOUR
	btfsc	GLCDCOLOUR,0,BANKED
	bsf	DATAVAR,4,ACCESS
;case 5
	bra	SysSelectEnd6
SysSelect6Case6
	movlw	5
	subwf	REMAINDER,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case7
;DataVar.3=GLCDColour.0
	bcf	DATAVAR,3,ACCESS
	banksel	GLCDCOLOUR
	btfsc	GLCDCOLOUR,0,BANKED
	bsf	DATAVAR,3,ACCESS
;case 6
	bra	SysSelectEnd6
SysSelect6Case7
	movlw	6
	subwf	REMAINDER,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect6Case8
;DataVar.2=GLCDColour.0
	bcf	DATAVAR,2,ACCESS
	banksel	GLCDCOLOUR
	btfsc	GLCDCOLOUR,0,BANKED
	bsf	DATAVAR,2,ACCESS
;case 7
	bra	SysSelectEnd6
SysSelect6Case8
	movlw	7
	subwf	REMAINDER,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelectEnd6
;DataVar.1=GLCDColour.0
	bcf	DATAVAR,1,ACCESS
	banksel	GLCDCOLOUR
	btfsc	GLCDCOLOUR,0,BANKED
	bsf	DATAVAR,1,ACCESS
;End Select
SysSelectEnd6
;EPD_Buffer(EPD_Ind_Trans)=DataVar
	lfsr	0,EPD_BUFFER
	banksel	EPD_IND_TRANS
	movf	EPD_IND_TRANS,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	EPD_IND_TRANS_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movffl	DATAVAR,INDF0
	return

;********************************************************************************

;Source: MySDLib.h (418)
READ_PARTIT_ENTRY
;SDRead_Block(0)
	clrf	BLOCK_START,ACCESS
	clrf	BLOCK_START_H,ACCESS
	clrf	BLOCK_START_U,ACCESS
	clrf	BLOCK_START_E,ACCESS
	rcall	SDREAD_BLOCK
;SDByte=446
	movlw	190
	banksel	SDBYTE
	movwf	SDBYTE,BANKED
	movlw	1
	movwf	SDBYTE_H,BANKED
;B0=SDDataBuffer(SDByte+8)
	lfsr	0,SDDATABUFFER
	movf	SDBYTE,W,BANKED
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp1,BANKED
	movf	SDBYTE_H,W,BANKED
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movlw	8
	addwf	SysTemp1,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movffl	INDF0,B0
	clrf	B0_H,ACCESS
	clrf	B0_U,ACCESS
	clrf	B0_E,ACCESS
;B1=SDDataBuffer(SDByte+9)
	lfsr	0,SDDATABUFFER
	movf	SDBYTE,W,BANKED
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp1,BANKED
	movf	SDBYTE_H,W,BANKED
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movlw	9
	addwf	SysTemp1,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movffl	INDF0,B1
	clrf	B1_H,ACCESS
	clrf	B1_U,ACCESS
	clrf	B1_E,ACCESS
;B2=SDDataBuffer(SDByte+10)
	lfsr	0,SDDATABUFFER
	movf	SDBYTE,W,BANKED
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp1,BANKED
	movf	SDBYTE_H,W,BANKED
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movlw	10
	addwf	SysTemp1,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movffl	INDF0,B2
	clrf	B2_H,ACCESS
	clrf	B2_U,ACCESS
	clrf	B2_E,ACCESS
;B3=SDDataBuffer(SDByte+11)
	lfsr	0,SDDATABUFFER
	movf	SDBYTE,W,BANKED
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp1,BANKED
	movf	SDBYTE_H,W,BANKED
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movlw	11
	addwf	SysTemp1,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysTemp1_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movffl	INDF0,B3
	clrf	B3_H,ACCESS
	clrf	B3_U,ACCESS
	clrf	B3_E,ACCESS
;LSB_to_MSB(Partition_Begin_LBA)
	movff	PARTITION_BEGIN_LBA,OUTPUT
	movff	PARTITION_BEGIN_LBA_H,OUTPUT_H
	movff	PARTITION_BEGIN_LBA_U,OUTPUT_U
	movff	PARTITION_BEGIN_LBA_E,OUTPUT_E
	banksel	0
	call	LSB_TO_MSB
	movff	OUTPUT,PARTITION_BEGIN_LBA
	movff	OUTPUT_H,PARTITION_BEGIN_LBA_H
	movff	OUTPUT_U,PARTITION_BEGIN_LBA_U
	movff	OUTPUT_E,PARTITION_BEGIN_LBA_E
	return

;********************************************************************************

;Source: MySDLib.h (439)
READ_RELEVANT_PARTIT_DATA
;SDRead_Block(Partition_Begin_LBA)
	movff	PARTITION_BEGIN_LBA,BLOCK_START
	movff	PARTITION_BEGIN_LBA_H,BLOCK_START_H
	movff	PARTITION_BEGIN_LBA_U,BLOCK_START_U
	movff	PARTITION_BEGIN_LBA_E,BLOCK_START_E
	rcall	SDREAD_BLOCK
;B0=SDDataBuffer(11)
	movffl	SYSSDDATABUFFER_11,B0
	clrf	B0_H,ACCESS
	clrf	B0_U,ACCESS
	clrf	B0_E,ACCESS
;B1=SDDataBuffer(12)
	movffl	SYSSDDATABUFFER_12,B1
	clrf	B1_H,ACCESS
	clrf	B1_U,ACCESS
	clrf	B1_E,ACCESS
;N_Bytes_per_Sector=B0+FnLSL(B1,8)
	movff	B1,SYSLONGTEMPB
	movff	B1_H,SYSLONGTEMPB_H
	movff	B1_U,SYSLONGTEMPB_U
	movff	B1_E,SYSLONGTEMPB_E
	movlw	8
	banksel	NUMBITS
	movwf	NUMBITS,BANKED
	banksel	0
	call	FN_FNLSL545
	movf	SYSFNLSLLONG,W,BANKED
	addwf	B0,W,ACCESS
	banksel	N_BYTES_PER_SECTOR
	movwf	N_BYTES_PER_SECTOR,BANKED
	banksel	SYSFNLSLLONG_H
	movf	SYSFNLSLLONG_H,W,BANKED
	addwfc	B0_H,W,ACCESS
	banksel	N_BYTES_PER_SECTOR_H
	movwf	N_BYTES_PER_SECTOR_H,BANKED
;N_Sector_per_cluster=SDDataBuffer(13)
	movffl	SYSSDDATABUFFER_13,N_SECTOR_PER_CLUSTER
;B0=SDDataBuffer(14)
	movffl	SYSSDDATABUFFER_14,B0
	clrf	B0_H,ACCESS
	clrf	B0_U,ACCESS
	clrf	B0_E,ACCESS
;B1=SDDataBuffer(15)
	movffl	SYSSDDATABUFFER_15,B1
	clrf	B1_H,ACCESS
	clrf	B1_U,ACCESS
	clrf	B1_E,ACCESS
;N_Reserved_Sector=B0+FnLSL(B1,8)
	movff	B1,SYSLONGTEMPB
	movff	B1_H,SYSLONGTEMPB_H
	movff	B1_U,SYSLONGTEMPB_U
	movff	B1_E,SYSLONGTEMPB_E
	movlw	8
	movwf	NUMBITS,BANKED
	banksel	0
	call	FN_FNLSL545
	movf	SYSFNLSLLONG,W,BANKED
	addwf	B0,W,ACCESS
	banksel	N_RESERVED_SECTOR
	movwf	N_RESERVED_SECTOR,BANKED
	banksel	SYSFNLSLLONG_H
	movf	SYSFNLSLLONG_H,W,BANKED
	addwfc	B0_H,W,ACCESS
	banksel	N_RESERVED_SECTOR_H
	movwf	N_RESERVED_SECTOR_H,BANKED
;N_FATS=SDDataBuffer(16)
	movffl	SYSSDDATABUFFER_16,N_FATS
;B0=SDDataBuffer(36)
	movffl	SYSSDDATABUFFER_36,B0
	clrf	B0_H,ACCESS
	clrf	B0_U,ACCESS
	clrf	B0_E,ACCESS
;B1=SDDataBuffer(37)
	movffl	SYSSDDATABUFFER_37,B1
	clrf	B1_H,ACCESS
	clrf	B1_U,ACCESS
	clrf	B1_E,ACCESS
;B2=SDDataBuffer(38)
	movffl	SYSSDDATABUFFER_38,B2
	clrf	B2_H,ACCESS
	clrf	B2_U,ACCESS
	clrf	B2_E,ACCESS
;B3=SDDataBuffer(39)
	movffl	SYSSDDATABUFFER_39,B3
	clrf	B3_H,ACCESS
	clrf	B3_U,ACCESS
	clrf	B3_E,ACCESS
;LSB_to_MSB(N_Sectors_per_Fat)
	movff	N_SECTORS_PER_FAT,OUTPUT
	movff	N_SECTORS_PER_FAT_H,OUTPUT_H
	movff	N_SECTORS_PER_FAT_U,OUTPUT_U
	movff	N_SECTORS_PER_FAT_E,OUTPUT_E
	banksel	0
	call	LSB_TO_MSB
	movff	OUTPUT,N_SECTORS_PER_FAT
	movff	OUTPUT_H,N_SECTORS_PER_FAT_H
	movff	OUTPUT_U,N_SECTORS_PER_FAT_U
	movff	OUTPUT_E,N_SECTORS_PER_FAT_E
;B0=SDDataBuffer(42)
	movffl	SYSSDDATABUFFER_42,B0
	clrf	B0_H,ACCESS
	clrf	B0_U,ACCESS
	clrf	B0_E,ACCESS
;B1=SDDataBuffer(43)
	movffl	SYSSDDATABUFFER_43,B1
	clrf	B1_H,ACCESS
	clrf	B1_U,ACCESS
	clrf	B1_E,ACCESS
;File_System_Ver_Num=B0+FnLSL(B1,8)
	movff	B1,SYSLONGTEMPB
	movff	B1_H,SYSLONGTEMPB_H
	movff	B1_U,SYSLONGTEMPB_U
	movff	B1_E,SYSLONGTEMPB_E
	movlw	8
	banksel	NUMBITS
	movwf	NUMBITS,BANKED
	banksel	0
	call	FN_FNLSL545
	movf	SYSFNLSLLONG,W,BANKED
	addwf	B0,W,ACCESS
	movwf	FILE_SYSTEM_VER_NUM,BANKED
;N_Sector_of_FAT2=SDDataBuffer(50)
	movffl	SYSSDDATABUFFER_50,N_SECTOR_OF_FAT2
;SD_MyString1=CHR(SDDataBuffer(71))
	movffl	SYSSDDATABUFFER_71,SYSCHAR
	call	FN_CHR
	lfsr	1,SD_MYSTRING1
	lfsr	0,CHR
	call	SysCopyString
;for SD_Counter=1 to 10
	banksel	SD_COUNTER
	clrf	SD_COUNTER,BANKED
	clrf	SD_COUNTER_H,BANKED
SysForLoop12
	banksel	SD_COUNTER
	incf	SD_COUNTER,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	SD_COUNTER_H,F,BANKED
;SD_MyString2=SD_MyString1+CHR(SDDataBuffer(71+SD_Counter))
	lfsr	0,SDDATABUFFER
	movlw	71
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp1,BANKED
	movlw	0
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movf	SD_COUNTER,W,BANKED
	addwf	SysTemp1,W,BANKED
	movwf	AFSR0,ACCESS
	movf	SD_COUNTER_H,W,BANKED
	addwfc	SysTemp1_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movffl	INDF0,SYSCHAR
	banksel	0
	call	FN_CHR
	lfsr	1,SD_MYSTRING2
	clrf	SysStringLength,ACCESS
	lfsr	0,SD_MYSTRING1
	call	SysCopyStringPart
	lfsr	0,CHR
	call	SysCopyStringPart
	lfsr	0,SD_MYSTRING2
	movffl	SysStringLength,INDF0
;SD_MyString1=SD_MyString2
	lfsr	1,SD_MYSTRING1
	lfsr	0,SD_MYSTRING2
	call	SysCopyString
;next
	movff	SD_COUNTER,SysWORDTempA
	movff	SD_COUNTER_H,SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop12
SysForLoopEnd12
;SD_MyString=CHR(SDDataBuffer(82))
	movffl	SYSSDDATABUFFER_82,SYSCHAR
	call	FN_CHR
	lfsr	1,SD_MYSTRING
	lfsr	0,CHR
	call	SysCopyString
;for SD_Counter=1 to 7
	banksel	SD_COUNTER
	clrf	SD_COUNTER,BANKED
	clrf	SD_COUNTER_H,BANKED
SysForLoop13
	banksel	SD_COUNTER
	incf	SD_COUNTER,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	SD_COUNTER_H,F,BANKED
;SD_MyString2=SD_MyString+CHR(SDDataBuffer(82+SD_Counter))
	lfsr	0,SDDATABUFFER
	movlw	82
	addwf	AFSR0,W,ACCESS
	movwf	SysTemp1,BANKED
	movlw	0
	addwfc	AFSR0_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movf	SD_COUNTER,W,BANKED
	addwf	SysTemp1,W,BANKED
	movwf	AFSR0,ACCESS
	movf	SD_COUNTER_H,W,BANKED
	addwfc	SysTemp1_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movffl	INDF0,SYSCHAR
	banksel	0
	call	FN_CHR
	lfsr	1,SD_MYSTRING2
	clrf	SysStringLength,ACCESS
	lfsr	0,SD_MYSTRING
	call	SysCopyStringPart
	lfsr	0,CHR
	call	SysCopyStringPart
	lfsr	0,SD_MYSTRING2
	movffl	SysStringLength,INDF0
;SD_MyString=SD_MyString2
	lfsr	1,SD_MYSTRING
	lfsr	0,SD_MYSTRING2
	call	SysCopyString
;next
	movff	SD_COUNTER,SysWORDTempA
	movff	SD_COUNTER_H,SysWORDTempA_H
	movlw	7
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	call	SysCompLessThan16
	btfsc	SysByteTempX,0,ACCESS
	bra	SysForLoop13
SysForLoopEnd13
	return

;********************************************************************************

;Source: epd_epd2in13d.h (497)
REFRESH_EPD2IN13D
;Not required as this process has already happenend from INIT
;LoadLUTS_EPD2in13D
;SendCommand_EPD2in13D(DISPLAY_REFRESH)
	movlw	18
	movwf	EPD2IN13D_COMMAND,BANKED
	bra	SENDCOMMAND_EPD2IN13D

;********************************************************************************

;Source: string.h (373)
FN_RIGHT
;Empty input?
;If SysInString(0) = 0 Then
	movffl	SysSYSINSTRINGHandler,AFSR0
	movffl	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	INDF0,F,ACCESS
	btfss	STATUS, Z,ACCESS
	bra	ENDIF201
;Right(0) = 0
	banksel	SYSRIGHT_0
	clrf	SYSRIGHT_0,BANKED
;Exit Function
	banksel	0
	return
;End If
ENDIF201
;Input length too high?
;If SysInString(0) < SysCharCount Then
	movffl	SysSYSINSTRINGHandler,AFSR0
	movffl	SysSYSINSTRINGHandler_H,AFSR0_H
	banksel	SYSCHARCOUNT
	movf	SYSCHARCOUNT,W,BANKED
	subwf	INDF0,W,ACCESS
	btfsc	STATUS, C,ACCESS
	bra	ENDIF202
;SysCharCount = SysInString(0)
	movffl	SysSYSINSTRINGHandler,AFSR0
	movffl	SysSYSINSTRINGHandler_H,AFSR0_H
	movffl	INDF0,SYSCHARCOUNT
;End If
ENDIF202
;Copy rightmost characters
;SysCharStart = SysInString(0) - SysCharCount
	movffl	SysSYSINSTRINGHandler,AFSR0
	movffl	SysSYSINSTRINGHandler_H,AFSR0_H
	movf	SYSCHARCOUNT,W,BANKED
	subwf	INDF0,W,ACCESS
	movwf	SYSCHARSTART,BANKED
;For SysStringTemp = 1 To SysCharCount
	clrf	SYSSTRINGTEMP,BANKED
	movlw	1
	subwf	SYSCHARCOUNT,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd31
SysForLoop31
	incf	SYSSTRINGTEMP,F,BANKED
;Right(SysStringTemp) = SysInString(SysCharStart + SysStringTemp)
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	SYSCHARSTART,W,BANKED
	movwf	SysTemp3,BANKED
	addwf	SysSYSINSTRINGHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysSYSINSTRINGHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movffl	POSTINC0,SysArrayTemp2
	movff	SysArrayTemp2,SysArrayTemp1
	lfsr	0,RIGHT
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	AFSR0,F,ACCESS
	movlw	0
	addwfc	AFSR0_H,F,ACCESS
	movffl	SysArrayTemp1,POSTINC0
;Next
	movf	SYSCHARCOUNT,W,BANKED
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop31
SysForLoopEnd31
;Right(0) = SysCharCount
	movffl	SYSCHARCOUNT,SYSRIGHT_0
	banksel	0
	return

;********************************************************************************

;Source: epd_epd2in13d.h (898)
ROTATE_EPD2IN13D
;DIM GLCDDataTemp, PrintLocY, PrintLocX as word
;PrintLocY = 0
	banksel	PRINTLOCY
	clrf	PRINTLOCY,BANKED
	clrf	PRINTLOCY_H,BANKED
;PrintLocX = 0
	clrf	PRINTLOCX,BANKED
	clrf	PRINTLOCX_H,BANKED
;select case EPD2in13DAddressType
;case PORTRAIT
SysSelect7Case1
	movlw	4
	banksel	EPD2IN13DADDRESSTYPE
	subwf	EPD2IN13DADDRESSTYPE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect7Case2
;GLCDDeviceHeight = GLCD_HEIGHT - 1
	movlw	211
	movwf	GLCDDEVICEHEIGHT,BANKED
	clrf	GLCDDEVICEHEIGHT_H,BANKED
;GLCDDeviceWidth = GLCD_WIDTH - 1
	movlw	103
	movwf	GLCDDEVICEWIDTH,BANKED
	clrf	GLCDDEVICEWIDTH_H,BANKED
;case LANDSCAPE
	bra	SysSelectEnd7
SysSelect7Case2
	decf	EPD2IN13DADDRESSTYPE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect7Case3
;GLCDDeviceHeight = GLCD_WIDTH - 1
	movlw	103
	movwf	GLCDDEVICEHEIGHT,BANKED
	clrf	GLCDDEVICEHEIGHT_H,BANKED
;GLCDDeviceWidth  = GLCD_HEIGHT - 1
	movlw	211
	movwf	GLCDDEVICEWIDTH,BANKED
	clrf	GLCDDEVICEWIDTH_H,BANKED
;case PORTRAIT_REV
	bra	SysSelectEnd7
SysSelect7Case3
	movlw	2
	subwf	EPD2IN13DADDRESSTYPE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect7Case4
;GLCDDeviceHeight = GLCD_HEIGHT - 1
	movlw	211
	movwf	GLCDDEVICEHEIGHT,BANKED
	clrf	GLCDDEVICEHEIGHT_H,BANKED
;GLCDDeviceWidth  = GLCD_WIDTH - 1
	movlw	103
	movwf	GLCDDEVICEWIDTH,BANKED
	clrf	GLCDDEVICEWIDTH_H,BANKED
;case LANDSCAPE_REV
	bra	SysSelectEnd7
SysSelect7Case4
	movlw	3
	subwf	EPD2IN13DADDRESSTYPE,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	SysSelect7Case5
;GLCDDeviceHeight = GLCD_WIDTH - 1
	movlw	103
	movwf	GLCDDEVICEHEIGHT,BANKED
	clrf	GLCDDEVICEHEIGHT_H,BANKED
;GLCDDeviceWidth  = GLCD_HEIGHT - 1
	movlw	211
	movwf	GLCDDEVICEWIDTH,BANKED
	clrf	GLCDDEVICEWIDTH_H,BANKED
;case else
	bra	SysSelectEnd7
SysSelect7Case5
;GLCDDeviceHeight = GLCD_HEIGHT - 1
	movlw	211
	movwf	GLCDDEVICEHEIGHT,BANKED
	clrf	GLCDDEVICEHEIGHT_H,BANKED
;GLCDDeviceWidth  = GLCD_WIDTH - 1
	movlw	103
	movwf	GLCDDEVICEWIDTH,BANKED
	clrf	GLCDDEVICEWIDTH_H,BANKED
;end select
SysSelectEnd7
	return

;********************************************************************************

;Source: MySDLib.h (31)
SDINITIALIZE
;INITIALIZATION TO Transfer state
;Syncronization and CMD0 Command
;INITSucc=0
	banksel	INITSUCC
	clrf	INITSUCC,BANKED
;SDResponse=100
	movlw	100
	movwf	SDRESPONSE,BANKED
;do until INITSucc=1
SysDoLoop_S8
	banksel	INITSUCC
	decf	INITSUCC,W,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysDoLoop_E8
;Draw_Line(1,20," ")
	movlw	1
	movwf	LINE_TYPE,BANKED
	movlw	20
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM4
	movlw	low StringTable12
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable12
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable12
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM4
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM4
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	call	DRAW_LINE
;sertxd(1,"###### Initialization"," Starts ######",1)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM4
	movlw	low StringTable77
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable77
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable77
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM4
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM4
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable78
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable78
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable78
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysINPUTSHandler_H,BANKED
	movlw	1
	movwf	CRLF2,ACCESS
	banksel	0
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
	bra	SysDoLoop_S8
SysDoLoop_E8
;if INITSucc=1 then
	decf	INITSUCC,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE94_1
;sertxd(2,"###### Initialization"," successfull ######",1)
	movlw	2
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM4
	movlw	low StringTable77
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable77
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable77
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM4
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM4
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable79
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable79
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable79
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysINPUTSHandler_H,BANKED
	movlw	1
	movwf	CRLF2,ACCESS
	banksel	0
	rcall	SERTXD7
;else
	bra	ENDIF94
ELSE94_1
;sertxd(2,"###### Initialization"," UNSUCCESSFULL ######",1)
	movlw	2
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM4
	movlw	low StringTable77
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable77
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable77
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM4
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM4
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable80
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable80
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable80
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysINPUTSHandler_H,BANKED
	movlw	1
	movwf	CRLF2,ACCESS
	banksel	0
	rcall	SERTXD7
;wait 1 s
	movlw	1
	movwf	SysWaitTempS,ACCESS
	call	Delay_S
;end if
ENDIF94
;SET SD_Adaper_CS ON
	bsf	LATD,7,ACCESS
	return

;********************************************************************************

;Source: MySDLib.h (336)
SDREAD_BLOCK
;SDResponse=100
	movlw	100
	banksel	SDRESPONSE
	movwf	SDRESPONSE,BANKED
;SDToken=100
	movlw	100
	movwf	SDTOKEN,BANKED
;SD_Counter=0
	clrf	SD_COUNTER,BANKED
	clrf	SD_COUNTER_H,BANKED
;if Verbose="ON" then
	lfsr	1,SYSTEMPARRAY
	movlw	low StringTable28
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable28
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable28
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	lfsr	0,VERBOSE
	lfsr	1,SYSTEMPARRAY
	call	SysCompEqualString
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF111
;Draw_Line(2,20,"=")
	movlw	2
	banksel	LINE_TYPE
	movwf	LINE_TYPE,BANKED
	movlw	20
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable29
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable29
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable29
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	call	DRAW_LINE
;sertxd(1,"-CMD17  ","Waiting for Token",0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable133
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable133
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable133
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM8
	movlw	low StringTable134
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable134
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable134
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM8
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM8
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	rcall	SERTXD7
;Draw_Line(2,20,"=")
	movlw	2
	banksel	LINE_TYPE
	movwf	LINE_TYPE,BANKED
	movlw	20
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable29
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable29
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable29
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	call	DRAW_LINE
;end if
ENDIF111
;repeat 1000         'portato a 1000 da 100
	movlw	232
	banksel	SYSREPEATTEMP11
	movwf	SysRepeatTemp11,BANKED
	movlw	4
	movwf	SysRepeatTemp11_H,BANKED
SysRepeatLoop11
;SD_Counter=SD_Counter+1
	incf	SD_COUNTER,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	SD_COUNTER_H,F,BANKED
;HSerPrint ". "
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable135
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable135
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable135
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysPRINTDATAHandler_H,BANKED
	movlw	1
	movwf	COMPORT,ACCESS
	banksel	0
	call	HSERPRINT716
;SD_Counter1=0
	banksel	SD_COUNTER1
	clrf	SD_COUNTER1,BANKED
	clrf	SD_COUNTER1_H,BANKED
;SendCommand (0x51, Block_Start, 0xFF)    'CMD17
	movlw	81
	movwf	CODE,ACCESS
	movff	BLOCK_START,ARG
	movff	BLOCK_START_H,ARG_H
	movff	BLOCK_START_U,ARG_U
	movff	BLOCK_START_E,ARG_E
	setf	CRC,ACCESS
	banksel	0
	rcall	SENDCOMMAND
;do until SDResponse=0 or SD_Counter1 > 100
SysDoLoop_S15
	movff	sdresponse,SysBYTETempA
	clrf	SysBYTETempB,ACCESS
	banksel	0
	call	SysCompEqual
	movff	SysByteTempX,SysTemp3
	movff	sd_counter1,SysWORDTempB
	movff	sd_counter1_H,SysWORDTempB_H
	movlw	100
	movwf	SysWORDTempA,ACCESS
	clrf	SysWORDTempA_H,ACCESS
	call	SysCompLessThan16
	banksel	SYSTEMP3
	movf	SysTemp3,W,BANKED
	iorwf	SysByteTempX,W,ACCESS
	movwf	SysTemp1,BANKED
	btfsc	SysTemp1,0,BANKED
	bra	SysDoLoop_E15
;GetSDResponse(1,SDResponse)
	movlw	1
	movwf	NRESPONSE,BANKED
	movff	SDRESPONSE,SDRESP
	banksel	0
	call	GETSDRESPONSE
	movff	SDRESP,SDRESPONSE
;SD_Counter1=SD_Counter1+1
	banksel	SD_COUNTER1
	incf	SD_COUNTER1,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	SD_COUNTER1_H,F,BANKED
;loop
	bra	SysDoLoop_S15
SysDoLoop_E15
;SD_Counter1=0
	clrf	SD_COUNTER1,BANKED
	clrf	SD_COUNTER1_H,BANKED
;do until SDToken=0xFE or SD_Counter1 > 1000
SysDoLoop_S16
	movff	sdtoken,SysBYTETempA
	movlw	254
	movwf	SysBYTETempB,ACCESS
	banksel	0
	call	SysCompEqual
	movff	SysByteTempX,SysTemp3
	movff	sd_counter1,SysWORDTempB
	movff	sd_counter1_H,SysWORDTempB_H
	movlw	232
	movwf	SysWORDTempA,ACCESS
	movlw	3
	movwf	SysWORDTempA_H,ACCESS
	call	SysCompLessThan16
	banksel	SYSTEMP3
	movf	SysTemp3,W,BANKED
	iorwf	SysByteTempX,W,ACCESS
	movwf	SysTemp1,BANKED
	btfsc	SysTemp1,0,BANKED
	bra	SysDoLoop_E16
;GetSDResponse(1,SDToken)
	movlw	1
	movwf	NRESPONSE,BANKED
	movff	SDTOKEN,SDRESP
	banksel	0
	call	GETSDRESPONSE
	movff	SDRESP,SDTOKEN
;SD_Counter1=SD_Counter1+1
	banksel	SD_COUNTER1
	incf	SD_COUNTER1,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	SD_COUNTER1_H,F,BANKED
;loop
	bra	SysDoLoop_S16
SysDoLoop_E16
;if SDToken=0xFE and SDResponse=0 then
	movff	SDTOKEN,SysBYTETempA
	movlw	254
	movwf	SysBYTETempB,ACCESS
	banksel	0
	call	SysCompEqual
	movff	SysByteTempX,SysTemp3
	movff	SDRESPONSE,SysBYTETempA
	clrf	SysBYTETempB,ACCESS
	call	SysCompEqual
	banksel	SYSTEMP3
	movf	SysTemp3,W,BANKED
	andwf	SysByteTempX,W,ACCESS
	movwf	SysTemp1,BANKED
	btfss	SysTemp1,0,BANKED
	bra	ENDIF112
;if Verbose="ON" then
	lfsr	1,SYSTEMPARRAY
	movlw	low StringTable28
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable28
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable28
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	lfsr	0,VERBOSE
	lfsr	1,SYSTEMPARRAY
	call	SysCompEqualString
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF114
;Draw_Line(2,20,"=")
	movlw	2
	banksel	LINE_TYPE
	movwf	LINE_TYPE,BANKED
	movlw	20
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable29
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable29
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable29
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	call	DRAW_LINE
;sertxd(1,"-CMD17  Successfully ","Executed",0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable136
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable136
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable136
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM8
	movlw	low StringTable137
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable137
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable137
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM8
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM8
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	rcall	SERTXD7
;sertxd(0,", First Response=",SDResponse,0):sertxd(0,", Token(254)=",SDToken,0)
	clrf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable138
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable138
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable138
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysSTRINGAHandler_H,BANKED
	movff	SDRESPONSE,INPUTB
	clrf	CRLF2,ACCESS
	banksel	0
	rcall	SERTXD8
	clrf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable139
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable139
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable139
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysSTRINGAHandler_H,BANKED
	movff	SDTOKEN,INPUTB
	clrf	CRLF2,ACCESS
	banksel	0
	rcall	SERTXD8
;sertxd(0," n. attempts=",SD_Counter,0)
	clrf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable140
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable140
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable140
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysSTRINGAHandler_H,BANKED
	movff	SD_COUNTER,INPUTW
	movff	SD_COUNTER_H,INPUTW_H
	clrf	CRLF2,ACCESS
	banksel	0
	rcall	SERTXD9
;Draw_Line(2,20,"=")
	movlw	2
	banksel	LINE_TYPE
	movwf	LINE_TYPE,BANKED
	movlw	20
	movwf	N_CHAR,BANKED
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable29
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable29
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable29
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSCHARHANDLER
	movwf	SysCHARHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysCHARHandler_H,BANKED
	banksel	0
	call	DRAW_LINE
;end if
ENDIF114
;exit repeat
	bra	SysRepeatLoopEnd11
;end if
ENDIF112
;End Repeat
	decfsz	SysRepeatTemp11,F,BANKED
	bra	SysRepeatLoop11
	decfsz	SysRepeatTemp11_H,F,BANKED
	bra	SysRepeatLoop11
SysRepeatLoopEnd11
;SDByte=0
	banksel	SDBYTE
	clrf	SDBYTE,BANKED
	clrf	SDBYTE_H,BANKED
;if SDToken=0xFE  then
	movlw	254
	subwf	SDTOKEN,W,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ELSE113_1
;Repeat 512
	clrf	SysRepeatTemp11,BANKED
	movlw	2
	movwf	SysRepeatTemp11_H,BANKED
SysRepeatLoop12
;SPITransfer 255, SDData
	setf	SPITXDATA,BANKED
	banksel	0
	call	HWSPITRANSFER
	movff	SPIRXDATA,SDDATA
;SDDataBuffer(SDByte) = SDData
	lfsr	0,SDDATABUFFER
	banksel	SDBYTE
	movf	SDBYTE,W,BANKED
	addwf	AFSR0,F,ACCESS
	movf	SDBYTE_H,W,BANKED
	addwfc	AFSR0_H,F,ACCESS
	movffl	SDDATA,INDF0
;SDByte += 1
	incf	SDBYTE,F,BANKED
	btfsc	STATUS,Z,ACCESS
	incf	SDBYTE_H,F,BANKED
;End Repeat
	decfsz	SysRepeatTemp11,F,BANKED
	bra	SysRepeatLoop12
	decfsz	SysRepeatTemp11_H,F,BANKED
	bra	SysRepeatLoop12
SysRepeatLoopEnd12
;else
	bra	ENDIF113
ELSE113_1
;sertxd(1,"-CMD17  UNSUCCESSFULLY Executed","  ",0)
	movlw	1
	movwf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable141
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable141
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable141
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysSTRINGAHandler_H,BANKED
	lfsr	1,SYSSTRINGPARAM8
	movlw	low StringTable129
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable129
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable129
	movwf	TBLPTRU,ACCESS
	banksel	0
	call	SysReadString
	movlw	low SYSSTRINGPARAM8
	banksel	SYSINPUTSHANDLER
	movwf	SysINPUTSHandler,BANKED
	movlw	high SYSSTRINGPARAM8
	movwf	SysINPUTSHandler_H,BANKED
	clrf	CRLF2,ACCESS
	banksel	0
	rcall	SERTXD7
;sertxd(0,", First Response=",SDResponse,0):sertxd(0,", Token(254)=",SDToken,0)
	clrf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable138
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable138
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable138
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysSTRINGAHandler_H,BANKED
	movff	SDRESPONSE,INPUTB
	clrf	CRLF2,ACCESS
	banksel	0
	rcall	SERTXD8
	clrf	CRLF1,ACCESS
	lfsr	1,SYSSTRINGPARAM6
	movlw	low StringTable139
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable139
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable139
	movwf	TBLPTRU,ACCESS
	call	SysReadString
	movlw	low SYSSTRINGPARAM6
	banksel	SYSSTRINGAHANDLER
	movwf	SysSTRINGAHandler,BANKED
	movlw	high SYSSTRINGPARAM6
	movwf	SysSTRINGAHandler_H,BANKED
	movff	SDTOKEN,INPUTB
	clrf	CRLF2,ACCESS
	banksel	0
	rcall	SERTXD8
;END
	goto	BASPROGRAMEND
;end if
ENDIF113
	banksel	0
	return

;********************************************************************************

;Source: MySDLib.h (78)
SENDCOMMAND
;SET SD_Adaper_CS OFF
	bcf	LATD,7,ACCESS
;SPITransfer 0xFF, SDData
	banksel	SPITXDATA
	setf	SPITXDATA,BANKED
	banksel	0
	call	HWSPITRANSFER
	movff	SPIRXDATA,SDDATA
;SPITransfer Code, SDData
	movff	CODE,SPITXDATA
	call	HWSPITRANSFER
	movff	SPIRXDATA,SDDATA
;SPITransfer Arg_E, SDData
	movff	ARG_E,SPITXDATA
	call	HWSPITRANSFER
	movff	SPIRXDATA,SDDATA
;SPITransfer Arg_U, SDData
	movff	ARG_U,SPITXDATA
	call	HWSPITRANSFER
	movff	SPIRXDATA,SDDATA
;SPITransfer Arg_H, SDData
	movff	ARG_H,SPITXDATA
	call	HWSPITRANSFER
	movff	SPIRXDATA,SDDATA
;SPITransfer [byte]Arg, SDData
	movff	ARG,SPITXDATA
	call	HWSPITRANSFER
	movff	SPIRXDATA,SDDATA
;SPITransfer CRC, SDData
	movff	CRC,SPITXDATA
	call	HWSPITRANSFER
	movff	SPIRXDATA,SDDATA
;SendPulses      'NECESSARIO!!!!
	rcall	SENDPULSES
;SPITransfer 0xFF, SDData
	return

;********************************************************************************

;Source: epd_epd2in13d.h (517)
SENDCOMMAND_EPD2IN13D
;SET EPD_CS OFF
	bcf	LATC,1,ACCESS
;SET EPD_DC OFF
	bcf	LATA,0,ACCESS
;REPEAT 8
	movlw	8
	banksel	SYSREPEATTEMP15
	movwf	SysRepeatTemp15,BANKED
SysRepeatLoop15
;IF EPD2in13D_Command.7 = ON THEN
	banksel	EPD2IN13D_COMMAND
	btfss	EPD2IN13D_COMMAND,7,BANKED
	bra	ELSE140_1
;Set EPD_DO ON
	bsf	LATC,5,ACCESS
;ELSE
	bra	ENDIF140
ELSE140_1
;Set EPD_DO OFF
	bcf	LATC,5,ACCESS
;END IF
ENDIF140
;SET EPD_SCK On
	bsf	LATC,3,ACCESS
;Rotate EPD2in13D_Command left
	rlcf	EPD2IN13D_COMMAND,F,BANKED
;Set EPD_SCK Off
	bcf	LATC,3,ACCESS
;END REPEAT
	banksel	SYSREPEATTEMP15
	decfsz	SysRepeatTemp15,F,BANKED
	bra	SysRepeatLoop15
SysRepeatLoopEnd15
;Set EPD_CS ON
	bsf	LATC,1,ACCESS
;do
SysDoLoop_S18
;loop while EPD_Busy=Off
	btfss	PORTC,0,ACCESS
	bra	SysDoLoop_S18
SysDoLoop_E18
	banksel	0
	return

;********************************************************************************

;Source: epd_epd2in13d.h (550)
SENDDATA_EPD2IN13D
;SET EPD_CS OFF
	bcf	LATC,1,ACCESS
;SET EPD_DC ON
	bsf	LATA,0,ACCESS
;SendData_EPD2in13D_Macro
;Macro Source: epd_epd2in13d.h (560)
;REPEAT 8
	movlw	8
	banksel	SYSREPEATTEMP23
	movwf	SysRepeatTemp23,BANKED
SysRepeatLoop23
;IF EPD2in13D_Data.7 = ON THEN
	banksel	EPD2IN13D_DATA
	btfss	EPD2IN13D_DATA,7,BANKED
	bra	ELSE225_1
;Set EPD_DO ON
	bsf	LATC,5,ACCESS
;ELSE
	bra	ENDIF225
ELSE225_1
;Set EPD_DO OFF
	bcf	LATC,5,ACCESS
;END IF
ENDIF225
;SET EPD_SCK On
	bsf	LATC,3,ACCESS
;Rotate EPD2in13D_Data left
	rlcf	EPD2IN13D_DATA,F,BANKED
;Set EPD_SCK Off
	bcf	LATC,3,ACCESS
;END REPEAT
	banksel	SYSREPEATTEMP23
	decfsz	SysRepeatTemp23,F,BANKED
	bra	SysRepeatLoop23
SysRepeatLoopEnd23
;SET EPD_CS ON
	bsf	LATC,1,ACCESS
	banksel	0
	return

;********************************************************************************

;Source: MySDLib.h (71)
SENDDUMMYBYTES
;repeat n_bytes
	movff	N_BYTES,SysRepeatTemp21
	banksel	SYSREPEATTEMP21
	movf	SYSREPEATTEMP21,F,BANKED
	btfsc	STATUS, Z,ACCESS
	bra	SysRepeatLoopEnd21
SysRepeatLoop21
;SPITransfer 0xFF, SDData
	setf	SPITXDATA,BANKED
	banksel	0
	call	HWSPITRANSFER
	movff	SPIRXDATA,SDDATA
;end repeat
	banksel	SYSREPEATTEMP21
	decfsz	SysRepeatTemp21,F,BANKED
	bra	SysRepeatLoop21
SysRepeatLoopEnd21
	banksel	0
	return

;********************************************************************************

;Source: MySDLib.h (95)
SENDPULSES
;Set SD_Adaper_CS OFF
;SPITransfer 0xFF, SDData
	banksel	SPITXDATA
	setf	SPITXDATA,BANKED
	banksel	0
	call	HWSPITRANSFER
	movff	SPIRXDATA,SDDATA
;Set SD_Adaper_CS ON
	return

;********************************************************************************

;Overloaded signature: BYTE:STRING:STRING:BYTE:, Source: Sertxd.h (1)
SERTXD7
;if CRLF1 >0 Then
	movf	CRLF1,W,ACCESS
	sublw	0
	btfsc	STATUS, C,ACCESS
	bra	ELSE21_1
;HSerPrintCRLF CRLF1     'carriage return + line feed
	movff	CRLF1,HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
;Else
	bra	ENDIF21
ELSE21_1
;HSerSend CRLF1
	movff	CRLF1,SERDATA
	call	HSERSEND705
;End if
ENDIF21
;HSerPrint stringa
	movff	SysSTRINGAHandler,SysPRINTDATAHandler
	movff	SysSTRINGAHandler_H,SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINT716
;HSerPrint inputS
	movff	SysINPUTSHandler,SysPRINTDATAHandler
	movff	SysINPUTSHandler_H,SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINT716
;if CRLF2 >0 Then
	movf	CRLF2,W,ACCESS
	sublw	0
	btfsc	STATUS, C,ACCESS
	bra	ELSE22_1
;HSerPrintCRLF CRLF2
	movff	CRLF2,HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
;Else
	bra	ENDIF22
ELSE22_1
;HSerSend CRLF2
	movff	CRLF2,SERDATA
	call	HSERSEND705
;End if
ENDIF22
	return

;********************************************************************************

;Overloaded signature: BYTE:STRING:BYTE:BYTE:, Source: Sertxd.h (21)
SERTXD8
;if CRLF1 >0 Then
	movf	CRLF1,W,ACCESS
	sublw	0
	btfsc	STATUS, C,ACCESS
	bra	ELSE23_1
;HSerPrintCRLF CRLF1
	movff	CRLF1,HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
;Else
	bra	ENDIF23
ELSE23_1
;HSerSend CRLF1
	movff	CRLF1,SERDATA
	call	HSERSEND705
;End if
ENDIF23
;HSerPrint stringa
	movff	SysSTRINGAHandler,SysPRINTDATAHandler
	movff	SysSTRINGAHandler_H,SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINT716
;HSerPrint inputB
	movff	INPUTB,SERPRINTVAL
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINT717
;if CRLF2 > 0 Then
	movf	CRLF2,W,ACCESS
	sublw	0
	btfsc	STATUS, C,ACCESS
	bra	ELSE24_1
;HSerPrintCRLF CRLF2
	movff	CRLF2,HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
;Else
	bra	ENDIF24
ELSE24_1
;HSerSend CRLF2
	movff	CRLF2,SERDATA
	call	HSERSEND705
;End if
ENDIF24
	return

;********************************************************************************

;Overloaded signature: BYTE:STRING:WORD:BYTE:, Source: Sertxd.h (40)
SERTXD9
;if CRLF1 >0 Then
	movf	CRLF1,W,ACCESS
	sublw	0
	btfsc	STATUS, C,ACCESS
	bra	ELSE215_1
;HSerPrintCRLF CRLF1     'se 1 cambia riga, se 0 no
	movff	CRLF1,HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
;Else
	bra	ENDIF215
ELSE215_1
;HSerSend CRLF1
	movff	CRLF1,SERDATA
	call	HSERSEND705
;End if
ENDIF215
;HSerPrint stringa
	movff	SysSTRINGAHandler,SysPRINTDATAHandler
	movff	SysSTRINGAHandler_H,SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINT716
;HSerPrint inputW
	movff	INPUTW,SERPRINTVAL
	movff	INPUTW_H,SERPRINTVAL_H
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINT718
;if CRLF2 > 0 Then
	movf	CRLF2,W,ACCESS
	sublw	0
	btfsc	STATUS, C,ACCESS
	bra	ELSE216_1
;HSerPrintCRLF CRLF2
	movff	CRLF2,HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
;Else
	bra	ENDIF216
ELSE216_1
;HSerSend CRLF2
	movff	CRLF2,SERDATA
	call	HSERSEND705
;End if
ENDIF216
	return

;********************************************************************************

;Overloaded signature: BYTE:STRING:LONG:BYTE:, Source: Sertxd.h (59)
SERTXD10
;if CRLF1 > 0 Then
	movf	CRLF1,W,ACCESS
	sublw	0
	btfsc	STATUS, C,ACCESS
	bra	ELSE25_1
;HSerPrintCRLF CRLF1     'se 1 cambia riga, se 0 no
	movff	CRLF1,HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
;Else
	bra	ENDIF25
ELSE25_1
;HSerSend CRLF1
	movff	CRLF1,SERDATA
	call	HSERSEND705
;End if
ENDIF25
;HSerPrint stringa
	movff	SysSTRINGAHandler,SysPRINTDATAHandler
	movff	SysSTRINGAHandler_H,SysPRINTDATAHandler_H
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINT716
;HSerPrint inputL
	movff	INPUTL,SERPRINTVAL
	movff	INPUTL_H,SERPRINTVAL_H
	movff	INPUTL_U,SERPRINTVAL_U
	movff	INPUTL_E,SERPRINTVAL_E
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINT720
;if CRLF2 > 0 Then
	movf	CRLF2,W,ACCESS
	sublw	0
	btfsc	STATUS, C,ACCESS
	bra	ELSE26_1
;HSerPrintCRLF CRLF2
	movff	CRLF2,HSERPRINTCRLFCOUNT
	movlw	1
	movwf	COMPORT,ACCESS
	call	HSERPRINTCRLF
;Else
	bra	ENDIF26
ELSE26_1
;HSerSend CRLF2
	movff	CRLF2,SERDATA
	call	HSERSEND705
;End if
ENDIF26
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
	bra	ENDIF188
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
ENDIF188
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
	bra	ENDIF189
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
ENDIF189
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
	bra	ENDIF190
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
ENDIF190
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
	bra	ENDIF191
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
ENDIF191
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

;Source: E_paper-18F47K42_SD_SDLIB_Transaction.gcb (276)
STRING_EXAMPLE
;DrawString_EPD2in13D(2,2 ,"Caso Probabile")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	2
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable37
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable37
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable37
	movwf	TBLPTRU,ACCESS
	banksel	0
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;DrawString_EPD2in13D(2,12 ,"perché la rela")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	12
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable38
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable38
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable38
	movwf	TBLPTRU,ACCESS
	banksel	0
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;DrawString_EPD2in13D(2,22 ,"zione non era")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	22
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable39
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable39
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable39
	movwf	TBLPTRU,ACCESS
	banksel	0
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;DrawString_EPD2in13D(2,32 ,"attendibile.")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	32
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable40
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable40
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable40
	movwf	TBLPTRU,ACCESS
	banksel	0
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;DrawString_EPD2in13D(2,42 ,"Comunque la ")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	42
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable41
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable41
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable41
	movwf	TBLPTRU,ACCESS
	banksel	0
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;DrawString_EPD2in13D(2,52 ,"nuova versione")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	52
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable42
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable42
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable42
	movwf	TBLPTRU,ACCESS
	banksel	0
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;DrawString_EPD2in13D(2,62 ,"darà risultati")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	62
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable43
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable43
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable43
	movwf	TBLPTRU,ACCESS
	banksel	0
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;DrawString_EPD2in13D(2,72 ,"migliori?")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	72
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable44
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable44
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable44
	movwf	TBLPTRU,ACCESS
	banksel	0
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;DrawString_EPD2in13D(2,108,"Seconda Parte")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	108
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable45
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable45
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable45
	movwf	TBLPTRU,ACCESS
	banksel	0
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;DrawString_EPD2in13D(2,118,"dello schermo")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	118
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable46
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable46
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable46
	movwf	TBLPTRU,ACCESS
	banksel	0
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;DrawString_EPD2in13D(2,128,"con un buffer")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	128
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable47
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable47
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable47
	movwf	TBLPTRU,ACCESS
	banksel	0
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;DrawString_EPD2in13D(2,138,"ridotto. Si può")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	138
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable48
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable48
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable48
	movwf	TBLPTRU,ACCESS
	banksel	0
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;DrawString_EPD2in13D(2,148,"anche disegnare")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	148
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable49
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable49
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable49
	movwf	TBLPTRU,ACCESS
	banksel	0
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	call	DRAWSTRING_EPD2IN13D
;DrawString_EPD2in13D(2,158,"fig. geometriche")
	movlw	2
	banksel	STRINGLOCX
	movwf	STRINGLOCX,BANKED
	clrf	STRINGLOCX_H,BANKED
	movlw	158
	movwf	CHARLOCY,ACCESS
	clrf	CHARLOCY_H,ACCESS
	lfsr	1,SYSSTRINGPARAM3
	movlw	low StringTable50
	movwf	TBLPTRL,ACCESS
	movlw	high StringTable50
	movwf	TBLPTRH,ACCESS
	movlw	upper StringTable50
	movwf	TBLPTRU,ACCESS
	banksel	0
	rcall	SysReadString
	movlw	low SYSSTRINGPARAM3
	banksel	SYSCHARSHANDLER
	movwf	SysCHARSHandler,BANKED
	movlw	high SYSSTRINGPARAM3
	movwf	SysCHARSHandler_H,BANKED
	movff	GLCDFOREGROUND,LINECOLOUR
	movff	GLCDFOREGROUND_H,LINECOLOUR_H
	banksel	0
	goto	DRAWSTRING_EPD2IN13D

;********************************************************************************

;Overloaded signature: WORD:WORD:, Source: stdbasic.h (284)
SWAP536
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

;Source: system.h (2693)
SYSCOMPEQUAL32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
;Test low, exit if false
;movf SysLongTempB, W
	movf	SYSLONGTEMPB, W,ACCESS
;cpfseq SysLongTempA
	cpfseq	SYSLONGTEMPA,ACCESS
;return
	return
;Test high, exit if false
;movf SysLongTempB_H, W
	movf	SYSLONGTEMPB_H, W,ACCESS
;cpfseq SysLongTempA_H
	cpfseq	SYSLONGTEMPA_H,ACCESS
;return
	return
;Test upper, exit if false
;movf SysLongTempB_U, W
	movf	SYSLONGTEMPB_U, W,ACCESS
;cpfseq SysLongTempA_U
	cpfseq	SYSLONGTEMPA_U,ACCESS
;return
	return
;Test exp, exit if false
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

;Source: system.h (1419)
SYSCOMPEQUALSTRING
;Dim SysByteTempA As Byte
;Dim SysByteTempX As Byte
;SysByteTempX = 0
	clrf	SYSBYTETEMPX,ACCESS
;Check length matches
;movf INDF0, W
	movf	INDF0, W,ACCESS
;cpfseq POSTINC1
	cpfseq	POSTINC1,ACCESS
;return
	return
;Check if empty
;movf INDF0, F
	movf	INDF0, F,ACCESS
;bz SCEStrTrue
	bz	SCESTRTRUE
;Check each char, exit if not equal
;movff POSTINC0, SysByteTempA
	movffl	POSTINC0,SYSBYTETEMPA
SYSSTRINGCOMP
;Compare, exit if <>
;movf POSTINC0, W
	movf	POSTINC0, W,ACCESS
;cpfseq POSTINC1
	cpfseq	POSTINC1,ACCESS
;return
	return
;decfsz SysByteTempA, F
	decfsz	SYSBYTETEMPA, F,ACCESS
;goto SysStringComp
	bra	SYSSTRINGCOMP
SCESTRTRUE
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
	bra	ELSE185_1
;-A, +B, return true
;If SysIntegerTempB.15 = Off Then
	btfsc	SYSINTEGERTEMPB_H,7,ACCESS
	bra	ENDIF186
;Set SysByteTempX to 255
;SysByteTempX = Not SysByteTempX
	comf	SYSBYTETEMPX,F,ACCESS
;Exit Sub
	return
;End If
ENDIF186
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
	bra	ENDIF185
ELSE185_1
;+A, -B, return false
;If SysIntegerTempB.15 = On Then
	btfsc	SYSINTEGERTEMPB_H,7,ACCESS
;Exit Sub
	return
;End If
;End If
ENDIF185
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

;Source: system.h (2389)
SYSDIVSUB
;dim SysByteTempA as byte
;dim SysByteTempB as byte
;dim SysByteTempX as byte
;Check for div/0
;movf SysByteTempB, F
	movf	SYSBYTETEMPB, F,ACCESS
;btfsc STATUS, Z
	btfsc	STATUS, Z,ACCESS
;return
	return
;Main calc routine
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
	bra	ENDIF180
;SysWordTempA = 0
	clrf	SYSWORDTEMPA,ACCESS
	clrf	SYSWORDTEMPA_H,ACCESS
;exit sub
	return
;end if
ENDIF180
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
	bra	ENDIF181
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0,ACCESS
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W,ACCESS
	addwf	SYSDIVMULTX,F,ACCESS
	movf	SYSDIVMULTB_H,W,ACCESS
	addwfc	SYSDIVMULTX_H,F,ACCESS
;End If
ENDIF181
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

;Source: system.h (2533)
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
;Avoid division by zero
;if SysLongDivMultB = 0 then
	movff	SYSLONGDIVMULTB,SysLONGTempA
	movff	SYSLONGDIVMULTB_H,SysLONGTempA_H
	movff	SYSLONGDIVMULTB_U,SysLONGTempA_U
	movff	SYSLONGDIVMULTB_E,SysLONGTempA_E
	clrf	SysLONGTempB,ACCESS
	clrf	SysLONGTempB_H,ACCESS
	clrf	SysLONGTempB_U,ACCESS
	clrf	SysLONGTempB_E,ACCESS
	banksel	0
	rcall	SysCompEqual32
	btfss	SysByteTempX,0,ACCESS
	bra	ENDIF226
;SysLongTempA = 0
	clrf	SYSLONGTEMPA,ACCESS
	clrf	SYSLONGTEMPA_H,ACCESS
	clrf	SYSLONGTEMPA_U,ACCESS
	clrf	SYSLONGTEMPA_E,ACCESS
;exit sub
	return
;end if
ENDIF226
;Main calc routine
;SysDivLoop = 32
	movlw	32
	movwf	SYSDIVLOOP,ACCESS
SYSDIV32START
;set C off
	bcf	STATUS,C,ACCESS
;Rotate SysLongDivMultA Left
	banksel	SYSLONGDIVMULTA
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
	bra	ENDIF227
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
ENDIF227
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
	banksel	0
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
	bra	ENDIF182
	comf	SYSINTEGERTEMPA,F,ACCESS
	comf	SYSINTEGERTEMPA_H,F,ACCESS
	incf	SYSINTEGERTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPA_H,F,ACCESS
ENDIF182
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
	btfss	SYSINTEGERTEMPB_H,7,ACCESS
	bra	ENDIF183
	comf	SYSINTEGERTEMPB,F,ACCESS
	comf	SYSINTEGERTEMPB_H,F,ACCESS
	incf	SYSINTEGERTEMPB,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPB_H,F,ACCESS
ENDIF183
;Call word divide routine
;SysDivSub16
	rcall	SYSDIVSUB16
;Negate result if necessary
;If SysSignByte.7 Then
	btfss	SYSSIGNBYTE,7,ACCESS
	bra	ENDIF184
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
ENDIF184
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
	bra	ENDIF178
	movf	SYSLONGDIVMULTA,W,BANKED
	addwf	SYSLONGDIVMULTX,F,BANKED
	movf	SYSLONGDIVMULTA_H,W,BANKED
	addwfc	SYSLONGDIVMULTX_H,F,BANKED
	movf	SYSLONGDIVMULTA_U,W,BANKED
	addwfc	SYSLONGDIVMULTX_U,F,BANKED
	movf	SYSLONGDIVMULTA_E,W,BANKED
	addwfc	SYSLONGDIVMULTX_E,F,BANKED
ENDIF178
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
	bra	ENDIF175
	comf	SYSINTEGERTEMPA,F,ACCESS
	comf	SYSINTEGERTEMPA_H,F,ACCESS
	incf	SYSINTEGERTEMPA,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPA_H,F,ACCESS
ENDIF175
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
	btfss	SYSINTEGERTEMPB_H,7,ACCESS
	bra	ENDIF176
	comf	SYSINTEGERTEMPB,F,ACCESS
	comf	SYSINTEGERTEMPB_H,F,ACCESS
	incf	SYSINTEGERTEMPB,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPB_H,F,ACCESS
ENDIF176
;Call word multiply routine
;SysMultSub16
	rcall	SYSMULTSUB16
;Negate result if necessary
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
	btfss	SYSSIGNBYTE,7,ACCESS
	bra	ENDIF177
	comf	SYSINTEGERTEMPX,F,ACCESS
	comf	SYSINTEGERTEMPX_H,F,ACCESS
	incf	SYSINTEGERTEMPX,F,ACCESS
	btfsc	STATUS,Z,ACCESS
	incf	SYSINTEGERTEMPX_H,F,ACCESS
ENDIF177
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

StringTable3
	db	14,61,61,61,61,61,61,61,61,61,61,61,61,61,61


StringTable4
	db	19,69,45,80,97,112,101,114,32,69,80,68,50,105,110,49,51,40,68,41


StringTable5
	db	19,61,61,61,61,61,61,61,61,61,61,61,61,61,61,61,61,61,61,61


StringTable6
	db	2,61,61


StringTable7
	db	28,61,61,61,61,61,61,61,61,61,61,61,61,61,61,61,61,61,61,61,70,111,110,116,83,105
	db	122,101,61


StringTable8
	db	13,67,65,82,68,32,97,108,114,101,97,100,121,32


StringTable9
	db	17,105,110,105,116,105,97,108,105,122,101,100,63,32,115,47,110,32


StringTable10
	db	1,115


StringTable11
	db	4,66,79,79,84


StringTable12
	db	1,32


StringTable13
	db	7,32,77,69,78,85,58,32


StringTable14
	db	39,32,32,32,32,32,69,88,80,76,79,82,69,47,69,88,69,67,85,84,69,58,32,70,105,108
	db	101,32,111,114,32,68,105,114,101,99,116,111,114,121


StringTable15
	db	16,32,32,73,41,32,70,110,61,32,101,120,101,99,117,116,101


StringTable16
	db	11,32,70,105,108,101,32,110,117,109,32,110


StringTable17
	db	16,32,73,73,41,32,68,110,61,32,69,120,112,108,111,114,101


StringTable18
	db	16,32,68,105,114,101,99,116,111,114,121,32,110,117,109,32,110


StringTable19
	db	16,32,73,73,73,41,69,110,61,32,82,117,110,32,71,114,97


StringTable20
	db	16,112,104,32,69,120,97,109,112,108,101,32,110,117,109,32,110


StringTable21
	db	19,32,86,73,41,32,82,32,61,32,71,79,32,84,79,32,82,79,79,84


StringTable22
	db	25,32,32,80,108,101,97,115,101,32,103,105,118,101,32,121,111,117,114,32,99,104
	db	111,105,99,101


StringTable23
	db	1,82


StringTable24
	db	1,114


StringTable25
	db	1,68


StringTable26
	db	1,70


StringTable27
	db	1,69


StringTable28
	db	2,79,78


StringTable29
	db	1,61


StringTable30
	db	56,32,32,84,104,101,32,101,110,116,114,121,32,111,102,32,116,104,101,32,99,104
	db	111,115,101,110,32,70,105,108,101,47,68,105,114,32,105,115,32,32,97,116,32,66
	db	111,111,116,32,114,101,99,111,114,100,32,110,46


StringTable31
	db	40,32,32,84,104,101,32,99,104,111,111,115,101,110,32,70,105,108,101,47,68,105
	db	114,32,105,115,32,97,116,32,99,108,117,115,116,101,114,32,110,46,61


StringTable32
	db	37,32,32,76,66,65,32,65,100,100,114,101,115,115,32,111,102,32,116,104,101,32,99,104
	db	111,115,101,110,32,70,105,108,101,47,68,105,114,61


StringTable33
	db	1,45


StringTable34
	db	22,65,32,46,98,105,110,32,70,105,108,101,32,105,115,32,97,115,115,117,109,101
	db	100


StringTable35
	db	17,32,105,110,32,116,104,101,32,102,111,108,108,111,119,105,110,103


StringTable36
	db	23,32,32,61,61,61,77,65,75,73,78,71,32,84,72,69,32,80,73,67,84,85,82,69


StringTable37
	db	14,67,97,115,111,32,80,114,111,98,97,98,105,108,101


StringTable38
	db	14,112,101,114,99,104,233,32,108,97,32,114,101,108,97


StringTable39
	db	13,122,105,111,110,101,32,110,111,110,32,101,114,97


StringTable40
	db	12,97,116,116,101,110,100,105,98,105,108,101,46


StringTable41
	db	12,67,111,109,117,110,113,117,101,32,108,97,32


StringTable42
	db	14,110,117,111,118,97,32,118,101,114,115,105,111,110,101


StringTable43
	db	14,100,97,114,224,32,114,105,115,117,108,116,97,116,105


StringTable44
	db	9,109,105,103,108,105,111,114,105,63


StringTable45
	db	13,83,101,99,111,110,100,97,32,80,97,114,116,101


StringTable46
	db	13,100,101,108,108,111,32,115,99,104,101,114,109,111


StringTable47
	db	13,99,111,110,32,117,110,32,98,117,102,102,101,114


StringTable48
	db	15,114,105,100,111,116,116,111,46,32,83,105,32,112,117,242


StringTable49
	db	15,97,110,99,104,101,32,100,105,115,101,103,110,97,114,101


StringTable50
	db	16,102,105,103,46,32,103,101,111,109,101,116,114,105,99,104,101


StringTable51
	db	9,82,101,99,116,97,110,103,108,101


StringTable52
	db	9,72,121,112,101,114,98,111,108,101


StringTable77
	db	21,35,35,35,35,35,35,32,73,110,105,116,105,97,108,105,122,97,116,105,111,110


StringTable78
	db	14,32,83,116,97,114,116,115,32,35,35,35,35,35,35


StringTable79
	db	19,32,115,117,99,99,101,115,115,102,117,108,108,32,35,35,35,35,35,35


StringTable80
	db	21,32,85,78,83,85,67,67,69,83,83,70,85,76,76,32,35,35,35,35,35,35


StringTable81
	db	2,91,93


StringTable82
	db	2,63,63


StringTable83
	db	6,45,67,77,68,48,32


StringTable84
	db	10,32,32,69,120,101,99,117,116,101,100


StringTable85
	db	6,45,67,77,68,56,32


StringTable86
	db	7,102,97,105,108,101,100,46


StringTable87
	db	11,32,32,69,120,101,99,117,116,101,100,46


StringTable88
	db	12,32,32,32,32,32,32,32,32,67,97,114,100


StringTable89
	db	6,32,105,115,32,86,50


StringTable90
	db	7,45,67,77,68,56,32,32


StringTable91
	db	10,32,69,120,101,99,117,116,101,100,46


StringTable92
	db	6,32,105,115,32,86,49


StringTable93
	db	4,32,32,32,32


StringTable94
	db	3,32,32,32


StringTable95
	db	16,32,84,104,101,32,67,77,68,56,32,99,104,101,99,107,32


StringTable96
	db	20,112,97,116,116,101,114,110,32,105,115,32,99,111,110,102,105,114,109,101,100


StringTable97
	db	24,112,97,116,116,101,114,110,32,105,115,32,110,111,116,32,99,111,110,102,105,114
	db	109,101,100


StringTable98
	db	12,83,68,82,101,115,112,111,110,115,101,51,61


StringTable99
	db	18,32,84,104,101,32,67,77,68,56,32,99,111,110,102,105,114,109,32


StringTable100
	db	12,118,111,108,116,97,103,101,32,67,97,114,100


StringTable101
	db	19,32,84,104,101,32,67,77,68,56,32,100,111,101,115,32,110,111,116,32


StringTable102
	db	20,99,111,110,102,105,114,109,32,86,111,108,116,97,103,101,32,67,97,114,100


StringTable103
	db	12,83,68,82,101,115,112,111,110,115,101,50,61


StringTable104
	db	8,45,65,67,77,68,52,49,32


StringTable105
	db	9,69,120,101,99,117,116,101,100,46


StringTable106
	db	7,32,97,102,116,101,114,32


StringTable107
	db	9,32,97,116,116,101,109,112,116,115


StringTable108
	db	23,32,32,32,32,32,32,32,32,67,77,68,52,49,32,82,101,115,112,111,110,115,101,61


StringTable109
	db	16,32,67,77,68,53,53,32,82,101,115,112,111,110,115,101,61


StringTable110
	db	7,45,67,77,68,53,56,32


StringTable111
	db	24,32,69,120,101,99,117,116,101,100,32,115,117,99,99,101,115,115,102,117,108,108
	db	121,46,32


StringTable112
	db	16,65,116,116,101,109,112,116,115,32,110,117,109,98,101,114,61


StringTable113
	db	25,32,32,32,32,32,32,32,32,70,105,114,115,116,32,83,68,82,101,115,112,111,110,115
	db	101,61


StringTable114
	db	28,32,32,32,32,32,32,32,32,83,68,82,101,115,112,111,110,115,101,115,50,45,51,45
	db	52,45,53,61,40


StringTable115
	db	1,44


StringTable116
	db	1,41


StringTable117
	db	28,32,32,32,32,32,32,32,32,84,104,101,32,67,97,114,100,32,105,115,32,86,50,32
	db	83,68,83,67,32


StringTable118
	db	30,119,105,116,104,32,83,116,97,110,100,97,114,100,32,99,97,112,97,99,105,116
	db	121,32,40,67,67,83,61,48,41


StringTable119
	db	30,32,32,32,32,32,32,32,32,84,104,101,32,67,97,114,100,32,105,115,32,86,50,32
	db	83,67,88,67,32,111,114


StringTable120
	db	36,32,83,68,72,67,32,119,105,116,104,32,69,120,116,101,110,100,101,100,32,99,97,112
	db	97,99,105,116,121,32,40,67,67,83,61,49,41


StringTable121
	db	25,32,69,120,101,99,117,116,101,100,32,85,78,115,117,99,99,101,115,115,102,117
	db	108,108,121,46


StringTable122
	db	12,78,46,32,97,116,116,101,109,112,116,115,61


StringTable123
	db	13,45,45,45,45,45,45,45,45,45,45,45,45,45


StringTable124
	db	16,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45,45


StringTable128
	db	30,45,67,77,68,49,54,32,32,83,117,99,99,101,115,115,102,117,108,108,121,32,32,69
	db	120,101,99,117,116,101,100


StringTable129
	db	2,32,32


StringTable130
	db	31,45,67,77,68,49,54,32,32,85,78,83,85,67,67,69,83,83,70,85,76,76,89,32,69,120
	db	101,99,117,116,101,100


StringTable131
	db	16,32,32,32,32,32,32,32,82,101,115,112,111,110,115,101,61


StringTable132
	db	13,44,32,83,68,95,67,111,117,110,116,101,114,61


StringTable133
	db	8,45,67,77,68,49,55,32,32


StringTable134
	db	17,87,97,105,116,105,110,103,32,102,111,114,32,84,111,107,101,110


StringTable135
	db	2,46,32


StringTable136
	db	21,45,67,77,68,49,55,32,32,83,117,99,99,101,115,115,102,117,108,108,121,32


StringTable137
	db	8,69,120,101,99,117,116,101,100


StringTable138
	db	17,44,32,70,105,114,115,116,32,82,101,115,112,111,110,115,101,61


StringTable139
	db	13,44,32,84,111,107,101,110,40,50,53,52,41,61


StringTable140
	db	13,32,110,46,32,97,116,116,101,109,112,116,115,61


StringTable141
	db	31,45,67,77,68,49,55,32,32,85,78,83,85,67,67,69,83,83,70,85,76,76,89,32,69,120
	db	101,99,117,116,101,100


StringTable142
	db	30,32,32,32,32,32,82,101,97,100,105,110,103,32,77,66,82,32,97,116,32,48,120,49
	db	66,69,32,97,110,100,32


StringTable143
	db	24,80,97,114,116,105,116,105,111,110,32,86,111,108,117,109,101,32,73,68,32,100
	db	97,116,97


StringTable144
	db	14,32,32,70,105,108,101,32,83,121,115,116,101,109,32


StringTable145
	db	23,32,32,70,105,108,101,32,83,121,115,116,101,109,32,86,101,114,32,78,117,109
	db	46,61


StringTable146
	db	15,32,32,86,111,108,117,109,101,95,76,97,98,101,108,61


StringTable147
	db	22,32,32,78,46,32,66,121,116,101,115,32,112,101,114,32,83,101,99,116,111,114,61


StringTable148
	db	24,32,32,78,46,32,83,101,99,116,111,114,32,112,101,114,32,67,108,117,115,116
	db	101,114,61


StringTable149
	db	22,32,32,78,46,32,82,101,115,101,114,118,101,100,32,83,101,99,116,111,114,115
	db	61


StringTable150
	db	10,32,32,78,46,32,70,65,84,83,61


StringTable151
	db	20,32,32,78,46,32,83,101,99,116,111,114,32,112,101,114,32,70,97,116,61


StringTable152
	db	25,32,32,78,46,32,67,108,117,115,116,101,114,32,111,102,32,82,111,111,116,32,68,105
	db	114,61


StringTable153
	db	1,50


StringTable154
	db	22,32,32,80,97,114,116,105,116,105,111,110,95,66,101,103,105,110,95,76,66,65,61


StringTable155
	db	16,32,32,70,97,116,95,66,101,103,105,110,95,76,66,65,61


StringTable156
	db	20,32,32,67,108,117,115,116,101,114,95,66,101,103,105,110,95,76,66,65,61


StringTable157
	db	15,68,105,114,101,99,116,111,114,105,101,115,32,97,110,100


StringTable158
	db	15,32,70,105,108,101,115,32,76,105,115,116,32,105,110,32


StringTable159
	db	10,32,32,68,105,114,32,32,110,46,61


StringTable160
	db	17,32,32,32,32,32,97,116,32,82,101,99,111,114,100,32,110,46


StringTable161
	db	16,68,105,114,101,99,116,111,114,105,101,115,32,97,110,100,32


StringTable162
	db	14,70,105,108,101,115,32,76,105,115,116,32,105,110,32


StringTable163
	db	6,32,32,66,79,79,84


StringTable164
	db	6,32,83,69,67,84,46


StringTable165
	db	13,32,97,116,32,82,101,99,111,114,100,32,110,46


StringTable166
	db	10,32,32,70,105,108,101,32,110,46,61


StringTable167
	db	1,46


;********************************************************************************

;Source: string.h (299)
FN_VAL
;Parse SysInString, convert to word
;Stop parsing and exit on any non-number character
;Clear output value
;Val = 0
	banksel	VAL
	clrf	VAL,BANKED
	clrf	VAL_H,BANKED
;Get input length
;SysCharCount = SysInString(0)
	movffl	SysSYSINSTRINGHandler,AFSR0
	movffl	SysSYSINSTRINGHandler_H,AFSR0_H
	movffl	INDF0,SYSCHARCOUNT
;If SysCharCount = 0 Then Exit Function
	movf	SYSCHARCOUNT,F,BANKED
	btfss	STATUS, Z,ACCESS
	bra	ENDIF192
	banksel	0
	return
ENDIF192
;Parse
;For SysStringTemp = 1 to SysCharCount
	clrf	SYSSTRINGTEMP,BANKED
	movlw	1
	subwf	SYSCHARCOUNT,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoopEnd29
SysForLoop29
	incf	SYSSTRINGTEMP,F,BANKED
;SysStrData = SysInString(SysStringTemp)
	movf	SYSSTRINGTEMP,W,BANKED
	addwf	SysSYSINSTRINGHandler,W,BANKED
	movwf	AFSR0,ACCESS
	movlw	0
	addwfc	SysSYSINSTRINGHandler_H,W,BANKED
	movwf	AFSR0_H,ACCESS
	movffl	INDF0,SYSSTRDATA
;Exit if non-digit encountered
;If SysStrData < 48 Then Exit Sub
	movlw	48
	subwf	SYSSTRDATA,W,BANKED
	btfsc	STATUS, C,ACCESS
	bra	ENDIF194
	banksel	0
	return
ENDIF194
;If SysStrData > 57 Then Exit Sub
	movf	SYSSTRDATA,W,BANKED
	sublw	57
	btfsc	STATUS, C,ACCESS
	bra	ENDIF195
	banksel	0
	return
ENDIF195
;Add to output value
;Val = Val * 10 + SysStrData - 48
	movff	VAL,SysWORDTempA
	movff	VAL_H,SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB,ACCESS
	clrf	SysWORDTempB_H,ACCESS
	banksel	0
	call	SysMultSub16
	banksel	SYSSTRDATA
	movf	SYSSTRDATA,W,BANKED
	addwf	SysWORDTempX,W,ACCESS
	movwf	SysTemp1,BANKED
	movlw	0
	addwfc	SysWORDTempX_H,W,ACCESS
	movwf	SysTemp1_H,BANKED
	movlw	48
	subwf	SysTemp1,W,BANKED
	movwf	VAL,BANKED
	movlw	0
	subwfb	SysTemp1_H,W,BANKED
	movwf	VAL_H,BANKED
;Next
	movf	SYSCHARCOUNT,W,BANKED
	subwf	SYSSTRINGTEMP,W,BANKED
	btfss	STATUS, C,ACCESS
	bra	SysForLoop29
SysForLoopEnd29
	banksel	0
	return

;********************************************************************************


 END
