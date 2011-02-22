require File.dirname(__FILE__) + '/../test_helper'

class ArticlesControllerTest < ActionController::TestCase
  fixtures :users, :articles
  
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

  def test_should_create_article
    login_as :admin
    assert_difference('Article.count') do
      post :create, :article => { }
    end

    assert_redirected_to article_path(assigns(:object))
  end

  def test_should_show_article
    get :show, :id => articles(:one).to_param
    assert_response :success
  end

  def test_should_get_edit
    login_as :admin
    get :edit, :id => articles(:one).to_param
    assert_response :success
  end

  def test_should_update_article
    login_as :admin
    put :update, :id => articles(:one).to_param, :article => { }
    assert_redirected_to article_path(assigns(:object))
  end

  def test_should_destroy_article
    login_as :admin
    assert_difference('Article.count', -1) do
      delete :destroy, :id => articles(:one).to_param
    end

    assert_redirected_to articles_path
  end
end
