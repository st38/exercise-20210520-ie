# Errbit
default['errbit']['root']['dir'] = '/opt/errbit'
default['errbit']['user']['name'] = 'errbit'
default['errbit']['group']['name'] = default['errbit']['user']['name']

default['errbit']['listen']['host'] = '0.0.0.0'
default['errbit']['listen']['port'] = 9293

# Environment
default['errbit']['config']['environment'] = 'development'
default['errbit']['environment'] = {
    'RAILS_ENV'      => default['errbit']['config']['environment'],
    'ERRBIT_HOST'    => 'errbit.domain.tld',
    'ERRBIT_PORT'    => default['errbit']['listen']['port']
}
