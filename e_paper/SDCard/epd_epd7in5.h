'    Graphical LCD routines for the GCBASIC compiler
'    Copyright (C) 2019 Giuseppe D'Elia and Evan Venn

'    This library is free software; you can redistribute it and/or
'    modify it under the terms of the GNU Lesser General Public
'    License as published by the Free Software Foundation; either
'    version 2.1 of the License, or (at your option) any later version.

'    This library is distributed in the hope that it will be useful,
'    but WITHOUT ANY WARRANTY; without even the implied warranty of
'    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
'    Lesser General Public License for more details.

'    You should have received a copy of the GNU Lesser General Public
'    License along with this library; if not, write to the Free Software
'    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA



'  Initial release
'  Added _GLCDPagesH and _GLCDPagesL as defined variables
'  Added PrintLocY adaption Close_PageTransaction
'  Revised by Evan for performance and post testing changes.
'  Revised again by Evan for performance
'  Added ROTATE



'''Draws a string at the specified location on theE-Paper
'''@param StringLocX X coordinate for message
'''@param CharLocY Y coordinate for message
'''@param Chars String to display
'''@param LineColour Line Color, either 1 or 0


    'EPD Commands


   #define PANEL_SETTING                               0x00
   #define POWER_SETTING                               0x01
   #define POWER_OFF                                   0x02
   #define POWER_OFF_SEQUENCE_SETTING                  0x03
   #define POWER_ON                                    0x04
   #define POWER_ON_MEASURE                            0x05
   #define BOOSTER_SOFT_START                          0x06
   #define DEEP_SLEEP                                  0x07
   #define DATA_START_TRANSMISSION_1                   0x10
   #define DATA_STOP                                   0x11
   #define DISPLAY_REFRESH                             0x12
   #define DATA_START_TRANSMISSION_2                   0x13
   #define VCOM_LUT                                    0x20
   #define W2W_LUT                                     0x21
   #define B2W_LUT                                     0x22
   #define W2B_LUT                                     0x23
   #define B2B_LUT                                     0x24
   #define PLL_CONTROL                                 0x30
   #define TEMPERATURE_SENSOR_CALIBRATION              0x40
   #define TEMPERATURE_SENSOR_SELECTION                0x41
   #define TEMPERATURE_SENSOR_WRITE                    0x42
   #define TEMPERATURE_SENSOR_READ                     0x43
   #define VCOM_AND_DATA_INTERVAL_SETTING              0x50
   #define LOW_POWER_DETECTION                         0x51
   #define TCON_SETTING                                0x60
   #define RESOLUTION_SETTING                          0x61
   #define GET_STATUS                                  0x71
   #define AUTO_MEASURE_VCOM                           0x80
   #define READ_VCOM_VALUE                             0x81
   #define VCM_DC_SETTING                              0x82
   #define PARTIAL_WINDOW                              0x90
   #define PARTIAL_IN                                  0x91
   #define PARTIAL_OUT                                 0x92
   #define PROGRAM_MODE                                0xA0
   #define ACTIVE_PROGRAM                              0xA1
   #define READ_OTP_DATA                               0xA2
   #define POWER_SAVING                                0xE3


    'Pin mappings
    #define EPD_DC GLCD_DC
    #define EPD_CS GLCD_CS
    #define EPD_RESET GLCD_RESET
    #define EPD_DO GLCD_DO
    #define EPD_SCK GLCD_SCK
    #define EPD_BUSY GLCD_BUSY

'_________________________________________________________________
'


Dim EPD_Buffer(BUFFWIDTH)
dim EPD7in5AddressType as byte

#script
    EPD7in5VERSION=16
#endscript


#startup Init_EPD7in5, 99

sub Init_EPD7in5

    #if GLCD_TYPE = GLCD_TYPE_EPD_EPD7in5

        dim _GLCDPagesL, _GLCDPagesH  as byte

        asm showdebug Current_buffer_size_is BUFFWIDTH
        Dir   EPD_DC     OUT
        Dir   EPD_CS     OUT
        Dir   EPD_RESET  OUT
        Dir   EPD_DO     OUT
        Dir   EPD_SCK    OUT
        Dir   EPD_Busy   IN

        #ifdef EPD_HardwareSPI
          ' harware SPI mode
           asm showdebug SPI constant used equates to HWSPIMODESCRIPT
           SPIMode HWSPIMODESCRIPT, 0
        #endif

        'Colours
        GLCDForeground = TFT_BLACK
        'Default Colours
        #ifdef DEFAULT_GLCDBACKGROUND
          GLCDBackground = DEFAULT_GLCDBACKGROUND
        #endif
        #ifndef DEFAULT_GLCDBACKGROUND
          GLCDBackground = TFT_WHITE
        #endif

        #ifndef GLCD_OLED_FONT
          GLCDFontWidth = 6
        #endif

        #ifdef GLCD_OLED_FONT
          GLCDFontWidth = 5
        #endif

        Display_EPD7in5 ( On )


        'Variables required for device
        GLCDDeviceWidth = GLCD_WIDTH - 1
        GLCDDeviceHeight= GLCD_HEIGHT- 1
        GLCDRotate Landscape

        CLS_EPD7in5

        GLCDfntDefault = 0
        GLCDfntDefaultsize = 1
        GLCDfntDefaultHeight = 8

        asm showdebug EPD_N_PAGE
        _GLCDPagesH = EPD_N_PAGE - 1
        _GLCDPagesL = 0
        _GLCDPage = 0

    #endif


end sub



sub CLS_EPD7in5_init ( Optional In  GLCDBackground as word = GLCDBackground)

  'initialise global variable. Required variable for Circle - DO NOT DELETE
      GLCD_yordinate = 0

      Dim EPD_Ind_raw, EPD_Ind_col as word

      Dim PrintLocX, PrintLocY as word
      PrintLocX = 0
      PrintLocY = 0

      For EPD_Ind_raw=1 to BUFFWIDTH
          EPD_Buffer(EPD_Ind_raw)=GLCDBackground
      next

      'Clear data
      SendCommand_EPD7in5(DATA_START_TRANSMISSION_1)

      SET EPD_CS OFF
      SET EPD_DC ON
      for EPD_Ind_raw=1 to GLCD_Height
        for EPD_Ind_col=1 to GLCD_Width
          'Was.. speed optimised with macro
          Repeat 4
              if GLCDBackground = TFT_BLACK then
                  EPD7in5_Data = TFT_BLACK
              else
                  EPD7in5_Data = EPD_WHITE
              end if
              SendData_EPD7in5_Macro
          End Repeat
        next
      next
      SET EPD_CS ON

end sub


sub CLS_EPD7in5 ( Optional In  GLCDBackground as word = GLCDBackground)

      'added CLS_EPD7in5_init to optimise start up process.
      CLS_EPD7in5_init

      Refresh_EPD7in5

      'No need to call this as it faster to put in GLCDCLS. Keep the method if some one needs it
      'Clear_buffer_EPD7in5

end sub




sub   Pixel_To_Display_EPD7in5

    Dim EPD_Ind_raw, EPD_Ind_col as Word

    if _GLCDPage = 0 then

      ' Not required  is a POWERON or REFRESH at this part of the process

      'Commence data stream
      SendCommand_EPD7in5(DATA_START_TRANSMISSION_1)

    end if

    dim EPD7in5_Data as byte

    'We need to set the signals as we are optimising the code by using the macro
    SET EPD_CS OFF
    SET EPD_DC ON
    for EPD_Ind_raw=1 to BUFFWIDTH
       'replaced with macro for speed


        dim EPD7in5_Data_Black as byte
        EPD7in5_Data_Black = EPD_Buffer(EPD_Ind_raw)

        'Send the buffer data to the display
        repeat 4

            if EPD7in5_Data_Black.7 = 0 then
                EPD7in5_Data  = 0x00
            else
                EPD7in5_Data  = 0x03
            end if

'            EPD7in5_Data = EPD7in5_Data * 16
            repeat 4
              Set C Off
              rotate EPD7in5_Data left
            end Repeat

'            EPD7in5_Data_Black = EPD7in5_Data_Black * 2
            repeat 1
              Set C Off
              rotate EPD7in5_Data_Black left
            end Repeat

            if EPD7in5_Data_Black.7 = 0 then
                EPD7in5_Data  = EPD7in5_Data OR 0x00
            else
                EPD7in5_Data  = EPD7in5_Data OR 0x03
            end if

'            EPD7in5_Data_Black = EPD7in5_Data_Black * 2
            repeat 1
              Set C Off
              rotate EPD7in5_Data_Black left
            end Repeat
            'This macro assumes the use of the variable EPD7in5_Data
             SendData_EPD7in5_Macro

        end Repeat

       'Now clear the buffer
        EPD_Buffer(EPD_Ind_raw) = GLCDBackground

    next
    SET EPD_CS ON

end sub

sub Clear_buffer_EPD7in5
    Dim EPD_Ind_raw as Word

    for EPD_Ind_raw=1 to BUFFWIDTH                 'clear the buffer
      EPD_Buffer(EPD_Ind_raw)=GLCDBackground
    next

end sub

sub Refresh_EPD7in5
'Not required as this process has already happenend from INIT
    'LoadLUTS_EPD7in5

    SendCommand_EPD7in5(DISPLAY_REFRESH)
    do while EPD_Busy=Off
      wait 10 ms
    loop

end sub

sub Display_EPD7in5( Optional In EPD7in5_Command as Byte = Off )

  Dir   EPD_DC     OUT
  Dir   EPD_CS     OUT
  Dir   EPD_RESET  OUT
  Dir   EPD_DO     OUT
  Dir   EPD_SCK    OUT
  Dir   EPD_Busy   IN


  if EPD7in5_Command = on then

      SET EPD_RESET ON
      wait 200 ms
      SET EPD_RESET OFF
      wait 300 ms
      SET EPD_RESET ON
      wait 300 ms

      SendCommand_EPD7in5(0x04)
      do while EPD_Busy=Off
        wait 10 ms
      loop

      SendCommand_EPD7in5(0x01)
      SendData_EPD7in5(0x37)
      SendData_EPD7in5(0x00)

      SendCommand_EPD7in5(0x00)
      SendData_EPD7in5(0xCF)
      SendData_EPD7in5(0x08)

      SendCommand_EPD7in5(0x06)
      SendData_EPD7in5(0xC7)
      SendData_EPD7in5(0xcc)
      SendData_EPD7in5(0x28)

      SendCommand_EPD7in5(0x04)
      do while EPD_Busy=Off
        wait 10 ms
      loop


      SendCommand_EPD7in5(0x30)
      SendData_EPD7in5(0x3C)

      SendCommand_EPD7in5(0x41)
      SendData_EPD7in5(0x00)

      SendCommand_EPD7in5(0x50)
      SendData_EPD7in5(0x77)

      SendCommand_EPD7in5(0x60)
      SendData_EPD7in5(0x22)

      SendCommand_EPD7in5(0x61)
      SendData_EPD7in5(0x02)
      SendData_EPD7in5(0x80)
      SendData_EPD7in5(0x01)
      SendData_EPD7in5(0x80)


      SendCommand_EPD7in5(0x82)
      SendData_EPD7in5(0x1E)


      SendCommand_EPD7in5(0xE5)
      SendData_EPD7in5(0x03)


' May not be required, improves start up by having it removed
'      SendCommand_EPD7in5(0x12)
'      do while EPD_Busy=Off
'        wait 10 ms
'      loop


  else

      SendCommand_EPD7in5(POWER_OFF_SEQUENCE_SETTING)
      do while EPD_Busy=Off
        wait 10 ms
      loop
      SendCommand_EPD7in5(DEEP_SLEEP)
      SendData_EPD7in5(0xA5)

  end if
end sub

sub SendCommand_EPD7in5(in EPD7in5_Command as Byte)

    SET EPD_CS OFF
    SET EPD_DC OFF
    #ifdef EPD_HardwareSPI
      FastHWSPITransfer EPD7in5_Command
      SET EPD_CS ON
      Exit sub
    #endif

    #ifndef EPD_HardwareSPI
      REPEAT 8

        IF EPD7in5_Command.7 = ON THEN
          Set EPD_DO ON
        ELSE
          Set EPD_DO OFF
        END IF
        SET EPD_SCK On

        Rotate EPD7in5_Command left
        Set EPD_SCK Off

      END REPEAT
      Set EPD_CS ON

    #endif

end sub

sub SendData_EPD7in5(in EPD7in5_Data as Byte)

    SET EPD_CS OFF
    SET EPD_DC ON
    SendData_EPD7in5_Macro
    SET EPD_CS ON

end sub


'This assumes variable EPD7in5_Data
macro SendData_EPD7in5_Macro

        #ifdef EPD_HardwareSPI
          FastHWSPITransfer EPD7in5_Data
        #endif

        #ifndef EPD_HardwareSPI
          REPEAT 8
            IF EPD7in5_Data.7 = ON THEN
              Set EPD_DO ON
            ELSE
              Set EPD_DO OFF
            END IF
            SET EPD_SCK On
            Rotate EPD7in5_Data left
            Set EPD_SCK Off
          END REPEAT
        #endif

End Macro

Sub DrawString_EPD7in5( In StringLocX as word, In CharLocY as word, In Chars as string, Optional In LineColour as word = GLCDForeground )

  dim GLCDPrintLoc as word

    GLCDPrintLoc = StringLocX

  #ifdef GLCD_OLED_FONT
      dim OldGLCDFontWidth as Byte
      OldGLCDFontWidth = GLCDFontWidth
  #endif

  for xchar = 1 to Chars(0)
      GLCDDrawChar GLCDPrintLoc , CharLocY , Chars(xchar), LineColour
      GLCDPrintIncrementPixelPositionMacro
  next

  #ifdef GLCD_OLED_FONT
      GLCDFontWidth = OldGLCDFontWidth
  #endif


end sub

'''Draws a character at the specified location on the ST7920 GLCD
'''@param StringLocX X coordinate for message
'''@param CharLocY Y coordinate for message
'''@param Chars String to display
'''@param LineColour Line Color, either 1 or 0
Sub DrawChar_EPD7in5(In CharLocX as word, In CharLocY as word, In CharCode, Optional In LineColour as word = GLCDForeground )

  dim oldGLCDBackground, oldGLCDForeground, LineColourToggled as bit

  'This has got a tad complex
  'We have three major pieces
  '1 The preamble - this just adjusted color and the input character
  '2 The code that deals with GCB fontset
  '3 The code that deals with OLED fontset
  '
  'You can make independent change to section 2 and 3 but they are mutual exclusive with many common pieces


    'invert colors if required
    if LineColour <> GLCDForeground  then
      'Inverted Colours
      oldGLCDBackground = GLCDBackground
      oldGLCDForeground = GLCDForeground
      GLCDForeground = LineColour
      GLCDBackground = oldGLCDForeground
      LineColourToggled = 1
    else
      LineColourToggled = 0
    end if

   dim CharCol, CharRow, GLCDTemp as word
   CharCode -= 15
  'CharCode needs to have 15 subtracted, table starts at char 16 not char 0

   CharCol=0
   #ifndef GLCD_OLED_FONT

        if CharCode>=178 and CharCode<=202 then
           CharLocY=CharLocY-1
        end if

        For CurrCharCol = 1 to 5
          Select Case CurrCharCol
            Case 1: ReadTable GLCDCharCol3, CharCode, CurrCharVal
            Case 2: ReadTable GLCDCharCol4, CharCode, CurrCharVal
            Case 3: ReadTable GLCDCharCol5, CharCode, CurrCharVal
            Case 4: ReadTable GLCDCharCol6, CharCode, CurrCharVal
            Case 5: ReadTable GLCDCharCol7, CharCode, CurrCharVal
          End Select
          CharRow=0
          For CurrCharRow = 1 to 8
              CharColS=0
              For Col=1 to GLCDfntDefaultsize
                    CharColS +=1
                    CharRowS=0
                    For Row=1 to GLCDfntDefaultsize
                        CharRowS +=1
                        if CurrCharVal.0=1 then
                           PSet([word]CharLocX + CharCol+ CharColS, [word]CharLocY + CharRow+CharRowS, LineColour)
                        Else
                           PSet([word]CharLocX + CharCol+ CharColS, [word]CharLocY + CharRow+CharRowS, GLCDBACKGROUND)
                        End if
                    Next Row
              Next Col
            Rotate CurrCharVal Right
            CharRow +=GLCDfntDefaultsize
          Next
          CharCol +=GLCDfntDefaultsize
        Next

    #endif

    #ifdef GLCD_OLED_FONT

        'Calculate the pointer to the OLED fonts.
        'These fonts are not multiple tables one is a straight list the other is a lookup table with data.
        Dim LocalCharCode as word

        'Get key information and set up the fonts parameters
        Select case GLCDfntDefaultSize
            case 1 'This font is two font tables of an index and data
              CharCode = CharCode - 16
              ReadTable OLEDFont1Index, CharCode, LocalCharCode
              ReadTable OLEDFont1Data, LocalCharCode , COLSperfont
              GLCDFontWidth = COLSperfont + 1
              ROWSperfont = 7  'which is really 8 as we start at 0

            case 2 'This is one font table
              CharCode = CharCode - 17
              'Pointer to table of font elements
              LocalCharCode = (CharCode * 20)
              COLSperfont = 9  'which is really 10 as we start at 0

              ROWSperfont=15  'which is really 16 as we start at 0

        End Select


        'The main loop - loop throught the number of columns
        For CurrCharCol = 0 to COLSperfont  'number of columns in the font , with two row of data

          'Index the pointer to the code that we are looking for as we need to do this lookup many times getting more font data
          LocalCharCode++
          Select case GLCDfntDefaultSize
              case 1
                ReadTable OLEDFont1Data, LocalCharCode, CurrCharVal

              case 2
                #ifndef GLCD_Disable_OLED_FONT2
                  'Read this 20 times... (0..COLSperfont) [ * 2 ]
                  ReadTable OLEDFont2, LocalCharCode, CurrCharVal
                #endif
                #ifdef GLCD_Disable_OLED_FONT2
                  CurrCharVal = GLCDBACKGROUND
                #endif
          End Select

            'we handle 8 or 16 pixels of height
            For CurrCharRow = 0 to ROWSperfont
                'Set the pixel
                If CurrCharVal.0 = 0 Then
                          PSet CharLocX + CurrCharCol, CharLocY + CurrCharRow, GLCDBACKGROUND
                Else
                          PSet CharLocX + CurrCharCol, CharLocY + CurrCharRow, LineColour
                End If

                Rotate CurrCharVal Right

                'Set to next row of date, a second row
                if GLCDfntDefaultSize = 2 and CurrCharRow = 7 then
                  LocalCharCode++
                  #ifndef GLCD_Disable_OLED_FONT2
                    ReadTable OLEDFont2, LocalCharCode, CurrCharVal
                  #endif
                  #ifdef GLCD_Disable_OLED_FONT2
                    CurrCharVal = GLCDBACKGROUND
                  #endif
                end if

                'It is the intercharacter space, put out one pixel row
                if CurrCharCol = COLSperfont then
                    'Put out a white intercharacter pixel/space
                     GLCDTemp = CharLocX + CurrCharCol
                     if GLCDfntDefaultSize = 2 then
                        GLCDTemp++
                     end if
                     PSet GLCDTemp , CharLocY + CurrCharRow, GLCDBACKGROUND
                end if

            Next



        Next


    #endif

    'invert colors if required
    if LineColourToggled = 1  then
      GLCDForeground = oldGLCDForeground
      GLCDBackground = oldGLCDBackground
    end if

