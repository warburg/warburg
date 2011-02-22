require File.dirname(__FILE__) + '/../test_helper'

class BookTitleTest < ActiveSupport::TestCase
  
  fixtures :book_titles, :people, :organisations, :productions
  
  should_have_many :by_people, :through => :book_title_by_people
  should_have_many :about_people, :through => :book_title_about_people
  should_have_many :by_organisations, :through => :book_title_by_organisations
  should_have_many :about_organisations, :through => :book_title_about_organisations
  should_have_many :about_productions, :through => :book_title_about_productions
  should_have_many :orders, :through => :book_title_orders
  
  should "test about productions relation" do
    (book_titles(:one)).about_productions << productions(:one)    
    assert_not_nil((book_titles(:one)).about_productions.find_by_title("One"))
    assert_nil((book_titles(:one)).about_productions.find_by_title("Two"))
  end

  should "test by people relation" do    
    (book_titles(:one)).by_people << people(:jos)    
    assert_not_nil((book_titles(:one)).by_people.find_by_first_name("Jos"))
    assert_nil((book_titles(:one)).by_people.find_by_first_name("Jan"))
  end
  
  should "test about people relation" do
    (book_titles(:one)).about_people << people(:jos)    
    assert_not_nil((book_titles(:one)).about_people.find_by_first_name("Jos"))
    assert_nil((book_titles(:one)).about_people.find_by_first_name("Jan"))
  end
  
  should "test by organisation relation" do
    (book_titles(:one)).by_organisations << organisations(:one)    
    assert_not_nil((book_titles(:one)).by_organisations.find_by_name("One"))
    assert_nil((book_titles(:one)).by_organisations.find_by_name("Two"))
  end
  
  should "test about organisation relation" do
    (book_titles(:one)).about_organisations << organisations(:one)    
    assert_not_nil((book_titles(:one)).about_organisations.find_by_name("One"))
    assert_nil((book_titles(:one)).about_organisations.find_by_name("Two"))
  end

  should 'validate ean correctly' do
    book_title = BookTitle.new(:ean => '9789063212902')
    assert book_title.validate_ean
    book_title = BookTitle.new(:ean => '9789063212903')
    assert !book_title.validate_ean
    book_title = BookTitle.new(:ean => '9789070924430')
    assert book_title.validate_ean
    #book_title = BookTitle.new(:ean => '9789044122132')
    #assert book_title.validate_ean
    #book_title = BookTitle.new(:ean => '9789075862955')
    #assert book_title.validate_ean
  end
  

end