;Program compiled by Great Cow BASIC (0.98.<<>> 2019-04-02  (Windows 32 bit))
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F1829, r=DEC
#include <P16F1829.inc>
 __CONFIG _CONFIG1, _CP_OFF & _MCLRE_OFF & _WDTE_OFF & _FOSC_INTOSC
 __CONFIG _CONFIG2, _LVP_OFF & _PLLEN_OFF

;********************************************************************************

;Set aside memory locations for variables
ANIMATE_DELAY	EQU	32
ANIMATE_MODE	EQU	33
BIT_MODE	EQU	34
BUILT_VALUE	EQU	35
BUILT_VALUEL	EQU	37
BUILT_VALUEL_E	EQU	40
BUILT_VALUEL_H	EQU	38
BUILT_VALUEL_U	EQU	39
BUILT_VALUE_H	EQU	36
BUTTON_VALUE	EQU	41
CGARRAY	EQU	9179
CLOCKS	EQU	42
CURMS	EQU	43
CURMS_H	EQU	44
DAT	EQU	45
DAT_OUT	EQU	46
DECODE_VALUE	EQU	47
DELAYTEMP	EQU	112
DELAYTEMP2	EQU	113
DISPLAYHI	EQU	48
DISPLAYHIL	EQU	49
DISPLAYLO	EQU	50
DISPLAYLOL	EQU	51
DISPLAY_VALUE	EQU	52
DISPLAY_VALUEL	EQU	54
DISPLAY_VALUEL_E	EQU	57
DISPLAY_VALUEL_H	EQU	55
DISPLAY_VALUEL_U	EQU	56
DISPLAY_VALUE_H	EQU	53
D_VALUE	EQU	58
D_VALUEL	EQU	60
D_VALUEL_E	EQU	63
D_VALUEL_H	EQU	61
D_VALUEL_U	EQU	62
D_VALUE_H	EQU	59
HIGHCHAR	EQU	64
INPUT_VALUE	EQU	65
INPUT_VALUEL	EQU	67
INPUT_VALUEL_E	EQU	70
INPUT_VALUEL_H	EQU	68
INPUT_VALUEL_U	EQU	69
INPUT_VALUE_H	EQU	66
LAST_MODE	EQU	71
LCDBYTE	EQU	72
LCDCHAR	EQU	73
LCDCHARLOC	EQU	74
LCDCOLUMN	EQU	75
LCDLINE	EQU	76
LCDREADY	EQU	77
LCDTEMP	EQU	78
LCDVALUE	EQU	79
LCDVALUETEMP	EQU	83
LCDVALUE_E	EQU	82
LCDVALUE_H	EQU	80
LCDVALUE_U	EQU	81
LCD_STATE	EQU	84
LOWCHAR	EQU	85
LSTMS	EQU	86
LSTMS_H	EQU	87
MATH_LOOP	EQU	88
MATH_LOOP_H	EQU	89
MILLIS	EQU	90
MILLIS_E	EQU	93
MILLIS_H	EQU	91
MILLIS_U	EQU	92
MODE	EQU	94
MSCTR_	EQU	95
MSCTR__E	EQU	98
MSCTR__H	EQU	96
MSCTR__U	EQU	97
OP	EQU	99
OPERAND	EQU	100
OPERATE1	EQU	101
OPERATE1L	EQU	103
OPERATE1L_E	EQU	106
OPERATE1L_H	EQU	104
OPERATE1L_U	EQU	105
OPERATE1_H	EQU	102
OPERATE2	EQU	107
OPERATE2L	EQU	160
OPERATE2L_E	EQU	163
OPERATE2L_H	EQU	161
OPERATE2L_U	EQU	162
OPERATE2_H	EQU	108
PRINTLEN	EQU	109
RANDB1	EQU	110
RANDB2	EQU	111
RANDB3	EQU	164
RANDB4	EQU	165
RANDOM	EQU	166
RANDOMSEED	EQU	167
RANDOMSEED_H	EQU	168
RANDOMTEMP	EQU	169
RANDOMTEMP_H	EQU	170
RESULT	EQU	171
RESULTL	EQU	173
RESULTL_E	EQU	176
RESULTL_H	EQU	174
RESULTL_U	EQU	175
RESULT_H	EQU	172
ROW	EQU	177
RSEED	EQU	178
SAVEPCLATH	EQU	179
STRINGPOINTER	EQU	180
SYSBITVAR0	EQU	181
SYSBSR	EQU	182
SYSBYTETEMPA	EQU	117
SYSBYTETEMPB	EQU	121
SYSBYTETEMPX	EQU	112
SYSCALCTEMPA	EQU	117
SYSCALCTEMPA_E	EQU	120
SYSCALCTEMPA_H	EQU	118
SYSCALCTEMPA_U	EQU	119
SYSCALCTEMPX	EQU	112
SYSCALCTEMPX_H	EQU	113
SYSDIVLOOP	EQU	116
SYSDIVMULTA	EQU	119
SYSDIVMULTA_H	EQU	120
SYSDIVMULTB	EQU	123
SYSDIVMULTB_H	EQU	124
SYSDIVMULTX	EQU	114
SYSDIVMULTX_H	EQU	115
SYSINTSTATESAVE0	EQU	183
SYSLCDCHARDATAHANDLER	EQU	184
SYSLCDCHARDATAHANDLER_H	EQU	185
SYSLONGDIVMULTA	EQU	186
SYSLONGDIVMULTA_E	EQU	189
SYSLONGDIVMULTA_H	EQU	187
SYSLONGDIVMULTA_U	EQU	188
SYSLONGDIVMULTB	EQU	190
SYSLONGDIVMULTB_E	EQU	193
SYSLONGDIVMULTB_H	EQU	191
SYSLONGDIVMULTB_U	EQU	192
SYSLONGDIVMULTX	EQU	194
SYSLONGDIVMULTX_E	EQU	197
SYSLONGDIVMULTX_H	EQU	195
SYSLONGDIVMULTX_U	EQU	196
SYSLONGTEMPA	EQU	117
SYSLONGTEMPA_E	EQU	120
SYSLONGTEMPA_H	EQU	118
SYSLONGTEMPA_U	EQU	119
SYSLONGTEMPB	EQU	121
SYSLONGTEMPB_E	EQU	124
SYSLONGTEMPB_H	EQU	122
SYSLONGTEMPB_U	EQU	123
SYSLONGTEMPX	EQU	112
SYSLONGTEMPX_E	EQU	115
SYSLONGTEMPX_H	EQU	113
SYSLONGTEMPX_U	EQU	114
SYSPRINTBUFFER	EQU	9188
SYSPRINTBUFFLEN	EQU	198
SYSPRINTDATAHANDLER	EQU	199
SYSPRINTDATAHANDLER_H	EQU	200
SYSPRINTTEMP	EQU	201
SYSREPEATTEMP1	EQU	202
SYSREPEATTEMP2	EQU	203
SYSSTATUS	EQU	127
SYSSTRINGA	EQU	119
SYSSTRINGA_H	EQU	120
SYSTEMP1	EQU	204
SYSTEMP1_E	EQU	207
SYSTEMP1_H	EQU	205
SYSTEMP1_U	EQU	206
SYSTEMP2	EQU	208
SYSTEMP2_H	EQU	209
SYSW	EQU	126
SYSWAITTEMP10US	EQU	117
SYSWAITTEMPMS	EQU	114
SYSWAITTEMPMS_H	EQU	115
SYSWAITTEMPUS	EQU	117
SYSWAITTEMPUS_H	EQU	118
SYSWORDTEMPA	EQU	117
SYSWORDTEMPA_H	EQU	118
SYSWORDTEMPB	EQU	121
SYSWORDTEMPB_H	EQU	122
SYSWORDTEMPX	EQU	112
SYSWORDTEMPX_H	EQU	113
TEMP	EQU	210
TEMP_W	EQU	211
TEMP_W_H	EQU	212
TENTHOU	EQU	213
TMRPRES	EQU	214
TMRSOURCE	EQU	215
ZERO_VALUE	EQU	216

;********************************************************************************

;Alias variables
AFSR0	EQU	4
AFSR0_H	EQU	5
EEADDRESS	EQU	401
EEADDRESS_H	EQU	402
EEDATAVALUE	EQU	403
SYSCGARRAY_1	EQU	1596
SYSCGARRAY_2	EQU	1597
SYSCGARRAY_3	EQU	1598
SYSCGARRAY_4	EQU	1599
SYSCGARRAY_5	EQU	1600
SYSCGARRAY_6	EQU	1601
SYSCGARRAY_7	EQU	1602
SYSCGARRAY_8	EQU	1603

;********************************************************************************

;Vectors
	ORG	0
	pagesel	BASPROGRAMSTART
	goto	BASPROGRAMSTART
	ORG	4
Interrupt

;********************************************************************************

;Save Context
	movwf	SysW
	swapf	STATUS,W
	movwf	SysSTATUS
	movf	BSR,W
	banksel	STATUS
	banksel	SYSBSR
	movwf	SysBSR
;Store system variables
	movf	PCLATH,W
	movwf	SavePCLATH
	clrf	PCLATH
;On Interrupt handlers
	btfss	INTCON,TMR0IE
	goto	NotTMR0IF
	btfss	INTCON,TMR0IF
	goto	NotTMR0IF
	banksel	STATUS
	pagesel	MSCTR_INT_HDLR
	call	MSCTR_INT_HDLR
	pagesel	$
	bcf	INTCON,TMR0IF
	goto	INTERRUPTDONE
NotTMR0IF
;User Interrupt routine
INTERRUPTDONE
;Restore Context
;Restore system variables
	banksel	SAVEPCLATH
	movf	SavePCLATH,W
	movwf	PCLATH
	movf	SysBSR,W
	movwf	BSR
	swapf	SysSTATUS,W
	movwf	STATUS
	swapf	SysW,F
	swapf	SysW,W
	retfie
	banksel	STATUS

;********************************************************************************

;Start of program memory page 0
	ORG	36
BASPROGRAMSTART
;Call initialisation routines
	call	INITSYS
	call	SETPORTDIR
	call	INIT_MSCTR_INT
	call	INITLCD
	call	INITRANDOM
;Enable interrupts
	bsf	INTCON,GIE
	bsf	INTCON,PEIE

;Start of the main program
;Pic 16F1829 Binary, Decimal and Hexadecimal Calculator using a 74HC165 Keyboard scanner (24 buttons) and a 16x2 LCD
;(c) Mark Stevenson MkEDS 2018
;#define Codeversion "3.14 15th Mar"
;#define TimeOut 20000     ' Flash rate in mS
;Main                    ' This loop runs over and over forever.
;LstMs = 0
	clrf	LSTMS
	clrf	LSTMS_H
;CurMs = 0
	clrf	CURMS
	clrf	CURMS_H
;TimeOutState = false
	banksel	SYSBITVAR0
	bcf	SYSBITVAR0,0
;#Define Debug
;Variables used
;Dim     TimeOutState  As Bit
;Dim     CurMs, LstMs  as word  ' declare working variables
;Dim     Dat           As Byte
;Dim     Temp          As Byte
;Dim     RandB1        As Byte
;Dim     RandB2        As Byte
;Dim     RandB3        As Byte
;Dim     RandB4        As Byte
;Dim     Clocks        As Byte
;Dim     Dat_Out       As Byte
;Dim     Button_Value  As Byte
;Dim     Row           As Byte
;Dim     Decode_Value  As Byte
;Dim     Zero_Value    As Byte
;Dim     Input_Value   As Word
;Dim     Operate1      As Word
;Dim     Operate2      As Word
;Dim     Built_Value   As Word
;Dim     Result        As Word
;Dim     Input_ValueL   As Long
;Dim     Display_ValueL As Long
;Dim     Display_Value  As Word
;Dim     DisplayHiL     As Byte
;Dim     DisplayLoL     As Byte
;Dim     DisplayHi      As Byte
;Dim     DisplayLo      As Byte
;Dim     Operate1L      As Long
;Dim     Operate2L      As Long
;Dim     Built_ValueL   As Long
;Dim     ResultL        As Long
;Dim     Operand       As Byte
;Dim     Op            As Byte
;Dim     Mode          As Byte
;Dim     Bit_Mode      As Byte
;Dim     Last_Mode     As Byte
;Dim     Not_Active    As Byte
;Dim     RSeed         As Byte
;Dim     RandomSeed    As Byte
;Dim     TenThou       As Byte
;Dim     Math_Loop     As Word
;Dim     Temp_W        As Word
;Dim     Animate_Mode  As Byte
;Dim     Animate_Delay As Byte
;Dim     CGArray (8)
;StartUp
	banksel	STATUS
	pagesel	STARTUP
	call	STARTUP
	pagesel	$
;Do
SysDoLoop_S1
;If Bit_Mode = Bit_16 Then
	banksel	BIT_MODE
	decf	BIT_MODE,W
	btfss	STATUS, Z
	goto	ELSE1_1
;MainLoop_Sub
	pagesel	MAINLOOP_SUB
	call	MAINLOOP_SUB
	pagesel	$
;Else
	goto	ENDIF1
ELSE1_1
;MainLoop_SubL
	call	MAINLOOP_SUBL
;End If
ENDIF1
;If RandomSeed = 0 Then
	banksel	RANDOMSEED
	movf	RANDOMSEED,F
	btfsc	STATUS, Z
;Let RSeed = RSeed + 1 'Seed the random number generator to the time of the loop before 'Random' is requested
	incf	RSEED,F
;End If
ENDIF2
;Loop
	goto	SysDoLoop_S1
SysDoLoop_E1
BASPROGRAMEND
	sleep
	goto	BASPROGRAMEND

;********************************************************************************

DO_MATHS
;If Bit_Mode = Bit_32 Then
	movlw	2
	subwf	BIT_MODE,W
	btfss	STATUS, Z
	goto	ENDIF138
;Do_MathsL
	pagesel	DO_MATHSL
	call	DO_MATHSL
	pagesel	$
;Exit Sub
	return
;End If
ENDIF138
;If Operate1 > 0 Then
;If Operate2 > 0 Then
;If Operand > 0 Then
	movf	OPERAND,W
	sublw	0
	btfsc	STATUS, C
	goto	ENDIF139
;If Operand = BtPl Then
	movlw	17
	subwf	OPERAND,W
	btfss	STATUS, Z
	goto	ENDIF140
;If Animate_Mode = Animate Then
	decf	ANIMATE_MODE,W
	btfss	STATUS, Z
	goto	ELSE149_1
;For Math_Loop = 1 to Operate2
	clrf	MATH_LOOP
	clrf	MATH_LOOP_H
	movlw	1
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	movf	OPERATE2,W
	movwf	SysWORDTempA
	movf	OPERATE2_H,W
	movwf	SysWORDTempA_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd3
ENDIF153
SysForLoop3
	incf	MATH_LOOP,F
	btfsc	STATUS,Z
	incf	MATH_LOOP_H,F
;Let Operate1 = Operate1 + 1
	incf	OPERATE1,F
	btfsc	STATUS,Z
	incf	OPERATE1_H,F
;Show_ValuesSub(Operate1)
	movf	OPERATE1,W
	movwf	D_VALUE
	movf	OPERATE1_H,W
	movwf	D_VALUE_H
	pagesel	SHOW_VALUESSUB
	call	SHOW_VALUESSUB
;Get_Buttons
	pagesel	GET_BUTTONS
	call	GET_BUTTONS
	pagesel	$
;If Button_Value <> BtMode Then
	movlw	27
	subwf	BUTTON_VALUE,W
	btfsc	STATUS, Z
	goto	ENDIF154
;Wait Animate_Delay mS
	movf	ANIMATE_DELAY,W
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;Show_ValuesSub(Operate1)
	movf	OPERATE1,W
	movwf	D_VALUE
	movf	OPERATE1_H,W
	movwf	D_VALUE_H
	pagesel	SHOW_VALUESSUB
	call	SHOW_VALUESSUB
	pagesel	$
;End If
ENDIF154
;Next
	movf	MATH_LOOP,W
	movwf	SysWORDTempA
	movf	MATH_LOOP_H,W
	movwf	SysWORDTempA_H
	movf	OPERATE2,W
	movwf	SysWORDTempB
	movf	OPERATE2_H,W
	movwf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop3
ENDIF155
SysForLoopEnd3
;Let Result = Operate1
	movf	OPERATE1,W
	banksel	RESULT
	movwf	RESULT
	banksel	OPERATE1_H
	movf	OPERATE1_H,W
	banksel	RESULT_H
	movwf	RESULT_H
;Else
	goto	ENDIF149
ELSE149_1
;Let Result = Operate1 + Operate2
	movf	OPERATE2,W
	addwf	OPERATE1,W
	banksel	RESULT
	movwf	RESULT
	banksel	OPERATE2_H
	movf	OPERATE2_H,W
	addwfc	OPERATE1_H,W
	banksel	RESULT_H
	movwf	RESULT_H
;End If
ENDIF149
;End If
ENDIF140
;If Operand = BtMi Then
	movlw	18
	banksel	OPERAND
	subwf	OPERAND,W
	btfss	STATUS, Z
	goto	ENDIF141
;If Animate_Mode = Animate Then
	decf	ANIMATE_MODE,W
	btfss	STATUS, Z
	goto	ELSE150_1
;For Math_Loop = 1 to Operate2
	clrf	MATH_LOOP
	clrf	MATH_LOOP_H
	movlw	1
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	movf	OPERATE2,W
	movwf	SysWORDTempA
	movf	OPERATE2_H,W
	movwf	SysWORDTempA_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd4
ENDIF156
SysForLoop4
	incf	MATH_LOOP,F
	btfsc	STATUS,Z
	incf	MATH_LOOP_H,F
;Let Operate1 = Operate1 - 1
	movlw	1
	subwf	OPERATE1,F
	movlw	0
	subwfb	OPERATE1_H,F
;Show_ValuesSub(Operate1)
	movf	OPERATE1,W
	movwf	D_VALUE
	movf	OPERATE1_H,W
	movwf	D_VALUE_H
	pagesel	SHOW_VALUESSUB
	call	SHOW_VALUESSUB
;Get_Buttons
	pagesel	GET_BUTTONS
	call	GET_BUTTONS
	pagesel	$
;If Button_Value <> BtMode Then
	movlw	27
	subwf	BUTTON_VALUE,W
	btfsc	STATUS, Z
	goto	ENDIF157
;Wait Animate_Delay mS
	movf	ANIMATE_DELAY,W
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;Show_ValuesSub(Operate1)
	movf	OPERATE1,W
	movwf	D_VALUE
	movf	OPERATE1_H,W
	movwf	D_VALUE_H
	pagesel	SHOW_VALUESSUB
	call	SHOW_VALUESSUB
	pagesel	$
;End If
ENDIF157
;Next
	movf	MATH_LOOP,W
	movwf	SysWORDTempA
	movf	MATH_LOOP_H,W
	movwf	SysWORDTempA_H
	movf	OPERATE2,W
	movwf	SysWORDTempB
	movf	OPERATE2_H,W
	movwf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop4
ENDIF158
SysForLoopEnd4
;Let Result = Operate1
	movf	OPERATE1,W
	banksel	RESULT
	movwf	RESULT
	banksel	OPERATE1_H
	movf	OPERATE1_H,W
	banksel	RESULT_H
	movwf	RESULT_H
;Else
	goto	ENDIF150
ELSE150_1
;Let Result = Operate1 - Operate2
	movf	OPERATE2,W
	subwf	OPERATE1,W
	banksel	RESULT
	movwf	RESULT
	banksel	OPERATE2_H
	movf	OPERATE2_H,W
	subwfb	OPERATE1_H,W
	banksel	RESULT_H
	movwf	RESULT_H
;End If
ENDIF150
;End If
ENDIF141
;If Operand = BtDi Then
	movlw	19
	banksel	OPERAND
	subwf	OPERAND,W
	btfss	STATUS, Z
	goto	ENDIF142
;If Operate1 >= Operate2 Then
;If Animate_Mode = Animate Then
	decf	ANIMATE_MODE,W
	btfss	STATUS, Z
	goto	ELSE151_1
;Let Math_Loop = 0
	clrf	MATH_LOOP
	clrf	MATH_LOOP_H
;Do
SysDoLoop_S4
;Let Operate1 = Operate1 - Operate2
	movf	OPERATE2,W
	subwf	OPERATE1,F
	movf	OPERATE2_H,W
	subwfb	OPERATE1_H,F
;Let Math_Loop = Math_Loop + 1
	incf	MATH_LOOP,F
	btfsc	STATUS,Z
	incf	MATH_LOOP_H,F
;Show_ValuesSub(Operate1)
	movf	OPERATE1,W
	movwf	D_VALUE
	movf	OPERATE1_H,W
	movwf	D_VALUE_H
	pagesel	SHOW_VALUESSUB
	call	SHOW_VALUESSUB
;Get_Buttons
	pagesel	GET_BUTTONS
	call	GET_BUTTONS
	pagesel	$
;If Button_Value <> BtMode Then
	movlw	27
	subwf	BUTTON_VALUE,W
	btfsc	STATUS, Z
	goto	ENDIF159
;Wait Animate_Delay mS
	movf	ANIMATE_DELAY,W
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;Show_ValuesSub(Operate1)
	movf	OPERATE1,W
	movwf	D_VALUE
	movf	OPERATE1_H,W
	movwf	D_VALUE_H
	pagesel	SHOW_VALUESSUB
	call	SHOW_VALUESSUB
	pagesel	$
;End If
ENDIF159
;Loop While Operate1 >= Operate2
	movf	operate1,W
	movwf	SysWORDTempA
	movf	operate1_H,W
	movwf	SysWORDTempA_H
	movf	operate2,W
	movwf	SysWORDTempB
	movf	operate2_H,W
	movwf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	comf	SysByteTempX,F
	btfsc	SysByteTempX,0
	goto	SysDoLoop_S4
SysDoLoop_E4
;Let Result = Math_Loop
	movf	MATH_LOOP,W
	banksel	RESULT
	movwf	RESULT
	banksel	MATH_LOOP_H
	movf	MATH_LOOP_H,W
	banksel	RESULT_H
	movwf	RESULT_H
;Else
	goto	ENDIF151
ELSE151_1
;Let Result = Operate1 / Operate2
	movf	OPERATE1,W
	movwf	SysWORDTempA
	movf	OPERATE1_H,W
	movwf	SysWORDTempA_H
	movf	OPERATE2,W
	movwf	SysWORDTempB
	movf	OPERATE2_H,W
	movwf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempA,W
	banksel	RESULT
	movwf	RESULT
	movf	SysWORDTempA_H,W
	movwf	RESULT_H
;End If
ENDIF151
;Else   'Division equals zero
;Let Result   = 0
;End If
;End If
ENDIF142
;If Operand = BtMu Then
	movlw	20
	banksel	OPERAND
	subwf	OPERAND,W
	btfss	STATUS, Z
	goto	ENDIF143
;If Animate_Mode = Animate Then
	decf	ANIMATE_MODE,W
	btfss	STATUS, Z
	goto	ELSE152_1
;Let Temp_W = Operate1
	movf	OPERATE1,W
	banksel	TEMP_W
	movwf	TEMP_W
	banksel	OPERATE1_H
	movf	OPERATE1_H,W
	banksel	TEMP_W_H
	movwf	TEMP_W_H
;For Math_Loop = 2 to Operate2
	movlw	1
	banksel	MATH_LOOP
	movwf	MATH_LOOP
	clrf	MATH_LOOP_H
	movlw	2
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	movf	OPERATE2,W
	movwf	SysWORDTempA
	movf	OPERATE2_H,W
	movwf	SysWORDTempA_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoopEnd5
ENDIF160
SysForLoop5
	incf	MATH_LOOP,F
	btfsc	STATUS,Z
	incf	MATH_LOOP_H,F
;Let Operate1 = Operate1 + Temp_W
	banksel	TEMP_W
	movf	TEMP_W,W
	banksel	OPERATE1
	addwf	OPERATE1,F
	banksel	TEMP_W_H
	movf	TEMP_W_H,W
	banksel	OPERATE1_H
	addwfc	OPERATE1_H,F
;Get_Buttons
	pagesel	GET_BUTTONS
	call	GET_BUTTONS
	pagesel	$
;If Button_Value <> BtMode Then
	movlw	27
	subwf	BUTTON_VALUE,W
	btfsc	STATUS, Z
	goto	ENDIF161
;Wait Animate_Delay mS
	movf	ANIMATE_DELAY,W
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;Show_ValuesSub(Operate1)
	movf	OPERATE1,W
	movwf	D_VALUE
	movf	OPERATE1_H,W
	movwf	D_VALUE_H
	pagesel	SHOW_VALUESSUB
	call	SHOW_VALUESSUB
	pagesel	$
;End If
ENDIF161
;Next
	movf	MATH_LOOP,W
	movwf	SysWORDTempA
	movf	MATH_LOOP_H,W
	movwf	SysWORDTempA_H
	movf	OPERATE2,W
	movwf	SysWORDTempB
	movf	OPERATE2_H,W
	movwf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
	goto	SysForLoop5
ENDIF162
SysForLoopEnd5
;Let Result = Operate1
	movf	OPERATE1,W
	banksel	RESULT
	movwf	RESULT
	banksel	OPERATE1_H
	movf	OPERATE1_H,W
	banksel	RESULT_H
	movwf	RESULT_H
;Else
	goto	ENDIF152
ELSE152_1
;Let Result = Operate1 * Operate2
	movf	OPERATE1,W
	movwf	SysWORDTempA
	movf	OPERATE1_H,W
	movwf	SysWORDTempA_H
	movf	OPERATE2,W
	movwf	SysWORDTempB
	movf	OPERATE2_H,W
	movwf	SysWORDTempB_H
	pagesel	SysMultSub16
	call	SysMultSub16
	pagesel	$
	movf	SysWORDTempX,W
	banksel	RESULT
	movwf	RESULT
	movf	SysWORDTempX_H,W
	movwf	RESULT_H
;End If
ENDIF152
;End If
ENDIF143
;If Operand = BtAn Then
	movlw	21
	banksel	OPERAND
	subwf	OPERAND,W
	btfss	STATUS, Z
	goto	ENDIF144
;Let Result = Operate1 And Operate2
	movf	OPERATE1,W
	andwf	OPERATE2,W
	banksel	RESULT
	movwf	RESULT
	banksel	OPERATE1_H
	movf	OPERATE1_H,W
	andwf	OPERATE2_H,W
	banksel	RESULT_H
	movwf	RESULT_H
;End If
ENDIF144
;If Operand = BtOr Then
	movlw	23
	banksel	OPERAND
	subwf	OPERAND,W
	btfss	STATUS, Z
	goto	ENDIF145
;Let Result = Operate1 Or Operate2
	movf	OPERATE1,W
	iorwf	OPERATE2,W
	banksel	RESULT
	movwf	RESULT
	banksel	OPERATE1_H
	movf	OPERATE1_H,W
	iorwf	OPERATE2_H,W
	banksel	RESULT_H
	movwf	RESULT_H
;End If
ENDIF145
;If Operand = BtXor Then
	movlw	24
	banksel	OPERAND
	subwf	OPERAND,W
	btfss	STATUS, Z
	goto	ENDIF146
