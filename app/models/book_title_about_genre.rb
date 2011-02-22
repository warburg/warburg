class BookTitleAboutGenre < Relationship
  
  belongs_to :book_title
  belongs_to :genre
  
  validates_presence_of :book_title
  validates_presence_of :genre
  
end