class BookTitleOrder < Relationship
  
  belongs_to :book_title
  belongs_to :order
  
  validates_presence_of :book_title
  validates_presence_of :order
  
end