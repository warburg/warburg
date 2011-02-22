require File.dirname(__FILE__) + '/../test_helper'

class ArchivePartAboutGenreTest < ActiveSupport::TestCase
  
  should_belong_to :archive_part, :genre
  
  should_validate_presence_of :archive_part, :genre
  
  fixtures :archive_parts, :genres
  
  should "validate presence of relations" do
    assert !ArchivePartAboutGenre.new.save    
  end
  
end