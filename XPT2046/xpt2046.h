'    XPT2046 routines for the GCBASIC compiler
'    Copyright (C) 2018 Evan R. Venn

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

'    v0.9e - more samples

 '''    '******************************************************************************************************
'''    'Setup the XPT2046
'''
'''    'Typical calibration range for Hardware SPI when using XPT2046
'''    'for 320 * 240 screeen... may be different for others
'''    #define XPT2046XMIN   17
'''    #define XPT2046YMIN   15
'''    #define XPT2046XMAX   100
'''    #define XPT2046YMAX   110
'''
'''    'Typical Calibration range for Software SPI when using XPT2046
''''    #define XPT2046XMIN   30
''''    #define XPT2046YMIN   25
''''    #define XPT2046XMAX   210
''''    #define XPT2046YMAX   225
'''
'''
'''    #define XPT2046_DI       DIGITAL_12          ' Data in | MISO.  Should be shared port the GLCD (it will be if hardware SPI is used).  No essential to define as the librart will select the GLCD port
'''    #define XPT2046_DO       DIGITAL_11          ' Data out | MOSI.  .  Should be shared port the GLCD (it will be if hardware SPI is used).  No essential to define as the librart will select the GLCD port
'''    #define XPT2046_SCK      DIGITAL_13          ' Clock Line.  .  Should be shared port the GLCD (it will be if hardware SPI is used).  No essential to define as the librart will select the GLCD port
'''
'''    #define XPT2046_CS       DIGITAL_2           ' Touch chip select line. MUST BE DEFINED.
'''    #define XPT2046_IRQ      ANALOG_5            ' Event line... something touched the GLCD touch sensor.  MUST BE DEFINED.
'''    #define XPT2046_HardwareSPI                  ' remove/comment out if you want to use software SPI - must use same method as GLCD
'''
'''    '******************************************************************************************************



'No change below here
#define XPT2046_ReadSamples 200

#define XPT2046_CFG_START   128       'bit 7

#define XPT2046_CFG_MUX     112       'bits 7-4 the channel select bits   A2, A1 & A0
#define XPT2046_MUX_Y       80
#define XPT2046_MUX_X       16
#define XPT2046_MUX_Z1      48
#define XPT2046_MUX_Z2      64


#define XPT2046_CFG         8
#define XPT2046_CFG_8BIT    8         'bit 3 - the 12 or 8 bit conversion
#define XPT2046_CFG_12BIT   0

#define XPT2046_CFG         4
#define XPT2046_CFG_SER     4         'bit 2 - Single-ended or Differential conversion
#define XPT2046_CFG_DFR     0

#define XPT2046_CFG_PWR     0         'bit 1-0 - the power mask.  PD1 & PD0
#define XPT2046_CFG_PWR_1   1         'bit 1-0 - the power mask.  PD1 & PD0
#define XPT2046_CFG_PWR_2   2         'bit 1-0 - the power mask.  PD1 & PD0
#define XPT2046_CFG_PWR_3   3         'bit 1-0 - the power mask.  PD1 & PD0


#script

  'Test, map to the GLCD pins if they exist
  XPT2046_DI_PORT = 0
  if XPT2046_DI Then
    XPT2046_DI_PORT = 1
  end if
  if XPT2046_DI_PORT = 0 Then
    if GLCD_DI Then
        XPT2046_DI = GLCD_DI
        XPT2046_DI_PORT = 1
    end if
  end if
  if XPT2046_DI_PORT = 0 Then
      Warning "Missing Port Assignment XPT2046_DI"
  end if

  XPT2046_DO_PORT = 0
  if XPT2046_DO Then
    XPT2046_DO_PORT = 1
  end if
  if XPT2046_DO_PORT = 0 Then
    if GLCD_DO Then
        XPT2046_DO = GLCD_DO
        XPT2046_DO_PORT = 1
    end if
  end if
  if XPT2046_DO_PORT = 0 Then
      Warning "Missing Port Assignment XPT2046_DO"
  end if

  XPT2046_SCK_PORT = 0
  if XPT2046_SCK Then
    XPT2046_SCK_PORT = 1
  end if
  if XPT2046_SCK_PORT = 0 Then
    if GLCD_SCK Then
        XPT2046_SCK = GLCD_SCK
        XPT2046_SCK_PORT = 1
    end if
  end if
  if XPT2046_SCK_PORT = 0 Then
      Warning "Missing Port Assignment XPT2046_SCK"
  end if

  XPT2046_CS_PORT = 0
  if XPT2046_CS Then
    XPT2046_CS_PORT = 1
  end if
  if XPT2046_CS_PORT = 0 Then
      Warning "Missing Port Assignment XPT2046_CS"
  end if

  XPT2046_IRQ_PORT = 0
  if XPT2046_IRQ Then
    XPT2046_IRQ_PORT = 1
  end if
  if XPT2046_IRQ_PORT = 0 Then
      Warning "Missing Port Assignment XPT2046_IRQ"
  end if


