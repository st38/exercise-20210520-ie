# Add MongoDB repository
case node['platform']
when 'ubuntu'
    repo_uri          = 'https://repo.mongodb.org/apt/ubuntu'
    repo_arch         = 'amd64,arm64'
    repo_components   = 'multiverse'
    repo_distribution = 'focal/mongodb-org/4.4'
when 'debian'
    repo_uri  =       'http://repo.mongodb.org/apt/debian'
    repo_arch =       'amd64'
    repo_components = 'main'
    repo_distribution = 'buster/mongodb-org/4.4'
end

apt_repository 'mongodb-org-4.4' do
    uri          repo_uri
    if node['platform'] == 'ubuntu'
        arch     repo_arch
    end
    distribution repo_distribution
    components   [repo_components]
    key          'https://www.mongodb.org/static/pgp/server-4.4.asc'
    notifies     :update, 'apt_update[apt-update]', :immediately
end

# Update Apt repository
apt_update 'apt-update' do
    action :nothing
end

# Install MongoDB
package 'mongodb-org'

# Start MongoDB service
service 'mongod' do
    action [:enable, :start]
end
