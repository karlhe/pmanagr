Feature: Joining Projects

  In order to use the awesome pManagr site
  As awesome people
  I should be able to join projects to help make the awesome
  As the awesome administrator
  I should be able to accept/deny requests to join my awesome project

  Background:
    Given a user called "Anthony Leung"
    And a user called "Muller Zhang"
    And a user called "Michael Chen"
    And "Anthony Leung" is administrator for a public project called "Berkeley Project"

  Scenario: Muller Zhang requests to join the Berkeley Project project
    Given I am logged in as "Muller Zhang"
    When I request to join Berkeley Project
    Then it should create a membership with a "requesting" status
    And the request should show on the project page
    And the project should appear under the user dash board as "requesting"
    And I should see the project page

  Scenario: Anthony Leung accepts Muller Zhang's request
    Given I am logged in as "Anthony Leung"
    When I accept Muller Zhang into Berkeley Project
    Then it should change the membership status to "accepted"
    And Muller Zhang should display on the project page as a normal member
    And I should see the project page

  Scenario: Anthony Leung rejects Michael Chen's application to join
    Given I am logged in as "Anthony Leung"
    And Michael Chen requests to join Berkeley Project
    When I deny Michael Chen's request
    Then it should destroy the requesting membership
    And Michael Chen should not display on the project page member list
    And I should see the project page
