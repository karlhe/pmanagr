Feature: Assigning and Taking Assignments

  In order to use the awesome pManagr site
  As the awesome project administrator
  I should be able to assign awesome project members to awesome tasks and remove them from tasks
  As awesome project members
  I should be able to take awesome tasks for myself

  Background:
    Given a user called "Anthony Leung"
    And a user called "Chris Nguyen"
    And a user called "Tammy Le"
    And "Anthony Leung" is adminstrator for a project called "CSR"
    And "CSR" has a task called "Logistics"
    And "Logistics" has an assignment called "Find Food"
    And "Logistics" has an assignemnt called "Eat Food"

  Scenario: Anthony Leung assigns Tammy Le to assignment called "Find Food"
    Given I am logged in as "Anthony Leung"
    When I assign Tammy Le to the assignment "Find Food"
    Then it should change the assignment user to Tammy Le
    And Tammy should appear as the person responsible for assignment in the task page
    And the assignment should appear on Tammy Le's dashboard
    And I should see the task page

  Scenario: Anthony Leung assigns Chris Nguyen to assignment called "Find Food" while Tammy owns it
    Given I am logged in as "Anthony Leung"
    When I assign Chris Nguyen to the assignment "Find Food"
    Then it should change the assignment user to Chris Nguyen
    And Chris should appear as the person responsible for assignment in the task page
    And the assignment should appear on Chris's dashboard
    And the assignment should disappear from Tammy's dashboard
    And I should see the task page

  Scenario: Tammy Le takes the task called "Eat Food"
    Given I am logged in as "Tammy Le"
    When I take the task "Eat Food"
    Then it should change the assignment user to Tammy Le
    And Tammy should appear as the person responsible for assignment in the task page
    And the assignment should appear on my dashboard
    And I should see the task page

  Scenario: Anthony Leung removes Tammy Le from task "Event"
    Given I am logged in as "Anthony Leung"
    When I unassign "Eat Food"
    Then it should change the assignment user to no one
    And the assignment should appear as untaken on the task page
    And the assignment should be gone from Tammy's dashboard
    And I should see the task page