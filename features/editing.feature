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

  @it3 @javascript
  Scenario: Add assets
    Given a landscape
    When I press the add asset button
    When I add an asset with svg code
      """
      <g id="asset0" class="content" transform="translate(300,200)">
      <path d="M 236.54427,9.8485 C 220.2445,9.8485 204.45277,15.405415 191.41289,25.550223 L 97.337229,97.995127 L -135.0706,131.12201
        C -150.90459,133.65817 -161.13586,149.44963 -156.32358,165.14237 L -132.57022,244.60846 L -86.188678,244.60846 C -90.823109,289.62242
        -60.00389,319.2235 -20.679452,319.2235 C 18.644986,319.2235 49.844083,285.73585 44.829779,244.60846 L 425.19586,244.60846
        C 419.65783,289.49008 452.23789,319.2235 490.70508,319.2235 C 529.17227,319.2235 561.22444,285.70267 556.21433,244.60846
        L 651.04018,244.60846 C 659.88863,244.60846 667.48002,236.98237 667.48,227.63005 L 667.48,137.76012 C 667.48,129.20037
        661.30023,122.08284 653.22799,120.97335 L 491.76774,97.995127 L 427.82125,32.635149 C 413.84999,18.051989 394.74442,10.165524
        374.56372,9.8485 L 236.54427,9.8485 z M 304.42883,37.42226 L 378.62679,37.42226 C 389.64854,37.42226 399.73373,43.261111
        405.94316,52.613356 L 424.25825,80.825395 C 428.78955,88.722668 423.85522,96.409133 415.38198,97.803717 L 304.42883,97.803717
        L 304.42883,37.42226 z M 224.60508,37.549916 L 283.42586,37.549916 L 283.42586,97.803717 L 132.59212,97.803717 L 200.10167,45.97523
        C 207.08728,40.585799 215.91189,37.549914 224.60508,37.549916 z" id="path12" />
      </g>
      """
    And I press the add asset button
    And I add an asset with svg code
      """
      <g id="asset1" class="content" transform="">
        <text style="font-size:154.12817383px;" x="0" y="0" id="text2989">
          <tspan id="tspan2991" x="0" y="0">Headline</tspan>
        </text>
      </g>
      """
    And I press "Save"
    Then I should be on the presentation page for "test"
    And the element "asset1" is visible
    And the element "asset0" is visible

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
