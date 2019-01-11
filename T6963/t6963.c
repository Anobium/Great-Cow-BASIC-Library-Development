***********************************************************************************************
*							Toshiba T6963C Graphical LCD Display Driver
*
* File name		: t6963.c
* Programmer 	: John Leung, TechToys, Hong Kong
* Web presence  : www.TechToys.com.hk
* Note			: References -= picant complier web page, epe magazine Feb 2001
*				  & Jean J Labrosse's Embedded Systems Building Blocks
*				  & treitmey's driver on CCS forum
* Language		: CCS C complier for PIC mid-range MCU, PCM version 3.170, under MPLAB IDE 7.01
* Hardware		: Prototype board PCB ver 2.5(home-grown), EQS Console, MCU 16F877a, 20MHz Xtal
* Date			: Version 0.0 (20 April 2005 - 27 April 2005)
* Date			: 3 May 2005
*				: Routine sub GDispPixFontAt(x, y, textptr, size, color) and font5x7.h added
***********************************************************************************************
*										DESCRIPTION
*
* This module provides an interface to Toshiba T6963C-0101 Graphical LCD of size 128x64 dots
* A 128-word character generator ROM (code 0101) T6963C-0101 built-in.
* Graphics l.c.d. pinout function
* pin 1	FG	frame ground
* pin 2	GND	signal ground
* pin 3	+5V	Positive supply
* pin 4	CX	Negative supply (-3.5V approx)
* pin 5	WR	Data write (active low)
* pin 6	RD	Data read (active low)
* pin 7	CE	Chip enable (active low)
* pin 8	CD	CD=1, WR=0: command write
*			CD=1, WR=1: command read
*			CD=0, WR=0: data write
* 			CD=0, WR=1: data read
* pin 9	RST	Module reset (active low)
* pin 10 - 17	Data bus
* pin 18 FS	Font select: FS=0(8x8 font), FS=1(or open circuit, 6x8 font)
* On EQS console ver 2.5 PCB, FS is determined by JP23 jumper. FS=0 when shorted
*
***********************************************************************************************
*/

#include "font5x7.h"		//custom-defined 5x7 font, for GDispPixFontAt(...)

/*
***********************************************************************************************
*										LOCAL CONSTANTS
***********************************************************************************************
*/
#define CURSOR_PTR_SET      0x21    //Cursor Pointer Set
#define OFFSET_REG_SET      0x22    //Set Offset Command
#define ADDR_PTR_SET        0x24    //Set Address Pointer Command

#define TEXT_HOME_SET       0x40    //Text Home Address Set: Data = low, high addr
#define TEXT_AREA_SET       0x41    //Text Area Set: Data = columns, 0
#define GRAPH_HOME_SET      0x42    //Graphics Home address Set: Data = low, high addr
#define GRAPH_AREA_SET      0x43    //Graphics Area Set: Data = columns, 0
#define SCREEN_PEEK         0xE0    //Read data from screen command
#define SCREEN_COPY         0xE8    //Screen Copy

#define AUTO_WR_ON         	0xB0
#define DATA_AUTO_RD       	0xB1
#define AUTO_WR_OFF        	0xB2

#define DATA_WR_INC         0xC0   	// Data write and increment addrespointer
#define DATA_RD_INC         0xC1   	// Data read and increment  addrespointer
#define DATA_WR_DEC         0xC2   	// Data write and decrement addrespointer
#define DATA_RD_DEC         0xC3   	// Data read and decrement  addrespointer
#define DATA_WR             0xC4   	// Data write - no addr change
#define DATA_RD             0xC5   	// Data read  - no addr change



/*
*********************************************************************************************************
*									LOCAL FUNCTION PROTOTYPES
*********************************************************************************************************
*/
static sub GDispCmdAddrSend(unsigned int16 Addr, unsigned char cmd);

