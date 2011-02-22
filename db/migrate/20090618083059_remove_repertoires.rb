class RemoveRepertoires < ActiveRecord::Migration
  def self.up
    remove_column :relationships, :repertoire_id
    drop_table :repertoires
  end

  def self.down
    create_table "repertoires", :force => true do |t|
      t.string   "title"
      t.string   "inspiration_sources"
      t.date     "creation_date"
      t.integer  "number_of_roles"
      t.integer  "female_roles"
      t.integer  "male_roles"
      t.integer  "child_roles"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "creator_id"
      t.integer  "updater_id"
      t.string   "permalink"
      t.integer  "old_id"
      t.integer  "views"
      t.datetime "viewed_at"
    end
    add_index "repertoires", ["old_id"], :name => "index_repertoires_on_old_id"
    add_index "repertoires", ["permalink"], :name => "index_repertoires_on_permalink"
    add_column :relationships, :repertoire_id, :integer
    add_index "relationships", ["repertoire_id"], :name => "index_relationships_on_repertoire_id"
  end
end
