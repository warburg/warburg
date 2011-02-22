class Alumnus < Relationship
  set_table_name "alumni"
  
  stampable
  belongs_to :organisation
  belongs_to :person
end
