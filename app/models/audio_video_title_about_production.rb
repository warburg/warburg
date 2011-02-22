class AudioVideoTitleAboutProduction < Relationship
  
  belongs_to :audio_video_title
  belongs_to :production
  
  validates_presence_of :audio_video_title
  validates_presence_of :production
  
end