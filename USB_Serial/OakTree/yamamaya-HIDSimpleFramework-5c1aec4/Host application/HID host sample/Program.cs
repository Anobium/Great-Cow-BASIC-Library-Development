using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;

namespace HID_host_sample {
    static class Program {
        /// <summary>
        /// It is the main entry point of the application。
        /// </summary>
        [STAThread]
        static void Main() {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault( false );
            Application.Run( new Form1() );
        }
    }
}
