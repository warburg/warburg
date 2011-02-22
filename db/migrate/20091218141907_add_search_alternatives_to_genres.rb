class AddSearchAlternativesToGenres < ActiveRecord::Migration
  def self.up
    add_column :genres, :search_alternatives, :string
  end

  def self.down
    remove_column :genres, :search_alternatives
  end
end
