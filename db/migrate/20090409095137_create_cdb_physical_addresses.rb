class CreateCdbPhysicalAddresses < ActiveRecord::Migration
  def self.up
    create_table :cdb_physical_addresses do |t|
      t.integer :cdb_address_id
      t.integer :cdb_city_id
      t.integer :country_id
      t.string :housenr
      t.integer :cdb_street_id
      t.string :zipcode

      t.timestamps
    end
  end

  def self.down
    drop_table :cdb_physical_addresses
  end
end