End Sub

'''Draws a pixel on the GLCD
'''@param GLCDX X coordinate of pixel
'''@param GLCDY Y coordinate of pixel
'''@param GLCDColour State of pixel
Sub PSet_EPD7in5(In GLCDX as word, In GLCDY as word, In GLCDColour As Word)

  Dim EPD_Ind, EPD_N_Col, EPD_N_raw, EPD_Ind_Trans as long
  Dim remainder as long
  Dim DataVar as long
  Dim value as bit
  Dim GLCD_Time_Buff as long
  Dim GLCDDataTemp as long


    Select Case EPD7in5AddressType

      case Landscape

          'Reject if not on page
          if  (GLCDY / EPD_PIXELS_PER_PAGE) <> _GLCDPage then
              exit sub
          end if

      case Landscape_Rev
          'Reject if not on page
          if  (GLCDY / EPD_PIXELS_PER_PAGE) <> EPD_N_PAGE - _GLCDPage - 1 then
              exit sub
          end if

          GLCDY = GLCD_HEIGHT - GLCDY - 1
          GLCDX = GLCD_WIDTH - GLCDX - 1

      case Portrait
          'Reject if not on page
          if  (GLCDX / EPD_PIXELS_PER_PAGE) <> EPD_N_PAGE - _GLCDPage - 1  then
              exit sub
          end if

          GLCDDataTemp = GLCDX
          GLCDX = GLCDY
          GLCDY = GLCD_HEIGHT - GLCDDataTemp - 1

      case Portrait_Rev
          'Reject if not on page
          if  (GLCDX / EPD_PIXELS_PER_PAGE) <> _GLCDPage then
              exit sub
          end if

          GLCDDataTemp = GLCDX
          GLCDX = GLCD_WIDTH  - GLCDY - 1
          GLCDY = GLCDDataTemp

    end select


    #IFDEF GLCD_PROTECTOVERRUN
        'anything off screen with be rejected
        if GLCDX > GLCDDeviceWidth OR GLCDY > GLCDDeviceHeight Then
            exit sub
        end if

    #ENDIF

