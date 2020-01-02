' My SD Lib

    Dim SDResponse, SDResponse2, SDResponse3, SDResponse4, SDResponse5 as byte
    Dim SD_Counter, SD_Counter1, SD_Counter2, SD_Counter3 as word
    Dim INITSucc as byte
    Dim SDToken, SDData, Record_Number as byte
    Dim SDDataBuffer(512) as Byte
    Dim Dir_Record(5), File_Record(5)  as byte
    Dim SDByte, StepSize as Word
    Dim Record_Location, Record_location_last as Word
    Dim File_System_Ver_Num as byte
    Dim Flag as byte  alias  File_System_Ver_Num
    Dim N_Sector_per_cluster, N_FATS, N_Sector_of_FAT2 as byte
    Dim N_Bytes_per_Sector, N_Reserved_Sector as Word
    Dim Partition_Begin_LBA, Fat_Begin_Lba, Cluster_Begin_LBA  as Long
    Dim N_Sectors_per_Fat as Long
    Dim SDLocation, SDLocation0, SDLocation_last, SDLocation_Header as Long
    Dim B0, B1, B2, B3 as Long
    Dim ind1, ind2 as byte
    Dim ImageWidth, ImageHeight as word
    Dim x_Disp, y_Disp as Word
    Dim Blue_Color, Green_Color, Red_Color as byte
    Dim Color as word
    Dim SD_MyString, SD_MyString1, SD_MyString2 as String *11
    Dim Verbose as String * 3
    Dim Dir_or_File_Name  as String * 8
    Dim File_Extension as String * 3

    #ifdef SD_HardwareSPI
      ' harware SPI mode
       asm showdebug SPI constant used equates to HWSPIMODESCRIPT
       SPIMode HWSPIMODESCRIPT, 0
    #endif


sub SDInitialize
                  'INITIALIZATION TO Transfer state

                      'Syncronization and CMD0 Command
  INITSucc=0
  SDResponse=100
  do until INITSucc=1

    Draw_Line(1,20," ")
    sertxd(1,"* Initialization"," Starts *",1)


    CallCMD0              'CMD0 Command

    CallCMD8              'CMD8 Command

    CallCMD58             'CMD58 Command

    CallACMD41            'ACDMD41 Command

'    CallCMD13             'CMD13 Command  sembra che con le sanDisk non sia gradito
                          '                ma con le SD PNY funziona bene!!

    CallCMD58             'CMD58 Command

    CallCMD16             'CMD16 Command

  Loop

  if INITSucc=1 then
    sertxd(2,"* Initialization"," successfull *",1)
  else
    sertxd(2,"* Initialization"," UNSUCCESSFULL *",1)
    wait 1 s
  end if

  SET SD_Adaper_CS ON

end sub

sub SendDummyBytes(in n_bytes as byte)

    repeat n_bytes
      SPITransfer 0xFF, SDData
    end repeat
end sub

sub SendCommand(in Code as byte,  in Arg as Long , in CRC as byte)

    SET SD_Adaper_CS OFF
    SPITransfer 0xFF, SDData
    SPITransfer Code, SDData
    SPITransfer Arg_E, SDData
    SPITransfer Arg_U, SDData
    SPITransfer Arg_H, SDData
    SPITransfer [byte]Arg, SDData
    SPITransfer CRC, SDData


    SendPulses      'NECESSARIO!!!!
'    SPITransfer 0xFF, SDData

end sub

sub SendPulses

'    Set SD_Adaper_CS OFF
    SPITransfer 0xFF, SDData
'    Set SD_Adaper_CS ON

end sub

sub GetSDResponse(in NResponse as byte, SDResp )

    Dim SDResp as Byte

    repeat NResponse
        SPITransfer 255, SDResp
    end Repeat

end sub

