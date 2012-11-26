Feature: info command

  In order to use box from the command line
  As a CLI user
  I want to be able to see info for what's at a path

  @requires_authorization
  Scenario: get info about root
    When I've set the box cli env variables
    And I run `box info`
    Then the output should match /^Type: folder\s+Data:\s+Id: 0$/
    And the exit status should be 0
    
  @requires_authorization
  Scenario: get info about a folder
    When I've set the box cli env variables
    And I create a temporary folder at box
    And I run `box info` on the temporary path
    Then the output should match /^Type: folder\s+Data:/
    And the exit status should be 0