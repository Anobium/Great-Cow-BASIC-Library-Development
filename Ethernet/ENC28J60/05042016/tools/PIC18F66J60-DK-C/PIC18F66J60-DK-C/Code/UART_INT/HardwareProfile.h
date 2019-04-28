/*********************************************************************
 *
 *	Hardware specific definitions
 *
 *********************************************************************
 * FileName:        HardwareProfile.h
 * Dependencies:    None
 * Processor:       PIC18, PIC24F, PIC24H, dsPIC30F, dsPIC33F
 * Complier:        Microchip C18 v3.10 or higher
 *					Microchip C30 v2.05 or higher
 * Company:         Microchip Technology, Inc.
 *
 * Software License Agreement
 *
 * Copyright © 2002-2007 Microchip Technology Inc.  All rights 
 * reserved.
 *
 * Microchip licenses to you the right to use, modify, copy, and 
 * distribute: 
 * (i)  the Software when embedded on a Microchip microcontroller or 
 *      digital signal controller product (“Device”) which is 
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
 * THE SOFTWARE AND DOCUMENTATION ARE PROVIDED “AS IS” WITHOUT 
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
 * Author               Date		Comment
 *~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * Howard Schlunder		10/03/06	Original, copied from Compiler.h
 ********************************************************************/
#ifndef __HARDWARE_PROFILE_H
#define __HARDWARE_PROFILE_H

// Choose which hardware profile to compile for here.  See 
// the hardware profiles below for meaning of various options.  
//#define PICDEMNET2
//#define HPC_EXPLORER
//#define PICDEMZ
//#define PIC18F67J60_TEST_BOARD
//#define FS_USB			// Not supported - too little RAM/ROM
//#define PICDEMNET			// Not supported - too little RAM/ROM
//#define EXPLORER_16
//#define DSPICDEM11
//#define DSPICDEMNET1		// Not currently supported
//#define DSPICDEMNET2		// Not currently supported
#define ETORS232

// If no hardware profiles are defined, assume that we are using 
// a Microchip demo board and try to auto-select the correct profile
// based on processor selected in MPLAB
#if !defined(PICDEMNET2) && !defined(HPC_EXPLORER) && !defined(PICDEMZ) && !defined(FS_USB) && !defined(PICDEMNET) && !defined(EXPLORER_16) && !defined(DSPICDEM11) && !defined(DSPICDEMNET1) && !defined(DSPICDEMNET2) && !defined(PICDEMNET2) && !defined(PIC18F67J60_TEST_BOARD) && !defined(ETORS232)
	#if defined(__18F97J60) || defined(_18F97J60)
		#define PICDEMNET2
	#elif defined(__18F67J60) || defined(_18F67J60)
		#define PIC18F67J60_TEST_BOARD
	#elif defined(__18F8722) || defined(__18F87J10) || defined(_18F8722) || defined(_18F87J10)
		#define HPC_EXPLORER
	#elif defined(__18F4620) || defined(_18F4620)
		#define PICDEMZ
	#elif defined(__PIC24F__) || defined(__PIC24H__) || defined(__dsPIC33F__)
		#define EXPLORER_16
	#elif defined(__dsPIC30F__)
		#define DSPICDEM11
	#elif defined(__18F452) || defined(_18F452)
		#define PICDEMNET
	#endif
#endif

// Clock frequency value.
// This value is used to calculate Tick Counter value
#if defined(__18CXX) || defined(HI_TECH_C)	
	// All PIC18 processors
	#if defined(PICDEMNET2) || defined(PIC18F67J60_TEST_BOARD)
		#define CLOCK_FREQ		(41666667)      // Hz
	#elif defined(FS_USB)
		#define CLOCK_FREQ		(48000000)      // Hz
	#elif defined(PICDEMNET)
//		#define CLOCK_FREQ		(40000000)      // Hz
		#define CLOCK_FREQ		(19660800)      // Hz
	#elif defined(PICDEMZ)
		#define CLOCK_FREQ		(16000000)		// Hz
//		#define CLOCK_FREQ		(25000000)		// Using ENC28J60 Clockout
	#elif defined(ETORS232)
		#define CLOCK_FREQ		(41666667)      // Hz
	#else
		#define CLOCK_FREQ		(40000000)      // Hz
	#endif
#elif defined(__PIC24F__)	
	// PIC24F processor
	#define CLOCK_FREQ			(32000000)      // Hz
#elif defined(__PIC24H__)	
	// PIC24H processor
	#define CLOCK_FREQ			(80000000)      // Hz
#elif defined(__dsPIC33F__)	
	// dsPIC33F processor
	#define CLOCK_FREQ			(80000000)      // Hz
#elif defined(__dsPIC30F__)
	// dsPIC30F processor
	#define CLOCK_FREQ			(117920000)      // Hz
#endif

// Hardware mappings
#if defined(HPC_EXPLORER) && !defined(HI_TECH_C)
// PICDEM HPC Explorer + Ethernet PICtail
	// I/O pins
	#define LED0_TRIS			(TRISDbits.TRISD0)
	#define LED0_IO				(PORTDbits.RD0)
	#define LED1_TRIS			(TRISDbits.TRISD1)
	#define LED1_IO				(PORTDbits.RD1)
	#define LED2_TRIS			(TRISDbits.TRISD2)
	#define LED2_IO				(PORTDbits.RD2)
	#define LED3_TRIS			(TRISDbits.TRISD3)
	#define LED3_IO				(PORTDbits.RD3)
	#define LED4_TRIS			(TRISDbits.TRISD4)
	#define LED4_IO				(PORTDbits.RD4)
	#define LED5_TRIS			(TRISDbits.TRISD5)
	#define LED5_IO				(PORTDbits.RD5)
	#define LED6_TRIS			(TRISDbits.TRISD6)
	#define LED6_IO				(PORTDbits.RD6)
	#define LED7_TRIS			(TRISDbits.TRISD7)
	#define LED7_IO				(PORTDbits.RD7)
	#define LED_IO				(*((volatile unsigned char*)(&PORTD)))


	#define BUTTON0_TRIS		(TRISBbits.TRISB0)
	#define	BUTTON0_IO			(PORTBbits.RB0)
	#define BUTTON1_TRIS		(TRISBbits.TRISB0)	// No Button1 on this board, remap to Button0
	#define	BUTTON1_IO			(PORTBbits.RB0)
	#define BUTTON2_TRIS		(TRISBbits.TRISB0)	// No Button2 on this board, remap to Button0
	#define	BUTTON2_IO			(PORTBbits.RB0)
	#define BUTTON3_TRIS		(TRISBbits.TRISB0)	// No Button3 on this board, remap to Button0
	#define	BUTTON3_IO			(PORTBbits.RB0)

	// ENC28J60 I/O pins
	#define ENC_RST_TRIS		(TRISBbits.TRISB5)
	#define ENC_RST_IO			(LATBbits.LATB5)
	#define ENC_CS_TRIS			(TRISBbits.TRISB3)
	#define ENC_CS_IO			(LATBbits.LATB3)
	#define ENC_SCK_TRIS		(TRISCbits.TRISC3)
	#define ENC_SDI_TRIS		(TRISCbits.TRISC4)
	#define ENC_SDO_TRIS		(TRISCbits.TRISC5)
	#define ENC_SPI_IF			(PIR1bits.SSPIF)
	#define ENC_SSPBUF			(SSPBUF)
	#define ENC_SPISTAT			(SSP1STAT)
	#define ENC_SPISTATbits		(SSP1STATbits)
	#define ENC_SPICON1			(SSP1CON1)
	#define ENC_SPICON1bits		(SSP1CON1bits)
	#define ENC_SPICON2			(SSP1CON2)

	// 25LC256 I/O pins
	#define EEPROM_CS_TRIS		(TRISBbits.TRISB4)
	#define EEPROM_CS_IO		(LATBbits.LATB4)
	#define EEPROM_SCK_TRIS		(TRISCbits.TRISC3)
	#define EEPROM_SDI_TRIS		(TRISCbits.TRISC4)
	#define EEPROM_SDO_TRIS		(TRISCbits.TRISC5)
	#define EEPROM_SPI_IF		(PIR1bits.SSPIF)
	#define EEPROM_SSPBUF		(SSPBUF)
	#define EEPROM_SPICON1		(SSP1CON1)
	#define EEPROM_SPICON1bits	(SSP1CON1bits)
	#define EEPROM_SPICON2		(SSP1CON2)
	#define EEPROM_SPISTAT		(SSP1STAT)
	#define EEPROM_SPISTATbits	(SSP1STATbits)

