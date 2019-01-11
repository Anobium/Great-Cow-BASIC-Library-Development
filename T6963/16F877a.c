
#include <16F877a.h>
#Fuses HS,NOWDT,NOPROTECT,NOLVP,NOBROWNOUT
#use delay(clock=20000000)
#include "t6963.h"
#include "t6963.c"

void main()
{
GDispInit();                         //T6963C display initialization
GDispSetMode(XOR_MODE|INT_CG_MODE);  //Exclusive OR mode, internal CG character RAM
GDispSetMode(TEXT_GRH_ON);           //Text ON, Graphics ON
GDispClrTxt();                       //Clear the text area
GDispClrGrh();                       //Clear the graphics area (dot-by-dot!)

while(1)
  {
   GDispGoto(0,0);
   GDispChar(0x85);
  }
}

sudarsan



Joined: 08 Nov 2012
Posts: 5
Location: India
View user's profile  Send private message

t6963.c file
PostPosted: Thu Nov 08, 2012 1:07 am    	Reply with quote
Code:

/* t6963.c file */
#include "font5x7.h"      //custom-defined 5x7 font, for GDispPixFontAt(...)

/*
***********************************************************************************************
*                              LOCAL CONSTANTS
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
#define AUTO_WR_ON            0xB0
#define DATA_AUTO_RD          0xB1
#define AUTO_WR_OFF           0xB2
#define DATA_WR_INC         0xC0      // Data write and increment addrespointer
#define DATA_RD_INC         0xC1      // Data read and increment  addrespointer
#define DATA_WR_DEC         0xC2      // Data write and decrement addrespointer
#define DATA_RD_DEC         0xC3      // Data read and decrement  addrespointer
#define DATA_WR             0xC4      // Data write - no addr change
#define DATA_RD             0xC5      // Data read  - no addr change



/*
*********************************************************************************************************
*                           LOCAL FUNCTION PROTOTYPES
*********************************************************************************************************
*/
static void GDispCmdAddrSend(unsigned int16 Addr, unsigned char cmd);

/*
*********************************************************************************************************
*                                     SEND ADDRESS COMMAND
*
* Description : This function sends screen address with a command to the LCD screen
* Arguments   : 'Addr'  is the screen address to send
*            'cmd'   is the command
* Returns     : none
* Notes        : Most often a graphic LCD needs a screen address for command setup.
*            Example, set Graph Home Address is the command GRAPH_HOME_SET (0x42), at the ram address
*            GRH_HOME_ADDR (0x0200), say.
*********************************************************************************************************
*/
static void GDispCmdAddrSend(unsigned int16 Addr, unsigned char cmd)
{
   unsigned int8 c;

   c = Addr&0x00FF;
      GDispDataWr(c);      //Send LSB of 'Addr' first
   c = Addr >> 8;
      GDispDataWr(c);      //Send MSB of 'Addr' afterwards
      GDispCmdSend(cmd);
}


/*
*********************************************************************************************************
*                                     DISPLAY DRIVER INITIALIZATION
*
* Description : This function initializes the display driver
* Arguments   : none
* Returns     : none
* Notes        :
*********************************************************************************************************
*/
void GDispInit(void)
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
*                               SET MODE FOR DISPLAY/MODE/CURSOR/TEXT_ATTRIBUTE
*
* Description : This function sets mode
* Arguments   : 'mode'   , refer to mode available in t6963.h, MODE Section, CURSOR MODE, TEXT ATTRI
* Returns     : none
* Notes        :
*********************************************************************************************************
*/
void GDispSetMode(unsigned int8 mode)
{
   GDispCmdSend(mode);
}

