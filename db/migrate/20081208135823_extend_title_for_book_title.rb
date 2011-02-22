class ExtendTitleForBookTitle < ActiveRecord::Migration
  def self.up
    change_column :book_titles, :title, :string, :limit => 300
  end

  def self.down
    change_column :book_titles, :title, :string, :limit => 255
  end
end
