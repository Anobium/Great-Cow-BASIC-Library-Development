/*****************************************************************************
 *  Module for Microchip Graphics Library
 *  LCD controller driver
 *  ILI9326
 *****************************************************************************
 * FileName:        ILI9326.c
 * Dependencies:    Graphics.h
 * Processor:       PIC32
 * Compiler:        MPLAB C32
 * Linker:          MPLAB LINK32
 * Company:         
 * Contacts:        
 *
 * Software License Agreement
 *
  * SOFTWARE AND DOCUMENTATION ARE PROVIDED “AS IS” WITHOUT WARRANTY OF ANY
 * KIND, EITHER EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION, ANY WARRANTY
 * OF MERCHANTABILITY, TITLE, NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR
 * PURPOSE. IN NO EVENT SHALL MICROCHIP OR ITS LICENSORS BE LIABLE OR
 * OBLIGATED UNDER CONTRACT, NEGLIGENCE, STRICT LIABILITY, CONTRIBUTION,
 * BREACH OF WARRANTY, OR OTHER LEGAL EQUITABLE THEORY ANY DIRECT OR INDIRECT
 * DAMAGES OR EXPENSES INCLUDING BUT NOT LIMITED TO ANY INCIDENTAL, SPECIAL,
 * INDIRECT, PUNITIVE OR CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA,
 * COST OF PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY, SERVICES, OR ANY
 * CLAIMS BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF),
 * OR OTHER SIMILAR COSTS.
 *
 * Author               Date        Comment
 *~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * LPs                 03/08/11	Version 1.0 first release
 * LPs                 03/14/11	Version 1.1 Fast primitives
 *****************************************************************************/
#include "HardwareProfile.h"
#include "Graphics/Graphics.h"

//#define LINE_MEM_PITCH   240

// Color
WORD_VAL    _color;

// Clipping region control
SHORT       _clipRgn;

// Clipping region borders
SHORT       _clipLeft;
SHORT       _clipTop;
SHORT       _clipRight;
SHORT       _clipBottom;

/////////////////////// LOCAL FUNCTIONS PROTOTYPES ////////////////////////////
void        SetReg(WORD index, WORD value);
void        PutImage1BPP(SHORT left, SHORT top, FLASH_BYTE *bitmap, BYTE stretch);
void        PutImage4BPP(SHORT left, SHORT top, FLASH_BYTE *bitmap, BYTE stretch);
void        PutImage8BPP(SHORT left, SHORT top, FLASH_BYTE *bitmap, BYTE stretch);
void        PutImage16BPP(SHORT left, SHORT top, FLASH_BYTE *bitmap, BYTE stretch);

void        PutImage1BPPExt(SHORT left, SHORT top, void *bitmap, BYTE stretch);
void        PutImage4BPPExt(SHORT left, SHORT top, void *bitmap, BYTE stretch);
void        PutImage8BPPExt(SHORT left, SHORT top, void *bitmap, BYTE stretch);
void        PutImage16BPPExt(SHORT left, SHORT top, void *bitmap, BYTE stretch);

void MainLCD_SleepIn(void);
void MainLCD_SleepOut(void);
void MainLCD_EnterStandby(void);
void MainLCD_ExitStandby(void);

/*********************************************************************
* Macro:  WritePixel(color)
*
* PreCondition: none
*
* Input: color 
*
* Output: none
*
* Side Effects: none
*
* Overview: writes pixel at the current address
*
* Note: chip select should be enabled
*
********************************************************************/
#define WritePixel(data) {PMDIN1 = data; PMPWaitBusy();}

/*********************************************************************
* Macros:  PMPWaitBusy()
*
* Overview: waits for PMP cycle end.
*
* PreCondition: none
*
* Input: none
*
* Output: none
*
* Side Effects: none
*
********************************************************************/
#define PMPWaitBusy()  while(PMMODEbits.BUSY);

/*********************************************************************
* Macros:  SetAddress(addr)
*
* Overview: Writes address pointer.
*
* PreCondition: none
*
* Input: add0 -  32-bit address.
*
* Output: none
*
* Side Effects: none
*
********************************************************************/
void SetAddress ( DWORD addr )
{
	// Set of first start coordinate
	SetReg(0x0200, addr & 0x000000FF);
	// Set of second start coordinate
	SetReg(0x0201, addr >> 8);
	
	// Display enable
	CS_LAT_BIT = 0;
	// Register signal
	RS_LAT_BIT = 0;
	
	// Register address on PMP
	PMDIN1 = 0x0202;
	// wait for the transmission end
	PMPWaitBusy();         

	// Following data will not be register address
	RS_LAT_BIT = 1;
}

/*********************************************************************
* Function:  void  SetReg(WORD index, WORD value)
*
* PreCondition: none
*
* Input: index - register number
*        value - value to be set
*
* Output: none
*
* Side Effects: none
*
* Overview: sets graphics controller register
*
* Note: none
*
********************************************************************/
void SetReg(WORD index, WORD value)
{
//#ifdef USE_16BIT_PMP
	
	// Display enable
	CS_LAT_BIT = 0;
	// Register signal
	RS_LAT_BIT = 0;

	// Register address on PMP
	PMDIN1 = index;
	// wait for the transmission end
	PMPWaitBusy();         

	// Following data will not be a register address
	RS_LAT_BIT = 1;
	
	// Emit data to be wrote
	PMDIN1 = value;
	// wait for the transmission end
	PMPWaitBusy();         
	
	// Display disable
	CS_LAT_BIT = 1;	
/*#else
	CS_LAT_BIT = 0;
	DisplaySetCommand();
	DeviceWrite(((WORD_VAL)index).v[1]);
	DeviceWrite(((WORD_VAL)index).v[0]);
	DisplaySetData();
	DeviceWrite(((WORD_VAL)value).v[1]);
	DeviceWrite(((WORD_VAL)value).v[0]);
	CS_LAT_BIT = 1;
#endif*/
}

