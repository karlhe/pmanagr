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
      And "CSR" should not appear in public projects
      And "CSR" should appear in my dashboard

    Scenario: Anthony Leung creates a public project called Berkeley Project
      Given I am logged in as "Anthony Leung"
      When I create a public project called "Berkeley Project"
      Then I should be on the "Berkeley Project" project page
      And "Berkeley Project" should appear in public projects
      And "Berkeley Project" should appear in my dashboard

    Scenario: Anthony Leung removes the private project called CSR
      Given I am logged in as "Anthony Leung"
      And I own a private project called "CSR"
      When I destroy a project called "CSR"
      Then the project "CSR" should not exist
      And I should be on my dashboard

    Scenario: Anthony Leung removes the public project called Berkeley Project
      Given I am logged in as "Anthony Leung"
      And I own a public project called "Berkeley Project"
      When I destroy a project called "Berkeley Project"
      Then the project "Berkeley Project" should not exist
      And "Berkeley Project" should not appear in public projects
      And I should be on my dashboard
