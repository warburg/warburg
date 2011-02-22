class AudioVideoLanguage < Relationship
  set_table_name "audio_video_languages"
  
  belongs_to :audio_video_title
  belongs_to :language
  belongs_to :language_role
  
  validates_presence_of :audio_video_title
  validates_presence_of :language
  
  relation_attributes [:language_role]

  stampable

end
