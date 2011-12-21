#include <DmxSimple.h>

//Array Values
#include "WProgram.h"
void setup();
void loop();
int arrayCheck = HIGH;
int handShake;
int lightArray[7] = {0,0,0,0,0,0,0};

//Strobe Values
int intervalStrobe = 0; // Interval at which to blink
long previousMillisStrobe = 0;  //Stores last time Strobe was updated
int strobeKill = 0;

//PWM Values

const int pwmPin = 3;
int pwm;

//Light Values
int redValue = 0;
int greenValue = 0;
int blueValue = 0;

void setup(){
  //DMX Setup
  DmxSimple.usePin(11);
  DmxSimple.maxChannel(4);
  DmxSimple.write(1,215);
  
  //Serial Setup
  Serial.begin(9600);
  
  //Array Setup
  arrayCheck = HIGH;
  
  //PWM Setup
  pinMode(pwmPin, OUTPUT);
}

void loop(){
  
  if(Serial.available() >= 8){
     
     while(arrayCheck == HIGH)
     {
       handShake = Serial.read();
       if(handShake == 0){
         lightArray[0] = Serial.read() - 1;
         lightArray[1] = Serial.read() - 1;
         lightArray[2] = Serial.read() - 1;
         lightArray[3] = Serial.read() - 1;
         lightArray[4] = Serial.read() - 1;
         lightArray[5] = Serial.read() - 1;
         lightArray[6] = Serial.read() - 1;
         arrayCheck = LOW;
       }
     }
     
     arrayCheck = HIGH;
   }  
   pwm = lightArray[2];
   redValue = lightArray[3];
   greenValue = lightArray[4];
   blueValue = lightArray[5];
   intervalStrobe = lightArray[6];
   
     if(millis() - previousMillisStrobe > intervalStrobe){
       previousMillisStrobe = millis();
       if(strobeKill == 0){
         DmxSimple.write(2,redValue);
         DmxSimple.write(3,greenValue);
         DmxSimple.write(4,blueValue);
         strobeKill = 1;
       }
       else if(intervalStrobe == 0){
         DmxSimple.write(2,redValue);
         DmxSimple.write(3,greenValue);
         DmxSimple.write(4,blueValue);
         strobeKill = 1;
       }
         else{
         DmxSimple.write(2,0);
         DmxSimple.write(3,0);
         DmxSimple.write(4,0);
         strobeKill = 0;
       }         
     
    }
    
    analogWrite(pwmPin, pwm); //Send pwm Values to pwm pin
}

int main(void)
{
	init();

	setup();
    
	for (;;)
		loop();
        
	return 0;
}

