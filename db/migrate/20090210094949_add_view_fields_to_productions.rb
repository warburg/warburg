class AddViewFieldsToProductions < ActiveRecord::Migration
 def self.up
    add_column :productions, :views, :integer
    add_column :productions, :viewed_at, :datetime
  end

  def self.down
    remove_column :productions, :views
    remove_column :productions, :viewed_at
  end
end
