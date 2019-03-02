;Program compiled by Great Cow BASIC (0.98.<<>> 2019-02-14 (Windows 32 bit))
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
.EQU	AMBIENT=306
.EQU	AMBIENT_H=307
.EQU	COMPORT=308
.EQU	CTR=309
.EQU	DA=287
.EQU	DEVERROR=310
.EQU	DISTANCE=311
.EQU	DISTANCE_H=312
.EQU	HI2CACKPOLLSTATE=313
.EQU	HI2CCURRENTMODE=314
.EQU	HI2CGETACK=315
.EQU	HI2CSTARTOCCURRED=316
.EQU	HI2CWAITMSSPTIMEOUT=317
.EQU	HSERPRINTCRLFCOUNT=318
.EQU	I2CBYTE=319
.EQU	PRINTLEN=320
.EQU	SERDATA=321
.EQU	SIGNAL=322
.EQU	SIGNAL_H=323
.EQU	SPAD=324
.EQU	SPAD_H=325
.EQU	STR=300
.EQU	STRINGPOINTER=326
.EQU	SYSCHARCOUNT=327
.EQU	SYSPRINTDATAHANDLER=328
.EQU	SYSPRINTDATAHANDLER_H=329
.EQU	SYSPRINTTEMP=330
.EQU	SYSREPEATTEMP1=331
.EQU	SYSSTRDATA=332
.EQU	SYSSTRINGPARAM1=256
.EQU	SYSVALTEMP=333
.EQU	SYSVALTEMP_H=334
.EQU	TMP=335

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
.DEF	SYSTEMP2=r16
.DEF	SYSTEMP3=r17

;********************************************************************************

;Alias variables
#define	SYSDA_1	288
#define	SYSDA_10	297
#define	SYSDA_11	298
#define	SYSDA_12	299
#define	SYSDA_3	290
#define	SYSDA_4	291
#define	SYSDA_7	294
#define	SYSDA_8	295
#define	SYSDA_9	296
#define	SYSSTR_0	300

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
	rcall	HIC2INIT

;Start of the main program
;vl53l0x converted from picaxe
;#define W_ADDRESS 0xEC
;#define R_ADDRESS 0xED
;#define HI2C_BAUD_RATE 400
;#define HI2C_DATA PORTC.5
;#define HI2C_CLOCK PORTC.4
;HI2CMode Master
	ldi	SysValueCopy,12
	sts	HI2CCURRENTMODE,SysValueCopy
	rcall	AVRHI2CMODE
;#define USART_BAUD_RATE 9600
;#define USART_TX_BLOCKING
;#define USART_DELAY 10 ms
;VL53L0x Registers Write and Read
;No.  Command Return value  Description
;1    0XA0    BYTE1,BYTE2   Word output mode, the output distance is (BYTE1 < 8) &BYTE2;
;the conversion to 10 is the actual measurement distance, the unit is mm
;2    0XA1    BYTE1,BYTE2   VL53L0X initialization (initialization time is 500mS)
;3    0XB0    0XB0      The module baud rate is set to 9600, and it takes effect in time (default)
;4    0XB1    0XB1      The module baud rate is set to 19200, and it takes effect in time
;5    0XB2    0XB2      The module baud rate is set to 115200, and it takes effect in time
;6    0XC0    0XC0      Set up as a long distance measurement mode (default)
;7    0XC1    0XC1      Set up as a high-speed measurement model
;8    0XC2    0XC2      Set to high precision measurement mode (measurement interval is greater than 180mS)
;9    0XD0    0XD0      Set XSHUT to high level, module work normally and initialize module
;10         0XD1          0XD1      Setting XSHUT to low level, VL53L0X closes
;11         0XF0            BYTE1--BYTE4          Current baud rate (MSB)
;BYTE5  0X00 long distance mode                                                    0X01 high speed measurement mode
;0X02 high precision measurement mode
;BYTE6  The status of the current XSHUT
;dim da(12) as byte
;Symbol Da1        = b10
;Symbol Da2        = b11
;Symbol Da3        = b12
;Symbol Da4        = b13
;Symbol Da5        = b14
;Symbol Da6        = b15
;Symbol Da7        = b16
;Symbol Da8        = b17
;Symbol Da9        = b18
;Symbol Da10       = b19
;Symbol Da11       = b20
;Symbol Da12       = b21
;
;Symbol devError   = b22
;Symbol datoVL   = b23
;Symbol Distance   = w12
;Symbol Signal   = w13
;Symbol SPAD     = w14
;Symbol Ambient    = w15
;dim devError,datoVL,tmp,addr,ctr as byte
;dim Distance,Signal,SPAD,Ambient as word
;hi2csetup I2CMASTER, $52, i2cfast, i2cbyte
;do
SysDoLoop_S1:
;hi2cin $C0,(b0)
;HI2CStart
	rcall	AVRHI2CSTART
;HI2CSend(W_ADDRESS)
	ldi	SysValueCopy,236
	sts	I2CBYTE,SysValueCopy
	rcall	AVRHI2CSEND
;HI2CReStart
;HI2CSend(W_ADDRESS+1)               ;indicate a read operation
	ldi	SysValueCopy,237
	sts	I2CBYTE,SysValueCopy
	rcall	AVRHI2CSEND
;HI2CSend(0xc0)
	ldi	SysValueCopy,192
	sts	I2CBYTE,SysValueCopy
	rcall	AVRHI2CSEND
;HI2CReceive tmp, NACK
	ldi	SysValueCopy,0
	sts	HI2CGETACK,SysValueCopy
	rcall	AVRHI2CRECEIVE
	lds	SysValueCopy,I2CBYTE
	sts	TMP,SysValueCopy
;HI2CStop
	rcall	AVRHI2CSTOP
;sertxd (b0,cr,lf) ' EE
;hserprint str(tmp)
	lds	SysValueCopy,TMP
	sts	SYSVALTEMP,SysValueCopy
	ldi	SysValueCopy,0
	sts	SYSVALTEMP_H,SysValueCopy
	rcall	FN_STR
	ldi	SysValueCopy,low(STR)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(STR)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT256
;pause 10
;wait 10 ms
	ldi	SysWaitTempMS,10
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;hi2cin $C1,(b0)
;HI2CStart
	rcall	AVRHI2CSTART
;HI2CSend(W_ADDRESS)
	ldi	SysValueCopy,236
	sts	I2CBYTE,SysValueCopy
	rcall	AVRHI2CSEND
;HI2CReStart
;HI2CSend(W_ADDRESS+1)               ;indicate a read operation
	ldi	SysValueCopy,237
	sts	I2CBYTE,SysValueCopy
	rcall	AVRHI2CSEND
