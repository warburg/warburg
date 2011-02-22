class Show < ActiveRecord::Base
  belongs_to :production
  belongs_to :show_type
  belongs_to :venue
  belongs_to :organisation
  # belongs_to :season

  belongs_to :date, :class_name => "DateIsaar"

  cloneable
  stampable

  named_scope :visible, :conditions => {:visible => true}

  def to_s
    rvalue = production.to_s
    rvalue << date.to_s if date
    rvalue
  end
  alias :title :to_s

  # def self.fi# nd_by_cached_slug(cached_slug)
  # #     find_by_id(cached_slug)
  # #   end

  def cached_slug
    id.to_s
  end

  def before_save
    self.visible = production.visible if production
    true
  end


end
