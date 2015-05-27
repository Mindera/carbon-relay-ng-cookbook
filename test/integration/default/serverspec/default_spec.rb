require 'serverspec'

# Required by serverspec
set :backend, :exec

RSpec.configure do |c|
  c.before :all do
    c.path = '/sbin:/usr/sbin:$PATH'
  end
end

describe file('/etc/carbon-relay-ng/carbon-relay-ng.ini') do
  it { should be_file }
  it { should contain 'init = ["addBlack prefix collectd.localhost"]' }
end

describe file('/opt/go/bin/carbon-relay-ng') do
  it { should be_file }
end

describe file('/etc/supervisor.d/carbon-relay-ng.conf') do
  it { should be_file }
  it { should contain 'command=/opt/go/bin/carbon-relay-ng /etc/carbon-relay-ng/carbon-relay-ng.ini' }
end

describe command('/usr/bin/supervisorctl status carbon-relay-ng') do
  its(:stdout) { should contain 'RUNNING' }
end
