# CentOS 6 x86_64

Installes the current CentOS 6 64bit plus:

* ruby-install and chruby
* ruby 1.9.3-p429 as "system-ruby" in "/usr" so it is available for root (chef and co.)
* chef-solo 11.6.x (via rubygems)
* VMwareTools (if build as such, uses local iso file which must be present)
* VirtualBoxGuestAddition (if build as such, uses local iso file which must be present)