#elif defined(HPC_EXPLORER) && defined(HI_TECH_C)
// PICDEM HPC Explorer + Ethernet PICtail
	typedef struct
	{
	    unsigned char BF:1;
	    unsigned char UA:1;
	    unsigned char R_W:1;
	    unsigned char S:1;
	    unsigned char P:1;
	    unsigned char D_A:1;
	    unsigned char CKE:1;
	    unsigned char SMP:1;
	} SSPSTATbits;
	typedef struct 
	{
	    unsigned char RBIF:1;
	    unsigned char INT0IF:1;
	    unsigned char TMR0IF:1;
		unsigned char RBIE:1;
	    unsigned char INT0IE:1;
	    unsigned char TMR0IE:1;
	    unsigned char GIEL:1;
	    unsigned char GIEH:1;
	} INTCONbits;
	typedef struct 
	{
	    unsigned char RBIP:1;
	    unsigned char INT3IP:1;
	    unsigned char TMR0IP:1;
	    unsigned char INTEDG3:1;
	    unsigned char INTEDG2:1;
	    unsigned char INTEDG1:1;
	    unsigned char INTEDG0:1;
	    unsigned char RBPU:1;
	} INTCON2bits;
	typedef struct 
	{
	    unsigned char ADON:1;
	    unsigned char GO:1;
	    unsigned char CHS0:1;
	    unsigned char CHS1:1;
	    unsigned char CHS2:1;
	    unsigned char CHS3:1;
	} ADCON0bits;
	typedef struct 
	{
		unsigned char ADCS0:1;
		unsigned char ADCS1:1;
		unsigned char ADCS2:1;
		unsigned char ACQT0:1;
		unsigned char ACQT1:1;
		unsigned char ACQT2:1;
		unsigned char :1;
		unsigned char ADFM:1;
	} ADCON2bits;
	typedef struct 
	{
	    unsigned char TMR1IF:1;
	    unsigned char TMR2IF:1;
	    unsigned char CCP1IF:1;
	    unsigned char SSPIF:1;
	    unsigned char TXIF:1;
	    unsigned char RCIF:1;
	    unsigned char ADIF:1;
	    unsigned char PSPIF:1;
	} PIR1bits;
	typedef struct 
	{
	    unsigned char TMR1IE:1;
	    unsigned char TMR2IE:1;
	    unsigned char CCP1IE:1;
	    unsigned char SSPIE:1;
	    unsigned char TXIE:1;
	    unsigned char RCIE:1;
	    unsigned char ADIE:1;
	    unsigned char PSPIE:1;
	} PIE1bits;
	typedef struct
	{
		unsigned char IPEN:1;
		unsigned char :1;
		unsigned char CM:1;
		unsigned char RI:1;
		unsigned char TO:1;
		unsigned char PD:1;
		unsigned char POR:1;
		unsigned char BOR:1;
	} RCONbits;
	typedef struct
	{
	    unsigned char T0PS0:1;
	    unsigned char T0PS1:1;
	    unsigned char T0PS2:1;
	    unsigned char PSA:1;
	    unsigned char T0SE:1;
	    unsigned char T0CS:1;
	    unsigned char T08BIT:1;
	    unsigned char TMR0ON:1;
	} T0CONbits;
	typedef struct
	{
	    unsigned char TX9D:1;
	    unsigned char TRMT:1;
	    unsigned char BRGH:1;
	    unsigned char SENDB:1;
	    unsigned char SYNC:1;
	    unsigned char TXEN:1;
	    unsigned char TX9:1;
	    unsigned char CSRC:1;
	} TXSTAbits;
	typedef struct
	{
	    unsigned char RX9D:1;
	    unsigned char OERR:1;
	    unsigned char FERR:1;
	    unsigned char ADDEN:1;
	    unsigned char CREN:1;
	    unsigned char SREN:1;
	    unsigned char RX9:1;
	    unsigned char SPEN:1;
	} RCSTAbits;
	
	#define TXSTA				TXSTA1
	#define RCSTA				RCSTA1
	#define SPBRG				SPBRG1
	#define RCREG				RCREG1
	#define TXREG				TXREG1

	// I/O pins
	#define LED0_TRIS			(TRISD0)
	#define LED0_IO				(RD0)
	#define LED1_TRIS			(TRISD1)
	#define LED1_IO				(RD1)
	#define LED2_TRIS			(TRISD2)
	#define LED2_IO				(RD2)
	#define LED3_TRIS			(TRISD3)
	#define LED3_IO				(RD3)
	#define LED4_TRIS			(TRISD4)
	#define LED4_IO				(RD4)
	#define LED5_TRIS			(TRISD5)
	#define LED5_IO				(RD5)
	#define LED6_TRIS			(TRISD6)
	#define LED6_IO				(RD6)
	#define LED7_TRIS			(TRISD7)
	#define LED7_IO				(RD7)
	#define LED_IO				(*((volatile unsigned char*)(&PORTD)))

	#define BUTTON0_TRIS		(TRISB0)
	#define	BUTTON0_IO			(RB0)
	#define BUTTON1_TRIS		(TRISB0)	// No Button1 on this board, remap to Button0
	#define	BUTTON1_IO			(RB0)
	#define BUTTON2_TRIS		(TRISB0)	// No Button2 on this board, remap to Button0
	#define	BUTTON2_IO			(RB0)
	#define BUTTON3_TRIS		(TRISB0)	// No Button3 on this board, remap to Button0
	#define	BUTTON3_IO			(RB0)

	// ENC28J60 I/O pins
	#define ENC_RST_TRIS		(TRISB5)
	#define ENC_RST_IO			(LATB5)
	#define ENC_CS_TRIS			(TRISB3)
	#define ENC_CS_IO			(LATB3)
	#define ENC_SCK_TRIS		(TRISC3)
	#define ENC_SDI_TRIS		(TRISC4)
	#define ENC_SDO_TRIS		(TRISC5)
	#define ENC_SPI_IF			(SSP1IF)
	#define ENC_SSPBUF			(SSP1BUF)
	#define ENC_SPISTAT			(SSP1STAT)
	#define ENC_SPISTATbits		(*((SSPSTATbits*)&SSP1STAT))
	#define ENC_SPICON1			(SSP1CON1)
	#define ENC_SPICON1bits		(*((SSPCON1bits*)&SSP1CON))
	#define ENC_SPICON2			(SSP1CON2)

	// 25LC256 I/O pins
	#define EEPROM_CS_TRIS		(TRISB4)
	#define EEPROM_CS_IO		(LATB4)
	#define EEPROM_SCK_TRIS		(TRISC3)
	#define EEPROM_SDI_TRIS		(TRISC4)
	#define EEPROM_SDO_TRIS		(TRISC5)
	#define EEPROM_SPI_IF		(SSP1IF)
	#define EEPROM_SSPBUF		(SSP1BUF)
	#define EEPROM_SPICON1		(SSP1CON1)
	#define EEPROM_SPICON1bits	(*((SSPCON1bits*)&SSP1CON))
	#define EEPROM_SPICON2		(SSP1CON2)
	#define EEPROM_SPISTAT		(SSP1STAT)
	#define EEPROM_SPISTATbits	(*((SSPSTATbits*)&SSP1STAT))

	#define INTCONbits			(*((INTCONbits*)&INTCON))
	#define INTCON2bits			(*((INTCON2bits*)&INTCON2))
	#define ADCON0bits			(*((ADCON0bits*)&ADCON0))
	#define ADCON2bits			(*((ADCON2bits*)&ADCON2))
	#define PIR1bits			(*((PIR1bits*)&PIR1))
	#define PIE1bits			(*((PIE1bits*)&PIE1))
	#define RCONbits			(*((RCONbits*)&RCON))
	#define T0CONbits			(*((T0CONbits*)&T0CON))
	#define TXSTAbits			(*((TXSTAbits*)&TXSTA1))
	#define RCSTAbits			(*((RCSTAbits*)&RCSTA1))

#elif defined(PICDEMZ) && !defined(HI_TECH_C)
// PICDEM Z + Ethernet PICtail
	// I/O pins
	#define LED0_TRIS			(TRISAbits.TRISA1)
	#define LED0_IO				(PORTAbits.RA1)
	#define LED1_TRIS			(TRISAbits.TRISA0)
	#define LED1_IO				(PORTAbits.RA0)
	#define LED2_TRIS			(TRISAbits.TRISA1)
	#define LED2_IO				(PORTAbits.RA1)
	#define LED3_TRIS			(TRISAbits.TRISA0)
	#define LED3_IO				(PORTAbits.RA0)
	#define LED4_TRIS			(TRISAbits.TRISA1)
	#define LED4_IO				(PORTAbits.RA1)
	#define LED5_TRIS			(TRISAbits.TRISA0)
	#define LED5_IO				(PORTAbits.RA0)
	#define LED6_TRIS			(TRISAbits.TRISA1)
	#define LED6_IO				(PORTAbits.RA1)
	#define LED7_TRIS			(TRISAbits.TRISA0)
	#define LED7_IO				(PORTAbits.RA0)

	#define BUTTON0_TRIS		(TRISBbits.TRISB5)  // Button0 is connected to EEPROM_CS on this board, remap to Button1
	#define	BUTTON0_IO			(PORTBbits.RB5)
	#define BUTTON1_TRIS		(TRISBbits.TRISB5)
	#define	BUTTON1_IO			(PORTBbits.RB5)
	#define BUTTON2_TRIS		(TRISBbits.TRISB5)	// No Button2 on this board, remap to Button1
	#define	BUTTON2_IO			(PORTBbits.RB5)
	#define BUTTON3_TRIS		(TRISBbits.TRISB5)	// No Button3 on this board, remap to Button1
	#define	BUTTON3_IO			(PORTBbits.RB5)

	// ENC28J60 I/O pins
	#define ENC_CS_TRIS			(TRISBbits.TRISB3)
	#define ENC_CS_IO			(LATBbits.LATB3)
	#define ENC_SCK_TRIS		(TRISCbits.TRISC3)
	#define ENC_SDI_TRIS		(TRISCbits.TRISC4)
	#define ENC_SDO_TRIS		(TRISCbits.TRISC5)
	#define ENC_SPI_IF			(PIR1bits.SSPIF)
	#define ENC_SSPBUF			(SSPBUF)
	#define ENC_SPISTAT			(SSPSTAT)
	#define ENC_SPISTATbits		(SSPSTATbits)
	#define ENC_SPICON1			(SSPCON1)
	#define ENC_SPICON1bits		(SSPCON1bits)
	#define ENC_SPICON2			(SSPCON2)

	// 25LC256 I/O pins
	#define EEPROM_CS_TRIS		(TRISBbits.TRISB4)
	#define EEPROM_CS_IO		(LATBbits.LATB4)
	#define EEPROM_SCK_TRIS		(TRISCbits.TRISC3)
	#define EEPROM_SDI_TRIS		(TRISCbits.TRISC4)
	#define EEPROM_SDO_TRIS		(TRISCbits.TRISC5)
	#define EEPROM_SPI_IF		(PIR1bits.SSPIF)
	#define EEPROM_SSPBUF		(SSPBUF)
	#define EEPROM_SPICON1		(SSPCON1)
	#define EEPROM_SPICON1bits	(SSPCON1bits)
	#define EEPROM_SPICON2		(SSPCON2)
	#define EEPROM_SPISTAT		(SSPSTAT)
	#define EEPROM_SPISTATbits	(SSPSTATbits)

