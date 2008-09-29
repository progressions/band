require File.dirname(__FILE__) + '/../test_helper'

class CommentsControllerTest < ActionController::TestCase
  fixtures :blogs, :comments, :users  

  def test_should_create_comments
    assert_difference('Comment.count') do
      post :create, :comment => new_comment, :blog => blogs(:one).id 
    end
    assert_redirected_to blog_path(assigns(:comment).blog.id)
    comment = assigns(:comment)
    assert_equal comment.blog, blogs(:one)
    compare_comment comment, new_comment
  end 

  def test_should_create_comments_without_website
    assert_difference('Comment.count') do
      post :create, :comment => new_comment(:website => nil), :blog => blogs(:one).id 
    end
    assert_redirected_to blog_path(assigns(:comment).blog.id)
    comment = assigns(:comment)
    assert_equal comment.blog, blogs(:one)
    compare_comment comment, new_comment(:website => nil)
  end

  def test_should_not_create_comments_without_name
    assert_no_difference('Comment.count') do
      post :create, :comment => new_comment(:name => nil), :blog => blogs(:one).id 
    end
    assert_response :success
    assert_select "title", /New Comment/
  end
  
  def test_should_create_comments_with_subscription    
    assert_difference('Comment.count') do
      post :create, :comment => new_comment, :blog => blogs(:one).id, :subscribe => "1" 
    end
    assert_redirected_to blog_path(assigns(:comment).blog.id)
    comment = assigns(:comment)
    assert_equal comment.blog, blogs(:one)
    compare_comment comment, new_comment
    assert_not_nil assigns(:subscription)
  end

  def test_should_sanitize_website
    bad_comment = new_comment(:website => "javascript:alert('GOTCHA');")
    assert_difference('Comment.count') do
      post :create, :comment => bad_comment, :blog => blogs(:one).id 
    end
    assert_redirected_to blog_path(assigns(:comment).blog.id)
    comment = assigns(:comment)
    assert_equal comment.blog, blogs(:one)
  end 

=begin  
  def test_should_show_comments
    get :show, :id => comments(:one).id
    assert_response :success
  end
  
  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => comments(:one).id
    assert_response :success
  end

  def test_should_update_comments
    put :update, :id => comments(:one).id, :comments => { }
    assert_redirected_to comments_path(assigns(:comments))
  end

  def test_should_destroy_comments
    assert_difference('Comments.count', -1) do
      delete :destroy, :id => comments(:one).id
    end

    assert_redirected_to comments_path
  end
=end
  
  protected
  
  def new_comment options={}
    {:name => "Michael Cutter", :email => "mcutter@nyda.gov", :website => "http://www.nyda.gov/ada/mcutter", :body => "Your honor, the People request this blog entry be remanded into custody until such time as the people have sufficient evidence to indict."}.merge(options)
  end
  
  def compare_comment comment, options 
    comment.name = options[:name]
    comment.email = options[:email]
    comment.website = options[:website]
  end

end
