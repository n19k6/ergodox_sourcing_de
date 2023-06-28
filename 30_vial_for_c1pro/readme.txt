tasks:

a) compile using qmk server and flash keyboard
[change something e.g. change keys, flash, flash orginal firmware]
b) compile locally e.g. debian or raspberry pi
c) compile with added vial support

add a)

#compile using qmk server:
invoke https://config.qmk.fm/#/keychron/c1_pro/ansi/white/LAYOUT_tkl_ansi
press compile
press firmware to download file "keychron_c1_pro_ansi_white_layout_tkl_ansi_mine.bin"
question: compiled firmware is smaller, what about keymap.json?

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







#######################################
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



