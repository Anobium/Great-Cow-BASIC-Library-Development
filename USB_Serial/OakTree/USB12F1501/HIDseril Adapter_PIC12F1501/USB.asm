;*****************************************************************************************************
;
;	USB PIC12F1501
;
;*****************************************************************************************************

	list		p=12F1501      ; list directive to define processor
	#include	<p12F1501.inc> ; processor specific variable definitions
	errorlevel	-302

    __CONFIG _CONFIG1, _FOSC_ECH & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _CP_OFF & _BOREN_OFF & _CLKOUTEN_OFF
    __CONFIG _CONFIG2, _WRT_OFF & _STVREN_OFF & _BORV_LO & _LPBOR_OFF & _LVP_OFF

xtal    EQU     .30000000
baud    EQU     .9600

#define INDF		INDF0
#define FSR		FSR0L
#define TRISIO		TRISA
#define GPIO		PORTA
#define ANSEL		ANSELA

;****************************************************************************
;
;	DEFINICION DE ETIQUETAS Y VARIABLES
;
;****************************************************************************
;PORT/PIN
RTS			EQU		0
TX			EQU		1
DataMas			EQU		2
RX			EQU		3
DataMenos		EQU		4
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
Var_2			EQU		0x70
Var_3			EQU		0x71
Var_4			EQU		0x72
Var_5			EQU		0x73
Var_6			EQU		0x74
Var_7			EQU		0x75
Var_8			EQU		0x76
Var_9			EQU		0x77
;;;Rec_W		EQU		0x78
;;;Rec_STATUS		EQU		0x79
;;;Rec_FSR		EQU		0x7A
;;;Rec_PCLATH		EQU		0x7B
DeviceAddress		EQU		0x7C
UltAddressRec		EQU		0x7D
cn			EQU		0x7E
rxd			EQU		0x7F

#define AddrAsignOK		Banderas_0, 0
;				Banderas_0, 1
;				Banderas_0, 2
#define	Ocupado			Banderas_0, 3
;				Banderas_0, 4
#define	Setup			Banderas_0, 5
;				Banderas_0, 6
;				Banderas_0, 7
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

;;	BCF	STATUS, RP0			;Selecciono Banco 0
	movlb	0
	CLRF	GPIO				;Limpio GPIO
	GOTO	Configurar

	ORG	0x0004				;Vector de Interrupción

	goto	$+1				;30MHz adjust
	nop					;{0}[0]
	GOTO	RecepcionUSB			;{12}[12]

TMovf
	MOVLW	~((1<<DataMenos)|(1<<DataMas))	;'11111001'
	ANDWF	GPIO, F				;Limpio D+ y D- y dejo el puerto como esta...
;1	CLRF	TMR0				;Limpio TMR0
	bcf	T2CON,TMR2ON			;1
	bcf	PIR1,TMR2IF			;1
	BSF	Banderas_0, 6
;	NOP
;;;	CLRF	INTCON
;;	BSF	STATUS, RP0			;Selecciono Banco 1
	movlb	1
	MOVLW	((1<<DataMenos)|(1<<DataMas))	;'00001110' SE0, D+, D- entradas
	IORWF	TRISIO,F			;SE0, D+, D- en Tristate
;;	BCF	STATUS, RP0			;Selecciono Banco 0
	movlb	0
	GOTO	EsperoContinuacion

Configurar
;;	MOVLW	0x07				;Comparador
;;	MOVWF	CMCON				;deshabilitado
;;	BSF	STATUS, RP0			;Selecciono Banco 1
	movlb	1
	MOVLW	((1<<DataMenos)|(1<<DataMas))	;SE0, D+, D- entradas
;;;	IORWF	TRISIO,F			;Entrada
;;;	bcf	TRISIO,TX			;TX=OUTPUT
	movwf	TRISIO				;DataMenos,DataMas=INPUT, TX,RTS=OUTPUT
;;;	MOVLW	0xC1
	movlw	B'11000011'			;0.133uS x 256 x 16 = 546uS
	MOVWF	OPTION_REG			;Cargo el registro OPTION
;;	CLRF	VRCON				;VRef apagado
	movlb	3
	CLRF	ANSEL				;Selector Analogo deshabilitado
