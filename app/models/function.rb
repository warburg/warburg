class Function < ActiveRecord::Base
  stampable
  
  def to_s
    Utils.i18n_db_value(self, :name)
  end
end
