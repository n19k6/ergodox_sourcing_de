# Information about Pico-QMK-VIA Prototype

## Hardware

* Parts
  * Raspberry Pico[^1]
  * Eight tactile switches[^2]
  * Breadboard, Wires

* Schematic
![breadboard](images/schematic.png)

* Breadboard
![breadboard](images/breadboard.png)





## Software

## Usage


[^1]: [Raspberry Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/)
[^2]: [Adafruit Tactile Switch Buttons](https://www.adafruit.com/product/1119)

tasks:
a) reproduce adafuit one key qmk example
b) compile firmware on raspberry zero
c) add via support
d) add 4x2 keys

add a)
https://learn.adafruit.com/using-qmk-on-rp2040-microcontrollers/rp2040-one-key-keyboard
worked, but not with avaible uf2-file (https://cdn-learn.adafruit.com/assets/assets/000/113/316/original/handwired_onekey_rp2040_default.uf2?1658260686)
had to generate uf2 file using "handwired/onekey/rp2040" via https://config.qmk.fm/#/handwired/onekey/rp2040/LAYOUT_ortho_1x1
compiling (baking) via online service takes about 3 min
to flash firmware on raspberry pico as usually press reset button while
connecting to pc and copy uf2 file to RPI-RP2 drive
after one-key "a" worked changed "a" to "mute" via online gui and keymap.json

add b)
- install rasbian on raspberry zero e.g. raspberry pi os lite (debian version 11)
- activate ssh and optionally change hostname and user credentials
- the rasberry zero has to be connected to the network, e.g. using an
  usb-ethernet adapter for around 7 EUR
- install qmk using:
sudo apt install -y git python3-pip
python3 -mpip install --user qmk
qmk --version
qmk setup
- remark and the end of the setup there appears no the message "QMK is ready
  to go" the message that appears is "QMK is ready ato go, but minor problems
were found". Automatic flashing does not work I have to manually copy the uf2
file, which is OK for me.  
- cd ~/qmk_firmware
- qmk clean
- qmk compile -kb handwired/onekey/rp2040 -km default
-> a file "handwired_onekey_rp2040_default.uf2" has been generated after >= 5 min
-> flash the file onto pico and verify that pressing the button reasults in an "a" 
# inserting pico into usb-ethernet hub resets ethernet connection
# lsusb
# Bus 001 Device 004: ID 2e8a:0003 Raspberry Pi RP2 Boot
# rze@qmk-pi:~/qmk_firmware $ git diff
# diff --git a/keyboards/handwired/onekey/keymaps/default/keymap.c
# b/keyboards/handwired/onekey/keymaps/default/keymap.c
# index a5782f7a13..64c832d131 100644
# --- a/keyboards/handwired/onekey/keymaps/default/keymap.c
# +++ b/keyboards/handwired/onekey/keymaps/default/keymap.c
# @@ -1,5 +1,7 @@
#  #include QMK_KEYBOARD_H
# 
#  const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
# -    LAYOUT_ortho_1x1(KC_A)
# +//    LAYOUT_ortho_1x1(KC_A)
# +//    LAYOUT_ortho_1x1(KC_MUTE)
# +    LAYOUT_ortho_1x1(KC_CAPS)
#  };
# qmk import-keymap ~/handwired_onekey_rp2040_layout_ortho_1x1_KC_MS_U.json

add d)
- use adding a new keyboard section
qmk new-keyboard
-2by4
-change keys to GPx in file info.json
-change layout in info.json and keymapping in keymap.c
-nkro did not work since also bootmagic was enabled in info.json, and #define FORCE_NKRC was missing in config.h (perhaps defined in config.h is sufficient)


all changes as executed:
>

misc:
https://www.reddit.com/r/askscience/comments/vxs7bb/how_does_pressing_the_calculator_button_on_my/



different links:
http://builder.swillkb.com/
https://www.youtube.com/watch?v=UKfeJrRIcxw
https://media.ccc.de/v/froscon2021-2644-mechanische_tastaturen
ergogen

https://media.ccc.de/v/froscon2021-2644-mechanische_tastaturen

<!--
compress files e.g. https://www.iloveimg.com
-->
