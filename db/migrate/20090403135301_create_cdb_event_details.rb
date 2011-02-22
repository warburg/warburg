class CreateCdbEventDetails < ActiveRecord::Migration
  def self.up
    create_table :cdb_event_details do |t|
      t.integer :cdb_event_id
      t.integer :language_id
      t.string :admission
      t.string :calendarsummary
      t.string :estimatedtime
      t.text :longdescription
      t.string :shortdescription, :limit => 600
      t.string :title
      
      t.timestamps
    end
  end

  def self.down
    drop_table :cdb_event_details
  end
end
