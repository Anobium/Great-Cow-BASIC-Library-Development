'    Software PCF85x3 routines for the GCBASIC compiler
'
'    This library is free software' you can redistribute it and/or
'    modify it under the terms of the GNU Lesser General Public
'    License as published by the Free Software Foundation' either
'    version 2.1 of the License, or (at your option) any later version.
'
'    This library is distributed in the hope that it will be useful,
'    but WITHOUT ANY WARRANTY' without even the implied warranty of
'    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
'    Lesser General Public License for more details.
'
'    You should have received a copy of the GNU Lesser General Public
'    License along with this library' if not, write to the
'    Free Software ' Foundation, Inc., 51 Franklin St, Fifth Floor,
'    Boston, MA  02110-1301  USA
'
'    10 bytes are used as input and output parameters.
'    They are:
'       DS_Value, DS_Addr, DS_Hour, DS_Min, DS_Sec,
'       DS_Date, DS_Month, DS_Year and DS_DOW.
'
'    Quick Command Reference:
'
'    PCF85x3_Enable(flag)
'    PCF85x3_ResetClock
'    PCF85x3_SetClock(hour, minute, second, DOW, date, month, year)
'    PCF85x3_SetTime(hour, minute, second)
'    PCF85x3_SetDate(DOW, date, month, year)
'    PCF85x3_ReadClock(hour, minute, second, a.m.|p.m., DOW, date, month, year)
'    PCF85x3_ReadTime(hour, minute, second, a.m.|p.m.)
'    PCF85x3_ReadDate(DOW, date, month, year)
'
;See the subroutine definitions below for full details on each.

;----- Constants
 ' These are the I2C addresses of the generic PCF85x3 Real-Time Clock
 #define DS_AddrWrite 0xA2
 #define DS_AddrRead  0xA3


  #define  PCF85x3_DEFAULT_SEC         0
  #define  PCF85x3_DEFAULT_MIN         0
  #define  PCF85x3_DEFAULT_HOUR        0

  #define  PCF85x3_DEFAULT_DAY         1
  #define  PCF85x3_DEFAULT_WEEKDAY     2
  #define  PCF85x3_DEFAULT_MONTH       1
  #define  PCF85x3_DEFAULT_YEAR        19

  'Registers
  #define  PCF85x3_CTRL_REG_1          0x00
  #define  PCF85x3_CTRL_REG_1_STOPBIT  0x05

  #define  PCF85x3_CTRL_REG_2          0x01
  #define  PCF85x3_VL_SEC_REG          0x02
  #define  PCF85x3_MINS_REG            0x03
  #define  PCF85x3_HOURS_REG           0x04
  #define  PCF85x3_DAYS_REG            0x05
  #define  PCF85x3_WKDAY_REG           0x06
  #define  PCF85x3_CNTRY_MONTHS_REG    0x07
  #define  PCF85x3_YEARS_REG           0x08
  #define  PCF85x3_MINS_ALARM_REG      0x09
  #define  PCF85x3_HOURS_ALARM_REG     0x0A
  #define  PCF85x3_DAY_ALARM_REG       0x0B
  #define  PCF85x3_WKDAY_ALARM_REG     0x0C
  #define  PCF85x3_CLKOUT_CTRL_REG     0x0D
  #define  PCF85x3_CLKOUT_CTRL_REG_ENABLEBIT     0x07
  #define  PCF85x3_TIMER_CTRL_REG      0x0E
  #define  PCF85x3_TIMER_REG           0x0F

  'Register masks
  #define  PCF85x3_CTRL_REG_1_MASK     0xFF
  #define  PCF85x3_CTRL_REG_2_MASK     0xFF
  #define  PCF85x3_SEC_REG_MASK        0x7F
  #define  PCF85x3_VL_REG_MASK         0x80
  #define  PCF85x3_MINS_REG_MASK                   0x7F
  #define  PCF85x3_HOURS_REG_MASK                  0x3F
  #define  PCF85x3_DAYS_REG_MASK                   0x3F
  #define  PCF85x3_WKDAY_REG_MASK                  0x03
  #define  PCF85x3_MONTHS_REG_MASK                 0x1F
  #define  PCF85x3_CNTRY_REG_MASK                  0x80
  #define  PCF85x3_YEARS_REG_MASK                  0xFF
  #define  PCF85x3_MINS_ALARM_REG_MASK             0x7F
  #define  PCF85x3_ENABLE_MINS_ALARM_REG_MASK      0x80
  #define  PCF85x3_HOURS_ALARM_REG_MASK            0x3F
  #define  PCF85x3_ENABLE_HOURS_ALARM_REG_MASK     0x80
  #define  PCF85x3_DAY_ALARM_REG_MASK              0x3F
  #define  PCF85x3_ENABLE_DAY_ALARM_REG_MASK       0x80
  #define  PCF85x3_WKDAY_ALARM_REG_MASK            0x07
  #define  PCF85x3_ENABLE_WKDAY_ALARM_REG_MASK     0x80
  #define  PCF85x3_ENABLE_CLKOUT_CTRL_REG_MASK     0x80

  #define  PCF85x3_FREQUENCY_CLKOUT_CTRL_REG_MASK  0x03
  #define  PCF85x3_ENABLE_TIMER_CTRL_REG_MASK      0x80
  #define  PCF85x3_FREQUENCY_TIMER_CTRL_REG_MASK   0x03
  #define  PCF85x3_TIMER_REG_MASK                  0xFF

  '  32.768 kHz (default), 1.024 kHz, 32 Hz, and 1 Hz
  #define  PCF85x3_CLKOUT_CTRL_REG_32_768_kHz     0x00
  #define  PCF85x3_CLKOUT_CTRL_REG_1_024_kHz      0x01
  #define  PCF85x3_CLKOUT_CTRL_REG_32_Hz          0x02
  #define  PCF85x3_CLKOUT_CTRL_REG_1_Hz           0x03

  #define  PCF85x3_ALARM_ENABLE                   0x80


 #define PCF85x3_Alarm_Off                                     0x00
 #define PCF85x3_AlarmAssertion_Minute                         0x01
 #define PCF85x3_AlarmAssertion_Hour                           0x02
 #define PCF85x3_AlarmAssertion_Date                           0x04               ;Set by passing correct data
 #define PCF85x3_AlarmAssertion_DoW                            0x08
                ;Set by passing correct data
 #define PCF85x3_AlarmAssertion_MinuteHour                     0x03


