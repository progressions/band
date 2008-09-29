require File.dirname(__FILE__) + '/../test_helper'

class VenuesControllerTest < ActionController::TestCase
=begin
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:venues)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_venue
    assert_difference('Venue.count') do
      post :create, :venue => { }
    end

    assert_redirected_to venue_path(assigns(:venue))
  end

  def test_should_show_venue
    get :show, :id => venues(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => venues(:one).id
    assert_response :success
  end

  def test_should_update_venue
    put :update, :id => venues(:one).id, :venue => { }
    assert_redirected_to venue_path(assigns(:venue))
  end

  def test_should_destroy_venue
    assert_difference('Venue.count', -1) do
      delete :destroy, :id => venues(:one).id
    end

    assert_redirected_to venues_path
  end
  
=end
end
