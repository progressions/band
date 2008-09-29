module BloggerStructs
  class Blog < ActionWebService::Struct  
    member :url, :string
    member :blogId, :string
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
end


class BloggerService < ActionWebService::Base
  web_service_api BloggerApi
  
  def getUsersBlogs(appkey, username, password)     
    @user = User.authenticate(username, password)
    unless @user.nil?
      [BloggerStructs::Blog.new(
        :url => 'http://www.worldracketeeringsquad.com/blogs',
        :blogId => 1,
        :blogName => 'WRS Blog'
      )]
    end
  end
  
  def deletePost(appkey, postid, username, password, publish)      
    @user = User.authenticate(username, password)
    unless @user.nil?
      post = Blog.find(postid)
      post.destroy
      true
    end
  end
end