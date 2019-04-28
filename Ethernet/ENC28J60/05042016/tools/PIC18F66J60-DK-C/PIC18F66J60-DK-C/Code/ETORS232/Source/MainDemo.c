/*********************************************************************
 *
 *  Main Application Entry Point and TCP/IP Stack Demo
 *  Module for Microchip TCP/IP Stack
 *   -Demonstrates how to call and use the Microchip TCP/IP stack
 *	 -Reference: AN833
 *
 *********************************************************************
 * FileName:        MainDemo.c
 * Dependencies:    string.H
 *                  StackTsk.h
 *                  Tick.h
 *                  http.h
 *                  MPFS.h
 *				   	mac.h
 * Processor:       PIC18, PIC24F, PIC24H, dsPIC30F, dsPIC33F
 * Complier:        Microchip C18 v3.02 or higher
 *					Microchip C30 v2.05 or higher
 *					HI-TECH PICC-18
 * Company:         Microchip Technology, Inc.
 *
 * Software License Agreement
 *
 * Copyright ?2002-2007 Microchip Technology Inc.  All rights 
 * reserved.
 *
 * Microchip licenses to you the right to use, modify, copy, and 
 * distribute: 
 * (i)  the Software when embedded on a Microchip microcontroller or 
 *      digital signal controller product (“Device? which is 
 *      integrated into Licensee’s product; or
 * (ii) ONLY the Software driver source files ENC28J60.c and 
 *      ENC28J60.h ported to a non-Microchip device used in 
 *      conjunction with a Microchip ethernet controller for the 
 *      sole purpose of interfacing with the ethernet controller. 
 *
 * You should refer to the license agreement accompanying this 
 * Software for additional information regarding your rights and 
 * obligations.
 *
 * THE SOFTWARE AND DOCUMENTATION ARE PROVIDED “AS IS?WITHOUT 
 * WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING WITHOUT 
 * LIMITATION, ANY WARRANTY OF MERCHANTABILITY, FITNESS FOR A 
 * PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT SHALL 
 * MICROCHIP BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR 
 * CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA, COST OF 
 * PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS 
 * BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE 
 * THEREOF), ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER 
 * SIMILAR COSTS, WHETHER ASSERTED ON THE BASIS OF CONTRACT, TORT 
 * (INCLUDING NEGLIGENCE), BREACH OF WARRANTY, OR OTHERWISE.
 *
 *
 * Author              Date         Comment
 *~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 ********************************************************************/
/*
 * Following define uniquely deines this file as main
 * entry/application In whole project, there should only be one such
 * definition and application file must define AppConfig variable as
 * described below.
 */
#define THIS_IS_STACK_APPLICATION

#define VERSION 		"v4.02"		// TCP/IP stack version

// These headers must be included for required defs.
#include "TCPIP Stack/TCPIP.h"
#include "BSP_UART.H"

#define ConfigPortModule        (WORD)1021
#define ConfigPortPC	        (WORD)1022

#define FLASH_CONFIG_ADDRESS    (DWORD)0xF000
#define MAGICWORD       		(WORD)0x5050
#define MAXTCPLINKTIMER			(DWORD)TICK_SECOND*10

#define MODE_UDP            	1
#define MODE_TCP_SERVER     	2
#define MODE_TCP_CLIENT     	3

#define MAXRDY_COM      		512
#define MAXRDY_ETH      		MAC_TX_BUFFER_SIZE
#define CNT_COM					340		//512*3/4

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
#define     LED_LINK    LED1_IO
#define     LED_TRANS   LED0_IO
#define     LED_RUN     LED0_IO


typedef enum _SM_APP
{
    SM_APP_INIT,
    SM_APP_ARP_ASK,
    SM_APP_ARP_RESOLVE,
    SM_APP_UDP_SOCKET,
    SM_APP_UDP,
    SM_APP_TCP_SERVER_SOCKET,
    SM_APP_TCP_SERVER,
    SM_APP_TCP_CLIENT_SOCKET,
    SM_APP_TCP_CLIENT,
    SM_APP_ERROR
} SM_APP;


// Set configuration fuses
#if defined(__18CXX)
	#if defined(__18F66J60)
