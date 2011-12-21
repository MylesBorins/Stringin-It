#include <DmxSimple.h>

#include "WProgram.h"
void setup();
void loop();
int switchPin = 2;
int ledPin = 3;
int switchValue = 0;

void setup() {
  Serial.begin(9600);
  Serial.println("Switch Test");
  Serial.println();
  pinMode (ledPin, OUTPUT);
  pinMode (switchPin, INPUT);
  DmxSimple.usePin(11);
  DmxSimple.write(1,215);
}

void loop(){
  //while(!Serial.available());{
    switchValue = digitalRead(switchPin);
  
    if (switchValue < 1){
      digitalWrite(ledPin, LOW);
      //Serial.println("LOW");
      DmxSimple.write(2,0);
      DmxSimple.write(3,0);
      DmxSimple.write(4,0);
      //delay(50);
     }
    
    else{
      digitalWrite(ledPin, HIGH);
     //Serial.println("HIGH"); 
     DmxSimple.write(2,255);
     DmxSimple.write(3,255);
     DmxSimple.write(4,255);
    // delay(50);
    }
  //}
  delay(40);
}

int main(void)
{
	init();

	setup();
    
	for (;;)
		loop();
        
	return 0;
}

