'''    Graphical LCD routines for the GCBASIC compiler
'''    Copyright (C) 2019 Evan Venn
''
'''    This library is free software; you can redistribute it and/or
'''    modify it under the terms of the GNU Lesser General Public
'''    License as published by the Free Software Foundation; either
'''    version 2.1 of the License, or (at your option) any later version.
''
'''    This library is distributed in the hope that it will be useful,
'''    but WITHOUT ANY WARRANTY; without even the implied warranty of
'''    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
'''    Lesser General Public License for more details.
''
'''    You should have received a copy of the GNU Lesser General Public
'''    License along with this library; if not, write to the Free Software
'''    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
'
'********************************************************************************
'********************************************************************************
'********************************************************************************





'***********************************************************************************************
'*                   START OF USER REQUIRED GLOBAL CONSTANTS - examples
'***********************************************************************************************

'''  #define GLCD_DATA_PORT PORTD
'''
'''  #define GLCD_CS        PORTa.7          'Chip Enable (Active Low)
'''  #define GLCD_CD        PORTa.0
'''  #define GLCD_RD        PORTA.1           'LCD Read control line  pin number
'''  #define GLCD_WR        PORTA.2           'LCD Write control line pin number
'''  #define GLCD_RESET     PORTA.3
'''  #define GLCD_FS        PORTA.5            'FS1 I Font Select 6x8 font: FS1=�High�=1 8x8 font FS1=�Low�=1 for GLCD_FS_SELECT
'''  #define GLCD_FS_SELECT 1
'''
'''  '***********************************************************************************************
'''  '* Note    :   The T6963 controller's RAM address space from $0000 - $FFFF, total 64kbyte RAM.
'''  '*       It is just the RAM address set, not the actual RAM amount can be set!
'''  '*
'''  '***********************************************************************************************
'''  #define TEXT_HOME_ADDR      0x0000                                                         'This is specific to the GLCD display
'''  #define GRH_HOME_ADDR       0x3FFF                                                         'This is specific to the GLCD display
'''  #define CG_HOME_ADDR        0x77FF                                                        'This is specific to the GLCD display
'''  #define COLUMN              40    'Set column number to be 40 , 32, 30 etc.                 This is specific to the GLCD display
'''  #define MAX_ROW_PIXEL       64    'MAX_ROW_PIXEL the physical matrix length (y direction)   This is specific to the GLCD display
'''  #define MAX_COL_PIXEL       240   'MAX_COL_PIXEL the physical matrix width (x direction)    This is specific to the GLCD display


    '***********************************************************************************************
    '*                   END OF USER REQUIRED GLOBAL CONSTANTS
    '***********************************************************************************************






    '***********************************************************************************************
    '*                   GLOBAL CONSTANTS - DEFAULTS DO NOT CHANGE HERE - CHANGE IN USER PROGRAM
    '***********************************************************************************************

    '***********************************************************************************************
    '*                   GLOBAL CONSTANTS - DEFAULTS DO NOT CHANGE HERE - CHANGE IN USER PROGRAM
    '***********************************************************************************************

    '***********************************************************************************************
    '*                   GLOBAL CONSTANTS - DEFAULTS DO NOT CHANGE HERE - CHANGE IN USER PROGRAM
    '***********************************************************************************************

    '***********************************************************************************************
    '*                   GLOBAL CONSTANTS - DEFAULTS DO NOT CHANGE HERE - CHANGE IN USER PROGRAM
    '***********************************************************************************************

    '***********************************************************************************************
    '*                   GLOBAL CONSTANTS - DEFAULTS DO NOT CHANGE HERE - CHANGE IN USER PROGRAM
    '***********************************************************************************************

    '***********************************************************************************************
    '*                   GLOBAL CONSTANTS - DEFAULTS DO NOT CHANGE HERE - CHANGE IN USER PROGRAM
    '***********************************************************************************************


    #define T6963ReadDelay   0     ; 0 normal usage
    #define T6963WriteDelay  0     ; 0 normal usage
    #define T6963ClockDelay  0     ; 0 normal usage

    '
    '***********************************************************************************************
    '*                   GLOBAL CONSTANTS - DO NOT CHANGE
    '***********************************************************************************************

    ' Pin defines - do not change
    #define STA0         GLCD_DATA_PORT.0   'Check command execution capability
    #define STA1         GLCD_DATA_PORT.1   'Check data read/write capability
    #define STA2         GLCD_DATA_PORT.2   'Check Auto mode data read capability
    #define STA3         GLCD_DATA_PORT.3   'Check Auto mode data write capability
    #define STA5         GLCD_DATA_PORT.5   'Check controller operation capability
    #define STA6         GLCD_DATA_PORT.6   'Error flag. Used for screen peek and screen copy
    #define STA7         GLCD_DATA_PORT.7   'Check the blink condition

    '
    '***********************************************************************************************
    '*                   GLOBAL CONSTANTS - DO NOT CHANGE
    '***********************************************************************************************
    '
    ' MAX_COLUMNS - calculated value equates to the number of columns in LCD mode
    ' MAX_ROWS - calculated value equates to the number of rows in LCD mode
    '
    '***********************************************************************************************
    '*                   DISPLAY MODE
    '***********************************************************************************************
    '
    #define DISPLAY_OFF                            0x90    '0b10010000, display off
    #define CURSOR_ON_BLINK_OFF                    0x92    '0b1001xx10, cursor on without blinking
    #define CURSOR_BLINK_ON                        0x93    '0b1001xx11, cursor on with blinking
    #define TEXT_ON                                0x94    '0b100101xx, text on, graphics off
    #define TEXT_ON                                0x94    '0b100101xx, text on, graphics off
    #define TEXT_ON                                0x94    '0b100101xx, text on, graphics off
    #define TEXT_ON_CURSOR_ON_BLINK_OFF            0x96    '0b10010110, text on, graphics off, cursor on without blinking
    #define TEXT_ON_CURSOR_ON_BLINK_ON             0x97    '0b10010111, text on, graphics off, cursor on with blinking
    #define GRAPHIC_ON                             0x98    '0b100110xx, text off, graphics on
    #define TEXT_GRH_ON                            0x9C    '0b100111xx, text on, graphics on
    #define TEXT_GRH_C                             0x9C    '0b100111xx, text on, graphics on
    #define TEXT_GRH_CURSOR_ON_BLINK_OFF           0x9E    '0b10011110, text on, graphics on, cursor on without blinking
    #define TEXT_GRH_CURSOR_ON_BLINK_ON            0x9F    '0b10011111, text on, graphics on, cursor on with blinking



    '
    '***********************************************************************************************
    '*                     MODE
    '***********************************************************************************************
    '* Example:  OR_MODE|EXT_CG_MODE   ->  OR mode, external CG ram mode
    '*       AND_MODE        ->  AND mode, internal CG ROM mode
    '***********************************************************************************************
    '
    '
    '***********************************************************************************************
    '*   In internal CG ROM MODE (INT_CG_MODE), character codes 00h - 7Fh represent the
    '*   pre-defined "internal" CG ROM characters, and codes 80h - FFh represent the
    '*   users own "external" characters. In external CG ROM MODE (EXT_CG_MODE),
    '*   all 256 codes from 00h - FFh can be used to represent the users own characters.
    '***********************************************************************************************
    '

    #define INT_CG_MODE         0x80    '0b10000xxx, Internal CG ROM mode
    #define EXT_CG_MODE         0x88    '0b10001xxx, External CG RAM mode
    #define OR_MODE             0x80    '0b1000x000, OR mode, internal CG ROM mODE
    #define XOR_MODE            0x81    '0b1000x001, XOR mode, internal CG ROM mode
    #define AND_MODE            0x83    '0b1000x011, AND mode, internal CG ROM mode
    #define TEXT_ATTR_MODE      0x84    '0b1000x100, text attribute mode, internal CG ROM mode



    '
    '***********************************************************************************************
    '*                   CURSOR MODE
    '***********************************************************************************************
    '
    #define LINE_8_CURSOR   0xA7    '8-line cursor mode
    #define LINE_7_CURSOR   0xA6  '7-line cursor mode
    #define LINE_6_CURSOR   0xA5  '6-line cursor mode
    #define LINE_5_CURSOR   0xA4  '5-line cursor mode
    #define LINE_4_CURSOR   0xA3  '4-line cursor mode
    #define LINE_3_CURSOR   0xA2  '3-Line cursor mode
    #define LINE_2_CURSOR   0xA1  '2-Line cursor mode
    #define LINE_1_CURSOR   0xA0  '1-Line cursor mode

    '
    '***********************************************************************************************
    '*                 TEXT ATTRIBUTE MODE
    '***********************************************************************************************
    '
    #define ATTR_NORMAL         0x00    'Normal Display
    #define ATTR_REVERSE        0x05    'Reverse Display
    #define ATTR_INHIBIT        0x03    'Inhibit Display
    #define ATTR_BLINK          0x08    'Blinking of Normal Display
    #define ATTR_BLINK_REVERSE  0x0D    'Blinking of Reverse Display
    #define ATTR_BLINK_INHIBIT  0x0B    'Blinking of Inhibit Display


    #define CURSOR_PTR_SET      0x21    'Cursor Pointer Set
    #define OFFSET_REG_SET      0x22    'Set Offset Command
    #define ADDR_PTR_SET        0x24    'Set Address Pointer Command

    #define TEXT_HOME_SET       0x40    'Text Home Address Set: Data = low, high addr
    #define TEXT_AREA_SET       0x41    'Text Area Set: Data = columns, 0
    #define GRAPH_HOME_SET      0x42    'Graphics Home address Set: Data = low, high addr
    #define GRAPH_AREA_SET      0x43    'Graphics Area Set: Data = columns, 0
    #define SCREEN_PEEK         0xE0    'Read data from screen command
    #define SCREEN_COPY         0xE8    'Screen Copy

    #define AUTO_WR_ON          0xB0
    #define DATA_AUTO_RD        0xB1
    #define AUTO_WR_OFF         0xB2

    #define DATA_WR_INC         0xC0    ' Data write and increment addrespointer
    #define DATA_RD_INC         0xC1    ' Data read and increment  addrespointer
    #define DATA_WR_DEC         0xC2    ' Data write and decrement addrespointer
    #define DATA_RD_DEC         0xC3    ' Data read and decrement  addrespointer
    #define DATA_WR             0xC4    ' Data write - no addr change
    #define DATA_RD             0xC5    ' Data read  - no addr change



    #script
        'Adjust the columns to suit the pixel size select
        if GLCD_FS_SELECT = 1 then
            MAX_COLUMNS = MAX_COL_PIXEL / 6
            FontSize_T6963 = 6
        end if
        if GLCD_FS_SELECT = 0 then
            MAX_COLUMNS = MAX_COL_PIXEL / 8
            FontSize_T6963 = 8
        end if
        'set the max rows constant
        MAX_ROWS = MAX_ROW_PIXEL/8


        'Set default screen parameters to TEXT_GRH_ON ( 0x9c ) if not user constant defined
        DefaultDisplayModeFound_T6963 = 0
        if DefaultDisplayMode_T6963 Then
            DefaultDisplayModeInitialState_T6963_script = DefaultDisplayMode_T6963   'equates to user setting
            DefaultDisplayModeFound_T6963 = 1
        end if
        if DefaultDisplayModeFound_T6963 = 0  Then
            DefaultDisplayModeInitialState_T6963_script = 0x9C   'equates to TEXT_GRH_ON
        end if


        'Page - constants avaliable to the user
        LCDPage0_T6963 = TEXT_HOME_ADDR
        LCDPage1_T6963 = LCDPage0_T6963 + INT( COLUMN * 8  )
        LCDPage2_T6963 = LCDPage1_T6963 + INT( COLUMN * 8  )
        LCDPage3_T6963 = LCDPage2_T6963 + INT( COLUMN * 8  )
        LCDPage4_T6963 = LCDPage3_T6963 + INT( COLUMN * 8  )
        LCDPage5_T6963 = LCDPage4_T6963 + INT( COLUMN * 8  )
        LCDPage6_T6963 = LCDPage5_T6963 + INT( COLUMN * 8  )
        LCDPage7_T6963 = LCDPage6_T6963 + INT( COLUMN * 8  )
        LCDPage8_T6963 = LCDPage7_T6963 + INT( COLUMN * 8  )
        LCDPage9_T6963 = LCDPage8_T6963 + INT( COLUMN * 8  )
        LCDPage10_T6963 = LCDPage9_T6963 + INT( COLUMN * 8  )

        GLCDPage0_T6963 = GRH_HOME_ADDR
        GLCDPage1_T6963 = GLCDPage0_T6963 + INT( MAX_COL_PIXEL  * MAX_ROW_PIXEL  )
        GLCDPage2_T6963 = GLCDPage1_T6963 + INT( MAX_COL_PIXEL  * MAX_ROW_PIXEL  )
        GLCDPage3_T6963 = GLCDPage2_T6963 + INT( MAX_COL_PIXEL  * MAX_ROW_PIXEL  )
        GLCDPage4_T6963 = GLCDPage3_T6963 + INT( MAX_COL_PIXEL  * MAX_ROW_PIXEL  )
        GLCDPage5_T6963 = GLCDPage4_T6963 + INT( MAX_COL_PIXEL  * MAX_ROW_PIXEL  )
        GLCDPage6_T6963 = GLCDPage5_T6963 + INT( MAX_COL_PIXEL  * MAX_ROW_PIXEL  )
        GLCDPage7_T6963 = GLCDPage6_T6963 + INT( MAX_COL_PIXEL  * MAX_ROW_PIXEL  )
        GLCDPage8_T6963 = GLCDPage7_T6963 + INT( MAX_COL_PIXEL  * MAX_ROW_PIXEL  )
        GLCDPage9_T6963 = GLCDPage8_T6963 + INT( MAX_COL_PIXEL  * MAX_ROW_PIXEL  )
        GLCDPage10_T6963 = GLCDPage9_T6963 + INT( MAX_COL_PIXEL  * MAX_ROW_PIXEL  )

    #endscript

