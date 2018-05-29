/*
 * Great Cow USB test driver class
 */

#include "USBTest.h"
#include <lusb0_usb.h>
#include <stdio.h>
#include <iostream>
#include <windows.h>
using namespace std;

#define TEST_VID 0xF055
#define TEST_PID 0x1000

// Endpoints for device to host and host to device interrupt transfers
#define EP_D2H 0x80
#define EP_H2D 0

#define BUF_SIZE 64
#define MY_INTF 0 // Same for this

USBTest::USBTest(){
	
    char tmp[BUF_SIZE];
    int ret;
    void* async_read_context = NULL;
    void* async_write_context = NULL;

    // Find tower
	dev = NULL; /* the device handle */
	usb_init(); /* initialize the library */
    usb_find_busses(); /* find all busses */
    usb_find_devices(); /* find all connected devices */
	dev = open_dev();
    if (dev != NULL){
		cout << "Test device found\n";
		
		// Get information on tower
		bConfigurationValue = testDevice->config->bConfigurationValue;
		
		//wMaxPacketSize = testDevice->config->interface->altsetting->endpoint->wMaxPacketSize;
		//cout << wMaxPacketSize << '\n';
		//cout << (int)testDevice->config->interface->altsetting->endpoint->bEndpointAddress << '\n';
		
		// Set configuration
		if (usb_set_configuration(dev, bConfigurationValue) < 0) {
			printf("error setting config #%d: %s\n", bConfigurationValue, usb_strerror());
			usb_close(dev);
		} else {
			
			//Claim interface
			if (usb_claim_interface(dev, 0) < 0)
			{
				printf("error claiming interface #%d:\n%s\n", MY_INTF, usb_strerror());
				usb_close(dev);
			} else {
				//printf("success: claim_interface #%d\n", MY_INTF);
				
			}
			
		}
		
    } else {
		throw "Test device not found";
	}
}

USBTest::~USBTest(){
	usb_release_interface(dev, 0);
	if (dev)
    {
        usb_close(dev);
    }
}

/*
 Searches all USB busses and devices to find a device with the given VID and PID
 Adapted from bulk.c example
 */
usb_dev_handle* USBTest::open_dev(void)
{
    struct usb_bus *bus;
    struct usb_device *dev;

    for (bus = usb_get_busses(); bus; bus = bus->next) {
        for (dev = bus->devices; dev; dev = dev->next) {
            if (dev->descriptor.idVendor == TEST_VID && dev->descriptor.idProduct == TEST_PID){
                testDevice = dev;
				return usb_open(dev);
            }
        }
    }
    return NULL;
}

/*
 Performs some sort of demo operation
 */
void USBTest::demo(int testData){
	int stat;
	char replyBuffer[128];
	
	if (dev == NULL) return;
	
	//int usb_control_msg(usb_dev_handle *dev, int requesttype, int request, int value, int index, char *bytes, int size, int timeout);
	//stat = usb_control_msg(dev, USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_ENDPOINT_IN, LTW_REQ_SET_LED, LTW_LED_VLL + (LTW_LED_COLOR_OFF << 8), 0, replyBuffer, sizeof(LTW_REQ_GET_SET_LED_REPLY), 5000);
	switch (testData){
		case 0:
			stat = usb_control_msg(dev, USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_ENDPOINT_OUT, 132, 1, 0, replyBuffer, 0, 1000);
			break;
		case 1:
			stat = usb_control_msg(dev, USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_ENDPOINT_OUT, 131, 1, 0, replyBuffer, 0, 1000);
			break;
		default:
			stat = usb_control_msg(dev, USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_ENDPOINT_IN, 133, 1, 0, replyBuffer, 8, 1000);
			for (int i = 0; i < 4; i += 1) {
				cout << "Read" << i << ": " << ((unsigned int)replyBuffer[i * 2] & 255) + ((unsigned int)replyBuffer[i * 2 + 1] & 255) * 256 << '\n';
			}
			break;
	}
	
	cout << "Status: " << stat << '\n';
	
}
