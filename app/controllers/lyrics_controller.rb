class LyricsController < ApplicationController
  before_filter :login_required, :except => [:index, :show]
  before_filter :show_lyrics?
  
  # GET /lyrics
  # GET /lyrics.xml
  def index
    order = "created_at DESC"
    if params[:sort]
      order = "title" if params[:sort] == "title"
      order = "created_at DESC" if params[:sort] == "recent"
    end
    if params[:search]
      @lyrics = Lyric.search(params[:search], params[:p])
    else
      @lyrics = Lyric.paginate :all, :per_page => 20, :page => params[:p], :order => order
    end
    if @lyrics.empty?
      flash[:notice] = "No lyrics found."
    else
      flash.delete(:notice)
    end
  end

  # GET /lyrics/1
  # GET /lyrics/1.xml
  def show
    @lyric = Lyric.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @lyric }
    end
  end

  # GET /lyrics/new
  # GET /lyrics/new.xml
  def new
    @lyric = Lyric.new
  end

  # GET /lyrics/1/edit
  def edit
    @lyric = Lyric.find(params[:id])
  end

  # POST /lyrics
  # POST /lyrics.xml
  def create
    @lyric = Lyric.new(params[:lyric])
    @lyric.user = current_user
    
    @lyric.composer = "J.Coleman/R.Oliver" unless params[:lyric]

    respond_to do |format|
      if @lyric.save  
        blog_body = "#{@lyric.user.full_name} has posted a new lyric, for the song \"#{@lyric.title}\". Check it out <a href='#{lyric_path(@lyric)}' >here</a>."      
        
        if params["post_blog"] == "yes"
          @blog = Blog.new(:title => "New lyric: #{@lyric.title}", :body => blog_body)
          @blog.user = current_user
          @blog.save
        end
        
        if @global_settings.tweet_updates? && ENV['RAILS_ENV'] == 'production'
          tweet = "New lyric: #{lyric_url(@lyric)}"
          update_twitter(tweet)
        end        
        flash[:notice] = 'Lyric was successfully created.'
        format.html { redirect_to(@lyric) }
        format.xml  { render :xml => @lyric, :status => :created, :location => @lyric }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @lyric.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /lyrics/1
  # PUT /lyrics/1.xml
  def update
    @lyric = Lyric.find(params[:id])

    respond_to do |format|
      if @lyric.update_attributes(params[:lyric])
        flash[:notice] = 'Lyric was successfully updated.'
        format.html { redirect_to(@lyric) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @lyric.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /lyrics/1
  # DELETE /lyrics/1.xml
  def destroy
    @lyric = Lyric.find(params[:id])
    @lyric.destroy

    respond_to do |format|
      format.html { redirect_to(lyrics_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def show_lyrics?
    render_404 unless @global_settings.show_lyrics?
  end
end
