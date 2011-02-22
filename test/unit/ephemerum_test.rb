require File.dirname(__FILE__) + '/../test_helper'

class EphemerumTest < ActiveSupport::TestCase
  
  fixtures :people, :organisations, :productions, :ephemera
  
  should_belong_to :donation
  should_belong_to :warehouse
  should_belong_to :source
  should_belong_to :ephemerum_type
  
  should_have_many :by_people, :through => :ephemerum_by_people
  should_have_many :about_people, :through => :ephemerum_about_people
  should_have_many :by_organisations, :through => :ephemerum_by_organisations
  should_have_many :about_organisations, :through => :ephemerum_about_organisations
  should_have_many :about_productions, :through => :ephemerum_about_productions
  
  should "test about productions relation" do
    (ephemera(:one)).about_productions << productions(:one)    
    assert_not_nil((ephemera(:one)).about_productions.find_by_title("One"))
    assert_nil((ephemera(:one)).about_productions.find_by_title("Two"))
  end

  should "test by people relation" do    
    (ephemera(:one)).by_people << people(:jos)    
    assert_not_nil((ephemera(:one)).by_people.find_by_first_name("Jos"))
    assert_nil((ephemera(:one)).by_people.find_by_first_name("Jan"))
  end
  
  should "test about people relation" do
    (ephemera(:one)).about_people << people(:jos)    
    assert_not_nil((ephemera(:one)).about_people.find_by_first_name("Jos"))
    assert_nil((ephemera(:one)).about_people.find_by_first_name("Jan"))
  end
  
  should "test by organisation relation" do
    (ephemera(:one)).by_organisations << organisations(:one)    
    assert_not_nil((ephemera(:one)).by_organisations.find_by_name("One"))
    assert_nil((ephemera(:one)).by_organisations.find_by_name("Two"))
  end
  
  should "test about organisation relation" do
    (ephemera(:one)).about_organisations << organisations(:one)    
    assert_not_nil((ephemera(:one)).about_organisations.find_by_name("One"))
    assert_nil((ephemera(:one)).about_organisations.find_by_name("Two"))
  end

end
