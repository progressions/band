class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  # include AuthenticatedSystem
  
  before_filter :login_required
  
  def index
    set_admin= true
    @users = User.find(:all)
  end
  
  # render new.rhtml
  def new
    set_admin= true
    @user = User.new
  end
  
  def show
    set_admin= true
    @user = User.find(params[:id])
  end
  
  def edit
    set_admin= true
    @user = User.find(params[:id])
  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @user = User.new(params[:user])
    @user.save!
    self.current_user = @user
    redirect_back_or_default('/')
    flash[:notice] = "User was successfully created."
  rescue ActiveRecord::RecordInvalid
    render :action => 'new'
  end

  def update
    cookies.delete :auth_token
    @user = User.find(params[:id])
    
    if !@user.update_attributes(params[:user])
      render :action => "edit"
    else
      flash[:notice] = 'User was successfully updated.'
      redirect_to(@user)
    end
  end
end