;Let Result = Operate1 # Operate2
	movf	OPERATE1,W
	xorwf	OPERATE2,W
	banksel	RESULT
	movwf	RESULT
	banksel	OPERATE1_H
	movf	OPERATE1_H,W
	xorwf	OPERATE2_H,W
	banksel	RESULT_H
	movwf	RESULT_H
;End If
ENDIF146
;If Operand = BtModulo Then
	movlw	22
	banksel	OPERAND
	subwf	OPERAND,W
	btfss	STATUS, Z
	goto	ENDIF147
;Let Result = Operate1 % Operate2
	movf	OPERATE1,W
	movwf	SysWORDTempA
	movf	OPERATE1_H,W
	movwf	SysWORDTempA_H
	movf	OPERATE2,W
	movwf	SysWORDTempB
	movf	OPERATE2_H,W
	movwf	SysWORDTempB_H
	pagesel	SysDivSub16
	call	SysDivSub16
	pagesel	$
	movf	SysWORDTempX,W
	banksel	RESULT
	movwf	RESULT
	movf	SysWORDTempX_H,W
	movwf	RESULT_H
;End If
ENDIF147
;If Result = 0 Then 'Clear ready for new calculation'
	banksel	RESULT
	movf	RESULT,W
	movwf	SysWORDTempA
	movf	RESULT_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF148
;Let Op       = 1
	movlw	1
	movwf	OP
;Let Operate1 = 0
	clrf	OPERATE1
	clrf	OPERATE1_H
;Let Operate2 = 0
	clrf	OPERATE2
	clrf	OPERATE2_H
;Let Result   = 0
	banksel	RESULT
	clrf	RESULT
	clrf	RESULT_H
;Let Operand  = Answer
	movlw	29
	banksel	OPERAND
	movwf	OPERAND
;End If
ENDIF148
;End If
ENDIF139
;End If
;End If
	return

;********************************************************************************

INITLCD
;Initialization routines based upon code examples
;in HD44780 datasheet
;Configure RS,Enable & RW pin directions
;DIR LCD_RS OUT
	banksel	TRISA
	bcf	TRISA,0
;DIR LCD_Enable OUT
	bcf	TRISA,1
;wait 10 ms
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	banksel	STATUS
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;Wait until LCDReady
SysWaitLoop2
	pagesel	FN_LCDREADY
	call	FN_LCDREADY
	pagesel	$
	movf	LCDREADY,F
	btfsc	STATUS,Z
	goto	SysWaitLoop2
;SET LCD_RS OFF
	banksel	LATA
	bcf	LATA,0
;***********************************
;4-bit initialization routine
;***********************************
;revised LCDINIT Evan Venn March 2014
;modified by William Roth  July 2104
;Set pins to output
;DIR LCD_DB4 OUT
	banksel	TRISA
	bcf	TRISA,2
;DIR LCD_DB5 OUT
	bcf	TRISC,0
;DIR LCD_DB6 OUT
	bcf	TRISC,1
;DIR LCD_DB7 OUT
	bcf	TRISC,2
;wait 15 ms
	movlw	15
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	banksel	STATUS
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;Wakeup 0x30
;set LCD_DB4 ON
	banksel	LATA
	bsf	LATA,2
;set LCD_DB5 ON
	bsf	LATC,0
;set LCD_DB6 OFF
	bcf	LATC,1
;set LCD_DB7 OFF
	bcf	LATC,2
;wait 2 us
	movlw	5
	movwf	DELAYTEMP
DelayUS4
	decfsz	DELAYTEMP,F
	goto	DelayUS4
;PULSEOUT LCD_Enable, 2 us
;Set Pin On
	bsf	LATA,1
;Wait Time
	movlw	5
	movwf	DELAYTEMP
DelayUS5
	decfsz	DELAYTEMP,F
	goto	DelayUS5
;Set Pin Off
	bcf	LATA,1
;wait 5 ms
	movlw	5
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	banksel	STATUS
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;Repeat 3   'three more times
	movlw	3
	banksel	SYSREPEATTEMP1
	movwf	SysRepeatTemp1
SysRepeatLoop1
;PULSEOUT LCD_Enable, 2 us
;Set Pin On
	banksel	LATA
	bsf	LATA,1
;Wait Time
	movlw	5
	movwf	DELAYTEMP
DelayUS6
	decfsz	DELAYTEMP,F
	goto	DelayUS6
;Set Pin Off
	bcf	LATA,1
;Wait 200 us
	movlw	2
	movwf	DELAYTEMP2
DelayUSO7
	clrf	DELAYTEMP
DelayUS7
	decfsz	DELAYTEMP,F
	goto	DelayUS7
	decfsz	DELAYTEMP2,F
	goto	DelayUSO7
	movlw	19
	movwf	DELAYTEMP
DelayUS8
	decfsz	DELAYTEMP,F
	goto	DelayUS8
;end repeat
	banksel	SYSREPEATTEMP1
	decfsz	SysRepeatTemp1,F
	goto	SysRepeatLoop1
SysRepeatLoopEnd1
;Wait 5 ms
	movlw	5
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	banksel	STATUS
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;Set 4 bit mode    (0x20)
;set LCD_DB4 OFF
	banksel	LATA
	bcf	LATA,2
;set LCD_DB5 ON
	bsf	LATC,0
;set LCD_DB6 OFF
	bcf	LATC,1
;set LCD_DB7 OFF
	bcf	LATC,2
;wait 2 us
	movlw	5
	movwf	DELAYTEMP
DelayUS9
	decfsz	DELAYTEMP,F
	goto	DelayUS9
;PULSEOUT LCD_Enable, 2 us
;Set Pin On
	bsf	LATA,1
;Wait Time
	movlw	5
	movwf	DELAYTEMP
DelayUS10
	decfsz	DELAYTEMP,F
	goto	DelayUS10
;Set Pin Off
	bcf	LATA,1
;Wait 50 us
	movlw	133
	movwf	DELAYTEMP
DelayUS11
	decfsz	DELAYTEMP,F
	goto	DelayUS11
;===== now in 4 bit mode =====
;LCDWriteByte 0x28    '(b'011000000') 0x28  set 2 line mode
	movlw	40
	banksel	LCDBYTE
	movwf	LCDBYTE
	pagesel	LCDNORMALWRITEBYTE
	call	LCDNORMALWRITEBYTE
	pagesel	$
;LCDWriteByte 0x06    '(b'00000110')  'Set Cursor movement
	movlw	6
	movwf	LCDBYTE
	pagesel	LCDNORMALWRITEBYTE
	call	LCDNORMALWRITEBYTE
	pagesel	$
;LCDWriteByte 0x0C    '(b'00001100')  'Turn off cursor
	movlw	12
	movwf	LCDBYTE
	pagesel	LCDNORMALWRITEBYTE
	call	LCDNORMALWRITEBYTE
;CLS  'Clear the display
	pagesel	CLS
	call	CLS
	pagesel	$
;***********************************
;I2C pcf8574 initialization routine
;***********************************
;LCD_State = 12
	movlw	12
	movwf	LCD_STATE
	return

;********************************************************************************

INITRANDOM
;Dim RandomSeed As Word
;RandomSeed = RandStart
	movlw	134
	banksel	RANDOMSEED
	movwf	RANDOMSEED
	movlw	121
	movwf	RANDOMSEED_H
	banksel	STATUS
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
;ANSELC = 0
	clrf	ANSELC
;End clearing any ANSEL variants in the part
;Comparator register bits for 12F510,16F506, PIC16F1535, 18f etc classes
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
	return

;********************************************************************************

INIT_MSCTR_INT
;Add the handler for the interrupt
;On Interrupt Timer0Overflow Call MsCtr_Int_Hdlr
	bsf	INTCON,TMR0IE
;MsCtr_ = 0
	clrf	MSCTR_
	clrf	MSCTR__H
	clrf	MSCTR__U
	clrf	MSCTR__E
;Millis = 0
	pagesel	FN_MILLIS
	call	FN_MILLIS
	pagesel	$
;asm ShowDebug 8bit / 16bit No Postscaler
;8bit / 16bit no postscaler
;InitTimer0 Osc, PS0_32
	movlw	1
	banksel	TMRSOURCE
	movwf	TMRSOURCE
	movlw	4
	movwf	TMRPRES
	banksel	STATUS
	pagesel	INITTIMER0190
	call	INITTIMER0190
	pagesel	$
;asm ShowDebug  Call_SetTimer_Millis_macro
;call_settimer_millis_macro
;SetTimer_Millis Tmr0InitVal
;Handle chips withOUT TMR0H
;TMR0 = TMRValueMillis
	movlw	6
	movwf	TMR0
;asm ShowDebug Call_StartTimer_Millis_macro
;call_starttimer_millis_macro
;StartTimer_Millis
	return

;********************************************************************************

MAINLOOP_SUBL
;Get_Buttons
	pagesel	GET_BUTTONS
	call	GET_BUTTONS
	pagesel	$
;If Button_Value < 255 Then
	movlw	255
	subwf	BUTTON_VALUE,W
	btfsc	STATUS, C
	goto	ENDIF30
;If Button_Value = BtMode Then
	movlw	27
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	ENDIF31
;Check_Mode
	pagesel	CHECK_MODE
	call	CHECK_MODE
	pagesel	$
;End If
ENDIF31
;If Button_Value = BtOr Then
	movlw	23
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	ENDIF32
;Check_Or
	pagesel	CHECK_OR
	call	CHECK_OR
	pagesel	$
;End If
ENDIF32
;If Button_Value = BtEn Then
	movlw	16
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	ENDIF33
;Check_En
	pagesel	CHECK_EN
	call	CHECK_EN
	pagesel	$
;End If
ENDIF33
;If Button_Value = BtAn Then
	movlw	21
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	ENDIF34
;Check_An
	pagesel	CHECK_AN
	call	CHECK_AN
	pagesel	$
;End If
ENDIF34
;If Button_Value = BtDi Then
	movlw	19
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	ENDIF35
;Check_Modulo
	pagesel	CHECK_MODULO
	call	CHECK_MODULO
	pagesel	$
;End If
ENDIF35
;If Operand = Answer Then 'Clear ready for new calculation'
	movlw	29
	subwf	OPERAND,W
	btfss	STATUS, Z
	goto	ENDIF36
;Let Op        = 1
	movlw	1
	movwf	OP
;Let Operate1L = 0
	clrf	OPERATE1L
	clrf	OPERATE1L_H
	clrf	OPERATE1L_U
	clrf	OPERATE1L_E
;Let Operate2L = 0
	banksel	OPERATE2L
	clrf	OPERATE2L
	clrf	OPERATE2L_H
	clrf	OPERATE2L_U
	clrf	OPERATE2L_E
;Let ResultL   = 0
	clrf	RESULTL
	clrf	RESULTL_H
	clrf	RESULTL_U
	clrf	RESULTL_E
;Let Operand   = 0
	banksel	OPERAND
	clrf	OPERAND
;End If
ENDIF36
;If ResultL > 0 Then
	banksel	RESULTL
	movf	RESULTL,W
	movwf	SysLONGTempB
	movf	RESULTL_H,W
	movwf	SysLONGTempB_H
	movf	RESULTL_U,W
	movwf	SysLONGTempB_U
	movf	RESULTL_E,W
	movwf	SysLONGTempB_E
	clrf	SysLONGTempA
	clrf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	banksel	STATUS
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF37
;If Mode = M_Dec Then
	movlw	2
	subwf	MODE,W
	btfss	STATUS, Z
	goto	ENDIF40
;If Button_Value < BtA Then 'Clear ready for new calculation'
	movlw	10
	subwf	BUTTON_VALUE,W
	btfsc	STATUS, C
	goto	ENDIF44
;Let Op        = 1
	movlw	1
	movwf	OP
;Let Operate1L = 0
	clrf	OPERATE1L
	clrf	OPERATE1L_H
	clrf	OPERATE1L_U
	clrf	OPERATE1L_E
;Let Operate2L = 0
	banksel	OPERATE2L
	clrf	OPERATE2L
	clrf	OPERATE2L_H
	clrf	OPERATE2L_U
	clrf	OPERATE2L_E
;Let ResultL   = 0
	clrf	RESULTL
	clrf	RESULTL_H
	clrf	RESULTL_U
	clrf	RESULTL_E
;Let Operand   = 0
	banksel	OPERAND
	clrf	OPERAND
;End If
ENDIF44
;End If
ENDIF40
;If Mode = M_Hex Then
	movlw	3
	subwf	MODE,W
	btfss	STATUS, Z
	goto	ENDIF41
;If Button_Value < BtEn Then 'Clear ready for new calculation'
	movlw	16
	subwf	BUTTON_VALUE,W
	btfsc	STATUS, C
	goto	ENDIF45
;Let Op        = 1
	movlw	1
	movwf	OP
;Let Operate1L = 0
	clrf	OPERATE1L
	clrf	OPERATE1L_H
	clrf	OPERATE1L_U
	clrf	OPERATE1L_E
;Let Operate2L = 0
	banksel	OPERATE2L
	clrf	OPERATE2L
	clrf	OPERATE2L_H
	clrf	OPERATE2L_U
	clrf	OPERATE2L_E
;Let ResultL   = 0
	clrf	RESULTL
	clrf	RESULTL_H
	clrf	RESULTL_U
	clrf	RESULTL_E
;Let Operand   = 0
	banksel	OPERAND
	clrf	OPERAND
;End If
ENDIF45
;End If
ENDIF41
;End If
ENDIF37
;Build_ValueL(Button_Value)
	movf	BUTTON_VALUE,W
	movwf	INPUT_VALUE
	clrf	INPUT_VALUE_H
	pagesel	BUILD_VALUEL
	call	BUILD_VALUEL
	pagesel	$
;If Op = 1 Then
	decf	OP,W
	btfss	STATUS, Z
	goto	ELSE38_1
;Show_ValuesSubL(Operate1L)
	movf	OPERATE1L,W
	movwf	D_VALUEL
	movf	OPERATE1L_H,W
	movwf	D_VALUEL_H
	movf	OPERATE1L_U,W
	movwf	D_VALUEL_U
	movf	OPERATE1L_E,W
	movwf	D_VALUEL_E
	call	SHOW_VALUESSUBL
;Let Operate2L = 0
	banksel	OPERATE2L
	clrf	OPERATE2L
	clrf	OPERATE2L_H
	clrf	OPERATE2L_U
	clrf	OPERATE2L_E
;Let ResultL   = 0
	clrf	RESULTL
	clrf	RESULTL_H
	clrf	RESULTL_U
	clrf	RESULTL_E
;Else
	goto	ENDIF38
ELSE38_1
;If Operate2L > 0 Then
	banksel	OPERATE2L
	movf	OPERATE2L,W
	movwf	SysLONGTempB
	movf	OPERATE2L_H,W
	movwf	SysLONGTempB_H
	movf	OPERATE2L_U,W
	movwf	SysLONGTempB_U
	movf	OPERATE2L_E,W
	movwf	SysLONGTempB_E
	clrf	SysLONGTempA
	clrf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	banksel	STATUS
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	btfss	SysByteTempX,0
	goto	ELSE42_1
;Show_ValuesSubL(Operate2L)
	banksel	OPERATE2L
	movf	OPERATE2L,W
	banksel	D_VALUEL
	movwf	D_VALUEL
	banksel	OPERATE2L_H
	movf	OPERATE2L_H,W
	banksel	D_VALUEL_H
	movwf	D_VALUEL_H
	banksel	OPERATE2L_U
	movf	OPERATE2L_U,W
	banksel	D_VALUEL_U
	movwf	D_VALUEL_U
	banksel	OPERATE2L_E
	movf	OPERATE2L_E,W
	banksel	D_VALUEL_E
	movwf	D_VALUEL_E
	call	SHOW_VALUESSUBL
;Else
	goto	ENDIF42
ELSE42_1
;If ResultL = 0 Then
	banksel	RESULTL
	movf	RESULTL,W
	movwf	SysLONGTempA
	movf	RESULTL_H,W
	movwf	SysLONGTempA_H
	movf	RESULTL_U,W
	movwf	SysLONGTempA_U
	movf	RESULTL_E,W
	movwf	SysLONGTempA_E
	clrf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SysCompEqual32
	call	SysCompEqual32
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF46
;Show_ValuesSubL(Operate1L)
	movf	OPERATE1L,W
	movwf	D_VALUEL
	movf	OPERATE1L_H,W
	movwf	D_VALUEL_H
	movf	OPERATE1L_U,W
	movwf	D_VALUEL_U
	movf	OPERATE1L_E,W
	movwf	D_VALUEL_E
	call	SHOW_VALUESSUBL
;End If
ENDIF46
;End If
ENDIF42
;End If
ENDIF38
;If ResultL > 0 Then
	banksel	RESULTL
	movf	RESULTL,W
	movwf	SysLONGTempB
	movf	RESULTL_H,W
	movwf	SysLONGTempB_H
	movf	RESULTL_U,W
	movwf	SysLONGTempB_U
	movf	RESULTL_E,W
	movwf	SysLONGTempB_E
	clrf	SysLONGTempA
	clrf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	banksel	STATUS
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	btfss	SysByteTempX,0
	goto	ELSE39_1
;Show_ValuesSubL(ResultL)
	banksel	RESULTL
	movf	RESULTL,W
	banksel	D_VALUEL
	movwf	D_VALUEL
	banksel	RESULTL_H
	movf	RESULTL_H,W
	banksel	D_VALUEL_H
	movwf	D_VALUEL_H
	banksel	RESULTL_U
	movf	RESULTL_U,W
	banksel	D_VALUEL_U
	movwf	D_VALUEL_U
	banksel	RESULTL_E
	movf	RESULTL_E,W
	banksel	D_VALUEL_E
	movwf	D_VALUEL_E
	call	SHOW_VALUESSUBL
;Locate 0,11
	clrf	LCDLINE
	movlw	11
	movwf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;Print "Ans"
	movlw	low StringTable3
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable3) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Else
	goto	ENDIF39
ELSE39_1
;If Operand = Answer Then
	movlw	29
	subwf	OPERAND,W
	btfss	STATUS, Z
	goto	ELSE43_1
;Show_ValuesSubL(ResultL)
	banksel	RESULTL
	movf	RESULTL,W
	banksel	D_VALUEL
	movwf	D_VALUEL
	banksel	RESULTL_H
	movf	RESULTL_H,W
	banksel	D_VALUEL_H
	movwf	D_VALUEL_H
	banksel	RESULTL_U
	movf	RESULTL_U,W
	banksel	D_VALUEL_U
	movwf	D_VALUEL_U
	banksel	RESULTL_E
	movf	RESULTL_E,W
	banksel	D_VALUEL_E
	movwf	D_VALUEL_E
	call	SHOW_VALUESSUBL
;Locate 0,11
	clrf	LCDLINE
	movlw	11
	movwf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;Print "Ans"
	movlw	low StringTable3
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable3) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Else
	goto	ENDIF43
ELSE43_1
;Locate 0,11
	clrf	LCDLINE
	movlw	11
	movwf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;Print "   "
	movlw	low StringTable5
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable5) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;End If
ENDIF43
;End If
ENDIF39
;Do
SysDoLoop_S3
;Wait 50 mS
	movlw	50
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
;Get_Buttons
	pagesel	GET_BUTTONS
	call	GET_BUTTONS
	pagesel	$
;Loop Until Button_Value = 255
	incf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	SysDoLoop_S3
SysDoLoop_E3
;End If
ENDIF30
	return

;********************************************************************************

SETPORTDIR
;Port directions
;Dir     Button_R1     Out
	banksel	TRISC
	bcf	TRISC,3
;Dir     Button_R2     Out
	bcf	TRISC,6
;Dir     Button_R3     Out
	bcf	TRISC,7
;Dir     LCD_RS        Out
	bcf	TRISA,0
;Dir     LCD_Enable    Out
	bcf	TRISA,1
;Dir     LCD_DB4       Out
	bcf	TRISA,2
;Dir     LCD_DB5       Out
	bcf	TRISC,0
;Dir     LCD_DB6       Out
	bcf	TRISC,1
;Dir     LCD_DB7       Out
	bcf	TRISC,2
;Dir     D_Clk         Out
	bcf	TRISC,5
;Dir     D_Data        In
	bsf	TRISA,4
;Dir     D_Lat         Out
	bcf	TRISC,4
	banksel	STATUS
	return

;********************************************************************************

SHOW_BUTTON
;If Bit_Mode <> Bit_32 Then
	movlw	2
	subwf	BIT_MODE,W
	btfsc	STATUS, Z
	goto	ELSE116_1
;Locate 1,8
	movlw	1
	movwf	LCDLINE
	movlw	8
	movwf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;Else
	goto	ENDIF116
ELSE116_1
;Locate 0,15
	clrf	LCDLINE
	movlw	15
	movwf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;End If
ENDIF116
;If Button_Value < 255 Then
	movlw	255
	subwf	BUTTON_VALUE,W
	btfsc	STATUS, C
	goto	ELSE117_1
;Select Case Button_Value
;Case Bt0
SysSelect5Case1
	movf	BUTTON_VALUE,F
	btfss	STATUS, Z
	goto	SysSelect5Case2
;Print "0"
	movlw	low StringTable8
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable8) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Case Bt1
	goto	SysSelectEnd5
SysSelect5Case2
	decf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect5Case3
;Print "1"
	movlw	low StringTable22
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable22) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Case Bt2
	goto	SysSelectEnd5
SysSelect5Case3
	movlw	2
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect5Case4
;Print "2"
	movlw	low StringTable23
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable23) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Case Bt3
	goto	SysSelectEnd5
SysSelect5Case4
	movlw	3
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect5Case5
;Print "3"
	movlw	low StringTable24
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable24) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Case Bt4
	goto	SysSelectEnd5
SysSelect5Case5
	movlw	4
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect5Case6
;Print "4"
	movlw	low StringTable25
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable25) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Case Bt5
	goto	SysSelectEnd5
SysSelect5Case6
	movlw	5
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect5Case7
;Print "5"
	movlw	low StringTable26
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable26) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Case Bt6
	goto	SysSelectEnd5
SysSelect5Case7
	movlw	6
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect5Case8
;Print "6"
	movlw	low StringTable27
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable27) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Case Bt7
	goto	SysSelectEnd5
SysSelect5Case8
	movlw	7
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect5Case9
;Print "7"
	movlw	low StringTable28
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable28) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Case Bt8
	goto	SysSelectEnd5
SysSelect5Case9
	movlw	8
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect5Case10
;Print "8"
	movlw	low StringTable29
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable29) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Case Bt9
	goto	SysSelectEnd5
SysSelect5Case10
	movlw	9
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect5Case11
;Print "9"
	movlw	low StringTable30
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable30) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Case BtA
	goto	SysSelectEnd5
SysSelect5Case11
	movlw	10
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect5Case12
;Print "A"
	movlw	low StringTable31
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable31) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Case BtB
	goto	SysSelectEnd5
SysSelect5Case12
	movlw	11
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect5Case13
;Print "B"
	movlw	low StringTable32
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable32) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Case BtC
	goto	SysSelectEnd5
SysSelect5Case13
	movlw	12
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect5Case14
;Print "C"
	movlw	low StringTable33
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable33) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Case BtD
	goto	SysSelectEnd5
SysSelect5Case14
	movlw	13
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect5Case15
;Print "D"
	movlw	low StringTable34
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable34) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Case BtE
	goto	SysSelectEnd5
SysSelect5Case15
	movlw	14
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect5Case16
;Print "E"
	movlw	low StringTable35
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable35) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Case BtF
	goto	SysSelectEnd5
SysSelect5Case16
	movlw	15
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect5Case17
;Print "F"
	movlw	low StringTable36
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable36) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Case BtEn
	goto	SysSelectEnd5
SysSelect5Case17
	movlw	16
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect5Case18
;Print "="
	movlw	low StringTable37
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable37) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Case BtPl
	goto	SysSelectEnd5
SysSelect5Case18
	movlw	17
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect5Case19
;Print "+"
	movlw	low StringTable38
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable38) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Case BtMi
	goto	SysSelectEnd5
SysSelect5Case19
	movlw	18
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect5Case20
;Print "-"
	movlw	low StringTable39
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable39) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Case BtDi
	goto	SysSelectEnd5
SysSelect5Case20
	movlw	19
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect5Case21
;Print "/"
	movlw	low StringTable40
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable40) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Case BtMu
	goto	SysSelectEnd5
SysSelect5Case21
	movlw	20
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect5Case22
;Print "x"
	movlw	low StringTable41
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable41) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Case BtAn
	goto	SysSelectEnd5
SysSelect5Case22
	movlw	21
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect5Case23
;Print "&"
	movlw	low StringTable42
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable42) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Case BtModulo
	goto	SysSelectEnd5
SysSelect5Case23
	movlw	22
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect5Case24
;Print "%"
	movlw	low StringTable43
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable43) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Case BtOr
	goto	SysSelectEnd5
SysSelect5Case24
	movlw	23
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect5Case25
;LCDWriteChar CG_Or  'Print Or symbol
	clrf	LCDCHAR
	pagesel	LCDWRITECHAR
	call	LCDWRITECHAR
	pagesel	$
;'Print "|"
;Case BTXor
	goto	SysSelectEnd5
SysSelect5Case25
	movlw	24
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect5Case26
;LCDWriteChar CG_Xor 'Print Xor symbol
	movlw	1
	movwf	LCDCHAR
	pagesel	LCDWRITECHAR
	call	LCDWRITECHAR
	pagesel	$
;'Print "#"
;Case BtMode
	goto	SysSelectEnd5
SysSelect5Case26
	movlw	27
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect5Case27
;Print "m"
	movlw	low StringTable44
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable44) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Case BtClr
	goto	SysSelectEnd5
SysSelect5Case27
	movlw	26
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect5Case28
;Print "c"
	movlw	low StringTable45
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable45) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Case BtNot
	goto	SysSelectEnd5
SysSelect5Case28
	movlw	25
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect5Case29
;LCDWriteChar CG_Not 'Print Not symbol
	movlw	2
	movwf	LCDCHAR
	pagesel	LCDWRITECHAR
	call	LCDWRITECHAR
	pagesel	$
;Case BtRand
	goto	SysSelectEnd5
SysSelect5Case29
	movlw	26
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	SysSelectEnd5
;Print "R"
	movlw	low StringTable46
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable46) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;End Select
SysSelectEnd5
;Else
	goto	ENDIF117
ELSE117_1
;Print " "
	movlw	low StringTable4
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable4) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;End If
ENDIF117
	return

;********************************************************************************

SHOW_VALUESSUBL
;Let Display_ValueL = D_ValueL
	movf	D_VALUEL,W
	movwf	DISPLAY_VALUEL
	movf	D_VALUEL_H,W
	movwf	DISPLAY_VALUEL_H
	movf	D_VALUEL_U,W
	movwf	DISPLAY_VALUEL_U
	movf	D_VALUEL_E,W
	movwf	DISPLAY_VALUEL_E
;Let DisplayHiL = Display_ValueL_E
	movwf	DISPLAYHIL
;Let DisplayLoL = Display_ValueL_U
	movf	DISPLAY_VALUEL_U,W
	movwf	DISPLAYLOL
