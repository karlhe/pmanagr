Feature: Events
  In order for the team to meet up
  As a project manager
  I want to be able to create events

  Scenario: Create Event
    Given I have clicked the events tab
    And clicked on "Create new Event"
    And type in Event Description, meeting place and meeting time
    When I check "Invite all"
    When I click on "Create Event"
    Then the result should be a page describing the event and email notifications to all members
    
  Scenario: Create Limited Event
    Given I have clicked the events tab
    And clicked on "Create new Event"
    And type in Event Description, meeting place and meeting time
    When I check the members I want to invite
    When I click on "Create Event"
    Then the result should be a page describing the event and email notifications to all members that were checked off
    
    
