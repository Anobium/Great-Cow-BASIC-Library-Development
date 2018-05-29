;*****************************************************************************************************
;
;	USB PIC12F1822
;
;*****************************************************************************************************

	list		p=12F1822      ; list directive to define processor
	#include	<p12F1822.inc> ; processor specific variable definitions
	errorlevel	-302

    __CONFIG _CONFIG1, _FOSC_ECH & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _CP_OFF & _CPD_OFF & _BOREN_OFF & _CLKOUTEN_OFF & _IESO_OFF & _FCMEN_OFF
    __CONFIG _CONFIG2, _WRT_OFF & _PLLEN_OFF & _STVREN_OFF & _BORV_19 & _LVP_OFF

#define INDF		INDF0
#define FSR		FSR0L
#define TRISIO		TRISA
#define GPIO		PORTA
#define ANSEL		ANSELA

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	<HID Data Format>
;
;       HOST to Device                                 Device to HOST
;       +-----------+-------+---------------------+    +-------+-------+---------------+
;       |   Upper   | Lower |     Command/Data    |    | Upper | Lower |      Data     |
;       +===========+=======+=====================+    +=======+=======+===============+
;       |0x80|SPBRGH| SPBRGL| Set Baud rate       |    |  any  | RData | Received Data |
;       +-----------+-------+---------------------+    +-------+-------+---------------+
;       |   0x00    | SData | Sending Serial Data |    Default: 8bit, No parity, 1 stop bit, 115200bps
;       +-----------+-------+---------------------+   =================================================
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;****************************************************************************
;
;	DEFINICION DE ETIQUETAS Y VARIABLES
;
;****************************************************************************
;PORT/PIN
TX			EQU		0
RX			EQU		1
DataMenos		EQU		4
DataMas			EQU		2
SE0			EQU		3
OSC1			EQU		5

;RAM-Variables
Banderas_0		EQU		0x20
Banderas_1		EQU		0x21
ByteAMandar		EQU		0x22
Veces			EQU		0x23
RecNRZI_0		EQU		0x24
RecNRZI_1		EQU		0x25
RecNRZI_2		EQU		0x26
RecNRZI_3		EQU		0x27
RecNRZI_4		EQU		0x28
RecNRZI_5		EQU		0x29
RecNRZI_6		EQU		0x2A
RecNRZI_7		EQU		0x2B
RecNRZI_8		EQU		0x2C
RecNRZI_9		EQU		0x2D
RecNRZI_A		EQU		0x2E
RecNRZI_B		EQU		0x2F
RecNRZI_C		EQU		0x30
BytesRecibidos		EQU		0x31
NuevoAddress		EQU		0x32
PID			EQU		0x33
Recibido_1		EQU		0x34
Recibido_2		EQU		0x35
Recibido_3		EQU		0x36
Recibido_4		EQU		0x37
Recibido_5		EQU		0x38
Recibido_6		EQU		0x39
Recibido_7		EQU		0x3A
Recibido_8		EQU		0x3B
Recibido_9		EQU		0x3C
Recibido_A		EQU		0x3D
Recibido_B		EQU		0x3E
Recibido_C		EQU		0x3F
Var_0			EQU		0x40
Var_1			EQU		0x41
Posicion		EQU		0x42
RespPID			EQU		0x43
Resp_0			EQU		0x44
Resp_1			EQU		0x45
Resp_2			EQU		0x46
Resp_3			EQU		0x47
Resp_4			EQU		0x48
Resp_5			EQU		0x49
Resp_6			EQU		0x4A
Resp_7			EQU		0x4B
Resp_8			EQU		0x4C
Resp_9			EQU		0x4D
Resp_A			EQU		0x4E
Resp_B			EQU		0x4F
Var_2			EQU		0x50
Var_3			EQU		0x51
Var_4			EQU		0x52
Var_5			EQU		0x53
Var_6			EQU		0x54
Var_7			EQU		0x55
Var_8			EQU		0x56
Var_9			EQU		0x57
DeviceAddress		EQU		0x58
UltAddressRec		EQU		0x59
PosicionPID		EQU		0x5A
Banderas_2		EQU		0x5B

#define AddrAsignOK		Banderas_0, 0
#define	Ocupado			Banderas_0, 3
#define	Setup			Banderas_0, 5
#define AsignAddress		Banderas_1, 0
#define	Data1			Banderas_1, 1
#define INPend			Banderas_1, 3
#define InterruptIN		Banderas_1, 4
#define Stall			Banderas_1, 5
#define ZLPPend			Banderas_1, 6


;****************************************************************************
;
;		+++++++++++++ ASIGNACION DE MEMORIA DE PROGRAMA ++++++++++++++
;
;****************************************************************************

; Programa

	ORG	0x0000				;Vector de Reset

	movlb	0				;Selecciono Banco 0
	CLRF	GPIO				;Limpio GPIO
	GOTO	Configurar

	ORG	0x0004				;Vector de Interrupción

	nop
	GOTO	RecepcionUSB

TMovf
	MOVLW	~((1<<DataMenos)|(1<<DataMas))	;'11111001'
	ANDWF	GPIO, F				;Limpio D+ y D- y dejo el puerto como esta...
	bcf	T2CON,TMR2ON
	bcf	PIR1,TMR2IF
	BSF	Banderas_0, 6
	movlb	1					;Selecciono Banco 1
	MOVLW	((1<<DataMenos)|(1<<SE0)|(1<<DataMas))	;'00001110' SE0, D+, D- entradas
	IORWF	TRISIO,F				;SE0, D+, D- en Tristate
	movlb	0					;Selecciono Banco 0
	GOTO	EsperoContinuacion

Configurar
	movlb	1					;Selecciono Banco 1
	MOVLW	((1<<DataMenos)|(1<<SE0)|(1<<DataMas))	;SE0, D+, D- entradas
	IORWF	TRISIO,F				;Entrada
	MOVLW	0xC1
	MOVWF	OPTION_REG			;Cargo el registro OPTION

	movlb	3
	CLRF	ANSEL				;Selector Analogo deshabilitado
	movlw   B'00100100'		    	;CSRC=0,TX9=0,TXEN=1,SYNC=0(Async mode)
	movwf   TXSTA		    		;SENDB=0,BRGH=1,TRMT=0,TX9D=0
	movlw   B'00001000'		    	;ABDOVF=0,RCIDL=0,SCKP=0,
	movwf   BAUDCON		    		;BRG16=1,WUE=0,ABDEN=0
	movlw   0x33		    		;115200bps X=(24M/115.2K)/4-1=51=0x0033
	movwf   SPBRGL		    		;
	movlw   0x00		    		;
	movwf   SPBRGH		    		;
	movlw   B'10010000'		    	;SPEN=1.RX9=0,SREN=0,CREN=1
	movwf   RCSTA		    		;ADDEN=0,FERR=0,OERR=0,RX9D=0

	movlb	0				;Selecciono Banco 0
	movlw   B'00000001'			;Prescaler=1:4
	movwf   T2CON				;

