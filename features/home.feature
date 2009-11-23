Feature: Viewing the home page

  In order to use the awesome pManagr site
  I should be able to visit the awesome home page

  Scenario: not logged in
    Given I am not logged in
    When I view the home page
    Then I see the home page
    And it should have a link to public projects

  Scenario: logged in
    Given I am logged in
    When I view the home page
    Then I see the user dashboard
    And it should have a link to public projects