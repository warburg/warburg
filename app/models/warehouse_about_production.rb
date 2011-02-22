class WarehouseAboutProduction < Relationship
  
  belongs_to :production
  belongs_to :warehouse
  
  validates_presence_of :production
  validates_presence_of :warehouse
  
end