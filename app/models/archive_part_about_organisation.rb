class ArchivePartAboutOrganisation < Relationship
  
  belongs_to :organisation
  belongs_to :archive_part
  
  validates_presence_of :archive_part
  validates_presence_of :organisation
  
end