require 'active_record_ext'

class CdbLocation < ActiveRecord::Base
  belongs_to :cdb_event
  has_one :cdb_address, :dependent => :destroy
  belongs_to :cdb_actor
  has_many :cdb_events
  
  before_save :update_title
  
  field_sequence [:cdb_actor_id, :cdb_address]
  relations [:cdb_events]
  
  def update_title
    a = cdb_actor
    self.title = (a.label || a.cdb_actor_details.first.title) rescue nil
  end
  
end
