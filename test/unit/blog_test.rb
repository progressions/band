require File.dirname(__FILE__) + '/../test_helper'

class BlogTest < ActiveSupport::TestCase
  fixtures :blogs
  
  def test_invalid_with_empty_attributes
    blog = Blog.new
    assert !blog.valid?
    assert blog.errors.invalid?(:title)
    assert blog.errors.invalid?(:body)
  end
  
  def test_invalid_without_title
    blog = Blog.new(:body => "Hey this is a blog")
    assert !blog.valid?
    assert blog.errors.invalid?(:title)
  end
  
  def test_invalid_without_body
    blog = Blog.new(:title => "A blog")
    assert !blog.valid?
    assert blog.errors.invalid?(:body)
  end
  
  def test_valid_blog    
    blog = blogs(:one)
    assert blog.valid?
  end
  
  def test_delete
    count = Blog.count
    blog = blogs(:one)
    blog.destroy
    assert_equal count-1, Blog.count
  end
  
  def test_update
    new_title = "A New Title"
    new_body = "This is a different blog"
    blog = blogs(:one)
    blog.update_attributes(:title => new_title, :body => new_body)
    assert_equal new_title, blog.title
    assert_equal new_body, blog.body
  end
  
  def test_create
    count = Blog.count
    blog = Blog.new(:title => "A blog", :body => "Hey, this is a blog")
    assert blog.save
    assert_equal count+1, Blog.count
  end
  
  def test_read
    assert 2, Blog.count
    blog = Blog.find(1)
    assert_equal blogs(:one).title, blog.title
    assert_equal blogs(:one).body, blog.body
  end
end
