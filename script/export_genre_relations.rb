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
OUT_BASE = RAILS_ROOT



def handle(table, id_column)
  conn = Old::MasterPersoon.connection
  out_name = OUT_BASE + "/#{table}_export.csv"
  a = conn.select_all("select aot.#{id_column} as id, t.ProductieGenreID from #{table} aot, Trefwoorden t where aot.TrefwoordId = t.TrefwoordId and t.ProductieGenreID is not null")
  FasterCSV.open(out_name, 'w', {:col_sep => SEPARATOR, :headers => true}) do |csv|
    csv << [id_column, 'ProductieGenreID']
    a.each do |row|
      csv << [row['id'], row['ProductieGenreID']]
    end
  end
end

handle("DocuOverTrefwoorden", "DocuId")
handle("IcoOverTrefwoorden", "IcoTitelId")
handle("TrefwoordenBijTijdschrift", "TijdschriftID")
handle("VerwervingOverTrefwoorden", "VerwervingId")