/*	
		DEBUG = OFF 	Background debugger disabled; RB6 and RB7 configured as general purpose I/O pins  
		XINST = OFF  	Instruction set extension and Indexed Addressing mode disabled (Legacy mode)  
		STVR = ON		Reset on stack overflow/underflow enabled  
		WDT = ON		WDT enabled  
		CP0 = OFF		Program memory is not code-protected  
		FCMEN = ON		Fail-Safe Clock Monitor enabled  
		IESO = ON		Two-Speed Start-up enabled  
		FOSC2 = ON		Clock selected by FOSC1:FOSC0 as system clock is enabled when OSCCON<1:0> = 00  
		FOSC = HSPLL	HS oscillator, PLL enabled and under software control  
		WDTPS = 16		1:16  about 64ms
		ETHLED = ON		RA0/RA1 are multiplexed with LEDA/LEDB when Ethernet module is enabled and function as I/O when Ethernet is disabled  
*/		
		#pragma config DEBUG = ON, XINST=OFF, STVR = ON, WDT=ON, CP0 = OFF, FCMEN = ON, IESO = ON, FOSC2=ON, FOSC=HSPLL, WDTPS = 16, ETHLED=ON
	#else
    	#error " MCU define error";
	#endif
#endif


// Private helper functions.
// These may or may not be present in all applications.
static void InitializeBoard(void);

// application config write and read
static void InitAppConfig(APP_CONFIG *pAppConfig);
static BOOL SaveAppConfig(APP_CONFIG *pAppConfig);
static BOOL LoadAppConfig(APP_CONFIG *pAppConfig);
static void FlashWrite(BYTE* pBuffer, BYTE Len, DWORD Addr);
static BYTE FlashRead(DWORD Addr);
static void FlashErase(DWORD Addr);


// applicaiton task
static void AppTask(void);
// configuration task
static void ConfigTask(void);
static void InitTask(void);



// This is used by other stack elements.
// Main application must define this and initialize it with proper values.
APP_CONFIG AppConfig;

TICK         ExchTimer;

SM_APP       smApp;
UDP_SOCKET   UDPConfigSocket;
UDP_SOCKET   UDPSocket = INVALID_UDP_SOCKET;
TCP_SOCKET   TCPSocket = INVALID_SOCKET;
NODE_INFO	 Remote;
BOOL 		 FlagFirstRun;
MAC_ADDR 	 RemoteMACAddr;
BOOL		 LED_Blink;
TICK		 TCPLinkTimer;

#pragma	udata SEC_BUF		   // locate 0x800
BYTE	Buffer[512];
#pragma udata 			// Return to default section


// NOTE: Several PICs, including the PIC18F4620 revision A3 have a RETFIE FAST/MOVFF bug
// The interruptlow keyword is used to work around the bug when using C18

#pragma interruptlow LowISR
void LowISR(void)
{
    TickUpdate();
}
#pragma code lowVector=0x18
void LowVector(void){_asm goto LowISR _endasm}
#pragma code // Return to default code section




// Main application entry point.
void main(void)
{
    static TICK t = 0;

    // Initialize any application specific hardware.
    InitializeBoard();

    // Initialize all stack related components.
    // Following steps must be performed for all applications using
    // the Microchip TCP/IP Stack.
    TickInit();

    // Initiates board setup process if button is depressed
	// on startup
    if(BUTTON_IO == 0)
    {
      LED_LINK = 0;
      // Initialize AppConfig and save it into flash memory
        InitAppConfig(&AppConfig);
        SaveAppConfig(&AppConfig);
      LED_LINK = 1;
    }
    else
    {
        //read configuration from Flash Memory
        LoadAppConfig(&AppConfig);
        // test the magic flag, if not then initialize, save the config to Flash Memory
        if(AppConfig.MagicWord != MAGICWORD)
        {
            LED_LINK = 0;
            // Initialize AppConfig and save it into flash memory
            InitAppConfig(&AppConfig);
            SaveAppConfig(&AppConfig);
		    LED_LINK = 1;
        }
    }

	// Initialize core stack layers (MAC, ARP, TCP, UDP)
    StackInit();

    FlagFirstRun = TRUE;

    // Once all items are initialized, go into infinite loop and let
    // stack items execute their tasks.
    // If application needs to perform its own task, it should be
    // done at the end of while loop.
    // Note that this is a "co-operative mult-tasking" mechanism
    // where every task performs its tasks (whether all in one shot
    // or part of it) and returns so that other tasks can do their
    // job.
    // If a task needs very long time to do its job, it must be broken
    // down into smaller pieces so that other tasks can have CPU time.
    while(1)
    {

		InitTask();
        // This task performs normal stack task including checking
        // for incoming packet, type of packet and calling
        // appropriate stack entity to process it.
        StackTask();

		 // Configuration Task
        ConfigTask();

        // Application Task
        AppTask();

        // Blink SYSTEM LED every second.
        if( LED_Blink == TRUE)
        {
   			LED_Blink = FALSE;
       		LED_TRANS = 0;
       		t = TickGet();
   		}
       		
       	if ( TickGetDiff(TickGet(), t) >= TICK_SECOND/50 )
       	{
   			LED_TRANS = 1;
       	}
/*
        if ( TickGetDiff(TickGet(), t) >= TICK_SECOND/2 )
        {
            t = TickGet();
            LED_RUN ^= 1;
        }
*/    	
		_asm CLRWDT _endasm
    }
}



