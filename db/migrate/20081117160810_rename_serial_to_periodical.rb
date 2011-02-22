class RenameSerialToPeriodical < ActiveRecord::Migration
  def self.up
    rename_table :serials, :periodicals 
    rename_column :periodicals, :serial_note, :periodical_note
  end

  def self.down
    rename_column :periodicals, :periodical_note, :serial_note
    rename_table :periodicals, :serials
  end
end
