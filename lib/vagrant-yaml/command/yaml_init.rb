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
          create_local_default_yaml
          create_symlinks

          @env.ui.info(I18n.t("vagrant.plugins.yaml.commands.init.success"),
                       :prefix => false)
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
          Dir.mkdir('vms-available')
          Dir.mkdir('vms-enabled')
          Dir.mkdir('local.d')
        end

        def create_default_yaml(box_name=nil, box_url=nil)
          save_path = @env.cwd.join("vms-available/default.yaml")
          raise Errors::VagrantfileExistsError if save_path.exist?

          template_path = ::VagrantYaml.source_root.join("templates/default.yaml")
          contents = Vagrant::Util::TemplateRenderer.render(template_path,
                                                            :box_name => box_name,
                                                            :box_url => box_url)
          save_path.open("w+") do |f|
            f.write(contents)
          end
        end

        def create_local_default_yaml
          save_path = @env.cwd.join("local.d/default.yaml")
          raise Errors::VagrantfileExistsError if save_path.exist?
          template_path = ::VagrantYaml.source_root.join("templates/local.default.yaml")
          contents = Vagrant::Util::TemplateRenderer.render(template_path)
          save_path.open("w+") do |f|
            f.write(contents)
          end
        end

        def create_symlinks
          File.symlink("../vms-available/default.yaml", "vms-enabled/default.yaml")
        end

      end
    end
  end
end
