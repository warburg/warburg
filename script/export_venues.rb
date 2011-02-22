#!/usr/bin/env ruby
require 'rubygems'
require 'fastercsv'

RAILS_ENV = ARGV[0] || 'development'

require File.dirname(__FILE__) + '/../config/boot'
require File.dirname(__FILE__) + '/../config/environment'

HOST = 'http://data.vti.be'
SEPARATOR = ';'
out_name = File.dirname(__FILE__) + '/../ftpexchange/vti_venues.csv'

def cached_slug_for(item)
  "#{HOST}/#{item.class.name.tableize}/#{item.cached_slug}"
end

def handle(clazz, csv)
  count = 0
  clazz.find_each(:conditions => {:country_id => Country.find_by_iso_code("BE").id}) do |item|
    line = [item.name, item.address, item.postal_code, item.city, item.country.iso_code, item.temporary_location, item.address_manager, item.phone, item.fax, item.default_start_hour, item.email, item.url, cached_slug_for(item)]
    count += 1
    if count % 1000 == 0
      puts "Handled #{count} #{clazz.name.pluralize} so far."
    end
    csv << line.collect{|f| escape(f)}
  end
  puts "Handled #{count} #{clazz.name.pluralize} in total."
end

def escape(string)
  string.nil? ? '' : string.to_s.gsub(/#{SEPARATOR}/, "\\#{SEPARATOR}").gsub(/\n/, ' ').gsub(/\r/, '')  
end

fields = %w(name address postal_code city country temporary_location address_manager phone fax default_start_hour email url cached_slug)


FasterCSV.open(out_name, 'w', {:col_sep => SEPARATOR, :headers => true}) do |csv|
  csv << fields
  handle(Venue, csv)
end




