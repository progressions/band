# TODO: Songs database which accepts uploads of mp3s, then plugs those into the mp3 player widget.  mp3s can be stored either on the site itself or on a different server.  
# TODO: Different type of songs database, of songs and set lists, so that set lists can be made by dragging and dropping songs into the set list, and the total time is calculated. 

class SongsController < ApplicationController
  before_filter :login_required, :except => [:index, :show]
  before_filter :set_admin, :except => [:index, :show]
  before_filter :show_music?,  :only => [:index]
  
  # GET /songs
  # GET /songs.xml
  def index
    @songs = Song.paginate :all, :per_page => 10, :page => params[:p], :order => 'created_at DESC'
  end

  # GET /songs/1
  # GET /songs/1.xml
  def show
    @song = Song.find(params[:id])
  end

  # GET /songs/new
  # GET /songs/new.xml
  def new
    @song = Song.new
  end

  # GET /songs/1/edit
  def edit
    @song = Song.find(params[:id])
  end

  # POST /songs
  # POST /songs.xml
  def create
    @song = Song.new(params[:song])

    if @global_settings.songs << @song
      flash[:notice] = 'Song was successfully created.'
            
      update_twitter_with_new_content("New song: #{song_url(@song)}")
      redirect_to(@song)
    else
     render :action => "new" 
    end
  end

  # PUT /songs/1
  # PUT /songs/1.xml
  def update
    @song = Song.find(params[:id])

    if @song.update_attributes(params[:song])
      flash[:notice] = 'Song was successfully updated.'
      redirect_to(@song)
    else
      render :action => "edit"
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.xml
  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    redirect_to(songs_url)
  end
  
  private
  
  def show_music?
    render_404 unless @global_settings.show_music? || admin?
  end
end
