Feature: doing a presentation in front of an audience

  When presenting contents in front of an audience, the user expects some support. This will help
  to deliver a good talk and result in satisfaction for both, speaker and listener.

  Background:
    Given a ZUI presentation "About Zooming Presentations"
    Given the outline
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

  @tbd @it2
  Scenario: Display the outline
    Given the element "outline" is "hidden"
    When I press "b"
    Then the element "outline" is "visible"

  @tbd @it2
  Scenario: Navigating to arbitrary waypoint on the landscape
    Given the current position is at "Title"
    And I see the content of "Title"
    When I open the outline
    And I go to "Slides + Problems"
    Then I should see the content of "Slides + Problems"

  @tbd @it2
  Scenario: Navigating forwards within the list of waypoints on landscape
    Given the current position is at "Slides + Problems"
    And I see the content of "Slides + Problems"
    When I go "forward"
    Then I should see the content of "ZUI Presentations"

  @tbd @it2
  Scenario: Navigating backwards within the list of waypoints on landscape
    Given the current position is at "Slides + Problems"
    And I see the content of "Slides + Problems"
    When I go "back"
    Then I should see the content of "Slides + Advantages"

  @tbd @it8
  Scenario: Semantic zooming
    Given current view contains a "large" Object
    And current view contains a "very small" Object
    When the view is shown to the user
    Then there should be 1 object "with" details visible
    And there should be 1 object "without" details visible

  @tbd @it1
  Scenario: Zooming in
    Given the current position is at "Title"
    And I can see an element "title"
    When I zoom in
    Then the element "title" should be larger

  @tbd @it1
  Scenario: Zooming out
    Given the current position is at "Title"
    And I can see an element "title"
    When I zoom out
    Then the element "title" should be smaller

  @tbd @it1
  Scenario: Panning
    Given the current position is at "Title"
    And I can see an element "title"
    When I pan 100 pixels to the left
    Then the element "title" should be moved by (-100,0)

