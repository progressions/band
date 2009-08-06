# TODO: Stylesheet into shared directory

class SettingsController < ApplicationController
  layout 'application'
  in_place_edit_for :setting, :site_name
  
  before_filter :login_required
  before_filter :set_admin
  
  # TODO: Settings > Profile
  # TODO: Settings > Mailing List
  # TODO: Settings > Social Networks
  # TODO: Settings > Music
  # TODO: Settings > Modules
  # TODO: Settings > Website (Modules + Header/Footer)
  #
  def index
    @setting = @global_settings
    @blogs = Blog.find(:all)
    @comments = Comment.find(:all)
    @entries = Entry.find(:all)
    @lyrics = Lyric.find(:all)
    @fans = Fan.find(:all)
    @shows_to_date = Show.find(:all, :conditions => ["date < ?", Time.now])
    @shows_upcoming = Show.find(:all, :conditions => ["date >= ?", Time.now])
    @deliveries = Delivery.scoped(:order => "created_at DESC")
  end
  
  def profile
    @setting = @global_settings
  end

  # GET /settings/1
  # GET /settings/1.xml
  def show
    @setting = Setting.find(params[:id])
    respond_to do |format|
      format.html
      format.css { render :layout => false }
    end
  end

  # GET /settings/new
  # GET /settings/new.xml
  def new
    @setting = Setting.new
  end

  # POST /settings
  # POST /settings.xml
  def create
    @setting = Setting.new(params[:setting])

      if @setting.save
        flash[:notice] = 'Settings were successfully created.'
        redirect_to admin_path
      else
        render :action => "new" 
    end
  end

  # PUT /settings/1
  # PUT /settings/1.xml
  def update
    @setting = Setting.find(params[:id])
    if params[:setting][:promo_id]
      params[:setting][:promo] = Promo.find(params[:setting][:promo_id])
    end
    if params[:setting][:color_id]
      params[:setting][:color] = Color.find(params[:setting][:color_id])
    end

    if @setting.update_attributes(params[:setting])
      flash[:notice] = 'Settings were successfully updated.'
      redirect_to profile_path
    else
      render :action => "profile" 
    end
  end

  # DELETE /settings/1
  # DELETE /settings/1.xml
  def destroy
    @setting = Setting.find(params[:id])
    @setting.destroy
    redirect_to admin_path 
  end
end
