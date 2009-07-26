Feature: Show the index page and the stuff on it
  In order to find out about this band
  As a random web user
  I want to see the band's pages
  
  Scenario: Go to the index page
    Given a global setting exists
    When I go to the home page
    Then I should see "World Racketeering Squad"
  
  
  

  
