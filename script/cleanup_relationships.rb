#!/usr/bin/env ruby
# encoding: utf-8

# check for relationships that have nil on either side and delete them.

RAILS_ENV = ARGV[0] || 'development'

require File.dirname(__FILE__) + '/../config/boot'
require File.dirname(__FILE__) + '/../config/environment'

def class_exists?(class_name)
  klass = Module.const_get(class_name)
  return klass.is_a?(Class)
rescue NameError
  return false
end

def product(x, y, z)
    result = []
    x.each do |r|
        y.each do |s|
            z.each do |t|
                result << [r, s, t]
            end
        end
    end
    result
end


documents = [Article, Production, ArchivePart, AudioVideoTitle, BookTitle, Ephemerum, IcoTitle, Organisation, Periodical, PressCutting, Warehouse]

voegwoorden = %w(About By)

actors = [Person, Genre, Organisation, Production]

product(documents, voegwoorden, actors).each do |prod|
  d=prod[0]
  v=prod[1]
  a=prod[2]
  
  class_name = "#{d.name}#{v}#{a.name}"
  
  if class_exists?(class_name)
    puts class_name
    conditions = "#{d.name.underscore}_id is null or #{a.name.underscore}_id is null"
    puts eval(class_name).delete_all(conditions)
  end

  # cl.find_each(:conditions => conditions){|p|p.permalink = nil; p.save!}
end

