# Sets up the Rails environment for Cucumber
ENV["RAILS_ENV"] ||= "cucumber"
require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')
require 'cucumber/rails/world'
require 'email_spec/cucumber'
# require 'database_cleaner'  
require 'spec/rails'
require 'cucumber/rails/rspec'

DatabaseCleaner.strategy = :truncation

# http://www.brynary.com/2009/2/3/cucumber-step-definition-tip-stubbing-time
require 'spec/mocks'

require "#{Rails.root}/spec/factories"

# Comment out the next line if you don't want Cucumber Unicode support
require 'cucumber/formatter/unicode'

# Comment out the next line if you don't want transactions to
# open/roll back around each scenario
# Cucumber::Rails.use_transactional_fixtures

# Comment out the next line if you want Rails' own error handling
# (e.g. rescue_action_in_public / rescue_responses / rescue_from)
Cucumber::Rails.bypass_rescue

require 'webrat'
require 'cucumber/webrat/table_locator' # Lets you do table.diff!(table_at('#my_table').to_a)

# Webrat.configure do |config|
#   config.mode = :rails
# end

Webrat.configure do |config|
  config.mode = :selenium

  # optional:

  # config.application_port = 4567 # defaults to 3001. Avoid Selenium’s default port, 4444
end

require 'cucumber/rails/rspec'
require 'webrat/core/matchers'
require 'pickle/world'
# Example of configuring pickle:
#
# Pickle.configure do |config|
#   config.adapters = [:machinist]
#   config.map 'I', 'myself', 'me', 'my', :to => 'user: "me"'
# end
require 'pickle/path/world'

# this is necessary to have webrat "wait_for" the response body to be available
# when writing steps that match against the response body returned by selenium
World(Webrat::Selenium::Matchers)


Before do
  DatabaseCleaner.clean
    
  # http://www.brynary.com/2009/2/3/cucumber-step-definition-tip-stubbing-time
  $rspec_mocks ||= Spec::Mocks::Space.new

  def current_user
    controller.send(:current_user)
  end

  # bypass delayed_job and do it now
  class Mailer
    def self.send_later(*args)
      send(*args)
    end
  end
  
  class Mail
    def send_later(*args)
      send(*args)
    end
  end
end

After do
  # http://www.brynary.com/2009/2/3/cucumber-step-definition-tip-stubbing-time
  begin
    $rspec_mocks.verify_all
  ensure
    $rspec_mocks.reset_all
  end
end  