;HI2CSend(0xc1)
	ldi	SysValueCopy,193
	sts	I2CBYTE,SysValueCopy
	rcall	AVRHI2CSEND
;HI2CReceive tmp, NACK
	ldi	SysValueCopy,0
	sts	HI2CGETACK,SysValueCopy
	rcall	AVRHI2CRECEIVE
	lds	SysValueCopy,I2CBYTE
	sts	TMP,SysValueCopy
;HI2CStop
	rcall	AVRHI2CSTOP
;sertxd (b0,cr,lf) ' AA
;hserprint str(tmp)
	lds	SysValueCopy,TMP
	sts	SYSVALTEMP,SysValueCopy
	ldi	SysValueCopy,0
	sts	SYSVALTEMP_H,SysValueCopy
	rcall	FN_STR
	ldi	SysValueCopy,low(STR)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(STR)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT256
;pause 10
;wait 10 ms
	ldi	SysWaitTempMS,10
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;hi2cin $C2,(b0)
;HI2CStart
	rcall	AVRHI2CSTART
;HI2CSend(W_ADDRESS)
	ldi	SysValueCopy,236
	sts	I2CBYTE,SysValueCopy
	rcall	AVRHI2CSEND
;HI2CReStart
;HI2CSend(W_ADDRESS+1)               ;indicate a read operation
	ldi	SysValueCopy,237
	sts	I2CBYTE,SysValueCopy
	rcall	AVRHI2CSEND
;HI2CSend(0xc2)
	ldi	SysValueCopy,194
	sts	I2CBYTE,SysValueCopy
	rcall	AVRHI2CSEND
;HI2CReceive tmp, NACK
	ldi	SysValueCopy,0
	sts	HI2CGETACK,SysValueCopy
	rcall	AVRHI2CRECEIVE
	lds	SysValueCopy,I2CBYTE
	sts	TMP,SysValueCopy
;HI2CStop
	rcall	AVRHI2CSTOP
;sertxd (b0,cr,lf) ' 10
;hserprint str(tmp)
	lds	SysValueCopy,TMP
	sts	SYSVALTEMP,SysValueCopy
	ldi	SysValueCopy,0
	sts	SYSVALTEMP_H,SysValueCopy
	rcall	FN_STR
	ldi	SysValueCopy,low(STR)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(STR)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT256
;pause 1000
;wait 1 s
	ldi	SysWaitTempS,1
	rcall	Delay_S
;Soft reset
;hi2cout $89,($01)
;HI2CStart
	rcall	AVRHI2CSTART
;hi2cSEND W_ADDRESS
	ldi	SysValueCopy,236
	sts	I2CBYTE,SysValueCopy
	rcall	AVRHI2CSEND
;hi2cSEND 0x89
	ldi	SysValueCopy,137
	sts	I2CBYTE,SysValueCopy
	rcall	AVRHI2CSEND
;hi2cSEND 1
	ldi	SysValueCopy,1
	sts	I2CBYTE,SysValueCopy
	rcall	AVRHI2CSEND
;HI2CStop
	rcall	AVRHI2CSTOP
;pause 200
;wait 200 ms
	ldi	SysWaitTempMS,200
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;Sys range start
;hi2cout $00,($01)
;HI2CStart
	rcall	AVRHI2CSTART
;hi2cSEND W_ADDRESS
	ldi	SysValueCopy,236
	sts	I2CBYTE,SysValueCopy
	rcall	AVRHI2CSEND
;hi2cSEND ( 0 )
	ldi	SysValueCopy,0
	sts	I2CBYTE,SysValueCopy
	rcall	AVRHI2CSEND
;hi2cSEND ( 1 )
	ldi	SysValueCopy,1
	sts	I2CBYTE,SysValueCopy
	rcall	AVRHI2CSEND
;HI2CStop
	rcall	AVRHI2CSTOP
;pause 50
;Read 12 raw data of Sensor:
;hi2cin $14,(da1,da2,da3,da4,da5,da6,da7,da8,da9,da10,da11,da12)
;HI2CStart
	rcall	AVRHI2CSTART
;Request value
;HI2CSend(W_ADDRESS)
	ldi	SysValueCopy,236
	sts	I2CBYTE,SysValueCopy
	rcall	AVRHI2CSEND
;HI2CReStart
;HI2CSend(W_ADDRESS+1)               ;indicate a read operation
	ldi	SysValueCopy,237
	sts	I2CBYTE,SysValueCopy
	rcall	AVRHI2CSEND
;HI2CSend(0x14)
	ldi	SysValueCopy,20
	sts	I2CBYTE,SysValueCopy
	rcall	AVRHI2CSEND
;For tmp=1 to 12
	ldi	SysValueCopy,0
	sts	TMP,SysValueCopy
SysForLoop1:
	lds	SysTemp1,TMP
	inc	SysTemp1
	sts	TMP,SysTemp1
;HI2CReceive da( tmp ), ACK
	ldi	SysValueCopy,255
	sts	HI2CGETACK,SysValueCopy
	rcall	AVRHI2CRECEIVE
	lds	SysTemp1,TMP
	ldi	SysTemp2,low(DA)
	add	SysTemp1,SysTemp2
	mov	SysStringA,SysTemp1
	ldi	SysTemp2,0
	ldi	SysTemp3,high(DA)
	adc	SysTemp2,SysTemp3
	mov	SysStringA_H,SysTemp2
	lds	SysValueCopy,I2CBYTE
	st	X,SysValueCopy
;next tmp
	lds	SysCalcTempA,TMP
	cpi	SysCalcTempA,12
	brlo	SysForLoop1
SysForLoopEnd1:
;HI2CReceive da( 12  ), NACK
;HI2CStop
	rcall	AVRHI2CSTOP
