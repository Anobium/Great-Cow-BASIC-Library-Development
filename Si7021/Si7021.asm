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
.EQU	COMPORT=348
.EQU	CURMS=349
.EQU	CURMS_H=350
.EQU	HI2CACKPOLLSTATE=351
.EQU	HI2CCURRENTMODE=352
.EQU	HI2CGETACK=353
.EQU	HI2CSTARTOCCURRED=354
.EQU	HI2CWAITMSSPTIMEOUT=355
.EQU	HSERPRINTCRLFCOUNT=356
.EQU	HUMIDITY=357
.EQU	HUMIDITY_H=358
.EQU	HUNDREDTHS=359
.EQU	I2CBYTE=360
.EQU	LSTMS=361
.EQU	LSTMS_H=362
.EQU	MILLIS=363
.EQU	MILLIS_E=366
.EQU	MILLIS_H=364
.EQU	MILLIS_U=365
.EQU	MSCTR_=367
.EQU	MSCTR__E=370
.EQU	MSCTR__H=368
.EQU	MSCTR__U=369
.EQU	OUTVALUETEMP=371
.EQU	PRINTLEN=372
.EQU	SAVESREG=373
.EQU	SAVESYSTEMP3=374
.EQU	SAVESYSVALUECOPY=375
.EQU	SERDATA=376
.EQU	SERPRINTVAL=377
.EQU	SERPRINTVAL_H=378
.EQU	SI7021_HIGHBYTE=379
.EQU	SI7021_LOWBYTE=380
.EQU	STR=342
.EQU	STRINGPOINTER=381
.EQU	SYSCHARCOUNT=382
.EQU	SYSINTSTATESAVE0=383
.EQU	SYSLONGDIVMULTA=384
.EQU	SYSLONGDIVMULTA_E=387
.EQU	SYSLONGDIVMULTA_H=385
.EQU	SYSLONGDIVMULTA_U=386
.EQU	SYSLONGDIVMULTB=388
.EQU	SYSLONGDIVMULTB_E=391
.EQU	SYSLONGDIVMULTB_H=389
.EQU	SYSLONGDIVMULTB_U=390
.EQU	SYSLONGDIVMULTX=392
.EQU	SYSLONGDIVMULTX_E=395
.EQU	SYSLONGDIVMULTX_H=393
.EQU	SYSLONGDIVMULTX_U=394
.EQU	SYSPRINTDATAHANDLER=396
.EQU	SYSPRINTDATAHANDLER_H=397
.EQU	SYSPRINTTEMP=398
.EQU	SYSREPEATTEMP1=399
.EQU	SYSSTRDATA=400
.EQU	SYSSTRINGPARAM1=256
.EQU	SYSSTRINGPARAM2=299
.EQU	SYSVALTEMP=401
.EQU	SYSVALTEMP_H=402
.EQU	TEMPERATUREC=403
.EQU	TEMPERATUREC_H=404
.EQU	TEMPERATUREF=405
.EQU	TEMPERATUREF_H=406
.EQU	TMR0=407
.EQU	TMR0_TMP=408
.EQU	TMRPRES=409
.EQU	TMRSOURCE=410

;********************************************************************************

;Register variables
.DEF	DELAYTEMP=r25
.DEF	DELAYTEMP2=r26
.DEF	SYSBITTEST=r5
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
#define	SIRAW	380
#define	SIRAW_H	379
#define	SYSSTR_0	342

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
	rjmp	IntTIMER0_OVF ;TIMER0_OVF
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
	rcall	INIT_MSCTR_INT
;Enable interrupts
	sei

;Start of the main program
;#define SAMPLERATE 5     ' Flash rate in S
;#define hi2c_BAUD_RATE 100
;#define hi2c_DATA PORTC.4
;#define hi2c_CLOCK PORTC.5
;hi2cMode Master
	ldi	SysValueCopy,12
	sts	HI2CCURRENTMODE,SysValueCopy
	rcall	AVRHI2CMODE
;Dim Si7021_HighByte, Si7021_LowByte as byte
;Dim SiRaw Alias Si7021_HighByte, Si7021_LowByte as Word
;Dim Humidity,Temperature,TemperatureC,TemperatureF as Word
;DIM Temperature as WORD
;Dim Hundredths as Byte
;#define READSENSOR  Read_Temperature : Read_Humidity
;#define USART_BAUD_RATE 9600
;#define USART_TX_BLOCKING
;#define USART_DELAY 10 ms
;Dim CurMs, LstMs as word  ' declare working variables
;Main                    ' This loop runs over and over forever.
;LstMs = 0
	ldi	SysValueCopy,0
	sts	LSTMS,SysValueCopy
	sts	LSTMS_H,SysValueCopy
;CurMs = 0
	ldi	SysValueCopy,0
	sts	CURMS,SysValueCopy
	sts	CURMS_H,SysValueCopy
;Initial read
;HSerPrintCRLF 2
	ldi	SysValueCopy,2
	sts	HSERPRINTCRLFCOUNT,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINTCRLF
;HSerPrint "Si7021 I2C HUMIDITY AND TEMPERATURE SENSOR"
	ldi	SysStringB,low(SYSSTRINGPARAM1)
	ldi	SysStringB_H,high(SYSSTRINGPARAM1)
	ldi	SysReadA,low(StringTable1<<1)
	ldi	SysReadA_H,high(StringTable1<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM1)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT265
;HSerPrintCRLF
	ldi	SysValueCopy,1
	sts	HSERPRINTCRLFCOUNT,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINTCRLF
;READSENSOR
	rcall	READ_TEMPERATURE
	rcall	READ_HUMIDITY
;Main                    ' This loop runs over and over forever.
;Do
SysDoLoop_S1:
;CurMs = millis()
	rcall	FN_MILLIS
	lds	SysValueCopy,MILLIS
	sts	CURMS,SysValueCopy
	lds	SysValueCopy,MILLIS_H
	sts	CURMS_H,SysValueCopy
