class CommentsController < ApplicationController  
  layout :admin_or_user_layout
  
  # GET /comments
  # GET /comments.xml
  def index
    @comments = Comment.find(:all)

    respond_to do |format|
      format.html { render_404 }
      format.rss  { render :rss => @comments }
    end
  end


=begin
  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end
=end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    @page_title = "New Comment"
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
    @blog = @comment.blog
  end
  
  # POST /comments
  # POST /comments.xml
  def create
    @blog = Blog.find(params[:blog])
    @comment = Comment.new(params[:comment])
    @new_comment = Comment.new

    valid_recaptcha = verify_recaptcha(:model => @comment)
    
    if params[:preview_button] || !valid_recaptcha || !@comment.save
      @preview_comment = @comment
      if !params[:preview_button] && !valid_recaptcha
        @comment.errors.add_to_base("You must enter the code in the image.")
      end
      render :action => "new"
    else
      @blog.comments << @comment
      cookies[:name] = { :value => @comment.name, :expires => 1.year.from_now }
      cookies[:email] = { :value => @comment.email, :expires => 1.year.from_now }
      cookies[:website] = { :value => @comment.website, :expires => 1.year.from_now }
       
      for subscription in @blog.subscriptions
        Mailer.deliver_comment_subscription(subscription.email, @blog, @comment)
      end
      
      if params[:subscribe] == "1"
        @subscription = @blog.subscribe(@comment.email)
      else
        @blog.unsubscribe(@comment.email)
      end
      
      Mailer.deliver_comment_notification(@blog.user, @blog, @comment)
      flash[:notice] = 'Comment was successfully created.'
      redirect_to(@blog)
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @comment = Comment.find(params[:id])
    @blog = @comment.blog

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = 'Comment was successfully updated.'
        format.html { redirect_to(@comment.blog, :method => :get) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    blog = @comment.blog
    @comment.destroy
    flash[:notice] = "Comment was successfully deleted."

    respond_to do |format|
      format.html { redirect_to(blog, :method => :get) }
      format.xml  { head :ok }
    end
  end
end
