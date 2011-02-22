#!/usr/bin/env ruby
RAILS_ENV = ARGV[0] || 'migration_test'

TARGET_ENV = ARGV[1]

puts "Dumping DB from environment #{RAILS_ENV} to #{TARGET_ENV}"

require File.dirname(__FILE__) + '/../config/boot'
require File.dirname(__FILE__) + '/../config/environment'

# script/migrate_db.rb mirror_production
# pg_dump -n development -v -D -f "vti.sql" vti
# pg_dump -n production vti | psql -h aluminium.openminds.be -U vti

class Dumper
  def run
    @start = Time.now
    puts "Started dump at #{@start}"
    @src_name = "#{RAILS_ROOT}/vti.dmp"
    @out_name = "#{RAILS_ROOT}/vti2.dmp"
    #@create_old_id_name = "#{RAILS_ROOT}/vti_create_old_id.dmp"
    #@remove_old_id_name = "#{RAILS_ROOT}/vti_remove_old_id.dmp"
    
    @db_config = Rails.configuration.database_configuration[RAILS_ENV]

    @schema = @db_config['schema_search_path']
    @schema = @schema.split(',').reject {|schema| schema == 'public'}.join(',')
    @password = @db_config['password']

    # dump_db
    # 
    # rewrite_dump

    upload_dump

    # FileUtils.rm(src_name)
    # FileUtils.rm(out_name)
    # FileUtils.rm(tables_name)
    puts "Finished in #{Time.now - @start}s"
  end

  private
  def dump_db
    `export PGPASSWORD=#{@password};pg_dump -f #{@src_name} -F p -b --schema #{@schema} #{@db_config['database']}`

    puts "pg_dump finished at #{Time.now}"
  end

  def rewrite_dump
    @out = File.new(@out_name, 'w')
    #@create_old_id = File.new(@create_old_id_name, 'w')
    #@remove_old_id = File.new(@remove_old_id_name, 'w')
    #
    #@create_old_id << "SET client_encoding = 'SQL_ASCII';"
    #@create_old_id << "SET check_function_bodies = false;"
    #@create_old_id << "SET client_min_messages = warning;"
    #@create_old_id << "SET escape_string_warning = off;"
    #@create_old_id << "SET search_path = #{@schema}, pg_catalog;SET default_tablespace = '';"
    #@create_old_id << "SET default_with_oids = false;"
    #
    #@remove_old_id << "SET client_encoding = 'SQL_ASCII';"
    #@remove_old_id << "SET check_function_bodies = false;"
    #@remove_old_id << "SET client_min_messages = warning;"
    #@remove_old_id << "SET escape_string_warning = off;"
    #@remove_old_id << "SET search_path = #{@schema}, pg_catalog;SET default_tablespace = '';"
    #@remove_old_id << "SET default_with_oids = false;"


    in_creation = false

    File.new(@src_name).each do |line|
      if line =~ /.*SET search_path = #{@schema}, pg_catalog;.*/
        line= 'SET search_path = production, pg_catalog;'
      end

      if line =~ /.*\s#{@schema}\.\S.*/
        line.gsub!(/\s#{@schema}\./, ' production.')
        puts line
      end

      if line =~ /.*OWNER TO .*/
        line = nil
      end

      if line =~ /CREATE TABLE.*/
        unless line =~ /.*open_id_authentication.*/
          #@create_old_id << line.gsub(/CREATE TABLE (\S+).*/, "ALTER TABLE \\1 ADD old_id INTEGER;")
          #@remove_old_id << line.gsub(/CREATE TABLE (\S+).*/, "ALTER TABLE \\1 DROP old_id;")
          @out << line.gsub(/CREATE TABLE (\S+).*/, "DELETE FROM \\1;")
          puts "Deleting table #{line.gsub(/CREATE TABLE (\S+).*/, "\\1")}"
        end
        in_creation = true
      end

      if line =~ /CREATE VIEW.*/
        in_creation = true
      end

      if line =~ /CREATE SEQUENCE.*/
        in_creation = true
      end

      if line =~ /ALTER SEQUENCE.*/
        line = nil
      end

      if line =~ /ALTER TABLE.*/
        line = nil
      end

      if line =~ /CREATE UNIQUE INDEX.*/
        line = nil
      end

      if line =~ /CREATE INDEX.*/
        line = nil
      end

      if line =~ /.*ADD CONSTRAINT.*/
        line = nil
      end

      if line =~ /.*standard_conforming_strings = off;.*/ ||
          line =~ /.*CREATE SCHEMA #{@schema};.*/ ||
          line =~ /.*ALTER SCHEMA.*/ ||
          line =~ /^--.*/
        line = nil
      end

      if line =~ /COPY .*open_id_authentication.*/
        in_creation = true
        puts line
      end

      if line =~ /COPY .*/
        puts line
      end

      if line =~ /.*open_id_authentication.*/
        line = nil
      end

      @out << line unless (in_creation || line.nil? || line.blank?)
      in_creation = false if line =~ /(.*;|\\\.)/
    end

    @out.close
    #@create_old_id.close
    #@remove_old_id.close

    puts "#{@out_name} created at #{Time.now}"
  end

  def upload_dump
    target_db_config = Rails.configuration.database_configuration[TARGET_ENV]
    host = target_db_config['host']
    username = target_db_config['username']
    db = target_db_config['database']
    pwd = target_db_config['password']
    #puts 'creating old_id ...'
    #`export PGPASSWORD=#{pwd};psql -h #{host} -U #{username} -f #{@create_old_id_name} -d #{db}`
    #puts 'created old_id'
    puts 'uploading db...'
    `export PGPASSWORD=#{pwd};psql -h #{host} -U #{username} -f #{@out_name} -d #{db}`
    puts 'uploaded db'
    #puts 'removing old_id...'
    #`export PGPASSWORD=#{pwd};psql -h #{host} -U #{username} -f #{@remove_old_id_name} -d #{db}`
    #puts 'removed old_id'
  end

end

Dumper.new.run
