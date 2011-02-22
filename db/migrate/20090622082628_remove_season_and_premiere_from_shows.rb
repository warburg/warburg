class RemoveSeasonAndPremiereFromShows < ActiveRecord::Migration
  def self.up
    remove_column :shows, :season_id
    remove_column :shows, :premiere
  end

  def self.down
    add_column :shows, :premiere, :string
    add_column :shows, :season_id, :integer
  end
end
