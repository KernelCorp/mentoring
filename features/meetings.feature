Feature: Meetings
  In order to allow users with role "mentor" create meeting on a date
  and allow users with role "psych" read and deprecate meetings of his subordinates


  Background:
    Given a orphanage "#13"
      And a child with name "Stalin"
      And a user with email: "psych@example.com" and role "psych" for orphanage "#13"
      And a user with email: "mentor@example.com" and role "mentor" for child "Stalin" and curator: "psych@example.com"

  Scenario: Create new meeting
    Given I signed in as user with email: "mentor@example.com"
    When I go to "/meetings"
     And I click to the button "Назначить новую встречу"
     And I select child "Stalin""
     And I select date "tomorrow"
     And I click to submit button
    Then I should see success message "Новая встреча назначена"
     And I should be redirected to new meeting's page
     And a new meeting to "Stalin" at tomorrow should be created


  Scenario: Mentor reject meeting
    Given a meeting to "Stalin" and user "mentor@example.com" at tomorrow
      And I signed in as user with email: "mentor@example.com"
    When I go to "/meetings"
     And I click to button "Отказатся от встречи"
    Then I should see success message "Вы отказались от встречи"
     And the meeting should have state "rejected"
     And I should be redirected to list of meetings

  Scenario: Show meetings for curator
    Given a child with name "Lenin"
    And a child with name "Putin"
    And a user with email: "mentor2@example.com" and role "mentor" for child "Lenin" and curator: "psych@example.com"
    And a meeting to "Stalin" and user "mentor@example.com" at tomorrow
    And a meeting to "Lenin" and user "mentor2@example.com" at tomorrow
    And a user with email: "psych2@example.com" and role "psych" for orphanage "#13"
    And a user with email: "mentor3@example.com" and role "mentor" for child "Putin" and curator: "psych2@example.com"
    And a meeting to "Putin" and user "mentor@example.com" at tomorrow
    And I signed in as user with email: "psych@example.com"
    When I go to "/meetings"
    Then I should see only "2" meetings to "Stalin", "Lenin"

  Scenario:  Psych reject meeting
    Given a meeting to "Stalin" and user "mentor@example.com" at tomorrow
    And I signed in as user with email: "mentor@example.com"
    When I go to "/meetings"
    And I click to button "Отказатся от встречи"
    Then I should see success message "Вы отклонили встречу"
    And the meeting should have state "rejected"
    And I should be redirected to list of meetings