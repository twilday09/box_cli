Feature: delete command

  In order to use box from the command line
  As a CLI user
  I want to be able to delete files and folders

  @requires_authorization
  Scenario: delete a folder
    When I've set the box cli env variables
    And I create a temporary folder at box
    And I run `box delete` on the temporary path
    Then the exit status should be 0
    And there should be nothing at the temporary path

  @requires_authorization
  Scenario: delete a file
    When I've set the box cli env variables
    And I create a temporary file at box
    And I run `box delete` on the temporary path
    Then the exit status should be 0
    And there should be nothing at the temporary path