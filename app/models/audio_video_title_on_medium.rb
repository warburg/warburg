class AudioVideoTitleOnMedium < ActiveRecord::Base
  stampable
  belongs_to :audio_video_title
  belongs_to :audio_video_medium
  belongs_to :source, :class_name => 'Organisation'

  validates_presence_of :audio_video_title
  validates_presence_of :audio_video_medium


  def self.relation_attributes
    [:player_position, :quality, :source, :date]
  end
  
  def other_side(object)
    if object == audio_video_title
      audio_video_medium
    else
      audio_video_title
    end
  end

  def self.other_side_class(klazz)
    if klazz.name == 'AudioVideoTitle'
      AudioVideoMedium
    else
      AudioVideoTitle
    end
  end
end
