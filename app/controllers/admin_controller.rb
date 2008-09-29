class AdminController < ApplicationController
  before_filter :set_admin
  before_filter :login_required
  
  def index
    @users = User.find(:all)
  end
  
  protected
  
  def set_admin
    params[:admin] = true
  end
end
