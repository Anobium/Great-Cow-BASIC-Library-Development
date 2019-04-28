/*********************************************************************
 *
 *               Data I2C EEPROM Access Routines
 *
 *********************************************************************
 * FileName:        I2CEEPROM.c
 * Dependencies:    Compiler.h
 *                  XEEPROM.h
 * Processor:       PIC18
 * Complier:        Microchip C18 v3.03 or higher
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
 * Author               Date        Comment
 *~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * Nilesh Rajbharti     5/20/02     Original (Rev. 1.0)
 * Howard Schlunder		8/10/06		Renamed registers/bits to use 
 *									C18/C30 style standard names
********************************************************************/
#include "TCPIP Stack/TCPIP.h"

#if defined(MPFS_USE_EEPROM) && defined(EEPROM_SCL_TRIS) && defined(STACK_USE_MPFS)

	// 24LC256 I/O pins
	#define EEPROM_SCL_TRIS		(TRISCbits.TRISC3)
	#define EEPROM_SDA_TRIS		(TRISCbits.TRISC4)
	#define EEPROM_SCL_IO		(PORTCbits.RC3)
	#define EEPROM_SDA_IO		(PORTCbits.RC4)
	#define EEPROM_SSPBUF		(SSPBUF)
	#define EEPROM_SSPCON1		(SSPCON1)
	#define EEPROM_SSPCON1bits	(SSPCON1bits)
	#define EEPROM_SSPCON2		(SSPCON2)
	#define EEPROM_SSPCON2bits	(SSPCON2bits)
	#define EEPROM_SSPSTATbits	(SSPSTATbits)


// I2C bits are in different registers for 8-bit and 16-bit 
// microcontrollers
#if defined(__18CXX)
	#define I2CBIT_ACKDT		(EEPROM_SSPCON2bits.ACKDT)
	#define I2CBIT_ACKEN		(EEPROM_SSPCON2bits.ACKEN)
	#define I2CBIT_RCEN			(EEPROM_SSPCON2bits.RCEN)
	#define I2CBIT_PEN			(EEPROM_SSPCON2bits.PEN)
	#define I2CBIT_SEN			(EEPROM_SSPCON2bits.SEN)
	#define I2CBIT_ACKSTAT		(EEPROM_SSPCON2bits.ACKSTAT)
	#define I2CBIT_TRSTAT		(EEPROM_SSPSTATbits.R_W)
//	#define I2CBIT_TRSTAT		(EEPROM_SSPSTATbits.BF)
	#define I2CBIT_IWCOL		(EEPROM_SSPCON1bits.WCOL)
	#define I2C_DATA_IN			(EEPROM_SSPBUF)
	#define I2C_DATA_OUT		(EEPROM_SSPBUF)
#elif defined(__C30__)
	#define I2CBIT_ACKDT		(EEPROM_I2CCONbits.ACKDT)
	#define I2CBIT_ACKEN		(EEPROM_I2CCONbits.ACKEN)
	#define I2CBIT_RCEN			(EEPROM_I2CCONbits.RCEN)
	#define I2CBIT_PEN			(EEPROM_I2CCONbits.PEN)
	#define I2CBIT_SEN			(EEPROM_I2CCONbits.SEN)
	#define I2CBIT_ACKSTAT		(EEPROM_I2CSTATbits.ACKSTAT)
	#define I2CBIT_TRSTAT		(EEPROM_I2CSTATbits.TRSTAT)
	#define I2CBIT_IWCOL		(EEPROM_I2CSTATbits.IWCOL)
	#define I2C_DATA_IN			(EEPROM_I2CRCV)
	#define I2C_DATA_OUT		(EEPROM_I2CTRN)
#endif


#define READ	(0x01)
#define WRITE	(0x00)

static BOOL NeedACK = FALSE;
static BOOL NeedEndRead = FALSE;
static BOOL NeedEndWrite = FALSE;


static void Delayus(BYTE v);
static void I2CStart(void);
static void I2CStop(void);
static void I2CAck(BOOL Not);
static BOOL I2CPut(BYTE c);
static BYTE I2CGet(void);

static void Delayus(BYTE v)
{
	while(v--)
	{
		Nop();
	}
}


static void I2CStart(void)
{
	EEPROM_SCL_TRIS = 1;	// Clock line must be high
	while(EEPROM_SCL_IO == 0);	
	Delayus(3);

	// Generate a start condition
	EEPROM_SDA_TRIS = 0;
	Delayus(3);	
}