LoopPrincipal
	CLRF	Banderas_0
	CLRF	Banderas_1
	CLRF	Banderas_2
	MOVLW	0x2A				;'00101010'  Address 0x00 inicialmente en NRZI (7 bits)
	MOVWF	DeviceAddress
EsperoContinuacion
	BCF	Ocupado
	bcf	INTCON, INTF
	bsf	INTCON, INTE
	bsf	INTCON, GIE
EspInt
	call    Main
	BTFSC	GPIO, SE0			;SE0 en "0"?
	GOTO	EspInt
	MOVLW	0x02
	MOVWF	Var_4				;Cargo mi variable con 2 de TimeOut...
DescTimeOut
	BTFSC	GPIO, SE0			;SE0 en "0"
	GOTO	EspInt				;Tedria que haber Interrupción..., la espero...
	DECFSZ	Var_4, F
	GOTO	DescTimeOut
	GOTO	LoopPrincipal			;TimeOut, espero otro Token

RecepcionUSB
	GOTO	$ + 1				;D+ en "0"?		(2)
	BTFSS	GPIO, DataMas			;D+ en "1"?		(3)
	GOTO	RegresardeInterrupt
	GOTO	$ + 1
	BTFSC	GPIO, DataMas			;D+ en "0"?		(4)
	GOTO	RegresardeInterrupt
	GOTO	$ + 1
	BTFSS	GPIO, DataMas			;D+ en "1"?		(5)
	GOTO	RegresardeInterrupt
	GOTO	$ + 1
	BTFSC	GPIO, DataMas			;D+ en "0"?		(6)
	GOTO	RegresardeInterrupt
	GOTO	$ + 1
	BTFSS	GPIO, DataMas			;D+ en "1"?		(7)
	GOTO	RegresardeInterrupt
	MOVLW	RecNRZI_0
	MOVWF	FSR
	BTFSS	GPIO, DataMas			;D+ en "1"?		(8)
	GOTO	RegresardeInterrupt
	CLRF	INDF
	CLRF	PCLATH				;Limpio PCLATH
	BTFSC	GPIO, DataMas			;D+ en "0"?
	BSF	INDF, 0
	GOTO	$ + 1
	BTFSC	GPIO, DataMas			;D+ en "0"?
	BSF	INDF, 1
	GOTO	$ + 1
ContinuoRecibiendo
	BTFSC	GPIO, DataMas			;D+ en "0"?
	BSF	INDF, 2
	BTFSS	GPIO, SE0			;SE0 en "1"?
	GOTO	Identificar_PID
	BTFSC	GPIO, DataMas			;D+ en "0"?
	BSF	INDF, 3
	GOTO	$ + 1				;Pierdo dos ciclo...
	BTFSC	GPIO, DataMas			;D+ en "0"?
	BSF	INDF, 4
	BTFSS	GPIO, SE0			;SE0 en "1"?
	GOTO	Identificar_PID
	BTFSC	GPIO, DataMas			;D+ en "0"?
	BSF	INDF, 5
	MOVFW	RecNRZI_0			;Lo primero que recibo es el PID + PID Inverso (Verificación)
	ANDLW	0x0F				;Solo el PID sin verificación...
	BTFSC	GPIO, DataMas			;D+ en "0"?
	BSF	INDF, 6
	BTFSS	GPIO, SE0			;SE0 en "1"?
	GOTO	Identificar_PID
	BTFSC	GPIO, DataMas			;D+ en "0"?
	BSF	INDF, 7
	INCF	FSR, F
	CLRF	INDF
	BTFSC	GPIO, DataMas			;D+ en "0"?
	BSF	INDF, 0
	BTFSS	GPIO, SE0			;SE0 en "1"?
	GOTO	Identificar_PID
	BTFSC	GPIO, DataMas			;D+ en "0"?
	BSF	INDF, 1
	GOTO	ContinuoRecibiendo

Identificar_PID
	brw
	GOTO	RegresardeInterrupt		;NRZI = 1110	STALL
	GOTO	SETUPToken			;NRZI = 1101	SETUP
	GOTO	RegresardeInterrupt		;NRZI = 1000	SPLIT
	GOTO	DATARecibido			;NRZI = 1011	DATA1
	GOTO	ACKTokenRecibido		;NRZI = 0010	ACK
	GOTO	OUTToken			;NRZI = 0001	OUT
	GOTO	RegresardeInterrupt		;NRZI = 0100	PING
	GOTO	RegresardeInterrupt		;NRZI = 0111	DATA2
	GOTO	RegresardeInterrupt		;NRZI = 0110	NYET
	GOTO	RegresardeInterrupt		;NRZI = 0101	SOF
	GOTO	RegresardeInterrupt		;NRZI = 0000	Reserved PID
	GOTO	DATARecibido			;NRZI = 0011	DATA0
	GOTO	RegresardeInterrupt		;NRZI = 1010	NAK
	GOTO	INToken				;NRZI = 1001	IN
	GOTO	RegresardeInterrupt		;NRZI = 1100	PRE
	GOTO	RegresardeInterrupt		;NRZI = 1111	MDATA

TodaviaNO
	CALL	MandarNAK			;La respuesta no esta lista, mando NAK Handshake
	GOTO	RegresardeInterrupt

OUTToken
	MOVFW	RecNRZI_1
	MOVWF	UltAddressRec

RegresardeInterrupt				;Recupero todos los Registros...
	BCF	INTCON, INTF
	RETFIE