;Let DisplayHi  = Display_ValueL_H
	movf	DISPLAY_VALUEL_H,W
	movwf	DISPLAYHI
;Let DisplayLo  = Display_ValueL
	movf	DISPLAY_VALUEL,W
	movwf	DISPLAYLO
;Locate 0,0
	clrf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;Print "h"
	movlw	low StringTable6
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable6) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;LCDHex DisplayHiL, LeadingZeroActive
	movf	DISPLAYHIL,W
	movwf	LCDVALUE
	movlw	2
	movwf	LCDCHAR
	pagesel	LCDHEX
	call	LCDHEX
	pagesel	$
;LCDHex DisplayLoL, LeadingZeroActive
	movf	DISPLAYLOL,W
	movwf	LCDVALUE
	movlw	2
	movwf	LCDCHAR
	pagesel	LCDHEX
	call	LCDHEX
	pagesel	$
;LCDHex DisplayHi , LeadingZeroActive
	movf	DISPLAYHI,W
	movwf	LCDVALUE
	movlw	2
	movwf	LCDCHAR
	pagesel	LCDHEX
	call	LCDHEX
	pagesel	$
;LCDHex DisplayLo , LeadingZeroActive
	movf	DISPLAYLO,W
	movwf	LCDVALUE
	movlw	2
	movwf	LCDCHAR
	pagesel	LCDHEX
	call	LCDHEX
	pagesel	$
;Show_Mode
	pagesel	SHOW_MODE
	call	SHOW_MODE
	pagesel	$
;Show_Button
	call	SHOW_BUTTON
;Locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;Print "d"
	movlw	low StringTable7
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable7) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;If Display_ValueL < 1000000000 Then
	movf	DISPLAY_VALUEL,W
	movwf	SysLONGTempA
	movf	DISPLAY_VALUEL_H,W
	movwf	SysLONGTempA_H
	movf	DISPLAY_VALUEL_U,W
	movwf	SysLONGTempA_U
	movf	DISPLAY_VALUEL_E,W
	movwf	SysLONGTempA_E
	clrf	SysLONGTempB
	movlw	202
	movwf	SysLONGTempB_H
	movlw	154
	movwf	SysLONGTempB_U
	movlw	59
	movwf	SysLONGTempB_E
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF98
;Print "0"
	movlw	low StringTable8
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable8) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;End If
ENDIF98
;If Display_ValueL < 100000000  Then
	movf	DISPLAY_VALUEL,W
	movwf	SysLONGTempA
	movf	DISPLAY_VALUEL_H,W
	movwf	SysLONGTempA_H
	movf	DISPLAY_VALUEL_U,W
	movwf	SysLONGTempA_U
	movf	DISPLAY_VALUEL_E,W
	movwf	SysLONGTempA_E
	clrf	SysLONGTempB
	movlw	225
	movwf	SysLONGTempB_H
	movlw	245
	movwf	SysLONGTempB_U
	movlw	5
	movwf	SysLONGTempB_E
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF99
;Print "0"
	movlw	low StringTable8
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable8) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;End If
ENDIF99
;If Display_ValueL < 10000000   Then
	movf	DISPLAY_VALUEL,W
	movwf	SysLONGTempA
	movf	DISPLAY_VALUEL_H,W
	movwf	SysLONGTempA_H
	movf	DISPLAY_VALUEL_U,W
	movwf	SysLONGTempA_U
	movf	DISPLAY_VALUEL_E,W
	movwf	SysLONGTempA_E
	movlw	128
	movwf	SysLONGTempB
	movlw	150
	movwf	SysLONGTempB_H
	movlw	152
	movwf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF100
;Print "0"
	movlw	low StringTable8
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable8) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;End If
ENDIF100
;If Display_ValueL < 1000000    Then
	movf	DISPLAY_VALUEL,W
	movwf	SysLONGTempA
	movf	DISPLAY_VALUEL_H,W
	movwf	SysLONGTempA_H
	movf	DISPLAY_VALUEL_U,W
	movwf	SysLONGTempA_U
	movf	DISPLAY_VALUEL_E,W
	movwf	SysLONGTempA_E
	movlw	64
	movwf	SysLONGTempB
	movlw	66
	movwf	SysLONGTempB_H
	movlw	15
	movwf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF101
;Print "0"
	movlw	low StringTable8
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable8) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;End If
ENDIF101
;If Display_ValueL < 100000     Then
	movf	DISPLAY_VALUEL,W
	movwf	SysLONGTempA
	movf	DISPLAY_VALUEL_H,W
	movwf	SysLONGTempA_H
	movf	DISPLAY_VALUEL_U,W
	movwf	SysLONGTempA_U
	movf	DISPLAY_VALUEL_E,W
	movwf	SysLONGTempA_E
	movlw	160
	movwf	SysLONGTempB
	movlw	134
	movwf	SysLONGTempB_H
	movlw	1
	movwf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF102
;Print "0"
	movlw	low StringTable8
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable8) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;End If
ENDIF102
;If Display_ValueL < 10000      Then
	movf	DISPLAY_VALUEL,W
	movwf	SysLONGTempA
	movf	DISPLAY_VALUEL_H,W
	movwf	SysLONGTempA_H
	movf	DISPLAY_VALUEL_U,W
	movwf	SysLONGTempA_U
	movf	DISPLAY_VALUEL_E,W
	movwf	SysLONGTempA_E
	movlw	16
	movwf	SysLONGTempB
	movlw	39
	movwf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF103
;Print "0"
	movlw	low StringTable8
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable8) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;End If
ENDIF103
;If Display_ValueL < 1000       Then
	movf	DISPLAY_VALUEL,W
	movwf	SysLONGTempA
	movf	DISPLAY_VALUEL_H,W
	movwf	SysLONGTempA_H
	movf	DISPLAY_VALUEL_U,W
	movwf	SysLONGTempA_U
	movf	DISPLAY_VALUEL_E,W
	movwf	SysLONGTempA_E
	movlw	232
	movwf	SysLONGTempB
	movlw	3
	movwf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF104
;Print "0"
	movlw	low StringTable8
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable8) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;End If
ENDIF104
;If Display_ValueL < 100        Then
	movf	DISPLAY_VALUEL,W
	movwf	SysLONGTempA
	movf	DISPLAY_VALUEL_H,W
	movwf	SysLONGTempA_H
	movf	DISPLAY_VALUEL_U,W
	movwf	SysLONGTempA_U
	movf	DISPLAY_VALUEL_E,W
	movwf	SysLONGTempA_E
	movlw	100
	movwf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF105
;Print "0"
	movlw	low StringTable8
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable8) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;End If
ENDIF105
;If Display_ValueL < 10         Then
	movf	DISPLAY_VALUEL,W
	movwf	SysLONGTempA
	movf	DISPLAY_VALUEL_H,W
	movwf	SysLONGTempA_H
	movf	DISPLAY_VALUEL_U,W
	movwf	SysLONGTempA_U
	movf	DISPLAY_VALUEL_E,W
	movwf	SysLONGTempA_E
	movlw	10
	movwf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF106
;Print "0"
	movlw	low StringTable8
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable8) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;End If
ENDIF106
;Print Display_ValueL
	movf	DISPLAY_VALUEL,W
	movwf	LCDVALUE
	movf	DISPLAY_VALUEL_H,W
	movwf	LCDVALUE_H
	movf	DISPLAY_VALUEL_U,W
	movwf	LCDVALUE_U
	movf	DISPLAY_VALUEL_E,W
	movwf	LCDVALUE_E
	pagesel	PRINT148
	call	PRINT148
	pagesel	$
;If Result > 0 Then
	banksel	RESULT
	movf	RESULT,W
	movwf	SysWORDTempB
	movf	RESULT_H,W
	movwf	SysWORDTempB_H
	clrf	SysWORDTempA
	clrf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF107
;Wait 500 mS 'Ensures Mode and Button are displayed briefly'
	movlw	244
	movwf	SysWaitTempMS
	movlw	1
	movwf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;End If
ENDIF107
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

StringTable2
	retlw	13
	retlw	51	;3
	retlw	46	;.
	retlw	49	;1
	retlw	52	;4
	retlw	32	; 
	retlw	49	;1
	retlw	53	;5
	retlw	116	;t
	retlw	104	;h
	retlw	32	; 
	retlw	77	;M
	retlw	97	;a
	retlw	114	;r


StringTable3
	retlw	3
	retlw	65	;A
	retlw	110	;n
	retlw	115	;s


StringTable4
	retlw	1
	retlw	32	; 


StringTable5
	retlw	3
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 


StringTable6
	retlw	1
	retlw	104	;h


StringTable7
	retlw	1
	retlw	100	;d


StringTable8
	retlw	1
	retlw	48	;0


StringTable9
	retlw	1
	retlw	42	;*


StringTable10
	retlw	1
	retlw	94	;^


StringTable11
	retlw	1
	retlw	97	;a


StringTable12
	retlw	15
	retlw	49	;1
	retlw	54	;6
	retlw	98	;b
	retlw	105	;i
	retlw	116	;t
	retlw	32	; 
	retlw	66	;B
	retlw	105	;i
	retlw	110	;n
	retlw	32	; 
	retlw	45	;-
	retlw	32	; 
	retlw	68	;D
	retlw	101	;e
	retlw	99	;c


StringTable13
	retlw	15
	retlw	32	; 
	retlw	51	;3
	retlw	50	;2
	retlw	98	;b
	retlw	105	;i
	retlw	116	;t
	retlw	32	; 
	retlw	32	; 
	retlw	68	;D
	retlw	101	;e
	retlw	99	;c
	retlw	105	;i
	retlw	109	;m
	retlw	97	;a
	retlw	108	;l


StringTable14
	retlw	15
	retlw	32	; 
	retlw	45	;-
	retlw	32	; 
	retlw	72	;H
	retlw	101	;e
	retlw	120	;x
	retlw	97	;a
	retlw	100	;d
	retlw	101	;e
	retlw	99	;c
	retlw	105	;i
	retlw	109	;m
	retlw	97	;a
	retlw	108	;l
	retlw	32	; 


StringTable15
	retlw	16
	retlw	32	; 
	retlw	42	;*
	retlw	73	;I
	retlw	110	;n
	retlw	116	;t
	retlw	101	;e
	retlw	103	;g
	retlw	101	;e
	retlw	114	;r
	retlw	32	; 
	retlw	111	;o
	retlw	110	;n
	retlw	108	;l
	retlw	121	;y
	retlw	42	;*
	retlw	32	; 


StringTable16
	retlw	16
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 
	retlw	67	;C
	retlw	97	;a
	retlw	108	;l
	retlw	99	;c
	retlw	117	;u
	retlw	108	;l
	retlw	97	;a
	retlw	116	;t
	retlw	111	;o
	retlw	114	;r
	retlw	32	; 
	retlw	32	; 
	retlw	32	; 


StringTable17
	retlw	3
	retlw	118	;v
	retlw	58	;:
	retlw	32	; 


StringTable18
	retlw	1
	retlw	44	;,


StringTable19
	retlw	3
	retlw	77	;M
	retlw	104	;h
	retlw	122	;z


StringTable20
	retlw	16
	retlw	32	; 
	retlw	40	;(
	retlw	67	;C
	retlw	41	;)
	retlw	32	; 
	retlw	77	;M
	retlw	107	;k
	retlw	69	;E
	retlw	68	;D
	retlw	83	;S
	retlw	32	; 
	retlw	50	;2
	retlw	48	;0
	retlw	49	;1
	retlw	56	;8
	retlw	32	; 


StringTable21
	retlw	1
	retlw	98	;b


StringTable22
	retlw	1
	retlw	49	;1


StringTable23
	retlw	1
	retlw	50	;2


StringTable24
	retlw	1
	retlw	51	;3


StringTable25
	retlw	1
	retlw	52	;4


StringTable26
	retlw	1
	retlw	53	;5


StringTable27
	retlw	1
	retlw	54	;6


StringTable28
	retlw	1
	retlw	55	;7


StringTable29
	retlw	1
	retlw	56	;8


StringTable30
	retlw	1
	retlw	57	;9


StringTable31
	retlw	1
	retlw	65	;A


StringTable32
	retlw	1
	retlw	66	;B


StringTable33
	retlw	1
	retlw	67	;C


StringTable34
	retlw	1
	retlw	68	;D


StringTable35
	retlw	1
	retlw	69	;E


StringTable36
	retlw	1
	retlw	70	;F


StringTable37
	retlw	1
	retlw	61	; (equals)


StringTable38
	retlw	1
	retlw	43	;+


StringTable39
	retlw	1
	retlw	45	;-


StringTable40
	retlw	1
	retlw	47	;/


StringTable41
	retlw	1
	retlw	120	;x


StringTable42
	retlw	1
	retlw	38	;&


StringTable43
	retlw	1
	retlw	37	;%


StringTable44
	retlw	1
	retlw	109	;m


StringTable45
	retlw	1
	retlw	99	;c


StringTable46
	retlw	1
	retlw	82	;R


StringTable47
	retlw	4
	retlw	49	;1
	retlw	46	;.
	retlw	48	;0
	retlw	48	;0


StringTable89
	retlw	7
	retlw	49	;1
	retlw	54	;6
	retlw	70	;F
	retlw	49	;1
	retlw	56	;8
	retlw	50	;2
	retlw	57	;9


;********************************************************************************

;Start of program memory page 1
	ORG	2048
BUILD_VALUEL
;If Input_Value = BtClr Then
	movf	INPUT_VALUE,W
	movwf	SysWORDTempA
	movf	INPUT_VALUE_H,W
	movwf	SysWORDTempA_H
	movlw	26
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF67
;Let Operate1L    = 0
	clrf	OPERATE1L
	clrf	OPERATE1L_H
	clrf	OPERATE1L_U
	clrf	OPERATE1L_E
;Let Operate2L    = 0
	banksel	OPERATE2L
	clrf	OPERATE2L
	clrf	OPERATE2L_H
	clrf	OPERATE2L_U
	clrf	OPERATE2L_E
;Let Operand      = 0
	banksel	OPERAND
	clrf	OPERAND
;Let Op           = 1
	movlw	1
	movwf	OP
;Let ResultL      = 0
	banksel	RESULTL
	clrf	RESULTL
	clrf	RESULTL_H
	clrf	RESULTL_U
	clrf	RESULTL_E
;Let Built_ValueL = 0
	banksel	BUILT_VALUEL
	clrf	BUILT_VALUEL
	clrf	BUILT_VALUEL_H
	clrf	BUILT_VALUEL_U
	clrf	BUILT_VALUEL_E
;Exit Sub
	return
;End If
ENDIF67
;If Input_Value = BtEn Then 'Enter pressed, do maths'
	movf	INPUT_VALUE,W
	movwf	SysWORDTempA
	movf	INPUT_VALUE_H,W
	movwf	SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF68
;Do_Maths
	pagesel	DO_MATHS
	call	DO_MATHS
	pagesel	$
;End If
ENDIF68
;If Input_Value > BtEn Then 'Operand is Pressed'
	movf	INPUT_VALUE,W
	movwf	SysWORDTempB
	movf	INPUT_VALUE_H,W
	movwf	SysWORDTempB_H
	movlw	16
	movwf	SysWORDTempA
	clrf	SysWORDTempA_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF69
;If Input_Value < 24 Then 'Mode or Clr are not Pressed'
	movf	INPUT_VALUE,W
	movwf	SysWORDTempA
	movf	INPUT_VALUE_H,W
	movwf	SysWORDTempA_H
	movlw	24
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF73
;If ResultL > 0 Then
	banksel	RESULTL
	movf	RESULTL,W
	movwf	SysLONGTempB
	movf	RESULTL_H,W
	movwf	SysLONGTempB_H
	movf	RESULTL_U,W
	movwf	SysLONGTempB_U
	movf	RESULTL_E,W
	movwf	SysLONGTempB_E
	clrf	SysLONGTempA
	clrf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	banksel	STATUS
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	btfss	SysByteTempX,0
	goto	ELSE74_1
;Let Operate1L = ResultL
	banksel	RESULTL
	movf	RESULTL,W
	banksel	OPERATE1L
	movwf	OPERATE1L
	banksel	RESULTL_H
	movf	RESULTL_H,W
	banksel	OPERATE1L_H
	movwf	OPERATE1L_H
	banksel	RESULTL_U
	movf	RESULTL_U,W
	banksel	OPERATE1L_U
	movwf	OPERATE1L_U
	banksel	RESULTL_E
	movf	RESULTL_E,W
	banksel	OPERATE1L_E
	movwf	OPERATE1L_E
;Let Operate2L = 0
	banksel	OPERATE2L
	clrf	OPERATE2L
	clrf	OPERATE2L_H
	clrf	OPERATE2L_U
	clrf	OPERATE2L_E
;Let ResultL   = 0
	clrf	RESULTL
	clrf	RESULTL_H
	clrf	RESULTL_U
	clrf	RESULTL_E
;Let Op        = 2
	movlw	2
	banksel	OP
	movwf	OP
;Let Operand   = Input_Value
	movf	INPUT_VALUE,W
	movwf	OPERAND
;Else
	goto	ENDIF74
ELSE74_1
;If Operate1L > 0 Then
;If Op = 2 Then
	movlw	2
	subwf	OP,W
	btfss	STATUS, Z
	goto	ENDIF75
;Let Operate2L = 0
	banksel	OPERATE2L
	clrf	OPERATE2L
	clrf	OPERATE2L_H
	clrf	OPERATE2L_U
	clrf	OPERATE2L_E
;Let ResultL   = 0
	clrf	RESULTL
	clrf	RESULTL_H
	clrf	RESULTL_U
	clrf	RESULTL_E
;End If
ENDIF75
;If Op = 1 Then
	banksel	OP
	decf	OP,W
	btfss	STATUS, Z
	goto	ENDIF76
;Let Op = 2
	movlw	2
	movwf	OP
;End If
ENDIF76
;Let Operand = Input_Value
	movf	INPUT_VALUE,W
	movwf	OPERAND
;Exit Sub
	return
;Else
;Exit Sub
;End If
;End If
ENDIF74
;Exit Sub
	return
;End If
ENDIF73
;End If
ENDIF69
;If Input_Value < BtEn Then 'Number pressed'
	movf	INPUT_VALUE,W
	movwf	SysWORDTempA
	movf	INPUT_VALUE_H,W
	movwf	SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
;Do_NumberL
	call	DO_NUMBERL
;End If
ENDIF70
;If Input_Value = BtNot Then
	movf	INPUT_VALUE,W
	movwf	SysWORDTempA
	movf	INPUT_VALUE_H,W
	movwf	SysWORDTempA_H
	movlw	25
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF71
;Do_NotL
	pagesel	DO_NOTL
	call	DO_NOTL
	pagesel	$
;End If
ENDIF71
;If Input_Value = BtRand Then
	movf	INPUT_VALUE,W
	movwf	SysWORDTempA
	movf	INPUT_VALUE_H,W
	movwf	SysWORDTempA_H
	movlw	26
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfsc	SysByteTempX,0
;Do_RandL
	call	DO_RANDL
;End If
ENDIF72
	return

;********************************************************************************

DO_MATHSL
;If Bit_Mode < Bit_32 Then
	movlw	2
	subwf	BIT_MODE,W
	btfsc	STATUS, C
	goto	ENDIF194
;Do_Maths
	pagesel	DO_MATHS
	call	DO_MATHS
	pagesel	$
;Exit Sub
	return
;End If
ENDIF194
;Wait 500 mS
	movlw	244
	movwf	SysWaitTempMS
	movlw	1
	movwf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;If Operate1L > 0 Then
;If Operate2L > 0 Then
;If Operand > 0 Then
	movf	OPERAND,W
	sublw	0
	btfsc	STATUS, C
	goto	ENDIF195
;If Operand = BtPl Then
	movlw	17
	subwf	OPERAND,W
	btfss	STATUS, Z
	goto	ENDIF196
;Let ResultL = Operate1L + Operate2L
	banksel	OPERATE2L
	movf	OPERATE2L,W
	banksel	OPERATE1L
	addwf	OPERATE1L,W
	banksel	RESULTL
	movwf	RESULTL
	movf	OPERATE2L_H,W
	banksel	OPERATE1L_H
	addwfc	OPERATE1L_H,W
	banksel	RESULTL_H
	movwf	RESULTL_H
	movf	OPERATE2L_U,W
	banksel	OPERATE1L_U
	addwfc	OPERATE1L_U,W
	banksel	RESULTL_U
	movwf	RESULTL_U
	movf	OPERATE2L_E,W
	banksel	OPERATE1L_E
	addwfc	OPERATE1L_E,W
	banksel	RESULTL_E
	movwf	RESULTL_E
;End If
ENDIF196
;If Operand = BtMi Then
	movlw	18
	banksel	OPERAND
	subwf	OPERAND,W
	btfss	STATUS, Z
	goto	ENDIF197
;Let ResultL = Operate1L - Operate2L
	banksel	OPERATE2L
	movf	OPERATE2L,W
	banksel	OPERATE1L
	subwf	OPERATE1L,W
	banksel	RESULTL
	movwf	RESULTL
	movf	OPERATE2L_H,W
	banksel	OPERATE1L_H
	subwfb	OPERATE1L_H,W
	banksel	RESULTL_H
	movwf	RESULTL_H
	movf	OPERATE2L_U,W
	banksel	OPERATE1L_U
	subwfb	OPERATE1L_U,W
	banksel	RESULTL_U
	movwf	RESULTL_U
	movf	OPERATE2L_E,W
	banksel	OPERATE1L_E
	subwfb	OPERATE1L_E,W
	banksel	RESULTL_E
	movwf	RESULTL_E
;End If
ENDIF197
;If Operand = BtDi Then
	movlw	19
	banksel	OPERAND
	subwf	OPERAND,W
	btfss	STATUS, Z
	goto	ENDIF198
;If Operate1L >= Operate2L Then
;Let ResultL = Operate1L / Operate2L
	movf	OPERATE1L,W
	movwf	SysLONGTempA
	movf	OPERATE1L_H,W
	movwf	SysLONGTempA_H
	movf	OPERATE1L_U,W
	movwf	SysLONGTempA_U
	movf	OPERATE1L_E,W
	movwf	SysLONGTempA_E
	banksel	OPERATE2L
	movf	OPERATE2L,W
	movwf	SysLONGTempB
	movf	OPERATE2L_H,W
	movwf	SysLONGTempB_H
	movf	OPERATE2L_U,W
	movwf	SysLONGTempB_U
	movf	OPERATE2L_E,W
	movwf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SysDivSub32
	call	SysDivSub32
	pagesel	$
	movf	SysLONGTempA,W
	banksel	RESULTL
	movwf	RESULTL
	movf	SysLONGTempA_H,W
	movwf	RESULTL_H
	movf	SysLONGTempA_U,W
	movwf	RESULTL_U
	movf	SysLONGTempA_E,W
	movwf	RESULTL_E
;Else   'Division equals zero
;Let ResultL   = 0
;End If
;End If
ENDIF198
;If Operand = BtMu Then
	movlw	20
	banksel	OPERAND
	subwf	OPERAND,W
	btfss	STATUS, Z
	goto	ENDIF199
;Let ResultL = Operate1L * Operate2L
	movf	OPERATE1L,W
	movwf	SysLONGTempA
	movf	OPERATE1L_H,W
	movwf	SysLONGTempA_H
	movf	OPERATE1L_U,W
	movwf	SysLONGTempA_U
	movf	OPERATE1L_E,W
	movwf	SysLONGTempA_E
	banksel	OPERATE2L
	movf	OPERATE2L,W
	movwf	SysLONGTempB
	movf	OPERATE2L_H,W
	movwf	SysLONGTempB_H
	movf	OPERATE2L_U,W
	movwf	SysLONGTempB_U
	movf	OPERATE2L_E,W
	movwf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SysMultSub32
	call	SysMultSub32
	pagesel	$
	movf	SysLONGTempX,W
	banksel	RESULTL
	movwf	RESULTL
	movf	SysLONGTempX_H,W
	movwf	RESULTL_H
	movf	SysLONGTempX_U,W
	movwf	RESULTL_U
	movf	SysLONGTempX_E,W
	movwf	RESULTL_E
;End If
ENDIF199
;If Operand = BtAn Then
	movlw	21
	banksel	OPERAND
	subwf	OPERAND,W
	btfss	STATUS, Z
	goto	ENDIF200
;Let ResultL = Operate1L And Operate2L
	movf	OPERATE1L,W
	banksel	OPERATE2L
	andwf	OPERATE2L,W
	movwf	RESULTL
	banksel	OPERATE1L_H
	movf	OPERATE1L_H,W
	banksel	OPERATE2L_H
	andwf	OPERATE2L_H,W
	movwf	RESULTL_H
	banksel	OPERATE1L_U
	movf	OPERATE1L_U,W
	banksel	OPERATE2L_U
	andwf	OPERATE2L_U,W
	movwf	RESULTL_U
	banksel	OPERATE1L_E
	movf	OPERATE1L_E,W
	banksel	OPERATE2L_E
	andwf	OPERATE2L_E,W
	movwf	RESULTL_E
;End If
ENDIF200
;If Operand = BtOr Then
	movlw	23
	banksel	OPERAND
	subwf	OPERAND,W
	btfss	STATUS, Z
	goto	ENDIF201
;Let ResultL = Operate1L Or Operate2L
	movf	OPERATE1L,W
	banksel	OPERATE2L
	iorwf	OPERATE2L,W
	movwf	RESULTL
	banksel	OPERATE1L_H
	movf	OPERATE1L_H,W
	banksel	OPERATE2L_H
	iorwf	OPERATE2L_H,W
	movwf	RESULTL_H
	banksel	OPERATE1L_U
	movf	OPERATE1L_U,W
	banksel	OPERATE2L_U
	iorwf	OPERATE2L_U,W
	movwf	RESULTL_U
	banksel	OPERATE1L_E
	movf	OPERATE1L_E,W
	banksel	OPERATE2L_E
	iorwf	OPERATE2L_E,W
	movwf	RESULTL_E
;End If
ENDIF201
;If Operand = BtXor Then
	movlw	24
	banksel	OPERAND
	subwf	OPERAND,W
	btfss	STATUS, Z
	goto	ENDIF202
;Let ResultL = Operate1L # Operate2L
	movf	OPERATE1L,W
	banksel	OPERATE2L
	xorwf	OPERATE2L,W
	movwf	RESULTL
	banksel	OPERATE1L_H
	movf	OPERATE1L_H,W
	banksel	OPERATE2L_H
	xorwf	OPERATE2L_H,W
	movwf	RESULTL_H
	banksel	OPERATE1L_U
	movf	OPERATE1L_U,W
	banksel	OPERATE2L_U
	xorwf	OPERATE2L_U,W
	movwf	RESULTL_U
	banksel	OPERATE1L_E
	movf	OPERATE1L_E,W
	banksel	OPERATE2L_E
	xorwf	OPERATE2L_E,W
	movwf	RESULTL_E
;End If
ENDIF202
;If Operand = BtModulo Then
	movlw	22
	banksel	OPERAND
	subwf	OPERAND,W
	btfss	STATUS, Z
	goto	ENDIF203
