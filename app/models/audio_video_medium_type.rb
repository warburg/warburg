class AudioVideoMediumType < ActiveRecord::Base
  stampable

  def to_s
    localized('description')
  end
  
end
