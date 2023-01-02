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

* generate two_x_four keyboard template

```
$ qmk new-keyboard
Ψ Generating a new QMK keyboard directory

Name Your Keyboard Project
For more infomation, see:
https://docs.qmk.fm/#/hardware_keyboard_guidelines?id=naming-your-keyboardproject

Keyboard Name? two_x_four

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
Ψ Created a new keyboard called two_x_four.
Ψ To start working on things, `cd` into keyboards/two_x_four,
Ψ or open the directory in your preferred text editor.
Ψ And build with qmk compile -kb two_x_four -km default.
```

* the following files have been generated with in directory '~/qmk_firmware/keyboards/two_x_four'

```
keyboards/two_x_four/config.h
keyboards/two_x_four/info.json
keyboards/two_x_four/keymaps/default/keymap.c
keyboards/two_x_four/readme.md
keyboards/two_x_four/rules.mk
```

* adjust pin names in file "info.json"

```
 $ git diff keyboards/two_x_four/info.json
diff --git a/keyboards/two_x_four/info.json b/keyboards/two_x_four/info.json
index e512bbedd7..29a3e7167f 100644
--- a/keyboards/two_x_four/info.json
+++ b/keyboards/two_x_four/info.json
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

* compile twoXfour firmware

```
$ qmk compile -kb two_x_four -km default
Ψ Compiling keymap with gmake --jobs=1 two_x_four:default
...
Creating UF2 file for deployment: .build/two_x_four_default.uf2                                      [OK]
Copying two_x_four_default.uf2 to qmk_firmware folder                                                [OK]
(Firmware size check does not yet support RP2040; skipping)
```

* add line "#define FORCE_NKRO" in file config.h and line "VIA_ENABLE = yes" in file rules.mk
* verify that firmware still compiles

* change diode direction, matrix layout and keycodes in files "info.json" and "keymaps/default/keymap.c"

```
$ git diff keyboards/two_x_four/info.json
diff --git a/keyboards/two_x_four/info.json b/keyboards/two_x_four/info.json
index 29a3e7167f..3bb7f038dd 100644
--- a/keyboards/two_x_four/info.json
+++ b/keyboards/two_x_four/info.json
@@ -3,7 +3,6 @@
     "keyboard_name": "two_x_four",
     "maintainer": "xxx",
     "bootloader": "rp2040",
-    "diode_direction": "COL2ROW",
     "features": {
         "bootmagic": true,
         "command": false,
@@ -13,8 +12,10 @@
         "nkro": true
     },
     "matrix_pins": {
-        "cols": ["GP1", "GP2", "GP3", "GP4"],
-        "rows": ["GP5", "GP6", "GP7", "GP8"]
+        "direct": [
+            ["GP13", "GP12", "GP11", "GP10"],
+            ["GP9", "GP8", "GP7", "GP6"]
+       ]
     },
     "processor": "RP2040",
     "url": "",
