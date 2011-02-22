class ArchivePartAboutGenre < Relationship
  
  belongs_to :archive_part
  belongs_to :genre
  
  validates_presence_of :archive_part
  validates_presence_of :genre
  
end