#startup InitGLCD_T6963

'''Sub to send a value of the byte to speciific LCD screen position
'''@param LCDPutLine value in the Y axis
'''@param LCDPutColumn value in the X axis
Sub PUT_T6963 (In LCDPutLine, In LCDPutColumn, In LCDChar)
          LOCATE LCDPutLine, LCDPutColumn
          GLCDSendData_T6963( LCDChar - 0x20 )        'Adjust standard ASCII to T6963 ASCII
          GLCDSendCommand_T6963(DATA_WR)              'Write data
End Sub_T6963

'''Non-functional - the device does not support BYTE read of a character only bit read of pixel
'''@hide
Function GET_T6963 (LCDPutLine, LCDPutColumn)

End Function

'''Sub to send pointer to the given position
'''@param LCDLine value in the Y axis
'''@param LCDColumn value in the X axis
Sub LOCATE_T6963 (In LCDLine, In LCDColumn)

    dim addr as word

    addr = LCDColumn
    addr_h =  LCDLine
    'Set address pointer
    GLCDCmdAddrSend_T6963(addr,ADDR_PTR_SET)
    GLCDSendCommand_T6963(CURSOR_PTR_SET)

    if LCDLine > MAX_ROWS -1 then
        exit Sub
    end if
    if LCDColumn >  MAX_COLUMNS -1  then
        exit Sub
    end if
    addr = (LCDLine*[word]COLUMN) + [word]LCDColumn + [word]TEXT_HOME_ADDR
    'Set address pointer
    GLCDCmdAddrSend_T6963(addr,ADDR_PTR_SET)