;-----

sub PCF85x3_Enable( optional in DS_Value  = true )

  dim DS_EnableState as byte alias DS_Sec

  #ifdef HI2C_DATA

     do
        HI2CReStart                                   ;generate a start signal
        HI2CSend(DS_AddrWrite)                        ;indicate a write
     loop While HI2CAckPollState
     HI2CSend(PCF85x3_CTRL_REG_1)                     ;indicate register
     HI2CReStart
     HI2CSend(DS_AddrRead)
     HI2CReceive(DS_EnableState, NACK)                ;get theregiser
     if DS_Value.1 then
      set DS_EnableState.PCF85x3_CTRL_REG_1_STOPBIT off              ;enables
     else
      set DS_EnableState.PCF85x3_CTRL_REG_1_STOPBIT on             ;disables
     end if
     HI2CReStart
     HI2CSend(DS_AddrWrite)
     HI2CSend(PCF85x3_CTRL_REG_1)                     ;indicate register
     HI2CSend(DS_EnableState)                         ;now send updated value
     HI2CStop
  #endif


  #ifdef I2C_DATA
    ;Enables clock if DS_Value = TRUE, disables if DS_Value = FALSE
     I2CStart
     I2CSend(DS_AddrWrite)
     I2CSend( PCF85x3_CTRL_REG_1 )                     ;indicate register 0
     I2CStart
     I2CSend(DS_AddrRead)
     I2CReceive(DS_EnableState, NACK)       ;get the current seconds
     if DS_Value.1 then
      set DS_EnableState.PCF85x3_CTRL_REG_1_STOPBIT off              ;enables
     else
      set DS_EnableState.PCF85x3_CTRL_REG_1_STOPBIT on             ;disables
     end if
     I2CStart
     I2CSend(DS_AddrWrite)
     I2CSend( PCF85x3_CTRL_REG_1 )                     ;indicate register 0
     I2CSend(DS_EnableState)                ;now send updated value
     I2CStop
  #endif