;if CurMs - LstMs >= SAMPLERATE * 1000 then  ' required Time has Elapsed
	lds	SysTemp2,CURMS
	lds	SysTemp3,LSTMS
	sub	SysTemp2,SysTemp3
	mov	SysTemp1,SysTemp2
	lds	SysTemp2,CURMS_H
	lds	SysTemp3,LSTMS_H
	sbc	SysTemp2,SysTemp3
	mov	SysTemp1_H,SysTemp2
	mov	SysWORDTempA,SysTemp1
	mov	SysWORDTempA_H,SysTemp1_H
	ldi	SysWORDTempB,136
	ldi	SysWORDTempB_H,19
	rcall	SysCompLessThan16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF1
;READSENSOR
	rcall	READ_TEMPERATURE
	rcall	READ_HUMIDITY
;LstMs = CurMs                   ' And Record Toggle Time
	lds	SysValueCopy,CURMS
	sts	LSTMS,SysValueCopy
	lds	SysValueCopy,CURMS_H
	sts	LSTMS_H,SysValueCopy
;end if
ENDIF1:
;Loop
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
	brne	ENDIF21
;TWSR = CST_PRESCALER
	ldi	SysValueCopy,0
	sts	TWSR,SysValueCopy
;TWBR = CST_TWBR
	ldi	SysValueCopy,72
	sts	TWBR,SysValueCopy
;end if
ENDIF21:
;if HI2CCurrentMode = Slave then
	lds	SysCalcTempA,HI2CCURRENTMODE
	tst	SysCalcTempA
	brne	ENDIF22
;[tbd]
;end if
ENDIF22:
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
	rjmp	ELSE27_1
;lds SysValueCopy,TWCR
	lds	SYSVALUECOPY,TWCR
;sbr       SysValueCopy, (1<<TWINT)
	sbr	SYSVALUECOPY, (1<<TWINT)
;cbr       SysValueCopy, (1<<TWSTA) | (1<<TWSTO) | (1<<TWEA)
	cbr	SYSVALUECOPY, (1<<TWSTA) | (1<<TWSTO) | (1<<TWEA)
;sts TWCR,SysValueCopy
	sts	TWCR,SYSVALUECOPY
;else
	rjmp	ENDIF27
ELSE27_1:
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
ENDIF27:
;nop
	nop
;nop
	nop
;do while TWINT = 0
SysDoLoop_S5:
	lds	SysBitTest,TWCR
	sbrc	SysBitTest,TWINT
	rjmp	SysDoLoop_E5
;loop
	rjmp	SysDoLoop_S5
SysDoLoop_E5:
;Get byte
;I2CByte = TWDR
	lds	SysValueCopy,TWDR
	sts	I2CBYTE,SysValueCopy
	ret

;********************************************************************************

AVRHI2CRESTART:
;lds SysValueCopy,TWCR
	lds	SYSVALUECOPY,TWCR
;sbr   SysValueCopy, (1<<TWINT)|(1<<TWSTA)| (1<<TWEN)
	sbr	SYSVALUECOPY, (1<<TWINT)|(1<<TWSTA)| (1<<TWEN)
;sts TWCR,SysValueCopy
	sts	TWCR,SYSVALUECOPY
;do while TWINT = 0
SysDoLoop_S3:
	lds	SysBitTest,TWCR
	sbrc	SysBitTest,TWINT
	rjmp	SysDoLoop_E3
;loop
	rjmp	SysDoLoop_S3
SysDoLoop_E3:
;I2CByte = TWSR & 0xF8
	ldi	SysTemp4,248
	lds	SysTemp3,TWSR
	and	SysTemp3,SysTemp4
	sts	I2CBYTE,SysTemp3
;extended code to ensure compiler gets the correctly.
;if I2CByte = AVR_I2C_START then
	lds	SysCalcTempA,I2CBYTE
	cpi	SysCalcTempA,8
	brne	ELSE25_1
;HI2CStartOccurred = true
	rcall	FN_HI2CSTARTOCCURRED
;goto exitAVRHI2CReStart
	rjmp	EXITAVRHI2CRESTART
;else
	rjmp	ENDIF25
ELSE25_1:
;HI2CStartOccurred = false
	rcall	FN_HI2CSTARTOCCURRED
;end if
ENDIF25:
;if I2CByte = AVR_I2C_ReSTART then
	lds	SysCalcTempA,I2CBYTE
	cpi	SysCalcTempA,16
	brne	ELSE26_1
;HI2CStartOccurred = true
	rcall	FN_HI2CSTARTOCCURRED
;goto exitAVRHI2CReStart
	rjmp	EXITAVRHI2CRESTART
;else
	rjmp	ENDIF26
ELSE26_1:
;HI2CStartOccurred = false
	rcall	FN_HI2CSTARTOCCURRED
;end if
ENDIF26:
EXITAVRHI2CRESTART:
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
SysDoLoop_S4:
	lds	SysBitTest,TWCR
	sbrc	SysBitTest,TWINT
	rjmp	SysDoLoop_E4
;loop
	rjmp	SysDoLoop_S4
SysDoLoop_E4:
;Destructive use of I2CByte to save memory
;I2CByte = TWSR & 0xF8
	ldi	SysTemp4,248
	lds	SysTemp3,TWSR
	and	SysTemp3,SysTemp4
	sts	I2CBYTE,SysTemp3
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
	brne	ENDIF23
;assume MASTER
;HI2CMode Master
	ldi	SysValueCopy,12
	sts	HI2CCURRENTMODE,SysValueCopy
	rcall	AVRHI2CMODE
;end if
ENDIF23:
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
	ldi	SysTemp4,248
	lds	SysTemp3,TWSR
	and	SysTemp3,SysTemp4
	sts	I2CBYTE,SysTemp3
