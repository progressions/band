class BlogsController < ApplicationController    
  before_filter :show_blog?
  before_filter :login_required, :except => [:show, :index]

  # GET /blogs
  # GET /blogs.xml
  def index
    @body_style = "home"
    @user = User.find_by_name(params[:author]) if params[:author]
    unless @user.nil?
      @blogs = Blog.paginate :all, :per_page => 10, :page => params[:p], :order => 'created_at DESC', :conditions => ['created_by = ?',@user.id]
    else
      @blogs = Blog.paginate :all, :per_page => 10, :page => params[:p], :order => 'created_at DESC'
    end
  end

  # GET /blogs/1
  # GET /blogs/1.xml
  def show
    @blog = Blog.find(params[:id])
    @subscription = @blog.subscribed(cookies[:email])
    @subscribe = !@subscription.nil?
    @comment = Comment.new(:name => cookies[:name], :email => cookies[:email], :website => cookies[:website])
    @comment.blog = @blog
  end

  # GET /blogs/new
  # GET /blogs/new.xml
  def new
    @blog = Blog.new 
  end

  # GET /blogs/1/edit
  def edit
    @blog = Blog.find(params[:id])
  end

  # POST /blogs
  # POST /blogs.xml
  def create
    @blog = Blog.new(params[:blog])
    @blog.user = current_user
    
    if params[:preview_button] || !@blog.save
      flash[:notice] = "User is valid? #{current_user.valid?}"
      @show_byline = false
      render :action => "new"
    else
      flash[:notice] = 'Blog was successfully created.'
      update_twitter_with_new_content("New blog post: #{blog_url(@blog)}")
      redirect_to(@blog)
    end
  end

  # PUT /blogs/1
  # PUT /blogs/1.xml
  def update
    @blog = Blog.find(params[:id])

    if !@blog.update_attributes(params[:blog]) || params[:preview_button]
      render :action => "edit"
    else
      flash[:notice] = 'Blog was successfully updated.'
      redirect_to(@blog)
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.xml
  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
        flash[:notice] = 'Blog was successfully deleted.'

    respond_to do |format|
      format.html { redirect_to(blogs_url) }
      format.xml  { head :ok }
    end
  end
  
  def unsubscribe
    @blog = Blog.find(params[:id])
    @subscription = @blog.subscribed(params[:email])
    if params[:unsubscribe]
      @blog.unsubscribe(params[:email])
      flash[:notice] = "Successfully unsubscribed from comment notifications."
      redirect_to @blog
    end
  end
  
  private
  
  def show_blog?
    render_404 unless (@global_settings.show_blog? || admin?)
  end
end