end sub

;-----

sub PCF85x3_ResetClock
  ;Reset clock to default date/Time

  #ifdef HI2C_DATA

    do
        HI2CReStart                          ;generate a start signal
        HI2CSend(DS_AddrWrite)                     ;inidcate a write
    loop While HI2CAckPollState
    HI2CSend(PCF85x3_VL_SEC_REG)              ;begin
    HI2CSend(DecToBcd ( PCF85x3_DEFAULT_SEC ))                      ;then set the seven
    HI2CSend(DecToBcd ( PCF85x3_DEFAULT_MIN ))                      ;consecutive locations
    HI2CSend(DecToBcd ( PCF85x3_DEFAULT_HOUR ))
    HI2CSend( DecToBcd ( PCF85x3_DEFAULT_DAY ) )
    HI2CSend( DecToBcd ( PCF85x3_DEFAULT_WEEKDAY ) )
    HI2CSend( DecToBcd ( PCF85x3_DEFAULT_MONTH ) )
    HI2CSend( DecToBcd ( PCF85x3_DEFAULT_YEAR ) )
    HI2CStop

  #endif

  #ifdef I2C_DATA
    I2CStart
    I2CSend(DS_AddrWrite)
    I2CSend(PCF85x3_VL_SEC_REG)                      ;begin
    I2CSend(DecToBcd ( PCF85x3_DEFAULT_SEC ))                      ;then set the seven
    I2CSend(DecToBcd ( PCF85x3_DEFAULT_MIN ))                      ;consecutive locations
    I2CSend(DecToBcd ( PCF85x3_DEFAULT_HOUR ))
    I2CSend( DecToBcd ( PCF85x3_DEFAULT_DAY ) )
    I2CSend( DecToBcd ( PCF85x3_DEFAULT_WEEKDAY ) )
    I2CSend( DecToBcd ( PCF85x3_DEFAULT_MONTH ) )
    I2CSend( DecToBcd ( PCF85x3_DEFAULT_YEAR ) )
    I2CStop
  #endif
end sub

;-----

sub PCF85x3_SetClock(in DS_Hour, in DS_Min, in DS_Sec, in DS_DOW, in DS_Date, in DS_Month, in DS_Year)
  ;Set entire clock: hours, minutes, seconds, day of week, date, month, year

  #ifdef HI2C_DATA

    do
       HI2CReStart                          ;generate a start signal
       HI2CSend(DS_AddrWrite)                     ;inidcate a write
    loop While HI2CAckPollState
    HI2CSend( PCF85x3_VL_SEC_REG )   ;begin
    HI2CSend(DecToBcd(DS_Sec))       ;then set the seven
    HI2CSend(DecToBcd(DS_Min))       ;consecutive values
    HI2CSend(DecToBcd(DS_Hour))
    HI2CSend(DecToBcd(DS_Date))
    HI2CSend(DecToBcd(DS_DOW))
    HI2CSend(DecToBcd(DS_Month))
    HI2CSend(DecToBcd(DS_Year))
    HI2CStop
  #endif

  #ifdef I2C_DATA
    I2CStart
    I2CSend(DS_AddrWrite)
    I2CSend( PCF85x3_VL_SEC_REG )   ;begin
    I2CSend(DecToBcd(DS_Sec))       ;then set the seven
    I2CSend(DecToBcd(DS_Min))       ;consecutive values
    I2CSend(DecToBcd(DS_Hour))
    I2CSend(DecToBcd(DS_Date))
    I2CSend(DecToBcd(DS_DOW))
    I2CSend(DecToBcd(DS_Month))
    I2CSend(DecToBcd(DS_Year))
    I2CStop
  #endif
end sub

;-----