;if I2CByte = AVR_I2C_START then
	lds	SysCalcTempA,I2CBYTE
	cpi	SysCalcTempA,8
	brne	ELSE24_1
;HI2CStartOccurred = true
	rcall	FN_HI2CSTARTOCCURRED
;else
	rjmp	ENDIF24
ELSE24_1:
;HI2CStartOccurred = false
	rcall	FN_HI2CSTARTOCCURRED
;end if
ENDIF24:
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

FN_HI2CSTARTOCCURRED:
;Master mode
;Always return true
;If HI2CCurrentMode > 10 Then
	ldi	SysCalcTempA,10
	lds	SysCalcTempB,HI2CCURRENTMODE
	cp	SysCalcTempA,SysCalcTempB
	brsh	ELSE29_1
;HI2CStartOccurred = TRUE
	ldi	SysValueCopy,255
	sts	HI2CSTARTOCCURRED,SysValueCopy
;Exit Function
	ret
;Slave mode, check if start condition received last
;Else
	rjmp	ENDIF29
ELSE29_1:
;HI2CStartOccurred = FALSE
	ldi	SysValueCopy,0
	sts	HI2CSTARTOCCURRED,SysValueCopy
;End If
ENDIF29:
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
HSERPRINT265:
;PrintLen = LEN(PrintData$)
;PrintLen = PrintData(0)
	lds	SysStringA,SysPRINTDATAHandler
	lds	SysStringA_H,SysPRINTDATAHandler_H
	ld	SysValueCopy,X
	sts	PRINTLEN,SysValueCopy
;If PrintLen <> 0 then
	lds	SysCalcTempA,PRINTLEN
	tst	SysCalcTempA
	breq	ENDIF14
;Write Data
;for SysPrintTemp = 1 to PrintLen
	ldi	SysValueCopy,0
	sts	SYSPRINTTEMP,SysValueCopy
	lds	SysCalcTempA,PRINTLEN
	cpi	SysCalcTempA,1
	brlo	SysForLoopEnd1
SysForLoop1:
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
	rcall	HSERSEND
;next
	lds	SysCalcTempA,SYSPRINTTEMP
	lds	SysCalcTempB,PRINTLEN
	cp	SysCalcTempA,SysCalcTempB
	brlo	SysForLoop1
SysForLoopEnd1:
;End If
ENDIF14:
;CR
	ret

;********************************************************************************

;Overloaded signature: WORD:byte:
HSERPRINT267:
;Dim SysCalcTempX As Word
;OutValueTemp = 0
	ldi	SysValueCopy,0
	sts	OUTVALUETEMP,SysValueCopy
;If SerPrintVal >= 10000 then
	lds	SysWORDTempA,SERPRINTVAL
	lds	SysWORDTempA_H,SERPRINTVAL_H
	ldi	SysWORDTempB,16
	ldi	SysWORDTempB_H,39
	rcall	SysCompLessThan16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF17
;OutValueTemp = SerPrintVal / 10000 [word]
	lds	SysWORDTempA,SERPRINTVAL
	lds	SysWORDTempA_H,SERPRINTVAL_H
	ldi	SysWORDTempB,16
	ldi	SysWORDTempB_H,39
	rcall	SysDivSub16
	sts	OUTVALUETEMP,SysWORDTempA
;SerPrintVal = SysCalcTempX
	sts	SERPRINTVAL,SYSCALCTEMPX
	sts	SERPRINTVAL_H,SYSCALCTEMPX_H
;HSerSend(OutValueTemp + 48 ,comport )
	lds	SysTemp3,OUTVALUETEMP
	ldi	SysTemp4,48
	add	SysTemp3,SysTemp4
	sts	SERDATA,SysTemp3
	rcall	HSERSEND
;Goto HSerPrintWord1000
	rjmp	HSERPRINTWORD1000
;End If
ENDIF17:
;If SerPrintVal >= 1000 then
	lds	SysWORDTempA,SERPRINTVAL
	lds	SysWORDTempA_H,SERPRINTVAL_H
	ldi	SysWORDTempB,232
	ldi	SysWORDTempB_H,3
	rcall	SysCompLessThan16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF18
HSERPRINTWORD1000:
;OutValueTemp = SerPrintVal / 1000 [word]
	lds	SysWORDTempA,SERPRINTVAL
	lds	SysWORDTempA_H,SERPRINTVAL_H
	ldi	SysWORDTempB,232
	ldi	SysWORDTempB_H,3
	rcall	SysDivSub16
	sts	OUTVALUETEMP,SysWORDTempA
;SerPrintVal = SysCalcTempX
	sts	SERPRINTVAL,SYSCALCTEMPX
	sts	SERPRINTVAL_H,SYSCALCTEMPX_H
;HSerSend(OutValueTemp + 48 ,comport  )
	lds	SysTemp3,OUTVALUETEMP
	ldi	SysTemp4,48
	add	SysTemp3,SysTemp4
	sts	SERDATA,SysTemp3
	rcall	HSERSEND
;Goto HSerPrintWord100
	rjmp	HSERPRINTWORD100
;End If
ENDIF18:
;If SerPrintVal >= 100 then
	lds	SysWORDTempA,SERPRINTVAL
	lds	SysWORDTempA_H,SERPRINTVAL_H
	ldi	SysWORDTempB,100
	ldi	SysWORDTempB_H,0
	rcall	SysCompLessThan16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF19
HSERPRINTWORD100:
;OutValueTemp = SerPrintVal / 100 [word]
	lds	SysWORDTempA,SERPRINTVAL
	lds	SysWORDTempA_H,SERPRINTVAL_H
	ldi	SysWORDTempB,100
	ldi	SysWORDTempB_H,0
	rcall	SysDivSub16
	sts	OUTVALUETEMP,SysWORDTempA
