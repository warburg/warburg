require File.dirname(__FILE__) + '/../test_helper'

class ProductionsControllerTest < ActionController::TestCase
  fixtures :users, :productions
  
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:subtitles)
  end

  def test_should_get_new
    login_as :jos
    get :new
    assert_response :success
  end

  def test_should_create_production
    login_as :jos
    assert_difference('Production.count') do
      post :create, :production => { }
    end

    assert_redirected_to production_path(assigns(:object))
  end

  def test_should_show_production
    get :show, :id => productions(:one).to_param
    assert_response :success
  end

  def test_should_get_edit
    login_as :jos
    get :edit, :id => productions(:one).to_param
    assert_response :success
  end

  def test_should_update_production
    login_as :jos
    put :update, :id => productions(:one).to_param, :production => { }
    assert_redirected_to production_path(assigns(:object))
  end

  def test_should_destroy_production
    login_as :jos
    assert_difference('Production.count', -1) do
      delete :destroy, :id => productions(:one).to_param
    end

    assert_redirected_to productions_path
  end
end
