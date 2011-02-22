class AddMultiLanguageToAvDescription < ActiveRecord::Migration
  def self.up
    rename_column :audio_video_titles, :description, :description_nl
    add_column :audio_video_titles, :description_fr, :string
    add_column :audio_video_titles, :description_en, :string
  end

  def self.down
    rename_column :audio_video_titles, :description_nl, :description
    remove_column :audio_video_titles, :description_fr
    remove_column :audio_video_titles, :description_en
  end
end