sub CallCMD0
HserPrint "    CMD0"
  SET SD_Adaper_CS OFF
  wait 500 ms
  SET SD_Adaper_CS ON
                                 'sembra necessario
  do while SDResponse <> 0x01
    SD_Counter=0
    SET SD_Adaper_CS ON
    SendDummyBytes (10)         'lascia SD_Adaper_CS Off
    wait 50 ms
    SendCommand(0x40, 0x00000000, 0x95)
    do while SDResponse <> 0x01 and SD_Counter<50
       GetSDResponse(1,SDResponse)
    Loop
  Loop
  SET SD_Adaper_CS ON
  sertxd(1,"-CMD0 ","  Executed",0)
end sub

sub CallCMD8

  SDResponse=100
  Counter=0
  do until SDResponse = 0x01 or SDResponse = 0x05 or SD_Counter >50
    SD_Counter=SD_Counter+1
    SendCommand(0x48, 0x000001AA, 0x87) 'return R7 response
    GetSDResponse(1,SDResponse)
    GetSDResponse(3,SDResponse2)
    GetSDResponse(1,SDResponse3)
    GetSDResponse(1,SDData)
  loop
  SET SD_Adaper_CS ON
  if SD_Counter >50  then
    sertxd(1,"-CMD8 ","failed.",0)
  else
    if SDResponse=0x01 then
      sertxd(1,"-CMD8 ","  Executed.",0):sertxd(1,"        Card"," is V2",0)
    end if
    if SDResponse=0x05 then
      sertxd(1,"-CMD8  "," Executed.",0):sertxd(1,"        Card"," is V1",0)
    end if
    If SDResponse3=0xAA then
      sertxd(1,"    ","   ",0)
      sertxd(0," The CMD8 check ","pattern is confirmed",0)
    else
      sertxd(1,"    ","   ",0)
      sertxd(0," The CMD8 check ","pattern is not confirmed",0):sertxd(0, "SDResponse3=",SDResponse3,0)
    end if
    If SDResponse2=1 then
      sertxd(1,"    ","   ",0)
      sertxd(0," The CMD8 confirm ","voltage Card",0)
    else
      sertxd(1,"    ","   ",0)
      sertxd(0," The CMD8 does not ","confirm Voltage Card",0):sertxd(0, "SDResponse2=",SDResponse2,0)
    end if
  end if

end sub

sub CallACMD41

  SD_Counter=0
  SD_Counter1=0
  repeat 1000'  do while SDResponse <> 0x00
      SD_Counter=SD_Counter+1
      SDResponse=100
      SDResponse2=100
      SD_Counter1=1
      SendCommand(0x77, 0x00000000, 0xFF)       'CMD55
      do until SDResponse2<2 or SD_Counter1 > 100
        GetSDResponse(1,SDResponse2)
        SD_Counter1=SD_Counter1+1
      loop
      SD_Counter1=1
      SendCommand(0x69, 0x40000000, 0xFF)       'CMD41
      do until SDResponse<2 or SD_Counter1 > 100
        GetSDResponse(1,SDResponse)
        SD_Counter1=SD_Counter1+1
      loop
'      set SD_Adaper_CS ON
      if SDResponse=0  then
        exit repeat
      end if
  end repeat
  sertxd(1,"-ACMD41 ","Executed.",0):sertxd(0," after ",SD_Counter,0):sertxd(0," attempts","   ",0)
  sertxd(1,"        CMD41 Response=",SDResponse,0):sertxd(0," CMD55 Response=",SDResponse2,0)

end sub

sub CallCMD58

  INITSucc=0
  SDResponse=100
