class AddPermalinkToTags < ActiveRecord::Migration
  def self.up
    add_column :tags, :permalink, :string
  end

  def self.down
    remove_column :tags, :permalink
  end
end
