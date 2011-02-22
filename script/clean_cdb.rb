#!/usr/bin/env ruby
RAILS_ENV = ARGV[0] || 'development'

require File.dirname(__FILE__) + '/../config/boot'
require File.dirname(__FILE__) + '/../config/environment'

Dir.new(File.dirname(__FILE__) + '/../app/models').entries.each do |file|
  if file.starts_with?('cdb_')
    clazz = eval(file[0..-4].camelize)
    puts clazz
    clazz.delete_all
    letters = NavigationLetters.find_by_classname(clazz.name)
    letters.delete if letters
  end
end