/*********************************************************************
* Function:  void ResetDevice()
*
* PreCondition: none
*
* Input: none
*
* Output: none
*
* Side Effects: none
*
* Overview: resets LCD, initializes PMP
*
* Note: none
*
********************************************************************/
void ResetDevice(void)
{
	unsigned int x;
	unsigned short y = 0;
	
    RST_LAT_BIT = 1;       // hold in reset by default
    RST_TRIS_BIT = 0;      // enable RESET line

    RS_TRIS_BIT = 0;       // enable RS line 

    CS_LAT_BIT = 1;        // SSD1926 is not selected by default
    CS_TRIS_BIT = 0;       // enable 1926 CS line    

    // PMP setup 
    PMMODE = 0; PMAEN = 0; PMCON = 0;
    PMMODEbits.MODE   = 2;  // Intel 80 master interface

    PMMODEbits.WAITB  = 0;
    PMMODEbits.WAITM  = 3;

#ifdef USE_16BIT_PMP
    PMMODEbits.MODE16 = 1;  // 16 bit mode
#else
    PMMODEbits.MODE16 = 0;  // 8 bit mode
#endif

    PMCONbits.PTRDEN = 1;  // enable RD line
    PMCONbits.PTWREN = 1;  // enable WR line
    PMCONbits.PMPEN  = 1;  // enable PMP(parallel master port)

	// Display reset
	RST_LAT_BIT = 1;
	DelayMs(1);
	RST_LAT_BIT = 0;
	DelayMs(10); 
	RST_LAT_BIT = 1;
	DelayMs(50);

	//************* Start Initial Sequence **********//
	SetReg(0x0702, 0x3008);// Set internal timing,don?t change this value
	SetReg(0x0705, 0x0036);// Set internal timing,don?t change this value
	SetReg(0x070B, 0x1213);// Set internal timing,don?t change this value

	SetReg(0x0001, 0x0100);// set SS and SM bit
	SetReg(0x0002, 0x0100);// set 1 line inversion

	#if (DISP_ORIENTATION == 0)
		SetReg(0x0003, 0x1030); // Set GRAM write directions
	#elif (DISP_ORIENTATION == 90)
		SetReg(0x0003, 0x1028);// Set GRAM write directions
	#elif (DISP_ORIENTATION == 180)
		SetReg(0x0003, 0x1000);// Set GRAM write directions
	#elif (DISP_ORIENTATION == 270)
		SetReg(0x0003, 0x1018);// Set GRAM write directions
	#endif
	
	SetReg(0x0008, 0x0808);// set the back porch and front porch
	SetReg(0x0009, 0x0000);// set non-display area refresh cycle ISC[3:0]
	SetReg(0x000C, 0x0000);// RGB interface setting 16 bits color depth
	SetReg(0x000F, 0x0000);// RGB interface polarity
	
	//*************Power On sequence ****************//
	SetReg(0x0100, 0x0000);// SAP,BT[3:0],AP,DSTB,SLP,STB
	SetReg(0x0102, 0x0000);// VREG1OUT voltage
	SetReg(0x0103, 0x0000);// VDV[4:0] for VCOM amplitude
	DelayMs(200);                         // Dis-charge capacitor power voltage
	SetReg(0x0100, 0x1190);// SAP,BT[3:0],AP,DSTB,SLP,STB
	SetReg(0x0101, 0x0017);// DC1[2:0],DC0[2:0],VC[2:0]
	DelayMs(50);                          // Delay 50ms
	SetReg(0x0102, 0x01BD);// VREG1OUT voltage
	DelayMs(50);                          // Delay 50ms
	SetReg(0x0103, 0x3500);// VDV[4:0] for VCOM amplitude
	SetReg(0x0281, 0x0017);// VCM[5:0] for VCOMH
	DelayMs(50);
	SetReg(0x0200, 0x0000);// GRAM horizontal Address
	SetReg(0x0201, 0x0000);// GRAM Vertical Address	

	// ----------- Adjust the Gamma Curve ----------//
	SetReg(0x0300, 0x0000);
	SetReg(0x0301, 0x0707);
	SetReg(0x0302, 0x0606);
	SetReg(0x0305, 0x0006);
	SetReg(0x0306, 0x0A09);
	SetReg(0x0307, 0x0203);
	SetReg(0x0308, 0x0005);
	SetReg(0x0309, 0x0007);
	SetReg(0x030C, 0x0400);
	SetReg(0x030D, 0x000A);
	
	//------------------ Set GRAM area ---------------//
	SetReg(0x0210, 0x0000);// Horizontal GRAM Start Address
	SetReg(0x0211, 0x00EF);// Horizontal GRAM End Address
	SetReg(0x0212, 0x0000);// Vertical GRAM Start Address
	SetReg(0x0213, 0x01AF);// Vertical GRAM Start Address
	SetReg(0x0400, 0x3500);// Gate Scan Line 432 lines
	SetReg(0x0401, 0x0001);// NDL,VLE,REV
	SetReg(0x0404, 0x0000);// set scrolling line
	
	//-------------- Partial Display Control ---------//
	SetReg(0x0500, 0x0000);// Partial Image 1 Display Position
	SetReg(0x0501, 0x0000);// Partial Image 1 RAM Start/End Address
	SetReg(0x0502, 0x0000);// Partial Image 1 RAM Start/End Address
	SetReg(0x0503, 0x0000);// Partial Image 2 Display Position
	SetReg(0x0504, 0x0000);// Partial Image 2 RAM Start/End Address
	SetReg(0x0505, 0x0000);// Partial Image 2 RAM Start/End Address
	
	//-------------- Panel Control -------------------//
	SetReg(0x0010, 0x0010);// DIVI[1:0];RTNI[4:0]
	SetReg(0x0011, 0x0000);// NOWI[2:0];SDTI[2:0]
	SetReg(0x0020, 0x0002);// DIVE[1:0];RTNE[5:0]
	SetReg(0x020B, 0x0000);// DIVE[1:0];RTNE[5:0]
	SetReg(0x0007, 0x0173);// 262K color and display ON	
	
	// Backlight switch on
	BL_TRIS_BIT	= 0;
	BL_LAT_BIT = 1;	
}

void MainLCD_SleepIn(void)
{
	SetReg(0x0007, 0x0131);// Set D1=0, D0=1
	DelayMs(10);
	SetReg(0x0007, 0x0130);// Set D1=0, D0=0
	DelayMs(10);
	SetReg(0x0007, 0x0000);// display OFF
	SetReg(0x0100, 0x0000);
	DelayMs(200);
	SetReg(0x0100, 0x0002);	
}

void MainLCD_SleepOut(void)
{
	SetReg(0x0100, 0x0000);// SAP, BT[3:0], AP, SLP, STB
	DelayMs(200);
	SetReg(0x0100, 0x1190);// SAP, BT[3:0], AP, SLP, STB
	SetReg(0x0101, 0x0017);// DC1[2:0], DC0[2:0], VC[2:0]
	DelayMs(50);
	SetReg(0x0102, 0x01BD);// VREG1OUT voltage
	DelayMs(50);
	SetReg(0x0103, 0x3500);// VDV[4:0] for VCOM amplitude
	DelayMs(50);
	SetReg(0x0007, 0x0173);// display ON
}

void MainLCD_EnterStandby(void)
{
	SetReg(0x0007, 0x0131);// Set D1=0, D0=1
	DelayMs(10);
	SetReg(0x0007, 0x0130);// Set D1=0, D0=0
	DelayMs(10);
	SetReg(0x0007, 0x0000);// display OFF
	SetReg(0x0100, 0x0000);
	DelayMs(200);
	SetReg(0x0100, 0x0001);	
}

void MainLCD_ExitStandby(void)
{
	SetReg(0x0100, 0x0000);// SAP, BT[3:0], AP, SLP, STB
	DelayMs(200);
	SetReg(0x0100, 0x1190);// SAP, BT[3:0], AP, SLP, STB
	SetReg(0x0101, 0x0017);// DC1[2:0], DC0[2:0], VC[2:0]
	DelayMs(50);
	SetReg(0x0102, 0x01BD);// VREG1OUT voltage
	DelayMs(50);
	SetReg(0x0103, 0x3500);// VDV[4:0] for VCOM amplitude
	DelayMs(50);
	SetReg(0x0007, 0x0173);// display ON
}


/*********************************************************************
* Function: void PutPixel(SHORT x, SHORT y)
*
* PreCondition: none
*
* Input: x,y - pixel coordinates
*
* Output: none
*
* Side Effects: none
*
* Overview: puts pixel
*
* Note: none
*
********************************************************************/
void PutPixel(SHORT x, SHORT y)
{
	DWORD address;
	
	// Checks of coordinates boundaries
	if(_clipRgn)
	{
		if(x < _clipLeft)
			return;
		if(x > _clipRight)
			return;
		if(y < _clipTop)
			return;
		if(y > _clipBottom)
			return;
	}
	
	// Coordinates transaltion to the GRAM address of controller
	#if (DISP_ORIENTATION == 0)
		address = (y * 0x100) + x;
	#elif (DISP_ORIENTATION == 90)
		address = (x * 0x100) + (GetMaxY()-y);
	#elif (DISP_ORIENTATION == 180)
		address = ((GetMaxY() - y) * 0x100) + (GetMaxX()-x);
	#elif (DISP_ORIENTATION == 270)
		address = ((GetMaxX() - x) * 0x100) + y;
	#endif
/*
	// Coordinates transaltion to the GRAM address of controller
	#if (DISP_ORIENTATION == 0)
		address = (y * 0x100) + x;
	#elif (DISP_ORIENTATION == 90)
		address = (x * 0x100) + (LINE_MEM_PITCH-y);
	#elif (DISP_ORIENTATION == 180)
		address = ((432 - y) * 0x100) + (LINE_MEM_PITCH-x);
	#elif (DISP_ORIENTATION == 270)
		address = ((432 - x) * 0x100) + y;
	#endif
*/
	// Set address of pixel
	SetAddress(address);
	// Write a pixel to the GRAM
	WritePixel(_color.Val);
	// Disaply disable
	CS_LAT_BIT = 1;
}

