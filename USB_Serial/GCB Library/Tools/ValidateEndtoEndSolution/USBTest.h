/*
 * Lego Tower test driver class
 */
 
#ifndef USBTEST_H
#define USBTEST_H

#include <lusb0_usb.h>

class USBTest{
	private:
		usb_dev_handle* dev;
		usb_dev_handle* open_dev(void);
		struct usb_device* testDevice;
		
		int bConfigurationValue;
		int wMaxPacketSize;
		
	public:
		USBTest();
		~USBTest();
		void demo(int testData);
};
	
#endif