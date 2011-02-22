class AdaptBookTitle < ActiveRecord::Migration
  def self.up
    change_column :book_titles, :title, :string, :limit => 1000
    change_column :book_titles, :title_extra, :string, :limit => 1000
  end

  def self.down
    change_column :book_titles, :title, :string, :limit => 300
    change_column :book_titles, :title_extra, :string, :limit => 255
  end
end
