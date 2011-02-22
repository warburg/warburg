class PeriodicalImpressum < Relationship
  set_table_name "periodical_impressums"
  
  belongs_to :impressum
  belongs_to :periodical
  stampable
  
end
