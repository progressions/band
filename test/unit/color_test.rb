require File.dirname(__FILE__) + '/../test_helper'

class ColorTest < ActiveSupport::TestCase
  fixtures :colors
  
  def test_invalid_with_empty_attributes
    color = Color.new
    assert !color.valid?
    assert color.errors.invalid?(:title)
  end
  
  def test_invalid_without_title
    color = Color.new(:body => "Hey this is a color")
    assert !color.valid?
    assert color.errors.invalid?(:title)
  end
  
  def test_valid_color    
    color = colors(:one)
    assert color.valid?
  end
  
  def test_delete
    count = Color.count
    color = colors(:one)
    color.destroy
    assert_equal count-1, Color.count
  end
  
  def test_update
    new_title = "A New Title"
    new_body = "This is a different color"
    color = colors(:one)
    color.update_attributes(:title => new_title, :body => new_body)
    assert_equal new_title, color.title
    assert_equal new_body, color.body
  end
  
  def test_create
    count = Color.count
    color = Color.new(:title => "A color", :body => "Hey, this is a color")
    assert color.save
    assert_equal count+1, Color.count
  end
  
  def test_read
    assert 2, Color.count
    color = Color.find(1)
    assert_equal colors(:one).title, color.title
    assert_equal colors(:one).body, color.body
  end
end
