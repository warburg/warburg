require 'active_record_ext'

class CdbOrganisation < ActiveRecord::Base
  set_friendly_id :label

  field_sequence [:label]

  def title
    label
  end
end
