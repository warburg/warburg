class AddContentToCdbCategory < ActiveRecord::Migration
  def self.up
    add_column :cdb_categories, :text, :string
  end

  def self.down
    remove_column :cdb_categories, :text
  end
end
