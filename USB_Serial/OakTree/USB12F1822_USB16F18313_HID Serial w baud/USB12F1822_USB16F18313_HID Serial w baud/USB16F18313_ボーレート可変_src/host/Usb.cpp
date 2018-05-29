#include "StdAfx.h"
#include "Usb.h"

	HANDLE								DeviceHandle;
	HANDLE								WriteHandle;
	HANDLE								ReadHandle;

	PSP_DEVICE_INTERFACE_DETAIL_DATA	detailData;

	unsigned char inputReport[5];
	DWORD bytesRead = 0;
	DWORD bytesWritten = 0;


Usb::Usb(void)
{
	DeviceHandle = NULL;
	ReadHandle	 = NULL;
	WriteHandle  = NULL;
}


bool Usb::findDevice() {
	
	SP_DEVICE_INTERFACE_DATA			devInfoData;
	HIDD_ATTRIBUTES						Attributes;
	GUID								HidGuid;
	HANDLE								hDevInfo;
	LONG								Result;
	ULONG								Required;

	ULONG Length = 0;
	detailData = NULL;
	DeviceHandle = NULL;

	int	MemberIndex = 0;
	bool LastDevice = FALSE;

	HidD_GetHidGuid(&HidGuid);

	hDevInfo = SetupDiGetClassDevs 
		(&HidGuid, 
		NULL, 
		NULL, 
		DIGCF_PRESENT|DIGCF_INTERFACEDEVICE);
		
	devInfoData.cbSize = sizeof(devInfoData);

	while(true) {

		Result = SetupDiEnumDeviceInterfaces 
				(hDevInfo, 
				0, 
				&HidGuid, 
				MemberIndex, 
				&devInfoData);
	
		if(Result == 0) {
			return false;
		} else {

			Result = SetupDiGetDeviceInterfaceDetail 
				(hDevInfo, 
				&devInfoData, 
				NULL, 
				0, 
				&Length, 
				NULL);

			detailData = (PSP_DEVICE_INTERFACE_DETAIL_DATA)malloc(Length);
			detailData->cbSize = sizeof(SP_DEVICE_INTERFACE_DETAIL_DATA);

			Result = SetupDiGetDeviceInterfaceDetail 
				(hDevInfo, 
				&devInfoData, 
				detailData, 
				Length, 
				&Required, 
				NULL);

			DeviceHandle = CreateFile 
				(detailData->DevicePath, 
				0, 
				FILE_SHARE_READ|FILE_SHARE_WRITE, 
				(LPSECURITY_ATTRIBUTES)NULL,
				OPEN_EXISTING, 
				0,
				NULL);

			Attributes.Size = sizeof(Attributes);

			Result = HidD_GetAttributes 
				(DeviceHandle, 
				&Attributes);

			if (Attributes.VendorID == VendorID && Attributes.ProductID == ProductID) {
				return true;
			}

			MemberIndex++;
		}

		
	}

}

HANDLE Usb::openReadHandle() {
	if(ReadHandle == NULL) {
		ReadHandle = CreateFile(
		detailData->DevicePath, 
		GENERIC_READ, 
		FILE_SHARE_READ|FILE_SHARE_WRITE,
		(LPSECURITY_ATTRIBUTES)NULL, 
		OPEN_EXISTING, 
		0, 
		NULL);
	}

	return ReadHandle;
}

unsigned char *Usb::readReport() {
	inputReport[0] = 0;

	ReadFile 
		(ReadHandle, 
		inputReport, 
		2, 
		&bytesRead,
		0);

	return inputReport;
}

unsigned char *Usb::readReport2() {
	inputReport[0] = 0;

	ReadFile 
		(ReadHandle, 
		inputReport, 
		3, 
		&bytesRead,
		0);

	return inputReport;
}

unsigned char *Usb::readReport4() {
	inputReport[0] = 0;

	ReadFile 
		(ReadHandle, 
		inputReport, 
		5, 
		&bytesRead,
		0);

	return inputReport;
}

HANDLE Usb::openWriteHandle() {
	if(WriteHandle == NULL) {
		WriteHandle = CreateFile(
			detailData->DevicePath, 
			GENERIC_WRITE, 
			FILE_SHARE_READ|FILE_SHARE_WRITE, 
			(LPSECURITY_ATTRIBUTES)NULL,
			OPEN_EXISTING, 
			0, 
			NULL);
	}

	return WriteHandle;
}

int Usb::writeReport(unsigned char *outputReport) {	
	WriteFile 
		(WriteHandle, 
		outputReport, 
		2, 
		&bytesWritten, 
		NULL);

	return bytesWritten;
}

int Usb::writeReport2(unsigned char *outputReport) {	
	WriteFile 
		(WriteHandle, 
		outputReport, 
		3, 
		&bytesWritten, 
		NULL);

	return bytesWritten;
}

int Usb::writeReport4(unsigned char *outputReport) {	
	WriteFile 
		(WriteHandle, 
		outputReport, 
		5, 
		&bytesWritten, 
		NULL);

	return bytesWritten;
}