/*********************************************************************
 * Function:        void InitializeBoard(void)
 *
 * PreCondition:    None
 *
 * Input:           None
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:        Initialize board specific hardware.
 *
 * Note:            None
 ********************************************************************/
static void InitializeBoard(void)
{
    // PLL enable; Postcaler disabled; PLL prescaler is divided by 3; PLL post
    OSCTUNEbits.PPRE =0;                // PLL Prescaler Configuration bit 0:divide by 2; 1:divide by 3
    OSCTUNEbits.PPST0 = 0;
    OSCTUNEbits.PPST1 = 0;
    OSCTUNEbits.PLLEN = 1;              //enable PLL

	// LEDs IO
	LED0_IO = 1;    //led off
	LED1_IO = 1;    //led off

	LED0_TRIS = 0;		// output
	LED1_TRIS = 0;		// output		

	BUTTON_TRIS = 1;	// input
	
    // UART IO
    UART1TX_TRIS = 0;	// output
    UART1RX_TRIS = 1;	// input

	RCSTA1bits.SPEN = 0;// disable uart commutation
    TXSTA1bits.SYNC = 0;    // asynchronous mode
    TXSTA1bits.BRGH = 1;    // high speed
	BAUDCON1bits.BRG16 = 1; // 16bits

    RCSTA1bits.CREN = 1;    // enable receive
    TXSTA1bits.TXEN = 1;    // tx enable

    // EUSART1 rx int enable
    IPR1bits.RC1IP = 1;             // high priority
    PIE1bits.RC1IE = 1;             // enable

    // EUSART1 tx int enable
    IPR1bits.TX1IP = 1;             // high priority
    PIE1bits.TX1IE = 0;             // disable

	// Enable Interrupts
	RCONbits.IPEN = 1;		// Enable interrupt priorities
    INTCONbits.GIEH = 1;
    INTCONbits.GIEL = 1;

}


/*********************************************************************
 * Function:        void InitTask(void)
 *
 * PreCondition:    Stack is initialized()
 *
 * Input:           None
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:
 *
 * Note:
 ********************************************************************/
static void InitTask(void)
{
    WORD        wRdy;
	BYTE		c;
// config the parameters
    if(FlagFirstRun)
    {
        FlagFirstRun = FALSE;
	
	    MAADR1 = AppConfig.MyMACAddr.v[0]; Nop();
    	MAADR2 = AppConfig.MyMACAddr.v[1]; Nop();
    	MAADR3 = AppConfig.MyMACAddr.v[2]; Nop();
    	MAADR4 = AppConfig.MyMACAddr.v[3]; Nop();
    	MAADR5 = AppConfig.MyMACAddr.v[4]; Nop();
    	MAADR6 = AppConfig.MyMACAddr.v[5]; Nop();

        if(!AppConfig.Flags.bIsDHCPEnabled)
        {
            // Force IP address display update.
            DHCPDisable();
        }
        else
        {
			DHCPEnable();
        	AppConfig.MyIPAddr.Val = 0x00000000ul;
            AppConfig.Flags.bInConfigMode = TRUE;
       		DHCPReset();
       	}

    	ARPInit();
    	
		// close the TCP Socket
	    if(TCPSocket != INVALID_UDP_SOCKET)
	    	TCPDisconnect(TCPSocket);
    	
		// close the UDP Socket
	    if(UDPConfigSocket != INVALID_UDP_SOCKET)
			UDPClose( UDPConfigSocket );
	    if(UDPSocket != INVALID_UDP_SOCKET)
			UDPClose( UDPSocket );

        // Open UDP Socket for Configuration
   	    UDPConfigSocket = UDPOpen(ConfigPortModule, NULL, ConfigPortPC );

        // initialize UART
        UART_Init( AppConfig.UARTBaud );
        smApp = SM_APP_INIT;
    }
}

