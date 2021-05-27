# Test MongoDB systemd service
describe service('mongod') do
  it { should be_enabled }
  it { should be_running }
end

# Test MongoDB listener on host and port
describe port('127.0.0.1', 27017) do
  it { should be_listening }
end

# Test Errbit listener on host and port
describe port('0.0.0.0', 9293) do
  it { should be_listening }
end

# Test Errbit systemd service
describe service('errbit') do
  it { should be_enabled }
  it { should be_running }
end
