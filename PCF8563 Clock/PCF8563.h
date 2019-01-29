
'    Software PCF8563 routines for the GCBASIC compiler
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
'       DS_A_P, DS_Date, DS_Month, DS_Year and DS_DOW.
'
'    Quick Command Reference:
'
'    PCF8563_Enable(flag)
'    PCF8563_ResetClock
'    PCF8563_SetClock(hour, minute, second, DOW, date, month, year)
'    PCF8563_SetTime(hour, minute, second)
'    PCF8563_SetDate(DOW, date, month, year)
'    PCF8563_ReadClock(hour, minute, second, a.m.|p.m., DOW, date, month, year)
'    PCF8563_ReadTime(hour, minute, second, a.m.|p.m.)
'    PCF8563_ReadDate(DOW, date, month, year)
'    PCF8563_SetHourMode(12|24)
'    PCF8563_ReadHourMode(12|24)
'    PCF8563_SetSQW(rate)
'    PCF8563_Write(address, value)
'    PCF8563_Read(address, value)
;See the subroutine definitions below for full details on each.

;----- Constants
 ' These are the I2C addresses of the generic PCF8563 Real-Time Clock
 #define DS_AddrWrite 0xA2
 #define DS_AddrRead  0xA3


  #define  PCD8563_DEFAULT_SEC         0
  #define  PCD8563_DEFAULT_MIN         0
  #define  PCD8563_DEFAULT_HOUR        0

  #define  PCD8563_DEFAULT_DAY         1
  #define  PCD8563_DEFAULT_WEEKDAY     2
  #define  PCD8563_DEFAULT_MONTH       1
  #define  PCD8563_DEFAULT_YEAR        19

  'Registers
  #define  PCD8563_CTRL_REG_1          0x00
  #define  PCD8563_CTRL_REG_1_STOPBIT  0x05

  #define  PCD8563_CTRL_REG_2          0x01
  #define  PCD8563_VL_SEC_REG          0x02
  #define  PCD8563_MINS_REG            0x03
  #define  PCD8563_HOURS_REG           0x04
  #define  PCD8563_DAYS_REG            0x05
  #define  PCD8563_WKDAY_REG           0x06
  #define  PCD8563_CNTRY_MONTHS_REG    0x07
  #define  PCD8563_YEARS_REG           0x08
  #define  PCD8563_MINS_ALARM_REG      0x09
  #define  PCD8563_HOURS_ALARM_REG     0x0A
  #define  PCD8563_DAY_ALARM_REG       0x0B
  #define  PCD8563_WKDAY_ALARM_REG     0x0C
  #define  PCD8563_CLKOUT_CTRL_REG     0x0D
  #define  PCD8563_TIMER_CTRL_REG      0x0E
  #define  PCD8563_TIMER_REG           0x0F

  'Register masks
  #define  PCD8563_CTRL_REG_1_MASK     0xFF
  #define  PCD8563_CTRL_REG_2_MASK     0xFF
  #define  PCD8563_SEC_REG_MASK        0x7F
  #define  PCD8563_VL_REG_MASK         0x80
  #define  PCD8563_MINS_REG_MASK                   0x7F
  #define  PCD8563_HOURS_REG_MASK                  0x3F
  #define  PCD8563_DAYS_REG_MASK                   0x3F
  #define  PCD8563_WKDAY_REG_MASK                  0x03
  #define  PCD8563_MONTHS_REG_MASK                 0x1F
  #define  PCD8563_CNTRY_REG_MASK                  0x80
  #define  PCD8563_YEARS_REG_MASK                  0xFF
  #define  PCD8563_MINS_ALARM_REG_MASK             0x7F
  #define  PCD8563_ENABLE_MINS_ALARM_REG_MASK      0x80
  #define  PCD8563_HOURS_ALARM_REG_MASK            0x3F
  #define  PCD8563_ENABLE_HOURS_ALARM_REG_MASK     0x80
  #define  PCD8563_DAY_ALARM_REG_MASK              0x3F
  #define  PCD8563_ENABLE_DAY_ALARM_REG_MASK       0x80
  #define  PCD8563_WKDAY_ALARM_REG_MASK            0x07
  #define  PCD8563_ENABLE_WKDAY_ALARM_REG_MASK     0x80
  #define  PCD8563_ENABLE_CLKOUT_CTRL_REG_MASK     0x80
  #define  PCD8563_FREQUENCY_CLKOUT_CTRL_REG_MASK  0x03
  #define  PCD8563_ENABLE_TIMER_CTRL_REG_MASK      0x80
  #define  PCD8563_FREQUENCY_TIMER_CTRL_REG_MASK   0x03
  #define  PCD8563_TIMER_REG_MASK                  0xFF

  '  32.768 kHz (default), 1.024 kHz, 32 Hz, and 1 Hz
  #define  PCD8563_CLKOUT_CTRL_REG_32_768_kHz     0x00
  #define  PCD8563_CLKOUT_CTRL_REG_1_024_kHz      0x01
  #define  PCD8563_CLKOUT_CTRL_REG_32_Hz          0x02
  #define  PCD8563_CLKOUT_CTRL_REG_1_Hz           0x03



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

