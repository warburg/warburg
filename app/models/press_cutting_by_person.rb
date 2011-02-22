class PressCuttingByPerson < Relationship
  
  belongs_to :press_cutting
  belongs_to :person
  belongs_to :function, :class_name => 'PersonFunction'
  
  relation_attributes [:function]
  
  validates_presence_of :press_cutting
  validates_presence_of :person
  
end