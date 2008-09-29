module BloggerStructs
  class Blog < ActionWebService::Struct  
    member :url, :string
    member :blogid, :string
    member :blogName, :string
  end
end


class BloggerApi < ActionWebService::API::Base
  inflect_names false
  
  api_method :getUsersBlogs,
    :expects => [{:appkey => :string}, {:username => :string},
      {:password => :string}],
    :returns => [[BloggerStructs::Blog]]
    
  api_method :deletePost,
    :expects => [{:appkey => :string},
      {:postid => :string},
      {:username => :string},
      {:password => :string},
      {:publish => :int}],
    :returns => [:bool]
endclass BloggerAPI < ActionWebService::API::Base
  inflect_names false
  
  api_method :getUsersBlogs,
    :expects => [ {:appkey => :string}, {:username => :string},
      {:password => :string}],
    :returns => [[BloggerStructs::Blog]]
    
  api_method :getUserInfo,
    :expects => [{:appkey => :string}, {:username => :string},
      {:password => :string}],
    :returns => [BloggerStructs::User]
    
  api_method :getPost,
    :expects => [{:appkey => :string}, {:postid => :string},
      {:username => :string}, {:password => :string}],
    :returns => [BloggerStructs::Post]
    
  api_method :getRecentPosts,
    :expects => [{:appkey => :string}, {:blogid => :string},
      {:username => :string}, {:password => :string},
      {:numberOfPosts => :integer}],
    :returns => [[BloggerStructs::Post]]
    
  api_method :newPost,
    :expects => [{:appkey => :string}, {:blogid => :string},
      {:username => :string}, {:password => :string},
      {:content => :string}, {:published => :boolean}],
    :returns => [:int]
    
  api_method :editPost,
    :expects => [{:appkey => :string}, {:postid => :string},
      {:username => :string}, {:password => :string},
      {:content => :string}, {:published => :boolean}],
    :returns => [:boolean]
end