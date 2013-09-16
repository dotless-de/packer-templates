# CentOS 6 x86_64

Installes the current CentOS 6 64bit plus:

* ruby-install and chruby
* ruby 1.9.3-p429 and bundler for "vagrant" (in user-space)
* chef-solo 11.6.x (via omnibus)
* VMwareTools (if build as such, uses local iso file which must be present)
* VirtualBoxGuestAddition (if build as such, uses local iso file which must be present)

Note on Ruby installations:

Omnibus-Chef brings it's own, bundled ruby. Depending on how provisioning with is kicked off, a global default ruby will break Chef. Thats why vagrant does not have a default ruby. Consider putting a `.ruby-version` file into your project and let `chruby_auto` pick a ruby when `cd`ing into your project folder.
