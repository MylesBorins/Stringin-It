#include <DmxSimple.h>

#include "WProgram.h"
void setup();
void loop();
int redValue = 0;

void setup(){
  DmxSimple.usePin(11);
  DmxSimple.maxChannel(4);
  DmxSimple.write(1,215);
  Serial.begin(9600);
}

void loop(){
  if (Serial.available() > 0) {
    redValue = Serial.read();
    DmxSimple.write(2,redValue);
    delay(5);
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