/*********************************************************************
* Function: WORD GetPixel(SHORT x, SHORT y)
*
* PreCondition: none
*
* Input: x,y - pixel coordinates 
*
* Output: pixel color
*
* Side Effects: none
*
* Overview: returns pixel color at x,y position
*
* Note: none
*
********************************************************************/
/*
#ifndef __PIC24FJ256GB210__
#ifdef USE_16BIT_PMP


WORD GetPixel(SHORT x, SHORT y)
{
    DWORD   address;
    WORD    result;
        #if (DISP_ORIENTATION == 0)
    address = (long)LINE_MEM_PITCH * y + x;
        #else
    y = GetMaxY() - y;
    address = (long)LINE_MEM_PITCH * x + y;
        #endif
    CS_LAT_BIT = 0;

    SetAddress(address);

    // Temporary change wait cycles for reading (250ns = 4 cycles)
        #if defined(__C30__)
    PMMODEbits.WAITM = 4;
        #elif defined(__PIC32MX__)
    PMMODEbits.WAITM = 8;
        #else
            #error Need wait states for the device
        #endif
    DisplaySetData();

    // First RD cycle to move data from GRAM to Read Data Latch
    result = PMDIN1;

    while(PMMODEbits.BUSY);

    // Second RD cycle to get data from Read Data Latch
    result = PMDIN1;

    while(PMMODEbits.BUSY);

    // Disable LCD
    CS_LAT_BIT = 1;

    // Disable PMP
    PMCONbits.PMPEN = 1;

    // Read result
    result = PMDIN1;

    // Restore wait cycles for writing (60ns)
        #if defined(__dsPIC33F__) || defined(__PIC24H__)
    PMMODEbits.WAITM = 2;
        #else
    PMMODEbits.WAITM = 1;
        #endif

    // Enable PMP
    PMCONbits.PMPEN = 1;

    return (result);
}

#else


WORD GetPixel(SHORT x, SHORT y)
{
    DWORD       address;
    WORD_VAL    result;

	#if (DISP_ORIENTATION == 0)
		address = (long)LINE_MEM_PITCH * y + x;
	#else
		y = GetMaxY() - y;
		address = (long)LINE_MEM_PITCH * x + y;
	#endif
      
	CS_LAT_BIT = 0;
	
	SetAddress(address);

	// Temporary change wait cycles for reading (250ns = 4 cycles)
	#if defined(__C30__)
		PMMODEbits.WAITM = 4;
	#elif defined(__PIC32MX__)
		PMMODEbits.WAITM = 8;
	#else
		#error Need wait states for the device
	#endif
    
	DisplaySetData();

	// First RD cycle to move data from GRAM to Read Data Latch
	result.v[1] = PMDIN1;
	
	while(PMMODEbits.BUSY);

	#if (DISPLAY_CONTROLLER == ILI9320)
		DelayForSync();
	#endif

	// Second RD cycle to move data from GRAM to Read Data Latch
	result.v[1] = PMDIN1;
	
	while(PMMODEbits.BUSY);
	
	#if (DISPLAY_CONTROLLER == ILI9320)
		DelayForSync();
	#endif

	// First RD cycle to get data from Read Data Latch
	// Read previous dummy value
	result.v[1] = PMDIN1;
	
	while(PMMODEbits.BUSY);
	#if (DISPLAY_CONTROLLER == ILI9320)
		DelayForSync();
	#endif

    // Second RD cycle to get data from Read Data Latch
    // Read MSB
    result.v[1] = PMDIN1;

	while(PMMODEbits.BUSY);
	#if (DISPLAY_CONTROLLER == ILI9320)
		DelayForSync();
	#endif

	// Disable LCD
	CS_LAT_BIT = 1;
	
	// Disable PMP
	PMCONbits.PMPEN = 1;
	
	// Read LSB
	result.v[0] = PMDIN1;
	#if (DISPLAY_CONTROLLER == ILI9320)
		DelayForSync();
	#endif

	// Restore wait cycles for writing (60ns)
	#if defined(__dsPIC33F__) || defined(__PIC24H__)
		PMMODEbits.WAITM = 2;
	#else
		PMMODEbits.WAITM = 1;
	#endif

	// Enable PMP
	PMCONbits.PMPEN = 1;
	
	return (result.Val);
}

#endif
#endif
*/

/*********************************************************************
* Function: WORD PutImage(SHORT left, SHORT top, void* bitmap, BYTE stretch)
*
* PreCondition: none
*
* Input: left,top - left top image corner,
*        bitmap - image pointer,
*        stretch - image stretch factor
*
* Output: For NON-Blocking configuration:
*         - Returns 0 when device is busy and the image is not yet completely drawn.
*         - Returns 1 when the image is completely drawn.
*         For Blocking configuration:
*         - Always return 1.
*
* Side Effects: none
*
* Overview: outputs image starting from left,top coordinates
*
* Note: image must be located in flash
*
********************************************************************/
#ifdef USE_DRV_PUTIMAGE

WORD PutImage(SHORT left, SHORT top, void *bitmap, BYTE stretch)
{
#if defined (USE_BITMAP_FLASH) || defined (USE_BITMAP_EXTERNAL)
    FLASH_BYTE  *flashAddress;
    BYTE        colorDepth;
#endif    
	WORD_VAL    colorTemp;

	#ifndef USE_NONBLOCKING_CONFIG
		while(IsDeviceBusy() != 0);
		
		/* Ready */
	#else
		if(IsDeviceBusy() != 0)
		return (0);
	#endif
	
    // Save current color
    colorTemp = _color;

    switch(*((SHORT *)bitmap))
    {
                #ifdef USE_BITMAP_FLASH

        case FLASH:

            // Image address
            flashAddress = ((IMAGE_FLASH *)bitmap)->address;

            // Read color depth
            colorDepth = *(flashAddress + 1);

            // Draw picture
            switch(colorDepth)
            {
                case 1:     PutImage1BPP(left, top, flashAddress, stretch); break;
                case 4:     PutImage4BPP(left, top, flashAddress, stretch); break;
                case 8:     PutImage8BPP(left, top, flashAddress, stretch); break;
                case 16:    PutImage16BPP(left, top, flashAddress, stretch); break;
            }

            break;
                #endif
                #ifdef USE_BITMAP_EXTERNAL

        case EXTERNAL:

            // Get color depth
            ExternalMemoryCallback(bitmap, 1, 1, &colorDepth);

            // Draw picture
            switch(colorDepth)
            {
                case 1:     PutImage1BPPExt(left, top, bitmap, stretch); break;
                case 4:     PutImage4BPPExt(left, top, bitmap, stretch); break;
                case 8:     PutImage8BPPExt(left, top, bitmap, stretch); break;
                case 16:    PutImage16BPPExt(left, top, bitmap, stretch); break;
                default:    break;
            }

            break;
                #endif

        default:
            break;
    }

    // Restore current color
    _color = colorTemp;
    return (1);
}

#ifdef USE_BITMAP_FLASH

