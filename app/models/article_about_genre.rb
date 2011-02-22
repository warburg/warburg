class ArticleAboutGenre < Relationship
  
  belongs_to :article
  belongs_to :genre
  
  validates_presence_of :article
  validates_presence_of :genre
  
end