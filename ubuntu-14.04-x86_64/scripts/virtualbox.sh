#!/usr/bin/env bash
# Bail if we are not running inside VirtualBox.
(lspci | grep -i virtualbox > /dev/null) || {
	exit 0
}

if [ ! -f /tmp/VBoxGuestAdditions.iso ]; then
	echo "VirtualBox Guest Additions iso file missing."
	exit 1
fi

trap "umount /mnt/virtualbox; rm -rf /mnt/virtualbox /tmp/VBoxGuestAdditions.iso" EXIT

# Installing the virtualbox guest additions
mkdir -p /mnt/virtualbox
mount -o loop /tmp/VBoxGuestAdditions.iso /mnt/virtualbox

(sh /mnt/virtualbox/VBoxLinuxAdditions.run --nox11) || {
	echo "VirtualBox Guest Additions Installer failed. This may be safely ignored..." >&2
}
