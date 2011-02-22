class BookTitleByOrganisation < Relationship

  belongs_to :book_title
  belongs_to :organisation
  belongs_to :function, :class_name => 'OrganisationFunction'

  validates_presence_of :book_title
  validates_presence_of :organisation

  relation_attributes [:function, :function_text]
end
