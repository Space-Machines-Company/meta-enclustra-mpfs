FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

ENCLUSTRA_UBOOT_PATCH_LIST = " \
    file://0008-Enclustra-MAC-address-readout-from-EEPROM.patch \
    file://0009-Board-files-for-Mercury-MP1-added.patch \
    file://0010-Devicetree-for-Mercury-MP1-added.patch \
    "

ENCLUSTRA_UBOOT_DTS_LIST = " \
    file://enclustra_mercury_mp1_common.dtsi \
    file://enclustra_mercury_mp1.dts \
    file://enclustra_mercury_mp1-u-boot.dtsi \
    file://enclustra_mercury_mp1_defconfig \
    "

SRC_URI:append:me-mp1-250-ees-d3e := "${ENCLUSTRA_UBOOT_PATCH_LIST}"
SRC_URI:append:me-mp1-250-ees-d3e := "${ENCLUSTRA_UBOOT_DTS_LIST}"
SRC_URI:append:me-mp1-250-si-d3en := "${ENCLUSTRA_UBOOT_PATCH_LIST}"
SRC_URI:append:me-mp1-250-si-d3en := "${ENCLUSTRA_UBOOT_DTS_LIST}"
SRC_URI:append:me-mp1-250-sipp-d3en := "${ENCLUSTRA_UBOOT_PATCH_LIST}"
SRC_URI:append:me-mp1-250-sipp-d3en := "${ENCLUSTRA_UBOOT_DTS_LIST}"
SRC_URI:append:me-mp1-460-1si-d4e := "${ENCLUSTRA_UBOOT_PATCH_LIST}"
SRC_URI:append:me-mp1-460-1si-d4e := "${ENCLUSTRA_UBOOT_DTS_LIST}"

do_create_boot_script[nostamp] = "1"
do_create_boot_script() {
    if [ ${MACHINE} = "me-mp1-250-ees-d3e" ] || \
       [ ${MACHINE} = "me-mp1-250-si-d3en" ] || \
       [ ${MACHINE} = "me-mp1-250-sipp-d3en" ] || \
       [ ${MACHINE} = "me-mp1-460-1si-d4e" ]; then
        mkimage -O linux -T script -C none -n "U-Boot boot script" \
            -d ${WORKDIR}/${UBOOT_ENV}.txt ${WORKDIR}/boot.scr.uimg
    fi
}

do_add_enclustra_devicetree() {
    if [ ${MACHINE} = "me-mp1-250-ees-d3e" ] || \
       [ ${MACHINE} = "me-mp1-250-si-d3en" ] || \
       [ ${MACHINE} = "me-mp1-250-sipp-d3en" ] || \
       [ ${MACHINE} = "me-mp1-460-1si-d4e" ]; then
        cp ${WORKDIR}/enclustra_mercury_mp1_common.dtsi ${S}/arch/riscv/dts/
        cp ${WORKDIR}/enclustra_mercury_mp1.dts ${S}/arch/riscv/dts/
        cp ${WORKDIR}/enclustra_mercury_mp1-u-boot.dtsi ${S}/arch/riscv/dts/
        cp ${WORKDIR}/enclustra_mercury_mp1_defconfig ${S}/configs/
    fi
}

addtask do_create_boot_script after do_compile before do_install
addtask do_add_enclustra_devicetree after do_patch before do_configure
