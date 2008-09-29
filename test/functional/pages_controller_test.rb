require File.dirname(__FILE__) + '/../test_helper'

class PagesControllerTest < ActionController::TestCase
  fixtures :pages, :users
  
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:pages)
  end
  
  def test_should_get_index_admin
    login_as :isaac
    get :index, :admin => 'true'
    assert_response :success
    assert_not_nil assigns(:pages)
    using_admin_layout?
  end

  def test_should_show_page
    get :show, :id => pages(:one).id
    assert_response :success
  end

  def test_should_show_page_admin
    login_as :isaac
    get :show, :id => pages(:one).url, :admin => 'true'
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

  def test_should_create_page
    login_as :isaac
    assert_difference('Page.count') do
      post :create, :page => new_page
    end
    #assert false, assigns(:page).url

    assert_redirected_to page_path(assigns(:page).url)
  end

  def test_should_not_create_page
    assert_no_difference('Page.count') do
      post :create, :page => new_page
    end

    assert_redirected_to login_path
  end

  def test_should_get_edit
    login_as :isaac
    get :edit, :id => pages(:one).id
    assert_response :success
  end

  def test_should_get_edit_admin
    login_as :isaac
    get :edit, :id => pages(:one).id, :admin => 'true'
    assert_response :success
    using_admin_layout?
  end

  def test_should_not_get_edit
    get :edit, :id => pages(:one).id
    assert_redirected_to login_path
  end

  def test_should_update_page
    login_as :isaac
    put :update, :id => pages(:one).id, :page => {:name => "Sammy Guitar"}
    assert_redirected_to page_path(assigns(:page).url)
  end

  def test_should_not_update_page
    put :update, :id => pages(:one).id, :page => {:name => "Sammy Guitar"}
    assert_redirected_to login_path
  end

  def test_should_destroy_page
    login_as :isaac
    assert_difference('Page.count', -1) do
      delete :destroy, :id => pages(:one).id
    end

    assert_redirected_to pages_path
  end

  def test_should_not_destroy_page
    assert_no_difference('Page.count', -1) do
      delete :destroy, :id => pages(:one).id
    end

    assert_redirected_to login_path
  end
  
  protected    
  
  def new_page options={}
    {:name => "Freddy Guitar", :url => "freddy", :body => "Freddy plays guitar."}.merge(options)
  end
end
