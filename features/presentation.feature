Feature: doing a presentation in front of an audience

  When presenting contents in front of an audience, the user expects some support. This will help
  to deliver a good talk and result in satisfaction for both, speaker and listener.

  Background:
    Given a ZUI presentation "About Zooming Presentations"
    Given the outline
      | name       |
      | # Title #  |
      | # Slides # |
      | ## Advantages ## |
      | ## Problems ##   |
      | # ZUI Presentations # |
      | ## Advantages ## |
      | ## Problems ## |
      | # Solutions # |
      | ## Prezi ## |
      | ## CounterPoint ## |
      | ## ZUIP ##  |

  @it2 @wip
  Scenario: Display the outline
    Given the element "outline" is hidden
    When I press "b"
    Then the element "outline" is visible

  @it2 @tbd
  Scenario: Navigating to arbitrary waypoint on the landscape
    Given the current position is at "Title"
    And I see the content of "Title"
    When I open the outline
    And I go to "Slides + Problems"
    Then I should see the content of "Slides + Problems"

  @it2 @tbd
  Scenario: Navigating forwards within the list of waypoints on landscape
    Given the current position is at "Slides + Problems"
    And I see the content of "Slides + Problems"
    When I go "forward"
    Then I should see the content of "ZUI Presentations"

  @it2 @tbd
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

  @javascript
  Scenario: Zooming in
    Given the current position is at "Title"
    And I can see an element "title"
    When I zoom in
    Then the elements should be larger

  @javascript
  Scenario: Zooming out
    Given the current position is at "Title"
    And I can see an element "title"
    When I zoom out
    Then the elements should be smaller

  @javascript
  Scenario: Panning
    Given the current position is at "Title"
    And I can see an element "title"
    When I pan to the left
    Then the elements should be more left
