class PagesController < ApplicationController
  before_filter :set_admin, :except => [:index, :show]
  before_filter :login_required, :except => [:index, :show]
  
  # GET /pages
  # GET /pages.xml
  def index
    @pages = Page.find(:all)
  end

  # GET /pages/isaac
  # GET /pages/isaac.xml
  #  - or -
  # GET /pages/1
  # GET /pages/1.xml  
  def show
    begin
      @page = Page.find_by_url_or_id(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end

  # GET /pages/new
  # GET /pages/new.xml
  def new
    @page = Page.new
  end

  # GET /pages/1/edit
  def edit
    begin
      @page = Page.find_by_url_or_id(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = "Could not find page."
      redirect_to home_path
    end
  end

  # POST /pages
  # POST /pages.xml
  def create
    @page = Page.new(params[:page])

    if @page.save
      flash[:notice] = 'Page was successfully created.'
      redirect_to(page_path(@page.url))
    else
      render :action => "new"
    end
  end

  # PUT /pages/1
  # PUT /pages/1.xml
  def update
    @page = Page.find_by_url_or_id(params[:id])

    if @page.update_attributes(params[:page])
      flash[:notice] = 'Page was successfully updated.'
      redirect_to(page_path(@page.url))
    else
      render :action => "edit"
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.xml
  def destroy
    @page = Page.find_by_url_or_id(params[:id])
    @page.destroy
    
    redirect_to(pages_url)
  end
end
