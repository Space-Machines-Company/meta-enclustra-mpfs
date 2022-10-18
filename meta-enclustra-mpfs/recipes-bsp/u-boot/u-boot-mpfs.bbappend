FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

ENCLUSTRA_UBOOT_PATCH_LIST = " \
    file://0008-Enclustra-MAC-address-readout-from-EEPROM.patch \
    file://0009-Board-files-for-Mercury-MP1-added.patch \
    file://0010-Devicetree-for-Mercury-MP1-added.patch \
    file://0011-PolarFire-SoC-I2C-driver-modification-for-zero-sized.patch \
    file://0012-Bugfix-for-atsha204a-driver.patch \
    file://0014-Use-only-high-memory-region.patch \
    file://0015-Rename-mpfs-devicetree.patch \
    "

ENCLUSTRA_UBOOT_DTS_LIST = " \
    file://enclustra_mercury_mp1_common.dtsi \
    file://enclustra_mercury_mp1.dts \
    file://enclustra_mercury_mp1-u-boot.dtsi \
    "

ENCLUSTRA_UBOOT_COMMON_FILE_LIST = " \
    file://enclustra_mercury_mp1_defconfig \
    file://${UBOOT_ENV_SRC} \
    ${ENCLUSTRA_UBOOT_PATCH_LIST} \
    ${ENCLUSTRA_UBOOT_DTS_LIST} \
    "

# Remove unwanted files added by meta-polarfire-soc-yocto-bsp
SRC_URI:remove:me-mp1-250-ees-d3e := " file://${UBOOT_ENV}.txt"
SRC_URI:remove:me-mp1-250-ees-d3e-e1 := " file://${UBOOT_ENV}.txt"
SRC_URI:remove:me-mp1-250-si-d3en := " file://${UBOOT_ENV}.txt"
SRC_URI:remove:me-mp1-250-si-d3en-e1 := " file://${UBOOT_ENV}.txt"
SRC_URI:remove:me-mp1-460-1si-d4e := " file://${UBOOT_ENV}.txt"
SRC_URI:remove:me-mp1-460-1si-d4e-e1 := " file://${UBOOT_ENV}.txt"

SRC_URI:append:me-mp1-250-ees-d3e := " ${ENCLUSTRA_UBOOT_COMMON_FILE_LIST}"
SRC_URI:append:me-mp1-250-ees-d3e-e1 := " ${ENCLUSTRA_UBOOT_COMMON_FILE_LIST}"
SRC_URI:append:me-mp1-250-si-d3en := " ${ENCLUSTRA_UBOOT_COMMON_FILE_LIST}"
SRC_URI:append:me-mp1-250-si-d3en-e1 := " ${ENCLUSTRA_UBOOT_COMMON_FILE_LIST}"
SRC_URI:append:me-mp1-460-1si-d4e := " ${ENCLUSTRA_UBOOT_COMMON_FILE_LIST}"
SRC_URI:append:me-mp1-460-1si-d4e-e1 := " ${ENCLUSTRA_UBOOT_COMMON_FILE_LIST}"

COMPATIBLE_MACHINE:append = " \
    |me-mp1-250-ees-d3e|me-mp1-250-si-d3en|me-mp1-460-1si-d4e \
    |me-mp1-250-ees-d3e-e1|me-mp1-250-si-d3en-e1|me-mp1-460-1si-d4e-e1 \
    "

do_add_enclustra_devicetree() {
    if [ ${MACHINE} = "me-mp1-250-ees-d3e" ] || \
       [ ${MACHINE} = "me-mp1-250-ees-d3e-e1" ] || \
       [ ${MACHINE} = "me-mp1-250-si-d3en" ] || \
       [ ${MACHINE} = "me-mp1-250-si-d3en-e1" ] || \
       [ ${MACHINE} = "me-mp1-460-1si-d4e" ] || \
       [ ${MACHINE} = "me-mp1-460-1si-d4e-e1" ]; then
        cp ${WORKDIR}/enclustra_mercury_mp1_common.dtsi ${S}/arch/riscv/dts/
        cp ${WORKDIR}/enclustra_mercury_mp1.dts ${S}/arch/riscv/dts/
        cp ${WORKDIR}/enclustra_mercury_mp1-u-boot.dtsi ${S}/arch/riscv/dts/
        cp ${WORKDIR}/enclustra_mercury_mp1_defconfig ${S}/configs/
    fi
}

addtask do_add_enclustra_devicetree after do_patch before do_configure
