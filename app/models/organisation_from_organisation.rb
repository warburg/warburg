class OrganisationFromOrganisation < Relationship
  belongs_to :organisation_relation_type
  belongs_to :organisation_from,      :class_name => 'Organisation'
  belongs_to :organisation_to,        :class_name => 'Organisation'

  belongs_to :creation_date,          :class_name => "DateIsaar"
  belongs_to :cancellation_date,      :class_name => "DateIsaar"
  belongs_to :start_activities_date,  :class_name => "DateIsaar"
  belongs_to :end_activities_date,    :class_name => "DateIsaar"
  
  validates_presence_of :organisation_from
  validates_presence_of :organisation_to
  
  relation_attributes [ :organisation_relation_type ]
  
  def self.other_side_class(klazz)
    Organisation
  end
  
  def other_side(object)
    if organisation_to == object
      organisation_from
    else
      organisation_to
    end
  end
end