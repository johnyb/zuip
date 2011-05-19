Feature: Connecting to a Fassets instance

  As an administrator I want to connect to an existing
  instance of Fassets in order to use the Fassets integration
  feature.

  @tbd @it6
  Scenario: Add a connection
    Given there is no connection to Fassets
    When I add a connection to "https://zfx.imis.uni-luebeck.de/"
    Then there is a connection to Fassets

  @tbd @it6
  Scenario: Remove a connection
    Given there is a connection to Fassets
    When I remove the connection to "https://zfx.imis.uni-luebeck.de/"
    Then there is no connection to Fassets

