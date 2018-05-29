#include <iostream>
#include "USBTest.h"

using namespace std;

int main(int args, char* argv[]){
	cout << "GCBASIC USB test\n";
	
	// Set up tester
	USBTest* tester = new USBTest();
	
	printf ("Tester %c\n", tester );
	
	if ( dev != NULL )
	{
		cout << "USB Test object created\n";
		// Do stuff
		if (args < 2){
			tester->demo(1);
		} else {
			tester->demo(atoi(argv[1]));
		}
		

		delete tester;
	}
}