;;	BCF	STATUS, RP0			;Selecciono Banco 0
	movlb	0
	movlw   B'00100000'			;1
	movwf   T2CON				;1
	bsf	GPIO,TX 			;TX port Initialization
	bsf	GPIO,RTS			;disable Data from the host

LoopPrincipal
	CLRF	Banderas_0
	CLRF	Banderas_1
	MOVLW	0x2A				;'00101010'  Address 0x00 inicialmente en NRZI (7 bits)
	MOVWF	DeviceAddress
EsperoContinuacion
	BCF	Ocupado
	MOVLW	((1<<GIE)|(1<<INTE))
	MOVWF	INTCON
EspInt
	BTFSC	GPIO, DataMenos			;DataMenos en "0"?
	GOTO	EspInt
	BTFSC	GPIO, DataMas			;DataMas en "0"?
	GOTO	EspInt
	MOVLW	0x02
	MOVWF	Var_4				;Cargo mi variable con 2 de TimeOut...
DescTimeOut
	BTFSC	GPIO, DataMenos			;DataMenos en "0"?
	GOTO	EspInt
	BTFSC	GPIO, DataMas			;DataMas en "0"?
	GOTO	EspInt
	DECFSZ	Var_4, F
	GOTO	DescTimeOut
	GOTO	LoopPrincipal			;TimeOut, espero otro Token

RecepcionUSB
	GOTO	$ + 1				;D+ en "0"?		(2)	{30}[34]
	nop					;				 +  [0]
	BTFSS	GPIO, DataMas			;D+ en "1"?		(3)	{1} [1]
	GOTO	LimpioINT			;				{2} [2]
	GOTO	$ + 1				;				{30}[34]
	nop					;				 +  [0]
	BTFSC	GPIO, DataMas			;D+ en "0"?		(4)     {1} [1]
	GOTO	LimpioINT			;				{2} [2]
;;;	MOVWF	Rec_W				;Primero Guardo W...		{3} [3]
;;;	SWAPF	STATUS, W			;Invierto STATUS en W		{0} [4]
	goto	$+1
	nop					;				 +  [0]
	BTFSS	GPIO, DataMas			;D+ en "1"?		(5)     {1} [1]
	GOTO	Recupero_W			;				{2} [2]
;;;	MOVWF	Rec_STATUS			;Guardo el STATUS Invertido...	{3} [3]
;;;	MOVFW	PCLATH				;				{0} [4]
	goto	$+1
	nop					;				 +  [0]
	BTFSC	GPIO, DataMas			;D+ en "0"?		(6)     {1} [1]
	GOTO	Recupero_STATUS			;Recupero desde STATUS + W	{2} [2]
;;;	MOVWF	Rec_PCLATH			;Guardo PCLATH			{3} [3]
;;;	MOVFW	FSR				;				{0} [4]
	goto	$+1
	nop					;				 +  [0]
	BTFSS	GPIO, DataMas			;D+ en "1"?		(7)     {1} [1]
	GOTO	Recupero_PCLATH			;Recupero desde PCLATH + STATUS + W {2} [2]
;;;	MOVWF	Rec_FSR				;				{3} [3]
	MOVLW	RecNRZI_0			;				{0} [4]
;;;	nop					;				 +  [0]
	goto	$+1
	BTFSS	GPIO, DataMas			;D+ en "1"?		(8)     {1} [1]
	GOTO	RegresardeInterrupt		;				{2} [2]
	MOVWF	FSR				;				{3} [3]
	CLRF	INDF				;				{0} [4]
	nop					;				 +  [0]
	BTFSC	GPIO, DataMas			;D+ en "0"?     		{1} [1]
	BSF	INDF, 0				;				{2} [2]
	GOTO	$ + 1				;				{30}[34]
	nop					;				 +  [0]
	BTFSC	GPIO, DataMas			;D+ en "0"?     		{1} [1]
	BSF	INDF, 1				;				{2} [2]
	GOTO	$ + 1				;				{30}[34]
	CLRF	PCLATH				;Limpio PCLATH			 +  [0]
