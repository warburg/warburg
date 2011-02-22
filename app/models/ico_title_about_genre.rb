class IcoTitleAboutGenre < Relationship
  
  belongs_to :ico_title
  belongs_to :genre
  
  validates_presence_of :ico_title
  validates_presence_of :genre
  
end