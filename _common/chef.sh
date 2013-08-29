if [ -f /etc/profile.d/chruby.sh ]; then
	echo "sourcing chruby to get default ruby environment"
	source /etc/profile.d/chruby.sh
fi

# Install Chef
gem install --no-ri --no-rdoc chef --version '~> 11.6.0'

