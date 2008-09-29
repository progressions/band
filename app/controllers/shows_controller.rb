class ShowsController < ApplicationController
  before_filter :login_required, :except => [:show, :index]
  
  # GET /shows
  # GET /shows.xml
  def index
    if params[:admin] && login_required
      @shows = Show.paginate :all, :per_page => 10, :page => params[:p], :order => 'date DESC'
    else      
      @shows = Show.paginate :all, :per_page => 10, :page => params[:p], :order => 'date', :conditions => ["date > ?", Time.now]
    end
  end
  
  # GET /shows/1
  # GET /shows/1.xml
  def show
    @show = Show.find(params[:id])
  end

  # GET /shows/new
  # GET /shows/new.xml
  def new
    @show = Show.new
    @venue = Venue.new
    @venues = Venue.find(:all)
  end
  
  def old_fill_venue_params
    @venue = Venue.find(params[:venue_id])
    render :update do |page|
      page.replace_html 'venue', :partial => @venue
    end
  end
  
  def fill_venue_params
    venue = Venue.find(params[:venue_id])
    render :update do |page|
      page['venue_name'].value = venue.name
      page['venue_address'].value = venue.address
      page['venue_city'].value = venue.city
      page['venue_state'].value = venue.state
      page['venue_zipcode'].value = venue.zipcode
    end
  end

  # GET /shows/1/edit
  def edit
    @show = Show.find(params[:id])
    @venue = @show.venue.nil? ? Venue.new : @show.venue
    @venues = Venue.find(:all)
  end

  # POST /shows
  # POST /shows.xml
  def create
    @show = Show.new(params[:show])
    @show.user = current_user
    @show.venue = Venue.find_or_create_by_name(params[:venue])

    if @show.venue.valid? && @show.save
      flash[:notice] = 'Show was successfully created.'
      redirect_to(@show)
    else
      render :action => "new"
    end
  end

  # PUT /shows/1
  # PUT /shows/1.xml
  def update
    @show = Show.find(params[:id])    
    @show.venue = Venue.find_or_create_by_name(params[:venue]) if @show.venue.nil?

    if @show.update_attributes(params[:show]) && @show.venue.update_attributes(params[:venue])
      flash[:notice] = "Show was successfully updated."
      redirect_to(@show)
    else
      render :action => "edit"
    end
  end

  # DELETE /shows/1
  # DELETE /shows/1.xml
  def destroy
    @show = Show.find(params[:id])
    @show.destroy
    flash[:notice] = 'Show was successfully deleted.'

    redirect_to(shows_url)
  end
end
