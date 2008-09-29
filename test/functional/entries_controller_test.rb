require File.dirname(__FILE__) + '/../test_helper'

class EntriesControllerTest < ActionController::TestCase
  fixtures :entries, :users
  
  def setup
    @controller = EntriesController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
  end
  
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:entries)
  end

  def test_should_get_new
    login_as(:isaac)
    get :new
    assert_response :success
    assert_select "title", :text => /Manage/, :count => 0
  end

  def test_should_get_new_admin
    login_as(:isaac)
    get :new, :admin => 'true'
    assert_response :success 
  end
  
  def test_should_not_get_new
    get :new
    assert_redirected_to login_path
  end

  def test_should_create_entry
    login_as(:isaac)
    assert_difference('Entry.count') do
      post :create, :entry => new_entry
    end
    assert_redirected_to entry_path(assigns(:entry))
  end
 
  def test_should_not_create_entry
    assert_no_difference('Entry.count') do
      post :create, :entry => new_entry
    end
    assert_redirected_to login_path
  end
  
  def test_should_show_entry
    get :show, :id => entries(:one).id
    assert_response :success
  end
  
  def test_should_get_edit
    login_as(:isaac)
    get :edit, :id => entries(:one).id
    assert_response :success
  end
  
  def test_should_get_edit_with_admin
    login_as(:isaac)
    get :edit, :id => entries(:one).id, :admin => 'true'
    assert_response :success
    using_admin_layout?
  end
  
  def test_should_not_get_edit
    get :edit, :id => entries(:one).id
    assert_redirected_to login_path
  end

  def test_should_update_entry
    new_title = "New Entreez!"
    login_as(:isaac)
    put :update, :id => entries(:one).id, :entry => {:title => new_title}
    assert_redirected_to entry_path(assigns(:entry))
    assert_equal new_title, assigns(:entry).title
  end

  def test_should_not_update_entry
    new_title = "New Entreez!"
    put :update, :id => entries(:one).id, :entry => {:title => new_title}
    assert_redirected_to login_path
  end

  def test_should_destroy_entry
    login_as(:isaac)
    assert_difference('Entry.count', -1) do
      delete :destroy, :id => entries(:one).id
    end
    assert_redirected_to entries_path
  end

  def test_should_not_destroy_entry
    assert_no_difference('Entry.count') do
      delete :destroy, :id => entries(:one).id
    end
    assert_redirected_to login_path
  end
  
  protected
  
  def new_entry options={}
    {:title => "It's a new entry!", :body => "Don't you love new entries?"}.merge(options)
  end
  
end
