class EphemerumAboutPerson < Relationship
  
  belongs_to :ephemerum
  belongs_to :person
  
  validates_presence_of :ephemerum
  validates_presence_of :person

end