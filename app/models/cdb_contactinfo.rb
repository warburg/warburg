class CdbContactinfo < ActiveRecord::Base
  belongs_to :cdb_actor
  belongs_to :cdb_event
  has_many :cdb_urls, :dependent => :destroy
end