end Sub

'''Sub to clear the LCD screen and send pointer to the home position of 0,0
Sub CLS_T6963

  #if GLCD_TYPE = GLCD_TYPE_T6963

    dim row_T6963, col_T6963 as word

    'Set address pointer to address (TEXT_HOME_ADDR)
    GLCDCmdAddrSend_T6963(TEXT_HOME_ADDR,ADDR_PTR_SET)

    'Set Auto Write ON
    GLCDSendCommand_T6963(AUTO_WR_ON)

    'row runs from 0 ... (MAX_ROW_PIXEL/8 -1), in form of a cell of (FontSize x 8) bits
    for  row_T6963 =  0 to ( MAX_ROW_PIXEL/8 ) -1
        'write blank to clear screen the first page only, col = 0...(COLUMN-1)
        for col_T6963 = 0 to COLUMN - 1

            GLCDispAutoDataWr ( 0 )

        next

    next
    GLCDSendCommand_T6963(AUTO_WR_OFF)
    GLCDCmdAddrSend_T6963(TEXT_HOME_ADDR,ADDR_PTR_SET)
    GLCDSendCommand_T6963(CURSOR_PTR_SET)

  #endif

End Sub

'''Sub to send pointer to the home position of 0,0
Sub LCDHOME_T6963
    GLCDCmdAddrSend_T6963(TEXT_HOME_ADDR,ADDR_PTR_SET)
