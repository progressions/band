require File.dirname(__FILE__) + '/../test_helper'
require 'xmlrpc_lyrics_controller'

class XmlrpcLyricsController; def rescue_action(e) raise e end; end

class XmlrpcLyricsControllerApiTest < Test::Rails::TestCase
  fixtures :lyrics, :users
  
  def setup
    @controller = XmlrpcLyricsController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
  end
  
  def test_should_get_users_blogs
    blogs = invoke_layered :blogger, :getUsersBlogs, '', 'isaac@example.com', 'test'
    assert_not_nil blogs
    assert_equal '1', blogs[0]['blogId']
    assert_equal "WRS Lyrics", blogs[0]['blogName']
  end
  
  def test_should_not_get_users_blogs
    blogs = invoke_layered :blogger, :getUsersBlogs, '', 'isaac@example.com', 'NOTMYPASSWORD'
    assert_nil blogs
    blogs = invoke_layered :blogger, :getUsersBlogs, '', 'NOT_A_REAL_LOGIN', 'test'
    assert_nil blogs
  end
  
  def test_get_post
    post = invoke_layered :metaWeblog, :getPost, lyrics(:one).id.to_s, 'isaac@example.com', 'test'
    assert_equal lyrics(:one).id.to_s, post['postId']
    assert_equal lyrics(:one).title, post['title']
    assert_equal lyrics(:one).body, post['description']
  end
  
  def test_should_not_get_post_without_login
    post = invoke_layered :metaWeblog, :getPost, lyrics(:one).id.to_s, 'isaac@example.com', 'NOTMYPASSWORD'
    assert_nil post
    post = invoke_layered :metaWeblog, :getPost, lyrics(:one).id.to_s, 'NOT_A_REAL_LOGIN', 'test'
    assert_nil post
  end  
  
  def test_get_recent_posts
    posts = invoke_layered :metaWeblog, :getRecentPosts, '1', 'isaac@example.com', 'test', '1'
    assert_not_nil posts
    assert_equal 1, posts.length
    
    first_post = posts.first    
    post = Lyric.find(first_post['postId'])
    assert_equal post.title, first_post['title']
    assert_equal post.body, first_post['description']
  end
  
  def test_should_not_get_recent_posts_without_login
    posts = invoke_layered :metaWeblog, :getRecentPosts, '1', 'isaac@example.com', 'NOTMYPASSWORD', '1'
    assert_nil posts
    posts = invoke_layered :metaWeblog, :getRecentPosts, '1', 'NOT_A_REAL_LOGIN', 'test', '1'
    assert_nil posts
  end
  
  def test_should_create_post
    post_content = build_post_from_options(
      :title => "A new post!", 
      :body => "It's a brand new post.")
      
    blogs = invoke_layered :blogger, :getUsersBlogs, '', 'isaac@example.com', 'test'
    new_post = invoke_layered :metaWeblog, :newPost, blogs[0]['blogId'], 'isaac@example.com', 'test', post_content, true
    
    # if successful, new_post is the id of the created post
    # otherwise, it's the string "Error: could not create post"
    assert new_post.to_i > 0, new_post.inspect
    
    post = Lyric.find(new_post)
    assert_equal post.title, post_content[:title]
    assert_equal post.body, post_content[:description]
  end
  
  def test_should_not_create_post_without_login
    post_content = build_post_from_options(
      :title => "A new post!", 
      :body => "It's a brand new post.")
    blogs = invoke_layered :blogger, :getUsersBlogs, '', 'isaac@example.com', 'test'
    new_post = invoke_layered :metaWeblog, :newPost, blogs[0]['blogId'], 'isaac@example.com', 'NOTMYPASSWORD', post_content, true
    assert_nil new_post
  end
  
  def test_should_not_create_post_without_body
    post_content = build_post_from_options(
      :title => "A new post!")
    blogs = invoke_layered :blogger, :getUsersBlogs, '', 'isaac@example.com', 'test'
    new_post = invoke_layered :metaWeblog, :newPost, blogs[0]['blogId'], 'isaac@example.com', 'test', post_content, true
    assert_match /Error/, new_post
  end
  
  def test_should_not_create_post_without_title
    post_content = build_post_from_options(
      :body => "It's a brand new post.")
    blogs = invoke_layered :blogger, :getUsersBlogs, '', 'isaac@example.com', 'test'
    new_post = invoke_layered :metaWeblog, :newPost, blogs[0]['blogId'], 'isaac@example.com', 'test', post_content, true
    assert_match /Error/, new_post
  end
  
  protected  
  
  def build_post_from_options options={}
    MetaWeblogStructs::Post.new(
      :dateCreated => options[:created_at] || '',
      :postId => options[:id],
      :description => options[:body],
      :title => options[:title]
    )
  end
end