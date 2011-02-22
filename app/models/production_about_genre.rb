class ProductionAboutGenre < Relationship
  
  belongs_to :production
  belongs_to :genre
  
  validates_presence_of :production
  validates_presence_of :genre
  
end