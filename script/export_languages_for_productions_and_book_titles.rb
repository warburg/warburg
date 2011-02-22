#!/usr/bin/env ruby
#
#
# Lighthouse ticket 481
# https://10to1.lighthouseapp.com/projects/18110-vti/tickets/481-producties-taal-moet-gemigreerd-worden#ticket-481-4

require 'rubygems'
require 'fastercsv'

RAILS_ENV = ARGV[0] || 'development'

require File.dirname(__FILE__) + '/../config/boot'
require File.dirname(__FILE__) + '/../config/environment'

SEPARATOR = ';'
OUT_BASE = RAILS_ROOT

def handle(old_table, id_column)
  conn = Old::MasterPersoon.connection
  out_name = OUT_BASE + "/#{old_table.underscore}_export.csv"
  a = conn.select_all("select #{id_column}, IsoTaalcode from #{old_table}")
  FasterCSV.open(out_name, 'w', {:col_sep => SEPARATOR, :headers => true}) do |csv|
    csv << [id_column, 'IsoTaalcode']
    a.each do |row|
      csv << [row[id_column], row['IsoTaalcode']]
    end
  end
end

handle("ProductiesTalen", 'ProductieId')
handle("BoekTitelTaalcode", "BoekTitelId")