/*********************************************************************
* Function: void PutImage1BPP(SHORT left, SHORT top, FLASH_BYTE* bitmap, BYTE stretch)
*
* PreCondition: none
*
* Input: left,top - left top image corner,
*        bitmap - image pointer,
*        stretch - image stretch factor
*
* Output: none
*
* Side Effects: none
*
* Overview: outputs monochrome image starting from left,top coordinates
*
* Note: image must be located in flash
*
********************************************************************/
void PutImage1BPP(SHORT left, SHORT top, FLASH_BYTE *bitmap, BYTE stretch)
{
    register DWORD      address;
    register FLASH_BYTE *flashAddress;
    register FLASH_BYTE *tempFlashAddress;
    WORD                sizeX, sizeY;
    BYTE                stretchX, stretchY;
    WORD                palette[2];
    BYTE                mask;
    short               i, j;

    // Move pointer to size information
    flashAddress = bitmap + 2;

    // Read image size
    sizeY = *((FLASH_WORD *)flashAddress);
    flashAddress += 2;
    sizeX = *((FLASH_WORD *)flashAddress);
    flashAddress += 2;
    palette[0] = *((FLASH_WORD *)flashAddress);
    flashAddress += 2;
    palette[1] = *((FLASH_WORD *)flashAddress);
    flashAddress += 2;

  	// Coordinates transaltion to the GRAM address of controller
	#if (DISP_ORIENTATION == 0)
		address = (top * 0x100) + left;
	#elif (DISP_ORIENTATION == 90)
		address = (left * 0x100) + (GetMaxY()-top);
	#elif (DISP_ORIENTATION == 180)
		address = ((GetMaxY() - top) * 0x100) + (GetMaxX()-left);
	#elif (DISP_ORIENTATION == 270)
		address = ((GetMaxX() - left) * 0x100) + top;
	#endif

	// In case of no stretch required pixels can be sent sequentially from 1st to the last one
	if (stretch == IMAGE_NORMAL)
	{
		// Coordinates transaltion to the GRAM address of controller
		#if (DISP_ORIENTATION == 0)
			// Set of boundaries of image on the screen
			SetReg (0x0210, left        );
			SetReg (0x0211, left+sizeX-1);
			SetReg (0x0212, top         );
			SetReg (0x0213, top+sizeY-1 );
		#elif (DISP_ORIENTATION == 90)
			// Set of boundaries of image on the screen
			SetReg (0x0210, GetMaxY()-top-(sizeY-1));
			SetReg (0x0211, GetMaxY()-top          );
			SetReg (0x0212, left                   );
			SetReg (0x0213, left+(sizeX-1)         );
		#elif (DISP_ORIENTATION == 180)
			// Set of boundaries of image on the screen
			SetReg (0x0210, GetMaxX()-left-(sizeX-1));
			SetReg (0x0211, GetMaxX()-left          );
			SetReg (0x0212, GetMaxY()-top-(sizeY-1) );
			SetReg (0x0213, GetMaxY()-top           );
		#elif (DISP_ORIENTATION == 270)
			// Set of boundaries of image on the screen
			SetReg (0x0210, top                     );
			SetReg (0x0211, top+(sizeY-1)           );
			SetReg (0x0212, GetMaxX()-left-(sizeX-1));
			SetReg (0x0213, GetMaxX()-left          );
		#endif
		
		// Set the starting point coordinates
		SetAddress(address);
				
		for (i=0; i<sizeY; i++)
		{
			// Start value of bitmask
			mask = 0x80;
			for (j=0; j<sizeX; j++)
			{
				// reset of bitmask and byte change
				if (mask == 0) 
				{
					mask = 0x80;
					flashAddress++;
				}	
				
				// Put the pixel on screen
				if(*flashAddress & mask)
				{
					WritePixel(palette[1]);
				}
				else
				{
					WritePixel(palette[0]);
				}		
				
				// next bit to test
				mask >>= 1;
			}	
			// Next byte
			flashAddress++;
		}			
	}
	else
	{
		// Coordinates transaltion to the GRAM address of controller
		#if (DISP_ORIENTATION == 0)
			// Set of boundaries of image on the screen
			SetReg (0x0210, left             );
			SetReg (0x0211, left+(sizeX*2)-1 );
			SetReg (0x0212, top              );
			SetReg (0x0213, top+((sizeY*2)-1));
		#elif (DISP_ORIENTATION == 90)
			// Set of boundaries of image on the screen
			SetReg (0x0210, GetMaxY()-top-((sizeY*2)-1));
			SetReg (0x0211, GetMaxY()-top              );
			SetReg (0x0212, left                       );
			SetReg (0x0213, left+((sizeX*2)-1)         );
		#elif (DISP_ORIENTATION == 180)
			// Set of boundaries of image on the screen
			SetReg (0x0210, GetMaxX()-left-((sizeX*2)-1));
			SetReg (0x0211, GetMaxX()-left              );
			SetReg (0x0212, GetMaxY()-top-((sizeY*2)-1) );
			SetReg (0x0213, GetMaxY()-top               );
		#elif (DISP_ORIENTATION == 270)
			// Set of boundaries of image on the screen
			SetReg (0x0210, top                         );
			SetReg (0x0211, top+((sizeY*2)-1)           );
			SetReg (0x0212, GetMaxX()-left-((sizeX*2)-1));
			SetReg (0x0213, GetMaxX()-left              );
		#endif
				
		// Set the starting point coordinates
		SetAddress(address);
				
		for (i=0; i<sizeY; i++)
		{
			// Store start byte
			tempFlashAddress = flashAddress;
			// Number of multiplier of lines
			for(stretchY = 0; stretchY < stretch; stretchY++)
			{
				// init of start byte
				flashAddress = tempFlashAddress;
				// Init of bit mask
				mask = 0x80;
				for (j=0; j<sizeX; j++)
				{
					// reset of bitmask and byte change
					if (mask == 0) 
					{
						mask = 0x80;
						flashAddress++;
					}	
					
					// Double putpixel for X2 image
					if(*flashAddress & mask)
					{
						WritePixel(palette[1]);
						WritePixel(palette[1]);
					}
					else
					{
						WritePixel(palette[0]);
						WritePixel(palette[0]);
					}		
					
					// Next bit to test
					mask >>= 1;
				}	
			}		
			// Nex byte
			flashAddress++;	
		}			
	}

	// Display disable	
	CS_LAT_BIT = 1;
	
	// Restor original full screen boundaries
	SetReg(0x0210, 0x0000);// Horizontal GRAM Start Address
	SetReg(0x0211, 0x00EF);// Horizontal GRAM End Address
	SetReg(0x0212, 0x0000);// Vertical GRAM Start Address
	SetReg(0x0213, 0x01AF);// Vertical GRAM Start Address			
}

/*********************************************************************
* Function: void PutImage4BPP(SHORT left, SHORT top, FLASH_BYTE* bitmap, BYTE stretch)
*
* PreCondition: none
*
* Input: left,top - left top image corner, bitmap - image pointer,
*        stretch - image stretch factor
*
* Output: none
*
* Side Effects: none
*
* Overview: outputs 16 color image starting from left,top coordinates
*
* Note: image must be located in flash
*
********************************************************************/
void PutImage4BPP(SHORT left, SHORT top, FLASH_BYTE *bitmap, BYTE stretch)
{
    register DWORD      address;
    register FLASH_BYTE *flashAddress;
    register FLASH_BYTE *tempFlashAddress;
    WORD                sizeX, sizeY;
    register BYTE       stretchX, stretchY;
    WORD                palette[16];
    short               i, j, Odd_Res;

    // Move pointer to size information
    flashAddress = bitmap + 2;

    // Read image size
    sizeY = *((FLASH_WORD *)flashAddress);
    flashAddress += 2;
    sizeX = *((FLASH_WORD *)flashAddress);
    flashAddress += 2;

	// Read palette
	for(i = 0; i < 16; i++)
	{
		palette[i] = *((FLASH_WORD *)flashAddress);
		flashAddress += 2;
	}

  	// Coordinates transaltion to the GRAM address of controller
	#if (DISP_ORIENTATION == 0)
		address = (top * 0x100) + left;
	#elif (DISP_ORIENTATION == 90)
		address = (left * 0x100) + (GetMaxY()-top);
	#elif (DISP_ORIENTATION == 180)
		address = ((GetMaxY() - top) * 0x100) + (GetMaxX()-left);
	#elif (DISP_ORIENTATION == 270)
		address = ((GetMaxX() - left) * 0x100) + top;
	#endif

	// In case of no stretch required pixels can be sent sequentially from 1st to the last one
	if (stretch == IMAGE_NORMAL)
	{
		// Coordinates transaltion to the GRAM address of controller
		#if (DISP_ORIENTATION == 0)
			// Set of boundaries of image on the screen
			SetReg (0x0210, left        );
			SetReg (0x0211, left+sizeX-1);
			SetReg (0x0212, top         );
			SetReg (0x0213, top+sizeY-1 );
		#elif (DISP_ORIENTATION == 90)
			// Set of boundaries of image on the screen
			SetReg (0x0210, GetMaxY()-top-(sizeY-1));
			SetReg (0x0211, GetMaxY()-top          );
			SetReg (0x0212, left                   );
			SetReg (0x0213, left+(sizeX-1)         );
		#elif (DISP_ORIENTATION == 180)
			// Set of boundaries of image on the screen
			SetReg (0x0210, GetMaxX()-left-(sizeX-1));
			SetReg (0x0211, GetMaxX()-left          );
			SetReg (0x0212, GetMaxY()-top-(sizeY-1) );
			SetReg (0x0213, GetMaxY()-top           );
		#elif (DISP_ORIENTATION == 270)
			// Set of boundaries of image on the screen
			SetReg (0x0210, top                     );
			SetReg (0x0211, top+(sizeY-1)           );
			SetReg (0x0212, GetMaxX()-left-(sizeX-1));
			SetReg (0x0213, GetMaxX()-left          );
		#endif
		
		// Set the starting point coordinates
		SetAddress(address);
		
		// Check of horizontal resolution
		Odd_Res = (sizeX%2);
		
		for (i=0; i<sizeY; i++)
		{
			for (j=0; j<sizeX; j++)
			{              
				if (j & 0x0001)
				{
					WritePixel(palette[*flashAddress++ & 0x0F]);
				}
				else
				{
					WritePixel(palette[(*flashAddress & 0xF0) >> 4]);
				}						
			}	
			
			// In case of odd horizontal resolution the last byte is used only for the fisrt 4 bits
			if (Odd_Res) flashAddress++;
		}			
	}
	else
	{
		// Coordinates transaltion to the GRAM address of controller
		#if (DISP_ORIENTATION == 0)
			// Set of boundaries of image on the screen
			SetReg (0x0210, left             );
			SetReg (0x0211, left+(sizeX*2)-1 );
			SetReg (0x0212, top              );
			SetReg (0x0213, top+((sizeY*2)-1));
		#elif (DISP_ORIENTATION == 90)
			// Set of boundaries of image on the screen
			SetReg (0x0210, GetMaxY()-top-((sizeY*2)-1));
			SetReg (0x0211, GetMaxY()-top              );
			SetReg (0x0212, left                       );
			SetReg (0x0213, left+((sizeX*2)-1)         );
		#elif (DISP_ORIENTATION == 180)
			// Set of boundaries of image on the screen
			SetReg (0x0210, GetMaxX()-left-((sizeX*2)-1));
			SetReg (0x0211, GetMaxX()-left              );
			SetReg (0x0212, GetMaxY()-top-((sizeY*2)-1) );
			SetReg (0x0213, GetMaxY()-top               );
		#elif (DISP_ORIENTATION == 270)
			// Set of boundaries of image on the screen
			SetReg (0x0210, top                         );
			SetReg (0x0211, top+((sizeY*2)-1)           );
			SetReg (0x0212, GetMaxX()-left-((sizeX*2)-1));
			SetReg (0x0213, GetMaxX()-left              );
		#endif
				
		// Set the starting point coordinates
		SetAddress(address);
		
		// Calculate if the horizontal resolution is odd or even
		Odd_Res = (sizeX%2);
		
		for (i=0; i<sizeY; i++)
		{
			// Store start byte
			tempFlashAddress = flashAddress;
			// Number of multiplier of lines
			for(stretchY = 0; stretchY < stretch; stretchY++)
			{
				// Init of start byte
				flashAddress = tempFlashAddress;
				for (j=0; j<sizeX; j++)
				{
					// Double putpixel for X2 image
					if (j & 0x00000001)
					{
						WritePixel(palette[*flashAddress   & 0x0F]);
						WritePixel(palette[*flashAddress++ & 0x0F]);
					}
					else
					{
						WritePixel(palette[(*flashAddress & 0xF0) >> 4]);
						WritePixel(palette[(*flashAddress & 0xF0) >> 4]);
					}						
				}	
			}			

			// In case of odd horizontal resolution the last byte is used only for the fisrt 4 bits
			if (Odd_Res) flashAddress++;
		}			
	}

	// Display disable	
	CS_LAT_BIT = 1;
	
	// Restor original full screen boundaries
	SetReg(0x0210, 0x0000);// Horizontal GRAM Start Address
	SetReg(0x0211, 0x00EF);// Horizontal GRAM End Address
	SetReg(0x0212, 0x0000);// Vertical GRAM Start Address
	SetReg(0x0213, 0x01AF);// Vertical GRAM Start Address			
}

