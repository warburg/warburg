class CreateCdbLocations < ActiveRecord::Migration
  def self.up
    create_table :cdb_locations do |t|
      t.string :city
      t.integer :country_id
      t.string :street
      t.string :zipcode
      t.string :label

      t.timestamps
    end
  end

  def self.down
    drop_table :cdb_locations
  end
end
