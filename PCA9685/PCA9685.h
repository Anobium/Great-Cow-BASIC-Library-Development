'    PCA9685 routines for the GCBASIC compiler
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

'Notes:
'     v0.9a - initial release needs to have the Servo methods sorted.
'     v0.9b - revised to fix the Duty at 100%
'     v0.9c - revised PCA9685_SetFreqency to remove typo
'     v1.0  - first library release
'     v2.X  - added support for more devices

; ----- Define Hardware settings for I2C
    ' Define I2C settings - CHANGE PORTS if required for your specific device.
;    #define hi2c_BAUD_RATE 100
;    #define hi2c_DATA PORTC.3
;    #define hi2c_CLOCK PORTC.4
    'Initialise I2C Master
    'I2C pins need to be input for SSP module

;or
; ----- Define software settings for I2C
    ' Define I2C settings - CHANGE PORTS if required for your specific device.
;     #define I2C_MODE Master
;     #define I2C_DATA PORTC.3
;     #define I2C_CLOCK PORTC.4
;     #define I2C_DISABLE_INTERRUPTS ON

; Solution Specific constants can be replaced by user constants

    #define PCA9685_ADDRESS_1 0x80
'    #define PCA9685_ADDRESS_2 0x82
'    #define PCA9685_ADDRESS_3 0x84
'    #define PCA9685_ADDRESS_4 0x86

    ' Set the frequency using the Great Cow BASIC PWM constant
    #define PWM_Freq 38
    '  Range is 24-1526
      '#define PWM_Freq 1526
      '#define PWM_Freq 24


' Public methods

'    PCA9685_SetFreqency ( frequency_wordvalue ) a value from 24 to 1526
'    PCA9685_SetPrescaler ( byte_value)
'    PCA9685_SetChannelDuty(  channel as byte , duty as word )  where duty is 0 to 100%
'    PCA9685_SetChannelOnOnly ( channel as byte , OnValue as word ) where Onvalue is 0 to 4095
'    PCA9685_SetChannelOffOnly ( channel as byte , OffValue as word ) where Offvalue is 0 to 4095
'    PCA9685_WriteChannel( channel as byte, OnValue as word, OffValue  as word ) ranges of 0 to 4095

'      PCA9685_EnableServoMode
'      PCA9685_SetServoAnglePulseLimits
'      PCA9685_GetServoAnglePulseLimits
'      PCA9685_SetServoAngleLimits
'      PCA9685_GetServoAngleLimits
'      PCA9685_SetChannelAngle

' Key Constants
'        PCA9685_ADDRESS_1    device address
'        PWM_DUTY             default pwm

