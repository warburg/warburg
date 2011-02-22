class CreateAudioVideoLanguages < ActiveRecord::Migration
  def self.up
    create_table :audio_video_languages do |t|
      t.integer :audio_video_title_id
      t.integer :language_id
      t.string :note

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :audio_video_languages
  end
end
