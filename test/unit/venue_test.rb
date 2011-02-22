require File.dirname(__FILE__) + '/../test_helper'

class VenueTest < ActiveSupport::TestCase
  
  fixtures :organisations, :venues
  
  should_belong_to :country
  
  should_have_many :organisations, :through => :organisation_venues
  
  should "test organisations relation" do
    venues(:one).organisations << organisations(:one)
    assert_not_nil(venues(:one).organisations.find_by_name("One"))
    assert_nil(venues(:one).organisations.find_by_name("Two"))
  end
  
end
