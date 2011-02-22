class ArticleByPerson < Relationship
  
  belongs_to :article
  belongs_to :person
  belongs_to :function, :class_name => 'PersonFunction'

  validates_presence_of :article
  validates_presence_of :person

  relation_attributes [:function]
  
end