#
# Cookbook Name:: carbon-relay-ng
# Attributes:: default
#
# Copyright 2015, Mindera
#

default_unless['carbon-relay-ng']['instance'] = 'default'
default_unless['carbon-relay-ng']['listen_addr'] = '0.0.0.0:2003'
default_unless['carbon-relay-ng']['admin']['enabled'] = true
default_unless['carbon-relay-ng']['admin_addr'] = '0.0.0.0:2004'
default_unless['carbon-relay-ng']['http']['enabled'] = true
default_unless['carbon-relay-ng']['http_addr'] = '0.0.0.0:8081'
default_unless['carbon-relay-ng']['bad_metrics_max_age'] = '24h'
default_unless['carbon-relay-ng']['log_level'] = 'warning'
default_unless['carbon-relay-ng']['config_dir'] = '/etc/carbon-relay-ng'
default_unless['carbon-relay-ng']['log_dir'] = '/var/log/carbon-relay-ng'

default_unless['carbon-relay-ng']['spool']['enabled'] = true
default_unless['carbon-relay-ng']['spool']['directory'] = '/var/spool/carbon-relay-ng'

default_unless['carbon-relay-ng']['init'] = [
  'addBlack prefix collectd.localhost'
]

default_unless['carbon-relay-ng']['instrumentation']['graphite']['enabled'] = false
default_unless['carbon-relay-ng']['instrumentation']['graphite_addr'] = nil
default_unless['carbon-relay-ng']['instrumentation']['graphite_interval'] = 1000
