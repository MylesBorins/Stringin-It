#include <DmxSimple.h>

//Array Values
int arrayCheck = HIGH;
int handShake;
int lightArray[4] = {0,0,0,0};

//Strobe Values
int intervalStrobe = 0; // Interval at which to blink
long previousMillisStrobe = 0;  //Stores last time Strobe was updated
int strobeKill = 0;

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
  
  if(Serial.available() >= 5){
     
     while(arrayCheck == HIGH)
     {
       handShake = Serial.read();
       if(handShake == 0){
         lightArray[0] = Serial.read() - 1;
         lightArray[1] = Serial.read() - 1;
         lightArray[2] = Serial.read() - 1;
         lightArray[3] = Serial.read() - 1;
         arrayCheck = LOW;
       }
     }
     
     arrayCheck = HIGH;
   }  
   
   intervalStrobe = lightArray[3];
   
     if(millis() - previousMillisStrobe > intervalStrobe){
       previousMillisStrobe = millis();
       if(strobeKill == 0){
         DmxSimple.write(2,lightArray[0]);
         DmxSimple.write(3,lightArray[1]);
         DmxSimple.write(4,lightArray[2]);
         strobeKill = 1;
       }
       else if(intervalStrobe == 0){
         DmxSimple.write(2,lightArray[0]);
         DmxSimple.write(3,lightArray[1]);
         DmxSimple.write(4,lightArray[2]);
         strobeKill = 1;
       }
         else{
         DmxSimple.write(2,0);
         DmxSimple.write(3,0);
         DmxSimple.write(4,0);
         strobeKill = 0;
       }         
     
    }
}
