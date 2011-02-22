class Gender < ActiveRecord::Base
  stampable
  set_friendly_id :code

  def to_s
    self.send("name_#{I18n.locale}")
  end

end
