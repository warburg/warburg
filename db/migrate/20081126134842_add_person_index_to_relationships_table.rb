class AddPersonIndexToRelationshipsTable < ActiveRecord::Migration
  def self.up
    add_index :relationships, :person_id
  end

  def self.down
    remove_index :relationships, :person_id
  end
end
