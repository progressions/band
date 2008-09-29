# Youtube

require 'open-uri'
require 'rexml/document'
require 'date'

module YouTube
  API_URL = "http://gdata.youtube.com/feeds/api"
  YOUTUBE_URL = "http://www.youtube.com"
  RSS_URL = "/rss/user/USERNAME/videos.rss"
  
  class Base
    attr_reader :tmp
    # protected
          
    # tests the given URL to see if it's got any previous 
    # parameters (search queries, etc).  
    # 
    # if not, the param is appended to the URL with a ?
    # if so, the param is appended with a &
    #
    def add_param_to_url tmp_url, param
      if tmp_url.include?("?")
        tmp_url += "&"
      else
        tmp_url += "?"
      end
      tmp_url += param
      tmp_url
    end
    
    def add_params_to_url tmp_url, params
      @tmp_url = tmp_url
      params.each do |k, v|
        k = k.to_s.sub("_", "-")
        @tmp_url = add_param_to_url(@tmp_url, "#{k}=#{v}") unless v.nil?
      end
      # # puts "OH YEAH: " + @tmp_url
      @tmp_url
    end        
    
    def add_params_from_options tmp_url, options
      tmp_url = add_param_to_url(tmp_url, "orderby=#{options[:orderby]}") if options[:orderby]
      tmp_url = add_param_to_url(tmp_url, "max-results=#{options[:max_results]}") if options[:max_results]
      tmp_url = add_param_to_url(tmp_url, "start-index=#{options[:start_index]}") if options[:start_index]  
      tmp_url = add_params_to_url(tmp_url, {:orderby => options[:orderby], :max_results => options[:max_results], :start_index => options[:start_index]})
      tmp_url
    end
      
    def get_root data_url
      #raise "HEY"
      # puts "URL: #{data_url}"
      open(data_url) do |http|
        response = http.read
        sleep(2)
        @tmp = REXML::Document.new response
      end 
      # puts "TMP:"
      # puts @tmp.elements
      return @tmp     
    end    
  end 
    
   
  # collection of Video objects representing a collection of YouTube videos
  #
  class Videos < Base
    attr_accessor :id, :url, :doc, :videos
    
    def initialize options
      if options[:url] 
        @url = options[:url]
      else
        @id = options[:id].to_s
        @url = "#{API_URL}/#{options[:type]}/#{@id}" if @url.nil?
      end

      @url = add_param_to_url(@url, "orderby=#{options[:orderby]}") if options[:orderby]
      @url = add_param_to_url(@url, "max-results=#{options[:max_results]}") if options[:max_results]
      @url = add_param_to_url(@url, "start-index=#{options[:start_index]}") if options[:start_index]

      @videos = nil
      @doc = nil
      
      # TODO: Videos don't populate until they're requested, with a reference to the "videos" attribute.
      
      # get_videos @url
    end
    
    def videos
      get_videos(@url) if @videos.nil?
      @videos
    end
    
    def doc
      @doc = get_root(@url).root if @doc.nil?
      @doc
    end

    def to_a
      videos
    end
    
    def title
      doc.elements['title'].text
    end
    
    def link
      doc.elements['link'].attributes['href']
    end
    
    def updated
      Time.parse(doc.elements['updated'].text)
    end
    
    def length
      doc.elements["openSearch:totalResults"].text.to_i
    end
    
    def empty?
      length == 0
    end
    
    protected
    
    # loads the results of the videos query into
    # the @videos class attribute.
    #
    def get_videos videos_url
      @videos = [] if @videos.nil?
      doc.elements.each('entry') do |v|
        @videos << Video.new(:video => v)
      end
    end
  end
  
  class Playlist < Videos
    def initialize options
      options[:type] = :playlists
      super options
    end
    
    def url
      "#{YOUTUBE_URL}/p/#{id}"
    end
    
    def link
      "#{YOUTUBE_URL}/view_playlist?p=#{id}"
    end
  end
  
  # http://gdata.youtube.com/feeds/api/videos?author=liz
  # http://gdata.youtube.com/feeds/api/users/liz/uploads
  class User < Videos
    attr_accessor :playlists, :playlists_doc
    
    def initialize options
      @id = options[:id]
      options[:orderby] = :updated unless options[:orderby]
      #@url = "#{API_URL}/videos?author=#{@id}"
      @url = "#{API_URL}/users/#{@id}/uploads"
      @playlists = nil
      options[:url] = @url
      super options
    end
    
    def author
      doc.elements['author'].elements['name'].text
    end
    
    def name
      author
    end
    
    def uri      
      doc.elements['author'].elements['uri'].text
    end
    
    def email
      uri
    end
    
    def title
      doc.elements['title'].text
    end
    
    def link
      "#{YOUTUBE_URL}/#{@id}"
    end
    
    # http://gdata.youtube.com/feeds/api/users/liz/favorites
    def favorites options={}
      options[:id] = @id
      Favorites.new(options)
    end
    
    def playlists
      get_playlists if @playlists.nil?
      @playlists
    end
    
    protected
    
    # loads the results of the playlists query into
    # the @playlists class attribute.
    #
    # http://gdata.youtube.com/feeds/api/users/worldracketeer/playlists
    def get_playlists
      playlists_url = "#{API_URL}/users/#{id}/playlists"
      # puts "GETTING PLAYLISTS"
      @playlists ||= []
      @playlists_doc = get_root(playlists_url)
      # # puts @playlists_doc.inspect
      @playlists_doc.elements.each('entry') do |v|
        playlist_url = v.elements['id']
        @playlists << Playlist.new(:url => playlist_url)
      end
    end
  end
  
  class Favorites < Videos
    def initialize options
      options[:url] = "#{API_URL}/users/#{options[:id]}/favorites"
      super(options)
    end
  end
  
  class StandardFeeds < Videos
    def initialize options={}
      options[:type] = :standardfeeds
      super(options)
    end
  end
  
  # http://gdata.youtube.com/feeds/api/standardfeeds/top_rated
  
  class TopRated < StandardFeeds
    def initialize options={}
      options[:id] = :top_rated
      super(options)
    end
  end
  
  class TopFavorites < StandardFeeds
    def initialize options={}
      options[:id] = :top_favorites
      super(options)
    end
  end
  
  class MostViewed < StandardFeeds
    def initialize options={}
      options[:id] = :most_viewed
      super(options)
    end
  end
  
  class MostDiscussed < StandardFeeds
    def initialize options={}
      options[:id] = :most_discussed
      super(options)
    end
  end
  
  class MostLinked < StandardFeeds
    def initialize options={}
      options[:id] = :most_linked
      super(options)
    end
  end
  
  class MostResponded < StandardFeeds
    def initialize options={}
      options[:id] = :most_responded
      super(options)
    end
  end
  
  class RecentlyFeatured < StandardFeeds
    def initialize options={}
      options[:id] = :recently_featured
      super(options)
    end
  end
  
  class WatchOnMobile < StandardFeeds
    def initialize options={}
      options[:id] = :watch_on_mobile
      super(options)
    end
  end
  
  class Author
    attr_accessor :name, :full_name, :email
    def initialize video
      @name = video.elements['author'].elements['name'].text
      @email = video.elements['author'].elements['uri'].text
    end
    
    def full_name
      @name
    end
  end
    
  
  class Video < Base
    attr_accessor :video, :user, :video_id, :id
    
    def initialize options
      @video = nil
      if options[:video]
        #raise "OMG"
        @video = options[:video]
      elsif options[:url] 
        @url = options[:url]
      else
        @video_id = options[:id].to_s
        # http://gdata.youtube.com/feeds/api/videos/03YbknYlJK0
        @url = "#{API_URL}/videos/#{@video_id}" if @url.nil?
      end
      
      if @video.nil?
        @url = add_params_from_options(@url, options)
        get_video @url
      end
      @user = Author.new(@video)
    end
    
    def link
      @video.elements['media:group'].elements['media:player'].attributes['url']
    end
    
    def title
      @video.elements['title'].text
    end
    
    def body
      string = <<END_STRING
<object width="425" height="355"><param name="movie" value="#{url}"></param><param name="wmode" value="transparent"></param><embed src="#{url}" type="application/x-shockwave-flash" wmode="transparent" width="425" height="355"></embed></object>
END_STRING
    end
    
    def feed_id
      @video.elements['id'].text
    end
    
    def url
      @video.elements['media:group'].elements['media:content'].attributes['url']
    end
    
    def created_at
      published
    end
    
    def published
      if @video.elements['published']
        Time.parse(@video.elements['published'].text)
      else
        nil
      end
    end
    
    def updated_at
      updated
    end
    
    def updated
      Time.parse(@video.elements['updated'].text)
    end
    
    def views
      if @video.elements['yt:statistics']
        @video.elements['yt:statistics'].attributes['viewCount']
      else
        0
      end
    end
    
    protected 
    # loads the results of the videos query into
    # the @videos class attribute.
    #
    def get_video videos_url 
      @doc = get_root videos_url
      
      @video = @doc.elements['entry']
    end
  end
end

     

