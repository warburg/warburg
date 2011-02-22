#!/usr/bin/env ruby
# encoding: utf-8

# Check for default permalinks ('3de8ef...') and try to replace them.

RAILS_ENV = ARGV[0] || 'development'

require File.dirname(__FILE__) + '/../config/boot'
require File.dirname(__FILE__) + '/../config/environment'

s = "[0-9a-z]"*40
conditions = ["permalink similar to ?", s]

[Periodical, Organisation, Production, Person].each do |cl|
  puts "#{cl.name}: #{cl.count(:conditions => conditions)}"
  cl.find_each(:conditions => conditions){|p|p.permalink = nil; p.save!}
end
