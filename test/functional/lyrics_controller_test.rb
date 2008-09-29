require File.dirname(__FILE__) + '/../test_helper'

class LyricsControllerTest < ActionController::TestCase
  fixtures :lyrics, :users
  
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:lyrics)
  end

  def test_should_show_lyric
    get :show, :id => lyrics(:one).id
    assert_response :success
  end
  
  def test_should_get_new
    login_as(:isaac)
    get :new
    assert_response :success
  end
  
  def test_should_get_new_admin
    login_as(:isaac)
    get :new, :admin => 'true'
    assert_response :success
    using_admin_layout?
  end
  
  def test_should_not_get_new
    get :new
    assert_redirected_to login_path
  end

  def test_should_create_lyric
    login_as(:isaac)
    assert_difference('Lyric.count') do
      post :create, :lyric => new_lyric
    end
    assert_redirected_to lyric_path(assigns(:lyric))
  end

  def test_should_not_create_lyric
    assert_no_difference('Lyric.count') do
      post :create, :lyric => new_lyric
    end
    assert_redirected_to login_path
  end

  def test_should_get_edit
    login_as(:isaac)
    get :edit, :id => lyrics(:one).id
    assert_response :success
  end

  def test_should_get_edit_admin
    login_as(:isaac)
    get :edit, :id => lyrics(:one).id, :admin => 'true'
    assert_response :success
    using_admin_layout?
  end

  def test_should_not_get_edit
    get :edit, :id => lyrics(:one).id
    assert_redirected_to login_path
  end

  def test_should_update_lyric
    login_as(:isaac)
    new_title = "A brand new song"
    put :update, :id => lyrics(:one).id, :lyric => {:title => new_title}
    assert_redirected_to lyric_path(assigns(:lyric))
    assert_equal new_title, assigns(:lyric).title
  end

  def test_should_not_update_lyric
    new_title = "A brand new song"
    put :update, :id => lyrics(:one).id, :lyric => {:title => new_title}
    assert_redirected_to login_path
  end

  def test_should_destroy_lyric
    login_as(:isaac)
    assert_difference('Lyric.count', -1) do
      delete :destroy, :id => lyrics(:one).id
    end
    assert_redirected_to lyrics_path
  end

  def test_should_not_destroy_lyric
    assert_no_difference('Lyric.count') do
      delete :destroy, :id => lyrics(:one).id
    end
    assert_redirected_to login_path
  end

  protected
  
  def new_lyric options={}
    {:title => "A song", :body => "This is a song lalalala"}.merge(options)
  end
end
