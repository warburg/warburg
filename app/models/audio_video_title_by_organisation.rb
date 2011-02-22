class AudioVideoTitleByOrganisation < Relationship
  
  belongs_to :audio_video_title
  belongs_to :organisation
  belongs_to :function, :class_name => 'OrganisationFunction'

  validates_presence_of :audio_video_title
  validates_presence_of :organisation

  relation_attributes [:function_text, :function]
end