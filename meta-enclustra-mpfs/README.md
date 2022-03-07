# Yocto BSP Layer for Enclustra Modules equipped with Microchip SoCs

This layer provides support for Enclustra System-on-Chip modules equipped with Microchip Polarfire SoCs.

For more information on available Enclustra Modules, please visit:

https://www.enclustra.com/en/products/system-on-chip-modules/

# Dependencies

This Yocto layer depends on:

  URI: https://git.openembedded.org/openembedded-core
  layers: meta
  tag: 2021-10.1-honister
  revision: 70384dd958c57d1da924a66cffa35f80eb60d4b0

  URI: https://github.com/riscv/meta-riscv
  branch: honister
  revision: 9561639c61663a10d8c9c23d26173db499f4c39b

  URI: https://github.com/polarfire-soc/meta-polarfire-soc-yocto-bsp
  tag: v2021.11
  revision: 02cb81741a5e1b37f89318d04ebc6b2854bfe736

# Submit Patches / Reporting Bugs

Please report bugs or submit patches against the meta-enclustra-msoc layer to following address:

support@enclustra.com

# Building Instructions

See [README](https://gitlab.enclustra.com/Enclustra/BU-SP/OS/MPFS/meta-enclustra-mpfs/-/blob/main/README.md)

# License

All metadata is MIT licensed unless otherwise stated. Source code included in tree for individual recipes are under the LICENSE stated in the associated recipe (.bb file) unless otherwise stated.
