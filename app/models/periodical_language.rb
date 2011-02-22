class PeriodicalLanguage < Relationship
  set_table_name "periodical_languages"
  stampable
  
  belongs_to :periodical
  belongs_to :language
  belongs_to :language_role
end
