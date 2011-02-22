class GrantSystem < ActiveRecord::Base
  stampable
  belongs_to :grant_genre

  set_friendly_id :code

end
