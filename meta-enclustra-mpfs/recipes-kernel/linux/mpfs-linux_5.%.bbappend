FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRCREV = "cfb9c0faf7fcce8aae1be044a375fa1c59708ed7"

ENCLUSTRA_KERNEL_PATCH_LIST = " \
    file://0001-Driver-for-SI5338-added.patch \
    file://0002-Devicetree-for-Mercury-MP1-added.patch \
    file://0003-Remove-devicetree-include-from-icicle-kit.patch \
    file://0004-gpio-microsemi-gpio-get-base-dynamically.patch \
    file://0005-Remove-USB-host-dependency.patch \
    file://0006-Add-atsha204a-driver-with-support-to-read-OTP-region.patch \
    "

ENCLUSTRA_KERNEL_DTS_LIST = " \
    file://enclustra_mercury_mp1.dts \
    file://enclustra_mercury_mp1_common.dtsi \
    file://enclustra_mercury_mp1_fabric.dtsi \
    file://enclustra_mercury_pe1.dtsi \
    file://enclustra_mercury_pe3.dtsi \
    file://enclustra_mercury_st1.dtsi \
    "

SRC_URI:append:me-mp1-250-ees-d3e = "${ENCLUSTRA_KERNEL_PATCH_LIST}"
SRC_URI:append:me-mp1-250-ees-d3e = "${ENCLUSTRA_KERNEL_DTS_LIST}"
SRC_URI:append:me-mp1-250-ees-d3e = " file://defconfig"
SRC_URI:append:me-mp1-250-si-d3en = "${ENCLUSTRA_KERNEL_PATCH_LIST}"
SRC_URI:append:me-mp1-250-si-d3en = "${ENCLUSTRA_KERNEL_DTS_LIST}"
SRC_URI:append:me-mp1-250-si-d3en = " file://defconfig"
SRC_URI:append:me-mp1-460-1si-d4e = "${ENCLUSTRA_KERNEL_PATCH_LIST}"
SRC_URI:append:me-mp1-460-1si-d4e = "${ENCLUSTRA_KERNEL_DTS_LIST}"
SRC_URI:append:me-mp1-460-1si-d4e = " file://defconfig"
SRC_URI:append:me-mp1-250-sipp-d3en = "${ENCLUSTRA_KERNEL_PATCH_LIST}"
SRC_URI:append:me-mp1-250-sipp-d3en = "${ENCLUSTRA_KERNEL_DTS_LIST}"
SRC_URI:append:me-mp1-250-sipp-d3en = " file://defconfig"

COMPATIBLE_MACHINE:append = \
    "|me-mp1-250-ees-d3e|me-mp1-250-si-d3en|me-mp1-250-sipp-d3en|me-mp1-460-1si-d4e"

do_add_enclustra_devicetree() {
    if [ ${MACHINE} = "me-mp1-250-ees-d3e" ] || \
       [ ${MACHINE} = "me-mp1-250-si-d3en" ] || \
       [ ${MACHINE} = "me-mp1-250-sipp-d3en" ] || \
       [ ${MACHINE} = "me-mp1-460-1si-d4e" ]; then

        cp ${WORKDIR}/enclustra_mercury_mp1.dts ${WORKDIR}/enclustra_mercury_mp1_temp.dts

        if [ ${ENCLUSTRA_BASEBOARD} = "pe1" ]; then
            echo "#include \"enclustra_mercury_pe1.dtsi\"" \
                >> ${WORKDIR}/enclustra_mercury_mp1_temp.dts
            cp ${WORKDIR}/enclustra_mercury_pe1.dtsi ${S}/arch/riscv/boot/dts/microchip/
        fi

        if [ ${ENCLUSTRA_BASEBOARD} = "pe3" ]; then
            echo "#include \"enclustra_mercury_pe3.dtsi\"" \
                >> ${WORKDIR}/enclustra_mercury_mp1_temp.dts
            cp ${WORKDIR}/enclustra_mercury_pe3.dtsi ${S}/arch/riscv/boot/dts/microchip/
        fi

        if [ ${ENCLUSTRA_BASEBOARD} = "st1" ]; then
            echo "#include \"enclustra_mercury_st1.dtsi\"" \
                >> ${WORKDIR}/enclustra_mercury_mp1_temp.dts
            cp ${WORKDIR}/enclustra_mercury_st1.dtsi ${S}/arch/riscv/boot/dts/microchip/
        fi

        echo "#include \"enclustra_mercury_mp1_fabric.dtsi\"" \
            >> ${WORKDIR}/enclustra_mercury_mp1_temp.dts

        cp ${WORKDIR}/enclustra_mercury_mp1_common.dtsi ${S}/arch/riscv/boot/dts/microchip/
        cp ${WORKDIR}/enclustra_mercury_mp1_fabric.dtsi ${S}/arch/riscv/boot/dts/microchip/
        cp ${WORKDIR}/enclustra_mercury_mp1_temp.dts ${S}/arch/riscv/boot/dts/microchip/enclustra_mercury_mp1.dts
    fi
}

addtask do_add_enclustra_devicetree after do_patch before do_configure
