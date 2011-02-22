class AddNameToPersonVersion < ActiveRecord::Migration
  def self.up
    add_column :person_versions, :name, :string
  end

  def self.down
    remove_column :person_versions, :name
  end
end
