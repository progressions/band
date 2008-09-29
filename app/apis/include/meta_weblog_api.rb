module MetaWeblogStructs
  class Post < ActionWebService::Struct
    member :postid, :string
    member :title, :string
    member :link, :string
    member :dateCreated, :time
    member :description, :string
    member :categories, [:string]
  end
end

class MetaWeblogApi < ActionWebService::API::Base
  inflect_names false
  
  api_method :getCategories,
    :expects => [{:blogid => :string},
      {:username => :string},
      {:password => :string}],
    :returns => [[:string]]
    
  api_method :newPost,
    :expects => [
      {:blogid => :string},
      {:username => :string},
      {:password => :string},
      {:content => MetaWeblogStructs::Post},
      {:publish => :bool}
      ],
    :returns => [:string]
    
    api_method :getPost,
      :expects => [{:postid => :string}, 
        {:username => :string},
        {:password => :string}],
      :returns => [MetaWeblogStructs::Post]
      
    api_method :getRecentPosts,
      :expects => [{:blogid => :string},
        {:username => :string},
        {:password => :string},
        {:numberOfPosts => :int}],
      :returns => [[MetaWeblogStructs::Post]]
      
    api_method :editPost,
      :expects => [{:postid => :string},
        {:struct => MetaWeblogStructs::Post},
        {:publish => :int}],
      :returns => [:bool]
end

def buildPost(post)
  MetaWeblogStructs::Post.new(
    :dateCreated => post.created_at || '',
    :postid => post.id.to_s,
    :description => post.body,
    :title => post.title
  )
end