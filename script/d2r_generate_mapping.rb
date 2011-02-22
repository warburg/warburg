#!/usr/bin/env ruby
# encoding: utf-8
RAILS_ENV = ARGV[0] || 'development'

puts "Generating D2R mapping in environment #{RAILS_ENV}"

require File.dirname(__FILE__) + '/../config/boot'
require File.dirname(__FILE__) + '/../config/environment'

@db_config = Rails.configuration.database_configuration[RAILS_ENV]

# @schema = @db_config['schema_search_path']
# @schema = @schema.split(',').reject {|schema| schema == 'public'}.join(',')
@username = @db_config['username']
@username = 'tomklaasen' if @username.blank?
@password = @db_config['password']
@database = @db_config['database']
# @schema = RAILS_ENV

@d2r_dir = "#{RAILS_ROOT}/../d2r-server-0.7"

@outfile = "#{RAILS_ROOT}/data/mapping.n3"


# cd ../../d2r-server-0.6
# generate-mapping -o mapping.n3 -d driver.class.name -u db-user -p db-password jdbc:url:...
# ./generate-mapping -o mapping.n3 -d org.postgresql.Driver -u tomk jdbc:postgresql:vti
command = "#{@d2r_dir}/generate-mapping -o #{@outfile} -d org.postgresql.Driver -u #{@username} -p '#{@password}' -b http://localhost:2020/ jdbc:postgresql:#{@database}"
puts command
`#{command}`


