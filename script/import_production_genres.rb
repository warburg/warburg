#!/usr/bin/env ruby
#
#
# Lighthouse ticket 298
# https://10to1.lighthouseapp.com/projects/18110-vti/tickets/298-gedeelte-van-trefwoorden-omvormen-tot-productiegenres

require 'rubygems'
require 'fastercsv'

RAILS_ENV = ARGV[0] || 'development'

require File.dirname(__FILE__) + '/../config/boot'
require File.dirname(__FILE__) + '/../config/environment'

SEPARATOR = ';'
IN_BASE = RAILS_ROOT

def handle(new_class)
  in_name = IN_BASE + "/producties_over_genres_export.csv"
  relation_name = "#{new_class.name.underscore}_about_genres"
  relation_class = eval(relation_name.classify)
  FasterCSV.foreach(in_name, {:col_sep => SEPARATOR, :headers => true}) do |row|
    e = new_class.find_by_old_id(row[0])
    genre = Genre.find_by_old_id(row[1])
    
    if e.nil? || genre.nil?
      puts row
    else
      r = relation_class.new
      r.genre_id = genre.id
      r.send("#{new_class.name.underscore}_id=", e.id)
      r.save!
    end
  end
end

handle(Production)


