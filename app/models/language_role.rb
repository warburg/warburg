class LanguageRole < ActiveRecord::Base
  stampable

  def self.fits_in_dropdown_box?
    true
  end
  
end