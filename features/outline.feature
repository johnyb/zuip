Feature: Support outlines for presentations

  In order to achieve a better structure for my presentations
  As an author I want to define topics and subtopics as an outline.

  @tbd
  Scenario: topic waypoints only
    Given the outline
      | name |
      | Title |
      | Introduction |
      | Future Plans |
      | Benefits |
    Then the presentation has 4 topics
    And no subtopics

  @tbd
  Scenario: topic and subtopic waypoints
    Given the outline
      | name |
      | Title |
      | Introduction |
      | + Persons |
      | + Software |
      | + Current Situation |
      | Future Plans |
      | + Short-Term |
      | + Long-Term |
      | Benefits |
      | + Users |
      | + Team |
    Then the presentation has 4 topics
    And "Title" has no subtopics
    And "Introduction" has 3 subtopics
    And "Future Plans" has 2 subtopics
    And "Benefits" has 2 subtopics

  @tbd
  Scenario: referencing subtopics
    Given the outline
      | name |
      | Title |
      | Introduction |
      | + Persons |
      | + Software |
      | + Current Situation |
    When I select "Introduction + Software"
    Then the current topic should be "Introduction"
    And the current subtopic should be "Software"

  @tbd
  Scenario: plus-sign in topic names not allowed
    Given the outline
      | name |
      | Titlel |
      | Introduction |
      | + Persons |
      | + Software |
    When I add the topic "Drinking + Driving"
    Then I should see the message "plus-sign not allowed in topic names"