#elif defined(FS_USB) && !defined(HI_TECH_C)
// NOTE: THIS IS A WORK IN PROGRESS
// PICDEM FS USB demo board support still needs more work
// PICDEM FS USB + Ethernet PICtail
// To use the PICDEM FS USB board, you must :
// 1. On Ethernet PICtail, cut the traces under J5, J6, and J7, install jumper headers, and place jumper shunts on pins 2-3, 2-3, and 2-3.
// 2. On PICDEM FS USB, cut trace under JP3 to prevent SDO and MAX232 RX output bus contention
// 3. Remove all UART code in the stack.  The SPI and UART share the same PIC18F4550 pins, so you must disable the UART and not use it.
// 4. RAM and ROM are tight on the PIC18F4550.  Need to unprotect several USB RAM banks and enable all C18 compiler optimizations (especially procedural abstraction), or remove a bunch of stack modules.

	// I/O pins
	#define LED0_TRIS			(TRISDbits.TRISD3)
	#define LED0_IO				(PORTDbits.RD3)
	#define LED1_TRIS			(TRISDbits.TRISD2)
	#define LED1_IO				(PORTDbits.RD2)
	#define LED2_TRIS			(TRISDbits.TRISD1)
	#define LED2_IO				(PORTDbits.RD1)
	#define LED3_TRIS			(TRISDbits.TRISD0)
	#define LED3_IO				(PORTDbits.RD0)
	#define LED4_TRIS			(TRISDbits.TRISD3)	// No LED remap to LED0
	#define LED4_IO				(PORTDbits.RD3)
	#define LED5_TRIS			(TRISDbits.TRISD2)	// No LED remap to LED1
	#define LED5_IO				(PORTDbits.RD2)
	#define LED6_TRIS			(TRISDbits.TRISD1)	// No LED remap to LED2
	#define LED6_IO				(PORTDbits.RD1)
	#define LED7_TRIS			(TRISDbits.TRISD0)	// No LED remap to LED3
	#define LED7_IO				(PORTDbits.RD0)


	#define BUTTON0_TRIS		(TRISBbits.TRISB5)
	#define	BUTTON0_IO			(PORTBbits.RB5)
	#define BUTTON1_TRIS		(TRISBbits.TRISB4)
	#define	BUTTON1_IO			(PORTBbits.RB4)
	#define BUTTON2_TRIS		(TRISBbits.TRISB5)	// No Button2 on this board, remap to Button0
	#define	BUTTON2_IO			(PORTBbits.RB5)
	#define BUTTON3_TRIS		(TRISBbits.TRISB4)	// No Button3 on this board, remap to Button0
	#define	BUTTON3_IO			(PORTBbits.RB4)

	// ENC28J60 I/O pins
	#define ENC_RST_TRIS		(TRISBbits.TRISB5)
	#define ENC_RST_IO			(LATBbits.LATB5)
	#define ENC_CS_TRIS			(TRISBbits.TRISB3)
	#define ENC_CS_IO			(LATBbits.LATB3)
	#define ENC_SCK_TRIS		(TRISBbits.TRISB1)
	#define ENC_SDI_TRIS		(TRISBbits.TRISB0)
	#define ENC_SDO_TRIS		(TRISCbits.TRISC7)
	#define ENC_SPI_IF			(PIR1bits.SSPIF)
	#define ENC_SSPBUF			(SSPBUF)
	#define ENC_SPISTAT			(SSPSTAT)
	#define ENC_SPISTATbits		(SSPSTATbits)
	#define ENC_SPICON1			(SSPCON1)
	#define ENC_SPICON1bits		(SSPCON1bits)
	#define ENC_SPICON2			(SSPCON2)

	// 25LC256 I/O pins
	#define EEPROM_CS_TRIS		(TRISBbits.TRISB4)
	#define EEPROM_CS_IO		(LATBbits.LATB4)
	#define EEPROM_SCK_TRIS		(TRISBbits.TRISB1)
	#define EEPROM_SDI_TRIS		(TRISBbits.TRISB0)
	#define EEPROM_SDO_TRIS		(TRISCbits.TRISC7)
	#define EEPROM_SPI_IF		(PIR1bits.SSPIF)
	#define EEPROM_SSPBUF		(SSPBUF)
	#define EEPROM_SPICON1		(SSPCON1)
	#define EEPROM_SPICON1bits	(SSPCON1bits)
	#define EEPROM_SPICON2		(SSPCON2)
	#define EEPROM_SPISTAT		(SSPSTAT)
	#define EEPROM_SPISTATbits	(SSPSTATbits)

#elif defined(PICDEMNET) && !defined(HI_TECH_C)
// PICDEM.net (classic) board with Realtek RTL8019AS Ethernet controller
// It is strongly recommended that the PIC18F452 that came installed 
// on the PICDEM.net be removed and a PIC18F4620 be installed in its 
// place.  The PIC18F4620 has twice the FLASH, substantially more 
// RAM, and as a result can support all of the latest TCP/IP stack 
// modules compiled all at once.  The PIC18F4620 also has superior 
// peripherals that are natively supported by the stack.
//
// If using the PIC18F452, you most likely have to use the modified 
// 18f452i.lkr linker script and turn on all C18 compiler optimizations, 
// including procedural abstraction to get the project to compile.  The 
// stack ROM/RAM memory usage is right at the limits of the 18F452.
	// I/O pins
	#define LED0_TRIS			(TRISAbits.TRISA4)
	#define LED0_IO				(PORTAbits.RA4)
	#define LED1_TRIS			(TRISAbits.TRISA3)
	#define LED1_IO				(PORTAbits.RA3)
	#define LED2_TRIS			(TRISAbits.TRISA2)
	#define LED2_IO				(PORTAbits.RA2)
	#define LED3_TRIS			(TRISAbits.TRISA4)	// No LED3; remap
	#define LED3_IO				(PORTAbits.RA4)
	#define LED4_TRIS			(TRISAbits.TRISA3)	// No LED4; remap
	#define LED4_IO				(PORTAbits.RA3)
	#define LED5_TRIS			(TRISAbits.TRISA2)	// No LED5; remap
	#define LED5_IO				(PORTAbits.RA2)
	#define LED6_TRIS			(TRISAbits.TRISA4)	// No LED6; remap
	#define LED6_IO				(PORTAbits.RA4)
	#define LED7_TRIS			(TRISAbits.TRISA3)	// No LED7; remap
	#define LED7_IO				(PORTAbits.RA3)

	#define BUTTON0_TRIS		(TRISBbits.TRISB5)
	#define	BUTTON0_IO			(PORTBbits.RB5)
	#define BUTTON1_TRIS		(TRISBbits.TRISB5)	// No Button1 on this board, remap to Button0
	#define	BUTTON1_IO			(PORTBbits.RB5)
	#define BUTTON2_TRIS		(TRISBbits.TRISB5)	// No Button2 on this board, remap to Button0
	#define	BUTTON2_IO			(PORTBbits.RB5)
	#define BUTTON3_TRIS		(TRISBbits.TRISB5)	// No Button3 on this board, remap to Button0
	#define	BUTTON3_IO			(PORTBbits.RB5)

	// RTL8019AS I/O pins
	typedef struct
	{
		unsigned char data : 5;	// Bits 0 through 4
		unsigned char : 3;		// Bits 5 through 7
	} NIC_ADDR;
	typedef struct
	{
		unsigned char data : 8;	// Bits 0 through 7
	} NIC_DATA;
	#define NIC_ADDR_TRIS		(((volatile NIC_ADDR*)&TRISB)->data)
	#define NIC_ADDR_IO			(((volatile NIC_ADDR*)&LATB)->data)
	#define NIC_DATA_TRIS		(((volatile NIC_DATA*)&TRISD)->data)
	#define NIC_DATA_IO			(((volatile NIC_DATA*)&PORTD)->data)
	#define NIC_RESET_TRIS		(TRISEbits.TRISE2)
	#define NIC_RESET_IO        (LATEbits.LATE2)
	#define NIC_ADDR_LATCH_TRIS	(PRODL)
	#define NIC_ADDR_LATCH_IO	(PRODL)
	#define NIC_IOW_TRIS		(TRISEbits.TRISE1)
	#define NIC_IOW_IO          (LATEbits.LATE1)
	#define NIC_IOR_TRIS		(TRISEbits.TRISE0)
	#define NIC_IOR_IO          (LATEbits.LATE0)

	// 24LC256 I/O pins
	#define EEPROM_SCL_TRIS		(TRISCbits.TRISC3)
	#define EEPROM_SDA_TRIS		(TRISCbits.TRISC4)
	#define EEPROM_SSPBUF		(SSPBUF)
	#define EEPROM_SSPCON1		(SSPCON1)
	#define EEPROM_SSPCON1bits	(SSPCON1bits)
	#define EEPROM_SSPCON2		(SSPCON2)
	#define EEPROM_SSPCON2bits	(SSPCON2bits)
	#define EEPROM_SSPSTATbits	(SSPSTATbits)

	// 24LC256 configuration
	#define EEPROM_CONTROL	(0xA0)		// Address 0
	#define I2CBAUD			(400000)	// Hz

	// LCD
	// LCD Module I/O pins
	typedef struct
	{
		unsigned char data : 4;	// Bits 0 through 3
		unsigned char : 4;		// Bits 4 through 7
	} LCD_DATA;
	#define LCD_DATA_TRIS		(((volatile LCD_DATA*)&TRISD)->data)
	#define LCD_DATA_IO			(((volatile LCD_DATA*)&LATD)->data)
	#define LCD_RD_WR_TRIS		(TRISDbits.TRISD5)
	#define LCD_RD_WR_IO		(LATDbits.LATD5)
	#define LCD_RS_TRIS			(TRISDbits.TRISD4)
	#define LCD_RS_IO			(LATDbits.LATD4)
	#define LCD_E_TRIS			(TRISAbits.TRISA5)
	#define LCD_E_IO			(LATAbits.LATA5)

	// Do not use the DMA and other goodies that Microchip Ethernet modules have
	#define NON_MCHP_MAC

	#if defined(__18F452)
		#define OSCTUNE				PRODL
		#define ADCON2				PRODL
	#endif

