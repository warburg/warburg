class PeriodicalAboutGenre < Relationship
  
  belongs_to :periodical
  belongs_to :genre
  
  validates_presence_of :periodical
  validates_presence_of :genre
  
end