class EntriesController < ApplicationController
  before_filter :login_required, :except => [:show, :index]
  
  # GET /entries
  # GET /entries.xml
  def index
    @entries = Entry.paginate :all, :per_page => 5, :page => params[:p], :order => 'created_at DESC'
  end

  # GET /entries/1
  # GET /entries/1.xml
  def show
    @entry = Entry.find(params[:id])
  end

  # GET /entries/new
  # GET /entries/new.xml
  def new
    @entry = Entry.new
  end

  # GET /entries/1/edit
  def edit
    @entry = Entry.find(params[:id])
  end

  # POST /entries
  # POST /entries.xml
  def create
    @entry = Entry.new(params[:entry])
    @entry.user = current_user
    
    if params[:preview_button] || !@entry.save
      @show_byline = false
      render :action => "new"
    else
      flash[:notice] = 'News entry was successfully created.'
      redirect_to(@entry)
    end
  end

  # PUT /entries/1
  # PUT /entries/1.xml
  def update
    @entry = Entry.find(params[:id])

    if !@entry.update_attributes(params[:entry]) || params[:preview_button]
      render :action => "edit"
    else
      flash[:notice] = 'Entry was successfully updated.'
      redirect_to(@entry)
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.xml
  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy

    redirect_to(entries_url)
  end
end