;-----

sub PCF8563_Enable( optional in DS_Value  = true )

  dim DS_EnableState as byte alias DS_Sec

  #ifdef HI2C_DATA

     do
        HI2CReStart                                   ;generate a start signal
        HI2CSend(DS_AddrWrite)                        ;indicate a write
     loop While HI2CAckPollState
     HI2CSend(PCD8563_CTRL_REG_1)                     ;indicate register
     HI2CReStart
     HI2CSend(DS_AddrRead)
     HI2CReceive(DS_EnableState, NACK)                ;get theregiser
     if DS_Value.1 then
      set DS_EnableState.PCD8563_CTRL_REG_1_STOPBIT off              ;enables
     else
      set DS_EnableState.PCD8563_CTRL_REG_1_STOPBIT on             ;disables
     end if
     HI2CReStart
     HI2CSend(DS_AddrWrite)
     HI2CSend(PCD8563_CTRL_REG_1)                     ;indicate register
     HI2CSend(DS_EnableState)                         ;now send updated value
     HI2CStop
  #endif


  #ifdef I2C_DATA
    ;Enables clock if DS_Value = TRUE, disables if DS_Value = FALSE
     I2CStart
     I2CSend(DS_AddrWrite)
     I2CSend( PCD8563_VL_SEC_REG )                     ;indicate register 0
     I2CStart
     I2CSend(DS_AddrRead)
     I2CReceive(DS_Sec, NACK)       ;get the current seconds
     if DS_Value then
      set DS_Sec.7 off              ;CH bit = 0 enables
     else
      set DS_Sec.7 on               ;CH bit = 1 disables
     end if
     I2CStart
     I2CSend(DS_AddrWrite)
     I2CSend( PCD8563_VL_SEC_REG )                     ;indicate register 0
     I2CSend(DS_Sec)                ;now send updated value
     I2CStop
  #endif

end sub


sub PCF8563_EnableClockoutFrequency(in DS_Value)

  'use DS_Sec as a temp variable

  #ifdef HI2C_DATA

     do
        HI2CReStart                          ;generate a start signal
        HI2CSend(DS_AddrWrite)                     ;inidcate a write
     loop While HI2CAckPollState
     HI2CSend(CLKOUT_CTRL_REG)                     ;indicate register CLKOUT_CTRL_REG
     HI2CReStart
     HI2CSend(DS_AddrRead)
     HI2CReceive(DS_Sec, NACK)       ;get the current seconds
     DS_Sec = DS_Sec and 0xFC        ;mask the lower two bits
     DS_Sec = DS_Sec or DS_Value     ;or the lower two bits
     HI2CReStart
     HI2CSend(DS_AddrWrite)
     HI2CSend(CLKOUT_CTRL_REG)                     ;indicate register 0
     HI2CSend(DS_Sec)                ;now send updated value
     HI2CStop
  #endif


  #ifdef I2C_DATA
    ;Enables clock if DS_Value = TRUE, disables if DS_Value = FALSE
     I2CStart
     I2CSend(DS_AddrWrite)
     I2CSend( PCD8563_VL_SEC_REG )                     ;indicate register
     I2CStart
     I2CSend(DS_AddrRead)
     I2CReceive(DS_Sec, NACK)       ;get the current seconds
     DS_Sec = DS_Sec and 0xFC        ;mask the lower two bits
     DS_Sec = DS_Sec or DS_Value     ;or the lower two bits
     I2CStart
     I2CSend(DS_AddrWrite)
     I2CSend( PCD8563_VL_SEC_REG )                     ;indicate register
     I2CSend(DS_Sec)                ;now send updated value
     I2CStop
  #endif

end sub
;-----

