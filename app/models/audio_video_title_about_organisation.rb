class AudioVideoTitleAboutOrganisation < Relationship
  
  belongs_to :audio_video_title
  belongs_to :organisation
  
  validates_presence_of :audio_video_title
  validates_presence_of :organisation
  
end