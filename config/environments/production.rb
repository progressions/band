# Settings specified here will take precedence over those in config/environment.rb

# The production environment is meant for finished, "live" apps.
# Code is not reloaded between requests
config.cache_classes = true

# Use a different logger for distributed setups
# config.logger = SyslogLogger.new

# Full error reports are disabled and caching is turned on
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = true

config.action_controller.cache_store = [:file_store, "#{RAILS_ROOT}/tmp/cache"]

# Enable serving of images, stylesheets, and javascripts from an asset server
# config.action_controller.asset_host                  = "http://assets.example.com"

# Disable delivery errors, bad email addresses will be ignored
# config.action_mailer.raise_delivery_errors = false

# Don't care if the mailer can't send
config.action_mailer.raise_delivery_errors = false

APP_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/config.yml")['mailer']

config.action_mailer.delivery_method = :smtp

config.action_mailer.smtp_settings = {
  :address  => APP_CONFIG['address'],
  :port  => APP_CONFIG['port'], 
  :domain  => APP_CONFIG['domain'],
  :user_name  => APP_CONFIG['user_name'],
  :password  => APP_CONFIG['password'],
  :authentication  => :login
}

=begin
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
  :address  => "localhost",
  :port  => 25, 
  :domain  => "www.worldracketeeringsquad.com",
  :user_name  => "mail@example.com",
  :password  => "foobar",
  :authentication  => :login
}
=end
