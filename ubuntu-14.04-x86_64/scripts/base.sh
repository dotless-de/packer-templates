#!/usr/bin/env bash

apt-get -y install linux-headers-`uname -r`

# Setup sudoers for user vagrant
cat > /tmp/sudoers_vagrant <<EOM
Defaults:vagrant !requiretty
vagrant        ALL=(ALL)       NOPASSWD: ALL
EOM
chmod 0440 /tmp/sudoers_vagrant
mv /tmp/sudoers_vagrant /etc/sudoers.d/vagrant

# Speed up ssh logins
echo "UseDNS no" >> /etc/ssh/sshd_config
