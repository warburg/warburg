require File.dirname(__FILE__) + '/../test_helper'


class EphemeraControllerTest < ActionController::TestCase
  fixtures :users, :ephemera
  
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:subtitles)
  end

  def test_should_get_new
    login_as :admin
    get :new
    assert_response :success
  end

  def test_should_create_ephemerum
    login_as :admin
    assert_difference('Ephemerum.count') do
      post :create, :ephemerum => { }
    end

    assert_redirected_to ephemerum_path(assigns(:object))
  end

  def test_should_show_ephemerum
    get :show, :id => ephemera(:one).to_param
    assert_response :success
  end

  def test_should_get_edit
    login_as :admin
    get :edit, :id => ephemera(:one).to_param
    assert_response :success
  end

  def test_should_update_ephemerum
    login_as :admin
    put :update, :id => ephemera(:one).to_param, :ephemerum => { }
    assert_redirected_to ephemerum_path(assigns(:object))
  end

  def test_should_destroy_ephemerum
    login_as :admin
    assert_difference('Ephemerum.count', -1) do
      delete :destroy, :id => ephemera(:one).to_param
    end

    assert_redirected_to ephemera_path
  end
end
