class TwitterController < ApplicationController
  before_filter :login_required, :only => [:new]
  
  def index
    @tweets = twitter_feed(50)
  rescue
    @tweets = []
  end

  def new
  end

  # POST /twitter
  def create
    if twitter.update(params[:update])
      flash[:notice] = "Successfully updated Twitter."
    else
      flash[:error] = "There was a problem."
    end
    redirect_to new_twitter_path
  end
end
