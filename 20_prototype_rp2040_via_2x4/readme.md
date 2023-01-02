# Information about Pico-QMK-VIA Prototype

## Hardware

* Parts
  * Raspberry Pico[^1]
  * Eight tactile switches[^2]
  * Breadboard, Wires

* Schematic
<img src="images/schematic.png" alt="schematic" width="800"/>

* Breadboard
<img src="images/breadboard.png" alt="breadboard" width="800"/>

## Software

### Compile on Raspberry Pi

Any linux based operation system should work. If flashing does not work the generated uf2-file can be installed manually.
I used a Raspberry Pi Zero. Compilation takes about 3 min.

#### Setting up

* install rasbian lite and enable ssh
* install qmk[^3]

```
$ sudo apt install -y git python3-pip
$ python3 -mpip install --user qmk
$ qmk --version
1.1.1
$ qmk setup
Ψ QMK is ready to go, but minor problems were found
```
* remark: instead of getting "QMK is ready to go" i get "QMK is ready to go, but minor problems were found" at the end of the qmk setup

* check if generating uf2-file and manual installation onto pico works

```
$ cd ~/qmk_firmware
$ echo "checking if uf2-file is generated"
checking if uf2-file is generated
$ qmk clean
QMK Firmware 0.19.5
Deleting .build/ ... done.
$ qmk compile -kb handwired/onekey/rp2040 -km default
Ψ Compiling keymap with gmake --jobs=1 handwired/onekey/rp2040:default
...
Creating UF2 file for deployment: .build/handwired_onekey_rp2040_default.uf2                        [OK]
Copying handwired_onekey_rp2040_default.uf2 to qmk_firmware folder                                  [OK]
(Firmware size check does not yet support RP2040; skipping)
```

#### Compiling Firmware

* generate ortho_2x4 keyboard template

```
$ qmk new-keyboard
Ψ Generating a new QMK keyboard directory

Name Your Keyboard Project
For more infomation, see:
https://docs.qmk.fm/#/hardware_keyboard_guidelines?id=naming-your-keyboardproject

Keyboard Name? ortho_2x4

Attribution
Used for maintainer, copyright, etc

Your GitHub Username? xxx

More Attribution
Used for maintainer, copyright, etc

Your Real Name?  [xxx]

Pick Base Layout
As a starting point, one of the common layouts can be used to bootstrap the process

Default Layout?
        1. 60_abnt2
        2. 60_ansi
...
        51. tkl_nofrow_iso
        52. none of the above
Please enter your choice:  [52] 52

What Powers Your Project
For more infomation, see:
https://docs.qmk.fm/#/compatible_microcontrollers

MCU?
        1. bit_c_pro
        2. blackpill_f401
...
        31. MK66FX1M0
        32. MKL26Z64
        33. RP2040
        34. STM32F042
...
        52. WB32FQ95
Please enter your choice:  [25] 33
Ψ Created a new keyboard called ortho_2x4.
Ψ To start working on things, `cd` into keyboards/ortho_2x4,
Ψ or open the directory in your preferred text editor.
Ψ And build with qmk compile -kb ortho_2x4 -km default.
```

* the following files have been generated with in directory '~/qmk_firmware/keyboards/ortho_2x4'

```
keyboards/ortho_2x4/config.h
keyboards/ortho_2x4/info.json
keyboards/ortho_2x4/keymaps/default/keymap.c
keyboards/ortho_2x4/readme.md
keyboards/ortho_2x4/rules.mk
```

* adjust pin names in file "info.json"

```
 $ git diff keyboards/ortho_2x4/info.json
diff --git a/keyboards/ortho_2x4/info.json b/keyboards/ortho_2x4/info.json
index e512bbedd7..29a3e7167f 100644
--- a/keyboards/ortho_2x4/info.json
+++ b/keyboards/ortho_2x4/info.json
@@ -13,8 +13,8 @@
         "nkro": true
     },
     "matrix_pins": {
-        "cols": ["C2", "C2", "C2", "C2"],
-        "rows": ["D1", "D1", "D1", "D1"]
+        "cols": ["GP1", "GP2", "GP3", "GP4"],
+        "rows": ["GP5", "GP6", "GP7", "GP8"]
     },
     "processor": "RP2040",
     "url": "",
@@ -45,4 +45,4 @@
             ]
```

* compile ortho_2x4 firmware

```
$ qmk compile -kb ortho_2x4 -km default
Ψ Compiling keymap with gmake --jobs=1 ortho_2x4:default
...
Creating UF2 file for deployment: .build/ortho_2x4_default.uf2                                      [OK]
Copying ortho_2x4_default.uf2 to qmk_firmware folder                                                [OK]
(Firmware size check does not yet support RP2040; skipping)
```

* add line "#define FORCE_NKRO" in file config.h and line "VIA_ENABLE = yes" in file rules.mk
* verify that firmware still compiles

* change diode direction, matrix layout and keycodes in files "info.json" and "keymaps/default/keymap.c"

```
$ git diff keyboards/ortho_2x4/config.h
diff --git a/keyboards/ortho_2x4/config.h b/keyboards/ortho_2x4/config.h
index 3ef2d0c6dc..fbd97359d5 100644
--- a/keyboards/ortho_2x4/config.h
+++ b/keyboards/ortho_2x4/config.h
@@ -18,3 +18,6 @@
 //#define NO_ACTION_LAYER
 //#define NO_ACTION_TAPPING
 //#define NO_ACTION_ONESHOT
+//
+#define FORCE_NKRO
+
$ git diff keyboards/ortho_2x4/r
readme.md  rules.mk
$ git diff keyboards/ortho_2x4/rules.mk
diff --git a/keyboards/ortho_2x4/rules.mk b/keyboards/ortho_2x4/rules.mk
index 6e7633bfe0..a372fdf62c 100644
--- a/keyboards/ortho_2x4/rules.mk
+++ b/keyboards/ortho_2x4/rules.mk
@@ -1 +1,3 @@
 # This file intentionally left blank
+VIA_ENABLE = yes
```

* verify that firmware still compiles
* if keyboard hardware is available, flash keyboard and verify that key mapping is correct[^4]
* modify files

## Usage


[^1]: [Raspberry Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/)
[^2]: [Adafruit Tactile Switch Buttons](https://www.adafruit.com/product/1119
[^3]: [Adafruit Learning System: Using QMK on RP2040] (https://learn.adafruit.com/using-qmk-on-rp2040-microcontrollers/overview)
[^4]: If you have a WebHID enabled browser like Chrome or Edge use [VIA](https://usevia.app/#/) otherwise use [key-rollover-test](https://www.mechanical-keyboard.org/key-rollover-test/)

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
# $ git diff
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
