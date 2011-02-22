class AddDescriptionToAudioVideoTitle < ActiveRecord::Migration
  def self.up
    add_column :audio_video_titles,          :description_id, :integer
    add_column :audio_video_title_versioned, :description_id, :integer
    
    total = AudioVideoTitle.count
    AudioVideoTitle.all.each_with_index do |audio_video_title, index|
      description = Description.find_or_create_by_description_nl(audio_video_title.description_nl)
      audio_video_title.description = description
      audio_video_title.save(false)
      puts "saved #{index + 1} of #{total}"
    end
  end

  def self.down
    remove_column :audio_video_titles,          :description_id
    remove_column :audio_video_title_versioned, :description_id
  end
end
