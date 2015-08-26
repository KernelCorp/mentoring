Feature: Meetings
  Section is a repository of books and articles that have been added by curators.
  In the section "New read" on dashboard users are displayed books respectively priority:
  first "urgent to read everything," then "must-read" and "it's interesting".
  For every book and article, all users should be able to add a comment. Priority is enum

  Background:
    Given a orphanage "Futurama"
      And a child with name "Fry"
      And a user with email: "zoidberg@example.com" and role "curator" for orphanage "Futurama"
      And a user with email: "bender@rodriguez.com" and role "mentor" for child "Fry" and curator: "zoidberg@example.com"


  Scenario: Curator add a new book
    Given I signed in as user with email: "zoidberg@example.com"
    When I go to "/books"
     And I click to the button "Добавить новую книгу"
     And I fill in an input "Название" as "Wikipedia. Premium Edition" in the form "new_book"
     And I select priority "must_read"
     And I attach some file
     And I click to the submit button
    Then I should be redirected to list of books
     And a new book with title "Wikipedia. Premium Edition" should be created

  Scenario: Mentor see books
    Given I signed in as user with email: "bender@rodriguez.com"
    And a user with email: "leela@example.com" and role "curator" for orphanage "Futurama"
    And a book with title: "Mutants. Right-hand rule", owner: "leela@example.com"
    And a book with title: "Wikipedia. Premium Edition", owner: "zoidberg@example.com"
    When I go to "/books"
    Then I should see book with title: "Wikipedia. Premium Edition"
    But I should not see book with title: "Mutants. Right-hand rule"
    And I should not see button "Добавить новую книгу"

  Scenario: Mentor send comment
    Given I signed in as user with email: "bender@rodriguez.com"
    And a book with title: "Wikipedia. Premium Edition", owner: "zoidberg@example.com"
    When I go to "/books"
    And I click on book with title: "Wikipedia. Premium Edition"
    And I fill in an input "comment_text" as "Awesome!" in the form "new_comment"
    And I click to the submit button
    Then I should see a new comment

  Scenario: Curator send comment
    Given I signed in as user with email: "zoidberg@example.com"
    And a book with title: "Wikipedia. Premium Edition", owner: "zoidberg@example.com"
    When I go to "/books"
    And I click on book with title: "Wikipedia. Premium Edition"
    And I fill in an input "comment_text" as "Awesome!" in the form "new_comment"
    And I click to the submit button
    Then I should see a new comment



    