;sertxd (#da1," ",#da2," ",#da3," ",#da4," ",#da5," ",#da6," ",#da7," ",#da8," ",#da9," ",#da10," ",#da11," ",#da12,cr,lf)
;for ctr=1 to 12
	ldi	SysValueCopy,0
	sts	CTR,SysValueCopy
SysForLoop2:
	lds	SysTemp1,CTR
	inc	SysTemp1
	sts	CTR,SysTemp1
;hserprint str(da(ctr))+" , "
	ldi	SysTemp2,low(DA)
	add	SysTemp1,SysTemp2
	mov	SysStringA,SysTemp1
	ldi	SysTemp2,0
	ldi	SysTemp3,high(DA)
	adc	SysTemp2,SysTemp3
	mov	SysStringA_H,SysTemp2
	ld	SysValueCopy,X
	sts	SYSVALTEMP,SysValueCopy
	ldi	SysValueCopy,0
	sts	SYSVALTEMP_H,SysValueCopy
	rcall	FN_STR
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysStringA,low(STR)
	ldi	SysStringA_H,high(STR)
	rcall	SysCopyStringPart
	ldi	SysReadA,low(StringTable1<<1)
	ldi	SysReadA_H,high(StringTable1<<1)
	rcall	SysReadStringPart
	ldi	SysStringA,low(SYSSTRINGPARAM1)
	ldi	SysStringA_H,high(SYSSTRINGPARAM1)
	st	X, SysStringLength
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT256
;next ctr
	lds	SysCalcTempA,CTR
	cpi	SysCalcTempA,12
	brlo	SysForLoop2
SysForLoopEnd2:
;hserprintcrlf
	ldi	SysValueCopy,1
	sts	HSERPRINTCRLFCOUNT,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINTCRLF
;Resolve sensor errors
;devError = (Da(1) and 0x78)/8 ;>> 3 ' // Check for errors
	ldi	SysTemp2,120
	lds	SysTemp3,SYSDA_1
	and	SysTemp3,SysTemp2
	mov	SysTemp1,SysTemp3
	mov	SysBYTETempA,SysTemp1
	ldi	SysBYTETempB,8
	rcall	SysDivSub
	sts	DEVERROR,SysBYTETempA
;hserprint "Status: "
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable2<<1)
	ldi	SysReadA_H,high(StringTable2<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT256
;sertxd("Status: ")
;hserprint str(tmp)
;If devError = $00 Then  sertxd ("Data OK!") : endif  ' No device error
;If devError = 0 Then hserprint "Data OK!"
	lds	SysCalcTempA,DEVERROR
	tst	SysCalcTempA
	brne	ENDIF3
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable3<<1)
	ldi	SysReadA_H,high(StringTable3<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT256
ENDIF3:
;If devError = $01 Then  sertxd ("VCSEL CONTINUITY TEST FAILURE!") : endif
;If devError = 1 Then hserprint "VCSEL CONTINUITY TEST FAILURE!"
	lds	SysCalcTempA,DEVERROR
	cpi	SysCalcTempA,1
	brne	ENDIF4
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable4<<1)
	ldi	SysReadA_H,high(StringTable4<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT256
ENDIF4:
;If devError = $02 Then  sertxd ("VCSEL WATCHDOG TEST FAILURE!") : endif
;If devError = 2 Then hserprint "VCSEL WATCHDOG TEST FAILURE!"
	lds	SysCalcTempA,DEVERROR
	cpi	SysCalcTempA,2
	brne	ENDIF5
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable5<<1)
	ldi	SysReadA_H,high(StringTable5<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT256
ENDIF5:
;If devError = $03 Then  sertxd ("NO VHV VALUE FOUND!") : endif
;If devError = 3 Then hserprint "NO VHV VALUE FOUND!"
	lds	SysCalcTempA,DEVERROR
	cpi	SysCalcTempA,3
	brne	ENDIF6
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable6<<1)
	ldi	SysReadA_H,high(StringTable6<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT256
ENDIF6:
;If devError = $04 Then  sertxd ("MSRC NO TARGET!") : endif
;If devError = 4 Then hserprint "MSRC NO TARGET!"
	lds	SysCalcTempA,DEVERROR
	cpi	SysCalcTempA,4
	brne	ENDIF7
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable7<<1)
	ldi	SysReadA_H,high(StringTable7<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT256
ENDIF7:
;If devError = $05 Then  sertxd ("SNR CHECK!") : endif
;If devError = 5 Then hserprint "SNR CHECK!"
	lds	SysCalcTempA,DEVERROR
	cpi	SysCalcTempA,5
	brne	ENDIF8
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable8<<1)
	ldi	SysReadA_H,high(StringTable8<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT256
ENDIF8:
;If devError = $06 Then  sertxd ("RANGE PHASE CHECK!") : endif
;If devError = 6 Then hserprint "RANGE PHASE CHECK!"
	lds	SysCalcTempA,DEVERROR
	cpi	SysCalcTempA,6
	brne	ENDIF9
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable9<<1)
	ldi	SysReadA_H,high(StringTable9<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT256
ENDIF9:
;If devError = $07 Then  sertxd ("SIGMA THRESHOLD CHECK!") : endif
;If devError = 7 Then hserprint "SIGMA THRESHOLD CHECK!"
	lds	SysCalcTempA,DEVERROR
	cpi	SysCalcTempA,7
	brne	ENDIF10
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable10<<1)
	ldi	SysReadA_H,high(StringTable10<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT256
ENDIF10:
;If devError = $08 Then  sertxd ("TCC!"): endif
;If devError = 8 Then hserprint "TCC!"
	lds	SysCalcTempA,DEVERROR
	cpi	SysCalcTempA,8
	brne	ENDIF11
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable11<<1)
	ldi	SysReadA_H,high(StringTable11<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT256
ENDIF11:
;If devError = $09 Then  sertxd ("PHASE CONSISTENCY!") : endif
;If devError = 9 Then hserprint "PHASE CONSISTENCY!"
	lds	SysCalcTempA,DEVERROR
	cpi	SysCalcTempA,9
	brne	ENDIF12
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable12<<1)
	ldi	SysReadA_H,high(StringTable12<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT256
ENDIF12:
;If devError = $0A Then  sertxd ("MIN CLIP!" ): endif
;If devError = 10 Then hserprint "MIN CLIP!"
	lds	SysCalcTempA,DEVERROR
	cpi	SysCalcTempA,10
	brne	ENDIF13
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable13<<1)
	ldi	SysReadA_H,high(StringTable13<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT256
ENDIF13:
;If devError = $0B Then  sertxd ("RANGE COMPLETE!") : endif
;If devError = 11 Then hserprint "RANGE COMPLETE!"
	lds	SysCalcTempA,DEVERROR
	cpi	SysCalcTempA,11
	brne	ENDIF14
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable14<<1)
	ldi	SysReadA_H,high(StringTable14<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT256
ENDIF14:
;If devError = $0C Then  sertxd ("ALGO UNDERFLOW!") : endif
;If devError = 12 Then hserprint "ALGO UNDERFLOW!"
	lds	SysCalcTempA,DEVERROR
	cpi	SysCalcTempA,12
	brne	ENDIF15
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable15<<1)
	ldi	SysReadA_H,high(StringTable15<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT256
ENDIF15:
;If devError = $0D Then  sertxd ("ALGO OVERFLOW!") : endif
;If devError = 13 Then hserprint "ALGO OVERFLOW!"
	lds	SysCalcTempA,DEVERROR
	cpi	SysCalcTempA,13
	brne	ENDIF16
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable16<<1)
	ldi	SysReadA_H,high(StringTable16<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT256
ENDIF16:
;If devError = $0E Then  sertxd ("RANGE IGNORE THRESHOLD!") : endif
;If devError = 14 Then hserprint "RANGE IGNORE THRESHOLD!"
	lds	SysCalcTempA,DEVERROR
	cpi	SysCalcTempA,14
	brne	ENDIF17
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable17<<1)
	ldi	SysReadA_H,high(StringTable17<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT256
ENDIF17:
;sertxd (" (",devError,")",cr,lf)
;hserprint "devError= "+str(devError)
	lds	SysValueCopy,DEVERROR
	sts	SYSVALTEMP,SysValueCopy
	ldi	SysValueCopy,0
	sts	SYSVALTEMP_H,SysValueCopy
	rcall	FN_STR
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysReadA,low(StringTable18<<1)
	ldi	SysReadA_H,high(StringTable18<<1)
	rcall	SysReadStringPart
	ldi	SysStringA,low(STR)
	ldi	SysStringA_H,high(STR)
	rcall	SysCopyStringPart
	ldi	SysStringA,low(SYSSTRINGPARAM1)
	ldi	SysStringA_H,high(SYSSTRINGPARAM1)
	st	X, SysStringLength
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT256
;hserprintcrlf
	ldi	SysValueCopy,1
	sts	HSERPRINTCRLFCOUNT,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINTCRLF
;Resolve info of sensor VL53L0x:
;If devError = $00 or devError = $06 update Distance
;If devError = $00 Or devError = $06Then
;Distance=Da(11)*256+Da(12)
	lds	SysWORDTempA,SYSDA_11
	ldi	SysWORDTempA_H,0
	ldi	SysWORDTempB,0
	ldi	SysWORDTempB_H,1
	rcall	SysMultSub16
	mov	SysTemp1,SysWORDTempX
	lds	SysTemp2,SYSDA_12
	add	SysTemp1,SysTemp2
	sts	DISTANCE,SysTemp1
	mov	SysTemp1,SysWORDTempX_H
	ldi	SysTemp2,0
	adc	SysTemp1,SysTemp2
	sts	DISTANCE_H,SysTemp1
;endif
;Effective SPAD Return Count
;SPAD = Da(3) + Da(4) /255
	lds	SysBYTETempA,SYSDA_4
	ldi	SysBYTETempB,255
	rcall	SysDivSub
	lds	SysTemp1,SYSDA_3
	add	SysTemp1,SysBYTETempA
	sts	SPAD,SysTemp1
	clr	SysTemp1
	brcc	PC + 2
	inc	SysTemp1
	sts	SPAD_H,SysTemp1
;Signal Rate
;Signal = Da(7)*256+Da(8)
	lds	SysWORDTempA,SYSDA_7
	ldi	SysWORDTempA_H,0
	ldi	SysWORDTempB,0
	ldi	SysWORDTempB_H,1
	rcall	SysMultSub16
	mov	SysTemp1,SysWORDTempX
	lds	SysTemp2,SYSDA_8
	add	SysTemp1,SysTemp2
	sts	SIGNAL,SysTemp1
	mov	SysTemp1,SysWORDTempX_H
	ldi	SysTemp2,0
	adc	SysTemp1,SysTemp2
	sts	SIGNAL_H,SysTemp1
;Ambient Rate
;Ambient= Da(9)*256+Da(10)
	lds	SysWORDTempA,SYSDA_9
	ldi	SysWORDTempA_H,0
	ldi	SysWORDTempB,0
	ldi	SysWORDTempB_H,1
	rcall	SysMultSub16
	mov	SysTemp1,SysWORDTempX
	lds	SysTemp2,SYSDA_10
	add	SysTemp1,SysTemp2
	sts	AMBIENT,SysTemp1
	mov	SysTemp1,SysWORDTempX_H
	ldi	SysTemp2,0
	adc	SysTemp1,SysTemp2
	sts	AMBIENT_H,SysTemp1
;Send terminal info:
;sertxd ( "Distance: ", #Distance," mm",13,10 )
;hserprint "Distance: "+str(Distance)+" mm"
	lds	SysValueCopy,DISTANCE
	sts	SYSVALTEMP,SysValueCopy
	lds	SysValueCopy,DISTANCE_H
	sts	SYSVALTEMP_H,SysValueCopy
	rcall	FN_STR
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysReadA,low(StringTable19<<1)
	ldi	SysReadA_H,high(StringTable19<<1)
	rcall	SysReadStringPart
	ldi	SysStringA,low(STR)
	ldi	SysStringA_H,high(STR)
	rcall	SysCopyStringPart
	ldi	SysReadA,low(StringTable20<<1)
	ldi	SysReadA_H,high(StringTable20<<1)
	rcall	SysReadStringPart
	ldi	SysStringA,low(SYSSTRINGPARAM1)
	ldi	SysStringA_H,high(SYSSTRINGPARAM1)
	st	X, SysStringLength
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT256
;hserprintcrlf
	ldi	SysValueCopy,1
	sts	HSERPRINTCRLFCOUNT,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINTCRLF
;sertxd ("Ambient ", #Ambient,"mc/s",13,10 )
;hserprint "Ambient "+str(Ambient)+" mc/s"
	lds	SysValueCopy,AMBIENT
	sts	SYSVALTEMP,SysValueCopy
	lds	SysValueCopy,AMBIENT_H
	sts	SYSVALTEMP_H,SysValueCopy
	rcall	FN_STR
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysReadA,low(StringTable21<<1)
	ldi	SysReadA_H,high(StringTable21<<1)
	rcall	SysReadStringPart
	ldi	SysStringA,low(STR)
	ldi	SysStringA_H,high(STR)
	rcall	SysCopyStringPart
	ldi	SysReadA,low(StringTable22<<1)
	ldi	SysReadA_H,high(StringTable22<<1)
	rcall	SysReadStringPart
	ldi	SysStringA,low(SYSSTRINGPARAM1)
	ldi	SysStringA_H,high(SYSSTRINGPARAM1)
	st	X, SysStringLength
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT256
;hserprintcrlf
	ldi	SysValueCopy,1
	sts	HSERPRINTCRLFCOUNT,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINTCRLF
;sertxd ( "Signal Rate = ",#Signal,"mc/s",13,10 )
;hserprint "Signal Rate = "+str(Signal)+" mc/s"
	lds	SysValueCopy,SIGNAL
	sts	SYSVALTEMP,SysValueCopy
	lds	SysValueCopy,SIGNAL_H
	sts	SYSVALTEMP_H,SysValueCopy
	rcall	FN_STR
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysReadA,low(StringTable23<<1)
	ldi	SysReadA_H,high(StringTable23<<1)
	rcall	SysReadStringPart
	ldi	SysStringA,low(STR)
	ldi	SysStringA_H,high(STR)
	rcall	SysCopyStringPart
	ldi	SysReadA,low(StringTable22<<1)
	ldi	SysReadA_H,high(StringTable22<<1)
	rcall	SysReadStringPart
	ldi	SysStringA,low(SYSSTRINGPARAM1)
	ldi	SysStringA_H,high(SYSSTRINGPARAM1)
	st	X, SysStringLength
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT256
;hserprintcrlf
	ldi	SysValueCopy,1
	sts	HSERPRINTCRLFCOUNT,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINTCRLF
;sertxd ( "SPAD = ",#SPAD,13,10 )
;hserprint "SPAD = "+str(SPAD)
	lds	SysValueCopy,SPAD
	sts	SYSVALTEMP,SysValueCopy
	lds	SysValueCopy,SPAD_H
	sts	SYSVALTEMP_H,SysValueCopy
	rcall	FN_STR
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysReadA,low(StringTable24<<1)
	ldi	SysReadA_H,high(StringTable24<<1)
	rcall	SysReadStringPart
	ldi	SysStringA,low(STR)
	ldi	SysStringA_H,high(STR)
	rcall	SysCopyStringPart
	ldi	SysStringA,low(SYSSTRINGPARAM1)
	ldi	SysStringA_H,high(SYSSTRINGPARAM1)
	st	X, SysStringLength
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT256
;hserprintcrlf
	ldi	SysValueCopy,1
	sts	HSERPRINTCRLFCOUNT,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINTCRLF
;loop
	rjmp	SysDoLoop_S1
SysDoLoop_E1:
BASPROGRAMEND:
	sleep
	rjmp	BASPROGRAMEND

;********************************************************************************

AVRHI2CMODE:
;If HI2CCurrentMode = Master Then
	lds	SysCalcTempA,HI2CCURRENTMODE
	cpi	SysCalcTempA,12
	brne	ENDIF26
;TWSR = CST_PRESCALER
	ldi	SysValueCopy,0
	sts	TWSR,SysValueCopy
;TWBR = CST_TWBR
	ldi	SysValueCopy,12
	sts	TWBR,SysValueCopy
;end if
ENDIF26:
;if HI2CCurrentMode = Slave then
	lds	SysCalcTempA,HI2CCURRENTMODE
	tst	SysCalcTempA
	brne	ENDIF27
;[tbd]
;end if
ENDIF27:
;ldi  SysValueCopy, 0|(1<<TWEN)
	ldi	SYSVALUECOPY, 0|(1<<TWEN)
;sts  TWCR,SysValueCopy
	sts	TWCR,SYSVALUECOPY
;HI2CWaitMSSPTimeout = 0
	ldi	SysValueCopy,0
	sts	HI2CWAITMSSPTIMEOUT,SysValueCopy
	ret

;********************************************************************************

AVRHI2CRECEIVE:
;if HI2CGetAck.0 = 0 then
	lds	SysBitTest,HI2CGETACK
	sbrc	SysBitTest,0
	rjmp	ELSE30_1
;lds SysValueCopy,TWCR
	lds	SYSVALUECOPY,TWCR
;sbr       SysValueCopy, (1<<TWINT)
	sbr	SYSVALUECOPY, (1<<TWINT)
;cbr       SysValueCopy, (1<<TWSTA) | (1<<TWSTO) | (1<<TWEA)
	cbr	SYSVALUECOPY, (1<<TWSTA) | (1<<TWSTO) | (1<<TWEA)
;sts TWCR,SysValueCopy
	sts	TWCR,SYSVALUECOPY
;else
	rjmp	ENDIF30
ELSE30_1:
;Acknowledge
;lds SysValueCopy,TWCR
	lds	SYSVALUECOPY,TWCR
;cbr       SysValueCopy, (1<<TWSTA) | (1<<TWSTO)
	cbr	SYSVALUECOPY, (1<<TWSTA) | (1<<TWSTO)
;sbr       SysValueCopy, (1<<TWINT) | (1<<TWEA)
	sbr	SYSVALUECOPY, (1<<TWINT) | (1<<TWEA)
;sts TWCR,SysValueCopy
	sts	TWCR,SYSVALUECOPY
;end if
ENDIF30:
;nop
	nop
;nop
	nop
;do while TWINT = 0
SysDoLoop_S4:
	lds	SysBitTest,TWCR
	sbrc	SysBitTest,TWINT
	rjmp	SysDoLoop_E4
;loop
	rjmp	SysDoLoop_S4
SysDoLoop_E4:
;Get byte
;I2CByte = TWDR
	lds	SysValueCopy,TWDR
	sts	I2CBYTE,SysValueCopy
	ret

;********************************************************************************

AVRHI2CSEND:
;lds       SysValueCopy,I2CBYTE
	lds	SYSVALUECOPY,I2CBYTE
;sts       TWDR,SysValueCopy
	sts	TWDR,SYSVALUECOPY
;ldi       SysValueCopy, (1<<TWINT) | (1<<TWEN)
	ldi	SYSVALUECOPY, (1<<TWINT) | (1<<TWEN)
;sts       TWCR, SysValueCopy
	sts	TWCR, SYSVALUECOPY
;nop
	nop
;nop
	nop
;do while TWINT = 0
SysDoLoop_S3:
	lds	SysBitTest,TWCR
	sbrc	SysBitTest,TWINT
	rjmp	SysDoLoop_E3
;loop
	rjmp	SysDoLoop_S3
SysDoLoop_E3:
;Destructive use of I2CByte to save memory
;I2CByte = TWSR & 0xF8
	ldi	SysTemp2,248
	lds	SysTemp1,TWSR
	and	SysTemp1,SysTemp2
	sts	I2CBYTE,SysTemp1
;HI2CAckPollState = true
	ldi	SysValueCopy,255
	sts	HI2CACKPOLLSTATE,SysValueCopy
;Select case I2CByte          'Use AVRDisable_HI2CAckPollState to make a tad faster
;case AVR_I2C_START
SysSelect1Case1:
	lds	SysCalcTempA,I2CBYTE
	cpi	SysCalcTempA,8
	brne	SysSelect1Case2
;dummy
;case MT_SLA_ACK
	rjmp	SysSelectEnd1
SysSelect1Case2:
	lds	SysCalcTempA,I2CBYTE
	cpi	SysCalcTempA,24
	brne	SysSelect1Case3
;HI2CAckPollState = false
	ldi	SysValueCopy,0
	sts	HI2CACKPOLLSTATE,SysValueCopy
;case MT_DATA_ACK
	rjmp	SysSelectEnd1
SysSelect1Case3:
	lds	SysCalcTempA,I2CBYTE
	cpi	SysCalcTempA,40
	brne	SysSelect1Case4
;HI2CAckPollState = false
	ldi	SysValueCopy,0
	sts	HI2CACKPOLLSTATE,SysValueCopy
;case MT_SLA_NACK_REC
	rjmp	SysSelectEnd1
SysSelect1Case4:
	lds	SysCalcTempA,I2CBYTE
	cpi	SysCalcTempA,32
	brne	SysSelect1Case5
;HI2CAckPollState = true
	ldi	SysValueCopy,255
	sts	HI2CACKPOLLSTATE,SysValueCopy
;case MT_DATA_NACK_REC
	rjmp	SysSelectEnd1
SysSelect1Case5:
	lds	SysCalcTempA,I2CBYTE
	cpi	SysCalcTempA,48
	brne	SysSelect1Case6
;HI2CAckPollState = true
	ldi	SysValueCopy,255
	sts	HI2CACKPOLLSTATE,SysValueCopy
;case MR_SLA_NACK_REC
	rjmp	SysSelectEnd1
SysSelect1Case6:
	lds	SysCalcTempA,I2CBYTE
	cpi	SysCalcTempA,72
	brne	SysSelect1Case7
;HI2CAckPollState = true
	ldi	SysValueCopy,255
	sts	HI2CACKPOLLSTATE,SysValueCopy
;case MR_SLA_ACK
	rjmp	SysSelectEnd1
SysSelect1Case7:
	lds	SysCalcTempA,I2CBYTE
	cpi	SysCalcTempA,64
	brne	SysSelect1Case8
;HI2CAckPollState = false
	ldi	SysValueCopy,0
	sts	HI2CACKPOLLSTATE,SysValueCopy
;case MR_DATA_NACK_REC
	rjmp	SysSelectEnd1
SysSelect1Case8:
	lds	SysCalcTempA,I2CBYTE
	cpi	SysCalcTempA,88
	brne	SysSelect1Case9
;HI2CAckPollState = true
	ldi	SysValueCopy,255
	sts	HI2CACKPOLLSTATE,SysValueCopy
;case else
	rjmp	SysSelectEnd1
SysSelect1Case9:
;bad event!!
;end select
SysSelectEnd1:
;HI2CStartOccurred = false
	rjmp	FN_HI2CSTARTOCCURRED

;********************************************************************************

AVRHI2CSTART:
;if HI2CCurrentMode = 0 then
	lds	SysCalcTempA,HI2CCURRENTMODE
	tst	SysCalcTempA
	brne	ENDIF28
;assume MASTER
;HI2CMode Master
	ldi	SysValueCopy,12
	sts	HI2CCURRENTMODE,SysValueCopy
	rcall	AVRHI2CMODE
;end if
ENDIF28:
;lds SysValueCopy,TWCR
	lds	SYSVALUECOPY,TWCR
;sbr   SysValueCopy, (1<<TWINT)|(1<<TWSTA)| (1<<TWEN)
	sbr	SYSVALUECOPY, (1<<TWINT)|(1<<TWSTA)| (1<<TWEN)
;sts TWCR,SysValueCopy
	sts	TWCR,SYSVALUECOPY
;do while TWINT = 0
SysDoLoop_S2:
	lds	SysBitTest,TWCR
	sbrc	SysBitTest,TWINT
	rjmp	SysDoLoop_E2
;loop
	rjmp	SysDoLoop_S2
SysDoLoop_E2:
;I2CByte = TWSR & 0xF8
	ldi	SysTemp2,248
	lds	SysTemp1,TWSR
	and	SysTemp1,SysTemp2
	sts	I2CBYTE,SysTemp1
;if I2CByte = AVR_I2C_START then
	lds	SysCalcTempA,I2CBYTE
	cpi	SysCalcTempA,8
	brne	ELSE29_1
;HI2CStartOccurred = true
	rcall	FN_HI2CSTARTOCCURRED
;else
	rjmp	ENDIF29
ELSE29_1:
;HI2CStartOccurred = false
	rcall	FN_HI2CSTARTOCCURRED
;end if
ENDIF29:
	ret

;********************************************************************************

AVRHI2CSTOP:
;lds SysValueCopy,TWCR
	lds	SYSVALUECOPY,TWCR
;sbr   SysValueCopy, (1<<TWINT)|(1<<TWEN)|(1<<TWSTO)
	sbr	SYSVALUECOPY, (1<<TWINT)|(1<<TWEN)|(1<<TWSTO)
;sts TWCR,SysValueCopy
	sts	TWCR,SYSVALUECOPY
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

FN_HI2CSTARTOCCURRED:
;Master mode
;Always return true
;If HI2CCurrentMode > 10 Then
	ldi	SysCalcTempA,10
	lds	SysCalcTempB,HI2CCURRENTMODE
	cp	SysCalcTempA,SysCalcTempB
	brsh	ELSE33_1
;HI2CStartOccurred = TRUE
	ldi	SysValueCopy,255
	sts	HI2CSTARTOCCURRED,SysValueCopy
;Exit Function
	ret
;Slave mode, check if start condition received last
;Else
	rjmp	ENDIF33
ELSE33_1:
;HI2CStartOccurred = FALSE
	ldi	SysValueCopy,0
	sts	HI2CSTARTOCCURRED,SysValueCopy
;End If
ENDIF33:
	ret

;********************************************************************************

HIC2INIT:
;HI2CCurrentMode = 0
	ldi	SysValueCopy,0
	sts	HI2CCURRENTMODE,SysValueCopy
;Initialise the I2C module
	ret

;********************************************************************************

;Overloaded signature: STRING:byte:
HSERPRINT256:
;PrintLen = LEN(PrintData$)
;PrintLen = PrintData(0)
	lds	SysStringA,SysPRINTDATAHandler
	lds	SysStringA_H,SysPRINTDATAHandler_H
	ld	SysValueCopy,X
	sts	PRINTLEN,SysValueCopy
;If PrintLen <> 0 then
	lds	SysCalcTempA,PRINTLEN
	tst	SysCalcTempA
	breq	ENDIF23
;Write Data
;for SysPrintTemp = 1 to PrintLen
	ldi	SysValueCopy,0
	sts	SYSPRINTTEMP,SysValueCopy
	lds	SysCalcTempA,PRINTLEN
	cpi	SysCalcTempA,1
	brlo	SysForLoopEnd3
SysForLoop3:
	lds	SysTemp1,SYSPRINTTEMP
	inc	SysTemp1
	sts	SYSPRINTTEMP,SysTemp1
;HSerSend(PrintData(SysPrintTemp),comport )
	lds	SysTemp1,SysPRINTDATAHandler
	lds	SysTemp2,SYSPRINTTEMP
	add	SysTemp1,SysTemp2
	mov	SysStringA,SysTemp1
	lds	SysTemp1,SysPRINTDATAHandler_H
	ldi	SysTemp2,0
	adc	SysTemp1,SysTemp2
	mov	SysStringA_H,SysTemp1
	ld	SysValueCopy,X
	sts	SERDATA,SysValueCopy
	rcall	HSERSEND
;next
	lds	SysCalcTempA,SYSPRINTTEMP
	lds	SysCalcTempB,PRINTLEN
	cp	SysCalcTempA,SysCalcTempB
	brlo	SysForLoop3
SysForLoopEnd3:
;End If
ENDIF23:
;CR
	ret

;********************************************************************************

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
	rcall	HSERSEND
;HSerSend(10,comport)
	ldi	SysValueCopy,10
	sts	SERDATA,SysValueCopy
	rcall	HSERSEND
;end Repeat
	lds	SysTemp1,SysRepeatTemp1
	dec	SysTemp1
	sts	SysRepeatTemp1,SysTemp1
	brne	SysRepeatLoop1
SysRepeatLoopEnd1:
	ret

;********************************************************************************

HSERSEND:
;Block before sending (if needed)
;Send byte
;AVR USART1 Send
;if comport = 1 Then
	lds	SysCalcTempA,COMPORT
	cpi	SysCalcTempA,1
	brne	ENDIF22
;HSerSendBlocker    'comport 1 blocker
;Wait While UDRE0 = Off    'Blocking Transmit buffer empty ,ready for data
SysWaitLoop1:
	lds	SysBitTest,UCSR0A
	sbrs	SysBitTest,UDRE0
	rjmp	SysWaitLoop1
;#ifndef Var(UDR0)
;#ifdef Var(UDR1)
;UDR1 = SerData    '? second comport
;#endif
;#endif
;UDR0 = SerData ' *******************
	lds	SysValueCopy,SERDATA
	sts	UDR0,SysValueCopy
;End If
ENDIF22:
;----------------------------------------------------
;AVR USART 2 send
;AVR USART 3 send
;AVR USART 4 send
	ret

;********************************************************************************

INITSYS:
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

FN_STR:
;SysCharCount = 0
	ldi	SysValueCopy,0
	sts	SYSCHARCOUNT,SysValueCopy
;Dim SysCalcTempX As Word
;Ten Thousands
;IF SysValTemp >= 10000 then
	lds	SysWORDTempA,SYSVALTEMP
	lds	SysWORDTempA_H,SYSVALTEMP_H
	ldi	SysWORDTempB,16
	ldi	SysWORDTempB_H,39
	rcall	SysCompLessThan16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF18
;SysStrData = SysValTemp / 10000
	lds	SysWORDTempA,SYSVALTEMP
	lds	SysWORDTempA_H,SYSVALTEMP_H
	ldi	SysWORDTempB,16
	ldi	SysWORDTempB_H,39
	rcall	SysDivSub16
	sts	SYSSTRDATA,SysWORDTempA
;SysValTemp = SysCalcTempX
	sts	SYSVALTEMP,SYSCALCTEMPX
	sts	SYSVALTEMP_H,SYSCALCTEMPX_H
;SysCharCount += 1
	lds	SysTemp1,SYSCHARCOUNT
	inc	SysTemp1
	sts	SYSCHARCOUNT,SysTemp1
;Str(SysCharCount) = SysStrData + 48
	ldi	SysTemp2,low(STR)
	add	SysTemp1,SysTemp2
	mov	SysStringA,SysTemp1
	ldi	SysTemp2,0
	ldi	SysTemp3,high(STR)
	adc	SysTemp2,SysTemp3
	mov	SysStringA_H,SysTemp2
	lds	SysTemp1,SYSSTRDATA
	ldi	SysTemp2,48
	add	SysTemp1,SysTemp2
	st	X,SysTemp1
;Goto SysValThousands
	rjmp	SYSVALTHOUSANDS
;End If
ENDIF18:
;Thousands
;IF SysValTemp >= 1000 then
	lds	SysWORDTempA,SYSVALTEMP
	lds	SysWORDTempA_H,SYSVALTEMP_H
	ldi	SysWORDTempB,232
	ldi	SysWORDTempB_H,3
	rcall	SysCompLessThan16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF19
SYSVALTHOUSANDS:
;SysStrData = SysValTemp / 1000
	lds	SysWORDTempA,SYSVALTEMP
	lds	SysWORDTempA_H,SYSVALTEMP_H
	ldi	SysWORDTempB,232
	ldi	SysWORDTempB_H,3
	rcall	SysDivSub16
	sts	SYSSTRDATA,SysWORDTempA
;SysValTemp = SysCalcTempX
	sts	SYSVALTEMP,SYSCALCTEMPX
	sts	SYSVALTEMP_H,SYSCALCTEMPX_H
;SysCharCount += 1
	lds	SysTemp1,SYSCHARCOUNT
	inc	SysTemp1
	sts	SYSCHARCOUNT,SysTemp1
;Str(SysCharCount) = SysStrData + 48
	ldi	SysTemp2,low(STR)
	add	SysTemp1,SysTemp2
	mov	SysStringA,SysTemp1
	ldi	SysTemp2,0
	ldi	SysTemp3,high(STR)
	adc	SysTemp2,SysTemp3
	mov	SysStringA_H,SysTemp2
	lds	SysTemp1,SYSSTRDATA
	ldi	SysTemp2,48
	add	SysTemp1,SysTemp2
	st	X,SysTemp1
;Goto SysValHundreds
	rjmp	SYSVALHUNDREDS
;End If
ENDIF19:
;Hundreds
;IF SysValTemp >= 100 then
	lds	SysWORDTempA,SYSVALTEMP
	lds	SysWORDTempA_H,SYSVALTEMP_H
	ldi	SysWORDTempB,100
	ldi	SysWORDTempB_H,0
	rcall	SysCompLessThan16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF20
SYSVALHUNDREDS:
;SysStrData = SysValTemp / 100
	lds	SysWORDTempA,SYSVALTEMP
	lds	SysWORDTempA_H,SYSVALTEMP_H
	ldi	SysWORDTempB,100
	ldi	SysWORDTempB_H,0
	rcall	SysDivSub16
	sts	SYSSTRDATA,SysWORDTempA
;SysValTemp = SysCalcTempX
	sts	SYSVALTEMP,SYSCALCTEMPX
	sts	SYSVALTEMP_H,SYSCALCTEMPX_H
;SysCharCount += 1
	lds	SysTemp1,SYSCHARCOUNT
	inc	SysTemp1
	sts	SYSCHARCOUNT,SysTemp1
;Str(SysCharCount) = SysStrData + 48
	ldi	SysTemp2,low(STR)
	add	SysTemp1,SysTemp2
	mov	SysStringA,SysTemp1
	ldi	SysTemp2,0
	ldi	SysTemp3,high(STR)
	adc	SysTemp2,SysTemp3
	mov	SysStringA_H,SysTemp2
	lds	SysTemp1,SYSSTRDATA
	ldi	SysTemp2,48
	add	SysTemp1,SysTemp2
	st	X,SysTemp1
;Goto SysValTens
	rjmp	SYSVALTENS
;End If
ENDIF20:
;Tens
;IF SysValTemp >= 10 Then
	lds	SysWORDTempA,SYSVALTEMP
	lds	SysWORDTempA_H,SYSVALTEMP_H
	ldi	SysWORDTempB,10
	ldi	SysWORDTempB_H,0
	rcall	SysCompLessThan16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF21
SYSVALTENS:
;SysStrData = SysValTemp / 10
	lds	SysWORDTempA,SYSVALTEMP
	lds	SysWORDTempA_H,SYSVALTEMP_H
	ldi	SysWORDTempB,10
	ldi	SysWORDTempB_H,0
	rcall	SysDivSub16
	sts	SYSSTRDATA,SysWORDTempA
;SysValTemp = SysCalcTempX
	sts	SYSVALTEMP,SYSCALCTEMPX
	sts	SYSVALTEMP_H,SYSCALCTEMPX_H
;SysCharCount += 1
	lds	SysTemp1,SYSCHARCOUNT
	inc	SysTemp1
	sts	SYSCHARCOUNT,SysTemp1
;Str(SysCharCount) = SysStrData + 48
	ldi	SysTemp2,low(STR)
	add	SysTemp1,SysTemp2
	mov	SysStringA,SysTemp1
	ldi	SysTemp2,0
	ldi	SysTemp3,high(STR)
	adc	SysTemp2,SysTemp3
	mov	SysStringA_H,SysTemp2
	lds	SysTemp1,SYSSTRDATA
	ldi	SysTemp2,48
	add	SysTemp1,SysTemp2
	st	X,SysTemp1
;End If
ENDIF21:
;Ones
;SysCharCount += 1
	lds	SysTemp1,SYSCHARCOUNT
	inc	SysTemp1
	sts	SYSCHARCOUNT,SysTemp1
;Str(SysCharCount) = SysValTemp + 48
	ldi	SysTemp2,low(STR)
	add	SysTemp1,SysTemp2
	mov	SysStringA,SysTemp1
	ldi	SysTemp2,0
	ldi	SysTemp3,high(STR)
	adc	SysTemp2,SysTemp3
	mov	SysStringA_H,SysTemp2
	lds	SysTemp1,SYSVALTEMP
	ldi	SysTemp2,48
	add	SysTemp1,SysTemp2
	st	X,SysTemp1
;SysValTemp = SysCalcTempX
	sts	SYSVALTEMP,SYSCALCTEMPX
	sts	SYSVALTEMP_H,SYSCALCTEMPX_H
;Str(0) = SysCharCount
	lds	SysValueCopy,SYSCHARCOUNT
	sts	SYSSTR_0,SysValueCopy
	ret

;********************************************************************************

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
	rjmp	ENDIF31
;SysWordTempA = 0
	ldi	SYSWORDTEMPA,0
	ldi	SYSWORDTEMPA_H,0
;exit sub
	ret
;end if
ENDIF31:
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
	mov	SysTemp1,SYSDIVMULTX
	sub	SysTemp1,SYSDIVMULTB
	mov	SYSDIVMULTX,SysTemp1
	mov	SysTemp1,SYSDIVMULTX_H
	sbc	SysTemp1,SYSDIVMULTB_H
	mov	SYSDIVMULTX_H,SysTemp1
;Set SysDivMultA.0 On
	sbr	 SYSDIVMULTA,1<<0
;If C On Then
	brbc	C,ENDIF32
;Set SysDivMultA.0 Off
	cbr	 SYSDIVMULTA,1<<0
;SysDivMultX = SysDivMultX + SysDivMultB
	mov	SysTemp1,SYSDIVMULTX
	add	SysTemp1,SYSDIVMULTB
	mov	SYSDIVMULTX,SysTemp1
	mov	SysTemp1,SYSDIVMULTX_H
	adc	SysTemp1,SYSDIVMULTB_H
	mov	SYSDIVMULTX_H,SysTemp1
;End If
ENDIF32:
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
.DB	3,32,44,32


StringTable2:
.DB	8,83,116,97,116,117,115,58,32,0


StringTable3:
.DB	8,68,97,116,97,32,79,75,33,0


StringTable4:
.DB	30,86,67,83,69,76,32,67,79,78,84,73,78,85,73,84,89,32,84,69,83,84,32,70,65,73,76,85,82,69,33,0


StringTable5:
.DB	28,86,67,83,69,76,32,87,65,84,67,72,68,79,71,32,84,69,83,84,32,70,65,73,76,85,82,69,33,0


StringTable6:
.DB	19,78,79,32,86,72,86,32,86,65,76,85,69,32,70,79,85,78,68,33


StringTable7:
.DB	15,77,83,82,67,32,78,79,32,84,65,82,71,69,84,33


StringTable8:
.DB	10,83,78,82,32,67,72,69,67,75,33,0


StringTable9:
.DB	18,82,65,78,71,69,32,80,72,65,83,69,32,67,72,69,67,75,33,0


StringTable10:
.DB	22,83,73,71,77,65,32,84,72,82,69,83,72,79,76,68,32,67,72,69,67,75,33,0


StringTable11:
.DB	4,84,67,67,33,0


StringTable12:
.DB	18,80,72,65,83,69,32,67,79,78,83,73,83,84,69,78,67,89,33,0


StringTable13:
.DB	9,77,73,78,32,67,76,73,80,33


StringTable14:
.DB	15,82,65,78,71,69,32,67,79,77,80,76,69,84,69,33


StringTable15:
.DB	15,65,76,71,79,32,85,78,68,69,82,70,76,79,87,33


StringTable16:
.DB	14,65,76,71,79,32,79,86,69,82,70,76,79,87,33,0


StringTable17:
.DB	23,82,65,78,71,69,32,73,71,78,79,82,69,32,84,72,82,69,83,72,79,76,68,33


StringTable18:
.DB	10,100,101,118,69,114,114,111,114,61,32,0


StringTable19:
.DB	10,68,105,115,116,97,110,99,101,58,32,0


StringTable20:
.DB	3,32,109,109


StringTable21:
.DB	8,65,109,98,105,101,110,116,32,0


StringTable22:
.DB	5,32,109,99,47,115


StringTable23:
.DB	14,83,105,103,110,97,108,32,82,97,116,101,32,61,32,0


StringTable24:
.DB	7,83,80,65,68,32,61,32


;********************************************************************************


