class ArticleAboutOrganisation < Relationship
  
  belongs_to :article
  belongs_to :organisation
  
  validates_presence_of :article
  validates_presence_of :organisation
  
end