/*
*********************************************************************************************************
*                         				SEND ADDRESS COMMAND
*
* Description : This function sends screen address with a command to the LCD screen
* Arguments   : 'Addr'  is the screen address to send
*				'cmd'   is the command
* Returns     : none
* Notes		  : Most often a graphic LCD needs a screen address for command setup.
*				Example, set Graph Home Address is the command GRAPH_HOME_SET (0x42), at the ram address
*				GRH_HOME_ADDR (0x0200), say.
*********************************************************************************************************
*/
static sub GDispCmdAddrSend(unsigned int16 Addr, unsigned char cmd)
{
	unsigned int8 c;

	c = Addr&0x00FF;
   	GDispDataWr(c);		//Send LSB of 'Addr' first
	c = Addr >> 8;
   	GDispDataWr(c);		//Send MSB of 'Addr' afterwards
   	GDispCmdSend(cmd);
}


/*
*********************************************************************************************************
*                         				DISPLAY DRIVER INITIALIZATION
*
* Description : This function initializes the display driver
* Arguments   : none
* Returns     : none
* Notes		  :
*********************************************************************************************************
*/
sub GDispInit(void)
{
   //Reset the LCD module and perform a hardware port init
	GDispInitPort();
   //Set Text Home address to TEXT_HOME_ADDR
   	GDispCmdAddrSend(TEXT_HOME_ADDR,TEXT_HOME_SET);
   //Set Graph Home address to GRH_HOME_ADDR
   	GDispCmdAddrSend(GRH_HOME_ADDR,GRAPH_HOME_SET);
   //Set Text Area to COLUMN column mode
   	GDispCmdAddrSend(COLUMN,TEXT_AREA_SET);
   //Set Graph Area to COLUMN column mode
   	GDispCmdAddrSend(COLUMN,GRAPH_AREA_SET);
   //Set Offset register to 0x0002, CG Ram start address = $1400 (CG_HOME_ADDR)
   //first character code $80 for CG Ram
   	GDispCmdAddrSend(0x0002,OFFSET_REG_SET);
}

/*
*********************************************************************************************************
*                         		SET MODE FOR DISPLAY/MODE/CURSOR/TEXT_ATTRIBUTE
*
* Description : This function sets mode
* Arguments   : 'mode'	, refer to mode available in t6963.h, MODE Section, CURSOR MODE, TEXT ATTRI
* Returns     : none
* Notes		  :
*********************************************************************************************************
*/
sub GDispSetMode(unsigned int8 mode)
{
	GDispCmdSend(mode);
}

/*
*********************************************************************************************************
*                         					CLEAR TEXT SCREEN
*
* Description : This function clears the text clear in font mode
* Arguments   : none
* Returns     : none
* Notes		  :
*********************************************************************************************************
*/
sub GDispClrTxt(void)
{
    unsigned int16 row;
	unsigned int16 col;

   //Set address pointer to address (TEXT_HOME_ADDR)
   GDispCmdAddrSend(TEXT_HOME_ADDR,ADDR_PTR_SET);
   //Set Auto Write ON
   GDispCmdSend(AUTO_WR_ON);

			//row runs from 0 ... (MAX_ROW_PIXEL/8 -1), in form of a cell of (FontSize x 8) bits
   for(row=0; row < MAX_ROW_PIXEL/8; row++)
   {		//write blank to clear screen the first page only, col = 0...(COLUMN-1)
	for(col=0; col < COLUMN; col++)
	{
   		GDispAutoDataWr(0x00);
	}
   }
   //Set Auto Write OFF
   GDispCmdSend(AUTO_WR_OFF);
}

/*
*********************************************************************************************************
*                         				CLEAR THE GRAPHIC AREA
*
* Description : This function clears the graphic area pixel by pixel
* Arguments   : none
* Returns     : none
* Notes		  :
*********************************************************************************************************
*/
sub GDispClrGrh(void)
{
	unsigned int16 row;
	unsigned int16 col;

	//Set address pointer to address (GRH_HOME_ADDR)
	GDispCmdAddrSend(GRH_HOME_ADDR, ADDR_PTR_SET);
	GDispCmdSend(AUTO_WR_ON);
		//row runs from 0 ... (MAX_ROW_PIXEL-1), in form of a byte size of (FontSize x 1) bits
	for(row=0; row < MAX_ROW_PIXEL; row++)
	{	//write blank to clear screen the first page only, col = 0...(COLUMN-1)
	for (col=0; col < COLUMN; col++)
		{
			GDispAutoDataWr(0x00);
		}
	}
   	GDispCmdSend(AUTO_WR_OFF);	//Set Auto Write OFF
}


