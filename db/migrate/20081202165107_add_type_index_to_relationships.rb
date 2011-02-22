class AddTypeIndexToRelationships < ActiveRecord::Migration
  def self.up
    add_index :relationships, :type
  end

  def self.down
    remove_index :relationships, :type
  end
end
