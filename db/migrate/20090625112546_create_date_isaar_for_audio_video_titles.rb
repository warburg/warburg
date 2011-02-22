class CreateDateIsaarForAudioVideoTitles < ActiveRecord::Migration
  def self.up
    add_column :audio_video_titles, :creation_date_id, :integer
    remove_column :audio_video_titles, :creation_date 
    remove_column :audio_video_titles, :creation_year
    remove_column :audio_video_titles, :creation_month
  end

  def self.down
    add_column :audio_video_titles, :creation_month, :integer
    add_column :audio_video_titles, :creation_year, :integer
    add_column :audio_video_titles, :creation_date, :date
    remove_column :audio_video_titles, :creation_date_id
  end
end
