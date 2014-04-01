require 'optparse'
require 'vagrant/util/template_renderer'

module VagrantPlugins
  module VagrantYaml
    module Command
      class YamlInit < Vagrant.plugin("2", :command)

        def self.synopsis
          "Initializes a new YAML-based Vagrant environment by creating a Vagrantfile, and config directories."
        end
        def execute
          options = {}

          opts = OptionParser.new do |opts|
            opts.banner = "Usage: vagrant yaml init [box-name] [box-url]"
          end

          # Parse the options
          argv = parse_options(opts)
          return if !argv

          create_vagrantfile
          create_directories
          create_default_yaml(argv[0], argv[1])
          create_vm_yaml('vm1')
          create_vm_yaml('vm2')

          @env.ui.info(I18n.t(
            "vagrant.plugins.yaml.commands.init.success",
              avail_dir: 'available.d',
              enabled_dir: 'enabled.d',
              local_dir: 'local.d'
            ), :prefix => false)
          # Success, exit status 0
          0
        end

        def create_vagrantfile
          save_path = @env.cwd.join("Vagrantfile")
          raise Errors::VagrantfileExistsError if save_path.exist?

          template_path = ::VagrantYaml.source_root.join("templates/Vagrantfile")
          contents = Vagrant::Util::TemplateRenderer.render(template_path)
          save_path.open("w+") do |f|
            f.write(contents)
          end
        end

        def create_directories
          Dir.mkdir('available.d')
          Dir.mkdir('enabled.d')
          Dir.mkdir('local.d')
        end

        def create_default_yaml(box_name=nil, box_url=nil)
          save_path = @env.cwd.join("available.d/default.yaml")
          raise Errors::VagrantfileExistsError if save_path.exist?

          template_path = ::VagrantYaml.source_root.join("templates/default.yaml")
          contents = Vagrant::Util::TemplateRenderer.render(template_path,
                                                            :box_name => box_name,
                                                            :box_url => box_url)
          save_path.open("w+") do |f|
            f.write(contents)
          end
        end

        def create_vm_yaml(vm_name)
          File.symlink("../available.d/default.yaml", "enabled.d/" + vm_name + ".yaml")
          save_path = @env.cwd.join("local.d/" + vm_name + ".yaml")
          raise Errors::VagrantfileExistsError if save_path.exist?
          template_path = ::VagrantYaml.source_root.join("templates/local.yaml")
          contents = Vagrant::Util::TemplateRenderer.render(template_path,
                                                            :host_name => vm_name + ".example.com")
          save_path.open("w+") do |f|
            f.write(contents)
          end
        end

      end
    end
  end
end
