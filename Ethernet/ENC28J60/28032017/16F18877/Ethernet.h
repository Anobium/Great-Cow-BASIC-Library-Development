''FILE:Ethernet.h
'    Ethernet setup and buffer definitions for the GCBASIC compiler
'    Copyright (C) 2017 Evan Venn

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

'    Notes
'    28/03/2017 Initial release


'Ethernet Hardware types
#define ETHERNET_TYPE_ENC28j60 1



    dim macaddr(6)
    dim ipaddr(4)
    dim ipserver(4)
    dim iprouter(4)
    dim macaddrrouter(4)
    dim sntpserveraddr(4)
    dim ipport as byte
    #define etherBufferSize 730
    dim etherbuffer(etherBufferSize)
    dim nextpacketptr as word
    dim I_checksum16 as word
    dim I_value16 as word alias I_checksum16_H, I_checksum16
    Dim Ip_id As Word
    dim T_udp_destport as word
    Dim hulp2 As Word
    Dim Incoming_ack as Long
    dim commandlineString as string * 12
    dim arrayloc,TableLoc as word
    dim HTTPStandardHeaderStatusBit as Byte
    dim HTTPSentTCPPacket, lastGet as byte
    dim TCPresult16, TableStartPoint as word
    #define HTTPPrintCRLF 1

sub EtherParameters

        macaddr =   0x00, 0x00, 0x00, 0x00, 0x00, 0x00
        ipaddr =    0,0,0,0
        ipserver =  0,0,0,0
        ipport = 80   'set a default value



        Ip_id = 0

'an outstanding GET is a pending flag
        lastGet = 0
        TableStartPoint =1
end sub



'Recommend not to change any of this definitions.

'IP Header Size
    #define IP_HeaderSize 14


'These defines all refer to the defined array - etherbuffer
    dim etherbuffer(etherBufferSize)



'Ethernet packet destination
    #Define T_enetpacketdest0 etherbuffer(0x01)
    #Define T_enetpacketdest1 etherbuffer(0x02)
    #Define T_enetpacketdest2 etherbuffer(0x03)
    #Define T_enetpacketdest3 etherbuffer(0x04)
    #Define T_enetpacketdest4 etherbuffer(0x05)
    #Define T_enetpacketdest5 etherbuffer(0x06)

'Ethernet packet source
    #Define T_enetpacketsrc0 etherbuffer(0x07)
    #Define T_enetpacketsrc1 etherbuffer(0x08)
    #Define T_enetpacketsrc2 etherbuffer(0x09)
    #Define T_enetpacketsrc3 etherbuffer(0x0A)
    #Define T_enetpacketsrc4 etherbuffer(0x0B)
    #Define T_enetpacketsrc5 etherbuffer(0x0C)

'Ethernet packet type
    '#Define T_enetpackettype As Word
    #Define T_enetpackettype0 etherbuffer(0x0D)
    #Define T_enetpackettype1 etherbuffer(0x0E)

'ARP definitions

    #Define T_arp_hwtype1 etherbuffer(0x10)

    #Define T_arp_prttype1 etherbuffer(0x12)
    #Define T_arp_hwlen etherbuffer(0x13)
    #Define T_arp_prlen etherbuffer(0x14)
    #Define T_arp_op1 etherbuffer(0x16)

'ARP source ip address
    '#Define T_arp_sipaddr As Long
    #Define T_arp_sipaddr0 etherbuffer(0x1D)
    #Define T_arp_sipaddr1 etherbuffer(0x1E)
    #Define T_arp_sipaddr2 etherbuffer(0x1F)
    #Define T_arp_sipaddr3 etherbuffer(0x20)

'ARP target IP address
    '#Define T_arp_tipaddr As Long
    #Define T_arp_tipaddr0 etherbuffer(0x27)
    #Define T_arp_tipaddr1 etherbuffer(0x28)
    #Define T_arp_tipaddr2 etherbuffer(0x29)
    #Define T_arp_tipaddr3 etherbuffer(0x2A)


'IP header layout IP version and header length
    #Define T_ip_header_pointer0 0x0F
    #Define T_ip_header_pointer1 0x21

'IP version and hardware type
    #Define T_ip_vers_len etherbuffer(0x0F)
    #Define T_arp_hwtype0 etherbuffer(0x0F)
'ARP definitions

    #Define T_arp_prttype0 etherbuffer(0x11)
    #Define T_arp_op0 etherbuffer(0x15)

'ARP source mac address
    #Define T_arp_src_enetpacket0 etherbuffer(0x17)
    #Define T_arp_src_enetpacket1 etherbuffer(0x18)
    #Define T_arp_src_enetpacket2 etherbuffer(0x19)
    #Define T_arp_src_enetpacket3 etherbuffer(0x1A)
    #Define T_arp_src_enetpacket4 etherbuffer(0x1B)
    #Define T_arp_src_enetpacket5 etherbuffer(0x1C)
'ARP source mac address
    #Define T_arp_dest_enetpacket0 etherbuffer(0x21)
    #Define T_arp_dest_enetpacket1 etherbuffer(0x22)
    #Define T_arp_dest_enetpacket2 etherbuffer(0x23)
    #Define T_arp_dest_enetpacket3 etherbuffer(0x24)
    #Define T_arp_dest_enetpacket4 etherbuffer(0x25)
    #Define T_arp_dest_enetpacket5 etherbuffer(0x26)

'TOS
    #Define T_tos etherbuffer(0x10)

'Packet Buffer length
    #Define T_ip_pktlen0 etherbuffer(0x11)
    #Define T_ip_pktlen1 etherbuffer(0x12)

