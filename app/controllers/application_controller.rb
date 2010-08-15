# TODO: Merchandise page/online store
# TODO: Downloadable promo materials--images, wallpapers, &c
# TODO: Online promo stuff: links, banners, &c

class ApplicationController < ActionController::Base
  
  before_filter :global_settings
  
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  before_filter :new_fan
  before_filter :load_sidebar
  
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '09ac6893ab583a94fe3e627c92898db0'
  
  
  def global_settings
    @global_settings = Setting.first || Setting.create
    @site_name = @global_settings.site_name
  end
  
  def new_fan
    @fan = Fan.new
  end
  
  def load_sidebar
    if show_sidebar?
      @members = Member.find(:all, :conditions => ["active = ?", true], :limit => 5, :order => 'name') || []
      @blogs = Blog.paginate :all, :per_page => 5, :page => params[:p], :order => 'created_at DESC' || []
      @shows = Show.find(:all, :limit => 3, :order => 'date', :conditions => ["date > ?", Time.now]) || []
      @songs = Song.find_all_with_file || []
    end  
  end
  
  def render_404
    render :file => "#{RAILS_ROOT}/public/404.html", :status => 404
  end
  
  def admin_or_user_layout
    logged_in? && admin? ? "settings" : "application"
  end
  
  def show_sidebar?
    !admin?
  end
  
  def admin?
    logged_in? && params[:admin]
  end
  
  def set_admin
    params[:admin] = true
  end
  
	def twitter_profile_url
	  "http://www.twitter.com/#{@global_settings.twitter_profile}"
  end
  
  def twitter_user
    twitter.user(@global_settings.twitter_profile)
  end
  # memoize :twitter_user
	
	def twitter
	  httpauth = Twitter::HTTPAuth.new(@global_settings.twitter_profile, @global_settings.twitter_password)
    Twitter::Base.new(httpauth)
  end
  # memoize :twitter
  
  def twitter_feed(count=MAX_TWITTER_COUNT)
    if @global_settings.show_twitter?
      TwitterWorker.user_timeline(@global_settings.twitter_profile).first(5)
    end
  rescue
    @twitter_error = true
    []
  end
  
  def user_timeline_url(username)
    "http://twitter.com/statuses/user_timeline.json?screen_name=#{username}"
  end
  
  def update_twitter(update)
    twitter.update(update)
  end
  
  def update_twitter_with_new_content(update)
    if @global_settings.tweet_updates? && Rails.env.production?
      update_twitter(update)
    end
  end
  
  def convert_to_html(text)
    text.gsub("&lt;", "<")
    text.gsub("&gt;", ">")
    text.gsub("&quot;", '"')
  end
  
  def facebook_cookie
    # @raw_facebook_cookie = cookies["fbs_#{FACEBOOK['api_key']}"]
    # 
    # if @raw_facebook_cookie
    #   @raw_facebook_cookie.gsub!(/^#{34.chr}/, "")
    #   @raw_facebook_cookie.gsub!(/#{34.chr}$/, "")
    #   @cookie = {}
    #   @raw_facebook_cookie.split("&").each do |arg|
    #     key, value = arg.split("=")
    #     @cookie[key] = value
    #   end
    # 
    #   @payload = ""
    #   @cookie.keys.sort.each do |key|
    #     unless key == "sig"
    #       @payload += key + "=" + @cookie[key]
    #     end
    #   end
    #   
    #   @digest = Digest::MD5.hexdigest(@payload + FACEBOOK["application_secret"])
    # 
    #   if @digest != @cookie["sig"]
    #     @cookie = nil
    #   end
    # end
    # @cookie
  end
end