ContinuoRecibiendo
	BTFSC	GPIO, DataMas			;D+ en "0"?			[1]  [1]
	goto 	$+4				;				[23] [2]
	BTFSC	GPIO, DataMenos			;D- en "0"?		     	     [3]
	goto 	$+4				;				     [40]
	GOTO	Identificar_PID			;
	nop					;				[4]
	BSF	INDF, 2				;				[0]

	BTFSC	GPIO, DataMas			;D+ en "0"?			{1} [1]
	BSF	INDF, 3				;				{2} [2]
	GOTO	$ + 1				;Pierdo dos ciclo...		{30}[34]
	nop					;				 +  [0]

	BTFSC	GPIO, DataMas			;D+ en "0"?			[1]  [1]
	goto 	$+4				;				[23] [2]
	BTFSC	GPIO, DataMenos			;DataMenos en "0"?		     [3]
	goto 	$+4				;				     [40]
	GOTO	Identificar_PID			;
	nop					;				[4]
	BSF	INDF, 4				;				[0]

	BTFSC	GPIO, DataMas			;D+ en "0"?			{1} [1]
	BSF	INDF, 5				;				{2} [2]
	MOVFW	RecNRZI_0			;				{3} [3]
	ANDLW	0x0F				;				{0} [4]
	nop					;				 +  [0]

	BTFSC	GPIO, DataMas			;D+ en "0"?			[1]  [1]
	goto 	$+4				;				[23] [2]
	BTFSC	GPIO, DataMenos			;DataMenos en "0"?		     [3]
	goto 	$+4				;				     [40]
	GOTO	Identificar_PID			;
	nop					;				[4]
	BSF	INDF, 6				;				[0]

	BTFSC	GPIO, DataMas			;D+ en "0"?			{1} [1]
	BSF	INDF, 7				;				{2} [2]
	INCF	FSR, F				;				{3} [3]
	CLRF	INDF				;				{0} [4]
	nop					;				 +  [0]

	BTFSC	GPIO, DataMas			;D+ en "0"?			[1]  [1]
	goto 	$+4				;				[23] [2]
	BTFSC	GPIO, DataMenos			;DataMenos en "0"?		     [3]
	goto 	$+4				;				     [40]
	GOTO	Identificar_PID			;
	nop					;				[4]
	BSF	INDF, 0				;				[0]

	BTFSC	GPIO, DataMas			;D+ en "0"?			{1} [1]
	BSF	INDF, 1				;				{2} [2]
	nop					;				 +  [3]
	GOTO	ContinuoRecibiendo		;				{30}[40]

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
;;;	MOVFW	Rec_FSR
;;;	MOVWF	FSR				;Recupero FSR...
Recupero_PCLATH
;;;	MOVFW	Rec_PCLATH			;Recupero PCLATH
;;;	MOVWF	PCLATH
Recupero_STATUS
;;;	SWAPF	Rec_STATUS, W			;Enderezo STATUS
;;;	MOVWF	STATUS				;Recupero STATUS...
Recupero_W
;;;	SWAPF	Rec_W, F
;;;	SWAPF	Rec_W, W

LimpioINT
	BCF	INTCON, INTF
;;;	BTFSC	INTCON, INTF
;;;	GOTO	LimpioINT
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
	BCF	Banderas_0, 7
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
;;;	BTFSC	INTCON, INTF
;;;	GOTO	LimpioInterrupcion
	BSF	INTCON, GIE
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
	BTFSS	Banderas_0, 4
	GOTO	ProcesarSetup			; it's SETUP
	CALL	ProcessOut			; it's OUT
	BCF	Banderas_0, 4
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
;;	BSF	STATUS, RP0			;Selecciono Banco 1
	movlb	1
	MOVLW	~((1<<DataMenos)|(1<<DataMas))	;'00001000' Todas Salidas menos SE0
	ANDWF	TRISIO,F			;SE0 en Tristate
;;	BCF	STATUS, RP0			;Selecciono Banco 0
	movlb	0
	MOVLW	0x07
	MOVWF	Veces				;Cargo Variable con 7
	MOVLW	((1<<DataMenos)|(1<<DataMas))	;Solamente los bits D- y D+
	BTFSS	ZLPPend
	goto	SincUSB10
SincUSB1
	XORWF	GPIO, F				;Invierto D- y D+			{0} [0]
	nop					;				 	 +  [1]
	DECFSZ	Veces, F			;Decremento mi variable...		{1} [2]
	GOTO	SincUSB1			;Sigo hasta terminar los 7 cambios...	{23}[34]
	MOVLW	0x10				;					{3} [4]
	MOVWF	Veces				;Cargo Variable con 16			{0} [0]
