rcar-m2-tizen-meta
==================

This repository provides the kernel config file, append script and tizen ks file
necessary to build a basic Tizen IVI image for the Renesas R-Car M2 platform

The content of this repository should find itself upstream eventually, but until then ...

Building the image
==================

Prepare an SD Card
------------------

Format an SD card (minimum 1G, but more is nice too) to have the following partitions:
1. minimum 20MB, ext4 filesystem
2. mimimum 800MB, ext4 filesystem

Kernel build
------------

Kernel source code for the Renesas M2 board can be checked out from:

Copy contents of kernel/ directory from this repo to the kernel source
directory

Build the kernel

    $ cp config .config
    $ export CROSS_COMPILE=arm_none_linux_gnueabi- (or other ARM cross compiler)
    $ export ARCH=arm
    $ LOADADDR=40008000 make uImage
    $ ./duImage-m2.sh

Copy `arch/arm/boot/duImage` to partition 1 of the SD card

Tizen IVI platform build
------------------------

Create a Tizen IVI image with the ks file from the ks directory of this repo.

    $ gbs createimage -K ivi-mbr-renesas-m2.ks

Extract the contents of the image tarball and copy to SD Card partition 2

    $ tar xzf mic_output/<image name>.tar.gz
    $ dd if=platform.img of=/dev/sdx2

You can use `resize2fs` to resize the filesystem to fill the rest of the
SD card partion

Booting the platform
--------------------

Connect a micro USB cable to Serial 0 on the board and use a terminal
program to connect at 115200 baud.

From U-Boot load and boot the kernel image from the SD card

    => ext4load mmc 0 40007fc0 duImage
    => bootm

Boot and enjoy
