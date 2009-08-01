When %r{^a new fan signs up with #{capture_fields}$} do |fields|
  params = parse_fields(fields)
  email = params["email"]
  zipcode = params["zipcode"]
  
  And "I am on the home page"
  And "I fill in \"email\" with \"#{email}\""
  And "I fill in \"zip_code\" with \"#{zipcode}\""
  And "I press \"SIGN UP\""
end