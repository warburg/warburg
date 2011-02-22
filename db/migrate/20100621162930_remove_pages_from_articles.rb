class RemovePagesFromArticles < ActiveRecord::Migration
  def self.up
    remove_column :articles, :pages
  end

  def self.down
    add_column :articles, :pages, :string
  end
end
