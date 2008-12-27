YAML::add_private_type("Style") do |type, value|
  Style.new(value)
end

class StylesController < ApplicationController
  # caches_page :show
  # cache_sweeper :style_sweeper, :only => [:create, :update, :destroy]
  
  before_filter :login_required, :except => [:show]
  before_filter :set_admin

  def update_preview
    @preview = Style.new(params[:style])
    render :update do |page|
      page.replace_html 'preview', :partial => "preview"
    end
  end
  
  # GET /styles
  # GET /styles.xml
  def index
    @setting = @global_settings
    @styles = Style.find(:all, :order => "created_at DESC")
  end

  # GET /styles/1
  # GET /styles/1.xml
  def show
    @style = Style.find(params[:id])
    
    respond_to do |format|
      format.html { 
        login_required
        render_404 }
      format.css { render :layout => false }
    end
  end
  
  def export
    @style = Style.find(params[:id])
    title = @style.title.gsub(/[\.|\/| ]/, "_")
    filename = "#{title}.yml"
    send_data(
      @style.to_yaml,
      :type => 'text/yaml; charset=utf-8; header=present',
      :filename => filename)
  end
  
  # TODO: Import YAML into new Styles
  def import
    if params[:dump]
      @yaml = YAML.load(params[:dump][:file].read)
      @attributes = @yaml.ivars["attributes"]
      @attributes.delete("created_at")
      @attributes.delete("updated_at")
      @attributes.delete("created_by")
      @style = Style.new(@attributes)
      if @style.save
        flash[:notice] = 'Style was successfully created.'
        redirect_to(styles_path)
      else
        flash[:error] = "There was a problem creating the new style setting."
        render(import_styles_path)
      end
    end
  rescue
    flash[:error] = "There was a problem creating the new style setting."
    render(import_styles_path)
  end

  # GET /styles/new
  # GET /styles/new.xml
  def new
    @style = Style.new
    @preview = @style
  end

  # GET /styles/1/edit
  def edit
    @style = Style.find(params[:id])
    @preview = @style
  end

  # POST /styles
  # POST /styles.xml
  def create
    @style = Style.new(params[:style])
    @style.user = current_user
    if @style.save
      flash[:notice] = 'Style was successfully created.'
      redirect_to(styles_path)
    end
  end

  # PUT /styles/1
  # PUT /styles/1.xml
  def update
    @style = Style.find(params[:id])    
    params[:style][:user] = current_user

    if @style.update_attributes(params[:style])
      flash[:notice] = 'Style was successfully updated.'
      redirect_to(styles_path)
    end
  end

  # DELETE /styles/1
  # DELETE /styles/1.xml
  def destroy
    @style = Style.find(params[:id])
    @style.destroy

    redirect_to(styles_path)
  end
end
