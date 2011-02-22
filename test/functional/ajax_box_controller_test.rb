require File.dirname(__FILE__) + '/../test_helper'

class AjaxBoxControllerTest < ActionController::TestCase
  
  fixtures :users, :productions
  
  context "on fetch" do
    setup do
      login_as(:jos)
      get(:fetch, :object => "Production", :id => productions(:one).id, :relation => "productions_by", :klazz => 'Person', :pid => 'uh')
    end
    should_assign_to(:object, :dls)
  end
  
  
end