End Sub

'''Sub to send raw command the the GLCD
'''@param LCDValue value to be sent to the GLCD
Sub LCDcmd_T6963 ( In LCDValue )
        'Send Command.... this is unvalidated.. send whatever is passed!
        GLCDSendCommand_T6963(LCDValue)
end sub

'''Sub to send raw data the the GLCD
'''@param LCDDataByte value to be sent to the GLCD
Sub LCDdata_T6963 ( In LCDDataByte )

    GLCDBusyCheck_T6963

    GLCD_DATA_PORT = LCDDataByte
    wait T6963ClockDelay us
    GLCD_CD = 0
    wait T6963ClockDelay us
    GLCD_WR = 0
    wait T6963ClockDelay us
    GLCD_RD = 1
    wait T6963ClockDelay us
    GLCD_CS = 0
    wait T6963WriteDelay us
    GLCD_CS = 1

end sub

'''Sub to print hex string to the GLCD
'''@param LCDValue decimal number to be shown in hex
'''@param LCDChar optional constant of LeadingZeroActive  to force leading 0 for hex number less that 0x10
sub LCDHex_T6963  (In LCDValue, optional in LCDChar = 1)

    dim HighChar, LowChar as Byte

    'Extract nibbles and convert to ascii values
    HighChar = (LCDValue / 16)  + 48
    LowChar  = (LCDValue and 15) + 48

    'Check for alpha and convert.
    If HighChar > 57 Then HighChar = HighChar + 7
    If LowChar > 57 Then  LowChar = LowChar + 7

    'Write chars to LCD - if user specifies LeadingZeroActive then print the leading char
    IF LCDChar = LeadingZeroActive then
       if LCDValue < 16 then
          Print "0"
       end if
    END IF

    'Write high char if LCDValue is > 15 (DEC)
    IF LCDValue > 15 then Print Chr(HighChar)

    Print Chr(LowChar)

end sub



'''Sub to print a number of spaces - upto COLUMN
'''@param LCDValue number of spaces to send to the GLCD in LCD mode
sub LCDSpace_T6963(in LCDValue)
          if LCDValue > COLUMN then LCDValue = COLUMN
          do until LCDValue = 0
                    Print " "
                    LCDValue --
          loop
end sub


'''Can be LCDON, LCDOFF, CURSORON, CURSOROFF, FLASHON, Or FLASHOFF
'''   1) FLASH is the same as FLASHON and has been retained
'''      for compatibility but should be considererd depricated.
'''
'''   2) ON & OFF Have been superceded with LCDON & LCDOFF for clarity.
'''      However they Will still work as usual. This was done
'''       because LCDCURSOR(OFF | ON) was confusing and implied
'''      control of the cursor instead of the entire display.
'''
'''   3) With this revision, changing one setting does not change the others.
'''      eg.  FlashOFF does turn off the cursor and CURSOROFF does not
'''      turn off Flash. Cursor and flash states are not changed when the
'''      display is turned OFF or ON with LCDCURSOR LCDON OR LCDCURSOR LCDOFF.
'''
'''   4) See Help For New Commands  LCD_OFF and LCD_ON
'''      LCD_ON & LCD OFF are separate Subs that when called
'''      will also turn off the cursor and flash if they are on
'''@param LCDCRSR specified constants.  LCDON, FLASHON etc
'''@param LCDValue optional number lines that make up the cursor.
sub LCDCursor_T6963(In LCDCRSR, optional in line_x_cursor = 1 )

      'for LCDCURSOR Sub
      #define LCDON 4

      #define FLASHON 3
      #define FLASH 3
      #define CursorON 2

      #define FLASHOFF 0xFC   'an AND MASK
      #define CursorOFF 0xFD  'an AND MASK
      #define LCDOFF 0xFB     'an AND MASK

      dim DefaultDisplayModeState_T6963 as byte
      'adjust for line count
      line_x_cursor = line_x_cursor - 1
      'protect if zero is passed as parameter and well as the default
      if line_x_cursor > 8 then
        line_x_cursor = 0
      end if

      If LCDCRSR = ON  Then DefaultDisplayModeState_T6963 = DefaultDisplayModeState_T6963 OR LCDON
      IF LCDCRSR = LCDON Then DefaultDisplayModeState_T6963 = DefaultDisplayModeState_T6963 OR LCDON

      If LCDCRSR = OFF Then DefaultDisplayModeState_T6963 = DefaultDisplayModeState_T6963 AND LCDOFF
      If LCDCRSR = LCDOFF Then DefaultDisplayModeState_T6963 = DefaultDisplayModeState_T6963 AND LCDOFF

      If LCDCRSR = CursorOn Then
          DefaultDisplayModeState_T6963 = DefaultDisplayModeState_T6963 OR CursorON
          GLCDSendCommand_T6963(line_x_cursor)
      end if

      If LCDCRSR = CursorOFF then
          DefaultDisplayModeState_T6963 = DefaultDisplayModeState_T6963 and CursorOFF
          GLCDSendCommand_T6963(LINE_1_CURSOR)
      end if


      If LCDCRSR = FLASH  Then
          DefaultDisplayModeState_T6963 = DefaultDisplayModeState_T6963 OR FLASHON
          line_x_cursor = line_x_cursor or line_1_cursor
          GLCDSendCommand_T6963( line_x_cursor )
      End if

      If LCDCRSR = FLASHOFF then
          DefaultDisplayModeState_T6963 = DefaultDisplayModeState_T6963 and FLASHOFF
          GLCDSendCommand_T6963( line_1_cursor )
      end if

      GLCDSendCommand_T6963(DefaultDisplayModeState_T6963)

