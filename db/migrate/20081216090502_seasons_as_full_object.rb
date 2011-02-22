class SeasonsAsFullObject < ActiveRecord::Migration
  def self.up
    add_column    :ephemera, :season_id, :integer
    remove_column :ephemera, :season
    add_column    :ico_titles, :season_id, :integer
    remove_column :ico_titles, :season
    add_column    :productions, :season_id, :integer
    remove_column :productions, :season
    add_column    :shows, :season_id, :integer
    remove_column :shows, :season
  end

  def self.down
    add_column    :shows, :season, :string
    remove_column :shows, :season_id
    add_column    :productions, :season, :string
    remove_column :productions, :season_id
    add_column    :ico_titles, :season, :string
    remove_column :ico_titles, :season_id
    add_column    :ephemera, :season, :string
    remove_column :ephemera, :season_id
  end
end
