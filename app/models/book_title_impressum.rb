class BookTitleImpressum < Relationship
  set_table_name "book_title_impressums"

  belongs_to :book_title
  belongs_to :impressum
  
  validates_presence_of :book_title
  validates_presence_of :impressum
  
  
  stampable
end