#elif defined(PICDEMNET) && defined(HI_TECH_C)
// PICDEM.net (classic) board with Realtek RTL8019AS Ethernet controller
// It is strongly recommended that the PIC18F452 that came installed 
// on the PICDEM.net be removed and a PIC18F4620 be installed in its 
// place.  The PIC18F4620 has twice the FLASH, substantially more 
// RAM, and as a result can support all of the latest TCP/IP stack 
// modules compiled all at once.  The PIC18F4620 also has superior 
// peripherals that are natively supported by the stack.
//
// If using the PIC18F452, you most likely will not be able to compile
// the stack with the HI-TECH compiler due to excessive code space needed.
// You must remove unneeded modules or use a bigger microcontroller.
	typedef struct
	{
	    unsigned char BF:1;
	    unsigned char UA:1;
	    unsigned char R_W:1;
	    unsigned char S:1;
	    unsigned char P:1;
	    unsigned char D_A:1;
	    unsigned char CKE:1;
	    unsigned char SMP:1;
	} SSPSTATbits;
	typedef struct
	{
	    unsigned char SSPM0:1;
	    unsigned char SSPM1:1;
	    unsigned char SSPM2:1;
	    unsigned char SSPM3:1;
	    unsigned char CKP:1;
	    unsigned char SSPEN:1;
	    unsigned char SSPOV:1;
	    unsigned char WCOL:1;
	} SSPCON1bits;
	typedef struct
	{
	    unsigned char SEN:1;
	    unsigned char RSEN:1;
	    unsigned char PEN:1;
	    unsigned char RCEN:1;
	    unsigned char ACKEN:1;
	    unsigned char ACKDT:1;
	    unsigned char ACKSTAT:1;
	    unsigned char GCEN:1;
	} SSPCON2bits;
	typedef struct 
	{
	    unsigned char RBIF:1;
	    unsigned char INT0IF:1;
	    unsigned char TMR0IF:1;
		unsigned char RBIE:1;
	    unsigned char INT0IE:1;
	    unsigned char TMR0IE:1;
	    unsigned char GIEL:1;
	    unsigned char GIEH:1;
	} INTCONbits;
	typedef struct 
	{
	    unsigned char RBIP:1;
	    unsigned char INT3IP:1;
	    unsigned char TMR0IP:1;
	    unsigned char INTEDG3:1;
	    unsigned char INTEDG2:1;
	    unsigned char INTEDG1:1;
	    unsigned char INTEDG0:1;
	    unsigned char RBPU:1;
	} INTCON2bits;
	typedef struct 
	{
	    unsigned char ADON:1;
	    unsigned char GO:1;
	    unsigned char CHS0:1;
	    unsigned char CHS1:1;
	    unsigned char CHS2:1;
	    unsigned char CHS3:1;
	} ADCON0bits;
	typedef struct 
	{
		unsigned char ADCS0:1;
		unsigned char ADCS1:1;
		unsigned char ADCS2:1;
		unsigned char ACQT0:1;
		unsigned char ACQT1:1;
		unsigned char ACQT2:1;
		unsigned char :1;
		unsigned char ADFM:1;
	} ADCON2bits;
	typedef struct 
	{
	    unsigned char TMR1IF:1;
	    unsigned char TMR2IF:1;
	    unsigned char CCP1IF:1;
	    unsigned char SSPIF:1;
	    unsigned char TXIF:1;
	    unsigned char RCIF:1;
	    unsigned char ADIF:1;
	    unsigned char PSPIF:1;
	} PIR1bits;
	typedef struct 
	{
	    unsigned char CCP2IF:1;
	    unsigned char TMR3IF:1;
	    unsigned char HLVDIF:1;
	    unsigned char BCLIF:1;
	    unsigned char EEIF:1;
	    unsigned char :1;
	    unsigned char CMIF:1;
	    unsigned char OSCFIF:1;
	} PIR2bits;
	typedef struct 
	{
	    unsigned char TMR1IE:1;
	    unsigned char TMR2IE:1;
	    unsigned char CCP1IE:1;
	    unsigned char SSPIE:1;
	    unsigned char TXIE:1;
	    unsigned char RCIE:1;
	    unsigned char ADIE:1;
	    unsigned char PSPIE:1;
	} PIE1bits;
	typedef struct
	{
	    unsigned char T0PS0:1;
	    unsigned char T0PS1:1;
	    unsigned char T0PS2:1;
	    unsigned char PSA:1;
	    unsigned char T0SE:1;
	    unsigned char T0CS:1;
	    unsigned char T08BIT:1;
	    unsigned char TMR0ON:1;
	} T0CONbits;
	typedef struct
	{
	    unsigned char TX9D:1;
	    unsigned char TRMT:1;
	    unsigned char BRGH:1;
	    unsigned char SENDB:1;
	    unsigned char SYNC:1;
	    unsigned char TXEN:1;
	    unsigned char TX9:1;
	    unsigned char CSRC:1;
	} TXSTAbits;
	typedef struct
	{
	    unsigned char RX9D:1;
	    unsigned char OERR:1;
	    unsigned char FERR:1;
	    unsigned char ADDEN:1;
	    unsigned char CREN:1;
	    unsigned char SREN:1;
	    unsigned char RX9:1;
	    unsigned char SPEN:1;
	} RCSTAbits;

	
	#define SSPSTATbits			(*((SSPSTATbits*)&SSPSTAT))
	#define INTCONbits			(*((INTCONbits*)&INTCON))
	#define INTCON2bits			(*((INTCON2bits*)&INTCON2))
	#define ADCON0bits			(*((ADCON0bits*)&ADCON0))
	#define ADCON2bits			(*((ADCON2bits*)&ADCON2))
	#define PIR1bits			(*((PIR1bits*)&PIR1))
	#define PIR2bits			(*((PIR2bits*)&PIR2))
	#define PIE1bits			(*((PIE1bits*)&PIE1))
	#define T0CONbits			(*((T0CONbits*)&T0CON))
	#define TXSTAbits			(*((TXSTAbits*)&TXSTA))
	#define RCSTAbits			(*((RCSTAbits*)&RCSTA))
	#define SSPCON1bits			(*((SSPCON1bits*)&SSPCON1))
	#define SSPCON2bits			(*((SSPCON2bits*)&SSPCON2))

	// I/O pins
	#define LED0_TRIS			(TRISA4)
	#define LED0_IO				(RA4)
	#define LED1_TRIS			(TRISA3)
	#define LED1_IO				(RA3)
	#define LED2_TRIS			(TRISA2)
	#define LED2_IO				(RA2)
	#define LED3_TRIS			(TRISA4)
	#define LED3_IO				(RA4)
	#define LED4_TRIS			(TRISA3)
	#define LED4_IO				(RA3)
	#define LED5_TRIS			(TRISA2)
	#define LED5_IO				(RA2)
	#define LED6_TRIS			(TRISA4)
	#define LED6_IO				(RA4)
	#define LED7_TRIS			(TRISA3)
	#define LED7_IO				(RA3)

	#define BUTTON0_TRIS		(TRISB5)
	#define	BUTTON0_IO			(RB5)
	#define BUTTON1_TRIS		(TRISB5)	// No Button1 on this board, remap to Button0
	#define	BUTTON1_IO			(RB5)
	#define BUTTON2_TRIS		(TRISB5)	// No Button2 on this board, remap to Button0
	#define	BUTTON2_IO			(RB5)
	#define BUTTON3_TRIS		(TRISB5)	// No Button3 on this board, remap to Button0
	#define	BUTTON3_IO			(RB5)

	// RTL8019AS I/O pins
	typedef struct
	{
		unsigned char data : 5;	// Bits 0 through 4
		unsigned char : 3;		// Bits 5 through 7
	} NIC_ADDR;
	typedef struct
	{
		unsigned char data : 8;	// Bits 0 through 7
	} NIC_DATA;
	#define NIC_ADDR_TRIS		(((volatile NIC_ADDR*)&TRISB)->data)
	#define NIC_ADDR_IO			(((volatile NIC_ADDR*)&LATB)->data)
	#define NIC_DATA_TRIS		(((volatile NIC_DATA*)&TRISD)->data)
	#define NIC_DATA_IO			(((volatile NIC_DATA*)&PORTD)->data)
	#define NIC_RESET_TRIS		(TRISE2)
	#define NIC_RESET_IO        (LATE2)
	#define NIC_ADDR_LATCH_TRIS	(PRODL)
	#define NIC_ADDR_LATCH_IO	(PRODL)
	#define NIC_IOW_TRIS		(TRISE1)
	#define NIC_IOW_IO          (LATE1)
	#define NIC_IOR_TRIS		(TRISE0)
	#define NIC_IOR_IO          (LATE0)

	// 24LC256 I/O pins
	#define EEPROM_SCL_TRIS		(TRISC3)
	#define EEPROM_SDA_TRIS		(TRISC4)
	#define EEPROM_SSPBUF		(SSPBUF)
	#define EEPROM_SSPCON1		(SSPCON1)
	#define EEPROM_SSPCON1bits	(SSPCON1bits)
	#define EEPROM_SSPCON2		(SSPCON2)
	#define EEPROM_SSPCON2bits	(SSPCON2bits)
	#define EEPROM_SSPSTATbits	(SSPSTATbits)

	// 24LC256 configuration
	#define EEPROM_CONTROL	(0xA0)		// Address 0
	#define I2CBAUD			(400000)	// Hz

	// LCD
	// LCD Module I/O pins
	typedef struct
	{
		unsigned char data : 4;	// Bits 0 through 3
		unsigned char : 4;		// Bits 4 through 7
	} LCD_DATA;
	#define LCD_DATA_TRIS		(((volatile LCD_DATA*)&TRISD)->data)
	#define LCD_DATA_IO			(((volatile LCD_DATA*)&LATD)->data)
	#define LCD_RD_WR_TRIS		(TRISD5)
	#define LCD_RD_WR_IO		(LATD5)
	#define LCD_RS_TRIS			(TRISD4)
	#define LCD_RS_IO			(LATD4)
	#define LCD_E_TRIS			(TRISA5)
	#define LCD_E_IO			(LATA5)

	// Do not use the DMA and other goodies that Microchip Ethernet modules have
	#define NON_MCHP_MAC

