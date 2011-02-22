class SplitArticleInPressCuttingAndArticle < ActiveRecord::Migration
  def self.up
    create_table "press_cuttings", :force => true do |t|
      t.string   "title",               :limit => 300
      t.date     "date"
      t.integer  "periodical_id"
      t.string   "library_location"
      t.boolean  "available"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "creator_id"
      t.integer  "updater_id"
      t.string   "permalink"
      t.integer  "old_id"
      t.integer  "views"
      t.datetime "viewed_at"
    end
    
    add_index :press_cuttings, :old_id
    add_index :press_cuttings, :periodical_id
    add_index :press_cuttings, :permalink
    
    remove_index :articles, :name => :index_articles_on_periodical_id
    
    remove_column :articles, :document_type_id
    remove_column :articles, :periodical_id
    remove_column :articles, :date
  end

  def self.down
    remove_index :press_cuttings, :permalink
    remove_index :press_cuttings, :periodical_id
    remove_index :press_cuttings, :old_id

    add_column :articles, :date, :date
    add_column :articles, :periodical_id, :integer
    add_column :articles, :document_type_id, :integer
    add_index :articles, [:periodical_id], :name => "index_articles_on_periodical_id", :unique => true
    drop_table 'press_cuttings'
  end
end
