require File.dirname(__FILE__) + '/../test_helper'

class MemberTest < ActiveSupport::TestCase
  fixtures :members
  
  def test_invalid_with_empty_attributes
    member = Member.new
    assert !member.valid?
    assert member.errors.invalid?(:name)
  end
  
  def test_invalid_without_name
    member = Member.new(:body => "Hey this is a member")
    assert !member.valid?
    assert member.errors.invalid?(:name)
  end
  
  def test_invalid_without_active
    member = Member.new(:name => "A member", :active => nil)
    assert !member.valid?
    assert member.errors.invalid?(:active)
  end
  
  def test_invalid_url
    member = Member.new(:name => "A member", :url => "12/43*7")
    assert !member.valid?
    assert member.errors.invalid?(:url)
  end
  
  def test_valid_member    
    member = members(:one)
    assert member.valid?
  end
  
  def test_delete
    count = Member.count
    member = members(:one)
    member.destroy
    assert_equal count-1, Member.count
  end
  
  def test_update
    new_name = "A New name"
    new_body = "This is a different member"
    member = members(:one)
    member.update_attributes(:name => new_name, :body => new_body)
    assert_equal new_name, member.name
    assert_equal new_body, member.body
  end
  
  def test_create
    count = Member.count
    member = Member.new(:name => "A member", :url => "a_url", :body => "Hey, this is a member")
    assert member.save
    assert_equal count+1, Member.count
  end
  
  def test_read
    assert 2, Member.count
    member = Member.find(1)
    assert_equal members(:one).name, member.name
    assert_equal members(:one).body, member.body
  end
end
