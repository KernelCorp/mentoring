Feature: new candidate
  In order to guest user can send CV and an admin can approve CV

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

#  Scenario: show candidats list
#    Given a user with email: "hermes@example.com" and role "admin"
#    And a new candidate
#    And a approved candidate
#    And I signed in as user with email: "hermes@example.com"
#    When I go to dashboard
#    And I click to link "Кандидаты"
#    Then I should see 2 candidats
#
#  Scenario: Approve candidate
#    Given a user with email: "hermes@example.com" and role "admin"
#    And a new candidate with email: "emy@wong.info"
#    And I signed in as user with email: "hermes@example.com"
#    When I go to dashboard
#    And I click to link "Кандидаты"
#    And I click to button "approve"
#    Then a new user with email "emy@wong.info" with role "mentor" should be created
#    And the candidate with email "emy@wong.info" should change state to "approved"