# Enclustra Reference Design for Microchip Polarfire SoC

## Description

This is a Yocto layer to generate reference designs for the Enclustra
Mercury+ MP1 module.

## Compatibility

This reference design was tested on following operating systems:

- Ubuntu 21.04

## Requirements

Following packages are required:

    sudo apt install gawk wget git diffstat unzip texinfo gcc build-essential chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev pylint3 xterm python3-subunit mesa-common-dev zstd liblz4-tool libyaml-dev libelf-dev python3-distutils

See [Yocto System Requirements](https://docs.yoctoproject.org/3.4.2/ref-manual/system-requirements.html?highlight=host) for more details or requirements for other Linux distributions than Ubuntu.

## Build 

### Supported Machine Targets for Mercury+ MP1 module

The Enclustra Module can be specified as target device (variable: MACHINE). Following modules are supported:

- me-mp1-250-ees-d3e
- me-mp1-250-si-d3en
- me-mp1-250-sipp-d3en
- me-mp1-460-1si-d4en

### Supported Enclustra Base Boards

The Enclustra Base Board can be specified with BASEBOARD variable. Following baseboards are supported:

- PE1
- PE3
- ST1

### KAS

The recommended build flow is to use kas, which is a tool that provides an easy mechanism to setup a bitbake project. The configuration file **build.yml** provides all required settings for kas.

#### Installation

    python pip install kas

#### Usage

    kas build build.yml

or

    kas shell build.yml -c 'MACHINE=me-mp1-250-ees-d3e ENCLUSTRA_BASEBOARD=PE3 bitbake core-image-minimal-dev'

kas can be used to only checkout the repositories and setup the build directory. The build process can be started with bitbake.

    kas checkout kas-project.yml
    source openembedded-core/oe-init-script
    MACHINE=me-mp1-250-ees-d3e ENCLUSTRA_BASEBOARD=PE3 bitbake core-image-minimal-dev

See [kas documentation](https://kas.readthedocs.io/en/latest/command-line.html) for more details.

#### Speed-Up Build

To reuse the downloaded files and shared-state cache between different builds, the DL_DIR and SSTATE_DIR variable can be set to an existing directory.
If this project is built for the first time, these directories must be created manually. If the variables are not set, the default shared state cache and download directories in the build directory are used.

As example:

    export SSTATE_DIR="${HOME}/Desktop/riscv-sstate-cache"
    export DL_DIR="${HOME}/Desktop/yocto-downloads"

## Build HSS

### Prepare Toolchain

Download RISC-V GNU Newlib Toolchain from [SiFive](https://github.com/sifive/freedom-tools/releases)

    wget https://static.dev.sifive.com/dev-tools/freedom-tools/v2020.12/riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14.tar.gz
    tar xzvf riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14.tar.gz
    export CROSS_COMPILE=$(pwd)/riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14/bin/riscv64-unknown-elf-

### Generate Binary

    git clone git@gitlab.enclustra.com:Enclustra/BU-SP/OS/MPFS/hart-software-services.git
    cd hart-software-services
    make BOARD=me-mp1-250-ees-d3e defconfig
    make BOARD=me-mp1-250-ees-d3e

The generated file to be used as eNVM initialization data for boot mode 1 in Libero: hart-software-services/Default/hss-envm-wrapper-header.hex

### Update MSS Configuration

TODO

### Add HSS Binary to FPGA Bitstream

TODO