/*********************************************************************
* Function: void PutImage8BPP(SHORT left, SHORT top, FLASH_BYTE* bitmap, BYTE stretch)
*
* PreCondition: none
*
* Input: left,top - left top image corner, bitmap - image pointer,
*        stretch - image stretch factor
*
* Output: none
*
* Side Effects: none
*
* Overview: outputs 256 color image starting from left,top coordinates
*
* Note: image must be located in flash
*
********************************************************************/
void PutImage8BPP(SHORT left, SHORT top, FLASH_BYTE *bitmap, BYTE stretch)
{
	register DWORD      address;
	register FLASH_BYTE *flashAddress;
	register FLASH_BYTE *tempFlashAddress;
	WORD                sizeX, sizeY;
	BYTE                stretchX, stretchY;
	WORD                pallete[256];
	short               Size, i ,j;
	
	// Move pointer to size information
	flashAddress = bitmap + 2;

	// Read image size
	sizeY = *((FLASH_WORD *)flashAddress);
	flashAddress += 2;
	sizeX = *((FLASH_WORD *)flashAddress);
	flashAddress += 2;
    
    // Read pallete
    for(i = 0; i < 256; i++)
    {
        pallete[i] = *((FLASH_WORD *)flashAddress);
        flashAddress += 2;
    }
    
  	// Coordinates transaltion to the GRAM address of controller
	#if (DISP_ORIENTATION == 0)
		address = (top * 0x100) + left;
	#elif (DISP_ORIENTATION == 90)
		address = (left * 0x100) + (GetMaxY()-top);
	#elif (DISP_ORIENTATION == 180)
		address = ((GetMaxY() - top) * 0x100) + (GetMaxX()-left);
	#elif (DISP_ORIENTATION == 270)
		address = ((GetMaxX() - left) * 0x100) + top;
	#endif

	// In case of no stretch required pixels can be sent sequentially from 1st to the last one
	if (stretch == IMAGE_NORMAL)
	{
		// Coordinates transaltion to the GRAM address of controller
		#if (DISP_ORIENTATION == 0)
			// Set of boundaries of image on the screen
			SetReg (0x0210, left        );
			SetReg (0x0211, left+sizeX-1);
			SetReg (0x0212, top         );
			SetReg (0x0213, top+sizeY-1 );
		#elif (DISP_ORIENTATION == 90)
			// Set of boundaries of image on the screen
			SetReg (0x0210, GetMaxY()-top-(sizeY-1));
			SetReg (0x0211, GetMaxY()-top          );
			SetReg (0x0212, left                   );
			SetReg (0x0213, left+(sizeX-1)         );
		#elif (DISP_ORIENTATION == 180)
			// Set of boundaries of image on the screen
			SetReg (0x0210, GetMaxX()-left-(sizeX-1));
			SetReg (0x0211, GetMaxX()-left          );
			SetReg (0x0212, GetMaxY()-top-(sizeY-1) );
			SetReg (0x0213, GetMaxY()-top           );
		#elif (DISP_ORIENTATION == 270)
			// Set of boundaries of image on the screen
			SetReg (0x0210, top                     );
			SetReg (0x0211, top+(sizeY-1)           );
			SetReg (0x0212, GetMaxX()-left-(sizeX-1));
			SetReg (0x0213, GetMaxX()-left          );
		#endif

		// Calculate the total pixels numbers
		Size = sizeX * sizeY;
		
		// Set the starting point coordinates
		SetAddress(address);

		// Send of all pixels
		for (i=0; i<Size; i++)
		{	
			WritePixel(pallete[*flashAddress++]);
		}	
	}
	else
	{
		// Coordinates transaltion to the GRAM address of controller
		#if (DISP_ORIENTATION == 0)
			// Set of boundaries of image on the screen
			SetReg (0x0210, left             );
			SetReg (0x0211, left+(sizeX*2)-1 );
			SetReg (0x0212, top              );
			SetReg (0x0213, top+((sizeY*2)-1));
		#elif (DISP_ORIENTATION == 90)
			// Set of boundaries of image on the screen
			SetReg (0x0210, GetMaxY()-top-((sizeY*2)-1));
			SetReg (0x0211, GetMaxY()-top              );
			SetReg (0x0212, left                       );
			SetReg (0x0213, left+((sizeX*2)-1)         );
		#elif (DISP_ORIENTATION == 180)
			// Set of boundaries of image on the screen
			SetReg (0x0210, GetMaxX()-left-((sizeX*2)-1));
			SetReg (0x0211, GetMaxX()-left              );
			SetReg (0x0212, GetMaxY()-top-((sizeY*2)-1) );
			SetReg (0x0213, GetMaxY()-top               );
		#elif (DISP_ORIENTATION == 270)
			// Set of boundaries of image on the screen
			SetReg (0x0210, top                         );
			SetReg (0x0211, top+((sizeY*2)-1)           );
			SetReg (0x0212, GetMaxX()-left-((sizeX*2)-1));
			SetReg (0x0213, GetMaxX()-left              );
		#endif
				
		// Set the starting point coordinates
		SetAddress(address);

		for (i=0; i<sizeY; i++)
		{
			tempFlashAddress = flashAddress;
			for(stretchY = 0; stretchY < stretch; stretchY++)
			{
				flashAddress = tempFlashAddress;
				for (j=0; j<sizeX; j++)
				{
					WritePixel(pallete[*flashAddress]);		
					WritePixel(pallete[*flashAddress++]);		
				}	
			}	
		}	
	}

	// Display disable	
	CS_LAT_BIT = 1;
	
	// Restor original full screen boundaries
	SetReg(0x0210, 0x0000);// Horizontal GRAM Start Address
	SetReg(0x0211, 0x00EF);// Horizontal GRAM End Address
	SetReg(0x0212, 0x0000);// Vertical GRAM Start Address
	SetReg(0x0213, 0x01AF);// Vertical GRAM Start Address			
}

