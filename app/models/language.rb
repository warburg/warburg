require 'active_record_ext'

class Language < ActiveRecord::Base
  stampable

  set_friendly_id :iso_code

  validates_presence_of :iso_code

  LOCALE_MAPPING = [%w(nl DUT), %w(en ENG), %w(fr FRE), %w(de GER)]

  search_fields [:name_nl]

  def use_slug?
    true
  end

  def self.find_by_locale(locale)
    mapping = LOCALE_MAPPING.select {|tuple| tuple[0] == locale }
    mapping.empty? ? nil : find_by_iso_code(mapping[0][1])
  end

  def to_locale
    LOCALE_MAPPING.select {|tuple| tuple[1] == self.iso_code }[0][0]
  end

  def to_s
    ([I18n.locale.to_s] + (%w(en fr nl))).uniq.each do |l|
      if result = self.send("name_#{l}")
        return result
      end
    end
    self.iso_code
  end

  def to_s_for_combobox
    self.iso_code + ' - ' + to_s
  end

  def self.fits_in_dropdown_box?
    true
  end

  def title
    to_s
  end


end
