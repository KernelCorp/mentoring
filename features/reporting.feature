Feature: Reporting
  In order to allow mentors create report and psych read and verify it
  Mentor should send report during the day after meeting unless meeting marked as expired


  Background:
    Given a orphanage "#13"
    And a child with name "Stalin"
    And a user with email: "psych@example.com" and role "psych" for orphanage "#13"
    And a user with email: "mentor@example.com" and role "mentor" for child "Stalin" and curator: "psych@example.com"


  Scenario: Visible reporting about meeeting
    Given a meeting to "Stalin" and user "mentor@example.com" at tomorrow
    And a meeting to "Stalin" and user "mentor@example.com" at yesterday
    And I signed in as user with email: "mentor@example.com"
    When I go to "/meetings"
    Then I should meeting's action "reporting" visible only meeting at yesterday


  Scenario: Send report
    Given a meeting to "Stalin" and user "mentor@example.com" at yesterday
      And I signed in as user with email: "mentor@example.com"
    When I go to "/meetings"
     And Click to "Отправить отчет"
     And I fill in an input "duration" as "2 hour" in the form "new_report"
     And I fill in an input "aim" as "blitzkrieg" in the form "new_report"
     And I fill in an input "short_description" as "blitzkrieg" in the form "new_report"
     And I fill in an input "result" as "fail" in the form "new_report"
     And I fill in an input "feelings" as "vexation" in the form "new_report"
     And I fill in an input "questions" as "no" in the form "new_report"
     And I fill in an input "next_aim" as "no" in the form "new_report"
     And I fill in an input "other_comments" as "no" in the form "new_report"
     And I click on the submit button
    Then a report of the meeting should be created
     And I should be redirected to list of meetings
