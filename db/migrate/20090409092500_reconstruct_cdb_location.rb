class ReconstructCdbLocation < ActiveRecord::Migration
  def self.up
    drop_table :cdb_locations
    create_table :cdb_locations do |t|
      t.integer :cdb_address_id
      t.integer :cdb_actor_id
      t.integer :cdb_event_id
      
      t.timestamps
    end
    
  end

  def self.down
    drop_table :cdb_locations
    create_table :cdb_locations do |t|
      t.string :city
      t.integer :country_id
      t.string :street
      t.string :zipcode
      t.string :label

      t.timestamps
    end
  end
end
