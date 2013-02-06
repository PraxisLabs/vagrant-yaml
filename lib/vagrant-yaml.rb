require 'vagrant'
#require 'vagrant-yaml/errors'
require 'vagrant-yaml/commands/yaml'
require 'vagrant-yaml/commands/yaml_init'
require 'vagrant-yaml/commands/yaml_update'

Vagrant.commands.register(:yaml) { VagrantYaml::Command::Yaml }

# Add our custom translations to the load path
I18n.load_path << File.expand_path("../../locales/en.yml", __FILE__)