end sub

'''Private method
'''Intercepts the standard LCD print routines and routes these standard LCD capabilities to the GLCD
'''@hide
sub LCDNormalWriteByte_T6963 ( In LCDByte )
    GLCDSendData_T6963( LCDByte - 0x20 )      'Adjust standard ASCII to T6963 ASCII
    GLCDSendCommand_T6963(DATA_WR_INC)          'Address pointer increment ON
end sub


'''Initialise the GLCD
'''@hide
Sub InitGLCD_T6963

  'Setup code for T6963 controllers
  #if GLCD_TYPE = GLCD_TYPE_T6963

    dim T6963_GLCD_HEIGHT, T6963_GLCD_WIDTH as word

    'Set pin directions
    dir GLCD_DATA_PORT out
    dir GLCD_CS        out
    dir GLCD_CD        out
    dir GLCD_RD        out
    dir GLCD_WR        out
    dir GLCD_RESET     out
    dir GLCD_FS        out
    'Reset cycle
    GLCD_RESET = 0
    GLCD_CD = 1
    GLCD_CS = 1
    GLCD_RD = 1
    GLCD_WR = 1
    'Set the font control port
    GLCD_FS  = GLCD_FS_SELECT
    GLCD_DATA_PORT = 0
    wait 5 ms
    GLCD_RESET = 1

   'Set Text Home address to TEXT_HOME_ADDR
    GLCDCmdAddrSend_T6963(TEXT_HOME_ADDR,TEXT_HOME_SET)
   'Set Graph Home address to GRH_HOME_ADDR
    GLCDCmdAddrSend_T6963(GRH_HOME_ADDR,GRAPH_HOME_SET)
   'Set Text Area to COLUMN column mode
    GLCDCmdAddrSend_T6963(COLUMN,TEXT_AREA_SET)
   'Set Graph Area to COLUMN column mode
    GLCDCmdAddrSend_T6963(COLUMN,GRAPH_AREA_SET)

   'Set Offset register to 0x0002, CG Ram start address = $1400 (CG_HOME_ADDR)
   'first character code $80 for CG Ram
    GLCDCmdAddrSend_T6963(0x0002,OFFSET_REG_SET)

    'Set the operating mode
    GLCDSendCommand_T6963 ( OR_MODE )
    dim DefaultDisplayModeState_T6963 as byte
    DefaultDisplayModeState_T6963 = DefaultDisplayModeInitialState_T6963_script
    GLCDSendCommand_T6963 ( DefaultDisplayModeState_T6963 )
    GLCDSendCommand_T6963(LINE_1_CURSOR)

    'Colours
    GLCDBackground = 0
    GLCDForeground = 1
    GLCDFontWidth = 5
    GLCDfntDefault = 0
    GLCDfntDefaultsize = 1

    T6963_GLCD_WIDTH = GLCD_WIDTH
    T6963_GLCD_HEIGHT = GLCD_HEIGHT

    GLCDRotate
    'Clear screen
    GLCDCLS
    CLS


  #endif


End Sub


'''Clears the GLCD screen
Sub GLCDCLS_T6963
  ' initialise global variable. Required variable for Circle in all DEVICE DRIVERS- DO NOT DELETE
  GLCD_yordinate = 0

  #if GLCD_TYPE = GLCD_TYPE_T6963
    dim row_T6963, col_T6963 as byte
    'Set address pointer to address (GRH_HOME_ADDR)
    GLCDCmdAddrSend_T6963(GRH_HOME_ADDR, ADDR_PTR_SET)
    'Set Auto Write ON
    GLCDSendCommand_T6963(AUTO_WR_ON)
    'Row runs from 0 ... (MAX_ROW_PIXEL-1), in form of a byte size of (FontSize x 1) bits
    for  row_T6963 =  0 to  MAX_ROW_PIXEL -1
            'write blank to clear screen the first page only, col = 0...(COLUMN-1)
        for col_T6963 = 0 to COLUMN - 1
            GLCDispAutoDataWr ( 0x00 )
        next
    next
    GLCDSendCommand_T6963(AUTO_WR_OFF)
    GLCDCmdAddrSend_T6963(GRH_HOME_ADDR, ADDR_PTR_SET)


  #endif

