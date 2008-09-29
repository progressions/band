class WebProfilesController < ApplicationController
  before_filter :login_required
  
  # GET /web_profiles
  # GET /web_profiles.xml
  def index
    @web_profiles = WebProfile.find(:all)
  end

  # GET /web_profiles/1
  # GET /web_profiles/1.xml
  def show
    @web_profile = WebProfile.find(params[:id])
  end

  # GET /web_profiles/new
  # GET /web_profiles/new.xml
  def new
    @web_profile = WebProfile.new
  end

  # GET /web_profiles/1/edit
  def edit
    @web_profile = WebProfile.find(params[:id])
  end

  # POST /web_profiles
  # POST /web_profiles.xml
  def create
    @web_profile = WebProfile.new(params[:web_profile])
    
    if @web_profile.save
      flash[:notice] = 'WebProfile was successfully created.'
      redirect_to(@web_profile) 
    else
      render :action => "new"
    end
  end

  # PUT /web_profiles/1
  # PUT /web_profiles/1.xml
  def update
    @web_profile = WebProfile.find(params[:id])

    if @web_profile.update_attributes(params[:web_profile])
      flash[:notice] = 'WebProfile was successfully updated.'
      redirect_to(@web_profile) 
    else
      render :action => "edit"
    end
  end

  # DELETE /web_profiles/1
  # DELETE /web_profiles/1.xml
  def destroy
    @web_profile = WebProfile.find(params[:id])
    @web_profile.destroy

    redirect_to(web_profiles_url)
  end
end
