class AddPermalinkToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :permalink, :string
    add_column :person_versions, :permalink, :string
  end

  def self.down
    remove_column :person_versions, :permalink
    remove_column :people, :permalink
  end
end
