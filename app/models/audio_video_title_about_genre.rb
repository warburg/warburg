class AudioVideoTitleAboutGenre < Relationship
  
  belongs_to :audio_video_title
  belongs_to :genre
  
  validates_presence_of :audio_video_title
  validates_presence_of :genre
  
end