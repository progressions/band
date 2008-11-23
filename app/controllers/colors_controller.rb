class ColorsController < ApplicationController
  # caches_page :show
  # cache_sweeper :color_sweeper, :only => [:create, :update, :destroy]
  
  before_filter :login_required, :except => [:show]
  before_filter :set_admin

  def update_preview
    @preview = Color.new(params[:color])
    render :update do |page|
      page.replace_html 'preview', :partial => "preview"
    end
  end
  
  # GET /colors
  # GET /colors.xml
  def index
    @setting = @global_settings
    @colors = Color.find(:all, :order => "created_at DESC")
  end

  # GET /colors/1
  # GET /colors/1.xml
  def show
    @color = Color.find(params[:id])
    
    respond_to do |format|
      format.html { 
        login_required
        render_404 }
      format.css { render :layout => false }
    end
  end
  
  # TODO: Export colors as YAML
  def export
  end
  
  # TODO: Import YAML into new Colors
  def import
  end

  # GET /colors/new
  # GET /colors/new.xml
  def new
    @color = Color.new
    @preview = @color
  end

  # GET /colors/1/edit
  def edit
    @color = Color.find(params[:id])
    @preview = @color
  end

  # POST /colors
  # POST /colors.xml
  def create
    @color = Color.new(params[:color])
    @color.user = current_user

    respond_to do |format|
      if @color.save
        flash[:notice] = 'Color was successfully created.'
        format.html { redirect_to(colors_path) }
        format.xml  { render :xml => @color, :status => :created, :location => @color }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @color.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /colors/1
  # PUT /colors/1.xml
  def update
    @color = Color.find(params[:id])    
    params[:color][:user] = current_user

    respond_to do |format|
      if @color.update_attributes(params[:color])
        flash[:notice] = 'Color was successfully updated.'
        format.html { redirect_to(colors_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @color.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /colors/1
  # DELETE /colors/1.xml
  def destroy
    @color = Color.find(params[:id])
    @color.destroy

    respond_to do |format|
      format.html { redirect_to(colors_path) }
      format.xml  { head :ok }
    end
  end
end
