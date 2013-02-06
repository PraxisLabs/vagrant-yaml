require 'optparse'
require 'vagrant/util/template_renderer'
require 'vagrant/command/base'

module VagrantYaml
  module Command

    class YamlInit < Vagrant::Command::Base
      def execute
        options = {}

        opts = OptionParser.new do |opts|
          opts.banner = "Usage: vagrant yaml init [box-name] [box-url]"
        end

        # Parse the options
        argv = parse_options(opts)
        return if !argv

        # Create our Vagrantfile
        save_path = @env.cwd.join("Vagrantfile")
        raise Errors::VagrantfileExistsError if save_path.exist?

        template_path = ::VagrantYaml.source_root.join("templates/Vagrantfile")
        contents = Vagrant::Util::TemplateRenderer.render(template_path,
                                                          :box_name => argv[0] || "base",
                                                          :box_url => argv[1])
        save_path.open("w+") do |f|
          f.write(contents)
        end

        # Create our directories
        Dir.mkdir('vms-available')
        Dir.mkdir('vms-enabled')

        # Create default.yml
        save_path = @env.cwd.join("vms-available/default.yml")
        raise Errors::VagrantfileExistsError if save_path.exist?

        template_path = ::VagrantYaml.source_root.join("templates/default.yml")
        contents = Vagrant::Util::TemplateRenderer.render(template_path,
                                                          :box_name => argv[0] || "base",
                                                          :box_url => argv[1])
        save_path.open("w+") do |f|
          f.write(contents)
        end

        # Create symlink
        File.symlink("../vms-available/default.yml", "vms-enabled/default.yml")

        @env.ui.info(I18n.t("vagrant.plugins.yaml.commands.init.success"),
                     :prefix => false)

        # Success, exit status 0
        0
       end
    end
  end
end