'        PCA9685_ALL_CHANNELS   address all channels
'        PCA9685_LED0, PCA9685_LED1 etc to PCA9685_LED15   address a specific channel
'        PCA9685_LED_ON                                    set channel on
'        PCA9685_LED_OFF                                   set channel off
'        PCA9685_INTERNAL_CLOCK_FREQUENCY                  set to 25000000 change if you use an external clock
'

    ' Let's make a big long hideous list of all the register names and pin names!

     #define PCA9685_MODE1         0x00
     #define PCA9685_RESTART       0x80 ' Has something to do with sleep mode. I don't
                                '  really get it.
     #define PCA9685_EXTCLK        0x40 ' Write to '1' to disable internal clock. Cannot
                                '  be reset to '0' without power cycle or reset.
     #define PCA9685_AI            0x20 ' Set to '1' to enable autoincrement register
                                '  during write operations. Defaults to '0'.
     #define PCA9685_SLEEP         0x10 ' Set to '0' to leave sleep and enable internal
                                '  oscillator. Defaults to '1' on boot.
     #define PCA9685_SUB1          0x08 ' Set to '1' to allow part to respond to address
     #define PCA9685_SUB2          0x04 '  in SUBADRx registers. Defaults to '0'.
     #define PCA9685_SUB3          0x02
     #define PCA9685_ALLCALL       0x01 ' Set to '1' to allow part to respond to address
                                '  in ALLCALL register. Defaults to '1'.

     #define PCA9685_MODE2         0x01
     #define PCA9685_INVRT         0x10 ' Write to '1' to invert output (i.e., a when the
                                '  pin is ON, the output will be low, or the
                                '  open-drain transistor will be off).
     #define PCA9685_OCH           0x08 ' '0' (default) is update PWM behavior on I2C STOP
                                ' '1' is update on I2C ACK
     #define PCA9685_OUTDRV        0x04 ' '0' is open-drain mode, '1' (default) is
                                '  totem-pole drive.
     #define PCA9685_OUTNE1        0x02 ' These bits affect behavior when OE is high and
     #define PCA9685_OUTNE0        0x01 '  the outputs are disabled.
                                ' 00 - Output is '0'
                                ' 01 - Output is '1' in totem-pole mode
                                '      Output is Hi-z in open drain mode
                                ' 1x - Output is Hi-z

    ' The SUBADR registers allow you to set a second (or third, or fourth) I2C
    ' address that the PCA9685 will respond to. Thus, you can set up multiple
    ' "subnets" on the I2C bus. These power up to 0xe2, 0xe4 and 0xe6, but can't
    ' be used until the SUBx bits in MODE1 are set.
    #define PCA9685_SUBADR1       0x02

    #define PCA9685_SUBADR2       0x03

    #define PCA9685_SUBADR3       0x04

    ' This register powers up with a value of 0xE0, allowing the user to access
    ' *all* PCA9685 devices on the bus by writing to address 0x70. This function
    ' is enabled by default, but can be disabled by clearing the ALLCALL bit in
    ' MODE1.
    #define PCA9685_ALLCALLADR    0x05

    ' Each channel has two 12-bit registers associated with it: ON and OFF. The
    ' PCA9685 has an internal 12-bit register which counts from 0-4095 and then
    ' overflows. When the ON register matches that counter, the pin asserts. When
    ' the OFF register matches, the pin de-asserts.
    #define PCA9685_LED0          0x06
    #define PCA9685_LED0_ON_L     0x06
    #define PCA9685_LED0_ON_H     0x07
    #define PCA9685_LED0_OFF_L    0x08
    #define PCA9685_LED0_OFF_H    0x09

    #define PCA9685_LED1          0x0a
    #define PCA9685_LED1_ON_L     0x0a
    #define PCA9685_LED1_ON_H     0x0b
    #define PCA9685_LED1_OFF_L    0x0c
    #define PCA9685_LED1_OFF_H    0x0d

    #define PCA9685_LED2          0x0e
    #define PCA9685_LED2_ON_L     0x0e
    #define PCA9685_LED2_ON_H     0x0f
    #define PCA9685_LED2_OFF_L    0x10
    #define PCA9685_LED2_OFF_H    0x11

    #define PCA9685_LED3          0x12
    #define PCA9685_LED3_ON_L     0x12
    #define PCA9685_LED3_ON_H     0x13
    #define PCA9685_LED3_OFF_L    0x14
    #define PCA9685_LED3_OFF_H    0x15

    #define PCA9685_LED4          0x16
    #define PCA9685_LED4_ON_L     0x16
    #define PCA9685_LED4_ON_H     0x17
    #define PCA9685_LED4_OFF_L    0x18
    #define PCA9685_LED4_OFF_H    0x19

    #define PCA9685_LED5          0x1a
    #define PCA9685_LED5_ON_L     0x1a
    #define PCA9685_LED5_ON_H     0x1b
    #define PCA9685_LED5_OFF_L    0x1c
    #define PCA9685_LED5_OFF_H    0x1d

    #define PCA9685_LED6          0x1e
    #define PCA9685_LED6_ON_L     0x1e
    #define PCA9685_LED6_ON_H     0x1f
    #define PCA9685_LED6_OFF_L    0x20
    #define PCA9685_LED6_OFF_H    0x21

    #define PCA9685_LED7          0x22
    #define PCA9685_LED7_ON_L     0x22
    #define PCA9685_LED7_ON_H     0x23
    #define PCA9685_LED7_OFF_L    0x24
    #define PCA9685_LED7_OFF_H    0x25

    #define PCA9685_LED8          0x26
    #define PCA9685_LED8_ON_L     0x26
    #define PCA9685_LED8_ON_H     0x27
    #define PCA9685_LED8_OFF_L    0x28
    #define PCA9685_LED8_OFF_H    0x29

    #define PCA9685_LED9          0x2a
    #define PCA9685_LED9_ON_L     0x2a
    #define PCA9685_LED9_ON_H     0x2b
    #define PCA9685_LED9_OFF_L    0x2c
    #define PCA9685_LED9_OFF_H    0x2d

    #define PCA9685_LED10         0x2e
    #define PCA9685_LED10_ON_L    0x2e
    #define PCA9685_LED10_ON_H    0x2f
    #define PCA9685_LED10_OFF_L   0x30
    #define PCA9685_LED10_OFF_H   0x31

    #define PCA9685_LED11         0x32
    #define PCA9685_LED11_ON_L    0x32
    #define PCA9685_LED11_ON_H    0x33
    #define PCA9685_LED11_OFF_L   0x34
    #define PCA9685_LED11_OFF_H   0x35

    #define PCA9685_LED12         0x36
    #define PCA9685_LED12_ON_L    0x36
    #define PCA9685_LED12_ON_H    0x37
    #define PCA9685_LED12_OFF_L   0x38
    #define PCA9685_LED12_OFF_H   0x39

    #define PCA9685_LED13         0x3a
    #define PCA9685_LED13_ON_L    0x3a
    #define PCA9685_LED13_ON_H    0x3b
    #define PCA9685_LED13_OFF_L   0x3c
    #define PCA9685_LED13_OFF_H   0x3d

    #define PCA9685_LED14         0x3e
    #define PCA9685_LED14_ON_L    0x3e
    #define PCA9685_LED14_ON_H    0x3f
    #define PCA9685_LED14_OFF_L   0x40
    #define PCA9685_LED14_OFF_H   0x41

    #define PCA9685_LED15         0x42
    #define PCA9685_LED15_ON_L    0x42
    #define PCA9685_LED15_ON_H    0x43
    #define PCA9685_LED15_OFF_L   0x44
    #define PCA9685_LED15_OFF_H   0x45

    ' These registers allow the user to load *all* the corresponding registers at
    ' the same time. This is useful for resetting all registers to zero or to a
    ' common brightness.
    #define PCA9685_ALL_LED_ON_L  0xfa
    #define PCA9685_ALL_LED_ON_H  0xfb
    #define PCA9685_ALL_LED_OFF_L 0xfc
    #define PCA9685_ALL_LED_OFF_H 0xfd

    #define PCA9685_ALL_CHANNELS  0xfa

    ' The PRE_SCALE register allows the user to set the PWM frequency. The
    ' equation for determining this value is
    '  PRE_SCALE = ((f_clk)/(4096*f_pwm))-1
    ' Of course, only positive integers are allowed, and futhermore, a minimum
    ' value of 3 is enforced on the value in this register.
    ' f_clk is, by default, 25MHz; external clocks can be applied.
    #define PCA9685_PRE_SCALE     0xfe


    ' Library specific constants to support ease of use
    #define PCA9685_LED_ON   0x1000
    #define PCA9685_LED_OFF  0x0000

    #define PCA9685_INTERNAL_CLOCK_FREQUENCY 25000000

    ' Servo angle calculation constants
    '  We want to give the user the ability to specify an angle (range 0 to 180)
    '  and have a servo simply move to that angle. Thus, we need two constants
    '  to do the scaling math: MIN_WIDTH and MAX_WIDTH. A pulse of MIN_WIDTH
    '  corresponds to an angle of 0, and MAX_WIDTH of 180. These values can vary
    '  across servo models; the defaults here are a swag.
    '  Servos expect a pulse train of varying duty cycle and 50Hz frequency; to
    '  get that frequency, we want to set the prescaler to 121, which makes the
    '  numbers below each represent ~4.5us per count.


