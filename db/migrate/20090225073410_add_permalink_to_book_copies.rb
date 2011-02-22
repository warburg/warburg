class AddPermalinkToBookCopies < ActiveRecord::Migration
  def self.up
    add_column :book_copies, :permalink, :string
  end

  def self.down
    remove_column :book_copies, :permalink
  end
end