'  SDResponse2=100
'  SDResponse3=100
  SD_Counter=0
  repeat 1000
    SD_Counter=SD_Counter+1
    SendCommand(0x7A, 0x00000000, 0xFF) 'return R3 response
    repeat 50
      GetSDResponse(1,SDResponse)
      if SDResponse=0 then
        exit repeat
      end if
    end repeat

    repeat 50
      GetSDResponse(1,SDResponse2)
      if SDResponse2<>255 then
        exit repeat
      end if
    end repeat

    repeat 50
      GetSDResponse(1,SDResponse3)
      if SDResponse3<>255 then
        exit repeat
      end if
    end repeat

    repeat 50
      GetSDResponse(1,SDResponse4)
      if SDResponse4<>255 then
        exit repeat
      end if
    end repeat
    repeat 50
      GetSDResponse(1,SDResponse5)
      if SDResponse2<>255 then
        exit repeat
      end if
    end repeat

    if SDResponse=0 then
      exit repeat
    end if
  end repeat
'  set SD_Adaper_CS ON

  if  SDResponse=0 then
    INITSucc=1
    sertxd(1,"-CMD58 "," Executed OK. ",0):sertxd(0,"Attempts number=",SD_SD_Counter,0)
    sertxd(1,"        First SDResponse=",SDResponse,0)
    sertxd(1,"        SDResponses2-3-4-5=(",SDResponse2,0)
    sertxd(0,",",SDResponse3,0):sertxd(0,",",SDResponse4,0):sertxd(0,",",SDResponse5,0):sertxd(0,")"," ",0)
    If SDResponse2.6=0 then       'uses byte address data (nota 10 pag 222)
      sertxd(1,"        The Card is V2 SDSC ","with Standard capacity (CCS=0)",0)
    else                          'uses block address data
      sertxd(1,"        The Card is V2 SCXC or"," SDHC with Extended capacity (CCS=1)",0)
    end if
  else
  SET SD_Adaper_CS ON
    sertxd(1,"-CMD58 "," Executed !OK.",0):sertxd(0,"N. attempts=",SD_Counter,0)
    sertxd(1,"*","*",0)
  end if

end sub

sub CallCMD13

'  Set SD_Adaper_CS ON
  SDResponse=100
  SDResponse2=100
  SD_Counter=0
  repeat 1000
    SD_Counter=SD_Counter+1
    SendCommand(0x4D, 0x00000000, 0xFF)  'Return R2 response
    SD_Counter1=1
    do until SDResponse=0 or SD_Counter1=100
     GetSDResponse(1,SDResponse)
     SD_Counter1=SD_Counter1+1
    loop
    SD_Counter1=1
    do until SDResponse<>255 or SD_Counter1=100
     GetSDResponse(1,SDResponse2)
     SD_Counter1=SD_Counter1+1
    loop

    if SDResponse=0 then
        exit repeat
    end if
  end repeat
  if  SDResponse=0 then
    sertxd(1,"-CMD13 "," Executed OK. ",0):sertxd(0,"Attempts number=",SD_Counter,0)
    sertxd(1,"        First SDResponse=",SDResponse,0)
    sertxd(1,"        SDResponse2=",SDResponse2,0)
  else
    sertxd(1,"-CMD13 "," Executed !OK. ",0):sertxd(0,"N. attempts=",SD_Counter,0)
    sertxd(1,"        First SDResponse=",SDResponse,0)
    sertxd(1,"        SDResponse2=",SDResponse2,0)
  end if

end sub

sub CallCMD16

  SDResponse=100                  'Block size setting
  SD_Counter=0
  repeat 100
    SD_Counter=SD_Counter+1
    SD_Counter1=0
    sendCommand(0x51,512,0xFF)
    do until SDResponse=0 or SD_Counter1 > 100
      GetSDResponse(1,SDResponse)
      SD_Counter1=SD_Counter1+1
    loop
    if SDResponse=0 then
      exit repeat
    end if
  End Repeat

  if SDResponse=0 then
    sertxd(1,"-CMD16  OK  Executed","  ",0)
  else
    sertxd(1,"-CMD16  !OK Executed","  ",0)
  end if
  sertxd(0,"       Response=",SDResponse,0):sertxd(0,", SD_Counter=",SD_Counter,0)

end sub

