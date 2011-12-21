const int pwmPin = 11;      // the pin that the DC Motor's Connected to
const int ledPin = 10;      // The pin that the led power is connected to
const int redPin = 8;       // To Base on red transistor
const int bluePin = 7;      // To Base on blue transistor
const int greenPin = 6;     // // To Base on green transistor


int redOn = HIGH; //Sets Status of Light's (On or Off)
int blueOn = HIGH;
int greenOn = HIGH;

int arrayCheck = HIGH;
int handShake;                    //  arrayCheck and handShake check for a 0 before sorting array
int monomeArray[6] = {0, 0, 0, 0, 0, 0};  // Stores Array of Data from monome


int intervalStrobe = 0; // Interval at which to blink
int intervalPattern = 0; // Interval at which to change lights
int randPattern = random(3);
long previousMillisStrobe = 0;  //Stores last time Strobe was updated
long previousMillisPattern = 1;
int pwm;
int led;
int pattern;
int patternCounter;

 void setup()
 {
   // initialize the serial communication:
   Serial.begin(9600);
   // initialize the Pins as output:
   pinMode(pwmPin, OUTPUT);
   pinMode(ledPin, OUTPUT);
   pinMode(redPin, OUTPUT);
   pinMode(bluePin, OUTPUT);
   pinMode(greenPin, OUTPUT);
   arrayCheck = HIGH;
}

 void loop() {
   
   if(Serial.available() >= 6){
     
     while(arrayCheck == HIGH)
     {
       handShake = Serial.read();
       if(handShake == 0){
         monomeArray[0] = Serial.read() - 1;
         monomeArray[1] = Serial.read() - 1;
         monomeArray[2] = Serial.read() - 1;
         monomeArray[3] = Serial.read() * 2;
         monomeArray[4] = Serial.read();
         arrayCheck = LOW;
       }
     }
     
     arrayCheck = HIGH;
   }  
   
   pwm = monomeArray[0];  //Sets Value for DC motor control
   intervalStrobe = monomeArray[2];  //Sets value for Strobe
   intervalPattern = monomeArray[3];
   pattern = monomeArray[4];
   
   if (millis() - previousMillisStrobe > intervalStrobe){
     previousMillisStrobe = millis();
     if(led == 0){
       led = monomeArray[1];
     }
     else if(intervalStrobe == 0){
       led = monomeArray[1];
     } 
     else{
       led = 0;
     }
   }
   
   switch (pattern) {
     
     case 1:
     redOn = HIGH;
     blueOn = HIGH;
     greenOn = HIGH;
     
     break;
     
     case 2:
     if (millis() - previousMillisPattern > intervalPattern){
       
       previousMillisPattern = millis();
       
       if (patternCounter == 0){
         redOn = HIGH;
         blueOn = LOW;
         greenOn = LOW;
         patternCounter = 1;
       }
       
       else if (patternCounter == 1){
         redOn = LOW;
         blueOn = HIGH;
         greenOn = LOW;
         patternCounter = 2;
       }
       
       else{
         redOn = LOW;
         blueOn = LOW;
         greenOn = HIGH;
         patternCounter = 0;
       }
     }    
     
     break;
     
     case 3:
     if (millis() - previousMillisPattern > intervalPattern){
       
       previousMillisPattern = millis();
       
       if (patternCounter == 0){
         redOn = LOW;
         blueOn = LOW;
         greenOn = HIGH;
         patternCounter = 1;
       }
       
       else if (patternCounter == 1){
         redOn = LOW;
         blueOn = HIGH;
         greenOn = LOW;
         patternCounter = 2;
       }
       
       else{
         redOn = HIGH;
         blueOn = LOW;
         greenOn = LOW;
         patternCounter = 0;
       }
     }    
     
     break;
     
     
     case 4:
     if (millis() - previousMillisPattern > intervalPattern){
       
       previousMillisPattern = millis();
       
       if (patternCounter == 0){
         redOn = HIGH;
         blueOn = HIGH;
         greenOn = LOW;
         patternCounter = 1;
       }
       
       else if (patternCounter == 1){
         redOn = LOW;
         blueOn = HIGH;
         greenOn = HIGH;
         patternCounter = 2;
       }
       
       else{
         redOn = HIGH;
         blueOn = LOW;
         greenOn = HIGH;
         patternCounter = 0;
       }
     }    
     
     break;
     
     case 5:
     
     redOn = HIGH;
     blueOn = LOW;
     greenOn = LOW;
     
     break;
     
     case 6:
     
     redOn = LOW;
     blueOn = HIGH;
     greenOn = LOW;
     
     break;
     
     case 7:
     
     redOn = LOW;
     blueOn = LOW;
     greenOn = HIGH;
     
     break;
     
     case 8:
     
     if (millis() - previousMillisPattern > intervalPattern){
       
       previousMillisPattern = millis();
       
       if (randPattern == 0){
         redOn = HIGH;
         blueOn = LOW;
         greenOn = LOW;
         patternCounter = 1;
       }
       
       else if (randPattern == 1){
         redOn = LOW;
         blueOn = HIGH;
         greenOn = LOW;
         patternCounter = 2;
       }
       
       else{
         redOn = LOW;
         blueOn = LOW;
         greenOn = HIGH;
         patternCounter = 0;
       }
       randPattern = random(3);
     }    
     
     break;
   }
   
     
   analogWrite(pwmPin, pwm);
   analogWrite(ledPin, led);
   //Send PWM values to DC motor and LED Collective
   
   digitalWrite(redPin, redOn);
   digitalWrite(bluePin, blueOn);
   digitalWrite(greenPin, greenOn);
   // Sends data to each individual light to check on or off
 }

