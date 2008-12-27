ActionController::Routing::Routes.draw do |map|
  map.resources :show_reports

  map.resources :styles, :member => {:export => :get},
    :collection => {:import => :post, :import => :get}

  map.resources :songs

  map.resources :songs

  map.resources :web_profiles

  map.resources :pages

  map.resources :members

  map.resources :promos

  map.resources :settings

  map.resources :fans, :collection => {:import => :post, :tag => :post, :import => :get, :export => :get}

  map.resources :venues

  map.resources :shows
  
  map.resources :comments

  map.resources :blogs, :member => {:unsubscribe => :get}

  map.resources :mails, :member => {:deliver => :put, :select => :get}

  map.resources :lyrics

  map.resources :entries

  map.resources :comments
  
  map.resources :sessions
  
  map.resources :users

  map.resources :blogs

  map.resources :fans

  map.resources :songs
  
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  
  map.simple_captcha '/simple_captcha/:action', :controller => 'simple_captcha'
  
  # map.connect 'rcss/:rcssfile.css', :controller => 'rcss', :action => 'rcss', :format => 'css'
  
  map.unsubscribe '/unsubscribe/:id', :controller => 'fans', :action => 'unsubscribe'
       
  map.signup '/register', :controller => 'users', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'new'
  map.login  '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  
  # map.admin '/admin', :controller => 'admin', :action => 'index'
  map.admin '/admin', :controller => 'settings', :action => 'index'
  map.profile '/profile', :controller => 'settings', :action => 'profile'
  map.rss '/rss', :controller => 'about', :action => 'rss'
  map.rss_feed '/rss.:format', :controller => 'about', :action => 'rss', :format => :format
  
  map.music '/music', :controller => 'songs', :action => 'index'
  map.videos '/videos', :controller => 'about', :action => 'videos'
  map.web '/web', :controller => 'about', :action => 'web'
  map.photos '/photos', :controller => 'about', :action => 'photos'
  map.twitter '/twitter', :controller => 'twitter', :action => 'index'
  map.new_twitter '/twitter/new', :controller => 'twitter', :action => 'new', :conditions => {:method => :get}  
  map.new_twitter '/twitter/new', :controller => 'twitter', :action => 'create', :conditions => {:method => :post}
  
  map.news '/news', :controller => 'entries', :action => 'index'
  
  map.about '/about/:id', :controller => 'members', :action => 'show'
  
  map.home '', :controller => 'about', :action => 'index'
  
  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # map.news_api '/news/api', :controller => 'entries', :action => 'wsdl'
  
    # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  map.connect ':controller/service.wsdl', :action => 'wsdl'

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
