class Grant < ActiveRecord::Base
  stampable
  belongs_to :grant_state
  belongs_to :grant_system
  belongs_to :person
  belongs_to :organisation
  belongs_to :production
  
  def to_s
    id.to_s
  end
  alias :title :to_s
  
  # def self.find_by_cached_slug(cached_slug)
  #   find(cached_slug.to_s)
  # end
  
  def cached_slug
    id.to_s
  end
  
  def self.order_field
    'id'
  end
end