sub PCF8563_ResetClock
  ;Reset clock to default date/Time

  #ifdef HI2C_DATA

    do
        HI2CReStart                          ;generate a start signal
        HI2CSend(DS_AddrWrite)                     ;inidcate a write
    loop While HI2CAckPollState
    HI2CSend(PCD8563_VL_SEC_REG)              ;begin
    HI2CSend(DecToBcd ( PCD8563_DEFAULT_SEC ))                      ;then set the seven
    HI2CSend(DecToBcd ( PCD8563_DEFAULT_MIN ))                      ;consecutive locations
    HI2CSend(DecToBcd ( PCD8563_DEFAULT_HOUR ))
    HI2CSend( DecToBcd ( PCD8563_DEFAULT_DAY ) )
    HI2CSend( DecToBcd ( PCD8563_DEFAULT_WEEKDAY ) )
    HI2CSend( DecToBcd ( PCD8563_DEFAULT_MONTH ) )
    HI2CSend( DecToBcd ( PCD8563_DEFAULT_YEAR ) )
    HI2CStop

  #endif

  #ifdef I2C_DATA
    I2CStart
    I2CSend(DS_AddrWrite)
    I2CSend(PCD8563_VL_SEC_REG)                      ;begin
    I2CSend(DecToBcd ( PCD8563_DEFAULT_SEC ))                      ;then set the seven
    I2CSend(DecToBcd ( PCD8563_DEFAULT_MIN ))                      ;consecutive locations
    I2CSend(DecToBcd ( PCD8563_DEFAULT_HOUR ))
    I2CSend( DecToBcd ( PCD8563_DEFAULT_DAY ) )
    I2CSend( DecToBcd ( PCD8563_DEFAULT_WEEKDAY ) )
    I2CSend( DecToBcd ( PCD8563_DEFAULT_MONTH ) )
    I2CSend( DecToBcd ( PCD8563_DEFAULT_YEAR ) )
    I2CStop
  #endif
end sub

;-----

sub PCF8563_SetClock(in DS_Hour, in DS_Min, in DS_Sec, in DS_DOW, in DS_Date, in DS_Month, in DS_Year)
  ;Set entire clock: hours, minutes, seconds, day of week, date, month, year
  ;Also sets 24-hour mode and enables the clock.

  #ifdef HI2C_DATA

    do
       HI2CReStart                          ;generate a start signal
       HI2CSend(DS_AddrWrite)                     ;inidcate a write
    loop While HI2CAckPollState
    HI2CSend( PCD8563_VL_SEC_REG )   ;begin
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
    I2CSend( PCD8563_VL_SEC_REG )   ;begin
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

sub PCF8563_SetTime(in DS_Hour, in DS_Min, in DS_Sec)
  ;Set time only: hours, minutes, seconds.
  ;Also sets 24-hour mode and enables the clock.

  #ifdef HI2C_DATA

    do
        HI2CReStart                          ;generate a start signal
        HI2CSend(DS_AddrWrite)                     ;inidcate a write
    loop While HI2CAckPollState
    HI2CSend( PCD8563_VL_SEC_REG )   ;begin
    HI2CSend(DecToBcd(DS_Sec))       ;then set the three
    HI2CSend(DecToBcd(DS_Min))       ;consecutive values
    HI2CSend(DecToBcd(DS_Hour))
    HI2CStop
  #endif


  #ifdef I2C_DATA
    I2CStart
    I2CSend(DS_AddrWrite)
    I2CSend( PCD8563_VL_SEC_REG )   ;begin
    I2CSend(DecToBcd(DS_Sec))       ;then set the three
    I2CSend(DecToBcd(DS_Min))       ;consecutive values
    I2CSend(DecToBcd(DS_Hour))
    I2CStop
  #endif
end sub

;-----

sub PCF8563_SetDate(in DS_DOW, DS_Date, in DS_Month, in DS_Year)
  ;Set date only: day of week, date, month, year
  ;There is no error detection for out-of-range dates.

  #ifdef HI2C_DATA

     do
        HI2CReStart                          ;generate a start signal
        HI2CSend(DS_AddrWrite)                     ;inidcate a write
     loop While HI2CAckPollState
    HI2CSend( PCD8563_DAYS_REG )                     ;begin with at this address
    HI2CSend(DecToBcd(DS_Date))      ;consecutive values
    HI2CSend(DecToBcd(DS_DOW))       ;then set the four
    HI2CSend(DecToBcd(DS_Month))
    HI2CSend(DecToBcd(DS_Year))
    HI2CStop
  #endif


  #ifdef I2C_DATA
    I2CStart
    I2CSend(DS_AddrWrite)
    I2CSend( PCD8563_DAYS_REG )                      ;begin with at this address
    I2CSend(DecToBcd(DS_Date))      ;consecutive values
    I2CSend(DecToBcd(DS_DOW))       ;then set the four
    I2CSend(DecToBcd(DS_Month))
    I2CSend(DecToBcd(DS_Year))
    I2CStop
  #endif

 end sub

