require 'active_record_ext'

class Country < ActiveRecord::Base
  stampable

  validates_presence_of :iso_code
  has_many :venues, :dependent => :nullify

  set_friendly_id :iso_code

  def to_s_for_combobox
    self.iso_code + ' - ' + Utils.i18n_db_value(self, 'name')
  end

  def self.fits_in_dropdown_box?
    true
  end

end