'    EPD_N_Col=(GLCDX+1)/8                   'number of the column of the byte to be set
    EPD_N_Col=(GLCDX+1)
    Repeat 3
      Set C Off
      Rotate EPD_N_Col Right
    End Repeat

    remainder=(GLCDX+1) % 8

    EPD_N_raw=[WORD]GLCDY * [WORD]GLCD_Width8       'number of the column of the byte to be set

    if remainder=0 then
      EPD_Ind=EPD_N_raw+EPD_N_Col
    else
      EPD_Ind=EPD_N_raw+EPD_N_Col+1       'Number of the byte to be set (starting from 1)
    end if
    GLCD_Time_Buff=_GLCDPage*BUFFWIDTH
    EPD_Ind_Trans=EPD_Ind
    EPD_Ind_Trans=EPD_Ind_Trans-GLCD_Time_Buff

    if EPD_Ind_Trans>BUFFWIDTH then       'NOTE:it should be a control also for a
      EXIT SUB                            'lower bound of ind (ind>GLCD_Time_Buff)
    end if                                'However when the lower bound is violated,

    DataVar=EPD_Buffer(EPD_Ind_Trans)     'Ind_Trans should be negative and, due to

    Select Case remainder                 'non signed arithmetic, it will be very
    case 0                                'large, thus Exits sub is executed.
      DataVar.0=GLCDColour.0
    case 1
      DataVar.7=GLCDColour.0
    case 2
      DataVar.6=GLCDColour.0
    case 3
      DataVar.5=GLCDColour.0
    case 4
      DataVar.4=GLCDColour.0
    case 5
      DataVar.3=GLCDColour.0
    case 6
      DataVar.2=GLCDColour.0
    case 7
      DataVar.1=GLCDColour.0
    End Select
    EPD_Buffer(EPD_Ind_Trans)=DataVar

