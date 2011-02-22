# Class to store missing translations.
class MissingTranslation < ActiveRecord::Base
  def self.list
    missings = self.all
    missings.collect!{|missing| missing.key}
    missings.sort.join("\n")
  end
end
