class PropagateChangesToVersionTables < ActiveRecord::Migration
  def self.up
    rename_column :production_versions, :inspiration_number, :inspiration
    change_table :person_versions do |t|
      t.string :key_name
      t.integer :alias_of_id
    end
    
  end

  def self.down
    rename_column :production_versions, :inspiration, :inspiration_number 
    remove_column :person_versions, :alias_of_id
    remove_column :person_versions, :key_name
    
  end
end
