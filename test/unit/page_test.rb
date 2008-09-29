require File.dirname(__FILE__) + '/../test_helper'

class PageTest < ActiveSupport::TestCase
  fixtures :pages
  
  def test_invalid_with_empty_attributes
    page = Page.new
    assert !page.valid?
    assert page.errors.invalid?(:name)
  end
  
  def test_invalid_without_name
    page = Page.new(:body => "Hey this is a page")
    assert !page.valid?
    assert page.errors.invalid?(:name)
  end
  
  def test_invalid_without_active
    page = Page.new(:name => "A page", :active => nil)
    assert !page.valid?
    assert page.errors.invalid?(:active)
  end
  
  def test_invalid_url
    page = Page.new(:name => "A page", :url => "12/43*7")
    assert !page.valid?
    assert page.errors.invalid?(:url)
    page = Page.new(:name => "A page", :url => "a url with spaces")
    assert !page.valid?
    assert page.errors.invalid?(:url)
  end
  
  def test_valid_page    
    page = pages(:one)
    assert page.valid?
  end
  
  def test_delete
    count = Page.count
    page = pages(:one)
    page.destroy
    assert_equal count-1, Page.count
  end
  
  def test_update
    new_name = "A New name"
    new_body = "This is a different page"
    page = pages(:one)
    page.update_attributes(:name => new_name, :body => new_body)
    assert_equal new_name, page.name
    assert_equal new_body, page.body
  end
  
  def test_create
    count = Page.count
    page = Page.new(:name => "A page", :url => "a_url", :body => "Hey, this is a page")
    assert page.save
    assert_equal count+1, Page.count
  end
  
  def test_read
    assert 2, Page.count
    page = Page.find(1)
    assert_equal pages(:one).name, page.name
    assert_equal pages(:one).body, page.body
  end
end
