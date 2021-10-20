'    CanBus MCP2515 routines for the GCBASIC compiler
'    Copyright (C) 2011-2020 Angel Mier

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
'

'Changes:
' date: 10/06/2021 Alpha (For a sneak peak)
' date: 10/19/2021 Beta release. Better code readability, added capability for multiple module usage (up to 4), added new commands (LoadBuffer, SendBuffer, SetRollover, GetErrorStatus, SetInterrupts, ClrAllInt, Clr*****Int), minor bugs fixed.

'Initialisation routine
  #startup CanBus_Init

'Constants

  ''' CAN Bus BitRate configs for 8mhz xtal
  #define C1000kBPS_CFG1 0x00
  #define C1000kBPS_CFG2 0x80
  #define C1000kBPS_CFG3 0x80

  #define C500kBPS_CFG1 0x00
  #define C500kBPS_CFG2 0x90
  #define C500kBPS_CFG3 0x82

  #define C250kBPS_CFG1 0x00
  #define C250kBPS_CFG2 0xB1
  #define C250kBPS_CFG3 0x85

  #define C200kBPS_CFG1 0x00
  #define C200kBPS_CFG2 0xB4
  #define C200kBPS_CFG3 0x86

  #define C125kBPS_CFG1 0x01
  #define C125kBPS_CFG2 0xB1
  #define C125kBPS_CFG3 0x85

  #define C100kBPS_CFG1 0x01
  #define C100kBPS_CFG2 0xB4
  #define C100kBPS_CFG3 0x86

  #define C80kBPS_CFG1 0x01
  #define C80kBPS_CFG2 0xBF
  #define C80kBPS_CFG3 0x87

  #define C50kBPS_CFG1 0x03
  #define C50kBPS_CFG2 0xB4
  #define C50kBPS_CFG3 0x86

  #define C40kBPS_CFG1 0x03
  #define C40kBPS_CFG2 0xBF
  #define C40kBPS_CFG3 0x87

  #define C33k3BPS_CFG1 0x47
  #define C33k3BPS_CFG2 0xE2
  #define C33k3BPS_CFG3 0x85

  #define C31kBPS_CFG1 0x07
  #define C31kBPS_CFG2 0xA4
  #define C31kBPS_CFG3 0x84

  #define C20kBPS_CFG1 0x07
  #define C20kBPS_CFG2 0xBF
  #define C20kBPS_CFG3 0x87

  #define C10kBPS_CFG1 0x0F
  #define C10kBPS_CFG2 0xBF
  #define C10kBPS_CFG3 0x87

  #define C5kBPS_CFG1 0x1F
  #define C5kBPS_CFG2 0xBF
  #define C5kBPS_CFG3 0x87

  ''' MCP2515 modes
  #define CANCTRL_REQOP_NORMAL      0x00
  #define CANCTRL_REQOP_SLEEP       0x20
  #define CANCTRL_REQOP_LOOPBACK    0x40
  #define CANCTRL_REQOP_LISTENONLY  0x60
  #define CANCTRL_REQOP_CONFIG      0x80
  #define CANCTRL_REQOP_POWERUP     0xE0

  ''' MCP2515 CanCtrl
  #define CANCTRL_REQOP   0xE0
  #define CANCTRL_ABAT    0x10
  #define CANCTRL_OSM     0x08
  #define CANCTRL_CLKEN   0x04
  #define CANCTRL_CLKPRE  0x03

  ''' MCP2515 Instructions
  #define INSTRUCTION_WRITE        0x02
  #define INSTRUCTION_READ         0x03
  #define INSTRUCTION_BITMOD       0x05
  #define INSTRUCTION_LOAD_TX0     0x40
  #define INSTRUCTION_LOAD_TX1     0x42
  #define INSTRUCTION_LOAD_TX2     0x44
  #define INSTRUCTION_RTS_TX0      0x81
  #define INSTRUCTION_RTS_TX1      0x82
  #define INSTRUCTION_RTS_TX2      0x84
  #define INSTRUCTION_RTS_ALL      0x87
  #define INSTRUCTION_READ_RX0     0x90
  #define INSTRUCTION_READ_RX1     0x94
  #define INSTRUCTION_READ_STATUS  0xA0
  #define INSTRUCTION_RX_STATUS    0xB0
  #define INSTRUCTION_RESET        0xC0

  ''' MCP2515 Registers
  #define MCP_RXF0SIDH  0x00
  #define MCP_RXF0SIDL  0x01
  #define MCP_RXF0EID8  0x02
  #define MCP_RXF0EID0  0x03
  #define MCP_RXF1SIDH  0x04
  #define MCP_RXF1SIDL  0x05
  #define MCP_RXF1EID8  0x06
  #define MCP_RXF1EID0  0x07
  #define MCP_RXF2SIDH  0x08
  #define MCP_RXF2SIDL  0x09
  #define MCP_RXF2EID8  0x0A
  #define MCP_RXF2EID0  0x0B
  #define MCP_CANSTAT   0x0E
  #define MCP_CANCTRL   0x0F
  #define MCP_RXF3SIDH  0x10
  #define MCP_RXF3SIDL  0x11
  #define MCP_RXF3EID8  0x12
  #define MCP_RXF3EID0  0x13
  #define MCP_RXF4SIDH  0x14
  #define MCP_RXF4SIDL  0x15
  #define MCP_RXF4EID8  0x16
  #define MCP_RXF4EID0  0x17
  #define MCP_RXF5SIDH  0x18
  #define MCP_RXF5SIDL  0x19
  #define MCP_RXF5EID8  0x1A
  #define MCP_RXF5EID0  0x1B
  #define MCP_TEC       0x1C
  #define MCP_REC       0x1D
  #define MCP_RXM0SIDH  0x20
  #define MCP_RXM0SIDL  0x21
  #define MCP_RXM0EID8  0x22
  #define MCP_RXM0EID0  0x23
  #define MCP_RXM1SIDH  0x24
  #define MCP_RXM1SIDL  0x25
  #define MCP_RXM1EID8  0x26
  #define MCP_RXM1EID0  0x27
  #define MCP_CNF3      0x28
  #define MCP_CNF2      0x29
  #define MCP_CNF1      0x2A
  #define MCP_CANINTE   0x2B
  #define MCP_CANINTF   0x2C
  #define MCP_EFLG      0x2D
  #define MCP_TXB0CTRL  0x30
  #define MCP_TXB0SIDH  0x31
  #define MCP_TXB0SIDL  0x32
  #define MCP_TXB0EID8  0x33
  #define MCP_TXB0EID0  0x34
  #define MCP_TXB0DLC   0x35
  #define MCP_TXB0DATA  0x36
  #define MCP_TXB1CTRL  0x40
  #define MCP_TXB1SIDH  0x41
  #define MCP_TXB1SIDL  0x42
  #define MCP_TXB1EID8  0x43
  #define MCP_TXB1EID0  0x44
  #define MCP_TXB1DLC   0x45
  #define MCP_TXB1DATA  0x46
  #define MCP_TXB2CTRL  0x50
  #define MCP_TXB2SIDH  0x51
  #define MCP_TXB2SIDL  0x52
  #define MCP_TXB2EID8  0x53
  #define MCP_TXB2EID0  0x54
  #define MCP_TXB2DLC   0x55
  #define MCP_TXB2DATA  0x56
  #define MCP_RXB0CTRL  0x60
  #define MCP_RXB0SIDH  0x61
  #define MCP_RXB0SIDL  0x62
  #define MCP_RXB0EID8  0x63
  #define MCP_RXB0EID0  0x64
  #define MCP_RXB0DLC   0x65
  #define MCP_RXB0DATA  0x66
  #define MCP_RXB1CTRL  0x70
  #define MCP_RXB1SIDH  0x71
  #define MCP_RXB1SIDL  0x72
  #define MCP_RXB1EID8  0x73
  #define MCP_RXB1EID0  0x74
  #define MCP_RXB1DLC   0x75
  #define MCP_RXB1DATA  0x76


  'MCP2515 CANINTF Masks
  #define CANINTF_RX0IF  0x01
  #define CANINTF_RX1IF  0x02
  #define CANINTF_TX0IF  0x04
  #define CANINTF_TX1IF  0x08
  #define CANINTF_TX2IF  0x10
  #define CANINTF_ERRIF  0x20
  #define CANINTF_WAKIF  0x40
  #define CANINTF_MERRF  0x80

  'MCP2515 RXBnCTRL Masks
  #define RXBnCTRL_RXM_STD      0x20
  #define RXBnCTRL_RXM_EXT      0x40
  #define RXBnCTRL_RXM_STDEXT   0x00
  #define RXBnCTRL_RXM_MASK     0x60
  #define RXBnCTRL_RTR          0x08
  #define RXB0CTRL_BUKT         0x04
  #define RXB0CTRL_FILHIT_MASK  0x03
  #define RXB1CTRL_FILHIT_MASK  0x07
  #define RXB0CTRL_FILHIT       0x00
  #define RXB1CTRL_FILHIT       0x01


  'Default Configs
  #define DEFAULT_CANINTE   0x03

  'vars
  Dim CanBus_ReadBuffer (8) as Byte
  Dim CanBus_Module as Byte




'Subs
Sub CanBus_Init ()
  #IFDEF CanBus_CS


    CanBus_SetSPI

    CanBus_Module = 0

    #IFDEF CanBus_BitRate
      CanBus_SetBusBitrate CanBus_BitRate
    #endif
    #IFNDEF CanBus_BitRate
      CanBus_SetBusBitrate 10
    #endif

    #IFDEF CanBus_CS1
      CanBus_Module = 1
      #IFDEF CanBus_BitRate1
        CanBus_SetBusBitrate CanBus_BitRate1
      #endif
      #IFNDEF CanBus_BitRate
        CanBus_SetBusBitrate 10
      #endif
    #endif
    #IFDEF CanBus_CS2
      CanBus_Module = 2
      #IFDEF CanBus_BitRate2
        CanBus_SetBusBitrate CanBus_BitRate2
      #endif
      #IFNDEF CanBus_BitRate
        CanBus_SetBusBitrate 10
      #endif
    #endif
    #IFDEF CanBus_CS3
      CanBus_Module = 3
      #IFDEF CanBus_BitRate3
        CanBus_SetBusBitrate CanBus_BitRate3
      #endif
      #IFNDEF CanBus_BitRate
        CanBus_SetBusBitrate 10
      #endif
    #endif

    CanBus_Module = 0

  #endif

end sub


Sub CanBus_Reset ()
  #IFDEF CanBus_CS
    CanBus_CSoff


    CanBus_SendData INSTRUCTION_RESET

    CanBus_CSon

    CanBus_ReadBuffer = 0,0,0,0,0,0,0,0

    wait 15 ms

    CanBus_CSoff
    CanBus_SendData INSTRUCTION_WRITE
    CanBus_SendData MCP_TXB0CTRL
    repeat 14
      CanBus_SendData 0
    end repeat
    CanBus_CSon

    CanBus_CSoff
    CanBus_SendData INSTRUCTION_WRITE
    CanBus_SendData MCP_TXB1CTRL
    repeat 14
      CanBus_SendData 0
    end repeat
    CanBus_CSon

    CanBus_CSoff
    CanBus_SendData INSTRUCTION_WRITE
    CanBus_SendData MCP_TXB2CTRL
    repeat 14
      CanBus_SendData 0
    end repeat
    CanBus_CSon


    CanBus_SetRegister MCP_RXB0CTRL, RXBnCTRL_RXM_STDEXT
    CanBus_SetRegister MCP_RXB1CTRL, RXBnCTRL_RXM_STDEXT

    ' set caninte 00000011 enable interrupts on rxb0 & rxb1
    CanBus_SetRegister MCP_CANINTE, DEFAULT_CANINTE

    'add clear filters and mask code
    CanBus_CSoff
    CanBus_SendData INSTRUCTION_WRITE
    CanBus_SendData MCP_RXF0SIDH
    repeat 4
      CanBus_SendData 0
    end repeat
    CanBus_CSon

    CanBus_CSoff
    CanBus_SendData INSTRUCTION_WRITE
    CanBus_SendData MCP_RXF1SIDH
    repeat 4
      CanBus_SendData 0
    end repeat
    CanBus_CSon

    CanBus_CSoff
    CanBus_SendData INSTRUCTION_WRITE
    CanBus_SendData MCP_RXF2SIDH
    repeat 4
      CanBus_SendData 0
    end repeat
    CanBus_CSon

    CanBus_CSoff
    CanBus_SendData INSTRUCTION_WRITE
    CanBus_SendData MCP_RXF3SIDH
    repeat 4
      CanBus_SendData 0
    end repeat
    CanBus_CSon

    CanBus_CSoff
    CanBus_SendData INSTRUCTION_WRITE
    CanBus_SendData MCP_RXF4SIDH
    repeat 4
      CanBus_SendData 0
    end repeat
    CanBus_CSon

    CanBus_CSoff
    CanBus_SendData INSTRUCTION_WRITE
    CanBus_SendData MCP_RXF5SIDH
    repeat 4
      CanBus_SendData 0
    end repeat
    CanBus_CSon


    CanBus_CSoff
    CanBus_SendData INSTRUCTION_WRITE
    CanBus_SendData MCP_RXM0SIDH
    repeat 4
      CanBus_SendData 0
    end repeat
    CanBus_CSon

    CanBus_CSoff
    CanBus_SendData INSTRUCTION_WRITE
    CanBus_SendData MCP_RXM1SIDH
    repeat 4
      CanBus_SendData 0
    end repeat
    CanBus_CSon

  #ENDIF
End sub

Sub CanBus_SetRegister (in CanBus_Register as Byte,in CanBus_Value as Byte)
  #IFDEF CanBus_CS

    CanBus_CSoff

    CanBus_SendData INSTRUCTION_WRITE
    CanBus_SendData CanBus_Register
    CanBus_SendData CanBus_Value

    CanBus_CSon
  #ENDIF
end sub


Sub CanBus_ModifyRegister (in CanBus_Register,in CanBus_Mask,in CanBus_Data)
  #IFDEF CanBus_CS


    CanBus_CSoff

    CanBus_SendData INSTRUCTION_BITMOD
    CanBus_SendData CanBus_Register
    CanBus_SendData CanBus_Mask
    CanBus_SendData CanBus_Data

    CanBus_CSon
  #ENDIF
end sub

Sub CanBus_ReadRegister (in CanBus_Register,out CanBus_Value)
  #IFDEF CanBus_CS


    CanBus_CSoff

    CanBus_SendData INSTRUCTION_READ
    CanBus_SendData CanBus_Register
    CanBus_TransferData 0,CanBus_Value

    CanBus_CSon
  #ENDIF
end sub

Sub CanBus_GetStatus (out CanBus_Value)
  #IFDEF CanBus_CS


    CanBus_CSoff

    CanBus_SendData INSTRUCTION_READ_STATUS
    CanBus_TransferData 0,CanBus_Value

    CanBus_CSon
  #ENDIF
end sub

Sub CanBus_ConfigMode ()
  CanBus_ModifyRegister MCP_CANCTRL,CANCTRL_REQOP,CANCTRL_REQOP_CONFIG
  wait 15 ms
End sub

Sub CanBus_ListenMode ()
  CanBus_ModifyRegister MCP_CANCTRL,CANCTRL_REQOP,CANCTRL_REQOP_LISTENONLY
  wait 15 ms
End sub

Sub CanBus_SleepMode ()
  CanBus_ModifyRegister MCP_CANCTRL,CANCTRL_REQOP,CANCTRL_REQOP_SLEEP
  wait 15 ms
End sub

Sub CanBus_LoopbackMode ()
  CanBus_ModifyRegister MCP_CANCTRL,CANCTRL_REQOP,CANCTRL_REQOP_LOOPBACK
  wait 15 ms
End sub

Sub CanBus_NormalMode ()
  CanBus_ModifyRegister MCP_CANCTRL,CANCTRL_REQOP,CANCTRL_REQOP_NORMAL
  wait 15 ms
End sub


Sub CanBus_SetBusBitrate (in CanBus_Br as Word)
  #IFDEF CanBus_CS
    dim CanBus_lastmode as byte

    CanBus_ReadRegister MCP_CANSTAT,CanBus_lastmode

    CanBus_Reset

    Select Case CanBus_Br
      case 5
        CFG1 = C5kBPS_CFG1
        CFG2 = C5kBPS_CFG2
        CFG3 = C5kBPS_CFG3
      case 10
        CFG1 = C10kBPS_CFG1
        CFG2 = C10kBPS_CFG2
        CFG3 = C10kBPS_CFG3
      case 20
        CFG1 = C20kBPS_CFG1
        CFG2 = C20kBPS_CFG2
        CFG3 = C20kBPS_CFG3
      case 31
        CFG1 = C31kBPS_CFG1
        CFG2 = C31kBPS_CFG2
        CFG3 = C31kBPS_CFG3
      case 33
        CFG1 = C33k3BPS_CFG1
        CFG2 = C33k3BPS_CFG2
        CFG3 = C33k3BPS_CFG3
      case 40
        CFG1 = C40kBPS_CFG1
        CFG2 = C40kBPS_CFG2
        CFG3 = C40kBPS_CFG3
      case 50
        CFG1 = C50kBPS_CFG1
        CFG2 = C50kBPS_CFG2
        CFG3 = C50kBPS_CFG3
      case 80
        CFG1 = C80kBPS_CFG1
        CFG2 = C80kBPS_CFG2
        CFG3 = C80kBPS_CFG3
      case 100
        CFG1 = C100kBPS_CFG1
        CFG2 = C100kBPS_CFG2
        CFG3 = C100kBPS_CFG3
      case 125
        CFG1 = C125kBPS_CFG1
        CFG2 = C125kBPS_CFG2
        CFG3 = C125kBPS_CFG3
      case 200
        CFG1 = C200kBPS_CFG1
        CFG2 = C200kBPS_CFG2
        CFG3 = C200kBPS_CFG3
      case 250
        CFG1 = C250kBPS_CFG1
        CFG2 = C250kBPS_CFG2
        CFG3 = C250kBPS_CFG3
      case 500
        CFG1 = C500kBPS_CFG1
        CFG2 = C500kBPS_CFG2
        CFG3 = C500kBPS_CFG3
      case 1000
        CFG1 = C1000kBPS_CFG1
        CFG2 = C1000kBPS_CFG2
        CFG3 = C1000kBPS_CFG3
      case else
        CFG1 = C10kBPS_CFG1
        CFG2 = C10kBPS_CFG2
        CFG3 = C10kBPS_CFG3
    end select



    CanBus_SetRegister MCP_CNF1,CFG1
    CanBus_SetRegister MCP_CNF2,CFG2
    CanBus_SetRegister MCP_CNF3,CFG3

    if CanBus_lastmode <> CANCTRL_REQOP_CONFIG then
      CanBus_ModifyRegister MCP_CANCTRL,CANCTRL_REQOP,CanBus_lastmode
      wait 15 ms
    end if

  #ENDIF
end sub

Sub CanBus_SendMessage (in CanBus_Buffern as byte,CanBus_ForceExt as bit,in CanBus_ID as Long,in CanBus_RTR as Bit, in CanBus_DL as Byte ,Optional in CanBus_data0 as Byte = 0,Optional in CanBus_data1 as Byte = 0,Optional in CanBus_data2 as Byte = 0,Optional in CanBus_data3 as Byte = 0,Optional in CanBus_data4 as Byte = 0,Optional in CanBus_data5 as Byte = 0,Optional in CanBus_data6 as Byte = 0,Optional in CanBus_data7 as Byte = 0)

  #IFDEF CanBus_CS

    dim CanBus_DLC as Byte
    dim CanBus_IDH as Byte
    dim CanBus_IDL as Byte
    dim CanBus_EID8 as Byte
    dim CanBus_EID0 as Byte
    dim CanBus_selbuffer as Byte
    dim CanBus_sendcommand as byte

    'max for std is 2047 (only 2031 for compat) "00000000011111111111" 0x0000007FF  can 0x7FF
    'max for ext is 536870911 "000000011111111111111111111111111111" 0x01FFFFFFF    can 0x1FFFFFFF
    'convert long to mcp ID format
    if CanBus_ID > 536870911 then
      CanBus_ID = 536870911
    end if

    if CanBus_ForceExt = 1 then
      'ext code
      CanBus_IDL  = 0

      CanBus_EID0.0= CanBus_ID.0
      CanBus_EID0.1= CanBus_ID.1
      CanBus_EID0.2= CanBus_ID.2
      CanBus_EID0.3= CanBus_ID.3
      CanBus_EID0.4= CanBus_ID.4
      CanBus_EID0.5= CanBus_ID.5
      CanBus_EID0.6= CanBus_ID.6
      CanBus_EID0.7= CanBus_ID.7

      CanBus_EID8.0= CanBus_ID.8
      CanBus_EID8.1= CanBus_ID.9
      CanBus_EID8.2= CanBus_ID.10
      CanBus_EID8.3= CanBus_ID.11
      CanBus_EID8.4= CanBus_ID.12
      CanBus_EID8.5= CanBus_ID.13
      CanBus_EID8.6= CanBus_ID.14
      CanBus_EID8.7= CanBus_ID.15

      CanBus_IDL.0 = CanBus_ID.16
      CanBus_IDL.1 = CanBus_ID.17
      CanBus_IDL.3 = 1
      CanBus_IDL.5 = CanBus_ID.18
      CanBus_IDL.6 = CanBus_ID.19
      CanBus_IDL.7 = CanBus_ID.20
      CanBus_IDH.0 = CanBus_ID.21
      CanBus_IDH.1 = CanBus_ID.22
      CanBus_IDH.2 = CanBus_ID.23
      CanBus_IDH.3 = CanBus_ID.24
      CanBus_IDH.4 = CanBus_ID.25
      CanBus_IDH.5 = CanBus_ID.26
      CanBus_IDH.6 = CanBus_ID.27
      CanBus_IDH.7 = CanBus_ID.28

    else
      if CanBus_ID > 2047 then
        'ext code
        CanBus_IDL  = 0

        CanBus_EID0.0= CanBus_ID.0
        CanBus_EID0.1= CanBus_ID.1
        CanBus_EID0.2= CanBus_ID.2
        CanBus_EID0.3= CanBus_ID.3
        CanBus_EID0.4= CanBus_ID.4
        CanBus_EID0.5= CanBus_ID.5
        CanBus_EID0.6= CanBus_ID.6
        CanBus_EID0.7= CanBus_ID.7

        CanBus_EID8.0= CanBus_ID.8
        CanBus_EID8.1= CanBus_ID.9
        CanBus_EID8.2= CanBus_ID.10
        CanBus_EID8.3= CanBus_ID.11
        CanBus_EID8.4= CanBus_ID.12
        CanBus_EID8.5= CanBus_ID.13
        CanBus_EID8.6= CanBus_ID.14
        CanBus_EID8.7= CanBus_ID.15

        CanBus_IDL.0 = CanBus_ID.16
        CanBus_IDL.1 = CanBus_ID.17
        CanBus_IDL.3 = 1
        CanBus_IDL.5 = CanBus_ID.18
        CanBus_IDL.6 = CanBus_ID.19
        CanBus_IDL.7 = CanBus_ID.20
        CanBus_IDH.0 = CanBus_ID.21
        CanBus_IDH.1 = CanBus_ID.22
        CanBus_IDH.2 = CanBus_ID.23
        CanBus_IDH.3 = CanBus_ID.24
        CanBus_IDH.4 = CanBus_ID.25
        CanBus_IDH.5 = CanBus_ID.26
        CanBus_IDH.6 = CanBus_ID.27
        CanBus_IDH.7 = CanBus_ID.28

      else
        'std code
        CanBus_IDL   = 0
        CanBus_EID8  = 0
        CanBus_EID0  = 0
        CanBus_IDL.5 = CanBus_ID.0
        CanBus_IDL.6 = CanBus_ID.1
        CanBus_IDL.7 = CanBus_ID.2
        CanBus_IDH.0 = CanBus_ID.3
        CanBus_IDH.1 = CanBus_ID.4
        CanBus_IDH.2 = CanBus_ID.5
        CanBus_IDH.3 = CanBus_ID.6
        CanBus_IDH.4 = CanBus_ID.7
        CanBus_IDH.5 = CanBus_ID.8
        CanBus_IDH.6 = CanBus_ID.9
        CanBus_IDH.7 = CanBus_ID.10
      end if
    end if


    'convert RTR & DL to mcp DLC format
    if CanBus_DL > 8 then
      CanBus_DL = 8
    end if
    CanBus_DLC = 0
    CanBus_DLC.0 = CanBus_DL.0
    CanBus_DLC.1 = CanBus_DL.1
    CanBus_DLC.2 = CanBus_DL.2
    CanBus_DLC.3 = CanBus_DL.3
    CanBus_DLC.6 = CanBus_RTR



    select case CanBus_Buffern
      case 0
        CanBus_selbuffer = MCP_TXB0CTRL
        CanBus_sendcommand = INSTRUCTION_RTS_TX0
      case 1
        CanBus_selbuffer = MCP_TXB1CTRL
        CanBus_sendcommand = INSTRUCTION_RTS_TX1
      case 2
        CanBus_selbuffer = MCP_TXB2CTRL
        CanBus_sendcommand = INSTRUCTION_RTS_TX2
      case else
        CanBus_selbuffer = MCP_TXB0CTRL
        CanBus_sendcommand = INSTRUCTION_RTS_TX0
    end select


    CanBus_selbuffer += 1
    CanBus_CSoff
    CanBus_SendData INSTRUCTION_WRITE
    CanBus_SendData CanBus_selbuffer
    CanBus_SendData CanBus_IDH
    CanBus_SendData CanBus_IDL
    CanBus_SendData CanBus_EID8
    CanBus_SendData CanBus_EID0
    CanBus_SendData CanBus_DLC
    CanBus_SendData CanBus_data0
    CanBus_SendData CanBus_data1
    CanBus_SendData CanBus_data2
    CanBus_SendData CanBus_data3
    CanBus_SendData CanBus_data4
    CanBus_SendData CanBus_data5
    CanBus_SendData CanBus_data6
    CanBus_SendData CanBus_data7
    CanBus_CSon

    CanBus_CSoff

    CanBus_SendData CanBus_sendcommand

    CanBus_CSon

  #ENDIF

end sub


Sub CanBus_LoadBuffer (in CanBus_Buffern as byte,CanBus_ForceExt as bit,in CanBus_ID as Long,in CanBus_RTR as Bit, in CanBus_DL as Byte ,Optional in CanBus_data0 as Byte = 0,Optional in CanBus_data1 as Byte = 0,Optional in CanBus_data2 as Byte = 0,Optional in CanBus_data3 as Byte = 0,Optional in CanBus_data4 as Byte = 0,Optional in CanBus_data5 as Byte = 0,Optional in CanBus_data6 as Byte = 0,Optional in CanBus_data7 as Byte = 0)

  #IFDEF CanBus_CS

    dim CanBus_DLC as Byte
    dim CanBus_IDH as Byte
    dim CanBus_IDL as Byte
    dim CanBus_EID8 as Byte
    dim CanBus_EID0 as Byte
    dim CanBus_selbuffer as Byte
    dim CanBus_sendcommand as byte

    'max for std is 2047 (only 2031 for compat) "00000000011111111111" 0x0000007FF  can 0x7FF
    'max for ext is 536870911 "000000011111111111111111111111111111" 0x01FFFFFFF    can 0x1FFFFFFF
    'convert long to mcp ID format
    if CanBus_ID > 536870911 then
    CanBus_ID = 536870911
    end if

    if CanBus_ForceExt = 1 then
      'ext code
      CanBus_IDL  = 0

      CanBus_EID0.0= CanBus_ID.0
      CanBus_EID0.1= CanBus_ID.1
      CanBus_EID0.2= CanBus_ID.2
      CanBus_EID0.3= CanBus_ID.3
      CanBus_EID0.4= CanBus_ID.4
      CanBus_EID0.5= CanBus_ID.5
      CanBus_EID0.6= CanBus_ID.6
      CanBus_EID0.7= CanBus_ID.7

      CanBus_EID8.0= CanBus_ID.8
      CanBus_EID8.1= CanBus_ID.9
      CanBus_EID8.2= CanBus_ID.10
      CanBus_EID8.3= CanBus_ID.11
      CanBus_EID8.4= CanBus_ID.12
      CanBus_EID8.5= CanBus_ID.13
      CanBus_EID8.6= CanBus_ID.14
      CanBus_EID8.7= CanBus_ID.15

      CanBus_IDL.0 = CanBus_ID.16
      CanBus_IDL.1 = CanBus_ID.17
      CanBus_IDL.3 = 1
      CanBus_IDL.5 = CanBus_ID.18
      CanBus_IDL.6 = CanBus_ID.19
      CanBus_IDL.7 = CanBus_ID.20
      CanBus_IDH.0 = CanBus_ID.21
      CanBus_IDH.1 = CanBus_ID.22
      CanBus_IDH.2 = CanBus_ID.23
      CanBus_IDH.3 = CanBus_ID.24
      CanBus_IDH.4 = CanBus_ID.25
      CanBus_IDH.5 = CanBus_ID.26
      CanBus_IDH.6 = CanBus_ID.27
      CanBus_IDH.7 = CanBus_ID.28

    else
      if CanBus_ID > 2047 then
        'ext code
        CanBus_IDL  = 0

        CanBus_EID0.0= CanBus_ID.0
        CanBus_EID0.1= CanBus_ID.1
        CanBus_EID0.2= CanBus_ID.2
        CanBus_EID0.3= CanBus_ID.3
        CanBus_EID0.4= CanBus_ID.4
        CanBus_EID0.5= CanBus_ID.5
        CanBus_EID0.6= CanBus_ID.6
        CanBus_EID0.7= CanBus_ID.7

        CanBus_EID8.0= CanBus_ID.8
        CanBus_EID8.1= CanBus_ID.9
        CanBus_EID8.2= CanBus_ID.10
        CanBus_EID8.3= CanBus_ID.11
        CanBus_EID8.4= CanBus_ID.12
        CanBus_EID8.5= CanBus_ID.13
        CanBus_EID8.6= CanBus_ID.14
        CanBus_EID8.7= CanBus_ID.15

        CanBus_IDL.0 = CanBus_ID.16
        CanBus_IDL.1 = CanBus_ID.17
        CanBus_IDL.3 = 1
        CanBus_IDL.5 = CanBus_ID.18
        CanBus_IDL.6 = CanBus_ID.19
        CanBus_IDL.7 = CanBus_ID.20
        CanBus_IDH.0 = CanBus_ID.21
        CanBus_IDH.1 = CanBus_ID.22
        CanBus_IDH.2 = CanBus_ID.23
        CanBus_IDH.3 = CanBus_ID.24
        CanBus_IDH.4 = CanBus_ID.25
        CanBus_IDH.5 = CanBus_ID.26
        CanBus_IDH.6 = CanBus_ID.27
        CanBus_IDH.7 = CanBus_ID.28

      else

        'std code
        CanBus_IDL   = 0
        CanBus_EID8  = 0
        CanBus_EID0  = 0
        CanBus_IDL.5 = CanBus_ID.0
        CanBus_IDL.6 = CanBus_ID.1
        CanBus_IDL.7 = CanBus_ID.2
        CanBus_IDH.0 = CanBus_ID.3
        CanBus_IDH.1 = CanBus_ID.4
        CanBus_IDH.2 = CanBus_ID.5
        CanBus_IDH.3 = CanBus_ID.6
        CanBus_IDH.4 = CanBus_ID.7
        CanBus_IDH.5 = CanBus_ID.8
        CanBus_IDH.6 = CanBus_ID.9
        CanBus_IDH.7 = CanBus_ID.10
      end if
    end if



    'convert RTR & DL to mcp DLC format
    if CanBus_DL > 8 then
      CanBus_DL = 8
    end if
    CanBus_DLC = 0
    CanBus_DLC.0 = CanBus_DL.0
    CanBus_DLC.1 = CanBus_DL.1
    CanBus_DLC.2 = CanBus_DL.2
    CanBus_DLC.3 = CanBus_DL.3
    CanBus_DLC.6 = CanBus_RTR



    select case CanBus_Buffern
      case 0
        CanBus_selbuffer = MCP_TXB0CTRL
      case 1
        CanBus_selbuffer = MCP_TXB1CTRL
      case 2
        CanBus_selbuffer = MCP_TXB2CTRL
      case else
        CanBus_selbuffer = MCP_TXB0CTRL
    end select


    CanBus_selbuffer += 1
    CanBus_CSoff
    CanBus_SendData INSTRUCTION_WRITE
    CanBus_SendData CanBus_selbuffer
    CanBus_SendData CanBus_IDH
    CanBus_SendData CanBus_IDL
    CanBus_SendData CanBus_EID8
    CanBus_SendData CanBus_EID0
    CanBus_SendData CanBus_DLC
    CanBus_SendData CanBus_data0
    CanBus_SendData CanBus_data1
    CanBus_SendData CanBus_data2
    CanBus_SendData CanBus_data3
    CanBus_SendData CanBus_data4
    CanBus_SendData CanBus_data5
    CanBus_SendData CanBus_data6
    CanBus_SendData CanBus_data7
    CanBus_CSon


  #ENDIF

end sub

sub CanBus_SendBuffer (in CanBus_Buffern as byte)
  #IFDEF CanBus_CS

    select case CanBus_Buffern
      case 0
        CanBus_sendcommand = INSTRUCTION_RTS_TX0
      case 1
        CanBus_sendcommand = INSTRUCTION_RTS_TX1
      case 2
        CanBus_sendcommand = INSTRUCTION_RTS_TX2
      case else
        CanBus_sendcommand = INSTRUCTION_RTS_TX0
    end select


    CanBus_CSoff
    CanBus_SendData CanBus_sendcommand
    CanBus_CSon
  #ENDIF
end sub

Sub CanBus_ReadMessage (in CanBus_Buffern as bit,out CanBus_Ext as BIT ,out CanBus_ID as Long,out CanBus_RTR as Bit,out CanBus_DL as Byte,optional CanBus_FilHit as Byte =1)
  #IFDEF CanBus_CS
    dim CanBus_DLC as Byte
    dim CanBus_IDH as Byte
    dim CanBus_IDL as Byte
    dim CanBus_EID8 as Byte
    dim CanBus_EID0 as Byte
    dim CanBus_selbuffer as Byte
    dim CanBus_CTRL
    CanBus_ID  = 0
    CanBus_DL  = 0

    if CanBus_Buffern = 0 then
      CanBus_selbuffer = MCP_RXB0CTRL

    else
      CanBus_selbuffer = MCP_RXB1CTRL

    end if


    CanBus_CSoff
    CanBus_SendData INSTRUCTION_READ
    CanBus_SendData CanBus_selbuffer
    CanBus_TransferData 0,CanBus_CTRL
    CanBus_TransferData 0,CanBus_IDH
    CanBus_TransferData 0,CanBus_IDL
    CanBus_TransferData 0,CanBus_EID8
    CanBus_TransferData 0,CanBus_EID0
    CanBus_TransferData 0,CanBus_DLC
    CanBus_TransferData 0,CanBus_ReadBuffer(1)
    CanBus_TransferData 0,CanBus_ReadBuffer(2)
    CanBus_TransferData 0,CanBus_ReadBuffer(3)
    CanBus_TransferData 0,CanBus_ReadBuffer(4)
    CanBus_TransferData 0,CanBus_ReadBuffer(5)
    CanBus_TransferData 0,CanBus_ReadBuffer(6)
    CanBus_TransferData 0,CanBus_ReadBuffer(7)
    CanBus_TransferData 0,CanBus_ReadBuffer(8)
    CanBus_CSon

    if CanBus_selbuffer = MCP_RXB0CTRL then
      CanBus_FilHit = CanBus_CTRL.0
    else
      CanBus_FilHit = 0

      CanBus_FilHit.0 = CanBus_CTRL.0
      CanBus_FilHit.1 = CanBus_CTRL.1
      CanBus_FilHit.2 = CanBus_CTRL.2
    end if

    if CanBus_IDL.3 = 1 then
      'ext code
      CanBus_Ext   = CanBus_IDL.3

      CanBus_RTR   = CanBus_DLC.6

      CanBus_ID.0  = CanBus_EID0.0
      CanBus_ID.1  = CanBus_EID0.1
      CanBus_ID.2  = CanBus_EID0.2
      CanBus_ID.3  = CanBus_EID0.3
      CanBus_ID.4  = CanBus_EID0.4
      CanBus_ID.5  = CanBus_EID0.5
      CanBus_ID.6  = CanBus_EID0.6
      CanBus_ID.7  = CanBus_EID0.7

      CanBus_ID.8  = CanBus_EID8.0
      CanBus_ID.9  = CanBus_EID8.1
      CanBus_ID.10 = CanBus_EID8.2
      CanBus_ID.11 = CanBus_EID8.3
      CanBus_ID.12 = CanBus_EID8.4
      CanBus_ID.13 = CanBus_EID8.5
      CanBus_ID.14 = CanBus_EID8.6
      CanBus_ID.15 = CanBus_EID8.7

      CanBus_ID.16 = CanBus_IDL.0
      CanBus_ID.17 = CanBus_IDL.1
      CanBus_ID.18 = CanBus_IDL.5
      CanBus_ID.19 = CanBus_IDL.6
      CanBus_ID.20 = CanBus_IDL.7

      CanBus_ID.21 = CanBus_IDH.0
      CanBus_ID.22 = CanBus_IDH.1
      CanBus_ID.23 = CanBus_IDH.2
      CanBus_ID.24 = CanBus_IDH.3
      CanBus_ID.25 = CanBus_IDH.4
      CanBus_ID.26 = CanBus_IDH.5
      CanBus_ID.27 = CanBus_IDH.6
      CanBus_ID.28 = CanBus_IDH.7

    else
      'std code
      CanBus_Ext = CanBus_IDL.3

      CanBus_RTR   = CanBus_IDL.4

      CanBus_ID.0  = CanBus_IDL.5
      CanBus_ID.1  = CanBus_IDL.6
      CanBus_ID.2  = CanBus_IDL.7

      CanBus_ID.3  = CanBus_IDH.0
      CanBus_ID.4  = CanBus_IDH.1
      CanBus_ID.5  = CanBus_IDH.2
      CanBus_ID.6  = CanBus_IDH.3
      CanBus_ID.7  = CanBus_IDH.4
      CanBus_ID.8  = CanBus_IDH.5
      CanBus_ID.9  = CanBus_IDH.6
      CanBus_ID.10 = CanBus_IDH.7
    end if


    CanBus_DL.0  = CanBus_DLC.0
    CanBus_DL.1  = CanBus_DLC.1
    CanBus_DL.2  = CanBus_DLC.2
    CanBus_DL.3  = CanBus_DLC.3

    if CanBus_DL < 8 then
      for i = CanBus_DL to 7
        CanBus_ReadBuffer(i+1) = 0
      next
    end if

    'set corresponding register read flag
    if CanBus_buffern = 0 then
      CanBus_ModifyRegister MCP_CANINTF, CANINTF_RX0IF,0
    else
      CanBus_ModifyRegister MCP_CANINTF, CANINTF_RX1IF,0
    end if

  #ENDIF
end sub

sub CanBus_SetRollover (in CanBus_Rollover as bit)
  #IFDEF CanBus_CS
    CanBus_ModifyRegister MCP_RXB0CTRL,RXB0CTRL_BUKT,CanBus_Rollover

  #ENDIF
end sub

sub CanBus_SetMaskMode (in CanBus_Buffern as bit, CanBus_Mode as Byte)
  #IFDEF CanBus_CS
    dim CanBus_selbuffer as Byte
    if CanBus_Buffern = 0 then
      CanBus_selbuffer = MCP_RXB0CTRL
    else
      CanBus_selbuffer = MCP_RXB1CTRL
    end if
    select case CanBus_Mode
      case 3
        'Filters off receive all messages, including fault messages (usefull for debug or sniffing)
        CanBus_ModifyRegister CanBus_selbuffer,RXBnCTRL_RXM_MASK,RXBnCTRL_RXM_MASK
      case 2
        'Filters On receive valid messages whit Ext Id's only
        CanBus_ModifyRegister CanBus_selbuffer,RXBnCTRL_RXM_MASK,RXBnCTRL_RXM_EXT
      case 1
        CanBus_ModifyRegister CanBus_selbuffer,RXBnCTRL_RXM_MASK,RXBnCTRL_RXM_STD
        'Filters on Receive valid messages whit Std and Ext Id's
      case 0
        'Filters on Receive valid messages whit Std and Ext Id's (default)
        CanBus_ModifyRegister CanBus_selbuffer,RXBnCTRL_RXM_MASK,RXBnCTRL_RXM_STDEXT
      case else
        'Filters on Receive valid messages whit Std and Ext Id's (default)
        CanBus_ModifyRegister CanBus_selbuffer,RXBnCTRL_RXM_MASK,RXBnCTRL_RXM_STDEXT
    end select

  #ENDIF
end sub

sub CanBus_GetErrorStatus (CanBus_ErrorWarning as BIT,optional CanBus_RxWarning as BIT,optional CanBus_TxWarning as BIT,optional CanBus_RxErrPasive as BIT,optional CanBus_TxErrPasive as BIT,optional CanBus_TxErrBusOff as BIT,optional CanBus_Rx0Overflow as BIT,optional CanBus_Rx1Overflow as BIT,optional CanBus_TxErrCounter as byte,optional CanBus_RxErrCounter as byte)
  #IFDEF CanBus_CS
    dim CanBus_TEC as Byte
    dim CanBus_EFLG as Byte
    CanBus_ReadRegister MCP_TEC, CanBus_TxErrCounter
    CanBus_ReadRegister MCP_REC, CanBus_RxErrCounter
    CanBus_ReadRegister MCP_EFLG, CanBus_EFLG

    CanBus_ErrorWarning = CanBus_EFLG.0
    CanBus_RxWarning    = CanBus_EFLG.1
    CanBus_TxWarning    = CanBus_EFLG.2
    CanBus_RxErrPasive  = CanBus_EFLG.3
    CanBus_TxErrPasive  = CanBus_EFLG.4
    CanBus_TxErrBusOff  = CanBus_EFLG.5
    CanBus_Rx0Overflow  = CanBus_EFLG.6
    CanBus_Rx1Overflow  = CanBus_EFLG.7

  #ENDIF
end sub

sub CanBus_SetInterrupts (CanBus_Rx0Full as bit,optional CanBus_Rx1Full as bit =0,optional CanBus_Tx0Empty as bit =0,optional CanBus_Tx1Empty as bit =0,optional CanBus_Tx2Empty as bit =0,optional CanBus_Error as bit =0,optional CanBus_MsgError as bit =0,optional CanBus_WakeUp as bit =0)
  #IFDEF CanBus_CS
  dim CanBus_caninte as Byte

    CanBus_caninte.0 = CanBus_Rx0Full
    CanBus_caninte.1 = CanBus_Rx1Full
    CanBus_caninte.2 = CanBus_Tx0Empty
    CanBus_caninte.3 = CanBus_Tx1Empty
    CanBus_caninte.4 = CanBus_Tx2Empty
    CanBus_caninte.5 = CanBus_Error
    CanBus_caninte.6 = CanBus_WakeUp
    CanBus_caninte.7 = CanBus_MsgError

    CanBus_SetRegister MCP_CANINTE, CanBus_caninte

  #ENDIF
end sub

sub CanBus_ClrAllInt()
  #IFDEF CanBus_CS
    CanBus_SetRegister MCP_CANINTF, 0
  #ENDIF
end sub

sub CanBus_ClrRx0FullInt ()
  #IFDEF CanBus_CS
    CanBus_ModifyRegister MCP_CANINTF, CANINTF_RX0IF, 0
  #ENDIF
end sub

sub CanBus_ClrRx1FullInt ()
  #IFDEF CanBus_CS
    CanBus_ModifyRegister MCP_CANINTF, CANINTF_RX1IF, 0
  #ENDIF
end sub

sub CanBus_ClrTx0EmptyInt ()
  #IFDEF CanBus_CS
    CanBus_ModifyRegister MCP_CANINTF, CANINTF_TX0IF, 0
  #ENDIF
end sub

sub CanBus_ClrTx1EmptyInt ()
  #IFDEF CanBus_CS
    CanBus_ModifyRegister MCP_CANINTF, CANINTF_TX1IF, 0
  #ENDIF
end sub

sub CanBus_ClrTx2EmptyInt ()
  #IFDEF CanBus_CS
    CanBus_ModifyRegister MCP_CANINTF, CANINTF_TX2IF, 0
  #ENDIF
end sub

sub CanBus_ClrErrorInt ()
  #IFDEF CanBus_CS
   CanBus_ModifyRegister MCP_CANINTF, CANINTF_ERRIF, 0
  #ENDIF
end sub

sub CanBus_ClrMsgErrorInt ()
  #IFDEF CanBus_CS
    CanBus_ModifyRegister MCP_CANINTF, CANINTF_MERRF, 0
  #ENDIF
end sub

sub CanBus_ClrWakeUpInt ()
  #IFDEF CanBus_CS
   CanBus_ModifyRegister MCP_CANINTF, CANINTF_WAKIF, 0
  #ENDIF
end sub

sub CanBus_GetBufferSatus (out CanBus_Rx0Full as bit,optional CanBus_Rx1Full as bit =0,optional CanBus_Tx0Empty as bit =0,optional CanBus_Tx1Empty as bit =0,optional CanBus_Tx2Empty as bit =0,optional CanBus_Error as bit =0,optional CanBus_MsgError as bit =0,optional CanBus_WakeUp as bit =0)
  #IFDEF CanBus_CS
    dim CanBus_canintf as Byte
    CanBus_ReadRegister MCP_CANINTF, CanBus_canintf
    CanBus_Rx0Full  = CanBus_canintf.0
    CanBus_Rx1Full  = CanBus_canintf.1
    CanBus_Tx0Empty = CanBus_canintf.2
    CanBus_Tx1Empty = CanBus_canintf.3
    CanBus_Tx2Empty = CanBus_canintf.4
    CanBus_Error    = CanBus_canintf.5
    CanBus_WakeUp   = CanBus_canintf.6
    CanBus_MsgError = CanBus_canintf.7
  #ENDIF
end sub

sub CanBus_SetFilter (in CanBus_Filtern as byte, CanBus_ForceExt as bit,in CanBus_Filter as Long,optional in CanBus_ApplyExt as bit = 1 )
  #IFDEF CanBus_CS

    dim CanBus_IDH as Byte
    dim CanBus_IDL as Byte
    dim CanBus_EID8 as Byte
    dim CanBus_EID0 as Byte
    dim CanBus_selfilter as Byte
    dim CanBus_lastmode as byte

    CanBus_ReadRegister MCP_CANSTAT,CanBus_lastmode
    CanBus_ConfigMode

    select case CanBus_Filtern
      case 0
        CanBus_selfilter = MCP_RXF0SIDH
      case 1
        CanBus_selfilter = MCP_RXF1SIDH
      case 2
        CanBus_selfilter = MCP_RXF2SIDH
      case 3
        CanBus_selfilter = MCP_RXF3SIDH
      case 4
        CanBus_selfilter = MCP_RXF4SIDH
      case 5
        CanBus_selfilter = MCP_RXF5SIDH
    end select

    'max for std is 2047 "00000000011111111111" 0x0000007FF  can 0x7FF
    'max for ext is 536870911 "000000011111111111111111111111111111" 0x01FFFFFFF    can 0x1FFFFFFF
    'convert long to mcp ID format
    if CanBus_Filter > 536870911 then
      CanBus_Filter = 536870911
    end if



    if CanBus_ForceExt = 1  > 2047 then
      'ext code
      CanBus_IDL  = 0

      CanBus_EID0.0= CanBus_Filter.0
      CanBus_EID0.1= CanBus_Filter.1
      CanBus_EID0.2= CanBus_Filter.2
      CanBus_EID0.3= CanBus_Filter.3
      CanBus_EID0.4= CanBus_Filter.4
      CanBus_EID0.5= CanBus_Filter.5
      CanBus_EID0.6= CanBus_Filter.6
      CanBus_EID0.7= CanBus_Filter.7

      CanBus_EID8.0= CanBus_Filter.8
      CanBus_EID8.1= CanBus_Filter.9
      CanBus_EID8.2= CanBus_Filter.10
      CanBus_EID8.3= CanBus_Filter.11
      CanBus_EID8.4= CanBus_Filter.12
      CanBus_EID8.5= CanBus_Filter.13
      CanBus_EID8.6= CanBus_Filter.14
      CanBus_EID8.7= CanBus_Filter.15

      CanBus_IDL.0 = CanBus_Filter.16
      CanBus_IDL.1 = CanBus_Filter.17
      CanBus_IDL.3 = CanBus_ApplyExt
      CanBus_IDL.5 = CanBus_Filter.18
      CanBus_IDL.6 = CanBus_Filter.19
      CanBus_IDL.7 = CanBus_Filter.20
      CanBus_IDH.0 = CanBus_Filter.21
      CanBus_IDH.1 = CanBus_Filter.22
      CanBus_IDH.2 = CanBus_Filter.23
      CanBus_IDH.3 = CanBus_Filter.24
      CanBus_IDH.4 = CanBus_Filter.25
      CanBus_IDH.5 = CanBus_Filter.26
      CanBus_IDH.6 = CanBus_Filter.27
      CanBus_IDH.7 = CanBus_Filter.28

    else
        if CanBus_ID > 2047 then
        'ext code
        CanBus_IDL  = 0

        CanBus_EID0.0= CanBus_Filter.0
        CanBus_EID0.1= CanBus_Filter.1
        CanBus_EID0.2= CanBus_Filter.2
        CanBus_EID0.3= CanBus_Filter.3
        CanBus_EID0.4= CanBus_Filter.4
        CanBus_EID0.5= CanBus_Filter.5
        CanBus_EID0.6= CanBus_Filter.6
        CanBus_EID0.7= CanBus_Filter.7

        CanBus_EID8.0= CanBus_Filter.8
        CanBus_EID8.1= CanBus_Filter.9
        CanBus_EID8.2= CanBus_Filter.10
        CanBus_EID8.3= CanBus_Filter.11
        CanBus_EID8.4= CanBus_Filter.12
        CanBus_EID8.5= CanBus_Filter.13
        CanBus_EID8.6= CanBus_Filter.14
        CanBus_EID8.7= CanBus_Filter.15

        CanBus_IDL.0 = CanBus_Filter.16
        CanBus_IDL.1 = CanBus_Filter.17
        CanBus_IDL.3 = 1
        CanBus_IDL.5 = CanBus_Filter.18
        CanBus_IDL.6 = CanBus_Filter.19
        CanBus_IDL.7 = CanBus_Filter.20
        CanBus_IDH.0 = CanBus_Filter.21
        CanBus_IDH.1 = CanBus_Filter.22
        CanBus_IDH.2 = CanBus_Filter.23
        CanBus_IDH.3 = CanBus_Filter.24
        CanBus_IDH.4 = CanBus_Filter.25
        CanBus_IDH.5 = CanBus_Filter.26
        CanBus_IDH.6 = CanBus_Filter.27
        CanBus_IDH.7 = CanBus_Filter.28

        else
        'std code
        CanBus_IDL   = 0
        CanBus_EID8  = 0
        CanBus_EID0  = 0
        CanBus_IDL.5 = CanBus_Filter.0
        CanBus_IDL.6 = CanBus_Filter.1
        CanBus_IDL.7 = CanBus_Filter.2
        CanBus_IDH.0 = CanBus_Filter.3
        CanBus_IDH.1 = CanBus_Filter.4
        CanBus_IDH.2 = CanBus_Filter.5
        CanBus_IDH.3 = CanBus_Filter.6
        CanBus_IDH.4 = CanBus_Filter.7
        CanBus_IDH.5 = CanBus_Filter.8
        CanBus_IDH.6 = CanBus_Filter.9
        CanBus_IDH.7 = CanBus_Filter.10
        end if
      end if




    CanBus_CSoff
    CanBus_SendData INSTRUCTION_WRITE
    CanBus_SendData CanBus_selfilter
    CanBus_SendData CanBus_IDH
    CanBus_SendData CanBus_IDL
    CanBus_SendData CanBus_EID8
    CanBus_SendData CanBus_EID0
    CanBus_CSon


    if CanBus_lastmode <> CANCTRL_REQOP_CONFIG then
      CanBus_ModifyRegister MCP_CANCTRL,CANCTRL_REQOP,CanBus_lastmode
    wait 15 ms
    end if

  #ENDIF
end sub

sub CanBus_SetMask (in CanBus_Maskn as bit, CanBus_ForceExt as bit,in CanBus_Mask as Long)
  #IFDEF CanBus_CS

    dim CanBus_IDH as Byte
    dim CanBus_IDL as Byte
    dim CanBus_EID8 as Byte
    dim CanBus_EID0 as Byte
    dim CanBus_selmask as Byte
    dim CanBus_lastmode as byte

    CanBus_ReadRegister MCP_CANSTAT,CanBus_lastmode
    CanBus_ConfigMode

    if CanBus_Maskn = 0 then
      CanBus_selmask = MCP_RXM0SIDH
    else
      CanBus_selmask = MCP_RXM1SIDH
    end if
    'max for std is 2047 "00000000011111111111" 0x0000007FF  can 0x7FF
    'max for ext is 536870911 "000000011111111111111111111111111111" 0x01FFFFFFF    can 0x1FFFFFFF
    'convert long to mcp ID format
    if CanBus_Mask > 536870911 then
      CanBus_Mask = 536870911
    end if

    if CanBus_ForceExt = 1 then
      'ext code
      CanBus_IDL  = 0

      CanBus_EID0.0= CanBus_Mask.0
      CanBus_EID0.1= CanBus_Mask.1
      CanBus_EID0.2= CanBus_Mask.2
      CanBus_EID0.3= CanBus_Mask.3
      CanBus_EID0.4= CanBus_Mask.4
      CanBus_EID0.5= CanBus_Mask.5
      CanBus_EID0.6= CanBus_Mask.6
      CanBus_EID0.7= CanBus_Mask.7

      CanBus_EID8.0= CanBus_Mask.8
      CanBus_EID8.1= CanBus_Mask.9
      CanBus_EID8.2= CanBus_Mask.10
      CanBus_EID8.3= CanBus_Mask.11
      CanBus_EID8.4= CanBus_Mask.12
      CanBus_EID8.5= CanBus_Mask.13
      CanBus_EID8.6= CanBus_Mask.14
      CanBus_EID8.7= CanBus_Mask.15

      CanBus_IDL.0 = CanBus_Mask.16
      CanBus_IDL.1 = CanBus_Mask.17
      CanBus_IDL.5 = CanBus_Mask.18
      CanBus_IDL.6 = CanBus_Mask.19
      CanBus_IDL.7 = CanBus_Mask.20
      CanBus_IDH.0 = CanBus_Mask.21
      CanBus_IDH.1 = CanBus_Mask.22
      CanBus_IDH.2 = CanBus_Mask.23
      CanBus_IDH.3 = CanBus_Mask.24
      CanBus_IDH.4 = CanBus_Mask.25
      CanBus_IDH.5 = CanBus_Mask.26
      CanBus_IDH.6 = CanBus_Mask.27
      CanBus_IDH.7 = CanBus_Mask.28

    else

      if  CanBus_ID > 2047 then
        'ext code
        CanBus_IDL  = 0

        CanBus_EID0.0= CanBus_Mask.0
        CanBus_EID0.1= CanBus_Mask.1
        CanBus_EID0.2= CanBus_Mask.2
        CanBus_EID0.3= CanBus_Mask.3
        CanBus_EID0.4= CanBus_Mask.4
        CanBus_EID0.5= CanBus_Mask.5
        CanBus_EID0.6= CanBus_Mask.6
        CanBus_EID0.7= CanBus_Mask.7

        CanBus_EID8.0= CanBus_Mask.8
        CanBus_EID8.1= CanBus_Mask.9
        CanBus_EID8.2= CanBus_Mask.10
        CanBus_EID8.3= CanBus_Mask.11
        CanBus_EID8.4= CanBus_Mask.12
        CanBus_EID8.5= CanBus_Mask.13
        CanBus_EID8.6= CanBus_Mask.14
        CanBus_EID8.7= CanBus_Mask.15

        CanBus_IDL.0 = CanBus_Mask.16
        CanBus_IDL.1 = CanBus_Mask.17
        CanBus_IDL.5 = CanBus_Mask.18
        CanBus_IDL.6 = CanBus_Mask.19
        CanBus_IDL.7 = CanBus_Mask.20
        CanBus_IDH.0 = CanBus_Mask.21
        CanBus_IDH.1 = CanBus_Mask.22
        CanBus_IDH.2 = CanBus_Mask.23
        CanBus_IDH.3 = CanBus_Mask.24
        CanBus_IDH.4 = CanBus_Mask.25
        CanBus_IDH.5 = CanBus_Mask.26
        CanBus_IDH.6 = CanBus_Mask.27
        CanBus_IDH.7 = CanBus_Mask.28
      else
        'std code
        CanBus_IDL   = 0
        CanBus_EID8  = 0
        CanBus_EID0  = 0
        CanBus_IDL.5 = CanBus_Mask.0
        CanBus_IDL.6 = CanBus_Mask.1
        CanBus_IDL.7 = CanBus_Mask.2
        CanBus_IDH.0 = CanBus_Mask.3
        CanBus_IDH.1 = CanBus_Mask.4
        CanBus_IDH.2 = CanBus_Mask.5
        CanBus_IDH.3 = CanBus_Mask.6
        CanBus_IDH.4 = CanBus_Mask.7
        CanBus_IDH.5 = CanBus_Mask.8
        CanBus_IDH.6 = CanBus_Mask.9
        CanBus_IDH.7 = CanBus_Mask.10
      end if
    end if




    CanBus_CSoff
    CanBus_SendData INSTRUCTION_WRITE
    CanBus_SendData CanBus_selmask
    CanBus_SendData CanBus_IDH
    CanBus_SendData CanBus_IDL
    CanBus_SendData CanBus_EID8
    CanBus_SendData CanBus_EID0
    CanBus_CSon

    if CanBus_lastmode <> CANCTRL_REQOP_CONFIG then
      CanBus_ModifyRegister MCP_CANCTRL,CANCTRL_REQOP,CanBus_lastmode
      wait 15 ms
    end if


  #ENDIF
end sub

sub CanBus_SetRead (optional in CanBus_Buffern as Byte = 2)
  #IFDEF CanBus_CS

    select case CanBus_Buffern
        case 0
          CanBus_ModifyRegister MCP_CANINTF, CANINTF_RX0IF,0
        case 1
          CanBus_ModifyRegister MCP_CANINTF, CANINTF_RX1IF,0
        case 2
          CanBus_ModifyRegister MCP_CANINTF, CANINTF_RX0IF,0
          CanBus_ModifyRegister MCP_CANINTF, CANINTF_RX1IF,0
        case else
          CanBus_ModifyRegister MCP_CANINTF, CANINTF_RX0IF,0
          CanBus_ModifyRegister MCP_CANINTF, CANINTF_RX1IF,0
    end Select

  #ENDIF
end sub




// SPI Comms


sub  CanBus_TransferData(IN CanBusSendByte as byte, CanBusOutByte as byte)

  Dim CanBusOutByte as byte
  CanBusOutByte = 0

  #ifdef CanBus_HardwareSPI
     SPITransfer  CanBusSendByte,  CanBusOutByte
  #endif

  #ifndef CanBus_HardwareSPI

      repeat 8

        if CanBusSendByte.7 = ON then
          CanBus_DO = 1
        else
          CanBus_DO = 0
        end if

        rotate CanBusOutByte left
        rotate CanBusSendByte left


          if CanBus_DI = 1 then
          CanBusOutByte.0 = 1
          end if


        CanBus_SCK = 1
        CanBus_SCK = 0

      end Repeat
        CanBus_DO = 1
  #endif

end Sub


sub  CanBus_SendData(IN CanBusSendByte as byte)

  #ifdef CanBus_HardwareSPI
     SPITransfer  CanBusSendByte,  CanBusTempOut
  #endif

  #ifndef CanBus_HardwareSPI

      repeat 8

        if CanBusSendByte.7 = 1  then
          CanBus_DO = 1
        else
          CanBus_DO = 0
        end if

        rotate CanBusSendByte left

        CanBus_SCK = 1

        CanBus_SCK = 0

      end repeat
        CanBus_DO = 1
  #endif
end sub

Sub CanBus_SetSPI()
  #IFDEF CanBus_CS
    #IFDEF CanBus_INT
      dir CanBus_INT   In
    #endif
        #IFDEF CanBus_INT1
      dir CanBus_INT1   In
    #endif
        #IFDEF CanBus_INT2
      dir CanBus_INT2   In
    #endif
        #IFDEF CanBus_INT3
      dir CanBus_INT3   In
    #endif

    dir CanBus_DO    Out
    dir CanBus_DI    In
    dir CanBus_SCK   Out

    #ifdef CanBus_HardwareSPI
      SPIMode Master, SPI_CPOL_0 + SPI_CPHA_0
    #ENDIF

    dir CanBus_CS    Out
    CanBus_CS = on

    #IFDEF CanBus_CS1
      dir CanBus_CS1    Out
      CanBus_CS1 = on
    #endif
    #IFDEF CanBus_CS2
      dir CanBus_CS2    Out
      CanBus_CS2 = on
    #endif
    #IFDEF CanBus_CS3
      dir CanBus_CS3    Out
      CanBus_CS3 = on
    #endif


  #ENDIF

end Sub

sub CanBus_CSoff
    select case CanBus_Module
      case 0
        CanBus_CS  = off
      case 1
        CanBus_CS1 = off
      case 2
        CanBus_CS2 = off
      case 3
        CanBus_CS3 = off
      case else
        CanBus_CS  = off
    end select
end sub

sub CanBus_CSon
    select case CanBus_Module
      case 0
        CanBus_CS  = on
      case 1
        CanBus_CS1 = on
      case 2
        CanBus_CS2 = on
      case 3
        CanBus_CS3 = on
      case else
        CanBus_CS  = on
    end select
end sub