;;;	nop					;				 	 +  [1]
	MOVLW	((1<<DataMenos)|(1<<DataMas))	;Solamente los bits D- y D+		{1} [2]
;;;	NOP					;					{2} [3]
	goto	$+1
	BTFSS	ByteAMandar, 0			;Si el bit 0 del Dato a mandar es...	{3} [4]
	XORWF	GPIO, F				;..."0" invierto D- y D+		{0} [0]
	nop					;				 	 +  [1]
	GOTO	$ + 1				;					{12}[23]
	BTFSS	ByteAMandar, 1			;Si el bit 1 del Dato a mandar es...	{3} [4]
	XORWF	GPIO, F				;..."0" invierto D- y D+		{0} [0]
	nop					;				 	 +  [1]
	GOTO	$ + 1				;					{12}[23]
	BTFSS	ByteAMandar, 2			;Si el bit 2 del Dato a mandar es...	{3} [4]
	XORWF	GPIO, F				;..."0" invierto D- y D+		{0} [0]
	nop					;				 	 +  [1]
	GOTO	$ + 1				;					{12}[23]
	BTFSS	ByteAMandar, 3			;Si el bit 3 del Dato a mandar es...	{3} [4]
	XORWF	GPIO, F				;..."0" invierto D- y D+		{0} [0]
	nop					;				 	 +  [1]
	GOTO	$ + 1				;					{12}[23]
	BTFSS	ByteAMandar, 4			;Si el bit 4 del Dato a mandar es...	{3} [4]
	XORWF	GPIO, F				;..."0" invierto D- y D+		{0} [0]
	nop					;				 	 +  [1]
	GOTO	$ + 1				;					{12}[23]
	BTFSS	ByteAMandar, 5			;Si el bit 5 del Dato a mandar es...	{3} [4]
	XORWF	GPIO, F				;..."0" invierto D- y D+		{0} [0]
	nop					;				 	 +  [1]
	GOTO	$ + 1				;					{12}[23]
	BTFSS	ByteAMandar, 6			;Si el bit 6 del Dato a mandar es...	{3} [4]
	XORWF	GPIO, F				;..."0" invierto D- y D+		{0} [0]
	nop					;				 	 +  [1]
	GOTO	$ + 1				;					{12}[23]
	BTFSS	ByteAMandar, 7			;Si el bit 7 del Dato a mandar es...	{3} [4]
	XORWF	GPIO, F				;..."0" invierto D- y D+		{0} [0]
	nop					;				 	 +  [1]
	GOTO	$ + 1				;					{12}[23]
	BSF	Banderas_0, 6			;					{3} [4]
ZLP
	XORWF	GPIO, F				;Zero Length Packet			{0} [0]
	nop					;				 	 +  [1]
	DECFSZ	Veces, F			;					{1} [2]
	GOTO	ZLP				;					{23}[34]
ConfEntradas
	MOVLW	~((1<<DataMenos)|(1<<DataMas))	;Todo menos D- y D+			{3} [4]
	ANDWF	GPIO, F				;					{0} [0]
	CALL	Espero				;Hago tiempo???
;;	BSF	STATUS, RP0			;Selecciono Banco 1
	movlb	1
	MOVLW	((1<<DataMenos)|(1<<DataMas))	;'00001110' SE0, D+, D- en Tristate
	IORWF	TRISIO,F			;SE0, D+, D- = Entradas
;;	BCF	STATUS, RP0			;Selecciono Banco 0
	movlb	0
	btfsc	Setup
Espero
	RETURN

	bcf	GPIO,RTS			; enable Data from the host
	clrf	TMR0				; clear timer0
	bcf	INTCON,TMR0IF			; clear overflow flag