End Sub

'''Draws a filled box on the GLCD screen
'''@param LineX1 Top left corner X location
'''@param LineY1 Top left corner Y location
'''@param LineX2 Bottom right corner X location
'''@param LineY2 Bottom right corner Y location
'''@param LineColour Colour of box (0 = erase, 1 = draw, default is 1)
Sub FilledBox_EPD7in5(In LineX1 as word, In LineY1 as word, In LineX2 as word, In LineY2 as word, Optional In LineColour As Word = GLCDForeground)
  'Make sure that starting point (1) is always less than end point (2)

  Dim EPD_Ind_raw, EPD_Ind_col as Word

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

  for EPD_Ind_raw=LineY1  to LineY2
    for EPD_Ind_col=LineX1 to lineX2
      PSet_EPD7in5(EPD_Ind_Col, EPD_Ind_raw, LineColour)
    next
  next
End Sub






Sub Rotate_EPD7in5( in EPD7in5AddressType as byte )

  'Reset PrintLocY
  PrintLocY = 0

  select case EPD7in5AddressType
        case PORTRAIT

              GLCDDeviceWidth = GLCD_HEIGHT - 1
              GLCDDeviceHeight  = GLCD_WIDTH - 1

        case LANDSCAPE

              GLCDDeviceHeight = GLCD_HEIGHT - 1
              GLCDDeviceWidth  = GLCD_WIDTH - 1

        case PORTRAIT_REV

              GLCDDeviceWidth = GLCD_HEIGHT - 1
              GLCDDeviceHeight  = GLCD_WIDTH - 1

        case LANDSCAPE_REV

              GLCDDeviceHeight = GLCD_HEIGHT - 1
              GLCDDeviceWidth  = GLCD_WIDTH - 1

        case else

              EPD7in5AddressType = 1
              GLCDDeviceHeight = GLCD_HEIGHT - 1
              GLCDDeviceWidth  = GLCD_WIDTH - 1

  end select

