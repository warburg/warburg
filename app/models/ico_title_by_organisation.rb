class IcoTitleByOrganisation < Relationship
  
  belongs_to :ico_title
  belongs_to :organisation
  belongs_to :function, :class_name => 'OrganisationFunction'

  validates_presence_of :ico_title
  validates_presence_of :organisation

  relation_attributes [:function_text, :function]
end