Feature: Completing Assignments

  In order to use the awesome pManagr site
  As awesome project member
  I should be able to declare tasks awesomely complete

  Background:
    Given a user called "Amy Tang"
    And "Amy Tang" is a member a project called "CSR"
    And "Amy Tang" owns an assignment called "Find Decorations" for the task "Logistics"

  Scenario: Amy Tang completes an assignment called "Find Decorations"
    Given I am logged in as "Amy Tang"
    When I complete the assignment called "Find Decorations"
    Then it should show the assignment on the task page as complete
    And if all other assignments are complete, the task should be marked as finished
    And the assignment should display as complete on the task page
    And the assignment should display under complete under my user dashboard
    And I should see the task page

  Scenario: Amy Tang undos her completion of the assignment called "Find Decorations"
    Given I am logged in as "Amy Tang"
    When I undo the completion of the assignment called "Find Decorations"
    Then it should show the assignment on the task page as incomplete
    And the assignment should be displayed as an incomplete task on dashboard
    And if the task was complete, it should change the task to incomplete
    And I should see the task page