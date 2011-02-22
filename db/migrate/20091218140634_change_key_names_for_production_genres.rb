class ChangeKeyNamesForProductionGenres < ActiveRecord::Migration
  def self.up
    rename_column :relationships, :production_genre_id, :genre_id
  end

  def self.down
    rename_column :relationships, :genre_id, :production_genre_id
  end
end