/*
*********************************************************************************************************
*                         	  			GOTO A POSITION (row, col)
*
* Description : This function sets the screen address pointer to a position row, col
* Arguments   : 'row'   row = 0...(MAX_ROW_PIXEL/8 - 1), the cell number in 8 bits height
*				'col'   col = 0...(COLUMN-1), is the column position in font width (6/8 font)
* Returns     : none
* Notes		  :
*********************************************************************************************************
*/
sub GDispGoto(unsigned int16 row, unsigned int16 col)
{
   unsigned int16 addr;

   addr = row*COLUMN + col + TEXT_HOME_ADDR;
   GDispCmdAddrSend(addr,ADDR_PTR_SET);							//Set address pointer
}


/*
*********************************************************************************************************
*                     DISPLAY A CHARACTER AT THE CURRENT SCREEN ADDRESS POINTER
*
* Description : This function is used to display a single character on the display device at row, col
*				col, row should have been set by GDispGoto(row, col) before. AUTO ADDRESS POINTER INC!
* Arguments   :	'c'     is the ASCII character to write
* Returns     : none
* Notes		  : This function gets around the problem that pointers cannot be created to constant string
*				in PCM. Referring to CCS Reference Manual (page 67), a function that has one CHAR
*				parameter will accept a constant string where it is called. PCM will generate a loop
*				that will call the function once for each character in the string.
*				Example :
*					GDispGoto(5,5);
*					GDispChar("Hello there!");
*********************************************************************************************************
*/
sub GDispChar(unsigned char c)
{
   	GDispDataWr(c - 0x20);					//Adjust standard ASCII to T6963 ASCII
	GDispCmdSend(DATA_WR_INC);				//Address pointer increment ON
}


/*
*********************************************************************************************************
*                         	  DISPLAY A CHARACTER AT A POSITION (row, col)
*
* Description : This function is used to display a single character on the display device, address
*				auto increment OFF!
* Arguments   : 'row'   row = 0...(MAX_ROW_PIXEL/8 - 1), the row pos of the cursor (MAX_ROW_PIXEL/8-1)
*				'col'   col = 0...(COLUMN-1), is the column position in font width (6/8 font)
*				'c'     is the ASCII character to write
* Returns     : none
* Notes		  : COLUMN constant determines the number of page, can be > physical size of the LCD
*********************************************************************************************************
*/
sub GDispCharAt(unsigned int16 row, unsigned int16 col, unsigned char c )
{
   	GDispGoto(row, col);
	GDispDataWr(c - 0x20);
	GDispCmdSend(DATA_WR);
}


/*
*********************************************************************************************************
*                         				SET CURSOR AT A POSITION
*
* Description : This function sets cursor at a position (row, col), of certain mode & type
* Arguments   : 'mode' is the mode of cursor. It should be bitwise OR with a TEXT / GRAPH mode to work
*				       mode = 	TEXT_GRH_ON|CURSOR_BLINK_ON
*								TEXT_ON|CURSOR_ON_BLINK_OFF....
*								TEXT_ON, without bitwise OR any cursor mode only will clear cursor
*				'row'  is the MSB of screen address, the row position of the cursor
*				'col'  is the LSB of the screen address, the column position of the cursor
*				'type' is cursor type
*					   type = LINE_1_CURSOR / LINE_8_CURSOR
* Returns     : none
* Notes		  : Cursor address is not like text address pointer. Cannot use GDispGoto(row,col).
*********************************************************************************************************
*/
sub GDispSetCursor(unsigned int8 mode, unsigned int16 row, unsigned int16 col, unsigned int8 type)
{
	unsigned int16 addr;

	addr = row << 8;
	addr = addr|(col&0x00FF);
   	GDispCmdAddrSend(addr, ADDR_PTR_SET);
   	GDispCmdSend(CURSOR_PTR_SET);  		//Set cursor position
	GDispCmdSend(mode);
   	GDispCmdSend(type); 				//cursor mode
}


