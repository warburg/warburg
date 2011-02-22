class Venue < ActiveRecord::Base
  belongs_to :country
  stampable

  has_many :organisations, :through => :organisation_venues, :source => :organisation
  has_many :organisation_venues, :dependent => :destroy
  has_many :shows, :dependent => :nullify

  relations [:organisation_venues]

  search_fields [:name, :city]

  set_friendly_id :name

  def title
    name
  end

end