RcvL:
	BCF	INTCON, GIE
	btfsc	INTCON,TMR0IF			; timeout ?
	goto	timeout				; yes

        btfsc   GPIO,RX				; detect Start Bit ?
        goto	RcvL				; loop

	call    bwait2				; wait 1/2 bit and W=9
        movwf   cn				; cn=9
        rrf     rxd,f				; get bit data
	call    bwait   			; wait 1bit and Carry=1
        btfss   GPIO,RX
        bcf     STATUS,C
	decfsz	cn,f				; cn=0?
        goto    $-5				; loop

	BSF	INTCON, GIE
	movf	rxd,W				;set data
	movwf	Recibido_1
	MOVLW	0x01
	MOVWF	Var_3
	call	_PD
	BSF	InterruptIN

timeout:
	bsf	GPIO,RTS			; disable Data from the host
        return

EscribirUSBDATA
	BSF	GPIO, DataMenos			;D- en "1"
;;	BSF	STATUS, RP0			;Selecciono Banco 1
	movlb	1
	MOVLW	~((1<<DataMenos)|(1<<DataMas))	;'00001000' Todas salidas menos SE0
	ANDWF	TRISIO,F			;SE0 Entrada
;;	BCF	STATUS, RP0			;Selecciono Banco 0
	movlb	0
;1	DECF	Var_2, W
;1	SUBLW	0xFF
;1	MOVWF	TMR0
;1	MOVLW	0xA0
;1	MOVWF	INTCON				;Interrupción por desbordamiento de TMR0
	movf	Var_2, W			;1
	movwf	PR2				;1
	clrf	TMR2				;1
	bsf	T2CON,TMR2ON			;1				{0} [0]
	MOVLW	0x07				;				{1} [1]
	MOVWF	Veces				;Cargo Variable con 7		{2} [2]
	MOVLW	((1<<DataMenos)|(1<<DataMas))	;Solamente los bits D- y D+	{3} [3]
;;;	NOP					;				{0} [4]
;;;	nop					;				 +  [0]
	goto	$+1
SincUSB2
	XORWF	GPIO, F				;invierto D- y D+		{1} [1]
	nop					;				 +  [2]
	DECFSZ	Veces, F			;				{2} [3]
	GOTO	SincUSB2			;				{30}[40]
	MOVLW	RespPID				;Registro Indirecto		{0} [0]
	MOVWF	FSR				;				{1} [1]
	MOVLW	((1<<DataMenos)|(1<<DataMas))	;Solamente los bits D- y D+	{2} [2]
;;;	NOP					;				{3} [3]
;;;	nop					;				 +  [4]
	goto	$+1
	BTFSS	INDF, 0				;				{0} [0]
	XORWF	GPIO, F				;..."0" invierto D- y D+	{1} [1]
	GOTO	MandarSigByte			;				{23}[23]
MandarSigByte
	nop					;				 	 +  [4]
	BTFSS	INDF, 1				;Si el bit 1 del Dato a mandar es...	{0} [0]
	XORWF	GPIO, F				;..."0" invierto D- y D+		{1} [1]
	btfsc	PIR1,TMR2IF			;					{2} [2]
	goto	TMovf				;					{3} [3]
	nop					;				 	 +  [4]
	BTFSS	INDF, 2				;Si el bit 2 del Dato a mandar es...	{0} [0]
	XORWF	GPIO, F				;..."0" invierto D- y D+		{1} [1]
	btfsc	PIR1,TMR2IF			;					{2} [2]
	goto	TMovf				;					{3} [3]
	nop					;				 	 +  [4]
	BTFSS	INDF, 3				;Si el bit 3 del Dato a mandar es...	{0} [0]
	XORWF	GPIO, F				;..."0" invierto D- y D+		{1} [1]
	btfsc	PIR1,TMR2IF			;					{2} [2]
	goto	TMovf				;					{3} [3]
	nop					;				 	 +  [4]
	BTFSS	INDF, 4				;Si el bit 4 del Dato a mandar es...	{0} [0]
	XORWF	GPIO, F				;..."0" invierto D- y D+		{1} [1]
	btfsc	PIR1,TMR2IF			;					{2} [2]
	goto	TMovf				;					{3} [3]
	nop					;				 	 +  [4]
	BTFSS	INDF, 5				;Si el bit 5 del Dato a mandar es...	{0} [0]
	XORWF	GPIO, F				;..."0" invierto D- y D+		{1} [1]
	btfsc	PIR1,TMR2IF			;					{2} [2]
	goto	TMovf				;					{3} [3]
	nop					;				 	 +  [4]
	BTFSS	INDF, 6				;Si el bit 6 del Dato a mandar es...	{0} [0]
	XORWF	GPIO, F				;..."0" invierto D- y D+		{1} [1]
	btfsc	PIR1,TMR2IF			;					{2} [2]
	goto	TMovf				;					{3} [3]
	nop					;				 	 +  [4]
	BTFSS	INDF, 7				;Si el bit 7 del Dato a mandar es...	{0} [0]
	XORWF	GPIO, F				;..."0" invierto D- y D+		{1} [1]
	INCF	FSR, F				;					{2} [2]
