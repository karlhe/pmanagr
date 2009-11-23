Feature: Creating and Destroying Tasks

  In order to use the awesome pManagr site
  As the awesome project administrator
  I should be able to create and destroy tasks

  Background:
    Given a user called "Anthony Leung"
    And "Anthony Leung" is adminstrator for a project called "CSR"

  Scenario: Anthony Leung creates task called "Logistics"
    Given I am logged in as "Anthony Leung"
    When I create a new task called Logistics
    Then it should show the task on the project page
    And I should see the project page

  Scenario: Anthony Leung creates task called "Event" that depends on "Logistics"
    Given I am logged in as "Anthony Leung"
    When I create a new task called Event
    Then it should show the task on the project page
    And the task view should show Logistics as a prerequisite
    And I should see the project page
