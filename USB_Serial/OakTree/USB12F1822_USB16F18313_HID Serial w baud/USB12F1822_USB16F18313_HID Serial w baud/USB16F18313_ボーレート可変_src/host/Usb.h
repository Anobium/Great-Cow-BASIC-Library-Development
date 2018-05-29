#pragma once

#include "stdio.h"

#include <wtypes.h>

extern "C" 
{
#include <initguid.h>
#include "hidsdi.h"
#include <setupapi.h>
#include <dbt.h>
}

ref class Usb
{
public:
	Usb(void);
	bool findDevice();	
	HANDLE openReadHandle();
	HANDLE openWriteHandle();
	unsigned char *readReport();
	int writeReport(unsigned char *);
	int VendorID;
	int ProductID;
	unsigned char *readReport2();
	int writeReport2(unsigned char *);
	unsigned char *readReport4();
	int writeReport4(unsigned char *);
};

