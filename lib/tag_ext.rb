require "set_friendly_id"
class Tag < ActiveRecord::Base
  belongs_to :language
  
  set_friendly_id :name
  
  def before_create
    self.language ||= Language.find_by_locale(I18n.locale)
  end
  
end

