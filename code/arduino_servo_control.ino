#include <Servo.h>  // Include the Servo library to control the servo motors
#define Num_Servos 6  // Define the number of servo motors to be controlled
// Array to hold the pin numbers to which each servo motor is connected
int servoPins[Num_Servos] = {2, 3, 4, 5, 6, 7}; 
// Array to create servo objects for each motor
Servo servos[Num_Servos]; 
void setup() {
  Serial.begin(9600);  // Start serial communication at a baud rate of 9600
  // Attach each servo motor to its respective pin
  for (int i = 0; i < Num_Servos; i++) {
    servos[i].attach(servoPins[i]);
  }
}
void loop() {
  // Check if at least 6 bytes of data are available to read from the serial buffer
  if (Serial.available() >= 6) { 
    unsigned int Data[6];  // Array to store the incoming data for each servo motor
    // Read 6 bytes of data from the serial buffer and store them in the Data array
    for (int i = 0; i < 6; i++) {
      Data[i] = Serial.read();
    }
    // Map and write the received data to each servo motor
    for (int i = 0; i < Num_Servos; i++) {
      // Map the received data (range 0-180) to the servo angle (0-180 degrees)
      int angle = map(Data[i], 0, 180, 0, 180);
      // Write the calculated angle to the corresponding servo motor
      servos[i].write(angle);
      // Send the angle back through the serial port for feedback
      Serial.write(angle);
    }
  }
}
