Feature: EmailNotifications
  Users can receive email-notifications about different events
  Admins receive notifications about new candidates
  Curators receive notifications about new report from their subordinates
  Mentors receive notifications about scheduled meetings
  All users receive notifications about incoming messages

  Background:
    Given a orphanage "Futurama"
    And a child with name "Fry" in orphanage "Futurama"
    And a user with email: "zoidberg@example.com" and role "curator" for orphanage "Futurama"
    And a user with email: "bender@rodriguez.com" and role "mentor" for child "Fry" and curator: "zoidberg@example.com"
    And a user with email: "hubert.j@farnsworth.com" and role "admin"

  @javascript
  Scenario: New candidate created
    When I go to "/candidates/new"
    And I fill in all "text" inputs with "test"
    And I fill in all textarea fields with "test"
    And I fill in all "number" inputs with "10"
    And I fill in all "email" inputs with "test@example.com"
    And I select option from each select
    And I choose each radio button with label "Да"
    And I click on agreement checkbox
    And I click to the submit button
    Then admin should receive email-notification
    And new candidate should receive email-notification

  Scenario: Curator receive message from mentor
    Given I signed in as user with email: "bender@rodriguez.com"
    When I go to "/mailbox"
    And I click to the button "Написать сообщение"
    And I select destination "zoidberg@example.com"
    And I fill in an input "Тема" as "Stalin is asshole" in the form "new_conversation"
    And I fill in an input "Сообщение" as "It isn't joke" in the form "new_conversation"
    And I click to the submit button
    Then a new conversation with "zoidberg@example.com" should be created
    And curator should receive email-notification

  Scenario: New report created
    Given a meeting to "Fry" and user "bender@rodriguez.com" at yesterday
    And I signed in as user with email: "bender@rodriguez.com"
    When I go to "/meetings"
    And I click to the button "Составить отчёт"
    And I fill in an input "Длительность в часах" as "2" in the form "new_report"
    And I fill in an input "Цель" as "blitzkrieg" in the form "new_report"
    And I fill in an input "Краткое описание" as "blitzkrieg" in the form "new_report"
    And I fill in an input "Результат" as "fail" in the form "new_report"
    And I fill in an input "Ощущения" as "vexation" in the form "new_report"
    And I fill in an input "Вопросы" as "no" in the form "new_report"
    And I fill in an input "Следующая цель" as "no" in the form "new_report"
    And I fill in an input "Дополнительные комментарии" as "no" in the form "new_report"
    And I click to the submit button
    Then a report of the meeting should be created
    And curator should receive email-notification
