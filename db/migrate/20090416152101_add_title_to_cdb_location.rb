class AddTitleToCdbLocation < ActiveRecord::Migration
  def self.up
    add_column :cdb_locations, :title, :string
  end

  def self.down
    remove_column :cdb_locations, :title
  end
end
