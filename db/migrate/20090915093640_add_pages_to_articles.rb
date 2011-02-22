class AddPagesToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :pages, :string
  end

  def self.down
    remove_column :articles, :pages
  end
end
