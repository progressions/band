Feature: Delivering mail to fans
  In order to communicate with our fans
  As a user
  I want to send a newsletter to our fans
  
  Background:
    Given a global setting exists
    And a user: "george" exists
    
  Scenario: Creating a mail
    When I login as user: "george"
    When I go to the mails page
    Then I should see "Mail"
    When I follow "Create New Mail"
    Then I should see "New Mail"
    When I fill in "Title" with "Our first letter"
    When I fill in "mail__body_editor" with "Hey everyone! This is a letter from our mailing list!"
    And I press "Create"
    And I should see "Our first letter"
    And I should see "Hey everyone! This is a letter from our mailing list!"
    
  


  
