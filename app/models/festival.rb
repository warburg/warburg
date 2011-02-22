class Festival < ActiveRecord::Base
  stampable
  belongs_to :organisation

  def to_s
    'Details'
  end
  alias :title :to_s

  def cached_slug
    id.to_s
  end

  def self.order_field
    'id'
  end
    #
    # def self.find_by_cached_slug(cached_slug)
    #   find(cached_slug.to_i)
    # end
end
