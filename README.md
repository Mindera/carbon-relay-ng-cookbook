# Carbon-Relay-NG Cookbook

[![Cookbook](https://img.shields.io/cookbook/v/carbon-relay-ng.svg)](https://supermarket.chef.io/cookbooks/carbon-relay-ng)
[![Build Status](https://travis-ci.org/Mindera/carbon-relay-ng-cookbook.svg?branch=master)](https://travis-ci.org/Mindera/carbon-relay-ng-cookbook)

Chef coookbook to install and manage [carbon-relay-ng](https://github.com/graphite-ng/carbon-relay-ng).

## Requirements

Depends on the cookbooks:

 * [golang](https://github.com/NOX73/chef-golang)
 * [supervisor](https://github.com/poise/supervisor)

## Platforms

 * Centos 6+
 * Amazon Linux

## Usage

This is an attribute driven cookbook which means that the desired behaviour can be achieved by overriding attributes and including it as a recipe.

## Attributes

### default.rb

<table>
    <tr>
        <th>Attribute</th>
        <th>Type</th>
        <th>Description</th>
        <th>Options</th>
        <th>Default</th>
    </tr>
    <tr>
        <td><tt>['carbon-relay-ng']['instance']</tt></td>
        <td>String</td>
        <td>carbon-relay-ng instance name</td>
        <td>-</td>
        <td><tt>'default'</tt></td>
    </tr>
    <tr>
        <td><tt>['carbon-relay-ng']['listen_addr']</tt></td>
        <td>String</td>
        <td>carbon-relay-ng listen address</td>
        <td>-</td>
        <td><tt>'0.0.0.0:2003'</tt></td>
    </tr>
    <tr>
        <td><tt>['carbon-relay-ng']['admin']['enabled']</tt></td>
        <td>TrueClass/FalseClass</td>
        <td>carbon-relay-ng admin interface enabled</td>
        <td>`true`, `false`</td>
        <td><tt>`true`</tt></td>
    </tr>
    <tr>
        <td><tt>['carbon-relay-ng']['admin_addr']</tt></td>
        <td>String</td>
        <td>carbon-relay-ng admin address</td>
        <td>-</td>
        <td><tt>'0.0.0.0:2004'</tt></td>
    </tr>
    <tr>
        <td><tt>['carbon-relay-ng']['http_addr']['enabled']</tt></td>
        <td>TrueClass/FalseClass</td>
        <td>carbon-relay-ng http interface enabled</td>
        <td>`true`, `false`</td>
        <td><tt>`true`</tt></td>
    </tr>
    <tr>
        <td><tt>['carbon-relay-ng']['http_addr']</tt></td>
        <td>String</td>
        <td>carbon-relay-ng http address</td>
        <td>-</td>
        <td><tt>'0.0.0.0:8081'</tt></td>
    </tr>
    <tr>
        <td><tt>['carbon-relay-ng']['bad_metrics_max_age']</tt></td>
        <td>String</td>
        <td>carbon-relay-ng bad metrics age</td>
        <td>Time units 's', 'm', 'h' available</td>
        <td><tt>'24h'</tt></td>
    </tr>
    <tr>
        <td><tt>['carbon-relay-ng']['log_level']</tt></td>
        <td>String</td>
        <td>carbon-relay-ng log level</td>
        <td>'critical', 'error', 'warning', 'notice', 'info', 'debug'</td>
        <td><tt>'warning'</tt></td>
    </tr>
    <tr>
        <td><tt>['carbon-relay-ng']['spool']['enabled']</tt></td>
        <td>TrueClass/FalseClass</td>
        <td>carbon-relay-ng spool enabled</td>
        <td>`true`, `false`</td>
        <td><tt>`true`</tt></td>
    </tr>
    <tr>
        <td><tt>['carbon-relay-ng']['spool']['directory']</tt></td>
        <td>String</td>
        <td>carbon-relay-ng spool directory</td>
        <td>-</td>
        <td><tt>'/var/spool/carbon-relay-ng'</tt></td>
    </tr>
    <tr>
        <td><tt>['carbon-relay-ng']['config_dir']</tt></td>
        <td>String</td>
        <td>carbon-relay-ng configuration directory</td>
        <td>-</td>
        <td><tt>'/etc/carbon-relay-ng'</tt></td>
    </tr>
    <tr>
        <td><tt>['carbon-relay-ng']['log_dir']</tt></td>
        <td>String</td>
        <td>carbon-relay-ng log directory</td>
        <td>-</td>
        <td><tt>'/var/log/carbon'</tt></td>
    </tr>
    <tr>
        <td><tt>['carbon-relay-ng']['init']</tt></td>
        <td>Array</td>
        <td>carbon-relay-ng init rules</td>
        <td>-</td>
        <td><tt>`['addBlack prefix collectd.localhost']`</tt></td>
    </tr>
    <tr>
        <td><tt>['carbon-relay-ng']['instrumentation']['graphite']['enabled']</tt></td>
        <td>TrueClass/FalseClass</td>
        <td>graphite reporting enabled</td>
        <td>`true`, `false`</td>
        <td><tt>`false`</tt></td>
    </tr>
    <tr>
        <td><tt>['carbon-relay-ng']['instrumentation']['graphite_addr']</tt></td>
        <td>String</td>
        <td>graphite address</td>
        <td>-</td>
        <td><tt>`nil`</tt></td>
    </tr>
    <tr>
        <td><tt>['carbon-relay-ng']['instrumentation']['graphite_interval']</tt></td>
        <td>Integer</td>
        <td>graphite reporting interval in ms</td>
        <td>-</td>
        <td><tt>`1000`</tt></td>
    </tr>
</table>

### supervisor.rb

<table>
   <tr>
       <th>Attribute</th>
       <th>Type</th>
       <th>Description</th>
       <th>Options</th>
       <th>Default</th>
   </tr>
   <tr>
       <td><tt>['carbon-relay-ng']['supervisor']['process_name']</tt></td>
       <td>String</td>
       <td>-</td>
       <td>-</td>
       <td><tt>'carbon-relay-ng'</tt></td>
   </tr>
   <tr>
       <td><tt>['carbon-relay-ng']['supervisor']['stdout_logfile']</tt></td>
       <td>String</td>
       <td>-</td>
       <td>-</td>
       <td><tt>`#{node['carbon-relay-ng']['log_dir']}/carbon-relay-ng.log`</tt></td>
   </tr>
   <tr>
       <td><tt>['carbon-relay-ng']['supervisor']['stderr_logfile']</tt></td>
       <td>String</td>
       <td>-</td>
       <td>-</td>
       <td><tt>`#{node['carbon-relay-ng']['log_dir']}/carbon-relay-ng.error.log`</tt></td>
   </tr>
</table>

See the supervisor [documentation](http://supervisord.org/configuration.html#program-x-section-values) for each attribute description.

### Up the chain

The `golang` and `supervisor` cookbooks are also attribute driven - override them for the desired behaviour when installing.

See [nodejs](https://github.com/redguide/nodejs/) and [supervisor](https://github.com/poise/supervisor) for details.

## Recipes

### default.rb

Installs carbon-relay-ng and sets it up as a service using `supervisord`.

### Example

To install carbon-relay-ng:

Add the `carbon-relay-ng` cookbook as a dependency:

```ruby
depends 'carbon-relay-ng'
```

Include the `carbon-relay-ng::default` recipe:

```ruby
include_recipe 'carbon-relay-ng::default'
```

Overwrite the configuration attributes as you desire.

## References

 * carbon-relay-ng [documentation](https://github.com/graphite-ng/carbon-relay-ng)

## Development / Contributing

### Dependencies

 * [Ruby](https://www.ruby-lang.org)
 * [Bundler](http://bundler.io)

### Installation

```bash
$ git clone git@github.com:Mindera/carbon-relay-ng-cookbook.git
$ cd carbon-relay-ng-cookbook
$ bundle install
```

### Tests

To run unit tests (chefspec):
```bash
$ bundle exec rake unit
```

To run lint tests (rubocop, foodcritic):
```bash
$ bundle exec rake lint
```

To run integration tests (kitchen-ci, serverspec):
```bash
$ bundle exec rake integration
```
