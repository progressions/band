@wip
Feature: Create and edit blog entries
  In order to express myself to the audience of the site
  As a user
  I want to create and edit blog posts
  
  Background:
    Given a global setting exists
    Given a user: "paul" exists


  Scenario Outline: Create blog posts
    When I login as user: "paul"
    And I go to the homepage
    Then I should see "Blog"
    When I go to the new blog page
    Then I should see "New Blog"
    When I fill in "Title" with "<title>"
    And I fill in "blog__body_editor" with "<body>"
    And I press "Create"
    Then I should see "Blog was successfully created."
    When I go to the homepage
    Then I should see "<title>"
    And I should see "<body>"
    
    Examples:
    | title | body |
    | This is a blog | This is a blog for reals! |
    | I like pie  | That's the thing about pie, I like it. |
    | Michelle, ma belle | Sont des mots qui vont tres bien ensemble |
  
