#Feature: My mentors
#  In order to a curator can see list of mentors
#
#  Background:
#    Given a orphanage "Futurama"
#    And a child with name "Fry" in orphanage "Futurama"
#    And a user with email: "zoidberg@example.com" and role "curator" for orphanage "Futurama"
#    And a user with email: "bender@rodriguez.com" and role "mentor" for child "Fry" and curator: "zoidberg@example.com"
#
#  Scenario: Show list
#    Given I signed in as user with email: "zoidberg@example.com"
#    When I click to the link "Мои наставники"
  #    Then I should see user with email "zoidberg@example.com"