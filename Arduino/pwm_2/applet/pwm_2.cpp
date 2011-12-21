#include "WProgram.h"
void setup();
void loop();
int ledPin = 11;

void setup()
{
  // begin the serial communication
  Serial.begin(9600);
  pinMode(ledPin, OUTPUT);
}

void loop()
{
  byte whichpot;
  byte pot1val;
  
  // check if data has been sent from the computer
  if (Serial.available()) {
    
    // read the most recent byte (which will be from 0 to 255)
    whichpot = Serial.read();
      
      //Check to see which pot data is to be sent to
      if(whichpot == 1){
        pot1val = Serial.read();
        
      }
   analogWrite(ledPin, pot1val); 
  }
}

int main(void)
{
	init();

	setup();
    
	for (;;)
		loop();
        
	return 0;
}