;-----

sub PCF8563_ReadClock(out DS_Hour, out DS_Min, out DS_Sec, out DS_DOW, out DS_Date, out DS_Month, out DS_Year)
;Read entire clock: hours, minutes, seconds, day of week, date, month, year


  #ifdef HI2C_DATA

     do
        HI2CReStart                          ;generate a start signal
        HI2CSend(DS_AddrWrite)                     ;inidcate a write
     loop While HI2CAckPollState
    HI2CSend( PCD8563_VL_SEC_REG )                      ;begin
    HI2CReStart
    HI2CSend(DS_AddrRead)
    HI2CReceive(DS_Sec)              ;get seconds
    DS_Sec = BcdToDec(DS_Sec & PCD8563_SEC_REG_MASK ) ;strip off VL bit

    HI2CReceive(DS_Min)              ;get minutes
    DS_Min = BcdToDec(DS_Min & PCD8563_MINS_REG_MASK )       ;bit 7 is always 0

    HI2CReceive(DS_Hour)             ;get hours
    DS_Hour = BcdToDec(DS_Hour & PCD8563_HOURS_REG_MASK )

    HI2CReceive(DS_Date)             ;get date
    DS_Date = BcdToDec(DS_Date  & PCD8563_DAYS_REG_MASK)

    HI2CReceive(DS_DOW)              ;get day of week
    DS_DOW = BcdToDec(DS_DOW & PCD8563_WKDAY_REG_MASK )

    HI2CReceive(DS_Month)            ;get month
    DS_Month = BcdToDec(DS_Month & PCD8563_MONTHS_REG_MASK)

    HI2CReceive(DS_Year, NACK)       ;get year
    DS_Year = BcdToDec(DS_Year & PCD8563_YEARS_REG_MASK)
    HI2CStop

  #endif


  #ifdef I2C_DATA
    I2CStart
    I2CSend(DS_AddrWrite)
    I2CSend( PCD8563_VL_SEC_REG )                      ;begin
    I2CStart
    I2CSend(DS_AddrRead)
    I2CReceive(DS_Sec, ACK)              ;get seconds
    DS_Sec = BcdToDec(DS_Sec & PCD8563_SEC_REG_MASK ) ;strip off VL bit

    I2CReceive(DS_Min, ACK)              ;get minutes
    DS_Min = BcdToDec(DS_Min & PCD8563_MINS_REG_MASK )       ;bit 7 is always 0

    I2CReceive(DS_Hour, ACK)             ;get hours
    DS_Hour = BcdToDec(DS_Hour & PCD8563_HOURS_REG_MASK )


    I2CReceive(DS_Date, ACK)             ;get date
    DS_Date = BcdToDec(DS_Date  & PCD8563_DAYS_REG_MASK)

    I2CReceive(DS_DOW, ACK)              ;get day of week
    DS_DOW = BcdToDec(DS_DOW & PCD8563_WKDAY_REG_MASK )

    I2CReceive(DS_Month, ACK)            ;get month
    DS_Month = BcdToDec(DS_Month & PCD8563_MONTHS_REG_MASK)

    I2CReceive(DS_Year, NACK)       ;get year
    DS_Year = BcdToDec(DS_Year & PCD8563_YEARS_REG_MASK)
    I2CStop
  #endif
 end sub

