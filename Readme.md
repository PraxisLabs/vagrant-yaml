Vagrant-Yaml
============

[![Build Status](https://travis-ci.org/PraxisLabs/vagrant-yaml.svg?branch=master)](https://travis-ci.org/PraxisLabs/vagrant-yaml) [![Gem Version](https://badge.fury.io/rb/vagrant-yaml.png)](http://badge.fury.io/rb/vagrant-yaml) [![Coverage Status](https://coveralls.io/repos/PraxisLabs/vagrant-yaml/badge.png)](https://coveralls.io/r/PraxisLabs/vagrant-yaml)

Installation
------------

To install this gem, use the Vagrant 'gem' command:

```
vagrant plugin install vagrant-yaml
```

This will keep it isolated from system-wide and other gems.


Usage
-----

To initialize a new project:

```
vagrant yaml init [box-name] [box-url]
```

To update an existing project with the latest Vagrantfile that Vagrant-Yaml
provides:

```
vagrant yaml update
```


Vagrantfile
-----------

Vagrant-Yaml provides a custom Vagrantfile. This Vagrantfile parses the Yaml
config files in the 'vms-enabled' directory, and applies any settings found
there. The Vagrant name for the VM is the name of the file (without the '.yaml'
extension, obviously). Multi-VM environments are supported by adding additional
Yaml config files.

As with a standard Vagrantfile, the one this gem provides can be altered to
suit the needs of your project. However, be aware that running the 'vagrant
yaml update' command will overwrite any changes you make. Of course, this
should not be a problem, since you are keeping your project directory under
some form of version control, right?


Config files
------------

All Vagrant VM configuration can be done from Yaml config files. Only config
files in the 'vms-enabled' directory are interpreted. You can copy from, or
symlink to, files in the 'vms-available' directory. This allows you to have a
library of config files that could, for example, be updated by an external
application.


Yaml
----

To see what you can do with Yaml, check out this handy reference card:
http://www.yaml.org/refcard.html. To see how Yaml is interpreted in Ruby, see
this guide: http://yaml.org/YAML_for_ruby.html. For further details, refer to
the full Yaml specification: http://www.yaml.org/spec/1.2/spec.html


Vagrant Options
---------------

For all available Vagrant options, see the docs on Vagrantfile settings:
http://vagrantup.com/v1/docs/vagrantfile.html. While we have provided some
example below, it is far from exhaustive. If you cannot figure out how to apply
a particular setting, please file a support request at:
https://github.com/ergonlogic/vagrant-yaml.


Free Software
-------------

This gem is published under the GNU GPLv3 (General Public License, Version 3),
and as such is, and will always remain, free software. Engagement in the
development process by users and other developers is strongly encouraged. So,
please feel free to post to the project wiki, and submit feature and pull
requests.


CREDITS
-------

Developed and maintained by Praxis Labs Coop <http://praxis.coop/>

Sponsored by Poetic Systems <http://poeticsystems.com/>
