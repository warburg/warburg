class CreateBookTitles < ActiveRecord::Migration
  def self.up
    create_table :book_titles do |t|
      t.string :title
      t.string :title_extra
      t.integer :publication_year
      t.string :isbn
      t.string :ean
      t.integer :part_of_book_title_id
      t.string :collation
      t.string :note, :limit => 900
      t.string :issn
      t.boolean :subscription_running
      t.string :subscription_type
      t.date :subscription_expiration_date
      t.integer :number_count
      t.string :subscription_note

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :book_titles
  end
end
