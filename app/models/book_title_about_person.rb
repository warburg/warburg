class BookTitleAboutPerson < Relationship
  
  belongs_to :book_title
  belongs_to :person
  
  validates_presence_of :book_title
  validates_presence_of :person
  
end