/*********************************************************************
 * Function:        void ConfigTask(void)
 *
 * PreCondition:    Stack is initialized()
 *
 * Input:           None
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:
 *
 * Note:
 ********************************************************************/

static void ConfigTask(void)
{

#define     CMD_SEARCH_MODULE       (BYTE)0x55u
#define     CMD_GET_CONFIG          (BYTE)0x57u
#define     CMD_SET_CONFIG          (BYTE)0x59u
#define     CMD_ACK                 (BYTE)0x5Au

    BYTE        bCmd;
// config the parameters through ethernet
    if(UDPIsGetReady(UDPConfigSocket)>0)
    {
        UDPGet(&bCmd);
        switch(bCmd){
            case CMD_SEARCH_MODULE:
                UDPDiscard();
                if(UDPIsPutReady(UDPConfigSocket))
                {
	                UDPPutArray( AppConfig.Name, sizeof(AppConfig.Name));
    	            UDPPutArray( (BYTE*)(&AppConfig.MyIPAddr),sizeof(AppConfig.MyIPAddr) );
        	        UDPPutArray( (BYTE*)(&AppConfig.MyMACAddr),sizeof(AppConfig.MyMACAddr) );
            	    UDPFlush();
            	}
                break;
            case CMD_GET_CONFIG:
                if(UDPIsPutReady(UDPConfigSocket))
				{            
					UDPPutArray( (BYTE*)&AppConfig,sizeof(AppConfig) );
    	            UDPFlush();
    	        }
                break;
            case CMD_SET_CONFIG:
                UDPGetArray( (BYTE*)&AppConfig,sizeof(AppConfig) );
                if(UDPIsPutReady(UDPConfigSocket))
				{
	                UDPPut(CMD_ACK);
                	UDPFlush();
	                SaveAppConfig(&AppConfig);
                }
                FlagFirstRun = TRUE;
                break;
        }
    }
}

/*********************************************************************
 * Function:        void AppTask(void)
 *
 * PreCondition:    Stack is initialized()
 *
 * Input:           None
 *
 * Output:          None
 *
 * Side Effects:    None
 *
 * Overview:
 *
 * Note:
 ********************************************************************/
