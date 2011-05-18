Feature: editing presentations

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

  @tbd @it3
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
  Scenario: remove assets
    Given a landscape containing the objects
      | name    |
      | car     |
      | bicycle |
      | train   |
    When I select all objects
    And I press the "del" key
    Then the landscape contains no objects

  @tbd @it3
  Scenario: add assets
    Given a landscape
    When I add an asset of "Image" type named "car.png"
    And I add an asset of "Text" type named "headline"
    Then the landscape contains 2 objects

  @tbd @it3
  Scenario: move objects
    Given a landscape containing the objects
      | name  |
      | car   |
      | train |
    When I move "car" to "(100,100)"
    Then the object "car" is rendered at "(100,100)"

