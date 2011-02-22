class AddLanguagesToGenres < ActiveRecord::Migration
  def self.up
    rename_column :production_genres, :name, :name_nl
    add_column :production_genres, :name_fr, :string
    add_column :production_genres, :name_en, :string
  end

  def self.down
    remove_column :production_genres, :name_en
    remove_column :production_genres, :name_fr
    rename_column :production_genres, :name_nl, :name
  end
end
