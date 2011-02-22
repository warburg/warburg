class DropDocumentType < ActiveRecord::Migration
  def self.up
    drop_table :document_types
  end

  def self.down
    create_table "document_types", :force => true do |t|
      t.string   "description_nl"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "creator_id"
      t.integer  "updater_id"
      t.integer  "old_id"
      t.string   "description_fr"
      t.string   "description_en"
    end
    
  end
end
