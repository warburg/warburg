class RemovePersonIsaar < ActiveRecord::Migration
  def self.up
    drop_table :person_isaars
    
    change_table :people do |t|
      t.string :key_name
      t.integer :alias_of_id
    end
    
  end

  def self.down
    remove_column :people, :alias_of_id
    remove_column :people, :key_name
    
    create_table "person_isaars", :force => true do |t|
      t.integer  "person_id"
      t.string   "key_name"
      t.integer  "alias_of_id"
      t.integer  "country_id"
      t.string   "description", :limit => 350
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "creator_id"
      t.integer  "updater_id"
      t.integer  "old_id"
    end
    
  end
end
