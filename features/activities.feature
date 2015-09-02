Feature: Activities
  In order to user can see public activities on dashboard
  Curators can see new meetings, new reports, new photos, new photo's comment, new books
  Mentors can see ony news about new books and new curator's photo

  Background:
    Given a orphanage "Futurama"
    And a child with name "Fry" in orphanage "Futurama"
    And a user with email: "zoidberg@example.com" and role "curator" for orphanage "Futurama"
    And a user with email: "bender@rodriguez.com" and role "mentor" for child "Fry" and curator: "zoidberg@example.com"

  Scenario: Show activities for mentor
    Given user "zoidberg@example.com" has album "Planet Express"
    And a photo in the album "Planet Express"
    And a book with title: "Mutants. Right-hand rule", owner: "zoidberg@example.com"
    And I signed in as user with email: "bender@rodriguez.com"
    When I go to dashboard
    Then I should see activities about new photo
    And I should see activities about new book "Mutants. Right-hand rule"

  Scenario: Show activities for curator
    Given user "bender@rodriguez.com" has album "Planet Express"
    And a photo in the album "Planet Express"
    And a meeting to "Fry" and user "bender@rodriguez.com" at tomorrow
    And meeting to "Fry" and user "bender@rodriguez.com" at yesterday on state "report_sent"
    And I signed in as user with email: "zoidberg@example.com"
    When I go to dashboard
    Then I should see activities about new photo
    And I should see activities about new meeting
    And I should see activities about new report
