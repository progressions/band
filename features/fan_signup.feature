@fans @captcha @mailer
Feature: Fan signup
  In order to know what the band is up to
  As a fan
  I want to sign up for the mailing list and receive emails
  
  Background:
    Given a setting exists
    
  Scenario Outline: Fan signs up from home page with all valid info
    And I am on the home page
    And I fill in "email" with "<email>"
    And I fill in "zip_code" with "<zipcode>"
    And I press "SIGN UP"
    Then I should see "Edit Fan"
    And I should see "Thanks for joining the World Racketeering Squad mailing list, <email>."
    And the "Zipcode" field should contain "<zipcode>"
    And the "City" field should contain "Austin"
    And the "State" field should contain "TX"
  
    Examples:
    | email           | zipcode | first_name | last_name |
    | jack@kirby.com  | 78701   | Jack       | Kirby     |
    # | stan@marvel.com | 10001   | Stan       | Lee       |
    # | joe@simon.com   | 21041   | Joe        | Simon     |
    
  Scenario Outline: Fan signs up and edits their info
    When a new fan signs up with email: "<email>", zipcode: "<zipcode>"
    When I fill in "First Name" with "<first_name>"
    And I fill in "Last Name" with "<last_name>"
    And I press "Update"
    Then I should see "Fan was successfully updated."
    And I should see "First Name: <first_name>"
    And I should see "Last Name: <last_name>"
    And I should see "Email: <email>"
    And I should see "City: Austin"
    And I should see "State: TX"
    And I should see "Zipcode: <zipcode>"
    
  Scenario Outline: Fan signs up and mails are sent
    When a new fan signs up with email: "<email>", zipcode: "<zipcode>"
    
    And "admin@weracketeer.com" should receive 1 email
    When "admin@weracketeer.com" opens the email with subject "\[New fan\] <email> has joined the mailing list\!"
    Then I should see "New fan signup" in the email
    And I should see "<email> has subscribed" in the email

    Then "<email>" should receive 1 email    
    When "<email>" opens the email with subject "\[WRS\] Thank you for joining the World Racketeering Squad mailing list\!"
    Then I should see "Thank you for joining!" in the email
    And I should see "<email> has subscribed" in the email
    And I should see "You are receiving these emails because <strong><email></strong> is subscribed to the <strong>World Racketeering Squad mailing list</strong>." in the email
  
    Examples:
    | email           | zipcode | first_name | last_name |
    | jack@kirby.com  | 78701   | Jack       | Kirby     |
    | stan@marvel.com | 10001   | Stan       | Lee       |
    | joe@simon.com   | 21041   | Joe        | Simon     |
    
  
  Scenario Outline: Fan signs up and clicks the links in the email to unsubscribe
    When a new fan signs up with email: "<email>", zipcode: "<zipcode>"
    Then "admin@weracketeer.com" should receive 1 email
    And "<email>" opens the email with subject "\[WRS\] Thank you for joining the World Racketeering Squad mailing list\!"
    Then print out the email
    When I follow "World Racketeering Squad" in the email
    Then I should be on the root directory
    When I follow "unsubscribe here" in the email
    Then I should see "Unsubscribe"
    And I should see "Click the button below to unsubscribe <email> from the World Racketeering Squad mailing list."
    Given a clear email queue
    When I press "Unsubscribe"
    Then I should be on the homepage
    And I should see "<email> was successfully unsubscribed."
    Then "admin@weracketeer.com" should receive 1 email
  
    Examples:
    | email           | zipcode | first_name | last_name |
    | jack@kirby.com  | 78701   | Jack       | Kirby     |
    | stan@marvel.com | 10001   | Stan       | Lee       |
    | joe@simon.com   | 21041   | Joe        | Simon     |
    
  
  Scenario Outline: Fan signs up with a duplicate email address
    When a new fan signs up with email: "<email>", zipcode: "<zipcode>"
    Given a clear email queue
    When a new fan signs up with email: "<email>", zipcode: "<zipcode>"
    Then I should see "Email has already been taken"
    And "<email>" should receive 0 emails
    When a new fan signs up with email: "<email>", zipcode: "999999"
    Then I should see "Email has already been taken"
    And "<email>" should receive 0 emails
  
    Examples:
    | email           | zipcode | first_name | last_name |
    | jack@kirby.com  | 78701   | Jack       | Kirby     |
    | stan@marvel.com | 10001   | Stan       | Lee       |
    | joe@simon.com   | 21041   | Joe        | Simon     |
  
  
  Scenario Outline: Fan signs up with valid captcha
    Given a global setting exists with use_captcha_for_fans: true
    And I am on the home page
    And I fill in "email" with "<email>"
    And I fill in "zip_code" with "<zipcode>"
    And I press "SIGN UP"
    Then I should see "New Fan"
    And I should see "You are almost done signing up for the World Racketeering Squad mailing list."
    And I should see "Please fill in the CAPTCHA below to complete your signup."
    And I fill in the captcha so it is true
    And I press "Create"
    Then I should see "Thanks for joining the World Racketeering Squad mailing list, <email>."
  
    Examples:
    | email           | zipcode | first_name | last_name |
    | jack@kirby.com  | 78701   | Jack       | Kirby     |
    | stan@marvel.com | 10001   | Stan       | Lee       |
    | joe@simon.com   | 21041   | Joe        | Simon     |
  
  
  Scenario Outline: Fan signs up with invalid captcha
    Given a global setting exists with use_captcha_for_fans: true
    And I am on the home page
    And I fill in "email" with "<email>"
    And I fill in "zip_code" with "<zipcode>"
    And I press "SIGN UP"
    Then I should see "New Fan"
    And I should see "You are almost done signing up for the World Racketeering Squad mailing list."
    And I should see "Please fill in the CAPTCHA below to complete your signup."
    And I fill in the captcha so it is false
    And I press "Create"
    Then I should not see "Thanks for joining the World Racketeering Squad mailing list, <email>."
    And I should see "Captcha response is incorrect, please try again."
  
    Examples:
    | email           | zipcode | first_name | last_name |
    | jack@kirby.com  | 78701   | Jack       | Kirby     |
    | stan@marvel.com | 10001   | Stan       | Lee       |
    | joe@simon.com   | 21041   | Joe        | Simon     |
  

  Scenario Outline: Fan signs up and is made active
    When a new fan signs up with email: "<email>", zipcode: "<zipcode>"
    Given a user: "john" exists
    When I login as user: "john"
    And I go to the fans page
    Then I should see "<email>"
  
    Examples:
    | email           | zipcode | first_name | last_name |
    | jack@kirby.com  | 78701   | Jack       | Kirby     |
    | stan@marvel.com | 10001   | Stan       | Lee       |
    | joe@simon.com   | 21041   | Joe        | Simon     |
    
    