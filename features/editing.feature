Feature: Editing presentations

  In order to create nice presentations authors want to
  manage the content of the landscape they are working on.

  @tbd @it3
  Scenario: Ungroup objects
    Given a landscape containing the objects
      | name    |
      | car     |
      | bicycle |
      | train   |
    And these objects belong to a group
      | name  |
      | car   |
      | train |
    When I select the group
    And I ungroup the selected objects
    Then the landscape contains no groups
    But the landscape contains 3 objects

  @tbd @it3 @javascript
  Scenario: Group objects
    Given a landscape containing the objects
      | name    |
      | car     |
      | bicycle |
      | train   |
    When I select the objects
      | name  |
      | car   |
      | train |
    And I group the selected objects
    Then the landscape contains 1 group with 2 objects
    But "bicycle" does not belong to a group

  @tbd @it3
  Scenario: Remove assets
    Given a landscape containing the objects
      | name    |
      | car     |
      | bicycle |
      | train   |
    When I select all objects
    And I press the "del" key
    Then the landscape contains no objects

  @wip @it3
  Scenario: Add assets
    Given a landscape
    When I add an asset of "Image" type named "car.png"
    And I add an asset of "Text" type named "headline"
    Then the landscape contains 2 objects

  @tbd @it3
  Scenario: Move objects
    Given a landscape containing the objects
      | name  |
      | car   |
      | train |
    When I move "car" to "(100,100)"
    Then the object "car" is rendered at "(100,100)"

  @it3
  Scenario: Create a New Presentation
    Given I am on the presentation index page
    And a presentation "semantic_desktop" does not exist
    When I follow "New ZUI-Presentation"
    And I fill in "Title" with "Semantic Desktop - recent progress"
    And I fill in "Filename" with "semantic_desktop"
    And I press "create"
    Then I should be on the presentations edit page for "semantic_desktop"
    And there should be a presentation "semantic_desktop"
