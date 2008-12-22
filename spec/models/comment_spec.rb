require File.dirname(__FILE__) + '/../spec_helper'

describe Comment do
  it "should not be valid without a name" do
    @comment = Comment.new(:email => "fred@flintstone.com", :body => "I like this.")
    @comment.should_not be_valid
  end
  
  it "should not be valid without an email" do
    @comment = Comment.new(:name => "Fred", :body => "I like this.")
    @comment.should_not be_valid
  end
  
  it "should not be valid without a body" do
    @comment = Comment.new(:name => "Fred", :email => "fred@flintstone.com")
    @comment.should_not be_valid
  end
  
  it "should be valid" do
    @comment = Comment.new(:name => "Fred", :email => "fred@flintstone.com", :body => "I like this.")
    @comment.should be_valid
  end
end