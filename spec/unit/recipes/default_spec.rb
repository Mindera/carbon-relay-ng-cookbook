require 'spec_helper'

describe 'carbon-relay-ng::default' do
  cached(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }
  cached(:node) { chef_run.node }

  it 'include the supervisor recipe' do
    expect(chef_run).to include_recipe('supervisor')
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
