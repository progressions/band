require File.dirname(__FILE__) + '/../test_helper'

class AboutControllerTest < ActionController::TestCase
  fixtures :settings
    
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:blogs)
    assert_select "title", /#{settings(:one).site_name}/
  end
  
  def test_should_get_rss
    get :rss
    assert_response :success
    assert_not_nil assigns(:items)
  end
  
  def test_should_get_music
    get :music
    assert_response :success
  end
  
  def test_should_get_videos
    get :videos
    assert_response :success
  end
  
  def test_should_get_web
    get :web
    assert_response :success
  end
end