/*********************************************************************
* Function: void PutImage16BPP(SHORT left, SHORT top, FLASH_BYTE* bitmap, BYTE stretch)
*
* PreCondition: none
*
* Input: left,top - left top image corner, bitmap - image pointer,
*        stretch - image stretch factor
*
* Output: none
*
* Side Effects: none
*
* Overview: outputs hicolor image starting from left,top coordinates
*
* Note: image must be located in flash
*
********************************************************************/
void PutImage16BPP(SHORT left, SHORT top, FLASH_BYTE *bitmap, BYTE stretch)
{
	register DWORD      address;
	register FLASH_WORD *flashAddress;
	register FLASH_WORD *tempFlashAddress;
	WORD                sizeX, sizeY;
	register BYTE       stretchX, stretchY;
	short               Size, i, j;

	// Move pointer to size information
	flashAddress = (FLASH_WORD *)bitmap + 1;

	// Read image size
	sizeY = *flashAddress;
	flashAddress++;
	sizeX = *flashAddress;
	flashAddress++;
	
	// Coordinates transaltion to the GRAM address of controller
	#if (DISP_ORIENTATION == 0)
		address = (top * 0x100) + left;
	#elif (DISP_ORIENTATION == 90)
		address = (left * 0x100) + (GetMaxY()-top);
	#elif (DISP_ORIENTATION == 180)
		address = ((GetMaxY() - top) * 0x100) + (GetMaxX()-left);
	#elif (DISP_ORIENTATION == 270)
		address = ((GetMaxX() - left) * 0x100) + top;
	#endif
	
	// In case of no stretch required pixels can be sent sequentially from 1st to the last one
	if (stretch == IMAGE_NORMAL)
	{
		// Coordinates transaltion to the GRAM address of controller
		#if (DISP_ORIENTATION == 0)
			// Set of boundaries of image on the screen
			SetReg (0x0210, left        );
			SetReg (0x0211, left+sizeX-1);
			SetReg (0x0212, top         );
			SetReg (0x0213, top+sizeY-1 );
		#elif (DISP_ORIENTATION == 90)
			// Set of boundaries of image on the screen
			SetReg (0x0210, GetMaxY()-top-(sizeY-1));
			SetReg (0x0211, GetMaxY()-top          );
			SetReg (0x0212, left                   );
			SetReg (0x0213, left+(sizeX-1)         );
		#elif (DISP_ORIENTATION == 180)
			// Set of boundaries of image on the screen
			SetReg (0x0210, GetMaxX()-left-(sizeX-1));
			SetReg (0x0211, GetMaxX()-left          );
			SetReg (0x0212, GetMaxY()-top-(sizeY-1) );
			SetReg (0x0213, GetMaxY()-top           );
		#elif (DISP_ORIENTATION == 270)
			// Set of boundaries of image on the screen
			SetReg (0x0210, top                     );
			SetReg (0x0211, top+(sizeY-1)           );
			SetReg (0x0212, GetMaxX()-left-(sizeX-1));
			SetReg (0x0213, GetMaxX()-left          );
		#endif

		// Calculate the total pixels numbers
		Size = sizeX * sizeY;
		
		// Set the starting point coordinates
		SetAddress(address);

		// Send of all pixels
		for (i=0; i<Size; i++)
		{	
			WritePixel(*flashAddress++);
		}	
	}
	else
	{
		// Coordinates transaltion to the GRAM address of controller
		#if (DISP_ORIENTATION == 0)
			// Set of boundaries of image on the screen
			SetReg (0x0210, left             );
			SetReg (0x0211, left+(sizeX*2)-1 );
			SetReg (0x0212, top              );
			SetReg (0x0213, top+((sizeY*2)-1));
		#elif (DISP_ORIENTATION == 90)
			// Set of boundaries of image on the screen
			SetReg (0x0210, GetMaxY()-top-((sizeY*2)-1));
			SetReg (0x0211, GetMaxY()-top              );
			SetReg (0x0212, left                       );
			SetReg (0x0213, left+((sizeX*2)-1)         );
		#elif (DISP_ORIENTATION == 180)
			// Set of boundaries of image on the screen
			SetReg (0x0210, GetMaxX()-left-((sizeX*2)-1));
			SetReg (0x0211, GetMaxX()-left              );
			SetReg (0x0212, GetMaxY()-top-((sizeY*2)-1) );
			SetReg (0x0213, GetMaxY()-top               );
		#elif (DISP_ORIENTATION == 270)
			// Set of boundaries of image on the screen
			SetReg (0x0210, top                         );
			SetReg (0x0211, top+((sizeY*2)-1)           );
			SetReg (0x0212, GetMaxX()-left-((sizeX*2)-1));
			SetReg (0x0213, GetMaxX()-left              );
		#endif
				
		// Set the starting point coordinates
		SetAddress(address);

		for (i=0; i<sizeY; i++)
		{
			tempFlashAddress = flashAddress;
			for(stretchY = 0; stretchY < stretch; stretchY++)
			{
				flashAddress = tempFlashAddress;
				for (j=0; j<sizeX; j++)
				{
					WritePixel(*flashAddress);		
					WritePixel(*flashAddress++);		
				}	
			}	
		}	
	}

	// Display disable	
	CS_LAT_BIT = 1;
	
	// Restor original full screen boundaries
	SetReg(0x0210, 0x0000);// Horizontal GRAM Start Address
	SetReg(0x0211, 0x00EF);// Horizontal GRAM End Address
	SetReg(0x0212, 0x0000);// Vertical GRAM Start Address
	SetReg(0x0213, 0x01AF);// Vertical GRAM Start Address			
}

#endif
#ifdef USE_BITMAP_EXTERNAL

/*********************************************************************
* Function: void PutImage1BPPExt(SHORT left, SHORT top, void* bitmap, BYTE stretch)
*
* PreCondition: none
*
* Input: left,top - left top image corner, bitmap - image pointer,
*        stretch - image stretch factor
*
* Output: none
*
* Side Effects: none
*
* Overview: outputs monochrome image starting from left,top coordinates
*
* Note: image must be located in external memory
*
********************************************************************/
void PutImage1BPPExt(SHORT left, SHORT top, void *bitmap, BYTE stretch)
{
    register DWORD  address;
    register DWORD  memOffset;
    BITMAP_HEADER   bmp;
    WORD            pallete[2];
    BYTE            lineBuffer[((GetMaxX() + 1) / 8) + 1];
    BYTE            *pData;
    SHORT           byteWidth;

    BYTE            temp = 0;
    BYTE            mask;
    WORD            sizeX, sizeY;
    WORD            x, y;
    BYTE            stretchX, stretchY;

    // Set start address
            #if (DISP_ORIENTATION == 0)
    address = (long)LINE_MEM_PITCH * top + left;
            #else
    address = (long)LINE_MEM_PITCH * left + top;
            #endif

    // Get bitmap header
    ExternalMemoryCallback(bitmap, 0, sizeof(BITMAP_HEADER), &bmp);

    // Get pallete (2 entries)
    ExternalMemoryCallback(bitmap, sizeof(BITMAP_HEADER), 2 * sizeof(WORD), pallete);

    // Set offset to the image data
    memOffset = sizeof(BITMAP_HEADER) + 2 * sizeof(WORD);

    // Line width in bytes
    byteWidth = bmp.width >> 3;
    if(bmp.width & 0x0007)
        byteWidth++;

    // Get size
    sizeX = bmp.width;
    sizeY = bmp.height;

    for(y = 0; y < sizeY; y++)
    {

        // Get line
        ExternalMemoryCallback(bitmap, memOffset, byteWidth, lineBuffer);
        memOffset += byteWidth;
        CS_LAT_BIT = 0;
        for(stretchY = 0; stretchY < stretch; stretchY++)
        {
            pData = lineBuffer;
            SetAddress(address);
            mask = 0;
            for(x = 0; x < sizeX; x++)
            {

                // Read 8 pixels from flash
                if(mask == 0)
                {
                    temp = *pData++;
                    mask = 0x80;
                }

                // Set color
                if(mask & temp)
                {
                    SetColor(pallete[1]);
                }
                else
                {
                    SetColor(pallete[0]);
                }

                // Write pixel to screen
                for(stretchX = 0; stretchX < stretch; stretchX++)
                {
                    WritePixel(_color);
                }

                // Shift to the next pixel
                mask >>= 1;
            }

                    #if (DISP_ORIENTATION == 0)
            address += LINE_MEM_PITCH;
                    #else
            address -= 1;
                    #endif
        }

        CS_LAT_BIT = 1;
    }
}

