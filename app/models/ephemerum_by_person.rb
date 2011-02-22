class EphemerumByPerson < Relationship
  
  belongs_to :ephemerum
  belongs_to :person
  belongs_to :function, :class_name => 'PersonFunction'

  validates_presence_of :ephemerum
  validates_presence_of :person

  relation_attributes [:function]
end