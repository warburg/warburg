class AddSourceIdToAudioVideoMedia < ActiveRecord::Migration
  def self.up
    add_column :audio_video_media, :source_id, :integer
  end

  def self.down
    remove_column :audio_video_media, :source_id
  end
end
