class AddHierarchyToPersonFunction < ActiveRecord::Migration
  def self.up
    add_column :functions, :hierarchy, :string
  end

  def self.down
    remove_column :functions, :hierarchy
  end
end
