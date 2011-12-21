/*
  Big Box of Awesome Code

 reads the box and outputs messages with routing containers.

 created 29 Oct 2010
 by Myles Borins
 */

int lever1value = 0;    // variable to hold the analog value
int lever1pin = 1;      // Lever Pin Biatch
int lever2value = 0;    // variable to hold the analog value
int lever2pin = 0;      // Lever Pin Biatch
int button1value = 0;   // Variable to hold the analog value
int button1pin = 12;    // Pin for button 1 my jigga
int button2value = 0;   // Variable to hold the analog value
int button2pin = 10;    // Pin for button 1 my jigga

void setup() {
  // open the serial port at 9600 bps:
  Serial.begin(9600);
  // set pinmode
  pinMode(button1pin, INPUT);
  pinMode(button2pin, INPUT);
  }

void loop() {
  // Poll that shit:
  lever1value = analogRead(lever1pin);
  lever2value = analogRead(lever2pin);
  button1value = digitalRead(button1pin);
  button2value = digitalRead(button2pin);

  // print it out in many formats:
  Serial.print("/lever1 ");       // print routing information
  Serial.println(lever1value);    // print value
  Serial.print("/lever2 ");       // print routing information
  Serial.println(lever2value);
  Serial.print("/button1 ");
  Serial.println(button1value);
  Serial.print("/button2 ");
  Serial.println(button2value);

  // delay 10 milliseconds before the next reading:
  delay(100);
}

