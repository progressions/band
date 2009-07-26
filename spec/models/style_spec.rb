require File.dirname(__FILE__) + '/../spec_helper'

describe Style do
  it "should not be valid without a title" do
    @style = Style.new()
    # @style.should_not be_valid
  end
  
  it "should be valid with a title" do
    @style = Style.new(:title => "Default")
    @style.should be_valid
  end
end
