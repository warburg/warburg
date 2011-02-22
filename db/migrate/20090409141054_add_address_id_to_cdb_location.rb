class AddAddressIdToCdbLocation < ActiveRecord::Migration
  def self.up
    add_column :cdb_addresses, :cdb_location_id, :integer
  end

  def self.down
    remove_column :cdb_addresses, :cdb_location_id
  end
end