#elif defined(EXPLORER_16)
// Explorer 16 + Ethernet PICtail Plus

	#define LED0_TRIS			(TRISAbits.TRISA0)	// Ref D3
	#define LED0_IO				(PORTAbits.RA0)	
	#define LED1_TRIS			(TRISAbits.TRISA1)	// Ref D4
	#define LED1_IO				(PORTAbits.RA1)
	#define LED2_TRIS			(TRISAbits.TRISA2)	// Ref D5
	#define LED2_IO				(PORTAbits.RA2)
	#define LED3_TRIS			(TRISAbits.TRISA3)	// Ref D6
	#define LED3_IO				(PORTAbits.RA3)
	#define LED4_TRIS			(TRISAbits.TRISA4)	// Ref D7
	#define LED4_IO				(PORTAbits.RA4)
	#define LED5_TRIS			(TRISAbits.TRISA5)	// Ref D8
	#define LED5_IO				(PORTAbits.RA5)
	#define LED6_TRIS			(TRISAbits.TRISA6)	// Ref D9
	#define LED6_IO				(PORTAbits.RA6)
	#define LED7_TRIS			(TRISAbits.TRISA7)	// Ref D10	// Note: This is multiplexed with BUTTON1
	#define LED7_IO				(PORTAbits.RA7)
	#define LED_IO				(*((volatile unsigned char*)(&PORTA)))


	#define BUTTON0_TRIS		(TRISDbits.TRISD13)	// Ref S4
	#define	BUTTON0_IO			(PORTDbits.RD13)
	#define BUTTON1_TRIS		(TRISAbits.TRISA7)	// Ref S5	// Note: This is multiplexed with LED7
	#define	BUTTON1_IO			(PORTAbits.RA7)
	#define BUTTON2_TRIS		(TRISDbits.TRISD7)	// Ref S6
	#define	BUTTON2_IO			(PORTDbits.RD7)
	#define BUTTON3_TRIS		(TRISDbits.TRISD6)	// Ref S3
	#define	BUTTON3_IO			(PORTDbits.RD6)

	#define UARTTX_TRIS			(TRISFbits.TRISF5)
	#define UARTTX_IO			(PORTFbits.RF5)
	#define UARTRX_TRIS			(TRISFbits.TRISF4)
	#define UARTRX_IO			(PORTFbits.RF4)

	// ENC28J60 I/O pins
	#define ENC_RST_TRIS		(TRISDbits.TRISD15)	// Not connected by default
	#define ENC_RST_IO			(PORTDbits.RD15)
	#define ENC_CS_TRIS			(TRISDbits.TRISD14)
	#define ENC_CS_IO			(PORTDbits.RD14)
	#define ENC_SCK_TRIS		(TRISFbits.TRISF6)
	#define ENC_SDI_TRIS		(TRISFbits.TRISF7)
	#define ENC_SDO_TRIS		(TRISFbits.TRISF8)
	#define ENC_SPI_IF			(IFS0bits.SPI1IF)
	#define ENC_SSPBUF			(SPI1BUF)
	#define ENC_SPISTAT			(SPI1STAT)
	#define ENC_SPISTATbits		(SPI1STATbits)
	#define ENC_SPICON1			(SPI1CON1)
	#define ENC_SPICON1bits		(SPI1CON1bits)
	#define ENC_SPICON2			(SPI1CON2)

	// 25LC256 I/O pins
	#define EEPROM_CS_TRIS		(TRISDbits.TRISD12)
	#define EEPROM_CS_IO		(PORTDbits.RD12)
	#define EEPROM_SCK_TRIS		(TRISGbits.TRISG6)
	#define EEPROM_SDI_TRIS		(TRISGbits.TRISG7)
	#define EEPROM_SDO_TRIS		(TRISGbits.TRISG8)
	#define EEPROM_SPI_IF		(IFS2bits.SPI2IF)
	#define EEPROM_SSPBUF		(SPI2BUF)
	#define EEPROM_SPICON1		(SPI2CON1)
	#define EEPROM_SPICON1bits	(SPI2CON1bits)
	#define EEPROM_SPICON2		(SPI2CON2)
	#define EEPROM_SPISTAT		(SPI2STAT)
	#define EEPROM_SPISTATbits	(SPI2STATbits)

	// LCD Module I/O pins
	#define LCD_DATA_TRIS		(*((volatile BYTE*)&TRISE))
	#define LCD_DATA_IO			(*((volatile BYTE*)&LATE))
	#define LCD_RD_WR_TRIS		(TRISDbits.TRISD5)
	#define LCD_RD_WR_IO		(LATDbits.LATD5)
	#define LCD_RS_TRIS			(TRISBbits.TRISB15)
	#define LCD_RS_IO			(LATBbits.LATB15)
	#define LCD_E_TRIS			(TRISDbits.TRISD4)
	#define LCD_E_IO			(LATDbits.LATD4)

#elif defined(DSPICDEM11)
// dsPICDEM 1.1 Development Board + Ethernet PICtail airwired. There 
// is no PICtail header on this development board.  The following 
// airwires must be made:
// 1. dsPICDEM GND <-> PICtail GND (PICtail pin 27)
// 2. dsPICDEM Vdd <- PICtail VPIC (PICtail pin 25)
// 3. dsPICDEM RG2 -> PICtail ENC28J60 CS (PICtail pin 22)
// 4. dsPICDEM RF6 -> PICtail SCK (PICtail pin 11)
// 5. dsPICDEM RF7 <- PICtail SDI (PICtail pin 9)
// 6. dsPICDEM RF8 -> PICtail SDO (PICtail pin 7)
// 7. dsPICDEM RG3 -> PICtail 25LC256 CS (PICtail pin 20)

	#define LED0_TRIS			(TRISDbits.TRISD3)	// Ref LED4
	#define LED0_IO				(PORTDbits.RD3)	
	#define LED1_TRIS			(TRISDbits.TRISD2)	// Ref LED3
	#define LED1_IO				(PORTDbits.RD2)
	#define LED2_TRIS			(TRISDbits.TRISD1)	// Ref LED2
	#define LED2_IO				(PORTDbits.RD1)
	#define LED3_TRIS			(TRISDbits.TRISD0)	// Ref LED1
	#define LED3_IO				(PORTDbits.RD0)
	#define LED4_TRIS			(TRISDbits.TRISD3)	// No LED, Remapped to Ref LED4
	#define LED4_IO				(PORTDbits.RD3)	
	#define LED5_TRIS			(TRISDbits.TRISD2)	// No LED, Remapped to Ref LED3
	#define LED5_IO				(PORTDbits.RD2)
	#define LED6_TRIS			(TRISDbits.TRISD1)	// No LED, Remapped to Ref LED2
	#define LED6_IO				(PORTDbits.RD1)
	#define LED7_TRIS			(TRISDbits.TRISD0)	// No LED, Remapped to Ref LED1
	#define LED7_IO				(PORTDbits.RD0)

	#define BUTTON0_TRIS		(TRISAbits.TRISA15)	// Ref SW4
	#define	BUTTON0_IO			(PORTAbits.RA15)
	#define BUTTON1_TRIS		(TRISAbits.TRISA14)	// Ref SW3
	#define	BUTTON1_IO			(PORTAbits.RA14)
	#define BUTTON2_TRIS		(TRISAbits.TRISA13)	// Ref SW2
	#define	BUTTON2_IO			(PORTAbits.RA13)
	#define BUTTON3_TRIS		(TRISAbits.TRISA12)	// Ref SW1
	#define	BUTTON3_IO			(PORTAbits.RA12)

	#define UARTTX_TRIS			(TRISFbits.TRISF3)
	#define UARTTX_IO			(PORTFbits.RF3)
	#define UARTRX_TRIS			(TRISFbits.TRISF2)
	#define UARTRX_IO			(PORTFbits.RF2)

	// ENC28J60 I/O pins
	#define ENC_RST_TRIS		(0)	// Not connected
	#define ENC_RST_IO			(0)
	#define ENC_CS_TRIS			(TRISGbits.TRISG2)		// User must airwire this
	#define ENC_CS_IO			(PORTGbits.RG2)
	#define ENC_SCK_TRIS		(TRISFbits.TRISF6)		// User must airwire this
	#define ENC_SDI_TRIS		(TRISFbits.TRISF7)		// User must airwire this
	#define ENC_SDO_TRIS		(TRISFbits.TRISF8)		// User must airwire this
	#define ENC_SPI_IF			(IFS0bits.SPI1IF)
	#define ENC_SSPBUF			(SPI1BUF)
	#define ENC_SPICON1			(SPI1CON)
	#define ENC_SPICON1bits		(SPI1CONbits)
	#define ENC_SPICON2			(SPI1BUF)				// SPI1CON2 doesn't exist, remap to unimportant register
	#define ENC_SPISTAT			(SPI1STAT)
	#define ENC_SPISTATbits		(SPI1STATbits)

	// 25LC256 I/O pins
	#define EEPROM_CS_TRIS		(TRISGbits.TRISG3)	// User must airwire this
	#define EEPROM_CS_IO		(PORTGbits.RG3)
	#define EEPROM_SCK_TRIS		(TRISGbits.TRISG6)
	#define EEPROM_SDI_TRIS		(TRISGbits.TRISG7)
	#define EEPROM_SDO_TRIS		(TRISGbits.TRISG8)
	#define EEPROM_SPI_IF		(IFS0bits.SPI1IF)
	#define EEPROM_SSPBUF		(SPI1BUF)
	#define EEPROM_SPICON1		(SPI1CON)
	#define EEPROM_SPICON1bits	(SPI1CONbits)
	#define EEPROM_SPICON2		(SPI1BUF)			// SPI1CON2 doesn't exist, remap to unimportant register
	#define EEPROM_SPISTAT		(SPI1STAT)
	#define EEPROM_SPISTATbits	(SPI1STATbits)

	// SI3000 codec pins
	#define CODEC_RST_TRIS		(TRISFbits.TRISF6)
	#define CODEC_RST_IO		(PORTFbits.RF6)
	
	// PIC18F252 LCD Controller
	#define LCDCTRL_CS_TRIS		(TRISGbits.TRISG9)
	#define LCDCTRL_CS_IO		(PORTGbits.RG9)

