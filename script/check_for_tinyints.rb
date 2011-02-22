#!/usr/bin/env ruby
require File.dirname(__FILE__) + '/../config/boot'
require File.dirname(__FILE__) + '/../config/environment'

basedir = File.dirname(__FILE__) + '/../app/models/old'
Dir.new(basedir).entries.each do |filename|
  if filename.size > 2
    clazz = eval("Old::#{filename[0..-4].camelize}")
    clazz.columns.each do |column|
      if column.sql_type[0..6] == 'tinyint'
        puts "Alter table VTi2000.dbo.#{clazz.table_name} alter column #{column.name} int;"
      end
    end
  end
end