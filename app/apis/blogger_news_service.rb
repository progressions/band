module BloggerStructs
  class Blog < ActionWebService::Struct  
    member :url, :string
    member :blogId, :string
    member :blogName, :string
  end
end


class BloggerNewsApi < ActionWebService::API::Base
  inflect_names false
  
  api_method :getUsersBlogs,
    :expects => [{:appkey => :string}, {:username => :string},
      {:password => :string}],
    :returns => [[BloggerStructs::Blog]]
    
  api_method :deletePost,
    :expects => [{:appkey => :string},
      {:postId => :string},
      {:username => :string},
      {:password => :string},
      {:publish => :int}],
    :returns => [:bool]
end

class BloggerNewsService < ActionWebService::Base
  web_service_api BloggerNewsApi
  
  def getUsersBlogs(appkey, username, password)
    @user = User.authenticate(username, password)
    unless @user.nil?
      [BloggerStructs::Blog.new(
        :url => 'http://www.worldracketeeringsquad.com/news',
        :blogId => 1,
        :blogName => 'WRS News'
      )]
    end
  end
  
  def deletePost(appkey, postid, username, password, publish)      
    @user = User.authenticate(username, password)
    unless @user.nil?
      post = Entry.find(postid)
      post.destroy
      true
    end
  end
end