;Let ResultL = Operate1L % Operate2l
	movf	OPERATE1L,W
	movwf	SysLONGTempA
	movf	OPERATE1L_H,W
	movwf	SysLONGTempA_H
	movf	OPERATE1L_U,W
	movwf	SysLONGTempA_U
	movf	OPERATE1L_E,W
	movwf	SysLONGTempA_E
	banksel	OPERATE2L
	movf	OPERATE2L,W
	movwf	SysLONGTempB
	movf	OPERATE2L_H,W
	movwf	SysLONGTempB_H
	movf	OPERATE2L_U,W
	movwf	SysLONGTempB_U
	movf	OPERATE2L_E,W
	movwf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SysDivSub32
	call	SysDivSub32
	pagesel	$
	movf	SysLONGTempX,W
	banksel	RESULTL
	movwf	RESULTL
	movf	SysLONGTempX_H,W
	movwf	RESULTL_H
	movf	SysLONGTempX_U,W
	movwf	RESULTL_U
	movf	SysLONGTempX_E,W
	movwf	RESULTL_E
;End If
ENDIF203
;If ResultL = 0 Then 'Clear ready for new calculation'
	banksel	RESULTL
	movf	RESULTL,W
	movwf	SysLONGTempA
	movf	RESULTL_H,W
	movwf	SysLONGTempA_H
	movf	RESULTL_U,W
	movwf	SysLONGTempA_U
	movf	RESULTL_E,W
	movwf	SysLONGTempA_E
	clrf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SysCompEqual32
	call	SysCompEqual32
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF204
;Let Op        = 1
	movlw	1
	movwf	OP
;Let Operate1L = 0
	clrf	OPERATE1L
	clrf	OPERATE1L_H
	clrf	OPERATE1L_U
	clrf	OPERATE1L_E
;Let Operate2L = 0
	banksel	OPERATE2L
	clrf	OPERATE2L
	clrf	OPERATE2L_H
	clrf	OPERATE2L_U
	clrf	OPERATE2L_E
;Let ResultL   = 0
	clrf	RESULTL
	clrf	RESULTL_H
	clrf	RESULTL_U
	clrf	RESULTL_E
;Let Operand   = Answer
	movlw	29
	banksel	OPERAND
	movwf	OPERAND
;End If
ENDIF204
;End If
ENDIF195
;End If
;End If
	return

;********************************************************************************

DO_NUMBERL
;If Bit_Mode < Bit_32 Then
	movlw	2
	subwf	BIT_MODE,W
	btfsc	STATUS, C
	goto	ENDIF211
;Do_Number
	pagesel	DO_NUMBER
	call	DO_NUMBER
	pagesel	$
;Exit Sub
	return
;End If
ENDIF211
;If Mode = M_Bin Then
	decf	MODE,W
	btfss	STATUS, Z
	goto	ENDIF212
;Let Mode = M_Dec
	movlw	2
	movwf	MODE
;End If
ENDIF212
;If Mode = M_Dec Then
	movlw	2
	subwf	MODE,W
	btfss	STATUS, Z
	goto	ENDIF213
;If Input_Value > Bt9 Then
	movf	INPUT_VALUE,W
	movwf	SysWORDTempB
	movf	INPUT_VALUE_H,W
	movwf	SysWORDTempB_H
	movlw	9
	movwf	SysWORDTempA
	clrf	SysWORDTempA_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
;Exit Sub
	return
;End If
ENDIF215
;End If
ENDIF213
;Get_ZeroValue
	pagesel	GET_ZEROVALUE
	call	GET_ZEROVALUE
	pagesel	$
;If Op = 1 Then
	decf	OP,W
	btfss	STATUS, Z
	goto	ELSE214_1
;If Input_Value = Bt0 Then
	movf	INPUT_VALUE,W
	movwf	SysWORDTempA
	movf	INPUT_VALUE_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ELSE216_1
;Let Operate1L = Operate1L * Zero_Value
	movf	OPERATE1L,W
	movwf	SysLONGTempA
	movf	OPERATE1L_H,W
	movwf	SysLONGTempA_H
	movf	OPERATE1L_U,W
	movwf	SysLONGTempA_U
	movf	OPERATE1L_E,W
	movwf	SysLONGTempA_E
	banksel	ZERO_VALUE
	movf	ZERO_VALUE,W
	movwf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SysMultSub32
	call	SysMultSub32
	pagesel	$
	movf	SysLONGTempX,W
	movwf	OPERATE1L
	movf	SysLONGTempX_H,W
	movwf	OPERATE1L_H
	movf	SysLONGTempX_U,W
	movwf	OPERATE1L_U
	movf	SysLONGTempX_E,W
	movwf	OPERATE1L_E
;Else
	goto	ENDIF216
ELSE216_1
;Let Operate1L = Operate1L * Zero_Value
	movf	OPERATE1L,W
	movwf	SysLONGTempA
	movf	OPERATE1L_H,W
	movwf	SysLONGTempA_H
	movf	OPERATE1L_U,W
	movwf	SysLONGTempA_U
	movf	OPERATE1L_E,W
	movwf	SysLONGTempA_E
	banksel	ZERO_VALUE
	movf	ZERO_VALUE,W
	movwf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SysMultSub32
	call	SysMultSub32
	pagesel	$
	movf	SysLONGTempX,W
	movwf	OPERATE1L
	movf	SysLONGTempX_H,W
	movwf	OPERATE1L_H
	movf	SysLONGTempX_U,W
	movwf	OPERATE1L_U
	movf	SysLONGTempX_E,W
	movwf	OPERATE1L_E
;Let Operate1L = Operate1L + Input_Value
	movf	INPUT_VALUE,W
	addwf	OPERATE1L,F
	movf	INPUT_VALUE_H,W
	addwfc	OPERATE1L_H,F
	movlw	0
	addwfc	OPERATE1L_U,F
	movlw	0
	addwfc	OPERATE1L_E,F
;End If
ENDIF216
;Else
	goto	ENDIF214
ELSE214_1
;If Input_Value = Bt0 Then
	movf	INPUT_VALUE,W
	movwf	SysWORDTempA
	movf	INPUT_VALUE_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ELSE217_1
;Let Operate2L = Operate2L * Zero_Value
	banksel	OPERATE2L
	movf	OPERATE2L,W
	movwf	SysLONGTempA
	movf	OPERATE2L_H,W
	movwf	SysLONGTempA_H
	movf	OPERATE2L_U,W
	movwf	SysLONGTempA_U
	movf	OPERATE2L_E,W
	movwf	SysLONGTempA_E
	movf	ZERO_VALUE,W
	movwf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SysMultSub32
	call	SysMultSub32
	pagesel	$
	movf	SysLONGTempX,W
	banksel	OPERATE2L
	movwf	OPERATE2L
	movf	SysLONGTempX_H,W
	movwf	OPERATE2L_H
	movf	SysLONGTempX_U,W
	movwf	OPERATE2L_U
	movf	SysLONGTempX_E,W
	movwf	OPERATE2L_E
;Else
	goto	ENDIF217
ELSE217_1
;Let Operate2L = Operate2L * Zero_Value
	banksel	OPERATE2L
	movf	OPERATE2L,W
	movwf	SysLONGTempA
	movf	OPERATE2L_H,W
	movwf	SysLONGTempA_H
	movf	OPERATE2L_U,W
	movwf	SysLONGTempA_U
	movf	OPERATE2L_E,W
	movwf	SysLONGTempA_E
	movf	ZERO_VALUE,W
	movwf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SysMultSub32
	call	SysMultSub32
	pagesel	$
	movf	SysLONGTempX,W
	banksel	OPERATE2L
	movwf	OPERATE2L
	movf	SysLONGTempX_H,W
	movwf	OPERATE2L_H
	movf	SysLONGTempX_U,W
	movwf	OPERATE2L_U
	movf	SysLONGTempX_E,W
	movwf	OPERATE2L_E
;Let Operate2L = Operate2L + Input_Value
	banksel	INPUT_VALUE
	movf	INPUT_VALUE,W
	banksel	OPERATE2L
	addwf	OPERATE2L,F
	banksel	INPUT_VALUE_H
	movf	INPUT_VALUE_H,W
	banksel	OPERATE2L_H
	addwfc	OPERATE2L_H,F
	movlw	0
	addwfc	OPERATE2L_U,F
	movlw	0
	addwfc	OPERATE2L_E,F
;End If
ENDIF217
;End If
ENDIF214
	banksel	STATUS
	return

;********************************************************************************

DO_RANDL
;If Bit_Mode < Bit_32 Then
	movlw	2
	subwf	BIT_MODE,W
	btfsc	STATUS, C
	goto	ENDIF218
;Do_Rand
	pagesel	DO_RAND
	call	DO_RAND
	pagesel	$
;Exit Sub
	return
;End If
ENDIF218
;If RandomSeed = 0 Then
	banksel	RANDOMSEED
	movf	RANDOMSEED,F
	btfss	STATUS, Z
	goto	ENDIF219
;Randomize RSeed
	movf	RSEED,W
	movwf	RANDOMTEMP
	clrf	RANDOMTEMP_H
	banksel	STATUS
	pagesel	RANDOMIZE
	call	RANDOMIZE
	pagesel	$
;Let RandomSeed = 1
	movlw	1
	banksel	RANDOMSEED
	movwf	RANDOMSEED
;End If
ENDIF219
;Let ResultL = 0
	clrf	RESULTL
	clrf	RESULTL_H
	clrf	RESULTL_U
	clrf	RESULTL_E
;If TenThou = 1 Then
	decf	TENTHOU,W
	btfss	STATUS, Z
	goto	ELSE220_1
;Do
SysDoLoop_S6
;Let RandB1 = Random
	banksel	STATUS
	pagesel	FN_RANDOM
	call	FN_RANDOM
	pagesel	$
	banksel	RANDOM
	movf	RANDOM,W
	banksel	RANDB1
	movwf	RANDB1
;Let RandB2 = Random
	pagesel	FN_RANDOM
	call	FN_RANDOM
	pagesel	$
	banksel	RANDOM
	movf	RANDOM,W
	banksel	RANDB2
	movwf	RANDB2
;Let RandB3 = Random
	pagesel	FN_RANDOM
	call	FN_RANDOM
	pagesel	$
	banksel	RANDOM
	movf	RANDOM,W
	movwf	RANDB3
;Let RandB4 = Random
	banksel	STATUS
	pagesel	FN_RANDOM
	call	FN_RANDOM
	pagesel	$
	banksel	RANDOM
	movf	RANDOM,W
	movwf	RANDB4
;Let ResultL.0  = RandB1.0
	bcf	RESULTL,0
	banksel	RANDB1
	btfss	RANDB1,0
	goto	ENDIF221
	banksel	RESULTL
	bsf	RESULTL,0
ENDIF221
;Let ResultL.1  = RandB2.1
	banksel	RESULTL
	bcf	RESULTL,1
	banksel	RANDB2
	btfss	RANDB2,1
	goto	ENDIF222
	banksel	RESULTL
	bsf	RESULTL,1
ENDIF222
;Let ResultL.2  = RandB3.2
	banksel	RESULTL
	bcf	RESULTL,2
	btfsc	RANDB3,2
	bsf	RESULTL,2
ENDIF223
;Let ResultL.3  = RandB4.3
	bcf	RESULTL,3
	btfsc	RANDB4,3
	bsf	RESULTL,3
ENDIF224
;Let ResultL.4  = RandB1.2
	bcf	RESULTL,4
	banksel	RANDB1
	btfss	RANDB1,2
	goto	ENDIF225
	banksel	RESULTL
	bsf	RESULTL,4
ENDIF225
;Let ResultL.5  = RandB2.3
	banksel	RESULTL
	bcf	RESULTL,5
	banksel	RANDB2
	btfss	RANDB2,3
	goto	ENDIF226
	banksel	RESULTL
	bsf	RESULTL,5
ENDIF226
;Let ResultL.6  = RandB3.4
	banksel	RESULTL
	bcf	RESULTL,6
	btfsc	RANDB3,4
	bsf	RESULTL,6
ENDIF227
;Let ResultL.7  = RandB4.5
	bcf	RESULTL,7
	btfsc	RANDB4,5
	bsf	RESULTL,7
ENDIF228
;Let ResultL.8  = RandB1.3
	bcf	RESULTL_H,0
	banksel	RANDB1
	btfss	RANDB1,3
	goto	ENDIF229
	banksel	RESULTL_H
	bsf	RESULTL_H,0
ENDIF229
;Let ResultL.9  = RandB2.4
	banksel	RESULTL_H
	bcf	RESULTL_H,1
	banksel	RANDB2
	btfss	RANDB2,4
	goto	ENDIF230
	banksel	RESULTL_H
	bsf	RESULTL_H,1
ENDIF230
;Let ResultL.10 = RandB3.5
	banksel	RESULTL_H
	bcf	RESULTL_H,2
	btfsc	RANDB3,5
	bsf	RESULTL_H,2
ENDIF231
;Let ResultL.11 = RandB4.6
	bcf	RESULTL_H,3
	btfsc	RANDB4,6
	bsf	RESULTL_H,3
ENDIF232
;Let ResultL.12 = RandB1.4
	bcf	RESULTL_H,4
	banksel	RANDB1
	btfss	RANDB1,4
	goto	ENDIF233
	banksel	RESULTL_H
	bsf	RESULTL_H,4
ENDIF233
;Let ResultL.13 = RandB2.5
	banksel	RESULTL_H
	bcf	RESULTL_H,5
	banksel	RANDB2
	btfss	RANDB2,5
	goto	ENDIF234
	banksel	RESULTL_H
	bsf	RESULTL_H,5
ENDIF234
;Let ResultL.14 = 0
	banksel	RESULTL_H
	bcf	RESULTL_H,6
;Let ResultL.15 = 0
	bcf	RESULTL_H,7
;Loop until ResultL < 9999
	movf	resultl,W
	movwf	SysLONGTempA
	movf	resultl_H,W
	movwf	SysLONGTempA_H
	movf	resultl_U,W
	movwf	SysLONGTempA_U
	movf	resultl_E,W
	movwf	SysLONGTempA_E
	movlw	15
	movwf	SysLONGTempB
	movlw	39
	movwf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	btfss	SysByteTempX,0
	goto	SysDoLoop_S6
SysDoLoop_E6
;Let ResultL = ResultL + 1 'Prevent zero being returned
	banksel	RESULTL
	incf	RESULTL,F
	btfsc	STATUS,Z
	incf	RESULTL_H,F
	btfsc	STATUS,Z
	incf	RESULTL_U,F
	btfsc	STATUS,Z
	incf	RESULTL_E,F
;Else
	goto	ENDIF220
ELSE220_1
;Let ResultL = Random
	banksel	STATUS
	pagesel	FN_RANDOM
	call	FN_RANDOM
	pagesel	$
	banksel	RANDOM
	movf	RANDOM,W
	movwf	RESULTL
	clrf	RESULTL_H
	clrf	RESULTL_U
	clrf	RESULTL_E
;End If
ENDIF220
;Show_ValuesSubL(ResultL)
	movf	RESULTL,W
	banksel	D_VALUEL
	movwf	D_VALUEL
	banksel	RESULTL_H
	movf	RESULTL_H,W
	banksel	D_VALUEL_H
	movwf	D_VALUEL_H
	banksel	RESULTL_U
	movf	RESULTL_U,W
	banksel	D_VALUEL_U
	movwf	D_VALUEL_U
	banksel	RESULTL_E
	movf	RESULTL_E,W
	banksel	D_VALUEL_E
	movwf	D_VALUEL_E
	pagesel	SHOW_VALUESSUBL
	call	SHOW_VALUESSUBL
	pagesel	$
;Let Op = 2
	movlw	2
	movwf	OP
	return

;********************************************************************************

GET_BUTTONS
;For Row = 1 to 3
	banksel	ROW
	clrf	ROW
SysForLoop1
	incf	ROW,F
;If Row = 1 Then
	decf	ROW,W
	btfss	STATUS, Z
	goto	ENDIF47
;Let Button_R1 = 0
	banksel	LATC
	bcf	LATC,3
;Let Button_R2 = 1
	bsf	LATC,6
;Let Button_R3 = 1
	bsf	LATC,7
;End If
ENDIF47
;If Row = 2 Then
	movlw	2
	banksel	ROW
	subwf	ROW,W
	btfss	STATUS, Z
	goto	ENDIF48
;Let Button_R1 = 1
	banksel	LATC
	bsf	LATC,3
;Let Button_R2 = 0
	bcf	LATC,6
;Let Button_R3 = 1
	bsf	LATC,7
;End If
ENDIF48
;If Row = 3 Then
	movlw	3
	banksel	ROW
	subwf	ROW,W
	btfss	STATUS, Z
	goto	ENDIF49
;Let Button_R1 = 1
	banksel	LATC
	bsf	LATC,3
;Let Button_R2 = 1
	bsf	LATC,6
;Let Button_R3 = 0
	bcf	LATC,7
;End If
ENDIF49
;Let D_Lat = 0 'Load data to register
	banksel	LATC
	bcf	LATC,4
;Let D_Clk = 0 'Send Dummy pulse to ready actual data
	bcf	LATC,5
;Wait 1 uS
	movlw	2
	movwf	DELAYTEMP
DelayUS1
	decfsz	DELAYTEMP,F
	goto	DelayUS1
	nop
;Let D_Clk = 1
	bsf	LATC,5
;Wait 1 uS
	movlw	2
	movwf	DELAYTEMP
DelayUS2
	decfsz	DELAYTEMP,F
	goto	DelayUS2
	nop
;Let Dat_Out = 0
	banksel	DAT_OUT
	clrf	DAT_OUT
;Let D_Lat = 1 'Data now loaded, and ready for reading
	banksel	LATC
	bsf	LATC,4
;For Clocks = 1 to 8
	banksel	CLOCKS
	clrf	CLOCKS
SysForLoop2
	incf	CLOCKS,F
;Let D_Clk = 1               'Shift register clocked
	banksel	LATC
	bsf	LATC,5
;Let Dat_Out.7 = D_Data       'Read the first 'bit' into Dat_Out,
	banksel	DAT_OUT
	bcf	DAT_OUT,7
	btfsc	PORTA,4
	bsf	DAT_OUT,7
ENDIF56
;using bit.7 gives the correct sequence
;Let D_Clk = 0               'Close the clock
	banksel	LATC
	bcf	LATC,5
;Wait 1 uS
	movlw	2
	movwf	DELAYTEMP
DelayUS3
	decfsz	DELAYTEMP,F
	goto	DelayUS3
	nop
;Rotate Dat_Out Left Simple   'Move the data along one bit, ready for
	banksel	DAT_OUT
	rlf	DAT_OUT,W
	rlf	DAT_OUT,F
;the next bit, left gives the correct sequence
;Next Clocks
	movlw	8
	subwf	CLOCKS,W
	btfss	STATUS, C
	goto	SysForLoop2
ENDIF50
SysForLoopEnd2
;If Dat_Out < 255 Then
	movlw	255
	subwf	DAT_OUT,W
	btfsc	STATUS, C
	goto	ELSE51_1
;Data is sent from 74HC165 in reverse order, so invert it
;so that input zero is read as '1' and input 7 as '254'
;Let Dat_Out = 255 - Dat_Out
	movf	DAT_OUT,W
	sublw	255
	movwf	DAT_OUT
;If Row = 1 Then
	banksel	ROW
	decf	ROW,W
	btfss	STATUS, Z
	goto	ENDIF53
;Decode_Row1(Dat_Out)
	banksel	DAT_OUT
	movf	DAT_OUT,W
	movwf	DECODE_VALUE
	pagesel	DECODE_ROW1
	call	DECODE_ROW1
	pagesel	$
;End If
ENDIF53
;If Row = 2 Then
	movlw	2
	banksel	ROW
	subwf	ROW,W
	btfss	STATUS, Z
	goto	ENDIF54
;Decode_Row2(Dat_Out)
	banksel	DAT_OUT
	movf	DAT_OUT,W
	movwf	DECODE_VALUE
	pagesel	DECODE_ROW2
	call	DECODE_ROW2
	pagesel	$
;End If
ENDIF54
;If Row = 3 Then
	movlw	3
	banksel	ROW
	subwf	ROW,W
	btfss	STATUS, Z
	goto	ENDIF55
;Decode_Row3(Dat_Out)
	banksel	DAT_OUT
	movf	DAT_OUT,W
	movwf	DECODE_VALUE
	pagesel	DECODE_ROW3
	call	DECODE_ROW3
	pagesel	$
;End If
ENDIF55
;Exit Sub
	banksel	STATUS
	return
;Else
	goto	ENDIF51
ELSE51_1
;Let Button_Value = 255
	movlw	255
	movwf	BUTTON_VALUE
;End If
ENDIF51
;Next
	movlw	3
	banksel	ROW
	subwf	ROW,W
	btfss	STATUS, C
	goto	SysForLoop1
ENDIF52
SysForLoopEnd1
	banksel	STATUS
	return

;********************************************************************************

MAINLOOP_SUB
;Get_Buttons
	call	GET_BUTTONS
;If Button_Value < 255 Then
	movlw	255
	subwf	BUTTON_VALUE,W
	btfsc	STATUS, C
	goto	ENDIF10
;TimeOutState = false
	banksel	SYSBITVAR0
	bcf	SYSBITVAR0,0
;If Button_Value = BtMode Then
	movlw	27
	banksel	BUTTON_VALUE
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	ENDIF12
;Check_Mode
	pagesel	CHECK_MODE
	call	CHECK_MODE
	pagesel	$
;End If
ENDIF12
;If Button_Value = BtOr Then
	movlw	23
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	ENDIF13
;Check_Or
	pagesel	CHECK_OR
	call	CHECK_OR
	pagesel	$
;End If
ENDIF13
;If Button_Value = BtEn Then
	movlw	16
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	ENDIF14
;Check_En
	pagesel	CHECK_EN
	call	CHECK_EN
	pagesel	$
;End If
ENDIF14
;If Button_Value = BtAn Then
	movlw	21
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	ENDIF15
;Check_An
	pagesel	CHECK_AN
	call	CHECK_AN
	pagesel	$
;End If
ENDIF15
;If Button_Value = BtDi Then
	movlw	19
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	ENDIF16
;Check_Modulo
	pagesel	CHECK_MODULO
	call	CHECK_MODULO
	pagesel	$
;End If
ENDIF16
;If Operand = Answer Then 'Clear ready for new calculation'
	movlw	29
	subwf	OPERAND,W
	btfss	STATUS, Z
	goto	ENDIF17
;Let Op       = 1
	movlw	1
	movwf	OP
;Let Operate1 = 0
	clrf	OPERATE1
	clrf	OPERATE1_H
;Let Operate2 = 0
	clrf	OPERATE2
	clrf	OPERATE2_H
;Let Result   = 0
	banksel	RESULT
	clrf	RESULT
	clrf	RESULT_H
;Let Operand  = 0
	banksel	OPERAND
	clrf	OPERAND
;End If
ENDIF17
;If Result > 0 Then
	banksel	RESULT
	movf	RESULT,W
	movwf	SysWORDTempB
	movf	RESULT_H,W
	movwf	SysWORDTempB_H
	clrf	SysWORDTempA
	clrf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF18
;If Mode = M_Bin Then
	decf	MODE,W
	btfss	STATUS, Z
	goto	ENDIF21
;If Button_Value < Bt2 Then 'Clear ready for new calculation'
	movlw	2
	subwf	BUTTON_VALUE,W
	btfsc	STATUS, C
	goto	ENDIF26
;Let Op       = 1
	movlw	1
	movwf	OP
;Let Operate1 = 0
	clrf	OPERATE1
	clrf	OPERATE1_H
;Let Operate2 = 0
	clrf	OPERATE2
	clrf	OPERATE2_H
;Let Result   = 0
	banksel	RESULT
	clrf	RESULT
	clrf	RESULT_H
;Let Operand  = 0
	banksel	OPERAND
	clrf	OPERAND
;End If
ENDIF26
;End If
ENDIF21
;If Mode = M_Dec Then
	movlw	2
	subwf	MODE,W
	btfss	STATUS, Z
	goto	ENDIF22
;If Button_Value < BtA Then 'Clear ready for new calculation'
	movlw	10
	subwf	BUTTON_VALUE,W
	btfsc	STATUS, C
	goto	ENDIF27
;Let Op       = 1
	movlw	1
	movwf	OP
;Let Operate1 = 0
	clrf	OPERATE1
	clrf	OPERATE1_H
;Let Operate2 = 0
	clrf	OPERATE2
	clrf	OPERATE2_H
;Let Result   = 0
	banksel	RESULT
	clrf	RESULT
	clrf	RESULT_H
;Let Operand  = 0
	banksel	OPERAND
	clrf	OPERAND
;End If
ENDIF27
;End If
ENDIF22
;If Mode = M_Hex Then
	movlw	3
	subwf	MODE,W
	btfss	STATUS, Z
	goto	ENDIF23
;If Button_Value < BtEn Then 'Clear ready for new calculation'
	movlw	16
	subwf	BUTTON_VALUE,W
	btfsc	STATUS, C
	goto	ENDIF28
;Let Op       = 1
	movlw	1
	movwf	OP
;Let Operate1 = 0
	clrf	OPERATE1
	clrf	OPERATE1_H
;Let Operate2 = 0
	clrf	OPERATE2
	clrf	OPERATE2_H
;Let Result   = 0
	banksel	RESULT
	clrf	RESULT
	clrf	RESULT_H
;Let Operand  = 0
	banksel	OPERAND
	clrf	OPERAND
;End If
ENDIF28
;End If
ENDIF23
;End If
ENDIF18
;Build_Value(Button_Value)
	movf	BUTTON_VALUE,W
	movwf	INPUT_VALUE
	clrf	INPUT_VALUE_H
	pagesel	BUILD_VALUE
	call	BUILD_VALUE
	pagesel	$
;If Op = 1 Then
	decf	OP,W
	btfss	STATUS, Z
	goto	ELSE19_1
;Show_ValuesSub(Operate1)
	movf	OPERATE1,W
	movwf	D_VALUE
	movf	OPERATE1_H,W
	movwf	D_VALUE_H
	call	SHOW_VALUESSUB
;Let Operate2 = 0
	clrf	OPERATE2
	clrf	OPERATE2_H
;Let Result   = 0
	banksel	RESULT
	clrf	RESULT
	clrf	RESULT_H
;Else
	goto	ENDIF19
ELSE19_1
;If Operate2 > 0 Then
	movf	OPERATE2,W
	movwf	SysWORDTempB
	movf	OPERATE2_H,W
	movwf	SysWORDTempB_H
	clrf	SysWORDTempA
	clrf	SysWORDTempA_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ELSE24_1
;Show_ValuesSub(Operate2)
	movf	OPERATE2,W
	movwf	D_VALUE
	movf	OPERATE2_H,W
	movwf	D_VALUE_H
	call	SHOW_VALUESSUB
;Else
	goto	ENDIF24
ELSE24_1
;If Result = 0 Then
	banksel	RESULT
	movf	RESULT,W
	movwf	SysWORDTempA
	movf	RESULT_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF29
;Show_ValuesSub(Operate1)
	movf	OPERATE1,W
	movwf	D_VALUE
	movf	OPERATE1_H,W
	movwf	D_VALUE_H
	call	SHOW_VALUESSUB
