require File.dirname(__FILE__) + '/../spec_helper'

describe Fan do
  it "should be invalid without email" do
    @fan = Fan.create(:zipcode => "12345")
    @fan.should_not be_valid
  end
  
  it "should be invalid without proper email" do
    @fan = Fan.create(:email => "fred@flinstone", :zipcode => "12345")
    @fan.should_not be_valid
    
    @fan.email = "fredflinstone.com"
    @fan.should_not be_valid
    
    @fan.email = "fredflinstone"
    @fan.should_not be_valid
  end
  
  it "should be invalid without zipcode" do
    @fan = Fan.create(:email => "fred@flintstone.com")
    @fan.should_not be_valid
  end
  
  it "should be valid with email and zipcode" do
    @fan = Fan.create(:email => "fred@flinstone.com", :zipcode => "12345")
    @fan.should be_valid
  end
end
