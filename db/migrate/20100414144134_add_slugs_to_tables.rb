class AddSlugsToTables < ActiveRecord::Migration
  def self.up
    add_column :archive_parts,      :cached_slug, :string
    add_column :audio_video_titles, :cached_slug, :string
    add_column :articles,           :cached_slug, :string
    add_column :book_titles,        :cached_slug, :string
    add_column :ephemera,           :cached_slug, :string
    add_column :ico_titles,         :cached_slug, :string
    add_column :organisations,      :cached_slug, :string
    add_column :people,             :cached_slug, :string
    add_column :press_cuttings,     :cached_slug, :string
    add_column :audio_video_media,  :cached_slug, :string
    add_column :book_copies,        :cached_slug, :string
    add_column :cdb_events,         :cached_slug, :string
    add_column :cdb_organisations,  :cached_slug, :string
    add_column :countries,          :cached_slug, :string
    add_column :donations,          :cached_slug, :string
    add_column :genders,            :cached_slug, :string
    add_column :genres,             :cached_slug, :string
    add_column :grant_genres,       :cached_slug, :string
    add_column :grants,             :cached_slug, :string
    add_column :grant_systems,      :cached_slug, :string
    add_column :ico_types,          :cached_slug, :string
    add_column :impressums,         :cached_slug, :string
    add_column :languages,          :cached_slug, :string
    add_column :orders,             :cached_slug, :string
    add_column :periodicals,        :cached_slug, :string
    add_column :periodical_issues,  :cached_slug, :string
    add_column :festivals,          :cached_slug, :string
    add_column :productions,        :cached_slug, :string
    add_column :seasons,            :cached_slug, :string
    add_column :show_types,         :cached_slug, :string
    add_column :users,              :cached_slug, :string
    add_column :venues,             :cached_slug, :string
    add_column :warehouses,         :cached_slug, :string
    add_column :tags,               :cached_slug, :string
    
    add_column :archive_part_versioned,      :cached_slug, :string
    add_column :audio_video_title_versioned, :cached_slug, :string
    add_column :article_versioned,           :cached_slug, :string
    add_column :book_title_versioned,        :cached_slug, :string
    add_column :ephemerum_versioned,         :cached_slug, :string
    add_column :ico_title_versioned,         :cached_slug, :string
    add_column :organisation_versions,       :cached_slug, :string
    add_column :person_versions,             :cached_slug, :string
    add_column :production_versions,         :cached_slug, :string
    add_column :press_cutting_versioned,     :cached_slug, :string
  end

  def self.down
    remove_column :archive_parts,      :cached_slug
    remove_column :articles,           :cached_slug
    remove_column :audio_video_media,  :cached_slug
    remove_column :audio_video_titles, :cached_slug
    remove_column :book_copies,        :cached_slug
    remove_column :book_titles,        :cached_slug
    remove_column :cdb_events,         :cached_slug
    remove_column :cdb_organisations,  :cached_slug
    remove_column :countries,          :cached_slug
    remove_column :donations,          :cached_slug
    remove_column :ephemera,           :cached_slug
    remove_column :genders,            :cached_slug
    remove_column :genres,             :cached_slug
    remove_column :grant_genres,       :cached_slug
    remove_column :grants,             :cached_slug
    remove_column :grant_systems,      :cached_slug
    remove_column :ico_titles,         :cached_slug
    remove_column :ico_types,          :cached_slug
    remove_column :impressums,         :cached_slug
    remove_column :languages,          :cached_slug
    remove_column :orders,             :cached_slug
    remove_column :organisations,      :cached_slug
    remove_column :periodicals,        :cached_slug
    remove_column :periodical_issues,  :cached_slug
    remove_column :people,             :cached_slug
    remove_column :press_cuttings,     :cached_slug
    remove_column :productions,        :cached_slug
    remove_column :seasons,            :cached_slug
    remove_column :show_types,         :cached_slug
    remove_column :users,              :cached_slug
    remove_column :festivals,          :cached_slug
    remove_column :venues,             :cached_slug
    remove_column :warehouses,         :cached_slug
    remove_column :tags,               :cached_slug
    
    remove_column :archive_part_versioned,      :cached_slug
    remove_column :audio_video_title_versioned, :cached_slug
    remove_column :article_versioned,           :cached_slug
    remove_column :book_title_versioned,        :cached_slug
    remove_column :ephemerum_versioned,         :cached_slug
    remove_column :ico_title_versioned,         :cached_slug
    remove_column :organisation_versions,       :cached_slug
    remove_column :person_versions,             :cached_slug
    remove_column :production_versions,         :cached_slug
    remove_column :press_cutting_versioned,     :cached_slug
  end
end
