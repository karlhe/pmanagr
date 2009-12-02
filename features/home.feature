Feature: Viewing the home page

  In order to use the awesome pManagr site
  I should be able to visit the awesome home page

  Scenario: not logged in
    Given I am not logged in
    When I go to the home page
    Then I should be on the home page
    And it should have a link to public projects

  Scenario: logged in
    Given I am logged in
    When I go to the home page
    Then I should be on the dashboard
    And it should have a link to public projects
