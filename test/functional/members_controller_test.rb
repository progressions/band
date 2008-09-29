require File.dirname(__FILE__) + '/../test_helper'

class MembersControllerTest < ActionController::TestCase
  fixtures :members, :users
  
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:members)
  end
  
  def test_should_get_index_admin
    login_as :isaac
    get :index, :admin => 'true'
    assert_response :success
    assert_not_nil assigns(:members)
    using_admin_layout?
  end

  def test_should_show_member
    get :show, :id => members(:one).id
    assert_response :success
  end

  def test_should_show_member_admin
    login_as :isaac
    get :show, :id => members(:one).url, :admin => 'true'
    assert_response :success
    using_admin_layout?
  end

  def test_should_get_new
    login_as :isaac
    get :new
    assert_response :success
  end

  def test_should_get_new_admin
    login_as :isaac
    get :new, :admin => 'true'
    assert_response :success
    using_admin_layout?
  end

  def test_should_not_get_new
    get :new
    assert_redirected_to login_path
  end

  def test_should_create_member
    login_as :isaac
    assert_difference('Member.count') do
      post :create, :member => new_member
    end

    assert_redirected_to about_path(assigns(:member).url)
  end

  def test_should_not_create_member
    assert_no_difference('Member.count') do
      post :create, :member => new_member
    end

    assert_redirected_to login_path
  end

  def test_should_get_edit
    login_as :isaac
    get :edit, :id => members(:one).id
    assert_response :success
  end

  def test_should_get_edit_admin
    login_as :isaac
    get :edit, :id => members(:one).id, :admin => 'true'
    assert_response :success
    using_admin_layout?
  end

  def test_should_not_get_edit
    get :edit, :id => members(:one).id
    assert_redirected_to login_path
  end

  def test_should_update_member
    login_as :isaac
    put :update, :id => members(:one).id, :member => {:name => "Sammy Guitar"}
    assert_redirected_to about_path(assigns(:member).url)
  end

  def test_should_not_update_member
    put :update, :id => members(:one).id, :member => {:name => "Sammy Guitar"}
    assert_redirected_to login_path
  end

  def test_should_destroy_member
    login_as :isaac
    assert_difference('Member.count', -1) do
      delete :destroy, :id => members(:one).id
    end

    assert_redirected_to members_path
  end

  def test_should_not_destroy_member
    assert_no_difference('Member.count', -1) do
      delete :destroy, :id => members(:one).id
    end

    assert_redirected_to login_path
  end
  
  protected    
  
  def new_member options={}
    {:name => "Freddy Guitar", :url => "freddy", :instruments => "guitar, vocals", :body => "Freddy plays guitar."}.merge(options)
  end
end
