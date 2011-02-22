require 'active_record_ext'

class CdbPhysicalAddress < ActiveRecord::Base
  belongs_to :cdb_address
  belongs_to :cdb_city
  belongs_to :cdb_gis
  belongs_to :cdb_street
  belongs_to :country
  
  field_sequence [:cdb_street_id, :housenr, :zipcode, :cdb_city_id]
  def title
    "#{cdb_street.street} #{housenr}, #{cdb_city.city}"
  end
  
end
