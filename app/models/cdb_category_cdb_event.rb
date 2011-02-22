class CdbCategoryCdbEvent < ActiveRecord::Base
  belongs_to :cdb_category
  belongs_to :cdb_event
end