SETUPToken
	MOVFW	RecNRZI_1
	MOVWF	UltAddressRec			;Guardo el Address recibido en UltAddressRec
	ANDLW	0x7F				;Solamente 7 bits de address
	XORWF	DeviceAddress, W		;Comparo con mi address actual
	BTFSS	STATUS, Z			;Mi address es igual al address recibido?
	GOTO	RegresardeInterrupt		;NO me hablan a mi, descarto paquete...
	BSF	Setup
	GOTO	EsperoContinuacion

ACKTokenRecibido
	BTFSS	Banderas_0, 6
	GOTO	RegresardeInterrupt
	BCF	Banderas_0, 6
	BTFSC	ZLPPend
	BCF	Setup
	BCF	ZLPPend
	BCF	INPend
	BTFSS	Setup
	BCF	InterruptIN
	GOTO	EsperoContinuacion

INToken
	MOVLW	0x7F				;Solamente 7 bits de address
	ANDWF	RecNRZI_1, W
	XORWF	DeviceAddress, W
	BTFSS	STATUS, Z			;Address Recibido es igual al address con el que estoy trabajando?
	GOTO	RegresardeInterrupt		;Address no coincide descarto paquete...
	BTFSC	Ocupado
	GOTO	TodaviaNO
	BSF	STATUS, C			;Cargo el Carry con "1"
	RLF	RecNRZI_1, W			;Inserto en "1" de Carry por la Derecha y lo guardo en W
	XORWF	RecNRZI_1, F
	COMF	RecNRZI_1, F			;Decripto Address en NRZI
	BTFSC	RecNRZI_1, 7			;ENDPOINT = 0?
	GOTO	ResponderIN			;NO
	BTFSC	AsignAddress
	GOTO	AsignarNuevoAddress
	BTFSC	Stall
	GOTO	MandarSTALL
	BTFSC	ZLPPend
	GOTO	MandarZLP
	BTFSC	INPend
	GOTO	EscribirUSBDATA			;Mandar USB...
	GOTO	ContTabla			;Levantar mas tabla...

ResponderIN
	BTFSS	InterruptIN
	GOTO	TodaviaNO
	GOTO	EscribirUSBDATA

AsignarNuevoAddress
	MOVFW	NuevoAddress
	MOVWF	DeviceAddress
	BCF	AsignAddress
	BSF	AddrAsignOK

MandarZLP
	CALL	MandarDATA
	GOTO	EsperoContinuacion

ZLPPendiente					;Zero length packet
	BSF	ZLPPend
	GOTO	EsperoContinuacion

DATARecibido
	MOVLW	0x7F				;Solamente 7 bits de address
	ANDWF	UltAddressRec, W
	XORWF	DeviceAddress, W
	BTFSS	STATUS, Z			;Address Recibido es igual al address con el que estoy trabajando?
	GOTO	RegresardeInterrupt		;Address no coincide descarto paquete...
	BTFSC	Ocupado
	GOTO	TodaviaNO
	MOVLW	RecNRZI_0			;Posición del primer paquete recibido...
	SUBWF	FSR, W				;Resto la posición del ultimo recibido menos la posición del primero...
	XORLW	0x03
	BTFSS	STATUS, Z
	GOTO	ProcesarDATA			;NO...
	CALL	MandarACK
	BCF	Banderas_2, 7
	BCF	Setup
	GOTO	EsperoContinuacion

ProcesarDATA
	MOVFW	RecNRZI_0
	MOVWF	PID
	MOVFW	RecNRZI_1
	MOVWF	Recibido_1
	MOVFW	RecNRZI_2
	MOVWF	Recibido_2
	MOVFW	RecNRZI_3
	MOVWF	Recibido_3
	MOVFW	RecNRZI_4
	MOVWF	Recibido_4
	CALL	MandarACK
	BSF	Ocupado
LimpioInterrupcion
	BCF	INTCON, INTF
	MOVFW	RecNRZI_5
	MOVWF	Recibido_5
	MOVFW	RecNRZI_6
	MOVWF	Recibido_6
	MOVFW	RecNRZI_7
	MOVWF	Recibido_7
	MOVFW	RecNRZI_8
	MOVWF	Recibido_8
	MOVFW	RecNRZI_9
	MOVWF	Recibido_9
	MOVFW	RecNRZI_A
	MOVWF	Recibido_A
	MOVFW	RecNRZI_B
	MOVWF	Recibido_B
	MOVFW	RecNRZI_C
	MOVWF	Recibido_C
	MOVLW	RecNRZI_0 - 1			;Posición del primer dato recibido - 1
	SUBWF	FSR, W
	MOVWF	BytesRecibidos
	CALL	DesencriptarNRZI
	BTFSS	Setup				;Salta si es Control Transfer
	GOTO	InterruptTransfer
	BTFSS	Banderas_2, 6
	GOTO	ProcesarSetup			; it's SETUP
	CALL	ProcessOut			; it's OUT
	BCF	Banderas_2, 6
	GOTO	ZLPPendiente

InterruptTransfer
	CALL	ProcessOut
	GOTO	EsperoContinuacion

MandarDATA
	MOVLW	0x4B				;'01001011' DATA1
	BTFSS	Data1
	MOVLW	0xC3				;'11000011' DATA0
	GOTO	EscribirUSBPID

MandarSTALL
	BCF	Stall
	MOVLW	0x1E				;'00011110' STALL Handshake
	CALL	EscribirUSBPID
	GOTO	EsperoContinuacion

MandarNAK
	MOVLW	0x5A				;'01011010' NAK Handshake
	GOTO	EscribirUSBPID

MandarACK
	MOVLW	0xD2				;'11010010' ACK Handshake

EscribirUSBPID
	MOVWF	ByteAMandar
	BSF	GPIO, DataMenos			;D- en "1"
	movlb	1				;Selecciono Banco 1
	MOVLW	~((1<<DataMenos)|(1<<DataMas))	;'00001000' Todas Salidas menos SE0
	ANDWF	TRISIO,F			;SE0 en Tristate
	movlb	0				;Selecciono Banco 0
	MOVLW	0x07				;
	MOVWF	Veces				;Cargo Variable con 7
	MOVLW	((1<<DataMenos)|(1<<DataMas))	;Solamente los bits D- y D+
