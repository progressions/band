class PromosController < ApplicationController
  before_filter :login_required
  before_filter :set_admin
  
  # GET /promos
  # GET /promos.xml
  def index
    @setting = @global_settings
    @promos = Promo.find(:all, :order => "created_at DESC")
  end

  # GET /promos/1
  # GET /promos/1.xml
  def show
    @promo = Promo.find(params[:id])

  end

  # GET /promos/new
  # GET /promos/new.xml
  def new
    @promo = Promo.new
  end

  # GET /promos/1/edit
  def edit
    @promo = Promo.find(params[:id])
  end
  
  # POST /promos
  # POST /promos.xml
  def create
    @promo = Promo.new(params[:promo])

    if params[:preview_button] || !@promo.save
      render :action => "new"
    else
      @global_settings.promo = @promo
      @global_settings.save
      flash[:notice] = 'Promo was successfully created.'
      redirect_to(@promo)
    end
  end

  # PUT /promos/1
  # PUT /promos/1.xml
  def update
    @promo = Promo.find(params[:id])

    if !@promo.update_attributes(params[:promo]) || params[:preview_button]
      render :action => "edit"
    else
      flash[:notice] = 'Promo was successfully updated.'
      redirect_to(@promo)
    end
  end

  # DELETE /promos/1
  # DELETE /promos/1.xml
  def destroy
    @promo = Promo.find(params[:id])
    @promo.destroy
    redirect_to(promos_url) 
  end
end