;SerPrintVal = SysCalcTempX
	sts	SERPRINTVAL,SYSCALCTEMPX
	sts	SERPRINTVAL_H,SYSCALCTEMPX_H
;HSerSend(OutValueTemp + 48 ,comport )
	lds	SysTemp3,OUTVALUETEMP
	ldi	SysTemp4,48
	add	SysTemp3,SysTemp4
	sts	SERDATA,SysTemp3
	rcall	HSERSEND
;Goto HSerPrintWord10
	rjmp	HSERPRINTWORD10
;End If
ENDIF19:
;If SerPrintVal >= 10 then
	lds	SysWORDTempA,SERPRINTVAL
	lds	SysWORDTempA_H,SERPRINTVAL_H
	ldi	SysWORDTempB,10
	ldi	SysWORDTempB_H,0
	rcall	SysCompLessThan16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF20
HSERPRINTWORD10:
;OutValueTemp = SerPrintVal / 10 [word]
	lds	SysWORDTempA,SERPRINTVAL
	lds	SysWORDTempA_H,SERPRINTVAL_H
	ldi	SysWORDTempB,10
	ldi	SysWORDTempB_H,0
	rcall	SysDivSub16
	sts	OUTVALUETEMP,SysWORDTempA
;SerPrintVal = SysCalcTempX
	sts	SERPRINTVAL,SYSCALCTEMPX
	sts	SERPRINTVAL_H,SYSCALCTEMPX_H
;HSerSend(OutValueTemp + 48 ,comport )
	lds	SysTemp3,OUTVALUETEMP
	ldi	SysTemp4,48
	add	SysTemp3,SysTemp4
	sts	SERDATA,SysTemp3
	rcall	HSERSEND
;End If
ENDIF20:
;HSerSend(SerPrintVal + 48 ,comport  )
	lds	SysTemp3,SERPRINTVAL
	ldi	SysTemp4,48
	add	SysTemp3,SysTemp4
	sts	SERDATA,SysTemp3
	rcall	HSERSEND
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
	lds	SysTemp3,SysRepeatTemp1
	dec	SysTemp3
	sts	SysRepeatTemp1,SysTemp3
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
	brne	ENDIF13
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
ENDIF13:
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

;Overloaded signature: BYTE:BYTE:
INITTIMER0162:
;Just need to buffer TMR0Pres
;(And change it for external clock)
;TMRPres, TMRSource now shared and local - WMR
;TMR0_TMP now used as shadow register    - WMR
;If TMRSource = Ext Then
	lds	SysCalcTempA,TMRSOURCE
	cpi	SysCalcTempA,2
	brne	ENDIF28
;TMRPres = AVR_EXT_TMR_0_RE
	ldi	SysValueCopy,7
	sts	TMRPRES,SysValueCopy
;End If
ENDIF28:
;TMR0_TMP = TMRPres
	lds	SysValueCopy,TMRPRES
	sts	TMR0_TMP,SysValueCopy
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

INIT_MSCTR_INT:
;Add the handler for the interrupt
;On Interrupt Timer0Overflow Call MsCtr_Int_Hdlr
	lds	SysValueCopy,TIMSK0
	sbr	SysValueCopy,1<<TOIE0
	sts	TIMSK0,SysValueCopy
;MsCtr_ = 0
	ldi	SysValueCopy,0
	sts	MSCTR_,SysValueCopy
	sts	MSCTR__H,SysValueCopy
	sts	MSCTR__U,SysValueCopy
	sts	MSCTR__E,SysValueCopy
;Millis = 0
	rcall	FN_MILLIS
;Set prescaler to 64, Preload and then start the timer
;InitTimer0 Osc, PS_0_64
	ldi	SysValueCopy,1
	sts	TMRSOURCE,SysValueCopy
	ldi	SysValueCopy,3
	sts	TMRPRES,SysValueCopy
	rcall	INITTIMER0162
;asm ShowDebug  Call_SetTimer_Millis_macro
;call_settimer_millis_macro
;SetTimer_Millis Tmr0InitVal
;Handle chips withOUT TMR0H
;TMR0 = TMRValueMillis
	ldi	SysValueCopy,6
	sts	TMR0,SysValueCopy
;asm ShowDebug Call_StartTimer_Millis_macro
;call_starttimer_millis_macro
;StartTimer_Millis
;Need to set clock select bits to 0 (Stops Timer)
;TCCR0B = TCCR0B And 248 Or TMR0_TMP
	ldi	SysTemp4,248
	in	SysTemp1,TCCR0B
	and	SysTemp1,SysTemp4
	mov	SysTemp3,SysTemp1
	lds	SysTemp1,TMR0_TMP
	or	SysTemp1,SysTemp3
	out	TCCR0B,SysTemp1
	ret

;********************************************************************************

IntTIMER0_OVF:
	rcall	SysIntContextSave
	rcall	MSCTR_INT_HDLR
	cbi	TIFR0,TOV0
	rjmp	SysIntContextRestore

;********************************************************************************

FN_MILLIS:
;dim Millis, MsCtr_ as long
;disable interrupts while we read millis or we might get an
;inconsistent value (e.g. in the middle of a write to millis)
;IntOff
	lds	SysValueCopy,SYSINTSTATESAVE0
	cbr	SysValueCopy,1<<0
	brbc	I,PC + 2
	sbr	SysValueCopy,1<<0
	sts	SYSINTSTATESAVE0,SysValueCopy
	cli
;Millis = MsCtr_
	lds	SysValueCopy,MSCTR_
	sts	MILLIS,SysValueCopy
	lds	SysValueCopy,MSCTR__H
	sts	MILLIS_H,SysValueCopy
	lds	SysValueCopy,MSCTR__U
	sts	MILLIS_U,SysValueCopy
	lds	SysValueCopy,MSCTR__E
	sts	MILLIS_E,SysValueCopy
