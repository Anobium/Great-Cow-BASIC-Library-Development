/*******************************************************************************
Copyright 2016 Microchip Technology Inc. (www.microchip.com)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

*******************************************************************************/

#ifndef USART_H
#define USART_H

#include <stdbool.h>
#include <stdint.h>

#define CLOCK_FREQ 48000000L
#define GetSystemClock() CLOCK_FREQ

#define UART_ENABLE   RCSTAbits.SPEN

#define UART_TRISTx   TRISCbits.TRISC6
#define UART_TRISRx   TRISCbits.TRISC7

#define TXREG         TXREG1
#define RCREG         RCREG1
#define SPBRG         SPBRG1
#define SPBRGH        SPBRGH1
#define BAUDCON       BAUDCON1
#define RCIF          RC1IF

#define UART_TxRdy()      (TXSTA1bits.TRMT)

// Use following only for Hardware Flow Control
//#define UART_DTS PORTBbits.RB4
//#define UART_DTR LATDbits.LATD3
//#define UART_RTS LATAbits.LATA2
//#define UART_CTS PORTAbits.RA3

//#define mInitRTSPin() {TRISAbits.TRISA2 = 0;}   //Configure RTS as a digital output.
//#define mInitCTSPin() {TRISAbits.TRISA3 = 1;}   //Configure CTS as a digital input.  (Make sure pin is digital if ANxx functions is present on the pin)
//#define mInitDTSPin() {TRISBbits.TRISB4 = 1;}   //Configure DTS as a digital input.  (Make sure pin is digital if ANxx functions is present on the pin)
//#define mInitDTRPin() {TRISDbits.TRISD3 = 0;}   //Configure DTR as a digital output.

/*********************************************************************
* Function: void UART_Initialize(void);
* Overview: Initializes USART (RS-232 port)
********************************************************************/
void UART_Initialize();

/******************************************************************************
 * Function:        void UART_putch(char c)
 * Input:           char c - character to print to the UART
 * Overview:        Sends one character to the UART
 *****************************************************************************/
void UART_putch(char);

/******************************************************************************
 * Function:        void UART_baudrateSet(void)
 * Overview:        Changes the UART baudrate
 *****************************************************************************/
void UART_baudrateSet(uint32_t);

/******************************************************************************
 * Function:        char UART_getch()
 * Output:          unsigned char c - character received from the UART
 * Overview:        Get the input character from the UART
 *****************************************************************************/
unsigned char UART_getch(void);

#endif //USART_H
