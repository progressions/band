class MailsController < ApplicationController
  before_filter :login_required
  before_filter :can_send_mail?
  
  FANS_OPTIONS = ["Everywhere", "In a specific city", "In a specific state", "In a specific postal code", "With specific tags"]
  
  # GET /mails
  # GET /mails.xml
  def index
    @mails = Mail.paginate :all, :per_page => 20, :page => params[:p], :order => 'created_at DESC'
  end

  # GET /mails/1
  # GET /mails/1.xml
  def show
    @mail = Mail.find(params[:id])
  end
    
  # GET /mails/1/select
  # 
  def select    
    @fans_options = FANS_OPTIONS
    @mail = Mail.find(params[:id])
  end
  
  def update_fan_count
    if params[:fans_by_zipcode]
      zipcode = params[:fans_by_zipcode][:zipcode]      
      zipcode ||= params[:fans_by_zipcode]
      @fans = Fan.find_all_by_zipcode(zipcode.to_i)
    end
    if params[:fans_by_city]
      city = params[:fans_by_city][:city]
      city ||= params[:fans_by_city]
      @fans = Fan.find_all_by_city(city)
    end
    if params[:fans_by_state]
      state = params[:fans_by_state][:state]
      state ||= params[:fans_by_state]
      @fans = Fan.find_all_by_state(state)
    end
    if params[:fans_by_tags]
      tags = params[:fans_by_tags]
      @fans = Fan.find_tagged(tags)
    end
    @fans = Fan.find(:all) if @fans.nil?
    render :update do |page|
      page.replace_html 'fan_count', :partial => 'fan_count', :locals => {:fan_count => @fans.length}
    end
  end
  
  # PUT /mails/1/deliver
  #
  def deliver
    @fans_options = FANS_OPTIONS
    @mail = Mail.find(params[:id])
    if params[:deliver_button]
      if params[:fans_by_zipcode]
        zipcode = params[:fans_by_zipcode][:zipcode]      
        @fans = Fan.find_all_by_zipcode(zipcode.to_i)
      end
      if params[:fans_by_city]
        city = params[:fans_by_city][:city]
        @fans = Fan.find_all_by_city(city)
      end
      if params[:fans_by_state]
        state = params[:fans_by_state][:state]
        @fans = Fan.find_all_by_state(state)
      end
      if params[:fans_by_tags]
        tags = params[:fans_by_tags]
        @fans = Fan.find_tagged(tags)
      end
      @fans = Fan.find(:all) if @fans.nil?
      
      @fans.each do |f|
        logger.info("SENDING MAIL TO DELAYED_JOBS FOR #{f.email}")
        Mailer.send_later(:deliver_mail, f, @mail)
      end
      @mail.sent_at = Time.now
      @mail.save
      flash[:notice] = "Mail was successfully delivered to #{@fans.length} fans."
      redirect_to mails_path
    end
  end
  
  def select_fans_options    
    @thingy = params[:select_fans]
    if @thingy == FANS_OPTIONS[0]  # "Everywhere"
      render :update do |page|
        page.replace_html 'select_options', ""
      page.replace_html 'fan_count', :partial => 'fan_count', :locals => {:fan_count => Fan.count}
      end
      return
    elsif @thingy == FANS_OPTIONS[1]  # "In a specific city"
      @partial_name = "select_by_city"      
    elsif @thingy == FANS_OPTIONS[2]  # "In a specific state"
      @partial_name = "select_by_state"
    elsif @thingy == FANS_OPTIONS[3]  # "In a specific postal code"
      @partial_name = "select_by_postal"
    elsif @thingy == FANS_OPTIONS[4]  # "In a specific postal code"
      @partial_name = "select_by_tag"
    end
    render :update do |page|
      page.replace_html 'select_options', :partial => @partial_name, :object => @thingy
    end
  end

  # GET /mails/new
  # GET /mails/new.xml
  def new
    @mail = Mail.new
  end

  # GET /mails/1/edit
  def edit
    @mail = Mail.find(params[:id])
  end

  # POST /mails
  # POST /mails.xml
  def create
    @mail = Mail.new(params[:mail])
    @mail.user = current_user
    
    if params[:preview_button] || !@mail.save
      render :action => "new"
    else
      flash[:notice] = 'Mail was successfully created.'
      redirect_to(@mail)
    end
  end

  # PUT /mails/1
  # PUT /mails/1.xml
  def update
    @mail = Mail.find(params[:id])    
    if !@mail.update_attributes(params[:mail]) || params[:preview_button]
      
      render :action => "edit"
    else
      flash[:notice] = 'Mail was successfully updated.'
      redirect_to(@mail)
    end
  end

  # DELETE /mails/1
  # DELETE /mails/1.xml
  def destroy
    @mail = Mail.find(params[:id])
    @mail.destroy

    respond_to do |format|
      format.html { redirect_to(mails_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def can_send_mail?
    unless @global_settings.can_send_mail?
      flash[:notice] = "You must have a valid email address and website URL to send mail."
      redirect_to profile_url
    end
  end
end
