@wip
Feature: Fan signup
  In order to know what the band is up to
  As a fan
  I want to sign up for the mailing list and receive emails
  
  Scenario: Fan signs up from home page with all valid info
    Given a global setting exists
    And I am on the home page
    And I fill in "email" with "fred@gmail.com"
    And I fill in "zip_code" with "78723"
    And I press "SIGN UP"
    Then I should see "Thanks for joining the World Racketeering Squad mailing list."
    And the "Zipcode" field should contain "78723"
  
  

  