SincUSB1
	XORWF	GPIO, F				;Invierto D- y D+
	DECFSZ	Veces, F			;Decremento mi variable...
	GOTO	SincUSB1			;Sigo hasta terminar los 7 cambios...
	MOVLW	0x10				;
	MOVWF	Veces				;Cargo Variable con 16
	MOVLW	((1<<DataMenos)|(1<<DataMas))	;Solamente los bits D- y D+
	NOP
	BTFSS	ByteAMandar, 0			;Si el bit 0 del Dato a mandar es...
	XORWF	GPIO, F				;..."0" invierto D- y D+
	GOTO	$ + 1
	BTFSS	ByteAMandar, 1			;Si el bit 1 del Dato a mandar es...
	XORWF	GPIO, F				;..."0" invierto D- y D+
	GOTO	$ + 1
	BTFSS	ByteAMandar, 2			;Si el bit 2 del Dato a mandar es...
	XORWF	GPIO, F				;..."0" invierto D- y D+
	GOTO	$ + 1
	BTFSS	ByteAMandar, 3			;Si el bit 3 del Dato a mandar es...
	XORWF	GPIO, F				;..."0" invierto D- y D+
	GOTO	$ + 1
	BTFSS	ByteAMandar, 4			;Si el bit 4 del Dato a mandar es...
	XORWF	GPIO, F				;..."0" invierto D- y D+
	GOTO	$ + 1
	BTFSS	ByteAMandar, 5			;Si el bit 5 del Dato a mandar es...
	XORWF	GPIO, F				;..."0" invierto D- y D+
	GOTO	$ + 1
	BTFSS	ByteAMandar, 6			;Si el bit 6 del Dato a mandar es...
	XORWF	GPIO, F				;..."0" invierto D- y D+
	GOTO	$ + 1
	BTFSS	ByteAMandar, 7			;Si el bit 7 del Dato a mandar es...
	XORWF	GPIO, F				;..."0" invierto D- y D+
	BTFSS	ZLPPend
	GOTO	ConfEntradas
	BSF	Banderas_0, 6
ZLP
	XORWF	GPIO, F				;Zero Length Packet
	DECFSZ	Veces, F
	GOTO	ZLP
	NOP
ConfEntradas
	MOVLW	~((1<<DataMenos)|(1<<DataMas))		;Todo menos D- y D+
	ANDWF	GPIO, F					;Borro los valores de D- y D+ y dejo el puerto como esta...
	CALL	Espero					;Hago tiempo???
	movlb	1					;Selecciono Banco 1
	MOVLW	((1<<DataMenos)|(1<<SE0)|(1<<DataMas))	;'00001110' SE0, D+, D- en Tristate
	IORWF	TRISIO,F				;SE0, D+, D- = Entradas
	movlb	0					;Selecciono Banco 0
Espero
	RETURN

EscribirUSBDATA
	BSF	GPIO, DataMenos			;D- en "1"
	movlb	1				;Selecciono Banco 1
	MOVLW	~((1<<DataMenos)|(1<<DataMas))	;'00001000' Todas salidas menos SE0
	ANDWF	TRISIO,F			;SE0 Entrada
	movlb	0				;Selecciono Banco 0
	movf	Var_2, W
	movwf	PR2
	clrf	TMR2
	bsf	T2CON,TMR2ON
	nop
	MOVLW	0x07
	MOVWF	Veces				;Cargo Variable con 7
	MOVLW	((1<<DataMenos)|(1<<DataMas))	;Solamente los bits D- y D+
SincUSB2
	XORWF	GPIO, F				;invierto D- y D+
	DECFSZ	Veces, F
	GOTO	SincUSB2
	MOVLW	RespPID				;Registro Indirecto
	MOVWF	FSR
	MOVLW	((1<<DataMenos)|(1<<DataMas))	;Solamente los bits D- y D+
	NOP
	BTFSS	INDF, 0				;Si el bit 0 del Dato a mandar es...
	XORWF	GPIO, F				;..."0" invierto D- y D+
	GOTO	MandarSigByte
MandarSigByte
	BTFSS	INDF, 1				;Si el bit 1 del Dato a mandar es...
	XORWF	GPIO, F				;..."0" invierto D- y D+
	btfsc	PIR1,TMR2IF			;
	goto	TMovf				;
	BTFSS	INDF, 2				;Si el bit 2 del Dato a mandar es...
	XORWF	GPIO, F				;..."0" invierto D- y D+
	btfsc	PIR1,TMR2IF			;
	goto	TMovf				;
	BTFSS	INDF, 3				;Si el bit 3 del Dato a mandar es...
	XORWF	GPIO, F				;..."0" invierto D- y D+
	btfsc	PIR1,TMR2IF			;
	goto	TMovf				;
	BTFSS	INDF, 4				;Si el bit 4 del Dato a mandar es...
	XORWF	GPIO, F				;..."0" invierto D- y D+
	btfsc	PIR1,TMR2IF			;
	goto	TMovf				;
	BTFSS	INDF, 5				;Si el bit 5 del Dato a mandar es...
	XORWF	GPIO, F				;..."0" invierto D- y D+
	btfsc	PIR1,TMR2IF			;
	goto	TMovf				;
	BTFSS	INDF, 6				;Si el bit 6 del Dato a mandar es...
	XORWF	GPIO, F				;..."0" invierto D- y D+
	btfsc	PIR1,TMR2IF			;
	goto	TMovf				;
	BTFSS	INDF, 7				;Si el bit 7 del Dato a mandar es...
	XORWF	GPIO, F				;..."0" invierto D- y D+
	INCF	FSR, F				;Incremento el Dato y sigo mandando hasta que halla desbordamiento...
	NOP
	BTFSS	INDF, 0				;Si el bit 0 del Dato a mandar es...
	XORWF	GPIO, F				;..."0" invierto D- y D+
	GOTO	MandarSigByte

DesencriptarNRZI
	MOVLW	PID				;Cargo la dirección del primer paquete recibido (PID) NRZI
	MOVWF	FSR				;en el registro indirecto para pasarlos a binario...
	MOVFW	BytesRecibidos
	MOVWF	Var_4
	BSF	STATUS, C			;Cargo el Carry con "1"
SigNRZI
	RLF	INDF, W
	XORWF	INDF, F
	COMF	INDF, F
	INCF	FSR, F
	DECFSZ	Var_4, F			;Desencripto siguente registro NRZI recibido...
	GOTO	SigNRZI
	MOVLW	PID				;PID Indirecto
	MOVWF	Var_5
	MOVLW	PID				;PID Indirecto
	MOVWF	Var_4
	MOVWF	FSR
	MOVFW	BytesRecibidos
	MOVWF	Resp_0				;Uso el buffer de repuesta como variable...
	CLRF	RespPID
	CLRF	Var_6
	CLRF	Var_7
	CLRF	Var_8
	CLRF	Var_9
