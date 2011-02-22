class BookTitleByPerson < Relationship
  
  belongs_to :book_title
  belongs_to :person
  belongs_to :function, :class_name => 'PersonFunction'

  validates_presence_of :book_title
  validates_presence_of :person

  relation_attributes [:function, :function_text]
end