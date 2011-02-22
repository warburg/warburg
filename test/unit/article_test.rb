require File.dirname(__FILE__) + '/../test_helper'

class ArticleTest < ActiveSupport::TestCase
  
  fixtures :articles, :people, :organisations, :productions
  
  should_belong_to :periodical_issue
  
  should_have_many :by_people, :through => :article_by_people
  should_have_many :about_people, :through => :article_about_people
  should_have_many :by_organisations, :through => :article_by_organisations
  should_have_many :about_organisations, :through => :article_about_organisations
  should_have_many :about_productions, :through => :article_about_productions
  
  should "test about productions relation" do
    (articles(:one)).about_productions << productions(:one)    
    assert_not_nil((articles(:one)).about_productions.find_by_title("One"))
    assert_nil((articles(:one)).about_productions.find_by_title("Two"))
  end

  should "test by people relation" do    
    (articles(:one)).by_people << people(:jos)    
    assert_not_nil((articles(:one)).by_people.find_by_first_name("Jos"))
    assert_nil((articles(:one)).by_people.find_by_first_name("Jan"))
  end
  
  should "test about people relation" do
    (articles(:one)).about_people << people(:jos)    
    assert_not_nil((articles(:one)).about_people.find_by_first_name("Jos"))
    assert_nil((articles(:one)).about_people.find_by_first_name("Jan"))
  end
  
  should "test by organisation relation" do
    (articles(:one)).by_organisations << organisations(:one)    
    assert_not_nil((articles(:one)).by_organisations.find_by_name("One"))
    assert_nil((articles(:one)).by_organisations.find_by_name("Two"))
  end
  
  should "test about organisation relation" do
    (articles(:one)).about_organisations << organisations(:one)    
    assert_not_nil((articles(:one)).about_organisations.find_by_name("One"))
    assert_nil((articles(:one)).about_organisations.find_by_name("Two"))
  end

end