Label_0
	RRF	INDF, F				;Exraigo el bit menos significativo...
	RRF	Var_6, F			;Lo inserto por la izquierda...
	INCF	Var_8, F			;Cuento el bit...
	BCF	Var_6, 0
	MOVLW	0x7E
	XORWF	Var_6, W
	BTFSC	STATUS, Z
	GOTO	Label_2
	RLF	Var_6, W
	RRF	Var_7, F
	INCF	Var_9, F
	BTFSC	Var_9, 3
	CALL	Label_3
Label_1
	BTFSS	Var_8, 3
	GOTO	Label_0
	CLRF	Var_8
	INCF	Var_4, F
	MOVFW	Var_4
	MOVWF	FSR
	DECFSZ	Resp_0, F			;Uso el buffer de repuesta como variable...
	GOTO	Label_0
	RETLW	0x00
Label_2
	INCF	RespPID, F			;Uso el buffer de repuesta como variable... Incremento variable...
	BTFSS	RespPID, 3			;Fueron 8 veces?
	GOTO	Label_1				;No
	DECF	BytesRecibidos, F
	CLRF	RespPID				;Limpio variable...
	GOTO	Label_1

Label_3
	CLRF	Var_9
	MOVFW	Var_5
	MOVWF	FSR
	MOVFW	Var_7
	MOVWF	INDF
	INCF	Var_5, F
	MOVFW	Var_4
	MOVWF	FSR
	RETURN

CalcularCRC16
	INCF	FSR, F
	MOVFW	Var_3
	MOVWF	Var_8
	MOVLW	0xFF
	MOVWF	Var_4
	MOVWF	Var_5
	MOVFW	INDF
	MOVWF	Var_6
	MOVLW	0x08
	MOVWF	Var_7
Label_4
	MOVFW	INDF
	XORWF	Var_4, W
	MOVWF	Var_6
	MOVFW	Var_5
	MOVWF	Var_4
	CLRF	Var_7
	BCF	STATUS, C
	RRF	Var_6, W
	XORWF	Var_6, F
	RRF	Var_7, F
	RRF	Var_6, W
	MOVWF	Var_5
	RRF	Var_7, F
	RLF	Var_6, F
	XORWF	Var_6, F
	SWAPF	Var_6, W
	XORWF	Var_6, F
	MOVFW	Var_7
	BTFSC	Var_6, 1
	XORLW	0x01
	XORWF	Var_4, F
	MOVLW	0xC0
	BTFSC	Var_6, 1
	XORWF	Var_5, F
	INCF	FSR, F
	DECFSZ	Var_8, F
	GOTO	Label_4
	COMF	Var_4, F
	COMF	Var_5, F
	RETLW	0x00

InsertarCRC16
	MOVFW	Var_4
	MOVWF	INDF
	INCF	FSR, F
	MOVFW	Var_5
	MOVWF	INDF
	MOVLW	0x02
	ADDWF	Var_3, F
	RETLW	0x00

InsertarBitStuffing
	MOVLW	RespPID				;Registro Indirecto
	MOVWF	Var_5
	MOVFW	PosicionPID
	MOVWF	Var_4
	MOVWF	FSR
	CLRF	Var_6
	CLRF	Var_7
	CLRF	Var_8
	MOVFW	Var_3
	MOVWF	Var_9
	CLRF	Var_2
Label_5
	RRF	INDF, F
	INCF	Var_7, F
	RRF	Var_6, F
	INCF	Var_8, F
	BTFSC	Var_8, 3
	CALL	Label_9
	MOVLW	0xFC
	SUBWF	Var_6, W
	BTFSC	STATUS, C
	CALL	Label_6
	BTFSC	Var_7, 3
	GOTO	Label_7
	GOTO	Label_5

Label_6
	BCF	STATUS, C
	RRF	Var_6, F
	INCF	Var_8, F
	BTFSC	Var_8, 3
	CALL	Label_9
	INCF	Var_2, F
	RETURN
Label_7
	CLRF	Var_7
	INCF	Var_4, F
	MOVFW	Var_4
	MOVWF	FSR
	DECFSZ	Var_9, F
	GOTO	Label_5
	BCF	STATUS, C
Label_8
	RRF	Var_6, F
	INCF	Var_8, F
	BTFSS	Var_8, 3
	GOTO	Label_8
	CALL	Label_9
	MOVFW	Var_3
	MOVWF	Var_9
	BCF	STATUS, C
	RLF	Var_9, F
	RLF	Var_9, F
	RLF	Var_9, W
	ADDWF	Var_2, F
	RETLW	0x00

Label_9
	CLRF	Var_8
	MOVFW	Var_5
	MOVWF	FSR
	MOVFW	Var_6
	MOVWF	INDF
	INCF	Var_5, F
	MOVFW	Var_4
	MOVWF	FSR
	RETURN

ContTabla
	MOVFW	Var_0
	IORWF	Var_1, W
	BTFSC	STATUS, Z
	GOTO	ZLPPendiente
	BSF	Ocupado
	BCF	INTCON, INTF
LeerDescriptor
	MOVLW	Recibido_1			;Address Indirecto
	MOVWF	FSR
	CLRF	Var_3				;Limpio registro contador (principio de la tabla)
	MOVLW	PID				;PID Indirecto
	MOVWF	PosicionPID
SiguienteDatoTabla
	CALL	LevantarTabla
	MOVWF	INDF
	INCF	Var_3, F			;Incremento contador...
	INCF	FSR, F				;Incremento Dirección de registro indirecto
	INCF	Posicion, F
	DECFSZ	Var_0, F
	BTFSC	Var_3, 3
	GOTO	PrepararDescriptor		;SI!
	GOTO	SiguienteDatoTabla

PrepararDescriptor
	MOVFW	PosicionPID
	MOVWF	FSR
	MOVLW	0x4B				;'01001011' DATA1
	BTFSS	Data1
	MOVLW	0xC3				;'11000011' DATA0
	MOVWF	INDF
	BCF	Data1
	BTFSS	INDF, 3
	BSF	Data1
	CALL	CalcularCRC16
	CALL	InsertarCRC16
	INCF	Var_3, F
	CALL	InsertarBitStuffing
	MOVLW	0x08
	ADDWF	Var_2, F
	BSF	INPend
	GOTO	EsperoContinuacion

