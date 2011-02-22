class Genre < ActiveRecord::Base
  include DeltaFlag

  set_friendly_id :name_nl

  stampable

  has_many :productions_about, :through => :production_about_genres, :source => :production
  has_many :production_about_genres, :dependent => :destroy

  search_fields [:name_nl]

  def title
    localized('name')
  end

end