sub SDRead_Block(in Block_Start as Long)

  SDResponse=100
  SDToken=100
  SD_Counter=0
  if Verbose="ON" then
    Draw_Line(2,20,"=")
    sertxd(1,"-CMD17  ","Waiting for Token",0)
    Draw_Line(2,20,"=")
  end if
  repeat 1000         'portato a 1000 da 100
    SD_Counter=SD_Counter+1
    HSerPrint ". "
    SD_Counter1=0
    SendCommand (0x51, Block_Start, 0xFF)    'CMD17
    do until SDResponse=0 or SD_Counter1 > 100
      GetSDResponse(1,SDResponse)
      SD_Counter1=SD_Counter1+1
    loop
    SD_Counter1=0
    do until SDToken=0xFE or SD_Counter1 > 1000
      GetSDResponse(1,SDToken)
      SD_Counter1=SD_Counter1+1
    loop

    if SDToken=0xFE and SDResponse=0 then
        if Verbose="ON" then
          Draw_Line(2,20,"=")
          sertxd(1,"-CMD17  OK ","Executed",0)
          sertxd(0,", First Response=",SDResponse,0):sertxd(0,", Token(254)=",SDToken,0)
          sertxd(0," n. attempts=",SD_Counter,0)
          Draw_Line(2,20,"=")
        end if
        exit repeat
    end if
  End Repeat
  SDByte=0
  if SDToken=0xFE  then
    Repeat 512
      SPITransfer 255, SDData
      SDDataBuffer(SDByte) = SDData
      SDByte += 1
    End Repeat
  else
    sertxd(1,"-CMD17  !OK Executed","  ",0)
    sertxd(0,", First Response=",SDResponse,0):sertxd(0,", Token(254)=",SDToken,0)
    END
  end if

end sub

sub Partition_Entry_and_Relevant_Data

    Draw_Line(1,60,"-")
    sertxd(1,"     Reading MBR at 0x1BE and ","Partition Volume ID data",0)
    Draw_Line(1,60,"-"):Draw_Line(1,60," ")

    Read_Partit_Entry          'Read Partition begin address at 0x1BE

    Read_Relevant_Partit_Data  'Read most relevant Partition Data

    sertxd(1,"  File System ",SD_MyString,0)
    sertxd(1,"  File System Ver Num.=",File_System_Ver_Num,0)
    sertxd(1,"  Volume_Label=",SD_MyString1,0)
    sertxd(1,"  N. Bytes per Sector=",N_Bytes_per_Sector,0)
    sertxd(1,"  N. Sector per Cluster=",N_Sector_per_cluster,0)
    sertxd(1,"  N. Reserved Sectors=",N_Reserved_Sector,0)
    sertxd(1,"  N. FATS=",N_FATS,0)
    sertxd(1,"  N. Sector per Fat=",N_Sectors_per_Fat,0)
    sertxd(1,"  N. Cluster of Root Dir=","2",0)

    Draw_Line(1,60," "): Draw_Line(2,30,"-"):Draw_Line(1,60," ")
    sertxd(1,"  Partition_Begin_LBA=",Partition_Begin_LBA,0)
    Fat_Begin_LBA=Partition_Begin_LBA+N_Reserved_Sector
    Cluster_Begin_LBA=Fat_Begin_LBA+N_FATS*N_Sectors_per_Fat
    sertxd(1,"  Fat_Begin_LBA=",Fat_Begin_LBA,0)
    sertxd(1,"  Cluster_Begin_LBA=",Cluster_Begin_LBA,0)
    Draw_Line(1,60,"-"): Draw_Line(1,60," ")


end sub

sub Read_Partit_Entry

    SDRead_Block(0)

    SDByte=446
    B0=SDDataBuffer(SDByte+8)
    B1=SDDataBuffer(SDByte+9)
    B2=SDDataBuffer(SDByte+10)
    B3=SDDataBuffer(SDByte+11)
    LSB_to_MSB(Partition_Begin_LBA)

end Sub

