require File.dirname(__FILE__) + '/../test_helper'

class ArchivePartTest < ActiveSupport::TestCase
  
  fixtures :organisations, :archive_parts, :people, :productions
  
  should_belong_to :warehouse
  should_belong_to :donation
  
  should_have_many :about_organisations, :through => :archive_part_about_organisations
  should_have_many :about_productions, :through => :archive_part_about_productions
  should_have_many :about_people, :through => :archive_part_about_people
  
  should "test about_organisations relation" do
    archive_parts(:one).about_organisations << organisations(:one)
    assert_not_nil(archive_parts(:one).about_organisations.find_by_name("One"))
    assert_nil(archive_parts(:one).about_organisations.find_by_name("Two"))
  end

  should "test about_productions relation" do
    archive_parts(:one).about_productions << productions(:one)
    assert_not_nil(archive_parts(:one).about_productions.find_by_title("One"))
    assert_nil(archive_parts(:one).about_productions.find_by_title("Two"))
  end

  should "test about_people relation" do
    archive_parts(:one).about_people << people(:jos)
    assert_not_nil(archive_parts(:one).about_people.find_by_first_name("Jos"))
    assert_nil(archive_parts(:one).about_people.find_by_first_name("Jan"))
  end
  
end
