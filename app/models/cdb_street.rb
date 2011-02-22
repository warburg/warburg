class CdbStreet < ActiveRecord::Base
  has_many :cdb_physical_addresses
  
  def title
    street
  end
end
