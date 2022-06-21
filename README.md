# Enclustra Linux Reference Design for Microchip Polarfire SoC

## Description

This repository contains a Yocto layer to generate Linux reference designs for the Enclustra Mercury+ MP1 module.

## FPGA Reference Designs for Microchip Libero

The generated binaries are compatible with the FPGA and MSS configuration of following reference designs:

- ***TODO***: add link to all Libero reference designs

## Host Requirements

### Host Operating System

This reference design was tested on following operating systems:

- Ubuntu 20.04
- Ubuntu 21.04

### Required Packages

Following packages are required for building this reference design on Ubuntu:

    gawk wget git diffstat unzip texinfo gcc build-essential chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev pylint3 xterm python3-subunit mesa-common-dev zstd liblz4-tool libyaml-dev libelf-dev python3-distutils

The packages can be installed on with **sudo apt install \<package\>** command.
See [Yocto System Requirements](https://docs.yoctoproject.org/3.4.2/ref-manual/system-requirements.html?highlight=host) for more details about requirements for Linux distributions other than Ubuntu.

## Build 

### Supported Machine Targets

The Enclustra Module can be specified as target device (variable: **MACHINE**). Following modules are supported:

- me-mp1-250-ees-d3e
- me-mp1-250-si-d3en
- me-mp1-250-sipp-d3en
- me-mp1-460-1si-d4e

### Supported Enclustra Base Boards

The Enclustra Base Board can be specified with **ENCLUSTRA_BASEBOARD** variable. Following base boards are supported:

- pe1
- pe3
- st1

### Accelerate Build

To reuse the downloaded files and built packages for further builds, the **DL_DIR** and **SSTATE_DIR** variable can be set to a local directory. If this project is built for the first time, these directories must be created manually. If the variables are not set, the default directories in the build directory are used.

As example:

    export SSTATE_DIR="${HOME}/Desktop/riscv-sstate-cache"
    export DL_DIR="${HOME}/Desktop/yocto-downloads"

### KAS

The recommended build flow is to use kas, which is a Python based tool that provides an easy mechanism to setup a bitbake project. The configuration file [build.yml](build.yml) provides all required settings. See [documentation](https://kas.readthedocs.io/en/latest/command-line.html) for more details.

#### Installation

    pip install kas
    export PATH=$PATH:${HOME}/.local/bin

#### Usage \#1

Use following command to build the target specified in the build.yml file. All base board dependent peripherals are disabled.

    kas build build.yml

#### Usage \#2

Use following command to specify the bitbake command to be executed. **MACHINE** and **ENCLUSTRA_BASEBOARD** variable can be overridden according to sections [Supported Machine Targets](#supported-machine-targets) and [Supported Enclustra Base Boards](#supported-enclustra-base-boards).

    kas shell build.yml -c 'MACHINE=me-mp1-250-ees-d3e ENCLUSTRA_BASEBOARD=pe3 bitbake core-image-minimal'

Note that the image **core-image-minimal** can be replaced by any available image. Following are a few examples, provided by openembedded-core layer:
- core-image-base
- core-image-minimal
- core-image-minimal-dev
- core-image-x11

#### Usage \#3

The tool kas can be used to checkout the repositories and setup the build directory. The build process can be started independently with bitbake as shown in following example.

    kas checkout kas-project.yml
    source openembedded-core/oe-init-build-env 
    export BB_ENV_EXTRAWHITE="ENCLUSTRA_BASEBOARD"
    MACHINE=me-mp1-250-ees-d3e ENCLUSTRA_BASEBOARD=pe3 bitbake core-image-minimal

## Deployment

The OpenEmbedded Image Creator (wic) creates a partitioned image file for SD Card/eMMC boot. The partitions are configured in an OpenEmbedded kickstart file ([mpfs-icicle-kit.wks](https://github.com/polarfire-soc/meta-polarfire-soc-yocto-bsp/blob/master/wic/mpfs-icicle-kit.wks)) that is located in the [meta-polarfire-soc-yocto-bsp](https://github.com/polarfire-soc/meta-polarfire-soc-yocto-bsp) layer. The image file to be deployed on SD Card/eMMC can be found in **build/tmp-glibc/deploy/images/\<MACHINE\>** directory, e.g. **core-image-minimal-me-mp1-250-ees-d3e.wic**.

### Creating a Bootable SD Card

Copy the image file to a SD card e.g.

    dd if=core-image-minimal-me-mp1-250-ees-d3e.wic of=<device> && sync

Note that the device of the SD card (\<device\>) need to be replaced with the SD Card device on your host (e.g. /dev/sdd).

### eMMC Memory

***TODO:***

## Login on Target

Login with **root** account, no password is set.

## Base Board Dependent Peripherals

If the **ENCLUSTRA_BASEBOARD** variable is set to an Enclustra Base Board, a devicetree include file is added for the Linux kernel which contains base-board specific configuration settings:
 
- ENCLUSTRA_BASEBOARD=pe1: [enclustra_mercury_pe1.dtsi](meta-enclustra-mpfs/recipes-kernel/linux/files/enclustra_mercury_pe1.dtsi)
- ENCLUSTRA_BASEBOARD=pe3: [enclustra_mercury_pe3.dtsi](meta-enclustra-mpfs/recipes-kernel/linux/files/enclustra_mercury_pe3.dtsi)
- ENCLUSTRA_BASEBOARD=st1: [enclustra_mercury_st1.dtsi](meta-enclustra-mpfs/recipes-kernel/linux/files/enclustra_mercury_st1.dtsi)

## Build HSS (Hart Software Services)
This Linux reference design requires that the MSS is configured by the HSS with the reference design. Enclustra provides a fork of the [Microchip hart-software-services](https://github.com/polarfire-soc/hart-software-services) repository with added build targets for the supported Enclustra modules. The xml files generated with the Microchip MSS Configurator tool are already available in the Enclustra hart-software-services fork.

### Prepare Toolchain

It is recommended to use a pre-compiled toolchain as provided by [SiFive](https://github.com/sifive/freedom-tools/releases). Use following commands to download the RISC-V GNU Newlib Toolchain and setup the cross-compiler.

    wget https://static.dev.sifive.com/dev-tools/freedom-tools/v2020.12/riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14.tar.gz
    tar xzvf riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14.tar.gz
    export CROSS_COMPILE=$(pwd)/riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14/bin/riscv64-unknown-elf-

### Generate Binary

To build the HSS binary, use following commands. The **BOARD** variable needs to be set to the corresponding Enclustra module ([Supported Machine Targets](#supported-machine-targets))

    git clone git@gitlab.enclustra.com:Enclustra/BU-SP/OS/MPFS/hart-software-services.git
    cd hart-software-services
    make BOARD=me-mp1-250-ees-d3e defconfig
    make BOARD=me-mp1-250-ees-d3e

The generated file to be used as eNVM initialization data for boot mode 1 in Libero can be found in **hart-software-services/Default/**  directory and is named **hss-envm-wrapper-header.hex**.

## Known Issues:

#### Minimal I2C Frequency

The clock frequency of the I2C bus is derived from the MSS AHB/APB bus clock. This clock is set to 150MHz by default.  Because the biggest possible divider value is 960, the slowest possible I2C frequency is 150MHz/960=156.25kHz. With this
156.25kHz I2C clock frequency, the wake-up pulse duration of the Atmel ATSHA204a device is violated (52us instead of 60us). Measurements has shown that the device wakes up reliable when the wake-up pulse is bigger than 30us.

## License

See [License](meta-enclustra-mpfs/COPYING.MIT)

## Changelog

***TODO*** First release
