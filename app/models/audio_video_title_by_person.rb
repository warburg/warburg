class AudioVideoTitleByPerson < Relationship
  
  belongs_to :audio_video_title
  belongs_to :person
  belongs_to :function, :class_name => 'PersonFunction'

  validates_presence_of :audio_video_title
  validates_presence_of :person

  relation_attributes [:function_text, :function]
end