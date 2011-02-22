class RemoveNonPolymorphicIdsFromPostits < ActiveRecord::Migration
  def self.up
    remove_column :postits, :person_id
    remove_column :postits, :organisation_id
    remove_column :postits, :alumnus_id
    remove_column :postits, :archive_part_id
    remove_column :postits, :article_id
    remove_column :postits, :audio_video_medium_id
    remove_column :postits, :audio_video_title_id
    remove_column :postits, :book_copy_id
    remove_column :postits, :book_title_language_id
    remove_column :postits, :book_title_id
    remove_column :postits, :date_isaar_id
    remove_column :postits, :donation_id
    remove_column :postits, :ephemerum_id
    remove_column :postits, :ephemerum_language_id
    remove_column :postits, :festival_id
    remove_column :postits, :grant_genre_id
    remove_column :postits, :grant_system_id
    remove_column :postits, :grant_id
    remove_column :postits, :ico_title_id
    remove_column :postits, :impressum_id
    remove_column :postits, :periodical_copy_id
    remove_column :postits, :periodical_id
    remove_column :postits, :person_isaar_id
    remove_column :postits, :production_language_id
    remove_column :postits, :production_id
    remove_column :postits, :relationship_id
    remove_column :postits, :repertoire_id
    remove_column :postits, :room_id
    remove_column :postits, :show_id
  end

  def self.down
    add_column :postits, :person_id, :integer
    add_column :postits, :organisation_id, :integer
    add_column :postits, :alumnus_id, :integer
    add_column :postits, :archive_part_id, :integer
    add_column :postits, :article_id, :integer
    add_column :postits, :audio_video_medium_id, :integer
    add_column :postits, :audio_video_title_id, :integer
    add_column :postits, :book_copy_id, :integer
    add_column :postits, :book_title_language_id, :integer
    add_column :postits, :book_title_id, :integer
    add_column :postits, :date_isaar_id, :integer
    add_column :postits, :donation_id, :integer
    add_column :postits, :ephemerum_id, :integer
    add_column :postits, :ephemerum_language_id, :integer
    add_column :postits, :festival_id, :integer
    add_column :postits, :grant_genre_id, :integer
    add_column :postits, :grant_system_id, :integer
    add_column :postits, :grant_id, :integer
    add_column :postits, :ico_title_id, :integer
    add_column :postits, :impressum_id, :integer
    add_column :postits, :periodical_copy_id, :integer
    add_column :postits, :periodical_id, :integer
    add_column :postits, :person_isaar_id, :integer
    add_column :postits, :production_language_id, :integer
    add_column :postits, :production_id, :integer
    add_column :postits, :relationship_id, :integer
    add_column :postits, :repertoire_id, :integer
    add_column :postits, :room_id, :integer
    add_column :postits, :show_id, :integer

  end
end
