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
'  Removed Script to glcd.h - need to isolate else as expanding across the range the scripts start to clash
'  Fixed GLCDCLS
'  Added documentation



' Introduction
'
'  The e-paper device is a Microencapsulated Electrophoretic Display, MED.
'  A MED display uses tiny spheres, in which the charged color pigments are suspending in the transparent oil and would move depending on the electronic charge.
'  The e-paper screen display patterns by reflecting the ambient light, so it has no background light requirement.
'  Under sunshine, the e-paper screen still has high visibility with a wide viewing angle of 180 degree.  It is the ideal choice for e-reading.
'
'
' Constraints and usage
'
' This library does not support Partial/Windows operation.  The LUTS tables and the assiocated method is not included.
'
' This is specific to the EPD2in13D device.  See https://www.waveshare.com/w/upload/5/5b/2.13inch_e-Paper_%28D%29_Datasheet.pdf
'
' Refresh mode
'
'   This library uses Full refresh: The e-Paper will flicker when full refreshing.  This flicker removes the ghost image from the display.
'   You could use Partial refresh as this does  not flicker.   Note that you cannot use Partial refresh all the time, you should full refresh e-paper regularly, otherwise, the ghost problem will get worse and even damage the display.
'
' Refresh rate
'   When using, you should set the update interval at least 180seconds, except when using Partial mode.
'   Please set the e-Paper to sleep mode in software or remove the power directly, otherwise, the e-Paper will be damaged because of working in high voltage for extended  time periods.
'   You need to update the content of the e-Paper at least once every 24h to avoid from burn-in problem.
'
' Operating Voltages
'
'   The e-Paper should be driven with 3V3 operating voltages and signals.
'   If your Microcontroller (PIC, AVR and therefore an Arduino)  cannot drive the e-Paper successfully. You must convert the level to 3.3V
'   The I/O level of Arduino is 5V.   HEALTH WARNING:  You can also try to connect the Vcc pin to the 5V of Arduino to see whether the e-Paper works, but we recommend you not to use 5V for a long time.
'
' The e-Paper look a little black or grey
'
'   You can try to change the value of Vcom the library by setting the VCOM_AND_DATA_INTERVAL constant.  See table 'CDI[3:0]' Vcom and data interval in the dataheet.
'   VCOM_AND_DATA_INTERVAL can be 0x00 to 0x0F
'
' The e-Paper support Black/White and  Black/White/Red
'
'  The default is Black/White. To support Black/White/Red add `#define PANEL_SETTING_KWR 0x00`  to you user program.
'  The constant can be 0x00 for Black/White/Red. Default is 0x10 for Black/White.
'
' The e-paper has ghosting problem after working for some days
'
'    Please set the e-paper to sleep mode or disconnect it if you do not refresh the e-paper but need to power on your solution.
'    Do NOT leave power on for extended periods, otherwise, the voltage of panel remains high and it will damage the e-paper display.
'
'
' Rules
'
'    Remove power if practical.
'    ALWAYS use sleep mode. ALWAYS
'    When in storage CLEAR the screen.... avoid burn it.
'
' Sleep
'
' The recommended method is:
'
'    GLCDCLS
'    GLCDSleep
'    do
'    loop


    'EPD Constants
    #define PANEL_SETTING                               0x00
      #define PANEL_SETTING_VALUE                       0xAF
      #define PANEL_SETTING_KWR                         0x10  'can be 0x00 for B,W and R. Default is 0x10 for B and W
    #define POWER_SETTING                               0x01
    #define POWER_OFF                                   0x02
    #define POWER_OFF_SEQUENCE_SETTING                  0x03
    #define POWER_ON                                    0x04
    #define POWER_ON_MEASURE                            0x05
    #define BOOSTER_SOFT_START                          0x06
    #define DEEP_SLEEP                                  0x07
      #define DEEP_SLEEP_CHECK_CODE                     0xA5
    #define DATA_START_TRANSMISSION_1                   0x10
      #define DATA_TRANSMISSION_1                       0x10
    #define DATA_STOP                                   0x11
    #define DISPLAY_REFRESH                             0x12
    #define DATA_START_TRANSMISSION_2                   0x13
    #define DATA_TRANSMISSION_2                         0x13
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
      #define VCOM_AND_DATA_INTERVAL                    0x07
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
dim EPD2in13DAddressType  as byte

#script
    EPD2_13VERSION=16
#endscript

#startup Init_EPD2in13D, 99

