class AddIndexesToRelationships < ActiveRecord::Migration
  def self.up
    change_table(:relationships) do |t|
      t.index  "audio_video_title_id"
      t.index  "organisation_id"
      t.index  "production_id"
      t.index  "archive_part_id"
      t.index  "article_id"
      t.index  "function_id"
      t.index  "book_title_id"
      t.index  "ephemerum_id"
      t.index  "ico_title_id"
      t.index  "production_genre_id"
      t.index  "repertoire_id"
      t.index  "room_id"
      t.index  "language_id"
      t.index  "order_id"
    end
  end

  def self.down
    change_table(:relationships) do |t|
      t.remove_index  "order_id"
      t.remove_index  "language_id"
      t.remove_index  "room_id"
      t.remove_index  "repertoire_id"
      t.remove_index  "production_genre_id"
      t.remove_index  "ico_title_id"
      t.remove_index  "ephemerum_id"
      t.remove_index  "book_title_id"
      t.remove_index  "function_id"
      t.remove_index  "article_id"
      t.remove_index  "archive_part_id"
      t.remove_index  "production_id"
      t.remove_index  "organisation_id"
      t.remove_index  "audio_video_title_id"
    end
  end
end
