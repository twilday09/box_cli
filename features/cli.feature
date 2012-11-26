Feature: cli basics

  In order to use box from the command line
  As a CLI user
  I want to be able to run box and specify some options

  Scenario: use the box command with no command
    When I run `box`
    Then the exit status should be 1

  Scenario: use the box command with an unrecognized command
    When I run `box foobar`
    Then the exit status should be 1

  Scenario: use the box command with a valid command
    When I run `box --version`
    Then the exit status should be 0

  Scenario: use the box command to get help
    When I run `box help`
    Then the output should contain "CLI for box"