sub PCF85x3_SetTime(in DS_Hour, in DS_Min, in DS_Sec)
  ;Set time only: hours, minutes, seconds.
  ;Also sets 24-hour mode and enables the clock.

  #ifdef HI2C_DATA

    do
        HI2CReStart                          ;generate a start signal
        HI2CSend(DS_AddrWrite)                     ;inidcate a write
    loop While HI2CAckPollState
    HI2CSend( PCF85x3_VL_SEC_REG )   ;begin
    HI2CSend(DecToBcd(DS_Sec))       ;then set the three
    HI2CSend(DecToBcd(DS_Min))       ;consecutive values
    HI2CSend(DecToBcd(DS_Hour))
    HI2CStop
  #endif


  #ifdef I2C_DATA
    I2CStart
    I2CSend(DS_AddrWrite)
    I2CSend( PCF85x3_VL_SEC_REG )   ;begin
    I2CSend(DecToBcd(DS_Sec))       ;then set the three
    I2CSend(DecToBcd(DS_Min))       ;consecutive values
    I2CSend(DecToBcd(DS_Hour))
    I2CStop
  #endif
end sub

;-----

sub PCF85x3_SetDate(in DS_DOW, DS_Date, in DS_Month, in DS_Year)
  ;Set date only: day of week, date, month, year
  ;There is no error detection for out-of-range dates.

  #ifdef HI2C_DATA

     do
        HI2CReStart                          ;generate a start signal
        HI2CSend(DS_AddrWrite)                     ;inidcate a write
     loop While HI2CAckPollState
    HI2CSend( PCF85x3_DAYS_REG )                     ;begin with at this address
    HI2CSend(DecToBcd(DS_Date))      ;consecutive values
    HI2CSend(DecToBcd(DS_DOW))       ;then set the four
    HI2CSend(DecToBcd(DS_Month))
    HI2CSend(DecToBcd(DS_Year))
    HI2CStop
  #endif


  #ifdef I2C_DATA
    I2CStart
    I2CSend(DS_AddrWrite)
    I2CSend( PCF85x3_DAYS_REG )                      ;begin with at this address
    I2CSend(DecToBcd(DS_Date))      ;consecutive values
    I2CSend(DecToBcd(DS_DOW))       ;then set the four
    I2CSend(DecToBcd(DS_Month))
    I2CSend(DecToBcd(DS_Year))
    I2CStop
  #endif

 end sub

;-----

sub PCF85x3_SetAlarm(in DS_Hour, in DS_Min, in DS_DOW, in DS_Date)
  ;Set entire alarm: hours, minutes, day of week, date

  #ifdef HI2C_DATA

    do
       HI2CReStart                          ;generate a start signal
       HI2CSend(DS_AddrWrite)                     ;inidcate a write
    loop While HI2CAckPollState
    HI2CSend( PCF85x3_MINS_ALARM_REG )   ;begin
    HI2CSend(DecToBcd(DS_Min))       ;consecutive values
    HI2CSend(DecToBcd(DS_Hour))
    HI2CSend(DecToBcd(DS_Date))
    HI2CSend(DecToBcd(DS_DOW))
    HI2CStop
  #endif

  #ifdef I2C_DATA
    I2CStart
    I2CSend(DS_AddrWrite)
    I2CSend( PCF85x3_MINS_ALARM_REG )   ;begin
    I2CSend(DecToBcd(DS_Min))       ;consecutive values
    I2CSend(DecToBcd(DS_Hour))
    I2CSend(DecToBcd(DS_Date))
    I2CSend(DecToBcd(DS_DOW))
    I2CStop
  #endif
end sub

;-----

sub PCF85x3_SetAlarm(in DS_Hour, in DS_Min)
  ;Set alarm: hours, minutes

  #ifdef HI2C_DATA

    do
       HI2CReStart                          ;generate a start signal
       HI2CSend(DS_AddrWrite)                     ;inidcate a write
    loop While HI2CAckPollState
    HI2CSend( PCF85x3_MINS_ALARM_REG )   ;begin
    HI2CSend(DecToBcd(DS_Min))       ;consecutive values
    HI2CSend(DecToBcd(DS_Hour))
    HI2CStop
  #endif

  #ifdef I2C_DATA
    I2CStart
    I2CSend(DS_AddrWrite)
    I2CSend( PCF85x3_MINS_ALARM_REG )   ;begin
    I2CSend(DecToBcd(DS_Min))       ;consecutive values
    I2CSend(DecToBcd(DS_Hour))
    I2CStop
  #endif
end sub

;-----

