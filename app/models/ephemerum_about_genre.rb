class EphemerumAboutGenre < Relationship
  
  belongs_to :ephemerum
  belongs_to :genre
  
  validates_presence_of :ephemerum
  validates_presence_of :genre
  
end