class IcoTitleAboutOrganisation < Relationship
  
  belongs_to :ico_title
  belongs_to :organisation
  
  validates_presence_of :ico_title
  validates_presence_of :organisation
  
end