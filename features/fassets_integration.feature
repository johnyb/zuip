Feature: Fassets integration

  As an asset store and content management system, Fassets can be used to
  manage content that can be loaded into a presentation.
  Users should be able to easily integrate content from Fassets into zuip.

  Background:
    Given a user named "robert" is logged into the Fassets system

  @tbd
  Scenario: import assets from Fassets’ tray
    Given the tray of "robert" contains these items
      | name      | type  |
      | telephone | Image |
    When I choose "telephone"
    Then the asset named "telephone" should be imported

  @tbd
  Scenario: store presentation in Fassets
    Given a presentation
    When I put it on Fassets’ tray
    Then my tray should contain the presentation

  Scenario: create overviews from multiple presentations in fassets
    Given the tray of "robert" contains these items
      | name        | type         |
      | History     | Presentation |
      | Technology  | Presentation |
      | Realisation | Presentation |
    When I generate an overview
    Then the landscape contains 3 groups with many objects