;End If
ENDIF29
;End If
ENDIF24
;End If
ENDIF19
;If Result > 0 Then
	banksel	RESULT
	movf	RESULT,W
	movwf	SysWORDTempB
	movf	RESULT_H,W
	movwf	SysWORDTempB_H
	clrf	SysWORDTempA
	clrf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ELSE20_1
;Show_ValuesSub(Result)
	banksel	RESULT
	movf	RESULT,W
	banksel	D_VALUE
	movwf	D_VALUE
	banksel	RESULT_H
	movf	RESULT_H,W
	banksel	D_VALUE_H
	movwf	D_VALUE_H
	call	SHOW_VALUESSUB
;Locate 1,6
	movlw	1
	movwf	LCDLINE
	movlw	6
	movwf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;Print "Ans"
	movlw	low StringTable3
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable3) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Else
	goto	ENDIF20
ELSE20_1
;If Operand = Answer Then
	movlw	29
	subwf	OPERAND,W
	btfss	STATUS, Z
	goto	ELSE25_1
;Show_ValuesSub(Result)
	banksel	RESULT
	movf	RESULT,W
	banksel	D_VALUE
	movwf	D_VALUE
	banksel	RESULT_H
	movf	RESULT_H,W
	banksel	D_VALUE_H
	movwf	D_VALUE_H
	call	SHOW_VALUESSUB
;Locate 1,6
	movlw	1
	movwf	LCDLINE
	movlw	6
	movwf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;Print "Ans"
	movlw	low StringTable3
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable3) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Else
	goto	ENDIF25
ELSE25_1
;Locate 1,7
	movlw	1
	movwf	LCDLINE
	movlw	7
	movwf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;Print " "
	movlw	low StringTable4
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable4) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;End If
ENDIF25
;End If
ENDIF20
;Do
SysDoLoop_S2
;Wait 50 mS
	movlw	50
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;Get_Buttons
	call	GET_BUTTONS
;Loop Until Button_Value = 255
	incf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	SysDoLoop_S2
SysDoLoop_E2
;End If
ENDIF10
;Dim     CurMs, LstMs  as word  ' declare working variables
;CurMs = millis()
	pagesel	FN_MILLIS
	call	FN_MILLIS
	pagesel	$
	movf	MILLIS,W
	movwf	CURMS
	movf	MILLIS_H,W
	movwf	CURMS_H
;if CurMs - LstMs >= TimeOut then  ' required Time has Elapsed
	movf	LSTMS,W
	subwf	CURMS,W
	banksel	SYSTEMP1
	movwf	SysTemp1
	banksel	LSTMS_H
	movf	LSTMS_H,W
	subwfb	CURMS_H,W
	banksel	SYSTEMP1_H
	movwf	SysTemp1_H
	movf	SysTemp1,W
	movwf	SysWORDTempA
	movf	SysTemp1_H,W
	movwf	SysWORDTempA_H
	movlw	32
	movwf	SysWORDTempB
	movlw	78
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ENDIF11
;Animate_Screen
;LstMs = CurMs                   ' And Record Toggle Time
	movf	CURMS,W
	movwf	LSTMS
	movf	CURMS_H,W
	movwf	LSTMS_H
;end if
ENDIF11
	return

;********************************************************************************

SHOW_SPLASHSCREEN
;Get_Buttons
	call	GET_BUTTONS
;If Button_Value = BtAn Then
	movlw	21
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	ELSE108_1
;Locate 0,15
	clrf	LCDLINE
	movlw	15
	movwf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;Print "*"
	movlw	low StringTable9
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable9) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Let TenThou = 1
	movlw	1
	banksel	TENTHOU
	movwf	TENTHOU
;Else
	goto	ENDIF108
ELSE108_1
;Let TenThou = 0
	banksel	TENTHOU
	clrf	TENTHOU
;End If
ENDIF108
;If Button_Value = BtMode Then
	movlw	27
	banksel	BUTTON_VALUE
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	ENDIF109
;Locate 1,15
	movlw	1
	movwf	LCDLINE
	movlw	15
	movwf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;Print "^"
	movlw	low StringTable10
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable10) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;If Bit_Mode = Bit_16 Then
	decf	BIT_MODE,W
	btfss	STATUS, Z
	goto	ELSE112_1
;Let Bit_Mode = Bit_32
	movlw	2
	movwf	BIT_MODE
;Else
	goto	ENDIF112
ELSE112_1
;Let Bit_Mode = Bit_16
	movlw	1
	movwf	BIT_MODE
;End If
ENDIF112
;EpWrite Ep_Bit, Bit_mode
	movlw	1
	banksel	EEADDRESS
	movwf	EEADDRESS
	clrf	EEADDRESS_H
	banksel	BIT_MODE
	movf	BIT_MODE,W
	banksel	EEDATAVALUE
	movwf	EEDATAVALUE
	banksel	STATUS
	pagesel	EPWRITE
	call	EPWRITE
	pagesel	$
;End If
ENDIF109
;If Button_Value = BtA Then
	movlw	10
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	ENDIF110
;Locate 1,15
	movlw	1
	movwf	LCDLINE
	movlw	15
	movwf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;Print "a"
	movlw	low StringTable11
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable11) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;If Animate_Mode = Animate Then
	decf	ANIMATE_MODE,W
	btfss	STATUS, Z
	goto	ELSE113_1
;Let Animate_Mode = NoAnimate
	clrf	ANIMATE_MODE
;Else
	goto	ENDIF113
ELSE113_1
;Let Animate_Mode = Animate
	movlw	1
	movwf	ANIMATE_MODE
;End If
ENDIF113
;EpWrite Ep_Ani, Animate_Mode
	movlw	2
	banksel	EEADDRESS
	movwf	EEADDRESS
	clrf	EEADDRESS_H
	banksel	ANIMATE_MODE
	movf	ANIMATE_MODE,W
	banksel	EEDATAVALUE
	movwf	EEDATAVALUE
	banksel	STATUS
	pagesel	EPWRITE
	call	EPWRITE
	pagesel	$
;End If
ENDIF110
;Locate 0,0
	clrf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;If Bit_Mode = Bit_16 Then
	decf	BIT_MODE,W
	btfss	STATUS, Z
	goto	ELSE111_1
;0123456789012345'
;Print "16bit Bin - Dec"'Nothing in position 15 so that the mode changing 'markers' are not overwritten
	movlw	low StringTable12
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable12) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Else
	goto	ENDIF111
ELSE111_1
;0123456789012345'
;Print " 32bit  Decimal"'Nothing in position 15 so that the mode changing 'markers' are not overwritten
	movlw	low StringTable13
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable13) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;End If
ENDIF111
;Locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;0123456789012345'
;Print " - Hexadecimal "'Nothing in position 15 so that the mode changing 'markers' are not overwritten
	movlw	low StringTable14
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable14) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Wait 1500 mS
	movlw	220
	movwf	SysWaitTempMS
	movlw	5
	movwf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;Locate 0,0
	clrf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;Print " *Integer only* "
	movlw	low StringTable15
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable15) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;0123456789012345'
;Print "   Calculator   "
	movlw	low StringTable16
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable16) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Wait 1500 mS
	movlw	220
	movwf	SysWaitTempMS
	movlw	5
	movwf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
;CLS
	pagesel	CLS
	call	CLS
	pagesel	$
;Print "v: "
	movlw	low StringTable17
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable17) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Print CodeVersion
	movlw	low StringTable2
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable2) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;Print "h: "
;Print HCodeversion
	movlw	low StringTable47
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable47) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Wait 1500 mS
	movlw	220
	movwf	SysWaitTempMS
	movlw	5
	movwf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
;CLS
	pagesel	CLS
	call	CLS
	pagesel	$
;Locate 0,1
	clrf	LCDLINE
	movlw	1
	movwf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;Print ChipNameStr
	movlw	low StringTable89
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable89) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Print ","
	movlw	low StringTable18
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable18) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Print ChipMHz
	movlw	32
	movwf	LCDVALUE
	pagesel	PRINT145
	call	PRINT145
	pagesel	$
;Print "Mhz"
	movlw	low StringTable19
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable19) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;Print " (C) MkEDS 2018 "
	movlw	low StringTable20
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable20) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;Wait 1500 mS
	movlw	220
	movwf	SysWaitTempMS
	movlw	5
	movwf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;CLS
	pagesel	CLS
	goto	CLS

;********************************************************************************

SHOW_VALUESSUB
;Let Display_Value = D_Value
	movf	D_VALUE,W
	movwf	DISPLAY_VALUE
	movf	D_VALUE_H,W
	movwf	DISPLAY_VALUE_H
;Let DisplayHi = Display_Value_H
	movwf	DISPLAYHI
;Let DisplayLo = Display_Value
	movf	DISPLAY_VALUE,W
	movwf	DISPLAYLO
;Locate 0,0
	clrf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;Print DisplayHi.7 'Show High byte binary value'
	clrf	LCDVALUE
	btfsc	DISPLAYHI,7
	incf	LCDVALUE,F
ENDIF82
	pagesel	PRINT145
	call	PRINT145
	pagesel	$
;Print DisplayHi.6
	clrf	LCDVALUE
	btfsc	DISPLAYHI,6
	incf	LCDVALUE,F
ENDIF83
	pagesel	PRINT145
	call	PRINT145
	pagesel	$
;Print DisplayHi.5
	clrf	LCDVALUE
	btfsc	DISPLAYHI,5
	incf	LCDVALUE,F
ENDIF84
	pagesel	PRINT145
	call	PRINT145
	pagesel	$
;Print DisplayHi.4
	clrf	LCDVALUE
	btfsc	DISPLAYHI,4
	incf	LCDVALUE,F
ENDIF85
	pagesel	PRINT145
	call	PRINT145
	pagesel	$
;Print DisplayHi.3
	clrf	LCDVALUE
	btfsc	DISPLAYHI,3
	incf	LCDVALUE,F
ENDIF86
	pagesel	PRINT145
	call	PRINT145
	pagesel	$
;Print DisplayHi.2
	clrf	LCDVALUE
	btfsc	DISPLAYHI,2
	incf	LCDVALUE,F
ENDIF87
	pagesel	PRINT145
	call	PRINT145
	pagesel	$
;Print DisplayHi.1
	clrf	LCDVALUE
	btfsc	DISPLAYHI,1
	incf	LCDVALUE,F
ENDIF88
	pagesel	PRINT145
	call	PRINT145
	pagesel	$
;Print DisplayHi.0
	clrf	LCDVALUE
	btfsc	DISPLAYHI,0
	incf	LCDVALUE,F
ENDIF89
	pagesel	PRINT145
	call	PRINT145
	pagesel	$
;Print DisplayLo.7 'Show low  byte binary value'
	clrf	LCDVALUE
	btfsc	DISPLAYLO,7
	incf	LCDVALUE,F
ENDIF90
	pagesel	PRINT145
	call	PRINT145
	pagesel	$
;Print DisplayLo.6
	clrf	LCDVALUE
	btfsc	DISPLAYLO,6
	incf	LCDVALUE,F
ENDIF91
	pagesel	PRINT145
	call	PRINT145
	pagesel	$
;Print DisplayLo.5
	clrf	LCDVALUE
	btfsc	DISPLAYLO,5
	incf	LCDVALUE,F
ENDIF92
	pagesel	PRINT145
	call	PRINT145
	pagesel	$
;Print DisplayLo.4
	clrf	LCDVALUE
	btfsc	DISPLAYLO,4
	incf	LCDVALUE,F
ENDIF93
	pagesel	PRINT145
	call	PRINT145
	pagesel	$
;Print DisplayLo.3
	clrf	LCDVALUE
	btfsc	DISPLAYLO,3
	incf	LCDVALUE,F
ENDIF94
	pagesel	PRINT145
	call	PRINT145
	pagesel	$
;Print DisplayLo.2
	clrf	LCDVALUE
	btfsc	DISPLAYLO,2
	incf	LCDVALUE,F
ENDIF95
	pagesel	PRINT145
	call	PRINT145
	pagesel	$
;Print DisplayLo.1
	clrf	LCDVALUE
	btfsc	DISPLAYLO,1
	incf	LCDVALUE,F
ENDIF96
	pagesel	PRINT145
	call	PRINT145
	pagesel	$
;Print DisplayLo.0
	clrf	LCDVALUE
	btfsc	DISPLAYLO,0
	incf	LCDVALUE,F
ENDIF97
	pagesel	PRINT145
	call	PRINT145
	pagesel	$
;Locate 1,0
	movlw	1
	movwf	LCDLINE
	clrf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;Print "h"
	movlw	low StringTable6
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable6) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;LCDHex DisplayHi, LeadingZeroActive
	movf	DISPLAYHI,W
	movwf	LCDVALUE
	movlw	2
	movwf	LCDCHAR
	pagesel	LCDHEX
	call	LCDHEX
	pagesel	$
;LCDHex DisplayLo, LeadingZeroActive
	movf	DISPLAYLO,W
	movwf	LCDVALUE
	movlw	2
	movwf	LCDCHAR
	pagesel	LCDHEX
	call	LCDHEX
	pagesel	$
;Show_Mode
	pagesel	SHOW_MODE
	call	SHOW_MODE
;Show_Button
	pagesel	SHOW_BUTTON
	call	SHOW_BUTTON
	pagesel	$
;Locate 1,10
	movlw	1
	movwf	LCDLINE
	movlw	10
	movwf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;Print "d"
	movlw	low StringTable7
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable7) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;If Display_Value < 10000 Then
	movf	DISPLAY_VALUE,W
	movwf	SysWORDTempA
	movf	DISPLAY_VALUE_H,W
	movwf	SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB
	movlw	39
	movwf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF77
;Print "0"
	movlw	low StringTable8
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable8) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;End If
ENDIF77
;If Display_Value < 1000  Then
	movf	DISPLAY_VALUE,W
	movwf	SysWORDTempA
	movf	DISPLAY_VALUE_H,W
	movwf	SysWORDTempA_H
	movlw	232
	movwf	SysWORDTempB
	movlw	3
	movwf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF78
;Print "0"
	movlw	low StringTable8
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable8) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;End If
ENDIF78
;If Display_Value < 100   Then
	movf	DISPLAY_VALUE,W
	movwf	SysWORDTempA
	movf	DISPLAY_VALUE_H,W
	movwf	SysWORDTempA_H
	movlw	100
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF79
;Print "0"
	movlw	low StringTable8
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable8) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;End If
ENDIF79
;If Display_Value < 10    Then
	movf	DISPLAY_VALUE,W
	movwf	SysWORDTempA
	movf	DISPLAY_VALUE_H,W
	movwf	SysWORDTempA_H
	movlw	10
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF80
;Print "0"
	movlw	low StringTable8
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable8) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	pagesel	PRINT144
	call	PRINT144
	pagesel	$
;End If
ENDIF80
;Print Display_Value
	movf	DISPLAY_VALUE,W
	movwf	LCDVALUE
	movf	DISPLAY_VALUE_H,W
	movwf	LCDVALUE_H
	pagesel	PRINT146
	call	PRINT146
	pagesel	$
;If Result > 0 Then
	banksel	RESULT
	movf	RESULT,W
	movwf	SysWORDTempB
	movf	RESULT_H,W
	movwf	SysWORDTempB_H
	clrf	SysWORDTempA
	clrf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF81
;Wait 500 mS 'Ensures Mode and Button are displayed briefly'
	movlw	244
	movwf	SysWaitTempMS
	movlw	1
	movwf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;End If
ENDIF81
	return

;********************************************************************************

STARTUP
;Let Dat          = 0
	clrf	DAT
;Let Temp         = 0
	banksel	TEMP
	clrf	TEMP
;Let Clocks       = 0
	banksel	CLOCKS
	clrf	CLOCKS
;Let Dat_Out      = 0
	clrf	DAT_OUT
;Let Row          = 0
	banksel	ROW
	clrf	ROW
;Let Button_Value = 0
	banksel	BUTTON_VALUE
	clrf	BUTTON_VALUE
;Let Decode_Value = 0
	clrf	DECODE_VALUE
;Let Input_Value  = 0
	clrf	INPUT_VALUE
	clrf	INPUT_VALUE_H
;Let Display_Value= 0
	clrf	DISPLAY_VALUE
	clrf	DISPLAY_VALUE_H
;Let DisplayHi    = 0
	clrf	DISPLAYHI
;Let DisplayLo    = 0
	clrf	DISPLAYLO
;Let Operate1     = 0
	clrf	OPERATE1
	clrf	OPERATE1_H
;Let Operate2     = 0
	clrf	OPERATE2
	clrf	OPERATE2_H
;Let Built_Value  = 0
	clrf	BUILT_VALUE
	clrf	BUILT_VALUE_H
;Let Result       = 0
	banksel	RESULT
	clrf	RESULT
	clrf	RESULT_H
;Let Operand      = 0
	banksel	OPERAND
	clrf	OPERAND
;Let Op           = 1
	movlw	1
	movwf	OP
;Let RSeed        = 0
	banksel	RSEED
	clrf	RSEED
;Let RandomSeed   = 0
	clrf	RANDOMSEED
;Let Input_ValueL  = 0
	banksel	INPUT_VALUEL
	clrf	INPUT_VALUEL
	clrf	INPUT_VALUEL_H
	clrf	INPUT_VALUEL_U
	clrf	INPUT_VALUEL_E
;Let Display_ValueL= 0
	clrf	DISPLAY_VALUEL
	clrf	DISPLAY_VALUEL_H
	clrf	DISPLAY_VALUEL_U
	clrf	DISPLAY_VALUEL_E
;Let DisplayHiL    = 0
	clrf	DISPLAYHIL
;Let DisplayLoL    = 0
	clrf	DISPLAYLOL
;Let DisplayHi     = 0
	clrf	DISPLAYHI
;Let DisplayLo     = 0
	clrf	DISPLAYLO
;Let Operate1L     = 0
	clrf	OPERATE1L
	clrf	OPERATE1L_H
	clrf	OPERATE1L_U
	clrf	OPERATE1L_E
;Let Operate2L     = 0
	banksel	OPERATE2L
	clrf	OPERATE2L
	clrf	OPERATE2L_H
	clrf	OPERATE2L_U
	clrf	OPERATE2L_E
;Let Built_ValueL  = 0
	banksel	BUILT_VALUEL
	clrf	BUILT_VALUEL
	clrf	BUILT_VALUEL_H
	clrf	BUILT_VALUEL_U
	clrf	BUILT_VALUEL_E
;Let ResultL       = 0
	banksel	RESULTL
	clrf	RESULTL
	clrf	RESULTL_H
	clrf	RESULTL_U
	clrf	RESULTL_E
;Let Math_Loop    = 0
	banksel	MATH_LOOP
	clrf	MATH_LOOP
	clrf	MATH_LOOP_H
;Let Temp_W       = 0
	banksel	TEMP_W
	clrf	TEMP_W
	clrf	TEMP_W_H
;Let Animate_Mode = 0
	banksel	ANIMATE_MODE
	clrf	ANIMATE_MODE
;Let Animate_Delay= 35 'mS
	movlw	35
	movwf	ANIMATE_DELAY
;EpRead (EpMode, Mode)
	banksel	EEADDRESS
	clrf	EEADDRESS
	clrf	EEADDRESS_H
	banksel	STATUS
	pagesel	SYSEPREAD
	call	SYSEPREAD
	pagesel	$
	banksel	EEDATAVALUE
	movf	EEDATAVALUE,W
	banksel	MODE
	movwf	MODE
;If Mode > M_Hex Then
	sublw	3
	btfsc	STATUS, C
	goto	ENDIF3
;Let Mode = M_Dec
	movlw	2
	movwf	MODE
;End If
ENDIF3
;EpRead (Ep_Bit, Bit_Mode)
	movlw	1
	banksel	EEADDRESS
	movwf	EEADDRESS
	clrf	EEADDRESS_H
	banksel	STATUS
	pagesel	SYSEPREAD
	call	SYSEPREAD
	pagesel	$
	banksel	EEDATAVALUE
	movf	EEDATAVALUE,W
	banksel	BIT_MODE
	movwf	BIT_MODE
;If Bit_Mode > Bit_32 Then
	sublw	2
	btfsc	STATUS, C
	goto	ENDIF4
;Let Bit_Mode = Bit_16
	movlw	1
	movwf	BIT_MODE
;End If
ENDIF4
;If Bit_Mode < Bit_16 Then
	movlw	1
	subwf	BIT_MODE,W
	btfsc	STATUS, C
	goto	ENDIF5
;Let Bit_Mode = Bit_16
	movlw	1
	movwf	BIT_MODE
;End If
ENDIF5
;EpRead Ep_Ani, Animate_Mode
	movlw	2
	banksel	EEADDRESS
	movwf	EEADDRESS
	clrf	EEADDRESS_H
	banksel	STATUS
	pagesel	SYSEPREAD
	call	SYSEPREAD
	pagesel	$
	banksel	EEDATAVALUE
	movf	EEDATAVALUE,W
	banksel	ANIMATE_MODE
	movwf	ANIMATE_MODE
;If Animate_Mode > Animate Then
	sublw	1
	btfss	STATUS, C
;Let Animate_Mode = NoAnimate
	clrf	ANIMATE_MODE
;End If
ENDIF6
;Let Last_Mode    = 0
	clrf	LAST_MODE
;Let D_Clk = 0
	banksel	LATC
	bcf	LATC,5
;MakeLCDGraphics
	banksel	STATUS
	pagesel	MAKELCDGRAPHICS
	call	MAKELCDGRAPHICS
	pagesel	$
;Show_SplashScreen
	call	SHOW_SPLASHSCREEN
	pagesel	$
;If Bit_Mode = Bit_32 Then
	movlw	2
	subwf	BIT_MODE,W
	btfss	STATUS, Z
	goto	ENDIF7
;If Mode = M_Bin Then
	decf	MODE,W
	btfss	STATUS, Z
	goto	ENDIF9
;Let Mode = M_Dec
	movlw	2
	movwf	MODE
;EpWrite EpMode, Mode
	banksel	EEADDRESS
	clrf	EEADDRESS
	clrf	EEADDRESS_H
	banksel	MODE
	movf	MODE,W
	banksel	EEDATAVALUE
	movwf	EEDATAVALUE
	banksel	STATUS
	pagesel	EPWRITE
	call	EPWRITE
	pagesel	$
;End If
ENDIF9
;End If
ENDIF7
;If Bit_Mode = Bit_16 Then
	decf	BIT_MODE,W
	btfss	STATUS, Z
	goto	ELSE8_1
;Show_ValuesSub(0)
	clrf	D_VALUE
	clrf	D_VALUE_H
	call	SHOW_VALUESSUB
;Else
	goto	ENDIF8
ELSE8_1
;CLS
	pagesel	CLS
	call	CLS
	pagesel	$
;Show_ValuesSubL(0)
	clrf	D_VALUEL
	clrf	D_VALUEL_H
	clrf	D_VALUEL_U
	clrf	D_VALUEL_E
	pagesel	SHOW_VALUESSUBL
	call	SHOW_VALUESSUBL
	pagesel	$
;End If
ENDIF8
	return

;********************************************************************************

;Start of program memory page 2
	ORG	4096
BUILD_VALUE
;If Input_Value = BtClr Then
	movf	INPUT_VALUE,W
	movwf	SysWORDTempA
	movf	INPUT_VALUE_H,W
	movwf	SysWORDTempA_H
	movlw	26
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF57
;Let Operate1    = 0
	clrf	OPERATE1
	clrf	OPERATE1_H
;Let Operate2    = 0
	clrf	OPERATE2
	clrf	OPERATE2_H
;Let Operand     = 0
	clrf	OPERAND
;Let Op          = 1
	movlw	1
	movwf	OP
;Let Result      = 0
	banksel	RESULT
	clrf	RESULT
	clrf	RESULT_H
;Let Built_Value = 0
	banksel	BUILT_VALUE
	clrf	BUILT_VALUE
	clrf	BUILT_VALUE_H
;Exit Sub
	return
;End If
ENDIF57
;If Input_Value = BtEn Then 'Enter pressed, do maths'
	movf	INPUT_VALUE,W
	movwf	SysWORDTempA
	movf	INPUT_VALUE_H,W
	movwf	SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF58
;Do_Maths
	pagesel	DO_MATHS
	call	DO_MATHS
	pagesel	$
;End If
ENDIF58
;If Input_Value > BtEn Then 'Operand is Pressed'
	movf	INPUT_VALUE,W
	movwf	SysWORDTempB
	movf	INPUT_VALUE_H,W
	movwf	SysWORDTempB_H
	movlw	16
	movwf	SysWORDTempA
	clrf	SysWORDTempA_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF59
;If Input_Value < BtMode Then 'Mode or Clr are not Pressed'
	movf	INPUT_VALUE,W
	movwf	SysWORDTempA
	movf	INPUT_VALUE_H,W
	movwf	SysWORDTempA_H
	movlw	27
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF63
;If Result > 0 Then
	banksel	RESULT
	movf	RESULT,W
	movwf	SysWORDTempB
	movf	RESULT_H,W
	movwf	SysWORDTempB_H
	clrf	SysWORDTempA
	clrf	SysWORDTempA_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ELSE64_1
;Let Operate1 = Result
	banksel	RESULT
	movf	RESULT,W
	banksel	OPERATE1
	movwf	OPERATE1
	banksel	RESULT_H
	movf	RESULT_H,W
	banksel	OPERATE1_H
	movwf	OPERATE1_H
;Let Operate2 = 0
	clrf	OPERATE2
	clrf	OPERATE2_H
;Let Result   = 0
	banksel	RESULT
	clrf	RESULT
	clrf	RESULT_H
;Let Op       = 2
	movlw	2
	banksel	OP
	movwf	OP
;Let Operand  = Input_Value
	movf	INPUT_VALUE,W
	movwf	OPERAND
;Else
	goto	ENDIF64
ELSE64_1
;If Operate1 > 0 Then
;If Op = 2 Then
	movlw	2
	subwf	OP,W
	btfss	STATUS, Z
	goto	ENDIF65
;Let Operate2 = 0
	clrf	OPERATE2
	clrf	OPERATE2_H
;Let Result   = 0
	banksel	RESULT
	clrf	RESULT
	clrf	RESULT_H
;End If
ENDIF65
;If Op = 1 Then
	banksel	OP
	decf	OP,W
	btfss	STATUS, Z
	goto	ENDIF66
;Let Op = 2
	movlw	2
	movwf	OP
;End If
ENDIF66
;Let Operand = Input_Value
	movf	INPUT_VALUE,W
	movwf	OPERAND
;Exit Sub
	return
;Else
;Exit Sub
;End If
;End If
ENDIF64
;Exit Sub
	return
;End If
ENDIF63
;End If
ENDIF59
;If Input_Value < BtEn Then 'Number pressed'
	movf	INPUT_VALUE,W
	movwf	SysWORDTempA
	movf	INPUT_VALUE_H,W
	movwf	SysWORDTempA_H
	movlw	16
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
;Do_Number
	call	DO_NUMBER