;;;	NOP					;					{3} [3]
;;;	nop					;				 	 +  [4]
	goto	$+1
	BTFSS	INDF, 0				;Si el bit 0 del Dato a mandar es...	{0} [0]
	XORWF	GPIO, F				;..."0" invierto D- y D+		{1} [1]
	GOTO	MandarSigByte				;				{23}[23]

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
	MOVLW	PID
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
	BSF	INTCON, GIE
LeerDescriptor
	MOVLW	Recibido_1			;Address Indirecto
	MOVWF	FSR
	CLRF	Var_3				;Limpio registro contador (principio de la tabla)
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
;;;	MOVLW	PID
;;;	MOVWF	FSR
;;;	MOVLW	0x4B				;'01001011' DATA1
;;;	BTFSS	Data1
;;;	MOVLW	0xC3				;'11000011' DATA0
;;;	MOVWF	INDF
;;;	BCF	Data1
;;;	BTFSS	INDF, 3
;;;	BSF	Data1
;;;	CALL	CalcularCRC16
;;;	CALL	InsertarCRC16
;;;	INCF	Var_3, F
;;;	CALL	InsertarBitStuffing
;;;	MOVLW	0x08
;;;	ADDWF	Var_2, F
	call	_PD
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
;;;	MOVWF	Var_3
;;;	GOTO	PrepararDescriptor
	goto	_GI2

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
;;;	MOVWF	Posicion
;;;	GOTO	LeerDescriptor
	goto	_SD2

Mandar_CONFIGURATION_Descriptor
	MOVLW	0x29				;Tamaño del Descriptor (41 Bytes)
	CALL	Label_A
	MOVLW	0x12				;Posición del Descriptor (18)
;;;	MOVWF	Posicion
;;;	GOTO	LeerDescriptor
	goto	_SD2

Mandar_HID_Descriptor
	MOVLW	0x09				;Tamaño del Descriptor (9 Bytes)
	CALL	Label_A
	MOVLW	0x24				;Posición del Descriptor (36)
;;;	MOVWF	Posicion
;;;	GOTO	LeerDescriptor
	goto	_SD2

Mandar_HIDReport_Descriptor
	MOVLW	0x19				;Tamaño del Descriptor (25 Bytes)
	CALL	Label_A
	MOVLW	0x3B				;Posición del Descriptor (59)
;;;	MOVWF	Posicion
;;;	GOTO	LeerDescriptor
	goto	_SD2

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
;;;	MOVWF	Posicion
;;;	GOTO	LeerDescriptor
	goto	_SD2

StringDescriptor1
	MOVLW	0x12				;Tamaño 18 Bytes (String Descriptor)
	CALL	Label_A
	MOVLW	0x58				;Posición en la tabla (88)...
;;;	MOVWF	Posicion
;;;	GOTO	LeerDescriptor
	goto	_SD2

StringDescriptor2
	MOVLW	0x56				;Tamaño 86 Bytes (String Descriptor)
	CALL	Label_A
	MOVLW	0x6A				;Posición en la tabla (106)...
_SD2
	MOVWF	Posicion
	GOTO	LeerDescriptor

GET_CONFIGURATION
	MOVFW	NuevoAddress
	MOVWF	Recibido_1
;;;	MOVLW	0x01
;;;	MOVWF	Var_3
;;;	GOTO	PrepararDescriptor
	goto	_GI1

SET_CONFIGURATION
	MOVFW	Recibido_3
	MOVWF	NuevoAddress
	BSF	Banderas_0, 1
	GOTO	ZLPPendiente

GET_INTERFACE
	CLRF	Recibido_1
_GI1
	MOVLW	0x01
_GI2
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
	RETLW	0x01				;18
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

