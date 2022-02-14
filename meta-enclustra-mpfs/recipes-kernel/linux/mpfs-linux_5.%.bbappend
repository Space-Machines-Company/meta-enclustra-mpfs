FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

ENCLUSTRA_KERNEL_PATCH_LIST = " \
    file://0001-Driver-for-SI5338-added.patch \
    file://0002-Devicetree-for-Mercury-MP1-added.patch \
    "
ENCLUSTRA_KERNEL_DTS_LIST = " \
    file://enclustra_mercury_mp1.dts \
    file://enclustra_mercury_mp1_common.dtsi \
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

COMPATIBLE_MACHINE:append = \
    "|me-mp1-250-ees-d3e|me-mp1-250-si-d3en|me-mp1-460-1si-d4e"

do_add_enclustra_devicetree() {
    if [ ${MACHINE} = "me-mp1-250-ees-d3e" ] || \
       [ ${MACHINE} = "me-mp1-250-si-d3en" ] || \
       [ ${MACHINE} = "me-mp1-460-1si-d4e" ]; then

        if [ ${ENCLUSTRA_BASEBOARD} = "PE1" ]; then
            echo "#include \"enclustra_mercury_pe1.dtsi\"" \
                >> ${WORKDIR}/enclustra_mercury_mp1.dts
            cp ${WORKDIR}/enclustra_mercury_pe1.dtsi ${S}/arch/riscv/boot/dts/microchip/
        fi

        if [ ${ENCLUSTRA_BASEBOARD} = "PE3" ]; then
            echo "#include \"enclustra_mercury_pe3.dtsi\"" \
                >> ${WORKDIR}/enclustra_mercury_mp1.dts
            cp ${WORKDIR}/enclustra_mercury_pe3.dtsi ${S}/arch/riscv/boot/dts/microchip/
        fi

        if [ ${ENCLUSTRA_BASEBOARD} = "ST1" ]; then
            echo "#include \"enclustra_mercury_st1.dtsi\"" \
                >> ${WORKDIR}/enclustra_mercury_mp1.dts
            cp ${WORKDIR}/enclustra_mercury_st1.dtsi ${S}/arch/riscv/boot/dts/microchip/
        fi

        cp ${WORKDIR}/enclustra_mercury_mp1_common.dtsi ${S}/arch/riscv/boot/dts/microchip/
        cp ${WORKDIR}/enclustra_mercury_mp1.dts ${S}/arch/riscv/boot/dts/microchip/
    fi
}

addtask do_add_enclustra_devicetree after do_patch before do_configure

