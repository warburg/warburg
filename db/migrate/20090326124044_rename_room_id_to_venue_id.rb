class RenameRoomIdToVenueId < ActiveRecord::Migration
  def self.up
    rename_column :shows, :room_id, :venue_id
    rename_column :relationships, :room_id, :venue_id
  end

  def self.down
    rename_column :relationships, :venue_id, :room_id
    rename_column :shows, :venue_id, :room_id
  end
end
