Feature: Discussion
  In order to communicate with other team members
  As a team member
  I want to be able to talk with them through pManagr

  Scenario: Post Discussion Topic
    Given I have clicked the discussion tab
    And clicked on "Create new Discussion Topic"
    When I type in a topic title and post
    And clicked on "Post Topic"
    Then the result should be a page for that topic

  Scenario: Reply to Discussion
    Given I have entered the discussion tab
    And clicked on "Create new Discussion Topic"
    When I type in a topic title and post
    And clicked on "Post Topic"
    Then the result should be a page for that topic

  Scenario: Private Message
    Given I have entered the discussion tab
    And clicked on "Send Private Message"
    And I type in a message title and post
    And I type in the members I want to send the message to
    When I click on "Send Message"
    Then the result should send that messages to the specified members and I am taken back to the main page of the discussion tab
