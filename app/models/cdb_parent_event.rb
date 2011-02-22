class CdbParentEvent < ActiveRecord::Base
  belongs_to :child_event, :class_name => 'CdbEvent', :foreign_key => 'cdb_event_id'
  
  def parent_event
    CdbEvent.find_by_cdbid(self.cdbid)
  end
end
