#!/usr/bin/env ruby
# encoding: utf-8

RAILS_ENV = ARGV[0] || 'migration_test'

require File.dirname(__FILE__) + '/../config/boot'
require File.dirname(__FILE__) + '/../config/environment'

def puts_count(clazz)
  puts "To do: #{clazz.count}"
end

def generate_permalink(clazz)
  puts clazz.name
  puts_count(clazz)
  clazz.find_each(:conditions => 'cached_slug is null') do |o|
    
    clazz.connection.
    o.save!
    if (o.id % 100) == 0
      puts_count(clazz)
    end
  end
end

def go
  [Production, Person, PressCutting,  Season, Venue, Warehouse, Organisation, ArchivePart, Article,
   AudioVideoMedium, AudioVideoTitle, BookCopy, BookTitle, Donation,
   Ephemerum, IcoTitle, 
   Periodical, PeriodicalIssue].each{|cl| generate_permalink(cl)}
end

update production.seasons set cached_slug = permalink;
update production.venues set cached_slug = permalink;
update production.warehouses set cached_slug = permalink;
update production.organisations set cached_slug = permalink;

 
