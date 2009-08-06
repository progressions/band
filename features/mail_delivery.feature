Feature: Delivering mail to fans
  In order to communicate with our fans
  As a user
  I want to send a newsletter to our fans
  
  Background:
    Given a global setting exists
    And a user: "archie" exists
    And a fan: "betty" exists with email: "betty@riverdale.com"
    And a fan: "veronica" exists with email: "veronica@lodge.com"
    And a mail exists with title: "Our first letter", body: "Hey everyone! This is a letter from our first mailing list!"
    
  Scenario: Creating a mail
    When I login as user: "archie"
    When I go to the mails page
    Then I should see "Mail"
    And I should see "Our first letter"
    When I follow "SEND"
    Then I should see "Send mail"
    And I should see "Send this email to fans"
    And I should see "2 fans selected"
    When I press "Send"
    Then I should see "Mail was successfully queued for delivery to 2 fans."
    And "betty@riverdale.com" should receive 1 email
    And "veronica@lodge.com" should receive 1 email
    When I go to the admin page
    Then I should see /delivered mail \"Our first letter\" to 2 fans\./
    
  


  
