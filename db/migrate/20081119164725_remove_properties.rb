class RemoveProperties < ActiveRecord::Migration
  def self.up
    drop_table :properties
  end

  def self.down
    create_table "properties", :force => true do |t|
      t.string   "property"
      t.string   "description_dutch"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "old_id"
    end
    
  end
end
