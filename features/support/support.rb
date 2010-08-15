require 'spec/rails'
require 'cucumber/rails/rspec'

# http://www.brynary.com/2009/2/3/cucumber-step-definition-tip-stubbing-time
require 'spec/mocks'

require "#{Rails.root}/spec/factories"
require 'email_spec/cucumber'

require 'pickle/world'
# Example of configuring pickle:
#
# Pickle.configure do |config|
#   config.adapters = [:machinist]
#   config.map 'I', 'myself', 'me', 'my', :to => 'user: "me"'
# end
require 'pickle/path/world'
# require 'pickle/email/world'
 
# This code will be run each time you run your specs.
require 'cucumber/rails/world'

# Comment out the next line if you don't want transactions to
# open/roll back around each scenario
#Cucumber::Rails.use_transactional_fixtures

# Comment out the next line if you want Rails' own error handling
# (e.g. rescue_action_in_public / rescue_responses / rescue_from)
Cucumber::Rails.bypass_rescue if Cucumber::Rails.respond_to?(:bypass_rescue)

Before do
  class Object
    def self.send_later(*args)
      send(*args)
    end
    def send_later(*args)
      send(*args)
    end
  end
end