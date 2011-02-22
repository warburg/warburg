require File.dirname(__FILE__) + '/../test_helper'

class IcoTitlesControllerTest < ActionController::TestCase
  fixtures :users, :ico_titles

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

  def test_should_create_ico_title
    login_as :jos
    assert_difference('IcoTitle.count') do
      post :create, :ico_title => { }
    end

    assert_redirected_to ico_title_path(assigns(:object))
  end

  def test_should_show_ico_title
    get :show, :id => ico_titles(:one).to_param
    assert_response :success
  end

  def test_should_get_edit
    login_as :jos
    get :edit, :id => ico_titles(:one).to_param
    assert_response :success
  end

  def test_should_update_ico_title
    login_as :jos
    put :update, :id => ico_titles(:one).to_param, :ico_title => { }
    assert_redirected_to ico_title_path(assigns(:object))
  end

  def test_should_destroy_ico_title
    login_as :jos
    assert_difference('IcoTitle.count', -1) do
      delete :destroy, :id => ico_titles(:one).to_param
    end

    assert_redirected_to ico_titles_path
  end
end
