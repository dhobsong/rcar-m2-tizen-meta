#! /bin/sh

# create zImage + dtb = dzImage
cat arch/arm/boot/zImage arch/arm/boot/dts/r8a7791-koelsch.dtb > arch/arm/boot/dzImage

# create duImage
DUIMAGE=`cut -f 3- -d ' ' < arch/arm/boot/.uImage.cmd | sed -e "s/zImage/dzImage/" | sed -e "s/uImage/duImage/"`
${DUIMAGE}
