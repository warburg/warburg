class CreatePostits < ActiveRecord::Migration
  def self.up
    create_table :postits do |t|
      t.string :text, :limit => 5000
      t.integer :user_id
      t.integer :language_id
      t.integer :alumnus_id
      t.integer :archive_part_id
      t.integer :article_id
      t.integer :audio_video_language_id
      t.integer :audio_video_medium_id
      t.integer :audio_video_title_id
      t.integer :book_copy_id
      t.integer :book_title_language_id
      t.integer :book_title_id
      t.integer :date_isaar_id
      t.integer :donation_id
      t.integer :ephemerum_id
      t.integer :ephemerum_language_id
      t.integer :festival_id
      t.integer :grant_genre_id
      t.integer :grant_system_id
      t.integer :grant_id
      t.integer :ico_title_id
      t.integer :impressum_id
      t.integer :periodical_copy_id
      t.integer :periodical_id
      t.integer :person_isaar_id
      t.integer :production_language_id
      t.integer :production_id
      t.integer :relationship_id
      t.integer :repertoire_id
      t.integer :room_id
      t.integer :show_id

      t.timestamps
    end

    remove_column :alumni, :note
    remove_column :archive_parts, :note
    remove_column :articles, :note
    remove_column :audio_video_languages, :note
    remove_column :audio_video_media, :general_note
    remove_column :audio_video_media, :technical_note
    remove_column :audio_video_titles, :note
    remove_column :book_copies, :note
    remove_column :book_title_languages, :note
    remove_column :book_titles, :note
    remove_column :date_isaars, :note
    remove_column :donations, :note
    remove_column :ephemera, :note
    remove_column :ephemerum_languages, :note
    remove_column :festivals, :note
    remove_column :grant_genres, :note
    remove_column :grant_systems, :note
    remove_column :grants, :note
    remove_column :ico_titles, :note
    remove_column :impressums, :note
    remove_column :periodical_copies, :note
    remove_column :periodicals, :periodical_note
    remove_column :person_isaars, :note
    remove_column :production_languages, :note
    remove_column :productions, :note
    remove_column :relationships, :note
    remove_column :repertoires, :note
    remove_column :rooms, :note
    remove_column :shows, :note
  end

  def self.down
    drop_table :postits
    add_column :alumni, :note
    add_column :archive_parts, :note , :string
    add_column :articles, :note , :string
    add_column :audio_video_languages, :note , :string
    add_column :audio_video_media, :general_note , :string
    add_column :audio_video_media, :technical_note , :string
    add_column :audio_video_titles, :note , :string
    add_column :book_copies, :note , :string
    add_column :book_title_languages, :note , :string
    add_column :book_titles, :note , :string
    add_column :date_isaars, :note , :string
    add_column :donations, :note , :string
    add_column :ephemera, :note , :string
    add_column :ephemerum_languages, :note , :string
    add_column :festivals, :note , :string
    add_column :grant_genres, :note , :string
    add_column :grant_systems, :note , :string
    add_column :grants, :note , :string
    add_column :ico_titles, :note , :string
    add_column :impressums, :note , :string
    add_column :periodical_copies, :note , :string
    add_column :periodicals, :periodical_note , :string
    add_column :person_isaars, :note , :string
    add_column :production_languages, :note , :string
    add_column :productions, :note , :string
    add_column :relationships, :note , :string
    add_column :repertoires, :note , :string
    add_column :rooms, :note , :string
    add_column :shows, :note , :string
  end
end
