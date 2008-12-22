require File.dirname(__FILE__) + '/../spec_helper'

describe Color do
  it "should not be valid without a title" do
    @color = Color.new()
    @color.should_not be_valid
  end
  
  it "should be valid with a title" do
    @color = Color.new(:title => "Default")
    @color.should be_valid
  end
end
