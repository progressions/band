When %r{^I login as #{capture_model}$} do |user_name|
  user = model(user_name)
  When "I am on the login page"
  And "I fill in \"Email address\" with \"#{user.email}\""
  And "I fill in \"Password\" with \"password\""
  And "I press \"Log in\""
  And "I should see \"Logged in successfully as #{user.email}\""
end
