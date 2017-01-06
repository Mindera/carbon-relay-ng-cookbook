#
# Cookbook Name:: carbon-relay-ng-cookbook
# Recipe:: default
#
# Copyright 2015, Mindera
#

include_recipe 'supervisor'

packagecloud_repo 'raintank/raintank' do
  type 'deb'
end

package 'carbon-relay-ng'

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
  notifies :restart, 'supervisor_service[carbon-relay-ng]', :delayed
end

SUP_PROC_NAME = node['carbon-relay-ng']['supervisor']['process_name']
SUP_STDOUT_LOG = node['carbon-relay-ng']['supervisor']['stdout_logfile']
SUP_STDERR_LOG = node['carbon-relay-ng']['supervisor']['stderr_logfile']

# TODO: add extra supervisor service configs
supervisor_service 'carbon-relay-ng' do
  command "carbon-relay-ng #{CARBON_CONF_DIR}/carbon-relay-ng.ini"
  process_name SUP_PROC_NAME
  stdout_logfile "#{CARBON_LOG_DIR}/#{SUP_STDOUT_LOG}"
  stderr_logfile "#{CARBON_LOG_DIR}/#{SUP_STDERR_LOG}"
end
