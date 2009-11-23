Feature: Completing Tasks

  In order to use the awesome pManagr site
  As the awesome project administrator
  I should be able to declare tasks complete

  Background:
    Given a user called "Anthony Leung"
    And "Anthony Leung" is adminstrator for a project called "CSR"

  Scenario: Anthony Leung completes a task called "Logistics"
    Given I am logged in as "Anthony Leung"
    And all prerequisites of the task are complete
    And all assignments of the task are complete
    When I ccompletes the task called Logistics
    Then it should show the task on the project page as complete
    And users can no longer add assignments to the task
    And I should see the project page
