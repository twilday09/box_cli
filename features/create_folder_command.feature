Feature: create folder command

  In order to use box from the command line
  As a CLI user
  I want to be able to create a folder

  @requires_authorization
  Scenario: create a new folder
    When I've set the box cli env variables
    And I create a temporary folder at box
    And there should be something at the temporary path