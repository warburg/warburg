# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = true

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false

# Don't care if the mailer can't send
config.action_mailer.raise_delivery_errors = false

config.log_level = :info

config.gem 'dbi', :version => '0.4.1'
config.gem 'dbd-odbc', :version => '0.2.4', :lib => 'dbd/ODBC'
config.gem 'activerecord-sqlserver-adapter', :source => 'http://gems.github.com' #, :lib => 'rails-sqlserver/2000-2005-adapter'

ActionMailer::Base.perform_deliveries = false
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :domain => "mydomain.net",
  :address => "localhost",
  :port => 2525,
}