#endscript

#startup Init_XPT2046, 99

  dim XTouchPoint_XPT2046, YTouchPoint_XPT2046 as Word
  dim XTouchPoint_XPT2046raw, YTouchPoint_XPT2046raw as word
  dim XPT2046_Xmin, XPT2046_Ymin, XPT2046_Xmax, XPT2046_Ymax  as Byte

Sub Init_XPT2046 (Optional In precision = PREC_EXTREME)

    XPT2046_Xmin =  XPT2046XMIN
    XPT2046_Ymin =  XPT2046YMIN
    XPT2046_Xmax =  XPT2046XMAX
    XPT2046_Ymax =  XPT2046YMAX

    DIR XPT2046_DI IN
    DIR XPT2046_IRQ IN
    DIR XPT2046_DO OUT
    DIR XPT2046_SCK OUT
    DIR XPT2046_CS  OUT
    #ifdef XPT2046_HardwareSPI
      ' harware SPI mode
      SPIMode MasterFast, 0
    #endif

    Repeat 4
        set XPT2046_CS OFF
        wait 10 ms
        set XPT2046_CS ON
        wait 10 ms
    End Repeat

    #define isTouched_XPT2046  XPT2046_IRQ = 1
    EnableIRQ_XPT2046


End Sub

sub SetCalibation_XPT2046( XPT2046_Xmin, XPT2046_Xmax, XPT2046_Ymin, XPT2046_Ymax )
     'this simply set the variables
End Sub

Sub EnableIRQ_XPT2046

    set XPT2046_CS OFF
    SendData_XPT2046( XPT2046_CFG_START | XPT2046_CFG_8BIT | XPT2046_CFG_DFR | XPT2046_MUX_Y )
    wait 1 ms
    set XPT2046_CS ON

End Sub

'''Send a data byte to the XPT2046 GLCD
'''@param XPT2046SendByte Byte to send
'''@hide
sub  TransferData_XPT2046( IN XPT2046SendByte as byte, XPT2046OutByte as byte )

  Dim XPT2046OutByte as byte
  XPT2046OutByte = 0

  #ifdef XPT2046_HardwareSPI
     SPITransfer  XPT2046SendByte,  XPT2046OutByte
  #endif

  #ifndef XPT2046_HardwareSPI
      repeat 8

        if XPT2046SendByte.7 = ON then
          set XPT2046_DO ON;
        else
          set XPT2046_DO OFF;
        end if
        SET XPT2046_SCK On;

        if XPT2046_DI = 1 then
          XPT2046OutByte.0 = 1
        end if

        rotate XPT2046OutByte left
        rotate XPT2046SendByte left
        set XPT2046_SCK Off;

      end Repeat

  #endif
'  wait 250 us

end Sub

'''Send a command to the XPT2046 GLCD
'''@param XPT2046SendByte Command to send
'''@hide
sub  SendData_XPT2046( IN XPT2046SendByte as byte )


  #ifdef XPT2046_HardwareSPI
     SPITransfer  XPT2046SendByte,  XPT2046TempOut
  #endif

  #ifndef XPT2046_HardwareSPI
      set XPT2046_SCK Off;
      repeat 8

        if XPT2046SendByte.7 = ON  then
          set XPT2046_DO ON;
        else
          set XPT2046_DO OFF;
        end if
        SET XPT2046_SCK On;
        rotate XPT2046SendByte left
        set XPT2046_SCK Off;

      end repeat
  #endif

