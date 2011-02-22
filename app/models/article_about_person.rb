class ArticleAboutPerson < Relationship
  
  belongs_to :article
  belongs_to :person
  
  validates_presence_of :article
  validates_presence_of :person
  
end