Feature: Creating and Destroying Tasks

  In order to use the awesome pManagr site
  As the awesome project administrator
  I should be able to create and destroy tasks

  Background:
    Given a user called "Anthony Leung"
    And I am logged in as "Anthony Leung"
    And I own a public project called "CSR"

  Scenario: Anthony Leung creates task called "Logistics"
    When I create a task for "CSR" called "Logistics"
    Then I should be on the the "CSR" task "Logistics" page
    And I should see "Logistics" on the "CSR" project page

  Scenario: Anthony Leung creates task called "Event" that depends on "Logistics"
    When I create a task for "CSR" called "Logistics"
    And I create a task for "CSR" called "Event"
    And I add the "CSR" task "Logistics" as a prerequisite for "Event"
    Then the "CSR" task "Event" should depend on "Logistics"
