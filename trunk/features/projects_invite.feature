Feature: Inviting Users to Projects

  In order to use the awesome pManagr site
  As an awesome administrator
  I should be able to invite awesome people to join projects
  As awesome people
  I should be able to accept to deny invitations

  Background:
    Given a user called "Anthony Leung"
    And a user called "Jasmine Nguyen"
    And a user called "Rose Yuan"
    And a user called "Donna Woo"
    And a unregistered person called "Kelly Wang"
    And "Anthony Leung" is administrator for a private project called "CSR"

  Scenario: Anthony Leung invites Jasmine Nguyen, Donna Woo, and Rose Yuan to the CSR project
    Given I am logged in as "Anthony Leung"
    When I invite Jasmine Nguyen, Donna Woo, and Rose Yuan to join
    Then it should create new memberships for each with a pending status
    And an invitation should appear on each invitee's user dashboard
    And the project should show Jasmine, Donna, and Rose as a pending members
    And I should see the project page

  Scenario: Jasmine Nguyen accepts the invitation
    Given I am logged in as "Jasmine Nguyen"
    When I accept the invitation
    Then it should change the membership status to accepted
    And Jasmine should appear as a normal member on the project
    And I should see the project page

  Scenario: Rose Yuan rejects Anthony Leung's invitation
    Given I am logged in as "Rose Yuan"
    When I decline the invitation
    Then it should delete the pending membership
    And Rose should be removed from the project member list
    And I should see the project page

  Scenario: Anthony Leung cancels Donna Woo's invitation
    Given I am logged in as "Anthony Leung"
    When I cancel the invitation
    Then it should delete the pending membership
    And Donna should be removed from the project member list
    And I should see the project page

  Scenario: Anthony Leung invites Kelly Wang to the CSR project
    Given I am logged in as "Anthony Leung"
    When I invite Kelly Wang to join
    Then it should ask to me for Kelly Wang's name and email
    And it should create a user Kelly Wang
    And it should create a membership with pending status for Kelly Wang to CSR
    And it should generate a special link for the invitation
    And it should send this link in an email to Kelly Wang
    And I should see the project page

  Scenario: Kelly Wang follows the invitation link
    Given I am an unregistered person called "Kelly Wang"
    When I follow the invitation link
    Then it should ask me to change my password
    And it should change the membership status to accepted
    And it should show Kelly as a regular member on the project page
    And the link should be disabled
    And I should see the project page

