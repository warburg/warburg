class MakeCdbEventsMultiLingual < ActiveRecord::Migration
  def self.up
    remove_column :cdb_events, :language_id
    create_table :cdb_events_languages do |t|
      t.integer :cdb_event_id
      t.integer :language_id
    end
  end

  def self.down
    add_column :cdb_events, :language_id, :integer
    drop_table :cdb_events_languages
  end
end
