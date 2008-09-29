require File.dirname(__FILE__) + '/../test_helper'

class WebProfilesControllerTest < ActionController::TestCase
  fixtures :users, :web_profiles
  
  def test_should_get_index
    login_as :isaac
    get :index
    assert_response :success
    assert_not_nil assigns(:web_profiles)
  end

  def test_should_get_new
    login_as :isaac
    get :new
    assert_response :success
  end

  def test_should_create_web_profile
    login_as :isaac
    assert_difference('WebProfile.count') do
      post :create, :web_profile => new_web_profile
    end

    assert_redirected_to web_profile_path(assigns(:web_profile))
  end

  def test_should_show_web_profile
    login_as :isaac
    get :show, :id => web_profiles(:one).id
    assert_response :success
  end

  def test_should_get_edit
    login_as :isaac
    get :edit, :id => web_profiles(:one).id
    assert_response :success
  end

  def test_should_update_web_profile
    login_as :isaac
    put :update, :id => web_profiles(:one).id, :web_profile => new_web_profile
    assert_redirected_to web_profile_path(assigns(:web_profile))
  end

  def test_should_destroy_web_profile
    login_as :isaac
    assert_difference('WebProfile.count', -1) do
      delete :destroy, :id => web_profiles(:one).id
    end

    assert_redirected_to web_profiles_path
  end
  
  protected
  
  def new_web_profile options={}
    {:name => "MySpace", :url => "http://www.myspace.com/yermomma", :image => ""}
  end
end
