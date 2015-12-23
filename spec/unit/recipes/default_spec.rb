require 'spec_helper'

describe 'carbon-relay-ng::default' do
  cached(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }
  cached(:node) { chef_run.node }

  before do
    stub_command("/usr/local/go/bin/go version | grep \"go1.5 \"").and_return(true)
    stub_command("/usr/local/go/bin/go version | grep \"go1.4 \"").and_return(true)
  end

  it 'include the supervisor recipe' do
    expect(chef_run).to include_recipe('supervisor')
  end

  it 'include the golang::packages recipe' do
    expect(chef_run).to include_recipe('golang')
  end

  it 'install the go-bindata binary' do
    expect(chef_run).to run_execute('go get -u github.com/jteeuwen/go-bindata/...')
  end

  it 'gets the carbon-relay-ng source' do
    expect(chef_run).to run_execute('go get -u -d github.com/graphite-ng/carbon-relay-ng/...')
  end

  it 'install the carbon-relay-ng binary' do
    expect(chef_run).to run_execute('make install')
  end

  it 'creates the spool directory' do
    expect(chef_run).to create_directory('/var/spool/carbon-relay-ng')
  end

  it 'creates the log directory' do
    expect(chef_run).to create_directory('/var/log/carbon-relay-ng')
  end

  it 'creates the config directory' do
    expect(chef_run).to create_directory('/etc/carbon-relay-ng')
  end

  it 'deployed the carbon-relay-ng ini configuration file' do
    expect(chef_run).to create_template('/etc/carbon-relay-ng/carbon-relay-ng.ini')
  end

  it 'enables the supervisor carbon-relay-ng service' do
    expect(chef_run).to enable_supervisor_service('carbon-relay-ng')
  end
end
