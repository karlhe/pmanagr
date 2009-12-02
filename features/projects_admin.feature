Feature: Administrating Projects

  In order to use the awesome pManagr site
  As the awesome project administrator
  I should be able to awesomely create and administrate projects
  
  Background:
    Given there exists a user called "Anthony Leung"
    
    Scenario: Anthony Leung creates a private project called CSR
      Given I am logged in as "Anthony Leung"
      When I create a private project called "CSR"
      Then I should be on the "CSR" project page
      Then "CSR" should not appear in "public projects"
      And "CSR" should appear in "your projects"

    Scenario: Anthony Leung creates a public project called Berkeley Project
      Given I am logged in as "Anthony Leung"
      When I create a public project called "Berkeley Project"
      Then it should be in the public page view
      And "Berkeley Project" should appear under "Your Projects" on the user dashboard
      And I should see the "Berkeley Project" project page'

    Scenario: Anthony Leung removes the private project called CSR
      Given I am logged in as "Anthony Leung"
      And there exists a private project called "CSR"
      And I am administrator for "CSR"
      When I destroy a private project called "CSR"
      Then the project along with its tasks, assignments, and members should be removed
      And I should see the user dashboard

    Scenario: Anthony Leung removes the public project called Berkeley Project
      Given I am logged in as "Anthony Leung"
      And there exists a public project called "Berkeley Project"
      And I am administrator for "Berkeley Project"
      When I destroy a public project called "Berkeley Project"
      Then the project along with its tasks, assignments, and members should be removed
      And "Berkeley Project" should no longer be on the public projects page
      And I should see the user dashboard
