class AddMoreIndexes < ActiveRecord::Migration
  def self.up
    add_index :grants, :organisation_id 
    add_index :grants, :person_id 
  end

  def self.down
    remove_index :grants, :person_id
    remove_index :grants, :organisation_id
  end
end