/*
*********************************************************************************************************
*                                        CLEAR TEXT SCREEN
*
* Description : This function clears the text clear in font mode
* Arguments   : none
* Returns     : none
* Notes        :
*********************************************************************************************************
*/
void GDispClrTxt(void)
{
    unsigned int16 row;
   unsigned int16 col;

   //Set address pointer to address (TEXT_HOME_ADDR)
   GDispCmdAddrSend(TEXT_HOME_ADDR,ADDR_PTR_SET);
   //Set Auto Write ON
   GDispCmdSend(AUTO_WR_ON);

         //row runs from 0 ... (MAX_ROW_PIXEL/8 -1), in form of a cell of (FontSize x 8) bits
   for(row=0; row < MAX_ROW_PIXEL/8; row++)
   {      //write blank to clear screen the first page only, col = 0...(COLUMN-1)
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
*                                     CLEAR THE GRAPHIC AREA
*
* Description : This function clears the graphic area pixel by pixel
* Arguments   : none
* Returns     : none
* Notes        :
*********************************************************************************************************
*/
void GDispClrGrh(void)
{
   unsigned int16 row;
   unsigned int16 col;

   //Set address pointer to address (GRH_HOME_ADDR)
   GDispCmdAddrSend(GRH_HOME_ADDR, ADDR_PTR_SET);
   GDispCmdSend(AUTO_WR_ON);
      //row runs from 0 ... (MAX_ROW_PIXEL-1), in form of a byte size of (FontSize x 1) bits
   for(row=0; row < MAX_ROW_PIXEL; row++)
   {   //write blank to clear screen the first page only, col = 0...(COLUMN-1)
   for (col=0; col < COLUMN; col++)
      {
         GDispAutoDataWr(0x00);
      }
   }
      GDispCmdSend(AUTO_WR_OFF);   //Set Auto Write OFF
}


/*
*********************************************************************************************************
*                                       GOTO A POSITION (row, col)
*
* Description : This function sets the screen address pointer to a position row, col
* Arguments   : 'row'   row = 0...(MAX_ROW_PIXEL/8 - 1), the cell number in 8 bits height
*            'col'   col = 0...(COLUMN-1), is the column position in font width (6/8 font)
* Returns     : none
* Notes        :
*********************************************************************************************************
*/
void GDispGoto(unsigned int16 row, unsigned int16 col)
{
   unsigned int16 addr;

   addr = row*COLUMN + col + TEXT_HOME_ADDR;
   GDispCmdAddrSend(addr,ADDR_PTR_SET);                     //Set address pointer
}


/*
*********************************************************************************************************
*                     DISPLAY A CHARACTER AT THE CURRENT SCREEN ADDRESS POINTER
*
* Description : This function is used to display a single character on the display device at row, col
*            col, row should have been set by GDispGoto(row, col) before. AUTO ADDRESS POINTER INC!
* Arguments   :   'c'     is the ASCII character to write
* Returns     : none
* Notes        : This function gets around the problem that pointers cannot be created to constant string
*            in PCM. Referring to CCS Reference Manual (page 67), a function that has one CHAR
*            parameter will accept a constant string where it is called. PCM will generate a loop
*            that will call the function once for each character in the string.
*            Example :
*               GDispGoto(5,5);
*               GDispChar("Hello there!");
*********************************************************************************************************
*/
void GDispChar(unsigned char c)
{
      GDispDataWr(c - 0x20);               //Adjust standard ASCII to T6963 ASCII
   GDispCmdSend(DATA_WR_INC);            //Address pointer increment ON
}


/*
*********************************************************************************************************
*                              DISPLAY A CHARACTER AT A POSITION (row, col)
*
* Description : This function is used to display a single character on the display device, address
*            auto increment OFF!
* Arguments   : 'row'   row = 0...(MAX_ROW_PIXEL/8 - 1), the row pos of the cursor (MAX_ROW_PIXEL/8-1)
*            'col'   col = 0...(COLUMN-1), is the column position in font width (6/8 font)
*            'c'     is the ASCII character to write
* Returns     : none
* Notes        : COLUMN constant determines the number of page, can be > physical size of the LCD
*********************************************************************************************************
*/
void GDispCharAt(unsigned int16 row, unsigned int16 col, unsigned char c )
{
      GDispGoto(row, col);
   GDispDataWr(c - 0x20);
   GDispCmdSend(DATA_WR);
}


/*
*********************************************************************************************************
*                                     SET CURSOR AT A POSITION
*
* Description : This function sets cursor at a position (row, col), of certain mode & type
* Arguments   : 'mode' is the mode of cursor. It should be bitwise OR with a TEXT / GRAPH mode to work
*                   mode =    TEXT_GRH_ON|CURSOR_BLINK_ON
*                        TEXT_ON|CURSOR_ON_BLINK_OFF....
*                        TEXT_ON, without bitwise OR any cursor mode only will clear cursor
*            'row'  is the MSB of screen address, the row position of the cursor
*            'col'  is the LSB of the screen address, the column position of the cursor
*            'type' is cursor type
*                  type = LINE_1_CURSOR / LINE_8_CURSOR
* Returns     : none
* Notes        : Cursor address is not like text address pointer. Cannot use GDispGoto(row,col).
*********************************************************************************************************
*/
void GDispSetCursor(unsigned int8 mode, unsigned int16 row, unsigned int16 col, unsigned int8 type)
{
   unsigned int16 addr;

   addr = row << 8;
   addr = addr|(col&0x00FF);
      GDispCmdAddrSend(addr, ADDR_PTR_SET);
      GDispCmdSend(CURSOR_PTR_SET);        //Set cursor position
   GDispCmdSend(mode);
      GDispCmdSend(type);             //cursor mode
}


/*
*********************************************************************************************************
*                                     SET PIXEL AT X, Y POSITION
*
* Description : This function sets a pixel with color = BLACK / WHITE (defined in t6963.h)
* Arguments   : 'X'    0....MAX_COL_PIXEL is matrix position in horizontal direction
*            'Y     0....MAX_ROW_PIXEL is matrix position in vertical direction
*            'color'  sets BLACK / WHITE standing for pixel ON/OFF
* Returns     : none
* Notes        :
*********************************************************************************************************
*/
void GDispSetPixel(unsigned int16 X, unsigned int16 Y, unsigned int8 color)
{
   unsigned int16 addr;
   unsigned int16 row, col;
   unsigned char cmd;

      row = Y;
      col = X/8;
         addr = row*COLUMN + col + GRH_HOME_ADDR;
      GDispCmdAddrSend(addr, ADDR_PTR_SET);

      if (color == BLACK)
         cmd = (0b11111000)|(8- 1 -(X%8));
      else
         cmd = (0b11110000)|(8- 1 -(X%8));

      GDispCmdSend(cmd);
}

void glcd_3Dbox(int16 x,int16 y,int16 width, int16 height, int depth, int1 color)
{
   int16 i,j;
   for(i=x;i<=x+width;i++)
   {
      GDispSetPixel(i,y,1);
      GDispSetPixel(i,y+height,1);
   }
   for(i=y;i<=y+height;i++)
   {
     GDispSetPixel(x,i,1);
     GDispSetPixel(x+width,i,1);
   }
   for(j=1;j<=depth;j++)
   {
      for(i=y+j;i<=y+height+j;i++)
      {
         GDispSetPixel(x-j,i,1);
      }
   }
   for(j=1;j<=depth;j++)
   {
      for(i=x-j;i<=(x-j+width);i++)
      {
         GDispSetPixel(i,y+height+j,color);
      }
   }
}
/*
*********************************************************************************************************
*                               SET TEXT ATTRIBUTE (NOT COMPLETE DEBUG)
*
* Description : This function sets / clears text attribute mode
* Arguments   : 'row'   row = 0...(MAX_ROW_PIXEL/8 - 1), the row pos of the cursor (MAX_ROW_PIXEL/8-1)
*            'col'   col = 0...(COLUMN-1), is the column position in font width (6/8 font)
*            'mode'  =    ATTR_REVERSE, ATTR_INHIBIT, ATTR_BLINK_REVERSE, ATTR_BLINK_INHIBIT...
*                     (see TEXT ATTRIBUTE MODE in t6963.h for available mode)
* Returns     : none
* Notes        : After function call to GDispSetAttrb(row,col,ATTR_BLINK_REVERSE),
*            should use GDispSetAttrib(row,col, ATTR_NORMAL) before using graphic area again to avoid
*            graphic area data write error!
*********************************************************************************************************
*/

void GDispSetAttrb(unsigned int16 row, unsigned int16 col, unsigned int8 mode)
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
*                                  SET CUSTOM DEFINED CHARACTER TO CG RAM
*
* Description : This function assigns a custom created pattern of 8 BYTE with an id number
* Arguments   : 'id'   is the identifier for the pattern created. Range of 'id' is 0...127 for T6963.
*            'pat'    is a pointer to an 8 BYTE array containing the dot pattern
* Returns     : none
* Notes        : Pointers cannot be created to constant arrays in PCM. Thus, a global CGBuffer[]'s created
*            in t6963.h to store a constant array to RAM space.
*            Code Example   ::
*
*            char i;
*            const char CUSTOM_PAT[8] = {0x00, 0x23, 0x45, 0x56, 0x89, 0xAB, 0xFF, 0xEE};
*            for(i=0;i<8;i++) CGBuffer[i] = CUSTOM_PAT[i]   //assign CUSTOM_PAT[] to CGBuffer[]
*            GDispDefCGChar(0, &CGBuffer[0]);            //create a pattern in CG RAM with id '0'
*********************************************************************************************************
*/
void GDispDefCGChar(unsigned int8 id, unsigned char *pat)
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
* Arguments   : 'id'   is the identifier for the pattern created. Range of 'id' is 0...127 for T6963.
* Returns     : none
* Notes        :
*********************************************************************************************************
*/
void GDispCGChar(unsigned int8 id)
{
   GDispDataWr(0x80 + id);               //Adjust standard ASCII to T6963 ASCII
   GDispCmdSend(DATA_WR_INC);            //'0x80 + id's range 0 to 255, good for GDispDataWr(char)
}

/*
*********************************************************************************************************
*                         DISPLAY AN EXTERNAL CG CHARACTER AT ROW, COL
*
* Description : This function shows a pre-defined CG RAM character at (row, col) coordinates
* Arguments   : 'id'   is the identifier for the pattern created. Range of 'id' is 0...127 for T6963.
* Returns     : none
* Notes        :
*********************************************************************************************************
*/
void GDispCGCharAt(unsigned int16 row, unsigned int16 col, unsigned int8 id)
{
   GDispGoto(row,col);
   GDispCGChar(id);
}


/*
*********************************************************************************************************
*                            DISPLAY A BLANK ICON OF 32x32 MATRIX AT ROW, COL
*
* Description : This function clears the 32x32 ICON at (row, col) coordinates
* Arguments   : 'row'   row = 0...(MAX_ROW_PIXEL/8 - 1), the row pos of the cursor (MAX_ROW_PIXEL/8-1)
*            'col'   col = 0...(COLUMN-1), is the column position in font width (6/8 font)
* Returns     : none
* Notes        :
*********************************************************************************************************
*/
void GDispBlkIcon32X32At(unsigned int16 row, unsigned int16 col)
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
*                  CONVERT A STRING TO PIXEL DATA AND DISPLAY AT X,Y IN GRAPHIC MODE
*
* Description : This function outputs a string in graphic mode from a char* textptr pointer
* Arguments   : 'X'          0....MAX_COL_PIXEL is matrix position in horizontal direction
*            'Y           0....MAX_ROW_PIXEL is matrix position in vertical direction
*            'textptr'   pointer to the string to write
*            'size'      should be non-zero, 1 = 5x7, 2 = 10x14, ..., basically "enlarge" the font
*                     defined under font5x7.h.
*            'color'      BLACK / WHITE
* Returns     : none
* Notes        : Copyright (c) 2004 Sentinel Systems Corporation
*            Example, declare a string
*            .
*            char str[] = "Hello World!";
*            .
*            .
*            main()
*            {
*               GDispPixFontAt(0,20,&str[0],2,BLACK); //Display the "Hello World!" string starting
*                                            //at (x,y)=(0,20), in size font size 2 (10x14)
*                                            //color in black
*            }
*********************************************************************************************************
*/
void GDispPixFontAt(unsigned int16 X, unsigned int16 Y, unsigned char* textptr, unsigned char size, int1 color)
{
   const BYTE bytes_per_char = 5;
   int i, j, k, l, m;                         // Loop counters
   BYTE pixelData[bytes_per_char];             // Stores character data

   for(i=0; textptr[i] != '\0'; ++i, ++X)          // Loop through the passed string
   {
      if(textptr[i] < 'S')                   // Checks if the letter is in the first or second array
      memcpy(pixelData, FONT1[textptr[i]-' '], bytes_per_char);
      else if(textptr[i] <= '~')                // Check if the letter is in the second array
      memcpy(pixelData, FONT2[textptr[i]-'S'], bytes_per_char);
      else                               // Default to space if character out of range
      memcpy(pixelData, FONT1[0], bytes_per_char);

      if(X+5*size >= MAX_COL_PIXEL)             // Performs character wrapping
      {
         X = 0;                            // Set X at far left position
         Y += 7*size + 1;                   // Set Y at next position down
      }
      for(j=0; j<bytes_per_char; ++j, X+=size)    // 5 bytes per character
      {
         for(k=0; k<7*size; ++k)             // Loop through the vertical pixels
         {
         if(bit_test(pixelData[j], k))          // Check if the pixel should be set
         {
            for(l=0; l<size; ++l)             // The next two loops change the character's size
            {
               for(m=0; m<size; ++m)
               {                         // Draws the pixel
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
*                                      I/O PORT INITIALIZATION
*
* Description : This initializes the I/O ports used by the display driver
* Arguments   : none
* Returns     : none
* Notes        :
*********************************************************************************************************
*/
void GDispInitPort(void)
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
*                                          BUSY CHECK
*
* Description : This function checks command execution capability, & data read/write capability
* Arguments   : none
* Returns     : none
* Notes        :
*********************************************************************************************************
*/
void GDispBusyChk(void)
{
   GDispCmdRd;
     GDispChipEn;
     #asm
      nop
     #endasm
     while (!STA0)         // Busy Check here
      ;
     while (!STA1)
         ;
     GDispChipDi;         //Chip disable to finish
}

/*
*********************************************************************************************************
*                                       AUTO MODE DATA WRITE CHECK
*
* Description : This function checks auto mode data write capability
* Arguments   : none
* Returns     : none
* Notes        :
*********************************************************************************************************
*/
void GDispAutoWrChk(void)
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
*                                          WRITE DATA TO LCD MODULE
*
* Description : This function sends a single data byte to the display device
* Arguments   : 'data' is the BYTE to send to the display device
* Returns     : none
* Notes        :
*********************************************************************************************************
*/
void GDispDataWr(unsigned char data)
{
  GDispBusyChk();             // Wait for LCD to be ready

  LCD_DATA = data;               // Data write
  #asm
   nop
  #endasm
  GDispDatWr;
  GDispChipEn;
  #asm
   nop                     //delay one cycle for port stablize
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
* Notes        :
*********************************************************************************************************
*/
void GDispAutoDataWr(unsigned char data)
{
  GDispAutoWrChk();             // Auto write mode check

  LCD_DATA = data;               // Data write
  #asm
   nop
  #endasm
  GDispDatWr;
  GDispChipEn;
  #asm
   nop                     //delay one cycle for port stablize
  #endasm
  GDispChipDi;
}


/*
*********************************************************************************************************
*                                       WRITE COMMAND TO LCD MODULE
*
* Description : This function sends a single byte as command to the display device
* Arguments   : 'cmd' is the COMMAND BYTE to send to the display device
* Returns     : none
* Notes        :
*********************************************************************************************************
*/
void GDispCmdSend(unsigned char cmd)
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


Last edited by sudarsan on Thu Nov 08, 2012 1:10 am; edited 1 time in total

sudarsan



Joined: 08 Nov 2012
Posts: 5
Location: India
View user's profile  Send private message

t6963.h file
PostPosted: Thu Nov 08, 2012 1:09 am    	Reply with quote
Code:
/*
***********************************************************************************************
*                              PORT DEFINITION
***********************************************************************************************
*/
#byte   PORTA   =   0x05
#byte   TRISA   =   0x85
#bit   PORTA0   =   PORTA.0

#bit   PORTA1   =   PORTA.1
#bit   PORTA2   =   PORTA.2
#bit   PORTA3   =   PORTA.3
#bit   PORTA4   =   PORTA.4
#bit   PORTA5   =   PORTA.5
#bit   TRISA0   =   TRISA.0
#bit   TRISA1   =   TRISA.1
#bit   TRISA2   =   TRISA.2
#bit   TRISA3   =   TRISA.3
#bit   TRISA4   =   TRISA.4
#bit   TRISA5   =   TRISA.5

#byte   PORTB   =   0x06
#byte   TRISB   =   0x86
#bit   PORTB0   =   PORTB.0
#bit   PORTB1   =   PORTB.1
#bit   PORTB2   =   PORTB.2
#bit   PORTB3   =   PORTB.3
#bit   PORTB4   =   PORTB.4
#bit   PORTB5   =   PORTB.5
#bit   PORTB6   =   PORTB.6
#bit   PORTB7   =   PORTB.7
#bit   TRISB0   =   TRISB.0
#bit   TRISB1   =   TRISB.1
#bit   TRISB2   =   TRISB.2
#bit   TRISB3   =   TRISB.3
#bit   TRISB4   =   TRISB.4
#bit   TRISB5   =   TRISB.5
#bit   TRISB6   =   TRISB.6
#bit   TRISB7   =   TRISB.7

#byte   PORTC   =   0x07
#byte   TRISC   =   0x87
#bit   PORTC0   =   PORTC.0
#bit   PORTC1   =   PORTC.1
#bit   PORTC2   =   PORTC.2
#bit   PORTC3   =   PORTC.3
#bit   PORTC4   =   PORTC.4
#bit   PORTC5   =   PORTC.5
#bit   PORTC6   =   PORTC.6
#bit   PORTC7   =   PORTC.7
#bit   TRISC0   =   TRISC.0
#bit   TRISC1   =   TRISC.1
#bit   TRISC2   =   TRISC.2
#bit   TRISC3   =   TRISC.3
#bit   TRISC4   =   TRISC.4
#bit   TRISC5   =   TRISC.5
#bit   TRISC6   =   TRISC.6
#bit   TRISC7   =   TRISC.7

#byte   PORTD   =   0x08
#byte   TRISD   =   0x88
#bit   PORTD0   =   PORTD.0
#bit   PORTD1   =   PORTD.1
#bit   PORTD2   =   PORTD.2
#bit   PORTD3   =   PORTD.3
#bit   PORTD4   =   PORTD.4
#bit   PORTD5   =   PORTD.5
#bit   PORTD6   =   PORTD.6
#bit   PORTD7   =   PORTD.7
#bit   TRISD0   =   TRISD.0
#bit   TRISD1   =   TRISD.1
#bit   TRISD2   =   TRISD.2
#bit   TRISD3   =   TRISD.3
#bit   TRISD4   =   TRISD.4
#bit   TRISD5   =   TRISD.5
#bit   TRISD6   =   TRISD.6
#bit   TRISD7   =   TRISD.7

#byte    PORTE   =   0x09
#byte   TRISE   =   0x89
#bit   PORTE0   =   PORTE.0
#bit   PORTE1   =   PORTE.1
#bit   PORTE2   =   PORTE.2
#bit   TRISE0   =   TRISE.0
#bit   TRISE1   =   TRISE.1
#bit   TRISE2   =   TRISE.2

//I/O port for data definition
#ifndef T6963_H
#define T6963_H

#define LCD_DATA         PORTD      // LCD data port
#define LCD_DATA_TRIS      TRISD      // LCD Data port Tris
#define STA0            PORTD0      // Check command execution capability
#define STA1            PORTD1      // Check data read/write capability
#define STA2            PORTD2      // Check Auto mode data read capability
#define STA3            PORTD3      // Check Auto mode data write capability
#define STA5            PORTD5      // Check controller operation capability
#define STA6            PORTD6      // Error flag. Used for screen peek and screen copy
#define STA7            PORTD7      // Check the blink condition

//Control pin setting
#define LCD_CE            PORTC2      // LCD Enable control line pin number
#define LCD_CE_TRIS        TRISC2      // LCD Enable control line direction pin #
#define LCD_RD            PORTC1      // LCD Read control line  pin number
#define LCD_RD_TRIS          TRISC1      // LCD Read control line direction pin #
#define LCD_WR            PORTC0      // LCD Write control line pin number
#define LCD_WR_TRIS          TRISC0      // LCD Write control line irection pin #
#define LCD_CD            PORTB7      // LCD Control/data Select line
#define LCD_CD_TRIS          TRISB7      // LCD Control/data Select line direction
#define LCD_RST             PORTB6      // LCD RST_ line
#define LCD_RST_TRIS      TRISB6      // LCD RST_line direction
#endif

/*
***********************************************************************************************
*                              GLOBAL CONSTANTS
***********************************************************************************************
*/

/*
***********************************************************************************************
* Note      :    The T6963 controller's RAM address space from $0000 - $FFFF, total 64kbyte RAM.
*            It is just the RAM address set, not the actual RAM amount can be set!
*            However, everything manufacturer may mount different amount of RAM on its
*            module. Example, Powertip's PG12864-F has 4 kbyte RAM only.
*            RAM space to handle 128x64 dots in 8 font = 128x64/8 = 1,024 byte.
*            Thus, the LCD's actual visible screen area is 1 kbyte.
*            For 8-font, 16 COLUMN,
*            TEXT_HOME_ADDR    starts 0x0000 ending 0x01FF -> 512  bytes (for text use)?
*            GRH_HOME_ADDR   starts 0x0200 ending 0x05FF -> 1,024 bytes ?
*            CG_HOME_ADDR   starts 0x1400 ending 0x147F   -> 128  bytes (custom characters) ?
***********************************************************************************************
*/
#define TEXT_HOME_ADDR      0x0000
#define GRH_HOME_ADDR       0x0200
#define CG_HOME_ADDR      0x1400
#define COLUMN            30      //Set column number to be e.g. 32 for 8x8 fonts, 2 pages
#define MAX_ROW_PIXEL      64      //MAX_ROW_PIXEL the physical matrix length (y direction)
#define MAX_COL_PIXEL      240   //MAX_COL_PIXEL the physical matrix width (x direction)
#define ENABLE            1
#define DISABLE            0
#define BLACK            1
#define WHITE            0

/*
***********************************************************************************************
*                              DISPLAY MODE
***********************************************************************************************
*/
#define DISPLAY_OFF         0x90    //0b10010000, display off
#define CURSOR_ON_BLINK_OFF 0x92    //0b1001xx10, cursor on without blinking
#define CURSOR_BLINK_ON     0x93    //0b1001xx11, cursor on with blinking
#define TEXT_ON             0x94    //0b100101xx, text on, graphics off
#define GRAPHIC_ON          0x98    //0b100110xx, text off, graphics on
#define TEXT_GRH_ON         0x9C    //0b100111xx, text on, graphics on


/*
***********************************************************************************************
*                                 MODE
***********************************************************************************************
*   Example:    OR_MODE|EXT_CG_MODE    ->    OR mode, external CG ram mode
*            AND_MODE            ->    AND mode, internal CG ROM mode
***********************************************************************************************
*/
/*
***********************************************************************************************
*      In internal CG ROM MODE (INT_CG_MODE), character codes 00h - 7Fh represent the
*      pre-defined "internal" CG ROM characters, and codes 80h - FFh represent the
*      users' own "external" characters. In external CG ROM MODE (EXT_CG_MODE),
*      all 256 codes from 00h - FFh can be used to represent the users' own characters.
***********************************************************************************************
*/

#define INT_CG_MODE         0x80    //0b10000xxx, Internal CG ROM mode
#define EXT_CG_MODE         0x88    //0b10001xxx, External CG RAM mode
#define OR_MODE             0x80    //0b1000x000, OR mode, internal CG ROM mODE
#define XOR_MODE            0x81    //0b1000x001, XOR mode, internal CG ROM mode
#define AND_MODE            0x83    //0b1000x011, AND mode, internal CG ROM mode
#define TEXT_ATTR_MODE      0x84    //0b1000x100, text attribute mode, internal CG ROM mode



/*
***********************************************************************************************
*                              CURSOR MODE
***********************************************************************************************
*/
#define LINE_8_CURSOR       0xA7    //8-line cursor mode
#define LINE_7_CURSOR      0xA6   //7-line cursor mode
#define LINE_6_CURSOR      0xA5   //6-line cursor mode
#define LINE_5_CURSOR      0xA4   //5-line cursor mode
#define LINE_4_CURSOR      0xA3   //4-line cursor mode
#define LINE_3_CURSOR      0xA2   //3-Line cursor mode
#define LINE_2_CURSOR      0xA1   //2-Line cursor mode
#define LINE_1_CURSOR       0xA0    //1-Line cursor mode

/*
***********************************************************************************************
*                           TEXT ATTRIBUTE MODE
***********************************************************************************************
*/
#define ATTR_NORMAL         0x00    //Normal Display
#define ATTR_REVERSE        0x05    //Reverse Display
#define ATTR_INHIBIT        0x03    //Inhibit Display
#define ATTR_BLINK          0x08    //Blinking of Normal Display
#define ATTR_BLINK_REVERSE  0x0D    //Blinking of Reverse Display
#define ATTR_BLINK_INHIBIT  0x0B    //Blinking of Inhibit Display


/*
***********************************************************************************************
*                             GLOBAL VARIABLES
***********************************************************************************************
*/
 unsigned int8    DisplayMode;   /* Keeps state of the display mode (DISPLAY MODE)    */
 unsigned int8   Mode;         /* Keeps state of the MODE                     */
// extern unsigned const   FontSize;      /* 6 font or 8 font                           */
 unsigned char   CGBuffer[8];   /* Buffer for custom pattern                  */

/*
***********************************************************************************************
*                           FUNCTION PROTOTYPES
***********************************************************************************************
*/
void GDispInit(void);
void GDispSetMode(unsigned int8 mode);
void GDispClrTxt(void);
void GDispClrGrh(void);
void GDispGoto(unsigned int16 row, unsigned int16 col);
void GDispChar(unsigned char c);
void GDispCharAt(unsigned int16 row, unsigned int16 col, unsigned char c);
void GDispSetCursor(unsigned int8 mode, unsigned int16 row, unsigned int16 col, unsigned int8 type);
void GDispSetPixel(unsigned int16 X, unsigned int16 Y, unsigned int8 color);
void GDispSetAttrb(unsigned int16 row, unsigned int16 col, unsigned int8 mode);
void GDispDefCGChar(unsigned int8 id, unsigned char *pat);
void GDispCGChar(unsigned int8 id);
void GDispCGCharAt(unsigned int16 row, unsigned int16 col, unsigned int8 id);
void GDispBlkIcon32X32At(unsigned int16 row, unsigned int16 col);
void GDispPixFontAt(unsigned int16 X, unsigned int16 Y, unsigned char* textptr, unsigned char size, int1 color);
void glcd_3Dbox(int16 x,int16 y,int16 width, int16 height, int depth, int1 color);

/*
***********************************************************************************************
*                           FUNCTION PROTOTYPES
*                            HARDWARE SPECIFIC
***********************************************************************************************
*/
#define GDispChipEn      LCD_CE = 0               /* Low level Chip Enable macro          */
#define GDispChipDi      LCD_CE = 1               /* Low level Chip Disable macro       */
#define GDispCmdWr      LCD_DATA_TRIS = 0x00;   \
                  LCD_RD = 1; LCD_CD = 1; \
                  LCD_WR = 0                 /* Low level command write macro      */
#define GDispCmdRd      LCD_DATA_TRIS = 0xFF;    \
                  LCD_RD = 0; LCD_CD = 1; \
                  LCD_WR = 1               /* Low level command read macro         */
#define GDispDatWr      LCD_DATA_TRIS = 0x00;   \
                  LCD_RD = 1; LCD_CD = 0; \
                  LCD_WR = 0               /* Low level data write macro         */
#define GDispDatRd      LCD_CD = 0; LCD_WR = 1      /* Low level data read macro         */

void GDispInitPort(void);
void GDispBusyChk(void);
void GDispAutoWrChk(void);
void GDispDataWr(unsigned char data);
void GDispAutoDataWr(unsigned char data);
void GDispCmdSend(unsigned char cmd);

sudarsan



Joined: 08 Nov 2012
Posts: 5
Location: India
View user's profile  Send private message

font 5x7.h
PostPosted: Thu Nov 08, 2012 1:11 am    	Reply with quote
Code:

const unsigned char FONT1[51][5] =
{
0x00, 0x00, 0x00, 0x00, 0x00, // SPACE
0x00, 0x00, 0x5F, 0x00, 0x00, // !
0x00, 0x03, 0x00, 0x03, 0x00, // "
0x14, 0x3E, 0x14, 0x3E, 0x14, // #
0x24, 0x2A, 0x7F, 0x2A, 0x12, // $
0x43, 0x33, 0x08, 0x66, 0x61, // %
0x36, 0x49, 0x55, 0x22, 0x50, // &
0x00, 0x05, 0x03, 0x00, 0x00, // '
0x00, 0x1C, 0x22, 0x41, 0x00, // (
0x00, 0x41, 0x22, 0x1C, 0x00, // )
0x14, 0x08, 0x3E, 0x08, 0x14, // *
0x08, 0x08, 0x3E, 0x08, 0x08, // +
0x00, 0x50, 0x30, 0x00, 0x00, // ,
0x08, 0x08, 0x08, 0x08, 0x08, // -
0x00, 0x60, 0x60, 0x00, 0x00, // .
0x20, 0x10, 0x08, 0x04, 0x02, // /
0x3E, 0x51, 0x49, 0x45, 0x3E, // 0
0x04, 0x02, 0x7F, 0x00, 0x00, // 1
0x42, 0x61, 0x51, 0x49, 0x46, // 2
0x22, 0x41, 0x49, 0x49, 0x36, // 3
0x18, 0x14, 0x12, 0x7F, 0x10, // 4
0x27, 0x45, 0x45, 0x45, 0x39, // 5
0x3E, 0x49, 0x49, 0x49, 0x32, // 6
0x01, 0x01, 0x71, 0x09, 0x07, // 7
0x36, 0x49, 0x49, 0x49, 0x36, // 8
0x26, 0x49, 0x49, 0x49, 0x3E, // 9
0x00, 0x36, 0x36, 0x00, 0x00, // :
0x00, 0x56, 0x36, 0x00, 0x00, // ;
0x08, 0x14, 0x22, 0x41, 0x00, // <
0x14, 0x14, 0x14, 0x14, 0x14, // =
0x00, 0x41, 0x22, 0x14, 0x08, // >
0x02, 0x01, 0x51, 0x09, 0x06, // ?
0x3E, 0x41, 0x59, 0x55, 0x5E, // @
0x7E, 0x09, 0x09, 0x09, 0x7E, // A
0x7F, 0x49, 0x49, 0x49, 0x36, // B
0x3E, 0x41, 0x41, 0x41, 0x22, // C
0x7F, 0x41, 0x41, 0x41, 0x3E, // D
0x7F, 0x49, 0x49, 0x49, 0x41, // E
0x7F, 0x09, 0x09, 0x09, 0x01, // F
0x3E, 0x41, 0x41, 0x49, 0x3A, // G
0x7F, 0x08, 0x08, 0x08, 0x7F, // H
0x00, 0x41, 0x7F, 0x41, 0x00, // I
0x30, 0x40, 0x40, 0x40, 0x3F, // J
0x7F, 0x08, 0x14, 0x22, 0x41, // K
0x7F, 0x40, 0x40, 0x40, 0x40, // L
0x7F, 0x02, 0x0C, 0x02, 0x7F, // M
0x7F, 0x02, 0x04, 0x08, 0x7F, // N
0x3E, 0x41, 0x41, 0x41, 0x3E, // O
0x7F, 0x09, 0x09, 0x09, 0x06, // P
0x1E, 0x21, 0x21, 0x21, 0x5E, // Q
0x7F, 0x09, 0x09, 0x09, 0x76  // R
};

const unsigned char FONT2[44][5]=
{
0x26, 0x49, 0x49, 0x49, 0x32, // S
0x01, 0x01, 0x7F, 0x01, 0x01, // T
0x3F, 0x40, 0x40, 0x40, 0x3F, // U
0x1F, 0x20, 0x40, 0x20, 0x1F, // V
0x7F, 0x20, 0x10, 0x20, 0x7F, // W
0x41, 0x22, 0x1C, 0x22, 0x41, // X
0x07, 0x08, 0x70, 0x08, 0x07, // Y
0x61, 0x51, 0x49, 0x45, 0x43, // Z
0x00, 0x7F, 0x41, 0x00, 0x00, // [
0x02, 0x04, 0x08, 0x10, 0x20, // \
0x00, 0x00, 0x41, 0x7F, 0x00, // ]
0x04, 0x02, 0x01, 0x02, 0x04, // ^
0x40, 0x40, 0x40, 0x40, 0x40, // _
0x00, 0x01, 0x02, 0x04, 0x00, // `
0x20, 0x54, 0x54, 0x54, 0x78, // a
0x7F, 0x44, 0x44, 0x44, 0x38, // b
0x38, 0x44, 0x44, 0x44, 0x44, // c
0x38, 0x44, 0x44, 0x44, 0x7F, // d
0x38, 0x54, 0x54, 0x54, 0x18, // e
0x04, 0x04, 0x7E, 0x05, 0x05, // f
0x08, 0x54, 0x54, 0x54, 0x3C, // g
0x7F, 0x08, 0x04, 0x04, 0x78, // h
0x00, 0x44, 0x7D, 0x40, 0x00, // i
0x20, 0x40, 0x44, 0x3D, 0x00, // j
0x7F, 0x10, 0x28, 0x44, 0x00, // k
0x00, 0x41, 0x7F, 0x40, 0x00, // l
0x7C, 0x04, 0x78, 0x04, 0x78, // m
0x7C, 0x08, 0x04, 0x04, 0x78, // n
0x38, 0x44, 0x44, 0x44, 0x38, // o
0x7C, 0x14, 0x14, 0x14, 0x08, // p
0x08, 0x14, 0x14, 0x14, 0x7C, // q
0x00, 0x7C, 0x08, 0x04, 0x04, // r
0x48, 0x54, 0x54, 0x54, 0x20, // s
0x04, 0x04, 0x3F, 0x44, 0x44, // t
0x3C, 0x40, 0x40, 0x20, 0x7C, // u
0x1C, 0x20, 0x40, 0x20, 0x1C, // v
0x3C, 0x40, 0x30, 0x40, 0x3C, // w
0x44, 0x28, 0x10, 0x28, 0x44, // x
0x0C, 0x50, 0x50, 0x50, 0x3C, // y
0x44, 0x64, 0x54, 0x4C, 0x44, // z
0x00, 0x08, 0x36, 0x41, 0x41, // {
0x00, 0x00, 0x7F, 0x00, 0x00, // |
0x41, 0x41, 0x36, 0x08, 0x00, // }
0x02, 0x01, 0x02, 0x04, 0x02  // ~
};
