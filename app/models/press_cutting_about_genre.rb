class PressCuttingAboutGenre < Relationship
  
  belongs_to :press_cutting
  belongs_to :genre
  
  validates_presence_of :press_cutting
  validates_presence_of :genre
  
end