/*
*********************************************************************************************************
*                         				SET PIXEL AT X, Y POSITION
*
* Description : This function sets a pixel with color = BLACK / WHITE (defined in t6963.h)
* Arguments   : 'X'    0....MAX_COL_PIXEL is matrix position in horizontal direction
*				'Y     0....MAX_ROW_PIXEL is matrix position in vertical direction
*				'color'  sets BLACK / WHITE standing for pixel ON/OFF
* Returns     : none
* Notes		  :
*********************************************************************************************************
*/
sub GDispSetPixel(unsigned int16 X, unsigned int16 Y, unsigned int8 color)
{
	unsigned int16 addr;
	unsigned int16 row, col;
	unsigned char cmd;

		row = Y;
		col = X/FontSize;
   		addr = row*COLUMN + col + GRH_HOME_ADDR;
		GDispCmdAddrSend(addr, ADDR_PTR_SET);

		if (color == BLACK)
			cmd = (0b11111000)|(FontSize- 1 -(X%FontSize));
		else
			cmd = (0b11110000)|(FontSize- 1 -(X%FontSize));

		GDispCmdSend(cmd);
}


/*
*********************************************************************************************************
*                         		SET TEXT ATTRIBUTE (NOT COMPLETE DEBUG)
*
* Description : This function sets / clears text attribute mode
* Arguments   : 'row'   row = 0...(MAX_ROW_PIXEL/8 - 1), the row pos of the cursor (MAX_ROW_PIXEL/8-1)
*				'col'   col = 0...(COLUMN-1), is the column position in font width (6/8 font)
*				'mode'  = 	ATTR_REVERSE, ATTR_INHIBIT, ATTR_BLINK_REVERSE, ATTR_BLINK_INHIBIT...
*							(see TEXT ATTRIBUTE MODE in t6963.h for available mode)
* Returns     : none
* Notes		  : After function call to GDispSetAttrb(row,col,ATTR_BLINK_REVERSE),
*				should use GDispSetAttrib(row,col, ATTR_NORMAL) before using graphic area again to avoid
*				graphic area data write error!
*********************************************************************************************************
*/

sub GDispSetAttrb(unsigned int16 row, unsigned int16 col, unsigned int8 mode)
{
	unsigned int16 addr;

   	addr = row*COLUMN + col + GRH_HOME_ADDR;
	GDispCmdAddrSend(addr, ADDR_PTR_SET);
	GDispCmdSend(AUTO_WR_ON);
	GDispAutoDataWr(mode);
	GDispCmdSend(AUTO_WR_OFF);
	GDispCmdSend(TEXT_ATTR_MODE);
	GDispCmdSend(TEXT_GRH_ON);
}


/*
*********************************************************************************************************
*                         			SET CUSTOM DEFINED CHARACTER TO CG RAM
*
* Description : This function assigns a custom created pattern of 8 BYTE with an id number
* Arguments   : 'id'	is the identifier for the pattern created. Range of 'id' is 0...127 for T6963.
*				'pat' 	is a pointer to an 8 BYTE array containing the dot pattern
* Returns     : none
* Notes		  : Pointers cannot be created to constant arrays in PCM. Thus, a global CGBuffer[]'s created
*				in t6963.h to store a constant array to RAM space.
*				Code Example	::
*
*				char i;
*				const char CUSTOM_PAT[8] = {0x00, 0x23, 0x45, 0x56, 0x89, 0xAB, 0xFF, 0xEE};
*				for(i=0;i<8;i++) CGBuffer[i] = CUSTOM_PAT[i]	//assign CUSTOM_PAT[] to CGBuffer[]
*				GDispDefCGChar(0, &CGBuffer[0]);				//create a pattern in CG RAM with id '0'
*********************************************************************************************************
*/
sub GDispDefCGChar(unsigned int8 id, unsigned char *pat)
{
	unsigned int8 i;

	GDispCmdAddrSend(CG_HOME_ADDR+(unsigned int16)id*8, ADDR_PTR_SET);

	for(i=0; i<8; i++)
	{
		GDispDataWr(*pat++);
		GDispCmdSend(DATA_WR_INC);
	}
}

