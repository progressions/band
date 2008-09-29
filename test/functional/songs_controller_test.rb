require File.dirname(__FILE__) + '/../test_helper'

class SongsControllerTest < ActionController::TestCase
  fixtures :songs, :users
  
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:songs)
  end

  def test_should_get_new
    login_as :isaac
    get :new
    assert_response :success
  end

  def test_should_not_get_new_without_login
    get :new
    assert_redirected_to login_path
  end

  def test_should_create_song
    login_as :isaac
    assert_difference('Song.count') do
      post :create, :song => new_song
    end

    assert_redirected_to song_path(assigns(:song))
  end

  def test_should_not_create_song_without_login
    assert_no_difference('Song.count') do
      post :create, :song => new_song
    end
    assert_redirected_to login_path
  end

  def test_should_show_song
    login_as :isaac
    get :show, :id => songs(:one).id
    assert_response :success
  end

  def test_should_get_edit
    login_as :isaac
    get :edit, :id => songs(:one).id
    assert_response :success
  end

  def test_should_not_get_edit_without_login
    get :edit, :id => songs(:one).id
    assert_redirected_to login_path
  end

  def test_should_update_song
    login_as :isaac
    put :update, :id => songs(:one).id, :song => {:title => "It's a funky song" }
    assert_redirected_to song_path(assigns(:song))
  end

  def test_should_not_update_song_without_login
    put :update, :id => songs(:one).id, :song => {:title => "It's a funky song" }
    assert_redirected_to login_path
  end

  def test_should_destroy_song
    login_as :isaac
    assert_difference('Song.count', -1) do
      delete :destroy, :id => songs(:one).id
    end

    assert_redirected_to songs_path
  end

  def test_should_not_destroy_song_without_login
    assert_no_difference('Song.count') do
      delete :destroy, :id => songs(:one).id
    end
    assert_redirected_to login_path
  end
  
  protected
  
  def new_song options={}
    {:title => "Day Tripper", :filename => "daytripper", :body => "She's a big teaser!"}.merge(options)
  end
end
