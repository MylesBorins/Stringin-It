#include <DmxSimple.h>

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
  }
  
}