/*
*********************************************************************************************************
*                DISPLAY AN EXTERNAL CG CHARACTER AT THE CURRENT SCREEN ADDRESS POINTER
*
* Description : This function shows a pre-defined CG RAM character at the current screen address pointer
* Arguments   : 'id'	is the identifier for the pattern created. Range of 'id' is 0...127 for T6963.
* Returns     : none
* Notes		  :
*********************************************************************************************************
*/
sub GDispCGChar(unsigned int8 id)
{
	GDispDataWr(0x80 + id);					//Adjust standard ASCII to T6963 ASCII
	GDispCmdSend(DATA_WR_INC);				//'0x80 + id's range 0 to 255, good for GDispDataWr(char)
}

/*
*********************************************************************************************************
*               			 DISPLAY AN EXTERNAL CG CHARACTER AT ROW, COL
*
* Description : This function shows a pre-defined CG RAM character at (row, col) coordinates
* Arguments   : 'id'	is the identifier for the pattern created. Range of 'id' is 0...127 for T6963.
* Returns     : none
* Notes		  :
*********************************************************************************************************
*/
sub GDispCGCharAt(unsigned int16 row, unsigned int16 col, unsigned int8 id)
{
	GDispGoto(row,col);
	GDispCGChar(id);
}


/*
*********************************************************************************************************
*               			    DISPLAY A BLANK ICON OF 32x32 MATRIX AT ROW, COL
*
* Description : This function clears the 32x32 ICON at (row, col) coordinates
* Arguments   : 'row'   row = 0...(MAX_ROW_PIXEL/8 - 1), the row pos of the cursor (MAX_ROW_PIXEL/8-1)
*				'col'   col = 0...(COLUMN-1), is the column position in font width (6/8 font)
* Returns     : none
* Notes		  :
*********************************************************************************************************
*/
sub GDispBlkIcon32X32At(unsigned int16 row, unsigned int16 col)
{
	unsigned int16 row_cnt, col_cnt;

	GDispGoto(row, col);
	for(row_cnt = row; row_cnt < (row+4); row_cnt++)
	{
		for(col_cnt = col; col_cnt < (col+4); col_cnt++)
		{
			GDispCharAt(row_cnt, col_cnt, ' ');
		}
	}
}


/*
*********************************************************************************************************
*               	CONVERT A STRING TO PIXEL DATA AND DISPLAY AT X,Y IN GRAPHIC MODE
*
* Description : This function outputs a string in graphic mode from a char* textptr pointer
* Arguments   : 'X'    		0....MAX_COL_PIXEL is matrix position in horizontal direction
*				'Y     		0....MAX_ROW_PIXEL is matrix position in vertical direction
*				'textptr'	pointer to the string to write
*				'size'		should be non-zero, 1 = 5x7, 2 = 10x14, ..., basically "enlarge" the font
*							defined under font5x7.h.
*				'color'		BLACK / WHITE
* Returns     : none
* Notes		  : Copyright (c) 2004 Sentinel Systems Corporation
*				Example, declare a string
*				.
*				char str[] = "Hello World!";
*				.
*				.
*				main()
*				{
*					GDispPixFontAt(0,20,&str[0],2,BLACK); //Display the "Hello World!" string starting
*														  //at (x,y)=(0,20), in size font size 2 (10x14)
*														  //color in black
*				}
*********************************************************************************************************
*/
sub GDispPixFontAt(unsigned int16 X, unsigned int16 Y, unsigned char* textptr, unsigned char size, int1 color)
{
	const BYTE bytes_per_char = 5;
	int i, j, k, l, m; 								// Loop counters
	BYTE pixelData[bytes_per_char]; 				// Stores character data

	for(i=0; textptr[i] != '\0'; ++i, ++X) 			// Loop through the passed string
	{
		if(textptr[i] < 'S') 						// Checks if the letter is in the first or second array
		memcpy(pixelData, FONT1[textptr[i]-' '], bytes_per_char);
		else if(textptr[i] <= '~') 					// Check if the letter is in the second array
		memcpy(pixelData, FONT2[textptr[i]-'S'], bytes_per_char);
		else 										// Default to space if character out of range
		memcpy(pixelData, FONT1[0], bytes_per_char);

		if(X+5*size >= MAX_COL_PIXEL) 				// Performs character wrapping
		{
			X = 0; 									// Set X at far left position
			Y += 7*size + 1; 						// Set Y at next position down
		}
		for(j=0; j<bytes_per_char; ++j, X+=size) 	// 5 bytes per character
		{
			for(k=0; k<7*size; ++k) 				// Loop through the vertical pixels
			{
			if(bit_test(pixelData[j], k)) 			// Check if the pixel should be set
			{
				for(l=0; l<size; ++l) 				// The next two loops change the character's size
				{
					for(m=0; m<size; ++m)
					{ 								// Draws the pixel
						GDispSetPixel(X+m, Y+k*size+l, color);
					}
				}
			}
			}
		}
	} //for(i = 0; textptr[i] != '\0';...)
}