;-----
'ported
sub PCF8563_ReadTime(out DS_Hour, out DS_Min, out DS_Sec)

  #ifdef HI2C_DATA

     do
        HI2CReStart                          ;generate a start signal
        HI2CSend(DS_AddrWrite)                     ;inidcate a write
     loop While HI2CAckPollState
    HI2CSend( PCD8563_VL_SEC_REG )                      ;begin
    HI2CReStart
    HI2CSend(DS_AddrRead)
    HI2CReceive(DS_Sec)              ;get seconds
    DS_Sec = BcdToDec(DS_Sec & PCD8563_SEC_REG_MASK ) ;strip off VL bit

    HI2CReceive(DS_Min)              ;get minutes
    DS_Min = BcdToDec(DS_Min  & PCD8563_MINS_REG_MASK)       ;bit 7 is always 0

    HI2CReceive(DS_Hour, NACK)             ;get hours
    DS_Hour = BcdToDec(DS_Hour & PCD8563_HOURS_REG_MASK )
    HI2CStop

  #endif


  #ifdef I2C_DATA
    I2CStart
    I2CSend(DS_AddrWrite)
    I2CSend( PCD8563_VL_SEC_REG )                      ;begin
    I2CStart
    I2CSend(DS_AddrRead)
    I2CReceive(DS_Sec, ACK)              ;get seconds
    DS_Sec = BcdToDec(DS_Sec & PCD8563_SEC_REG_MASK ) ;strip off VL bit

    I2CReceive(DS_Min, ACK)              ;get minutes
    DS_Min = BcdToDec(DS_Min & PCD8563_MINS_REG_MASK)       ;bit 7 is always 0

    I2CReceive(DS_Hour, ACK)             ;get hours
    DS_Hour = BcdToDec(DS_Hour & PCD8563_HOURS_REG_MASK )

    I2CStop
  #endif
end sub
;-----
'Ported
sub PCF8563_ReadDate(out DS_DOW, out DS_Date, out DS_Month, out DS_Year)
;Get date only: day of week, date, month, year

  #ifdef HI2C_DATA

     do
        HI2CReStart                          ;generate a start signal
        HI2CSend(DS_AddrWrite)                     ;inidcate a write
     loop While HI2CAckPollState
    HI2CSend( PCD8563_DAYS_REG )                      ;begin
    HI2CReStart
    HI2CSend(DS_AddrRead)

    HI2CReceive(DS_Date)             ;get date
    DS_Date = BcdToDec(DS_Date  & PCD8563_DAYS_REG_MASK)

    HI2CReceive(DS_DOW)              ;get day of week
    DS_DOW = BcdToDec(DS_DOW & PCD8563_WKDAY_REG_MASK )

    HI2CReceive(DS_Month)            ;get month
    DS_Month = BcdToDec(DS_Month & PCD8563_MONTHS_REG_MASK)

    HI2CReceive(DS_Year, NACK)       ;get year
    DS_Year = BcdToDec(DS_Year & PCD8563_YEARS_REG_MASK)
    HI2CStop

  #endif


  #ifdef I2C_DATA
    I2CStart
    I2CSend(DS_AddrWrite)
    I2CSend( PCD8563_DAYS_REG )                      ;begin
    I2CStart
    I2CSend(DS_AddrRead)

    I2CReceive(DS_Date, ACK)             ;get date
    DS_Date = BcdToDec(DS_Date  & PCD8563_DAYS_REG_MASK)

    I2CReceive(DS_DOW, ACK)              ;get day of week
    DS_DOW = BcdToDec(DS_DOW & PCD8563_WKDAY_REG_MASK )

    I2CReceive(DS_Month, ACK)            ;get month
    DS_Month = BcdToDec(DS_Month & PCD8563_MONTHS_REG_MASK)

    I2CReceive(DS_Year, NACK)       ;get year
    DS_Year = BcdToDec(DS_Year & PCD8563_YEARS_REG_MASK)
    I2CStop
  #endif
end sub

;-----

sub PCF8563_SetSQW(in DS_Value)
  ;Set square wave output pin mode

  #ifdef HI2C_DATA

     do
        HI2CReStart                          ;generate a start signal
        HI2CSend(DS_AddrWrite)                     ;inidcate a write
     loop While HI2CAckPollState
    HI2CSend(9)                      ;location is address 7
    select case DS_Value
       case 0                       ;0 = disable completely
            HI2CSend(0)
       case 4                       ;4 = 4.096kHz
            HI2CSend(17)
       case 8                       ;8 = 8.192kHz
            HI2CSend(18)
       case 32                      ;32 = 32.768kHz
            HI2CSend(19)
       case else                    ;anything else defaults to 1 Hz
            HI2CSend(16)
    end select
    HI2CStop
  #endif

  #ifdef I2C_DATA
    I2CStart
    I2CSend(DS_AddrWrite)
    I2CSend(9)                      ;location is address 7
    select case DS_Value
       case 0                       ;0 = disable completely
            I2CSend(0)
       case 4                       ;4 = 4.096kHz
            I2CSend(17)
       case 8                       ;8 = 8.192kHz
            I2CSend(18)
       case 32                      ;32 = 32.768kHz
            I2CSend(19)
       case else                    ;anything else defaults to 1 Hz
            I2CSend(16)
    end select
    I2CStop
  #endif
end sub
