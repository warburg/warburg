class AddVisibilityToSeasons < ActiveRecord::Migration
  def self.up
    add_column :seasons, :visible, :boolean, :default => false
  end

  def self.down
    remove_column :seasons, :visible
  end
end
