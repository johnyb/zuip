Feature: Defining a presentation as a path through the landscape

  A presentation can be defined as a sequential list of waypoints throughout
  the landscape that has been layed out by the author. As an author I want to define
  such a path through the content in order to create a specific presentation.

  @tbd @it4
  Scenario: Create waypoint
    Given a presentation
    And the presentation contains an object "Architecture"
    When I focus the object "Architecture"
    And create a new waypoint
    Then there should be a waypoint "Architecture"

  @tbd @it4
  Scenario: Change order
    Given a presentation
    And the presentation contains the waypoints
      | name |
      | Architecture |
      | Model |
      | Controller |
      | View |
    When I select the waypoint "View"
    And move it up one position
    Then the outline looks like
      | name |
      | Architecture |
      | Model |
      | View |
      | Controller |

  @tbd @it4
  Scenario: Remove waypoint
    Given a presentation
    And the presentation contains the waypoints
      | name |
      | Architecture |
      | Model |
      | Controller |
      | View |
    When I select the waypoint "View"
    And I press the "del" key
    Then the outline looks like
      | name |
      | Architecture |
      | Model |
      | Controller |

