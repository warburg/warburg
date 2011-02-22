require File.dirname(__FILE__) + '/../test_helper'

class IcoTitleTest < ActiveSupport::TestCase
  
  fixtures :ico_titles, :people, :organisations, :productions
  
  should_have_many :by_people, :through => :ico_title_by_people
  should_have_many :about_people, :through => :ico_title_about_people
  should_have_many :by_organisations, :through => :ico_title_by_organisations
  should_have_many :about_organisations, :through => :ico_title_about_organisations
  should_have_many :about_productions, :through => :ico_title_about_productions
  
  should "test about productions relation" do
    (ico_titles(:one)).about_productions << productions(:one)    
    assert_not_nil((ico_titles(:one)).about_productions.find_by_title("One"))
    assert_nil((ico_titles(:one)).about_productions.find_by_title("Two"))
  end

  should "test by people relation" do    
    (ico_titles(:one)).by_people << people(:jos)    
    assert_not_nil((ico_titles(:one)).by_people.find_by_first_name("Jos"))
    assert_nil((ico_titles(:one)).by_people.find_by_first_name("Jan"))
  end
  
  should "test about people relation" do
    (ico_titles(:one)).about_people << people(:jos)    
    assert_not_nil((ico_titles(:one)).about_people.find_by_first_name("Jos"))
    assert_nil((ico_titles(:one)).about_people.find_by_first_name("Jan"))
  end
  
  should "test by organisation relation" do
    (ico_titles(:one)).by_organisations << organisations(:one)    
    assert_not_nil((ico_titles(:one)).by_organisations.find_by_name("One"))
    assert_nil((ico_titles(:one)).by_organisations.find_by_name("Two"))
  end
  
  should "test about organisation relation" do
    (ico_titles(:one)).about_organisations << organisations(:one)    
    assert_not_nil((ico_titles(:one)).about_organisations.find_by_name("One"))
    assert_nil((ico_titles(:one)).about_organisations.find_by_name("Two"))
  end
  

end