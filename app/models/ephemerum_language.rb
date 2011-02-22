class EphemerumLanguage < Relationship
  set_table_name "ephemerum_languages"
  
  stampable
  belongs_to :language
  belongs_to :ephemerum
  
  validates_presence_of :language
  validates_presence_of :ephemerum
  
end
