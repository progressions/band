require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  it "should be invalid with only title" do
    @blog = Blog.create(:title => "This is a blog")
    @blog.should_not be_valid
  end
  
  it "should be invalid with only body" do
    @blog = Blog.create(:body => "This is a blog")
    @blog.should_not be_valid
  end
  
  it "should be valid with title and body" do
    @blog = Blog.create(:title => "This is a title", :body => "This is a body")
    @blog.should be_valid
  end
end