;End If
ENDIF60
;If Input_Value = BtNot Then
	movf	INPUT_VALUE,W
	movwf	SysWORDTempA
	movf	INPUT_VALUE_H,W
	movwf	SysWORDTempA_H
	movlw	25
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF61
;Do_Not
	call	DO_NOT
	pagesel	$
;End If
ENDIF61
;If Input_Value = BtRand Then
	movf	INPUT_VALUE,W
	movwf	SysWORDTempA
	movf	INPUT_VALUE_H,W
	movwf	SysWORDTempA_H
	movlw	26
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfsc	SysByteTempX,0
;Do_Rand
	call	DO_RAND
;End If
ENDIF62
	return

;********************************************************************************

CHECK_AN
;Wait 50 mS
	movlw	50
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;If Button_Value = BtAn Then
	movlw	21
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	ELSE132_1
;Wait 100 mS
	movlw	100
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;Get_Buttons
	pagesel	GET_BUTTONS
	call	GET_BUTTONS
	pagesel	$
;If Button_Value = BtAn Then
	movlw	21
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	ELSE133_1
;Wait 100 mS
	movlw	100
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;Get_Buttons
	pagesel	GET_BUTTONS
	call	GET_BUTTONS
	pagesel	$
;If Button_Value = BtAn Then
	movlw	21
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	ELSE134_1
;Let Button_Value = BtRand
	movlw	26
	movwf	BUTTON_VALUE
;Else
	goto	ENDIF134
ELSE134_1
;Let Button_Value = BtAn
	movlw	21
	movwf	BUTTON_VALUE
;End If
ENDIF134
;Else
	goto	ENDIF133
ELSE133_1
;Let Button_Value = BtAn
	movlw	21
	movwf	BUTTON_VALUE
;End If
ENDIF133
;Else
	goto	ENDIF132
ELSE132_1
;Let Button_Value = BtAn
	movlw	21
	movwf	BUTTON_VALUE
;End If
ENDIF132
	return

;********************************************************************************

CHECK_EN
;Wait 50 mS
	movlw	50
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;If Button_Value = BtEn Then
	movlw	16
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	ELSE129_1
;Wait 100 mS
	movlw	100
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;Get_Buttons
	pagesel	GET_BUTTONS
	call	GET_BUTTONS
	pagesel	$
;If Button_Value = BtEn Then
	movlw	16
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	ELSE130_1
;Wait 100 mS
	movlw	100
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;Get_Buttons
	pagesel	GET_BUTTONS
	call	GET_BUTTONS
	pagesel	$
;If Button_Value = BtEn Then
	movlw	16
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	ELSE131_1
;Let Button_Value = BtNot
	movlw	25
	movwf	BUTTON_VALUE
;Else
	goto	ENDIF131
ELSE131_1
;Let Button_Value = BtEn
	movlw	16
	movwf	BUTTON_VALUE
;End If
ENDIF131
;Else
	goto	ENDIF130
ELSE130_1
;Let Button_Value = BtEn
	movlw	16
	movwf	BUTTON_VALUE
;End If
ENDIF130
;Else
	goto	ENDIF129
ELSE129_1
;Let Button_Value = BtEn
	movlw	16
	movwf	BUTTON_VALUE
;End If
ENDIF129
	return

;********************************************************************************

CHECK_MODE
;Wait 50 mS
	movlw	50
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;Get_Buttons
	pagesel	GET_BUTTONS
	call	GET_BUTTONS
	pagesel	$
;If Button_Value = BtMode Then
	movlw	27
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	ELSE118_1
;Wait 100 mS
	movlw	100
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;Get_Buttons
	pagesel	GET_BUTTONS
	call	GET_BUTTONS
	pagesel	$
;If Button_Value = BtMode Then
	movlw	27
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	ELSE120_1
;Wait 100 mS
	movlw	100
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;Get_Buttons
	pagesel	GET_BUTTONS
	call	GET_BUTTONS
	pagesel	$
;If Button_Value = BtMode Then
	movlw	27
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	ELSE124_1
;Let Button_Value = BtClr
	movlw	26
	movwf	BUTTON_VALUE
;Else
	goto	ENDIF124
ELSE124_1
;Let Button_Value = BtMode
	movlw	27
	movwf	BUTTON_VALUE
;End If
ENDIF124
;Else
	goto	ENDIF120
ELSE120_1
;Let Button_Value = BtMode
	movlw	27
	movwf	BUTTON_VALUE
;End If
ENDIF120
;Else
	goto	ENDIF118
ELSE118_1
;Let Button_Value = BtMode
	movlw	27
	movwf	BUTTON_VALUE
;End If
ENDIF118
;If Button_Value = BtMode Then
	movlw	27
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	ENDIF119
;Let Mode = Mode + 1
	incf	MODE,F
;If Mode > M_Hex Then
	movf	MODE,W
	sublw	3
	btfsc	STATUS, C
	goto	ENDIF121
;Let Mode = M_Bin
	movlw	1
	movwf	MODE
;End If
ENDIF121
;If Bit_Mode = Bit_32 Then 'No Binary in 32bit
	movlw	2
	subwf	BIT_MODE,W
	btfss	STATUS, Z
	goto	ENDIF122
;If Mode = M_Bin Then
	decf	MODE,W
	btfsc	STATUS, Z
;Let Mode = Mode + 1
	incf	MODE,F
;End If
ENDIF125
;End If
ENDIF122
;EpRead  (EpMode, Temp) 'Only write if value is different'
	banksel	EEADDRESS
	clrf	EEADDRESS
	clrf	EEADDRESS_H
	banksel	STATUS
	pagesel	SYSEPREAD
	call	SYSEPREAD
	pagesel	$
	banksel	EEDATAVALUE
	movf	EEDATAVALUE,W
	banksel	TEMP
	movwf	TEMP
;If Temp <> Mode Then
	banksel	MODE
	movf	MODE,W
	banksel	TEMP
	subwf	TEMP,W
	btfsc	STATUS, Z
	goto	ENDIF123
;EpWrite (EpMode, Mode)
	banksel	EEADDRESS
	clrf	EEADDRESS
	clrf	EEADDRESS_H
	banksel	MODE
	movf	MODE,W
	banksel	EEDATAVALUE
	movwf	EEDATAVALUE
	banksel	STATUS
	pagesel	EPWRITE
	call	EPWRITE
	pagesel	$
;End If
ENDIF123
;End If
ENDIF119
	banksel	STATUS
	return

;********************************************************************************

CHECK_OR
;Wait 50 mS
	movlw	50
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;If Button_Value = BtOr Then
	movlw	23
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	ELSE126_1
;Wait 100 mS
	movlw	100
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;Get_Buttons
	pagesel	GET_BUTTONS
	call	GET_BUTTONS
	pagesel	$
;If Button_Value = BtOr Then
	movlw	23
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	ELSE127_1
;Wait 100 mS
	movlw	100
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	call	Delay_MS
;Get_Buttons
	pagesel	GET_BUTTONS
	call	GET_BUTTONS
	pagesel	$
;If Button_Value = BtOr Then
	movlw	23
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	ELSE128_1
;Let Button_Value = BtXor
	movlw	24
	movwf	BUTTON_VALUE
;Else
	goto	ENDIF128
ELSE128_1
;Let Button_Value = BtOr
	movlw	23
	movwf	BUTTON_VALUE
;End If
ENDIF128
;Else
	goto	ENDIF127
ELSE127_1
;Let Button_Value = BtOr
	movlw	23
	movwf	BUTTON_VALUE
;End If
ENDIF127
;Else
	goto	ENDIF126
ELSE126_1
;Let Button_Value = BtOr
	movlw	23
	movwf	BUTTON_VALUE
;End If
ENDIF126
	return

;********************************************************************************

DECODE_ROW1
;Let Button_Value = 255
	movlw	255
	movwf	BUTTON_VALUE
;Select Case Decode_Value
;Case Column_0
SysSelect1Case1
	decf	DECODE_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect1Case2
;Let Button_Value = Bt0
	clrf	BUTTON_VALUE
;Case Column_1
	goto	SysSelectEnd1
SysSelect1Case2
	movlw	2
	subwf	DECODE_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect1Case3
;Let Button_Value = Bt1
	movlw	1
	movwf	BUTTON_VALUE
;Case Column_2
	goto	SysSelectEnd1
SysSelect1Case3
	movlw	4
	subwf	DECODE_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect1Case4
;Let Button_Value = Bt2
	movlw	2
	movwf	BUTTON_VALUE
;Case Column_3
	goto	SysSelectEnd1
SysSelect1Case4
	movlw	8
	subwf	DECODE_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect1Case5
;Let Button_Value = Bt3
	movlw	3
	movwf	BUTTON_VALUE
;Case Column_4
	goto	SysSelectEnd1
SysSelect1Case5
	movlw	16
	subwf	DECODE_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect1Case6
;Let Button_Value = Bt4
	movlw	4
	movwf	BUTTON_VALUE
;Case Column_5
	goto	SysSelectEnd1
SysSelect1Case6
	movlw	32
	subwf	DECODE_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect1Case7
;Let Button_Value = Bt5
	movlw	5
	movwf	BUTTON_VALUE
;Case Column_6
	goto	SysSelectEnd1
SysSelect1Case7
	movlw	64
	subwf	DECODE_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect1Case8
;Let Button_Value = Bt6
	movlw	6
	movwf	BUTTON_VALUE
;Case Column_7
	goto	SysSelectEnd1
SysSelect1Case8
	movlw	128
	subwf	DECODE_VALUE,W
	btfss	STATUS, Z
	goto	SysSelectEnd1
;Let Button_Value = Bt7
	movlw	7
	movwf	BUTTON_VALUE
;End Select
SysSelectEnd1
	return

;********************************************************************************

DECODE_ROW2
;Let Button_Value = 255
	movlw	255
	movwf	BUTTON_VALUE
;Select Case Decode_Value
;Case Column_0
SysSelect2Case1
	decf	DECODE_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect2Case2
;Let Button_Value = Bt8
	movlw	8
	movwf	BUTTON_VALUE
;Case Column_1
	goto	SysSelectEnd2
SysSelect2Case2
	movlw	2
	subwf	DECODE_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect2Case3
;Let Button_Value = Bt9
	movlw	9
	movwf	BUTTON_VALUE
;Case Column_2
	goto	SysSelectEnd2
SysSelect2Case3
	movlw	4
	subwf	DECODE_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect2Case4
;Let Button_Value = BtA
	movlw	10
	movwf	BUTTON_VALUE
;Case Column_3
	goto	SysSelectEnd2
SysSelect2Case4
	movlw	8
	subwf	DECODE_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect2Case5
;Let Button_Value = BtB
	movlw	11
	movwf	BUTTON_VALUE
;Case Column_4
	goto	SysSelectEnd2
SysSelect2Case5
	movlw	16
	subwf	DECODE_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect2Case6
;Let Button_Value = BtC
	movlw	12
	movwf	BUTTON_VALUE
;Case Column_5
	goto	SysSelectEnd2
SysSelect2Case6
	movlw	32
	subwf	DECODE_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect2Case7
;Let Button_Value = BtD
	movlw	13
	movwf	BUTTON_VALUE
;Case Column_6
	goto	SysSelectEnd2
SysSelect2Case7
	movlw	64
	subwf	DECODE_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect2Case8
;Let Button_Value = BtE
	movlw	14
	movwf	BUTTON_VALUE
;Case Column_7
	goto	SysSelectEnd2
SysSelect2Case8
	movlw	128
	subwf	DECODE_VALUE,W
	btfss	STATUS, Z
	goto	SysSelectEnd2
;Let Button_Value = BtF
	movlw	15
	movwf	BUTTON_VALUE
;End Select
SysSelectEnd2
	return

;********************************************************************************

DECODE_ROW3
;Let Button_Value = 255
	movlw	255
	movwf	BUTTON_VALUE
;Select Case Decode_Value
;Case Column_0
SysSelect3Case1
	decf	DECODE_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect3Case2
;Let Button_Value = BtEn
	movlw	16
	movwf	BUTTON_VALUE
;Case Column_1
	goto	SysSelectEnd3
SysSelect3Case2
	movlw	2
	subwf	DECODE_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect3Case3
;Let Button_Value = BtPl
	movlw	17
	movwf	BUTTON_VALUE
;Case Column_2
	goto	SysSelectEnd3
SysSelect3Case3
	movlw	4
	subwf	DECODE_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect3Case4
;Let Button_Value = BtMi
	movlw	18
	movwf	BUTTON_VALUE
;Case Column_3
	goto	SysSelectEnd3
SysSelect3Case4
	movlw	8
	subwf	DECODE_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect3Case5
;Let Button_Value = BtDi
	movlw	19
	movwf	BUTTON_VALUE
;Case Column_4
	goto	SysSelectEnd3
SysSelect3Case5
	movlw	16
	subwf	DECODE_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect3Case6
;Let Button_Value = BtMu
	movlw	20
	movwf	BUTTON_VALUE
;Case Column_5
	goto	SysSelectEnd3
SysSelect3Case6
	movlw	32
	subwf	DECODE_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect3Case7
;Let Button_Value = BtAn
	movlw	21
	movwf	BUTTON_VALUE
;Case Column_6
	goto	SysSelectEnd3
SysSelect3Case7
	movlw	64
	subwf	DECODE_VALUE,W
	btfss	STATUS, Z
	goto	SysSelect3Case8
;Let Button_Value = BtOr
	movlw	23
	movwf	BUTTON_VALUE
;Case Column_7
	goto	SysSelectEnd3
SysSelect3Case8
	movlw	128
	subwf	DECODE_VALUE,W
	btfss	STATUS, Z
	goto	SysSelectEnd3
;Let Button_Value = BtMode
	movlw	27
	movwf	BUTTON_VALUE
;End Select
SysSelectEnd3
	return

;********************************************************************************

DO_NOT
;If Bit_Mode = Bit_32 Then
	movlw	2
	subwf	BIT_MODE,W
	btfss	STATUS, Z
	goto	ENDIF163
;Do_NotL
	call	DO_NOTL
	pagesel	$
;Exit Sub
	return
;End If
ENDIF163
;If Op = 1 Then
	decf	OP,W
	btfss	STATUS, Z
	goto	ELSE164_1
;Let Operate1 = Not Operate1
	comf	OPERATE1,F
	comf	OPERATE1_H,F
;Else
	goto	ENDIF164
ELSE164_1
;If Op = 2 Then
	movlw	2
	subwf	OP,W
	btfss	STATUS, Z
	goto	ELSE165_1
;If Result <> 0 Then
	banksel	RESULT
	movf	RESULT,W
	movwf	SysWORDTempA
	movf	RESULT_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ELSE166_1
;Let Result = Not Result
	banksel	RESULT
	comf	RESULT,F
	comf	RESULT_H,F
;If Result = 0 Then 'Clear ready for new calculation'
	movf	RESULT,W
	movwf	SysWORDTempA
	movf	RESULT_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF168
;Let Op       = 1
	movlw	1
	movwf	OP
;Let Operate1 = 0
	clrf	OPERATE1
	clrf	OPERATE1_H
;Let Operate2 = 0
	clrf	OPERATE2
	clrf	OPERATE2_H
;Let Result   = 0
	banksel	RESULT
	clrf	RESULT
	clrf	RESULT_H
;End If
ENDIF168
;Else
	goto	ENDIF166
ELSE166_1
;Let Operate2 = Not Operate2
	comf	OPERATE2,F
	comf	OPERATE2_H,F
;End If
ENDIF166
;Else
	goto	ENDIF165
ELSE165_1
;Let Result = Not Result
	banksel	RESULT
	comf	RESULT,F
	comf	RESULT_H,F
;If Result = 0 Then 'Clear ready for new calculation'
	movf	RESULT,W
	movwf	SysWORDTempA
	movf	RESULT_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF167
;Let Op       = 1
	movlw	1
	movwf	OP
;Let Operate1 = 0
	clrf	OPERATE1
	clrf	OPERATE1_H
;Let Operate2 = 0
	clrf	OPERATE2
	clrf	OPERATE2_H
;Let Result   = 0
	banksel	RESULT
	clrf	RESULT
	clrf	RESULT_H
;End If
ENDIF167
;End If
ENDIF165
;End If
ENDIF164
;Show_Mode
	banksel	STATUS
	call	SHOW_MODE
;Show_Button
	pagesel	SHOW_BUTTON
	goto	SHOW_BUTTON

;********************************************************************************

DO_NOTL
;If Bit_Mode < Bit_32 Then
	movlw	2
	subwf	BIT_MODE,W
	btfsc	STATUS, C
	goto	ENDIF205
;Do_Not
	call	DO_NOT
	pagesel	$
;Exit Sub
	return
;End If
ENDIF205
;If Op = 1 Then
	decf	OP,W
	btfss	STATUS, Z
	goto	ELSE206_1
;Let Operate1L = Not Operate1L
	comf	OPERATE1L,F
	comf	OPERATE1L_H,F
	comf	OPERATE1L_U,F
	comf	OPERATE1L_E,F
;Else
	goto	ENDIF206
ELSE206_1
;If Op = 2 Then
	movlw	2
	subwf	OP,W
	btfss	STATUS, Z
	goto	ELSE207_1
;If ResultL <> 0 Then
	banksel	RESULTL
	movf	RESULTL,W
	movwf	SysLONGTempA
	movf	RESULTL_H,W
	movwf	SysLONGTempA_H
	movf	RESULTL_U,W
	movwf	SysLONGTempA_U
	movf	RESULTL_E,W
	movwf	SysLONGTempA_E
	clrf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SysCompEqual32
	call	SysCompEqual32
	pagesel	$
	comf	SysByteTempX,F
	btfss	SysByteTempX,0
	goto	ELSE208_1
;Let ResultL = Not ResultL
	banksel	RESULTL
	comf	RESULTL,F
	comf	RESULTL_H,F
	comf	RESULTL_U,F
	comf	RESULTL_E,F
;If ResultL = 0 Then 'Clear ready for new calculation'
	movf	RESULTL,W
	movwf	SysLONGTempA
	movf	RESULTL_H,W
	movwf	SysLONGTempA_H
	movf	RESULTL_U,W
	movwf	SysLONGTempA_U
	movf	RESULTL_E,W
	movwf	SysLONGTempA_E
	clrf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SysCompEqual32
	call	SysCompEqual32
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF210
;Let Op        = 1
	movlw	1
	movwf	OP
;Let Operate1L = 0
	clrf	OPERATE1L
	clrf	OPERATE1L_H
	clrf	OPERATE1L_U
	clrf	OPERATE1L_E
;Let Operate2L = 0
	banksel	OPERATE2L
	clrf	OPERATE2L
	clrf	OPERATE2L_H
	clrf	OPERATE2L_U
	clrf	OPERATE2L_E
;Let ResultL   = 0
	clrf	RESULTL
	clrf	RESULTL_H
	clrf	RESULTL_U
	clrf	RESULTL_E
;End If
ENDIF210
;Else
	goto	ENDIF208
ELSE208_1
;Let Operate2L = Not Operate2L
	banksel	OPERATE2L
	comf	OPERATE2L,F
	comf	OPERATE2L_H,F
	comf	OPERATE2L_U,F
	comf	OPERATE2L_E,F
;End If
ENDIF208
;Else
	goto	ENDIF207
ELSE207_1
;Let ResultL = Not ResultL
	banksel	RESULTL
	comf	RESULTL,F
	comf	RESULTL_H,F
	comf	RESULTL_U,F
	comf	RESULTL_E,F
;If ResultL = 0 Then 'Clear ready for new calculation'
	movf	RESULTL,W
	movwf	SysLONGTempA
	movf	RESULTL_H,W
	movwf	SysLONGTempA_H
	movf	RESULTL_U,W
	movwf	SysLONGTempA_U
	movf	RESULTL_E,W
	movwf	SysLONGTempA_E
	clrf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SysCompEqual32
	call	SysCompEqual32
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF209
;Let Op        = 1
	movlw	1
	movwf	OP
;Let Operate1L = 0
	clrf	OPERATE1L
	clrf	OPERATE1L_H
	clrf	OPERATE1L_U
	clrf	OPERATE1L_E
;Let Operate2L = 0
	banksel	OPERATE2L
	clrf	OPERATE2L
	clrf	OPERATE2L_H
	clrf	OPERATE2L_U
	clrf	OPERATE2L_E
;Let ResultL   = 0
	clrf	RESULTL
	clrf	RESULTL_H
	clrf	RESULTL_U
	clrf	RESULTL_E
;End If
ENDIF209
;End If
ENDIF207
;End If
ENDIF206
;Show_Mode
	banksel	STATUS
	call	SHOW_MODE
;Show_Button
	pagesel	SHOW_BUTTON
	goto	SHOW_BUTTON

;********************************************************************************

DO_NUMBER
;If Bit_Mode = Bit_32 Then
	movlw	2
	subwf	BIT_MODE,W
	btfss	STATUS, Z
	goto	ENDIF169
;Do_NumberL
	pagesel	DO_NUMBERL
	call	DO_NUMBERL
	pagesel	$
;Exit Sub
	return
;End If
ENDIF169
;If Mode = M_Bin Then
	decf	MODE,W
	btfss	STATUS, Z
	goto	ENDIF170
;If Input_Value > Bt1 Then
	movf	INPUT_VALUE,W
	movwf	SysWORDTempB
	movf	INPUT_VALUE_H,W
	movwf	SysWORDTempB_H
	movlw	1
	movwf	SysWORDTempA
	clrf	SysWORDTempA_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
;Exit Sub
	return
;End if
ENDIF173
;End If
ENDIF170
;If Mode = M_Dec Then
	movlw	2
	subwf	MODE,W
	btfss	STATUS, Z
	goto	ENDIF171
;If Input_Value > Bt9 Then
	movf	INPUT_VALUE,W
	movwf	SysWORDTempB
	movf	INPUT_VALUE_H,W
	movwf	SysWORDTempB_H
	movlw	9
	movwf	SysWORDTempA
	clrf	SysWORDTempA_H
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfsc	SysByteTempX,0
;Exit Sub
	return
;End If
ENDIF174
;End If
ENDIF171
;Get_ZeroValue
	pagesel	GET_ZEROVALUE
	call	GET_ZEROVALUE
	pagesel	$
;If Op = 1 Then
	decf	OP,W
	btfss	STATUS, Z
	goto	ELSE172_1
;If Input_Value = Bt0 Then
	movf	INPUT_VALUE,W
	movwf	SysWORDTempA
	movf	INPUT_VALUE_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ELSE175_1
;Let Operate1 = Operate1 * Zero_Value
	movf	OPERATE1,W
	movwf	SysWORDTempA
	movf	OPERATE1_H,W
	movwf	SysWORDTempA_H
	banksel	ZERO_VALUE
	movf	ZERO_VALUE,W
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysMultSub16
	call	SysMultSub16
	pagesel	$
	movf	SysWORDTempX,W
	movwf	OPERATE1
	movf	SysWORDTempX_H,W
	movwf	OPERATE1_H
;Else
	goto	ENDIF175
ELSE175_1
;Let Operate1 = Operate1 * Zero_Value
	movf	OPERATE1,W
	movwf	SysWORDTempA
	movf	OPERATE1_H,W
	movwf	SysWORDTempA_H
	banksel	ZERO_VALUE
	movf	ZERO_VALUE,W
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysMultSub16
	call	SysMultSub16
	pagesel	$
	movf	SysWORDTempX,W
	movwf	OPERATE1
	movf	SysWORDTempX_H,W
	movwf	OPERATE1_H
;Let Operate1 = Operate1 + Input_Value
	movf	INPUT_VALUE,W
	addwf	OPERATE1,F
	movf	INPUT_VALUE_H,W
	addwfc	OPERATE1_H,F
;End If
ENDIF175
;Else
	goto	ENDIF172
ELSE172_1
;If Input_Value = Bt0 Then
	movf	INPUT_VALUE,W
	movwf	SysWORDTempA
	movf	INPUT_VALUE_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	clrf	SysWORDTempB_H
	pagesel	SysCompEqual16
	call	SysCompEqual16
	pagesel	$
	btfss	SysByteTempX,0
	goto	ELSE176_1
;Let Operate2 = Operate2 * Zero_Value
	movf	OPERATE2,W
	movwf	SysWORDTempA
	movf	OPERATE2_H,W
	movwf	SysWORDTempA_H
	banksel	ZERO_VALUE
	movf	ZERO_VALUE,W
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysMultSub16
	call	SysMultSub16
	pagesel	$
	movf	SysWORDTempX,W
	movwf	OPERATE2
	movf	SysWORDTempX_H,W
	movwf	OPERATE2_H
;Else
	goto	ENDIF176
ELSE176_1
;Let Operate2 = Operate2 * Zero_Value
	movf	OPERATE2,W
	movwf	SysWORDTempA
	movf	OPERATE2_H,W
	movwf	SysWORDTempA_H
	banksel	ZERO_VALUE
	movf	ZERO_VALUE,W
	movwf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysMultSub16
	call	SysMultSub16
	pagesel	$
	movf	SysWORDTempX,W
	movwf	OPERATE2
	movf	SysWORDTempX_H,W
	movwf	OPERATE2_H
;Let Operate2 = Operate2 + Input_Value
	movf	INPUT_VALUE,W
	addwf	OPERATE2,F
	movf	INPUT_VALUE_H,W
	addwfc	OPERATE2_H,F
;End If
ENDIF176
;End If
ENDIF172
	return

;********************************************************************************

DO_RAND
;If Bit_Mode = Bit_32 Then
	movlw	2
	subwf	BIT_MODE,W
	btfss	STATUS, Z
	goto	ENDIF177
;Do_RandL
	pagesel	DO_RANDL
	call	DO_RANDL
	pagesel	$
;Exit Sub
	return
;End If
ENDIF177
;If RandomSeed = 0 Then
	banksel	RANDOMSEED
	movf	RANDOMSEED,F
	btfss	STATUS, Z
	goto	ENDIF178
;Randomize RSeed
	movf	RSEED,W
	movwf	RANDOMTEMP
	clrf	RANDOMTEMP_H
	banksel	STATUS
	pagesel	RANDOMIZE
	call	RANDOMIZE
	pagesel	$
;Let RandomSeed = 1
	movlw	1
	banksel	RANDOMSEED
	movwf	RANDOMSEED
;End If
ENDIF178
;If TenThou = 1 Then
	decf	TENTHOU,W
	btfss	STATUS, Z
	goto	ELSE179_1
;Do
SysDoLoop_S5
;Let RandB1 = Random
	banksel	STATUS
	pagesel	FN_RANDOM
	call	FN_RANDOM
	pagesel	$
	banksel	RANDOM
	movf	RANDOM,W
	banksel	RANDB1
	movwf	RANDB1
;Let RandB2 = Random
	pagesel	FN_RANDOM
	call	FN_RANDOM
	pagesel	$
	banksel	RANDOM
	movf	RANDOM,W
	banksel	RANDB2
	movwf	RANDB2
;Let RandB3 = Random
	pagesel	FN_RANDOM
	call	FN_RANDOM
	pagesel	$
	banksel	RANDOM
	movf	RANDOM,W
	movwf	RANDB3
;Let RandB4 = Random
	banksel	STATUS
	pagesel	FN_RANDOM
	call	FN_RANDOM
	pagesel	$
	banksel	RANDOM
	movf	RANDOM,W
	movwf	RANDB4
