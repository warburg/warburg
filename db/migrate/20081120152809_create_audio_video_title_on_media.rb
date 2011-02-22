class CreateAudioVideoTitleOnMedia < ActiveRecord::Migration
  def self.up
    create_table :audio_video_title_on_media do |t|
      t.integer :audio_video_title_id
      t.integer :audio_video_medium_id
      t.string :player_position
      t.string :quality
      t.integer :source_id
      t.date :date

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :audio_video_title_on_media
  end
end