sub LSB_to_MSB(Output as Long)

    B1=FnLSL(B1,8)
    B2=FnLSL(B2,16)
    B3=FnLSL(B3,24)
    Output=B0+B1+B2+B3
end sub

Sub  Read_Relevant_Partit_Data

    SDRead_Block(Partition_Begin_LBA)

    B0=SDDataBuffer(11)
    B1=SDDataBuffer(12)
    N_Bytes_per_Sector=B0+FnLSL(B1,8)
    N_Sector_per_cluster=SDDataBuffer(13)
    B0=SDDataBuffer(14)
    B1=SDDataBuffer(15)
    N_Reserved_Sector=B0+FnLSL(B1,8)
    N_FATS=SDDataBuffer(16)
    B0=SDDataBuffer(36)
    B1=SDDataBuffer(37)
    B2=SDDataBuffer(38)
    B3=SDDataBuffer(39)
    LSB_to_MSB(N_Sectors_per_Fat)
    B0=SDDataBuffer(42)
    B1=SDDataBuffer(43)
    File_System_Ver_Num=B0+FnLSL(B1,8)
    N_Sector_of_FAT2=SDDataBuffer(50)
    SD_MyString1=CHR(SDDataBuffer(71))
    for SD_Counter=1 to 10
      SD_MyString2=SD_MyString1+CHR(SDDataBuffer(71+SD_Counter))
      SD_MyString1=SD_MyString2
    next
    SD_MyString=CHR(SDDataBuffer(82))
    for SD_Counter=1 to 7
      SD_MyString2=SD_MyString+CHR(SDDataBuffer(82+SD_Counter))
      SD_MyString=SD_MyString2
    next

End sub

sub Disk_Explorer(in Address_Sector as Long,in Name as String)

    dim boot_flag as Byte

    SDRead_Block(Address_Sector)

    SDLocation_last=Address_Sector
    if Address_Sector=Cluster_Begin_LBA then
      boot_Flag=1
    else
      boot_flag=0
    end if
    Record_Location=0  'ora la base di indirizzo è il byte 0 del blocco letto
    B0=100
    SD_Counter2=0     'SD_Counter, SD_Counter1 non utilizzabili perche usati da CallReadBlock
    ind1=0
    ind2=0
    do until B0 =0
      B1=SDDataBuffer(Record_Location)
      if B1<>0xE5 then
        B1=SDDataBuffer(Record_Location+11)
        if B1.0<>1 or B1.1<>1 or B1.2 <>1 or B1.3<>1  then
          If B1.4 =1  then                                'is a directory
            SD_MyString=CHR(SDDataBuffer(Record_Location))
            for SD_Counter3=1 to 7
                Dir_or_File_Name=SD_MyString+CHR(SDDataBuffer(Record_Location+SD_Counter3))
                SD_MyString=Dir_or_File_Name
            next
            ind1=ind1+1
            Dir_Record(ind1)=SD_Counter2
            if ind1=1 and ind2=0 then
              Draw_Line(1,60,"-")
              Draw_Line(1,8," "):Sertxd(0,"Directories and"," Files List in "+Name,0)
              Draw_Line(1,60,"-"):Draw_Line(1,60," ")
            end if
            sertxd(1,"  Dir  n.=",ind1,0):sertxd(0," "+CHR(254)+" ",Dir_or_File_Name,0)
            sertxd(0,"     at Record n.",Dir_Record(ind1),0)
          else
            SD_MyString=CHR(SDDataBuffer(Record_Location))    'is a file or Boot record
            for SD_Counter3=1 to 7
                Dir_or_File_Name=SD_MyString+CHR(SDDataBuffer(Record_Location+SD_Counter3))
                SD_MyString=Dir_or_File_Name
            next
            SD_MyString=CHR(SDDataBuffer(Record_Location+8))
            for SD_Counter3=1 to 2
                File_Extension=SD_MyString+CHR(SDDataBuffer(Record_Location+SD_Counter3+8))
                SD_MyString=File_Extension
            next
            ind2=ind2+1
            File_Record(ind2)=SD_Counter2
            if ind2=1 and ind1=0 then
              Draw_Line(1,60,"-")
              Draw_Line(1,8," "):Sertxd(0,"Directories and ","Files List in "+Name,0)
              Draw_Line(1,60,"-"):Draw_Line(1,60," ")
            end if
            if boot_flag=1 then
              if ind2=1 then
                sertxd(1,"  BOOT"," SECT.",0):sertxd(0,CHR(233)+" ",Dir_or_File_Name,0):sertxd(0,"  ","  ",0)
                sertxd(0," at Record n.",File_Record(ind2),0)
              else
                sertxd(1,"  File n.=",ind2-1,0):sertxd(0," "+CHR(233)+" ",Dir_or_File_Name,0):Sertxd(0,".",File_Extension,0)
                sertxd(0," at Record n.",File_Record(ind2),0)
              end if
            else
                sertxd(1,"  File n.=",ind2,0):sertxd(0," "+CHR(233)+" ",Dir_or_File_Name,0):Sertxd(0,".",File_Extension,0)
                sertxd(0," at Record n.",File_Record(ind2),0)
            end if
          end if
        end if
      end if
        Record_Location=Record_Location+32
        SD_Counter2=SD_Counter2+1
        if Record_Location=512 then
          Record_Location=0
          SDLocation_Last=Address_Sector+SD_Counter2/16
          SDRead_Block(SDLocation_Last)
        end if
        B0=SDDataBuffer(Record_Location)
      Loop
      Record_location_Last=Record_Location
      If Boot_Flag=1 then                      'NOTA: Per la presenza di BOOT,
        ind2=ind2-1                            ' le Info del file n-mo
        For ind1=1 to ind2                     ' in File_Record sono nell'elemento
          File_Record(ind1)=File_Record(ind1+1)' (n+1)-mo. Con queste istruzione
        Next                                   ' le si riportano all-n-mo
      End If
      if SD_Counter2>15 then

        SDRead_Block(Address_Sector) 'Necessario per ripristinare il buffer iniziale
        '                              'Naturalmente la poca RAM non consente di fare
      end if                           'diversamente
      Draw_Line(1,60,"-"):Draw_Line(1,60," ")
