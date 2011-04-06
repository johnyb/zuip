Feature: doing a presentation in front of an audience

  When presenting contents in front of an audience, the user expects some support. This will help
  to deliver a good talk and result in confidentiality for both, speaker and listener.

  Background:
    Given a presentation "About Zooming Presentations"
    Given a list of navigational points
    | name       |
    | Title      |
    | Advantages |
    | Problems   |
    | Solutions  |
 
  Scenario: Navigation between different navigational points on landscape
    Given the current position is at "Problems"
    When I go "back"
    Then I should see the content of "Advantages"

  Scenario: semantic zooming
    Given current view contains a "large" Object
    And current view contains a "very small" Object
    When the view is shown to the user
    Then there should be 1 object "with" details visible
    And there should be 1 object "without" details visible

