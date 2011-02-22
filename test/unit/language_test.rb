require File.dirname(__FILE__) + '/../test_helper'

class LanguageTest < ActiveSupport::TestCase
  
  fixtures :languages
  
  should 'test find_by_locale' do
    assert_equal('ENG', Language.find_by_locale('en').iso_code)
    assert_equal('DUT', Language.find_by_locale('nl').iso_code)
    assert_equal('FRE', Language.find_by_locale('fr').iso_code)
    Language.find_by_locale('xx')
  end
  
end
