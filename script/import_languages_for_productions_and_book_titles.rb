#!/usr/bin/env ruby
#
#
# Lighthouse ticket 481
# https://10to1.lighthouseapp.com/projects/18110-vti/tickets/481-producties-taal-moet-gemigreerd-worden#ticket-481-4

require 'rubygems'
require 'fastercsv'

RAILS_ENV = ARGV[0] || 'development'

require File.dirname(__FILE__) + '/../config/boot'
require File.dirname(__FILE__) + '/../config/environment'

SEPARATOR = ';'
IN_BASE = RAILS_ROOT

def get_language(isocode)
  @langs ||= {}
  result = @langs[isocode]
  if result.nil?
    result = Language.find_by_iso_code(isocode)
    @langs[isocode] = result
  end
  result
end

def handle(old_table, new_class)
  puts "*** #{old_table}"
  in_name = IN_BASE + "/#{old_table.underscore}_export.csv"
  relation_name = "#{new_class.name.underscore}_languages"
  relation_class = eval(relation_name.classify)
  FasterCSV.foreach(in_name, {:col_sep => SEPARATOR, :headers => true}) do |row|
    e = new_class.find_by_old_id(row[0])
    language = get_language(row[1])
    
    if e.nil? || language.nil?
      puts row
    else
      r = relation_class.new
      r.language_id = language.id
      r.send("#{new_class.name.underscore}_id=", e.id)
      r.save!
      # puts r.inspect
    end
  end
end

handle("ProductiesTalen", Production)
handle("BoekTitelTaalcode", BookTitle)

