Feature: Completing Tasks

  In order to use the awesome pManagr site
  As the awesome project administrator
  I should be able to declare tasks complete

  Background:
    Given a user called "Anthony Leung"
    And I am logged in as "Anthony Leung"
    And I own a public project called "CSR"

  Scenario: Anthony Leung completes a task called "Logistics"
    Given I have created a task for "CSR" called "Logistics"
    When I complete the "CSR" task "Logistics"
    Then the "CSR" task "Logistics" should be complete
    And I should be on the "CSR" project page
