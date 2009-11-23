Feature: Administrating Projects

  In order to use the awesome pManagr site
  As the awesome project administrator
  I should be able to awesomely create and administrate projects

  Background:
    Given a user called "Anthony Leung"
    And "Anthony Leung" wants to administrate a private project called "CSR"
    And "Anthony Leung" wants to administrate a public project called "Berkeley Project"

  Scenario: Anthony Leung creates a private project called CSR
    Given I am logged in as "Anthony Leung"
    When I create a new private project called "CSR"
    Then it should not be in the public page view
    And "CSR" should appear under "Your Projects" on the user dashboard
    And I should see the "CSR" project page

  Scenario: Anthony Leung creates a public project called Berkeley Project
    Given I am logged in as "Anthony Leung"
    When I create a new public project called "Berkeley Project"
    Then it should be in the public page view
    And "Berkeley Project" should appear under "Your Projects" on the user dashboard
    And I should see the "Berkeley Project" project page'

  Scenario: Anthony Leung removes the private project called CSR
    Given I am logged in as "Anthony Leung"
    And I am administrator for "CSR"
    When I destroy a private project called "CSR"
    Then the project along with its tasks, assignments, and members should be removed
    And I should see the user dashboard

  Scenario: Anthony Leung removes the public project called Berkeley Project
    Given I am logged in as "Anthony Leung"
    And I am administrator for "Berkeley Project"
    When I destroy a public project called "Berkeley Project"
    Then the project along with its tasks, assignments, and members should be removed
    And "Berkeley Project" should no longer be on the public projects page
    And I should see the user dashboard
