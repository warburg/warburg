class CreatePressCuttingLanguage < ActiveRecord::Migration
  def self.up
    create_table "press_cutting_languages", :force => true do |t|
      t.integer  "press_cutting_id"
      t.integer  "language_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "creator_id"
      t.integer  "updater_id"
      t.integer  "old_id"
    end

    add_index "press_cutting_languages", ["press_cutting_id"]
    add_index "press_cutting_languages", ["old_id"]
    
    execute("CREATE INDEX trgm_press_cuttings_title_idx ON press_cuttings USING gist (title gist_trgm_ops)")
    
  end

  def self.down
    execute("DROP INDEX trgm_press_cuttings_title_idx")
    remove_index :press_cutting_languages, :press_cutting_id
    remove_index :press_cutting_languages, :old_id
    drop_table :press_cutting_languages
  end
end
