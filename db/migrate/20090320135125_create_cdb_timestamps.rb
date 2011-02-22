class CreateCdbTimestamps < ActiveRecord::Migration
  def self.up
    create_table :cdb_timestamps do |t|
      t.datetime :start
      t.integer :event_id

      t.timestamps
    end
  end

  def self.down
    drop_table :cdb_timestamps
  end
end
