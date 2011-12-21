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
int monomeArray[4] = {0, 0, 0, 0};  // Stores Array of Data from monome


int intervalStrobe = 0; // Interval at which to blink
int intervalLed = 0;      // Interval inbetween specific lighting patterns
long previousMillis = 0;  //Stores last time LED was updated
int pwm;
int led;

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
   
   if(Serial.available() >= 4){
     
     while(arrayCheck == HIGH)
     {
       handShake = Serial.read();
       if(handShake == 0){
         monomeArray[0] = Serial.read() - 1;
         monomeArray[1] = Serial.read() - 1;
         monomeArray[2] = Serial.read() - 1;
         arrayCheck = LOW;
       }
     }
     
     arrayCheck = HIGH;
   }  
   
   pwm = monomeArray[0];  //Sets Value for DC motor control
   intervalStrobe = monomeArray[2];  //Sets value for Strobe
   
   if (millis() - previousMillis > intervalStrobe){
     previousMillis = millis();
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
   analogWrite(pwmPin, pwm);
   analogWrite(ledPin, led);
   //Send PWM values to DC motor and LED Collective
   digitalWrite(redPin, redOn);
   digitalWrite(bluePin, blueOn);
   digitalWrite(greenPin, greenOn);
   // Sends data to each individual light to check on or off
 }

