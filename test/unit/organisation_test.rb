require File.dirname(__FILE__) + '/../test_helper'

class OrganisationTest < ActiveSupport::TestCase
  
  fixtures :organisations, :audio_video_titles, :archive_parts, :articles, :book_titles, :ephemera, :ico_titles, :productions, :venues
  
  should_belong_to :language
  
  should_have_many :audio_video_titles_by, :through => :audio_video_title_by_organisations
  should_have_many :audio_video_titles_about, :through => :audio_video_title_about_organisations
  should_have_many :archive_parts_about, :through => :archive_part_about_organisations
  should_have_many :articles_by, :through => :article_by_organisations
  should_have_many :articles_about, :through => :article_about_organisations
  should_have_many :book_titles_by, :through => :book_title_by_organisations
  should_have_many :book_titles_about, :through => :book_title_about_organisations
  should_have_many :ephemera_by, :through => :ephemerum_by_organisations
  should_have_many :ephemera_about, :through => :ephemerum_about_organisations
  should_have_many :ico_titles_by, :through => :ico_title_by_organisations
  should_have_many :ico_titles_about, :through => :ico_title_about_organisations  
  should_have_many :productions_by, :through => :production_by_organisations
  should_have_many :venues, :through => :organisation_venues
  should_have_many :organisations_from, :through => :organisation_from_organisations

  should "test venues relation" do
    organisations(:one).venues << venues(:one)
    assert_not_nil(organisations(:one).venues.find_by_name("One"))
    assert_nil(organisations(:one).venues.find_by_name("Two"))
  end  
  
  should "test productions_by relation" do    
    organisations(:one).productions_by << productions(:one)
    assert_not_nil(organisations(:one).productions_by.find_by_title("One"))
    assert_nil(organisations(:one).productions_by.find_by_title("Two"))
  end  
  
  should "test ico_titles_by relation" do    
    organisations(:one).ico_titles_by << ico_titles(:one)
    assert_not_nil(organisations(:one).ico_titles_by.find_by_title("One"))
    assert_nil(organisations(:one).ico_titles_by.find_by_title("Two"))
    assert(true, organisations(:one).ico_titles_about.empty?)    
  end
  
  should "test ico_titles_about relation" do
    organisations(:one).ico_titles_about << ico_titles(:one)
    assert_not_nil(organisations(:one).ico_titles_about.find_by_title("One"))
    assert_nil(organisations(:one).ico_titles_about.find_by_title("Two"))
    assert(true, organisations(:one).ico_titles_by.empty?)    
  end
    
  should "test ephemera_by relation" do    
    organisations(:one).ephemera_by << ephemera(:one)
    assert_not_nil(organisations(:one).ephemera_by.find_by_title("One"))
    assert_nil(organisations(:one).ephemera_by.find_by_title("Two"))
    assert(true, organisations(:one).ephemera_about.empty?)    
  end
  
  should "test ephemera_about relation" do
    organisations(:one).ephemera_about << ephemera(:one)
    assert_not_nil(organisations(:one).ephemera_about.find_by_title("One"))
    assert_nil(organisations(:one).ephemera_about.find_by_title("Two"))
    assert(true, organisations(:one).ephemera_by.empty?)    
  end  
  
  should "test book_titles_by relation" do    
    organisations(:one).book_titles_by << book_titles(:one)
    assert_not_nil(organisations(:one).book_titles_by.find_by_title("One"))
    assert_nil(organisations(:one).book_titles_by.find_by_title("Two"))
    assert(true, organisations(:one).book_titles_about.empty?)    
  end
  
  should "test book_titles_about relation" do
    organisations(:one).book_titles_about << book_titles(:one)
    assert_not_nil(organisations(:one).book_titles_about.find_by_title("One"))
    assert_nil(organisations(:one).book_titles_about.find_by_title("Two"))
    assert(true, organisations(:one).book_titles_by.empty?)    
  end
  
  should "test articles_by relation" do    
    organisations(:one).articles_by << articles(:one)
    assert_not_nil(organisations(:one).articles_by.find_by_title("One"))
    assert_nil(organisations(:one).articles_by.find_by_title("Two"))
    assert(true, organisations(:one).articles_about.empty?)    
  end
  
  should "test articles_about relation" do
    organisations(:one).articles_about << articles(:one)
    assert_not_nil(organisations(:one).articles_about.find_by_title("One"))
    assert_nil(organisations(:one).articles_about.find_by_title("Two"))
    assert(true, organisations(:one).articles_by.empty?)    
  end
  
  should "test audio_video_titles_by relation" do    
    organisations(:one).audio_video_titles_by << audio_video_titles(:one)
    assert_not_nil(organisations(:one).audio_video_titles_by.find_by_title("One"))
    assert_nil(organisations(:one).audio_video_titles_by.find_by_title("Two"))
    assert(true, organisations(:one).audio_video_titles_about.empty?)    
  end
  
  should "test audio_video_titles_about relation" do
    organisations(:one).audio_video_titles_about << audio_video_titles(:one)
    assert_not_nil(organisations(:one).audio_video_titles_about.find_by_title("One"))
    assert_nil(organisations(:one).audio_video_titles_about.find_by_title("Two"))
    assert(true, organisations(:one).audio_video_titles_by.empty?)    
  end
  
  should "test archive_parts_about relation" do
    organisations(:one).archive_parts_about << archive_parts(:one)
    assert_not_nil(organisations(:one).archive_parts_about.find_by_title("One"))
    assert_nil(organisations(:one).archive_parts_about.find_by_title("Two"))
  end
  
  should "test organisations_from relation" do
    organisations(:one).organisations_from << organisations(:three)
    
    assert_not_nil organisations(:one).organisations_from.find_by_name("Three")
    assert_nil     organisations(:one).organisations_from.find_by_name("Two")
    assert_not_nil organisations(:three).organisations_from.find_by_name("One")
  end
  
  should "test organisations_to relation" do
    organisations(:one).organisations_to << organisations(:one)
    
    assert_not_nil organisations(:one).organisations_to.find_by_name("One")
    assert_nil     organisations(:one).organisations_to.find_by_name("Two")
  end
end
