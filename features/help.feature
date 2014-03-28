Feature: Command help text

  In order to learn about commands and usage
  As a user using vagrant-yaml
  I want to see help text for commands and options

  Scenario: Running 'vagrant help'
    When I successfully run `vagrant help`
    Then the output should contain "yaml"
    And the output should contain "Manage YAML-based projects."
    And the output should not contain "yaml-init"
    And the output should not contain "yaml-update"

  Scenario: Running 'vagrant list-commands'
    When I successfully run `vagrant list-commands`
    Then the output should contain "yaml"
    And the output should contain "Manage YAML-based projects."
    And the output should contain "yaml-init"
    And the output should contain "Initializes a new YAML-based Vagrant environment by creating a Vagrantfile, and config directories."
    And the output should contain "yaml-update"
    And the output should contain "Updates a YAML-based Vagrant environment."

  Scenario: Running 'vagrant yaml'
    When I successfully run `vagrant yaml`
    Then the output should contain "Usage: vagrant yaml <command> [<args>]"
    And the output should contain "Available subcommands:"
    And the output should contain "init"
    And the output should contain "update"
    And the output should contain "For help on any individual command run `vagrant yaml COMMAND -h`"

  Scenario: Running 'vagrant yaml init -h'
    When I successfully run `vagrant yaml init -h`
    Then the output should contain "Usage: vagrant yaml init [box-name] [box-url]"
    And the output should contain "-h, --help"
    And the output should contain "Print this help"

  Scenario: Running 'vagrant yaml update -h'
    When I successfully run `vagrant yaml update -h`
    Then the output should contain "Usage: vagrant yaml update"
    And the output should contain "-f, --force"
    And the output should contain "Update without confirmation."
    And the output should contain "-h, --help"
    And the output should contain "Print this help"