sub PCF85x3_SetAlarm( in DS_Min)
  ;Set alarm: hours, minutes

  #ifdef HI2C_DATA

    do
       HI2CReStart                          ;generate a start signal
       HI2CSend(DS_AddrWrite)                     ;inidcate a write
    loop While HI2CAckPollState
    HI2CSend( PCF85x3_MINS_ALARM_REG )   ;begin
    HI2CSend(DecToBcd(DS_Min))
    HI2CSend( 0 )
    HI2CStop
  #endif

  #ifdef I2C_DATA
    I2CStart
    I2CSend(DS_AddrWrite)
    I2CSend( PCF85x3_MINS_ALARM_REG )   ;begin
    I2CSend(DecToBcd(DS_Min))
    I2CSend( 0 )
    I2CStop
  #endif

end sub

;-----

sub PCF85x3_EnableAlarm(in DS_Enableval as byte)

'      'read register by register and set appropoiate bit 7 of the correct register
      'minute
      PCF85x3_ReadRegister( PCF85x3_MINS_ALARM_REG, DS_EnableState )
      DS_EnableState.7 = !DS_Enableval.0
      PCF85x3_WriteRegister( PCF85x3_MINS_ALARM_REG, DS_EnableState)

      'hours
      PCF85x3_ReadRegister( PCF85x3_HOURS_ALARM_REG, DS_EnableState )
      DS_EnableState.7 = !DS_Enableval.1
      PCF85x3_WriteRegister( PCF85x3_HOURS_ALARM_REG, DS_EnableState )

      'day of the month
      PCF85x3_ReadRegister( PCF85x3_DAY_ALARM_REG, DS_EnableState )
      DS_EnableState.7 = !DS_Enableval.2
      PCF85x3_WriteRegister( PCF85x3_DAY_ALARM_REG, DS_EnableState )

      'day of the week
      PCF85x3_ReadRegister( PCF85x3_WKDAY_ALARM_REG, DS_EnableState )
      DS_EnableState.7 = !DS_Enableval.3
      PCF85x3_WriteRegister( PCF85x3_WKDAY_ALARM_REG, DS_EnableState )

end sub

;-----

;-----

sub PCF85x3_ClearAlarm

      dim DS_EnableState as byte alias DS_Sec

'      'read register by register and set appropoiate bit of the correct register

      PCF85x3_ReadRegister( PCF85x3_CTRL_REG_2, DS_EnableState )
      DS_EnableState.3 =  0
      PCF85x3_WriteRegister( PCF85x3_CTRL_REG_2, DS_EnableState)

end sub

function PCF85x3_AlarmState

      'read register by register and read appropoiate bit of the correct register
      PCF85x3_ReadRegister( PCF85x3_CTRL_REG_2, DS_EnableState )
      PCF85x3_AlarmState = DS_EnableState.3

end function

sub PCF85x3_WriteRegister(in DS_reg, in DS_val)
  ;Set value - should be in BCD

  #ifdef HI2C_DATA

    do
       HI2CReStart                          ;generate a start signal
       HI2CSend(DS_AddrWrite)                     ;inidcate a write
    loop While HI2CAckPollState
    HI2CSend( DS_reg )   ;begin
    HI2CSend( DS_val )   ;value
    HI2CStop
  #endif

  #ifdef I2C_DATA
    I2CStart
    I2CSend(DS_AddrWrite)
    I2CSend( DS_reg )   ;begin
    I2CSend( DS_val )   ;value
    I2CStop
  #endif
end sub

sub PCF85x3_ReadRegister(in DS_reg, out DS_val)

  #ifdef HI2C_DATA

    do
       HI2CReStart                          ;generate a start signal
       HI2CSend(DS_AddrWrite)                     ;inidcate a write
    loop While HI2CAckPollState
    HI2CSend( DS_reg )   ;begin
    HI2CReStart
    HI2CSend(DS_AddrRead)
    HI2CReceive(DS_val, NACK)
    HI2CStop
  #endif

  #ifdef I2C_DATA
    I2CStart
    I2CSend(DS_AddrWrite)
    I2CSend( DS_reg )   ;begin
    I2CStart
    I2CSend(DS_AddrRead)
    I2CReceive(DS_val, NACK)
    I2CStop
  #endif
end sub

;-----