;Let Result.0  = RandB1.0
	bcf	RESULT,0
	banksel	RANDB1
	btfss	RANDB1,0
	goto	ENDIF180
	banksel	RESULT
	bsf	RESULT,0
ENDIF180
;Let Result.1  = RandB2.1
	banksel	RESULT
	bcf	RESULT,1
	banksel	RANDB2
	btfss	RANDB2,1
	goto	ENDIF181
	banksel	RESULT
	bsf	RESULT,1
ENDIF181
;Let Result.2  = RandB3.2
	banksel	RESULT
	bcf	RESULT,2
	btfsc	RANDB3,2
	bsf	RESULT,2
ENDIF182
;Let Result.3  = RandB4.3
	bcf	RESULT,3
	btfsc	RANDB4,3
	bsf	RESULT,3
ENDIF183
;Let Result.4  = RandB1.2
	bcf	RESULT,4
	banksel	RANDB1
	btfss	RANDB1,2
	goto	ENDIF184
	banksel	RESULT
	bsf	RESULT,4
ENDIF184
;Let Result.5  = RandB2.3
	banksel	RESULT
	bcf	RESULT,5
	banksel	RANDB2
	btfss	RANDB2,3
	goto	ENDIF185
	banksel	RESULT
	bsf	RESULT,5
ENDIF185
;Let Result.6  = RandB3.4
	banksel	RESULT
	bcf	RESULT,6
	btfsc	RANDB3,4
	bsf	RESULT,6
ENDIF186
;Let Result.7  = RandB4.5
	bcf	RESULT,7
	btfsc	RANDB4,5
	bsf	RESULT,7
ENDIF187
;Let Result.8  = RandB1.3
	bcf	RESULT_H,0
	banksel	RANDB1
	btfss	RANDB1,3
	goto	ENDIF188
	banksel	RESULT_H
	bsf	RESULT_H,0
ENDIF188
;Let Result.9  = RandB2.4
	banksel	RESULT_H
	bcf	RESULT_H,1
	banksel	RANDB2
	btfss	RANDB2,4
	goto	ENDIF189
	banksel	RESULT_H
	bsf	RESULT_H,1
ENDIF189
;Let Result.10 = RandB3.5
	banksel	RESULT_H
	bcf	RESULT_H,2
	btfsc	RANDB3,5
	bsf	RESULT_H,2
ENDIF190
;Let Result.11 = RandB4.6
	bcf	RESULT_H,3
	btfsc	RANDB4,6
	bsf	RESULT_H,3
ENDIF191
;Let Result.12 = RandB1.4
	bcf	RESULT_H,4
	banksel	RANDB1
	btfss	RANDB1,4
	goto	ENDIF192
	banksel	RESULT_H
	bsf	RESULT_H,4
ENDIF192
;Let Result.13 = RandB2.5
	banksel	RESULT_H
	bcf	RESULT_H,5
	banksel	RANDB2
	btfss	RANDB2,5
	goto	ENDIF193
	banksel	RESULT_H
	bsf	RESULT_H,5
ENDIF193
;Let Result.14 = 0
	banksel	RESULT_H
	bcf	RESULT_H,6
;Let Result.15 = 0
	bcf	RESULT_H,7
;Loop until Result < 9999
	movf	result,W
	movwf	SysWORDTempA
	movf	result_H,W
	movwf	SysWORDTempA_H
	movlw	15
	movwf	SysWORDTempB
	movlw	39
	movwf	SysWORDTempB_H
	banksel	STATUS
	pagesel	SysCompLessThan16
	call	SysCompLessThan16
	pagesel	$
	btfss	SysByteTempX,0
	goto	SysDoLoop_S5
SysDoLoop_E5
;Let Result = Result + 1 'Prevent zero being returned
	banksel	RESULT
	incf	RESULT,F
	btfsc	STATUS,Z
	incf	RESULT_H,F
;Else
	goto	ENDIF179
ELSE179_1
;Let Result = Random
	banksel	STATUS
	pagesel	FN_RANDOM
	call	FN_RANDOM
	pagesel	$
	banksel	RANDOM
	movf	RANDOM,W
	movwf	RESULT
	clrf	RESULT_H
;End If
ENDIF179
;Show_ValuesSub(Result)
	movf	RESULT,W
	banksel	D_VALUE
	movwf	D_VALUE
	banksel	RESULT_H
	movf	RESULT_H,W
	banksel	D_VALUE_H
	movwf	D_VALUE_H
	pagesel	SHOW_VALUESSUB
	call	SHOW_VALUESSUB
	pagesel	$
;Let Op = 2
	movlw	2
	movwf	OP
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

LCDCREATECHAR
;Store old location
;Select location
;Set LCD_RS Off
	banksel	LATA
	bcf	LATA,0
;LCDWriteByte (64 + LCDCharLoc * 8)
	banksel	LCDCHARLOC
	movf	LCDCHARLOC,W
	movwf	SysBYTETempA
	movlw	8
	movwf	SysBYTETempB
	pagesel	SysMultSub
	call	SysMultSub
	pagesel	$
	movlw	64
	addwf	SysBYTETempX,W
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
;wait 5 10us
	movlw	5
	movwf	SysWaitTemp10US
	pagesel	Delay_10US
	call	Delay_10US
	pagesel	$
;Write char
;Set LCD_RS On
	banksel	LATA
	bsf	LATA,0
;For LCDTemp = 1 to 8
	banksel	LCDTEMP
	clrf	LCDTEMP
SysForLoop8
	incf	LCDTEMP,F
;LCDWriteByte LCDCharData(LCDTemp)
	movf	LCDTEMP,W
	banksel	SYSLCDCHARDATAHANDLER
	addwf	SysLCDCHARDATAHandler,W
	movwf	AFSR0
	movlw	0
	addwfc	SysLCDCHARDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	LCDBYTE
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
;wait 5 10us
	movlw	5
	movwf	SysWaitTemp10US
	pagesel	Delay_10US
	call	Delay_10US
	pagesel	$
;Next
	movlw	8
	subwf	LCDTEMP,W
	btfss	STATUS, C
	goto	SysForLoop8
ENDIF263
SysForLoopEnd8
;Restore location
;set LCD_RS off
	banksel	LATA
	bcf	LATA,0
;LCDWriteByte(0x80)
	movlw	128
	banksel	LCDBYTE
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
;wait 5 10us
	movlw	5
	movwf	SysWaitTemp10US
	pagesel	Delay_10US
	goto	Delay_10US

;********************************************************************************

LCDHEX
;Revised 01/26/2014 by William Roth
;Prints Hex value of ByteVal at current cursor location
;ByteVal must be in the range of 0 to 255 (Dec)
;ByteVal can be entered as dec, binary or hex
;Extract nibbles and convert to ascii values
;HighChar = (LCDValue / 16)  + 48
	movf	LCDVALUE,W
	movwf	SysBYTETempA
	movlw	16
	movwf	SysBYTETempB
	pagesel	SysDivSub
	call	SysDivSub
	pagesel	$
	movf	SysBYTETempA,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	48
	addwf	SysTemp2,W
	banksel	HIGHCHAR
	movwf	HIGHCHAR
;LowChar  = (LCDValue and 15) + 48
	movlw	15
	andwf	LCDVALUE,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	48
	addwf	SysTemp2,W
	banksel	LOWCHAR
	movwf	LOWCHAR
;Check for alpha and convert.
;If HighChar > 57 Then HighChar = HighChar + 7
	movf	HIGHCHAR,W
	sublw	57
	btfsc	STATUS, C
	goto	ENDIF247
	movlw	7
	addwf	HIGHCHAR,F
ENDIF247
;If LowChar > 57 Then  LowChar = LowChar + 7
	movf	LOWCHAR,W
	sublw	57
	btfsc	STATUS, C
	goto	ENDIF248
	movlw	7
	addwf	LOWCHAR,F
ENDIF248
;Set LCD_RS OFF
	banksel	LATA
	bcf	LATA,0
;Write chars to LCD - if user specifies LeadingZeroActive then print the leading char
;IF LCDChar = LeadingZeroActive then
	movlw	2
	banksel	LCDCHAR
	subwf	LCDCHAR,W
	btfss	STATUS, Z
	goto	ENDIF249
;if LCDValue < 16 then
	movlw	16
	subwf	LCDVALUE,W
	btfsc	STATUS, C
	goto	ENDIF251
;LCDWriteChar 48
	movlw	48
	movwf	LCDCHAR
	pagesel	LCDWRITECHAR
	call	LCDWRITECHAR
	pagesel	$
;end if
ENDIF251
;END IF
ENDIF249
;Write high char if LCDValue is > 15 (DEC)
;IF LCDValue > 15 then LCDWriteChar HighChar
	movf	LCDVALUE,W
	sublw	15
	btfsc	STATUS, C
	goto	ENDIF250
	movf	HIGHCHAR,W
	movwf	LCDCHAR
	pagesel	LCDWRITECHAR
	call	LCDWRITECHAR
	pagesel	$
ENDIF250
;LCDWriteChar LowChar
	movf	LOWCHAR,W
	movwf	LCDCHAR
	pagesel	LCDWRITECHAR
	goto	LCDWRITECHAR

;********************************************************************************

LCDNORMALWRITEBYTE
;Set pins to output
;DIR LCD_DB4 OUT
	banksel	TRISA
	bcf	TRISA,2
;DIR LCD_DB5 OUT
	bcf	TRISC,0
;DIR LCD_DB6 OUT
	bcf	TRISC,1
;DIR LCD_DB7 OUT
	bcf	TRISC,2
;Write upper nibble to output pins
;set LCD_DB4 OFF
	banksel	LATA
	bcf	LATA,2
;set LCD_DB5 OFF
	bcf	LATC,0
;set LCD_DB6 OFF
	bcf	LATC,1
;set LCD_DB7 OFF
	bcf	LATC,2
;if LCDByte.7 ON THEN SET LCD_DB7 ON
	banksel	LCDBYTE
	btfss	LCDBYTE,7
	goto	ENDIF252
	banksel	LATC
	bsf	LATC,2
ENDIF252
;if LCDByte.6 ON THEN SET LCD_DB6 ON
	banksel	LCDBYTE
	btfss	LCDBYTE,6
	goto	ENDIF253
	banksel	LATC
	bsf	LATC,1
ENDIF253
;if LCDByte.5 ON THEN SET LCD_DB5 ON
	banksel	LCDBYTE
	btfss	LCDBYTE,5
	goto	ENDIF254
	banksel	LATC
	bsf	LATC,0
ENDIF254
;if LCDByte.4 ON THEN SET LCD_DB4 ON
	banksel	LCDBYTE
	btfss	LCDBYTE,4
	goto	ENDIF255
	banksel	LATA
	bsf	LATA,2
ENDIF255
;wait 1 us
	movlw	2
	movwf	DELAYTEMP
DelayUS12
	decfsz	DELAYTEMP,F
	goto	DelayUS12
	nop
;pulseout LCD_enable, 2 us
;Set Pin On
	banksel	LATA
	bsf	LATA,1
;Wait Time
	movlw	5
	movwf	DELAYTEMP
DelayUS13
	decfsz	DELAYTEMP,F
	goto	DelayUS13
;Set Pin Off
	bcf	LATA,1
;Wait 2 us
	movlw	5
	movwf	DELAYTEMP
DelayUS14
	decfsz	DELAYTEMP,F
	goto	DelayUS14
;All data pins low
;set LCD_DB4 OFF
	bcf	LATA,2
;set LCD_DB5 OFF
	bcf	LATC,0
;set LCD_DB6 OFF
	bcf	LATC,1
;set LCD_DB7 OFF
	bcf	LATC,2
;Write lower nibble to output pins
;if LCDByte.3 ON THEN SET LCD_DB7 ON
	banksel	LCDBYTE
	btfss	LCDBYTE,3
	goto	ENDIF256
	banksel	LATC
	bsf	LATC,2
ENDIF256
;if LCDByte.2 ON THEN SET LCD_DB6 ON
	banksel	LCDBYTE
	btfss	LCDBYTE,2
	goto	ENDIF257
	banksel	LATC
	bsf	LATC,1
ENDIF257
;if LCDByte.1 ON THEN SET LCD_DB5 ON
	banksel	LCDBYTE
	btfss	LCDBYTE,1
	goto	ENDIF258
	banksel	LATC
	bsf	LATC,0
ENDIF258
;if LCDByte.0 ON THEN SET LCD_DB4 ON
	banksel	LCDBYTE
	btfss	LCDBYTE,0
	goto	ENDIF259
	banksel	LATA
	bsf	LATA,2
ENDIF259
;wait 1 us
	movlw	2
	movwf	DELAYTEMP
DelayUS15
	decfsz	DELAYTEMP,F
	goto	DelayUS15
	nop
;pulseout LCD_enable, 2 us
;Set Pin On
	banksel	LATA
	bsf	LATA,1
;Wait Time
	movlw	5
	movwf	DELAYTEMP
DelayUS16
	decfsz	DELAYTEMP,F
	goto	DelayUS16
;Set Pin Off
	bcf	LATA,1
;wait 2 us
	movlw	5
	movwf	DELAYTEMP
DelayUS17
	decfsz	DELAYTEMP,F
	goto	DelayUS17
;Set data pins low again
;SET LCD_DB7 OFF
	bcf	LATC,2
;SET LCD_DB6 OFF
	bcf	LATC,1
;SET LCD_DB5 OFF
	bcf	LATC,0
;SET LCD_DB4 OFF
	bcf	LATA,2
;character delay settings
;wait fast_us  us
	movlw	85
	movwf	DELAYTEMP
DelayUS18
	decfsz	DELAYTEMP,F
	goto	DelayUS18
;If Register Select is low.  14.02.19
;IF LCD_RS = 0 then
	banksel	PORTA
	btfsc	PORTA,0
	goto	ENDIF260
;IF LCDByte < 16 then
	movlw	16
	subwf	LCDBYTE,W
	btfsc	STATUS, C
	goto	ENDIF261
;if LCDByte > 7 then
	movf	LCDBYTE,W
	sublw	7
	btfsc	STATUS, C
	goto	ENDIF262
;LCD_State = LCDByte
	movf	LCDBYTE,W
	movwf	LCD_STATE
;end if
ENDIF262
;END IF
ENDIF261
;END IF
ENDIF260
	return

;********************************************************************************

MAKELCDGRAPHICS
;Or CG0
;CGArray(1) = b'00010001'
	movlw	17
	banksel	SYSCGARRAY_1
	movwf	SYSCGARRAY_1
;CGArray(2) = b'00010001'
	movlw	17
	movwf	SYSCGARRAY_2
;CGArray(3) = b'00010001'
	movlw	17
	movwf	SYSCGARRAY_3
;CGArray(4) = b'00001010'
	movlw	10
	movwf	SYSCGARRAY_4
;CGArray(5) = b'00000100'
	movlw	4
	movwf	SYSCGARRAY_5
;CGArray(6) = b'00000000'
	clrf	SYSCGARRAY_6
;CGArray(7) = b'00000000'
	clrf	SYSCGARRAY_7
;CGArray(8) = b'00000000'
	clrf	SYSCGARRAY_8
;LCDCreateChar 0, CGArray()
	banksel	LCDCHARLOC
	clrf	LCDCHARLOC
	movlw	low CGARRAY
	banksel	SYSLCDCHARDATAHANDLER
	movwf	SysLCDCHARDATAHandler
	movlw	high CGARRAY
	movwf	SysLCDCHARDATAHandler_H
	banksel	STATUS
	call	LCDCREATECHAR
	pagesel	$
;Xor CG1
;CGArray(1) = b'00010001'
	movlw	17
	banksel	SYSCGARRAY_1
	movwf	SYSCGARRAY_1
;CGArray(2) = b'00010001'
	movlw	17
	movwf	SYSCGARRAY_2
;CGArray(3) = b'00010001'
	movlw	17
	movwf	SYSCGARRAY_3
;CGArray(4) = b'00001010'
	movlw	10
	movwf	SYSCGARRAY_4
;CGArray(5) = b'00000100'
	movlw	4
	movwf	SYSCGARRAY_5
;CGArray(6) = b'00000000'
	clrf	SYSCGARRAY_6
;CGArray(7) = b'00011111'
	movlw	31
	movwf	SYSCGARRAY_7
;CGArray(8) = b'00000000'
	clrf	SYSCGARRAY_8
;LCDCreateChar 1, CGArray()
	movlw	1
	banksel	LCDCHARLOC
	movwf	LCDCHARLOC
	movlw	low CGARRAY
	banksel	SYSLCDCHARDATAHANDLER
	movwf	SysLCDCHARDATAHandler
	movlw	high CGARRAY
	movwf	SysLCDCHARDATAHandler_H
	banksel	STATUS
	call	LCDCREATECHAR
	pagesel	$
;Not CG2
;CGArray(1) = b'00011111'
	movlw	31
	banksel	SYSCGARRAY_1
	movwf	SYSCGARRAY_1
;CGArray(2) = b'00011111'
	movlw	31
	movwf	SYSCGARRAY_2
;CGArray(3) = b'00010001'
	movlw	17
	movwf	SYSCGARRAY_3
;CGArray(4) = b'00011111'
	movlw	31
	movwf	SYSCGARRAY_4
;CGArray(5) = b'00010001'
	movlw	17
	movwf	SYSCGARRAY_5
;CGArray(6) = b'00011111'
	movlw	31
	movwf	SYSCGARRAY_6
;CGArray(7) = b'00011111'
	movlw	31
	movwf	SYSCGARRAY_7
;CGArray(8) = b'00000000'
	clrf	SYSCGARRAY_8
;LCDCreateChar 2, CGArray()
	movlw	2
	banksel	LCDCHARLOC
	movwf	LCDCHARLOC
	movlw	low CGARRAY
	banksel	SYSLCDCHARDATAHANDLER
	movwf	SysLCDCHARDATAHandler
	movlw	high CGARRAY
	movwf	SysLCDCHARDATAHandler_H
	banksel	STATUS
	goto	LCDCREATECHAR

;********************************************************************************

;Overloaded signature: STRING:
PRINT144
;PrintLen = LEN(PrintData$)
;PrintLen = PrintData(0)
	banksel	SYSPRINTDATAHANDLER
	movf	SysPRINTDATAHandler,W
	movwf	AFSR0
	movf	SysPRINTDATAHandler_H,W
	movwf	AFSR0_H
	movf	INDF0,W
	banksel	PRINTLEN
	movwf	PRINTLEN
;If PrintLen = 0 Then Exit Sub
	movf	PRINTLEN,F
	btfsc	STATUS, Z
	return
ENDIF236
;Set LCD_RS On
	banksel	LATA
	bsf	LATA,0
;Write Data
;For SysPrintTemp = 1 To PrintLen
	banksel	SYSPRINTTEMP
	clrf	SYSPRINTTEMP
	movlw	1
	banksel	PRINTLEN
	subwf	PRINTLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd6
ENDIF237
SysForLoop6
	banksel	SYSPRINTTEMP
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
	call	LCDNORMALWRITEBYTE
;Next
	movf	PRINTLEN,W
	banksel	SYSPRINTTEMP
	subwf	SYSPRINTTEMP,W
	btfss	STATUS, C
	goto	SysForLoop6
ENDIF238
SysForLoopEnd6
	banksel	STATUS
	return

;********************************************************************************

;Overloaded signature: BYTE:
PRINT145
;LCDValueTemp = 0
	clrf	LCDVALUETEMP
;Set LCD_RS On
	banksel	LATA
	bsf	LATA,0
;IF LCDValue >= 100 Then
	movlw	100
	banksel	LCDVALUE
	subwf	LCDVALUE,W
	btfss	STATUS, C
	goto	ENDIF239
;LCDValueTemp = LCDValue / 100
	movf	LCDVALUE,W
	movwf	SysBYTETempA
	movlw	100
	movwf	SysBYTETempB
	pagesel	SysDivSub
	call	SysDivSub
	pagesel	$
	movf	SysBYTETempA,W
	movwf	LCDVALUETEMP
;LCDValue = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	LCDVALUE
;LCDWriteByte(LCDValueTemp + 48)
	movlw	48
	addwf	LCDVALUETEMP,W
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
;End If
ENDIF239
;If LCDValueTemp > 0 Or LCDValue >= 10 Then
	movf	LCDVALUETEMP,W
	movwf	SysBYTETempB
	clrf	SysBYTETempA
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	movf	SysByteTempX,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	banksel	LCDVALUE
	movf	LCDVALUE,W
	movwf	SysBYTETempA
	movlw	10
	movwf	SysBYTETempB
	pagesel	SysCompLessThan
	call	SysCompLessThan
	pagesel	$
	comf	SysByteTempX,F
	banksel	SYSTEMP2
	movf	SysTemp2,W
	iorwf	SysByteTempX,W
	movwf	SysTemp1
	btfss	SysTemp1,0
	goto	ENDIF240
;LCDValueTemp = LCDValue / 10
	banksel	LCDVALUE
	movf	LCDVALUE,W
	movwf	SysBYTETempA
	movlw	10
	movwf	SysBYTETempB
	pagesel	SysDivSub
	call	SysDivSub
	pagesel	$
	movf	SysBYTETempA,W
	movwf	LCDVALUETEMP
;LCDValue = SysCalcTempX
	movf	SYSCALCTEMPX,W
	movwf	LCDVALUE
;LCDWriteByte(LCDValueTemp + 48)
	movlw	48
	addwf	LCDVALUETEMP,W
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
;End If
ENDIF240
;LCDWriteByte (LCDValue + 48)
	movlw	48
	banksel	LCDVALUE
	addwf	LCDVALUE,W
	movwf	LCDBYTE
	goto	LCDNORMALWRITEBYTE

;********************************************************************************

;Overloaded signature: WORD:
PRINT146
;Dim SysCalcTempX As Word
;Set LCD_RS On
	banksel	LATA
	bsf	LATA,0
;LCDValueTemp = 0
	banksel	LCDVALUETEMP
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
	goto	ENDIF241
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
	call	LCDNORMALWRITEBYTE
;Goto LCDPrintWord1000
	goto	LCDPRINTWORD1000
;End If
ENDIF241
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
	goto	ENDIF242
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
	call	LCDNORMALWRITEBYTE
;Goto LCDPrintWord100
	goto	LCDPRINTWORD100
;End If
ENDIF242
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
	goto	ENDIF243
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
	call	LCDNORMALWRITEBYTE
;Goto LCDPrintWord10
	goto	LCDPRINTWORD10
;End If
ENDIF243
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
	goto	ENDIF244
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
	call	LCDNORMALWRITEBYTE
;End If
ENDIF244
;LCDWriteByte (LCDValue + 48)
	movlw	48
	addwf	LCDVALUE,W
	movwf	LCDBYTE
	goto	LCDNORMALWRITEBYTE

;********************************************************************************

;Overloaded signature: LONG:
PRINT148
;Dim SysCalcTempA As Long
;Dim SysPrintBuffer(10)
;SysPrintBuffLen = 0
	banksel	SYSPRINTBUFFLEN
	clrf	SYSPRINTBUFFLEN
;Do
SysDoLoop_S7
;Divide number by 10, remainder into buffer
;SysPrintBuffLen += 1
	banksel	SYSPRINTBUFFLEN
	incf	SYSPRINTBUFFLEN,F
;SysPrintBuffer(SysPrintBuffLen) = LCDValue % 10
	movlw	low(SYSPRINTBUFFER)
	addwf	SYSPRINTBUFFLEN,W
	movwf	AFSR0
	clrf	SysTemp2
	movlw	high(SYSPRINTBUFFER)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	banksel	LCDVALUE
	movf	LCDVALUE,W
	movwf	SysLONGTempA
	movf	LCDVALUE_H,W
	movwf	SysLONGTempA_H
	movf	LCDVALUE_U,W
	movwf	SysLONGTempA_U
	movf	LCDVALUE_E,W
	movwf	SysLONGTempA_E
	movlw	10
	movwf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	call	SysDivSub32
	movf	SysLONGTempX,W
	movwf	INDF0
;LCDValue = SysCalcTempA
	movf	SYSCALCTEMPA,W
	movwf	LCDVALUE
	movf	SYSCALCTEMPA_H,W
	movwf	LCDVALUE_H
	movf	SYSCALCTEMPA_U,W
	movwf	LCDVALUE_U
	movf	SYSCALCTEMPA_E,W
	movwf	LCDVALUE_E
;Loop While LCDValue <> 0
	movf	lcdvalue,W
	movwf	SysLONGTempA
	movf	lcdvalue_H,W
	movwf	SysLONGTempA_H
	movf	lcdvalue_U,W
	movwf	SysLONGTempA_U
	movf	lcdvalue_E,W
	movwf	SysLONGTempA_E
	clrf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	pagesel	SysCompEqual32
	call	SysCompEqual32
	pagesel	$
	comf	SysByteTempX,F
	btfsc	SysByteTempX,0
	goto	SysDoLoop_S7
SysDoLoop_E7
;Display
;Set LCD_RS On
	banksel	LATA
	bsf	LATA,0
;For SysPrintTemp = SysPrintBuffLen To 1 Step -1
	banksel	SYSPRINTBUFFLEN
	incf	SYSPRINTBUFFLEN,W
	movwf	SYSPRINTTEMP
	movlw	1
	subwf	SYSPRINTBUFFLEN,W
	btfss	STATUS, C
	goto	SysForLoopEnd7
ENDIF245
SysForLoop7
	decf	SYSPRINTTEMP,F
;LCDWriteByte(SysPrintBuffer(SysPrintTemp) + 48)
	movlw	low(SYSPRINTBUFFER)
	addwf	SYSPRINTTEMP,W
	movwf	AFSR0
	clrf	SysTemp2
	movlw	high(SYSPRINTBUFFER)
	addwfc	SysTemp2,W
	movwf	AFSR0_H
	movlw	48
	addwf	INDF0,W
	banksel	LCDBYTE
	movwf	LCDBYTE
	call	LCDNORMALWRITEBYTE
;Next
	banksel	SYSPRINTTEMP
	movf	SYSPRINTTEMP,W
	sublw	1
	btfss	STATUS, C
	goto	SysForLoop7
ENDIF246
SysForLoopEnd7
	banksel	STATUS
	return

;********************************************************************************

SHOW_MODE
;If Bit_Mode < Bit_32 Then
	movlw	2
	subwf	BIT_MODE,W
	btfsc	STATUS, C
	goto	ELSE114_1
;Locate 1,6
	movlw	1
	movwf	LCDLINE
	movlw	6
	movwf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;Else
	goto	ENDIF114
ELSE114_1
;Locate 1,15
	movlw	1
	movwf	LCDLINE
	movlw	15
	movwf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;End If
ENDIF114
;Select Case Mode
;Case M_Dec
SysSelect4Case1
	movlw	2
	subwf	MODE,W
	btfss	STATUS, Z
	goto	SysSelect4Case2
;Print "d"
	movlw	low StringTable7
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable7) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	call	PRINT144
;Case M_Bin
	goto	SysSelectEnd4
SysSelect4Case2
	decf	MODE,W
	btfss	STATUS, Z
	goto	SysSelect4Case3
