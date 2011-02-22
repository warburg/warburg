class ArticleAboutProduction < Relationship
  
  belongs_to :article
  belongs_to :production
  
  validates_presence_of :article
  validates_presence_of :production
  
end