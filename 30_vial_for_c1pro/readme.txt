tasks:
a) retrieve original firmware version and flash latest one provided by keychron website

b) compile using qmk server and flash keyboard
[change something e.g. change keys, flash, flash orginal firmware]
c) compile locally e.g. debian or raspberry pi
d) compile with added vial support

add a)
wmic path CIM_LogicalDevice where "Description like 'USB%'" get /value | findstr 3434 | findstr REV
HardwareID={"USB\VID_3434&amp;PID_0513&amp;REV_0100","USB\VID_3434&amp;PID_0513"}

REV_0100 -> Version 1.00

https://www.keychron.com/blogs/archived/how-to-factory-reset-or-flash-your-qmk-via-enabled-keychron-c1-pro-keyboard
Download C1 Pro ANSI White Backlit Version Firmware -> c1_us_white_v1.1.bin
https://github.com/qmk/qmk_toolbox/releases/download/0.2.2/qmk_toolbox.exe
used qmk toolbox on esxi vm

C:\Users\rze>wmic path CIM_LogicalDevice where "Description like 'USB%'" get /value | findstr 3434 | findstr REV
HardwareID={"USB\VID_3434&amp;PID_0513&amp;REV_0101","USB\VID_3434&amp;PID_0513"}


add b)

#compile using qmk server:
visited on 20230630
invoke https://config.qmk.fm/#/keychron/c1_pro/ansi/white/LAYOUT_tkl_ansi
press compile
press firmware to download file "keychron_c1_pro_ansi_white_layout_tkl_ansi_mine.bin"
question: compiled firmware is smaller, what about keymap.json?
-> red led, left from reset botton is activated
version states 1.00

dump:
#original firmware (not available)
C:\Users\rze>wmic path CIM_LogicalDevice where "Description like 'USB%'" get /value | findstr 3434 | findstr REV
HardwareID={"USB\VID_3434&amp;PID_0513&amp;REV_0100","USB\VID_3434&amp;PID_0513"}
HardwareID={"USB\VID_3434&amp;PID_0513&amp;REV_0100&amp;MI_00","USB\VID_3434&amp;PID_0513&amp;MI_00"}
HardwareID={"USB\VID_3434&amp;PID_0513&amp;REV_0100&amp;MI_01","USB\VID_3434&amp;PID_0513&amp;MI_01"}
HardwareID={"USB\VID_3434&amp;PID_0513&amp;REV_0100&amp;MI_02","USB\VID_3434&amp;PID_0513&amp;MI_02"}
HardwareID={"USB\VID_3434&amp;PID_0513&amp;REV_0100&amp;MI_03","USB\VID_3434&amp;PID_0513&amp;MI_03"}

#firmware c1_us_white_v1.1.bin
C:\Users\rze>wmic path CIM_LogicalDevice where "Description like 'USB%'" get /value | findstr 3434 | findstr REV
HardwareID={"USB\VID_3434&amp;PID_0513&amp;REV_0101","USB\VID_3434&amp;PID_0513"}
HardwareID={"USB\VID_3434&amp;PID_0513&amp;REV_0101&amp;MI_03","USB\VID_3434&amp;PID_0513&amp;MI_03"}
HardwareID={"USB\VID_3434&amp;PID_0513&amp;REV_0101&amp;MI_02","USB\VID_3434&amp;PID_0513&amp;MI_02"}
HardwareID={"USB\VID_3434&amp;PID_0513&amp;REV_0101&amp;MI_01","USB\VID_3434&amp;PID_0513&amp;MI_01"}
HardwareID={"USB\VID_3434&amp;PID_0513&amp;REV_0101&amp;MI_00","USB\VID_3434&amp;PID_0513&amp;MI_00"}

