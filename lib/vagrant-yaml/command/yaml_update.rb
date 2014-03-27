require 'optparse'
require 'vagrant/util/template_renderer'

module VagrantPlugins
  module VagrantYaml
    module Command
      class YamlUpdate < Vagrant.plugin("2", :command)
        def self.synopsis
          "Updates a YAML-based Vagrant environment."
        end

        def execute
          options = {}

          # Boolean whether we should actually go through with the update
          # or not. This is true only if the "--force" flag is set or if the
          # user confirms it.
          do_update = false

          opts = OptionParser.new do |opts|
            opts.banner = "Usage: vagrant yaml update"

            opts.on("-f", "--force", "Update without confirmation.") do |f|
              options[:force] = f
            end
          end

          # Parse the options
          argv = parse_options(opts)
          return if !argv

          if options[:force]
            do_update = true
          else
            choice = nil
            begin
              choice = @env.ui.ask(I18n.t("vagrant.plugins.yaml.commands.update.confirmation"))

            rescue Errors::UIExpectsTTY
              # We raise a more specific error but one which basically
              # means the same thing.
              raise Errors::UpdateRequiresForce
            end
            do_update = choice.upcase == "Y"
          end

          if do_update
            @logger.info("Updating project with latest Vagrantfile from vagrant-yaml.")
            update
          else
            @logger.info("Not updating project since confirmation was declined.")
            @env.ui.success(I18n.t("vagrant.plugins.yaml.commands.update.will_not_update"),
                              :prefix => false)
          end
        end

        def update
          save_path = @env.cwd.join("Vagrantfile")

          template_path = ::VagrantYaml.source_root.join("templates/Vagrantfile")
          contents = Vagrant::Util::TemplateRenderer.render(template_path)

          # Write out the contents
          save_path.open("w+") do |f|
            f.write(contents)
          end

          @env.ui.info(I18n.t("vagrant.plugins.yaml.commands.update.success"),
                       :prefix => false)

          # Success, exit status 0
          0
        end
      end
    end
  end
end
