class DonationAboutGenre < Relationship
  
  belongs_to :donation
  belongs_to :genre
  
  validates_presence_of :donation
  validates_presence_of :genre
  
end