require File.dirname(__FILE__) + '/../test_helper'

class PersonTest < ActiveSupport::TestCase
  
  fixtures :people, :audio_video_titles, :archive_parts, :articles, :book_titles, :ephemera,  :ico_titles, :productions

  should "report the right admin_fields" do
    assert(!Person.admin_fields.empty?)
  end

  should 'report the right atomic relations' do
    # assert(Person.atomic_relations.include?(:language))
    assert(!Person.atomic_relations.include?(:ico_titles_by))
    assert(!Person.atomic_relations.include?(:productions_by))
    assert(Person.editable_relations.include?(:article_about_people))
  end
  
  should 'report the right editable relations' do
    assert(!Person.editable_relations.include?(:language))
    assert(!Person.editable_relations.include?(:ico_titles_by))
    assert(Person.editable_relations.include?(:ico_title_by_people))
  end

  should "test adding tags" do
    jos = people(:jos)
    assert(jos.tag_list.empty?)
    jos.tag_list = "Funny, Silly"
    assert_save(jos)
    assert_same_elements(jos.tag_list, ["Funny", "Silly"])
  end
  
  should_belong_to :language
  should_belong_to :gender
  
  should_have_many :audio_video_titles_by, :through => :audio_video_title_by_people
  should_have_many :audio_video_titles_about, :through => :audio_video_title_about_people  
  should_have_many :archive_parts_about, :through => :archive_part_about_people
  should_have_many :articles_about, :through => :article_about_people
  should_have_many :articles_by, :through => :article_by_people
  should_have_many :book_titles_by, :through => :book_title_by_people
  should_have_many :book_titles_about, :through => :book_title_about_people
  should_have_many :ephemera_by, :through => :ephemerum_by_people
  should_have_many :ephemera_about, :through => :ephemerum_about_people
  should_have_many :ico_titles_by, :through => :ico_title_by_people
  should_have_many :ico_titles_about, :through => :ico_title_about_people 
  should_have_many :productions_by, :through => :production_by_people

  should "test productions_by relation" do    
    people(:jos).productions_by << productions(:one)
    assert_not_nil(people(:jos).productions_by.find_by_title("One"))
    assert_nil(people(:jos).productions_by.find_by_title("Two"))
  end  
  
  should "test ico_titles_about relation" do    
    people(:jos).ico_titles_about << ico_titles(:one)
    assert_not_nil(people(:jos).ico_titles_about.find_by_title("One"))
    assert_nil(people(:jos).ico_titles_about.find_by_title("Two"))
    assert(people(:jos).ico_titles_by.empty?)    
  end

  should "test ico_titles_by relation" do    
    people(:jos).ico_titles_by << ico_titles(:one)
    assert_not_nil(people(:jos).ico_titles_by.find_by_title("One"))
    assert_nil(people(:jos).ico_titles_by.find_by_title("Two"))
    assert(true, people(:jos).ico_titles_about.empty?)    
  end   
  
  should "test ephemera_by relation" do    
    people(:jos).ephemera_by << ephemera(:one)
    assert_not_nil(people(:jos).ephemera_by.find_by_title("One"))
    assert_nil(people(:jos).ephemera_by.find_by_title("Two"))
    assert(true, people(:jos).ephemera_about.empty?)    
  end
  
  should "test ephemera_about relation" do
    people(:jos).ephemera_about << ephemera(:one)
    assert_not_nil(people(:jos).ephemera_about.find_by_title("One"))
    assert_nil(people(:jos).ephemera_about.find_by_title("Two"))
    assert(true, people(:jos).ephemera_by.empty?)    
  end  
  
  should "test book_titles_about relation" do    
    people(:jos).book_titles_about << book_titles(:one)
    assert_not_nil(people(:jos).book_titles_about.find_by_title("One"))
    assert_nil(people(:jos).book_titles_about.find_by_title("Two"))
    assert(true, people(:jos).book_titles_by.empty?)    
  end

  should "test book_titles_by relation" do    
    people(:jos).book_titles_by << book_titles(:one)
    assert_not_nil(people(:jos).book_titles_by.find_by_title("One"))
    assert_nil(people(:jos).book_titles_by.find_by_title("Two"))
    assert(true, people(:jos).book_titles_about.empty?)    
  end    
  
  should "test articles_about relation" do    
    people(:jos).articles_about << articles(:one)
    assert_not_nil(people(:jos).articles_about.find_by_title("One"))
    assert_nil(people(:jos).articles_about.find_by_title("Two"))
    assert(true, people(:jos).articles_by.empty?)    
  end

  should "test articles_by relation" do    
    people(:jos).articles_by << articles(:one)
    assert_not_nil(people(:jos).articles_by.find_by_title("One"))
    assert_nil(people(:jos).articles_by.find_by_title("Two"))
    assert(true, people(:jos).articles_about.empty?)    
  end  
  
  should "test audio_video_titles_by relation" do    
    people(:jos).audio_video_titles_by << audio_video_titles(:one)
    assert_not_nil(people(:jos).audio_video_titles_by.find_by_title("One"))
    assert_nil(people(:jos).audio_video_titles_by.find_by_title("Two"))
    assert(true, people(:jos).audio_video_titles_about.empty?)    
  end
  
  should "test audio_video_titles_about relation" do
    people(:jos).audio_video_titles_about << audio_video_titles(:one)
    assert_not_nil(people(:jos).audio_video_titles_about.find_by_title("One"))
    assert_nil(people(:jos).audio_video_titles_about.find_by_title("Two"))
    assert(true, people(:jos).audio_video_titles_by.empty?)    
  end
  
  should "test archive_parts_about relation" do
    people(:jos).archive_parts_about << archive_parts(:one)
    assert_not_nil(people(:jos).archive_parts_about.find_by_title("One"))
    assert_nil(people(:jos).archive_parts_about.find_by_title("Two"))    
  end

  should 'define relations' do
    assert_not_nil Person.relations
    assert(3, Person.relations.size)
  end
  
  should 'react correctly to visible scope' do
    Person.visible.first
  end
  
end
