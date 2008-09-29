require File.dirname(__FILE__) + '/../test_helper'

class FansControllerTest < ActionController::TestCase
  fixtures :fans, :users

  def test_should_get_index
    login_as :isaac
    get :index
    assert_response :success
    assert_not_nil assigns(:fans)
    assert_select 'title', /^Fans/
    # using_admin_layout?
  end

  def test_should_get_index_with_admin
    login_as :isaac
    get :index, :admin => 'true'
    assert_response :success
    assert_not_nil assigns(:fans)
    using_admin_layout?
  end
  
  # test_contacts.csv has 6 entries:
    # Franklin Shankly,frankly.mr.shankly@gmail.com,,,,,,,,,,,,,,,,,,
    # Arizona Slim Whitman,aslimwhitman@yahoo.com,,,,,,,,,,,,,,,,,,
    # ,noname@yahoo.com,,,,,,,,,,,,,,,,,,
    # Arizona Slim Whitman,aslimwhitman@yahoo.com,,,,,,,,,,,,,,,,,,
    # Invalid Email,invalidemailatyahoo.com,,,,,,,,,,,,,,,,,,
    # No Email,,,,,,,,,,,,,,,,,,,
  # Entries 1-3 are valid.
  # Entries 4-6 are invalid:
  # - duplicate email
  # - invalid email
  # - no email
  #
  def test_should_import
    login_as :isaac
    count = Fan.count
    assert_difference('Fan.count', 3) do
      post :import, :dump => {:file => fixture_file_upload('/files/test_contacts.csv')}
      assert_redirected_to fans_path
      
      assert_not_nil Fan.find_by_email("aslimwhitman@yahoo.com")
      assert_nil Fan.find_by_email("invalidemailatyahoo.com")
      assert_nil Fan.find(:first, :conditions => ["firstname = ? AND lastname = ?", "No", "Email"])
    end
    assert assigns(:n) == Fan.count - count
    
    # FIXME: Should be able to confirm using admin layout
    # using_admin_layout?
  end
  
  def test_should_not_import_without_login
    count = Fan.count
    assert_no_difference('Fan.count') do
      post :import, :dump => {:file => fixture_file_upload('/files/test_contacts.csv')}
      assert_redirected_to login_path
      
      assert_nil Fan.find_by_email("aslimwhitman@yahoo.com")
      assert_nil Fan.find_by_email("invalidemailatyahoo.com")
      assert_nil Fan.find(:first, :conditions => ["firstname = ? AND lastname = ?", "No", "Email"])
    end
  end
  
  def test_should_export
    login_as :isaac
    get :export
    assert_response :success
  end  
    
  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_fan
    assert_difference('Fan.count') do
      post(:create, :fan => {:email => 'email@yahoo.com', :zipcode => '10001'})
    end

    assert_redirected_to edit_fan_path(assigns(:fan), :f => assigns(:fan).crypted_email)
  end

  def test_should_show_fan_with_crypted_email
    fan = fans(:one)
    get :show, :id => fan.id, :f => fan.crypted_email
    assert_response :success
  end

  def test_should_show_fan_with_login
    login_as :isaac
    fan = fans(:one)
    get :show, :id => fan.id
    assert_response :success
    # using_admin_layout?
  end

  def test_should_show_fan_with_admin
    login_as :isaac
    fan = fans(:one)
    get :show, :id => fan.id, :admin => 'true'
    assert_response :success
    using_admin_layout?
  end

  def test_should_not_show_fan_without_crypted_email
    fan = fans(:one)
    get :show, :id => fan.id
    assert_redirected_to login_path
  end

  def test_should_get_edit_with_crypted_email
    fan = fans(:one)
    get :edit, :id => fan.id, :f => fan.crypted_email
    assert_response :success
  end

  def test_should_not_get_edit_without_crypted_email
    fan = fans(:one)
    get :edit, :id => fan.id
    assert_redirected_to login_path
  end

  def test_should_edit_fan_with_login
    login_as :isaac
    fan = fans(:one)
    get :edit, :id => fan.id
    assert_response :success
    # using_admin_layout?
  end

  def test_should_edit_fan_with_admin
    login_as :isaac
    fan = fans(:one)
    get :edit, :id => fan.id, :admin => 'true'
    assert_response :success
    using_admin_layout?
  end

  def test_should_update_fan
    put :update, :id => fans(:one).id, :f => fans(:one).crypted_email, :fan => {:zipcode => 99999}
    assert_redirected_to fan_path(assigns(:fan), :f => assigns(:fan).crypted_email)
  end

  def test_should_destroy_fan_with_login
    login_as :isaac
    assert_difference('Fan.count', -1) do
      delete :destroy, :id => fans(:one).id
    end
    assert_redirected_to fans_path
    
    # FIXME: Should be able to confirm using admin layout
    #using_admin_layout?
  end
  
  def test_should_get_unsubscribe_with_crypted_email
    get :unsubscribe, :id => fans(:one).id, :f => fans(:one).crypted_email
    assert_response :success
    assert_select "h1", "Unsubscribe"
  end

  def test_should_destroy_fan_with_crypted_email
    assert_difference('Fan.count', -1) do
      delete :destroy, :id => fans(:one).id, :f => fans(:one).crypted_email
    end

    assert_redirected_to home_path
  end

  def test_should_not_destroy_fan_without_login
    assert_no_difference('Fan.count') do
      delete :destroy, :id => fans(:one).id
    end
    assert_redirected_to login_path
  end
end
