class RemoveIsbnFromBookTitles < ActiveRecord::Migration
  def self.up
    remove_column :book_titles, :isbn
  end

  def self.down
    add_column :book_titles, :isbn, :string
  end
end