/*********************************************************************
* Function: void PutImage4BPPExt(SHORT left, SHORT top, void* bitmap, BYTE stretch)
*
* PreCondition: none
*
* Input: left,top - left top image corner, bitmap - image pointer,
*        stretch - image stretch factor
*
* Output: none
*
* Side Effects: none
*
* Overview: outputs monochrome image starting from left,top coordinates
*
* Note: image must be located in external memory
*
********************************************************************/
void PutImage4BPPExt(SHORT left, SHORT top, void *bitmap, BYTE stretch)
{
    register DWORD  address;
    register DWORD  memOffset;
    BITMAP_HEADER   bmp;
    WORD            pallete[16];
    BYTE            lineBuffer[((GetMaxX() + 1) / 2) + 1];
    BYTE            *pData;
    SHORT           byteWidth;

    BYTE            temp = 0;
    WORD            sizeX, sizeY;
    WORD            x, y;
    BYTE            stretchX, stretchY;

    // Set start address
            #if (DISP_ORIENTATION == 0)
    address = (long)LINE_MEM_PITCH * top + left;
            #else
    address = (long)LINE_MEM_PITCH * left + top;
            #endif

    // Get bitmap header
    ExternalMemoryCallback(bitmap, 0, sizeof(BITMAP_HEADER), &bmp);

    // Get pallete (16 entries)
    ExternalMemoryCallback(bitmap, sizeof(BITMAP_HEADER), 16 * sizeof(WORD), pallete);

    // Set offset to the image data
    memOffset = sizeof(BITMAP_HEADER) + 16 * sizeof(WORD);

    // Line width in bytes
    byteWidth = bmp.width >> 1;
    if(bmp.width & 0x0001)
        byteWidth++;

    // Get size
    sizeX = bmp.width;
    sizeY = bmp.height;

    for(y = 0; y < sizeY; y++)
    {

        // Get line
        ExternalMemoryCallback(bitmap, memOffset, byteWidth, lineBuffer);
        memOffset += byteWidth;
        CS_LAT_BIT = 0;
        for(stretchY = 0; stretchY < stretch; stretchY++)
        {
            pData = lineBuffer;
            SetAddress(address);

            for(x = 0; x < sizeX; x++)
            {

                // Read 2 pixels from flash
                if(x & 0x0001)
                {

                    // second pixel in byte
                    SetColor(pallete[temp >> 4]);
                }
                else
                {
                    temp = *pData++;

                    // first pixel in byte
                    SetColor(pallete[temp & 0x0f]);
                }

                // Write pixel to screen
                for(stretchX = 0; stretchX < stretch; stretchX++)
                {
                    WritePixel(_color);
                }
            }

                    #if (DISP_ORIENTATION == 0)
            address += LINE_MEM_PITCH;
                    #else
            address -= 1;
                    #endif
        }

        CS_LAT_BIT = 1;
    }
}

/*********************************************************************
* Function: void PutImage8BPPExt(SHORT left, SHORT top, void* bitmap, BYTE stretch)
*
* PreCondition: none
*
* Input: left,top - left top image corner, bitmap - image pointer,
*        stretch - image stretch factor
*
* Output: none
*
* Side Effects: none
*
* Overview: outputs monochrome image starting from left,top coordinates
*
* Note: image must be located in external memory
*
********************************************************************/
void PutImage8BPPExt(SHORT left, SHORT top, void *bitmap, BYTE stretch)
{
    register DWORD  address;
    register DWORD  memOffset;
    BITMAP_HEADER   bmp;
    WORD            pallete[256];
    BYTE            lineBuffer[(GetMaxX() + 1)];
    BYTE            *pData;

    BYTE            temp;
    WORD            sizeX, sizeY;
    WORD            x, y;
    BYTE            stretchX, stretchY;

    // Set start address
            #if (DISP_ORIENTATION == 0)
    address = (long)LINE_MEM_PITCH * top + left;
            #else
    address = (long)LINE_MEM_PITCH * left + top;
            #endif

    // Get bitmap header
    ExternalMemoryCallback(bitmap, 0, sizeof(BITMAP_HEADER), &bmp);

    // Get pallete (256 entries)
    ExternalMemoryCallback(bitmap, sizeof(BITMAP_HEADER), 256 * sizeof(WORD), pallete);

    // Set offset to the image data
    memOffset = sizeof(BITMAP_HEADER) + 256 * sizeof(WORD);

    // Get size
    sizeX = bmp.width;
    sizeY = bmp.height;

    for(y = 0; y < sizeY; y++)
    {

        // Get line
        ExternalMemoryCallback(bitmap, memOffset, sizeX, lineBuffer);
        memOffset += sizeX;
        CS_LAT_BIT = 0;
        for(stretchY = 0; stretchY < stretch; stretchY++)
        {
            pData = lineBuffer;
            SetAddress(address);

            for(x = 0; x < sizeX; x++)
            {
                temp = *pData++;
                SetColor(pallete[temp]);

                // Write pixel to screen
                for(stretchX = 0; stretchX < stretch; stretchX++)
                {
                    WritePixel(_color);
                }
            }

                    #if (DISP_ORIENTATION == 0)
            address += LINE_MEM_PITCH;
                    #else
            address -= 1;
                    #endif
        }

        CS_LAT_BIT = 1;
    }
}

/*********************************************************************
* Function: void PutImage16BPPExt(SHORT left, SHORT top, void* bitmap, BYTE stretch)
*
* PreCondition: none
*
* Input: left,top - left top image corner, bitmap - image pointer,
*        stretch - image stretch factor
*
* Output: none
*
* Side Effects: none
*
* Overview: outputs monochrome image starting from left,top coordinates
*
* Note: image must be located in external memory
*
********************************************************************/
void PutImage16BPPExt(SHORT left, SHORT top, void *bitmap, BYTE stretch)
{
    register DWORD  address;
    register DWORD  memOffset;
    BITMAP_HEADER   bmp;
    WORD            lineBuffer[(GetMaxX() + 1)];
    WORD            *pData;
    WORD            byteWidth;

    WORD            temp;
    WORD            sizeX, sizeY;
    WORD            x, y;
    BYTE            stretchX, stretchY;

    // Set start address
            #if (DISP_ORIENTATION == 0)
    address = (long)LINE_MEM_PITCH * top + left;
            #else
    address = (long)LINE_MEM_PITCH * left + top;
            #endif

    // Get bitmap header
    ExternalMemoryCallback(bitmap, 0, sizeof(BITMAP_HEADER), &bmp);

    // Set offset to the image data
    memOffset = sizeof(BITMAP_HEADER);

    // Get size
    sizeX = bmp.width;
    sizeY = bmp.height;

    byteWidth = sizeX << 1;

    for(y = 0; y < sizeY; y++)
    {

        // Get line
        ExternalMemoryCallback(bitmap, memOffset, byteWidth, lineBuffer);
        memOffset += byteWidth;
        CS_LAT_BIT = 0;
        for(stretchY = 0; stretchY < stretch; stretchY++)
        {
            pData = lineBuffer;
            SetAddress(address);

            for(x = 0; x < sizeX; x++)
            {
                temp = *pData++;
                SetColor(temp);

                // Write pixel to screen
                for(stretchX = 0; stretchX < stretch; stretchX++)
                {
                    WritePixel(_color);
                }
            }

                    #if (DISP_ORIENTATION == 0)
            address += LINE_MEM_PITCH;
                    #else
            address -= 1;
                    #endif
        }

        CS_LAT_BIT = 1;
    }
}

    #endif // USE_DRV_PUTIMAGE
#endif

/*********************************************************************
* Function: void DrawLine (short x, short y, short Length )
*
* PreCondition: none
*
* Input: x, y - start line coordinates
*        Length - length of line
*
* Output: none
*
* Side Effects: none
*
* Overview: 
*
* Note: none
*
********************************************************************/
void DrawLine_Fast (short x, short y, short Length )
{
	DWORD address;
	short i;
	
	// Coordinates transaltion to the GRAM address of controller
	#if (DISP_ORIENTATION == 0)
		address = (y * 0x100) + x;
	#elif (DISP_ORIENTATION == 90)
		address = (x * 0x100) + (GetMaxY()-y);
	#elif (DISP_ORIENTATION == 180)
		address = ((GetMaxY() - y) * 0x100) + (GetMaxX()-x);
	#elif (DISP_ORIENTATION == 270)
		address = ((GetMaxX() - x) * 0x100) + y;
	#endif
	
	SetAddress(address);
	
	for (i=0; i<Length; i++)
	{
		WritePixel(_color.Val);
	}
		
	CS_LAT_BIT = 1;	
}


/*********************************************************************
* Function: WORD Bar(SHORT left, SHORT top, SHORT right, SHORT bottom)
*
* PreCondition: none
*
* Input: left,top - top left corner coordinates,
*        right,bottom - bottom right corner coordinates
*
* Output: For NON-Blocking configuration:
*         - Returns 0 when device is busy and the shape is not yet completely drawn.
*         - Returns 1 when the shape is completely drawn.
*         For Blocking configuration:
*         - Always return 1.
*
* Side Effects: none
*
* Overview: draws rectangle filled with current color
*
* Note: none
*
********************************************************************/
#ifdef USE_DRV_BAR

