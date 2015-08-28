Feature: Photos
  Section is a repository of photos from events or meetings with children. Photos can be downloaded by users in formats
  jpeg, jpg, png, gif, bmp. Loading should be possible both in one picture with the addition of the specification and
  the album with the addition of the album title. After downloading the photos are visible for users c roles of mentor,
  curator, employee of the children's home, as well as open the possibility commenting photos.

  Background:
    Given a orphanage "Futurama"
    And a child with name "Fry" in orphanage "Futurama"
    And a user with email: "zoidberg@example.com" and role "curator" for orphanage "Futurama"
    And a user with email: "bender@rodriguez.com" and role "mentor" for child "Fry" and curator: "zoidberg@example.com"

  Scenario:  Create new album
    Given I signed in as user with email: "bender@rodriguez.com"
    When I click to the link "Мои фотографии"
    And I click to the button "Добавить новый альбом"
    And I fill in an input "Название" as "Planet Express" in the form "new_album"
    And I click to the submit button
    Then a new album should be created
    And I should be redirected to the album's page

  Scenario: Show photos on user's page
    Given I signed in as user with email: "zoidberg@example.com"
     And user "bender@rodriguez.com" has album "Planet Express"
    When I go to page of user "bender@rodriguez.com"
    Then I should see album "Planet Express"
