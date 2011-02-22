class EphemerumType < ActiveRecord::Base
  stampable

  def title
    localized('description')
  end

end
