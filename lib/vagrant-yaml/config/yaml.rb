module VagrantPlugins
  module VagrantYaml
    module Config
      class Yaml < Vagrant.plugin("2", :config)
        attr_accessor :conf_dirs

        def initialize
          @conf_dirs = UNSET_VALUE
        end

        def finalize!
          if @conf_dirs == UNSET_VALUE
            @conf_dirs = { "local" => "local.d", "enabled" => "vms-enabled" }
          end
        end

        def validate(machine)
          errors = _detected_errors
          @conf_dirs.each() do |name, conf_dir|
            current_dir = Dir.pwd + '/' + conf_dir
            if !File.directory?(current_dir)
              errors << "Configuration directories must exist: #{current_dir}"
            end
          end

          { "yaml" => errors }
        end

      end
    end
  end
end
