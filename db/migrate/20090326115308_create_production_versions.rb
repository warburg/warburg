class CreateProductionVersions < ActiveRecord::Migration
  def self.up
    Production.create_versioned_table
    add_column :productions, :lock_version, :integer, :default => 0
    Production.update_all("lock_version = 0")
  end

  def self.down
    remove_column :productions, :lock_version
    Production.drop_versioned_table
  end
end
