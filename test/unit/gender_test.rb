require File.dirname(__FILE__) + '/../test_helper'

class GenderTest < ActiveSupport::TestCase
  fixtures :genders
  
  should "make an English to_s representation" do
    I18n.locale = 'en'
    assert_equal "Man", genders(:man).to_s
    assert_equal "Woman", genders(:vrouw).to_s
  end

  should "make an i18ned to_s representation" do
    I18n.locale = 'nl'
    assert_equal "Man", genders(:man).to_s
    assert_equal "Vrouw", genders(:vrouw).to_s
  end

end
