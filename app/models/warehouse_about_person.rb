class WarehouseAboutPerson < Relationship
  
  belongs_to :warehouse
  belongs_to :person
  
  validates_presence_of :warehouse
  validates_presence_of :person
  
end