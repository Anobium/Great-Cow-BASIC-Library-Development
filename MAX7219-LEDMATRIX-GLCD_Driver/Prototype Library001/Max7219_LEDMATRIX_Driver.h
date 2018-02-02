'    Graphical Max7219 GLCD routines for the GCBASIC compiler
'    Copyright (C) 2018 Hugh Considine and Evan Venn

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

'Notes:
' Supports Max7219 as a GLCD controller only.
' 02/02/2018  Updated Max7219_LEDMatrix_Brightness to correct number of devices set.

  ' Include the GLCD.H to reuse the font tables
  #include <glcd.h>

  ' Set GLCD_TYPE to ensure glcdinit does initialise for the max7219 solution
  #define GLCD_TYPE NOTSPECIFIED    'Do not change

  ' Reguired defines - Do not change
  #define  MAX7219_REG_NOOP        0x00
  #define  MAX7219_REG_DECODEMODE  0x09   ' decode register; specify digits to decode
  #define  MAX7219_REG_INTENSITY   0x0A   ' intensity (brightness) register; 15 = 100%
  #define  MAX7219_REG_SCANLIMIT   0x0B   ' scan-limit register; specify how many digits
  #define  MAX7219_REG_SHUTDOWN    0x0C   ' 1 = display on; 0 = display off
  #define  MAX7219_REG_DISPLAYTEST 0x0F   ' 1 =  on; 0 =  off


  'Constants - Do not change
  #define Max7219_LEDMatrix_Update  Max7219_LEDMatrix_SendBuffer
  #define Pset max7219_LEDMatrix_PSet_0

  ' Do NOT CHANGE!
  #define GLCDCLS Max7219_LEDMatrix_GLCDCLS
  #define GLCDDrawChar max7219_LEDMatrix_GLCDDrawChar
  #define GLCDPrint max7219_LEDMatrix_GLCDPrint
  ' Do NOT CHANGE!

  ' Determine the power on wait. Can be changed by the user
  #define Max7219_PowerOnTestWait_ms 100

  #startup MAX7219_LEDMatrix_Init

 'Declare global variables
  dim  GLCDBackground, GLCDForeground as byte
  'Declare default Constants
  #define MAX7219_X_Devices 4       'Default
  #define MAX7219_Y_Devices 1       'Default


  ' Calculate the max pixels for the buffer
  #define Max7219_Devices ( MAX7219_X_Devices  * MAX7219_Y_Devices )
  #define Max7219_PixelBytes ( Max7219_Devices * 8 )

  ' Create the image buffer
  Dim Max7219_Image_Buffer( Max7219_PixelBytes )

  sub MAX7219_LEDMatrix_Init

    GLCDBackground = 0
    GLCDForeground = 1

    #ifdef MAX7219_LEDMatrix_HardwareSPI
        SPIMode masterfast, SPI_CPOL_0 + SPI_CPHA_0
    #endif

    Dir Max7219_DI  In
    Dir Max7219_DO  Out
    Dir Max7219_SCK Out
    Dir Max7219_CS  out
    wait 100 ms

    Set Max7219_DO  off
    Set Max7219_SCK on
    wait 100 ms

    'initialise
    Max7219_sendByte(MAX7219_REG_SCANLIMIT, 0x07)'Scan limit = 7
    Max7219_sendByte(MAX7219_REG_DECODEMODE, 0x00)'Decoding off
    Max7219_sendByte(MAX7219_REG_SHUTDOWN, 0x01)'Normal operation mode
    Max7219_sendByte(MAX7219_REG_DISPLAYTEST, 0x00)
    Max7219_sendByte(MAX7219_REG_INTENSITY, 0x00)'Brightness to minimum
    wait Max7219_PowerOnTestWait_ms ms
    Max7219_CS = 1
    wait Max7219_PowerOnTestWait_ms ms
    Max7219_CS = 0
    wait Max7219_PowerOnTestWait_ms ms
    Max7219_CS = 1
    wait Max7219_PowerOnTestWait_ms ms
    GLCDFontWidth = 6
    GLCDCLS

end sub



