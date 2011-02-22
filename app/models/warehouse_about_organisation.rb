class WarehouseAboutOrganisation < Relationship
  
  belongs_to :warehouse
  belongs_to :organisation
  
  validates_presence_of :warehouse
  validates_presence_of :organisation
  
  
end