end sub

sub Read_Write_Image_Info(StepSize)

'    B0=SDDataBuffer(34)           'read image size
'    B1=SDDataBuffer(35)
'    B2=SDDataBuffer(36)
'    B3=SDDataBuffer(37)
'    LSB_to_MSB(B0)
'    Sertxd(1,"  Image Size=",B0,0)
'
'    B0=SDDataBuffer(18)           'read BitMap Width
'    B1=SDDataBuffer(19)
'    B2=SDDataBuffer(20)
'    B3=SDDataBuffer(21)
'    LSB_to_MSB(B0)
'    ImageWidth=B0
'    Sertxd(1,"  ImageWidth=",B0,0)
'
'    B0=SDDataBuffer(22)           'read BitMap Height
'    B1=SDDataBuffer(23)
'    B2=SDDataBuffer(24)
'    B3=SDDataBuffer(25)
'    LSB_to_MSB(B0)
'    ImageHeight=B0
'    Sertxd(1,"  Image Height=",B0,0)
'
'    B0=SDDataBuffer(10)           'read indirizzo inizio color pixel
'    B1=SDDataBuffer(11)           'rispetto allinizio del blocco header
'    B2=SDDataBuffer(12)
'    B3=SDDataBuffer(13)
'    LSB_to_MSB(B0)
'    StepSize=B0
'    Sertxd(1,"  N. of starting pixel byte (within header)=",B0,0)
end sub