WORD Bar(SHORT left, SHORT top, SHORT right, SHORT bottom)
{
	//SHORT Row_Number, Row_Length;
	DWORD address;
	unsigned short sizeX, sizeY;
	int Size, i;
	
	#ifndef USE_NONBLOCKING_CONFIG
		while(IsDeviceBusy() != 0) Nop();
	
	/* Ready */
	#else
		if(IsDeviceBusy() != 0)
		return (0);
	#endif
/*
	Row_Number = (bottom - top) + 1;
	Row_Length = (right - left) + 1;
	
	for (i=0; i<Row_Number; i++)
	{
		DrawLine_Fast ( left, top, Row_Length );
		
		top++;
	}
*/	

	sizeX = (right - left) + 1;
	sizeY = (bottom - top) + 1;
	Size = sizeX * sizeY;

	// Coordinates transaltion to the GRAM address of controller
	#if (DISP_ORIENTATION == 0)
		address = (top * 0x100) + left;
	#elif (DISP_ORIENTATION == 90)
		address = (left * 0x100) + (GetMaxY()-top);
	#elif (DISP_ORIENTATION == 180)
		address = ((GetMaxY() - top) * 0x100) + (GetMaxX()-left);
	#elif (DISP_ORIENTATION == 270)
		address = ((GetMaxX() - left) * 0x100) + top;
	#endif
	
	// Coordinates transaltion to the GRAM address of controller
	#if (DISP_ORIENTATION == 0)
		// Set of boundaries of image on the screen
		SetReg (0x0210, left        );
		SetReg (0x0211, left+sizeX-1);
		SetReg (0x0212, top         );
		SetReg (0x0213, top+sizeY-1 );
	#elif (DISP_ORIENTATION == 90)
		// Set of boundaries of image on the screen
		SetReg (0x0210, GetMaxY()-top-(sizeY-1));
		SetReg (0x0211, GetMaxY()-top          );
		SetReg (0x0212, left                   );
		SetReg (0x0213, left+(sizeX-1)         );
	#elif (DISP_ORIENTATION == 180)
		// Set of boundaries of image on the screen
		SetReg (0x0210, GetMaxX()-left-(sizeX-1));
		SetReg (0x0211, GetMaxX()-left          );
		SetReg (0x0212, GetMaxY()-top-(sizeY-1) );
		SetReg (0x0213, GetMaxY()-top           );
	#elif (DISP_ORIENTATION == 270)
		// Set of boundaries of image on the screen
		SetReg (0x0210, top                     );
		SetReg (0x0211, top+(sizeY-1)           );
		SetReg (0x0212, GetMaxX()-left-(sizeX-1));
		SetReg (0x0213, GetMaxX()-left          );
	#endif

	SetAddress(address);
	
	for (i=0; i<Size; i++)
	{
		WritePixel(_color.Val);
	}			

	// Display disable	
	CS_LAT_BIT = 1;
	
	// Restor original full screen boundaries
	SetReg(0x0210, 0x0000);// Horizontal GRAM Start Address
	SetReg(0x0211, 0x00EF);// Horizontal GRAM End Address
	SetReg(0x0212, 0x0000);// Vertical GRAM Start Address
	SetReg(0x0213, 0x01AF);// Vertical GRAM Start Address			

	return (1);
}

#endif

/*********************************************************************
* Function: WORD Line(SHORT x1, SHORT y1, SHORT x2, SHORT y2)
*
* PreCondition: none
*
* Input: x1,y1 - starting coordinates, x2,y2 - ending coordinates
*
* Output: For NON-Blocking configuration:
*         - Returns 0 when device is busy and the shape is not yet completely drawn.
*         - Returns 1 when the shape is completely drawn.
*         For Blocking configuration:
*         - Always return 1.
*
* Side Effects: none
*
* Overview: draws line
*
* Note: none
*
********************************************************************/
#ifdef USE_DRV_LINE

/* */
WORD Line(SHORT x1, SHORT y1, SHORT x2, SHORT y2)
{
	SHORT   deltaX, deltaY;
	SHORT   error, stepErrorLT, stepErrorGE;
	SHORT   stepX, stepY;
	SHORT   steep;
	SHORT   temp;
	SHORT   style, type;
	short   Length;

	#ifndef USE_NONBLOCKING_CONFIG
		while(IsDeviceBusy() != 0) Nop();

	/* Ready */
	#else
		if(IsDeviceBusy() != 0)
		return (0);
	#endif

	// Move cursor
	MoveTo(x2, y2);

	if(x1 == x2)
	{
		if(y1 > y2)
		{
			temp = y1;
			y1 = y2;
			y2 = temp;
		}
		
		if (_lineType == SOLID_LINE)
		{
			#if (DISP_ORIENTATION == 0)
				SetReg(0x0003, 0x1028);// Set GRAM write directions
			#elif (DISP_ORIENTATION == 90)
				SetReg(0x0003, 0x1000);// Set GRAM write directions
			#elif (DISP_ORIENTATION == 180)
				SetReg(0x0003, 0x1018);// Set GRAM write directions
			#elif (DISP_ORIENTATION == 270)
				SetReg(0x0003, 0x1030); // Set GRAM write directions
			#endif
				
			Length = y2 - y1;
			
			DrawLine_Fast(x1, y1, Length);
			
			if(_lineThickness)
			{
				DrawLine_Fast(x1, y1+1, Length);
				DrawLine_Fast(x1, y1-1, Length);
			}
		
			#if (DISP_ORIENTATION == 0)
				SetReg(0x0003, 0x1030); // Set GRAM write directions
			#elif (DISP_ORIENTATION == 90)
				SetReg(0x0003, 0x1028);// Set GRAM write directions
			#elif (DISP_ORIENTATION == 180)
				SetReg(0x0003, 0x1000);// Set GRAM write directions
			#elif (DISP_ORIENTATION == 270)
				SetReg(0x0003, 0x1018);// Set GRAM write directions
			#endif
		}	
		else
		{
			style = 0;
			type = 1;
			for(temp = y1; temp < y2 + 1; temp++)
			{
				if((++style) == _lineType)
				{
					type ^= 1;
					style = 0;
				}
				
				if(type)
				{
					PutPixel(x1, temp);
					if(_lineThickness)
					{
						PutPixel(x1 + 1, temp);
						PutPixel(x1 - 1, temp);
					}
				}
			}
		}
		return (1);
	}

		if(y1 == y2)
		{
			if(x1 > x2)
			{
				temp = x1;
				x1 = x2;
				x2 = temp;
			}
						
			if (_lineType == SOLID_LINE)
			{
				Length = x2 - x1;

				DrawLine_Fast(x1, y1, Length);
				
				if(_lineThickness)
				{
					DrawLine_Fast(x1, y1+1, Length);
					DrawLine_Fast(x1, y1-1, Length);
				}
			}
			else
			{ 
				style = 0;
				type = 1;
				for(temp = x1; temp < x2 + 1; temp++)
				{
					if((++style) == _lineType)
					{
						type ^= 1;
						style = 0;
					}
					
					if(type)
					{
						PutPixel(temp, y1);

						if(_lineThickness)
						{
							PutPixel(temp, y1 + 1);
							PutPixel(temp, y1 - 1);
						}
					}
				}
			}
			return (1);
		}

    stepX = 0;
    deltaX = x2 - x1;
    if(deltaX < 0)
    {
        deltaX = -deltaX;
        --stepX;
    }
    else
    {
        ++stepX;
    }

    stepY = 0;
    deltaY = y2 - y1;
    if(deltaY < 0)
    {
        deltaY = -deltaY;
        --stepY;
    }
    else
    {
        ++stepY;
    }

    steep = 0;
    if(deltaX < deltaY)
    {
        ++steep;
        temp = deltaX;
        deltaX = deltaY;
        deltaY = temp;
        temp = x1;
        x1 = y1;
        y1 = temp;
        temp = stepX;
        stepX = stepY;
        stepY = temp;
        PutPixel(y1, x1);
    }
    else
    {
        PutPixel(x1, y1);
    }

    // If the current error greater or equal zero
    stepErrorGE = deltaX << 1;

    // If the current error less than zero
    stepErrorLT = deltaY << 1;

    // Error for the first pixel
    error = stepErrorLT - deltaX;

    style = 0;
    type = 1;

    while(--deltaX >= 0)
    {
        if(error >= 0)
        {
            y1 += stepY;
            error -= stepErrorGE;
        }

        x1 += stepX;
        error += stepErrorLT;

        if((++style) == _lineType)
        {
            type ^= 1;
            style = 0;
        }

        if(type)
        {
            if(steep)
            {
                PutPixel(y1, x1);
                if(_lineThickness)
                {
                    PutPixel(y1 + 1, x1);
                    PutPixel(y1 - 1, x1);
                }
            }
            else
            {
                PutPixel(x1, y1);
                if(_lineThickness)
                {
                    PutPixel(x1, y1 + 1);
                    PutPixel(x1, y1 - 1);
                }
            }
        }
    }   // end of while

    return (1);
}

#endif

