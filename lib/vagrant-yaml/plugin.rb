module VagrantPlugins
  module VagrantYaml
    class Plugin < Vagrant.plugin("2")
      name "Yagrant YAML"
      description <<-DESC
      This plugin enables Vagrant to use YAML files to configure VMs.
      DESC

      command("yaml") do
        require_relative "command/yaml"
        Command::Yaml
      end

      command("yaml-init", primary: false) do
        require_relative "command/yaml_init"
        Command::YamlInit
      end

      command("yaml-update", primary: false) do
        require_relative "command/yaml_update"
        Command::YamlUpdate
      end
    end
  end
end

