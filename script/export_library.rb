#!/usr/bin/env ruby
require 'rubygems'
require 'fastercsv'

RAILS_ENV = ARGV[0] || 'development'

require File.dirname(__FILE__) + '/../config/boot'
require File.dirname(__FILE__) + '/../config/environment'

HOST = 'http://data.vti.be'
SEPARATOR = ';'
out_name = File.dirname(__FILE__) + '/../ '

def cached_slug_for(item)
  "#{HOST}/#{item.class.name.tableize}/#{item.cached_slug}"
end

def handle(clazz, csv)
  count = 0
  clazz.find_each do |item|
    line = [item.barcode.to_s, clazz.name.underscore, item.title, cached_slug_for(item)]
    count += 1
    if count % 1000 == 0
      puts "Handled #{count} #{clazz.name.pluralize} so far."
    end
    csv << line.collect{|f| escape(f)}
  end
  puts "Handled #{count} #{clazz.name.pluralize} in total."
end

def escape(string)
  string.nil? ? '' : string.gsub(/#{SEPARATOR}/, "\\#{SEPARATOR}").gsub(/\n/, ' ').gsub(/\r/, '')  
end

FasterCSV.open(out_name, 'w', {:col_sep => SEPARATOR, :headers => true}) do |csv|
  csv << %w(barcode type title cached_slug)
  handle(BookCopy, csv)
  handle(AudioVideoMedium, csv)
  handle(PeriodicalIssue, csv)
end




