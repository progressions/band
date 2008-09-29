require File.dirname(__FILE__) + '/../test_helper'

class BlogsControllerTest < ActionController::TestCase
  fixtures :blogs, :comments, :users
  
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:blogs)
  end

  def test_should_get_new
    login_as(:isaac)
    get :new
    assert_response :success
    assert_select "title", :text => /^Manage/, :count => 0
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

  def test_should_create_blog
    login_as(:isaac)
    assert_difference('Blog.count') do
      post :create, :blog => new_blog
    end
    assert_redirected_to blog_path(assigns(:blog))
  end
 
  def test_should_not_create_blog
    assert_no_difference('Blog.count') do
      post :create, :blog => new_blog
    end
    assert_redirected_to login_path
  end
  
  def test_should_show_blog
    get :show, :id => blogs(:one).id
    assert_not_nil blogs(:one).comments
    assert_response :success
    comment = blogs(:one).comments.first
    assert_select "div.comment", :count => blogs(:one).comments.length
    assert_select "div.comment p.post_date"
    assert_select "a[href$='#{comment.website}']"
    assert_select "div.comment_body", :text => /love this blog/
    assert_select "textarea#comment_body", :text => ""
  end
  
  def test_should_sanitize_comment
    get :show, :id => blogs(:two).id
    assert_not_nil blogs(:two).comments
    assert_response :success
    
    comment = comments(:three)
    assert_select "div.comment", :count => blogs(:two).comments.length
    assert_select "div.comment p.post_date"
    assert_select "p.post_date", :text => eval("/#{comment.name}/"), :count => 0
    assert_select "div.comment_body", :text => eval("/#{comment.body}/"), :count => 0
    assert_select("a[href='#{comment.website}']", :count => 0)
    assert_select "textarea#comment_body", :text => ""
  end
  
  def test_should_get_edit
    login_as(:isaac)
    get :edit, :id => blogs(:one).id
    assert_response :success
  end
  
  def test_should_get_edit_with_admin
    login_as(:isaac)
    get :edit, :id => blogs(:one).id, :admin => 'true'
    assert_response :success
    using_admin_layout?
  end
  
  def test_should_not_get_edit
    get :edit, :id => blogs(:one).id
    assert_redirected_to login_path
  end

  def test_should_update_blog
    new_title = "New blogz!"
    login_as(:isaac)
    put :update, :id => blogs(:one).id, :blog => {:title => new_title}
    assert_redirected_to blog_path(assigns(:blog))
    assert_equal new_title, assigns(:blog).title
  end

  def test_should_not_update_blog
    new_title = "New blogz!"
    put :update, :id => blogs(:one).id, :blog => {:title => new_title}
    assert_redirected_to login_path
  end

  def test_should_destroy_blog
    login_as(:isaac)
    assert_difference('Blog.count', -1) do
      delete :destroy, :id => blogs(:one).id
    end
    assert_redirected_to blogs_path
  end

  def test_should_not_destroy_blog
    assert_no_difference('Blog.count') do
      delete :destroy, :id => blogs(:one).id
    end
    assert_redirected_to login_path
  end
  
  protected
  
  def new_blog options={}
    {:title => "It's a new blog!", :body => "Don't you love new blogs?"}.merge(options)
  end
  
end