;Print "b"
	movlw	low StringTable21
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable21) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	call	PRINT144
;Case M_Hex
	goto	SysSelectEnd4
SysSelect4Case3
	movlw	3
	subwf	MODE,W
	btfss	STATUS, Z
	goto	SysSelectEnd4
;Print "h"
	movlw	low StringTable6
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable6) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	call	PRINT144
;End Select
SysSelectEnd4
;If Bit_Mode < Bit_32 Then
	movlw	2
	subwf	BIT_MODE,W
	btfsc	STATUS, C
	goto	ELSE115_1
;Locate 1,7
	movlw	1
	movwf	LCDLINE
	movlw	7
	movwf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;Print " "
	movlw	low StringTable4
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable4) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	call	PRINT144
;Else
	goto	ENDIF115
ELSE115_1
;Locate 0,11
	clrf	LCDLINE
	movlw	11
	movwf	LCDCOLUMN
	pagesel	LOCATE
	call	LOCATE
	pagesel	$
;Print "   "
	movlw	low StringTable5
	banksel	SYSPRINTDATAHANDLER
	movwf	SysPRINTDATAHandler
	movlw	(high StringTable5) | 128
	movwf	SysPRINTDATAHandler_H
	banksel	STATUS
	call	PRINT144
;End If
ENDIF115
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
	goto	ENDIF268
;SysWordTempA = 0
	clrf	SYSWORDTEMPA
	clrf	SYSWORDTEMPA_H
;exit sub
	return
;end if
ENDIF268
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
	goto	ENDIF269
;Set SysDivMultA.0 Off
	bcf	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	movf	SYSDIVMULTB,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTB_H,W
	addwfc	SYSDIVMULTX_H,F
;End If
ENDIF269
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
	movf	SYSLONGTEMPA,W
	banksel	SYSLONGDIVMULTA
	movwf	SYSLONGDIVMULTA
	movf	SYSLONGTEMPA_H,W
	movwf	SYSLONGDIVMULTA_H
	movf	SYSLONGTEMPA_U,W
	movwf	SYSLONGDIVMULTA_U
	movf	SYSLONGTEMPA_E,W
	movwf	SYSLONGDIVMULTA_E
;SysLongDivMultB = SysLongTempB
	movf	SYSLONGTEMPB,W
	movwf	SYSLONGDIVMULTB
	movf	SYSLONGTEMPB_H,W
	movwf	SYSLONGDIVMULTB_H
	movf	SYSLONGTEMPB_U,W
	movwf	SYSLONGDIVMULTB_U
	movf	SYSLONGTEMPB_E,W
	movwf	SYSLONGDIVMULTB_E
;SysLongDivMultX = 0
	clrf	SYSLONGDIVMULTX
	clrf	SYSLONGDIVMULTX_H
	clrf	SYSLONGDIVMULTX_U
	clrf	SYSLONGDIVMULTX_E
;Avoid division by zero
;if SysLongDivMultB = 0 then
	movf	SYSLONGDIVMULTB,W
	movwf	SysLONGTempA
	movf	SYSLONGDIVMULTB_H,W
	movwf	SysLONGTempA_H
	movf	SYSLONGDIVMULTB_U,W
	movwf	SysLONGTempA_U
	movf	SYSLONGDIVMULTB_E,W
	movwf	SysLONGTempA_E
	clrf	SysLONGTempB
	clrf	SysLONGTempB_H
	clrf	SysLONGTempB_U
	clrf	SysLONGTempB_E
	banksel	STATUS
	pagesel	SysCompEqual32
	call	SysCompEqual32
	pagesel	$
	btfss	SysByteTempX,0
	goto	ENDIF270
;SysLongTempA = 0
	clrf	SYSLONGTEMPA
	clrf	SYSLONGTEMPA_H
	clrf	SYSLONGTEMPA_U
	clrf	SYSLONGTEMPA_E
;exit sub
	return
;end if
ENDIF270
;Main calc routine
;SysDivLoop = 32
	movlw	32
	movwf	SYSDIVLOOP
SYSDIV32START
;set C off
	bcf	STATUS,C
;Rotate SysLongDivMultA Left
	banksel	SYSLONGDIVMULTA
	rlf	SYSLONGDIVMULTA,F
	rlf	SYSLONGDIVMULTA_H,F
	rlf	SYSLONGDIVMULTA_U,F
	rlf	SYSLONGDIVMULTA_E,F
;Rotate SysLongDivMultX Left
	rlf	SYSLONGDIVMULTX,F
	rlf	SYSLONGDIVMULTX_H,F
	rlf	SYSLONGDIVMULTX_U,F
	rlf	SYSLONGDIVMULTX_E,F
;SysLongDivMultX = SysLongDivMultX - SysLongDivMultB
	movf	SYSLONGDIVMULTB,W
	subwf	SYSLONGDIVMULTX,F
	movf	SYSLONGDIVMULTB_H,W
	subwfb	SYSLONGDIVMULTX_H,F
	movf	SYSLONGDIVMULTB_U,W
	subwfb	SYSLONGDIVMULTX_U,F
	movf	SYSLONGDIVMULTB_E,W
	subwfb	SYSLONGDIVMULTX_E,F
;Set SysLongDivMultA.0 On
	bsf	SYSLONGDIVMULTA,0
;If C Off Then
	btfsc	STATUS,C
	goto	ENDIF271
;Set SysLongDivMultA.0 Off
	bcf	SYSLONGDIVMULTA,0
;SysLongDivMultX = SysLongDivMultX + SysLongDivMultB
	movf	SYSLONGDIVMULTB,W
	addwf	SYSLONGDIVMULTX,F
	movf	SYSLONGDIVMULTB_H,W
	addwfc	SYSLONGDIVMULTX_H,F
	movf	SYSLONGDIVMULTB_U,W
	addwfc	SYSLONGDIVMULTX_U,F
	movf	SYSLONGDIVMULTB_E,W
	addwfc	SYSLONGDIVMULTX_E,F
;End If
ENDIF271
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F
;goto SysDiv32Start
	goto	SYSDIV32START
;SysLongTempA = SysLongDivMultA
	movf	SYSLONGDIVMULTA,W
	movwf	SYSLONGTEMPA
	movf	SYSLONGDIVMULTA_H,W
	movwf	SYSLONGTEMPA_H
	movf	SYSLONGDIVMULTA_U,W
	movwf	SYSLONGTEMPA_U
	movf	SYSLONGDIVMULTA_E,W
	movwf	SYSLONGTEMPA_E
;SysLongTempX = SysLongDivMultX
	movf	SYSLONGDIVMULTX,W
	movwf	SYSLONGTEMPX
	movf	SYSLONGDIVMULTX_H,W
	movwf	SYSLONGTEMPX_H
	movf	SYSLONGDIVMULTX_U,W
	movwf	SYSLONGTEMPX_U
	movf	SYSLONGDIVMULTX_E,W
	movwf	SYSLONGTEMPX_E
	banksel	STATUS
	return

;********************************************************************************

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
	movf	SYSLONGTEMPA,W
	banksel	SYSLONGDIVMULTA
	movwf	SYSLONGDIVMULTA
	movf	SYSLONGTEMPA_H,W
	movwf	SYSLONGDIVMULTA_H
	movf	SYSLONGTEMPA_U,W
	movwf	SYSLONGDIVMULTA_U
	movf	SYSLONGTEMPA_E,W
	movwf	SYSLONGDIVMULTA_E
;SysLongDivMultB = SysLongTempB
	movf	SYSLONGTEMPB,W
	movwf	SYSLONGDIVMULTB
	movf	SYSLONGTEMPB_H,W
	movwf	SYSLONGDIVMULTB_H
	movf	SYSLONGTEMPB_U,W
	movwf	SYSLONGDIVMULTB_U
	movf	SYSLONGTEMPB_E,W
	movwf	SYSLONGDIVMULTB_E
;SysLongDivMultX = 0
	clrf	SYSLONGDIVMULTX
	clrf	SYSLONGDIVMULTX_H
	clrf	SYSLONGDIVMULTX_U
	clrf	SYSLONGDIVMULTX_E
MUL32LOOP
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
	banksel	SYSLONGDIVMULTB
	btfss	SYSLONGDIVMULTB,0
	goto	ENDIF266
	movf	SYSLONGDIVMULTA,W
	addwf	SYSLONGDIVMULTX,F
	movf	SYSLONGDIVMULTA_H,W
	addwfc	SYSLONGDIVMULTX_H,F
	movf	SYSLONGDIVMULTA_U,W
	addwfc	SYSLONGDIVMULTX_U,F
	movf	SYSLONGDIVMULTA_E,W
	addwfc	SYSLONGDIVMULTX_E,F
ENDIF266
;set STATUS.C OFF
	bcf	STATUS,C
;rotate SysLongDivMultB right
	rrf	SYSLONGDIVMULTB_E,F
	rrf	SYSLONGDIVMULTB_U,F
	rrf	SYSLONGDIVMULTB_H,F
	rrf	SYSLONGDIVMULTB,F
;set STATUS.C off
	bcf	STATUS,C
;rotate SysLongDivMultA left
	rlf	SYSLONGDIVMULTA,F
	rlf	SYSLONGDIVMULTA_H,F
	rlf	SYSLONGDIVMULTA_U,F
	rlf	SYSLONGDIVMULTA_E,F
;if SysLongDivMultB > 0 then goto MUL32LOOP
	movf	SYSLONGDIVMULTB,W
	movwf	SysLONGTempB
	movf	SYSLONGDIVMULTB_H,W
	movwf	SysLONGTempB_H
	movf	SYSLONGDIVMULTB_U,W
	movwf	SysLONGTempB_U
	movf	SYSLONGDIVMULTB_E,W
	movwf	SysLONGTempB_E
	clrf	SysLONGTempA
	clrf	SysLONGTempA_H
	clrf	SysLONGTempA_U
	clrf	SysLONGTempA_E
	banksel	STATUS
	pagesel	SysCompLessThan32
	call	SysCompLessThan32
	pagesel	$
	btfsc	SysByteTempX,0
	goto	MUL32LOOP
ENDIF267
;SysLongTempX = SysLongDivMultX
	banksel	SYSLONGDIVMULTX
	movf	SYSLONGDIVMULTX,W
	movwf	SYSLONGTEMPX
	movf	SYSLONGDIVMULTX_H,W
	movwf	SYSLONGTEMPX_H
	movf	SYSLONGDIVMULTX_U,W
	movwf	SYSLONGTEMPX_U
	movf	SYSLONGDIVMULTX_E,W
	movwf	SYSLONGTEMPX_E
	banksel	STATUS
	return

;********************************************************************************

;Start of program memory page 3
	ORG	6144
CHECK_MODULO
;Wait 50 mS
	movlw	50
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;If Button_Value = BtDi Then
	movlw	19
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	ELSE135_1
;Wait 100 mS
	movlw	100
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
;Get_Buttons
	pagesel	GET_BUTTONS
	call	GET_BUTTONS
	pagesel	$
;If Button_Value = BtDi Then
	movlw	19
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	ELSE136_1
;Wait 100 mS
	movlw	100
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
;Get_Buttons
	pagesel	GET_BUTTONS
	call	GET_BUTTONS
	pagesel	$
;If Button_Value = BtDi Then
	movlw	19
	subwf	BUTTON_VALUE,W
	btfss	STATUS, Z
	goto	ELSE137_1
;Let Button_Value = BtModulo
	movlw	22
	movwf	BUTTON_VALUE
;Else
	goto	ENDIF137
ELSE137_1
;Let Button_Value = BtDi
	movlw	19
	movwf	BUTTON_VALUE
;End If
ENDIF137
;Else
	goto	ENDIF136
ELSE136_1
;Let Button_Value = BtDi
	movlw	19
	movwf	BUTTON_VALUE
;End If
ENDIF136
;Else
	goto	ENDIF135
ELSE135_1
;Let Button_Value = BtDi
	movlw	19
	movwf	BUTTON_VALUE
;End If
ENDIF135
	return

;********************************************************************************

CLS
;SET LCD_RS OFF
	banksel	LATA
	bcf	LATA,0
;Clear screen
;LCDWriteByte (0b00000001)
	movlw	1
	banksel	LCDBYTE
	movwf	LCDBYTE
	pagesel	LCDNORMALWRITEBYTE
	call	LCDNORMALWRITEBYTE
	pagesel	$
;Wait 4 ms
	movlw	4
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;Move to start of visible DDRAM
;LCDWriteByte(0x80)
	movlw	128
	movwf	LCDBYTE
	pagesel	LCDNORMALWRITEBYTE
	call	LCDNORMALWRITEBYTE
	pagesel	$
;Wait 12 10us
	movlw	12
	movwf	SysWaitTemp10US
	goto	Delay_10US

;********************************************************************************

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

EPWRITE
;Variable alias
;Dim EEAddress As Word Alias EEADRH, EEADR
;Dim EEDataValue Alias EEDATL_REF
;Disable interrupt
;IntOff
	banksel	SYSINTSTATESAVE0
	bcf	SYSINTSTATESAVE0,1
	btfsc	INTCON,GIE
	bsf	SYSINTSTATESAVE0,1
ENDIF278
	bcf	INTCON,GIE
;Select data memory
;SET EEPGD OFF
	banksel	EECON1
	bcf	EECON1,EEPGD
;Set CFGS OFF
	bcf	EECON1,CFGS
;Start write
;SET WREN ON
	bsf	EECON1,WREN
;EECON2 = 0x55
	movlw	85
	movwf	EECON2
;EECON2 = 0xAA
	movlw	170
	movwf	EECON2
;SET WR ON
	bsf	EECON1,WR
;SET WREN OFF
	bcf	EECON1,WREN
;Wait for write to complete
;WAIT WHILE WR ON
SysWaitLoop1
	btfsc	EECON1,WR
	goto	SysWaitLoop1
;SET WREN OFF
	bcf	EECON1,WREN
;Restore interrupt
;IntOn
	banksel	SYSINTSTATESAVE0
	btfss	SYSINTSTATESAVE0,1
	bcf	INTCON,GIE
ENDIF279
	btfsc	SYSINTSTATESAVE0,1
	bsf	INTCON,GIE
ENDIF280
	banksel	STATUS
	return

;********************************************************************************

GET_ZEROVALUE
;Select Case Mode
;Case M_Dec
SysSelect6Case1
	movlw	2
	subwf	MODE,W
	btfss	STATUS, Z
	goto	SysSelect6Case2
;Let Zero_Value = 10
	movlw	10
	banksel	ZERO_VALUE
	movwf	ZERO_VALUE
;Case M_Bin
	goto	SysSelectEnd6
SysSelect6Case2
	decf	MODE,W
	btfss	STATUS, Z
	goto	SysSelect6Case3
;Let Zero_Value = 2
	movlw	2
	banksel	ZERO_VALUE
	movwf	ZERO_VALUE
;Case M_Hex
	goto	SysSelectEnd6
SysSelect6Case3
	movlw	3
	subwf	MODE,W
	btfss	STATUS, Z
	goto	SysSelectEnd6
;Let Zero_Value = 16
	movlw	16
	banksel	ZERO_VALUE
	movwf	ZERO_VALUE
;End Select
SysSelectEnd6
	banksel	STATUS
	return

;********************************************************************************

;Overloaded signature: BYTE:BYTE:
INITTIMER0190
;Some PICS (18F+) Use T0CON for timer0 Control
;ALL OTHER PICS USE OPTION_REG for timer0 control
;Sub modified to set all TMR Control bits at once
;* TMRPres, TMRSource & TMRPost now shared *
;if TMRPRes > 7 then TMRPRes = 0 'failsafe
	banksel	TMRPRES
	movf	TMRPRES,W
	sublw	7
	btfss	STATUS, C
	clrf	TMRPRES
ENDIF273
;If Timer0 is 16-bit capable
;Re-Use TMRPres as T0CON Temp_register
;Keep T0CON 7:6 and write bits 2:0 from TMRPres
;Bits 5,4 & 3 will be cleared!
;TMRPres = (OPTION_REG AND 192) OR TMRPres
	movlw	192
	andwf	OPTION_REG,W
	movwf	SysTemp1
	iorwf	TMRPRES,F
;IF TMRSource = EXT then
	movlw	2
	subwf	TMRSOURCE,W
	btfss	STATUS, Z
	goto	ELSE274_1
;Set TMRPres.5 ON   'EXT
	bsf	TMRPRES,5
;ELSE
	goto	ENDIF274
ELSE274_1
;Set TMRPres.5 OFF  'OSC
	bcf	TMRPRES,5
;END IF
ENDIF274
;Now Write the OPTION_REG
;OPTION_REG = TMRPres
	movf	TMRPRES,W
	movwf	OPTION_REG
;Added For baseline Chips with write only option_reg
;If Timer0 is 16-bit capable
	banksel	STATUS
	return

;********************************************************************************

FN_LCDREADY
;Wait 10 ms
	movlw	10
	movwf	SysWaitTempMS
	clrf	SysWaitTempMS_H
	pagesel	Delay_MS
	call	Delay_MS
	pagesel	$
;LCDReady = TRUE
	movlw	255
	movwf	LCDREADY
;exit function
	return
	return

;********************************************************************************

LCDWRITECHAR
;set LCD_RS on
	banksel	LATA
	bsf	LATA,0
;LCDWriteByte(LCDChar)
	banksel	LCDCHAR
	movf	LCDCHAR,W
	movwf	LCDBYTE
	pagesel	LCDNORMALWRITEBYTE
	call	LCDNORMALWRITEBYTE
	pagesel	$
;wait 5 10us
	return

;********************************************************************************

LOCATE
;Set LCD_RS Off
	banksel	LATA
	bcf	LATA,0
;If LCDLine > 1 Then
	banksel	LCDLINE
	movf	LCDLINE,W
	sublw	1
	btfsc	STATUS, C
	goto	ENDIF235
;LCDLine = LCDLine - 2
	movlw	2
	subwf	LCDLINE,F
;LCDColumn = LCDColumn + LCD_WIDTH
	movlw	20
	addwf	LCDCOLUMN,F
;End If
ENDIF235
;LCDWriteByte(0x80 or 0x40 * LCDLine + LCDColumn)
	movf	LCDLINE,W
	movwf	SysBYTETempA
	movlw	64
	movwf	SysBYTETempB
	call	SysMultSub
	movf	LCDCOLUMN,W
	addwf	SysBYTETempX,W
	banksel	SYSTEMP2
	movwf	SysTemp2
	movlw	128
	iorwf	SysTemp2,W
	banksel	LCDBYTE
	movwf	LCDBYTE
	pagesel	LCDNORMALWRITEBYTE
	call	LCDNORMALWRITEBYTE
	pagesel	$
;wait 5 10us 'test
	movlw	5
	movwf	SysWaitTemp10US
	goto	Delay_10US

;********************************************************************************

FN_MILLIS
;dim Millis, MsCtr_ as long
;disable interrupts while we read millis or we might get an
;inconsistent value (e.g. in the middle of a write to millis)
;IntOff
	banksel	SYSINTSTATESAVE0
	bcf	SYSINTSTATESAVE0,0
	btfsc	INTCON,GIE
	bsf	SYSINTSTATESAVE0,0
ENDIF275
	bcf	INTCON,GIE
;Millis = MsCtr_
	banksel	MSCTR_
	movf	MSCTR_,W
	movwf	MILLIS
	movf	MSCTR__H,W
	movwf	MILLIS_H
	movf	MSCTR__U,W
	movwf	MILLIS_U
	movf	MSCTR__E,W
	movwf	MILLIS_E
;IntOn
	banksel	SYSINTSTATESAVE0
	btfss	SYSINTSTATESAVE0,0
	bcf	INTCON,GIE
ENDIF276
	btfsc	SYSINTSTATESAVE0,0
	bsf	INTCON,GIE
ENDIF277
	banksel	STATUS
	return

;********************************************************************************

MSCTR_INT_HDLR
;dim MsCtr_ as Long
;asm ShowDebug Call_SetTimer_Millis_macro
;call_settimer_millis_macro
;SetTimer_Millis  Tmr0InitVal   ' Reset Inital Counter valueue
;Handle chips withOUT TMR0H
;TMR0 = TMRValueMillis
	movlw	6
	movwf	TMR0
;MsCtr_ = MsCtr_ + 1
	incf	MSCTR_,F
	btfsc	STATUS,Z
	incf	MSCTR__H,F
	btfsc	STATUS,Z
	incf	MSCTR__U,F
	btfsc	STATUS,Z
	incf	MSCTR__E,F
	return

;********************************************************************************

FN_RANDOM
;Repeat 7
	movlw	7
	banksel	SYSREPEATTEMP2
	movwf	SysRepeatTemp2
SysRepeatLoop2
;Dim RandomTemp As Word
;Dim RandomSeed As Word
;RandomTemp = RandomSeed
	movf	RANDOMSEED,W
	movwf	RANDOMTEMP
	movf	RANDOMSEED_H,W
	movwf	RANDOMTEMP_H
;Rotate RandomTemp Left Simple
	rlf	RANDOMTEMP_H,W
	rlf	RANDOMTEMP,F
	rlf	RANDOMTEMP_H,F
;Taps at 16, 15, 13, 11, And with b'1101 0100 0000 0000' = D800
;RandomSeed = RandomTemp XOR (Not (RandomSeed And 1) + 1 And 0xB400)
	movlw	1
	andwf	RANDOMSEED,W
	movwf	SysTemp1
	clrf	SysTemp1_H
	comf	SysTemp1,W
	movwf	SysTemp2
	comf	SysTemp1_H,W
	movwf	SysTemp2_H
	incf	SysTemp2,F
	btfsc	STATUS,Z
	incf	SysTemp2_H,F
	clrf	SysTemp1
	movlw	180
	andwf	SysTemp2_H,W
	movwf	SysTemp1_H
	movf	RANDOMTEMP,W
	xorwf	SysTemp1,W
	movwf	RANDOMSEED
	movf	RANDOMTEMP_H,W
	xorwf	SysTemp1_H,W
	movwf	RANDOMSEED_H
;Random = Random Xor RandomSeed_H
	movf	RANDOM,W
	xorwf	RANDOMSEED_H,W
	movwf	RANDOM
;End Repeat
	decfsz	SysRepeatTemp2,F
	goto	SysRepeatLoop2
SysRepeatLoopEnd2
	banksel	STATUS
	return

;********************************************************************************

RANDOMIZE
;Dim RandomSeed As Word
;RandomSeed += RandomTemp
	banksel	RANDOMTEMP
	movf	RANDOMTEMP,W
	addwf	RANDOMSEED,F
	movf	RANDOMTEMP_H,W
	addwfc	RANDOMSEED_H,F
;If random seed gets set to 0, Random will return nothing but 0
;If RandomSeed = 0 Then RandomSeed = 1
	movf	RANDOMSEED,W
	movwf	SysWORDTempA
	movf	RANDOMSEED_H,W
	movwf	SysWORDTempA_H
	clrf	SysWORDTempB
	clrf	SysWORDTempB_H
	banksel	STATUS
	call	SysCompEqual16
	btfss	SysByteTempX,0
	goto	ENDIF272
	movlw	1
	banksel	RANDOMSEED
	movwf	RANDOMSEED
	clrf	RANDOMSEED_H
ENDIF272
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

SYSCOMPEQUAL32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;Test low, exit if false
;movf SysLongTempA, W
	movf	SYSLONGTEMPA, W
;subwf SysLongTempB, W
	subwf	SYSLONGTEMPB, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;Test high, exit if false
;movf SysLongTempA_H, W
	movf	SYSLONGTEMPA_H, W
;subwf SysLongTempB_H, W
	subwf	SYSLONGTEMPB_H, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;Test upper, exit if false
;movf SysLongTempA_U, W
	movf	SYSLONGTEMPA_U, W
;subwf SysLongTempB_U, W
	subwf	SYSLONGTEMPB_U, W
;btfss STATUS, Z
	btfss	STATUS, Z
;return
	return
;Test exp, exit if false
;movf SysLongTempA_E, W
	movf	SYSLONGTEMPA_E, W
;subwf SysLongTempB_E, W
	subwf	SYSLONGTEMPB_E, W
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

SYSCOMPLESSTHAN32
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX
;Test Exp, exit if more
;movf SysLongTempA_E,W
	movf	SYSLONGTEMPA_E,W
;subwf SysLongTempB_E,W
	subwf	SYSLONGTEMPB_E,W
;btfss STATUS,C
	btfss	STATUS,C
;return
	return
;If not more and not zero, is less
;btfss STATUS,Z
	btfss	STATUS,Z
;goto SCLT32True
	goto	SCLT32TRUE
;Test Upper, exit if more
;movf SysLongTempA_U,W
	movf	SYSLONGTEMPA_U,W
;subwf SysLongTempB_U,W
	subwf	SYSLONGTEMPB_U,W
;btfss STATUS,C
	btfss	STATUS,C
;return
	return
;If not more and not zero, is less
;btfss STATUS,Z
	btfss	STATUS,Z
;goto SCLT32True
	goto	SCLT32TRUE
;Test High, exit if more
;movf SysLongTempA_H,W
	movf	SYSLONGTEMPA_H,W
;subwf SysLongTempB_H,W
	subwf	SYSLONGTEMPB_H,W
;btfss STATUS,C
	btfss	STATUS,C
;return
	return
;If not more and not zero, is less
;btfss STATUS,Z
	btfss	STATUS,Z
;goto SCLT32True
	goto	SCLT32TRUE
;Test Low, exit if more or equal
;movf SysLongTempB,W
	movf	SYSLONGTEMPB,W
;subwf SysLongTempA,W
	subwf	SYSLONGTEMPA,W
;btfsc STATUS,C
	btfsc	STATUS,C
;return
	return
SCLT32TRUE
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

SYSEPREAD
;Variable alias
;Dim EEAddress As Word Alias EEADRH, EEADR
;Dim EEDataValue Alias EEDATL_REF
;Disable interrupt
;IntOff
	banksel	SYSINTSTATESAVE0
	bcf	SYSINTSTATESAVE0,2
	btfsc	INTCON,GIE
	bsf	SYSINTSTATESAVE0,2
ENDIF281
	bcf	INTCON,GIE
;Select data memory
;SET EEPGD OFF
	banksel	EECON1
	bcf	EECON1,EEPGD
;Set CFGS OFF
	bcf	EECON1,CFGS
;Read
;SET RD ON
	bsf	EECON1,RD
;Restore interrupt
;IntOn
	banksel	SYSINTSTATESAVE0
	btfss	SYSINTSTATESAVE0,2
	bcf	INTCON,GIE
ENDIF282
	btfsc	SYSINTSTATESAVE0,2
	bsf	INTCON,GIE
ENDIF283
	banksel	STATUS
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
	goto	ENDIF264
	movf	SYSDIVMULTA,W
	addwf	SYSDIVMULTX,F
	movf	SYSDIVMULTA_H,W
	addwfc	SYSDIVMULTX_H,F
ENDIF264
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
ENDIF265
;SysWordTempX = SysDivMultX
	movf	SYSDIVMULTX,W
	movwf	SYSWORDTEMPX
	movf	SYSDIVMULTX_H,W
	movwf	SYSWORDTEMPX_H
	return

;********************************************************************************


 END