end sub



'Macro GLCD_Open_PageTransaction_EPD7in5 ( Optional In _GLCDPagesL As byte = 0 , Optional In _GLCDPagesH As byte = 7 )
Macro GLCD_Open_PageTransaction_EPD7in5 ( Optional In _GLCDPagesL As byte = 0 , Optional In _GLCDPagesH As byte = EPD_N_PAGE - 1 )

      dim _GLCDPage as byte
      dim _GLCDPagesL, _GLCDPagesH as byte

      Clear_buffer_EPD7in5

      if _GLCDPagesL > 0 then
          for _GLCDPage = 0 to _GLCDPagesL-1
              Pixel_To_Display_EPD7in5
          next
      end if

      for _GLCDPage = _GLCDPagesL to _GLCDPagesH    '_GLCDPage is a global variable - DO NOT CHANGE!!!

          if  _GLCDPage => _GLCDPagesL and _GLCDPage <= _GLCDPagesH then

              GLCDLocateString 0,0

end Macro

Macro  GLCD_Close_PageTransaction_EPD7in5

          end if

          Pixel_To_Display_EPD7in5

      next

      if _GLCDPage < (EPD_N_PAGE - 1) then
          dim _GLCDPagesH as byte
          for _GLCDPage = _GLCDPage + 1 to (EPD_N_PAGE - 1)
              Pixel_To_Display_EPD7in5
          next
      end if
      SendCommand_EPD2in13D(DISPLAY_REFRESH)

