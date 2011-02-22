class EnlargeArticleTitle < ActiveRecord::Migration
  
  def self.up
    change_column :articles, :title, :string, :limit => 300
  end

  def self.down
    change_column :articles, :title, :string, :limit => 255
  end
end
