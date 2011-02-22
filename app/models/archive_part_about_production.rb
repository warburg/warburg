class ArchivePartAboutProduction < Relationship
  
  belongs_to :archive_part
  belongs_to :production
  
  validates_presence_of :archive_part
  validates_presence_of :production
  
end