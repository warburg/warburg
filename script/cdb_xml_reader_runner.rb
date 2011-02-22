#!/usr/bin/env ruby
RAILS_ENV = ARGV[0] || 'development'

require File.dirname(__FILE__) + '/../config/boot'
require File.dirname(__FILE__) + '/../config/environment'

# reader = CdbXmlReader.new(File.dirname(__FILE__) + "/../doc/Jan2008.xml", true)
# reader = CdbXmlReader.new(File.dirname(__FILE__) + "/../doc/cdbxmlsample.xml", true)
# reader = CdbXmlReader.new(File.dirname(__FILE__) + "/../data/Jan.xml", true)
# reader = CdbXmlReader.new("../doc/cdbxmlsample_8KB.xml", true)

def header(msg)
  char = '#'
  full = "#{char} #{msg} #{char}"
  puts
  puts full.gsub(/./, char)
  puts full
  puts full.gsub(/./, char)
end
  
Dir.new(File.dirname(__FILE__) + '/../data/').entries.each do |file|
  if file.ends_with?('.xml')
    full_filename = File.dirname(__FILE__) + "/../data/" + file
    msg = "Processing #{File.expand_path(full_filename)}"
    header(msg)
    reader = CdbXmlReader.new(full_filename, true)
    reader.process
  end
end

