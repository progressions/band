require File.dirname(__FILE__) + '/../spec_helper'

describe Entry do
  it "should be invalid with only title" do
    @entry = Entry.create(:title => "This is a Entry")
    @entry.should_not be_valid
  end
  
  it "should be invalid with only body" do
    @entry = Entry.create(:body => "This is a Entry")
    @entry.should_not be_valid
  end
  
  it "should be valid with title and body" do
    @entry = Entry.create(:title => "This is a title", :body => "This is a body")
    @entry.should be_valid
  end
end
