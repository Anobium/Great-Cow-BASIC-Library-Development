#pragma once

#include "stdio.h"
#include <wtypes.h>
#include <string>
#include "Usb.h"
#include <iostream>
#include <stdlib.h>

#include "TString.h"

namespace My16FUSB_HID_DioSampleAPP {

	using namespace System;
	using namespace System::ComponentModel;
	using namespace System::Collections;
	using namespace System::Windows::Forms;
	using namespace System::Data;
	using namespace std;
	using namespace System::Drawing;
	
	using namespace System::Threading;

	/// <summary>
	/// Summary for Form1
	/// </summary>
	public ref class Form1 : public System::Windows::Forms::Form
	{
		delegate void SetCheckDelegate();
	public:
		Form1(void)
		{
			InitializeComponent();
			
			 usb = gcnew Usb();
			 usb->VendorID = 0x04D8;
			 usb->ProductID = 0x0628;

			 if(usb->findDevice()) {
				this->toolStripStatuslabel1->Text = "Device Connected";

				usb->openReadHandle();
				bgWorker = gcnew System::ComponentModel::BackgroundWorker();
				bgWorker->DoWork += gcnew DoWorkEventHandler( this, &Form1::inputThread );
				bgWorker->RunWorkerAsync();

				usb->openWriteHandle();
			 } else {
				System::Windows::Forms::MessageBox::Show( L"Device not found!", L"16FUSB", 
					System::Windows::Forms::MessageBoxButtons::OK);				
			 }
		}

	protected:
		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		~Form1()
		{
			if (components)
			{
				delete components;
			}
		}

	private: System::Windows::Forms::GroupBox^  groupBox1;
	private: System::Windows::Forms::GroupBox^  groupBox2;
	private: System::Windows::Forms::TextBox^  textBox1;
	private: System::Windows::Forms::TextBox^  textBox2;

	private: System::ComponentModel::IContainer^  components;
	protected: 

	private:
		/// <summary>
		/// Required designer variable.
		/// </summary>


			 
	private: System::Windows::Forms::StatusStrip^  statusStrip1;
	private: System::Windows::Forms::ToolStripStatusLabel^  toolStripStatuslabel1;

			 System::ComponentModel::BackgroundWorker^ bgWorker;

			 Usb^ usb;
			 			 

#pragma region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		void InitializeComponent(void)
		{
			this->groupBox1 = (gcnew System::Windows::Forms::GroupBox());
			this->groupBox2 = (gcnew System::Windows::Forms::GroupBox());
			this->textBox1 = (gcnew System::Windows::Forms::TextBox());
			this->textBox2 = (gcnew System::Windows::Forms::TextBox());
			this->statusStrip1 = (gcnew System::Windows::Forms::StatusStrip());
			this->toolStripStatuslabel1 = (gcnew System::Windows::Forms::ToolStripStatusLabel());
			this->groupBox1->SuspendLayout();
			this->groupBox2->SuspendLayout();
			this->statusStrip1->SuspendLayout();
			this->SuspendLayout();
			// 
			// groupBox1
			// 
			this->groupBox1->Controls->Add(this->textBox1);
			this->groupBox1->Location = System::Drawing::Point(30, 93);
			this->groupBox1->Name = L"groupBox1";
			this->groupBox1->Size = System::Drawing::Size(256, 73);
			this->groupBox1->TabIndex = 1;
			this->groupBox1->TabStop = false;
			this->groupBox1->Text = L"Send to Serial";
			// 
			// groupBox2
			// 
			this->groupBox2->Controls->Add(this->textBox2);
			this->groupBox2->Location = System::Drawing::Point(30, 13);
			this->groupBox2->Name = L"groupBox2";
			this->groupBox2->Size = System::Drawing::Size(256, 73);
			this->groupBox2->TabIndex = 2;
			this->groupBox2->TabStop = false;
			this->groupBox2->Text = L"Recive from Serial";
			// 
			// textBox1
			// 
			this->textBox1->Location = System::Drawing::Point(18, 33);
			this->textBox1->Multiline = true;
			this->textBox1->Name = L"textBox1";
			this->textBox1->Size = System::Drawing::Size(200, 30);
			this->textBox1->TabIndex = 0;
			this->textBox1->KeyPress += gcnew KeyPressEventHandler(this, &Form1::textBox1_KeyPress);
			// 
			// textBox2
			// 
			this->textBox2->Location = System::Drawing::Point(18, 33);
			this->textBox2->Multiline = true;
			this->textBox2->Name = L"textBox2";
			this->textBox2->Size = System::Drawing::Size(200, 30);
			this->textBox2->TabIndex = 0;
			this->textBox2->ReadOnly = true;
			// 
			// statusStrip1
			// 
			this->statusStrip1->Items->AddRange(gcnew cli::array< System::Windows::Forms::ToolStripItem^  >(1) {this->toolStripStatuslabel1});
			this->statusStrip1->Location = System::Drawing::Point(0, 197);
			this->statusStrip1->Name = L"statusStrip1";
			this->statusStrip1->Size = System::Drawing::Size(319, 22);
			this->statusStrip1->TabIndex = 4;
			this->statusStrip1->Text = L"statusStrip1";
			// 
			// toolStripStatuslabel1
			// 
			this->toolStripStatuslabel1->Name = L"toolStripStatuslabel1";
			this->toolStripStatuslabel1->Size = System::Drawing::Size(0, 17);
			// 
			// Form1
			// 
			this->AutoScaleDimensions = System::Drawing::SizeF(6, 13);
			this->AutoScaleMode = System::Windows::Forms::AutoScaleMode::Font;
			this->ClientSize = System::Drawing::Size(319, 219);
			this->Controls->Add(this->statusStrip1);
			this->Controls->Add(this->groupBox2);
			this->Controls->Add(this->groupBox1);
			this->Name = L"Form1";
			this->Text = L"16FUSB Serial HID Sample App";
			this->Load += gcnew System::EventHandler(this, &Form1::Form1_Load);
			this->groupBox1->ResumeLayout(false);
			this->groupBox1->PerformLayout();
			this->groupBox2->ResumeLayout(false);
			this->groupBox2->PerformLayout();
			this->statusStrip1->ResumeLayout(false);
			this->statusStrip1->PerformLayout();
			this->ResumeLayout(false);
			this->PerformLayout();

		}
#pragma endregion

private: System::Void Form1_Load(System::Object^  sender, System::EventArgs^  e) {
			 if(this->toolStripStatuslabel1->Text == "") {
				Application::Exit();
			 }			 
		 }

private: System::Void inputThread( Object^ sender, DoWorkEventArgs^ e ) {
			 
			 unsigned char *inputReport;
			 
			 while(true) {
				 char buf[] = "1";
				 char* orig = buf;
				 cout << orig << "(char *)" << endl;
				 
				 inputReport = usb->readReport();
			  	 
			  	 char temp = inputReport[1];
				 
			  	 buf[0] = temp;
			  	 
			  	 String^ systemstring = gcnew String(orig);
    			 Console::WriteLine("{0}", systemstring);
    			 delete systemstring;
			  	 
				 textBox2->AppendText(systemstring);
			 }
		 }

private: System::Void textBox1_KeyPress(Object^ sender, KeyPressEventArgs^ e) {
			
			unsigned char outputReport[2];
			outputReport[0] = 0;
			outputReport[1] = Convert::ToInt32(e->KeyChar);
			usb->writeReport(outputReport);
		 }

};

}