Sub PCA9685_SetFreqency ( _localFrequency as Word, Optional In _localDevice as byte = PCA9685_ADDRESS_1 )

    'Protect the range - see the datasheet
    if _localFrequency < 24 then _localFrequency = 24
    if _localFrequency > 1526 then _localFrequency = 1526


    dim _localtempFrequency as long
    _localtempFrequency  = [long]4096 * [word]_localFrequency
    _localtempFrequency  = [long]_localtempFrequency   - 1
    _localtempFrequency  = [long]PCA9685_INTERNAL_CLOCK_FREQUENCY / [long]_localtempFrequency

    PCA9685_SetPrescaler ( _localtempFrequency, _localDevice )

End Sub





Sub PCA9685_SetChannelDuty( _localchannel as byte , _localduty as word, Optional In _localDevice as byte = PCA9685_ADDRESS_1 )
  ' Generic duty cycle setting. Automatically makes the start time 0, then
  '  calculates the number of counts needed to realize the appropriate duty
  '  cycle as nearly as possible.

  dim _offTime as long
  if _localduty < 100 then

      _offTime = 0
      if _localduty > 0 then
        _offTime = _localduty*4096
        _offTime = (_offTime/100)
      end if
      PCA9685_WriteChannel( _localchannel, [word]PCA9685_LED_OFF , [word]_offTime, _localDevice )
  else
      'force DUTY TO ON = 100%
      PCA9685_WriteChannel ( _localchannel, PCA9685_LED_ON, _localDevice )

  end if