@@ -24,7 +25,7 @@
         "vid": "0xFEED"
     },
     "layouts": {
-        "LAYOUT_ortho_4x4": {
+        "LAYOUT_ortho_2x4": {
             "layout": [
                 { "matrix": [0, 0], "x": 0, "y": 0 },
                 { "matrix": [0, 1], "x": 1, "y": 0 },
@@ -33,15 +34,7 @@
                 { "matrix": [1, 0], "x": 0, "y": 1 },
                 { "matrix": [1, 1], "x": 1, "y": 1 },
                 { "matrix": [1, 2], "x": 2, "y": 1 },
-                { "matrix": [1, 3], "x": 3, "y": 1 },
-                { "matrix": [2, 0], "x": 0, "y": 2 },
-                { "matrix": [2, 1], "x": 1, "y": 2 },
-                { "matrix": [2, 2], "x": 2, "y": 2 },
-                { "matrix": [2, 3], "x": 3, "y": 2 },
-                { "matrix": [3, 0], "x": 0, "y": 3 },
-                { "matrix": [3, 1], "x": 1, "y": 3 },
-                { "matrix": [3, 2], "x": 2, "y": 3 },
-                { "matrix": [3, 3], "x": 3, "y": 3 }
+                { "matrix": [1, 3], "x": 3, "y": 1 }
             ]
         }
     }
$ git diff keyboards/two_x_four/keymaps/default/keymap.c
diff --git a/keyboards/two_x_four/keymaps/default/keymap.c b/keyboards/two_x_four/keymaps/default/keymap.c
index 26769e0bee..5dc5fb7e24 100644
--- a/keyboards/two_x_four/keymaps/default/keymap.c
+++ b/keyboards/two_x_four/keymaps/default/keymap.c
@@ -12,10 +12,8 @@ const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
      * │ 0 │ . │Ent│ + │
      * └───┴───┴───┴───┘
      */
-    [0] = LAYOUT_ortho_4x4(
-        KC_P7,   KC_P8,   KC_P9,   KC_PSLS,
-        KC_P4,   KC_P5,   KC_P6,   KC_PAST,
-        KC_P1,   KC_P2,   KC_P3,   KC_PMNS,
-        KC_P0,   KC_PDOT, KC_PENT, KC_PPLS
+    [0] = LAYOUT_ortho_2x4(
+        KC_P1,   KC_P2,   KC_P3,   KC_P4,
+        KC_P5,   KC_P6,   KC_P7,   KC_P8
     )
 };
$ cat keyboards/two_x_four/info.json
{
    "manufacturer": "xxx",
    "keyboard_name": "two_x_four",
    "maintainer": "xxx",
    "bootloader": "rp2040",
    "features": {
        "bootmagic": true,
        "command": false,
        "console": false,
        "extrakey": true,
        "mousekey": true,
        "nkro": true
    },
    "matrix_pins": {
        "direct": [
            ["GP13", "GP12", "GP11", "GP10"],
            ["GP9", "GP8", "GP7", "GP6"]
        ]
    },
    "processor": "RP2040",
    "url": "",
    "usb": {
        "device_version": "1.0.0",
        "pid": "0x0000",
        "vid": "0xFEED"
    },
    "layouts": {
        "LAYOUT_ortho_2x4": {
            "layout": [
                { "matrix": [0, 0], "x": 0, "y": 0 },
                { "matrix": [0, 1], "x": 1, "y": 0 },
                { "matrix": [0, 2], "x": 2, "y": 0 },
                { "matrix": [0, 3], "x": 3, "y": 0 },
                { "matrix": [1, 0], "x": 0, "y": 1 },
                { "matrix": [1, 1], "x": 1, "y": 1 },
                { "matrix": [1, 2], "x": 2, "y": 1 },
                { "matrix": [1, 3], "x": 3, "y": 1 }
            ]
        }
    }
}
$ cat keyboards/two_x_four/keymaps/default/keymap.c
#include QMK_KEYBOARD_H

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    /*
     * ┌───┬───┬───┬───┐
     * │ 1 │ 2 │ 3 │ 4 │
     * ├───┼───┼───┼───┤
     * │ 5 │ 6 │ 7 │ 8 │
     * └───┴───┴───┴───┘
     */
    [0] = LAYOUT_ortho_2x4(
        KC_P1,   KC_P2,   KC_P3,   KC_P4,
        KC_P5,   KC_P6,   KC_P7,   KC_P8
    )
};
```

* verify that firmware still compiles
* if keyboard hardware is available, flash keyboard and verify that key mapping is correct[^4]

## Usage

* create a file named "ortho_via.json" with the following content:

```
{
  "name": "two_x_four" ,
  "vendorId": "0xFEED",
  "productId": "0x0000",
  "matrix": { "rows": 2, "cols": 4 },
  "layouts": 
  {
    "keymap": 
	 [
		[{"y":0,"x":0},"0,0",{"x":1},"0,1",{"x":2},"0,2",{"x":3},"0,3"],
		[{"y":1,"x":0},"1,0",{"x":1},"1,1",{"x":2},"1,2",{"x":3},"1,3"]
	 ]
  }
}
```

* verify that key mapping can be changed using via[^5]
* the ui interface should look similiar to the following:

<img src="images/via_layout.png" alt="via_layout" width="800"/>


[^1]: [Raspberry Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/)
[^2]: [Adafruit Tactile Switch Buttons](https://www.adafruit.com/product/1119
[^3]: [Adafruit Learning System: Using QMK on RP2040] (https://learn.adafruit.com/using-qmk-on-rp2040-microcontrollers/overview)
[^4]: If you have a WebHID enabled browser like Chrome or Edge use [VIA](https://usevia.app/#/) otherwise use [key-rollover-test](https://www.mechanical-keyboard.org/key-rollover-test/)
[^5]: File is available at: [via_ortho_2x4.json](firmware/via_ortho_2x4.json)
[^6]:[VIA](https://www.caniusevia.com)

<!--
compress files e.g. https://www.iloveimg.com
-->
qqqqqwweeeeee