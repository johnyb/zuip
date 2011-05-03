Feature: doing a presentation in front of an audience

  When presenting contents in front of an audience, the user expects some support. This will help
  to deliver a good talk and result in satisfaction for both, speaker and listener.

  Background:
    Given a presentation "About Zooming Presentations"
    Given a list of waypoints
      | name       |
      | Title      |
      | Slides     |
      | + Advantages |
      | + Problems   |
      | ZUI Presentations |
      | + Advantages |
      | + Problems   |
      | Solutions  |
      | + Prezi    |
      | + CounterPoint |
      | + ZUIP     |

  @tbd
  Scenario: Navigating to arbitrary waypoint on the landscape
    Given the current position is at "Title"
    And I see the content of "Title"
    When I go to "Slides + Problems"
    Then I should see the content of "Slides + Problems"

  @tbd
  Scenario: Navigating backwards within the list of waypoints on landscape
    Given the current position is at "Slides + Problems"
    And I see the content of "Slides + Problems"
    When I go "forward"
    Then I should see the content of "ZUI Presentations"

  @tbd
  Scenario: Navigating backwards within the list of waypoints on landscape
    Given the current position is at "Slides + Problems"
    And I see the content of "Slides + Problems"
    When I go "back"
    Then I should see the content of "Slides + Advantages"

  @tbd
  Scenario: semantic zooming
    Given current view contains a "large" Object
    And current view contains a "very small" Object
    When the view is shown to the user
    Then there should be 1 object "with" details visible
    And there should be 1 object "without" details visible

