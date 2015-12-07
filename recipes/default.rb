#
# Cookbook Name:: carbon-relay-ng-cookbook
# Recipe:: default
#
# Copyright 2015, Mindera
#
if node['carbon-relay-ng']['supervisor']['enable']
  include_recipe 'supervisor'
  svc = 'supervisor_service[carbon-relay-ng]'
elsif node['init_package'].equal?('systemd')
  template '/etc/systemd/system/carbon.service' do
    source 'systemd.erb'
    owner 'root'
    group 'root'
    mode '0755'
  end
  bash 'systemd_carbon_setup' do
    code <<-EOH
      systemctl daemon-reload
      systemctl enable carbon.service
      systemctl start carbon.service
    EOH
  end
end

include_recipe 'golang'

PATH = '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/go/bin:/opt/go/bin'

GO_BIN = node['go']['bin']
GO_PATH = node['go']['gopath']
GO_OWNER = node['go']['owner']
GO_GROUP = node['go']['group']

[
    'go get -u github.com/jteeuwen/go-bindata/...',
    'go get -u -d github.com/graphite-ng/carbon-relay-ng/...'
].each do |cmd|
  execute cmd do
    user GO_OWNER
    group GO_GROUP
    environment(
        'GOPATH' => GO_PATH,
        'GOBIN' => GO_BIN,
        'PATH' => PATH
    )
  end
end

execute 'make install' do
  user GO_OWNER
  group GO_GROUP
  cwd "#{GO_PATH}/src/github.com/graphite-ng/carbon-relay-ng"
  environment(
      'GOPATH' => GO_PATH,
      'GOBIN' => GO_BIN,
      'PATH' => PATH
  )
  not_if { ::File.exist?("#{GO_BIN}/carbon-relay-ng") }
end

SPOOL_ENABLED = node['carbon-relay-ng']['spool']['enabled']
SPOOL_DIR = node['carbon-relay-ng']['spool']['directory']

directory SPOOL_DIR do
  recursive true
  action :create
  only_if { SPOOL_ENABLED }
end

CARBON_LOG_DIR = node['carbon-relay-ng']['log_dir']

directory CARBON_LOG_DIR do
  recursive true
  action :create
end

CARBON_CONF_DIR = node['carbon-relay-ng']['config_dir']

directory CARBON_CONF_DIR do
  recursive true
  action :create
end

template "#{CARBON_CONF_DIR}/carbon-relay-ng.ini" do
  source 'carbon-relay-ng.ini.erb'
  backup false
  notifies :restart, svc, :delayed
end

SUP_PROC_NAME = node['carbon-relay-ng']['supervisor']['process_name']
SUP_STDOUT_LOG = node['carbon-relay-ng']['supervisor']['stdout_logfile']
SUP_STDERR_LOG = node['carbon-relay-ng']['supervisor']['stderr_logfile']

# TODO: add extra supervisor service configs
if node['carbon-relay-ng']['supervisor']['enable']
  supervisor_service 'carbon-relay-ng' do
    command "#{GO_BIN}/carbon-relay-ng #{CARBON_CONF_DIR}/carbon-relay-ng.ini"
    process_name SUP_PROC_NAME
    stdout_logfile "#{CARBON_LOG_DIR}/#{SUP_STDOUT_LOG}"
    stderr_logfile "#{CARBON_LOG_DIR}/#{SUP_STDERR_LOG}"
  end
else
  service 'carbon' do
    action :nothing
  end
end