End Sub

sub PCA9685_SetChannelOnOnly ( _localchannel as byte , _localValue as word, Optional In _localDevice as byte = PCA9685_ADDRESS_1 )
  'Just want to change the start time? This allows you to do that
  ' without worrying about what the stop time is, and without affecting it.

  dim _onTime , _offTime as word

  _onTime = PCA9685_ReadChannel( _localchannel, _localDevice )          'read a Word
  _offTime = PCA9685_ReadChannel( _localchannel + 2, _localDevice )     'read the next Word
  PCA9685_WriteChannel( _localchannel, _localValue, _offTime, _localDevice)

end Sub

sub PCA9685_SetChannelOffOnly ( _localchannel as byte , _localValue as word, Optional In _localDevice as byte = PCA9685_ADDRESS_1 )
  'Just want to change the start time? This allows you to do that
  ' without worrying about what the stop time is, and without affecting it.

  dim _onTime , _offTime as word

  _onTime = PCA9685_ReadChannel( _localchannel )          'read a Word
  _offTime = PCA9685_ReadChannel( _localchannel + 2 )     'read the next Word
  PCA9685_WriteChannel( _localchannel, _onTime, _localValue, _localDevice )

end Sub



Sub PCA9685_WriteChannel( _localregister as byte, _localValueOn as word, _localValueOff  as word, Optional In _localDevice as byte = PCA9685_ADDRESS_1 )

  'Requires Mode1.AI=1 and Mode1.OCH = 0 - these ARE MANDATED


  #ifdef HI2C_DATA
      do
        HI2CRESTART
        HI2CSend( _localDevice)
      loop While HI2CAckPollState
      HI2CSend( _localregister )
      HI2CSend( _localValueOn )
      HI2CSend( _localValueOn_h )
      HI2CSend( _localValueOff )
      HI2CSend( _localValueOff_h )
      HI2CStop
  #endif

  #ifdef I2C_DATA
      I2CSTART
      I2CSend( _localDevice)
      I2CSend( _localregister )
      I2CSend( _localValueOn )
      I2CSend( _localValueOn_h )
      I2CSend( _localValueOff )
      I2CSend( _localValueOff_h )
      I2CStop
  #endif



End Sub

sub PCA9685_EnableServoMode
'  Servo Mode means we're working at 50Hz, which is what most servos want. It
'   also means we've made the output non-inverted, although we leave it open
'   drain and let the pullup resistors handle the highs.

end Sub

sub PCA9685_SetServoAnglePulseLimits
'  We can alter the minimum and maximum servo pulse lengths because different
'   servo models may like different lengths. E.g., the one SparkFun sells as a
'   "sub-micro generic" likes a minimum of ~108 pulses and a max of ~450.

end Sub

sub PCA9685_GetServoAnglePulseLimits
'  We read the minimum and maximum servo pulse lengths because different
'   servo models may like different lengths. E.g., the one SparkFun sells as a
'   "sub-micro generic" likes a minimum of ~108 pulses and a max of ~450.

end Sub

sub PCA9685_SetServoAngleLimits

'  We can also alter the angle range. Again, taking the sub-micro generic as a
'   model, it has a range of about 160 degrees. Others may have more than 180,
'   or may use a gearing system.

end Sub

sub PCA9685_SetServoAngleLimits

'  We read the angle range. Again, taking the sub-micro generic as a
'   model, it has a range of about 160 degrees. Others may have more than 180,
'   or may use a gearing system.

end Sub

