class AddViewFields < ActiveRecord::Migration
  def self.up
    add_column :people, :views, :integer
    add_column :people, :viewed_at, :datetime
    add_column :person_versions, :views, :integer
    add_column :person_versions, :viewed_at, :datetime    
  end

  def self.down
    remove_column :people, :views
    remove_column :people, :viewed_at
    remove_column :person_versions, :views
    remove_column :person_versions, :viewed_at
  end
end
