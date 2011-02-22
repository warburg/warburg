require File.dirname(__FILE__) + '/../test_helper'

class AudioVideoTitleTest < ActiveSupport::TestCase
  
  fixtures :people, :audio_video_titles, :organisations, :productions, :functions
  
  should_have_many :by_people, :through => :audio_video_title_by_people
  should_have_many :about_people, :through => :audio_video_title_about_people  
  should_have_many :by_organisations, :through => :audio_video_title_by_organisations
  should_have_many :about_organisations, :through => :audio_video_title_about_organisations 
  should_have_many :about_productions, :through => :audio_video_title_about_productions
  
  should "test function on by people relation" do
    a = audio_video_titles(:one)
    a.by_people << people(:jos)
    rel = a.audio_video_title_by_people.first
    rel.function = functions(:person_function)
    assert(true, rel.save)
    assert(true, a.save)
    a.audio_video_title_by_people.each {|r| r.save!}
    assert_not_nil(a.audio_video_title_by_people.first.function)
    b = AudioVideoTitle.find(audio_video_titles(:one).id).audio_video_title_by_people.first
    assert_not_nil(b.function)
    assert(true, a.audio_video_title_by_people.first.function.name_nl == functions(:person_function).name_nl)
  end

  should "test function on by people relation should not accept OrganisationRelation" do
    a = audio_video_titles(:one)
    a.by_people << people(:jos)
    begin
      a.audio_video_title_by_people.first.function = functions(:organisation_function)
      fail("The above line should've thrown an exception")
    rescue => bang
      # It's ok. We want this exception to happen.
    end
  end

  should "test by people relation" do    
    (audio_video_titles(:one)).by_people << people(:jos)    
    assert_not_nil((audio_video_titles(:one)).by_people.find_by_first_name("Jos"))
    assert_nil((audio_video_titles(:one)).by_people.find_by_first_name("Jan"))
  end
  
  should "test about people relation" do
    (audio_video_titles(:one)).about_people << people(:jos)    
    assert_not_nil((audio_video_titles(:one)).about_people.find_by_first_name("Jos"))
    assert_nil((audio_video_titles(:one)).about_people.find_by_first_name("Jan"))
  end
  
  should "test by organisation relation" do
    (audio_video_titles(:one)).by_organisations << organisations(:one)    
    assert_not_nil((audio_video_titles(:one)).by_organisations.find_by_name("One"))
    assert_nil((audio_video_titles(:one)).by_organisations.find_by_name("Two"))
  end
  
  should "test about organisation relation" do
    (audio_video_titles(:one)).about_organisations << organisations(:one)    
    assert_not_nil((audio_video_titles(:one)).about_organisations.find_by_name("One"))
    assert_nil((audio_video_titles(:one)).about_organisations.find_by_name("Two"))
  end
  
  should "test about production relation" do
    (audio_video_titles(:one)).about_productions << productions(:one)    
    assert_not_nil((audio_video_titles(:one)).about_productions.find_by_title("One"))
    assert_nil((audio_video_titles(:one)).about_productions.find_by_title("Two"))
  end
end
