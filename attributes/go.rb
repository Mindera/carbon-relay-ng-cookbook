#
# Cookbook Name:: carbon-relay-ng-cookbook
# Recipe:: go
#
# Copyright 2015, Mindera
#

default_unless['go']['bin'] = '/opt/go/bin'
default_unless['go']['gopath'] = '/opt/go'
default_unless['go']['owner'] = 'root'
default_unless['go']['group'] = 'root'
