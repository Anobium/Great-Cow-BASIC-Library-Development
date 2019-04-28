;Program compiled by Great Cow BASIC (0.97.01 2017-02-20)
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email w_cholmondeley at users dot sourceforge dot net.

;********************************************************************************

;Set up the assembler options (Chip type, clock source, other bits and pieces)
 LIST p=16F18877, r=DEC
#include <P16F18877.inc>
 __CONFIG _CONFIG1, _RSTOSC_HFINT32
 __CONFIG _CONFIG2, _STVREN_OFF & _BOREN_OFF & _MCLRE_ON
 __CONFIG _CONFIG3, _WDTE_OFF
 __CONFIG _CONFIG4, _LVP_OFF

;********************************************************************************

;Set aside memory locations for variables
ADDR  EQU 32
BANKTOBESELECTED  EQU 33
BUTTONSTATE EQU 34
BYTENUM EQU 35
BYTETOBIN EQU 10172
COMPORT EQU 36
DDEBUG  EQU 37
DELAYTEMP EQU 112
DELAYTEMP2  EQU 113
ENC28J60_READREG  EQU 38
ENC_OUTBYTE EQU 39
ENC_OUTBYTE1  EQU 40
ENC_OUTBYTE2  EQU 41
HEX EQU 10130
HSERPRINTCRLFCOUNT  EQU 42
IPADDR  EQU 10154
IPPORT  EQU 43
IPROUTER  EQU 10149
IPSERVER  EQU 10144
IP_ID EQU 44
IP_ID_H EQU 45
I_CHECKSUM16  EQU 46
I_CHECKSUM16_H  EQU 47
LASTGET EQU 48
LASTSELECTEDBANK  EQU 49
MACADDR EQU 10165
MACADDRROUTER EQU 10139
NEXTPACKETPTR EQU 50
NEXTPACKETPTR_H EQU 51
OUTVALUETEMP  EQU 52
PHYREGADDR  EQU 53
PRINTLEN  EQU 54
SERDATA EQU 55
SERPRINTVAL EQU 56
SNTPSERVERADDR  EQU 10134
SPICLOCKMODE  EQU 57
SPICURRENTMODE  EQU 58
SPIRXDATA EQU 59
SPITXDATA EQU 60
SSPBUFTEMP1 EQU 61
SSPBUFTEMP2 EQU 62
STR EQU 10159
STRINGPOINTER EQU 63
SYSBITVAR0  EQU 64
SYSBYTETEMPA  EQU 117
SYSBYTETEMPB  EQU 121
SYSBYTETEMPX  EQU 112
SYSCALCTEMPA  EQU 117
SYSCALCTEMPX  EQU 112
SYSCALCTEMPX_H  EQU 113
SYSCHARCOUNT  EQU 65
SYSDIVLOOP  EQU 116
SYSDIVMULTA EQU 119
SYSDIVMULTA_H EQU 120
SYSDIVMULTB EQU 123
SYSDIVMULTB_H EQU 124
SYSDIVMULTX EQU 114
SYSDIVMULTX_H EQU 115
SYSMACADDRHANDLER EQU 66
SYSMACADDRHANDLER_H EQU 67
SYSPRINTDATAHANDLER EQU 68
SYSPRINTDATAHANDLER_H EQU 69
SYSPRINTTEMP  EQU 70
SYSREPEATTEMP1  EQU 71
SYSREPEATTEMP2  EQU 72
SYSREPEATTEMP3  EQU 73
SYSREPEATTEMP4  EQU 74
SYSREPEATTEMP5  EQU 75
SYSREPEATTEMP6  EQU 76
SYSREPEATTEMP7  EQU 77
SYSSTRDATA  EQU 78
SYSSTRINGA  EQU 119
SYSSTRINGA_H  EQU 120
SYSSTRINGLENGTH EQU 118
SYSSTRINGPARAM1 EQU 10181
SYSSTRINGTEMP EQU 79
SYSTEMP1  EQU 80
SYSTEMP1_H  EQU 81
SYSTEMP2  EQU 82
SYSVALTEMP  EQU 83
SYSVALTEMP_H  EQU 84
SYSWAITTEMPMS EQU 114
SYSWAITTEMPMS_H EQU 115
SYSWAITTEMPS  EQU 116
SYSWORDTEMPA  EQU 117
SYSWORDTEMPA_H  EQU 118
SYSWORDTEMPB  EQU 121
SYSWORDTEMPB_H  EQU 122
SYSWORDTEMPX  EQU 112
SYSWORDTEMPX_H  EQU 113
TABLESTARTPOINT EQU 85
TABLESTARTPOINT_H EQU 86

;********************************************************************************

;Alias variables
AFSR0 EQU 4
AFSR0_H EQU 5
SYSHEX_0  EQU 3122
SYSHEX_1  EQU 3123
SYSHEX_2  EQU 3124
SYSSTR_0  EQU 3151
ENC28J60_DATA EQU 46
ENC28J60_DATA_H EQU 47

;********************************************************************************

;Vectors
  ORG 0
  pagesel BASPROGRAMSTART
  goto  BASPROGRAMSTART
  ORG 4
  retfie

;********************************************************************************

;Start of program memory page 0
  ORG 5
BASPROGRAMSTART
;Call initialisation routines
  call  INITSYS
  call  INITUSART
  call  ETHERPARAMETERS

;Start of the main program
;Current limitations.
;1. Packet size cannot exceed 700 bytes.
;2. Means, web page table cannot exceed 595 bytes.
;3. Web pages have to be...... wait for this one.... an odd number of bytes!! ?
;So, if things do not work....
;1. Check the TCP packet size in the terminal windows - cannot exceed 685 bytes.
;2. Check the table - cannot exceed 595
;3. Make sure the TCP packet size in the terminal window is an odd number.
;All this is sortable but for today. We are in a great place!
;A web page is max at about 633... but, the converter strips out chars not required so this will vary on the CRLF's used.
;you need the latest HTML2GCB.EXE.  I have uploaded also.
;you need the latest compiler.  I have uploaded also.
;
;lots of todos
;''A program  for GCGB and GCB.
;''A program  for GCGB and GCB.
;''--------------------------------------------------------------------------------------------------------------------------------
;'' Description  :  Setup ENC28j60, then reads data from the Ethernet stream to a PC terminal.
;''
;'' You NEED a PC terminal connected to the serial out on the microprocessor.
;''
;''@author    [todo]
;''@licence   GPL
;''@version   [todo]
;''@date      [todo]
;''********************************************************************************
;
;#include "ENC28J60.h"
;#include "Ethernet.h"
;#define USART_BAUD_RATE 115200
;#define USART_BLOCKING
;#define USART_TX_BLOCKING
;----- Define Ethernet Hardware type
;#define ETHERNET_TYPE ETHERNET_TYPE_ENC28j60
;----- Define Hardware settings
;#Define Ethernet_DI               Portb.0   'Connected to Device SO
;#Define Ethernet_DO               Portb.3     'Connected to Device SI
;#Define Ethernet_SCK              Portb.1     'Connected to Clock
;#Define Ethernet_CS               Porta.5     'Chip select line
;#Define Ethernet_RESET            Portb.4     'Reset line
;----- Variables
;DIR PORTb.1 Out
;DIR PORTb.3 Out
;DIR PORTb.0 IN
;DIR Ethernet_CS OUT
;
;SPIMode MasterSlow, 0
;
;----- Quick Command Reference:
;----- Main body of program commences here.
;#ifdef ENC28j60_Hserial_Supported
;HSerPrintCRLF 2
;HserPrint "ENC28j60 Ethernet Driver 039a" : HSerPrintCRLF
;HSerSend 7
;#endif
RESET_ETHERNET_DEVICE
;ipaddr = 192,168,0,3
  movlw low IPADDR
  movwf FSR0L
  movlw high IPADDR
  movwf FSR0H
  movlw 4
  movwf INDF0
  incf  FSR0L,F
  movlw 192
  movwf INDF0
  incf  FSR0L,F
  movlw 168
  movwf INDF0
  incf  FSR0L,F
  clrf  INDF0
  incf  FSR0L,F
  movlw 3
  movwf INDF0
;macaddr = 0x00, 0x1E, 0xC0, 0x00, 0x00, 0x03
  movlw low MACADDR
  movwf FSR0L
  movlw high MACADDR
  movwf FSR0H
  movlw 6
  movwf INDF0
  incf  FSR0L,F
  clrf  INDF0
  incf  FSR0L,F
  movlw 30
  movwf INDF0
  incf  FSR0L,F
  movlw 192
  movwf INDF0
  incf  FSR0L,F
  clrf  INDF0
  incf  FSR0L,F
  clrf  INDF0
  incf  FSR0L,F
  movlw 3
  movwf INDF0
;IPRouter = 192,168,0,250
  movlw low IPROUTER
  movwf FSR0L
  movlw high IPROUTER
  movwf FSR0H
  movlw 4
  movwf INDF0
  incf  FSR0L,F
  movlw 192
  movwf INDF0
  incf  FSR0L,F
  movlw 168
  movwf INDF0
  incf  FSR0L,F
  clrf  INDF0
  incf  FSR0L,F
  movlw 250
  movwf INDF0
;MACaddrrouter = 0x38, 0x10, 0xd5, 0xef, 0x0e, 0xdb
  movlw low MACADDRROUTER
  movwf FSR0L
  movlw high MACADDRROUTER
  movwf FSR0H
  movlw 6
  movwf INDF0
  incf  FSR0L,F
  movlw 56
  movwf INDF0
  incf  FSR0L,F
  movlw 16
  movwf INDF0
  incf  FSR0L,F
  movlw 213
  movwf INDF0
  incf  FSR0L,F
  movlw 239
  movwf INDF0
  incf  FSR0L,F
  movlw 14
  movwf INDF0
  incf  FSR0L,F
  movlw 219
  movwf INDF0
;IPPort = 80
  movlw 80
  movwf IPPORT
;IPServer = 192,168,0,106
  movlw low IPSERVER
  movwf FSR0L
  movlw high IPSERVER
  movwf FSR0H
  movlw 4
  movwf INDF0
  incf  FSR0L,F
  movlw 192
  movwf INDF0
  incf  FSR0L,F
  movlw 168
  movwf INDF0
  incf  FSR0L,F
  clrf  INDF0
  incf  FSR0L,F
  movlw 106
  movwf INDF0
;SntpServerAddr = 129, 6, 15, 28
  movlw low SNTPSERVERADDR
  movwf FSR0L
  movlw high SNTPSERVERADDR
  movwf FSR0H
  movlw 4
  movwf INDF0
  incf  FSR0L,F
  movlw 129
  movwf INDF0
  incf  FSR0L,F
  movlw 6
  movwf INDF0
  incf  FSR0L,F
  movlw 15
  movwf INDF0
  incf  FSR0L,F
  movlw 28
  movwf INDF0
;ENC28j60_regdump
;Ethernet_Initialise( macaddr )
  movlw low MACADDR
  movwf SysMACADDRHandler
  movlw high MACADDR
  movwf SysMACADDRHandler_H
  pagesel ENC28J60_INIT
  call  ENC28J60_INIT
  pagesel $

;do
SysDoLoop_S1
;HserPrint "Initialised"
  movlw low StringTable2
  movwf SysPRINTDATAHandler
  movlw (high StringTable2) | 128
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;HSerPrintCRLF
  movlw 1
  movwf HSERPRINTCRLFCOUNT
  movlw 1
  movwf COMPORT
  pagesel HSERPRINTCRLF
  call  HSERPRINTCRLF
  pagesel $

;HserPrint "Initialised"
  movlw low StringTable2
  movwf SysPRINTDATAHandler
  movlw (high StringTable2) | 128
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;HSerPrintCRLF
  movlw 1
  movwf HSERPRINTCRLFCOUNT
  movlw 1
  movwf COMPORT
  pagesel HSERPRINTCRLF
  call  HSERPRINTCRLF
  pagesel $

;loop
  goto  SysDoLoop_S1
SysDoLoop_E1
;#Define SwitchIn porta.4
;dir SwitchIn  in
  bsf TRISA,4
;#Define ButtonDown = 1
;dim buttonstate as byte
;buttonstate = ButtonDown
  movlw 1
  movwf BUTTONSTATE
;ENC28j60_writeReg( ERXFCON, 0 )
  movlw 56
  movwf ADDR
  clrf  ENC_OUTBYTE
  pagesel ENC28J60_WRITEREG
  call  ENC28J60_WRITEREG
  pagesel $

;dim myReadTime as bit
;myReadTime = 0
  bcf SYSBITVAR0,0
;ENC28j60_bitSet( ECON1 , econ1_txrst )
  movlw 31
  movwf ADDR
  movlw 128
  movwf ENC_OUTBYTE
  pagesel ENC28J60_BITSET
  call  ENC28J60_BITSET
  pagesel $

;ENC28j60_bitClear( ECON1 , econ1_txrst )
  movlw 31
  movwf ADDR
  movlw 128
  movwf ENC_OUTBYTE
  pagesel ENC28J60_BITCLEAR
  call  ENC28J60_BITCLEAR
  pagesel $

;ENC28j60_bitClear( EIR , EIR_TXERIF )
  movlw 28
  movwf ADDR
  movlw 2
  movwf ENC_OUTBYTE
  pagesel ENC28J60_BITCLEAR
  call  ENC28J60_BITCLEAR
  pagesel $

;ENC28j60_regdump
  call  ENC28J60_REGDUMP

;ENC28j60_setfrequency ( 5 )
  movlw 5
  movwf ENC_OUTBYTE
  pagesel ENC28J60_SETFREQUENCY
  call  ENC28J60_SETFREQUENCY
  pagesel $

;dir portd.3 out
  bcf TRISD,3
;Do forever
SysDoLoop_S2
;if SwitchIn = buttonstate then
  clrf  SysCalcTempA
  btfsc PORTA,4
  incf  SysCalcTempA,F
  movf  BUTTONSTATE,W
  subwf SysCalcTempA,W
  btfss STATUS, Z
  goto  ENDIF2
;if buttonstate  = ButtonDown then
  decf  BUTTONSTATE,W
  btfss STATUS, Z
  goto  ENDIF3
;end if
ENDIF3
;end if
ENDIF2
;ENC28j60_poll 'Start the process.
;portd.3 =!portd.3
  clrf  SysTemp1
  btfsc PORTD,3
  incf  SysTemp1,F
  comf  SysTemp1,F
  bcf LATD,3
  btfsc SysTemp1,0
  bsf LATD,3
;if myReadTime = 0 then
;ENC28j60_sntp_get                       'get the Network Time once
;myReadTime = 1
;end if
;Loop
  goto  SysDoLoop_S2
SysDoLoop_E2
;end
  goto  BASPROGRAMEND