ProcesarSetup
	BSF	Data1				;Respuesta a (Setup + Data0) = Data1
	MOVFW	Recibido_1			;Cargo Address en W
	ANDLW	0x60				;Standard Request (Bit5 y Bit6 en "0")
	BTFSC	STATUS, Z			;Si los bits 5 y 6 de Recibido_1 son igual a 0 es Standard Request
	GOTO	IdentificarStdReq
	MOVFW	Recibido_2
	XORLW	0x01				;CLEAR_FEATURE no Standard Request
	BTFSC	STATUS, Z			;Si Recibido_2 es igual a CLEAR_FEATURE...
	GOTO	bReqNS
	MOVFW	Recibido_2
	XORLW	0x09				;SET_CONFIGURATION no Standard Request
	BTFSC	STATUS, Z			;Si Recibido_2 es igual a SET_CONFIGURATION...
	GOTO	bReqNS
	MOVFW	Recibido_2
	XORLW	0x0A				;GET_INTERFACE no Standard Request
	BTFSC	STATUS, Z			;Si Recibido_2 es igual a GET_INTERFACE...
	GOTO	GINSR
	BSF	Stall				;Levanto bandera de STALL (atascado)
	GOTO	EsperoContinuacion

IdentificarStdReq
	MOVFW	Recibido_2			;Cargo en W Recibido_2
	brw					;Se lo agrego a PCL

	GOTO	GET_STATUS			;GET_STATUS
	GOTO	CLEAR_FEATURE			;CLEAR_FEATURE
	GOTO	EsperoContinuacion		;Reserved for future use
	GOTO	SET_FEATURE			;SET_FEATURE
	GOTO	EsperoContinuacion		;Reserved for future use
	GOTO	SET_ADDRESS			;SET_ADDRESS
	GOTO	GET_SET_DESCRIPTOR		;GET_DESCRIPTOR
	GOTO	GET_SET_DESCRIPTOR		;SET_DESCRIPTOR
	GOTO	GET_CONFIGURATION		;GET_CONFIGURATION
	GOTO	SET_CONFIGURATION		;SET_CONFIGURATION
	GOTO	GET_INTERFACE			;GET_INTERFACE
	GOTO	SET_INTERFACE			;SET_INTERFACE
	GOTO	SYNCH_FRAME			;SYNCH_FRAME

GET_STATUS
	CLRF	Recibido_1
	CLRF	Recibido_2
	BTFSC	Banderas_0, 2
	BSF	Recibido_1, 0
	MOVLW	0x02
	MOVWF	Var_3
	GOTO	PrepararDescriptor

CLEAR_FEATURE
	BCF	Banderas_0, 2
	GOTO	ZLPPendiente

SET_FEATURE
	BSF	Banderas_0, 2
	GOTO	ZLPPendiente

SET_ADDRESS
	MOVFW	Recibido_3
	MOVWF	NuevoAddress
	CLRF	Var_4
	BSF	Var_4, 3
	BSF	STATUS, C
AddressNRZI
	MOVLW	0x80
	RRF	NuevoAddress, F
	BTFSS	STATUS, C
	XORWF	NuevoAddress, F
	RLF	NuevoAddress, W
	DECFSZ	Var_4, F
	GOTO	AddressNRZI
	BCF	NuevoAddress, 7
	BSF	AsignAddress
	GOTO	ZLPPendiente

GET_SET_DESCRIPTOR
	MOVFW	Recibido_7
	MOVWF	Var_0
	MOVFW	Recibido_8
	MOVWF	Var_1
	MOVLW	0xFF
	MOVF	Recibido_8, F
	BTFSC	STATUS, Z			;Me fijo si Recibido_8 es distinto de "0"
	MOVFW	Recibido_7			;Es igual a "0", Cargo W con Recibido_7
	MOVWF	Var_4
	MOVFW	Recibido_4
	XORLW	0x21
	BTFSC	STATUS, Z			;Si Recibido_4 es igual a 0x21...
	GOTO	Mandar_HID_Descriptor		;Es igual a 0x21, Mando Descriptor (HID)
	MOVFW	Recibido_4
	XORLW	0x22
	BTFSC	STATUS, Z			;Si Recibido_4 es igual a 0x22...
	GOTO	Mandar_HIDReport_Descriptor	;Es igual a 0x22, Mando HID Report Descriptor
	MOVFW	Recibido_4			;Cargo en W Recibido_4
	brw					;Se lo agrego a PCL
	GOTO	EsperoContinuacion		;Posición de PC = 2B3 (PCLATH = 0x02) (PCL = 0xB3)
	GOTO	Mandar_DEVICE_Descriptor
	GOTO	Mandar_CONFIGURATION_Descriptor
	GOTO	Mandar_STRING_Descriptors

Mandar_DEVICE_Descriptor
	MOVLW	0x12				;Tamaño del Descriptor (18 Bytes)
	CALL	Label_A
	MOVLW	0x00				;Posición del Descriptor (0)
	MOVWF	Posicion
	GOTO	LeerDescriptor

Mandar_CONFIGURATION_Descriptor
	MOVLW	0x29				;Tamaño del Descriptor (41 Bytes)
	CALL	Label_A
	MOVLW	0x12				;Posición del Descriptor (18)
	MOVWF	Posicion
	GOTO	LeerDescriptor

Mandar_HID_Descriptor
	MOVLW	0x09				;Tamaño del Descriptor (9 Bytes)
	CALL	Label_A
	MOVLW	0x24				;Posición del Descriptor (36)
	MOVWF	Posicion
	GOTO	LeerDescriptor

Mandar_HIDReport_Descriptor
	MOVLW	0x19				;Tamaño del Descriptor (25 Bytes)
	CALL	Label_A
	MOVLW	0x3B				;Posición del Descriptor (59)
	MOVWF	Posicion
	GOTO	LeerDescriptor

Mandar_STRING_Descriptors
	MOVFW	Recibido_3			;Cargo en W Recibido_3
	brw					;Se lo agrego a PCL
	GOTO	StringDescriptor0		;Posición de PC = 2D3 (PCLATH = 0x02) (PCL = 0xD3)
	GOTO	StringDescriptor1
	GOTO	StringDescriptor2

