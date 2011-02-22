require 'active_record_ext'

class CdbActor < ActiveRecord::Base
  has_many :cdb_actor_details
  has_one :cdb_contactinfo, :dependent => :destroy
  has_many :cdb_locations
  
  field_sequence [:cdbid, :shortdescription, :longdescription, :cdb_contactinfo]
  
  def title
    label || cdb_actor_details.first.title rescue nil
  end
  
  def details
    cdb_actor_details.find_by_language_id(Language.find_by_locale(I18n.locale).id)
  end
  
  def shortdescription
    details.shortdescription rescue nil
  end
  
  def longdescription
    details.longdescription rescue nil
  end
end
