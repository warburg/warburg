class ProductionLanguage < Relationship
  set_table_name "production_languages"
  
  stampable
  belongs_to :production
  belongs_to :language
  belongs_to :language_role
  
  validates_presence_of :production
  validates_presence_of :language

end