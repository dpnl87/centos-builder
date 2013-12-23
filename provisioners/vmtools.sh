#!/bin/bash -eux

echo "Installing VirtualBox guest additions"

# Assume that we've installed all the prerequisites:
# kernel-headers-$(uname -r) kernel-devel-$(uname -r) gcc make perl
# from the install media via ks.cfg

VBOX_VERSION=$(cat /home/vagrant/.vbox_version)
mount -o loop /home/vagrant/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
sh /mnt/VBoxLinuxAdditions.run --nox11
umount /mnt
rm -rf /home/vagrant/VBoxGuestAdditions_$VBOX_VERSION.iso
