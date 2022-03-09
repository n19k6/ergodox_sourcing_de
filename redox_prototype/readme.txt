20220308:

a)
check that cheap micro pro clone can be programmed

using arduino ide on windows 10 worked. the following programm let two led blink:

https://learn.sparkfun.com/tutorials/pro-micro--fio-v3-hookup-guide/example-1-blinkies

############
/* Pro Micro Test Code
   by: Nathan Seidle
   modified by: Jim Lindblom
   SparkFun Electronics
   date: September 16, 2013
   license: Public Domain - please use this code however you'd like.
   It's provided as a learning tool.

   This code is provided to show how to control the SparkFun
   ProMicro's TX and RX LEDs within a sketch. It also serves
   to explain the difference between Serial.print() and
   Serial1.print().
*/

int RXLED = 17;  // The RX LED has a defined Arduino pin
// Note: The TX LED was not so lucky, we'll need to use pre-defined
// macros (TXLED1, TXLED0) to control that.
// (We could use the same macros for the RX LED too -- RXLED1,
//  and RXLED0.)

void setup()
{
  pinMode(RXLED, OUTPUT);  // Set RX LED as an output
  // TX LED is set as an output behind the scenes

  Serial.begin(9600); //This pipes to the serial monitor
  Serial.println("Initialize Serial Monitor");

  Serial1.begin(9600); //This is the UART, pipes to sensors attached to board
  Serial1.println("Initialize Serial Hardware UART Pins");
}

void loop()
{
  Serial.println("Hello world!");  // Print "Hello World" to the Serial Monitor
  Serial1.println("Hello! Can anybody hear me?");  // Print "Hello!" over hardware UART

  digitalWrite(RXLED, LOW);   // set the RX LED ON
  TXLED0; //TX LED is not tied to a normally controlled pin so a macro is needed, turn LED OFF
  delay(1000);              // wait for a second

  digitalWrite(RXLED, HIGH);    // set the RX LED OFF
  TXLED1; //TX LED macro to turn LED ON
  delay(1000);              // wait for a second
}
############

Arduino -> Sketch -> Kompilierte Binärdatei exportieren
sketch_dec31c.ino.micro.hex
sketch_dec31c.ino.with_bootloader.micro.hex

Arduino -> Voreinstellungen -> Einstellungen -> Ausführliche Ausgabe während Hochladen [check]

C:\Users\rze\AppData\Local\Arduino15\packages\arduino\tools\avrdude\6.3.0-arduino17/bin/avrdude -CC:\Users\rze\AppData\Local\Arduino15\packages\arduino\tools\avrdude\6.3.0-arduino17/etc/avrdude.conf -v -V -patmega32u4 -cavr109 -PCOM10 -b57600 -D -Uflash:w:C:\Users\rze\AppData\Local\Temp\arduino_build_198876/sketch_dec31c.ino.hex:i 


b) upload hex file "redox_rev1_layout_mine.hex" generated via https://config.qmk.fm/#/redox/rev1/LAYOUT

https://www.youtube.com/watch?v=fuBJbdCFF0Q
https://github.com/qmk/qmk_toolbox/releases

upload of hex files worked with QMK Toolbox on Windows with checkbox "Auto-Flash" (via Open and reseting micro pro clone wire https://www.icode.com/wp-content/uploads/image-7.png)

c) schematics and breadboard

https://github.com/mattdibi/redox-keyboard/blob/master/redox/pcb/Redox-schematic.pdf

3D printed Redox mechanical keyboard - first build (https://www.youtube.com/watch?v=Q7JEEiEhtWg)
Build your own keyboard (Redox Media) (https://www.youtube.com/watch?v=Cwkf7HFcUkY)

Next

d)
testing keymap using shortening wires https://config.qmk.fm

e)
conection two micro pros

d)
makerspace: lasercut case + solder pin headers