static void AppTask(void)
{
    static TICK         Timer;
    static BYTE         bARPCnt;

    BYTE  		status;
    WORD        wRdy,i;
    CHAR        c;

    if ( !MACIsLinked() )		// mac link is disconnected
    {
        LED_LINK = 1;           //LED off
        smApp = SM_APP_INIT;
        return;
    }

    // in DHCP configuration mode, so any application is skipped
    if( AppConfig.Flags.bIsDHCPEnabled )
    {
        if( AppConfig.Flags.bInConfigMode )
        {
            LED_LINK = 1;           //LED off
            smApp = SM_APP_INIT;
	
            return;
        }
    }

    switch(smApp)
    {
// all initialization mode
        case SM_APP_INIT:
        {
            bARPCnt = 0;

			// close the Socket
	    	TCPInit();
			TCPSocket == INVALID_SOCKET;
			
					
            switch(AppConfig.UARTBaud)
            {
                case UART_BAUD_1200:
                    ExchTimer = TICK_SECOND*5/10;		// 500ms
                    break;
                case UART_BAUD_2400:
                    ExchTimer = TICK_SECOND*5/10;		// 50ms
                    break;
                case UART_BAUD_4800:
                    ExchTimer = TICK_SECOND*4/10;		// 400ms
                    break;
                case UART_BAUD_9600:
                    ExchTimer = TICK_SECOND*2/10;		// 200ms
                    break;
                case UART_BAUD_19200:
                    ExchTimer = TICK_SECOND*1/10;		// 100ms
                    break;
                case UART_BAUD_38400:
                    ExchTimer = TICK_SECOND*6/100;		// 60ms
                    break;
                case UART_BAUD_57600:
                    ExchTimer = TICK_SECOND*4/100;		// 40ms
                    break;
                case UART_BAUD_115200:
                    ExchTimer = TICK_SECOND*2/100;		// 20ms
                    break;
                case UART_BAUD_RATE_230400:
                    ExchTimer = TICK_SECOND/100;		// 10ms
                    break;
                case UART_BAUD_RATE_460800:
                    ExchTimer = TICK_SECOND/200;		// 5ms
                    break;
                default:
                    ExchTimer = TICK_SECOND/100;		// 10ms
                    break;
            }

    		if( AppConfig.ConnectMode == MODE_UDP )
                smApp = SM_APP_ARP_ASK;
    		if( AppConfig.ConnectMode == MODE_TCP_SERVER )
                smApp = SM_APP_TCP_SERVER_SOCKET;
    		else if( AppConfig.ConnectMode == MODE_TCP_CLIENT )
                smApp = SM_APP_ARP_ASK;
            else
            {
                smApp = SM_APP_ARP_ASK;
                AppConfig.ConnectMode == MODE_UDP;
            }
            break;
        }

        // send out ARP packet resolve the host MAC address
        case SM_APP_ARP_ASK:
        {
            ARPResolve( &AppConfig.RemoteIPAddr );
            Timer = TickGet();
            smApp = SM_APP_ARP_RESOLVE;
            break;
        }

        // wait the ARP reply packet
        case SM_APP_ARP_RESOLVE:
        {
            if( ARPIsResolved( &AppConfig.RemoteIPAddr, &RemoteMACAddr ) )
			{
        		if( AppConfig.ConnectMode == MODE_UDP )
                    smApp = SM_APP_UDP_SOCKET;
    	    	else if( AppConfig.ConnectMode == MODE_TCP_CLIENT )
                    smApp = SM_APP_TCP_CLIENT_SOCKET;
    		}
            else
                if ( TickGetDiff(TickGet(), Timer) >= TICK_SECOND )
                {
		            Timer = TickGet();
                    bARPCnt++;
                    smApp = SM_APP_ARP_ASK;
                }
            break;
        }
        
// build the UDP connection for data transfer
        case SM_APP_UDP_SOCKET:
        {
            // Set remote address
        	Remote.MACAddr = RemoteMACAddr;
        	// Set the IP subnet's broadcast address
        	Remote.IPAddr.Val = AppConfig.RemoteIPAddr.Val;

        	// Open a UDP socket for outbound transmission
        	UDPSocket = UDPOpen(AppConfig.MyPortAddr, &Remote, AppConfig.RemotePortAddr);

        	// Abort operation if no UDP sockets are available
        	// If this ever happens, incrementing MAX_UDP_SOCKETS in
        	// StackTsk.h may help (at the expense of more global memory
        	// resources).
        	if( UDPSocket == INVALID_UDP_SOCKET )
        	{
            	smApp = SM_APP_ERROR;
				break;
        	}
            smApp = SM_APP_UDP;
            Timer = TickGet();
            LED_LINK = 0;            // establish the connection
            break;
        }

// UDP data transfer main routines
        case SM_APP_UDP:
        {
            // check if there is a ethernet package
            wRdy = UDPIsGetReady(UDPSocket);
            if(wRdy > 0 )
            {
	            LED_Blink = TRUE;            // LED TRANS Light On

                if( wRdy > MAXRDY_ETH ) wRdy = MAXRDY_ETH;
                
                UDPGetArray(Buffer,wRdy);
                UART_Write(Buffer,wRdy);
                UDPDiscard();
            }

            wRdy = UART_HoldNum();
            if( (wRdy > 0 && ( TickGetDiff(TickGet(), Timer) >= ExchTimer )) ||
                 wRdy > CNT_COM )
            {
                Timer = TickGet();
            	// Make certain the socket can be written to
	    		if( UDPIsPutReady(UDPSocket)>0 )
		    	{
		            LED_Blink = TRUE;            // LED TRANS Light On
                    if( wRdy > MAXRDY_COM ) wRdy = MAXRDY_COM;
                    UART_Read(Buffer,wRdy);
                    UDPPutArray( Buffer, wRdy );
               	    // Send the packet
           			UDPFlush();
                }
            }
            break;
        }

// build the TCP connection for data transfer
        case SM_APP_TCP_SERVER_SOCKET:
        {
            TCPSocket = TCPListen(AppConfig.MyPortAddr);
           	if( TCPSocket != INVALID_SOCKET )
           	{
            	smApp = SM_APP_TCP_SERVER;
   	        }
        	break;
        }

// TCP data transfer main routines
        case SM_APP_TCP_SERVER:
        {
			if(!TCPIsConnected(TCPSocket))
			{
                LED_LINK = 1;
                TCPLinkTimer = TickGet();
				break;
			}
            LED_LINK = 0;            // establish the connection
            
			wRdy = TCPIsGetReady(TCPSocket);
			if( wRdy > 0 )
			{
	            LED_Blink = TRUE;            // LED TRANS Light On

                if( wRdy > MAXRDY_ETH )
                    wRdy = MAXRDY_ETH;

                TCPGetArray(TCPSocket,Buffer,wRdy);
                UART_Write(Buffer,wRdy);
                TCPDiscard(TCPSocket);
                TCPLinkTimer = TickGet();
		    }

            wRdy = UART_HoldNum();
            if( (wRdy > 0 && ( TickGetDiff(TickGet(), Timer) >= ExchTimer )) ||
                 wRdy > CNT_COM )
            {
                Timer = TickGet();
    			// Make certain the socket can be written to
	    		if(TCPIsPutReady(TCPSocket))
		    	{
		            LED_Blink = TRUE;            // LED TRANS Light On

                    if( wRdy > MAXRDY_COM ) wRdy = MAXRDY_COM;

                    UART_Read(Buffer,wRdy);
                    TCPPutArray( TCPSocket, Buffer, wRdy );
           			TCPFlush(TCPSocket);
           			TCPLinkTimer = TickGet();
                }
            }

            if( (TickGet() - TCPLinkTimer) > MAXTCPLINKTIMER )
            {
            	TCPDisconnect(TCPSocket);
            }
        	break;
        }

        case SM_APP_TCP_CLIENT_SOCKET:
        {
        	Remote.IPAddr.Val = AppConfig.RemoteIPAddr.Val;
        	Remote.MACAddr = RemoteMACAddr;

			// Connect a socket to the remote TCP server
			TCPSocket = TCPConnect(&Remote, AppConfig.RemotePortAddr);

			if(TCPSocket == INVALID_SOCKET)
			{
				break;
			}

          	smApp = SM_APP_TCP_CLIENT;
			Timer = TickGet();
			break;
        }

        case SM_APP_TCP_CLIENT:
        {
			// Wait for the remote server to accept our connection request
			if(!TCPIsConnected(TCPSocket))
			{
                LED_LINK = 1;
                TCPLinkTimer = TickGet();
                
				// Time out if too much time is spent in this state
				if(TickGet()-Timer > 2*TICK_SECOND)
				{
					// Close the socket so it can be used by other modules
					TCPDisconnect(TCPSocket);
					TCPSocket = INVALID_SOCKET;
                  	smApp = SM_APP_TCP_CLIENT_SOCKET;
				}
				break;
			}

            LED_LINK = 0;            // establish the connection

			wRdy = TCPIsGetReady(TCPSocket);
			if( wRdy > 0 )
			{
	            LED_Blink = TRUE;            // LED TRANS Light On
                if( wRdy > MAXRDY_ETH ) wRdy = MAXRDY_ETH;

                TCPGetArray(TCPSocket,Buffer,wRdy);
                UART_Write(Buffer,wRdy);
                TCPDiscard(TCPSocket);
                TCPLinkTimer = TickGet();
		    }

            wRdy = UART_HoldNum();
            if( (wRdy > 0 && ( TickGetDiff(TickGet(), Timer) >= ExchTimer )) || wRdy > CNT_COM )
            {
                Timer = TickGet();
    			// Make certain the socket can be written to
	    		if(TCPIsPutReady(TCPSocket))
		    	{
		            LED_Blink = TRUE;            // LED TRANS Light On

                    if( wRdy > MAXRDY_COM ) wRdy = MAXRDY_COM;

                    UART_Read(Buffer,wRdy);
                    TCPPutArray( TCPSocket, Buffer, wRdy );
           			TCPFlush(TCPSocket);	               	    // Send the packet
           			TCPLinkTimer = TickGet();
                }
            }

            if( (TickGet() - TCPLinkTimer) > MAXTCPLINKTIMER )
            {
            	TCPDisconnect(TCPSocket);
            }
			break;
	    }

        case SM_APP_ERROR:

            break;
    }
    return;
}


