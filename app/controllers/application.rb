# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

# TODO: Merchandise page/online store
# TODO: Downloadable promo materials--images, wallpapers, &c
# TODO: Online promo stuff: links, banners, &c

class ApplicationController < ActionController::Base
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  before_filter :global_settings
  before_filter :new_fan
  before_filter :load_sidebar
  
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '09ac6893ab583a94fe3e627c92898db0'
  
  
  def global_settings
    @global_settings = Setting.find_or_create_by_id(:id => 1)
    @site_name = @global_settings.site_name
  end
  
  def new_fan
    @fan = Fan.new
  end
  
  def load_sidebar 
    @members = Member.find(:all, :conditions => ["active = ?", true], :limit => 5, :order => 'name')
    @blogs = Blog.paginate :all, :per_page => 5, :page => params[:p], :order => 'created_at DESC' 
    @shows = Show.find(:all, :limit => 3, :order => 'date', :conditions => ["date > ?", Time.now])
  end
  
  def render_404
    render :file => "#{RAILS_ROOT}/public/404.html", :status => 404
  end
  
  def admin_or_user
    logged_in? && params[:admin]=="true" ? "settings" : "application"
  end
  
  def set_admin
    params[:admin] = true
  end
end
