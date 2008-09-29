require File.dirname(__FILE__) + '/../test_helper'
require File.dirname(__FILE__) + '/../../vendor/rails/actionpack/lib/action_view/helpers/sanitize_helper'


# use "truncate" to test the mail views
include ActionView::Helpers::TextHelper

class MailsControllerTest < ActionController::TestCase  
  fixtures :mails, :users  
  
  def test_should_get_index
    login_as(:isaac)
    get :index
    assert_response :success
    assert_not_nil assigns(:mails)
    assert_select "h3", /#{truncate(mails(:one).title, 30)}/
  end
  
  def test_should_get_index_admin
    login_as(:isaac)
    get :index, :admin => 'true'
    assert_response :success
    assert_not_nil assigns(:mails)
    using_admin_layout?
  end
  
  def test_should_not_get_index    
    get :index
    assert_redirected_to login_path
  end
  
  def test_should_deliver
    login_as(:isaac)
    put :deliver, :id => mails(:one), :deliver_button => "true"
    assert_redirected_to mails_path
  end
  
  def test_should_deliver_by_city
    login_as(:isaac)
    put :deliver, :id => mails(:one), :deliver_button => "Send", :fans_by_city => {:city => "Austin"}
    # austin_fans = Fan.find_by_city("Austin")
    assert_redirected_to mails_path
  end
  
  def test_should_not_get_deliver
    put :deliver, :id => mails(:one)
    assert_redirected_to login_path    
  end
  
  def test_should_get_select
    login_as(:isaac)
    get :select, :id => mails(:one)
    assert_response :success
    assert_select "select" do
      ["Everywhere", "In a specific city", "In a specific state", "In a specific postal code"].each do |o|
        assert_select "option", o
      end
    end
  end
  
  def test_should_not_get_select
    get :select, :id => mails(:one)
    assert_redirected_to login_path    
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

  def test_should_create_mail
    login_as(:isaac)
    assert_difference('Mail.count') do
      post :create, :mail => new_mail
    end
    assert_redirected_to mail_path(assigns(:mail))
  end

  def test_should_not_create_mail
    assert_no_difference('Mail.count') do
      post :create, :mail => new_mail
    end
    assert_redirected_to login_path  
  end
  
  def test_should_show_mail
    login_as(:isaac)
    get :show, :id => mails(:one).id
    assert_response :success
    assert_select "h3", /#{mails(:one).title}/
  end
  
  def test_should_not_show_mail
    get :show, :id => mails(:one).id
    assert_redirected_to login_path  
  end

  def test_should_get_edit
    login_as(:isaac)
    get :edit, :id => mails(:one).id
    assert_response :success
  end

  def test_should_get_edit_admin
    login_as(:isaac)
    get :edit, :id => mails(:one).id, :admin => 'true'
    assert_response :success
    using_admin_layout?
  end

  def test_should_not_get_edit
    get :edit, :id => mails(:one).id
    assert_redirected_to login_path  
  end

  def test_should_update_mail
    login_as(:isaac)
    put :update, :id => mails(:one).id, :mail => {:title => "A new title"}
    assert_redirected_to mail_path(assigns(:mail))
  end

  def test_should_not_update_mail
    put :update, :id => mails(:one).id, :mail => {:title => "A new title"}
    assert_redirected_to login_path
  end
  
  def test_should_destroy_mail
    login_as(:isaac)
    assert_difference('Mail.count', -1) do
      delete :destroy, :id => mails(:one).id
    end
    assert_redirected_to mails_path
  end
  
  def test_should_not_destroy_mail
    assert_no_difference('Mail.count') do
      delete :destroy, :id => mails(:one).id
    end
    assert_redirected_to login_path
  end
  
  protected
  
  def new_mail(options = {})
    {:title => "A new mail", :body => "This is what being a mail is all about."}.merge(options)
  end
end
