require 'active_record_ext'

class CdbEventDetail < ActiveRecord::Base
  belongs_to :language
  has_one :cdb_price, :dependent => :destroy
  has_many :cdb_performers, :dependent => :destroy
  belongs_to :cdb_event
  
  field_sequence [:cdb_event_id, :title, :shortdescription, :longdescription, 
                  :price, :price_description, :language_id, :calendarsummary]
  relations [:cdb_performers]

  def price
    cdb_price.pricevalue if cdb_price
  end
  
  def price_description
    cdb_price.pricedescription if cdb_price
  end
end
