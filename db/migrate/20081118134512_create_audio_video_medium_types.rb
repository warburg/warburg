class CreateAudioVideoMediumTypes < ActiveRecord::Migration
  def self.up
    create_table :audio_video_medium_types do |t|
      t.string :description

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :audio_video_medium_types
  end
end
