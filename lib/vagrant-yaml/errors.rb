module VagrantYaml
  module Errors

    class YamlError < Vagrant::Errors::VagrantError
      def error_namespace; "vagrant.plugins.yaml.errors"; end
    end

    class VagrantfileExistsError < YamlError
      error_key :vagrantfile_exists
    end

    class EnabledDirMissing < YamlError
      error_key :enabled_dir_missing
    end

  end
end
