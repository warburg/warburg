class PressCuttingByOrganisation < Relationship
  
  belongs_to :press_cutting
  belongs_to :organisation
  belongs_to :function, :class_name => 'OrganisationFunction'

  relation_attributes [:function]
  
  validates_presence_of :press_cutting
  validates_presence_of :organisation
  
end