#elif defined(DSPICDEMNET1) || defined(DSPICDEMNET2)
// dsPICDEM.net 1 and 2 Development Board with RTL8019AS MAC, 24LC515 EEPROM
	#define LED0_TRIS			(TRISCbits.TRISC4)	// Ref LED3
	#define LED0_IO				(PORTCbits.RC4)	
	#define LED1_TRIS			(TRISCbits.TRISC3)	// Ref LED2
	#define LED1_IO				(PORTCbits.RC3)
	#define LED2_TRIS			(TRISCbits.TRISC2)	// Ref LED1
	#define LED2_IO				(PORTCbits.RC2)
	#define LED3_TRIS			(TRISCbits.TRISC4)	// No LED, Remapped to Ref LED3
	#define LED3_IO				(PORTCbits.RC4)	
	#define LED4_TRIS			(TRISCbits.TRISC3)	// No LED, Remapped to Ref LED2
	#define LED4_IO				(PORTCbits.RC3)
	#define LED5_TRIS			(TRISCbits.TRISC2)	// No LED, Remapped to Ref LED1
	#define LED5_IO				(PORTCbits.RC2)
	#define LED6_TRIS			(TRISCbits.TRISC4)	// No LED, Remapped to Ref LED3
	#define LED6_IO				(PORTCbits.RC4)	
	#define LED7_TRIS			(TRISCbits.TRISC3)	// No LED, Remapped to Ref LED2
	#define LED7_IO				(PORTCbits.RC3)

	#define BUTTON0_TRIS		(TRISAbits.TRISA14)	// Ref S3
	#define	BUTTON0_IO			(PORTAbits.RA14)
	#define BUTTON1_TRIS		(TRISAbits.TRISA13)	// Ref S2
	#define	BUTTON1_IO			(PORTAbits.RA13)
	#define BUTTON2_TRIS		(TRISAbits.TRISA12)	// Ref S1
	#define	BUTTON2_IO			(PORTAbits.RA12)
	#define BUTTON3_TRIS		(TRISAbits.TRISA14)	// No switch, remapped to Ref S3
	#define	BUTTON3_IO			(PORTAbits.RA14)

	#define UARTTX_TRIS			(TRISFbits.TRISF3)
	#define UARTTX_IO			(PORTFbits.RF3)
	#define UARTRX_TRIS			(TRISFbits.TRISF2)
	#define UARTRX_IO			(PORTFbits.RF2)

	// RTL8019AS I/O pins
	typedef struct
	{
		unsigned char data : 5;	// Bits 0 through 4
		unsigned char : 3;		// Bits 5 through 7
		unsigned char : 8;		// Bits 8 through 15
	} NIC_ADDR;
	typedef struct
	{
		unsigned int data : 16;	// Bits 0 through 15
	} NIC_DATA;
	#define NIC_ADDR_TRIS		(((volatile NIC_ADDR*)&TRISD)->data)
	#define NIC_ADDR_IO			(((volatile NIC_ADDR*)&LATD)->data)
	#define NIC_DATA_TRIS		(((volatile NIC_DATA*)&TRISD)->data)
	#define NIC_DATA_IO			(((volatile NIC_DATA*)&PORTD)->data)
	#define NIC_RESET_ADPCFG	(ADPCFGbits.PCFG15)
	#define NIC_RESET_TRIS		(TRISBbits.TRISB15)
	#define NIC_RESET_IO		(PORTBbits.RB15)
	#define NIC_ADDR_LATCH_ADPCFG	(ADPCFGbits.PCFG12)
	#define NIC_ADDR_LATCH_TRIS	(TRISBbits.TRISB12)
	#define NIC_ADDR_LATCH_IO	(PORTBbits.RB12)
	#define NIC_IOW_ADPCFG		(ADPCFGbits.PCFG14)
	#define NIC_IOW_TRIS		(TRISBbits.TRISB14)
	#define NIC_IOW_IO			(PORTBbits.RB14)
	#define NIC_IOR_ADPCFG		(ADPCFGbits.PCFG13)
	#define NIC_IOR_TRIS		(TRISBbits.TRISB13)
	#define NIC_IOR_IO			(PORTBbits.RB13)

	// 24LC515 I/O pins
	#define EEPROM_I2CRCV		(I2CRCV)
	#define EEPROM_I2CTRN		(I2CTRN)
	#define EEPROM_I2CCON		(I2CCON)
	#define EEPROM_I2CCONbits	(I2CCONbits)
	#define EEPROM_I2CSTAT		(I2CSTAT)
	#define EEPROM_I2CSTATbits	(I2CSTATbits)

	// 24LC515 configuration
	#define EEPROM_CONTROL	(0xA0)		// Address 0
	#define I2CBAUD			(400000)	// Hz

	// LCD Module I/O pins
	typedef struct
	{
		unsigned char data : 8;	// Bits 0 through 7
		unsigned char : 8;		// Bits 8 through 15
	} LCD_DATA;
	#define LCD_DATA_TRIS		(((volatile LCD_DATA*)&TRISD)->data)
	#define LCD_DATA_IO			(((volatile LCD_DATA*)&LATD)->data)
	#define LCD_RD_WR_TRIS		(TRISBbits.TRISB11)
	#define LCD_RD_WR_IO		(LATBbits.LATB11)
	#define LCD_RS_TRIS			(TRISAbits.TRISA6)
	#define LCD_RS_IO			(LATAbits.LATA6)
	#define LCD_E_TRIS			(TRISAbits.TRISA7)
	#define LCD_E_IO			(LATAbits.LATA7)

	//SRAM I/O
	#define SRAM_CE_ADPCFG		(ADPCFGbits.PCFG9)
	#define SRAM_OE_ADPCFG		(ADPCFGbits.PCFG10)
	#define SRAM_CE_TRIS		(TRISBbits.TRISB9)
	#define SRAM_CE_IO			(LATBbits.LATB9)
	#define SRAM_OE_TRIS		(TRISBbits.TRISB10)
	#define SRAM_OE_IO			(LATBbits.LATB10)
	

	// Do not use the DMA and other goodies that Microchip Ethernet modules have
	#define NON_MCHP_MAC

#elif defined(PICDEMNET2) && !defined(HI_TECH_C)
// PICDEM.net 2 (PIC18F97J60 + ENC28J60)

	// I/O pins
	#define LED0_TRIS			(TRISJbits.TRISJ0)
	#define LED0_IO				(PORTJbits.RJ0)
	#define LED1_TRIS			(TRISJbits.TRISJ1)
	#define LED1_IO				(PORTJbits.RJ1)
	#define LED2_TRIS			(TRISJbits.TRISJ2)
	#define LED2_IO				(PORTJbits.RJ2)
	#define LED3_TRIS			(TRISJbits.TRISJ3)
	#define LED3_IO				(PORTJbits.RJ3)
	#define LED4_TRIS			(TRISJbits.TRISJ4)
	#define LED4_IO				(PORTJbits.RJ4)
	#define LED5_TRIS			(TRISJbits.TRISJ5)
	#define LED5_IO				(PORTJbits.RJ5)
	#define LED6_TRIS			(TRISJbits.TRISJ6)
	#define LED6_IO				(PORTJbits.RJ6)
	#define LED7_TRIS			(TRISJbits.TRISJ7)
	#define LED7_IO				(PORTJbits.RJ7)
	#define LED_IO				(*((volatile unsigned char*)(&PORTJ)))

	#define BUTTON0_TRIS		(TRISBbits.TRISB3)
	#define	BUTTON0_IO			(PORTBbits.RB3)
	#define BUTTON1_TRIS		(TRISBbits.TRISB2)
	#define	BUTTON1_IO			(PORTBbits.RB2)
	#define BUTTON2_TRIS		(TRISBbits.TRISB1)
	#define	BUTTON2_IO			(PORTBbits.RB1)
	#define BUTTON3_TRIS		(TRISBbits.TRISB0)
	#define	BUTTON3_IO			(PORTBbits.RB0)

	// ENC28J60 I/O pins
	#define ENC_RST_TRIS		(TRISDbits.TRISD2)	// Not connected by default
	#define ENC_RST_IO			(LATDbits.LATD2)
//	#define ENC_CS_TRIS			(TRISDbits.TRISD3)	// Uncomment this line if you wish to use the ENC28J60 on the PICDEM.net 2 board instead of the internal PIC18F97J60 Ethernet module
	#define ENC_CS_IO			(LATDbits.LATD3)
	#define ENC_SCK_TRIS		(TRISCbits.TRISC3)
	#define ENC_SDI_TRIS		(TRISCbits.TRISC4)
	#define ENC_SDO_TRIS		(TRISCbits.TRISC5)
	#define ENC_SPI_IF			(PIR1bits.SSPIF)
	#define ENC_SSPBUF			(SSP1BUF)
	#define ENC_SPISTAT			(SSP1STAT)
	#define ENC_SPISTATbits		(SSP1STATbits)
	#define ENC_SPICON1			(SSP1CON1)
	#define ENC_SPICON1bits		(SSP1CON1bits)
	#define ENC_SPICON2			(SSP1CON2)

	// 25LC256 I/O pins
	#define EEPROM_CS_TRIS		(TRISDbits.TRISD7)
	#define EEPROM_CS_IO		(LATDbits.LATD7)
	#define EEPROM_SCK_TRIS		(TRISCbits.TRISC3)
	#define EEPROM_SDI_TRIS		(TRISCbits.TRISC4)
	#define EEPROM_SDO_TRIS		(TRISCbits.TRISC5)
	#define EEPROM_SPI_IF		(PIR1bits.SSPIF)
	#define EEPROM_SSPBUF		(SSPBUF)
	#define EEPROM_SPICON1		(SSP1CON1)
	#define EEPROM_SPICON1bits	(SSP1CON1bits)
	#define EEPROM_SPICON2		(SSP1CON2)
	#define EEPROM_SPISTAT		(SSP1STAT)
	#define EEPROM_SPISTATbits	(SSP1STATbits)

	#define LCD_DATA_TRIS		(TRISE)
	#define LCD_DATA_IO			(LATE)
	#define LCD_RD_WR_TRIS		(TRISHbits.TRISH1)
	#define LCD_RD_WR_IO		(LATHbits.LATH1)
	#define LCD_RS_TRIS			(TRISHbits.TRISH2)
	#define LCD_RS_IO			(LATHbits.LATH2)
	#define LCD_E_TRIS			(TRISHbits.TRISH0)
	#define LCD_E_IO			(LATHbits.LATH0)

