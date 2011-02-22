class Static < ActiveRecord::Base
  def to_param
    name
  end

  def title
    I18n.translate("static.#{name}")
  end
  
  def to_s
    title
  end
end