;IntOn
	lds	SysBitTest,SYSINTSTATESAVE0
	sbrc	SysBitTest,0
	sei
	ret

;********************************************************************************

MSCTR_INT_HDLR:
;dim MsCtr_ as Long
;asm ShowDebug Call_SetTimer_Millis_macro
;call_settimer_millis_macro
;SetTimer_Millis  Tmr0InitVal   ' Reset Inital Counter valueue
;Handle chips withOUT TMR0H
;TMR0 = TMRValueMillis
	ldi	SysValueCopy,6
	sts	TMR0,SysValueCopy
;MsCtr_ = MsCtr_ + 1
	lds	SysTemp3,MSCTR_
	inc	SysTemp3
	sts	MSCTR_,SysTemp3
	lds	SysTemp3,MSCTR__H
	brne	PC + 2
	inc	SysTemp3
	sts	MSCTR__H,SysTemp3
	lds	SysTemp3,MSCTR__U
	brne	PC + 2
	inc	SysTemp3
	sts	MSCTR__U,SysTemp3
	lds	SysTemp3,MSCTR__E
	brne	PC + 2
	inc	SysTemp3
	sts	MSCTR__E,SysTemp3
	ret

;********************************************************************************

READ_HUMIDITY:
;Hi2CStart
	rcall	AVRHI2CSTART
;HI2cSend (0x80)  'Write
	ldi	SysValueCopy,128
	sts	I2CBYTE,SysValueCopy
	rcall	AVRHI2CSEND
;Hi2cSend (0xF5)
	ldi	SysValueCopy,245
	sts	I2CBYTE,SysValueCopy
	rcall	AVRHI2CSEND
;Hi2CReStart
	rcall	AVRHI2CRESTART
;HI2CSend (0x81)  'read
	ldi	SysValueCopy,129
	sts	I2CBYTE,SysValueCopy
	rcall	AVRHI2CSEND
;wait 50 ms   ' for conversion ( could be less)
	ldi	SysWaitTempMS,50
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;Hi2CReStart
	rcall	AVRHI2CRESTART
;HI2CSend (0x81)  'read
	ldi	SysValueCopy,129
	sts	I2CBYTE,SysValueCopy
	rcall	AVRHI2CSEND
;Hi2CReceive (Si7021_HighByte, ACK)
	ldi	SysValueCopy,255
	sts	HI2CGETACK,SysValueCopy
	rcall	AVRHI2CRECEIVE
	lds	SysValueCopy,I2CBYTE
	sts	SI7021_HIGHBYTE,SysValueCopy
;Hi2CReceive (Si7021_Lowbyte, NACK)
	ldi	SysValueCopy,0
	sts	HI2CGETACK,SysValueCopy
	rcall	AVRHI2CRECEIVE
	lds	SysValueCopy,I2CBYTE
	sts	SI7021_LOWBYTE,SysValueCopy
;Hi2Cstop
	rcall	AVRHI2CSTOP
;now do the maths
;Humidity = (([long]SiRaw * 125) / 65536) -6
	lds	SysLONGTempA,SIRAW
	lds	SysLONGTempA_H,SIRAW_H
	ldi	SysLONGTempA_U,0
	ldi	SysLONGTempA_E,0
	ldi	SysLONGTempB,125
	ldi	SysLONGTempB_H,0
	ldi	SysLONGTempB_U,0
	ldi	SysLONGTempB_E,0
	rcall	SysMultSub32
	mov	SysTemp1,SysLONGTempX
	mov	SysTemp1_H,SysLONGTempX_H
	mov	SysTemp1_U,SysLONGTempX_U
	mov	SysTemp1_E,SysLONGTempX_E
	mov	SysLONGTempA,SysTemp1
	mov	SysLONGTempA_H,SysTemp1_H
	mov	SysLONGTempA_U,SysTemp1_U
	mov	SysLONGTempA_E,SysTemp1_E
	ldi	SysLONGTempB,0
	ldi	SysLONGTempB_H,0
	ldi	SysLONGTempB_U,1
	ldi	SysLONGTempB_E,0
	rcall	SysDivSub32
	mov	SysTemp2,SysLONGTempA
	mov	SysTemp2_H,SysLONGTempA_H
	mov	SysTemp2_U,SysLONGTempA_U
	mov	SysTemp2_E,SysLONGTempA_E
	ldi	SysTemp4,6
	sub	SysTemp2,SysTemp4
	sts	HUMIDITY,SysTemp2
	ldi	SysTemp4,0
	sbc	SysTemp2_H,SysTemp4
	sts	HUMIDITY_H,SysTemp2_H
;Locate 1,12
;If Humidity  < 10 then hserPrint "0"
	lds	SysWORDTempA,HUMIDITY
	lds	SysWORDTempA_H,HUMIDITY_H
	ldi	SysWORDTempB,10
	ldi	SysWORDTempB_H,0
	rcall	SysCompLessThan16
	sbrs	SysByteTempX,0
	rjmp	ENDIF2
	ldi	SysStringB,low(SYSSTRINGPARAM2)
	ldi	SysStringB_H,high(SYSSTRINGPARAM2)
	ldi	SysReadA,low(StringTable2<<1)
	ldi	SysReadA_H,high(StringTable2<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM2)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM2)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT265
