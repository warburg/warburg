class BookTitleAboutProduction < Relationship
  
  belongs_to :book_title
  belongs_to :production
  
  validates_presence_of :book_title
  validates_presence_of :production
  
end