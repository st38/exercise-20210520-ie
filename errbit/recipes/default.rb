# Install required packages
apt_update
package %w(gpg git python2 build-essential)

# Setup MongoDB
include_recipe 'errbit::setup_mongo'

# Setup Errbit
include_recipe 'errbit::setup_errbit'
