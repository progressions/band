require File.dirname(__FILE__) + '/../test_helper'

class ShowTest < ActiveSupport::TestCase
  fixtures :all
  
  def test_invalid_with_empty_attributes
    show = Show.new
    assert !show.valid?
    assert show.errors.invalid?(:date)
    assert show.errors.invalid?(:venue)
  end
   
  def test_invalid_without_venue
    show = Show.new(:date => "2008-03-05")
    assert !show.valid?
    assert show.errors.invalid?(:venue)
  end
   
  def test_invalid_without_date
    show = Show.new(:venue => venues(:trophys))
    assert !show.valid?
    assert show.errors.invalid?(:date)
  end
  
  def test_valid_show    
    show = shows(:one)
    assert show.valid?
  end
  
  def test_delete
    count = Show.count
    show = shows(:one)
    show.destroy
    assert_equal count-1, Show.count
  end
  
  def test_update
    new_date = "Tue Apr 01 21:00:00 -0500 2008"
    show = shows(:one)
    assert show.update_attributes(:date => new_date)
    assert_equal new_date, show.date.to_s
  end
  
  def test_create
    count = Show.count
    show = Show.new(:date => "Tue Apr 01 21:00:00 -0500 2008", :venue => venues(:trophys))
    assert show.save
    assert_equal count+1, Show.count
  end
  
  def test_read
    assert 2, Show.count
    show = Show.find(1)
    assert_equal shows(:one).date, show.date
    assert_equal shows(:one).venue, show.venue
    assert_equal shows(:one).venue.name, show.venue.name
  end
end