StringDescriptor0
	MOVLW	0x04				;Tamaño 4 Bytes (String Descriptor)
	CALL	Label_A
	MOVLW	0x54				;Posición en la tabla (84)...
	MOVWF	Posicion
	GOTO	LeerDescriptor

StringDescriptor1
	MOVLW	0x12				;Tamaño 18 Bytes (String Descriptor)
	CALL	Label_A
	MOVLW	0x58				;Posición en la tabla (88)...
	MOVWF	Posicion
	GOTO	LeerDescriptor

StringDescriptor2
	MOVLW	0x56				;Tamaño 86 Bytes (String Descriptor)
	CALL	Label_A
	MOVLW	0x6A				;Posición en la tabla (106)...
	MOVWF	Posicion
	GOTO	LeerDescriptor

GET_CONFIGURATION
	MOVFW	NuevoAddress
	MOVWF	Recibido_1
	MOVLW	0x01
	MOVWF	Var_3
	GOTO	PrepararDescriptor

SET_CONFIGURATION
	MOVFW	Recibido_3
	MOVWF	NuevoAddress
	BSF	Banderas_0, 1
	GOTO	ZLPPendiente

GET_INTERFACE
	CLRF	Recibido_1
	MOVLW	0x01
	MOVWF	Var_3
	GOTO	PrepararDescriptor

SET_INTERFACE
	GOTO	ZLPPendiente

SYNCH_FRAME
	GOTO	EsperoContinuacion

bReqNS
	GOTO	EsperoContinuacion

GINSR
	GOTO	ZLPPendiente

Label_A
	SUBWF	Var_4, F
	BTFSS	STATUS, C
	MOVFW	Recibido_7
	MOVWF	Var_0
	RETURN

ProcessOut				; Custom code goes here
    					; Interrupt transfer found, put first byte nibble of
					; Output Report and Send one byte.
	CLRF	Var_4			; Limpio
	INCF	Var_4, F		; Incremento
	btfsc	Recibido_2,7		;!(Recibido_2 > 0x80) ?
	goto	Set_BR
	movf	Recibido_2,F		;Recibido_2 = 0x00 ?
	skpz
    	retlw   0x00
    	movf    Recibido_1,W
    	movlb   3
    	btfsc   TXSTA,TRMT
    	movwf   TXREG
    	movlb   0
    	retlw   0x00

Set_BR
    	movf    Recibido_1,W
    	movlb   3
	movwf	SPBRGL
    	movlb   0
    	movf    Recibido_2,W
	bcf	WREG,7
    	movlb   3
	movwf	SPBRGH
    	movlb   0
    	retlw   0x00

Main    				; Custom code goes here
	btfss	PIR1,RCIF
	retlw	0x00

    	movlb   3
	movf	RCREG,W
    	movlb   0

	MOVWF	Recibido_1
	MOVLW	0x02
	MOVWF	Var_3
	MOVLW	PID
	MOVWF	PosicionPID
	MOVFW	PosicionPID
	MOVWF	FSR
	MOVLW	0x4B			;'01001011' DATA1
	BTFSS	Data1
	MOVLW	0xC3			;'11000011' DATA0
	MOVWF	INDF
	BCF	Data1
	BTFSS	INDF, 3
	BSF	Data1
	CALL	CalcularCRC16
	CALL	InsertarCRC16
	INCF	Var_3, F
	CALL	InsertarBitStuffing
	MOVLW	0x08
	ADDWF	Var_2, F
	BSF	InterruptIN
	RETLW	0x00

