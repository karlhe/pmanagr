Feature: View progress
  In order to see the progress of the project
  As a project member
  I want to be able to see the completed and unfinished tasks

  Scenario: View Progress for Task11
    Given I have clicked the progress tab
    When I click on “expand” by Task11
    Then the result should be an expanded list for Task11, showing subtasks with completed tasks checked off and in red and unfinished ones in black and not checked off.

Scenario: Comment on Flagged Task
    Given I have clicked the progress tab and I see that Task12 is flagged
    And I click on “expand” by Task12
    And I read the comment on why it’s flagged
    And I click on the “Discuss” button
    And I see a discussion topic of “FLAGGED: TASK12”
    And I post a reply
    Then the result should be an a post responding to the flag.
