#!/bin/bash

iasl -tc cirrus_ssdt_patch.dsl
mkdir -p kernel/firmware/acpi
cp cirrus_ssdt_patch.aml kernel/firmware/acpi
find kernel | cpio -H newc --create > patched_cirrus_acpi.cpio
sudo cp patched_cirrus_acpi.cpio /boot/patched_cirrus_acpi.cpio

echo 'GRUB_EARLY_INITRD_LINUX_CUSTOM="patched_cirrus_acpi.cpio"' >> /etc/default/grub
sudo grub2-mkconfig -o /etc/grub2-efi.cfg

cp -r cirrus /lib/firmware/
