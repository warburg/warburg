require File.dirname(__FILE__) + '/../test_helper'

class AudioVideoTitlesControllerTest < ActionController::TestCase
  fixtures :users, :audio_video_titles
  
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

  def test_should_create_audio_video_title
    login_as :admin
    assert_difference('AudioVideoTitle.count') do
      post :create, :audio_video_title => { }
    end

    assert_redirected_to audio_video_title_path(assigns(:object))
  end

  def test_should_show_audio_video_title
    get :show, :id => audio_video_titles(:one).to_param
    assert_response :success
  end

  def test_should_get_edit
    login_as :admin
    get :edit, :id => audio_video_titles(:one).to_param
    assert_response :success
  end

  def test_should_update_audio_video_title
    login_as :admin
    put :update, :id => audio_video_titles(:one).to_param, :audio_video_title => { }
    assert_redirected_to audio_video_title_path(assigns(:object))
  end

  def test_should_destroy_audio_video_title
    login_as :admin
    assert_difference('AudioVideoTitle.count', -1) do
      delete :destroy, :id => audio_video_titles(:one).to_param
    end

    assert_redirected_to audio_video_titles_path
  end
end
