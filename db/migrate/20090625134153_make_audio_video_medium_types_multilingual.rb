class MakeAudioVideoMediumTypesMultilingual < ActiveRecord::Migration
  def self.up
    rename_column :audio_video_medium_types, :description, :description_nl
    add_column :audio_video_medium_types, :description_fr, :string
    add_column :audio_video_medium_types, :description_en, :string
  end

  def self.down
    remove_column :audio_video_medium_types, :description_en
    remove_column :audio_video_medium_types, :description_fr
    rename_column :audio_video_medium_types, :description_nl, :description
  end
end
