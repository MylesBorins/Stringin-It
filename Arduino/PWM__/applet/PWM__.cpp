#include "WProgram.h"
void setup();
void loop();
const int pwmPin1 = 11;      // the pin that the POT is attached to
const int pwmPin2 = 10;

int monomeArray[2];

 void setup()
 {
   // initialize the serial communication:
   Serial.begin(9600);
   // initialize the ledPin as an output:
   pinMode(pwmPin1, OUTPUT);
   pinMode(pwmPin2, OUTPUT);
 }

 void loop() {
   
   if(Serial.available() >=2){
     monomeArray[1] = Serial.read();
     break;
     monomeArray[0] = Serial.read();
     break;
   }  


    
   analogWrite(pwmPin1, monomeArray[0]);
   analogWrite(pwmPin2, monomeArray[1]);
 }


int main(void)
{
	init();

	setup();
    
	for (;;)
		loop();
        
	return 0;
}