#elif defined(PICDEMNET2) && defined(HI_TECH_C)
// PICDEM.net 2 (PIC18F97J60 + ENC28J60) + HI-TECH PICC-18 compiler
	typedef struct
	{
		unsigned char BOR:1;
		unsigned char POR:1;
		unsigned char PD:1;
		unsigned char TO:1;
		unsigned char RI:1;
		unsigned char CM:1;
		unsigned char :1;
		unsigned char IPEN:1;
	} RCONbits;
	typedef struct
	{
	    unsigned char BF:1;
	    unsigned char UA:1;
	    unsigned char R_W:1;
	    unsigned char S:1;
	    unsigned char P:1;
	    unsigned char D_A:1;
	    unsigned char CKE:1;
	    unsigned char SMP:1;
	} SSPSTATbits;
	typedef struct
	{
	    unsigned char SSPM0:1;
	    unsigned char SSPM1:1;
	    unsigned char SSPM2:1;
	    unsigned char SSPM3:1;
	    unsigned char CKP:1;
	    unsigned char SSPEN:1;
	    unsigned char SSPOV:1;
	    unsigned char WCOL:1;
	} SSPCON1bits;
	typedef struct
	{
	    unsigned char SEN:1;
	    unsigned char RSEN:1;
	    unsigned char PEN:1;
	    unsigned char RCEN:1;
	    unsigned char ACKEN:1;
	    unsigned char ACKDT:1;
	    unsigned char ACKSTAT:1;
	    unsigned char GCEN:1;
	} SSPCON2bits;
	typedef struct 
	{
	    unsigned char RBIF:1;
	    unsigned char INT0IF:1;
	    unsigned char TMR0IF:1;
		unsigned char RBIE:1;
	    unsigned char INT0IE:1;
	    unsigned char TMR0IE:1;
	    unsigned char GIEL:1;
	    unsigned char GIEH:1;
	} INTCONbits;
	typedef struct 
	{
	    unsigned char RBIP:1;
	    unsigned char INT3IP:1;
	    unsigned char TMR0IP:1;
	    unsigned char INTEDG3:1;
	    unsigned char INTEDG2:1;
	    unsigned char INTEDG1:1;
	    unsigned char INTEDG0:1;
	    unsigned char RBPU:1;
	} INTCON2bits;
	typedef struct 
	{
	    unsigned char ADON:1;
	    unsigned char GO:1;
	    unsigned char CHS0:1;
	    unsigned char CHS1:1;
	    unsigned char CHS2:1;
	    unsigned char CHS3:1;
		unsigned char :1;
		unsigned char ADCAL:1;
	} ADCON0bits;
	typedef struct 
	{
		unsigned char ADCS0:1;
		unsigned char ADCS1:1;
		unsigned char ADCS2:1;
		unsigned char ACQT0:1;
		unsigned char ACQT1:1;
		unsigned char ACQT2:1;
		unsigned char :1;
		unsigned char ADFM:1;
	} ADCON2bits;
	typedef struct 
	{
	    unsigned char TMR1IF:1;
	    unsigned char TMR2IF:1;
	    unsigned char CCP1IF:1;
	    unsigned char SSPIF:1;
	    unsigned char TXIF:1;
	    unsigned char RCIF:1;
	    unsigned char ADIF:1;
	    unsigned char PSPIF:1;
	} PIR1bits;
	typedef struct 
	{
	    unsigned char CCP2IF:1;
	    unsigned char TMR3IF:1;
	    unsigned char HLVDIF:1;
	    unsigned char BCLIF:1;
	    unsigned char EEIF:1;
	    unsigned char :1;
	    unsigned char CMIF:1;
	    unsigned char OSCFIF:1;
	} PIR2bits;
	typedef struct 
	{
	    unsigned char TMR1IE:1;
	    unsigned char TMR2IE:1;
	    unsigned char CCP1IE:1;
	    unsigned char SSPIE:1;
	    unsigned char TXIE:1;
	    unsigned char RCIE:1;
	    unsigned char ADIE:1;
	    unsigned char PSPIE:1;
	} PIE1bits;
	typedef struct
	{
	    unsigned char T0PS0:1;
	    unsigned char T0PS1:1;
	    unsigned char T0PS2:1;
	    unsigned char PSA:1;
	    unsigned char T0SE:1;
	    unsigned char T0CS:1;
	    unsigned char T08BIT:1;
	    unsigned char TMR0ON:1;
	} T0CONbits;
	typedef struct
	{
	    unsigned char TX9D:1;
	    unsigned char TRMT:1;
	    unsigned char BRGH:1;
	    unsigned char SENDB:1;
	    unsigned char SYNC:1;
	    unsigned char TXEN:1;
	    unsigned char TX9:1;
	    unsigned char CSRC:1;
	} TXSTAbits;
	typedef struct
	{
	    unsigned char RX9D:1;
	    unsigned char OERR:1;
	    unsigned char FERR:1;
	    unsigned char ADDEN:1;
	    unsigned char CREN:1;
	    unsigned char SREN:1;
	    unsigned char RX9:1;
	    unsigned char SPEN:1;
	} RCSTAbits;
	typedef struct
	{
		unsigned char LATA0:1;
		unsigned char LATA1:1;
		unsigned char LATA2:1;
		unsigned char LATA3:1;
		unsigned char LATA4:1;
		unsigned char LATA5:1;
		unsigned char REPU:1;
		unsigned char RDPU:1;
	} LATAbits;
	typedef struct
	{
		unsigned char TRISA0:1;
		unsigned char TRISA1:1;
		unsigned char TRISA2:1;
		unsigned char TRISA3:1;
		unsigned char TRISA4:1;
		unsigned char TRISA5:1;
		unsigned char :2;
	} TRISAbits;
	typedef struct
	{
	  unsigned :5;
	  unsigned ETHEN:1;
	  unsigned PKTDEC:1;
	  unsigned AUTOINC:1;
	} ECON2bits;
	typedef struct
	{
	  unsigned PHYRDY:1;
	  unsigned TXABRT:1;
	  unsigned RXBUSY:1;
	  unsigned :3;
	  unsigned BUFER:1;
	} ESTATbits;
	typedef struct
	{
	  unsigned :2;
	  unsigned RXEN:1;
	  unsigned TXRTS:1;
	  unsigned CSUMEN:1;
	  unsigned DMAST:1;
	  unsigned RXRST:1;
	  unsigned TXRST:1;
	} ECON1bits;
	typedef struct
	{
	  unsigned RXERIF:1;
	  unsigned TXERIF:1;
	  unsigned :1;
	  unsigned TXIF:1;
	  unsigned LINKIF:1;
	  unsigned DMAIF:1;
	  unsigned PKTIF:1;
	} EIRbits;
	typedef struct
	{
	  unsigned BUSY:1;
	  unsigned SCAN:1;
	  unsigned NVALID:1;
	} MISTATbits;

	
	#define RCONbits			(*((RCONbits*)&RCON))
	#define SSP1STATbits		(*((SSPSTATbits*)&SSP1STAT))
	#define INTCONbits			(*((INTCONbits*)&INTCON))
	#define INTCON2bits			(*((INTCON2bits*)&INTCON2))
	#define ADCON0bits			(*((ADCON0bits*)&ADCON0))
	#define ADCON2bits			(*((ADCON2bits*)&ADCON2))
	#define PIR1bits			(*((PIR1bits*)&PIR1))
	#define PIR2bits			(*((PIR2bits*)&PIR2))
	#define PIE1bits			(*((PIE1bits*)&PIE1))
	#define T0CONbits			(*((T0CONbits*)&T0CON))
	#define TXSTAbits			(*((TXSTAbits*)&TXSTA))
	#define RCSTAbits			(*((RCSTAbits*)&RCSTA))
	#define SSPCON1bits			(*((SSPCON1bits*)&SSPCON1))
	#define SSPCON2bits			(*((SSPCON2bits*)&SSPCON2))
	#define LATAbits			(*((LATAbits*)&LATA))
	#define TRISAbits			(*((TRISAbits*)&TRISA))
	#define ECON1bits			(*((ECON1bits*)&ECON1))
	#define ESTATbits			(*((ESTATbits*)&ESTAT))
	#define ECON2bits			(*((ECON2bits*)&ECON2))
	#define EIRbits				(*((EIRbits*)&EIR))
	#define MISTATbits			(*((MISTATbits*)&MISTAT))

	// I/O pins
	#define LED0_TRIS			(TRISJ0)
	#define LED0_IO				(RJ0)
	#define LED1_TRIS			(TRISJ1)
	#define LED1_IO				(RJ1)
	#define LED2_TRIS			(TRISJ2)
	#define LED2_IO				(RJ2)
	#define LED3_TRIS			(TRISJ3)
	#define LED3_IO				(RJ3)
	#define LED4_TRIS			(TRISJ4)
	#define LED4_IO				(RJ4)
	#define LED5_TRIS			(TRISJ5)
	#define LED5_IO				(RJ5)
	#define LED6_TRIS			(TRISJ6)
	#define LED6_IO				(RJ6)
	#define LED7_TRIS			(TRISJ7)
	#define LED7_IO				(RJ7)
	#define LED_IO				(*((volatile unsigned char*)(&PORTJ)))

	#define BUTTON0_TRIS		(TRISB3)
	#define	BUTTON0_IO			(RB3)
	#define BUTTON1_TRIS		(TRISB2)
	#define	BUTTON1_IO			(RB2)
	#define BUTTON2_TRIS		(TRISB1)
	#define	BUTTON2_IO			(RB1)
	#define BUTTON3_TRIS		(TRISB0)
	#define	BUTTON3_IO			(RB0)

	// ENC28J60 I/O pins
	#define ENC_RST_TRIS		(TRISD2)	// Not connected by default
	#define ENC_RST_IO			(LATD2)
