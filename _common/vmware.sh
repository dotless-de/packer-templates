# Bail if we are not running inside VMWare.
(lspci | grep -i vmware > /dev/null) || {
  exit 0
}

# Install the VMWare Tools from a linux ISO.
mkdir -p /mnt/vmware
mount -o loop /tmp/linux.iso /mnt/vmware

cd /tmp
tar xzf /mnt/vmware/VMwareTools-*.tar.gz

umount /mnt/vmware
rm -rf /mnt/vmware
rm -rf /tmp/linux.iso

/tmp/vmware-tools-distrib/vmware-install.pl -d
rm -rf /tmp/vmware-tools-distrib
