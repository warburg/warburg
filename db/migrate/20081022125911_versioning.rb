class Versioning < ActiveRecord::Migration
  def self.up
    Person.create_versioned_table
    add_column :people, :lock_version, :integer, :default => 0
    Person.update_all("lock_version = 0")
    Organisation.create_versioned_table
    add_column :organisations, :lock_version, :integer, :default => 0
    Organisation.update_all("lock_version = 0")
  end

  def self.down
    remove_column :organisations, :lock_version
    Organisation.drop_versioned_table
    remove_column :people, :lock_version
    Person.drop_versioned_table
  end
end
