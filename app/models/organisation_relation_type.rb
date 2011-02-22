class OrganisationRelationType < ActiveRecord::Base
  stampable
  
  def self.order_field
    "from_name_nl"
  end
  
end