ENDIF2:
;hserPrint "Humidity="+str(Humidity) : hserPrint "%"
	lds	SysValueCopy,HUMIDITY
	sts	SYSVALTEMP,SysValueCopy
	lds	SysValueCopy,HUMIDITY_H
	sts	SYSVALTEMP_H,SysValueCopy
	rcall	FN_STR
	ldi	SysStringB,low(SYSSTRINGPARAM2)
	ldi	SysStringB_H,high(SYSSTRINGPARAM2)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysReadA,low(StringTable3<<1)
	ldi	SysReadA_H,high(StringTable3<<1)
	rcall	SysReadStringPart
	ldi	SysStringA,low(STR)
	ldi	SysStringA_H,high(STR)
	rcall	SysCopyStringPart
	ldi	SysStringA,low(SYSSTRINGPARAM2)
	ldi	SysStringA_H,high(SYSSTRINGPARAM2)
	st	X, SysStringLength
	ldi	SysValueCopy,low(SYSSTRINGPARAM2)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM2)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT265
	ldi	SysStringB,low(SYSSTRINGPARAM2)
	ldi	SysStringB_H,high(SYSSTRINGPARAM2)
	ldi	SysReadA,low(StringTable4<<1)
	ldi	SysReadA_H,high(StringTable4<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM2)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM2)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rjmp	HSERPRINT265

;********************************************************************************

READ_TEMPERATURE:
;Hi2CStart
	rcall	AVRHI2CSTART
;HI2CSend (0x80)  'Write
	ldi	SysValueCopy,128
	sts	I2CBYTE,SysValueCopy
	rcall	AVRHI2CSEND
;Hi2cSend (0xE0)
	ldi	SysValueCopy,224
	sts	I2CBYTE,SysValueCopy
	rcall	AVRHI2CSEND
;Hi2CReStart
	rcall	AVRHI2CRESTART
;HI2CSend (0x81)  'read
	ldi	SysValueCopy,129
	sts	I2CBYTE,SysValueCopy
	rcall	AVRHI2CSEND
;Hi2CReceive (Si7021_HighByte, ACK)
	ldi	SysValueCopy,255
	sts	HI2CGETACK,SysValueCopy
	rcall	AVRHI2CRECEIVE
	lds	SysValueCopy,I2CBYTE
	sts	SI7021_HIGHBYTE,SysValueCopy
;Hi2CReceive (Si7021_Lowbyte, NACK)
	ldi	SysValueCopy,0
	sts	HI2CGETACK,SysValueCopy
	rcall	AVRHI2CRECEIVE
	lds	SysValueCopy,I2CBYTE
	sts	SI7021_LOWBYTE,SysValueCopy
;Hi2Cstop
	rcall	AVRHI2CSTOP
;wait 20 ms
	ldi	SysWaitTempMS,20
	ldi	SysWaitTempMS_H,0
	rcall	Delay_MS
;TemperatureC = (([long]SiRaw * 17572) / 65536) - 4685
	lds	SysLONGTempA,SIRAW
	lds	SysLONGTempA_H,SIRAW_H
	ldi	SysLONGTempA_U,0
	ldi	SysLONGTempA_E,0
	ldi	SysLONGTempB,164
	ldi	SysLONGTempB_H,68
	ldi	SysLONGTempB_U,0
	ldi	SysLONGTempB_E,0
	rcall	SysMultSub32
	mov	SysTemp1,SysLONGTempX
	mov	SysTemp1_H,SysLONGTempX_H
	mov	SysTemp1_U,SysLONGTempX_U
	mov	SysTemp1_E,SysLONGTempX_E
	mov	SysLONGTempA,SysTemp1
	mov	SysLONGTempA_H,SysTemp1_H
	mov	SysLONGTempA_U,SysTemp1_U
	mov	SysLONGTempA_E,SysTemp1_E
	ldi	SysLONGTempB,0
	ldi	SysLONGTempB_H,0
	ldi	SysLONGTempB_U,1
	ldi	SysLONGTempB_E,0
	rcall	SysDivSub32
	mov	SysTemp2,SysLONGTempA
	mov	SysTemp2_H,SysLONGTempA_H
	mov	SysTemp2_U,SysLONGTempA_U
	mov	SysTemp2_E,SysLONGTempA_E
	ldi	SysTemp4,77
	sub	SysTemp2,SysTemp4
	sts	TEMPERATUREC,SysTemp2
	ldi	SysTemp4,18
	sbc	SysTemp2_H,SysTemp4
	sts	TEMPERATUREC_H,SysTemp2_H
;TemperatureF =   (([long]TemperatureC * 9) /5) + 3200
	lds	SysLONGTempA,TEMPERATUREC
	lds	SysLONGTempA_H,TEMPERATUREC_H
	ldi	SysLONGTempA_U,0
	ldi	SysLONGTempA_E,0
	ldi	SysLONGTempB,9
	ldi	SysLONGTempB_H,0
	ldi	SysLONGTempB_U,0
	ldi	SysLONGTempB_E,0
	rcall	SysMultSub32
	mov	SysTemp1,SysLONGTempX
	mov	SysTemp1_H,SysLONGTempX_H
	mov	SysTemp1_U,SysLONGTempX_U
	mov	SysTemp1_E,SysLONGTempX_E
	mov	SysLONGTempA,SysTemp1
	mov	SysLONGTempA_H,SysTemp1_H
	mov	SysLONGTempA_U,SysTemp1_U
	mov	SysLONGTempA_E,SysTemp1_E
	ldi	SysLONGTempB,5
	ldi	SysLONGTempB_H,0
	ldi	SysLONGTempB_U,0
	ldi	SysLONGTempB_E,0
	rcall	SysDivSub32
	mov	SysTemp2,SysLONGTempA
	mov	SysTemp2_H,SysLONGTempA_H
	mov	SysTemp2_U,SysLONGTempA_U
	mov	SysTemp2_E,SysLONGTempA_E
	ldi	SysTemp4,128
	add	SysTemp2,SysTemp4
	sts	TEMPERATUREF,SysTemp2
	ldi	SysTemp4,12
	adc	SysTemp2_H,SysTemp4
	sts	TEMPERATUREF_H,SysTemp2_H
;Hundredths = TemperatureF % 100  'Modulu Divide
	lds	SysWORDTempA,TEMPERATUREF
	lds	SysWORDTempA_H,TEMPERATUREF_H
	ldi	SysWORDTempB,100
	ldi	SysWORDTempB_H,0
	rcall	SysDivSub16
	sts	HUNDREDTHS,SysWORDTempX
