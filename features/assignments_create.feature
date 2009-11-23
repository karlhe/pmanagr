Feature: Creating and Destroying Assignments

  In order to use the awesome pManagr site
  As the awesome project administrator
  I should be able to create and destroy assignments

  Background:
    Given a user called "Anthony Leung"
    And "Anthony Leung" is adminstrator for a project called "CSR"
    And "CSR" has a task called "Logistics"

  Scenario: Anthony Leung creates an assignment called "Find Food" for "Logistics"
    Given I am logged in as "Anthony Leung"
    When I create a new assignment called Find Food for the task Logistics
    Then it should create a new assignment with no user, or an assigned user if assigned
    And it should show on the Logistics task page
    And I should see the task page

  Scenario: Anthony Leung destroys the assignment called "Find Food" for "Logistics"
    Given I am logged in as "Anthony Leung"
    When I destroyed assignment called Find Food for Logistics
    Then it should not show on the Logistics task page
    And I should see the task page