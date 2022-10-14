# Try to boot a fitImage from the MMC
if load ${devtype} ${devnum}:${distro_bootpart} ${ramdisk_addr_r} fitImage; then
    bootm ${ramdisk_addr_r}
fi;
