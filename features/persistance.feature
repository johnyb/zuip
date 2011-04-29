Feature: Persistance for presentations

  As an author I want to have persistant access to my
  creations in order to stop editing and start again, later.

  Scenario: storing presentation on disk
    Given a presentation
    When I save the presentation as "my_presentation"
    Then there should be a file "my_presentation.svg"
    And the file should contain a valid presentation

  Scenario: loading a presentation from a file
    Given an empty working area
    When I open the file "my_presentation.svg"
    Then I should see a presentation

