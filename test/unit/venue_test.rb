require File.dirname(__FILE__) + '/../test_helper'

class VenueTest < ActiveSupport::TestCase
  fixtures :venues
    
  def test_invalid_with_empty_attributes
    venue = Venue.new
    assert !venue.valid?
    assert venue.errors.invalid?(:name)
  end
  
  def test_invalid_duplicate_name
    name = "A place"
    venue = Venue.new(:name => name)
    assert venue.save
    venue = Venue.new(:name => name)
    assert !venue.save
    venue = Venue.new(:name => name.downcase)
    assert !venue.save
    venue = Venue.new(:name => name.upcase)
    assert !venue.save    
  end
  
  def test_zipcode
    bad = [1, 12, 123, 123456, 1234567, "a word"]
    good = [00502, 12345, 54321, 10001, 78745, 99999]
    bad.each do |z|
      venue = Venue.new(:name => "A place", :zipcode => z)
      assert !venue.valid?
    end
    good.each do |z|
      venue = Venue.new(:name => "A place", :zipcode => z)
      assert venue.valid?
    end
  end
  
  def test_valid_venue
    venue = venues(:trophys)
    assert venue.valid?
  end
  
  def test_delete
    count = Venue.count
    venue = venues(:trophys)
    venue.destroy
    assert_equal count-1, Venue.count
  end
  
  def test_update
    new_zipcode = 99999
    venue = venues(:trophys)
    assert venue.update_attributes(:zipcode => new_zipcode)
    assert_equal new_zipcode, venue.zipcode
  end
  
  def test_create
    count = Venue.count
    venue = Venue.new(:name => "A place", :zipcode => "78745")
    assert venue.save
    assert_equal count+1, Venue.count
  end
end
