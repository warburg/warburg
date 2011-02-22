class AddGisIdToCdbPhysicalAddress < ActiveRecord::Migration
  def self.up
    add_column :cdb_physical_addresses, :cdb_gis_id, :integer
  end

  def self.down
    remove_column :cdb_physical_addresses, :cdb_gis_id
  end
end