'TCP buffers size, flags, offsets and ttl
    #Define T_id0 etherbuffer(0x13)
    #Define T_id1 etherbuffer(0x14)
    #Define T_flags etherbuffer(0x15)
    #Define T_offset etherbuffer(0x16)
    #Define T_ttl etherbuffer(0x17)

'Protocol type (ICMP=1, TCP=6, UDP=11)
    #Define T_ip_proto etherbuffer(0x18)

'Header checksum
    #Define T_ip_hdr_cksum0_pointer 0x19
    #Define T_ip_hdr_cksum0 etherbuffer(0x19)
    #Define T_ip_hdr_cksum1 etherbuffer(0x1A)

    '#Define T_ip_hdr_cksum As Word

'IP address of source
    #Define T_ip_srcaddr0 etherbuffer(0x1B)
    #Define T_ip_srcaddr1 etherbuffer(0x1C)
    #Define T_ip_srcaddr2 etherbuffer(0x1D)
    #Define T_ip_srcaddr3 etherbuffer(0x1E)
    '#Define T_ip_srcaddr As Long

'IP address of destination
    #Define T_ip_destaddr0 etherbuffer(0x1F)
    #Define T_ip_destaddr1 etherbuffer(0x20)
    #Define T_ip_destaddr2 etherbuffer(0x21)
    #Define T_ip_destaddr3 etherbuffer(0x22)
    '#Define T_ip_destaddr As Long

'ICMP parameters
    #Define T_icmp_type etherbuffer(0x23)
    #Define T_icmp_code etherbuffer(0x24)
    #Define T_icmp_cksum0 etherbuffer(0x25)
    #Define T_icmp_cksum1 etherbuffer(0x26)
    '#Define T_icmp_cksum As Word

'TCP Source port
    #Define Tcp_srcporth etherbuffer(0x23)
    #Define Tcp_srcportl etherbuffer(0x24)

'TCP Destination port
    #Define Tcp_destporth etherbuffer(0x25)
    #Define Tcp_destportl etherbuffer(0x26)

'TCP Sequence number
    #Define Tcp_seqnum3 etherbuffer(0x27)
    #Define Tcp_seqnum2 etherbuffer(0x28)
    #Define Tcp_seqnum1 etherbuffer(0x29)
    #Define Tcp_seqnum0 etherbuffer(0x2A)

'TCP Acknowledge number
    #Define Tcp_acknum3 etherbuffer(0x2B)
    #Define Tcp_acknum2 etherbuffer(0x2C)
    #Define Tcp_acknum1 etherbuffer(0x2D)
    #Define Tcp_acknum0 etherbuffer(0x2E)

'TCP Headets, flags and checksum
    #Define Tcp_hdr etherbuffer(0x2F)
    #Define Tcp_flags etherbuffer(0x30)
    #Define Tcp_cksum0 etherbuffer(0x33)
    #Define Tcp_cksum1 etherbuffer(0x34)
    '#Define Tcp_cksum As Word

'UDP source port
    #Define T_udp_srcport0 etherbuffer(0x23)
    #Define T_udp_srcport1 etherbuffer(0x24)
    '#Define T_udp_srcport As Word

'UDP destination port
    #Define T_udp_destport0 etherbuffer(0x25)
    #Define T_udp_destport1 etherbuffer(0x26)
    '#Define T_udp_destport As Word

'UDP length
  #Define T_udp_len0 etherbuffer(0x27)
  #Define T_udp_len1 etherbuffer(0x28)

'UDP checksum
  #Define T_udp_chksum0 etherbuffer(0x29)
  #Define T_udp_chksum1 etherbuffer(0x2A)

'UDP Data pointer
  #Define T_udp_data_pointer 0x2B

'UDP Data Buffer
    #Define T_udp_data etherbuffer(0x2B)
    #Define T_udp_data0 etherbuffer(0x2B)
    #Define T_udp_data1 etherbuffer(0x2C)
    #Define T_udp_data2 etherbuffer(0x2D)
    #Define T_udp_data3 etherbuffer(0x2E)
    #Define T_udp_data4 etherbuffer(0x2F)
    #Define T_udp_data5 etherbuffer(0x30)
    #Define T_udp_data6 etherbuffer(0x31)
    #Define T_udp_data7 etherbuffer(0x32)
    #Define T_udp_data8 etherbuffer(0x33)
    #Define T_udp_data9 etherbuffer(0x34)
    #Define T_udp_data10 etherbuffer(0x35)
    #Define T_udp_data11 etherbuffer(0x36)
    #Define T_udp_data12 etherbuffer(0x37)
    #Define T_udp_data13 etherbuffer(0x38)
    #Define T_udp_data14 etherbuffer(0x39)
    #Define T_udp_data15 etherbuffer(0x3A)
    #Define T_udp_data16 etherbuffer(0x3B)
    #Define T_udp_data17 etherbuffer(0x3C)
    #Define T_udp_data18 etherbuffer(0x3D)
    #Define T_udp_data19 etherbuffer(0x3E)
    #Define T_udp_data20 etherbuffer(0x3F)
    #Define T_udp_data21 etherbuffer(0x40)
    #Define T_udp_data22 etherbuffer(0x41)
    #Define T_udp_data23 etherbuffer(0x42)
    #Define T_udp_data24 etherbuffer(0x43)
    #Define T_udp_data25 etherbuffer(0x44)
    #Define T_udp_data26 etherbuffer(0x45)
    #Define T_udp_data27 etherbuffer(0x46)
    #Define T_udp_data28 etherbuffer(0x47)
    #Define T_udp_data29 etherbuffer(0x48)
    #Define T_udp_data30 etherbuffer(0x49)
    #Define T_udp_data31 etherbuffer(0x4A)
    #Define T_udp_data32 etherbuffer(0x4B)