static void I2CStop(void)
{
	// Pull data low
	EEPROM_SDA_TRIS = 0;
	Delayus(1);


	EEPROM_SCL_TRIS = 1;	// Clock line must be high
	while(EEPROM_SCL_IO == 0);	
	Delayus(3);

	// Generate a stop condition
	EEPROM_SDA_TRIS = 1;
	Delayus(3);	
}

static void I2CAck(BOOL Not)
{
	// Generate the (N)Ack
	EEPROM_SDA_TRIS = Not;
	Delayus(3);	

	EEPROM_SCL_TRIS = 1;	// Release the clock
	while(EEPROM_SCL_IO == 0);	
	Delayus(3);	

	EEPROM_SCL_TRIS = 0;	// Pull clock low
	Delayus(1);	
	EEPROM_SDA_TRIS = 1;
	Delayus(3);	
}

static BOOL I2CPut(BYTE c)
{
	BYTE i;

	EEPROM_SCL_TRIS = 0;	// Clock line must be low
	Delayus(1);

	for(i = 0; i < 8; i++)
	{	
		// Generate the data bit
		EEPROM_SDA_TRIS = ((BYTE_VAL*)&c)->bits.b7;
		Delayus(3);
		EEPROM_SCL_TRIS = 1;	// Release the clock	
		while(EEPROM_SCL_IO == 0);	
		Delayus(3);
		EEPROM_SCL_TRIS = 0;	// Pull clock low
		Delayus(1);
		c <<= 1;
	}
	
	// Read the ACK response
	EEPROM_SDA_TRIS = 1;
	Delayus(3);
	
	EEPROM_SCL_TRIS = 1;	// Release the clock	
	while(EEPROM_SCL_IO == 0);	
	Delayus(1);
	i = EEPROM_SDA_IO;
	Delayus(1);
	i += EEPROM_SDA_IO;
	Delayus(1);
	i += EEPROM_SDA_IO;
	
	EEPROM_SCL_TRIS = 0;	// Pull clock low
	Delayus(3);

	return i >= 2;
}


static BYTE I2CGet(void)
{
	BYTE i;
	BYTE c;

	EEPROM_SCL_TRIS = 0;	// Clock line must be low
	Delayus(1);
	EEPROM_SDA_TRIS = 1;
	Delayus(3);

	for(i = 0; i < 8; i++)
	{
		EEPROM_SCL_TRIS = 1;	// Release the clock
		while(EEPROM_SCL_IO == 0);	
		Delayus(3);
	
		// Get the data bit
		c <<= 1;
		((BYTE_VAL*)&c)->bits.b0 = EEPROM_SDA_IO;
		EEPROM_SCL_TRIS = 0;	// Pull clock low
		Delayus(3);
	}

	return c;
}

void XEEInit(void)
{
	LATCbits.LATC3 = 0;
	LATCbits.LATC4 = 0;
//	EEPROM_SCL_IO = 0;
//	EEPROM_SDA_IO = 0;
	EEPROM_SCL_TRIS = 1;		// Set SCL pin to output
	EEPROM_SDA_TRIS = 1;		// Set SDA pin to input
}

XEE_RESULT XEEBeginWrite(XEE_ADDR address)
{
	if(NeedEndRead)
		while(1);
	if(NeedEndWrite)
		while(1);

	while(XEEIsBusy());

	NeedEndWrite = TRUE;

	// Generate a start condition
	I2CStart();

	// Send "control" byte with device address to slave
	if(I2CPut(EEPROM_CONTROL | WRITE))
		while(1);
	// Send address bytes
	if(I2CPut(((WORD_VAL*)&address)->v[1]))
		while(1);
	if(I2CPut(((WORD_VAL*)&address)->v[0]))
		while(1);
	
	return XEE_SUCCESS;
}

XEE_RESULT XEEBeginRead(XEE_ADDR address)
{
	// Set the address to read from.  This procedure is identical 
	// for reading and writing.
	XEEBeginWrite(address);

	NeedEndRead = TRUE;
	NeedEndWrite = FALSE;

	// Generate a start condition
	I2CStart();

	// Send "control" byte with device address to slave
	if(I2CPut(EEPROM_CONTROL | READ))
		while(1);
	
	return XEE_SUCCESS;
}

XEE_RESULT XEEEndWrite(void)
{
	if(!NeedEndWrite)
		while(1);
	if(NeedEndRead)
		while(1);

	NeedEndWrite = FALSE;

	// Generate a STOP condition
	I2CStop();
}

