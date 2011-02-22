class CreateCdbParentEvents < ActiveRecord::Migration
  def self.up
    create_table :cdb_parent_events do |t|
      t.integer :cdb_event_id
      t.string :cdbid
      t.string :externalid

      t.timestamps
    end
  end

  def self.down
    drop_table :cdb_parent_events
  end
end