End Sub



'''Draws a pixel on the GLCD
'''@param GLCDX X coordinate of pixel
'''@param GLCDY Y coordinate of pixel
'''@param GLCDColour State of pixel (0 = background, 1 = foreground )
Sub PSet_T6963(In GLCDX as word, In GLCDY as word, In GLCDColour As Word)

  #if GLCD_TYPE = GLCD_TYPE_T6963

    dim T6963_GLCD_HEIGHT, T6963_GLCD_WIDTH as word

    select case GLCDRotateState
        case PORTRAIT
              'NOT supportED
        case LANDSCAPE
              'default
        case PORTRAIT_REV
              'NOT supportED
        case LANDSCAPE_REV
             GLCDX  = T6963_GLCD_WIDTH - GLCDX - 1
             GLCDY  = T6963_GLCD_HEIGHT - GLCDY - 1
        case else
              'default
    end select


    dim addr as word
    dim cmd as byte


    addr = ( GLCDY  * COLUMN ) + (GLCDX /FontSize_T6963) + GRH_HOME_ADDR
    GLCDCmdAddrSend_T6963(addr, ADDR_PTR_SET)

    if ( GLCDColour = 1 ) then
      cmd = (0b11111000)|(FontSize_T6963- 1 -((GLCDX)%FontSize_T6963))
    else
      cmd = (0b11110000)|(FontSize_T6963- 1 -((GLCDX)%FontSize_T6963))
    end if
    GLCDSendCommand_T6963(cmd)

  #endif