/*********************************************************************
 * Function:        void InitAppConfig(APP_CONFIG *pAppConfig)
 *
 * PreCondition:
 *
 * Input:           None
 *
 * Output:          Write/Read non-volatile config variables.
 *
 * Side Effects:    None
 *
 * Overview:        None
 *
 * Note:            None
 ********************************************************************/

static void InitAppConfig(APP_CONFIG *pAppConfig)
{
/*
    pAppConfig->ConnectMode = MODE_UDP;
    pAppConfig->Name[0] = 'E';
    pAppConfig->Name[1] = 'T';
    pAppConfig->Name[2] = 'O';
    pAppConfig->Name[3] = 'R';
    pAppConfig->Name[4] = 'S';
    pAppConfig->Name[5] = '2';
    pAppConfig->Name[6] = '3';
    pAppConfig->Name[7] = '2';
    pAppConfig->Name[8] = '_';
    pAppConfig->Name[9] = '0';
    pAppConfig->Name[10] = '0';
    pAppConfig->Name[11] = '0';
    pAppConfig->Name[12] = ' ';
    pAppConfig->Name[13] = ' ';
    pAppConfig->Name[14] = ' ';
    pAppConfig->Name[15] = ' ';

    pAppConfig->MyMACAddr.v[0] = 0x00;
    pAppConfig->MyMACAddr.v[1] = 0x04;
    pAppConfig->MyMACAddr.v[2] = 0xA3;
    pAppConfig->MyMACAddr.v[3] = 0x00;
    pAppConfig->MyMACAddr.v[4] = 0x00;
    pAppConfig->MyMACAddr.v[5] = 0x01;

    pAppConfig->MyIPAddr.v[0] = 172;
    pAppConfig->MyIPAddr.v[1] = 16;
    pAppConfig->MyIPAddr.v[2] = 175;
    pAppConfig->MyIPAddr.v[3] = 149;

    pAppConfig->MyGateway.v[0] = 172;
    pAppConfig->MyGateway.v[1] = 16;
    pAppConfig->MyGateway.v[2] = 175;
    pAppConfig->MyGateway.v[3] = 2;

    pAppConfig->MyMask.v[0] = 255;
    pAppConfig->MyMask.v[1] = 255;
    pAppConfig->MyMask.v[2] = 255;
    pAppConfig->MyMask.v[3] = 0;

    pAppConfig->RemoteIPAddr.v[0] = 172;
    pAppConfig->RemoteIPAddr.v[1] = 16;
    pAppConfig->RemoteIPAddr.v[2] = 175;
    pAppConfig->RemoteIPAddr.v[3] = 129;

    pAppConfig->MyPortAddr = 2001;
    pAppConfig->RemotePortAddr = 2002;

    pAppConfig->UARTBaud = UART_BAUD_115200;

    pAppConfig->Flags.bIsDHCPEnabled = FALSE;

    pAppConfig->MagicWord = MAGICWORD;
*/
    pAppConfig->ConnectMode = MODE_TCP_SERVER;
    pAppConfig->Name[0] = 'E';
    pAppConfig->Name[1] = 'T';
    pAppConfig->Name[2] = 'O';
    pAppConfig->Name[3] = 'R';
    pAppConfig->Name[4] = 'S';
    pAppConfig->Name[5] = '2';
    pAppConfig->Name[6] = '3';
    pAppConfig->Name[7] = '2';
    pAppConfig->Name[8] = '_';
    pAppConfig->Name[9] = '0';
    pAppConfig->Name[10] = '0';
    pAppConfig->Name[11] = '0';
    pAppConfig->Name[12] = ' ';
    pAppConfig->Name[13] = ' ';
    pAppConfig->Name[14] = ' ';
    pAppConfig->Name[15] = ' ';

    pAppConfig->MyMACAddr.v[0] = 0x00;
    pAppConfig->MyMACAddr.v[1] = 0x04;
    pAppConfig->MyMACAddr.v[2] = 0xA3;
    pAppConfig->MyMACAddr.v[3] = 0x00;
    pAppConfig->MyMACAddr.v[4] = 0x00;
    pAppConfig->MyMACAddr.v[5] = 0x01;

    pAppConfig->MyIPAddr.v[0] = 192;
    pAppConfig->MyIPAddr.v[1] = 168;
    pAppConfig->MyIPAddr.v[2] = 1;
    pAppConfig->MyIPAddr.v[3] = 3;

    pAppConfig->MyGateway.v[0] = 192;
    pAppConfig->MyGateway.v[1] = 168;
    pAppConfig->MyGateway.v[2] = 1;
    pAppConfig->MyGateway.v[3] = 1;

    pAppConfig->MyMask.v[0] = 255;
    pAppConfig->MyMask.v[1] = 255;
    pAppConfig->MyMask.v[2] = 255;
    pAppConfig->MyMask.v[3] = 0;

    pAppConfig->RemoteIPAddr.v[0] = 192;
    pAppConfig->RemoteIPAddr.v[1] = 168;
    pAppConfig->RemoteIPAddr.v[2] = 1;
    pAppConfig->RemoteIPAddr.v[3] = 2;

    pAppConfig->MyPortAddr = 2001;
    pAppConfig->RemotePortAddr = 2002;

    pAppConfig->UARTBaud = UART_BAUD_19200;

    pAppConfig->Flags.bIsDHCPEnabled = FALSE;

    pAppConfig->MagicWord = MAGICWORD; 
}