sub Init_EPD2in13D

    #if GLCD_TYPE = GLCD_TYPE_EPD_EPD2in13D

        dim _GLCDPagesL, _GLCDPagesH  as byte

        asm showdebug Current_buffer_size_is BUFFWIDTH
        Dir   EPD_DC     OUT
        Dir   EPD_CS     OUT
        Dir   EPD_RESET  OUT
        Dir   EPD_DO     OUT
        Dir   EPD_SCK    OUT
        Dir   EPD_Busy   IN

        SET EPD_RESET ON
        wait 300 ms
        SET EPD_RESET OFF
        wait 200 ms
        SET EPD_RESET ON
        wait 300 ms

        #ifdef EPD_HardwareSPI
          ' harware SPI mode
           asm showdebug SPI constant used equates to HWSPIMODESCRIPT
           SPIMode HWSPIMODESCRIPT, 0
        #endif

        SendCommand_EPD2in13D(BOOSTER_SOFT_START)
        SendData_EPD2in13D(0x17)
        SendData_EPD2in13D(0x17)
        SendData_EPD2in13D(0x17)

        wait 200 ms
        SendCommand_EPD2in13D(POWER_SETTING)
        SendData_EPD2in13D(0x03)
        SendData_EPD2in13D(0x00)
        SendData_EPD2in13D(0x2B)
        SendData_EPD2in13D(0x2B)
        SendData_EPD2in13D(0x03)
        wait 200 ms
        SendCommand_EPD2in13D(POWER_ON)

        SendCommand_EPD2in13D(PANEL_SETTING)
        SendData_EPD2in13D(PANEL_SETTING_VALUE or PANEL_SETTING_KWR )

        SendCommand_EPD2in13D(PLL_CONTROL)
        SendData_EPD2in13D(0x3C)

        SendCommand_EPD2in13D(RESOLUTION_SETTING)
        SendData_EPD2in13D(0x68)
        SendData_EPD2in13D(0x00)
        SendData_EPD2in13D(0xD4)

        SendCommand_EPD2in13D(VCM_DC_SETTING)
        SendData_EPD2in13D(0x12)

        LoadLUTS_EPD2in13D

        'Colours
        GLCDForeground =TFT_WHITE
        'Default Colours
        #ifdef DEFAULT_GLCDBACKGROUND
          GLCDBackground = DEFAULT_GLCDBACKGROUND
        #endif
        #ifndef DEFAULT_GLCDBACKGROUND
          GLCDBackground = TFT_BLACK
        #endif

        #ifndef GLCD_OLED_FONT
          GLCDFontWidth = 6
        #endif

        #ifdef GLCD_OLED_FONT
          GLCDFontWidth = 5
        #endif

        GLCDCLS

        'Variables required for device
        GLCDDeviceWidth = GLCD_WIDTH - 1
        GLCDDeviceHeight= GLCD_HEIGHT- 1
        GLCDRotate Portrait

        GLCDfntDefault = 0
        GLCDfntDefaultsize = 1
        GLCDfntDefaultHeight = 8

        _GLCDPagesH = EPD_N_PAGE - 1
        _GLCDPagesL = 0
        _GLCDPage = 0

    #endif

end sub



sub Display_EPD2in13D  ( Optional In EPD2in13D_Command as Byte = Off )

  Dir   EPD_DC     OUT
  Dir   EPD_CS     OUT
  Dir   EPD_RESET  OUT
  Dir   EPD_DO     OUT
  Dir   EPD_SCK    OUT
  Dir   EPD_Busy   IN

  if EPD2in13D_Command = On then

    SET EPD_RESET ON
    wait 200 ms
    SET EPD_RESET OFF
    wait 20 ms
    SET EPD_RESET ON
    wait 200 ms

    SendCommand_EPD2in13D(BOOSTER_SOFT_START)
    SendData_EPD2in13D(0x17)
    SendData_EPD2in13D(0x17)
    SendData_EPD2in13D(0x17)

    wait 200 ms
    SendCommand_EPD2in13D(POWER_SETTING)
    SendData_EPD2in13D(0x03)
    SendData_EPD2in13D(0x00)
    SendData_EPD2in13D(0x2B)
    SendData_EPD2in13D(0x2B)
    SendData_EPD2in13D(0x03)
    wait 200 ms
    SendCommand_EPD2in13D(POWER_ON)

    SendCommand_EPD2in13D(PANEL_SETTING)
    SendData_EPD2in13D(PANEL_SETTING_VALUE or PANEL_SETTING_KWR )

    SendCommand_EPD2in13D(PLL_CONTROL)
    SendData_EPD2in13D(0x3C)

    SendCommand_EPD2in13D(RESOLUTION_SETTING)
    SendData_EPD2in13D(0x68)
    SendData_EPD2in13D(0x00)
    SendData_EPD2in13D(0xD4)

    SendCommand_EPD2in13D(VCM_DC_SETTING)
    SendData_EPD2in13D(0x12)

    LoadLUTS_EPD2in13D

  else

    SendCommand_EPD2in13D(Vcom_and_data_interval_setting)
    SendData_EPD2in13D(0xF7)
    SendCommand_EPD2in13D(POWER_OFF)
    SendCommand_EPD2in13D(DEEP_SLEEP)
    SendData_EPD2in13D(DEEP_SLEEP_CHECK_CODE)

  end if


