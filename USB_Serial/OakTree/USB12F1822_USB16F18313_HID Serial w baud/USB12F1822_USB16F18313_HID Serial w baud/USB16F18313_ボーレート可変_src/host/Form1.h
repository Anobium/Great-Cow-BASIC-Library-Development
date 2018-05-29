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
	private: System::Windows::Forms::GroupBox^  groupBox3;
	private: System::Windows::Forms::GroupBox^  groupBox4;
	private: System::Windows::Forms::TextBox^  textBox1;
	private: System::Windows::Forms::TextBox^  textBox2;
	private: System::Windows::Forms::ComboBox^  comboBox1;
	private: System::Windows::Forms::ComboBox^  comboBox2;

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
			this->groupBox3 = (gcnew System::Windows::Forms::GroupBox());
			this->groupBox4 = (gcnew System::Windows::Forms::GroupBox());
			this->textBox1 = (gcnew System::Windows::Forms::TextBox());
			this->textBox2 = (gcnew System::Windows::Forms::TextBox());
			this->comboBox1 = (gcnew System::Windows::Forms::ComboBox());
			this->comboBox2 = (gcnew System::Windows::Forms::ComboBox());
			this->statusStrip1 = (gcnew System::Windows::Forms::StatusStrip());
			this->toolStripStatuslabel1 = (gcnew System::Windows::Forms::ToolStripStatusLabel());
			this->groupBox1->SuspendLayout();
			this->groupBox2->SuspendLayout();
			this->groupBox3->SuspendLayout();
			this->groupBox4->SuspendLayout();
			this->statusStrip1->SuspendLayout();
			this->SuspendLayout();
			// 
			// groupBox1
			// 
			this->groupBox1->Controls->Add(this->textBox1);
			this->groupBox1->Location = System::Drawing::Point(30, 73);
			this->groupBox1->Name = L"groupBox1";
			this->groupBox1->Size = System::Drawing::Size(256, 50);
			this->groupBox1->TabIndex = 1;
			this->groupBox1->TabStop = false;
			this->groupBox1->Text = L"Send to Serial";
			// 
			// groupBox2
			// 
			this->groupBox2->Controls->Add(this->textBox2);
			this->groupBox2->Location = System::Drawing::Point(30, 13);
			this->groupBox2->Name = L"groupBox2";
			this->groupBox2->Size = System::Drawing::Size(256, 50);
			this->groupBox2->TabIndex = 2;
			this->groupBox2->TabStop = false;
			this->groupBox2->Text = L"Recive from Serial";
			// 
			// groupBox3
			// 
			this->groupBox3->Controls->Add(this->comboBox1);
			this->groupBox3->Location = System::Drawing::Point(30, 133);
			this->groupBox3->Name = L"groupBox3";
			this->groupBox3->Size = System::Drawing::Size(103, 50);
			this->groupBox3->TabIndex = 3;
			this->groupBox3->TabStop = false;
			this->groupBox3->Text = L"Baud Rate";
			// 
			// groupBox4
			// 
			this->groupBox4->Controls->Add(this->comboBox2);
			this->groupBox4->Location = System::Drawing::Point(143, 133);
			this->groupBox4->Name = L"groupBox4";
			this->groupBox4->Size = System::Drawing::Size(143, 50);
			this->groupBox4->TabIndex = 4;
			this->groupBox4->TabStop = false;
			this->groupBox4->Text = L"RTS";
			// 
			// textBox1
			// 
			this->textBox1->Location = System::Drawing::Point(18, 18);
			this->textBox1->Multiline = true;
			this->textBox1->Name = L"textBox1";
			this->textBox1->Size = System::Drawing::Size(200, 20);
			this->textBox1->TabIndex = 0;
			this->textBox1->KeyPress += gcnew KeyPressEventHandler(this, &Form1::textBox1_KeyPress);
			// 
			// textBox2
			// 
			this->textBox2->Location = System::Drawing::Point(18, 18);
			this->textBox2->Multiline = true;
			this->textBox2->Name = L"textBox2";
			this->textBox2->Size = System::Drawing::Size(200, 20);
			this->textBox2->TabIndex = 0;
			this->textBox2->ReadOnly = true;
			//
			// comboBox1
			// 
			array<String^>^ Baud = {"115200","57600","38400","19200","9600"};
			this->comboBox1->Items->AddRange( Baud );
			this->comboBox1->DropDownStyle = System::Windows::Forms::ComboBoxStyle::DropDownList;
			this->comboBox1->FormattingEnabled = true;
			this->comboBox1->Location = System::Drawing::Point(18, 18);
			this->comboBox1->Name = L"comboBox1";
			this->comboBox1->Size = System::Drawing::Size(65, 20);
			this->comboBox1->TabIndex = 0;
			this->comboBox1->SelectionChangeCommitted += gcnew System::EventHandler(this, &Form1::comboBox1_SelectedIndexChanged);
			//
			// comboBox2
			// 
			array<String^>^ RTS = {"RTS HIGH","RTS LOW"};
			this->comboBox2->Items->AddRange( RTS );
			this->comboBox2->DropDownStyle = System::Windows::Forms::ComboBoxStyle::DropDownList;
			this->comboBox2->FormattingEnabled = true;
			this->comboBox2->Location = System::Drawing::Point(18, 18);
			this->comboBox2->Name = L"comboBox2";
			this->comboBox2->Size = System::Drawing::Size(105, 20);
			this->comboBox2->TabIndex = 0;
			this->comboBox2->SelectionChangeCommitted += gcnew System::EventHandler(this, &Form1::comboBox2_SelectedIndexChanged);
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
			this->Controls->Add(this->groupBox1);
			this->Controls->Add(this->groupBox2);
			this->Controls->Add(this->groupBox3);
			this->Controls->Add(this->groupBox4);
			this->Name = L"Form1";
			this->Text = L"16FUSB Serial HID Sample App";
			this->Load += gcnew System::EventHandler(this, &Form1::Form1_Load);
			this->groupBox1->ResumeLayout(false);
			this->groupBox1->PerformLayout();
			this->groupBox2->ResumeLayout(false);
			this->groupBox2->PerformLayout();
			this->groupBox3->ResumeLayout(false);
			this->groupBox3->PerformLayout();
			this->groupBox4->ResumeLayout(false);
			this->groupBox4->PerformLayout();
			this->statusStrip1->ResumeLayout(false);
			this->statusStrip1->PerformLayout();
			this->ResumeLayout(false);
			this->PerformLayout();

		}
