class RenameMagazineToSerial < ActiveRecord::Migration
  def self.up
    rename_table :magazines, :serials
    rename_column :serials, :magazine_note, :serial_note
  end

  def self.down
    rename_column :serials, :serial_note, :magazine_note
    rename_table :serials, :magazines
  end
end
