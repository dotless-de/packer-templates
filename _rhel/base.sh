# Base install

# Add epel repo permanently
cat > /etc/yum.repos.d/epel.repo << EOM
[epel]
name=epel
mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=epel-6&arch=\$basearch
enabled=1
gpgcheck=0
EOM

yum -y install kernel-devel-`uname -r` fuse fuse-devel fuse-libs