;TemperatureF = TemperatureF / 100
	lds	SysWORDTempA,TEMPERATUREF
	lds	SysWORDTempA_H,TEMPERATUREF_H
	ldi	SysWORDTempB,100
	ldi	SysWORDTempB_H,0
	rcall	SysDivSub16
	sts	TEMPERATUREF,SysWORDTempA
	sts	TEMPERATUREF_H,SysWORDTempA_H
;Hundredths = TemperatureC % 100  'Modulu Divide
	lds	SysWORDTempA,TEMPERATUREC
	lds	SysWORDTempA_H,TEMPERATUREC_H
	ldi	SysWORDTempB,100
	ldi	SysWORDTempB_H,0
	rcall	SysDivSub16
	sts	HUNDREDTHS,SysWORDTempX
;TemperatureC = TemperatureC / 100
	lds	SysWORDTempA,TEMPERATUREC
	lds	SysWORDTempA_H,TEMPERATUREC_H
	ldi	SysWORDTempB,100
	ldi	SysWORDTempB_H,0
	rcall	SysDivSub16
	sts	TEMPERATUREC,SysWORDTempA
	sts	TEMPERATUREC_H,SysWORDTempA_H
;HSerPrintCRLF
	ldi	SysValueCopy,1
	sts	HSERPRINTCRLFCOUNT,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINTCRLF
;HSerPrint SiRaw
	lds	SysValueCopy,SIRAW
	sts	SERPRINTVAL,SysValueCopy
	lds	SysValueCopy,SIRAW_H
	sts	SERPRINTVAL_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT267
;HSerPrint ": "
	ldi	SysStringB,low(SYSSTRINGPARAM2)
	ldi	SysStringB_H,high(SYSSTRINGPARAM2)
	ldi	SysReadA,low(StringTable5<<1)
	ldi	SysReadA_H,high(StringTable5<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM2)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM2)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT265
;hserPrint "Temp ="+str(TemperatureC) : hserPrint "." : hserPrint str(Hundredths)+" "
	lds	SysValueCopy,TEMPERATUREC
	sts	SYSVALTEMP,SysValueCopy
	lds	SysValueCopy,TEMPERATUREC_H
	sts	SYSVALTEMP_H,SysValueCopy
	rcall	FN_STR
	ldi	SysStringB,low(SYSSTRINGPARAM2)
	ldi	SysStringB_H,high(SYSSTRINGPARAM2)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysReadA,low(StringTable6<<1)
	ldi	SysReadA_H,high(StringTable6<<1)
	rcall	SysReadStringPart
	ldi	SysStringA,low(STR)
	ldi	SysStringA_H,high(STR)
	rcall	SysCopyStringPart
	ldi	SysStringA,low(SYSSTRINGPARAM2)
	ldi	SysStringA_H,high(SYSSTRINGPARAM2)
	st	X, SysStringLength
	ldi	SysValueCopy,low(SYSSTRINGPARAM2)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM2)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT265
	ldi	SysStringB,low(SYSSTRINGPARAM2)
	ldi	SysStringB_H,high(SYSSTRINGPARAM2)
	ldi	SysReadA,low(StringTable7<<1)
	ldi	SysReadA_H,high(StringTable7<<1)
	rcall	SysReadString
	ldi	SysValueCopy,low(SYSSTRINGPARAM2)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM2)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rcall	HSERPRINT265
	lds	SysValueCopy,HUNDREDTHS
	sts	SYSVALTEMP,SysValueCopy
	ldi	SysValueCopy,0
	sts	SYSVALTEMP_H,SysValueCopy
	rcall	FN_STR
	ldi	SysStringB,low(SYSSTRINGPARAM2)
	ldi	SysStringB_H,high(SYSSTRINGPARAM2)
	clr	SysStringLength
	ld	SysValueCopy, Y+
	ldi	SysStringA,low(STR)
	ldi	SysStringA_H,high(STR)
	rcall	SysCopyStringPart
	ldi	SysReadA,low(StringTable8<<1)
	ldi	SysReadA_H,high(StringTable8<<1)
	rcall	SysReadStringPart
	ldi	SysStringA,low(SYSSTRINGPARAM2)
	ldi	SysStringA_H,high(SYSSTRINGPARAM2)
	st	X, SysStringLength
	ldi	SysValueCopy,low(SYSSTRINGPARAM2)
	sts	SysPRINTDATAHandler,SysValueCopy
	ldi	SysValueCopy,high(SYSSTRINGPARAM2)
	sts	SysPRINTDATAHandler_H,SysValueCopy
	ldi	SysValueCopy,1
	sts	COMPORT,SysValueCopy
	rjmp	HSERPRINT265

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
	rjmp	ENDIF9
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
	lds	SysTemp3,SYSCHARCOUNT
	inc	SysTemp3
	sts	SYSCHARCOUNT,SysTemp3
;Str(SysCharCount) = SysStrData + 48
	ldi	SysTemp4,low(STR)
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	ldi	SysTemp4,0
	ldi	SysTemp5,high(STR)
	adc	SysTemp4,SysTemp5
	mov	SysStringA_H,SysTemp4
	lds	SysTemp3,SYSSTRDATA
	ldi	SysTemp4,48
	add	SysTemp3,SysTemp4
	st	X,SysTemp3
;Goto SysValThousands
	rjmp	SYSVALTHOUSANDS
;End If
ENDIF9:
;Thousands
;IF SysValTemp >= 1000 then
	lds	SysWORDTempA,SYSVALTEMP
	lds	SysWORDTempA_H,SYSVALTEMP_H
	ldi	SysWORDTempB,232
	ldi	SysWORDTempB_H,3
	rcall	SysCompLessThan16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF10
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
	lds	SysTemp3,SYSCHARCOUNT
	inc	SysTemp3
	sts	SYSCHARCOUNT,SysTemp3
