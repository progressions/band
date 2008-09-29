# TODO: Images into shared directory
# TODO: Stylesheet into shared directory

class SettingsController < ApplicationController
  layout 'application'
  in_place_edit_for :setting, :site_name
  
  before_filter :login_required
  before_filter :set_admin
  
  # TODO: Add "web profiles" to setting
  
  # GET /settings
  # GET /settings.xml
  def index
    @setting = @global_settings
    @blogs = Blog.find(:all)
    @comments = Comment.find(:all)
    @entries = Entry.find(:all)
    @lyrics = Lyric.find(:all)
    @fans = Fan.find(:all)
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

  # GET /settings/1/edit
  def edit
    @setting = Setting.find(params[:id])
  end

  # POST /settings
  # POST /settings.xml
  def create
    @setting = Setting.new(params[:setting])

      if @setting.save
        flash[:notice] = 'Setting was successfully created.'
        redirect_to admin_path
      else
        render :action => "new" 
    end
  end

  # PUT /settings/1
  # PUT /settings/1.xml
  def update
    # raise "OMG"
    @setting = Setting.find(params[:id])
    if params[:setting][:promo_id]
      params[:setting][:promo] = Promo.find(params[:setting][:promo_id])
    end
    if params[:setting][:color_id]
      params[:setting][:color] = Color.find(params[:setting][:color_id])
    end

    if @setting.update_attributes(params[:setting])      
      flash[:notice] = 'Setting was successfully updated.'
      redirect_to admin_path
    else
      render :action => "edit" 
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
