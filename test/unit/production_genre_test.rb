require File.dirname(__FILE__) + '/../test_helper'

class ProductionGenreTest < ActiveSupport::TestCase
  
  fixtures :productions, :production_genres
  
  should_have_many :productions_about
  
  should "test productions_about relation" do
    production_genres(:one).productions_about << productions(:one)
    assert_not_nil(production_genres(:one).productions_about.find_by_title("One"))
    assert_nil(production_genres(:one).productions_about.find_by_title("Two"))
  end
  
end