sub PCF85x3_ReadClock(out DS_Hour, out DS_Min, out DS_Sec, out DS_DOW, out DS_Date, out DS_Month, out DS_Year)
;Read entire clock: hours, minutes, seconds, day of week, date, month, year


  #ifdef HI2C_DATA

     do
        HI2CReStart                          ;generate a start signal
        HI2CSend(DS_AddrWrite)                     ;inidcate a write
     loop While HI2CAckPollState
    HI2CSend( PCF85x3_VL_SEC_REG )                      ;begin
    HI2CReStart
    HI2CSend(DS_AddrRead)
    HI2CReceive(DS_Sec)              ;get seconds
    DS_Sec = BcdToDec(DS_Sec & PCF85x3_SEC_REG_MASK ) ;strip off VL bit

    HI2CReceive(DS_Min)              ;get minutes
    DS_Min = BcdToDec(DS_Min & PCF85x3_MINS_REG_MASK )       ;bit 7 is always 0

    HI2CReceive(DS_Hour)             ;get hours
    DS_Hour = BcdToDec(DS_Hour & PCF85x3_HOURS_REG_MASK )

    HI2CReceive(DS_Date)             ;get date
    DS_Date = BcdToDec(DS_Date  & PCF85x3_DAYS_REG_MASK)

    HI2CReceive(DS_DOW)              ;get day of week
    DS_DOW = BcdToDec(DS_DOW & PCF85x3_WKDAY_REG_MASK )

    HI2CReceive(DS_Month)            ;get month
    DS_Month = BcdToDec(DS_Month & PCF85x3_MONTHS_REG_MASK)

    HI2CReceive(DS_Year, NACK)       ;get year
    DS_Year = BcdToDec(DS_Year & PCF85x3_YEARS_REG_MASK)
    HI2CStop

  #endif


  #ifdef I2C_DATA
    I2CStart
    I2CSend(DS_AddrWrite)
    I2CSend( PCF85x3_VL_SEC_REG )                      ;begin
    I2CStart
    I2CSend(DS_AddrRead)
    I2CReceive(DS_Sec, ACK)              ;get seconds
    DS_Sec = BcdToDec(DS_Sec & PCF85x3_SEC_REG_MASK ) ;strip off VL bit

    I2CReceive(DS_Min, ACK)              ;get minutes
    DS_Min = BcdToDec(DS_Min & PCF85x3_MINS_REG_MASK )       ;bit 7 is always 0

    I2CReceive(DS_Hour, ACK)             ;get hours
    DS_Hour = BcdToDec(DS_Hour & PCF85x3_HOURS_REG_MASK )


    I2CReceive(DS_Date, ACK)             ;get date
    DS_Date = BcdToDec(DS_Date  & PCF85x3_DAYS_REG_MASK)

    I2CReceive(DS_DOW, ACK)              ;get day of week
    DS_DOW = BcdToDec(DS_DOW & PCF85x3_WKDAY_REG_MASK )

    I2CReceive(DS_Month, ACK)            ;get month
    DS_Month = BcdToDec(DS_Month & PCF85x3_MONTHS_REG_MASK)

    I2CReceive(DS_Year, NACK)       ;get year
    DS_Year = BcdToDec(DS_Year & PCF85x3_YEARS_REG_MASK)
    I2CStop
  #endif
 end sub

;-----
'ported
sub PCF85x3_ReadTime(out DS_Hour, out DS_Min, out DS_Sec)

  #ifdef HI2C_DATA

     do
        HI2CReStart                          ;generate a start signal
        HI2CSend(DS_AddrWrite)                     ;inidcate a write
     loop While HI2CAckPollState
    HI2CSend( PCF85x3_VL_SEC_REG )                      ;begin
    HI2CReStart
    HI2CSend(DS_AddrRead)
    HI2CReceive(DS_Sec)              ;get seconds
    DS_Sec = BcdToDec(DS_Sec & PCF85x3_SEC_REG_MASK ) ;strip off VL bit

    HI2CReceive(DS_Min)              ;get minutes
    DS_Min = BcdToDec(DS_Min  & PCF85x3_MINS_REG_MASK)       ;bit 7 is always 0

    HI2CReceive(DS_Hour, NACK)             ;get hours
    DS_Hour = BcdToDec(DS_Hour & PCF85x3_HOURS_REG_MASK )
    HI2CStop

  #endif


  #ifdef I2C_DATA
    I2CStart
    I2CSend(DS_AddrWrite)
    I2CSend( PCF85x3_VL_SEC_REG )                      ;begin
    I2CStart
    I2CSend(DS_AddrRead)
    I2CReceive(DS_Sec, ACK)              ;get seconds
    DS_Sec = BcdToDec(DS_Sec & PCF85x3_SEC_REG_MASK ) ;strip off VL bit

    I2CReceive(DS_Min, ACK)              ;get minutes
    DS_Min = BcdToDec(DS_Min & PCF85x3_MINS_REG_MASK)       ;bit 7 is always 0

    I2CReceive(DS_Hour, ACK)             ;get hours
    DS_Hour = BcdToDec(DS_Hour & PCF85x3_HOURS_REG_MASK )

    I2CStop
  #endif
