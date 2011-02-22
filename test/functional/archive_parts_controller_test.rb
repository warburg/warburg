require File.dirname(__FILE__) + '/../test_helper'

class ArchivePartsControllerTest < ActionController::TestCase
  fixtures :users, :archive_parts

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

  def test_should_create_archive_part
    login_as :jos
    assert_difference('ArchivePart.count') do
      post :create, :archive_part => { }
    end

    assert_redirected_to archive_part_path(assigns(:object))
  end

  def test_should_show_archive_part
    get :show, :id => archive_parts(:one).to_param
    assert_response :success
  end

  def test_should_get_edit
    login_as :jos
    get :edit, :id => archive_parts(:one).to_param
    assert_response :success
  end

  def test_should_update_archive_part
    login_as :jos
    put :update, :id => archive_parts(:one).to_param, :archive_part => { }
    assert_redirected_to archive_part_path(assigns(:object))
  end

  def test_should_destroy_archive_part
    login_as :admin
    assert_difference('ArchivePart.count', -1) do
      delete :destroy, :id => archive_parts(:one).to_param
    end

    assert_redirected_to archive_parts_path
  end
end
