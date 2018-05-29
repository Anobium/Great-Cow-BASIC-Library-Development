using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace HID_host_sample {
    public partial class Form1 : Form {
        public Form1() {
            InitializeComponent();
        }

        private OaktreeLab.USBDevice.HIDSimple device =null;
        private Timer timer = null;

        private void buttonOpen_Click( object sender, EventArgs e ) {
            // Open HID Device
            device = new OaktreeLab.USBDevice.HIDSimple();
//            if ( device.Open( 0x04d8, 0x003f ) ) {
            if (device.Open(0x04D8, 0x0628))
                {

                    // Opened the target USB device

                    // Set our screen button states
                    buttonOpen.Enabled = false;
                buttonLEDOn.Enabled = true;
                buttonLEDOff.Enabled = true;
                // Timer Activation
                timer = new Timer();
                timer.Interval = 100;
                timer.Tick += new EventHandler( timer_Tick );
                timer.Start();

            } else {
                // Open failed - device not found
                MessageBox.Show( "Device not found" );
            }
        }

        private void Form1_FormClosed( object sender, FormClosedEventArgs e ) {
            if ( device != null ) {
                device.Dispose();
            }
            if ( timer != null ) {
                timer.Dispose();
            }
        }

        private void timer_Tick( object sender, EventArgs e ) {
            // Send packet by putting 0x01 in the first byte
            device.Send( 0x01 );
            // Receive packet from device
            byte[] res = device.Receive();
            if ( res[0] == 0 ) {
                textBoxSwitch.Text = "OFF";
            } else {
                textBoxSwitch.Text = "ON";
            }

            // Send packet by putting 0x02 in the first byte
            device.Send( 0x02 );
            // Receive packet from device
            res = device.Receive();
            uint value = (uint)res[0] * 256 + res[1];
            textBoxADC.Text = value.ToString();
        }

        private void buttonLEDOn_Click( object sender, EventArgs e ) {
            // Send a packet with 0x00 and 0x01 in the first 2 bytes
            device.Send( 0x00, 0x01 );
            // Receive packet from device
            device.Receive();
        }

        private void buttonLEDOff_Click( object sender, EventArgs e ) {
            // Send packet by putting 0x00, 0x00 in the first 2 bytes
            device.Send( 0x00, 0x00 );
            // Receive packet from device
            device.Receive();
        }

    }
}
