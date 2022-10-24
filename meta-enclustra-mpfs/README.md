# Yocto BSP Layer for Enclustra Modules equipped with Microchip SoCs

This layer provides support for Enclustra System-on-Chip modules equipped with Microchip Polarfire SoCs.

For more information on available Enclustra Modules, please visit:

https://www.enclustra.com/en/products/system-on-chip-modules/

# Dependencies

This Yocto layer depends on:

URI: https://git.openembedded.org/openembedded-core<br>
layers: meta<br>
revision: f4dbdb9774eb61a71289fe91b017b4caf9c34b16

URI: https://github.com/riscv/meta-riscv<br>
revision: 18227c1de0a56327a22b94b2594fbeb45c1dfcff

URI: https://github.com/polarfire-soc/meta-polarfire-soc-yocto-bsp<br>
tag: v2022.09<br>
revision: 07438a5526dd33226d5341ae3a901c6ee0594dfd

URI git://git.yoctoproject.org/meta-security<br>
layers: meta-tpm<br>
revision: 59295103f1f87b207e5c3e154e6ad01291e1f9df

# Submit Patches / Reporting Bugs

Please report bugs or submit patches against the meta-enclustra-mpfs layer to following address:

support@enclustra.com

# Building Instructions

See [README](../README.md)

# License

All metadata is MIT licensed unless otherwise stated. Source code included in tree for individual recipes are under the LICENSE stated in the associated recipe (.bb file) unless otherwise stated.
