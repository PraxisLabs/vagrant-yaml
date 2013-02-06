class InitYaml

  class YamlError < Vagrant::Errors::VagrantError
    def error_namespace; "vagrant.plugins.yaml.errors"; end
  end

  class VagrantfileExistsError < InitYaml::YamlError
    error_key :vagrantfile_exists
  end

end
