#include <DmxSimple.h>

//Array Values
int arrayCheck = HIGH;
int handsShake;
int lightArray[3] = {0,0,0};

void setup(){
  //DMX Setup
  DmxSimple.usePin(11);
  DmxSimple.maxChannel(4);
  DmxSimple.write(1,215);
  
  //Serial Setup
  Serial.begin(9600);
  
  //Array Setup
  arrayCheck = HIGH;
}

void loop(){
  
  if(Serial.available() >= 4){
     
     while(arrayCheck == HIGH)
     {
       handShake = Serial.read();
       if(handShake == 0){
         lightArray[0] = Serial.read() - 1;
         lightArray[1] = Serial.read() - 1;
         lightArray[2] = Serial.read() - 1;
         arrayCheck = LOW;
       }
     }
     
     arrayCheck = HIGH;
   }  
  DmxSimple.write(2,lightArray[0]);
  DmxSimple.write(3,lightArray[1]);
  DmxSimple.write(2,lightArray[2]);
}
