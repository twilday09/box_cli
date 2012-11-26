Feature: account_info command

  In order to use box from the command line
  As a CLI user
  I want to be able to see my account info

  @requires_authorization
  Scenario: Get account info
    When I've set the box cli env variables
    And I run `box account_info`
    Then the output should match /Space used:\s+\d+/
    And the exit status should be 0