End Macro


'______________________________________________________________
'______________________________________________________________

    Table Lut_Vcom as Byte
        0x00, 0x08, 0x00, 0x00, 0x00, 0x02
        0x60, 0x28, 0x28, 0x00, 0x00, 0x01
        0x00, 0x14, 0x00, 0x00, 0x00, 0x01
        0x00, 0x12, 0x12, 0x00, 0x00, 0x01
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        0x00, 0x00
    End Table
    Table Lut_WW as Byte
        0x40, 0x08, 0x00, 0x00, 0x00, 0x02
        0x90, 0x28, 0x28, 0x00, 0x00, 0x01
        0x40, 0x14, 0x00, 0x00, 0x00, 0x01
        0xA0, 0x12, 0x12, 0x00, 0x00, 0x01
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    End Table
    Table Lut_BW as Byte
        0x40, 0x17, 0x00, 0x00, 0x00, 0x02
        0x90, 0x0F, 0x0F, 0x00, 0x00, 0x03
        0x40, 0x0A, 0x01, 0x00, 0x00, 0x01
        0xA0, 0x0E, 0x0E, 0x00, 0x00, 0x02
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    End Table
    Table Lut_WB as Byte
        0x80, 0x08, 0x00, 0x00, 0x00, 0x02
        0x90, 0x28, 0x28, 0x00, 0x00, 0x01
        0x80, 0x14, 0x00, 0x00, 0x00, 0x01
        0x50, 0x12, 0x12, 0x00, 0x00, 0x01
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    End table
    Table Lut_BB as Byte
        0x80, 0x08, 0x00, 0x00, 0x00, 0x02
        0x90, 0x28, 0x28, 0x00, 0x00, 0x01
        0x80, 0x14, 0x00, 0x00, 0x00, 0x01
        0x50, 0x12, 0x12, 0x00, 0x00, 0x01
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    End Table
'______________________________________________________________
'______________________________________________________________
