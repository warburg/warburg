#!/usr/bin/env ruby
#
#
# Lighthouse ticket 370
# https://10to1.lighthouseapp.com/projects/18110/tickets/370-fwd-waar-zijn-de-productiegenres-bij-gemigreerde-producties

require 'rubygems'
require 'fastercsv'

RAILS_ENV = ARGV[0] || 'development'

require File.dirname(__FILE__) + '/../config/boot'
require File.dirname(__FILE__) + '/../config/environment'

SEPARATOR = ';'
OUT_BASE = RAILS_ROOT

def handle
  conn = Old::MasterPersoon.connection
  out_name = OUT_BASE + "/producties_over_genres_export.csv"
  a = conn.select_all("select ProductieId, ProductiesGenreId from ProductiesOverGenres where ProductieId is not null and ProductiesGenreId is not null")
  FasterCSV.open(out_name, 'w', {:col_sep => SEPARATOR, :headers => true}) do |csv|
    csv << ['ProductieId', 'ProductieGenreID']
    a.each do |row|
      csv << [row['ProductieId'], row['ProductiesGenreId']]
    end
  end
end

handle


