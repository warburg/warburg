class RenameEventIdToCdbEventIdInCdbTimestamps < ActiveRecord::Migration
  def self.up
    rename_column :cdb_timestamps, :event_id, :cdb_event_id
  end

  def self.down
    rename_column :cdb_timestamps, :cdb_event_id, :event_id
  end
end
