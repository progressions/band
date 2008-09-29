require File.dirname(__FILE__) + '/../test_helper'

class ColorsControllerTest < ActionController::TestCase
  fixtures :colors, :users 
  
  def test_should_get_index
    login_as :isaac
    get :index
    assert_response :success
    assert_not_nil assigns(:colors)
  end

  def test_should_get_new
    login_as :isaac
    get :new
    assert_response :success
  end

  def test_should_create_color
    login_as :isaac
    assert_difference('Color.count') do
      post :create, :color => { :title => "New" }
    end

    assert_redirected_to colors_path
  end

  def test_should_get_edit
    login_as :isaac
    get :edit, :id => colors(:one).id
    assert_response :success
  end

  def test_should_update_color
    login_as :isaac
    put :update, :id => colors(:one).id, :color => { }
    assert_redirected_to colors_path
  end

  def test_should_destroy_color
    login_as :isaac
    assert_difference('Color.count', -1) do
      delete :destroy, :id => colors(:one).id
    end

    assert_redirected_to colors_path
  end
end
