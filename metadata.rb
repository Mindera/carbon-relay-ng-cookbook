name             'carbon-relay-ng'
maintainer       'Mindera'
maintainer_email 'miguel.fonseca@mindera.com'
license          'MIT'
description      'Installs/Configures carbon-relay-ng'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

supports 'centos', '~> 6.0'
supports 'redhat', '~> 6.0'
supports 'amazon'

depends 'supervisor', '~> 0.4'
depends 'golang',     '~> 1.5'
