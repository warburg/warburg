class EphemerumAboutOrganisation < Relationship
  
  belongs_to :ephemerum
  belongs_to :organisation
  
  validates_presence_of :ephemerum
  validates_presence_of :organisation
  
end