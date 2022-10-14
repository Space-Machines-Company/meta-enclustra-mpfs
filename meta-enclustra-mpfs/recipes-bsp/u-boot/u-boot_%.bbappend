FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

ENCLUSTRA_UBOOT_PATCH_LIST = " \
    file://0008-Enclustra-MAC-address-readout-from-EEPROM.patch \
    file://0009-Board-files-for-Mercury-MP1-added.patch \
    file://0010-Devicetree-for-Mercury-MP1-added.patch \
    file://0011-PolarFire-SoC-I2C-driver-modification-for-zero-sized.patch \
    file://0012-Bugfix-for-atsha204a-driver.patch \
    file://0013-Add-Microchip-Polarfire-SoC-QSPI-driver.patch \
    file://0014-Use-only-high-memory-region.patch \
    "

ENCLUSTRA_UBOOT_DTS_LIST = " \
    file://enclustra_mercury_mp1_common.dtsi \
    file://enclustra_mercury_mp1.dts \
    file://enclustra_mercury_mp1-u-boot.dtsi \
    "

SRC_URI:append:me-mp1-250-ees-d3e := " \
    file://enclustra_mercury_mp1_defconfig \
    file://${HSS_PAYLOAD}.yaml \
    ${ENCLUSTRA_UBOOT_PATCH_LIST} \
    ${ENCLUSTRA_UBOOT_DTS_LIST}"

SRC_URI:append:me-mp1-250-ees-d3e-e1 := " \
    file://enclustra_mercury_mp1_defconfig \
    file://${HSS_PAYLOAD}.yaml \
    ${ENCLUSTRA_UBOOT_PATCH_LIST} \
    ${ENCLUSTRA_UBOOT_DTS_LIST}"

SRC_URI:append:me-mp1-250-si-d3en := " \
    file://enclustra_mercury_mp1_defconfig \
    file://${HSS_PAYLOAD}.yaml \
    ${ENCLUSTRA_UBOOT_PATCH_LIST} \
    ${ENCLUSTRA_UBOOT_DTS_LIST}"

SRC_URI:append:me-mp1-250-si-d3en-e1 := " \
    file://enclustra_mercury_mp1_defconfig \
    file://${HSS_PAYLOAD}.yaml \
    ${ENCLUSTRA_UBOOT_PATCH_LIST} \
    ${ENCLUSTRA_UBOOT_DTS_LIST}"

SRC_URI:append:me-mp1-460-1si-d4e := " \
    file://enclustra_mercury_mp1_defconfig \
    file://${HSS_PAYLOAD}.yaml \
    ${ENCLUSTRA_UBOOT_PATCH_LIST} \
    ${ENCLUSTRA_UBOOT_DTS_LIST}"

SRC_URI:append:me-mp1-460-1si-d4e-e1 := " \
    file://enclustra_mercury_mp1_defconfig \
    file://${HSS_PAYLOAD}.yaml \
    ${ENCLUSTRA_UBOOT_PATCH_LIST} \
    ${ENCLUSTRA_UBOOT_DTS_LIST}"

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
