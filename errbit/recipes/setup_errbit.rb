# Create Errbit user
user node['errbit']['user']['name'] do
    home node['errbit']['root']['dir']
    shell '/bin/false'
end

# Install RVM
bash 'install-rvm' do
    code <<-EOH
      curl -sSL https://rvm.io/mpapis.asc | sudo gpg --import -
      curl -sSL https://rvm.io/pkuczynski.asc | sudo gpg --import -
      curl -sSL https://get.rvm.io | sudo bash -s stable
      usermod $(whoami) -a -G rvm
      grep rvm.sh $HOME/.bashrc || echo "source /etc/profile.d/rvm.sh" >> $HOME/.bashrc
    EOH
    not_if { ::File.exists?('/usr/local/rvm/bin/rvm') }
end

# Install Ruby
bash 'install-ruby' do
    code <<-EOH
    source /etc/profile.d/rvm.sh
    rvm install 2.6
    EOH
end

# Create directory for Errbit
directory node['errbit']['root']['dir'] do
    owner node['errbit']['user']['name']
    group node['errbit']['group']['name']
    mode 0755
    action :create
end

# Get Errbit sources from GitHub
git node['errbit']['root']['dir'] do
    repository 'https://github.com/errbit/errbit.git'
    user node['errbit']['user']['name']
    group node['errbit']['group']['name']
end

# Create Errbit config file
template "#{node['errbit']['root']['dir']}/.env.#{node['errbit']['config']['environment']}" do
    source 'errbit-config.erb'
    owner node['errbit']['user']['name']
    group node['errbit']['group']['name']
end

# Install Errbit
bash 'errbit-install' do
    cwd node['errbit']['root']['dir']
    code <<-EOH
      source /etc/profile.d/rvm.sh
      gem install bundler libv8 puma
      bundle update libv8
      bundle install
    EOH
end

# Bootstrap Errbit
bash 'errbit-bootstrap' do
    cwd node['errbit']['root']['dir']
    user node['errbit']['user']['name']
    code <<-EOH
      source /etc/profile.d/rvm.sh
      bundle exec rake errbit:bootstrap > "#{node['errbit']['root']['dir']}/bootstrap.log"
    EOH
    not_if { ::File.exists?("#{node['errbit']['root']['dir']}/bootstrap.log") }
end

# Create Errbit systemd service
template '/etc/systemd/system/errbit.service' do
    source 'errbit-systemd.erb'
    notifies :run, 'execute[systemctl daemon-reload]', :immediately
    notifies :restart, 'service[errbit-restart]', :delayed
    variables(
        bundle_path: lazy { shell_out("/bin/bash -c 'source /etc/profile.d/rvm.sh; which bundle'").stdout.chomp.gsub(/bin/, 'wrappers') }
    )
end

# Start Errbit service
service 'errbit' do
    action [:enable, :start]
end

# Reload Errbit service
service 'errbit-restart' do
    service_name 'errbit'
    action :nothing
end

# Reload systemd configuration
execute 'systemctl daemon-reload' do
    command 'systemctl daemon-reload'
    action :nothing
end
