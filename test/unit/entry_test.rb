require File.dirname(__FILE__) + '/../test_helper'

class EntryTest < ActiveSupport::TestCase
  fixtures :all
  
  def test_invalid_with_empty_attributes
    entry = Entry.new
    assert !entry.valid?
    assert entry.errors.invalid?(:title)
    assert entry.errors.invalid?(:body)
  end
  
  def test_invalid_without_title
    entry = Entry.new(:body => "Hey this is a entry")
    assert !entry.valid?
    assert entry.errors.invalid?(:title)
  end
  
  def test_invalid_without_body
    entry = Entry.new(:title => "A entry")
    assert !entry.valid?
    assert entry.errors.invalid?(:body)
  end
  
  def test_valid_entry    
    entry = entries(:one)
    assert entry.valid?
  end
  
  def test_delete
    count = Entry.count
    entry = entries(:one)
    entry.destroy
    assert_equal count-1, Entry.count
  end
  
  
  def test_update
    new_title = "A New Title"
    new_body = "This is a different entry"
    entry = entries(:one)
    entry.update_attributes(:title => new_title, :body => new_body)
    assert_equal new_title, entry.title
    assert_equal new_body, entry.body
  end
  
  
  def test_create
    count = Entry.count
    entry = Entry.new(:title => "A entry", :body => "Hey, this is an entry")
    assert entry.save
    assert_equal count+1, Entry.count
  end
  
  def test_read
    assert 2, Entry.count
    entry = Entry.find(1)
    assert_equal entries(:one).title, entry.title
    assert_equal entries(:one).body, entry.body
  end 
end
