class BookTitleAboutOrganisation < Relationship
  
  belongs_to :book_title
  belongs_to :organisation
  
  validates_presence_of :book_title
  validates_presence_of :organisation
  
end