end sub
;-----
'Ported
sub PCF85x3_ReadDate(out DS_DOW, out DS_Date, out DS_Month, out DS_Year)
;Get date only: day of week, date, month, year

  #ifdef HI2C_DATA

     do
        HI2CReStart                          ;generate a start signal
        HI2CSend(DS_AddrWrite)                     ;inidcate a write
     loop While HI2CAckPollState
    HI2CSend( PCF85x3_DAYS_REG )                      ;begin
    HI2CReStart
    HI2CSend(DS_AddrRead)

    HI2CReceive(DS_Date)             ;get date
    DS_Date = BcdToDec(DS_Date  & PCF85x3_DAYS_REG_MASK)

    HI2CReceive(DS_DOW)              ;get day of week
    DS_DOW = BcdToDec(DS_DOW & PCF85x3_WKDAY_REG_MASK )

    HI2CReceive(DS_Month)            ;get month
    DS_Month = BcdToDec(DS_Month & PCF85x3_MONTHS_REG_MASK)

    HI2CReceive(DS_Year, NACK)       ;get year
    DS_Year = BcdToDec(DS_Year & PCF85x3_YEARS_REG_MASK)
    HI2CStop

  #endif


  #ifdef I2C_DATA
    I2CStart
    I2CSend(DS_AddrWrite)
    I2CSend( PCF85x3_DAYS_REG )                      ;begin
    I2CStart
    I2CSend(DS_AddrRead)

    I2CReceive(DS_Date, ACK)             ;get date
    DS_Date = BcdToDec(DS_Date  & PCF85x3_DAYS_REG_MASK)

    I2CReceive(DS_DOW, ACK)              ;get day of week
    DS_DOW = BcdToDec(DS_DOW & PCF85x3_WKDAY_REG_MASK )

    I2CReceive(DS_Month, ACK)            ;get month
    DS_Month = BcdToDec(DS_Month & PCF85x3_MONTHS_REG_MASK)

    I2CReceive(DS_Year, NACK)       ;get year
    DS_Year = BcdToDec(DS_Year & PCF85x3_YEARS_REG_MASK)
    I2CStop
  #endif
end sub

;-----

Function PCF85x3_ReadVL


  #ifdef HI2C_DATA

     do
        HI2CReStart                          ;generate a start signal
        HI2CSend(DS_AddrWrite)                     ;inidcate a write
     loop While HI2CAckPollState
    HI2CSend( PCF85x3_VL_SEC_REG )                      ;begin
    HI2CReStart
    HI2CSend(DS_AddrRead)
    HI2CReceive(DS_Sec, NACK)              ;get seconds
    PCF85x3_ReadVL = BcdToDec(DS_Sec & PCF85x3_VL_REG_MASK ) ;strip off VL bit
    HI2CStop

  #endif


  #ifdef I2C_DATA
    I2CStart
    I2CSend(DS_AddrWrite)
    I2CSend( PCF85x3_VL_SEC_REG )                      ;begin
    I2CStart
    I2CSend(DS_AddrRead)
    I2CReceive(DS_Sec, NACK)              ;get seconds
    PCF85x3_ReadVL = BcdToDec(DS_Sec & PCF85x3_VL_REG_MASK ) ;strip off VL bit
    I2CStop

  #endif

End Function

;-----


