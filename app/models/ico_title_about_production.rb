class IcoTitleAboutProduction < Relationship
  
  belongs_to :ico_title
  belongs_to :production
  
  validates_presence_of :production
  validates_presence_of :ico_title
  
end