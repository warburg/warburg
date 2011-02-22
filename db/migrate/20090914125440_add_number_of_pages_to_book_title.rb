class AddNumberOfPagesToBookTitle < ActiveRecord::Migration
  def self.up
    add_column :book_titles, :number_of_pages, :integer
  end

  def self.down
    remove_column :book_titles, :number_of_pages
  end
end
