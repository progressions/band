require File.dirname(__FILE__) + '/../test_helper'

class LyricTest < ActiveSupport::TestCase
  fixtures :lyrics
  
  def test_invalid_with_empty_attributes
    lyric = Lyric.new
    assert !lyric.valid?
    assert lyric.errors.invalid?(:title)
    assert lyric.errors.invalid?(:body)
  end
  
  def test_invalid_without_title
    lyric = Lyric.new(:body => "Hey this is a lyric")
    assert !lyric.valid?
    assert lyric.errors.invalid?(:title)
  end
  
  def test_invalid_without_body
    lyric = Lyric.new(:title => "A lyric")
    assert !lyric.valid?
    assert lyric.errors.invalid?(:body)
  end
  
  def test_valid_lyric    
    lyric = lyrics(:one)
    assert lyric.valid?
  end
  
  def test_delete
    count = Lyric.count
    lyric = lyrics(:one)
    lyric.destroy
    assert_equal count-1, Lyric.count
  end
  
  def test_update
    new_title = "A New Title"
    new_body = "This is a different lyric"
    lyric = lyrics(:one)
    lyric.update_attributes(:title => new_title, :body => new_body)
    assert_equal new_title, lyric.title
    assert_equal new_body, lyric.body
  end
end