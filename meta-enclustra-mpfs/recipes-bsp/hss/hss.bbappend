FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

# Strict dependency
do_configure:me-mp1-250-ees-d3e[depends] += "u-boot:do_deploy"
do_configure:me-mp1-250-si-d3en[depends] += "u-boot:do_deploy"
do_configure:me-mp1-460-1si-d4e[depends] += "u-boot:do_deploy"

## taking U-Boot binary and package for HSS
do_configure() {
    if [ ${MACHINE} = "me-mp1-250-ees-d3e" ] || \
       [ ${MACHINE} = "me-mp1-250-si-d3en" ] || \
       [ ${MACHINE} = "me-mp1-460-1si-d4e" ]; then
        cp -f ${DEPLOY_DIR_IMAGE}/u-boot.bin ${WORKDIR}/git/
        cp -f ${WORKDIR}/${HSS_PAYLOAD}.yaml ${WORKDIR}/git/tools/hss-payload-generator/
    fi
}
