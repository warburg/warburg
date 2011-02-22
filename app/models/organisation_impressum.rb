class OrganisationImpressum < Relationship
  set_table_name "organisation_impressums"

  belongs_to :organisation
  belongs_to :impressum
  
  validates_presence_of :organisation
  validates_presence_of :impressum
  
  
  stampable
end
