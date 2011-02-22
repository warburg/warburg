class BoxType < ActiveRecord::Base
  stampable

  def title
    localized('description')
  end
  
end