/*
*********************************************************************************************************
*                         				 I/O PORT INITIALIZATION
*
* Description : This initializes the I/O ports used by the display driver
* Arguments   : none
* Returns     : none
* Notes		  :
*********************************************************************************************************
*/
sub GDispInitPort(void)
{
    LCD_RST = 0;
	LCD_CD = 1;
	LCD_CE = 1;
	LCD_RD = 1;
	LCD_WR = 1;
	LCD_DATA = 0x00;
   	//Set all control line as output
   	LCD_CE_TRIS = 0;
   	LCD_RD_TRIS = 0;
   	LCD_CD_TRIS = 0;
   	LCD_WR_TRIS = 0;
   	LCD_RST_TRIS = 0;
   	LCD_DATA_TRIS = 0x00;
   	//Turn on LCD module after reset
  	#asm
		nop
	#endasm
   	LCD_RST=1;
}


/*
*********************************************************************************************************
*                         					  BUSY CHECK
*
'* Description : This function checks command execution capability, & data read/write capability
* Arguments   : none
* Returns     : none
* Notes		  :
*********************************************************************************************************
*/
sub GDispBusyChk(void)
{
	GDispCmdRd;
  	GDispChipEn;
  	#asm
		nop
  	#endasm
  	while (!STA0)			// Busy Check here
		;
  	while (!STA1)
   		;
  	GDispChipDi;			//Chip disable to finish
}

/*
*********************************************************************************************************
*                                    	AUTO MODE DATA WRITE CHECK
*
* Description : This function checks auto mode data write capability
* Arguments   : none
* Returns     : none
* Notes		  :
*********************************************************************************************************
*/
sub GDispAutoWrChk(void)
{
	GDispCmdRd;
	GDispChipEn;
	#asm
		nop
	#endasm
	while(!STA3)
		;
	GDispChipDi;
}

/*
*********************************************************************************************************
*                                    		WRITE DATA TO LCD MODULE
*
* Description : This function sends a single data byte to the display device
* Arguments   : 'data' is the BYTE to send to the display device
* Returns     : none
* Notes		  :
*********************************************************************************************************
*/
sub GDispDataWr(unsigned char data)
{
  GDispBusyChk();       		// Wait for LCD to be ready

  LCD_DATA = data;	   			// Data write
  #asm
	nop
  #endasm
  GDispDatWr;
  GDispChipEn;
  #asm
	nop							//delay one cycle for port stablize
  #endasm
  GDispChipDi;
}


/*
*********************************************************************************************************
*                        WRITE DATA TO LCD MODULE, SCREEN ADRESS AUTO-INCREMENTED
*
* Description : Send a single data byte to the screen with screen address auto'ly incremented
* Arguments   : 'data' is the BYTE to send to the display device
* Returns     : none
* Notes		  :
*********************************************************************************************************
*/
sub GDispAutoDataWr(unsigned char data)
{
  GDispAutoWrChk();       		// Auto write mode check

  LCD_DATA = data;	   			// Data write
  #asm
	nop
  #endasm
  GDispDatWr;
  GDispChipEn;
  #asm
	nop							//delay one cycle for port stablize
  #endasm
  GDispChipDi;
}


/*
*********************************************************************************************************
*                                    	WRITE COMMAND TO LCD MODULE
*
* Description : This function sends a single byte as command to the display device
* Arguments   : 'cmd' is the COMMAND BYTE to send to the display device
* Returns     : none
* Notes		  :
*********************************************************************************************************
*/
sub GDispCmdSend(unsigned char cmd)
{
  	GDispBusyChk();         // Wait for LCD to be ready
  	LCD_DATA = cmd;
	GDispCmdWr;
  	GDispChipEn;
  	#asm
		nop
	#endasm
  	GDispChipDi;
}

