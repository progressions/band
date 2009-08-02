@comments @captcha
Feature: Readers can comment on blog entries
  In order to express myself and communicate with fans of the band
  As an unauthenticated reader of the website
  I want to comment on blog entries
  
  Background:
    Given a global setting exists
    Given a user: "paul" exists
    Given a blog: "hello" exists with user: user "paul", title: "It was 20 years ago today", body: "Sergeant Pepper taught the band to play."
    When I go to the blog: "hello"'s page
  
  Scenario: Everything's where it should be
    Then I should see "It was 20 years ago today"
    And I should see "Sergeant Pepper taught the band to play."
    And I should see "Leave a comment"
    And I should see "Name (required)"
    And I should see "Mail (will not be published) (required)"
    And I should see "Website"
    And I should see "Notify me by email of further comments to this post."

  Scenario Outline: Reader previews a valid comment
    When I fill in "Name" with "<name>"
    And I fill in "Mail" with "<email>"
    And I fill in "Website" with "<website>"
    And I fill in "comment_body" with "<comment>"
    And I press "Preview"
    Then I should see "Previewing comment."
    And the "Name" field should contain "<name>"
    And the "Mail" field should contain "<email>"
    And the "Website" field should contain "<website>"
    And I should see "<comment>"
  
    Examples:
    | name | email | website | comment |
    | Billy Shears | billy@billyshears.com | www.billyshears.com | Hey guys, it's true! |
    | Eleanor Rigby | eleanor23@geocities.com | www.myspace.com/eleanor23 | I remember those days... |
    | Uncle Albert  | albert@handsacrossthewater.com | www.handsacrossthesky.com | Apology accepted. |

  
  Scenario Outline: Reader creates a valid comment
    When I fill in "Name" with "<name>"
    And I fill in "Mail" with "<email>"
    And I fill in "Website" with "<website>"
    And I fill in "comment_body" with "<comment>"
    And I press "Create"
    Then I should not see "Previewing comment."
    And I should see "Comment was successfully created."
    And the "Name" field should contain "<name>"
    And the "Mail" field should contain "<email>"
    And the "Website" field should contain "<website>"
    And I should see "<comment>"
    And I should not see "edit"
    And I should not see "delete"
    And I should see "posted on"
  
    Examples:
    | name | email | website | comment |
    | Billy Shears | billy@billyshears.com | www.billyshears.com | Hey guys, it's true! |
    | Eleanor Rigby | eleanor23@geocities.com | www.myspace.com/eleanor23 | I remember those days... |
    | Uncle Albert  | albert@handsacrossthewater.com | www.handsacrossthesky.com | Apology accepted. |

  
  Scenario Outline: Reader creates a comment with invalid fields
    When I fill in "Name" with ""
    And I fill in "Mail" with ""
    And I fill in "Website" with ""
    And I fill in "comment_body" with ""
    And I press "Create"
    Then I should not see "Comment was successfully created."
    And I should see "Name can't be blank"
    And I should see "Email can't be blank"
    And I should see "Body can't be blank"
    When I fill in "Name" with "<name>"
    And I press "Create"
    Then I should not see "Comment was successfully created."
    And I should see "Email can't be blank"
    And I should see "Body can't be blank"
    When I fill in "Name" with "<name>"
    And I fill in "Mail" with "<email>"
    And I press "Create"
    Then I should not see "Comment was successfully created."
    And I should see "Body can't be blank"
    
    Examples:
    | name          | email                          | comment                  |
    | Billy Shears  | billy@billyshears.com          | Hey guys, it's true!     |
    | Eleanor Rigby | eleanor23@geocities.com        | I remember those days... |
    | Uncle Albert  | albert@handsacrossthewater.com | Apology accepted.        |
  
  
  Scenario Outline: Reader can preview a comment without filling in captcha
    Given a global setting exists with use_captcha_for_comments: true
    When I fill in "Name" with "<name>"
    And I fill in "Mail" with "<email>"
    And I fill in "Website" with "<website>"
    And I fill in "comment_body" with "<comment>"
    And I press "Preview"
    Then I should see "Previewing comment."
    And the "Name" field should contain "<name>"
    And the "Mail" field should contain "<email>"
    And the "Website" field should contain "<website>"
    And I should see "<comment>"
  
    Examples:
    | name | email | website | comment |
    | Billy Shears | billy@billyshears.com | www.billyshears.com | Hey guys, it's true! |
    | Eleanor Rigby | eleanor23@geocities.com | www.myspace.com/eleanor23 | I remember those days... |
    | Uncle Albert  | albert@handsacrossthewater.com | www.handsacrossthesky.com | Apology accepted. |
  
  
  Scenario Outline: Reader creates a valid comment when captcha is required
    Given a global setting exists with use_captcha_for_comments: true
    When I fill in "Name" with "<name>"
    And I fill in "Mail" with "<email>"
    And I fill in "Website" with "<website>"
    And I fill in "comment_body" with "<comment>"
    And I fill in the captcha so it is true
    And I press "Create"
    Then I should not see "Previewing comment."
    And I should see "Comment was successfully created."
    And the "Name" field should contain "<name>"
    And the "Mail" field should contain "<email>"
    And the "Website" field should contain "<website>"
    And I should see "<comment>"
    And I should not see "edit"
    And I should not see "delete"
    And I should see "posted on"
  
    Examples:
    | name | email | website | comment |
    | Billy Shears | billy@billyshears.com | www.billyshears.com | Hey guys, it's true! |
    | Eleanor Rigby | eleanor23@geocities.com | www.myspace.com/eleanor23 | I remember those days... |
    | Uncle Albert  | albert@handsacrossthewater.com | www.handsacrossthesky.com | Apology accepted. |
  
  
  Scenario Outline: Reader fills out invalid captcha when captcha is required
    Given a global setting exists with use_captcha_for_comments: true
    When I fill in "Name" with "<name>"
    And I fill in "Mail" with "<email>"
    And I fill in "Website" with "<website>"
    And I fill in "comment_body" with "<comment>"
    And I fill in the captcha so it is false
    And I press "Create"
    And I should not see "Comment was successfully created."
    And I should see "Captcha response is incorrect, please try again."
  
    Examples:
    | name | email | website | comment |
    | Billy Shears | billy@billyshears.com | www.billyshears.com | Hey guys, it's true! |
    | Eleanor Rigby | eleanor23@geocities.com | www.myspace.com/eleanor23 | I remember those days... |
    | Uncle Albert  | albert@handsacrossthewater.com | www.handsacrossthesky.com | Apology accepted. |
    
  # TODO: Cover the emails that get sent when somebody comments
  # TODO: Cover subscribing and unsubscribing to a blog post's comments
  # TODO: Cover RSS feeds?
  