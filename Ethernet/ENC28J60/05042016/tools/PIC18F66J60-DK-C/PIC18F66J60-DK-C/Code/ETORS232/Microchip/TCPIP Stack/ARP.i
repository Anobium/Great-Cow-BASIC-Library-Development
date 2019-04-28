#line 1 "ARP.c"
#line 1 "ARP.c"

#line 59 "ARP.c"
 
#line 61 "ARP.c"



#line 65 "ARP.c"



#line 69 "ARP.c"
#line 70 "ARP.c"


#line 73 "ARP.c"
#line 74 "ARP.c"




#line 81 "ARP.c"



typedef struct _ARP_PACKET
{
    WORD        HardwareType;
    WORD        Protocol;
    BYTE        MACAddrLen;
    BYTE        ProtocolLen;
    WORD        Operation;
    MAC_ADDR    SenderMACAddr;
    IP_ADDR     SenderIPAddr;
    MAC_ADDR    TargetMACAddr;
    IP_ADDR     TargetIPAddr;
} ARP_PACKET;


static void SwapARPPacket(ARP_PACKET *p);
static BOOL ARPPut(ARP_PACKET *packet);




#line 119 "ARP.c"
 
static BOOL ARPPut(ARP_PACKET *packet)
{
	while(!MACIsTxReady());
	MACSetWritePtr(BASE_TX_ADDR);
	

    packet->HardwareType  = (0x0001u) ;
    packet->Protocol      = (0x0800u) ;
    packet->MACAddrLen    = sizeof(MAC_ADDR);
    packet->ProtocolLen   = sizeof(IP_ADDR);

	memcpy(&packet->SenderMACAddr, (void*)&AppConfig.MyMACAddr, sizeof(packet->SenderMACAddr));
    packet->SenderIPAddr  = AppConfig.MyIPAddr;

    SwapARPPacket(packet);

    MACPutHeader(&packet->TargetMACAddr, MAC_ARP, sizeof(*packet));
    MACPutArray((BYTE*)packet, sizeof(*packet));
    MACFlush();
	
	return TRUE;
}




#line 159 "ARP.c"
 
#line 173 "ARP.c"




#line 191 "ARP.c"
 
BOOL ARPProcess(void)
{
	ARP_PACKET packet;
	static NODE_INFO Target;
	static enum
	{
	    SM_ARP_IDLE,
	    SM_ARP_REPLY
	} smARP = SM_ARP_IDLE;

    switch(smARP)
    {
	    case SM_ARP_IDLE:
			
		    MACGetArray((BYTE*)&packet, sizeof(packet));		
		    MACDiscardRx();
		    SwapARPPacket(&packet);
		
			
		    if ( packet.HardwareType != (0x0001u)      ||
		         packet.MACAddrLen != sizeof(MAC_ADDR)  ||
		         packet.ProtocolLen != sizeof(IP_ADDR) )
		    {
		         return TRUE;
		    }
		
			
#line 227 "ARP.c"

			
			if(packet.Operation == 0x01u )
			{
				if(packet.TargetIPAddr.Val != AppConfig.MyIPAddr.Val)
				{
					return TRUE;
				}
				Target.IPAddr = packet.SenderIPAddr;
				Target.MACAddr = packet.SenderMACAddr;

				smARP = SM_ARP_REPLY;
			}
			

	    case SM_ARP_REPLY:
	        packet.Operation		= 0x02u ;
    	    packet.TargetMACAddr	= Target.MACAddr;
    	    packet.TargetIPAddr		= Target.IPAddr;

			
			if(!ARPPut(&packet))
			{
	           return FALSE;
			}

			
			smARP = SM_ARP_IDLE;
	        break;
	}

    return TRUE;
}



#line 277 "ARP.c"
 
#line 298 "ARP.c"




#line 320 "ARP.c"
 
#line 332 "ARP.c"




#line 349 "ARP.c"
 
static void SwapARPPacket(ARP_PACKET *p)
{
    p->HardwareType     = swaps(p->HardwareType);
    p->Protocol         = swaps(p->Protocol);
    p->Operation        = swaps(p->Operation);
}

#line 358 "ARP.c"
