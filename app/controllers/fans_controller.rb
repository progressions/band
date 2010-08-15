require 'faster_csv'

class FansController < ApplicationController
  protect_from_forgery :except => [:new, :create]
  before_filter :load_sidebar, :except => [:create, :update, :destroy, :tag, :new_tag]
  before_filter :login_required, :only => [:index, :import, :manage]
  before_filter :body_style
  before_filter :use_crypted_email, :only => [:show, :update, :edit, :destroy, :unsubscribe]
  before_filter :set_admin
  
  DEFAULT_ZIPCODE = 78701
  
  def update_select 
    fan_list = get_fans(params[:fans])
    
    fans = Fan.find(fan_list)
    @tags = []
    
    fans.each do |fan|
      @tags << fan.tag_list
    end
    @remove_tags = @tags.flatten.uniq
    render :update do |page|      
      page.replace_html 'tag_options', :partial => 'tag_options', :locals => {:remove_tags => @remove_tags}
    end
  end
  
  def check_all
    render :update do |page|
       page.select('#tag_fans input[type=checkbox]').each do |item|
        item.checked = true
      end
    end
  end
  
  def check_none
    render :update do |page|
       page.select('#tag_fans input[type=checkbox]').each do |item|
        item.checked = false
      end
    end
  end
  
  def new_tag
    if params[:tag] == "New tag"
      render :update do |page|
        session[:fans] = params[:fans]
        unless params[:fans].empty?
          page.call("x_add_tag")
          session[:fans] = nil
        end
      end
    else
      render nil, :layout => false
    end
  end
  
  def tag
    fans = get_fans(params[:fans])
    
    if fans.empty?
      return
    else
      if params[:update]
        if params[:tag] == "New tag"
          render :update do |page|
            unless fans.empty?
              page.call("x_add_tag", fans.join("+"))
            end
          end
          return
        else
          if ["Apply tag", "Remove tag", "New tag"].include?(params[:tag])
            return
          else
            process_tag fans, params[:tag]
          end
        end 
      elsif params[:delete]
        Fan.destroy(fans)
      end
      render :update do |page|
        @fans = Fan.paginate :all, :per_page => 25, :page => params[:p], :order => "created_at DESC"
        page.replace_html 'fans_list', :partial => 'fans_list', :locals => {:fans => @fans, :fan_total => Fan.count(:all), :fan_count => @fans.length} 
      end
    end
  end
  
  def add_tag
    fans = get_fans(params[:fans])
  end


  # if user has the crypted email string, they're authorized to 
  # show, edit, destroy, etc, their account.  
  # 
  # if not, they must be logged in.
  #
  def use_crypted_email
    begin
      if params[:f] || login_required
        @fan = Fan.find(:first, :conditions => ["id = ? AND crypted_email = ?", params[:id], params[:f]])  
      end
      if @fan.nil? && login_required
        @fan = Fan.find(params[:id])
      end
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = "Fan not found."
      redirect_to home_path
    end
  end
  
  def body_style
    @body_style = "fans"
  end
  
  # GET /fans
  # GET /fans.xml 
  def index
    @fans = []
    @show_sidebar = false    
    @fan_total = Fan.active.count
    if params[:tag]
      @fans = Fan.active.paginate_tagged_with(params[:tag], :page => params[:p])
    elsif params[:search]
      @fans = Fan.active.search(params[:search], params[:p])
    elsif @fans.empty?
      if params[:sort]
        order_by = params[:sort]
      else
        order_by = "created_at DESC"
      end
      @fans = Fan.active.paginate :all, :per_page => 25, :page => params[:p], :order => order_by
    end
    @fan_count = @fans.length
    if @fans.empty?
      flash[:notice] = "No fans found."
    end
  end
    
  # GET /fans/import
  # POST /fans/import
  def import
    if params[:dump]
      @parsed_file = FasterCSV.parse(params[:dump][:file])
      @n=0
      @parsed_file.each do |row|
        fan = Fan.new(:name => row[0], :email => row[1], :zipcode => DEFAULT_ZIPCODE)
        if fan.save
          @n=@n+1
          GC.start if @n%50==0
        end
      end
      if @n > 0
        flash[:notice] = "CSV Import Successful. #{@n} new fans added."
      else
        flash[:notice] = "CSV Import: No new fans added."
      end
      redirect_to fans_path
    end
  end
  
    
  # GET /fans/export
  # POST /fans/export
  def export
    @fans = Fan.active.find(:all)

    csv_string = FasterCSV.generate do |csv|
      csv << ["Name", "E-mail", "Notes", "Section 1 - Description", "Section 1 - Email", "Section 1 - IM", "Section 1 - Phone", "Section 1 - Mobile", "Section 1 - Pager", "Section 1 - Fax", "Section 1 - Company", "Section 1 - Title", "Section 1 - Other", "Section 1 - Address"]

      for fan in @fans
        csv << [fan.name,
                fan.email,
                "", "", "", "", "", "", "", "", "", "", "",
                fan.address                
                ]
      end
    end

    # filename = @list.name.downcase.gsub(/[^0-9a-z]/, "_") + ".csv"
    filename = "fans.csv"
    send_data(csv_string,
      :type => 'text/csv; charset=utf-8; header=present',
      :filename => filename)
  end

  # GET /fans/1
  # GET /fans/1.xml
  def show
  end

  # GET /fans/new
  # GET /fans/new.xml
  def new
    @fan = Fan.new(:email => params[:email])
  end

  # GET /fans/1/edit
  def edit
  end

  # POST /fans
  # POST /fans.xml
  def create
    @fan = Fan.new(params[:fan])
    
    valid_recaptcha = !@global_settings.use_captcha_for_fans? || (!params[:homepage] && verify_recaptcha(:model => @fan))

    if valid_recaptcha && @fan.save
      Mailer.send_later(:deliver_signup_confirmation, @fan)
      Mailer.send_later(:deliver_signup_report, @fan)
      flash[:registration] = "Thanks for joining the #{@global_settings.artist_name} mailing list, #{@fan.email}.  If you'd like to tell us your name, you can do it here."
      redirect_to edit_fan_path(@fan, :f => @fan.crypted_email)
    else
      if params[:homepage]
        flash[:registration] = "You are almost done signing up for the World Racketeering Squad mailing list. Please fill in the CAPTCHA below to complete your signup."
      end
      render :action => "new"
    end
  end

  # PUT /fans/1
  # PUT /fans/1.xml
  def update
    if @fan.update_attributes(params[:fan])
      flash[:notice] = 'Fan was successfully updated.'
      redirect_to(fan_path(@fan, :f => @fan.crypted_email))
    else
      render :action => "edit"
    end
  end
  
  def unsubscribe
  end

  # DELETE /fans/1
  # DELETE /fans/1.xml
  def destroy
    Mailer.deliver_unsubscribe_report(@fan)
    @fan.deactivate
    flash[:notice] = "#{@fan.email} was successfully unsubscribed."

    if logged_in?
      redirect_to fans_path
    else
      redirect_to home_path
    end
  end
  
  protected
  
  def process_tag fans, tag
    for f in fans
      fan = Fan.find(f)
      
      if tag.match(/^remove /)      
        fan.tag_list.remove(tag.gsub("remove ",""))
      else             
        fan.tag_list.add(tag) unless ["Apply tag", "Remove tag", "New tag"].include?(tag)
      end
      fan.save
    end
  end
  
  def get_fans fans
    if fans && fans.is_a?(Hash)
      fans = fans.keys
    end
    if fans && fans.is_a?(String)
      fans = fans.split("+")
    end
    fans || []
  end
end