end sub


sub LoadLUTS_EPD2in13D

    Dim DataVar as byte
    Dim Counter as Word

    SendCommand_EPD2in13D(VCM_DC_SETTING)
    SendData_EPD2in13D(0x00)


    SendCommand_EPD2in13D(VCOM_AND_DATA_INTERVAL_SETTING)
    ' Mask VCOM_AND_DATA_INTERVAL bits and then Mask the user bits.
    SendData_EPD2in13D( (0x90 AND 0xF0 ) or ( VCOM_AND_DATA_INTERVAL AND 0X0F ))

    SendCommand_EPD2in13D(0x20) 'VCOM LUT
    for EPD_Counter=1 to 44
      ReadTable Lut_Vcom, EPD_Counter, DataVar
      SendData_EPD2in13D(DataVar)
    next

    SendCommand_EPD2in13D(0x21) 'WW LUT
    for EPD_Counter=1 to 42
      ReadTable Lut_WW, EPD_Counter, DataVar
      SendData_EPD2in13D(DataVar)
    next

    SendCommand_EPD2in13D(0x22) 'BW LUT
    for EPD_Counter=1 to 42
      ReadTable Lut_BW, EPD_Counter, DataVar
      SendData_EPD2in13D(DataVar)
    next

    SendCommand_EPD2in13D(0x23) 'WB LUT
    for EPD_Counter=1 to 42
      ReadTable Lut_WB, EPD_Counter, DataVar
      SendData_EPD2in13D(DataVar)
    next

    SendCommand_EPD2in13D(0x24) 'BB LUT
    for EPD_Counter=1 to 42
      ReadTable Lut_BB, EPD_Counter, DataVar
      SendData_EPD2in13D(DataVar)
    next

end sub



sub CLS_EPD2in13D_init ( Optional In  GLCDBackground as word = GLCDBackground)

 ' initialise global variable. Required variable for Circle - DO NOT DELETE
      GLCD_yordinate = 0

      Dim EPD_Ind_raw, EPD_Ind_col as word

      Dim PrintLocX, PrintLocY as word
      PrintLocX = 0
      PrintLocY = 0

      For EPD_Ind_raw=1 to BUFFWIDTH
          EPD_Buffer(EPD_Ind_raw)=GLCDBackground
      next

      'Clear down "OLD" data
      SendCommand_EPD2in13D(Data_Transmission_1)
      wait 2 ms
      SET EPD_CS OFF
      SET EPD_DC ON
      for EPD_Ind_raw=1 to GLCD_Height
        for EPD_Ind_col=1 to GLCD_Width
          'Was.. speed optimised with macro              SendData_EPD2in13D(GLCDBackGround)
          EPD2in13D_Data = GLCDBackGround
          SendData_EPD2in13D_Macro
        next
      next
      SET EPD_CS ON
      wait 10 ms

      'Clear down "NEW" data
      SendCommand_EPD2in13D(Data_Transmission_2)
      wait 2 ms
      SET EPD_CS OFF
      SET EPD_DC ON
      for EPD_Ind_raw=1 to GLCD_Height
        for EPD_Ind_col=1 to GLCD_Width
          'Was.. speed optimised with macro              SendData_EPD2in13D(GLCDBackGround)
          EPD2in13D_Data = GLCDBackGround
          SendData_EPD2in13D_Macro

        next
      next
      SET EPD_CS ON
      wait 10 ms


end sub


sub CLS_EPD2in13D ( Optional In  GLCDBackground as word = GLCDBackground)

      CLS_EPD2in13D_init
      Refresh_EPD2in13D


end sub