end Sub


Sub GetXY_XPT2046 (out XTouchPoint_XPT2046 as word, out YTouchPoint_XPT2046 as word )

    dim XTouchPoint_XPT2046, YTouchPoint_XPT2046 as Word
    dim NewXTouchPoint_XPT2046, NewYTouchPoint_XPT2046 as Word
    dim XTouchPoint_XPT2046raw, YTouchPoint_XPT2046Raw as word

    set XPT2046_CS OFF

      Repeat 10
          TransferData_XPT2046  ( XPT2046_CFG_START | XPT2046_CFG_8BIT | XPT2046_CFG_DFR | XPT2046_MUX_X  | XPT2046_CFG_PWR ), XPT2046TempOut
          TransferData_XPT2046  0,  YTouchPoint_XPT2046
          TransferData_XPT2046  ( XPT2046_CFG_START | XPT2046_CFG_8BIT | XPT2046_CFG_DFR | XPT2046_MUX_Y  | XPT2046_CFG_PWR ), XPT2046TempOut
          TransferData_XPT2046  0, XTouchPoint_XPT2046
          TransferData_XPT2046  0, XPT2046TempOut
      end Repeat

      XTouchPoint_XPT2046 = 0
      YTouchPoint_XPT2046 = 0

      Repeat XPT2046_ReadSamples

          TransferData_XPT2046  XPT2046_CFG_START | XPT2046_CFG_8BIT | XPT2046_CFG_DFR | XPT2046_MUX_X  | XPT2046_CFG_PWR, XPT2046TempOut
          wait 20 us
          TransferData_XPT2046  0,  NewYTouchPoint_XPT2046
          TransferData_XPT2046  XPT2046_CFG_START | XPT2046_CFG_8BIT | XPT2046_CFG_DFR | XPT2046_MUX_Y  | XPT2046_CFG_PWR, XPT2046TempOut
          wait 20 us
          TransferData_XPT2046  0, NewXTouchPoint_XPT2046
          TransferData_XPT2046  0, XPT2046TempOut

          yTouchPoint_XPT2046 = ( yTouchPoint_XPT2046 + NewyTouchPoint_XPT2046 )
          XTouchPoint_XPT2046 = ( XTouchPoint_XPT2046 + NewXTouchPoint_XPT2046 )

      End Repeat

      yTouchPoint_XPT2046 = yTouchPoint_XPT2046 /(XPT2046_ReadSamples )
      xTouchPoint_XPT2046 = xTouchPoint_XPT2046 /(XPT2046_ReadSamples )

      SendData_XPT2046( XPT2046_CFG_START | XPT2046_CFG_8BIT | XPT2046_CFG_DFR | XPT2046_CFG_PWR )

    set XPT2046_CS ON

    'Set the raw values, folks may want to know this
    XTouchPoint_XPT2046raw = XTouchPoint_XPT2046
    YTouchPoint_XPT2046Raw = yTouchPoint_XPT2046

    'Scale to calibration
    XTouchPoint_XPT2046 = scale ( XTouchPoint_XPT2046, XPT2046_Xmin, XPT2046_Xmax, 0, Current_GLCD_WIDTH )
    YTouchPoint_XPT2046 = scale ( YTouchPoint_XPT2046, XPT2046_Ymin, XPT2046_Ymax, 0, Current_GLCD_HEIGHT )


    if GLCDRotateState = Portrait_Rev then
        YTouchPoint_XPT2046 = GLCD_HEIGHT - YTouchPoint_XPT2046
    end if


    if GLCDRotateState = Landscape_Rev then
        XTouchPoint_XPT2046 = GLCD_WIDTH - XTouchPoint_XPT2046
    end if


End Sub