sub Make_Picture(Step_Size)
'
'    y_Disp=0
'    for SD_Counter2=1 to ImageHeight       'SD_Counter1 e SD_Counter2 sono usati Da readBlock
'      x_Disp=0
'      for SD_Counter3=1 to ImageWidth
'        Blue_Color=SDDataBuffer(StepSize)
'        Blue_Color=Blue_Color/8
'        If StepSize=511 then          'RICORDA SDDATABuffer parte da 0 e arriva a 511 compreso
'          SDLocation=SDlocation+1
'          SDRead_Block(SDLocation)
'          StepSize=0
'        else
'          StepSize=StepSize+1
'        end if
'        Green_Color=SDDataBuffer(StepSize)
'        Green_Color=Green_Color/4
'        If StepSize=511 then
'          SDLocation=SDlocation+1
'          SDRead_Block(SDLocation)
'          StepSize=0
'        else
'          StepSize=StepSize+1
'        end if
'        Red_Color=SDDataBuffer(StepSize)
'        Red_Color=Red_Color/8
'        If StepSize=511 then
'          SDLocation=SDlocation+1
'          SDRead_Block(SDLocation)
'          StepSize=0
'        else
'          StepSize=StepSize+1
'        end if
'
'          Color=Blue_Color
'          SD_Counter=Green_Color   'Reusing SD_Counter bytes
'          Color=Color+FnLSL(SD_Counter,5)
'          SD_Counter=Red_Color
'          Color=Color+FnLSL(SD_Counter,11)
'
'        SET CS ON
'        SET GLCD_CS OFF
'        PSet_ST7735(x_Disp, y_Disp, Color)
'        SET GLCD_CS ON
'        SET CS OFF
'        x_disp=x_disp+1
'      next
'      y_disp=y_disp+1
'    next
end sub

sub SDWrite_Block(in Block_Start as Long, in Record_Start as word, in Location_Write as Long)

  if Record_start*Location_Write<>0 then

    SDRead_Block(Block_Start)

    Ind1=1
    Repeat 11
      SDByte=ASC(Mid(SD_MyString1,Ind1,1))
      SDDataBuffer(Record_Start+ind1-1) = SDByte
      Ind1 += 1
    End Repeat
    SDDataBuffer(Record_Start+11)=0
    B0=[byte]Location_Write
    B1=Location_Write_H
    B2=Location_Write_E
    B3=Location_Write_U
    SDDataBuffer(Record_Start+20)=B2
    SDDataBuffer(Record_Start+21)=B3
    SDDataBuffer(Record_Start+26)=B0
    SDDataBuffer(Record_Start+27)=B1
  end if
  SDResponse=100
  SDToken=100
  SD_Counter=0
  if Verbose="ON" then
    Draw_Line(2,20,"=")
    sertxd(1,"-CMD24  ","Waiting for Answer",0)
    Draw_Line(2,20,"=")
  end if
  repeat 100
    SD_Counter=SD_Counter+1
    HSerPrint "^ "
    SD_Counter1=0
    SendCommand (0x58, Block_Start, 0xFF)    'CMD24
    do until SDResponse=0 or SD_Counter1 > 100
      GetSDResponse(1,SDResponse)
      SD_Counter1=SD_Counter1+1
    loop
    SD_Counter1=0
    if SDResponse=0 then
        if Verbose="ON" then
          Draw_Line(2,20,"=")
          sertxd(1,"-CMD24  OK ","Executed",0)
          sertxd(0,", First Response=",SDResponse,0)
          sertxd(0," n. attempts=",Counter,0)
          Draw_Line(2,20,"=")
        end if
        exit repeat
    end if
  End Repeat
  if SDResponse=0 then
    ind2=0xFE
    SDByte=0
    SPITransfer Ind2, ind1          'Token inizio trasmissione
    ind2=0
    Repeat 512
      SPITransfer SDDataBuffer(SDByte), ind1
      SDByte += 1
    End Repeat
  else
    sertxd(1,"-CMD24  !OK Executed","  ",0)
    sertxd(0,", First Response=",SDResponse,0):sertxd(0,", Token(254)=",SDToken,0)
    END
  end if

end sub
