class TwitterController < ApplicationController
  before_filter :login_required, :only => [:new]
  
  def index
    @tweets = twitter_feed(50)
  end

  def new
  end

  # POST /twitter
  def create
    
  end
end
