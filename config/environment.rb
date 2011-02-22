# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')
#
# require "activesupport"
# require 'active_record_ext'

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.
  # See Rails::Configuration for more options.

  # Skip frameworks you're not going to use. To use Rails without a database
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Specify gems that this application depends on.
  # They can then be installed with "rake gems:install" on new installations.
  # config.gem "bj"
#    config.gem "libxml-ruby"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "aws-s3", :lib => "aws/s3"
  # config.gem 'activerecord-sqlserver-adapter', :source => 'http://gems.rubyonrails.org', :lib => 'active_record/connection_adapters/sqlserver_adapter'
  # config.gem 'ruby-openid'
   # config.gem 'dbi'
  # config.gem 'deprecated'
  # config.gem 'odbc'
  # config.gem 'pg', :version => '0.7.9.2008.10.13'
  # config.gem 'postgres-pr', :version => '0.5.0'
  # config.gem 'postgres', :version => '0.7.9.2008.01.28'
  config.gem "friendly_id"
  config.gem 'barby'
  config.gem 'prawn'
  # config.gem 'dbd-odbc', :version => '0.2.4', :lib => 'dbd/ODBC'
  #config.gem 'activerecord-sqlserver-adapter', :version => '2.2.19'
  config.gem 'ruby-openid', :lib => 'openid'
  config.gem '10to1-crack', :lib => 'crack'
  config.gem 'javan-whenever', :lib => false, :source => 'http://gems.github.com'
  # config.gem 'libxml-ruby', :lib => 'libxml' # Needs native extensions.
  config.gem 'bluecloth'
  config.gem 'hoptoad_notifier'
  config.gem 'thinking-sphinx', :lib => 'thinking_sphinx'
  config.gem 'ts-delayed-delta', :lib => 'thinking_sphinx/deltas/delayed_delta'
  config.gem "eager_record"

  # Only load the plugins named here, in the order given. By default, all plugins
  # in vendor/plugins are loaded in alphabetical order.
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Force all environments to use the same logger level
  # (by default production uses :info, the others :debug)
  # config.log_level = :debug

  # Make Time.zone default to the specified zone, and make Active Record store time values
  # in the database in UTC, and return them converted to the specified local zone.
  # Run "rake -D time" for a list of tasks for finding time zone names. Comment line to use default local time.
  config.time_zone = 'UTC'

  # Your secret key for verifying cookie session data integrity.
  # If you change this key, all old sessions will become invalid!
  # Make sure the secret is at least 30 characters and all random,
  # no regular words or you'll be exposed to dictionary attacks.
  config.action_controller.session = {
    :session_key => '_warburg_session',
    :secret      => 'd8679cf38567fc25c68fd4f71087a8b2dbec730820bbe06787a31a286b6f2d5cd3678bce26102cafa494e2cc07f991d599a35e8f28b236187fe66982f9215901'
  }

  # Use the database for sessions instead of the cookie-based default,
  # which shouldn't be used to store highly confidential information
  # (create the session table with "rake db:sessions:create")
  # config.action_controller.session_store = :active_record_store
  
  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector
  config.active_record.observers = :navigation_letters_observer

end

ERROR_MAILER_TO = "your-email"
ERROR_MAILER_FROM = "your-email"

# OpenID::Util.logger = RAILS_DEFAULT_LOGGER


require 'string_ext'
require 'extend_string'
require 'request_ext'
require 'active_record_visibility'
require 'i18n_ext'
require 'tag_ext'
require "barby/outputter/prawn_outputter"
require "prawn/measurement_extensions"