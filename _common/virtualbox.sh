#!/usr/bin/env bash
# Bail if we are not running inside VirtualBox.
(lspci | grep -i virtualbox > /dev/null) || {
	exit 0
}

# Installing the virtualbox guest additions
mkdir -p /mnt/virtualbox
mount -o loop /tmp/VBoxGuestAdditions.iso /mnt/virtualbox

sh /mnt/virtualbox/VBoxLinuxAdditions.run --nox11

umount /mnt/virtualbox
rm -rf /mnt/virtualbox
rm -rf /tmp/VBoxGuestAdditions.iso

