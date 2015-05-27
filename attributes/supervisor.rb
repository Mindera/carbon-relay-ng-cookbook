#
# Cookbook Name:: carbon-relay-ng
# Attributes:: supervisor
#
# Copyright 2015, Mindera
#

default_unless['carbon-relay-ng']['supervisor']['process_name'] = 'carbon-relay-ng'
default_unless['carbon-relay-ng']['supervisor']['stdout_logfile'] = 'carbon-relay-ng.log'
default_unless['carbon-relay-ng']['supervisor']['stderr_logfile'] = 'carbon-relay-ng.error.log'