sub   Pixel_To_Display_EPD2in13D

    Dim EPD_Ind_raw, EPD_Ind_col as Word

    if _GLCDPage = 0 then

      'Clear down 'OLD' data - to prevent flashing
      SendCommand_EPD2in13D(Data_Transmission_1)

      SET EPD_CS OFF
      SET EPD_DC ON
      for EPD_Ind_raw=1 to GLCD_Height
        for EPD_Ind_col=1 to GLCD_Width
          'Replaced with macro for speed              SendData_EPD2in13D(GLCDBackGround)
          EPD2in13D_Data = GLCDBackGround

          SendData_EPD2in13D_Macro
        next
      next
      SET EPD_CS ON
      SendCommand_EPD2in13D(DATA_TRANSMISSION_2)

    end if

    dim EPD2in13D_Data as byte

    'We need to set the signals as we are optimising the code by using the macro
    SET EPD_CS OFF
    SET EPD_DC ON
    for EPD_Ind_raw=1 to BUFFWIDTH
       'replaced with macro for speed
       'SendData_EPD2in13D(EPD_Buffer(EPD_Ind_raw))

        EPD2in13D_Data = EPD_Buffer(EPD_Ind_raw)

        'The following line is intentionally commented out, but, it shows the orientation of the pixels to the array. Uncomment to force a two (when the value is 3!) byte write to the Display
        'You can then examine the display to see the orientation of the pixels.
        'This will write the bytes at the top of each page - so, do not be surprised!
'        if EPD_Ind_raw < 3 then EPD2in13D_Data = GLCDForeground

        'This macro assumes the use of the variable EPD2in13D_Data
        SendData_EPD2in13D_Macro

        'Now clear the buffer
        EPD_Buffer(EPD_Ind_raw) = GLCDBackground

    next
    SET EPD_CS ON

end sub

sub Clear_buffer_EPD2in13D
 ' initialise global variable. Required variable for Circle - DO NOT DELETE
    GLCD_yordinate = 0

    Dim EPD_Ind_raw, EPD_Ind_col as word

    Dim PrintLocX, PrintLocY as word
    PrintLocX = 0
    PrintLocY = 0

    Dim EPD_Ind_raw as Word

    for EPD_Ind_raw=1 to BUFFWIDTH                 'clear the buffer
      EPD_Buffer(EPD_Ind_raw)=GLCDBackground
    next



end sub

sub Refresh_EPD2in13D
'Not required as this process has already happenend from INIT
    'LoadLUTS_EPD2in13D

    SendCommand_EPD2in13D(DISPLAY_REFRESH)

end sub

sub Sleep_EPD2in13D

    SendCommand_EPD2in13D(Vcom_and_data_interval_setting)
    SendData_EPD2in13D(0xF7)

    SendCommand_EPD2in13D(POWER_OFF)

    SendCommand_EPD2in13D(DEEP_SLEEP)
    SendData_EPD2in13D(DEEP_SLEEP_CHECK_CODE)

end sub

sub SendCommand_EPD2in13D(in EPD2in13D_Command as Byte)

    SET EPD_CS OFF
    SET EPD_DC OFF
    #ifdef EPD_HardwareSPI
      FastHWSPITransfer EPD2in13D_Command
      SET EPD_CS ON
      do
      loop while EPD_Busy=Off
      Exit sub
    #endif

    #ifndef EPD_HardwareSPI
      REPEAT 8

        IF EPD2in13D_Command.7 = ON THEN
          Set EPD_DO ON
        ELSE
          Set EPD_DO OFF
        END IF
        SET EPD_SCK On

        Rotate EPD2in13D_Command left
        Set EPD_SCK Off

      END REPEAT
      Set EPD_CS ON
      do
      loop while EPD_Busy=Off
    #endif

end sub

sub SendData_EPD2in13D(in EPD2in13D_Data as Byte)

    SET EPD_CS OFF
    SET EPD_DC ON
    SendData_EPD2in13D_Macro
    SET EPD_CS ON
end sub


'This assumes variable EPD2in13D_Data
macro SendData_EPD2in13D_Macro

        #ifdef EPD_HardwareSPI
          FastHWSPITransfer EPD2in13D_Data
        #endif

        #ifndef EPD_HardwareSPI
          REPEAT 8
            IF EPD2in13D_Data.7 = ON THEN
              Set EPD_DO ON
            ELSE
              Set EPD_DO OFF
            END IF
            SET EPD_SCK On
            Rotate EPD2in13D_Data left
            Set EPD_SCK Off
          END REPEAT
        #endif

