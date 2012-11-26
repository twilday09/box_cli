Feature: settings command

  In order to use box from the command line
  As a CLI user
  I want to be able to show settings

  Scenario: show all settings
    When I run `box settings --user john --password 123456 --api_key abc`
    Then the output should match:
      """
        api_key: abc
        password: 123456
        user: john
      """

  Scenario: show all settings and arguments
    When I run `box settings --user john --password 123456 --api_key abc arg2 arg1`
    Then the output should match:
      """
        api_key: abc
        password: 123456
        user: john
      .*
        arg2
        arg1
      """

  Scenario: show settings when defined by environment variables
    When I unset all env variables matching /BOX_CLI_/
    And I set env variable "BOX_CLI_USER" to "john"
    And I run `box settings --password 123456 --api_key abc`
    Then the output should match:
      """
        api_key: abc
        password: 123456
        user: john
      """

  Scenario: Have explicit setting override environment variable
    When I unset all env variables matching /BOX_CLI_/
    And I set env variable "BOX_CLI_USER" to "john"
    And I run `box settings --password 123456 --api_key abc --user booboo`
    Then the output should match:
      """
        api_key: abc
        password: 123456
        user: booboo
      """