End Sub


'''Rotate the GLCD in terms of the pixels drawn for the GLCD capabilities only
'''@param GLCDRotateState is LANDSCAPE or LANDSCAPE_REV, default is LANDSCAPE)
sub   GLCDRotate_T6963 ( optional in GLCDRotateState as byte = LANDSCAPE  )


  dim T6963_GLCD_HEIGHT, T6963_GLCD_WIDTH as word

  select case GLCDRotateState
        case LANDSCAPE   '0 degree
             T6963_GLCD_WIDTH = GLCD_WIDTH
             T6963_GLCD_HEIGHT = GLCD_HEIGHT
        case Portrait
             T6963_GLCD_WIDTH = GLCD_HEIGHT
             T6963_GLCD_HEIGHT = GLCD_WIDTH
        case LANDSCAPE_REV
             T6963_GLCD_WIDTH = GLCD_WIDTH
             T6963_GLCD_HEIGHT = GLCD_HEIGHT
        case PORTRAIT_REV
             T6963_GLCD_WIDTH = GLCD_HEIGHT
             T6963_GLCD_HEIGHT = GLCD_WIDTH
        case else
             T6963_GLCD_WIDTH = GLCD_WIDTH
             T6963_GLCD_HEIGHT = GLCD_HEIGHT
  end select

end sub


