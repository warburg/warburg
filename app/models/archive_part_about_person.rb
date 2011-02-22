class ArchivePartAboutPerson < Relationship
  
  belongs_to :archive_part
  belongs_to :person
  
  validates_presence_of :archive_part
  validates_presence_of :person
  
end