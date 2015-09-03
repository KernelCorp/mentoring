Feature: new candidate

  @javascript
  Scenario: correct
    When I go to "/candidates/new"
    And I fill in all "text" inputs with "test"
    And I fill in all textarea fields with "test"
    And I fill in all "number" inputs with "10"
    And I fill in all "email" inputs with "test@example.com"
    And I select option from each select
    And I choose each radio button with label "Да"
    And I click on agreement checkbox
    And I click to the submit button
    Then I should see success message

  @javascript
  Scenario: incorrect
    When I go to "/candidates/new"
    Then I should see disabled submit button