'''Draws a filled box on the GLCD screen
'''@param LineX1 Top left corner X location
'''@param LineY1 Top left corner Y location
'''@param LineX2 Bottom right corner X location
'''@param LineY2 Bottom right corner Y location
'''@param LineColour Colour of box (0 = erase, 1 = draw, default is 1)
Sub FilledBox_T6963(In LineX1 as word, In LineY1 as word, In LineX2 as word, In LineY2 as word, Optional In LineColour As Word = GLCDForeground)
  dim GLCDTemp, DrawLine as word
  'Make sure that starting point (1) is always less than end point (2)
  If LineX1 > LineX2 Then
    GLCDTemp = LineX1
    LineX1 = LineX2
    LineX2 = GLCDTemp
  End If
  If LineY1 > LineY2 Then
    GLCDTemp = LineY1
    LineY1 = LineY2
    LineY2 = GLCDTemp
  End If


  'Fill with colour
  'Draw lines going across
  For DrawLine = LineX1 To LineX2
    For GLCDTemp = LineY1 To LineY2
      PSet DrawLine, GLCDTemp, LineColour
    Next
  Next

End Sub


'''Sends a data word and command byte  to the GLCD
'''@param LCDDataWord  the value of the data to be sent
'''@param LCDCmdBytethe value of the data to be sent
sub GLCDCmdAddrSend_T6963 ( in LCDDataWord as word, In LCDCmdByte )

  GLCDSendData_T6963 ( LCDDataWord )
  GLCDSendData_T6963 ( LCDDataWord_h )
  GLCDSendCommand_T6963 ( LCDCmdByte )

end sub

'''Sends a command byte  to the GLCD
'''@param LCDCmdByte the value of the command to be sent
Sub GLCDSendCommand_T6963 ( In LCDCmdByte )

    GLCDBusyCheck_T6963

    GLCD_DATA_PORT = LCDCmdByte
    wait T6963ClockDelay us
    GLCD_CD = 1
    wait T6963ClockDelay us
    GLCD_WR = 0
    wait T6963ClockDelay us
    GLCD_RD = 1
    wait T6963ClockDelay us

    GLCD_CS = 0
    wait T6963WriteDelay us
    GLCD_CS = 1

End Sub


'''Sends a data byte in automatic increment mode to the GLCD
'''@param LCDDataByte the value of the data to be sent
Sub GLCDispAutoDataWr   ( In LCDDataByte )

    GLCDispAutoWrChk_T6963

    GLCD_DATA_PORT = LCDDataByte
    wait T6963ClockDelay us
    GLCD_CD = 0
    wait T6963ClockDelay us
    GLCD_WR = 0
    wait T6963ClockDelay us
    GLCD_RD = 1
    wait T6963ClockDelay us

    GLCD_CS = 0
    wait T6963WriteDelay us
    GLCD_CS = 1

End Sub

'''Sends a data byte to the GLCD
'''@param LCDDataByte the value of the data to be sent
Sub GLCDSendData_T6963 ( In LCDDataByte )

    GLCDBusyCheck_T6963

    GLCD_DATA_PORT = LCDDataByte
    wait T6963ClockDelay us
    GLCD_CD = 0
    wait T6963ClockDelay us
    GLCD_WR = 0
    wait T6963ClockDelay us
    GLCD_RD = 1
    wait T6963ClockDelay us
    GLCD_CS = 0
    wait T6963WriteDelay us
    GLCD_CS = 1

End Sub

'''Inspect the status of the autowrite. Has the last byte been written?
Sub GLCDBusyCheck_T6963

    dir GLCD_DATA_PORT in

    GLCD_CD = 1
    wait T6963ClockDelay us
    GLCD_WR = 1
    wait T6963ClockDelay us
    GLCD_RD = 0
    wait T6963ClockDelay us

    GLCD_CS = 0
    wait T6963ClockDelay us
    wait while (!STA0)  'Busy Check here
    wait T6963ClockDelay us
    wait while (!STA1)
    GLCD_CS = 1
    dir GLCD_DATA_PORT out

End Sub


'''Inspect the status of the autowrite. Has the last byte been written?
Sub GLCDispAutoWrChk_T6963

    dir GLCD_DATA_PORT in

    GLCD_CD = 1
    wait T6963ClockDelay us
    GLCD_WR = 1
    wait T6963ClockDelay us
    GLCD_RD = 0
    wait T6963ClockDelay us
    GLCD_CS = 0
    wait T6963ClockDelay us
    wait while (!STA3)  'Busy Check here
    GLCD_CS = 1
    dir GLCD_DATA_PORT out

End Sub