LevantarTabla
	MOVFW	Posicion			;Cargo Posicion en W
	brw					;Se lo agrego a PCL

	RETLW	0x12				;1 Size of this descriptor in bytes	Posición de PC = 306
	RETLW	0x01				;2 Descriptor Type (1 = DEVICE)
	RETLW	0x10				;3 (This field identifies the release of the USB Specification 
	RETLW	0x01				;4 with which the device and its descriptors are compliant.)
	RETLW	0x00				;5 Class code (assigned by the USB-IF).
	RETLW	0x00				;6 Subclass code (assigned by the USB-IF).
	RETLW	0x00				;7 Protocol code (assigned by the USB-IF).
	RETLW	0x08				;8 Maximum packet size for endpoint zero
	RETLW	0xD8				;9 Vendor ID (assigned by the USB-IF) Low
	RETLW	0x04				;10 Vendor ID (assigned by the USB-IF) High
	RETLW	0x28				;11 Product ID (assigned by the manufacturer) Low
	RETLW	0x06				;12 Product ID (assigned by the manufacturer) High
	RETLW	0x16				;13 Device release number in binary-coded decimal Low
	RETLW	0x08				;14 Device release number in binary-coded decimal High
	RETLW	0x01				;15 Index of string descriptor describing manufacturer
	RETLW	0x02				;16 Index of string descriptor describing product
	RETLW	0x00				;17 Index of string descriptor describing the device’s serial number
	RETLW	0x01				;18 Number of possible configurations

	RETLW	0x09				;1 Size of this descriptor in bytes
	RETLW	0x02				;2 Descriptor Type (2 = CONFIGURATION)
	RETLW	0x29				;3 wTotalLength Low
	RETLW	0x00				;4 wTotalLength High
	RETLW	0x01				;5 bNumInterfaces
	RETLW	0x01				;6 bConfigurationValue
	RETLW	0x00				;7 Index of string descriptor describing this configuration
	RETLW	0x80				;8 bmAttributes
	RETLW	0x32				;9 bMaxPower
						
	RETLW	0x09				;1 Size of this descriptor in bytes
	RETLW	0x04				;2 Descriptor Type (4 = INTERFACE)
	RETLW	0x00				;3 bInterfaceNumber
	RETLW	0x00				;4 bAlternateSetting
	RETLW	0x02				;5 bNumEndpoints
	RETLW	0x03				;6 bInterfaceClass
	RETLW	0x00				;7 bInterfaceSubClass
	RETLW	0x00				;8 bInterfaceProtocol
	RETLW	0x00				;9 iInterface

	RETLW	0x09				;1 Size of this descriptor in bytes
	RETLW	0x21				;2 Descriptor Type (21 = HID)
	RETLW	0x00				;3 HID Class Specification release number in binary Low
	RETLW	0x01				;4 HID Class Specification release number in binary High
	RETLW	0x00				;5 Hardware target country
	RETLW	0x01				;6 Number of HID class descriptors to follow
	RETLW	0x22				;7 Report Type Descriptor
	RETLW	0x19				;8 Total length of Report descriptor Low
	RETLW	0x00				;9 Total length of Report descriptor High

	RETLW	0x07				;1 Size of this descriptor in bytes
	RETLW	0x05				;2 Descriptor Type (5 = ENDPOINT)
	RETLW	0x81				;3 bEndpointAddress (Bit 7: 1 IN, Bits 0..3 = 1 Endpoint Address 1)
	RETLW	0x03				;4 bmAttributes (3 = INTERRUPT TRANSFER)
	RETLW	0x08				;5 wMaxPacketSize Low
	RETLW	0x00				;6 wMaxPacketSize High
	RETLW	0x0A				;7 bInterval

	RETLW	0x07				;1 Size of this descriptor in bytes
	RETLW	0x05				;2 Descriptor Type (5 = ENDPOINT)
	RETLW	0x01				;3 bEndpointAddress (Bit 7: 0 OUT, Bits 0..3 = 1 Endpoint Address 1)
	RETLW	0x03				;4 bmAttributes (3 = INTERRUPT TRANSFER)
	RETLW	0x08				;5 wMaxPacketSize Low
	RETLW	0x00				;6 wMaxPacketSize High
	RETLW	0x0A				;7 bInterval

	RETLW	0x06				;1 HID Report Descriptor
	RETLW	0xA0				;2
	RETLW	0xFF				;3
	RETLW	0x09				;4
	RETLW	0x01				;5
	RETLW	0xA1				;6
	RETLW	0x01				;7
	RETLW	0x09				;8
	RETLW	0x03				;9
	RETLW	0x15				;10
	RETLW	0x00				;11
	RETLW	0x26				;12
	RETLW	0xFF				;13
	RETLW	0x00				;14
	RETLW	0x75				;15
	RETLW	0x08				;16
	RETLW	0x95				;17
	RETLW	0x02				;18
	RETLW	0x81				;19
	RETLW	0x02				;20
	RETLW	0x09				;21
	RETLW	0x04				;22
	RETLW	0x91				;23
	RETLW	0x02				;24
	RETLW	0xC0				;25

	RETLW	0x04				;1 String Descriptors
	RETLW	0x03				;2
	RETLW	0x09				;3
	RETLW	0x04				;4

	RETLW	0x12				;1
	RETLW	0x03                            ;2
	RETLW	0x44                            ;3
	RETLW	0x00                            ;4
	RETLW	0x4D                            ;5
	RETLW	0x00                            ;6
	RETLW	0x4C                            ;7
	RETLW	0x00                            ;8
	RETLW	0x40                            ;9
	RETLW	0x00                            ;10
	RETLW	0x32                            ;11
	RETLW	0x00                            ;12
	RETLW	0x30                            ;13
	RETLW	0x00                            ;14
	RETLW	0x31                            ;15
	RETLW	0x00                            ;16
	RETLW	0x33                            ;17
	RETLW	0x00                            ;18

	RETLW	0x56				;1
	RETLW	0x03                            ;2
	RETLW	0x43                            ;3
	RETLW	0x00                            ;4
	RETLW	0x6F                            ;5
	RETLW	0x00                            ;6
	RETLW	0x6E                            ;7
	RETLW	0x00                            ;8
	RETLW	0x65                            ;9
	RETLW	0x00				;10
	RETLW	0x63                            ;11
	RETLW	0x00                            ;12
	RETLW	0x63                            ;13
	RETLW	0x00                            ;14
	RETLW	0x69                            ;15
	RETLW	0x00                            ;16
	RETLW	0xF3                            ;17
	RETLW	0x00                            ;18
	RETLW	0x6E				;19
	RETLW	0x00				;20
	RETLW	0x20				;21
	RETLW	0x00                            ;22
	RETLW	0x55                            ;23
	RETLW	0x00                            ;24
	RETLW	0x53                            ;25
	RETLW	0x00                            ;26
	RETLW	0x42                            ;27
	RETLW	0x00                            ;28
	RETLW	0x20                            ;29
	RETLW	0x00                            ;30
	RETLW	0x61				;31
	RETLW	0x00                            ;32
	RETLW	0x74                            ;33
	RETLW	0x00                            ;34
	RETLW	0x72                            ;35
	RETLW	0x00                            ;36
	RETLW	0x61                            ;37
	RETLW	0x00                            ;38
	RETLW	0x76                            ;39
	RETLW	0x00                            ;40
	RETLW	0x65                            ;41
	RETLW	0x00                            ;42
	RETLW	0x7A                            ;43
	RETLW	0x00                            ;44
	RETLW	0x20                            ;45
	RETLW	0x00                            ;46
	RETLW	0x64                            ;47
	RETLW	0x00                            ;48
	RETLW	0x65                            ;49
	RETLW	0x00                            ;50
	RETLW	0x20				;51
	RETLW	0x00                            ;52
	RETLW	0x50                            ;53
	RETLW	0x00                            ;54
	RETLW	0x49                            ;55
	RETLW	0x00                            ;56
	RETLW	0x43                            ;57
	RETLW	0x00                            ;58
	RETLW	0x31                            ;59
	RETLW	0x00                            ;60
	RETLW	0x32				;61
	RETLW	0x00                            ;62
	RETLW	0x46                            ;63
	RETLW	0x00                            ;64
	RETLW	0x36                            ;65
	RETLW	0x00                            ;66
	RETLW	0x37                            ;67
	RETLW	0x00                            ;68
	RETLW	0x35                            ;69
	RETLW	0x00                            ;70
	RETLW	0x20				;71
	RETLW	0x00                            ;72
	RETLW	0x70                            ;73
	RETLW	0x00                            ;74
	RETLW	0x6F                            ;75
	RETLW	0x00                            ;76
	RETLW	0x72                            ;77
	RETLW	0x00                            ;78
	RETLW	0x20                            ;79
	RETLW	0x00                            ;80
	RETLW	0x44				;81
	RETLW	0x00				;82
	RETLW	0x4D				;83
	RETLW	0x00				;84
	RETLW	0x4C				;85
	RETLW	0x00				;86







	END





