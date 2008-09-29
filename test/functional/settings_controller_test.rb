require File.dirname(__FILE__) + '/../test_helper'

class SettingsControllerTest < ActionController::TestCase
  fixtures :settings, :users
  
  def test_should_get_index
    login_as :isaac
    get :index
    assert_response :success
    assert_not_nil assigns(:global_settings)
  end
  
  def test_should_edit_profile
    login_as :isaac
    get :profile
    assert_response :success
  end
  
  def test_should_not_edit_profile
    get :profile
    assert_redirected_to login_path
  end

  # def test_should_create_setting
  #   login_as :isaac
  #   assert_difference('Setting.count') do
  #     post :create, :setting => new_setting
  #   end
  # 
  #   assert_redirected_to admin_path
  # end
  # 
  # def test_should_not_create_setting
  #   assert_no_difference('Setting.count') do
  #     post :create, :setting => new_setting
  #   end
  # 
  #   assert_redirected_to login_path
  # end

  # def test_should_show_setting
  #   login_as :isaac
  #   get :show, :id => settings(:one).id
  #   assert_response :success
  # end

  # def test_should_not_show_setting
  #   get :show, :id => settings(:one).id
  # 
  #   assert_redirected_to login_path
  # end

  # def test_should_get_edit
#     login_as :isaac
#     get :edit, :id => settings(:one).id
#     assert_response :success
#   end
# 
#   def test_should_not_get_edit
#     get :edit, :id => settings(:one).id
# 
#     assert_redirected_to login_path
#   end

  def test_should_update_setting
    login_as :isaac
    put :update, :id => settings(:one).id, :setting => new_setting
    assert_redirected_to admin_path
  end

  def test_should_not_update_setting
    put :update, :id => settings(:one).id, :setting => new_setting

    assert_redirected_to login_path
  end

  def test_should_destroy_setting
    login_as :isaac
    assert_difference('Setting.count', -1) do
      delete :destroy, :id => settings(:one).id
    end

    assert_redirected_to admin_path
  end

  def test_should_not_destroy_setting
    assert_no_difference('Setting.count', -1) do
      delete :destroy, :id => settings(:one).id
    end

    assert_redirected_to login_path
  end
  
  protected
  
  def new_setting options={}
    {:site_name => "World Racketeering Squad - Your Home For Smooth Music!", :artist_name => "Worldwide Racqueteering Squadron", :artist_description => "A cool group"}.merge(options)
  end
end