Sub Max7219_LEDMatrix_GLCDCLS ( Optional In  GLCDBackground as byte = GLCDBackground )

  ' initialise global variable. Required variable for Circle - DO NOT DELETE
  GLCD_yordinate = 0

  Dim Max7219_PixelCounter , Max7219_DeviceAddress as byte

  Max7219_DeviceAddress = 1

  For Max7219_PixelCounter = 1 to Max7219_PixelBytes

            MAX7219_Image_Buffer( Max7219_PixelCounter ) = 0

            Max7219_RowAddress = ( ( Max7219_PixelCounter mod 8 ) )

            'Send a number of NOPS
            Repeat ( Max7219_Devices - Max7219_DeviceAddress )
                Max7219_sendByte(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
            End Repeat

            'Send data to the specific Device and Row
            Max7219_sendByte( Max7219_RowAddress, GLCDBackground )

            'Send a number of NOPS
            Repeat Max7219_DeviceAddress - 1
                Max7219_sendByte(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
            End Repeat

            'Increment the Device address
            If Max7219_RowAddress = 8 then
                Max7219_DeviceAddress++
            end if

  Next

End Sub

  Sub Max7219_LEDMatrix_ScrollMessage( in OutMessage as string, In max7219_MessageTime As Word )

    dim max7219_ScrollLen, max7219_ScrollPosition, max7219_XScrollPosition as word
    max7219_ScrollLen = OutMessage(0) * GLCDFontWidth

    max7219_XScrollPosition = Max7219_PixelBytes-1

    For max7219_ScrollPosition = 0 to max7219_ScrollLen-1
      Max7219_LEDMatrix_ClearBuffer ( Max7219_Image_Buffer() ,Max7219_PixelBytes)
      GLCDPrint(max7219_XScrollPosition, 0,  OutMessage)
      max7219_XScrollPosition--
      Max7219_LEDMatrix_SendBuffer ( Max7219_Image_Buffer() ,Max7219_PixelBytes)
      if max7219_MessageTime > 0 then
          Wait max7219_MessageTime ms
      end if
    Next

  End Sub

  Sub Max7219_LEDMatrix_Flash( In max7219_MessageTime As Word)

    Max7219_sendByte(MAX7219_REG_SHUTDOWN, 0x00)
    Max7219_sendByte(MAX7219_REG_SHUTDOWN, 0x00)
    Max7219_sendByte(MAX7219_REG_SHUTDOWN, 0x00)
    Max7219_sendByte(MAX7219_REG_SHUTDOWN, 0x00)
    Wait max7219_MessageTime ms

    Max7219_sendByte(MAX7219_REG_SHUTDOWN, 0x01)'Normal operation mode
    Max7219_sendByte(MAX7219_REG_SHUTDOWN, 0x01)'Normal operation mode
    Max7219_sendByte(MAX7219_REG_SHUTDOWN, 0x01)'Normal operation mode
    Max7219_sendByte(MAX7219_REG_SHUTDOWN, 0x01)'Normal operation mode
    Wait max7219_MessageTime ms


  End Sub



  sub Max7219_LEDMatrix_Brightness (  optional in Max7219_Brightness_Value = 7  )

    if Max7219_Brightness_Value > 0x0f then Max7219_Brightness_Value = 0x0f
    repeat Max7219_Devices
        Max7219_sendByte( MAX7219_REG_INTENSITY , Max7219_Brightness_Value )
    end Repeat

  end sub


  sub Max7219_SendByte(in _MAX7219_reg, in _MAX7219_ddata )

  #ifdef MAX7219_LEDMatrix_HardwareSPI
      Max7219_CS = 0
      FastHWSPITransfer  _MAX7219_reg
      FastHWSPITransfer  _MAX7219_ddata
      Max7219_CS = 1
      exit sub
  #endif

  'must be software SPI
  Max7219_CS = 0

  repeat 8

    if _MAX7219_reg.7 = ON then
      set Max7219_DO ON
    else
      set Max7219_DO OFF
    end if
    SET Max7219_SCK OFF
    rotate _MAX7219_reg left
    set Max7219_SCK ON

  end Repeat

  repeat 8

    if _MAX7219_ddata.7 = ON then
      set Max7219_DO ON
    else
      set Max7219_DO OFF
    end if
    SET Max7219_SCK OFF
    rotate _MAX7219_ddata left
    set Max7219_SCK ON

  end Repeat

  Max7219_CS = 1

  end sub

  sub Max7219_SendByteStream(in _MAX7219_reg, in _MAX7219_ddata)

  #ifdef MAX7219_LEDMatrix_HardwareSPI
      FastHWSPITransfer  _MAX7219_reg
      FastHWSPITransfer  _MAX7219_ddata
      exit sub
  #endif


  'must be software SPI
  repeat 8

    if _MAX7219_reg.7 = ON then
      set Max7219_DO ON
    else
      set Max7219_DO OFF
    end if
    SET Max7219_SCK OFF
    rotate _MAX7219_reg left
    set Max7219_SCK ON

  end Repeat

  repeat 8

    if _MAX7219_ddata.7 = ON then
      set Max7219_DO ON
    else
      set Max7219_DO OFF
    end if
    SET Max7219_SCK OFF
    rotate _MAX7219_ddata left
    set Max7219_SCK ON

  end Repeat


  end sub


  Sub Max7219_LEDMatrix_SendBuffer

    Dim Max7219_ByteValue, Max7219_PixelCounter As Byte
    Max7219_PixelCounter = 1

    Max7219_CS = 1

    For Max7219_CurrentMatrix = 1 to Max7219_Devices

        For CurrPixelY = 1 to 8

          Max7219_CS = 0

          'Send a number of NOPS
          Repeat ( Max7219_Devices - Max7219_CurrentMatrix )
              Max7219_SendByteStream(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
          End Repeat

          'Send data to the specific Device and Row
          Max7219_SendByteStream( CurrPixelY, Max7219_Image_Buffer ( Max7219_PixelCounter) )

          'Send a number of NOPS
          Repeat Max7219_CurrentMatrix - 1
              Max7219_SendByteStream(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
          End Repeat

          Max7219_PixelCounter++
          Max7219_CS = 1

        Next
        HSerPrintCRLF

    Next

  End Sub


  Sub Max7219_LED4Matrix_SendBuffer

    Dim Max7219_ByteValue, Max7219_PixelCounter As Byte
    Max7219_PixelCounter = 1

    For Max7219_CurrPixelX = 1 to Max7219_PixelBytes / 8

        For CurrPixelY = 1 to 8

          Max7219_CS = 1
          Max7219_CS = 0

          select case Max7219_PixelCounter

          case 1 to 8

              Max7219_SendByteStream(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
              Max7219_SendByteStream(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
              Max7219_SendByteStream(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
              Max7219_SendByteStream( CurrPixelY ,Max7219_Image_Buffer ( Max7219_PixelCounter) )

          case 9 to 16
              Max7219_SendByteStream(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
              Max7219_SendByteStream(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
              Max7219_SendByteStream( CurrPixelY ,Max7219_Image_Buffer ( Max7219_PixelCounter) )
              Max7219_SendByteStream(MAX7219_REG_NOOP, MAX7219_REG_NOOP)

          case 17 to 24
              Max7219_SendByteStream(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
              Max7219_SendByteStream( CurrPixelY ,Max7219_Image_Buffer ( Max7219_PixelCounter) )
              Max7219_SendByteStream(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
              Max7219_SendByteStream(MAX7219_REG_NOOP, MAX7219_REG_NOOP)


          case 25 to 32
              Max7219_SendByteStream( CurrPixelY ,Max7219_Image_Buffer ( Max7219_PixelCounter) )
              Max7219_SendByteStream(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
              Max7219_SendByteStream(MAX7219_REG_NOOP, MAX7219_REG_NOOP)
              Max7219_SendByteStream(MAX7219_REG_NOOP, MAX7219_REG_NOOP)

          end select

          Max7219_PixelCounter++
          Max7219_CS = 1

        Next

    Next

  End Sub


 sub Max7219_LEDMatrix_BufferInvert

  Dim Max7219_PixelCounter as word

  For Max7219_PixelCounter = 1 to Max7219_PixelBytes

          Max7219_Image_Buffer ( Max7219_PixelCounter ) = !Max7219_Image_Buffer ( Max7219_PixelCounter )
  Next

  Max7219_PaintFromBuffer

  End Sub


  Sub Max7219_LEDMatrix_ClearBuffer

    For Max7219_CurrPixelX = 1 to Max7219_PixelBytes
        Max7219_Image_Buffer(Max7219_CurrPixelX) = 0
    Next

  End Sub




Sub Max7219_LEDMatrix_PSet_90( max7219_LocX as word, max7219_LocY as word, PixelCol)

      'Protect the buffer - by extreme X Y locations
      if max7219_LocX > ( MAX7219_X_Devices * 8 ) -1  then exit sub
      elementbit =  max7219_LocY / 8
      if elementbit >  MAX7219_Y_Devices - 1 then exit sub


      element = ( max7219_LocX + ( max7219_LocY / 8 ) + 1 )
      elementbit =  max7219_LocY mod 8

      Max7219_Image_Buffer( element ) = Max7219_Image_Buffer( element ) OR FnLSL( PixelCol, elementbit )

  End Sub

Sub Max7219_LEDMatrix_PSet_0( max7219_LocX as word, max7219_LocY as word, PixelCol)


      'Protect the buffer - by extreme X Y locations
      if max7219_LocX > ( MAX7219_X_Devices * 8 ) - 1  then Exit sub
      elementbit =  max7219_LocY / 8
      if elementbit >  MAX7219_Y_Devices - 1 then Exit Sub

      elementbit = max7219_LocX mod 8
      element = ( ( max7219_LocX / 8 ) * 8 ) + (8-max7219_LocY)

      Max7219_Image_Buffer( element ) = Max7219_Image_Buffer( element ) OR FnLSL( PixelCol, elementbit )



  End Sub





  '''Displays a message
  '''@param PrintLocX X coordinate for message
  '''@param PrintLocY Y coordinate for message
  '''@param PrintData Message to display
  Sub Max7219_LEDMatrix_GLCDPrint(In PrintLocX as word, In PrintLocY as word, in LCDPrintData as string )

    Dim GLCDPrintLoc as word

    PrintLen = LCDPrintData(0)
    If PrintLen = 0 Then Exit Sub

    GLCDPrintLoc = PrintLocX
    'Write Data
    For SysPrintTemp = 1 To PrintLen
      GLCDDrawChar GLCDPrintLoc, PrintLocY, LCDPrintData(SysPrintTemp)
      GLCDPrintLoc += GLCDFontWidth
    Next
  End Sub

  '''Displays a number
  '''@param PrintLocX X coordinate for message
  '''@param PrintLocY Y coordinate for message
  '''@param LCDValue Number to display
  Sub Max7219_LEDMatrix_GLCDPrint(In PrintLocX, In PrintLocY, In LCDValue As Long)
    Dim SysCalcTempA As Long
    Dim SysPrintBuffer(10)
    SysPrintBuffLen = 0

    Do
      'Divide number by 10, remainder into buffer
      SysPrintBuffLen += 1
      SysPrintBuffer(SysPrintBuffLen) = LCDValue % 10
      LCDValue = SysCalcTempA
    Loop While LCDValue <> 0

    'Display
    GLCDPrintLoc = PrintLocX
    For SysPrintTemp = SysPrintBuffLen To 1 Step -1
      GLCDDrawChar GLCDPrintLoc, PrintLocY, SysPrintBuffer(SysPrintTemp) + 48
      GLCDPrintLoc += GLCDFontWidth
    Next

  End Sub


  '''Draws a character at the specified location on the ST7920 GLCD
  '''@param StringLocX X coordinate for message
  '''@param CharLocY Y coordinate for message
  '''@param Chars String to display
  '''@param LineColour Line Color, either 1 or 0
  Sub max7219_LEDMatrix_GLCDDrawChar(In CharLocX as word, In CharLocY as word, In CharCode, Optional In LineColour as word = GLCDForeground )

    'CharCode needs to have 16 subtracted, table starts at char 16 not char 0
    CharCode -= 15

    'invert colors if required

      if LineColour <> GLCDForeground  then
        'Inverted Colours
        GLCDBackground = 1
        GLCDForeground = 0
      end if

            'Need to read characters from CharColn (n = 0:7) tables
    '(First 3, ie 0:2 are blank, so can ignore)
    For CurrCharCol = 1 to 5

      Select Case CurrCharCol
        Case 1: ReadTable GLCDCharCol3, CharCode, CurrCharVal
        Case 2: ReadTable GLCDCharCol4, CharCode, CurrCharVal
        Case 3: ReadTable GLCDCharCol5, CharCode, CurrCharVal
        Case 4: ReadTable GLCDCharCol6, CharCode, CurrCharVal
        Case 5: ReadTable GLCDCharCol7, CharCode, CurrCharVal
      End Select
      For CurrCharRow = 0 to 7
        If CurrCharVal.0 = 0 Then
                  PSet CharLocX + CurrCharCol-1, CharLocY + CurrCharRow, GLCDBackground
        Else
                  PSet CharLocX + CurrCharCol-1, CharLocY + CurrCharRow, GLCDForeground
        End If
        Rotate CurrCharVal Right
      Next

    Next

    'Restore
    GLCDBackground = 0
    GLCDForeground = 1

  End Sub
