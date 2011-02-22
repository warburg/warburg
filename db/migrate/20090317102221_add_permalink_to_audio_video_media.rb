class AddPermalinkToAudioVideoMedia < ActiveRecord::Migration
  def self.up
    add_column :audio_video_media, :permalink, :string
  end

  def self.down
    remove_column :audio_video_media, :permalink
  end
end