sub PCA9685_SetChannelAngle
'  Once we've set our angle and pulse limits (which set by default too a fairly
'   modest value), we can tell the servo what angle we want and feel fairly
'   assured that it will give us that angle.

end Sub



'Utility methods - these should not be changed

Sub PCA9685_SetPrescaler( _localPrescale as byte, Optional In _localDevice as byte = PCA9685_ADDRESS_1 )

  if _localPrescale < 3 then _localPrescale = 3 'this is the minimum value

  ' Set the prescaler. This requires some fancy twiddling of the SLEEP and
  '  PCA9685_RESTART bits in the MODE1 register; this function handles all of that.
  Dim modeReg as byte

  pca9685_writeReg ( PCA9685_ALL_LED_OFF_H, 0x10, _localDevice )

  ' Set the SLEEP bit, which stops the oscillator on the part.
  modeReg = PCA9685_readReg(PCA9685_MODE1, _localDevice)
  modeReg = modeReg OR PCA9685_SLEEP
  PCA9685_writeReg(PCA9685_MODE1, modeReg, _localDevice)


  ' This register can only be written when the oscillator is stopped.
  PCA9685_writeReg( PCA9685_PRE_SCALE, _localPrescale, _localDevice)


  ' Clear the sleep bit.
  modeReg = PCA9685_readReg(PCA9685_MODE1, _localDevice)
  modeReg.4 = 0
  PCA9685_writeReg(PCA9685_MODE1, modeReg, _localDevice)


  wait 500 us ' According to the datasheet, we must wait 500us before
               '  we touch the PCA9685_RESTART bit after touching the SLEEP bit.
               '  *Maybe* we can count on that much time elapsing in the
               '  I2C transaction, but let's be on the safe side.

  ' Set the PCA9685_RESTART bit which, counterintuitively, clears the actual PCA9685_RESTART
  '  bit in the register.
  modeReg = PCA9685_readReg(PCA9685_MODE1, _localDevice)
  modeReg = modeReg OR PCA9685_RESTART
  PCA9685_writeReg(PCA9685_MODE1, modeReg, _localDevice)

end sub

Function PCA9685_ReadReg (  _localregister, Optional In _localDevice as byte = PCA9685_ADDRESS_1 )

  #ifdef HI2C_DATA
      do
        HI2CRESTART
        HI2CSend( _localDevice )
      loop While HI2CAckPollState
      HI2CSend( _localregister )
      HI2CRESTART
      HI2CSend(  _localDevice+1)
      HI2CReceive PCA9685_readReg, nack
      HI2CStop
  #endif

  #ifdef I2C_DATA
      I2CSTART
      I2CSend(  _localDevice )
      I2CSend( _localregister )
      I2CRESTART
      I2CSend(  _localDevice+1)
      I2CReceive PCA9685_readReg, nack
      I2CStop
  #endif


End Function

Sub PCA9685_WriteReg ( _localregister, _localValue, Optional In _localDevice as byte = PCA9685_ADDRESS_1 )

  #ifdef HI2C_DATA
      do
        HI2CRESTART
        HI2CSend( _localDevice )
      loop While HI2CAckPollState
      HI2CSend( _localregister )
      HI2CSend( _localValue )
      HI2CStop
  #endif

  #ifdef I2C_DATA
      I2CSTART
      I2CSend( _localDevice )
      I2CSend( _localregister )
      I2CSend( _localValue )
      I2CStop
  #endif

End Sub





Sub PCA9685_WriteChannel( _localregister, _localValueOn as word, Optional In _localDevice as byte = PCA9685_ADDRESS_1  )

  'Requires Mode1.AI=1 and Mode1.OCH = 0 - these ARE MANDATED
  #ifdef HI2C_DATA
      do
        HI2CRESTART
        HI2CSend( _localDevice )
      loop While HI2CAckPollState
      HI2CSend( _localregister )
      HI2CSend( _localValueOn )
      HI2CSend( _localValueOn_h )
      HI2CSend( PCA9685_LED_OFF )
      HI2CSend( PCA9685_LED_OFF )
      HI2CStop
  #endif

  #ifdef I2C_DATA
      I2CSTART
      I2CSend( _localDevice )
      I2CSend( _localregister )
      I2CSend( _localValueOn )
      I2CSend( _localValueOn_h )
      I2CSend( PCA9685_LED_OFF )
      I2CSend( PCA9685_LED_OFF )
      I2CStop
  #endif


End Sub



Function PCA9685_ReadChannel( _localregister, Optional In _localDevice as byte = PCA9685_ADDRESS_1 ) as word

  'Requires Mode1.AI=1 and Mode1.OCH = 0 - these ARE MANDATED

  #ifdef HI2C_DATA
      do
        HI2CRESTART
        HI2CSend( _localDevice )
      loop While HI2CAckPollState
      HI2CSend( _localregister )
      HI2CRESTART
      HI2CSend( _localDevice +1)
      HI2CReceive PCA9685_ReadChannel, nack
      HI2CReceive PCA9685_ReadChannel_h, nack
      HI2CStop
  #endif

  #ifdef I2C_DATA
      I2CSTART
      I2CSend( _localDevice )
      I2CSend( _localregister )
      I2CRESTART
      I2CSend( _localDevice +1)
      I2CReceive PCA9685_ReadChannel, nack
      I2CReceive PCA9685_ReadChannel_h, nack
      I2CStop
  #endif


End Function


Sub PCA9685_Reset

  'The Software Reset Call (SWRST Call) allows all the devices in the I2C-bus to be reset to
  'the power-up state value through a specific formatted I2C-bus command. To be performed
  'correctly, it implies that the I2C-bus is functional and that there is no device hanging the
  'bus.
  'The SWRST Call function is defined as the following:
  '1. A START command is sent by the I2C-bus master.
  '2. The reserved SWRST I2C-bus address 0000 000 with the R/W bit set to 0 (write) is
  'sent by the I2C-bus master.
  '3. The PCA9685 device(s) acknowledge(s) after seeing the General Call address
  '0000 0000 (00h) only. If the R/W bit is set to 1 (read), no acknowledge is returned to
  'the I2C-bus master.
  '4. Once the General Call address has been sent and acknowledged, the master sends
  '1 byte with 1 specific value (SWRST data byte 1):
  'a. Byte 1 = 06h: the PCA9685 acknowledges this value only. If byte 1 is not equal to
  '06h, the PCA9685 does not acknowledge it.
  'If more than 1 byte of data is sent, the PCA9685 does not acknowledge any more.
  '5. Once the correct byte (SWRST data byte 1) has been sent and correctly
  'acknowledged, the master sends a STOP command to end the SWRST Call: the
  'PCA9685 then resets to the default value (power-up value) and is ready to be
  'addressed again within the specified bus free time (tBUF).

      #ifdef HI2C_DATA
        HI2CSTART
        HI2CSend(0x00)     'all call
        HI2CSend(0x06)     'reset the parts
        HI2CStop
      #endif

      #ifdef I2C_DATA
        I2CSTART
        I2CSend(0x00)     'all call
        I2CSend(0x06)     'reset the parts
        I2CStop
        #endif

End Sub


Sub PCA9685_Initialise

  'There maybe times when you dont want to reset
  #ifndef Prevent_PCA9685_Reset
    PCA9685_Reset
  #endif

  #ifdef PCA9685_ADDRESS_1

     'Set the autoincrement regiser bit
      pca9685_WriteReg ( PCA9685_MODE1, PCA9685_AI, PCA9685_ADDRESS_1 )

      'Set the initial prescaler
      pca9685_SetPrescaler ( PCA9685_SERVO_PRESCALER, PCA9685_ADDRESS_1 )

  #endif

  #ifdef PCA9685_ADDRESS_2

     'Set the autoincrement regiser bit
      pca9685_WriteReg ( PCA9685_MODE1, PCA9685_AI, PCA9685_ADDRESS_2 )

      'Set the initial prescaler
      pca9685_SetPrescaler ( PCA9685_SERVO_PRESCALER, PCA9685_ADDRESS_2 )

  #endif

  #ifdef PCA9685_ADDRESS_3

     'Set the autoincrement regiser bit
      pca9685_WriteReg ( PCA9685_MODE1, PCA9685_AI, PCA9685_ADDRESS_3 )

      'Set the initial prescaler
      pca9685_SetPrescaler ( PCA9685_SERVO_PRESCALER, PCA9685_ADDRESS_3 )

  #endif

  #ifdef PCA9685_ADDRESS_4

     'Set the autoincrement regiser bit
      pca9685_WriteReg ( PCA9685_MODE1, PCA9685_AI, PCA9685_ADDRESS_4  )

      'Set the initial prescaler
      pca9685_SetPrescaler ( PCA9685_SERVO_PRESCALER, PCA9685_ADDRESS_4 )

  #endif


End Sub



#script
    'Sets PCA9685_SERVO_PRESCALER constant

    'See section 7.3.5 PWM frequency PRE_SCALE of the datasheet
    PCA9685_SERVO_PRESCALER = int(((PCA9685_INTERNAL_CLOCK_FREQUENCY)/(4096*PWM_Freq*0.95))-1)

    'Check the setting
    if PCA9685_SERVO_PRESCALER > 255 then
      if PWM_Freq <> 24 then
        Warning "PCA9685_SERVO_PRESCALER: PWM_FREQ outside of operational frequency"
        Warning "PCA9685_SERVO_PRESCALER: PWM_FREQ  is 24 hz to 1526 hz."
        Warning "PCA9685_SERVO_PRESCALER: PWM_FREQ  set to 24..1526"
      end if
      'Force 24hz as the calculation over estimates the setting.
      PCA9685_SERVO_PRESCALER = 255
    end if

#endscript

