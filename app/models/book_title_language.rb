class BookTitleLanguage < Relationship
  stampable
  belongs_to :language
  belongs_to :book_title
  belongs_to :language_role
  
  validates_presence_of :book_title
  validates_presence_of :language
end
