# Since Vagrant starts under a different process from our tests, we need to
# initialize simplecov here, and make it available for coveralls to retrieve.
if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.command_name "binary #{Process.pid}"
  SimpleCov.root(File.expand_path('../../', __FILE__))
  SimpleCov.start
end


require 'vagrant'
require 'vagrant-yaml/errors'
require 'vagrant-yaml/plugin'

module VagrantYaml
  # The source root is the path to the root directory of the this gem.
  def self.source_root
    @source_root ||= Pathname.new(File.expand_path('../../', __FILE__))
  end

  def self.apply_settings(vm,yml)
    yml.each do |key0,value0|
      if !value0.is_a?(Hash)                           # If it's a setting,
          vm.send("#{key0}=".to_sym, value0)           # we set it directly.
      else                                               # Otherwise,
        method_object = vm.method("#{key0}".to_sym)      # we're invoking a method
        value0.each do |key1,value1|                     # and each setting
          method_object.call("#{key1}".to_sym, value1)   # needs to be passed to the method.
        end
      end
    end
  end

  def self.up!(config)

    require "yaml"

    # All paths are relative to the project root
    # todo: Can we access this from Vagrant::Environment?
    current_dir = Dir.pwd

    # Scan our vms-enabled/ directory for YAML config files
    if File.directory?("#{current_dir}/vms-enabled/")
       Dir.chdir("#{current_dir}/vms-enabled/")
       config_files = Dir.glob("*.yaml")
    end

    # Build up a list of the VMs we'll provision, and their config_files
    vms = {}
    config_files.each do |config_file|
      vms.update({ config_file.sub('.yaml', '') => config_file})
    end

    # VM-specific configuration loaded from YAML config files
    vms.each do |vm,config_file|

      yml = YAML.load_file "#{current_dir}/vms-enabled/#{config_file}"

      # Allow local overrides
      local_file = "#{current_dir}/local.d/#{config_file}"
      if File.exists?(local_file)
        local = YAML.load_file local_file
        if local.is_a?(Hash)
          yml.merge!(local)
        end
      end

      config.vm.define "#{vm}" do |vm_config|
        apply_settings(vm_config.vm, yml)
        # We may need some project-wide config file to handle things like:
        #vm_config.vbguest.auto_update = false
      end

    end

  end
end

# Add our custom translations to the load path
I18n.load_path << File.expand_path("../../locales/en.yml", __FILE__)
