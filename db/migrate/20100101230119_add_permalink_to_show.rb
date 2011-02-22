class AddPermalinkToShow < ActiveRecord::Migration
  def self.up
    add_column :shows, :permalink, :string
  end

  def self.down
    remove_column :shows, :permalink
  end
end
