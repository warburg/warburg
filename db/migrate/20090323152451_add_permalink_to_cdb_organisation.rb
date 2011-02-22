class AddPermalinkToCdbOrganisation < ActiveRecord::Migration
  def self.up
    add_column :cdb_organisations, :permalink, :string
  end

  def self.down
    remove_column :cdb_organisations, :permalink
  end
end
