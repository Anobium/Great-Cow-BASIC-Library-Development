// 16FUSB_HID_DioSampleAPP.cpp : main project file.

#include "stdafx.h"
#include "Form1.h"

using namespace My16FUSB_HID_DioSampleAPP;

[STAThreadAttribute]
int main(array<System::String ^> ^args)
{
	// Enabling Windows XP visual effects before any controls are created
	Application::EnableVisualStyles();
	Application::SetCompatibleTextRenderingDefault(false); 

	// Create the main window and run it
	Application::Run(gcnew Form1());
	return 0;
}
