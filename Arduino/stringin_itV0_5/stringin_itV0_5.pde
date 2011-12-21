const int ledPin1 = 10;      // the pin that the POT is attached to
const int ledPin2 = 9;


int monomeArray[3] = {0, 0, 0};
int interval = 0; // Interval at which to blink 
long previousMillis = 0;  //Stores last time LED was updated
int led1;
int led2;

 void setup()
 {
   // initialize the serial communication:
   Serial.begin(9600);
   // initialize the ledPin as an output:
   pinMode(ledPin1, OUTPUT);
   pinMode(ledPin2, OUTPUT);
 }

 void loop() {
   
   if(Serial.available() >=3){
     monomeArray[0] = Serial.read();
     monomeArray[1] = Serial.read();
     monomeArray[2] = Serial.read();
   }  
   
   interval = monomeArray[2];
   
   if (millis() - previousMillis > interval){
     previousMillis = millis();
     if(led1 == 0){
       led1 = monomeArray[0];
       led2 = monomeArray[1];
     }
     else if(interval == 0){
       led1 = monomeArray[0];
       led2 = monomeArray[1];
     } 
     else{
       led1 = 0;
       led2 = 0;
     }
   }
   analogWrite(ledPin1, led1);
   analogWrite(ledPin2, led2);
 }

