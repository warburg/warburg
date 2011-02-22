class ArticleByOrganisation < Relationship
  
  belongs_to :article
  belongs_to :organisation
  belongs_to :function, :class_name => 'OrganisationFunction'

  validates_presence_of :article
  validates_presence_of :organisation

  relation_attributes [:function]
  
end