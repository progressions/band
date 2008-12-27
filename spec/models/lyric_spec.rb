require File.dirname(__FILE__) + '/../spec_helper'

describe Lyric do
  it "should be invalid with only title" do
    @lyric = Lyric.create(:title => "This is a lyric")
    @lyric.should_not be_valid
  end
  
  it "should be invalid with only body" do
    @lyric = Lyric.create(:body => "This is a lyric")
    @lyric.should_not be_valid
  end
  
  it "should be valid with title and body" do
    @lyric = Lyric.create(:title => "This is a title", :body => "This is a body")
    @lyric.should be_valid
  end
end
