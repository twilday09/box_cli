Feature: upload command

  In order to use box from the command line
  As a CLI user
  I want to be able to upload a file to a path
  
  @requires_authorization
  Scenario: upload a file
    When I've set the box cli env variables
    And I create a local temporary file
    And I run `box upload` for a local temporary file
    Then the exit status should be 0

  @requires_authorization
  Scenario: upload a file when one already exists with the same name
    When I've set the box cli env variables
    And I create a local temporary file
    And I run `box upload` for a local temporary file
    And I run `box upload` for a local temporary file
    Then the exit status should be 1
