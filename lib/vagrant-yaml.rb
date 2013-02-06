require 'vagrant'
#require 'vagrant-yaml/errors'
require 'vagrant-yaml/command'

Vagrant.commands.register(:yaml) { InitYaml }

# Add our custom translations to the load path
I18n.load_path << File.expand_path("../../locales/en.yml", __FILE__)