;; ----- Support methods.  Subroutines and Functions
;
;' CHANGE Epoch_seconds  TO SUIT LOCAL NEEDS.. IN SECONDS!!
;sub ENC28j60_UTC_Adjust ( in Epoch_seconds AS long )
;
;'London time
;'  Epoch_seconds = Epoch_seconds + 3600
;
;'South Africa time
;Epoch_seconds = Epoch_seconds + 7200
;
;
;End sub
;
;
;Sub My_udp_handler
;
;;  Uncomment to show UDP packet data
;'            dim I_x as word
;'
;;        Calcualte UDP packet length
;'            I_value16_h = T_udp_len0
;'            [byte]I_value16 = T_udp_len1
;'            I_value16 = I_value16 - 8
;'
;'            For I_x = T_udp_data_pointer To ( T_udp_data_pointer + I_value16 - 1 )
;'                HSerPrint i_x
;'                HSerPrint "."
;'              Next
;'            HSerPrintCRLF
;'
;'            For I_x = T_udp_data_pointer To ( T_udp_data_pointer + I_value16 - 1 )
;'              HSerPrint hex(etherbuffer(i_x))
;'              HSerPrint ":"
;'            Next
;'            HSerPrintCRLF
;'
;'            For I_x = T_udp_data_pointer To ( T_udp_data_pointer + I_value16 - 1 )
;'                HSerPrint chr(etherbuffer(i_x))
;'              Next
;'            HSerPrintCRLF
;'            HSerPrint " -----------------------------------------------"
;'            HSerPrintCRLF
;
;select case T_udp_destport
;case 6000
;
;#ifdef ENC28j60_reinitialisation_Supported
;if T_udp_data = "R" then
;ENC28j60_Initialise
;goto Reset_ENC26j60
;end if
;#endif
;
;#ifdef ENC28j60regdump_Supported
;if T_udp_data = "D" then
;ENC28j60_regdump
;end if
;#endif
;
;case 5000
;
;'non-echo on PORT 5000
;Select Case T_udp_data
;
;#ifdef ENC28j60_sntp_Remote_Supported
;CASE "T"
;HserPrint "Time...": HSerPrintCRLF
;ENC28j60_sntp_get
;#endif
;
;End Select
;
;
;case 5002
;
;;        Calcualte UDP packet length
;I_value16_h = T_udp_len0
;[byte]I_value16 = T_udp_len1
;I_value16 = I_value16 - 8
;
;#ifdef ENC28j60_Lcd_Supported
;If  I_value16 = 2  then 'LCD Command
;
;select case T_udp_data0
;case 0
;'clear lcd
;Cls
;case 1
;Locate (0,0)
;Print "locate 1,0"
;case 2
;Locate (1,0)
;Print "locate 2,0"
;case 3
;Locate (2,0)
;Print "locate 3,0"
;case 4
;Locate (3,0)
;Print "locate 4,0"
;end select
;
;else
;
;'LCD string
;Locate (0,0)
;Print chr(T_udp_data0)
;End If
;#endif
;
;'LCD Control on PORT 5002
;if  I_value16 = 2  then 'LCD Command
;
;select case T_udp_data0
;case 0
;'clear lcd
;HSerPrint "CLS"
;case 1
;HSerPrint "locate 1,0"
;case 2
;HSerPrint "locate 2,0"
;case 3
;HSerPrint "locate 3,0"
;case 4
;HSerPrint "locate 4,0"
;
;end select
;HSerPrintCRLF
;
;else
;
;'LCD string
;HSerprint "Print "
;HSerSend T_udp_data0
;HSerPrintCRLF
;end if
;
;end select
;'
;End Sub
;
;;If you want use the CALCULATED UDP checksum.  Not required typically.
;'    #define ENC28j60_UDP_checkSum_Supported
;
;;If you want the ENC28j60 to respond to ICMP/Ping requests
;#define ENC28j60_ping_Supported
;
;;If you want the ENC28j60 to put things on the LCD
;'    #define ENC28j60_Lcd_Supported
;
;;If you want the ENC28j60 to put things on the terminal
;#define ENC28j60_Hserial_Supported
;;If you want to implement packet counting - you require ENC28j60_Hserial_Supported
;'        #define ENC28j60_packetCounting_Supported
;;If you want to see the buffer error messages - you require ENC28j60_Hserial_Supported
;#define ENC28j60_BufferErrorMessages_Supported
;;If you want to see the incoming packets
;'        #define ReceivePacketDebug_Supported
;;If you want to see the HTTP packet info
;#define ENC28j60_ShowHTTPInfo_Supported
;;If you want to see the HTTP header
;'        #define ShowHTTPHeader_Supported
;;If you want to see the HTTP Flag status
;'        #define ShowHTTPFlags
;
;;If you want the UDP protocols to be supported.  You cannot turn off UDP/ARP
;#define ENC28j60_UDP_Supported
;;If you want to use UDP/Port 6000 and R to remote reset the ENC28j60 via UDP terminal application
;#define ENC28j60_reinitialisation_Supported
;
;;If you want to use UDP/SNTP time. Provides lookup and terminal... but you will require ENC28j60_Hserial_Supported for the terminal!
;#define ENC28j60_sntp_Supported
;
;;If you want to adjust the UDP/SNTP time. You need to define a sub called ENC28j60_UTC_Adjust ( in Epoch_seconds as Long )
;#define ENC28j60_sntp_UTC_adjust_supported
;
;;If you want to call the UDP/SNTP time get time event.  Use a UDP client application on Port 5000 and "T" to call remote SNTP time.  Will display result on terminal.
;#define ENC28j60_sntp_Remote_Supported
;
;;If you want to adjust the UDP/ECHO on port 7
;#define ENC28j60_Echo7_Supported
;
;;If you want to support the UDP/Port 6000 and D to dump the registers from a UDP terminal application to the terminal
;#define ENC28j60regdump_Supported
;
;;If you want the TCP protocols to be supported.
;#define ENC28j60_tcp_supported
;;If you want the HTTP protocol to be supported.
;#define ENC28j60_http_supported
;
;;If you want the Telnet protocol to be supported.
;'        #define ENC28j60_telnet_supported
;
;
;;If you want to add your own UDP handler.
;'         #define ENC28j60_Handle_udp My_udp_handler
;
;
;'''http://www.hackshed.co.uk/lets-build-a-functional-arduino-webserver-sdcard-ethernet/
;'#define HTTP_HANDLER userSubAJAX
;'#define etherBufferSize 500
;'sub userSubAJAX
;'    HTTPPrint str(55155)
;'
;'end sub
;
;
;'http://tmail.mooo.com:8080                         'shows index.htm
;'http://tmail.mooo.com:8080/index.htm               'shows index.htm
;'http://tmail.mooo.com:8080/?data=val1              'currently, shows port status page. This will be an AJAX call.
;'This will be  tmail.mooo.com:8080/ADCPage.htm
;'http://tmail.mooo.com:8080/?data=val1              'not operational. Will be AJAX call.
;'http://tmail.mooo.com:8080/anyinvalidurl           'shows 403 error
;
;'#define HTTP_HANDLER myHTTP_HANDLER
;#define HTTP_HANDLER PortsStatus_HTM
;#define etherBufferSize 1000
;
;sub myHTTP_HANDLER
;
;#ifdef ENC28j60_ShowHTTPInfo_Supported
;HSerPrint "/"
;HSerPrint CommandLineString
;HSerPrintCRLF
;#endif
;
;if CommandLineString="index.htm" then
;Index_HTM
;exit Sub
;end if
;
;if left(CommandLineString,1)="?" then
;PortsStatus_HTM
;exit Sub
;end if
;
;'else.......
;Error400_HTM
;#ifdef ENC28j60_ShowHTTPInfo_Supported
;HSerPrintCRLF
;#endif
;
;end sub
;
;
;Sub PortsStatus_HTM
;dim analogChannel as byte
;dir porta.0 in
;dir porta.1 in
;dir porta.2 in
;dir porta.3 in
;
;'Auto refresh web page
;HTTPPrint( "REFRESH: 5",HTTPPrintCRLF )
;'You must close off the header by add
;HTTPPrint( "", HTTPPrintCRLF )
;
;HTTPPrint ( "<html><font face=helvetica>")
;HTTPPrint ( "<img alt=""GCB Logo!"" title=""Great Cow BASIC v0.39"" ")
;HTTPPrint ( "src=""http://goo.gl/FZ4v4e"" height=""36"" ")
;HTTPPrint ("width=""243""><br><br />" )
;HTTPPrint  ("&nbsp;&nbsp;Evan is ")
;
;if ReadAD( 0 ) < 50 then
;HTTPPrint ("not ")
;end if
;HTTPPrint " in the lab at the moment.."
;
;if ReadAD( 0 ) < 50 then
;HTTPPrint ("probably working elsewhere, having family time or even asleep!")
;Else
;HTTPPrint ("probably working on a Great Cow BASIC solution!")
;end if
;
;
;HTTPPrint "<br /><br />"
;HTTPPrint "&nbsp;&nbsp;Analog inputs are: "
;HTTPPrint "<br />"
;for analogChannel = 0 to 3
;HTTPPrint "<br />&nbsp;&nbsp;ADC"
;HTTPPrint str(analogChannel)
;HTTPPrint ": "
;HTTPPrint str(ReadAD( analogChannel ))
;HTTPPrint "<br />"
;next
;HTTPPrint "<br />"
;HTTPPrint "&nbsp;&nbspPorts A:&nbsp;" + ByteToBin(porta)
;HTTPPrint "&nbsp;&nbsp;B:&nbsp;" + ByteToBin(portb)
;HTTPPrint "&nbsp;&nbsp;C:&nbsp;" + ByteToBin(portc)
;HTTPPrint "&nbsp;&nbsp;E:&nbsp;" + ByteToBin(porte)
;HTTPPrint "<br /><br />"
;HTTPPrint "&nbsp;&nbsp;Source: " + str(T_ip_destaddr0)
;HTTPPrint "." + str(T_ip_destaddr1)
;HTTPPrint "." + str(T_ip_destaddr2)
;HTTPPrint "." + str(T_ip_destaddr3)
;HTTPPrint "<br /><br />"
;
;HTTPPrint ( "<img alt=""Lab"" title=""Great Cow BASIC"" ")
;if ReadAD( 0 ) < 50 then
;
;HTTPPrint ( "src=""http://goo.gl/yNg5Tr"" height=""217"" width=""386"" ")
;Else
;
;HTTPPrint ( "src=""http://goo.gl/NUOFWu"" height=""424"" width=""239"" ")
;
;end if
;HTTPPrint ("><br><br />" )
;
;HTTPPrint ("</html>")
;
;HTTPSend
;End Sub
;
;Sub Error400_HTM
;HTTPPrint( "", HTTPPrintCRLF )
;
;HTTPPrint "<html><font face=helvetica>"
;HTTPPrint ( "<img alt=""GCB"" title=""Great Cow BASIC"" ")
;HTTPPrint ( "src=""http://goo.gl/FZ4v4e"" height=""36"" width=""243""><br>")
;HTTPPrint "<p><b>403.</b> Forbidden:  The request was a valid "
;HTTPPrint "request, but the server is refusing to respond "
;HTTPPrint "to it. <br /><br /><b>403.</b> Error semantically means "
;HTTPPrint "unauthorized"
;HTTPPrint ", i.e. the user does not have the necessary permissions"
;HTTPPrint "for the resource."
;HTTPPrint "<p>URL <code>/"
;HTTPPrint CommandLineString
;HTTPPrint "</code> was not found.  </b></b>That is all we know."
;
;HTTPPrint "</html>"
;
;HTTPSend
;
;
;end sub
;
;
;
;sub Index_HTM
;
;dim TableLoc as word
;HTTPPrint( "", HTTPPrintCRLF )
;
;For [word]TableLoc = 1 to SizeofTable1
;ReadTable index1, TableLoc,etherBuffer(arrayloc)
;;Want to see the HTML? uncomment..
;'                          HSerSend etherBuffer(arrayloc)
;arrayloc = arrayloc +1
;Next
;
;end sub
;'FILE:ENC28J60.h
;
;It is needed to called EtherParameters to setup the essential variables before we call any hardware specific methods.
;#define Ethernet_Initialise  ENC28j60_Init
;#define ETHERNET_TYPE                 ETHERNET_TYPE_ENC28j60
;#define ENC28j60_SPI_Command          SPIMode MasterSlow, 0
;#Define ENC28j60_DI     Ethernet_DI
;#Define ENC28j60_DO     Ethernet_DO
;#Define ENC28j60_SCK    Ethernet_SCK
;#Define ENC28j60_CS     Ethernet_CS
;#Define ENC28j60_RESET  Ethernet_RESET
;#define ENC28j60_Select         Set ENC28j60_CS off
;#define ENC28j60_Deselect       Set ENC28j60_CS on
;#define ENC28j60_Reset_CMD      Set ENC28j60_RESET on: Wait 20 ms :Set ENC28j60_RESET off: Wait 20 ms :Set ENC28j60_RESET on: Wait 20 ms
;/* Sets bits in a register */
;writes byte ENC_Outbyte in ENC register addr of the current bank
;dim ddebug as byte
;#define ENC28j60_Detailed_RegDump
;COCON2:COCON0: Clock Output Configuration bits
;111 = Reserved for factory test. Do not use. Glitch prevention not assured.
;110 = Reserved for factory test. Do not use. Glitch prevention not assured.
;101 = CLKOUT outputs main clock divided by 8 (3.125 MHz)
;100 = CLKOUT outputs main clock divided by 4 (6.25 MHz)
;011 = CLKOUT outputs main clock divided by 3 (8.333333 MHz)
;010 = CLKOUT outputs main clock divided by 2 (12.5 MHz)
;001 = CLKOUT outputs main clock divided by 1 (25 MHz)
;000 = CLKOUT is disabled. The pin is driven low
CONFIGURATIONDETAILS
;Important bit maps
;#define EPKTDEC 0x40
;#define DMAST   0x20
;#define CSUMEN  0x10
;#define TXRTS   0x08
;#define MIIRD   0x01
;#define BUSY    0x01
;#define CLKRDY  0x01
;#define RXEN    0x04
MEMORY_LOCATIONS_SCRIPT
;Set ENC28j60 Memory locations
;ENC28j60 Control Registers
;#define WCRCMD  b'01000000'      ; write control register
;#define BFCCMD  b'10100000'      ; bit field clear
;#define BFSCMD  b'10000000'      ; bit field set
;Control register definitions are a combination of address,
;bank number, and Ethernet/MAC/PHY indicator bits.
;- Register address  (bits 0-4)
;- Bank number (bits 5-6)
;- MAC/MII indicator (bit 7)
;
;#define ADDR_MASK 0x1F
;#define BANK_MASK 0x60
;#define SPRD_MASK 0x80
;All-bank registers'
;#define BANK0   0
;#define BANK1   1
;#define BANK2   2
;#define BANK3   3
;#define EIE   0x1B
;#define EIR   0x1C
;#define ESTAT   0x1D
;#define ECON2   0x1E
;#define ECON1   0x1F
;Bank 0 registers'
;#define ERDPTL    (0x00|0x00)
;#define ERDPTH    (0x01|0x00)
;#define EWRPTL    (0x02|0x00)
;#define EWRPTH    (0x03|0x00)
;#define ETXSTL    (0x04|0x00)
;#define ETXSTH    (0x05|0x00)
;#define ETXNDL    (0x06|0x00)
;#define ETXNDH    (0x07|0x00)
;#define ERXSTL    (0x08|0x00)
;#define ERXSTH    (0x09|0x00)
;#define ERXNDL    (0x0A|0x00)
;#define ERXNDH    (0x0B|0x00)
;#define ERXRDPTL  (0x0C|0x00)
;#define ERXRDPTH  (0x0D|0x00)
;#define ERXWRPTL  (0x0E|0x00)
;#define ERXWRPTH  (0x0F|0x00)
;#define EDMASTL   (0x10|0x00)
;#define EDMASTH   (0x11|0x00)
;#define EDMANDL   (0x12|0x00)
;#define EDMANDH   (0x13|0x00)
;#define EDMADSTL  (0x14|0x00)
;#define EDMADSTH  (0x15|0x00)
;#define EDMACSL   (0x16|0x00)
;#define EDMACSH   (0x17|0x00)
;Bank 1 registers'
;#define EHT0    (0x00|0x20)
;#define EHT1    (0x01|0x20)
;#define EHT2    (0x02|0x20)
;#define EHT3    (0x03|0x20)
;#define EHT4    (0x04|0x20)
;#define EHT5    (0x05|0x20)
;#define EHT6    (0x06|0x20)
;#define EHT7    (0x07|0x20)
;#define EPMM0   (0x08|0x20)
;#define EPMM1   (0x09|0x20)
;#define EPMM2   (0x0A|0x20)
;#define EPMM3   (0x0B|0x20)
;#define EPMM4   (0x0C|0x20)
;#define EPMM5   (0x0D|0x20)
;#define EPMM6   (0x0E|0x20)
;#define EPMM7   (0x0F|0x20)
;#define EPMCSL    (0x10|0x20)
;#define EPMCSH    (0x11|0x20)
;#define EPMOL   (0x14|0x20)
;#define EPMOH   (0x15|0x20)
;#define EWOLIE    (0x16|0x20)
;#define EWOLIR    (0x17|0x20)
;#define ERXFCON   (0x18|0x20)
;#define EPKTCNT   (0x19|0x20)
;Bank 2 registers'
;#define MACON1    (0x00|0x40|SPRD_MASK)
;#define MACON2 (0x01|0x40|SPRD_MASK)'
;#define MACON3    (0x02|0x40|SPRD_MASK)
;#define MACON4    (0x03|0x40|SPRD_MASK)
;#define MABBIPG   (0x04|0x40|SPRD_MASK)
;#define MAIPGL    (0x06|0x40|SPRD_MASK)
;#define MAIPGH    (0x07|0x40|SPRD_MASK)
;#define MACLCON1  (0x08|0x40|SPRD_MASK)
;#define MACLCON2  (0x09|0x40|SPRD_MASK)
;#define MAMXFLL   (0x0A|0x40|SPRD_MASK)
;#define MAMXFLH   (0x0B|0x40|SPRD_MASK)
;#define MAPHSUP    (0x0D|0x40|SPRD_MASK)
;#define MICON    (0x11|0x40|SPRD_MASK)
;#define MICMD   (0x12|0x40|SPRD_MASK)
;#define MIREGADR  (0x14|0x40|SPRD_MASK)
;#define MIWRL   (0x16|0x40|SPRD_MASK)
;#define MIWRH   (0x17|0x40|SPRD_MASK)
;#define MIRDL   (0x18|0x40|SPRD_MASK)
;#define MIRDH   (0x19|0x40|SPRD_MASK)
;Bank 3 registers'
;#define MAADR1    (0x00|0x60|SPRD_MASK)
;#define MAADR0    (0x01|0x60|SPRD_MASK)
;#define MAADR3    (0x02|0x60|SPRD_MASK)
;#define MAADR2    (0x03|0x60|SPRD_MASK)
;#define MAADR5    (0x04|0x60|SPRD_MASK)
;#define MAADR4    (0x05|0x60|SPRD_MASK)
;#define EBSTSD    (0x06|0x60)
;#define EBSTCON   (0x07|0x60)
;#define EBSTCSL   (0x08|0x60)
;#define EBSTCSH   (0x09|0x60)
;#define MISTAT    (0x0A|0x60|SPRD_MASK)
;#define EREVID    (0x12|0x60)
;#define ECOCON    (0x15|0x60)
;#define EFLOCON   (0x17|0x60)
;#define EPAUSL    (0x18|0x60)
;#define EPAUSH    (0x19|0x60)
;PHY registers'
;#define PHCON1    0x00
;#define PHSTAT1   0x01
;#define PHHID1    0x02
;#define PHHID2    0x03
;#define PHCON2    0x10
;#define PHSTAT2   0x11
;#define PHIE    0x12
;#define PHIR    0x13
;#define PHLCON    0x14
;ENC28j60 EIE Register Bit Definitions'
;#define EIE_INTIE 0x80
;#define EIE_PKTIE 0x40
;#define EIE_DMAIE 0x20
;#define EIE_LINKIE  0x10
;#define EIE_TXIE  0x08
;#define EIE_WOLIE  0x04 (reserved)'
;#define EIE_TXERIE  0x02
;#define EIE_RXERIE  0x01
;ENC28j60 EIR Register Bit Definitions'
;#define EIR_PKTIF 0x40
;#define EIR_DMAIF 0x20
;#define EIR_LINKIF  0x10
;#define EIR_TXIF  0x08
;#define EIR_WOLIF  0x04 (reserved)'
;#define EIR_TXERIF  0x02
;#define EIR_RXERIF  0x01
;ENC28j60 ESTAT Register Bit Definitions'
;#define ESTAT_INT 0x80
;#define ESTAT_LATECOL 0x10
;#define ESTAT_RXBUSY  0x04
;#define ESTAT_TXABRT  0x02
;#define ESTAT_CLKRDY  0x01
;ENC28j60 ECON2 Register Bit Definitions'
;#define ECON2_AUTOINC 0x80
;#define ECON2_PKTDEC  0x40
;#define ECON2_PWRSV 0x20
;#define ECON2_VRPS  0x08
;ENC28j60 ECON1 Register Bit Definitions'
;#define ECON1_TXRST 0x80
;#define ECON1_RXRST 0x40
;#define ECON1_DMAST 0x20
;#define ECON1_CSUMEN  0x10
;#define ECON1_TXRTS 0x08
;#define ECON1_RXEN  0x04
;#define ECON1_BSEL1 0x02
;#define ECON1_BSEL0 0x01
;ENC28j60 MACON1 Register Bit Definitions'
;#define MACON1_LOOPBK 0x10
;#define MACON1_TXPAUS 0x08
;#define MACON1_RXPAUS 0x04
;#define MACON1_PASSALL  0x02
;#define MACON1_MARXEN 0x01
;ENC28j60 MACON2 Register Bit Definitions'
;#define MACON2_MARST  0x80
;#define MACON2_RNDRST 0x40
;#define MACON2_MARXRST  0x08
;#define MACON2_RFUNRST  0x04
;#define MACON2_MATXRST  0x02
;#define MACON2_TFUNRST  0x01
;ENC28j60 MACON3 Register Bit Definitions'
;#define MACON3_PADCFG2  0x80
;#define MACON3_PADCFG1  0x40
;#define MACON3_PADCFG0  0x20
;#define MACON3_TXCRCEN  0x10
;#define MACON3_PHDRLEN  0x08
;#define MACON3_HFRMLEN  0x04
;#define MACON3_FRMLNEN  0x02
;#define MACON3_FULDPX 0x01
;ENC28j60 MICMD Register Bit Definitions'
;#define MICMD_MIISCAN 0x02
;#define MICMD_MIIRD 0x01
;ENC28j60 MISTAT Register Bit Definitions'
;#define MISTAT_NVALID 0x04
;#define MISTAT_SCAN 0x02
;#define MISTAT_BUSY 0x01
;ENC28j60 ERXFCON Register Bit Definitions'
;#define ERXFCON_UCEN  0x80
;#define ERXFCON_ANDOR 0x40
;#define ERXFCON_CRCEN 0x20
;#define ERXFCON_PMEN  0x10
;#define ERXFCON_MPEN  0x08
;#define ERXFCON_HTEN  0x04
;#define ERXFCON_MCEN  0x02
;#define ERXFCON_BCEN  0x01
;ENC28j60 PHY PHCON1 Register Bit Definitions'
;#define PHCON1_PRST 0x8000
;#define PHCON1_PLOOPBK  0x4000
;#define PHCON1_PPWRSV 0x0800
;#define PHCON1_PDPXMD 0x0100
;ENC28j60 PHY PHSTAT1 Register Bit Definitions'
;#define PHSTAT1_PFDPX 0x1000
;#define PHSTAT1_PHDPX 0x0800
;#define PHSTAT1_LLSTAT  0x0004
;#define PHSTAT1_JBSTAT  0x0002
;ENC28j60 PHY PHSTAT2 Register Bit Definitions'
;#define PHSTAT2_TXSTAT  (1 << 13)
;#define PHSTAT2_RXSTAT  (1 << 12)
;#define PHSTAT2_COLSTAT (1 << 11)
;#define PHSTAT2_LSTAT (1 << 10)
;#define PHSTAT2_DPXSTAT (1 << 9)
;#define PHSTAT2_PLRITY  (1 << 5)
;ENC28j60 PHY PHCON2 Register Bit Definitions'
;#define PHCON2_FRCLINK  0x4000
;#define PHCON2_TXDIS  0x2000
;#define PHCON2_JABBER 0x0400
;#define PHCON2_HDLDIS 0x0100
;ENC28j60 PHY PHIE Register Bit Definitions'
;#define PHIE_PLNKIE (1 << 4)
;#define PHIE_PGEIE  (1 << 1)
;ENC28j60 PHY PHIR Register Bit Definitions'
;#define PHIR_PLNKIF (1 << 4)
;#define PHIR_PGEIF  (1 << 1)
;ENC28j60 Packet Control Byte Bit Definitions'
;#define PKTCTRL_PHUGEEN   0x08
;#define PKTCTRL_PPADEN    0x04
;#define PKTCTRL_PCRCEN    0x02
;#define PKTCTRL_POVERRIDE 0x01
;ENC28j60 Transmit Status Vector'
;#define TSV_TXBYTECNT   0
;#define TSV_TXCOLLISIONCNT  16
;#define TSV_TXCRCERROR    20
;#define TSV_TXLENCHKERROR 21
;#define TSV_TXLENOUTOFRANGE 22
;#define TSV_TXDONE    23
;#define TSV_TXMULTICAST   24
;#define TSV_TXBROADCAST   25
;#define TSV_TXPACKETDEFER 26
;#define TSV_TXEXDEFER   27
;#define TSV_TXEXCOLLISION 28
;#define TSV_TXLATECOLLISION 29
;#define TSV_TXGIANT   30
;#define TSV_TXUNDERRUN    31
;#define TSV_TOTBYTETXONWIRE 32
;#define TSV_TXCONTROLFRAME  48
;#define TSV_TXPAUSEFRAME  49
;#define TSV_BACKPRESSUREAPP 50
;#define TSV_TXVLANTAGFRAME  51
;#define TSV_SIZE    7
;#define TSV_BYTEOF(x)    ((x) / 8)
;#define TSV_BITMASK(x)   (1 << ((x) % 8))
;#define TSV_GETBIT(x, y) (((x)[TSV_BYTEOF(y)] & TSV_BITMASK(y)) ? 1 : 0)
;ENC28j60 Receive Status Vector'
;#define RSV_RXLONGEVDROPEV  16
;#define RSV_CARRIEREV   18
;#define RSV_CRCERROR    20
;#define RSV_LENCHECKERR   21
;#define RSV_LENOUTOFRANGE 22
;#define RSV_RXOK    23
;#define RSV_RXMULTICAST   24
;#define RSV_RXBROADCAST   25
;#define RSV_DRIBBLENIBBLE 26
;#define RSV_RXCONTROLFRAME  27
;#define RSV_RXPAUSEFRAME  28
;#define RSV_RXUNKNOWNOPCODE 29
;#define RSV_RXTYPEVLAN    30
;#define RSV_SIZE    6
;#define RSV_BITMASK(x)   (1 << ((x) - 16))
;#define RSV_GETBIT(x, y) (((x) & RSV_BITMASK(y)) ? 1 : 0)
;SPI operation codes'
;#define ENC28j60_READ_CTRL_REG  0x00
;#define ENC28j60_READ_BUF_MEM 0x3A
;#define ENC28j60_WRITE_CTRL_REG 0x40
;#define ENC28j60_WRITE_BUF_MEM  0x7A
;#define ENC28j60_BIT_FIELD_SET  0x80
;#define ENC28j60_BIT_FIELD_CLR  0xA0
;#define ENC28j60_SOFT_RESET 0xFF
;#define TXEND_INIT    0x1FFF
;#define TXEND_INIT_b    0x1F
;#define TXEND_INIT_h    0xFF
;Put RX buffer at 0 as suggested by the Errata datasheet'
;#define RXSTART_INIT    0x0000
;#define RXSTART_INIT_b    0x00
;#define RXSTART_INIT_h    0x00
;#define RXEND_INIT    0x19FF
;#define RXEND_INIT_b    0xFF
;#define RXEND_INIT_h    0x19
;maximum ethernet frame length'
;#define MAX_FRAMELEN    1518
;Preferred half duplex: LEDA: Link status LEDB: Rx/Tx activity'
;#define ENC28j60_LAMPS_MODE 0x3476
;'FILE:Ethernet.h
;Ethernet setup and buffer definitions for the GCBASIC compiler
;Copyright (C) 2017 Evan Venn
;This library is free software; you can redistribute it and/or
;modify it under the terms of the GNU Lesser General Public
;License as published by the Free Software Foundation; either
;version 2.1 of the License, or (at your option) any later version.
;This library is distributed in the hope that it will be useful,
;but WITHOUT ANY WARRANTY; without even the implied warranty of
;MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;Lesser General Public License for more details.
;You should have received a copy of the GNU Lesser General Public
;License along with this library; if not, write to the Free Software
;Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
;Notes
;28/03/2017 Initial release
;Ethernet Hardware types
;#define ETHERNET_TYPE_ENC28j60 1
;dim macaddr(6)
;dim ipaddr(4)
;dim ipserver(4)
;dim iprouter(4)
;dim macaddrrouter(4)
;dim sntpserveraddr(4)
;dim ipport as byte
;#define etherBufferSize 730
;dim etherbuffer(etherBufferSize)
;dim nextpacketptr as word
;dim I_checksum16 as word
;dim I_value16 as word alias I_checksum16_H, I_checksum16
;Dim Ip_id As Word
;dim T_udp_destport as word
;Dim hulp2 As Word
;Dim Incoming_ack as Long
;dim commandlineString as string * 12
;dim arrayloc,TableLoc as word
;dim HTTPStandardHeaderStatusBit as Byte
;dim HTTPSentTCPPacket, lastGet as byte
;dim TCPresult16, TableStartPoint as word
;#define HTTPPrintCRLF 1
;dim lastselectedBank, banktobeselected as byte
;dim SSPBUFtemp1, SSPBUFtemp2 as byte
;Recommend not to change any of this definitions.
;IP Header Size
;#define IP_HeaderSize 14
;These defines all refer to the defined array - etherbuffer
;dim etherbuffer(etherBufferSize)
;Ethernet packet destination
;#Define T_enetpacketdest0 etherbuffer(0x01)
;#Define T_enetpacketdest1 etherbuffer(0x02)
;#Define T_enetpacketdest2 etherbuffer(0x03)
;#Define T_enetpacketdest3 etherbuffer(0x04)
;#Define T_enetpacketdest4 etherbuffer(0x05)
;#Define T_enetpacketdest5 etherbuffer(0x06)
;Ethernet packet source
;#Define T_enetpacketsrc0 etherbuffer(0x07)
;#Define T_enetpacketsrc1 etherbuffer(0x08)
;#Define T_enetpacketsrc2 etherbuffer(0x09)
;#Define T_enetpacketsrc3 etherbuffer(0x0A)
;#Define T_enetpacketsrc4 etherbuffer(0x0B)
;#Define T_enetpacketsrc5 etherbuffer(0x0C)
;Ethernet packet type
;#Define T_enetpackettype0 etherbuffer(0x0D)
;#Define T_enetpackettype1 etherbuffer(0x0E)
;ARP definitions
;#Define T_arp_hwtype1 etherbuffer(0x10)
;#Define T_arp_prttype1 etherbuffer(0x12)
;#Define T_arp_hwlen etherbuffer(0x13)
;#Define T_arp_prlen etherbuffer(0x14)
;#Define T_arp_op1 etherbuffer(0x16)
;ARP source ip address
;#Define T_arp_sipaddr0 etherbuffer(0x1D)
;#Define T_arp_sipaddr1 etherbuffer(0x1E)
;#Define T_arp_sipaddr2 etherbuffer(0x1F)
;#Define T_arp_sipaddr3 etherbuffer(0x20)
;ARP target IP address
;#Define T_arp_tipaddr0 etherbuffer(0x27)
;#Define T_arp_tipaddr1 etherbuffer(0x28)
;#Define T_arp_tipaddr2 etherbuffer(0x29)
;#Define T_arp_tipaddr3 etherbuffer(0x2A)
;IP header layout IP version and header length
;#Define T_ip_header_pointer0 0x0F
;#Define T_ip_header_pointer1 0x21
;IP version and hardware type
;#Define T_ip_vers_len etherbuffer(0x0F)
;#Define T_arp_hwtype0 etherbuffer(0x0F)
;ARP definitions
;#Define T_arp_prttype0 etherbuffer(0x11)
;#Define T_arp_op0 etherbuffer(0x15)
;ARP source mac address
;#Define T_arp_src_enetpacket0 etherbuffer(0x17)
;#Define T_arp_src_enetpacket1 etherbuffer(0x18)
;#Define T_arp_src_enetpacket2 etherbuffer(0x19)
;#Define T_arp_src_enetpacket3 etherbuffer(0x1A)
;#Define T_arp_src_enetpacket4 etherbuffer(0x1B)
;#Define T_arp_src_enetpacket5 etherbuffer(0x1C)
;ARP source mac address
;#Define T_arp_dest_enetpacket0 etherbuffer(0x21)
;#Define T_arp_dest_enetpacket1 etherbuffer(0x22)
;#Define T_arp_dest_enetpacket2 etherbuffer(0x23)
;#Define T_arp_dest_enetpacket3 etherbuffer(0x24)
;#Define T_arp_dest_enetpacket4 etherbuffer(0x25)
;#Define T_arp_dest_enetpacket5 etherbuffer(0x26)
;TOS
;#Define T_tos etherbuffer(0x10)
;Packet Buffer length
;#Define T_ip_pktlen0 etherbuffer(0x11)
;#Define T_ip_pktlen1 etherbuffer(0x12)
;TCP buffers size, flags, offsets and ttl
;#Define T_id0 etherbuffer(0x13)
;#Define T_id1 etherbuffer(0x14)
;#Define T_flags etherbuffer(0x15)
;#Define T_offset etherbuffer(0x16)
;#Define T_ttl etherbuffer(0x17)
;Protocol type (ICMP=1, TCP=6, UDP=11)
;#Define T_ip_proto etherbuffer(0x18)
;Header checksum
;#Define T_ip_hdr_cksum0_pointer 0x19
;#Define T_ip_hdr_cksum0 etherbuffer(0x19)
;#Define T_ip_hdr_cksum1 etherbuffer(0x1A)
;IP address of source
;#Define T_ip_srcaddr0 etherbuffer(0x1B)
;#Define T_ip_srcaddr1 etherbuffer(0x1C)
;#Define T_ip_srcaddr2 etherbuffer(0x1D)
;#Define T_ip_srcaddr3 etherbuffer(0x1E)
;IP address of destination
;#Define T_ip_destaddr0 etherbuffer(0x1F)
;#Define T_ip_destaddr1 etherbuffer(0x20)
;#Define T_ip_destaddr2 etherbuffer(0x21)
;#Define T_ip_destaddr3 etherbuffer(0x22)
;ICMP parameters
;#Define T_icmp_type etherbuffer(0x23)
;#Define T_icmp_code etherbuffer(0x24)
;#Define T_icmp_cksum0 etherbuffer(0x25)
;#Define T_icmp_cksum1 etherbuffer(0x26)
;TCP Source port
;#Define Tcp_srcporth etherbuffer(0x23)
;#Define Tcp_srcportl etherbuffer(0x24)
;TCP Destination port
;#Define Tcp_destporth etherbuffer(0x25)
;#Define Tcp_destportl etherbuffer(0x26)
;TCP Sequence number
;#Define Tcp_seqnum3 etherbuffer(0x27)
;#Define Tcp_seqnum2 etherbuffer(0x28)
;#Define Tcp_seqnum1 etherbuffer(0x29)
;#Define Tcp_seqnum0 etherbuffer(0x2A)
;TCP Acknowledge number
;#Define Tcp_acknum3 etherbuffer(0x2B)
;#Define Tcp_acknum2 etherbuffer(0x2C)
;#Define Tcp_acknum1 etherbuffer(0x2D)
;#Define Tcp_acknum0 etherbuffer(0x2E)
;TCP Headets, flags and checksum
;#Define Tcp_hdr etherbuffer(0x2F)
;#Define Tcp_flags etherbuffer(0x30)
;#Define Tcp_cksum0 etherbuffer(0x33)
;#Define Tcp_cksum1 etherbuffer(0x34)
;UDP source port
;#Define T_udp_srcport0 etherbuffer(0x23)
;#Define T_udp_srcport1 etherbuffer(0x24)
;UDP destination port
;#Define T_udp_destport0 etherbuffer(0x25)
;#Define T_udp_destport1 etherbuffer(0x26)
;UDP length
;#Define T_udp_len0 etherbuffer(0x27)
;#Define T_udp_len1 etherbuffer(0x28)
;UDP checksum
;#Define T_udp_chksum0 etherbuffer(0x29)
;#Define T_udp_chksum1 etherbuffer(0x2A)
;UDP Data pointer
;#Define T_udp_data_pointer 0x2B
;UDP Data Buffer
;#Define T_udp_data etherbuffer(0x2B)
;#Define T_udp_data0 etherbuffer(0x2B)
;#Define T_udp_data1 etherbuffer(0x2C)
;#Define T_udp_data2 etherbuffer(0x2D)
;#Define T_udp_data3 etherbuffer(0x2E)
;#Define T_udp_data4 etherbuffer(0x2F)
;#Define T_udp_data5 etherbuffer(0x30)
;#Define T_udp_data6 etherbuffer(0x31)
;#Define T_udp_data7 etherbuffer(0x32)
;#Define T_udp_data8 etherbuffer(0x33)
;#Define T_udp_data9 etherbuffer(0x34)
;#Define T_udp_data10 etherbuffer(0x35)
;#Define T_udp_data11 etherbuffer(0x36)
;#Define T_udp_data12 etherbuffer(0x37)
;#Define T_udp_data13 etherbuffer(0x38)
;#Define T_udp_data14 etherbuffer(0x39)
;#Define T_udp_data15 etherbuffer(0x3A)
;#Define T_udp_data16 etherbuffer(0x3B)
;#Define T_udp_data17 etherbuffer(0x3C)
;#Define T_udp_data18 etherbuffer(0x3D)
;#Define T_udp_data19 etherbuffer(0x3E)
;#Define T_udp_data20 etherbuffer(0x3F)
;#Define T_udp_data21 etherbuffer(0x40)
;#Define T_udp_data22 etherbuffer(0x41)
;#Define T_udp_data23 etherbuffer(0x42)
;#Define T_udp_data24 etherbuffer(0x43)
;#Define T_udp_data25 etherbuffer(0x44)
;#Define T_udp_data26 etherbuffer(0x45)
;#Define T_udp_data27 etherbuffer(0x46)
;#Define T_udp_data28 etherbuffer(0x47)
;#Define T_udp_data29 etherbuffer(0x48)
;#Define T_udp_data30 etherbuffer(0x49)
;#Define T_udp_data31 etherbuffer(0x4A)
;#Define T_udp_data32 etherbuffer(0x4B)
BASPROGRAMEND
  sleep
  goto  BASPROGRAMEND

;********************************************************************************

ENC28J60_REGDUMP
;dim ENC28j60_data as word alias I_checksum16_H, I_checksum16
;HSerPrintCRLF
  movlw 1
  movwf HSERPRINTCRLFCOUNT
  movlw 1
  movwf COMPORT
  pagesel HSERPRINTCRLF
  call  HSERPRINTCRLF
  pagesel $

;HSerPrint "Registerdump ENC28j60"
  movlw low StringTable15
  movwf SysPRINTDATAHandler
  movlw (high StringTable15) | 128
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;ENC28j60_data = ENC28j60_ReadReg( erevid )
  movlw 114
  movwf ADDR
  pagesel FN_ENC28J60_READREG
  call  FN_ENC28J60_READREG
  pagesel $
  movf  ENC28J60_READREG,W
  movwf ENC28J60_DATA
  clrf  ENC28J60_DATA_H
;HSerPrint " ENC Rev " + str( ENC28j60_data )
  movf  ENC28J60_DATA,W
  movwf SYSVALTEMP
  movf  ENC28J60_DATA_H,W
  movwf SYSVALTEMP_H
  pagesel FN_STR
  call  FN_STR
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR1L
  movlw high SYSSTRINGPARAM1
  movwf FSR1H
  clrf  SysStringLength
  movlw low StringTable16
  movwf SysStringA
  movlw (high StringTable16) & 127
  movwf SysStringA_H
  pagesel SysReadStringPart
  call  SysReadStringPart
  pagesel $
  movlw low STR
  movwf FSR0L
  movlw high STR
  movwf FSR0H
  pagesel SysCopyStringPart
  call  SysCopyStringPart
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR0L
  movlw high SYSSTRINGPARAM1
  movwf FSR0H
  movf  SysStringLength,W
  movwf INDF0
  movlw low SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler
  movlw high SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;HSerPrint " Build 037"
  movlw low StringTable17
  movwf SysPRINTDATAHandler
  movlw (high StringTable17) | 128
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;HSerPrintCRLF
  movlw 1
  movwf HSERPRINTCRLFCOUNT
  movlw 1
  movwf COMPORT
  pagesel HSERPRINTCRLF
  call  HSERPRINTCRLF
  pagesel $

;HSerPrintCRLF
  movlw 1
  movwf HSERPRINTCRLFCOUNT
  movlw 1
  movwf COMPORT
  pagesel HSERPRINTCRLF
  call  HSERPRINTCRLF
  pagesel $

;HSerPrint "Cntrl: ECON1 ECON2 ESTAT  EIR  EIE"
  movlw low StringTable18
  movwf SysPRINTDATAHandler
  movlw (high StringTable18) | 128
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;HSerPrintCRLF
  movlw 1
  movwf HSERPRINTCRLFCOUNT
  movlw 1
  movwf COMPORT
  pagesel HSERPRINTCRLF
  call  HSERPRINTCRLF
  pagesel $

;ENC28j60_data = ENC28j60_ReadReg( econ1)
  movlw 31
  movwf ADDR
  pagesel FN_ENC28J60_READREG
  call  FN_ENC28J60_READREG
  pagesel $
  movf  ENC28J60_READREG,W
  movwf ENC28J60_DATA
  clrf  ENC28J60_DATA_H
;HSerPrint "       " + Hex(ENC28j60_data)
  movf  ENC28J60_DATA,W
  movwf SYSVALTEMP
  pagesel FN_HEX
  call  FN_HEX
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR1L
  movlw high SYSSTRINGPARAM1
  movwf FSR1H
  clrf  SysStringLength
  movlw low StringTable19
  movwf SysStringA
  movlw (high StringTable19) & 127
  movwf SysStringA_H
  pagesel SysReadStringPart
  call  SysReadStringPart
  pagesel $
  movlw low HEX
  movwf FSR0L
  movlw high HEX
  movwf FSR0H
  pagesel SysCopyStringPart
  call  SysCopyStringPart
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR0L
  movlw high SYSSTRINGPARAM1
  movwf FSR0H
  movf  SysStringLength,W
  movwf INDF0
  movlw low SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler
  movlw high SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;ENC28j60_data = ENC28j60_ReadReg( econ2)
  movlw 30
  movwf ADDR
  pagesel FN_ENC28J60_READREG
  call  FN_ENC28J60_READREG
  pagesel $
  movf  ENC28J60_READREG,W
  movwf ENC28J60_DATA
  clrf  ENC28J60_DATA_H
;HSerPrint "    " + Hex(ENC28j60_data);
  movf  ENC28J60_DATA,W
  movwf SYSVALTEMP
  pagesel FN_HEX
  call  FN_HEX
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR1L
  movlw high SYSSTRINGPARAM1
  movwf FSR1H
  clrf  SysStringLength
  movlw low StringTable20
  movwf SysStringA
  movlw (high StringTable20) & 127
  movwf SysStringA_H
  pagesel SysReadStringPart
  call  SysReadStringPart
  pagesel $
  movlw low HEX
  movwf FSR0L
  movlw high HEX
  movwf FSR0H
  pagesel SysCopyStringPart
  call  SysCopyStringPart
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR0L
  movlw high SYSSTRINGPARAM1
  movwf FSR0H
  movf  SysStringLength,W
  movwf INDF0
  movlw low SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler
  movlw high SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;ENC28j60_data = ENC28j60_ReadReg( estat)
  movlw 29
  movwf ADDR
  pagesel FN_ENC28J60_READREG
  call  FN_ENC28J60_READREG
  pagesel $
  movf  ENC28J60_READREG,W
  movwf ENC28J60_DATA
  clrf  ENC28J60_DATA_H
;HSerPrint "    " + Hex(ENC28j60_data);
  movf  ENC28J60_DATA,W
  movwf SYSVALTEMP
  pagesel FN_HEX
  call  FN_HEX
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR1L
  movlw high SYSSTRINGPARAM1
  movwf FSR1H
  clrf  SysStringLength
  movlw low StringTable20
  movwf SysStringA
  movlw (high StringTable20) & 127
  movwf SysStringA_H
  pagesel SysReadStringPart
  call  SysReadStringPart
  pagesel $
  movlw low HEX
  movwf FSR0L
  movlw high HEX
  movwf FSR0H
  pagesel SysCopyStringPart
  call  SysCopyStringPart
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR0L
  movlw high SYSSTRINGPARAM1
  movwf FSR0H
  movf  SysStringLength,W
  movwf INDF0
  movlw low SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler
  movlw high SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;ENC28j60_data = ENC28j60_ReadReg (eir)
  movlw 28
  movwf ADDR
  pagesel FN_ENC28J60_READREG
  call  FN_ENC28J60_READREG
  pagesel $
  movf  ENC28J60_READREG,W
  movwf ENC28J60_DATA
  clrf  ENC28J60_DATA_H
;HSerPrint "     " + Hex(ENC28j60_data);
  movf  ENC28J60_DATA,W
  movwf SYSVALTEMP
  pagesel FN_HEX
  call  FN_HEX
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR1L
  movlw high SYSSTRINGPARAM1
  movwf FSR1H
  clrf  SysStringLength
  movlw low StringTable21
  movwf SysStringA
  movlw (high StringTable21) & 127
  movwf SysStringA_H
  pagesel SysReadStringPart
  call  SysReadStringPart
  pagesel $
  movlw low HEX
  movwf FSR0L
  movlw high HEX
  movwf FSR0H
  pagesel SysCopyStringPart
  call  SysCopyStringPart
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR0L
  movlw high SYSSTRINGPARAM1
  movwf FSR0H
  movf  SysStringLength,W
  movwf INDF0
  movlw low SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler
  movlw high SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;ENC28j60_data = ENC28j60_ReadReg( eie)
  movlw 27
  movwf ADDR
  pagesel FN_ENC28J60_READREG
  call  FN_ENC28J60_READREG
  pagesel $
  movf  ENC28J60_READREG,W
  movwf ENC28J60_DATA
  clrf  ENC28J60_DATA_H
;HSerPrint "   " + Hex(ENC28j60_data)
  movf  ENC28J60_DATA,W
  movwf SYSVALTEMP
  pagesel FN_HEX
  call  FN_HEX
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR1L
  movlw high SYSSTRINGPARAM1
  movwf FSR1H
  clrf  SysStringLength
  movlw low StringTable22
  movwf SysStringA
  movlw (high StringTable22) & 127
  movwf SysStringA_H
  pagesel SysReadStringPart
  call  SysReadStringPart
  pagesel $
  movlw low HEX
  movwf FSR0L
  movlw high HEX
  movwf FSR0H
  pagesel SysCopyStringPart
  call  SysCopyStringPart
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR0L
  movlw high SYSSTRINGPARAM1
  movwf FSR0H
  movf  SysStringLength,W
  movwf INDF0
  movlw low SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler
  movlw high SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;HSerPrintCRLF
  movlw 1
  movwf HSERPRINTCRLFCOUNT
  movlw 1
  movwf COMPORT
  pagesel HSERPRINTCRLF
  call  HSERPRINTCRLF
  pagesel $

;HSerPrint "MAC  : MACON1  MACON3  MACON4  MAC-Address"
  movlw low StringTable23
  movwf SysPRINTDATAHandler
  movlw (high StringTable23) | 128
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;HSerPrintCRLF
  movlw 1
  movwf HSERPRINTCRLFCOUNT
  movlw 1
  movwf COMPORT
  pagesel HSERPRINTCRLF
  call  HSERPRINTCRLF
  pagesel $

;ENC28j60_data = ENC28j60_ReadReg( macon1)
  movlw 192
  movwf ADDR
  pagesel FN_ENC28J60_READREG
  call  FN_ENC28J60_READREG
  pagesel $
  movf  ENC28J60_READREG,W
  movwf ENC28J60_DATA
  clrf  ENC28J60_DATA_H
;HSerPrint "       " + Hex(ENC28j60_data);
  movf  ENC28J60_DATA,W
  movwf SYSVALTEMP
  pagesel FN_HEX
  call  FN_HEX
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR1L
  movlw high SYSSTRINGPARAM1
  movwf FSR1H
  clrf  SysStringLength
  movlw low StringTable19
  movwf SysStringA
  movlw (high StringTable19) & 127
  movwf SysStringA_H
  pagesel SysReadStringPart
  call  SysReadStringPart
  pagesel $
  movlw low HEX
  movwf FSR0L
  movlw high HEX
  movwf FSR0H
  pagesel SysCopyStringPart
  call  SysCopyStringPart
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR0L
  movlw high SYSSTRINGPARAM1
  movwf FSR0H
  movf  SysStringLength,W
  movwf INDF0
  movlw low SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler
  movlw high SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;ENC28j60_data = ENC28j60_ReadReg( macon2)
;HSerPrint "      " + Hex(ENC28j60_data);
;ENC28j60_data = ENC28j60_ReadReg( macon3)
  movlw 194
  movwf ADDR
  pagesel FN_ENC28J60_READREG
  call  FN_ENC28J60_READREG
  pagesel $
  movf  ENC28J60_READREG,W
  movwf ENC28J60_DATA
  clrf  ENC28J60_DATA_H
;HSerPrint "      " + Hex(ENC28j60_data);
  movf  ENC28J60_DATA,W
  movwf SYSVALTEMP
  pagesel FN_HEX
  call  FN_HEX
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR1L
  movlw high SYSSTRINGPARAM1
  movwf FSR1H
  clrf  SysStringLength
  movlw low StringTable24
  movwf SysStringA
  movlw (high StringTable24) & 127
  movwf SysStringA_H
  pagesel SysReadStringPart
  call  SysReadStringPart
  pagesel $
  movlw low HEX
  movwf FSR0L
  movlw high HEX
  movwf FSR0H
  pagesel SysCopyStringPart
  call  SysCopyStringPart
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR0L
  movlw high SYSSTRINGPARAM1
  movwf FSR0H
  movf  SysStringLength,W
  movwf INDF0
  movlw low SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler
  movlw high SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;ENC28j60_data = ENC28j60_ReadReg( macon4)
  movlw 195
  movwf ADDR
  pagesel FN_ENC28J60_READREG
  call  FN_ENC28J60_READREG
  pagesel $
  movf  ENC28J60_READREG,W
  movwf ENC28J60_DATA
  clrf  ENC28J60_DATA_H
;HSerPrint "      " + Hex(ENC28j60_data);
  movf  ENC28J60_DATA,W
  movwf SYSVALTEMP
  pagesel FN_HEX
  call  FN_HEX
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR1L
  movlw high SYSSTRINGPARAM1
  movwf FSR1H
  clrf  SysStringLength
  movlw low StringTable24
  movwf SysStringA
  movlw (high StringTable24) & 127
  movwf SysStringA_H
  pagesel SysReadStringPart
  call  SysReadStringPart
  pagesel $
  movlw low HEX
  movwf FSR0L
  movlw high HEX
  movwf FSR0H
  pagesel SysCopyStringPart
  call  SysCopyStringPart
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR0L
  movlw high SYSSTRINGPARAM1
  movwf FSR0H
  movf  SysStringLength,W
  movwf INDF0
  movlw low SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler
  movlw high SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;ENC28j60_data = ENC28j60_ReadReg( maadr5)
  movlw 228
  movwf ADDR
  pagesel FN_ENC28J60_READREG
  call  FN_ENC28J60_READREG
  pagesel $
  movf  ENC28J60_READREG,W
  movwf ENC28J60_DATA
  clrf  ENC28J60_DATA_H
;HSerPrint "      " + Hex(ENC28j60_data);
  movf  ENC28J60_DATA,W
  movwf SYSVALTEMP
  pagesel FN_HEX
  call  FN_HEX
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR1L
  movlw high SYSSTRINGPARAM1
  movwf FSR1H
  clrf  SysStringLength
  movlw low StringTable24
  movwf SysStringA
  movlw (high StringTable24) & 127
  movwf SysStringA_H
  pagesel SysReadStringPart
  call  SysReadStringPart
  pagesel $
  movlw low HEX
  movwf FSR0L
  movlw high HEX
  movwf FSR0H
  pagesel SysCopyStringPart
  call  SysCopyStringPart
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR0L
  movlw high SYSSTRINGPARAM1
  movwf FSR0H
  movf  SysStringLength,W
  movwf INDF0
  movlw low SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler
  movlw high SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;ENC28j60_data = ENC28j60_ReadReg( maadr4)
  movlw 229
  movwf ADDR
  pagesel FN_ENC28J60_READREG
  call  FN_ENC28J60_READREG
  pagesel $
  movf  ENC28J60_READREG,W
  movwf ENC28J60_DATA
  clrf  ENC28J60_DATA_H
;HSerPrint "." + Hex(ENC28j60_data);
  movf  ENC28J60_DATA,W
  movwf SYSVALTEMP
  pagesel FN_HEX
  call  FN_HEX
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR1L
  movlw high SYSSTRINGPARAM1
  movwf FSR1H
  clrf  SysStringLength
  movlw low StringTable25
  movwf SysStringA
  movlw (high StringTable25) & 127
  movwf SysStringA_H
  pagesel SysReadStringPart
  call  SysReadStringPart
  pagesel $
  movlw low HEX
  movwf FSR0L
  movlw high HEX
  movwf FSR0H
  pagesel SysCopyStringPart
  call  SysCopyStringPart
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR0L
  movlw high SYSSTRINGPARAM1
  movwf FSR0H
  movf  SysStringLength,W
  movwf INDF0
  movlw low SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler
  movlw high SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;ENC28j60_data = ENC28j60_ReadReg( maadr3)
  movlw 226
  movwf ADDR
  pagesel FN_ENC28J60_READREG
  call  FN_ENC28J60_READREG
  pagesel $
  movf  ENC28J60_READREG,W
  movwf ENC28J60_DATA
  clrf  ENC28J60_DATA_H
;HSerPrint "." + Hex(ENC28j60_data);
  movf  ENC28J60_DATA,W
  movwf SYSVALTEMP
  pagesel FN_HEX
  call  FN_HEX
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR1L
  movlw high SYSSTRINGPARAM1
  movwf FSR1H
  clrf  SysStringLength
  movlw low StringTable25
  movwf SysStringA
  movlw (high StringTable25) & 127
  movwf SysStringA_H
  pagesel SysReadStringPart
  call  SysReadStringPart
  pagesel $
  movlw low HEX
  movwf FSR0L
  movlw high HEX
  movwf FSR0H
  pagesel SysCopyStringPart
  call  SysCopyStringPart
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR0L
  movlw high SYSSTRINGPARAM1
  movwf FSR0H
  movf  SysStringLength,W
  movwf INDF0
  movlw low SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler
  movlw high SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;ENC28j60_data = ENC28j60_ReadReg( maadr2)
  movlw 227
  movwf ADDR
  pagesel FN_ENC28J60_READREG
  call  FN_ENC28J60_READREG
  pagesel $
  movf  ENC28J60_READREG,W
  movwf ENC28J60_DATA
  clrf  ENC28J60_DATA_H
;HSerPrint "." + Hex(ENC28j60_data);
  movf  ENC28J60_DATA,W
  movwf SYSVALTEMP
  pagesel FN_HEX
  call  FN_HEX
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR1L
  movlw high SYSSTRINGPARAM1
  movwf FSR1H
  clrf  SysStringLength
  movlw low StringTable25
  movwf SysStringA
  movlw (high StringTable25) & 127
  movwf SysStringA_H
  pagesel SysReadStringPart
  call  SysReadStringPart
  pagesel $
  movlw low HEX
  movwf FSR0L
  movlw high HEX
  movwf FSR0H
  pagesel SysCopyStringPart
  call  SysCopyStringPart
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR0L
  movlw high SYSSTRINGPARAM1
  movwf FSR0H
  movf  SysStringLength,W
  movwf INDF0
  movlw low SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler
  movlw high SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;ENC28j60_data = ENC28j60_ReadReg( maadr1)
  movlw 224
  movwf ADDR
  pagesel FN_ENC28J60_READREG
  call  FN_ENC28J60_READREG
  pagesel $
  movf  ENC28J60_READREG,W
  movwf ENC28J60_DATA
  clrf  ENC28J60_DATA_H
;HSerPrint "." + Hex(ENC28j60_data);
  movf  ENC28J60_DATA,W
  movwf SYSVALTEMP
  pagesel FN_HEX
  call  FN_HEX
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR1L
  movlw high SYSSTRINGPARAM1
  movwf FSR1H
  clrf  SysStringLength
  movlw low StringTable25
  movwf SysStringA
  movlw (high StringTable25) & 127
  movwf SysStringA_H
  pagesel SysReadStringPart
  call  SysReadStringPart
  pagesel $
  movlw low HEX
  movwf FSR0L
  movlw high HEX
  movwf FSR0H
  pagesel SysCopyStringPart
  call  SysCopyStringPart
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR0L
  movlw high SYSSTRINGPARAM1
  movwf FSR0H
  movf  SysStringLength,W
  movwf INDF0
  movlw low SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler
  movlw high SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;ENC28j60_data = ENC28j60_ReadReg( maadr0)
  movlw 225
  movwf ADDR
  pagesel FN_ENC28J60_READREG
  call  FN_ENC28J60_READREG
  pagesel $
  movf  ENC28J60_READREG,W
  movwf ENC28J60_DATA
  clrf  ENC28J60_DATA_H
;HSerPrint "." + Hex(ENC28j60_data)
  movf  ENC28J60_DATA,W
  movwf SYSVALTEMP
  pagesel FN_HEX
  call  FN_HEX
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR1L
  movlw high SYSSTRINGPARAM1
  movwf FSR1H
  clrf  SysStringLength
  movlw low StringTable25
  movwf SysStringA
  movlw (high StringTable25) & 127
  movwf SysStringA_H
  pagesel SysReadStringPart
  call  SysReadStringPart
  pagesel $
  movlw low HEX
  movwf FSR0L
  movlw high HEX
  movwf FSR0H
  pagesel SysCopyStringPart
  call  SysCopyStringPart
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR0L
  movlw high SYSSTRINGPARAM1
  movwf FSR0H
  movf  SysStringLength,W
  movwf INDF0
  movlw low SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler
  movlw high SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;HSerPrintCRLF
  movlw 1
  movwf HSERPRINTCRLFCOUNT
  movlw 1
  movwf COMPORT
  pagesel HSERPRINTCRLF
  call  HSERPRINTCRLF
  pagesel $

;HSerPrint "Rx   : ERXST  ERXND  ERXWRPT ERXRDPT ERXFCON EPKTCNT MAMXFL"
  movlw low StringTable26
  movwf SysPRINTDATAHandler
  movlw (high StringTable26) | 128
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;HSerPrintCRLF
  movlw 1
  movwf HSERPRINTCRLFCOUNT
  movlw 1
  movwf COMPORT
  pagesel HSERPRINTCRLF
  call  HSERPRINTCRLF
  pagesel $

;ENC28j60_data = ENC28j60_ReadReg(erxsth)
  movlw 9
  movwf ADDR
  pagesel FN_ENC28J60_READREG
  call  FN_ENC28J60_READREG
  pagesel $
  movf  ENC28J60_READREG,W
  movwf ENC28J60_DATA
  clrf  ENC28J60_DATA_H
;HSerPrint "       " + Hex(ENC28j60_data);
  movf  ENC28J60_DATA,W
  movwf SYSVALTEMP
  pagesel FN_HEX
  call  FN_HEX
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR1L
  movlw high SYSSTRINGPARAM1
  movwf FSR1H
  clrf  SysStringLength
  movlw low StringTable19
  movwf SysStringA
  movlw (high StringTable19) & 127
  movwf SysStringA_H
  pagesel SysReadStringPart
  call  SysReadStringPart
  pagesel $
  movlw low HEX
  movwf FSR0L
  movlw high HEX
  movwf FSR0H
  pagesel SysCopyStringPart
  call  SysCopyStringPart
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR0L
  movlw high SYSSTRINGPARAM1
  movwf FSR0H
  movf  SysStringLength,W
  movwf INDF0
  movlw low SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler
  movlw high SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;ENC28j60_data = ENC28j60_ReadReg(erxstl)
  movlw 8
  movwf ADDR
  pagesel FN_ENC28J60_READREG
  call  FN_ENC28J60_READREG
  pagesel $
  movf  ENC28J60_READREG,W
  movwf ENC28J60_DATA
  clrf  ENC28J60_DATA_H
;HSerPrint Hex(ENC28j60_data);
  movf  ENC28J60_DATA,W
  movwf SYSVALTEMP
  pagesel FN_HEX
  call  FN_HEX
  pagesel $
  movlw low HEX
  movwf SysPRINTDATAHandler
  movlw high HEX
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;ENC28j60_data = ENC28j60_ReadReg(erxndh)
  movlw 11
  movwf ADDR
  pagesel FN_ENC28J60_READREG
  call  FN_ENC28J60_READREG
  pagesel $
  movf  ENC28J60_READREG,W
  movwf ENC28J60_DATA
  clrf  ENC28J60_DATA_H
;HSerPrint "   " + Hex(ENC28j60_data);
  movf  ENC28J60_DATA,W
  movwf SYSVALTEMP
  pagesel FN_HEX
  call  FN_HEX
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR1L
  movlw high SYSSTRINGPARAM1
  movwf FSR1H
  clrf  SysStringLength
  movlw low StringTable22
  movwf SysStringA
  movlw (high StringTable22) & 127
  movwf SysStringA_H
  pagesel SysReadStringPart
  call  SysReadStringPart
  pagesel $
  movlw low HEX
  movwf FSR0L
  movlw high HEX
  movwf FSR0H
  pagesel SysCopyStringPart
  call  SysCopyStringPart
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR0L
  movlw high SYSSTRINGPARAM1
  movwf FSR0H
  movf  SysStringLength,W
  movwf INDF0
  movlw low SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler
  movlw high SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;ENC28j60_data = ENC28j60_ReadReg(erxndl)
  movlw 10
  movwf ADDR
  pagesel FN_ENC28J60_READREG
  call  FN_ENC28J60_READREG
  pagesel $
  movf  ENC28J60_READREG,W
  movwf ENC28J60_DATA
  clrf  ENC28J60_DATA_H
;HSerPrint Hex(ENC28j60_data);
  movf  ENC28J60_DATA,W
  movwf SYSVALTEMP
  pagesel FN_HEX
  call  FN_HEX
  pagesel $
  movlw low HEX
  movwf SysPRINTDATAHandler
  movlw high HEX
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;ENC28j60_data_h = ENC28j60_ReadReg(erxwrpth)
  movlw 15
  movwf ADDR
  pagesel FN_ENC28J60_READREG
  call  FN_ENC28J60_READREG
  pagesel $
  movf  ENC28J60_READREG,W
  movwf ENC28J60_DATA_H
;HSerPrint "   " + Hex(ENC28j60_data_h);
  movwf SYSVALTEMP
  pagesel FN_HEX
  call  FN_HEX
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR1L
  movlw high SYSSTRINGPARAM1
  movwf FSR1H
  clrf  SysStringLength
  movlw low StringTable22
  movwf SysStringA
  movlw (high StringTable22) & 127
  movwf SysStringA_H
  pagesel SysReadStringPart
  call  SysReadStringPart
  pagesel $
  movlw low HEX
  movwf FSR0L
  movlw high HEX
  movwf FSR0H
  pagesel SysCopyStringPart
  call  SysCopyStringPart
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR0L
  movlw high SYSSTRINGPARAM1
  movwf FSR0H
  movf  SysStringLength,W
  movwf INDF0
  movlw low SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler
  movlw high SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;ENC28j60_data = ENC28j60_ReadReg(erxwrptl)
  movlw 14
  movwf ADDR
  pagesel FN_ENC28J60_READREG
  call  FN_ENC28J60_READREG
  pagesel $
  movf  ENC28J60_READREG,W
  movwf ENC28J60_DATA
  clrf  ENC28J60_DATA_H
;HSerPrint Hex(ENC28j60_data);
  movf  ENC28J60_DATA,W
  movwf SYSVALTEMP
  pagesel FN_HEX
  call  FN_HEX
  pagesel $
  movlw low HEX
  movwf SysPRINTDATAHandler
  movlw high HEX
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;ENC28j60_data_h = ENC28j60_ReadReg(erxrdpth)
  movlw 13
  movwf ADDR
  pagesel FN_ENC28J60_READREG
  call  FN_ENC28J60_READREG
  pagesel $
  movf  ENC28J60_READREG,W
  movwf ENC28J60_DATA_H
;HSerPrint "    " + Hex(ENC28j60_data_h);
  movwf SYSVALTEMP
  pagesel FN_HEX
  call  FN_HEX
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR1L
  movlw high SYSSTRINGPARAM1
  movwf FSR1H
  clrf  SysStringLength
  movlw low StringTable20
  movwf SysStringA
  movlw (high StringTable20) & 127
  movwf SysStringA_H
  pagesel SysReadStringPart
  call  SysReadStringPart
  pagesel $
  movlw low HEX
  movwf FSR0L
  movlw high HEX
  movwf FSR0H
  pagesel SysCopyStringPart
  call  SysCopyStringPart
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR0L
  movlw high SYSSTRINGPARAM1
  movwf FSR0H
  movf  SysStringLength,W
  movwf INDF0
  movlw low SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler
  movlw high SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;ENC28j60_data = ENC28j60_ReadReg(erxrdptl)
  movlw 12
  movwf ADDR
  pagesel FN_ENC28J60_READREG
  call  FN_ENC28J60_READREG
  pagesel $
  movf  ENC28J60_READREG,W
  movwf ENC28J60_DATA
  clrf  ENC28J60_DATA_H
;HSerPrint Hex(ENC28j60_data);
  movf  ENC28J60_DATA,W
  movwf SYSVALTEMP
  pagesel FN_HEX
  call  FN_HEX
  pagesel $
  movlw low HEX
  movwf SysPRINTDATAHandler
  movlw high HEX
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;ENC28j60_data = ENC28j60_ReadReg(erxfcon)
  movlw 56
  movwf ADDR
  pagesel FN_ENC28J60_READREG
  call  FN_ENC28J60_READREG
  pagesel $
  movf  ENC28J60_READREG,W
  movwf ENC28J60_DATA
  clrf  ENC28J60_DATA_H
;HSerPrint "    " + Hex(ENC28j60_data);
  movf  ENC28J60_DATA,W
  movwf SYSVALTEMP
  pagesel FN_HEX
  call  FN_HEX
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR1L
  movlw high SYSSTRINGPARAM1
  movwf FSR1H
  clrf  SysStringLength
  movlw low StringTable20
  movwf SysStringA
  movlw (high StringTable20) & 127
  movwf SysStringA_H
  pagesel SysReadStringPart
  call  SysReadStringPart
  pagesel $
  movlw low HEX
  movwf FSR0L
  movlw high HEX
  movwf FSR0H
  pagesel SysCopyStringPart
  call  SysCopyStringPart
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR0L
  movlw high SYSSTRINGPARAM1
  movwf FSR0H
  movf  SysStringLength,W
  movwf INDF0
  movlw low SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler
  movlw high SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;ENC28j60_data = ENC28j60_ReadReg(epktcnt)
  movlw 57
  movwf ADDR
  pagesel FN_ENC28J60_READREG
  call  FN_ENC28J60_READREG
  pagesel $
  movf  ENC28J60_READREG,W
  movwf ENC28J60_DATA
  clrf  ENC28J60_DATA_H
;HSerPrint "      " + Hex(ENC28j60_data);
  movf  ENC28J60_DATA,W
  movwf SYSVALTEMP
  pagesel FN_HEX
  call  FN_HEX
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR1L
  movlw high SYSSTRINGPARAM1
  movwf FSR1H
  clrf  SysStringLength
  movlw low StringTable24
  movwf SysStringA
  movlw (high StringTable24) & 127
  movwf SysStringA_H
  pagesel SysReadStringPart
  call  SysReadStringPart
  pagesel $
  movlw low HEX
  movwf FSR0L
  movlw high HEX
  movwf FSR0H
  pagesel SysCopyStringPart
  call  SysCopyStringPart
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR0L
  movlw high SYSSTRINGPARAM1
  movwf FSR0H
  movf  SysStringLength,W
  movwf INDF0
  movlw low SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler
  movlw high SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;ENC28j60_data = ENC28j60_ReadReg(mamxflh)
  movlw 203
  movwf ADDR
  pagesel FN_ENC28J60_READREG
  call  FN_ENC28J60_READREG
  pagesel $
  movf  ENC28J60_READREG,W
  movwf ENC28J60_DATA
  clrf  ENC28J60_DATA_H
;HSerPrint "      " + Hex(ENC28j60_data);
  movf  ENC28J60_DATA,W
  movwf SYSVALTEMP
  pagesel FN_HEX
  call  FN_HEX
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR1L
  movlw high SYSSTRINGPARAM1
  movwf FSR1H
  clrf  SysStringLength
  movlw low StringTable24
  movwf SysStringA
  movlw (high StringTable24) & 127
  movwf SysStringA_H
  pagesel SysReadStringPart
  call  SysReadStringPart
  pagesel $
  movlw low HEX
  movwf FSR0L
  movlw high HEX
  movwf FSR0H
  pagesel SysCopyStringPart
  call  SysCopyStringPart
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR0L
  movlw high SYSSTRINGPARAM1
  movwf FSR0H
  movf  SysStringLength,W
  movwf INDF0
  movlw low SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler
  movlw high SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;ENC28j60_data = ENC28j60_ReadReg(mamxfll)
  movlw 202
  movwf ADDR
  pagesel FN_ENC28J60_READREG
  call  FN_ENC28J60_READREG
  pagesel $
  movf  ENC28J60_READREG,W
  movwf ENC28J60_DATA
  clrf  ENC28J60_DATA_H
;HSerPrint Hex(ENC28j60_data)
  movf  ENC28J60_DATA,W
  movwf SYSVALTEMP
  pagesel FN_HEX
  call  FN_HEX
  pagesel $
  movlw low HEX
  movwf SysPRINTDATAHandler
  movlw high HEX
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;HSerPrintCRLF
  movlw 1
  movwf HSERPRINTCRLFCOUNT
  movlw 1
  movwf COMPORT
  pagesel HSERPRINTCRLF
  call  HSERPRINTCRLF
  pagesel $

;HSerPrint "Tx   : ETXST  ETXND  EWRPT  MACLCON1 MACLCON2"
  movlw low StringTable27
  movwf SysPRINTDATAHandler
  movlw (high StringTable27) | 128
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;HSerPrintCRLF
  movlw 1
  movwf HSERPRINTCRLFCOUNT
  movlw 1
  movwf COMPORT
  pagesel HSERPRINTCRLF
  call  HSERPRINTCRLF
  pagesel $

;ENC28j60_data = ENC28j60_ReadReg(etxsth)
  movlw 5
  movwf ADDR
  pagesel FN_ENC28J60_READREG
  call  FN_ENC28J60_READREG
  pagesel $
  movf  ENC28J60_READREG,W
  movwf ENC28J60_DATA
  clrf  ENC28J60_DATA_H
;HSerPrint "       " + Hex(ENC28j60_data);
  movf  ENC28J60_DATA,W
  movwf SYSVALTEMP
  pagesel FN_HEX
  call  FN_HEX
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR1L
  movlw high SYSSTRINGPARAM1
  movwf FSR1H
  clrf  SysStringLength
  movlw low StringTable19
  movwf SysStringA
  movlw (high StringTable19) & 127
  movwf SysStringA_H
  pagesel SysReadStringPart
  call  SysReadStringPart
  pagesel $
  movlw low HEX
  movwf FSR0L
  movlw high HEX
  movwf FSR0H
  pagesel SysCopyStringPart
  call  SysCopyStringPart
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR0L
  movlw high SYSSTRINGPARAM1
  movwf FSR0H
  movf  SysStringLength,W
  movwf INDF0
  movlw low SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler
  movlw high SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;ENC28j60_data = ENC28j60_ReadReg(etxstl)
  movlw 4
  movwf ADDR
  pagesel FN_ENC28J60_READREG
  call  FN_ENC28J60_READREG
  pagesel $
  movf  ENC28J60_READREG,W
  movwf ENC28J60_DATA
  clrf  ENC28J60_DATA_H
;HSerPrint Hex(ENC28j60_data);
  movf  ENC28J60_DATA,W
  movwf SYSVALTEMP
  pagesel FN_HEX
  call  FN_HEX
  pagesel $
  movlw low HEX
  movwf SysPRINTDATAHandler
  movlw high HEX
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;ENC28j60_data = ENC28j60_ReadReg(etxndh)
  movlw 7
  movwf ADDR
  pagesel FN_ENC28J60_READREG
  call  FN_ENC28J60_READREG
  pagesel $
  movf  ENC28J60_READREG,W
  movwf ENC28J60_DATA
  clrf  ENC28J60_DATA_H
;HSerPrint "   " + Hex(ENC28j60_data);
  movf  ENC28J60_DATA,W
  movwf SYSVALTEMP
  pagesel FN_HEX
  call  FN_HEX
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR1L
  movlw high SYSSTRINGPARAM1
  movwf FSR1H
  clrf  SysStringLength
  movlw low StringTable22
  movwf SysStringA
  movlw (high StringTable22) & 127
  movwf SysStringA_H
  pagesel SysReadStringPart
  call  SysReadStringPart
  pagesel $
  movlw low HEX
  movwf FSR0L
  movlw high HEX
  movwf FSR0H
  pagesel SysCopyStringPart
  call  SysCopyStringPart
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR0L
  movlw high SYSSTRINGPARAM1
  movwf FSR0H
  movf  SysStringLength,W
  movwf INDF0
  movlw low SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler
  movlw high SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;ENC28j60_data = ENC28j60_ReadReg(etxndl)
  movlw 6
  movwf ADDR
  pagesel FN_ENC28J60_READREG
  call  FN_ENC28J60_READREG
  pagesel $
  movf  ENC28J60_READREG,W
  movwf ENC28J60_DATA
  clrf  ENC28J60_DATA_H
;HSerPrint Hex(ENC28j60_data);
  movf  ENC28J60_DATA,W
  movwf SYSVALTEMP
  pagesel FN_HEX
  call  FN_HEX
  pagesel $
  movlw low HEX
  movwf SysPRINTDATAHandler
  movlw high HEX
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;ENC28j60_data = ENC28j60_ReadReg(EWRPTH)
  movlw 3
  movwf ADDR
  pagesel FN_ENC28J60_READREG
  call  FN_ENC28J60_READREG
  pagesel $
  movf  ENC28J60_READREG,W
  movwf ENC28J60_DATA
  clrf  ENC28J60_DATA_H
;HSerPrint "   " +  Hex(ENC28j60_data);
  movf  ENC28J60_DATA,W
  movwf SYSVALTEMP
  pagesel FN_HEX
  call  FN_HEX
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR1L
  movlw high SYSSTRINGPARAM1
  movwf FSR1H
  clrf  SysStringLength
  movlw low StringTable22
  movwf SysStringA
  movlw (high StringTable22) & 127
  movwf SysStringA_H
  pagesel SysReadStringPart
  call  SysReadStringPart
  pagesel $
  movlw low HEX
  movwf FSR0L
  movlw high HEX
  movwf FSR0H
  pagesel SysCopyStringPart
  call  SysCopyStringPart
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR0L
  movlw high SYSSTRINGPARAM1
  movwf FSR0H
  movf  SysStringLength,W
  movwf INDF0
  movlw low SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler
  movlw high SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;ENC28j60_data = ENC28j60_ReadReg(EWRPTl)
  movlw 2
  movwf ADDR
  pagesel FN_ENC28J60_READREG
  call  FN_ENC28J60_READREG
  pagesel $
  movf  ENC28J60_READREG,W
  movwf ENC28J60_DATA
  clrf  ENC28J60_DATA_H
;HSerPrint Hex(ENC28j60_data);
  movf  ENC28J60_DATA,W
  movwf SYSVALTEMP
  pagesel FN_HEX
  call  FN_HEX
  pagesel $
  movlw low HEX
  movwf SysPRINTDATAHandler
  movlw high HEX
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;ENC28j60_data = ENC28j60_ReadReg(maclcon1)
  movlw 200
  movwf ADDR
  pagesel FN_ENC28J60_READREG
  call  FN_ENC28J60_READREG
  pagesel $
  movf  ENC28J60_READREG,W
  movwf ENC28J60_DATA
  clrf  ENC28J60_DATA_H
;HSerPrint "   " + Hex(ENC28j60_data);
  movf  ENC28J60_DATA,W
  movwf SYSVALTEMP
  pagesel FN_HEX
  call  FN_HEX
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR1L
  movlw high SYSSTRINGPARAM1
  movwf FSR1H
  clrf  SysStringLength
  movlw low StringTable22
  movwf SysStringA
  movlw (high StringTable22) & 127
  movwf SysStringA_H
  pagesel SysReadStringPart
  call  SysReadStringPart
  pagesel $
  movlw low HEX
  movwf FSR0L
  movlw high HEX
  movwf FSR0H
  pagesel SysCopyStringPart
  call  SysCopyStringPart
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR0L
  movlw high SYSSTRINGPARAM1
  movwf FSR0H
  movf  SysStringLength,W
  movwf INDF0
  movlw low SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler
  movlw high SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;ENC28j60_data = ENC28j60_ReadReg(maclcon2)
  movlw 201
  movwf ADDR
  pagesel FN_ENC28J60_READREG
  call  FN_ENC28J60_READREG
  pagesel $
  movf  ENC28J60_READREG,W
  movwf ENC28J60_DATA
  clrf  ENC28J60_DATA_H
;HSerPrint "       " + Hex(ENC28j60_data);
  movf  ENC28J60_DATA,W
  movwf SYSVALTEMP
  pagesel FN_HEX
  call  FN_HEX
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR1L
  movlw high SYSSTRINGPARAM1
  movwf FSR1H
  clrf  SysStringLength
  movlw low StringTable19
  movwf SysStringA
  movlw (high StringTable19) & 127
  movwf SysStringA_H
  pagesel SysReadStringPart
  call  SysReadStringPart
  pagesel $
  movlw low HEX
  movwf FSR0L
  movlw high HEX
  movwf FSR0H
  pagesel SysCopyStringPart
  call  SysCopyStringPart
  pagesel $
  movlw low SYSSTRINGPARAM1
  movwf FSR0L
  movlw high SYSSTRINGPARAM1
  movwf FSR0H
  movf  SysStringLength,W
  movwf INDF0
  movlw low SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler
  movlw high SYSSTRINGPARAM1
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;Capability is not valid in all devices
;ENC28j60_data = ENC28j60_ReadReg(maphsup)
;HSerPrint "       " + Hex(ENC28j60_data)
;HSerPrintCRLF 2
  movlw 2
  movwf HSERPRINTCRLFCOUNT
  movlw 1
  movwf COMPORT
  pagesel HSERPRINTCRLF
  call  HSERPRINTCRLF
  pagesel $

  return

;********************************************************************************

ENC28J60_WRITEPHYREG
;HSerPrint 1
  movlw 1
  movwf SERPRINTVAL
  movlw 1
  movwf COMPORT
  pagesel HSERPRINT236
  call  HSERPRINT236
  pagesel $

;WAIT 1 S
  movlw 1
  movwf SysWaitTempS
  pagesel Delay_S
  call  Delay_S
  pagesel $
;HSerPrint "("
  movlw low StringTable13
  movwf SysPRINTDATAHandler
  movlw (high StringTable13) | 128
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;HSerPrint hex(MISTAT)
  movlw 234
  movwf SYSVALTEMP
  pagesel FN_HEX
  call  FN_HEX
  pagesel $
  movlw low HEX
  movwf SysPRINTDATAHandler
  movlw high HEX
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;HSerPrint ")"
  movlw low StringTable14
  movwf SysPRINTDATAHandler
  movlw (high StringTable14) | 128
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;ddebug =1
  movlw 1
  movwf DDEBUG
;while ((ENC28j60_ReadReg( MISTAT ) & MISTAT_BUSY ) = MISTAT_BUSY )
SysDoLoop_S3
  movlw 234
  movwf ADDR
  pagesel FN_ENC28J60_READREG
  call  FN_ENC28J60_READREG
  pagesel $
;HSerPrint 2
  movlw 2
  movwf SERPRINTVAL
  movlw 1
  movwf COMPORT
  pagesel HSERPRINT236
  call  HSERPRINT236
  pagesel $

;ENC28j60_writeReg( MIREGADR, PhyRegaddr )
  movlw 212
  movwf ADDR
  movf  PHYREGADDR,W
  movwf ENC_OUTBYTE
  pagesel ENC28J60_WRITEREG
  call  ENC28J60_WRITEREG
  pagesel $

;HSerPrint 3
  movlw 3
  movwf SERPRINTVAL
  movlw 1
  movwf COMPORT
  pagesel HSERPRINT236
  call  HSERPRINT236
  pagesel $

;ENC28j60_writeReg( MIWRL, ENC_Outbyte1 )
  movlw 214
  movwf ADDR
  movf  ENC_OUTBYTE1,W
  movwf ENC_OUTBYTE
  pagesel ENC28J60_WRITEREG
  call  ENC28J60_WRITEREG
  pagesel $

;ENC28j60_writeReg( MIWRH, ENC_Outbyte2 )
  movlw 215
  movwf ADDR
  movf  ENC_OUTBYTE2,W
  movwf ENC_OUTBYTE
  pagesel ENC28J60_WRITEREG
  call  ENC28J60_WRITEREG
  pagesel $

;HSerPrint 98
  movlw 98
  movwf SERPRINTVAL
  movlw 1
  movwf COMPORT
  pagesel HSERPRINT236
  call  HSERPRINT236
  pagesel $

;HSerPrintCRLF
  movlw 1
  movwf HSERPRINTCRLFCOUNT
  movlw 1
  movwf COMPORT
  pagesel HSERPRINTCRLF
  call  HSERPRINTCRLF
  pagesel $

;HSerPrint "("
  movlw low StringTable13
  movwf SysPRINTDATAHandler
  movlw (high StringTable13) | 128
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;HSerPrint hex(MISTAT)
  movlw 234
  movwf SYSVALTEMP
  pagesel FN_HEX
  call  FN_HEX
  pagesel $
  movlw low HEX
  movwf SysPRINTDATAHandler
  movlw high HEX
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;HSerPrint ")"
  movlw low StringTable14
  movwf SysPRINTDATAHandler
  movlw (high StringTable14) | 128
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  call  HSERPRINT235

;wait while ((ENC28j60_ReadReg( MISTAT ) & MISTAT_BUSY ) = MISTAT_BUSY )
SysWaitLoop3
  movlw 234
  movwf ADDR
  pagesel FN_ENC28J60_READREG
  call  FN_ENC28J60_READREG
  pagesel $
  movlw 1
  andwf ENC28J60_READREG,W
  movwf SysTemp1
  movwf SysBYTETempA
  movlw 1
  movwf SysBYTETempB
  pagesel SysCompEqual
  call  SysCompEqual
  pagesel $
  btfsc SysByteTempX,0
  goto  SysWaitLoop3
;HSerPrint 99
  movlw 99
  movwf SERPRINTVAL
  movlw 1
  movwf COMPORT
  pagesel HSERPRINT236
  call  HSERPRINT236
  pagesel $

  return

;********************************************************************************

ETHERPARAMETERS
;macaddr =   0x00, 0x00, 0x00, 0x00, 0x00, 0x00
  movlw low MACADDR
  movwf FSR0L
  movlw high MACADDR
  movwf FSR0H
  movlw 6
  movwf INDF0
  incf  FSR0L,F
  clrf  INDF0
  incf  FSR0L,F
  clrf  INDF0
  incf  FSR0L,F
  clrf  INDF0
  incf  FSR0L,F
  clrf  INDF0
  incf  FSR0L,F
  clrf  INDF0
  incf  FSR0L,F
  clrf  INDF0
;ipaddr =    0,0,0,0
  movlw low IPADDR
  movwf FSR0L
  movlw high IPADDR
  movwf FSR0H
  movlw 4
  movwf INDF0
  incf  FSR0L,F
  clrf  INDF0
  incf  FSR0L,F
  clrf  INDF0
  incf  FSR0L,F
  clrf  INDF0
  incf  FSR0L,F
  clrf  INDF0
;ipserver =  0,0,0,0
  movlw low IPSERVER
  movwf FSR0L
  movlw high IPSERVER
  movwf FSR0H
  movlw 4
  movwf INDF0
  incf  FSR0L,F
  clrf  INDF0
  incf  FSR0L,F
  clrf  INDF0
  incf  FSR0L,F
  clrf  INDF0
  incf  FSR0L,F
  clrf  INDF0
;ipport = 80   'set a default value
  movlw 80
  movwf IPPORT
;Ip_id = 0
  clrf  IP_ID
  clrf  IP_ID_H
;an outstanding GET is a pending flag
;lastGet = 0
  clrf  LASTGET
;TableStartPoint =1
  movlw 1
  movwf TABLESTARTPOINT
  clrf  TABLESTARTPOINT_H
  return

;********************************************************************************

;Overloaded signature: STRING:byte:
HSERPRINT235
;PrintLen = PrintData(0)
  movf  SysPRINTDATAHandler,W
  movwf AFSR0
  movf  SysPRINTDATAHandler_H,W
  movwf AFSR0_H
  movf  INDF0,W
  movwf PRINTLEN
;If PrintLen <> 0 then
  movf  PRINTLEN,F
  btfsc STATUS, Z
  goto  ENDIF32
;for SysPrintTemp = 1 to PrintLen
  clrf  SYSPRINTTEMP
  movlw 1
  subwf PRINTLEN,W
  btfss STATUS, C
  goto  SysForLoopEnd2
SysForLoop2
  incf  SYSPRINTTEMP,F
;HSerSend(PrintData(SysPrintTemp),comport )
  movf  SYSPRINTTEMP,W
  addwf SysPRINTDATAHandler,W
  movwf AFSR0
  movlw 0
  addwfc  SysPRINTDATAHandler_H,W
  movwf AFSR0_H
  movf  INDF0,W
  movwf SERDATA
  pagesel HSERSEND
  call  HSERSEND
  pagesel $

;Wait USART_DELAY
  movlw 1
  movwf SysWaitTempMS
  clrf  SysWaitTempMS_H
  pagesel Delay_MS
  call  Delay_MS
  pagesel $
;next
  movf  PRINTLEN,W
  subwf SYSPRINTTEMP,W
  btfss STATUS, C
  goto  SysForLoop2
SysForLoopEnd2
;End If
ENDIF32
  return

;********************************************************************************

INITSYS
;nop             ' This is the routine to support OSCCON1 config addresss
  nop
;OSCCON1 = 0x60 ' NOSC HFINTOSC; NDIV 1 - Common as this simply sets the HFINTOSC
  movlw 96
  banksel OSCCON1
  movwf OSCCON1
;OSCCON3 = 0x00 ' CSWHOLD may proceed; SOSCPWR Low power
  clrf  OSCCON3
;OSCEN = 0x00   ' MFOEN disabled; LFOEN disabled; ADOEN disabled; SOSCEN disabled; EXTOEN disabled; HFOEN disabled
  clrf  OSCEN
;OSCTUNE = 0x00 ' HFTUN 0
  clrf  OSCTUNE
;OSCFRQ = 0b00000011
  movlw 3
  movwf OSCFRQ
;SET ADCON0.ADON OFF
  banksel ADCON0
  bcf ADCON0,ADON
;ANSELA = 0
  banksel ANSELA
  clrf  ANSELA
;ANSELB = 0
  clrf  ANSELB
;ANSELC = 0
  clrf  ANSELC
;ANSELD = 0
  clrf  ANSELD
;ANSELE = 0
  clrf  ANSELE
;#IFDEF bit(C2ON): C2ON = 0: #ENDIF
  banksel CM2CON0
  bcf CM2CON0,C2ON
;#IFDEF bit(C1ON): C1ON = 0: #ENDIF
  bcf CM1CON0,C1ON
;PORTA = 0
  banksel PORTA
  clrf  PORTA
;PORTB = 0
  clrf  PORTB
;PORTC = 0
  clrf  PORTC
;PORTD = 0
  clrf  PORTD
;PORTE = 0
  clrf  PORTE
  return

;********************************************************************************

INITUSART
;comport = 1
  movlw 1
  movwf COMPORT
;SPBRG = SPBRGL_TEMP
  movlw 16
  banksel SPBRG
  movwf SPBRG
;SPBRGH = SPBRGH_TEMP
  clrf  SP1BRGH
;BRG16 = BRG16_TEMP
  bsf BAUD1CON,BRG16
;BRGH = BRGH_TEMP
  bsf TX1STA,BRGH
;Set SYNC Off
  bcf TX1STA,SYNC_TX1STA
;Set SPEN On
  bsf RC1STA,SPEN
;Set CREN On
  bsf RC1STA,CREN
;Set TXEN On
  bsf TX1STA,TXEN
  banksel STATUS
  return

;********************************************************************************

;Start of program memory page 1
  ORG 2048
FN_BYTETOBIN
;ByteToBin = ""
  movlw low BYTETOBIN
  movwf FSR1L
  movlw high BYTETOBIN
  movwf FSR1H
  movlw low StringTable55
  movwf SysStringA
  movlw (high StringTable55) & 127
  movwf SysStringA_H
  call  SysReadString
;Repeat 8
  movlw 8
  movwf SysRepeatTemp6
SysRepeatLoop6
;If ByteNum.7 = 1 Then
  btfss BYTENUM,7
  goto  ELSE30_1
;ByteToBin = ByteToBin +"1"
  movlw low BYTETOBIN
  movwf FSR1L
  movlw high BYTETOBIN
  movwf FSR1H
  clrf  SysStringLength
  movlw low BYTETOBIN
  movwf FSR0L
  movlw high BYTETOBIN
  movwf FSR0H
  call  SysCopyStringPart
  movlw low StringTable56
  movwf SysStringA
  movlw (high StringTable56) & 127
  movwf SysStringA_H
  call  SysReadStringPart
  movlw low BYTETOBIN
  movwf FSR0L
  movlw high BYTETOBIN
  movwf FSR0H
  movf  SysStringLength,W
  movwf INDF0
;Else
  goto  ENDIF30
ELSE30_1
;ByteToBin = ByteToBin +"0"
  movlw low BYTETOBIN
  movwf FSR1L
  movlw high BYTETOBIN
  movwf FSR1H
  clrf  SysStringLength
  movlw low BYTETOBIN
  movwf FSR0L
  movlw high BYTETOBIN
  movwf FSR0H
  call  SysCopyStringPart
  movlw low StringTable57
  movwf SysStringA
  movlw (high StringTable57) & 127
  movwf SysStringA_H
  call  SysReadStringPart
  movlw low BYTETOBIN
  movwf FSR0L
  movlw high BYTETOBIN
  movwf FSR0H
  movf  SysStringLength,W
  movwf INDF0
;End If
ENDIF30
;Rotate ByteNum Left
  rlf BYTENUM,F
;End Repeat
  decfsz  SysRepeatTemp6,F
  goto  SysRepeatLoop6
SysRepeatLoopEnd6
  return

;********************************************************************************

Delay_MS
  incf  SysWaitTempMS_H, F
DMS_START
  movlw 4
  movwf DELAYTEMP2
DMS_OUTER
  movlw 165
  movwf DELAYTEMP
DMS_INNER
  decfsz  DELAYTEMP, F
  goto  DMS_INNER
  decfsz  DELAYTEMP2, F
  goto  DMS_OUTER
  decfsz  SysWaitTempMS, F
  goto  DMS_START
  decfsz  SysWaitTempMS_H, F
  goto  DMS_START
  return

;********************************************************************************

Delay_S
DS_START
  movlw 232
  movwf SysWaitTempMS
  movlw 3
  movwf SysWaitTempMS_H
  call  Delay_MS

  decfsz  SysWaitTempS, F
  goto  DS_START
  return

;********************************************************************************

ENC28J60_BITCLEAR
;banktobeselected = ( addr & BANK_MASK) / 32
;banktobeselected = ( addr & BANK_MASK)
  movlw 96
  andwf ADDR,W
  movwf BANKTOBESELECTED
;Repeat 5
  movlw 5
  movwf SysRepeatTemp3
SysRepeatLoop3
;set c off
  bcf STATUS,C
;rotate banktobeselected right
  rrf BANKTOBESELECTED,F
;end repeat
  decfsz  SysRepeatTemp3,F
  goto  SysRepeatLoop3
SysRepeatLoopEnd3
;if lastselectedBank <> banktobeselected then
  movf  BANKTOBESELECTED,W
  subwf LASTSELECTEDBANK,W
  btfsc STATUS, Z
  goto  ELSE8_1
;if ( ( addr & ADDR_MASK )  <= EIE  ) then
  movlw 31
  andwf ADDR,W
  movwf SysTemp1
  movwf SysBYTETempB
  movlw 27
  movwf SysBYTETempA
  call  SysCompLessThan
  comf  SysByteTempX,F
  btfss SysByteTempX,0
  goto  ENDIF9
;ENC28j60_selectBank ( banktobeselected, addr )
  call  ENC28J60_SELECTBANK

;end if
ENDIF9
;Else
  goto  ENDIF8
ELSE8_1
;lastselectedBank = banktobeselected
  movf  BANKTOBESELECTED,W
  movwf LASTSELECTEDBANK
;end if
ENDIF8
;ENC28j60_Select
  bcf LATA,5
;FastHWSPITransfer( ENC28j60_BIT_FIELD_CLR | (addr AND ADDR_MASK ), temp )
  movlw 31
  andwf ADDR,W
  movwf SysTemp1
  movlw 160
  iorwf SysTemp1,W
  movwf SPITXDATA
  call  FASTHWSPITRANSFER

;FastHWSPITransfer( ENC_Outbyte, temp )
  movf  ENC_OUTBYTE,W
  movwf SPITXDATA
  call  FASTHWSPITRANSFER

;ENC28j60_Deselect
  bsf LATA,5
  return

;********************************************************************************

ENC28J60_BITSET
;banktobeselected = ( addr & BANK_MASK) / 32
;HSerPrintByteCRLF banktobeselected
;banktobeselected = ( addr & BANK_MASK)
  movlw 96
  andwf ADDR,W
  movwf BANKTOBESELECTED
;Repeat 5
  movlw 5
  movwf SysRepeatTemp2
SysRepeatLoop2
;set c off
  bcf STATUS,C
;rotate banktobeselected right
  rrf BANKTOBESELECTED,F
;end repeat
  decfsz  SysRepeatTemp2,F
  goto  SysRepeatLoop2
SysRepeatLoopEnd2
;HSerPrintByteCRLF banktobeselected
;HSerPrintCRLF
;if lastselectedBank <> banktobeselected then
  movf  BANKTOBESELECTED,W
  subwf LASTSELECTEDBANK,W
  btfsc STATUS, Z
  goto  ELSE6_1
;if ( ( addr & ADDR_MASK )  <= EIE  ) then
  movlw 31
  andwf ADDR,W
  movwf SysTemp1
  movwf SysBYTETempB
  movlw 27
  movwf SysBYTETempA
  call  SysCompLessThan
  comf  SysByteTempX,F
  btfss SysByteTempX,0
  goto  ENDIF7
;ENC28j60_selectBank ( banktobeselected, addr )
  call  ENC28J60_SELECTBANK

;end if
ENDIF7
;Else
  goto  ENDIF6
ELSE6_1
;lastselectedBank = banktobeselected
  movf  BANKTOBESELECTED,W
  movwf LASTSELECTEDBANK
;end if
ENDIF6
;ENC28j60_Select
  bcf LATA,5
;FastHWSPITransfer( ENC28j60_BIT_FIELD_SET | (addr AND ADDR_MASK ), temp )
  movlw 31
  andwf ADDR,W
  movwf SysTemp1
  movlw 128
  iorwf SysTemp1,W
  movwf SPITXDATA
  call  FASTHWSPITRANSFER

;FastHWSPITransfer( ENC_Outbyte, temp )
  movf  ENC_OUTBYTE,W
  movwf SPITXDATA
  call  FASTHWSPITRANSFER

;ENC28j60_Deselect
  bsf LATA,5
  return

;********************************************************************************

ENC28J60_INIT
;ddebug = 0
  clrf  DDEBUG
;HSerPrintCRLF
  movlw 1
  movwf HSERPRINTCRLFCOUNT
  movlw 1
  movwf COMPORT
  call  HSERPRINTCRLF

;HSerPrint "ENC28j60_Init( in macaddr() )"
  movlw low StringTable5
  movwf SysPRINTDATAHandler
  movlw (high StringTable5) | 128
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  pagesel HSERPRINT235
  call  HSERPRINT235
  pagesel $

;HSerPrintCRLF
  movlw 1
  movwf HSERPRINTCRLFCOUNT
  movlw 1
  movwf COMPORT
  call  HSERPRINTCRLF

;Dir ENC28j60_DI in
  bsf TRISB,0
;Dir ENC28j60_DO Out
  bcf TRISB,3
;Dir ENC28j60_SCK Out
  bcf TRISB,1
;Dir ENC28j60_CS out
  bcf TRISA,5
;Dir ENC28j60_RESET out
  bcf TRISB,4
;set ENC28j60_DO off
  bcf LATB,3
;set ENC28j60_SCK off
  bcf LATB,1
;set ENC28j60_CS off
  bcf LATA,5
;DIR PORTb.1 Out
  bcf TRISB,1
;DIR PORTb.3 Out
  bcf TRISB,3
;DIR PORTb.0 IN
  bsf TRISB,0
;DIR Ethernet_CS OUT
  bcf TRISA,5
;ENC28j60_Deselect
  bsf LATA,5
;Repeat 5
  movlw 5
  movwf SysRepeatTemp1
SysRepeatLoop1
;ENC28j60_Reset_CMD
  bsf LATB,4
  movlw 20
  movwf SysWaitTempMS
  clrf  SysWaitTempMS_H
  call  Delay_MS
  bcf LATB,4
  movlw 20
  movwf SysWaitTempMS
  clrf  SysWaitTempMS_H
  call  Delay_MS
  bsf LATB,4
  movlw 20
  movwf SysWaitTempMS
  clrf  SysWaitTempMS_H
  call  Delay_MS
;End Repeat
  decfsz  SysRepeatTemp1,F
  goto  SysRepeatLoop1
SysRepeatLoopEnd1
;ENC28j60_Select
  bcf LATA,5
;SPIMode MasterFast, 0
  movlw 13
  movwf SPICURRENTMODE
  clrf  SPICLOCKMODE
  call  SPIMODE190

;FastHWSPITransfer( ENC28j60_SOFT_RESET, temp )
  movlw 255
  movwf SPITXDATA
  call  FASTHWSPITRANSFER

;lastselectedBank = 99
  movlw 99
  movwf LASTSELECTEDBANK
;HSerPrint "Pre WAIT1"
  movlw low StringTable6
  movwf SysPRINTDATAHandler
  movlw (high StringTable6) | 128
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  pagesel HSERPRINT235
  call  HSERPRINT235
  pagesel $

;HSerPrintCRLF
  movlw 1
  movwf HSERPRINTCRLFCOUNT
  movlw 1
  movwf COMPORT
  call  HSERPRINTCRLF

;ddebug=1
  movlw 1
  movwf DDEBUG
;wait while ( (ENC28j60_ReadReg( ESTAT ) & ESTAT_CLKRDY ) <> ESTAT_CLKRDY)
SysWaitLoop1
  movlw 29
  movwf ADDR
  call  FN_ENC28J60_READREG
  movlw 1
  andwf ENC28J60_READREG,W
  movwf SysTemp1
  movwf SysBYTETempA
  movlw 1
  movwf SysBYTETempB
  call  SysCompEqual
  comf  SysByteTempX,F
  btfsc SysByteTempX,0
  goto  SysWaitLoop1
;HSerPrint "pOST WAIT1"
  movlw low StringTable7
  movwf SysPRINTDATAHandler
  movlw (high StringTable7) | 128
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  pagesel HSERPRINT235
  call  HSERPRINT235
  pagesel $

;HSerPrintCRLF
  movlw 1
  movwf HSERPRINTCRLFCOUNT
  movlw 1
  movwf COMPORT
  call  HSERPRINTCRLF

;ENC28j60_writeReg(ECON1, 0xC1) 'Hold it in Reset
  movlw 31
  movwf ADDR
  movlw 193
  movwf ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;ENC28j60_writeReg(ECON2, 0x80) 'Set the AUTOINC bit
  movlw 30
  movwf ADDR
  movlw 128
  movwf ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;ENC28j60_writeReg(EIR, 0x00) 'Reset interrupt flags
  movlw 28
  movwf ADDR
  clrf  ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;ENC28j60_writeReg(EIE,  0xC1)  'Interrupts: Packet reception and buffer errors
  movlw 27
  movwf ADDR
  movlw 193
  movwf ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;ENC28j60_writeReg(EWOLIE, 0x00)  'Disable wake-on-lan interrupts
  movlw 54
  movwf ADDR
  clrf  ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;ENC28j60_writeReg(EWOLIR, 0x00)  'Clear wake-on-lan interrupt flags
  movlw 55
  movwf ADDR
  clrf  ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;ENC28j60_writeReg(ETXSTL, ENC_TXBUF_STL)
  movlw 4
  movwf ADDR
  movlw 112
  movwf ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;ENC28j60_writeReg(ETXSTH, ENC_TXBUF_STH)
  movlw 5
  movwf ADDR
  movlw 22
  movwf ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;ENC28j60_writeReg(ETXNDL, ENC_TXBUF_NDL)
  movlw 6
  movwf ADDR
  movlw 255
  movwf ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;ENC28j60_writeReg(ETXNDH, ENC_TXBUF_NDH)  'TX Buffer : 1800 bytes
  movlw 7
  movwf ADDR
  movlw 31
  movwf ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;ENC28j60_writeReg(ERXSTL, ENC_RXBUF_STL)
  movlw 8
  movwf ADDR
  clrf  ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;ENC28j60_writeReg(ERXSTH, ENC_RXBUF_STH)
  movlw 9
  movwf ADDR
  clrf  ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;ENC28j60_writeReg(ERXNDL, ENC_RXBUF_NDL)
  movlw 10
  movwf ADDR
  movlw 110
  movwf ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;ENC28j60_writeReg(ERXNDH, ENC_RXBUF_NDH)  'RX Buffer : 6390 bytes
  movlw 11
  movwf ADDR
  movlw 22
  movwf ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;ENC28j60_writeReg(ERDPTL, ENC_RXBUF_STL)
  clrf  ADDR
  clrf  ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;ENC28j60_writeReg(ERDPTH, ENC_RXBUF_STH)
  movlw 1
  movwf ADDR
  clrf  ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;ENC28j60_writeReg(ERXRDPTL, ENC_RXBUF_STL)
  movlw 12
  movwf ADDR
  clrf  ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;ENC28j60_writeReg(ERXRDPTH, ENC_RXBUF_STH) 'RX Pointers (same)
  movlw 13
  movwf ADDR
  clrf  ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;nextpacketptr = ENC_RXBUF_ST
  clrf  NEXTPACKETPTR
  clrf  NEXTPACKETPTR_H
;ENC28j60_writeReg( ERXFCON, 0xA1) 'Receive unicasts or broadcasts
;For broadcast packets we allow only ARP packtets
;All other packets should be unicast only for our mac (MAADR)
;
;The pattern to match on is therefore
;Type     ETH.DST
;ARP      BROADCAST
;06 08 -- ff ff ff ff ff ff -> ip checksum for theses bytes=f7f9
;in binary these poitions are:11 0000 0011 1111
;This is hex 303F->EPMM0=0x3f,EPMM1=0x30
;ENC28j60_writeReg( EPMCSH, 0xf7)
;ENC28j60_writeReg( EPMCSL, 0xf9)
;ENC28j60_writeReg( EPMM0, 0x3f)
;ENC28j60_writeReg( EPMM1, 0x30)
;ENC28j60_bitClear( ERXFCON, ERXFCON_ANDOR ) 'Set filter bit
;
;Enc28j60_bitSet( ERXFCON, ERXFCON_UCEN ) 'Set filter bit
;
;ENC28j60_bitClear( ERXFCON, ERXFCON_CRCEN ) 'Set filter bit
;
;Enc28j60_bitSet( ERXFCON, ERXFCON_BCEN ) 'Set filter bit
;
;ENC28j60_bitClear( ERXFCON, ERXFCON_MPEN ) 'UnSet filter bit
;
;Enc28j60_bitSet( ERXFCON, ERXFCON_PMEN ) 'Set filter bit
;ENC28j60_writeReg( ERXFCON, ERXFCON_UCEN | ERXFCON_MCEN | ERXFCON_BCEN | ERXFCON_PMEN)
;Cannot get filter to Work, so use the folllowing
;ENC28j60_writeReg( ERXFCON, ERXFCON_CRCEN )
  movlw 56
  movwf ADDR
  movlw 32
  movwf ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;ENC28j60_writeReg(EFLOCON, 0x00) 'Disable flow control sending
  movlw 119
  movwf ADDR
  clrf  ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;ENC28j60_writeReg(ECOCON, 0x00) 'Disable Clock Out pin
  movlw 117
  movwf ADDR
  clrf  ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;ENC28j60_writeReg(EBSTCON, 0x00) 'Disable built-in self test controller
  movlw 103
  movwf ADDR
  clrf  ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;wait while ( (ENC28j60_ReadReg(ESTAT) & ESTAT_CLKRDY) <> ESTAT_CLKRDY)
SysWaitLoop2
  movlw 29
  movwf ADDR
  call  FN_ENC28J60_READREG
  movlw 1
  andwf ENC28J60_READREG,W
  movwf SysTemp1
  movwf SysBYTETempA
  movlw 1
  movwf SysBYTETempB
  call  SysCompEqual
  comf  SysByteTempX,F
  btfsc SysByteTempX,0
  goto  SysWaitLoop2
;HSerPrint "pOST WAIT2"
  movlw low StringTable8
  movwf SysPRINTDATAHandler
  movlw (high StringTable8) | 128
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  pagesel HSERPRINT235
  call  HSERPRINT235
  pagesel $

;HSerPrintCRLF
  movlw 1
  movwf HSERPRINTCRLFCOUNT
  movlw 1
  movwf COMPORT
  call  HSERPRINTCRLF

;ENC28j60_writeReg(MISTAT, 0x00)  'Clear MII status register
  movlw 234
  movwf ADDR
  clrf  ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;ENC28j60_writeReg(MICMD, 0x00)   'Clear MII command register
  movlw 210
  movwf ADDR
  clrf  ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;ENC28j60_writeReg(MICON1, 0x02)  'Fast MII operation
;ENC28j60_writeReg(MICON2, 0x00)  'Release MII interface from reset
;ENC28j60_writeReg(MACON1, 0b00001101 )  'Enable packet reception
  movlw 192
  movwf ADDR
  movlw 13
  movwf ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;ENC28j60_writeReg(MACON2, 0x00)  'Release the MAC subsystem from reset
;ENC28j60_writeReg(MACON3, 0xB1)  'Auto Pad + CRC + Full Duplex
;ENC28j60_writeReg(MACON3, 0x32)  'Auto Pad to 60 bytes + CRC + Half Duplex + Check frame length
  movlw 194
  movwf ADDR
  movlw 50
  movwf ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;ENC28j60_writeReg(MACON4, 0x01)  'Need valid preamble
  movlw 195
  movwf ADDR
  movlw 1
  movwf ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;ENC28j60_writeReg(MAPHSUP, b'00010000') 'Release MAC-PHY support from Reset
;ENC28j60_writeReg(MAMXFLL, 0xEE)
  movlw 202
  movwf ADDR
  movlw 238
  movwf ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;ENC28j60_writeReg(MAMXFLH, 0x05)  'Maximum frame length
  movlw 203
  movwf ADDR
  movlw 5
  movwf ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;ENC28j60_writeReg(MABBIPG, 0x12) 'IEEE BTB Inter Packet Gap
  movlw 196
  movwf ADDR
  movlw 18
  movwf ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;ENC28j60_writeReg(MAIPGL, 0x12)
  movlw 198
  movwf ADDR
  movlw 18
  movwf ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;ENC28j60_writeReg(MAIPGH, 0x0C)  'IEEE Non BTB Inter Packet Gap
  movlw 199
  movwf ADDR
  movlw 12
  movwf ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;ENC28j60_writeReg(MAADR0, macaddr(2))
  movlw 225
  movwf ADDR
  movlw 2
  addwf SysMACADDRHandler,W
  movwf AFSR0
  movlw 0
  addwfc  SysMACADDRHandler_H,W
  movwf AFSR0_H
  movf  INDF0,W
  movwf ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;ENC28j60_writeReg(MAADR1, macaddr(1))
  movlw 224
  movwf ADDR
  movlw 1
  addwf SysMACADDRHandler,W
  movwf AFSR0
  movlw 0
  addwfc  SysMACADDRHandler_H,W
  movwf AFSR0_H
  movf  INDF0,W
  movwf ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;ENC28j60_writeReg(MAADR2, macaddr(4))
  movlw 227
  movwf ADDR
  movlw 4
  addwf SysMACADDRHandler,W
  movwf AFSR0
  movlw 0
  addwfc  SysMACADDRHandler_H,W
  movwf AFSR0_H
  movf  INDF0,W
  movwf ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;ENC28j60_writeReg(MAADR3, macaddr(3))
  movlw 226
  movwf ADDR
  movlw 3
  addwf SysMACADDRHandler,W
  movwf AFSR0
  movlw 0
  addwfc  SysMACADDRHandler_H,W
  movwf AFSR0_H
  movf  INDF0,W
  movwf ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;ENC28j60_writeReg(MAADR4, macaddr(6))
  movlw 229
  movwf ADDR
  movlw 6
  addwf SysMACADDRHandler,W
  movwf AFSR0
  movlw 0
  addwfc  SysMACADDRHandler_H,W
  movwf AFSR0_H
  movf  INDF0,W
  movwf ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;ENC28j60_writeReg(MAADR5, macaddr(5))
  movlw 228
  movwf ADDR
  movlw 5
  addwf SysMACADDRHandler,W
  movwf AFSR0
  movlw 0
  addwfc  SysMACADDRHandler_H,W
  movwf AFSR0_H
  movf  INDF0,W
  movwf ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;HSerPrint "pOST mac"
  movlw low StringTable9
  movwf SysPRINTDATAHandler
  movlw (high StringTable9) | 128
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  pagesel HSERPRINT235
  call  HSERPRINT235
  pagesel $

;HSerPrintCRLF
  movlw 1
  movwf HSERPRINTCRLFCOUNT
  movlw 1
  movwf COMPORT
  call  HSERPRINTCRLF

;'Initialize PHY subsystem
;ENC28j60_writePhyReg(PHCON1, 0x00, 0x00)  'Half duplex
  clrf  PHYREGADDR
  clrf  ENC_OUTBYTE1
  clrf  ENC_OUTBYTE2
  pagesel ENC28J60_WRITEPHYREG
  call  ENC28J60_WRITEPHYREG
  pagesel $

;HSerPrint "writePhyReg1"
  movlw low StringTable10
  movwf SysPRINTDATAHandler
  movlw (high StringTable10) | 128
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  pagesel HSERPRINT235
  call  HSERPRINT235
  pagesel $

;HSerPrintCRLF
  movlw 1
  movwf HSERPRINTCRLFCOUNT
  movlw 1
  movwf COMPORT
  call  HSERPRINTCRLF

;ENC28j60_writePhyReg(PHCON2, 0x00, 0x00)
  movlw 16
  movwf PHYREGADDR
  clrf  ENC_OUTBYTE1
  clrf  ENC_OUTBYTE2
  pagesel ENC28J60_WRITEPHYREG
  call  ENC28J60_WRITEPHYREG
  pagesel $

;ENC28j60_writePhyReg(PHLCON, 0B00000100, 0B01110110 )
  movlw 20
  movwf PHYREGADDR
  movlw 4
  movwf ENC_OUTBYTE1
  movlw 118
  movwf ENC_OUTBYTE2
  pagesel ENC28J60_WRITEPHYREG
  call  ENC28J60_WRITEPHYREG
  pagesel $

;ENC28j60_writePhyReg(PHIE, 0x00, 0x00)  'Disable interrupts
  movlw 18
  movwf PHYREGADDR
  clrf  ENC_OUTBYTE1
  clrf  ENC_OUTBYTE2
  pagesel ENC28J60_WRITEPHYREG
  call  ENC28J60_WRITEPHYREG
  pagesel $

;HSerPrint "writePhyReg2"
  movlw low StringTable11
  movwf SysPRINTDATAHandler
  movlw (high StringTable11) | 128
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  pagesel HSERPRINT235
  call  HSERPRINT235
  pagesel $

;HSerPrintCRLF
  movlw 1
  movwf HSERPRINTCRLFCOUNT
  movlw 1
  movwf COMPORT
  call  HSERPRINTCRLF

;ENC28j60_writeReg(ECON1, 0B00010100 )
  movlw 31
  movwf ADDR
  movlw 20
  movwf ENC_OUTBYTE
  call  ENC28J60_WRITEREG

;ENC28j60_writeReg(ECON1, B'00000100')
;ENC28j60_writePhyReg ( PHLCON, 0xA2, 0x0A )
;wait 5 s
;ENC28j60_writePhyReg ( PHLCON, 0x76, 0x04 )
  movlw 20
  movwf PHYREGADDR
  movlw 118
  movwf ENC_OUTBYTE1
  movlw 4
  movwf ENC_OUTBYTE2
  pagesel ENC28J60_WRITEPHYREG
  call  ENC28J60_WRITEPHYREG
  pagesel $

;HSerPrint "eXIT init"
  movlw low StringTable12
  movwf SysPRINTDATAHandler
  movlw (high StringTable12) | 128
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  pagesel HSERPRINT235
  call  HSERPRINT235
  pagesel $

;HSerPrintCRLF
  movlw 1
  movwf HSERPRINTCRLFCOUNT
  movlw 1
  movwf COMPORT
  call  HSERPRINTCRLF

  return

;********************************************************************************

FN_ENC28J60_READREG
;dim SSPBUFtemp1, SSPBUFtemp2  as byte
;banktobeselected =  ( addr & BANK_MASK) / 32
;if ddebug = 1 then
  decf  DDEBUG,W
  btfss STATUS, Z
  goto  ENDIF13
;HSerPrint "A)"
  movlw low StringTable29
  movwf SysPRINTDATAHandler
  movlw (high StringTable29) | 128
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  pagesel HSERPRINT235
  call  HSERPRINT235
  pagesel $

;HSerPrint hex(addr)
  movf  ADDR,W
  movwf SYSVALTEMP
  call  FN_HEX
  movlw low HEX
  movwf SysPRINTDATAHandler
  movlw high HEX
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  pagesel HSERPRINT235
  call  HSERPRINT235
  pagesel $

;HSerPrint ":*"
  movlw low StringTable30
  movwf SysPRINTDATAHandler
  movlw (high StringTable30) | 128
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  pagesel HSERPRINT235
  call  HSERPRINT235
  pagesel $

;end if
ENDIF13
;banktobeselected =  ( addr & BANK_MASK)
  movlw 96
  andwf ADDR,W
  movwf BANKTOBESELECTED
;Repeat 5
  movlw 5
  movwf SysRepeatTemp5
SysRepeatLoop5
;set c off
  bcf STATUS,C
;rotate banktobeselected right
  rrf BANKTOBESELECTED,F
;end repeat
  decfsz  SysRepeatTemp5,F
  goto  SysRepeatLoop5
SysRepeatLoopEnd5
;if ddebug = 1 then
  decf  DDEBUG,W
  btfss STATUS, Z
  goto  ENDIF14
;HSerPrint "($"
  movlw low StringTable31
  movwf SysPRINTDATAHandler
  movlw (high StringTable31) | 128
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  pagesel HSERPRINT235
  call  HSERPRINT235
  pagesel $

;HSerPrint banktobeselected
  movf  BANKTOBESELECTED,W
  movwf SERPRINTVAL
  movlw 1
  movwf COMPORT
  call  HSERPRINT236

;HSerPrint ":)"
  movlw low StringTable32
  movwf SysPRINTDATAHandler
  movlw (high StringTable32) | 128
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  pagesel HSERPRINT235
  call  HSERPRINT235
  pagesel $

;end if
ENDIF14
;'These registers (EIE, EIR, ESTAT, ECON2, ECON1)
;'are present in all banks, no need to switch bank
;if lastselectedBank <> banktobeselected then
  movf  BANKTOBESELECTED,W
  subwf LASTSELECTEDBANK,W
  btfsc STATUS, Z
  goto  ENDIF15
;if ( ( addr & ADDR_MASK ) <= EIE  ) then
  movlw 31
  andwf ADDR,W
  movwf SysTemp1
  movwf SysBYTETempB
  movlw 27
  movwf SysBYTETempA
  call  SysCompLessThan
  comf  SysByteTempX,F
  btfss SysByteTempX,0
  goto  ELSE19_1
;ENC28j60_selectBank ( banktobeselected, addr )
  call  ENC28J60_SELECTBANK

;else
  goto  ENDIF19
ELSE19_1
;lastselectedBank = banktobeselected
  movf  BANKTOBESELECTED,W
  movwf LASTSELECTEDBANK
;end if
ENDIF19
;end if
ENDIF15
;ENC28j60_Select
  bcf LATA,5
;Set WCOL Off
  banksel SSP1CON1
  bcf SSP1CON1,WCOL
;if ddebug = 1 then HSerPrint hex(ENC28j60_READ_CTRL_REG | ( addr AND ADDR_MASK ))
  banksel DDEBUG
  decf  DDEBUG,W
  btfss STATUS, Z
  goto  ENDIF16
  movlw 31
  andwf ADDR,W
  movwf SysTemp1
  movwf SYSVALTEMP
  call  FN_HEX
  movlw low HEX
  movwf SysPRINTDATAHandler
  movlw high HEX
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  pagesel HSERPRINT235
  call  HSERPRINT235
  pagesel $

ENDIF16
;if ddebug = 1 then HSerPrintCRLF
  decf  DDEBUG,W
  btfss STATUS, Z
  goto  ENDIF17
  movlw 1
  movwf HSERPRINTCRLFCOUNT
  movlw 1
  movwf COMPORT
  call  HSERPRINTCRLF

ENDIF17
;SPITransfer ( ENC28j60_READ_CTRL_REG | ( addr AND ADDR_MASK ), SSPBUFtemp1 )
  movlw 31
  andwf ADDR,W
  movwf SysTemp1
  movwf SPITXDATA
  call  HWSPITRANSFER
  movf  SPIRXDATA,W
  movwf SSPBUFTEMP1

;SPITransfer ( SSPBUFtemp2, SSPBUFtemp2 )
  movf  SSPBUFTEMP2,W
  movwf SPITXDATA
  call  HWSPITRANSFER
  movf  SPIRXDATA,W
  movwf SSPBUFTEMP2

;SPITransfer ( SSPBUFtemp2, ENC28j60_ReadReg  )
  movf  SSPBUFTEMP2,W
  movwf SPITXDATA
  call  HWSPITRANSFER

;if ddebug = 1 then
  decf  DDEBUG,W
  btfss STATUS, Z
  goto  ENDIF18
;HSerPrint "<"
  movlw low StringTable33
  movwf SysPRINTDATAHandler
  movlw (high StringTable33) | 128
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  pagesel HSERPRINT235
  call  HSERPRINT235
  pagesel $

;HSerPrintCRLF
  movlw 1
  movwf HSERPRINTCRLFCOUNT
  movlw 1
  movwf COMPORT
  call  HSERPRINTCRLF

;HSerPrint hex(SSPBUFtemp1)
  movf  SSPBUFTEMP1,W
  movwf SYSVALTEMP
  call  FN_HEX
  movlw low HEX
  movwf SysPRINTDATAHandler
  movlw high HEX
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  pagesel HSERPRINT235
  call  HSERPRINT235
  pagesel $

;HSerPrintCRLF
  movlw 1
  movwf HSERPRINTCRLFCOUNT
  movlw 1
  movwf COMPORT
  call  HSERPRINTCRLF

;HSerPrint hex(SSPBUFtemp2)
  movf  SSPBUFTEMP2,W
  movwf SYSVALTEMP
  call  FN_HEX
  movlw low HEX
  movwf SysPRINTDATAHandler
  movlw high HEX
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  pagesel HSERPRINT235
  call  HSERPRINT235
  pagesel $

;HSerPrintCRLF
  movlw 1
  movwf HSERPRINTCRLFCOUNT
  movlw 1
  movwf COMPORT
  call  HSERPRINTCRLF

;HSerPrint ByteToBin(ENC28j60_ReadReg )
  movf  ENC28J60_READREG,W
  movwf BYTENUM
  call  FN_BYTETOBIN
  movlw low BYTETOBIN
  movwf SysPRINTDATAHandler
  movlw high BYTETOBIN
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  pagesel HSERPRINT235
  call  HSERPRINT235
  pagesel $

;HSerPrint ">"
  movlw low StringTable34
  movwf SysPRINTDATAHandler
  movlw (high StringTable34) | 128
  movwf SysPRINTDATAHandler_H
  movlw 1
  movwf COMPORT
  pagesel HSERPRINT235
  call  HSERPRINT235
  pagesel $

;do
SysDoLoop_S4
;loop
  goto  SysDoLoop_S4
SysDoLoop_E4
;end if
ENDIF18
;ENC28j60_Deselect
  bsf LATA,5
  return

;********************************************************************************

ENC28J60_SELECTBANK
;ENC28j60_Select
  bcf LATA,5
;FastHWSPITransfer(BFCCMD | ECON1, temp)
  movlw 191
  movwf SPITXDATA
  call  FASTHWSPITRANSFER

;FastHWSPITransfer( 0b00000011, temp)
  movlw 3
  movwf SPITXDATA
  call  FASTHWSPITRANSFER

;ENC28j60_Deselect
  bsf LATA,5
;ENC28j60_Select
  bcf LATA,5
;FastHWSPITransfer(BFSCMD | ECON1, temp)
  movlw 159
  movwf SPITXDATA
  call  FASTHWSPITRANSFER

;Select case banktobeselected
;case 0
;
;FastHWSPITransfer( 0b00000000 , temp)
;case 1
SysSelect1Case1
  decf  BANKTOBESELECTED,W
  btfss STATUS, Z
  goto  SysSelect1Case2
;FastHWSPITransfer( 0b00000001 , temp)
  movlw 1
  movwf SPITXDATA
  call  FASTHWSPITRANSFER

;case 2
  goto  SysSelectEnd1
SysSelect1Case2
  movlw 2
  subwf BANKTOBESELECTED,W
  btfss STATUS, Z
  goto  SysSelect1Case3
;FastHWSPITransfer( 0b00000010 , temp)
  movlw 2
  movwf SPITXDATA
  call  FASTHWSPITRANSFER

;case 3
  goto  SysSelectEnd1
SysSelect1Case3
  movlw 3
  subwf BANKTOBESELECTED,W
  btfss STATUS, Z
  goto  SysSelect1Case4
;FastHWSPITransfer( 0b00000011 , temp)
  movlw 3
  movwf SPITXDATA
  call  FASTHWSPITRANSFER

;End Select
SysSelect1Case4
SysSelectEnd1
;ENC28j60_Deselect
  bsf LATA,5
;lastselectedBank = banktobeselected
  movf  BANKTOBESELECTED,W
  movwf LASTSELECTEDBANK
  return

;********************************************************************************

ENC28J60_SETFREQUENCY
;if ENC_Outbyte > 5 then ENC_Outbyte = 5
  movf  ENC_OUTBYTE,W
  sublw 5
  btfsc STATUS, C
  goto  ENDIF12
  movlw 5
  movwf ENC_OUTBYTE
ENDIF12
;ENC28j60_WriteReg( ECOCON, ENC_Outbyte )
  movlw 117
  movwf ADDR
  call  ENC28J60_WRITEREG

  return

;********************************************************************************

ENC28J60_WRITEREG
;banktobeselected = ( addr & BANK_MASK) / 32
;banktobeselected =  ( addr & BANK_MASK)
  movlw 96
  andwf ADDR,W
  movwf BANKTOBESELECTED
;Repeat 5
  movlw 5
  movwf SysRepeatTemp4
SysRepeatLoop4
;set c off
  bcf STATUS,C
;rotate banktobeselected right
  rrf BANKTOBESELECTED,F
;end Repeat
  decfsz  SysRepeatTemp4,F
  goto  SysRepeatLoop4
SysRepeatLoopEnd4
;if lastselectedBank <> banktobeselected then
  movf  BANKTOBESELECTED,W
  subwf LASTSELECTEDBANK,W
  btfsc STATUS, Z
  goto  ELSE10_1
;if ( ( addr & ADDR_MASK )  <= EIE  ) then
  movlw 31
  andwf ADDR,W
  movwf SysTemp1
  movwf SysBYTETempB
  movlw 27
  movwf SysBYTETempA
  call  SysCompLessThan
  comf  SysByteTempX,F
  btfss SysByteTempX,0
  goto  ENDIF11
;ENC28j60_selectBank ( banktobeselected, addr )
  call  ENC28J60_SELECTBANK

;end if
ENDIF11
;Else
  goto  ENDIF10
ELSE10_1
;lastselectedBank = banktobeselected
  movf  BANKTOBESELECTED,W
  movwf LASTSELECTEDBANK
;end if
ENDIF10
;ENC28j60_Select
  bcf LATA,5
;FastHWSPITransfer( ENC28j60_WRITE_CTRL_REG | (addr AND ADDR_MASK ), temp )
  movlw 31
  andwf ADDR,W
  movwf SysTemp1
  movlw 64
  iorwf SysTemp1,W
  movwf SPITXDATA
  call  FASTHWSPITRANSFER

;FastHWSPITransfer( ENC_Outbyte, temp )
  movf  ENC_OUTBYTE,W
  movwf SPITXDATA
  call  FASTHWSPITRANSFER

;ENC28j60_Deselect
  bsf LATA,5
  return

;********************************************************************************

FASTHWSPITRANSFER
;Set SSPCON1.WCOL Off
  banksel SSP1CON1
  bcf SSP1CON1,WCOL
;SSPBUF = SPITxData
  banksel SPITXDATA
  movf  SPITXDATA,W
  banksel SSP1BUF
  movwf SSP1BUF
;Wait While SSPSTAT.BF = Off
SysWaitLoop5
  btfss SSP1STAT,BF
  goto  SysWaitLoop5
;Set SSPSTAT.BF Off
  bcf SSP1STAT,BF
;SPIRxData = SSPBUF
  movf  SSP1BUF,W
  banksel SPIRXDATA
  movwf SPIRXDATA
  return

;********************************************************************************

FN_HEX
;Hex(0) = 2
  movlw 2
  banksel SYSHEX_0
  movwf SYSHEX_0
;SysStringTemp = SysValTemp And 0x0F
  movlw 15
  banksel SYSVALTEMP
  andwf SYSVALTEMP,W
  movwf SYSSTRINGTEMP
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
  sublw 9
  btfsc STATUS, C
  goto  ENDIF27
  movlw 7
  addwf SYSSTRINGTEMP,F
ENDIF27
;Hex(2) = SysStringTemp + 48
  movlw 48
  addwf SYSSTRINGTEMP,W
  banksel SYSHEX_2
  movwf SYSHEX_2
;For SysStringTemp = 1 to 4
  banksel SYSSTRINGTEMP
  clrf  SYSSTRINGTEMP
SysForLoop1
  incf  SYSSTRINGTEMP,F
;Rotate SysValTemp Right
  rrf SYSVALTEMP,F
;Next
  movlw 4
  subwf SYSSTRINGTEMP,W
  btfss STATUS, C
  goto  SysForLoop1
SysForLoopEnd1
;SysStringTemp = SysValTemp And 0x0F
  movlw 15
  andwf SYSVALTEMP,W
  movwf SYSSTRINGTEMP
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
  sublw 9
  btfsc STATUS, C
  goto  ENDIF29
  movlw 7
  addwf SYSSTRINGTEMP,F
ENDIF29
;Hex(1) = SysStringTemp + 48
  movlw 48
  addwf SYSSTRINGTEMP,W
  banksel SYSHEX_1
  movwf SYSHEX_1
  banksel STATUS
  return

;********************************************************************************

;Overloaded signature: BYTE:byte:
HSERPRINT236
;OutValueTemp = 0
  clrf  OUTVALUETEMP
;IF SerPrintVal >= 100 Then
  movlw 100
  subwf SERPRINTVAL,W
  btfss STATUS, C
  goto  ENDIF35
;OutValueTemp = SerPrintVal / 100
  movf  SERPRINTVAL,W
  movwf SysBYTETempA
  movlw 100
  movwf SysBYTETempB
  call  SysDivSub
  movf  SysBYTETempA,W
  movwf OUTVALUETEMP
;SerPrintVal = SysCalcTempX
  movf  SYSCALCTEMPX,W
  movwf SERPRINTVAL
;HSerSend(OutValueTemp + 48 ,comport )
  movlw 48
  addwf OUTVALUETEMP,W
  movwf SERDATA
  call  HSERSEND

;Wait USART_DELAY
  movlw 1
  movwf SysWaitTempMS
  clrf  SysWaitTempMS_H
  call  Delay_MS
;End If
ENDIF35
;If OutValueTemp > 0 Or SerPrintVal >= 10 Then
  movf  OUTVALUETEMP,W
  movwf SysBYTETempB
  clrf  SysBYTETempA
  call  SysCompLessThan
  movf  SysByteTempX,W
  movwf SysTemp2
  movf  SERPRINTVAL,W
  movwf SysBYTETempA
  movlw 10
  movwf SysBYTETempB
  call  SysCompLessThan
  comf  SysByteTempX,F
  movf  SysTemp2,W
  iorwf SysByteTempX,W
  movwf SysTemp1
  btfss SysTemp1,0
  goto  ENDIF36
;OutValueTemp = SerPrintVal / 10
  movf  SERPRINTVAL,W
  movwf SysBYTETempA
  movlw 10
  movwf SysBYTETempB
  call  SysDivSub
  movf  SysBYTETempA,W
  movwf OUTVALUETEMP
;SerPrintVal = SysCalcTempX
  movf  SYSCALCTEMPX,W
  movwf SERPRINTVAL
;HSerSend(OutValueTemp + 48 ,comport )
  movlw 48
  addwf OUTVALUETEMP,W
  movwf SERDATA
  call  HSERSEND

;Wait USART_DELAY
  movlw 1
  movwf SysWaitTempMS
  clrf  SysWaitTempMS_H
  call  Delay_MS
;End If
ENDIF36
;HSerSend(SerPrintVal + 48 ,comport)
  movlw 48
  addwf SERPRINTVAL,W
  movwf SERDATA
  call  HSERSEND

;Wait USART_DELAY
  movlw 1
  movwf SysWaitTempMS
  clrf  SysWaitTempMS_H
  goto  Delay_MS

;********************************************************************************

HSERPRINTCRLF
;repeat HSerPrintCRLFCount
  movf  HSERPRINTCRLFCOUNT,W
  movwf SysRepeatTemp7
  btfsc STATUS,Z
  goto  SysRepeatLoopEnd7
SysRepeatLoop7
;HSerSend(13,comport)
  movlw 13
  movwf SERDATA
  call  HSERSEND

;Wait USART_DELAY
  movlw 1
  movwf SysWaitTempMS
  clrf  SysWaitTempMS_H
  call  Delay_MS
;HSerSend(10,comport)
  movlw 10
  movwf SERDATA
  call  HSERSEND

;wait USART_DELAY
  movlw 1
  movwf SysWaitTempMS
  clrf  SysWaitTempMS_H
  call  Delay_MS
;end Repeat
  decfsz  SysRepeatTemp7,F
  goto  SysRepeatLoop7
SysRepeatLoopEnd7
  return

;********************************************************************************

HSERSEND
;if comport = 1 Then
  decf  COMPORT,W
  btfss STATUS, Z
  goto  ENDIF31
;Wait While TXIF = Off
SysWaitLoop6
  banksel PIR3
  btfss PIR3,TXIF
  goto  SysWaitLoop6
;Wait While TXIF = Off
SysWaitLoop7
  btfss PIR3,TXIF
  goto  SysWaitLoop7
;TXREG1 = SerData
  banksel SERDATA
  movf  SERDATA,W
  banksel TXREG1
  movwf TXREG1
;end if
ENDIF31
  banksel STATUS
  return

;********************************************************************************

HWSPITRANSFER
;If SPICurrentMode > 10 Then
  movf  SPICURRENTMODE,W
  sublw 10
  btfsc STATUS, C
  goto  ELSE22_1
;Set SSPCON1.WCOL Off
  banksel SSP1CON1
  bcf SSP1CON1,WCOL
;SSPBUF = SPITxData
  banksel SPITXDATA
  movf  SPITXDATA,W
  banksel SSP1BUF
  movwf SSP1BUF
;Else
  goto  ENDIF22
ELSE22_1
;Do
SysDoLoop_S5
;SET SSPCON1.WCOL OFF
  banksel SSP1CON1
  bcf SSP1CON1,WCOL
;SSPBUF = SPITxData
  banksel SPITXDATA
  movf  SPITXDATA,W
  banksel SSP1BUF
  movwf SSP1BUF
;Loop While SSPCON1.WCOL = On
  btfsc SSP1CON1,WCOL
  goto  SysDoLoop_S5
SysDoLoop_E5
;End If
ENDIF22
;Wait While SSPSTAT.BF = Off
SysWaitLoop4
  btfss SSP1STAT,BF
  goto  SysWaitLoop4
;SPIRxData = SSPBUF
  movf  SSP1BUF,W
  banksel SPIRXDATA
  movwf SPIRXDATA
;Set SSPSTAT.BF Off
  banksel SSP1STAT
  bcf SSP1STAT,BF
  banksel STATUS
  return

;********************************************************************************

;Overloaded signature: BYTE:BYTE:
SPIMODE190
;Dim SSPCON1 Alias SSP1CON1 ;added for 18f18855
;Dim SSPSTAT Alias SSP1STAT ;added for 18f18855
;Dim SSPBUF Alias SSP1BUF
;Set SSPCON1.SSPEN Off ;(Prevents any weird glitches during setup)
  banksel SSP1CON1
  bcf SSP1CON1,SSPEN
;Set SSPSTAT.SMP Off
  bcf SSP1STAT,SMP
;Set SSPSTAT.CKE Off
  bcf SSP1STAT,CKE
;If SPIClockMode.0 = Off Then
  banksel SPICLOCKMODE
  btfsc SPICLOCKMODE,0
  goto  ENDIF20
;Set SSPSTAT.CKE On
  banksel SSP1STAT
  bsf SSP1STAT,CKE
;End If
ENDIF20
;Set SSPCON1.CKP Off
  banksel SSP1CON1
  bcf SSP1CON1,CKP
;If SPIClockMode.1 = On Then
  banksel SPICLOCKMODE
  btfss SPICLOCKMODE,1
  goto  ENDIF21
;Set SSPCON1.CKP On
  banksel SSP1CON1
  bsf SSP1CON1,CKP
;End If
ENDIF21
;Set SSPCON1.SSPM3 Off
  banksel SSP1CON1
  bcf SSP1CON1,SSPM3
;Set SSPCON1.SSPM2 Off
  bcf SSP1CON1,SSPM2
;Set SSPCON1.SSPM1 Off
  bcf SSP1CON1,SSPM1
;Set SSPCON1.SSPM0 Off
  bcf SSP1CON1,SSPM0
;Select Case SPICurrentMode
;Case MasterFast
SysSelect2Case1
  movlw 13
  banksel SPICURRENTMODE
  subwf SPICURRENTMODE,W
  btfss STATUS, Z
  goto  SysSelect2Case2
;Case Master
  goto  SysSelectEnd2
SysSelect2Case2
  movlw 12
  subwf SPICURRENTMODE,W
  btfss STATUS, Z
  goto  SysSelect2Case3
;Set SSPCON1.SSPM0 On
  banksel SSP1CON1
  bsf SSP1CON1,SSPM0
;Case MasterSlow
  goto  SysSelectEnd2
SysSelect2Case3
  movlw 11
  subwf SPICURRENTMODE,W
  btfss STATUS, Z
  goto  SysSelect2Case4
;Set SSPCON1.SSPM1 On
  banksel SSP1CON1
  bsf SSP1CON1,SSPM1
;Case Slave
  goto  SysSelectEnd2
SysSelect2Case4
  movf  SPICURRENTMODE,F
  btfss STATUS, Z
  goto  SysSelect2Case5
;Set SSPCON1.SSPM2 On
  banksel SSP1CON1
  bsf SSP1CON1,SSPM2
;Set SSPCON1.SSPM0 On
  bsf SSP1CON1,SSPM0
;Case SlaveSS
  goto  SysSelectEnd2
SysSelect2Case5
  decf  SPICURRENTMODE,W
  btfss STATUS, Z
  goto  SysSelect2Case6
;Set SSPCON1.SSPM2 On
  banksel SSP1CON1
  bsf SSP1CON1,SSPM2
;End Select
SysSelect2Case6
SysSelectEnd2
;Set SSPCON1.SSPEN On
  banksel SSP1CON1
  bsf SSP1CON1,SSPEN
  banksel STATUS
  return

;********************************************************************************

FN_STR
;SysCharCount = 0
  clrf  SYSCHARCOUNT
;Dim SysCalcTempX As Word
;IF SysValTemp >= 10000 then
  movf  SYSVALTEMP,W
  movwf SysWORDTempA
  movf  SYSVALTEMP_H,W
  movwf SysWORDTempA_H
  movlw 16
  movwf SysWORDTempB
  movlw 39
  movwf SysWORDTempB_H
  call  SysCompLessThan16
  comf  SysByteTempX,F
  btfss SysByteTempX,0
  goto  ENDIF23
;SysStrData = SysValTemp / 10000
  movf  SYSVALTEMP,W
  movwf SysWORDTempA
  movf  SYSVALTEMP_H,W
  movwf SysWORDTempA_H
  movlw 16
  movwf SysWORDTempB
  movlw 39
  movwf SysWORDTempB_H
  call  SysDivSub16
  movf  SysWORDTempA,W
  movwf SYSSTRDATA
;SysValTemp = SysCalcTempX
  movf  SYSCALCTEMPX,W
  movwf SYSVALTEMP
  movf  SYSCALCTEMPX_H,W
  movwf SYSVALTEMP_H
;SysCharCount += 1
  incf  SYSCHARCOUNT,F
;Str(SysCharCount) = SysStrData + 48
  movlw low(STR)
  addwf SYSCHARCOUNT,W
  movwf AFSR0
  clrf  SysTemp2
  movlw high(STR)
  addwfc  SysTemp2,W
  movwf AFSR0_H
  movlw 48
  addwf SYSSTRDATA,W
  movwf INDF0
;Goto SysValThousands
  goto  SYSVALTHOUSANDS
;End If
ENDIF23
;IF SysValTemp >= 1000 then
  movf  SYSVALTEMP,W
  movwf SysWORDTempA
  movf  SYSVALTEMP_H,W
  movwf SysWORDTempA_H
  movlw 232
  movwf SysWORDTempB
  movlw 3
  movwf SysWORDTempB_H
  call  SysCompLessThan16
  comf  SysByteTempX,F
  btfss SysByteTempX,0
  goto  ENDIF24
SYSVALTHOUSANDS
;SysStrData = SysValTemp / 1000
  movf  SYSVALTEMP,W
  movwf SysWORDTempA
  movf  SYSVALTEMP_H,W
  movwf SysWORDTempA_H
  movlw 232
  movwf SysWORDTempB
  movlw 3
  movwf SysWORDTempB_H
  call  SysDivSub16
  movf  SysWORDTempA,W
  movwf SYSSTRDATA
;SysValTemp = SysCalcTempX
  movf  SYSCALCTEMPX,W
  movwf SYSVALTEMP
  movf  SYSCALCTEMPX_H,W
  movwf SYSVALTEMP_H
;SysCharCount += 1
  incf  SYSCHARCOUNT,F
;Str(SysCharCount) = SysStrData + 48
  movlw low(STR)
  addwf SYSCHARCOUNT,W
  movwf AFSR0
  clrf  SysTemp2
  movlw high(STR)
  addwfc  SysTemp2,W
  movwf AFSR0_H
  movlw 48
  addwf SYSSTRDATA,W
  movwf INDF0
;Goto SysValHundreds
  goto  SYSVALHUNDREDS
;End If
ENDIF24
;IF SysValTemp >= 100 then
  movf  SYSVALTEMP,W
  movwf SysWORDTempA
  movf  SYSVALTEMP_H,W
  movwf SysWORDTempA_H
  movlw 100
  movwf SysWORDTempB
  clrf  SysWORDTempB_H
  call  SysCompLessThan16
  comf  SysByteTempX,F
  btfss SysByteTempX,0
  goto  ENDIF25
SYSVALHUNDREDS
;SysStrData = SysValTemp / 100
  movf  SYSVALTEMP,W
  movwf SysWORDTempA
  movf  SYSVALTEMP_H,W
  movwf SysWORDTempA_H
  movlw 100
  movwf SysWORDTempB
  clrf  SysWORDTempB_H
  call  SysDivSub16
  movf  SysWORDTempA,W
  movwf SYSSTRDATA
;SysValTemp = SysCalcTempX
  movf  SYSCALCTEMPX,W
  movwf SYSVALTEMP
  movf  SYSCALCTEMPX_H,W
  movwf SYSVALTEMP_H
;SysCharCount += 1
  incf  SYSCHARCOUNT,F
;Str(SysCharCount) = SysStrData + 48
  movlw low(STR)
  addwf SYSCHARCOUNT,W
  movwf AFSR0
  clrf  SysTemp2
  movlw high(STR)
  addwfc  SysTemp2,W
  movwf AFSR0_H
  movlw 48
  addwf SYSSTRDATA,W
  movwf INDF0
;Goto SysValTens
  goto  SYSVALTENS
;End If
ENDIF25
;IF SysValTemp >= 10 Then
  movf  SYSVALTEMP,W
  movwf SysWORDTempA
  movf  SYSVALTEMP_H,W
  movwf SysWORDTempA_H
  movlw 10
  movwf SysWORDTempB
  clrf  SysWORDTempB_H
  call  SysCompLessThan16
  comf  SysByteTempX,F
  btfss SysByteTempX,0
  goto  ENDIF26
SYSVALTENS
;SysStrData = SysValTemp / 10
  movf  SYSVALTEMP,W
  movwf SysWORDTempA
  movf  SYSVALTEMP_H,W
  movwf SysWORDTempA_H
  movlw 10
  movwf SysWORDTempB
  clrf  SysWORDTempB_H
  call  SysDivSub16
  movf  SysWORDTempA,W
  movwf SYSSTRDATA
;SysValTemp = SysCalcTempX
  movf  SYSCALCTEMPX,W
  movwf SYSVALTEMP
  movf  SYSCALCTEMPX_H,W
  movwf SYSVALTEMP_H
;SysCharCount += 1
  incf  SYSCHARCOUNT,F
;Str(SysCharCount) = SysStrData + 48
  movlw low(STR)
  addwf SYSCHARCOUNT,W
  movwf AFSR0
  clrf  SysTemp2
  movlw high(STR)
  addwfc  SysTemp2,W
  movwf AFSR0_H
  movlw 48
  addwf SYSSTRDATA,W
  movwf INDF0
;End If
ENDIF26
;SysCharCount += 1
  incf  SYSCHARCOUNT,F
;Str(SysCharCount) = SysValTemp + 48
  movlw low(STR)
  addwf SYSCHARCOUNT,W
  movwf AFSR0
  clrf  SysTemp2
  movlw high(STR)
  addwfc  SysTemp2,W
  movwf AFSR0_H
  movlw 48
  addwf SYSVALTEMP,W
  movwf INDF0
;SysValTemp = SysCalcTempX
  movf  SYSCALCTEMPX,W
  movwf SYSVALTEMP
  movf  SYSCALCTEMPX_H,W
  movwf SYSVALTEMP_H
;Str(0) = SysCharCount
  movf  SYSCHARCOUNT,W
  banksel SYSSTR_0
  movwf SYSSTR_0
  banksel STATUS
  return

;********************************************************************************

SYSCOMPEQUAL
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;clrf SysByteTempX
  clrf  SYSBYTETEMPX
;movf SysByteTempA, W
  movf  SYSBYTETEMPA, W
;subwf SysByteTempB, W
  subwf SYSBYTETEMPB, W
;btfsc STATUS, Z
  btfsc STATUS, Z
;comf SysByteTempX,F
  comf  SYSBYTETEMPX,F
  return

;********************************************************************************

SYSCOMPEQUAL16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
  clrf  SYSBYTETEMPX
;movf SysWordTempA, W
  movf  SYSWORDTEMPA, W
;subwf SysWordTempB, W
  subwf SYSWORDTEMPB, W
;btfss STATUS, Z
  btfss STATUS, Z
;return
  return
;movf SysWordTempA_H, W
  movf  SYSWORDTEMPA_H, W
;subwf SysWordTempB_H, W
  subwf SYSWORDTEMPB_H, W
;btfss STATUS, Z
  btfss STATUS, Z
;return
  return
;comf SysByteTempX,F
  comf  SYSBYTETEMPX,F
  return

;********************************************************************************

SYSCOMPLESSTHAN
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;clrf SysByteTempX
  clrf  SYSBYTETEMPX
;bsf STATUS, C
  bsf STATUS, C
;movf SysByteTempB, W
  movf  SYSBYTETEMPB, W
;subwf SysByteTempA, W
  subwf SYSBYTETEMPA, W
;btfss STATUS, C
  btfss STATUS, C
;comf SysByteTempX,F
  comf  SYSBYTETEMPX,F
  return

;********************************************************************************

SYSCOMPLESSTHAN16
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
  clrf  SYSBYTETEMPX
;movf SysWordTempA_H,W
  movf  SYSWORDTEMPA_H,W
;subwf SysWordTempB_H,W
  subwf SYSWORDTEMPB_H,W
;btfss STATUS,C
  btfss STATUS,C
;return
  return
;movf SysWordTempB_H,W
  movf  SYSWORDTEMPB_H,W
;subwf SysWordTempA_H,W
  subwf SYSWORDTEMPA_H,W
;btfss STATUS,C
  btfss STATUS,C
;goto SCLT16True
  goto  SCLT16TRUE
;movf SysWordTempB,W
  movf  SYSWORDTEMPB,W
;subwf SysWordTempA,W
  subwf SYSWORDTEMPA,W
;btfsc STATUS,C
  btfsc STATUS,C
;return
  return
SCLT16TRUE
;comf SysByteTempX,F
  comf  SYSBYTETEMPX,F
  return

;********************************************************************************

SYSCOPYSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;movf INDF0, W
  movf  INDF0, W
;movwf SysCalcTempA
  movwf SYSCALCTEMPA
;movwf INDF1
  movwf INDF1
;goto SysCopyStringCheck
  goto  SYSCOPYSTRINGCHECK
SYSCOPYSTRINGPART
;movf INDF0, W
  movf  INDF0, W
;movwf SysCalcTempA
  movwf SYSCALCTEMPA
;addwf SysStringLength, F
  addwf SYSSTRINGLENGTH, F
SYSCOPYSTRINGCHECK
;movf SysCalcTempA,F
  movf  SYSCALCTEMPA,F
;btfsc STATUS,Z
  btfsc STATUS,Z
;return
  return
SYSSTRINGCOPY
;addfsr 0, 1
  addfsr  0, 1
;addfsr 1, 1
  addfsr  1, 1
;movf INDF0, W
  movf  INDF0, W
;movwf INDF1
  movwf INDF1
;decfsz SysCalcTempA, F
  decfsz  SYSCALCTEMPA, F
;goto SysStringCopy
  goto  SYSSTRINGCOPY
  return

;********************************************************************************

SYSDIVSUB
;dim SysByteTempA as byte
;dim SysByteTempB as byte
;dim SysByteTempX as byte
;movf SysByteTempB, F
  movf  SYSBYTETEMPB, F
;btfsc STATUS, Z
  btfsc STATUS, Z
;return
  return
;SysByteTempX = 0
  clrf  SYSBYTETEMPX
;SysDivLoop = 8
  movlw 8
  movwf SYSDIVLOOP
SYSDIV8START
;bcf STATUS, C
  bcf STATUS, C
;rlf SysByteTempA, F
  rlf SYSBYTETEMPA, F
;rlf SysByteTempX, F
  rlf SYSBYTETEMPX, F
;movf SysByteTempB, W
  movf  SYSBYTETEMPB, W
;subwf SysByteTempX, F
  subwf SYSBYTETEMPX, F
;bsf SysByteTempA, 0
  bsf SYSBYTETEMPA, 0
;btfsc STATUS, C
  btfsc STATUS, C
;goto Div8NotNeg
  goto  DIV8NOTNEG
;bcf SysByteTempA, 0
  bcf SYSBYTETEMPA, 0
;movf SysByteTempB, W
  movf  SYSBYTETEMPB, W
;addwf SysByteTempX, F
  addwf SYSBYTETEMPX, F
DIV8NOTNEG
;decfsz SysDivLoop, F
  decfsz  SYSDIVLOOP, F
;goto SysDiv8Start
  goto  SYSDIV8START
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
  movf  SYSWORDTEMPA,W
  movwf SYSDIVMULTA
  movf  SYSWORDTEMPA_H,W
  movwf SYSDIVMULTA_H
;SysDivMultB = SysWordTempB
  movf  SYSWORDTEMPB,W
  movwf SYSDIVMULTB
  movf  SYSWORDTEMPB_H,W
  movwf SYSDIVMULTB_H
;SysDivMultX = 0
  clrf  SYSDIVMULTX
  clrf  SYSDIVMULTX_H
;if SysDivMultB = 0 then
  movf  SYSDIVMULTB,W
  movwf SysWORDTempA
  movf  SYSDIVMULTB_H,W
  movwf SysWORDTempA_H
  clrf  SysWORDTempB
  clrf  SysWORDTempB_H
  call  SysCompEqual16
  btfss SysByteTempX,0
  goto  ENDIF37
;SysWordTempA = 0
  clrf  SYSWORDTEMPA
  clrf  SYSWORDTEMPA_H
;exit sub
  return
;end if
ENDIF37
;SysDivLoop = 16
  movlw 16
  movwf SYSDIVLOOP
SYSDIV16START
;set C off
  bcf STATUS,C
;Rotate SysDivMultA Left
  rlf SYSDIVMULTA,F
  rlf SYSDIVMULTA_H,F
;Rotate SysDivMultX Left
  rlf SYSDIVMULTX,F
  rlf SYSDIVMULTX_H,F
;SysDivMultX = SysDivMultX - SysDivMultB
  movf  SYSDIVMULTB,W
  subwf SYSDIVMULTX,F
  movf  SYSDIVMULTB_H,W
  subwfb  SYSDIVMULTX_H,F
;Set SysDivMultA.0 On
  bsf SYSDIVMULTA,0
;If C Off Then
  btfsc STATUS,C
  goto  ENDIF38
;Set SysDivMultA.0 Off
  bcf SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
  movf  SYSDIVMULTB,W
  addwf SYSDIVMULTX,F
  movf  SYSDIVMULTB_H,W
  addwfc  SYSDIVMULTX_H,F
;End If
ENDIF38
;decfsz SysDivLoop, F
  decfsz  SYSDIVLOOP, F
;goto SysDiv16Start
  goto  SYSDIV16START
;SysWordTempA = SysDivMultA
  movf  SYSDIVMULTA,W
  movwf SYSWORDTEMPA
  movf  SYSDIVMULTA_H,W
  movwf SYSWORDTEMPA_H
;SysWordTempX = SysDivMultX
  movf  SYSDIVMULTX,W
  movwf SYSWORDTEMPX
  movf  SYSDIVMULTX_H,W
  movwf SYSWORDTEMPX_H
  return

;********************************************************************************

SYSREADSTRING
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;call SysStringTables
  call  SYSSTRINGTABLES
;movwf SysCalcTempA
  movwf SYSCALCTEMPA
;movwf INDF1
  movwf INDF1
;goto SysStringReadCheck
  goto  SYSSTRINGREADCHECK
SYSREADSTRINGPART
;call SysStringTables
  call  SYSSTRINGTABLES
;movwf SysCalcTempA
  movwf SYSCALCTEMPA
;addwf SysStringLength,F
  addwf SYSSTRINGLENGTH,F
SYSSTRINGREADCHECK
;movf SysCalcTempA,F
  movf  SYSCALCTEMPA,F
;btfsc STATUS,Z
  btfsc STATUS,Z
;return
  return
SYSSTRINGREAD
;call SysStringTables
  call  SYSSTRINGTABLES
;addfsr 1,1
  addfsr  1,1
;movwf INDF1
  movwf INDF1
;decfsz SysCalcTempA, F
  decfsz  SYSCALCTEMPA, F
;goto SysStringRead
  goto  SYSSTRINGREAD
  return

;********************************************************************************

SysStringTables
  movf  SysStringA_H,W
  movwf PCLATH
  movf  SysStringA,W
  incf  SysStringA,F
  btfsc STATUS,Z
  incf  SysStringA_H,F
  movwf PCL

StringTable2
  retlw 11
  retlw 73  ;I
  retlw 110 ;n
  retlw 105 ;i
  retlw 116 ;t
  retlw 105 ;i
  retlw 97  ;a
  retlw 108 ;l
  retlw 105 ;i
  retlw 115 ;s
  retlw 101 ;e
  retlw 100 ;d


StringTable5
  retlw 29
  retlw 69  ;E
  retlw 78  ;N
  retlw 67  ;C
  retlw 50  ;2
  retlw 56  ;8
  retlw 106 ;j
  retlw 54  ;6
  retlw 48  ;0
  retlw 95  ;_
  retlw 73  ;I
  retlw 110 ;n
  retlw 105 ;i
  retlw 116 ;t
  retlw 40  ;(
  retlw 32  ;
  retlw 105 ;i
  retlw 110 ;n
  retlw 32  ;
  retlw 109 ;m
  retlw 97  ;a
  retlw 99  ;c
  retlw 97  ;a
  retlw 100 ;d
  retlw 100 ;d
  retlw 114 ;r
  retlw 40  ;(
  retlw 41  ;)
  retlw 32  ;
  retlw 41  ;)


StringTable6
  retlw 9
  retlw 80  ;P
  retlw 114 ;r
  retlw 101 ;e
  retlw 32  ;
  retlw 87  ;W
  retlw 65  ;A
  retlw 73  ;I
  retlw 84  ;T
  retlw 49  ;1


StringTable7
  retlw 10
  retlw 112 ;p
  retlw 79  ;O
  retlw 83  ;S
  retlw 84  ;T
  retlw 32  ;
  retlw 87  ;W
  retlw 65  ;A
  retlw 73  ;I
  retlw 84  ;T
  retlw 49  ;1


StringTable8
  retlw 10
  retlw 112 ;p
  retlw 79  ;O
  retlw 83  ;S
  retlw 84  ;T
  retlw 32  ;
  retlw 87  ;W
  retlw 65  ;A
  retlw 73  ;I
  retlw 84  ;T
  retlw 50  ;2


StringTable9
  retlw 8
  retlw 112 ;p
  retlw 79  ;O
  retlw 83  ;S
  retlw 84  ;T
  retlw 32  ;
  retlw 109 ;m
  retlw 97  ;a
  retlw 99  ;c


StringTable10
  retlw 12
  retlw 119 ;w
  retlw 114 ;r
  retlw 105 ;i
  retlw 116 ;t
  retlw 101 ;e
  retlw 80  ;P
  retlw 104 ;h
  retlw 121 ;y
  retlw 82  ;R
  retlw 101 ;e
  retlw 103 ;g
  retlw 49  ;1


StringTable11
  retlw 12
  retlw 119 ;w
  retlw 114 ;r
  retlw 105 ;i
  retlw 116 ;t
  retlw 101 ;e
  retlw 80  ;P
  retlw 104 ;h
  retlw 121 ;y
  retlw 82  ;R
  retlw 101 ;e
  retlw 103 ;g
  retlw 50  ;2


StringTable12
  retlw 9
  retlw 101 ;e
  retlw 88  ;X
  retlw 73  ;I
  retlw 84  ;T
  retlw 32  ;
  retlw 105 ;i
  retlw 110 ;n
  retlw 105 ;i
  retlw 116 ;t


StringTable13
  retlw 1
  retlw 40  ;(


StringTable14
  retlw 1
  retlw 41  ;)


StringTable15
  retlw 21
  retlw 82  ;R
  retlw 101 ;e
  retlw 103 ;g
  retlw 105 ;i
  retlw 115 ;s
  retlw 116 ;t
  retlw 101 ;e
  retlw 114 ;r
  retlw 100 ;d
  retlw 117 ;u
  retlw 109 ;m
  retlw 112 ;p
  retlw 32  ;
  retlw 69  ;E
  retlw 78  ;N
  retlw 67  ;C
  retlw 50  ;2
  retlw 56  ;8
  retlw 106 ;j
  retlw 54  ;6
  retlw 48  ;0


StringTable16
  retlw 9
  retlw 32  ;
  retlw 69  ;E
  retlw 78  ;N
  retlw 67  ;C
  retlw 32  ;
  retlw 82  ;R
  retlw 101 ;e
  retlw 118 ;v
  retlw 32  ;


StringTable17
  retlw 10
  retlw 32  ;
  retlw 66  ;B
  retlw 117 ;u
  retlw 105 ;i
  retlw 108 ;l
  retlw 100 ;d
  retlw 32  ;
  retlw 48  ;0
  retlw 51  ;3
  retlw 55  ;7


StringTable18
  retlw 34
  retlw 67  ;C
  retlw 110 ;n
  retlw 116 ;t
  retlw 114 ;r
  retlw 108 ;l
  retlw 58  ;:
  retlw 32  ;
  retlw 69  ;E
  retlw 67  ;C
  retlw 79  ;O
  retlw 78  ;N
  retlw 49  ;1
  retlw 32  ;
  retlw 69  ;E
  retlw 67  ;C
  retlw 79  ;O
  retlw 78  ;N
  retlw 50  ;2
  retlw 32  ;
  retlw 69  ;E
  retlw 83  ;S
  retlw 84  ;T
  retlw 65  ;A
  retlw 84  ;T
  retlw 32  ;
  retlw 32  ;
  retlw 69  ;E
  retlw 73  ;I
  retlw 82  ;R
  retlw 32  ;
  retlw 32  ;
  retlw 69  ;E
  retlw 73  ;I
  retlw 69  ;E


StringTable19
  retlw 7
  retlw 32  ;
  retlw 32  ;
  retlw 32  ;
  retlw 32  ;
  retlw 32  ;
  retlw 32  ;
  retlw 32  ;


StringTable20
  retlw 4
  retlw 32  ;
  retlw 32  ;
  retlw 32  ;
  retlw 32  ;


StringTable21
  retlw 5
  retlw 32  ;
  retlw 32  ;
  retlw 32  ;
  retlw 32  ;
  retlw 32  ;


StringTable22
  retlw 3
  retlw 32  ;
  retlw 32  ;
  retlw 32  ;


StringTable23
  retlw 42
  retlw 77  ;M
  retlw 65  ;A
  retlw 67  ;C
  retlw 32  ;
  retlw 32  ;
  retlw 58  ;:
  retlw 32  ;
  retlw 77  ;M
  retlw 65  ;A
  retlw 67  ;C
  retlw 79  ;O
  retlw 78  ;N
  retlw 49  ;1
  retlw 32  ;
  retlw 32  ;
  retlw 77  ;M
  retlw 65  ;A
  retlw 67  ;C
  retlw 79  ;O
  retlw 78  ;N
  retlw 51  ;3
  retlw 32  ;
  retlw 32  ;
  retlw 77  ;M
  retlw 65  ;A
  retlw 67  ;C
  retlw 79  ;O
  retlw 78  ;N
  retlw 52  ;4
  retlw 32  ;
  retlw 32  ;
  retlw 77  ;M
  retlw 65  ;A
  retlw 67  ;C
  retlw 45  ;-
  retlw 65  ;A
  retlw 100 ;d
  retlw 100 ;d
  retlw 114 ;r
  retlw 101 ;e
  retlw 115 ;s
  retlw 115 ;s


StringTable24
  retlw 6
  retlw 32  ;
  retlw 32  ;
  retlw 32  ;
  retlw 32  ;
  retlw 32  ;
  retlw 32  ;


StringTable25
  retlw 1
  retlw 46  ;.


StringTable26
  retlw 59
  retlw 82  ;R
  retlw 120 ;x
  retlw 32  ;
  retlw 32  ;
  retlw 32  ;
  retlw 58  ;:
  retlw 32  ;
  retlw 69  ;E
  retlw 82  ;R
  retlw 88  ;X
  retlw 83  ;S
  retlw 84  ;T
  retlw 32  ;
  retlw 32  ;
  retlw 69  ;E
  retlw 82  ;R
  retlw 88  ;X
  retlw 78  ;N
  retlw 68  ;D
  retlw 32  ;
  retlw 32  ;
  retlw 69  ;E
  retlw 82  ;R
  retlw 88  ;X
  retlw 87  ;W
  retlw 82  ;R
  retlw 80  ;P
  retlw 84  ;T
  retlw 32  ;
  retlw 69  ;E
  retlw 82  ;R
  retlw 88  ;X
  retlw 82  ;R
  retlw 68  ;D
  retlw 80  ;P
  retlw 84  ;T
  retlw 32  ;
  retlw 69  ;E
  retlw 82  ;R
  retlw 88  ;X
  retlw 70  ;F
  retlw 67  ;C
  retlw 79  ;O
  retlw 78  ;N
  retlw 32  ;
  retlw 69  ;E
  retlw 80  ;P
  retlw 75  ;K
  retlw 84  ;T
  retlw 67  ;C
  retlw 78  ;N
  retlw 84  ;T
  retlw 32  ;
  retlw 77  ;M
  retlw 65  ;A
  retlw 77  ;M
  retlw 88  ;X
  retlw 70  ;F
  retlw 76  ;L


StringTable27
  retlw 45
  retlw 84  ;T
  retlw 120 ;x
  retlw 32  ;
  retlw 32  ;
  retlw 32  ;
  retlw 58  ;:
  retlw 32  ;
  retlw 69  ;E
  retlw 84  ;T
  retlw 88  ;X
  retlw 83  ;S
  retlw 84  ;T
  retlw 32  ;
  retlw 32  ;
  retlw 69  ;E
  retlw 84  ;T
  retlw 88  ;X
  retlw 78  ;N
  retlw 68  ;D
  retlw 32  ;
  retlw 32  ;
  retlw 69  ;E
  retlw 87  ;W
  retlw 82  ;R
  retlw 80  ;P
  retlw 84  ;T
  retlw 32  ;
  retlw 32  ;
  retlw 77  ;M
  retlw 65  ;A
  retlw 67  ;C
  retlw 76  ;L
  retlw 67  ;C
  retlw 79  ;O
  retlw 78  ;N
  retlw 49  ;1
  retlw 32  ;
  retlw 77  ;M
  retlw 65  ;A
  retlw 67  ;C
  retlw 76  ;L
  retlw 67  ;C
  retlw 79  ;O
  retlw 78  ;N
  retlw 50  ;2


StringTable29
  retlw 2
  retlw 65  ;A
  retlw 41  ;)


StringTable30
  retlw 2
  retlw 58  ;:
  retlw 42  ;*


StringTable31
  retlw 2
  retlw 40  ;(
  retlw 36  ;$


StringTable32
  retlw 2
  retlw 58  ;:
  retlw 41  ;)


StringTable33
  retlw 1
  retlw 60  ;<


StringTable34
  retlw 1
  retlw 62  ;>


StringTable55
  retlw 0


StringTable56
  retlw 1
  retlw 49  ;1


StringTable57
  retlw 1
  retlw 48  ;0


;********************************************************************************

;Start of program memory page 2
  ORG 4096
;Start of program memory page 3
  ORG 6144
;Start of program memory page 4
  ORG 8192
;Start of program memory page 5
  ORG 10240
;Start of program memory page 6
  ORG 12288
;Start of program memory page 7
  ORG 14336
;Start of program memory page 8
  ORG 16384
;Start of program memory page 9
  ORG 18432
;Start of program memory page 10
  ORG 20480
;Start of program memory page 11
  ORG 22528
;Start of program memory page 12
  ORG 24576
;Start of program memory page 13
  ORG 26624
;Start of program memory page 14
  ORG 28672
;Start of program memory page 15
  ORG 30720

 END
