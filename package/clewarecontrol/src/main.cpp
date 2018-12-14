#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include "error.h"
#include "USBaccess.h"

CUSBaccess CWusb;
int USBcount = -1;
bool initted = false;

void init() {
  if (!initted) {
    USBcount = CWusb.OpenCleware();
    initted = true;
  }
}

int find_usb_id(int device_id) {
  for(int devID=0; devID<USBcount; devID++) {
    if (device_id == -1 || CWusb.GetSerialNumber(devID) == device_id)
      return devID;
  }
  return -1;
}

int main(int argc, char *argv[]) {
  int usb_id = -1;
  int device_id = -1;
  int red, green, orange;

  if(argc != 3+1) {
    fprintf(stderr, "%s 0|1 0|1 0|1\n", argv[0]);
    return -1;
  }

  // init
  init();

  // find device
  usb_id = find_usb_id(device_id);
  if (device_id == -1) {
    if (usb_id == -1) {
      fprintf(stderr, "No device found\n");
      if (getuid())
	fprintf(stderr, "Not running as root: does your current user have enough rights to access the device?\n");
      else
	fprintf(stderr, "You might need to use -p.\n");
      exit(1);
    }

    device_id = CWusb.GetSerialNumber(usb_id);
  } else if (usb_id == -1) {
    error_exit("Device %d not found", device_id);
  }

  // main
  red    = (atoi(argv[1]) == 1) ? 1 : 0;
  orange = (atoi(argv[2]) == 1) ? 1 : 0;
  green  = (atoi(argv[3]) == 1) ? 1 : 0;

  if (CWusb.SetLED(usb_id, (CUSBaccess::LED_IDs) 16, red))    {}
  if (CWusb.SetLED(usb_id, (CUSBaccess::LED_IDs) 17, orange)) {}
  if (CWusb.SetLED(usb_id, (CUSBaccess::LED_IDs) 18, green))  {}

  CWusb.CloseCleware();
  return 0;
}
