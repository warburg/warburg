class Description < ActiveRecord::Base
  include ActiveRecordExtensions

  stampable
  set_friendly_id :description_nl

  validates_presence_of :description_nl

  search_fields [:description_nl]

  def permalink
    description_nl
  end

  def use_slug?
    true
  end

  def title
    to_s
  end

  def to_s
    self.description_nl
  end

end