#firmware compiled using qmk server on 20230630                                                                                                                                                         
C:\Users\rze>wmic path CIM_LogicalDevice where "Description like 'USB%'" get /value | findstr 3434 | findstr REV
HardwareID={"USB\VID_3434&amp;PID_0513&amp;REV_0100","USB\VID_3434&amp;PID_0513"}
HardwareID={"USB\VID_3434&amp;PID_0513&amp;REV_0100&amp;MI_01","USB\VID_3434&amp;PID_0513&amp;MI_01"}
HardwareID={"USB\VID_3434&amp;PID_0513&amp;REV_0100&amp;MI_00","USB\VID_3434&amp;PID_0513&amp;MI_00"}

#use qmk server firmware for some days, use via to set volume keys:
edge https://usevia.app/#/
no via support: no compatible devices found -> install official 1.1 firmware and try via again
red light stays active, perhaps normal, device is detected in via as Keychron C1 Pro
download c1_us_white_v1.1.json.zip, https://www.keychron.com/products/keychron-c1-pro-qmk-via-wired-mechanical-keyboard?variant=40359223361625
, turn on "Show Design tab" on "Settings" tab, and drag the JSON file into the “Design” tab on VIA to get the C1 Pro keymap working on VIA.
use load button in load draft definition context
button arrow right can not be programmed -> interesting: email keychron

-------
button arrow right can not be programmed:
pscp [options] [user@]host:source target
pscp rze@vmc1pro:/home/rze/project_c1_pro/qmk_firmware/keychron_c1_pro_ansi_white_default.bin c:\github\ergodox_sourcing_de\30_vial_for_c1pro




-------


#compile locally using debian 12
   16  mkdir project_c1pro
   17  cd project_c1pro/
   19  sudo apt-get install python3-venv
   20  python3 -m venv venv
   22  . venv/bin/activate
   24  python3 -mpip install  qmk
   qmk --version
   qmk setup -H ~/project_c1pro/qmk_firmware
   qmk compile -kb keychron/c1_pro/ansi/white -km default
   ls qmk_firmware/.build
   

ressources:
https://config.qmk.fm/#/keychron/c1_pro/ansi/white/LAYOUT_tkl_ansi
https://www.keychron.com/pages/firmware
https://www.keychron.com/blogs/archived/how-to-factory-reset-or-flash-your-qmk-via-enabled-keychron-c1-pro-keyboard -> c1_us_white_v1.1.bin
https://www.keychron.com/pages/how-to-check-your-keyboard-firmware-version-on-windows-device -> q11 -> HID\VID_3434&PID_01E0&REV_0101&MI_00 -> version 1.01
 

c1_pro:
https://cdn.shopify.com/s/files/1/0059/0630/1017/files/c1_us_white_v1.1.bin?v=1683861222
c1:
only exe installer, since no programmable keyboard







####################################################################################################
old stuff:


steps:

create temporary debian vm (vm-c1pro)

old:
install debian (debian-11.6.0-amd64-netinst.iso) using text-based installer with "Debian desktop environment" disabled and "SSH server" and "standard system utilities" enabled
install sudo via "apt install sudo"
add user to sudoers file using visudo, e.g " ALL=(ALL:ALL) ALL". replace placeholder with current user

new:
   1  ls
   16  mkdir project_c2pro
   17  cd project_c2pro/
   19  sudo apt-get install python3-venv
   20  python3 -m venv venv
   22  . venv/bin/activate
   24  python3 -mpip install  qmk

qmk version 1.1.2

https://github.com/Keychron/qmk_firmware/tree/keychron-c1_pro/keyboards/keychron/c1_pro

https://www.keychron.com/pages/firmware

https://www.keychron.com/pages/keychron-c1-pro-user-manual

(venv) rze@vmc1pro:~/qmk_firmware/keyboards$ qmk compile -kb keychron/v4/ansi -km default

how to compile c1 pro

https://www.keychron.com/blogs/archived/how-to-factory-reset-or-flash-your-qmk-via-enabled-keychron-c1-pro-keyboard


1. flash (website: win or mac)
2. compile useing qmk configurator website


https://github.com/qmk/qmk_firmware/pull/20700

https://www.youtube.com/watch?v=1bRqxVm_wvo

NEW:
python3 -m venv venv
. venv/bin/activate
python3 -mpip install qmk
cd ~