XEE_RESULT XEEWrite(unsigned char val)
{
	if(!NeedEndWrite)
		while(1);
	if(NeedEndRead)
		while(1);

	// Send data byte
	if(I2CPut(val))
		while(1);

	return XEE_SUCCESS;
}

unsigned char XEERead(void)
{
	if(NeedEndWrite)
		while(1);
	if(!NeedEndRead)
		while(1);

	if(NeedACK)
	{
		NeedACK = FALSE;
		I2CAck(FALSE);
	}

	NeedACK = TRUE;

	// Receive a byte	
	return I2CGet();
}

XEE_RESULT XEEEndRead(void)
{
	if(NeedEndWrite)
		while(1);
	if(!NeedEndRead)
		while(1);

	NeedEndRead = FALSE;

	// Send a NACK to complete the read
	I2CAck(TRUE);
	NeedACK = FALSE;

	// Generate a STOP condition
	I2CStop();

	DelayMs(1);//TODO: debug

    return XEE_SUCCESS;
}

XEE_RESULT XEEReadArray(XEE_ADDR address, unsigned char *buffer, unsigned char length)
{
    XEEBeginRead(address);
    while(length--)
        *buffer++ = XEERead();
    XEEEndRead();

    return XEE_SUCCESS;
}

BOOL XEEIsBusy(void)
{
	BOOL i;

	if(NeedEndWrite)
		while(1);
	if(NeedEndRead)
		while(1);

	// Generate a start condition
	I2CStart();

	// Send "control" byte with device address to slave
	i = I2CPut(EEPROM_CONTROL | WRITE);

	// Generate a STOP condition
	I2CStop();

	return i;
}


