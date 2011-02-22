class CreateCdbEvents < ActiveRecord::Migration
  def self.up
    create_table :cdb_events do |t|
      t.integer :cdb_production_id
      t.integer :cdb_location_id
      t.string :cdbid

      t.timestamps
    end
  end

  def self.down
    drop_table :cdb_events
  end
end
