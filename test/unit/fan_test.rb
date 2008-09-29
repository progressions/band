require File.dirname(__FILE__) + '/../test_helper'

class FanTest < ActiveSupport::TestCase
  fixtures :fans
  
  def test_invalid_with_empty_attributes
    fan = Fan.new
    assert !fan.valid?
    assert fan.errors.invalid?(:email)
    assert fan.errors.invalid?(:zipcode)
  end
   
  def test_invalid_without_email
    fan = Fan.new(:zipcode => "78745")
    assert !fan.valid?
    assert fan.errors.invalid?(:email)
  end
  
  def test_should_require_valid_email
    assert_no_difference 'Fan.count' do
      fan = Fan.create(:email => "notanemail_at_yahoo", :zipcode => "10001")
      assert fan.errors.on(:email)
    end
  end
  
  def test_invalid_without_zipcode
    fan = Fan.new(:email => "fred@yahoo.com")
    assert !fan.valid?
    assert fan.errors.invalid?(:zipcode)
  end
  
  def test_invalid_duplicate_email
    fan = Fan.new(:email => "fred@gmail.com", :zipcode => "10001")
    assert fan.save
    fan = Fan.new(:email => "fred@gmail.com", :zipcode => "10001")
    assert !fan.save
  end
  
  def test_zipcode
    bad = [1, 12, 123, 123456, 1234567, "a word"]
    good = [00502, 12345, 54321, 10001, 78745, 99999]
    bad.each do |z|
      fan = Fan.new(:email => "person@gmail.com", :zipcode => z)
      assert !fan.valid?
    end
    good.each do |z|
      fan = Fan.new(:email => "person@gmail.com", :zipcode => z)
      assert fan.valid?
    end
  end
  
  def test_valid_fan    
    fan = fans(:one)
    assert fan.valid?
  end
  
  def test_delete
    count = Fan.count
    fan = fans(:one)
    fan.destroy
    assert_equal count-1, Fan.count
  end
  
  def test_update
    new_zipcode = 99999
    fan = fans(:one)
    assert fan.update_attributes(:zipcode => new_zipcode)
    assert_equal new_zipcode, fan.zipcode
  end
  
  def test_create
    count = Fan.count
    fan = Fan.new(:email => "norman@yahoo.com", :zipcode => "78745")
    assert fan.save
    assert_equal count+1, Fan.count
  end
  
  def test_read
    assert 2, Fan.count
    fan = Fan.find(1)
    assert_equal fans(:one).email, fan.email
    assert_equal fans(:one).zipcode, fan.zipcode
  end
  
  def test_name
    fan = fans(:one)
    assert_equal "Fred Simpson", fan.name
    fan.name = "Jack Skellington"
    assert "Jack", fan.firstname
    assert "Skellington", fan.lastname
    assert "Jack Skellington", fan.name
  end
end
