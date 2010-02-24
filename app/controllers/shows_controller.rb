class ShowsController < ApplicationController
  before_filter :login_required, :except => [:show, :index]
  before_filter :show_shows?, :only => [:show, :index]
  
  # GET /shows
  # GET /shows.xml
  def index
    options = {
      :per_page => 10, :page => params[:p], :order => 'date DESC'
    }
    if admin? && login_required
    else
      options = options.merge(:conditions => ["date > ?", Time.now])
    end
    @venue = Venue.find(params[:venue_id]) if params[:venue_id]
    if @venue
      options = options.merge(:conditions => ["venue_id = ?", params[:venue_id]])
    end
    @shows = Show.paginate(:all, options)
  end
  
  # GET /shows/1
  # GET /shows/1.xml
  def show
    @show = Show.find(params[:id])
  end

  # GET /shows/new
  # GET /shows/new.xml
  def new
    @post_tweet = true
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
    @post_tweet = false
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
      update_twitter_with_new_content("New show: #{@show.venue.name} on #{@show.date.strftime('%b %d')} at #{@show.date.strftime("%I:%M%p").downcase}: #{show_url(@show)}") if params[:post_tweet]
      redirect_to(@show)
    else
      render :action => "new"
    end
  end

  # PUT /shows/1
  # PUT /shows/1.xml
  def update
    @post_tweet = params[:post_tweet] || false
    @show = Show.find(params[:id])    
    @show.venue = Venue.find_or_create_by_name(params[:venue]) if @show.venue.nil?

    if @show.update_attributes(params[:show]) && @show.venue.update_attributes(params[:venue])
      flash[:notice] = "Show was successfully updated."
      update_twitter_with_new_content("Updated show: #{@show.venue.name} on #{@show.date.strftime('%b %d')} at #{@show.date.strftime("%I:%M%p").downcase}: #{show_url(@show)}") if @post_tweet
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
  
  private
  
  def show_shows?
    render_404 unless @global_settings.show_shows? || admin?
  end
end