/*********************************************************************
 * Function:        void InitAppConfig(APP_CONFIG *pAppConfig)
 *
 * PreCondition:
 *
 * Input:           None
 *
 * Output:          Write/Read non-volatile config variables.
 *
 * Side Effects:    None
 *
 * Overview:        None
 *
 * Note:            None
 ********************************************************************/
static BOOL SaveAppConfig(APP_CONFIG *pAppConfig)
{

//	BYTE ReadBuf[64];
//	BYTE *p;
//	BYTE i;
//	BOOL f;

	FlashErase(FLASH_CONFIG_ADDRESS);
	FlashWrite((BYTE*)pAppConfig, sizeof(APP_CONFIG),FLASH_CONFIG_ADDRESS);

    return TRUE;

//	p=ReadBuf;
//	for( i = 0; i < sizeof(APP_CONFIG); i++)
//    	*p++ = FlashRead( FLASH_CONFIG_ADDRESS + i );

//	f=memcmppgm2ram( ReadBuf, pAppConfig, sizeof(APP_CONFIG) );
//	return f;
}

/*********************************************************************
 * Function:        void InitAppConfig(APP_CONFIG *pAppConfig)
 *
 * PreCondition:
 *
 * Input:           None
 *
 * Output:          Write/Read non-volatile config variables.
 *
 * Side Effects:    None
 *
 * Overview:        None
 *
 * Note:            None
 ********************************************************************/
