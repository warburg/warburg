class PressCuttingAboutPerson < Relationship
  
  belongs_to :press_cutting
  belongs_to :person
  
  validates_presence_of :press_cutting
  validates_presence_of :person
  
end