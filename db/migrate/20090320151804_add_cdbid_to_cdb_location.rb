class AddCdbidToCdbLocation < ActiveRecord::Migration
  def self.up
    add_column :cdb_locations, :cdbid, :string
  end

  def self.down
    remove_column :cdb_locations, :cdbid
  end
end
