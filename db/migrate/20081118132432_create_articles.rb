class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.integer :document_type_id
      t.string :title
      t.date :date
      t.integer :periodical_id
      t.integer :periodical_copy_id
      t.string :reference
      t.boolean :available
      t.string :note

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :articles
  end
end
