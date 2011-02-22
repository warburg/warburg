class RenameRoomsToVenues < ActiveRecord::Migration
  def self.up
    rename_table :rooms, :venues
  end

  def self.down
    rename_table :venues, :rooms
  end
end