//
///*********************************************************************
// * Function:        void XEEInit(unsigned char baud)
// *
// * PreCondition:    None
// *
// * Input:           baud    - SSPADD value for bit rate.
// *
// * Output:          None
// *
// * Side Effects:    None
// *
// * Overview:        Initialize I2C module to communicate to serial
// *                  EEPROM.
// *
// * Note:            None
// ********************************************************************/
//void XEEInit(BYTE baud)
//{
//
//#if defined(__18CXX)
//	EEPROM_SCL_TRIS = 1;		// Set SCL pin to output
//	EEPROM_SDA_TRIS = 1;		// Set SDA pin to input
//	SSPCON1 = 0x28;				// Set SSPEN and set I2C Master mode
//	SSPADD = (INSTR_FREQ+I2CBAUD/2)/I2CBAUD - 1;
//#elif defined(__C30__)
//	EEPROM_I2CCONbits.I2CEN = 1;
//	#if defined(__dsPIC30F__)	
//		I2CBRG = ((INSTR_FREQ+I2CBAUD/2)/I2CBAUD - (INSTR_FREQ+1111111/2)/1111111)-1; //dsPIC30F only
//	#else						
//		I2CBRG = (INSTR_FREQ+I2CBAUD)/(2*I2CBAUD)-1	// PIC24, dsPIC33
//	#endif
//#endif
//}
//
//
///*********************************************************************
// * Macro:           XEE_RESULT XEEBeginWrite(XEE_ADDR address)
// *
// * PreCondition:    XEEInit() is already called.
// *
// * Input:           control     - data EEPROM control code
// *                  address     - address to where to write
// *
// * Output:          XEE_SUCCESS if successful
// *                  other value if failed.
// *
// * Side Effects:    None
// *
// * Overview:        Sets up internal address counter of EEPROM.
// *
// * Note:            This function does not release the I2C bus.
// *                  User must close XEEEndWrite() after this function
// *                  is called to relase the I2C bus.
// ********************************************************************/
//XEE_RESULT XEEBeginWrite(BYTE control, XEE_ADDR address)
//{
//	if(NeedEndRead)
//		while(1);
//	if(NeedEndWrite)
//		while(1);
//
//	NeedEndWrite = TRUE;
//
//	// Generate a start condition
//	I2CBIT_SEN = 1;
//    while(I2CBIT_SEN);
//
//	// Send "control" byte with device address to slave
//	do
//	{
//		I2CBIT_IWCOL = 0;
//		I2C_DATA_OUT = EEPROM_CONTROL | WRITE;
//	} while(I2CBIT_IWCOL);
//	while(I2CBIT_TRSTAT);
//	if(I2CBIT_ACKSTAT)
//		while(1);
//
//	// Send address bytes
//	do
//	{
//		I2CBIT_IWCOL = 0;
//		I2C_DATA_OUT = ((WORD_VAL*)&address)->v[1];
//	} while(I2CBIT_IWCOL);
//	while(I2CBIT_TRSTAT);
//	if(I2CBIT_ACKSTAT)
//		while(1);
//	do
//	{
//		I2CBIT_IWCOL = 0;
//		I2C_DATA_OUT = ((WORD_VAL*)&address)->v[0];
//	} while(I2CBIT_IWCOL);
//	while(I2CBIT_TRSTAT);
//	if(I2CBIT_ACKSTAT)
//		while(1);
//	
//	return XEE_SUCCESS;
//}
//
///*********************************************************************
// * Function:        XEE_RESULT XEEBeginRead(XEE_ADDR address)
// *
// * PreCondition:    XEEInit() is already called.
// *
// * Input:           control - EEPROM control and address code.
// *                  address - Address at which read is to be performed.
// *
// * Output:          XEE_SUCCESS if successful
// *                  other value if failed.
// *
// * Side Effects:    None
// *
// * Overview:        Sets internal address counter to given address.
// *                  Puts EEPROM in sequential read mode.
// *
// * Note:            This function does not release I2C bus.
// *                  User must call XEEEndRead() when read is not longer
// *                  needed; I2C bus will released after XEEEndRead()
// *                  is called.
// ********************************************************************/
//XEE_RESULT XEEBeginRead(BYTE control, XEE_ADDR address)
//{
//	if(NeedEndWrite)
//		while(1);
//	if(NeedEndRead)
//		while(1);
//
//
//	// Set the address to read from.  This procedure is identical 
//	// for reading and writing.
//	XEEBeginWrite(0, address);
//
//	NeedEndRead = TRUE;
//	NeedEndWrite = FALSE;
//
////	// Generate a STOP condition
////	I2CBIT_PEN = 1;
////	while(I2CBIT_PEN);
//
//
//	EEPROM_SCL_TRIS = 1;
//
//	// Generate a start condition
//	I2CBIT_SEN = 1;
//    while(I2CBIT_SEN);
//
//	// Send "control" byte with device address to slave
//	do
//	{
//		I2CBIT_IWCOL = 0;
//		I2C_DATA_OUT = EEPROM_CONTROL | READ;
//	} while(I2CBIT_IWCOL);
//	while(I2CBIT_TRSTAT);
//	if(I2CBIT_ACKSTAT)
//		while(1);
//	
//	return XEE_SUCCESS;
//}
//
//
//XEE_RESULT XEEWrite(unsigned char val)
//{
//	if(!NeedEndWrite)
//		while(1);
//	if(NeedEndRead)
//		while(1);
//
//	// Send data byte
//	do
//	{
//		I2CBIT_IWCOL = 0;
//		I2C_DATA_OUT = val;
//	} while(I2CBIT_IWCOL);
//	while(I2CBIT_TRSTAT);
//	if(I2CBIT_ACKSTAT)
//		while(1);
//
//	return XEE_SUCCESS;
//}
//
///*********************************************************************
// * Function:        XEE_RESULT XEEEndWrite(void)
// *
// * PreCondition:    XEEInit() && XEEBeginWrite() are already called.
// *
// * Input:           None
// *
// * Output:          XEE_SUCCESS if successful
// *                  other value if failed.
// *
// * Side Effects:    None
// *
// * Overview:        Instructs EEPROM to begin write cycle.
// *
// * Note:            Call this function after either page full of bytes
// *                  written or no more bytes are left to load.
// *                  This function initiates the write cycle.
// *                  User must call for XEEWait() to ensure that write
// *                  cycle is finished before calling any other
// *                  routine.
// ********************************************************************/
//XEE_RESULT XEEEndWrite(void)
//{
//	if(!NeedEndWrite)
//		while(1);
//	if(NeedEndRead)
//		while(1);
//
//	NeedEndWrite = FALSE;
//
//	// Generate a STOP condition
//	I2CBIT_PEN = 1;
//	while(I2CBIT_PEN);
//
//	DelayMs(5);
//
//}
//
//
//
///*********************************************************************
// * Function:        XEE_RESULT XEERead(void)
// *
// * PreCondition:    XEEInit() && XEEBeginRead() are already called.
// *
// * Input:           None
// *
// * Output:          XEE_SUCCESS if successful
// *                  other value if failed.
// *
// * Side Effects:    None
// *
// * Overview:        Reads next byte from EEPROM; internal address
// *                  is incremented by one.
// *
// * Note:            This function does not release I2C bus.
// *                  User must call XEEEndRead() when read is not longer
// *                  needed; I2C bus will released after XEEEndRead()
// *                  is called.
// ********************************************************************/
//unsigned char XEERead(void)
//{
//	volatile BYTE i;
//	
//	if(NeedEndWrite)
//		while(1);
//	if(!NeedEndRead)
//		while(1);
//
//	if(NeedACK)
//	{
//		NeedACK = FALSE;
//		I2CBIT_ACKDT = 0;
//		I2CBIT_ACKEN = 1;
//		while(I2CBIT_ACKEN);
//	}
//
//	// Receive a byte
//	I2CBIT_RCEN = 1;
//	while(I2CBIT_RCEN);
//	NeedACK = TRUE;
//
//	i = I2C_DATA_IN;
//    return i;
//}
//
///*********************************************************************
// * Function:        XEE_RESULT XEEEndRead(void)
// *
// * PreCondition:    XEEInit() && XEEBeginRead() are already called.
// *
// * Input:           None
// *
// * Output:          XEE_SUCCESS if successful
// *                  other value if failed.
// *
// * Side Effects:    None
// *
// * Overview:        Ends sequential read cycle.
// *
// * Note:            This function ends seuential cycle that was in
// *                  progress.  It releases I2C bus.
// ********************************************************************/
//XEE_RESULT XEEEndRead(void)
//{
//	if(NeedEndWrite)
//		while(1);
//	if(!NeedEndRead)
//		while(1);
//
//	NeedEndRead = FALSE;
//
//	// Send a NACK to complete the read
//	I2CBIT_ACKDT = 1;
//	I2CBIT_ACKEN = 1;
//	while(I2CBIT_ACKEN);
//	NeedACK = FALSE;
//
//	// Generate a STOP condition
//	I2CBIT_PEN = 1;
//	while(I2CBIT_PEN);
//
//    return XEE_SUCCESS;
//}
//
//
///*********************************************************************
// * Function:        XEE_RESULT XEEReadArray(XEE_ADDR address,
// *                                          unsigned char *buffer,
// *                                          unsigned char length)
// *
// * PreCondition:    XEEInit() is already called.
// *
// * Input:           control     - EEPROM control and address code.
// *                  address     - Address from where array is to be read
// *                  buffer      - Caller supplied buffer to hold the data
// *                  length      - Number of bytes to read.
// *
// * Output:          XEE_SUCCESS if successful
// *                  other value if failed.
// *
// * Side Effects:    None
// *
// * Overview:        Reads desired number of bytes in sequential mode.
// *                  This function performs all necessary steps
// *                  and releases the bus when finished.
// *
// * Note:            None
// ********************************************************************/
//XEE_RESULT XEEReadArray(BYTE control, XEE_ADDR address,
//                        unsigned char *buffer,
//                        unsigned char length)
//{
//    XEEBeginRead(0, address);
//    while(length--)
//        *buffer++ = XEERead();
//    XEEEndRead();
//
//    return XEE_SUCCESS;
//}
//
//
///*********************************************************************
// * Function:        BOOL XEEIsBusy(void)
// *
// * PreCondition:    XEEInit() is already called.
// *
// * Input:           None
// *
// * Output:          FALSE if EEPROM is not busy
// *                  TRUE if EEPROM is busy or operation failed
// *
// * Side Effects:    None
// *
// * Overview:        Requests ACK from EEPROM.
// *
// * Note:            None
// ********************************************************************/
//BOOL XEEIsBusy(BYTE control)
//{
//	if(NeedEndWrite)
//		while(1);
//	if(NeedEndRead)
//		while(1);
//
//	// Generate a start condition
//	I2CBIT_SEN = 1;
//    while(I2CBIT_SEN);
//
//	// Send "control" byte with device address to slave
//	do
//	{
//		I2CBIT_IWCOL = 0;
//		I2C_DATA_OUT = EEPROM_CONTROL | WRITE;
//	} while(I2CBIT_IWCOL);
//	while(I2CBIT_TRSTAT);
//
//	// Generate a STOP condition
//	I2CBIT_PEN = 1;
//	while(I2CBIT_PEN);
//
//	return I2CBIT_ACKSTAT;
//}
//

#endif //#if defined(MPFS_USE_EEPROM) && defined(EEPROM_SCL_TRIS) && defined(STACK_USE_MPFS)
