require File.dirname(__FILE__) + '/../test_helper'

class ProductionTest < ActiveSupport::TestCase
  
  fixtures :productions, :audio_video_titles, :archive_parts, :articles, :book_titles, :ephemera, :ico_titles, :people, :organisations, :genres
  
  should_belong_to :rerun_of
  
  should_have_many :audio_video_titles_about, :through => :audio_video_title_about_productions
  should_have_many :archive_parts_about, :through => :archive_part_about_productions
  should_have_many :articles_about, :through => :article_about_productions
  should_have_many :book_titles_about, :through => :book_title_about_productions
  should_have_many :ephemera_about, :through => :ephemerum_about_productions
  should_have_many :ico_titles_about, :through => :ico_title_about_productions  
  should_have_many :by_organisations, :through => :production_by_organisations
  should_have_many :by_people, :through => :production_by_people
  should_have_many :about_genres, :through => :production_about_genres

  should "test about_genres relation" do
    productions(:one).about_genres << genres(:one)
    assert_not_nil(productions(:one).about_genres.find_by_name_nl("One"))
    assert_nil(productions(:one).about_genres.find_by_name_nl("Two"))
  end

  should "test by_organisations relation" do
    productions(:one).by_organisations << organisations(:one)
    assert_not_nil(productions(:one).by_organisations.find_by_name("One"))
    assert_nil(productions(:one).by_organisations.find_by_name("Two"))
  end

  should "test by_people relation" do
    productions(:one).by_people << people(:jos)
    assert_not_nil(productions(:one).by_people.find_by_first_name("Jos"))
    assert_nil(productions(:one).by_people.find_by_first_name("Jan"))
  end

  should "test ico_titles_about relation" do
    productions(:one).ico_titles_about << ico_titles(:one)
    assert_not_nil(productions(:one).ico_titles_about.find_by_title("One"))
    assert_nil(productions(:one).ico_titles_about.find_by_title("Two"))
  end

  should "test ephemera_about relation" do
    productions(:one).ephemera_about << ephemera(:one)
    assert_not_nil(productions(:one).ephemera_about.find_by_title("One"))
    assert_nil(productions(:one).ephemera_about.find_by_title("Two"))
  end

  should "test book_titles_about relation" do
    productions(:one).book_titles_about << book_titles(:one)
    assert_not_nil(productions(:one).book_titles_about.find_by_title("One"))
    assert_nil(productions(:one).book_titles_about.find_by_title("Two"))
  end

  should "test articles_about relation" do
    productions(:one).articles_about << articles(:one)
    assert_not_nil(productions(:one).articles_about.find_by_title("One"))
    assert_nil(productions(:one).articles_about.find_by_title("Two"))
  end
  
  should "test audio_video_titles_about relation" do
    productions(:one).audio_video_titles_about << audio_video_titles(:one)
    assert_not_nil(productions(:one).audio_video_titles_about.find_by_title("One"))
    assert_nil(productions(:one).audio_video_titles_about.find_by_title("Two"))
  end

  should "test archive_parts_about relation" do
    productions(:one).archive_parts_about << archive_parts(:one)
    assert_not_nil(productions(:one).archive_parts_about.find_by_title("One"))
    assert_nil(productions(:one).archive_parts_about.find_by_title("Two"))
  end
  
  should "delete articles_about relation" do
    production = productions(:one)
    production.articles_about << articles(:one)
    id = production.id
    assert_not_nil(Relationship.find_by_production_id(id))
    production.destroy
    assert_nil(Relationship.find_by_production_id(id))
  end
  
end