SincUSB10
	XORWF	GPIO, F				;Invierto D- y D+			{0} [0]
	nop					;				 	 +  [1]
	DECFSZ	Veces, F			;Decremento mi variable...		{1} [2]
	GOTO	SincUSB10			;Sigo hasta terminar los 7 cambios...	{23}[34]
	MOVLW	0x10				;					{3} [4]
	MOVWF	Veces				;Cargo Variable con 16			{0} [0]
;;;	nop					;				 	 +  [1]
	MOVLW	((1<<DataMenos)|(1<<DataMas))	;Solamente los bits D- y D+		{1} [2]
;;;	NOP					;					{2} [3]
	goto	$+1
	BTFSS	ByteAMandar, 0			;Si el bit 0 del Dato a mandar es...	{3} [4]
	XORWF	GPIO, F				;..."0" invierto D- y D+		{0} [0]
	nop					;				 	 +  [1]
	GOTO	$ + 1				;					{12}[23]
	BTFSS	ByteAMandar, 1			;Si el bit 1 del Dato a mandar es...	{3} [4]
	XORWF	GPIO, F				;..."0" invierto D- y D+		{0} [0]
	nop					;				 	 +  [1]
	GOTO	$ + 1				;					{12}[23]
	BTFSS	ByteAMandar, 2			;Si el bit 2 del Dato a mandar es...	{3} [4]
	XORWF	GPIO, F				;..."0" invierto D- y D+		{0} [0]
	nop					;				 	 +  [1]
	GOTO	$ + 1				;					{12}[23]
	BTFSS	ByteAMandar, 3			;Si el bit 3 del Dato a mandar es...	{3} [4]
	XORWF	GPIO, F				;..."0" invierto D- y D+		{0} [0]
	nop					;				 	 +  [1]
	GOTO	$ + 1				;					{12}[23]
	BTFSS	ByteAMandar, 4			;Si el bit 4 del Dato a mandar es...	{3} [4]
	XORWF	GPIO, F				;..."0" invierto D- y D+		{0} [0]
	nop					;				 	 +  [1]
	GOTO	$ + 1				;					{12}[23]
	BTFSS	ByteAMandar, 5			;Si el bit 5 del Dato a mandar es...	{3} [4]
	XORWF	GPIO, F				;..."0" invierto D- y D+		{0} [0]
	nop					;				 	 +  [1]
	GOTO	$ + 1				;					{12}[23]
	BTFSS	ByteAMandar, 6			;Si el bit 6 del Dato a mandar es...	{3} [4]
	XORWF	GPIO, F				;..."0" invierto D- y D+		{0} [0]
	nop					;				 	 +  [1]
	GOTO	$ + 1				;					{12}[23]
	BTFSS	ByteAMandar, 7			;Si el bit 7 del Dato a mandar es...	{3} [4]
	XORWF	GPIO, F				;..."0" invierto D- y D+		{0} [0]
	nop					;				 	 +  [1]
	GOTO	ConfEntradas			;					{12}[23]

_PD
	MOVLW	PID
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
	RETURN

ProcessOut				; Custom code goes here
	BCF	INTCON, GIE
	CLRF	Var_4			; Limpio
	INCF	Var_4, F		; Incremento
SendL:
	call	bout+3		; send start bit
	movwf	cn		; cn=9
	rrf     Recibido_1,f	; set Carry		; 1
        call    bout		; wait 1bit and Carry=1	; 2+1+1+1+1+8N+6=8N+12
        decfsz  cn,f		; send 10bits?		; 1
        goto    $-3		; loop			; 2(1) total:1+8N+12+1+2=8N+16
	BSF	INTCON, GIE
	RETURN

bout:
        btfsc   STATUS,C
        bsf     GPIO,TX
        btfss   STATUS,C
        bcf     GPIO,TX

bwait:				; wait 1 bit
	call	bwait2				; 2+(4N+2)+(4N+2)=8N+6
bwait2:				; wait 1/2bit and Set Carry=1
	movlw   .256-((xtal/.4)/baud-.16)/.8	; 1
        addlw   0x01           			; 1
        btfss	STATUS,Z        		; 1
        goto    $-2             		; 2(1)
	retlw	0x09				; 2 total:1+(1+1+2)*N-1+2=4N+2

	END





