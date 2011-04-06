Feature: editing presentations

  In order to create nice presentations editors want to
  manage the content of the landscape they are working on.

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

  Scenario: add assets
    Given a landscape
    When I add an asset of "Image" type named "car.png"
    And I add an asset of "Text" type named "headline"
    Then the landscape contains 2 objects

