class IcoTitleAboutPerson < Relationship
  
  belongs_to :ico_title
  belongs_to :person
  
  validates_presence_of :ico_title
  validates_presence_of :person
  
end