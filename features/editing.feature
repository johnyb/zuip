Feature: editing presentations

  In order to create nice presentations authors want to
  manage the content of the landscape they are working on.

  @tbd
  Scenario: Grouping objects
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
    But bicycle does not belong to a group

  @tbd
  Scenario: add assets
    Given a landscape
    When I add an asset of "Image" type named "car.png"
    And I add an asset of "Text" type named "headline"
    Then the landscape contains 2 objects

  Scenario: moving objects
    Given a landscape containing the objects
      | name  |
      | car   |
      | train |
    When I move "car" to "(100,100)"
    Then the object "car" is rendered at "(100,100)"

