class ExtendDescriptionForAudioVideoTitle < ActiveRecord::Migration
  def self.up
    change_column :audio_video_titles, :description, :string, :limit => 300
  end

  def self.down
    change_column :audio_video_titles, :description, :string, :limit => 255
  end
end
