class AddPermalinks < ActiveRecord::Migration
  TABLES = [:archive_parts, :articles, :audio_video_titles, :book_titles,
            :countries, :ephemera, :genders, :grant_genres, 
            :grant_systems, :ico_titles, :ico_types, :impressums, :languages,
            :orders, :periodicals, :periodical_copies, 
            :productions, :production_genres, :repertoires, :rooms, :seasons,
            :show_types, :users, :warehouses]
            
  def self.up
    add_column :organisations, :permalink, :string
    add_column :organisation_versions, :permalink, :string
    add_index  :organisations, :permalink

    TABLES.each do |table|
      add_column table, :permalink, :string
      add_index  table, :permalink
    end

  end

  def self.down
    TABLES.reverse.each do |table|
      remove_index  table, :permalink
      remove_column table, :permalink
    end

    remove_index  :organisations, :permalink
    remove_column :organisation_versions, :permalink
    remove_column :organisations, :permalink
  end
end
