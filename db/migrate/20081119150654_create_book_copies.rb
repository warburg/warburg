class CreateBookCopies < ActiveRecord::Migration
  def self.up
    create_table :book_copies do |t|
      t.integer :book_title_id
      t.integer :donation_id
      t.string :library_location
      t.integer :warehouse_id
      t.boolean :borrowable
      t.boolean :available
      t.string :note

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :book_copies
  end
end
