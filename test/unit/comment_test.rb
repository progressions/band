require File.dirname(__FILE__) + '/../test_helper'

class CommentTest < ActiveSupport::TestCase
  fixtures :comments, :blogs
  
  def test_invalid_with_empty_attributes
    comment = Comment.new
    assert !comment.valid?
    assert comment.errors.invalid?(:name)    
    assert comment.errors.invalid?(:email)
    assert comment.errors.invalid?(:body)
  end
  
  def test_invalid_without_name
    comment = Comment.new(:email => "example@example.com", :body => "Hey this is a comment")
    assert !comment.valid?
    assert comment.errors.invalid?(:name)
  end
  
  def test_invalid_without_email
    comment = Comment.new(:name => "Fred", :body => "Hey this is a comment")
    assert !comment.valid?
    assert comment.errors.invalid?(:email)
  end
  
  def test_invalid_without_body
    comment = Comment.new(:name => "Fred", :email => "example@example.com")
    assert !comment.valid?
    assert comment.errors.invalid?(:body)
  end
  
  def test_valid_comment    
    comment = comments(:one)
    assert comment.valid?
  end
  
  def test_delete
    count = Comment.count
    comment = comments(:one)
    comment.destroy
    assert_equal count-1, Comment.count
  end
  
  def test_update
    new_body = "This is a different comment"
    comment = comments(:one)
    comment.update_attributes(:body => new_body)
    assert_equal new_body, comment.body
  end
  
  def test_create
    count = Comment.count
    comment = Comment.new(:name => "Fred", :email => "fred@yahoo.com", :body => "Hey, this is a comment")
    assert comment.save
    assert_equal count+1, Comment.count
  end
  
  def test_read
    assert 2, Comment.count
    comment = Comment.find(1)
    assert_equal comments(:one).name, comment.name
    assert_equal comments(:one).email, comment.email
    assert_equal comments(:one).body, comment.body
  end
end
