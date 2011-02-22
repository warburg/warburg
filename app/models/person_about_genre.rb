class PersonAboutGenre < Relationship
  
  belongs_to :person
  belongs_to :genre
  
  validates_presence_of :person
  validates_presence_of :genre
  
end