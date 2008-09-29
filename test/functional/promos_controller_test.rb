require File.dirname(__FILE__) + '/../test_helper'

class PromosControllerTest < ActionController::TestCase
  fixtures :promos, :users
  
  def test_should_get_index
    login_as :isaac
    get :index
    assert_response :success
    assert_not_nil assigns(:promos)
  end
  
  def test_should_not_get_index
    get :index
    assert_redirected_to login_path
  end

  def test_should_get_new
    login_as :isaac
    get :new
    assert_response :success
  end

  def test_should_not_get_new
    get :new
    assert_redirected_to login_path
  end

  def test_should_create_promo
    login_as :isaac
    assert_difference('Promo.count') do
      post :create, :promo => new_promo
    end

    assert_redirected_to promo_path(assigns(:promo))
  end

  def test_should_not_create_promo
    assert_no_difference('Promo.count') do
      post :create, :promo => new_promo
    end
    assert_redirected_to login_path
  end

  def test_should_show_promo
    login_as :isaac
    get :show, :id => promos(:one).id
    assert_response :success
  end

  def test_should_not_show_promo
    get :show, :id => promos(:one).id
    assert_redirected_to login_path
  end

  def test_should_get_edit
    login_as :isaac
    get :edit, :id => promos(:one).id
    assert_response :success
  end

  def test_should_not_get_edit
    get :edit, :id => promos(:one).id
    assert_redirected_to login_path
  end

  def test_should_update_promo
    login_as :isaac
    put :update, :id => promos(:one).id, :promo => {:title => "It's a funky promo" }
    assert_redirected_to promo_path(assigns(:promo))
  end

  def test_should_not_update_promo
    put :update, :id => promos(:one).id, :promo => {:title => "It's a funky promo" }
    assert_redirected_to login_path
  end

  def test_should_destroy_promo
    login_as :isaac
    assert_difference('Promo.count', -1) do
      delete :destroy, :id => promos(:one).id
    end

    assert_redirected_to promos_path
  end

  def test_should_not_destroy_promo
    assert_no_difference('Promo.count') do
      delete :destroy, :id => promos(:one).id
    end
    assert_redirected_to login_path
  end
  
  protected
  
  def new_promo options={}
    {:title => "A new promo", :body => "This is a promo"}.merge(options)
  end
end