End Macro

Sub DrawString_EPD2in13D( In StringLocX as word, In CharLocY as word, In Chars as string, Optional In LineColour as word = GLCDForeground )

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
Sub DrawChar_EPD2in13D(In CharLocX as word, In CharLocY as word, In CharCode, Optional In LineColour as word = GLCDForeground )

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
Sub PSet_EPD2in13D(In GLCDX as word, In GLCDY as word, In GLCDColour As Word)

  Dim EPD_Ind, EPD_N_Col, EPD_N_raw, EPD_Ind_Trans as word
  Dim remainder as byte
  Dim DataVar as byte
  Dim value as bit
  Dim GLCD_Time_Buff as word
  Dim GLCDDataTemp, GLCDY_Temp, GLCDY_withinPage  as word


    Select Case EPD2in13DAddressType

      case Landscape
          GLCDDataTemp = GLCDX
          GLCDX = GLCDY
          GLCDY = GLCD_HEIGHT - GLCDDataTemp - 1

      case Landscape_Rev
          GLCDDataTemp = GLCDX
          GLCDX = GLCD_WIDTH  - GLCDY - 1
          GLCDY = GLCDDataTemp

      case Portrait
            'Default do nothing

      case Portrait_Rev
          GLCDY = GLCD_HEIGHT - GLCDY - 1
          GLCDX = GLCD_WIDTH - GLCDX - 1

    end select

    #IFDEF GLCD_PROTECTOVERRUN
        'anything off screen with be rejected
        if GLCDX > GLCDDeviceWidth OR GLCDY > GLCDDeviceHeight Then
            exit sub
        end if

    #ENDIF


    'Exit if not the current page.
    if  ( GLCDY / EPD_PIXELS_PER_PAGE  ) <> _GLCDPage then
      exit sub
    end if


'    EPD_N_Col=(GLCDX+1)/8                   'number of the column of the byte to be set
    EPD_N_Col=(GLCDX+1)
    Repeat 3
      Set C Off
      Rotate EPD_N_Col Right
    End Repeat

    remainder=(GLCDX+1) % 8

    EPD_N_raw=GLCDY * GLCD_Width8       'number of the column of the byte to be set

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
Sub FilledBox_EPD2in13D(In LineX1 as word, In LineY1 as word, In LineX2 as word, In LineY2 as word, Optional In LineColour As Word = GLCDForeground)
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
      PSet(EPD_Ind_Col, EPD_Ind_raw, LineColour)
    next
  next
End Sub



Sub Rotate_EPD2in13D( in EPD2in13DAddressType as byte )

  DIM GLCDDataTemp, PrintLocY, PrintLocX as word

  PrintLocY = 0
  PrintLocX = 0

  select case EPD2in13DAddressType

        case PORTRAIT

              GLCDDeviceHeight = GLCD_HEIGHT - 1
              GLCDDeviceWidth = GLCD_WIDTH - 1

        case LANDSCAPE

              GLCDDeviceHeight = GLCD_WIDTH - 1
              GLCDDeviceWidth  = GLCD_HEIGHT - 1

        case PORTRAIT_REV

              GLCDDeviceHeight = GLCD_HEIGHT - 1
              GLCDDeviceWidth  = GLCD_WIDTH - 1

        case LANDSCAPE_REV

              GLCDDeviceHeight = GLCD_WIDTH - 1
              GLCDDeviceWidth  = GLCD_HEIGHT - 1

        case else

              GLCDDeviceHeight = GLCD_HEIGHT - 1
              GLCDDeviceWidth  = GLCD_WIDTH - 1

  end select

end sub



'Macro GLCD_Open_PageTransaction_EPD2in13D ( Optional In _GLCDPagesL As byte = 0 , Optional In _GLCDPagesH As byte = 7 )
Macro GLCD_Open_PageTransaction_EPD2in13D ( Optional In _GLCDPagesL As byte = 0 , Optional In _GLCDPagesH As byte = EPD_N_PAGE - 1 )

      dim _GLCDPage as byte
      dim _GLCDPagesL, _GLCDPagesH as byte

      Clear_buffer_EPD2in13D

      for _GLCDPage = _GLCDPagesL to _GLCDPagesH    '_GLCDPage is a global variable - DO NOT CHANGE!!!

            GLCDLocateString 0,0

end Macro

Macro  GLCD_Close_PageTransaction_EPD2in13D

          Pixel_To_Display_EPD2in13D

      next

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