;Str(SysCharCount) = SysStrData + 48
	ldi	SysTemp4,low(STR)
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	ldi	SysTemp4,0
	ldi	SysTemp5,high(STR)
	adc	SysTemp4,SysTemp5
	mov	SysStringA_H,SysTemp4
	lds	SysTemp3,SYSSTRDATA
	ldi	SysTemp4,48
	add	SysTemp3,SysTemp4
	st	X,SysTemp3
;Goto SysValHundreds
	rjmp	SYSVALHUNDREDS
;End If
ENDIF10:
;Hundreds
;IF SysValTemp >= 100 then
	lds	SysWORDTempA,SYSVALTEMP
	lds	SysWORDTempA_H,SYSVALTEMP_H
	ldi	SysWORDTempB,100
	ldi	SysWORDTempB_H,0
	rcall	SysCompLessThan16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF11
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
	lds	SysTemp3,SYSCHARCOUNT
	inc	SysTemp3
	sts	SYSCHARCOUNT,SysTemp3
;Str(SysCharCount) = SysStrData + 48
	ldi	SysTemp4,low(STR)
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	ldi	SysTemp4,0
	ldi	SysTemp5,high(STR)
	adc	SysTemp4,SysTemp5
	mov	SysStringA_H,SysTemp4
	lds	SysTemp3,SYSSTRDATA
	ldi	SysTemp4,48
	add	SysTemp3,SysTemp4
	st	X,SysTemp3
;Goto SysValTens
	rjmp	SYSVALTENS
;End If
ENDIF11:
;Tens
;IF SysValTemp >= 10 Then
	lds	SysWORDTempA,SYSVALTEMP
	lds	SysWORDTempA_H,SYSVALTEMP_H
	ldi	SysWORDTempB,10
	ldi	SysWORDTempB_H,0
	rcall	SysCompLessThan16
	com	SysByteTempX
	sbrs	SysByteTempX,0
	rjmp	ENDIF12
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
	lds	SysTemp3,SYSCHARCOUNT
	inc	SysTemp3
	sts	SYSCHARCOUNT,SysTemp3
;Str(SysCharCount) = SysStrData + 48
	ldi	SysTemp4,low(STR)
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	ldi	SysTemp4,0
	ldi	SysTemp5,high(STR)
	adc	SysTemp4,SysTemp5
	mov	SysStringA_H,SysTemp4
	lds	SysTemp3,SYSSTRDATA
	ldi	SysTemp4,48
	add	SysTemp3,SysTemp4
	st	X,SysTemp3
;End If
ENDIF12:
;Ones
;SysCharCount += 1
	lds	SysTemp3,SYSCHARCOUNT
	inc	SysTemp3
	sts	SYSCHARCOUNT,SysTemp3
;Str(SysCharCount) = SysValTemp + 48
	ldi	SysTemp4,low(STR)
	add	SysTemp3,SysTemp4
	mov	SysStringA,SysTemp3
	ldi	SysTemp4,0
	ldi	SysTemp5,high(STR)
	adc	SysTemp4,SysTemp5
	mov	SysStringA_H,SysTemp4
	lds	SysTemp3,SYSVALTEMP
	ldi	SysTemp4,48
	add	SysTemp3,SysTemp4
	st	X,SysTemp3
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
	rjmp	ENDIF5
;SysWordTempA = 0
	ldi	SYSWORDTEMPA,0
	ldi	SYSWORDTEMPA_H,0
;exit sub
	ret
;end if
ENDIF5:
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
	brbc	C,ENDIF6
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
ENDIF6:
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
	rjmp	ENDIF7
;SysLongTempA = 0
	ldi	SYSLONGTEMPA,0
	ldi	SYSLONGTEMPA_H,0
	ldi	SYSLONGTEMPA_U,0
	ldi	SYSLONGTEMPA_E,0
;exit sub
	ret
;end if
ENDIF7:
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
	brbc	C,ENDIF8
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
ENDIF8:
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
	rjmp	ENDIF3
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
ENDIF3:
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
ENDIF4:
;SysLongTempX = SysLongDivMultX
	lds	SYSLONGTEMPX,SYSLONGDIVMULTX
	lds	SYSLONGTEMPX_H,SYSLONGDIVMULTX_H
	lds	SYSLONGTEMPX_U,SYSLONGDIVMULTX_U
	lds	SYSLONGTEMPX_E,SYSLONGDIVMULTX_E
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

SysIntContextRestore:
;Restore registers
	lds	SysTemp3,SaveSysTemp3
;Restore SREG
	lds	SysValueCopy,SaveSREG
	out	SREG,SysValueCopy
;Restore SysValueCopy
	lds	SysValueCopy,SaveSysValueCopy
	reti

;********************************************************************************

SysIntContextSave:
;Store SysValueCopy
	sts	SaveSysValueCopy,SysValueCopy
;Store SREG
	in	SysValueCopy,SREG
	sts	SaveSREG,SysValueCopy
;Store registers
	sts	SaveSysTemp3,SysTemp3
	ret

;********************************************************************************

SysStringTables:

StringTable1:
.DB	42,83,105,55,48,50,49,32,73,50,67,32,72,85,77,73,68,73,84,89,32,65,78,68,32,84,69,77,80,69,82,65,84,85,82,69,32,83,69,78,83,79,82,0


StringTable2:
.DB	1,48


StringTable3:
.DB	9,72,117,109,105,100,105,116,121,61


StringTable4:
.DB	1,37


StringTable5:
.DB	2,58,32,0


StringTable6:
.DB	6,84,101,109,112,32,61,0


StringTable7:
.DB	1,46


StringTable8:
.DB	1,32


;********************************************************************************


