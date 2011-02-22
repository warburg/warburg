class AddPermalinkToCdbLocation < ActiveRecord::Migration
  def self.up
    add_column :cdb_locations, :permalink, :string
  end

  def self.down
    remove_column :cdb_locations, :permalink
  end
end
