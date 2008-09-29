require File.dirname(__FILE__) + '/../test_helper'

class ShowsControllerTest < ActionController::TestCase
  fixtures :shows, :venues, :users
  
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:shows)
  end
  
  def test_should_get_new
    login_as(:isaac)
    get :new
    assert_response :success
    assert_select "h1", "New Show"
    assert_select "select[id^=show_end_time]"
  end
  
  def test_should_not_get_new
    get :new
    assert_redirected_to login_path
  end

  def test_should_create_show
    login_as(:isaac)
    assert_difference('Show.count') do
      post :create, :show => new_show, :venue => {:name => venues(:trophys).name}
    end
    assert_equal venues(:trophys), assigns(:show).venue
    assert_redirected_to show_path(assigns(:show))
  end

  def test_should_create_show_and_venue
    login_as(:isaac)
    assert_difference('Show.count') do
      assert_difference('Venue.count') do
        post :create, :show => new_show, :venue => new_venue
      end
    end
    assert_equal new_venue[:name], assigns(:show).venue.name
    assert_equal new_venue[:address], assigns(:show).venue.address
    assert_equal new_venue[:zipcode], assigns(:show).venue.zipcode
    assert_redirected_to show_path(assigns(:show))
  end

  def test_should_not_create_show_without_venue_name
    login_as(:isaac)
    assert_no_difference('Show.count') do
      assert_no_difference('Venue.count') do
        post :create, :show => new_show, :venue => new_venue(:name => nil)
      end
    end
    assert_response :success
    assert_select "h1", "New Show"
  end

  def test_should_not_create_show
    assert_no_difference('Show.count') do
      venue = Venue.find(venues(:trophys).id)
      post :create, :show => new_show, :venue => venues(:trophys).name
    end
    assert_redirected_to login_path
  end
  
  def test_should_show_show
    get :show, :id => shows(:one).id
    assert_response :success
    assert_select "li.title", shows(:one).title
    assert_select "li.address", shows(:one).address
    # assert_select "li.time", /\d:\d\d[ap]m - \d{1,2}?:\d\d[ap]m/
    assert_select "li.time", / - /
  end

  def test_should_get_edit
    login_as(:isaac)
    get :edit, :id => shows(:one).id
    assert_response :success
    assert_select "h1", "Edit Show"
    assert_select "input#venue_name"
  end
  
  def test_should_not_get_edit
    get :edit, :id => shows(:one).id
    assert_redirected_to login_path
  end

  def test_should_update_show
    new_title = "BIG SHOW"
    login_as(:isaac)
    put :update, :id => shows(:one).id, :show => {:title => new_title}
    assert_redirected_to show_path(assigns(:show))
    assert_equal new_title, assigns(:show).title
  end
  
  def test_should_update_venue
    new_address = "1313 Mockingbird Lane"
    login_as(:isaac)
    put :update, :id => shows(:one).id, :show => {}, :venue => {:address => new_address}
    assert_redirected_to show_path(assigns(:show))
    assert_equal new_address, assigns(:show).venue.address
  end
  
  def test_should_not_update_show
    new_title = "BIG SHOW"
    put :update, :id => shows(:one).id, :show => {:title => new_title}
    assert_redirected_to login_path
  end

  def test_should_not_destroy_show
    assert_no_difference('Show.count') do
      delete :destroy, :id => shows(:one).id
    end
    assert_redirected_to login_path
  end

  def test_should_destroy_show
    login_as(:isaac)
    assert_difference('Show.count', -1) do
      delete :destroy, :id => shows(:one).id
    end
    assert_redirected_to shows_path
  end
  
  protected
  
  def new_show options={}
    {:title => "A brand new show", :date => "2008-03-05", :time => "22:00", :end_time => "24:00"}.merge(options)
  end
  
  def new_venue options={}
    {:name => "A new place!", :address => "100 My Street", :zipcode => 78701}.merge(options)
  end
end
