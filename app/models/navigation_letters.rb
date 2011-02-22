class NavigationLetters < ActiveRecord::Base
  table_name = 'navigation_letters'
  serialize :letters
end
