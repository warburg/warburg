class AddVisibleFields < ActiveRecord::Migration
  def self.up
      add_column :productions, :visible, :boolean, :default => false
      add_column :production_versions, :visible, :boolean, :default => false
      add_column :shows, :visible, :boolean, :default => false
      add_column :relationships, :visible, :boolean, :default => true
    end

    def self.down
      remove_column :productions, :visible
      remove_column :production_versions, :visible
      remove_column :shows, :visible
      remove_column :relationships, :visible
  end
end