#pragma endregion

private: System::Void Form1_Load(System::Object^  sender, System::EventArgs^  e) {
			comboBox1->SelectedIndex=0;
			comboBox2->SelectedIndex=0;
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
				 
				 inputReport = usb->readReport2();
			  	 
			  	 char temp = inputReport[1];
				 
			  	 buf[0] = temp;
			  	 
			  	 String^ systemstring = gcnew String(orig);
    			 Console::WriteLine("{0}", systemstring);
    			 delete systemstring;
			  	 
				 textBox2->AppendText(systemstring);
			 }
		 }

private: System::Void textBox1_KeyPress(Object^ sender, KeyPressEventArgs^ e) {
			
			unsigned char outputReport[5];
			outputReport[0] = 0;
			outputReport[1] = Convert::ToInt32(e->KeyChar);
			outputReport[2] = 0;
			usb->writeReport2(outputReport);
		 }

private: System::Void comboBox1_SelectedIndexChanged(Object^ sender, System::EventArgs^ e) {
			unsigned char outputReport[5];
			if (comboBox1->SelectedIndex == 0) { //115200 24000000/115200/4-1=51=0x33
				outputReport[1] = 0x33;
				outputReport[2] = 0x80;
			}
			if (comboBox1->SelectedIndex == 1) { //57600 24000000/57600/4-1=103=0x67
				outputReport[1] = 0x67;
				outputReport[2] = 0x80;
			}
			if (comboBox1->SelectedIndex == 2) { //38400 24000000/38400/4-1=155=0x9B
				outputReport[1] = 0x9B;
				outputReport[2] = 0x80;
			}
			if (comboBox1->SelectedIndex == 3) { //19200 24000000/19200/4-1=312=0x0138
				outputReport[1] = 0x38;
				outputReport[2] = 0x01+0x80;
			}
			if (comboBox1->SelectedIndex == 4) { //9600 24000000/9600/4-1=624=0x0270
				outputReport[1] = 0x70;
				outputReport[2] = 0x02+0x80;
			}
			outputReport[0] = 0;
			usb->writeReport2(outputReport);
		}

private: System::Void comboBox2_SelectedIndexChanged(Object^ sender, System::EventArgs^ e) {
			unsigned char outputReport[5];
			if (comboBox2->SelectedIndex == 0) { //"RTS HIGH"
				outputReport[2] = 0x20;
			}
			if (comboBox2->SelectedIndex == 1) { //"RTS LOW"
				outputReport[2] = 0x10;
			}
			outputReport[0] = 0;
			outputReport[1] = 0;
			usb->writeReport2(outputReport);
		}

};

}

