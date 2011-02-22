class RenameProductionGenresToGenres < ActiveRecord::Migration
  def self.up
    rename_table :production_genres, :genres
  end

  def self.down
    rename_table :genres, :production_genres
  end
end
