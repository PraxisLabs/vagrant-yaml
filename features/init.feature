Feature: Init command

  In order to start using a YAML-based Vagrant project
  As a user using vagrant-yaml
  I want to initialize a new project

  Scenario: Running 'vagrant yaml init'
    Given a directory named "test"
    And I cd to "test"
    When I successfully run `vagrant yaml init`
    Then the following files should exist:
      | Vagrantfile |
      | vms-available/default.yaml |
      | vms-enabled/default.yaml |
      | local.d/default.yaml |
    And the following directories should exist:
      | local.d |
      | vms-available |
      | vms-enabled |
    And the output should contain "A `Vagrantfile` has been placed in this directory, a default Yaml VM config file"
    And the output should contain "has been placed in vms-available/, and a symlink to it, placed in vms-enabled/."
    And the output should contain "Finally, a file to contain local overrides was placed in local.d/. Unlike a"
    And the output should contain "regular Vagrantfile, this one parses and applies the configuration in the Yaml"
    And the output should contain "files it finds in vms-enabled/. You are now ready to `vagrant up` your first"
    And the output should contain "virtual environment! Please read the comments in the default Yaml VM config"
    And the output should contain "file to see how it works."

