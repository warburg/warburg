class AudioVideoTitleAboutPerson < Relationship
  
  belongs_to :audio_video_title
  belongs_to :person
  
  validates_presence_of :audio_video_title
  validates_presence_of :person
  
end