//	#define ENC_CS_TRIS			(TRISD3)	// Uncomment this line if you wish to use the ENC28J60 on the PICDEM.net 2 board instead of the internal PIC18F97J60 Ethernet module
	#define ENC_CS_IO			(LATD3)
	#define ENC_SCK_TRIS		(TRISC3)
	#define ENC_SDI_TRIS		(TRISC4)
	#define ENC_SDO_TRIS		(TRISC5)
	#define ENC_SPI_IF			(SSPIF)
	#define ENC_SSPBUF			(SSP1BUF)
	#define ENC_SPISTAT			(SSP1STAT)
	#define ENC_SPISTATbits		(SSP1STATbits)
	#define ENC_SPICON1			(SSP1CON1)
	#define ENC_SPICON1bits		(SSP1CON1bits)
	#define ENC_SPICON2			(SSP1CON2)

	// 25LC256 I/O pins
	#define EEPROM_CS_TRIS		(TRISD7)
	#define EEPROM_CS_IO		(LATD7)
	#define EEPROM_SCK_TRIS		(TRISC3)
	#define EEPROM_SDI_TRIS		(TRISC4)
	#define EEPROM_SDO_TRIS		(TRISC5)
	#define EEPROM_SPI_IF		(SSP1IF)
	#define EEPROM_SSPBUF		(SSP1BUF)
	#define EEPROM_SPICON1		(SSP1CON1)
	#define EEPROM_SPICON1bits	(SSP1CON1bits)
	#define EEPROM_SPICON2		(SSP1CON2)
	#define EEPROM_SPISTAT		(SSP1STAT)
	#define EEPROM_SPISTATbits	(SSP1STATbits)

	#define LCD_DATA_TRIS		(TRISE)
	#define LCD_DATA_IO			(LATE)
	#define LCD_RD_WR_TRIS		(TRISH1)
	#define LCD_RD_WR_IO		(LATH1)
	#define LCD_RS_TRIS			(TRISH2)
	#define LCD_RS_IO			(LATH2)
	#define LCD_E_TRIS			(TRISH0)
	#define LCD_E_IO			(LATH0)

#elif defined(PIC18F67J60_TEST_BOARD)
// A little test board with a PIC18F67J60 on it (not in production)
// PIC18F67J60 board 05-60091 (Rev 1)

	// I/O pins
	#define LED0_TRIS			(TRISDbits.TRISD0)
	#define LED0_IO				(PORTDbits.RD0)
	#define LED1_TRIS			(TRISDbits.TRISD0)
	#define LED1_IO				(PORTDbits.RD0)
	#define LED2_TRIS			(TRISDbits.TRISD0)
	#define LED2_IO				(PORTDbits.RD0)
	#define LED3_TRIS			(TRISDbits.TRISD0)
	#define LED3_IO				(PORTDbits.RD0)
	#define LED4_TRIS			(TRISDbits.TRISD0)
	#define LED4_IO				(PORTDbits.RD0)
	#define LED5_TRIS			(TRISDbits.TRISD0)
	#define LED5_IO				(PORTDbits.RD0)
	#define LED6_TRIS			(TRISDbits.TRISD0)
	#define LED6_IO				(PORTDbits.RD0)
	#define LED7_TRIS			(TRISDbits.TRISD0)
	#define LED7_IO				(PORTDbits.RD0)

	#define BUTTON0_TRIS		(TRISBbits.TRISB1)
	#define	BUTTON0_IO			(PORTBbits.RB1)
	#define BUTTON1_TRIS		(TRISBbits.TRISB2)
	#define	BUTTON1_IO			(PORTBbits.RB2)
	#define BUTTON2_TRIS		(TRISBbits.TRISB1)
	#define	BUTTON2_IO			(PORTBbits.RB1)
	#define BUTTON3_TRIS		(TRISBbits.TRISB2)
	#define	BUTTON3_IO			(PORTBbits.RB2)

	// 25LC256 I/O pins
	#define EEPROM_CS_TRIS		(TRISCbits.TRISC2)
	#define EEPROM_CS_IO		(LATCbits.LATC2)
	#define EEPROM_SCK_TRIS		(TRISCbits.TRISC3)
	#define EEPROM_SDI_TRIS		(TRISCbits.TRISC4)
	#define EEPROM_SDO_TRIS		(TRISCbits.TRISC5)
	#define EEPROM_SPI_IF		(PIR1bits.SSPIF)
	#define EEPROM_SSPBUF		(SSPBUF)
	#define EEPROM_SPICON1		(SSP1CON1)
	#define EEPROM_SPICON1bits	(SSP1CON1bits)
	#define EEPROM_SPICON2		(SSP1CON2)
	#define EEPROM_SPISTAT		(SSP1STAT)
	#define EEPROM_SPISTATbits	(SSP1STATbits)

#elif defined(ETORS232)
// Define your own board hardware profile here
	#define LED0_TRIS		    (TRISEbits.TRISE2)
	#define LED0_IO			    (PORTEbits.RE2)
	#define LED1_TRIS		    (TRISEbits.TRISE3)
	#define LED1_IO			    (PORTEbits.RE3)

	#define BUTTON_TRIS	    	(TRISEbits.TRISE5)
	#define	BUTTON_IO		    (PORTEbits.RE5)

    // UART
	#define UART1TX_TRIS		(TRISCbits.TRISC6)
	#define UART1TX_IO		    (PORTCbits.RC6)
	#define UART1RX_TRIS		(TRISCbits.TRISC7)
	#define UART1RX_IO		    (PORTCbits.RC7)



#else
	#error "Hardware profile not defined.  See available profiles in HardwareProfile.h.  Add the appropriate macro definition to your application configuration file ('TCPIPConfig.h', etc.)"
#endif


#if defined(__18CXX) || defined(HI_TECH_C)
	#define BusyUART()				BusyUSART()
	#define CloseUART()				CloseUSART()
	#define ConfigIntUART(a)		ConfigIntUSART(a)
	#define DataRdyUART()			DataRdyUSART()
	#define OpenUART(a,b,c)			OpenUSART(a,b,c)
	#define ReadUART()				ReadUSART()
	#define WriteUART(a)			WriteUSART(a)
	#define getsUART(a,b,c)			getsUSART(b,a)
	#define putsUART(a)				putsUSART(a)
	#define getcUART()				ReadUSART()
	#define putcUART(a)				WriteUSART(a)
	#define putrsUART(a)			putrsUSART((far rom char*)a)

#elif defined(__C30__)
#if defined(DSPICDEMNET1) || defined(DSPICDEMNET2)
	#define UBRG					U1BRG
	#define UMODE					U1MODE
	#define USTA					U1STA
	#define BusyUART()				BusyUART1()
	#define CloseUART()				CloseUART1()
	#define ConfigIntUART(a)		ConfigIntUART1(a)
	#define DataRdyUART()			DataRdyUART1()
	#define OpenUART(a,b,c)			OpenUART1(a,b,c)
	#define ReadUART()				ReadUART1()
	#define WriteUART(a)			WriteUART1(a)
	#define getsUART(a,b,c)			getsUART1(a,b,c)
	#define putsUART(a)				putsUART1((unsigned int *)a)
	#define getcUART()				getcUART1()
	#define putcUART(a)				WriteUART1(a)
	#define putrsUART(a)			putsUART1((unsigned int *)a)
#else
	#define UBRG					U2BRG
	#define UMODE					U2MODE
	#define USTA					U2STA
	#define BusyUART()				BusyUART2()
	#define CloseUART()				CloseUART2()
	#define ConfigIntUART(a)		ConfigIntUART2(a)
	#define DataRdyUART()			DataRdyUART2()
	#define OpenUART(a,b,c)			OpenUART2(a,b,c)
	#define ReadUART()				ReadUART2()
	#define WriteUART(a)			WriteUART2(a)
	#define getsUART(a,b,c)			getsUART2(a,b,c)
	#define putsUART(a)				putsUART2((unsigned int *)a)
	#define getcUART()				getcUART2()
	#define putcUART(a)				WriteUART2(a)
	#define putrsUART(a)			putsUART2((unsigned int *)a)
#endif
#endif

// Various compilation warnings specific to the TCP/IP stack
#if ((defined(__18F97J60)) && !defined(PICDEMNET2) && !defined(ETORS232)) || \
	((defined(__18F67J60)) && !defined(PIC18F67J60_TEST_BOARD) && !defined(ETORS232)) || \
	((defined(__18F18F8722) || defined(__18F87J10) || defined(__18F45J10)) && !defined(HPC_EXPLORER) && !defined(ETORS232)) || \
	((defined(__PIC24F__) || defined(__PIC24H__) || defined(__dsPIC33F__)) && !defined(EXPLORER_16) && !defined(ETORS232)) || \
	((defined(__dsPIC30F__)) && !defined(DSPICDEM11) && !defined(DSPICDEMNET1) && !defined(DSPICDEMNET2) && !defined(ETORS232))
	#error "Warning: The board profile may not be configured correctly."
	#error
	#error "Make sure that a proper board profile macro is defined at the top of 'TCPIPConfig.h' and your processor is selected correctly in MPLAB."
#endif


#endif
