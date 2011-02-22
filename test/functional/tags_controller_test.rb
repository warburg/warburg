require File.dirname(__FILE__) + '/../test_helper'

class TagsControllerTest < ActionController::TestCase
  fixtures :users, :people
  
  context "on add" do
    setup do
      login_as(:jos)
      post(:add, :object => "Person", :id => people(:jos).id, :tagfield => "zot, chinees")
    end
    should_assign_to(:object, :tags)
    should_change("Tag.count", :by => 2)
    should_redirect_to("person_path(@object)")
  end
  
end
