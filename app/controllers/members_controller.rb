class MembersController < ApplicationController
  before_filter :set_admin, :except => [:index, :show]
  before_filter :login_required, :except => [:index, :show]
  
  # TODO: Add index to members, sort by index number?
  
  # GET /members
  # GET /members.xml
  def index
    @members = Member.find(:all)
  end

  # GET /members/isaac
  # GET /members/isaac.xml
  #  - or -
  # GET /members/1
  # GET /members/1.xml  
  def show
    @member = Member.find_by_url(params[:id])
    @member = Member.find_by_url_or_id(params[:id]) if @member.nil?
  end

  # GET /members/new
  # GET /members/new.xml
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
    @member = Member.find_by_url_or_id(params[:id])
  end

  # POST /members
  # POST /members.xml
  def create
    @member = Member.new(params[:member])

    if @member.save
      flash[:notice] = 'Member was successfully created.'
      redirect_to about_path(@member.url)
    else
      render :action => "new"
    end
  end

  # PUT /members/1
  # PUT /members/1.xml
  def update
    @member = Member.find_by_url_or_id(params[:id])

    if @member.update_attributes(params[:member])
      flash[:notice] = 'Member was successfully updated.'
      redirect_to about_path(@member.url)
    else
      render :action => "edit" 
    end
  end

  # DELETE /members/1
  # DELETE /members/1.xml
  def destroy
    @member = Member.find_by_url_or_id(params[:id])
    @member.destroy

    redirect_to(members_url)
  end
end
