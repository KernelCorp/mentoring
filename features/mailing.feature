Feature: Mailing
  In order to allow users with role "mentor" send messages to their curators
  and allow users with role "curator" read and reply this messages

  Background:
    Given a orphanage "#13"
      And a child with name "Stalin"
      And a user with email: "psych@example.com" and role "curator" for orphanage "#13"
      And a user with email: "mentor@example.com" and role "mentor" for child "Stalin" and curator: "psych@example.com"

  Scenario: Send message to curator
    Given I signed in as user with email: "mentor@example.com"
     When I go to "/mailbox"
      And I click to the button "Написать сообщение"
      And I select destination "psych@example.com"
      And I fill in an input "Тема" as "Stalin is asshole" in the form "new_conversation"
      And I fill in an input "Сообщение" as "It isn't joke" in the form "new_conversation"
      And I click to the submit button
     Then a new conversation with "psych@example.com" should be created
      And I should be redirected to new conversation page
     When I go to "/mailbox/sent"
     Then I should see only 1 conversation with originator "mentor@example.com"

  Scenario: Show message to curator
    Given a conversation with originator "mentor@example.com" and recipient "psych@example.com"
      And I signed in as user with email: "psych@example.com"
     When I go to "/mailbox/inbox"
      And I should see only 1 conversation with originator "mentor@example.com"

  Scenario: Reply to the message
    Given a conversation with originator "mentor@example.com" and recipient "psych@example.com"
      And I signed in as user with email: "psych@example.com"
     When I go to "/mailbox/inbox"
      And I click to the button "Просмотр"
      And I fill in an input "Ответ" as "body of message must be here somewhere" in the form "new_message"
      And I click to the button "Ответить"
     When I should see only 2 messages on this page
      And a conversation with "mentor@example.com" should have only 2 messages
