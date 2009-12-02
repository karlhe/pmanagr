Feature: Joining Projects

  In order to use the awesome pManagr site
  As awesome people
  I should be able to join projects to help make the awesome
  As the awesome administrator
  I should be able to accept/deny requests to join my awesome project

  Background:
    Given a user called "Anthony Leung"
    And I am logged in as "Anthony Leung"
    And I own a public project called "Berkeley Project"

  Scenario: Muller Zhang requests to join the Berkeley Project project
    Given a user called "Muller Zhang"
    And I am logged in as "Muller Zhang"
    When I request to join "Berkeley Project"
    Then it should add me to "Berkeley Project" as a request member
    And I should be on the "Berkeley Project" project page

  Scenario: Anthony Leung accepts Muller Zhang's request
    Given a user called "Muller Zhang"
    And I am logged in as "Muller Zhang"
    And I request to join "Berkeley Project"
    
    Given I am logged in as "Anthony Leung"
    When I accept "Muller Zhang" into "Berkeley Project"
    Then it should add "Muller Zhang" to "Berkeley Project" as a "user"
    And I should be on the "Berkeley Project" manage members page

  Scenario: Anthony Leung rejects Michael Chen's application to join
    Given a user called "Michael Chen"
    And I am logged in as "Michael Chen"
    And I request to join "Berkeley Project"
    
    Given I am logged in as "Anthony Leung"
    When I reject "Michael Chen" from "Berkeley Project"
    Then "Michael Chen" should not be a member of "Berkeley Project"
    And I should be on the "Berkeley Project" manage members page
