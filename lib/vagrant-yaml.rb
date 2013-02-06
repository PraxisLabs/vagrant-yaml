require 'vagrant'
require 'vagrant-yaml/errors'
require 'vagrant-yaml/commands/yaml'
require 'vagrant-yaml/commands/yaml_init'
require 'vagrant-yaml/commands/yaml_update'

Vagrant.commands.register(:yaml) { VagrantYaml::Command::Yaml }

module VagrantYaml
  # The source root is the path to the root directory of the this gem.
  def self.source_root
    @source_root ||= Pathname.new(File.expand_path('../../', __FILE__))
  end
end

# Add our custom translations to the load path
I18n.load_path << File.expand_path("../../locales/en.yml", __FILE__)
