class CreateCdbVirtualAddresses < ActiveRecord::Migration
  def self.up
    create_table :cdb_virtual_addresses do |t|
      t.integer :cdb_address_id
      t.string :title, :limit => 1500

      t.timestamps
    end
  end

  def self.down
    drop_table :cdb_virtual_addresses
  end
end
