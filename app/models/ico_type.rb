class IcoType < ActiveRecord::Base
  stampable

  set_friendly_id :description_nl

  def title
    localized('description')
  end


end
