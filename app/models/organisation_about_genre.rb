class OrganisationAboutGenre < Relationship
  
  belongs_to :organisation
  belongs_to :genre
  
  validates_presence_of :organisation
  validates_presence_of :genre
  
end