class CreateBookTitleLanguages < ActiveRecord::Migration
  def self.up
    create_table :book_title_languages do |t|
      t.integer :book_title_id
      t.integer :language_id
      t.string :note

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :book_title_languages
  end
end
