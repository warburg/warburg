class CreateCdbAddresses < ActiveRecord::Migration
  def self.up
    create_table :cdb_addresses do |t|
      t.boolean :main
      t.boolean :reservation

      t.timestamps
    end
  end

  def self.down
    drop_table :cdb_addresses
  end
end
