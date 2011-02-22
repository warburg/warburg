class PressCuttingAboutOrganisation < Relationship
  
  belongs_to :press_cutting
  belongs_to :organisation
  
  validates_presence_of :press_cutting
  validates_presence_of :organisation
  
end