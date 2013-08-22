#!/usr/bin/env bash
#
# chruby script that installs ruby-install which then installs the lastest
# stable versions of Ruby, JRuby and Rubinius into /opt/rubies or ~/.rubies.
#
# !!!
#     this is an altered version of
#     https://raw.github.com/postmodern/chruby/master/scripts/setup.sh
#     which does NOT install all ruby flavors, but MRI only
#     also it is simplified to install in global space

set -e

#
# Constants
#
export PREFIX="${PREFIX:-/usr/local}"

SRC_DIR="${SRC_DIR:-/usr/local/src}"

#
# Functions
#
function log() {
	if [[ -t 1 ]]; then
		printf "%b>>>%b %b%s%b\n" "\x1b[1m\x1b[32m" "\x1b[0m" \
		                          "\x1b[1m\x1b[37m" "$1" "\x1b[0m"
	else
		printf ">>> %s\n" "$1"
	fi
}

function error() {
	if [[ -t 1 ]]; then
		printf "%b!!!%b %b%s%b\n" "\x1b[1m\x1b[31m" "\x1b[0m" \
		                          "\x1b[1m\x1b[37m" "$1" "\x1b[0m" >&2
	else
		printf "!!! %s\n" "$1" >&2
	fi
}

function warning() {
	if [[ -t 1 ]]; then
		printf "%b***%b %b%s%b\n" "\x1b[1m\x1b[33m" "\x1b[0m" \
			                  "\x1b[1m\x1b[37m" "$1" "\x1b[0m" >&2
	else
		printf "*** %s\n" "$1" >&2
	fi
}

#
# Pre Install
#
install -d "$SRC_DIR"
cd "$SRC_DIR"


#
# Install chruby
#
chruby_version="0.3.7"

log "Downloading chruby ..."
wget -O "chruby-$chruby_version.tar.gz" https://github.com/postmodern/chruby/archive/v$chruby_version.tar.gz

log "Extracting chruby $chruby_version ..."
tar -xzvf "chruby-$chruby_version.tar.gz"
cd "chruby-$chruby_version/"

log "Installing chruby ..."
make install

#
# Pre Install
#
install -d "$SRC_DIR"
cd "$SRC_DIR"

#
# Install ruby-install (https://github.com/postmodern/ruby-install#readme)
#
ruby_install_version="0.3.0"

log "Downloading ruby-install ..."
wget -O "ruby-install-$ruby_install_version.tar.gz" "https://github.com/postmodern/ruby-install/archive/v$ruby_install_version.tar.gz"

log "Extracting ruby-install $ruby_install_version ..."
tar -xzvf "ruby-install-$ruby_install_version.tar.gz"
cd "ruby-install-$ruby_install_version/"

log "Installing ruby-install ..."
make install || (error "installing ruby-install failed"; exit 0)

log "Installing MRI ruby 1.9.3 in global space..."
$PREFIX/bin/ruby-install -i /usr ruby 1.9.3-p429

#
# Configuration
#
log "Configuring chruby ..."

config="[ -n \"\$BASH_VERSION\" ] || [ -n \"\$ZSH_VERSION\" ] || return

source $PREFIX/share/chruby/chruby.sh"

if [[ -d /etc/profile.d/ ]]; then
	# Bash/Zsh
	echo "$config" > /etc/profile.d/chruby.sh
	echo "source $PREFIX/share/chruby/auto.sh" >> /etc/profile.d/chruby.sh
	log "Setup complete! Please restart the shell"
else
	warning "Could not determine where to add chruby configuration."
	warning "Please add the following configuration where appropriate:"
	echo
	echo "$config"
	echo "source $PREFIX/share/chruby/auto.sh"
	echo
fi
