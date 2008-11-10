require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BlogsController do
  
  before(:each) do
    @blog = mock_model(Blog, :save => true)
    Blog.stub!(:new).and_return(@blog)
  end

  def do_create
    post :create, :blog => {:title => "This is a title", :body => "This is a body."}
  end

  it "should create a new blog" do
    #Blog.should_receive(:new).and_return(@blog)
    
    do_create
    
  end

end
