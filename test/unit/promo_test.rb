require File.dirname(__FILE__) + '/../test_helper'

class PromoTest < ActiveSupport::TestCase

  fixtures :promos
  
  def test_invalid_with_empty_attributes
    promo = Promo.new
    assert !promo.valid?
    assert promo.errors.invalid?(:title)
    assert promo.errors.invalid?(:body)
  end
  
  def test_invalid_without_title
    promo = Promo.new(:body => "Hey this is a promo")
    assert !promo.valid?
    assert promo.errors.invalid?(:title)
  end
  
  def test_invalid_without_body
    promo = Promo.new(:title => "A promo")
    assert !promo.valid?
    assert promo.errors.invalid?(:body)
  end
  
  def test_valid_promo    
    promo = promos(:one)
    assert promo.valid?
  end
  
  def test_delete
    count = Promo.count
    promo = promos(:one)
    promo.destroy
    assert_equal count-1, Promo.count
  end
  
  def test_update
    new_title = "A New Title"
    new_body = "This is a different promo"
    promo = promos(:one)
    promo.update_attributes(:title => new_title, :body => new_body)
    assert_equal new_title, promo.title
    assert_equal new_body, promo.body
  end
  
  def test_create
    count = Promo.count
    promo = Promo.new(:title => "A promo", :body => "Hey, this is a promo")
    assert promo.save
    assert_equal count+1, Promo.count
  end
  
  def test_read
    assert 2, Promo.count
    promo = Promo.find(1)
    assert_equal promos(:one).title, promo.title
    assert_equal promos(:one).body, promo.body
  end
end
