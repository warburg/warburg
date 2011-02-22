class PressCuttingAboutProduction < Relationship
  
  belongs_to :press_cutting
  belongs_to :production
  
  validates_presence_of :press_cutting
  validates_presence_of :production
  
  
end