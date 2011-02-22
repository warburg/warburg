class CreateBookTitleImpressums < ActiveRecord::Migration
  def self.up
    create_table :book_title_impressums do |t|
      t.integer :book_title_id
      t.integer :impressum_id

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :book_title_impressums
  end
end
