class OrganisationVenue < Relationship
  
  belongs_to :organisation
  belongs_to :venue
  
  validates_presence_of :organisation
  validates_presence_of :venue
  
end