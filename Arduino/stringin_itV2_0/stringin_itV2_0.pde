/*
  Stringin it V2

 reads the box and controls string +lights... faces melt.

 created 29 Oct 2010
 by Myles Borins
 */

#include <DmxSimple.h>

//box of awesome values
int lever1value = 0;    // variable to hold the analog value
int lever1pin = 1;      // Lever Pin Biatch
int lever2value = 0;    // variable to hold the analog value
int lever2pin = 0;      // Lever Pin Biatch
int button1value = 0;   // Variable to hold the analog value
int button1pin = 12;    // Pin for button 1 my jigga
int button2value = 0;   // Variable to hold the analog value
int button2pin = 10;    // Pin for button 1 my jigga

//Strobe Values
int intervalStrobe = 0; // Interval at which to blink
long previousMillisStrobe = 0;  //Stores last time Strobe was updated
int strobeKill = 0;

//PWM Values
int pwmPin = 5;
int pwm = 100;

//Light Value
int intensity = 63;
int intensityOutput = 63;
int intensityCounter = 0;
int redOn = 1; //Sets Status of Light's (On or Off)
int blueOn = 1;
int greenOn = 1;

//Pattern Values
int pattern = 0;
int patternCounter;
int intervalPattern = 500; // Interval at which to change lights
int randPattern = random(3);
int previousMillisPattern = 0;


void setup() {
  
  // set pinmode
  pinMode(button1pin, INPUT);
  pinMode(button2pin, INPUT);
  pinMode(pwmPin, OUTPUT);
  
  //DMX Setup
  DmxSimple.usePin(11);
  DmxSimple.maxChannel(4);
  DmxSimple.write(1,215);
  DmxSimple.write(2,255);
  DmxSimple.write(3,255);
  DmxSimple.write(4,255);
  }

void loop() {
  
  // Poll that shit:
  lever1value = analogRead(lever1pin);
  lever2value = analogRead(lever2pin);
  button1value = digitalRead(button1pin);
  button2value = digitalRead(button2pin);
  
  //Move polled Lever values to functions for code
  pwm = lever1value;
  pwm = map(pwm, 0, 255, 60, 130);
  intervalStrobe = lever2value;
  
  //Button 1 Cycles Patterns
  if (button1value == 1){
    if (pattern == 7){
      pattern = 0;
    }
    else{
      pattern = pattern + 1;
    }
  }
  
  //Button 2 Cycles Intensity
  if (button2value == 1){
    if (intensityCounter == 3){
      intensityCounter = 0;
    }
    else{
      intensityCounter = intensityCounter + 1;
    }
  }
    
    switch (intensityCounter){
      
      case 0:
      intensity = 63;
      
      break;
      
      case 1:
      intensity = 127;
      
      break;
      
      case 2:
      intensity = 191;
      
      break;
      
      case 3:
      intensity = 255;
      
      break;
    }
    
    
    //Pattern Switching
    switch (pattern) {
     
     case 0:
     redOn = 1;
     blueOn = 1;
     greenOn = 1;
     
     break;
     
     case 1:
     if (millis() - previousMillisPattern > intervalPattern){
       
       previousMillisPattern = millis();
       
       if (patternCounter == 0){
         redOn = 1;
         blueOn = 0;
         greenOn = 0;
         patternCounter = 1;
       }
       
       else if (patternCounter == 1){
         redOn = 0;
         blueOn = 1;
         greenOn = 0;
         patternCounter = 2;
       }
       
       else{
         redOn = 0;
         blueOn = 0;
         greenOn = 1;
         patternCounter = 0;
       }
     }    
     
     break;
     
     case 2:
     if (millis() - previousMillisPattern > intervalPattern){
       
       previousMillisPattern = millis();
       
       if (patternCounter == 0){
         redOn = 0;
         blueOn = 0;
         greenOn = 1;
         patternCounter = 1;
       }
       
       else if (patternCounter == 1){
         redOn = 0;
         blueOn = 1;
         greenOn = 0;
         patternCounter = 2;
       }
       
       else{
         redOn = 1;
         blueOn = 0;
         greenOn = 0;
         patternCounter = 0;
       }
     }    
     
     break;
     
     
     case 3:
     if (millis() - previousMillisPattern > intervalPattern){
       
       previousMillisPattern = millis();
       
       if (patternCounter == 0){
         redOn = 1;
         blueOn = 1;
         greenOn = 0;
         patternCounter = 1;
       }
       
       else if (patternCounter == 1){
         redOn = 0;
         blueOn = 1;
         greenOn = 1;
         patternCounter = 2;
       }
       
       else{
         redOn = 1;
         blueOn = 0;
         greenOn = 1;
         patternCounter = 0;
       }
     }    
     
     break;
     
     case 4:
     
     redOn = 1;
     blueOn = 0;
     greenOn = 0;
     
     break;
     
     case 5:
     
     redOn = 0;
     blueOn = 1;
     greenOn = 0;
     
     break;
     
     case 6:
     
     redOn = 0;
     blueOn = 0;
     greenOn = 1;
     
     break;
     
     case 7:
     
     if (millis() - previousMillisPattern > intervalPattern){
       
       previousMillisPattern = millis();
       
       if (randPattern == 0){
         redOn = 1;
         blueOn = 0;
         greenOn = 0;
         patternCounter = 1;
       }
       
       else if (randPattern == 1){
         redOn = 0;
         blueOn = 1;
         greenOn = 0;
         patternCounter = 2;
       }
       
       else{
         redOn = 0;
         blueOn = 0;
         greenOn = 1;
         patternCounter = 0;
       }
       randPattern = random(3);
     }    
     
     break;
   }
   
   analogWrite(pwmPin, pwm);
   
   if(millis() - previousMillisStrobe > intervalStrobe){
       previousMillisStrobe = millis();
       if(strobeKill == 0){
         if (redOn == 1){
     DmxSimple.write(2, intensity);
   }
   else{
     DmxSimple.write(2, 0);
   }
   
   if (greenOn == 1){
     DmxSimple.write(3, intensity);
   }
   else{
     DmxSimple.write(3, 0);
   }
   
   if (blueOn == 1){
     DmxSimple.write(4, intensity);
   }
   else{
     DmxSimple.write(4, 0);
   }
         
         
         strobeKill = 1;
       }
       else if(intervalStrobe == 0){
         if (redOn == 1){
     DmxSimple.write(2, intensity);
   }
   else{
     DmxSimple.write(2, 0);
   }
   
   if (greenOn == 1){
     DmxSimple.write(3, intensity);
   }
   else{
     DmxSimple.write(3, 0);
   }
   
   if (blueOn == 1){
     DmxSimple.write(4, intensity);
   }
     else{
       DmxSimple.write(4, 0);
       }
         
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


