class CreateCdbCategoryCdbEvents < ActiveRecord::Migration
  def self.up
    create_table :cdb_category_cdb_events do |t|
      t.integer :cdb_category_id
      t.integer :cdb_event_id

      t.timestamps
    end
  end

  def self.down
    drop_table :cdb_category_cdb_events
  end
end
