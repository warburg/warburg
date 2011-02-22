require File.dirname(__FILE__) + '/../test_helper'

class BookTitlesControllerTest < ActionController::TestCase
  fixtures :users, :book_titles
  
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

  def test_should_create_book_title
    login_as :admin
    assert_difference('BookTitle.count') do
      post :create, :book_title => { }
    end

    assert_redirected_to book_title_path(assigns(:object))
  end

  def test_should_show_book_title
    login_as :admin
    get :show, :id => book_titles(:one).to_param
    assert_response :success
  end

  def test_should_get_edit
    login_as :admin
    get :edit, :id => book_titles(:one).to_param
    assert_response :success
  end

  def test_should_update_book_title
    login_as :admin
    put :update, :id => book_titles(:one).to_param, :book_title => { }
    assert_redirected_to book_title_path(assigns(:object))
  end

  def test_should_destroy_book_title
    login_as :admin
    assert_difference('BookTitle.count', -1) do
      delete :destroy, :id => book_titles(:one).to_param
    end

    assert_redirected_to book_titles_path
  end
end
