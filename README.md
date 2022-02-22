# Enclustra Reference Design for Microchip Polarfire SoC

## Description

This is a Yocto layer to generate reference designs for the Enclustra
Mercury+ MP1 module.

## Compatibility

This reference design was tested on following operating systems:

- Ubuntu 21.04

## Requirements
#### Yocto

See [Yocto System Requirements](https://docs.yoctoproject.org/3.4.2/ref-manual/system-requirements.html?highlight=host)

####  KAS

Installation

    python pip install kas

## Build 

#### Supported Machine Targets for Mercury+ MP1 module

- me-mp1-250-ees-d3e
- me-mp1-250-si-d3en
- me-mp1-250-sipp-d3en
- me-mp1-460-1si-d4en

####  KAS
    kas build build.yml

or

    kas shell build.yml -c 'MACHINE=me-mp1-250-si-d3en BASEBOARD=PE3 bitbake core-image-minimal-dev'

## Build HSS

#### Prepare Toolchain

Download RISC-V GNU Newlib Toolchain from [SiFive](https://github.com/sifive/freedom-tools/releases)

    wget https://static.dev.sifive.com/dev-tools/freedom-tools/v2020.12/riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14.tar.gz
    tar xzvf riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14.tar.gz
    export CROSS_COMPILE=$(pwd)/riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14/bin/riscv64-unknown-elf-

#### Generate Binary

    git clone git@gitlab.enclustra.com:Enclustra/BU-SP/OS/MPFS/hart-software-services.git
    cd hart-software-services
    make BOARD=me-mp1-250-ees-d3e defconfig
    make BOARD=me-mp1-250-ees-d3e

The generated file to be used as eNVM initialization data for boot mode 1 in Libero: hart-software-services/Default/hss-envm-wrapper-header.hex
