#!/usr/bin/env bash
# Bail if we are not running inside VMWare.
(lspci | grep -i vmware > /dev/null) || {
  exit 0
}

if [ ! -f /tmp/vmware-tools.iso ]; then
	echo "VMware Tools iso file missing."
	exit 1
fi

trap "umount /mnt/vmware; rm -rf /mnt/vmware /tmp/vmware-tools.iso /tmp/vmware-tools-distrib" EXIT

# Install the VMWare Tools from a linux ISO.
mkdir -p /mnt/vmware
mount -o loop /tmp/vmware-tools.iso /mnt/vmware

cd /tmp
tar xzf /mnt/vmware/VMwareTools-*.tar.gz

/tmp/vmware-tools-distrib/vmware-install.pl -d
