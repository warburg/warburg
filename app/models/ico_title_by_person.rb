class IcoTitleByPerson < Relationship
  
  belongs_to :ico_title
  belongs_to :person
  belongs_to :function, :class_name => 'PersonFunction'

  validates_presence_of :ico_title
  validates_presence_of :person

  relation_attributes [:function_text, :function]
end