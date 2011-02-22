class DropReferenceFromRelationships < ActiveRecord::Migration
  def self.up
    remove_column :relationships, :reference
  end

  def self.down
    add_column :relationships, :reference, :boolean
  end
end
