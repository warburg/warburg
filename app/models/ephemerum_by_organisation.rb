class EphemerumByOrganisation < Relationship
  
  belongs_to :ephemerum
  belongs_to :organisation
  belongs_to :function, :class_name => 'OrganisationFunction'

  validates_presence_of :ephemerum
  validates_presence_of :organisation

  relation_attributes [:function]
end