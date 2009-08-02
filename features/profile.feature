Feature: Manage global settings
  In order to customize the website
  As an administrator
  I want to edit the profile settings
  
  Background:
    Given a global setting exists
    Given a user: "john" exists
    
  Scenario: Settings page requires me to be signed in
    When I go to the profile page
    Then I should be on the login page
    When I login as user: "john"
    When I go to the homepage
    And I follow "Profile"
    Then I should be on the profile page
  
  Scenario: Basic profile section has all the content it should
    When I login as user: "john"
    And I go to the profile page
    Then I should see "Edit Profile"
    And I should see "Artist name"
    And I should see "Website title"
    And I should see "Composer"
    And I should see "Contact email"
    And I should see "Administrative email"
    And I should see "Website URL"
    And I should see "Mailing list announcement tag"
    And I should see "Mailing list header"
    And I should see "Mailing list footer"
    
  Scenario: Social networks section has all the content it should
    When I login as user: "john"
    And I go to the profile page
    Then I should see "Your social networks"
    And I should see "Facebook"
    And I should see "MySpace"
    And I should see "YouTube"
    And I should see "Featured playlist"
    And I should see "Default video format"
    And I should see "Twitter"
    And I should see "Twitter password"
    
  Scenario: Miscellaneous section has all the content it should
    When I login as user: "john"
    And I go to the profile page
    And I should see "Captcha security settings"
    And I should see "Songs host"
    And I should see "Header"
    And I should see "Footer"

  Scenario Outline: User changes some basic settings
    When I login as user: "john"
    And I go to the profile page
    When I fill in "Artist name" with "<artist_name>"
    And I fill in "Website title" with "<website_title>"
    And I fill in "Composer" with "<composer>"
    And I press "Update"
    Then I should see "Settings were successfully updated."
    And the "Artist name" field should contain "<artist_name>"
    And the "Website title" field should contain "<website_title>"
    And the "Composer" field should contain "<composer>"
    
    Examples:
    | artist_name              | website_title                            | composer           |
    | The Beatles              | Home of the Fab Four                     | Lennon/McCartney   |
    | Pop Will Eat Itself      | Time to get ugly!                        | Vestan Pance       |
    | World Racketeering Squad | Rock and roll pop music from the future! | J.Coleman/R.Oliver |

  Scenario Outline: User changes some email settings with valid emails
    When I login as user: "john"
    And I go to the profile page
    And I fill in "Contact email" with "<contact_email>"
    And I fill in "Administrative email" with "<admin_email>"
    And I press "Update"
    Then I should see "Settings were successfully updated."
    And the "Contact email" field should contain "<contact_email>"
    And the "Administrative email" field should contain "<admin_email>"
    
    Examples:
    | contact_email | admin_email |
    | brian@nems.co.uk | eggman@thebeatles.com |
    | clint@pweination.org | clint@pweination.org |
    | wrs@weracketeer.com | isaac@weracketeer.com |
    
    
  Scenario Outline: User changes some email settings with invalid emails
    When I login as user: "john"
    And I go to the profile page
    And I fill in "Contact email" with "<contact_email>"
    And I fill in "Administrative email" with "<admin_email>"
    And I press "Update"
    Then I should see "Email is invalid"
    And the "Contact email" field should contain "<contact_email>"
    And the "Administrative email" field should contain "<admin_email>"
    
    Examples:
    | contact_email | admin_email |
    | brian@nems.co | eggman-thebeatles.com |
    | clintpweination.org | clint@pweination.zorg |
    | wrsweracketeer.com | isaac@weracketeer!com |

  
  Scenario Outline: User changes website URL with valid urls
    When I login as user: "john"
    And I go to the profile page
    And I fill in "Website URL" with "<url>"
    And I press "Update"
    Then I should see "Settings were successfully updated."
  
    Examples:
    | url |
    | www.thebeatles.com |
    | pweination.org |
    | www.weracketeer.com |
    
  # TODO: validate format of URL. (#55)
  # Scenario Outline: 
  #   When I login as user: "john"
  #   And I go to the profile page
  #   And I fill in "Website URL" with "<url>"
  #   And I press "Update"
  #   Then I should see "Url is invalid"
  # 
  #   Examples:
  #   | url |
  #   | wwwthebeatlescom |
  #   | pweinationzorg |
  #   | wwwweracketeer!com |

  
  Scenario Outline: User changes mailing list settings
    When I login as user: "john"
    And I go to the profile page
    And I fill in "Mailing list announcement tag" with "<tag>"
    And I fill in "Mailing list header" with "<header>"
    And I fill in "Mailing list footer" with "<footer>"
    And I press "Update"
    Then I should see "Settings were successfully updated."
    And the "Mailing list announcement tag" field should contain "<tag>"
    And the "Mailing list header" field should contain "<header>"
    And the "Mailing list footer" field should contain "<footer>"
    
    Examples:
    | tag     | header                  | footer                                                  |
    | BEATLES | Hello from The Beatles! | You say hello I say goodbye...                          |
    | PWEI    | All feet on heat!       | Time to get ugly!                                       |
    | WRS     | Greetings,              | You are subscribed to our mailing list. You're awesome. |

  
  Scenario: User changes social networking settings
    When I login as user: "john"
    And I go to the profile page
    When I fill in "Facebook" with "www.facebook.com"
    And I fill in "MySpace" with "myspacer"
    And I fill in "YouTube" with "youtuber"
    And I fill in "Featured playlist" with "playlist123"
    And I choose "Standard"
    And I fill in "Twitter" with "twitterer"
    And I fill in "Twitter password" with "password"
    And I press "Update"
    Then I should see "Settings were successfully updated."
    And the "Facebook" field should contain "www.facebook.com"
    And the "MySpace" field should contain "myspacer"
    And the "YouTube" field should contain "youtuber"
    And the "Featured playlist" field should contain "playlist123"
    And the "Standard" checkbox should be checked
    And the "Widescreen" checkbox should not be checked
    And the "Twitter" field should contain "twitterer"
    And the "Twitter password" field should contain "password"
    
  
  Scenario: User changes some miscellaneous settings
    When I login as user: "john"
    And I go to the profile page
    And I check "to join the mailing list"
    And I check "to post comments"
    And I fill in "Songs host" with "www.bandcamp.com"
    And I fill in "Header" with "This is the header."
    And I fill in "Footer" with "This is the footer."
    And I press "Update"
    Then I should see "Settings were successfully updated."
    And the "to join the mailing list" checkbox should be checked
    And the "to post comments" checkbox should be checked
    And the "Songs host" field should contain "www.bandcamp.com"
    And the "Header" field should contain "This is the header."
    And the "Footer" field should contain "This is the footer."
    
  
  
    
    