static BOOL LoadAppConfig(APP_CONFIG *pAppConfig)
{
	BYTE i;
	BYTE* p;
	p = (BYTE*)pAppConfig;

	for( i=0; i < sizeof(APP_CONFIG);i++)
	    *p++ = FlashRead( FLASH_CONFIG_ADDRESS + i );

    return TRUE;
}



/*********************************************************************
 * Function:
 *
 * PreCondition:    None
 *
 * Input:           None
 *
 * Output:
 *
 * Side Effects:    None
 *
 * Overview:        None
 *
 * Note:            None
 ********************************************************************/
static void FlashErase(DWORD Addr)
{
		TBLPTR=Addr;			
		INTCONbits.GIE=0;		

		EECON1bits.WREN=1;
		EECON1bits.FREE=1;

		INTCONbits.GIE=0;
		EECON1bits.WREN=1;
		EECON2=0x55;
		EECON2=0xAA;
		EECON1bits.WR=1;	

		EECON1bits.WREN=0;					
		while(EECON1bits.WR);
		EECON1bits.FREE=0;

		INTCONbits.GIE=1;
	}


/*********************************************************************
 * Function:
 *
 * PreCondition:    None
 *
 * Input:           None
 *
 * Output:
 *
 * Side Effects:    None
 *
 * Overview:        None
 *
 * Note:            None
 ********************************************************************/
static void FlashWrite(BYTE* pBuffer, BYTE Len, DWORD Addr)
{

	TBLPTRL=(BYTE)((Addr)&0xFF);
	TBLPTRH=(BYTE)(((Addr)>>8)&0xFF);
	TBLPTRU=(BYTE)( Addr >> 16 );
	EECON1=0;
	while(Len--)
		{

		TABLAT=*pBuffer++;
			_asm
			TBLWTPOSTINC
			_endasm
		}
	TBLPTRL=(BYTE)(Addr & 0xFF);
	TBLPTRH=(BYTE)(((Addr)>>8) & 0xFF);
	TBLPTRU=(BYTE)( Addr >> 16);
	EECON1bits.WREN=1;		// this is the required sequence
	INTCONbits.GIE=0;
	EECON2=0x55;
	EECON2=0xAA;
	EECON1bits.WR=1;
	while(EECON1bits.WR);
	EECON1bits.WREN=0;
	INTCONbits.GIE=1;
}

/*********************************************************************
 * Function:
 *
 * PreCondition:    None
 *
 * Input:           None
 *
 * Output:
 *
 * Side Effects:    None
 *
 * Overview:        None
 *
 * Note:            None
 ********************************************************************/
static BYTE FlashRead(DWORD Addr)
{
	TBLPTRL=(BYTE)((Addr)&0xFF);
	TBLPTRH=(BYTE)(((Addr)>>8)&0xFF);
	TBLPTRU=(BYTE)( Addr >> 16 );
	_asm
	TBLRDPOSTINC
	_endasm
	return TABLAT;
}