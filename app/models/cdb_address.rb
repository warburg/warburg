require 'active_record_ext'

class CdbAddress < ActiveRecord::Base
  has_one :cdb_physical_address, :dependent => :destroy
  has_one :cdb_virtual_address, :dependent => :destroy
  belongs_to :cdb_location
  
  field_sequence [:cdb_physical_address, :cdb_virtual_address]
  
  def title
    "#{cdb_physical_address.cdb_street.street} #{cdb_physical_address.housenr}, #{cdb_physical_address.cdb_city.city}"
  end
  
end
