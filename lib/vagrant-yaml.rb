require 'vagrant'
#require 'vagrant-yaml/errors'
require 'vagrant-yaml/init-yaml'

Vagrant.commands.register(:yaml) { VagrantYaml::Command }

# Add our custom translations to the load path
I18n.load_path << File.expand_path("../../locales/en.yml", __FILE__)