sub PCF85x3_EnableClockout ( optional in DS_Value  = true )


  dim DS_EnableState as byte alias DS_Sec

  #ifdef HI2C_DATA

     do
        HI2CReStart                                   ;generate a start signal
        HI2CSend(DS_AddrWrite)                        ;indicate a write
     loop While HI2CAckPollState
     HI2CSend(PCF85x3_CLKOUT_CTRL_REG)                     ;indicate register
     HI2CReStart
     HI2CSend(DS_AddrRead)
     HI2CReceive(DS_EnableState, NACK)                ;get theregiser
     if DS_Value.1 then
      set DS_EnableState.PCF85x3_CLKOUT_CTRL_REG_ENABLEBIT on              ;enables
     else
      set DS_EnableState.PCF85x3_CLKOUT_CTRL_REG_ENABLEBIT off             ;disables
     end if
     HI2CReStart
     HI2CSend(DS_AddrWrite)
     HI2CSend(PCF85x3_CLKOUT_CTRL_REG)                     ;indicate register
     HI2CSend(DS_EnableState)                         ;now send updated value
     HI2CStop
  #endif


  #ifdef I2C_DATA
    ;Enables clock if DS_Value = TRUE, disables if DS_Value = FALSE
     I2CStart
     I2CSend(DS_AddrWrite)
     I2CSend( PCF85x3_CLKOUT_CTRL_REG )                     ;indicate register 0
     I2CStart
     I2CSend(DS_AddrRead)
     I2CReceive(DS_EnableState, NACK)       ;get the current seconds
     if DS_Value.1 then
      set DS_EnableState.PCF85x3_CLKOUT_CTRL_REG_ENABLEBIT off              ;enables
     else
      set DS_EnableState.PCF85x3_CLKOUT_CTRL_REG_ENABLEBIT on             ;disables
     end if
     I2CStart
     I2CSend(DS_AddrWrite)
     I2CSend( PCF85x3_CLKOUT_CTRL_REG )                     ;indicate register 0
     I2CSend(DS_EnableState)                ;now send updated value
     I2CStop
  #endif

end sub
;-----


sub PCF85x3_EnableClockoutFrequency(in DS_Value)

  'use DS_Sec as a temp variable

  #ifdef HI2C_DATA

     do
        HI2CReStart                          ;generate a start signal
        HI2CSend(DS_AddrWrite)                     ;inidcate a write
     loop While HI2CAckPollState
     HI2CSend(PCF85x3_CLKOUT_CTRL_REG)                     ;indicate register CLKOUT_CTRL_REG
     HI2CReStart
     HI2CSend(DS_AddrRead)
     HI2CReceive(DS_Sec, NACK)       ;get the current
     DS_Sec = DS_Sec and 0xFC        ;mask the lower two bits
     DS_Sec = DS_Sec or DS_Value     ;or the lower two bits
     HI2CReStart
     HI2CSend(DS_AddrWrite)
     HI2CSend(PCF85x3_CLKOUT_CTRL_REG)                     ;indicate register
     HI2CSend(DS_Sec)                ;now send updated value
     HI2CStop
  #endif


  #ifdef I2C_DATA
    ;Enables clock if DS_Value = TRUE, disables if DS_Value = FALSE
     I2CStart
     I2CSend(DS_AddrWrite)
     I2CSend( PCF85x3_CLKOUT_CTRL_REG )                     ;indicate register
     I2CStart
     I2CSend(DS_AddrRead)
     I2CReceive(DS_Sec, NACK)       ;get the current
     DS_Sec = DS_Sec and 0xFC        ;mask the lower two bits
     DS_Sec = DS_Sec or DS_Value     ;or the lower two bits
     I2CStart
     I2CSend(DS_AddrWrite)
     I2CSend( PCF85x3_CLKOUT_CTRL_REG )                     ;indicate register
     I2CSend(DS_Sec)                ;now send updated value
     I2CStop
  #endif

end sub


;-----

function DecToBcd(in va ) as byte
  ;Convert pure decimal number to binary coded decimal
  DecToBcd=( va /10)*16+ va % 10
end function

;-----

function BcdToDec(in va ) as byte
  ;Convert binary coded decimal to pure decimal
  BcdToDec=( va /16)*10+ ( va % 16 )
end function
