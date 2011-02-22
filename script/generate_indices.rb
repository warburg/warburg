#!/usr/bin/env ruby
# encoding: utf-8

RAILS_ENV = ARGV[0] || 'migration_test'

require File.dirname(__FILE__) + '/../config/boot'
require File.dirname(__FILE__) + '/../config/environment'


def generate_indices(clazz)
  puts clazz.name
  clazz.find_each{|o|o.generate_indices}
end

[ArchivePart, Article, AudioVideoTitle, BookTitle, Ephemerum, IcoTitle, PressCutting].each{|cl| generate_indices(cl)}